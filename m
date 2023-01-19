Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B80A9673B74
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 15:14:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231608AbjASOOe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 09:14:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231654AbjASONv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 09:13:51 -0500
Received: from fudo.makrotopia.org (fudo.makrotopia.org [IPv6:2a07:2ec0:3002::71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E9714C6D8;
        Thu, 19 Jan 2023 06:13:08 -0800 (PST)
Received: from local
        by fudo.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96)
        (envelope-from <daniel@makrotopia.org>)
        id 1pIVf5-0008NH-3B;
        Thu, 19 Jan 2023 15:13:04 +0100
Date:   Thu, 19 Jan 2023 14:12:56 +0000
From:   Daniel Golle <daniel@makrotopia.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Miles Chen <miles.chen@mediatek.com>,
        Edward-JW Yang <edward-jw.yang@mediatek.com>,
        Johnson Wang <johnson.wang@mediatek.com>,
        Fabien Parent <fparent@baylibre.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Sam Shih <sam.shih@mediatek.com>,
        Jianhui Zhao <zhaojh329@gmail.com>
Subject: [PATCH 2/2] clk: mediatek: add MT7981 clock support
Message-ID: <d1718b4f9887664e56b56019b8d21470407c4aaf.1674137304.git.daniel@makrotopia.org>
References: <cover.1674137304.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1674137304.git.daniel@makrotopia.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MT7986 clock support, include topckgen, apmixedsys, infracfg and
ethernet subsystem clocks.

The drivers are based on clk-mt7981.c which can be found in MediaTek's
SDK sources. To be fit for upstream inclusion the driver has been split
into clock domains and the infracfg part has been significantly
de-bloated by removing all the 1:1 factors (aliases).

Signed-off-by: Jianhui Zhao <zhaojh329@gmail.com>
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/clk/mediatek/Kconfig               |  17 +
 drivers/clk/mediatek/Makefile              |   4 +
 drivers/clk/mediatek/clk-mt7981-apmixed.c  | 103 +++++
 drivers/clk/mediatek/clk-mt7981-eth.c      | 138 +++++++
 drivers/clk/mediatek/clk-mt7981-infracfg.c | 236 +++++++++++
 drivers/clk/mediatek/clk-mt7981-topckgen.c | 431 +++++++++++++++++++++
 include/dt-bindings/clock/mt7981-clk.h     | 215 ++++++++++
 7 files changed, 1144 insertions(+)
 create mode 100644 drivers/clk/mediatek/clk-mt7981-apmixed.c
 create mode 100644 drivers/clk/mediatek/clk-mt7981-eth.c
 create mode 100644 drivers/clk/mediatek/clk-mt7981-infracfg.c
 create mode 100644 drivers/clk/mediatek/clk-mt7981-topckgen.c
 create mode 100644 include/dt-bindings/clock/mt7981-clk.h

diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
index 22e8e79475ee4..c20d03895f382 100644
--- a/drivers/clk/mediatek/Kconfig
+++ b/drivers/clk/mediatek/Kconfig
@@ -388,6 +388,23 @@ config COMMON_CLK_MT7629_HIFSYS
 	  This driver supports MediaTek MT7629 HIFSYS clocks providing
 	  to PCI-E and USB.
 
+config COMMON_CLK_MT7981
+	bool "Clock driver for MediaTek MT7981"
+	depends on ARCH_MEDIATEK || COMPILE_TEST
+	select COMMON_CLK_MEDIATEK
+	default ARCH_MEDIATEK
+	help
+	  This driver supports MediaTek MT7981 basic clocks and clocks
+	  required for various peripherals found on this SoC.
+
+config COMMON_CLK_MT7981_ETHSYS
+	bool "Clock driver for MediaTek MT7981 ETHSYS"
+	depends on COMMON_CLK_MT7981
+	default COMMON_CLK_MT7981
+	help
+	  This driver adds support for clocks for Ethernet and SGMII
+	  required on MediaTek MT7981 SoC.
+
 config COMMON_CLK_MT7986
 	bool "Clock driver for MediaTek MT7986"
 	depends on ARCH_MEDIATEK || COMPILE_TEST
diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
index e24080fd6e7f7..5d6f3cd34acee 100644
--- a/drivers/clk/mediatek/Makefile
+++ b/drivers/clk/mediatek/Makefile
@@ -53,6 +53,10 @@ obj-$(CONFIG_COMMON_CLK_MT7622_AUDSYS) += clk-mt7622-aud.o
 obj-$(CONFIG_COMMON_CLK_MT7629) += clk-mt7629.o
 obj-$(CONFIG_COMMON_CLK_MT7629_ETHSYS) += clk-mt7629-eth.o
 obj-$(CONFIG_COMMON_CLK_MT7629_HIFSYS) += clk-mt7629-hif.o
+obj-$(CONFIG_COMMON_CLK_MT7981) += clk-mt7981-apmixed.o
+obj-$(CONFIG_COMMON_CLK_MT7981) += clk-mt7981-topckgen.o
+obj-$(CONFIG_COMMON_CLK_MT7981) += clk-mt7981-infracfg.o
+obj-$(CONFIG_COMMON_CLK_MT7981_ETHSYS) += clk-mt7981-eth.o
 obj-$(CONFIG_COMMON_CLK_MT7986) += clk-mt7986-apmixed.o
 obj-$(CONFIG_COMMON_CLK_MT7986) += clk-mt7986-topckgen.o
 obj-$(CONFIG_COMMON_CLK_MT7986) += clk-mt7986-infracfg.o
diff --git a/drivers/clk/mediatek/clk-mt7981-apmixed.c b/drivers/clk/mediatek/clk-mt7981-apmixed.c
new file mode 100644
index 0000000000000..b517d20b5fdec
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt7981-apmixed.c
@@ -0,0 +1,103 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2021 MediaTek Inc.
+ * Author: Sam Shih <sam.shih@mediatek.com>
+ * Author: Wenzhen Yu <wenzhen.yu@mediatek.com>
+ * Author: Jianhui Zhao <zhaojh329@gmail.com>
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+
+#include "clk-gate.h"
+#include "clk-mtk.h"
+#include "clk-mux.h"
+#include "clk-pll.h"
+
+#include <dt-bindings/clock/mt7981-clk.h>
+#include <linux/clk.h>
+
+#define MT7981_PLL_FMAX (2500UL * MHZ)
+#define CON0_MT7981_RST_BAR BIT(27)
+
+#define PLL_xtal(_id, _name, _reg, _pwr_reg, _en_mask, _flags, _pcwbits,       \
+		 _pd_reg, _pd_shift, _tuner_reg, _pcw_reg, _pcw_shift,         \
+		 _div_table, _parent_name)                                     \
+	{                                                                      \
+		.id = _id, .name = _name, .reg = _reg, .pwr_reg = _pwr_reg,    \
+		.en_mask = _en_mask, .flags = _flags,                          \
+		.rst_bar_mask = CON0_MT7981_RST_BAR, .fmax = MT7981_PLL_FMAX,  \
+		.pcwbits = _pcwbits, .pd_reg = _pd_reg, .pd_shift = _pd_shift, \
+		.tuner_reg = _tuner_reg, .pcw_reg = _pcw_reg,                  \
+		.pcw_shift = _pcw_shift, .div_table = _div_table,              \
+		.parent_name = _parent_name,                                   \
+	}
+
+#define PLL(_id, _name, _reg, _pwr_reg, _en_mask, _flags, _pcwbits, _pd_reg,   \
+	    _pd_shift, _tuner_reg, _pcw_reg, _pcw_shift)                       \
+	PLL_xtal(_id, _name, _reg, _pwr_reg, _en_mask, _flags, _pcwbits,       \
+		 _pd_reg, _pd_shift, _tuner_reg, _pcw_reg, _pcw_shift, NULL,   \
+		 "clkxtal")
+
+static const struct mtk_pll_data plls[] = {
+	PLL(CLK_APMIXED_ARMPLL, "armpll", 0x0200, 0x020C, 0x00000001, 0, 32,
+		0x0200, 4, 0, 0x0204, 0),
+	PLL(CLK_APMIXED_NET2PLL, "net2pll", 0x0210, 0x021C, 0x00000001, 0, 32,
+		0x0210, 4, 0, 0x0214, 0),
+	PLL(CLK_APMIXED_MMPLL, "mmpll", 0x0220, 0x022C, 0x00000001, 0, 32,
+		0x0220, 4, 0, 0x0224, 0),
+	PLL(CLK_APMIXED_SGMPLL, "sgmpll", 0x0230, 0x023C, 0x00000001, 0, 32,
+		0x0230, 4, 0, 0x0234, 0),
+	PLL(CLK_APMIXED_WEDMCUPLL, "wedmcupll", 0x0240, 0x024C, 0x00000001, 0, 32,
+		0x0240, 4, 0, 0x0244, 0),
+	PLL(CLK_APMIXED_NET1PLL, "net1pll", 0x0250, 0x025C, 0x00000001, 0, 32,
+		0x0250, 4, 0, 0x0254, 0),
+	PLL(CLK_APMIXED_MPLL, "mpll", 0x0260, 0x0270, 0x00000001, 0, 32,
+		0x0260, 4, 0, 0x0264, 0),
+	PLL(CLK_APMIXED_APLL2, "apll2", 0x0278, 0x0288, 0x00000001, 0, 32,
+		0x0278, 4, 0, 0x027C, 0),
+};
+
+static const struct of_device_id of_match_clk_mt7981_apmixed[] = {
+	{ .compatible = "mediatek,mt7981-apmixedsys", },
+	{}
+};
+
+static int clk_mt7981_apmixed_probe(struct platform_device *pdev)
+{
+	struct clk_hw_onecell_data *clk_data;
+	struct device_node *node = pdev->dev.of_node;
+	int r;
+
+	clk_data = mtk_alloc_clk_data(ARRAY_SIZE(plls));
+	if (!clk_data)
+		return -ENOMEM;
+
+	mtk_clk_register_plls(node, plls, ARRAY_SIZE(plls), clk_data);
+
+	clk_prepare_enable(clk_data->hws[CLK_APMIXED_ARMPLL]->clk);
+
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
+	if (r) {
+		pr_err("%s(): could not register clock provider: %d\n",
+		       __func__, r);
+		goto free_apmixed_data;
+	}
+	return r;
+
+free_apmixed_data:
+	mtk_free_clk_data(clk_data);
+	return r;
+}
+
+static struct platform_driver clk_mt7981_apmixed_drv = {
+	.probe = clk_mt7981_apmixed_probe,
+	.driver = {
+		.name = "clk-mt7981-apmixed",
+		.of_match_table = of_match_clk_mt7981_apmixed,
+	},
+};
+builtin_platform_driver(clk_mt7981_apmixed_drv);
diff --git a/drivers/clk/mediatek/clk-mt7981-eth.c b/drivers/clk/mediatek/clk-mt7981-eth.c
new file mode 100644
index 0000000000000..36f0fa222675b
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt7981-eth.c
@@ -0,0 +1,138 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2021 MediaTek Inc.
+ * Author: Sam Shih <sam.shih@mediatek.com>
+ * Author: Wenzhen Yu <wenzhen.yu@mediatek.com>
+ * Author: Jianhui Zhao <zhaojh329@gmail.com>
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+
+#include "clk-mtk.h"
+#include "clk-gate.h"
+
+#include <dt-bindings/clock/mt7981-clk.h>
+
+static const struct mtk_gate_regs sgmii0_cg_regs = {
+	.set_ofs = 0xE4,
+	.clr_ofs = 0xE4,
+	.sta_ofs = 0xE4,
+};
+
+#define GATE_SGMII0(_id, _name, _parent, _shift) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.regs = &sgmii0_cg_regs,		\
+		.shift = _shift,			\
+		.ops = &mtk_clk_gate_ops_no_setclr_inv,	\
+	}
+
+static const struct mtk_gate sgmii0_clks[] __initconst = {
+	GATE_SGMII0(CLK_SGM0_TX_EN, "sgm0_tx_en", "usb_tx250m", 2),
+	GATE_SGMII0(CLK_SGM0_RX_EN, "sgm0_rx_en", "usb_eq_rx250m", 3),
+	GATE_SGMII0(CLK_SGM0_CK0_EN, "sgm0_ck0_en", "usb_ln0", 4),
+	GATE_SGMII0(CLK_SGM0_CDR_CK0_EN, "sgm0_cdr_ck0_en", "usb_cdr", 5),
+};
+
+static const struct mtk_gate_regs sgmii1_cg_regs = {
+	.set_ofs = 0xE4,
+	.clr_ofs = 0xE4,
+	.sta_ofs = 0xE4,
+};
+
+#define GATE_SGMII1(_id, _name, _parent, _shift) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.regs = &sgmii1_cg_regs,		\
+		.shift = _shift,			\
+		.ops = &mtk_clk_gate_ops_no_setclr_inv,	\
+	}
+
+static const struct mtk_gate sgmii1_clks[] __initconst = {
+	GATE_SGMII1(CLK_SGM1_TX_EN, "sgm1_tx_en", "usb_tx250m", 2),
+	GATE_SGMII1(CLK_SGM1_RX_EN, "sgm1_rx_en", "usb_eq_rx250m", 3),
+	GATE_SGMII1(CLK_SGM1_CK1_EN, "sgm1_ck1_en", "usb_ln0", 4),
+	GATE_SGMII1(CLK_SGM1_CDR_CK1_EN, "sgm1_cdr_ck1_en", "usb_cdr", 5),
+};
+
+static const struct mtk_gate_regs eth_cg_regs = {
+	.set_ofs = 0x30,
+	.clr_ofs = 0x30,
+	.sta_ofs = 0x30,
+};
+
+#define GATE_ETH(_id, _name, _parent, _shift) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.regs = &eth_cg_regs,			\
+		.shift = _shift,			\
+		.ops = &mtk_clk_gate_ops_no_setclr_inv,	\
+	}
+
+static const struct mtk_gate eth_clks[] __initconst = {
+	GATE_ETH(CLK_ETH_FE_EN, "eth_fe_en", "netsys_2x", 6),
+	GATE_ETH(CLK_ETH_GP2_EN, "eth_gp2_en", "sgm_325m", 7),
+	GATE_ETH(CLK_ETH_GP1_EN, "eth_gp1_en", "sgm_325m", 8),
+	GATE_ETH(CLK_ETH_WOCPU0_EN, "eth_wocpu0_en", "netsys_wed_mcu", 15),
+};
+
+static void __init mtk_sgmiisys_0_init(struct device_node *node)
+{
+	struct clk_hw_onecell_data *clk_data;
+	int r;
+
+	clk_data = mtk_alloc_clk_data(ARRAY_SIZE(sgmii0_clks));
+
+	mtk_clk_register_gates(node, sgmii0_clks, ARRAY_SIZE(sgmii0_clks),
+			       clk_data);
+
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
+	if (r)
+		pr_err("%s(): could not register clock provider: %d\n",
+		       __func__, r);
+}
+CLK_OF_DECLARE(mtk_sgmiisys_0, "mediatek,mt7981-sgmiisys_0",
+	       mtk_sgmiisys_0_init);
+
+static void __init mtk_sgmiisys_1_init(struct device_node *node)
+{
+	struct clk_hw_onecell_data *clk_data;
+	int r;
+
+	clk_data = mtk_alloc_clk_data(ARRAY_SIZE(sgmii1_clks));
+
+	mtk_clk_register_gates(node, sgmii1_clks, ARRAY_SIZE(sgmii1_clks),
+			       clk_data);
+
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
+
+	if (r)
+		pr_err("%s(): could not register clock provider: %d\n",
+		       __func__, r);
+}
+CLK_OF_DECLARE(mtk_sgmiisys_1, "mediatek,mt7981-sgmiisys_1",
+	       mtk_sgmiisys_1_init);
+
+static void __init mtk_ethsys_init(struct device_node *node)
+{
+	struct clk_hw_onecell_data *clk_data;
+	int r;
+
+	clk_data = mtk_alloc_clk_data(ARRAY_SIZE(eth_clks));
+
+	mtk_clk_register_gates(node, eth_clks, ARRAY_SIZE(eth_clks), clk_data);
+
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
+
+	if (r)
+		pr_err("%s(): could not register clock provider: %d\n",
+		       __func__, r);
+}
+CLK_OF_DECLARE(mtk_ethsys, "mediatek,mt7981-ethsys", mtk_ethsys_init);
diff --git a/drivers/clk/mediatek/clk-mt7981-infracfg.c b/drivers/clk/mediatek/clk-mt7981-infracfg.c
new file mode 100644
index 0000000000000..e7d4eed7a253e
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt7981-infracfg.c
@@ -0,0 +1,236 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2021 MediaTek Inc.
+ * Author: Sam Shih <sam.shih@mediatek.com>
+ * Author: Wenzhen Yu <wenzhen.yu@mediatek.com>
+ * Author: Jianhui Zhao <zhaojh329@gmail.com>
+ * Author: Daniel Golle <daniel@makrotopia.org>
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include "clk-mtk.h"
+#include "clk-gate.h"
+#include "clk-mux.h"
+
+#include <dt-bindings/clock/mt7981-clk.h>
+#include <linux/clk.h>
+
+static DEFINE_SPINLOCK(mt7981_clk_lock);
+
+static const struct mtk_fixed_factor infra_divs[] = {
+	FACTOR(CLK_INFRA_66M_MCK, "infra_66m_mck", "sysaxi_sel", 1, 2),
+};
+
+static const char *const infra_uart_parent[] __initconst = { "csw_f26m_sel",
+								"uart_sel" };
+
+static const char *const infra_spi0_parents[] __initconst = { "i2c_sel",
+							      "spi_sel" };
+
+static const char *const infra_spi1_parents[] __initconst = { "i2c_sel",
+							      "spim_mst_sel" };
+
+static const char *const infra_pwm1_parents[] __initconst = { "pwm_sel" };
+
+static const char *const infra_pwm_bsel_parents[] __initconst = {
+	"cb_rtc_32p7k", "csw_f26m_sel", "infra_66m_mck", "pwm_sel"
+};
+
+static const char *const infra_pcie_parents[] __initconst = {
+	"cb_rtc_32p7k", "csw_f26m_sel", "cb_cksq_40m", "pextp_tl_ck_sel"
+};
+
+static const struct mtk_mux infra_muxes[] = {
+	/* MODULE_CLK_SEL_0 */
+	MUX_GATE_CLR_SET_UPD(CLK_INFRA_UART0_SEL, "infra_uart0_sel",
+			     infra_uart_parent, 0x0018, 0x0010, 0x0014, 0, 1,
+			     -1, -1, -1),
+	MUX_GATE_CLR_SET_UPD(CLK_INFRA_UART1_SEL, "infra_uart1_sel",
+			     infra_uart_parent, 0x0018, 0x0010, 0x0014, 1, 1,
+			     -1, -1, -1),
+	MUX_GATE_CLR_SET_UPD(CLK_INFRA_UART2_SEL, "infra_uart2_sel",
+			     infra_uart_parent, 0x0018, 0x0010, 0x0014, 2, 1,
+			     -1, -1, -1),
+	MUX_GATE_CLR_SET_UPD(CLK_INFRA_SPI0_SEL, "infra_spi0_sel",
+			     infra_spi0_parents, 0x0018, 0x0010, 0x0014, 4, 1,
+			     -1, -1, -1),
+	MUX_GATE_CLR_SET_UPD(CLK_INFRA_SPI1_SEL, "infra_spi1_sel",
+			     infra_spi1_parents, 0x0018, 0x0010, 0x0014, 5, 1,
+			     -1, -1, -1),
+	MUX_GATE_CLR_SET_UPD(CLK_INFRA_SPI2_SEL, "infra_spi2_sel",
+			     infra_spi0_parents, 0x0018, 0x0010, 0x0014, 6, 1,
+			     -1, -1, -1),
+	MUX_GATE_CLR_SET_UPD(CLK_INFRA_PWM1_SEL, "infra_pwm1_sel",
+			     infra_pwm1_parents, 0x0018, 0x0010, 0x0014, 9, 1,
+			     -1, -1, -1),
+	MUX_GATE_CLR_SET_UPD(CLK_INFRA_PWM2_SEL, "infra_pwm2_sel",
+			     infra_pwm1_parents, 0x0018, 0x0010, 0x0014, 11, 1,
+			     -1, -1, -1),
+	MUX_GATE_CLR_SET_UPD(CLK_INFRA_PWM3_SEL, "infra_pwm3_sel",
+			     infra_pwm1_parents, 0x0018, 0x0010, 0x0014, 15, 1,
+			     -1, -1, -1),
+	MUX_GATE_CLR_SET_UPD(CLK_INFRA_PWM_BSEL, "infra_pwm_bsel",
+			     infra_pwm_bsel_parents, 0x0018, 0x0010, 0x0014, 13,
+			     2, -1, -1, -1),
+	/* MODULE_CLK_SEL_1 */
+	MUX_GATE_CLR_SET_UPD(CLK_INFRA_PCIE_SEL, "infra_pcie_sel",
+			     infra_pcie_parents, 0x0028, 0x0020, 0x0024, 0, 2,
+			     -1, -1, -1),
+};
+
+static const struct mtk_gate_regs infra0_cg_regs = {
+	.set_ofs = 0x40,
+	.clr_ofs = 0x44,
+	.sta_ofs = 0x48,
+};
+
+static const struct mtk_gate_regs infra1_cg_regs = {
+	.set_ofs = 0x50,
+	.clr_ofs = 0x54,
+	.sta_ofs = 0x58,
+};
+
+static const struct mtk_gate_regs infra2_cg_regs = {
+	.set_ofs = 0x60,
+	.clr_ofs = 0x64,
+	.sta_ofs = 0x68,
+};
+
+#define GATE_INFRA0(_id, _name, _parent, _shift)                               \
+	{                                                                      \
+		.id = _id, .name = _name, .parent_name = _parent,              \
+		.regs = &infra0_cg_regs, .shift = _shift,                      \
+		.ops = &mtk_clk_gate_ops_setclr,                               \
+	}
+
+#define GATE_INFRA1(_id, _name, _parent, _shift)                               \
+	{                                                                      \
+		.id = _id, .name = _name, .parent_name = _parent,              \
+		.regs = &infra1_cg_regs, .shift = _shift,                      \
+		.ops = &mtk_clk_gate_ops_setclr,                               \
+	}
+
+#define GATE_INFRA2(_id, _name, _parent, _shift)                               \
+	{                                                                      \
+		.id = _id, .name = _name, .parent_name = _parent,              \
+		.regs = &infra2_cg_regs, .shift = _shift,                      \
+		.ops = &mtk_clk_gate_ops_setclr,                               \
+	}
+
+static const struct mtk_gate infra_clks[] = {
+	/* INFRA0 */
+	GATE_INFRA0(CLK_INFRA_GPT_STA, "infra_gpt_sta", "infra_66m_mck", 0),
+	GATE_INFRA0(CLK_INFRA_PWM_HCK, "infra_pwm_hck", "infra_66m_mck", 1),
+	GATE_INFRA0(CLK_INFRA_PWM_STA, "infra_pwm_sta", "infra_pwm_bsel", 2),
+	GATE_INFRA0(CLK_INFRA_PWM1_CK, "infra_pwm1", "infra_pwm1_sel", 3),
+	GATE_INFRA0(CLK_INFRA_PWM2_CK, "infra_pwm2", "infra_pwm2_sel", 4),
+	GATE_INFRA0(CLK_INFRA_CQ_DMA_CK, "infra_cq_dma", "sysaxi", 6),
+
+	GATE_INFRA0(CLK_INFRA_AUD_BUS_CK, "infra_aud_bus", "sysaxi", 8),
+	GATE_INFRA0(CLK_INFRA_AUD_26M_CK, "infra_aud_26m", "csw_f26m_sel", 9),
+	GATE_INFRA0(CLK_INFRA_AUD_L_CK, "infra_aud_l", "aud_l", 10),
+	GATE_INFRA0(CLK_INFRA_AUD_AUD_CK, "infra_aud_aud", "a1sys", 11),
+	GATE_INFRA0(CLK_INFRA_AUD_EG2_CK, "infra_aud_eg2", "a_tuner", 13),
+	GATE_INFRA0(CLK_INFRA_DRAMC_26M_CK, "infra_dramc_26m", "csw_f26m_sel",
+		    14),
+	GATE_INFRA0(CLK_INFRA_DBG_CK, "infra_dbg", "infra_66m_mck", 15),
+	GATE_INFRA0(CLK_INFRA_AP_DMA_CK, "infra_ap_dma", "infra_66m_mck", 16),
+	GATE_INFRA0(CLK_INFRA_SEJ_CK, "infra_sej", "infra_66m_mck", 24),
+	GATE_INFRA0(CLK_INFRA_SEJ_13M_CK, "infra_sej_13m", "csw_f26m_sel", 25),
+	GATE_INFRA0(CLK_INFRA_PWM3_CK, "infra_pwm3", "infra_pwm3_sel", 27),
+	/* INFRA1 */
+	GATE_INFRA1(CLK_INFRA_THERM_CK, "infra_therm", "csw_f26m_sel", 0),
+	GATE_INFRA1(CLK_INFRA_I2C0_CK, "infra_i2c0", "i2c_bck", 1),
+	GATE_INFRA1(CLK_INFRA_UART0_CK, "infra_uart0", "infra_uart0_sel", 2),
+	GATE_INFRA1(CLK_INFRA_UART1_CK, "infra_uart1", "infra_uart1_sel", 3),
+	GATE_INFRA1(CLK_INFRA_UART2_CK, "infra_uart2", "infra_uart2_sel", 4),
+	GATE_INFRA1(CLK_INFRA_SPI2_CK, "infra_spi2", "infra_spi2_sel", 6),
+	GATE_INFRA1(CLK_INFRA_SPI2_HCK_CK, "infra_spi2_hck", "infra_66m_mck", 7),
+	GATE_INFRA1(CLK_INFRA_NFI1_CK, "infra_nfi1", "nfi1x", 8),
+	GATE_INFRA1(CLK_INFRA_SPINFI1_CK, "infra_spinfi1", "spinfi_bck", 9),
+	GATE_INFRA1(CLK_INFRA_NFI_HCK_CK, "infra_nfi_hck", "infra_66m_mck", 10),
+	GATE_INFRA1(CLK_INFRA_SPI0_CK, "infra_spi0", "infra_spi0_sel", 11),
+	GATE_INFRA1(CLK_INFRA_SPI1_CK, "infra_spi1", "infra_spi1_sel", 12),
+	GATE_INFRA1(CLK_INFRA_SPI0_HCK_CK, "infra_spi0_hck", "infra_66m_mck",
+		    13),
+	GATE_INFRA1(CLK_INFRA_SPI1_HCK_CK, "infra_spi1_hck", "infra_66m_mck",
+		    14),
+	GATE_INFRA1(CLK_INFRA_FRTC_CK, "infra_frtc", "cb_rtc_32k", 15),
+	GATE_INFRA1(CLK_INFRA_MSDC_CK, "infra_msdc", "emmc_400m", 16),
+	GATE_INFRA1(CLK_INFRA_MSDC_HCK_CK, "infra_msdc_hck", "emmc_208m", 17),
+	GATE_INFRA1(CLK_INFRA_MSDC_133M_CK, "infra_msdc_133m", "sysaxi", 18),
+	GATE_INFRA1(CLK_INFRA_MSDC_66M_CK, "infra_msdc_66m", "sysaxi", 19),
+	GATE_INFRA1(CLK_INFRA_ADC_26M_CK, "infra_adc_26m", "infra_adc_frc", 20),
+	GATE_INFRA1(CLK_INFRA_ADC_FRC_CK, "infra_adc_frc", "csw_f26m", 21),
+	GATE_INFRA1(CLK_INFRA_FBIST2FPC_CK, "infra_fbist2fpc", "nfi1x", 23),
+	GATE_INFRA1(CLK_INFRA_I2C_MCK_CK, "infra_i2c_mck", "sysaxi", 25),
+	GATE_INFRA1(CLK_INFRA_I2C_PCK_CK, "infra_i2c_pck", "infra_66m_mck", 26),
+	/* INFRA2 */
+	GATE_INFRA2(CLK_INFRA_IUSB_133_CK, "infra_iusb_133", "sysaxi", 0),
+	GATE_INFRA2(CLK_INFRA_IUSB_66M_CK, "infra_iusb_66m", "sysaxi", 1),
+	GATE_INFRA2(CLK_INFRA_IUSB_SYS_CK, "infra_iusb_sys", "u2u3_sys", 2),
+	GATE_INFRA2(CLK_INFRA_IUSB_CK, "infra_iusb", "u2u3_ref", 3),
+	GATE_INFRA2(CLK_INFRA_IPCIE_CK, "infra_ipcie", "pextp_tl", 12),
+	GATE_INFRA2(CLK_INFRA_IPCIE_PIPE_CK, "infra_ipcie_pipe", "cb_cksq_40m",
+		    13),
+	GATE_INFRA2(CLK_INFRA_IPCIER_CK, "infra_ipcier", "csw_f26m", 14),
+	GATE_INFRA2(CLK_INFRA_IPCIEB_CK, "infra_ipcieb", "sysaxi", 15),
+};
+
+static int clk_mt7981_infracfg_probe(struct platform_device *pdev)
+{
+	struct clk_hw_onecell_data *clk_data;
+	struct device_node *node = pdev->dev.of_node;
+	int r;
+	void __iomem *base;
+	int nr = ARRAY_SIZE(infra_divs) + ARRAY_SIZE(infra_muxes) +
+		 ARRAY_SIZE(infra_clks);
+
+	base = of_iomap(node, 0);
+	if (!base) {
+		pr_err("%s(): ioremap failed\n", __func__);
+		return -ENOMEM;
+	}
+
+	clk_data = mtk_alloc_clk_data(nr);
+
+	if (!clk_data)
+		return -ENOMEM;
+
+	mtk_clk_register_factors(infra_divs, ARRAY_SIZE(infra_divs), clk_data);
+	mtk_clk_register_muxes(infra_muxes, ARRAY_SIZE(infra_muxes), node,
+			       &mt7981_clk_lock, clk_data);
+	mtk_clk_register_gates(node, infra_clks, ARRAY_SIZE(infra_clks),
+			       clk_data);
+
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
+	if (r) {
+		pr_err("%s(): could not register clock provider: %d\n",
+		       __func__, r);
+		goto free_infracfg_data;
+	}
+	return r;
+
+free_infracfg_data:
+	mtk_free_clk_data(clk_data);
+	return r;
+
+}
+
+static const struct of_device_id of_match_clk_mt7981_infracfg[] = {
+	{ .compatible = "mediatek,mt7981-infracfg", },
+	{}
+};
+
+static struct platform_driver clk_mt7981_infracfg_drv = {
+	.probe = clk_mt7981_infracfg_probe,
+	.driver = {
+		.name = "clk-mt7981-infracfg",
+		.of_match_table = of_match_clk_mt7981_infracfg,
+	},
+};
+builtin_platform_driver(clk_mt7981_infracfg_drv);
diff --git a/drivers/clk/mediatek/clk-mt7981-topckgen.c b/drivers/clk/mediatek/clk-mt7981-topckgen.c
new file mode 100644
index 0000000000000..a136c0b364694
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt7981-topckgen.c
@@ -0,0 +1,431 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2021 MediaTek Inc.
+ * Author: Sam Shih <sam.shih@mediatek.com>
+ * Author: Wenzhen Yu <wenzhen.yu@mediatek.com>
+ * Author: Jianhui Zhao <zhaojh329@gmail.com>
+ */
+
+
+#include <linux/clk-provider.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include "clk-mtk.h"
+#include "clk-gate.h"
+#include "clk-mux.h"
+
+#include <dt-bindings/clock/mt7981-clk.h>
+#include <linux/clk.h>
+
+static DEFINE_SPINLOCK(mt7981_clk_lock);
+
+static const struct mtk_fixed_factor top_divs[] = {
+	FACTOR(CLK_TOP_CB_CKSQ_40M, "cb_cksq_40m", "clkxtal", 1, 1),
+	FACTOR(CLK_TOP_CB_M_416M, "cb_m_416m", "mpll", 1, 1),
+	FACTOR(CLK_TOP_CB_M_D2, "cb_m_d2", "mpll", 1, 2),
+	FACTOR(CLK_TOP_CB_M_D3, "cb_m_d3", "mpll", 1, 3),
+	FACTOR(CLK_TOP_M_D3_D2, "m_d3_d2", "mpll", 1, 2),
+	FACTOR(CLK_TOP_CB_M_D4, "cb_m_d4", "mpll", 1, 4),
+	FACTOR(CLK_TOP_CB_M_D8, "cb_m_d8", "mpll", 1, 8),
+	FACTOR(CLK_TOP_M_D8_D2, "m_d8_d2", "mpll", 1, 16),
+	FACTOR(CLK_TOP_CB_MM_720M, "cb_mm_720m", "mmpll", 1, 1),
+	FACTOR(CLK_TOP_CB_MM_D2, "cb_mm_d2", "mmpll", 1, 2),
+	FACTOR(CLK_TOP_CB_MM_D3, "cb_mm_d3", "mmpll", 1, 3),
+	FACTOR(CLK_TOP_CB_MM_D3_D5, "cb_mm_d3_d5", "mmpll", 1, 15),
+	FACTOR(CLK_TOP_CB_MM_D4, "cb_mm_d4", "mmpll", 1, 4),
+	FACTOR(CLK_TOP_CB_MM_D6, "cb_mm_d6", "mmpll", 1, 6),
+	FACTOR(CLK_TOP_MM_D6_D2, "mm_d6_d2", "mmpll", 1, 12),
+	FACTOR(CLK_TOP_CB_MM_D8, "cb_mm_d8", "mmpll", 1, 8),
+	FACTOR(CLK_TOP_CB_APLL2_196M, "cb_apll2_196m", "apll2", 1, 1),
+	FACTOR(CLK_TOP_APLL2_D2, "apll2_d2", "apll2", 1, 2),
+	FACTOR(CLK_TOP_APLL2_D4, "apll2_d4", "apll2", 1, 4),
+	FACTOR(CLK_TOP_NET1_2500M, "net1_2500m", "net1pll", 1, 1),
+	FACTOR(CLK_TOP_CB_NET1_D4, "cb_net1_d4", "net1pll", 1, 4),
+	FACTOR(CLK_TOP_CB_NET1_D5, "cb_net1_d5", "net1pll", 1, 5),
+	FACTOR(CLK_TOP_NET1_D5_D2, "net1_d5_d2", "net1pll", 1, 10),
+	FACTOR(CLK_TOP_NET1_D5_D4, "net1_d5_d4", "net1pll", 1, 20),
+	FACTOR(CLK_TOP_CB_NET1_D8, "cb_net1_d8", "net1pll", 1, 8),
+	FACTOR(CLK_TOP_NET1_D8_D2, "net1_d8_d2", "net1pll", 1, 16),
+	FACTOR(CLK_TOP_NET1_D8_D4, "net1_d8_d4", "net1pll", 1, 32),
+	FACTOR(CLK_TOP_CB_NET2_800M, "cb_net2_800m", "net2pll", 1, 1),
+	FACTOR(CLK_TOP_CB_NET2_D2, "cb_net2_d2", "net2pll", 1, 2),
+	FACTOR(CLK_TOP_CB_NET2_D4, "cb_net2_d4", "net2pll", 1, 4),
+	FACTOR(CLK_TOP_NET2_D4_D2, "net2_d4_d2", "net2pll", 1, 8),
+	FACTOR(CLK_TOP_NET2_D4_D4, "net2_d4_d4", "net2pll", 1, 16),
+	FACTOR(CLK_TOP_CB_NET2_D6, "cb_net2_d6", "net2pll", 1, 6),
+	FACTOR(CLK_TOP_CB_WEDMCU_208M, "cb_wedmcu_208m", "wedmcupll", 1, 1),
+	FACTOR(CLK_TOP_CB_SGM_325M, "cb_sgm_325m", "sgmpll", 1, 1),
+	FACTOR(CLK_TOP_CKSQ_40M_D2, "cksq_40m_d2", "cb_cksq_40m", 1, 2),
+	FACTOR(CLK_TOP_CB_RTC_32K, "cb_rtc_32k", "cb_cksq_40m", 1, 1250),
+	FACTOR(CLK_TOP_CB_RTC_32P7K, "cb_rtc_32p7k", "cb_cksq_40m", 1, 1220),
+	FACTOR(CLK_TOP_USB_TX250M, "usb_tx250m", "cb_cksq_40m", 1, 1),
+	FACTOR(CLK_TOP_FAUD, "faud", "aud_sel", 1, 1),
+	FACTOR(CLK_TOP_NFI1X, "nfi1x", "nfi1x_sel", 1, 1),
+	FACTOR(CLK_TOP_USB_EQ_RX250M, "usb_eq_rx250m", "cb_cksq_40m", 1, 1),
+	FACTOR(CLK_TOP_USB_CDR_CK, "usb_cdr", "cb_cksq_40m", 1, 1),
+	FACTOR(CLK_TOP_USB_LN0_CK, "usb_ln0", "cb_cksq_40m", 1, 1),
+	FACTOR(CLK_TOP_SPINFI_BCK, "spinfi_bck", "spinfi_sel", 1, 1),
+	FACTOR(CLK_TOP_SPI, "spi", "spi_sel", 1, 1),
+	FACTOR(CLK_TOP_SPIM_MST, "spim_mst", "spim_mst_sel", 1, 1),
+	FACTOR(CLK_TOP_UART_BCK, "uart_bck", "uart_sel", 1, 1),
+	FACTOR(CLK_TOP_PWM_BCK, "pwm_bck", "pwm_sel", 1, 1),
+	FACTOR(CLK_TOP_I2C_BCK, "i2c_bck", "i2c_sel", 1, 1),
+	FACTOR(CLK_TOP_PEXTP_TL, "pextp_tl", "pextp_tl_ck_sel", 1, 1),
+	FACTOR(CLK_TOP_EMMC_208M, "emmc_208m", "emmc_208m_sel", 1, 1),
+	FACTOR(CLK_TOP_EMMC_400M, "emmc_400m", "emmc_400m_sel", 1, 1),
+	FACTOR(CLK_TOP_DRAMC_REF, "dramc_ref", "dramc_sel", 1, 1),
+	FACTOR(CLK_TOP_DRAMC_MD32, "dramc_md32", "dramc_md32_sel", 1, 1),
+	FACTOR(CLK_TOP_SYSAXI, "sysaxi", "sysaxi_sel", 1, 1),
+	FACTOR(CLK_TOP_SYSAPB, "sysapb", "sysapb_sel", 1, 1),
+	FACTOR(CLK_TOP_ARM_DB_MAIN, "arm_db_main", "arm_db_main_sel", 1, 1),
+	FACTOR(CLK_TOP_AP2CNN_HOST, "ap2cnn_host", "ap2cnn_host_sel", 1, 1),
+	FACTOR(CLK_TOP_NETSYS, "netsys", "netsys_sel", 1, 1),
+	FACTOR(CLK_TOP_NETSYS_500M, "netsys_500m", "netsys_500m_sel", 1, 1),
+	FACTOR(CLK_TOP_NETSYS_WED_MCU, "netsys_wed_mcu", "netsys_mcu_sel", 1, 1),
+	FACTOR(CLK_TOP_NETSYS_2X, "netsys_2x", "netsys_2x_sel", 1, 1),
+	FACTOR(CLK_TOP_SGM_325M, "sgm_325m", "sgm_325m_sel", 1, 1),
+	FACTOR(CLK_TOP_SGM_REG, "sgm_reg", "sgm_reg_sel", 1, 1),
+	FACTOR(CLK_TOP_F26M, "csw_f26m", "csw_f26m_sel", 1, 1),
+	FACTOR(CLK_TOP_EIP97B, "eip97b", "eip97b_sel", 1, 1),
+	FACTOR(CLK_TOP_USB3_PHY, "usb3_phy", "usb3_phy_sel", 1, 1),
+	FACTOR(CLK_TOP_AUD, "aud", "faud", 1, 1),
+	FACTOR(CLK_TOP_A1SYS, "a1sys", "a1sys_sel", 1, 1),
+	FACTOR(CLK_TOP_AUD_L, "aud_l", "aud_l_sel", 1, 1),
+	FACTOR(CLK_TOP_A_TUNER, "a_tuner", "a_tuner_sel", 1, 1),
+	FACTOR(CLK_TOP_U2U3_REF, "u2u3_ref", "u2u3_sel", 1, 1),
+	FACTOR(CLK_TOP_U2U3_SYS, "u2u3_sys", "u2u3_sys_sel", 1, 1),
+	FACTOR(CLK_TOP_U2U3_XHCI, "u2u3_xhci", "u2u3_xhci_sel", 1, 1),
+	FACTOR(CLK_TOP_USB_FRMCNT, "usb_frmcnt", "usb_frmcnt_sel", 1, 1),
+};
+
+static const char * const nfi1x_parents[] __initconst = {
+	"cb_cksq_40m",
+	"cb_mm_d4",
+	"net1_d8_d2",
+	"cb_net2_d6",
+	"cb_m_d4",
+	"cb_mm_d8",
+	"net1_d8_d4",
+	"cb_m_d8"
+};
+
+static const char * const spinfi_parents[] __initconst = {
+	"cksq_40m_d2",
+	"cb_cksq_40m",
+	"net1_d5_d4",
+	"cb_m_d4",
+	"cb_mm_d8",
+	"net1_d8_d4",
+	"mm_d6_d2",
+	"cb_m_d8"
+};
+
+static const char * const spi_parents[] __initconst = {
+	"cb_cksq_40m",
+	"cb_m_d2",
+	"cb_mm_d4",
+	"net1_d8_d2",
+	"cb_net2_d6",
+	"net1_d5_d4",
+	"cb_m_d4",
+	"net1_d8_d4"
+};
+
+static const char * const uart_parents[] __initconst = {
+	"cb_cksq_40m",
+	"cb_m_d8",
+	"m_d8_d2"
+};
+
+static const char * const pwm_parents[] __initconst = {
+	"cb_cksq_40m",
+	"net1_d8_d2",
+	"net1_d5_d4",
+	"cb_m_d4",
+	"m_d8_d2",
+	"cb_rtc_32k"
+};
+
+static const char * const i2c_parents[] __initconst = {
+	"cb_cksq_40m",
+	"net1_d5_d4",
+	"cb_m_d4",
+	"net1_d8_d4"
+};
+
+static const char * const pextp_tl_ck_parents[] __initconst = {
+	"cb_cksq_40m",
+	"net1_d5_d4",
+	"cb_m_d4",
+	"cb_rtc_32k"
+};
+
+static const char * const emmc_208m_parents[] __initconst = {
+	"cb_cksq_40m",
+	"cb_m_d2",
+	"cb_net2_d4",
+	"cb_apll2_196m",
+	"cb_mm_d4",
+	"net1_d8_d2",
+	"cb_mm_d6"
+};
+
+static const char * const emmc_400m_parents[] __initconst = {
+	"cb_cksq_40m",
+	"cb_net2_d2",
+	"cb_mm_d2",
+	"cb_net2_d2"
+};
+
+static const char * const csw_f26m_parents[] __initconst = {
+	"cksq_40m_d2",
+	"m_d8_d2"
+};
+
+static const char * const dramc_md32_parents[] __initconst = {
+	"cb_cksq_40m",
+	"cb_m_d2",
+	"cb_wedmcu_208m"
+};
+
+static const char * const sysaxi_parents[] __initconst = {
+	"cb_cksq_40m",
+	"net1_d8_d2"
+};
+
+static const char * const sysapb_parents[] __initconst = {
+	"cb_cksq_40m",
+	"m_d3_d2"
+};
+
+static const char * const arm_db_main_parents[] __initconst = {
+	"cb_cksq_40m",
+	"cb_net2_d6"
+};
+
+static const char * const ap2cnn_host_parents[] __initconst = {
+	"cb_cksq_40m",
+	"net1_d8_d4"
+};
+
+static const char * const netsys_parents[] __initconst = {
+	"cb_cksq_40m",
+	"cb_mm_d2"
+};
+
+static const char * const netsys_500m_parents[] __initconst = {
+	"cb_cksq_40m",
+	"cb_net1_d5"
+};
+
+static const char * const netsys_mcu_parents[] __initconst = {
+	"cb_cksq_40m",
+	"cb_mm_720m",
+	"cb_net1_d4",
+	"cb_net1_d5",
+	"cb_m_416m"
+};
+
+static const char * const netsys_2x_parents[] __initconst = {
+	"cb_cksq_40m",
+	"cb_net2_800m",
+	"cb_mm_720m"
+};
+
+static const char * const sgm_325m_parents[] __initconst = {
+	"cb_cksq_40m",
+	"cb_sgm_325m"
+};
+
+static const char * const sgm_reg_parents[] __initconst = {
+	"cb_cksq_40m",
+	"cb_net2_d4"
+};
+
+static const char * const eip97b_parents[] __initconst = {
+	"cb_cksq_40m",
+	"cb_net1_d5",
+	"cb_m_416m",
+	"cb_mm_d2",
+	"net1_d5_d2"
+};
+
+static const char * const aud_parents[] __initconst = {
+	"cb_cksq_40m",
+	"cb_apll2_196m"
+};
+
+static const char * const a1sys_parents[] __initconst = {
+	"cb_cksq_40m",
+	"apll2_d4"
+};
+
+static const char * const aud_l_parents[] __initconst = {
+	"cb_cksq_40m",
+	"cb_apll2_196m",
+	"m_d8_d2"
+};
+
+static const char * const a_tuner_parents[] __initconst = {
+	"cb_cksq_40m",
+	"apll2_d4",
+	"m_d8_d2"
+};
+
+static const char * const u2u3_parents[] __initconst = {
+	"cb_cksq_40m",
+	"m_d8_d2"
+};
+
+static const char * const u2u3_sys_parents[] __initconst = {
+	"cb_cksq_40m",
+	"net1_d5_d4"
+};
+
+static const char * const usb_frmcnt_parents[] __initconst = {
+	"cb_cksq_40m",
+	"cb_mm_d3_d5"
+};
+
+static const struct mtk_mux top_muxes[] = {
+	/* CLK_CFG_0 */
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_NFI1X_SEL, "nfi1x_sel",
+	    nfi1x_parents, 0x000, 0x004, 0x008, 0, 3, 7, 0x1C0, 0),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_SPINFI_SEL, "spinfi_sel",
+	    spinfi_parents, 0x000, 0x004, 0x008, 8, 3, 15, 0x1C0, 1),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_SPI_SEL, "spi_sel",
+	    spi_parents, 0x000, 0x004, 0x008, 16, 3, 23, 0x1C0, 2),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_SPIM_MST_SEL, "spim_mst_sel",
+	    spi_parents, 0x000, 0x004, 0x008, 24, 3, 31, 0x1C0, 3),
+	/* CLK_CFG_1 */
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_UART_SEL, "uart_sel",
+	    uart_parents, 0x010, 0x014, 0x018, 0, 2, 7, 0x1C0, 4),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_PWM_SEL, "pwm_sel",
+	    pwm_parents, 0x010, 0x014, 0x018, 8, 3, 15, 0x1C0, 5),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_I2C_SEL, "i2c_sel",
+	    i2c_parents, 0x010, 0x014, 0x018, 16, 2, 23, 0x1C0, 6),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_PEXTP_TL_SEL, "pextp_tl_ck_sel",
+	    pextp_tl_ck_parents, 0x010, 0x014, 0x018, 24, 2, 31, 0x1C0, 7),
+	/* CLK_CFG_2 */
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_EMMC_208M_SEL, "emmc_208m_sel",
+	    emmc_208m_parents, 0x020, 0x024, 0x028, 0, 3, 7, 0x1C0, 8),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_EMMC_400M_SEL, "emmc_400m_sel",
+	    emmc_400m_parents, 0x020, 0x024, 0x028, 8, 2, 15, 0x1C0, 9),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_F26M_SEL, "csw_f26m_sel",
+	    csw_f26m_parents, 0x020, 0x024, 0x028, 16, 1, 23, 0x1C0, 10),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_DRAMC_SEL, "dramc_sel",
+	    csw_f26m_parents, 0x020, 0x024, 0x028, 24, 1, 31, 0x1C0, 11),
+	/* CLK_CFG_3 */
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_DRAMC_MD32_SEL, "dramc_md32_sel",
+	    dramc_md32_parents, 0x030, 0x034, 0x038, 0, 2, 7, 0x1C0, 12),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_SYSAXI_SEL, "sysaxi_sel",
+	    sysaxi_parents, 0x030, 0x034, 0x038, 8, 1, 15, 0x1C0, 13),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_SYSAPB_SEL, "sysapb_sel",
+	    sysapb_parents, 0x030, 0x034, 0x038, 16, 1, 23, 0x1C0, 14),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_ARM_DB_MAIN_SEL, "arm_db_main_sel",
+	    arm_db_main_parents, 0x030, 0x034, 0x038, 24, 1, 31, 0x1C0, 15),
+	/* CLK_CFG_4 */
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_AP2CNN_HOST_SEL, "ap2cnn_host_sel",
+	    ap2cnn_host_parents, 0x040, 0x044, 0x048, 0, 1, 7, 0x1C0, 16),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_NETSYS_SEL, "netsys_sel",
+	    netsys_parents, 0x040, 0x044, 0x048, 8, 1, 15, 0x1C0, 17),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_NETSYS_500M_SEL, "netsys_500m_sel",
+	    netsys_500m_parents, 0x040, 0x044, 0x048, 16, 1, 23, 0x1C0, 18),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_NETSYS_MCU_SEL, "netsys_mcu_sel",
+	    netsys_mcu_parents, 0x040, 0x044, 0x048, 24, 3, 31, 0x1C0, 19),
+	/* CLK_CFG_5 */
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_NETSYS_2X_SEL, "netsys_2x_sel",
+	    netsys_2x_parents, 0x050, 0x054, 0x058, 0, 2, 7, 0x1C0, 20),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_SGM_325M_SEL, "sgm_325m_sel",
+	    sgm_325m_parents, 0x050, 0x054, 0x058, 8, 1, 15, 0x1C0, 21),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_SGM_REG_SEL, "sgm_reg_sel",
+	    sgm_reg_parents, 0x050, 0x054, 0x058, 16, 1, 23, 0x1C0, 22),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_EIP97B_SEL, "eip97b_sel",
+	    eip97b_parents, 0x050, 0x054, 0x058, 24, 3, 31, 0x1C0, 23),
+	/* CLK_CFG_6 */
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_USB3_PHY_SEL, "usb3_phy_sel",
+	    csw_f26m_parents, 0x060, 0x064, 0x068, 0, 1, 7, 0x1C0, 24),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_AUD_SEL, "aud_sel",
+	    aud_parents, 0x060, 0x064, 0x068, 8, 1, 15, 0x1C0, 25),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_A1SYS_SEL, "a1sys_sel",
+	    a1sys_parents, 0x060, 0x064, 0x068, 16, 1, 23, 0x1C0, 26),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_AUD_L_SEL, "aud_l_sel",
+	    aud_l_parents, 0x060, 0x064, 0x068, 24, 2, 31, 0x1C0, 27),
+	/* CLK_CFG_7 */
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_A_TUNER_SEL, "a_tuner_sel",
+	    a_tuner_parents, 0x070, 0x074, 0x078, 0, 2, 7, 0x1C0, 28),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_U2U3_SEL, "u2u3_sel",
+	    u2u3_parents, 0x070, 0x074, 0x078, 8, 1, 15, 0x1C0, 29),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_U2U3_SYS_SEL, "u2u3_sys_sel",
+	    u2u3_sys_parents, 0x070, 0x074, 0x078, 16, 1, 23, 0x1C0, 30),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_U2U3_XHCI_SEL, "u2u3_xhci_sel",
+	    u2u3_sys_parents, 0x070, 0x074, 0x078, 24, 1, 31, 0x1C4, 0),
+	/* CLK_CFG_8 */
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_USB_FRMCNT_SEL, "usb_frmcnt_sel",
+	    usb_frmcnt_parents, 0x080, 0x084, 0x088, 0, 1, 7, 0x1C4, 1),
+};
+
+static struct mtk_composite top_aud_divs[] = {
+	DIV_GATE(CLK_TOP_AUD_I2S_M, "aud_i2s_m", "aud",
+		0x0420, 0, 0x0420, 8, 8),
+};
+
+static int clk_mt7981_topckgen_probe(struct platform_device *pdev)
+{
+	struct clk_hw_onecell_data *clk_data;
+	struct device_node *node = pdev->dev.of_node;
+	int r;
+	void __iomem *base;
+	int nr = ARRAY_SIZE(top_divs) + ARRAY_SIZE(top_muxes);
+
+	base = of_iomap(node, 0);
+	if (!base) {
+		pr_err("%s(): ioremap failed\n", __func__);
+		return -ENOMEM;
+	}
+
+	clk_data = mtk_alloc_clk_data(nr);
+	if (!clk_data)
+		return -ENOMEM;
+
+	mtk_clk_register_factors(top_divs, ARRAY_SIZE(top_divs), clk_data);
+	mtk_clk_register_muxes(top_muxes, ARRAY_SIZE(top_muxes), node,
+			       &mt7981_clk_lock, clk_data);
+	mtk_clk_register_composites(top_aud_divs, ARRAY_SIZE(top_aud_divs),
+		base, &mt7981_clk_lock, clk_data);
+
+	clk_prepare_enable(clk_data->hws[CLK_TOP_SYSAXI_SEL]->clk);
+	clk_prepare_enable(clk_data->hws[CLK_TOP_SYSAPB_SEL]->clk);
+	clk_prepare_enable(clk_data->hws[CLK_TOP_DRAMC_SEL]->clk);
+	clk_prepare_enable(clk_data->hws[CLK_TOP_DRAMC_MD32_SEL]->clk);
+	clk_prepare_enable(clk_data->hws[CLK_TOP_F26M_SEL]->clk);
+
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
+
+	if (r) {
+		pr_err("%s(): could not register clock provider: %d\n",
+		       __func__, r);
+		goto free_topckgen_data;
+	}
+	return r;
+
+free_topckgen_data:
+	mtk_free_clk_data(clk_data);
+	return r;
+}
+
+static const struct of_device_id of_match_clk_mt7981_topckgen[] = {
+	{ .compatible = "mediatek,mt7981-topckgen", },
+	{}
+};
+
+static struct platform_driver clk_mt7981_topckgen_drv = {
+	.probe = clk_mt7981_topckgen_probe,
+	.driver = {
+		.name = "clk-mt7981-topckgen",
+		.of_match_table = of_match_clk_mt7981_topckgen,
+	},
+};
+builtin_platform_driver(clk_mt7981_topckgen_drv);
diff --git a/include/dt-bindings/clock/mt7981-clk.h b/include/dt-bindings/clock/mt7981-clk.h
new file mode 100644
index 0000000000000..192f8cefb589f
--- /dev/null
+++ b/include/dt-bindings/clock/mt7981-clk.h
@@ -0,0 +1,215 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2021 MediaTek Inc.
+ * Author: Wenzhen.Yu <wenzhen.yu@mediatek.com>
+ * Author: Jianhui Zhao <zhaojh329@gmail.com>
+ * Author: Daniel Golle <daniel@makrotopia.org>
+ */
+
+#ifndef _DT_BINDINGS_CLK_MT7981_H
+#define _DT_BINDINGS_CLK_MT7981_H
+
+/* TOPCKGEN */
+#define CLK_TOP_CB_CKSQ_40M		0
+#define CLK_TOP_CB_M_416M		1
+#define CLK_TOP_CB_M_D2			2
+#define CLK_TOP_CB_M_D3			3
+#define CLK_TOP_M_D3_D2			4
+#define CLK_TOP_CB_M_D4			5
+#define CLK_TOP_CB_M_D8			6
+#define CLK_TOP_M_D8_D2			7
+#define CLK_TOP_CB_MM_720M		8
+#define CLK_TOP_CB_MM_D2		9
+#define CLK_TOP_CB_MM_D3		10
+#define CLK_TOP_CB_MM_D3_D5		11
+#define CLK_TOP_CB_MM_D4		12
+#define CLK_TOP_CB_MM_D6		13
+#define CLK_TOP_MM_D6_D2		14
+#define CLK_TOP_CB_MM_D8		15
+#define CLK_TOP_CB_APLL2_196M		16
+#define CLK_TOP_APLL2_D2		17
+#define CLK_TOP_APLL2_D4		18
+#define CLK_TOP_NET1_2500M		19
+#define CLK_TOP_CB_NET1_D4		20
+#define CLK_TOP_CB_NET1_D5		21
+#define CLK_TOP_NET1_D5_D2		22
+#define CLK_TOP_NET1_D5_D4		23
+#define CLK_TOP_CB_NET1_D8		24
+#define CLK_TOP_NET1_D8_D2		25
+#define CLK_TOP_NET1_D8_D4		26
+#define CLK_TOP_CB_NET2_800M		27
+#define CLK_TOP_CB_NET2_D2		28
+#define CLK_TOP_CB_NET2_D4		29
+#define CLK_TOP_NET2_D4_D2		30
+#define CLK_TOP_NET2_D4_D4		31
+#define CLK_TOP_CB_NET2_D6		32
+#define CLK_TOP_CB_WEDMCU_208M		33
+#define CLK_TOP_CB_SGM_325M		34
+#define CLK_TOP_CKSQ_40M_D2		35
+#define CLK_TOP_CB_RTC_32K		36
+#define CLK_TOP_CB_RTC_32P7K		37
+#define CLK_TOP_USB_TX250M		38
+#define CLK_TOP_FAUD			39
+#define CLK_TOP_NFI1X			40
+#define CLK_TOP_USB_EQ_RX250M		41
+#define CLK_TOP_USB_CDR_CK		42
+#define CLK_TOP_USB_LN0_CK		43
+#define CLK_TOP_SPINFI_BCK		44
+#define CLK_TOP_SPI			45
+#define CLK_TOP_SPIM_MST		46
+#define CLK_TOP_UART_BCK		47
+#define CLK_TOP_PWM_BCK			48
+#define CLK_TOP_I2C_BCK			49
+#define CLK_TOP_PEXTP_TL		50
+#define CLK_TOP_EMMC_208M		51
+#define CLK_TOP_EMMC_400M		52
+#define CLK_TOP_DRAMC_REF		53
+#define CLK_TOP_DRAMC_MD32		54
+#define CLK_TOP_SYSAXI			55
+#define CLK_TOP_SYSAPB			56
+#define CLK_TOP_ARM_DB_MAIN		57
+#define CLK_TOP_AP2CNN_HOST		58
+#define CLK_TOP_NETSYS			59
+#define CLK_TOP_NETSYS_500M		60
+#define CLK_TOP_NETSYS_WED_MCU		61
+#define CLK_TOP_NETSYS_2X		62
+#define CLK_TOP_SGM_325M		63
+#define CLK_TOP_SGM_REG			64
+#define CLK_TOP_F26M			65
+#define CLK_TOP_EIP97B			66
+#define CLK_TOP_USB3_PHY		67
+#define CLK_TOP_AUD			68
+#define CLK_TOP_A1SYS			69
+#define CLK_TOP_AUD_L			70
+#define CLK_TOP_A_TUNER			71
+#define CLK_TOP_U2U3_REF		72
+#define CLK_TOP_U2U3_SYS		73
+#define CLK_TOP_U2U3_XHCI		74
+#define CLK_TOP_USB_FRMCNT		75
+#define CLK_TOP_NFI1X_SEL		76
+#define CLK_TOP_SPINFI_SEL		77
+#define CLK_TOP_SPI_SEL			78
+#define CLK_TOP_SPIM_MST_SEL		79
+#define CLK_TOP_UART_SEL		80
+#define CLK_TOP_PWM_SEL			81
+#define CLK_TOP_I2C_SEL			82
+#define CLK_TOP_PEXTP_TL_SEL		83
+#define CLK_TOP_EMMC_208M_SEL		84
+#define CLK_TOP_EMMC_400M_SEL		85
+#define CLK_TOP_F26M_SEL		86
+#define CLK_TOP_DRAMC_SEL		87
+#define CLK_TOP_DRAMC_MD32_SEL		88
+#define CLK_TOP_SYSAXI_SEL		89
+#define CLK_TOP_SYSAPB_SEL		90
+#define CLK_TOP_ARM_DB_MAIN_SEL		91
+#define CLK_TOP_AP2CNN_HOST_SEL		92
+#define CLK_TOP_NETSYS_SEL		93
+#define CLK_TOP_NETSYS_500M_SEL		94
+#define CLK_TOP_NETSYS_MCU_SEL		95
+#define CLK_TOP_NETSYS_2X_SEL		96
+#define CLK_TOP_SGM_325M_SEL		97
+#define CLK_TOP_SGM_REG_SEL		98
+#define CLK_TOP_EIP97B_SEL		99
+#define CLK_TOP_USB3_PHY_SEL		100
+#define CLK_TOP_AUD_SEL			101
+#define CLK_TOP_A1SYS_SEL		102
+#define CLK_TOP_AUD_L_SEL		103
+#define CLK_TOP_A_TUNER_SEL		104
+#define CLK_TOP_U2U3_SEL		105
+#define CLK_TOP_U2U3_SYS_SEL		106
+#define CLK_TOP_U2U3_XHCI_SEL		107
+#define CLK_TOP_USB_FRMCNT_SEL		108
+#define CLK_TOP_AUD_I2S_M		109
+
+/* INFRACFG */
+#define CLK_INFRA_66M_MCK		0
+#define CLK_INFRA_UART0_SEL		1
+#define CLK_INFRA_UART1_SEL		2
+#define CLK_INFRA_UART2_SEL		3
+#define CLK_INFRA_SPI0_SEL		4
+#define CLK_INFRA_SPI1_SEL		5
+#define CLK_INFRA_SPI2_SEL		6
+#define CLK_INFRA_PWM1_SEL		7
+#define CLK_INFRA_PWM2_SEL		8
+#define CLK_INFRA_PWM3_SEL		9
+#define CLK_INFRA_PWM_BSEL		10
+#define CLK_INFRA_PCIE_SEL		11
+#define CLK_INFRA_GPT_STA		12
+#define CLK_INFRA_PWM_HCK		13
+#define CLK_INFRA_PWM_STA		14
+#define CLK_INFRA_PWM1_CK		15
+#define CLK_INFRA_PWM2_CK		16
+#define CLK_INFRA_PWM3_CK		17
+#define CLK_INFRA_CQ_DMA_CK		18
+#define CLK_INFRA_AUD_BUS_CK		19
+#define CLK_INFRA_AUD_26M_CK		20
+#define CLK_INFRA_AUD_L_CK		21
+#define CLK_INFRA_AUD_AUD_CK		22
+#define CLK_INFRA_AUD_EG2_CK		23
+#define CLK_INFRA_DRAMC_26M_CK		24
+#define CLK_INFRA_DBG_CK		25
+#define CLK_INFRA_AP_DMA_CK		26
+#define CLK_INFRA_SEJ_CK		27
+#define CLK_INFRA_SEJ_13M_CK		28
+#define CLK_INFRA_THERM_CK		29
+#define CLK_INFRA_I2C0_CK		30
+#define CLK_INFRA_UART0_CK		31
+#define CLK_INFRA_UART1_CK		32
+#define CLK_INFRA_UART2_CK		33
+#define CLK_INFRA_SPI2_CK		34
+#define CLK_INFRA_SPI2_HCK_CK		35
+#define CLK_INFRA_NFI1_CK		36
+#define CLK_INFRA_SPINFI1_CK		37
+#define CLK_INFRA_NFI_HCK_CK		38
+#define CLK_INFRA_SPI0_CK		39
+#define CLK_INFRA_SPI1_CK		40
+#define CLK_INFRA_SPI0_HCK_CK		41
+#define CLK_INFRA_SPI1_HCK_CK		42
+#define CLK_INFRA_FRTC_CK		43
+#define CLK_INFRA_MSDC_CK		44
+#define CLK_INFRA_MSDC_HCK_CK		45
+#define CLK_INFRA_MSDC_133M_CK		46
+#define CLK_INFRA_MSDC_66M_CK		47
+#define CLK_INFRA_ADC_26M_CK		48
+#define CLK_INFRA_ADC_FRC_CK		49
+#define CLK_INFRA_FBIST2FPC_CK		50
+#define CLK_INFRA_I2C_MCK_CK		51
+#define CLK_INFRA_I2C_PCK_CK		52
+#define CLK_INFRA_IUSB_133_CK		53
+#define CLK_INFRA_IUSB_66M_CK		54
+#define CLK_INFRA_IUSB_SYS_CK		55
+#define CLK_INFRA_IUSB_CK		56
+#define CLK_INFRA_IPCIE_CK		57
+#define CLK_INFRA_IPCIE_PIPE_CK		58
+#define CLK_INFRA_IPCIER_CK		59
+#define CLK_INFRA_IPCIEB_CK		60
+
+/* APMIXEDSYS */
+#define CLK_APMIXED_ARMPLL		0
+#define CLK_APMIXED_NET2PLL		1
+#define CLK_APMIXED_MMPLL		2
+#define CLK_APMIXED_SGMPLL		3
+#define CLK_APMIXED_WEDMCUPLL		4
+#define CLK_APMIXED_NET1PLL		5
+#define CLK_APMIXED_MPLL		6
+#define CLK_APMIXED_APLL2		7
+
+/* SGMIISYS_0 */
+#define CLK_SGM0_TX_EN			0
+#define CLK_SGM0_RX_EN			1
+#define CLK_SGM0_CK0_EN			2
+#define CLK_SGM0_CDR_CK0_EN		3
+
+/* SGMIISYS_1 */
+#define CLK_SGM1_TX_EN			0
+#define CLK_SGM1_RX_EN			1
+#define CLK_SGM1_CK1_EN			2
+#define CLK_SGM1_CDR_CK1_EN		3
+
+/* ETHSYS */
+#define CLK_ETH_FE_EN			0
+#define CLK_ETH_GP2_EN			1
+#define CLK_ETH_GP1_EN			2
+#define CLK_ETH_WOCPU0_EN		3
+
+#endif /* _DT_BINDINGS_CLK_MT7981_H */
-- 
2.39.1

