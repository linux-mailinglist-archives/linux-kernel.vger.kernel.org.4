Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C82B95F1999
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 05:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232350AbiJAD1X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 23:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233273AbiJADZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 23:25:46 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 208D9F80AE;
        Fri, 30 Sep 2022 20:17:55 -0700 (PDT)
X-UUID: d1fa1afec6fe49afbf67a3593defbebe-20221001
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=YXsaGgrWcfTxB6frm3Y9+mK7+MQIPFMyxzTV3FpAegI=;
        b=Yn15yPPeK8pQd6DZDmC/ZJSyb0nhWHE+7GVAbiYWR2iqOrEScJDyF44eSc8cDvsptBIaJrhjUfHu/D/BD6qGkhJ68hn5sDCufQ9e66M1NuXIj6mjaOoIbj7wBL3ZXqGOgZnUnzVwW69ewFaBRawoF66C/ztj8USXpD44Sho3O44=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:9929a7da-49ce-44b0-a5cf-348f7a3305f3,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-25
X-CID-META: VersionHash:39a5ff1,CLOUDID:ababa107-1cee-4c38-b21b-a45f9682fdc0,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: d1fa1afec6fe49afbf67a3593defbebe-20221001
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <irui.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1048704068; Sat, 01 Oct 2022 11:17:51 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Sat, 1 Oct 2022 11:17:49 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Sat, 1 Oct 2022 11:17:48 +0800
From:   Irui Wang <irui.wang@mediatek.com>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        <angelogioacchino.delregno@collabora.com>,
        <nicolas.dufresne@collabora.com>,
        Tiffany Lin <tiffany.lin@mediatek.com>
CC:     Yunfei Dong <yunfei.dong@mediatek.com>,
        Maoguang Meng <maoguang.meng@mediatek.com>,
        Longfei Wang <longfei.wang@mediatek.com>,
        Irui Wang <irui.wang@mediatek.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH v6, 8/8] media: mediatek: vcodec: Return encoding result in asynchronous mode
Date:   Sat, 1 Oct 2022 11:17:37 +0800
Message-ID: <20221001031737.18266-9-irui.wang@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221001031737.18266-1-irui.wang@mediatek.com>
References: <20221001031737.18266-1-irui.wang@mediatek.com>
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

when enable multi-core encoding, the wait IRQ done synchronous function
should not be called, so the encoding result can't return to client in
device_run. Move the buffer done function in IRQ handler.

Signed-off-by: Irui Wang <irui.wang@mediatek.com>
---
 .../platform/mediatek/vcodec/mtk_vcodec_drv.h |  6 ++
 .../platform/mediatek/vcodec/mtk_vcodec_enc.c | 72 +++++++++++++++++--
 .../platform/mediatek/vcodec/mtk_vcodec_enc.h |  7 +-
 .../mediatek/vcodec/mtk_vcodec_enc_drv.c      | 28 +++++++-
 .../mediatek/vcodec/mtk_vcodec_enc_hw.c       | 13 +++-
 .../mediatek/vcodec/mtk_vcodec_enc_pm.c       |  1 +
 .../mediatek/vcodec/mtk_vcodec_util.h         |  1 +
 .../mediatek/vcodec/venc/venc_h264_if.c       | 20 ++++--
 .../platform/mediatek/vcodec/venc_drv_if.h    |  2 +
 9 files changed, 137 insertions(+), 13 deletions(-)

diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_drv.h b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_drv.h
index a75ba675f72b..d9c27ebcf3c3 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_drv.h
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_drv.h
@@ -291,6 +291,9 @@ struct vdec_pic_info {
  * @msg_queue: msg queue used to store lat buffer information.
  * @q_mutex: vb2_queue mutex.
  * @encoded_frame_cnt: number of encoded frames
+ * @pfrm_buf: used to store current ctx's frame buffer
+ * @pbs_buf: used to store current ctx's bitstream buffer
+ * @hdr_size: used to store prepend header size
  */
 struct mtk_vcodec_ctx {
 	enum mtk_instance_type type;
@@ -340,6 +343,9 @@ struct mtk_vcodec_ctx {
 
 	struct mutex q_mutex;
 	int encoded_frame_cnt;
+	struct vb2_v4l2_buffer *pfrm_buf[MTK_VENC_HW_MAX];
+	struct vb2_v4l2_buffer *pbs_buf[MTK_VENC_HW_MAX];
+	unsigned int hdr_size;
 };
 
 /*
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c
index d15e106fb246..3424da4aaa26 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c
@@ -958,6 +958,8 @@ static void vb2ops_venc_stop_streaming(struct vb2_queue *q)
 
 	mtk_v4l2_debug(2, "[%d]-> type=%d", ctx->id, q->type);
 
+	mtk_venc_lock_all(ctx);
+
 	if (q->type == V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE) {
 		while ((dst_buf = v4l2_m2m_dst_buf_remove(ctx->m2m_ctx))) {
 			vb2_set_plane_payload(&dst_buf->vb2_buf, 0, 0);
@@ -1193,6 +1195,7 @@ static void mtk_venc_worker(struct work_struct *work)
 	 * is dequeued.
 	 */
 	if (src_buf == &ctx->empty_flush_buf.vb) {
+		mtk_venc_lock_all(ctx);
 		vb2_set_plane_payload(&dst_buf->vb2_buf, 0, 0);
 		dst_buf->flags |= V4L2_BUF_FLAG_LAST;
 		v4l2_m2m_buf_done(dst_buf, VB2_BUF_STATE_DONE);
@@ -1207,9 +1210,12 @@ static void mtk_venc_worker(struct work_struct *work)
 		frm_buf.fb_addr[i].size =
 				(size_t)src_buf->vb2_buf.planes[i].length;
 	}
+	frm_buf.frm_addr = src_buf;
+
 	bs_buf.va = vb2_plane_vaddr(&dst_buf->vb2_buf, 0);
 	bs_buf.dma_addr = vb2_dma_contig_plane_dma_addr(&dst_buf->vb2_buf, 0);
 	bs_buf.size = (size_t)dst_buf->vb2_buf.planes[0].length;
+	bs_buf.buf = dst_buf;
 
 	mtk_v4l2_debug(2,
 			"Framebuf PA=%llx Size=0x%zx;PA=0x%llx Size=0x%zx;PA=0x%llx Size=%zu",
@@ -1235,11 +1241,14 @@ static void mtk_venc_worker(struct work_struct *work)
 		v4l2_m2m_buf_done(dst_buf, VB2_BUF_STATE_ERROR);
 		mtk_v4l2_err("venc_if_encode failed=%d", ret);
 	} else {
-		v4l2_m2m_buf_done(src_buf, VB2_BUF_STATE_DONE);
-		vb2_set_plane_payload(&dst_buf->vb2_buf, 0, enc_result.bs_size);
-		v4l2_m2m_buf_done(dst_buf, VB2_BUF_STATE_DONE);
-		mtk_v4l2_debug(2, "venc_if_encode bs size=%d",
-				 enc_result.bs_size);
+		if (!IS_VENC_MULTICORE(ctx->dev->enc_capability)) {
+			v4l2_m2m_buf_done(src_buf, VB2_BUF_STATE_DONE);
+			vb2_set_plane_payload(&dst_buf->vb2_buf, 0,
+					      enc_result.bs_size);
+			v4l2_m2m_buf_done(dst_buf, VB2_BUF_STATE_DONE);
+			mtk_v4l2_debug(2, "venc_if_encode bs size=%d",
+				       enc_result.bs_size);
+		}
 	}
 
 	ctx->encoded_frame_cnt++;
@@ -1453,6 +1462,34 @@ int mtk_vcodec_enc_queue_init(void *priv, struct vb2_queue *src_vq,
 	return vb2_queue_init(dst_vq);
 }
 
+void mtk_venc_buf_done(struct mtk_vcodec_ctx *ctx, int hw_id,
+		       unsigned int bs_size, bool time_out, bool key_frame)
+{
+	struct vb2_v4l2_buffer *src_vb2_v4l2 = NULL;
+	struct vb2_v4l2_buffer *dst_vb2_v4l2 = NULL;
+
+	/*
+	 * the frm_buf(src_buf) and bs_buf(dst_buf) can be obtained from ctx,
+	 * then put them to done list, user can get them by dqbuf call
+	 */
+	src_vb2_v4l2 = ctx->pfrm_buf[hw_id];
+	dst_vb2_v4l2 = ctx->pbs_buf[hw_id];
+
+	if (src_vb2_v4l2 && dst_vb2_v4l2) {
+		dst_vb2_v4l2->vb2_buf.timestamp =
+			src_vb2_v4l2->vb2_buf.timestamp;
+		dst_vb2_v4l2->timecode = src_vb2_v4l2->timecode;
+
+		if (key_frame)
+			dst_vb2_v4l2->flags |= V4L2_BUF_FLAG_KEYFRAME;
+
+		v4l2_m2m_buf_done(src_vb2_v4l2, VB2_BUF_STATE_DONE);
+		vb2_set_plane_payload(&dst_vb2_v4l2->vb2_buf, 0, bs_size);
+		v4l2_m2m_buf_done(dst_vb2_v4l2, VB2_BUF_STATE_DONE);
+	}
+}
+EXPORT_SYMBOL_GPL(mtk_venc_buf_done);
+
 int mtk_venc_unlock(struct mtk_vcodec_ctx *ctx, int hw_id)
 {
 	struct mtk_vcodec_dev *dev = ctx->dev;
@@ -1460,6 +1497,7 @@ int mtk_venc_unlock(struct mtk_vcodec_ctx *ctx, int hw_id)
 	mutex_unlock(&dev->enc_mutex[hw_id]);
 	return 0;
 }
+EXPORT_SYMBOL_GPL(mtk_venc_unlock);
 
 int mtk_venc_lock(struct mtk_vcodec_ctx *ctx, int hw_id)
 {
@@ -1468,6 +1506,30 @@ int mtk_venc_lock(struct mtk_vcodec_ctx *ctx, int hw_id)
 	mutex_lock(&dev->enc_mutex[hw_id]);
 	return 0;
 }
+EXPORT_SYMBOL_GPL(mtk_venc_lock);
+
+void mtk_venc_lock_all(struct mtk_vcodec_ctx *ctx)
+{
+	unsigned int i;
+	struct mtk_vcodec_dev *dev = ctx->dev;
+
+	/*
+	 * For multi-core mode encoding, there are may be bufs being encoded
+	 * when get the empty flush buffer or stop streaming, for example, the
+	 * buffer with LAST flag will return to client before the encoding
+	 * buffers, which will cause frame lost.
+	 * The encoder device mutex will be locked during encoding process,
+	 * when encode done, the mutex unlocked. So if all encoder device mutex
+	 * can be locked, which means there are no bufs being encoded at this
+	 * time, then the buffer with LAST flag can return to client properly.
+	 */
+
+	for (i = 0; i < MTK_VENC_HW_MAX; i++) {
+		mutex_lock(&dev->enc_mutex[i]);
+		mutex_unlock(&dev->enc_mutex[i]);
+	}
+}
+EXPORT_SYMBOL_GPL(mtk_venc_lock_all);
 
 void mtk_vcodec_enc_release(struct mtk_vcodec_ctx *ctx)
 {
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.h b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.h
index 29f5c8d1b59f..5ab17381c7ba 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.h
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.h
@@ -20,6 +20,9 @@
 
 #define MTK_VENC_IRQ_STATUS_OFFSET	0x05C
 #define MTK_VENC_IRQ_ACK_OFFSET	0x060
+#define VENC_PIC_BITSTREAM_BYTE_CNT 0x0098
+#define VENC_PIC_FRM_TYPE		0x0010
+#define VENC_PIC_KEY_FRM       0x2
 
 /**
  * struct mtk_video_enc_buf - Private data related to each VB2 buffer.
@@ -46,5 +49,7 @@ int mtk_vcodec_enc_queue_init(void *priv, struct vb2_queue *src_vq,
 void mtk_vcodec_enc_release(struct mtk_vcodec_ctx *ctx);
 int mtk_vcodec_enc_ctrls_setup(struct mtk_vcodec_ctx *ctx);
 void mtk_vcodec_enc_set_default_params(struct mtk_vcodec_ctx *ctx);
-
+void mtk_venc_buf_done(struct mtk_vcodec_ctx *ctx, int hw_id,
+		       unsigned int bs_size, bool time_out, bool key_frame);
+void mtk_venc_lock_all(struct mtk_vcodec_ctx *ctx);
 #endif /* _MTK_VCODEC_ENC_H_ */
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c
index ba9c19a4d2cc..b34d7583fccc 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c
@@ -89,6 +89,9 @@ static irqreturn_t mtk_vcodec_enc_irq_handler(int irq, void *priv)
 	struct mtk_vcodec_ctx *ctx;
 	unsigned long flags;
 	void __iomem *addr;
+	unsigned int bs_size;
+	unsigned int frm_type;
+	bool is_key_frame = 0;
 
 	spin_lock_irqsave(&dev->irqlock, flags);
 	ctx = dev->curr_enc_ctx[MTK_VENC_CORE_0];
@@ -101,8 +104,32 @@ static irqreturn_t mtk_vcodec_enc_irq_handler(int irq, void *priv)
 	ctx->irq_status = readl(dev->reg_base[dev->venc_pdata->core_id] +
 				(MTK_VENC_IRQ_STATUS_OFFSET));
 
+	bs_size = readl(dev->reg_base[dev->venc_pdata->core_id] +
+			(VENC_PIC_BITSTREAM_BYTE_CNT));
+	frm_type = readl(dev->reg_base[dev->venc_pdata->core_id] +
+			 (VENC_PIC_FRM_TYPE));
+
 	clean_irq_status(ctx->irq_status, addr);
 
+	if (IS_VENC_MULTICORE(dev->enc_capability)) {
+		if (ctx->irq_status & MTK_VENC_IRQ_STATUS_FRM) {
+			if (ctx->hdr_size != 0) {
+				bs_size += ctx->hdr_size;
+				ctx->hdr_size = 0;
+			}
+
+			if (frm_type & VENC_PIC_KEY_FRM)
+				is_key_frame = 1;
+
+			mtk_venc_buf_done(ctx, 0, bs_size, 0, is_key_frame);
+			mtk_vcodec_enc_clock_off(dev, 0);
+			mtk_venc_unlock(ctx, 0);
+		} else {
+			wake_up_ctx(ctx, MTK_INST_IRQ_RECEIVED, 0);
+		}
+		return IRQ_HANDLED;
+	}
+
 	wake_up_ctx(ctx, MTK_INST_IRQ_RECEIVED, 0);
 	return IRQ_HANDLED;
 }
@@ -284,7 +311,6 @@ static int mtk_vcodec_probe(struct platform_device *pdev)
 		goto err_res;
 	}
 
-	irq_set_status_flags(dev->enc_irq, IRQ_NOAUTOEN);
 	ret = devm_request_irq(&pdev->dev, dev->enc_irq,
 			       mtk_vcodec_enc_irq_handler,
 			       0, pdev->name, dev);
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_hw.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_hw.c
index 6df5221b742f..0367e59b20a9 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_hw.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_hw.c
@@ -50,6 +50,9 @@ static irqreturn_t mtk_enc_hw_irq_handler(int irq, void *priv)
 	struct mtk_vcodec_ctx *ctx;
 	unsigned long flags;
 	void __iomem *addr;
+	unsigned int bs_size;
+	unsigned int frm_type;
+	bool is_key_frame = 0;
 
 	spin_lock_irqsave(&main_dev->irqlock, flags);
 	ctx = main_dev->curr_enc_ctx[dev->hw_id];
@@ -61,9 +64,17 @@ static irqreturn_t mtk_enc_hw_irq_handler(int irq, void *priv)
 
 	addr = dev->reg_base + MTK_VENC_IRQ_ACK_OFFSET;
 	ctx->irq_status = readl(dev->reg_base + MTK_VENC_IRQ_STATUS_OFFSET);
+	bs_size = readl(dev->reg_base + VENC_PIC_BITSTREAM_BYTE_CNT);
+	frm_type = readl(dev->reg_base + VENC_PIC_FRM_TYPE);
 	clean_hw_irq_status(ctx->irq_status, addr);
 
-	wake_up_ctx(ctx, MTK_INST_IRQ_RECEIVED, 0);
+	if (frm_type & VENC_PIC_KEY_FRM)
+		is_key_frame = 1;
+
+	mtk_venc_buf_done(ctx, dev->hw_id, bs_size, 0, is_key_frame);
+	mtk_vcodec_enc_clock_off(main_dev, dev->hw_id);
+	mtk_venc_unlock(ctx, dev->hw_id);
+
 	return IRQ_HANDLED;
 }
 
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_pm.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_pm.c
index 2f83aade779a..af2968a8d2e5 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_pm.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_pm.c
@@ -235,3 +235,4 @@ void mtk_vcodec_enc_clock_off(struct mtk_vcodec_dev *dev,
 	for (i = enc_clk->clk_num - 1; i >= 0; i--)
 		clk_disable(enc_clk->clk_info[i].vcodec_clk);
 }
+EXPORT_SYMBOL_GPL(mtk_vcodec_enc_clock_off);
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_util.h b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_util.h
index 0033c53d5589..cecf78d6d4c6 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_util.h
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_util.h
@@ -15,6 +15,7 @@ struct mtk_vcodec_mem {
 	size_t size;
 	void *va;
 	dma_addr_t dma_addr;
+	void *buf;
 };
 
 struct mtk_vcodec_fb {
diff --git a/drivers/media/platform/mediatek/vcodec/venc/venc_h264_if.c b/drivers/media/platform/mediatek/vcodec/venc/venc_h264_if.c
index 32497a35afb1..a6990221d845 100644
--- a/drivers/media/platform/mediatek/vcodec/venc/venc_h264_if.c
+++ b/drivers/media/platform/mediatek/vcodec/venc/venc_h264_if.c
@@ -22,7 +22,6 @@
 static const char h264_filler_marker[] = {0x0, 0x0, 0x0, 0x1, 0xc};
 
 #define H264_FILLER_MARKER_SIZE ARRAY_SIZE(h264_filler_marker)
-#define VENC_PIC_BITSTREAM_BYTE_CNT 0x0098
 
 /*
  * enum venc_h264_frame_type - h264 encoder output bitstream frame type
@@ -620,6 +619,11 @@ static int h264_encode_frame(struct venc_h264_inst *inst,
 		return ret;
 	}
 
+	if (IS_VENC_MULTICORE(ctx->dev->enc_capability)) {
+		++inst->frm_cnt;
+		return ret;
+	}
+
 	irq_status = h264_enc_wait_venc_done(inst);
 	if (irq_status != MTK_VENC_IRQ_STATUS_FRM) {
 		mtk_vcodec_err(inst, "irq_status=%d failed", irq_status);
@@ -705,8 +709,6 @@ static int h264_enc_encode(void *handle,
 
 	mtk_vcodec_debug(inst, "opt %d ->", opt);
 
-	enable_irq(ctx->dev->enc_irq);
-
 	switch (opt) {
 	case VENC_START_OPT_ENCODE_SEQUENCE_HEADER: {
 		unsigned int bs_size_hdr;
@@ -729,6 +731,13 @@ static int h264_enc_encode(void *handle,
 		unsigned int bs_size_hdr;
 		unsigned int bs_size_frm;
 
+		/*
+		 * the frm_buf and bs_buf need to recorded into current ctx,
+		 * when encoding done, the target buffers can be got from ctx.
+		 */
+		ctx->pfrm_buf[ctx->hw_id] = frm_buf->frm_addr;
+		ctx->pbs_buf[ctx->hw_id] = bs_buf->buf;
+
 		if (!inst->prepend_hdr) {
 			ret = h264_encode_frame(inst, frm_buf, bs_buf,
 						&result->bs_size, ctx->hw_id);
@@ -763,7 +772,9 @@ static int h264_enc_encode(void *handle,
 		if (ret)
 			goto encode_err;
 
-		result->bs_size = hdr_sz + filler_sz + bs_size_frm;
+		ctx->hdr_size = hdr_sz + filler_sz;
+
+		result->bs_size = ctx->hdr_size + bs_size_frm;
 
 		mtk_vcodec_debug(inst, "hdr %d filler %d frame %d bs %d",
 				 hdr_sz, filler_sz, bs_size_frm,
@@ -782,7 +793,6 @@ static int h264_enc_encode(void *handle,
 
 encode_err:
 
-	disable_irq(ctx->dev->enc_irq);
 	mtk_vcodec_debug(inst, "opt %d <-", opt);
 
 	return ret;
diff --git a/drivers/media/platform/mediatek/vcodec/venc_drv_if.h b/drivers/media/platform/mediatek/vcodec/venc_drv_if.h
index e676ccf6bd25..7e24b7f573d7 100644
--- a/drivers/media/platform/mediatek/vcodec/venc_drv_if.h
+++ b/drivers/media/platform/mediatek/vcodec/venc_drv_if.h
@@ -108,9 +108,11 @@ struct venc_frame_info {
 /*
  * struct venc_frm_buf - frame buffer information used in venc_if_encode()
  * @fb_addr: plane frame buffer addresses
+ * @frm_addr: current v4l2 buffer address
  */
 struct venc_frm_buf {
 	struct mtk_vcodec_fb fb_addr[MTK_VCODEC_MAX_PLANES];
+	void *frm_addr;
 };
 
 /*
-- 
2.18.0

