Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D35F6B369E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 07:24:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbjCJGYf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 01:24:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbjCJGYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 01:24:13 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6558104617;
        Thu,  9 Mar 2023 22:24:11 -0800 (PST)
X-UUID: 28235888bf0c11ed945fc101203acc17-20230310
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=Gn2kibkOu2BpBaNvPK5fRP0sBK77AQfIg4Roa4SkH2Q=;
        b=kP0EbAlH3BXHBdiBt2rS2Lx1EZc7vyY9VSml8AeOzPgbddRDcbfeMSqErbC14YZlf5JgBwJZF2We1U9AOQ2mQdVpDHp5s9RK/zXxZGX2yycM5iidCr0uwYSrIwY24yvTEFXYBonXCSAmX1oY5R9wFGzEfjiqS3J3EAFR7fgoLaE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.20,REQID:13df1942-a35a-45bb-bf8d-4c06697edb24,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-25
X-CID-META: VersionHash:25b5999,CLOUDID:1949f127-564d-42d9-9875-7c868ee415ec,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-UUID: 28235888bf0c11ed945fc101203acc17-20230310
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
        (envelope-from <irui.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 398728192; Fri, 10 Mar 2023 14:24:05 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Fri, 10 Mar 2023 14:24:03 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Fri, 10 Mar 2023 14:24:02 +0800
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
Subject: [V2,6/7] media: mtk-jpeg: refactor some variables
Date:   Fri, 10 Mar 2023 14:23:54 +0800
Message-ID: <20230310062355.9963-7-irui.wang@mediatek.com>
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

Refactor some variables to reduce redundancy
and optimize the initialization process.

Signed-off-by: kyrie wu <kyrie.wu@mediatek.com>
Signed-off-by: irui wang <irui.wang@mediatek.com>
---
 .../platform/mediatek/jpeg/mtk_jpeg_core.c    | 31 ++++++++++++++-----
 .../platform/mediatek/jpeg/mtk_jpeg_core.h    | 18 ++++-------
 .../platform/mediatek/jpeg/mtk_jpeg_dec_hw.c  | 16 +++-------
 .../platform/mediatek/jpeg/mtk_jpeg_enc_hw.c  | 16 +++-------
 4 files changed, 37 insertions(+), 44 deletions(-)

diff --git a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
index e89195f1989c..ab06c1ee80d4 100644
--- a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
+++ b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
@@ -1004,8 +1004,8 @@ static void mtk_jpegenc_worker(struct work_struct *work)
 retry_select:
 	hw_id = mtk_jpegenc_get_hw(ctx);
 	if (hw_id < 0) {
-		ret = wait_event_interruptible(jpeg->enc_hw_wq,
-					       atomic_read(&jpeg->enchw_rdy) > 0);
+		ret = wait_event_interruptible(jpeg->hw_wq,
+					       atomic_read(&jpeg->hw_rdy) > 0);
 		if (ret != 0 || (i++ > MTK_JPEG_MAX_RETRY_TIME)) {
 			dev_err(jpeg->dev, "%s : %d, all HW are busy\n",
 				__func__, __LINE__);
@@ -1016,7 +1016,7 @@ static void mtk_jpegenc_worker(struct work_struct *work)
 		goto retry_select;
 	}
 
-	atomic_dec(&jpeg->enchw_rdy);
+	atomic_dec(&jpeg->hw_rdy);
 	src_buf = v4l2_m2m_next_src_buf(ctx->fh.m2m_ctx);
 	if (!src_buf)
 		goto getbuf_fail;
@@ -1073,7 +1073,7 @@ static void mtk_jpegenc_worker(struct work_struct *work)
 	v4l2_m2m_buf_done(src_buf, buf_state);
 	v4l2_m2m_buf_done(dst_buf, buf_state);
 getbuf_fail:
-	atomic_inc(&jpeg->enchw_rdy);
+	atomic_inc(&jpeg->hw_rdy);
 	mtk_jpegenc_put_hw(jpeg, hw_id);
 	v4l2_m2m_job_finish(jpeg->m2m_dev, ctx->fh.m2m_ctx);
 }
@@ -1198,8 +1198,8 @@ static void mtk_jpegdec_worker(struct work_struct *work)
 retry_select:
 	hw_id = mtk_jpegdec_get_hw(ctx);
 	if (hw_id < 0) {
-		ret = wait_event_interruptible_timeout(jpeg->dec_hw_wq,
-						       atomic_read(&jpeg->dechw_rdy) > 0,
+		ret = wait_event_interruptible_timeout(jpeg->hw_wq,
+						       atomic_read(&jpeg->hw_rdy) > 0,
 						       MTK_JPEG_HW_TIMEOUT_MSEC);
 		if (ret != 0 || (i++ > MTK_JPEG_MAX_RETRY_TIME)) {
 			dev_err(jpeg->dev, "%s : %d, all HW are busy\n",
@@ -1211,7 +1211,7 @@ static void mtk_jpegdec_worker(struct work_struct *work)
 		goto retry_select;
 	}
 
-	atomic_dec(&jpeg->dechw_rdy);
+	atomic_dec(&jpeg->hw_rdy);
 	src_buf = v4l2_m2m_next_src_buf(ctx->fh.m2m_ctx);
 	if (!src_buf)
 		goto getbuf_fail;
@@ -1290,7 +1290,7 @@ static void mtk_jpegdec_worker(struct work_struct *work)
 	v4l2_m2m_buf_done(src_buf, buf_state);
 	v4l2_m2m_buf_done(dst_buf, buf_state);
 getbuf_fail:
-	atomic_inc(&jpeg->dechw_rdy);
+	atomic_inc(&jpeg->hw_rdy);
 	mtk_jpegdec_put_hw(jpeg, hw_id);
 	v4l2_m2m_job_finish(jpeg->m2m_dev, ctx->fh.m2m_ctx);
 }
@@ -1710,6 +1710,8 @@ static int mtk_jpeg_single_core_init(struct platform_device *pdev,
 static int mtk_jpeg_probe(struct platform_device *pdev)
 {
 	struct mtk_jpeg_dev *jpeg;
+	struct device_node *child;
+	int num_child = 0;
 	int ret;
 
 	jpeg = devm_kzalloc(&pdev->dev, sizeof(*jpeg), GFP_KERNEL);
@@ -1733,6 +1735,19 @@ static int mtk_jpeg_probe(struct platform_device *pdev)
 			v4l2_err(&jpeg->v4l2_dev, "mtk_jpeg_single_core_init failed.");
 			return -EINVAL;
 		}
+	} else {
+		init_waitqueue_head(&jpeg->hw_wq);
+
+		for_each_child_of_node(pdev->dev.of_node, child)
+			num_child++;
+
+		atomic_set(&jpeg->hw_rdy, num_child);
+
+		jpeg->workqueue = alloc_ordered_workqueue(MTK_JPEG_NAME,
+							  WQ_MEM_RECLAIM
+							  | WQ_FREEZABLE);
+		if (!jpeg->workqueue)
+			return -EINVAL;
 	}
 
 	ret = v4l2_device_register(&pdev->dev, &jpeg->v4l2_dev);
diff --git a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.h b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.h
index 83cf35a12b7a..89242e407dc9 100644
--- a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.h
+++ b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.h
@@ -203,14 +203,11 @@ struct mtk_jpegdec_comp_dev {
  * @job_timeout_work:	IRQ timeout structure
  * @variant:		driver variant to be used
  * @reg_encbase:	jpg encode register base addr
- * @enc_hw_dev:		jpg encode hardware device
- * @enc_hw_wq:		jpg encode wait queue
- * @enchw_rdy:		jpg encode hw ready flag
+ * @enc_hw_dev:	jpg encode hardware device
+ * @hw_wq:		jpg wait queue
+ * @hw_rdy:		jpg hw ready flag
  * @reg_decbase:	jpg decode register base addr
- * @dec_hw_dev:		jpg decode hardware device
- * @dec_hw_wq:		jpg decode wait queue
- * @dec_workqueue:	jpg decode work queue
- * @dechw_rdy:		jpg decode hw ready flag
+ * @dec_hw_dev:	jpg decode hardware device
  */
 struct mtk_jpeg_dev {
 	struct mutex		lock;
@@ -227,14 +224,11 @@ struct mtk_jpeg_dev {
 
 	void __iomem *reg_encbase[MTK_JPEGENC_HW_MAX];
 	struct mtk_jpegenc_comp_dev *enc_hw_dev[MTK_JPEGENC_HW_MAX];
-	wait_queue_head_t enc_hw_wq;
-	atomic_t enchw_rdy;
+	wait_queue_head_t hw_wq;
+	atomic_t hw_rdy;
 
 	void __iomem *reg_decbase[MTK_JPEGDEC_HW_MAX];
 	struct mtk_jpegdec_comp_dev *dec_hw_dev[MTK_JPEGDEC_HW_MAX];
-	wait_queue_head_t dec_hw_wq;
-	struct workqueue_struct	*dec_workqueue;
-	atomic_t dechw_rdy;
 };
 
 /**
diff --git a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_dec_hw.c b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_dec_hw.c
index 5b47bd83c5ce..b7c2de2489b0 100644
--- a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_dec_hw.c
+++ b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_dec_hw.c
@@ -503,8 +503,8 @@ static void mtk_jpegdec_timeout_work(struct work_struct *work)
 	clk_disable_unprepare(cjpeg->jdec_clk.clks->clk);
 	pm_runtime_put(cjpeg->dev);
 	cjpeg->hw_state = MTK_JPEG_HW_IDLE;
-	atomic_inc(&master_jpeg->dechw_rdy);
-	wake_up(&master_jpeg->dec_hw_wq);
+	atomic_inc(&master_jpeg->hw_rdy);
+	wake_up(&master_jpeg->hw_wq);
 	v4l2_m2m_buf_done(src_buf, buf_state);
 	mtk_jpegdec_put_buf(cjpeg);
 }
@@ -551,8 +551,8 @@ static irqreturn_t mtk_jpegdec_hw_irq_handler(int irq, void *priv)
 	clk_disable_unprepare(jpeg->jdec_clk.clks->clk);
 
 	jpeg->hw_state = MTK_JPEG_HW_IDLE;
-	wake_up(&master_jpeg->dec_hw_wq);
-	atomic_inc(&master_jpeg->dechw_rdy);
+	wake_up(&master_jpeg->hw_wq);
+	atomic_inc(&master_jpeg->hw_rdy);
 
 	return IRQ_HANDLED;
 }
@@ -608,20 +608,12 @@ static int mtk_jpegdec_hw_probe(struct platform_device *pdev)
 	dev->plat_dev = pdev;
 	dev->dev = &pdev->dev;
 
-	init_waitqueue_head(&master_dev->dec_hw_wq);
-	master_dev->workqueue = alloc_ordered_workqueue(MTK_JPEG_NAME,
-							WQ_MEM_RECLAIM
-							| WQ_FREEZABLE);
-	if (!master_dev->workqueue)
-		return -EINVAL;
-
 	ret = devm_add_action_or_reset(&pdev->dev,
 				       mtk_jpegdec_destroy_workqueue,
 				       master_dev->workqueue);
 	if (ret)
 		return ret;
 
-	atomic_set(&master_dev->dechw_rdy, MTK_JPEGDEC_HW_MAX);
 	spin_lock_init(&dev->hw_lock);
 	dev->hw_state = MTK_JPEG_HW_IDLE;
 
diff --git a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_enc_hw.c b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_enc_hw.c
index c2bc0b531b32..e35ee1bdce3d 100644
--- a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_enc_hw.c
+++ b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_enc_hw.c
@@ -248,8 +248,8 @@ static void mtk_jpegenc_timeout_work(struct work_struct *work)
 	clk_disable_unprepare(cjpeg->venc_clk.clks->clk);
 	pm_runtime_put(cjpeg->dev);
 	cjpeg->hw_state = MTK_JPEG_HW_IDLE;
-	atomic_inc(&master_jpeg->enchw_rdy);
-	wake_up(&master_jpeg->enc_hw_wq);
+	atomic_inc(&master_jpeg->hw_rdy);
+	wake_up(&master_jpeg->hw_wq);
 	v4l2_m2m_buf_done(src_buf, buf_state);
 	mtk_jpegenc_put_buf(cjpeg);
 }
@@ -288,8 +288,8 @@ static irqreturn_t mtk_jpegenc_hw_irq_handler(int irq, void *priv)
 	clk_disable_unprepare(jpeg->venc_clk.clks->clk);
 
 	jpeg->hw_state = MTK_JPEG_HW_IDLE;
-	wake_up(&master_jpeg->enc_hw_wq);
-	atomic_inc(&master_jpeg->enchw_rdy);
+	wake_up(&master_jpeg->hw_wq);
+	atomic_inc(&master_jpeg->hw_rdy);
 
 	return IRQ_HANDLED;
 }
@@ -340,14 +340,6 @@ static int mtk_jpegenc_hw_probe(struct platform_device *pdev)
 	dev->plat_dev = pdev;
 	dev->dev = &pdev->dev;
 
-	init_waitqueue_head(&master_dev->enc_hw_wq);
-	master_dev->workqueue = alloc_ordered_workqueue(MTK_JPEG_NAME,
-							WQ_MEM_RECLAIM
-							| WQ_FREEZABLE);
-	if (!master_dev->workqueue)
-		return -EINVAL;
-
-	atomic_set(&master_dev->enchw_rdy, MTK_JPEGENC_HW_MAX);
 	spin_lock_init(&dev->hw_lock);
 	dev->hw_state = MTK_JPEG_HW_IDLE;
 
-- 
2.18.0

