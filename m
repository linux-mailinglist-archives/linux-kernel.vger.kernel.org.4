Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC5A76BB4B0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 14:30:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbjCONaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 09:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232005AbjCONag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 09:30:36 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E0F091B5F
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 06:30:29 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id cy23so75448901edb.12
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 06:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1678887027;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a5a+6HYmuNF0NcA/SU/mW3fBSurTLFx+qA7YB8EkD48=;
        b=lkGXUzVfMNurFTpaDvb74x5w7jDczuCxdoDbMkv4itF7+EnifGtL5hT2whGNkBD+VZ
         JVgD5smdZm9pojK8aq6n+UbciMGKM+n4+JYa6HhruKyhL8kcIhTwJ8z2reGaPi59R26M
         nin4rOhjgVBOIhwgFLlCj8DoAhfkOFTuUzfGM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678887027;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a5a+6HYmuNF0NcA/SU/mW3fBSurTLFx+qA7YB8EkD48=;
        b=yf2kMTk+vZKIkDATms2wUyjtpiWPijSoEolSTXVt8hG0lZFQgqqDOLAu8XlgGQVXPS
         FzJMqoqajcETgBi2Tw5SZONvVFD8JV2cIIW+i3eGJO/ZM/RrR40KZo5nBdaJQKrHFLT0
         i1QtOLmbMUKqw7vmGYKIvrU1yd3H5m7gnFe1RpcdM5mPEcthofLyWMmHKR/Z4Ve98BU6
         p0Dk4BECCqFOG5zxnbe6iwvt1UZWKWgB0+AwNTEw9ZpNhZel8gv2b49cjJKsFJg83xaY
         rCZx1e5Al5O8Y/TXFzIcW43k9/ElyrBWWevJIs3f7WpNvmseYMHgoEO0HbVMwe45kSgI
         2JOg==
X-Gm-Message-State: AO0yUKX57MV6N9SIklvmthGC9PUrJHyQzP9/NKKKRUr7rt3XmNB4kiQF
        1hzaP9FUwU0bu+xVK+ja9+0r6A==
X-Google-Smtp-Source: AK7set+Y+ixY6taQhbbIK2VWuMtXw2FdV+VTQLCwuvzqPYLgqov+sbS5JY9czYKaYCnSbxxxCYSjGw==
X-Received: by 2002:a17:906:17ca:b0:8b1:76ca:f228 with SMTP id u10-20020a17090617ca00b008b176caf228mr6039405eje.39.1678887027610;
        Wed, 15 Mar 2023 06:30:27 -0700 (PDT)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:491c:f627:27f0:1c4])
        by smtp.gmail.com with ESMTPSA id ha11-20020a170906a88b00b0092043ae1a8asm2534638ejb.92.2023.03.15.06.30.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 06:30:27 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Wed, 15 Mar 2023 14:30:14 +0100
Subject: [PATCH v9 3/6] media: uvcvideo: Quirk for invalid dev_sof in Logitech C922
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20220920-resend-hwtimestamp-v9-3-55a89f46f6be@chromium.org>
References: <20220920-resend-hwtimestamp-v9-0-55a89f46f6be@chromium.org>
In-Reply-To: <20220920-resend-hwtimestamp-v9-0-55a89f46f6be@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Ricardo Ribalda <ribalda@chromium.org>,
        linux-kernel@vger.kernel.org, "hn.chen" <hn.chen@sunplusit.com>,
        linux-media@vger.kernel.org
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=5234; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=5jcOY5wQypEMPaIWclRrjn20dOHGC/hJF48i1+E0AwQ=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBkEchqFy31rdemB9D0huME7IsTEWnrnkF2YuRPmJwl
 +6uiHROJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCZBHIagAKCRDRN9E+zzrEiEQaD/
 4uYq2DW4edlL96kv3i1Hy2R7ZRLYbLh1nDeP6WpArdUMsIr/g/Im81vRErUGYEDEhN+kXAcaNUB99s
 F4k0gWxZt+en5y1wqzbRuVsKUKuoG3JGIhJGIGOM0eg+apLSPa81ycrrHF3HZhVndNtggQ0v/+YH/a
 uFfC5ecHJKsUBsjO/+2XfSnnHxqz6IH7zD77H1eXehcTP70PwvAjlF2Q4ckmMz1zueGgpy4+lVd1Zp
 Ufnmc1bZuCMzYL9ReCUJ827WQgmvflNsL7WQowEKZ13d+O2jp8J7yfFadtSVcJyWPUt+0UHi9cWSxd
 MSZxWQ+p5tbRjElPtY4olYxLivCt87uYcEoTIxIh4lL/K39w0cUZjw1oVPipzUnTlnbGiKFTsDArgy
 IEZcKk1D2GekdoZ8ml5tLbsr8Tgqq6cp7auNUm1fId/MCpLhClf/TgGM7kRJxb0mntvhqF8kPYMnX0
 HHxaH8OZK8F5/P3NSeNKJNRnQVaZtAldT8f2QAkDEwgPA5P9rJbp0SHJ/KCMTn7NesHZUuYy280TdH
 qFWVUfAXhVjdAr9zH75cZSdlLWKlftIIkI+MIfw5Ap3CTfP3M/o1rYEXnTenOf2Jrn3F9FFjl8Y60W
 K9Kse57pCuBprkYYUWG/E1QwDgoogoo3hhvnZvPo37fqUuyHb4QIR+g6F/Aw==
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
