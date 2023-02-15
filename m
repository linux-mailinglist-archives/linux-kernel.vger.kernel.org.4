Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5615C697657
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 07:27:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233098AbjBOG1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 01:27:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbjBOG1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 01:27:20 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E4FE34C32;
        Tue, 14 Feb 2023 22:27:01 -0800 (PST)
X-UUID: bdc2747aacf911eda06fc9ecc4dadd91-20230215
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=vUg60ZiSadtjnY2aJZUABOZJhEHAijhA6RbRthYA4cs=;
        b=TYoPDPX78TpEaSNRiTaQ1D/ewNb8rfu/gX3BsIAcNtKiD480aN5xckyBq+HSyf/AAz22I5zvghnlNUaQjn/wnBVRHlZKhO6UCt6mTCSy96uEjux+bCYXFYfhUhqmI8DhlsJAoFTeb/t1IWg2vVp1aN/2jtKNnvABNaM4smMfDpc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.19,REQID:c6a6102e-df73-494f-8a4b-f5da49f035ba,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:70
X-CID-INFO: VERSION:1.1.19,REQID:c6a6102e-df73-494f-8a4b-f5da49f035ba,IP:0,URL
        :0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTI
        ON:quarantine,TS:70
X-CID-META: VersionHash:885ddb2,CLOUDID:1d4d0df3-ddba-41c3-91d9-10eeade8eac7,B
        ulkID:230215142657KSW2D7GB,BulkQuantity:0,Recheck:0,SF:38|29|28|17|19|48,T
        C:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
        ,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-UUID: bdc2747aacf911eda06fc9ecc4dadd91-20230215
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 587395742; Wed, 15 Feb 2023 14:26:54 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 15 Feb 2023 14:26:53 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Wed, 15 Feb 2023 14:26:52 +0800
From:   Yong Wu <yong.wu@mediatek.com>
To:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Hans Verkuil <hverkuil@xs4all.nl>, <nfraprado@collabora.com>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        <mingyuan.ma@mediatek.com>, <yf.wang@mediatek.com>,
        <jianjiao.zeng@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        kyrie wu <kyrie.wu@mediatek.corp-partner.google.com>,
        <chengci.xu@mediatek.com>, <youlin.pei@mediatek.com>,
        <anan.sun@mediatek.com>, Yong Wu <yong.wu@mediatek.com>
Subject: [PATCH v4 05/11] iommu/mediatek: mt8192: Add iova_region_larb_msk
Date:   Wed, 15 Feb 2023 14:25:38 +0800
Message-ID: <20230215062544.8677-6-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230215062544.8677-1-yong.wu@mediatek.com>
References: <20230215062544.8677-1-yong.wu@mediatek.com>
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

Add iova_region_larb_msk for mt8192. We separate the 16GB iova regions
by each device's larbid/portid.
Note: larb3/6/8/10/12/15 connect nothing in this SoC.
Refer to the comment in include/dt-bindings/memory/mt8192-larb-port.h

Define a new macro MT8192_MULTI_REGION_NR_MAX to indicate
the index of mt8xxx_larb_region_msk and
"struct mtk_iommu_iova_region mt8192_multi_dom"
are the same.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 drivers/iommu/mtk_iommu.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 89a80982b7d1..710a3239fd3d 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -336,7 +336,12 @@ static const struct mtk_iommu_iova_region single_domain[] = {
 	{.iova_base = 0,		.size = SZ_4G},
 };
 
-static const struct mtk_iommu_iova_region mt8192_multi_dom[] = {
+#define MT8192_MULTI_REGION_NR_MAX	6
+
+#define MT8192_MULTI_REGION_NR	(IS_ENABLED(CONFIG_ARCH_DMA_ADDR_T_64BIT) ? \
+				 MT8192_MULTI_REGION_NR_MAX : 1)
+
+static const struct mtk_iommu_iova_region mt8192_multi_dom[MT8192_MULTI_REGION_NR] = {
 	{ .iova_base = 0x0,		.size = SZ_4G},		/* 0 ~ 4G */
 	#if IS_ENABLED(CONFIG_ARCH_DMA_ADDR_T_64BIT)
 	{ .iova_base = SZ_4G,		.size = SZ_4G},		/* 4G ~ 8G */
@@ -1538,6 +1543,17 @@ static const struct mtk_iommu_plat_data mt8186_data_mm = {
 	.iova_region_nr = ARRAY_SIZE(mt8192_multi_dom),
 };
 
+static const unsigned int mt8192_larb_region_msk[MT8192_MULTI_REGION_NR_MAX][MTK_LARB_NR_MAX] = {
+	[0] = {~0, ~0},				/* Region0: larb0/1 */
+	[1] = {0, 0, 0, 0, ~0, ~0, 0, ~0},	/* Region1: larb4/5/7 */
+	[2] = {0, 0, ~0, 0, 0, 0, 0, 0,		/* Region2: larb2/9/11/13/14/16/17/18/19/20 */
+	       0, ~0, 0, ~0, 0, ~(u32)(BIT(9) | BIT(10)), ~(u32)(BIT(4) | BIT(5)), 0,
+	       ~0, ~0, ~0, ~0, ~0},
+	[3] = {0},
+	[4] = {[13] = BIT(9) | BIT(10)},	/* larb13 port9/10 */
+	[5] = {[14] = BIT(4) | BIT(5)},		/* larb14 port4/5 */
+};
+
 static const struct mtk_iommu_plat_data mt8192_data = {
 	.m4u_plat       = M4U_MT8192,
 	.flags          = HAS_BCLK | HAS_SUB_COMM_2BITS | OUT_ORDER_WR_EN |
@@ -1547,6 +1563,7 @@ static const struct mtk_iommu_plat_data mt8192_data = {
 	.banks_enable   = {true},
 	.iova_region    = mt8192_multi_dom,
 	.iova_region_nr = ARRAY_SIZE(mt8192_multi_dom),
+	.iova_region_larb_msk = mt8192_larb_region_msk,
 	.larbid_remap   = {{0}, {1}, {4, 5}, {7}, {2}, {9, 11, 19, 20},
 			   {0, 14, 16}, {0, 13, 18, 17}},
 };
-- 
2.18.0

