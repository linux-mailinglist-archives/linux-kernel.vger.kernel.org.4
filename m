Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86E4868EA90
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 10:09:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbjBHJJM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 04:09:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjBHJJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 04:09:10 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 967B333451;
        Wed,  8 Feb 2023 01:09:04 -0800 (PST)
X-UUID: 38bd05f6a79011eda06fc9ecc4dadd91-20230208
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=cKFKKWJEuIFWGC38vUzUVAyCtguW1pxiJiImidANQ8A=;
        b=iG93hyRquC8/SyD0t47SkOWAYRbn5jlR3YUyHCZjv4QMigv6NAsZUG6o9n+wMptrrf9wTzBMqunota6p+fLtthrEQWWZRcEEgFtC6lFCEScStSplH2+lxBlhH+7aJQLaXVcf6oV7/y2DX30WqV5829U7tq2zxAVYnm3aSehz7bc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.19,REQID:59141570-2587-42e0-b209-8ace82ea9932,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:95
X-CID-INFO: VERSION:1.1.19,REQID:59141570-2587-42e0-b209-8ace82ea9932,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTION
        :quarantine,TS:95
X-CID-META: VersionHash:885ddb2,CLOUDID:d420458e-8530-4eff-9f77-222cf6e2895b,B
        ulkID:230208170859OSDEATW7,BulkQuantity:0,Recheck:0,SF:38|29|28|17|19|48,T
        C:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
        ,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-UUID: 38bd05f6a79011eda06fc9ecc4dadd91-20230208
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <moudy.ho@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 704672012; Wed, 08 Feb 2023 17:08:58 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Wed, 8 Feb 2023 17:08:58 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Wed, 8 Feb 2023 17:08:57 +0800
From:   Moudy Ho <moudy.ho@mediatek.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        "Ping-Hsun Wu" <ping-hsun.wu@mediatek.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Moudy Ho <moudy.ho@mediatek.com>
Subject: [PATCH v6 09/12] media: platform: mtk-mdp3: dynamically allocate component clocks
Date:   Wed, 8 Feb 2023 17:08:52 +0800
Message-ID: <20230208090855.18934-10-moudy.ho@mediatek.com>
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

For extensibility of adding more MDP3 components in the further, the
magic number is removed by dynamically allocating component clocks.

Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
---
 .../platform/mediatek/mdp3/mtk-mdp3-comp.c    | 49 +++++++++++--------
 .../platform/mediatek/mdp3/mtk-mdp3-comp.h    |  3 +-
 2 files changed, 31 insertions(+), 21 deletions(-)

diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c
index b65b708d0e3d..d9963f265a07 100644
--- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c
+++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c
@@ -641,7 +641,8 @@ int mdp_comp_clock_on(struct device *dev, struct mdp_comp *comp)
 {
 	int i, ret;
 
-	if (comp->comp_dev) {
+	/* Only DMA capable components need the pm control */
+	if (comp->comp_dev && is_dma_capable(comp->type)) {
 		ret = pm_runtime_resume_and_get(comp->comp_dev);
 		if (ret < 0) {
 			dev_err(dev,
@@ -651,7 +652,7 @@ int mdp_comp_clock_on(struct device *dev, struct mdp_comp *comp)
 		}
 	}
 
-	for (i = 0; i < ARRAY_SIZE(comp->clks); i++) {
+	for (i = 0; i < comp->clk_num; i++) {
 		if (IS_ERR_OR_NULL(comp->clks[i]))
 			continue;
 		ret = clk_prepare_enable(comp->clks[i]);
@@ -671,7 +672,7 @@ int mdp_comp_clock_on(struct device *dev, struct mdp_comp *comp)
 			continue;
 		clk_disable_unprepare(comp->clks[i]);
 	}
-	if (comp->comp_dev)
+	if (comp->comp_dev && is_dma_capable(comp->type))
 		pm_runtime_put_sync(comp->comp_dev);
 
 	return ret;
@@ -681,13 +682,13 @@ void mdp_comp_clock_off(struct device *dev, struct mdp_comp *comp)
 {
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(comp->clks); i++) {
+	for (i = 0; i < comp->clk_num; i++) {
 		if (IS_ERR_OR_NULL(comp->clks[i]))
 			continue;
 		clk_disable_unprepare(comp->clks[i]);
 	}
 
-	if (comp->comp_dev)
+	if (comp->comp_dev && is_dma_capable(comp->type))
 		pm_runtime_put(comp->comp_dev);
 }
 
@@ -766,7 +767,7 @@ static int mdp_comp_init(struct mdp_dev *mdp, struct device_node *node,
 			 struct mdp_comp *comp, enum mtk_mdp_comp_id id)
 {
 	struct device *dev = &mdp->pdev->dev;
-	int clk_num;
+	struct platform_device *pdev_c;
 	int clk_ofst;
 	int i;
 	s32 event;
@@ -776,6 +777,14 @@ static int mdp_comp_init(struct mdp_dev *mdp, struct device_node *node,
 		return -EINVAL;
 	}
 
+	pdev_c = of_find_device_by_node(node);
+	if (!pdev_c) {
+		dev_warn(dev, "can't find platform device of node:%s\n",
+			 node->name);
+		return -ENODEV;
+	}
+
+	comp->comp_dev = &pdev_c->dev;
 	comp->public_id = id;
 	comp->type = mdp->mdp_data->comp_data[id].match.type;
 	comp->inner_id = mdp->mdp_data->comp_data[id].match.inner_id;
@@ -783,10 +792,15 @@ static int mdp_comp_init(struct mdp_dev *mdp, struct device_node *node,
 	comp->ops = mdp_comp_ops[comp->type];
 	__mdp_comp_init(mdp, node, comp);
 
-	clk_num = mdp->mdp_data->comp_data[id].info.clk_num;
+	comp->clk_num = mdp->mdp_data->comp_data[id].info.clk_num;
+	comp->clks = devm_kzalloc(dev, sizeof(struct clk *) * comp->clk_num,
+				  GFP_KERNEL);
+	if (!comp->clks)
+		return -ENOMEM;
+
 	clk_ofst = mdp->mdp_data->comp_data[id].info.clk_ofst;
 
-	for (i = 0; i < clk_num; i++) {
+	for (i = 0; i < comp->clk_num; i++) {
 		comp->clks[i] = of_clk_get(node, i + clk_ofst);
 		if (IS_ERR(comp->clks[i]))
 			break;
@@ -823,6 +837,11 @@ static void mdp_comp_deinit(struct mdp_comp *comp)
 	if (!comp)
 		return;
 
+	if (comp->comp_dev && comp->clks) {
+		devm_kfree(&comp->mdp_dev->pdev->dev, comp->clks);
+		comp->clks = NULL;
+	}
+
 	if (comp->regs)
 		iounmap(comp->regs);
 }
@@ -904,7 +923,8 @@ void mdp_comp_destroy(struct mdp_dev *mdp)
 
 	for (i = 0; i < ARRAY_SIZE(mdp->comp); i++) {
 		if (mdp->comp[i]) {
-			pm_runtime_disable(mdp->comp[i]->comp_dev);
+			if (is_dma_capable(mdp->comp[i]->type))
+				pm_runtime_disable(mdp->comp[i]->comp_dev);
 			mdp_comp_deinit(mdp->comp[i]);
 			devm_kfree(mdp->comp[i]->comp_dev, mdp->comp[i]);
 			mdp->comp[i] = NULL;
@@ -916,7 +936,6 @@ int mdp_comp_config(struct mdp_dev *mdp)
 {
 	struct device *dev = &mdp->pdev->dev;
 	struct device_node *node, *parent;
-	struct platform_device *pdev;
 	int ret;
 
 	memset(mdp_comp_alias_id, 0, sizeof(mdp_comp_alias_id));
@@ -957,18 +976,8 @@ int mdp_comp_config(struct mdp_dev *mdp)
 		}
 
 		/* Only DMA capable components need the pm control */
-		comp->comp_dev = NULL;
 		if (!is_dma_capable(comp->type))
 			continue;
-
-		pdev = of_find_device_by_node(node);
-		if (!pdev) {
-			dev_warn(dev, "can't find platform device of node:%s\n",
-				 node->name);
-			return -ENODEV;
-		}
-
-		comp->comp_dev = &pdev->dev;
 		pm_runtime_enable(comp->comp_dev);
 	}
 
diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.h b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.h
index 3de994d7ef1c..20d2bcb77ef9 100644
--- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.h
+++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.h
@@ -159,7 +159,8 @@ struct mdp_comp {
 	void __iomem			*regs;
 	phys_addr_t			reg_base;
 	u8				subsys_id;
-	struct clk			*clks[6];
+	u8				clk_num;
+	struct clk			**clks;
 	struct device			*comp_dev;
 	enum mdp_comp_type		type;
 	enum mtk_mdp_comp_id		public_id;
-- 
2.18.0

