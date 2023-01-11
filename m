Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF8BD666135
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 18:01:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234544AbjAKRAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 12:00:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233100AbjAKQ7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 11:59:50 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41558140F9;
        Wed, 11 Jan 2023 08:59:47 -0800 (PST)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:1ee3:efce:e4f6:17a3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id BAFCB6602DA4;
        Wed, 11 Jan 2023 16:59:45 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1673456386;
        bh=sB0B5hMmBlGyvoV5FP5UJ3qSGt/YAjWMOgO6CSVwApk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CaFBvxd7Jdz3MTr/xQ2E2zcTQrHcdQPZgwXFyrMxWXtA5T+wXz82spe/Q/g8vfFnm
         sh48qyGdbEUn+nDLCX/go4qyfe/SgAJcfzT+aKro2mmbgmEenrrmps+VLicMib+o1D
         n9uYQlpXF7E83qmFrtG5Y8Y8goQ9mGnt9J3I4S5Vdvlmcb0BkkXlAaejSdhoNjmxt4
         lrNRbSBC+K0bnGyIOdC4Y926Jz+yybA6TirK2d/E1jjBUaJ9HFsO0UaL5SS6bkASJr
         +KjMQhO4AKoR/QW4yGmi9OzK0BB3GS9MgHPeQpB6h0ppueskmzSNBMuttpPgH2d87o
         Io9uYxRvI3+8Q==
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
To:     ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        mchehab@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, heiko@sntech.de,
        daniel.almeida@collabora.com, nicolas.dufresne@collabora.co.uk
Cc:     linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH v3 13/13] media: verisilicon: Conditionnaly ignore native formats
Date:   Wed, 11 Jan 2023 17:59:31 +0100
Message-Id: <20230111165931.753763-14-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230111165931.753763-1-benjamin.gaignard@collabora.com>
References: <20230111165931.753763-1-benjamin.gaignard@collabora.com>
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
Additionally if when setting a control a value could change capture
queue pixels formats it is needed to call hantro_reset_raw_fmt().

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
v3:
- Reset raw pixel formats list when bit depth or film grain feature
  values change.

 drivers/media/platform/verisilicon/hantro.h      |  3 +++
 drivers/media/platform/verisilicon/hantro_drv.c  | 11 ++++++++++-
 .../media/platform/verisilicon/hantro_postproc.c |  4 ++++
 drivers/media/platform/verisilicon/hantro_v4l2.c | 16 +++++++++++++++-
 drivers/media/platform/verisilicon/hantro_v4l2.h |  1 +
 5 files changed, 33 insertions(+), 2 deletions(-)

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
index 4fc6dea16ae6..ef99f0f0fc53 100644
--- a/drivers/media/platform/verisilicon/hantro_drv.c
+++ b/drivers/media/platform/verisilicon/hantro_drv.c
@@ -340,12 +340,21 @@ static int hantro_av1_s_ctrl(struct v4l2_ctrl *ctrl)
 	switch (ctrl->id) {
 	case V4L2_CID_STATELESS_AV1_SEQUENCE:
 		int bit_depth = ctrl->p_new.p_av1_sequence->bit_depth;
+		bool need_postproc = false;
 
 		if (vb2_is_streaming(v4l2_m2m_get_src_vq(ctx->fh.m2m_ctx)))
 			if (ctx->bit_depth != bit_depth)
 				return -EINVAL;
 
-		ctx->bit_depth = bit_depth;
+		if (ctrl->p_new.p_av1_sequence->flags
+		    & V4L2_AV1_SEQUENCE_FLAG_FILM_GRAIN_PARAMS_PRESENT)
+			need_postproc = true;
+
+		if (ctx->bit_depth != bit_depth || ctx->need_postproc != need_postproc) {
+			ctx->bit_depth = bit_depth;
+			ctx->need_postproc = need_postproc;
+			hantro_reset_raw_fmt(ctx);
+		}
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
index bbe79dbd2cd9..7566fe86f624 100644
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
 
@@ -404,7 +418,7 @@ hantro_reset_encoded_fmt(struct hantro_ctx *ctx)
 		hantro_set_fmt_out(ctx, fmt);
 }
 
-static void
+void
 hantro_reset_raw_fmt(struct hantro_ctx *ctx)
 {
 	const struct hantro_fmt *raw_vpu_fmt;
diff --git a/drivers/media/platform/verisilicon/hantro_v4l2.h b/drivers/media/platform/verisilicon/hantro_v4l2.h
index 64f6f57e9d7a..f642560aed93 100644
--- a/drivers/media/platform/verisilicon/hantro_v4l2.h
+++ b/drivers/media/platform/verisilicon/hantro_v4l2.h
@@ -21,6 +21,7 @@
 extern const struct v4l2_ioctl_ops hantro_ioctl_ops;
 extern const struct vb2_ops hantro_queue_ops;
 
+void hantro_reset_raw_fmt(struct hantro_ctx *ctx);
 void hantro_reset_fmts(struct hantro_ctx *ctx);
 int hantro_get_format_depth(u32 fourcc);
 const struct hantro_fmt *
-- 
2.34.1

