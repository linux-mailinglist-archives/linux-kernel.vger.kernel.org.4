Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4079B6058DC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 09:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230430AbiJTHke (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 03:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbiJTHjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 03:39:40 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCCA61735BD;
        Thu, 20 Oct 2022 00:39:18 -0700 (PDT)
X-UUID: 36e4e4b0b5af46cd8c2aedfab8be6c83-20221020
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=TnH9pt25u45/CtFRy6dAd5E8G79hHZO6errZ2Ka1ep4=;
        b=WxLv1/VXNzqb67tXu4MPiWyZt3+KsZBVAg8JAswD5ky6tqfLqoi++/Io86PxqnAGxp9wxDin9jpj7xy38FU5X5t2gfil02FsM9xgEVCKxo5jRTv2C7ZyCSKkav7qxzweVE0+1XwUSAbuLpeU6vGSLHW2lJF4SzN6jeliDVAIbDo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.12,REQID:6a5fb91d-13bb-4bc2-b192-5bc461dfca4b,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:100
X-CID-INFO: VERSION:1.1.12,REQID:6a5fb91d-13bb-4bc2-b192-5bc461dfca4b,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTIO
        N:quarantine,TS:100
X-CID-META: VersionHash:62cd327,CLOUDID:107d66a4-ebb2-41a8-a87c-97702aaf2e20,B
        ulkID:2210201539124LFZ0VJF,BulkQuantity:0,Recheck:0,SF:38|28|17|19|48,TC:n
        il,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:1
X-UUID: 36e4e4b0b5af46cd8c2aedfab8be6c83-20221020
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <moudy.ho@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 807954240; Thu, 20 Oct 2022 15:39:10 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Thu, 20 Oct 2022 15:39:09 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Thu, 20 Oct 2022 15:39:09 +0800
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
Subject: [PATCH v2 7/9] media: platform: mtk-mdp3: decompose hardware-related information in shared memory
Date:   Thu, 20 Oct 2022 15:39:00 +0800
Message-ID: <20221020073902.21039-8-moudy.ho@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20221020073902.21039-1-moudy.ho@mediatek.com>
References: <20221020073902.21039-1-moudy.ho@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PDS_OTHER_BAD_TLD,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
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
 drivers/media/platform/mediatek/mdp3/Makefile |   1 +
 .../mediatek/mdp3/mt8183/mdp3-comp-mt8183.c   | 868 ++++++++++++++++++
 .../mediatek/mdp3/mt8183/mdp3-comp-mt8183.h   | 149 +++
 .../platform/mediatek/mdp3/mtk-img-ipi.h      | 134 +--
 .../platform/mediatek/mdp3/mtk-mdp3-cmdq.c    | 272 +-----
 .../platform/mediatek/mdp3/mtk-mdp3-cmdq.h    |  19 +-
 .../platform/mediatek/mdp3/mtk-mdp3-comp.c    | 611 +-----------
 .../platform/mediatek/mdp3/mtk-mdp3-comp.h    |  12 +-
 .../platform/mediatek/mdp3/mtk-mdp3-core.c    |   2 +
 .../platform/mediatek/mdp3/mtk-mdp3-core.h    |   5 +
 .../platform/mediatek/mdp3/mtk-mdp3-vpu.c     |  42 +-
 .../platform/mediatek/mdp3/mtk-mdp3-vpu.h     |  11 +-
 12 files changed, 1101 insertions(+), 1025 deletions(-)
 create mode 100644 drivers/media/platform/mediatek/mdp3/mt8183/mdp3-comp-mt8183.c
 create mode 100644 drivers/media/platform/mediatek/mdp3/mt8183/mdp3-comp-mt8183.h

diff --git a/drivers/media/platform/mediatek/mdp3/Makefile b/drivers/media/platform/mediatek/mdp3/Makefile
index 63e6c87e480b..b9ed1b34d16e 100644
--- a/drivers/media/platform/mediatek/mdp3/Makefile
+++ b/drivers/media/platform/mediatek/mdp3/Makefile
@@ -2,5 +2,6 @@
 mtk-mdp3-y += mtk-mdp3-core.o mtk-mdp3-vpu.o mtk-mdp3-regs.o
 mtk-mdp3-y += mtk-mdp3-m2m.o
 mtk-mdp3-y += mtk-mdp3-comp.o mtk-mdp3-cmdq.o
+mtk-mdp3-y += mt8183/mdp3-comp-mt8183.o
 
 obj-$(CONFIG_VIDEO_MEDIATEK_MDP3) += mtk-mdp3.o
diff --git a/drivers/media/platform/mediatek/mdp3/mt8183/mdp3-comp-mt8183.c b/drivers/media/platform/mediatek/mdp3/mt8183/mdp3-comp-mt8183.c
new file mode 100644
index 000000000000..a8b2db474936
--- /dev/null
+++ b/drivers/media/platform/mediatek/mdp3/mt8183/mdp3-comp-mt8183.c
@@ -0,0 +1,868 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2022 MediaTek Inc.
+ * Author: Ping-Hsun Wu <ping-hsun.wu@mediatek.com>
+ */
+
+#include "mtk-mdp3-cmdq.h"
+#include "mtk-mdp3-comp.h"
+#include "mtk-mdp3-m2m.h"
+#include "mtk-mdp3-core.h"
+
+#include "mdp_reg_rdma.h"
+#include "mdp_reg_ccorr.h"
+#include "mdp_reg_rsz.h"
+#include "mdp_reg_wrot.h"
+#include "mdp_reg_wdma.h"
+#include "mdp3-comp-mt8183.h"
+
+static inline const struct mdp_platform_config *
+__get_plat_cfg(const struct mdp_comp_ctx *ctx)
+{
+	if (!ctx)
+		return NULL;
+
+	return ctx->comp->mdp_dev->mdp_data->mdp_cfg;
+}
+
+static bool is_output_disabled(const struct img_compparam *param, u32 count)
+{
+	return (count < param->num_subfrms) ?
+		(param->frame.output_disable ||
+		param->subfrms[count].tile_disable) :
+		true;
+}
+
+static s64 get_comp_flag(const struct mdp_comp_ctx *ctx)
+{
+	const struct mdp_platform_config *mdp_cfg = __get_plat_cfg(ctx);
+	u32 rdma0, rsz1;
+
+	rdma0 = get_comp_inner_id(ctx->comp->mdp_dev, MDP_COMP_RDMA0);
+	rsz1 = get_comp_inner_id(ctx->comp->mdp_dev, MDP_COMP_RSZ1);
+	if (!rdma0 || !rsz1)
+		return MDP_COMP_NONE;
+
+	if (mdp_cfg && mdp_cfg->rdma_rsz1_sram_sharing)
+		if (ctx->comp->inner_id == rdma0)
+			return BIT(rdma0) | BIT(rsz1);
+
+	return BIT(ctx->comp->inner_id);
+}
+
+static int init_rdma(struct mdp_comp_ctx *ctx, struct mdp_cmdq_cmd *cmd)
+{
+	const struct mdp_platform_config *mdp_cfg = __get_plat_cfg(ctx);
+	phys_addr_t base = ctx->comp->reg_base;
+	u8 subsys_id = ctx->comp->subsys_id;
+	s32 rdma0;
+
+	rdma0 = get_comp_inner_id(ctx->comp->mdp_dev, MDP_COMP_RDMA0);
+	if (!rdma0)
+		return -EINVAL;
+
+	if (mdp_cfg && mdp_cfg->rdma_support_10bit) {
+		struct mdp_comp *prz1 = ctx->comp->mdp_dev->comp[MDP_COMP_RSZ1];
+
+		/* Disable RSZ1 */
+		if (ctx->comp->inner_id == rdma0 && prz1)
+			MM_REG_WRITE(cmd, subsys_id, prz1->reg_base, PRZ_ENABLE,
+				     0x0, BIT(0));
+	}
+
+	/* Reset RDMA */
+	MM_REG_WRITE(cmd, subsys_id, base, MDP_RDMA_RESET, BIT(0), BIT(0));
+	MM_REG_POLL(cmd, subsys_id, base, MDP_RDMA_MON_STA_1, BIT(8), BIT(8));
+	MM_REG_WRITE(cmd, subsys_id, base, MDP_RDMA_RESET, 0x0, BIT(0));
+	return 0;
+}
+
+static int config_rdma_frame(struct mdp_comp_ctx *ctx,
+			     struct mdp_cmdq_cmd *cmd,
+			     const struct v4l2_rect *compose)
+{
+	const struct mdp_rdma_data *rdma = &ctx->param->rdma;
+	const struct mdp_platform_config *mdp_cfg = __get_plat_cfg(ctx);
+	u32 colorformat = ctx->input->buffer.format.colorformat;
+	bool block10bit = MDP_COLOR_IS_10BIT_PACKED(colorformat);
+	bool en_ufo = MDP_COLOR_IS_UFP(colorformat);
+	phys_addr_t base = ctx->comp->reg_base;
+	u8 subsys_id = ctx->comp->subsys_id;
+
+	if (mdp_cfg && mdp_cfg->rdma_support_10bit) {
+		if (block10bit)
+			MM_REG_WRITE(cmd, subsys_id, base,
+				     MDP_RDMA_RESV_DUMMY_0, 0x7, 0x7);
+		else
+			MM_REG_WRITE(cmd, subsys_id, base,
+				     MDP_RDMA_RESV_DUMMY_0, 0x0, 0x7);
+	}
+
+	/* Setup smi control */
+	MM_REG_WRITE(cmd, subsys_id, base, MDP_RDMA_GMCIF_CON,
+		     (7 <<  4) + //burst type to 8
+		     (1 << 16),  //enable pre-ultra
+		     0x00030071);
+
+	/* Setup source frame info */
+	MM_REG_WRITE(cmd, subsys_id, base, MDP_RDMA_SRC_CON, rdma->src_ctrl,
+		     0x03C8FE0F);
+
+	if (mdp_cfg)
+		if (mdp_cfg->rdma_support_10bit && en_ufo) {
+			/* Setup source buffer base */
+			MM_REG_WRITE(cmd, subsys_id,
+				     base, MDP_RDMA_UFO_DEC_LENGTH_BASE_Y,
+				     rdma->ufo_dec_y, 0xFFFFFFFF);
+			MM_REG_WRITE(cmd, subsys_id,
+				     base, MDP_RDMA_UFO_DEC_LENGTH_BASE_C,
+				     rdma->ufo_dec_c, 0xFFFFFFFF);
+			/* Set 10bit source frame pitch */
+			if (block10bit)
+				MM_REG_WRITE(cmd, subsys_id,
+					     base, MDP_RDMA_MF_BKGD_SIZE_IN_PXL,
+					     rdma->mf_bkgd_in_pxl, 0x001FFFFF);
+		}
+
+	MM_REG_WRITE(cmd, subsys_id, base, MDP_RDMA_CON, rdma->control,
+		     0x1110);
+	/* Setup source buffer base */
+	MM_REG_WRITE(cmd, subsys_id, base, MDP_RDMA_SRC_BASE_0, rdma->iova[0],
+		     0xFFFFFFFF);
+	MM_REG_WRITE(cmd, subsys_id, base, MDP_RDMA_SRC_BASE_1, rdma->iova[1],
+		     0xFFFFFFFF);
+	MM_REG_WRITE(cmd, subsys_id, base, MDP_RDMA_SRC_BASE_2, rdma->iova[2],
+		     0xFFFFFFFF);
+	/* Setup source buffer end */
+	MM_REG_WRITE(cmd, subsys_id, base, MDP_RDMA_SRC_END_0,
+		     rdma->iova_end[0], 0xFFFFFFFF);
+	MM_REG_WRITE(cmd, subsys_id, base, MDP_RDMA_SRC_END_1,
+		     rdma->iova_end[1], 0xFFFFFFFF);
+	MM_REG_WRITE(cmd, subsys_id, base, MDP_RDMA_SRC_END_2,
+		     rdma->iova_end[2], 0xFFFFFFFF);
+	/* Setup source frame pitch */
+	MM_REG_WRITE(cmd, subsys_id, base, MDP_RDMA_MF_BKGD_SIZE_IN_BYTE,
+		     rdma->mf_bkgd, 0x001FFFFF);
+	MM_REG_WRITE(cmd, subsys_id, base, MDP_RDMA_SF_BKGD_SIZE_IN_BYTE,
+		     rdma->sf_bkgd, 0x001FFFFF);
+	/* Setup color transform */
+	MM_REG_WRITE(cmd, subsys_id, base, MDP_RDMA_TRANSFORM_0,
+		     rdma->transform, 0x0F110000);
+
+	return 0;
+}
+
+static int config_rdma_subfrm(struct mdp_comp_ctx *ctx,
+			      struct mdp_cmdq_cmd *cmd, u32 index)
+{
+	const struct mdp_rdma_subfrm *subfrm = &ctx->param->rdma.subfrms[index];
+	const struct img_comp_subfrm *csf = &ctx->param->subfrms[index];
+	const struct mdp_platform_config *mdp_cfg = __get_plat_cfg(ctx);
+	u32 colorformat = ctx->input->buffer.format.colorformat;
+	bool block10bit = MDP_COLOR_IS_10BIT_PACKED(colorformat);
+	bool en_ufo = MDP_COLOR_IS_UFP(colorformat);
+	phys_addr_t base = ctx->comp->reg_base;
+	u8 subsys_id = ctx->comp->subsys_id;
+
+	/* Enable RDMA */
+	MM_REG_WRITE(cmd, subsys_id, base, MDP_RDMA_EN, BIT(0), BIT(0));
+
+	/* Set Y pixel offset */
+	MM_REG_WRITE(cmd, subsys_id, base, MDP_RDMA_SRC_OFFSET_0,
+		     subfrm->offset[0], 0xFFFFFFFF);
+
+	/* Set 10bit UFO mode */
+	if (mdp_cfg)
+		if (mdp_cfg->rdma_support_10bit && block10bit && en_ufo)
+			MM_REG_WRITE(cmd, subsys_id, base,
+				     MDP_RDMA_SRC_OFFSET_0_P,
+				     subfrm->offset_0_p, 0xFFFFFFFF);
+
+	/* Set U pixel offset */
+	MM_REG_WRITE(cmd, subsys_id, base, MDP_RDMA_SRC_OFFSET_1,
+		     subfrm->offset[1], 0xFFFFFFFF);
+	/* Set V pixel offset */
+	MM_REG_WRITE(cmd, subsys_id, base, MDP_RDMA_SRC_OFFSET_2,
+		     subfrm->offset[2], 0xFFFFFFFF);
+	/* Set source size */
+	MM_REG_WRITE(cmd, subsys_id, base, MDP_RDMA_MF_SRC_SIZE, subfrm->src,
+		     0x1FFF1FFF);
+	/* Set target size */
+	MM_REG_WRITE(cmd, subsys_id, base, MDP_RDMA_MF_CLIP_SIZE,
+		     subfrm->clip, 0x1FFF1FFF);
+	/* Set crop offset */
+	MM_REG_WRITE(cmd, subsys_id, base, MDP_RDMA_MF_OFFSET_1,
+		     subfrm->clip_ofst, 0x003F001F);
+
+	if (mdp_cfg && mdp_cfg->rdma_upsample_repeat_only)
+		if ((csf->in.right - csf->in.left + 1) > 320)
+			MM_REG_WRITE(cmd, subsys_id, base,
+				     MDP_RDMA_RESV_DUMMY_0, BIT(2), BIT(2));
+
+	return 0;
+}
+
+static int wait_rdma_event(struct mdp_comp_ctx *ctx, struct mdp_cmdq_cmd *cmd)
+{
+	struct device *dev = &ctx->comp->mdp_dev->pdev->dev;
+	phys_addr_t base = ctx->comp->reg_base;
+	u8 subsys_id = ctx->comp->subsys_id;
+
+	if (ctx->comp->alias_id == 0)
+		MM_REG_WAIT(cmd, ctx->comp->gce_event[MDP_GCE_EVENT_EOF]);
+	else
+		dev_err(dev, "Do not support RDMA1_DONE event\n");
+
+	/* Disable RDMA */
+	MM_REG_WRITE(cmd, subsys_id, base, MDP_RDMA_EN, 0x0, BIT(0));
+	return 0;
+}
+
+static const struct mdp_comp_ops rdma_ops = {
+	.get_comp_flag = get_comp_flag,
+	.init_comp = init_rdma,
+	.config_frame = config_rdma_frame,
+	.config_subfrm = config_rdma_subfrm,
+	.wait_comp_event = wait_rdma_event,
+};
+
+static int init_rsz(struct mdp_comp_ctx *ctx, struct mdp_cmdq_cmd *cmd)
+{
+	phys_addr_t base = ctx->comp->reg_base;
+	u8 subsys_id = ctx->comp->subsys_id;
+
+	/* Reset RSZ */
+	MM_REG_WRITE(cmd, subsys_id, base, PRZ_ENABLE, 0x10000, BIT(16));
+	MM_REG_WRITE(cmd, subsys_id, base, PRZ_ENABLE, 0x0, BIT(16));
+	/* Enable RSZ */
+	MM_REG_WRITE(cmd, subsys_id, base, PRZ_ENABLE, BIT(0), BIT(0));
+	return 0;
+}
+
+static int config_rsz_frame(struct mdp_comp_ctx *ctx,
+			    struct mdp_cmdq_cmd *cmd,
+			    const struct v4l2_rect *compose)
+{
+	const struct mdp_rsz_data *rsz = &ctx->param->rsz;
+	phys_addr_t base = ctx->comp->reg_base;
+	u8 subsys_id = ctx->comp->subsys_id;
+
+	if (ctx->param->frame.bypass) {
+		/* Disable RSZ */
+		MM_REG_WRITE(cmd, subsys_id, base, PRZ_ENABLE, 0x0, BIT(0));
+		return 0;
+	}
+
+	MM_REG_WRITE(cmd, subsys_id, base, PRZ_CONTROL_1, rsz->control1,
+		     0x03FFFDF3);
+	MM_REG_WRITE(cmd, subsys_id, base, PRZ_CONTROL_2, rsz->control2,
+		     0x0FFFC290);
+	MM_REG_WRITE(cmd, subsys_id, base, PRZ_HORIZONTAL_COEFF_STEP,
+		     rsz->coeff_step_x, 0x007FFFFF);
+	MM_REG_WRITE(cmd, subsys_id, base, PRZ_VERTICAL_COEFF_STEP,
+		     rsz->coeff_step_y, 0x007FFFFF);
+	return 0;
+}
+
+static int config_rsz_subfrm(struct mdp_comp_ctx *ctx,
+			     struct mdp_cmdq_cmd *cmd, u32 index)
+{
+	const struct mdp_rsz_subfrm *subfrm = &ctx->param->rsz.subfrms[index];
+	const struct img_comp_subfrm *csf = &ctx->param->subfrms[index];
+	const struct mdp_platform_config *mdp_cfg = __get_plat_cfg(ctx);
+	phys_addr_t base = ctx->comp->reg_base;
+	u8 subsys_id = ctx->comp->subsys_id;
+
+	MM_REG_WRITE(cmd, subsys_id, base, PRZ_CONTROL_2, subfrm->control2,
+		     0x00003800);
+	MM_REG_WRITE(cmd, subsys_id, base, PRZ_INPUT_IMAGE, subfrm->src,
+		     0xFFFFFFFF);
+
+	if (mdp_cfg && mdp_cfg->rsz_disable_dcm_small_sample)
+		if ((csf->in.right - csf->in.left + 1) <= 16)
+			MM_REG_WRITE(cmd, subsys_id, base, PRZ_CONTROL_1,
+				     BIT(27), BIT(27));
+
+	MM_REG_WRITE(cmd, subsys_id, base, PRZ_LUMA_HORIZONTAL_INTEGER_OFFSET,
+		     csf->luma.left, 0xFFFF);
+	MM_REG_WRITE(cmd, subsys_id,
+		     base, PRZ_LUMA_HORIZONTAL_SUBPIXEL_OFFSET,
+		     csf->luma.left_subpix, 0x1FFFFF);
+	MM_REG_WRITE(cmd, subsys_id, base, PRZ_LUMA_VERTICAL_INTEGER_OFFSET,
+		     csf->luma.top, 0xFFFF);
+	MM_REG_WRITE(cmd, subsys_id, base, PRZ_LUMA_VERTICAL_SUBPIXEL_OFFSET,
+		     csf->luma.top_subpix, 0x1FFFFF);
+	MM_REG_WRITE(cmd, subsys_id,
+		     base, PRZ_CHROMA_HORIZONTAL_INTEGER_OFFSET,
+		     csf->chroma.left, 0xFFFF);
+	MM_REG_WRITE(cmd, subsys_id,
+		     base, PRZ_CHROMA_HORIZONTAL_SUBPIXEL_OFFSET,
+		     csf->chroma.left_subpix, 0x1FFFFF);
+
+	MM_REG_WRITE(cmd, subsys_id, base, PRZ_OUTPUT_IMAGE, subfrm->clip,
+		     0xFFFFFFFF);
+
+	return 0;
+}
+
+static int advance_rsz_subfrm(struct mdp_comp_ctx *ctx,
+			      struct mdp_cmdq_cmd *cmd, u32 index)
+{
+	const struct mdp_platform_config *mdp_cfg = __get_plat_cfg(ctx);
+
+	if (mdp_cfg && mdp_cfg->rsz_disable_dcm_small_sample) {
+		const struct img_comp_subfrm *csf = &ctx->param->subfrms[index];
+		phys_addr_t base = ctx->comp->reg_base;
+		u8 subsys_id = ctx->comp->subsys_id;
+
+		if ((csf->in.right - csf->in.left + 1) <= 16)
+			MM_REG_WRITE(cmd, subsys_id, base, PRZ_CONTROL_1, 0x0,
+				     BIT(27));
+	}
+
+	return 0;
+}
+
+static const struct mdp_comp_ops rsz_ops = {
+	.get_comp_flag = get_comp_flag,
+	.init_comp = init_rsz,
+	.config_frame = config_rsz_frame,
+	.config_subfrm = config_rsz_subfrm,
+	.advance_subfrm = advance_rsz_subfrm,
+};
+
+static int init_wrot(struct mdp_comp_ctx *ctx, struct mdp_cmdq_cmd *cmd)
+{
+	phys_addr_t base = ctx->comp->reg_base;
+	u8 subsys_id = ctx->comp->subsys_id;
+
+	/* Reset WROT */
+	MM_REG_WRITE(cmd, subsys_id, base, VIDO_SOFT_RST, BIT(0), BIT(0));
+	MM_REG_POLL(cmd, subsys_id, base, VIDO_SOFT_RST_STAT, BIT(0), BIT(0));
+	MM_REG_WRITE(cmd, subsys_id, base, VIDO_SOFT_RST, 0x0, BIT(0));
+	MM_REG_POLL(cmd, subsys_id, base, VIDO_SOFT_RST_STAT, 0x0, BIT(0));
+	return 0;
+}
+
+static int config_wrot_frame(struct mdp_comp_ctx *ctx,
+			     struct mdp_cmdq_cmd *cmd,
+			     const struct v4l2_rect *compose)
+{
+	const struct mdp_wrot_data *wrot = &ctx->param->wrot;
+	const struct mdp_platform_config *mdp_cfg = __get_plat_cfg(ctx);
+	phys_addr_t base = ctx->comp->reg_base;
+	u8 subsys_id = ctx->comp->subsys_id;
+
+	/* Write frame base address */
+	MM_REG_WRITE(cmd, subsys_id, base, VIDO_BASE_ADDR, wrot->iova[0],
+		     0xFFFFFFFF);
+	MM_REG_WRITE(cmd, subsys_id, base, VIDO_BASE_ADDR_C, wrot->iova[1],
+		     0xFFFFFFFF);
+	MM_REG_WRITE(cmd, subsys_id, base, VIDO_BASE_ADDR_V, wrot->iova[2],
+		     0xFFFFFFFF);
+	/* Write frame related registers */
+	MM_REG_WRITE(cmd, subsys_id, base, VIDO_CTRL, wrot->control,
+		     0xF131510F);
+	/* Write frame Y pitch */
+	MM_REG_WRITE(cmd, subsys_id, base, VIDO_STRIDE, wrot->stride[0],
+		     0x0000FFFF);
+	/* Write frame UV pitch */
+	MM_REG_WRITE(cmd, subsys_id, base, VIDO_STRIDE_C, wrot->stride[1],
+		     0xFFFF);
+	MM_REG_WRITE(cmd, subsys_id, base, VIDO_STRIDE_V, wrot->stride[2],
+		     0xFFFF);
+	/* Write matrix control */
+	MM_REG_WRITE(cmd, subsys_id, base, VIDO_MAT_CTRL, wrot->mat_ctrl, 0xF3);
+
+	/* Set the fixed ALPHA as 0xFF */
+	MM_REG_WRITE(cmd, subsys_id, base, VIDO_DITHER, 0xFF000000,
+		     0xFF000000);
+	/* Set VIDO_EOL_SEL */
+	MM_REG_WRITE(cmd, subsys_id, base, VIDO_RSV_1, BIT(31), BIT(31));
+	/* Set VIDO_FIFO_TEST */
+	if (wrot->fifo_test != 0)
+		MM_REG_WRITE(cmd, subsys_id, base, VIDO_FIFO_TEST,
+			     wrot->fifo_test, 0xFFF);
+	/* Filter enable */
+	if (mdp_cfg && mdp_cfg->wrot_filter_constraint)
+		MM_REG_WRITE(cmd, subsys_id, base, VIDO_MAIN_BUF_SIZE,
+			     wrot->filter, 0x77);
+
+	return 0;
+}
+
+static int config_wrot_subfrm(struct mdp_comp_ctx *ctx,
+			      struct mdp_cmdq_cmd *cmd, u32 index)
+{
+	const struct mdp_wrot_subfrm *subfrm = &ctx->param->wrot.subfrms[index];
+	phys_addr_t base = ctx->comp->reg_base;
+	u8 subsys_id = ctx->comp->subsys_id;
+
+	/* Write Y pixel offset */
+	MM_REG_WRITE(cmd, subsys_id, base, VIDO_OFST_ADDR,
+		     subfrm->offset[0], 0x0FFFFFFF);
+	/* Write U pixel offset */
+	MM_REG_WRITE(cmd, subsys_id, base, VIDO_OFST_ADDR_C,
+		     subfrm->offset[1], 0x0FFFFFFF);
+	/* Write V pixel offset */
+	MM_REG_WRITE(cmd, subsys_id, base, VIDO_OFST_ADDR_V,
+		     subfrm->offset[2], 0x0FFFFFFF);
+	/* Write source size */
+	MM_REG_WRITE(cmd, subsys_id, base, VIDO_IN_SIZE, subfrm->src,
+		     0x1FFF1FFF);
+	/* Write target size */
+	MM_REG_WRITE(cmd, subsys_id, base, VIDO_TAR_SIZE, subfrm->clip,
+		     0x1FFF1FFF);
+	MM_REG_WRITE(cmd, subsys_id, base, VIDO_CROP_OFST, subfrm->clip_ofst,
+		     0x1FFF1FFF);
+
+	MM_REG_WRITE(cmd, subsys_id, base, VIDO_MAIN_BUF_SIZE,
+		     subfrm->main_buf, 0x1FFF7F00);
+
+	/* Enable WROT */
+	MM_REG_WRITE(cmd, subsys_id, base, VIDO_ROT_EN, BIT(0), BIT(0));
+
+	return 0;
+}
+
+static int wait_wrot_event(struct mdp_comp_ctx *ctx, struct mdp_cmdq_cmd *cmd)
+{
+	const struct mdp_platform_config *mdp_cfg = __get_plat_cfg(ctx);
+	struct device *dev = &ctx->comp->mdp_dev->pdev->dev;
+	phys_addr_t base = ctx->comp->reg_base;
+	u8 subsys_id = ctx->comp->subsys_id;
+
+	if (ctx->comp->alias_id == 0)
+		MM_REG_WAIT(cmd, ctx->comp->gce_event[MDP_GCE_EVENT_EOF]);
+	else
+		dev_err(dev, "Do not support WROT1_DONE event\n");
+
+	if (mdp_cfg && mdp_cfg->wrot_filter_constraint)
+		MM_REG_WRITE(cmd, subsys_id, base, VIDO_MAIN_BUF_SIZE, 0x0,
+			     0x77);
+
+	/* Disable WROT */
+	MM_REG_WRITE(cmd, subsys_id, base, VIDO_ROT_EN, 0x0, BIT(0));
+
+	return 0;
+}
+
+static const struct mdp_comp_ops wrot_ops = {
+	.get_comp_flag = get_comp_flag,
+	.init_comp = init_wrot,
+	.config_frame = config_wrot_frame,
+	.config_subfrm = config_wrot_subfrm,
+	.wait_comp_event = wait_wrot_event,
+};
+
+static int init_wdma(struct mdp_comp_ctx *ctx, struct mdp_cmdq_cmd *cmd)
+{
+	phys_addr_t base = ctx->comp->reg_base;
+	u8 subsys_id = ctx->comp->subsys_id;
+
+	/* Reset WDMA */
+	MM_REG_WRITE(cmd, subsys_id, base, WDMA_RST, BIT(0), BIT(0));
+	MM_REG_POLL(cmd, subsys_id, base, WDMA_FLOW_CTRL_DBG, BIT(0), BIT(0));
+	MM_REG_WRITE(cmd, subsys_id, base, WDMA_RST, 0x0, BIT(0));
+	return 0;
+}
+
+static int config_wdma_frame(struct mdp_comp_ctx *ctx,
+			     struct mdp_cmdq_cmd *cmd,
+			     const struct v4l2_rect *compose)
+{
+	const struct mdp_wdma_data *wdma = &ctx->param->wdma;
+	phys_addr_t base = ctx->comp->reg_base;
+	u8 subsys_id = ctx->comp->subsys_id;
+
+	MM_REG_WRITE(cmd, subsys_id, base, WDMA_BUF_CON2, 0x10101050,
+		     0xFFFFFFFF);
+
+	/* Setup frame information */
+	MM_REG_WRITE(cmd, subsys_id, base, WDMA_CFG, wdma->wdma_cfg,
+		     0x0F01B8F0);
+	/* Setup frame base address */
+	MM_REG_WRITE(cmd, subsys_id, base, WDMA_DST_ADDR,   wdma->iova[0],
+		     0xFFFFFFFF);
+	MM_REG_WRITE(cmd, subsys_id, base, WDMA_DST_U_ADDR, wdma->iova[1],
+		     0xFFFFFFFF);
+	MM_REG_WRITE(cmd, subsys_id, base, WDMA_DST_V_ADDR, wdma->iova[2],
+		     0xFFFFFFFF);
+	/* Setup Y pitch */
+	MM_REG_WRITE(cmd, subsys_id, base, WDMA_DST_W_IN_BYTE,
+		     wdma->w_in_byte, 0x0000FFFF);
+	/* Setup UV pitch */
+	MM_REG_WRITE(cmd, subsys_id, base, WDMA_DST_UV_PITCH,
+		     wdma->uv_stride, 0x0000FFFF);
+	/* Set the fixed ALPHA as 0xFF */
+	MM_REG_WRITE(cmd, subsys_id, base, WDMA_ALPHA, 0x800000FF,
+		     0x800000FF);
+
+	return 0;
+}
+
+static int config_wdma_subfrm(struct mdp_comp_ctx *ctx,
+			      struct mdp_cmdq_cmd *cmd, u32 index)
+{
+	const struct mdp_wdma_subfrm *subfrm = &ctx->param->wdma.subfrms[index];
+	phys_addr_t base = ctx->comp->reg_base;
+	u8 subsys_id = ctx->comp->subsys_id;
+
+	/* Write Y pixel offset */
+	MM_REG_WRITE(cmd, subsys_id, base, WDMA_DST_ADDR_OFFSET,
+		     subfrm->offset[0], 0x0FFFFFFF);
+	/* Write U pixel offset */
+	MM_REG_WRITE(cmd, subsys_id, base, WDMA_DST_U_ADDR_OFFSET,
+		     subfrm->offset[1], 0x0FFFFFFF);
+	/* Write V pixel offset */
+	MM_REG_WRITE(cmd, subsys_id, base, WDMA_DST_V_ADDR_OFFSET,
+		     subfrm->offset[2], 0x0FFFFFFF);
+	/* Write source size */
+	MM_REG_WRITE(cmd, subsys_id, base, WDMA_SRC_SIZE, subfrm->src,
+		     0x3FFF3FFF);
+	/* Write target size */
+	MM_REG_WRITE(cmd, subsys_id, base, WDMA_CLIP_SIZE, subfrm->clip,
+		     0x3FFF3FFF);
+	/* Write clip offset */
+	MM_REG_WRITE(cmd, subsys_id, base, WDMA_CLIP_COORD, subfrm->clip_ofst,
+		     0x3FFF3FFF);
+
+	/* Enable WDMA */
+	MM_REG_WRITE(cmd, subsys_id, base, WDMA_EN, BIT(0), BIT(0));
+
+	return 0;
+}
+
+static int wait_wdma_event(struct mdp_comp_ctx *ctx, struct mdp_cmdq_cmd *cmd)
+{
+	phys_addr_t base = ctx->comp->reg_base;
+	u8 subsys_id = ctx->comp->subsys_id;
+
+	MM_REG_WAIT(cmd, ctx->comp->gce_event[MDP_GCE_EVENT_EOF]);
+	/* Disable WDMA */
+	MM_REG_WRITE(cmd, subsys_id, base, WDMA_EN, 0x0, BIT(0));
+	return 0;
+}
+
+static const struct mdp_comp_ops wdma_ops = {
+	.get_comp_flag = get_comp_flag,
+	.init_comp = init_wdma,
+	.config_frame = config_wdma_frame,
+	.config_subfrm = config_wdma_subfrm,
+	.wait_comp_event = wait_wdma_event,
+};
+
+static int init_ccorr(struct mdp_comp_ctx *ctx, struct mdp_cmdq_cmd *cmd)
+{
+	phys_addr_t base = ctx->comp->reg_base;
+	u8 subsys_id = ctx->comp->subsys_id;
+
+	/* CCORR enable */
+	MM_REG_WRITE(cmd, subsys_id, base, MDP_CCORR_EN, BIT(0), BIT(0));
+	/* Relay mode */
+	MM_REG_WRITE(cmd, subsys_id, base, MDP_CCORR_CFG, BIT(0), BIT(0));
+	return 0;
+}
+
+static int config_ccorr_subfrm(struct mdp_comp_ctx *ctx,
+			       struct mdp_cmdq_cmd *cmd, u32 index)
+{
+	const struct img_comp_subfrm *csf = &ctx->param->subfrms[index];
+	phys_addr_t base = ctx->comp->reg_base;
+	u8 subsys_id = ctx->comp->subsys_id;
+	u32 hsize, vsize;
+
+	hsize = csf->in.right - csf->in.left + 1;
+	vsize = csf->in.bottom - csf->in.top + 1;
+	MM_REG_WRITE(cmd, subsys_id, base, MDP_CCORR_SIZE,
+		     (hsize << 16) + (vsize <<  0), 0x1FFF1FFF);
+	return 0;
+}
+
+static const struct mdp_comp_ops ccorr_ops = {
+	.get_comp_flag = get_comp_flag,
+	.init_comp = init_ccorr,
+	.config_subfrm = config_ccorr_subfrm,
+};
+
+static const struct mdp_comp_ops *mdp_comp_ops[MDP_COMP_TYPE_COUNT] = {
+	[MDP_COMP_TYPE_RDMA] =		&rdma_ops,
+	[MDP_COMP_TYPE_RSZ] =		&rsz_ops,
+	[MDP_COMP_TYPE_WROT] =		&wrot_ops,
+	[MDP_COMP_TYPE_WDMA] =		&wdma_ops,
+	[MDP_COMP_TYPE_CCORR] =		&ccorr_ops,
+};
+
+int mdp_comp_ctx_config(struct mdp_dev *mdp, struct mdp_comp_ctx *ctx,
+			const struct img_compparam *param,
+			const struct img_ipi_frameparam *frame)
+{
+	struct device *dev = &mdp->pdev->dev;
+	enum mtk_mdp_comp_id public_id = MDP_COMP_NONE;
+	int i;
+
+	public_id = get_comp_public_id(mdp, param->type);
+	if (public_id < 0) {
+		dev_err(dev, "Invalid component id %d", public_id);
+		return -EINVAL;
+	}
+
+	ctx->comp = mdp->comp[public_id];
+	if (!ctx->comp) {
+		dev_err(dev, "Uninit component inner id %d", param->type);
+		return -EINVAL;
+	}
+
+	ctx->param = param;
+	ctx->input = &frame->inputs[param->input];
+	ctx->comp->ops = mdp_comp_ops[ctx->comp->type];
+	for (i = 0; i < param->num_outputs; i++)
+		ctx->outputs[i] = &frame->outputs[param->outputs[i]];
+	return 0;
+}
+
+static int mdp_path_ctx_init(struct mdp_dev *mdp, struct mdp_path *path)
+{
+	struct img_config *config = (struct img_config *)path->config;
+	struct mdp_comp_ctx *comps = (struct mdp_comp_ctx *)path->comps;
+	struct img_compparam *component = (struct img_compparam *)config->components;
+	int index, ret;
+
+	if (config->num_components < 1)
+		return -EINVAL;
+
+	path->num_comps = config->num_components;
+	for (index = 0; index < config->num_components; index++) {
+		ret = mdp_comp_ctx_config(mdp, &comps[index],
+					  &component[index],
+					  path->param);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int mdp_path_subfrm_require(const struct mdp_path *path,
+				   struct mdp_cmdq_cmd *cmd,
+				   s32 *mutex_id, u32 count)
+{
+	const struct img_config *config = (struct img_config *)path->config;
+	struct mdp_comp_ctx *comps = (struct mdp_comp_ctx *)path->comps;
+	const struct mdp_comp_ctx *ctx;
+	const struct mtk_mdp_driver_data *data = path->mdp_dev->mdp_data;
+	struct device *dev = &path->mdp_dev->pdev->dev;
+	struct mtk_mutex **mutex = path->mdp_dev->mdp_mutex;
+	int id, index;
+
+	/* Decide which mutex to use based on the current pipeline */
+	switch (comps[0].comp->public_id) {
+	case MDP_COMP_RDMA0:
+		index = mdp_get_pipe_idx(data, MDP_PIPE_RDMA0);
+		*mutex_id = data->pipe_info[index].mutex_id;
+		break;
+	case MDP_COMP_ISP_IMGI:
+		index = mdp_get_pipe_idx(data, MDP_PIPE_IMGI);
+		*mutex_id = data->pipe_info[index].mutex_id;
+		break;
+	case MDP_COMP_WPEI:
+		index = mdp_get_pipe_idx(data, MDP_PIPE_WPEI);
+		*mutex_id = data->pipe_info[index].mutex_id;
+		break;
+	case MDP_COMP_WPEI2:
+		index = mdp_get_pipe_idx(data, MDP_PIPE_WPEI2);
+		*mutex_id = data->pipe_info[index].mutex_id;
+		break;
+	default:
+		dev_err(dev, "Unknown pipeline and no mutex is assigned");
+		return -EINVAL;
+	}
+
+	/* Set mutex mod */
+	for (index = 0; index < config->num_components; index++) {
+		ctx = &comps[index];
+		if (is_output_disabled(ctx->param, count))
+			continue;
+		id = ctx->comp->public_id;
+		mtk_mutex_write_mod(mutex[*mutex_id],
+				    data->mdp_mutex_table_idx[id], false);
+	}
+
+	mtk_mutex_write_sof(mutex[*mutex_id],
+			    MUTEX_SOF_IDX_SINGLE_MODE);
+
+	return 0;
+}
+
+static int mdp_path_subfrm_run(const struct mdp_path *path,
+			       struct mdp_cmdq_cmd *cmd,
+			       s32 *mutex_id, u32 count)
+{
+	const struct img_config *config = (struct img_config *)path->config;
+	struct mdp_comp_ctx *comps = (struct mdp_comp_ctx *)path->comps;
+	const struct mdp_comp_ctx *ctx;
+	struct device *dev = &path->mdp_dev->pdev->dev;
+	struct mtk_mutex **mutex = path->mdp_dev->mdp_mutex;
+	int index;
+	s32 event;
+
+	if (-1 == *mutex_id) {
+		dev_err(dev, "Incorrect mutex id");
+		return -EINVAL;
+	}
+
+	/* Wait WROT SRAM shared to DISP RDMA */
+	/* Clear SOF event for each engine */
+	for (index = 0; index < config->num_components; index++) {
+		ctx = &comps[index];
+		if (is_output_disabled(ctx->param, count))
+			continue;
+		event = ctx->comp->gce_event[MDP_GCE_EVENT_SOF];
+		if (event != MDP_GCE_NO_EVENT)
+			MM_REG_CLEAR(cmd, event);
+	}
+
+	/* Enable the mutex */
+	mtk_mutex_enable_by_cmdq(mutex[*mutex_id], (void *)&cmd->pkt);
+
+	/* Wait SOF events and clear mutex modules (optional) */
+	for (index = 0; index < config->num_components; index++) {
+		ctx = &comps[index];
+		if (is_output_disabled(ctx->param, count))
+			continue;
+		event = ctx->comp->gce_event[MDP_GCE_EVENT_SOF];
+		if (event != MDP_GCE_NO_EVENT)
+			MM_REG_WAIT(cmd, event);
+	}
+
+	return 0;
+}
+
+static int mdp_path_config_subfrm(struct mdp_cmdq_cmd *cmd,
+				  struct mdp_path *path, u32 count)
+{
+	const struct img_config *config = path->config;
+	const struct img_mmsys_ctrl *ctrl = &config->ctrls[count];
+	const struct img_mux *set;
+	struct mdp_comp_ctx *comps = (struct mdp_comp_ctx *)path->comps;
+	struct mdp_comp_ctx *ctx;
+	s32 mutex_id;
+	int index, ret;
+
+	/* Acquire components */
+	ret = mdp_path_subfrm_require(path, cmd, &mutex_id, count);
+	if (ret)
+		return ret;
+	/* Enable mux settings */
+	for (index = 0; index < ctrl->num_sets; index++) {
+		set = &ctrl->sets[index];
+		cmdq_pkt_write_mask(&cmd->pkt, set->subsys_id, set->reg,
+				    set->value, 0xFFFFFFFF);
+	}
+	/* Config sub-frame information */
+	for (index = (config->num_components - 1); index >= 0; index--) {
+		ctx = &comps[index];
+		if (is_output_disabled(ctx->param, count))
+			continue;
+		ret = call_op(ctx, config_subfrm, cmd, count);
+		if (ret)
+			return ret;
+	}
+	/* Run components */
+	ret = mdp_path_subfrm_run(path, cmd, &mutex_id, count);
+	if (ret)
+		return ret;
+
+	/* Wait components done */
+	for (index = 0; index < config->num_components; index++) {
+		ctx = &comps[index];
+		if (is_output_disabled(ctx->param, count))
+			continue;
+		ret = call_op(ctx, wait_comp_event, cmd);
+		if (ret)
+			return ret;
+	}
+	/* Advance to the next sub-frame */
+	for (index = 0; index < config->num_components; index++) {
+		ctx = &comps[index];
+		ret = call_op(ctx, advance_subfrm, cmd, count);
+		if (ret)
+			return ret;
+	}
+	/* Disable mux settings */
+	for (index = 0; index < ctrl->num_sets; index++) {
+		set = &ctrl->sets[index];
+		cmdq_pkt_write_mask(&cmd->pkt, set->subsys_id, set->reg,
+				    0, 0xFFFFFFFF);
+	}
+
+	return 0;
+}
+
+static int mdp_path_config(struct mdp_dev *mdp, struct mdp_cmdq_cmd *cmd,
+			   struct mdp_path *path)
+{
+	const struct img_config *config = path->config;
+	struct mdp_comp_ctx *comps = (struct mdp_comp_ctx *)path->comps;
+	struct mdp_comp_ctx *ctx;
+	int index, count, ret;
+
+	/* Config path frame */
+	/* Reset components */
+	for (index = 0; index < config->num_components; index++) {
+		ctx = &comps[index];
+		ret = call_op(ctx, init_comp, cmd);
+		if (ret)
+			return ret;
+	}
+	/* Config frame mode */
+	for (index = 0; index < config->num_components; index++) {
+		const struct v4l2_rect *compose =
+			path->composes[ctx->param->outputs[0]];
+
+		ctx = &comps[index];
+		ret = call_op(ctx, config_frame, cmd, compose);
+		if (ret)
+			return ret;
+	}
+
+	/* Config path sub-frames */
+	for (count = 0; count < config->num_subfrms; count++) {
+		ret = mdp_path_config_subfrm(cmd, path, count);
+		if (ret)
+			return ret;
+	}
+	/* Post processing information */
+	for (index = 0; index < config->num_components; index++) {
+		ctx = &comps[index];
+		ret = call_op(ctx, post_process, cmd);
+		if (ret)
+			return ret;
+	}
+	return 0;
+}
+
+u32 mdp_config_size_mt8183(void)
+{
+	return sizeof(struct img_config);
+}
+
+int mdp_config_path_mt8183(struct mdp_dev *mdp, struct mdp_path *path, struct mdp_cmdq_cmd *cmd)
+{
+	struct device *dev = &mdp->pdev->dev;
+	int ret;
+
+	ret = mdp_path_ctx_init(mdp, path);
+	if (ret) {
+		dev_err(dev, "mdp_path_ctx_init error\n");
+		return ret;
+	}
+
+	ret = mdp_path_config(mdp, cmd, path);
+	if (ret) {
+		dev_err(dev, "mdp_path_config error\n");
+		return ret;
+	}
+
+	return ret;
+}
diff --git a/drivers/media/platform/mediatek/mdp3/mt8183/mdp3-comp-mt8183.h b/drivers/media/platform/mediatek/mdp3/mt8183/mdp3-comp-mt8183.h
new file mode 100644
index 000000000000..b4928912040f
--- /dev/null
+++ b/drivers/media/platform/mediatek/mdp3/mt8183/mdp3-comp-mt8183.h
@@ -0,0 +1,149 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2022 MediaTek Inc.
+ * Author: Holmes Chiou <holmes.chiou@mediatek.com>
+ *         Ping-Hsun Wu <ping-hsun.wu@mediatek.com>
+ */
+
+#ifndef __MDP3_COMP_MT8183_H__
+#define __MDP3_COMP_MT8183_H__
+
+#include <linux/types.h>
+#include "mtk-img-ipi.h"
+/*
+ * ISP-MDP generic input information
+ * MD5 of the target SCP blob:
+ *     6da52bdcf4bf76a0983b313e1d4745d6
+ */
+
+#define IMG_MAX_SUBFRAMES      14
+
+struct img_comp_frame {
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
+struct img_comp_subfrm {
+	u32 tile_disable:1;
+	struct img_region in;
+	struct img_region out;
+	struct img_offset luma;
+	struct img_offset chroma;
+	s16 out_vertical; /* Output vertical index */
+	s16 out_horizontal; /* Output horizontal index */
+} __packed;
+
+struct mdp_rdma_subfrm {
+	u32 offset[IMG_MAX_PLANES];
+	u32 offset_0_p;
+	u32 src;
+	u32 clip;
+	u32 clip_ofst;
+} __packed;
+
+struct mdp_rdma_data {
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
+	struct mdp_rdma_subfrm subfrms[IMG_MAX_SUBFRAMES];
+} __packed;
+
+struct mdp_rsz_subfrm {
+	u32 control2;
+	u32 src;
+	u32 clip;
+} __packed;
+
+struct mdp_rsz_data {
+	u32 coeff_step_x;
+	u32 coeff_step_y;
+	u32 control1;
+	u32 control2;
+	struct mdp_rsz_subfrm subfrms[IMG_MAX_SUBFRAMES];
+} __packed;
+
+struct mdp_wrot_subfrm {
+	u32 offset[IMG_MAX_PLANES];
+	u32 src;
+	u32 clip;
+	u32 clip_ofst;
+	u32 main_buf;
+} __packed;
+
+struct mdp_wrot_data {
+	u32 iova[IMG_MAX_PLANES];
+	u32 control;
+	u32 stride[IMG_MAX_PLANES];
+	u32 mat_ctrl;
+	u32 fifo_test;
+	u32 filter;
+	struct mdp_wrot_subfrm subfrms[IMG_MAX_SUBFRAMES];
+} __packed;
+
+struct mdp_wdma_subfrm {
+	u32 offset[IMG_MAX_PLANES];
+	u32 src;
+	u32 clip;
+	u32 clip_ofst;
+} __packed;
+
+struct mdp_wdma_data {
+	u32 wdma_cfg;
+	u32 iova[IMG_MAX_PLANES];
+	u32 w_in_byte;
+	u32 uv_stride;
+	struct mdp_wdma_subfrm subfrms[IMG_MAX_SUBFRAMES];
+} __packed;
+
+struct isp_data {
+	u64 dl_flags; /* 1 << (enum mdp_comp_type) */
+	u32 smxi_iova[4];
+	u32 cq_idx;
+	u32 cq_iova;
+	u32 tpipe_iova[IMG_MAX_SUBFRAMES];
+} __packed;
+
+struct img_compparam {
+	u16 type; /* enum mdp_comp_id */
+	u16 id; /* engine alias_id */
+	u32 input;
+	u32 outputs[IMG_MAX_HW_OUTPUTS];
+	u32 num_outputs;
+	struct img_comp_frame frame;
+	struct img_comp_subfrm subfrms[IMG_MAX_SUBFRAMES];
+	u32 num_subfrms;
+	union {
+		struct mdp_rdma_data rdma;
+		struct mdp_rsz_data rsz;
+		struct mdp_wrot_data wrot;
+		struct mdp_wdma_data wdma;
+		struct isp_data isp;
+	};
+} __packed;
+
+struct img_config {
+	struct img_compparam	components[IMG_MAX_COMPONENTS];
+	u32 num_components;
+	struct img_mmsys_ctrl ctrls[IMG_MAX_SUBFRAMES];
+	u32 num_subfrms;
+} __packed;
+
+u32 mdp_config_size_mt8183(void);
+int mdp_config_path_mt8183(struct mdp_dev *mdp, struct mdp_path *path,
+			   struct mdp_cmdq_cmd *cmd);
+
+#endif  /* __MDP3_COMP_MT8183_H__ */
diff --git a/drivers/media/platform/mediatek/mdp3/mtk-img-ipi.h b/drivers/media/platform/mediatek/mdp3/mtk-img-ipi.h
index 3e66ebaee2da..fcd6f7dd39fc 100644
--- a/drivers/media/platform/mediatek/mdp3/mtk-img-ipi.h
+++ b/drivers/media/platform/mediatek/mdp3/mtk-img-ipi.h
@@ -10,11 +10,7 @@
 
 #include <linux/types.h>
 
-/*
- * ISP-MDP generic input information
- * MD5 of the target SCP blob:
- *     6da52bdcf4bf76a0983b313e1d4745d6
- */
+/* ISP-MDP generic input information */
 
 #define IMG_MAX_HW_INPUTS	3
 
@@ -132,20 +128,6 @@ struct img_frameparam {
 	struct img_ipi_frameparam frameparam;
 };
 
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
 struct img_region {
 	s16 left;
 	s16 right;
@@ -160,113 +142,6 @@ struct img_offset {
 	u32 top_subpix;
 } __packed;
 
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
-
-struct mdp_wdma_subfrm {
-	u32 offset[IMG_MAX_PLANES];
-	u32 src;
-	u32 clip;
-	u32 clip_ofst;
-} __packed;
-
-struct mdp_wdma_data {
-	u32 wdma_cfg;
-	u32 iova[IMG_MAX_PLANES];
-	u32 w_in_byte;
-	u32 uv_stride;
-	struct mdp_wdma_subfrm subfrms[IMG_MAX_SUBFRAMES];
-} __packed;
-
-struct isp_data {
-	u64 dl_flags; /* 1 << (enum mdp_comp_type) */
-	u32 smxi_iova[4];
-	u32 cq_idx;
-	u32 cq_iova;
-	u32 tpipe_iova[IMG_MAX_SUBFRAMES];
-} __packed;
-
-struct img_compparam {
-	u16 type; /* enum mdp_comp_type */
-	u16 id; /* enum mtk_mdp_comp_id */
-	u32 input;
-	u32 outputs[IMG_MAX_HW_OUTPUTS];
-	u32 num_outputs;
-	struct img_comp_frame frame;
-	struct img_comp_subfrm subfrms[IMG_MAX_SUBFRAMES];
-	u32 num_subfrms;
-	union {
-		struct mdp_rdma_data rdma;
-		struct mdp_rsz_data rsz;
-		struct mdp_wrot_data wrot;
-		struct mdp_wdma_data wdma;
-		struct isp_data isp;
-	};
-} __packed;
-
 #define IMG_MAX_COMPONENTS	20
 
 struct img_mux {
@@ -280,11 +155,4 @@ struct img_mmsys_ctrl {
 	u32 num_sets;
 };
 
-struct img_config {
-	struct img_compparam components[IMG_MAX_COMPONENTS];
-	u32 num_components;
-	struct img_mmsys_ctrl ctrls[IMG_MAX_SUBFRAMES];
-	u32 num_subfrms;
-} __packed;
-
 #endif  /* __MTK_IMG_IPI_H__ */
diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-cmdq.c b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-cmdq.c
index 0ce291760acb..e612547450e7 100644
--- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-cmdq.c
+++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-cmdq.c
@@ -6,38 +6,15 @@
 
 #include <linux/mailbox_controller.h>
 #include <linux/platform_device.h>
+
 #include "mtk-mdp3-cmdq.h"
 #include "mtk-mdp3-comp.h"
 #include "mtk-mdp3-core.h"
 #include "mtk-mdp3-m2m.h"
+#include "mt8183/mdp3-comp-mt8183.h"
 
-#define MDP_PATH_MAX_COMPS	IMG_MAX_COMPONENTS
-
-struct mdp_path {
-	struct mdp_dev		*mdp_dev;
-	struct mdp_comp_ctx	comps[MDP_PATH_MAX_COMPS];
-	u32			num_comps;
-	const struct img_config	*config;
-	const struct img_ipi_frameparam *param;
-	const struct v4l2_rect	*composes[IMG_MAX_HW_OUTPUTS];
-	struct v4l2_rect	bounds[IMG_MAX_HW_OUTPUTS];
-};
-
-#define has_op(ctx, op) \
-	((ctx)->comp->ops && (ctx)->comp->ops->op)
- #define call_op(ctx, op, ...) \
-	(has_op(ctx, op) ? (ctx)->comp->ops->op(ctx, ##__VA_ARGS__) : 0)
-
-static bool is_output_disabled(const struct img_compparam *param, u32 count)
-{
-	return (count < param->num_subfrms) ?
-		(param->frame.output_disable ||
-		param->subfrms[count].tile_disable) :
-		true;
-}
-
-static int mdp_get_pipe_idx(const struct mtk_mdp_driver_data *data,
-			    enum mdp_pipe_id pipe_id)
+int mdp_get_pipe_idx(const struct mtk_mdp_driver_data *data,
+		     enum mdp_pipe_id pipe_id)
 {
 	int i;
 
@@ -48,219 +25,6 @@ static int mdp_get_pipe_idx(const struct mtk_mdp_driver_data *data,
 	return -ENODEV;
 }
 
-static int mdp_path_subfrm_require(const struct mdp_path *path,
-				   struct mdp_cmdq_cmd *cmd,
-				   s32 *mutex_id, u32 count)
-{
-	const struct img_config *config = path->config;
-	const struct mdp_comp_ctx *ctx;
-	const struct mtk_mdp_driver_data *data = path->mdp_dev->mdp_data;
-	struct device *dev = &path->mdp_dev->pdev->dev;
-	struct mtk_mutex **mutex = path->mdp_dev->mdp_mutex;
-	int id, index;
-
-	/* Decide which mutex to use based on the current pipeline */
-	switch (path->comps[0].comp->public_id) {
-	case MDP_COMP_RDMA0:
-		index = mdp_get_pipe_idx(data, MDP_PIPE_RDMA0);
-		*mutex_id = data->pipe_info[index].mutex_id;
-		break;
-	case MDP_COMP_ISP_IMGI:
-		index = mdp_get_pipe_idx(data, MDP_PIPE_IMGI);
-		*mutex_id = data->pipe_info[index].mutex_id;
-		break;
-	case MDP_COMP_WPEI:
-		index = mdp_get_pipe_idx(data, MDP_PIPE_WPEI);
-		*mutex_id = data->pipe_info[index].mutex_id;
-		break;
-	case MDP_COMP_WPEI2:
-		index = mdp_get_pipe_idx(data, MDP_PIPE_WPEI2);
-		*mutex_id = data->pipe_info[index].mutex_id;
-		break;
-	default:
-		dev_err(dev, "Unknown pipeline and no mutex is assigned");
-		return -EINVAL;
-	}
-
-	/* Set mutex mod */
-	for (index = 0; index < config->num_components; index++) {
-		ctx = &path->comps[index];
-		if (is_output_disabled(ctx->param, count))
-			continue;
-		id = ctx->comp->public_id;
-		mtk_mutex_write_mod(mutex[*mutex_id],
-				    data->mdp_mutex_table_idx[id], false);
-	}
-
-	mtk_mutex_write_sof(mutex[*mutex_id],
-			    MUTEX_SOF_IDX_SINGLE_MODE);
-
-	return 0;
-}
-
-static int mdp_path_subfrm_run(const struct mdp_path *path,
-			       struct mdp_cmdq_cmd *cmd,
-			       s32 *mutex_id, u32 count)
-{
-	const struct img_config *config = path->config;
-	const struct mdp_comp_ctx *ctx;
-	struct device *dev = &path->mdp_dev->pdev->dev;
-	struct mtk_mutex **mutex = path->mdp_dev->mdp_mutex;
-	int index;
-	s32 event;
-
-	if (-1 == *mutex_id) {
-		dev_err(dev, "Incorrect mutex id");
-		return -EINVAL;
-	}
-
-	/* Wait WROT SRAM shared to DISP RDMA */
-	/* Clear SOF event for each engine */
-	for (index = 0; index < config->num_components; index++) {
-		ctx = &path->comps[index];
-		if (is_output_disabled(ctx->param, count))
-			continue;
-		event = ctx->comp->gce_event[MDP_GCE_EVENT_SOF];
-		if (event != MDP_GCE_NO_EVENT)
-			MM_REG_CLEAR(cmd, event);
-	}
-
-	/* Enable the mutex */
-	mtk_mutex_enable_by_cmdq(mutex[*mutex_id], (void *)&cmd->pkt);
-
-	/* Wait SOF events and clear mutex modules (optional) */
-	for (index = 0; index < config->num_components; index++) {
-		ctx = &path->comps[index];
-		if (is_output_disabled(ctx->param, count))
-			continue;
-		event = ctx->comp->gce_event[MDP_GCE_EVENT_SOF];
-		if (event != MDP_GCE_NO_EVENT)
-			MM_REG_WAIT(cmd, event);
-	}
-
-	return 0;
-}
-
-static int mdp_path_ctx_init(struct mdp_dev *mdp, struct mdp_path *path)
-{
-	const struct img_config *config = path->config;
-	int index, ret;
-
-	if (config->num_components < 1)
-		return -EINVAL;
-
-	for (index = 0; index < config->num_components; index++) {
-		ret = mdp_comp_ctx_config(mdp, &path->comps[index],
-					  &config->components[index],
-					  path->param);
-		if (ret)
-			return ret;
-	}
-
-	return 0;
-}
-
-static int mdp_path_config_subfrm(struct mdp_cmdq_cmd *cmd,
-				  struct mdp_path *path, u32 count)
-{
-	const struct img_config *config = path->config;
-	const struct img_mmsys_ctrl *ctrl = &config->ctrls[count];
-	const struct img_mux *set;
-	struct mdp_comp_ctx *ctx;
-	s32 mutex_id;
-	int index, ret;
-
-	/* Acquire components */
-	ret = mdp_path_subfrm_require(path, cmd, &mutex_id, count);
-	if (ret)
-		return ret;
-	/* Enable mux settings */
-	for (index = 0; index < ctrl->num_sets; index++) {
-		set = &ctrl->sets[index];
-		cmdq_pkt_write_mask(&cmd->pkt, set->subsys_id, set->reg,
-				    set->value, 0xFFFFFFFF);
-	}
-	/* Config sub-frame information */
-	for (index = (config->num_components - 1); index >= 0; index--) {
-		ctx = &path->comps[index];
-		if (is_output_disabled(ctx->param, count))
-			continue;
-		ret = call_op(ctx, config_subfrm, cmd, count);
-		if (ret)
-			return ret;
-	}
-	/* Run components */
-	ret = mdp_path_subfrm_run(path, cmd, &mutex_id, count);
-	if (ret)
-		return ret;
-	/* Wait components done */
-	for (index = 0; index < config->num_components; index++) {
-		ctx = &path->comps[index];
-		if (is_output_disabled(ctx->param, count))
-			continue;
-		ret = call_op(ctx, wait_comp_event, cmd);
-		if (ret)
-			return ret;
-	}
-	/* Advance to the next sub-frame */
-	for (index = 0; index < config->num_components; index++) {
-		ctx = &path->comps[index];
-		ret = call_op(ctx, advance_subfrm, cmd, count);
-		if (ret)
-			return ret;
-	}
-	/* Disable mux settings */
-	for (index = 0; index < ctrl->num_sets; index++) {
-		set = &ctrl->sets[index];
-		cmdq_pkt_write_mask(&cmd->pkt, set->subsys_id, set->reg,
-				    0, 0xFFFFFFFF);
-	}
-
-	return 0;
-}
-
-static int mdp_path_config(struct mdp_dev *mdp, struct mdp_cmdq_cmd *cmd,
-			   struct mdp_path *path)
-{
-	const struct img_config *config = path->config;
-	struct mdp_comp_ctx *ctx;
-	int index, count, ret;
-
-	/* Config path frame */
-	/* Reset components */
-	for (index = 0; index < config->num_components; index++) {
-		ctx = &path->comps[index];
-		ret = call_op(ctx, init_comp, cmd);
-		if (ret)
-			return ret;
-	}
-	/* Config frame mode */
-	for (index = 0; index < config->num_components; index++) {
-		const struct v4l2_rect *compose =
-			path->composes[ctx->param->outputs[0]];
-
-		ctx = &path->comps[index];
-		ret = call_op(ctx, config_frame, cmd, compose);
-		if (ret)
-			return ret;
-	}
-
-	/* Config path sub-frames */
-	for (count = 0; count < config->num_subfrms; count++) {
-		ret = mdp_path_config_subfrm(cmd, path, count);
-		if (ret)
-			return ret;
-	}
-	/* Post processing information */
-	for (index = 0; index < config->num_components; index++) {
-		ctx = &path->comps[index];
-		ret = call_op(ctx, post_process, cmd);
-		if (ret)
-			return ret;
-	}
-	return 0;
-}
-
 static int mdp_cmdq_pkt_create(struct cmdq_client *client, struct cmdq_pkt *pkt,
 			       size_t size)
 {
@@ -374,7 +138,7 @@ int mdp_cmdq_send(struct mdp_dev *mdp, struct mdp_cmdq_param *param)
 {
 	struct mdp_path *path = NULL;
 	struct mdp_cmdq_cmd *cmd = NULL;
-	struct mdp_comp *comps = NULL;
+	struct mdp_comp_ctx *comps = NULL;
 	struct device *dev = &mdp->pdev->dev;
 	int i, ret;
 
@@ -394,8 +158,7 @@ int mdp_cmdq_send(struct mdp_dev *mdp, struct mdp_cmdq_param *param)
 	if (ret)
 		goto err_free_cmd;
 
-	comps = kcalloc(param->config->num_components, sizeof(*comps),
-			GFP_KERNEL);
+	comps = kcalloc(IMG_MAX_COMPONENTS, sizeof(*comps), GFP_KERNEL);
 	if (!comps) {
 		ret = -ENOMEM;
 		goto err_destroy_pkt;
@@ -417,6 +180,7 @@ int mdp_cmdq_send(struct mdp_dev *mdp, struct mdp_cmdq_param *param)
 	path->mdp_dev = mdp;
 	path->config = param->config;
 	path->param = param->param;
+	path->comps = (void *)comps;
 	for (i = 0; i < param->param->num_outputs; i++) {
 		path->bounds[i].left = 0;
 		path->bounds[i].top = 0;
@@ -428,31 +192,23 @@ int mdp_cmdq_send(struct mdp_dev *mdp, struct mdp_cmdq_param *param)
 			param->composes[i] : &path->bounds[i];
 	}
 
-	ret = mdp_path_ctx_init(mdp, path);
-	if (ret) {
-		dev_err(dev, "mdp_path_ctx_init error\n");
-		goto err_free_path;
-	}
-
-	ret = mdp_path_config(mdp, cmd, path);
-	if (ret) {
-		dev_err(dev, "mdp_path_config error\n");
+	switch (mdp->mdp_data->mdp_plat_id) {
+	case MDP_PLAT_MT8183:
+		ret = mdp_config_path_mt8183(mdp, path, cmd);
+		break;
+	default:
+		dev_err(dev, "Unsupport platform ID %d\n", mdp->mdp_data->mdp_plat_id);
 		goto err_free_path;
 	}
 	cmdq_pkt_finalize(&cmd->pkt);
 
-	for (i = 0; i < param->config->num_components; i++)
-		memcpy(&comps[i], path->comps[i].comp,
-		       sizeof(struct mdp_comp));
-
 	mdp->cmdq_clt->client.rx_callback = mdp_handle_cmdq_callback;
 	cmd->mdp = mdp;
 	cmd->user_cmdq_cb = param->cmdq_cb;
 	cmd->user_cb_data = param->cb_data;
 	cmd->comps = comps;
-	cmd->num_comps = param->config->num_components;
+	cmd->num_comps = path->num_comps;
 	cmd->mdp_ctx = param->mdp_ctx;
-
 	ret = mdp_comp_clocks_on(&mdp->pdev->dev, cmd->comps, cmd->num_comps);
 	if (ret)
 		goto err_free_path;
diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-cmdq.h b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-cmdq.h
index 43475b862ddb..29d9a33ddccb 100644
--- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-cmdq.h
+++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-cmdq.h
@@ -12,10 +12,18 @@
 #include <linux/soc/mediatek/mtk-cmdq.h>
 #include "mtk-img-ipi.h"
 
-struct platform_device *mdp_get_plat_device(struct platform_device *pdev);
+struct mdp_path {
+	struct mdp_dev		*mdp_dev;
+	const void		*config;
+	const void		*comps;
+	u32			num_comps;
+	const struct		img_ipi_frameparam *param;
+	const struct v4l2_rect	*composes[IMG_MAX_HW_OUTPUTS];
+	struct v4l2_rect	bounds[IMG_MAX_HW_OUTPUTS];
+};
 
 struct mdp_cmdq_param {
-	struct img_config *config;
+	void *config;
 	struct img_ipi_frameparam *param;
 	const struct v4l2_rect *composes[IMG_MAX_HW_OUTPUTS];
 
@@ -31,13 +39,18 @@ struct mdp_cmdq_cmd {
 	struct mdp_dev *mdp;
 	void (*user_cmdq_cb)(struct cmdq_cb_data data);
 	void *user_cb_data;
-	struct mdp_comp *comps;
+	struct mdp_comp_ctx *comps;
 	void *mdp_ctx;
 	u8 num_comps;
 };
 
 struct mdp_dev;
+struct mtk_mdp_driver_data;
+enum mdp_pipe_id;
 
+struct platform_device *mdp_get_plat_device(struct platform_device *pdev);
+int mdp_get_pipe_idx(const struct mtk_mdp_driver_data *data,
+		     enum mdp_pipe_id pipe_id);
 int mdp_cmdq_send(struct mdp_dev *mdp, struct mdp_cmdq_param *param);
 
 #endif  /* __MTK_MDP3_CMDQ_H__ */
diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c
index 8f4786cc4416..07a53503dbc6 100644
--- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c
+++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c
@@ -12,23 +12,8 @@
 #include "mtk-mdp3-core.h"
 #include "mtk-mdp3-regs.h"
 
-#include "mdp_reg_rdma.h"
-#include "mdp_reg_ccorr.h"
-#include "mdp_reg_rsz.h"
-#include "mdp_reg_wrot.h"
-#include "mdp_reg_wdma.h"
-
 static u32 mdp_comp_alias_id[MDP_COMP_TYPE_COUNT];
 
-static inline const struct mdp_platform_config *
-__get_plat_cfg(const struct mdp_comp_ctx *ctx)
-{
-	if (!ctx)
-		return NULL;
-
-	return ctx->comp->mdp_dev->mdp_data->mdp_cfg;
-}
-
 s32 get_comp_inner_id(struct mdp_dev *mdp_dev, enum mtk_mdp_comp_id id)
 {
 	if (!mdp_dev)
@@ -59,566 +44,6 @@ enum mtk_mdp_comp_id get_comp_public_id(struct mdp_dev *mdp_dev, s32 inner_id)
 	return public_id;
 }
 
-static s64 get_comp_flag(const struct mdp_comp_ctx *ctx)
-{
-	const struct mdp_platform_config *mdp_cfg = __get_plat_cfg(ctx);
-	u32 rdma0, rsz1;
-
-	rdma0 = get_comp_inner_id(ctx->comp->mdp_dev, MDP_COMP_RDMA0);
-	rsz1 = get_comp_inner_id(ctx->comp->mdp_dev, MDP_COMP_RSZ1);
-	if (!rdma0 || !rsz1)
-		return MDP_COMP_NONE;
-
-	if (mdp_cfg && mdp_cfg->rdma_rsz1_sram_sharing)
-		if (ctx->comp->inner_id == rdma0)
-			return BIT(rdma0) | BIT(rsz1);
-
-	return BIT(ctx->comp->inner_id);
-}
-
-static int init_rdma(struct mdp_comp_ctx *ctx, struct mdp_cmdq_cmd *cmd)
-{
-	const struct mdp_platform_config *mdp_cfg = __get_plat_cfg(ctx);
-	phys_addr_t base = ctx->comp->reg_base;
-	u8 subsys_id = ctx->comp->subsys_id;
-	s32 rdma0;
-
-	rdma0 = get_comp_inner_id(ctx->comp->mdp_dev, MDP_COMP_RDMA0);
-	if (!rdma0)
-		return -EINVAL;
-
-	if (mdp_cfg && mdp_cfg->rdma_support_10bit) {
-		struct mdp_comp *prz1 = ctx->comp->mdp_dev->comp[MDP_COMP_RSZ1];
-
-		/* Disable RSZ1 */
-		if (ctx->comp->inner_id == rdma0 && prz1)
-			MM_REG_WRITE(cmd, subsys_id, prz1->reg_base, PRZ_ENABLE,
-				     0x0, BIT(0));
-	}
-
-	/* Reset RDMA */
-	MM_REG_WRITE(cmd, subsys_id, base, MDP_RDMA_RESET, BIT(0), BIT(0));
-	MM_REG_POLL(cmd, subsys_id, base, MDP_RDMA_MON_STA_1, BIT(8), BIT(8));
-	MM_REG_WRITE(cmd, subsys_id, base, MDP_RDMA_RESET, 0x0, BIT(0));
-	return 0;
-}
-
-static int config_rdma_frame(struct mdp_comp_ctx *ctx,
-			     struct mdp_cmdq_cmd *cmd,
-			     const struct v4l2_rect *compose)
-{
-	const struct mdp_rdma_data *rdma = &ctx->param->rdma;
-	const struct mdp_platform_config *mdp_cfg = __get_plat_cfg(ctx);
-	u32 colorformat = ctx->input->buffer.format.colorformat;
-	bool block10bit = MDP_COLOR_IS_10BIT_PACKED(colorformat);
-	bool en_ufo = MDP_COLOR_IS_UFP(colorformat);
-	phys_addr_t base = ctx->comp->reg_base;
-	u8 subsys_id = ctx->comp->subsys_id;
-
-	if (mdp_cfg && mdp_cfg->rdma_support_10bit) {
-		if (block10bit)
-			MM_REG_WRITE(cmd, subsys_id, base,
-				     MDP_RDMA_RESV_DUMMY_0, 0x7, 0x7);
-		else
-			MM_REG_WRITE(cmd, subsys_id, base,
-				     MDP_RDMA_RESV_DUMMY_0, 0x0, 0x7);
-	}
-
-	/* Setup smi control */
-	MM_REG_WRITE(cmd, subsys_id, base, MDP_RDMA_GMCIF_CON,
-		     (7 <<  4) + //burst type to 8
-		     (1 << 16),  //enable pre-ultra
-		     0x00030071);
-
-	/* Setup source frame info */
-	MM_REG_WRITE(cmd, subsys_id, base, MDP_RDMA_SRC_CON, rdma->src_ctrl,
-		     0x03C8FE0F);
-
-	if (mdp_cfg)
-		if (mdp_cfg->rdma_support_10bit && en_ufo) {
-			/* Setup source buffer base */
-			MM_REG_WRITE(cmd, subsys_id,
-				     base, MDP_RDMA_UFO_DEC_LENGTH_BASE_Y,
-				     rdma->ufo_dec_y, 0xFFFFFFFF);
-			MM_REG_WRITE(cmd, subsys_id,
-				     base, MDP_RDMA_UFO_DEC_LENGTH_BASE_C,
-				     rdma->ufo_dec_c, 0xFFFFFFFF);
-			/* Set 10bit source frame pitch */
-			if (block10bit)
-				MM_REG_WRITE(cmd, subsys_id,
-					     base, MDP_RDMA_MF_BKGD_SIZE_IN_PXL,
-					     rdma->mf_bkgd_in_pxl, 0x001FFFFF);
-		}
-
-	MM_REG_WRITE(cmd, subsys_id, base, MDP_RDMA_CON, rdma->control,
-		     0x1110);
-	/* Setup source buffer base */
-	MM_REG_WRITE(cmd, subsys_id, base, MDP_RDMA_SRC_BASE_0, rdma->iova[0],
-		     0xFFFFFFFF);
-	MM_REG_WRITE(cmd, subsys_id, base, MDP_RDMA_SRC_BASE_1, rdma->iova[1],
-		     0xFFFFFFFF);
-	MM_REG_WRITE(cmd, subsys_id, base, MDP_RDMA_SRC_BASE_2, rdma->iova[2],
-		     0xFFFFFFFF);
-	/* Setup source buffer end */
-	MM_REG_WRITE(cmd, subsys_id, base, MDP_RDMA_SRC_END_0,
-		     rdma->iova_end[0], 0xFFFFFFFF);
-	MM_REG_WRITE(cmd, subsys_id, base, MDP_RDMA_SRC_END_1,
-		     rdma->iova_end[1], 0xFFFFFFFF);
-	MM_REG_WRITE(cmd, subsys_id, base, MDP_RDMA_SRC_END_2,
-		     rdma->iova_end[2], 0xFFFFFFFF);
-	/* Setup source frame pitch */
-	MM_REG_WRITE(cmd, subsys_id, base, MDP_RDMA_MF_BKGD_SIZE_IN_BYTE,
-		     rdma->mf_bkgd, 0x001FFFFF);
-	MM_REG_WRITE(cmd, subsys_id, base, MDP_RDMA_SF_BKGD_SIZE_IN_BYTE,
-		     rdma->sf_bkgd, 0x001FFFFF);
-	/* Setup color transform */
-	MM_REG_WRITE(cmd, subsys_id, base, MDP_RDMA_TRANSFORM_0,
-		     rdma->transform, 0x0F110000);
-
-	return 0;
-}
-
-static int config_rdma_subfrm(struct mdp_comp_ctx *ctx,
-			      struct mdp_cmdq_cmd *cmd, u32 index)
-{
-	const struct mdp_rdma_subfrm *subfrm = &ctx->param->rdma.subfrms[index];
-	const struct img_comp_subfrm *csf = &ctx->param->subfrms[index];
-	const struct mdp_platform_config *mdp_cfg = __get_plat_cfg(ctx);
-	u32 colorformat = ctx->input->buffer.format.colorformat;
-	bool block10bit = MDP_COLOR_IS_10BIT_PACKED(colorformat);
-	bool en_ufo = MDP_COLOR_IS_UFP(colorformat);
-	phys_addr_t base = ctx->comp->reg_base;
-	u8 subsys_id = ctx->comp->subsys_id;
-
-	/* Enable RDMA */
-	MM_REG_WRITE(cmd, subsys_id, base, MDP_RDMA_EN, BIT(0), BIT(0));
-
-	/* Set Y pixel offset */
-	MM_REG_WRITE(cmd, subsys_id, base, MDP_RDMA_SRC_OFFSET_0,
-		     subfrm->offset[0], 0xFFFFFFFF);
-
-	/* Set 10bit UFO mode */
-	if (mdp_cfg)
-		if (mdp_cfg->rdma_support_10bit && block10bit && en_ufo)
-			MM_REG_WRITE(cmd, subsys_id, base,
-				     MDP_RDMA_SRC_OFFSET_0_P,
-				     subfrm->offset_0_p, 0xFFFFFFFF);
-
-	/* Set U pixel offset */
-	MM_REG_WRITE(cmd, subsys_id, base, MDP_RDMA_SRC_OFFSET_1,
-		     subfrm->offset[1], 0xFFFFFFFF);
-	/* Set V pixel offset */
-	MM_REG_WRITE(cmd, subsys_id, base, MDP_RDMA_SRC_OFFSET_2,
-		     subfrm->offset[2], 0xFFFFFFFF);
-	/* Set source size */
-	MM_REG_WRITE(cmd, subsys_id, base, MDP_RDMA_MF_SRC_SIZE, subfrm->src,
-		     0x1FFF1FFF);
-	/* Set target size */
-	MM_REG_WRITE(cmd, subsys_id, base, MDP_RDMA_MF_CLIP_SIZE,
-		     subfrm->clip, 0x1FFF1FFF);
-	/* Set crop offset */
-	MM_REG_WRITE(cmd, subsys_id, base, MDP_RDMA_MF_OFFSET_1,
-		     subfrm->clip_ofst, 0x003F001F);
-
-	if (mdp_cfg && mdp_cfg->rdma_upsample_repeat_only)
-		if ((csf->in.right - csf->in.left + 1) > 320)
-			MM_REG_WRITE(cmd, subsys_id, base,
-				     MDP_RDMA_RESV_DUMMY_0, BIT(2), BIT(2));
-
-	return 0;
-}
-
-static int wait_rdma_event(struct mdp_comp_ctx *ctx, struct mdp_cmdq_cmd *cmd)
-{
-	struct device *dev = &ctx->comp->mdp_dev->pdev->dev;
-	phys_addr_t base = ctx->comp->reg_base;
-	u8 subsys_id = ctx->comp->subsys_id;
-
-	if (ctx->comp->alias_id == 0)
-		MM_REG_WAIT(cmd, ctx->comp->gce_event[MDP_GCE_EVENT_EOF]);
-	else
-		dev_err(dev, "Do not support RDMA1_DONE event\n");
-
-	/* Disable RDMA */
-	MM_REG_WRITE(cmd, subsys_id, base, MDP_RDMA_EN, 0x0, BIT(0));
-	return 0;
-}
-
-static const struct mdp_comp_ops rdma_ops = {
-	.get_comp_flag = get_comp_flag,
-	.init_comp = init_rdma,
-	.config_frame = config_rdma_frame,
-	.config_subfrm = config_rdma_subfrm,
-	.wait_comp_event = wait_rdma_event,
-};
-
-static int init_rsz(struct mdp_comp_ctx *ctx, struct mdp_cmdq_cmd *cmd)
-{
-	phys_addr_t base = ctx->comp->reg_base;
-	u8 subsys_id = ctx->comp->subsys_id;
-
-	/* Reset RSZ */
-	MM_REG_WRITE(cmd, subsys_id, base, PRZ_ENABLE, 0x10000, BIT(16));
-	MM_REG_WRITE(cmd, subsys_id, base, PRZ_ENABLE, 0x0, BIT(16));
-	/* Enable RSZ */
-	MM_REG_WRITE(cmd, subsys_id, base, PRZ_ENABLE, BIT(0), BIT(0));
-	return 0;
-}
-
-static int config_rsz_frame(struct mdp_comp_ctx *ctx,
-			    struct mdp_cmdq_cmd *cmd,
-			    const struct v4l2_rect *compose)
-{
-	const struct mdp_rsz_data *rsz = &ctx->param->rsz;
-	phys_addr_t base = ctx->comp->reg_base;
-	u8 subsys_id = ctx->comp->subsys_id;
-
-	if (ctx->param->frame.bypass) {
-		/* Disable RSZ */
-		MM_REG_WRITE(cmd, subsys_id, base, PRZ_ENABLE, 0x0, BIT(0));
-		return 0;
-	}
-
-	MM_REG_WRITE(cmd, subsys_id, base, PRZ_CONTROL_1, rsz->control1,
-		     0x03FFFDF3);
-	MM_REG_WRITE(cmd, subsys_id, base, PRZ_CONTROL_2, rsz->control2,
-		     0x0FFFC290);
-	MM_REG_WRITE(cmd, subsys_id, base, PRZ_HORIZONTAL_COEFF_STEP,
-		     rsz->coeff_step_x, 0x007FFFFF);
-	MM_REG_WRITE(cmd, subsys_id, base, PRZ_VERTICAL_COEFF_STEP,
-		     rsz->coeff_step_y, 0x007FFFFF);
-	return 0;
-}
-
-static int config_rsz_subfrm(struct mdp_comp_ctx *ctx,
-			     struct mdp_cmdq_cmd *cmd, u32 index)
-{
-	const struct mdp_rsz_subfrm *subfrm = &ctx->param->rsz.subfrms[index];
-	const struct img_comp_subfrm *csf = &ctx->param->subfrms[index];
-	const struct mdp_platform_config *mdp_cfg = __get_plat_cfg(ctx);
-	phys_addr_t base = ctx->comp->reg_base;
-	u8 subsys_id = ctx->comp->subsys_id;
-
-	MM_REG_WRITE(cmd, subsys_id, base, PRZ_CONTROL_2, subfrm->control2,
-		     0x00003800);
-	MM_REG_WRITE(cmd, subsys_id, base, PRZ_INPUT_IMAGE, subfrm->src,
-		     0xFFFFFFFF);
-
-	if (mdp_cfg && mdp_cfg->rsz_disable_dcm_small_sample)
-		if ((csf->in.right - csf->in.left + 1) <= 16)
-			MM_REG_WRITE(cmd, subsys_id, base, PRZ_CONTROL_1,
-				     BIT(27), BIT(27));
-
-	MM_REG_WRITE(cmd, subsys_id, base, PRZ_LUMA_HORIZONTAL_INTEGER_OFFSET,
-		     csf->luma.left, 0xFFFF);
-	MM_REG_WRITE(cmd, subsys_id,
-		     base, PRZ_LUMA_HORIZONTAL_SUBPIXEL_OFFSET,
-		     csf->luma.left_subpix, 0x1FFFFF);
-	MM_REG_WRITE(cmd, subsys_id, base, PRZ_LUMA_VERTICAL_INTEGER_OFFSET,
-		     csf->luma.top, 0xFFFF);
-	MM_REG_WRITE(cmd, subsys_id, base, PRZ_LUMA_VERTICAL_SUBPIXEL_OFFSET,
-		     csf->luma.top_subpix, 0x1FFFFF);
-	MM_REG_WRITE(cmd, subsys_id,
-		     base, PRZ_CHROMA_HORIZONTAL_INTEGER_OFFSET,
-		     csf->chroma.left, 0xFFFF);
-	MM_REG_WRITE(cmd, subsys_id,
-		     base, PRZ_CHROMA_HORIZONTAL_SUBPIXEL_OFFSET,
-		     csf->chroma.left_subpix, 0x1FFFFF);
-
-	MM_REG_WRITE(cmd, subsys_id, base, PRZ_OUTPUT_IMAGE, subfrm->clip,
-		     0xFFFFFFFF);
-
-	return 0;
-}
-
-static int advance_rsz_subfrm(struct mdp_comp_ctx *ctx,
-			      struct mdp_cmdq_cmd *cmd, u32 index)
-{
-	const struct mdp_platform_config *mdp_cfg = __get_plat_cfg(ctx);
-
-	if (mdp_cfg && mdp_cfg->rsz_disable_dcm_small_sample) {
-		const struct img_comp_subfrm *csf = &ctx->param->subfrms[index];
-		phys_addr_t base = ctx->comp->reg_base;
-		u8 subsys_id = ctx->comp->subsys_id;
-
-		if ((csf->in.right - csf->in.left + 1) <= 16)
-			MM_REG_WRITE(cmd, subsys_id, base, PRZ_CONTROL_1, 0x0,
-				     BIT(27));
-	}
-
-	return 0;
-}
-
-static const struct mdp_comp_ops rsz_ops = {
-	.get_comp_flag = get_comp_flag,
-	.init_comp = init_rsz,
-	.config_frame = config_rsz_frame,
-	.config_subfrm = config_rsz_subfrm,
-	.advance_subfrm = advance_rsz_subfrm,
-};
-
-static int init_wrot(struct mdp_comp_ctx *ctx, struct mdp_cmdq_cmd *cmd)
-{
-	phys_addr_t base = ctx->comp->reg_base;
-	u8 subsys_id = ctx->comp->subsys_id;
-
-	/* Reset WROT */
-	MM_REG_WRITE(cmd, subsys_id, base, VIDO_SOFT_RST, BIT(0), BIT(0));
-	MM_REG_POLL(cmd, subsys_id, base, VIDO_SOFT_RST_STAT, BIT(0), BIT(0));
-	MM_REG_WRITE(cmd, subsys_id, base, VIDO_SOFT_RST, 0x0, BIT(0));
-	MM_REG_POLL(cmd, subsys_id, base, VIDO_SOFT_RST_STAT, 0x0, BIT(0));
-	return 0;
-}
-
-static int config_wrot_frame(struct mdp_comp_ctx *ctx,
-			     struct mdp_cmdq_cmd *cmd,
-			     const struct v4l2_rect *compose)
-{
-	const struct mdp_wrot_data *wrot = &ctx->param->wrot;
-	const struct mdp_platform_config *mdp_cfg = __get_plat_cfg(ctx);
-	phys_addr_t base = ctx->comp->reg_base;
-	u8 subsys_id = ctx->comp->subsys_id;
-
-	/* Write frame base address */
-	MM_REG_WRITE(cmd, subsys_id, base, VIDO_BASE_ADDR, wrot->iova[0],
-		     0xFFFFFFFF);
-	MM_REG_WRITE(cmd, subsys_id, base, VIDO_BASE_ADDR_C, wrot->iova[1],
-		     0xFFFFFFFF);
-	MM_REG_WRITE(cmd, subsys_id, base, VIDO_BASE_ADDR_V, wrot->iova[2],
-		     0xFFFFFFFF);
-	/* Write frame related registers */
-	MM_REG_WRITE(cmd, subsys_id, base, VIDO_CTRL, wrot->control,
-		     0xF131510F);
-	/* Write frame Y pitch */
-	MM_REG_WRITE(cmd, subsys_id, base, VIDO_STRIDE, wrot->stride[0],
-		     0x0000FFFF);
-	/* Write frame UV pitch */
-	MM_REG_WRITE(cmd, subsys_id, base, VIDO_STRIDE_C, wrot->stride[1],
-		     0xFFFF);
-	MM_REG_WRITE(cmd, subsys_id, base, VIDO_STRIDE_V, wrot->stride[2],
-		     0xFFFF);
-	/* Write matrix control */
-	MM_REG_WRITE(cmd, subsys_id, base, VIDO_MAT_CTRL, wrot->mat_ctrl, 0xF3);
-
-	/* Set the fixed ALPHA as 0xFF */
-	MM_REG_WRITE(cmd, subsys_id, base, VIDO_DITHER, 0xFF000000,
-		     0xFF000000);
-	/* Set VIDO_EOL_SEL */
-	MM_REG_WRITE(cmd, subsys_id, base, VIDO_RSV_1, BIT(31), BIT(31));
-	/* Set VIDO_FIFO_TEST */
-	if (wrot->fifo_test != 0)
-		MM_REG_WRITE(cmd, subsys_id, base, VIDO_FIFO_TEST,
-			     wrot->fifo_test, 0xFFF);
-	/* Filter enable */
-	if (mdp_cfg && mdp_cfg->wrot_filter_constraint)
-		MM_REG_WRITE(cmd, subsys_id, base, VIDO_MAIN_BUF_SIZE,
-			     wrot->filter, 0x77);
-
-	return 0;
-}
-
-static int config_wrot_subfrm(struct mdp_comp_ctx *ctx,
-			      struct mdp_cmdq_cmd *cmd, u32 index)
-{
-	const struct mdp_wrot_subfrm *subfrm = &ctx->param->wrot.subfrms[index];
-	phys_addr_t base = ctx->comp->reg_base;
-	u8 subsys_id = ctx->comp->subsys_id;
-
-	/* Write Y pixel offset */
-	MM_REG_WRITE(cmd, subsys_id, base, VIDO_OFST_ADDR,
-		     subfrm->offset[0], 0x0FFFFFFF);
-	/* Write U pixel offset */
-	MM_REG_WRITE(cmd, subsys_id, base, VIDO_OFST_ADDR_C,
-		     subfrm->offset[1], 0x0FFFFFFF);
-	/* Write V pixel offset */
-	MM_REG_WRITE(cmd, subsys_id, base, VIDO_OFST_ADDR_V,
-		     subfrm->offset[2], 0x0FFFFFFF);
-	/* Write source size */
-	MM_REG_WRITE(cmd, subsys_id, base, VIDO_IN_SIZE, subfrm->src,
-		     0x1FFF1FFF);
-	/* Write target size */
-	MM_REG_WRITE(cmd, subsys_id, base, VIDO_TAR_SIZE, subfrm->clip,
-		     0x1FFF1FFF);
-	MM_REG_WRITE(cmd, subsys_id, base, VIDO_CROP_OFST, subfrm->clip_ofst,
-		     0x1FFF1FFF);
-
-	MM_REG_WRITE(cmd, subsys_id, base, VIDO_MAIN_BUF_SIZE,
-		     subfrm->main_buf, 0x1FFF7F00);
-
-	/* Enable WROT */
-	MM_REG_WRITE(cmd, subsys_id, base, VIDO_ROT_EN, BIT(0), BIT(0));
-
-	return 0;
-}
-
-static int wait_wrot_event(struct mdp_comp_ctx *ctx, struct mdp_cmdq_cmd *cmd)
-{
-	const struct mdp_platform_config *mdp_cfg = __get_plat_cfg(ctx);
-	struct device *dev = &ctx->comp->mdp_dev->pdev->dev;
-	phys_addr_t base = ctx->comp->reg_base;
-	u8 subsys_id = ctx->comp->subsys_id;
-
-	if (ctx->comp->alias_id == 0)
-		MM_REG_WAIT(cmd, ctx->comp->gce_event[MDP_GCE_EVENT_EOF]);
-	else
-		dev_err(dev, "Do not support WROT1_DONE event\n");
-
-	if (mdp_cfg && mdp_cfg->wrot_filter_constraint)
-		MM_REG_WRITE(cmd, subsys_id, base, VIDO_MAIN_BUF_SIZE, 0x0,
-			     0x77);
-
-	/* Disable WROT */
-	MM_REG_WRITE(cmd, subsys_id, base, VIDO_ROT_EN, 0x0, BIT(0));
-
-	return 0;
-}
-
-static const struct mdp_comp_ops wrot_ops = {
-	.get_comp_flag = get_comp_flag,
-	.init_comp = init_wrot,
-	.config_frame = config_wrot_frame,
-	.config_subfrm = config_wrot_subfrm,
-	.wait_comp_event = wait_wrot_event,
-};
-
-static int init_wdma(struct mdp_comp_ctx *ctx, struct mdp_cmdq_cmd *cmd)
-{
-	phys_addr_t base = ctx->comp->reg_base;
-	u8 subsys_id = ctx->comp->subsys_id;
-
-	/* Reset WDMA */
-	MM_REG_WRITE(cmd, subsys_id, base, WDMA_RST, BIT(0), BIT(0));
-	MM_REG_POLL(cmd, subsys_id, base, WDMA_FLOW_CTRL_DBG, BIT(0), BIT(0));
-	MM_REG_WRITE(cmd, subsys_id, base, WDMA_RST, 0x0, BIT(0));
-	return 0;
-}
-
-static int config_wdma_frame(struct mdp_comp_ctx *ctx,
-			     struct mdp_cmdq_cmd *cmd,
-			     const struct v4l2_rect *compose)
-{
-	const struct mdp_wdma_data *wdma = &ctx->param->wdma;
-	phys_addr_t base = ctx->comp->reg_base;
-	u8 subsys_id = ctx->comp->subsys_id;
-
-	MM_REG_WRITE(cmd, subsys_id, base, WDMA_BUF_CON2, 0x10101050,
-		     0xFFFFFFFF);
-
-	/* Setup frame information */
-	MM_REG_WRITE(cmd, subsys_id, base, WDMA_CFG, wdma->wdma_cfg,
-		     0x0F01B8F0);
-	/* Setup frame base address */
-	MM_REG_WRITE(cmd, subsys_id, base, WDMA_DST_ADDR,   wdma->iova[0],
-		     0xFFFFFFFF);
-	MM_REG_WRITE(cmd, subsys_id, base, WDMA_DST_U_ADDR, wdma->iova[1],
-		     0xFFFFFFFF);
-	MM_REG_WRITE(cmd, subsys_id, base, WDMA_DST_V_ADDR, wdma->iova[2],
-		     0xFFFFFFFF);
-	/* Setup Y pitch */
-	MM_REG_WRITE(cmd, subsys_id, base, WDMA_DST_W_IN_BYTE,
-		     wdma->w_in_byte, 0x0000FFFF);
-	/* Setup UV pitch */
-	MM_REG_WRITE(cmd, subsys_id, base, WDMA_DST_UV_PITCH,
-		     wdma->uv_stride, 0x0000FFFF);
-	/* Set the fixed ALPHA as 0xFF */
-	MM_REG_WRITE(cmd, subsys_id, base, WDMA_ALPHA, 0x800000FF,
-		     0x800000FF);
-
-	return 0;
-}
-
-static int config_wdma_subfrm(struct mdp_comp_ctx *ctx,
-			      struct mdp_cmdq_cmd *cmd, u32 index)
-{
-	const struct mdp_wdma_subfrm *subfrm = &ctx->param->wdma.subfrms[index];
-	phys_addr_t base = ctx->comp->reg_base;
-	u8 subsys_id = ctx->comp->subsys_id;
-
-	/* Write Y pixel offset */
-	MM_REG_WRITE(cmd, subsys_id, base, WDMA_DST_ADDR_OFFSET,
-		     subfrm->offset[0], 0x0FFFFFFF);
-	/* Write U pixel offset */
-	MM_REG_WRITE(cmd, subsys_id, base, WDMA_DST_U_ADDR_OFFSET,
-		     subfrm->offset[1], 0x0FFFFFFF);
-	/* Write V pixel offset */
-	MM_REG_WRITE(cmd, subsys_id, base, WDMA_DST_V_ADDR_OFFSET,
-		     subfrm->offset[2], 0x0FFFFFFF);
-	/* Write source size */
-	MM_REG_WRITE(cmd, subsys_id, base, WDMA_SRC_SIZE, subfrm->src,
-		     0x3FFF3FFF);
-	/* Write target size */
-	MM_REG_WRITE(cmd, subsys_id, base, WDMA_CLIP_SIZE, subfrm->clip,
-		     0x3FFF3FFF);
-	/* Write clip offset */
-	MM_REG_WRITE(cmd, subsys_id, base, WDMA_CLIP_COORD, subfrm->clip_ofst,
-		     0x3FFF3FFF);
-
-	/* Enable WDMA */
-	MM_REG_WRITE(cmd, subsys_id, base, WDMA_EN, BIT(0), BIT(0));
-
-	return 0;
-}
-
-static int wait_wdma_event(struct mdp_comp_ctx *ctx, struct mdp_cmdq_cmd *cmd)
-{
-	phys_addr_t base = ctx->comp->reg_base;
-	u8 subsys_id = ctx->comp->subsys_id;
-
-	MM_REG_WAIT(cmd, ctx->comp->gce_event[MDP_GCE_EVENT_EOF]);
-	/* Disable WDMA */
-	MM_REG_WRITE(cmd, subsys_id, base, WDMA_EN, 0x0, BIT(0));
-	return 0;
-}
-
-static const struct mdp_comp_ops wdma_ops = {
-	.get_comp_flag = get_comp_flag,
-	.init_comp = init_wdma,
-	.config_frame = config_wdma_frame,
-	.config_subfrm = config_wdma_subfrm,
-	.wait_comp_event = wait_wdma_event,
-};
-
-static int init_ccorr(struct mdp_comp_ctx *ctx, struct mdp_cmdq_cmd *cmd)
-{
-	phys_addr_t base = ctx->comp->reg_base;
-	u8 subsys_id = ctx->comp->subsys_id;
-
-	/* CCORR enable */
-	MM_REG_WRITE(cmd, subsys_id, base, MDP_CCORR_EN, BIT(0), BIT(0));
-	/* Relay mode */
-	MM_REG_WRITE(cmd, subsys_id, base, MDP_CCORR_CFG, BIT(0), BIT(0));
-	return 0;
-}
-
-static int config_ccorr_subfrm(struct mdp_comp_ctx *ctx,
-			       struct mdp_cmdq_cmd *cmd, u32 index)
-{
-	const struct img_comp_subfrm *csf = &ctx->param->subfrms[index];
-	phys_addr_t base = ctx->comp->reg_base;
-	u8 subsys_id = ctx->comp->subsys_id;
-	u32 hsize, vsize;
-
-	hsize = csf->in.right - csf->in.left + 1;
-	vsize = csf->in.bottom - csf->in.top + 1;
-	MM_REG_WRITE(cmd, subsys_id, base, MDP_CCORR_SIZE,
-		     (hsize << 16) + (vsize <<  0), 0x1FFF1FFF);
-	return 0;
-}
-
-static const struct mdp_comp_ops ccorr_ops = {
-	.get_comp_flag = get_comp_flag,
-	.init_comp = init_ccorr,
-	.config_subfrm = config_ccorr_subfrm,
-};
-
-static const struct mdp_comp_ops *mdp_comp_ops[MDP_COMP_TYPE_COUNT] = {
-	[MDP_COMP_TYPE_RDMA] =		&rdma_ops,
-	[MDP_COMP_TYPE_RSZ] =		&rsz_ops,
-	[MDP_COMP_TYPE_WROT] =		&wrot_ops,
-	[MDP_COMP_TYPE_WDMA] =		&wdma_ops,
-	[MDP_COMP_TYPE_CCORR] =		&ccorr_ops,
-};
-
 static const struct of_device_id mdp_comp_dt_ids[] = {
 	{
 		.compatible = "mediatek,mt8183-mdp3-rdma",
@@ -720,12 +145,12 @@ void mdp_comp_clock_off(struct device *dev, struct mdp_comp *comp)
 		pm_runtime_put(comp->comp_dev);
 }
 
-int mdp_comp_clocks_on(struct device *dev, struct mdp_comp *comps, int num)
+int mdp_comp_clocks_on(struct device *dev, struct mdp_comp_ctx *comps, int num)
 {
 	int i, ret;
 
 	for (i = 0; i < num; i++) {
-		ret = mdp_comp_clock_on(dev, &comps[i]);
+		ret = mdp_comp_clock_on(dev, comps[i].comp);
 		if (ret)
 			return ret;
 	}
@@ -733,12 +158,12 @@ int mdp_comp_clocks_on(struct device *dev, struct mdp_comp *comps, int num)
 	return 0;
 }
 
-void mdp_comp_clocks_off(struct device *dev, struct mdp_comp *comps, int num)
+void mdp_comp_clocks_off(struct device *dev, struct mdp_comp_ctx *comps, int num)
 {
 	int i;
 
 	for (i = 0; i < num; i++)
-		mdp_comp_clock_off(dev, &comps[i]);
+		mdp_comp_clock_off(dev, comps[i].comp);
 }
 
 static int mdp_get_subsys_id(struct mdp_dev *mdp, struct device *dev,
@@ -809,7 +234,6 @@ static int mdp_comp_init(struct mdp_dev *mdp, struct device_node *node,
 	comp->type = mdp->mdp_data->comp_data[id].match.type;
 	comp->inner_id = mdp->mdp_data->comp_data[id].match.inner_id;
 	comp->alias_id = mdp->mdp_data->comp_data[id].match.alias_id;
-	comp->ops = mdp_comp_ops[comp->type];
 	__mdp_comp_init(mdp, node, comp);
 
 	clk_num = mdp->mdp_data->comp_data[id].info.clk_num;
@@ -1011,30 +435,3 @@ int mdp_comp_config(struct mdp_dev *mdp)
 	mdp_comp_destroy(mdp);
 	return ret;
 }
-
-int mdp_comp_ctx_config(struct mdp_dev *mdp, struct mdp_comp_ctx *ctx,
-			const struct img_compparam *param,
-			const struct img_ipi_frameparam *frame)
-{
-	struct device *dev = &mdp->pdev->dev;
-	enum mtk_mdp_comp_id public_id = MDP_COMP_NONE;
-	int i;
-
-	public_id = get_comp_public_id(mdp, param->type);
-	if (public_id < 0) {
-		dev_err(dev, "Invalid component id %d", public_id);
-		return -EINVAL;
-	}
-
-	ctx->comp = mdp->comp[public_id];
-	if (!ctx->comp) {
-		dev_err(dev, "Uninit component inner id %d", param->type);
-		return -EINVAL;
-	}
-
-	ctx->param = param;
-	ctx->input = &frame->inputs[param->input];
-	for (i = 0; i < param->num_outputs; i++)
-		ctx->outputs[i] = &frame->outputs[param->outputs[i]];
-	return 0;
-}
diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.h b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.h
index 5188aa0821c4..6438b69ffc97 100644
--- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.h
+++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.h
@@ -64,6 +64,11 @@ do {								\
 			(0xffffffff) : (m), ##__VA_ARGS__);	\
 } while (0)
 
+#define has_op(ctx, op) \
+	((ctx)->comp->ops && (ctx)->comp->ops->op)
+#define call_op(ctx, op, ...) \
+	(has_op(ctx, op) ? (ctx)->comp->ops->op(ctx, ##__VA_ARGS__) : 0)
+
 enum mtk_mdp_comp_id {
 	MDP_COMP_NONE = -1,	/* Invalid engine */
 
@@ -199,10 +204,7 @@ int mdp_comp_config(struct mdp_dev *mdp);
 void mdp_comp_destroy(struct mdp_dev *mdp);
 int mdp_comp_clock_on(struct device *dev, struct mdp_comp *comp);
 void mdp_comp_clock_off(struct device *dev, struct mdp_comp *comp);
-int mdp_comp_clocks_on(struct device *dev, struct mdp_comp *comps, int num);
-void mdp_comp_clocks_off(struct device *dev, struct mdp_comp *comps, int num);
-int mdp_comp_ctx_config(struct mdp_dev *mdp, struct mdp_comp_ctx *ctx,
-			const struct img_compparam *param,
-			const struct img_ipi_frameparam *frame);
+int mdp_comp_clocks_on(struct device *dev, struct mdp_comp_ctx *comps, int num);
+void mdp_comp_clocks_off(struct device *dev, struct mdp_comp_ctx *comps, int num);
 
 #endif  /* __MTK_MDP3_COMP_H__ */
diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c
index 79acdccd0b60..8b4979ac4da6 100644
--- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c
+++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c
@@ -15,9 +15,11 @@
 
 #include "mtk-mdp3-core.h"
 #include "mtk-mdp3-m2m.h"
+#include "mt8183/mdp3-comp-mt8183.h"
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
diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-vpu.c b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-vpu.c
index a72bed927bb6..f8905d09fbcc 100644
--- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-vpu.c
+++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-vpu.c
@@ -6,8 +6,10 @@
 
 #include <linux/remoteproc.h>
 #include <linux/remoteproc/mtk_scp.h>
+
 #include "mtk-mdp3-vpu.h"
 #include "mtk-mdp3-core.h"
+#include "mt8183/mdp3-comp-mt8183.h"
 
 #define MDP_VPU_MESSAGE_TIMEOUT 500U
 #define vpu_alloc_size		0x600000
@@ -159,7 +161,7 @@ int mdp_vpu_dev_init(struct mdp_vpu_dev *vpu, struct mtk_scp *scp,
 	};
 	size_t mem_size;
 	phys_addr_t pool;
-	const size_t pool_size = sizeof(struct mdp_config_pool);
+	size_t pool_size;
 	struct mdp_dev *mdp = vpu_to_mdp(vpu);
 	int err;
 
@@ -172,6 +174,19 @@ int mdp_vpu_dev_init(struct mdp_vpu_dev *vpu, struct mtk_scp *scp,
 		goto err_work_size;
 	/* vpu work_size was set in mdp_vpu_ipi_handle_init_ack */
 
+	switch (mdp->mdp_data->mdp_plat_id) {
+	case MDP_PLAT_MT8183:
+		vpu->cfg_size = mdp_config_size_mt8183();
+		break;
+	default:
+		break;
+	}
+	if (!vpu->cfg_size) {
+		err = -EINVAL;
+		goto err_work_size;
+	}
+	pool_size = vpu->cfg_size * MDP_CONFIG_POOL_SIZE;
+
 	mem_size = vpu_alloc_size;
 	err = mdp_vpu_shared_mem_alloc(vpu);
 	if (err) {
@@ -192,14 +207,15 @@ int mdp_vpu_dev_init(struct mdp_vpu_dev *vpu, struct mtk_scp *scp,
 		"VPU work:%pK pa:%pad sz:%zx pool:%pa sz:%zx (mem sz:%zx)",
 		vpu->work, &vpu->work_addr, vpu->work_size,
 		&pool, pool_size, mem_size);
-	vpu->pool = (struct mdp_config_pool *)(uintptr_t)pool;
+	vpu->pool = pool;
+
 	msg.work_addr = vpu->work_addr;
 	msg.work_size = vpu->work_size;
 	err = mdp_vpu_sendmsg(vpu, SCP_IPI_MDP_INIT, &msg, sizeof(msg));
 	if (err)
 		goto err_work_size;
 
-	memset(vpu->pool, 0, sizeof(*vpu->pool));
+	memset((void *)(uintptr_t)vpu->pool, 0, pool_size);
 	return 0;
 
 err_work_size:
@@ -227,17 +243,17 @@ int mdp_vpu_dev_deinit(struct mdp_vpu_dev *vpu)
 	return mdp_vpu_sendmsg(vpu, SCP_IPI_MDP_DEINIT, &msg, sizeof(msg));
 }
 
-static struct img_config *mdp_config_get(struct mdp_vpu_dev *vpu,
-					 enum mdp_config_id id, uint32_t *addr)
+static void *mdp_config_get(struct mdp_vpu_dev *vpu,
+			    enum mdp_config_id id, uint32_t *addr)
 {
-	struct img_config *config;
+	void *config;
 
 	if (id < 0 || id >= MDP_CONFIG_POOL_SIZE)
 		return ERR_PTR(-EINVAL);
 
 	mutex_lock(vpu->lock);
-	vpu->pool->cfg_count[id]++;
-	config = &vpu->pool->configs[id];
+	vpu->cfg_count[id]++;
+	config = (void *)(uintptr_t)(vpu->pool + vpu->cfg_size * id);
 	*addr = vpu->work_addr + ((uintptr_t)config - (uintptr_t)vpu->work);
 	mutex_unlock(vpu->lock);
 
@@ -246,18 +262,20 @@ static struct img_config *mdp_config_get(struct mdp_vpu_dev *vpu,
 
 static int mdp_config_put(struct mdp_vpu_dev *vpu,
 			  enum mdp_config_id id,
-			  const struct img_config *config)
+			  const void *config)
 {
 	int err = 0;
+	void *pool_addr;
 
 	if (id < 0 || id >= MDP_CONFIG_POOL_SIZE)
 		return -EINVAL;
 	if (vpu->lock)
 		mutex_lock(vpu->lock);
-	if (!vpu->pool->cfg_count[id] || config != &vpu->pool->configs[id])
+	pool_addr = (void *)(uintptr_t)(vpu->pool + vpu->cfg_size * id);
+	if (!vpu->cfg_count[id] || config != pool_addr)
 		err = -EINVAL;
 	else
-		vpu->pool->cfg_count[id]--;
+		vpu->cfg_count[id]--;
 	if (vpu->lock)
 		mutex_unlock(vpu->lock);
 	return err;
@@ -301,7 +319,7 @@ int mdp_vpu_process(struct mdp_vpu_ctx *ctx, struct img_ipi_frameparam *param)
 		}
 	}
 	memset((void *)ctx->vpu_dev->work, 0, ctx->vpu_dev->work_size);
-	memset(ctx->config, 0, sizeof(*ctx->config));
+	memset(ctx->config, 0, vpu->cfg_size);
 	param->config_data.va = (unsigned long)ctx->config;
 	param->config_data.pa = ctx->inst_addr;
 	param->drv_data = (unsigned long)ctx;
diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-vpu.h b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-vpu.h
index 244b3a32d689..b089bdf754c6 100644
--- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-vpu.h
+++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-vpu.h
@@ -42,11 +42,6 @@ enum mdp_config_id {
 	MDP_CONFIG_POOL_SIZE	/* ALWAYS keep at the end */
 };
 
-struct mdp_config_pool {
-	u64			cfg_count[MDP_CONFIG_POOL_SIZE];
-	struct img_config	configs[MDP_CONFIG_POOL_SIZE];
-};
-
 struct mdp_vpu_dev {
 	/* synchronization protect for accessing vpu working buffer info */
 	struct mutex		*lock;
@@ -55,14 +50,16 @@ struct mdp_vpu_dev {
 	void			*work;
 	dma_addr_t		work_addr;
 	size_t			work_size;
-	struct mdp_config_pool	*pool;
+	u32			cfg_count[MDP_CONFIG_POOL_SIZE];
+	u32			cfg_size;
+	phys_addr_t		pool;
 	u32			status;
 };
 
 struct mdp_vpu_ctx {
 	struct mdp_vpu_dev	*vpu_dev;
 	u32			config_id;
-	struct img_config	*config;
+	void			*config;
 	u32			inst_addr;
 };
 
-- 
2.18.0

