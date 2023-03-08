Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10CC16B1580
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 23:46:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbjCHWqG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 17:46:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbjCHWpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 17:45:49 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE81BCF0C9
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 14:45:46 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id u9so72030037edd.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 14:45:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1678315545;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V6VjwHdOuGql5ezgQLsLwwzSf/aEf2U+vKcsdfzTDiY=;
        b=VrXoYlQp6ATF36g5gniyRXPT8ngc6BrdLdXwh/puwzg1HTf4DGSeJmKoYppeByuNT5
         qeqLm+RIozb9sHOodcp6OpScZ5+Bq2Tip0h3yzkBZrdUixFFw0R64blDL+FwAKynERlR
         R9oePfbuASWKuC0Q0hr1A1BdcoOgZK9gZdjzs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678315545;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V6VjwHdOuGql5ezgQLsLwwzSf/aEf2U+vKcsdfzTDiY=;
        b=pC5HCcO1WKIFyxyh9DeBvYpbB/9uq/yhrg0EpAKGSEMUCu6eglYFklSajMn0B2pFk5
         KvbKIAiC6fcZ09kpm4H8HOnFStYICGALQD/v/uDA3HpIjn4XOQr45CLJBAlWaXpQzgnY
         Csr08IHWacG7y3R97h9p3ch9GSrgIH0c9HDX4VQJe6JC59WvihkMJ0PYFX7x6g6CQPfm
         35fSvS9yDpaFeqTrcJwCgovYfThy/VfPoNnYI68dON346CMoLvPa/I/E6hrOCtzdgYS4
         39IDKy7UfQZPt5XubuE/glb2/EGa+4inTqVY6FpNZP/WPZymS3M1bTBewsltBfVi6H4t
         3Vew==
X-Gm-Message-State: AO0yUKVNOd/hXkKgxVzIowRI5yRRhjy5Yz49sIqLyzzq4nycu+vo/lOZ
        StnSvKL5WxYWWbXuc25VmuJjHQ==
X-Google-Smtp-Source: AK7set9LtxhxFK35AFbfY306qcZ6FF974Uo6u18utBZ8tzKWtNjD3dbaEBvXTOosgADyLpdhkkoYaQ==
X-Received: by 2002:a17:906:d9c8:b0:8e1:cc38:6ab0 with SMTP id qk8-20020a170906d9c800b008e1cc386ab0mr17630864ejb.16.1678315545101;
        Wed, 08 Mar 2023 14:45:45 -0800 (PST)
Received: from alco.roam.corp.google.com (80.71.134.83.ipv4.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id ot18-20020a170906ccd200b008e40853a712sm8040167ejb.97.2023.03.08.14.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 14:45:44 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Wed, 08 Mar 2023 23:45:33 +0100
Subject: [PATCH RESEND v5 2/5] media: uvcvideo: Quirk for invalid dev_sof in
 Logitech C922
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20220920-resend-hwtimestamp-v5-2-139d1a144614@chromium.org>
References: <20220920-resend-hwtimestamp-v5-0-139d1a144614@chromium.org>
In-Reply-To: <20220920-resend-hwtimestamp-v5-0-139d1a144614@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     "hn.chen" <hn.chen@sunplusit.com>, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=5228; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=9d83K9VEn5BR8bzm9yb8kPpgmV29vXBGj2CJMG3gKUQ=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBkCRAQxNj++KUZcM4H+69gz2NIx/W+XgLjafjtG49n
 VB+dDA+JAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCZAkQEAAKCRDRN9E+zzrEiM3gD/
 0bqfO++Qt1wc2nXVF6swkS9BT9t8uYJs5wDwl7JLpq8Tndrw+m8M8dyfCGtfdiqoGTOSIfzl1FDdbM
 MgIn7Nf57duW3IzTaJE2h95kAG0Unfa4nQe4OOvIKRIYBuc/+FynyNsQvV2qxr6CAFVR1VqHetQLMX
 hNVb+TjvTabGOk/bAm6X24nLN9qGIHCiLkJfKhf3rZwQcb+0+kmIeq2nOB0ky5ryRcILJnVFuZ6btW
 R5UCS9Euph5kw3pwa0IKV+dDZ+4ytyqAiPcZZBxFir14xymzn7avlSe+jLoFG7PAtFFJyXoIDp/CbY
 1vTfSfPKpylxtMfWXm7ZeOUfE6aTnfXPFjU2Dhizfgt4c+GOrUfse/gXpgsZkLqig92why7T8/ucEh
 r/PPUTzwD4BSnTy2N8wiK+yy+BLMej/ZgLyMccO1PJ9K7p9+0OJ30M0U2mVoVBaFMbt38MDQEIlaOH
 T5uO8VxPjOnhCAFDBN+ssZhX9zhCpRqs6HokJoJfHhDpklSAyt9bE5YNpeJIVhdO9fAY9+xsuY73zc
 9vYr41etLTF0BRJFTAzT5ACcnQn0nzu4Et/8V8ZqRELv36Aw0Nfl8Gv9gVEdHZ+vAIV3+uNsm5PyzR
 pHyOGTxnMzcGXdWBSt7ShSrI38oZEW2koGou/BXyjpvP8jQVaq+z0VvmkY7g==
X-Developer-Key: i=ribalda@chromium.org; a=openpgp;
 fpr=9EC3BB66E2FC129A6F90B39556A0D81F9F782DA9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
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
index 488c58bc9919..f4470f6df45c 100644
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
2.40.0.rc0.216.gc4246ad0f0-goog-b4-0.11.0-dev-696ae
