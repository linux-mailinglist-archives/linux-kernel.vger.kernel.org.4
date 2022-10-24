Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC98E60BD30
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 00:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232109AbiJXWO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 18:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232425AbiJXWOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 18:14:00 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF1E55FF47;
        Mon, 24 Oct 2022 13:30:02 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id d26so7638030eje.10;
        Mon, 24 Oct 2022 13:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y/yrkhmb9tAthV0Ih6jG4Lgj5q7DIPyJ6gH6VCA6KiY=;
        b=RoYMwdfZ5hVLNE9a178c+4dilMAsXZLvQ6aJaNOlSOfy91iZdFwVz4IYyAMJhzDWOJ
         Y15WC9ST9YilKFbVoOOUkgtDYqUSinbPAbd7+cJ4wkDw7p+BCAEt4L9MgPMMbAIZCd/x
         0mAamL/Y/RMmytDZ8N3CgTuu73It9W6l1tbEpTe6GVm1JXb3sEnUUOaW5RF3+ZkNzWun
         Yc6ch1AabQOrXdyWNqQhMYm0XRp0r7/BCbEs5J4uOTjNCGhMQSwDFuilO8kEpJPMEeDO
         lDE+/AAUygxZ6b7rZrHEi72oDPkh1OhIbiAaDWEzxpfzc0jBYb2O9GUHlrHQrDpvj7OM
         YvMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y/yrkhmb9tAthV0Ih6jG4Lgj5q7DIPyJ6gH6VCA6KiY=;
        b=zS5v1R/h95xtzR9+LCKOFwzznO2D+xwK43IoLkxFIsZIVyVbGSHMC/Fd3delZHhl78
         eQ+pOOKG4Dz/X7PlzZmMP9Vq7EjEM++g91VKmixCFLDZtA2lq4+5jA6nWHS5C6DL36M2
         JmrKaMzwHXkZOUy6TCs4fLj3qHcJnYV/cj1hVSuoXPevJpdVV/o2GlxByDpZHc07f84B
         b0nXPgS+kY9PXhOVPRQGbuvvrWeRdIa0f3SM2VBZVXhowRYitn0vx8i86DXH8cucxkh8
         G2C9xRSuDQij+lXeeX284O3PUnyNTB9EgmGHVaqe1qbXpCp9mSgQvgSJG/63AcGs0nNO
         telA==
X-Gm-Message-State: ACrzQf273RVh92iVPYbDVmE57u11ojWyZBRbWG77Jk32JrG+5GDXlmD5
        wN1bOAOs/YdRlK018+Z3wJgdKPL8edIy8g==
X-Google-Smtp-Source: AMsMyM7mkAib8Vjas6bq+HemGI/3sQzpoihvo98VYIEWD0NKeQ5VogzERdadSOlwtPwXeAIrpso73w==
X-Received: by 2002:a17:907:6d23:b0:78d:8f0f:1266 with SMTP id sa35-20020a1709076d2300b0078d8f0f1266mr29663460ejc.762.1666642535989;
        Mon, 24 Oct 2022 13:15:35 -0700 (PDT)
Received: from kista.localdomain (82-149-19-102.dynamic.telemach.net. [82.149.19.102])
        by smtp.gmail.com with ESMTPSA id op7-20020a170906bce700b0073d638a7a89sm332023ejb.99.2022.10.24.13.15.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 13:15:35 -0700 (PDT)
From:   Jernej Skrabec <jernej.skrabec@gmail.com>
To:     mripard@kernel.org, paul.kocialkowski@bootlin.com
Cc:     mchehab@kernel.org, gregkh@linuxfoundation.org, wens@csie.org,
        samuel@sholland.org, hverkuil-cisco@xs4all.nl,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH 06/11] media: cedrus: set codec ops immediately
Date:   Mon, 24 Oct 2022 22:15:10 +0200
Message-Id: <20221024201515.34129-7-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221024201515.34129-1-jernej.skrabec@gmail.com>
References: <20221024201515.34129-1-jernej.skrabec@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We'll need codec ops soon after output format is set in following
commits. Let's move current codec setup to set output format callback.
While at it, let's remove one level of indirection by changing
current_codec to point to codec ops structure directly.

Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/staging/media/sunxi/cedrus/cedrus.c   |  5 ---
 drivers/staging/media/sunxi/cedrus/cedrus.h   |  3 +-
 .../staging/media/sunxi/cedrus/cedrus_dec.c   |  4 +-
 .../staging/media/sunxi/cedrus/cedrus_hw.c    |  6 +--
 .../staging/media/sunxi/cedrus/cedrus_video.c | 44 ++++++++-----------
 5 files changed, 25 insertions(+), 37 deletions(-)

diff --git a/drivers/staging/media/sunxi/cedrus/cedrus.c b/drivers/staging/media/sunxi/cedrus/cedrus.c
index 023566b02dc5..8cfe47574c39 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus.c
+++ b/drivers/staging/media/sunxi/cedrus/cedrus.c
@@ -455,11 +455,6 @@ static int cedrus_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	dev->dec_ops[CEDRUS_CODEC_MPEG2] = &cedrus_dec_ops_mpeg2;
-	dev->dec_ops[CEDRUS_CODEC_H264] = &cedrus_dec_ops_h264;
-	dev->dec_ops[CEDRUS_CODEC_H265] = &cedrus_dec_ops_h265;
-	dev->dec_ops[CEDRUS_CODEC_VP8] = &cedrus_dec_ops_vp8;
-
 	mutex_init(&dev->dev_mutex);
 
 	INIT_DELAYED_WORK(&dev->watchdog_work, cedrus_watchdog);
diff --git a/drivers/staging/media/sunxi/cedrus/cedrus.h b/drivers/staging/media/sunxi/cedrus/cedrus.h
index 7a1619967513..0b082b1fae22 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus.h
+++ b/drivers/staging/media/sunxi/cedrus/cedrus.h
@@ -126,7 +126,7 @@ struct cedrus_ctx {
 
 	struct v4l2_pix_format		src_fmt;
 	struct v4l2_pix_format		dst_fmt;
-	enum cedrus_codec		current_codec;
+	struct cedrus_dec_ops		*current_codec;
 
 	struct v4l2_ctrl_handler	hdl;
 	struct v4l2_ctrl		**ctrls;
@@ -185,7 +185,6 @@ struct cedrus_dev {
 	struct platform_device	*pdev;
 	struct device		*dev;
 	struct v4l2_m2m_dev	*m2m_dev;
-	struct cedrus_dec_ops	*dec_ops[CEDRUS_CODEC_LAST];
 
 	/* Device file mutex */
 	struct mutex		dev_mutex;
diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_dec.c b/drivers/staging/media/sunxi/cedrus/cedrus_dec.c
index e7f7602a5ab4..fbbf9e6f0f50 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus_dec.c
+++ b/drivers/staging/media/sunxi/cedrus/cedrus_dec.c
@@ -94,7 +94,7 @@ void cedrus_device_run(void *priv)
 
 	cedrus_dst_format_set(dev, &ctx->dst_fmt);
 
-	error = dev->dec_ops[ctx->current_codec]->setup(ctx, &run);
+	error = ctx->current_codec->setup(ctx, &run);
 	if (error)
 		v4l2_err(&ctx->dev->v4l2_dev,
 			 "Failed to setup decoding job: %d\n", error);
@@ -110,7 +110,7 @@ void cedrus_device_run(void *priv)
 		schedule_delayed_work(&dev->watchdog_work,
 				      msecs_to_jiffies(2000));
 
-		dev->dec_ops[ctx->current_codec]->trigger(ctx);
+		ctx->current_codec->trigger(ctx);
 	} else {
 		v4l2_m2m_buf_done_and_job_finish(ctx->dev->m2m_dev,
 						 ctx->fh.m2m_ctx,
diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_hw.c b/drivers/staging/media/sunxi/cedrus/cedrus_hw.c
index a6470a89851e..c3387cd1e80f 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus_hw.c
+++ b/drivers/staging/media/sunxi/cedrus/cedrus_hw.c
@@ -132,12 +132,12 @@ static irqreturn_t cedrus_irq(int irq, void *data)
 		return IRQ_NONE;
 	}
 
-	status = dev->dec_ops[ctx->current_codec]->irq_status(ctx);
+	status = ctx->current_codec->irq_status(ctx);
 	if (status == CEDRUS_IRQ_NONE)
 		return IRQ_NONE;
 
-	dev->dec_ops[ctx->current_codec]->irq_disable(ctx);
-	dev->dec_ops[ctx->current_codec]->irq_clear(ctx);
+	ctx->current_codec->irq_disable(ctx);
+	ctx->current_codec->irq_clear(ctx);
 
 	if (status == CEDRUS_IRQ_ERROR)
 		state = VB2_BUF_STATE_ERROR;
diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_video.c b/drivers/staging/media/sunxi/cedrus/cedrus_video.c
index 04b7b87ef0b7..3591bf9d7d9c 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus_video.c
+++ b/drivers/staging/media/sunxi/cedrus/cedrus_video.c
@@ -335,6 +335,21 @@ static int cedrus_s_fmt_vid_out_p(struct cedrus_ctx *ctx,
 		break;
 	}
 
+	switch (ctx->src_fmt.pixelformat) {
+	case V4L2_PIX_FMT_MPEG2_SLICE:
+		ctx->current_codec = &cedrus_dec_ops_mpeg2;
+		break;
+	case V4L2_PIX_FMT_H264_SLICE:
+		ctx->current_codec = &cedrus_dec_ops_h264;
+		break;
+	case V4L2_PIX_FMT_HEVC_SLICE:
+		ctx->current_codec = &cedrus_dec_ops_h265;
+		break;
+	case V4L2_PIX_FMT_VP8_FRAME:
+		ctx->current_codec = &cedrus_dec_ops_vp8;
+		break;
+	}
+
 	/* Propagate format information to capture. */
 	ctx->dst_fmt.colorspace = pix_fmt->colorspace;
 	ctx->dst_fmt.xfer_func = pix_fmt->xfer_func;
@@ -493,34 +508,13 @@ static int cedrus_start_streaming(struct vb2_queue *vq, unsigned int count)
 	struct cedrus_dev *dev = ctx->dev;
 	int ret = 0;
 
-	switch (ctx->src_fmt.pixelformat) {
-	case V4L2_PIX_FMT_MPEG2_SLICE:
-		ctx->current_codec = CEDRUS_CODEC_MPEG2;
-		break;
-
-	case V4L2_PIX_FMT_H264_SLICE:
-		ctx->current_codec = CEDRUS_CODEC_H264;
-		break;
-
-	case V4L2_PIX_FMT_HEVC_SLICE:
-		ctx->current_codec = CEDRUS_CODEC_H265;
-		break;
-
-	case V4L2_PIX_FMT_VP8_FRAME:
-		ctx->current_codec = CEDRUS_CODEC_VP8;
-		break;
-
-	default:
-		return -EINVAL;
-	}
-
 	if (V4L2_TYPE_IS_OUTPUT(vq->type)) {
 		ret = pm_runtime_resume_and_get(dev->dev);
 		if (ret < 0)
 			goto err_cleanup;
 
-		if (dev->dec_ops[ctx->current_codec]->start) {
-			ret = dev->dec_ops[ctx->current_codec]->start(ctx);
+		if (ctx->current_codec->start) {
+			ret = ctx->current_codec->start(ctx);
 			if (ret)
 				goto err_pm;
 		}
@@ -542,8 +536,8 @@ static void cedrus_stop_streaming(struct vb2_queue *vq)
 	struct cedrus_dev *dev = ctx->dev;
 
 	if (V4L2_TYPE_IS_OUTPUT(vq->type)) {
-		if (dev->dec_ops[ctx->current_codec]->stop)
-			dev->dec_ops[ctx->current_codec]->stop(ctx);
+		if (ctx->current_codec->stop)
+			ctx->current_codec->stop(ctx);
 
 		pm_runtime_put(dev->dev);
 	}
-- 
2.38.1

