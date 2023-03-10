Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AC136B369B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 07:24:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbjCJGYZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 01:24:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjCJGYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 01:24:13 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29A65104615;
        Thu,  9 Mar 2023 22:24:11 -0800 (PST)
X-UUID: 28e56f0ebf0c11eda06fc9ecc4dadd91-20230310
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=rnHDPaF+R8FF8PJd9FlWmcGdhDJGTaMa9mgP/cJusow=;
        b=tDailIn0Te986A0DXOTjkyjBIMAWlbQgCANePh5T8zkKDduE8Y4gkmzwEuTf912XCMXdgAe8jDuH8n5ui7GPqsT/Wkc8CbVIwerPbgHIyCxgBfMGDNzXYURycIbG33Y9X10dc+xMIeuDXIjw4kI90dJZmfsZ2Er4Qttt6cG1vZs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.20,REQID:4e4173bf-4582-44ca-84bb-0e2ea943d206,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:90
X-CID-INFO: VERSION:1.1.20,REQID:4e4173bf-4582-44ca-84bb-0e2ea943d206,IP:0,URL
        :0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTIO
        N:quarantine,TS:90
X-CID-META: VersionHash:25b5999,CLOUDID:cbb05ff5-ddba-41c3-91d9-10eeade8eac7,B
        ulkID:230310103707N1LW8J4D,BulkQuantity:4,Recheck:0,SF:38|29|28|17|19|48,T
        C:nil,Content:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:40,QS:nil,BEC:nil,COL
        :0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-UUID: 28e56f0ebf0c11eda06fc9ecc4dadd91-20230310
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <irui.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1032475739; Fri, 10 Mar 2023 14:24:06 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Fri, 10 Mar 2023 14:24:04 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Fri, 10 Mar 2023 14:24:03 +0800
From:   Irui Wang <irui.wang@mediatek.com>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <angelogioacchino.delregno@collabora.com>,
        <nicolas.dufresne@collabora.com>, kyrie wu <kyrie.wu@mediatek.com>
CC:     <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Tomasz Figa <tfiga@chromium.org>, <xia.jiang@mediatek.com>,
        <maoguang.meng@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        "Irui Wang" <irui.wang@mediatek.com>
Subject: [V2,7/7] media: mtk-jpeg: refactor hw dev initializaiton
Date:   Fri, 10 Mar 2023 14:23:55 +0800
Message-ID: <20230310062355.9963-8-irui.wang@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230310062355.9963-1-irui.wang@mediatek.com>
References: <20230310062355.9963-1-irui.wang@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: kyrie wu <kyrie.wu@mediatek.com>

Add a atomic_t variable for initialization of hw dev.

Signed-off-by: kyrie wu <kyrie.wu@mediatek.com>
Signed-off-by: irui wang <irui.wang@mediatek.com>
---
 drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c |  1 +
 drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.h |  2 ++
 .../media/platform/mediatek/jpeg/mtk_jpeg_dec_hw.c   | 12 ++++--------
 .../media/platform/mediatek/jpeg/mtk_jpeg_enc_hw.c   | 12 ++++--------
 4 files changed, 11 insertions(+), 16 deletions(-)

diff --git a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
index ab06c1ee80d4..1dd03938df7e 100644
--- a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
+++ b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
@@ -1742,6 +1742,7 @@ static int mtk_jpeg_probe(struct platform_device *pdev)
 			num_child++;
 
 		atomic_set(&jpeg->hw_rdy, num_child);
+		atomic_set(&jpeg->hw_index, 0);
 
 		jpeg->workqueue = alloc_ordered_workqueue(MTK_JPEG_NAME,
 							  WQ_MEM_RECLAIM
diff --git a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.h b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.h
index 89242e407dc9..8ba6e757e11a 100644
--- a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.h
+++ b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.h
@@ -208,6 +208,7 @@ struct mtk_jpegdec_comp_dev {
  * @hw_rdy:		jpg hw ready flag
  * @reg_decbase:	jpg decode register base addr
  * @dec_hw_dev:	jpg decode hardware device
+ * @hw_index:		jpg hw index
  */
 struct mtk_jpeg_dev {
 	struct mutex		lock;
@@ -229,6 +230,7 @@ struct mtk_jpeg_dev {
 
 	void __iomem *reg_decbase[MTK_JPEGDEC_HW_MAX];
 	struct mtk_jpegdec_comp_dev *dec_hw_dev[MTK_JPEGDEC_HW_MAX];
+	atomic_t hw_index;
 };
 
 /**
diff --git a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_dec_hw.c b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_dec_hw.c
index b7c2de2489b0..869068fac5e2 100644
--- a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_dec_hw.c
+++ b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_dec_hw.c
@@ -638,14 +638,10 @@ static int mtk_jpegdec_hw_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, ret,
 				     "Failed to register JPEGDEC irq handler.\n");
 
-	for (i = 0; i < MTK_JPEGDEC_HW_MAX; i++) {
-		if (master_dev->dec_hw_dev[i])
-			continue;
-
-		master_dev->dec_hw_dev[i] = dev;
-		master_dev->reg_decbase[i] = dev->reg_base;
-		dev->master_dev = master_dev;
-	}
+	i = atomic_add_return(1, &master_dev->hw_index) - 1;
+	master_dev->dec_hw_dev[i] = dev;
+	master_dev->reg_decbase[i] = dev->reg_base;
+	dev->master_dev = master_dev;
 
 	platform_set_drvdata(pdev, dev);
 	pm_runtime_enable(&pdev->dev);
diff --git a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_enc_hw.c b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_enc_hw.c
index e35ee1bdce3d..71e85b4bbf12 100644
--- a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_enc_hw.c
+++ b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_enc_hw.c
@@ -362,14 +362,10 @@ static int mtk_jpegenc_hw_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	for (i = 0; i < MTK_JPEGENC_HW_MAX; i++) {
-		if (master_dev->enc_hw_dev[i])
-			continue;
-
-		master_dev->enc_hw_dev[i] = dev;
-		master_dev->reg_encbase[i] = dev->reg_base;
-		dev->master_dev = master_dev;
-	}
+	i = atomic_add_return(1, &master_dev->hw_index) - 1;
+	master_dev->enc_hw_dev[i] = dev;
+	master_dev->reg_encbase[i] = dev->reg_base;
+	dev->master_dev = master_dev;
 
 	platform_set_drvdata(pdev, dev);
 	pm_runtime_enable(&pdev->dev);
-- 
2.18.0

