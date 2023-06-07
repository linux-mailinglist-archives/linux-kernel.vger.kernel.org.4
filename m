Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6574972588C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 10:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239535AbjFGItg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 04:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239391AbjFGItT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 04:49:19 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 916A91BC3;
        Wed,  7 Jun 2023 01:49:16 -0700 (PDT)
X-UUID: 2a0f1430051011eeb20a276fd37b9834-20230607
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=LxYuyWc5srJqI1oN40HqXwkzejYMYsFQzZw2d2TulQ0=;
        b=FFIzEGTwr+3oXqmaVc/kyv3faSy66/AY0WbukzgZkDGm0aDceKfYumhaxlkVgPXjSPALHqdK9laEfETqL+GLnzLemDzF8ImsAjlunVqI5NOAHqX1iQknPKB4Kkg5NoMM5wb8JhCFQMcR5AiDYW+1vqq6Xvt4fZnf6gszCBgbNCs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.25,REQID:341f75ea-46ba-4583-af57-f8b5160c3ac7,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:d5b0ae3,CLOUDID:e1884d6e-2f20-4998-991c-3b78627e4938,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: 2a0f1430051011eeb20a276fd37b9834-20230607
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
        (envelope-from <yunfei.dong@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 96552809; Wed, 07 Jun 2023 16:49:07 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 7 Jun 2023 16:49:06 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 7 Jun 2023 16:49:05 +0800
From:   Yunfei Dong <yunfei.dong@mediatek.com>
To:     Chen-Yu Tsai <wenst@chromium.org>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        =?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= 
        <nfraprado@collabora.com>, Nathan Hebert <nhebert@chromium.org>
CC:     Yunfei Dong <yunfei.dong@mediatek.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Fritz Koenig <frkoenig@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Steve Cho <stevecho@chromium.org>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v2,03/10] media: mediatek: vcodec: re-write shared interface
Date:   Wed, 7 Jun 2023 16:48:54 +0800
Message-ID: <20230607084901.28021-4-yunfei.dong@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230607084901.28021-1-yunfei.dong@mediatek.com>
References: <20230607084901.28021-1-yunfei.dong@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Re-write shared interface which encoder and decoder used at
the same time. Using the common struct as the parameter of
these interface in order to remove the depedency.

Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
---
 .../mediatek/vcodec/mtk_vcodec_intr.c         | 30 ++++++++++++-------
 .../mediatek/vcodec/mtk_vcodec_intr.h         |  3 +-
 .../mediatek/vcodec/mtk_vcodec_util.c         | 19 +++++-------
 .../mediatek/vcodec/mtk_vcodec_util.h         |  9 ++----
 .../mediatek/vcodec/vdec/vdec_vp8_if.c        | 14 ++++-----
 .../mediatek/vcodec/venc/venc_h264_if.c       |  2 +-
 .../mediatek/vcodec/venc/venc_vp8_if.c        |  2 +-
 7 files changed, 39 insertions(+), 40 deletions(-)

diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_intr.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_intr.c
index 552b4c93d972..daa44f635727 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_intr.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_intr.c
@@ -11,32 +11,40 @@
 #include "mtk_vcodec_intr.h"
 #include "mtk_vcodec_util.h"
 
-int mtk_vcodec_wait_for_done_ctx(struct mtk_vcodec_ctx *ctx,
-				 int command, unsigned int timeout_ms,
+int mtk_vcodec_wait_for_done_ctx(void *priv, int command, unsigned int timeout_ms,
 				 unsigned int hw_id)
 {
+	struct mtk_vcodec_ctx *ctx = priv;
 	long timeout_jiff, ret;
-	int status = 0;
+	int status = 0, ctx_id, ctx_type;
+	int *ctx_int_cond, *ctx_int_type;
+	wait_queue_head_t *ctx_queue;
+
+	ctx_id = ctx->id;
+	ctx_type = ctx->type;
+	ctx_int_cond = ctx->int_cond;
+	ctx_int_type = ctx->int_type;
+	ctx_queue = ctx->queue;
 
 	timeout_jiff = msecs_to_jiffies(timeout_ms);
-	ret = wait_event_interruptible_timeout(ctx->queue[hw_id],
-					       ctx->int_cond[hw_id],
+	ret = wait_event_interruptible_timeout(ctx_queue[hw_id],
+					       ctx_int_cond[hw_id],
 					       timeout_jiff);
 
 	if (!ret) {
 		status = -1;	/* timeout */
 		mtk_v4l2_err("[%d] cmd=%d, type=%d, dec timeout=%ums (%d %d)",
-			     ctx->id, command, ctx->type, timeout_ms,
-			     ctx->int_cond[hw_id], ctx->int_type[hw_id]);
+			     ctx_id, command, ctx_type, timeout_ms,
+			     ctx_int_cond[hw_id], ctx_int_type[hw_id]);
 	} else if (-ERESTARTSYS == ret) {
 		status = -1;
 		mtk_v4l2_err("[%d] cmd=%d, type=%d, dec inter fail (%d %d)",
-			     ctx->id, command, ctx->type,
-			     ctx->int_cond[hw_id], ctx->int_type[hw_id]);
+			     ctx_id, command, ctx_type,
+			     ctx_int_cond[hw_id], ctx_int_type[hw_id]);
 	}
 
-	ctx->int_cond[hw_id] = 0;
-	ctx->int_type[hw_id] = 0;
+	ctx_int_cond[hw_id] = 0;
+	ctx_int_type[hw_id] = 0;
 
 	return status;
 }
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_intr.h b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_intr.h
index 9681f492813b..11bf0ef94d5d 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_intr.h
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_intr.h
@@ -12,8 +12,7 @@
 struct mtk_vcodec_ctx;
 
 /* timeout is ms */
-int mtk_vcodec_wait_for_done_ctx(struct mtk_vcodec_ctx *ctx,
-				 int command, unsigned int timeout_ms,
+int mtk_vcodec_wait_for_done_ctx(void *priv, int command, unsigned int timeout_ms,
 				 unsigned int hw_id);
 
 #endif /* _MTK_VCODEC_INTR_H_ */
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_util.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_util.c
index f214e6f67005..847e321f4fcc 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_util.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_util.c
@@ -21,24 +21,20 @@ int mtk_v4l2_dbg_level;
 EXPORT_SYMBOL(mtk_v4l2_dbg_level);
 #endif
 
-void __iomem *mtk_vcodec_get_reg_addr(struct mtk_vcodec_ctx *data,
-					unsigned int reg_idx)
+void __iomem *mtk_vcodec_get_reg_addr(void __iomem **reg_base, unsigned int reg_idx)
 {
-	struct mtk_vcodec_ctx *ctx = (struct mtk_vcodec_ctx *)data;
-
-	if (!data || reg_idx >= NUM_MAX_VCODEC_REG_BASE) {
+	if (reg_idx >= NUM_MAX_VCODEC_REG_BASE) {
 		mtk_v4l2_err("Invalid arguments, reg_idx=%d", reg_idx);
 		return NULL;
 	}
-	return ctx->dev->reg_base[reg_idx];
+	return reg_base[reg_idx];
 }
 EXPORT_SYMBOL(mtk_vcodec_get_reg_addr);
 
-int mtk_vcodec_mem_alloc(struct mtk_vcodec_ctx *data,
-			struct mtk_vcodec_mem *mem)
+int mtk_vcodec_mem_alloc(void *priv, struct mtk_vcodec_mem *mem)
 {
 	unsigned long size = mem->size;
-	struct mtk_vcodec_ctx *ctx = (struct mtk_vcodec_ctx *)data;
+	struct mtk_vcodec_ctx *ctx = priv;
 	struct device *dev = &ctx->dev->plat_dev->dev;
 
 	mem->va = dma_alloc_coherent(dev, size, &mem->dma_addr, GFP_KERNEL);
@@ -57,11 +53,10 @@ int mtk_vcodec_mem_alloc(struct mtk_vcodec_ctx *data,
 }
 EXPORT_SYMBOL(mtk_vcodec_mem_alloc);
 
-void mtk_vcodec_mem_free(struct mtk_vcodec_ctx *data,
-			struct mtk_vcodec_mem *mem)
+void mtk_vcodec_mem_free(void *priv, struct mtk_vcodec_mem *mem)
 {
 	unsigned long size = mem->size;
-	struct mtk_vcodec_ctx *ctx = (struct mtk_vcodec_ctx *)data;
+	struct mtk_vcodec_ctx *ctx = priv;
 	struct device *dev = &ctx->dev->plat_dev->dev;
 
 	if (!mem->va) {
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_util.h b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_util.h
index 587aa817e7f4..ecb0bdf3a4f4 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_util.h
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_util.h
@@ -68,12 +68,9 @@ extern int mtk_vcodec_dbg;
 #define mtk_vcodec_debug_enter(h)  mtk_vcodec_debug(h, "+")
 #define mtk_vcodec_debug_leave(h)  mtk_vcodec_debug(h, "-")
 
-void __iomem *mtk_vcodec_get_reg_addr(struct mtk_vcodec_ctx *data,
-				unsigned int reg_idx);
-int mtk_vcodec_mem_alloc(struct mtk_vcodec_ctx *data,
-				struct mtk_vcodec_mem *mem);
-void mtk_vcodec_mem_free(struct mtk_vcodec_ctx *data,
-				struct mtk_vcodec_mem *mem);
+void __iomem *mtk_vcodec_get_reg_addr(void __iomem **reg_base, unsigned int reg_idx);
+int mtk_vcodec_mem_alloc(void *priv, struct mtk_vcodec_mem *mem);
+void mtk_vcodec_mem_free(void *priv, struct mtk_vcodec_mem *mem);
 void mtk_vcodec_set_curr_ctx(struct mtk_vcodec_dev *vdec_dev,
 			     struct mtk_vcodec_ctx *ctx, int hw_idx);
 struct mtk_vcodec_ctx *mtk_vcodec_get_curr_ctx(struct mtk_vcodec_dev *vdec_dev,
diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp8_if.c b/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp8_if.c
index 88c046731754..5edbccc9ae68 100644
--- a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp8_if.c
+++ b/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp8_if.c
@@ -167,13 +167,13 @@ struct vdec_vp8_inst {
 
 static void get_hw_reg_base(struct vdec_vp8_inst *inst)
 {
-	inst->reg_base.top = mtk_vcodec_get_reg_addr(inst->ctx, VDEC_TOP);
-	inst->reg_base.cm = mtk_vcodec_get_reg_addr(inst->ctx, VDEC_CM);
-	inst->reg_base.hwd = mtk_vcodec_get_reg_addr(inst->ctx, VDEC_HWD);
-	inst->reg_base.sys = mtk_vcodec_get_reg_addr(inst->ctx, VDEC_SYS);
-	inst->reg_base.misc = mtk_vcodec_get_reg_addr(inst->ctx, VDEC_MISC);
-	inst->reg_base.ld = mtk_vcodec_get_reg_addr(inst->ctx, VDEC_LD);
-	inst->reg_base.hwb = mtk_vcodec_get_reg_addr(inst->ctx, VDEC_HWB);
+	inst->reg_base.top = mtk_vcodec_get_reg_addr(inst->ctx->dev->reg_base, VDEC_TOP);
+	inst->reg_base.cm = mtk_vcodec_get_reg_addr(inst->ctx->dev->reg_base, VDEC_CM);
+	inst->reg_base.hwd = mtk_vcodec_get_reg_addr(inst->ctx->dev->reg_base, VDEC_HWD);
+	inst->reg_base.sys = mtk_vcodec_get_reg_addr(inst->ctx->dev->reg_base, VDEC_SYS);
+	inst->reg_base.misc = mtk_vcodec_get_reg_addr(inst->ctx->dev->reg_base, VDEC_MISC);
+	inst->reg_base.ld = mtk_vcodec_get_reg_addr(inst->ctx->dev->reg_base, VDEC_LD);
+	inst->reg_base.hwb = mtk_vcodec_get_reg_addr(inst->ctx->dev->reg_base, VDEC_HWB);
 }
 
 static void write_hw_segmentation_data(struct vdec_vp8_inst *inst)
diff --git a/drivers/media/platform/mediatek/vcodec/venc/venc_h264_if.c b/drivers/media/platform/mediatek/vcodec/venc/venc_h264_if.c
index 60fd165c0d94..10365c95ebbe 100644
--- a/drivers/media/platform/mediatek/vcodec/venc/venc_h264_if.c
+++ b/drivers/media/platform/mediatek/vcodec/venc/venc_h264_if.c
@@ -612,7 +612,7 @@ static int h264_enc_init(struct mtk_vcodec_ctx *ctx)
 	inst->ctx = ctx;
 	inst->vpu_inst.ctx = ctx;
 	inst->vpu_inst.id = is_ext ? SCP_IPI_VENC_H264 : IPI_VENC_H264;
-	inst->hw_base = mtk_vcodec_get_reg_addr(inst->ctx, VENC_SYS);
+	inst->hw_base = mtk_vcodec_get_reg_addr(inst->ctx->dev->reg_base, VENC_SYS);
 
 	mtk_vcodec_debug_enter(inst);
 
diff --git a/drivers/media/platform/mediatek/vcodec/venc/venc_vp8_if.c b/drivers/media/platform/mediatek/vcodec/venc/venc_vp8_if.c
index 56ce58f761f1..73ebc35d7c99 100644
--- a/drivers/media/platform/mediatek/vcodec/venc/venc_vp8_if.c
+++ b/drivers/media/platform/mediatek/vcodec/venc/venc_vp8_if.c
@@ -336,7 +336,7 @@ static int vp8_enc_init(struct mtk_vcodec_ctx *ctx)
 	inst->ctx = ctx;
 	inst->vpu_inst.ctx = ctx;
 	inst->vpu_inst.id = IPI_VENC_VP8;
-	inst->hw_base = mtk_vcodec_get_reg_addr(inst->ctx, VENC_LT_SYS);
+	inst->hw_base = mtk_vcodec_get_reg_addr(inst->ctx->dev->reg_base, VENC_LT_SYS);
 
 	mtk_vcodec_debug_enter(inst);
 
-- 
2.18.0

