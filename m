Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73C1D6D3FF4
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 11:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231934AbjDCJQG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 05:16:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231788AbjDCJPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 05:15:54 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C52741041C;
        Mon,  3 Apr 2023 02:15:38 -0700 (PDT)
X-UUID: 15f95b2ed20011edb6b9f13eb10bd0fe-20230403
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=4RaT+9nrF2MCl8+ZR9wc/aV9OmM6fg58sYHW4ls9iwI=;
        b=i62oMpUDIa2aojH9uM8O59O+SMCFnpg3088ZjrmCwSHCIxXmLkYBbfl7BmT1+1cjCTVzPyrbnO3/M32m3X2MbxqiBiuJR9riZ+bjFFhVrAkegH2bbpbGIUeIqjOMNLXIpSP13hgpMa13/g3SS3tt76VBMANju6csWcq5zswHEF0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:a3fdbc7b-da4a-4452-9a76-d387e2805f5f,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:70
X-CID-INFO: VERSION:1.1.22,REQID:a3fdbc7b-da4a-4452-9a76-d387e2805f5f,IP:0,URL
        :0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTI
        ON:quarantine,TS:70
X-CID-META: VersionHash:120426c,CLOUDID:0adb23b5-beed-4dfc-bd9c-e1b22fa6ccc4,B
        ulkID:230403171535EC9QO95N,BulkQuantity:0,Recheck:0,SF:38|29|28|17|19|48,T
        C:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
        ,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: 15f95b2ed20011edb6b9f13eb10bd0fe-20230403
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 481322176; Mon, 03 Apr 2023 17:15:32 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Mon, 3 Apr 2023 17:15:31 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Mon, 3 Apr 2023 17:15:30 +0800
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
Subject: [PATCH v6 08/14] iommu/mediatek: Add a gap for the iova regions
Date:   Mon, 3 Apr 2023 17:13:31 +0800
Message-ID: <20230403091337.26745-9-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230403091337.26745-1-yong.wu@mediatek.com>
References: <20230403091337.26745-1-yong.wu@mediatek.com>
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

As the removed property in the vcodec dt-binding, the property is:
dma-ranges = <0x1 0x0 0x0 0x40000000 0x0 0xfff00000>;

The length is 0xfff0_0000 rather than 0x1_0000_0000, this means it
requires 1M as a gap. This is because the end address for some vcodec
HW is (address + size). If the size is 4G, the end address may be
0x2_0000_0000, and the width for vcodec register only is 32, then the
HW may get the ZERO address.

Currently the consumer's dma-ranges property doesn't work, IOMMU
has to consider this case. Add a bigger gap(8M) for all the regions
to avoid it.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/iommu/mtk_iommu.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 2c2a64c1712a..0e104bb27010 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -332,8 +332,10 @@ static LIST_HEAD(m4ulist);	/* List all the M4U HWs */
 
 #define for_each_m4u(data, head)  list_for_each_entry(data, head, list)
 
+#define MTK_IOMMU_IOVA_SZ_4G		(SZ_4G - SZ_8M) /* 8M as gap */
+
 static const struct mtk_iommu_iova_region single_domain[] = {
-	{.iova_base = 0,		.size = SZ_4G},
+	{.iova_base = 0,		.size = MTK_IOMMU_IOVA_SZ_4G},
 };
 
 #define MT8192_MULTI_REGION_NR_MAX	6
@@ -342,11 +344,11 @@ static const struct mtk_iommu_iova_region single_domain[] = {
 				 MT8192_MULTI_REGION_NR_MAX : 1)
 
 static const struct mtk_iommu_iova_region mt8192_multi_dom[MT8192_MULTI_REGION_NR] = {
-	{ .iova_base = 0x0,		.size = SZ_4G},		/* 0 ~ 4G */
+	{ .iova_base = 0x0,		.size = MTK_IOMMU_IOVA_SZ_4G},	/* 0 ~ 4G,  */
 	#if IS_ENABLED(CONFIG_ARCH_DMA_ADDR_T_64BIT)
-	{ .iova_base = SZ_4G,		.size = SZ_4G},		/* 4G ~ 8G */
-	{ .iova_base = SZ_4G * 2,	.size = SZ_4G},		/* 8G ~ 12G */
-	{ .iova_base = SZ_4G * 3,	.size = SZ_4G},		/* 12G ~ 16G */
+	{ .iova_base = SZ_4G,		.size = MTK_IOMMU_IOVA_SZ_4G},	/* 4G ~ 8G */
+	{ .iova_base = SZ_4G * 2,	.size = MTK_IOMMU_IOVA_SZ_4G},	/* 8G ~ 12G */
+	{ .iova_base = SZ_4G * 3,	.size = MTK_IOMMU_IOVA_SZ_4G},	/* 12G ~ 16G */
 
 	{ .iova_base = 0x240000000ULL,	.size = 0x4000000},	/* CCU0 */
 	{ .iova_base = 0x244000000ULL,	.size = 0x4000000},	/* CCU1 */
-- 
2.25.1

