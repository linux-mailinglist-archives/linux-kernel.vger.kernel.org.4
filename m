Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DEEE6F5359
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 10:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbjECIfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 04:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbjECIfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 04:35:04 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 834534C0B;
        Wed,  3 May 2023 01:34:53 -0700 (PDT)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:8234:977e:ebbe:d70b])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id DC6696602338;
        Wed,  3 May 2023 09:34:51 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1683102892;
        bh=+nJRo7eNs3g9xQU2LLTvjIA+A4S3t3t+2Fn3IItEqx0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U1cfSlkhfnF+2VeAMPDFTSSA26aARVhesedl8dKqAaxNmKJvx9OJw1mMHf9E9ZnlN
         M9kY21aRvXB5uHeGk3EaFuGQkxyBrTzhIH0BmiIjjLa1eHJmtBW3TxViyKA80n78ES
         rAFBWH+V8MafMwCXNDmB5sMhOM8wRzS9O/tmPdIvzWSkr2oef8TjzRBlDOuUBDgBCq
         hgD/Tb7k6KD7/r9FamPGBqCDoCR8A8T57TuuvpVgUakX9kQ0Yn3D+svsliepVs4AXc
         9g1M8SXm/jJxBj0+G7HogKxlJROB5DWASrLwjAfrWT+5cu2aXXRonLIc3RZKSHyBxj
         CBZtq6f1FFpsQ==
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
To:     ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        mchehab@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, heiko@sntech.de,
        hverkuil-cisco@xs4all.nl, nicolas.dufresne@collabora.com
Cc:     linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH v7 13/13] media: verisilicon: Conditionally ignore native formats
Date:   Wed,  3 May 2023 10:34:38 +0200
Message-Id: <20230503083438.85139-14-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230503083438.85139-1-benjamin.gaignard@collabora.com>
References: <20230503083438.85139-1-benjamin.gaignard@collabora.com>
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

AV1 film grain feature requires to use the postprocessor to produce
valid frames. In such case the driver shouldn't propose native pixels
format but only post-processed pixels format.
Additionally if when setting a control a value could change capture
queue pixels formats it is needed to call hantro_reset_raw_fmt().

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
---
 drivers/media/platform/verisilicon/hantro.h   |  3 +
 .../media/platform/verisilicon/hantro_drv.c   | 14 +++--
 .../platform/verisilicon/hantro_postproc.c    |  6 +-
 .../media/platform/verisilicon/hantro_v4l2.c  | 57 +++++++++++++------
 .../media/platform/verisilicon/hantro_v4l2.h  |  8 ++-
 5 files changed, 63 insertions(+), 25 deletions(-)

diff --git a/drivers/media/platform/verisilicon/hantro.h b/drivers/media/platform/verisilicon/hantro.h
index a98cb40a8d3b..6523ffb74881 100644
--- a/drivers/media/platform/verisilicon/hantro.h
+++ b/drivers/media/platform/verisilicon/hantro.h
@@ -231,6 +231,8 @@ struct hantro_dev {
  * @ctrl_handler:	Control handler used to register controls.
  * @jpeg_quality:	User-specified JPEG compression quality.
  * @bit_depth:		Bit depth of current frame
+ * @need_postproc:	Set to true if the bitstream features require to
+ *			use the post-processor.
  *
  * @codec_ops:		Set of operations related to codec mode.
  * @postproc:		Post-processing context.
@@ -261,6 +263,7 @@ struct hantro_ctx {
 
 	const struct hantro_codec_ops *codec_ops;
 	struct hantro_postproc_ctx postproc;
+	bool need_postproc;
 
 	/* Specific for particular codec modes. */
 	union {
diff --git a/drivers/media/platform/verisilicon/hantro_drv.c b/drivers/media/platform/verisilicon/hantro_drv.c
index dd41a6de1a0c..c0a368bacf88 100644
--- a/drivers/media/platform/verisilicon/hantro_drv.c
+++ b/drivers/media/platform/verisilicon/hantro_drv.c
@@ -319,7 +319,7 @@ static int hantro_vp9_s_ctrl(struct v4l2_ctrl *ctrl)
 		if (ctx->bit_depth == bit_depth)
 			return 0;
 
-		return hantro_reset_raw_fmt(ctx, bit_depth);
+		return hantro_reset_raw_fmt(ctx, bit_depth, HANTRO_AUTO_POSTPROC);
 	}
 	default:
 		return -EINVAL;
@@ -343,7 +343,7 @@ static int hantro_hevc_s_ctrl(struct v4l2_ctrl *ctrl)
 		if (ctx->bit_depth == bit_depth)
 			return 0;
 
-		return hantro_reset_raw_fmt(ctx, bit_depth);
+		return hantro_reset_raw_fmt(ctx, bit_depth, HANTRO_AUTO_POSTPROC);
 	}
 	default:
 		return -EINVAL;
@@ -363,11 +363,17 @@ static int hantro_av1_s_ctrl(struct v4l2_ctrl *ctrl)
 	case V4L2_CID_STATELESS_AV1_SEQUENCE:
 	{
 		int bit_depth = ctrl->p_new.p_av1_sequence->bit_depth;
+		bool need_postproc = HANTRO_AUTO_POSTPROC;
 
-		if (ctx->bit_depth == bit_depth)
+		if (ctrl->p_new.p_av1_sequence->flags
+		    & V4L2_AV1_SEQUENCE_FLAG_FILM_GRAIN_PARAMS_PRESENT)
+			need_postproc = HANTRO_FORCE_POSTPROC;
+
+		if (ctx->bit_depth == bit_depth &&
+		    ctx->need_postproc == need_postproc)
 			return 0;
 
-		return hantro_reset_raw_fmt(ctx, bit_depth);
+		return hantro_reset_raw_fmt(ctx, bit_depth, need_postproc);
 	}
 	default:
 		return -EINVAL;
diff --git a/drivers/media/platform/verisilicon/hantro_postproc.c b/drivers/media/platform/verisilicon/hantro_postproc.c
index bb16af50719d..c977d64105b1 100644
--- a/drivers/media/platform/verisilicon/hantro_postproc.c
+++ b/drivers/media/platform/verisilicon/hantro_postproc.c
@@ -57,6 +57,10 @@ bool hantro_needs_postproc(const struct hantro_ctx *ctx,
 {
 	if (ctx->is_encoder)
 		return false;
+
+	if (ctx->need_postproc)
+		return true;
+
 	return fmt->postprocessed;
 }
 
@@ -197,7 +201,7 @@ int hantro_postproc_alloc(struct hantro_ctx *ctx)
 	unsigned int i, buf_size;
 
 	/* this should always pick native format */
-	fmt = hantro_get_default_fmt(ctx, false, ctx->bit_depth);
+	fmt = hantro_get_default_fmt(ctx, false, ctx->bit_depth, HANTRO_AUTO_POSTPROC);
 	if (!fmt)
 		return -EINVAL;
 	v4l2_fill_pixfmt_mp(&pix_mp, fmt->fourcc, ctx->src_fmt.width,
diff --git a/drivers/media/platform/verisilicon/hantro_v4l2.c b/drivers/media/platform/verisilicon/hantro_v4l2.c
index 1c76ca1fe1c6..66318dbe5031 100644
--- a/drivers/media/platform/verisilicon/hantro_v4l2.c
+++ b/drivers/media/platform/verisilicon/hantro_v4l2.c
@@ -31,15 +31,21 @@
 #define  HANTRO_DEFAULT_BIT_DEPTH 8
 
 static int hantro_set_fmt_out(struct hantro_ctx *ctx,
-			      struct v4l2_pix_format_mplane *pix_mp);
+			      struct v4l2_pix_format_mplane *pix_mp,
+			      bool need_postproc);
 static int hantro_set_fmt_cap(struct hantro_ctx *ctx,
 			      struct v4l2_pix_format_mplane *pix_mp);
 
 static const struct hantro_fmt *
-hantro_get_formats(const struct hantro_ctx *ctx, unsigned int *num_fmts)
+hantro_get_formats(const struct hantro_ctx *ctx, unsigned int *num_fmts, bool need_postproc)
 {
 	const struct hantro_fmt *formats;
 
+	if (need_postproc) {
+		*num_fmts = 0;
+		return NULL;
+	}
+
 	if (ctx->is_encoder) {
 		formats = ctx->dev->variant->enc_fmts;
 		*num_fmts = ctx->dev->variant->num_enc_fmts;
@@ -108,7 +114,7 @@ hantro_find_format(const struct hantro_ctx *ctx, u32 fourcc)
 	const struct hantro_fmt *formats;
 	unsigned int i, num_fmts;
 
-	formats = hantro_get_formats(ctx, &num_fmts);
+	formats = hantro_get_formats(ctx, &num_fmts, HANTRO_AUTO_POSTPROC);
 	for (i = 0; i < num_fmts; i++)
 		if (formats[i].fourcc == fourcc)
 			return &formats[i];
@@ -121,18 +127,28 @@ hantro_find_format(const struct hantro_ctx *ctx, u32 fourcc)
 }
 
 const struct hantro_fmt *
-hantro_get_default_fmt(const struct hantro_ctx *ctx, bool bitstream, int bit_depth)
+hantro_get_default_fmt(const struct hantro_ctx *ctx, bool bitstream,
+		       int bit_depth, bool need_postproc)
 {
 	const struct hantro_fmt *formats;
 	unsigned int i, num_fmts;
 
-	formats = hantro_get_formats(ctx, &num_fmts);
+	formats = hantro_get_formats(ctx, &num_fmts, need_postproc);
+	for (i = 0; i < num_fmts; i++) {
+		if (bitstream == (formats[i].codec_mode !=
+				  HANTRO_MODE_NONE) &&
+		    hantro_check_depth_match(&formats[i], bit_depth))
+			return &formats[i];
+	}
+
+	formats = hantro_get_postproc_formats(ctx, &num_fmts);
 	for (i = 0; i < num_fmts; i++) {
 		if (bitstream == (formats[i].codec_mode !=
 				  HANTRO_MODE_NONE) &&
 		    hantro_check_depth_match(&formats[i], bit_depth))
 			return &formats[i];
 	}
+
 	return NULL;
 }
 
@@ -199,7 +215,7 @@ static int vidioc_enum_fmt(struct file *file, void *priv,
 	 */
 	skip_mode_none = capture == ctx->is_encoder;
 
-	formats = hantro_get_formats(ctx, &num_fmts);
+	formats = hantro_get_formats(ctx, &num_fmts, HANTRO_AUTO_POSTPROC);
 	for (i = 0; i < num_fmts; i++) {
 		bool mode_none = formats[i].codec_mode == HANTRO_MODE_NONE;
 		fmt = &formats[i];
@@ -294,7 +310,7 @@ static int hantro_try_fmt(const struct hantro_ctx *ctx,
 
 	fmt = hantro_find_format(ctx, pix_mp->pixelformat);
 	if (!fmt) {
-		fmt = hantro_get_default_fmt(ctx, coded, HANTRO_DEFAULT_BIT_DEPTH);
+		fmt = hantro_get_default_fmt(ctx, coded, HANTRO_DEFAULT_BIT_DEPTH, HANTRO_AUTO_POSTPROC);
 		pix_mp->pixelformat = fmt->fourcc;
 	}
 
@@ -383,7 +399,7 @@ hantro_reset_encoded_fmt(struct hantro_ctx *ctx)
 	const struct hantro_fmt *vpu_fmt;
 	struct v4l2_pix_format_mplane fmt;
 
-	vpu_fmt = hantro_get_default_fmt(ctx, true, HANTRO_DEFAULT_BIT_DEPTH);
+	vpu_fmt = hantro_get_default_fmt(ctx, true, HANTRO_DEFAULT_BIT_DEPTH, HANTRO_AUTO_POSTPROC);
 	if (!vpu_fmt)
 		return;
 
@@ -393,17 +409,17 @@ hantro_reset_encoded_fmt(struct hantro_ctx *ctx)
 	if (ctx->is_encoder)
 		hantro_set_fmt_cap(ctx, &fmt);
 	else
-		hantro_set_fmt_out(ctx, &fmt);
+		hantro_set_fmt_out(ctx, &fmt, HANTRO_AUTO_POSTPROC);
 }
 
 int
-hantro_reset_raw_fmt(struct hantro_ctx *ctx, int bit_depth)
+hantro_reset_raw_fmt(struct hantro_ctx *ctx, int bit_depth, bool need_postproc)
 {
 	const struct hantro_fmt *raw_vpu_fmt;
 	struct v4l2_pix_format_mplane raw_fmt, *encoded_fmt;
 	int ret;
 
-	raw_vpu_fmt = hantro_get_default_fmt(ctx, false, bit_depth);
+	raw_vpu_fmt = hantro_get_default_fmt(ctx, false, bit_depth, need_postproc);
 	if (!raw_vpu_fmt)
 		return -EINVAL;
 
@@ -416,12 +432,14 @@ hantro_reset_raw_fmt(struct hantro_ctx *ctx, int bit_depth)
 	raw_fmt.width = encoded_fmt->width;
 	raw_fmt.height = encoded_fmt->height;
 	if (ctx->is_encoder)
-		ret = hantro_set_fmt_out(ctx, &raw_fmt);
+		ret = hantro_set_fmt_out(ctx, &raw_fmt, need_postproc);
 	else
 		ret = hantro_set_fmt_cap(ctx, &raw_fmt);
 
-	if (!ret)
+	if (!ret) {
 		ctx->bit_depth = bit_depth;
+		ctx->need_postproc = need_postproc;
+	}
 
 	return ret;
 }
@@ -429,7 +447,7 @@ hantro_reset_raw_fmt(struct hantro_ctx *ctx, int bit_depth)
 void hantro_reset_fmts(struct hantro_ctx *ctx)
 {
 	hantro_reset_encoded_fmt(ctx);
-	hantro_reset_raw_fmt(ctx, HANTRO_DEFAULT_BIT_DEPTH);
+	hantro_reset_raw_fmt(ctx, HANTRO_DEFAULT_BIT_DEPTH, HANTRO_AUTO_POSTPROC);
 }
 
 static void
@@ -476,7 +494,8 @@ hantro_update_requires_hold_capture_buf(struct hantro_ctx *ctx, u32 fourcc)
 }
 
 static int hantro_set_fmt_out(struct hantro_ctx *ctx,
-			      struct v4l2_pix_format_mplane *pix_mp)
+			      struct v4l2_pix_format_mplane *pix_mp,
+			      bool need_postproc)
 {
 	struct vb2_queue *vq;
 	int ret;
@@ -529,7 +548,9 @@ static int hantro_set_fmt_out(struct hantro_ctx *ctx,
 	 * changes to the raw format.
 	 */
 	if (!ctx->is_encoder)
-		hantro_reset_raw_fmt(ctx, hantro_get_format_depth(pix_mp->pixelformat));
+		hantro_reset_raw_fmt(ctx,
+				     hantro_get_format_depth(pix_mp->pixelformat),
+				     need_postproc);
 
 	/* Colorimetry information are always propagated. */
 	ctx->dst_fmt.colorspace = pix_mp->colorspace;
@@ -592,7 +613,7 @@ static int hantro_set_fmt_cap(struct hantro_ctx *ctx,
 	 * changes to the raw format.
 	 */
 	if (ctx->is_encoder)
-		hantro_reset_raw_fmt(ctx, HANTRO_DEFAULT_BIT_DEPTH);
+		hantro_reset_raw_fmt(ctx, HANTRO_DEFAULT_BIT_DEPTH, HANTRO_AUTO_POSTPROC);
 
 	/* Colorimetry information are always propagated. */
 	ctx->src_fmt.colorspace = pix_mp->colorspace;
@@ -612,7 +633,7 @@ static int hantro_set_fmt_cap(struct hantro_ctx *ctx,
 static int
 vidioc_s_fmt_out_mplane(struct file *file, void *priv, struct v4l2_format *f)
 {
-	return hantro_set_fmt_out(fh_to_ctx(priv), &f->fmt.pix_mp);
+	return hantro_set_fmt_out(fh_to_ctx(priv), &f->fmt.pix_mp, HANTRO_AUTO_POSTPROC);
 }
 
 static int
diff --git a/drivers/media/platform/verisilicon/hantro_v4l2.h b/drivers/media/platform/verisilicon/hantro_v4l2.h
index 9ea2fef57dcd..fca7e3a690e5 100644
--- a/drivers/media/platform/verisilicon/hantro_v4l2.h
+++ b/drivers/media/platform/verisilicon/hantro_v4l2.h
@@ -18,13 +18,17 @@
 
 #include "hantro.h"
 
+#define HANTRO_FORCE_POSTPROC	true
+#define HANTRO_AUTO_POSTPROC	false
+
 extern const struct v4l2_ioctl_ops hantro_ioctl_ops;
 extern const struct vb2_ops hantro_queue_ops;
 
-int hantro_reset_raw_fmt(struct hantro_ctx *ctx, int bit_depth);
+int hantro_reset_raw_fmt(struct hantro_ctx *ctx, int bit_depth, bool need_postproc);
 void hantro_reset_fmts(struct hantro_ctx *ctx);
 int hantro_get_format_depth(u32 fourcc);
 const struct hantro_fmt *
-hantro_get_default_fmt(const struct hantro_ctx *ctx, bool bitstream, int bit_depth);
+hantro_get_default_fmt(const struct hantro_ctx *ctx, bool bitstream,
+		       int bit_depth, bool need_postproc);
 
 #endif /* HANTRO_V4L2_H_ */
-- 
2.34.1

