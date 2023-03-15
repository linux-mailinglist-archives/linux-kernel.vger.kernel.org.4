Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F7866BB4B1
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 14:31:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232310AbjCONbB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 09:31:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232131AbjCONag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 09:30:36 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D8D791B7C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 06:30:31 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id w9so4789864edc.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 06:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1678887029;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nfrIME0wJIYRWxUiJsRB8/dUZqSdjz1B4rSK467QV2U=;
        b=KHaT5VylGWcmvubhEggVy1vnsnxEkDSBrt3DeXHUsFx0R4eN1KDdZ3ymOH3PxVeKpX
         pNHSUjoqcZN1nHEA1MDBDH64GV5eJ2F1F8kcKCYV0jRuSvEYp/mYAHlqB+bD3ClW6Ebw
         vh2DGGYroFbQWIYp4S5befUpvtQkeYtj1r+dQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678887029;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nfrIME0wJIYRWxUiJsRB8/dUZqSdjz1B4rSK467QV2U=;
        b=HY6lD/NWK1QnFb22E4123AGkSc/WdQfrGrRLogLGY29zvzSD3w27MGEA4dmI/p45BB
         2IJLyqvLwVRz+u33h9Eg/Szs4MRiZzn2/UQnkNBCwvfeoZLxpCISqOdZn2DItTM6iBjl
         Ltor9aPhdlWjyGEaVbgPofDrhCv0h0yGJ6mccyEPaHTCOyNB/S8lLYGUMSs4MEKl4hAC
         VFGlz/kLUplJ317wqgYJsRJ/4S4UM0BjFaP11HxiIMQnxg2oRriaz/1DrUTYaWn64lvF
         ZINMoL1OvHaQHzQsdw09cOWzySsywZj1UOe/bPHXqrSErkoQvDQlv3jbqXDzjUkQdZC5
         386Q==
X-Gm-Message-State: AO0yUKVkLJ+SBb7TXb6OaEDZEc9YLtjAd9pbML7Q2yDKR4qLUYhIzWDa
        hfY43FsHG0QkSQnEYGmQnoh4Fg==
X-Google-Smtp-Source: AK7set9/wL4JhG2jrBM6XmJsChWwIxp6GU1HruVLKmf4ERJUrScxkUoUv1YDYsMv5ya3e3wO+kZrIQ==
X-Received: by 2002:a17:906:4e92:b0:878:72d0:2817 with SMTP id v18-20020a1709064e9200b0087872d02817mr6062723eju.29.1678887029512;
        Wed, 15 Mar 2023 06:30:29 -0700 (PDT)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:491c:f627:27f0:1c4])
        by smtp.gmail.com with ESMTPSA id ha11-20020a170906a88b00b0092043ae1a8asm2534638ejb.92.2023.03.15.06.30.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 06:30:29 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Wed, 15 Mar 2023 14:30:16 +0100
Subject: [PATCH v9 5/6] media: uvcvideo: Refactor clock circular buffer
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20220920-resend-hwtimestamp-v9-5-55a89f46f6be@chromium.org>
References: <20220920-resend-hwtimestamp-v9-0-55a89f46f6be@chromium.org>
In-Reply-To: <20220920-resend-hwtimestamp-v9-0-55a89f46f6be@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Ricardo Ribalda <ribalda@chromium.org>,
        linux-kernel@vger.kernel.org, "hn.chen" <hn.chen@sunplusit.com>,
        linux-media@vger.kernel.org
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=6682; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=1XOlapgZ7o2YnyPsHBz+Zu3te118klpRecTLUAUw/1Q=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBkEchskmhPNyQcOP0px7P1LeWbWNLniHOx4a86Kzhj
 1fGkW0aJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCZBHIbAAKCRDRN9E+zzrEiPCuD/
 9aGs1INStszDd9kwQmNc+7X/FvhIisrcqqhFYKTs8n4vMBpepipuRtuPtX925dXnuLgHgjYZP1Pae/
 /nni4S6OpCb/5Q3cqO4e5PuofG9f8c3mjwRHUYyu3sLFFgIT882ICgLKDDk4xU+tNWwnwI97FpdHFl
 x8pWWR1qnRqdci0mT+jUMpOFUvlLN2UWpdR1QwKrxGoplQQIT6pU1TGMRuxy52d1Il6iYFBS9lWBQa
 LYyNATj+nHh5iPocEq/Vx/M5WvsIJfmDLMmB3pMr93vP2T057BfFy+AgYrZxHlo8CM/qmbbYK4GtL1
 46IhXLf69ohhBo0a0n36DSfr3LSDaYG7zZfYr49ExMBOS2sP00++hIHcgDgnNOmZzzKsGH6Qdy8dai
 dsg5FimQbfWl6Ygb1IOsMXpgMwgRIpEEDtpxcvM2IUIaZPNLxpgv+/WDFWUrC6/zmGNysGn9C8KY5Z
 KmFyEOCux16IE2SLgjF+kKGyTqEY6B7RuCCROWNeArhEz6hthfvF8f0TCeirJM6DvsQnqzOXvzqZJz
 NmGX4rrsjWfNdevApQHFjE6VsgBaFDJ8zRuKXl9fmG7R8izf6r6ATNr5i5EUSmNlYbwh6gDw8mLaJV
 3y2DjuupdjjCDk4QXx5uvrvzkxyPvTZAkhsava5DdpqxyO4vWt0fDbwnUKaQ==
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

Isolate all the changes related to the clock circular buffer to its own
function, that way we can make changes easier to the buffer logic.

Also simplify the lock, by removing the circular buffer clock handling
from uvc_video_clock_decode().

And now that we are at it, unify the API of the clock functions.

Tested-by: HungNien Chen <hn.chen@sunplusit.com>
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_video.c | 84 ++++++++++++++++++---------------------
 1 file changed, 38 insertions(+), 46 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
index 6d0243ea0e07..1db0d1bc80e6 100644
--- a/drivers/media/usb/uvc/uvc_video.c
+++ b/drivers/media/usb/uvc/uvc_video.c
@@ -466,19 +466,30 @@ static inline ktime_t uvc_video_get_time(void)
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
+
+	clock->last_sof = sample->dev_sof;
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
@@ -523,11 +534,11 @@ uvc_video_clock_decode(struct uvc_streaming *stream, struct uvc_buffer *buf,
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
 	 * STC (Source Time Clock) is the clock used by the camera. The UVC 1.5
@@ -541,21 +552,19 @@ uvc_video_clock_decode(struct uvc_streaming *stream, struct uvc_buffer *buf,
 	 * and stc and sof are zero.
 	 */
 	if (buf && buf->bytesused == 0 && len == header_size &&
-	    dev_stc == 0 && dev_sof == 0)
+	    sample.dev_stc == 0 && sample.dev_sof == 0)
 		return;
 
-	stream->clock.last_sof = dev_sof;
-
-	host_sof = usb_get_current_frame_number(stream->dev->udev);
+	sample.host_sof = usb_get_current_frame_number(stream->dev->udev);
 
 	/*
 	 * On some devices, like the Logitech C922, the device SOF does not run
 	 * at a stable rate of 1kHz. For those devices use the host SOF instead.
 	 */
 	if (stream->dev->quirks & UVC_QUIRK_INVALID_DEVICE_SOF)
-		dev_sof = host_sof;
+		sample.dev_sof = sample.host_sof;
 
-	time = uvc_video_get_time();
+	sample.host_time = uvc_video_get_time();
 
 	/*
 	 * The UVC specification allows device implementations that can't obtain
@@ -578,46 +587,29 @@ uvc_video_clock_decode(struct uvc_streaming *stream, struct uvc_buffer *buf,
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
 
@@ -626,15 +618,15 @@ static int uvc_video_clock_init(struct uvc_streaming *stream)
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
@@ -2108,7 +2100,7 @@ int uvc_video_resume(struct uvc_streaming *stream, int reset)
 
 	stream->frozen = 0;
 
-	uvc_video_clock_reset(stream);
+	uvc_video_clock_reset(&stream->clock);
 
 	if (!uvc_queue_streaming(&stream->queue))
 		return 0;
@@ -2257,7 +2249,7 @@ int uvc_video_start_streaming(struct uvc_streaming *stream)
 {
 	int ret;
 
-	ret = uvc_video_clock_init(stream);
+	ret = uvc_video_clock_init(&stream->clock);
 	if (ret < 0)
 		return ret;
 
@@ -2275,7 +2267,7 @@ int uvc_video_start_streaming(struct uvc_streaming *stream)
 error_video:
 	usb_set_interface(stream->dev->udev, stream->intfnum, 0);
 error_commit:
-	uvc_video_clock_cleanup(stream);
+	uvc_video_clock_cleanup(&stream->clock);
 
 	return ret;
 }
@@ -2303,5 +2295,5 @@ void uvc_video_stop_streaming(struct uvc_streaming *stream)
 		usb_clear_halt(stream->dev->udev, pipe);
 	}
 
-	uvc_video_clock_cleanup(stream);
+	uvc_video_clock_cleanup(&stream->clock);
 }

-- 
2.40.0.rc1.284.g88254d51c5-goog-b4-0.11.0-dev-696ae
