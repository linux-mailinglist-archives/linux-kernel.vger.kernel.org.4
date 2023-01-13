Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE0D668E7C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 07:57:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240980AbjAMG4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 01:56:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236012AbjAMGz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 01:55:57 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B833571892;
        Thu, 12 Jan 2023 22:41:13 -0800 (PST)
X-UUID: 4280646c930d11ed945fc101203acc17-20230113
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=jyEudgx7WcgyCeL9KzWF01BbZwIXIznkx+/V9+/fATw=;
        b=at1rbu/kSZsj+KR4G0X6K8iwNjg+I/8y7PMx42eNVFwj5wW8/oBgl/47zd4bU2qWQ/xd4r7NiOKJwDR8sRJxnH/WYyDkxe/QXINhtMNHuAWVK9mLFe2z8fnhlAwOITN0nHrLB5fPezIxM8ro1bl0UKFviM/xpzzS6n2ABXHXZ3E=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.17,REQID:2511bf35-3d9d-4615-b910-2810fd92e47e,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:70
X-CID-INFO: VERSION:1.1.17,REQID:2511bf35-3d9d-4615-b910-2810fd92e47e,IP:0,URL
        :0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTI
        ON:quarantine,TS:70
X-CID-META: VersionHash:543e81c,CLOUDID:a51d278c-8530-4eff-9f77-222cf6e2895b,B
        ulkID:2301131441093LVPGH3T,BulkQuantity:0,Recheck:0,SF:38|28|17|19|48,TC:n
        il,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OS
        I:0,OSA:0
X-CID-APTURL: Status:success,Category:nil,Trust:0,Unknown:0,Malicious:0
X-CID-BVR: 0
X-UUID: 4280646c930d11ed945fc101203acc17-20230113
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <moudy.ho@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2027494848; Fri, 13 Jan 2023 14:41:07 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Fri, 13 Jan 2023 14:41:06 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Fri, 13 Jan 2023 14:41:06 +0800
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
Subject: [PATCH v5 04/12] media: platform: mtk-mdp3: chip config split about subcomponents
Date:   Fri, 13 Jan 2023 14:40:56 +0800
Message-ID: <20230113064104.22402-5-moudy.ho@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230113064104.22402-1-moudy.ho@mediatek.com>
References: <20230113064104.22402-1-moudy.ho@mediatek.com>
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

Integrate and move subcomponent related information into
the chip config header file for compatibility with multiple chips

Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
---
 .../mediatek/mdp3/mt8183/mdp3-plat-mt8183.h        | 11 +++++++++++
 .../media/platform/mediatek/mdp3/mtk-mdp3-comp.c   | 14 ++------------
 .../media/platform/mediatek/mdp3/mtk-mdp3-core.c   |  1 +
 .../media/platform/mediatek/mdp3/mtk-mdp3-core.h   |  1 +
 4 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/drivers/media/platform/mediatek/mdp3/mt8183/mdp3-plat-mt8183.h b/drivers/media/platform/mediatek/mdp3/mt8183/mdp3-plat-mt8183.h
index 81fb80ec8ac2..a4bfde4a9e16 100644
--- a/drivers/media/platform/mediatek/mdp3/mt8183/mdp3-plat-mt8183.h
+++ b/drivers/media/platform/mediatek/mdp3/mt8183/mdp3-plat-mt8183.h
@@ -32,6 +32,17 @@ static const u32 mt8183_mutex_idx[MDP_MAX_COMP_COUNT] = {
 	[MDP_COMP_CCORR0] = MUTEX_MOD_IDX_MDP_CCORR0,
 };
 
+static const struct of_device_id mt8183_sub_comp_dt_ids[] = {
+	{
+		.compatible = "mediatek,mt8183-mdp3-wdma",
+		.data = (void *)MDP_COMP_TYPE_PATH,
+	}, {
+		.compatible = "mediatek,mt8183-mdp3-wrot",
+		.data = (void *)MDP_COMP_TYPE_PATH,
+	},
+	{}
+};
+
 enum mt8183_mdp_comp_id {
 	/* MT8183 Comp id */
 	/* ISP */
diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c
index 1ac9c46e27d4..8f4786cc4416 100644
--- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c
+++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c
@@ -639,17 +639,6 @@ static const struct of_device_id mdp_comp_dt_ids[] = {
 	{}
 };
 
-static const struct of_device_id mdp_sub_comp_dt_ids[] = {
-	{
-		.compatible = "mediatek,mt8183-mdp3-wdma",
-		.data = (void *)MDP_COMP_TYPE_PATH,
-	}, {
-		.compatible = "mediatek,mt8183-mdp3-wrot",
-		.data = (void *)MDP_COMP_TYPE_PATH,
-	},
-	{}
-};
-
 static inline bool is_dma_capable(const enum mdp_comp_type type)
 {
 	return (type == MDP_COMP_TYPE_RDMA ||
@@ -900,6 +889,7 @@ static int mdp_comp_sub_create(struct mdp_dev *mdp)
 {
 	struct device *dev = &mdp->pdev->dev;
 	struct device_node *node, *parent;
+	const struct mtk_mdp_driver_data *data = mdp->mdp_data;
 
 	parent = dev->of_node->parent;
 
@@ -909,7 +899,7 @@ static int mdp_comp_sub_create(struct mdp_dev *mdp)
 		int id, alias_id;
 		struct mdp_comp *comp;
 
-		of_id = of_match_node(mdp_sub_comp_dt_ids, node);
+		of_id = of_match_node(data->mdp_sub_comp_dt_ids, node);
 		if (!of_id)
 			continue;
 		if (!of_device_is_available(node)) {
diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c
index ee7b5a1bbc88..277253c8c963 100644
--- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c
+++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c
@@ -19,6 +19,7 @@
 
 static const struct mtk_mdp_driver_data mt8183_mdp_driver_data = {
 	.mdp_probe_infra = mt8183_mdp_probe_infra,
+	.mdp_sub_comp_dt_ids = mt8183_sub_comp_dt_ids,
 	.mdp_cfg = &mt8183_plat_cfg,
 	.mdp_mutex_table_idx = mt8183_mutex_idx,
 	.comp_data = mt8183_mdp_comp_data,
diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.h b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.h
index 0c398ef75616..b83b2c517730 100644
--- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.h
+++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.h
@@ -52,6 +52,7 @@ enum mdp_pipe_id {
 
 struct mtk_mdp_driver_data {
 	const struct of_device_id *mdp_probe_infra;
+	const struct of_device_id *mdp_sub_comp_dt_ids;
 	const struct mdp_platform_config *mdp_cfg;
 	const u32 *mdp_mutex_table_idx;
 	const struct mdp_comp_data *comp_data;
-- 
2.18.0

