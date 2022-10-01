Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B03F5F1991
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 05:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233324AbiJAD0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 23:26:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233109AbiJADZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 23:25:40 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2108BF80A3;
        Fri, 30 Sep 2022 20:17:49 -0700 (PDT)
X-UUID: 189f2903897642d585ab51ff4907afab-20221001
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=gQH1JyEktFOJV39yJWLnXwk1nF1Uwl2E7ka1LkvPm10=;
        b=Hd6W2J7GXQ7ILuBmxb3sXsi2uqGHFai6LIfz3zMgzE8uzQD5jTB020hA0aHjg0q5lizMZPNmWhlIME1sOQgc28WbikWm2uPAlMMQfjAyCllWssOWEDzk5wRnmYmEvzhXWMzKrEMY8I3DKm9VvnZr9Vbb/dyUfPBhDGfAWxjmTT0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:56c23a73-1160-4a54-82e2-1d75663274e5,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:70
X-CID-INFO: VERSION:1.1.11,REQID:56c23a73-1160-4a54-82e2-1d75663274e5,IP:0,URL
        :0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTI
        ON:quarantine,TS:70
X-CID-META: VersionHash:39a5ff1,CLOUDID:9e67afa3-dc04-435c-b19b-71e131a5fc35,B
        ulkID:221001111747BN0SKB6G,BulkQuantity:0,Recheck:0,SF:38|28|17|19|48|823|
        824,TC:nil,Content:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:nil,QS:nil,BEC:n
        il,COL:0
X-UUID: 189f2903897642d585ab51ff4907afab-20221001
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <irui.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 278911089; Sat, 01 Oct 2022 11:17:47 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Sat, 1 Oct 2022 11:17:45 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Sat, 1 Oct 2022 11:17:44 +0800
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
Subject: [PATCH v6, 4/8] media: mediatek: vcodec: Add more extra processing for multi-core encoding
Date:   Sat, 1 Oct 2022 11:17:33 +0800
Message-ID: <20221001031737.18266-5-irui.wang@mediatek.com>
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

Add a bit for indicating support multi-core encoding, because multi-core
encoding need more working buffers for encoder hardware. The working
buffers are allocated from kernel side then pass to scp firmware side
through shared memory, the struct definition must be kept align between
kernel and scp firmware side. New another shared memory struct for
multi-core encoding.

Signed-off-by: Irui Wang <irui.wang@mediatek.com>
---
 .../platform/mediatek/vcodec/mtk_vcodec_drv.h |   2 +
 .../mediatek/vcodec/mtk_vcodec_util.c         |  19 +++
 .../mediatek/vcodec/mtk_vcodec_util.h         |   2 +
 .../mediatek/vcodec/venc/venc_h264_if.c       | 108 +++++++++++++++---
 4 files changed, 116 insertions(+), 15 deletions(-)

diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_drv.h b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_drv.h
index 6faf9ccc940f..e074198a12ad 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_drv.h
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_drv.h
@@ -27,6 +27,8 @@
 #define WAIT_INTR_TIMEOUT_MS	1000
 #define IS_VDEC_LAT_ARCH(hw_arch) ((hw_arch) >= MTK_VDEC_LAT_SINGLE_CORE)
 #define IS_VDEC_INNER_RACING(capability) ((capability) & MTK_VCODEC_INNER_RACING)
+#define MTK_VENC_MULTICORE_ENABLE BIT(1)
+#define IS_VENC_MULTICORE(capability) ((capability) & MTK_VENC_MULTICORE_ENABLE)
 
 /*
  * enum mtk_hw_reg_idx - MTK hw register base index
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_util.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_util.c
index ace78c4b5b9e..a4c2cbf4040e 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_util.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_util.c
@@ -11,6 +11,7 @@
 
 #include "mtk_vcodec_dec_hw.h"
 #include "mtk_vcodec_drv.h"
+#include "mtk_vcodec_enc_hw.h"
 #include "mtk_vcodec_util.h"
 
 void __iomem *mtk_vcodec_get_reg_addr(struct mtk_vcodec_ctx *data,
@@ -26,6 +27,24 @@ void __iomem *mtk_vcodec_get_reg_addr(struct mtk_vcodec_ctx *data,
 }
 EXPORT_SYMBOL(mtk_vcodec_get_reg_addr);
 
+void __iomem *mtk_venc_get_core_reg_addr(struct mtk_vcodec_ctx *ctx,
+					 int hw_id)
+{
+	struct mtk_venc_hw_dev *sub_core;
+
+	if (hw_id >= MTK_VENC_HW_MAX) {
+		mtk_v4l2_err("Invalid hw_id = %d", hw_id);
+		return NULL;
+	}
+
+	sub_core = (struct mtk_venc_hw_dev *)ctx->dev->enc_hw_dev[hw_id];
+	if (!sub_core)
+		return NULL;
+
+	return sub_core->reg_base;
+}
+EXPORT_SYMBOL(mtk_venc_get_core_reg_addr);
+
 int mtk_vcodec_mem_alloc(struct mtk_vcodec_ctx *data,
 			struct mtk_vcodec_mem *mem)
 {
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_util.h b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_util.h
index 71956627a0e2..0033c53d5589 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_util.h
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_util.h
@@ -50,6 +50,8 @@ struct mtk_vcodec_dev;
 
 void __iomem *mtk_vcodec_get_reg_addr(struct mtk_vcodec_ctx *data,
 				unsigned int reg_idx);
+void __iomem *mtk_venc_get_core_reg_addr(struct mtk_vcodec_ctx *data,
+					 int hw_id);
 int mtk_vcodec_mem_alloc(struct mtk_vcodec_ctx *data,
 				struct mtk_vcodec_mem *mem);
 void mtk_vcodec_mem_free(struct mtk_vcodec_ctx *data,
diff --git a/drivers/media/platform/mediatek/vcodec/venc/venc_h264_if.c b/drivers/media/platform/mediatek/vcodec/venc/venc_h264_if.c
index 13c4f860fa69..d7ed5c753a0e 100644
--- a/drivers/media/platform/mediatek/vcodec/venc/venc_h264_if.c
+++ b/drivers/media/platform/mediatek/vcodec/venc/venc_h264_if.c
@@ -50,6 +50,24 @@ enum venc_h264_vpu_work_buf {
 	VENC_H264_VPU_WORK_BUF_MAX,
 };
 
+/*
+ * enum venc_multi_core_work_buf - h264 multi core encoder buffer index
+ */
+enum venc_multi_core_work_buf {
+	VENC_MULTI_CORE_WORK_BUF_RC_INFO_CORE0,
+	VENC_MULTI_CORE_WORK_BUF_RC_CODE,
+	VENC_MULTI_CORE_WORK_BUF_REC_LUMA,
+	VENC_MULTI_CORE_WORK_BUF_REC_CHROMA,
+	VENC_MULTI_CORE_WORK_BUF_REF_LUMA,
+	VENC_MULTI_CORE_WORK_BUF_REF_CHROMA,
+	VENC_MULTI_CORE_WORK_BUF_MV_INFO_1,
+	VENC_MULTI_CORE_WORK_BUF_MV_INFO_2,
+	VENC_MULTI_CORE_WORK_BUF_SKIP_FRAME,
+	VENC_MULTI_CORE_WORK_BUF_RC_INFO_CORE1,
+	VENC_MULTI_CORE_WORK_BUF_FR_RC_INFO,
+	VENC_MULTI_CORE_WORK_BUF_MAX,
+};
+
 /*
  * enum venc_h264_bs_mode - for bs_mode argument in h264_enc_vpu_encode
  */
@@ -193,6 +211,17 @@ struct venc_h264_vsi_34 {
 	struct venc_h264_vpu_buf_34 work_bufs[VENC_H264_VPU_WORK_BUF_MAX];
 };
 
+/**
+ * struct venc_multi_core_vsi - Structure for VPU driver control and info share
+ *                             Used for multi-core encode sharing
+ * @config: h264 encoder configuration
+ * @work_bufs: working buffer information in VPU side
+ */
+struct venc_multi_core_vsi {
+	struct venc_h264_vpu_config_ext config;
+	struct venc_h264_vpu_buf work_bufs[VENC_MULTI_CORE_WORK_BUF_MAX];
+};
+
 /*
  * struct venc_h264_inst - h264 encoder AP driver instance
  * @hw_base: h264 encoder hardware register base
@@ -208,25 +237,29 @@ struct venc_h264_vsi_34 {
  *	 control and info share
  * @vsi_34: driver structure allocated by VPU side and shared to AP side for
  *	 control and info share, used for 34-bit iova sharing.
+ * @core_vsi: used for multi-core encode info sharing.
  * @ctx: context for v4l2 layer integration
  */
 struct venc_h264_inst {
-	void __iomem *hw_base;
-	struct mtk_vcodec_mem work_bufs[VENC_H264_VPU_WORK_BUF_MAX];
+	void __iomem *hw_base[MTK_VENC_HW_MAX];
+	struct mtk_vcodec_mem work_bufs[VENC_MULTI_CORE_WORK_BUF_MAX];
 	struct mtk_vcodec_mem pps_buf;
 	bool work_buf_allocated;
 	unsigned int frm_cnt;
 	unsigned int skip_frm_cnt;
 	unsigned int prepend_hdr;
 	struct venc_vpu_inst vpu_inst;
-	struct venc_h264_vsi *vsi;
-	struct venc_h264_vsi_34 *vsi_34;
+	union {
+		struct venc_h264_vsi *vsi;
+		struct venc_h264_vsi_34 *vsi_34;
+		struct venc_multi_core_vsi *core_vsi;
+	};
 	struct mtk_vcodec_ctx *ctx;
 };
 
 static inline u32 h264_read_reg(struct venc_h264_inst *inst, u32 addr)
 {
-	return readl(inst->hw_base + addr);
+	return readl(inst->hw_base[MTK_VENC_CORE_0] + addr);
 }
 
 static unsigned int h264_get_profile(struct venc_h264_inst *inst,
@@ -296,14 +329,20 @@ static unsigned int h264_get_level(struct venc_h264_inst *inst,
 
 static void h264_enc_free_work_buf(struct venc_h264_inst *inst)
 {
-	int i;
+	struct mtk_vcodec_ctx *ctx = inst->ctx;
+	int i, max_work_buf;
 
 	mtk_vcodec_debug_enter(inst);
 
+	if (IS_VENC_MULTICORE(ctx->dev->enc_capability))
+		max_work_buf = VENC_MULTI_CORE_WORK_BUF_MAX;
+	else
+		max_work_buf = VENC_H264_VPU_WORK_BUF_MAX;
+
 	/* Except the SKIP_FRAME buffers,
 	 * other buffers need to be freed by AP.
 	 */
-	for (i = 0; i < VENC_H264_VPU_WORK_BUF_MAX; i++) {
+	for (i = 0; i < max_work_buf; i++) {
 		if (i != VENC_H264_VPU_WORK_BUF_SKIP_FRAME)
 			mtk_vcodec_mem_free(inst->ctx, &inst->work_bufs[i]);
 	}
@@ -317,18 +356,25 @@ static int h264_enc_alloc_work_buf(struct venc_h264_inst *inst, bool is_34bit)
 {
 	struct venc_h264_vpu_buf *wb = NULL;
 	struct venc_h264_vpu_buf_34 *wb_34 = NULL;
-	int i;
+	struct mtk_vcodec_ctx *ctx = inst->ctx;
+	int i, max_work_buf;
 	u32 vpua, wb_size;
 	int ret = 0;
 
 	mtk_vcodec_debug_enter(inst);
 
-	if (is_34bit)
+	if (is_34bit) {
 		wb_34 = inst->vsi_34->work_bufs;
-	else
+		max_work_buf = VENC_H264_VPU_WORK_BUF_MAX;
+	} else if (IS_VENC_MULTICORE(ctx->dev->enc_capability)) {
+		wb = inst->core_vsi->work_bufs;
+		max_work_buf = VENC_MULTI_CORE_WORK_BUF_MAX;
+	} else {
 		wb = inst->vsi->work_bufs;
+		max_work_buf = VENC_H264_VPU_WORK_BUF_MAX;
+	}
 
-	for (i = 0; i < VENC_H264_VPU_WORK_BUF_MAX; i++) {
+	for (i = 0; i < max_work_buf; i++) {
 		/*
 		 * This 'wb' structure is set by VPU side and shared to AP for
 		 * buffer allocation and IO virtual addr mapping. For most of
@@ -537,6 +583,9 @@ static int h264_encode_frame(struct venc_h264_inst *inst,
 	if (MTK_ENC_IOVA_IS_34BIT(ctx)) {
 		gop_size = inst->vsi_34->config.gop_size;
 		intra_period = inst->vsi_34->config.intra_period;
+	} else if (IS_VENC_MULTICORE(ctx->dev->enc_capability)) {
+		gop_size = inst->core_vsi->config.gop_size;
+		intra_period = inst->core_vsi->config.intra_period;
 	} else {
 		gop_size = inst->vsi->config.gop_size;
 		intra_period = inst->vsi->config.intra_period;
@@ -602,8 +651,8 @@ static void h264_encode_filler(struct venc_h264_inst *inst, void *buf,
 static int h264_enc_init(struct mtk_vcodec_ctx *ctx)
 {
 	const bool is_ext = MTK_ENC_CTX_IS_EXT(ctx);
-	int ret = 0;
 	struct venc_h264_inst *inst;
+	int ret, i;
 
 	inst = kzalloc(sizeof(*inst), GFP_KERNEL);
 	if (!inst)
@@ -612,16 +661,24 @@ static int h264_enc_init(struct mtk_vcodec_ctx *ctx)
 	inst->ctx = ctx;
 	inst->vpu_inst.ctx = ctx;
 	inst->vpu_inst.id = is_ext ? SCP_IPI_VENC_H264 : IPI_VENC_H264;
-	inst->hw_base = mtk_vcodec_get_reg_addr(inst->ctx, VENC_SYS);
+	inst->hw_base[0] = mtk_vcodec_get_reg_addr(inst->ctx, VENC_SYS);
 
 	mtk_vcodec_debug_enter(inst);
 
 	ret = vpu_enc_init(&inst->vpu_inst);
 
-	if (MTK_ENC_IOVA_IS_34BIT(ctx))
+	if (MTK_ENC_IOVA_IS_34BIT(ctx)) {
 		inst->vsi_34 = (struct venc_h264_vsi_34 *)inst->vpu_inst.vsi;
-	else
+	} else if (IS_VENC_MULTICORE(ctx->dev->enc_capability)) {
+		inst->core_vsi =
+			(struct venc_multi_core_vsi *)inst->vpu_inst.vsi;
+
+		for (i = 1; i < MTK_VENC_HW_MAX; i++)
+			inst->hw_base[i] =
+				mtk_venc_get_core_reg_addr(inst->ctx, i);
+	} else {
 		inst->vsi = (struct venc_h264_vsi *)inst->vpu_inst.vsi;
+	}
 
 	mtk_vcodec_debug_leave(inst);
 
@@ -766,6 +823,25 @@ static void h264_enc_set_vsi_34_configs(struct venc_h264_inst *inst,
 	inst->vsi_34->config.wfd = 0;
 }
 
+static void h264_enc_set_core_configs(struct venc_h264_inst *inst,
+				      struct venc_enc_param *enc_prm)
+{
+	inst->core_vsi->config.input_fourcc = enc_prm->input_yuv_fmt;
+	inst->core_vsi->config.bitrate = enc_prm->bitrate;
+	inst->core_vsi->config.pic_w = enc_prm->width;
+	inst->core_vsi->config.pic_h = enc_prm->height;
+	inst->core_vsi->config.buf_w = enc_prm->buf_width;
+	inst->core_vsi->config.buf_h = enc_prm->buf_height;
+	inst->core_vsi->config.gop_size = enc_prm->gop_size;
+	inst->core_vsi->config.framerate = enc_prm->frm_rate;
+	inst->core_vsi->config.intra_period = enc_prm->intra_period;
+	inst->core_vsi->config.profile =
+		h264_get_profile(inst, enc_prm->h264_profile);
+	inst->core_vsi->config.level =
+		h264_get_level(inst, enc_prm->h264_level);
+	inst->core_vsi->config.wfd = 0;
+}
+
 static int h264_enc_set_param(void *handle,
 			      enum venc_set_param_type type,
 			      struct venc_enc_param *enc_prm)
@@ -781,6 +857,8 @@ static int h264_enc_set_param(void *handle,
 	case VENC_SET_PARAM_ENC:
 		if (is_34bit)
 			h264_enc_set_vsi_34_configs(inst, enc_prm);
+		else if (IS_VENC_MULTICORE(ctx->dev->enc_capability))
+			h264_enc_set_core_configs(inst, enc_prm);
 		else
 			h264_enc_set_vsi_configs(inst, enc_prm);
 		ret = vpu_enc_set_param(&inst->vpu_inst, type, enc_prm);
-- 
2.18.0

