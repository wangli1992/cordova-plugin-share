#import "MMShare.h"
#import <Cordova/CDV.h>

@implementation MMShare

- (void)share:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult = nil;
    NSString* text = [command.arguments objectAtIndex:0];

    if (text != nil && [text length] > 0) {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
          NSString *textToShare = @"入校预约";
         NSURL *urlToShare = [NSURL URLWithString:text];
        NSArray* dataToShare = @[textToShare,urlToShare];  // ...or whatever pieces of data you want to share.
        
        UIActivityViewController* activityViewController =
        [[UIActivityViewController alloc] initWithActivityItems:dataToShare
                                          applicationActivities:nil];
                                          
        //  activityViewController.excludedActivityTypes = @[UIActivityTypeAssignToContact,
        //                                  UIActivityTypePrint];
          activityViewController.excludedActivityTypes = @[UIActivityTypeMail,UIActivityTypePostToTwitter,UIActivityTypePrint,UIActivityTypeCopyToPasteboard,UIActivityTypeAssignToContact,UIActivityTypeAddToReadingList,UIActivityTypePostToFlickr,UIActivityTypePostToVimeo,UIActivityTypePostToTencentWeibo,UIActivityTypeAirDrop,UIActivityTypeOpenInIBooks];
        // fix crash on iOS8
        if (IsAtLeastiOSVersion(@"8.0")) {
           // activityViewController.popoverPresentationController.sourceView = self.webView;
        }
    //     activityViewController.completionWithItemsHandler = ^(NSString *activityType,BOOL completed,NSArray *returnedItems,NSError *activityError)
    // {
    //     if (completed) { // 确定分享
    //          NSLog(@"completed succeed");
    //          [self.viewController dismissModalViewControllerAnimated:YES];
    //     }
    //     else {
    //          NSLog(@"completed failure");
    //     }
    // };
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        [self.viewController presentViewController:activityViewController animated:YES completion:^{}];
    } else {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
         [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }
    
   
}

@end