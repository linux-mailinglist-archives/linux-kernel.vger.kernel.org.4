Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5488468100A
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 14:59:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236938AbjA3N7I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 08:59:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236800AbjA3N65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 08:58:57 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EE4B36FEA;
        Mon, 30 Jan 2023 05:58:37 -0800 (PST)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:e655:2335:9172:6e39])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 996E96602F10;
        Mon, 30 Jan 2023 13:58:13 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1675087094;
        bh=R5a/mEpnxaqGwC3EbPKXrQNBPFEzTc0n/5f90KTNBzU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UbeFUDJNjH+boCT1h8uJhzuLeqp2wTx96eCbu0JLaU1/SUDFSJmZWNun3sKp/eTq4
         Z9JlKRyaD57WcD78uF34AkuL4sOnpO5Z3MVZlamrTDr3tmzPTyw1YWl+KIXuCgTAI6
         7lb3WaYZMzVrkEqbZnpujWMWiVShNEVwqWfIJrQiEqXE97N6tfcj43R564dC3ItQcx
         zmy2wZlIUVs8qj+36vV8mwiqHQsXgvKW60WolHykjBDgCSiOPQDdciKy+YeU2pzgMn
         6GkT3nEOV3N1sa53CZ1kdGaYOR+kP0PBQDNN6853mzqZbgKcxeOgP7l8+EIpYjtX4E
         PszSStAJgWSZg==
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
Subject: [PATCH v6 5/5] media: verisilicon: HEVC: Only propose 10 bitscompatible pixels formats
Date:   Mon, 30 Jan 2023 14:58:02 +0100
Message-Id: <20230130135802.744743-6-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230130135802.744743-1-benjamin.gaignard@collabora.com>
References: <20230130135802.744743-1-benjamin.gaignard@collabora.com>
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
 drivers/media/platform/verisilicon/hantro_drv.c  | 16 ++++++++++++++--
 .../media/platform/verisilicon/imx8m_vpu_hw.c    |  2 ++
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/verisilicon/hantro_drv.c b/drivers/media/platform/verisilicon/hantro_drv.c
index 715075f15596..e3656649c717 100644
--- a/drivers/media/platform/verisilicon/hantro_drv.c
+++ b/drivers/media/platform/verisilicon/hantro_drv.c
@@ -331,8 +331,20 @@ static int hantro_hevc_s_ctrl(struct v4l2_ctrl *ctrl)
 
 	switch (ctrl->id) {
 	case V4L2_CID_STATELESS_HEVC_SPS:
-		ctx->bit_depth = ctrl->p_new.p_hevc_sps->bit_depth_luma_minus8 + 8;
-		break;
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

