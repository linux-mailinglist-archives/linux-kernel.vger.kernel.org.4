Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98E436176EC
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 07:49:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbiKCGt3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 02:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbiKCGtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 02:49:00 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F21B16341;
        Wed,  2 Nov 2022 23:48:49 -0700 (PDT)
X-UUID: 85d9a2b52f4e4b9f8da4debd556c1cc5-20221103
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=pQLBAN6Ekkyzj5JynKqZFx9JfAH9zRw7RxBicSAJ82I=;
        b=DcsCyo8FWriBd7znniVgffKXQZfH60QoNGDTjKx9X0bcpuz9EqIXDgqte3RDSNbFNPXDG3rz/21HcBto8iyvZxNXp7m+vfayERWSUG2j3aEHsDdjXorSWWkPYUg3aV67LDorGfvvpnaN3KBSAq3X+ftankFLyOdLjKd2MrCNSZk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.12,REQID:f1249165-7bb1-4ae5-ba02-cf22f2c65f3c,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:62cd327,CLOUDID:d4544deb-84ac-4628-a416-bc50d5503da6,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 85d9a2b52f4e4b9f8da4debd556c1cc5-20221103
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
        (envelope-from <moudy.ho@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 286456541; Thu, 03 Nov 2022 14:48:45 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 3 Nov 2022 14:48:44 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Thu, 3 Nov 2022 14:48:44 +0800
From:   Moudy Ho <moudy.ho@mediatek.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
CC:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        <linux-media@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Moudy Ho <moudy.ho@mediatek.com>
Subject: [PATCH v3 04/10] media: platform: mtk-mdp3: chip config split about color format
Date:   Thu, 3 Nov 2022 14:48:36 +0800
Message-ID: <20221103064842.12042-5-moudy.ho@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20221103064842.12042-1-moudy.ho@mediatek.com>
References: <20221103064842.12042-1-moudy.ho@mediatek.com>
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

Due to differences in hardware design, the supported
color formats will vary and should be moved and
integrated into the chip configuration header file.

Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
---
 .../mediatek/mdp3/mt8183/mdp3-plat-mt8183.h   | 225 +++++++++++++++
 .../platform/mediatek/mdp3/mtk-mdp3-core.c    |   2 +
 .../platform/mediatek/mdp3/mtk-mdp3-core.h    |   2 +
 .../platform/mediatek/mdp3/mtk-mdp3-m2m.c     |  10 +-
 .../platform/mediatek/mdp3/mtk-mdp3-regs.c    | 262 ++----------------
 .../platform/mediatek/mdp3/mtk-mdp3-regs.h    |   7 +-
 6 files changed, 259 insertions(+), 249 deletions(-)

diff --git a/drivers/media/platform/mediatek/mdp3/mt8183/mdp3-plat-mt8183.h b/drivers/media/platform/mediatek/mdp3/mt8183/mdp3-plat-mt8183.h
index a4bfde4a9e16..1be9cc55b9b5 100644
--- a/drivers/media/platform/mediatek/mdp3/mt8183/mdp3-plat-mt8183.h
+++ b/drivers/media/platform/mediatek/mdp3/mt8183/mdp3-plat-mt8183.h
@@ -155,4 +155,229 @@ static const struct mdp_comp_data mt8183_mdp_comp_data[MDP_MAX_COMP_COUNT] = {
 	},
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
 #endif  /* __MDP3_PLAT_MT8183_H__ */
diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c
index 277253c8c963..ce18cbf70e96 100644
--- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c
+++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c
@@ -24,6 +24,8 @@ static const struct mtk_mdp_driver_data mt8183_mdp_driver_data = {
 	.mdp_mutex_table_idx = mt8183_mutex_idx,
 	.comp_data = mt8183_mdp_comp_data,
 	.comp_data_len = ARRAY_SIZE(mt8183_mdp_comp_data),
+	.format = mt8183_formats,
+	.format_len = ARRAY_SIZE(mt8183_formats),
 };
 
 static const struct of_device_id mdp_of_ids[] = {
diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.h b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.h
index b83b2c517730..982438a9ab02 100644
--- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.h
+++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.h
@@ -57,6 +57,8 @@ struct mtk_mdp_driver_data {
 	const u32 *mdp_mutex_table_idx;
 	const struct mdp_comp_data *comp_data;
 	unsigned int comp_data_len;
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
index 4e84a37ecdfc..cd6afbf53797 100644
--- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-regs.c
+++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-regs.c
@@ -11,231 +11,6 @@
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
@@ -255,32 +30,34 @@ static const struct mdp_limit mdp_def_limit = {
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
@@ -354,11 +131,11 @@ static int mdp_clamp_align(s32 *x, int min, int max, unsigned int align)
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
 
@@ -366,7 +143,8 @@ int mdp_enum_fmt_mplane(struct v4l2_fmtdesc *f)
 	return 0;
 }
 
-const struct mdp_format *mdp_try_fmt_mplane(struct v4l2_format *f,
+const struct mdp_format *mdp_try_fmt_mplane(struct mdp_dev *mdp,
+					    struct v4l2_format *f,
 					    struct mdp_frameparam *param,
 					    u32 ctx_id)
 {
@@ -378,9 +156,9 @@ const struct mdp_format *mdp_try_fmt_mplane(struct v4l2_format *f,
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
@@ -699,7 +477,7 @@ void mdp_set_dst_config(struct img_output *out,
 	mdp_set_orientation(out, frame->rotation, frame->hflip, frame->vflip);
 }
 
-int mdp_frameparam_init(struct mdp_frameparam *param)
+int mdp_frameparam_init(struct mdp_dev *mdp, struct mdp_frameparam *param)
 {
 	struct mdp_frame *frame;
 
@@ -712,7 +490,7 @@ int mdp_frameparam_init(struct mdp_frameparam *param)
 
 	frame = &param->output;
 	frame->format.type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE;
-	frame->mdp_fmt = mdp_try_fmt_mplane(&frame->format, param, 0);
+	frame->mdp_fmt = mdp_try_fmt_mplane(mdp, &frame->format, param, 0);
 	frame->ycbcr_prof =
 		mdp_map_ycbcr_prof_mplane(&frame->format,
 					  frame->mdp_fmt->mdp_color);
@@ -721,7 +499,7 @@ int mdp_frameparam_init(struct mdp_frameparam *param)
 	param->num_captures = 1;
 	frame = &param->captures[0];
 	frame->format.type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE;
-	frame->mdp_fmt = mdp_try_fmt_mplane(&frame->format, param, 0);
+	frame->mdp_fmt = mdp_try_fmt_mplane(mdp, &frame->format, param, 0);
 	frame->ycbcr_prof =
 		mdp_map_ycbcr_prof_mplane(&frame->format,
 					  frame->mdp_fmt->mdp_color);
diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-regs.h b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-regs.h
index f995e536d45f..1a26c1bcfd8d 100644
--- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-regs.h
+++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-regs.h
@@ -353,8 +353,9 @@ struct mdp_frameparam {
 	enum v4l2_quantization		quant;
 };
 
-int mdp_enum_fmt_mplane(struct v4l2_fmtdesc *f);
-const struct mdp_format *mdp_try_fmt_mplane(struct v4l2_format *f,
+int mdp_enum_fmt_mplane(struct mdp_dev *mdp, struct v4l2_fmtdesc *f);
+const struct mdp_format *mdp_try_fmt_mplane(struct mdp_dev *mdp,
+					    struct v4l2_format *f,
 					    struct mdp_frameparam *param,
 					    u32 ctx_id);
 enum mdp_ycbcr_profile mdp_map_ycbcr_prof_mplane(struct v4l2_format *f,
@@ -368,6 +369,6 @@ void mdp_set_src_config(struct img_input *in,
 			struct mdp_frame *frame, struct vb2_buffer *vb);
 void mdp_set_dst_config(struct img_output *out,
 			struct mdp_frame *frame, struct vb2_buffer *vb);
-int mdp_frameparam_init(struct mdp_frameparam *param);
+int mdp_frameparam_init(struct mdp_dev *mdp, struct mdp_frameparam *param);
 
 #endif  /* __MTK_MDP3_REGS_H__ */
-- 
2.18.0

