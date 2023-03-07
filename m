Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EC156AD8B2
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 09:07:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbjCGIHt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 03:07:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbjCGIHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 03:07:46 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6239D8A3BF;
        Tue,  7 Mar 2023 00:07:14 -0800 (PST)
X-UUID: 0f0d1f40bcbf11ed945fc101203acc17-20230307
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=0LyV4s2Ok5yqN5N3ONlx6sK/lj9z+lC8NLJq3hQ7ebs=;
        b=J55vboQO6j6jLoiNlKt6ua2xDmeBzoyczLyHayi9hSHHP6VmIEr7vgvkXKi1WHZwXOoDljVMpjuCI8giSBPscl+JN72WHIZTOXOUxgnwdOy3z6dvw+802qrxZKRKfJmEK7Oz776cQYadk3SKo2tHTaL1fX0hiqlxTxhcWogwL9g=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.20,REQID:91fff596-18ab-4ecc-9a92-ae9923ad3e1a,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:25b5999,CLOUDID:057b74b2-beed-4dfc-bd9c-e1b22fa6ccc4,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-UUID: 0f0d1f40bcbf11ed945fc101203acc17-20230307
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1117787136; Tue, 07 Mar 2023 16:07:09 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Tue, 7 Mar 2023 16:07:08 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Tue, 7 Mar 2023 16:07:07 +0800
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
Subject: [PATCH v8 4/7] iommu/mediatek: Adjust mtk_iommu_config flow
Date:   Tue, 7 Mar 2023 16:05:52 +0800
Message-ID: <20230307080555.14399-5-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230307080555.14399-1-yong.wu@mediatek.com>
References: <20230307080555.14399-1-yong.wu@mediatek.com>
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

For reduce indention without functional change, prepare for MT8188.
If there are many ports in a same larb, current flow will update
larb_mmu->mmu or update INFRA register for too many times.
So we save all ports to portid_msk in the front of mtk_iommu_config(),
and then update only once for IOMMU configure. By this modification,
we can prevent MT8188 from sending to many SMC calls, avoiding enter
ATF for each port.

Signed-off-by: Chengci.Xu <chengci.xu@mediatek.com>
Reviewed-by: Yong Wu <yong.wu@mediatek.com>
---
 drivers/iommu/mtk_iommu.c | 58 +++++++++++++++++++++------------------
 1 file changed, 32 insertions(+), 26 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 1bdb0e0022a8..b125e9211a3e 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -583,41 +583,47 @@ static int mtk_iommu_config(struct mtk_iommu_data *data, struct device *dev,
 	unsigned int                 larbid, portid;
 	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 	const struct mtk_iommu_iova_region *region;
-	u32 peri_mmuen, peri_mmuen_msk;
+	unsigned long portid_msk = 0;
 	int i, ret = 0;
 
 	for (i = 0; i < fwspec->num_ids; ++i) {
-		larbid = MTK_M4U_TO_LARB(fwspec->ids[i]);
 		portid = MTK_M4U_TO_PORT(fwspec->ids[i]);
+		portid_msk |= BIT(portid);
+	}
 
-		if (MTK_IOMMU_IS_TYPE(data->plat_data, MTK_IOMMU_TYPE_MM)) {
-			larb_mmu = &data->larb_imu[larbid];
+	if (MTK_IOMMU_IS_TYPE(data->plat_data, MTK_IOMMU_TYPE_MM)) {
+		/* All ports should be in the same larb. just use 0 here */
+		larbid = MTK_M4U_TO_LARB(fwspec->ids[0]);
+		larb_mmu = &data->larb_imu[larbid];
+		region = data->plat_data->iova_region + regionid;
 
-			region = data->plat_data->iova_region + regionid;
+		for_each_set_bit(portid, &portid_msk, 32)
 			larb_mmu->bank[portid] = upper_32_bits(region->iova_base);
 
-			dev_dbg(dev, "%s iommu for larb(%s) port %d region %d rgn-bank %d.\n",
-				enable ? "enable" : "disable", dev_name(larb_mmu->dev),
-				portid, regionid, larb_mmu->bank[portid]);
-
-			if (enable)
-				larb_mmu->mmu |= MTK_SMI_MMU_EN(portid);
-			else
-				larb_mmu->mmu &= ~MTK_SMI_MMU_EN(portid);
-		} else if (MTK_IOMMU_IS_TYPE(data->plat_data, MTK_IOMMU_TYPE_INFRA)) {
-			peri_mmuen_msk = BIT(portid);
-			/* PCI dev has only one output id, enable the next writing bit for PCIe */
-			if (dev_is_pci(dev))
-				peri_mmuen_msk |= BIT(portid + 1);
-
-			peri_mmuen = enable ? peri_mmuen_msk : 0;
-			ret = regmap_update_bits(data->pericfg, PERICFG_IOMMU_1,
-						 peri_mmuen_msk, peri_mmuen);
-			if (ret)
-				dev_err(dev, "%s iommu(%s) inframaster 0x%x fail(%d).\n",
-					enable ? "enable" : "disable",
-					dev_name(data->dev), peri_mmuen_msk, ret);
+		dev_dbg(dev, "%s iommu for larb(%s) port 0x%lx region %d rgn-bank %d.\n",
+			enable ? "enable" : "disable", dev_name(larb_mmu->dev),
+			portid_msk, regionid, upper_32_bits(region->iova_base));
+
+		if (enable)
+			larb_mmu->mmu |= portid_msk;
+		else
+			larb_mmu->mmu &= ~portid_msk;
+	} else if (MTK_IOMMU_IS_TYPE(data->plat_data, MTK_IOMMU_TYPE_INFRA)) {
+		/* PCI dev has only one output id, enable the next writing bit for PCIe */
+		if (dev_is_pci(dev)) {
+			if (fwspec->num_ids != 1) {
+				dev_err(dev, "PCI dev can only have one port.\n");
+				return -ENODEV;
+			}
+			portid_msk |= BIT(portid + 1);
 		}
+
+		ret = regmap_update_bits(data->pericfg, PERICFG_IOMMU_1,
+					 (u32)portid_msk, enable ? (u32)portid_msk : 0);
+		if (ret)
+			dev_err(dev, "%s iommu(%s) inframaster 0x%lx fail(%d).\n",
+				enable ? "enable" : "disable",
+				dev_name(data->dev), portid_msk, ret);
 	}
 	return ret;
 }
-- 
2.25.1

