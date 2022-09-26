Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD375E9D51
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 11:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234518AbiIZJQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 05:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234880AbiIZJPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 05:15:14 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FBC9165BB;
        Mon, 26 Sep 2022 02:14:57 -0700 (PDT)
X-UUID: 8a14c4f92d644ad8b7715b5122413943-20220926
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=hkqaI2jwGJn4CTLbocA/YQXNILfABCw6olRcnr4ce5I=;
        b=FYs8X743M61eV38Y4+4cJWJwAyXa/L4txsfez6vjkwz4Ryam3vg31PlAltrSA8QX8FVxnroRqBpvbqvQyofOEEKS01JKPZChBfP5YHSDq+qmgr/dLaRWN7bbZ65ymko747TwS8gvy9+cRaX8HNawjVVWjJiDQDeSsZnvV1iDfyg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:055e4488-c07a-42dc-a3e2-e6a4164b15a3,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-25
X-CID-META: VersionHash:39a5ff1,CLOUDID:76513ce4-87f9-4bb0-97b6-34957dc0fbbe,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 8a14c4f92d644ad8b7715b5122413943-20220926
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <irui.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 861383187; Mon, 26 Sep 2022 17:14:54 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Mon, 26 Sep 2022 17:14:51 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Mon, 26 Sep 2022 17:14:50 +0800
From:   Irui Wang <irui.wang@mediatek.com>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Tzung-Bi Shih" <tzungbi@chromium.org>,
        <angelogioacchino.delregno@collabora.com>,
        <nicolas.dufresne@collabora.com>, <wenst@chromium.org>,
        kyrie wu <kyrie.wu@mediatek.com>
CC:     <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Tomasz Figa <tfiga@chromium.org>, <xia.jiang@mediatek.com>,
        <maoguang.meng@mediatek.com>, irui wang <irui.wang@mediatek.com>
Subject: [V15,12/15] media: mtk-jpegdec: add jpeg decode worker interface
Date:   Mon, 26 Sep 2022 17:14:30 +0800
Message-ID: <20220926091433.18633-13-irui.wang@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220926091433.18633-1-irui.wang@mediatek.com>
References: <20220926091433.18633-1-irui.wang@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY,URIBL_CSS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: kyrie wu <kyrie.wu@mediatek.com>

Add jpeg decoding worker to ensure that three HWs
run in parallel in MT8195.

Signed-off-by: kyrie wu <kyrie.wu@mediatek.com>
Signed-off-by: irui wang <irui.wang@mediatek.com>
---
 .../platform/mediatek/jpeg/mtk_jpeg_core.c    | 196 ++++++++++++++++++
 .../platform/mediatek/jpeg/mtk_jpeg_core.h    |  11 +
 .../platform/mediatek/jpeg/mtk_jpeg_dec_hw.c  |  39 ++--
 3 files changed, 234 insertions(+), 12 deletions(-)

diff --git a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
index e60363e38a90..1d8e065a2067 100644
--- a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
+++ b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
@@ -1102,6 +1102,180 @@ static void mtk_jpeg_multicore_enc_device_run(void *priv)
 	queue_work(jpeg->workqueue, &ctx->jpeg_work);
 }
 
+static int mtk_jpegdec_get_hw(struct mtk_jpeg_ctx *ctx)
+{
+	struct mtk_jpegdec_comp_dev *comp_jpeg;
+	struct mtk_jpeg_dev *jpeg = ctx->jpeg;
+	unsigned long flags;
+	int hw_id = -1;
+	int i;
+
+	spin_lock_irqsave(&jpeg->hw_lock, flags);
+	for (i = 0; i < MTK_JPEGDEC_HW_MAX; i++) {
+		comp_jpeg = jpeg->dec_hw_dev[i];
+		if (comp_jpeg->hw_state == MTK_JPEG_HW_IDLE) {
+			hw_id = i;
+			comp_jpeg->hw_state = MTK_JPEG_HW_BUSY;
+			break;
+		}
+	}
+	spin_unlock_irqrestore(&jpeg->hw_lock, flags);
+
+	return hw_id;
+}
+
+static int mtk_jpegdec_put_hw(struct mtk_jpeg_dev *jpeg, int hw_id)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&jpeg->hw_lock, flags);
+	jpeg->dec_hw_dev[hw_id]->hw_state =
+		MTK_JPEG_HW_IDLE;
+	spin_unlock_irqrestore(&jpeg->hw_lock, flags);
+
+	return 0;
+}
+
+static int mtk_jpegdec_set_hw_param(struct mtk_jpeg_ctx *ctx,
+				    int hw_id,
+				    struct vb2_v4l2_buffer *src_buf,
+				    struct vb2_v4l2_buffer *dst_buf)
+{
+	struct mtk_jpegdec_comp_dev *jpeg =
+		ctx->jpeg->dec_hw_dev[hw_id];
+
+	jpeg->hw_param.curr_ctx = ctx;
+	jpeg->hw_param.src_buffer = src_buf;
+	jpeg->hw_param.dst_buffer = dst_buf;
+
+	return 0;
+}
+
+static void mtk_jpegdec_worker(struct work_struct *work)
+{
+	struct mtk_jpeg_ctx *ctx = container_of(work, struct mtk_jpeg_ctx,
+		jpeg_work);
+	struct mtk_jpegdec_comp_dev *comp_jpeg[MTK_JPEGDEC_HW_MAX];
+	enum vb2_buffer_state buf_state = VB2_BUF_STATE_ERROR;
+	struct mtk_jpeg_src_buf *jpeg_src_buf, *jpeg_dst_buf;
+	struct vb2_v4l2_buffer *src_buf, *dst_buf;
+	struct mtk_jpeg_dev *jpeg = ctx->jpeg;
+	int ret, i, hw_id = 0;
+	struct mtk_jpeg_bs bs;
+	struct mtk_jpeg_fb fb;
+	unsigned long flags;
+
+	for (i = 0; i < MTK_JPEGDEC_HW_MAX; i++)
+		comp_jpeg[i] = jpeg->dec_hw_dev[i];
+	i = 0;
+
+retry_select:
+	hw_id = mtk_jpegdec_get_hw(ctx);
+	if (hw_id < 0) {
+		ret = wait_event_interruptible_timeout(jpeg->dec_hw_wq,
+						       atomic_read(&jpeg->dechw_rdy) > 0,
+						       MTK_JPEG_HW_TIMEOUT_MSEC);
+		if (ret != 0 || (i++ > MTK_JPEG_MAX_RETRY_TIME)) {
+			dev_err(jpeg->dev, "%s : %d, all HW are busy\n",
+				__func__, __LINE__);
+			v4l2_m2m_job_finish(jpeg->m2m_dev, ctx->fh.m2m_ctx);
+			return;
+		}
+
+		goto retry_select;
+	}
+
+	atomic_dec(&jpeg->dechw_rdy);
+	src_buf = v4l2_m2m_next_src_buf(ctx->fh.m2m_ctx);
+	if (!src_buf)
+		goto getbuf_fail;
+
+	dst_buf = v4l2_m2m_next_dst_buf(ctx->fh.m2m_ctx);
+	if (!dst_buf)
+		goto getbuf_fail;
+
+	v4l2_m2m_src_buf_remove(ctx->fh.m2m_ctx);
+	v4l2_m2m_dst_buf_remove(ctx->fh.m2m_ctx);
+
+	v4l2_m2m_buf_copy_metadata(src_buf, dst_buf, true);
+	jpeg_src_buf = mtk_jpeg_vb2_to_srcbuf(&src_buf->vb2_buf);
+	jpeg_dst_buf = mtk_jpeg_vb2_to_srcbuf(&dst_buf->vb2_buf);
+
+	if (mtk_jpeg_check_resolution_change(ctx,
+					     &jpeg_src_buf->dec_param)) {
+		mtk_jpeg_queue_src_chg_event(ctx);
+		ctx->state = MTK_JPEG_SOURCE_CHANGE;
+		goto dec_end;
+	}
+
+	jpeg_src_buf->curr_ctx = ctx;
+	jpeg_src_buf->frame_num = ctx->total_frame_num;
+	jpeg_dst_buf->curr_ctx = ctx;
+	jpeg_dst_buf->frame_num = ctx->total_frame_num;
+	ctx->total_frame_num++;
+
+	mtk_jpegdec_set_hw_param(ctx, hw_id, src_buf, dst_buf);
+	ret = pm_runtime_get_sync(comp_jpeg[hw_id]->dev);
+	if (ret < 0) {
+		dev_err(jpeg->dev, "%s : %d, pm_runtime_get_sync fail !!!\n",
+			__func__, __LINE__);
+		goto dec_end;
+	}
+
+	ret = clk_prepare_enable(comp_jpeg[hw_id]->jdec_clk.clks->clk);
+	if (ret) {
+		dev_err(jpeg->dev, "%s : %d, jpegdec clk_prepare_enable fail\n",
+			__func__, __LINE__);
+		goto clk_end;
+	}
+
+	schedule_delayed_work(&comp_jpeg[hw_id]->job_timeout_work,
+			      msecs_to_jiffies(MTK_JPEG_HW_TIMEOUT_MSEC));
+
+	mtk_jpeg_set_dec_src(ctx, &src_buf->vb2_buf, &bs);
+	if (mtk_jpeg_set_dec_dst(ctx,
+				 &jpeg_src_buf->dec_param,
+				 &dst_buf->vb2_buf, &fb)) {
+		dev_err(jpeg->dev, "%s : %d, mtk_jpeg_set_dec_dst fail\n",
+			__func__, __LINE__);
+		goto setdst_end;
+	}
+
+	spin_lock_irqsave(&comp_jpeg[hw_id]->hw_lock, flags);
+	mtk_jpeg_dec_reset(comp_jpeg[hw_id]->reg_base);
+	mtk_jpeg_dec_set_config(jpeg->reg_base,
+				&jpeg_src_buf->dec_param,
+				&bs,
+				&fb);
+	mtk_jpeg_dec_start(comp_jpeg[hw_id]->reg_base);
+	v4l2_m2m_job_finish(jpeg->m2m_dev, ctx->fh.m2m_ctx);
+	spin_unlock_irqrestore(&comp_jpeg[hw_id]->hw_lock, flags);
+
+	return;
+
+setdst_end:
+	clk_disable_unprepare(comp_jpeg[hw_id]->jdec_clk.clks->clk);
+clk_end:
+	pm_runtime_put(comp_jpeg[hw_id]->dev);
+dec_end:
+	v4l2_m2m_src_buf_remove(ctx->fh.m2m_ctx);
+	v4l2_m2m_dst_buf_remove(ctx->fh.m2m_ctx);
+	v4l2_m2m_buf_done(src_buf, buf_state);
+	v4l2_m2m_buf_done(dst_buf, buf_state);
+getbuf_fail:
+	atomic_inc(&jpeg->dechw_rdy);
+	mtk_jpegdec_put_hw(jpeg, hw_id);
+	v4l2_m2m_job_finish(jpeg->m2m_dev, ctx->fh.m2m_ctx);
+}
+
+static void mtk_jpeg_multicore_dec_device_run(void *priv)
+{
+	struct mtk_jpeg_ctx *ctx = priv;
+	struct mtk_jpeg_dev *jpeg = ctx->jpeg;
+
+	queue_work(jpeg->workqueue, &ctx->jpeg_work);
+}
+
 static void mtk_jpeg_dec_device_run(void *priv)
 {
 	struct mtk_jpeg_ctx *ctx = priv;
@@ -1168,6 +1342,10 @@ static const struct v4l2_m2m_ops mtk_jpeg_multicore_enc_m2m_ops = {
 	.device_run = mtk_jpeg_multicore_enc_device_run,
 };
 
+static const struct v4l2_m2m_ops mtk_jpeg_multicore_dec_m2m_ops = {
+	.device_run = mtk_jpeg_multicore_dec_device_run,
+};
+
 static const struct v4l2_m2m_ops mtk_jpeg_dec_m2m_ops = {
 	.device_run = mtk_jpeg_dec_device_run,
 	.job_ready  = mtk_jpeg_dec_job_ready,
@@ -1371,6 +1549,9 @@ static int mtk_jpeg_open(struct file *file)
 	if (jpeg->is_jpgenc_multihw)
 		INIT_WORK(&ctx->jpeg_work, mtk_jpegenc_worker);
 
+	if (jpeg->is_jpgdec_multihw)
+		INIT_WORK(&ctx->jpeg_work, mtk_jpegdec_worker);
+
 	INIT_LIST_HEAD(&ctx->dst_done_queue);
 	spin_lock_init(&ctx->done_queue_lock);
 	v4l2_fh_init(&ctx->fh, vfd);
@@ -1678,6 +1859,17 @@ static struct mtk_jpeg_variant mtk8195_jpegenc_drvdata = {
 	.cap_q_default_fourcc = V4L2_PIX_FMT_JPEG,
 };
 
+static const struct mtk_jpeg_variant mtk8195_jpegdec_drvdata = {
+	.formats = mtk_jpeg_dec_formats,
+	.num_formats = MTK_JPEG_DEC_NUM_FORMATS,
+	.qops = &mtk_jpeg_dec_qops,
+	.m2m_ops = &mtk_jpeg_multicore_dec_m2m_ops,
+	.dev_name = "mtk-jpeg-dec",
+	.ioctl_ops = &mtk_jpeg_dec_ioctl_ops,
+	.out_q_default_fourcc = V4L2_PIX_FMT_JPEG,
+	.cap_q_default_fourcc = V4L2_PIX_FMT_YUV420M,
+};
+
 #if defined(CONFIG_OF)
 static const struct of_device_id mtk_jpeg_match[] = {
 	{
@@ -1696,6 +1888,10 @@ static const struct of_device_id mtk_jpeg_match[] = {
 		.compatible = "mediatek,mt8195-jpgenc",
 		.data = &mtk8195_jpegenc_drvdata,
 	},
+	{
+		.compatible = "mediatek,mt8195-jpgdec",
+		.data = &mtk8195_jpegdec_drvdata,
+	},
 	{},
 };
 
diff --git a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.h b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.h
index 391c4ec25b2c..0713b8d14356 100644
--- a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.h
+++ b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.h
@@ -167,6 +167,8 @@ struct mtk_jpegenc_comp_dev {
  * @jpegdec_irq:		jpeg decode irq num
  * @job_timeout_work:		decode timeout workqueue
  * @hw_param:			jpeg decode hw parameters
+ * @hw_state:			record hw state
+ * @hw_lock:			spinlock protecting hw
  */
 struct mtk_jpegdec_comp_dev {
 	struct device *dev;
@@ -177,6 +179,9 @@ struct mtk_jpegdec_comp_dev {
 	int jpegdec_irq;
 	struct delayed_work job_timeout_work;
 	struct mtk_jpeg_hw_param hw_param;
+	enum mtk_jpeg_hw_state hw_state;
+	/* spinlock protecting the hw device resource */
+	spinlock_t hw_lock;
 };
 
 /**
@@ -200,6 +205,9 @@ struct mtk_jpegdec_comp_dev {
  * @reg_decbase:	jpg decode register base addr
  * @dec_hw_dev:		jpg decode hardware device
  * @is_jpgdec_multihw:	the flag of dec multi-hw core
+ * @dec_hw_wq:		jpg decode wait queue
+ * @dec_workqueue:	jpg decode work queue
+ * @dechw_rdy:		jpg decode hw ready flag
  */
 struct mtk_jpeg_dev {
 	struct mutex		lock;
@@ -223,6 +231,9 @@ struct mtk_jpeg_dev {
 	void __iomem *reg_decbase[MTK_JPEGDEC_HW_MAX];
 	struct mtk_jpegdec_comp_dev *dec_hw_dev[MTK_JPEGDEC_HW_MAX];
 	bool is_jpgdec_multihw;
+	wait_queue_head_t dec_hw_wq;
+	struct workqueue_struct	*dec_workqueue;
+	atomic_t dechw_rdy;
 };
 
 /**
diff --git a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_dec_hw.c b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_dec_hw.c
index d65cc0a3b663..f7e3013234d3 100644
--- a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_dec_hw.c
+++ b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_dec_hw.c
@@ -446,6 +446,7 @@ static void mtk_jpegdec_timeout_work(struct work_struct *work)
 	struct mtk_jpegdec_comp_dev *cjpeg =
 		container_of(work, struct mtk_jpegdec_comp_dev,
 			     job_timeout_work.work);
+	struct mtk_jpeg_dev *master_jpeg = cjpeg->master_dev;
 	struct vb2_v4l2_buffer *src_buf, *dst_buf;
 
 	src_buf = cjpeg->hw_param.src_buffer;
@@ -455,6 +456,9 @@ static void mtk_jpegdec_timeout_work(struct work_struct *work)
 	mtk_jpeg_dec_reset(cjpeg->reg_base);
 	clk_disable_unprepare(cjpeg->jdec_clk.clks->clk);
 	pm_runtime_put(cjpeg->dev);
+	cjpeg->hw_state = MTK_JPEG_HW_IDLE;
+	atomic_inc(&master_jpeg->dechw_rdy);
+	wake_up(&master_jpeg->dec_hw_wq);
 	v4l2_m2m_buf_done(src_buf, buf_state);
 	v4l2_m2m_buf_done(dst_buf, buf_state);
 }
@@ -474,22 +478,19 @@ static irqreturn_t mtk_jpegdec_hw_irq_handler(int irq, void *priv)
 
 	cancel_delayed_work(&jpeg->job_timeout_work);
 
+	ctx = jpeg->hw_param.curr_ctx;
+	src_buf = jpeg->hw_param.src_buffer;
+	dst_buf = jpeg->hw_param.dst_buffer;
+	v4l2_m2m_buf_copy_metadata(src_buf, dst_buf, true);
+
 	irq_status = mtk_jpeg_dec_get_int_status(jpeg->reg_base);
 	dec_irq_ret = mtk_jpeg_dec_enum_result(irq_status);
 	if (dec_irq_ret >= MTK_JPEG_DEC_RESULT_UNDERFLOW)
 		mtk_jpeg_dec_reset(jpeg->reg_base);
-	if (dec_irq_ret != MTK_JPEG_DEC_RESULT_EOF_DONE)
-		return IRQ_NONE;
 
-	ctx = v4l2_m2m_get_curr_priv(master_jpeg->m2m_dev);
-	if (!ctx) {
-		dev_err(jpeg->dev, "Context is NULL\n");
-		return IRQ_HANDLED;
-	}
+	if (dec_irq_ret != MTK_JPEG_DEC_RESULT_EOF_DONE)
+		dev_warn(jpeg->dev, "Jpg Dec occurs unknown Err.");
 
-	src_buf = v4l2_m2m_src_buf_remove(ctx->fh.m2m_ctx);
-	dst_buf = v4l2_m2m_dst_buf_remove(ctx->fh.m2m_ctx);
-	v4l2_m2m_buf_copy_metadata(src_buf, dst_buf, true);
 	jpeg_src_buf =
 		container_of(src_buf, struct mtk_jpeg_src_buf, b);
 
@@ -498,11 +499,14 @@ static irqreturn_t mtk_jpegdec_hw_irq_handler(int irq, void *priv)
 				      jpeg_src_buf->dec_param.comp_size[i]);
 
 	buf_state = VB2_BUF_STATE_DONE;
-
 	v4l2_m2m_buf_done(src_buf, buf_state);
 	v4l2_m2m_buf_done(dst_buf, buf_state);
-	v4l2_m2m_job_finish(master_jpeg->m2m_dev, ctx->fh.m2m_ctx);
 	pm_runtime_put(ctx->jpeg->dev);
+	clk_disable_unprepare(jpeg->jdec_clk.clks->clk);
+
+	jpeg->hw_state = MTK_JPEG_HW_IDLE;
+	wake_up(&master_jpeg->dec_hw_wq);
+	atomic_inc(&master_jpeg->dechw_rdy);
 
 	return IRQ_HANDLED;
 }
@@ -557,8 +561,19 @@ static int mtk_jpegdec_hw_probe(struct platform_device *pdev)
 		master_dev->is_jpgdec_multihw = true;
 		for (i = 0; i < MTK_JPEGDEC_HW_MAX; i++)
 			master_dev->dec_hw_dev[i] = NULL;
+
+		init_waitqueue_head(&master_dev->dec_hw_wq);
+		master_dev->workqueue = alloc_ordered_workqueue(MTK_JPEG_NAME,
+								WQ_MEM_RECLAIM
+								| WQ_FREEZABLE);
+		if (!master_dev->workqueue)
+			return -EINVAL;
 	}
 
+	atomic_set(&master_dev->dechw_rdy, MTK_JPEGDEC_HW_MAX);
+	spin_lock_init(&dev->hw_lock);
+	dev->hw_state = MTK_JPEG_HW_IDLE;
+
 	INIT_DELAYED_WORK(&dev->job_timeout_work,
 			  mtk_jpegdec_timeout_work);
 
-- 
2.18.0

