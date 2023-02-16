Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC237698C19
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 06:35:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbjBPFf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 00:35:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbjBPFf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 00:35:26 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36F2D46096;
        Wed, 15 Feb 2023 21:35:08 -0800 (PST)
X-UUID: a7bdfaecadbb11eda06fc9ecc4dadd91-20230216
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=LrqqZVczADf4UXxLULFwBwcdFJyfPBBKUZSijRZtoyk=;
        b=MlDTKuG4oQCkSsOoRT0CHi9Ya+0DK1C+NdyNaSqkmALKlIuapMvZdJZlyv8fW9VVhh/fak5nJ5oy0GZCbpFZfrr0FbDM+qVdsv3WxqUyxuRqQ9LCJ1fu6e8nQFhiyqdBvREZBILsJy4Jq9e2mK6Hqlj+wkzQ2IJ1u3PJF4fqLvM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.19,REQID:62d7e7ef-4aa7-4802-bb0b-5254b9a0c8e7,IP:0,U
        RL:0,TC:0,Content:-20,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-20
X-CID-META: VersionHash:885ddb2,CLOUDID:02059cb0-beed-4dfc-bd9c-e1b22fa6ccc4,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:1,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-UUID: a7bdfaecadbb11eda06fc9ecc4dadd91-20230216
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1678086085; Thu, 16 Feb 2023 13:35:00 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 16 Feb 2023 13:35:00 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Thu, 16 Feb 2023 13:34:59 +0800
From:   Yong Wu <yong.wu@mediatek.com>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Robin Murphy <robin.murphy@arm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Yong Wu <yong.wu@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, <iommu@lists.linux.dev>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <mingyuan.ma@mediatek.com>,
        <yf.wang@mediatek.com>, <jianjiao.zeng@mediatek.com>,
        <chengci.xu@mediatek.com>, <youlin.pei@mediatek.com>
Subject: [PATCH v7 6/6] iommu/mediatek: mt8188: Add iova_region_larb_msk
Date:   Thu, 16 Feb 2023 13:33:22 +0800
Message-ID: <20230216053322.11596-7-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230216053322.11596-1-yong.wu@mediatek.com>
References: <20230216053322.11596-1-yong.wu@mediatek.com>
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

Add iova_region_larb_msk for mt8188. We separate the 16GB iova regions
by each device's larbid/portid.
Refer to include/dt-bindings/memory/mediatek,mt8188-memory-port.h

Note: larb19(21) as commented in that h above, it means larb19 while its SW
index is 21.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 drivers/iommu/mtk_iommu.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index a3012fdc8f61..7dc7cd510a8b 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -1595,6 +1595,20 @@ static const struct mtk_iommu_plat_data mt8188_data_infra = {
 	.iova_region_nr   = ARRAY_SIZE(single_domain),
 };
 
+static const u32 mt8188_larb_region_msk[MT8192_MULTI_REGION_NR_MAX][MTK_LARB_NR_MAX] = {
+	[0] = {~0, ~0, ~0, ~0},               /* Region0: all ports for larb0/1/2/3 */
+	[1] = {0, 0, 0, 0, 0, 0, 0, 0,
+	       0, 0, 0, 0, 0, 0, 0, 0,
+	       0, 0, 0, 0, 0, ~0, ~0, ~0},    /* Region1: larb19(21)/21(22)/23 */
+	[2] = {0, 0, 0, 0, ~0, ~0, ~0, ~0,    /* Region2: the other larbs. */
+	       ~0, ~0, ~0, ~0, ~0, ~0, ~0, ~0,
+	       ~0, ~0, ~0, ~0, ~0, 0, 0, 0,
+	       0, ~0},
+	[3] = {0},
+	[4] = {[24] = BIT(0) | BIT(1)},       /* Only larb27(24) port0/1 */
+	[5] = {[24] = BIT(2) | BIT(3)},       /* Only larb27(24) port2/3 */
+};
+
 static const struct mtk_iommu_plat_data mt8188_data_vdo = {
 	.m4u_plat       = M4U_MT8188,
 	.flags          = HAS_BCLK | HAS_SUB_COMM_3BITS | OUT_ORDER_WR_EN |
@@ -1606,6 +1620,7 @@ static const struct mtk_iommu_plat_data mt8188_data_vdo = {
 	.banks_enable   = {true},
 	.iova_region    = mt8192_multi_dom,
 	.iova_region_nr = ARRAY_SIZE(mt8192_multi_dom),
+	.iova_region_larb_msk = mt8188_larb_region_msk,
 	.larbid_remap   = {{2}, {0}, {21}, {0}, {19}, {9, 10,
 			   11 /* 11a */, 25 /* 11c */},
 			   {13, 0, 29 /* 16b */, 30 /* 17b */, 0}, {5}},
@@ -1622,6 +1637,7 @@ static const struct mtk_iommu_plat_data mt8188_data_vpp = {
 	.banks_enable   = {true},
 	.iova_region    = mt8192_multi_dom,
 	.iova_region_nr = ARRAY_SIZE(mt8192_multi_dom),
+	.iova_region_larb_msk = mt8188_larb_region_msk,
 	.larbid_remap   = {{1}, {3}, {23}, {7}, {MTK_INVALID_LARBID},
 			   {12, 15, 24 /* 11b */}, {14, MTK_INVALID_LARBID,
 			   16 /* 16a */, 17 /* 17a */, MTK_INVALID_LARBID,
-- 
2.18.0

