Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FDCF68EAA7
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 10:10:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbjBHJKC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 04:10:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230491AbjBHJJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 04:09:18 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94F7745F52;
        Wed,  8 Feb 2023 01:09:11 -0800 (PST)
X-UUID: 386f220aa79011eda06fc9ecc4dadd91-20230208
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=BeJUPlhBux+yhj4mTNjaaj5e/B9n1mF/Q3YxP5GEG44=;
        b=mllwBd6gI3iExR/U9AAJKqQPjKSJWgV5ymIRAvqz3KLC5OIpEmk/IvNrU8QpJnD0ayae2HkeVkh8DaRF2axJthZfcQSlZwzBANLaJ6q0siv7hrwaZ9Gj9VjN3m1n8zwQvALEzxoGu/CPAja4h7bTXOhh1KUcmuAS+jR+ppj7bCs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.19,REQID:39476797-b155-4626-8fbd-ba07bd481cc7,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:885ddb2,CLOUDID:dc72aa56-dd49-462e-a4be-2143a3ddc739,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-UUID: 386f220aa79011eda06fc9ecc4dadd91-20230208
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
        (envelope-from <moudy.ho@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 280447534; Wed, 08 Feb 2023 17:08:58 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 8 Feb 2023 17:08:57 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Wed, 8 Feb 2023 17:08:57 +0800
From:   Moudy Ho <moudy.ho@mediatek.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Ping-Hsun Wu <ping-hsun.wu@mediatek.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Moudy Ho <moudy.ho@mediatek.com>
Subject: [PATCH v6 05/12] media: platform: mtk-mdp3: chip config split about color format
Date:   Wed, 8 Feb 2023 17:08:48 +0800
Message-ID: <20230208090855.18934-6-moudy.ho@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230208090855.18934-1-moudy.ho@mediatek.com>
References: <20230208090855.18934-1-moudy.ho@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to differences in hardware design, the supported color formats
will vary and should be integrated into specific config file.

Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
---
 .../platform/mediatek/mdp3/mdp_cfg_data.c     | 228 +++++++++++++++
 .../platform/mediatek/mdp3/mtk-mdp3-core.h    |   2 +
 .../platform/mediatek/mdp3/mtk-mdp3-m2m.c     |  10 +-
 .../platform/mediatek/mdp3/mtk-mdp3-regs.c    | 262 ++----------------
 .../platform/mediatek/mdp3/mtk-mdp3-regs.h    |   9 +-
 5 files changed, 262 insertions(+), 249 deletions(-)

diff --git a/drivers/media/platform/mediatek/mdp3/mdp_cfg_data.c b/drivers/media/platform/mediatek/mdp3/mdp_cfg_data.c
index 159f5ecb9c1b..92e45bd72705 100644
--- a/drivers/media/platform/mediatek/mdp3/mdp_cfg_data.c
+++ b/drivers/media/platform/mediatek/mdp3/mdp_cfg_data.c
@@ -7,6 +7,7 @@
 #include "mtk-mdp3-cfg.h"
 #include "mtk-mdp3-core.h"
 #include "mtk-mdp3-comp.h"
+#include "mtk-mdp3-regs.h"
 
 enum mt8183_mdp_comp_id {
 	/* ISP */
@@ -155,6 +156,231 @@ static const struct of_device_id mt8183_sub_comp_dt_ids[] = {
 	{}
 };
 
+/*
+ * All 10-bit related formats are not added in the basic format list,
+ * please add the corresponding format settings before use.
+ */
+static const struct mdp_format mt8183_formats[] = {
+	{
+		.pixelformat	= V4L2_PIX_FMT_GREY,
+		.mdp_color	= MDP_COLOR_GREY,
+		.depth		= { 8 },
+		.row_depth	= { 8 },
+		.num_planes	= 1,
+		.flags		= MDP_FMT_FLAG_OUTPUT | MDP_FMT_FLAG_CAPTURE,
+	}, {
+		.pixelformat	= V4L2_PIX_FMT_RGB565X,
+		.mdp_color	= MDP_COLOR_BGR565,
+		.depth		= { 16 },
+		.row_depth	= { 16 },
+		.num_planes	= 1,
+		.flags		= MDP_FMT_FLAG_OUTPUT | MDP_FMT_FLAG_CAPTURE,
+	}, {
+		.pixelformat	= V4L2_PIX_FMT_RGB565,
+		.mdp_color	= MDP_COLOR_RGB565,
+		.depth		= { 16 },
+		.row_depth	= { 16 },
+		.num_planes	= 1,
+		.flags		= MDP_FMT_FLAG_OUTPUT | MDP_FMT_FLAG_CAPTURE,
+	}, {
+		.pixelformat	= V4L2_PIX_FMT_RGB24,
+		.mdp_color	= MDP_COLOR_RGB888,
+		.depth		= { 24 },
+		.row_depth	= { 24 },
+		.num_planes	= 1,
+		.flags		= MDP_FMT_FLAG_OUTPUT | MDP_FMT_FLAG_CAPTURE,
+	}, {
+		.pixelformat	= V4L2_PIX_FMT_BGR24,
+		.mdp_color	= MDP_COLOR_BGR888,
+		.depth		= { 24 },
+		.row_depth	= { 24 },
+		.num_planes	= 1,
+		.flags		= MDP_FMT_FLAG_OUTPUT | MDP_FMT_FLAG_CAPTURE,
+	}, {
+		.pixelformat	= V4L2_PIX_FMT_ABGR32,
+		.mdp_color	= MDP_COLOR_BGRA8888,
+		.depth		= { 32 },
+		.row_depth	= { 32 },
+		.num_planes	= 1,
+		.flags		= MDP_FMT_FLAG_OUTPUT | MDP_FMT_FLAG_CAPTURE,
+	}, {
+		.pixelformat	= V4L2_PIX_FMT_ARGB32,
+		.mdp_color	= MDP_COLOR_ARGB8888,
+		.depth		= { 32 },
+		.row_depth	= { 32 },
+		.num_planes	= 1,
+		.flags		= MDP_FMT_FLAG_OUTPUT | MDP_FMT_FLAG_CAPTURE,
+	}, {
+		.pixelformat	= V4L2_PIX_FMT_UYVY,
+		.mdp_color	= MDP_COLOR_UYVY,
+		.depth		= { 16 },
+		.row_depth	= { 16 },
+		.num_planes	= 1,
+		.walign		= 1,
+		.flags		= MDP_FMT_FLAG_OUTPUT | MDP_FMT_FLAG_CAPTURE,
+	}, {
+		.pixelformat	= V4L2_PIX_FMT_VYUY,
+		.mdp_color	= MDP_COLOR_VYUY,
+		.depth		= { 16 },
+		.row_depth	= { 16 },
+		.num_planes	= 1,
+		.walign		= 1,
+		.flags		= MDP_FMT_FLAG_OUTPUT | MDP_FMT_FLAG_CAPTURE,
+	}, {
+		.pixelformat	= V4L2_PIX_FMT_YUYV,
+		.mdp_color	= MDP_COLOR_YUYV,
+		.depth		= { 16 },
+		.row_depth	= { 16 },
+		.num_planes	= 1,
+		.walign		= 1,
+		.flags		= MDP_FMT_FLAG_OUTPUT | MDP_FMT_FLAG_CAPTURE,
+	}, {
+		.pixelformat	= V4L2_PIX_FMT_YVYU,
+		.mdp_color	= MDP_COLOR_YVYU,
+		.depth		= { 16 },
+		.row_depth	= { 16 },
+		.num_planes	= 1,
+		.walign		= 1,
+		.flags		= MDP_FMT_FLAG_OUTPUT | MDP_FMT_FLAG_CAPTURE,
+	}, {
+		.pixelformat	= V4L2_PIX_FMT_YUV420,
+		.mdp_color	= MDP_COLOR_I420,
+		.depth		= { 12 },
+		.row_depth	= { 8 },
+		.num_planes	= 1,
+		.walign		= 1,
+		.halign		= 1,
+		.flags		= MDP_FMT_FLAG_OUTPUT | MDP_FMT_FLAG_CAPTURE,
+	}, {
+		.pixelformat	= V4L2_PIX_FMT_YVU420,
+		.mdp_color	= MDP_COLOR_YV12,
+		.depth		= { 12 },
+		.row_depth	= { 8 },
+		.num_planes	= 1,
+		.walign		= 1,
+		.halign		= 1,
+		.flags		= MDP_FMT_FLAG_OUTPUT | MDP_FMT_FLAG_CAPTURE,
+	}, {
+		.pixelformat	= V4L2_PIX_FMT_NV12,
+		.mdp_color	= MDP_COLOR_NV12,
+		.depth		= { 12 },
+		.row_depth	= { 8 },
+		.num_planes	= 1,
+		.walign		= 1,
+		.halign		= 1,
+		.flags		= MDP_FMT_FLAG_OUTPUT | MDP_FMT_FLAG_CAPTURE,
+	}, {
+		.pixelformat	= V4L2_PIX_FMT_NV21,
+		.mdp_color	= MDP_COLOR_NV21,
+		.depth		= { 12 },
+		.row_depth	= { 8 },
+		.num_planes	= 1,
+		.walign		= 1,
+		.halign		= 1,
+		.flags		= MDP_FMT_FLAG_OUTPUT | MDP_FMT_FLAG_CAPTURE,
+	}, {
+		.pixelformat	= V4L2_PIX_FMT_NV16,
+		.mdp_color	= MDP_COLOR_NV16,
+		.depth		= { 16 },
+		.row_depth	= { 8 },
+		.num_planes	= 1,
+		.walign		= 1,
+		.flags		= MDP_FMT_FLAG_OUTPUT,
+	}, {
+		.pixelformat	= V4L2_PIX_FMT_NV61,
+		.mdp_color	= MDP_COLOR_NV61,
+		.depth		= { 16 },
+		.row_depth	= { 8 },
+		.num_planes	= 1,
+		.walign		= 1,
+		.flags		= MDP_FMT_FLAG_OUTPUT,
+	}, {
+		.pixelformat	= V4L2_PIX_FMT_NV24,
+		.mdp_color	= MDP_COLOR_NV24,
+		.depth		= { 24 },
+		.row_depth	= { 8 },
+		.num_planes	= 1,
+		.flags		= MDP_FMT_FLAG_OUTPUT,
+	}, {
+		.pixelformat	= V4L2_PIX_FMT_NV42,
+		.mdp_color	= MDP_COLOR_NV42,
+		.depth		= { 24 },
+		.row_depth	= { 8 },
+		.num_planes	= 1,
+		.flags		= MDP_FMT_FLAG_OUTPUT,
+	}, {
+		.pixelformat	= V4L2_PIX_FMT_MT21C,
+		.mdp_color	= MDP_COLOR_420_BLK_UFO,
+		.depth		= { 8, 4 },
+		.row_depth	= { 8, 8 },
+		.num_planes	= 2,
+		.walign		= 4,
+		.halign		= 5,
+		.flags		= MDP_FMT_FLAG_OUTPUT,
+	}, {
+		.pixelformat	= V4L2_PIX_FMT_MM21,
+		.mdp_color	= MDP_COLOR_420_BLK,
+		.depth		= { 8, 4 },
+		.row_depth	= { 8, 8 },
+		.num_planes	= 2,
+		.walign		= 4,
+		.halign		= 5,
+		.flags		= MDP_FMT_FLAG_OUTPUT,
+	}, {
+		.pixelformat	= V4L2_PIX_FMT_NV12M,
+		.mdp_color	= MDP_COLOR_NV12,
+		.depth		= { 8, 4 },
+		.row_depth	= { 8, 8 },
+		.num_planes	= 2,
+		.walign		= 1,
+		.halign		= 1,
+		.flags		= MDP_FMT_FLAG_OUTPUT | MDP_FMT_FLAG_CAPTURE,
+	}, {
+		.pixelformat	= V4L2_PIX_FMT_NV21M,
+		.mdp_color	= MDP_COLOR_NV21,
+		.depth		= { 8, 4 },
+		.row_depth	= { 8, 8 },
+		.num_planes	= 2,
+		.walign		= 1,
+		.halign		= 1,
+		.flags		= MDP_FMT_FLAG_OUTPUT | MDP_FMT_FLAG_CAPTURE,
+	}, {
+		.pixelformat	= V4L2_PIX_FMT_NV16M,
+		.mdp_color	= MDP_COLOR_NV16,
+		.depth		= { 8, 8 },
+		.row_depth	= { 8, 8 },
+		.num_planes	= 2,
+		.walign		= 1,
+		.flags		= MDP_FMT_FLAG_OUTPUT,
+	}, {
+		.pixelformat	= V4L2_PIX_FMT_NV61M,
+		.mdp_color	= MDP_COLOR_NV61,
+		.depth		= { 8, 8 },
+		.row_depth	= { 8, 8 },
+		.num_planes	= 2,
+		.walign		= 1,
+		.flags		= MDP_FMT_FLAG_OUTPUT,
+	}, {
+		.pixelformat	= V4L2_PIX_FMT_YUV420M,
+		.mdp_color	= MDP_COLOR_I420,
+		.depth		= { 8, 2, 2 },
+		.row_depth	= { 8, 4, 4 },
+		.num_planes	= 3,
+		.walign		= 1,
+		.halign		= 1,
+		.flags		= MDP_FMT_FLAG_OUTPUT | MDP_FMT_FLAG_CAPTURE,
+	}, {
+		.pixelformat	= V4L2_PIX_FMT_YVU420M,
+		.mdp_color	= MDP_COLOR_YV12,
+		.depth		= { 8, 2, 2 },
+		.row_depth	= { 8, 4, 4 },
+		.num_planes	= 3,
+		.walign		= 1,
+		.halign		= 1,
+		.flags		= MDP_FMT_FLAG_OUTPUT | MDP_FMT_FLAG_CAPTURE,
+	}
+};
+
 const struct mtk_mdp_driver_data mt8183_mdp_driver_data = {
 	.mdp_probe_infra = mt8183_mdp_probe_infra,
 	.mdp_cfg = &mt8183_plat_cfg,
@@ -162,6 +388,8 @@ const struct mtk_mdp_driver_data mt8183_mdp_driver_data = {
 	.comp_data = mt8183_mdp_comp_data,
 	.comp_data_len = ARRAY_SIZE(mt8183_mdp_comp_data),
 	.mdp_sub_comp_dt_ids = mt8183_sub_comp_dt_ids,
+	.format = mt8183_formats,
+	.format_len = ARRAY_SIZE(mt8183_formats),
 };
 
 s32 mdp_cfg_get_id_inner(struct mdp_dev *mdp_dev, enum mtk_mdp_comp_id id)
diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.h b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.h
index 41eeba49fb42..327da00dd1fc 100644
--- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.h
+++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.h
@@ -57,6 +57,8 @@ struct mtk_mdp_driver_data {
 	const struct mdp_comp_data *comp_data;
 	unsigned int comp_data_len;
 	const struct of_device_id *mdp_sub_comp_dt_ids;
+	const struct mdp_format *format;
+	unsigned int format_len;
 };
 
 struct mdp_dev {
diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-m2m.c b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-m2m.c
index 5f74ea3b7a52..7c14679ffd78 100644
--- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-m2m.c
+++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-m2m.c
@@ -277,7 +277,9 @@ static int mdp_m2m_querycap(struct file *file, void *fh,
 static int mdp_m2m_enum_fmt_mplane(struct file *file, void *fh,
 				   struct v4l2_fmtdesc *f)
 {
-	return mdp_enum_fmt_mplane(f);
+	struct mdp_m2m_ctx *ctx = fh_to_ctx(fh);
+
+	return mdp_enum_fmt_mplane(ctx->mdp_dev, f);
 }
 
 static int mdp_m2m_g_fmt_mplane(struct file *file, void *fh,
@@ -307,7 +309,7 @@ static int mdp_m2m_s_fmt_mplane(struct file *file, void *fh,
 	const struct mdp_format *fmt;
 	struct vb2_queue *vq;
 
-	fmt = mdp_try_fmt_mplane(f, &ctx->curr_param, ctx->id);
+	fmt = mdp_try_fmt_mplane(ctx->mdp_dev, f, &ctx->curr_param, ctx->id);
 	if (!fmt)
 		return -EINVAL;
 
@@ -346,7 +348,7 @@ static int mdp_m2m_try_fmt_mplane(struct file *file, void *fh,
 {
 	struct mdp_m2m_ctx *ctx = fh_to_ctx(fh);
 
-	if (!mdp_try_fmt_mplane(f, &ctx->curr_param, ctx->id))
+	if (!mdp_try_fmt_mplane(ctx->mdp_dev, f, &ctx->curr_param, ctx->id))
 		return -EINVAL;
 
 	return 0;
@@ -589,7 +591,7 @@ static int mdp_m2m_open(struct file *file)
 	ctx->fh.m2m_ctx = ctx->m2m_ctx;
 
 	ctx->curr_param.ctx = ctx;
-	ret = mdp_frameparam_init(&ctx->curr_param);
+	ret = mdp_frameparam_init(mdp, &ctx->curr_param);
 	if (ret) {
 		dev_err(dev, "Failed to initialize mdp parameter\n");
 		goto err_release_m2m_ctx;
diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-regs.c b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-regs.c
index 36336d169bd9..c6fecb089687 100644
--- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-regs.c
+++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-regs.c
@@ -12,231 +12,6 @@
 #include "mtk-mdp3-regs.h"
 #include "mtk-mdp3-m2m.h"
 
-/*
- * All 10-bit related formats are not added in the basic format list,
- * please add the corresponding format settings before use.
- */
-static const struct mdp_format mdp_formats[] = {
-	{
-		.pixelformat	= V4L2_PIX_FMT_GREY,
-		.mdp_color	= MDP_COLOR_GREY,
-		.depth		= { 8 },
-		.row_depth	= { 8 },
-		.num_planes	= 1,
-		.flags		= MDP_FMT_FLAG_OUTPUT | MDP_FMT_FLAG_CAPTURE,
-	}, {
-		.pixelformat	= V4L2_PIX_FMT_RGB565X,
-		.mdp_color	= MDP_COLOR_BGR565,
-		.depth		= { 16 },
-		.row_depth	= { 16 },
-		.num_planes	= 1,
-		.flags		= MDP_FMT_FLAG_OUTPUT | MDP_FMT_FLAG_CAPTURE,
-	}, {
-		.pixelformat	= V4L2_PIX_FMT_RGB565,
-		.mdp_color	= MDP_COLOR_RGB565,
-		.depth		= { 16 },
-		.row_depth	= { 16 },
-		.num_planes	= 1,
-		.flags		= MDP_FMT_FLAG_OUTPUT | MDP_FMT_FLAG_CAPTURE,
-	}, {
-		.pixelformat	= V4L2_PIX_FMT_RGB24,
-		.mdp_color	= MDP_COLOR_RGB888,
-		.depth		= { 24 },
-		.row_depth	= { 24 },
-		.num_planes	= 1,
-		.flags		= MDP_FMT_FLAG_OUTPUT | MDP_FMT_FLAG_CAPTURE,
-	}, {
-		.pixelformat	= V4L2_PIX_FMT_BGR24,
-		.mdp_color	= MDP_COLOR_BGR888,
-		.depth		= { 24 },
-		.row_depth	= { 24 },
-		.num_planes	= 1,
-		.flags		= MDP_FMT_FLAG_OUTPUT | MDP_FMT_FLAG_CAPTURE,
-	}, {
-		.pixelformat	= V4L2_PIX_FMT_ABGR32,
-		.mdp_color	= MDP_COLOR_BGRA8888,
-		.depth		= { 32 },
-		.row_depth	= { 32 },
-		.num_planes	= 1,
-		.flags		= MDP_FMT_FLAG_OUTPUT | MDP_FMT_FLAG_CAPTURE,
-	}, {
-		.pixelformat	= V4L2_PIX_FMT_ARGB32,
-		.mdp_color	= MDP_COLOR_ARGB8888,
-		.depth		= { 32 },
-		.row_depth	= { 32 },
-		.num_planes	= 1,
-		.flags		= MDP_FMT_FLAG_OUTPUT | MDP_FMT_FLAG_CAPTURE,
-	}, {
-		.pixelformat	= V4L2_PIX_FMT_UYVY,
-		.mdp_color	= MDP_COLOR_UYVY,
-		.depth		= { 16 },
-		.row_depth	= { 16 },
-		.num_planes	= 1,
-		.walign		= 1,
-		.flags		= MDP_FMT_FLAG_OUTPUT | MDP_FMT_FLAG_CAPTURE,
-	}, {
-		.pixelformat	= V4L2_PIX_FMT_VYUY,
-		.mdp_color	= MDP_COLOR_VYUY,
-		.depth		= { 16 },
-		.row_depth	= { 16 },
-		.num_planes	= 1,
-		.walign		= 1,
-		.flags		= MDP_FMT_FLAG_OUTPUT | MDP_FMT_FLAG_CAPTURE,
-	}, {
-		.pixelformat	= V4L2_PIX_FMT_YUYV,
-		.mdp_color	= MDP_COLOR_YUYV,
-		.depth		= { 16 },
-		.row_depth	= { 16 },
-		.num_planes	= 1,
-		.walign		= 1,
-		.flags		= MDP_FMT_FLAG_OUTPUT | MDP_FMT_FLAG_CAPTURE,
-	}, {
-		.pixelformat	= V4L2_PIX_FMT_YVYU,
-		.mdp_color	= MDP_COLOR_YVYU,
-		.depth		= { 16 },
-		.row_depth	= { 16 },
-		.num_planes	= 1,
-		.walign		= 1,
-		.flags		= MDP_FMT_FLAG_OUTPUT | MDP_FMT_FLAG_CAPTURE,
-	}, {
-		.pixelformat	= V4L2_PIX_FMT_YUV420,
-		.mdp_color	= MDP_COLOR_I420,
-		.depth		= { 12 },
-		.row_depth	= { 8 },
-		.num_planes	= 1,
-		.walign		= 1,
-		.halign		= 1,
-		.flags		= MDP_FMT_FLAG_OUTPUT | MDP_FMT_FLAG_CAPTURE,
-	}, {
-		.pixelformat	= V4L2_PIX_FMT_YVU420,
-		.mdp_color	= MDP_COLOR_YV12,
-		.depth		= { 12 },
-		.row_depth	= { 8 },
-		.num_planes	= 1,
-		.walign		= 1,
-		.halign		= 1,
-		.flags		= MDP_FMT_FLAG_OUTPUT | MDP_FMT_FLAG_CAPTURE,
-	}, {
-		.pixelformat	= V4L2_PIX_FMT_NV12,
-		.mdp_color	= MDP_COLOR_NV12,
-		.depth		= { 12 },
-		.row_depth	= { 8 },
-		.num_planes	= 1,
-		.walign		= 1,
-		.halign		= 1,
-		.flags		= MDP_FMT_FLAG_OUTPUT | MDP_FMT_FLAG_CAPTURE,
-	}, {
-		.pixelformat	= V4L2_PIX_FMT_NV21,
-		.mdp_color	= MDP_COLOR_NV21,
-		.depth		= { 12 },
-		.row_depth	= { 8 },
-		.num_planes	= 1,
-		.walign		= 1,
-		.halign		= 1,
-		.flags		= MDP_FMT_FLAG_OUTPUT | MDP_FMT_FLAG_CAPTURE,
-	}, {
-		.pixelformat	= V4L2_PIX_FMT_NV16,
-		.mdp_color	= MDP_COLOR_NV16,
-		.depth		= { 16 },
-		.row_depth	= { 8 },
-		.num_planes	= 1,
-		.walign		= 1,
-		.flags		= MDP_FMT_FLAG_OUTPUT,
-	}, {
-		.pixelformat	= V4L2_PIX_FMT_NV61,
-		.mdp_color	= MDP_COLOR_NV61,
-		.depth		= { 16 },
-		.row_depth	= { 8 },
-		.num_planes	= 1,
-		.walign		= 1,
-		.flags		= MDP_FMT_FLAG_OUTPUT,
-	}, {
-		.pixelformat	= V4L2_PIX_FMT_NV24,
-		.mdp_color	= MDP_COLOR_NV24,
-		.depth		= { 24 },
-		.row_depth	= { 8 },
-		.num_planes	= 1,
-		.flags		= MDP_FMT_FLAG_OUTPUT,
-	}, {
-		.pixelformat	= V4L2_PIX_FMT_NV42,
-		.mdp_color	= MDP_COLOR_NV42,
-		.depth		= { 24 },
-		.row_depth	= { 8 },
-		.num_planes	= 1,
-		.flags		= MDP_FMT_FLAG_OUTPUT,
-	}, {
-		.pixelformat	= V4L2_PIX_FMT_MT21C,
-		.mdp_color	= MDP_COLOR_420_BLK_UFO,
-		.depth		= { 8, 4 },
-		.row_depth	= { 8, 8 },
-		.num_planes	= 2,
-		.walign		= 4,
-		.halign		= 5,
-		.flags		= MDP_FMT_FLAG_OUTPUT,
-	}, {
-		.pixelformat	= V4L2_PIX_FMT_MM21,
-		.mdp_color	= MDP_COLOR_420_BLK,
-		.depth		= { 8, 4 },
-		.row_depth	= { 8, 8 },
-		.num_planes	= 2,
-		.walign		= 4,
-		.halign		= 5,
-		.flags		= MDP_FMT_FLAG_OUTPUT,
-	}, {
-		.pixelformat	= V4L2_PIX_FMT_NV12M,
-		.mdp_color	= MDP_COLOR_NV12,
-		.depth		= { 8, 4 },
-		.row_depth	= { 8, 8 },
-		.num_planes	= 2,
-		.walign		= 1,
-		.halign		= 1,
-		.flags		= MDP_FMT_FLAG_OUTPUT | MDP_FMT_FLAG_CAPTURE,
-	}, {
-		.pixelformat	= V4L2_PIX_FMT_NV21M,
-		.mdp_color	= MDP_COLOR_NV21,
-		.depth		= { 8, 4 },
-		.row_depth	= { 8, 8 },
-		.num_planes	= 2,
-		.walign		= 1,
-		.halign		= 1,
-		.flags		= MDP_FMT_FLAG_OUTPUT | MDP_FMT_FLAG_CAPTURE,
-	}, {
-		.pixelformat	= V4L2_PIX_FMT_NV16M,
-		.mdp_color	= MDP_COLOR_NV16,
-		.depth		= { 8, 8 },
-		.row_depth	= { 8, 8 },
-		.num_planes	= 2,
-		.walign		= 1,
-		.flags		= MDP_FMT_FLAG_OUTPUT,
-	}, {
-		.pixelformat	= V4L2_PIX_FMT_NV61M,
-		.mdp_color	= MDP_COLOR_NV61,
-		.depth		= { 8, 8 },
-		.row_depth	= { 8, 8 },
-		.num_planes	= 2,
-		.walign		= 1,
-		.flags		= MDP_FMT_FLAG_OUTPUT,
-	}, {
-		.pixelformat	= V4L2_PIX_FMT_YUV420M,
-		.mdp_color	= MDP_COLOR_I420,
-		.depth		= { 8, 2, 2 },
-		.row_depth	= { 8, 4, 4 },
-		.num_planes	= 3,
-		.walign		= 1,
-		.halign		= 1,
-		.flags		= MDP_FMT_FLAG_OUTPUT | MDP_FMT_FLAG_CAPTURE,
-	}, {
-		.pixelformat	= V4L2_PIX_FMT_YVU420M,
-		.mdp_color	= MDP_COLOR_YV12,
-		.depth		= { 8, 2, 2 },
-		.row_depth	= { 8, 4, 4 },
-		.num_planes	= 3,
-		.walign		= 1,
-		.halign		= 1,
-		.flags		= MDP_FMT_FLAG_OUTPUT | MDP_FMT_FLAG_CAPTURE,
-	}
-};
-
 static const struct mdp_limit mdp_def_limit = {
 	.out_limit = {
 		.wmin	= 16,
@@ -256,32 +31,34 @@ static const struct mdp_limit mdp_def_limit = {
 	.v_scale_down_max = 128,
 };
 
-static const struct mdp_format *mdp_find_fmt(u32 pixelformat, u32 type)
+static const struct mdp_format *mdp_find_fmt(const struct mtk_mdp_driver_data *mdp_data,
+					     u32 pixelformat, u32 type)
 {
 	u32 i, flag;
 
 	flag = V4L2_TYPE_IS_OUTPUT(type) ? MDP_FMT_FLAG_OUTPUT :
 					MDP_FMT_FLAG_CAPTURE;
-	for (i = 0; i < ARRAY_SIZE(mdp_formats); ++i) {
-		if (!(mdp_formats[i].flags & flag))
+	for (i = 0; i < mdp_data->format_len; ++i) {
+		if (!(mdp_data->format[i].flags & flag))
 			continue;
-		if (mdp_formats[i].pixelformat == pixelformat)
-			return &mdp_formats[i];
+		if (mdp_data->format[i].pixelformat == pixelformat)
+			return &mdp_data->format[i];
 	}
 	return NULL;
 }
 
-static const struct mdp_format *mdp_find_fmt_by_index(u32 index, u32 type)
+static const struct mdp_format *mdp_find_fmt_by_index(const struct mtk_mdp_driver_data *mdp_data,
+						      u32 index, u32 type)
 {
 	u32 i, flag, num = 0;
 
 	flag = V4L2_TYPE_IS_OUTPUT(type) ? MDP_FMT_FLAG_OUTPUT :
 					MDP_FMT_FLAG_CAPTURE;
-	for (i = 0; i < ARRAY_SIZE(mdp_formats); ++i) {
-		if (!(mdp_formats[i].flags & flag))
+	for (i = 0; i < mdp_data->format_len; ++i) {
+		if (!(mdp_data->format[i].flags & flag))
 			continue;
 		if (index == num)
-			return &mdp_formats[i];
+			return &mdp_data->format[i];
 		num++;
 	}
 	return NULL;
@@ -355,11 +132,11 @@ static int mdp_clamp_align(s32 *x, int min, int max, unsigned int align)
 	return 0;
 }
 
-int mdp_enum_fmt_mplane(struct v4l2_fmtdesc *f)
+int mdp_enum_fmt_mplane(struct mdp_dev *mdp, struct v4l2_fmtdesc *f)
 {
 	const struct mdp_format *fmt;
 
-	fmt = mdp_find_fmt_by_index(f->index, f->type);
+	fmt = mdp_find_fmt_by_index(mdp->mdp_data, f->index, f->type);
 	if (!fmt)
 		return -EINVAL;
 
@@ -367,7 +144,8 @@ int mdp_enum_fmt_mplane(struct v4l2_fmtdesc *f)
 	return 0;
 }
 
-const struct mdp_format *mdp_try_fmt_mplane(struct v4l2_format *f,
+const struct mdp_format *mdp_try_fmt_mplane(struct mdp_dev *mdp,
+					    struct v4l2_format *f,
 					    struct mdp_frameparam *param,
 					    u32 ctx_id)
 {
@@ -379,9 +157,9 @@ const struct mdp_format *mdp_try_fmt_mplane(struct v4l2_format *f,
 	u32 org_w, org_h;
 	unsigned int i;
 
-	fmt = mdp_find_fmt(pix_mp->pixelformat, f->type);
+	fmt = mdp_find_fmt(mdp->mdp_data, pix_mp->pixelformat, f->type);
 	if (!fmt) {
-		fmt = mdp_find_fmt_by_index(0, f->type);
+		fmt = mdp_find_fmt_by_index(mdp->mdp_data, 0, f->type);
 		if (!fmt) {
 			dev_dbg(dev, "%d: pixelformat %c%c%c%c invalid", ctx_id,
 				(pix_mp->pixelformat & 0xff),
@@ -701,7 +479,7 @@ void mdp_set_dst_config(struct img_output *out,
 	mdp_set_orientation(out, frame->rotation, frame->hflip, frame->vflip);
 }
 
-int mdp_frameparam_init(struct mdp_frameparam *param)
+int mdp_frameparam_init(struct mdp_dev *mdp, struct mdp_frameparam *param)
 {
 	struct mdp_frame *frame;
 
@@ -714,7 +492,7 @@ int mdp_frameparam_init(struct mdp_frameparam *param)
 
 	frame = &param->output;
 	frame->format.type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE;
-	frame->mdp_fmt = mdp_try_fmt_mplane(&frame->format, param, 0);
+	frame->mdp_fmt = mdp_try_fmt_mplane(mdp, &frame->format, param, 0);
 	frame->ycbcr_prof =
 		mdp_map_ycbcr_prof_mplane(&frame->format,
 					  frame->mdp_fmt->mdp_color);
@@ -723,7 +501,7 @@ int mdp_frameparam_init(struct mdp_frameparam *param)
 	param->num_captures = 1;
 	frame = &param->captures[0];
 	frame->format.type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE;
-	frame->mdp_fmt = mdp_try_fmt_mplane(&frame->format, param, 0);
+	frame->mdp_fmt = mdp_try_fmt_mplane(mdp, &frame->format, param, 0);
 	frame->ycbcr_prof =
 		mdp_map_ycbcr_prof_mplane(&frame->format,
 					  frame->mdp_fmt->mdp_color);
diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-regs.h b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-regs.h
index f995e536d45f..8e91bcb094e0 100644
--- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-regs.h
+++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-regs.h
@@ -353,8 +353,11 @@ struct mdp_frameparam {
 	enum v4l2_quantization		quant;
 };
 
-int mdp_enum_fmt_mplane(struct v4l2_fmtdesc *f);
-const struct mdp_format *mdp_try_fmt_mplane(struct v4l2_format *f,
+struct mdp_dev;
+
+int mdp_enum_fmt_mplane(struct mdp_dev *mdp, struct v4l2_fmtdesc *f);
+const struct mdp_format *mdp_try_fmt_mplane(struct mdp_dev *mdp,
+					    struct v4l2_format *f,
 					    struct mdp_frameparam *param,
 					    u32 ctx_id);
 enum mdp_ycbcr_profile mdp_map_ycbcr_prof_mplane(struct v4l2_format *f,
@@ -368,6 +371,6 @@ void mdp_set_src_config(struct img_input *in,
 			struct mdp_frame *frame, struct vb2_buffer *vb);
 void mdp_set_dst_config(struct img_output *out,
 			struct mdp_frame *frame, struct vb2_buffer *vb);
-int mdp_frameparam_init(struct mdp_frameparam *param);
+int mdp_frameparam_init(struct mdp_dev *mdp, struct mdp_frameparam *param);
 
 #endif  /* __MTK_MDP3_REGS_H__ */
-- 
2.18.0

