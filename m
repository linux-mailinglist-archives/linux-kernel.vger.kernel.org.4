Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBCCB604F20
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 19:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231421AbiJSRqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 13:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbiJSRqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 13:46:01 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75B521C25E5;
        Wed, 19 Oct 2022 10:45:58 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id u21so26364173edi.9;
        Wed, 19 Oct 2022 10:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BD+BD99SDsWzkwGKQmqOHhxdqKYLdMvG7sEt1/fqsiM=;
        b=eDDOn19Kg0zAZxp9nlKJ/wnWHqNuWGPZUA0iWrDCewlrj6dMNlaIi+tAtxl9lYpHOh
         ruAfX+/OUHB4CHVOXpIRcJiIlnYbyMmVn6Fcl3uPZ4JhOyOC8rQUN8SO4j0qSOGFXTQl
         1aA4qGe4AzhgnvVDHxdI5PUHD0I/BPUtrhu99TPO2Ryj5vXcCX/fWbdwhpzNjN9YPSl6
         GDb2c0ekOtFNbe9xKMBt3uPQrz8PR8wi6GhuvJD6GkhHg/Dk4PIPx4BgWYEAHTwC8EM5
         r3NSPOvC1OkO6G+rt5QkcoMxiS5Z2ERmw2eKUNYkgdC+ewrgZKXZT0blkDkG+EPztj43
         qugg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BD+BD99SDsWzkwGKQmqOHhxdqKYLdMvG7sEt1/fqsiM=;
        b=kii01n+rwqRfanuEThYabHvgsUCEkFMF5jifcCHJ6X/33551TIOijVgDY0/Hzxg3X8
         pvlPrLIzBc2WqqEC/QrViAQstR5sMfZ/g8tcGNhOUzlnwrpOO7/T2OE4l0tVm+T+K/Mw
         jYTFGOm+C9LI7AqDojlMkJ8cpJl+nn3IP/nLBwIaVDRRoCELVt3w4wK+lz0pRAW/7mb3
         jwFusvEsF88FY19Vhk1xo65riDZh6wskMNFQgLuW5d3+dQfXuHwAeeug6YDd86JF22ft
         0jR4O5pPlrGIXGeWphpbQvsU1i3jdcL3H61tUJmMgIFyp7Z6ZI5Za3LU4e+rQduqEz1v
         iYbQ==
X-Gm-Message-State: ACrzQf2MwORFsbEmEytrVmEsOqZsM3fdiMHGMkguFHZsKxlHi7l9O7Tl
        CX9N0bjNFHGsER0uQCWAOeY=
X-Google-Smtp-Source: AMsMyM7sHHIsz5oTd5NAVKIvTHI8Xt/BosycEjfYHmrm2XHwtQx6qglE8LIwNP1SN2XoD4td4Pu3MA==
X-Received: by 2002:a05:6402:440f:b0:45d:297b:c70a with SMTP id y15-20020a056402440f00b0045d297bc70amr8703436eda.187.1666201556684;
        Wed, 19 Oct 2022 10:45:56 -0700 (PDT)
Received: from kista.localdomain (82-149-19-102.dynamic.telemach.net. [82.149.19.102])
        by smtp.gmail.com with ESMTPSA id qn24-20020a170907211800b0073c10031dc9sm9218382ejb.80.2022.10.19.10.45.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 10:45:55 -0700 (PDT)
From:   Jernej Skrabec <jernej.skrabec@gmail.com>
To:     mripard@kernel.org, paul.kocialkowski@bootlin.com
Cc:     mchehab@kernel.org, gregkh@linuxfoundation.org, wens@csie.org,
        samuel@sholland.org, hverkuil-cisco@xs4all.nl,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH 1/2] media: cedrus: h265: Associate mv col buffers with buffer
Date:   Wed, 19 Oct 2022 19:45:50 +0200
Message-Id: <20221019174551.2695149-2-jernej.skrabec@gmail.com>
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

Currently mv col aux buffers are allocated as a pool. This is not
optimal because pool size equals number of buffers before stream is
started. Buffers can easily be allocated afterwards. In such cases,
invalid pointer is assigned to the decoding frame and Cedrus might
overwrite memory location which is allocated to different task.

Solve this issue with allocating mv col buffer once capture buffer is
actually used.

Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/staging/media/sunxi/cedrus/cedrus.h   |  9 +--
 .../staging/media/sunxi/cedrus/cedrus_h265.c  | 63 ++++++++++---------
 2 files changed, 38 insertions(+), 34 deletions(-)

diff --git a/drivers/staging/media/sunxi/cedrus/cedrus.h b/drivers/staging/media/sunxi/cedrus/cedrus.h
index 93a2196006f7..cb99610f3e12 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus.h
+++ b/drivers/staging/media/sunxi/cedrus/cedrus.h
@@ -109,6 +109,11 @@ struct cedrus_buffer {
 			unsigned int			position;
 			enum cedrus_h264_pic_type	pic_type;
 		} h264;
+		struct {
+			void		*mv_col_buf;
+			dma_addr_t	mv_col_buf_dma;
+			ssize_t		mv_col_buf_size;
+		} h265;
 	} codec;
 };
 
@@ -142,10 +147,6 @@ struct cedrus_ctx {
 			ssize_t		intra_pred_buf_size;
 		} h264;
 		struct {
-			void		*mv_col_buf;
-			dma_addr_t	mv_col_buf_addr;
-			ssize_t		mv_col_buf_size;
-			ssize_t		mv_col_buf_unit_size;
 			void		*neighbor_info_buf;
 			dma_addr_t	neighbor_info_buf_addr;
 			void		*entry_points_buf;
diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_h265.c b/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
index 625f77a8c5bd..7a438cd22c34 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
+++ b/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
@@ -90,12 +90,13 @@ static void cedrus_h265_sram_write_data(struct cedrus_dev *dev, void *data,
 }
 
 static inline dma_addr_t
-cedrus_h265_frame_info_mv_col_buf_addr(struct cedrus_ctx *ctx,
-				       unsigned int index, unsigned int field)
+cedrus_h265_frame_info_mv_col_buf_addr(struct vb2_buffer *buf,
+				       unsigned int field)
 {
-	return ctx->codec.h265.mv_col_buf_addr + index *
-	       ctx->codec.h265.mv_col_buf_unit_size +
-	       field * ctx->codec.h265.mv_col_buf_unit_size / 2;
+	struct cedrus_buffer *cedrus_buf = vb2_to_cedrus_buffer(buf);
+
+	return cedrus_buf->codec.h265.mv_col_buf_dma +
+	       field * cedrus_buf->codec.h265.mv_col_buf_size / 2;
 }
 
 static void cedrus_h265_frame_info_write_single(struct cedrus_ctx *ctx,
@@ -108,9 +109,8 @@ static void cedrus_h265_frame_info_write_single(struct cedrus_ctx *ctx,
 	dma_addr_t dst_luma_addr = cedrus_dst_buf_addr(ctx, buf, 0);
 	dma_addr_t dst_chroma_addr = cedrus_dst_buf_addr(ctx, buf, 1);
 	dma_addr_t mv_col_buf_addr[2] = {
-		cedrus_h265_frame_info_mv_col_buf_addr(ctx, buf->index, 0),
-		cedrus_h265_frame_info_mv_col_buf_addr(ctx, buf->index,
-						       field_pic ? 1 : 0)
+		cedrus_h265_frame_info_mv_col_buf_addr(buf, 0),
+		cedrus_h265_frame_info_mv_col_buf_addr(buf, field_pic ? 1 : 0)
 	};
 	u32 offset = VE_DEC_H265_SRAM_OFFSET_FRAME_INFO +
 		     VE_DEC_H265_SRAM_OFFSET_FRAME_INFO_UNIT * index;
@@ -412,6 +412,7 @@ static int cedrus_h265_setup(struct cedrus_ctx *ctx, struct cedrus_run *run)
 	unsigned int width_in_ctb_luma, ctb_size_luma;
 	unsigned int log2_max_luma_coding_block_size;
 	unsigned int ctb_addr_x, ctb_addr_y;
+	struct cedrus_buffer *cedrus_buf;
 	dma_addr_t src_buf_addr;
 	dma_addr_t src_buf_end_addr;
 	u32 chroma_log2_weight_denom;
@@ -428,6 +429,7 @@ static int cedrus_h265_setup(struct cedrus_ctx *ctx, struct cedrus_run *run)
 	decode_params = run->h265.decode_params;
 	pred_weight_table = &slice_params->pred_weight_table;
 	num_entry_point_offsets = slice_params->num_entry_point_offsets;
+	cedrus_buf = vb2_to_cedrus_buffer(&run->dst->vb2_buf);
 
 	/*
 	 * If entry points offsets are present, we should get them
@@ -445,31 +447,25 @@ static int cedrus_h265_setup(struct cedrus_ctx *ctx, struct cedrus_run *run)
 		DIV_ROUND_UP(sps->pic_width_in_luma_samples, ctb_size_luma);
 
 	/* MV column buffer size and allocation. */
-	if (!ctx->codec.h265.mv_col_buf_size) {
-		unsigned int num_buffers =
-			run->dst->vb2_buf.vb2_queue->num_buffers;
-
+	if (!cedrus_buf->codec.h265.mv_col_buf_size) {
 		/*
 		 * Each CTB requires a MV col buffer with a specific unit size.
 		 * Since the address is given with missing lsb bits, 1 KiB is
 		 * added to each buffer to ensure proper alignment.
 		 */
-		ctx->codec.h265.mv_col_buf_unit_size =
+		cedrus_buf->codec.h265.mv_col_buf_size =
 			DIV_ROUND_UP(ctx->src_fmt.width, ctb_size_luma) *
 			DIV_ROUND_UP(ctx->src_fmt.height, ctb_size_luma) *
 			CEDRUS_H265_MV_COL_BUF_UNIT_CTB_SIZE + SZ_1K;
 
-		ctx->codec.h265.mv_col_buf_size = num_buffers *
-			ctx->codec.h265.mv_col_buf_unit_size;
-
 		/* Buffer is never accessed by CPU, so we can skip kernel mapping. */
-		ctx->codec.h265.mv_col_buf =
+		cedrus_buf->codec.h265.mv_col_buf =
 			dma_alloc_attrs(dev->dev,
-					ctx->codec.h265.mv_col_buf_size,
-					&ctx->codec.h265.mv_col_buf_addr,
+					cedrus_buf->codec.h265.mv_col_buf_size,
+					&cedrus_buf->codec.h265.mv_col_buf_dma,
 					GFP_KERNEL, DMA_ATTR_NO_KERNEL_MAPPING);
-		if (!ctx->codec.h265.mv_col_buf) {
-			ctx->codec.h265.mv_col_buf_size = 0;
+		if (!cedrus_buf->codec.h265.mv_col_buf) {
+			cedrus_buf->codec.h265.mv_col_buf_size = 0;
 			return -ENOMEM;
 		}
 	}
@@ -816,9 +812,6 @@ static int cedrus_h265_start(struct cedrus_ctx *ctx)
 {
 	struct cedrus_dev *dev = ctx->dev;
 
-	/* The buffer size is calculated at setup time. */
-	ctx->codec.h265.mv_col_buf_size = 0;
-
 	/* Buffer is never accessed by CPU, so we can skip kernel mapping. */
 	ctx->codec.h265.neighbor_info_buf =
 		dma_alloc_attrs(dev->dev, CEDRUS_H265_NEIGHBOR_INFO_BUF_SIZE,
@@ -845,14 +838,24 @@ static int cedrus_h265_start(struct cedrus_ctx *ctx)
 static void cedrus_h265_stop(struct cedrus_ctx *ctx)
 {
 	struct cedrus_dev *dev = ctx->dev;
+	struct cedrus_buffer *buf;
+	struct vb2_queue *vq;
+	unsigned int i;
 
-	if (ctx->codec.h265.mv_col_buf_size > 0) {
-		dma_free_attrs(dev->dev, ctx->codec.h265.mv_col_buf_size,
-			       ctx->codec.h265.mv_col_buf,
-			       ctx->codec.h265.mv_col_buf_addr,
-			       DMA_ATTR_NO_KERNEL_MAPPING);
+	vq = v4l2_m2m_get_vq(ctx->fh.m2m_ctx, V4L2_BUF_TYPE_VIDEO_CAPTURE);
 
-		ctx->codec.h265.mv_col_buf_size = 0;
+	for (i = 0; i < vq->num_buffers; i++) {
+		buf = vb2_to_cedrus_buffer(vb2_get_buffer(vq, i));
+
+		if (buf->codec.h265.mv_col_buf_size > 0) {
+			dma_free_attrs(dev->dev,
+				       buf->codec.h265.mv_col_buf_size,
+				       buf->codec.h265.mv_col_buf,
+				       buf->codec.h265.mv_col_buf_dma,
+				       DMA_ATTR_NO_KERNEL_MAPPING);
+
+			buf->codec.h265.mv_col_buf_size = 0;
+		}
 	}
 
 	dma_free_attrs(dev->dev, CEDRUS_H265_NEIGHBOR_INFO_BUF_SIZE,
-- 
2.38.0

