Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C56F35F1997
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 05:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233346AbiJAD1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 23:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233213AbiJADZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 23:25:45 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A5F2F80AC;
        Fri, 30 Sep 2022 20:17:55 -0700 (PDT)
X-UUID: 5098f5f47bd443d6ba401e0c840e03b9-20221001
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=1nRZij7FBP7nArpzIx+WOULHnjCn1SIwkAQdsuKIz9w=;
        b=CXikUgcIhAQ9AE8WP1DhnWbke+fNtpRctiPDn92gh/wQ29PnWzImEsgkZOy4GAE1OeL0BhRvkj2mxUvbX7yn2NXgs+D8QagqqsrmEFffmWr4sBjyLT9WRfZmriASgi6sBo89RlZxot0mzgMIO3pf+KTIhW37f5+YH7jgFX5Ndl8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:4c382812-cfc9-43ec-bfa9-eb212fe930d4,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-25
X-CID-META: VersionHash:39a5ff1,CLOUDID:9aaba107-1cee-4c38-b21b-a45f9682fdc0,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 5098f5f47bd443d6ba401e0c840e03b9-20221001
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
        (envelope-from <irui.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 68640158; Sat, 01 Oct 2022 11:17:49 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Sat, 1 Oct 2022 11:17:48 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Sat, 1 Oct 2022 11:17:47 +0800
From:   Irui Wang <irui.wang@mediatek.com>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Tzung-Bi Shih" <tzungbi@chromium.org>,
        <angelogioacchino.delregno@collabora.com>,
        <nicolas.dufresne@collabora.com>,
        Tiffany Lin <tiffany.lin@mediatek.com>
CC:     Yunfei Dong <yunfei.dong@mediatek.com>,
        Maoguang Meng <maoguang.meng@mediatek.com>,
        Longfei Wang <longfei.wang@mediatek.com>,
        "Irui Wang" <irui.wang@mediatek.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH v6, 7/8] media: mediatek: vcodec: Add multi-core encoding process
Date:   Sat, 1 Oct 2022 11:17:36 +0800
Message-ID: <20221001031737.18266-8-irui.wang@mediatek.com>
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

MT8195 has two encoder hardware cores, when enable multi-core encoding,
it is possiable to trying to use the two cores. According to hardware
requirements, input frame 0 uses core0, frame 1 uses core1, then frame 2
uses core0, lock the device and enable clock by used core, and for
sequence header encoding, it always use core0.

Signed-off-by: Irui Wang <irui.wang@mediatek.com>
---
 .../platform/mediatek/vcodec/mtk_vcodec_drv.h |  7 +-
 .../platform/mediatek/vcodec/mtk_vcodec_enc.c | 10 +--
 .../platform/mediatek/vcodec/mtk_vcodec_enc.h |  4 +-
 .../mediatek/vcodec/mtk_vcodec_enc_drv.c      |  8 ++-
 .../mediatek/vcodec/mtk_vcodec_enc_hw.c       |  7 +-
 .../mediatek/vcodec/mtk_vcodec_enc_hw.h       |  2 -
 .../mediatek/vcodec/venc/venc_h264_if.c       | 15 ++--
 .../mediatek/vcodec/venc/venc_vp8_if.c        |  3 +-
 .../platform/mediatek/vcodec/venc_drv_if.c    | 69 ++++++++++++++-----
 .../platform/mediatek/vcodec/venc_drv_if.h    |  4 ++
 .../platform/mediatek/vcodec/venc_vpu_if.c    | 25 +++++--
 .../platform/mediatek/vcodec/venc_vpu_if.h    |  3 +-
 12 files changed, 110 insertions(+), 47 deletions(-)

diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_drv.h b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_drv.h
index e074198a12ad..a75ba675f72b 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_drv.h
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_drv.h
@@ -290,6 +290,7 @@ struct vdec_pic_info {
  *
  * @msg_queue: msg queue used to store lat buffer information.
  * @q_mutex: vb2_queue mutex.
+ * @encoded_frame_cnt: number of encoded frames
  */
 struct mtk_vcodec_ctx {
 	enum mtk_instance_type type;
@@ -338,6 +339,7 @@ struct mtk_vcodec_ctx {
 	struct vdec_msg_queue msg_queue;
 
 	struct mutex q_mutex;
+	int encoded_frame_cnt;
 };
 
 /*
@@ -482,6 +484,7 @@ struct mtk_vcodec_enc_pdata {
  * @vdec_racing_info: record register value
  * @dec_racing_info_mutex: mutex lock used for inner racing mode
  * @enc_hw_dev: used to store venc core device
+ * @curr_enc_ctx: used to store current used enc context
  */
 struct mtk_vcodec_dev {
 	struct v4l2_device v4l2_dev;
@@ -515,7 +518,8 @@ struct mtk_vcodec_dev {
 
 	/* decoder hardware mutex lock */
 	struct mutex dec_mutex[MTK_VDEC_HW_MAX];
-	struct mutex enc_mutex;
+	/* encoder hardware mutex lock */
+	struct mutex enc_mutex[MTK_VENC_HW_MAX];
 
 	struct mtk_vcodec_pm pm;
 	unsigned int dec_capability;
@@ -534,6 +538,7 @@ struct mtk_vcodec_dev {
 	struct mutex dec_racing_info_mutex;
 
 	void *enc_hw_dev[MTK_VENC_HW_MAX];
+	struct mtk_vcodec_ctx *curr_enc_ctx[MTK_VENC_HW_MAX];
 };
 
 static inline struct mtk_vcodec_ctx *fh_to_ctx(struct v4l2_fh *fh)
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c
index 66e08e88dcc8..d15e106fb246 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c
@@ -1242,6 +1242,8 @@ static void mtk_venc_worker(struct work_struct *work)
 				 enc_result.bs_size);
 	}
 
+	ctx->encoded_frame_cnt++;
+
 	v4l2_m2m_job_finish(ctx->dev->m2m_dev_enc, ctx->m2m_ctx);
 
 	mtk_v4l2_debug(1, "<=== src_buf[%d] dst_buf[%d] venc_if_encode ret=%d Size=%u===>",
@@ -1451,19 +1453,19 @@ int mtk_vcodec_enc_queue_init(void *priv, struct vb2_queue *src_vq,
 	return vb2_queue_init(dst_vq);
 }
 
-int mtk_venc_unlock(struct mtk_vcodec_ctx *ctx)
+int mtk_venc_unlock(struct mtk_vcodec_ctx *ctx, int hw_id)
 {
 	struct mtk_vcodec_dev *dev = ctx->dev;
 
-	mutex_unlock(&dev->enc_mutex);
+	mutex_unlock(&dev->enc_mutex[hw_id]);
 	return 0;
 }
 
-int mtk_venc_lock(struct mtk_vcodec_ctx *ctx)
+int mtk_venc_lock(struct mtk_vcodec_ctx *ctx, int hw_id)
 {
 	struct mtk_vcodec_dev *dev = ctx->dev;
 
-	mutex_lock(&dev->enc_mutex);
+	mutex_lock(&dev->enc_mutex[hw_id]);
 	return 0;
 }
 
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.h b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.h
index 513ee7993e34..29f5c8d1b59f 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.h
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.h
@@ -39,8 +39,8 @@ struct mtk_video_enc_buf {
 extern const struct v4l2_ioctl_ops mtk_venc_ioctl_ops;
 extern const struct v4l2_m2m_ops mtk_venc_m2m_ops;
 
-int mtk_venc_unlock(struct mtk_vcodec_ctx *ctx);
-int mtk_venc_lock(struct mtk_vcodec_ctx *ctx);
+int mtk_venc_unlock(struct mtk_vcodec_ctx *ctx, int hw_id);
+int mtk_venc_lock(struct mtk_vcodec_ctx *ctx, int hw_id);
 int mtk_vcodec_enc_queue_init(void *priv, struct vb2_queue *src_vq,
 			      struct vb2_queue *dst_vq);
 void mtk_vcodec_enc_release(struct mtk_vcodec_ctx *ctx);
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c
index 5bfbf4eead13..ba9c19a4d2cc 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c
@@ -91,7 +91,7 @@ static irqreturn_t mtk_vcodec_enc_irq_handler(int irq, void *priv)
 	void __iomem *addr;
 
 	spin_lock_irqsave(&dev->irqlock, flags);
-	ctx = dev->curr_ctx;
+	ctx = dev->curr_enc_ctx[MTK_VENC_CORE_0];
 	spin_unlock_irqrestore(&dev->irqlock, flags);
 
 	mtk_v4l2_debug(1, "id=%d coreid:%d", ctx->id, dev->venc_pdata->core_id);
@@ -231,7 +231,7 @@ static int mtk_vcodec_probe(struct platform_device *pdev)
 	struct video_device *vfd_enc;
 	phandle rproc_phandle;
 	enum mtk_vcodec_fw_type fw_type;
-	int ret;
+	int ret, i;
 
 	dev = devm_kzalloc(&pdev->dev, sizeof(*dev), GFP_KERNEL);
 	if (!dev)
@@ -296,7 +296,9 @@ static int mtk_vcodec_probe(struct platform_device *pdev)
 		goto err_res;
 	}
 
-	mutex_init(&dev->enc_mutex);
+	for (i = 0; i < MTK_VENC_HW_MAX; i++)
+		mutex_init(&dev->enc_mutex[i]);
+
 	mutex_init(&dev->dev_mutex);
 	spin_lock_init(&dev->irqlock);
 
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_hw.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_hw.c
index 1ed4279925b7..6df5221b742f 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_hw.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_hw.c
@@ -46,13 +46,14 @@ static void clean_hw_irq_status(unsigned int irq_status, void __iomem *addr)
 static irqreturn_t mtk_enc_hw_irq_handler(int irq, void *priv)
 {
 	struct mtk_venc_hw_dev *dev = priv;
+	struct mtk_vcodec_dev *main_dev = dev->main_dev;
 	struct mtk_vcodec_ctx *ctx;
 	unsigned long flags;
 	void __iomem *addr;
 
-	spin_lock_irqsave(&dev->main_dev->irqlock, flags);
-	ctx = dev->curr_ctx;
-	spin_unlock_irqrestore(&dev->main_dev->irqlock, flags);
+	spin_lock_irqsave(&main_dev->irqlock, flags);
+	ctx = main_dev->curr_enc_ctx[dev->hw_id];
+	spin_unlock_irqrestore(&main_dev->irqlock, flags);
 	if (!ctx)
 		return IRQ_HANDLED;
 
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_hw.h b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_hw.h
index 9daea9665659..e8dfd46b3b01 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_hw.h
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_hw.h
@@ -14,7 +14,6 @@
  * @plat_dev: platform_device
  * @main_dev: main device
  * @pm: power management data
- * @curr_ctx: the context that is waiting for venc hardware
  * @reg_base: mapped address of venc registers
  * @irq_status: venc hardware irq status
  * @enc_irq: venc device irq
@@ -25,7 +24,6 @@ struct mtk_venc_hw_dev {
 	struct mtk_vcodec_dev *main_dev;
 
 	struct mtk_vcodec_pm pm;
-	struct mtk_vcodec_ctx *curr_ctx;
 
 	void __iomem *reg_base;
 	unsigned int irq_status;
diff --git a/drivers/media/platform/mediatek/vcodec/venc/venc_h264_if.c b/drivers/media/platform/mediatek/vcodec/venc/venc_h264_if.c
index d7ed5c753a0e..32497a35afb1 100644
--- a/drivers/media/platform/mediatek/vcodec/venc/venc_h264_if.c
+++ b/drivers/media/platform/mediatek/vcodec/venc/venc_h264_if.c
@@ -500,7 +500,8 @@ static int h264_encode_sps(struct venc_h264_inst *inst,
 
 	mtk_vcodec_debug_enter(inst);
 
-	ret = vpu_enc_encode(&inst->vpu_inst, H264_BS_MODE_SPS, NULL, bs_buf, NULL);
+	ret = vpu_enc_encode(&inst->vpu_inst, H264_BS_MODE_SPS, NULL,
+			     bs_buf, NULL, MTK_VENC_CORE_0);
 	if (ret)
 		return ret;
 
@@ -526,7 +527,8 @@ static int h264_encode_pps(struct venc_h264_inst *inst,
 
 	mtk_vcodec_debug_enter(inst);
 
-	ret = vpu_enc_encode(&inst->vpu_inst, H264_BS_MODE_PPS, NULL, bs_buf, NULL);
+	ret = vpu_enc_encode(&inst->vpu_inst, H264_BS_MODE_PPS, NULL,
+			     bs_buf, NULL, MTK_VENC_CORE_0);
 	if (ret)
 		return ret;
 
@@ -568,7 +570,8 @@ static int h264_encode_header(struct venc_h264_inst *inst,
 static int h264_encode_frame(struct venc_h264_inst *inst,
 			     struct venc_frm_buf *frm_buf,
 			     struct mtk_vcodec_mem *bs_buf,
-			     unsigned int *bs_size)
+			     unsigned int *bs_size,
+			     int hw_id)
 {
 	int ret = 0;
 	unsigned int gop_size;
@@ -599,7 +602,7 @@ static int h264_encode_frame(struct venc_h264_inst *inst,
 			 frame_info.frm_type);
 
 	ret = vpu_enc_encode(&inst->vpu_inst, H264_BS_MODE_FRAME,
-			     frm_buf, bs_buf, &frame_info);
+			     frm_buf, bs_buf, &frame_info, hw_id);
 	if (ret)
 		return ret;
 
@@ -728,7 +731,7 @@ static int h264_enc_encode(void *handle,
 
 		if (!inst->prepend_hdr) {
 			ret = h264_encode_frame(inst, frm_buf, bs_buf,
-						&result->bs_size);
+						&result->bs_size, ctx->hw_id);
 			if (ret)
 				goto encode_err;
 			result->is_key_frm = inst->vpu_inst.is_key_frm;
@@ -756,7 +759,7 @@ static int h264_enc_encode(void *handle,
 		tmp_bs_buf.size = bs_buf->size - (hdr_sz + filler_sz);
 
 		ret = h264_encode_frame(inst, frm_buf, &tmp_bs_buf,
-					&bs_size_frm);
+					&bs_size_frm, ctx->hw_id);
 		if (ret)
 			goto encode_err;
 
diff --git a/drivers/media/platform/mediatek/vcodec/venc/venc_vp8_if.c b/drivers/media/platform/mediatek/vcodec/venc/venc_vp8_if.c
index 56ce58f761f1..9eed39a4faa2 100644
--- a/drivers/media/platform/mediatek/vcodec/venc/venc_vp8_if.c
+++ b/drivers/media/platform/mediatek/vcodec/venc/venc_vp8_if.c
@@ -302,7 +302,8 @@ static int vp8_enc_encode_frame(struct venc_vp8_inst *inst,
 
 	mtk_vcodec_debug(inst, "->frm_cnt=%d", inst->frm_cnt);
 
-	ret = vpu_enc_encode(&inst->vpu_inst, 0, frm_buf, bs_buf, NULL);
+	ret = vpu_enc_encode(&inst->vpu_inst, 0, frm_buf,
+			     bs_buf, NULL, MTK_VENC_CORE_0);
 	if (ret)
 		return ret;
 
diff --git a/drivers/media/platform/mediatek/vcodec/venc_drv_if.c b/drivers/media/platform/mediatek/vcodec/venc_drv_if.c
index 6cbdb7e30bb3..53fa9a91d3fa 100644
--- a/drivers/media/platform/mediatek/vcodec/venc_drv_if.c
+++ b/drivers/media/platform/mediatek/vcodec/venc_drv_if.c
@@ -16,6 +16,8 @@
 #include "mtk_vcodec_enc.h"
 #include "mtk_vcodec_enc_pm.h"
 
+#define ODD_VENC_FRAME 0x1
+
 int venc_if_init(struct mtk_vcodec_ctx *ctx, unsigned int fourcc)
 {
 	int ret = 0;
@@ -31,9 +33,9 @@ int venc_if_init(struct mtk_vcodec_ctx *ctx, unsigned int fourcc)
 		return -EINVAL;
 	}
 
-	mtk_venc_lock(ctx);
+	mtk_venc_lock(ctx, ctx->hw_id);
 	ret = ctx->enc_if->init(ctx);
-	mtk_venc_unlock(ctx);
+	mtk_venc_unlock(ctx, ctx->hw_id);
 
 	return ret;
 }
@@ -43,9 +45,9 @@ int venc_if_set_param(struct mtk_vcodec_ctx *ctx,
 {
 	int ret = 0;
 
-	mtk_venc_lock(ctx);
+	mtk_venc_lock(ctx, ctx->hw_id);
 	ret = ctx->enc_if->set_param(ctx->drv_handle, type, in);
-	mtk_venc_unlock(ctx);
+	mtk_venc_unlock(ctx, ctx->hw_id);
 
 	return ret;
 }
@@ -56,24 +58,13 @@ int venc_if_encode(struct mtk_vcodec_ctx *ctx,
 		   struct venc_done_result *result)
 {
 	int ret = 0;
-	unsigned long flags;
 
-	mtk_venc_lock(ctx);
+	venc_encode_prepare(ctx, opt);
 
-	spin_lock_irqsave(&ctx->dev->irqlock, flags);
-	ctx->dev->curr_ctx = ctx;
-	spin_unlock_irqrestore(&ctx->dev->irqlock, flags);
-
-	mtk_vcodec_enc_clock_on(ctx->dev, 0);
 	ret = ctx->enc_if->encode(ctx->drv_handle, opt, frm_buf,
 				  bs_buf, result);
-	mtk_vcodec_enc_clock_off(ctx->dev, 0);
-
-	spin_lock_irqsave(&ctx->dev->irqlock, flags);
-	ctx->dev->curr_ctx = NULL;
-	spin_unlock_irqrestore(&ctx->dev->irqlock, flags);
 
-	mtk_venc_unlock(ctx);
+	venc_encode_unprepare(ctx, opt, ret);
 	return ret;
 }
 
@@ -84,11 +75,51 @@ int venc_if_deinit(struct mtk_vcodec_ctx *ctx)
 	if (!ctx->drv_handle)
 		return 0;
 
-	mtk_venc_lock(ctx);
+	mtk_venc_lock(ctx, ctx->hw_id);
 	ret = ctx->enc_if->deinit(ctx->drv_handle);
-	mtk_venc_unlock(ctx);
+	mtk_venc_unlock(ctx, ctx->hw_id);
 
 	ctx->drv_handle = NULL;
 
 	return ret;
 }
+
+void venc_encode_prepare(struct mtk_vcodec_ctx *ctx,
+			 enum venc_start_opt opt)
+{
+	unsigned long flags;
+
+	if (IS_VENC_MULTICORE(ctx->dev->enc_capability)) {
+		if (ctx->encoded_frame_cnt & ODD_VENC_FRAME)
+			ctx->hw_id = MTK_VENC_CORE_1;
+		else
+			ctx->hw_id = MTK_VENC_CORE_0;
+	} else {
+		ctx->hw_id = MTK_VENC_CORE_0;
+	}
+
+	mtk_venc_lock(ctx, ctx->hw_id);
+
+	spin_lock_irqsave(&ctx->dev->irqlock, flags);
+	ctx->dev->curr_enc_ctx[ctx->hw_id] = ctx;
+	spin_unlock_irqrestore(&ctx->dev->irqlock, flags);
+
+	mtk_vcodec_enc_clock_on(ctx->dev, ctx->hw_id);
+}
+
+void venc_encode_unprepare(struct mtk_vcodec_ctx *ctx,
+			   enum venc_start_opt opt, int ret)
+{
+	unsigned long flags;
+
+	if (ret || !IS_VENC_MULTICORE(ctx->dev->enc_capability) ||
+	    opt == VENC_START_OPT_ENCODE_SEQUENCE_HEADER) {
+		mtk_vcodec_enc_clock_off(ctx->dev, ctx->hw_id);
+
+		spin_lock_irqsave(&ctx->dev->irqlock, flags);
+		ctx->dev->curr_enc_ctx[ctx->hw_id] = NULL;
+		spin_unlock_irqrestore(&ctx->dev->irqlock, flags);
+
+		mtk_venc_unlock(ctx, ctx->hw_id);
+	}
+}
diff --git a/drivers/media/platform/mediatek/vcodec/venc_drv_if.h b/drivers/media/platform/mediatek/vcodec/venc_drv_if.h
index 0b04a1020873..e676ccf6bd25 100644
--- a/drivers/media/platform/mediatek/vcodec/venc_drv_if.h
+++ b/drivers/media/platform/mediatek/vcodec/venc_drv_if.h
@@ -167,4 +167,8 @@ int venc_if_encode(struct mtk_vcodec_ctx *ctx,
 		   struct mtk_vcodec_mem *bs_buf,
 		   struct venc_done_result *result);
 
+void venc_encode_prepare(struct mtk_vcodec_ctx *ctx,
+			 enum venc_start_opt opt);
+void venc_encode_unprepare(struct mtk_vcodec_ctx *ctx,
+			   enum venc_start_opt opt, int ret);
 #endif /* _VENC_DRV_IF_H_ */
diff --git a/drivers/media/platform/mediatek/vcodec/venc_vpu_if.c b/drivers/media/platform/mediatek/vcodec/venc_vpu_if.c
index 09e7eaa25aab..fb1565a2ca49 100644
--- a/drivers/media/platform/mediatek/vcodec/venc_vpu_if.c
+++ b/drivers/media/platform/mediatek/vcodec/venc_vpu_if.c
@@ -226,7 +226,8 @@ static int vpu_enc_encode_32bits(struct venc_vpu_inst *vpu,
 				 unsigned int bs_mode,
 				 struct venc_frm_buf *frm_buf,
 				 struct mtk_vcodec_mem *bs_buf,
-				 struct venc_frame_info *frame_info)
+				 struct venc_frame_info *frame_info,
+				 int hw_id)
 {
 	const bool is_ext = MTK_ENC_CTX_IS_EXT(vpu->ctx);
 	size_t msg_size = is_ext ?
@@ -262,6 +263,12 @@ static int vpu_enc_encode_32bits(struct venc_vpu_inst *vpu,
 		out.data[1] = frame_info->skip_frm_count;
 		out.data[2] = frame_info->frm_type;
 	}
+
+	if (IS_VENC_MULTICORE(vpu->ctx->dev->enc_capability)) {
+		out.data_item = 4;
+		out.data[3] = hw_id;
+	}
+
 	if (vpu_enc_send_msg(vpu, &out, msg_size)) {
 		mtk_vcodec_err(vpu, "AP_IPIMSG_ENC_ENCODE %d fail",
 			       bs_mode);
@@ -275,7 +282,8 @@ static int vpu_enc_encode_34bits(struct venc_vpu_inst *vpu,
 				 unsigned int bs_mode,
 				 struct venc_frm_buf *frm_buf,
 				 struct mtk_vcodec_mem *bs_buf,
-				 struct venc_frame_info *frame_info)
+				 struct venc_frame_info *frame_info,
+				 int hw_id)
 {
 	struct venc_ap_ipi_msg_enc_ext_34 out;
 	size_t msg_size = sizeof(struct venc_ap_ipi_msg_enc_ext_34);
@@ -309,6 +317,12 @@ static int vpu_enc_encode_34bits(struct venc_vpu_inst *vpu,
 		out.data[1] = frame_info->skip_frm_count;
 		out.data[2] = frame_info->frm_type;
 	}
+
+	if (IS_VENC_MULTICORE(vpu->ctx->dev->enc_capability)) {
+		out.data_item = 4;
+		out.data[3] = hw_id;
+	}
+
 	if (vpu_enc_send_msg(vpu, &out, msg_size)) {
 		mtk_vcodec_err(vpu, "AP_IPIMSG_ENC_ENCODE %d fail",
 			       bs_mode);
@@ -321,16 +335,17 @@ static int vpu_enc_encode_34bits(struct venc_vpu_inst *vpu,
 int vpu_enc_encode(struct venc_vpu_inst *vpu, unsigned int bs_mode,
 		   struct venc_frm_buf *frm_buf,
 		   struct mtk_vcodec_mem *bs_buf,
-		   struct venc_frame_info *frame_info)
+		   struct venc_frame_info *frame_info,
+		   int hw_id)
 {
 	int ret;
 
 	if (MTK_ENC_IOVA_IS_34BIT(vpu->ctx))
 		ret = vpu_enc_encode_34bits(vpu, bs_mode,
-					    frm_buf, bs_buf, frame_info);
+					    frm_buf, bs_buf, frame_info, hw_id);
 	else
 		ret = vpu_enc_encode_32bits(vpu, bs_mode,
-					    frm_buf, bs_buf, frame_info);
+					    frm_buf, bs_buf, frame_info, hw_id);
 
 	if (ret)
 		return ret;
diff --git a/drivers/media/platform/mediatek/vcodec/venc_vpu_if.h b/drivers/media/platform/mediatek/vcodec/venc_vpu_if.h
index f83bc1b3f2bf..23efcea8d510 100644
--- a/drivers/media/platform/mediatek/vcodec/venc_vpu_if.h
+++ b/drivers/media/platform/mediatek/vcodec/venc_vpu_if.h
@@ -45,7 +45,8 @@ int vpu_enc_set_param(struct venc_vpu_inst *vpu,
 int vpu_enc_encode(struct venc_vpu_inst *vpu, unsigned int bs_mode,
 		   struct venc_frm_buf *frm_buf,
 		   struct mtk_vcodec_mem *bs_buf,
-		   struct venc_frame_info *frame_info);
+		   struct venc_frame_info *frame_info,
+		   int hw_id);
 int vpu_enc_deinit(struct venc_vpu_inst *vpu);
 
 #endif
-- 
2.18.0

