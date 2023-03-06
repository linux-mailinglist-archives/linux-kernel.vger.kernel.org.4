Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA086AC28E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 15:10:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbjCFOKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 09:10:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231373AbjCFOJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 09:09:39 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5644B30C6;
        Mon,  6 Mar 2023 06:08:03 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 3CE506602FE5;
        Mon,  6 Mar 2023 14:06:28 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1678111589;
        bh=Y9OkODTDNmSVwsbSSwpqPuC/orp6A0Bd3FSf0Ld5XzI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XoC7funjbYMqAVLd79Ln19VPZJvac7gb8go10IPOahvFAzhY9/+mtv1D6w/ckAJeF
         udf0aGR1cJspONUEJysGkrrSqoSO5ubehyG91Utexpf5iyrheYXXHCLGJ5wn/SfPv3
         OECOnt0uC+rs+kHaksHHaLgYzGiOe7Sc5jpdzD3W5ljGnOe3Htk1MBOVmhWWj3uOMJ
         CEwdcjj4txzQ0kallrj/vObn6Oj124XVfWVIV3x4qITH6HmxslHtFqrrl8+NGbGJ+6
         qLI4SYaHy/HptzjCMcu0i30je1EHACgiQFoMLbziJiNITTwPMdxtMtrKAvISib1pc0
         2tsWjS6wEzw5Q==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     mturquette@baylibre.com
Cc:     sboyd@kernel.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, wenst@chromium.org,
        johnson.wang@mediatek.com, miles.chen@mediatek.com,
        chun-jie.chen@mediatek.com, daniel@makrotopia.org,
        fparent@baylibre.com, msp@baylibre.com, nfraprado@collabora.com,
        rex-bc.chen@mediatek.com, zhaojh329@gmail.com,
        sam.shih@mediatek.com, edward-jw.yang@mediatek.com,
        yangyingliang@huawei.com, granquet@baylibre.com,
        pablo.sun@mediatek.com, sean.wang@mediatek.com,
        chen.zhong@mediatek.com, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com
Subject: [PATCH v6 26/54] clk: mediatek: mt7622: Move infracfg to clk-mt7622-infracfg.c
Date:   Mon,  6 Mar 2023 15:05:15 +0100
Message-Id: <20230306140543.1813621-27-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230306140543.1813621-1-angelogioacchino.delregno@collabora.com>
References: <20230306140543.1813621-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The infracfg driver cannot be converted to clk_mtk_simple_probe() as
it registers cpumuxes, which is not supported on the common probing
mechanism: for this reason, move it to its own file.
While at it, also convert it to be a platform driver instead; to do
so, also add a .remove() callback for this driver.

During the conversion, error handling was added to the infracfg
probe function.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/clk/mediatek/Makefile              |   3 +-
 drivers/clk/mediatek/clk-mt7622-infracfg.c | 127 +++++++++++++++++++++
 drivers/clk/mediatek/clk-mt7622.c          |  78 +------------
 3 files changed, 134 insertions(+), 74 deletions(-)
 create mode 100644 drivers/clk/mediatek/clk-mt7622-infracfg.c

diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
index 4619091963a0..5dc5f9457c44 100644
--- a/drivers/clk/mediatek/Makefile
+++ b/drivers/clk/mediatek/Makefile
@@ -46,7 +46,8 @@ obj-$(CONFIG_COMMON_CLK_MT2712_MFGCFG) += clk-mt2712-mfg.o
 obj-$(CONFIG_COMMON_CLK_MT2712_MMSYS) += clk-mt2712-mm.o
 obj-$(CONFIG_COMMON_CLK_MT2712_VDECSYS) += clk-mt2712-vdec.o
 obj-$(CONFIG_COMMON_CLK_MT2712_VENCSYS) += clk-mt2712-venc.o
-obj-$(CONFIG_COMMON_CLK_MT7622) += clk-mt7622-apmixedsys.o clk-mt7622.o
+obj-$(CONFIG_COMMON_CLK_MT7622) += clk-mt7622-apmixedsys.o clk-mt7622.o \
+				   clk-mt7622-infracfg.o
 obj-$(CONFIG_COMMON_CLK_MT7622_ETHSYS) += clk-mt7622-eth.o
 obj-$(CONFIG_COMMON_CLK_MT7622_HIFSYS) += clk-mt7622-hif.o
 obj-$(CONFIG_COMMON_CLK_MT7622_AUDSYS) += clk-mt7622-aud.o
diff --git a/drivers/clk/mediatek/clk-mt7622-infracfg.c b/drivers/clk/mediatek/clk-mt7622-infracfg.c
new file mode 100644
index 000000000000..09d8ac4d483a
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt7622-infracfg.c
@@ -0,0 +1,127 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2017 MediaTek Inc.
+ * Copyright (c) 2023 Collabora, Ltd.
+ *               AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
+ */
+
+#include <dt-bindings/clock/mt7622-clk.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+
+#include "clk-cpumux.h"
+#include "clk-gate.h"
+#include "clk-mtk.h"
+#include "reset.h"
+
+#define GATE_INFRA(_id, _name, _parent, _shift)				\
+	GATE_MTK(_id, _name, _parent, &infra_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
+
+static const struct mtk_gate_regs infra_cg_regs = {
+	.set_ofs = 0x40,
+	.clr_ofs = 0x44,
+	.sta_ofs = 0x48,
+};
+
+static const char * const infra_mux1_parents[] = {
+	"clkxtal",
+	"armpll",
+	"main_core_en",
+	"armpll"
+};
+
+static const struct mtk_composite cpu_muxes[] = {
+	MUX(CLK_INFRA_MUX1_SEL, "infra_mux1_sel", infra_mux1_parents, 0x000, 2, 2),
+};
+
+static const struct mtk_gate infra_clks[] = {
+	GATE_INFRA(CLK_INFRA_DBGCLK_PD, "infra_dbgclk_pd", "axi_sel", 0),
+	GATE_INFRA(CLK_INFRA_TRNG, "trng_ck", "axi_sel", 2),
+	GATE_INFRA(CLK_INFRA_AUDIO_PD, "infra_audio_pd", "aud_intbus_sel", 5),
+	GATE_INFRA(CLK_INFRA_IRRX_PD, "infra_irrx_pd", "irrx_sel", 16),
+	GATE_INFRA(CLK_INFRA_APXGPT_PD, "infra_apxgpt_pd", "f10m_ref_sel", 18),
+	GATE_INFRA(CLK_INFRA_PMIC_PD, "infra_pmic_pd", "pmicspi_sel", 22),
+};
+
+static u16 infrasys_rst_ofs[] = { 0x30 };
+
+static const struct mtk_clk_rst_desc clk_rst_desc = {
+	.version = MTK_RST_SIMPLE,
+	.rst_bank_ofs = infrasys_rst_ofs,
+	.rst_bank_nr = ARRAY_SIZE(infrasys_rst_ofs),
+};
+
+static const struct of_device_id of_match_clk_mt7622_infracfg[] = {
+	{ .compatible = "mediatek,mt7622-infracfg" },
+	{ /* sentinel */ }
+};
+
+static int clk_mt7622_infracfg_probe(struct platform_device *pdev)
+{
+	struct clk_hw_onecell_data *clk_data;
+	struct device_node *node = pdev->dev.of_node;
+	void __iomem *base;
+	int ret;
+
+	base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	clk_data = mtk_alloc_clk_data(CLK_INFRA_NR_CLK);
+	if (!clk_data)
+		return -ENOMEM;
+
+	ret = mtk_register_reset_controller_with_dev(&pdev->dev, &clk_rst_desc);
+	if (ret)
+		goto free_clk_data;
+
+	ret = mtk_clk_register_gates(&pdev->dev, node, infra_clks,
+				     ARRAY_SIZE(infra_clks), clk_data);
+	if (ret)
+		goto free_clk_data;
+
+	ret = mtk_clk_register_cpumuxes(&pdev->dev, node, cpu_muxes,
+					ARRAY_SIZE(cpu_muxes), clk_data);
+	if (ret)
+		goto unregister_gates;
+
+	ret = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
+	if (ret)
+		goto unregister_cpumuxes;
+
+	return 0;
+
+unregister_cpumuxes:
+	mtk_clk_unregister_cpumuxes(cpu_muxes, ARRAY_SIZE(cpu_muxes), clk_data);
+unregister_gates:
+	mtk_clk_unregister_gates(infra_clks, ARRAY_SIZE(infra_clks), clk_data);
+free_clk_data:
+	mtk_free_clk_data(clk_data);
+	return ret;
+}
+
+static int clk_mt7622_infracfg_remove(struct platform_device *pdev)
+{
+	struct device_node *node = pdev->dev.of_node;
+	struct clk_hw_onecell_data *clk_data = platform_get_drvdata(pdev);
+
+	of_clk_del_provider(node);
+	mtk_clk_unregister_cpumuxes(cpu_muxes, ARRAY_SIZE(cpu_muxes), clk_data);
+	mtk_clk_unregister_gates(infra_clks, ARRAY_SIZE(infra_clks), clk_data);
+	mtk_free_clk_data(clk_data);
+
+	return 0;
+}
+
+static struct platform_driver clk_mt7622_infracfg_drv = {
+	.driver = {
+		.name = "clk-mt7622-infracfg",
+		.of_match_table = of_match_clk_mt7622_infracfg,
+	},
+	.probe = clk_mt7622_infracfg_probe,
+	.remove = clk_mt7622_infracfg_remove,
+};
+module_platform_driver(clk_mt7622_infracfg_drv);
+
+MODULE_DESCRIPTION("MediaTek MT7622 infracfg clocks driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt7622.c b/drivers/clk/mediatek/clk-mt7622.c
index 6cf74c948ac7..fb813f8d3a7d 100644
--- a/drivers/clk/mediatek/clk-mt7622.c
+++ b/drivers/clk/mediatek/clk-mt7622.c
@@ -18,9 +18,6 @@
 #include <dt-bindings/clock/mt7622-clk.h>
 #include <linux/clk.h> /* for consumer */
 
-#define GATE_INFRA(_id, _name, _parent, _shift)				\
-	GATE_MTK(_id, _name, _parent, &infra_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
-
 #define GATE_TOP0(_id, _name, _parent, _shift)				\
 	GATE_MTK(_id, _name, _parent, &top0_cg_regs, _shift, &mtk_clk_gate_ops_no_setclr)
 
@@ -39,13 +36,6 @@
 
 static DEFINE_SPINLOCK(mt7622_clk_lock);
 
-static const char * const infra_mux1_parents[] = {
-	"clkxtal",
-	"armpll",
-	"main_core_en",
-	"armpll"
-};
-
 static const char * const axi_parents[] = {
 	"clkxtal",
 	"syspll1_d2",
@@ -225,12 +215,6 @@ static const char * const peribus_ck_parents[] = {
 	"syspll1_d4"
 };
 
-static const struct mtk_gate_regs infra_cg_regs = {
-	.set_ofs = 0x40,
-	.clr_ofs = 0x44,
-	.sta_ofs = 0x48,
-};
-
 static const struct mtk_gate_regs top0_cg_regs = {
 	.set_ofs = 0x120,
 	.clr_ofs = 0x120,
@@ -255,15 +239,6 @@ static const struct mtk_gate_regs peri1_cg_regs = {
 	.sta_ofs = 0x1C,
 };
 
-static const struct mtk_gate infra_clks[] = {
-	GATE_INFRA(CLK_INFRA_DBGCLK_PD, "infra_dbgclk_pd", "axi_sel", 0),
-	GATE_INFRA(CLK_INFRA_TRNG, "trng_ck", "axi_sel", 2),
-	GATE_INFRA(CLK_INFRA_AUDIO_PD, "infra_audio_pd", "aud_intbus_sel", 5),
-	GATE_INFRA(CLK_INFRA_IRRX_PD, "infra_irrx_pd", "irrx_sel", 16),
-	GATE_INFRA(CLK_INFRA_APXGPT_PD, "infra_apxgpt_pd", "f10m_ref_sel", 18),
-	GATE_INFRA(CLK_INFRA_PMIC_PD, "infra_pmic_pd", "pmicspi_sel", 22),
-};
-
 static const struct mtk_fixed_clk top_fixed_clks[] = {
 	FIXED_CLK(CLK_TOP_TO_U2_PHY, "to_u2_phy", "clkxtal",
 		  31250000),
@@ -408,11 +383,6 @@ static const struct mtk_gate peri_clks[] = {
 	GATE_PERI1(CLK_PERI_IRTX_PD, "peri_irtx_pd", "irtx_sel", 2),
 };
 
-static struct mtk_composite infra_muxes[] = {
-	MUX(CLK_INFRA_MUX1_SEL, "infra_mux1_sel", infra_mux1_parents,
-	    0x000, 2, 2),
-};
-
 static struct mtk_composite top_muxes[] = {
 	/* CLK_CFG_0 */
 	MUX_GATE_FLAGS(CLK_TOP_AXI_SEL, "axi_sel", axi_parents,
@@ -512,22 +482,12 @@ static struct mtk_composite peri_muxes[] = {
 	MUX(CLK_PERIBUS_SEL, "peribus_ck_sel", peribus_ck_parents, 0x05C, 0, 1),
 };
 
-static u16 infrasys_rst_ofs[] = { 0x30, };
 static u16 pericfg_rst_ofs[] = { 0x0, 0x4, };
 
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
+static const struct mtk_clk_rst_desc clk_rst_desc = {
+	.version = MTK_RST_SIMPLE,
+	.rst_bank_ofs = pericfg_rst_ofs,
+	.rst_bank_nr = ARRAY_SIZE(pericfg_rst_ofs),
 };
 
 static int mtk_topckgen_init(struct platform_device *pdev)
@@ -561,31 +521,6 @@ static int mtk_topckgen_init(struct platform_device *pdev)
 	return of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 }
 
-static int mtk_infrasys_init(struct platform_device *pdev)
-{
-	struct device_node *node = pdev->dev.of_node;
-	struct clk_hw_onecell_data *clk_data;
-	int r;
-
-	clk_data = mtk_alloc_clk_data(CLK_INFRA_NR_CLK);
-
-	mtk_clk_register_gates(&pdev->dev, node, infra_clks,
-			       ARRAY_SIZE(infra_clks), clk_data);
-
-	mtk_clk_register_cpumuxes(&pdev->dev, node, infra_muxes,
-				  ARRAY_SIZE(infra_muxes), clk_data);
-
-	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get,
-				   clk_data);
-	if (r)
-		return r;
-
-	mtk_register_reset_controller_with_dev(&pdev->dev, &clk_rst_desc[0]);
-
-	return 0;
-}
-
-
 static int mtk_pericfg_init(struct platform_device *pdev)
 {
 	struct clk_hw_onecell_data *clk_data;
@@ -610,16 +545,13 @@ static int mtk_pericfg_init(struct platform_device *pdev)
 	if (r)
 		return r;
 
-	mtk_register_reset_controller_with_dev(&pdev->dev, &clk_rst_desc[1]);
+	mtk_register_reset_controller_with_dev(&pdev->dev, &clk_rst_desc);
 
 	return 0;
 }
 
 static const struct of_device_id of_match_clk_mt7622[] = {
 	{
-		.compatible = "mediatek,mt7622-infracfg",
-		.data = mtk_infrasys_init,
-	}, {
 		.compatible = "mediatek,mt7622-topckgen",
 		.data = mtk_topckgen_init,
 	}, {
-- 
2.39.2

