Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7AC96B24B3
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 13:58:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231264AbjCIM6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 07:58:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231166AbjCIM5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 07:57:32 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48BE6F2084
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 04:56:52 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id da10so6625470edb.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 04:56:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1678366569;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ru/q2AVdUwJAWeSXRp9GMn60NOVlvm+wcgoK1aArSdM=;
        b=dn4K4WvWlQpEGoFB4tuo7UDZZextIzf4f1tM0Qj7lJfEln/yKEcJJAAOAIsFGYtoE5
         9fgQQ3/ZzmDrFop7nXEDpEZDNPvHtIodBr9JYfWt202FmW3o8SzYF4iwqXqDpEsU6omJ
         ePiX1kJ2jM4+0uqAALF4bUVzGC6Be1J6isxpw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678366569;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ru/q2AVdUwJAWeSXRp9GMn60NOVlvm+wcgoK1aArSdM=;
        b=Uq5yNUG4fbkEGZebI4e4GdgEQaTky2y5H/ChxAqJ2wHBHEL0BOIvtNCtQ1yWgR02ve
         gHpeQXpPIajle3PxhjzoAtodkkYhsw2wNtlx4bbFRh6fO8cb/JFn8QW0rK6LPdcj8Xnt
         D7VaIwnaF6IZWyC4Rhdy2fSAvbeJM62lNZZ2FQ0+SLUrftNLYN/kysQN9tbUiK1lSyCh
         v52Em62Kc+C0mvolYZx5DOqszwZzl3WmNpm5lWmBoiJWApD61fwNmaGZ/pcEAo1mfwtL
         1tAidZPjunPlu4R3RB2wvPXwA135zHWxVzMY3cDUGhUJUmPpB3hWggoitvLJZpDSv1xz
         tHPA==
X-Gm-Message-State: AO0yUKWI7KKJ9g/QXITrKNi3GHnSvj3J1QMIF/Wz/jd7fNcMa6x2GdUK
        aJzET+9KLi1qnkqtBbvI7rYcDpav0uSfZmsshW2llg==
X-Google-Smtp-Source: AK7set+mXmAyPjH4PpelvC6e0xFAfukMa6pmghrwihwJGzuMohyvWxHclURRrJNzD8iqPHhhaxOPhA==
X-Received: by 2002:a17:906:db05:b0:882:cdd4:14d9 with SMTP id xj5-20020a170906db0500b00882cdd414d9mr26386036ejb.46.1678366568858;
        Thu, 09 Mar 2023 04:56:08 -0800 (PST)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:1645:7aa4:a765:1966])
        by smtp.gmail.com with ESMTPSA id hy26-20020a1709068a7a00b008d92897cc29sm8799523ejc.37.2023.03.09.04.56.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 04:56:08 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Thu, 09 Mar 2023 13:55:18 +0100
Subject: [PATCH v6 4/5] media: uvcvideo: Refactor clock circular buffer
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20220920-resend-hwtimestamp-v6-4-c7a99299ec35@chromium.org>
References: <20220920-resend-hwtimestamp-v6-0-c7a99299ec35@chromium.org>
In-Reply-To: <20220920-resend-hwtimestamp-v6-0-c7a99299ec35@chromium.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     linux-media@vger.kernel.org,
        Ricardo Ribalda <ribalda@chromium.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        linux-kernel@vger.kernel.org, "hn.chen" <hn.chen@sunplusit.com>
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=6685; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=CNOqiM4ezF7ILeG8xiZdi/AwLna/49D4dSt5xbUhfs8=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBkCddgr2N61y/Br9Tw6mHj8xKEfrK+/7urrcvSZZSH
 4ojtVwKJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCZAnXYAAKCRDRN9E+zzrEiOyGD/
 9oGFQhpCsXjASjZ8Zx2yor8eO0UpMNgb3Tw4OeuOFAWQC9LGr8G/e+LHLjdo+mgwoWx8R+dE/TgUGG
 nvkZFvJzLkwWO0qUf+G11IA38sE1lAlqw+QhcCCKl9qHz0ihyYGe8vV323NESoSkZzHjIioN+hLmcM
 xcoe9+NH5PdT9iO5vAGOHBfm1HadqMNu+9hL5zWIF/mHM34iWXtF1TVGKWVgXbj3HMNv0nYWd0sP+j
 S/3HznFWhEf9QbVH3QPZblck3ipC7AtXhPnPJFgEgaJoJGQsZLu2IfYHoSoU7xJPCrnyIPQyMAN4Nu
 KSgk+LpKNBpFLOvFZKPk/6uLq8v4HTaLNVK5iijEjVtadh7AZby/9T70dDRcIRnOEYwcVlS+fDyMiS
 CWM3FK8ut2dwOorfNvy3mvRXKQhHFKi294gU1LBREPrqsK8rONzwuz4QzxB0uSTRAbqmJuVG3lrJKe
 4esfAhxuu2+Ej7qyXlFAMkrawBNW+MsFy0jFHE0cSM0sIbk4CI9huLCv2cRdcXyStuakAY9CdElVgj
 9ozD8Cdchv4yc3qO314Jto2PAgK+SrXjpQjQg/uGFK+PsJ5ljPVaRYp3XrerKujDQM1vQt/xctP5nz
 R1u1HLyrTh+U4USfM3zcfjVUK80owt6ze52QgEcQky8vD1OOWvkZvA1Jk2VA==
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
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_video.c | 82 ++++++++++++++++++---------------------
 1 file changed, 37 insertions(+), 45 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
index d5fb0c1339a3..0bb862e8c803 100644
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
 	 * STC (Source Time Clock) is the clock used by the camera. The UVC 1.5
@@ -541,21 +550,21 @@ uvc_video_clock_decode(struct uvc_streaming *stream, struct uvc_buffer *buf,
 	 * and stc and sof are zero.
 	 */
 	if (buf && buf->bytesused == 0 && len == header_size &&
-	    dev_stc == 0 && dev_sof == 0)
+	    sample.dev_stc == 0 && sample.dev_sof == 0)
 		return;
 
-	stream->clock.last_sof = dev_sof;
+	stream->clock.last_sof = sample.dev_sof;
 
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
@@ -2106,7 +2098,7 @@ int uvc_video_resume(struct uvc_streaming *stream, int reset)
 
 	stream->frozen = 0;
 
-	uvc_video_clock_reset(stream);
+	uvc_video_clock_reset(&stream->clock);
 
 	if (!uvc_queue_streaming(&stream->queue))
 		return 0;
@@ -2255,7 +2247,7 @@ int uvc_video_start_streaming(struct uvc_streaming *stream)
 {
 	int ret;
 
-	ret = uvc_video_clock_init(stream);
+	ret = uvc_video_clock_init(&stream->clock);
 	if (ret < 0)
 		return ret;
 
@@ -2273,7 +2265,7 @@ int uvc_video_start_streaming(struct uvc_streaming *stream)
 error_video:
 	usb_set_interface(stream->dev->udev, stream->intfnum, 0);
 error_commit:
-	uvc_video_clock_cleanup(stream);
+	uvc_video_clock_cleanup(&stream->clock);
 
 	return ret;
 }
@@ -2301,5 +2293,5 @@ void uvc_video_stop_streaming(struct uvc_streaming *stream)
 		usb_clear_halt(stream->dev->udev, pipe);
 	}
 
-	uvc_video_clock_cleanup(stream);
+	uvc_video_clock_cleanup(&stream->clock);
 }

-- 
2.40.0.rc0.216.gc4246ad0f0-goog-b4-0.11.0-dev-696ae
