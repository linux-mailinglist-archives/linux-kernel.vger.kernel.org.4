Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C713616BB9
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 19:08:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231428AbiKBSIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 14:08:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231235AbiKBSIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 14:08:23 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91440641B;
        Wed,  2 Nov 2022 11:08:21 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id r14so27731719edc.7;
        Wed, 02 Nov 2022 11:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4uzd84Lo8isAFXRphDOp8YM5rfTGeiE2OqupA7quo4Y=;
        b=V2JHHP2kl5m1wWWBT62YhSuax2oWvTafyIGpWoP3EO6VF+iu7LAFuxpM9O6WMAqfS9
         +L7V7E4CnsEbUwec0aUbvxG2i+vPMC2bSiKtuD29FL7bBkO3sWX3uw+9NufO+iPGyA9Q
         9XYOOZrqQly9P29PviUHrQd7lPxp+riDh3E9ZrqQJEuNc4H5FyrBsrV/DlXF7qBILi/k
         vyYY/8ymtmDCB4N/yOSNBZIerOvgMDMdLVF1nF+J0pwYF2emdzw8pZHLahkrNC4GMU5s
         kwbTimZdZUahGB3wWqZfGgQawKTCUNAN+7SIs3ALYQK++O33EwUuEGSwJ+GiEdJcXaWf
         p5vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4uzd84Lo8isAFXRphDOp8YM5rfTGeiE2OqupA7quo4Y=;
        b=YDz4r3PdLbigwwn7MZh3qQqm/WqWVbaKJtbBf3S3pBRfCJlaGUo/+Gc5wrUmXPlnfa
         EU2Xr1RLswgXPCjaB2MPgNuTpTYQO5Qmwam+TBIfQAYJYxAwyH+IdAlNBTMZrS/lOz7w
         cUA01ytYXUYGP5BtMcOeaADwvaWlqsP0Ka8y6co4gkG3o7k0OcDNzEcIq/e2bFuLgvlP
         dbW98xkiG290Muamw4jj0adtYpl4LoS5g1Ky7Tl09u6ubqdegay1YXSf0va540Ri9/8o
         n8cCjV6lmf3uavcuvy6fpA8AYzoUeb07AdvVYcASUlJhONTK3hSXcsNCFvugPfrbnQDl
         E58g==
X-Gm-Message-State: ACrzQf1ugMtx0rPsiUwcJju6s64aDS1qDqRDBja2Btd8lc29RBWRB7c4
        I58W1hAvT1s1mVDUAKuE4Cg=
X-Google-Smtp-Source: AMsMyM4nMdw9qFudS0MppwKqqPi9ceglgVyAgRyXA2zxjW0S8nVIvq/jDJPeHBSWYaGDV6Ycc0GpIg==
X-Received: by 2002:a05:6402:2550:b0:462:38d7:a6e1 with SMTP id l16-20020a056402255000b0046238d7a6e1mr26463164edb.337.1667412499831;
        Wed, 02 Nov 2022 11:08:19 -0700 (PDT)
Received: from kista.localdomain (82-149-19-102.dynamic.telemach.net. [82.149.19.102])
        by smtp.gmail.com with ESMTPSA id gy8-20020a170906f24800b007317f017e64sm5677460ejb.134.2022.11.02.11.08.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 11:08:19 -0700 (PDT)
From:   Jernej Skrabec <jernej.skrabec@gmail.com>
To:     mripard@kernel.org, paul.kocialkowski@bootlin.com
Cc:     mchehab@kernel.org, gregkh@linuxfoundation.org, wens@csie.org,
        samuel@sholland.org, hverkuil-cisco@xs4all.nl,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH v2 02/11] media: cedrus: Add format reset helpers
Date:   Wed,  2 Nov 2022 19:08:01 +0100
Message-Id: <20221102180810.267252-3-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221102180810.267252-1-jernej.skrabec@gmail.com>
References: <20221102180810.267252-1-jernej.skrabec@gmail.com>
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

