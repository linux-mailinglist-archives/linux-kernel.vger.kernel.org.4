Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E986D5BE80A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 16:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbiITOHj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 10:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbiITOHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 10:07:33 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 740DDEE38
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 07:07:31 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id r18so6383952eja.11
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 07:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date;
        bh=gqOM2ax1M4eFGJBfEooPhgWt4hxS5lEfMPKCGdAAQvM=;
        b=IT2VLqA+WO3UJJUrXyEmOC/RKE5D1gGm1ggJ4Djp/uZvNs2AjutyQXEX8vm4QXzsdQ
         UDEMFFPbYslHAmNEpVI7+oJmeAKMicQDHyoTv2Z1Q11zf1iM9YDwDZj9ch/dYe2fqUx9
         MhOmP4xNf3XCxQM6hSAYViR3t0LXy3uDUHz2A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=gqOM2ax1M4eFGJBfEooPhgWt4hxS5lEfMPKCGdAAQvM=;
        b=tOaWepGzGKC62FmN2MveacrlfDUvE8wur1XtXAgpJoK40BA/oGe3VtgK+w+TAJGGds
         XuvOe7tt/uBLfL2BoX3TAEn73Cp8le/iI5HER0df+VUgX0eX6IOcC99CQx4jUwXh/AEG
         YKhj7IZzF9iH8lfr+EuPZ3A2oBp3vnUSrxhaodNA7Tv2sHQl+xp0ZRS4+rdVyKSTIEtR
         9KYeawYFs+GiY9UZSALa5cXWTy6QZxMJSvL5r/Hzez8tNUErojJbjQmm+fVqPrQJYx/F
         sEmBKv9MKGoEZ9o4nZsB2wxrd1wxJKxcBhmumALHm4IBSErnuMaF0yoY7lNYv1p7DCpn
         2tYg==
X-Gm-Message-State: ACrzQf1s5kcOVwA2M/nijuSz7dJI//UdF/UJTZCfhh4TOMU7/oBUgJ8P
        wnAh4PRprm2XMXSBV9/9p5dHfw==
X-Google-Smtp-Source: AMsMyM7mcRZApnJUeohWwEywrffAMbh4ZnjFaXQv5zjAH+N3IbgyfZppydskh6LYGkNOyYFvRBNeMw==
X-Received: by 2002:a17:907:1c90:b0:77f:b1ae:9f44 with SMTP id nb16-20020a1709071c9000b0077fb1ae9f44mr16717857ejc.304.1663682849781;
        Tue, 20 Sep 2022 07:07:29 -0700 (PDT)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:935d:52b0:7461:88e1])
        by smtp.gmail.com with ESMTPSA id 12-20020a170906308c00b0074182109623sm902003ejv.39.2022.09.20.07.07.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 07:07:29 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Tue, 20 Sep 2022 16:07:20 +0200
Subject: [PATCH v1 1/1] media: uvcvideo: Recover stalled ElGato devices
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20220920-resend-elgato-v1-1-8672a2380e3d@chromium.org>
References: <20220920-resend-elgato-v1-0-8672a2380e3d@chromium.org>
In-Reply-To: <20220920-resend-elgato-v1-0-8672a2380e3d@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Ricardo Ribalda <ribalda@chromium.org>,
        linux-media@vger.kernel.org
X-Mailer: b4 0.11.0-dev-d93f8
X-Developer-Signature: v=1; a=openpgp-sha256; l=19385; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=av7JGNocA2WN+ItictrMvvtWQGh0aKkUq3XbRjfk3zo=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjKcke3/wADwMiSpvxpscCdUcUdiHbkwgmQeqpdtJC
 75la2weJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCYynJHgAKCRDRN9E+zzrEiIdUD/
 9pTGHYfFOAjdmTItDL6DT5HR5kYg8KGcP/5wc/8yin9pDDtczn/ww9mEY0TofKUgFXhX6bJb6d4eL1
 7us3Syc18dCSpZWGegLSXz2vL9/bPZbJFshTnDWjQk3pDY7XPTglZw8JCYonjHE2x/MgqwpZ2af1Rr
 EYV2Bn2bqzGNRXrojsov/tNE/vrVMbOg8HSp6CH8itfolK2dDKa2NNx3gE+FuFJAobFsBYyBHpSczN
 26gJFVt8aH1ZICDHtk8mgoG3TlwJ73N6HtXWvUNNBCWZSVnPETfGM1u6jTI2MHU+/+64p2pBDE1gNt
 TAnk6o9TqKp7tHO34ikwVkVxD1OYXqkwM61eLA7eYQNe8UiDO8UII+z8YkGQ8j8fYKn3nKpKBgthnW
 ZpAaE8NlQ8OI9XJnxQ273RjLYt0fw576F99r5H0C+EaiAuC6HzJHASRIeF/kyIsqPr2hc81Dw4Outj
 /KoNY1g5asmE8XqssG91EE4x/HK6Ova1CGZkuX6haoahD8ihiJDewLS6xHswg6NOTj1SgexSQEkppk
 AmjstsJi6CeELls7wa6a0ALSzk4xhZxxQ9sBtW/KCiPfPbyko4dIzuqb5JXS/0P6b8xIUcNj0XMHdH
 sOF0ciC/1zrAax2wA3Bx6I1ajeLOqQKX35j1S3FB4skZpda4hZ3yq53NkXUg==
X-Developer-Key: i=ribalda@chromium.org; a=openpgp;
 fpr=9EC3BB66E2FC129A6F90B39556A0D81F9F782DA9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Elgato Cam Link 4k can be in a stalled state if the resolution of
the external source has changed while the firmware initializes.
Once in this state, the device is useless until it receives a
USB reset. It has even been observed that the stalled state will
continue even after unplugging the device.

lsusb -v

Bus 002 Device 002: ID 0fd9:0066 Elgato Systems GmbH Cam Link 4K
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               3.00
  bDeviceClass          239 Miscellaneous Device
  bDeviceSubClass         2
  bDeviceProtocol         1 Interface Association
  bMaxPacketSize0         9
  idVendor           0x0fd9 Elgato Systems GmbH
  idProduct          0x0066
  bcdDevice            0.00
  iManufacturer           1 Elgato
  iProduct                2 Cam Link 4K
  iSerial                 4 0005AC52FE000
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength       0x01ca
    bNumInterfaces          5
    bConfigurationValue     1
    iConfiguration          0
    bmAttributes         0x80
      (Bus Powered)
    MaxPower              800mA
    Interface Association:
      bLength                 8
      bDescriptorType        11
      bFirstInterface         0
      bInterfaceCount         2
      bFunctionClass         14 Video
      bFunctionSubClass       3 Video Interface Collection
      bFunctionProtocol       0
      iFunction               0
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass        14 Video
      bInterfaceSubClass      1 Video Control
      bInterfaceProtocol      0
      iInterface              5 Cam Link 4K
      VideoControl Interface Descriptor:
        bLength                13
        bDescriptorType        36
        bDescriptorSubtype      1 (HEADER)
        bcdUVC               1.10
        wTotalLength       0x002b
        dwClockFrequency        0.000000MHz
        bInCollection           1
        baInterfaceNr( 0)       1
      VideoControl Interface Descriptor:
        bLength                 8
        bDescriptorType        36
        bDescriptorSubtype      2 (INPUT_TERMINAL)
        bTerminalID             1
        wTerminalType      0x0200 Input Vendor Specific
        bAssocTerminal          0
        iTerminal               0
      VideoControl Interface Descriptor:
        bLength                13
        bDescriptorType        36
        bDescriptorSubtype      5 (PROCESSING_UNIT)
        bUnitID                 2
        bSourceID               1
        wMaxMultiplier          0
        bControlSize            3
        bmControls     0x0000000f
          Brightness
          Contrast
          Hue
          Saturation
        iProcessing             0
        bmVideoStandards     0x00
      VideoControl Interface Descriptor:
        bLength                 9
        bDescriptorType        36
        bDescriptorSubtype      3 (OUTPUT_TERMINAL)
        bTerminalID             3
        wTerminalType      0x0101 USB Streaming
        bAssocTerminal          0
        bSourceID               2
        iTerminal               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x82  EP 2 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               1
        bMaxBurst               0
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass        14 Video
      bInterfaceSubClass      2 Video Streaming
      bInterfaceProtocol      0
      iInterface              5 Cam Link 4K
      VideoStreaming Interface Descriptor:
        bLength                            16
        bDescriptorType                    36
        bDescriptorSubtype                  1 (INPUT_HEADER)
        bNumFormats                         3
        wTotalLength                   0x00cd
        bEndpointAddress                 0x83  EP 3 IN
        bmInfo                              0
        bTerminalLink                       3
        bStillCaptureMethod                 1
        bTriggerSupport                     0
        bTriggerUsage                       0
        bControlSize                        1
        bmaControls( 0)                     0
        bmaControls( 1)                     0
        bmaControls( 2)                     0
      VideoStreaming Interface Descriptor:
        bLength                            27
        bDescriptorType                    36
        bDescriptorSubtype                  4 (FORMAT_UNCOMPRESSED)
        bFormatIndex                        1
        bNumFrameDescriptors                1
        guidFormat                            {3231564e-0000-0010-8000-00aa00389b71}
        bBitsPerPixel                      12
        bDefaultFrameIndex                  1
        bAspectRatioX                       0
        bAspectRatioY                       0
        bmInterlaceFlags                 0x00
          Interlaced stream or variable: No
          Fields per frame: 2 fields
          Field 1 first: No
          Field pattern: Field 1 only
        bCopyProtect                        0
      VideoStreaming Interface Descriptor:
        bLength                            30
        bDescriptorType                    36
        bDescriptorSubtype                  5 (FRAME_UNCOMPRESSED)
        bFrameIndex                         1
        bmCapabilities                   0x01
          Still image supported
        wWidth                           3840
        wHeight                          2160
        dwMinBitRate                2985984000
        dwMaxBitRate                2985984000
        dwMaxVideoFrameBufferSize    12441600
        dwDefaultFrameInterval         333333
        bFrameIntervalType                  1
        dwFrameInterval( 0)            333333
      VideoStreaming Interface Descriptor:
        bLength                             6
        bDescriptorType                    36
        bDescriptorSubtype                 13 (COLORFORMAT)
        bColorPrimaries                     1 (BT.709,sRGB)
        bTransferCharacteristics            1 (BT.709)
        bMatrixCoefficients                 1 (BT.709)
      VideoStreaming Interface Descriptor:
        bLength                            27
        bDescriptorType                    36
        bDescriptorSubtype                  4 (FORMAT_UNCOMPRESSED)
        bFormatIndex                        2
        bNumFrameDescriptors                1
        guidFormat                            {3231564e-0000-0010-8000-00aa00389b71}
        bBitsPerPixel                      12
        bDefaultFrameIndex                  1
        bAspectRatioX                       0
        bAspectRatioY                       0
        bmInterlaceFlags                 0x00
          Interlaced stream or variable: No
          Fields per frame: 2 fields
          Field 1 first: No
          Field pattern: Field 1 only
        bCopyProtect                        0
      VideoStreaming Interface Descriptor:
        bLength                            30
        bDescriptorType                    36
        bDescriptorSubtype                  5 (FRAME_UNCOMPRESSED)
        bFrameIndex                         1
        bmCapabilities                   0x01
          Still image supported
        wWidth                           3840
        wHeight                          2160
        dwMinBitRate                2985984000
        dwMaxBitRate                2985984000
        dwMaxVideoFrameBufferSize    12441600
        dwDefaultFrameInterval         333333
        bFrameIntervalType                  1
        dwFrameInterval( 0)            333333
      VideoStreaming Interface Descriptor:
        bLength                             6
        bDescriptorType                    36
        bDescriptorSubtype                 13 (COLORFORMAT)
        bColorPrimaries                     1 (BT.709,sRGB)
        bTransferCharacteristics            1 (BT.709)
        bMatrixCoefficients                 1 (BT.709)
      VideoStreaming Interface Descriptor:
        bLength                            27
        bDescriptorType                    36
        bDescriptorSubtype                  4 (FORMAT_UNCOMPRESSED)
        bFormatIndex                        3
        bNumFrameDescriptors                1
        guidFormat                            {30323449-0000-0010-8000-00aa00389b71}
        bBitsPerPixel                      12
        bDefaultFrameIndex                  1
        bAspectRatioX                       0
        bAspectRatioY                       0
        bmInterlaceFlags                 0x00
          Interlaced stream or variable: No
          Fields per frame: 2 fields
          Field 1 first: No
          Field pattern: Field 1 only
        bCopyProtect                        0
      VideoStreaming Interface Descriptor:
        bLength                            30
        bDescriptorType                    36
        bDescriptorSubtype                  5 (FRAME_UNCOMPRESSED)
        bFrameIndex                         1
        bmCapabilities                   0x01
          Still image supported
        wWidth                           3840
        wHeight                          2160
        dwMinBitRate                2985984000
        dwMaxBitRate                2985984000
        dwMaxVideoFrameBufferSize    12441600
        dwDefaultFrameInterval         333333
        bFrameIntervalType                  1
        dwFrameInterval( 0)            333333
      VideoStreaming Interface Descriptor:
        bLength                             6
        bDescriptorType                    36
        bDescriptorSubtype                 13 (COLORFORMAT)
        bColorPrimaries                     1 (BT.709,sRGB)
        bTransferCharacteristics            1 (BT.709)
        bMatrixCoefficients                 1 (BT.709)
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0400  1x 1024 bytes
        bInterval               0
        bMaxBurst              15
    Interface Association:
      bLength                 8
      bDescriptorType        11
      bFirstInterface         2
      bInterfaceCount         1
      bFunctionClass          3 Human Interface Device
      bFunctionSubClass       0
      bFunctionProtocol       0
      iFunction               5 Cam Link 4K
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        2
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         3 Human Interface Device
      bInterfaceSubClass      0
      bInterfaceProtocol      0
      iInterface              0
        HID Device Descriptor:
          bLength                 9
          bDescriptorType        33
          bcdHID               1.01
          bCountryCode            0 Not supported
          bNumDescriptors         1
          bDescriptorType        34 Report
          wDescriptorLength     207
         Report Descriptors:
           ** UNAVAILABLE **
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x86  EP 6 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval              10
        bMaxBurst               0
    Interface Association:
      bLength                 8
      bDescriptorType        11
      bFirstInterface         3
      bInterfaceCount         2
      bFunctionClass          1 Audio
      bFunctionSubClass       2 Streaming
      bFunctionProtocol       0
      iFunction               6 Cam Link 4K
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        3
      bAlternateSetting       0
      bNumEndpoints           0
      bInterfaceClass         1 Audio
      bInterfaceSubClass      1 Control Device
      bInterfaceProtocol      0
      iInterface              6 Cam Link 4K
      AudioControl Interface Descriptor:
        bLength                 9
        bDescriptorType        36
        bDescriptorSubtype      1 (HEADER)
        bcdADC               1.00
        wTotalLength       0x001e
        bInCollection           1
        baInterfaceNr(0)        4
      AudioControl Interface Descriptor:
        bLength                12
        bDescriptorType        36
        bDescriptorSubtype      2 (INPUT_TERMINAL)
        bTerminalID             1
        wTerminalType      0x0602 Digital Audio Interface
        bAssocTerminal          0
        bNrChannels             2
        wChannelConfig     0x0003
          Left Front (L)
          Right Front (R)
        iChannelNames           0
        iTerminal               0
      AudioControl Interface Descriptor:
        bLength                 9
        bDescriptorType        36
        bDescriptorSubtype      3 (OUTPUT_TERMINAL)
        bTerminalID             2
        wTerminalType      0x0101 USB Streaming
        bAssocTerminal          0
        bSourceID               1
        iTerminal               0
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        4
      bAlternateSetting       0
      bNumEndpoints           0
      bInterfaceClass         1 Audio
      bInterfaceSubClass      2 Streaming
      bInterfaceProtocol      0
      iInterface              6 Cam Link 4K
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        4
      bAlternateSetting       1
      bNumEndpoints           1
      bInterfaceClass         1 Audio
      bInterfaceSubClass      2 Streaming
      bInterfaceProtocol      0
      iInterface              6 Cam Link 4K
      AudioStreaming Interface Descriptor:
        bLength                 7
        bDescriptorType        36
        bDescriptorSubtype      1 (AS_GENERAL)
        bTerminalLink           2
        bDelay                  1 frames
        wFormatTag         0x0001 PCM
      AudioStreaming Interface Descriptor:
        bLength                11
        bDescriptorType        36
        bDescriptorSubtype      2 (FORMAT_TYPE)
        bFormatType             1 (FORMAT_TYPE_I)
        bNrChannels             2
        bSubframeSize           2
        bBitResolution         16
        bSamFreqType            1 Discrete
        tSamFreq[ 0]        48000
      Endpoint Descriptor:
        bLength                 9
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            5
          Transfer Type            Isochronous
          Synch Type               Asynchronous
          Usage Type               Data
        wMaxPacketSize     0x00c0  1x 192 bytes
        bInterval               4
        bRefresh                0
        bSynchAddress           0
        bMaxBurst               0
        AudioStreaming Endpoint Descriptor:
          bLength                 7
          bDescriptorType        37
          bDescriptorSubtype      1 (EP_GENERAL)
          bmAttributes         0x00
          bLockDelayUnits         0 Undefined
          wLockDelay         0x0000
Binary Object Store Descriptor:
  bLength                 5
  bDescriptorType        15
  wTotalLength       0x0016
  bNumDeviceCaps          2
  USB 2.0 Extension Device Capability:
    bLength                 7
    bDescriptorType        16
    bDevCapabilityType      2
    bmAttributes   0x00000002
      HIRD Link Power Management (LPM) Supported
  SuperSpeed USB Device Capability:
    bLength                10
    bDescriptorType        16
    bDevCapabilityType      3
    bmAttributes         0x00
    wSpeedsSupported   0x000e
      Device can operate at Full Speed (12Mbps)
      Device can operate at High Speed (480Mbps)
      Device can operate at SuperSpeed (5Gbps)
    bFunctionalitySupport   3
      Lowest fully-functional device speed is SuperSpeed (5Gbps)
    bU1DevExitLat           0 micro seconds
    bU2DevExitLat           0 micro seconds
Device Status:     0x0000
  (Bus Powered)

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
index 170a008f4006..ad1762b66c4c 100644
--- a/drivers/media/usb/uvc/uvc_video.c
+++ b/drivers/media/usb/uvc/uvc_video.c
@@ -129,12 +129,12 @@ int uvc_query_ctrl(struct uvc_device *dev, u8 query, u8 unit,
 	return -EPIPE;
 }
 
+static const struct usb_device_id elgato_cam_link_4k = {
+						USB_DEVICE(0x0fd9, 0x0066)};
+
 static void uvc_fixup_video_ctrl(struct uvc_streaming *stream,
 	struct uvc_streaming_control *ctrl)
 {
-	static const struct usb_device_id elgato_cam_link_4k = {
-		USB_DEVICE(0x0fd9, 0x0066)
-	};
 	struct uvc_format *format = NULL;
 	struct uvc_frame *frame = NULL;
 	unsigned int i;
@@ -297,7 +297,7 @@ static int uvc_get_video_ctrl(struct uvc_streaming *stream,
 		dev_err(&stream->intf->dev,
 			"Failed to query (%u) UVC %s control : %d (exp. %u).\n",
 			query, probe ? "probe" : "commit", ret, size);
-		ret = -EIO;
+		ret = (ret == -EPROTO) ? -EPROTO : -EIO;
 		goto out;
 	}
 
@@ -2121,6 +2121,20 @@ int uvc_video_init(struct uvc_streaming *stream)
 	 * request on the probe control, as required by the UVC specification.
 	 */
 	ret = uvc_get_video_ctrl(stream, probe, 1, UVC_GET_CUR);
+
+	/*
+	 * Elgato Cam Link 4k can be in a stalled state if the resolution of
+	 * the external source has changed while the firmware initializes.
+	 * Once in this state, the device is useless until it receives a
+	 * USB reset. It has even been observed that the stalled state will
+	 * continue even after unplugging the device.
+	 */
+	if (usb_match_one_id(stream->dev->intf, &elgato_cam_link_4k) &&
+	    (ret == -EPROTO)) {
+		usb_reset_device(stream->dev->udev);
+		dev_err(&stream->intf->dev, "Restarting Elgato Cam Link 4K\n");
+	}
+
 	if (ret < 0)
 		return ret;
 

-- 
b4 0.11.0-dev-d93f8
