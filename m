Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63CAF6B21B2
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 11:41:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbjCIKlW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 05:41:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbjCIKkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 05:40:43 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC6C0E8CE0
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 02:39:31 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8A26A66018CA;
        Thu,  9 Mar 2023 10:39:17 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1678358358;
        bh=rmPFnrdCU4JEVWqaCcnkC6D30+fChM2cM1ghnBmuP2A=;
        h=From:To:Cc:Subject:Date:From;
        b=QsYcvF7XkyRIee456DfEuPcGOz8ItytO2MuVkBMRELce3FONeC8wm0M0qTasZs5WG
         M31lqJHEYbPtkp7Hh3lrNhymq0SCR7fRcyUZ754Zq6DlI778u7UPGZwEOrs2hgkVTC
         G3XH9U+kfF9dfvAaC3S1zmX2l9z9ItsihONk1gmJd7J7Skc8xxyc3NuEMwdHTm3FI6
         CF3C4e27RpiMLLEFN74xMq2mTy5Dn9RkjpiHisjGzHw8+0VN+xc9cMKQR1x9bQlLOC
         T1UVxDCMfUSBpn6qw2pp6zcz+CJs/MltT8hObFM0KTmt/K0bm/QXqyhHdLTIrR0vBZ
         2IRsIUPCeZDdw==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     daniel.lezcano@linaro.org
Cc:     tglx@linutronix.de, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com,
        Walter.Chang@mediatek.com
Subject: [PATCH] clocksource/drivers/timer-mediatek: Split out CPUXGPT timers
Date:   Thu,  9 Mar 2023 11:39:13 +0100
Message-Id: <20230309103913.116775-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.39.2
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

On MediaTek platforms, CPUXGPT is the source for the AArch64 System
Timer, read through CNTVCT_EL0.

The handling for starting this timer ASAP was introduced in commit
327e93cf9a59 ("clocksource/drivers/timer-mediatek: Implement CPUXGPT timers")
which description also contains an important full explanation of the
reasons why this driver is necessary and cannot be a module.

In preparation for an eventual conversion of timer-mediatek to a
platform_driver that would be possibly built as a module, split out
the CPUXGPT timers driver to a new timer-mediatek-cpux.c driver.

This commit brings no functional changes.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---

Note: I've added a mention to the commit that is introducing CPUXGPT
because it contains a broad explanation about why this is needed and
why it is mandatory to have it as built-in and initialized as early
as possible. This is mostly because this question was asked multiple
times and I've been pointing people to that commit to explain it all.

This commit was made because of a discussion about the impossibility
to convert timer-mediatek to a module: even though that's definitely
not easy at all, this will make sure that whatever cannot (ever) be
built as module goes out of that driver.

I tried to tackle a timer-mediatek conversion to platform_driver as
well, but I don't currently have the required bandwidth to do so:
as a first step I moved that, so I'm pushing this commit as to try
to reduce duplicated work.

This commit was tested on MT6795 Sony Xperia M5.

 drivers/clocksource/Kconfig               |   9 ++
 drivers/clocksource/Makefile              |   1 +
 drivers/clocksource/timer-mediatek-cpux.c | 140 ++++++++++++++++++++++
 drivers/clocksource/timer-mediatek.c      | 114 ------------------
 4 files changed, 150 insertions(+), 114 deletions(-)
 create mode 100644 drivers/clocksource/timer-mediatek-cpux.c

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 5fc8f0e7fb38..526382dc7482 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -479,6 +479,15 @@ config MTK_TIMER
 	help
 	  Support for Mediatek timer driver.
 
+config MTK_CPUX_TIMER
+	bool "MediaTek CPUX timer driver" if COMPILE_TEST
+	depends on HAS_IOMEM
+	default ARCH_MEDIATEK
+	select TIMER_OF
+	select CLKSRC_MMIO
+	help
+	  Support for MediaTek CPUXGPT timer driver.
+
 config SPRD_TIMER
 	bool "Spreadtrum timer driver" if EXPERT
 	depends on HAS_IOMEM
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index 64ab547de97b..f12d3987a960 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -51,6 +51,7 @@ obj-$(CONFIG_FSL_FTM_TIMER)	+= timer-fsl-ftm.o
 obj-$(CONFIG_VF_PIT_TIMER)	+= timer-vf-pit.o
 obj-$(CONFIG_CLKSRC_QCOM)	+= timer-qcom.o
 obj-$(CONFIG_MTK_TIMER)		+= timer-mediatek.o
+obj-$(CONFIG_MTK_CPUX_TIMER)	+= timer-mediatek-cpux.o
 obj-$(CONFIG_CLKSRC_PISTACHIO)	+= timer-pistachio.o
 obj-$(CONFIG_CLKSRC_TI_32K)	+= timer-ti-32k.o
 obj-$(CONFIG_OXNAS_RPS_TIMER)	+= timer-oxnas-rps.o
diff --git a/drivers/clocksource/timer-mediatek-cpux.c b/drivers/clocksource/timer-mediatek-cpux.c
new file mode 100644
index 000000000000..a8e3df4c09fd
--- /dev/null
+++ b/drivers/clocksource/timer-mediatek-cpux.c
@@ -0,0 +1,140 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * MediaTek SoCs CPUX General Purpose Timer handling
+ *
+ * Based on timer-mediatek.c:
+ * Copyright (C) 2014 Matthias Brugger <matthias.bgg@gmail.com>
+ *
+ * Copyright (C) 2022 Collabora Ltd.
+ *                    AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
+ */
+
+#define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
+
+#include <linux/clockchips.h>
+#include <linux/clocksource.h>
+#include <linux/interrupt.h>
+#include <linux/irqreturn.h>
+#include <linux/sched_clock.h>
+#include <linux/slab.h>
+#include "timer-of.h"
+
+#define TIMER_SYNC_TICKS        3
+
+/* cpux mcusys wrapper */
+#define CPUX_CON_REG		0x0
+#define CPUX_IDX_REG		0x4
+
+/* cpux */
+#define CPUX_IDX_GLOBAL_CTRL	0x0
+ #define CPUX_ENABLE		BIT(0)
+ #define CPUX_CLK_DIV_MASK	GENMASK(10, 8)
+ #define CPUX_CLK_DIV1		BIT(8)
+ #define CPUX_CLK_DIV2		BIT(9)
+ #define CPUX_CLK_DIV4		BIT(10)
+#define CPUX_IDX_GLOBAL_IRQ	0x30
+
+static u32 mtk_cpux_readl(u32 reg_idx, struct timer_of *to)
+{
+	writel(reg_idx, timer_of_base(to) + CPUX_IDX_REG);
+	return readl(timer_of_base(to) + CPUX_CON_REG);
+}
+
+static void mtk_cpux_writel(u32 val, u32 reg_idx, struct timer_of *to)
+{
+	writel(reg_idx, timer_of_base(to) + CPUX_IDX_REG);
+	writel(val, timer_of_base(to) + CPUX_CON_REG);
+}
+
+static void mtk_cpux_set_irq(struct timer_of *to, bool enable)
+{
+	const unsigned long *irq_mask = cpumask_bits(cpu_possible_mask);
+	u32 val;
+
+	val = mtk_cpux_readl(CPUX_IDX_GLOBAL_IRQ, to);
+
+	if (enable)
+		val |= *irq_mask;
+	else
+		val &= ~(*irq_mask);
+
+	mtk_cpux_writel(val, CPUX_IDX_GLOBAL_IRQ, to);
+}
+
+static int mtk_cpux_clkevt_shutdown(struct clock_event_device *clkevt)
+{
+	/* Clear any irq */
+	mtk_cpux_set_irq(to_timer_of(clkevt), false);
+
+	/*
+	 * Disabling CPUXGPT timer will crash the platform, especially
+	 * if Trusted Firmware is using it (usually, for sleep states),
+	 * so we only mask the IRQ and call it a day.
+	 */
+	return 0;
+}
+
+static int mtk_cpux_clkevt_resume(struct clock_event_device *clkevt)
+{
+	mtk_cpux_set_irq(to_timer_of(clkevt), true);
+	return 0;
+}
+
+static struct timer_of to = {
+	/*
+	 * There are per-cpu interrupts for the CPUX General Purpose Timer
+	 * but since this timer feeds the AArch64 System Timer we can rely
+	 * on the CPU timer PPIs as well, so we don't declare TIMER_OF_IRQ.
+	 */
+	.flags = TIMER_OF_BASE | TIMER_OF_CLOCK,
+
+	.clkevt = {
+		.name = "mtk-cpuxgpt",
+		.cpumask = cpu_possible_mask,
+		.rating = 10,
+		.set_state_shutdown = mtk_cpux_clkevt_shutdown,
+		.tick_resume = mtk_cpux_clkevt_resume,
+	},
+};
+
+static int __init mtk_cpux_init(struct device_node *node)
+{
+	u32 freq, val;
+	int ret;
+
+	/* If this fails, bad things are about to happen... */
+	ret = timer_of_init(node, &to);
+	if (ret) {
+		WARN(1, "Cannot start CPUX timers.\n");
+		return ret;
+	}
+
+	/*
+	 * Check if we're given a clock with the right frequency for this
+	 * timer, otherwise warn but keep going with the setup anyway, as
+	 * that makes it possible to still boot the kernel, even though
+	 * it may not work correctly (random lockups, etc).
+	 * The reason behind this is that having an early UART may not be
+	 * possible for everyone and this gives a chance to retrieve kmsg
+	 * for eventual debugging even on consumer devices.
+	 */
+	freq = timer_of_rate(&to);
+	if (freq > 13000000)
+		WARN(1, "Requested unsupported timer frequency %u\n", freq);
+
+	/* Clock input is 26MHz, set DIV2 to achieve 13MHz clock */
+	val = mtk_cpux_readl(CPUX_IDX_GLOBAL_CTRL, &to);
+	val &= ~CPUX_CLK_DIV_MASK;
+	val |= CPUX_CLK_DIV2;
+	mtk_cpux_writel(val, CPUX_IDX_GLOBAL_CTRL, &to);
+
+	/* Enable all CPUXGPT timers */
+	val = mtk_cpux_readl(CPUX_IDX_GLOBAL_CTRL, &to);
+	mtk_cpux_writel(val | CPUX_ENABLE, CPUX_IDX_GLOBAL_CTRL, &to);
+
+	clockevents_config_and_register(&to.clkevt, timer_of_rate(&to),
+					TIMER_SYNC_TICKS, 0xffffffff);
+
+	return 0;
+}
+TIMER_OF_DECLARE(mtk_mt6795, "mediatek,mt6795-systimer", mtk_cpux_init);
diff --git a/drivers/clocksource/timer-mediatek.c b/drivers/clocksource/timer-mediatek.c
index d5b29fd03ca2..7bcb4a3f26fb 100644
--- a/drivers/clocksource/timer-mediatek.c
+++ b/drivers/clocksource/timer-mediatek.c
@@ -22,19 +22,6 @@
 
 #define TIMER_SYNC_TICKS        (3)
 
-/* cpux mcusys wrapper */
-#define CPUX_CON_REG		0x0
-#define CPUX_IDX_REG		0x4
-
-/* cpux */
-#define CPUX_IDX_GLOBAL_CTRL	0x0
- #define CPUX_ENABLE		BIT(0)
- #define CPUX_CLK_DIV_MASK	GENMASK(10, 8)
- #define CPUX_CLK_DIV1		BIT(8)
- #define CPUX_CLK_DIV2		BIT(9)
- #define CPUX_CLK_DIV4		BIT(10)
-#define CPUX_IDX_GLOBAL_IRQ	0x30
-
 /* gpt */
 #define GPT_IRQ_EN_REG          0x00
 #define GPT_IRQ_ENABLE(val)     BIT((val) - 1)
@@ -85,52 +72,6 @@
 
 static void __iomem *gpt_sched_reg __read_mostly;
 
-static u32 mtk_cpux_readl(u32 reg_idx, struct timer_of *to)
-{
-	writel(reg_idx, timer_of_base(to) + CPUX_IDX_REG);
-	return readl(timer_of_base(to) + CPUX_CON_REG);
-}
-
-static void mtk_cpux_writel(u32 val, u32 reg_idx, struct timer_of *to)
-{
-	writel(reg_idx, timer_of_base(to) + CPUX_IDX_REG);
-	writel(val, timer_of_base(to) + CPUX_CON_REG);
-}
-
-static void mtk_cpux_set_irq(struct timer_of *to, bool enable)
-{
-	const unsigned long *irq_mask = cpumask_bits(cpu_possible_mask);
-	u32 val;
-
-	val = mtk_cpux_readl(CPUX_IDX_GLOBAL_IRQ, to);
-
-	if (enable)
-		val |= *irq_mask;
-	else
-		val &= ~(*irq_mask);
-
-	mtk_cpux_writel(val, CPUX_IDX_GLOBAL_IRQ, to);
-}
-
-static int mtk_cpux_clkevt_shutdown(struct clock_event_device *clkevt)
-{
-	/* Clear any irq */
-	mtk_cpux_set_irq(to_timer_of(clkevt), false);
-
-	/*
-	 * Disabling CPUXGPT timer will crash the platform, especially
-	 * if Trusted Firmware is using it (usually, for sleep states),
-	 * so we only mask the IRQ and call it a day.
-	 */
-	return 0;
-}
-
-static int mtk_cpux_clkevt_resume(struct clock_event_device *clkevt)
-{
-	mtk_cpux_set_irq(to_timer_of(clkevt), true);
-	return 0;
-}
-
 static void mtk_syst_ack_irq(struct timer_of *to)
 {
 	/* Clear and disable interrupt */
@@ -340,60 +281,6 @@ static struct timer_of to = {
 	},
 };
 
-static int __init mtk_cpux_init(struct device_node *node)
-{
-	static struct timer_of to_cpux;
-	u32 freq, val;
-	int ret;
-
-	/*
-	 * There are per-cpu interrupts for the CPUX General Purpose Timer
-	 * but since this timer feeds the AArch64 System Timer we can rely
-	 * on the CPU timer PPIs as well, so we don't declare TIMER_OF_IRQ.
-	 */
-	to_cpux.flags = TIMER_OF_BASE | TIMER_OF_CLOCK;
-	to_cpux.clkevt.name = "mtk-cpuxgpt";
-	to_cpux.clkevt.rating = 10;
-	to_cpux.clkevt.cpumask = cpu_possible_mask;
-	to_cpux.clkevt.set_state_shutdown = mtk_cpux_clkevt_shutdown;
-	to_cpux.clkevt.tick_resume = mtk_cpux_clkevt_resume;
-
-	/* If this fails, bad things are about to happen... */
-	ret = timer_of_init(node, &to_cpux);
-	if (ret) {
-		WARN(1, "Cannot start CPUX timers.\n");
-		return ret;
-	}
-
-	/*
-	 * Check if we're given a clock with the right frequency for this
-	 * timer, otherwise warn but keep going with the setup anyway, as
-	 * that makes it possible to still boot the kernel, even though
-	 * it may not work correctly (random lockups, etc).
-	 * The reason behind this is that having an early UART may not be
-	 * possible for everyone and this gives a chance to retrieve kmsg
-	 * for eventual debugging even on consumer devices.
-	 */
-	freq = timer_of_rate(&to_cpux);
-	if (freq > 13000000)
-		WARN(1, "Requested unsupported timer frequency %u\n", freq);
-
-	/* Clock input is 26MHz, set DIV2 to achieve 13MHz clock */
-	val = mtk_cpux_readl(CPUX_IDX_GLOBAL_CTRL, &to_cpux);
-	val &= ~CPUX_CLK_DIV_MASK;
-	val |= CPUX_CLK_DIV2;
-	mtk_cpux_writel(val, CPUX_IDX_GLOBAL_CTRL, &to_cpux);
-
-	/* Enable all CPUXGPT timers */
-	val = mtk_cpux_readl(CPUX_IDX_GLOBAL_CTRL, &to_cpux);
-	mtk_cpux_writel(val | CPUX_ENABLE, CPUX_IDX_GLOBAL_CTRL, &to_cpux);
-
-	clockevents_config_and_register(&to_cpux.clkevt, timer_of_rate(&to_cpux),
-					TIMER_SYNC_TICKS, 0xffffffff);
-
-	return 0;
-}
-
 static int __init mtk_syst_init(struct device_node *node)
 {
 	int ret;
@@ -452,4 +339,3 @@ static int __init mtk_gpt_init(struct device_node *node)
 }
 TIMER_OF_DECLARE(mtk_mt6577, "mediatek,mt6577-timer", mtk_gpt_init);
 TIMER_OF_DECLARE(mtk_mt6765, "mediatek,mt6765-timer", mtk_syst_init);
-TIMER_OF_DECLARE(mtk_mt6795, "mediatek,mt6795-systimer", mtk_cpux_init);
-- 
2.39.2

