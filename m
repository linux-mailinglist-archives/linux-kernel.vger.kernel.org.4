Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7746E62325A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 19:23:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbiKISXb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 13:23:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbiKISX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 13:23:26 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAEA3337;
        Wed,  9 Nov 2022 10:23:22 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id f5so49136500ejc.5;
        Wed, 09 Nov 2022 10:23:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7QNQeeFMMLF8vBEvJ+FLblDUcbcD9cwVY8taPegWwVA=;
        b=oBdxTA5GE7I+X8qN2FycqtID3GmtH1rf8SEk09lq0tYnwm9Wkm1RdXPaXCGOutsqpf
         TTzrU0dwnfY7zNnPOL8eiEKQeWQoz1NFnZbLxRIJQt9GZDs56Y+a98VdBM//9a7xWK6F
         2LnCrVK9DJqX6lIJVNv6PPQtgvI2vmtPCR+xNUpXFIzU9n/CbX3EmJe7I2xYDjXtq34V
         DRrn44SzQ1fyxe4srI7bdZ42ZaDjC9C9ObiMlYh18mlBsB1g1gtuP2e2uDnhUlrD8l89
         lOAjVaAoC4i2BFZSeBcMiSsGiFAVSFNUZN29WGZqqE6Pqb6JCdMjizi5+KPDci22fOwq
         gw8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7QNQeeFMMLF8vBEvJ+FLblDUcbcD9cwVY8taPegWwVA=;
        b=u2ArSdxnSvclqvXKdGSBI2628lZphAZZR1oHsPD6PtYM4r94GJsadxO0N+/VZb4hg0
         6kxjQgfFbAx2EsiTR7bvL9KcVtZpAqyzQRdyZfwJ5FuboXa0iboTNnDV4SoAi0dNubeL
         q8A5uNFXV55Pq4n20Z9KR5ZK0pTj+I2rBXUSxawRyBBnTERzKWhDIBNAqBlc1+rRRJd0
         Nz75dDaJWpb8lauOwefqmF5m5v9o2Ayg6XY15bIL4gFfeQOsNBkJv8G0gj0tOcuvnnUT
         H9OZemqF0BsFe7PUHOpVbhnb0xDU/03Tkx5+Lap6FX5jSHAJnJbVVEoKs3+xcGNj40LD
         biAw==
X-Gm-Message-State: ACrzQf3+uEazujD6+ZwZU+8OaBL1aBmJv/sLKWQ+VxMZ99RrvxRHI1b0
        SidD0Gcm2Bq1m+br6GhwH3c=
X-Google-Smtp-Source: AMsMyM58inNKtrTCuRKXM3NtqPxhGXlHP/Ybprv3X/XcslpCiCmMrKC+XyWtT6mu/y+OKAZrwbaFGg==
X-Received: by 2002:a17:906:4898:b0:78d:4935:1ad8 with SMTP id v24-20020a170906489800b0078d49351ad8mr1492956ejq.564.1668018201014;
        Wed, 09 Nov 2022 10:23:21 -0800 (PST)
Received: from kista.localdomain (82-149-19-102.dynamic.telemach.net. [82.149.19.102])
        by smtp.gmail.com with ESMTPSA id gj26-20020a170906e11a00b007a0b28c324dsm6029400ejb.126.2022.11.09.10.23.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 10:23:20 -0800 (PST)
From:   Jernej Skrabec <jernej.skrabec@gmail.com>
To:     mripard@kernel.org, paul.kocialkowski@bootlin.com
Cc:     mchehab@kernel.org, gregkh@linuxfoundation.org, wens@csie.org,
        samuel@sholland.org, hverkuil-cisco@xs4all.nl,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH v3 2/3] media: cedrus: h265: Support decoding 10-bit frames
Date:   Wed,  9 Nov 2022 19:23:08 +0100
Message-Id: <20221109182309.2475221-3-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221109182309.2475221-1-jernej.skrabec@gmail.com>
References: <20221109182309.2475221-1-jernej.skrabec@gmail.com>
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

10-bit frames needs extra buffer space when 8-bit capture format is
used. Use previously prepared infrastructure to adjust buffer size.

Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/staging/media/sunxi/cedrus/cedrus.c   | 21 +++++++++++
 drivers/staging/media/sunxi/cedrus/cedrus.h   |  1 +
 .../staging/media/sunxi/cedrus/cedrus_h265.c  | 35 +++++++++++++++++++
 .../staging/media/sunxi/cedrus/cedrus_regs.h  | 16 +++++++++
 4 files changed, 73 insertions(+)

diff --git a/drivers/staging/media/sunxi/cedrus/cedrus.c b/drivers/staging/media/sunxi/cedrus/cedrus.c
index 6a2c08928613..2e860cf60136 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus.c
+++ b/drivers/staging/media/sunxi/cedrus/cedrus.c
@@ -45,6 +45,8 @@ static int cedrus_try_ctrl(struct v4l2_ctrl *ctrl)
 	} else if (ctrl->id == V4L2_CID_STATELESS_HEVC_SPS) {
 		const struct v4l2_ctrl_hevc_sps *sps = ctrl->p_new.p_hevc_sps;
 		struct cedrus_ctx *ctx = container_of(ctrl->handler, struct cedrus_ctx, hdl);
+		unsigned int bit_depth;
+		struct vb2_queue *vq;
 
 		if (sps->chroma_format_idc != 1)
 			/* Only 4:2:0 is supported */
@@ -63,6 +65,24 @@ static int cedrus_try_ctrl(struct v4l2_ctrl *ctrl)
 				/* Only 8-bit is supported */
 				return -EINVAL;
 		}
+
+		bit_depth = max(sps->bit_depth_luma_minus8,
+				sps->bit_depth_chroma_minus8) + 8;
+
+		vq = v4l2_m2m_get_vq(ctx->fh.m2m_ctx,
+				     V4L2_BUF_TYPE_VIDEO_CAPTURE);
+
+		/*
+		 * Bit depth can't be higher than currently set once
+		 * buffers are allocated.
+		 */
+		if (vb2_is_busy(vq)) {
+			if (ctx->bit_depth < bit_depth)
+				return -EINVAL;
+		} else {
+			ctx->bit_depth = bit_depth;
+			cedrus_reset_cap_format(ctx);
+		}
 	}
 
 	return 0;
@@ -354,6 +374,7 @@ static int cedrus_open(struct file *file)
 	v4l2_fh_init(&ctx->fh, video_devdata(file));
 	file->private_data = &ctx->fh;
 	ctx->dev = dev;
+	ctx->bit_depth = 8;
 
 	ctx->fh.m2m_ctx = v4l2_m2m_ctx_init(dev->m2m_dev, ctx,
 					    &cedrus_queue_init);
diff --git a/drivers/staging/media/sunxi/cedrus/cedrus.h b/drivers/staging/media/sunxi/cedrus/cedrus.h
index 774fe8048ce3..522c184e2afc 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus.h
+++ b/drivers/staging/media/sunxi/cedrus/cedrus.h
@@ -119,6 +119,7 @@ struct cedrus_ctx {
 	struct v4l2_pix_format		src_fmt;
 	struct v4l2_pix_format		dst_fmt;
 	struct cedrus_dec_ops		*current_codec;
+	unsigned int			bit_depth;
 
 	struct v4l2_ctrl_handler	hdl;
 	struct v4l2_ctrl		**ctrls;
diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_h265.c b/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
index 5d3da50ce46a..fc9297232456 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
+++ b/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
@@ -41,6 +41,19 @@ struct cedrus_h265_sram_pred_weight {
 	__s8	offset;
 } __packed;
 
+static unsigned int cedrus_h265_2bit_size(unsigned int width,
+					  unsigned int height)
+{
+	/*
+	 * Vendor library additionally aligns width and height to 16,
+	 * but all capture formats are already aligned to that anyway,
+	 * so we can skip that here. All formats are also one form of
+	 * YUV 4:2:0 or another, so we can safely assume multiplication
+	 * factor of 1.5.
+	 */
+	return ALIGN(width / 4, 32) * height * 3 / 2;
+}
+
 static enum cedrus_irq_status cedrus_h265_irq_status(struct cedrus_ctx *ctx)
 {
 	struct cedrus_dev *dev = ctx->dev;
@@ -802,6 +815,18 @@ static int cedrus_h265_setup(struct cedrus_ctx *ctx, struct cedrus_run *run)
 						      VE_DEC_H265_SRAM_OFFSET_PRED_WEIGHT_CHROMA_L1);
 	}
 
+	if (ctx->bit_depth > 8) {
+		unsigned int stride = ALIGN(ctx->dst_fmt.width / 4, 32);
+
+		reg = ctx->dst_fmt.sizeimage -
+		      cedrus_h265_2bit_size(ctx->dst_fmt.width,
+					    ctx->dst_fmt.height);
+		cedrus_write(dev, VE_DEC_H265_OFFSET_ADDR_FIRST_OUT, reg);
+
+		reg = VE_DEC_H265_10BIT_CONFIGURE_FIRST_2BIT_STRIDE(stride);
+		cedrus_write(dev, VE_DEC_H265_10BIT_CONFIGURE, reg);
+	}
+
 	/* Enable appropriate interruptions. */
 	cedrus_write(dev, VE_DEC_H265_CTRL, VE_DEC_H265_CTRL_IRQ_MASK);
 
@@ -874,6 +899,15 @@ static void cedrus_h265_trigger(struct cedrus_ctx *ctx)
 	cedrus_write(dev, VE_DEC_H265_TRIGGER, VE_DEC_H265_TRIGGER_DEC_SLICE);
 }
 
+static unsigned int cedrus_h265_extra_cap_size(struct cedrus_ctx *ctx,
+					       struct v4l2_pix_format *pix_fmt)
+{
+	if (ctx->bit_depth > 8)
+		return cedrus_h265_2bit_size(pix_fmt->width, pix_fmt->height);
+
+	return 0;
+}
+
 struct cedrus_dec_ops cedrus_dec_ops_h265 = {
 	.irq_clear	= cedrus_h265_irq_clear,
 	.irq_disable	= cedrus_h265_irq_disable,
@@ -882,4 +916,5 @@ struct cedrus_dec_ops cedrus_dec_ops_h265 = {
 	.start		= cedrus_h265_start,
 	.stop		= cedrus_h265_stop,
 	.trigger	= cedrus_h265_trigger,
+	.extra_cap_size	= cedrus_h265_extra_cap_size,
 };
diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_regs.h b/drivers/staging/media/sunxi/cedrus/cedrus_regs.h
index 655c05b389cf..05e6cbc548ab 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus_regs.h
+++ b/drivers/staging/media/sunxi/cedrus/cedrus_regs.h
@@ -498,6 +498,22 @@
 
 #define VE_DEC_H265_LOW_ADDR			(VE_ENGINE_DEC_H265 + 0x80)
 
+#define VE_DEC_H265_OFFSET_ADDR_FIRST_OUT	(VE_ENGINE_DEC_H265 + 0x84)
+#define VE_DEC_H265_OFFSET_ADDR_SECOND_OUT	(VE_ENGINE_DEC_H265 + 0x88)
+
+#define VE_DEC_H265_SECOND_OUT_FMT_8BIT_PLUS_2BIT	0
+#define VE_DEC_H265_SECOND_OUT_FMT_P010			1
+#define VE_DEC_H265_SECOND_OUT_FMT_10BIT_4x4_TILED	2
+
+#define VE_DEC_H265_10BIT_CONFIGURE_SECOND_OUT_FMT(v) \
+	SHIFT_AND_MASK_BITS(v, 24, 23)
+#define VE_DEC_H265_10BIT_CONFIGURE_SECOND_2BIT_ENABLE	BIT(22)
+#define VE_DEC_H265_10BIT_CONFIGURE_SECOND_2BIT_STRIDE(v) \
+	SHIFT_AND_MASK_BITS(v, 21, 11)
+#define VE_DEC_H265_10BIT_CONFIGURE_FIRST_2BIT_STRIDE(v) \
+	SHIFT_AND_MASK_BITS(v, 10, 0)
+#define VE_DEC_H265_10BIT_CONFIGURE		(VE_ENGINE_DEC_H265 + 0x8c)
+
 #define VE_DEC_H265_LOW_ADDR_PRIMARY_CHROMA(a) \
 	SHIFT_AND_MASK_BITS(a, 31, 24)
 #define VE_DEC_H265_LOW_ADDR_SECONDARY_CHROMA(a) \
-- 
2.38.1

