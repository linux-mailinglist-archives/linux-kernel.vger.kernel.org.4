Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6BF56B39A7
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 10:07:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231547AbjCJJHm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 04:07:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjCJJGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 04:06:43 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F1A911258F
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 01:02:40 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id i34so17611708eda.7
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 01:02:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1678438935;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1nm96Wrt6gyEIi1trIE8ggK/zsqJmxHOVJaDLG8Q4K4=;
        b=dfDNrC0ZLZtziQjxrQ827AzIfRrdg85nRDa5OZ3OAtO+bStH7Izi+nC02g8UG+RUd+
         OYTDfM0WOemGp3oVfnjmrLoF/rXcjz6wT7qOZY9AkUr2B6ze7MYeA/xSBXUdN+JC2d9w
         bNHExn7H8B8MzdFqEipTSicJQMh1tgprtlhSA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678438935;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1nm96Wrt6gyEIi1trIE8ggK/zsqJmxHOVJaDLG8Q4K4=;
        b=BhSiapVcfTH1oGZAGZqXfk6G3l6QAsIYRZYngyN0fJqZ2yXZD2uXnA/A4WvsX945IU
         tH5Sd3iZsK3GOBDG7xbAut0rpY4Y+Ou5/Kese+pOOhRVEeuqT2N8sLz0Rhe82B5JIgMc
         V+CmgVtZx33ioE/9Mzx4l/H7O6CJaYuLECS+obIA79b8PF/imqGjuNaZ1as/VGlqqiiY
         EJZlQ3BC8GjlA78eBqvu2YD88tg4r/pskVMMpI6ips8sd5lEJl8+MyXLqu3dPw88iKjO
         m8TC4cOjmd4BxmxRSgNqQRhfVCmtxt8P2bwHpGtczB76LLtKtZq8UzK8VJd7OhMMSa81
         B20Q==
X-Gm-Message-State: AO0yUKUj950kgnssd8p3lW0DdWDVSC0baDCZEtpXVFzQcauYcBnlVpvv
        5r8QMpmglJgO2pA2/qppyqDfDA==
X-Google-Smtp-Source: AK7set8uBJUWEdjTJ8acxq8/GZ0DAAdqZ0/iRxCNqAQ28wKNp1xWI8Xihg28oO14JL6zkHe+c262zA==
X-Received: by 2002:a17:906:66cd:b0:8e8:602f:847a with SMTP id k13-20020a17090666cd00b008e8602f847amr23072180ejp.24.1678438935445;
        Fri, 10 Mar 2023 01:02:15 -0800 (PST)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:ef69:7ab6:87ac:99f])
        by smtp.gmail.com with ESMTPSA id s5-20020a170906454500b008b23b22b062sm692931ejq.114.2023.03.10.01.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 01:02:15 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Fri, 10 Mar 2023 10:01:32 +0100
Subject: [PATCH v7 5/6] media: uvcvideo: Refactor clock circular buffer
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20220920-resend-hwtimestamp-v7-5-cf1d78bb8821@chromium.org>
References: <20220920-resend-hwtimestamp-v7-0-cf1d78bb8821@chromium.org>
In-Reply-To: <20220920-resend-hwtimestamp-v7-0-cf1d78bb8821@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Ricardo Ribalda <ribalda@chromium.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        "hn.chen" <hn.chen@sunplusit.com>
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=6685; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=K1XWiZZVgbVikxQUf2acjH8pNqXvxOd5rL4C6h3qVQI=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBkCvINr+ZwSCAqRUItGprR4yFuX8Jm0ErN3ZjNeUt+
 YTHQm4SJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCZAryDQAKCRDRN9E+zzrEiGh+D/
 4n3tTAxb4vRF+tYvF0MSi562VBo4IhUak2Jrl591uTCzcc2xTtxsLF7VRE3WPdLIfvD1SiJ7l5oMX8
 vmN3UwtjS9smDKz310p1dROTT3s2xmTGxDq21q06O/6h4YsV9oRsLX+9+ikoDND4XfBAYEco9VFxhc
 kfO6fjOAbUA2Jdp8EZL+Uw38RuommvxaWmG99Ejeh0q4PqLsiT0N1/5WDrjfXuPDuSmfsTwT+kyWSM
 CVakUrqH4MWt8smN24MzoVuHu9eZvslCmCsdvwICDf1aEDgMxxIT4MtYlo/1dAskZf67qBX/TOZtnM
 zLjtg3/dQkWvom2DFqJIZDfEM2dY44Z4M60oQ7kGwW+65wg0vpXpDtxToVfEIfF90cQF3gFKF2gqK7
 xhN0tpuADROLSG1+Mx7L1ZIC1SEb/33ux8ZJLwEAlikI2d33Cnt5NQPBo0mPnBDF1ipvf1elupsOaN
 GngxtY1+UscwnBxqoMNXH+N0rmxnLaH/D1VMCTb+70uJP41HP3FmiLleENwG4GKXKHS9f76yK68Kal
 WrMdx3pMGXyjytwuO3cziB4I3ZxEG5+LWXktCvlx+TZt2HQdpo8KDmPE/wmr5D96i8277us3+yfTTh
 /8nWkhFB/TObJccEmiFoACpCCRAMnqQcz45869ijeO09QKQXmQ6KOL3TJR0g==
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
 drivers/media/usb/uvc/uvc_video.c | 82 ++++++++++++++++++---------------------
 1 file changed, 37 insertions(+), 45 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
index 6d0243ea0e07..8156efcf48ac 100644
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
