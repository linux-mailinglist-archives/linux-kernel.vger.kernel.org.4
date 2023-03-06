Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1A636AC2AA
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 15:11:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231503AbjCFOLw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 09:11:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231439AbjCFOLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 09:11:07 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C047D32E46;
        Mon,  6 Mar 2023 06:09:16 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C9F226602EE4;
        Mon,  6 Mar 2023 14:07:12 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1678111634;
        bh=6RsoMSUKbuFrGrHciY1yya3bkWjwkg0jDVxNFiChlXE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ql8K0O0VM80+SmLYFl8vdq0AUHzNZFEVXGoMu93raV+fIP4Q2c22uhMmqq5Kr/y87
         WETtj0jLpnymKnKkX7QvRrkvyAWx8lEYO6SnjkpDU2MNNSw6acyR/X+lw/reLwr4Wq
         NJ9x6P2MvrYxb+tZ/nR5LomFAemurIqmeTXjhYXnVEIe0mSyFcXMjWZmsuL8M7Psgn
         qI9e67EAs0RF/h/XB6hYqwFB4OucRx/u5ZLnKO6Ttxbbx701Rg6iDpC4L7TQ3xiHOj
         mjU/J7fAVU2xytJQkeq0utOGh4h0hjBobDG09qiCGC2gZ+oRR3GQKPvxMRWCS4mt4z
         FzOwVTznlUwzA==
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
Subject: [PATCH v6 54/54] clk: mediatek: mt8135: Convert to simple probe and enable module build
Date:   Mon,  6 Mar 2023 15:05:43 +0100
Message-Id: <20230306140543.1813621-55-angelogioacchino.delregno@collabora.com>
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

Convert the MT8135 clock drivers to platform_driver using the common
simple probe mechanism; special note goes to the introduction of
dummy clocks with ID 0 (where 0 is the first entry of a clock array)
for each clock controller: this was necessary because of a mistake
in the bindings for all MT8135 clock controllers, where the first
clock has ID 1 (hence, array would start from element 1) instead of
zero.

Now that all of the MT8135 clock drivers (including apmixedsys) can
be compiled as modules, change the COMMON_CLK_MT8135 configuration
option to tristate to enable module build.

While at it, also remove the __initconst annotation from all of the
clock arrays as they are not only used during init anymore, but also
during runtime.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/clk/mediatek/Kconfig      |   2 +-
 drivers/clk/mediatek/clk-mt8135.c | 176 +++++++++++++-----------------
 2 files changed, 76 insertions(+), 102 deletions(-)

diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
index 02093996ccc3..7a12aefb1d0b 100644
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
index 8785d58cb3a5..084e48a554c2 100644
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
@@ -17,7 +19,8 @@
 
 static DEFINE_SPINLOCK(mt8135_clk_lock);
 
-static const struct mtk_fixed_factor top_divs[] __initconst = {
+static const struct mtk_fixed_factor top_divs[] = {
+	FACTOR(CLK_DUMMY, "top_divs_dummy", "clk_null", 1, 1),
 	FACTOR(CLK_TOP_DSI0_LNTC_DSICLK, "dsi0_lntc_dsiclk", "clk_null", 1, 1),
 	FACTOR(CLK_TOP_HDMITX_CLKDIG_CTS, "hdmitx_clkdig_cts", "clk_null", 1, 1),
 	FACTOR(CLK_TOP_CLKPH_MCK, "clkph_mck", "clk_null", 1, 1),
@@ -98,7 +101,7 @@ static const struct mtk_fixed_factor top_divs[] __initconst = {
 	FACTOR(CLK_TOP_MEMPLL_MCK_D4, "mempll_mck_d4", "clkph_mck", 1, 4),
 };
 
-static const char * const axi_parents[] __initconst = {
+static const char * const axi_parents[] = {
 	"clk26m",
 	"syspll_d3",
 	"syspll_d4",
@@ -108,7 +111,7 @@ static const char * const axi_parents[] __initconst = {
 	"syspll_d3p5"
 };
 
-static const char * const smi_parents[] __initconst = {
+static const char * const smi_parents[] = {
 	"clk26m",
 	"clkph_mck",
 	"syspll_d2p5",
@@ -126,7 +129,7 @@ static const char * const smi_parents[] __initconst = {
 	"lvdspll"
 };
 
-static const char * const mfg_parents[] __initconst = {
+static const char * const mfg_parents[] = {
 	"clk26m",
 	"univpll1_d4",
 	"syspll_d2",
@@ -142,13 +145,13 @@ static const char * const mfg_parents[] __initconst = {
 	"mmpll_d7"
 };
 
-static const char * const irda_parents[] __initconst = {
+static const char * const irda_parents[] = {
 	"clk26m",
 	"univpll2_d8",
 	"univpll1_d6"
 };
 
-static const char * const cam_parents[] __initconst = {
+static const char * const cam_parents[] = {
 	"clk26m",
 	"syspll_d3",
 	"syspll_d3p5",
@@ -159,13 +162,13 @@ static const char * const cam_parents[] __initconst = {
 	"univpll1_d4"
 };
 
-static const char * const aud_intbus_parents[] __initconst = {
+static const char * const aud_intbus_parents[] = {
 	"clk26m",
 	"syspll_d6",
 	"univpll_d10"
 };
 
-static const char * const jpg_parents[] __initconst = {
+static const char * const jpg_parents[] = {
 	"clk26m",
 	"syspll_d5",
 	"syspll_d4",
@@ -175,7 +178,7 @@ static const char * const jpg_parents[] __initconst = {
 	"univpll_d5"
 };
 
-static const char * const disp_parents[] __initconst = {
+static const char * const disp_parents[] = {
 	"clk26m",
 	"syspll_d3p5",
 	"syspll_d3",
@@ -186,7 +189,7 @@ static const char * const disp_parents[] __initconst = {
 	"vdecpll"
 };
 
-static const char * const msdc30_parents[] __initconst = {
+static const char * const msdc30_parents[] = {
 	"clk26m",
 	"syspll_d6",
 	"syspll_d5",
@@ -195,13 +198,13 @@ static const char * const msdc30_parents[] __initconst = {
 	"msdcpll"
 };
 
-static const char * const usb20_parents[] __initconst = {
+static const char * const usb20_parents[] = {
 	"clk26m",
 	"univpll2_d6",
 	"univpll1_d10"
 };
 
-static const char * const venc_parents[] __initconst = {
+static const char * const venc_parents[] = {
 	"clk26m",
 	"syspll_d3",
 	"syspll_d8",
@@ -212,7 +215,7 @@ static const char * const venc_parents[] __initconst = {
 	"mmpll_d6"
 };
 
-static const char * const spi_parents[] __initconst = {
+static const char * const spi_parents[] = {
 	"clk26m",
 	"syspll_d6",
 	"syspll_d8",
@@ -221,17 +224,17 @@ static const char * const spi_parents[] __initconst = {
 	"univpll1_d8"
 };
 
-static const char * const uart_parents[] __initconst = {
+static const char * const uart_parents[] = {
 	"clk26m",
 	"univpll2_d8"
 };
 
-static const char * const mem_parents[] __initconst = {
+static const char * const mem_parents[] = {
 	"clk26m",
 	"clkph_mck"
 };
 
-static const char * const camtg_parents[] __initconst = {
+static const char * const camtg_parents[] = {
 	"clk26m",
 	"univpll_d26",
 	"univpll1_d6",
@@ -239,12 +242,12 @@ static const char * const camtg_parents[] __initconst = {
 	"syspll_d8"
 };
 
-static const char * const audio_parents[] __initconst = {
+static const char * const audio_parents[] = {
 	"clk26m",
 	"syspll_d24"
 };
 
-static const char * const fix_parents[] __initconst = {
+static const char * const fix_parents[] = {
 	"rtc32k",
 	"clk26m",
 	"univpll_d5",
@@ -255,7 +258,7 @@ static const char * const fix_parents[] __initconst = {
 	"univpll1_d8"
 };
 
-static const char * const vdec_parents[] __initconst = {
+static const char * const vdec_parents[] = {
 	"clk26m",
 	"vdecpll",
 	"clkph_mck",
@@ -274,13 +277,13 @@ static const char * const vdec_parents[] __initconst = {
 	"lvdspll"
 };
 
-static const char * const ddrphycfg_parents[] __initconst = {
+static const char * const ddrphycfg_parents[] = {
 	"clk26m",
 	"axi_sel",
 	"syspll_d12"
 };
 
-static const char * const dpilvds_parents[] __initconst = {
+static const char * const dpilvds_parents[] = {
 	"clk26m",
 	"lvdspll",
 	"lvdspll_d2",
@@ -288,7 +291,7 @@ static const char * const dpilvds_parents[] __initconst = {
 	"lvdspll_d8"
 };
 
-static const char * const pmicspi_parents[] __initconst = {
+static const char * const pmicspi_parents[] = {
 	"clk26m",
 	"univpll2_d6",
 	"syspll_d8",
@@ -299,14 +302,14 @@ static const char * const pmicspi_parents[] __initconst = {
 	"syspll_d24"
 };
 
-static const char * const smi_mfg_as_parents[] __initconst = {
+static const char * const smi_mfg_as_parents[] = {
 	"clk26m",
 	"smi_sel",
 	"mfg_sel",
 	"mem_sel"
 };
 
-static const char * const gcpu_parents[] __initconst = {
+static const char * const gcpu_parents[] = {
 	"clk26m",
 	"syspll_d4",
 	"univpll_d7",
@@ -314,14 +317,14 @@ static const char * const gcpu_parents[] __initconst = {
 	"syspll_d6"
 };
 
-static const char * const dpi1_parents[] __initconst = {
+static const char * const dpi1_parents[] = {
 	"clk26m",
 	"tvhdmi_h_ck",
 	"tvhdmi_d2",
 	"tvhdmi_d4"
 };
 
-static const char * const cci_parents[] __initconst = {
+static const char * const cci_parents[] = {
 	"clk26m",
 	"mainpll_537p3m",
 	"univpll_d3",
@@ -330,7 +333,7 @@ static const char * const cci_parents[] __initconst = {
 	"syspll_d5"
 };
 
-static const char * const apll_parents[] __initconst = {
+static const char * const apll_parents[] = {
 	"clk26m",
 	"apll_ck",
 	"apll_d4",
@@ -339,14 +342,14 @@ static const char * const apll_parents[] __initconst = {
 	"apll_d24"
 };
 
-static const char * const hdmipll_parents[] __initconst = {
+static const char * const hdmipll_parents[] = {
 	"clk26m",
 	"hdmitx_clkdig_cts",
 	"hdmitx_clkdig_d2",
 	"hdmitx_clkdig_d3"
 };
 
-static const struct mtk_composite top_muxes[] __initconst = {
+static const struct mtk_composite top_muxes[] = {
 	/* CLK_CFG_0 */
 	MUX_GATE(CLK_TOP_AXI_SEL, "axi_sel", axi_parents,
 		0x0140, 0, 3, INVALID_MUX_GATE_BIT),
@@ -406,7 +409,8 @@ static const struct mtk_gate_regs infra_cg_regs = {
 	GATE_MTK_FLAGS(_id, _name, _parent, &infra_cg_regs, _shift,	\
 		       &mtk_clk_gate_ops_setclr, CLK_IS_CRITICAL)
 
-static const struct mtk_gate infra_clks[] __initconst = {
+static const struct mtk_gate infra_clks[] = {
+	GATE_DUMMY(CLK_DUMMY, "infra_dummy"),
 	GATE_ICG(CLK_INFRA_PMIC_WRAP, "pmic_wrap_ck", "axi_sel", 23),
 	GATE_ICG(CLK_INFRA_PMICSPI, "pmicspi_ck", "pmicspi_sel", 22),
 	GATE_ICG(CLK_INFRA_CCIF1_AP_CTRL, "ccif1_ap_ctrl", "axi_sel", 21),
@@ -440,7 +444,8 @@ static const struct mtk_gate_regs peri1_cg_regs = {
 #define GATE_PERI1(_id, _name, _parent, _shift)	\
 	GATE_MTK(_id, _name, _parent, &peri1_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
 
-static const struct mtk_gate peri_gates[] __initconst = {
+static const struct mtk_gate peri_gates[] = {
+	GATE_DUMMY(CLK_DUMMY, "peri_dummy"),
 	/* PERI0 */
 	GATE_PERI0(CLK_PERI_I2C5, "i2c5_ck", "axi_sel", 31),
 	GATE_PERI0(CLK_PERI_I2C4, "i2c4_ck", "axi_sel", 30),
@@ -486,12 +491,12 @@ static const struct mtk_gate peri_gates[] __initconst = {
 	GATE_PERI1(CLK_PERI_I2C6, "i2c6_ck", "axi_sel", 0),
 };
 
-static const char * const uart_ck_sel_parents[] __initconst = {
+static const char * const uart_ck_sel_parents[] = {
 	"clk26m",
 	"uart_sel",
 };
 
-static const struct mtk_composite peri_clks[] __initconst = {
+static const struct mtk_composite peri_clks[] = {
 	MUX(CLK_PERI_UART0_SEL, "uart0_ck_sel", uart_ck_sel_parents, 0x40c, 0, 1),
 	MUX(CLK_PERI_UART1_SEL, "uart1_ck_sel", uart_ck_sel_parents, 0x40c, 1, 1),
 	MUX(CLK_PERI_UART2_SEL, "uart2_ck_sel", uart_ck_sel_parents, 0x40c, 2, 1),
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
2.39.2

