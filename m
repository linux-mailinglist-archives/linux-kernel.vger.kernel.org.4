Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 205946672BF
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 13:57:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232746AbjALM5r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 07:57:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231934AbjALM5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 07:57:00 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF9C638BC;
        Thu, 12 Jan 2023 04:56:58 -0800 (PST)
Received: from localhost (89-26-75-29.goll.dyn.salzburg-online.at [89.26.75.29])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sebastianfricke)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7A1636602DBA;
        Thu, 12 Jan 2023 12:56:57 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1673528217;
        bh=19U+A00eX7GomcVZ4hwuwzX1XI4Jf/K9mYqNNP1Mc6c=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=d7S8hzbl9CZf9tINvxTrwAjOPyZGpYeDkOqtO15LV6A+mhlACIc8cO4x/l0QhLMDV
         RKtUTsC7nqNRAguPa6HrSTppiAP+1MA8FDk9ZHJ6IeS3YiPDk9+Z0RHqgXca364iyY
         kPl9M+S+OxTFPmU58ZejKKYo/UXx+XjYE7gInFp8dzFpr6PjgyppTspRMHeBo6B0vR
         wGh0SrbnkraovnN/1QBadr3FDZT4PVFJePnsNXM/Ey47S0Kgc8cBk0q4HU3KAmJ+AT
         CSQoFV/3kRVQDouTMqx+p/j/egX/DTbgfWmQixUEaho3i+DQosC1e3d9d3RjYAvhRy
         txFyOGKwsixbA==
From:   Sebastian Fricke <sebastian.fricke@collabora.com>
Date:   Thu, 12 Jan 2023 13:56:24 +0100
Subject: [PATCH v2 09/12] staging: media: rkvdec: h264: Add callbacks for h264
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230101-patch-series-v2-6-2-rc1-v2-9-fa1897efac14@collabora.com>
References: <20230101-patch-series-v2-6-2-rc1-v2-0-fa1897efac14@collabora.com>
In-Reply-To: <20230101-patch-series-v2-6-2-rc1-v2-0-fa1897efac14@collabora.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        Jonas Karlman <jonas@kwiboo.se>,
        Alex Bee <knaerzche@gmail.com>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Collabora Kernel-domain <kernel@collabora.com>,
        Robert Beckett <bob.beckett@collabora.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Sebastian Fricke <sebastian.fricke@collabora.com>
X-Mailer: b4 0.11.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1673528186; l=5576;
 i=sebastian.fricke@collabora.com; s=linux-media; h=from:subject:message-id;
 bh=19U+A00eX7GomcVZ4hwuwzX1XI4Jf/K9mYqNNP1Mc6c=;
 b=q/7dHZEZC7Om5sfZ593nhkIVNVGwUmKnKRnaq5y/97IVmaJeS8raTGDHwcL5TyDW1rqoym9zCAKB
 cUypHMjIB7YqWAGX5s3xun+/JDEUBTd5vaUDxzWqeURvM7C16Agw
X-Developer-Key: i=sebastian.fricke@collabora.com; a=ed25519;
 pk=pYXedPwrTtErcj7ERYeo/IpTrpe4QbJuEzSB52fslBg=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement the valid format and sps validation callbacks for H264.
H264 already has a SPS validation function, adjust it to fit the
function the declaration and add error messages.
Additionally, add a function to fetch attributes from the SPS in a human
readable format to make the code more self documenting.

Signed-off-by: Sebastian Fricke <sebastian.fricke@collabora.com>
---
 drivers/staging/media/rkvdec/rkvdec-h264.c | 105 ++++++++++++++++++++++-------
 1 file changed, 80 insertions(+), 25 deletions(-)

diff --git a/drivers/staging/media/rkvdec/rkvdec-h264.c b/drivers/staging/media/rkvdec/rkvdec-h264.c
index 4fc167b42cf0..17b215874ddd 100644
--- a/drivers/staging/media/rkvdec/rkvdec-h264.c
+++ b/drivers/staging/media/rkvdec/rkvdec-h264.c
@@ -1026,40 +1026,80 @@ static int rkvdec_h264_adjust_fmt(struct rkvdec_ctx *ctx,
 	return 0;
 }
 
-static int rkvdec_h264_validate_sps(struct rkvdec_ctx *ctx,
-				    const struct v4l2_ctrl_h264_sps *sps)
+/*
+ * Convert some fields from the SPS structure into human readable attributes.
+ */
+static int rkvdec_h264_get_sps_attributes(struct rkvdec_ctx *ctx, void *sps,
+					  struct sps_attributes *attributes)
+{
+	struct v4l2_ctrl_h264_sps *h264_sps = sps;
+	unsigned int width = (h264_sps->pic_width_in_mbs_minus1 + 1) * 16;
+	unsigned int height = (h264_sps->pic_height_in_map_units_minus1 + 1) * 16;
+	/*
+	 * When frame_mbs_only_flag is not set, this is field height,
+	 * which is half the final height (see (7-18) in the
+	 * specification)
+	 */
+	if (!(h264_sps->flags & V4L2_H264_SPS_FLAG_FRAME_MBS_ONLY))
+		height *= 2;
+
+	attributes->width = width;
+	attributes->height = height;
+	attributes->luma_bitdepth = h264_sps->bit_depth_luma_minus8 + 8;
+	attributes->chroma_bitdepth = h264_sps->bit_depth_chroma_minus8 + 8;
+	switch (h264_sps->chroma_format_idc) {
+	case 0:
+		attributes->subsampling = 400;
+		break;
+	case 1:
+		attributes->subsampling = 420;
+		break;
+	case 2:
+		attributes->subsampling = 422;
+		break;
+	case 3:
+		attributes->subsampling = 444;
+		break;
+	};
+	return 0;
+}
+
+static int rkvdec_h264_validate_sps(struct rkvdec_ctx *ctx, void *sps,
+				    struct v4l2_pix_format_mplane *pix_mp)
 {
-	unsigned int width, height;
+	struct sps_attributes attributes = {0};
+
+	rkvdec_h264_get_sps_attributes(ctx, sps, &attributes);
 
 	/*
 	 * TODO: The hardware supports 10-bit and 4:2:2 profiles,
 	 * but it's currently broken in the driver.
 	 * Reject them for now, until it's fixed.
 	 */
-	if (sps->chroma_format_idc > 1)
-		/* Only 4:0:0 and 4:2:0 are supported */
+	if (attributes.subsampling > 420) {
+		dev_err(ctx->dev->dev,
+			"Only 4:0:0 and 4:2:0 subsampling schemes are supported, got: %d\n",
+			attributes.subsampling);
 		return -EINVAL;
-	if (sps->bit_depth_luma_minus8 != sps->bit_depth_chroma_minus8)
-		/* Luma and chroma bit depth mismatch */
+	}
+	if (attributes.luma_bitdepth != attributes.chroma_bitdepth) {
+		dev_err(ctx->dev->dev,
+			"Luma and chroma bit depth mismatch, luma %d, chroma %d\n",
+			attributes.luma_bitdepth, attributes.chroma_bitdepth);
 		return -EINVAL;
-	if (sps->bit_depth_luma_minus8 != 0)
-		/* Only 8-bit is supported */
+	}
+	if (attributes.luma_bitdepth != 8) {
+		dev_err(ctx->dev->dev, "Only 8-bit H264 formats supported, SPS %d\n",
+			attributes.luma_bitdepth);
 		return -EINVAL;
+	}
 
-	width = (sps->pic_width_in_mbs_minus1 + 1) * 16;
-	height = (sps->pic_height_in_map_units_minus1 + 1) * 16;
-
-	/*
-	 * When frame_mbs_only_flag is not set, this is field height,
-	 * which is half the final height (see (7-18) in the
-	 * specification)
-	 */
-	if (!(sps->flags & V4L2_H264_SPS_FLAG_FRAME_MBS_ONLY))
-		height *= 2;
-
-	if (width > ctx->coded_fmt.fmt.pix_mp.width ||
-	    height > ctx->coded_fmt.fmt.pix_mp.height)
+	if (attributes.width > pix_mp->width || attributes.height > pix_mp->height) {
+		dev_err(ctx->dev->dev,
+			"Incompatible SPS dimension, SPS %dx%d, Pixel format %dx%d.",
+			attributes.width, attributes.height, pix_mp->width, pix_mp->height);
 		return -EINVAL;
+	}
 
 	return 0;
 }
@@ -1077,8 +1117,9 @@ static int rkvdec_h264_start(struct rkvdec_ctx *ctx)
 	if (!ctrl)
 		return -EINVAL;
 
-	ret = rkvdec_h264_validate_sps(ctx, ctrl->p_new.p_h264_sps);
-	if (ret)
+	ret = rkvdec_h264_validate_sps(ctx, ctrl->p_new.p_h264_sps,
+				       &ctx->coded_fmt.fmt.pix_mp);
+	if (ret < 0)
 		return ret;
 
 	h264_ctx = kzalloc(sizeof(*h264_ctx), GFP_KERNEL);
@@ -1175,10 +1216,21 @@ static int rkvdec_h264_run(struct rkvdec_ctx *ctx)
 	return 0;
 }
 
+static u32 rkvdec_h264_valid_fmt(struct rkvdec_ctx *ctx)
+{
+	/*
+	 * Only 8 bit 4:0:0 and 4:2:0 formats supported for now.
+	 * The SPS is validated at a different function thus we can assume that
+	 * it is correct.
+	 */
+	return V4L2_PIX_FMT_NV12;
+}
+
 static int rkvdec_h264_try_ctrl(struct rkvdec_ctx *ctx, struct v4l2_ctrl *ctrl)
 {
 	if (ctrl->id == V4L2_CID_STATELESS_H264_SPS)
-		return rkvdec_h264_validate_sps(ctx, ctrl->p_new.p_h264_sps);
+		return rkvdec_h264_validate_sps(ctx, ctrl->p_new.p_h264_sps,
+						&ctx->coded_fmt.fmt.pix_mp);
 
 	return 0;
 }
@@ -1189,4 +1241,7 @@ const struct rkvdec_coded_fmt_ops rkvdec_h264_fmt_ops = {
 	.stop = rkvdec_h264_stop,
 	.run = rkvdec_h264_run,
 	.try_ctrl = rkvdec_h264_try_ctrl,
+	.valid_fmt = rkvdec_h264_valid_fmt,
+	.sps_check = rkvdec_h264_validate_sps,
+	.get_sps_attributes = rkvdec_h264_get_sps_attributes,
 };

-- 
2.25.1
