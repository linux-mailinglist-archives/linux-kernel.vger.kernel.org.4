Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3248267DFEC
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 10:21:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232742AbjA0JVl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 04:21:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232163AbjA0JVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 04:21:36 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 970D59EFB;
        Fri, 27 Jan 2023 01:21:35 -0800 (PST)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:4623:efe7:8a8:33c2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id EBB536602EA1;
        Fri, 27 Jan 2023 09:21:33 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1674811294;
        bh=7Fa9dzvTgBivHIPI4iHsytCfPy7D6F7WBpQuVBtYwF8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YWw6QuA4FDh22bhiEkZZUUBAskmKEsnvyu6ddHe9fd8TIV7CicdTkZ74WwJwjIxQh
         qQsl+9uhurLo58HpxZc7yjGO1j53x4onDuSM6Ax9/sDM1r7SBDnA6uIaUhCrD4lmiZ
         kooH7vIEZa/zGTCylqBDYQps+hT8oOnepCZ97Kxhq6eFLzmRcM7zYTXM4CbbyVodnr
         ZKtZ1uUBFCmH+3J7pXnUFT8f2xKEtyeIosw3hTDLZWL93yvtnmggpYniMB/bFC4MQK
         BFZfKzsks+w9HN3VbFWm9s3zz0SxcEcycI3MLYhrNUHAKfula1LyaMm5k59wdJRCgZ
         MZ7l+Ll3Kwtzw==
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
Subject: [PATCH v5 2/2] media: verisilicon: HEVC: Only propose 10 bits compatible pixels formats
Date:   Fri, 27 Jan 2023 10:21:26 +0100
Message-Id: <20230127092126.318268-3-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230127092126.318268-1-benjamin.gaignard@collabora.com>
References: <20230127092126.318268-1-benjamin.gaignard@collabora.com>
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
version 5:
- Add Review and Fixes tags

 .../media/platform/verisilicon/hantro_drv.c   | 44 +++++++++++++++----
 .../media/platform/verisilicon/imx8m_vpu_hw.c |  2 +
 2 files changed, 38 insertions(+), 8 deletions(-)

diff --git a/drivers/media/platform/verisilicon/hantro_drv.c b/drivers/media/platform/verisilicon/hantro_drv.c
index 8cb4a68c9119..a736050fef5a 100644
--- a/drivers/media/platform/verisilicon/hantro_drv.c
+++ b/drivers/media/platform/verisilicon/hantro_drv.c
@@ -251,11 +251,6 @@ queue_init(void *priv, struct vb2_queue *src_vq, struct vb2_queue *dst_vq)
 
 static int hantro_try_ctrl(struct v4l2_ctrl *ctrl)
 {
-	struct hantro_ctx *ctx;
-
-	ctx = container_of(ctrl->handler,
-			   struct hantro_ctx, ctrl_handler);
-
 	if (ctrl->id == V4L2_CID_STATELESS_H264_SPS) {
 		const struct v4l2_ctrl_h264_sps *sps = ctrl->p_new.p_h264_sps;
 
@@ -274,8 +269,6 @@ static int hantro_try_ctrl(struct v4l2_ctrl *ctrl)
 		if (sps->bit_depth_luma_minus8 != 0 && sps->bit_depth_luma_minus8 != 2)
 			/* Only 8-bit and 10-bit are supported */
 			return -EINVAL;
-
-		ctx->bit_depth = sps->bit_depth_luma_minus8 + 8;
 	} else if (ctrl->id == V4L2_CID_STATELESS_VP9_FRAME) {
 		const struct v4l2_ctrl_vp9_frame *dec_params = ctrl->p_new.p_vp9_frame;
 
@@ -286,6 +279,36 @@ static int hantro_try_ctrl(struct v4l2_ctrl *ctrl)
 	return 0;
 }
 
+static int hantro_hevc_s_ctrl(struct v4l2_ctrl *ctrl)
+{
+	struct hantro_ctx *ctx;
+
+	ctx = container_of(ctrl->handler,
+			   struct hantro_ctx, ctrl_handler);
+
+	switch (ctrl->id) {
+	case V4L2_CID_STATELESS_HEVC_SPS:
+	{
+		const struct v4l2_ctrl_hevc_sps *sps = ctrl->p_new.p_hevc_sps;
+		int bit_depth = sps->bit_depth_luma_minus8 + 8;
+		int ret;
+
+		if (ctx->bit_depth == bit_depth)
+			return 0;
+
+		ret = hantro_reset_raw_fmt(ctx, bit_depth);
+		if (!ret)
+			ctx->bit_depth = bit_depth;
+
+		return ret;
+	}
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int hantro_jpeg_s_ctrl(struct v4l2_ctrl *ctrl)
 {
 	struct hantro_ctx *ctx;
@@ -328,6 +351,11 @@ static const struct v4l2_ctrl_ops hantro_ctrl_ops = {
 	.try_ctrl = hantro_try_ctrl,
 };
 
+static const struct v4l2_ctrl_ops hantro_hevc_ctrl_ops = {
+	.s_ctrl = hantro_hevc_s_ctrl,
+	.try_ctrl = hantro_try_ctrl,
+};
+
 static const struct v4l2_ctrl_ops hantro_jpeg_ctrl_ops = {
 	.s_ctrl = hantro_jpeg_s_ctrl,
 };
@@ -470,7 +498,7 @@ static const struct hantro_ctrl controls[] = {
 		.codec = HANTRO_HEVC_DECODER,
 		.cfg = {
 			.id = V4L2_CID_STATELESS_HEVC_SPS,
-			.ops = &hantro_ctrl_ops,
+			.ops = &hantro_hevc_ctrl_ops,
 		},
 	}, {
 		.codec = HANTRO_HEVC_DECODER,
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

