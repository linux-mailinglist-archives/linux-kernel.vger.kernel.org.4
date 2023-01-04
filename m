Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDDD465D0E9
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 11:47:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239092AbjADKqh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 05:46:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238993AbjADKqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 05:46:00 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C808F5B
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 02:45:57 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id c34so41414035edf.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 02:45:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FDgPA71BB6P36oy/yaWrNwP2I0p7AiHxv3mHi9TEYCk=;
        b=XtrsS/1UZK81LaeViHHnmVT6dYQWNOCIPPq6upkTAESvZJtiphcvlwCMmvfFqNqnCG
         EjEGBS9DFN8QEhPzyZZJxLrhNGHcocY/twTOBwFSZmg24iJn0g1QGeOEh8SmvhPlxip+
         Y8BnVpUJw+IqyVLAoGVia6OIv4gIZhAGjUMB8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FDgPA71BB6P36oy/yaWrNwP2I0p7AiHxv3mHi9TEYCk=;
        b=T6oopitQP7Qh42vAFTSr71qvQW56nwc4kkH1sgnXdIReGgoT/Jf63SL5AuGyfZ028y
         YzHD5OaAKylxLn0cy/Ratc2el6k+fbYwLtz261Ne1Gi1v5nn5Z31i+Ly4efn5+yfGzY+
         +/17eFo6x8bq2Onl/Zi5bFY0FWP0lBugk5p8smj86OfVd+MXe2oT7PiRwVo/0WPFpRRq
         kBbgBm5fH7MZT/njNGag9cPOqvnQL85xJfrunteSEiVeHiFrmcw1oTZyTk7J/qvifF8R
         YO1BToCWcD9v6xjKcZefDHvkaB8hoW3VZxTAWSak5Vx9dPAvkSe3VeSb3FDHquWrvrfV
         YQsQ==
X-Gm-Message-State: AFqh2kqSSP8anazkmzr/O2M5R0lJybLk/1UmybUa9Hvt/8q0XR58oGdh
        R05tEazCtvGA54RpV0Z+GhmAXA==
X-Google-Smtp-Source: AMrXdXs++SNoPgWWG2zaTy3gn1kVq0tM3XhxbFmpXW7ZLN76kBv6tsf4Jq3V2sa6w6iKWMXtsZ9U1w==
X-Received: by 2002:a05:6402:1f06:b0:46f:a6ea:202 with SMTP id b6-20020a0564021f0600b0046fa6ea0202mr51524811edb.37.1672829156072;
        Wed, 04 Jan 2023 02:45:56 -0800 (PST)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:6531:9bb0:b3f7:86a8])
        by smtp.gmail.com with ESMTPSA id g32-20020a056402322000b0048c85c5ad30sm4754971eda.83.2023.01.04.02.45.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 02:45:55 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Wed, 04 Jan 2023 11:45:25 +0100
Subject: [PATCH v3 7/8] media: uvcvideo: Refactor clock circular buffer
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20220920-resend-hwtimestamp-v3-7-db9faee7f47d@chromium.org>
References: <20220920-resend-hwtimestamp-v3-0-db9faee7f47d@chromium.org>
In-Reply-To: <20220920-resend-hwtimestamp-v3-0-db9faee7f47d@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-kernel@vger.kernel.org, "hn.chen" <hn.chen@sunplusit.com>,
        Ricardo Ribalda <ribalda@chromium.org>,
        linux-media@vger.kernel.org
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=6103; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=Y+RBkriXzItA9F9XcVh0gDzU4cduaikhSaZRnYLxgS8=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjtVjatQTNxFXCouiEcpNU0Ctlaqn2ejx6qCnliSKl
 Eo4FayWJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY7VY2gAKCRDRN9E+zzrEiLF5D/
 9EE4FYXMWbulzY9cMNWC8FcsUF07yEeuJ9Xk64XToqjtLg7WinkcTdQgCFaO2N+QLFVb01Q67WHwqZ
 8x9aDyjmelxrGLSziyZcoHsnUmWUYCvU7oj6pce8rMZ4DGNIwBuD/LKVRleJQyshig6x8CV1TdrWXW
 lmT0cU29Hvn9cGGlKXrUnZEgvvUZsNgPLoLBDlJ1jhyISx3h5huo74Xl3/WzK069o2hkkjF1y0eGl5
 Y8WegAHOoL2xV9HtMkNXrSfxdHSl+eUeXLoDHCwW6zGnKkC2V53ish2ujMiMVXmRaoD/i5dpCF35AP
 jBpxKYQ1OEZr2+kJe5BUmxtnxLaJ8vq3umSy+3HdG8hE6cBhU/QyJ095XTg+zS598lXW6T1DNbrZtG
 OCJneNrly/gZUvGaXGZy6Et8PvG9ND/hAX0F1ADaCunm73Mi9a1ODedunHMSRCHsBR1I6c9y67DSaJ
 ubDPWiZr4iEdz7sUo4mfUkV/vIYtvvWoIYRORobKkIzV7XddImx3rbondYfwNLvrdcDuXCZodU9hDc
 k6y6IQkViLd+YmKXYsbpcAEGjfBN3NswDCSS+vRRdOLwWpkkQ5YFFebqdH5CgoKlcnSK/ntavwsems
 EYDXmlj62UKiKd9DDLqFEpHuaG9AndtoEuEbDBTbYV5YshkI344nHVp0TN9w==
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

Isolate all the changes related to the clock circular buffer to its own
function, that way we can make changes easier to the buffer logic.

Also simplify the lock, by removing the circular buffer clock handling
from uvc_video_clock_decode().

And now that we are at it, unify the API of the clock functions.

Tested-by: HungNien Chen <hn.chen@sunplusit.com>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_video.c | 81 ++++++++++++++++++---------------------
 1 file changed, 37 insertions(+), 44 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
index 5c37b080e0c6..2c6da49ff84b 100644
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
@@ -531,20 +542,19 @@ uvc_video_clock_decode(struct uvc_streaming *stream, struct uvc_buffer *buf,
 	 * case only the first one will match the host_sof.
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
@@ -567,46 +577,29 @@ uvc_video_clock_decode(struct uvc_streaming *stream, struct uvc_buffer *buf,
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
 
@@ -615,15 +608,15 @@ static int uvc_video_clock_init(struct uvc_streaming *stream)
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
@@ -2092,7 +2085,7 @@ int uvc_video_resume(struct uvc_streaming *stream, int reset)
 
 	stream->frozen = 0;
 
-	uvc_video_clock_reset(stream);
+	uvc_video_clock_reset(&stream->clock);
 
 	if (!uvc_queue_streaming(&stream->queue))
 		return 0;
@@ -2226,7 +2219,7 @@ int uvc_video_start_streaming(struct uvc_streaming *stream)
 {
 	int ret;
 
-	ret = uvc_video_clock_init(stream);
+	ret = uvc_video_clock_init(&stream->clock);
 	if (ret < 0)
 		return ret;
 
@@ -2244,7 +2237,7 @@ int uvc_video_start_streaming(struct uvc_streaming *stream)
 error_video:
 	usb_set_interface(stream->dev->udev, stream->intfnum, 0);
 error_commit:
-	uvc_video_clock_cleanup(stream);
+	uvc_video_clock_cleanup(&stream->clock);
 
 	return ret;
 }
@@ -2272,5 +2265,5 @@ void uvc_video_stop_streaming(struct uvc_streaming *stream)
 		usb_clear_halt(stream->dev->udev, pipe);
 	}
 
-	uvc_video_clock_cleanup(stream);
+	uvc_video_clock_cleanup(&stream->clock);
 }

-- 
2.39.0.314.g84b9a713c41-goog-b4-0.11.0-dev-696ae
