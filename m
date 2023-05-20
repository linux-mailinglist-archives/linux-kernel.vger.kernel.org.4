Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C61370ABAD
	for <lists+linux-kernel@lfdr.de>; Sun, 21 May 2023 01:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbjETXl6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 19:41:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjETXl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 19:41:56 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 202BD13E;
        Sat, 20 May 2023 16:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=1B7KJxHgGHRJTk/mrOQOrs0VFb4S4S6htFZJMQeoy/4=; b=0ip2nNLSyHISmKS1/roz1/DksP
        S7aC4m8BjBkOh5E21qW76QrWdRUl42GFAW2lW4r6w3FcMXWvyQuehPAbrMpsNdoxZwgqa2ZVzzXt9
        a0eLIcK6y1d5OzTd6P1hwLBxl053YYnQxE8sjyjA0Y8qerhOxhsopBo4xWMF6izEsIkAKvA0M9cQJ
        d1P5Rt/ZBj+R26W3fdeN4/mVRcDfY3AVSJhUhzi67cmOlMZVlVFqlWNOUB5HHbJs7VWQ8whDyUoL9
        86AsilQB+vzejuyKdtEy6yJoFjstXlNIH0MX2is4ESGMAr5yxeqnSJIjcyorVEvy4Iwne2XVlA8nb
        WekTcs2g==;
Received: from [2601:1c2:980:9ec0::2764] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q0WCl-002YGL-1Q;
        Sat, 20 May 2023 23:41:46 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Bin Liu <bin.liu@mediatek.com>,
        oushixiong <oushixiong@kylinos.cn>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>, linux-media@vger.kernel.org
Subject: [PATCH] media: mtk-jpeg: move data/code inside CONFIG_OF blocks
Date:   Sat, 20 May 2023 16:41:42 -0700
Message-Id: <20230520234142.23948-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lots of data and functions here are not needed when CONFIG_OF is not
set, so move them inside #ifdef CONFIG_OF blocks to prevent the warnings.

../drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c:1645:29: warning: ‘mtk_jpeg_clocks’ defined but not used [-Wunused-variable]
 1645 | static struct clk_bulk_data mtk_jpeg_clocks[] = {
../drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c:1640:29: warning: ‘mt8173_jpeg_dec_clocks’ defined but not used [-Wunused-variable]
 1640 | static struct clk_bulk_data mt8173_jpeg_dec_clocks[] = {
../drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c:1481:20: warning: ‘mtk_jpeg_dec_irq’ defined but not used [-Wunused-function]
 1481 | static irqreturn_t mtk_jpeg_dec_irq(int irq, void *priv)
../drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c:1461:20: warning: ‘mtk_jpeg_enc_irq’ defined but not used [-Wunused-function]
 1461 | static irqreturn_t mtk_jpeg_enc_irq(int irq, void *priv)
../drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c:1180:13: warning: ‘mtk_jpegdec_worker’ defined but not used [-Wunused-function]
 1180 | static void mtk_jpegdec_worker(struct work_struct *work)
../drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c:986:13: warning: ‘mtk_jpegenc_worker’ defined but not used [-Wunused-function]
  986 | static void mtk_jpegenc_worker(struct work_struct *work)
../drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c:79:28: warning: ‘mtk_jpeg_dec_formats’ defined but not used [-Wunused-variable]
   79 | static struct mtk_jpeg_fmt mtk_jpeg_dec_formats[] = {
../drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c:31:28: warning: ‘mtk_jpeg_enc_formats’ defined but not used [-Wunused-variable]
   31 | static struct mtk_jpeg_fmt mtk_jpeg_enc_formats[] = {
../drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c:1222:20: warning: ‘mtk_jpeg_enc_done’ defined but not used [-Wunused-function]
 1222 | static irqreturn_t mtk_jpeg_enc_done(struct mtk_jpeg_dev *jpeg)
../drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c:1072:12: warning: ‘mtk_jpegdec_set_hw_param’ defined but not used [-Wunused-function]
 1072 | static int mtk_jpegdec_set_hw_param(struct mtk_jpeg_ctx *ctx,
../drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c:1060:12: warning: ‘mtk_jpegdec_put_hw’ defined but not used [-Wunused-function]
 1060 | static int mtk_jpegdec_put_hw(struct mtk_jpeg_dev *jpeg, int hw_id)
../drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c:1038:12: warning: ‘mtk_jpegdec_get_hw’ defined but not used [-Wunused-function]
 1038 | static int mtk_jpegdec_get_hw(struct mtk_jpeg_ctx *ctx)
../drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c:977:12: warning: ‘mtk_jpegenc_put_hw’ defined but not used [-Wunused-function]
  977 | static int mtk_jpegenc_put_hw(struct mtk_jpeg_dev *jpeg, int hw_id)
../drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c:963:12: warning: ‘mtk_jpegenc_set_hw_param’ defined but not used [-Wunused-function]
  963 | static int mtk_jpegenc_set_hw_param(struct mtk_jpeg_ctx *ctx,
../drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c:941:12: warning: ‘mtk_jpegenc_get_hw’ defined but not used [-Wunused-function]
  941 | static int mtk_jpegenc_get_hw(struct mtk_jpeg_ctx *ctx)

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/linux-media/202305042146.j4ZxuvpM-lkp@intel.com/
Cc: Bin Liu <bin.liu@mediatek.com>
Cc: oushixiong <oushixiong@kylinos.cn>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Hans Verkuil <hverkuil@xs4all.nl>
Cc: linux-media@vger.kernel.org
---
 drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c |  828 +++++-----
 1 file changed, 415 insertions(+), 413 deletions(-)

diff -- a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
--- a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
+++ b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
@@ -28,6 +28,7 @@
 #include "mtk_jpeg_core.h"
 #include "mtk_jpeg_dec_parse.h"
 
+#if defined(CONFIG_OF)
 static struct mtk_jpeg_fmt mtk_jpeg_enc_formats[] = {
 	{
 		.fourcc		= V4L2_PIX_FMT_JPEG,
@@ -101,6 +102,7 @@ static struct mtk_jpeg_fmt mtk_jpeg_dec_
 		.flags		= MTK_JPEG_FMT_FLAG_CAPTURE,
 	},
 };
+#endif
 
 #define MTK_JPEG_ENC_NUM_FORMATS ARRAY_SIZE(mtk_jpeg_enc_formats)
 #define MTK_JPEG_DEC_NUM_FORMATS ARRAY_SIZE(mtk_jpeg_dec_formats)
@@ -936,148 +938,6 @@ static int mtk_jpeg_set_dec_dst(struct m
 	return 0;
 }
 
-static int mtk_jpegenc_get_hw(struct mtk_jpeg_ctx *ctx)
-{
-	struct mtk_jpegenc_comp_dev *comp_jpeg;
-	struct mtk_jpeg_dev *jpeg = ctx->jpeg;
-	unsigned long flags;
-	int hw_id = -1;
-	int i;
-
-	spin_lock_irqsave(&jpeg->hw_lock, flags);
-	for (i = 0; i < MTK_JPEGENC_HW_MAX; i++) {
-		comp_jpeg = jpeg->enc_hw_dev[i];
-		if (comp_jpeg->hw_state == MTK_JPEG_HW_IDLE) {
-			hw_id = i;
-			comp_jpeg->hw_state = MTK_JPEG_HW_BUSY;
-			break;
-		}
-	}
-	spin_unlock_irqrestore(&jpeg->hw_lock, flags);
-
-	return hw_id;
-}
-
-static int mtk_jpegenc_set_hw_param(struct mtk_jpeg_ctx *ctx,
-				    int hw_id,
-				    struct vb2_v4l2_buffer *src_buf,
-				    struct vb2_v4l2_buffer *dst_buf)
-{
-	struct mtk_jpegenc_comp_dev *jpeg = ctx->jpeg->enc_hw_dev[hw_id];
-
-	jpeg->hw_param.curr_ctx = ctx;
-	jpeg->hw_param.src_buffer = src_buf;
-	jpeg->hw_param.dst_buffer = dst_buf;
-
-	return 0;
-}
-
-static int mtk_jpegenc_put_hw(struct mtk_jpeg_dev *jpeg, int hw_id)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&jpeg->hw_lock, flags);
-	jpeg->enc_hw_dev[hw_id]->hw_state = MTK_JPEG_HW_IDLE;
-	spin_unlock_irqrestore(&jpeg->hw_lock, flags);
-
-	return 0;
-}
-
-static void mtk_jpegenc_worker(struct work_struct *work)
-{
-	struct mtk_jpegenc_comp_dev *comp_jpeg[MTK_JPEGENC_HW_MAX];
-	enum vb2_buffer_state buf_state = VB2_BUF_STATE_ERROR;
-	struct mtk_jpeg_src_buf *jpeg_dst_buf;
-	struct vb2_v4l2_buffer *src_buf, *dst_buf;
-	int ret, i, hw_id = 0;
-	unsigned long flags;
-
-	struct mtk_jpeg_ctx *ctx = container_of(work,
-		struct mtk_jpeg_ctx,
-		jpeg_work);
-	struct mtk_jpeg_dev *jpeg = ctx->jpeg;
-
-	for (i = 0; i < MTK_JPEGENC_HW_MAX; i++)
-		comp_jpeg[i] = jpeg->enc_hw_dev[i];
-	i = 0;
-
-retry_select:
-	hw_id = mtk_jpegenc_get_hw(ctx);
-	if (hw_id < 0) {
-		ret = wait_event_interruptible(jpeg->hw_wq,
-					       atomic_read(&jpeg->hw_rdy) > 0);
-		if (ret != 0 || (i++ > MTK_JPEG_MAX_RETRY_TIME)) {
-			dev_err(jpeg->dev, "%s : %d, all HW are busy\n",
-				__func__, __LINE__);
-			v4l2_m2m_job_finish(jpeg->m2m_dev, ctx->fh.m2m_ctx);
-			return;
-		}
-
-		goto retry_select;
-	}
-
-	atomic_dec(&jpeg->hw_rdy);
-	src_buf = v4l2_m2m_next_src_buf(ctx->fh.m2m_ctx);
-	if (!src_buf)
-		goto getbuf_fail;
-
-	dst_buf = v4l2_m2m_next_dst_buf(ctx->fh.m2m_ctx);
-	if (!dst_buf)
-		goto getbuf_fail;
-
-	v4l2_m2m_buf_copy_metadata(src_buf, dst_buf, true);
-
-	mtk_jpegenc_set_hw_param(ctx, hw_id, src_buf, dst_buf);
-	ret = pm_runtime_get_sync(comp_jpeg[hw_id]->dev);
-	if (ret < 0) {
-		dev_err(jpeg->dev, "%s : %d, pm_runtime_get_sync fail !!!\n",
-			__func__, __LINE__);
-		goto enc_end;
-	}
-
-	ret = clk_prepare_enable(comp_jpeg[hw_id]->venc_clk.clks->clk);
-	if (ret) {
-		dev_err(jpeg->dev, "%s : %d, jpegenc clk_prepare_enable fail\n",
-			__func__, __LINE__);
-		goto enc_end;
-	}
-
-	v4l2_m2m_src_buf_remove(ctx->fh.m2m_ctx);
-	v4l2_m2m_dst_buf_remove(ctx->fh.m2m_ctx);
-
-	schedule_delayed_work(&comp_jpeg[hw_id]->job_timeout_work,
-			      msecs_to_jiffies(MTK_JPEG_HW_TIMEOUT_MSEC));
-
-	spin_lock_irqsave(&comp_jpeg[hw_id]->hw_lock, flags);
-	jpeg_dst_buf = mtk_jpeg_vb2_to_srcbuf(&dst_buf->vb2_buf);
-	jpeg_dst_buf->curr_ctx = ctx;
-	jpeg_dst_buf->frame_num = ctx->total_frame_num;
-	ctx->total_frame_num++;
-	mtk_jpeg_enc_reset(comp_jpeg[hw_id]->reg_base);
-	mtk_jpeg_set_enc_dst(ctx,
-			     comp_jpeg[hw_id]->reg_base,
-			     &dst_buf->vb2_buf);
-	mtk_jpeg_set_enc_src(ctx,
-			     comp_jpeg[hw_id]->reg_base,
-			     &src_buf->vb2_buf);
-	mtk_jpeg_set_enc_params(ctx, comp_jpeg[hw_id]->reg_base);
-	mtk_jpeg_enc_start(comp_jpeg[hw_id]->reg_base);
-	v4l2_m2m_job_finish(jpeg->m2m_dev, ctx->fh.m2m_ctx);
-	spin_unlock_irqrestore(&comp_jpeg[hw_id]->hw_lock, flags);
-
-	return;
-
-enc_end:
-	v4l2_m2m_src_buf_remove(ctx->fh.m2m_ctx);
-	v4l2_m2m_dst_buf_remove(ctx->fh.m2m_ctx);
-	v4l2_m2m_buf_done(src_buf, buf_state);
-	v4l2_m2m_buf_done(dst_buf, buf_state);
-getbuf_fail:
-	atomic_inc(&jpeg->hw_rdy);
-	mtk_jpegenc_put_hw(jpeg, hw_id);
-	v4l2_m2m_job_finish(jpeg->m2m_dev, ctx->fh.m2m_ctx);
-}
-
 static void mtk_jpeg_enc_device_run(void *priv)
 {
 	struct mtk_jpeg_ctx *ctx = priv;
@@ -1128,173 +988,6 @@ static void mtk_jpeg_multicore_enc_devic
 	queue_work(jpeg->workqueue, &ctx->jpeg_work);
 }
 
-static int mtk_jpegdec_get_hw(struct mtk_jpeg_ctx *ctx)
-{
-	struct mtk_jpegdec_comp_dev *comp_jpeg;
-	struct mtk_jpeg_dev *jpeg = ctx->jpeg;
-	unsigned long flags;
-	int hw_id = -1;
-	int i;
-
-	spin_lock_irqsave(&jpeg->hw_lock, flags);
-	for (i = 0; i < MTK_JPEGDEC_HW_MAX; i++) {
-		comp_jpeg = jpeg->dec_hw_dev[i];
-		if (comp_jpeg->hw_state == MTK_JPEG_HW_IDLE) {
-			hw_id = i;
-			comp_jpeg->hw_state = MTK_JPEG_HW_BUSY;
-			break;
-		}
-	}
-	spin_unlock_irqrestore(&jpeg->hw_lock, flags);
-
-	return hw_id;
-}
-
-static int mtk_jpegdec_put_hw(struct mtk_jpeg_dev *jpeg, int hw_id)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&jpeg->hw_lock, flags);
-	jpeg->dec_hw_dev[hw_id]->hw_state =
-		MTK_JPEG_HW_IDLE;
-	spin_unlock_irqrestore(&jpeg->hw_lock, flags);
-
-	return 0;
-}
-
-static int mtk_jpegdec_set_hw_param(struct mtk_jpeg_ctx *ctx,
-				    int hw_id,
-				    struct vb2_v4l2_buffer *src_buf,
-				    struct vb2_v4l2_buffer *dst_buf)
-{
-	struct mtk_jpegdec_comp_dev *jpeg =
-		ctx->jpeg->dec_hw_dev[hw_id];
-
-	jpeg->hw_param.curr_ctx = ctx;
-	jpeg->hw_param.src_buffer = src_buf;
-	jpeg->hw_param.dst_buffer = dst_buf;
-
-	return 0;
-}
-
-static void mtk_jpegdec_worker(struct work_struct *work)
-{
-	struct mtk_jpeg_ctx *ctx = container_of(work, struct mtk_jpeg_ctx,
-		jpeg_work);
-	struct mtk_jpegdec_comp_dev *comp_jpeg[MTK_JPEGDEC_HW_MAX];
-	enum vb2_buffer_state buf_state = VB2_BUF_STATE_ERROR;
-	struct mtk_jpeg_src_buf *jpeg_src_buf, *jpeg_dst_buf;
-	struct vb2_v4l2_buffer *src_buf, *dst_buf;
-	struct mtk_jpeg_dev *jpeg = ctx->jpeg;
-	int ret, i, hw_id = 0;
-	struct mtk_jpeg_bs bs;
-	struct mtk_jpeg_fb fb;
-	unsigned long flags;
-
-	for (i = 0; i < MTK_JPEGDEC_HW_MAX; i++)
-		comp_jpeg[i] = jpeg->dec_hw_dev[i];
-	i = 0;
-
-retry_select:
-	hw_id = mtk_jpegdec_get_hw(ctx);
-	if (hw_id < 0) {
-		ret = wait_event_interruptible_timeout(jpeg->hw_wq,
-						       atomic_read(&jpeg->hw_rdy) > 0,
-						       MTK_JPEG_HW_TIMEOUT_MSEC);
-		if (ret != 0 || (i++ > MTK_JPEG_MAX_RETRY_TIME)) {
-			dev_err(jpeg->dev, "%s : %d, all HW are busy\n",
-				__func__, __LINE__);
-			v4l2_m2m_job_finish(jpeg->m2m_dev, ctx->fh.m2m_ctx);
-			return;
-		}
-
-		goto retry_select;
-	}
-
-	atomic_dec(&jpeg->hw_rdy);
-	src_buf = v4l2_m2m_next_src_buf(ctx->fh.m2m_ctx);
-	if (!src_buf)
-		goto getbuf_fail;
-
-	dst_buf = v4l2_m2m_next_dst_buf(ctx->fh.m2m_ctx);
-	if (!dst_buf)
-		goto getbuf_fail;
-
-	v4l2_m2m_buf_copy_metadata(src_buf, dst_buf, true);
-	jpeg_src_buf = mtk_jpeg_vb2_to_srcbuf(&src_buf->vb2_buf);
-	jpeg_dst_buf = mtk_jpeg_vb2_to_srcbuf(&dst_buf->vb2_buf);
-
-	if (mtk_jpeg_check_resolution_change(ctx,
-					     &jpeg_src_buf->dec_param)) {
-		mtk_jpeg_queue_src_chg_event(ctx);
-		ctx->state = MTK_JPEG_SOURCE_CHANGE;
-		goto getbuf_fail;
-	}
-
-	jpeg_src_buf->curr_ctx = ctx;
-	jpeg_src_buf->frame_num = ctx->total_frame_num;
-	jpeg_dst_buf->curr_ctx = ctx;
-	jpeg_dst_buf->frame_num = ctx->total_frame_num;
-
-	mtk_jpegdec_set_hw_param(ctx, hw_id, src_buf, dst_buf);
-	ret = pm_runtime_get_sync(comp_jpeg[hw_id]->dev);
-	if (ret < 0) {
-		dev_err(jpeg->dev, "%s : %d, pm_runtime_get_sync fail !!!\n",
-			__func__, __LINE__);
-		goto dec_end;
-	}
-
-	ret = clk_prepare_enable(comp_jpeg[hw_id]->jdec_clk.clks->clk);
-	if (ret) {
-		dev_err(jpeg->dev, "%s : %d, jpegdec clk_prepare_enable fail\n",
-			__func__, __LINE__);
-		goto clk_end;
-	}
-
-	v4l2_m2m_src_buf_remove(ctx->fh.m2m_ctx);
-	v4l2_m2m_dst_buf_remove(ctx->fh.m2m_ctx);
-
-	schedule_delayed_work(&comp_jpeg[hw_id]->job_timeout_work,
-			      msecs_to_jiffies(MTK_JPEG_HW_TIMEOUT_MSEC));
-
-	mtk_jpeg_set_dec_src(ctx, &src_buf->vb2_buf, &bs);
-	if (mtk_jpeg_set_dec_dst(ctx,
-				 &jpeg_src_buf->dec_param,
-				 &dst_buf->vb2_buf, &fb)) {
-		dev_err(jpeg->dev, "%s : %d, mtk_jpeg_set_dec_dst fail\n",
-			__func__, __LINE__);
-		goto setdst_end;
-	}
-
-	spin_lock_irqsave(&comp_jpeg[hw_id]->hw_lock, flags);
-	ctx->total_frame_num++;
-	mtk_jpeg_dec_reset(comp_jpeg[hw_id]->reg_base);
-	mtk_jpeg_dec_set_config(comp_jpeg[hw_id]->reg_base,
-				&jpeg_src_buf->dec_param,
-				jpeg_src_buf->bs_size,
-				&bs,
-				&fb);
-	mtk_jpeg_dec_start(comp_jpeg[hw_id]->reg_base);
-	v4l2_m2m_job_finish(jpeg->m2m_dev, ctx->fh.m2m_ctx);
-	spin_unlock_irqrestore(&comp_jpeg[hw_id]->hw_lock, flags);
-
-	return;
-
-setdst_end:
-	clk_disable_unprepare(comp_jpeg[hw_id]->jdec_clk.clks->clk);
-clk_end:
-	pm_runtime_put(comp_jpeg[hw_id]->dev);
-dec_end:
-	v4l2_m2m_src_buf_remove(ctx->fh.m2m_ctx);
-	v4l2_m2m_dst_buf_remove(ctx->fh.m2m_ctx);
-	v4l2_m2m_buf_done(src_buf, buf_state);
-	v4l2_m2m_buf_done(dst_buf, buf_state);
-getbuf_fail:
-	atomic_inc(&jpeg->hw_rdy);
-	mtk_jpegdec_put_hw(jpeg, hw_id);
-	v4l2_m2m_job_finish(jpeg->m2m_dev, ctx->fh.m2m_ctx);
-}
-
 static void mtk_jpeg_multicore_dec_device_run(void *priv)
 {
 	struct mtk_jpeg_ctx *ctx = priv;
@@ -1430,101 +1123,6 @@ static void mtk_jpeg_clk_off(struct mtk_
 				   jpeg->variant->clks);
 }
 
-static irqreturn_t mtk_jpeg_enc_done(struct mtk_jpeg_dev *jpeg)
-{
-	struct mtk_jpeg_ctx *ctx;
-	struct vb2_v4l2_buffer *src_buf, *dst_buf;
-	enum vb2_buffer_state buf_state = VB2_BUF_STATE_ERROR;
-	u32 result_size;
-
-	ctx = v4l2_m2m_get_curr_priv(jpeg->m2m_dev);
-	if (!ctx) {
-		v4l2_err(&jpeg->v4l2_dev, "Context is NULL\n");
-		return IRQ_HANDLED;
-	}
-
-	src_buf = v4l2_m2m_src_buf_remove(ctx->fh.m2m_ctx);
-	dst_buf = v4l2_m2m_dst_buf_remove(ctx->fh.m2m_ctx);
-
-	result_size = mtk_jpeg_enc_get_file_size(jpeg->reg_base);
-	vb2_set_plane_payload(&dst_buf->vb2_buf, 0, result_size);
-
-	buf_state = VB2_BUF_STATE_DONE;
-
-	v4l2_m2m_buf_done(src_buf, buf_state);
-	v4l2_m2m_buf_done(dst_buf, buf_state);
-	v4l2_m2m_job_finish(jpeg->m2m_dev, ctx->fh.m2m_ctx);
-	pm_runtime_put(ctx->jpeg->dev);
-	return IRQ_HANDLED;
-}
-
-static irqreturn_t mtk_jpeg_enc_irq(int irq, void *priv)
-{
-	struct mtk_jpeg_dev *jpeg = priv;
-	u32 irq_status;
-	irqreturn_t ret = IRQ_NONE;
-
-	cancel_delayed_work(&jpeg->job_timeout_work);
-
-	irq_status = readl(jpeg->reg_base + JPEG_ENC_INT_STS) &
-		     JPEG_ENC_INT_STATUS_MASK_ALLIRQ;
-	if (irq_status)
-		writel(0, jpeg->reg_base + JPEG_ENC_INT_STS);
-
-	if (!(irq_status & JPEG_ENC_INT_STATUS_DONE))
-		return ret;
-
-	ret = mtk_jpeg_enc_done(jpeg);
-	return ret;
-}
-
-static irqreturn_t mtk_jpeg_dec_irq(int irq, void *priv)
-{
-	struct mtk_jpeg_dev *jpeg = priv;
-	struct mtk_jpeg_ctx *ctx;
-	struct vb2_v4l2_buffer *src_buf, *dst_buf;
-	struct mtk_jpeg_src_buf *jpeg_src_buf;
-	enum vb2_buffer_state buf_state = VB2_BUF_STATE_ERROR;
-	u32	dec_irq_ret;
-	u32 dec_ret;
-	int i;
-
-	cancel_delayed_work(&jpeg->job_timeout_work);
-
-	dec_ret = mtk_jpeg_dec_get_int_status(jpeg->reg_base);
-	dec_irq_ret = mtk_jpeg_dec_enum_result(dec_ret);
-	ctx = v4l2_m2m_get_curr_priv(jpeg->m2m_dev);
-	if (!ctx) {
-		v4l2_err(&jpeg->v4l2_dev, "Context is NULL\n");
-		return IRQ_HANDLED;
-	}
-
-	src_buf = v4l2_m2m_src_buf_remove(ctx->fh.m2m_ctx);
-	dst_buf = v4l2_m2m_dst_buf_remove(ctx->fh.m2m_ctx);
-	jpeg_src_buf = mtk_jpeg_vb2_to_srcbuf(&src_buf->vb2_buf);
-
-	if (dec_irq_ret >= MTK_JPEG_DEC_RESULT_UNDERFLOW)
-		mtk_jpeg_dec_reset(jpeg->reg_base);
-
-	if (dec_irq_ret != MTK_JPEG_DEC_RESULT_EOF_DONE) {
-		dev_err(jpeg->dev, "decode failed\n");
-		goto dec_end;
-	}
-
-	for (i = 0; i < dst_buf->vb2_buf.num_planes; i++)
-		vb2_set_plane_payload(&dst_buf->vb2_buf, i,
-				      jpeg_src_buf->dec_param.comp_size[i]);
-
-	buf_state = VB2_BUF_STATE_DONE;
-
-dec_end:
-	v4l2_m2m_buf_done(src_buf, buf_state);
-	v4l2_m2m_buf_done(dst_buf, buf_state);
-	v4l2_m2m_job_finish(jpeg->m2m_dev, ctx->fh.m2m_ctx);
-	pm_runtime_put(ctx->jpeg->dev);
-	return IRQ_HANDLED;
-}
-
 static void mtk_jpeg_set_default_params(struct mtk_jpeg_ctx *ctx)
 {
 	struct mtk_jpeg_q_data *q = &ctx->out_q;
@@ -1637,15 +1235,6 @@ static const struct v4l2_file_operations
 	.mmap           = v4l2_m2m_fop_mmap,
 };
 
-static struct clk_bulk_data mt8173_jpeg_dec_clocks[] = {
-	{ .id = "jpgdec-smi" },
-	{ .id = "jpgdec" },
-};
-
-static struct clk_bulk_data mtk_jpeg_clocks[] = {
-	{ .id = "jpgenc" },
-};
-
 static void mtk_jpeg_job_timeout_work(struct work_struct *work)
 {
 	struct mtk_jpeg_dev *jpeg = container_of(work, struct mtk_jpeg_dev,
@@ -1867,6 +1456,419 @@ static const struct dev_pm_ops mtk_jpeg_
 };
 
 #if defined(CONFIG_OF)
+static int mtk_jpegenc_get_hw(struct mtk_jpeg_ctx *ctx)
+{
+	struct mtk_jpegenc_comp_dev *comp_jpeg;
+	struct mtk_jpeg_dev *jpeg = ctx->jpeg;
+	unsigned long flags;
+	int hw_id = -1;
+	int i;
+
+	spin_lock_irqsave(&jpeg->hw_lock, flags);
+	for (i = 0; i < MTK_JPEGENC_HW_MAX; i++) {
+		comp_jpeg = jpeg->enc_hw_dev[i];
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
+static int mtk_jpegenc_set_hw_param(struct mtk_jpeg_ctx *ctx,
+				    int hw_id,
+				    struct vb2_v4l2_buffer *src_buf,
+				    struct vb2_v4l2_buffer *dst_buf)
+{
+	struct mtk_jpegenc_comp_dev *jpeg = ctx->jpeg->enc_hw_dev[hw_id];
+
+	jpeg->hw_param.curr_ctx = ctx;
+	jpeg->hw_param.src_buffer = src_buf;
+	jpeg->hw_param.dst_buffer = dst_buf;
+
+	return 0;
+}
+
+static int mtk_jpegenc_put_hw(struct mtk_jpeg_dev *jpeg, int hw_id)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&jpeg->hw_lock, flags);
+	jpeg->enc_hw_dev[hw_id]->hw_state = MTK_JPEG_HW_IDLE;
+	spin_unlock_irqrestore(&jpeg->hw_lock, flags);
+
+	return 0;
+}
+
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
+static irqreturn_t mtk_jpeg_enc_done(struct mtk_jpeg_dev *jpeg)
+{
+	struct mtk_jpeg_ctx *ctx;
+	struct vb2_v4l2_buffer *src_buf, *dst_buf;
+	enum vb2_buffer_state buf_state = VB2_BUF_STATE_ERROR;
+	u32 result_size;
+
+	ctx = v4l2_m2m_get_curr_priv(jpeg->m2m_dev);
+	if (!ctx) {
+		v4l2_err(&jpeg->v4l2_dev, "Context is NULL\n");
+		return IRQ_HANDLED;
+	}
+
+	src_buf = v4l2_m2m_src_buf_remove(ctx->fh.m2m_ctx);
+	dst_buf = v4l2_m2m_dst_buf_remove(ctx->fh.m2m_ctx);
+
+	result_size = mtk_jpeg_enc_get_file_size(jpeg->reg_base);
+	vb2_set_plane_payload(&dst_buf->vb2_buf, 0, result_size);
+
+	buf_state = VB2_BUF_STATE_DONE;
+
+	v4l2_m2m_buf_done(src_buf, buf_state);
+	v4l2_m2m_buf_done(dst_buf, buf_state);
+	v4l2_m2m_job_finish(jpeg->m2m_dev, ctx->fh.m2m_ctx);
+	pm_runtime_put(ctx->jpeg->dev);
+	return IRQ_HANDLED;
+}
+
+static void mtk_jpegenc_worker(struct work_struct *work)
+{
+	struct mtk_jpegenc_comp_dev *comp_jpeg[MTK_JPEGENC_HW_MAX];
+	enum vb2_buffer_state buf_state = VB2_BUF_STATE_ERROR;
+	struct mtk_jpeg_src_buf *jpeg_dst_buf;
+	struct vb2_v4l2_buffer *src_buf, *dst_buf;
+	int ret, i, hw_id = 0;
+	unsigned long flags;
+
+	struct mtk_jpeg_ctx *ctx = container_of(work,
+		struct mtk_jpeg_ctx,
+		jpeg_work);
+	struct mtk_jpeg_dev *jpeg = ctx->jpeg;
+
+	for (i = 0; i < MTK_JPEGENC_HW_MAX; i++)
+		comp_jpeg[i] = jpeg->enc_hw_dev[i];
+	i = 0;
+
+retry_select:
+	hw_id = mtk_jpegenc_get_hw(ctx);
+	if (hw_id < 0) {
+		ret = wait_event_interruptible(jpeg->hw_wq,
+					       atomic_read(&jpeg->hw_rdy) > 0);
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
+	atomic_dec(&jpeg->hw_rdy);
+	src_buf = v4l2_m2m_next_src_buf(ctx->fh.m2m_ctx);
+	if (!src_buf)
+		goto getbuf_fail;
+
+	dst_buf = v4l2_m2m_next_dst_buf(ctx->fh.m2m_ctx);
+	if (!dst_buf)
+		goto getbuf_fail;
+
+	v4l2_m2m_buf_copy_metadata(src_buf, dst_buf, true);
+
+	mtk_jpegenc_set_hw_param(ctx, hw_id, src_buf, dst_buf);
+	ret = pm_runtime_get_sync(comp_jpeg[hw_id]->dev);
+	if (ret < 0) {
+		dev_err(jpeg->dev, "%s : %d, pm_runtime_get_sync fail !!!\n",
+			__func__, __LINE__);
+		goto enc_end;
+	}
+
+	ret = clk_prepare_enable(comp_jpeg[hw_id]->venc_clk.clks->clk);
+	if (ret) {
+		dev_err(jpeg->dev, "%s : %d, jpegenc clk_prepare_enable fail\n",
+			__func__, __LINE__);
+		goto enc_end;
+	}
+
+	v4l2_m2m_src_buf_remove(ctx->fh.m2m_ctx);
+	v4l2_m2m_dst_buf_remove(ctx->fh.m2m_ctx);
+
+	schedule_delayed_work(&comp_jpeg[hw_id]->job_timeout_work,
+			      msecs_to_jiffies(MTK_JPEG_HW_TIMEOUT_MSEC));
+
+	spin_lock_irqsave(&comp_jpeg[hw_id]->hw_lock, flags);
+	jpeg_dst_buf = mtk_jpeg_vb2_to_srcbuf(&dst_buf->vb2_buf);
+	jpeg_dst_buf->curr_ctx = ctx;
+	jpeg_dst_buf->frame_num = ctx->total_frame_num;
+	ctx->total_frame_num++;
+	mtk_jpeg_enc_reset(comp_jpeg[hw_id]->reg_base);
+	mtk_jpeg_set_enc_dst(ctx,
+			     comp_jpeg[hw_id]->reg_base,
+			     &dst_buf->vb2_buf);
+	mtk_jpeg_set_enc_src(ctx,
+			     comp_jpeg[hw_id]->reg_base,
+			     &src_buf->vb2_buf);
+	mtk_jpeg_set_enc_params(ctx, comp_jpeg[hw_id]->reg_base);
+	mtk_jpeg_enc_start(comp_jpeg[hw_id]->reg_base);
+	v4l2_m2m_job_finish(jpeg->m2m_dev, ctx->fh.m2m_ctx);
+	spin_unlock_irqrestore(&comp_jpeg[hw_id]->hw_lock, flags);
+
+	return;
+
+enc_end:
+	v4l2_m2m_src_buf_remove(ctx->fh.m2m_ctx);
+	v4l2_m2m_dst_buf_remove(ctx->fh.m2m_ctx);
+	v4l2_m2m_buf_done(src_buf, buf_state);
+	v4l2_m2m_buf_done(dst_buf, buf_state);
+getbuf_fail:
+	atomic_inc(&jpeg->hw_rdy);
+	mtk_jpegenc_put_hw(jpeg, hw_id);
+	v4l2_m2m_job_finish(jpeg->m2m_dev, ctx->fh.m2m_ctx);
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
+		ret = wait_event_interruptible_timeout(jpeg->hw_wq,
+						       atomic_read(&jpeg->hw_rdy) > 0,
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
+	atomic_dec(&jpeg->hw_rdy);
+	src_buf = v4l2_m2m_next_src_buf(ctx->fh.m2m_ctx);
+	if (!src_buf)
+		goto getbuf_fail;
+
+	dst_buf = v4l2_m2m_next_dst_buf(ctx->fh.m2m_ctx);
+	if (!dst_buf)
+		goto getbuf_fail;
+
+	v4l2_m2m_buf_copy_metadata(src_buf, dst_buf, true);
+	jpeg_src_buf = mtk_jpeg_vb2_to_srcbuf(&src_buf->vb2_buf);
+	jpeg_dst_buf = mtk_jpeg_vb2_to_srcbuf(&dst_buf->vb2_buf);
+
+	if (mtk_jpeg_check_resolution_change(ctx,
+					     &jpeg_src_buf->dec_param)) {
+		mtk_jpeg_queue_src_chg_event(ctx);
+		ctx->state = MTK_JPEG_SOURCE_CHANGE;
+		goto getbuf_fail;
+	}
+
+	jpeg_src_buf->curr_ctx = ctx;
+	jpeg_src_buf->frame_num = ctx->total_frame_num;
+	jpeg_dst_buf->curr_ctx = ctx;
+	jpeg_dst_buf->frame_num = ctx->total_frame_num;
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
+	v4l2_m2m_src_buf_remove(ctx->fh.m2m_ctx);
+	v4l2_m2m_dst_buf_remove(ctx->fh.m2m_ctx);
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
+	ctx->total_frame_num++;
+	mtk_jpeg_dec_reset(comp_jpeg[hw_id]->reg_base);
+	mtk_jpeg_dec_set_config(comp_jpeg[hw_id]->reg_base,
+				&jpeg_src_buf->dec_param,
+				jpeg_src_buf->bs_size,
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
+	atomic_inc(&jpeg->hw_rdy);
+	mtk_jpegdec_put_hw(jpeg, hw_id);
+	v4l2_m2m_job_finish(jpeg->m2m_dev, ctx->fh.m2m_ctx);
+}
+
+static irqreturn_t mtk_jpeg_enc_irq(int irq, void *priv)
+{
+	struct mtk_jpeg_dev *jpeg = priv;
+	u32 irq_status;
+	irqreturn_t ret = IRQ_NONE;
+
+	cancel_delayed_work(&jpeg->job_timeout_work);
+
+	irq_status = readl(jpeg->reg_base + JPEG_ENC_INT_STS) &
+		     JPEG_ENC_INT_STATUS_MASK_ALLIRQ;
+	if (irq_status)
+		writel(0, jpeg->reg_base + JPEG_ENC_INT_STS);
+
+	if (!(irq_status & JPEG_ENC_INT_STATUS_DONE))
+		return ret;
+
+	ret = mtk_jpeg_enc_done(jpeg);
+	return ret;
+}
+
+static irqreturn_t mtk_jpeg_dec_irq(int irq, void *priv)
+{
+	struct mtk_jpeg_dev *jpeg = priv;
+	struct mtk_jpeg_ctx *ctx;
+	struct vb2_v4l2_buffer *src_buf, *dst_buf;
+	struct mtk_jpeg_src_buf *jpeg_src_buf;
+	enum vb2_buffer_state buf_state = VB2_BUF_STATE_ERROR;
+	u32	dec_irq_ret;
+	u32 dec_ret;
+	int i;
+
+	cancel_delayed_work(&jpeg->job_timeout_work);
+
+	dec_ret = mtk_jpeg_dec_get_int_status(jpeg->reg_base);
+	dec_irq_ret = mtk_jpeg_dec_enum_result(dec_ret);
+	ctx = v4l2_m2m_get_curr_priv(jpeg->m2m_dev);
+	if (!ctx) {
+		v4l2_err(&jpeg->v4l2_dev, "Context is NULL\n");
+		return IRQ_HANDLED;
+	}
+
+	src_buf = v4l2_m2m_src_buf_remove(ctx->fh.m2m_ctx);
+	dst_buf = v4l2_m2m_dst_buf_remove(ctx->fh.m2m_ctx);
+	jpeg_src_buf = mtk_jpeg_vb2_to_srcbuf(&src_buf->vb2_buf);
+
+	if (dec_irq_ret >= MTK_JPEG_DEC_RESULT_UNDERFLOW)
+		mtk_jpeg_dec_reset(jpeg->reg_base);
+
+	if (dec_irq_ret != MTK_JPEG_DEC_RESULT_EOF_DONE) {
+		dev_err(jpeg->dev, "decode failed\n");
+		goto dec_end;
+	}
+
+	for (i = 0; i < dst_buf->vb2_buf.num_planes; i++)
+		vb2_set_plane_payload(&dst_buf->vb2_buf, i,
+				      jpeg_src_buf->dec_param.comp_size[i]);
+
+	buf_state = VB2_BUF_STATE_DONE;
+
+dec_end:
+	v4l2_m2m_buf_done(src_buf, buf_state);
+	v4l2_m2m_buf_done(dst_buf, buf_state);
+	v4l2_m2m_job_finish(jpeg->m2m_dev, ctx->fh.m2m_ctx);
+	pm_runtime_put(ctx->jpeg->dev);
+	return IRQ_HANDLED;
+}
+
+static struct clk_bulk_data mtk_jpeg_clocks[] = {
+	{ .id = "jpgenc" },
+};
+
+static struct clk_bulk_data mt8173_jpeg_dec_clocks[] = {
+	{ .id = "jpgdec-smi" },
+	{ .id = "jpgdec" },
+};
+
 static const struct mtk_jpeg_variant mt8173_jpeg_drvdata = {
 	.clks = mt8173_jpeg_dec_clocks,
 	.num_clks = ARRAY_SIZE(mt8173_jpeg_dec_clocks),
