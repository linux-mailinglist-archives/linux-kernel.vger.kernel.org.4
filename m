Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1302F662257
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 11:02:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233883AbjAIKCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 05:02:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237061AbjAIKBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 05:01:24 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 186D711800
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 02:01:16 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id vm8so18704815ejc.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 02:01:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xvjHFoIRPinuYhuTUwGZOQFT+hEiktYHj7+SHztYcQc=;
        b=MNP6VpTztVXmmbuGde6f7sg2tCgkNWgruLxCshIXHGMgr72O+XAxkdM/OHgrDEO0tn
         /Ugssz5NHL1356jm6jc2UbZMX6aX67JzM2St3ktgyHrSaZExd/Ceim4w8puc6FiyHCB6
         /zVeM4QkZ3P/Gs4rNXXJMBbZdViMfN6EowzTw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xvjHFoIRPinuYhuTUwGZOQFT+hEiktYHj7+SHztYcQc=;
        b=UKpxO9jprudx5u3Ar8WEWnyTUjBiUG0acsotmb4EG/a+bt16jx4Mv5tTGNIhk5DmCD
         9GQ6XJMfYMPNHBpVPAyfkbM/MRXxfX9+5dIbFK47dnE3JasTr8GZyW7EBq83YEOW4+t4
         IXICTGhHXDuvWn4cVVnEEMMmx/V524HqV3jbIZ6n84KJIi9NUBgIvVqlT3If+m1m6W+L
         OBb/DYzhG1bAuq8CsiiIKKANIExZslbCxCOzZRy7hEEAaWlOqphVBAqjNv1lPQNYI/dt
         xOSO4gFadq0dF/hT6u9uriFejASCAnBTV662UhZGXztzPtBxzd7yVSnlAciobWaISSp1
         soow==
X-Gm-Message-State: AFqh2kqLnaf/M7qpsF+1h13psMB7hA6g5lTZk8V3/MI7QCAe/yTpugg3
        jQZ+nOnz2ijCB62fgu0o7QvjAw==
X-Google-Smtp-Source: AMrXdXvIwlfOHY3XNb2gJXCT9h+smYZclmjl8O+z7R0NcRwGqk54IIfi+zFzMwp++1CVkvy71MVAlw==
X-Received: by 2002:a17:906:ca56:b0:84d:363c:888b with SMTP id jx22-20020a170906ca5600b0084d363c888bmr5395629ejb.58.1673258474631;
        Mon, 09 Jan 2023 02:01:14 -0800 (PST)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:cd22:9dd:6d54:8488])
        by smtp.gmail.com with ESMTPSA id bg14-20020a170906a04e00b007c094d31f35sm3557548ejb.76.2023.01.09.02.01.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 02:01:14 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Mon, 09 Jan 2023 11:00:49 +0100
Subject: [PATCH v4 2/5] media: uvcvideo: Quirk for invalid dev_sof in Logitech C922
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20220920-resend-hwtimestamp-v4-2-a8ddc1358a29@chromium.org>
References: <20220920-resend-hwtimestamp-v4-0-a8ddc1358a29@chromium.org>
In-Reply-To: <20220920-resend-hwtimestamp-v4-0-a8ddc1358a29@chromium.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Ricardo Ribalda <ribalda@chromium.org>,
        "hn.chen" <hn.chen@sunplusit.com>, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=5225; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=FQpt+pfRHossLzPpk7WZbwMO2zMVjYkgEDfy6RwkwCA=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBju+Xi9KJLwkoFnzocf5Tv+v23shGAduGgBn6Dp6Dr
 OFH/mw2JAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY7vl4gAKCRDRN9E+zzrEiGb3D/
 9bq6WciES6pVW4X78EZvp5qfPLwUh2eGty8FNFhUYbC2NI1Jz9qU8zax0TPuzH0V03OgxWZE1DMa+B
 4m/JOWLudJwtMdmVM40jtSnwVTh8Ie7HCU818AXu+3mqr6ZGQHp5MuhbciQhRzJJ5pjOgU5brFgDBg
 CnfpX1JvCGBc+Nu20JtJKJb2anDx2E8aF/+dJRsSp4PYvKiI9+eMCUxZaQP3e6tcAVcGN28WTfg8tc
 zxV/hs889TMfbLSYOSIDQMgOOmHFA9evj46ePcQ244DqGoST4g8ZEHAwueAIBHunBTWlTZeXMIZU7X
 yhuVQEjIwvQaUIcXTUE2/fPy2KTS9g2XyUiQu6TWuSAKRZyd0DtrBgSmmSmT/AA1h2pSIm6EP4Uof5
 2tGY4saqS19UqOYyPYK4xKT5+KZkbKzL9hozjoEd/MFgKYq2Loksg16NSJi6bq8E50ob2PeTs37sa/
 Z0fOdq47G9mXv7lzP7zlri6UyjCSSZxviothS7/OjJ0/HrLLbQRKl9h3JgJ3EKfVpnHtF+1qKYe3W3
 fi1SOWHfoBGWQH6gbZdAIC9VRjxCJRzoFXgxSVzoB+mTl9cAb+alSHerEDFcTcHA3suQLqGtiMf8C1
 C2t/cokh1tzM2dYII0ZdmQWdims303apemmXtm/8M1PNXPmC8cJK68905iJA==
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

Logitech C922 internal SOF does not increases at a stable rate of 1kHz.
This causes that the device_sof and the host_sof run at different rates,
breaking the clock domain conversion algorithm. Eg:

30 (6) [-] none 30 614400 B 21.245557 21.395214 34.133 fps ts mono/SoE
31 (7) [-] none 31 614400 B 21.275327 21.427246 33.591 fps ts mono/SoE
32 (0) [-] none 32 614400 B 21.304739 21.459256 34.000 fps ts mono/SoE
33 (1) [-] none 33 614400 B 21.334324 21.495274 33.801 fps ts mono/SoE
* 34 (2) [-] none 34 614400 B 21.529237 21.527297 5.130 fps ts mono/SoE
* 35 (3) [-] none 35 614400 B 21.649416 21.559306 8.321 fps ts mono/SoE
36 (4) [-] none 36 614400 B 21.678789 21.595320 34.045 fps ts mono/SoE
...
99 (3) [-] none 99 614400 B 23.542226 23.696352 33.541 fps ts mono/SoE
100 (4) [-] none 100 614400 B 23.571578 23.728404 34.069 fps ts mono/SoE
101 (5) [-] none 101 614400 B 23.601425 23.760420 33.504 fps ts mono/SoE
* 102 (6) [-] none 102 614400 B 23.798324 23.796428 5.079 fps ts mono/SoE
* 103 (7) [-] none 103 614400 B 23.916271 23.828450 8.478 fps ts mono/SoE
104 (0) [-] none 104 614400 B 23.945720 23.860479 33.957 fps ts mono/SoE

Instead of disabling completely the hardware timestamping for such
hardware we take the assumption that the packet handling jitter is
under 2ms and use the host_sof as dev_sof.

We can think of the UVC hardware clock as a system with a coarse clock
(the SOF) and a fine clock (the PTS). The coarse clock can be replaced
with a clock on the same frequency, if the jitter of such clock is
smaller than its sampling rate. That way we can save some of the
precision of the fine clock.

To probe this point we have run three experiments on the Logitech C922.
On that experiment we run the camera at 33fps and we analyse the
difference in msec between a frame and its predecessor. If we display
the histogram of that value, a thinner histogram will mean a better
meassurement. The results for:
- original hw timestamp: https://ibb.co/D1HJJ4x
- pure software timestamp: https://ibb.co/QC9MgVK
- modified hw timestamp: https://ibb.co/8s9dBdk

This bug in the camera firmware has been confirmed by the vendor.

lsusb -v

Bus 001 Device 044: ID 046d:085c Logitech, Inc. C922 Pro Stream Webcam
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass          239 Miscellaneous Device
  bDeviceSubClass         2
  bDeviceProtocol         1 Interface Association
  bMaxPacketSize0        64
  idVendor           0x046d Logitech, Inc.
  idProduct          0x085c C922 Pro Stream Webcam
  bcdDevice            0.16
  iManufacturer           0
  iProduct                2 C922 Pro Stream Webcam
  iSerial                 1 80B912DF
  bNumConfigurations      1

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_driver.c | 9 +++++++++
 drivers/media/usb/uvc/uvc_video.c  | 8 +++++++-
 drivers/media/usb/uvc/uvcvideo.h   | 1 +
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index c1e3c1fab976..eae88d0f420e 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -2569,6 +2569,15 @@ static const struct usb_device_id uvc_ids[] = {
 	  .bInterfaceSubClass	= 1,
 	  .bInterfaceProtocol	= 0,
 	  .driver_info		= UVC_INFO_QUIRK(UVC_QUIRK_RESTORE_CTRLS_ON_INIT) },
+	/* Logitech HD Pro Webcam C922 */
+	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
+				| USB_DEVICE_ID_MATCH_INT_INFO,
+	  .idVendor		= 0x046d,
+	  .idProduct		= 0x085c,
+	  .bInterfaceClass	= USB_CLASS_VIDEO,
+	  .bInterfaceSubClass	= 1,
+	  .bInterfaceProtocol	= 0,
+	  .driver_info		= UVC_INFO_QUIRK(UVC_QUIRK_INVALID_DEVICE_SOF) },
 	/* Chicony CNF7129 (Asus EEE 100HE) */
 	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
 				| USB_DEVICE_ID_MATCH_INT_INFO,
diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
index 710165502b5b..ecd3c1292182 100644
--- a/drivers/media/usb/uvc/uvc_video.c
+++ b/drivers/media/usb/uvc/uvc_video.c
@@ -541,7 +541,13 @@ uvc_video_clock_decode(struct uvc_streaming *stream, struct uvc_buffer *buf,
 
 	stream->clock.last_sof = dev_sof;
 
-	host_sof = usb_get_current_frame_number(stream->dev->udev);
+	/*
+	 * On some devices, like the Logitech C922, the device SOF does not run
+	 * at a stable rate of 1kHz. For those devices use the host SOF instead.
+	 */
+	if (stream->dev->quirks & UVC_QUIRK_INVALID_DEVICE_SOF)
+		dev_sof = usb_get_current_frame_number(stream->dev->udev);
+
 	time = uvc_video_get_time();
 
 	/*
diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
index 22656755a801..699c33bc24ed 100644
--- a/drivers/media/usb/uvc/uvcvideo.h
+++ b/drivers/media/usb/uvc/uvcvideo.h
@@ -73,6 +73,7 @@
 #define UVC_QUIRK_FORCE_Y8		0x00000800
 #define UVC_QUIRK_FORCE_BPP		0x00001000
 #define UVC_QUIRK_WAKE_AUTOSUSPEND	0x00002000
+#define UVC_QUIRK_INVALID_DEVICE_SOF	0x00004000
 
 /* Format flags */
 #define UVC_FMT_FLAG_COMPRESSED		0x00000001

-- 
2.39.0.314.g84b9a713c41-goog-b4-0.11.0-dev-696ae
