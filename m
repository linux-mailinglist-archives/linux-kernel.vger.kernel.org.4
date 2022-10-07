Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 173DB5F770E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 12:49:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbiJGKtU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 06:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbiJGKtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 06:49:05 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E8A1120EF9;
        Fri,  7 Oct 2022 03:48:49 -0700 (PDT)
X-UUID: d6dc502f9baf4e91b7769e4f8bae546d-20221007
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=eKuV/YyHFF6x61EVErbSHpFhS8jnoJmyHr3AxQ6UhJk=;
        b=rta1tMkmoHOW8Z51/njowRBt+KqYxYTQPOIfpWxyOuIswinDalXYE6qC4q2nUL09Nk3QLPZ4Ju1H9jloPyukpoXA7tW7dNYT0xg2jZh267xYxYlh7Slh2rKP36j0vdqXFJeur33yKPqT/m7t8E9cOF6ihNb6P6UBdAe+GCooTxE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:4b3d6369-5baa-4faf-a32e-c10603541ec1,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-25
X-CID-META: VersionHash:39a5ff1,CLOUDID:c22193fe-ee8c-4ff7-afe9-644435e96625,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:1
X-UUID: d6dc502f9baf4e91b7769e4f8bae546d-20221007
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 811057219; Fri, 07 Oct 2022 18:48:44 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Fri, 7 Oct 2022 18:48:43 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Fri, 7 Oct 2022 18:48:43 +0800
From:   Bo-Chen Chen <rex-bc.chen@mediatek.com>
To:     <sboyd@kernel.org>, <mturquette@baylibre.com>,
        <matthias.bgg@gmail.com>, <p.zabel@pengutronix.de>
CC:     <runyang.chen@mediatek.com>, <miles.chen@mediatek.com>,
        <wenst@chromium.org>, <angelogioacchino.delregno@collabora.com>,
        <nfraprado@collabora.com>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Bo-Chen Chen <rex-bc.chen@mediatek.com>
Subject: [PATCH v5] reset: mediatek: Move mediatek system clock reset to reset folder
Date:   Fri, 7 Oct 2022 18:48:42 +0800
Message-ID: <20221007104842.13164-1-rex-bc.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_CSS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To manager mediatek system clock reset easier, we move the driver to
drivers/reset.

- Create reset/mediatek folder.
- Move clk/mediatek/reset.c to reset/mediatek/reset-mediatek-sysclk.c
- Because we don't want to build in unsed static variable (For example,
  if we use mt8186, we don't want to build in the variable of MT8195.),
  we use clk KConfig to do this.
- Move reset data which are scattered around the mediatek drivers to
  reset-mtxxxx.c.
- For mtk clk drivers which support device, we can ues
  mtk_reset_controller_register() to register reset controller using
  auxiliary bus.
- For mtk clk drivers which do not support device (only support
  device_node), we use mtk_reset_{init/remove}_with_node to register
  reset controller.

Signed-off-by: Bo-Chen Chen <rex-bc.chen@mediatek.com>
---
Changes for v5:
1. Replace reset-mtxxxx.h with reset-mtxxxx.c and after using this, we don't need to
   add many "#if #endif" in reset-mediatek-sysclk.c.
2. Use mediatek clock common KConfig to control whether to build in reset-mtxxxx.c.
3. Rebased on linux-next-1007.

Changes for v4:
1. Rebased oo linux-next-1004.
2. Move reset data which are scattered around the mediatek drivers to reset-mtxxxx.h.
3. Add reset data of mt6795.

Version for this series:
v4 : https://lore.kernel.org/all/20221005051145.29676-1-rex-bc.chen@mediatek.com/
v3 : https://lore.kernel.org/all/20220929121031.17523-1-rex-bc.chen@mediatek.com/
v2 : https://lore.kernel.org/all/20220923045738.2027-1-rex-bc.chen@mediatek.com/
v1 : https://lore.kernel.org/all/20220922141107.10203-1-rex-bc.chen@mediatek.com/
RFC: https://lore.kernel.org/all/20220527090355.7354-1-rex-bc.chen@mediatek.com/
---
 drivers/clk/mediatek/Kconfig                  |   2 +
 drivers/clk/mediatek/Makefile                 |   2 +-
 drivers/clk/mediatek/clk-mt2701-eth.c         |  10 +-
 drivers/clk/mediatek/clk-mt2701-g3d.c         |  10 +-
 drivers/clk/mediatek/clk-mt2701-hif.c         |  10 +-
 drivers/clk/mediatek/clk-mt2701.c             |  22 +-
 drivers/clk/mediatek/clk-mt2712.c             |  22 +-
 drivers/clk/mediatek/clk-mt6795-infracfg.c    |  22 +-
 drivers/clk/mediatek/clk-mt6795-pericfg.c     |  20 +-
 drivers/clk/mediatek/clk-mt7622-eth.c         |  10 +-
 drivers/clk/mediatek/clk-mt7622-hif.c         |  12 +-
 drivers/clk/mediatek/clk-mt7622.c             |  22 +-
 drivers/clk/mediatek/clk-mt7629-eth.c         |  10 +-
 drivers/clk/mediatek/clk-mt7629-hif.c         |  12 +-
 drivers/clk/mediatek/clk-mt8135.c             |  23 +-
 drivers/clk/mediatek/clk-mt8173.c             |  22 +-
 drivers/clk/mediatek/clk-mt8183.c             |  15 +-
 drivers/clk/mediatek/clk-mt8186-infra_ao.c    |  23 +-
 drivers/clk/mediatek/clk-mt8192.c             |  27 +-
 drivers/clk/mediatek/clk-mt8195-infra_ao.c    |  28 +-
 drivers/clk/mediatek/clk-mtk.c                |  62 ++-
 drivers/clk/mediatek/clk-mtk.h                |   8 +-
 drivers/clk/mediatek/reset.c                  | 233 -----------
 drivers/reset/Kconfig                         |   1 +
 drivers/reset/Makefile                        |   1 +
 drivers/reset/mediatek/Kconfig                |   6 +
 drivers/reset/mediatek/Makefile               |  13 +
 .../reset/mediatek/reset-mediatek-sysclk.c    | 389 ++++++++++++++++++
 drivers/reset/mediatek/reset-mt2701.c         | 102 +++++
 drivers/reset/mediatek/reset-mt2712.c         |  42 ++
 drivers/reset/mediatek/reset-mt6795.c         |  61 +++
 drivers/reset/mediatek/reset-mt7622.c         |  91 ++++
 drivers/reset/mediatek/reset-mt7629.c         |  62 +++
 drivers/reset/mediatek/reset-mt8135.c         |  43 ++
 drivers/reset/mediatek/reset-mt8173.c         |  43 ++
 drivers/reset/mediatek/reset-mt8183.c         |  31 ++
 drivers/reset/mediatek/reset-mt8186.c         |  39 ++
 drivers/reset/mediatek/reset-mt8192.c         |  43 ++
 drivers/reset/mediatek/reset-mt8195.c         |  44 ++
 .../linux/reset/reset-mediatek-sysclk.h       |  61 +--
 40 files changed, 1142 insertions(+), 557 deletions(-)
 delete mode 100644 drivers/clk/mediatek/reset.c
 create mode 100644 drivers/reset/mediatek/Kconfig
 create mode 100644 drivers/reset/mediatek/Makefile
 create mode 100644 drivers/reset/mediatek/reset-mediatek-sysclk.c
 create mode 100644 drivers/reset/mediatek/reset-mt2701.c
 create mode 100644 drivers/reset/mediatek/reset-mt2712.c
 create mode 100644 drivers/reset/mediatek/reset-mt6795.c
 create mode 100644 drivers/reset/mediatek/reset-mt7622.c
 create mode 100644 drivers/reset/mediatek/reset-mt7629.c
 create mode 100644 drivers/reset/mediatek/reset-mt8135.c
 create mode 100644 drivers/reset/mediatek/reset-mt8173.c
 create mode 100644 drivers/reset/mediatek/reset-mt8183.c
 create mode 100644 drivers/reset/mediatek/reset-mt8186.c
 create mode 100644 drivers/reset/mediatek/reset-mt8192.c
 create mode 100644 drivers/reset/mediatek/reset-mt8195.c
 rename drivers/clk/mediatek/reset.h => include/linux/reset/reset-mediatek-sysclk.h (60%)

diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
index 843cea0c7a44..bcd073ada0e9 100644
--- a/drivers/clk/mediatek/Kconfig
+++ b/drivers/clk/mediatek/Kconfig
@@ -8,6 +8,8 @@ menu "Clock driver for MediaTek SoC"
 config COMMON_CLK_MEDIATEK
 	tristate
 	select RESET_CONTROLLER
+	select RESET_MEDIATEK_SYSCLK
+	select AUXILIARY_BUS
 	help
 	  MediaTek SoCs' clock support.
 
diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
index ea3b73240303..494bc8e17c5e 100644
--- a/drivers/clk/mediatek/Makefile
+++ b/drivers/clk/mediatek/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-obj-$(CONFIG_COMMON_CLK_MEDIATEK) += clk-mtk.o clk-pll.o clk-gate.o clk-apmixed.o clk-cpumux.o reset.o clk-mux.o
+obj-$(CONFIG_COMMON_CLK_MEDIATEK) += clk-mtk.o clk-pll.o clk-gate.o clk-apmixed.o clk-cpumux.o clk-mux.o
 
 obj-$(CONFIG_COMMON_CLK_MT6765) += clk-mt6765.o
 obj-$(CONFIG_COMMON_CLK_MT6765_AUDIOSYS) += clk-mt6765-audio.o
diff --git a/drivers/clk/mediatek/clk-mt2701-eth.c b/drivers/clk/mediatek/clk-mt2701-eth.c
index edf1e2ed2b59..2da95232e529 100644
--- a/drivers/clk/mediatek/clk-mt2701-eth.c
+++ b/drivers/clk/mediatek/clk-mt2701-eth.c
@@ -36,14 +36,6 @@ static const struct mtk_gate eth_clks[] = {
 	GATE_ETH(CLK_ETHSYS_CRYPTO, "crypto_clk", "ethif_sel", 29),
 };
 
-static u16 rst_ofs[] = { 0x34, };
-
-static const struct mtk_clk_rst_desc clk_rst_desc = {
-	.version = MTK_RST_SIMPLE,
-	.rst_bank_ofs = rst_ofs,
-	.rst_bank_nr = ARRAY_SIZE(rst_ofs),
-};
-
 static const struct of_device_id of_match_clk_mt2701_eth[] = {
 	{ .compatible = "mediatek,mt2701-ethsys", },
 	{}
@@ -66,7 +58,7 @@ static int clk_mt2701_eth_probe(struct platform_device *pdev)
 			"could not register clock provider: %s: %d\n",
 			pdev->name, r);
 
-	mtk_register_reset_controller_with_dev(&pdev->dev, &clk_rst_desc);
+	mtk_reset_controller_register(&pdev->dev, "mt2701-eth-rst");
 
 	return r;
 }
diff --git a/drivers/clk/mediatek/clk-mt2701-g3d.c b/drivers/clk/mediatek/clk-mt2701-g3d.c
index 1458109d99d9..da43c422d452 100644
--- a/drivers/clk/mediatek/clk-mt2701-g3d.c
+++ b/drivers/clk/mediatek/clk-mt2701-g3d.c
@@ -35,14 +35,6 @@ static const struct mtk_gate g3d_clks[] = {
 	GATE_G3D(CLK_G3DSYS_CORE, "g3d_core", "mfg_sel", 0),
 };
 
-static u16 rst_ofs[] = { 0xc, };
-
-static const struct mtk_clk_rst_desc clk_rst_desc = {
-	.version = MTK_RST_SIMPLE,
-	.rst_bank_ofs = rst_ofs,
-	.rst_bank_nr = ARRAY_SIZE(rst_ofs),
-};
-
 static int clk_mt2701_g3dsys_init(struct platform_device *pdev)
 {
 	struct clk_hw_onecell_data *clk_data;
@@ -60,7 +52,7 @@ static int clk_mt2701_g3dsys_init(struct platform_device *pdev)
 			"could not register clock provider: %s: %d\n",
 			pdev->name, r);
 
-	mtk_register_reset_controller_with_dev(&pdev->dev, &clk_rst_desc);
+	mtk_reset_controller_register(&pdev->dev, "mt2701-g3d-rst");
 
 	return r;
 }
diff --git a/drivers/clk/mediatek/clk-mt2701-hif.c b/drivers/clk/mediatek/clk-mt2701-hif.c
index 434cbbe8c037..2ecccf8fe16e 100644
--- a/drivers/clk/mediatek/clk-mt2701-hif.c
+++ b/drivers/clk/mediatek/clk-mt2701-hif.c
@@ -33,14 +33,6 @@ static const struct mtk_gate hif_clks[] = {
 	GATE_HIF(CLK_HIFSYS_PCIE2, "pcie2_clk", "ethpll_500m_ck", 26),
 };
 
-static u16 rst_ofs[] = { 0x34, };
-
-static const struct mtk_clk_rst_desc clk_rst_desc = {
-	.version = MTK_RST_SIMPLE,
-	.rst_bank_ofs = rst_ofs,
-	.rst_bank_nr = ARRAY_SIZE(rst_ofs),
-};
-
 static const struct of_device_id of_match_clk_mt2701_hif[] = {
 	{ .compatible = "mediatek,mt2701-hifsys", },
 	{}
@@ -65,7 +57,7 @@ static int clk_mt2701_hif_probe(struct platform_device *pdev)
 		return r;
 	}
 
-	mtk_register_reset_controller_with_dev(&pdev->dev, &clk_rst_desc);
+	mtk_reset_controller_register(&pdev->dev, "mt2701-hif-rst");
 
 	return 0;
 }
diff --git a/drivers/clk/mediatek/clk-mt2701.c b/drivers/clk/mediatek/clk-mt2701.c
index 9b442af37e67..b90f611a5b52 100644
--- a/drivers/clk/mediatek/clk-mt2701.c
+++ b/drivers/clk/mediatek/clk-mt2701.c
@@ -735,24 +735,6 @@ static const struct mtk_fixed_factor infra_fixed_divs[] = {
 	FACTOR(CLK_INFRA_CLK_13M, "clk13m", "clk26m", 1, 2),
 };
 
-static u16 infrasys_rst_ofs[] = { 0x30, 0x34, };
-static u16 pericfg_rst_ofs[] = { 0x0, 0x4, };
-
-static const struct mtk_clk_rst_desc clk_rst_desc[] = {
-	/* infrasys */
-	{
-		.version = MTK_RST_SIMPLE,
-		.rst_bank_ofs = infrasys_rst_ofs,
-		.rst_bank_nr = ARRAY_SIZE(infrasys_rst_ofs),
-	},
-	/* pericfg */
-	{
-		.version = MTK_RST_SIMPLE,
-		.rst_bank_ofs = pericfg_rst_ofs,
-		.rst_bank_nr = ARRAY_SIZE(pericfg_rst_ofs),
-	},
-};
-
 static struct clk_hw_onecell_data *infra_clk_data;
 
 static void __init mtk_infrasys_init_early(struct device_node *node)
@@ -805,7 +787,7 @@ static int mtk_infrasys_init(struct platform_device *pdev)
 	if (r)
 		return r;
 
-	mtk_register_reset_controller_with_dev(&pdev->dev, &clk_rst_desc[0]);
+	mtk_reset_controller_register(&pdev->dev, "mt2701-infrasys-rst");
 
 	return 0;
 }
@@ -928,7 +910,7 @@ static int mtk_pericfg_init(struct platform_device *pdev)
 	if (r)
 		return r;
 
-	mtk_register_reset_controller_with_dev(&pdev->dev, &clk_rst_desc[1]);
+	mtk_reset_controller_register(&pdev->dev, "mt2701-pericfg-rst");
 
 	return 0;
 }
diff --git a/drivers/clk/mediatek/clk-mt2712.c b/drivers/clk/mediatek/clk-mt2712.c
index 56980dd6c2ea..bada923b60cf 100644
--- a/drivers/clk/mediatek/clk-mt2712.c
+++ b/drivers/clk/mediatek/clk-mt2712.c
@@ -1258,24 +1258,6 @@ static const struct mtk_pll_data plls[] = {
 		0, 31, 0x0300, 4, 0, 0, 0, 0x0304, 0),
 };
 
-static u16 infrasys_rst_ofs[] = { 0x30, 0x34, };
-static u16 pericfg_rst_ofs[] = { 0x0, 0x4, };
-
-static const struct mtk_clk_rst_desc clk_rst_desc[] = {
-	/* infra */
-	{
-		.version = MTK_RST_SIMPLE,
-		.rst_bank_ofs = infrasys_rst_ofs,
-		.rst_bank_nr = ARRAY_SIZE(infrasys_rst_ofs),
-	},
-	/* peri */
-	{
-		.version = MTK_RST_SIMPLE,
-		.rst_bank_ofs = pericfg_rst_ofs,
-		.rst_bank_nr = ARRAY_SIZE(pericfg_rst_ofs),
-	},
-};
-
 static int clk_mt2712_apmixed_probe(struct platform_device *pdev)
 {
 	struct clk_hw_onecell_data *clk_data;
@@ -1379,7 +1361,7 @@ static int clk_mt2712_infra_probe(struct platform_device *pdev)
 		pr_err("%s(): could not register clock provider: %d\n",
 			__func__, r);
 
-	mtk_register_reset_controller_with_dev(&pdev->dev, &clk_rst_desc[0]);
+	mtk_reset_controller_register(&pdev->dev, "mt2712-infra-rst");
 
 	return r;
 }
@@ -1401,7 +1383,7 @@ static int clk_mt2712_peri_probe(struct platform_device *pdev)
 		pr_err("%s(): could not register clock provider: %d\n",
 			__func__, r);
 
-	mtk_register_reset_controller_with_dev(&pdev->dev, &clk_rst_desc[1]);
+	mtk_reset_controller_register(&pdev->dev, "mt2712-peri-rst");
 
 	return r;
 }
diff --git a/drivers/clk/mediatek/clk-mt6795-infracfg.c b/drivers/clk/mediatek/clk-mt6795-infracfg.c
index df7eed6e071e..725d17f95ed4 100644
--- a/drivers/clk/mediatek/clk-mt6795-infracfg.c
+++ b/drivers/clk/mediatek/clk-mt6795-infracfg.c
@@ -5,13 +5,11 @@
  */
 
 #include <dt-bindings/clock/mediatek,mt6795-clk.h>
-#include <dt-bindings/reset/mediatek,mt6795-resets.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include "clk-cpumux.h"
 #include "clk-gate.h"
 #include "clk-mtk.h"
-#include "reset.h"
 
 #define GATE_ICG(_id, _name, _parent, _shift)			\
 		GATE_MTK(_id, _name, _parent, &infra_cg_regs,	\
@@ -59,24 +57,6 @@ static const struct mtk_gate infra_gates[] = {
 	GATE_ICG(CLK_INFRA_KP, "infra_kp", "axi_sel", 16),
 };
 
-static u16 infra_ao_rst_ofs[] = { 0x30, 0x34 };
-
-static u16 infra_ao_idx_map[] = {
-	[MT6795_INFRA_RST0_SCPSYS_RST]    = 0 * RST_NR_PER_BANK + 5,
-	[MT6795_INFRA_RST0_PMIC_WRAP_RST] = 0 * RST_NR_PER_BANK + 7,
-	[MT6795_INFRA_RST1_MIPI_DSI_RST]  = 1 * RST_NR_PER_BANK + 4,
-	[MT6795_INFRA_RST1_MIPI_CSI_RST]  = 1 * RST_NR_PER_BANK + 7,
-	[MT6795_INFRA_RST1_MM_IOMMU_RST]  = 1 * RST_NR_PER_BANK + 15,
-};
-
-static const struct mtk_clk_rst_desc clk_rst_desc = {
-	.version = MTK_RST_SET_CLR,
-	.rst_bank_ofs = infra_ao_rst_ofs,
-	.rst_bank_nr = ARRAY_SIZE(infra_ao_rst_ofs),
-	.rst_idx_map = infra_ao_idx_map,
-	.rst_idx_map_nr = ARRAY_SIZE(infra_ao_idx_map),
-};
-
 static const struct of_device_id of_match_clk_mt6795_infracfg[] = {
 	{ .compatible = "mediatek,mt6795-infracfg" },
 	{ /* sentinel */ }
@@ -97,7 +77,7 @@ static int clk_mt6795_infracfg_probe(struct platform_device *pdev)
 	if (!clk_data)
 		return -ENOMEM;
 
-	ret = mtk_register_reset_controller_with_dev(&pdev->dev, &clk_rst_desc);
+	ret = mtk_reset_controller_register(&pdev->dev, "mt6795-ifa");
 	if (ret)
 		goto free_clk_data;
 
diff --git a/drivers/clk/mediatek/clk-mt6795-pericfg.c b/drivers/clk/mediatek/clk-mt6795-pericfg.c
index cb28d35dad59..db02e513d9f6 100644
--- a/drivers/clk/mediatek/clk-mt6795-pericfg.c
+++ b/drivers/clk/mediatek/clk-mt6795-pericfg.c
@@ -5,12 +5,10 @@
  */
 
 #include <dt-bindings/clock/mediatek,mt6795-clk.h>
-#include <dt-bindings/reset/mediatek,mt6795-resets.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include "clk-gate.h"
 #include "clk-mtk.h"
-#include "reset.h"
 
 #define GATE_PERI(_id, _name, _parent, _shift)			\
 		GATE_MTK(_id, _name, _parent, &peri_cg_regs,	\
@@ -69,22 +67,6 @@ static const struct mtk_gate peri_gates[] = {
 	GATE_PERI(CLK_PERI_SPI0, "peri_spi0", "spi_sel", 29),
 };
 
-static u16 peri_rst_ofs[] = { 0x0 };
-
-static u16 peri_idx_map[] = {
-	[MT6795_PERI_NFI_SW_RST]   = 14,
-	[MT6795_PERI_THERM_SW_RST] = 16,
-	[MT6795_PERI_MSDC1_SW_RST] = 20,
-};
-
-static const struct mtk_clk_rst_desc clk_rst_desc = {
-	.version = MTK_RST_SIMPLE,
-	.rst_bank_ofs = peri_rst_ofs,
-	.rst_bank_nr = ARRAY_SIZE(peri_rst_ofs),
-	.rst_idx_map = peri_idx_map,
-	.rst_idx_map_nr = ARRAY_SIZE(peri_idx_map),
-};
-
 static const struct of_device_id of_match_clk_mt6795_pericfg[] = {
 	{ .compatible = "mediatek,mt6795-pericfg" },
 	{ /* sentinel */ }
@@ -105,7 +87,7 @@ static int clk_mt6795_pericfg_probe(struct platform_device *pdev)
 	if (!clk_data)
 		return -ENOMEM;
 
-	ret = mtk_register_reset_controller_with_dev(&pdev->dev, &clk_rst_desc);
+	ret = mtk_reset_controller_register(&pdev->dev, "mt6795-peri");
 	if (ret)
 		goto free_clk_data;
 
diff --git a/drivers/clk/mediatek/clk-mt7622-eth.c b/drivers/clk/mediatek/clk-mt7622-eth.c
index 43de0477d5d9..2e668ed78cd5 100644
--- a/drivers/clk/mediatek/clk-mt7622-eth.c
+++ b/drivers/clk/mediatek/clk-mt7622-eth.c
@@ -65,14 +65,6 @@ static const struct mtk_gate sgmii_clks[] = {
 		   "ssusb_cdr_fb", 5),
 };
 
-static u16 rst_ofs[] = { 0x34, };
-
-static const struct mtk_clk_rst_desc clk_rst_desc = {
-	.version = MTK_RST_SIMPLE,
-	.rst_bank_ofs = rst_ofs,
-	.rst_bank_nr = ARRAY_SIZE(rst_ofs),
-};
-
 static int clk_mt7622_ethsys_init(struct platform_device *pdev)
 {
 	struct clk_hw_onecell_data *clk_data;
@@ -90,7 +82,7 @@ static int clk_mt7622_ethsys_init(struct platform_device *pdev)
 			"could not register clock provider: %s: %d\n",
 			pdev->name, r);
 
-	mtk_register_reset_controller_with_dev(&pdev->dev, &clk_rst_desc);
+	mtk_reset_controller_register(&pdev->dev, "mt7622-eth-rst");
 
 	return r;
 }
diff --git a/drivers/clk/mediatek/clk-mt7622-hif.c b/drivers/clk/mediatek/clk-mt7622-hif.c
index 67e96231dd25..0335d84b0043 100644
--- a/drivers/clk/mediatek/clk-mt7622-hif.c
+++ b/drivers/clk/mediatek/clk-mt7622-hif.c
@@ -76,14 +76,6 @@ static const struct mtk_gate pcie_clks[] = {
 	GATE_PCIE(CLK_SATA_PM_EN, "sata_pm_en", "univpll2_d4", 30),
 };
 
-static u16 rst_ofs[] = { 0x34, };
-
-static const struct mtk_clk_rst_desc clk_rst_desc = {
-	.version = MTK_RST_SIMPLE,
-	.rst_bank_ofs = rst_ofs,
-	.rst_bank_nr = ARRAY_SIZE(rst_ofs),
-};
-
 static int clk_mt7622_ssusbsys_init(struct platform_device *pdev)
 {
 	struct clk_hw_onecell_data *clk_data;
@@ -101,7 +93,7 @@ static int clk_mt7622_ssusbsys_init(struct platform_device *pdev)
 			"could not register clock provider: %s: %d\n",
 			pdev->name, r);
 
-	mtk_register_reset_controller_with_dev(&pdev->dev, &clk_rst_desc);
+	mtk_reset_controller_register(&pdev->dev, "mt7622-usb-rst");
 
 	return r;
 }
@@ -123,7 +115,7 @@ static int clk_mt7622_pciesys_init(struct platform_device *pdev)
 			"could not register clock provider: %s: %d\n",
 			pdev->name, r);
 
-	mtk_register_reset_controller_with_dev(&pdev->dev, &clk_rst_desc);
+	mtk_reset_controller_register(&pdev->dev, "mt7622-pcie-rst");
 
 	return r;
 }
diff --git a/drivers/clk/mediatek/clk-mt7622.c b/drivers/clk/mediatek/clk-mt7622.c
index 3b55f8641fae..ea4c21b9a6a0 100644
--- a/drivers/clk/mediatek/clk-mt7622.c
+++ b/drivers/clk/mediatek/clk-mt7622.c
@@ -610,24 +610,6 @@ static struct mtk_composite peri_muxes[] = {
 	MUX(CLK_PERIBUS_SEL, "peribus_ck_sel", peribus_ck_parents, 0x05C, 0, 1),
 };
 
-static u16 infrasys_rst_ofs[] = { 0x30, };
-static u16 pericfg_rst_ofs[] = { 0x0, 0x4, };
-
-static const struct mtk_clk_rst_desc clk_rst_desc[] = {
-	/* infrasys */
-	{
-		.version = MTK_RST_SIMPLE,
-		.rst_bank_ofs = infrasys_rst_ofs,
-		.rst_bank_nr = ARRAY_SIZE(infrasys_rst_ofs),
-	},
-	/* pericfg */
-	{
-		.version = MTK_RST_SIMPLE,
-		.rst_bank_ofs = pericfg_rst_ofs,
-		.rst_bank_nr = ARRAY_SIZE(pericfg_rst_ofs),
-	},
-};
-
 static int mtk_topckgen_init(struct platform_device *pdev)
 {
 	struct clk_hw_onecell_data *clk_data;
@@ -681,7 +663,7 @@ static int mtk_infrasys_init(struct platform_device *pdev)
 	if (r)
 		return r;
 
-	mtk_register_reset_controller_with_dev(&pdev->dev, &clk_rst_desc[0]);
+	mtk_reset_controller_register(&pdev->dev, "mt7622-infrasys-rst");
 
 	return 0;
 }
@@ -732,7 +714,7 @@ static int mtk_pericfg_init(struct platform_device *pdev)
 
 	clk_prepare_enable(clk_data->hws[CLK_PERI_UART0_PD]->clk);
 
-	mtk_register_reset_controller_with_dev(&pdev->dev, &clk_rst_desc[1]);
+	mtk_reset_controller_register(&pdev->dev, "mt7622-pericfg-rst");
 
 	return 0;
 }
diff --git a/drivers/clk/mediatek/clk-mt7629-eth.c b/drivers/clk/mediatek/clk-mt7629-eth.c
index 282dd6559465..dadc76da899b 100644
--- a/drivers/clk/mediatek/clk-mt7629-eth.c
+++ b/drivers/clk/mediatek/clk-mt7629-eth.c
@@ -76,14 +76,6 @@ static const struct mtk_gate sgmii_clks[2][4] = {
 	}
 };
 
-static u16 rst_ofs[] = { 0x34, };
-
-static const struct mtk_clk_rst_desc clk_rst_desc = {
-	.version = MTK_RST_SIMPLE,
-	.rst_bank_ofs = rst_ofs,
-	.rst_bank_nr = ARRAY_SIZE(rst_ofs),
-};
-
 static int clk_mt7629_ethsys_init(struct platform_device *pdev)
 {
 	struct clk_hw_onecell_data *clk_data;
@@ -100,7 +92,7 @@ static int clk_mt7629_ethsys_init(struct platform_device *pdev)
 			"could not register clock provider: %s: %d\n",
 			pdev->name, r);
 
-	mtk_register_reset_controller_with_dev(&pdev->dev, &clk_rst_desc);
+	mtk_reset_controller_register(&pdev->dev, "mt7629-ethsys-rst");
 
 	return r;
 }
diff --git a/drivers/clk/mediatek/clk-mt7629-hif.c b/drivers/clk/mediatek/clk-mt7629-hif.c
index 0c8b9e139789..bd6fdfd97504 100644
--- a/drivers/clk/mediatek/clk-mt7629-hif.c
+++ b/drivers/clk/mediatek/clk-mt7629-hif.c
@@ -71,14 +71,6 @@ static const struct mtk_gate pcie_clks[] = {
 	GATE_PCIE(CLK_PCIE_P0_PIPE_EN, "pcie_p0_pipe_en", "pcie0_pipe_en", 23),
 };
 
-static u16 rst_ofs[] = { 0x34, };
-
-static const struct mtk_clk_rst_desc clk_rst_desc = {
-	.version = MTK_RST_SIMPLE,
-	.rst_bank_ofs = rst_ofs,
-	.rst_bank_nr = ARRAY_SIZE(rst_ofs),
-};
-
 static int clk_mt7629_ssusbsys_init(struct platform_device *pdev)
 {
 	struct clk_hw_onecell_data *clk_data;
@@ -96,7 +88,7 @@ static int clk_mt7629_ssusbsys_init(struct platform_device *pdev)
 			"could not register clock provider: %s: %d\n",
 			pdev->name, r);
 
-	mtk_register_reset_controller_with_dev(&pdev->dev, &clk_rst_desc);
+	mtk_reset_controller_register(&pdev->dev, "mt7629-usb-rst");
 
 	return r;
 }
@@ -118,7 +110,7 @@ static int clk_mt7629_pciesys_init(struct platform_device *pdev)
 			"could not register clock provider: %s: %d\n",
 			pdev->name, r);
 
-	mtk_register_reset_controller_with_dev(&pdev->dev, &clk_rst_desc);
+	mtk_reset_controller_register(&pdev->dev, "mt7629-pcie-rst");
 
 	return r;
 }
diff --git a/drivers/clk/mediatek/clk-mt8135.c b/drivers/clk/mediatek/clk-mt8135.c
index b68888a034c4..89cd8c492b91 100644
--- a/drivers/clk/mediatek/clk-mt8135.c
+++ b/drivers/clk/mediatek/clk-mt8135.c
@@ -514,24 +514,6 @@ static const struct mtk_composite peri_clks[] __initconst = {
 	MUX(CLK_PERI_UART3_SEL, "uart3_ck_sel", uart_ck_sel_parents, 0x40c, 3, 1),
 };
 
-static u16 infrasys_rst_ofs[] = { 0x30, 0x34, };
-static u16 pericfg_rst_ofs[] = { 0x0, 0x4, };
-
-static const struct mtk_clk_rst_desc clk_rst_desc[] = {
-	/* infrasys */
-	{
-		.version = MTK_RST_SIMPLE,
-		.rst_bank_ofs = infrasys_rst_ofs,
-		.rst_bank_nr = ARRAY_SIZE(infrasys_rst_ofs),
-	},
-	/* pericfg */
-	{
-		.version = MTK_RST_SIMPLE,
-		.rst_bank_ofs = pericfg_rst_ofs,
-		.rst_bank_nr = ARRAY_SIZE(pericfg_rst_ofs),
-	}
-};
-
 static void __init mtk_topckgen_init(struct device_node *node)
 {
 	struct clk_hw_onecell_data *clk_data;
@@ -577,7 +559,8 @@ static void __init mtk_infrasys_init(struct device_node *node)
 		pr_err("%s(): could not register clock provider: %d\n",
 			__func__, r);
 
-	mtk_register_reset_controller(node, &clk_rst_desc[0]);
+	mtk_reset_init_with_node(node, "clk_mt8135.mt8135-infrasys-rst");
+
 }
 CLK_OF_DECLARE(mtk_infrasys, "mediatek,mt8135-infracfg", mtk_infrasys_init);
 
@@ -605,7 +588,7 @@ static void __init mtk_pericfg_init(struct device_node *node)
 		pr_err("%s(): could not register clock provider: %d\n",
 			__func__, r);
 
-	mtk_register_reset_controller(node, &clk_rst_desc[1]);
+	mtk_reset_init_with_node(node, "clk_mt8135.mt8135-pericfg-rst");
 }
 CLK_OF_DECLARE(mtk_pericfg, "mediatek,mt8135-pericfg", mtk_pericfg_init);
 
diff --git a/drivers/clk/mediatek/clk-mt8173.c b/drivers/clk/mediatek/clk-mt8173.c
index b8529ee7199d..ac01addf432f 100644
--- a/drivers/clk/mediatek/clk-mt8173.c
+++ b/drivers/clk/mediatek/clk-mt8173.c
@@ -819,24 +819,6 @@ static const struct mtk_gate venclt_clks[] __initconst = {
 	GATE_VENCLT(CLK_VENCLT_CKE1, "venclt_cke1", "venclt_sel", 4),
 };
 
-static u16 infrasys_rst_ofs[] = { 0x30, 0x34, };
-static u16 pericfg_rst_ofs[] = { 0x0, 0x4, };
-
-static const struct mtk_clk_rst_desc clk_rst_desc[] = {
-	/* infrasys */
-	{
-		.version = MTK_RST_SIMPLE,
-		.rst_bank_ofs = infrasys_rst_ofs,
-		.rst_bank_nr = ARRAY_SIZE(infrasys_rst_ofs),
-	},
-	/* pericfg */
-	{
-		.version = MTK_RST_SIMPLE,
-		.rst_bank_ofs = pericfg_rst_ofs,
-		.rst_bank_nr = ARRAY_SIZE(pericfg_rst_ofs),
-	}
-};
-
 static struct clk_hw_onecell_data *mt8173_top_clk_data __initdata;
 static struct clk_hw_onecell_data *mt8173_pll_clk_data __initdata;
 
@@ -900,7 +882,7 @@ static void __init mtk_infrasys_init(struct device_node *node)
 		pr_err("%s(): could not register clock provider: %d\n",
 			__func__, r);
 
-	mtk_register_reset_controller(node, &clk_rst_desc[0]);
+	mtk_reset_init_with_node(node, "clk_mt8173.mt8173-infracfg-rst");
 }
 CLK_OF_DECLARE(mtk_infrasys, "mediatek,mt8173-infracfg", mtk_infrasys_init);
 
@@ -928,7 +910,7 @@ static void __init mtk_pericfg_init(struct device_node *node)
 		pr_err("%s(): could not register clock provider: %d\n",
 			__func__, r);
 
-	mtk_register_reset_controller(node, &clk_rst_desc[1]);
+	mtk_reset_init_with_node(node, "clk_mt8173.mt8173-pericfg-rst");
 }
 CLK_OF_DECLARE(mtk_pericfg, "mediatek,mt8173-pericfg", mtk_pericfg_init);
 
diff --git a/drivers/clk/mediatek/clk-mt8183.c b/drivers/clk/mediatek/clk-mt8183.c
index 1860a35a723a..7e2be81e58d9 100644
--- a/drivers/clk/mediatek/clk-mt8183.c
+++ b/drivers/clk/mediatek/clk-mt8183.c
@@ -1150,19 +1150,6 @@ static const struct mtk_pll_data plls[] = {
 		0, 0, 32, 8, 0x02B4, 1, 0x02BC, 0x0014, 1, 0x02B8, 0, 0x02B4),
 };
 
-static u16 infra_rst_ofs[] = {
-	INFRA_RST0_SET_OFFSET,
-	INFRA_RST1_SET_OFFSET,
-	INFRA_RST2_SET_OFFSET,
-	INFRA_RST3_SET_OFFSET,
-};
-
-static const struct mtk_clk_rst_desc clk_rst_desc = {
-	.version = MTK_RST_SET_CLR,
-	.rst_bank_ofs = infra_rst_ofs,
-	.rst_bank_nr = ARRAY_SIZE(infra_rst_ofs),
-};
-
 static int clk_mt8183_apmixed_probe(struct platform_device *pdev)
 {
 	struct clk_hw_onecell_data *clk_data;
@@ -1278,7 +1265,7 @@ static int clk_mt8183_infra_probe(struct platform_device *pdev)
 		return r;
 	}
 
-	mtk_register_reset_controller_with_dev(&pdev->dev, &clk_rst_desc);
+	mtk_reset_controller_register(&pdev->dev, "mt8183-infra-rst");
 
 	return r;
 }
diff --git a/drivers/clk/mediatek/clk-mt8186-infra_ao.c b/drivers/clk/mediatek/clk-mt8186-infra_ao.c
index df2a6bd1aefa..958e28472f2b 100644
--- a/drivers/clk/mediatek/clk-mt8186-infra_ao.c
+++ b/drivers/clk/mediatek/clk-mt8186-infra_ao.c
@@ -192,31 +192,10 @@ static const struct mtk_gate infra_ao_clks[] = {
 	GATE_INFRA_AO3(CLK_INFRA_AO_FLASHIF_66M, "infra_ao_flashif_66m", "top_axi", 29),
 };
 
-static u16 infra_ao_rst_ofs[] = {
-	INFRA_RST0_SET_OFFSET,
-	INFRA_RST1_SET_OFFSET,
-	INFRA_RST2_SET_OFFSET,
-	INFRA_RST3_SET_OFFSET,
-	INFRA_RST4_SET_OFFSET,
-};
-
-static u16 infra_ao_idx_map[] = {
-	[MT8186_INFRA_THERMAL_CTRL_RST] = 0 * RST_NR_PER_BANK + 0,
-	[MT8186_INFRA_PTP_CTRL_RST] = 1 * RST_NR_PER_BANK + 0,
-};
-
-static struct mtk_clk_rst_desc infra_ao_rst_desc = {
-	.version = MTK_RST_SET_CLR,
-	.rst_bank_ofs = infra_ao_rst_ofs,
-	.rst_bank_nr = ARRAY_SIZE(infra_ao_rst_ofs),
-	.rst_idx_map = infra_ao_idx_map,
-	.rst_idx_map_nr = ARRAY_SIZE(infra_ao_idx_map),
-};
-
 static const struct mtk_clk_desc infra_ao_desc = {
 	.clks = infra_ao_clks,
 	.num_clks = ARRAY_SIZE(infra_ao_clks),
-	.rst_desc = &infra_ao_rst_desc,
+	.rst_name = "mt8186-infra-ao-rst",
 };
 
 static const struct of_device_id of_match_clk_mt8186_infra_ao[] = {
diff --git a/drivers/clk/mediatek/clk-mt8192.c b/drivers/clk/mediatek/clk-mt8192.c
index d0f226931070..11ca428030b8 100644
--- a/drivers/clk/mediatek/clk-mt8192.c
+++ b/drivers/clk/mediatek/clk-mt8192.c
@@ -18,7 +18,6 @@
 #include "clk-pll.h"
 
 #include <dt-bindings/clock/mt8192-clk.h>
-#include <dt-bindings/reset/mt8192-resets.h>
 
 static DEFINE_SPINLOCK(mt8192_clk_lock);
 
@@ -959,30 +958,6 @@ static const struct mtk_gate top_clks[] = {
 	GATE_TOP(CLK_TOP_SSUSB_PHY_REF, "ssusb_phy_ref", "clk26m", 25),
 };
 
-static u16 infra_ao_rst_ofs[] = {
-	INFRA_RST0_SET_OFFSET,
-	INFRA_RST1_SET_OFFSET,
-	INFRA_RST2_SET_OFFSET,
-	INFRA_RST3_SET_OFFSET,
-	INFRA_RST4_SET_OFFSET,
-};
-
-static u16 infra_ao_idx_map[] = {
-	[MT8192_INFRA_RST0_THERM_CTRL_SWRST] = 0 * RST_NR_PER_BANK + 0,
-	[MT8192_INFRA_RST2_PEXTP_PHY_SWRST] = 2 * RST_NR_PER_BANK + 15,
-	[MT8192_INFRA_RST3_THERM_CTRL_PTP_SWRST] = 3 * RST_NR_PER_BANK + 5,
-	[MT8192_INFRA_RST4_PCIE_TOP_SWRST] = 4 * RST_NR_PER_BANK + 1,
-	[MT8192_INFRA_RST4_THERM_CTRL_MCU_SWRST] = 4 * RST_NR_PER_BANK + 12,
-};
-
-static const struct mtk_clk_rst_desc clk_rst_desc = {
-	.version = MTK_RST_SET_CLR,
-	.rst_bank_ofs = infra_ao_rst_ofs,
-	.rst_bank_nr = ARRAY_SIZE(infra_ao_rst_ofs),
-	.rst_idx_map = infra_ao_idx_map,
-	.rst_idx_map_nr = ARRAY_SIZE(infra_ao_idx_map),
-};
-
 #define MT8192_PLL_FMAX		(3800UL * MHZ)
 #define MT8192_PLL_FMIN		(1500UL * MHZ)
 #define MT8192_INTEGER_BITS	8
@@ -1137,7 +1112,7 @@ static int clk_mt8192_infra_probe(struct platform_device *pdev)
 	if (r)
 		goto free_clk_data;
 
-	r = mtk_register_reset_controller_with_dev(&pdev->dev, &clk_rst_desc);
+	r = mtk_reset_controller_register(&pdev->dev, "mt8192-infra-rst");
 	if (r)
 		goto free_clk_data;
 
diff --git a/drivers/clk/mediatek/clk-mt8195-infra_ao.c b/drivers/clk/mediatek/clk-mt8195-infra_ao.c
index fcd410461d3b..0afc1336b2fb 100644
--- a/drivers/clk/mediatek/clk-mt8195-infra_ao.c
+++ b/drivers/clk/mediatek/clk-mt8195-infra_ao.c
@@ -7,7 +7,6 @@
 #include "clk-mtk.h"
 
 #include <dt-bindings/clock/mt8195-clk.h>
-#include <dt-bindings/reset/mt8195-resets.h>
 #include <linux/clk-provider.h>
 #include <linux/platform_device.h>
 
@@ -190,35 +189,10 @@ static const struct mtk_gate infra_ao_clks[] = {
 	GATE_INFRA_AO4(CLK_INFRA_AO_PERI_UFS_MEM_SUB, "infra_ao_peri_ufs_mem_sub", "mem_466m", 31),
 };
 
-static u16 infra_ao_rst_ofs[] = {
-	INFRA_RST0_SET_OFFSET,
-	INFRA_RST1_SET_OFFSET,
-	INFRA_RST2_SET_OFFSET,
-	INFRA_RST3_SET_OFFSET,
-	INFRA_RST4_SET_OFFSET,
-};
-
-static u16 infra_ao_idx_map[] = {
-	[MT8195_INFRA_RST0_THERM_CTRL_SWRST] = 0 * RST_NR_PER_BANK + 0,
-	[MT8195_INFRA_RST2_USBSIF_P1_SWRST] = 2 * RST_NR_PER_BANK + 18,
-	[MT8195_INFRA_RST2_PCIE_P0_SWRST] = 2 * RST_NR_PER_BANK + 26,
-	[MT8195_INFRA_RST2_PCIE_P1_SWRST] = 2 * RST_NR_PER_BANK + 27,
-	[MT8195_INFRA_RST3_THERM_CTRL_PTP_SWRST] = 3 * RST_NR_PER_BANK + 5,
-	[MT8195_INFRA_RST4_THERM_CTRL_MCU_SWRST] = 4 * RST_NR_PER_BANK + 10,
-};
-
-static struct mtk_clk_rst_desc infra_ao_rst_desc = {
-	.version = MTK_RST_SET_CLR,
-	.rst_bank_ofs = infra_ao_rst_ofs,
-	.rst_bank_nr = ARRAY_SIZE(infra_ao_rst_ofs),
-	.rst_idx_map = infra_ao_idx_map,
-	.rst_idx_map_nr = ARRAY_SIZE(infra_ao_idx_map),
-};
-
 static const struct mtk_clk_desc infra_ao_desc = {
 	.clks = infra_ao_clks,
 	.num_clks = ARRAY_SIZE(infra_ao_clks),
-	.rst_desc = &infra_ao_rst_desc,
+	.rst_name = "mt8195-infra-ao-rst",
 };
 
 static const struct of_device_id of_match_clk_mt8195_infra_ao[] = {
diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
index d31f01d0ba1c..61b7ee23738a 100644
--- a/drivers/clk/mediatek/clk-mtk.c
+++ b/drivers/clk/mediatek/clk-mtk.c
@@ -444,6 +444,63 @@ void mtk_clk_unregister_dividers(const struct mtk_clk_divider *mcds, int num,
 }
 EXPORT_SYMBOL_GPL(mtk_clk_unregister_dividers);
 
+static void mtk_reset_unregister_adev(void *_adev)
+{
+	struct auxiliary_device *adev = _adev;
+
+	auxiliary_device_delete(adev);
+}
+
+static void mtk_reset_adev_release(struct device *dev)
+{
+	struct auxiliary_device *adev = to_auxiliary_dev(dev);
+
+	auxiliary_device_uninit(adev);
+
+	kfree(adev);
+}
+
+static struct auxiliary_device *mtk_reset_adev_alloc(struct device *dev, const char *name)
+{
+	struct auxiliary_device *adev;
+	int ret;
+
+	adev = kzalloc(sizeof(*adev), GFP_KERNEL);
+	if (!adev)
+		return ERR_PTR(-ENOMEM);
+
+	adev->name = name;
+	adev->dev.parent = dev;
+	adev->dev.release = mtk_reset_adev_release;
+
+	ret = auxiliary_device_init(adev);
+	if (ret) {
+		kfree(adev);
+		return ERR_PTR(ret);
+	}
+
+	return adev;
+}
+
+int mtk_reset_controller_register(struct device *dev, const char *name)
+{
+	struct auxiliary_device *adev;
+	int ret;
+
+	adev = mtk_reset_adev_alloc(dev, name);
+	if (IS_ERR(adev))
+		return PTR_ERR(adev);
+
+	ret = auxiliary_device_add(adev);
+	if (ret) {
+		auxiliary_device_uninit(adev);
+		return ret;
+	}
+
+	return devm_add_action_or_reset(dev, mtk_reset_unregister_adev, adev);
+}
+EXPORT_SYMBOL_GPL(mtk_reset_controller_register);
+
 int mtk_clk_simple_probe(struct platform_device *pdev)
 {
 	const struct mtk_clk_desc *mcd;
@@ -470,9 +527,8 @@ int mtk_clk_simple_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, clk_data);
 
-	if (mcd->rst_desc) {
-		r = mtk_register_reset_controller_with_dev(&pdev->dev,
-							   mcd->rst_desc);
+	if (mcd->rst_name) {
+		r = mtk_reset_controller_register(&pdev->dev, mcd->rst_name);
 		if (r)
 			goto unregister_clks;
 	}
diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mtk.h
index 63ae7941aa92..9578643ef5a2 100644
--- a/drivers/clk/mediatek/clk-mtk.h
+++ b/drivers/clk/mediatek/clk-mtk.h
@@ -7,14 +7,14 @@
 #ifndef __DRV_CLK_MTK_H
 #define __DRV_CLK_MTK_H
 
+#include <linux/auxiliary_bus.h>
 #include <linux/clk-provider.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
+#include <linux/reset/reset-mediatek-sysclk.h>
 #include <linux/spinlock.h>
 #include <linux/types.h>
 
-#include "reset.h"
-
 #define MAX_MUX_GATE_BIT	31
 #define INVALID_MUX_GATE_BIT	(MAX_MUX_GATE_BIT + 1)
 
@@ -195,10 +195,12 @@ void mtk_clk_unregister_ref2usb_tx(struct clk_hw *hw);
 struct mtk_clk_desc {
 	const struct mtk_gate *clks;
 	size_t num_clks;
-	const struct mtk_clk_rst_desc *rst_desc;
+	char *rst_name;
 };
 
 int mtk_clk_simple_probe(struct platform_device *pdev);
 int mtk_clk_simple_remove(struct platform_device *pdev);
 
+int mtk_reset_controller_register(struct device *dev, const char *name);
+
 #endif /* __DRV_CLK_MTK_H */
diff --git a/drivers/clk/mediatek/reset.c b/drivers/clk/mediatek/reset.c
deleted file mode 100644
index 290ceda84ce4..000000000000
--- a/drivers/clk/mediatek/reset.c
+++ /dev/null
@@ -1,233 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Copyright (c) 2014 MediaTek Inc.
- */
-
-#include <linux/mfd/syscon.h>
-#include <linux/module.h>
-#include <linux/of.h>
-#include <linux/platform_device.h>
-#include <linux/regmap.h>
-#include <linux/slab.h>
-
-#include "reset.h"
-
-static inline struct mtk_clk_rst_data *to_mtk_clk_rst_data(struct reset_controller_dev *rcdev)
-{
-	return container_of(rcdev, struct mtk_clk_rst_data, rcdev);
-}
-
-static int mtk_reset_update(struct reset_controller_dev *rcdev,
-			    unsigned long id, bool deassert)
-{
-	struct mtk_clk_rst_data *data = to_mtk_clk_rst_data(rcdev);
-	unsigned int val = deassert ? 0 : ~0;
-
-	return regmap_update_bits(data->regmap,
-				  data->desc->rst_bank_ofs[id / RST_NR_PER_BANK],
-				  BIT(id % RST_NR_PER_BANK), val);
-}
-
-static int mtk_reset_assert(struct reset_controller_dev *rcdev,
-			    unsigned long id)
-{
-	return mtk_reset_update(rcdev, id, false);
-}
-
-static int mtk_reset_deassert(struct reset_controller_dev *rcdev,
-			      unsigned long id)
-{
-	return mtk_reset_update(rcdev, id, true);
-}
-
-static int mtk_reset(struct reset_controller_dev *rcdev, unsigned long id)
-{
-	int ret;
-
-	ret = mtk_reset_assert(rcdev, id);
-	if (ret)
-		return ret;
-
-	return mtk_reset_deassert(rcdev, id);
-}
-
-static int mtk_reset_update_set_clr(struct reset_controller_dev *rcdev,
-				    unsigned long id, bool deassert)
-{
-	struct mtk_clk_rst_data *data = to_mtk_clk_rst_data(rcdev);
-	unsigned int deassert_ofs = deassert ? 0x4 : 0;
-
-	return regmap_write(data->regmap,
-			    data->desc->rst_bank_ofs[id / RST_NR_PER_BANK] +
-			    deassert_ofs,
-			    BIT(id % RST_NR_PER_BANK));
-}
-
-static int mtk_reset_assert_set_clr(struct reset_controller_dev *rcdev,
-				    unsigned long id)
-{
-	return mtk_reset_update_set_clr(rcdev, id, false);
-}
-
-static int mtk_reset_deassert_set_clr(struct reset_controller_dev *rcdev,
-				      unsigned long id)
-{
-	return mtk_reset_update_set_clr(rcdev, id, true);
-}
-
-static int mtk_reset_set_clr(struct reset_controller_dev *rcdev,
-			     unsigned long id)
-{
-	int ret;
-
-	ret = mtk_reset_assert_set_clr(rcdev, id);
-	if (ret)
-		return ret;
-	return mtk_reset_deassert_set_clr(rcdev, id);
-}
-
-static const struct reset_control_ops mtk_reset_ops = {
-	.assert = mtk_reset_assert,
-	.deassert = mtk_reset_deassert,
-	.reset = mtk_reset,
-};
-
-static const struct reset_control_ops mtk_reset_ops_set_clr = {
-	.assert = mtk_reset_assert_set_clr,
-	.deassert = mtk_reset_deassert_set_clr,
-	.reset = mtk_reset_set_clr,
-};
-
-static int reset_xlate(struct reset_controller_dev *rcdev,
-		       const struct of_phandle_args *reset_spec)
-{
-	struct mtk_clk_rst_data *data = to_mtk_clk_rst_data(rcdev);
-
-	if (reset_spec->args[0] >= rcdev->nr_resets ||
-	    reset_spec->args[0] >= data->desc->rst_idx_map_nr)
-		return -EINVAL;
-
-	return data->desc->rst_idx_map[reset_spec->args[0]];
-}
-
-int mtk_register_reset_controller(struct device_node *np,
-				  const struct mtk_clk_rst_desc *desc)
-{
-	struct regmap *regmap;
-	const struct reset_control_ops *rcops = NULL;
-	struct mtk_clk_rst_data *data;
-	int ret;
-
-	if (!desc) {
-		pr_err("mtk clock reset desc is NULL\n");
-		return -EINVAL;
-	}
-
-	switch (desc->version) {
-	case MTK_RST_SIMPLE:
-		rcops = &mtk_reset_ops;
-		break;
-	case MTK_RST_SET_CLR:
-		rcops = &mtk_reset_ops_set_clr;
-		break;
-	default:
-		pr_err("Unknown reset version %d\n", desc->version);
-		return -EINVAL;
-	}
-
-	regmap = device_node_to_regmap(np);
-	if (IS_ERR(regmap)) {
-		pr_err("Cannot find regmap for %pOF: %pe\n", np, regmap);
-		return -EINVAL;
-	}
-
-	data = kzalloc(sizeof(*data), GFP_KERNEL);
-	if (!data)
-		return -ENOMEM;
-
-	data->desc = desc;
-	data->regmap = regmap;
-	data->rcdev.owner = THIS_MODULE;
-	data->rcdev.ops = rcops;
-	data->rcdev.of_node = np;
-
-	if (data->desc->rst_idx_map_nr > 0) {
-		data->rcdev.of_reset_n_cells = 1;
-		data->rcdev.nr_resets = desc->rst_idx_map_nr;
-		data->rcdev.of_xlate = reset_xlate;
-	} else {
-		data->rcdev.nr_resets = desc->rst_bank_nr * RST_NR_PER_BANK;
-	}
-
-	ret = reset_controller_register(&data->rcdev);
-	if (ret) {
-		pr_err("could not register reset controller: %d\n", ret);
-		kfree(data);
-		return ret;
-	}
-
-	return 0;
-}
-
-int mtk_register_reset_controller_with_dev(struct device *dev,
-					   const struct mtk_clk_rst_desc *desc)
-{
-	struct device_node *np = dev->of_node;
-	struct regmap *regmap;
-	const struct reset_control_ops *rcops = NULL;
-	struct mtk_clk_rst_data *data;
-	int ret;
-
-	if (!desc) {
-		dev_err(dev, "mtk clock reset desc is NULL\n");
-		return -EINVAL;
-	}
-
-	switch (desc->version) {
-	case MTK_RST_SIMPLE:
-		rcops = &mtk_reset_ops;
-		break;
-	case MTK_RST_SET_CLR:
-		rcops = &mtk_reset_ops_set_clr;
-		break;
-	default:
-		dev_err(dev, "Unknown reset version %d\n", desc->version);
-		return -EINVAL;
-	}
-
-	regmap = device_node_to_regmap(np);
-	if (IS_ERR(regmap)) {
-		dev_err(dev, "Cannot find regmap %pe\n", regmap);
-		return -EINVAL;
-	}
-
-	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
-	if (!data)
-		return -ENOMEM;
-
-	data->desc = desc;
-	data->regmap = regmap;
-	data->rcdev.owner = THIS_MODULE;
-	data->rcdev.ops = rcops;
-	data->rcdev.of_node = np;
-	data->rcdev.dev = dev;
-
-	if (data->desc->rst_idx_map_nr > 0) {
-		data->rcdev.of_reset_n_cells = 1;
-		data->rcdev.nr_resets = desc->rst_idx_map_nr;
-		data->rcdev.of_xlate = reset_xlate;
-	} else {
-		data->rcdev.nr_resets = desc->rst_bank_nr * RST_NR_PER_BANK;
-	}
-
-	ret = devm_reset_controller_register(dev, &data->rcdev);
-	if (ret) {
-		dev_err(dev, "could not register reset controller: %d\n", ret);
-		return ret;
-	}
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(mtk_register_reset_controller_with_dev);
-
-MODULE_LICENSE("GPL");
diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index de176c2fbad9..bfd71c81efcf 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -320,6 +320,7 @@ config RESET_ZYNQ
 	help
 	  This enables the reset controller driver for Xilinx Zynq SoCs.
 
+source "drivers/reset/mediatek/Kconfig"
 source "drivers/reset/sti/Kconfig"
 source "drivers/reset/hisilicon/Kconfig"
 source "drivers/reset/tegra/Kconfig"
diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
index 3e7e5fd633a8..5cef7ccc9a7d 100644
--- a/drivers/reset/Makefile
+++ b/drivers/reset/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-y += core.o
 obj-y += hisilicon/
+obj-y += mediatek/
 obj-$(CONFIG_ARCH_STI) += sti/
 obj-$(CONFIG_ARCH_TEGRA) += tegra/
 obj-$(CONFIG_RESET_A10SR) += reset-a10sr.o
diff --git a/drivers/reset/mediatek/Kconfig b/drivers/reset/mediatek/Kconfig
new file mode 100644
index 000000000000..b5b671017d34
--- /dev/null
+++ b/drivers/reset/mediatek/Kconfig
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0-only
+config RESET_MEDIATEK_SYSCLK
+	tristate "MediaTek System Clock Reset Driver"
+	depends on AUXILIARY_BUS
+	help
+	  This enables the system clock reset driver for MediaTek SoCs.
diff --git a/drivers/reset/mediatek/Makefile b/drivers/reset/mediatek/Makefile
new file mode 100644
index 000000000000..83f26c2cecdd
--- /dev/null
+++ b/drivers/reset/mediatek/Makefile
@@ -0,0 +1,13 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_RESET_MEDIATEK_SYSCLK) += reset-mediatek-sysclk.o
+obj-$(CONFIG_COMMON_CLK_MT2701) += reset-mt2701.o
+obj-$(CONFIG_COMMON_CLK_MT2712) += reset-mt2712.o
+obj-$(CONFIG_COMMON_CLK_MT6795) += reset-mt6795.o
+obj-$(CONFIG_COMMON_CLK_MT7622) += reset-mt7622.o
+obj-$(CONFIG_COMMON_CLK_MT7629) += reset-mt7629.o
+obj-$(CONFIG_COMMON_CLK_MT8135) += reset-mt8135.o
+obj-$(CONFIG_COMMON_CLK_MT8173) += reset-mt8173.o
+obj-$(CONFIG_COMMON_CLK_MT8183) += reset-mt8183.o
+obj-$(CONFIG_COMMON_CLK_MT8186) += reset-mt8186.o
+obj-$(CONFIG_COMMON_CLK_MT8192) += reset-mt8192.o
+obj-$(CONFIG_COMMON_CLK_MT8195) += reset-mt8195.o
diff --git a/drivers/reset/mediatek/reset-mediatek-sysclk.c b/drivers/reset/mediatek/reset-mediatek-sysclk.c
new file mode 100644
index 000000000000..d7174c898f60
--- /dev/null
+++ b/drivers/reset/mediatek/reset-mediatek-sysclk.c
@@ -0,0 +1,389 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2022 MediaTek Inc.
+ */
+
+#include <linux/auxiliary_bus.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/reset/reset-mediatek-sysclk.h>
+#include <linux/slab.h>
+
+static inline struct mtk_clk_rst_data *to_mtk_clk_rst_data(struct reset_controller_dev *rcdev)
+{
+	return container_of(rcdev, struct mtk_clk_rst_data, rcdev);
+}
+
+static int mtk_reset_update(struct reset_controller_dev *rcdev,
+			    unsigned long id, bool deassert)
+{
+	struct mtk_clk_rst_data *data = to_mtk_clk_rst_data(rcdev);
+	unsigned int val = deassert ? 0 : ~0;
+
+	return regmap_update_bits(data->regmap,
+				  data->desc->rst_bank_ofs[id / RST_NR_PER_BANK],
+				  BIT(id % RST_NR_PER_BANK), val);
+}
+
+static int mtk_reset_assert(struct reset_controller_dev *rcdev,
+			    unsigned long id)
+{
+	return mtk_reset_update(rcdev, id, false);
+}
+
+static int mtk_reset_deassert(struct reset_controller_dev *rcdev,
+			      unsigned long id)
+{
+	return mtk_reset_update(rcdev, id, true);
+}
+
+static int mtk_reset(struct reset_controller_dev *rcdev, unsigned long id)
+{
+	int ret;
+
+	ret = mtk_reset_assert(rcdev, id);
+	if (ret)
+		return ret;
+
+	return mtk_reset_deassert(rcdev, id);
+}
+
+static int mtk_reset_update_set_clr(struct reset_controller_dev *rcdev,
+				    unsigned long id, bool deassert)
+{
+	struct mtk_clk_rst_data *data = to_mtk_clk_rst_data(rcdev);
+	unsigned int deassert_ofs = deassert ? 0x4 : 0;
+
+	return regmap_write(data->regmap,
+			    data->desc->rst_bank_ofs[id / RST_NR_PER_BANK] +
+			    deassert_ofs,
+			    BIT(id % RST_NR_PER_BANK));
+}
+
+static int mtk_reset_assert_set_clr(struct reset_controller_dev *rcdev,
+				    unsigned long id)
+{
+	return mtk_reset_update_set_clr(rcdev, id, false);
+}
+
+static int mtk_reset_deassert_set_clr(struct reset_controller_dev *rcdev,
+				      unsigned long id)
+{
+	return mtk_reset_update_set_clr(rcdev, id, true);
+}
+
+static int mtk_reset_set_clr(struct reset_controller_dev *rcdev,
+			     unsigned long id)
+{
+	int ret;
+
+	ret = mtk_reset_assert_set_clr(rcdev, id);
+	if (ret)
+		return ret;
+	return mtk_reset_deassert_set_clr(rcdev, id);
+}
+
+static const struct reset_control_ops mtk_reset_ops = {
+	.assert = mtk_reset_assert,
+	.deassert = mtk_reset_deassert,
+	.reset = mtk_reset,
+};
+
+static const struct reset_control_ops mtk_reset_ops_set_clr = {
+	.assert = mtk_reset_assert_set_clr,
+	.deassert = mtk_reset_deassert_set_clr,
+	.reset = mtk_reset_set_clr,
+};
+
+static int reset_xlate(struct reset_controller_dev *rcdev,
+		       const struct of_phandle_args *reset_spec)
+{
+	struct mtk_clk_rst_data *data = to_mtk_clk_rst_data(rcdev);
+
+	if (reset_spec->args[0] >= rcdev->nr_resets ||
+	    reset_spec->args[0] >= data->desc->rst_idx_map_nr)
+		return -EINVAL;
+
+	return data->desc->rst_idx_map[reset_spec->args[0]];
+}
+
+static int register_rst_ctrl_with_node(struct device_node *np, struct mtk_clk_rst_data *data)
+{
+	struct regmap *regmap;
+	const struct reset_control_ops *rcops = NULL;
+	int ret;
+
+	if (!data) {
+		pr_err("invalid mtk clock reset data\n");
+		return -EINVAL;
+	}
+
+	switch (data->desc->version) {
+	case MTK_RST_SIMPLE:
+		rcops = &mtk_reset_ops;
+		break;
+	case MTK_RST_SET_CLR:
+		rcops = &mtk_reset_ops_set_clr;
+		break;
+	default:
+		pr_err("Unknown reset version %d\n", data->desc->version);
+		return -EINVAL;
+	}
+
+	regmap = device_node_to_regmap(np);
+	if (IS_ERR(regmap)) {
+		pr_err("Cannot find regmap for %pOF: %pe\n", np, regmap);
+		return -EINVAL;
+	}
+
+	data->regmap = regmap;
+	data->rcdev.owner = THIS_MODULE;
+	data->rcdev.ops = rcops;
+	data->rcdev.of_node = np;
+
+	if (data->desc->rst_idx_map_nr > 0) {
+		data->rcdev.of_reset_n_cells = 1;
+		data->rcdev.nr_resets = data->desc->rst_idx_map_nr;
+		data->rcdev.of_xlate = reset_xlate;
+	} else {
+		data->rcdev.nr_resets = data->desc->rst_bank_nr * RST_NR_PER_BANK;
+	}
+
+	ret = reset_controller_register(&data->rcdev);
+	if (ret) {
+		pr_err("could not register reset controller: %d\n", ret);
+		kfree(data);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int register_rst_ctrl_with_dev(struct device *dev, struct mtk_clk_rst_data *data)
+{
+	struct device_node *np = dev->of_node;
+	struct regmap *regmap;
+	const struct reset_control_ops *rcops = NULL;
+	int ret;
+
+	if (!data) {
+		dev_err(dev, "invalid mtk clock reset data\n");
+		return -EINVAL;
+	}
+
+	switch (data->desc->version) {
+	case MTK_RST_SIMPLE:
+		rcops = &mtk_reset_ops;
+		break;
+	case MTK_RST_SET_CLR:
+		rcops = &mtk_reset_ops_set_clr;
+		break;
+	default:
+		dev_err(dev, "Unknown reset version %d\n", data->desc->version);
+		return -EINVAL;
+	}
+
+	regmap = device_node_to_regmap(np);
+	if (IS_ERR(regmap)) {
+		dev_err(dev, "Cannot find regmap %pe\n", regmap);
+		return -EINVAL;
+	}
+
+	data->regmap = regmap;
+	data->rcdev.owner = THIS_MODULE;
+	data->rcdev.ops = rcops;
+	data->rcdev.of_node = np;
+	data->rcdev.dev = dev;
+
+	if (data->desc->rst_idx_map_nr > 0) {
+		data->rcdev.of_reset_n_cells = 1;
+		data->rcdev.nr_resets = data->desc->rst_idx_map_nr;
+		data->rcdev.of_xlate = reset_xlate;
+	} else {
+		data->rcdev.nr_resets = data->desc->rst_bank_nr * RST_NR_PER_BANK;
+	}
+
+	ret = devm_reset_controller_register(dev, &data->rcdev);
+	if (ret) {
+		dev_err(dev, "could not register reset controller: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static struct auxiliary_device_id mtk_sysclk_reset_ids[] = {
+	{
+		.name = "clk_mt2701_eth.mt2701-eth-rst",
+		.driver_data = MTK_RST_ID_MT2701_ETH,
+	},
+	{
+		.name = "clk_mt2701_g3d.mt2701-g3d-rst",
+		.driver_data = MTK_RST_ID_MT2701_G3D,
+	},
+	{
+		.name = "clk_mt2701_hif.mt2701-hif-rst",
+		.driver_data = MTK_RST_ID_MT2701_HIF,
+	},
+	{
+		.name = "clk_mt2701.mt2701-infrasys-rst",
+		.driver_data = MTK_RST_ID_MT2701_INFRASYS,
+	},
+	{
+		.name = "clk_mt2701.mt2701-pericfg-rst",
+		.driver_data = MTK_RST_ID_MT2701_PERICFG,
+	},
+	{
+		.name = "clk_mt2712.mt2712-infra-rst",
+		.driver_data = MTK_RST_ID_MT2712_INFRA,
+	},
+	{
+		.name = "clk_mt2712.mt2712-peri-rst",
+		.driver_data = MTK_RST_ID_MT2712_PERI,
+	},
+	{
+		.name = "clk_mt6795_infracfg.mt6795-ifa",
+		.driver_data = MTK_RST_ID_MT6795_INFRA,
+	},
+	{
+		.name = "clk_mt6795_pericfg.mt6795-peri",
+		.driver_data = MTK_RST_ID_MT6795_PERI,
+	},
+	{
+		.name = "clk_mt7622_eth.mt7622-eth-rst",
+		.driver_data = MTK_RST_ID_MT7622_ETH,
+	},
+	{
+		.name = "clk_mt7622_hif.mt7622-usb-rst",
+		.driver_data = MTK_RST_ID_MT7622_SSUSBSYS,
+	},
+	{
+		.name = "clk_mt7622_hif.mt7622-pcie-rst",
+		.driver_data = MTK_RST_ID_MT7622_PCIESYS,
+	},
+	{
+		.name = "clk_mt7622.mt7622-infrasys-rst",
+		.driver_data = MTK_RST_ID_MT7622_INFRASYS,
+	},
+	{
+		.name = "clk_mt7622.mt7622-pericfg-rst",
+		.driver_data = MTK_RST_ID_MT7622_PERICFG,
+	},
+	{
+		.name = "clk_mt7629_eth.mt7629-ethsys-rst",
+		.driver_data = MTK_RST_ID_MT7629_ETHSYS,
+	},
+	{
+		.name = "clk_mt7629_hif.mt7629-usb-rst",
+		.driver_data = MTK_RST_ID_MT7629_SSUSBSYS,
+	},
+	{
+		.name = "clk_mt7629_hif.mt7629-pcie-rst",
+		.driver_data = MTK_RST_ID_MT7629_PCIESYS,
+	},
+	{
+		.name = "clk_mt8135.mt8135-infrasys-rst",
+		.driver_data = MTK_RST_ID_MT8135_INFRASYS,
+	},
+	{
+		.name = "clk_mt8135.mt8135-pericfg-rst",
+		.driver_data = MTK_RST_ID_MT8135_PERICFG,
+	},
+	{
+		.name = "clk_mt8173.mt8173-infracfg-rst",
+		.driver_data = MTK_RST_ID_MT8173_INFRACFG,
+	},
+	{
+		.name = "clk_mt8173.mt8173-pericfg-rst",
+		.driver_data = MTK_RST_ID_MT8173_PERICFG,
+	},
+	{
+		.name = "clk_mt8183.mt8183-infra-rst",
+		.driver_data = MTK_RST_ID_MT8183_INFRA,
+	},
+	{
+		.name = "clk_mtk.mt8186-infra-ao-rst",
+		.driver_data = MTK_RST_ID_MT8186_INFRA_AO,
+	},
+	{
+		.name = "clk_mt8192.mt8192-infra-rst",
+		.driver_data = MTK_RST_ID_MT8192_INFRA,
+	},
+	{
+		.name = "clk_mtk.mt8195-infra-ao-rst",
+		.driver_data = MTK_RST_ID_MT8195_INFRA_AO,
+	},
+	{
+	},
+};
+MODULE_DEVICE_TABLE(auxiliary, mtk_sysclk_reset_ids);
+
+/* reset data pointer */
+struct mtk_clk_rst_data *p_clk_rst_data[MTK_RST_ID_MAX];
+
+static struct mtk_clk_rst_data *find_rst_data(const char *name)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(mtk_sysclk_reset_ids); i++)
+		if (mtk_sysclk_reset_ids[i].name == name)
+			return p_clk_rst_data[mtk_sysclk_reset_ids[i].driver_data];
+
+	return NULL;
+}
+
+int mtk_reset_init_with_node(struct device_node *np, const char *name)
+{
+	struct mtk_clk_rst_data *data = find_rst_data(name);
+
+	if (!np || !data)
+		return -EINVAL;
+
+	return register_rst_ctrl_with_node(np, data);
+}
+EXPORT_SYMBOL_GPL(mtk_reset_init_with_node);
+
+void mtk_rst_remove_with_node(struct device_node *np, const char *name)
+{
+	struct mtk_clk_rst_data *data = find_rst_data(name);
+
+	if (!np || !data)
+		return;
+
+	reset_controller_unregister(&data->rcdev);
+}
+EXPORT_SYMBOL_GPL(mtk_rst_remove_with_node);
+
+int mtk_rst_register_clk_rst_data(u32 index, struct mtk_clk_rst_data *data)
+{
+	if (index >= MTK_RST_ID_MAX)
+		return -EINVAL;
+
+	p_clk_rst_data[index] = data;
+
+	pr_info("%s, register mediatek sysclock reset(%d).\n", __func__, index);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mtk_rst_register_clk_rst_data);
+
+static int mtk_sysclk_reset_probe(struct auxiliary_device *adev,
+				  const struct auxiliary_device_id *id)
+{
+	if (id->driver_data >= MTK_RST_ID_MAX)
+		return -EINVAL;
+
+	return register_rst_ctrl_with_dev(adev->dev.parent, p_clk_rst_data[id->driver_data]);
+}
+
+static struct auxiliary_driver mtk_sysclk_reset_driver = {
+	.probe		= mtk_sysclk_reset_probe,
+	.id_table	= mtk_sysclk_reset_ids,
+};
+module_auxiliary_driver(mtk_sysclk_reset_driver);
+
+MODULE_DESCRIPTION("MediaTek System Clock Reset Driver");
+MODULE_AUTHOR("Bo-Chen Chen <rex-bc.chen@mediatek.com>");
+MODULE_LICENSE("GPL");
diff --git a/drivers/reset/mediatek/reset-mt2701.c b/drivers/reset/mediatek/reset-mt2701.c
new file mode 100644
index 000000000000..1a057ef8913b
--- /dev/null
+++ b/drivers/reset/mediatek/reset-mt2701.c
@@ -0,0 +1,102 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2022 MediaTek Inc.
+ */
+
+#include <linux/reset/reset-mediatek-sysclk.h>
+
+#if defined(CONFIG_COMMON_CLK_MT2701_ETHSYS)
+static u16 mt2701_eth_rst_ofs[] = { 0x34, };
+
+static const struct mtk_clk_rst_desc mt2701_eth_rst_desc = {
+	.version = MTK_RST_SIMPLE,
+	.rst_bank_ofs = mt2701_eth_rst_ofs,
+	.rst_bank_nr = ARRAY_SIZE(mt2701_eth_rst_ofs),
+};
+
+static struct mtk_clk_rst_data mt2701_eth_clk_rst_data = {
+	.desc = &mt2701_eth_rst_desc,
+};
+#endif
+
+#if defined(CONFIG_COMMON_CLK_MT2701_G3DSYS)
+static u16 mt2701_g3d_rst_ofs[] = { 0xc, };
+
+static const struct mtk_clk_rst_desc mt2701_g3d_clk_rst_desc = {
+	.version = MTK_RST_SIMPLE,
+	.rst_bank_ofs = mt2701_g3d_rst_ofs,
+	.rst_bank_nr = ARRAY_SIZE(mt2701_g3d_rst_ofs),
+};
+
+static struct mtk_clk_rst_data mt2701_g3d_clk_rst_data = {
+	.desc = &mt2701_g3d_clk_rst_desc,
+};
+#endif
+
+#if defined(CONFIG_COMMON_CLK_MT2701_HIFSYS)
+static u16 mt2701_hif_rst_ofs[] = { 0x34, };
+
+static const struct mtk_clk_rst_desc mt2701_hif_rst_desc = {
+	.version = MTK_RST_SIMPLE,
+	.rst_bank_ofs = mt2701_hif_rst_ofs,
+	.rst_bank_nr = ARRAY_SIZE(mt2701_hif_rst_ofs),
+};
+
+static struct mtk_clk_rst_data mt2701_hif_clk_rst_data = {
+	.desc = &mt2701_hif_rst_desc,
+};
+#endif
+
+static u16 mt2701_infrasys_rst_ofs[] = { 0x30, 0x34, };
+static u16 mt2701_pericfg_rst_ofs[] = { 0x0, 0x4, };
+
+static const struct mtk_clk_rst_desc mt2701_infrasys_clk_rst_desc = {
+	.version = MTK_RST_SIMPLE,
+	.rst_bank_ofs = mt2701_infrasys_rst_ofs,
+	.rst_bank_nr = ARRAY_SIZE(mt2701_infrasys_rst_ofs),
+};
+
+static const struct mtk_clk_rst_desc mt2701_pericfg_clk_rst_desc = {
+	.version = MTK_RST_SIMPLE,
+	.rst_bank_ofs = mt2701_pericfg_rst_ofs,
+	.rst_bank_nr = ARRAY_SIZE(mt2701_pericfg_rst_ofs),
+};
+
+static struct mtk_clk_rst_data mt2701_infrasys_clk_rst_data = {
+	.desc = &mt2701_infrasys_clk_rst_desc,
+};
+
+static struct mtk_clk_rst_data mt2701_pericfg_clk_rst_data = {
+	.desc = &mt2701_pericfg_clk_rst_desc,
+};
+
+static int __init mt2701_rst_desc_init(void)
+{
+	int ret;
+
+#if defined(CONFIG_COMMON_CLK_MT2701_ETHSYS)
+	ret = mtk_rst_register_clk_rst_data(MTK_RST_ID_MT2701_ETH, &mt2701_eth_clk_rst_data);
+	if (ret)
+		return ret;
+#endif
+#if defined(CONFIG_COMMON_CLK_MT2701_G3DSYS)
+	ret = mtk_rst_register_clk_rst_data(MTK_RST_ID_MT2701_G3D, &mt2701_g3d_clk_rst_data);
+	if (ret)
+		return ret;
+#endif
+#if defined(CONFIG_COMMON_CLK_MT2701_HIFSYS)
+	ret = mtk_rst_register_clk_rst_data(MTK_RST_ID_MT2701_HIF, &mt2701_hif_clk_rst_data);
+	if (ret)
+		return ret;
+#endif
+	ret = mtk_rst_register_clk_rst_data(MTK_RST_ID_MT2701_INFRASYS,
+					    &mt2701_infrasys_clk_rst_data);
+	if (ret)
+		return ret;
+
+	return mtk_rst_register_clk_rst_data(MTK_RST_ID_MT2701_PERICFG,
+					     &mt2701_pericfg_clk_rst_data);
+}
+arch_initcall(mt2701_rst_desc_init);
+
+MODULE_LICENSE("GPL");
diff --git a/drivers/reset/mediatek/reset-mt2712.c b/drivers/reset/mediatek/reset-mt2712.c
new file mode 100644
index 000000000000..14506e95159c
--- /dev/null
+++ b/drivers/reset/mediatek/reset-mt2712.c
@@ -0,0 +1,42 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2022 MediaTek Inc.
+ */
+
+#include <linux/reset/reset-mediatek-sysclk.h>
+
+static u16 mt2712_infrasys_rst_ofs[] = { 0x30, 0x34, };
+static u16 mt2712_pericfg_rst_ofs[] = { 0x0, 0x4, };
+
+static const struct mtk_clk_rst_desc mt2712_infrasys_clk_rst_desc = {
+	.version = MTK_RST_SIMPLE,
+	.rst_bank_ofs = mt2712_infrasys_rst_ofs,
+	.rst_bank_nr = ARRAY_SIZE(mt2712_infrasys_rst_ofs),
+};
+
+static const struct mtk_clk_rst_desc mt2712_pericfg_clk_rst_desc = {
+	.version = MTK_RST_SIMPLE,
+	.rst_bank_ofs = mt2712_pericfg_rst_ofs,
+	.rst_bank_nr = ARRAY_SIZE(mt2712_pericfg_rst_ofs),
+};
+
+static struct mtk_clk_rst_data mt2712_infrasys_clk_rst_data = {
+	.desc = &mt2712_infrasys_clk_rst_desc,
+};
+
+static struct mtk_clk_rst_data mt2712_pericfg_clk_rst_data = {
+	.desc = &mt2712_pericfg_clk_rst_desc,
+};
+
+static int __init mt2712_rst_desc_init(void)
+{
+	int ret = mtk_rst_register_clk_rst_data(MTK_RST_ID_MT2712_INFRA,
+						&mt2712_infrasys_clk_rst_data);
+	if (ret)
+		return ret;
+
+	return mtk_rst_register_clk_rst_data(MTK_RST_ID_MT2712_PERI, &mt2712_pericfg_clk_rst_data);
+}
+arch_initcall(mt2712_rst_desc_init);
+
+MODULE_LICENSE("GPL");
diff --git a/drivers/reset/mediatek/reset-mt6795.c b/drivers/reset/mediatek/reset-mt6795.c
new file mode 100644
index 000000000000..3fa1ad507ad6
--- /dev/null
+++ b/drivers/reset/mediatek/reset-mt6795.c
@@ -0,0 +1,61 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2022 MediaTek Inc.
+ */
+
+#include <dt-bindings/reset/mediatek,mt6795-resets.h>
+#include <linux/reset/reset-mediatek-sysclk.h>
+
+static u16 mt6795_infra_ao_rst_ofs[] = { 0x30, 0x34 };
+static u16 mt6795_peri_rst_ofs[] = { 0x0 };
+
+static u16 mt6795_infra_ao_idx_map[] = {
+	[MT6795_INFRA_RST0_SCPSYS_RST]    = 0 * RST_NR_PER_BANK + 5,
+	[MT6795_INFRA_RST0_PMIC_WRAP_RST] = 0 * RST_NR_PER_BANK + 7,
+	[MT6795_INFRA_RST1_MIPI_DSI_RST]  = 1 * RST_NR_PER_BANK + 4,
+	[MT6795_INFRA_RST1_MIPI_CSI_RST]  = 1 * RST_NR_PER_BANK + 7,
+	[MT6795_INFRA_RST1_MM_IOMMU_RST]  = 1 * RST_NR_PER_BANK + 15,
+};
+
+static u16 mt6795_peri_idx_map[] = {
+	[MT6795_PERI_NFI_SW_RST]   = 14,
+	[MT6795_PERI_THERM_SW_RST] = 16,
+	[MT6795_PERI_MSDC1_SW_RST] = 20,
+};
+
+static const struct mtk_clk_rst_desc mt6795_infra_rst_desc = {
+	.version = MTK_RST_SET_CLR,
+	.rst_bank_ofs = mt6795_infra_ao_rst_ofs,
+	.rst_bank_nr = ARRAY_SIZE(mt6795_infra_ao_rst_ofs),
+	.rst_idx_map = mt6795_infra_ao_idx_map,
+	.rst_idx_map_nr = ARRAY_SIZE(mt6795_infra_ao_idx_map),
+};
+
+static const struct mtk_clk_rst_desc mt6795_peri_clk_rst_desc = {
+	.version = MTK_RST_SIMPLE,
+	.rst_bank_ofs = mt6795_peri_rst_ofs,
+	.rst_bank_nr = ARRAY_SIZE(mt6795_peri_rst_ofs),
+	.rst_idx_map = mt6795_peri_idx_map,
+	.rst_idx_map_nr = ARRAY_SIZE(mt6795_peri_idx_map),
+};
+
+static struct mtk_clk_rst_data mt6795_infra_clk_rst_data = {
+	.desc = &mt6795_infra_rst_desc,
+};
+
+static struct mtk_clk_rst_data mt6795_peri_clk_rst_data = {
+	.desc = &mt6795_peri_clk_rst_desc,
+};
+
+static int __init mt6795_rst_desc_init(void)
+{
+	int ret = mtk_rst_register_clk_rst_data(MTK_RST_ID_MT6795_INFRA,
+						&mt6795_infra_clk_rst_data);
+	if (ret)
+		return ret;
+
+	return mtk_rst_register_clk_rst_data(MTK_RST_ID_MT6795_PERI, &mt6795_peri_clk_rst_data);
+}
+arch_initcall(mt6795_rst_desc_init);
+
+MODULE_LICENSE("GPL");
diff --git a/drivers/reset/mediatek/reset-mt7622.c b/drivers/reset/mediatek/reset-mt7622.c
new file mode 100644
index 000000000000..281906d5ca58
--- /dev/null
+++ b/drivers/reset/mediatek/reset-mt7622.c
@@ -0,0 +1,91 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2022 MediaTek Inc.
+ */
+
+#include <linux/reset/reset-mediatek-sysclk.h>
+
+#if defined(CONFIG_COMMON_CLK_MT7622_ETHSYS)
+static u16 mt7622_eth_rst_ofs[] = { 0x34, };
+
+static const struct mtk_clk_rst_desc mt7622_eth_rst_desc = {
+	.version = MTK_RST_SIMPLE,
+	.rst_bank_ofs = mt7622_eth_rst_ofs,
+	.rst_bank_nr = ARRAY_SIZE(mt7622_eth_rst_ofs),
+};
+
+static struct mtk_clk_rst_data mt7622_eth_clk_rst_data = {
+	.desc = &mt7622_eth_rst_desc,
+};
+#endif
+
+#if defined(CONFIG_COMMON_CLK_MT7622_HIFSYS)
+static u16 mt7622_hif_rst_ofs[] = { 0x34, };
+
+static const struct mtk_clk_rst_desc mt7622_hif_rst_desc = {
+	.version = MTK_RST_SIMPLE,
+	.rst_bank_ofs = mt7622_hif_rst_ofs,
+	.rst_bank_nr = ARRAY_SIZE(mt7622_hif_rst_ofs),
+};
+
+static struct mtk_clk_rst_data mt7622_ssusb_clk_rst_data = {
+	.desc = &mt7622_hif_rst_desc,
+};
+
+static struct mtk_clk_rst_data mt7622_pcie_clk_rst_data = {
+	.desc = &mt7622_hif_rst_desc,
+};
+#endif
+
+static u16 mt7622_infrasys_rst_ofs[] = { 0x30, };
+static u16 mt7622_pericfg_rst_ofs[] = { 0x0, 0x4, };
+
+static const struct mtk_clk_rst_desc mt7622_infrasys_clk_rst_desc = {
+	.version = MTK_RST_SIMPLE,
+	.rst_bank_ofs = mt7622_infrasys_rst_ofs,
+	.rst_bank_nr = ARRAY_SIZE(mt7622_infrasys_rst_ofs),
+};
+
+static const struct mtk_clk_rst_desc mt7622_pericfg_clk_rst_desc = {
+	.version = MTK_RST_SIMPLE,
+	.rst_bank_ofs = mt7622_pericfg_rst_ofs,
+	.rst_bank_nr = ARRAY_SIZE(mt7622_pericfg_rst_ofs),
+};
+
+static struct mtk_clk_rst_data mt7622_infrasys_clk_rst_data = {
+	.desc = &mt7622_infrasys_clk_rst_desc,
+};
+
+static struct mtk_clk_rst_data mt7622_pericfg_clk_rst_data = {
+	.desc = &mt7622_pericfg_clk_rst_desc,
+};
+
+static int __init mt7622_rst_desc_init(void)
+{
+	int ret;
+
+#if defined(CONFIG_COMMON_CLK_MT7622_ETHSYS)
+	ret = mtk_rst_register_clk_rst_data(MTK_RST_ID_MT7622_ETH, &mt7622_eth_clk_rst_data);
+	if (ret)
+		return ret;
+#endif
+#if defined(CONFIG_COMMON_CLK_MT7622_HIFSYS)
+	ret = mtk_rst_register_clk_rst_data(MTK_RST_ID_MT7622_SSUSBSYS, &mt7622_ssusb_clk_rst_data);
+	if (ret)
+		return ret;
+
+	ret = mtk_rst_register_clk_rst_data(MTK_RST_ID_MT7622_PCIESYS, &mt7622_pcie_clk_rst_data);
+	if (ret)
+		return ret;
+#endif
+	ret = mtk_rst_register_clk_rst_data(MTK_RST_ID_MT7622_INFRASYS,
+					    &mt7622_infrasys_clk_rst_data);
+	if (ret)
+		return ret;
+
+	return mtk_rst_register_clk_rst_data(MTK_RST_ID_MT7622_PERICFG,
+					     &mt7622_pericfg_clk_rst_data);
+}
+arch_initcall(mt7622_rst_desc_init);
+
+MODULE_LICENSE("GPL");
diff --git a/drivers/reset/mediatek/reset-mt7629.c b/drivers/reset/mediatek/reset-mt7629.c
new file mode 100644
index 000000000000..f87a436cf75d
--- /dev/null
+++ b/drivers/reset/mediatek/reset-mt7629.c
@@ -0,0 +1,62 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2022 MediaTek Inc.
+ */
+
+#include <linux/reset/reset-mediatek-sysclk.h>
+
+#if defined(CONFIG_COMMON_CLK_MT7629_ETHSYS)
+static u16 mt7629_eth_rst_ofs[] = { 0x34, };
+
+static const struct mtk_clk_rst_desc mt7629_eth_rst_desc = {
+	.version = MTK_RST_SIMPLE,
+	.rst_bank_ofs = mt7629_eth_rst_ofs,
+	.rst_bank_nr = ARRAY_SIZE(mt7629_eth_rst_ofs),
+};
+
+static struct mtk_clk_rst_data mt7629_eth_clk_rst_data = {
+	.desc = &mt7629_eth_rst_desc,
+};
+#endif
+
+#if defined(CONFIG_COMMON_CLK_MT7629_HIFSYS)
+static u16 mt7629_hif_rst_ofs[] = { 0x34, };
+
+static const struct mtk_clk_rst_desc mt7629_hif_rst_desc = {
+	.version = MTK_RST_SIMPLE,
+	.rst_bank_ofs = mt7629_hif_rst_ofs,
+	.rst_bank_nr = ARRAY_SIZE(mt7629_hif_rst_ofs),
+};
+
+static struct mtk_clk_rst_data mt7629_ssusb_clk_rst_data = {
+	.desc = &mt7629_hif_rst_desc,
+};
+
+static struct mtk_clk_rst_data mt7629_pcie_clk_rst_data = {
+	.desc = &mt7629_hif_rst_desc,
+};
+#endif
+
+static int __init mt7629_rst_desc_init(void)
+{
+	int ret = 0;
+
+#if defined(CONFIG_COMMON_CLK_MT7629_ETHSYS)
+	ret = mtk_rst_register_clk_rst_data(MTK_RST_ID_MT7629_ETHSYS, &mt7629_eth_clk_rst_data);
+	if (ret)
+		return ret;
+#endif
+#if defined(CONFIG_COMMON_CLK_MT7629_HIFSYS)
+	ret = mtk_rst_register_clk_rst_data(MTK_RST_ID_MT7629_SSUSBSYS, &mt7629_ssusb_clk_rst_data);
+	if (ret)
+		return ret;
+
+	ret = mtk_rst_register_clk_rst_data(MTK_RST_ID_MT7629_PCIESYS, &mt7629_pcie_clk_rst_data);
+	if (ret)
+		return ret;
+#endif
+	return ret;
+}
+arch_initcall(mt7629_rst_desc_init);
+
+MODULE_LICENSE("GPL");
diff --git a/drivers/reset/mediatek/reset-mt8135.c b/drivers/reset/mediatek/reset-mt8135.c
new file mode 100644
index 000000000000..59d9ea0f7556
--- /dev/null
+++ b/drivers/reset/mediatek/reset-mt8135.c
@@ -0,0 +1,43 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2022 MediaTek Inc.
+ */
+
+#include <linux/reset/reset-mediatek-sysclk.h>
+
+static u16 mt8135_infrasys_rst_ofs[] = { 0x30, 0x34, };
+static u16 mt8135_pericfg_rst_ofs[] = { 0x0, 0x4, };
+
+static const struct mtk_clk_rst_desc mt8135_infrasys_clk_rst_desc = {
+	.version = MTK_RST_SIMPLE,
+	.rst_bank_ofs = mt8135_infrasys_rst_ofs,
+	.rst_bank_nr = ARRAY_SIZE(mt8135_infrasys_rst_ofs),
+};
+
+static const struct mtk_clk_rst_desc mt8135_pericfg_clk_rst_desc = {
+	.version = MTK_RST_SIMPLE,
+	.rst_bank_ofs = mt8135_pericfg_rst_ofs,
+	.rst_bank_nr = ARRAY_SIZE(mt8135_pericfg_rst_ofs),
+};
+
+static struct mtk_clk_rst_data mt8135_infrasys_clk_rst_data = {
+	.desc = &mt8135_infrasys_clk_rst_desc,
+};
+
+static struct mtk_clk_rst_data mt8135_pericfg_clk_rst_data = {
+	.desc = &mt8135_pericfg_clk_rst_desc,
+};
+
+static int __init mt8135_rst_desc_init(void)
+{
+	int ret = mtk_rst_register_clk_rst_data(MTK_RST_ID_MT8135_INFRASYS,
+						&mt8135_infrasys_clk_rst_data);
+	if (ret)
+		return ret;
+
+	return mtk_rst_register_clk_rst_data(MTK_RST_ID_MT8135_PERICFG,
+					     &mt8135_pericfg_clk_rst_data);
+}
+arch_initcall(mt8135_rst_desc_init);
+
+MODULE_LICENSE("GPL");
diff --git a/drivers/reset/mediatek/reset-mt8173.c b/drivers/reset/mediatek/reset-mt8173.c
new file mode 100644
index 000000000000..90eb53cab2aa
--- /dev/null
+++ b/drivers/reset/mediatek/reset-mt8173.c
@@ -0,0 +1,43 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2022 MediaTek Inc.
+ */
+
+#include <linux/reset/reset-mediatek-sysclk.h>
+
+static u16 mt8173_infrasys_rst_ofs[] = { 0x30, 0x34, };
+static u16 mt8173_pericfg_rst_ofs[] = { 0x0, 0x4, };
+
+static const struct mtk_clk_rst_desc mt8173_infrasys_clk_rst_desc = {
+	.version = MTK_RST_SIMPLE,
+	.rst_bank_ofs = mt8173_infrasys_rst_ofs,
+	.rst_bank_nr = ARRAY_SIZE(mt8173_infrasys_rst_ofs),
+};
+
+static const struct mtk_clk_rst_desc mt8173_pericfg_clk_rst_desc = {
+	.version = MTK_RST_SIMPLE,
+	.rst_bank_ofs = mt8173_pericfg_rst_ofs,
+	.rst_bank_nr = ARRAY_SIZE(mt8173_pericfg_rst_ofs),
+};
+
+static struct mtk_clk_rst_data mt8173_infrasys_clk_rst_data = {
+	.desc = &mt8173_infrasys_clk_rst_desc,
+};
+
+static struct mtk_clk_rst_data mt8173_pericfg_clk_rst_data = {
+	.desc = &mt8173_pericfg_clk_rst_desc,
+};
+
+static int __init mt8173_rst_desc_init(void)
+{
+	int ret = mtk_rst_register_clk_rst_data(MTK_RST_ID_MT8173_INFRACFG,
+						&mt8173_infrasys_clk_rst_data);
+	if (ret)
+		return ret;
+
+	return mtk_rst_register_clk_rst_data(MTK_RST_ID_MT8173_PERICFG,
+					     &mt8173_pericfg_clk_rst_data);
+}
+arch_initcall(mt8173_rst_desc_init);
+
+MODULE_LICENSE("GPL");
diff --git a/drivers/reset/mediatek/reset-mt8183.c b/drivers/reset/mediatek/reset-mt8183.c
new file mode 100644
index 000000000000..931d8c7a477e
--- /dev/null
+++ b/drivers/reset/mediatek/reset-mt8183.c
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2022 MediaTek Inc.
+ */
+
+#include <linux/reset/reset-mediatek-sysclk.h>
+
+static u16 mt8183_infra_ao_rst_ofs[] = {
+	INFRA_RST0_SET_OFFSET,
+	INFRA_RST1_SET_OFFSET,
+	INFRA_RST2_SET_OFFSET,
+	INFRA_RST3_SET_OFFSET,
+};
+
+static struct mtk_clk_rst_desc mt8183_rst_desc = {
+	.version = MTK_RST_SET_CLR,
+	.rst_bank_ofs = mt8183_infra_ao_rst_ofs,
+	.rst_bank_nr = ARRAY_SIZE(mt8183_infra_ao_rst_ofs),
+};
+
+static struct mtk_clk_rst_data mt8183_clk_rst_data = {
+	.desc = &mt8183_rst_desc,
+};
+
+static int __init mt8183_rst_desc_init(void)
+{
+	return mtk_rst_register_clk_rst_data(MTK_RST_ID_MT8183_INFRA, &mt8183_clk_rst_data);
+}
+arch_initcall(mt8183_rst_desc_init);
+
+MODULE_LICENSE("GPL");
diff --git a/drivers/reset/mediatek/reset-mt8186.c b/drivers/reset/mediatek/reset-mt8186.c
new file mode 100644
index 000000000000..3bc853ecc733
--- /dev/null
+++ b/drivers/reset/mediatek/reset-mt8186.c
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2022 MediaTek Inc.
+ */
+
+#include <dt-bindings/reset/mt8186-resets.h>
+#include <linux/reset/reset-mediatek-sysclk.h>
+
+static u16 mt8186_infra_ao_idx_map[] = {
+	[MT8186_INFRA_THERMAL_CTRL_RST] = 0 * RST_NR_PER_BANK + 0,
+	[MT8186_INFRA_PTP_CTRL_RST] = 1 * RST_NR_PER_BANK + 0,
+};
+
+static u16 mt8186_infra_ao_rst_ofs[] = {
+	INFRA_RST0_SET_OFFSET,
+	INFRA_RST1_SET_OFFSET,
+	INFRA_RST2_SET_OFFSET,
+	INFRA_RST3_SET_OFFSET,
+};
+
+static struct mtk_clk_rst_desc mt8186_rst_desc = {
+	.version = MTK_RST_SET_CLR,
+	.rst_bank_ofs = mt8186_infra_ao_rst_ofs,
+	.rst_bank_nr = ARRAY_SIZE(mt8186_infra_ao_rst_ofs),
+	.rst_idx_map = mt8186_infra_ao_idx_map,
+	.rst_idx_map_nr = ARRAY_SIZE(mt8186_infra_ao_idx_map),
+};
+
+static struct mtk_clk_rst_data mt8186_clk_rst_data = {
+	.desc = &mt8186_rst_desc,
+};
+
+static int __init mt8186_rst_desc_init(void)
+{
+	return mtk_rst_register_clk_rst_data(MTK_RST_ID_MT8186_INFRA_AO, &mt8186_clk_rst_data);
+}
+arch_initcall(mt8186_rst_desc_init);
+
+MODULE_LICENSE("GPL");
diff --git a/drivers/reset/mediatek/reset-mt8192.c b/drivers/reset/mediatek/reset-mt8192.c
new file mode 100644
index 000000000000..67daada0c380
--- /dev/null
+++ b/drivers/reset/mediatek/reset-mt8192.c
@@ -0,0 +1,43 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2022 MediaTek Inc.
+ */
+
+#include <dt-bindings/reset/mt8192-resets.h>
+#include <linux/reset/reset-mediatek-sysclk.h>
+
+static u16 mt8192_infra_ao_idx_map[] = {
+	[MT8192_INFRA_RST0_THERM_CTRL_SWRST] = 0 * RST_NR_PER_BANK + 0,
+	[MT8192_INFRA_RST2_PEXTP_PHY_SWRST] = 2 * RST_NR_PER_BANK + 15,
+	[MT8192_INFRA_RST3_THERM_CTRL_PTP_SWRST] = 3 * RST_NR_PER_BANK + 5,
+	[MT8192_INFRA_RST4_PCIE_TOP_SWRST] = 4 * RST_NR_PER_BANK + 1,
+	[MT8192_INFRA_RST4_THERM_CTRL_MCU_SWRST] = 4 * RST_NR_PER_BANK + 12,
+};
+
+static u16 mt8192_infra_ao_rst_ofs[] = {
+	INFRA_RST0_SET_OFFSET,
+	INFRA_RST1_SET_OFFSET,
+	INFRA_RST2_SET_OFFSET,
+	INFRA_RST3_SET_OFFSET,
+	INFRA_RST4_SET_OFFSET,
+};
+
+static struct mtk_clk_rst_desc mt8192_rst_desc = {
+	.version = MTK_RST_SET_CLR,
+	.rst_bank_ofs = mt8192_infra_ao_rst_ofs,
+	.rst_bank_nr = ARRAY_SIZE(mt8192_infra_ao_rst_ofs),
+	.rst_idx_map = mt8192_infra_ao_idx_map,
+	.rst_idx_map_nr = ARRAY_SIZE(mt8192_infra_ao_idx_map),
+};
+
+static struct mtk_clk_rst_data mt8192_clk_rst_data = {
+	.desc = &mt8192_rst_desc,
+};
+
+static int __init mt8192_rst_desc_init(void)
+{
+	return mtk_rst_register_clk_rst_data(MTK_RST_ID_MT8192_INFRA, &mt8192_clk_rst_data);
+}
+arch_initcall(mt8192_rst_desc_init);
+
+MODULE_LICENSE("GPL");
diff --git a/drivers/reset/mediatek/reset-mt8195.c b/drivers/reset/mediatek/reset-mt8195.c
new file mode 100644
index 000000000000..ddad657e608e
--- /dev/null
+++ b/drivers/reset/mediatek/reset-mt8195.c
@@ -0,0 +1,44 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2022 MediaTek Inc.
+ */
+
+#include <dt-bindings/reset/mt8195-resets.h>
+#include <linux/reset/reset-mediatek-sysclk.h>
+
+static u16 mt8195_infra_ao_idx_map[] = {
+	[MT8195_INFRA_RST0_THERM_CTRL_SWRST] = 0 * RST_NR_PER_BANK + 0,
+	[MT8195_INFRA_RST2_USBSIF_P1_SWRST] = 2 * RST_NR_PER_BANK + 18,
+	[MT8195_INFRA_RST2_PCIE_P0_SWRST] = 2 * RST_NR_PER_BANK + 26,
+	[MT8195_INFRA_RST2_PCIE_P1_SWRST] = 2 * RST_NR_PER_BANK + 27,
+	[MT8195_INFRA_RST3_THERM_CTRL_PTP_SWRST] = 3 * RST_NR_PER_BANK + 5,
+	[MT8195_INFRA_RST4_THERM_CTRL_MCU_SWRST] = 4 * RST_NR_PER_BANK + 10,
+};
+
+static u16 mt8195_infra_ao_rst_ofs[] = {
+	INFRA_RST0_SET_OFFSET,
+	INFRA_RST1_SET_OFFSET,
+	INFRA_RST2_SET_OFFSET,
+	INFRA_RST3_SET_OFFSET,
+	INFRA_RST4_SET_OFFSET,
+};
+
+static struct mtk_clk_rst_desc mt8195_rst_desc = {
+	.version = MTK_RST_SET_CLR,
+	.rst_bank_ofs = mt8195_infra_ao_rst_ofs,
+	.rst_bank_nr = ARRAY_SIZE(mt8195_infra_ao_rst_ofs),
+	.rst_idx_map = mt8195_infra_ao_idx_map,
+	.rst_idx_map_nr = ARRAY_SIZE(mt8195_infra_ao_idx_map),
+};
+
+static struct mtk_clk_rst_data mt8195_clk_rst_data = {
+	.desc = &mt8195_rst_desc,
+};
+
+static int __init mt8195_rst_desc_init(void)
+{
+	return mtk_rst_register_clk_rst_data(MTK_RST_ID_MT8195_INFRA_AO, &mt8195_clk_rst_data);
+}
+arch_initcall(mt8195_rst_desc_init);
+
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/reset.h b/include/linux/reset/reset-mediatek-sysclk.h
similarity index 60%
rename from drivers/clk/mediatek/reset.h
rename to include/linux/reset/reset-mediatek-sysclk.h
index 6a58a3d59165..6f5f15d12edd 100644
--- a/drivers/clk/mediatek/reset.h
+++ b/include/linux/reset/reset-mediatek-sysclk.h
@@ -3,9 +3,11 @@
  * Copyright (c) 2022 MediaTek Inc.
  */
 
-#ifndef __DRV_CLK_MTK_RESET_H
-#define __DRV_CLK_MTK_RESET_H
+#ifndef __LINUX_RESET_MEDIATEK_SYSCLK_H__
+#define __LINUX_RESET_MEDIATEK_SYSCLK_H__
 
+#include <linux/module.h>
+#include <linux/regmap.h>
 #include <linux/reset-controller.h>
 #include <linux/types.h>
 
@@ -18,6 +20,35 @@
 #define INFRA_RST3_SET_OFFSET 0x150
 #define INFRA_RST4_SET_OFFSET 0x730
 
+enum {
+	MTK_RST_ID_MT2701_ETH = 0,
+	MTK_RST_ID_MT2701_G3D,
+	MTK_RST_ID_MT2701_HIF,
+	MTK_RST_ID_MT2701_INFRASYS,
+	MTK_RST_ID_MT2701_PERICFG,
+	MTK_RST_ID_MT2712_INFRA,
+	MTK_RST_ID_MT2712_PERI,
+	MTK_RST_ID_MT6795_INFRA,
+	MTK_RST_ID_MT6795_PERI,
+	MTK_RST_ID_MT7622_ETH,
+	MTK_RST_ID_MT7622_SSUSBSYS,
+	MTK_RST_ID_MT7622_PCIESYS,
+	MTK_RST_ID_MT7622_INFRASYS,
+	MTK_RST_ID_MT7622_PERICFG,
+	MTK_RST_ID_MT7629_ETHSYS,
+	MTK_RST_ID_MT7629_SSUSBSYS,
+	MTK_RST_ID_MT7629_PCIESYS,
+	MTK_RST_ID_MT8135_INFRASYS,
+	MTK_RST_ID_MT8135_PERICFG,
+	MTK_RST_ID_MT8173_INFRACFG,
+	MTK_RST_ID_MT8173_PERICFG,
+	MTK_RST_ID_MT8183_INFRA,
+	MTK_RST_ID_MT8186_INFRA_AO,
+	MTK_RST_ID_MT8192_INFRA,
+	MTK_RST_ID_MT8195_INFRA_AO,
+	MTK_RST_ID_MAX,
+};
+
 /**
  * enum mtk_reset_version - Version of MediaTek clock reset controller.
  * @MTK_RST_SIMPLE: Use the same registers for bit set and clear.
@@ -40,7 +71,7 @@ enum mtk_reset_version {
  * @rst_idx_map_nr: Quantity of reset index map.
  */
 struct mtk_clk_rst_desc {
-	enum mtk_reset_version version;
+	u8 version;
 	u16 *rst_bank_ofs;
 	u32 rst_bank_nr;
 	u16 *rst_idx_map;
@@ -59,24 +90,8 @@ struct mtk_clk_rst_data {
 	const struct mtk_clk_rst_desc *desc;
 };
 
-/**
- * mtk_register_reset_controller - Register MediaTek clock reset controller
- * @np: Pointer to device node.
- * @desc: Constant pointer to description of clock reset.
- *
- * Return: 0 on success and errorno otherwise.
- */
-int mtk_register_reset_controller(struct device_node *np,
-				  const struct mtk_clk_rst_desc *desc);
-
-/**
- * mtk_register_reset_controller - Register mediatek clock reset controller with device
- * @np: Pointer to device.
- * @desc: Constant pointer to description of clock reset.
- *
- * Return: 0 on success and errorno otherwise.
- */
-int mtk_register_reset_controller_with_dev(struct device *dev,
-					   const struct mtk_clk_rst_desc *desc);
+int mtk_rst_register_clk_rst_data(u32 index, struct mtk_clk_rst_data *data);
+int mtk_reset_init_with_node(struct device_node *np, const char *name);
+void mtk_rst_remove_with_node(struct device_node *np, const char *name);
 
-#endif /* __DRV_CLK_MTK_RESET_H */
+#endif /* __LINUX_RESET_MEDIATEK_SYSCLK_H__ */
-- 
2.18.0

