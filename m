Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F46365D0E7
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 11:47:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234903AbjADKqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 05:46:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238902AbjADKp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 05:45:56 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF71C1743F
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 02:45:54 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id l29so40935347edj.7
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 02:45:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5iccy1mOhkEmE1PLN3U2ExlldVmSVxYcFcoIeCsEwlQ=;
        b=f2Fztr7JuvNC7senkDZqqw01nLMiialjzNpFdhL3P35iDCjDHMI2FmyvKXBrPFUooa
         ELqmg5MgZh+7/nlB5Gcp3EpFR1PMKZpp5xxxdnAzm6i5O08c4OFWD9p9MJokT9Zi7EJZ
         Z/XAjglDNpQVaSXdi9XDNgNYcRM31UEEOB1hI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5iccy1mOhkEmE1PLN3U2ExlldVmSVxYcFcoIeCsEwlQ=;
        b=FuP5jVjIjKJGt5e+hcUiHLkPlf1AQFRhFodlsW8GfkEKJ7LGt8ZvvMnWKbhWyv4N+u
         +tlyaGNPu2+E5vP94/RB8zKhxfsFZWqM1MSSOTICvV7+1yHfBiyO9+bqKb7f4vSIdDEi
         aJ6zh+Bn/Rsxoqddl2s1DDKWi1Z5O5cTVyBLhIc9v0bO9YDKNixVFropMmUa5/UZyQAE
         naWlTloIPVhk2ayLM5edaDWBATl6nkt7yWz+Tx7paOG1QbbBRBqUwWZHaYTMDFVDG8bp
         LL/h/H0IiAFgG+68vNji+xQ7ghYrJvTXcweueknRNiQmfFOZ7biYEbeexrcOLFmDF5uQ
         UIqw==
X-Gm-Message-State: AFqh2koSQOiPBZWaRf5DXYPkQ1ph8H0DraZPCpbm7nkjpIZsEO16JjGm
        86XCVUK0mpG+Oj15+79Mgwolgw==
X-Google-Smtp-Source: AMrXdXtWxwOiWbwJeR6bi2nidVcMqzT4zxVVPGs6v+/ng2Sh2/7tB9Eyhyh+jJ6RxmDayctbl5dpcQ==
X-Received: by 2002:aa7:d04d:0:b0:47d:b4e6:a631 with SMTP id n13-20020aa7d04d000000b0047db4e6a631mr40858113edo.7.1672829153476;
        Wed, 04 Jan 2023 02:45:53 -0800 (PST)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:6531:9bb0:b3f7:86a8])
        by smtp.gmail.com with ESMTPSA id g32-20020a056402322000b0048c85c5ad30sm4754971eda.83.2023.01.04.02.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 02:45:53 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Wed, 04 Jan 2023 11:45:22 +0100
Subject: [PATCH v3 4/8] media: uvcvideo: Quirk for invalid dev_sof in Logitech C922
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20220920-resend-hwtimestamp-v3-4-db9faee7f47d@chromium.org>
References: <20220920-resend-hwtimestamp-v3-0-db9faee7f47d@chromium.org>
In-Reply-To: <20220920-resend-hwtimestamp-v3-0-db9faee7f47d@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-kernel@vger.kernel.org, "hn.chen" <hn.chen@sunplusit.com>,
        Ricardo Ribalda <ribalda@chromium.org>,
        linux-media@vger.kernel.org
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=5538; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=Wsf1Wp3a/Huhnb++hUSQ1p3B//D9EJZrjWECEqWLm0k=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjtVjUSO1A2pI3RH/4ObqEKNarKdcbkJdUKk8m9h3T
 UVYHYxeJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY7VY1AAKCRDRN9E+zzrEiK27D/
 41498SeqsUC94w2LA7j36W6bwiDzLolqi+vDLu9sI5fzW/YDVWnyEQxf0nEEtJdtxQg5qtjBMyt7ik
 IvQYYLBAc2fWYpvXs8RUtWknNERPgnF2iSnLHMziVxkhYWbYZ0RMD+jEh+gtrAidA/GbBQ2jhDq5HS
 pey2zMubFZLlcULTvsL57dYcfuYIBahWJ+qI+XN0f4GNBDZh5g8Nw6mMAlDjRarcONkIYHlaI+AbNB
 mIrIb8/yhBwtanTC2NYqV20jvHTls5EFuzV2Ssgp/gZtnzW9BmsHOPoXK5BFEYSrhitsyRBJhM8GWx
 5lF2ml+hzKd1m4moijHq0i0aFfJXpBt0IzCFOr5shOfAS6kGscyVOuX5gsqYx9A1bQYeoBPNm4acXQ
 rhyPxYGICyo131Z6ggez62DcBAQJ0fwOXCepoZsYZmDHUB6/UBb/kVlzklyUfoxK5ZbUy579Y+8bYm
 JZBanaR3mKIO2TJS7+YaLDShtRulvvnZssfNtYSwMPRgZczXvoVENKnR/e7xk2dO7W9jUSJcTrUEAd
 yH7F2Hp+9fZp9ynTW1qWCM0Q4eD/I3YV7Jg0UjMGwY5LQC394Pfv9QbRjhzoQVFzrziwvAMcDtuc4H
 gQDF3fCwYDjT3lNG40ASuJm23GJE4SWASbqbtqpZyKzFOT0ZcEt50ElAaPEw==
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
 drivers/media/usb/uvc/uvc_driver.c |  9 +++++++++
 drivers/media/usb/uvc/uvc_video.c  | 11 +++++++++--
 drivers/media/usb/uvc/uvcvideo.h   |  1 +
 3 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index c5ab6e2d24c3..c89a1eebe91c 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -2582,6 +2582,15 @@ static const struct usb_device_id uvc_ids[] = {
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
index f469c62bedca..bc75c7c40251 100644
--- a/drivers/media/usb/uvc/uvc_video.c
+++ b/drivers/media/usb/uvc/uvc_video.c
@@ -530,13 +530,20 @@ uvc_video_clock_decode(struct uvc_streaming *stream, struct uvc_buffer *buf,
 	 * all the data packets of the same frame contains the same SOF. In that
 	 * case only the first one will match the host_sof.
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
index c3424ae29339..88d1790e6695 100644
--- a/drivers/media/usb/uvc/uvcvideo.h
+++ b/drivers/media/usb/uvc/uvcvideo.h
@@ -75,6 +75,7 @@
 #define UVC_QUIRK_FORCE_Y8		0x00000800
 #define UVC_QUIRK_FORCE_BPP		0x00001000
 #define UVC_QUIRK_IGNORE_EMPTY_TS	0x00002000
+#define UVC_QUIRK_INVALID_DEVICE_SOF	0x00004000
 
 /* Format flags */
 #define UVC_FMT_FLAG_COMPRESSED		0x00000001

-- 
2.39.0.314.g84b9a713c41-goog-b4-0.11.0-dev-696ae
