Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EEB873F4AF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 08:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbjF0Gk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 02:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230429AbjF0GkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 02:40:05 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA88C9F;
        Mon, 26 Jun 2023 23:40:03 -0700 (PDT)
X-UUID: 6f1f998214b511ee9cb5633481061a41-20230627
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=y9gb5DsL6ohZIhywiXBpwMFfpSz0sqd/ntC7ZEhIAgo=;
        b=RtViVNPHRkCkosInKmtYsQ1YI3AlgG9aa7bTOo3lEeoVeWLne0K8ZSLmqSNjavL4tldO4jNdFw5c8agM0j1kD+Scn6tipdWRNpWwlOZ3qvIMTnVXMrRFvGTEih3BOPOlfqcPW3RYGxuBbACQO/g3PMkJmeBpWBEPfMMQ0ovTjCQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.27,REQID:35fc352e-24b8-41df-98e5-34f1e321f47a,IP:0,U
        RL:0,TC:0,Content:-25,EDM:-30,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACT
        ION:release,TS:-55
X-CID-META: VersionHash:01c9525,CLOUDID:f65b5b82-5a99-42ae-a2dd-e4afb731b474,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:2,IP:nil,UR
        L:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 6f1f998214b511ee9cb5633481061a41-20230627
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <shawn.sung@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 100108060; Tue, 27 Jun 2023 14:39:58 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS14N2.mediatek.inc (172.21.101.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 27 Jun 2023 14:39:56 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 27 Jun 2023 14:39:56 +0800
From:   Hsiao Chien Sung <shawn.sung@mediatek.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Singo Chang <singo.chang@mediatek.com>,
        Nancy Lin <nancy.lin@mediatek.com>,
        Jason-JH Lin <jason-jh.lin@mediatek.com>,
        Shawn Sung <shawn.sung@mediatek.com>
Subject: [PATCH v5 14/14] drm/mediatek: Support MT8188 Padding in display driver
Date:   Tue, 27 Jun 2023 14:39:46 +0800
Message-ID: <20230627063946.14935-15-shawn.sung@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230627063946.14935-1-shawn.sung@mediatek.com>
References: <20230627063946.14935-1-shawn.sung@mediatek.com>
MIME-Version: 1.0
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

Padding is a new display module on MT8188, it provides ability
to add pixels to width and height of a layer with specified colors.

Due to hardware design, Mixer in VDOSYS1 requires width of a layer
to be 2-pixel-align, or 4-pixel-align when ETHDR is enabled,
we need Padding to deal with odd width.

Please notice that even if the Padding is in bypass mode,
settings in register must be cleared to 0,
or undefined behaviors could happen.

Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.com>
---
 drivers/gpu/drm/mediatek/Makefile             |   3 +-
 drivers/gpu/drm/mediatek/mtk_disp_drv.h       |   3 +
 .../gpu/drm/mediatek/mtk_disp_ovl_adaptor.c   |  33 +++++
 drivers/gpu/drm/mediatek/mtk_drm_drv.c        |   1 +
 drivers/gpu/drm/mediatek/mtk_drm_drv.h        |   2 +-
 drivers/gpu/drm/mediatek/mtk_padding.c        | 136 ++++++++++++++++++
 6 files changed, 176 insertions(+), 2 deletions(-)
 create mode 100644 drivers/gpu/drm/mediatek/mtk_padding.c

diff --git a/drivers/gpu/drm/mediatek/Makefile b/drivers/gpu/drm/mediatek/Makefile
index d4d193f60271..5e4436403b8d 100644
--- a/drivers/gpu/drm/mediatek/Makefile
+++ b/drivers/gpu/drm/mediatek/Makefile
@@ -16,7 +16,8 @@ mediatek-drm-y := mtk_disp_aal.o \
 		  mtk_dsi.o \
 		  mtk_dpi.o \
 		  mtk_ethdr.o \
-		  mtk_mdp_rdma.o
+		  mtk_mdp_rdma.o \
+		  mtk_padding.o
 
 obj-$(CONFIG_DRM_MEDIATEK) += mediatek-drm.o
 
diff --git a/drivers/gpu/drm/mediatek/mtk_disp_drv.h b/drivers/gpu/drm/mediatek/mtk_disp_drv.h
index 2254038519e1..f9fdb1268aa5 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_drv.h
+++ b/drivers/gpu/drm/mediatek/mtk_disp_drv.h
@@ -157,4 +157,7 @@ void mtk_mdp_rdma_config(struct device *dev, struct mtk_mdp_rdma_cfg *cfg,
 const u32 *mtk_mdp_rdma_get_formats(struct device *dev);
 size_t mtk_mdp_rdma_get_num_formats(struct device *dev);
 
+int mtk_padding_clk_enable(struct device *dev);
+void mtk_padding_clk_disable(struct device *dev);
+void mtk_padding_config(struct device *dev, struct cmdq_pkt *cmdq_pkt);
 #endif
diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c b/drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c
index f73a558dcf93..ca8f3febbf11 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c
@@ -29,6 +29,7 @@ enum mtk_ovl_adaptor_comp_type {
 	OVL_ADAPTOR_TYPE_ETHDR,
 	OVL_ADAPTOR_TYPE_MDP_RDMA,
 	OVL_ADAPTOR_TYPE_MERGE,
+	OVL_ADAPTOR_TYPE_PADDING,
 	OVL_ADAPTOR_TYPE_NUM,
 };
 
@@ -46,6 +47,14 @@ enum mtk_ovl_adaptor_comp_id {
 	OVL_ADAPTOR_MERGE1,
 	OVL_ADAPTOR_MERGE2,
 	OVL_ADAPTOR_MERGE3,
+	OVL_ADAPTOR_PADDING0,
+	OVL_ADAPTOR_PADDING1,
+	OVL_ADAPTOR_PADDING2,
+	OVL_ADAPTOR_PADDING3,
+	OVL_ADAPTOR_PADDING4,
+	OVL_ADAPTOR_PADDING5,
+	OVL_ADAPTOR_PADDING6,
+	OVL_ADAPTOR_PADDING7,
 	OVL_ADAPTOR_ID_MAX
 };
 
@@ -66,6 +75,7 @@ static const char * const private_comp_stem[OVL_ADAPTOR_TYPE_NUM] = {
 	[OVL_ADAPTOR_TYPE_ETHDR]	= "ethdr",
 	[OVL_ADAPTOR_TYPE_MDP_RDMA]	= "vdo1-rdma",
 	[OVL_ADAPTOR_TYPE_MERGE]	= "merge",
+	[OVL_ADAPTOR_TYPE_PADDING]	= "padding",
 };
 
 static const struct mtk_ddp_comp_funcs _ethdr = {
@@ -78,6 +88,11 @@ static const struct mtk_ddp_comp_funcs _merge = {
 	.clk_disable = mtk_merge_clk_disable,
 };
 
+static const struct mtk_ddp_comp_funcs _padding = {
+	.clk_enable = mtk_padding_clk_enable,
+	.clk_disable = mtk_padding_clk_disable,
+};
+
 static const struct mtk_ddp_comp_funcs _rdma = {
 	.clk_enable = mtk_mdp_rdma_clk_enable,
 	.clk_disable = mtk_mdp_rdma_clk_disable,
@@ -97,6 +112,14 @@ static const struct ovl_adaptor_comp_match comp_matches[OVL_ADAPTOR_ID_MAX] = {
 	[OVL_ADAPTOR_MERGE1] = { OVL_ADAPTOR_TYPE_MERGE, DDP_COMPONENT_MERGE2, 2, &_merge },
 	[OVL_ADAPTOR_MERGE2] = { OVL_ADAPTOR_TYPE_MERGE, DDP_COMPONENT_MERGE3, 3, &_merge },
 	[OVL_ADAPTOR_MERGE3] = { OVL_ADAPTOR_TYPE_MERGE, DDP_COMPONENT_MERGE4, 4, &_merge },
+	[OVL_ADAPTOR_PADDING0] = { OVL_ADAPTOR_TYPE_PADDING, DDP_COMPONENT_PADDING0, 0, &_padding },
+	[OVL_ADAPTOR_PADDING1] = { OVL_ADAPTOR_TYPE_PADDING, DDP_COMPONENT_PADDING1, 1, &_padding },
+	[OVL_ADAPTOR_PADDING2] = { OVL_ADAPTOR_TYPE_PADDING, DDP_COMPONENT_PADDING2, 2, &_padding },
+	[OVL_ADAPTOR_PADDING3] = { OVL_ADAPTOR_TYPE_PADDING, DDP_COMPONENT_PADDING3, 3, &_padding },
+	[OVL_ADAPTOR_PADDING4] = { OVL_ADAPTOR_TYPE_PADDING, DDP_COMPONENT_PADDING4, 4, &_padding },
+	[OVL_ADAPTOR_PADDING5] = { OVL_ADAPTOR_TYPE_PADDING, DDP_COMPONENT_PADDING5, 5, &_padding },
+	[OVL_ADAPTOR_PADDING6] = { OVL_ADAPTOR_TYPE_PADDING, DDP_COMPONENT_PADDING6, 6, &_padding },
+	[OVL_ADAPTOR_PADDING7] = { OVL_ADAPTOR_TYPE_PADDING, DDP_COMPONENT_PADDING7, 7, &_padding },
 };
 
 void mtk_ovl_adaptor_layer_config(struct device *dev, unsigned int idx,
@@ -108,6 +131,8 @@ void mtk_ovl_adaptor_layer_config(struct device *dev, unsigned int idx,
 	struct mtk_mdp_rdma_cfg rdma_config = {0};
 	struct device *ethdr;
 	struct device *merge;
+	struct device *padding_l;
+	struct device *padding_r;
 	struct device *rdma_l;
 	struct device *rdma_r;
 	const struct drm_format_info *fmt_info = drm_format_info(pending->format);
@@ -124,6 +149,8 @@ void mtk_ovl_adaptor_layer_config(struct device *dev, unsigned int idx,
 
 	ethdr = ovl_adaptor->ovl_adaptor_comp[OVL_ADAPTOR_ETHDR0];
 	merge = ovl_adaptor->ovl_adaptor_comp[OVL_ADAPTOR_MERGE0 + idx];
+	padding_l = ovl_adaptor->ovl_adaptor_comp[OVL_ADAPTOR_PADDING0 + 2 * idx];
+	padding_r = ovl_adaptor->ovl_adaptor_comp[OVL_ADAPTOR_PADDING0 + 2 * idx + 1];
 	rdma_l = ovl_adaptor->ovl_adaptor_comp[OVL_ADAPTOR_MDP_RDMA0 + 2 * idx];
 	rdma_r = ovl_adaptor->ovl_adaptor_comp[OVL_ADAPTOR_MDP_RDMA0 + 2 * idx + 1];
 
@@ -159,10 +186,15 @@ void mtk_ovl_adaptor_layer_config(struct device *dev, unsigned int idx,
 	rdma_config.color_encoding = pending->color_encoding;
 	mtk_mdp_rdma_config(rdma_l, &rdma_config, cmdq_pkt);
 
+	if (padding_l)
+		mtk_padding_config(padding_l, cmdq_pkt);
+
 	if (use_dual_pipe) {
 		rdma_config.x_left = l_w;
 		rdma_config.width = r_w;
 		mtk_mdp_rdma_config(rdma_r, &rdma_config, cmdq_pkt);
+		if (padding_r)
+			mtk_padding_config(padding_r, cmdq_pkt);
 	}
 
 	mtk_merge_start_cmdq(merge, cmdq_pkt);
@@ -353,6 +385,7 @@ static int ovl_adaptor_comp_get_id(struct device *dev, struct device_node *node,
 }
 
 static const struct of_device_id mtk_ovl_adaptor_comp_dt_ids[] = {
+	{ .compatible = "mediatek,mt8188-padding", .data = (void *)OVL_ADAPTOR_TYPE_PADDING },
 	{ .compatible = "mediatek,mt8195-disp-ethdr", .data = (void *)OVL_ADAPTOR_TYPE_ETHDR },
 	{ .compatible = "mediatek,mt8195-disp-merge", .data = (void *)OVL_ADAPTOR_TYPE_MERGE },
 	{ .compatible = "mediatek,mt8195-vdo1-rdma", .data = (void *)OVL_ADAPTOR_TYPE_MDP_RDMA },
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
index 613093068bb4..ed5b5b8d6c2e 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -977,6 +977,7 @@ static struct platform_driver * const mtk_drm_drivers[] = {
 	&mtk_dsi_driver,
 	&mtk_ethdr_driver,
 	&mtk_mdp_rdma_driver,
+	&mtk_padding_driver,
 };
 
 static int __init mtk_drm_init(void)
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.h b/drivers/gpu/drm/mediatek/mtk_drm_drv.h
index eb2fd45941f0..562f2db47add 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.h
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.h
@@ -64,5 +64,5 @@ extern struct platform_driver mtk_dpi_driver;
 extern struct platform_driver mtk_dsi_driver;
 extern struct platform_driver mtk_ethdr_driver;
 extern struct platform_driver mtk_mdp_rdma_driver;
-
+extern struct platform_driver mtk_padding_driver;
 #endif /* MTK_DRM_DRV_H */
diff --git a/drivers/gpu/drm/mediatek/mtk_padding.c b/drivers/gpu/drm/mediatek/mtk_padding.c
new file mode 100644
index 000000000000..bbb9c5e286ce
--- /dev/null
+++ b/drivers/gpu/drm/mediatek/mtk_padding.c
@@ -0,0 +1,136 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2023 MediaTek Inc.
+ */
+
+#include <linux/clk.h>
+#include <linux/component.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/soc/mediatek/mtk-cmdq.h>
+
+#include "mtk_disp_drv.h"
+#include "mtk_drm_crtc.h"
+#include "mtk_drm_ddp_comp.h"
+
+/**
+ * struct mtk_padding - basic information of Padding
+ * @clk: Clock of the module
+ * @regs: Virtual address of the Padding for CPU to access
+ * @cmdq_reg: CMDQ setting of the Padding
+ *
+ * Every Padding should have different clock source, register base, and
+ * CMDQ settings, we stored these differences all together.
+ */
+struct mtk_padding {
+	struct clk		*clk;
+	void __iomem		*regs;
+	struct cmdq_client_reg	cmdq_reg;
+};
+
+int mtk_padding_clk_enable(struct device *dev)
+{
+	struct mtk_padding *padding = dev_get_drvdata(dev);
+
+	return clk_prepare_enable(padding->clk);
+}
+
+void mtk_padding_clk_disable(struct device *dev)
+{
+	struct mtk_padding *padding = dev_get_drvdata(dev);
+
+	clk_disable_unprepare(padding->clk);
+}
+
+void mtk_padding_config(struct device *dev, struct cmdq_pkt *cmdq_pkt)
+{
+	struct mtk_padding *padding = dev_get_drvdata(dev);
+
+	/* bypass padding */
+	mtk_ddp_write_mask(cmdq_pkt, GENMASK(1, 0), &padding->cmdq_reg, padding->regs, 0,
+			   GENMASK(1, 0));
+}
+
+static int mtk_padding_bind(struct device *dev, struct device *master, void *data)
+{
+	return 0;
+}
+
+static void mtk_padding_unbind(struct device *dev, struct device *master, void *data)
+{
+}
+
+static const struct component_ops mtk_padding_component_ops = {
+	.bind	= mtk_padding_bind,
+	.unbind = mtk_padding_unbind,
+};
+
+static int mtk_padding_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct mtk_padding *priv;
+	struct resource *res;
+	int ret;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->clk = devm_clk_get(dev, NULL);
+	if (IS_ERR(priv->clk)) {
+		dev_err(dev, "failed to get clk\n");
+		return PTR_ERR(priv->clk);
+	}
+
+	priv->regs = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
+	if (IS_ERR(priv->regs)) {
+		dev_err(dev, "failed to do ioremap\n");
+		return PTR_ERR(priv->regs);
+	}
+
+#if IS_REACHABLE(CONFIG_MTK_CMDQ)
+	ret = cmdq_dev_get_client_reg(dev, &priv->cmdq_reg, 0);
+	if (ret) {
+		dev_err(dev, "failed to get gce client reg\n");
+		return ret;
+	}
+#endif
+
+	platform_set_drvdata(pdev, priv);
+
+	ret = devm_pm_runtime_enable(dev);
+	if (ret)
+		return ret;
+
+	ret = component_add(dev, &mtk_padding_component_ops);
+	if (ret) {
+		pm_runtime_disable(dev);
+		return dev_err_probe(dev, ret, "failed to add component\n");
+	}
+
+	return 0;
+}
+
+static int mtk_padding_remove(struct platform_device *pdev)
+{
+	component_del(&pdev->dev, &mtk_padding_component_ops);
+	return 0;
+}
+
+static const struct of_device_id mtk_padding_driver_dt_match[] = {
+	{ .compatible = "mediatek,mt8188-padding" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, mtk_padding_driver_dt_match);
+
+struct platform_driver mtk_padding_driver = {
+	.probe		= mtk_padding_probe,
+	.remove		= mtk_padding_remove,
+	.driver		= {
+		.name	= "mediatek-padding",
+		.owner	= THIS_MODULE,
+		.of_match_table = mtk_padding_driver_dt_match,
+	},
+};
-- 
2.18.0

