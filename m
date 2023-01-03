Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93AB065C4AE
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 18:06:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238520AbjACRFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 12:05:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238435AbjACREk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 12:04:40 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 565AC13F4D;
        Tue,  3 Jan 2023 09:01:28 -0800 (PST)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:abfa:cf23:1e4e:2b14])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B6A496602D22;
        Tue,  3 Jan 2023 17:01:15 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1672765276;
        bh=0evQrqRnb9kaCHHqbzsXzEtQVoBvZbX6zxh5lAc3G0c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=arepqSVfQN9tsFnEFv9RYCmekD+1+YPbuLQ8pislwVcVNHN2ptorkKFwfFSo80Sxq
         hlHoZkcev+T5yk3CgDaECuN88IRrZhSEQighCKaaQzaDQseNESCMMmxLawwb2xuPIh
         kKuvbd5wq2hp8BjPZbTLVkiRDT7DeMHid/KcEFtrL4jQ5HAQGO/2gf6ddfHKsz9EXl
         oSVKBETny+KuSORyr1/lupX9Vw9yc4iyIHAP/xdhur6dHBCFV3g8MsUWD6Vr8BP4KF
         wYwqja4MnC+9BsuM8NpXVKwiB4ttiY+i81823qwgTJ9v4iNqgZBVUN+hO3ZqZInM3R
         VtPkuHWsnR1iA==
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
To:     ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        mchehab@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, heiko@sntech.de,
        daniel.almeida@collabora.com, nicolas.dufresne@collabora.co.uk
Cc:     linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH v2 13/13] media: verisilicon: Conditionnaly ignore native formats
Date:   Tue,  3 Jan 2023 18:00:58 +0100
Message-Id: <20230103170058.810597-14-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230103170058.810597-1-benjamin.gaignard@collabora.com>
References: <20230103170058.810597-1-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AV1 film grain feature requires to use the postprocessor to produce
valid frames. In such case the driver shouldn't propose native pixels
format but only post-processed pixels format.
If a codec set need_postproc field in hantro_ctx structure to true
native pixel formats will be ignored.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
 drivers/media/platform/verisilicon/hantro.h   |  3 ++
 .../media/platform/verisilicon/hantro_drv.c   |  5 ++
 .../platform/verisilicon/hantro_postproc.c    |  4 ++
 .../media/platform/verisilicon/hantro_v4l2.c  | 46 +++++++++++++------
 4 files changed, 45 insertions(+), 13 deletions(-)

diff --git a/drivers/media/platform/verisilicon/hantro.h b/drivers/media/platform/verisilicon/hantro.h
index a98cb40a8d3b..7a5357e810fb 100644
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
@@ -258,6 +260,7 @@ struct hantro_ctx {
 	struct v4l2_ctrl_handler ctrl_handler;
 	int jpeg_quality;
 	int bit_depth;
+	bool need_postproc;
 
 	const struct hantro_codec_ops *codec_ops;
 	struct hantro_postproc_ctx postproc;
diff --git a/drivers/media/platform/verisilicon/hantro_drv.c b/drivers/media/platform/verisilicon/hantro_drv.c
index 4fc6dea16ae6..8d7055c0bf3b 100644
--- a/drivers/media/platform/verisilicon/hantro_drv.c
+++ b/drivers/media/platform/verisilicon/hantro_drv.c
@@ -346,6 +346,11 @@ static int hantro_av1_s_ctrl(struct v4l2_ctrl *ctrl)
 				return -EINVAL;
 
 		ctx->bit_depth = bit_depth;
+
+		if (ctrl->p_new.p_av1_sequence->flags
+		    & V4L2_AV1_SEQUENCE_FLAG_FILM_GRAIN_PARAMS_PRESENT)
+			ctx->need_postproc = true;
+
 		break;
 	default:
 		return -EINVAL;
diff --git a/drivers/media/platform/verisilicon/hantro_postproc.c b/drivers/media/platform/verisilicon/hantro_postproc.c
index 7dc39519a2ee..293e5612e2ce 100644
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
 
diff --git a/drivers/media/platform/verisilicon/hantro_v4l2.c b/drivers/media/platform/verisilicon/hantro_v4l2.c
index bbe79dbd2cd9..5c381766cca3 100644
--- a/drivers/media/platform/verisilicon/hantro_v4l2.c
+++ b/drivers/media/platform/verisilicon/hantro_v4l2.c
@@ -38,6 +38,11 @@ hantro_get_formats(const struct hantro_ctx *ctx, unsigned int *num_fmts)
 {
 	const struct hantro_fmt *formats;
 
+	if (ctx->need_postproc) {
+		*num_fmts = 0;
+		return NULL;
+	}
+
 	if (ctx->is_encoder) {
 		formats = ctx->dev->variant->enc_fmts;
 		*num_fmts = ctx->dev->variant->num_enc_fmts;
@@ -132,6 +137,15 @@ hantro_get_default_fmt(const struct hantro_ctx *ctx, bool bitstream)
 		    hantro_check_depth_match(ctx, &formats[i]))
 			return &formats[i];
 	}
+
+	formats = hantro_get_postproc_formats(ctx, &num_fmts);
+	for (i = 0; i < num_fmts; i++) {
+		if (bitstream == (formats[i].codec_mode !=
+				  HANTRO_MODE_NONE) &&
+		    hantro_check_depth_match(ctx, &formats[i]))
+			return &formats[i];
+	}
+
 	return NULL;
 }
 
@@ -261,19 +275,6 @@ static int vidioc_g_fmt_out_mplane(struct file *file, void *priv,
 	return 0;
 }
 
-static int vidioc_g_fmt_cap_mplane(struct file *file, void *priv,
-				   struct v4l2_format *f)
-{
-	struct v4l2_pix_format_mplane *pix_mp = &f->fmt.pix_mp;
-	struct hantro_ctx *ctx = fh_to_ctx(priv);
-
-	vpu_debug(4, "f->type = %d\n", f->type);
-
-	*pix_mp = ctx->dst_fmt;
-
-	return 0;
-}
-
 static int hantro_try_fmt(const struct hantro_ctx *ctx,
 			  struct v4l2_pix_format_mplane *pix_mp,
 			  enum v4l2_buf_type type)
@@ -353,6 +354,25 @@ static int hantro_try_fmt(const struct hantro_ctx *ctx,
 	return 0;
 }
 
+static int vidioc_g_fmt_cap_mplane(struct file *file, void *priv,
+				   struct v4l2_format *f)
+{
+	struct v4l2_pix_format_mplane *pix_mp = &f->fmt.pix_mp;
+	struct hantro_ctx *ctx = fh_to_ctx(priv);
+	int ret;
+
+	vpu_debug(4, "f->type = %d\n", f->type);
+
+	ret = hantro_try_fmt(ctx, pix_mp, f->type);
+	if (ret)
+		return ret;
+
+	ctx->vpu_dst_fmt = hantro_find_format(ctx, pix_mp->pixelformat);
+	ctx->dst_fmt = *pix_mp;
+
+	return 0;
+}
+
 static int vidioc_try_fmt_cap_mplane(struct file *file, void *priv,
 				     struct v4l2_format *f)
 {
-- 
2.34.1

