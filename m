Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99D7B602156
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 04:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbiJRCoE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 22:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbiJRCnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 22:43:47 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E600397D6E
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 19:43:43 -0700 (PDT)
X-UUID: c83371b0bf904add9019aef8aa9cee12-20221018
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=KuUQWhnKuz4LrvSbXLah6E5g0Pf3IIvUjmI1m91j9l4=;
        b=hoPtfORHcP5yq3cvHU2YUHg96OSLwbJJQ+oQAQ7eTH8gaHfbmfymylhbhWeyzuVbSKLXb6VOnx2aFKIfhT/ZaF7fY/pLnJ3YqjN7cWyxMudTH00xf2lfSy9UTkA3DEORUWWSf0RDLX/Ir2CYg+CR1YmircypG7UpMeoEXa7onKk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:ac8610b9-a0e6-4b91-8d56-086a2abb0e7e,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-25
X-CID-META: VersionHash:39a5ff1,CLOUDID:eeee18a4-ebb2-41a8-a87c-97702aaf2e20,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: c83371b0bf904add9019aef8aa9cee12-20221018
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 29339292; Tue, 18 Oct 2022 10:43:37 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Tue, 18 Oct 2022 10:43:35 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Tue, 18 Oct 2022 10:43:34 +0800
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
Subject: [PATCH v7 3/6] iommu/mediatek: Add error path for loop of mm_dts_parse
Date:   Tue, 18 Oct 2022 10:42:55 +0800
Message-ID: <20221018024258.19073-4-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20221018024258.19073-1-yong.wu@mediatek.com>
References: <20221018024258.19073-1-yong.wu@mediatek.com>
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

The mtk_iommu_mm_dts_parse will parse the smi larbs nodes. if the i+1
larb is parsed fail, we should put_device for the i..0 larbs.

There are two places need to comment:
1) The larbid may be not linear mapping, we should loop whole
   the array in the error path.
2) I move this line position: "data->larb_imu[id].dev = &plarbdev->dev;"
   before "if (!plarbdev->dev.driver)", That means set
   data->larb_imu[id].dev before the error path. then we don't need
   "platform_device_put(plarbdev)" again in probe_defer case. All depend
   on "put_device" of the error path in error cases.

Fixes: d2e9a1102cfc ("iommu/mediatek: Contain MM IOMMU flow with the MM TYPE")
Signed-off-by: Yong Wu <yong.wu@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/iommu/mtk_iommu.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 38112ad87d70..912322494bc0 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -1055,8 +1055,10 @@ static int mtk_iommu_mm_dts_parse(struct device *dev, struct component_match **m
 		u32 id;
 
 		larbnode = of_parse_phandle(dev->of_node, "mediatek,larbs", i);
-		if (!larbnode)
-			return -EINVAL;
+		if (!larbnode) {
+			ret = -EINVAL;
+			goto err_larbdev_put;
+		}
 
 		if (!of_device_is_available(larbnode)) {
 			of_node_put(larbnode);
@@ -1069,14 +1071,16 @@ static int mtk_iommu_mm_dts_parse(struct device *dev, struct component_match **m
 
 		plarbdev = of_find_device_by_node(larbnode);
 		of_node_put(larbnode);
-		if (!plarbdev)
-			return -ENODEV;
+		if (!plarbdev) {
+			ret = -ENODEV;
+			goto err_larbdev_put;
+		}
+		data->larb_imu[id].dev = &plarbdev->dev;
 
 		if (!plarbdev->dev.driver) {
-			platform_device_put(plarbdev);
-			return -EPROBE_DEFER;
+			ret = -EPROBE_DEFER;
+			goto err_larbdev_put;
 		}
-		data->larb_imu[id].dev = &plarbdev->dev;
 
 		component_match_add(dev, match, component_compare_dev, &plarbdev->dev);
 		platform_device_put(plarbdev);
@@ -1111,6 +1115,15 @@ static int mtk_iommu_mm_dts_parse(struct device *dev, struct component_match **m
 		return -EINVAL;
 	}
 	return 0;
+
+err_larbdev_put:
+	/* id may be not linear mapping, loop whole the array */
+	for (i = MTK_LARB_NR_MAX - 1; i >= 0; i++) {
+		if (!data->larb_imu[i].dev)
+			continue;
+		put_device(data->larb_imu[i].dev);
+	}
+	return ret;
 }
 
 static int mtk_iommu_probe(struct platform_device *pdev)
-- 
2.18.0

