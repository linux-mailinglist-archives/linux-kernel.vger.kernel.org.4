Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 541A969765A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 07:27:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233243AbjBOG1i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 01:27:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233245AbjBOG1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 01:27:35 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F4A735244;
        Tue, 14 Feb 2023 22:27:13 -0800 (PST)
X-UUID: c4b50cf2acf911eda06fc9ecc4dadd91-20230215
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=hwGBTMOVQ2wBigdtMArkLUWDMnuEE+1K/VPuqH+/3SA=;
        b=i2max/JTcrMfBSr6AfvMytccovNkuaVcddVYW4yWWZQnDDJlnWJFEePXW7XiccEY9Sq7Qe38m1EsBW+lMKPIDko7uiY1s5Ek2gFLRyVfTNSNFzeGpY26rB/sR2w7B6WJ8Ody71CsZSm6M+0Ymt0yJ6iHRHZq086nycEJJCgP8nU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.19,REQID:51f5adab-e7d2-4f23-ab11-775c5f2cb843,IP:0,U
        RL:0,TC:0,Content:-20,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:75
X-CID-INFO: VERSION:1.1.19,REQID:51f5adab-e7d2-4f23-ab11-775c5f2cb843,IP:0,URL
        :0,TC:0,Content:-20,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTI
        ON:quarantine,TS:75
X-CID-META: VersionHash:885ddb2,CLOUDID:3d4f0df3-ddba-41c3-91d9-10eeade8eac7,B
        ulkID:2302151427098GXQP203,BulkQuantity:0,Recheck:0,SF:38|29|28|17|19|48,T
        C:nil,Content:1,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
        ,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-UUID: c4b50cf2acf911eda06fc9ecc4dadd91-20230215
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 544965444; Wed, 15 Feb 2023 14:27:06 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.194) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 15 Feb 2023 14:27:05 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Wed, 15 Feb 2023 14:27:04 +0800
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
Subject: [PATCH v4 06/11] iommu/mediatek: mt8195: Add iova_region_larb_msk
Date:   Wed, 15 Feb 2023 14:25:39 +0800
Message-ID: <20230215062544.8677-7-yong.wu@mediatek.com>
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

Add iova_region_larb_msk for mt8195. We separate the 16GB iova regions
by each device's larbid/portid.
Refer to include/dt-bindings/memory/mt8195-memory-port.h

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 drivers/iommu/mtk_iommu.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 710a3239fd3d..0e387345e1c3 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -1583,6 +1583,21 @@ static const struct mtk_iommu_plat_data mt8195_data_infra = {
 	.iova_region_nr   = ARRAY_SIZE(single_domain),
 };
 
+static const unsigned int mt8195_larb_region_msk[MT8192_MULTI_REGION_NR_MAX][MTK_LARB_NR_MAX] = {
+	[0] = {~0, ~0, ~0, ~0},               /* Region0: all ports for larb0/1/2/3 */
+	[1] = {0, 0, 0, 0, 0, 0, 0, 0,
+	       0, 0, 0, 0, 0, 0, 0, 0,
+	       0, 0, 0, ~0, ~0, ~0, ~0, ~0,   /* Region1: larb19/20/21/22/23/24 */
+	       ~0},
+	[2] = {0, 0, 0, 0, ~0, ~0, ~0, ~0,    /* Region2: the other larbs. */
+	       ~0, ~0, ~0, ~0, ~0, ~0, ~0, ~0,
+	       ~0, ~0, 0, 0, 0, 0, 0, 0,
+	       0, ~0, ~0, ~0, ~0},
+	[3] = {0},
+	[4] = {[18] = BIT(0) | BIT(1)},       /* Only larb18 port0/1 */
+	[5] = {[18] = BIT(2) | BIT(3)},       /* Only larb18 port2/3 */
+};
+
 static const struct mtk_iommu_plat_data mt8195_data_vdo = {
 	.m4u_plat	= M4U_MT8195,
 	.flags          = HAS_BCLK | HAS_SUB_COMM_2BITS | OUT_ORDER_WR_EN |
@@ -1593,6 +1608,7 @@ static const struct mtk_iommu_plat_data mt8195_data_vdo = {
 	.banks_enable   = {true},
 	.iova_region	= mt8192_multi_dom,
 	.iova_region_nr	= ARRAY_SIZE(mt8192_multi_dom),
+	.iova_region_larb_msk = mt8195_larb_region_msk,
 	.larbid_remap   = {{2, 0}, {21}, {24}, {7}, {19}, {9, 10, 11},
 			   {13, 17, 15/* 17b */, 25}, {5}},
 };
@@ -1607,6 +1623,7 @@ static const struct mtk_iommu_plat_data mt8195_data_vpp = {
 	.banks_enable   = {true},
 	.iova_region	= mt8192_multi_dom,
 	.iova_region_nr	= ARRAY_SIZE(mt8192_multi_dom),
+	.iova_region_larb_msk = mt8195_larb_region_msk,
 	.larbid_remap   = {{1}, {3},
 			   {22, MTK_INVALID_LARBID, MTK_INVALID_LARBID, MTK_INVALID_LARBID, 23},
 			   {8}, {20}, {12},
-- 
2.18.0

