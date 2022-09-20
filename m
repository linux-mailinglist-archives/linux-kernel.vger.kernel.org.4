Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B235A5BE830
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 16:11:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231561AbiITOJF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 10:09:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231515AbiITOIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 10:08:38 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA2056BB9
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 07:08:34 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id 13so6485199ejn.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 07:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date;
        bh=NCc5XnE86A35upfQb7w9Zg49ZtxeysSLRX/7yyxgtR0=;
        b=BX1eXrPvlIVcwDO3uOoPlFa+ImKnuEQCQV/DWcnsoCT6sqrex4Hu7kkrwCgLMyWJtx
         UNJcjUQV2YD8jravMv0yw7c/xqBO25g8hMAACLntYpoJoUXKUELs4ZOkieYcfdHHBhFd
         l/quskDGx3sQyd4FHgPSVZrexFzLbKQLo3caM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=NCc5XnE86A35upfQb7w9Zg49ZtxeysSLRX/7yyxgtR0=;
        b=sC6Q089eNIuOZkrkItvExp56EnsV4dECKC3LoqDhtY0PIy458RBnUrG/JqJMNSljB1
         BXybzPNH7ABFYTlsvqeet/+dXQZUbQXWvKUboQi6OXkH+nxLjJNi+1WCnHDsx80M6uW/
         K+8JAxle0KVtVRGw7z/tzp3awBbDFbs6efZTsKOIPnm51XVG11N0y4deUc7PA8heY+qM
         Wh2R2xxuP9Q3lcyih+1+PNr8zoI/4f6pZ5Fjrh+iyR54xU0wzhbbE2mZiCbzVjXiYWs1
         S6Xzi6G1Ur8KpEmaXVoFxfkqhccv96gRB/Uy0D983N0EJFR0n6ep402nbS8SLMh1TKKu
         DwSQ==
X-Gm-Message-State: ACrzQf24i7G7O1kvgyWU795OJ93pSo1tPxeGYmfBv30ude+ex/ggq1wA
        Bp8VBnv3ccYCposZ4q4KoThARRm4DDvcpCB6LO8=
X-Google-Smtp-Source: AMsMyM7PE6lyS3+0vtSumMvg+ryWzwkFIVOxy/qOiei/xbbb0im3D3s8lTsiQHWWrV9HXqQr9yDzsQ==
X-Received: by 2002:a17:906:cc4a:b0:779:ed37:b5a3 with SMTP id mm10-20020a170906cc4a00b00779ed37b5a3mr16861886ejb.626.1663682914022;
        Tue, 20 Sep 2022 07:08:34 -0700 (PDT)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:935d:52b0:7461:88e1])
        by smtp.gmail.com with ESMTPSA id j17-20020a17090623f100b0077016f4c6d4sm936564ejg.55.2022.09.20.07.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 07:08:33 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Tue, 20 Sep 2022 16:08:13 +0200
Subject: [PATCH v1 7/8] media: uvcvideo: Refactor clock circular buffer
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20220920-resend-hwtimestamp-v1-7-e9c14b258404@chromium.org>
References: <20220920-resend-hwtimestamp-v1-0-e9c14b258404@chromium.org>
In-Reply-To: <20220920-resend-hwtimestamp-v1-0-e9c14b258404@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     "hn.chen" <hn.chen@sunplusit.com>,
        Ricardo Ribalda <ribalda@chromium.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
X-Mailer: b4 0.11.0-dev-d93f8
X-Developer-Signature: v=1; a=openpgp-sha256; l=5683; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=z/+kzQHc3YxeEXHUqT6czLGAa5vbV9no6M5D99w9Aks=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjKclW0N/GT6a158BpvExijGgXwYoWPIwxcszDBMi7
 C5iAMHCJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCYynJVgAKCRDRN9E+zzrEiGC4EA
 CKtFH0hEXzzHQtBofaYIEP0M3h7dxYuzsCo0upAQgd5jzreQXQPSfq4+hIHvfBqlKEWYO8j1Kl5BVw
 jcs9KGfYF3H+Oxk2tAlNHpvh/MehKyHnE9HtNbQjkU9OEOcoEQElSleKv9meMo7eKZ0t59K9tlVNRv
 0z/MaIVQCFJ8slQ5YxkqP6OGJoUCqcr4w4fVYvGKQf758AFB5AHRdyoFC8zZR7ARU7MnUNnQRnqHu1
 4FQ2rxxukpuiuzwZaiyBqT0IWVohLEk/1X16na43YkMdBqhFODfxt6M0W4CtmWXINvx+5pvYf4RKgF
 tPsK3IFGY8sY2LJ6fRu3pLcRHahGF2lxvxpR6f4C+ZsJSU96txF693nooIQcwqQVuZwbBDIfPDv5iF
 Wgex9vKVDIeh7Jt44sQXJ6yYFZ/TtaDahxhL1lR+mZcZBVTsHtPxvFpHNphehj/n/m+h1cAesTsJBg
 2T1GpsRCbJDPHZCPUvjhJnHpucaRohuofM+LXHcihW40X8TC/ku/Gd7psBf3ytCyKwc1f4zJQCiC5f
 qJCD6ZOure5118fJouhI0V5F7HVrAbpGMd3eAuDv6UxWfJdU4BipA6TiNoNCwrTUApUlvIVLtGfp8F
 vNjD/8l2RRUQvxsMubsWoJQyBHKULQNpoNWmGS4a+QCVT3vK791zMsyVcJsQ==
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

Move the addition to the buffer into its own function and remove the
stream dependency to all the clock functions.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
index 7c7fb478aef7..9e7ab7ef8624 100644
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
@@ -2077,7 +2070,7 @@ int uvc_video_resume(struct uvc_streaming *stream, int reset)
 
 	stream->frozen = 0;
 
-	uvc_video_clock_reset(stream);
+	uvc_video_clock_reset(&stream->clock);
 
 	if (!uvc_queue_streaming(&stream->queue))
 		return 0;
@@ -2211,7 +2204,7 @@ int uvc_video_start_streaming(struct uvc_streaming *stream)
 {
 	int ret;
 
-	ret = uvc_video_clock_init(stream);
+	ret = uvc_video_clock_init(&stream->clock);
 	if (ret < 0)
 		return ret;
 
@@ -2229,7 +2222,7 @@ int uvc_video_start_streaming(struct uvc_streaming *stream)
 error_video:
 	usb_set_interface(stream->dev->udev, stream->intfnum, 0);
 error_commit:
-	uvc_video_clock_cleanup(stream);
+	uvc_video_clock_cleanup(&stream->clock);
 
 	return ret;
 }
@@ -2257,5 +2250,5 @@ void uvc_video_stop_streaming(struct uvc_streaming *stream)
 		usb_clear_halt(stream->dev->udev, pipe);
 	}
 
-	uvc_video_clock_cleanup(stream);
+	uvc_video_clock_cleanup(&stream->clock);
 }

-- 
b4 0.11.0-dev-d93f8
