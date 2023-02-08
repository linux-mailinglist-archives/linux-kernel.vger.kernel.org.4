Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1CF968E7B5
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 06:37:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbjBHFhx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 00:37:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbjBHFhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 00:37:47 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 906D7279B8;
        Tue,  7 Feb 2023 21:37:44 -0800 (PST)
X-UUID: b22441a2a77211ed945fc101203acc17-20230208
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=pEaMqDi2txNbEnZR9amkvg6uIEQa6MMAQodXL3vDOS0=;
        b=g+g5BiNL7vLylEv0Mm491VmVGAHKAq7Vw0nuLWsbQPABAZfwf3JI5uovWIZDKQ5kZioMrxfRzeLBRqDBMRl+61b1oN8YiX+0ZvS7q47tyyeWxZbCrpiBOWKAW46LoM9P9DFKlZOWosHRhI1d4npbthKeGNJ8ZQvEdigG2YAZY4g=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.19,REQID:15266141-d2b0-45bc-9b8c-cd8a0bd2d2d6,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:70
X-CID-INFO: VERSION:1.1.19,REQID:15266141-d2b0-45bc-9b8c-cd8a0bd2d2d6,IP:0,URL
        :0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTI
        ON:quarantine,TS:70
X-CID-META: VersionHash:885ddb2,CLOUDID:da5fa356-dd49-462e-a4be-2143a3ddc739,B
        ulkID:230208133738I1HN97XU,BulkQuantity:0,Recheck:0,SF:38|29|28|17|19|48,T
        C:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
        ,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-UUID: b22441a2a77211ed945fc101203acc17-20230208
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1136717213; Wed, 08 Feb 2023 13:37:37 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 8 Feb 2023 13:37:36 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Wed, 8 Feb 2023 13:37:35 +0800
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
        <libo.kang@mediatek.com>, Yunfei Dong <yunfei.dong@mediatek.com>,
        kyrie wu <kyrie.wu@mediatek.corp-partner.google.com>,
        <chengci.xu@mediatek.com>, <youlin.pei@mediatek.com>,
        <anan.sun@mediatek.com>, Yong Wu <yong.wu@mediatek.com>
Subject: [PATCH v2 03/10] iommu/mediatek: Get regionid from larb/port id
Date:   Wed, 8 Feb 2023 13:36:36 +0800
Message-ID: <20230208053643.28249-4-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230208053643.28249-1-yong.wu@mediatek.com>
References: <20230208053643.28249-1-yong.wu@mediatek.com>
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

After commit f1ad5338a4d5 ("of: Fix "dma-ranges" handling for bus
controllers"), the dma-ranges is not allowed for dts leaf node.
but we still would like to separate to different masters
into different iova regions.

Thus we have to separate it by the HW larbid and portid. For example,
larb1/2 are in region2 and larb3 is in region3. The problem is that
some ports inside a larb are in region4 while some ports inside this
larb are in region5. Therefore I define a "larb_region_msk" to help
record the information for each a port. Take a example for a larb:
 [1] = ~0: means all ports in this larb are in region1;
 [2] = BIT(3) | BIT(4): means port3/4 in this larb are region2;
 [3] = ~(BIT(3) | BIT(4)): means all the other ports except port3/4
                           in this larb are region3.

This method also avoids the users forget/abuse the iova regions.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 drivers/iommu/mtk_iommu.c | 43 +++++++++++++++++++++------------------
 1 file changed, 23 insertions(+), 20 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index d5a4955910ff..fc3d9be120a0 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -8,7 +8,6 @@
 #include <linux/clk.h>
 #include <linux/component.h>
 #include <linux/device.h>
-#include <linux/dma-direct.h>
 #include <linux/err.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
@@ -194,6 +193,7 @@ struct mtk_iommu_plat_data {
 	enum mtk_iommu_plat	m4u_plat;
 	u32			flags;
 	u32			inv_sel_reg;
+	const u32		(*larb_region_msk)[32];
 
 	char			*pericfg_comp_str;
 	struct list_head	*hw_list;
@@ -508,30 +508,33 @@ static unsigned int mtk_iommu_get_bank_id(struct device *dev,
 static int mtk_iommu_get_iova_region_id(struct device *dev,
 					const struct mtk_iommu_plat_data *plat_data)
 {
-	const struct mtk_iommu_iova_region *rgn = plat_data->iova_region;
-	const struct bus_dma_region *dma_rgn = dev->dma_range_map;
-	int i, candidate = -1;
-	dma_addr_t dma_end;
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
+	unsigned int portidmsk = 0, larbid;
+	const u32 *rgn_larb_msk;
+	int i, region_id = -1;
 
-	if (!dma_rgn || plat_data->iova_region_nr == 1)
+	if (plat_data->iova_region_nr == 1)
 		return 0;
 
-	dma_end = dma_rgn->dma_start + dma_rgn->size - 1;
-	for (i = 0; i < plat_data->iova_region_nr; i++, rgn++) {
-		/* Best fit. */
-		if (dma_rgn->dma_start == rgn->iova_base &&
-		    dma_end == rgn->iova_base + rgn->size - 1)
-			return i;
-		/* ok if it is inside this region. */
-		if (dma_rgn->dma_start >= rgn->iova_base &&
-		    dma_end < rgn->iova_base + rgn->size)
-			candidate = i;
+	larbid = MTK_M4U_TO_LARB(fwspec->ids[0]);
+	for (i = 0; i < fwspec->num_ids; i++)
+		portidmsk |= BIT(MTK_M4U_TO_PORT(fwspec->ids[i]));
+
+	for (i = 0; i < plat_data->iova_region_nr; i++) {
+		rgn_larb_msk = plat_data->larb_region_msk[i];
+		if (!rgn_larb_msk)
+			continue;
+
+		if  ((rgn_larb_msk[larbid] & portidmsk) == portidmsk) {
+			region_id = i;
+			break;
+		}
 	}
 
-	if (candidate >= 0)
-		return candidate;
-	dev_err(dev, "Can NOT find the iommu domain id(%pad 0x%llx).\n",
-		&dma_rgn->dma_start, dma_rgn->size);
+	if (region_id >= 0)
+		return region_id;
+	dev_err(dev, "Can NOT find the region for larb(%d-%x).\n",
+		larbid, portidmsk);
 	return -EINVAL;
 }
 
-- 
2.18.0

