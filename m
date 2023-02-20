Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4624169C8F0
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 11:49:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231713AbjBTKtP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 05:49:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231676AbjBTKtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 05:49:02 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A3E7AD0D;
        Mon, 20 Feb 2023 02:49:01 -0800 (PST)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:d30c:b155:96fb:dcc])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B5CEE6602142;
        Mon, 20 Feb 2023 10:48:59 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676890140;
        bh=SxFS3sgxVfXOtyOQNwLjMDuu7K/g1eyIum+Nn/+YN6I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z8il/20VIKq6sJsWP5TMNUgVLnXgtrZetPbZoe0LpXmDIBGOuXk1dVfgwHrQ5JvhX
         p01Uk7bpBhcy4RWEwXoCYGJjsuKG8IYVBpbAuBhCoFHQAtMWE1HRxDhA5DJHmpzwdt
         YgmzvCnPEWUWPYWhDx8PB+8ZsL/IlUJPfe1Od8z5t7Z95pknu1MdvTa8lP2Kqmnjee
         pYt1FnRgo8ZV9WR5hDROXpTs0LQ6FwVuj09Q95sEnTJuZyGgxZ9fMFA+9orZBCv0Xi
         +3tnSn1QAzhUalkmPbpaxIRuWe3Rwu/GJFJMIQL0GtjHcFUtKn5290gvgENv5uXufX
         a+pJSqGVKt1Gg==
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
Subject: [PATCH v9 5/6] media: verisilicon: HEVC: Only propose 10 bits compatible pixels formats
Date:   Mon, 20 Feb 2023 11:48:48 +0100
Message-Id: <20230220104849.398203-6-benjamin.gaignard@collabora.com>
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

When decoding a 10bits bitstreams HEVC driver should only expose
10bits pixel formats.
To fulfill this requirement it is needed to call hantro_reset_raw_fmt()
when bit depth change and to correctly set match_depth in pixel formats
enumeration.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
---
version 9:
- Fix brackets

 drivers/media/platform/verisilicon/hantro_drv.c   | 12 +++++++++---
 drivers/media/platform/verisilicon/imx8m_vpu_hw.c |  2 ++
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/verisilicon/hantro_drv.c b/drivers/media/platform/verisilicon/hantro_drv.c
index c237253803f4..7d452f1afaae 100644
--- a/drivers/media/platform/verisilicon/hantro_drv.c
+++ b/drivers/media/platform/verisilicon/hantro_drv.c
@@ -325,9 +325,15 @@ static int hantro_hevc_s_ctrl(struct v4l2_ctrl *ctrl)
 			   struct hantro_ctx, ctrl_handler);
 
 	switch (ctrl->id) {
-	case V4L2_CID_STATELESS_HEVC_SPS:
-		ctx->bit_depth = ctrl->p_new.p_hevc_sps->bit_depth_luma_minus8 + 8;
-		break;
+	case V4L2_CID_STATELESS_HEVC_SPS: {
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

