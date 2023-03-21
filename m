Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E15366C297E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 06:01:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbjCUFBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 01:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbjCUFAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 01:00:54 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B80122035;
        Mon, 20 Mar 2023 22:00:42 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id o40-20020a05600c512800b003eddedc47aeso3292585wms.3;
        Mon, 20 Mar 2023 22:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679374840;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mntj67P088qs0lEZBtkmJ24kXIrGnevdJEXav6myTTE=;
        b=eFX034oyChemdMpe+hVKcoDlifGLsxQLRt4BQx2Ut02/FuMtYQj5xDFL5cI0m/vPuJ
         AFj0K6x4FQoaAyHVFofAOUgqhmB1sReDatkU8KtRAJ/HZRHbC/npti+wZZ8/Kwo+3a9o
         kbDgQ/twWaJOed71t0B0BuYmoXg9bRV6TWIHrs+iUlIT6zTvsLHw2/3MNXeOKlELGt2y
         nY0XW4/mFQzz+bE+fzWl75dCnFF1xdQRWgYQkToCYvmooz/0eHEXK2hE4MlSn3Lriylt
         y2Vvtkc3TM5sZSY61aUjNTUFEk6S+cJJc7CGvtDRF9loUFcOktg6aD2wEnar8UfebsnA
         kClQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679374840;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mntj67P088qs0lEZBtkmJ24kXIrGnevdJEXav6myTTE=;
        b=2DyS65QxgF7vMraqifFQUh6BEp0t7o4TDMZ6Z737IaDo0TSkbUrQrEDDe1xN50kzwu
         KHoYYaV47uqjrY3B/iqvWUf5+pbqo40a2qWOr0AbzKMjQjZ7Mj7+m3c178Xd2OIQakbt
         f69+Sx3xwsNMu0fK3nxHBmwSLi8XbkM4zDZpvnQ/B0c6EYmdy5Ew+jxjaco0qHI00BLN
         4Akf4+kEPYqQXxKr5lL0KHjJ7BUjXO5d6DJ68vnIgSPRuO3/AIgpY57aWfX1xZM+2uNV
         Wu/Qa6hH5ve8ZeRJ37Y6CXw3ilDV7ddzlk1fzcQpGpKnv68PYloxA6ZGGcExqrhvOZ8g
         x3dA==
X-Gm-Message-State: AO0yUKVmnA9KcUjap0ue07h3OGuM5lE9kVRS6gDz9JA1PyjMX91ScYfV
        1Mrl9/WqD68U7x9Y/GQK91pPuyEkEB0=
X-Google-Smtp-Source: AK7set8XdoCUkUd3i9S6PFCNlM+xjE24LO6nXi5bkalEoCvlnWGjigaWwH9yehGm/TscwVgYMmvGMA==
X-Received: by 2002:a7b:c4cd:0:b0:3ed:4b9b:f0a1 with SMTP id g13-20020a7bc4cd000000b003ed4b9bf0a1mr1342046wmk.27.1679374839981;
        Mon, 20 Mar 2023 22:00:39 -0700 (PDT)
Received: from localhost.localdomain (106.red-88-13-29.dynamicip.rima-tde.net. [88.13.29.106])
        by smtp.gmail.com with ESMTPSA id 3-20020a05600c020300b003eddefd8792sm6238432wmi.14.2023.03.20.22.00.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 22:00:39 -0700 (PDT)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     linux-mips@vger.kernel.org, tsbogend@alpha.franken.de,
        john@phrozen.org, linux-kernel@vger.kernel.org,
        p.zabel@pengutronix.de, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, devicetree@vger.kernel.org,
        arinc.unal@arinc9.com
Subject: [PATCH v2 2/9] clk: ralink: add clock and reset driver for MTMIPS SoCs
Date:   Tue, 21 Mar 2023 06:00:27 +0100
Message-Id: <20230321050034.1431379-3-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230321050034.1431379-1-sergio.paracuellos@gmail.com>
References: <20230321050034.1431379-1-sergio.paracuellos@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Until now, clock related code for old ralink SoCs was based in fixed clocks
using 'clk_register_fixed_rate' and 'clkdev_create' directly doing in code
and not using device tree at all for their definition. Including this driver
is an effort to be able to define proper clocks using device tree and also
cleaning all the clock and reset related code from 'arch/mips/ralink' dir.
This clock and reset driver covers all the ralink SoCs but MT7621 which is
the newest and provides gating and some differences that make it different
from its predecesors. It has its own driver since some time ago. The ralink
SoCs we are taking about are RT2880, RT3050, RT3052, RT3350, RT3352, RT3883,
RT5350, MT7620, MT7628 and MT7688. Mostly the code in this new driver has
been extracted from 'arch/mips/ralink' and cleanly put using kernel clock
driver APIs. The clock plans for this SoCs only talks about relation between
CPU frequency and BUS frequency. This relation is different depending on the
particular SoC. CPU clock is derived from XTAL frequencies.

Depending on the SoC we have the following frequencies:
* RT2880 SoC:
    - XTAL: 40 MHz.
    - CPU: 250, 266, 280 or 300 MHz.
    - BUS: CPU / 2 MHz.
* RT3050, RT3052, RT3350:
    - XTAL: 40 MHz.
    - CPU: 320 or 384 MHz.
    - BUS: CPU / 3 MHz.
* RT3352:
    - XTAL: 40 MHz.
    - CPU: 384 or 400 MHz.
    - BUS: CPU / 3 MHz.
    - PERIPH: 40 MHz.
* RT3383:
    - XTAL: 40 MHz.
    - CPU: 250, 384, 480 or 500 MHz.
    - BUS: Depends on RAM Type and CPU:
        + RAM DDR2: 125. ELSE 83 MHz.
        + RAM DDR2: 128. ELSE 96 MHz.
        + RAM DDR2: 160. ELSE 120 MHz.
        + RAM DDR2: 166. ELSE 125 MHz.
* RT5350:
    - XTAL: 40 MHz.
    - CPU: 300, 320 or 360 MHz.
    - BUS: CPU / 3, CPU / 4, CPU / 3 MHz.
    - PERIPH: 40 MHz.
* MT7628 and MT7688:
    - XTAL: 20 MHz or 40 MHz.
    - CPU: 575 or 580 MHz.
    - BUS: CPU / 3.
    - PCMI2S: 480 MHz.
    - PERIPH: 40 MHz.
* MT7620:
    - XTAL: 20 MHz or 40 MHz.
    - PLL: XTAL, 480, 600 MHz.
    - CPU: depends on PLL and some mult and dividers.
    - BUS: depends on PLL and some mult and dividers.
    - PERIPH: 40 or XTAL MHz.

MT7620 is a bit more complex deriving CPU clock from a PLL and an bunch of
register reads and predividers. To derive CPU and BUS frequencies in the
MT7620 SoC 'mt7620_calc_rate()' helper is used.

In the case XTAL can have different frequencies and we need a different
clock frequency for peripherals 'periph' clock in introduced.

The rest of the peripherals present in the SoC just follow their parent
frequencies.

With this information the clk driver will provide all the clock and reset
functionality from a set of hardcoded clocks allowing to define a nice
device tree without fixed clocks.

Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
 drivers/clk/ralink/Kconfig      |   7 +
 drivers/clk/ralink/Makefile     |   1 +
 drivers/clk/ralink/clk-mtmips.c | 985 ++++++++++++++++++++++++++++++++
 3 files changed, 993 insertions(+)
 create mode 100644 drivers/clk/ralink/clk-mtmips.c

diff --git a/drivers/clk/ralink/Kconfig b/drivers/clk/ralink/Kconfig
index 6580d5edc676..7c4f335864a8 100644
--- a/drivers/clk/ralink/Kconfig
+++ b/drivers/clk/ralink/Kconfig
@@ -9,3 +9,10 @@ config CLK_MT7621
 	select MFD_SYSCON
 	help
 	  This driver supports MediaTek MT7621 basic clocks.
+
+config CLK_MTMIPS
+	bool "Clock driver for MTMIPS SoCs"
+	depends on SOC_RT305X || SOC_RT288X || SOC_RT3883 || SOC_MT7620 || COMPILE_TEST
+	select MFD_SYSCON
+	help
+	  This driver supports MTMIPS basic clocks.
diff --git a/drivers/clk/ralink/Makefile b/drivers/clk/ralink/Makefile
index cf6f9216379d..398c1bf8cbc1 100644
--- a/drivers/clk/ralink/Makefile
+++ b/drivers/clk/ralink/Makefile
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_CLK_MT7621) += clk-mt7621.o
+obj-$(CONFIG_CLK_MTMIPS) += clk-mtmips.o
diff --git a/drivers/clk/ralink/clk-mtmips.c b/drivers/clk/ralink/clk-mtmips.c
new file mode 100644
index 000000000000..6b4b5ae9384d
--- /dev/null
+++ b/drivers/clk/ralink/clk-mtmips.c
@@ -0,0 +1,985 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * MTMIPS SoCs Clock Driver
+ * Author: Sergio Paracuellos <sergio.paracuellos@gmail.com>
+ */
+
+#include <linux/bitops.h>
+#include <linux/clk-provider.h>
+#include <linux/clk.h>
+#include <linux/mfd/syscon.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/reset-controller.h>
+#include <linux/slab.h>
+
+/* Configuration registers */
+#define SYSC_REG_SYSTEM_CONFIG		0x10
+#define SYSC_REG_CLKCFG0		0x2c
+#define SYSC_REG_RESET_CTRL		0x34
+#define SYSC_REG_CPU_SYS_CLKCFG		0x3c
+#define SYSC_REG_CPLL_CONFIG0		0x54
+#define SYSC_REG_CPLL_CONFIG1		0x58
+
+/* RT2880 SoC */
+#define RT2880_CONFIG_CPUCLK_SHIFT	20
+#define RT2880_CONFIG_CPUCLK_MASK	0x3
+#define RT2880_CONFIG_CPUCLK_250	0x0
+#define RT2880_CONFIG_CPUCLK_266	0x1
+#define RT2880_CONFIG_CPUCLK_280	0x2
+#define RT2880_CONFIG_CPUCLK_300	0x3
+
+/* RT305X SoC */
+#define RT305X_SYSCFG_CPUCLK_SHIFT	18
+#define RT305X_SYSCFG_CPUCLK_MASK	0x1
+#define RT305X_SYSCFG_CPUCLK_LOW	0x0
+#define RT305X_SYSCFG_CPUCLK_HIGH	0x1
+
+/* RT3352 SoC */
+#define RT3352_SYSCFG0_CPUCLK_SHIFT	8
+#define RT3352_SYSCFG0_CPUCLK_MASK	0x1
+#define RT3352_SYSCFG0_CPUCLK_LOW	0x0
+#define RT3352_SYSCFG0_CPUCLK_HIGH	0x1
+
+/* RT3383 SoC */
+#define RT3883_SYSCFG0_DRAM_TYPE_DDR2	BIT(17)
+#define RT3883_SYSCFG0_CPUCLK_SHIFT	8
+#define RT3883_SYSCFG0_CPUCLK_MASK	0x3
+#define RT3883_SYSCFG0_CPUCLK_250	0x0
+#define RT3883_SYSCFG0_CPUCLK_384	0x1
+#define RT3883_SYSCFG0_CPUCLK_480	0x2
+#define RT3883_SYSCFG0_CPUCLK_500	0x3
+
+/* RT5350 SoC */
+#define RT5350_CLKCFG0_XTAL_SEL		BIT(20)
+#define RT5350_SYSCFG0_CPUCLK_SHIFT	8
+#define RT5350_SYSCFG0_CPUCLK_MASK	0x3
+#define RT5350_SYSCFG0_CPUCLK_360	0x0
+#define RT5350_SYSCFG0_CPUCLK_320	0x2
+#define RT5350_SYSCFG0_CPUCLK_300	0x3
+
+/* MT7620 and MT76x8 SoCs */
+#define MT7620_XTAL_FREQ_SEL		BIT(6)
+#define CPLL_CFG0_SW_CFG		BIT(31)
+#define CPLL_CFG0_PLL_MULT_RATIO_SHIFT	16
+#define CPLL_CFG0_PLL_MULT_RATIO_MASK   0x7
+#define CPLL_CFG0_LC_CURFCK		BIT(15)
+#define CPLL_CFG0_BYPASS_REF_CLK	BIT(14)
+#define CPLL_CFG0_PLL_DIV_RATIO_SHIFT	10
+#define CPLL_CFG0_PLL_DIV_RATIO_MASK	0x3
+#define CPLL_CFG1_CPU_AUX1		BIT(25)
+#define CPLL_CFG1_CPU_AUX0		BIT(24)
+#define CLKCFG0_PERI_CLK_SEL		BIT(4)
+#define CPU_SYS_CLKCFG_OCP_RATIO_SHIFT	16
+#define CPU_SYS_CLKCFG_OCP_RATIO_MASK	0xf
+#define CPU_SYS_CLKCFG_OCP_RATIO_1	0	/* 1:1   (Reserved) */
+#define CPU_SYS_CLKCFG_OCP_RATIO_1_5	1	/* 1:1.5 (Reserved) */
+#define CPU_SYS_CLKCFG_OCP_RATIO_2	2	/* 1:2   */
+#define CPU_SYS_CLKCFG_OCP_RATIO_2_5	3       /* 1:2.5 (Reserved) */
+#define CPU_SYS_CLKCFG_OCP_RATIO_3	4	/* 1:3   */
+#define CPU_SYS_CLKCFG_OCP_RATIO_3_5	5	/* 1:3.5 (Reserved) */
+#define CPU_SYS_CLKCFG_OCP_RATIO_4	6	/* 1:4   */
+#define CPU_SYS_CLKCFG_OCP_RATIO_5	7	/* 1:5   */
+#define CPU_SYS_CLKCFG_OCP_RATIO_10	8	/* 1:10  */
+#define CPU_SYS_CLKCFG_CPU_FDIV_SHIFT	8
+#define CPU_SYS_CLKCFG_CPU_FDIV_MASK	0x1f
+#define CPU_SYS_CLKCFG_CPU_FFRAC_SHIFT	0
+#define CPU_SYS_CLKCFG_CPU_FFRAC_MASK	0x1f
+
+/* clock scaling */
+#define CLKCFG_FDIV_MASK		0x1f00
+#define CLKCFG_FDIV_USB_VAL		0x0300
+#define CLKCFG_FFRAC_MASK		0x001f
+#define CLKCFG_FFRAC_USB_VAL		0x0003
+
+struct mtmips_clk;
+
+struct mtmips_clk_data {
+	struct mtmips_clk *clk_base;
+	size_t num_clk_base;
+	struct mtmips_clk *clk_periph;
+	size_t num_clk_periph;
+};
+
+struct mtmips_clk_priv {
+	struct regmap *sysc;
+	const struct mtmips_clk_data *data;
+};
+
+struct mtmips_clk {
+	struct clk_hw hw;
+	struct mtmips_clk_priv *priv;
+};
+
+static unsigned long mtmips_pherip_clk_rate(struct clk_hw *hw,
+					    unsigned long parent_rate)
+{
+	return parent_rate;
+}
+
+/*
+ * There are drivers for these SoCs that are older than clock driver
+ * and are not prepared for the clock. We don't want the kernel to
+ * disable anything so we add CLK_IS_CRITICAL flag here.
+ */
+#define CLK_PERIPH(_name, _parent) {				\
+	.init = &(struct clk_init_data) {			\
+		.name = _name,					\
+		.ops = &(const struct clk_ops) {                \
+			.recalc_rate = mtmips_pherip_clk_rate	\
+		},						\
+		.parent_data = &(const struct clk_parent_data) {\
+			.name = _parent,			\
+			.fw_name = _parent			\
+		},						\
+		.num_parents = 1,				\
+		.flags = CLK_SET_RATE_PARENT | CLK_IS_CRITICAL	\
+	},							\
+}
+
+static struct mtmips_clk rt2880_pherip_clks[] = {
+	{ CLK_PERIPH("300100.timer", "bus") },
+	{ CLK_PERIPH("300120.watchdog", "bus") },
+	{ CLK_PERIPH("300500.uart", "bus") },
+	{ CLK_PERIPH("300900.i2c", "bus") },
+	{ CLK_PERIPH("300c00.uartlite", "bus") },
+	{ CLK_PERIPH("400000.ethernet", "bus") },
+	{ CLK_PERIPH("480000.wmac", "xtal") }
+};
+
+static struct mtmips_clk rt305x_pherip_clks[] = {
+	{ CLK_PERIPH("10000900.i2c", "bus") },
+	{ CLK_PERIPH("10000a00.i2s", "bus") },
+	{ CLK_PERIPH("10000b00.spi", "bus") },
+	{ CLK_PERIPH("10000b40.spi", "bus") },
+	{ CLK_PERIPH("10000100.timer", "bus") },
+	{ CLK_PERIPH("10000120.watchdog", "bus") },
+	{ CLK_PERIPH("10000500.uart", "bus") },
+	{ CLK_PERIPH("10000c00.uartlite", "bus") },
+	{ CLK_PERIPH("10100000.ethernet", "bus") },
+	{ CLK_PERIPH("10180000.wmac", "xtal") }
+};
+
+static struct mtmips_clk rt5350_pherip_clks[] = {
+	{ CLK_PERIPH("10000900.i2c", "periph") },
+	{ CLK_PERIPH("10000a00.i2s", "periph") },
+	{ CLK_PERIPH("10000b00.spi", "bus") },
+	{ CLK_PERIPH("10000b40.spi", "bus") },
+	{ CLK_PERIPH("10000100.timer", "bus") },
+	{ CLK_PERIPH("10000120.watchdog", "bus") },
+	{ CLK_PERIPH("10000500.uart", "periph") },
+	{ CLK_PERIPH("10000c00.uartlite", "periph") },
+	{ CLK_PERIPH("10100000.ethernet", "bus") },
+	{ CLK_PERIPH("10180000.wmac", "xtal") }
+};
+
+static struct mtmips_clk mt7620_pherip_clks[] = {
+	{ CLK_PERIPH("10000100.timer", "periph") },
+	{ CLK_PERIPH("10000120.watchdog", "periph") },
+	{ CLK_PERIPH("10000900.i2c", "periph") },
+	{ CLK_PERIPH("10000a00.i2s", "periph") },
+	{ CLK_PERIPH("10000b00.spi", "bus") },
+	{ CLK_PERIPH("10000b40.spi", "bus") },
+	{ CLK_PERIPH("10000c00.uartlite", "periph") },
+	{ CLK_PERIPH("10000d00.uart1", "periph") },
+	{ CLK_PERIPH("10000e00.uart2", "periph") },
+	{ CLK_PERIPH("10180000.wmac", "xtal") }
+};
+
+static struct mtmips_clk mt76x8_pherip_clks[] = {
+	{ CLK_PERIPH("10000100.timer", "periph") },
+	{ CLK_PERIPH("10000120.watchdog", "periph") },
+	{ CLK_PERIPH("10000900.i2c", "periph") },
+	{ CLK_PERIPH("10000a00.i2s", "pcmi2s") },
+	{ CLK_PERIPH("10000b00.spi", "bus") },
+	{ CLK_PERIPH("10000b40.spi", "bus") },
+	{ CLK_PERIPH("10000c00.uartlite", "periph") },
+	{ CLK_PERIPH("10000d00.uartlite", "periph") },
+	{ CLK_PERIPH("10000e00.uartlite", "periph") },
+	{ CLK_PERIPH("10000d00.uart1", "periph") },
+	{ CLK_PERIPH("10000e00.uart2", "periph") },
+	{ CLK_PERIPH("10180000.wmac", "xtal") }
+};
+
+static int mtmips_register_pherip_clocks(struct device_node *np,
+					 struct clk_hw_onecell_data *clk_data,
+					 struct mtmips_clk_priv *priv)
+{
+	struct clk_hw **hws = clk_data->hws;
+	struct mtmips_clk *sclk;
+	int ret, i;
+
+	for (i = 0; i < priv->data->num_clk_periph; i++) {
+		int idx = (priv->data->num_clk_base - 1) + i;
+
+		sclk = &priv->data->clk_periph[i];
+		ret = of_clk_hw_register(np, &sclk->hw);
+		if (ret) {
+			pr_err("Couldn't register peripheral clock %d\n", idx);
+			goto err_clk_unreg;
+		}
+
+		hws[idx] = &sclk->hw;
+	}
+
+	return 0;
+
+err_clk_unreg:
+	while (--i >= 0) {
+		sclk = &priv->data->clk_periph[i];
+		clk_hw_unregister(&sclk->hw);
+	}
+	return ret;
+}
+
+static inline struct mtmips_clk *to_mtmips_clk(struct clk_hw *hw)
+{
+	return container_of(hw, struct mtmips_clk, hw);
+}
+
+static unsigned long rt5350_xtal_recalc_rate(struct clk_hw *hw,
+					     unsigned long parent_rate)
+{
+	struct mtmips_clk *clk = to_mtmips_clk(hw);
+	struct regmap *sysc = clk->priv->sysc;
+	u32 val;
+
+	regmap_read(sysc, SYSC_REG_SYSTEM_CONFIG, &val);
+	if (!(val & RT5350_CLKCFG0_XTAL_SEL))
+		return 20000000;
+
+	return 40000000;
+}
+
+static unsigned long rt5350_cpu_recalc_rate(struct clk_hw *hw,
+					    unsigned long xtal_clk)
+{
+	struct mtmips_clk *clk = to_mtmips_clk(hw);
+	struct regmap *sysc = clk->priv->sysc;
+	u32 t;
+
+	regmap_read(sysc, SYSC_REG_SYSTEM_CONFIG, &t);
+	t = (t >> RT5350_SYSCFG0_CPUCLK_SHIFT) & RT5350_SYSCFG0_CPUCLK_MASK;
+
+	switch (t) {
+	case RT5350_SYSCFG0_CPUCLK_360:
+		return 360000000;
+	case RT5350_SYSCFG0_CPUCLK_320:
+		return 320000000;
+	case RT5350_SYSCFG0_CPUCLK_300:
+		return 300000000;
+	default:
+		BUG();
+	}
+}
+
+static unsigned long rt5350_bus_recalc_rate(struct clk_hw *hw,
+					    unsigned long parent_rate)
+{
+	if (parent_rate == 320000000)
+		return parent_rate / 4;
+
+	return parent_rate / 3;
+}
+
+static unsigned long rt3352_cpu_recalc_rate(struct clk_hw *hw,
+					    unsigned long xtal_clk)
+{
+	struct mtmips_clk *clk = to_mtmips_clk(hw);
+	struct regmap *sysc = clk->priv->sysc;
+	u32 t;
+
+	regmap_read(sysc, SYSC_REG_SYSTEM_CONFIG, &t);
+	t = (t >> RT3352_SYSCFG0_CPUCLK_SHIFT) & RT3352_SYSCFG0_CPUCLK_MASK;
+
+	switch (t) {
+	case RT3352_SYSCFG0_CPUCLK_LOW:
+		return 384000000;
+	case RT3352_SYSCFG0_CPUCLK_HIGH:
+		return 400000000;
+	default:
+		BUG();
+	}
+}
+
+static unsigned long rt3352_periph_recalc_rate(struct clk_hw *hw,
+					       unsigned long parent_rate)
+{
+	return 40000000;
+}
+
+static unsigned long rt3352_bus_recalc_rate(struct clk_hw *hw,
+					    unsigned long parent_rate)
+{
+	return parent_rate / 3;
+}
+
+static unsigned long rt305x_xtal_recalc_rate(struct clk_hw *hw,
+					     unsigned long parent_rate)
+{
+	return 40000000;
+}
+
+static unsigned long rt305x_cpu_recalc_rate(struct clk_hw *hw,
+					    unsigned long xtal_clk)
+{
+	struct mtmips_clk *clk = to_mtmips_clk(hw);
+	struct regmap *sysc = clk->priv->sysc;
+	u32 t;
+
+	regmap_read(sysc, SYSC_REG_SYSTEM_CONFIG, &t);
+	t = (t >> RT305X_SYSCFG_CPUCLK_SHIFT) & RT305X_SYSCFG_CPUCLK_MASK;
+
+	switch (t) {
+	case RT305X_SYSCFG_CPUCLK_LOW:
+		return 320000000;
+	case RT305X_SYSCFG_CPUCLK_HIGH:
+		return 384000000;
+	default:
+		BUG();
+	}
+}
+
+static unsigned long rt3883_cpu_recalc_rate(struct clk_hw *hw,
+					    unsigned long xtal_clk)
+{
+	struct mtmips_clk *clk = to_mtmips_clk(hw);
+	struct regmap *sysc = clk->priv->sysc;
+	u32 t;
+
+	regmap_read(sysc, SYSC_REG_SYSTEM_CONFIG, &t);
+	t = (t >> RT3883_SYSCFG0_CPUCLK_SHIFT) & RT3883_SYSCFG0_CPUCLK_MASK;
+
+	switch (t) {
+	case RT3883_SYSCFG0_CPUCLK_250:
+		return 250000000;
+	case RT3883_SYSCFG0_CPUCLK_384:
+		return 384000000;
+	case RT3883_SYSCFG0_CPUCLK_480:
+		return 480000000;
+	case RT3883_SYSCFG0_CPUCLK_500:
+		return 500000000;
+	default:
+		BUG();
+	}
+}
+
+static unsigned long rt3883_bus_recalc_rate(struct clk_hw *hw,
+					    unsigned long parent_rate)
+{
+	struct mtmips_clk *clk = to_mtmips_clk(hw);
+	struct regmap *sysc = clk->priv->sysc;
+	u32 ddr2;
+	u32 t;
+
+	regmap_read(sysc, SYSC_REG_SYSTEM_CONFIG, &t);
+	ddr2 = t & RT3883_SYSCFG0_DRAM_TYPE_DDR2;
+
+	switch (parent_rate) {
+	case 250000000:
+		return (ddr2) ? 125000000 : 83000000;
+	case 384000000:
+		return (ddr2) ? 128000000 : 96000000;
+	case 480000000:
+		return (ddr2) ? 160000000 : 120000000;
+	case 500000000:
+		return (ddr2) ? 166000000 : 125000000;
+	default:
+		BUG();
+	}
+}
+
+static unsigned long rt2880_cpu_recalc_rate(struct clk_hw *hw,
+					    unsigned long xtal_clk)
+{
+	struct mtmips_clk *clk = to_mtmips_clk(hw);
+	struct regmap *sysc = clk->priv->sysc;
+	u32 t;
+
+	regmap_read(sysc, SYSC_REG_SYSTEM_CONFIG, &t);
+	t = (t >> RT2880_CONFIG_CPUCLK_SHIFT) & RT2880_CONFIG_CPUCLK_MASK;
+
+	switch (t) {
+	case RT2880_CONFIG_CPUCLK_250:
+		return 250000000;
+	case RT2880_CONFIG_CPUCLK_266:
+		return 266000000;
+	case RT2880_CONFIG_CPUCLK_280:
+		return 280000000;
+	case RT2880_CONFIG_CPUCLK_300:
+		return 300000000;
+	default:
+		BUG();
+	}
+}
+
+static unsigned long rt2880_bus_recalc_rate(struct clk_hw *hw,
+					    unsigned long parent_rate)
+{
+	return parent_rate / 2;
+}
+
+static u32 mt7620_calc_rate(u32 ref_rate, u32 mul, u32 div)
+{
+	u64 t;
+
+	t = ref_rate;
+	t *= mul;
+	do_div(t, div);
+
+	return t;
+}
+
+static unsigned long mt7620_pll_recalc_rate(struct clk_hw *hw,
+					    unsigned long parent_rate)
+{
+	static const u32 clk_divider[] = { 2, 3, 4, 8 };
+	struct mtmips_clk *clk = to_mtmips_clk(hw);
+	struct regmap *sysc = clk->priv->sysc;
+	unsigned long cpu_pll;
+	u32 t;
+	u32 mul;
+	u32 div;
+
+	regmap_read(sysc, SYSC_REG_CPLL_CONFIG0, &t);
+	if (t & CPLL_CFG0_BYPASS_REF_CLK) {
+		cpu_pll = parent_rate;
+	} else if ((t & CPLL_CFG0_SW_CFG) == 0) {
+		cpu_pll = 600000000;
+	} else {
+		mul = (t >> CPLL_CFG0_PLL_MULT_RATIO_SHIFT) &
+			CPLL_CFG0_PLL_MULT_RATIO_MASK;
+		mul += 24;
+		if (t & CPLL_CFG0_LC_CURFCK)
+			mul *= 2;
+
+		div = (t >> CPLL_CFG0_PLL_DIV_RATIO_SHIFT) &
+			CPLL_CFG0_PLL_DIV_RATIO_MASK;
+
+		WARN_ON(div >= ARRAY_SIZE(clk_divider));
+
+		cpu_pll = mt7620_calc_rate(parent_rate, mul, clk_divider[div]);
+	}
+
+	regmap_read(sysc, SYSC_REG_CPLL_CONFIG1, &t);
+	if (t & CPLL_CFG1_CPU_AUX1)
+		return parent_rate;
+
+	if (t & CPLL_CFG1_CPU_AUX0)
+		return 480000000;
+
+	return cpu_pll;
+}
+
+static unsigned long mt7620_cpu_recalc_rate(struct clk_hw *hw,
+					    unsigned long parent_rate)
+{
+	struct mtmips_clk *clk = to_mtmips_clk(hw);
+	struct regmap *sysc = clk->priv->sysc;
+	u32 t;
+	u32 mul;
+	u32 div;
+
+	regmap_read(sysc, SYSC_REG_CPU_SYS_CLKCFG, &t);
+	mul = t & CPU_SYS_CLKCFG_CPU_FFRAC_MASK;
+	div = (t >> CPU_SYS_CLKCFG_CPU_FDIV_SHIFT) &
+		CPU_SYS_CLKCFG_CPU_FDIV_MASK;
+
+	return mt7620_calc_rate(parent_rate, mul, div);
+}
+
+static unsigned long mt7620_bus_recalc_rate(struct clk_hw *hw,
+					    unsigned long parent_rate)
+{
+	static const u32 ocp_dividers[16] = {
+		[CPU_SYS_CLKCFG_OCP_RATIO_2] = 2,
+		[CPU_SYS_CLKCFG_OCP_RATIO_3] = 3,
+		[CPU_SYS_CLKCFG_OCP_RATIO_4] = 4,
+		[CPU_SYS_CLKCFG_OCP_RATIO_5] = 5,
+		[CPU_SYS_CLKCFG_OCP_RATIO_10] = 10,
+	};
+	struct mtmips_clk *clk = to_mtmips_clk(hw);
+	struct regmap *sysc = clk->priv->sysc;
+	u32 t;
+	u32 ocp_ratio;
+	u32 div;
+
+	if (IS_ENABLED(CONFIG_USB)) {
+		/*
+		* When the CPU goes into sleep mode, the BUS
+		* clock will be too low for USB to function properly.
+		* Adjust the busses fractional divider to fix this
+		*/
+		regmap_read(sysc, SYSC_REG_CPU_SYS_CLKCFG, &t);
+		t &= ~(CLKCFG_FDIV_MASK | CLKCFG_FFRAC_MASK);
+		t |= CLKCFG_FDIV_USB_VAL | CLKCFG_FFRAC_USB_VAL;
+		regmap_write(sysc, SYSC_REG_CPU_SYS_CLKCFG, t);
+	}
+
+	regmap_read(sysc, SYSC_REG_CPU_SYS_CLKCFG, &t);
+	ocp_ratio = (t >> CPU_SYS_CLKCFG_OCP_RATIO_SHIFT) &
+		CPU_SYS_CLKCFG_OCP_RATIO_MASK;
+
+	if (WARN_ON(ocp_ratio >= ARRAY_SIZE(ocp_dividers)))
+		return parent_rate;
+
+	div = ocp_dividers[ocp_ratio];
+	if (WARN(!div, "invalid divider for OCP ratio %u", ocp_ratio))
+		return parent_rate;
+
+	return parent_rate / div;
+}
+
+static unsigned long mt7620_periph_recalc_rate(struct clk_hw *hw,
+					       unsigned long parent_rate)
+{
+	struct mtmips_clk *clk = to_mtmips_clk(hw);
+	struct regmap *sysc = clk->priv->sysc;
+	u32 t;
+
+	regmap_read(sysc, SYSC_REG_CLKCFG0, &t);
+	if (t & CLKCFG0_PERI_CLK_SEL)
+		return parent_rate;
+
+	return 40000000;
+}
+
+static unsigned long mt76x8_xtal_recalc_rate(struct clk_hw *hw,
+					     unsigned long parent_rate)
+{
+	struct mtmips_clk *clk = to_mtmips_clk(hw);
+	struct regmap *sysc = clk->priv->sysc;
+	u32 t;
+
+	regmap_read(sysc, SYSC_REG_SYSTEM_CONFIG, &t);
+	if (t & MT7620_XTAL_FREQ_SEL)
+		return 40000000;
+
+	return 20000000;
+}
+
+static unsigned long mt76x8_cpu_recalc_rate(struct clk_hw *hw,
+					    unsigned long xtal_clk)
+{
+	if (xtal_clk == 40000000)
+		return 580000000;
+
+	return 575000000;
+}
+
+static unsigned long mt76x8_pcmi2s_recalc_rate(struct clk_hw *hw,
+					       unsigned long xtal_clk)
+{
+	return 480000000;
+}
+
+#define CLK_BASE(_name, _parent, _recalc) {				\
+	.init = &(struct clk_init_data) {				\
+		.name = _name,						\
+		.ops = &(const struct clk_ops) {			\
+			.recalc_rate = _recalc,				\
+		},							\
+		.parent_data = &(const struct clk_parent_data) {	\
+			.name = _parent,				\
+			.fw_name = _parent				\
+		},							\
+		.num_parents = _parent ? 1 : 0				\
+	},								\
+}
+
+static struct mtmips_clk rt2880_clks_base[] = {
+	{ CLK_BASE("xtal", NULL, rt305x_xtal_recalc_rate) },
+	{ CLK_BASE("cpu", "xtal", rt2880_cpu_recalc_rate) },
+	{ CLK_BASE("bus", "cpu", rt2880_bus_recalc_rate) }
+};
+
+static struct mtmips_clk rt305x_clks_base[] = {
+	{ CLK_BASE("xtal", NULL, rt305x_xtal_recalc_rate) },
+	{ CLK_BASE("cpu", "xtal", rt305x_cpu_recalc_rate) },
+	{ CLK_BASE("bus", "cpu", rt3352_bus_recalc_rate) }
+};
+
+static struct mtmips_clk rt3352_clks_base[] = {
+	{ CLK_BASE("xtal", NULL, rt5350_xtal_recalc_rate) },
+	{ CLK_BASE("cpu", "xtal", rt3352_cpu_recalc_rate) },
+	{ CLK_BASE("periph", "xtal", rt3352_periph_recalc_rate) },
+	{ CLK_BASE("bus", "cpu", rt3352_bus_recalc_rate) }
+};
+
+static struct mtmips_clk rt3883_clks_base[] = {
+	{ CLK_BASE("xtal", NULL, rt305x_xtal_recalc_rate) },
+	{ CLK_BASE("cpu", "xtal", rt3883_cpu_recalc_rate) },
+	{ CLK_BASE("bus", "cpu", rt3883_bus_recalc_rate) }
+};
+
+static struct mtmips_clk rt5350_clks_base[] = {
+	{ CLK_BASE("xtal", NULL, rt5350_xtal_recalc_rate) },
+	{ CLK_BASE("cpu", "xtal", rt5350_cpu_recalc_rate) },
+	{ CLK_BASE("periph", "xtal", rt3352_periph_recalc_rate) },
+	{ CLK_BASE("bus", "cpu", rt5350_bus_recalc_rate) }
+};
+
+static struct mtmips_clk mt7620_clks_base[] = {
+	{ CLK_BASE("xtal", NULL, mt76x8_xtal_recalc_rate) },
+	{ CLK_BASE("pll", "xtal", mt7620_pll_recalc_rate) },
+	{ CLK_BASE("cpu", "pll", mt7620_cpu_recalc_rate) },
+	{ CLK_BASE("periph", "xtal", mt7620_periph_recalc_rate) },
+	{ CLK_BASE("bus", "cpu", mt7620_bus_recalc_rate) }
+};
+
+static struct mtmips_clk mt76x8_clks_base[] = {
+	{ CLK_BASE("xtal", NULL, mt76x8_xtal_recalc_rate) },
+	{ CLK_BASE("cpu", "xtal", mt76x8_cpu_recalc_rate) },
+	{ CLK_BASE("periph", "xtal", rt3352_periph_recalc_rate) },
+	{ CLK_BASE("pcmi2s", "xtal", mt76x8_pcmi2s_recalc_rate) },
+	{ CLK_BASE("bus", "cpu", rt3352_bus_recalc_rate) }
+};
+
+static int mtmips_register_clocks(struct device_node *np,
+				  struct clk_hw_onecell_data *clk_data,
+				  struct mtmips_clk_priv *priv)
+{
+	struct clk_hw **hws = clk_data->hws;
+	struct mtmips_clk *sclk;
+	int ret, i;
+
+	for (i = 0; i < priv->data->num_clk_base; i++) {
+		sclk = &priv->data->clk_base[i];
+		sclk->priv = priv;
+		ret = of_clk_hw_register(np, &sclk->hw);
+		if (ret) {
+			pr_err("Couldn't register top clock %i\n", i);
+			goto err_clk_unreg;
+		}
+
+		hws[i] = &sclk->hw;
+	}
+
+	return 0;
+
+err_clk_unreg:
+	while (--i >= 0) {
+		sclk = &priv->data->clk_base[i];
+		clk_hw_unregister(&sclk->hw);
+	}
+	return ret;
+}
+
+static const struct mtmips_clk_data rt2880_clk_data = {
+	.clk_base = rt2880_clks_base,
+	.num_clk_base = ARRAY_SIZE(rt2880_clks_base),
+	.clk_periph = rt2880_pherip_clks,
+	.num_clk_periph = ARRAY_SIZE(rt2880_pherip_clks),
+};
+
+static const struct mtmips_clk_data rt3050_clk_data = {
+	.clk_base = rt305x_clks_base,
+	.num_clk_base = ARRAY_SIZE(rt305x_clks_base),
+	.clk_periph = rt305x_pherip_clks,
+	.num_clk_periph = ARRAY_SIZE(rt305x_pherip_clks),
+};
+
+static const struct mtmips_clk_data rt3052_clk_data = {
+	.clk_base = rt305x_clks_base,
+	.num_clk_base = ARRAY_SIZE(rt305x_clks_base),
+	.clk_periph = rt305x_pherip_clks,
+	.num_clk_periph = ARRAY_SIZE(rt305x_pherip_clks),
+};
+
+static const struct mtmips_clk_data rt3352_clk_data = {
+	.clk_base = rt3352_clks_base,
+	.num_clk_base = ARRAY_SIZE(rt3352_clks_base),
+	.clk_periph = rt5350_pherip_clks,
+	.num_clk_periph = ARRAY_SIZE(rt5350_pherip_clks),
+};
+
+static const struct mtmips_clk_data rt3883_clk_data = {
+	.clk_base = rt3883_clks_base,
+	.num_clk_base = ARRAY_SIZE(rt3883_clks_base),
+	.clk_periph = rt5350_pherip_clks,
+	.num_clk_periph = ARRAY_SIZE(rt5350_pherip_clks),
+};
+
+static const struct mtmips_clk_data rt5350_clk_data = {
+	.clk_base = rt5350_clks_base,
+	.num_clk_base = ARRAY_SIZE(rt5350_clks_base),
+	.clk_periph = rt5350_pherip_clks,
+	.num_clk_periph = ARRAY_SIZE(rt5350_pherip_clks),
+};
+
+static const struct mtmips_clk_data mt7620_clk_data = {
+	.clk_base = mt7620_clks_base,
+	.num_clk_base = ARRAY_SIZE(mt7620_clks_base),
+	.clk_periph = mt7620_pherip_clks,
+	.num_clk_periph = ARRAY_SIZE(mt7620_pherip_clks),
+};
+
+static const struct mtmips_clk_data mt76x8_clk_data = {
+	.clk_base = mt76x8_clks_base,
+	.num_clk_base = ARRAY_SIZE(mt76x8_clks_base),
+	.clk_periph = mt76x8_pherip_clks,
+	.num_clk_periph = ARRAY_SIZE(mt76x8_pherip_clks),
+};
+
+static const struct of_device_id mtmips_of_match[] = {
+	{
+		.compatible = "ralink,rt2880-sysc",
+		.data = &rt2880_clk_data,
+	},
+	{
+		.compatible = "ralink,rt3050-sysc",
+		.data = &rt3050_clk_data,
+	},
+	{
+		.compatible = "ralink,rt3052-sysc",
+		.data = &rt3052_clk_data,
+	},
+	{
+		.compatible = "ralink,rt3352-sysc",
+		.data = &rt3052_clk_data,
+	},
+	{
+		.compatible = "ralink,rt3883-sysc",
+		.data = &rt3352_clk_data,
+	},
+	{
+		.compatible = "ralink,rt5350-sysc",
+		.data = &rt5350_clk_data,
+	},
+	{
+		.compatible = "ralink,mt7620-sysc",
+		.data = &mt7620_clk_data,
+	},
+	{
+		.compatible = "ralink,mt7620a-sysc",
+		.data = &mt7620_clk_data,
+	},
+	{
+		.compatible = "ralink,mt7628-sysc",
+		.data = &mt76x8_clk_data,
+	},
+	{
+		.compatible = "ralink,mt7688-sysc",
+		.data = &mt76x8_clk_data,
+	},
+	{}
+};
+
+static void __init mtmips_clk_init(struct device_node *node)
+{
+	const struct of_device_id *match;
+	const struct mtmips_clk_data *data;
+	struct mtmips_clk_priv *priv;
+	struct clk_hw_onecell_data *clk_data;
+	int ret, i, count;
+
+	if (!of_find_property(node, "#clock-cells", NULL)) {
+		pr_err("No '#clock-cells' property found\n");
+		return;
+	}
+
+	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return;
+
+	priv->sysc = syscon_node_to_regmap(node);
+	if (IS_ERR(priv->sysc)) {
+		pr_err("Could not get sysc syscon regmap\n");
+		goto free_clk_priv;
+	}
+
+	match = of_match_node(mtmips_of_match, node);
+	if (WARN_ON(!match))
+		return;
+
+	data = match->data;
+	priv->data = data;
+	count = priv->data->num_clk_base + priv->data->num_clk_periph;
+	clk_data = kzalloc(struct_size(clk_data, hws, count), GFP_KERNEL);
+	if (!clk_data)
+		goto free_clk_priv;
+
+	ret = mtmips_register_clocks(node, clk_data, priv);
+	if (ret) {
+		pr_err("Couldn't register top clocks\n");
+		goto free_clk_data;
+	}
+
+	ret = mtmips_register_pherip_clocks(node, clk_data, priv);
+	if (ret) {
+		pr_err("Couldn't register peripheral clocks\n");
+		goto unreg_clk_top;
+	}
+
+	clk_data->num = count;
+
+	ret = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
+	if (ret) {
+		pr_err("Couldn't add clk hw provider\n");
+		goto unreg_clk_periph;
+	}
+
+	return;
+
+unreg_clk_periph:
+	for (i = 0; i < priv->data->num_clk_periph; i++) {
+		struct mtmips_clk *sclk = &priv->data->clk_periph[i];
+
+		clk_hw_unregister(&sclk->hw);
+	}
+
+unreg_clk_top:
+	for (i = 0; i < priv->data->num_clk_base; i++) {
+		struct mtmips_clk *sclk = &priv->data->clk_base[i];
+
+		clk_hw_unregister(&sclk->hw);
+	}
+
+free_clk_data:
+	kfree(clk_data);
+
+free_clk_priv:
+	kfree(priv);
+}
+CLK_OF_DECLARE_DRIVER(rt2880_clk, "ralink,rt2880-sysc", mtmips_clk_init);
+CLK_OF_DECLARE_DRIVER(rt3050_clk, "ralink,rt3050-sysc", mtmips_clk_init);
+CLK_OF_DECLARE_DRIVER(rt3052_clk, "ralink,rt3052-sysc", mtmips_clk_init);
+CLK_OF_DECLARE_DRIVER(rt3352_clk, "ralink,rt3352-sysc", mtmips_clk_init);
+CLK_OF_DECLARE_DRIVER(rt3883_clk, "ralink,rt3883-sysc", mtmips_clk_init);
+CLK_OF_DECLARE_DRIVER(rt5350_clk, "ralink,rt5350-sysc", mtmips_clk_init);
+CLK_OF_DECLARE_DRIVER(mt7620_clk, "ralink,mt7620-sysc", mtmips_clk_init);
+CLK_OF_DECLARE_DRIVER(mt7620a_clk, "ralink,mt7620a-sysc", mtmips_clk_init);
+CLK_OF_DECLARE_DRIVER(mt7628_clk, "ralink,mt7628-sysc", mtmips_clk_init);
+CLK_OF_DECLARE_DRIVER(mt7688_clk, "ralink,mt7688-sysc", mtmips_clk_init);
+
+struct mtmips_rst {
+	struct reset_controller_dev rcdev;
+	struct regmap *sysc;
+};
+
+static struct mtmips_rst *to_mtmips_rst(struct reset_controller_dev *dev)
+{
+	return container_of(dev, struct mtmips_rst, rcdev);
+}
+
+static int mtmips_assert_device(struct reset_controller_dev *rcdev,
+				unsigned long id)
+{
+	struct mtmips_rst *data = to_mtmips_rst(rcdev);
+	struct regmap *sysc = data->sysc;
+
+	return regmap_update_bits(sysc, SYSC_REG_RESET_CTRL, BIT(id), BIT(id));
+}
+
+static int mtmips_deassert_device(struct reset_controller_dev *rcdev,
+				  unsigned long id)
+{
+	struct mtmips_rst *data = to_mtmips_rst(rcdev);
+	struct regmap *sysc = data->sysc;
+
+	return regmap_update_bits(sysc, SYSC_REG_RESET_CTRL, BIT(id), 0);
+}
+
+static int mtmips_reset_device(struct reset_controller_dev *rcdev,
+			       unsigned long id)
+{
+	int ret;
+
+	ret = mtmips_assert_device(rcdev, id);
+	if (ret < 0)
+		return ret;
+
+	return mtmips_deassert_device(rcdev, id);
+}
+
+static int mtmips_rst_xlate(struct reset_controller_dev *rcdev,
+			    const struct of_phandle_args *reset_spec)
+{
+	unsigned long id = reset_spec->args[0];
+
+	if (id == 0 || id >= rcdev->nr_resets)
+		return -EINVAL;
+
+	return id;
+}
+
+static const struct reset_control_ops reset_ops = {
+	.reset = mtmips_reset_device,
+	.assert = mtmips_assert_device,
+	.deassert = mtmips_deassert_device
+};
+
+static int mtmips_reset_init(struct device *dev, struct regmap *sysc)
+{
+	struct mtmips_rst *rst_data;
+
+	rst_data = devm_kzalloc(dev, sizeof(*rst_data), GFP_KERNEL);
+	if (!rst_data)
+		return -ENOMEM;
+
+	rst_data->sysc = sysc;
+	rst_data->rcdev.ops = &reset_ops;
+	rst_data->rcdev.owner = THIS_MODULE;
+	rst_data->rcdev.nr_resets = 32;
+	rst_data->rcdev.of_reset_n_cells = 1;
+	rst_data->rcdev.of_xlate = mtmips_rst_xlate;
+	rst_data->rcdev.of_node = dev_of_node(dev);
+
+	return devm_reset_controller_register(dev, &rst_data->rcdev);
+}
+
+static int mtmips_clk_probe(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct device *dev = &pdev->dev;
+	struct mtmips_clk_priv *priv;
+	int ret;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->sysc = syscon_node_to_regmap(np);
+	if (IS_ERR(priv->sysc)) {
+		ret = PTR_ERR(priv->sysc);
+		dev_err(dev, "Could not get sysc syscon regmap\n");
+		return ret;
+	}
+
+	ret = mtmips_reset_init(dev, priv->sysc);
+	if (ret) {
+		dev_err(dev, "Could not init reset controller\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static const struct of_device_id mtmips_clk_of_match[] = {
+	{ .compatible = "ralink,rt2880-reset" },
+	{ .compatible = "ralink,rt2880-sysc" },
+	{ .compatible = "ralink,rt3050-sysc" },
+	{ .compatible = "ralink,rt3050-sysc" },
+	{ .compatible = "ralink,rt3352-sysc" },
+	{ .compatible = "ralink,rt3883-sysc" },
+	{ .compatible = "ralink,rt5350-sysc" },
+	{ .compatible = "ralink,mt7620a-sysc" },
+	{ .compatible = "ralink,mt7620-sysc" },
+	{ .compatible = "ralink,mt7628-sysc" },
+	{ .compatible = "ralink,mt7688-sysc" },
+	{}
+};
+
+static struct platform_driver mtmips_clk_driver = {
+	.probe = mtmips_clk_probe,
+	.driver = {
+		.name = "mtmips-clk",
+		.of_match_table = mtmips_clk_of_match,
+	},
+};
+
+static int __init mtmips_clk_reset_init(void)
+{
+	return platform_driver_register(&mtmips_clk_driver);
+}
+arch_initcall(mtmips_clk_reset_init);
-- 
2.25.1

