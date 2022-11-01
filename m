Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6EAA6145C4
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 09:35:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbiKAIfD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 04:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbiKAIe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 04:34:58 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 271A113D36
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 01:34:53 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id b2so35339596eja.6
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 01:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kUZE7M5oUT8LDN8JR/RPw2fby0T+Dqd48x1Z/JK+aTk=;
        b=Fc39Gwt5M8xdDnlcKjQeI0K+qmORgDKiSSufjeSDfvI7GEMPkNgpM0aTDcNHXw2ipI
         EBhWiZb+Dx3W2kdWJjsILnJGas7Z/Ep8dLjZO305jUgdHFC3fr701b/3AHGC3TPBOBUd
         EmM/iOgg7BkeirHsRrao4PI/tFR0p+PYW+NFg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kUZE7M5oUT8LDN8JR/RPw2fby0T+Dqd48x1Z/JK+aTk=;
        b=rNBDQmCNUGuBXlb2B4vcQSCrJvyK5qL5UIjhwvQVjvYEB50/3e3eGpxMEam/FyqTnA
         jz7wFZCQR77Uq66ntMRPB23T4F5+lIPBEXeVSTNi2vkimjrx+IMmllcQ0M3u6dQww9w0
         55WE7uOoeIAPPZEvylR26dx7WNYcgTAXbmKcoqiOlGUrzpH2Pa/zlGYQsiWllH0OGQsr
         LejNzoF184TEEEag6zMTqcmaqs8ETZD75s1EBjXqC9aZyT/KGcsWV+LBFE0/rKgoaUEg
         SSFBH252idJXKGpdeNlGl6MjWcwP/4am5gLZSed31GjOx+EQA2IBatmRAXDiTXhqVnTH
         aoew==
X-Gm-Message-State: ACrzQf1j9eysEFXueikJtqDbDTv51a7HkzmbmAml+7qBzMllM5dDs+Gb
        dSahrLG9XRDxMqP//4lo8qCHwg==
X-Google-Smtp-Source: AMsMyM74/gF4kyPa0adyVvYj/A1wW33A8rXyKEVyRpEyy+X/o/XQ80EYpp8zRkJSd0D5B3gTQBVScw==
X-Received: by 2002:a17:906:fe49:b0:73d:70c5:1a52 with SMTP id wz9-20020a170906fe4900b0073d70c51a52mr17480607ejb.469.1667291691723;
        Tue, 01 Nov 2022 01:34:51 -0700 (PDT)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:7782:437f:aea6:1ec7])
        by smtp.gmail.com with ESMTPSA id u18-20020a1709061db200b007030c97ae62sm3904075ejh.191.2022.11.01.01.34.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 01:34:51 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Tue, 01 Nov 2022 09:34:35 +0100
Subject: [PATCH v1 1/1] media: uvcvideo: Disable autosuspend for Insta360 Link
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221101-instal-v1-1-321f3d96ad92@chromium.org>
References: <20221101-instal-v1-0-321f3d96ad92@chromium.org>
In-Reply-To: <20221101-instal-v1-0-321f3d96ad92@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.11.0-dev-d93f8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3895; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=XZ6OvDGkQXEDoKsOnCvdejDrrlcRCGUZBSV6hbOR3Jo=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjYNoidXzvu40RiXCLGEmRNFL0hclBf4uywHqOYSue
 KnNPNP2JAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY2DaIgAKCRDRN9E+zzrEiOejD/
 4kdmd/+JA+MSsL+hh2Kb/a0pcDuF9XFuF4eAohESgYuv1hNwfOEXKLqaspzeL0oIvJ5nEiwEt4snNR
 PUhu1CgCSlA6dacRl9c8MWzbs5QbGWg/tf4nxcwnT//n7vX3W7Lf/j+jxKJG6bc8Q1Ix3Gd2Eh2f5B
 czmB6vGrbp3fUQH/blU8znZXjmIbW7/l6OkLgLked1TOWIYBTdXbngNQenZxoPQAhI5DQQ8NwZByn3
 bSQppu7b/yRB1C2iZGeQ5UT0PjF1fRr5xPxn8sHWwCuKjbPXsMbemhzubK9boK1x64RYJWmaNqbPjB
 ccya6IJ6z8WTc/+Z6mpDYJnJuHi6KYliy727+c7PuQnS5eVxIw8ipbRnGPdiV5p1IY7+H815qJrXo4
 i9i0EfT0dPxc61PCTGlFECxdU2kp7/6SbqZ7o3J9Bg8HRwSy1EA13ChXHTCpDVwpedlztWpARo1iNC
 cX2a1dxFypRvV7SYUgsPvi+iZo0dl8eO/lcpIbgu4sGVqlLfbIUMFuGm6KoQhGltnUph6VqBlTd0k9
 9B/lyG3belB2nGh6AkNYUg78MZepkWTHNHOSWhJaUpbWF+/Kp5uZ56dbEDu0naOCYqQega6ljUaE9w
 ECpLg8LrjNWUl2qlZe2bDUEfeSJpgqQE6seBgx5tAuOOByAWrdRUEn3ReO2g==
X-Developer-Key: i=ribalda@chromium.org; a=openpgp;
 fpr=9EC3BB66E2FC129A6F90B39556A0D81F9F782DA9
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the device suspends, it keeps power-cycling.

The user notices it because the LED constanct oscillate between
blue (ready) and no LED (off).

<6>[95202.128542] usb 3-3-port4: attempt power cycle
<6>[95206.070120] usb 3-3.4: new high-speed USB device number 49 using xhci_hcd
<6>[95206.212027] usb 3-3.4: New USB device found, idVendor=2e1a, idProduct=4c01, bcdDevice= 2.00
<6>[95206.212044] usb 3-3.4: New USB device strings: Mfr=1, Product=2, SerialNumber=<Serial: 1>
<6>[95206.212050] usb 3-3.4: Product: Insta360 Link
<6>[95206.212075] usb 3-3.4: Manufacturer: Amba
<7>[95206.214862] usb 3-3.4: GPIO lookup for consumer privacy
<7>[95206.214866] usb 3-3.4: using lookup tables for GPIO lookup
<7>[95206.214869] usb 3-3.4: No GPIO consumer privacy found
<6>[95206.214871] usb 3-3.4: Found UVC 1.10 device Insta360 Link (2e1a:4c01)
<3>[95206.217113] usb 3-3.4: Failed to query (GET_INFO) UVC control 14 on unit 1: -32 (exp. 1).
<3>[95206.217733] usb 3-3.4: Failed to query (GET_INFO) UVC control 16 on unit 1: -32 (exp. 1).
<4>[95206.223544] usb 3-3.4: Warning! Unlikely big volume range (=32767), cval->res is probably wrong.
<4>[95206.223554] usb 3-3.4: [9] FU [Mic Capture Volume] ch = 1, val = -32768/-1/1
<6>[95210.698990] usb 3-3.4: USB disconnect, device number 49
<6>[95211.963090] usb 3-3.4: new high-speed USB device number 50 using xhci_hcd
<6>[95212.657061] usb 3-3.4: new full-speed USB device number 51 using xhci_hcd
<3>[95212.783119] usb 3-3.4: device descriptor read/64, error -32
<3>[95213.015076] usb 3-3.4: device descriptor read/64, error -32
<6>[95213.120358] usb 3-3-port4: attempt power cycle

Bus 001 Device 009: ID 2e1a:4c01 Amba Insta360 Link
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass          239 Miscellaneous Device
  bDeviceSubClass         2
  bDeviceProtocol         1 Interface Association
  bMaxPacketSize0        64
  idVendor           0x2e1a
  idProduct          0x4c01
  bcdDevice            2.00
  iManufacturer           1 Amba
  iProduct                2 Insta360 Link
  iSerial                 0
  bNumConfigurations      1

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index 215fb483efb0..ad95c7599863 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -2223,7 +2223,9 @@ static int uvc_probe(struct usb_interface *intf,
 	}
 
 	uvc_dbg(dev, PROBE, "UVC device initialized\n");
-	usb_enable_autosuspend(udev);
+	if (!(dev->quirks & UVC_QUIRK_DISABLE_AUTOSUSPEND))
+		usb_enable_autosuspend(udev);
+
 	return 0;
 
 error:
@@ -2967,6 +2969,15 @@ static const struct usb_device_id uvc_ids[] = {
 	  .bInterfaceSubClass	= 1,
 	  .bInterfaceProtocol	= 0,
 	  .driver_info		= (kernel_ulong_t)&uvc_quirk_force_y8 },
+	/* Insta360 Link */
+	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
+				| USB_DEVICE_ID_MATCH_INT_INFO,
+	  .idVendor		= 0x2e1a,
+	  .idProduct		= 0x4c01,
+	  .bInterfaceClass	= USB_CLASS_VIDEO,
+	  .bInterfaceSubClass	= 1,
+	  .bInterfaceProtocol	= 0,
+	  .driver_info		= UVC_INFO_QUIRK(UVC_QUIRK_DISABLE_AUTOSUSPEND) },
 	/* GEO Semiconductor GC6500 */
 	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
 				| USB_DEVICE_ID_MATCH_INT_INFO,
diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
index df93db259312..47c86c7c6346 100644
--- a/drivers/media/usb/uvc/uvcvideo.h
+++ b/drivers/media/usb/uvc/uvcvideo.h
@@ -74,6 +74,7 @@
 #define UVC_QUIRK_RESTORE_CTRLS_ON_INIT	0x00000400
 #define UVC_QUIRK_FORCE_Y8		0x00000800
 #define UVC_QUIRK_FORCE_BPP		0x00001000
+#define UVC_QUIRK_DISABLE_AUTOSUSPEND	0x00002000
 
 /* Format flags */
 #define UVC_FMT_FLAG_COMPRESSED		0x00000001

-- 
b4 0.11.0-dev-d93f8
