Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02E636B37CB
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 08:52:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbjCJHwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 02:52:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjCJHwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 02:52:47 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC62B6770A;
        Thu,  9 Mar 2023 23:52:45 -0800 (PST)
X-UUID: 88749a6abf1811ed945fc101203acc17-20230310
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=sJQQkamtHAcgkCGJ0h3Tqt0rl885miX0Xvw7NZPq2Hg=;
        b=nryrrcXeXThH5gc8f8e6+WQNq9oszst3fYEYcY5mYrR9ee71OH9eA5sEeePWdGhOYdunrZMJowOiInhQM1WNK+KARh+oy14HOBLkxs+vt4nvhbPgIcmjoamo5wbBKhZrYpSPgbBKY0QHoU9Zcr6fVPNv9EsgXCsvLoLV86HOTRg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.20,REQID:45a680af-35ec-44b6-8061-b4173e1f6fb0,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:25b5999,CLOUDID:d839d5b2-beed-4dfc-bd9c-e1b22fa6ccc4,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-UUID: 88749a6abf1811ed945fc101203acc17-20230310
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
        (envelope-from <irui.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 169689001; Fri, 10 Mar 2023 15:52:40 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with ShadowRedundancy id
 15.2.1118.7; Fri, 10 Mar 2023 07:51:41 +0000
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Fri, 10 Mar 2023 14:23:59 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Fri, 10 Mar 2023 14:23:58 +0800
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
        Irui Wang <irui.wang@mediatek.com>
Subject: [V2,2/7] media: mtk-jpeg: add jpeg single core initial function
Date:   Fri, 10 Mar 2023 14:23:50 +0800
Message-ID: <20230310062355.9963-3-irui.wang@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230310062355.9963-1-irui.wang@mediatek.com>
References: <20230310062355.9963-1-irui.wang@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: kyrie wu <kyrie.wu@mediatek.com>

add single core initial function to init reg_base,
irq and clk.

Signed-off-by: kyrie wu <kyrie.wu@mediatek.com>
Signed-off-by: irui wang <irui.wang@mediatek.com>
---
 .../platform/mediatek/jpeg/mtk_jpeg_core.c    | 74 +++++++++++--------
 1 file changed, 44 insertions(+), 30 deletions(-)

diff --git a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
index 6d052747a15e..daa4a6448311 100644
--- a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
+++ b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
@@ -1671,10 +1671,50 @@ static void mtk_jpeg_job_timeout_work(struct work_struct *work)
 	v4l2_m2m_job_finish(jpeg->m2m_dev, ctx->fh.m2m_ctx);
 }
 
+static int mtk_jpeg_single_core_init(struct platform_device *pdev,
+				     struct mtk_jpeg_dev *jpeg_dev)
+{
+	struct mtk_jpeg_dev *jpeg = jpeg_dev;
+	int jpeg_irq, ret;
+
+	INIT_DELAYED_WORK(&jpeg->job_timeout_work,
+			  mtk_jpeg_job_timeout_work);
+
+	jpeg->reg_base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(jpeg->reg_base)) {
+		ret = PTR_ERR(jpeg->reg_base);
+		return ret;
+	}
+
+	jpeg_irq = platform_get_irq(pdev, 0);
+	if (jpeg_irq < 0)
+		return jpeg_irq;
+
+	ret = devm_request_irq(&pdev->dev,
+			       jpeg_irq,
+			       jpeg->variant->irq_handler,
+			       0,
+			       pdev->name, jpeg);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to request jpeg_irq %d (%d)\n",
+			jpeg_irq, ret);
+		return ret;
+	}
+
+	ret = devm_clk_bulk_get(jpeg->dev,
+				jpeg->variant->num_clks,
+				jpeg->variant->clks);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to init clk\n");
+		return ret;
+	}
+
+	return 0;
+}
+
 static int mtk_jpeg_probe(struct platform_device *pdev)
 {
 	struct mtk_jpeg_dev *jpeg;
-	int jpeg_irq;
 	int ret;
 
 	jpeg = devm_kzalloc(&pdev->dev, sizeof(*jpeg), GFP_KERNEL);
@@ -1693,36 +1733,10 @@ static int mtk_jpeg_probe(struct platform_device *pdev)
 	}
 
 	if (!jpeg->variant->multi_core) {
-		INIT_DELAYED_WORK(&jpeg->job_timeout_work,
-				  mtk_jpeg_job_timeout_work);
-
-		jpeg->reg_base = devm_platform_ioremap_resource(pdev, 0);
-		if (IS_ERR(jpeg->reg_base)) {
-			ret = PTR_ERR(jpeg->reg_base);
-			return ret;
-		}
-
-		jpeg_irq = platform_get_irq(pdev, 0);
-		if (jpeg_irq < 0)
-			return jpeg_irq;
-
-		ret = devm_request_irq(&pdev->dev,
-				       jpeg_irq,
-				       jpeg->variant->irq_handler,
-				       0,
-				       pdev->name, jpeg);
-		if (ret) {
-			dev_err(&pdev->dev, "Failed to request jpeg_irq %d (%d)\n",
-				jpeg_irq, ret);
-			return ret;
-		}
-
-		ret = devm_clk_bulk_get(jpeg->dev,
-					jpeg->variant->num_clks,
-					jpeg->variant->clks);
+		ret = mtk_jpeg_single_core_init(pdev, jpeg);
 		if (ret) {
-			dev_err(&pdev->dev, "Failed to init clk\n");
-			return ret;
+			v4l2_err(&jpeg->v4l2_dev, "mtk_jpeg_single_core_init failed.");
+			return -EINVAL;
 		}
 	}
 
-- 
2.18.0

