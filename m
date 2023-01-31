Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBC1A682D41
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 14:04:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231928AbjAaNEA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 08:04:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231706AbjAaNDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 08:03:48 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 502FFC660;
        Tue, 31 Jan 2023 05:03:47 -0800 (PST)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:d507:461a:a036:bf89])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 659926602F21;
        Tue, 31 Jan 2023 13:03:44 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1675170224;
        bh=2u7fYNspq4vzaXs20IC2PfPMx0Y7wxGqqAi7GFh5rb8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TVi0DKWN+e6robHpeRsNMOV9qA0For7LI7lGpnHIxkS3Xo/TM2sCOrrIDEaMWd+LH
         XIEm7EVsko8vA6ZycMESIyn8I65XfGN760QZ6fBjDmmwFL9Wk+Pt4RmcGzIHtYBzH0
         AURtbstu4ImAVNcYaY5Fjk1LX3cr3H11tuc7pKl7OCBitLbu7AIziQhUkyXaEq86F9
         QlZFnxLH6lHS8ncAQY+7fRNzhMLDpRMZ57BNedbXnUCBZHDxWAHcUrD2S0mnE8IRw4
         tza7r2t7YpE5J35+wzkpAaLdKQVJGGzf63VGShB0oVNkK27g54m1NSXBO5okudN1oA
         5ayfdKUO5hpfA==
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
To:     ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        mchehab@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        hverkuil-cisco@xs4all.nl, nicolas.dufresne@collabora.co.uk
Cc:     linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>
Subject: [PATCH v7 5/5] media: verisilicon: HEVC: Only propose 10 bits compatible pixels formats
Date:   Tue, 31 Jan 2023 14:03:27 +0100
Message-Id: <20230131130327.776899-6-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230131130327.776899-1-benjamin.gaignard@collabora.com>
References: <20230131130327.776899-1-benjamin.gaignard@collabora.com>
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

When decoding a 10bits bitstreams HEVC driver should only expose
10bits pixel formats.
To fulfill this requirement it is needed to call hantro_reset_raw_fmt()
when bit depth change and to correctly set match_depth in pixel formats
enumeration.

Fixes: dc39473d0340 ("media: hantro: imx8m: Enable 10bit decoding")

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
---
 .../media/platform/verisilicon/hantro_drv.c   | 11 ++++++++--
 .../media/platform/verisilicon/hantro_v4l2.c  | 22 ++++++++++---------
 .../media/platform/verisilicon/imx8m_vpu_hw.c |  2 ++
 3 files changed, 23 insertions(+), 12 deletions(-)

diff --git a/drivers/media/platform/verisilicon/hantro_drv.c b/drivers/media/platform/verisilicon/hantro_drv.c
index 6d8bc55ea627..fa31b200b097 100644
--- a/drivers/media/platform/verisilicon/hantro_drv.c
+++ b/drivers/media/platform/verisilicon/hantro_drv.c
@@ -326,8 +326,15 @@ static int hantro_hevc_s_ctrl(struct v4l2_ctrl *ctrl)
 
 	switch (ctrl->id) {
 	case V4L2_CID_STATELESS_HEVC_SPS:
-		ctx->bit_depth = ctrl->p_new.p_hevc_sps->bit_depth_luma_minus8 + 8;
-		break;
+	{
+		const struct v4l2_ctrl_hevc_sps *sps = ctrl->p_new.p_hevc_sps;
+		int bit_depth = sps->bit_depth_luma_minus8 + 8;
+
+		if (ctx->bit_depth == bit_depth)
+			return 0;
+
+		return hantro_reset_raw_fmt(ctx, bit_depth);
+	}
 	default:
 		return -EINVAL;
 	}
diff --git a/drivers/media/platform/verisilicon/hantro_v4l2.c b/drivers/media/platform/verisilicon/hantro_v4l2.c
index 6c5f4351b257..7c9a04171b45 100644
--- a/drivers/media/platform/verisilicon/hantro_v4l2.c
+++ b/drivers/media/platform/verisilicon/hantro_v4l2.c
@@ -28,7 +28,7 @@
 #include "hantro_hw.h"
 #include "hantro_v4l2.h"
 
-#define  HANTRO_DEFAULT_BIT_DEPTH 0
+#define  HANTRO_DEFAULT_BIT_DEPTH 8
 
 static int hantro_set_fmt_out(struct hantro_ctx *ctx,
 			      struct v4l2_pix_format_mplane *pix_mp);
@@ -80,15 +80,11 @@ int hantro_get_format_depth(u32 fourcc)
 static bool
 hantro_check_depth_match(const struct hantro_fmt *fmt, int bit_depth)
 {
-	int fmt_depth, depth = 8;
+	int fmt_depth;
 
 	if (!fmt->match_depth && !fmt->postprocessed)
 		return true;
 
-	/* 0 means default depth, which is 8 */
-	if (bit_depth)
-		depth = bit_depth;
-
 	fmt_depth = hantro_get_format_depth(fmt->fourcc);
 
 	/*
@@ -96,9 +92,9 @@ hantro_check_depth_match(const struct hantro_fmt *fmt, int bit_depth)
 	 * It may be possible to relax that on some HW.
 	 */
 	if (!fmt->match_depth)
-		return fmt_depth <= depth;
+		return fmt_depth <= bit_depth;
 
-	return fmt_depth == depth;
+	return fmt_depth == bit_depth;
 }
 
 static const struct hantro_fmt *
@@ -398,6 +394,7 @@ hantro_reset_raw_fmt(struct hantro_ctx *ctx, int bit_depth)
 {
 	const struct hantro_fmt *raw_vpu_fmt;
 	struct v4l2_pix_format_mplane raw_fmt, *encoded_fmt;
+	int ret;
 
 	raw_vpu_fmt = hantro_get_default_fmt(ctx, false, bit_depth);
 	if (!raw_vpu_fmt)
@@ -412,9 +409,14 @@ hantro_reset_raw_fmt(struct hantro_ctx *ctx, int bit_depth)
 	raw_fmt.width = encoded_fmt->width;
 	raw_fmt.height = encoded_fmt->height;
 	if (ctx->is_encoder)
-		return hantro_set_fmt_out(ctx, &raw_fmt);
+		ret = hantro_set_fmt_out(ctx, &raw_fmt);
 	else
-		return hantro_set_fmt_cap(ctx, &raw_fmt);
+		ret = hantro_set_fmt_cap(ctx, &raw_fmt);
+
+	if (!ret)
+		ctx->bit_depth = bit_depth;
+
+	return ret;
 }
 
 void hantro_reset_fmts(struct hantro_ctx *ctx)
diff --git a/drivers/media/platform/verisilicon/imx8m_vpu_hw.c b/drivers/media/platform/verisilicon/imx8m_vpu_hw.c
index b390228fd3b4..f850d8bddef6 100644
--- a/drivers/media/platform/verisilicon/imx8m_vpu_hw.c
+++ b/drivers/media/platform/verisilicon/imx8m_vpu_hw.c
@@ -152,6 +152,7 @@ static const struct hantro_fmt imx8m_vpu_g2_postproc_fmts[] = {
 	{
 		.fourcc = V4L2_PIX_FMT_NV12,
 		.codec_mode = HANTRO_MODE_NONE,
+		.match_depth = true,
 		.postprocessed = true,
 		.frmsize = {
 			.min_width = FMT_MIN_WIDTH,
@@ -165,6 +166,7 @@ static const struct hantro_fmt imx8m_vpu_g2_postproc_fmts[] = {
 	{
 		.fourcc = V4L2_PIX_FMT_P010,
 		.codec_mode = HANTRO_MODE_NONE,
+		.match_depth = true,
 		.postprocessed = true,
 		.frmsize = {
 			.min_width = FMT_MIN_WIDTH,
-- 
2.34.1

