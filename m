Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D60C46176EF
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 07:49:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbiKCGtn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 02:49:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbiKCGtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 02:49:00 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7AAFB84B;
        Wed,  2 Nov 2022 23:48:54 -0700 (PDT)
X-UUID: f35dbd609f79423f99b1147a918842be-20221103
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=mYN/ambJAALuLeOcITnsqW8kjVK1ZaIAfZl2s4MSpAY=;
        b=S1kgK8trk2UozOTzhfOCcY9J8GXaqUR/Eia3rxcAwYMB5N/gcYFAYvrltHVkZln+ivRzpL2ZQmnd+Ux7vfhB+aBS7ZANVwKte7jSFBYfAFpJdIUq6bmdsZFCuXVD4j6dH3RNZNhts1K1hH8SikChUIewqK5KNOgJ0YxqVLz916c=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.12,REQID:90a257f1-8a44-4bb5-a11f-ea8e86c033d8,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:90
X-CID-INFO: VERSION:1.1.12,REQID:90a257f1-8a44-4bb5-a11f-ea8e86c033d8,IP:0,URL
        :0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTIO
        N:quarantine,TS:90
X-CID-META: VersionHash:62cd327,CLOUDID:97cf7d81-3116-4fbc-b86b-83475c3df513,B
        ulkID:22110314485016Y8I186,BulkQuantity:0,Recheck:0,SF:38|28|17|19|48,TC:n
        il,Content:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: f35dbd609f79423f99b1147a918842be-20221103
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
        (envelope-from <moudy.ho@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 431970614; Thu, 03 Nov 2022 14:48:47 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 3 Nov 2022 14:48:45 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Thu, 3 Nov 2022 14:48:45 +0800
From:   Moudy Ho <moudy.ho@mediatek.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
CC:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        <linux-media@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Moudy Ho <moudy.ho@mediatek.com>
Subject: [PATCH v3 10/10] media: platform: mtk-mdp3: decompose hardware-related information in shared memory
Date:   Thu, 3 Nov 2022 14:48:42 +0800
Message-ID: <20221103064842.12042-11-moudy.ho@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20221103064842.12042-1-moudy.ho@mediatek.com>
References: <20221103064842.12042-1-moudy.ho@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PDS_OTHER_BAD_TLD,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The communication between the MDP3 kernel driver and SCP is to
pass a shared memory through the cooperation of "mtk-mdp3-vpu.c" and
remoteproc driver.
The data structure of this shared memory is defined in "mtk-img-ipi.h",
as shown below:

vpu->work_addr -> +-----------------------------------------+
                  |                                         |
                  | To SCP : Input frame parameters         |
                  |          (struct img_ipi_frameparam)    |
                  |                                         |
     vpu->pool -> +-----------------------------------------+
                  |                                         |
                  | From SCP : Output component config pool |
                  |            (struct img_config)          |
                  |                                         |
                  |           *struct img_confg 1           |
                  |                    |                    |
                  |                    |                    |
                  |                    v                    |
                  |           *struct img_config N          |
                  |            (N = MDP_CONFIG_POOL_SIZE)   |
                  +-----------------------------------------+

One output component configuration contains the components
currently used by the pipeline, and has the register settings
that each component needs to set.

Since the quantity, type and function of components on each chip
will vary, the effect is that the size of the "struct img_config"
and its substructures will be different on each chip.
In addition, all chips will have to update their SCP firmware for
every change if the output component config structure is defined
and shared by a common header.

Therefore, all functions that operate on "struct img_config" and
its substructures must be separated by chips and so are the
relevant definations.

Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
---
 .../mediatek/mdp3/mt8183/mdp3-comp-mt8183.h   | 144 +++++++++
 .../platform/mediatek/mdp3/mtk-img-ipi.h      | 149 ++--------
 .../platform/mediatek/mdp3/mtk-mdp3-cmdq.c    |  94 +++---
 .../platform/mediatek/mdp3/mtk-mdp3-comp.c    | 277 ++++++++++++------
 .../platform/mediatek/mdp3/mtk-mdp3-core.c    |   1 +
 .../platform/mediatek/mdp3/mtk-mdp3-core.h    |   5 +
 6 files changed, 415 insertions(+), 255 deletions(-)
 create mode 100644 drivers/media/platform/mediatek/mdp3/mt8183/mdp3-comp-mt8183.h

diff --git a/drivers/media/platform/mediatek/mdp3/mt8183/mdp3-comp-mt8183.h b/drivers/media/platform/mediatek/mdp3/mt8183/mdp3-comp-mt8183.h
new file mode 100644
index 000000000000..f6db24060403
--- /dev/null
+++ b/drivers/media/platform/mediatek/mdp3/mt8183/mdp3-comp-mt8183.h
@@ -0,0 +1,144 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2022 MediaTek Inc.
+ * Author: Ping-Hsun Wu <ping-hsun.wu@mediatek.com>
+ */
+
+#ifndef __MDP3_COMP_MT8183_H__
+#define __MDP3_COMP_MT8183_H__
+
+#include "mtk-mdp3-type.h"
+
+/*
+ * ISP-MDP generic output information
+ * MD5 of the target SCP blob:
+ *     6da52bdcf4bf76a0983b313e1d4745d6
+ */
+
+#define IMG_MAX_SUBFRAMES_8183      14
+
+struct img_comp_frame_8183 {
+	u32 output_disable:1;
+	u32 bypass:1;
+	u16 in_width;
+	u16 in_height;
+	u16 out_width;
+	u16 out_height;
+	struct img_crop crop;
+	u16 in_total_width;
+	u16 out_total_width;
+} __packed;
+
+struct img_comp_subfrm_8183 {
+	u32 tile_disable:1;
+	struct img_region in;
+	struct img_region out;
+	struct img_offset luma;
+	struct img_offset chroma;
+	s16 out_vertical; /* Output vertical index */
+	s16 out_horizontal; /* Output horizontal index */
+} __packed;
+
+struct mdp_rdma_subfrm_8183 {
+	u32 offset[IMG_MAX_PLANES];
+	u32 offset_0_p;
+	u32 src;
+	u32 clip;
+	u32 clip_ofst;
+} __packed;
+
+struct mdp_rdma_data_8183 {
+	u32 src_ctrl;
+	u32 control;
+	u32 iova[IMG_MAX_PLANES];
+	u32 iova_end[IMG_MAX_PLANES];
+	u32 mf_bkgd;
+	u32 mf_bkgd_in_pxl;
+	u32 sf_bkgd;
+	u32 ufo_dec_y;
+	u32 ufo_dec_c;
+	u32 transform;
+	struct mdp_rdma_subfrm_8183 subfrms[IMG_MAX_SUBFRAMES_8183];
+} __packed;
+
+struct mdp_rsz_subfrm_8183 {
+	u32 control2;
+	u32 src;
+	u32 clip;
+} __packed;
+
+struct mdp_rsz_data_8183 {
+	u32 coeff_step_x;
+	u32 coeff_step_y;
+	u32 control1;
+	u32 control2;
+	struct mdp_rsz_subfrm_8183 subfrms[IMG_MAX_SUBFRAMES_8183];
+} __packed;
+
+struct mdp_wrot_subfrm_8183 {
+	u32 offset[IMG_MAX_PLANES];
+	u32 src;
+	u32 clip;
+	u32 clip_ofst;
+	u32 main_buf;
+} __packed;
+
+struct mdp_wrot_data_8183 {
+	u32 iova[IMG_MAX_PLANES];
+	u32 control;
+	u32 stride[IMG_MAX_PLANES];
+	u32 mat_ctrl;
+	u32 fifo_test;
+	u32 filter;
+	struct mdp_wrot_subfrm_8183 subfrms[IMG_MAX_SUBFRAMES_8183];
+} __packed;
+
+struct mdp_wdma_subfrm_8183 {
+	u32 offset[IMG_MAX_PLANES];
+	u32 src;
+	u32 clip;
+	u32 clip_ofst;
+} __packed;
+
+struct mdp_wdma_data_8183 {
+	u32 wdma_cfg;
+	u32 iova[IMG_MAX_PLANES];
+	u32 w_in_byte;
+	u32 uv_stride;
+	struct mdp_wdma_subfrm_8183 subfrms[IMG_MAX_SUBFRAMES_8183];
+} __packed;
+
+struct isp_data_8183 {
+	u64 dl_flags; /* 1 << (enum mdp_comp_type) */
+	u32 smxi_iova[4];
+	u32 cq_idx;
+	u32 cq_iova;
+	u32 tpipe_iova[IMG_MAX_SUBFRAMES_8183];
+} __packed;
+
+struct img_compparam_8183 {
+	u16 type; /* enum mdp_comp_id */
+	u16 id; /* engine alias_id */
+	u32 input;
+	u32 outputs[IMG_MAX_HW_OUTPUTS];
+	u32 num_outputs;
+	struct img_comp_frame_8183 frame;
+	struct img_comp_subfrm_8183 subfrms[IMG_MAX_SUBFRAMES_8183];
+	u32 num_subfrms;
+	union {
+		struct mdp_rdma_data_8183 rdma;
+		struct mdp_rsz_data_8183 rsz;
+		struct mdp_wrot_data_8183 wrot;
+		struct mdp_wdma_data_8183 wdma;
+		struct isp_data_8183 isp;
+	};
+} __packed;
+
+struct img_config_8183 {
+	struct img_compparam_8183 components[IMG_MAX_COMPONENTS];
+	u32 num_components;
+	struct img_mmsys_ctrl ctrls[IMG_MAX_SUBFRAMES_8183];
+	u32 num_subfrms;
+} __packed;
+
+#endif  /* __MDP3_COMP_MT8183_H__ */
diff --git a/drivers/media/platform/mediatek/mdp3/mtk-img-ipi.h b/drivers/media/platform/mediatek/mdp3/mtk-img-ipi.h
index 7078f997e3cb..7872db94e737 100644
--- a/drivers/media/platform/mediatek/mdp3/mtk-img-ipi.h
+++ b/drivers/media/platform/mediatek/mdp3/mtk-img-ipi.h
@@ -9,13 +9,11 @@
 #define __MTK_IMG_IPI_H__
 
 #include <linux/types.h>
+#include <linux/err.h>
 #include "mtk-mdp3-type.h"
+#include "mt8183/mdp3-comp-mt8183.h"
 
-/*
- * ISP-MDP generic input information
- * MD5 of the target SCP blob:
- *     6da52bdcf4bf76a0983b313e1d4745d6
- */
+/* ISP-MDP generic input information */
 
 #define IMG_IPI_INIT    1
 #define IMG_IPI_DEINIT  2
@@ -116,132 +114,37 @@ struct img_frameparam {
 	struct img_ipi_frameparam frameparam;
 } __packed;
 
-/* ISP-MDP generic output information */
-
-struct img_comp_frame {
-	u32 output_disable:1;
-	u32 bypass:1;
-	u16 in_width;
-	u16 in_height;
-	u16 out_width;
-	u16 out_height;
-	struct img_crop crop;
-	u16 in_total_width;
-	u16 out_total_width;
-} __packed;
-
-struct img_comp_subfrm {
-	u32 tile_disable:1;
-	struct img_region in;
-	struct img_region out;
-	struct img_offset luma;
-	struct img_offset chroma;
-	s16 out_vertical; /* Output vertical index */
-	s16 out_horizontal; /* Output horizontal index */
-} __packed;
-
-#define IMG_MAX_SUBFRAMES	14
-
-struct mdp_rdma_subfrm {
-	u32 offset[IMG_MAX_PLANES];
-	u32 offset_0_p;
-	u32 src;
-	u32 clip;
-	u32 clip_ofst;
-} __packed;
-
-struct mdp_rdma_data {
-	u32 src_ctrl;
-	u32 control;
-	u32 iova[IMG_MAX_PLANES];
-	u32 iova_end[IMG_MAX_PLANES];
-	u32 mf_bkgd;
-	u32 mf_bkgd_in_pxl;
-	u32 sf_bkgd;
-	u32 ufo_dec_y;
-	u32 ufo_dec_c;
-	u32 transform;
-	struct mdp_rdma_subfrm subfrms[IMG_MAX_SUBFRAMES];
-} __packed;
-
-struct mdp_rsz_subfrm {
-	u32 control2;
-	u32 src;
-	u32 clip;
-} __packed;
-
-struct mdp_rsz_data {
-	u32 coeff_step_x;
-	u32 coeff_step_y;
-	u32 control1;
-	u32 control2;
-	struct mdp_rsz_subfrm subfrms[IMG_MAX_SUBFRAMES];
-} __packed;
-
-struct mdp_wrot_subfrm {
-	u32 offset[IMG_MAX_PLANES];
-	u32 src;
-	u32 clip;
-	u32 clip_ofst;
-	u32 main_buf;
-} __packed;
-
-struct mdp_wrot_data {
-	u32 iova[IMG_MAX_PLANES];
-	u32 control;
-	u32 stride[IMG_MAX_PLANES];
-	u32 mat_ctrl;
-	u32 fifo_test;
-	u32 filter;
-	struct mdp_wrot_subfrm subfrms[IMG_MAX_SUBFRAMES];
-} __packed;
+#define CFG_CTX_ADDR_8183(cfg, addr) (						\
+	IS_ERR_OR_NULL(cfg) ? NULL : (&(cfg->config_8183.addr)))
+#define CFG_CTX_ADDR(plat, cfg, addr) (						\
+	IS_ERR_OR_NULL(cfg) ? NULL :						\
+	((plat == MDP_PLAT_MT8183) ? CFG_CTX_ADDR_8183(cfg, addr) : NULL)	\
+	)
 
-struct mdp_wdma_subfrm {
-	u32 offset[IMG_MAX_PLANES];
-	u32 src;
-	u32 clip;
-	u32 clip_ofst;
-} __packed;
+#define CFG_CTX_8183(cfg, mem) (						\
+	IS_ERR_OR_NULL(cfg) ? 0 : ((&(cfg->config_8183))->mem))
+#define CFG_CTX(plat, cfg, mem) (						\
+	IS_ERR_OR_NULL(cfg) ? 0 :						\
+	((plat == MDP_PLAT_MT8183) ? CFG_CTX_8183(cfg, mem) : 0)		\
+	)
 
-struct mdp_wdma_data {
-	u32 wdma_cfg;
-	u32 iova[IMG_MAX_PLANES];
-	u32 w_in_byte;
-	u32 uv_stride;
-	struct mdp_wdma_subfrm subfrms[IMG_MAX_SUBFRAMES];
-} __packed;
+#define COMP_CTX_8183(comp, mem) (						\
+	IS_ERR_OR_NULL(comp) ? 0 : ((&(comp->comp_8183))->mem))
+#define COMP_CTX(plat, comp, mem) (						\
+	IS_ERR_OR_NULL(comp) ? 0 :						\
+	((plat == MDP_PLAT_MT8183) ? COMP_CTX_8183(comp, mem) : 0)		\
+	)
 
-struct isp_data {
-	u64 dl_flags; /* 1 << (enum mdp_comp_type) */
-	u32 smxi_iova[4];
-	u32 cq_idx;
-	u32 cq_iova;
-	u32 tpipe_iova[IMG_MAX_SUBFRAMES];
+struct img_config {
+	union {
+		struct img_config_8183 config_8183;
+	};
 } __packed;
 
 struct img_compparam {
-	u16 type; /* enum mdp_comp_type */
-	u16 id; /* enum mtk_mdp_comp_id */
-	u32 input;
-	u32 outputs[IMG_MAX_HW_OUTPUTS];
-	u32 num_outputs;
-	struct img_comp_frame frame;
-	struct img_comp_subfrm subfrms[IMG_MAX_SUBFRAMES];
-	u32 num_subfrms;
 	union {
-		struct mdp_rdma_data rdma;
-		struct mdp_rsz_data rsz;
-		struct mdp_wrot_data wrot;
-		struct mdp_wdma_data wdma;
-		struct isp_data isp;
+		struct img_compparam_8183 comp_8183;
 	};
 } __packed;
 
-struct img_config {
-	struct img_compparam components[IMG_MAX_COMPONENTS];
-	u32 num_components;
-	struct img_mmsys_ctrl ctrls[IMG_MAX_SUBFRAMES];
-	u32 num_subfrms;
-} __packed;
-
 #endif  /* __MTK_IMG_IPI_H__ */
diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-cmdq.c b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-cmdq.c
index 0ce291760acb..5d66aeaa1a34 100644
--- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-cmdq.c
+++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-cmdq.c
@@ -10,6 +10,7 @@
 #include "mtk-mdp3-comp.h"
 #include "mtk-mdp3-core.h"
 #include "mtk-mdp3-m2m.h"
+#include "mtk-img-ipi.h"
 
 #define MDP_PATH_MAX_COMPS	IMG_MAX_COMPONENTS
 
@@ -28,11 +29,12 @@ struct mdp_path {
  #define call_op(ctx, op, ...) \
 	(has_op(ctx, op) ? (ctx)->comp->ops->op(ctx, ##__VA_ARGS__) : 0)
 
-static bool is_output_disabled(const struct img_compparam *param, u32 count)
+static bool is_output_disabled(const enum mdp_platform_id id,
+			       const struct img_compparam *param, u32 count)
 {
-	return (count < param->num_subfrms) ?
-		(param->frame.output_disable ||
-		param->subfrms[count].tile_disable) :
+	return (count < COMP_CTX(id, param, num_subfrms)) ?
+		COMP_CTX(id, param, frame.output_disable) ||
+		COMP_CTX(id, param, subfrms[count].tile_disable) :
 		true;
 }
 
@@ -52,12 +54,14 @@ static int mdp_path_subfrm_require(const struct mdp_path *path,
 				   struct mdp_cmdq_cmd *cmd,
 				   s32 *mutex_id, u32 count)
 {
-	const struct img_config *config = path->config;
+	const enum mdp_platform_id plat_id = path->mdp_dev->mdp_data->mdp_plat_id;
 	const struct mdp_comp_ctx *ctx;
 	const struct mtk_mdp_driver_data *data = path->mdp_dev->mdp_data;
 	struct device *dev = &path->mdp_dev->pdev->dev;
 	struct mtk_mutex **mutex = path->mdp_dev->mdp_mutex;
-	int id, index;
+	int id, index, num_comp;
+
+	num_comp = CFG_CTX(plat_id, path->config, num_components);
 
 	/* Decide which mutex to use based on the current pipeline */
 	switch (path->comps[0].comp->public_id) {
@@ -83,9 +87,9 @@ static int mdp_path_subfrm_require(const struct mdp_path *path,
 	}
 
 	/* Set mutex mod */
-	for (index = 0; index < config->num_components; index++) {
+	for (index = 0; index < num_comp; index++) {
 		ctx = &path->comps[index];
-		if (is_output_disabled(ctx->param, count))
+		if (is_output_disabled(plat_id, ctx->param, count))
 			continue;
 		id = ctx->comp->public_id;
 		mtk_mutex_write_mod(mutex[*mutex_id],
@@ -102,11 +106,11 @@ static int mdp_path_subfrm_run(const struct mdp_path *path,
 			       struct mdp_cmdq_cmd *cmd,
 			       s32 *mutex_id, u32 count)
 {
-	const struct img_config *config = path->config;
+	const enum mdp_platform_id id = path->mdp_dev->mdp_data->mdp_plat_id;
 	const struct mdp_comp_ctx *ctx;
 	struct device *dev = &path->mdp_dev->pdev->dev;
 	struct mtk_mutex **mutex = path->mdp_dev->mdp_mutex;
-	int index;
+	int index, num_comp;
 	s32 event;
 
 	if (-1 == *mutex_id) {
@@ -114,11 +118,13 @@ static int mdp_path_subfrm_run(const struct mdp_path *path,
 		return -EINVAL;
 	}
 
+	num_comp = CFG_CTX(id, path->config, num_components);
+
 	/* Wait WROT SRAM shared to DISP RDMA */
 	/* Clear SOF event for each engine */
-	for (index = 0; index < config->num_components; index++) {
+	for (index = 0; index < num_comp; index++) {
 		ctx = &path->comps[index];
-		if (is_output_disabled(ctx->param, count))
+		if (is_output_disabled(id, ctx->param, count))
 			continue;
 		event = ctx->comp->gce_event[MDP_GCE_EVENT_SOF];
 		if (event != MDP_GCE_NO_EVENT)
@@ -129,9 +135,9 @@ static int mdp_path_subfrm_run(const struct mdp_path *path,
 	mtk_mutex_enable_by_cmdq(mutex[*mutex_id], (void *)&cmd->pkt);
 
 	/* Wait SOF events and clear mutex modules (optional) */
-	for (index = 0; index < config->num_components; index++) {
+	for (index = 0; index < num_comp; index++) {
 		ctx = &path->comps[index];
-		if (is_output_disabled(ctx->param, count))
+		if (is_output_disabled(id, ctx->param, count))
 			continue;
 		event = ctx->comp->gce_event[MDP_GCE_EVENT_SOF];
 		if (event != MDP_GCE_NO_EVENT)
@@ -143,16 +149,18 @@ static int mdp_path_subfrm_run(const struct mdp_path *path,
 
 static int mdp_path_ctx_init(struct mdp_dev *mdp, struct mdp_path *path)
 {
-	const struct img_config *config = path->config;
-	int index, ret;
+	const enum mdp_platform_id id = mdp->mdp_data->mdp_plat_id;
+	void *param;
+	int index, ret, num_comp;
 
-	if (config->num_components < 1)
+	num_comp = CFG_CTX(id, path->config, num_components);
+	if (num_comp < 1)
 		return -EINVAL;
 
-	for (index = 0; index < config->num_components; index++) {
+	for (index = 0; index < num_comp; index++) {
+		param = (void *)CFG_CTX_ADDR(id, path->config, components[index]);
 		ret = mdp_comp_ctx_config(mdp, &path->comps[index],
-					  &config->components[index],
-					  path->param);
+					  param, path->param);
 		if (ret)
 			return ret;
 	}
@@ -163,12 +171,15 @@ static int mdp_path_ctx_init(struct mdp_dev *mdp, struct mdp_path *path)
 static int mdp_path_config_subfrm(struct mdp_cmdq_cmd *cmd,
 				  struct mdp_path *path, u32 count)
 {
-	const struct img_config *config = path->config;
-	const struct img_mmsys_ctrl *ctrl = &config->ctrls[count];
+	const enum mdp_platform_id id = path->mdp_dev->mdp_data->mdp_plat_id;
+	const struct img_mmsys_ctrl *ctrl;
 	const struct img_mux *set;
 	struct mdp_comp_ctx *ctx;
 	s32 mutex_id;
-	int index, ret;
+	int index, ret, num_comp;
+
+	num_comp = CFG_CTX(id, path->config, num_components);
+	ctrl = CFG_CTX_ADDR(id, path->config, ctrls[count]);
 
 	/* Acquire components */
 	ret = mdp_path_subfrm_require(path, cmd, &mutex_id, count);
@@ -181,9 +192,9 @@ static int mdp_path_config_subfrm(struct mdp_cmdq_cmd *cmd,
 				    set->value, 0xFFFFFFFF);
 	}
 	/* Config sub-frame information */
-	for (index = (config->num_components - 1); index >= 0; index--) {
+	for (index = (num_comp - 1); index >= 0; index--) {
 		ctx = &path->comps[index];
-		if (is_output_disabled(ctx->param, count))
+		if (is_output_disabled(id, ctx->param, count))
 			continue;
 		ret = call_op(ctx, config_subfrm, cmd, count);
 		if (ret)
@@ -194,16 +205,16 @@ static int mdp_path_config_subfrm(struct mdp_cmdq_cmd *cmd,
 	if (ret)
 		return ret;
 	/* Wait components done */
-	for (index = 0; index < config->num_components; index++) {
+	for (index = 0; index < num_comp; index++) {
 		ctx = &path->comps[index];
-		if (is_output_disabled(ctx->param, count))
+		if (is_output_disabled(id, ctx->param, count))
 			continue;
 		ret = call_op(ctx, wait_comp_event, cmd);
 		if (ret)
 			return ret;
 	}
 	/* Advance to the next sub-frame */
-	for (index = 0; index < config->num_components; index++) {
+	for (index = 0; index < num_comp; index++) {
 		ctx = &path->comps[index];
 		ret = call_op(ctx, advance_subfrm, cmd, count);
 		if (ret)
@@ -222,22 +233,25 @@ static int mdp_path_config_subfrm(struct mdp_cmdq_cmd *cmd,
 static int mdp_path_config(struct mdp_dev *mdp, struct mdp_cmdq_cmd *cmd,
 			   struct mdp_path *path)
 {
-	const struct img_config *config = path->config;
+	const enum mdp_platform_id id = mdp->mdp_data->mdp_plat_id;
 	struct mdp_comp_ctx *ctx;
-	int index, count, ret;
+	int index, count, ret, num_comp, num_sub;
+
+	num_comp = CFG_CTX(id, path->config, num_components);
+	num_sub = CFG_CTX(id, path->config, num_subfrms);
 
 	/* Config path frame */
 	/* Reset components */
-	for (index = 0; index < config->num_components; index++) {
+	for (index = 0; index < num_comp; index++) {
 		ctx = &path->comps[index];
 		ret = call_op(ctx, init_comp, cmd);
 		if (ret)
 			return ret;
 	}
 	/* Config frame mode */
-	for (index = 0; index < config->num_components; index++) {
+	for (index = 0; index < num_comp; index++) {
 		const struct v4l2_rect *compose =
-			path->composes[ctx->param->outputs[0]];
+			path->composes[COMP_CTX(id, ctx->param, outputs[0])];
 
 		ctx = &path->comps[index];
 		ret = call_op(ctx, config_frame, cmd, compose);
@@ -246,13 +260,13 @@ static int mdp_path_config(struct mdp_dev *mdp, struct mdp_cmdq_cmd *cmd,
 	}
 
 	/* Config path sub-frames */
-	for (count = 0; count < config->num_subfrms; count++) {
+	for (count = 0; count < num_sub; count++) {
 		ret = mdp_path_config_subfrm(cmd, path, count);
 		if (ret)
 			return ret;
 	}
 	/* Post processing information */
-	for (index = 0; index < config->num_components; index++) {
+	for (index = 0; index < num_comp; index++) {
 		ctx = &path->comps[index];
 		ret = call_op(ctx, post_process, cmd);
 		if (ret)
@@ -376,7 +390,7 @@ int mdp_cmdq_send(struct mdp_dev *mdp, struct mdp_cmdq_param *param)
 	struct mdp_cmdq_cmd *cmd = NULL;
 	struct mdp_comp *comps = NULL;
 	struct device *dev = &mdp->pdev->dev;
-	int i, ret;
+	int i, ret, num_comp;
 
 	atomic_inc(&mdp->job_count);
 	if (atomic_read(&mdp->suspended)) {
@@ -394,8 +408,8 @@ int mdp_cmdq_send(struct mdp_dev *mdp, struct mdp_cmdq_param *param)
 	if (ret)
 		goto err_free_cmd;
 
-	comps = kcalloc(param->config->num_components, sizeof(*comps),
-			GFP_KERNEL);
+	num_comp = CFG_CTX(mdp->mdp_data->mdp_plat_id, param->config, num_components);
+	comps = kcalloc(num_comp, sizeof(*comps), GFP_KERNEL);
 	if (!comps) {
 		ret = -ENOMEM;
 		goto err_destroy_pkt;
@@ -441,7 +455,7 @@ int mdp_cmdq_send(struct mdp_dev *mdp, struct mdp_cmdq_param *param)
 	}
 	cmdq_pkt_finalize(&cmd->pkt);
 
-	for (i = 0; i < param->config->num_components; i++)
+	for (i = 0; i < num_comp; i++)
 		memcpy(&comps[i], path->comps[i].comp,
 		       sizeof(struct mdp_comp));
 
@@ -450,7 +464,7 @@ int mdp_cmdq_send(struct mdp_dev *mdp, struct mdp_cmdq_param *param)
 	cmd->user_cmdq_cb = param->cmdq_cb;
 	cmd->user_cb_data = param->cb_data;
 	cmd->comps = comps;
-	cmd->num_comps = param->config->num_components;
+	cmd->num_comps = num_comp;
 	cmd->mdp_ctx = param->mdp_ctx;
 
 	ret = mdp_comp_clocks_on(&mdp->pdev->dev, cmd->comps, cmd->num_comps);
diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c
index 8f4786cc4416..5e8b6fc7b686 100644
--- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c
+++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c
@@ -19,6 +19,7 @@
 #include "mdp_reg_wdma.h"
 
 static u32 mdp_comp_alias_id[MDP_COMP_TYPE_COUNT];
+enum mdp_platform_id p_id;
 
 static inline const struct mdp_platform_config *
 __get_plat_cfg(const struct mdp_comp_ctx *ctx)
@@ -107,13 +108,13 @@ static int config_rdma_frame(struct mdp_comp_ctx *ctx,
 			     struct mdp_cmdq_cmd *cmd,
 			     const struct v4l2_rect *compose)
 {
-	const struct mdp_rdma_data *rdma = &ctx->param->rdma;
 	const struct mdp_platform_config *mdp_cfg = __get_plat_cfg(ctx);
 	u32 colorformat = ctx->input->buffer.format.colorformat;
 	bool block10bit = MDP_COLOR_IS_10BIT_PACKED(colorformat);
 	bool en_ufo = MDP_COLOR_IS_UFP(colorformat);
 	phys_addr_t base = ctx->comp->reg_base;
 	u8 subsys_id = ctx->comp->subsys_id;
+	u32 reg;
 
 	if (mdp_cfg && mdp_cfg->rdma_support_10bit) {
 		if (block10bit)
@@ -131,49 +132,64 @@ static int config_rdma_frame(struct mdp_comp_ctx *ctx,
 		     0x00030071);
 
 	/* Setup source frame info */
-	MM_REG_WRITE(cmd, subsys_id, base, MDP_RDMA_SRC_CON, rdma->src_ctrl,
+	reg = COMP_CTX(p_id, ctx->param, rdma.src_ctrl);
+	MM_REG_WRITE(cmd, subsys_id, base, MDP_RDMA_SRC_CON, reg,
 		     0x03C8FE0F);
 
 	if (mdp_cfg)
 		if (mdp_cfg->rdma_support_10bit && en_ufo) {
 			/* Setup source buffer base */
+			reg = COMP_CTX(p_id, ctx->param, rdma.ufo_dec_y);
 			MM_REG_WRITE(cmd, subsys_id,
 				     base, MDP_RDMA_UFO_DEC_LENGTH_BASE_Y,
-				     rdma->ufo_dec_y, 0xFFFFFFFF);
+				     reg, 0xFFFFFFFF);
+			reg = COMP_CTX(p_id, ctx->param, rdma.ufo_dec_c);
 			MM_REG_WRITE(cmd, subsys_id,
 				     base, MDP_RDMA_UFO_DEC_LENGTH_BASE_C,
-				     rdma->ufo_dec_c, 0xFFFFFFFF);
+				     reg, 0xFFFFFFFF);
 			/* Set 10bit source frame pitch */
-			if (block10bit)
+			if (block10bit) {
+				reg = COMP_CTX(p_id, ctx->param, rdma.mf_bkgd_in_pxl);
 				MM_REG_WRITE(cmd, subsys_id,
 					     base, MDP_RDMA_MF_BKGD_SIZE_IN_PXL,
-					     rdma->mf_bkgd_in_pxl, 0x001FFFFF);
+					     reg, 0x001FFFFF);
+			}
 		}
 
-	MM_REG_WRITE(cmd, subsys_id, base, MDP_RDMA_CON, rdma->control,
+	reg = COMP_CTX(p_id, ctx->param, rdma.control);
+	MM_REG_WRITE(cmd, subsys_id, base, MDP_RDMA_CON, reg,
 		     0x1110);
 	/* Setup source buffer base */
-	MM_REG_WRITE(cmd, subsys_id, base, MDP_RDMA_SRC_BASE_0, rdma->iova[0],
+	reg = COMP_CTX(p_id, ctx->param, rdma.iova[0]);
+	MM_REG_WRITE(cmd, subsys_id, base, MDP_RDMA_SRC_BASE_0, reg,
 		     0xFFFFFFFF);
-	MM_REG_WRITE(cmd, subsys_id, base, MDP_RDMA_SRC_BASE_1, rdma->iova[1],
+	reg = COMP_CTX(p_id, ctx->param, rdma.iova[1]);
+	MM_REG_WRITE(cmd, subsys_id, base, MDP_RDMA_SRC_BASE_1, reg,
 		     0xFFFFFFFF);
-	MM_REG_WRITE(cmd, subsys_id, base, MDP_RDMA_SRC_BASE_2, rdma->iova[2],
+	reg = COMP_CTX(p_id, ctx->param, rdma.iova[2]);
+	MM_REG_WRITE(cmd, subsys_id, base, MDP_RDMA_SRC_BASE_2, reg,
 		     0xFFFFFFFF);
 	/* Setup source buffer end */
+	reg = COMP_CTX(p_id, ctx->param, rdma.iova_end[0]);
 	MM_REG_WRITE(cmd, subsys_id, base, MDP_RDMA_SRC_END_0,
-		     rdma->iova_end[0], 0xFFFFFFFF);
+		     reg, 0xFFFFFFFF);
+	reg = COMP_CTX(p_id, ctx->param, rdma.iova_end[1]);
 	MM_REG_WRITE(cmd, subsys_id, base, MDP_RDMA_SRC_END_1,
-		     rdma->iova_end[1], 0xFFFFFFFF);
+		     reg, 0xFFFFFFFF);
+	reg = COMP_CTX(p_id, ctx->param, rdma.iova_end[2]);
 	MM_REG_WRITE(cmd, subsys_id, base, MDP_RDMA_SRC_END_2,
-		     rdma->iova_end[2], 0xFFFFFFFF);
+		     reg, 0xFFFFFFFF);
 	/* Setup source frame pitch */
+	reg = COMP_CTX(p_id, ctx->param, rdma.mf_bkgd);
 	MM_REG_WRITE(cmd, subsys_id, base, MDP_RDMA_MF_BKGD_SIZE_IN_BYTE,
-		     rdma->mf_bkgd, 0x001FFFFF);
+		     reg, 0x001FFFFF);
+	reg = COMP_CTX(p_id, ctx->param, rdma.sf_bkgd);
 	MM_REG_WRITE(cmd, subsys_id, base, MDP_RDMA_SF_BKGD_SIZE_IN_BYTE,
-		     rdma->sf_bkgd, 0x001FFFFF);
+		     reg, 0x001FFFFF);
 	/* Setup color transform */
+	reg = COMP_CTX(p_id, ctx->param, rdma.transform);
 	MM_REG_WRITE(cmd, subsys_id, base, MDP_RDMA_TRANSFORM_0,
-		     rdma->transform, 0x0F110000);
+		     reg, 0x0F110000);
 
 	return 0;
 }
@@ -181,47 +197,58 @@ static int config_rdma_frame(struct mdp_comp_ctx *ctx,
 static int config_rdma_subfrm(struct mdp_comp_ctx *ctx,
 			      struct mdp_cmdq_cmd *cmd, u32 index)
 {
-	const struct mdp_rdma_subfrm *subfrm = &ctx->param->rdma.subfrms[index];
-	const struct img_comp_subfrm *csf = &ctx->param->subfrms[index];
 	const struct mdp_platform_config *mdp_cfg = __get_plat_cfg(ctx);
 	u32 colorformat = ctx->input->buffer.format.colorformat;
 	bool block10bit = MDP_COLOR_IS_10BIT_PACKED(colorformat);
 	bool en_ufo = MDP_COLOR_IS_UFP(colorformat);
 	phys_addr_t base = ctx->comp->reg_base;
 	u8 subsys_id = ctx->comp->subsys_id;
+	u32 csf_l, csf_r;
+	u32 reg;
 
 	/* Enable RDMA */
 	MM_REG_WRITE(cmd, subsys_id, base, MDP_RDMA_EN, BIT(0), BIT(0));
 
 	/* Set Y pixel offset */
+	reg = COMP_CTX(p_id, ctx->param, rdma.subfrms[index].offset[0]);
 	MM_REG_WRITE(cmd, subsys_id, base, MDP_RDMA_SRC_OFFSET_0,
-		     subfrm->offset[0], 0xFFFFFFFF);
+		     reg, 0xFFFFFFFF);
 
 	/* Set 10bit UFO mode */
-	if (mdp_cfg)
-		if (mdp_cfg->rdma_support_10bit && block10bit && en_ufo)
+	if (mdp_cfg) {
+		if (mdp_cfg->rdma_support_10bit && block10bit && en_ufo) {
+			reg = COMP_CTX(p_id, ctx->param, rdma.subfrms[index].offset_0_p);
 			MM_REG_WRITE(cmd, subsys_id, base,
 				     MDP_RDMA_SRC_OFFSET_0_P,
-				     subfrm->offset_0_p, 0xFFFFFFFF);
+				     reg, 0xFFFFFFFF);
+		}
+	}
 
 	/* Set U pixel offset */
+	reg = COMP_CTX(p_id, ctx->param, rdma.subfrms[index].offset[1]);
 	MM_REG_WRITE(cmd, subsys_id, base, MDP_RDMA_SRC_OFFSET_1,
-		     subfrm->offset[1], 0xFFFFFFFF);
+		     reg, 0xFFFFFFFF);
 	/* Set V pixel offset */
+	reg = COMP_CTX(p_id, ctx->param, rdma.subfrms[index].offset[2]);
 	MM_REG_WRITE(cmd, subsys_id, base, MDP_RDMA_SRC_OFFSET_2,
-		     subfrm->offset[2], 0xFFFFFFFF);
+		     reg, 0xFFFFFFFF);
 	/* Set source size */
-	MM_REG_WRITE(cmd, subsys_id, base, MDP_RDMA_MF_SRC_SIZE, subfrm->src,
+	reg = COMP_CTX(p_id, ctx->param, rdma.subfrms[index].src);
+	MM_REG_WRITE(cmd, subsys_id, base, MDP_RDMA_MF_SRC_SIZE, reg,
 		     0x1FFF1FFF);
 	/* Set target size */
+	reg = COMP_CTX(p_id, ctx->param, rdma.subfrms[index].clip);
 	MM_REG_WRITE(cmd, subsys_id, base, MDP_RDMA_MF_CLIP_SIZE,
-		     subfrm->clip, 0x1FFF1FFF);
+		     reg, 0x1FFF1FFF);
 	/* Set crop offset */
+	reg = COMP_CTX(p_id, ctx->param, rdma.subfrms[index].clip_ofst);
 	MM_REG_WRITE(cmd, subsys_id, base, MDP_RDMA_MF_OFFSET_1,
-		     subfrm->clip_ofst, 0x003F001F);
+		     reg, 0x003F001F);
 
+	csf_l = COMP_CTX(p_id, ctx->param, subfrms[index].in.left);
+	csf_r = COMP_CTX(p_id, ctx->param, subfrms[index].in.right);
 	if (mdp_cfg && mdp_cfg->rdma_upsample_repeat_only)
-		if ((csf->in.right - csf->in.left + 1) > 320)
+		if ((csf_r - csf_l + 1) > 320)
 			MM_REG_WRITE(cmd, subsys_id, base,
 				     MDP_RDMA_RESV_DUMMY_0, BIT(2), BIT(2));
 
@@ -269,63 +296,78 @@ static int config_rsz_frame(struct mdp_comp_ctx *ctx,
 			    struct mdp_cmdq_cmd *cmd,
 			    const struct v4l2_rect *compose)
 {
-	const struct mdp_rsz_data *rsz = &ctx->param->rsz;
 	phys_addr_t base = ctx->comp->reg_base;
 	u8 subsys_id = ctx->comp->subsys_id;
+	u32 reg;
 
-	if (ctx->param->frame.bypass) {
+	if (COMP_CTX(p_id, ctx->param, frame.bypass)) {
 		/* Disable RSZ */
 		MM_REG_WRITE(cmd, subsys_id, base, PRZ_ENABLE, 0x0, BIT(0));
 		return 0;
 	}
 
-	MM_REG_WRITE(cmd, subsys_id, base, PRZ_CONTROL_1, rsz->control1,
+	reg = COMP_CTX(p_id, ctx->param, rsz.control1);
+	MM_REG_WRITE(cmd, subsys_id, base, PRZ_CONTROL_1, reg,
 		     0x03FFFDF3);
-	MM_REG_WRITE(cmd, subsys_id, base, PRZ_CONTROL_2, rsz->control2,
+	reg = COMP_CTX(p_id, ctx->param, rsz.control2);
+	MM_REG_WRITE(cmd, subsys_id, base, PRZ_CONTROL_2, reg,
 		     0x0FFFC290);
+	reg = COMP_CTX(p_id, ctx->param, rsz.coeff_step_x);
 	MM_REG_WRITE(cmd, subsys_id, base, PRZ_HORIZONTAL_COEFF_STEP,
-		     rsz->coeff_step_x, 0x007FFFFF);
+		     reg, 0x007FFFFF);
+	reg = COMP_CTX(p_id, ctx->param, rsz.coeff_step_y);
 	MM_REG_WRITE(cmd, subsys_id, base, PRZ_VERTICAL_COEFF_STEP,
-		     rsz->coeff_step_y, 0x007FFFFF);
+		     reg, 0x007FFFFF);
 	return 0;
 }
 
 static int config_rsz_subfrm(struct mdp_comp_ctx *ctx,
 			     struct mdp_cmdq_cmd *cmd, u32 index)
 {
-	const struct mdp_rsz_subfrm *subfrm = &ctx->param->rsz.subfrms[index];
-	const struct img_comp_subfrm *csf = &ctx->param->subfrms[index];
 	const struct mdp_platform_config *mdp_cfg = __get_plat_cfg(ctx);
 	phys_addr_t base = ctx->comp->reg_base;
 	u8 subsys_id = ctx->comp->subsys_id;
+	u32 reg;
+	u32 csf_l, csf_r;
 
-	MM_REG_WRITE(cmd, subsys_id, base, PRZ_CONTROL_2, subfrm->control2,
+	reg = COMP_CTX(p_id, ctx->param, rsz.subfrms[index].control2);
+	MM_REG_WRITE(cmd, subsys_id, base, PRZ_CONTROL_2, reg,
 		     0x00003800);
-	MM_REG_WRITE(cmd, subsys_id, base, PRZ_INPUT_IMAGE, subfrm->src,
+	reg = COMP_CTX(p_id, ctx->param, rsz.subfrms[index].src);
+	MM_REG_WRITE(cmd, subsys_id, base, PRZ_INPUT_IMAGE, reg,
 		     0xFFFFFFFF);
 
+	csf_l = COMP_CTX(p_id, ctx->param, subfrms[index].in.left);
+	csf_r = COMP_CTX(p_id, ctx->param, subfrms[index].in.right);
 	if (mdp_cfg && mdp_cfg->rsz_disable_dcm_small_sample)
-		if ((csf->in.right - csf->in.left + 1) <= 16)
+		if ((csf_r - csf_l + 1) <= 16)
 			MM_REG_WRITE(cmd, subsys_id, base, PRZ_CONTROL_1,
 				     BIT(27), BIT(27));
 
+	reg = COMP_CTX(p_id, ctx->param, subfrms[index].luma.left);
 	MM_REG_WRITE(cmd, subsys_id, base, PRZ_LUMA_HORIZONTAL_INTEGER_OFFSET,
-		     csf->luma.left, 0xFFFF);
+		     reg, 0xFFFF);
+	reg = COMP_CTX(p_id, ctx->param, subfrms[index].luma.left_subpix);
 	MM_REG_WRITE(cmd, subsys_id,
 		     base, PRZ_LUMA_HORIZONTAL_SUBPIXEL_OFFSET,
-		     csf->luma.left_subpix, 0x1FFFFF);
+		     reg, 0x1FFFFF);
+	reg = COMP_CTX(p_id, ctx->param, subfrms[index].luma.top);
 	MM_REG_WRITE(cmd, subsys_id, base, PRZ_LUMA_VERTICAL_INTEGER_OFFSET,
-		     csf->luma.top, 0xFFFF);
+		     reg, 0xFFFF);
+	reg = COMP_CTX(p_id, ctx->param, subfrms[index].luma.top_subpix);
 	MM_REG_WRITE(cmd, subsys_id, base, PRZ_LUMA_VERTICAL_SUBPIXEL_OFFSET,
-		     csf->luma.top_subpix, 0x1FFFFF);
+		     reg, 0x1FFFFF);
+	reg = COMP_CTX(p_id, ctx->param, subfrms[index].chroma.left);
 	MM_REG_WRITE(cmd, subsys_id,
 		     base, PRZ_CHROMA_HORIZONTAL_INTEGER_OFFSET,
-		     csf->chroma.left, 0xFFFF);
+		     reg, 0xFFFF);
+	reg = COMP_CTX(p_id, ctx->param, subfrms[index].chroma.left_subpix);
 	MM_REG_WRITE(cmd, subsys_id,
 		     base, PRZ_CHROMA_HORIZONTAL_SUBPIXEL_OFFSET,
-		     csf->chroma.left_subpix, 0x1FFFFF);
+		     reg, 0x1FFFFF);
 
-	MM_REG_WRITE(cmd, subsys_id, base, PRZ_OUTPUT_IMAGE, subfrm->clip,
+	reg = COMP_CTX(p_id, ctx->param, rsz.subfrms[index].clip);
+	MM_REG_WRITE(cmd, subsys_id, base, PRZ_OUTPUT_IMAGE, reg,
 		     0xFFFFFFFF);
 
 	return 0;
@@ -337,11 +379,14 @@ static int advance_rsz_subfrm(struct mdp_comp_ctx *ctx,
 	const struct mdp_platform_config *mdp_cfg = __get_plat_cfg(ctx);
 
 	if (mdp_cfg && mdp_cfg->rsz_disable_dcm_small_sample) {
-		const struct img_comp_subfrm *csf = &ctx->param->subfrms[index];
 		phys_addr_t base = ctx->comp->reg_base;
 		u8 subsys_id = ctx->comp->subsys_id;
+		u32 csf_l, csf_r;
 
-		if ((csf->in.right - csf->in.left + 1) <= 16)
+		csf_l = COMP_CTX(p_id, ctx->param, subfrms[index].in.left);
+		csf_r = COMP_CTX(p_id, ctx->param, subfrms[index].in.right);
+
+		if ((csf_r - csf_l + 1) <= 16)
 			MM_REG_WRITE(cmd, subsys_id, base, PRZ_CONTROL_1, 0x0,
 				     BIT(27));
 	}
@@ -374,31 +419,39 @@ static int config_wrot_frame(struct mdp_comp_ctx *ctx,
 			     struct mdp_cmdq_cmd *cmd,
 			     const struct v4l2_rect *compose)
 {
-	const struct mdp_wrot_data *wrot = &ctx->param->wrot;
 	const struct mdp_platform_config *mdp_cfg = __get_plat_cfg(ctx);
 	phys_addr_t base = ctx->comp->reg_base;
 	u8 subsys_id = ctx->comp->subsys_id;
+	u32 reg;
 
 	/* Write frame base address */
-	MM_REG_WRITE(cmd, subsys_id, base, VIDO_BASE_ADDR, wrot->iova[0],
+	reg = COMP_CTX(p_id, ctx->param, wrot.iova[0]);
+	MM_REG_WRITE(cmd, subsys_id, base, VIDO_BASE_ADDR, reg,
 		     0xFFFFFFFF);
-	MM_REG_WRITE(cmd, subsys_id, base, VIDO_BASE_ADDR_C, wrot->iova[1],
+	reg = COMP_CTX(p_id, ctx->param, wrot.iova[1]);
+	MM_REG_WRITE(cmd, subsys_id, base, VIDO_BASE_ADDR_C, reg,
 		     0xFFFFFFFF);
-	MM_REG_WRITE(cmd, subsys_id, base, VIDO_BASE_ADDR_V, wrot->iova[2],
+	reg = COMP_CTX(p_id, ctx->param, wrot.iova[2]);
+	MM_REG_WRITE(cmd, subsys_id, base, VIDO_BASE_ADDR_V, reg,
 		     0xFFFFFFFF);
 	/* Write frame related registers */
-	MM_REG_WRITE(cmd, subsys_id, base, VIDO_CTRL, wrot->control,
+	reg = COMP_CTX(p_id, ctx->param, wrot.control);
+	MM_REG_WRITE(cmd, subsys_id, base, VIDO_CTRL, reg,
 		     0xF131510F);
 	/* Write frame Y pitch */
-	MM_REG_WRITE(cmd, subsys_id, base, VIDO_STRIDE, wrot->stride[0],
+	reg = COMP_CTX(p_id, ctx->param, wrot.stride[0]);
+	MM_REG_WRITE(cmd, subsys_id, base, VIDO_STRIDE, reg,
 		     0x0000FFFF);
 	/* Write frame UV pitch */
-	MM_REG_WRITE(cmd, subsys_id, base, VIDO_STRIDE_C, wrot->stride[1],
+	reg = COMP_CTX(p_id, ctx->param, wrot.stride[1]);
+	MM_REG_WRITE(cmd, subsys_id, base, VIDO_STRIDE_C, reg,
 		     0xFFFF);
-	MM_REG_WRITE(cmd, subsys_id, base, VIDO_STRIDE_V, wrot->stride[2],
+	reg = COMP_CTX(p_id, ctx->param, wrot.stride[2]);
+	MM_REG_WRITE(cmd, subsys_id, base, VIDO_STRIDE_V, reg,
 		     0xFFFF);
 	/* Write matrix control */
-	MM_REG_WRITE(cmd, subsys_id, base, VIDO_MAT_CTRL, wrot->mat_ctrl, 0xF3);
+	reg = COMP_CTX(p_id, ctx->param, wrot.mat_ctrl);
+	MM_REG_WRITE(cmd, subsys_id, base, VIDO_MAT_CTRL, reg, 0xF3);
 
 	/* Set the fixed ALPHA as 0xFF */
 	MM_REG_WRITE(cmd, subsys_id, base, VIDO_DITHER, 0xFF000000,
@@ -406,13 +459,16 @@ static int config_wrot_frame(struct mdp_comp_ctx *ctx,
 	/* Set VIDO_EOL_SEL */
 	MM_REG_WRITE(cmd, subsys_id, base, VIDO_RSV_1, BIT(31), BIT(31));
 	/* Set VIDO_FIFO_TEST */
-	if (wrot->fifo_test != 0)
+	reg = COMP_CTX(p_id, ctx->param, wrot.fifo_test);
+	if (reg != 0)
 		MM_REG_WRITE(cmd, subsys_id, base, VIDO_FIFO_TEST,
-			     wrot->fifo_test, 0xFFF);
+			     reg, 0xFFF);
 	/* Filter enable */
-	if (mdp_cfg && mdp_cfg->wrot_filter_constraint)
+	if (mdp_cfg && mdp_cfg->wrot_filter_constraint) {
+		reg = COMP_CTX(p_id, ctx->param, wrot.filter);
 		MM_REG_WRITE(cmd, subsys_id, base, VIDO_MAIN_BUF_SIZE,
-			     wrot->filter, 0x77);
+			     reg, 0x77);
+	}
 
 	return 0;
 }
@@ -420,30 +476,37 @@ static int config_wrot_frame(struct mdp_comp_ctx *ctx,
 static int config_wrot_subfrm(struct mdp_comp_ctx *ctx,
 			      struct mdp_cmdq_cmd *cmd, u32 index)
 {
-	const struct mdp_wrot_subfrm *subfrm = &ctx->param->wrot.subfrms[index];
 	phys_addr_t base = ctx->comp->reg_base;
 	u8 subsys_id = ctx->comp->subsys_id;
+	u32 reg;
 
 	/* Write Y pixel offset */
+	reg = COMP_CTX(p_id, ctx->param, wrot.subfrms[index].offset[0]);
 	MM_REG_WRITE(cmd, subsys_id, base, VIDO_OFST_ADDR,
-		     subfrm->offset[0], 0x0FFFFFFF);
+		     reg, 0x0FFFFFFF);
 	/* Write U pixel offset */
+	reg = COMP_CTX(p_id, ctx->param, wrot.subfrms[index].offset[1]);
 	MM_REG_WRITE(cmd, subsys_id, base, VIDO_OFST_ADDR_C,
-		     subfrm->offset[1], 0x0FFFFFFF);
+		     reg, 0x0FFFFFFF);
 	/* Write V pixel offset */
+	reg = COMP_CTX(p_id, ctx->param, wrot.subfrms[index].offset[2]);
 	MM_REG_WRITE(cmd, subsys_id, base, VIDO_OFST_ADDR_V,
-		     subfrm->offset[2], 0x0FFFFFFF);
+		     reg, 0x0FFFFFFF);
 	/* Write source size */
-	MM_REG_WRITE(cmd, subsys_id, base, VIDO_IN_SIZE, subfrm->src,
+	reg = COMP_CTX(p_id, ctx->param, wrot.subfrms[index].src);
+	MM_REG_WRITE(cmd, subsys_id, base, VIDO_IN_SIZE, reg,
 		     0x1FFF1FFF);
 	/* Write target size */
-	MM_REG_WRITE(cmd, subsys_id, base, VIDO_TAR_SIZE, subfrm->clip,
+	reg = COMP_CTX(p_id, ctx->param, wrot.subfrms[index].clip);
+	MM_REG_WRITE(cmd, subsys_id, base, VIDO_TAR_SIZE, reg,
 		     0x1FFF1FFF);
-	MM_REG_WRITE(cmd, subsys_id, base, VIDO_CROP_OFST, subfrm->clip_ofst,
+	reg = COMP_CTX(p_id, ctx->param, wrot.subfrms[index].clip_ofst);
+	MM_REG_WRITE(cmd, subsys_id, base, VIDO_CROP_OFST, reg,
 		     0x1FFF1FFF);
 
+	reg = COMP_CTX(p_id, ctx->param, wrot.subfrms[index].main_buf);
 	MM_REG_WRITE(cmd, subsys_id, base, VIDO_MAIN_BUF_SIZE,
-		     subfrm->main_buf, 0x1FFF7F00);
+		     reg, 0x1FFF7F00);
 
 	/* Enable WROT */
 	MM_REG_WRITE(cmd, subsys_id, base, VIDO_ROT_EN, BIT(0), BIT(0));
@@ -497,29 +560,35 @@ static int config_wdma_frame(struct mdp_comp_ctx *ctx,
 			     struct mdp_cmdq_cmd *cmd,
 			     const struct v4l2_rect *compose)
 {
-	const struct mdp_wdma_data *wdma = &ctx->param->wdma;
 	phys_addr_t base = ctx->comp->reg_base;
 	u8 subsys_id = ctx->comp->subsys_id;
+	u32 reg;
 
 	MM_REG_WRITE(cmd, subsys_id, base, WDMA_BUF_CON2, 0x10101050,
 		     0xFFFFFFFF);
 
 	/* Setup frame information */
-	MM_REG_WRITE(cmd, subsys_id, base, WDMA_CFG, wdma->wdma_cfg,
+	reg = COMP_CTX(p_id, ctx->param, wdma.wdma_cfg);
+	MM_REG_WRITE(cmd, subsys_id, base, WDMA_CFG, reg,
 		     0x0F01B8F0);
 	/* Setup frame base address */
-	MM_REG_WRITE(cmd, subsys_id, base, WDMA_DST_ADDR,   wdma->iova[0],
+	reg = COMP_CTX(p_id, ctx->param, wdma.iova[0]);
+	MM_REG_WRITE(cmd, subsys_id, base, WDMA_DST_ADDR, reg,
 		     0xFFFFFFFF);
-	MM_REG_WRITE(cmd, subsys_id, base, WDMA_DST_U_ADDR, wdma->iova[1],
+	reg = COMP_CTX(p_id, ctx->param, wdma.iova[1]);
+	MM_REG_WRITE(cmd, subsys_id, base, WDMA_DST_U_ADDR, reg,
 		     0xFFFFFFFF);
-	MM_REG_WRITE(cmd, subsys_id, base, WDMA_DST_V_ADDR, wdma->iova[2],
+	reg = COMP_CTX(p_id, ctx->param, wdma.iova[2]);
+	MM_REG_WRITE(cmd, subsys_id, base, WDMA_DST_V_ADDR, reg,
 		     0xFFFFFFFF);
 	/* Setup Y pitch */
+	reg = COMP_CTX(p_id, ctx->param, wdma.w_in_byte);
 	MM_REG_WRITE(cmd, subsys_id, base, WDMA_DST_W_IN_BYTE,
-		     wdma->w_in_byte, 0x0000FFFF);
+		     reg, 0x0000FFFF);
 	/* Setup UV pitch */
+	reg = COMP_CTX(p_id, ctx->param, wdma.uv_stride);
 	MM_REG_WRITE(cmd, subsys_id, base, WDMA_DST_UV_PITCH,
-		     wdma->uv_stride, 0x0000FFFF);
+		     reg, 0x0000FFFF);
 	/* Set the fixed ALPHA as 0xFF */
 	MM_REG_WRITE(cmd, subsys_id, base, WDMA_ALPHA, 0x800000FF,
 		     0x800000FF);
@@ -530,27 +599,34 @@ static int config_wdma_frame(struct mdp_comp_ctx *ctx,
 static int config_wdma_subfrm(struct mdp_comp_ctx *ctx,
 			      struct mdp_cmdq_cmd *cmd, u32 index)
 {
-	const struct mdp_wdma_subfrm *subfrm = &ctx->param->wdma.subfrms[index];
+	//const struct mdp_wdma_subfrm *subfrm = &ctx->param->wdma.subfrms[index];
 	phys_addr_t base = ctx->comp->reg_base;
 	u8 subsys_id = ctx->comp->subsys_id;
+	u32 reg;
 
 	/* Write Y pixel offset */
+	reg = COMP_CTX(p_id, ctx->param, wdma.subfrms[index].offset[0]);
 	MM_REG_WRITE(cmd, subsys_id, base, WDMA_DST_ADDR_OFFSET,
-		     subfrm->offset[0], 0x0FFFFFFF);
+		     reg, 0x0FFFFFFF);
 	/* Write U pixel offset */
+	reg = COMP_CTX(p_id, ctx->param, wdma.subfrms[index].offset[1]);
 	MM_REG_WRITE(cmd, subsys_id, base, WDMA_DST_U_ADDR_OFFSET,
-		     subfrm->offset[1], 0x0FFFFFFF);
+		     reg, 0x0FFFFFFF);
 	/* Write V pixel offset */
+	reg = COMP_CTX(p_id, ctx->param, wdma.subfrms[index].offset[2]);
 	MM_REG_WRITE(cmd, subsys_id, base, WDMA_DST_V_ADDR_OFFSET,
-		     subfrm->offset[2], 0x0FFFFFFF);
+		     reg, 0x0FFFFFFF);
 	/* Write source size */
-	MM_REG_WRITE(cmd, subsys_id, base, WDMA_SRC_SIZE, subfrm->src,
+	reg = COMP_CTX(p_id, ctx->param, wdma.subfrms[index].src);
+	MM_REG_WRITE(cmd, subsys_id, base, WDMA_SRC_SIZE, reg,
 		     0x3FFF3FFF);
 	/* Write target size */
-	MM_REG_WRITE(cmd, subsys_id, base, WDMA_CLIP_SIZE, subfrm->clip,
+	reg = COMP_CTX(p_id, ctx->param, wdma.subfrms[index].clip);
+	MM_REG_WRITE(cmd, subsys_id, base, WDMA_CLIP_SIZE, reg,
 		     0x3FFF3FFF);
 	/* Write clip offset */
-	MM_REG_WRITE(cmd, subsys_id, base, WDMA_CLIP_COORD, subfrm->clip_ofst,
+	reg = COMP_CTX(p_id, ctx->param, wdma.subfrms[index].clip_ofst);
+	MM_REG_WRITE(cmd, subsys_id, base, WDMA_CLIP_COORD, reg,
 		     0x3FFF3FFF);
 
 	/* Enable WDMA */
@@ -593,13 +669,18 @@ static int init_ccorr(struct mdp_comp_ctx *ctx, struct mdp_cmdq_cmd *cmd)
 static int config_ccorr_subfrm(struct mdp_comp_ctx *ctx,
 			       struct mdp_cmdq_cmd *cmd, u32 index)
 {
-	const struct img_comp_subfrm *csf = &ctx->param->subfrms[index];
 	phys_addr_t base = ctx->comp->reg_base;
 	u8 subsys_id = ctx->comp->subsys_id;
+	u32 csf_l, csf_r, csf_t, csf_b;
 	u32 hsize, vsize;
 
-	hsize = csf->in.right - csf->in.left + 1;
-	vsize = csf->in.bottom - csf->in.top + 1;
+	csf_l = COMP_CTX(p_id, ctx->param, subfrms[index].in.left);
+	csf_r = COMP_CTX(p_id, ctx->param, subfrms[index].in.right);
+	csf_t = COMP_CTX(p_id, ctx->param, subfrms[index].in.top);
+	csf_b = COMP_CTX(p_id, ctx->param, subfrms[index].in.bottom);
+
+	hsize = csf_r - csf_l + 1;
+	vsize = csf_b - csf_t + 1;
 	MM_REG_WRITE(cmd, subsys_id, base, MDP_CCORR_SIZE,
 		     (hsize << 16) + (vsize <<  0), 0x1FFF1FFF);
 	return 0;
@@ -949,6 +1030,7 @@ int mdp_comp_config(struct mdp_dev *mdp)
 	int ret;
 
 	memset(mdp_comp_alias_id, 0, sizeof(mdp_comp_alias_id));
+	p_id = mdp->mdp_data->mdp_plat_id;
 
 	parent = dev->of_node->parent;
 	/* Iterate over sibling MDP function blocks */
@@ -1018,9 +1100,16 @@ int mdp_comp_ctx_config(struct mdp_dev *mdp, struct mdp_comp_ctx *ctx,
 {
 	struct device *dev = &mdp->pdev->dev;
 	enum mtk_mdp_comp_id public_id = MDP_COMP_NONE;
-	int i;
+	u32 arg;
+	int i, idx;
+
+	if (!param) {
+		dev_err(dev, "Invalid component param");
+		return -EINVAL;
+	}
 
-	public_id = get_comp_public_id(mdp, param->type);
+	arg = COMP_CTX(p_id, param, type);
+	public_id = get_comp_public_id(mdp, arg);
 	if (public_id < 0) {
 		dev_err(dev, "Invalid component id %d", public_id);
 		return -EINVAL;
@@ -1028,13 +1117,17 @@ int mdp_comp_ctx_config(struct mdp_dev *mdp, struct mdp_comp_ctx *ctx,
 
 	ctx->comp = mdp->comp[public_id];
 	if (!ctx->comp) {
-		dev_err(dev, "Uninit component inner id %d", param->type);
+		dev_err(dev, "Uninit component inner id %d", arg);
 		return -EINVAL;
 	}
 
 	ctx->param = param;
-	ctx->input = &frame->inputs[param->input];
-	for (i = 0; i < param->num_outputs; i++)
-		ctx->outputs[i] = &frame->outputs[param->outputs[i]];
+	arg = COMP_CTX(p_id, param, input);
+	ctx->input = &frame->inputs[arg];
+	idx = COMP_CTX(p_id, param, num_outputs);
+	for (i = 0; i < idx; i++) {
+		arg = COMP_CTX(p_id, param, outputs[i]);
+		ctx->outputs[i] = &frame->outputs[arg];
+	}
 	return 0;
 }
diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c
index 79acdccd0b60..7c0aa103e839 100644
--- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c
+++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c
@@ -18,6 +18,7 @@
 #include "mt8183/mdp3-plat-mt8183.h"
 
 static const struct mtk_mdp_driver_data mt8183_mdp_driver_data = {
+	.mdp_plat_id = MDP_PLAT_MT8183,
 	.mdp_probe_infra = mt8183_mdp_probe_infra,
 	.mdp_sub_comp_dt_ids = mt8183_sub_comp_dt_ids,
 	.mdp_cfg = &mt8183_plat_cfg,
diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.h b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.h
index 30f22bee89e6..d733b90c5fe3 100644
--- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.h
+++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.h
@@ -18,6 +18,10 @@
 #define MDP_DEVICE_NAME		"MediaTek MDP3"
 #define MDP_PHANDLE_NAME	"mediatek,mdp3"
 
+enum mdp_platform_id {
+	MDP_PLAT_MT8183,
+};
+
 enum mdp_infra_id {
 	MDP_INFRA_MMSYS,
 	MDP_INFRA_MUTEX,
@@ -51,6 +55,7 @@ enum mdp_pipe_id {
 };
 
 struct mtk_mdp_driver_data {
+	const enum mdp_platform_id mdp_plat_id;
 	const struct of_device_id *mdp_probe_infra;
 	const struct of_device_id *mdp_sub_comp_dt_ids;
 	const struct mdp_platform_config *mdp_cfg;
-- 
2.18.0

