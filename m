Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9193640BA7
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 18:03:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234392AbiLBRD2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 12:03:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234263AbiLBRDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 12:03:06 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB43B67217
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 09:03:04 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id e13so7230923edj.7
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 09:03:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lx0RTwbeF07JW5ZW7wkjZkyoNyHqWh3JjIKMCtW0xFs=;
        b=Q0BXyVxGC04ZBN43ZmgHVsV2ENEz3uNs5dN0tnRmaOqfDcdwgb1mIuFXyb1sTmKXMC
         9UWDUYn9wSJfi3oRQuSgJFtf4CL8YicgTCkK6Q/LZgIwVe5Ifj5P0eHEj8We7j221b2o
         ekkFERis8zlYXF6hONPczkPBZgvS0Dla31oIc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lx0RTwbeF07JW5ZW7wkjZkyoNyHqWh3JjIKMCtW0xFs=;
        b=5CD4erVa0REbrQlMeMr3jhg+Jv0LhdfrfKEyD1NNMupMM5qr5SNE/roFTBuu2iEUTz
         oMo+erawHjRpQ8pNPgYsuFhriiWdI/MAnoCpj/aVoaWX9uQKmQwYtErCw6kaTfhn2YW7
         9I4v7BzoJpnDK7C1wRMSNdBM/Xk0KRWFcSph1D/lYUHBWG7SUztgQVJW9ttqj2IAmxEt
         iWTSidMiy6xaoA6znA2Wcrn6wOTz5tOgUawVJaFN7tHBgng4ppj/basBDDJUlu7jKSVo
         rfccVHNJy6WCL1142gQgdrHlE56PpZQntIJoT77/Z56Y7sRY5FUuqFkRO00SOgKapz6P
         11/A==
X-Gm-Message-State: ANoB5pn06FcmZNUg/mlA2PXxaBA2ylNo1Q2iBOzOs22tz0ECr59QFqBH
        21tOCMLrQ1Ied0bQqqeMSha8dA==
X-Google-Smtp-Source: AA0mqf4q0sbghPWT/ao8+lEAWXg07S1DilOZGtE48QLxxBSoVjHWdW4/whl/ERYkyo973iRwUd/xPA==
X-Received: by 2002:a05:6402:5519:b0:461:e3f2:38bc with SMTP id fi25-20020a056402551900b00461e3f238bcmr55588823edb.149.1670000583256;
        Fri, 02 Dec 2022 09:03:03 -0800 (PST)
Received: from alco.roam.corp.google.com (80.71.134.83.ipv4.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id sa22-20020a170906edb600b0073d7ab84375sm3249133ejb.92.2022.12.02.09.03.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 09:03:02 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Fri, 02 Dec 2022 18:02:44 +0100
Subject: [PATCH RESEND v2 4/8] media: uvcvideo: Quirk for invalid dev_sof in Logi C922
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20220920-resend-hwtimestamp-v2-4-0d7978a817cc@chromium.org>
References: <20220920-resend-hwtimestamp-v2-0-0d7978a817cc@chromium.org>
In-Reply-To: <20220920-resend-hwtimestamp-v2-0-0d7978a817cc@chromium.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     "hn.chen" <hn.chen@sunplusit.com>, linux-media@vger.kernel.org,
        Ricardo Ribalda <ribalda@chromium.org>,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=4938; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=CXXqj68dbKHxKKYxVvCObfRHe2J96ojRxuGidUgj7F4=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjii+7hkWADKT+kFyE0yUtny4/lV/mcvdYK9d63u6m
 ndKhSOGJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY4ovuwAKCRDRN9E+zzrEiNkxEA
 CCRQKBg62it0U3/7hc9gW6lfXAWNdhksJcn/l0I99NsevhUmMPhWe9tREUHjlZhiBibsEf6wqNDqWD
 c3ZhdrRU6H4t4oBEi0EhmU6KXLs2MfZHnNAW3iF+yqYqzrNipqh/FP3HGjByPdsZuyhnaXtPMyhlpw
 PdvVFETjuEQlwpT1SRUYW0Mibal9x56jERM9tAVU8NMDVETUpX6o4lfaYH9W1IApWJ1MEa/c9M10ON
 16qyJ2Jr6aoylbB5ji2bG0UDwrktJoOYRZB2ze7vCTJD2CVvvbIn5950+kbexh/gNYG7cNg2gMyqxz
 LRaVkVe04lUh7DxFaeoAgmqoLmCLFGCInYhuyG21SlSiFtpiooPHuThhuiv1wXlvOksEEnTcvY7Lr0
 dFP8MFAmrWELd7Be5MvWRw3Iu/2VE8xGYQvbrJstaSrGSowhfh0xgzA+OpXI2UjTIw9J+Qp97hxEmS
 TiMxjb00faZFwnago/YfIr778vU4TXv2Pdxy2oI94jZWHLRgYbe1//nu1fa3rOrQcaGQrByHagN+7r
 JSVAE5ZI7x04VE90O+TqMX34Y8qSNhyNlhDgOfu28OpxbOp0Mymu9sC/14Jd2dEWuL4FBst2LKF5GM
 qh4bukTXXuiJRNjIrQVFvizT/q5BlpdSrQLuVoAJRLMNhwSDaDwWd3c7s2RQ==
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

Logitech C922 internal sof does not increases at a stable rate of 1KHz.

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
hardware we take the assumption that the package handling jitter is
under 2ms and use the host_sof as dev_sof.

For the hardware tested, it provides a much better timestamping than a
pure software solution:
https://ibb.co/D1HJJ4x
https://ibb.co/8s9dBdk
https://ibb.co/QC9MgVK

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
 drivers/media/usb/uvc/uvc_driver.c |  9 +++++++++
 drivers/media/usb/uvc/uvc_video.c  | 11 +++++++++--
 drivers/media/usb/uvc/uvcvideo.h   |  1 +
 3 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index 80ef0f0e04b0..4512316c8748 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -2880,6 +2880,15 @@ static const struct usb_device_id uvc_ids[] = {
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
index a5b184e71ad7..d387d6335344 100644
--- a/drivers/media/usb/uvc/uvc_video.c
+++ b/drivers/media/usb/uvc/uvc_video.c
@@ -529,13 +529,20 @@ uvc_video_clock_decode(struct uvc_streaming *stream, struct uvc_buffer *buf,
 	 * data packages of the same frame contains the same sof. In that case
 	 * only the first one will match the host_sof.
 	 */
-	dev_sof = get_unaligned_le16(&data[header_size - 2]);
+	if (stream->dev->quirks & UVC_QUIRK_INVALID_DEVICE_SOF)
+		dev_sof = usb_get_current_frame_number(stream->dev->udev);
+	else
+		dev_sof = get_unaligned_le16(&data[header_size - 2]);
+
 	if (dev_sof == stream->clock.last_sof)
 		return;
 
 	stream->clock.last_sof = dev_sof;
 
-	host_sof = usb_get_current_frame_number(stream->dev->udev);
+	if (stream->dev->quirks & UVC_QUIRK_INVALID_DEVICE_SOF)
+		host_sof = dev_sof;
+	else
+		host_sof = usb_get_current_frame_number(stream->dev->udev);
 	time = uvc_video_get_time();
 
 	/*
diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
index f395b67fe95a..e41289605d0e 100644
--- a/drivers/media/usb/uvc/uvcvideo.h
+++ b/drivers/media/usb/uvc/uvcvideo.h
@@ -213,6 +213,7 @@
 #define UVC_QUIRK_FORCE_Y8		0x00000800
 #define UVC_QUIRK_FORCE_BPP		0x00001000
 #define UVC_QUIRK_IGNORE_EMPTY_TS	0x00002000
+#define UVC_QUIRK_INVALID_DEVICE_SOF	0x00004000
 
 /* Format flags */
 #define UVC_FMT_FLAG_COMPRESSED		0x00000001

-- 
2.39.0.rc0.267.gcb52ba06e7-goog-b4-0.11.0-dev-696ae
