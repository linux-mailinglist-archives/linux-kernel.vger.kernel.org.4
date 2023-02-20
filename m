Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14D0669D02F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 16:05:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232898AbjBTPFO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 10:05:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232869AbjBTPEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 10:04:41 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F4771D913;
        Mon, 20 Feb 2023 07:02:55 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D9F2F6602136;
        Mon, 20 Feb 2023 15:02:30 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676905352;
        bh=h+DBC5isCqQIqQmrUysGMFQN8g+3IzpdI5PPG7viLGE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A2ceCJbfBSKEmQFDH+EWebqM9Cc93iP8qNiN0OkED5GaFGGa5zicJcBmk5rOr4Sth
         TlijcFbIjwCDa8v23aV3eZwwFU1HWYcHoPacf4v8AWwDecyw3MlwAJdnP0mAKvFmrj
         SO5pZz8tqTcs4Sn3W0arqz3zcP77Czj3DcFybzy1gyjxIcXJYdKfB0X1/863VC+L+p
         LWrXjRJ+MfVn7d+tLjpzCmW2aIoAhSn0y7hcAaqNi4uwJtVoGZnLeTC/SbT/b9Er5C
         F0IPJrEdpP1x4LXObTojyNundP0m/fugvq97mxTyw8tZYWBl7CC+kwMgxSGrGSnFyM
         JGpSg3Am/BxUw==
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
        linux-mediatek@lists.infradead.org
Subject: [PATCH v3 54/55] clk: mediatek: mt8135: Convert to simple probe and enable module build
Date:   Mon, 20 Feb 2023 16:01:10 +0100
Message-Id: <20230220150111.77897-55-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230220150111.77897-1-angelogioacchino.delregno@collabora.com>
References: <20230220150111.77897-1-angelogioacchino.delregno@collabora.com>
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

Convert the MT8135 clock drivers to platform_driver using the common
simple probe mechanism.

Now that all of the MT8135 clock drivers (including apmixedsys) can
be compiled as modules, change the COMMON_CLK_MT8135 configuration
option to tristate to enable module build.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/clk/mediatek/Kconfig      |   2 +-
 drivers/clk/mediatek/clk-mt8135.c | 110 ++++++++++++------------------
 2 files changed, 43 insertions(+), 69 deletions(-)

diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
index 90691261cddb..a15fbdfd3a53 100644
--- a/drivers/clk/mediatek/Kconfig
+++ b/drivers/clk/mediatek/Kconfig
@@ -423,7 +423,7 @@ config COMMON_CLK_MT7986_ETHSYS
 	  required on MediaTek MT7986 SoC.
 
 config COMMON_CLK_MT8135
-	bool "Clock driver for MediaTek MT8135"
+	tristate "Clock driver for MediaTek MT8135"
 	depends on (ARCH_MEDIATEK && ARM) || COMPILE_TEST
 	select COMMON_CLK_MEDIATEK
 	default ARCH_MEDIATEK && ARM
diff --git a/drivers/clk/mediatek/clk-mt8135.c b/drivers/clk/mediatek/clk-mt8135.c
index 8785d58cb3a5..39fd919900e5 100644
--- a/drivers/clk/mediatek/clk-mt8135.c
+++ b/drivers/clk/mediatek/clk-mt8135.c
@@ -5,8 +5,10 @@
  */
 
 #include <linux/clk.h>
+#include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
+#include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/mfd/syscon.h>
 #include <dt-bindings/clock/mt8135-clk.h>
@@ -18,6 +20,7 @@
 static DEFINE_SPINLOCK(mt8135_clk_lock);
 
 static const struct mtk_fixed_factor top_divs[] __initconst = {
+	FACTOR(CLK_DUMMY, "top_divs_dummy", "clk_null", 1, 1),
 	FACTOR(CLK_TOP_DSI0_LNTC_DSICLK, "dsi0_lntc_dsiclk", "clk_null", 1, 1),
 	FACTOR(CLK_TOP_HDMITX_CLKDIG_CTS, "hdmitx_clkdig_cts", "clk_null", 1, 1),
 	FACTOR(CLK_TOP_CLKPH_MCK, "clkph_mck", "clk_null", 1, 1),
@@ -407,6 +410,7 @@ static const struct mtk_gate_regs infra_cg_regs = {
 		       &mtk_clk_gate_ops_setclr, CLK_IS_CRITICAL)
 
 static const struct mtk_gate infra_clks[] __initconst = {
+	GATE_DUMMY(CLK_DUMMY, "infra_dummy"),
 	GATE_ICG(CLK_INFRA_PMIC_WRAP, "pmic_wrap_ck", "axi_sel", 23),
 	GATE_ICG(CLK_INFRA_PMICSPI, "pmicspi_ck", "pmicspi_sel", 22),
 	GATE_ICG(CLK_INFRA_CCIF1_AP_CTRL, "ccif1_ap_ctrl", "axi_sel", 21),
@@ -441,6 +445,7 @@ static const struct mtk_gate_regs peri1_cg_regs = {
 	GATE_MTK(_id, _name, _parent, &peri1_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
 
 static const struct mtk_gate peri_gates[] __initconst = {
+	GATE_DUMMY(CLK_DUMMY, "peri_dummy"),
 	/* PERI0 */
 	GATE_PERI0(CLK_PERI_I2C5, "i2c5_ck", "axi_sel", 31),
 	GATE_PERI0(CLK_PERI_I2C4, "i2c4_ck", "axi_sel", 30),
@@ -516,77 +521,46 @@ static const struct mtk_clk_rst_desc clk_rst_desc[] = {
 	}
 };
 
-static void __init mtk_topckgen_init(struct device_node *node)
-{
-	struct clk_hw_onecell_data *clk_data;
-	void __iomem *base;
-	int r;
-
-	base = of_iomap(node, 0);
-	if (!base) {
-		pr_err("%s(): ioremap failed\n", __func__);
-		return;
-	}
+static const struct mtk_clk_desc infra_desc = {
+	.clks = infra_clks,
+	.num_clks = ARRAY_SIZE(infra_clks),
+	.rst_desc = &clk_rst_desc[0],
+};
 
-	clk_data = mtk_alloc_clk_data(CLK_TOP_NR_CLK);
-
-	mtk_clk_register_factors(top_divs, ARRAY_SIZE(top_divs), clk_data);
-	mtk_clk_register_composites(NULL, top_muxes,
-				    ARRAY_SIZE(top_muxes), base,
-				    &mt8135_clk_lock, clk_data);
-
-	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
-	if (r)
-		pr_err("%s(): could not register clock provider: %d\n",
-			__func__, r);
-}
-CLK_OF_DECLARE(mtk_topckgen, "mediatek,mt8135-topckgen", mtk_topckgen_init);
-
-static void __init mtk_infrasys_init(struct device_node *node)
-{
-	struct clk_hw_onecell_data *clk_data;
-	int r;
-
-	clk_data = mtk_alloc_clk_data(CLK_INFRA_NR_CLK);
-
-	mtk_clk_register_gates(NULL, node, infra_clks,
-			       ARRAY_SIZE(infra_clks), clk_data);
-
-	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
-	if (r)
-		pr_err("%s(): could not register clock provider: %d\n",
-			__func__, r);
-
-	mtk_register_reset_controller(node, &clk_rst_desc[0]);
-}
-CLK_OF_DECLARE(mtk_infrasys, "mediatek,mt8135-infracfg", mtk_infrasys_init);
-
-static void __init mtk_pericfg_init(struct device_node *node)
-{
-	struct clk_hw_onecell_data *clk_data;
-	int r;
-	void __iomem *base;
-
-	base = of_iomap(node, 0);
-	if (!base) {
-		pr_err("%s(): ioremap failed\n", __func__);
-		return;
-	}
+static const struct mtk_clk_desc peri_desc = {
+	.clks = peri_gates,
+	.num_clks = ARRAY_SIZE(peri_gates),
+	.composite_clks = peri_clks,
+	.num_composite_clks = ARRAY_SIZE(peri_clks),
+	.clk_lock = &mt8135_clk_lock,
+	.rst_desc = &clk_rst_desc[1],
+};
 
-	clk_data = mtk_alloc_clk_data(CLK_PERI_NR_CLK);
+static const struct mtk_clk_desc topck_desc = {
+	.factor_clks = top_divs,
+	.num_factor_clks = ARRAY_SIZE(top_divs),
+	.composite_clks = top_muxes,
+	.num_composite_clks = ARRAY_SIZE(top_muxes),
+	.clk_lock = &mt8135_clk_lock,
+};
 
-	mtk_clk_register_gates(NULL, node, peri_gates,
-			       ARRAY_SIZE(peri_gates), clk_data);
-	mtk_clk_register_composites(NULL, peri_clks,
-				    ARRAY_SIZE(peri_clks), base,
-				    &mt8135_clk_lock, clk_data);
+static const struct of_device_id of_match_clk_mt8135[] = {
+	{ .compatible = "mediatek,mt8135-infracfg", .data = &infra_desc },
+	{ .compatible = "mediatek,mt8135-pericfg", .data = &peri_desc },
+	{ .compatible = "mediatek,mt8135-topckgen", .data = &topck_desc },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, of_match_clk_mt8135);
 
-	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
-	if (r)
-		pr_err("%s(): could not register clock provider: %d\n",
-			__func__, r);
+static struct platform_driver clk_mt8135_drv = {
+	.driver = {
+		.name = "clk-mt8135",
+		.of_match_table = of_match_clk_mt8135,
+	},
+	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
+};
+module_platform_driver(clk_mt8135_drv);
 
-	mtk_register_reset_controller(node, &clk_rst_desc[1]);
-}
-CLK_OF_DECLARE(mtk_pericfg, "mediatek,mt8135-pericfg", mtk_pericfg_init);
+MODULE_DESCRIPTION("MediaTek MT8135 clocks driver");
 MODULE_LICENSE("GPL");
-- 
2.39.1

