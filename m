Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 261AA669920
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 14:53:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241478AbjAMNxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 08:53:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241802AbjAMNwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 08:52:22 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1E6569B1B
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 05:49:08 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id mp20so5845660ejc.7
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 05:49:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2JdQ79/DG3w/NnYpFjhrKQiF9vf+P0kD+HDc/SwBkDU=;
        b=SPSWEpVlZTdei5NmTNUgjxxFp8CYsjWO5wHQilWmjHPTTHVb4NWA73Yd/jt8L6iGNg
         4OFqL9ivs7qwbnHHenui8Ue13qsjG7/8c2ZczkdyZOUlVYljfqhFuetUCbJg4GEpYyD7
         MzD350qHCe99aghjFjFso9blEJvSuuma/OgO4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2JdQ79/DG3w/NnYpFjhrKQiF9vf+P0kD+HDc/SwBkDU=;
        b=IxiEip02ObQpoOsuAWy/SjKtXdqIj+2mrYKpp/gtI0jnYe1uFwkKSQAJNppwdKAWcD
         pblKzGsdKT4o24x2lIT91t0ENzNj8l2iSinIRZcuEVDrAKu4XPyR6Uch2cnqJGhYwfe5
         ZR81UIW1u2elPKxVE1hkqSnNU8TGdQlBr8gLX1eBLZAWFubNks1j+cupMaXgYJ9P22y3
         ZXv3Xeu/6HWylYg1UeUH0OXZJsQlEkdsqDlLem4K6mdTXAF2fzX7lcJt8Zdi5+2rMxje
         Gw/PHL8qXGBy7AenwvrRcMSmfmaGQsTETbBVXEx1MQ5AujrVKGG2vc4TABLOgFO/zZNu
         qlTA==
X-Gm-Message-State: AFqh2kqFQVLJnxrKdut3VHbj+GGxA3xoJleSW0X7pGiCFoqERzGL4+cv
        vciadBW7bNVdXg0XToyqxhnAiK3pvEiM3T0rDKs=
X-Google-Smtp-Source: AMrXdXsRa7oXYSt5dEKlb3mHA3ByJcdxO7ZlcTVT0IrUuh7tZkMPORQi+v7lArSWLosoi1eRAoQ9Ig==
X-Received: by 2002:a17:907:a485:b0:7c1:709d:fa49 with SMTP id vp5-20020a170907a48500b007c1709dfa49mr87888466ejc.18.1673617746803;
        Fri, 13 Jan 2023 05:49:06 -0800 (PST)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:b023:4272:bddc:acf2])
        by smtp.gmail.com with ESMTPSA id w23-20020a1709062f9700b0084d3bf44996sm7072888eji.142.2023.01.13.05.49.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 05:49:06 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Fri, 13 Jan 2023 14:48:50 +0100
Subject: [PATCH v5 4/5] media: uvcvideo: Refactor clock circular buffer
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20220920-resend-hwtimestamp-v5-4-660679c6e148@chromium.org>
References: <20220920-resend-hwtimestamp-v5-0-660679c6e148@chromium.org>
In-Reply-To: <20220920-resend-hwtimestamp-v5-0-660679c6e148@chromium.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     "hn.chen" <hn.chen@sunplusit.com>, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=6614; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=r2Bi8jzAlegYJ34KV7vhsUT4PU3/z0Uyq8nK4oWIpCU=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjwWFKV4PZvGmcZmD3pUGhHBoq/4lKBwYpLBlCb1Og
 KVnqGqCJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY8FhSgAKCRDRN9E+zzrEiLPLD/
 sHCLfMibRlpo7NDo/NG17fdXhmRU63hrmgnPJ3Z1cbh6sfQyLIMRXi3A5vxJJ8gHRtcma3Vo95HR5H
 8MGyiIfblutzocaLdP/PjlraBskXJ4oudncy9SdzJ0dnVKmb3y9Pij+X2onf0q/WPT6oHoDpJiIe2F
 UZuvqBxRiMMdMhaphG4OQdFN5zEz5uWVX+geqxkZs+Mw9gei0ZlgKSQJdeTJSjdWRgQnQB0IatGP/g
 fE0T/JBIg6lMxUhNphIdXeCMXdvdLgdjYHvtdmijw/iKYJRMcoD+h6f2tKN8ZxnQyC1CTBmxKfxqc0
 9CKpdMwi3TX4nnOi1hqgn3FVxl7nAnhMwYUj6ingAGt08V/9v2sshrOkRz1gqwhyA/kH9salQ84U5M
 xD0ZbymF1jKzxKsqQX+OtrbmmJi+9CxGVSlm29lBCFsBpeuiqn+ndlYhJ103e3hzlb2fZWEkDbl9Hf
 VQDlWgZNs+WMuyg80SJJCAttMxn2UPZUfDQBjLpmmTv46l5lkUljBR5wTe4HHXy8b4L1mJdThdYW+/
 bs2MSMmVOSgrm10aQcvjQm98BiXT5L6eXuVhtjFde9ieLlhLbxjjP/92Gl8jsdbXqajKYtFe8lw25C
 vWGazIMErHMVn7MEBJcPU6SsFaW60mGJrH9GLCQkVAPiWUllr7+Aav3THNkQ==
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

Isolate all the changes related to the clock circular buffer to its own
function, that way we can make changes easier to the buffer logic.

Also simplify the lock, by removing the circular buffer clock handling
from uvc_video_clock_decode().

And now that we are at it, unify the API of the clock functions.

Tested-by: HungNien Chen <hn.chen@sunplusit.com>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_video.c | 84 ++++++++++++++++++---------------------
 1 file changed, 39 insertions(+), 45 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
index 21985598ff5b..22255bfa7db9 100644
--- a/drivers/media/usb/uvc/uvc_video.c
+++ b/drivers/media/usb/uvc/uvc_video.c
@@ -466,19 +466,28 @@ static inline ktime_t uvc_video_get_time(void)
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
-	u32 dev_stc;
 
 	switch (data[1] & (UVC_STREAM_PTS | UVC_STREAM_SCR)) {
 	case UVC_STREAM_PTS | UVC_STREAM_SCR:
@@ -523,11 +532,11 @@ uvc_video_clock_decode(struct uvc_streaming *stream, struct uvc_buffer *buf,
 	 * all the data packets of the same frame contains the same SOF. In that
 	 * case only the first one will match the host_sof.
 	 */
-	dev_sof = get_unaligned_le16(&data[header_size - 2]);
-	if (dev_sof == stream->clock.last_sof)
+	sample.dev_sof = get_unaligned_le16(&data[header_size - 2]);
+	if (sample.dev_sof == stream->clock.last_sof)
 		return;
 
-	dev_stc = get_unaligned_le32(&data[header_size - 6]);
+	sample.dev_stc = get_unaligned_le32(&data[header_size - 6]);
 
 	/*
 	 * Some devices make a borderline interpretation of the UVC 1.5 standard
@@ -536,19 +545,21 @@ uvc_video_clock_decode(struct uvc_streaming *stream, struct uvc_buffer *buf,
 	 * algorithm.
 	 */
 	if (buf && buf->bytesused == 0 && len == header_size &&
-	    dev_stc == 0 && dev_sof == 0)
+	    sample.dev_stc == 0 && sample.dev_sof == 0)
 		return;
 
-	stream->clock.last_sof = dev_sof;
+	stream->clock.last_sof = sample.dev_sof;
 
 	/*
 	 * On some devices, like the Logitech C922, the device SOF does not run
 	 * at a stable rate of 1kHz. For those devices use the host SOF instead.
 	 */
-	if (stream->dev->quirks & UVC_QUIRK_INVALID_DEVICE_SOF)
-		dev_sof = usb_get_current_frame_number(stream->dev->udev);
+	if (stream->dev->quirks & UVC_QUIRK_INVALID_DEVICE_SOF) {
+		sample.dev_sof =
+			usb_get_current_frame_number(stream->dev->udev);
+	}
 
-	time = uvc_video_get_time();
+	sample.host_time = uvc_video_get_time();
 
 	/*
 	 * The UVC specification allows device implementations that can't obtain
@@ -571,46 +582,29 @@ uvc_video_clock_decode(struct uvc_streaming *stream, struct uvc_buffer *buf,
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
-	sample->dev_stc = dev_stc;
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
 
@@ -619,15 +613,15 @@ static int uvc_video_clock_init(struct uvc_streaming *stream)
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
@@ -2099,7 +2093,7 @@ int uvc_video_resume(struct uvc_streaming *stream, int reset)
 
 	stream->frozen = 0;
 
-	uvc_video_clock_reset(stream);
+	uvc_video_clock_reset(&stream->clock);
 
 	if (!uvc_queue_streaming(&stream->queue))
 		return 0;
@@ -2248,7 +2242,7 @@ int uvc_video_start_streaming(struct uvc_streaming *stream)
 {
 	int ret;
 
-	ret = uvc_video_clock_init(stream);
+	ret = uvc_video_clock_init(&stream->clock);
 	if (ret < 0)
 		return ret;
 
@@ -2266,7 +2260,7 @@ int uvc_video_start_streaming(struct uvc_streaming *stream)
 error_video:
 	usb_set_interface(stream->dev->udev, stream->intfnum, 0);
 error_commit:
-	uvc_video_clock_cleanup(stream);
+	uvc_video_clock_cleanup(&stream->clock);
 
 	return ret;
 }
@@ -2294,5 +2288,5 @@ void uvc_video_stop_streaming(struct uvc_streaming *stream)
 		usb_clear_halt(stream->dev->udev, pipe);
 	}
 
-	uvc_video_clock_cleanup(stream);
+	uvc_video_clock_cleanup(&stream->clock);
 }

-- 
2.39.0.314.g84b9a713c41-goog-b4-0.11.0-dev-696ae
