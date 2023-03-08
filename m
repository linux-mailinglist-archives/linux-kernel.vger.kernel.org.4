Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 698186B157D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 23:46:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbjCHWqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 17:46:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbjCHWpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 17:45:50 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2DABD00B8
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 14:45:47 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id u9so72030219edd.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 14:45:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1678315546;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=agGGtHxRf8USOkd58s+vm5nJWzgzOixZG2/uliZ0k5A=;
        b=XxG1k7Uktlh6ts0mIWGFmGFRNQ++tiK9naocld0ZC2HmDImC78Ib1x6bV/+Hx/2MK6
         4U//wPs/nsB+69Z8/ZR4cHEv6ZEItm6crzFDDs7J+iaAC3BGJZn26fiQ7Ro/XXkiXDmX
         HM8v8CymNM7ViCnQEdu66NUDCFG9HN1523h/g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678315546;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=agGGtHxRf8USOkd58s+vm5nJWzgzOixZG2/uliZ0k5A=;
        b=Jxw+8+NebpA4lR0KZlT740fYjdj+clHeLRn8jtbMxhMzYv2wQvyPa7991b95NAuSHe
         2/J2uXg577BoPrMzKJTk2+TYAvPWjvyZc/HHisSabYIdgYHamEjXn1F32MCrvhjSTV3X
         whR5trW1Rp76h71QdOfBFBSzXN8jXHPWHLP0BvrLun9o1QO+AzgV9JLuWxmYuxvvGIyT
         qui8x+rifcoJXISSi6MFcmJ5IX1sro3bVhAniCquVLcrL8EVka3EnDTN+KEGKQ/euS0f
         4Soijj8+EHJs2U/c+9s6tT+syaJ3xoL/HNN044JnSrkApWX7yWdM0JQsoBDgMriJrfD0
         63bg==
X-Gm-Message-State: AO0yUKW55g+T+X56VGvGONXEY1Pr/sPtDC28/pP4SPPI2dikf3ceCCwp
        dmXw20/pgE/mm56PzId8cfyUbQ==
X-Google-Smtp-Source: AK7set/rTvZnz81tX+uRiOQroLGwAnAxNg5zcHzvP33gOcCPPyozHbxZu0ze7lJwQgfjRqliIzfpoQ==
X-Received: by 2002:a17:906:700f:b0:88d:79df:7cfc with SMTP id n15-20020a170906700f00b0088d79df7cfcmr17872695ejj.62.1678315546512;
        Wed, 08 Mar 2023 14:45:46 -0800 (PST)
Received: from alco.roam.corp.google.com (80.71.134.83.ipv4.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id ot18-20020a170906ccd200b008e40853a712sm8040167ejb.97.2023.03.08.14.45.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 14:45:46 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Wed, 08 Mar 2023 23:45:35 +0100
Subject: [PATCH RESEND v5 4/5] media: uvcvideo: Refactor clock circular buffer
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20220920-resend-hwtimestamp-v5-4-139d1a144614@chromium.org>
References: <20220920-resend-hwtimestamp-v5-0-139d1a144614@chromium.org>
In-Reply-To: <20220920-resend-hwtimestamp-v5-0-139d1a144614@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     "hn.chen" <hn.chen@sunplusit.com>, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=6617; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=C7PTS4ZXKfpQAl4AaZUozQn/Y3XzA3jWhWUy0P0et3M=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBkCRAUn6BxXs7hMNLa7PrXMhfilFJpj9+bdIa39Oia
 n4NkmR+JAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCZAkQFAAKCRDRN9E+zzrEiIyjD/
 9x2B67SZ3KFX0LPHFFLBGN4WXqIoGJzRJw0q/DScWRlkj0wziKLpaE2vE/Fnm4koCsFfMF7ypLKoA0
 Rlzxtmye9rfujmt/JzIiUfK/iszZyKYeOybDaxC1/FsB8P7xKa3hl2KhqxMX9dmBY1nTpq8Ess4D0k
 RjyAOHOTE1QuArQ7FwM8C0h3bMYDFefUbY6c24z3gd52iXrBMkuu64L6/1wmYXtuUcu/LVMTbhVKL+
 jZN6uQXMZL3mEHVUwdPm9sNM8YVe00yev9CnPIT6shgdo8fzqKrA6v1MjzZ0RKUzwlEtMqHZ0FngAc
 ZhnumyoT3dDOmJssb2XPmPn/aYxjbpV7QarebqZMoVS9bGxW7V92MGJg+h54X8//PgBagMBgfPgS7y
 CFTVXKo1HLYmfFNIbkird3BQvhDrE+LZM2220VIwFM1seUHbhF5zlgcNwOdcnRl3PsR8ii067UA2wN
 2t2EBjpsGObxyjxkMm9REapLJeuQrDuVa3fjIxVyekdN81rBbSds+VxxBd5823XWoeBwnnWHXSISbW
 cxkP8DV3UHKr2801qj00qeFSPFzLgR3VLWM5HliD4KCLY10BEehJo3nz+o7lLSf/AUrFnhDJjKFCGk
 csBh7FhzCE4T0c6lzkCn/FnFOV5Qil0mPeI9STuTiZ4y94qPjNtcwQULNwgg==
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
2.40.0.rc0.216.gc4246ad0f0-goog-b4-0.11.0-dev-696ae
