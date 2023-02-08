Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D52FB68EAA5
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 10:10:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbjBHJJ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 04:09:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230517AbjBHJJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 04:09:18 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9862B45BFF;
        Wed,  8 Feb 2023 01:09:10 -0800 (PST)
X-UUID: 388538e2a79011eda06fc9ecc4dadd91-20230208
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=dBAxAUPXKKGwDkdzJdyIEfe7h6oIU1Da4WZLT6aEF5E=;
        b=FKyMLO7X45MnY9wGhBsk7u64Sxt7Q8YpkbsAIgYVbolHSMtzAW9IeKHeOm3m4I3bboW4DAgIEl7CMtAcxL/RluPrk79JW4E7KO5v1ZTk2cCQmsi+aOK93W2kGK/5ZqMmo/b6V8yrw0ktrOkjMfypSSZHb1Ye38kfvSU+SCvRpjQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.19,REQID:f5745ada-245f-4540-ab99-145d556b88c0,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:885ddb2,CLOUDID:0633d4f7-ff42-4fb0-b929-626456a83c14,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-UUID: 388538e2a79011eda06fc9ecc4dadd91-20230208
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <moudy.ho@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 208574277; Wed, 08 Feb 2023 17:08:58 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 8 Feb 2023 17:08:57 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Wed, 8 Feb 2023 17:08:57 +0800
From:   Moudy Ho <moudy.ho@mediatek.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Ping-Hsun Wu <ping-hsun.wu@mediatek.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Moudy Ho <moudy.ho@mediatek.com>
Subject: [PATCH v6 03/12] media: platform: mtk-mdp3: chip config split about component settings
Date:   Wed, 8 Feb 2023 17:08:46 +0800
Message-ID: <20230208090855.18934-4-moudy.ho@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230208090855.18934-1-moudy.ho@mediatek.com>
References: <20230208090855.18934-1-moudy.ho@mediatek.com>
MIME-Version: 1.0
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

For different chips, different types and numbers of components are
configured in the MDP3 to achieve the desired application, which will
cause ID compatibility problems in the same driver.

Subdivide the component ID into two kinds:
	1. public_id (compatible with other chips)
	2. inner_id (what the current chip actually owns)

In addition, the chip configuration related structures of MDP3 components
are integrated into specific file.

Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
---
 .../platform/mediatek/mdp3/mdp_cfg_data.c     | 145 ++++++++++++++++++
 .../platform/mediatek/mdp3/mtk-mdp3-cfg.h     |   8 +
 .../platform/mediatek/mdp3/mtk-mdp3-cmdq.c    |   4 +-
 .../platform/mediatek/mdp3/mtk-mdp3-comp.c    | 117 ++++++--------
 .../platform/mediatek/mdp3/mtk-mdp3-comp.h    |  21 ++-
 .../platform/mediatek/mdp3/mtk-mdp3-core.h    |   2 +
 6 files changed, 223 insertions(+), 74 deletions(-)

diff --git a/drivers/media/platform/mediatek/mdp3/mdp_cfg_data.c b/drivers/media/platform/mediatek/mdp3/mdp_cfg_data.c
index 837b8202dcc7..af2e75acf119 100644
--- a/drivers/media/platform/mediatek/mdp3/mdp_cfg_data.c
+++ b/drivers/media/platform/mediatek/mdp3/mdp_cfg_data.c
@@ -4,7 +4,45 @@
  * Author: Ping-Hsun Wu <ping-hsun.wu@mediatek.com>
  */
 
+#include "mtk-mdp3-cfg.h"
 #include "mtk-mdp3-core.h"
+#include "mtk-mdp3-comp.h"
+
+enum mt8183_mdp_comp_id {
+	/* ISP */
+	MT8183_MDP_COMP_WPEI = 0,
+	MT8183_MDP_COMP_WPEO,           /* 1 */
+	MT8183_MDP_COMP_WPEI2,          /* 2 */
+	MT8183_MDP_COMP_WPEO2,          /* 3 */
+	MT8183_MDP_COMP_ISP_IMGI,       /* 4 */
+	MT8183_MDP_COMP_ISP_IMGO,       /* 5 */
+	MT8183_MDP_COMP_ISP_IMG2O,      /* 6 */
+
+	/* IPU */
+	MT8183_MDP_COMP_IPUI,           /* 7 */
+	MT8183_MDP_COMP_IPUO,           /* 8 */
+
+	/* MDP */
+	MT8183_MDP_COMP_CAMIN,          /* 9 */
+	MT8183_MDP_COMP_CAMIN2,         /* 10 */
+	MT8183_MDP_COMP_RDMA0,          /* 11 */
+	MT8183_MDP_COMP_AAL0,           /* 12 */
+	MT8183_MDP_COMP_CCORR0,         /* 13 */
+	MT8183_MDP_COMP_RSZ0,           /* 14 */
+	MT8183_MDP_COMP_RSZ1,           /* 15 */
+	MT8183_MDP_COMP_TDSHP0,         /* 16 */
+	MT8183_MDP_COMP_COLOR0,         /* 17 */
+	MT8183_MDP_COMP_PATH0_SOUT,     /* 18 */
+	MT8183_MDP_COMP_PATH1_SOUT,     /* 19 */
+	MT8183_MDP_COMP_WROT0,          /* 20 */
+	MT8183_MDP_COMP_WDMA,           /* 21 */
+
+	/* Dummy Engine */
+	MT8183_MDP_COMP_RDMA1,          /* 22 */
+	MT8183_MDP_COMP_RSZ2,           /* 23 */
+	MT8183_MDP_COMP_TDSHP1,         /* 24 */
+	MT8183_MDP_COMP_WROT1,          /* 25 */
+};
 
 static const struct of_device_id mt8183_mdp_probe_infra[MDP_INFRA_MAX] = {
 	[MDP_INFRA_MMSYS] = { .compatible = "mediatek,mt8183-mmsys" },
@@ -31,8 +69,115 @@ static const u32 mt8183_mutex_idx[MDP_MAX_COMP_COUNT] = {
 	[MDP_COMP_CCORR0] = MUTEX_MOD_IDX_MDP_CCORR0,
 };
 
+static const struct mdp_comp_data mt8183_mdp_comp_data[MDP_MAX_COMP_COUNT] = {
+	[MDP_COMP_WPEI] = {
+		{MDP_COMP_TYPE_WPEI, 0, MT8183_MDP_COMP_WPEI},
+		{0, 0, 0}
+	},
+	[MDP_COMP_WPEO] = {
+		{MDP_COMP_TYPE_EXTO, 2, MT8183_MDP_COMP_WPEO},
+		{0, 0, 0}
+	},
+	[MDP_COMP_WPEI2] = {
+		{MDP_COMP_TYPE_WPEI, 1, MT8183_MDP_COMP_WPEI2},
+		{0, 0, 0}
+	},
+	[MDP_COMP_WPEO2] = {
+		{MDP_COMP_TYPE_EXTO, 3, MT8183_MDP_COMP_WPEO2},
+		{0, 0, 0}
+	},
+	[MDP_COMP_ISP_IMGI] = {
+		{MDP_COMP_TYPE_IMGI, 0, MT8183_MDP_COMP_ISP_IMGI},
+		{0, 0, 4}
+	},
+	[MDP_COMP_ISP_IMGO] = {
+		{MDP_COMP_TYPE_EXTO, 0, MT8183_MDP_COMP_ISP_IMGO},
+		{0, 0, 4}
+	},
+	[MDP_COMP_ISP_IMG2O] = {
+		{MDP_COMP_TYPE_EXTO, 1, MT8183_MDP_COMP_ISP_IMG2O},
+		{0, 0, 0}
+	},
+	[MDP_COMP_CAMIN] = {
+		{MDP_COMP_TYPE_DL_PATH, 0, MT8183_MDP_COMP_CAMIN},
+		{2, 2, 1}
+	},
+	[MDP_COMP_CAMIN2] = {
+		{MDP_COMP_TYPE_DL_PATH, 1, MT8183_MDP_COMP_CAMIN2},
+		{2, 4, 1}
+	},
+	[MDP_COMP_RDMA0] = {
+		{MDP_COMP_TYPE_RDMA, 0, MT8183_MDP_COMP_RDMA0},
+		{2, 0, 0}
+	},
+	[MDP_COMP_CCORR0] = {
+		{MDP_COMP_TYPE_CCORR, 0, MT8183_MDP_COMP_CCORR0},
+		{1, 0, 0}
+	},
+	[MDP_COMP_RSZ0] = {
+		{MDP_COMP_TYPE_RSZ, 0, MT8183_MDP_COMP_RSZ0},
+		{1, 0, 0}
+	},
+	[MDP_COMP_RSZ1] = {
+		{MDP_COMP_TYPE_RSZ, 1, MT8183_MDP_COMP_RSZ1},
+		{1, 0, 0}
+	},
+	[MDP_COMP_TDSHP0] = {
+		{MDP_COMP_TYPE_TDSHP, 0, MT8183_MDP_COMP_TDSHP0},
+		{0, 0, 0}
+	},
+	[MDP_COMP_PATH0_SOUT] = {
+		{MDP_COMP_TYPE_PATH, 0, MT8183_MDP_COMP_PATH0_SOUT},
+		{0, 0, 0}
+	},
+	[MDP_COMP_PATH1_SOUT] = {
+		{MDP_COMP_TYPE_PATH, 1, MT8183_MDP_COMP_PATH1_SOUT},
+		{0, 0, 0}
+	},
+	[MDP_COMP_WROT0] = {
+		{MDP_COMP_TYPE_WROT, 0, MT8183_MDP_COMP_WROT0},
+		{1, 0, 0}
+	},
+	[MDP_COMP_WDMA] = {
+		{MDP_COMP_TYPE_WDMA, 0, MT8183_MDP_COMP_WDMA},
+		{1, 0, 0}
+	},
+};
+
 const struct mtk_mdp_driver_data mt8183_mdp_driver_data = {
 	.mdp_probe_infra = mt8183_mdp_probe_infra,
 	.mdp_cfg = &mt8183_plat_cfg,
 	.mdp_mutex_table_idx = mt8183_mutex_idx,
+	.comp_data = mt8183_mdp_comp_data,
+	.comp_data_len = ARRAY_SIZE(mt8183_mdp_comp_data),
 };
+
+s32 mdp_cfg_get_id_inner(struct mdp_dev *mdp_dev, enum mtk_mdp_comp_id id)
+{
+	if (!mdp_dev)
+		return MDP_COMP_NONE;
+	if (id <= MDP_COMP_NONE || id >= MDP_MAX_COMP_COUNT)
+		return MDP_COMP_NONE;
+
+	return mdp_dev->mdp_data->comp_data[id].match.inner_id;
+}
+
+enum mtk_mdp_comp_id mdp_cfg_get_id_public(struct mdp_dev *mdp_dev, s32 inner_id)
+{
+	enum mtk_mdp_comp_id public_id = MDP_COMP_NONE;
+	u32 i;
+
+	if (IS_ERR(mdp_dev) || !inner_id)
+		goto err_public_id;
+
+	for (i = 0; i < MDP_MAX_COMP_COUNT; i++) {
+		if (mdp_dev->mdp_data->comp_data[i].match.inner_id == inner_id) {
+			public_id = i;
+			return public_id;
+		}
+	}
+
+err_public_id:
+	dev_err(&mdp_dev->pdev->dev, "Unmapped inner id %d", inner_id);
+	return public_id;
+}
diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-cfg.h b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-cfg.h
index e0a698cba6ff..dee57cc4a954 100644
--- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-cfg.h
+++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-cfg.h
@@ -7,6 +7,14 @@
 #ifndef __MTK_MDP3_CFG_H__
 #define __MTK_MDP3_CFG_H__
 
+#include <linux/types.h>
+
 extern const struct mtk_mdp_driver_data mt8183_mdp_driver_data;
 
+struct mdp_dev;
+enum mtk_mdp_comp_id;
+
+s32 mdp_cfg_get_id_inner(struct mdp_dev *mdp_dev, enum mtk_mdp_comp_id id);
+enum mtk_mdp_comp_id mdp_cfg_get_id_public(struct mdp_dev *mdp_dev, s32 id);
+
 #endif  /* __MTK_MDP3_CFG_H__ */
diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-cmdq.c b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-cmdq.c
index 124c1b96e96b..dcd77f65b0e3 100644
--- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-cmdq.c
+++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-cmdq.c
@@ -48,7 +48,7 @@ static int mdp_path_subfrm_require(const struct mdp_path *path,
 	int id, index;
 
 	/* Decide which mutex to use based on the current pipeline */
-	switch (path->comps[0].comp->id) {
+	switch (path->comps[0].comp->public_id) {
 	case MDP_COMP_RDMA0:
 		*mutex_id = MDP_PIPE_RDMA0;
 		break;
@@ -71,7 +71,7 @@ static int mdp_path_subfrm_require(const struct mdp_path *path,
 		ctx = &path->comps[index];
 		if (is_output_disabled(ctx->param, count))
 			continue;
-		id = ctx->comp->id;
+		id = ctx->comp->public_id;
 		mtk_mutex_write_mod(mutex[*mutex_id],
 				    data->mdp_mutex_table_idx[id], false);
 	}
diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c
index 7bc05f42a23c..1000b0ae3483 100644
--- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c
+++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c
@@ -8,6 +8,7 @@
 #include <linux/of_platform.h>
 #include <linux/of_address.h>
 #include <linux/pm_runtime.h>
+#include "mtk-mdp3-cfg.h"
 #include "mtk-mdp3-comp.h"
 #include "mtk-mdp3-core.h"
 #include "mtk-mdp3-regs.h"
@@ -32,12 +33,18 @@ __get_plat_cfg(const struct mdp_comp_ctx *ctx)
 static s64 get_comp_flag(const struct mdp_comp_ctx *ctx)
 {
 	const struct mdp_platform_config *mdp_cfg = __get_plat_cfg(ctx);
+	u32 rdma0, rsz1;
+
+	rdma0 = mdp_cfg_get_id_inner(ctx->comp->mdp_dev, MDP_COMP_RDMA0);
+	rsz1 = mdp_cfg_get_id_inner(ctx->comp->mdp_dev, MDP_COMP_RSZ1);
+	if (!rdma0 || !rsz1)
+		return MDP_COMP_NONE;
 
 	if (mdp_cfg && mdp_cfg->rdma_rsz1_sram_sharing)
-		if (ctx->comp->id == MDP_COMP_RDMA0)
-			return BIT(MDP_COMP_RDMA0) | BIT(MDP_COMP_RSZ1);
+		if (ctx->comp->inner_id == rdma0)
+			return BIT(rdma0) | BIT(rsz1);
 
-	return BIT(ctx->comp->id);
+	return BIT(ctx->comp->inner_id);
 }
 
 static int init_rdma(struct mdp_comp_ctx *ctx, struct mdp_cmdq_cmd *cmd)
@@ -45,12 +52,17 @@ static int init_rdma(struct mdp_comp_ctx *ctx, struct mdp_cmdq_cmd *cmd)
 	const struct mdp_platform_config *mdp_cfg = __get_plat_cfg(ctx);
 	phys_addr_t base = ctx->comp->reg_base;
 	u8 subsys_id = ctx->comp->subsys_id;
+	s32 rdma0;
+
+	rdma0 = mdp_cfg_get_id_inner(ctx->comp->mdp_dev, MDP_COMP_RDMA0);
+	if (!rdma0)
+		return -EINVAL;
 
 	if (mdp_cfg && mdp_cfg->rdma_support_10bit) {
 		struct mdp_comp *prz1 = ctx->comp->mdp_dev->comp[MDP_COMP_RSZ1];
 
 		/* Disable RSZ1 */
-		if (ctx->comp->id == MDP_COMP_RDMA0 && prz1)
+		if (ctx->comp->inner_id == rdma0 && prz1)
 			MM_REG_WRITE(cmd, subsys_id, prz1->reg_base, PRZ_ENABLE,
 				     0x0, BIT(0));
 	}
@@ -578,32 +590,6 @@ static const struct mdp_comp_ops *mdp_comp_ops[MDP_COMP_TYPE_COUNT] = {
 	[MDP_COMP_TYPE_CCORR] =		&ccorr_ops,
 };
 
-struct mdp_comp_match {
-	enum mdp_comp_type	type;
-	u32			alias_id;
-};
-
-static const struct mdp_comp_match mdp_comp_matches[MDP_MAX_COMP_COUNT] = {
-	[MDP_COMP_WPEI] =	{ MDP_COMP_TYPE_WPEI, 0 },
-	[MDP_COMP_WPEO] =	{ MDP_COMP_TYPE_EXTO, 2 },
-	[MDP_COMP_WPEI2] =	{ MDP_COMP_TYPE_WPEI, 1 },
-	[MDP_COMP_WPEO2] =	{ MDP_COMP_TYPE_EXTO, 3 },
-	[MDP_COMP_ISP_IMGI] =	{ MDP_COMP_TYPE_IMGI, 0 },
-	[MDP_COMP_ISP_IMGO] =	{ MDP_COMP_TYPE_EXTO, 0 },
-	[MDP_COMP_ISP_IMG2O] =	{ MDP_COMP_TYPE_EXTO, 1 },
-
-	[MDP_COMP_CAMIN] =	{ MDP_COMP_TYPE_DL_PATH, 0 },
-	[MDP_COMP_CAMIN2] =	{ MDP_COMP_TYPE_DL_PATH, 1 },
-	[MDP_COMP_RDMA0] =	{ MDP_COMP_TYPE_RDMA, 0 },
-	[MDP_COMP_CCORR0] =	{ MDP_COMP_TYPE_CCORR, 0 },
-	[MDP_COMP_RSZ0] =	{ MDP_COMP_TYPE_RSZ, 0 },
-	[MDP_COMP_RSZ1] =	{ MDP_COMP_TYPE_RSZ, 1 },
-	[MDP_COMP_PATH0_SOUT] =	{ MDP_COMP_TYPE_PATH, 0 },
-	[MDP_COMP_PATH1_SOUT] =	{ MDP_COMP_TYPE_PATH, 1 },
-	[MDP_COMP_WROT0] =	{ MDP_COMP_TYPE_WROT, 0 },
-	[MDP_COMP_WDMA] =	{ MDP_COMP_TYPE_WDMA, 0 },
-};
-
 static const struct of_device_id mdp_comp_dt_ids[] = {
 	{
 		.compatible = "mediatek,mt8183-mdp3-rdma",
@@ -635,21 +621,6 @@ static const struct of_device_id mdp_sub_comp_dt_ids[] = {
 	{}
 };
 
-/* Used to describe the item order in MDP property */
-struct mdp_comp_info {
-	u32	clk_num;
-	u32	clk_ofst;
-	u32	dts_reg_ofst;
-};
-
-static const struct mdp_comp_info mdp_comp_dt_info[MDP_MAX_COMP_COUNT] = {
-	[MDP_COMP_RDMA0]	= {2, 0, 0},
-	[MDP_COMP_RSZ0]		= {1, 0, 0},
-	[MDP_COMP_WROT0]	= {1, 0, 0},
-	[MDP_COMP_WDMA]		= {1, 0, 0},
-	[MDP_COMP_CCORR0]	= {1, 0, 0},
-};
-
 static inline bool is_dma_capable(const enum mdp_comp_type type)
 {
 	return (type == MDP_COMP_TYPE_RDMA ||
@@ -666,13 +637,13 @@ static inline bool is_bypass_gce_event(const enum mdp_comp_type type)
 	return (type == MDP_COMP_TYPE_PATH);
 }
 
-static int mdp_comp_get_id(enum mdp_comp_type type, int alias_id)
+static int mdp_comp_get_id(struct mdp_dev *mdp, enum mdp_comp_type type, u32 alias_id)
 {
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(mdp_comp_matches); i++)
-		if (mdp_comp_matches[i].type == type &&
-		    mdp_comp_matches[i].alias_id == alias_id)
+	for (i = 0; i < mdp->mdp_data->comp_data_len; i++)
+		if (mdp->mdp_data->comp_data[i].match.type == type &&
+		    mdp->mdp_data->comp_data[i].match.alias_id == alias_id)
 			return i;
 	return -ENODEV;
 }
@@ -686,7 +657,7 @@ int mdp_comp_clock_on(struct device *dev, struct mdp_comp *comp)
 		if (ret < 0) {
 			dev_err(dev,
 				"Failed to get power, err %d. type:%d id:%d\n",
-				ret, comp->type, comp->id);
+				ret, comp->type, comp->inner_id);
 			return ret;
 		}
 	}
@@ -698,7 +669,7 @@ int mdp_comp_clock_on(struct device *dev, struct mdp_comp *comp)
 		if (ret) {
 			dev_err(dev,
 				"Failed to enable clk %d. type:%d id:%d\n",
-				i, comp->type, comp->id);
+				i, comp->type, comp->inner_id);
 			goto err_revert;
 		}
 	}
@@ -752,8 +723,8 @@ void mdp_comp_clocks_off(struct device *dev, struct mdp_comp *comps, int num)
 		mdp_comp_clock_off(dev, &comps[i]);
 }
 
-static int mdp_get_subsys_id(struct device *dev, struct device_node *node,
-			     struct mdp_comp *comp)
+static int mdp_get_subsys_id(struct mdp_dev *mdp, struct device *dev,
+			     struct device_node *node, struct mdp_comp *comp)
 {
 	struct platform_device *comp_pdev;
 	struct cmdq_client_reg  cmdq_reg;
@@ -766,12 +737,12 @@ static int mdp_get_subsys_id(struct device *dev, struct device_node *node,
 	comp_pdev = of_find_device_by_node(node);
 
 	if (!comp_pdev) {
-		dev_err(dev, "get comp_pdev fail! comp id=%d type=%d\n",
-			comp->id, comp->type);
+		dev_err(dev, "get comp_pdev fail! comp public id=%d, inner id=%d, type=%d\n",
+			comp->public_id, comp->inner_id, comp->type);
 		return -ENODEV;
 	}
 
-	index = mdp_comp_dt_info[comp->id].dts_reg_ofst;
+	index = mdp->mdp_data->comp_data[comp->public_id].info.dts_reg_ofst;
 	ret = cmdq_dev_get_client_reg(&comp_pdev->dev, &cmdq_reg, index);
 	if (ret != 0) {
 		dev_err(&comp_pdev->dev, "cmdq_dev_get_subsys fail!\n");
@@ -789,8 +760,9 @@ static void __mdp_comp_init(struct mdp_dev *mdp, struct device_node *node,
 {
 	struct resource res;
 	phys_addr_t base;
-	int index = mdp_comp_dt_info[comp->id].dts_reg_ofst;
+	int index;
 
+	index = mdp->mdp_data->comp_data[comp->public_id].info.dts_reg_ofst;
 	if (of_address_to_resource(node, index, &res) < 0)
 		base = 0L;
 	else
@@ -815,14 +787,15 @@ static int mdp_comp_init(struct mdp_dev *mdp, struct device_node *node,
 		return -EINVAL;
 	}
 
-	comp->id = id;
-	comp->type = mdp_comp_matches[id].type;
-	comp->alias_id = mdp_comp_matches[id].alias_id;
+	comp->public_id = id;
+	comp->type = mdp->mdp_data->comp_data[id].match.type;
+	comp->inner_id = mdp->mdp_data->comp_data[id].match.inner_id;
+	comp->alias_id = mdp->mdp_data->comp_data[id].match.alias_id;
 	comp->ops = mdp_comp_ops[comp->type];
 	__mdp_comp_init(mdp, node, comp);
 
-	clk_num = mdp_comp_dt_info[id].clk_num;
-	clk_ofst = mdp_comp_dt_info[id].clk_ofst;
+	clk_num = mdp->mdp_data->comp_data[id].info.clk_num;
+	clk_ofst = mdp->mdp_data->comp_data[id].info.clk_ofst;
 
 	for (i = 0; i < clk_num; i++) {
 		comp->clks[i] = of_clk_get(node, i + clk_ofst);
@@ -830,7 +803,7 @@ static int mdp_comp_init(struct mdp_dev *mdp, struct device_node *node,
 			break;
 	}
 
-	mdp_get_subsys_id(dev, node, comp);
+	mdp_get_subsys_id(mdp, dev, node, comp);
 
 	/* Set GCE SOF event */
 	if (is_bypass_gce_event(comp->type) ||
@@ -888,8 +861,8 @@ static struct mdp_comp *mdp_comp_create(struct mdp_dev *mdp,
 	mdp->comp[id] = comp;
 	mdp->comp[id]->mdp_dev = mdp;
 
-	dev_dbg(dev, "%s type:%d alias:%d id:%d base:%#x regs:%p\n",
-		dev->of_node->name, comp->type, comp->alias_id, id,
+	dev_dbg(dev, "%s type:%d alias:%d public id:%d inner id:%d base:%#x regs:%p\n",
+		dev->of_node->name, comp->type, comp->alias_id, id, comp->inner_id,
 		(u32)comp->reg_base, comp->regs);
 	return comp;
 }
@@ -918,7 +891,7 @@ static int mdp_comp_sub_create(struct mdp_dev *mdp)
 
 		type = (enum mdp_comp_type)(uintptr_t)of_id->data;
 		alias_id = mdp_comp_alias_id[type];
-		id = mdp_comp_get_id(type, alias_id);
+		id = mdp_comp_get_id(mdp, type, alias_id);
 		if (id < 0) {
 			dev_err(dev,
 				"Fail to get sub comp. id: type %d alias %d\n",
@@ -978,7 +951,7 @@ int mdp_comp_config(struct mdp_dev *mdp)
 
 		type = (enum mdp_comp_type)(uintptr_t)of_id->data;
 		alias_id = mdp_comp_alias_id[type];
-		id = mdp_comp_get_id(type, alias_id);
+		id = mdp_comp_get_id(mdp, type, alias_id);
 		if (id < 0) {
 			dev_err(dev,
 				"Fail to get component id: type %d alias %d\n",
@@ -1025,16 +998,18 @@ int mdp_comp_ctx_config(struct mdp_dev *mdp, struct mdp_comp_ctx *ctx,
 			const struct img_ipi_frameparam *frame)
 {
 	struct device *dev = &mdp->pdev->dev;
+	enum mtk_mdp_comp_id public_id = MDP_COMP_NONE;
 	int i;
 
-	if (param->type < 0 || param->type >= MDP_MAX_COMP_COUNT) {
-		dev_err(dev, "Invalid component id %d", param->type);
+	public_id = mdp_cfg_get_id_public(mdp, param->type);
+	if (public_id < 0) {
+		dev_err(dev, "Invalid component id %d", public_id);
 		return -EINVAL;
 	}
 
-	ctx->comp = mdp->comp[param->type];
+	ctx->comp = mdp->comp[public_id];
 	if (!ctx->comp) {
-		dev_err(dev, "Uninit component id %d", param->type);
+		dev_err(dev, "Uninit component inner id %d", param->type);
 		return -EINVAL;
 	}
 
diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.h b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.h
index dc48f55ac4f7..3de994d7ef1c 100644
--- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.h
+++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.h
@@ -134,6 +134,24 @@ enum {
 	MDP_GCE_EVENT_MAX,
 };
 
+struct mdp_comp_match {
+	enum mdp_comp_type type;
+	u32 alias_id;
+	s32 inner_id;
+};
+
+/* Used to describe the item order in MDP property */
+struct mdp_comp_info {
+	u32 clk_num;
+	u32 clk_ofst;
+	u32 dts_reg_ofst;
+};
+
+struct mdp_comp_data {
+	struct mdp_comp_match match;
+	struct mdp_comp_info info;
+};
+
 struct mdp_comp_ops;
 
 struct mdp_comp {
@@ -144,7 +162,8 @@ struct mdp_comp {
 	struct clk			*clks[6];
 	struct device			*comp_dev;
 	enum mdp_comp_type		type;
-	enum mtk_mdp_comp_id		id;
+	enum mtk_mdp_comp_id		public_id;
+	s32				inner_id;
 	u32				alias_id;
 	s32				gce_event[MDP_GCE_EVENT_MAX];
 	const struct mdp_comp_ops	*ops;
diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.h b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.h
index 2ef5fbc4f25a..0c398ef75616 100644
--- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.h
+++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.h
@@ -54,6 +54,8 @@ struct mtk_mdp_driver_data {
 	const struct of_device_id *mdp_probe_infra;
 	const struct mdp_platform_config *mdp_cfg;
 	const u32 *mdp_mutex_table_idx;
+	const struct mdp_comp_data *comp_data;
+	unsigned int comp_data_len;
 };
 
 struct mdp_dev {
-- 
2.18.0

