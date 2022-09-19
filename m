Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 137915BC545
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 11:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbiISJYo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 05:24:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbiISJYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 05:24:32 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E5D423B
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 02:24:30 -0700 (PDT)
X-UUID: f0332fdc791b46e7beaf1d4f986867b5-20220919
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=1n3i963YjnjCxA997/LlkIp6gYgdi9xkWLSnlTpGK7s=;
        b=FEBbQ0/Pnz4r6q9zO5YXlO9Phcz1xDyYAp9NRvDJ2RUf+JD/4+F3EyxIka+Tsqs55ZkvDCzD4YL9eo+kmAaIxS1KW2LK2OqymGWYTXh70ww3phQVU6glwPvtVbt/GURRSsuwtOgiK/auv5tpYWOwC8rGl09tpYcfOKDZ4kaQyws=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:cd938c0e-0163-4fb2-9c43-6957a2000c45,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:90
X-CID-INFO: VERSION:1.1.11,REQID:cd938c0e-0163-4fb2-9c43-6957a2000c45,IP:0,URL
        :0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTIO
        N:quarantine,TS:90
X-CID-META: VersionHash:39a5ff1,CLOUDID:26c6225e-5ed4-4e28-8b00-66ed9f042fbd,B
        ulkID:220919172425LCJE5R8E,BulkQuantity:0,Recheck:0,SF:28|17|19|48|823|824
        ,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL
        :0
X-UUID: f0332fdc791b46e7beaf1d4f986867b5-20220919
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1112873513; Mon, 19 Sep 2022 17:24:24 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Mon, 19 Sep 2022 17:24:23 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Mon, 19 Sep 2022 17:24:22 +0800
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
Subject: [PATCH v5 1/6] iommu/mediatek: Add platform_device_put for recovering the device refcnt
Date:   Mon, 19 Sep 2022 17:24:00 +0800
Message-ID: <20220919092405.8256-2-yong.wu@mediatek.com>
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

Add platform_device_put to match with of_find_device_by_node.

Meanwhile, I add a new variable "pcommdev" which is for smi common device.
Otherwise, "platform_device_put(plarbdev)" for smi-common dev may be not
readable. And add a checking for whether pcommdev is NULL.

Fixes: d2e9a1102cfc ("iommu/mediatek: Contain MM IOMMU flow with the MM TYPE")
Signed-off-by: Yong Wu <yong.wu@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/iommu/mtk_iommu.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 7e363b1f24df..21a8ce503a0e 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -1041,7 +1041,7 @@ static int mtk_iommu_mm_dts_parse(struct device *dev, struct component_match **m
 				  struct mtk_iommu_data *data)
 {
 	struct device_node *larbnode, *smicomm_node, *smi_subcomm_node;
-	struct platform_device *plarbdev;
+	struct platform_device *plarbdev, *pcommdev;
 	struct device_link *link;
 	int i, larb_nr, ret;
 
@@ -1072,12 +1072,14 @@ static int mtk_iommu_mm_dts_parse(struct device *dev, struct component_match **m
 		}
 		if (!plarbdev->dev.driver) {
 			of_node_put(larbnode);
+			platform_device_put(plarbdev);
 			return -EPROBE_DEFER;
 		}
 		data->larb_imu[id].dev = &plarbdev->dev;
 
 		component_match_add_release(dev, match, component_release_of,
 					    component_compare_of, larbnode);
+		platform_device_put(plarbdev);
 	}
 
 	/* Get smi-(sub)-common dev from the last larb. */
@@ -1095,12 +1097,15 @@ static int mtk_iommu_mm_dts_parse(struct device *dev, struct component_match **m
 	else
 		smicomm_node = smi_subcomm_node;
 
-	plarbdev = of_find_device_by_node(smicomm_node);
+	pcommdev = of_find_device_by_node(smicomm_node);
 	of_node_put(smicomm_node);
-	data->smicomm_dev = &plarbdev->dev;
+	if (!pcommdev)
+		return -ENODEV;
+	data->smicomm_dev = &pcommdev->dev;
 
 	link = device_link_add(data->smicomm_dev, dev,
 			       DL_FLAG_STATELESS | DL_FLAG_PM_RUNTIME);
+	platform_device_put(pcommdev);
 	if (!link) {
 		dev_err(dev, "Unable to link %s.\n", dev_name(data->smicomm_dev));
 		return -EINVAL;
-- 
2.18.0

