Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93F306DD6DB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 11:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbjDKJd7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 05:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbjDKJdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 05:33:46 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96C653C0C;
        Tue, 11 Apr 2023 02:33:25 -0700 (PDT)
X-UUID: e500594ed84b11edb6b9f13eb10bd0fe-20230411
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=5TzwrGm8MDwxREZVxNarlcOBJfzC0Abb3wd33GfWDz4=;
        b=bbcKZviRCE/rngFKkW2wzWlxn2bIiMkH5VibDZQXrFShmDuq1yyjdO+0jKURP2R/8OzejPCD0p/kzQLC6pIgNzT1Ys/Nr1n/ARt2mDw6nl1OsQ2ViBkZxtsIFEPmLlLDZ0rURF++Ms9ePaDnCaBLRlOKDL1t2PPxEnoLpt4D0G8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:6d6a3152-5f04-4de4-98af-b546c7d22f17,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-25
X-CID-META: VersionHash:120426c,CLOUDID:8d0995ea-db6f-41fe-8b83-13fe7ed1ef52,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: e500594ed84b11edb6b9f13eb10bd0fe-20230411
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1731459184; Tue, 11 Apr 2023 17:33:19 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Tue, 11 Apr 2023 17:33:18 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Tue, 11 Apr 2023 17:33:17 +0800
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
        "AngeloGioacchino Del Regno" 
        <angelogioacchino.delregno@collabora.com>,
        <mingyuan.ma@mediatek.com>, <yf.wang@mediatek.com>,
        <jianjiao.zeng@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        kyrie wu <kyrie.wu@mediatek.corp-partner.google.com>,
        <chengci.xu@mediatek.com>, <youlin.pei@mediatek.com>,
        <anan.sun@mediatek.com>, Yong Wu <yong.wu@mediatek.com>
Subject: [PATCH v7 07/14] iommu/mediatek: mt8186: Add iova_region_larb_msk
Date:   Tue, 11 Apr 2023 17:31:37 +0800
Message-ID: <20230411093144.2690-8-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230411093144.2690-1-yong.wu@mediatek.com>
References: <20230411093144.2690-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add iova_region_larb_msk for mt8186. We separate the 16GB iova regions
by each device's larbid/portid.
Note: larb5/6/10/12/14/15/18 connect nothing in this SoC.
Refer to include/dt-bindings/memory/mt8186-memory-port.h

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/iommu/mtk_iommu.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index bb3734378934..2c2a64c1712a 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -1525,6 +1525,18 @@ static const struct mtk_iommu_plat_data mt8183_data = {
 	.larbid_remap = {{0}, {4}, {5}, {6}, {7}, {2}, {3}, {1}},
 };
 
+static const unsigned int mt8186_larb_region_msk[MT8192_MULTI_REGION_NR_MAX][MTK_LARB_NR_MAX] = {
+	[0] = {~0, ~0, ~0},			/* Region0: all ports for larb0/1/2 */
+	[1] = {0, 0, 0, 0, ~0, 0, 0, ~0},	/* Region1: larb4/7 */
+	[2] = {0, 0, 0, 0, 0, 0, 0, 0,		/* Region2: larb8/9/11/13/16/17/19/20 */
+	       ~0, ~0, 0, ~0, 0, ~(u32)(BIT(9) | BIT(10)), 0, 0,
+						/* larb13: the other ports except port9/10 */
+	       ~0, ~0, 0, ~0, ~0},
+	[3] = {0},
+	[4] = {[13] = BIT(9) | BIT(10)},	/* larb13 port9/10 */
+	[5] = {[14] = ~0},			/* larb14 */
+};
+
 static const struct mtk_iommu_plat_data mt8186_data_mm = {
 	.m4u_plat       = M4U_MT8186,
 	.flags          = HAS_BCLK | HAS_SUB_COMM_2BITS | OUT_ORDER_WR_EN |
@@ -1537,6 +1549,7 @@ static const struct mtk_iommu_plat_data mt8186_data_mm = {
 	.banks_enable   = {true},
 	.iova_region    = mt8192_multi_dom,
 	.iova_region_nr = ARRAY_SIZE(mt8192_multi_dom),
+	.iova_region_larb_msk = mt8186_larb_region_msk,
 };
 
 static const unsigned int mt8192_larb_region_msk[MT8192_MULTI_REGION_NR_MAX][MTK_LARB_NR_MAX] = {
-- 
2.25.1

