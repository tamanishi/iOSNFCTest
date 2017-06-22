//
//  ViewController.swift
//  iOSNFCTest
//
//  Created by msyksnhr on 2017/06/17.
//  Copyright © 2017 tamanishi. All rights reserved.
//

import UIKit
import CoreNFC

class ViewController: UIViewController, NFCNDEFReaderSessionDelegate {
    
    @IBOutlet weak var payloadLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        payloadLabel.text = nil
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func startScanning(_ sender: Any) {
        let session:NFCNDEFReaderSession = NFCNDEFReaderSession(delegate: self, queue: nil, invalidateAfterFirstRead: false)
        session.begin()
        print("Session started")
        payloadLabel.text = nil
    }
    
    func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {
        print("Error: \(error.localizedDescription)")
        let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
        var payloadString: String = String()
        for message in messages {
            for payload in message.records {
                payloadString += String(describing: payload.payload)
            }
        }
        payloadLabel.text = payloadString
    }
    
}

