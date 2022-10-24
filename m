Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A3B660BD06
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 00:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbiJXWES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 18:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231586AbiJXWDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 18:03:39 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEAE51D374A;
        Mon, 24 Oct 2022 13:17:47 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id y14so7596468ejd.9;
        Mon, 24 Oct 2022 13:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=br85ZXo6PMYmOWPRWm1Lwu7e9xuitFs0s08ZOKz/bEw=;
        b=mlFlARERiNpYjdF46Kjy8T2k8M5VqBqW+0lP/3ZaGdJdLyWr3eWrtj0AqiAmbWNmY5
         mNJatXSjxSksNHCBcbS0M6aTlxc31B429GKIN6mfOm0h2uZrV/IZjg8LB+on5gOqe83g
         qJA/CU8X4aqCaKb2/0SJlcdTucW+ABvLWVczuoFRiahl37pPCD+xgHVfB+E4GZBmJGoY
         82Af+7hFZVPBW3hsYibOIz9KRt8aOvoXrqXSNMt4RfE+4rojr6T8n2/J01/03QsmippX
         3+qV0m58wEgxhmO2PzzLoJsrBAPSaZvN4RDZXMuQKupmwKZ8k2xCeEu7tJzPfiJyNGO9
         4d4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=br85ZXo6PMYmOWPRWm1Lwu7e9xuitFs0s08ZOKz/bEw=;
        b=k0GXCafShBUCuuk0mhactDVUC9D5V8XY+VKsA/Jms+2mOVW1wKMuL0F9mX1Aib0rlz
         /FZ9it8nxOyNQRya1ut25aPlSaPEfhUP7o/PP+1w7bfAmslOTq4ZM2cwJP6T4Wk3Qx35
         t3wCsJAMVISa+k8l56IuvAnIOoMFbcji78EzHObagMN2tbgQm2d2n4EhB6PnwZrfye2L
         O3/T7XeuJ8d66Hk5eQuStMIJvJ1PbBrdVm4hmRR2mMKGJt2OCy5/EVUxe4PYk3ULlD6p
         a+XFvWQpUGlxFraq1VPUGWUQ1RAgAu1iNLT1KWGDCnM3S1yvVZHiFsHzpswcjqz2CVuI
         iu+Q==
X-Gm-Message-State: ACrzQf1mauvyfX3QEFv+v2126rSzVA1F05/sR/18vmDxBPslZuZRW3dG
        YUqa+1LLshQqmZzkarpavdg=
X-Google-Smtp-Source: AMsMyM5KQZfPD1opR7zU+y0gTmmW2ZKeYjkvwDeB6NY2dSICdJVz7xLcoPyYJBVIOYotpP9scfi4aA==
X-Received: by 2002:a17:906:9bca:b0:78d:bc5a:9137 with SMTP id de10-20020a1709069bca00b0078dbc5a9137mr30735316ejc.25.1666642541563;
        Mon, 24 Oct 2022 13:15:41 -0700 (PDT)
Received: from kista.localdomain (82-149-19-102.dynamic.telemach.net. [82.149.19.102])
        by smtp.gmail.com with ESMTPSA id op7-20020a170906bce700b0073d638a7a89sm332023ejb.99.2022.10.24.13.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 13:15:41 -0700 (PDT)
From:   Jernej Skrabec <jernej.skrabec@gmail.com>
To:     mripard@kernel.org, paul.kocialkowski@bootlin.com
Cc:     mchehab@kernel.org, gregkh@linuxfoundation.org, wens@csie.org,
        samuel@sholland.org, hverkuil-cisco@xs4all.nl,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH 11/11] media: cedrus: h265: Support decoding 10-bit frames
Date:   Mon, 24 Oct 2022 22:15:15 +0200
Message-Id: <20221024201515.34129-12-jernej.skrabec@gmail.com>
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

10-bit frames needs extra buffer space when 8-bit capture format is
used. Use previously prepared infrastructure to adjust buffer size.

Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/staging/media/sunxi/cedrus/cedrus.c   |  7 ++++
 drivers/staging/media/sunxi/cedrus/cedrus.h   |  1 +
 .../staging/media/sunxi/cedrus/cedrus_h265.c  | 35 +++++++++++++++++++
 .../staging/media/sunxi/cedrus/cedrus_regs.h  | 16 +++++++++
 4 files changed, 59 insertions(+)

diff --git a/drivers/staging/media/sunxi/cedrus/cedrus.c b/drivers/staging/media/sunxi/cedrus/cedrus.c
index fbe3b2e7c1d4..1054528dbb32 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus.c
+++ b/drivers/staging/media/sunxi/cedrus/cedrus.c
@@ -75,6 +75,13 @@ static int cedrus_s_ctrl(struct v4l2_ctrl *ctrl)
 	struct vb2_queue *vq = v4l2_m2m_get_vq(ctx->fh.m2m_ctx,
 					       V4L2_BUF_TYPE_VIDEO_CAPTURE);
 
+	if (ctrl->id == V4L2_CID_STATELESS_HEVC_SPS) {
+		const struct v4l2_ctrl_hevc_sps *sps = ctrl->p_new.p_hevc_sps;
+
+		ctx->bit_depth = max(sps->bit_depth_luma_minus8,
+				     sps->bit_depth_chroma_minus8) + 8;
+	}
+
 	if (!vb2_is_busy(vq) && !vb2_is_streaming(vq))
 		cedrus_reset_cap_format(ctx);
 
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

