Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A95865E5C3
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 07:59:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbjAEG7M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 01:59:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbjAEG7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 01:59:10 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED424FD46;
        Wed,  4 Jan 2023 22:59:08 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 26C3E49C;
        Thu,  5 Jan 2023 07:59:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1672901947;
        bh=a1y2MnZ8BtSQABIRJaYV5hZ8DUr29N4x6bx0/QOiisU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sicm1O4vsvvHtTzamXq4pbOFZv22ZaQQevQ/uGdcvDx1YWidUrwFexIAB6zqsuhP3
         GMw0YYKU7esUQxxAXrOobtNT/6omfhCKuQfoQhbZ8F6PdRxwlWyA3Tu5/GycuULY6T
         hzpd0wiBpFPhHI2FdU54hzOlkH8PHtLjw7VaTW4c=
Date:   Thu, 5 Jan 2023 08:59:03 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     =?utf-8?B?6Im+6LaF?= <aichao@kylinos.cn>
Cc:     mchehab@kernel.org, ribalda@chromium.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH v4] media: uvcvideo: Fix bandwidth error for Alcor
 camera
Message-ID: <Y7Z1N6Vl5sYMKhAI@pendragon.ideasonboard.com>
References: <27w7prk59ed-27wbjl0eevq@nsmail7.0.0--kylin--1>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <27w7prk59ed-27wbjl0eevq@nsmail7.0.0--kylin--1>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Helo,

On Thu, Jan 05, 2023 at 01:45:07PM +0800, 艾超 wrote:
> Dear Pinchart:
> 
> This issue limited to MJPEG, and it is not used YUYV. 

Thank you for the confirmation.

The descriptors have been messed up with by HTML formatting. Could you
please resend them an an attachment ?

lsusb -v -d 2017:0011 > alcor-0011.usb

and attach the alcor-0011.usb file to the e-mail.

> Bus 001 Device 007: ID 2017:0011 Alcor Corp. Slave camera
> Device Descriptor:
> bLength 18
> bDescriptorType 1
> bcdUSB 2.00
> bDeviceClass 239 Miscellaneous Device
> bDeviceSubClass 2
> bDeviceProtocol 1 Interface Association
> bMaxPacketSize0 64
> idVendor 0x2017
> idProduct 0x0011
> bcdDevice 1.02
> iManufacturer 1 Alcor Corp.
> iProduct 2 Slave camera
> iSerial 0
> bNumConfigurations 1
> Configuration Descriptor:
> bLength 9
> bDescriptorType 2
> wTotalLength 0x02ad
> bNumInterfaces 2
> bConfigurationValue 1
> iConfiguration 0
> bmAttributes 0x80
> (Bus Powered)
> MaxPower 200mA
> Interface Association:
> bLength 8
> bDescriptorType 11
> bFirstInterface 0
> bInterfaceCount 2
> bFunctionClass 14 Video
> bFunctionSubClass 3 Video Interface Collection
> bFunctionProtocol 0
> iFunction 4 Slave camera
> Interface Descriptor:
> bLength 9
> bDescriptorType 4
> bInterfaceNumber 0
> bAlternateSetting 0
> bNumEndpoints 1
> bInterfaceClass 14 Video
> bInterfaceSubClass 1 Video Control
> bInterfaceProtocol 0
> iInterface 4 Slave camera
> VideoControl Interface Descriptor:
> bLength 13
> bDescriptorType 36
> bDescriptorSubtype 1 (HEADER)
> bcdUVC 1.00
> wTotalLength 0x004f
> dwClockFrequency 30.000000MHz
> bInCollection 1
> baInterfaceNr( 0) 1
> VideoControl Interface Descriptor:
> bLength 28
> bDescriptorType 36
> bDescriptorSubtype 6 (EXTENSION_UNIT)
> bUnitID 6
> guidExtensionCode {68bbd0b0-61a4-4b83-90b7-a6215f3c4f70}
> bNumControl 24
> bNrPins 1
> baSourceID( 0) 2
> bControlSize 3
> bmControls( 0) 0xff
> bmControls( 1) 0xff
> bmControls( 2) 0xff
> iExtension 0
> VideoControl Interface Descriptor:
> bLength 18
> bDescriptorType 36
> bDescriptorSubtype 2 (INPUT_TERMINAL)
> bTerminalID 1
> wTerminalType 0x0201 Camera Sensor
> bAssocTerminal 0
> iTerminal 0
> wObjectiveFocalLengthMin 0
> wObjectiveFocalLengthMax 0
> wOcularFocalLength 0
> bControlSize 3
> bmControls 0x0000000e
> Auto-Exposure Mode
> Auto-Exposure Priority
> Exposure Time (Absolute)
> VideoControl Interface Descriptor:
> bLength 11
> bDescriptorType 36
> bDescriptorSubtype 5 (PROCESSING_UNIT)
> Warning: Descriptor too short
> bUnitID 2
> bSourceID 1
> wMaxMultiplier 0
> bControlSize 2
> bmControls 0x0000177f
> Brightness
> Contrast
> Hue
> Saturation
> Sharpness
> Gamma
> White Balance Temperature
> Backlight Compensation
> Gain
> Power Line Frequency
> White Balance Temperature, Auto
> iProcessing 0
> bmVideoStandards 0x09
> None
> SECAM - 625/50
> VideoControl Interface Descriptor:
> bLength 9
> bDescriptorType 36
> bDescriptorSubtype 3 (OUTPUT_TERMINAL)
> bTerminalID 3
> wTerminalType 0x0101 USB Streaming
> bAssocTerminal 0
> bSourceID 2
> iTerminal 0
> Endpoint Descriptor:
> bLength 7
> bDescriptorType 5
> bEndpointAddress 0x81 EP 1 IN
> bmAttributes 3
> Transfer Type Interrupt
> Synch Type None
> Usage Type Data
> wMaxPacketSize 0x0010 1x 16 bytes
> bInterval 7
> Interface Descriptor:
> bLength 9
> bDescriptorType 4
> bInterfaceNumber 1
> bAlternateSetting 0
> bNumEndpoints 0
> bInterfaceClass 14 Video
> bInterfaceSubClass 2 Video Streaming
> bInterfaceProtocol 0
> iInterface 0
> VideoStreaming Interface Descriptor:
> bLength 14
> bDescriptorType 36
> bDescriptorSubtype 1 (INPUT_HEADER)
> bNumFormats 1
> wTotalLength 0x01ef
> bEndPointAddress 130
> bmInfo 0
> bTerminalLink 3
> bStillCaptureMethod 2
> bTriggerSupport 1
> bTriggerUsage 0
> bControlSize 1
> bmaControls( 0) 0
> VideoStreaming Interface Descriptor:
> bLength 11
> bDescriptorType 36
> bDescriptorSubtype 6 (FORMAT_MJPEG)
> bFormatIndex 1
> bNumFrameDescriptors 9
> bFlags 1
> Fixed-size samples: Yes
> bDefaultFrameIndex 1
> bAspectRatioX 0
> bAspectRatioY 0
> bmInterlaceFlags 0x00
> Interlaced stream or variable: No
> Fields per frame: 1 fields
> Field 1 first: No
> Field pattern: Field 1 only
> bCopyProtect 0
> VideoStreaming Interface Descriptor:
> bLength 50
> bDescriptorType 36
> bDescriptorSubtype 7 (FRAME_MJPEG)
> bFrameIndex 1
> bmCapabilities 0x00
> Still image unsupported
> wWidth 1920
> wHeight 1080
> dwMinBitRate 248832000
> dwMaxBitRate 1492992000
> dwMaxVideoFrameBufferSize 6220800
> dwDefaultFrameInterval 333333
> bFrameIntervalType 6
> dwFrameInterval( 0) 333333
> dwFrameInterval( 1) 400000
> dwFrameInterval( 2) 500000
> dwFrameInterval( 3) 666666
> dwFrameInterval( 4) 1000000
> dwFrameInterval( 5) 2000000
> VideoStreaming Interface Descriptor:
> bLength 50
> bDescriptorType 36
> bDescriptorSubtype 7 (FRAME_MJPEG)
> bFrameIndex 2
> bmCapabilities 0x00
> Still image unsupported
> wWidth 2048
> wHeight 1536
> dwMinBitRate 377487360
> dwMaxBitRate 2264924160
> dwMaxVideoFrameBufferSize 9437184
> dwDefaultFrameInterval 333333
> bFrameIntervalType 6
> dwFrameInterval( 0) 333333
> dwFrameInterval( 1) 400000
> dwFrameInterval( 2) 500000
> dwFrameInterval( 3) 666666
> dwFrameInterval( 4) 1000000
> dwFrameInterval( 5) 2000000
> VideoStreaming Interface Descriptor:
> bLength 42
> bDescriptorType 36
> bDescriptorSubtype 7 (FRAME_MJPEG)
> bFrameIndex 3
> bmCapabilities 0x00
> Still image unsupported
> wWidth 1600
> wHeight 1200
> dwMinBitRate 230400000
> dwMaxBitRate 921600000
> dwMaxVideoFrameBufferSize 5760000
> dwDefaultFrameInterval 500000
> bFrameIntervalType 4
> dwFrameInterval( 0) 500000
> dwFrameInterval( 1) 666666
> dwFrameInterval( 2) 1000000
> dwFrameInterval( 3) 2000000
> VideoStreaming Interface Descriptor:
> bLength 38
> bDescriptorType 36
> bDescriptorSubtype 7 (FRAME_MJPEG)
> bFrameIndex 4
> bmCapabilities 0x00
> Still image unsupported
> wWidth 2592
> wHeight 1944
> dwMinBitRate 604661760
> dwMaxBitRate 1813985280
> dwMaxVideoFrameBufferSize 15116544
> dwDefaultFrameInterval 666666
> bFrameIntervalType 3
> dwFrameInterval( 0) 666666
> dwFrameInterval( 1) 1000000
> dwFrameInterval( 2) 2000000
> VideoStreaming Interface Descriptor:
> bLength 50
> bDescriptorType 36
> bDescriptorSubtype 7 (FRAME_MJPEG)
> bFrameIndex 5
> bmCapabilities 0x00
> Still image unsupported
> wWidth 1280
> wHeight 1024
> dwMinBitRate 157286400
> dwMaxBitRate 943718400
> dwMaxVideoFrameBufferSize 3932160
> dwDefaultFrameInterval 333333
> bFrameIntervalType 6
> dwFrameInterval( 0) 333333
> dwFrameInterval( 1) 400000
> dwFrameInterval( 2) 500000
> dwFrameInterval( 3) 666666
> dwFrameInterval( 4) 1000000
> dwFrameInterval( 5) 2000000
> VideoStreaming Interface Descriptor:
> bLength 42
> bDescriptorType 36
> bDescriptorSubtype 7 (FRAME_MJPEG)
> bFrameIndex 6
> bmCapabilities 0x00
> Still image unsupported
> wWidth 1280
> wHeight 960
> dwMinBitRate 147456000
> dwMaxBitRate 589824000
> dwMaxVideoFrameBufferSize 3686400
> dwDefaultFrameInterval 500000
> bFrameIntervalType 4
> dwFrameInterval( 0) 500000
> dwFrameInterval( 1) 666666
> dwFrameInterval( 2) 1000000
> dwFrameInterval( 3) 2000000
> VideoStreaming Interface Descriptor:
> bLength 50
> bDescriptorType 36
> bDescriptorSubtype 7 (FRAME_MJPEG)
> bFrameIndex 7
> bmCapabilities 0x00
> Still image unsupported
> wWidth 1280
> wHeight 720
> dwMinBitRate 110592000
> dwMaxBitRate 663552000
> dwMaxVideoFrameBufferSize 2764800
> dwDefaultFrameInterval 333333
> bFrameIntervalType 6
> dwFrameInterval( 0) 333333
> dwFrameInterval( 1) 400000
> dwFrameInterval( 2) 500000
> dwFrameInterval( 3) 666666
> dwFrameInterval( 4) 1000000
> dwFrameInterval( 5) 2000000
> VideoStreaming Interface Descriptor:
> bLength 50
> bDescriptorType 36
> bDescriptorSubtype 7 (FRAME_MJPEG)
> bFrameIndex 8
> bmCapabilities 0x00
> Still image unsupported
> wWidth 800
> wHeight 600
> dwMinBitRate 57600000
> dwMaxBitRate 345600000
> dwMaxVideoFrameBufferSize 1440000
> dwDefaultFrameInterval 333333
> bFrameIntervalType 6
> dwFrameInterval( 0) 333333
> dwFrameInterval( 1) 400000
> dwFrameInterval( 2) 500000
> dwFrameInterval( 3) 666666
> dwFrameInterval( 4) 1000000
> dwFrameInterval( 5) 2000000
> VideoStreaming Interface Descriptor:
> bLength 50
> bDescriptorType 36
> bDescriptorSubtype 7 (FRAME_MJPEG)
> bFrameIndex 9
> bmCapabilities 0x00
> Still image unsupported
> wWidth 640
> wHeight 480
> dwMinBitRate 36864000
> dwMaxBitRate 221184000
> dwMaxVideoFrameBufferSize 921600
> dwDefaultFrameInterval 333333
> bFrameIntervalType 6
> dwFrameInterval( 0) 333333
> dwFrameInterval( 1) 400000
> dwFrameInterval( 2) 500000
> dwFrameInterval( 3) 666666
> dwFrameInterval( 4) 1000000
> dwFrameInterval( 5) 2000000
> VideoStreaming Interface Descriptor:
> bLength 42
> bDescriptorType 36
> bDescriptorSubtype 3 (STILL_IMAGE_FRAME)
> bEndpointAddress 0
> bNumImageSizePatterns 9
> wWidth( 0) 1920
> wHeight( 0) 1080
> wWidth( 1) 2048
> wHeight( 1) 1536
> wWidth( 2) 1600
> wHeight( 2) 1200
> wWidth( 3) 2592
> wHeight( 3) 1944
> wWidth( 4) 1280
> wHeight( 4) 1024
> wWidth( 5) 1280
> wHeight( 5) 960
> wWidth( 6) 1280
> wHeight( 6) 720
> wWidth( 7) 800
> wHeight( 7) 600
> wWidth( 8) 640
> wHeight( 8) 480
> bNumCompressionPatterns 0
> VideoStreaming Interface Descriptor:
> bLength 6
> bDescriptorType 36
> bDescriptorSubtype 13 (COLORFORMAT)
> bColorPrimaries 1 (BT.709,sRGB)
> bTransferCharacteristics 1 (BT.709)
> bMatrixCoefficients 4 (SMPTE 170M (BT.601))
> Interface Descriptor:
> bLength 9
> bDescriptorType 4
> bInterfaceNumber 1
> bAlternateSetting 1
> bNumEndpoints 1
> bInterfaceClass 14 Video
> bInterfaceSubClass 2 Video Streaming
> bInterfaceProtocol 0
> iInterface 0
> Endpoint Descriptor:
> bLength 7
> bDescriptorType 5
> bEndpointAddress 0x82 EP 2 IN
> bmAttributes 5
> Transfer Type Isochronous
> Synch Type Asynchronous
> Usage Type Data
> wMaxPacketSize 0x1400 3x 1024 bytes
> bInterval 1
> Interface Descriptor:
> bLength 9
> bDescriptorType 4
> bInterfaceNumber 1
> bAlternateSetting 2
> bNumEndpoints 1
> bInterfaceClass 14 Video
> bInterfaceSubClass 2 Video Streaming
> bInterfaceProtocol 0
> iInterface 0
> Endpoint Descriptor:
> bLength 7
> bDescriptorType 5
> bEndpointAddress 0x82 EP 2 IN
> bmAttributes 5
> Transfer Type Isochronous
> Synch Type Asynchronous
> Usage Type Data
> wMaxPacketSize 0x0b84 2x 900 bytes
> bInterval 1
> Interface Descriptor:
> bLength 9
> bDescriptorType 4
> bInterfaceNumber 1
> bAlternateSetting 3
> bNumEndpoints 1
> bInterfaceClass 14 Video
> bInterfaceSubClass 2 Video Streaming
> bInterfaceProtocol 0
> iInterface 0
> Endpoint Descriptor:
> bLength 7
> bDescriptorType 5
> bEndpointAddress 0x82 EP 2 IN
> bmAttributes 5
> Transfer Type Isochronous
> Synch Type Asynchronous
> Usage Type Data
> wMaxPacketSize 0x0c00 2x 1024 bytes
> bInterval 1
> Interface Descriptor:
> bLength 9
> bDescriptorType 4
> bInterfaceNumber 1
> bAlternateSetting 4
> bNumEndpoints 1
> bInterfaceClass 14 Video
> bInterfaceSubClass 2 Video Streaming
> bInterfaceProtocol 0
> iInterface 0
> Endpoint Descriptor:
> bLength 7
> bDescriptorType 5
> bEndpointAddress 0x82 EP 2 IN
> bmAttributes 5
> Transfer Type Isochronous
> Synch Type Asynchronous
> Usage Type Data
> wMaxPacketSize 0x0c00 2x 1024 bytes
> bInterval 1
> Device Qualifier (for other device speed):
> bLength 10
> bDescriptorType 6
> bcdUSB 2.00
> bDeviceClass 239 Miscellaneous Device
> bDeviceSubClass 2
> bDeviceProtocol 1 Interface Association
> bMaxPacketSize0 64
> bNumConfigurations 1
> Device Status: 0x0000
> (Bus Powered)
> 
> 
> 
> 
> 
> ----
> 
>  
> 
> 
> 
> 
> 主　题：Re: [PATCH v4] media: uvcvideo: Fix bandwidth error for Alcor camera
> 日　期：2022-12-31 01:47
> 发件人：laurent.pinchart
> 收件人：艾超;
> 
> Hi Ai,
> 
> Thank you for the patch.
> 
> On Tue, Nov 22, 2022 at 04:48:33PM +0800, Ai Chao wrote:
> > For Alcor Corp. Slave camera(1b17:6684/2017:0011), it support to output
> 
> Could you please send me the USB descriptors for the 2017:0011 device
> (lsusb -v -d 2017:0011) ?
> 
> > compressed video data, and it return a wrong dwMaxPayloadTransferSize
> > fields. This is a fireware issue, but the manufacturer cannot provide
> > a const return fieldsby the fireware. For some device, it requested
> > 2752512 B/frame bandwidth. For normally device, it requested 3072 or 1024
> > B/frame bandwidth. so we check the dwMaxPayloadTransferSize fields,if it
> > large than 0x1000, reset dwMaxPayloadTransferSize to 1024, and the camera
> > preview normally.
> >
> > Signed-off-by: Ai Chao
> >
> > ---
> > change for v4
> > - Change usb_match_one_id to usb_match_id
> > - Modify the discription
> >
> > change for v3
> > - Add VID/PID 2017:0011
> >
> > change for v2
> > - Used usb_match_one_id to check VID and PID
> > ---
> > ---
> > drivers/media/usb/uvc/uvc_video.c | 12 ++++++++++++
> > 1 file changed, 12 insertions(+)
> >
> > diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
> > index d2eb9066e4dc..75bdd71d0e5a 100644
> > --- a/drivers/media/usb/uvc/uvc_video.c
> > +++ b/drivers/media/usb/uvc/uvc_video.c
> > @@ -135,6 +135,11 @@ static void uvc_fixup_video_ctrl(struct uvc_streaming *stream,
> > static const struct usb_device_id elgato_cam_link_4k = {
> > USB_DEVICE(0x0fd9, 0x0066)
> > };
> > + static const struct usb_device_id alcor_corp_slave_cam[] = {
> > + { USB_DEVICE(0x2017, 0x0011) },
> > + { USB_DEVICE(0x1b17, 0x6684) },
> > + { }
> > + };
> > struct uvc_format *format = NULL;
> > struct uvc_frame *frame = NULL;
> > unsigned int i;
> > @@ -234,6 +239,13 @@ static void uvc_fixup_video_ctrl(struct uvc_streaming *stream,
> >
> > ctrl->dwMaxPayloadTransferSize = bandwidth;
> > }
> > +
> > + /* Alcor Corp. Slave camera return wrong dwMaxPayloadTransferSize */
> > + if ((format->flags & UVC_FMT_FLAG_COMPRESSED) &&
> 
> Is the issue limited to MJPEG ? The device also supports YUYV, does it
> provide a correct dwMaxPayloadTransferSize in that case ?
> 
> > + (ctrl->dwMaxPayloadTransferSize > 0x1000) &&
> > + usb_match_id(stream->dev->intf, alcor_corp_slave_cam)) {
> > + ctrl->dwMaxPayloadTransferSize = 1024;
> > + }
> > }
> >
> > static size_t uvc_video_ctrl_size(struct uvc_streaming *stream)

-- 
Regards,

Laurent Pinchart
