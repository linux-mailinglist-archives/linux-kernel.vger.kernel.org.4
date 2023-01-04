Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85EFB65D0E5
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 11:47:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239060AbjADKq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 05:46:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238971AbjADKp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 05:45:58 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1649F1DDEC
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 02:45:55 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id qk9so81383048ejc.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 02:45:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gRp2ESW5K70RCahtEssFSxztB7FTiNHqVBi6bMAAfN0=;
        b=goF6AiDvnYbQdClvRAdQ8ZRJtb29M81IkMrW8uWcNGwo/bkrFOzzOJXIUDVAxPREWw
         1S6W1sbAt/vCPsPF2sr8vThV4OG+IJPoE/h7ZlurDsZ1XvPsvcZ7lnwzsAn1Zs+cJhiK
         l0xKX5drhYqI+MPgCWwwptAwlTGs8pSC21dm8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gRp2ESW5K70RCahtEssFSxztB7FTiNHqVBi6bMAAfN0=;
        b=KMT1qpls46s3oWPcX9v1Dsmy9srCpZMPcdkbOa6dUFRmWfIpc5Q5NAcpJFLacH/cs1
         hdCmF88AFlBkUSctN0bkrAStDE3XFhoae/NP8Ezb1n/Lss4scD0ZkaASLL/E+d6egYEU
         mwc1A836h8pFAwf0qm56DatNNLACUKZABNKm0pnDgycKsoEM51bQffRo9eiuEbeVab+F
         Ca0Tp/1BXIpOZnIx9OqvF+vy1EV4Nu46i0cF93n3Rbx2ujhppyA09beGjOxXOg6z4wzR
         6OGtasDr0XIV7UGwPC8mrNv4ZrauLjiaJ9bDLF0DTn+TCwDrmAHvRvR2nXCJ2/kqfZvm
         F52A==
X-Gm-Message-State: AFqh2koxYFEBIuZLmUC4Ucv82RwzkXcC1Pkwdqb2lx5dEepLy1D6RY/p
        YGqXVsevucszr4yhnYbqALt/IQ==
X-Google-Smtp-Source: AMrXdXtUFnl1G93vkeP1yndia2ZiRlOK+d8uJKXWhkXHHEnrutxtRmkU9/YbgfadCRkhmZyeNW6M0A==
X-Received: by 2002:a17:907:3e26:b0:839:74cf:7c4f with SMTP id hp38-20020a1709073e2600b0083974cf7c4fmr54279545ejc.8.1672829154194;
        Wed, 04 Jan 2023 02:45:54 -0800 (PST)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:6531:9bb0:b3f7:86a8])
        by smtp.gmail.com with ESMTPSA id g32-20020a056402322000b0048c85c5ad30sm4754971eda.83.2023.01.04.02.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 02:45:53 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Wed, 04 Jan 2023 11:45:23 +0100
Subject: [PATCH v3 5/8] media: uvcvideo: Quirk for autosuspend in Logitech
 B910 and C910
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20220920-resend-hwtimestamp-v3-5-db9faee7f47d@chromium.org>
References: <20220920-resend-hwtimestamp-v3-0-db9faee7f47d@chromium.org>
In-Reply-To: <20220920-resend-hwtimestamp-v3-0-db9faee7f47d@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-kernel@vger.kernel.org, "hn.chen" <hn.chen@sunplusit.com>,
        Ricardo Ribalda <ribalda@chromium.org>,
        linux-media@vger.kernel.org
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=5515; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=d2H8jjlMxjzySDZwcfIgLwXk3Cr5F/h5s+x9I3bWE88=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjtVjXz8kkXnHCmaWyDVSboiRLq0QT5Ep169Pi7gyL
 TJXvml+JAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY7VY1wAKCRDRN9E+zzrEiNIeD/
 9rKtvE53i8gHnZbPspMqCE+Y84MThWbpgpi1DDnNk3/JdQfNeQoE2PxEowHC9MiuX1P3jatlI7+q5X
 qFJ8FdHyfdkSbHlOHRTAlREru5ocoKV92thfQAoK9mPFhsQNRJkwnbClm6UzMUuv6Gza6IAtKCMRxO
 WtOYjjKy5KF2AnDIv0o4/bc0Tgk8jMUlX9FJd5gOgvu7Url6gAJjY8A0ZD5SSVK5qrShwPoc5s64VG
 0AorD0b/rDyquKmz5pZRFjv7wqc3tz9p2S0lQcLK4csIZb94ZgG6OfjjfSeGBAF2IQwNZ+09ZyMOqm
 jKORQM1xnO6fd0k2QRcKUI5WZd81UOZaaWA6PdwVT7vzgptYI1lxNBKsFt/zEaN27/djwYQugQYB8C
 Hza/ehEBthDavNQAAkiVTrSQvqhzc6ULiqYEc4tfFeIIj+mKz/fHThmKzcLliyePxkf3KYLoLC+TQ+
 A/wu75vwwyIlZxRZYV7EJFo0nj48GNAOZda3AMW76gUuTCSGvpxsk1QEXijJ93vIDiKCHyQszaUxQv
 Cx7sjCz8MUrUPi7JrP12v79C9L5CLXnr3alfijHkOtVupcI7oEsc6IDzdjTdFseO35WFT9vw7f0ATH
 GIfo9YtOHDVmu+gQRQ1zpHuvxDyNLQztsjffC2FrM/uTTtq1b+5iuGIgIGrQ==
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

Logitech B910 and C910 firmware are unable to recover from an USB
autosuspend. When it resumes, the device is in a state where it only produces
invalid frames. Eg:

$ echo 0xFFFF > /sys/module/uvcvideo/parameters/trace # enable verbose log
$ yavta -c1 -n1 --file='frame#.jpg' --format MJPEG --size=1920x1080 /dev/video1
[350438.435219] uvcvideo: uvc_v4l2_open
[350438.529794] uvcvideo: Resuming interface 2
[350438.529801] uvcvideo: Resuming interface 3
[350438.529991] uvcvideo: Trying format 0x47504a4d (MJPG): 1920x1080.
[350438.529996] uvcvideo: Using default frame interval 33333.3 us (30.0 fps).
[350438.551496] uvcvideo: uvc_v4l2_mmap
[350438.555890] uvcvideo: Device requested 3060 B/frame bandwidth.
[350438.555896] uvcvideo: Selecting alternate setting 11 (3060 B/frame bandwidth).
[350438.556362] uvcvideo: Allocated 5 URB buffers of 32x3060 bytes each.
[350439.316468] uvcvideo: Marking buffer as bad (error bit set).
[350439.316475] uvcvideo: Frame complete (EOF found).
[350439.316477] uvcvideo: EOF in empty payload.
[350439.316484] uvcvideo: frame 1 stats: 149/261/417 packets, 1/149/417 pts (early initial), 416/417 scr, last pts/stc/sof 2976325734/2978107243/249
[350439.384510] uvcvideo: Marking buffer as bad (error bit set).
[350439.384516] uvcvideo: Frame complete (EOF found).
[350439.384518] uvcvideo: EOF in empty payload.
[350439.384525] uvcvideo: frame 2 stats: 265/379/533 packets, 1/265/533 pts (early initial), 532/533 scr, last pts/stc/sof 2979524454/2981305193/316
[350439.448472] uvcvideo: Marking buffer as bad (error bit set).
[350439.448478] uvcvideo: Frame complete (EOF found).
[350439.448480] uvcvideo: EOF in empty payload.
[350439.448487] uvcvideo: frame 3 stats: 265/377/533 packets, 1/265/533 pts (early initial), 532/533 scr, last pts/stc/sof 2982723174/2984503144/382
...(loop)...

The devices can leave this invalid state if the alternate setting of
the streaming interface is toggled.

This patch adds a quirk for this device so it can be autosuspended
properly.

lsusb -v:
Bus 001 Device 049: ID 046d:0821 Logitech, Inc. HD Webcam C910
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass          239 Miscellaneous Device
  bDeviceSubClass         2
  bDeviceProtocol         1 Interface Association
  bMaxPacketSize0        64
  idVendor           0x046d Logitech, Inc.
  idProduct          0x0821 HD Webcam C910
  bcdDevice            0.10
  iManufacturer           0
  iProduct                0
  iSerial                 1 390022B0
  bNumConfigurations      1

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_driver.c | 18 ++++++++++++++++++
 drivers/media/usb/uvc/uvc_video.c  | 10 ++++++++++
 drivers/media/usb/uvc/uvcvideo.h   |  1 +
 3 files changed, 29 insertions(+)

diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index c89a1eebe91c..be6ad9b732a2 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -2525,6 +2525,24 @@ static const struct usb_device_id uvc_ids[] = {
 	  .bInterfaceSubClass	= 1,
 	  .bInterfaceProtocol	= 0,
 	  .driver_info		= (kernel_ulong_t)&uvc_quirk_probe_minmax },
+	/* Logitech, Webcam C910 */
+	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
+				| USB_DEVICE_ID_MATCH_INT_INFO,
+	  .idVendor		= 0x046d,
+	  .idProduct		= 0x0821,
+	  .bInterfaceClass	= USB_CLASS_VIDEO,
+	  .bInterfaceSubClass	= 1,
+	  .bInterfaceProtocol	= 0,
+	  .driver_info		= UVC_INFO_QUIRK(UVC_QUIRK_WAKE_AUTOSUSPEND)},
+	/* Logitech, Webcam B910 */
+	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
+				| USB_DEVICE_ID_MATCH_INT_INFO,
+	  .idVendor		= 0x046d,
+	  .idProduct		= 0x0823,
+	  .bInterfaceClass	= USB_CLASS_VIDEO,
+	  .bInterfaceSubClass	= 1,
+	  .bInterfaceProtocol	= 0,
+	  .driver_info		= UVC_INFO_QUIRK(UVC_QUIRK_WAKE_AUTOSUSPEND)},
 	/* Logitech Quickcam Fusion */
 	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
 				| USB_DEVICE_ID_MATCH_INT_INFO,
diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
index bc75c7c40251..fe5c7b465adf 100644
--- a/drivers/media/usb/uvc/uvc_video.c
+++ b/drivers/media/usb/uvc/uvc_video.c
@@ -1984,6 +1984,16 @@ static int uvc_video_start_transfer(struct uvc_streaming *stream,
 			"Selecting alternate setting %u (%u B/frame bandwidth)\n",
 			altsetting, best_psize);
 
+		/*
+		 * Some devices, namely the Logitech C910 and B910, are unable
+		 * to recover from an USB autosuspend, unless the alternate
+		 * setting of the streaming interface is toggled.
+		 */
+		if (stream->dev->quirks & UVC_QUIRK_WAKE_AUTOSUSPEND) {
+			usb_set_interface(stream->dev->udev, intfnum,
+					  altsetting);
+			usb_set_interface(stream->dev->udev, intfnum, 0);
+		}
 		ret = usb_set_interface(stream->dev->udev, intfnum, altsetting);
 		if (ret < 0)
 			return ret;
diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
index 88d1790e6695..24c3e9411415 100644
--- a/drivers/media/usb/uvc/uvcvideo.h
+++ b/drivers/media/usb/uvc/uvcvideo.h
@@ -76,6 +76,7 @@
 #define UVC_QUIRK_FORCE_BPP		0x00001000
 #define UVC_QUIRK_IGNORE_EMPTY_TS	0x00002000
 #define UVC_QUIRK_INVALID_DEVICE_SOF	0x00004000
+#define UVC_QUIRK_WAKE_AUTOSUSPEND	0x00008000
 
 /* Format flags */
 #define UVC_FMT_FLAG_COMPRESSED		0x00000001

-- 
2.39.0.314.g84b9a713c41-goog-b4-0.11.0-dev-696ae
