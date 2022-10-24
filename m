Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F27F60BD08
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 00:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231564AbiJXWE0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 18:04:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231588AbiJXWDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 18:03:39 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9082C16;
        Mon, 24 Oct 2022 13:17:47 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id bj12so7530462ejb.13;
        Mon, 24 Oct 2022 13:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4uzd84Lo8isAFXRphDOp8YM5rfTGeiE2OqupA7quo4Y=;
        b=cqKQd2gKzVNMX+5x/YFpR+RBIFY+Djo+X6IMVKyhCRl8jxEW9kQOGfDZBiKyi7ljRg
         C/MtxDmJB5eZ5EinpJIBOJR2Ku57De+BBMw2S6bygvkqrRBWmJyM9vt3b1sC/f3LPXm9
         TR3dGaW7uEsETlRJeqcAiqJrJgAMOTRm/FCAKLEyTXIt4oGAFgmBAlg7bcIYEDI44DJh
         hFyqnA2iWsa9rA3oJZtyGyum7LI4qFX8EOP+B5pjkgwxhnCtXb40WvpX4QSJMUU63ReV
         jGoVJzuekyzC2Zh8lvM2DKNIGS46F5G7smK/jWJNfEjha2sV8rojZkz3JNfg2GiPqnIB
         8DEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4uzd84Lo8isAFXRphDOp8YM5rfTGeiE2OqupA7quo4Y=;
        b=hoRN24rfQwMTWHhr745hj1hCksBTq62lKdGFeb6U6T5mBs1N/k2kYSanl/mB8cL8On
         Fox7L2yQhEvHIHBYAu+glkjubAx3ju2tY72cTcMzJaJZHV+WRiPdKT/IHIFUmmfymq1S
         BoVtLipyVz05+46rzPU+kqQCb56NLj7qBKoitCc3aYg3llELP4Zb3r5TucTmHW4YTlCQ
         lemaw5UsiFcD/loj5a/sRzQUla6FNGoxOvVGO7M3eFHtKhN4MF3wjhWWTsKYIkN4ESjw
         uwtyZrKBqsyJIEsvRiO62HvoPYb4e85DKupCtE1hqmcOJTzAT8UxwTh9CrtKHVVkI/1w
         lDAA==
X-Gm-Message-State: ACrzQf3soUkxJ+/XO6EHlWL/iVpHUggJUeHgB+JmsqWCmPQzu52fxgBA
        m6518+R/gt9aSqv8j8scUiE=
X-Google-Smtp-Source: AMsMyM5a1fFesN6Xv5JdVWJVMUmrPtaffB92DG3AKHlTspfIWZBbrPujPVZGyamxMEfJUy8/RGeMUw==
X-Received: by 2002:a17:906:ef8c:b0:78d:46b7:6847 with SMTP id ze12-20020a170906ef8c00b0078d46b76847mr28751369ejb.241.1666642531636;
        Mon, 24 Oct 2022 13:15:31 -0700 (PDT)
Received: from kista.localdomain (82-149-19-102.dynamic.telemach.net. [82.149.19.102])
        by smtp.gmail.com with ESMTPSA id op7-20020a170906bce700b0073d638a7a89sm332023ejb.99.2022.10.24.13.15.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 13:15:31 -0700 (PDT)
From:   Jernej Skrabec <jernej.skrabec@gmail.com>
To:     mripard@kernel.org, paul.kocialkowski@bootlin.com
Cc:     mchehab@kernel.org, gregkh@linuxfoundation.org, wens@csie.org,
        samuel@sholland.org, hverkuil-cisco@xs4all.nl,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH 02/11] media: cedrus: Add format reset helpers
Date:   Mon, 24 Oct 2022 22:15:06 +0200
Message-Id: <20221024201515.34129-3-jernej.skrabec@gmail.com>
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

By re-arranging try format handlers and set out format handler, we can
easily implement reset out/cap format helpers.

There is only one subtle, but important functional change. Capture
pixel format will be reset each time output format is set. This is
actually expected behaviour per stateless decoder API.

Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 .../staging/media/sunxi/cedrus/cedrus_video.c | 100 +++++++++++-------
 .../staging/media/sunxi/cedrus/cedrus_video.h |   2 +
 2 files changed, 66 insertions(+), 36 deletions(-)

diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_video.c b/drivers/staging/media/sunxi/cedrus/cedrus_video.c
index 1c3c1d080d31..27a7120fa6fb 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus_video.c
+++ b/drivers/staging/media/sunxi/cedrus/cedrus_video.c
@@ -241,12 +241,10 @@ static int cedrus_g_fmt_vid_out(struct file *file, void *priv,
 	return 0;
 }
 
-static int cedrus_try_fmt_vid_cap(struct file *file, void *priv,
-				  struct v4l2_format *f)
+static int cedrus_try_fmt_vid_cap_p(struct cedrus_ctx *ctx,
+				    struct v4l2_pix_format *pix_fmt)
 {
-	struct cedrus_ctx *ctx = cedrus_file2ctx(file);
 	struct cedrus_dev *dev = ctx->dev;
-	struct v4l2_pix_format *pix_fmt = &f->fmt.pix;
 	struct cedrus_format *fmt =
 		cedrus_find_format(pix_fmt->pixelformat, CEDRUS_DECODE_DST,
 				   dev->capabilities);
@@ -262,12 +260,16 @@ static int cedrus_try_fmt_vid_cap(struct file *file, void *priv,
 	return 0;
 }
 
-static int cedrus_try_fmt_vid_out(struct file *file, void *priv,
+static int cedrus_try_fmt_vid_cap(struct file *file, void *priv,
 				  struct v4l2_format *f)
 {
-	struct cedrus_ctx *ctx = cedrus_file2ctx(file);
+	return cedrus_try_fmt_vid_cap_p(cedrus_file2ctx(file), &f->fmt.pix);
+}
+
+static int cedrus_try_fmt_vid_out_p(struct cedrus_ctx *ctx,
+				    struct v4l2_pix_format *pix_fmt)
+{
 	struct cedrus_dev *dev = ctx->dev;
-	struct v4l2_pix_format *pix_fmt = &f->fmt.pix;
 	struct cedrus_format *fmt =
 		cedrus_find_format(pix_fmt->pixelformat, CEDRUS_DECODE_SRC,
 				   dev->capabilities);
@@ -281,6 +283,12 @@ static int cedrus_try_fmt_vid_out(struct file *file, void *priv,
 	return 0;
 }
 
+static int cedrus_try_fmt_vid_out(struct file *file, void *priv,
+				  struct v4l2_format *f)
+{
+	return cedrus_try_fmt_vid_out_p(cedrus_file2ctx(file), &f->fmt.pix);
+}
+
 static int cedrus_s_fmt_vid_cap(struct file *file, void *priv,
 				struct v4l2_format *f)
 {
@@ -301,13 +309,60 @@ static int cedrus_s_fmt_vid_cap(struct file *file, void *priv,
 	return 0;
 }
 
+void cedrus_reset_cap_format(struct cedrus_ctx *ctx)
+{
+	ctx->dst_fmt.pixelformat = 0;
+	cedrus_try_fmt_vid_cap_p(ctx, &ctx->dst_fmt);
+}
+
+static int cedrus_s_fmt_vid_out_p(struct cedrus_ctx *ctx,
+				  struct v4l2_pix_format *pix_fmt)
+{
+	struct vb2_queue *vq;
+	int ret;
+
+	ret = cedrus_try_fmt_vid_out_p(ctx, pix_fmt);
+	if (ret)
+		return ret;
+
+	ctx->src_fmt = *pix_fmt;
+
+	vq = v4l2_m2m_get_vq(ctx->fh.m2m_ctx, V4L2_BUF_TYPE_VIDEO_OUTPUT);
+
+	switch (ctx->src_fmt.pixelformat) {
+	case V4L2_PIX_FMT_H264_SLICE:
+	case V4L2_PIX_FMT_HEVC_SLICE:
+		vq->subsystem_flags |=
+			VB2_V4L2_FL_SUPPORTS_M2M_HOLD_CAPTURE_BUF;
+		break;
+	default:
+		vq->subsystem_flags &=
+			~VB2_V4L2_FL_SUPPORTS_M2M_HOLD_CAPTURE_BUF;
+		break;
+	}
+
+	/* Propagate format information to capture. */
+	ctx->dst_fmt.colorspace = pix_fmt->colorspace;
+	ctx->dst_fmt.xfer_func = pix_fmt->xfer_func;
+	ctx->dst_fmt.ycbcr_enc = pix_fmt->ycbcr_enc;
+	ctx->dst_fmt.quantization = pix_fmt->quantization;
+	cedrus_reset_cap_format(ctx);
+
+	return 0;
+}
+
+void cedrus_reset_out_format(struct cedrus_ctx *ctx)
+{
+	ctx->src_fmt.pixelformat = 0;
+	cedrus_s_fmt_vid_out_p(ctx, &ctx->src_fmt);
+}
+
 static int cedrus_s_fmt_vid_out(struct file *file, void *priv,
 				struct v4l2_format *f)
 {
 	struct cedrus_ctx *ctx = cedrus_file2ctx(file);
 	struct vb2_queue *vq;
 	struct vb2_queue *peer_vq;
-	int ret;
 
 	vq = v4l2_m2m_get_vq(ctx->fh.m2m_ctx, f->type);
 	/*
@@ -328,34 +383,7 @@ static int cedrus_s_fmt_vid_out(struct file *file, void *priv,
 	if (vb2_is_busy(peer_vq))
 		return -EBUSY;
 
-	ret = cedrus_try_fmt_vid_out(file, priv, f);
-	if (ret)
-		return ret;
-
-	ctx->src_fmt = f->fmt.pix;
-
-	switch (ctx->src_fmt.pixelformat) {
-	case V4L2_PIX_FMT_H264_SLICE:
-	case V4L2_PIX_FMT_HEVC_SLICE:
-		vq->subsystem_flags |=
-			VB2_V4L2_FL_SUPPORTS_M2M_HOLD_CAPTURE_BUF;
-		break;
-	default:
-		vq->subsystem_flags &=
-			~VB2_V4L2_FL_SUPPORTS_M2M_HOLD_CAPTURE_BUF;
-		break;
-	}
-
-	/* Propagate format information to capture. */
-	ctx->dst_fmt.colorspace = f->fmt.pix.colorspace;
-	ctx->dst_fmt.xfer_func = f->fmt.pix.xfer_func;
-	ctx->dst_fmt.ycbcr_enc = f->fmt.pix.ycbcr_enc;
-	ctx->dst_fmt.quantization = f->fmt.pix.quantization;
-	ctx->dst_fmt.width = ctx->src_fmt.width;
-	ctx->dst_fmt.height = ctx->src_fmt.height;
-	cedrus_prepare_format(&ctx->dst_fmt);
-
-	return 0;
+	return cedrus_s_fmt_vid_out_p(cedrus_file2ctx(file), &f->fmt.pix);
 }
 
 const struct v4l2_ioctl_ops cedrus_ioctl_ops = {
diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_video.h b/drivers/staging/media/sunxi/cedrus/cedrus_video.h
index 05050c0a0921..8e1afc16a6a1 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus_video.h
+++ b/drivers/staging/media/sunxi/cedrus/cedrus_video.h
@@ -27,5 +27,7 @@ extern const struct v4l2_ioctl_ops cedrus_ioctl_ops;
 int cedrus_queue_init(void *priv, struct vb2_queue *src_vq,
 		      struct vb2_queue *dst_vq);
 void cedrus_prepare_format(struct v4l2_pix_format *pix_fmt);
+void cedrus_reset_cap_format(struct cedrus_ctx *ctx);
+void cedrus_reset_out_format(struct cedrus_ctx *ctx);
 
 #endif
-- 
2.38.1

