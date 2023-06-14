Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90B1072F760
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 10:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243441AbjFNIGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 04:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243295AbjFNIGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 04:06:09 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAC51CD;
        Wed, 14 Jun 2023 01:06:07 -0700 (PDT)
X-UUID: 848325d00a8511eeb20a276fd37b9834-20230614
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=uJrhqEVUl+JgSBLetX8UvH1e137N/lC8nLdCIORzaaA=;
        b=awG1uaAsnrC88lwSiGndoYMzuUmOoeOiqMP0LnuZqnDy8SrIM2efB2S+1PPdmgf1nXF8N9edyh8Gd3LBEYdWUZFipjQXpAKmm+zjXR14upAhbjyec4GFUx2VrW4a45bpmWTvumD4vIDBYSmN/mPrRISLmEiSWgo/NSzZBDnLyE0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.26,REQID:ba35dae9-8c51-483f-9506-e721308de876,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:100
X-CID-INFO: VERSION:1.1.26,REQID:ba35dae9-8c51-483f-9506-e721308de876,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTIO
        N:quarantine,TS:100
X-CID-META: VersionHash:cb9a4e1,CLOUDID:4709076f-2f20-4998-991c-3b78627e4938,B
        ulkID:230614153147QTGSG2LF,BulkQuantity:0,Recheck:0,SF:17|19|48|38|29|28,T
        C:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
        ,OSI:0,OSA:0,AV:0,LES:1,SPR:NO
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_SDM,TF_CID_SPAM_ASC,TF_CID_SPAM_FAS,
        TF_CID_SPAM_FSD
X-UUID: 848325d00a8511eeb20a276fd37b9834-20230614
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <shawn.sung@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 271035284; Wed, 14 Jun 2023 15:31:46 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 14 Jun 2023 15:31:45 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 14 Jun 2023 15:31:45 +0800
From:   Hsiao Chien Sung <shawn.sung@mediatek.com>
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Singo Chang <singo.chang@mediatek.com>,
        Nancy Lin <nancy.lin@mediatek.com>,
        Jason-JH Lin <jason-jh.lin@mediatek.com>,
        Shawn Sung <shawn.sung@mediatek.com>
Subject: [PATCH v2 14/15] drm/mediatek: Improve compatibility of display driver
Date:   Wed, 14 Jun 2023 15:31:24 +0800
Message-ID: <20230614073125.17958-15-shawn.sung@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230614073125.17958-1-shawn.sung@mediatek.com>
References: <20230614073125.17958-1-shawn.sung@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- Check if the component is defined before using it since
  some modules are MT8188 only (ex. PADDING)
- Use a for-loop to add/remove components in an arrays,
  so we can only maintain this array to make sure every
  component will be initialized properly

Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.com>
---
 .../gpu/drm/mediatek/mtk_disp_ovl_adaptor.c   | 128 +++++++++++-------
 1 file changed, 78 insertions(+), 50 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c b/drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c
index c0a38f5217ee..a5f5a0f8ea85 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c
@@ -51,6 +51,7 @@ enum mtk_ovl_adaptor_comp_id {

 struct ovl_adaptor_comp_match {
 	enum mtk_ovl_adaptor_comp_type type;
+	enum mtk_ddp_comp_id comp_id;
 	int alias_id;
 };

@@ -67,19 +68,19 @@ static const char * const private_comp_stem[OVL_ADAPTOR_TYPE_NUM] = {
 };

 static const struct ovl_adaptor_comp_match comp_matches[OVL_ADAPTOR_ID_MAX] = {
-	[OVL_ADAPTOR_MDP_RDMA0]	= { OVL_ADAPTOR_TYPE_RDMA, 0 },
-	[OVL_ADAPTOR_MDP_RDMA1]	= { OVL_ADAPTOR_TYPE_RDMA, 1 },
-	[OVL_ADAPTOR_MDP_RDMA2]	= { OVL_ADAPTOR_TYPE_RDMA, 2 },
-	[OVL_ADAPTOR_MDP_RDMA3]	= { OVL_ADAPTOR_TYPE_RDMA, 3 },
-	[OVL_ADAPTOR_MDP_RDMA4]	= { OVL_ADAPTOR_TYPE_RDMA, 4 },
-	[OVL_ADAPTOR_MDP_RDMA5]	= { OVL_ADAPTOR_TYPE_RDMA, 5 },
-	[OVL_ADAPTOR_MDP_RDMA6]	= { OVL_ADAPTOR_TYPE_RDMA, 6 },
-	[OVL_ADAPTOR_MDP_RDMA7]	= { OVL_ADAPTOR_TYPE_RDMA, 7 },
-	[OVL_ADAPTOR_MERGE0]	= { OVL_ADAPTOR_TYPE_MERGE, 1 },
-	[OVL_ADAPTOR_MERGE1]	= { OVL_ADAPTOR_TYPE_MERGE, 2 },
-	[OVL_ADAPTOR_MERGE2]	= { OVL_ADAPTOR_TYPE_MERGE, 3 },
-	[OVL_ADAPTOR_MERGE3]	= { OVL_ADAPTOR_TYPE_MERGE, 4 },
-	[OVL_ADAPTOR_ETHDR0]	= { OVL_ADAPTOR_TYPE_ETHDR, 0 },
+	[OVL_ADAPTOR_MDP_RDMA0] = { OVL_ADAPTOR_TYPE_RDMA, DDP_COMPONENT_MDP_RDMA0, 0 },
+	[OVL_ADAPTOR_MDP_RDMA1] = { OVL_ADAPTOR_TYPE_RDMA, DDP_COMPONENT_MDP_RDMA1, 1 },
+	[OVL_ADAPTOR_MDP_RDMA2] = { OVL_ADAPTOR_TYPE_RDMA, DDP_COMPONENT_MDP_RDMA2, 2 },
+	[OVL_ADAPTOR_MDP_RDMA3] = { OVL_ADAPTOR_TYPE_RDMA, DDP_COMPONENT_MDP_RDMA3, 3 },
+	[OVL_ADAPTOR_MDP_RDMA4] = { OVL_ADAPTOR_TYPE_RDMA, DDP_COMPONENT_MDP_RDMA4, 4 },
+	[OVL_ADAPTOR_MDP_RDMA5] = { OVL_ADAPTOR_TYPE_RDMA, DDP_COMPONENT_MDP_RDMA5, 5 },
+	[OVL_ADAPTOR_MDP_RDMA6] = { OVL_ADAPTOR_TYPE_RDMA, DDP_COMPONENT_MDP_RDMA6, 6 },
+	[OVL_ADAPTOR_MDP_RDMA7] = { OVL_ADAPTOR_TYPE_RDMA, DDP_COMPONENT_MDP_RDMA7, 7 },
+	[OVL_ADAPTOR_MERGE0] = { OVL_ADAPTOR_TYPE_MERGE, DDP_COMPONENT_MERGE1, 1 },
+	[OVL_ADAPTOR_MERGE1] = { OVL_ADAPTOR_TYPE_MERGE, DDP_COMPONENT_MERGE2, 2 },
+	[OVL_ADAPTOR_MERGE2] = { OVL_ADAPTOR_TYPE_MERGE, DDP_COMPONENT_MERGE3, 3 },
+	[OVL_ADAPTOR_MERGE3] = { OVL_ADAPTOR_TYPE_MERGE, DDP_COMPONENT_MERGE4, 4 },
+	[OVL_ADAPTOR_ETHDR0] = { OVL_ADAPTOR_TYPE_ETHDR, DDP_COMPONENT_ETHDR_MIXER, 0 },
 };

 void mtk_ovl_adaptor_layer_config(struct device *dev, unsigned int idx,
@@ -192,6 +193,8 @@ int mtk_ovl_adaptor_clk_enable(struct device *dev)

 	for (i = 0; i < OVL_ADAPTOR_MERGE0; i++) {
 		comp = ovl_adaptor->ovl_adaptor_comp[i];
+		if (!comp)
+			continue;
 		ret = pm_runtime_get_sync(comp);
 		if (ret < 0) {
 			dev_err(dev, "Failed to enable power domain %d, err %d\n", i, ret);
@@ -202,12 +205,23 @@ int mtk_ovl_adaptor_clk_enable(struct device *dev)
 	for (i = 0; i < OVL_ADAPTOR_ID_MAX; i++) {
 		comp = ovl_adaptor->ovl_adaptor_comp[i];

-		if (i < OVL_ADAPTOR_MERGE0)
+		if (!comp)
+			continue;
+
+		switch (comp_matches[i].type) {
+		case OVL_ADAPTOR_TYPE_RDMA:
 			ret = mtk_mdp_rdma_clk_enable(comp);
-		else if (i < OVL_ADAPTOR_ETHDR0)
+			break;
+		case OVL_ADAPTOR_TYPE_MERGE:
 			ret = mtk_merge_clk_enable(comp);
-		else
+			break;
+		case OVL_ADAPTOR_TYPE_ETHDR:
 			ret = mtk_ethdr_clk_enable(comp);
+			break;
+		default:
+			dev_err(dev, "Unknown type: %d\n", comp_matches[i].type);
+		}
+
 		if (ret) {
 			dev_err(dev, "Failed to enable clock %d, err %d\n", i, ret);
 			goto clk_err;
@@ -219,18 +233,33 @@ int mtk_ovl_adaptor_clk_enable(struct device *dev)
 clk_err:
 	while (--i >= 0) {
 		comp = ovl_adaptor->ovl_adaptor_comp[i];
-		if (i < OVL_ADAPTOR_MERGE0)
+
+		if (!comp)
+			continue;
+
+		switch (comp_matches[i].type) {
+		case OVL_ADAPTOR_TYPE_RDMA:
 			mtk_mdp_rdma_clk_disable(comp);
-		else if (i < OVL_ADAPTOR_ETHDR0)
+			break;
+		case OVL_ADAPTOR_TYPE_MERGE:
 			mtk_merge_clk_disable(comp);
-		else
+			break;
+		case OVL_ADAPTOR_TYPE_ETHDR:
 			mtk_ethdr_clk_disable(comp);
+			break;
+		default:
+			dev_err(dev, "Unknown type: %d\n", comp_matches[i].type);
+		}
 	}
 	i = OVL_ADAPTOR_MERGE0;

 pwr_err:
-	while (--i >= 0)
-		pm_runtime_put(ovl_adaptor->ovl_adaptor_comp[i]);
+	while (--i >= 0) {
+		comp = ovl_adaptor->ovl_adaptor_comp[i];
+		if (!comp)
+			continue;
+		pm_runtime_put(comp);
+	}

 	return ret;
 }
@@ -244,13 +273,22 @@ void mtk_ovl_adaptor_clk_disable(struct device *dev)
 	for (i = 0; i < OVL_ADAPTOR_ID_MAX; i++) {
 		comp = ovl_adaptor->ovl_adaptor_comp[i];

-		if (i < OVL_ADAPTOR_MERGE0) {
+		if (!comp)
+			continue;
+
+		switch (comp_matches[i].type) {
+		case OVL_ADAPTOR_TYPE_RDMA:
 			mtk_mdp_rdma_clk_disable(comp);
 			pm_runtime_put(comp);
-		} else if (i < OVL_ADAPTOR_ETHDR0) {
+			break;
+		case OVL_ADAPTOR_TYPE_MERGE:
 			mtk_merge_clk_disable(comp);
-		} else {
+			break;
+		case OVL_ADAPTOR_TYPE_ETHDR:
 			mtk_ethdr_clk_disable(comp);
+			break;
+		default:
+			dev_err(dev, "Unknown type: %d\n", comp_matches[i].type);
 		}
 	}
 }
@@ -313,36 +351,26 @@ size_t mtk_ovl_adaptor_get_num_formats(struct device *dev)

 void mtk_ovl_adaptor_add_comp(struct device *dev, struct mtk_mutex *mutex)
 {
-	mtk_mutex_add_comp(mutex, DDP_COMPONENT_MDP_RDMA0);
-	mtk_mutex_add_comp(mutex, DDP_COMPONENT_MDP_RDMA1);
-	mtk_mutex_add_comp(mutex, DDP_COMPONENT_MDP_RDMA2);
-	mtk_mutex_add_comp(mutex, DDP_COMPONENT_MDP_RDMA3);
-	mtk_mutex_add_comp(mutex, DDP_COMPONENT_MDP_RDMA4);
-	mtk_mutex_add_comp(mutex, DDP_COMPONENT_MDP_RDMA5);
-	mtk_mutex_add_comp(mutex, DDP_COMPONENT_MDP_RDMA6);
-	mtk_mutex_add_comp(mutex, DDP_COMPONENT_MDP_RDMA7);
-	mtk_mutex_add_comp(mutex, DDP_COMPONENT_MERGE1);
-	mtk_mutex_add_comp(mutex, DDP_COMPONENT_MERGE2);
-	mtk_mutex_add_comp(mutex, DDP_COMPONENT_MERGE3);
-	mtk_mutex_add_comp(mutex, DDP_COMPONENT_MERGE4);
-	mtk_mutex_add_comp(mutex, DDP_COMPONENT_ETHDR_MIXER);
+	struct mtk_disp_ovl_adaptor *ovl_adaptor = dev_get_drvdata(dev);
+	int i;
+
+	for (i = 0; i < OVL_ADAPTOR_ID_MAX; i++) {
+		if (!ovl_adaptor->ovl_adaptor_comp[i])
+			continue;
+		mtk_mutex_add_comp(mutex, comp_matches[i].comp_id);
+	}
 }

 void mtk_ovl_adaptor_remove_comp(struct device *dev, struct mtk_mutex *mutex)
 {
-	mtk_mutex_remove_comp(mutex, DDP_COMPONENT_MDP_RDMA0);
-	mtk_mutex_remove_comp(mutex, DDP_COMPONENT_MDP_RDMA1);
-	mtk_mutex_remove_comp(mutex, DDP_COMPONENT_MDP_RDMA2);
-	mtk_mutex_remove_comp(mutex, DDP_COMPONENT_MDP_RDMA3);
-	mtk_mutex_remove_comp(mutex, DDP_COMPONENT_MDP_RDMA4);
-	mtk_mutex_remove_comp(mutex, DDP_COMPONENT_MDP_RDMA5);
-	mtk_mutex_remove_comp(mutex, DDP_COMPONENT_MDP_RDMA6);
-	mtk_mutex_remove_comp(mutex, DDP_COMPONENT_MDP_RDMA7);
-	mtk_mutex_remove_comp(mutex, DDP_COMPONENT_MERGE1);
-	mtk_mutex_remove_comp(mutex, DDP_COMPONENT_MERGE2);
-	mtk_mutex_remove_comp(mutex, DDP_COMPONENT_MERGE3);
-	mtk_mutex_remove_comp(mutex, DDP_COMPONENT_MERGE4);
-	mtk_mutex_remove_comp(mutex, DDP_COMPONENT_ETHDR_MIXER);
+	struct mtk_disp_ovl_adaptor *ovl_adaptor = dev_get_drvdata(dev);
+	int i;
+
+	for (i = 0; i < OVL_ADAPTOR_ID_MAX; i++) {
+		if (!ovl_adaptor->ovl_adaptor_comp[i])
+			continue;
+		mtk_mutex_remove_comp(mutex, comp_matches[i].comp_id);
+	}
 }

 void mtk_ovl_adaptor_connect(struct device *dev, struct device *mmsys_dev, unsigned int next)
--
2.18.0

