Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 474667253EB
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 08:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234905AbjFGGMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 02:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234682AbjFGGLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 02:11:43 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9981210DE;
        Tue,  6 Jun 2023 23:11:40 -0700 (PDT)
X-UUID: 267cbfa404fa11eeb20a276fd37b9834-20230607
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=j2TfU3XE3RrXkWcR5XQ1FwXMxnXNpSjaXm1qh5cKGzU=;
        b=d5XKZ4rMkY3LrUAF3QER5PV1FfJaqfJ6mdHrdCeeOpRfLBqtAWrATnosqKFMYMd8CEsTbJRxlfPxPdDUDHUlBEVkszR4oT8VR9NfogquY2bxbmgiIhwktgyl4FnzFyKqdH84uyeo+nbsSJoGJBdim3GkFDW9SBXIlooCHmFNGyA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.25,REQID:878fd9de-494f-4774-b91b-463935a2ff03,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-25
X-CID-META: VersionHash:d5b0ae3,CLOUDID:fd0aa33d-de1e-4348-bc35-c96f92f1dcbb,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: 267cbfa404fa11eeb20a276fd37b9834-20230607
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
        (envelope-from <shawn.sung@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2070099171; Wed, 07 Jun 2023 14:11:32 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 7 Jun 2023 14:11:31 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 7 Jun 2023 14:11:31 +0800
From:   Hsiao Chien Sung <shawn.sung@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Singo Chang <singo.chang@mediatek.com>,
        Nancy Lin <nancy.lin@mediatek.com>,
        Jason-JH Lin <jason-jh.lin@mediatek.com>,
        Hsiao Chein Sung <shawn.sung@mediatek.com>,
        Fei Shao <fshao@google.com>
Subject: [PATCH v1 6/6] drm/mediatek: mt8188: Add VDOSYS1 PADDING driver
Date:   Wed, 7 Jun 2023 14:11:21 +0800
Message-ID: <20230607061121.6732-7-shawn.sung@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230607061121.6732-1-shawn.sung@mediatek.com>
References: <20230607061121.6732-1-shawn.sung@mediatek.com>
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

Add VDOSYS1 PADDING driver.

Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.com>
---
 drivers/gpu/drm/mediatek/Makefile             |   1 +
 drivers/gpu/drm/mediatek/mtk_disp_drv.h       |   3 +
 .../gpu/drm/mediatek/mtk_disp_ovl_adaptor.c   |  43 +++++-
 drivers/gpu/drm/mediatek/mtk_disp_padding.c   | 134 ++++++++++++++++++
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h   |   1 +
 drivers/gpu/drm/mediatek/mtk_drm_drv.c        |   1 +
 drivers/gpu/drm/mediatek/mtk_drm_drv.h        |   2 +-
 7 files changed, 181 insertions(+), 4 deletions(-)
 create mode 100644 drivers/gpu/drm/mediatek/mtk_disp_padding.c

diff --git a/drivers/gpu/drm/mediatek/Makefile b/drivers/gpu/drm/mediatek/Makefile
index d4d193f60271..753b7cb264d6 100644
--- a/drivers/gpu/drm/mediatek/Makefile
+++ b/drivers/gpu/drm/mediatek/Makefile
@@ -7,6 +7,7 @@ mediatek-drm-y := mtk_disp_aal.o \
 		  mtk_disp_merge.o \
 		  mtk_disp_ovl.o \
 		  mtk_disp_ovl_adaptor.o \
+		  mtk_disp_padding.o \
 		  mtk_disp_rdma.o \
 		  mtk_drm_crtc.o \
 		  mtk_drm_ddp_comp.o \
diff --git a/drivers/gpu/drm/mediatek/mtk_disp_drv.h b/drivers/gpu/drm/mediatek/mtk_disp_drv.h
index 2254038519e1..7200519a2670 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_drv.h
+++ b/drivers/gpu/drm/mediatek/mtk_disp_drv.h
@@ -157,4 +157,7 @@ void mtk_mdp_rdma_config(struct device *dev, struct mtk_mdp_rdma_cfg *cfg,
 const u32 *mtk_mdp_rdma_get_formats(struct device *dev);
 size_t mtk_mdp_rdma_get_num_formats(struct device *dev);

+int mtk_disp_padding_clk_enable(struct device *dev);
+void mtk_disp_padding_clk_disable(struct device *dev);
+void mtk_disp_padding_config(struct device *dev, struct cmdq_pkt *cmdq_pkt);
 #endif
diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c b/drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c
index e1d8d4765af8..5f775144e8c1 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c
@@ -27,6 +27,7 @@

 enum mtk_ovl_adaptor_comp_type {
 	OVL_ADAPTOR_TYPE_RDMA = 0,
+	OVL_ADAPTOR_TYPE_PADDING,
 	OVL_ADAPTOR_TYPE_MERGE,
 	OVL_ADAPTOR_TYPE_ETHDR,
 	OVL_ADAPTOR_TYPE_NUM,
@@ -41,6 +42,14 @@ enum mtk_ovl_adaptor_comp_id {
 	OVL_ADAPTOR_MDP_RDMA5,
 	OVL_ADAPTOR_MDP_RDMA6,
 	OVL_ADAPTOR_MDP_RDMA7,
+	OVL_ADAPTOR_DISP_PADDING0,
+	OVL_ADAPTOR_DISP_PADDING1,
+	OVL_ADAPTOR_DISP_PADDING2,
+	OVL_ADAPTOR_DISP_PADDING3,
+	OVL_ADAPTOR_DISP_PADDING4,
+	OVL_ADAPTOR_DISP_PADDING5,
+	OVL_ADAPTOR_DISP_PADDING6,
+	OVL_ADAPTOR_DISP_PADDING7,
 	OVL_ADAPTOR_MERGE0,
 	OVL_ADAPTOR_MERGE1,
 	OVL_ADAPTOR_MERGE2,
@@ -63,6 +72,7 @@ struct mtk_disp_ovl_adaptor {

 static const char * const private_comp_stem[OVL_ADAPTOR_TYPE_NUM] = {
 	[OVL_ADAPTOR_TYPE_RDMA]		= "vdo1-rdma",
+	[OVL_ADAPTOR_TYPE_PADDING]	= "vdo1-padding",
 	[OVL_ADAPTOR_TYPE_MERGE]	= "merge",
 	[OVL_ADAPTOR_TYPE_ETHDR]	= "ethdr",
 };
@@ -76,6 +86,14 @@ static const struct ovl_adaptor_comp_match comp_matches[OVL_ADAPTOR_ID_MAX] = {
 	[OVL_ADAPTOR_MDP_RDMA5] = { OVL_ADAPTOR_TYPE_RDMA, DDP_COMPONENT_MDP_RDMA5, 5 },
 	[OVL_ADAPTOR_MDP_RDMA6] = { OVL_ADAPTOR_TYPE_RDMA, DDP_COMPONENT_MDP_RDMA6, 6 },
 	[OVL_ADAPTOR_MDP_RDMA7] = { OVL_ADAPTOR_TYPE_RDMA, DDP_COMPONENT_MDP_RDMA7, 7 },
+	[OVL_ADAPTOR_DISP_PADDING0] = { OVL_ADAPTOR_TYPE_PADDING, DDP_COMPONENT_DISP_PADDING0, 0 },
+	[OVL_ADAPTOR_DISP_PADDING1] = { OVL_ADAPTOR_TYPE_PADDING, DDP_COMPONENT_DISP_PADDING1, 1 },
+	[OVL_ADAPTOR_DISP_PADDING2] = { OVL_ADAPTOR_TYPE_PADDING, DDP_COMPONENT_DISP_PADDING2, 2 },
+	[OVL_ADAPTOR_DISP_PADDING3] = { OVL_ADAPTOR_TYPE_PADDING, DDP_COMPONENT_DISP_PADDING3, 3 },
+	[OVL_ADAPTOR_DISP_PADDING4] = { OVL_ADAPTOR_TYPE_PADDING, DDP_COMPONENT_DISP_PADDING4, 4 },
+	[OVL_ADAPTOR_DISP_PADDING5] = { OVL_ADAPTOR_TYPE_PADDING, DDP_COMPONENT_DISP_PADDING5, 5 },
+	[OVL_ADAPTOR_DISP_PADDING6] = { OVL_ADAPTOR_TYPE_PADDING, DDP_COMPONENT_DISP_PADDING6, 6 },
+	[OVL_ADAPTOR_DISP_PADDING7] = { OVL_ADAPTOR_TYPE_PADDING, DDP_COMPONENT_DISP_PADDING7, 7 },
 	[OVL_ADAPTOR_MERGE0] = { OVL_ADAPTOR_TYPE_MERGE, DDP_COMPONENT_MERGE1, 1 },
 	[OVL_ADAPTOR_MERGE1] = { OVL_ADAPTOR_TYPE_MERGE, DDP_COMPONENT_MERGE2, 2 },
 	[OVL_ADAPTOR_MERGE2] = { OVL_ADAPTOR_TYPE_MERGE, DDP_COMPONENT_MERGE3, 3 },
@@ -92,6 +110,8 @@ void mtk_ovl_adaptor_layer_config(struct device *dev, unsigned int idx,
 	struct mtk_mdp_rdma_cfg rdma_config = {0};
 	struct device *rdma_l;
 	struct device *rdma_r;
+	struct device *padding_l;
+	struct device *padding_r;
 	struct device *merge;
 	struct device *ethdr;
 	const struct drm_format_info *fmt_info = drm_format_info(pending->format);
@@ -108,6 +128,8 @@ void mtk_ovl_adaptor_layer_config(struct device *dev, unsigned int idx,

 	rdma_l = ovl_adaptor->ovl_adaptor_comp[OVL_ADAPTOR_MDP_RDMA0 + 2 * idx];
 	rdma_r = ovl_adaptor->ovl_adaptor_comp[OVL_ADAPTOR_MDP_RDMA0 + 2 * idx + 1];
+	padding_l = ovl_adaptor->ovl_adaptor_comp[OVL_ADAPTOR_DISP_PADDING0 + 2 * idx];
+	padding_r = ovl_adaptor->ovl_adaptor_comp[OVL_ADAPTOR_DISP_PADDING0 + 2 * idx + 1];
 	merge = ovl_adaptor->ovl_adaptor_comp[OVL_ADAPTOR_MERGE0 + idx];
 	ethdr = ovl_adaptor->ovl_adaptor_comp[OVL_ADAPTOR_ETHDR0];

@@ -143,10 +165,15 @@ void mtk_ovl_adaptor_layer_config(struct device *dev, unsigned int idx,
 	rdma_config.color_encoding = pending->color_encoding;
 	mtk_mdp_rdma_config(rdma_l, &rdma_config, cmdq_pkt);

+	if (padding_l)
+		mtk_disp_padding_config(padding_l, cmdq_pkt);
+
 	if (use_dual_pipe) {
 		rdma_config.x_left = l_w;
 		rdma_config.width = r_w;
 		mtk_mdp_rdma_config(rdma_r, &rdma_config, cmdq_pkt);
+		if (padding_r)
+			mtk_disp_padding_config(padding_r, cmdq_pkt);
 	}

 	mtk_merge_start_cmdq(merge, cmdq_pkt);
@@ -206,8 +233,10 @@ int mtk_ovl_adaptor_clk_enable(struct device *dev)
 		comp = ovl_adaptor->ovl_adaptor_comp[i];
 		if (!comp)
 			continue;
-		if (i < OVL_ADAPTOR_MERGE0)
+		if (i < OVL_ADAPTOR_DISP_PADDING0)
 			ret = mtk_mdp_rdma_clk_enable(comp);
+		else if (i < OVL_ADAPTOR_MERGE0)
+			ret = mtk_disp_padding_clk_enable(comp);
 		else if (i < OVL_ADAPTOR_ETHDR0)
 			ret = mtk_merge_clk_enable(comp);
 		else
@@ -225,8 +254,10 @@ int mtk_ovl_adaptor_clk_enable(struct device *dev)
 		comp = ovl_adaptor->ovl_adaptor_comp[i];
 		if (!comp)
 			continue;
-		if (i < OVL_ADAPTOR_MERGE0)
+		if (i < OVL_ADAPTOR_DISP_PADDING0)
 			mtk_mdp_rdma_clk_disable(comp);
+		else if (i < OVL_ADAPTOR_MERGE0)
+			mtk_disp_padding_clk_disable(comp);
 		else if (i < OVL_ADAPTOR_ETHDR0)
 			mtk_merge_clk_disable(comp);
 		else
@@ -255,9 +286,12 @@ void mtk_ovl_adaptor_clk_disable(struct device *dev)
 		comp = ovl_adaptor->ovl_adaptor_comp[i];
 		if (!comp)
 			continue;
-		if (i < OVL_ADAPTOR_MERGE0) {
+		if (i < OVL_ADAPTOR_DISP_PADDING0) {
 			mtk_mdp_rdma_clk_disable(comp);
 			pm_runtime_put(comp);
+		} else if (i < OVL_ADAPTOR_MERGE0) {
+			mtk_disp_padding_clk_disable(comp);
+			pm_runtime_put(comp);
 		} else if (i < OVL_ADAPTOR_ETHDR0) {
 			mtk_merge_clk_disable(comp);
 		} else {
@@ -389,6 +423,9 @@ static const struct of_device_id mtk_ovl_adaptor_comp_dt_ids[] = {
 	{
 		.compatible = "mediatek,mt8188-vdo1-rdma",
 		.data = (void *)OVL_ADAPTOR_TYPE_RDMA,
+	}, {
+		.compatible = "mediatek,mt8188-vdo1-padding",
+		.data = (void *)OVL_ADAPTOR_TYPE_PADDING,
 	}, {
 		.compatible = "mediatek,mt8188-disp-merge",
 		.data = (void *)OVL_ADAPTOR_TYPE_MERGE,
diff --git a/drivers/gpu/drm/mediatek/mtk_disp_padding.c b/drivers/gpu/drm/mediatek/mtk_disp_padding.c
new file mode 100644
index 000000000000..5722aa57d628
--- /dev/null
+++ b/drivers/gpu/drm/mediatek/mtk_disp_padding.c
@@ -0,0 +1,134 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2022 MediaTek Inc.
+ */
+
+#include <linux/clk.h>
+#include <linux/component.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/of_irq.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/soc/mediatek/mtk-cmdq.h>
+
+#include "mtk_disp_drv.h"
+#include "mtk_drm_crtc.h"
+#include "mtk_drm_ddp_comp.h"
+
+/*
+ * struct mtk_disp_padding - DISP_RDMA driver structure
+ * @data: local driver data
+ */
+struct mtk_disp_padding {
+	struct clk		*clk;
+	void __iomem		*regs;
+	struct cmdq_client_reg	cmdq_reg;
+};
+
+static int mtk_disp_padding_bind(struct device *dev, struct device *master,
+				 void *data)
+{
+	return 0;
+}
+
+static void mtk_disp_padding_unbind(struct device *dev, struct device *master,
+				    void *data)
+{
+}
+
+static const struct component_ops mtk_disp_padding_component_ops = {
+	.bind	= mtk_disp_padding_bind,
+	.unbind = mtk_disp_padding_unbind,
+};
+
+static int mtk_disp_padding_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct mtk_disp_padding *priv;
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
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	priv->regs = devm_ioremap_resource(dev, res);
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
+	pm_runtime_enable(dev);
+
+	ret = component_add(dev, &mtk_disp_padding_component_ops);
+	if (ret) {
+		pm_runtime_disable(dev);
+		dev_err(dev, "failed to add component: %d\n", ret);
+	}
+
+	return ret;
+}
+
+static int mtk_disp_padding_remove(struct platform_device *pdev)
+{
+	component_del(&pdev->dev, &mtk_disp_padding_component_ops);
+	pm_runtime_disable(&pdev->dev);
+	return 0;
+}
+
+static const struct of_device_id mtk_disp_padding_driver_dt_match[] = {
+	{ .compatible = "mediatek,mt8188-vdo1-padding" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, mtk_disp_padding_driver_dt_match);
+
+struct platform_driver mtk_disp_padding_driver = {
+	.probe		= mtk_disp_padding_probe,
+	.remove		= mtk_disp_padding_remove,
+	.driver		= {
+		.name	= "mediatek-disp-padding",
+		.owner	= THIS_MODULE,
+		.of_match_table = mtk_disp_padding_driver_dt_match,
+	},
+};
+
+int mtk_disp_padding_clk_enable(struct device *dev)
+{
+	struct mtk_disp_padding *padding = dev_get_drvdata(dev);
+
+	return clk_prepare_enable(padding->clk);
+}
+
+void mtk_disp_padding_clk_disable(struct device *dev)
+{
+	struct mtk_disp_padding *padding = dev_get_drvdata(dev);
+
+	clk_disable_unprepare(padding->clk);
+}
+
+void mtk_disp_padding_config(struct device *dev, struct cmdq_pkt *cmdq_pkt)
+{
+	struct mtk_disp_padding *padding = dev_get_drvdata(dev);
+
+	// bypass padding
+	mtk_ddp_write_mask(cmdq_pkt,
+			   0b11, &padding->cmdq_reg, padding->regs, 0, 0b11);
+}
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
index febcaeef16a1..d8145a99fb94 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
+++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
@@ -32,6 +32,7 @@ enum mtk_ddp_comp_type {
 	MTK_DISP_OVL,
 	MTK_DISP_OVL_2L,
 	MTK_DISP_OVL_ADAPTOR,
+	MTK_DISP_PADDING,
 	MTK_DISP_POSTMASK,
 	MTK_DISP_PWM,
 	MTK_DISP_RDMA,
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
index 87dadd129c22..1c912bf43c35 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -985,6 +985,7 @@ static struct platform_driver * const mtk_drm_drivers[] = {
 	&mtk_disp_gamma_driver,
 	&mtk_disp_rdma_driver,
 	&mtk_mdp_rdma_driver,
+	&mtk_disp_padding_driver,
 	&mtk_disp_merge_driver,
 	&mtk_ethdr_driver,
 	&mtk_disp_ovl_driver,
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.h b/drivers/gpu/drm/mediatek/mtk_drm_drv.h
index eb2fd45941f0..cb89d2c30019 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.h
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.h
@@ -64,5 +64,5 @@ extern struct platform_driver mtk_dpi_driver;
 extern struct platform_driver mtk_dsi_driver;
 extern struct platform_driver mtk_ethdr_driver;
 extern struct platform_driver mtk_mdp_rdma_driver;
-
+extern struct platform_driver mtk_disp_padding_driver;
 #endif /* MTK_DRM_DRV_H */
--
2.18.0

