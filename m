Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A104D6BB29D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 13:37:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232917AbjCOMhf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 08:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232809AbjCOMhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 08:37:10 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9BC1848C6
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 05:36:17 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id eg48so15661070edb.13
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 05:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1678883763;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tCkrkxPcp+pi7gWatTpAiQc1rhobUtJPz5SB1d3BoAs=;
        b=HcUeL/Gsuz2rsdYJ2uO0fa6VHfLGNxucpRGvZ1v26hYlGJ+MbjoFj6bpzEzwjQvo3X
         rfiuvdhsXlaq2a6utmzRzNIoDwXOlMDSWdRws60B76Sc4H0TbYS6ERX3p1jtxDOVO9qE
         vi1zN8sRadkxj7p6mEcosg0spK6fdUlqIA0RU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678883763;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tCkrkxPcp+pi7gWatTpAiQc1rhobUtJPz5SB1d3BoAs=;
        b=XF18NDy3mt3+CGV8JErRqwDdOUd9+gw4UXa/n1lHFvIwGmvqZa7ymIAMpqSHVPse65
         4iTnoOkVTm2rKBcElBC9Z5iuMS7iVpfCp+s1TdkEgbLcRWtoMoT8y+/o8uVdKOhCaIg0
         ITDE92OihuJTMtyv1UawisT6VqoJKBfEolaYz0OWCVXpCAAWhlhXEcjV4CBDaarxEvaq
         X6iePlr3zsBlyo/mwg/mkK8sEtwIzMaNY6JgZU9Lq963kxV4Lyn9cTlKAFMUb1wMvyMJ
         WSES+U5TjjVDco9ja9JG2OJVaOlsFQR+nawdv6wNvwv4j2WeJerMilX6KfTboTsauOEs
         EBCA==
X-Gm-Message-State: AO0yUKVSoHxOuUisQD+WZ1xp+rzKR4833EAdWkvc8bs6iSUm93+BChUT
        430pgvg1n9Q0MT7SUwDNlIgIug==
X-Google-Smtp-Source: AK7set8ooG5NmhmFwX3pgacTuf8SZ7jUdAHMo2GbSz5y8q1Ff7WUKJbBssgq7VWXi4Il2Z69verrWQ==
X-Received: by 2002:a05:6402:887:b0:500:2a15:f86b with SMTP id e7-20020a056402088700b005002a15f86bmr1576900edy.42.1678883762837;
        Wed, 15 Mar 2023 05:36:02 -0700 (PDT)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:491c:f627:27f0:1c4])
        by smtp.gmail.com with ESMTPSA id w3-20020a50c443000000b004c30e2fc6e5sm2363256edf.65.2023.03.15.05.36.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 05:36:02 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Wed, 15 Mar 2023 13:35:41 +0100
Subject: [PATCH v8 5/6] media: uvcvideo: Refactor clock circular buffer
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20220920-resend-hwtimestamp-v8-5-0edaca2e2ab3@chromium.org>
References: <20220920-resend-hwtimestamp-v8-0-0edaca2e2ab3@chromium.org>
In-Reply-To: <20220920-resend-hwtimestamp-v8-0-0edaca2e2ab3@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     "hn.chen" <hn.chen@sunplusit.com>, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=6688; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=OHcMfCmrhkBCGNHm7ElXHEEK0vKCs58LRA2nG7cPcTo=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBkEbupjxjnRk77SUQR0/MIksA+fOmz1p+1MXr0m6wG
 /W7qENuJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCZBG7qQAKCRDRN9E+zzrEiBIKD/
 9KaGJwKe7leHuiXchoYFKwsc8k7asrzgqVT08RQwIXfVsHT48FlHaCtXSdkH7K3ldGGihnbriHBsSR
 4eMaF01UiZkWjbmEQobFgctZn/FEYjJXmY9SfLrZ+oFvwVRgvKfpugNi18VFa22kI5/A/Y5GCsJkuK
 sQ+PsVfpbCjGmCQMR8sDiCa3CgrGdrfScPifEFtwCeJkS03n4dYzKylmDbdvICDAddwTMo4WVVs2O2
 FnRRHAG/QeZQ8M09Vh6jMCn3XPKpbQUG8//g9B7LPnrnPGfdFZs6tzZecqV483Vs3EeWlTY+mBjK8x
 rYVK0WdRN+PY6sXZBpx2HASQTUHOLVZetApfTC3hJgcPc4QvtV9dmdHjbUyevQpasSaMIXY0KAIbZs
 v0bATtA9zjD8Gw7f01hmQNRDApGrAEzrcK/aooYEIWftI0ftrZq/eAxcIuUevyWSWYAmixtH8PBSie
 klxPo2R6rfDEIYHZpEW66GoopqmuojxJVGIoe0ozN2OzhPDWBLxKQCZGIozNfUTD+8HJo77nIKfQyu
 IVqw1NJt29K/W553YYrmA51cBiIbv1r0azMHYYS1l/APnmJaemznOel7aSpvlGtRlWnM/ZfsI9CI01
 zEsIFDc4eztChaSTOH5O3uBAnDTMO6iTQayBmVGlCh+cZYawocpNFfQly7RA==
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
index 6d0243ea0e07..df7c400fe82e 100644
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
+	stream->clock.last_sof = sample.dev_sof;
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
