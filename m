Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3C76617E30
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 14:42:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231818AbiKCNl4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 09:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231696AbiKCNlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 09:41:15 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E558DB4A8
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 06:41:13 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id v27so3087674eda.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 06:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=psoRMtYNQ67Qjhdcr6Qino20QujIYk2bcuQnFUuY+cM=;
        b=h2qCos2vriedJW0565u21lOIDK2ZXT5CCnGPJl414YMJ70OF6mdre0wcsNWip00EJK
         +VdgkIjiL7h2IsmFTUXwESgwAL+sF+BbBIU+giGCvmWdWFZtg/yBef8oE0v0noasB2fL
         YMszHZJc6WGNgzp8eCqHh7uS36aLaB+dFLj10=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=psoRMtYNQ67Qjhdcr6Qino20QujIYk2bcuQnFUuY+cM=;
        b=K/4Dd1xh50pB619biHDy963Fi0yPo+I7oNqFoQg63okCpyRaZJYF7eB3uLqx7gCNDg
         68IRgvNcTkwpInVkNi/oZI/0lnot6MyGvD5lw6lU59Eyavu8IjkRjKPdjJTtXHM5h2IP
         4VQdbeaj2XR+ys3JcHLV5IpY9avselBUZQz7t5tFkycq/a58W0DjLVGOhi/F1U5Kq0fh
         CaogcsIMU/fji28xrOXVduzTSi4+ACnjZp4774rrhNOzNwSAujlUm9UNd/s7ZlrPrETq
         rFT+ytCSvxSs7q/FJ7GX1ujb+z2xWK6a0Rz9PJHG8Tl0ra7MtsAsKvtN1xIPodh5M5jm
         soSQ==
X-Gm-Message-State: ACrzQf1+72A8a7OLBwgusdFEy6F0dRSC6juwqKbF/bT7lTcp2yo6jNxx
        zVvTiUPUHj6BgnOOPSHdHsuZ7pHTfbzQtWG+
X-Google-Smtp-Source: AMsMyM7oiHGlfoW7FoL3DuJb3gjRj700EHqmttlk5J2QLG9+Q+Ni1D3Th3bKTHJyhZR3nvZ9dYUZbQ==
X-Received: by 2002:a50:ed82:0:b0:461:ab45:df1a with SMTP id h2-20020a50ed82000000b00461ab45df1amr30226646edr.295.1667482872297;
        Thu, 03 Nov 2022 06:41:12 -0700 (PDT)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:c1a3:5bc:2068:8f2c])
        by smtp.gmail.com with ESMTPSA id j1-20020a17090623e100b0078d46aa3b82sm521948ejg.21.2022.11.03.06.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 06:41:12 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Thu, 03 Nov 2022 14:40:48 +0100
Subject: [PATCH v2 7/8] media: uvcvideo: Refactor clock circular buffer
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20220920-resend-hwtimestamp-v2-7-d8d0616bb612@chromium.org>
References: <20220920-resend-hwtimestamp-v2-0-d8d0616bb612@chromium.org>
In-Reply-To: <20220920-resend-hwtimestamp-v2-0-d8d0616bb612@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     HungNien Chen <hn.chen@sunplusit.com>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.11.0-dev-d93f8
X-Developer-Signature: v=1; a=openpgp-sha256; l=5733; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=jKLEhWOw50KCtY3geJta/+rFLohqmF2gBH8KzE83PQA=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjY8Tv47RijJ+yGizQXGOfNQ8/ZeH569iaM4vQ+yoE
 t9mQGl+JAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY2PE7wAKCRDRN9E+zzrEiCipD/
 4+sgbPvtCjP4KFkF9Aw6yYFYZVZRR7jLD6vlhTeTkQCxU5SQ48w+nH/7mBahAyKP1etMVa2abI9rzF
 BiumH0x7Q0TSnlRVs2Zz0jguw5mgN/a+b1DiQdjuoOK1ugT1D0q1Hx9G4/ku0fpEVnzmlJwLsYNaxh
 Tvoe8+IKd4cQgctZmTLH8uLTVK/sLyz9BAHLDORUCz6uJRmxc4BcaO/NEYcMIq9XUDZjiIStCPuZAD
 FZRFvPIN/5/iYxmV/UjLCpt3D0ZZBnzgV9XE9f45DFUO1MuiaZ4GAEnWvkFd7uv4TcVca4EJHK6nh0
 Ak5o/pxczaqgFvIF9r4A951AqqdhMl42joBIFN7qP1erW4Zdbdg/fzmCeox+J+mYtVL/ri4+IVIst0
 RGKmlkOMpdLAFcJzSxJnGqbxAJZpVEhoinpWRktqMw1NhqrG3nze/NPSYpB86+2PJTLufVMTDY617M
 bK4q6N0kkN3jcJ2HKUav6z7MHMN+5lT7W13I1pOCfDwhezsOpCOF3xX00BsvUOv7JVgDtaPU6gmPLr
 Vb9QW4X1DEASoMqGh7pvoWH6x0Lw00TQ6Om51eCZozg+68QaxNdp7Op3/lxO0fNAFbImHZQObCGXRk
 1a9d8mu5qIDLHMQRSE2x8MyzNU7zhPq06Rvnzsmnbu9OHwmUU6hVUxa4LfNQ==
X-Developer-Key: i=ribalda@chromium.org; a=openpgp;
 fpr=9EC3BB66E2FC129A6F90B39556A0D81F9F782DA9
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
b4 0.11.0-dev-d93f8
