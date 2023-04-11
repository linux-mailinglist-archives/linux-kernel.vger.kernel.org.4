Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1026DD6EC
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 11:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbjDKJew (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 05:34:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbjDKJeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 05:34:16 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADDB93C25;
        Tue, 11 Apr 2023 02:33:57 -0700 (PDT)
X-UUID: f97ced10d84b11eda9a90f0bb45854f4-20230411
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=R0k5lQHHRLml/ji++14oXkm9cmht5KGHr7AnrObcMd4=;
        b=UOyxwXL88mhRAvK3zmw+lbZBjPtgAOXHO3PZMhye+TysyK2pOQXdgJmfOUUAwxAZY9wAAx5AT2Q0PK95TAHasoilJ3VrBFV5PFQo+T0xshqMFCmyrWfxN+esexQxevEiKxAMcmGOLnb/XXIkCCCGlh+aPftlRT45B/UgQsw5Twg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:a0fea9d4-b872-423d-bddb-f33fda861715,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-25
X-CID-META: VersionHash:120426c,CLOUDID:5270ae83-cd9c-45f5-8134-710979e3df0e,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: f97ced10d84b11eda9a90f0bb45854f4-20230411
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 264596907; Tue, 11 Apr 2023 17:33:53 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Tue, 11 Apr 2023 17:33:52 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Tue, 11 Apr 2023 17:33:51 +0800
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
        <anan.sun@mediatek.com>, Yong Wu <yong.wu@mediatek.com>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        irui wang <irui.wang@mediatek.com>
Subject: [PATCH v7 11/14] media: mediatek: vcodec: Remove the setting for dma_mask
Date:   Tue, 11 Apr 2023 17:31:41 +0800
Message-ID: <20230411093144.2690-12-yong.wu@mediatek.com>
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

In order to simplify the masters to set their respective dma masks, MTK
IOMMU helps to centralize the processing. Because all the dma ranges is
set in IOMMU, IOMMU knows well the dma mask requirements of masters. After
this patch, the masters(codec here) code does not need care
dma-ranges/dma_mask related information.

Cc: Tiffany Lin <tiffany.lin@mediatek.com>
Cc: Andrew-CT Chen <andrew-ct.chen@mediatek.com>
Cc: Yunfei Dong <yunfei.dong@mediatek.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: irui wang <irui.wang@mediatek.com>
Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 .../media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c   | 8 --------
 .../media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c   | 3 ---
 2 files changed, 11 deletions(-)

diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c
index 174a6eec2f54..11583405cf61 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c
@@ -321,14 +321,6 @@ static int mtk_vcodec_probe(struct platform_device *pdev)
 		}
 	}
 
-	if (of_get_property(pdev->dev.of_node, "dma-ranges", NULL)) {
-		ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(34));
-		if (ret) {
-			mtk_v4l2_err("Failed to set mask");
-			goto err_core_workq;
-		}
-	}
-
 	for (i = 0; i < MTK_VDEC_HW_MAX; i++)
 		mutex_init(&dev->dec_mutex[i]);
 	mutex_init(&dev->dev_mutex);
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c
index 9095186d5495..50e5571608cd 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c
@@ -344,9 +344,6 @@ static int mtk_vcodec_probe(struct platform_device *pdev)
 		goto err_event_workq;
 	}
 
-	if (of_get_property(pdev->dev.of_node, "dma-ranges", NULL))
-		dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(34));
-
 	ret = video_register_device(vfd_enc, VFL_TYPE_VIDEO, -1);
 	if (ret) {
 		mtk_v4l2_err("Failed to register video device");
-- 
2.25.1

