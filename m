Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAF6C604F21
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 19:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230395AbiJSRqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 13:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231397AbiJSRqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 13:46:02 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 791BF1BBECF;
        Wed, 19 Oct 2022 10:45:59 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id q19so26368873edd.10;
        Wed, 19 Oct 2022 10:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZYFckWwX9uTEigsRmSE8M+w2FU9LcSUPeNXHRx9aVqY=;
        b=FRSQXJ2BQOtMb5aSzMw31RLJqB1kdyiJ2FvPYpQ4RpU6MfaRJEplG2JkNKxInXU2w0
         y9GML01FZxWhLNXu10zW1YJZ4x7l5wcGWEIb+GrZ0yNop5k4Sxk0WklHRTMhFP2eR0VD
         ZPqDSKdEc3pCHlBpGpDuWaKQlC7j5cMJi/m4E0i1oCX1tPwjAJMBYLvkz6aaWh5fd52+
         D9MZSgl3tQvYL+RPFzA2EtbuSpXEmgOT8IcTpS2FMiyGzURAdK7gLTMlbeB2mr2Kx+tX
         lxwUvWXfsBplme9oCJukwySDiNRfEtugnwJ/cAFGmXj1Kdvo9Bx2Lf5IrUHECk0Y8Ma6
         X6cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZYFckWwX9uTEigsRmSE8M+w2FU9LcSUPeNXHRx9aVqY=;
        b=pOx34jliWCzIuDsx023M5ZxEc7JUbqK4ZNdii5MZQjAmMmdPVPvAzWGag8/MLIEYJ8
         r26oJ0aJhfOoJ6/pp4GE6imdnKPckzGN1DmZFyrWkTMDyaSjX5XH38wWww3aqKQXPRHf
         H8uvJs0g8H0LLWAc4nI/Yw9ETFKgnVzRn8+EUGA1q4u4bzwBlubE9LzHs/lqyTZbrFx6
         KYn2fueYDX3NZLqOBUGJboZOzDcYJDa8IJpZFtM5Uv9NRNVS+rg43Sd8puogjPbJ0K17
         2d4q96RNY0Tb/d26v1nrmcIeshUoBnTK9DF+G7wrho8DoHX3F8Ap4Vjxast3xBTrf4LB
         lw7g==
X-Gm-Message-State: ACrzQf3tchWILOKGOdcJlmkce9NRMhhyJrgoixDDQHD8vO0y4swKmrDe
        R4dH8pCzj6lmFkVUZzhsDRE=
X-Google-Smtp-Source: AMsMyM5Ty5xHTPGhC2T9qTK5EqK4582xj+OeMFekmQLzYQCqgZXR+jVo3JQMs8Ff0+3PnznlTMhxEA==
X-Received: by 2002:a05:6402:3887:b0:458:289e:c9cc with SMTP id fd7-20020a056402388700b00458289ec9ccmr8583598edb.101.1666201557860;
        Wed, 19 Oct 2022 10:45:57 -0700 (PDT)
Received: from kista.localdomain (82-149-19-102.dynamic.telemach.net. [82.149.19.102])
        by smtp.gmail.com with ESMTPSA id qn24-20020a170907211800b0073c10031dc9sm9218382ejb.80.2022.10.19.10.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 10:45:57 -0700 (PDT)
From:   Jernej Skrabec <jernej.skrabec@gmail.com>
To:     mripard@kernel.org, paul.kocialkowski@bootlin.com
Cc:     mchehab@kernel.org, gregkh@linuxfoundation.org, wens@csie.org,
        samuel@sholland.org, hverkuil-cisco@xs4all.nl,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH 2/2] media: cedrus: h264: Optimize mv col buffer allocation
Date:   Wed, 19 Oct 2022 19:45:51 +0200
Message-Id: <20221019174551.2695149-3-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221019174551.2695149-1-jernej.skrabec@gmail.com>
References: <20221019174551.2695149-1-jernej.skrabec@gmail.com>
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

Currently allocation for mv col buffer pool is very wasteful. It
allocates memory for worst case which is a lot more than it's needed for
typical use. Fix that by replacing pool with individual allocations when
such buffer is really needed. At that time all needed information for
determining optimal mv col buffer size is also known.

Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/staging/media/sunxi/cedrus/cedrus.h   |   7 +-
 .../staging/media/sunxi/cedrus/cedrus_h264.c  | 118 +++++++++---------
 2 files changed, 61 insertions(+), 64 deletions(-)

diff --git a/drivers/staging/media/sunxi/cedrus/cedrus.h b/drivers/staging/media/sunxi/cedrus/cedrus.h
index cb99610f3e12..9cffaf228422 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus.h
+++ b/drivers/staging/media/sunxi/cedrus/cedrus.h
@@ -108,6 +108,9 @@ struct cedrus_buffer {
 		struct {
 			unsigned int			position;
 			enum cedrus_h264_pic_type	pic_type;
+			void				*mv_col_buf;
+			dma_addr_t			mv_col_buf_dma;
+			ssize_t				mv_col_buf_size;
 		} h264;
 		struct {
 			void		*mv_col_buf;
@@ -130,10 +133,6 @@ struct cedrus_ctx {
 
 	union {
 		struct {
-			void		*mv_col_buf;
-			dma_addr_t	mv_col_buf_dma;
-			ssize_t		mv_col_buf_field_size;
-			ssize_t		mv_col_buf_size;
 			void		*pic_info_buf;
 			dma_addr_t	pic_info_buf_dma;
 			ssize_t		pic_info_buf_size;
diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_h264.c b/drivers/staging/media/sunxi/cedrus/cedrus_h264.c
index a8b236cd3800..c92dec21c1ac 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus_h264.c
+++ b/drivers/staging/media/sunxi/cedrus/cedrus_h264.c
@@ -54,17 +54,13 @@ static void cedrus_h264_write_sram(struct cedrus_dev *dev,
 		cedrus_write(dev, VE_AVC_SRAM_PORT_DATA, *buffer++);
 }
 
-static dma_addr_t cedrus_h264_mv_col_buf_addr(struct cedrus_ctx *ctx,
-					      unsigned int position,
+static dma_addr_t cedrus_h264_mv_col_buf_addr(struct cedrus_buffer *buf,
 					      unsigned int field)
 {
-	dma_addr_t addr = ctx->codec.h264.mv_col_buf_dma;
-
-	/* Adjust for the position */
-	addr += position * ctx->codec.h264.mv_col_buf_field_size * 2;
+	dma_addr_t addr = buf->codec.h264.mv_col_buf_dma;
 
 	/* Adjust for the field */
-	addr += field * ctx->codec.h264.mv_col_buf_field_size;
+	addr += field * buf->codec.h264.mv_col_buf_size / 2;
 
 	return addr;
 }
@@ -76,7 +72,6 @@ static void cedrus_fill_ref_pic(struct cedrus_ctx *ctx,
 				struct cedrus_h264_sram_ref_pic *pic)
 {
 	struct vb2_buffer *vbuf = &buf->m2m_buf.vb.vb2_buf;
-	unsigned int position = buf->codec.h264.position;
 
 	pic->top_field_order_cnt = cpu_to_le32(top_field_order_cnt);
 	pic->bottom_field_order_cnt = cpu_to_le32(bottom_field_order_cnt);
@@ -84,14 +79,12 @@ static void cedrus_fill_ref_pic(struct cedrus_ctx *ctx,
 
 	pic->luma_ptr = cpu_to_le32(cedrus_buf_addr(vbuf, &ctx->dst_fmt, 0));
 	pic->chroma_ptr = cpu_to_le32(cedrus_buf_addr(vbuf, &ctx->dst_fmt, 1));
-	pic->mv_col_top_ptr =
-		cpu_to_le32(cedrus_h264_mv_col_buf_addr(ctx, position, 0));
-	pic->mv_col_bot_ptr =
-		cpu_to_le32(cedrus_h264_mv_col_buf_addr(ctx, position, 1));
+	pic->mv_col_top_ptr = cpu_to_le32(cedrus_h264_mv_col_buf_addr(buf, 0));
+	pic->mv_col_bot_ptr = cpu_to_le32(cedrus_h264_mv_col_buf_addr(buf, 1));
 }
 
-static void cedrus_write_frame_list(struct cedrus_ctx *ctx,
-				    struct cedrus_run *run)
+static int cedrus_write_frame_list(struct cedrus_ctx *ctx,
+				   struct cedrus_run *run)
 {
 	struct cedrus_h264_sram_ref_pic pic_list[CEDRUS_H264_FRAME_NUM];
 	const struct v4l2_ctrl_h264_decode_params *decode = run->h264.decode_params;
@@ -146,6 +139,31 @@ static void cedrus_write_frame_list(struct cedrus_ctx *ctx,
 	output_buf = vb2_to_cedrus_buffer(&run->dst->vb2_buf);
 	output_buf->codec.h264.position = position;
 
+	if (!output_buf->codec.h264.mv_col_buf_size) {
+		const struct v4l2_ctrl_h264_sps *sps = run->h264.sps;
+		unsigned int field_size;
+
+		field_size = DIV_ROUND_UP(ctx->src_fmt.width, 16) *
+			DIV_ROUND_UP(ctx->src_fmt.height, 16) * 16;
+		if (!(sps->flags & V4L2_H264_SPS_FLAG_DIRECT_8X8_INFERENCE))
+			field_size = field_size * 2;
+		if (!(sps->flags & V4L2_H264_SPS_FLAG_FRAME_MBS_ONLY))
+			field_size = field_size * 2;
+
+		output_buf->codec.h264.mv_col_buf_size = field_size * 2;
+		/* Buffer is never accessed by CPU, so we can skip kernel mapping. */
+		output_buf->codec.h264.mv_col_buf =
+			dma_alloc_attrs(dev->dev,
+					output_buf->codec.h264.mv_col_buf_size,
+					&output_buf->codec.h264.mv_col_buf_dma,
+					GFP_KERNEL, DMA_ATTR_NO_KERNEL_MAPPING);
+
+		if (!output_buf->codec.h264.mv_col_buf) {
+			output_buf->codec.h264.mv_col_buf_size = 0;
+			return -ENOMEM;
+		}
+	}
+
 	if (decode->flags & V4L2_H264_DECODE_PARAM_FLAG_FIELD_PIC)
 		output_buf->codec.h264.pic_type = CEDRUS_H264_PIC_TYPE_FIELD;
 	else if (sps->flags & V4L2_H264_SPS_FLAG_MB_ADAPTIVE_FRAME_FIELD)
@@ -162,6 +180,8 @@ static void cedrus_write_frame_list(struct cedrus_ctx *ctx,
 			       pic_list, sizeof(pic_list));
 
 	cedrus_write(dev, VE_H264_OUTPUT_FRAME_IDX, position);
+
+	return 0;
 }
 
 #define CEDRUS_MAX_REF_IDX	32
@@ -496,6 +516,7 @@ static void cedrus_h264_irq_disable(struct cedrus_ctx *ctx)
 static int cedrus_h264_setup(struct cedrus_ctx *ctx, struct cedrus_run *run)
 {
 	struct cedrus_dev *dev = ctx->dev;
+	int ret;
 
 	cedrus_engine_enable(ctx, CEDRUS_CODEC_H264);
 
@@ -506,7 +527,9 @@ static int cedrus_h264_setup(struct cedrus_ctx *ctx, struct cedrus_run *run)
 		     ctx->codec.h264.neighbor_info_buf_dma);
 
 	cedrus_write_scaling_lists(ctx, run);
-	cedrus_write_frame_list(ctx, run);
+	ret = cedrus_write_frame_list(ctx, run);
+	if (ret)
+		return ret;
 
 	cedrus_set_params(ctx, run);
 
@@ -517,8 +540,6 @@ static int cedrus_h264_start(struct cedrus_ctx *ctx)
 {
 	struct cedrus_dev *dev = ctx->dev;
 	unsigned int pic_info_size;
-	unsigned int field_size;
-	unsigned int mv_col_size;
 	int ret;
 
 	/*
@@ -566,38 +587,6 @@ static int cedrus_h264_start(struct cedrus_ctx *ctx)
 		goto err_pic_buf;
 	}
 
-	field_size = DIV_ROUND_UP(ctx->src_fmt.width, 16) *
-		DIV_ROUND_UP(ctx->src_fmt.height, 16) * 16;
-
-	/*
-	 * FIXME: This is actually conditional to
-	 * V4L2_H264_SPS_FLAG_DIRECT_8X8_INFERENCE not being set, we
-	 * might have to rework this if memory efficiency ever is
-	 * something we need to work on.
-	 */
-	field_size = field_size * 2;
-
-	/*
-	 * FIXME: This is actually conditional to
-	 * V4L2_H264_SPS_FLAG_FRAME_MBS_ONLY not being set, we might
-	 * have to rework this if memory efficiency ever is something
-	 * we need to work on.
-	 */
-	field_size = field_size * 2;
-	ctx->codec.h264.mv_col_buf_field_size = field_size;
-
-	mv_col_size = field_size * 2 * CEDRUS_H264_FRAME_NUM;
-	ctx->codec.h264.mv_col_buf_size = mv_col_size;
-	ctx->codec.h264.mv_col_buf =
-		dma_alloc_attrs(dev->dev,
-				ctx->codec.h264.mv_col_buf_size,
-				&ctx->codec.h264.mv_col_buf_dma,
-				GFP_KERNEL, DMA_ATTR_NO_KERNEL_MAPPING);
-	if (!ctx->codec.h264.mv_col_buf) {
-		ret = -ENOMEM;
-		goto err_neighbor_buf;
-	}
-
 	if (ctx->src_fmt.width > 2048) {
 		/*
 		 * Formulas for deblock and intra prediction buffer sizes
@@ -613,7 +602,7 @@ static int cedrus_h264_start(struct cedrus_ctx *ctx)
 					GFP_KERNEL, DMA_ATTR_NO_KERNEL_MAPPING);
 		if (!ctx->codec.h264.deblk_buf) {
 			ret = -ENOMEM;
-			goto err_mv_col_buf;
+			goto err_neighbor_buf;
 		}
 
 		/*
@@ -641,12 +630,6 @@ static int cedrus_h264_start(struct cedrus_ctx *ctx)
 		       ctx->codec.h264.deblk_buf_dma,
 		       DMA_ATTR_NO_KERNEL_MAPPING);
 
-err_mv_col_buf:
-	dma_free_attrs(dev->dev, ctx->codec.h264.mv_col_buf_size,
-		       ctx->codec.h264.mv_col_buf,
-		       ctx->codec.h264.mv_col_buf_dma,
-		       DMA_ATTR_NO_KERNEL_MAPPING);
-
 err_neighbor_buf:
 	dma_free_attrs(dev->dev, CEDRUS_NEIGHBOR_INFO_BUF_SIZE,
 		       ctx->codec.h264.neighbor_info_buf,
@@ -664,11 +647,26 @@ static int cedrus_h264_start(struct cedrus_ctx *ctx)
 static void cedrus_h264_stop(struct cedrus_ctx *ctx)
 {
 	struct cedrus_dev *dev = ctx->dev;
+	struct cedrus_buffer *buf;
+	struct vb2_queue *vq;
+	unsigned int i;
+
+	vq = v4l2_m2m_get_vq(ctx->fh.m2m_ctx, V4L2_BUF_TYPE_VIDEO_CAPTURE);
+
+	for (i = 0; i < vq->num_buffers; i++) {
+		buf = vb2_to_cedrus_buffer(vb2_get_buffer(vq, i));
+
+		if (buf->codec.h264.mv_col_buf_size > 0) {
+			dma_free_attrs(dev->dev,
+				       buf->codec.h264.mv_col_buf_size,
+				       buf->codec.h264.mv_col_buf,
+				       buf->codec.h264.mv_col_buf_dma,
+				       DMA_ATTR_NO_KERNEL_MAPPING);
+
+			buf->codec.h264.mv_col_buf_size = 0;
+		}
+	}
 
-	dma_free_attrs(dev->dev, ctx->codec.h264.mv_col_buf_size,
-		       ctx->codec.h264.mv_col_buf,
-		       ctx->codec.h264.mv_col_buf_dma,
-		       DMA_ATTR_NO_KERNEL_MAPPING);
 	dma_free_attrs(dev->dev, CEDRUS_NEIGHBOR_INFO_BUF_SIZE,
 		       ctx->codec.h264.neighbor_info_buf,
 		       ctx->codec.h264.neighbor_info_buf_dma,
-- 
2.38.0

