//
//  ViewController.swift
//  BallRoll
//
//  Created by TTung on 2/17/17.
//  Copyright © 2017 TTung. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    var ball = UIImageView()
    var radians = CGFloat()
    var ballRadious: CGFloat = 32.0
    var mainViewSize = CGSize()
    var direction:CGFloat = 1
    var deltaAngle: CGFloat = 0.1
    var right:Bool = true
    var time:Timer!
   
 
    override func viewDidLoad() {
        super.viewDidLoad()
        addBall()
        time = Timer.scheduledTimer(timeInterval: 0.02, target: self, selector: #selector(rollBall), userInfo: nil, repeats: true)
    }

    func addBall(){
        
         mainViewSize = self.view.bounds.size
        
        ball = UIImageView(image: UIImage(named: "ball.png"))
        ball.center =  CGPoint(x: ballRadious, y: (mainViewSize.height * 0.5))
        self.view.addSubview(ball)
    }
    
    
    func rollBallLeftToRight(){
        
        deltaAngle = 0.1
        radians = radians + deltaAngle
        let rotate = CGAffineTransform(rotationAngle: radians)
        ball.transform = rotate
       
        self.ball.center = CGPoint(x: self.ball.center.x + ballRadious * deltaAngle , y: self.ball.center.y + ballRadious * deltaAngle * direction)
        
        if ball.center.x > mainViewSize.width - ballRadious {
            deltaAngle = -0.1
            right = false
        }
    }
    
    func rollBallRightToLeft()  {
        deltaAngle = -0.1
        radians = radians + deltaAngle
        let rotate = CGAffineTransform(rotationAngle: radians)
        ball.transform = rotate
        
        self.ball.center = CGPoint(x: self.ball.center.x + ballRadious * deltaAngle , y: self.ball.center.y - ballRadious*deltaAngle*direction)
        
        if ball.center.x < ballRadious {
            deltaAngle = 0.1
            right = true
        }
        
    }
    
    func changeDirectoin(){
        
        let dic = randomDirect()
        
        if ball.center.y > mainViewSize.height - ballRadious {
            direction = -dic
        }
        else if ball.center.y < ballRadious {
            direction = dic
        }
    }
    
    func rollBall(){
        if right == true {
            changeDirectoin()
            rollBallLeftToRight()
        }else {
            changeDirectoin()
            rollBallRightToLeft()
        }
    }
    
    func randomDirect() -> CGFloat {
        return CGFloat(Float(arc4random()) / Float(UINT32_MAX))
    }
    
    
}
