Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC1F617E2D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 14:41:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231770AbiKCNlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 09:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230509AbiKCNlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 09:41:12 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4173A15706
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 06:41:11 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id kt23so5297750ejc.7
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 06:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=htk03ZXZ6BAf5SUnfWVl749nCIvhsf9YeaZoa0SoAPM=;
        b=SjFd9ErndYOjcXEk0hTpVzTdyHToxYaYTpA7l0bvcx5tVKdkFEwHQWt0I+DU6VKBwg
         u19E4eiKwpnbggLVhsrNZHYg6qaFzuX4T09nsiKLCGU2V8+4neVBAC6y+EGyfL5e8GK0
         lAkvyraOPgRHT/3dsOnFxAdrLlyZVk0zlC5OE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=htk03ZXZ6BAf5SUnfWVl749nCIvhsf9YeaZoa0SoAPM=;
        b=eybDIcwYAtdmj7X1Oy3tjo60dIegAtgY565FVLqGbsZO9g0B2c7Cq9Rdjjyj9G5ACb
         g+XtyIDFRM60fP9ad99V/WXyOIICYQdUOP3q6fNs4gebTgV0/JLe7e2XypBveifXcocX
         BhnHx1v2l83tPHvXT1wb8GHxSTSIBtZ0/9nhumsHyEr82hpjCKeJBy6hEF4zv3bSictK
         81Qcr03jQLnZC8H97a0ixzBEeY1/9MpVhyEjPAB0S/4IFgYWpgD52/wDroqyNXGnTi3M
         HyRrGzXTEdiYUSy6ea0SEIxrp0y+7M0OUwOP1jRwDA74ApFsCYBoPaDEuMgiy73Uw0+X
         JDDw==
X-Gm-Message-State: ACrzQf0NqpLNWpNk9YrUv66Md731atggrK3IsqragG+9+N5LZsz3fjOf
        XPioxfZYr5OLnaIC0m1qS5MxYbtEtIiQZpYH
X-Google-Smtp-Source: AMsMyM5bLAUr/ricDOx9T3fsAJlXMSEulBKNx/oVpXqn/z/Ek5+f+efrwUT6YAQFpGQK4zoy5Vyo7Q==
X-Received: by 2002:a17:907:94c3:b0:78e:2866:f89f with SMTP id dn3-20020a17090794c300b0078e2866f89fmr28346552ejc.617.1667482869589;
        Thu, 03 Nov 2022 06:41:09 -0700 (PDT)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:c1a3:5bc:2068:8f2c])
        by smtp.gmail.com with ESMTPSA id j1-20020a17090623e100b0078d46aa3b82sm521948ejg.21.2022.11.03.06.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 06:41:09 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Thu, 03 Nov 2022 14:40:45 +0100
Subject: [PATCH v2 4/8] media: uvcvideo: Quirk for invalid dev_sof in Logi C922
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20220920-resend-hwtimestamp-v2-4-d8d0616bb612@chromium.org>
References: <20220920-resend-hwtimestamp-v2-0-d8d0616bb612@chromium.org>
In-Reply-To: <20220920-resend-hwtimestamp-v2-0-d8d0616bb612@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     HungNien Chen <hn.chen@sunplusit.com>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.11.0-dev-d93f8
X-Developer-Signature: v=1; a=openpgp-sha256; l=4699; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=BG95FdUi6it8kGTXeYjcquehpttCvGOKYvHHKrrROlo=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjY8TpMd8hENvZhIksVT+BMQIwXHICRbtXZQlg/ANe
 5f2aF62JAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY2PE6QAKCRDRN9E+zzrEiP3GD/
 44LZUefEi9TAgPcvJWUpPaQziUvRkG6Z0rdcqBKg9yt9UM8alMthgngLuhTSmJoJRKpJGVuIr9wGGo
 ROc9ld/ZXMJnsODJ4NbWLAHdldF6JEgQTKn2j+TpMG4mkqo0jW9ayOLqLEST2vdJaTvF/2dA8Cmm2h
 Ns/S/U/D6p0XrM2yBFhJK1SRmx6j4a8eFUhe3Pr2UBo+ZuVgAaQJ1N9Mc1REdGrth0lvEjdUiyv1dO
 g8DXleuHo83/kIbQnZY2W5Az0n78ec6jPhqt+CSJnynm6Jb8xQ2/8yxvXEj7DRyqxBD2lHfap38fmk
 L5KyLDHASkeadmcleLtOU1PTFWi+3aQuOWVOpp8vqykHxQgvugqvaqzp1/YG+kfobvJMAtUF9Pivk3
 O91Sbg8YlrglmI8V0yW8WPfeMt2jHUzjfPn2fmLSZ+JTvE5Z295S/tBWSsN68LptSR26x+aarInDlY
 123VT9VNxgmQHzWJWhEyhmfU6txLsoWvJrQcm+3CZjoJBgGbAkKrXxCB9flBO9sYgKi+PhocaKrkBv
 vwF/CnAl3cUUGuoXLVHsIUUiZPDYERHa/+0lDej3KYOEwoK/dirnFpUs0DG7FwcT/5Lccq8yTtePN2
 uQAUMPJ7uuSKX+XruL6rjDBZoaoVDK70k/gN8jhGBHQzITrCgt2S7HJCjA1Q==
X-Developer-Key: i=ribalda@chromium.org; a=openpgp;
 fpr=9EC3BB66E2FC129A6F90B39556A0D81F9F782DA9
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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
b4 0.11.0-dev-d93f8
