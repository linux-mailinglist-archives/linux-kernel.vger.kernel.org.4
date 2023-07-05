Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADA827483EA
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 14:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232076AbjGEMLT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 08:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231147AbjGEMLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 08:11:08 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAD8F1705;
        Wed,  5 Jul 2023 05:11:06 -0700 (PDT)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:cbfb:e358:222c:d8c1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 4EDCA6606FBA;
        Wed,  5 Jul 2023 13:11:05 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1688559065;
        bh=/7DVclLTrBQzDYE1VjnNUTPJoyWcBdPfrc2tItSEaPs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mn3LpKZYxlKyQBB3N2c5v26i0eEPM8P1D7FJnhnJbntqqmR/Hk/huWldbG7ZXL9A2
         4Ovj40KnPUtrfjFxdd0sgXM9YPobNljguC0fM4a4gWw1LdLcIBKeerQxNqEMk+4+vS
         O6oXa9FVUzUYCXAYz+izaDPZQ1MYhvIA2h8jbxvHUdGFUIRH/sNUAQ5J741lYd35UQ
         Oj7d2QHBNDe0ksuLoCyh6+GfjqQRHVfC+VNfWQvZ2eU6wieeENk/2Yi2Kn7pqOX5oY
         cj0tWk+vd2Vs03Lj2dAVO6SxvcccYlCnrdL4WBnxwXcL+1r7LpbJrzyjRcwFgAphBC
         lbY+JjSfZlcgQ==
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
To:     mchehab@kernel.org, tfiga@chromium.org, m.szyprowski@samsung.com,
        ming.qian@nxp.com, ezequiel@vanguardiasur.com.ar,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        hverkuil-cisco@xs4all.nl, nicolas.dufresne@collabora.com
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        kernel@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH v4 04/10] media: verisilicon: Refactor postprocessor to store more buffers
Date:   Wed,  5 Jul 2023 14:10:50 +0200
Message-Id: <20230705121056.37017-5-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230705121056.37017-1-benjamin.gaignard@collabora.com>
References: <20230705121056.37017-1-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since vb2 queue can store than VB2_MAX_FRAME buffers postprocessor
buffer storage must be capable to store more buffers too.
Change static dec_q array to allocated array to be capable to store
up to queue 'max_allowed_buffers'.
Keep allocating queue 'num_buffers' at queue setup time but also allows
to allocate postprocessors buffers on the fly.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
 drivers/media/platform/verisilicon/hantro.h   |   7 +-
 .../media/platform/verisilicon/hantro_drv.c   |   4 +-
 .../media/platform/verisilicon/hantro_hw.h    |   2 +-
 .../platform/verisilicon/hantro_postproc.c    | 103 ++++++++++++++----
 .../media/platform/verisilicon/hantro_v4l2.c  |   2 +-
 5 files changed, 93 insertions(+), 25 deletions(-)

diff --git a/drivers/media/platform/verisilicon/hantro.h b/drivers/media/platform/verisilicon/hantro.h
index 2989ebc631cc..c8a3cf10cc64 100644
--- a/drivers/media/platform/verisilicon/hantro.h
+++ b/drivers/media/platform/verisilicon/hantro.h
@@ -461,11 +461,14 @@ hantro_get_dst_buf(struct hantro_ctx *ctx)
 bool hantro_needs_postproc(const struct hantro_ctx *ctx,
 			   const struct hantro_fmt *fmt);
 
+dma_addr_t
+hantro_postproc_get_dec_buf_addr(struct hantro_ctx *ctx, int index);
+
 static inline dma_addr_t
 hantro_get_dec_buf_addr(struct hantro_ctx *ctx, struct vb2_buffer *vb)
 {
 	if (hantro_needs_postproc(ctx, ctx->vpu_dst_fmt))
-		return ctx->postproc.dec_q[vb->index].dma;
+		return hantro_postproc_get_dec_buf_addr(ctx, vb->index);
 	return vb2_dma_contig_plane_dma_addr(vb, 0);
 }
 
@@ -477,8 +480,8 @@ vb2_to_hantro_decoded_buf(struct vb2_buffer *buf)
 
 void hantro_postproc_disable(struct hantro_ctx *ctx);
 void hantro_postproc_enable(struct hantro_ctx *ctx);
+int hantro_postproc_init(struct hantro_ctx *ctx);
 void hantro_postproc_free(struct hantro_ctx *ctx);
-int hantro_postproc_alloc(struct hantro_ctx *ctx);
 int hanto_postproc_enum_framesizes(struct hantro_ctx *ctx,
 				   struct v4l2_frmsizeenum *fsize);
 
diff --git a/drivers/media/platform/verisilicon/hantro_drv.c b/drivers/media/platform/verisilicon/hantro_drv.c
index 09c74a573ddb..d908559817ce 100644
--- a/drivers/media/platform/verisilicon/hantro_drv.c
+++ b/drivers/media/platform/verisilicon/hantro_drv.c
@@ -234,8 +234,10 @@ queue_init(void *priv, struct vb2_queue *src_vq, struct vb2_queue *dst_vq)
 	 * The Kernel needs access to the JPEG destination buffer for the
 	 * JPEG encoder to fill in the JPEG headers.
 	 */
-	if (!ctx->is_encoder)
+	if (!ctx->is_encoder) {
 		dst_vq->dma_attrs |= DMA_ATTR_NO_KERNEL_MAPPING;
+		dst_vq->max_allowed_buffers = 64;
+	}
 
 	dst_vq->type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE;
 	dst_vq->io_modes = VB2_MMAP | VB2_DMABUF;
diff --git a/drivers/media/platform/verisilicon/hantro_hw.h b/drivers/media/platform/verisilicon/hantro_hw.h
index e83f0c523a30..6fd6c9d53cec 100644
--- a/drivers/media/platform/verisilicon/hantro_hw.h
+++ b/drivers/media/platform/verisilicon/hantro_hw.h
@@ -253,7 +253,7 @@ struct hantro_vp9_dec_hw_ctx {
  * @dec_q:		References buffers, in decoder format.
  */
 struct hantro_postproc_ctx {
-	struct hantro_aux_buf dec_q[VB2_MAX_FRAME];
+	struct hantro_aux_buf *dec_q;
 };
 
 /**
diff --git a/drivers/media/platform/verisilicon/hantro_postproc.c b/drivers/media/platform/verisilicon/hantro_postproc.c
index 6437423ccf3a..9dfe3141a398 100644
--- a/drivers/media/platform/verisilicon/hantro_postproc.c
+++ b/drivers/media/platform/verisilicon/hantro_postproc.c
@@ -173,9 +173,11 @@ static int hantro_postproc_g2_enum_framesizes(struct hantro_ctx *ctx,
 void hantro_postproc_free(struct hantro_ctx *ctx)
 {
 	struct hantro_dev *vpu = ctx->dev;
+	struct v4l2_m2m_ctx *m2m_ctx = ctx->fh.m2m_ctx;
+	struct vb2_queue *queue = &m2m_ctx->cap_q_ctx.q;
 	unsigned int i;
 
-	for (i = 0; i < VB2_MAX_FRAME; ++i) {
+	for (i = 0; i < queue->max_allowed_buffers; ++i) {
 		struct hantro_aux_buf *priv = &ctx->postproc.dec_q[i];
 
 		if (priv->cpu) {
@@ -184,22 +186,21 @@ void hantro_postproc_free(struct hantro_ctx *ctx)
 			priv->cpu = NULL;
 		}
 	}
+	kfree(ctx->postproc.dec_q);
+	ctx->postproc.dec_q = NULL;
 }
 
-int hantro_postproc_alloc(struct hantro_ctx *ctx)
+static unsigned int hantro_postproc_buffer_size(struct hantro_ctx *ctx)
 {
-	struct hantro_dev *vpu = ctx->dev;
-	struct v4l2_m2m_ctx *m2m_ctx = ctx->fh.m2m_ctx;
-	struct vb2_queue *cap_queue = &m2m_ctx->cap_q_ctx.q;
-	unsigned int num_buffers = cap_queue->num_buffers;
 	struct v4l2_pix_format_mplane pix_mp;
 	const struct hantro_fmt *fmt;
-	unsigned int i, buf_size;
+	unsigned int buf_size;
 
 	/* this should always pick native format */
 	fmt = hantro_get_default_fmt(ctx, false, ctx->bit_depth);
 	if (!fmt)
-		return -EINVAL;
+		return 0;
+
 	v4l2_fill_pixfmt_mp(&pix_mp, fmt->fourcc, ctx->src_fmt.width,
 			    ctx->src_fmt.height);
 
@@ -214,23 +215,85 @@ int hantro_postproc_alloc(struct hantro_ctx *ctx)
 		buf_size += hantro_hevc_mv_size(pix_mp.width,
 						pix_mp.height);
 
-	for (i = 0; i < num_buffers; ++i) {
-		struct hantro_aux_buf *priv = &ctx->postproc.dec_q[i];
+	return buf_size;
+}
+
+static int hantro_postproc_alloc(struct hantro_ctx *ctx, int index)
+{
+	struct hantro_dev *vpu = ctx->dev;
+	struct hantro_aux_buf *priv = &ctx->postproc.dec_q[index];
+	unsigned int buf_size = hantro_postproc_buffer_size(ctx);
+
+	if (!buf_size)
+		return -EINVAL;
+
+	/*
+	 * The buffers on this queue are meant as intermediate
+	 * buffers for the decoder, so no mapping is needed.
+	 */
+	priv->attrs = DMA_ATTR_NO_KERNEL_MAPPING;
+	priv->cpu = dma_alloc_attrs(vpu->dev, buf_size, &priv->dma,
+				    GFP_KERNEL, priv->attrs);
+	if (!priv->cpu)
+		return -ENOMEM;
+	priv->size = buf_size;
+
+	return 0;
+}
+
+int hantro_postproc_init(struct hantro_ctx *ctx)
+{
+	struct v4l2_m2m_ctx *m2m_ctx = ctx->fh.m2m_ctx;
+	struct vb2_queue *cap_queue = &m2m_ctx->cap_q_ctx.q;
+	unsigned int num_buffers = cap_queue->num_buffers;
+	unsigned int i;
+	int ret;
 
-		/*
-		 * The buffers on this queue are meant as intermediate
-		 * buffers for the decoder, so no mapping is needed.
-		 */
-		priv->attrs = DMA_ATTR_NO_KERNEL_MAPPING;
-		priv->cpu = dma_alloc_attrs(vpu->dev, buf_size, &priv->dma,
-					    GFP_KERNEL, priv->attrs);
-		if (!priv->cpu)
-			return -ENOMEM;
-		priv->size = buf_size;
+	if (!ctx->postproc.dec_q)
+		ctx->postproc.dec_q = kcalloc(cap_queue->max_allowed_buffers,
+					      sizeof(*ctx->postproc.dec_q),
+					      GFP_KERNEL);
+
+	if (!ctx->postproc.dec_q)
+		return -EINVAL;
+
+	for (i = 0; i < num_buffers; i++) {
+		ret = hantro_postproc_alloc(ctx, i);
+		if (ret)
+			return ret;
 	}
+
 	return 0;
 }
 
+dma_addr_t
+hantro_postproc_get_dec_buf_addr(struct hantro_ctx *ctx, int index)
+{
+	struct hantro_aux_buf *priv = &ctx->postproc.dec_q[index];
+	unsigned int buf_size = hantro_postproc_buffer_size(ctx);
+	struct hantro_dev *vpu = ctx->dev;
+	int ret;
+
+	if (priv->size < buf_size && priv->cpu) {
+		/* buffer is too small, release it */
+		dma_free_attrs(vpu->dev, priv->size, priv->cpu,
+			       priv->dma, priv->attrs);
+		priv->cpu = NULL;
+	}
+
+	if (!priv->cpu) {
+		/* buffer not already allocated, try getting a new one */
+		ret = hantro_postproc_alloc(ctx, index);
+		if (ret)
+			return 0;
+	}
+
+	if (!priv->cpu)
+		return 0;
+
+	return priv->dma;
+}
+
 static void hantro_postproc_g1_disable(struct hantro_ctx *ctx)
 {
 	struct hantro_dev *vpu = ctx->dev;
diff --git a/drivers/media/platform/verisilicon/hantro_v4l2.c b/drivers/media/platform/verisilicon/hantro_v4l2.c
index 61cfaaf4e927..898e8763d63a 100644
--- a/drivers/media/platform/verisilicon/hantro_v4l2.c
+++ b/drivers/media/platform/verisilicon/hantro_v4l2.c
@@ -897,7 +897,7 @@ static int hantro_start_streaming(struct vb2_queue *q, unsigned int count)
 		}
 
 		if (hantro_needs_postproc(ctx, ctx->vpu_dst_fmt)) {
-			ret = hantro_postproc_alloc(ctx);
+			ret = hantro_postproc_init(ctx);
 			if (ret)
 				goto err_codec_exit;
 		}
-- 
2.39.2

