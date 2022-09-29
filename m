Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96B555EF17F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 11:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235825AbiI2JJV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 05:09:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235671AbiI2JIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 05:08:35 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 842921406CC;
        Thu, 29 Sep 2022 02:08:33 -0700 (PDT)
X-UUID: 983689ddc5d549908cb1c26893f6d260-20220929
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=ASapBEoUb+PaTSJhJohFOJmRhVFsFB906Ss0CjMZ29U=;
        b=Wb4s3m8UafwPZLXaBaPstd2Hnq9sGgO0yOmd3SRlTO27OwSTfYqBivY7D3Ie8DHyIEwEGTTxitTvx0EUTcsW2upSRPihTK9jVFeiJ8MKmFk33NRhy5YI2UdgIGsMOZ+9YrMinNtQrbS0/KiAHEARjk5jliFD4kbRZwX93mho978=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:a2092d4d-ba8a-4913-b29d-889ecc974174,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-25
X-CID-META: VersionHash:39a5ff1,CLOUDID:d4dd6e07-1cee-4c38-b21b-a45f9682fdc0,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 983689ddc5d549908cb1c26893f6d260-20220929
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <irui.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1508795397; Thu, 29 Sep 2022 17:08:30 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Thu, 29 Sep 2022 17:08:28 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Thu, 29 Sep 2022 17:08:25 +0800
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
Subject: [V17,06/15] mtk-jpegenc: add output pic reorder interface
Date:   Thu, 29 Sep 2022 17:08:08 +0800
Message-ID: <20220929090817.24272-7-irui.wang@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220929090817.24272-1-irui.wang@mediatek.com>
References: <20220929090817.24272-1-irui.wang@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: kyrie wu <kyrie.wu@mediatek.com>

There are two HWs in mt8195. Since the two HWs run
in parallel, it is necessary to reorder the output images
to ensure that the order is consistent with the input images.

Signed-off-by: kyrie wu <kyrie.wu@mediatek.com>
Signed-off-by: irui wang <irui.wang@mediatek.com>
---
 .../platform/mediatek/jpeg/mtk_jpeg_core.c    | 11 +----
 .../platform/mediatek/jpeg/mtk_jpeg_core.h    | 43 ++++++++++++-----
 .../platform/mediatek/jpeg/mtk_jpeg_dec_hw.c  |  1 +
 .../platform/mediatek/jpeg/mtk_jpeg_dec_hw.h  |  3 +-
 .../platform/mediatek/jpeg/mtk_jpeg_enc_hw.c  | 47 ++++++++++++++++++-
 5 files changed, 81 insertions(+), 24 deletions(-)

diff --git a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
index 43fc5e9dae9d..0d4e7220e509 100644
--- a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
+++ b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
@@ -111,15 +111,6 @@ enum {
 	MTK_JPEG_BUF_FLAGS_LAST_FRAME		= 1,
 };
 
-struct mtk_jpeg_src_buf {
-	u32 frame_num;
-	struct vb2_v4l2_buffer b;
-	struct list_head list;
-	struct mtk_jpeg_dec_param dec_param;
-
-	struct mtk_jpeg_ctx *curr_ctx;
-};
-
 static int debug;
 module_param(debug, int, 0644);
 
@@ -1377,6 +1368,8 @@ static int mtk_jpeg_open(struct file *file)
 	if (jpeg->is_jpgenc_multihw)
 		INIT_WORK(&ctx->jpeg_work, mtk_jpegenc_worker);
 
+	INIT_LIST_HEAD(&ctx->dst_done_queue);
+	spin_lock_init(&ctx->done_queue_lock);
 	v4l2_fh_init(&ctx->fh, vfd);
 	file->private_data = &ctx->fh;
 	v4l2_fh_add(&ctx->fh);
diff --git a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.h b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.h
index cbc6fbc21681..0f69402ffce6 100644
--- a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.h
+++ b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.h
@@ -14,10 +14,11 @@
 #include <media/v4l2-ctrls.h>
 #include <media/v4l2-device.h>
 #include <media/v4l2-fh.h>
+#include <media/videobuf2-v4l2.h>
 
-#define MTK_JPEG_NAME		"mtk-jpeg"
+#include "mtk_jpeg_dec_hw.h"
 
-#define MTK_JPEG_COMP_MAX		3
+#define MTK_JPEG_NAME		"mtk-jpeg"
 
 #define MTK_JPEG_FMT_FLAG_OUTPUT	BIT(0)
 #define MTK_JPEG_FMT_FLAG_CAPTURE	BIT(1)
@@ -75,6 +76,15 @@ struct mtk_jpeg_variant {
 	u32 cap_q_default_fourcc;
 };
 
+struct mtk_jpeg_src_buf {
+	u32 frame_num;
+	struct vb2_v4l2_buffer b;
+	struct list_head list;
+	struct mtk_jpeg_dec_param dec_param;
+
+	struct mtk_jpeg_ctx *curr_ctx;
+};
+
 enum mtk_jpeg_hw_state {
 	MTK_JPEG_HW_IDLE = 0,
 	MTK_JPEG_HW_BUSY = 1,
@@ -205,17 +215,20 @@ struct mtk_jpeg_q_data {
 
 /**
  * struct mtk_jpeg_ctx - the device context data
- * @jpeg:		JPEG IP device for this context
- * @out_q:		source (output) queue information
- * @cap_q:		destination (capture) queue queue information
- * @fh:			V4L2 file handle
- * @state:		state of the context
- * @enable_exif:	enable exif mode of jpeg encoder
- * @enc_quality:	jpeg encoder quality
- * @restart_interval:	jpeg encoder restart interval
- * @ctrl_hdl:		controls handler
- * @jpeg_work:		jpeg encoder workqueue
- * @total_frame_num:	encoded frame number
+ * @jpeg:			JPEG IP device for this context
+ * @out_q:			source (output) queue information
+ * @cap_q:			destination queue information
+ * @fh:				V4L2 file handle
+ * @state:			state of the context
+ * @enable_exif:		enable exif mode of jpeg encoder
+ * @enc_quality:		jpeg encoder quality
+ * @restart_interval:		jpeg encoder restart interval
+ * @ctrl_hdl:			controls handler
+ * @jpeg_work:			jpeg encoder workqueue
+ * @total_frame_num:		encoded frame number
+ * @dst_done_queue:		encoded frame buffer queue
+ * @done_queue_lock:		encoded frame operation spinlock
+ * @last_done_frame_num:	the last encoded frame number
  */
 struct mtk_jpeg_ctx {
 	struct mtk_jpeg_dev		*jpeg;
@@ -230,6 +243,10 @@ struct mtk_jpeg_ctx {
 
 	struct work_struct jpeg_work;
 	u32 total_frame_num;
+	struct list_head dst_done_queue;
+	/* spinlock protecting the encode done buffer */
+	spinlock_t done_queue_lock;
+	u32 last_done_frame_num;
 };
 
 #endif /* _MTK_JPEG_CORE_H */
diff --git a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_dec_hw.c b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_dec_hw.c
index afbbfd5d02bc..1e3852295f2f 100644
--- a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_dec_hw.c
+++ b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_dec_hw.c
@@ -9,6 +9,7 @@
 #include <linux/kernel.h>
 #include <media/videobuf2-core.h>
 
+#include "mtk_jpeg_core.h"
 #include "mtk_jpeg_dec_hw.h"
 
 #define MTK_JPEG_DUNUM_MASK(val)	(((val) - 1) & 0x3)
diff --git a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_dec_hw.h b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_dec_hw.h
index fa0d45fd7c34..87aaa5c9082b 100644
--- a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_dec_hw.h
+++ b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_dec_hw.h
@@ -11,9 +11,10 @@
 
 #include <media/videobuf2-core.h>
 
-#include "mtk_jpeg_core.h"
 #include "mtk_jpeg_dec_reg.h"
 
+#define MTK_JPEG_COMP_MAX		3
+
 enum {
 	MTK_JPEG_DEC_RESULT_EOF_DONE		= 0,
 	MTK_JPEG_DEC_RESULT_PAUSE		= 1,
diff --git a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_enc_hw.c b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_enc_hw.c
index 02d6c4993653..1bbb712d78d0 100644
--- a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_enc_hw.c
+++ b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_enc_hw.c
@@ -185,6 +185,50 @@ void mtk_jpeg_set_enc_params(struct mtk_jpeg_ctx *ctx,  void __iomem *base)
 }
 EXPORT_SYMBOL_GPL(mtk_jpeg_set_enc_params);
 
+static void mtk_jpegenc_put_buf(struct mtk_jpegenc_comp_dev *jpeg)
+{
+	struct mtk_jpeg_ctx *ctx;
+	struct vb2_v4l2_buffer *dst_buffer;
+	struct list_head *temp_entry;
+	struct list_head *pos = NULL;
+	struct mtk_jpeg_src_buf *dst_done_buf, *tmp_dst_done_buf;
+	unsigned long flags;
+
+	ctx = jpeg->hw_param.curr_ctx;
+	if (!ctx) {
+		dev_err(jpeg->dev, "comp_jpeg ctx fail !!!\n");
+		return;
+	}
+
+	dst_buffer = jpeg->hw_param.dst_buffer;
+	if (!dst_buffer) {
+		dev_err(jpeg->dev, "comp_jpeg dst_buffer fail !!!\n");
+		return;
+	}
+
+	dst_done_buf = container_of(dst_buffer,
+				    struct mtk_jpeg_src_buf, b);
+
+	spin_lock_irqsave(&ctx->done_queue_lock, flags);
+	list_add_tail(&dst_done_buf->list, &ctx->dst_done_queue);
+	while (!list_empty(&ctx->dst_done_queue) &&
+	       (pos != &ctx->dst_done_queue)) {
+		list_for_each_prev_safe(pos, temp_entry, &ctx->dst_done_queue) {
+			tmp_dst_done_buf = list_entry(pos,
+						      struct mtk_jpeg_src_buf,
+						      list);
+			if (tmp_dst_done_buf->frame_num ==
+				ctx->last_done_frame_num) {
+				list_del(&tmp_dst_done_buf->list);
+				v4l2_m2m_buf_done(&tmp_dst_done_buf->b,
+						  VB2_BUF_STATE_DONE);
+				ctx->last_done_frame_num++;
+			}
+		}
+	}
+	spin_unlock_irqrestore(&ctx->done_queue_lock, flags);
+}
+
 static void mtk_jpegenc_timeout_work(struct work_struct *work)
 {
 	struct delayed_work *dly_work = to_delayed_work(work);
@@ -207,6 +251,7 @@ static void mtk_jpegenc_timeout_work(struct work_struct *work)
 	atomic_inc(&master_jpeg->enchw_rdy);
 	wake_up(&master_jpeg->enc_hw_wq);
 	v4l2_m2m_buf_done(src_buf, buf_state);
+	mtk_jpegenc_put_buf(cjpeg);
 }
 
 static irqreturn_t mtk_jpegenc_hw_irq_handler(int irq, void *priv)
@@ -238,7 +283,7 @@ static irqreturn_t mtk_jpegenc_hw_irq_handler(int irq, void *priv)
 	vb2_set_plane_payload(&dst_buf->vb2_buf, 0, result_size);
 	buf_state = VB2_BUF_STATE_DONE;
 	v4l2_m2m_buf_done(src_buf, buf_state);
-	v4l2_m2m_buf_done(dst_buf, buf_state);
+	mtk_jpegenc_put_buf(jpeg);
 	pm_runtime_put(ctx->jpeg->dev);
 	clk_disable_unprepare(jpeg->venc_clk.clks->clk);
 	if (!list_empty(&ctx->fh.m2m_ctx->out_q_ctx.rdy_queue) ||
-- 
2.18.0

