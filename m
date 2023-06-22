Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8B8373A1AD
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 15:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbjFVNON (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 09:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231607AbjFVNOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 09:14:03 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B778910F8;
        Thu, 22 Jun 2023 06:14:01 -0700 (PDT)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:7d72:676c:e745:a6ef])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C8242660712A;
        Thu, 22 Jun 2023 14:13:59 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1687439640;
        bh=rIFi9nI9oOmxH+BS4YnCMnkoeVakCslz/qMxBQ3B9rg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MOqdLbkq2AQHq8FAr2JuOBighmg47fId1/MSzd02Ldhp9KYzfGIUGxZBVyQS1F2Qj
         dRmSTQn7IKwwGoZnSIEEkb2B5qQg9dnuhxkRTmOVANLdaAV3AS2Wqqd8qDRs8e2vX5
         TAQqEGHzpdpQ8AayfY17P838vZVY6EoIq5SPkMxbQRCiWqChIAiuQipzSz5Re57gi2
         exfiDw8g3IVvMmiXQdyXw1ZhauNKw4qyX+HCW/njJf94u/Rm9mM+2i7ogpOlAMrxK9
         MYxhXqa+5/0qN8XH6WNz4Hd0ODEyvk77T8hEhWXpKJUbM1wLFJ+/1je4anpMtkZpbs
         QPJti33S5Tycw==
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
Subject: [PATCH v3 05/11] media: verisilicon: Refactor postprocessor to store more buffers
Date:   Thu, 22 Jun 2023 15:13:43 +0200
Message-Id: <20230622131349.144160-6-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230622131349.144160-1-benjamin.gaignard@collabora.com>
References: <20230622131349.144160-1-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Like for vb queues remove VB2_MAX_FRAME upper limit on postprocessor
buffers storage capacity.
If a buffer hasn't been allocated when setting up the queue make
possible to alloc it on the fly while streaming. This happens
when resolution change between keyframes.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
 drivers/media/platform/verisilicon/hantro.h   |   6 +-
 .../media/platform/verisilicon/hantro_hw.h    |   6 +-
 .../platform/verisilicon/hantro_postproc.c    | 109 ++++++++++++------
 .../media/platform/verisilicon/hantro_v4l2.c  |  12 +-
 4 files changed, 82 insertions(+), 51 deletions(-)

diff --git a/drivers/media/platform/verisilicon/hantro.h b/drivers/media/platform/verisilicon/hantro.h
index 2989ebc631cc..bd0dca11b90a 100644
--- a/drivers/media/platform/verisilicon/hantro.h
+++ b/drivers/media/platform/verisilicon/hantro.h
@@ -460,12 +460,14 @@ hantro_get_dst_buf(struct hantro_ctx *ctx)
 
 bool hantro_needs_postproc(const struct hantro_ctx *ctx,
 			   const struct hantro_fmt *fmt);
+dma_addr_t
+hantro_postproc_get_dec_buf_addr(struct hantro_ctx *ctx, int index);
 
 static inline dma_addr_t
 hantro_get_dec_buf_addr(struct hantro_ctx *ctx, struct vb2_buffer *vb)
 {
 	if (hantro_needs_postproc(ctx, ctx->vpu_dst_fmt))
-		return ctx->postproc.dec_q[vb->index].dma;
+		return hantro_postproc_get_dec_buf_addr(ctx, vb->index);
 	return vb2_dma_contig_plane_dma_addr(vb, 0);
 }
 
@@ -477,8 +479,8 @@ vb2_to_hantro_decoded_buf(struct vb2_buffer *buf)
 
 void hantro_postproc_disable(struct hantro_ctx *ctx);
 void hantro_postproc_enable(struct hantro_ctx *ctx);
+int hantro_postproc_init(struct hantro_ctx *ctx);
 void hantro_postproc_free(struct hantro_ctx *ctx);
-int hantro_postproc_alloc(struct hantro_ctx *ctx);
 int hanto_postproc_enum_framesizes(struct hantro_ctx *ctx,
 				   struct v4l2_frmsizeenum *fsize);
 
diff --git a/drivers/media/platform/verisilicon/hantro_hw.h b/drivers/media/platform/verisilicon/hantro_hw.h
index 9e8faf7ba6fb..5c7b6e04aded 100644
--- a/drivers/media/platform/verisilicon/hantro_hw.h
+++ b/drivers/media/platform/verisilicon/hantro_hw.h
@@ -15,8 +15,6 @@
 #include <media/v4l2-vp9.h>
 #include <media/videobuf2-core.h>
 
-#define VB2_MAX_FRAME	32
-
 #define DEC_8190_ALIGN_MASK	0x07U
 
 #define MB_DIM			16
@@ -252,10 +250,10 @@ struct hantro_vp9_dec_hw_ctx {
 /**
  * struct hantro_postproc_ctx
  *
- * @dec_q:		References buffers, in decoder format.
+ * @dec_refs_xa:	References buffers, in decoder format.
  */
 struct hantro_postproc_ctx {
-	struct hantro_aux_buf dec_q[VB2_MAX_FRAME];
+	struct xarray dec_refs_xa;
 };
 
 /**
diff --git a/drivers/media/platform/verisilicon/hantro_postproc.c b/drivers/media/platform/verisilicon/hantro_postproc.c
index 6437423ccf3a..a6b67d0cc66c 100644
--- a/drivers/media/platform/verisilicon/hantro_postproc.c
+++ b/drivers/media/platform/verisilicon/hantro_postproc.c
@@ -170,36 +170,23 @@ static int hantro_postproc_g2_enum_framesizes(struct hantro_ctx *ctx,
 	return 0;
 }
 
-void hantro_postproc_free(struct hantro_ctx *ctx)
+static int hantro_postproc_alloc(struct hantro_ctx *ctx, int index)
 {
 	struct hantro_dev *vpu = ctx->dev;
-	unsigned int i;
-
-	for (i = 0; i < VB2_MAX_FRAME; ++i) {
-		struct hantro_aux_buf *priv = &ctx->postproc.dec_q[i];
-
-		if (priv->cpu) {
-			dma_free_attrs(vpu->dev, priv->size, priv->cpu,
-				       priv->dma, priv->attrs);
-			priv->cpu = NULL;
-		}
-	}
-}
-
-int hantro_postproc_alloc(struct hantro_ctx *ctx)
-{
-	struct hantro_dev *vpu = ctx->dev;
-	struct v4l2_m2m_ctx *m2m_ctx = ctx->fh.m2m_ctx;
-	struct vb2_queue *cap_queue = &m2m_ctx->cap_q_ctx.q;
-	unsigned int num_buffers = cap_queue->num_buffers;
 	struct v4l2_pix_format_mplane pix_mp;
 	const struct hantro_fmt *fmt;
-	unsigned int i, buf_size;
+	struct hantro_aux_buf *priv;
+	unsigned int buf_size;
+
+	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
 
 	/* this should always pick native format */
 	fmt = hantro_get_default_fmt(ctx, false, ctx->bit_depth);
 	if (!fmt)
 		return -EINVAL;
+
 	v4l2_fill_pixfmt_mp(&pix_mp, fmt->fourcc, ctx->src_fmt.width,
 			    ctx->src_fmt.height);
 
@@ -214,20 +201,74 @@ int hantro_postproc_alloc(struct hantro_ctx *ctx)
 		buf_size += hantro_hevc_mv_size(pix_mp.width,
 						pix_mp.height);
 
-	for (i = 0; i < num_buffers; ++i) {
-		struct hantro_aux_buf *priv = &ctx->postproc.dec_q[i];
-
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
+	/*
+	 * The buffers on this queue are meant as intermediate
+	 * buffers for the decoder, so no mapping is needed.
+	 */
+	priv->attrs = DMA_ATTR_NO_KERNEL_MAPPING;
+	priv->cpu = dma_alloc_attrs(vpu->dev, buf_size, &priv->dma, GFP_KERNEL, priv->attrs);
+	if (!priv->cpu)
+		return -ENOMEM;
+
+	priv->size = buf_size;
+
+	xa_store(&ctx->postproc.dec_refs_xa, index, priv, GFP_KERNEL);
+
+	return 0;
+}
+
+void hantro_postproc_free(struct hantro_ctx *ctx)
+{
+	struct hantro_dev *vpu = ctx->dev;
+	struct hantro_aux_buf *priv;
+	unsigned long i;
+
+	xa_for_each(&ctx->postproc.dec_refs_xa, i, priv) {
+		dma_free_attrs(vpu->dev, priv->size, priv->cpu, priv->dma, priv->attrs);
+		kfree(priv);
+	}
+
+	xa_destroy(&ctx->postproc.dec_refs_xa);
+}
+
+int hantro_postproc_init(struct hantro_ctx *ctx)
+{
+	struct v4l2_m2m_ctx *m2m_ctx = ctx->fh.m2m_ctx;
+	struct vb2_queue *cap_queue = &m2m_ctx->cap_q_ctx.q;
+	unsigned int num_buffers = cap_queue->num_buffers;
+	int i, ret = 0;
+
+	xa_init_flags(&ctx->postproc.dec_refs_xa, XA_FLAGS_ALLOC);
+
+	for (i = 0; i < num_buffers; i++) {
+		ret = hantro_postproc_alloc(ctx, i);
+		if (ret < 0) {
+			hantro_postproc_free(ctx);
+			return ret;
+		}
 	}
+
+	return ret;
+}
+
+dma_addr_t
+hantro_postproc_get_dec_buf_addr(struct hantro_ctx *ctx, int index)
+{
+	struct hantro_aux_buf *priv = xa_load(&ctx->postproc.dec_refs_xa, index);
+	int ret;
+
+	if (priv)
+		return priv->dma;
+
+	/* buffer not already allocated, try getting a new one */
+	ret = hantro_postproc_alloc(ctx, index);
+	if (ret < 0)
+		return 0;
+
+	priv = xa_load(&ctx->postproc.dec_refs_xa, index);
+	if (priv)
+		return priv->dma;
+
 	return 0;
 }
 
diff --git a/drivers/media/platform/verisilicon/hantro_v4l2.c b/drivers/media/platform/verisilicon/hantro_v4l2.c
index 61cfaaf4e927..0f615c1001c0 100644
--- a/drivers/media/platform/verisilicon/hantro_v4l2.c
+++ b/drivers/media/platform/verisilicon/hantro_v4l2.c
@@ -894,20 +894,10 @@ static int hantro_start_streaming(struct vb2_queue *q, unsigned int count)
 			ret = ctx->codec_ops->init(ctx);
 			if (ret)
 				return ret;
-		}
-
-		if (hantro_needs_postproc(ctx, ctx->vpu_dst_fmt)) {
-			ret = hantro_postproc_alloc(ctx);
-			if (ret)
-				goto err_codec_exit;
+			ret = hantro_postproc_init(ctx);
 		}
 	}
 	return ret;
-
-err_codec_exit:
-	if (ctx->codec_ops->exit)
-		ctx->codec_ops->exit(ctx);
-	return ret;
 }
 
 static void
-- 
2.39.2

