Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 608AB63FB24
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 23:58:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231788AbiLAW6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 17:58:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231654AbiLAW5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 17:57:38 -0500
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 741F21A4;
        Thu,  1 Dec 2022 14:57:32 -0800 (PST)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id D17005FD0D;
        Fri,  2 Dec 2022 01:57:30 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1669935450;
        bh=jlFI8jiIzHvwJyrx61i0yCrtfZpp7C91e4n7Ha5ayVs=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=ek4H1UPjyqSDtKiYo12/oG6XCKi2UwTYMCzT+cnnx7mLoOqxGq6yTnrfONXUEfA9G
         77hzodmBnpKsExSrf5m47F1y0LVFvqSp0DSpKckaQ2BXFfbV5rqDl7wjjaFzceBsL+
         c/YMXyrCCt7WaQGyGQZO8QFwz1T0SRMt0lvj7EL+3jvSXb1BwC3vGiZB89LIQIeGuJ
         OtFlrUcTszAWRoF3eeWDGO7kIRrERhzDLc8/w31JWNWGMFjRAlrUcmlELx8jLUytLa
         1Eg4zZoHpofE35ykjqGooY9r7QO7z/KqmGn9H9zPYKJzQVz/U2bFaN2x3cDcAsR/4M
         GMNYYSpYnrX0A==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Fri,  2 Dec 2022 01:57:30 +0300 (MSK)
From:   Dmitry Rokosov <ddrokosov@sberdevices.ru>
To:     <neil.armstrong@linaro.org>, <jbrunet@baylibre.com>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <khilman@baylibre.com>, <martin.blumenstingl@googlemail.com>
CC:     <jian.hu@amlogic.com>, <kernel@sberdevices.ru>,
        <rockosov@gmail.com>, <linux-amlogic@lists.infradead.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Dmitry Rokosov <ddrokosov@sberdevices.ru>
Subject: [PATCH v8 04/11] clk: meson: a1: add support for Amlogic A1 Peripheral clock driver
Date:   Fri, 2 Dec 2022 01:56:56 +0300
Message-ID: <20221201225703.6507-5-ddrokosov@sberdevices.ru>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20221201225703.6507-1-ddrokosov@sberdevices.ru>
References: <20221201225703.6507-1-ddrokosov@sberdevices.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH02.sberdevices.ru (172.16.1.5) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2022/12/01 20:49:00 #20634374
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jian Hu <jian.hu@amlogic.com>

Add Amlogic Meson A1 peripheral clock driver, it depends
on the A1 PLL driver.

Signed-off-by: Jian Hu <jian.hu@amlogic.com>
Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
---
 drivers/clk/meson/Kconfig  |    9 +
 drivers/clk/meson/Makefile |    1 +
 drivers/clk/meson/a1.c     | 2249 ++++++++++++++++++++++++++++++++++++
 drivers/clk/meson/a1.h     |  120 ++
 4 files changed, 2379 insertions(+)
 create mode 100644 drivers/clk/meson/a1.c
 create mode 100644 drivers/clk/meson/a1.h

diff --git a/drivers/clk/meson/Kconfig b/drivers/clk/meson/Kconfig
index ab34662b24f0..bd44ba47200e 100644
--- a/drivers/clk/meson/Kconfig
+++ b/drivers/clk/meson/Kconfig
@@ -108,6 +108,15 @@ config COMMON_CLK_A1_PLL
 	  Support for the PLL clock controller on Amlogic A113L device,
 	  aka a1. Say Y if you want PLL to work.
 
+config COMMON_CLK_A1
+	bool
+	depends on ARCH_MESON
+	select COMMON_CLK_MESON_DUALDIV
+	select COMMON_CLK_MESON_REGMAP
+	help
+	  Support for the Peripheral clock controller on Amlogic A113L device,
+	  aka a1. Say Y if you want Peripherals to work.
+
 config COMMON_CLK_G12A
 	tristate "G12 and SM1 SoC clock controllers support"
 	depends on ARM64
diff --git a/drivers/clk/meson/Makefile b/drivers/clk/meson/Makefile
index 2f17f475a48f..0e6f293c05d4 100644
--- a/drivers/clk/meson/Makefile
+++ b/drivers/clk/meson/Makefile
@@ -17,6 +17,7 @@ obj-$(CONFIG_COMMON_CLK_MESON_VID_PLL_DIV) += vid-pll-div.o
 obj-$(CONFIG_COMMON_CLK_AXG) += axg.o axg-aoclk.o
 obj-$(CONFIG_COMMON_CLK_AXG_AUDIO) += axg-audio.o
 obj-$(CONFIG_COMMON_CLK_A1_PLL) += a1-pll.o
+obj-$(CONFIG_COMMON_CLK_A1) += a1.o
 obj-$(CONFIG_COMMON_CLK_GXBB) += gxbb.o gxbb-aoclk.o
 obj-$(CONFIG_COMMON_CLK_G12A) += g12a.o g12a-aoclk.o
 obj-$(CONFIG_COMMON_CLK_MESON8B) += meson8b.o meson8-ddr.o
diff --git a/drivers/clk/meson/a1.c b/drivers/clk/meson/a1.c
new file mode 100644
index 000000000000..2cf20ae1db75
--- /dev/null
+++ b/drivers/clk/meson/a1.c
@@ -0,0 +1,2249 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2019 Amlogic, Inc. All rights reserved.
+ * Author: Jian Hu <jian.hu@amlogic.com>
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include "a1.h"
+#include "clk-dualdiv.h"
+#include "clk-regmap.h"
+
+static struct clk_regmap a1_xtal_clktree = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = SYS_OSCIN_CTRL,
+		.bit_idx = 0,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "xtal_clktree",
+		.ops = &clk_regmap_gate_ro_ops,
+		.parent_data = &(const struct clk_parent_data) {
+			.fw_name = "xtal",
+		},
+		.num_parents = 1,
+	},
+};
+
+static struct clk_regmap a1_xtal_fixpll = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = SYS_OSCIN_CTRL,
+		.bit_idx = 1,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "xtal_fixpll",
+		.ops = &clk_regmap_gate_ro_ops,
+		.parent_data = &(const struct clk_parent_data) {
+			.fw_name = "xtal",
+		},
+		.num_parents = 1,
+	},
+};
+
+static struct clk_regmap a1_xtal_usb_phy = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = SYS_OSCIN_CTRL,
+		.bit_idx = 2,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "xtal_usb_phy",
+		.ops = &clk_regmap_gate_ops,
+		.parent_data = &(const struct clk_parent_data) {
+			.fw_name = "xtal",
+		},
+		.num_parents = 1,
+	},
+};
+
+static struct clk_regmap a1_xtal_usb_ctrl = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = SYS_OSCIN_CTRL,
+		.bit_idx = 3,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "xtal_usb_ctrl",
+		.ops = &clk_regmap_gate_ops,
+		.parent_data = &(const struct clk_parent_data) {
+			.fw_name = "xtal",
+		},
+		.num_parents = 1,
+	},
+};
+
+static struct clk_regmap a1_xtal_hifipll = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = SYS_OSCIN_CTRL,
+		.bit_idx = 4,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "xtal_hifipll",
+		.ops = &clk_regmap_gate_ops,
+		.parent_data = &(const struct clk_parent_data) {
+			.fw_name = "xtal",
+		},
+		.num_parents = 1,
+	},
+};
+
+static struct clk_regmap a1_xtal_syspll = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = SYS_OSCIN_CTRL,
+		.bit_idx = 5,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "xtal_syspll",
+		.ops = &clk_regmap_gate_ops,
+		.parent_data = &(const struct clk_parent_data) {
+			.fw_name = "xtal",
+		},
+		.num_parents = 1,
+	},
+};
+
+static struct clk_regmap a1_xtal_dds = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = SYS_OSCIN_CTRL,
+		.bit_idx = 6,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "xtal_dds",
+		.ops = &clk_regmap_gate_ops,
+		.parent_data = &(const struct clk_parent_data) {
+			.fw_name = "xtal",
+		},
+		.num_parents = 1,
+	},
+};
+
+static const struct clk_parent_data sys_clk_parents[] = {
+	{ .fw_name = "xtal" },
+	{ .fw_name = "fclk_div2" },
+	{ .fw_name = "fclk_div3" },
+	{ .fw_name = "fclk_div5" },
+};
+
+static struct clk_regmap a1_sys_b_sel = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = SYS_CLK_CTRL0,
+		.mask = 0x7,
+		.shift = 26,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "sys_b_sel",
+		.ops = &clk_regmap_mux_ro_ops,
+		.parent_data = sys_clk_parents,
+		.num_parents = ARRAY_SIZE(sys_clk_parents),
+	},
+};
+
+static struct clk_regmap a1_sys_b_div = {
+	.data = &(struct clk_regmap_div_data){
+		.offset = SYS_CLK_CTRL0,
+		.shift = 16,
+		.width = 10,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "sys_b_div",
+		.ops = &clk_regmap_divider_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&a1_sys_b_sel.hw
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap a1_sys_b = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = SYS_CLK_CTRL0,
+		.bit_idx = 29,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "sys_b",
+		.ops = &clk_regmap_gate_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&a1_sys_b_div.hw
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap a1_sys_a_sel = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = SYS_CLK_CTRL0,
+		.mask = 0x7,
+		.shift = 10,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "sys_a_sel",
+		.ops = &clk_regmap_mux_ro_ops,
+		.parent_data = sys_clk_parents,
+		.num_parents = ARRAY_SIZE(sys_clk_parents),
+	},
+};
+
+static struct clk_regmap a1_sys_a_div = {
+	.data = &(struct clk_regmap_div_data){
+		.offset = SYS_CLK_CTRL0,
+		.shift = 0,
+		.width = 10,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "sys_a_div",
+		.ops = &clk_regmap_divider_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&a1_sys_a_sel.hw
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap a1_sys_a = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = SYS_CLK_CTRL0,
+		.bit_idx = 13,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "sys_a",
+		.ops = &clk_regmap_gate_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&a1_sys_a_div.hw
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap a1_sys_clk = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = SYS_CLK_CTRL0,
+		.mask = 0x1,
+		.shift = 31,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "sys_clk",
+		.ops = &clk_regmap_mux_ro_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&a1_sys_a.hw, &a1_sys_b.hw,
+		},
+		.num_parents = 2,
+		/*
+		 * This clock is used by APB bus which is set in boot ROM code
+		 * and is required by the platform to operate correctly.
+		 * Until the following condition are met, we need this clock to
+		 * be marked as critical:
+		 * a) Mark the clock used by a firmware resource, if possible
+		 * b) CCF has a clock hand-off mechanism to make the sure the
+		 *    clock stays on until the proper driver comes along
+		 */
+		.flags = CLK_SET_RATE_PARENT | CLK_IS_CRITICAL,
+	},
+};
+
+static struct clk_regmap a1_rtc_32k_clkin = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = RTC_BY_OSCIN_CTRL0,
+		.bit_idx = 31,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "rtc_32k_clkin",
+		.ops = &clk_regmap_gate_ops,
+		.parent_data = &(const struct clk_parent_data) {
+			.fw_name = "xtal",
+		},
+		.num_parents = 1,
+	},
+};
+
+static const struct meson_clk_dualdiv_param a1_32k_div_table[] = {
+	{
+		.dual		= 1,
+		.n1		= 733,
+		.m1		= 8,
+		.n2		= 732,
+		.m2		= 11,
+	},
+	{}
+};
+
+static struct clk_regmap a1_rtc_32k_div = {
+	.data = &(struct meson_clk_dualdiv_data){
+		.n1 = {
+			.reg_off = RTC_BY_OSCIN_CTRL0,
+			.shift   = 0,
+			.width   = 12,
+		},
+		.n2 = {
+			.reg_off = RTC_BY_OSCIN_CTRL0,
+			.shift   = 12,
+			.width   = 12,
+		},
+		.m1 = {
+			.reg_off = RTC_BY_OSCIN_CTRL1,
+			.shift   = 0,
+			.width   = 12,
+		},
+		.m2 = {
+			.reg_off = RTC_BY_OSCIN_CTRL1,
+			.shift   = 12,
+			.width   = 12,
+		},
+		.dual = {
+			.reg_off = RTC_BY_OSCIN_CTRL0,
+			.shift   = 28,
+			.width   = 1,
+		},
+		.table = a1_32k_div_table,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "rtc_32k_div",
+		.ops = &meson_clk_dualdiv_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&a1_rtc_32k_clkin.hw
+		},
+		.num_parents = 1,
+	},
+};
+
+static struct clk_regmap a1_rtc_32k_xtal = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = RTC_BY_OSCIN_CTRL1,
+		.bit_idx = 24,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "rtc_32k_xtal",
+		.ops = &clk_regmap_gate_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&a1_rtc_32k_clkin.hw
+		},
+		.num_parents = 1,
+	},
+};
+
+static struct clk_regmap a1_rtc_32k_sel = {
+	.data = &(struct clk_regmap_mux_data) {
+		.offset = RTC_CTRL,
+		.mask = 0x3,
+		.shift = 0,
+		.flags = CLK_MUX_ROUND_CLOSEST,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "rtc_32k_sel",
+		.ops = &clk_regmap_mux_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&a1_rtc_32k_xtal.hw,
+			&a1_rtc_32k_div.hw,
+		},
+		.num_parents = 2,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+struct clk_regmap a1_rtc_clk = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = RTC_BY_OSCIN_CTRL0,
+		.bit_idx = 30,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "rtc_clk",
+		.ops = &clk_regmap_gate_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&a1_rtc_32k_sel.hw
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static u32 mux_table_dsp_ab[] = { 0, 1, 2, 3, 4, 7 };
+static const struct clk_parent_data dsp_ab_clk_parent_data[] = {
+	{ .fw_name = "xtal", },
+	{ .fw_name = "fclk_div2", },
+	{ .fw_name = "fclk_div3", },
+	{ .fw_name = "fclk_div5", },
+	{ .fw_name = "hifi_pll", },
+	{ .hw = &a1_rtc_clk.hw },
+};
+
+static struct clk_regmap a1_dspa_a_sel = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = DSPA_CLK_CTRL0,
+		.mask = 0x7,
+		.shift = 10,
+		.table = mux_table_dsp_ab,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "dspa_a_sel",
+		.ops = &clk_regmap_mux_ops,
+		.parent_data = dsp_ab_clk_parent_data,
+		.num_parents = ARRAY_SIZE(dsp_ab_clk_parent_data),
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap a1_dspa_a_div = {
+	.data = &(struct clk_regmap_div_data){
+		.offset = DSPA_CLK_CTRL0,
+		.shift = 0,
+		.width = 10,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "dspa_a_div",
+		.ops = &clk_regmap_divider_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&a1_dspa_a_sel.hw
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap a1_dspa_a = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = DSPA_CLK_CTRL0,
+		.bit_idx = 13,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "dspa_a",
+		.ops = &clk_regmap_gate_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&a1_dspa_a_div.hw
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap a1_dspa_b_sel = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = DSPA_CLK_CTRL0,
+		.mask = 0x7,
+		.shift = 26,
+		.table = mux_table_dsp_ab,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "dspa_b_sel",
+		.ops = &clk_regmap_mux_ops,
+		.parent_data = dsp_ab_clk_parent_data,
+		.num_parents = ARRAY_SIZE(dsp_ab_clk_parent_data),
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap a1_dspa_b_div = {
+	.data = &(struct clk_regmap_div_data){
+		.offset = DSPA_CLK_CTRL0,
+		.shift = 16,
+		.width = 10,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "dspa_b_div",
+		.ops = &clk_regmap_divider_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&a1_dspa_b_sel.hw
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap a1_dspa_b = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = DSPA_CLK_CTRL0,
+		.bit_idx = 29,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "dspa_b",
+		.ops = &clk_regmap_gate_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&a1_dspa_b_div.hw
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap a1_dspa_sel = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = DSPA_CLK_CTRL0,
+		.mask = 0x1,
+		.shift = 15,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "dspa_sel",
+		.ops = &clk_regmap_mux_ops,
+		.parent_data = (const struct clk_parent_data []) {
+			{ .hw = &a1_dspa_a.hw },
+			{ .hw = &a1_dspa_b.hw },
+		},
+		.num_parents = 2,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap a1_dspa_en = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = DSPA_CLK_EN,
+		.bit_idx = 1,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "dspa_en",
+		.ops = &clk_regmap_gate_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&a1_dspa_sel.hw
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap a1_dspa_en_nic = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = DSPA_CLK_EN,
+		.bit_idx = 0,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "dspa_en_nic",
+		.ops = &clk_regmap_gate_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&a1_dspa_sel.hw
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap a1_dspb_a_sel = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = DSPB_CLK_CTRL0,
+		.mask = 0x7,
+		.shift = 10,
+		.table = mux_table_dsp_ab,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "dspb_a_sel",
+		.ops = &clk_regmap_mux_ops,
+		.parent_data = dsp_ab_clk_parent_data,
+		.num_parents = ARRAY_SIZE(dsp_ab_clk_parent_data),
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap a1_dspb_a_div = {
+	.data = &(struct clk_regmap_div_data){
+		.offset = DSPB_CLK_CTRL0,
+		.shift = 0,
+		.width = 10,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "dspb_a_div",
+		.ops = &clk_regmap_divider_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&a1_dspb_a_sel.hw
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap a1_dspb_a = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = DSPB_CLK_CTRL0,
+		.bit_idx = 13,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "dspb_a",
+		.ops = &clk_regmap_gate_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&a1_dspb_a_div.hw
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
+	},
+};
+
+static struct clk_regmap a1_dspb_b_sel = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = DSPB_CLK_CTRL0,
+		.mask = 0x7,
+		.shift = 26,
+		.table = mux_table_dsp_ab,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "dspb_b_sel",
+		.ops = &clk_regmap_mux_ops,
+		.parent_data = dsp_ab_clk_parent_data,
+		.num_parents = ARRAY_SIZE(dsp_ab_clk_parent_data),
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap a1_dspb_b_div = {
+	.data = &(struct clk_regmap_div_data){
+		.offset = DSPB_CLK_CTRL0,
+		.shift = 16,
+		.width = 10,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "dspb_b_div",
+		.ops = &clk_regmap_divider_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&a1_dspb_b_sel.hw
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap a1_dspb_b = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = DSPB_CLK_CTRL0,
+		.bit_idx = 29,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "dspb_b",
+		.ops = &clk_regmap_gate_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&a1_dspb_b_div.hw
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
+	},
+};
+
+static struct clk_regmap a1_dspb_sel = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = DSPB_CLK_CTRL0,
+		.mask = 0x1,
+		.shift = 15,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "dspb_sel",
+		.ops = &clk_regmap_mux_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&a1_dspb_a.hw, &a1_dspb_b.hw,
+		},
+		.num_parents = 2,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap a1_dspb_en = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = DSPB_CLK_EN,
+		.bit_idx = 1,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "dspb_en",
+		.ops = &clk_regmap_gate_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&a1_dspb_sel.hw
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
+	},
+};
+
+static struct clk_regmap a1_dspb_en_nic = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = DSPB_CLK_EN,
+		.bit_idx = 0,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "dspb_en_nic",
+		.ops = &clk_regmap_gate_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&a1_dspb_sel.hw
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
+	},
+};
+
+static struct clk_regmap a1_24m = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = CLK12_24_CTRL,
+		.bit_idx = 11,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "24m",
+		.ops = &clk_regmap_gate_ops,
+		.parent_data = &(const struct clk_parent_data) {
+			.fw_name = "xtal",
+		},
+		.num_parents = 1,
+	},
+};
+
+static struct clk_fixed_factor a1_24m_div2 = {
+	.mult = 1,
+	.div = 2,
+	.hw.init = &(struct clk_init_data){
+		.name = "24m_div2",
+		.ops = &clk_fixed_factor_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&a1_24m.hw
+		},
+		.num_parents = 1,
+	},
+};
+
+static struct clk_regmap a1_12m = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = CLK12_24_CTRL,
+		.bit_idx = 10,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "12m",
+		.ops = &clk_regmap_gate_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&a1_24m_div2.hw
+		},
+		.num_parents = 1,
+	},
+};
+
+static struct clk_regmap a1_fclk_div2_divn_pre = {
+	.data = &(struct clk_regmap_div_data){
+		.offset = CLK12_24_CTRL,
+		.shift = 0,
+		.width = 8,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "fclk_div2_divn_pre",
+		.ops = &clk_regmap_divider_ops,
+		.parent_data = &(const struct clk_parent_data) {
+			.fw_name = "fclk_div2",
+		},
+		.num_parents = 1,
+	},
+};
+
+static struct clk_regmap a1_fclk_div2_divn = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = CLK12_24_CTRL,
+		.bit_idx = 12,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "fclk_div2_divn",
+		.ops = &clk_regmap_gate_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&a1_fclk_div2_divn_pre.hw
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+/*
+ * the index 2 is sys_pll_div16, it will complete in the CPU clock,
+ * the index 4 is the clock measurement source, it relies on
+ * the clock measurement register configuration.
+ */
+static u32 gen_clk_table[] = { 0, 1, 3, 5, 6, 7, 8 };
+static const struct clk_parent_data gen_clk_parent_data[] = {
+	{ .fw_name = "xtal", },
+	{ .hw = &a1_rtc_clk.hw },
+	{ .fw_name = "hifi_pll", },
+	{ .fw_name = "fclk_div2", },
+	{ .fw_name = "fclk_div3", },
+	{ .fw_name = "fclk_div5", },
+	{ .fw_name = "fclk_div7", },
+};
+
+static struct clk_regmap a1_gen_sel = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = GEN_CLK_CTRL,
+		.mask = 0xf,
+		.shift = 12,
+		.table = gen_clk_table,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "gen_sel",
+		.ops = &clk_regmap_mux_ops,
+		.parent_data = gen_clk_parent_data,
+		.num_parents = ARRAY_SIZE(gen_clk_parent_data),
+	},
+};
+
+static struct clk_regmap a1_gen_div = {
+	.data = &(struct clk_regmap_div_data){
+		.offset = GEN_CLK_CTRL,
+		.shift = 0,
+		.width = 11,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "gen_div",
+		.ops = &clk_regmap_divider_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&a1_gen_sel.hw
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap a1_gen = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = GEN_CLK_CTRL,
+		.bit_idx = 11,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "gen",
+		.ops = &clk_regmap_gate_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&a1_gen_div.hw
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap a1_saradc_sel = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = SAR_ADC_CLK_CTRL,
+		.mask = 0x1,
+		.shift = 9,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "saradc_sel",
+		.ops = &clk_regmap_mux_ops,
+		.parent_data = (const struct clk_parent_data []) {
+			{ .fw_name = "xtal", },
+			{ .hw = &a1_sys_clk.hw, },
+		},
+		.num_parents = 2,
+	},
+};
+
+static struct clk_regmap a1_saradc_div = {
+	.data = &(struct clk_regmap_div_data){
+		.offset = SAR_ADC_CLK_CTRL,
+		.shift = 0,
+		.width = 8,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "saradc_div",
+		.ops = &clk_regmap_divider_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&a1_saradc_sel.hw
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap a1_saradc_clk = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = SAR_ADC_CLK_CTRL,
+		.bit_idx = 8,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "saradc_clk",
+		.ops = &clk_regmap_gate_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&a1_saradc_div.hw
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap a1_pwm_a_sel = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = PWM_CLK_AB_CTRL,
+		.mask = 0x1,
+		.shift = 9,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "pwm_a_sel",
+		.ops = &clk_regmap_mux_ops,
+		.parent_data = (const struct clk_parent_data []) {
+			{ .fw_name = "xtal", },
+			{ .hw = &a1_sys_clk.hw, },
+		},
+		.num_parents = 2,
+	},
+};
+
+static struct clk_regmap a1_pwm_a_div = {
+	.data = &(struct clk_regmap_div_data){
+		.offset = PWM_CLK_AB_CTRL,
+		.shift = 0,
+		.width = 8,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "pwm_a_div",
+		.ops = &clk_regmap_divider_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&a1_pwm_a_sel.hw
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap a1_pwm_a = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = PWM_CLK_AB_CTRL,
+		.bit_idx = 8,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "pwm_a",
+		.ops = &clk_regmap_gate_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&a1_pwm_a_div.hw
+		},
+		.num_parents = 1,
+		/*
+		 * The CPU working voltage is controlled by pwm_a
+		 * in BL2 firmware. The clock is required by the platform
+		 * to operate correctly. Add the CLK_IS_CRITICAL flag to
+		 * avoid changing at runtime.
+		 * About critical, refer to a1_sys_clk
+		 */
+		.flags = CLK_SET_RATE_PARENT | CLK_IS_CRITICAL,
+	},
+};
+
+static struct clk_regmap a1_pwm_b_sel = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = PWM_CLK_AB_CTRL,
+		.mask = 0x1,
+		.shift = 25,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "pwm_b_sel",
+		.ops = &clk_regmap_mux_ops,
+		.parent_data = (const struct clk_parent_data []) {
+			{ .fw_name = "xtal", },
+			{ .hw = &a1_sys_clk.hw, },
+		},
+		.num_parents = 2,
+	},
+};
+
+static struct clk_regmap a1_pwm_b_div = {
+	.data = &(struct clk_regmap_div_data){
+		.offset = PWM_CLK_AB_CTRL,
+		.shift = 16,
+		.width = 8,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "pwm_b_div",
+		.ops = &clk_regmap_divider_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&a1_pwm_b_sel.hw
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap a1_pwm_b = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = PWM_CLK_AB_CTRL,
+		.bit_idx = 24,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "pwm_b",
+		.ops = &clk_regmap_gate_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&a1_pwm_b_div.hw
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap a1_pwm_c_sel = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = PWM_CLK_CD_CTRL,
+		.mask = 0x1,
+		.shift = 9,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "pwm_c_sel",
+		.ops = &clk_regmap_mux_ops,
+		.parent_data = (const struct clk_parent_data []) {
+			{ .fw_name = "xtal", },
+			{ .hw = &a1_sys_clk.hw, },
+		},
+		.num_parents = 2,
+	},
+};
+
+static struct clk_regmap a1_pwm_c_div = {
+	.data = &(struct clk_regmap_div_data){
+		.offset = PWM_CLK_CD_CTRL,
+		.shift = 0,
+		.width = 8,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "pwm_c_div",
+		.ops = &clk_regmap_divider_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&a1_pwm_c_sel.hw
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap a1_pwm_c = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = PWM_CLK_CD_CTRL,
+		.bit_idx = 8,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "pwm_c",
+		.ops = &clk_regmap_gate_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&a1_pwm_c_div.hw
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap a1_pwm_d_sel = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = PWM_CLK_CD_CTRL,
+		.mask = 0x1,
+		.shift = 25,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "pwm_d_sel",
+		.ops = &clk_regmap_mux_ops,
+		.parent_data = (const struct clk_parent_data []) {
+			{ .fw_name = "xtal", },
+			{ .hw = &a1_sys_clk.hw, },
+		},
+		.num_parents = 2,
+	},
+};
+
+static struct clk_regmap a1_pwm_d_div = {
+	.data = &(struct clk_regmap_div_data){
+		.offset = PWM_CLK_CD_CTRL,
+		.shift = 16,
+		.width = 8,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "pwm_d_div",
+		.ops = &clk_regmap_divider_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&a1_pwm_d_sel.hw
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap a1_pwm_d = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = PWM_CLK_CD_CTRL,
+		.bit_idx = 24,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "pwm_d",
+		.ops = &clk_regmap_gate_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&a1_pwm_d_div.hw
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static const struct clk_parent_data pwm_ef_parent_data[] = {
+	{ .fw_name = "xtal", },
+	{ .hw = &a1_sys_clk.hw },
+	{ .fw_name = "fclk_div5", },
+	{ .hw = &a1_rtc_clk.hw },
+};
+
+static struct clk_regmap a1_pwm_e_sel = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = PWM_CLK_EF_CTRL,
+		.mask = 0x3,
+		.shift = 9,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "pwm_e_sel",
+		.ops = &clk_regmap_mux_ops,
+		.parent_data = pwm_ef_parent_data,
+		.num_parents = ARRAY_SIZE(pwm_ef_parent_data),
+	},
+};
+
+static struct clk_regmap a1_pwm_e_div = {
+	.data = &(struct clk_regmap_div_data){
+		.offset = PWM_CLK_EF_CTRL,
+		.shift = 0,
+		.width = 8,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "pwm_e_div",
+		.ops = &clk_regmap_divider_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&a1_pwm_e_sel.hw
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap a1_pwm_e = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = PWM_CLK_EF_CTRL,
+		.bit_idx = 8,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "pwm_e",
+		.ops = &clk_regmap_gate_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&a1_pwm_e_div.hw
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap a1_pwm_f_sel = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = PWM_CLK_EF_CTRL,
+		.mask = 0x3,
+		.shift = 25,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "pwm_f_sel",
+		.ops = &clk_regmap_mux_ops,
+		.parent_data = pwm_ef_parent_data,
+		.num_parents = ARRAY_SIZE(pwm_ef_parent_data),
+	},
+};
+
+static struct clk_regmap a1_pwm_f_div = {
+	.data = &(struct clk_regmap_div_data){
+		.offset = PWM_CLK_EF_CTRL,
+		.shift = 16,
+		.width = 8,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "pwm_f_div",
+		.ops = &clk_regmap_divider_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&a1_pwm_f_sel.hw
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap a1_pwm_f = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = PWM_CLK_EF_CTRL,
+		.bit_idx = 24,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "pwm_f",
+		.ops = &clk_regmap_gate_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&a1_pwm_f_div.hw
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+/*
+ * spicc clk
+ *   fdiv2   |\         |\       _____
+ *  ---------| |---DIV--| |     |     |    spicc out
+ *  ---------| |        | |-----|GATE |---------
+ *     ..... |/         | /     |_____|
+ *  --------------------|/
+ *                 24M
+ */
+static const struct clk_parent_data spicc_parents[] = {
+	{ .fw_name = "fclk_div2"},
+	{ .fw_name = "fclk_div3"},
+	{ .fw_name = "fclk_div5"},
+	{ .fw_name = "hifi_pll" },
+};
+
+static struct clk_regmap a1_spicc_sel = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = SPICC_CLK_CTRL,
+		.mask = 0x3,
+		.shift = 9,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "spicc_sel",
+		.ops = &clk_regmap_mux_ops,
+		.parent_data = spicc_parents,
+		.num_parents = 4,
+	},
+};
+
+static struct clk_regmap a1_spicc_div = {
+	.data = &(struct clk_regmap_div_data){
+		.offset = SPICC_CLK_CTRL,
+		.shift = 0,
+		.width = 8,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "spicc_div",
+		.ops = &clk_regmap_divider_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&a1_spicc_sel.hw
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap a1_spicc_sel2 = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = SPICC_CLK_CTRL,
+		.mask = 0x1,
+		.shift = 15,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "spicc_sel2",
+		.ops = &clk_regmap_mux_ops,
+		.parent_data = (const struct clk_parent_data []) {
+			{ .hw = &a1_spicc_div.hw },
+			{ .fw_name = "xtal", },
+		},
+		.num_parents = 2,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap a1_spicc = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = SPICC_CLK_CTRL,
+		.bit_idx = 8,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "spicc",
+		.ops = &clk_regmap_gate_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&a1_spicc_sel2.hw
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap a1_ts_div = {
+	.data = &(struct clk_regmap_div_data){
+		.offset = TS_CLK_CTRL,
+		.shift = 0,
+		.width = 8,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "ts_div",
+		.ops = &clk_regmap_divider_ops,
+		.parent_data = &(const struct clk_parent_data) {
+			.fw_name = "xtal",
+		},
+		.num_parents = 1,
+	},
+};
+
+static struct clk_regmap a1_ts = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = TS_CLK_CTRL,
+		.bit_idx = 8,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "ts",
+		.ops = &clk_regmap_gate_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&a1_ts_div.hw
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap a1_spifc_sel = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = SPIFC_CLK_CTRL,
+		.mask = 0x3,
+		.shift = 9,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "spifc_sel",
+		.ops = &clk_regmap_mux_ops,
+		/* the same parent with spicc */
+		.parent_data = spicc_parents,
+		.num_parents = 4,
+	},
+};
+
+static struct clk_regmap a1_spifc_div = {
+	.data = &(struct clk_regmap_div_data){
+		.offset = SPIFC_CLK_CTRL,
+		.shift = 0,
+		.width = 8,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "spifc_div",
+		.ops = &clk_regmap_divider_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&a1_spifc_sel.hw
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap a1_spifc_sel2 = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = SPIFC_CLK_CTRL,
+		.mask = 0x1,
+		.shift = 15,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "spifc_sel2",
+		.ops = &clk_regmap_mux_ops,
+		.parent_data = (const struct clk_parent_data []) {
+			{ .hw = &a1_spifc_div.hw },
+			{ .fw_name = "xtal", },
+		},
+		.num_parents = 2,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap a1_spifc = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = SPIFC_CLK_CTRL,
+		.bit_idx = 8,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "spifc",
+		.ops = &clk_regmap_gate_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&a1_spifc_sel2.hw
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static const struct clk_parent_data usb_bus_parent_data[] = {
+	{ .fw_name = "xtal", },
+	{ .hw = &a1_sys_clk.hw },
+	{ .fw_name = "fclk_div3", },
+	{ .fw_name = "fclk_div5", },
+};
+
+static struct clk_regmap a1_usb_bus_sel = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = USB_BUSCLK_CTRL,
+		.mask = 0x3,
+		.shift = 9,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "usb_bus_sel",
+		.ops = &clk_regmap_mux_ops,
+		.parent_data = usb_bus_parent_data,
+		.num_parents = ARRAY_SIZE(usb_bus_parent_data),
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap a1_usb_bus_div = {
+	.data = &(struct clk_regmap_div_data){
+		.offset = USB_BUSCLK_CTRL,
+		.shift = 0,
+		.width = 8,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "usb_bus_div",
+		.ops = &clk_regmap_divider_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&a1_usb_bus_sel.hw
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap a1_usb_bus = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = USB_BUSCLK_CTRL,
+		.bit_idx = 8,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "usb_bus",
+		.ops = &clk_regmap_gate_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&a1_usb_bus_div.hw
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static const struct clk_parent_data sd_emmc_parents[] = {
+	{ .fw_name = "fclk_div2", },
+	{ .fw_name = "fclk_div3", },
+	{ .fw_name = "fclk_div5", },
+	{ .fw_name = "hifi_pll", },
+};
+
+static struct clk_regmap a1_sd_emmc_sel = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = SD_EMMC_CLK_CTRL,
+		.mask = 0x3,
+		.shift = 9,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "sd_emmc_sel",
+		.ops = &clk_regmap_mux_ops,
+		.parent_data = sd_emmc_parents,
+		.num_parents = 4,
+	},
+};
+
+static struct clk_regmap a1_sd_emmc_div = {
+	.data = &(struct clk_regmap_div_data){
+		.offset = SD_EMMC_CLK_CTRL,
+		.shift = 0,
+		.width = 8,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "sd_emmc_div",
+		.ops = &clk_regmap_divider_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&a1_sd_emmc_sel.hw
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap a1_sd_emmc_sel2 = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = SD_EMMC_CLK_CTRL,
+		.mask = 0x1,
+		.shift = 15,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "sd_emmc_sel2",
+		.ops = &clk_regmap_mux_ops,
+		.parent_data = (const struct clk_parent_data []) {
+			{ .hw = &a1_sd_emmc_div.hw },
+			{ .fw_name = "xtal", },
+		},
+		.num_parents = 2,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap a1_sd_emmc = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = SD_EMMC_CLK_CTRL,
+		.bit_idx = 8,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "sd_emmc",
+		.ops = &clk_regmap_gate_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&a1_sd_emmc_sel2.hw
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap a1_psram_sel = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = PSRAM_CLK_CTRL,
+		.mask = 0x3,
+		.shift = 9,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "psram_sel",
+		.ops = &clk_regmap_mux_ops,
+		/* the same parent with sd_emmc */
+		.parent_data = sd_emmc_parents,
+		.num_parents = 4,
+	},
+};
+
+static struct clk_regmap a1_psram_div = {
+	.data = &(struct clk_regmap_div_data){
+		.offset = PSRAM_CLK_CTRL,
+		.shift = 0,
+		.width = 8,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "psram_div",
+		.ops = &clk_regmap_divider_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&a1_psram_sel.hw
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap a1_psram_sel2 = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = PSRAM_CLK_CTRL,
+		.mask = 0x1,
+		.shift = 15,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "psram_sel2",
+		.ops = &clk_regmap_mux_ops,
+		.parent_data = (const struct clk_parent_data []) {
+			{ .hw = &a1_psram_div.hw },
+			{ .fw_name = "xtal", },
+		},
+		.num_parents = 2,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap a1_psram = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = PSRAM_CLK_CTRL,
+		.bit_idx = 8,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "psram",
+		.ops = &clk_regmap_gate_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&a1_psram_sel2.hw
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap a1_dmc_sel = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = DMC_CLK_CTRL,
+		.mask = 0x3,
+		.shift = 9,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "dmc_sel",
+		.ops = &clk_regmap_mux_ops,
+		.parent_data = sd_emmc_parents,
+		.num_parents = 4,
+	},
+};
+
+static struct clk_regmap a1_dmc_div = {
+	.data = &(struct clk_regmap_div_data){
+		.offset = DMC_CLK_CTRL,
+		.shift = 0,
+		.width = 8,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "dmc_div",
+		.ops = &clk_regmap_divider_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&a1_dmc_sel.hw
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap a1_dmc_sel2 = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = DMC_CLK_CTRL,
+		.mask = 0x1,
+		.shift = 15,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "dmc_sel2",
+		.ops = &clk_regmap_mux_ops,
+		.parent_data = (const struct clk_parent_data []) {
+			{ .hw = &a1_dmc_div.hw },
+			{ .fw_name = "xtal", },
+		},
+		.num_parents = 2,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap a1_dmc = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = DMC_CLK_CTRL,
+		.bit_idx = 8,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "dmc",
+		.ops = &clk_regmap_gate_ro_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&a1_dmc_sel2.hw
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap a1_ceca_32k_clkin = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = CECA_CLK_CTRL0,
+		.bit_idx = 31,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "ceca_32k_clkin",
+		.ops = &clk_regmap_gate_ops,
+		.parent_data = &(const struct clk_parent_data) {
+			.fw_name = "xtal",
+		},
+		.num_parents = 1,
+	},
+};
+
+static struct clk_regmap a1_ceca_32k_div = {
+	.data = &(struct meson_clk_dualdiv_data){
+		.n1 = {
+			.reg_off = CECA_CLK_CTRL0,
+			.shift   = 0,
+			.width   = 12,
+		},
+		.n2 = {
+			.reg_off = CECA_CLK_CTRL0,
+			.shift   = 12,
+			.width   = 12,
+		},
+		.m1 = {
+			.reg_off = CECA_CLK_CTRL1,
+			.shift   = 0,
+			.width   = 12,
+		},
+		.m2 = {
+			.reg_off = CECA_CLK_CTRL1,
+			.shift   = 12,
+			.width   = 12,
+		},
+		.dual = {
+			.reg_off = CECA_CLK_CTRL0,
+			.shift   = 28,
+			.width   = 1,
+		},
+		.table = a1_32k_div_table,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "ceca_32k_div",
+		.ops = &meson_clk_dualdiv_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&a1_ceca_32k_clkin.hw
+		},
+		.num_parents = 1,
+	},
+};
+
+static struct clk_regmap a1_ceca_32k_sel_pre = {
+	.data = &(struct clk_regmap_mux_data) {
+		.offset = CECA_CLK_CTRL1,
+		.mask = 0x1,
+		.shift = 24,
+		.flags = CLK_MUX_ROUND_CLOSEST,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "ceca_32k_sel_pre",
+		.ops = &clk_regmap_mux_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&a1_ceca_32k_div.hw,
+			&a1_ceca_32k_clkin.hw,
+		},
+		.num_parents = 2,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap a1_ceca_32k_sel = {
+	.data = &(struct clk_regmap_mux_data) {
+		.offset = CECA_CLK_CTRL1,
+		.mask = 0x1,
+		.shift = 31,
+		.flags = CLK_MUX_ROUND_CLOSEST,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "ceca_32k_sel",
+		.ops = &clk_regmap_mux_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&a1_ceca_32k_sel_pre.hw,
+			&a1_rtc_clk.hw,
+		},
+		.num_parents = 2,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap a1_ceca_32k_clkout = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = CECA_CLK_CTRL0,
+		.bit_idx = 30,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "ceca_32k_clkout",
+		.ops = &clk_regmap_gate_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&a1_ceca_32k_sel.hw
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap a1_cecb_32k_clkin = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = CECB_CLK_CTRL0,
+		.bit_idx = 31,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "cecb_32k_clkin",
+		.ops = &clk_regmap_gate_ops,
+		.parent_data = &(const struct clk_parent_data) {
+			.fw_name = "xtal",
+		},
+		.num_parents = 1,
+	},
+};
+
+static struct clk_regmap a1_cecb_32k_div = {
+	.data = &(struct meson_clk_dualdiv_data){
+		.n1 = {
+			.reg_off = CECB_CLK_CTRL0,
+			.shift   = 0,
+			.width   = 12,
+		},
+		.n2 = {
+			.reg_off = CECB_CLK_CTRL0,
+			.shift   = 12,
+			.width   = 12,
+		},
+		.m1 = {
+			.reg_off = CECB_CLK_CTRL1,
+			.shift   = 0,
+			.width   = 12,
+		},
+		.m2 = {
+			.reg_off = CECB_CLK_CTRL1,
+			.shift   = 12,
+			.width   = 12,
+		},
+		.dual = {
+			.reg_off = CECB_CLK_CTRL0,
+			.shift   = 28,
+			.width   = 1,
+		},
+		.table = a1_32k_div_table,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "cecb_32k_div",
+		.ops = &meson_clk_dualdiv_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&a1_cecb_32k_clkin.hw
+		},
+		.num_parents = 1,
+	},
+};
+
+static struct clk_regmap a1_cecb_32k_sel_pre = {
+	.data = &(struct clk_regmap_mux_data) {
+		.offset = CECB_CLK_CTRL1,
+		.mask = 0x1,
+		.shift = 24,
+		.flags = CLK_MUX_ROUND_CLOSEST,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "cecb_32k_sel_pre",
+		.ops = &clk_regmap_mux_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&a1_cecb_32k_div.hw,
+			&a1_cecb_32k_clkin.hw,
+		},
+		.num_parents = 2,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap a1_cecb_32k_sel = {
+	.data = &(struct clk_regmap_mux_data) {
+		.offset = CECB_CLK_CTRL1,
+		.mask = 0x1,
+		.shift = 31,
+		.flags = CLK_MUX_ROUND_CLOSEST,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "cecb_32k_sel",
+		.ops = &clk_regmap_mux_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&a1_cecb_32k_sel_pre.hw,
+			&a1_rtc_clk.hw,
+		},
+		.num_parents = 2,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap a1_cecb_32k_clkout = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = CECB_CLK_CTRL0,
+		.bit_idx = 30,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "cecb_32k_clkout",
+		.ops = &clk_regmap_gate_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&a1_cecb_32k_sel.hw
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+#define MESON_GATE(_name, _reg, _bit) \
+	MESON_PCLK(_name, _reg, _bit, &a1_sys_clk.hw)
+
+static MESON_GATE(a1_clk_tree,		SYS_CLK_EN0,	0);
+static MESON_GATE(a1_reset_ctrl,	SYS_CLK_EN0,	1);
+static MESON_GATE(a1_analog_ctrl,	SYS_CLK_EN0,	2);
+static MESON_GATE(a1_pwr_ctrl,		SYS_CLK_EN0,	3);
+static MESON_GATE(a1_pad_ctrl,		SYS_CLK_EN0,	4);
+static MESON_GATE(a1_sys_ctrl,		SYS_CLK_EN0,	5);
+static MESON_GATE(a1_temp_sensor,	SYS_CLK_EN0,	6);
+static MESON_GATE(a1_am2axi_dev,	SYS_CLK_EN0,	7);
+static MESON_GATE(a1_spicc_b,		SYS_CLK_EN0,	8);
+static MESON_GATE(a1_spicc_a,		SYS_CLK_EN0,	9);
+static MESON_GATE(a1_clk_msr,		SYS_CLK_EN0,	10);
+static MESON_GATE(a1_audio,		SYS_CLK_EN0,	11);
+static MESON_GATE(a1_jtag_ctrl,		SYS_CLK_EN0,	12);
+static MESON_GATE(a1_saradc,		SYS_CLK_EN0,	13);
+static MESON_GATE(a1_pwm_ef,		SYS_CLK_EN0,	14);
+static MESON_GATE(a1_pwm_cd,		SYS_CLK_EN0,	15);
+static MESON_GATE(a1_pwm_ab,		SYS_CLK_EN0,	16);
+static MESON_GATE(a1_cec,		SYS_CLK_EN0,	17);
+static MESON_GATE(a1_i2c_s,		SYS_CLK_EN0,	18);
+static MESON_GATE(a1_ir_ctrl,		SYS_CLK_EN0,	19);
+static MESON_GATE(a1_i2c_m_d,		SYS_CLK_EN0,	20);
+static MESON_GATE(a1_i2c_m_c,		SYS_CLK_EN0,	21);
+static MESON_GATE(a1_i2c_m_b,		SYS_CLK_EN0,	22);
+static MESON_GATE(a1_i2c_m_a,		SYS_CLK_EN0,	23);
+static MESON_GATE(a1_acodec,		SYS_CLK_EN0,	24);
+static MESON_GATE(a1_otp,		SYS_CLK_EN0,	25);
+static MESON_GATE(a1_sd_emmc_a,		SYS_CLK_EN0,	26);
+static MESON_GATE(a1_usb_phy,		SYS_CLK_EN0,	27);
+static MESON_GATE(a1_usb_ctrl,		SYS_CLK_EN0,	28);
+static MESON_GATE(a1_sys_dspb,		SYS_CLK_EN0,	29);
+static MESON_GATE(a1_sys_dspa,		SYS_CLK_EN0,	30);
+static MESON_GATE(a1_dma,		SYS_CLK_EN0,	31);
+static MESON_GATE(a1_irq_ctrl,		SYS_CLK_EN1,	0);
+static MESON_GATE(a1_nic,		SYS_CLK_EN1,	1);
+static MESON_GATE(a1_gic,		SYS_CLK_EN1,	2);
+static MESON_GATE(a1_uart_c,		SYS_CLK_EN1,	3);
+static MESON_GATE(a1_uart_b,		SYS_CLK_EN1,	4);
+static MESON_GATE(a1_uart_a,		SYS_CLK_EN1,	5);
+static MESON_GATE(a1_sys_psram,		SYS_CLK_EN1,	6);
+static MESON_GATE(a1_rsa,		SYS_CLK_EN1,	8);
+static MESON_GATE(a1_coresight,		SYS_CLK_EN1,	9);
+static MESON_GATE(a1_am2axi_vad,	AXI_CLK_EN,	0);
+static MESON_GATE(a1_audio_vad,		AXI_CLK_EN,	1);
+static MESON_GATE(a1_axi_dmc,		AXI_CLK_EN,	3);
+static MESON_GATE(a1_axi_psram,		AXI_CLK_EN,	4);
+static MESON_GATE(a1_ramb,		AXI_CLK_EN,	5);
+static MESON_GATE(a1_rama,		AXI_CLK_EN,	6);
+static MESON_GATE(a1_axi_spifc,		AXI_CLK_EN,	7);
+static MESON_GATE(a1_axi_nic,		AXI_CLK_EN,	8);
+static MESON_GATE(a1_axi_dma,		AXI_CLK_EN,	9);
+static MESON_GATE(a1_cpu_ctrl,		AXI_CLK_EN,	10);
+static MESON_GATE(a1_rom,		AXI_CLK_EN,	11);
+static MESON_GATE(a1_prod_i2c,		AXI_CLK_EN,	12);
+
+/* Array of all clocks provided by this provider */
+static struct clk_hw_onecell_data a1_periphs_hw_onecell_data = {
+	.hws = {
+		[CLKID_SYS_B_SEL]		= &a1_sys_b_sel.hw,
+		[CLKID_SYS_B_DIV]		= &a1_sys_b_div.hw,
+		[CLKID_SYS_B]			= &a1_sys_b.hw,
+		[CLKID_SYS_A_SEL]		= &a1_sys_a_sel.hw,
+		[CLKID_SYS_A_DIV]		= &a1_sys_a_div.hw,
+		[CLKID_SYS_A]			= &a1_sys_a.hw,
+		[CLKID_SYS_CLK]			= &a1_sys_clk.hw,
+		[CLKID_XTAL_CLKTREE]		= &a1_xtal_clktree.hw,
+		[CLKID_XTAL_FIXPLL]		= &a1_xtal_fixpll.hw,
+		[CLKID_XTAL_USB_PHY]		= &a1_xtal_usb_phy.hw,
+		[CLKID_XTAL_USB_CTRL]		= &a1_xtal_usb_ctrl.hw,
+		[CLKID_XTAL_HIFIPLL]		= &a1_xtal_hifipll.hw,
+		[CLKID_XTAL_SYSPLL]		= &a1_xtal_syspll.hw,
+		[CLKID_XTAL_DDS]		= &a1_xtal_dds.hw,
+		[CLKID_CLKTREE]			= &a1_clk_tree.hw,
+		[CLKID_RESET_CTRL]		= &a1_reset_ctrl.hw,
+		[CLKID_ANALOG_CTRL]		= &a1_analog_ctrl.hw,
+		[CLKID_PWR_CTRL]		= &a1_pwr_ctrl.hw,
+		[CLKID_PAD_CTRL]		= &a1_pad_ctrl.hw,
+		[CLKID_SYS_CTRL]		= &a1_sys_ctrl.hw,
+		[CLKID_TEMP_SENSOR]		= &a1_temp_sensor.hw,
+		[CLKID_AM2AXI_DIV]		= &a1_am2axi_dev.hw,
+		[CLKID_SPICC_B]			= &a1_spicc_b.hw,
+		[CLKID_SPICC_A]			= &a1_spicc_a.hw,
+		[CLKID_CLK_MSR]			= &a1_clk_msr.hw,
+		[CLKID_AUDIO]			= &a1_audio.hw,
+		[CLKID_JTAG_CTRL]		= &a1_jtag_ctrl.hw,
+		[CLKID_SARADC]			= &a1_saradc.hw,
+		[CLKID_PWM_EF]			= &a1_pwm_ef.hw,
+		[CLKID_PWM_CD]			= &a1_pwm_cd.hw,
+		[CLKID_PWM_AB]			= &a1_pwm_ab.hw,
+		[CLKID_CEC]			= &a1_cec.hw,
+		[CLKID_I2C_S]			= &a1_i2c_s.hw,
+		[CLKID_IR_CTRL]			= &a1_ir_ctrl.hw,
+		[CLKID_I2C_M_D]			= &a1_i2c_m_d.hw,
+		[CLKID_I2C_M_C]			= &a1_i2c_m_c.hw,
+		[CLKID_I2C_M_B]			= &a1_i2c_m_b.hw,
+		[CLKID_I2C_M_A]			= &a1_i2c_m_a.hw,
+		[CLKID_ACODEC]			= &a1_acodec.hw,
+		[CLKID_OTP]			= &a1_otp.hw,
+		[CLKID_SD_EMMC_A]		= &a1_sd_emmc_a.hw,
+		[CLKID_USB_PHY]			= &a1_usb_phy.hw,
+		[CLKID_USB_CTRL]		= &a1_usb_ctrl.hw,
+		[CLKID_SYS_DSPB]		= &a1_sys_dspb.hw,
+		[CLKID_SYS_DSPA]		= &a1_sys_dspa.hw,
+		[CLKID_DMA]			= &a1_dma.hw,
+		[CLKID_IRQ_CTRL]		= &a1_irq_ctrl.hw,
+		[CLKID_NIC]			= &a1_nic.hw,
+		[CLKID_GIC]			= &a1_gic.hw,
+		[CLKID_UART_C]			= &a1_uart_c.hw,
+		[CLKID_UART_B]			= &a1_uart_b.hw,
+		[CLKID_UART_A]			= &a1_uart_a.hw,
+		[CLKID_SYS_PSRAM]		= &a1_sys_psram.hw,
+		[CLKID_RSA]			= &a1_rsa.hw,
+		[CLKID_CORESIGHT]		= &a1_coresight.hw,
+		[CLKID_AM2AXI_VAD]		= &a1_am2axi_vad.hw,
+		[CLKID_AUDIO_VAD]		= &a1_audio_vad.hw,
+		[CLKID_AXI_DMC]			= &a1_axi_dmc.hw,
+		[CLKID_AXI_PSRAM]		= &a1_axi_psram.hw,
+		[CLKID_RAMB]			= &a1_ramb.hw,
+		[CLKID_RAMA]			= &a1_rama.hw,
+		[CLKID_AXI_SPIFC]		= &a1_axi_spifc.hw,
+		[CLKID_AXI_NIC]			= &a1_axi_nic.hw,
+		[CLKID_AXI_DMA]			= &a1_axi_dma.hw,
+		[CLKID_CPU_CTRL]		= &a1_cpu_ctrl.hw,
+		[CLKID_ROM]			= &a1_rom.hw,
+		[CLKID_PROC_I2C]		= &a1_prod_i2c.hw,
+		[CLKID_DSPA_A_SEL]		= &a1_dspa_a_sel.hw,
+		[CLKID_DSPA_A_DIV]		= &a1_dspa_a_div.hw,
+		[CLKID_DSPA_A]			= &a1_dspa_a.hw,
+		[CLKID_DSPA_B_SEL]		= &a1_dspa_b_sel.hw,
+		[CLKID_DSPA_B_DIV]		= &a1_dspa_b_div.hw,
+		[CLKID_DSPA_B]			= &a1_dspa_b.hw,
+		[CLKID_DSPA_SEL]		= &a1_dspa_sel.hw,
+		[CLKID_DSPB_A_SEL]		= &a1_dspb_a_sel.hw,
+		[CLKID_DSPB_A_DIV]		= &a1_dspb_a_div.hw,
+		[CLKID_DSPB_A]			= &a1_dspb_a.hw,
+		[CLKID_DSPB_B_SEL]		= &a1_dspb_b_sel.hw,
+		[CLKID_DSPB_B_DIV]		= &a1_dspb_b_div.hw,
+		[CLKID_DSPB_B]			= &a1_dspb_b.hw,
+		[CLKID_DSPB_SEL]		= &a1_dspb_sel.hw,
+		[CLKID_DSPA_EN]			= &a1_dspa_en.hw,
+		[CLKID_DSPA_EN_NIC]		= &a1_dspa_en_nic.hw,
+		[CLKID_DSPB_EN]			= &a1_dspb_en.hw,
+		[CLKID_DSPB_EN_NIC]		= &a1_dspb_en_nic.hw,
+		[CLKID_24M]			= &a1_24m.hw,
+		[CLKID_24M_DIV2]		= &a1_24m_div2.hw,
+		[CLKID_12M]			= &a1_12m.hw,
+		[CLKID_DIV2_PRE]		= &a1_fclk_div2_divn_pre.hw,
+		[CLKID_FCLK_DIV2_DIVN]		= &a1_fclk_div2_divn.hw,
+		[CLKID_GEN_SEL]			= &a1_gen_sel.hw,
+		[CLKID_GEN_DIV]			= &a1_gen_div.hw,
+		[CLKID_GEN]			= &a1_gen.hw,
+		[CLKID_SARADC_SEL]		= &a1_saradc_sel.hw,
+		[CLKID_SARADC_DIV]		= &a1_saradc_div.hw,
+		[CLKID_SARADC_CLK]		= &a1_saradc_clk.hw,
+		[CLKID_PWM_A_SEL]		= &a1_pwm_a_sel.hw,
+		[CLKID_PWM_A_DIV]		= &a1_pwm_a_div.hw,
+		[CLKID_PWM_A]			= &a1_pwm_a.hw,
+		[CLKID_PWM_B_SEL]		= &a1_pwm_b_sel.hw,
+		[CLKID_PWM_B_DIV]		= &a1_pwm_b_div.hw,
+		[CLKID_PWM_B]			= &a1_pwm_b.hw,
+		[CLKID_PWM_C_SEL]		= &a1_pwm_c_sel.hw,
+		[CLKID_PWM_C_DIV]		= &a1_pwm_c_div.hw,
+		[CLKID_PWM_C]			= &a1_pwm_c.hw,
+		[CLKID_PWM_D_SEL]		= &a1_pwm_d_sel.hw,
+		[CLKID_PWM_D_DIV]		= &a1_pwm_d_div.hw,
+		[CLKID_PWM_D]			= &a1_pwm_d.hw,
+		[CLKID_PWM_E_SEL]		= &a1_pwm_e_sel.hw,
+		[CLKID_PWM_E_DIV]		= &a1_pwm_e_div.hw,
+		[CLKID_PWM_E]			= &a1_pwm_e.hw,
+		[CLKID_PWM_F_SEL]		= &a1_pwm_f_sel.hw,
+		[CLKID_PWM_F_DIV]		= &a1_pwm_f_div.hw,
+		[CLKID_PWM_F]			= &a1_pwm_f.hw,
+		[CLKID_SPICC_SEL]		= &a1_spicc_sel.hw,
+		[CLKID_SPICC_DIV]		= &a1_spicc_div.hw,
+		[CLKID_SPICC_SEL2]		= &a1_spicc_sel2.hw,
+		[CLKID_SPICC]			= &a1_spicc.hw,
+		[CLKID_TS_DIV]			= &a1_ts_div.hw,
+		[CLKID_TS]			= &a1_ts.hw,
+		[CLKID_SPIFC_SEL]		= &a1_spifc_sel.hw,
+		[CLKID_SPIFC_DIV]		= &a1_spifc_div.hw,
+		[CLKID_SPIFC_SEL2]		= &a1_spifc_sel2.hw,
+		[CLKID_SPIFC]			= &a1_spifc.hw,
+		[CLKID_USB_BUS_SEL]		= &a1_usb_bus_sel.hw,
+		[CLKID_USB_BUS_DIV]		= &a1_usb_bus_div.hw,
+		[CLKID_USB_BUS]			= &a1_usb_bus.hw,
+		[CLKID_SD_EMMC_SEL]		= &a1_sd_emmc_sel.hw,
+		[CLKID_SD_EMMC_DIV]		= &a1_sd_emmc_div.hw,
+		[CLKID_SD_EMMC_SEL2]		= &a1_sd_emmc_sel2.hw,
+		[CLKID_SD_EMMC]			= &a1_sd_emmc.hw,
+		[CLKID_PSRAM_SEL]		= &a1_psram_sel.hw,
+		[CLKID_PSRAM_DIV]		= &a1_psram_div.hw,
+		[CLKID_PSRAM_SEL2]		= &a1_psram_sel2.hw,
+		[CLKID_PSRAM]			= &a1_psram.hw,
+		[CLKID_DMC_SEL]			= &a1_dmc_sel.hw,
+		[CLKID_DMC_DIV]			= &a1_dmc_div.hw,
+		[CLKID_DMC_SEL2]		= &a1_dmc_sel2.hw,
+		[CLKID_DMC]			= &a1_dmc.hw,
+		[CLKID_RTC_32K_CLKIN]		= &a1_rtc_32k_clkin.hw,
+		[CLKID_RTC_32K_DIV]		= &a1_rtc_32k_div.hw,
+		[CLKID_RTC_32K_XTAL]		= &a1_rtc_32k_xtal.hw,
+		[CLKID_RTC_32K_SEL]		= &a1_rtc_32k_sel.hw,
+		[CLKID_RTC_CLK]			= &a1_rtc_clk.hw,
+		[CLKID_CECA_32K_CLKIN]		= &a1_ceca_32k_clkin.hw,
+		[CLKID_CECA_32K_DIV]		= &a1_ceca_32k_div.hw,
+		[CLKID_CECA_32K_SEL_PRE]	= &a1_ceca_32k_sel_pre.hw,
+		[CLKID_CECA_32K_SEL]		= &a1_ceca_32k_sel.hw,
+		[CLKID_CECA_32K]		= &a1_ceca_32k_clkout.hw,
+		[CLKID_CECB_32K_CLKIN]		= &a1_cecb_32k_clkin.hw,
+		[CLKID_CECB_32K_DIV]		= &a1_cecb_32k_div.hw,
+		[CLKID_CECB_32K_SEL_PRE]	= &a1_cecb_32k_sel_pre.hw,
+		[CLKID_CECB_32K_SEL]		= &a1_cecb_32k_sel.hw,
+		[CLKID_CECB_32K]		= &a1_cecb_32k_clkout.hw,
+		[NR_CLKS]			= NULL,
+	},
+	.num = NR_CLKS,
+};
+
+/* Convenience table to populate regmap in .probe */
+static struct clk_regmap *const a1_periphs_regmaps[] = {
+	&a1_xtal_clktree,
+	&a1_xtal_fixpll,
+	&a1_xtal_usb_phy,
+	&a1_xtal_usb_ctrl,
+	&a1_xtal_hifipll,
+	&a1_xtal_syspll,
+	&a1_xtal_dds,
+	&a1_clk_tree,
+	&a1_reset_ctrl,
+	&a1_analog_ctrl,
+	&a1_pwr_ctrl,
+	&a1_sys_ctrl,
+	&a1_temp_sensor,
+	&a1_am2axi_dev,
+	&a1_spicc_b,
+	&a1_spicc_a,
+	&a1_clk_msr,
+	&a1_audio,
+	&a1_jtag_ctrl,
+	&a1_saradc,
+	&a1_pwm_ef,
+	&a1_pwm_cd,
+	&a1_pwm_ab,
+	&a1_cec,
+	&a1_i2c_s,
+	&a1_ir_ctrl,
+	&a1_i2c_m_d,
+	&a1_i2c_m_c,
+	&a1_i2c_m_b,
+	&a1_i2c_m_a,
+	&a1_acodec,
+	&a1_otp,
+	&a1_sd_emmc_a,
+	&a1_usb_phy,
+	&a1_usb_ctrl,
+	&a1_sys_dspb,
+	&a1_sys_dspa,
+	&a1_dma,
+	&a1_irq_ctrl,
+	&a1_nic,
+	&a1_gic,
+	&a1_uart_c,
+	&a1_uart_b,
+	&a1_uart_a,
+	&a1_sys_psram,
+	&a1_rsa,
+	&a1_coresight,
+	&a1_am2axi_vad,
+	&a1_audio_vad,
+	&a1_axi_dmc,
+	&a1_axi_psram,
+	&a1_ramb,
+	&a1_rama,
+	&a1_axi_spifc,
+	&a1_axi_nic,
+	&a1_axi_dma,
+	&a1_cpu_ctrl,
+	&a1_rom,
+	&a1_prod_i2c,
+	&a1_dspa_a_sel,
+	&a1_dspa_a_div,
+	&a1_dspa_a,
+	&a1_dspa_b_sel,
+	&a1_dspa_b_div,
+	&a1_dspa_b,
+	&a1_dspa_sel,
+	&a1_dspb_a_sel,
+	&a1_dspb_a_div,
+	&a1_dspb_a,
+	&a1_dspb_b_sel,
+	&a1_dspb_b_div,
+	&a1_dspb_b,
+	&a1_dspb_sel,
+	&a1_dspa_en,
+	&a1_dspa_en_nic,
+	&a1_dspb_en,
+	&a1_dspb_en_nic,
+	&a1_24m,
+	&a1_12m,
+	&a1_fclk_div2_divn_pre,
+	&a1_fclk_div2_divn,
+	&a1_gen_sel,
+	&a1_gen_div,
+	&a1_gen,
+	&a1_saradc_sel,
+	&a1_saradc_div,
+	&a1_saradc_clk,
+	&a1_pwm_a_sel,
+	&a1_pwm_a_div,
+	&a1_pwm_a,
+	&a1_pwm_b_sel,
+	&a1_pwm_b_div,
+	&a1_pwm_b,
+	&a1_pwm_c_sel,
+	&a1_pwm_c_div,
+	&a1_pwm_c,
+	&a1_pwm_d_sel,
+	&a1_pwm_d_div,
+	&a1_pwm_d,
+	&a1_pwm_e_sel,
+	&a1_pwm_e_div,
+	&a1_pwm_e,
+	&a1_pwm_f_sel,
+	&a1_pwm_f_div,
+	&a1_pwm_f,
+	&a1_spicc_sel,
+	&a1_spicc_div,
+	&a1_spicc_sel2,
+	&a1_spicc,
+	&a1_ts_div,
+	&a1_ts,
+	&a1_spifc_sel,
+	&a1_spifc_div,
+	&a1_spifc_sel2,
+	&a1_spifc,
+	&a1_usb_bus_sel,
+	&a1_usb_bus_div,
+	&a1_usb_bus,
+	&a1_sd_emmc_sel,
+	&a1_sd_emmc_div,
+	&a1_sd_emmc_sel2,
+	&a1_sd_emmc,
+	&a1_psram_sel,
+	&a1_psram_div,
+	&a1_psram_sel2,
+	&a1_psram,
+	&a1_dmc_sel,
+	&a1_dmc_div,
+	&a1_dmc_sel2,
+	&a1_dmc,
+	&a1_sys_b_sel,
+	&a1_sys_b_div,
+	&a1_sys_b,
+	&a1_sys_a_sel,
+	&a1_sys_a_div,
+	&a1_sys_a,
+	&a1_sys_clk,
+	&a1_rtc_32k_clkin,
+	&a1_rtc_32k_div,
+	&a1_rtc_32k_xtal,
+	&a1_rtc_32k_sel,
+	&a1_rtc_clk,
+	&a1_ceca_32k_clkin,
+	&a1_ceca_32k_div,
+	&a1_ceca_32k_sel_pre,
+	&a1_ceca_32k_sel,
+	&a1_ceca_32k_clkout,
+	&a1_cecb_32k_clkin,
+	&a1_cecb_32k_div,
+	&a1_cecb_32k_sel_pre,
+	&a1_cecb_32k_sel,
+	&a1_cecb_32k_clkout,
+};
+
+static struct regmap_config clkc_regmap_config = {
+	.reg_bits       = 32,
+	.val_bits       = 32,
+	.reg_stride     = 4,
+};
+
+static int meson_a1_periphs_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct resource *res;
+	void __iomem *base;
+	struct regmap *map;
+	int ret, i;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+
+	base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	map = devm_regmap_init_mmio(dev, base, &clkc_regmap_config);
+	if (IS_ERR(map))
+		return PTR_ERR(map);
+
+	/* Populate regmap for the regmap backed clocks */
+	for (i = 0; i < ARRAY_SIZE(a1_periphs_regmaps); i++)
+		a1_periphs_regmaps[i]->map = map;
+
+	for (i = 0; i < a1_periphs_hw_onecell_data.num; i++) {
+		/* array might be sparse */
+		if (!a1_periphs_hw_onecell_data.hws[i])
+			continue;
+
+		ret = devm_clk_hw_register(dev,
+					   a1_periphs_hw_onecell_data.hws[i]);
+		if (ret) {
+			dev_err(dev, "Clock registration failed\n");
+			return ret;
+		}
+	}
+
+	return devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get,
+					   &a1_periphs_hw_onecell_data);
+}
+
+static const struct of_device_id clkc_match_table[] = {
+	{ .compatible = "amlogic,a1-periphs-clkc", },
+	{}
+};
+
+static struct platform_driver a1_periphs_driver = {
+	.probe		= meson_a1_periphs_probe,
+	.driver		= {
+		.name	= "a1-periphs-clkc",
+		.of_match_table = clkc_match_table,
+	},
+};
+
+builtin_platform_driver(a1_periphs_driver);
diff --git a/drivers/clk/meson/a1.h b/drivers/clk/meson/a1.h
new file mode 100644
index 000000000000..1ae5e04848d6
--- /dev/null
+++ b/drivers/clk/meson/a1.h
@@ -0,0 +1,120 @@
+/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
+/*
+ * Copyright (c) 2019 Amlogic, Inc. All rights reserved.
+ */
+
+#ifndef __A1_H
+#define __A1_H
+
+/* peripheral clock controller register offset */
+#define SYS_OSCIN_CTRL			0x0
+#define RTC_BY_OSCIN_CTRL0		0x4
+#define RTC_BY_OSCIN_CTRL1		0x8
+#define RTC_CTRL			0xc
+#define SYS_CLK_CTRL0			0x10
+#define AXI_CLK_CTRL0			0x14
+#define SYS_CLK_EN0			0x1c
+#define SYS_CLK_EN1			0x20
+#define AXI_CLK_EN			0x24
+#define DSPA_CLK_EN			0x28
+#define DSPB_CLK_EN			0x2c
+#define DSPA_CLK_CTRL0			0x30
+#define DSPB_CLK_CTRL0			0x34
+#define CLK12_24_CTRL			0x38
+#define GEN_CLK_CTRL			0x3c
+#define TIMESTAMP_CTRL0			0x40
+#define TIMESTAMP_CTRL1			0x44
+#define TIMESTAMP_CTRL2			0x48
+#define TIMESTAMP_VAL0			0x4c
+#define TIMESTAMP_VAL1			0x50
+#define TIMEBASE_CTRL0			0x54
+#define TIMEBASE_CTRL1			0x58
+#define SAR_ADC_CLK_CTRL		0xc0
+#define PWM_CLK_AB_CTRL			0xc4
+#define PWM_CLK_CD_CTRL			0xc8
+#define PWM_CLK_EF_CTRL			0xcc
+#define SPICC_CLK_CTRL			0xd0
+#define TS_CLK_CTRL			0xd4
+#define SPIFC_CLK_CTRL			0xd8
+#define USB_BUSCLK_CTRL			0xdc
+#define SD_EMMC_CLK_CTRL		0xe0
+#define CECA_CLK_CTRL0			0xe4
+#define CECA_CLK_CTRL1			0xe8
+#define CECB_CLK_CTRL0			0xec
+#define CECB_CLK_CTRL1			0xf0
+#define PSRAM_CLK_CTRL			0xf4
+#define DMC_CLK_CTRL			0xf8
+#define FCLK_DIV1_SEL			0xfc
+#define TST_CTRL			0x100
+
+#define CLKID_XTAL_CLKTREE		0
+#define CLKID_SYS_A_SEL			89
+#define CLKID_SYS_A_DIV			90
+#define CLKID_SYS_A			91
+#define CLKID_SYS_B_SEL			92
+#define CLKID_SYS_B_DIV			93
+#define CLKID_SYS_B			94
+#define CLKID_DSPA_A_SEL		95
+#define CLKID_DSPA_A_DIV		96
+#define CLKID_DSPA_A			97
+#define CLKID_DSPA_B_SEL		98
+#define CLKID_DSPA_B_DIV		99
+#define CLKID_DSPA_B			100
+#define CLKID_DSPB_A_SEL		101
+#define CLKID_DSPB_A_DIV		102
+#define CLKID_DSPB_A			103
+#define CLKID_DSPB_B_SEL		104
+#define CLKID_DSPB_B_DIV		105
+#define CLKID_DSPB_B			106
+#define CLKID_RTC_32K_CLKIN		107
+#define CLKID_RTC_32K_DIV		108
+#define CLKID_RTC_32K_XTAL		109
+#define CLKID_RTC_32K_SEL		110
+#define CLKID_CECB_32K_CLKIN		111
+#define CLKID_CECB_32K_DIV		112
+#define CLKID_CECB_32K_SEL_PRE		113
+#define CLKID_CECB_32K_SEL		114
+#define CLKID_CECA_32K_CLKIN		115
+#define CLKID_CECA_32K_DIV		116
+#define CLKID_CECA_32K_SEL_PRE		117
+#define CLKID_CECA_32K_SEL		118
+#define CLKID_DIV2_PRE			119
+#define CLKID_24M_DIV2			120
+#define CLKID_GEN_SEL			121
+#define CLKID_GEN_DIV			122
+#define CLKID_SARADC_DIV		123
+#define CLKID_PWM_A_SEL			124
+#define CLKID_PWM_A_DIV			125
+#define CLKID_PWM_B_SEL			126
+#define CLKID_PWM_B_DIV			127
+#define CLKID_PWM_C_SEL			128
+#define CLKID_PWM_C_DIV			129
+#define CLKID_PWM_D_SEL			130
+#define CLKID_PWM_D_DIV			131
+#define CLKID_PWM_E_SEL			132
+#define CLKID_PWM_E_DIV			133
+#define CLKID_PWM_F_SEL			134
+#define CLKID_PWM_F_DIV			135
+#define CLKID_SPICC_SEL			136
+#define CLKID_SPICC_DIV			137
+#define CLKID_SPICC_SEL2		138
+#define CLKID_TS_DIV			139
+#define CLKID_SPIFC_SEL			140
+#define CLKID_SPIFC_DIV			141
+#define CLKID_SPIFC_SEL2		142
+#define CLKID_USB_BUS_SEL		143
+#define CLKID_USB_BUS_DIV		144
+#define CLKID_SD_EMMC_SEL		145
+#define CLKID_SD_EMMC_DIV		146
+#define CLKID_SD_EMMC_SEL2		147
+#define CLKID_PSRAM_SEL			148
+#define CLKID_PSRAM_DIV			149
+#define CLKID_PSRAM_SEL2		150
+#define CLKID_DMC_SEL			151
+#define CLKID_DMC_DIV			152
+#define CLKID_DMC_SEL2			153
+#define NR_CLKS				154
+
+#include <dt-bindings/clock/a1-clkc.h>
+
+#endif /* __A1_H */
-- 
2.36.0

