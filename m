Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB8A2640B0E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 17:49:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233989AbiLBQtK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 11:49:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233497AbiLBQtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 11:49:08 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57665AB2CA
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 08:49:07 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id vp12so12865774ejc.8
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 08:49:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xVUWhdCgPZEXemrzoVD69wOfuR/sEShKHYaXnjh5IeM=;
        b=YMMJJPjl7hEYiVaA3VYhyPbcouCxz1JF9wxp3etUeY0ncpD2fLEbkyhDOPW25f0v6p
         bY+BAExRvWHMS8ePitasHOrMWb4t8JGq79x688gQxmVjyaGL0z5F5fpX7ZVTNtV0PQRS
         3BGmqneeKfE2AuGaIUIO6diMIeN3bO9mBUJmY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xVUWhdCgPZEXemrzoVD69wOfuR/sEShKHYaXnjh5IeM=;
        b=XzvaGhNIcOmIf3lwIy+hs2nKjibG5heRz6tGi4W7KxGFnMvHDjND6ucI8E99S1mETx
         Fyht33LyhxprRNtRyX60WttB4iC7MS6iSgHgk8USLraEbEzUWQfSuj8RI66VZO2ozTJO
         KAlNBNmUGda6bSm1686g0oiSd4ylmjxMaK37iwdp9xHQ34OFdPxJSNquLRlUIAQhAR7r
         mmg2w6/oGyAfazlJF4F05UmvGhSdA4chGn8rX9FdJEwdIa49H9kkOBUHC8zlIEAH3puO
         vlckCAAqh7J4LiLPKZysT5SD1OSj8aa1WLrIaCH51pw6tbgwG0Uej7OMNiM96XmNZdIH
         p2EQ==
X-Gm-Message-State: ANoB5pludf/JBFzSsOPsEtSCd65+VOxVzYfpbwAJSX6kx276ln6F0fC4
        1V0J4XIfIBHZDnqLYo7QCL259Q==
X-Google-Smtp-Source: AA0mqf401oJYqEuq5UzCsHyt4+vUcx4zR42dguFKuYy+3PLDZvJa6kfNIICIk0SmSFM0zO6kABZWfQ==
X-Received: by 2002:a17:907:cbc9:b0:7c0:8a2c:8886 with SMTP id vk9-20020a170907cbc900b007c08a2c8886mr1073546ejc.183.1669999745810;
        Fri, 02 Dec 2022 08:49:05 -0800 (PST)
Received: from alco.roam.corp.google.com (80.71.134.83.ipv4.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id 1-20020a170906310100b0073ae9ba9ba8sm3206883ejx.3.2022.12.02.08.49.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 08:49:05 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Fri, 02 Dec 2022 17:48:52 +0100
Subject: [PATCH RESEND] media: uvcvideo: Disable autosuspend for Insta360 Link
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221101-instal-v1-0-d13d1331c4b5@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Ricardo Ribalda <ribalda@chromium.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=4502; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=2thDDA3WqG5pS/1rzYujvnsp2N674EqRvqT4zNnMg34=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjiix32tDfnHUj3aNqEAj41Njr8wZ25OocIujGv7on
 HxWRZASJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY4osdwAKCRDRN9E+zzrEiO7FD/
 0YzXEDst0sISm8iOjjiDqGTo/jdw/EFzqLu+aAF6HvenpW9r2LcSuSeHrsj+1CpUhBHJ+WDISjUf9D
 JeC/MxPZ9uFwtwy6JK68rLcC4DOr3f9aAMyREjQGD+TCQg8NLoEDwP41Dx3lacp92ySM/YLeiHL3ST
 JnEAAy3BzQ2JyN8OZlK/wMIJjgQtDowlWAot6js6Rure8PcTclDyx28JrfFyar+shiN9+5pEwID7XM
 cuGAHbSknsp3V6Kf568hyP750yVOQjuSRKalUTKiaCKCeKLIobdj9TCBjwNb6K6oM/7D2cQooAJ3mS
 ImLXJu/Wu0lyk8kWXX0D4wQST7kCmj6LxqRDaET3B5m5noN+0vfFtrdCcEQwbobQA/sqpMWEjz4UDu
 EY236+dXDZUBLUsH9TNGssAzYDZBBHgtmXTxT/jGip8st0BXn+xXL8YOi0nx6ualKgAQri1GbNhRXz
 EfwLSz+lag0hEXW4aQPr2MgEtqn+btIm91kXw2g8ubX5VS0826sqrW7zJFZh8BcOQK/ekBKrhoBKi7
 cy5KAdlvPCCelMBQWIJrCmGJ8UN1mZhcp1AT4aE1ldggvVrZBNCIKHU/0V7Fsqj5i1H5yBWgxcxUkg
 5lwPcGw4YSHsb6sg+gN88j/qIUKIQWH6pTd0tmcieSjWCkbstqwJu4GNtpUA==
X-Developer-Key: i=ribalda@chromium.org; a=openpgp;
 fpr=9EC3BB66E2FC129A6F90B39556A0D81F9F782DA9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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
---
media: uvcvideo: Disable autosuspend for Insta360

The device does not handle properly the USB suspend and makes it barely usable.

To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/media/usb/uvc/uvc_driver.c | 13 ++++++++++++-
 drivers/media/usb/uvc/uvcvideo.h   |  1 +
 2 files changed, 13 insertions(+), 1 deletion(-)

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

---
base-commit: 23758867219c8d84c8363316e6dd2f9fd7ae3049
change-id: 20221101-instal-9a77ba1cc448

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>
