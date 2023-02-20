Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12EC969C8EF
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 11:49:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbjBTKtM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 05:49:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231674AbjBTKtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 05:49:02 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCA67BB8C;
        Mon, 20 Feb 2023 02:49:00 -0800 (PST)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:d30c:b155:96fb:dcc])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 35FD6660213E;
        Mon, 20 Feb 2023 10:48:59 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676890139;
        bh=2xaNocEAF4qvDyOTrQtHPsoGywHnve83vDJYytz3whU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HVIizSRM6iS0VMRitcUVQDPtRkF7uHKIILgHsO799PkW3NTyM1hB6jFH+9GY214vI
         GEZgweR2KsZo0rTCPF26hE0vhfc2IVJlWrIzOcNdQTCkivd0ccnWk5y4LraF2wy0dr
         NQDpQRs0ZBpiwHutqHKrA7n7Ma6JJ9sKv++AxvhCVMfFL4xfFzzl+C/Y92QDUnPJj9
         CmENkqkCubhJiBnpEl+jWL5vB6aBhkfi5/ppSTSX0A+vTsakNfpNjKFn8STdICauMw
         Opc178TdEtFYvKw1l4t+QRTnT1lNW5r/gucal4+rGHSa/1rwR3IWfxPDNwilgYRCYt
         gh77Hd2iTCCBQ==
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
To:     ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        mchehab@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        hverkuil-cisco@xs4all.nl, nicolas.dufresne@collabora.co.uk,
        robert.mader@collabora.com
Cc:     linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>
Subject: [PATCH v9 4/6] media: verisilicon: Do not change context bit depth before validating the format
Date:   Mon, 20 Feb 2023 11:48:47 +0100
Message-Id: <20230220104849.398203-5-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230220104849.398203-1-benjamin.gaignard@collabora.com>
References: <20230220104849.398203-1-benjamin.gaignard@collabora.com>
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

It is needed to check if the proposed pixels format is valid before
updating context bit depth and other internal states.
Stop using ctx->bit_depth to check format depth match and return
result to the caller.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
---
 .../platform/verisilicon/hantro_postproc.c    |  2 +-
 .../media/platform/verisilicon/hantro_v4l2.c  | 51 ++++++++++---------
 .../media/platform/verisilicon/hantro_v4l2.h  |  3 +-
 3 files changed, 30 insertions(+), 26 deletions(-)

diff --git a/drivers/media/platform/verisilicon/hantro_postproc.c b/drivers/media/platform/verisilicon/hantro_postproc.c
index 09d8cf942689..6437423ccf3a 100644
--- a/drivers/media/platform/verisilicon/hantro_postproc.c
+++ b/drivers/media/platform/verisilicon/hantro_postproc.c
@@ -197,7 +197,7 @@ int hantro_postproc_alloc(struct hantro_ctx *ctx)
 	unsigned int i, buf_size;
 
 	/* this should always pick native format */
-	fmt = hantro_get_default_fmt(ctx, false);
+	fmt = hantro_get_default_fmt(ctx, false, ctx->bit_depth);
 	if (!fmt)
 		return -EINVAL;
 	v4l2_fill_pixfmt_mp(&pix_mp, fmt->fourcc, ctx->src_fmt.width,
diff --git a/drivers/media/platform/verisilicon/hantro_v4l2.c b/drivers/media/platform/verisilicon/hantro_v4l2.c
index d94c99f875c8..d238d407f986 100644
--- a/drivers/media/platform/verisilicon/hantro_v4l2.c
+++ b/drivers/media/platform/verisilicon/hantro_v4l2.c
@@ -28,6 +28,8 @@
 #include "hantro_hw.h"
 #include "hantro_v4l2.h"
 
+#define  HANTRO_DEFAULT_BIT_DEPTH 8
+
 static int hantro_set_fmt_out(struct hantro_ctx *ctx,
 			      struct v4l2_pix_format_mplane *pix_mp);
 static int hantro_set_fmt_cap(struct hantro_ctx *ctx,
@@ -76,18 +78,13 @@ int hantro_get_format_depth(u32 fourcc)
 }
 
 static bool
-hantro_check_depth_match(const struct hantro_ctx *ctx,
-			 const struct hantro_fmt *fmt)
+hantro_check_depth_match(const struct hantro_fmt *fmt, int bit_depth)
 {
-	int fmt_depth, ctx_depth = 8;
+	int fmt_depth;
 
 	if (!fmt->match_depth && !fmt->postprocessed)
 		return true;
 
-	/* 0 means default depth, which is 8 */
-	if (ctx->bit_depth)
-		ctx_depth = ctx->bit_depth;
-
 	fmt_depth = hantro_get_format_depth(fmt->fourcc);
 
 	/*
@@ -95,9 +92,9 @@ hantro_check_depth_match(const struct hantro_ctx *ctx,
 	 * It may be possible to relax that on some HW.
 	 */
 	if (!fmt->match_depth)
-		return fmt_depth <= ctx_depth;
+		return fmt_depth <= bit_depth;
 
-	return fmt_depth == ctx_depth;
+	return fmt_depth == bit_depth;
 }
 
 static const struct hantro_fmt *
@@ -119,7 +116,7 @@ hantro_find_format(const struct hantro_ctx *ctx, u32 fourcc)
 }
 
 const struct hantro_fmt *
-hantro_get_default_fmt(const struct hantro_ctx *ctx, bool bitstream)
+hantro_get_default_fmt(const struct hantro_ctx *ctx, bool bitstream, int bit_depth)
 {
 	const struct hantro_fmt *formats;
 	unsigned int i, num_fmts;
@@ -128,7 +125,7 @@ hantro_get_default_fmt(const struct hantro_ctx *ctx, bool bitstream)
 	for (i = 0; i < num_fmts; i++) {
 		if (bitstream == (formats[i].codec_mode !=
 				  HANTRO_MODE_NONE) &&
-		    hantro_check_depth_match(ctx, &formats[i]))
+		    hantro_check_depth_match(&formats[i], bit_depth))
 			return &formats[i];
 	}
 	return NULL;
@@ -204,7 +201,7 @@ static int vidioc_enum_fmt(struct file *file, void *priv,
 
 		if (skip_mode_none == mode_none)
 			continue;
-		if (!hantro_check_depth_match(ctx, fmt))
+		if (!hantro_check_depth_match(fmt, ctx->bit_depth))
 			continue;
 		if (j == f->index) {
 			f->pixelformat = fmt->fourcc;
@@ -224,7 +221,7 @@ static int vidioc_enum_fmt(struct file *file, void *priv,
 	for (i = 0; i < num_fmts; i++) {
 		fmt = &formats[i];
 
-		if (!hantro_check_depth_match(ctx, fmt))
+		if (!hantro_check_depth_match(fmt, ctx->bit_depth))
 			continue;
 		if (j == f->index) {
 			f->pixelformat = fmt->fourcc;
@@ -292,7 +289,7 @@ static int hantro_try_fmt(const struct hantro_ctx *ctx,
 
 	fmt = hantro_find_format(ctx, pix_mp->pixelformat);
 	if (!fmt) {
-		fmt = hantro_get_default_fmt(ctx, coded);
+		fmt = hantro_get_default_fmt(ctx, coded, HANTRO_DEFAULT_BIT_DEPTH);
 		pix_mp->pixelformat = fmt->fourcc;
 	}
 
@@ -380,7 +377,7 @@ hantro_reset_encoded_fmt(struct hantro_ctx *ctx)
 	const struct hantro_fmt *vpu_fmt;
 	struct v4l2_pix_format_mplane fmt;
 
-	vpu_fmt = hantro_get_default_fmt(ctx, true);
+	vpu_fmt = hantro_get_default_fmt(ctx, true, HANTRO_DEFAULT_BIT_DEPTH);
 	if (!vpu_fmt)
 		return;
 
@@ -393,15 +390,16 @@ hantro_reset_encoded_fmt(struct hantro_ctx *ctx)
 		hantro_set_fmt_out(ctx, &fmt);
 }
 
-static void
-hantro_reset_raw_fmt(struct hantro_ctx *ctx)
+int
+hantro_reset_raw_fmt(struct hantro_ctx *ctx, int bit_depth)
 {
 	const struct hantro_fmt *raw_vpu_fmt;
 	struct v4l2_pix_format_mplane raw_fmt, *encoded_fmt;
+	int ret;
 
-	raw_vpu_fmt = hantro_get_default_fmt(ctx, false);
+	raw_vpu_fmt = hantro_get_default_fmt(ctx, false, bit_depth);
 	if (!raw_vpu_fmt)
-		return;
+		return -EINVAL;
 
 	if (ctx->is_encoder)
 		encoded_fmt = &ctx->dst_fmt;
@@ -412,15 +410,20 @@ hantro_reset_raw_fmt(struct hantro_ctx *ctx)
 	raw_fmt.width = encoded_fmt->width;
 	raw_fmt.height = encoded_fmt->height;
 	if (ctx->is_encoder)
-		hantro_set_fmt_out(ctx, &raw_fmt);
+		ret = hantro_set_fmt_out(ctx, &raw_fmt);
 	else
-		hantro_set_fmt_cap(ctx, &raw_fmt);
+		ret = hantro_set_fmt_cap(ctx, &raw_fmt);
+
+	if (!ret)
+		ctx->bit_depth = bit_depth;
+
+	return ret;
 }
 
 void hantro_reset_fmts(struct hantro_ctx *ctx)
 {
 	hantro_reset_encoded_fmt(ctx);
-	hantro_reset_raw_fmt(ctx);
+	hantro_reset_raw_fmt(ctx, HANTRO_DEFAULT_BIT_DEPTH);
 }
 
 static void
@@ -520,7 +523,7 @@ static int hantro_set_fmt_out(struct hantro_ctx *ctx,
 	 * changes to the raw format.
 	 */
 	if (!ctx->is_encoder)
-		hantro_reset_raw_fmt(ctx);
+		hantro_reset_raw_fmt(ctx, hantro_get_format_depth(pix_mp->pixelformat));
 
 	/* Colorimetry information are always propagated. */
 	ctx->dst_fmt.colorspace = pix_mp->colorspace;
@@ -583,7 +586,7 @@ static int hantro_set_fmt_cap(struct hantro_ctx *ctx,
 	 * changes to the raw format.
 	 */
 	if (ctx->is_encoder)
-		hantro_reset_raw_fmt(ctx);
+		hantro_reset_raw_fmt(ctx, HANTRO_DEFAULT_BIT_DEPTH);
 
 	/* Colorimetry information are always propagated. */
 	ctx->src_fmt.colorspace = pix_mp->colorspace;
diff --git a/drivers/media/platform/verisilicon/hantro_v4l2.h b/drivers/media/platform/verisilicon/hantro_v4l2.h
index 64f6f57e9d7a..9ea2fef57dcd 100644
--- a/drivers/media/platform/verisilicon/hantro_v4l2.h
+++ b/drivers/media/platform/verisilicon/hantro_v4l2.h
@@ -21,9 +21,10 @@
 extern const struct v4l2_ioctl_ops hantro_ioctl_ops;
 extern const struct vb2_ops hantro_queue_ops;
 
+int hantro_reset_raw_fmt(struct hantro_ctx *ctx, int bit_depth);
 void hantro_reset_fmts(struct hantro_ctx *ctx);
 int hantro_get_format_depth(u32 fourcc);
 const struct hantro_fmt *
-hantro_get_default_fmt(const struct hantro_ctx *ctx, bool bitstream);
+hantro_get_default_fmt(const struct hantro_ctx *ctx, bool bitstream, int bit_depth);
 
 #endif /* HANTRO_V4L2_H_ */
-- 
2.34.1

