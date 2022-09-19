Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDA6C5BC54A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 11:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbiISJZi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 05:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbiISJZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 05:25:07 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 600A924F19
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 02:24:58 -0700 (PDT)
X-UUID: e8fb3f1def3541e7894e213a702d33a9-20220919
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=q4q6hr9tPz4HzDjm0WRuVwaOEsMHWVBqCC3YrBT92fw=;
        b=Ko/uWqJBkILlmJ+WWEN1ezI5NMAAgENTm+OgBhjnWpGUuXCIgh2MZp6AmsnSML0pgEPT1khU6MOQxTEM77V7xZ4JqmpVyyiG9RZv0IGey8pqWwPfOe3TxklV9UAOybb511OzPEuvgYb3ZVHch4GIoRUzrHF63cQS8iTER6iPrzo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:f0f23bf9-cd8e-41fc-bc9b-6d349cacfded,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:39a5ff1,CLOUDID:c9ca225e-5ed4-4e28-8b00-66ed9f042fbd,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: e8fb3f1def3541e7894e213a702d33a9-20220919
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1473669100; Mon, 19 Sep 2022 17:24:53 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Mon, 19 Sep 2022 17:24:51 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Mon, 19 Sep 2022 17:24:50 +0800
From:   Yong Wu <yong.wu@mediatek.com>
To:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Will Deacon <will@kernel.org>
CC:     Robin Murphy <robin.murphy@arm.com>, <iommu@lists.linux.dev>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Yong Wu <yong.wu@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        <mingyuan.ma@mediatek.com>, <yf.wang@mediatek.com>,
        <libo.kang@mediatek.com>, <chengci.xu@mediatek.com>,
        <youlin.pei@mediatek.com>, <anan.sun@mediatek.com>,
        <xueqi.zhang@mediatek.com>, Guenter Roeck <groeck@chromium.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH v5 5/6] iommu/mediatek: Improve safety for mediatek,smi property in larb nodes
Date:   Mon, 19 Sep 2022 17:24:04 +0800
Message-ID: <20220919092405.8256-6-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220919092405.8256-1-yong.wu@mediatek.com>
References: <20220919092405.8256-1-yong.wu@mediatek.com>
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

No functional change. Just improve safety from dts.

All the larbs that connect to one IOMMU must connect with the same
smi-common. This patch checks all the mediatek,smi property for each
larb, If their mediatek,smi are different, it will return fails.
Also avoid there is no available smi-larb nodes.

Suggested-by: Guenter Roeck <groeck@chromium.org>
Signed-off-by: Yong Wu <yong.wu@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/iommu/mtk_iommu.c | 53 +++++++++++++++++++++++++++------------
 1 file changed, 37 insertions(+), 16 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 01b31b09bd8d..f92b8c0bb373 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -1040,7 +1040,7 @@ static const struct component_master_ops mtk_iommu_com_ops = {
 static int mtk_iommu_mm_dts_parse(struct device *dev, struct component_match **match,
 				  struct mtk_iommu_data *data)
 {
-	struct device_node *larbnode, *smicomm_node, *smi_subcomm_node;
+	struct device_node *larbnode, *frst_avail_smicomm_node = NULL;
 	struct platform_device *plarbdev, *pcommdev;
 	struct device_link *link;
 	int i, larb_nr, ret;
@@ -1052,6 +1052,7 @@ static int mtk_iommu_mm_dts_parse(struct device *dev, struct component_match **m
 		return -EINVAL;
 
 	for (i = 0; i < larb_nr; i++) {
+		struct device_node *smicomm_node, *smi_subcomm_node;
 		u32 id;
 
 		larbnode = of_parse_phandle(dev->of_node, "mediatek,larbs", i);
@@ -1092,27 +1093,47 @@ static int mtk_iommu_mm_dts_parse(struct device *dev, struct component_match **m
 			goto err_larbdev_put;
 		}
 
+		/* Get smi-(sub)-common dev from the last larb. */
+		smi_subcomm_node = of_parse_phandle(larbnode, "mediatek,smi", 0);
+		if (!smi_subcomm_node) {
+			ret = -EINVAL;
+			goto err_larbdev_put;
+		}
+
+		/*
+		 * It may have two level smi-common. the node is smi-sub-common if it
+		 * has a new mediatek,smi property. otherwise it is smi-commmon.
+		 */
+		smicomm_node = of_parse_phandle(smi_subcomm_node, "mediatek,smi", 0);
+		if (smicomm_node)
+			of_node_put(smi_subcomm_node);
+		else
+			smicomm_node = smi_subcomm_node;
+
+		/*
+		 * All the larbs that connect to one IOMMU must connect with the same
+		 * smi-common.
+		 */
+		if (!frst_avail_smicomm_node) {
+			frst_avail_smicomm_node = smicomm_node;
+		} else if (frst_avail_smicomm_node != smicomm_node) {
+			dev_err(dev, "mediatek,smi property is not right @larb%d.", id);
+			of_node_put(smicomm_node);
+			ret = -EINVAL;
+			goto err_larbdev_put;
+		} else {
+			of_node_put(smicomm_node);
+		}
+
 		component_match_add(dev, match, component_compare_dev, &plarbdev->dev);
 		platform_device_put(plarbdev);
 	}
 
-	/* Get smi-(sub)-common dev from the last larb. */
-	smi_subcomm_node = of_parse_phandle(larbnode, "mediatek,smi", 0);
-	if (!smi_subcomm_node)
+	if (!frst_avail_smicomm_node)
 		return -EINVAL;
 
-	/*
-	 * It may have two level smi-common. the node is smi-sub-common if it
-	 * has a new mediatek,smi property. otherwise it is smi-commmon.
-	 */
-	smicomm_node = of_parse_phandle(smi_subcomm_node, "mediatek,smi", 0);
-	if (smicomm_node)
-		of_node_put(smi_subcomm_node);
-	else
-		smicomm_node = smi_subcomm_node;
-
-	pcommdev = of_find_device_by_node(smicomm_node);
-	of_node_put(smicomm_node);
+	pcommdev = of_find_device_by_node(frst_avail_smicomm_node);
+	of_node_put(frst_avail_smicomm_node);
 	if (!pcommdev)
 		return -ENODEV;
 	data->smicomm_dev = &pcommdev->dev;
-- 
2.18.0

