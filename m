Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 570B86C99F6
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 05:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231203AbjC0DOD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 23:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232192AbjC0DNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 23:13:55 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F285252;
        Sun, 26 Mar 2023 20:13:41 -0700 (PDT)
X-UUID: 5e2235a0cc4d11eda9a90f0bb45854f4-20230327
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=37feK4H352MLzFfVmA6c0Q9gaAVyebOImg/IcUbn+wg=;
        b=JqvkGLJnGEiiwAHKz0hc+b0fhdlFQ81S6lwr4iZbv6JDeTXNI35tJErNQfsIrhzLxGC/iYTNsovxRKswzwDJZ5LvMVaPAsp9XrQsNTFipcgHg2bMSRTkHfXd4RMz7FSuAuFemeguP6Dq5Se8fAlHy5o6n6YFAex43fHqB6OO05c=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:85967be7-b793-4126-906c-b54174f8e003,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-25
X-CID-META: VersionHash:120426c,CLOUDID:b4d38f29-564d-42d9-9875-7c868ee415ec,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: 5e2235a0cc4d11eda9a90f0bb45854f4-20230327
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
        (envelope-from <moudy.ho@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1999047032; Mon, 27 Mar 2023 11:13:38 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Mon, 27 Mar 2023 11:13:36 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Mon, 27 Mar 2023 11:13:36 +0800
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
Subject: [PATCH v7 06/12] media: platform: mtk-mdp3: chip config split about resolution limitations
Date:   Mon, 27 Mar 2023 11:13:29 +0800
Message-ID: <20230327031335.9663-7-moudy.ho@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230327031335.9663-1-moudy.ho@mediatek.com>
References: <20230327031335.9663-1-moudy.ho@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to differences in hardware design, the supported max and min
resolutions and scaling capabilities will vary, and should be
integrated into specific config file.

Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
---
 .../platform/mediatek/mdp3/mdp_cfg_data.c     | 20 ++++++++++++++++++
 .../platform/mediatek/mdp3/mtk-mdp3-core.h    |  1 +
 .../platform/mediatek/mdp3/mtk-mdp3-m2m.c     |  5 +++--
 .../platform/mediatek/mdp3/mtk-mdp3-regs.c    | 21 +------------------
 4 files changed, 25 insertions(+), 22 deletions(-)

diff --git a/drivers/media/platform/mediatek/mdp3/mdp_cfg_data.c b/drivers/media/platform/mediatek/mdp3/mdp_cfg_data.c
index 46c005b7447f..1769bce2871e 100644
--- a/drivers/media/platform/mediatek/mdp3/mdp_cfg_data.c
+++ b/drivers/media/platform/mediatek/mdp3/mdp_cfg_data.c
@@ -381,6 +381,25 @@ static const struct mdp_format mt8183_formats[] = {
 	}
 };
 
+static const struct mdp_limit mt8183_mdp_def_limit = {
+	.out_limit = {
+		.wmin	= 16,
+		.hmin	= 16,
+		.wmax	= 8176,
+		.hmax	= 8176,
+	},
+	.cap_limit = {
+		.wmin	= 2,
+		.hmin	= 2,
+		.wmax	= 8176,
+		.hmax	= 8176,
+	},
+	.h_scale_up_max = 32,
+	.v_scale_up_max = 32,
+	.h_scale_down_max = 20,
+	.v_scale_down_max = 128,
+};
+
 const struct mtk_mdp_driver_data mt8183_mdp_driver_data = {
 	.mdp_probe_infra = mt8183_mdp_probe_infra,
 	.mdp_cfg = &mt8183_plat_cfg,
@@ -390,6 +409,7 @@ const struct mtk_mdp_driver_data mt8183_mdp_driver_data = {
 	.mdp_sub_comp_dt_ids = mt8183_sub_comp_dt_ids,
 	.format = mt8183_formats,
 	.format_len = ARRAY_SIZE(mt8183_formats),
+	.def_limit = &mt8183_mdp_def_limit,
 };
 
 s32 mdp_cfg_get_id_inner(struct mdp_dev *mdp_dev, enum mtk_mdp_comp_id id)
diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.h b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.h
index 327da00dd1fc..a312c1007e96 100644
--- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.h
+++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.h
@@ -59,6 +59,7 @@ struct mtk_mdp_driver_data {
 	const struct of_device_id *mdp_sub_comp_dt_ids;
 	const struct mdp_format *format;
 	unsigned int format_len;
+	const struct mdp_limit *def_limit;
 };
 
 struct mdp_dev {
diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-m2m.c b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-m2m.c
index f708fca228a7..27e1b1b8c6b4 100644
--- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-m2m.c
+++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-m2m.c
@@ -558,6 +558,7 @@ static int mdp_m2m_open(struct file *file)
 	struct device *dev = &mdp->pdev->dev;
 	int ret;
 	struct v4l2_format default_format = {};
+	const struct mdp_limit *limit = mdp->mdp_data->def_limit;
 
 	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
 	if (!ctx)
@@ -605,8 +606,8 @@ static int mdp_m2m_open(struct file *file)
 
 	/* Default format */
 	default_format.type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE;
-	default_format.fmt.pix_mp.width = 32;
-	default_format.fmt.pix_mp.height = 32;
+	default_format.fmt.pix_mp.width = limit->out_limit.wmin;
+	default_format.fmt.pix_mp.height = limit->out_limit.hmin;
 	default_format.fmt.pix_mp.pixelformat = V4L2_PIX_FMT_YUV420M;
 	mdp_m2m_s_fmt_mplane(file, &ctx->fh, &default_format);
 	default_format.type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE;
diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-regs.c b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-regs.c
index c6fecb089687..9b436b911d92 100644
--- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-regs.c
+++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-regs.c
@@ -12,25 +12,6 @@
 #include "mtk-mdp3-regs.h"
 #include "mtk-mdp3-m2m.h"
 
-static const struct mdp_limit mdp_def_limit = {
-	.out_limit = {
-		.wmin	= 16,
-		.hmin	= 16,
-		.wmax	= 8176,
-		.hmax	= 8176,
-	},
-	.cap_limit = {
-		.wmin	= 2,
-		.hmin	= 2,
-		.wmax	= 8176,
-		.hmax	= 8176,
-	},
-	.h_scale_up_max = 32,
-	.v_scale_up_max = 32,
-	.h_scale_down_max = 20,
-	.v_scale_down_max = 128,
-};
-
 static const struct mdp_format *mdp_find_fmt(const struct mtk_mdp_driver_data *mdp_data,
 					     u32 pixelformat, u32 type)
 {
@@ -487,7 +468,7 @@ int mdp_frameparam_init(struct mdp_dev *mdp, struct mdp_frameparam *param)
 		return -EINVAL;
 
 	INIT_LIST_HEAD(&param->list);
-	param->limit = &mdp_def_limit;
+	param->limit = mdp->mdp_data->def_limit;
 	param->type = MDP_STREAM_TYPE_BITBLT;
 
 	frame = &param->output;
-- 
2.18.0

