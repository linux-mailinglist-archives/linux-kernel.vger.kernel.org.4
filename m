Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66CD36BB299
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 13:37:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232905AbjCOMh2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 08:37:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232796AbjCOMhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 08:37:07 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2820C11170
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 05:36:13 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id r11so23249189edd.5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 05:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1678883760;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a5a+6HYmuNF0NcA/SU/mW3fBSurTLFx+qA7YB8EkD48=;
        b=TfofS92aM3t+JFhoqROgiTjIq0jxa93bnsEDcIQ3QXRB+58Zz14DE0GNoujVgb4+m7
         IB9dA3JlDyD7Nh8XWW/yfQXDZe6NjGEqACM5Rrql+Hx1Yg/aIraE8zmy0DoAhz/K1NzR
         7JlcZ2wpwY9mJdzGkSd9nu4WM6+U0/IXW7FuQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678883760;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a5a+6HYmuNF0NcA/SU/mW3fBSurTLFx+qA7YB8EkD48=;
        b=yUWCPYNY0FUFLQEA9KzwYAVQqzUnJHHJ/yqv5yso8PprLvMKHtlqNufdF0PEzL1eMe
         CW7uNiDx+31aoMnku7OzQeKqfoY05pkBLKd2gooUbVWVF4Qiurht2lUHsQ9ytHcUv90Y
         +FnZo1o8DFF8+bgpskHrWoy0951Au77NWp7wpx4zlXiduOJydMpMo1F9xZT6dJmlQ3vZ
         EpDFQYOhgf/V/P/LxJBjgC5pR3aPLUr1X56qjdlP27zlWQZY3BfBJO86IT7fo6kEuZgZ
         aS05SgnQkGysmGl+tPuFxG9dT4n8JRUvsrUaFSwuzLEmW52GRaVrDWMT49Z2pKYPusjZ
         IZDg==
X-Gm-Message-State: AO0yUKUJrOJ9CeLE+MGIMbezW9ZCxlOJDztt0nmYrt4ZB0B2e3ep71Ka
        QntzaiW37tpKsSL/mX7c1WtAKQ==
X-Google-Smtp-Source: AK7set9WBp6LVVjVCMkds0kT0iLc+eIuQkuzsRfQeDsDmuq3pnPOZ9kuFDK9V6rqRO9de7KKfIWCZg==
X-Received: by 2002:aa7:ca47:0:b0:500:2cac:3329 with SMTP id j7-20020aa7ca47000000b005002cac3329mr1248646edt.25.1678883760681;
        Wed, 15 Mar 2023 05:36:00 -0700 (PDT)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:491c:f627:27f0:1c4])
        by smtp.gmail.com with ESMTPSA id w3-20020a50c443000000b004c30e2fc6e5sm2363256edf.65.2023.03.15.05.36.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 05:36:00 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Wed, 15 Mar 2023 13:35:39 +0100
Subject: [PATCH v8 3/6] media: uvcvideo: Quirk for invalid dev_sof in Logitech C922
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20220920-resend-hwtimestamp-v8-3-0edaca2e2ab3@chromium.org>
References: <20220920-resend-hwtimestamp-v8-0-0edaca2e2ab3@chromium.org>
In-Reply-To: <20220920-resend-hwtimestamp-v8-0-0edaca2e2ab3@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     "hn.chen" <hn.chen@sunplusit.com>, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=5234; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=5jcOY5wQypEMPaIWclRrjn20dOHGC/hJF48i1+E0AwQ=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBkEbulUiqmYpWtNuGB9bQfwlYymNh5sVmuJd56u76B
 HHdVHgGJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCZBG7pQAKCRDRN9E+zzrEiN7QD/
 0cCJGm26Krcn10L6qxOEGqDuvZS48ItbE4y3r2ymblCK6XQQJPS5j2aLv6Q7DVM5bsM9QG5MRV68Wr
 vWd8odmHvJtlAkwYQBXImk5vRRmKKIodA1kwFaaOUXu5UZFx5qRB/QKua8l8Htjq3B0N0Hwl5H1BbR
 W8euNmEIZ4pvLN5IkcNVL3FX0WaWIaSkjSNi6+r53y9aUoJq/aF1+OUZAf0u8Dp9IG5047yIr5Zxra
 vLUq6pj+xH3PFvflfW9O/wAku4HhsOt5UrbWS72LeCv0NPEx7W+hUO2gjFvdWV/oUnBTQKwEmIbah0
 JZ2DQokwxKRk1hwICauU/98cT2AzMzF/hFe/EDmfCYqyJqwxgiec3PH0HhOI02/j/qpHHNWGsp7Gat
 c01vgCjoe8+5kEby09tV1i/nJe9HO3VeZkb0Cy6u7fu15vX5TVaDusDzgSgiB0w7jhIHrpa3svNHPN
 dj4o5/su72VBL9x7CU5k4SQx3ep0tLNnTaqETwYrJnorikIs06ueoZ30GAXTNETBsjA+Yf2I+jQa3B
 vrZhneG7ZgJRstIbTkECiuGIDImD222soCR/U4MvriujA8gPy9kv2ZlqJp4yew90shVZIzeXSdr5qB
 1XMsvGJEbst/QxoAyEYrG4X9XIewM6cWhpy4KG8oTbtzMPS+0lWyUW0JYcsA==
X-Developer-Key: i=ribalda@chromium.org; a=openpgp;
 fpr=9EC3BB66E2FC129A6F90B39556A0D81F9F782DA9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
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

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_driver.c | 9 +++++++++
 drivers/media/usb/uvc/uvc_video.c  | 8 ++++++++
 drivers/media/usb/uvc/uvcvideo.h   | 1 +
 3 files changed, 18 insertions(+)

diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index 7aefa76a42b3..678a5736c9df 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -2549,6 +2549,15 @@ static const struct usb_device_id uvc_ids[] = {
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
index 1f416c494acc..4d566edb73e7 100644
--- a/drivers/media/usb/uvc/uvc_video.c
+++ b/drivers/media/usb/uvc/uvc_video.c
@@ -547,6 +547,14 @@ uvc_video_clock_decode(struct uvc_streaming *stream, struct uvc_buffer *buf,
 	stream->clock.last_sof = dev_sof;
 
 	host_sof = usb_get_current_frame_number(stream->dev->udev);
+
+	/*
+	 * On some devices, like the Logitech C922, the device SOF does not run
+	 * at a stable rate of 1kHz. For those devices use the host SOF instead.
+	 */
+	if (stream->dev->quirks & UVC_QUIRK_INVALID_DEVICE_SOF)
+		dev_sof = host_sof;
+
 	time = uvc_video_get_time();
 
 	/*
diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
index 9a596c8d894a..07b2fdb80adf 100644
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
2.40.0.rc1.284.g88254d51c5-goog-b4-0.11.0-dev-696ae
