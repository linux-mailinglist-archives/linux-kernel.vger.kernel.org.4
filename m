Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 895D56BE495
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 09:58:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231753AbjCQI6Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 04:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231420AbjCQI5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 04:57:50 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13EAC6701A;
        Fri, 17 Mar 2023 01:57:11 -0700 (PDT)
X-UUID: acae89dec4a111edbd2e61cc88cc8f98-20230317
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=GweuEuG2PaGFFKmMhTk46HUD9lCxrObeX2AFAEyHnIo=;
        b=tXxSBmQVsGWlXB+Q3zGc/5LrxkTNsz+Y3PFBH3M9X7qg0jUutEYy14G89bJJEEQRDFvJRj35CudUpyEURUt5innzAU4P+J2YjQVtKRlCgzoCfhWcFCIKI4hVM98WX4yH16vsEe399OMSrSB9q6qEp/UCdoi9BuJ0RWCgdaYdYg0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.21,REQID:518980fc-d0fc-4468-9eb7-fa2cb998617f,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-25
X-CID-META: VersionHash:83295aa,CLOUDID:6ba28eb3-beed-4dfc-bd9c-e1b22fa6ccc4,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: acae89dec4a111edbd2e61cc88cc8f98-20230317
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2113170903; Fri, 17 Mar 2023 16:56:58 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Fri, 17 Mar 2023 16:56:57 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Fri, 17 Mar 2023 16:56:56 +0800
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
Subject: [PATCH v9 4/7] iommu/mediatek: Add enable IOMMU SMC command for INFRA masters
Date:   Fri, 17 Mar 2023 16:55:38 +0800
Message-ID: <20230317085541.20447-5-yong.wu@mediatek.com>
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

Prepare for MT8188. In MT8188, the register which enables IOMMU for
INFRA masters are in the secure world for security concerns, therefore we
add a SMC command for INFRA masters to enable IOMMU in ATF.

Signed-off-by: Chengci.Xu <chengci.xu@mediatek.com>
Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 drivers/iommu/mtk_iommu.c  | 32 ++++++++++++++++++++++----------
 include/soc/mediatek/smi.h |  1 +
 2 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 7ba05fa58c20..afd690da61e3 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -3,6 +3,7 @@
  * Copyright (c) 2015-2016 MediaTek Inc.
  * Author: Yong Wu <yong.wu@mediatek.com>
  */
+#include <linux/arm-smccc.h>
 #include <linux/bitfield.h>
 #include <linux/bug.h>
 #include <linux/clk.h>
@@ -27,6 +28,7 @@
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/soc/mediatek/infracfg.h>
+#include <linux/soc/mediatek/mtk_sip_svc.h>
 #include <asm/barrier.h>
 #include <soc/mediatek/smi.h>
 
@@ -143,6 +145,7 @@
 #define PGTABLE_PA_35_EN		BIT(17)
 #define TF_PORT_TO_ADDR_MT8173		BIT(18)
 #define INT_ID_PORT_WIDTH_6		BIT(19)
+#define CFG_IFA_MASTER_IN_ATF		BIT(20)
 
 #define MTK_IOMMU_HAS_FLAG_MASK(pdata, _x, mask)	\
 				((((pdata)->flags) & (mask)) == (_x))
@@ -584,6 +587,7 @@ static int mtk_iommu_config(struct mtk_iommu_data *data, struct device *dev,
 	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 	const struct mtk_iommu_iova_region *region;
 	unsigned long portid_msk = 0;
+	struct arm_smccc_res res;
 	int i, ret = 0;
 
 	for (i = 0; i < fwspec->num_ids; ++i) {
@@ -609,17 +613,24 @@ static int mtk_iommu_config(struct mtk_iommu_data *data, struct device *dev,
 		else
 			larb_mmu->mmu &= ~portid_msk;
 	} else if (MTK_IOMMU_IS_TYPE(data->plat_data, MTK_IOMMU_TYPE_INFRA)) {
-		/* PCI dev has only one output id, enable the next writing bit for PCIe */
-		if (dev_is_pci(dev)) {
-			if (fwspec->num_ids != 1) {
-				dev_err(dev, "PCI dev can only have one port.\n");
-				return -ENODEV;
+		if (MTK_IOMMU_HAS_FLAG(data->plat_data, CFG_IFA_MASTER_IN_ATF)) {
+			arm_smccc_smc(MTK_SIP_KERNEL_IOMMU_CONTROL,
+				      IOMMU_ATF_CMD_CONFIG_INFRA_IOMMU,
+				      portid_msk, enable, 0, 0, 0, 0, &res);
+			ret = res.a0;
+		} else {
+			/* PCI dev has only one output id, enable the next writing bit for PCIe */
+			if (dev_is_pci(dev)) {
+				if (fwspec->num_ids != 1) {
+					dev_err(dev, "PCI dev can only have one port.\n");
+					return -ENODEV;
+				}
+				portid_msk |= BIT(portid + 1);
 			}
-			portid_msk |= BIT(portid + 1);
-		}
 
-		ret = regmap_update_bits(data->pericfg, PERICFG_IOMMU_1,
-					 (u32)portid_msk, enable ? (u32)portid_msk : 0);
+			ret = regmap_update_bits(data->pericfg, PERICFG_IOMMU_1,
+						 (u32)portid_msk, enable ? (u32)portid_msk : 0);
+		}
 		if (ret)
 			dev_err(dev, "%s iommu(%s) inframaster 0x%lx fail(%d).\n",
 				enable ? "enable" : "disable",
@@ -1317,7 +1328,8 @@ static int mtk_iommu_probe(struct platform_device *pdev)
 			dev_err_probe(dev, ret, "mm dts parse fail\n");
 			goto out_runtime_disable;
 		}
-	} else if (MTK_IOMMU_IS_TYPE(data->plat_data, MTK_IOMMU_TYPE_INFRA)) {
+	} else if (MTK_IOMMU_IS_TYPE(data->plat_data, MTK_IOMMU_TYPE_INFRA) &&
+		   !MTK_IOMMU_HAS_FLAG(data->plat_data, CFG_IFA_MASTER_IN_ATF)) {
 		p = data->plat_data->pericfg_comp_str;
 		data->pericfg = syscon_regmap_lookup_by_compatible(p);
 		if (IS_ERR(data->pericfg)) {
diff --git a/include/soc/mediatek/smi.h b/include/soc/mediatek/smi.h
index dfd8efca5e60..000eb1cf68b7 100644
--- a/include/soc/mediatek/smi.h
+++ b/include/soc/mediatek/smi.h
@@ -13,6 +13,7 @@
 
 enum iommu_atf_cmd {
 	IOMMU_ATF_CMD_CONFIG_SMI_LARB,		/* For mm master to en/disable iommu */
+	IOMMU_ATF_CMD_CONFIG_INFRA_IOMMU,	/* For infra master to enable iommu */
 	IOMMU_ATF_CMD_MAX,
 };
 
-- 
2.25.1

