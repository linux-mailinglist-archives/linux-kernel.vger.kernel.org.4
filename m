Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 335F4637951
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 13:53:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbiKXMw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 07:52:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbiKXMwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 07:52:39 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2214D12A90;
        Thu, 24 Nov 2022 04:52:35 -0800 (PST)
X-UUID: 105d51dd7b22421ba58e99c22b889664-20221124
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=8vtKcTs17YkrRiAV7jy0vxJzo85V7v0pgY+kQtlunR4=;
        b=Pz5u+FRnQ7fz+bCvKiPdpvwq65yJLyNeLA8tNE/ZlgitgY8fpOcNRSGUmVfkTks6ATvGi6htfNvU8Hkd69gAD8ZyfB29XRco/cccfCa+YAs+g+PZpPMwDS1j/ibOx7F/m7cQw5XG0jzsw8HNA/XV4umPl26IRgJ9qRUMS2HE10c=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:a524fa02-8885-4f8a-853b-7db89beee6a3,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:dcaaed0,CLOUDID:3e4637f9-3a34-4838-abcf-dfedf9dd068e,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 105d51dd7b22421ba58e99c22b889664-20221124
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
        (envelope-from <moudy.ho@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1907614147; Thu, 24 Nov 2022 20:52:28 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 24 Nov 2022 20:52:27 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Thu, 24 Nov 2022 20:52:27 +0800
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
Subject: [PATCH v1 03/12] media: platform: mtk-mdp3: add support second sets of MMSYS
Date:   Thu, 24 Nov 2022 20:52:16 +0800
Message-ID: <20221124125225.24538-4-moudy.ho@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20221124125225.24538-1-moudy.ho@mediatek.com>
References: <20221124125225.24538-1-moudy.ho@mediatek.com>
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

In MT8195, there are two sets of MMSYS named VPPSYS0 and VPPSYS1,
which are used to coordinate and control the clock, power and
register settings required by the components of MDP3.

Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
---
 .../mediatek/mdp3/mt8183/mdp3-plat-mt8183.h   | 44 +++++++++----------
 .../platform/mediatek/mdp3/mtk-mdp3-comp.h    |  1 +
 .../platform/mediatek/mdp3/mtk-mdp3-core.c    | 40 +++++++++++------
 .../platform/mediatek/mdp3/mtk-mdp3-core.h    |  3 ++
 4 files changed, 53 insertions(+), 35 deletions(-)

diff --git a/drivers/media/platform/mediatek/mdp3/mt8183/mdp3-plat-mt8183.h b/drivers/media/platform/mediatek/mdp3/mt8183/mdp3-plat-mt8183.h
index eb0ab1880fe2..fb9b34fa901a 100644
--- a/drivers/media/platform/mediatek/mdp3/mt8183/mdp3-plat-mt8183.h
+++ b/drivers/media/platform/mediatek/mdp3/mt8183/mdp3-plat-mt8183.h
@@ -22,10 +22,10 @@ static const struct of_device_id mt8183_mdp_probe_infra[MDP_INFRA_MAX] = {
 };
 
 static const struct mdp_pipe_info mt8183_pipe_info[] = {
-	[MDP_PIPE_RDMA0] = {MDP_PIPE_RDMA0, 0},
-	[MDP_PIPE_IMGI] = {MDP_PIPE_IMGI, 1},
-	[MDP_PIPE_WPEI] = {MDP_PIPE_WPEI, 2},
-	[MDP_PIPE_WPEI2] = {MDP_PIPE_WPEI2, 3}
+	[MDP_PIPE_RDMA0] = {MDP_PIPE_RDMA0, 0, 0},
+	[MDP_PIPE_IMGI] = {MDP_PIPE_IMGI, 0, 1},
+	[MDP_PIPE_WPEI] = {MDP_PIPE_WPEI, 0, 2},
+	[MDP_PIPE_WPEI2] = {MDP_PIPE_WPEI2, 0, 3}
 };
 
 static const u32 mt8183_mutex_idx[MDP_MAX_COMP_COUNT] = {
@@ -89,75 +89,75 @@ enum mt8183_mdp_comp_id {
 
 static const struct mdp_comp_data mt8183_mdp_comp_data[MDP_MAX_COMP_COUNT] = {
 	[MDP_COMP_WPEI] = {
-		{MDP_COMP_TYPE_WPEI, 0, MT8183_MDP_COMP_WPEI},
+		{MDP_COMP_TYPE_WPEI, 0, MT8183_MDP_COMP_WPEI, 0},
 		{0, 0, 0}
 	},
 	[MDP_COMP_WPEO] = {
-		{MDP_COMP_TYPE_EXTO, 2, MT8183_MDP_COMP_WPEO},
+		{MDP_COMP_TYPE_EXTO, 2, MT8183_MDP_COMP_WPEO, 0},
 		{0, 0, 0}
 	},
 	[MDP_COMP_WPEI2] = {
-		{MDP_COMP_TYPE_WPEI, 1, MT8183_MDP_COMP_WPEI2},
+		{MDP_COMP_TYPE_WPEI, 1, MT8183_MDP_COMP_WPEI2, 0},
 		{0, 0, 0}
 	},
 	[MDP_COMP_WPEO2] = {
-		{MDP_COMP_TYPE_EXTO, 3, MT8183_MDP_COMP_WPEO2},
+		{MDP_COMP_TYPE_EXTO, 3, MT8183_MDP_COMP_WPEO2, 0},
 		{0, 0, 0}
 	},
 	[MDP_COMP_ISP_IMGI] = {
-		{MDP_COMP_TYPE_IMGI, 0, MT8183_MDP_COMP_ISP_IMGI},
+		{MDP_COMP_TYPE_IMGI, 0, MT8183_MDP_COMP_ISP_IMGI, 0},
 		{0, 0, 4}
 	},
 	[MDP_COMP_ISP_IMGO] = {
-		{MDP_COMP_TYPE_EXTO, 0, MT8183_MDP_COMP_ISP_IMGO},
+		{MDP_COMP_TYPE_EXTO, 0, MT8183_MDP_COMP_ISP_IMGO, 0},
 		{0, 0, 4}
 	},
 	[MDP_COMP_ISP_IMG2O] = {
-		{MDP_COMP_TYPE_EXTO, 1, MT8183_MDP_COMP_ISP_IMG2O},
+		{MDP_COMP_TYPE_EXTO, 1, MT8183_MDP_COMP_ISP_IMG2O, 0},
 		{0, 0, 0}
 	},
 	[MDP_COMP_CAMIN] = {
-		{MDP_COMP_TYPE_DL_PATH, 0, MT8183_MDP_COMP_CAMIN},
+		{MDP_COMP_TYPE_DL_PATH, 0, MT8183_MDP_COMP_CAMIN, 0},
 		{2, 2, 1}
 	},
 	[MDP_COMP_CAMIN2] = {
-		{MDP_COMP_TYPE_DL_PATH, 1, MT8183_MDP_COMP_CAMIN2},
+		{MDP_COMP_TYPE_DL_PATH, 1, MT8183_MDP_COMP_CAMIN2, 0},
 		{2, 4, 1}
 	},
 	[MDP_COMP_RDMA0] = {
-		{MDP_COMP_TYPE_RDMA, 0, MT8183_MDP_COMP_RDMA0},
+		{MDP_COMP_TYPE_RDMA, 0, MT8183_MDP_COMP_RDMA0, 0},
 		{2, 0, 0}
 	},
 	[MDP_COMP_CCORR0] = {
-		{MDP_COMP_TYPE_CCORR, 0, MT8183_MDP_COMP_CCORR0},
+		{MDP_COMP_TYPE_CCORR, 0, MT8183_MDP_COMP_CCORR0, 0},
 		{1, 0, 0}
 	},
 	[MDP_COMP_RSZ0] = {
-		{MDP_COMP_TYPE_RSZ, 0, MT8183_MDP_COMP_RSZ0},
+		{MDP_COMP_TYPE_RSZ, 0, MT8183_MDP_COMP_RSZ0, 0},
 		{1, 0, 0}
 	},
 	[MDP_COMP_RSZ1] = {
-		{MDP_COMP_TYPE_RSZ, 1, MT8183_MDP_COMP_RSZ1},
+		{MDP_COMP_TYPE_RSZ, 1, MT8183_MDP_COMP_RSZ1, 0},
 		{1, 0, 0}
 	},
 	[MDP_COMP_TDSHP0] = {
-		{MDP_COMP_TYPE_TDSHP, 0, MT8183_MDP_COMP_TDSHP0},
+		{MDP_COMP_TYPE_TDSHP, 0, MT8183_MDP_COMP_TDSHP0, 0},
 		{0, 0, 0}
 	},
 	[MDP_COMP_PATH0_SOUT] = {
-		{MDP_COMP_TYPE_PATH, 0, MT8183_MDP_COMP_PATH0_SOUT},
+		{MDP_COMP_TYPE_PATH, 0, MT8183_MDP_COMP_PATH0_SOUT, 0},
 		{0, 0, 0}
 	},
 	[MDP_COMP_PATH1_SOUT] = {
-		{MDP_COMP_TYPE_PATH, 1, MT8183_MDP_COMP_PATH1_SOUT},
+		{MDP_COMP_TYPE_PATH, 1, MT8183_MDP_COMP_PATH1_SOUT, 0},
 		{0, 0, 0}
 	},
 	[MDP_COMP_WROT0] = {
-		{MDP_COMP_TYPE_WROT, 0, MT8183_MDP_COMP_WROT0},
+		{MDP_COMP_TYPE_WROT, 0, MT8183_MDP_COMP_WROT0, 0},
 		{1, 0, 0}
 	},
 	[MDP_COMP_WDMA] = {
-		{MDP_COMP_TYPE_WDMA, 0, MT8183_MDP_COMP_WDMA},
+		{MDP_COMP_TYPE_WDMA, 0, MT8183_MDP_COMP_WDMA, 0},
 		{1, 0, 0}
 	},
 };
diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.h b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.h
index 5188aa0821c4..afec66c49f77 100644
--- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.h
+++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.h
@@ -138,6 +138,7 @@ struct mdp_comp_match {
 	enum mdp_comp_type type;
 	u32 alias_id;
 	s32 inner_id;
+	u32 mmsys_id;
 };
 
 /* Used to describe the item order in MDP property */
diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c
index 8daa7245c90b..927d3d65751a 100644
--- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c
+++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c
@@ -41,39 +41,45 @@ static const struct of_device_id mdp_of_ids[] = {
 MODULE_DEVICE_TABLE(of, mdp_of_ids);
 
 static struct platform_device *__get_pdev_by_id(struct platform_device *pdev,
+						struct platform_device *from,
 						enum mdp_infra_id id)
 {
-	struct device_node *node;
+	struct device_node *node, *f = NULL;
 	struct platform_device *mdp_pdev = NULL;
 	const struct mtk_mdp_driver_data *mdp_data;
 	const char *compat;
 
 	if (!pdev)
-		return NULL;
+		return ERR_PTR(-ENODEV);
 
 	if (id < MDP_INFRA_MMSYS || id >= MDP_INFRA_MAX) {
 		dev_err(&pdev->dev, "Illegal infra id %d\n", id);
-		return NULL;
+		return ERR_PTR(-ENODEV);
 	}
 
 	mdp_data = of_device_get_match_data(&pdev->dev);
 	if (!mdp_data) {
 		dev_err(&pdev->dev, "have no driver data to find node\n");
-		return NULL;
+		return ERR_PTR(-ENODEV);
 	}
+
 	compat = mdp_data->mdp_probe_infra[id].compatible;
+	if (strlen(compat) == 0)
+		return NULL;
 
-	node = of_find_compatible_node(NULL, NULL, compat);
+	if (from)
+		f = from->dev.of_node;
+	node = of_find_compatible_node(f, NULL, compat);
 	if (WARN_ON(!node)) {
 		dev_err(&pdev->dev, "find node from id %d failed\n", id);
-		return NULL;
+		return ERR_PTR(-ENODEV);
 	}
 
 	mdp_pdev = of_find_device_by_node(node);
 	of_node_put(node);
 	if (WARN_ON(!mdp_pdev)) {
 		dev_err(&pdev->dev, "find pdev from id %d failed\n", id);
-		return NULL;
+		return ERR_PTR(-ENODEV);
 	}
 
 	return mdp_pdev;
@@ -167,7 +173,7 @@ static int mdp_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct mdp_dev *mdp;
-	struct platform_device *mm_pdev;
+	struct platform_device *mm_pdev, *mm2_pdev;
 	int ret, i, mutex_id;
 
 	mdp = kzalloc(sizeof(*mdp), GFP_KERNEL);
@@ -179,15 +185,23 @@ static int mdp_probe(struct platform_device *pdev)
 	mdp->pdev = pdev;
 	mdp->mdp_data = of_device_get_match_data(&pdev->dev);
 
-	mm_pdev = __get_pdev_by_id(pdev, MDP_INFRA_MMSYS);
-	if (!mm_pdev) {
+	mm_pdev = __get_pdev_by_id(pdev, NULL, MDP_INFRA_MMSYS);
+	if (IS_ERR_OR_NULL(mm_pdev)) {
 		ret = -ENODEV;
 		goto err_destroy_device;
 	}
 	mdp->mdp_mmsys = &mm_pdev->dev;
 
-	mm_pdev = __get_pdev_by_id(pdev, MDP_INFRA_MUTEX);
-	if (WARN_ON(!mm_pdev)) {
+	/* Not all chips have MMSYS2, config may be null */
+	mm2_pdev = __get_pdev_by_id(pdev, mm_pdev, MDP_INFRA_MMSYS2);
+	if (IS_ERR(mm2_pdev)) {
+		ret = PTR_ERR(mm2_pdev);
+		goto err_destroy_device;
+	}
+	mdp->mdp_mmsys2 = &mm2_pdev->dev;
+
+	mm_pdev = __get_pdev_by_id(pdev, NULL, MDP_INFRA_MUTEX);
+	if (IS_ERR_OR_NULL(mm_pdev)) {
 		ret = -ENODEV;
 		goto err_destroy_device;
 	}
@@ -223,7 +237,7 @@ static int mdp_probe(struct platform_device *pdev)
 		goto err_destroy_job_wq;
 	}
 
-	mm_pdev = __get_pdev_by_id(pdev, MDP_INFRA_SCP);
+	mm_pdev = __get_pdev_by_id(pdev, NULL, MDP_INFRA_SCP);
 	if (WARN_ON(!mm_pdev)) {
 		dev_err(&pdev->dev, "Could not get scp device\n");
 		ret = -ENODEV;
diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.h b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.h
index 4591109eaf62..50c0bc6c358f 100644
--- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.h
+++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.h
@@ -20,6 +20,7 @@
 
 enum mdp_infra_id {
 	MDP_INFRA_MMSYS,
+	MDP_INFRA_MMSYS2,
 	MDP_INFRA_MUTEX,
 	MDP_INFRA_SCP,
 	MDP_INFRA_MAX
@@ -68,6 +69,7 @@ struct mtk_mdp_driver_data {
 struct mdp_dev {
 	struct platform_device			*pdev;
 	struct device				*mdp_mmsys;
+	struct device				*mdp_mmsys2;
 	struct mtk_mutex			*mdp_mutex[MDP_PIPE_MAX];
 	struct mdp_comp				*comp[MDP_MAX_COMP_COUNT];
 	const struct mtk_mdp_driver_data	*mdp_data;
@@ -96,6 +98,7 @@ struct mdp_dev {
 
 struct mdp_pipe_info {
 	enum mdp_pipe_id pipe_id;
+	u32 mmsys_id;
 	u32 mutex_id;
 };
 
-- 
2.18.0

