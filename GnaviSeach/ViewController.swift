//
//  ViewController.swift
//  GnaviSeach
//
//  Created by 原啓介 on 2017/01/18.
//  Copyright © 2017年 mycompany. All rights reserved.
//

import UIKit
import SwiftyJSON

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        getJSON()
    }
    //JSONを取得するメソッド
    func getJSON(){
        //APIのURLを定義する
        let url = NSURL(string: "http://geoapi.heartrails.com/api/json?method=getAreas")!
          //URLSessionで通信を行う
        let task = URLSession.shared.dataTask(with: url as URL) { (data, response, error) in
          //dataの中に値が入っているかのチェック
            if let urlContent = data {
                do{
                    //NSDictionary形式にキャスト
                    let jsonResult:NSDictionary = try JSONSerialization.jsonObject(with: urlContent, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                    
                    if jsonResult.count > 0{
                        //responseを取り出し、それもNSDictionaryにキャスト
                        if let response = jsonResult["response"] as? NSDictionary {
                            //responseからareaを取り出しNSArryにキャスト
                            if let areas = response["area"] as? NSArray{
                                //areaの数だけループさせ地域名を取り出し出力させる
                                for area in areas {
                                    if let name = area as? String {
                                        print(name)
                                    }
                                }
                            }
                        }
                    }
                }catch{
                    print("JSON serialization failed")
                }
            }
            
            
        }
        task.resume()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

