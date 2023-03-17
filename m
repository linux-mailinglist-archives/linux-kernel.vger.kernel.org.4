Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB886BE49A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 09:58:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231622AbjCQI6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 04:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231434AbjCQI6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 04:58:14 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 039319FE61;
        Fri, 17 Mar 2023 01:57:19 -0700 (PDT)
X-UUID: b10538e8c4a111ed91027fb02e0f1d65-20230317
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=/tTJ+DgyYAMj0f30f3PxU0dDXmhWcITaA4cDFW0eiuU=;
        b=OUaiKgeyGMjA2sveBWSPgZJILJ+LQEFOrqZ7HoHYBTECkVTCIuxVj/ZlT/NSuy9cDbDiryumFfKfsgWhxs2rwSJWIrLlse7ZOmNObWQ4ItxODOqCYMGkwqE7GFS2Gr+MqdfYw/EsAiN87JzPiUNKHxfw70ObBwRVxlCpAaDgs0w=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.21,REQID:90a0aab5-ceda-4918-9d8b-b57310d560b7,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:83295aa,CLOUDID:10c2ad28-564d-42d9-9875-7c868ee415ec,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: b10538e8c4a111ed91027fb02e0f1d65-20230317
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1655158600; Fri, 17 Mar 2023 16:57:05 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Fri, 17 Mar 2023 16:57:05 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Fri, 17 Mar 2023 16:57:04 +0800
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
        <chengci.xu@mediatek.com>
Subject: [PATCH v9 5/7] iommu/mediatek: Add MT8188 IOMMU Support
Date:   Fri, 17 Mar 2023 16:55:39 +0800
Message-ID: <20230317085541.20447-6-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230317085541.20447-1-yong.wu@mediatek.com>
References: <20230317085541.20447-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Chengci.Xu" <chengci.xu@mediatek.com>

MT8188 has 3 IOMMU, containing 2 MM IOMMUs, one is for vdo, the other
is for vpp. and 1 INFRA IOMMU.

Signed-off-by: Chengci.Xu <chengci.xu@mediatek.com>
Signed-off-by: Yong Wu <yong.wu@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/iommu/mtk_iommu.c | 49 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index afd690da61e3..a3012fdc8f61 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -170,6 +170,7 @@ enum mtk_iommu_plat {
 	M4U_MT8173,
 	M4U_MT8183,
 	M4U_MT8186,
+	M4U_MT8188,
 	M4U_MT8192,
 	M4U_MT8195,
 	M4U_MT8365,
@@ -1582,6 +1583,51 @@ static const struct mtk_iommu_plat_data mt8186_data_mm = {
 	.iova_region_larb_msk = mt8186_larb_region_msk,
 };
 
+static const struct mtk_iommu_plat_data mt8188_data_infra = {
+	.m4u_plat         = M4U_MT8188,
+	.flags            = WR_THROT_EN | DCM_DISABLE | STD_AXI_MODE | PM_CLK_AO |
+			    MTK_IOMMU_TYPE_INFRA | IFA_IOMMU_PCIE_SUPPORT |
+			    PGTABLE_PA_35_EN | CFG_IFA_MASTER_IN_ATF,
+	.inv_sel_reg      = REG_MMU_INV_SEL_GEN2,
+	.banks_num        = 1,
+	.banks_enable     = {true},
+	.iova_region      = single_domain,
+	.iova_region_nr   = ARRAY_SIZE(single_domain),
+};
+
+static const struct mtk_iommu_plat_data mt8188_data_vdo = {
+	.m4u_plat       = M4U_MT8188,
+	.flags          = HAS_BCLK | HAS_SUB_COMM_3BITS | OUT_ORDER_WR_EN |
+			  WR_THROT_EN | IOVA_34_EN | SHARE_PGTABLE |
+			  PGTABLE_PA_35_EN | MTK_IOMMU_TYPE_MM,
+	.hw_list        = &m4ulist,
+	.inv_sel_reg    = REG_MMU_INV_SEL_GEN2,
+	.banks_num      = 1,
+	.banks_enable   = {true},
+	.iova_region    = mt8192_multi_dom,
+	.iova_region_nr = ARRAY_SIZE(mt8192_multi_dom),
+	.larbid_remap   = {{2}, {0}, {21}, {0}, {19}, {9, 10,
+			   11 /* 11a */, 25 /* 11c */},
+			   {13, 0, 29 /* 16b */, 30 /* 17b */, 0}, {5}},
+};
+
+static const struct mtk_iommu_plat_data mt8188_data_vpp = {
+	.m4u_plat       = M4U_MT8188,
+	.flags          = HAS_BCLK | HAS_SUB_COMM_3BITS | OUT_ORDER_WR_EN |
+			  WR_THROT_EN | IOVA_34_EN | SHARE_PGTABLE |
+			  PGTABLE_PA_35_EN | MTK_IOMMU_TYPE_MM,
+	.hw_list        = &m4ulist,
+	.inv_sel_reg    = REG_MMU_INV_SEL_GEN2,
+	.banks_num      = 1,
+	.banks_enable   = {true},
+	.iova_region    = mt8192_multi_dom,
+	.iova_region_nr = ARRAY_SIZE(mt8192_multi_dom),
+	.larbid_remap   = {{1}, {3}, {23}, {7}, {MTK_INVALID_LARBID},
+			   {12, 15, 24 /* 11b */}, {14, MTK_INVALID_LARBID,
+			   16 /* 16a */, 17 /* 17a */, MTK_INVALID_LARBID,
+			   27, 28 /* ccu0 */, MTK_INVALID_LARBID}, {4, 6}},
+};
+
 static const unsigned int mt8192_larb_region_msk[MT8192_MULTI_REGION_NR_MAX][MTK_LARB_NR_MAX] = {
 	[0] = {~0, ~0},				/* Region0: larb0/1 */
 	[1] = {0, 0, 0, 0, ~0, ~0, 0, ~0},	/* Region1: larb4/5/7 */
@@ -1690,6 +1736,9 @@ static const struct of_device_id mtk_iommu_of_ids[] = {
 	{ .compatible = "mediatek,mt8173-m4u", .data = &mt8173_data},
 	{ .compatible = "mediatek,mt8183-m4u", .data = &mt8183_data},
 	{ .compatible = "mediatek,mt8186-iommu-mm",    .data = &mt8186_data_mm}, /* mm: m4u */
+	{ .compatible = "mediatek,mt8188-iommu-infra", .data = &mt8188_data_infra},
+	{ .compatible = "mediatek,mt8188-iommu-vdo",   .data = &mt8188_data_vdo},
+	{ .compatible = "mediatek,mt8188-iommu-vpp",   .data = &mt8188_data_vpp},
 	{ .compatible = "mediatek,mt8192-m4u", .data = &mt8192_data},
 	{ .compatible = "mediatek,mt8195-iommu-infra", .data = &mt8195_data_infra},
 	{ .compatible = "mediatek,mt8195-iommu-vdo",   .data = &mt8195_data_vdo},
-- 
2.25.1

