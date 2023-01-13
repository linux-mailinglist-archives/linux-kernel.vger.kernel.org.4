Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C3BC668C3B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 07:09:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240087AbjAMGHf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 01:07:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236012AbjAMGGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 01:06:17 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CB343FC97;
        Thu, 12 Jan 2023 22:02:52 -0800 (PST)
X-UUID: e79d87be930711eda06fc9ecc4dadd91-20230113
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=DFsuhxifPJ5NkfdPSqcg9Hc4XkiR3ME/aGtx7Ql1sCM=;
        b=tBJbkkepeQ+eAqPilSQ6cS6SzYfleFlx1+4oBrbRKtOQcm07nvCCqgL/KphZv3YlMxMkAwZIr+84fIbEzONqZkiNNAtYuJkid+U/jMS6490r9hfn+HpA6hY0pXxiBNPPe6vfm6sUYtzXgAag/wCOUFdKg0NS+MqIIdTNxMp6bcY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.17,REQID:7b68aff6-3233-4dbc-8a04-c02374df064d,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:90
X-CID-INFO: VERSION:1.1.17,REQID:7b68aff6-3233-4dbc-8a04-c02374df064d,IP:0,URL
        :0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTIO
        N:quarantine,TS:90
X-CID-META: VersionHash:543e81c,CLOUDID:12f38a54-dd49-462e-a4be-2143a3ddc739,B
        ulkID:230113140248TUZ060FY,BulkQuantity:0,Recheck:0,SF:38|28|17|19|48,TC:n
        il,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OS
        I:0,OSA:0
X-CID-APTURL: Status:success,Category:nil,Trust:0,Unknown:0,Malicious:0
X-CID-BVR: 0
X-UUID: e79d87be930711eda06fc9ecc4dadd91-20230113
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 681829711; Fri, 13 Jan 2023 14:02:47 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Fri, 13 Jan 2023 14:02:46 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Fri, 13 Jan 2023 14:02:45 +0800
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
        <libo.kang@mediatek.com>, Yunfei Dong <yunfei.dong@mediatek.com>,
        kyrie wu <kyrie.wu@mediatek.corp-partner.google.com>,
        <chengci.xu@mediatek.com>, <youlin.pei@mediatek.com>,
        <anan.sun@mediatek.com>, Yong Wu <yong.wu@mediatek.com>
Subject: [PATCH 05/10] iommu/mediatek: mt8186: add larb_region_msk
Date:   Fri, 13 Jan 2023 14:01:28 +0800
Message-ID: <20230113060133.9394-6-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230113060133.9394-1-yong.wu@mediatek.com>
References: <20230113060133.9394-1-yong.wu@mediatek.com>
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

Add larb_region_msk for mt8186. we separate the 16GB iova regions
by each device's larbid/portid.
Note: larb5/6/10/12/14/15/18 connect nothing in this SoC.
Refer to include/dt-bindings/memory/mt8186-memory-port.h

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 drivers/iommu/mtk_iommu.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index d8be7584702f..ffd0203f515e 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -1504,6 +1504,18 @@ static const struct mtk_iommu_plat_data mt8183_data = {
 	.larbid_remap = {{0}, {4}, {5}, {6}, {7}, {2}, {3}, {1}},
 };
 
+static const unsigned int mt8186_larb_region_msk[][32] = {
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
@@ -1516,6 +1528,7 @@ static const struct mtk_iommu_plat_data mt8186_data_mm = {
 	.banks_enable   = {true},
 	.iova_region    = mt8192_multi_dom,
 	.iova_region_nr = ARRAY_SIZE(mt8192_multi_dom),
+	.larb_region_msk = mt8186_larb_region_msk,
 };
 
 static const struct mtk_iommu_plat_data mt8192_data = {
-- 
2.18.0

