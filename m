Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35D8D640BAA
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 18:04:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234245AbiLBRDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 12:03:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234277AbiLBRDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 12:03:08 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C1AA2BB
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 09:03:07 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id s5so7225537edc.12
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 09:03:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8wywY3bthMlLRlkHC9RULQaRSbA1/GpUZvI3tR65/Ow=;
        b=fGc5xZMZuZ9U3eYxsjF36mFnj/PiUoC1WIEOBs1Gk9j+6Hbc2t0oyaXY/UGivhzNWu
         7RdBD378GNMXA2kiiUncq7jsriqmlSucrSU7zvcv5xAjkucWXmooyqMaYutlw2HWJE8E
         lI2kIwKEyb32ejCGXQdgPZf7ozlwEP80tOqIk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8wywY3bthMlLRlkHC9RULQaRSbA1/GpUZvI3tR65/Ow=;
        b=Lp+72Idfah5I4GXs8i5KEHkjk4GxXLFQQ915T4+T6bWbsMIWfpveM7cO9gInKjk5Wm
         vi/a78iu1Mp5l7kLNlQnP50TXp+S3Tb9jpa6xS3IVRGbe6uD176jnVnqXBXYJkGqLs7Q
         zxKcSIexrp8j7CrZn2tXjYalP7VxghSCmKYF0FkNK4EwkYsaABGZ52/5wFvWIPdqM/0i
         oC/SIFuUJ+qM5H6lzS6ziHkxntiwRyDuAB1KD8OHt72Yz8QvDH1UIaOh+3KH4TEpgdxp
         1SmIvIhZRJhZWyd05rwwJM9fo++CPwbi8Yvm7OoT74HCprumFJDXUf1PnRI/wwPLOHF2
         pYaQ==
X-Gm-Message-State: ANoB5pkxGpAYMvAjOVkagbkPgh5ILMbAPicEVP6rBCz4Fr6L7xvZop/A
        Th944VOgZepIgW+ClnhBrZs76g==
X-Google-Smtp-Source: AA0mqf4/BIvrSJvCRopYxquBpMDXn7itNaTpEXlHbPdHGkQxNIieaAuCV/olmRoXYPeq6wDReXI3bw==
X-Received: by 2002:a05:6402:88c:b0:46c:4566:8d55 with SMTP id e12-20020a056402088c00b0046c45668d55mr1788049edy.339.1670000585855;
        Fri, 02 Dec 2022 09:03:05 -0800 (PST)
Received: from alco.roam.corp.google.com (80.71.134.83.ipv4.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id sa22-20020a170906edb600b0073d7ab84375sm3249133ejb.92.2022.12.02.09.03.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 09:03:05 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Fri, 02 Dec 2022 18:02:47 +0100
Subject: [PATCH RESEND v2 7/8] media: uvcvideo: Refactor clock circular buffer
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20220920-resend-hwtimestamp-v2-7-0d7978a817cc@chromium.org>
References: <20220920-resend-hwtimestamp-v2-0-0d7978a817cc@chromium.org>
In-Reply-To: <20220920-resend-hwtimestamp-v2-0-0d7978a817cc@chromium.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     "hn.chen" <hn.chen@sunplusit.com>, linux-media@vger.kernel.org,
        Ricardo Ribalda <ribalda@chromium.org>,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=5903; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=B8RQISI4QMVIRkK5ckK4GQ2MSod4BIfdLdMm4WjWZ+w=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjii/A+6W5+VkrSSGmnhCsQh0Wjp4PZmGObAH1P3uV
 m5i1MJaJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY4ovwAAKCRDRN9E+zzrEiLGTD/
 wLZ0Lq9uFUdk0uaRjEuCtXiC0CCNaJ84lM6enLotZEC0BOr+z5t3TvOX/O/og07+JPFavX+nsYMULb
 MnMv6/sCusO3EyAS3+VB//A3adfW7dM+pkvjT756JWueep8QL/XIV7FhjCYG6jCWnUfpiMA0YhXuYW
 KfPzzfkxQbTApUAzr0Ug01b5YmebVJ0aeT6odSVEfKFOFTBGhe2OjsYKiRN3psKKZBCPlOFb9fAtbr
 R6YIzhQr5uO27iwkTq+qWRRzBaElsnHcG8G6Sd+YjmRoVYGXZ8SJvIyYnE1G5pX65/gsSagh8Rim2g
 ply81CeyakKkUcLif/e8JbjpxZMY6YA5bkC5x8zlpU5R2wsQ4MMe3+AYJ0Nmn1/UNVWYbOy0fhyP01
 mXNmBpaBqBYCsBmezl+3sdR3TQhvvampwOY9WyzNKoQe9TN9WZgcf3Fc1+LFhbkmXQHqZ9Xvr7Scn3
 0dSjOhRbH1V97GQjjCc+BSOrtrdbOJp97g7ymQAmloVX8AcrGR5NRERZ2W6BLQYJ7Cza/6dTov/cDd
 diuf5y7HkgALuucebmrO9aPaCy52UbIpOm67B96xClu5EBl49UlqEFOA27E4qAtNEjBi/z8iu93BSc
 Z5vG9YwmSZkC0ozNWEx2RSOhwr8+CJHZZRzJ6AU6uTGEG5QEOOzor2QgT6xA==
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

Move the addition to the buffer into its own function and remove the
stream dependency to all the clock functions.

Tested-by: HungNien Chen <hn.chen@sunplusit.com>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_video.c | 81 ++++++++++++++++++---------------------
 1 file changed, 37 insertions(+), 44 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
index 7c6448c6d706..c81a8362d582 100644
--- a/drivers/media/usb/uvc/uvc_video.c
+++ b/drivers/media/usb/uvc/uvc_video.c
@@ -464,18 +464,29 @@ static inline ktime_t uvc_video_get_time(void)
 		return ktime_get_real();
 }
 
+static void uvc_video_clock_add_sample(struct uvc_clock *clock,
+				       const struct uvc_clock_sample *sample)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&clock->lock, flags);
+
+	memcpy(&clock->samples[clock->head], sample, sizeof(*sample));
+	clock->last_sof = sample->dev_sof;
+	clock->head = (clock->head + 1) % clock->size;
+	clock->count = min(clock->count + 1, clock->size);
+
+	spin_unlock_irqrestore(&clock->lock, flags);
+}
+
 static void
 uvc_video_clock_decode(struct uvc_streaming *stream, struct uvc_buffer *buf,
 		       const u8 *data, int len)
 {
-	struct uvc_clock_sample *sample;
+	struct uvc_clock_sample sample;
 	unsigned int header_size;
 	bool has_pts = false;
 	bool has_scr = false;
-	unsigned long flags;
-	ktime_t time;
-	u16 host_sof;
-	u16 dev_sof;
 
 	switch (data[1] & (UVC_STREAM_PTS | UVC_STREAM_SCR)) {
 	case UVC_STREAM_PTS | UVC_STREAM_SCR:
@@ -530,20 +541,19 @@ uvc_video_clock_decode(struct uvc_streaming *stream, struct uvc_buffer *buf,
 	 * only the first one will match the host_sof.
 	 */
 	if (stream->dev->quirks & UVC_QUIRK_INVALID_DEVICE_SOF)
-		dev_sof = usb_get_current_frame_number(stream->dev->udev);
+		sample.dev_sof =
+			usb_get_current_frame_number(stream->dev->udev);
 	else
-		dev_sof = get_unaligned_le16(&data[header_size - 2]);
+		sample.dev_sof = get_unaligned_le16(&data[header_size - 2]);
 
-	if (dev_sof == stream->clock.last_sof)
+	if (sample.dev_sof == stream->clock.last_sof)
 		return;
 
-	stream->clock.last_sof = dev_sof;
-
 	if (stream->dev->quirks & UVC_QUIRK_INVALID_DEVICE_SOF)
-		host_sof = dev_sof;
+		sample.host_sof = sample.dev_sof;
 	else
-		host_sof = usb_get_current_frame_number(stream->dev->udev);
-	time = uvc_video_get_time();
+		sample.host_sof = usb_get_current_frame_number(stream->dev->udev);
+	sample.host_time = uvc_video_get_time();
 
 	/*
 	 * The UVC specification allows device implementations that can't obtain
@@ -566,46 +576,29 @@ uvc_video_clock_decode(struct uvc_streaming *stream, struct uvc_buffer *buf,
 	 * the 8 LSBs of the delta are kept.
 	 */
 	if (stream->clock.sof_offset == (u16)-1) {
-		u16 delta_sof = (host_sof - dev_sof) & 255;
+		u16 delta_sof = (sample.host_sof - sample.dev_sof) & 255;
 		if (delta_sof >= 10)
 			stream->clock.sof_offset = delta_sof;
 		else
 			stream->clock.sof_offset = 0;
 	}
 
-	dev_sof = (dev_sof + stream->clock.sof_offset) & 2047;
-
-	spin_lock_irqsave(&stream->clock.lock, flags);
-
-	sample = &stream->clock.samples[stream->clock.head];
-	sample->dev_stc = get_unaligned_le32(&data[header_size - 6]);
-	sample->dev_sof = dev_sof;
-	sample->host_sof = host_sof;
-	sample->host_time = time;
-
-	/* Update the sliding window head and count. */
-	stream->clock.head = (stream->clock.head + 1) % stream->clock.size;
+	sample.dev_sof = (sample.dev_sof + stream->clock.sof_offset) & 2047;
+	sample.dev_stc = get_unaligned_le32(&data[header_size - 6]);
 
-	if (stream->clock.count < stream->clock.size)
-		stream->clock.count++;
-
-	spin_unlock_irqrestore(&stream->clock.lock, flags);
+	uvc_video_clock_add_sample(&stream->clock, &sample);
 }
 
-static void uvc_video_clock_reset(struct uvc_streaming *stream)
+static void uvc_video_clock_reset(struct uvc_clock *clock)
 {
-	struct uvc_clock *clock = &stream->clock;
-
 	clock->head = 0;
 	clock->count = 0;
 	clock->last_sof = -1;
 	clock->sof_offset = -1;
 }
 
-static int uvc_video_clock_init(struct uvc_streaming *stream)
+static int uvc_video_clock_init(struct uvc_clock *clock)
 {
-	struct uvc_clock *clock = &stream->clock;
-
 	spin_lock_init(&clock->lock);
 	clock->size = 32;
 
@@ -614,15 +607,15 @@ static int uvc_video_clock_init(struct uvc_streaming *stream)
 	if (clock->samples == NULL)
 		return -ENOMEM;
 
-	uvc_video_clock_reset(stream);
+	uvc_video_clock_reset(clock);
 
 	return 0;
 }
 
-static void uvc_video_clock_cleanup(struct uvc_streaming *stream)
+static void uvc_video_clock_cleanup(struct uvc_clock *clock)
 {
-	kfree(stream->clock.samples);
-	stream->clock.samples = NULL;
+	kfree(clock->samples);
+	clock->samples = NULL;
 }
 
 /*
@@ -2085,7 +2078,7 @@ int uvc_video_resume(struct uvc_streaming *stream, int reset)
 
 	stream->frozen = 0;
 
-	uvc_video_clock_reset(stream);
+	uvc_video_clock_reset(&stream->clock);
 
 	if (!uvc_queue_streaming(&stream->queue))
 		return 0;
@@ -2219,7 +2212,7 @@ int uvc_video_start_streaming(struct uvc_streaming *stream)
 {
 	int ret;
 
-	ret = uvc_video_clock_init(stream);
+	ret = uvc_video_clock_init(&stream->clock);
 	if (ret < 0)
 		return ret;
 
@@ -2237,7 +2230,7 @@ int uvc_video_start_streaming(struct uvc_streaming *stream)
 error_video:
 	usb_set_interface(stream->dev->udev, stream->intfnum, 0);
 error_commit:
-	uvc_video_clock_cleanup(stream);
+	uvc_video_clock_cleanup(&stream->clock);
 
 	return ret;
 }
@@ -2265,5 +2258,5 @@ void uvc_video_stop_streaming(struct uvc_streaming *stream)
 		usb_clear_halt(stream->dev->udev, pipe);
 	}
 
-	uvc_video_clock_cleanup(stream);
+	uvc_video_clock_cleanup(&stream->clock);
 }

-- 
2.39.0.rc0.267.gcb52ba06e7-goog-b4-0.11.0-dev-696ae
