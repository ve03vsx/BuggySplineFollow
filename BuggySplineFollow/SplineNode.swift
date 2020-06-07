//
//  SplineNode.swift
//  snake2.0
//
//  Created by Daniel Hall on 07/06/2020.
//  Copyright © 2020 KwaKwaStudios. All rights reserved.
//

import SpriteKit

class SplineNode: SKNode  {
    
    var splinePoints: [CGPoint] = [.zero, .zero, .zero, .zero, .zero]

    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        getPoints()
        makeShape()
    }
    
    private func getPoints() {
        for node in children {
            node.removeFromParent()
            switch node.name {
            case "splinePoint1":
                splinePoints[0] = node.position
                print(splinePoints[0])
            case "splinePoint2":
                splinePoints[1] = node.position
            case "splinePoint3":
                splinePoints[2] = node.position
            case "splinePoint4":
                splinePoints[3] = node.position
            case "splinePoint5":
                splinePoints[4] = node.position
            default:
                fatalError("SplineNode: Undefined spline point")
            }
        }
    }
    
    private func makeShape() {
        let splineShape = SKShapeNode(splinePoints: &splinePoints, count: splinePoints.count)
        //let splineShape = SKShapeNode(points: &splinePoints, count: splinePoints.count)
        splineShape.lineWidth = 3
        splineShape.strokeColor = .red
        splineShape.zPosition = 100
        addChild(splineShape)
        let myBall = SKSpriteNode(texture: SKTexture(imageNamed: "circle"), color: .orange, size: CGSize(width: 30, height: 30))
        myBall.colorBlendFactor = 1
        let boundBox = SKShapeNode(rect: splineShape.path!.boundingBox)
        boundBox.lineWidth = 3
        boundBox.strokeColor = .red
        addChild(boundBox)
        myBall.position = splinePoints[0]
        addChild(myBall)
        print(myBall.position)
        let followAction1 = SKAction.follow(splineShape.path!, speed: 100)
        let followAction2 = SKAction.follow(splineShape.path!, asOffset: false, orientToPath: true, speed: 200)
        let followAction3 = SKAction.follow((splineShape.path)!, asOffset: false, orientToPath: true, speed: 100)
        let followAction4 = SKAction.follow(splineShape.path!, asOffset: false, orientToPath: true, duration: 8)
        let action = SKAction.repeatForever(followAction2)
        myBall.run(action)
    }
    
    public func update() {
        
    }
    
    public func updateDidEnd() {
        
    }
    
    deinit {
        
    }

}
