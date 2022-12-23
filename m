Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B497C654EDF
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 10:54:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236254AbiLWJyo convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 23 Dec 2022 04:54:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235895AbiLWJyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 04:54:12 -0500
Received: from fd01.gateway.ufhost.com (unknown [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11E894496A;
        Fri, 23 Dec 2022 01:48:20 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 7C66C24DFDC;
        Fri, 23 Dec 2022 17:48:04 +0800 (CST)
Received: from EXMBX161.cuchost.com (172.16.6.71) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 23 Dec
 2022 17:48:04 +0800
Received: from localhost.localdomain (183.27.97.120) by EXMBX161.cuchost.com
 (172.16.6.71) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 23 Dec
 2022 17:48:03 +0800
From:   Xingyu Wu <xingyu.wu@starfivetech.com>
To:     <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        "Daniel Lezcano" <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Xingyu Wu <xingyu.wu@starfivetech.com>,
        Samin Guo <samin.guo@starfivetech.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 2/3] clocksource: Add StarFive timer driver
Date:   Fri, 23 Dec 2022 17:48:00 +0800
Message-ID: <20221223094801.181315-3-xingyu.wu@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221223094801.181315-1-xingyu.wu@starfivetech.com>
References: <20221223094801.181315-1-xingyu.wu@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [183.27.97.120]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX161.cuchost.com
 (172.16.6.71)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        RDNS_NONE,SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add timer driver for the StarFive JH7110 SoC.

Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
---
 MAINTAINERS                          |   7 +
 drivers/clocksource/Kconfig          |  12 +
 drivers/clocksource/Makefile         |   1 +
 drivers/clocksource/timer-starfive.c | 465 +++++++++++++++++++++++++++
 drivers/clocksource/timer-starfive.h | 104 ++++++
 5 files changed, 589 insertions(+)
 create mode 100644 drivers/clocksource/timer-starfive.c
 create mode 100644 drivers/clocksource/timer-starfive.h

diff --git a/MAINTAINERS b/MAINTAINERS
index a70c1d0f303e..340ad9e0a31f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19623,6 +19623,13 @@ F:	Documentation/devicetree/bindings/reset/starfive,jh7100-reset.yaml
 F:	drivers/reset/starfive/
 F:	include/dt-bindings/reset/starfive*
 
+STARFIVE TIMER DRIVER
+M:	Samin Guo <samin.guo@starfivetech.com>
+M:	Xingyu Wu <xingyu.wu@starfivetech.com>
+S:	Supported
+F:	Documentation/devicetree/bindings/timer/starfive*
+F:	drivers/clocksource/timer-starfive*
+
 STATIC BRANCH/CALL
 M:	Peter Zijlstra <peterz@infradead.org>
 M:	Josh Poimboeuf <jpoimboe@kernel.org>
diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 4469e7f555e9..11400b3a8f5c 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -630,6 +630,18 @@ config RISCV_TIMER
 	  is accessed via both the SBI and the rdcycle instruction.  This is
 	  required for all RISC-V systems.
 
+config STARFIVE_TIMER
+	bool "Timer for the STARFIVE SoCs"
+	depends on RISCV && OF && (SOC_STARFIVE || COMPILE_TEST)
+	select TIMER_OF
+	select CLKSRC_MMIO
+	default SOC_STARFIVE
+	help
+	  This enables the timers for StarFive SoCs. On RISC-V platform,
+	  the system has started RISCV_TIMER. But you can also use these timers
+	  to do a lot more on StarFive SoCs. These timers can provide much
+	  higher precision than RISCV_TIMER.
+
 config CLINT_TIMER
 	bool "CLINT Timer for the RISC-V platform" if COMPILE_TEST
 	depends on GENERIC_SCHED_CLOCK && RISCV
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index 64ab547de97b..276695d95cdc 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -80,6 +80,7 @@ obj-$(CONFIG_INGENIC_TIMER)		+= ingenic-timer.o
 obj-$(CONFIG_CLKSRC_ST_LPC)		+= clksrc_st_lpc.o
 obj-$(CONFIG_X86_NUMACHIP)		+= numachip.o
 obj-$(CONFIG_RISCV_TIMER)		+= timer-riscv.o
+obj-$(CONFIG_STARFIVE_TIMER)		+= timer-starfive.o
 obj-$(CONFIG_CLINT_TIMER)		+= timer-clint.o
 obj-$(CONFIG_CSKY_MP_TIMER)		+= timer-mp-csky.o
 obj-$(CONFIG_GX6605S_TIMER)		+= timer-gx6605s.o
diff --git a/drivers/clocksource/timer-starfive.c b/drivers/clocksource/timer-starfive.c
new file mode 100644
index 000000000000..8db413a22fdc
--- /dev/null
+++ b/drivers/clocksource/timer-starfive.c
@@ -0,0 +1,465 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Starfive Timer driver
+ *
+ * Copyright (C) 2022 StarFive Technology Co., Ltd.
+ *
+ * Author:
+ * Xingyu Wu <xingyu.wu@starfivetech.com>
+ * Samin Guo <samin.guo@starfivetech.com>
+ */
+
+#include <linux/clk.h>
+#include <linux/clockchips.h>
+#include <linux/clocksource.h>
+#include <linux/err.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/irq.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_clk.h>
+#include <linux/of_irq.h>
+#include <linux/reset.h>
+#include <linux/sched_clock.h>
+
+#include "timer-starfive.h"
+
+struct starfive_timer __initdata starfive_timer_jh7110 = {
+	.ctrl		= STARFIVE_TIMER_JH7110_CTL,
+	.load		= STARFIVE_TIMER_JH7110_LOAD,
+	.enable		= STARFIVE_TIMER_JH7110_ENABLE,
+	.reload		= STARFIVE_TIMER_JH7110_RELOAD,
+	.value		= STARFIVE_TIMER_JH7110_VALUE,
+	.intclr		= STARFIVE_TIMER_JH7110_INT_CLR,
+	.intmask	= STARFIVE_TIMER_JH7110_INT_MASK,
+	.timer_base	= {STARFIVE_TIMER_BASE(0), STARFIVE_TIMER_BASE(1),
+			   STARFIVE_TIMER_BASE(2), STARFIVE_TIMER_BASE(3)},
+};
+
+static inline struct starfive_clkevt *to_starfive_clkevt(struct clock_event_device *evt)
+{
+	return container_of(evt, struct starfive_clkevt, evt);
+}
+
+/* 0:continuous-run mode, 1:single-run mode */
+static inline void starfive_timer_set_mod(struct starfive_clkevt *clkevt, int mod)
+{
+	writel(mod, clkevt->ctrl);
+}
+
+/* Interrupt Mask Register, 0:Unmask, 1:Mask */
+static inline void starfive_timer_int_enable(struct starfive_clkevt *clkevt)
+{
+	writel(INTMASK_ENABLE_DIS, clkevt->intmask);
+}
+
+static inline void starfive_timer_int_disable(struct starfive_clkevt *clkevt)
+{
+	writel(INTMASK_ENABLE, clkevt->intmask);
+}
+
+/*
+ * BIT(0): Read value represent channel intr status.
+ * Write 1 to this bit to clear interrupt. Write 0 has no effects.
+ * BIT(1): "1" means that it is clearing interrupt. BIT(0) can not be written.
+ */
+static inline void starfive_timer_int_clear(struct starfive_clkevt *clkevt)
+{
+	/* waiting interrupt can be to clearing */
+	u32 value;
+	int ret = 0;
+
+	value = readl(clkevt->intclr);
+	ret = readl_poll_timeout_atomic(clkevt->intclr, value,
+					!(value & STARFIVE_TIMER_JH7110_INT_STATUS_CLR_AVA),
+					STARFIVE_DELAY_US, STARFIVE_TIMEOUT_US);
+	if (!ret)
+		writel(1, clkevt->intclr);
+}
+
+/*
+ * The initial value to be loaded into the
+ * counter and is also used as the reload value.
+ */
+static inline void starfive_timer_set_load(struct starfive_clkevt *clkevt, u32 val)
+{
+	writel(val, clkevt->load);
+}
+
+static inline u32 starfive_timer_get_val(struct starfive_clkevt *clkevt)
+{
+	return readl(clkevt->value);
+}
+
+/*
+ * Write RELOAD register to reload preset value to counter.
+ * (Write 0 and write 1 are both ok)
+ */
+static inline void starfive_timer_set_reload(struct starfive_clkevt *clkevt)
+{
+	writel(1, clkevt->reload);
+}
+
+static inline void starfive_timer_enable(struct starfive_clkevt *clkevt)
+{
+	writel(TIMER_ENA, clkevt->enable);
+}
+
+static inline void starfive_timer_disable(struct starfive_clkevt *clkevt)
+{
+	writel(TIMER_ENA_DIS, clkevt->enable);
+}
+
+static void timer_shutdown(struct starfive_clkevt *clkevt)
+{
+	starfive_timer_int_disable(clkevt);
+	starfive_timer_disable(clkevt);
+	starfive_timer_int_clear(clkevt);
+}
+
+static void starfive_timer_suspend(struct clock_event_device *evt)
+{
+	struct starfive_clkevt *clkevt = to_starfive_clkevt(evt);
+
+	clkevt->reload_val = starfive_timer_get_val(clkevt);
+
+	starfive_timer_disable(clkevt);
+	starfive_timer_int_disable(clkevt);
+	starfive_timer_int_clear(clkevt);
+}
+
+static void starfive_timer_resume(struct clock_event_device *evt)
+{
+	struct starfive_clkevt *clkevt = to_starfive_clkevt(evt);
+
+	starfive_timer_set_load(clkevt, clkevt->reload_val);
+	starfive_timer_set_reload(clkevt);
+	starfive_timer_int_enable(clkevt);
+	starfive_timer_enable(clkevt);
+}
+
+static int starfive_timer_tick_resume(struct clock_event_device *evt)
+{
+	starfive_timer_resume(evt);
+
+	return 0;
+}
+
+static int starfive_timer_shutdown(struct clock_event_device *evt)
+{
+	struct starfive_clkevt *clkevt = to_starfive_clkevt(evt);
+
+	timer_shutdown(clkevt);
+
+	return 0;
+}
+
+static int starfive_get_clock_rate(struct starfive_clkevt *clkevt, struct device_node *np)
+{
+	int ret;
+	u32 rate;
+
+	if (clkevt->clk) {
+		clkevt->rate = clk_get_rate(clkevt->clk);
+		if (clkevt->rate > 0) {
+			pr_debug("clk_get_rate clkevt->rate: %d\n", clkevt->rate);
+			return 0;
+		}
+	}
+
+	/* Next we try to get clock-frequency from dts.*/
+	ret = of_property_read_u32(np, "clock-frequency", &rate);
+	if (!ret) {
+		pr_debug("Timer: try get clock-frequency:%d Hz\n", rate);
+		clkevt->rate = rate;
+		return 0;
+	}
+	pr_err("Timer: get rate failed, need clock-frequency define in dts.\n");
+
+	return -ENOENT;
+}
+
+static int starfive_clocksource_init(struct starfive_clkevt *clkevt,
+				     const char *name, struct device_node *np)
+{
+	starfive_timer_set_mod(clkevt, MOD_CONTIN);
+	starfive_timer_set_load(clkevt, STARFIVE_MAX_TICKS);  /* val = rate --> 1s */
+	starfive_timer_int_disable(clkevt);
+	starfive_timer_int_clear(clkevt);
+	starfive_timer_int_enable(clkevt);
+	starfive_timer_enable(clkevt);
+
+	return clocksource_mmio_init(clkevt->value, name, clkevt->rate,
+				     STARFIVE_CLOCK_SOURCE_RATING, STARFIVE_VALID_BITS,
+				     clocksource_mmio_readl_down);
+}
+
+/*
+ * IRQ handler for the timer
+ */
+static irqreturn_t starfive_timer_interrupt(int irq, void *priv)
+{
+	struct clock_event_device *evt = (struct clock_event_device *)priv;
+	struct starfive_clkevt *clkevt = to_starfive_clkevt(evt);
+
+	starfive_timer_int_clear(clkevt);
+
+	if (evt->event_handler)
+		evt->event_handler(evt);
+
+	return IRQ_HANDLED;
+}
+
+static int starfive_timer_set_periodic(struct clock_event_device *evt)
+{
+	struct starfive_clkevt *clkevt = to_starfive_clkevt(evt);
+
+	starfive_timer_disable(clkevt);
+	starfive_timer_set_mod(clkevt, MOD_CONTIN);
+	starfive_timer_set_load(clkevt, clkevt->periodic);
+	starfive_timer_int_disable(clkevt);
+	starfive_timer_int_clear(clkevt);
+	starfive_timer_int_enable(clkevt);
+	starfive_timer_enable(clkevt);
+
+	return 0;
+}
+
+static int starfive_timer_set_oneshot(struct clock_event_device *evt)
+{
+	struct starfive_clkevt *clkevt = to_starfive_clkevt(evt);
+
+	starfive_timer_disable(clkevt);
+	starfive_timer_set_mod(clkevt, MOD_SINGLE);
+	starfive_timer_set_load(clkevt, STARFIVE_MAX_TICKS);
+	starfive_timer_int_disable(clkevt);
+	starfive_timer_int_clear(clkevt);
+	starfive_timer_int_enable(clkevt);
+	starfive_timer_enable(clkevt);
+
+	return 0;
+}
+
+static int starfive_timer_set_next_event(unsigned long next,
+					 struct clock_event_device *evt)
+{
+	struct starfive_clkevt *clkevt = to_starfive_clkevt(evt);
+
+	starfive_timer_disable(clkevt);
+	starfive_timer_set_mod(clkevt, MOD_SINGLE);
+	starfive_timer_set_load(clkevt, next);
+	starfive_timer_enable(clkevt);
+
+	return 0;
+}
+
+static void starfive_set_clockevent(struct clock_event_device *evt)
+{
+	evt->features	= CLOCK_EVT_FEAT_PERIODIC |
+			  CLOCK_EVT_FEAT_ONESHOT |
+			  CLOCK_EVT_FEAT_DYNIRQ;
+	evt->set_state_shutdown	= starfive_timer_shutdown;
+	evt->set_state_periodic	= starfive_timer_set_periodic;
+	evt->set_state_oneshot	= starfive_timer_set_oneshot;
+	evt->set_state_oneshot_stopped = starfive_timer_shutdown;
+	evt->tick_resume	= starfive_timer_tick_resume;
+	evt->set_next_event	= starfive_timer_set_next_event;
+	evt->suspend		= starfive_timer_suspend;
+	evt->resume		= starfive_timer_resume;
+	evt->rating		= STARFIVE_CLOCKEVENT_RATING;
+}
+
+static int starfive_clockevents_register(struct starfive_clkevt *clkevt, unsigned int irq,
+					 struct device_node *np, const char *name)
+{
+	int ret = 0;
+
+	ret = starfive_get_clock_rate(clkevt, np);
+	if (ret)
+		return -EINVAL;
+
+	clkevt->periodic = DIV_ROUND_CLOSEST(clkevt->rate, HZ);
+
+	starfive_set_clockevent(&clkevt->evt);
+	clkevt->evt.name = name;
+	clkevt->evt.irq = irq;
+	clkevt->evt.cpumask = cpu_possible_mask;
+
+	ret = request_irq(irq, starfive_timer_interrupt,
+			  IRQF_TIMER | IRQF_IRQPOLL, name, &clkevt->evt);
+	if (ret)
+		pr_err("%s: request_irq failed\n", name);
+
+	clockevents_config_and_register(&clkevt->evt, clkevt->rate,
+					STARFIVE_MIN_TICKS, STARFIVE_MAX_TICKS);
+
+	return ret;
+}
+
+static void __init starfive_clkevt_base_init(struct starfive_timer *timer,
+					     struct starfive_clkevt *clkevt,
+					     void __iomem *base, int index)
+{
+	void __iomem *timer_base;
+
+	timer_base	= base + timer->timer_base[index];
+	clkevt->base	= timer_base;
+	clkevt->ctrl	= timer_base + timer->ctrl;
+	clkevt->load	= timer_base + timer->load;
+	clkevt->enable	= timer_base + timer->enable;
+	clkevt->reload	= timer_base + timer->reload;
+	clkevt->value	= timer_base + timer->value;
+	clkevt->intclr	= timer_base + timer->intclr;
+	clkevt->intmask	= timer_base + timer->intmask;
+}
+
+static int __init starfive_timer_jh7110_of_init(struct device_node *np)
+{
+	int index, count, irq, ret;
+	const char *name = NULL;
+	struct clk *clk;
+	struct clk *pclk;
+	struct reset_control *prst;
+	struct reset_control *rst;
+	struct starfive_clkevt *clkevt[STARFIVE_NR_TIMERS];
+	void __iomem *base;
+	struct starfive_timer *timer = &starfive_timer_jh7110;
+
+	base = of_iomap(np, 0);
+	if (!base)
+		return -ENXIO;
+
+	if (!of_device_is_available(np)) {
+		ret = -EINVAL;
+		goto err;
+	}
+
+	pclk = of_clk_get_by_name(np, "apb");
+	if (!IS_ERR(pclk)) {
+		if (clk_prepare_enable(pclk))
+			pr_warn("pclk for %pOFn is present, but could not be activated\n", np);
+	/*
+	 * Clock framework support is late, continue on
+	 * anyways if we don't find a matching clock.
+	 */
+	} else if (PTR_ERR(pclk) != -EPROBE_DEFER) {
+		ret = PTR_ERR(pclk);
+		goto err;
+	}
+
+	prst = of_reset_control_get(np, "apb");
+	if (!IS_ERR(prst)) {
+		ret = reset_control_deassert(prst);
+		if (ret)
+			goto prst_err;
+	/*
+	 * Reset framework support is late, continue on
+	 * anyways if we don't find a matching reset.
+	 */
+	} else if (PTR_ERR(prst) != -EPROBE_DEFER) {
+		ret = PTR_ERR(prst);
+		goto prst_err;
+	}
+
+	/* The number of timers used is determined according to the device tree. */
+	count = of_irq_count(np);
+	if (count > STARFIVE_NR_TIMERS || count <= 0) {
+		ret = -EINVAL;
+		goto count_err;
+	}
+
+	for (index = 0; index < count; index++) {
+		of_property_read_string_index(np, "clock-names", index, &name);
+		if (strncmp(name, "timer", strlen("timer")))
+			continue;
+
+		clkevt[index] = kzalloc(sizeof(*clkevt[index]), GFP_KERNEL);
+		if (!clkevt[index]) {
+			ret = -ENOMEM;
+			goto clkevt_err;
+		}
+
+		starfive_clkevt_base_init(timer, clkevt[index], base, index);
+
+		/* Ensure timers are disabled */
+		starfive_timer_disable(clkevt[index]);
+
+		clk = of_clk_get_by_name(np, name);
+		if (!IS_ERR(clk)) {
+			clkevt[index]->clk = clk;
+			if (clk_prepare_enable(clkevt[index]->clk))
+				pr_warn("clk for %pOFn is present, but could not be activated\n",
+					np);
+		} else if (PTR_ERR(clk) != -EPROBE_DEFER) {
+			ret = PTR_ERR(clk);
+			goto clk_err;
+		}
+
+		rst = of_reset_control_get(np, name);
+		if (!IS_ERR(rst)) {
+			clkevt[index]->rst = rst;
+			ret = reset_control_deassert(clkevt[index]->rst);
+			if (ret)
+				goto rst_err;
+		}
+
+		irq = irq_of_parse_and_map(np, index);
+		if (irq < 0) {
+			ret = -EINVAL;
+			goto irq_err;
+		}
+
+		snprintf(clkevt[index]->name, sizeof(clkevt[index]->name), "%s.ch%d",
+			 np->full_name, index);
+
+		ret = starfive_clockevents_register(clkevt[index], irq, np, clkevt[index]->name);
+		if (ret) {
+			pr_err("%s: init clockevents failed.\n", clkevt[index]->name);
+			goto register_err;
+		}
+		clkevt[index]->irq = irq;
+
+		ret = starfive_clocksource_init(clkevt[index], clkevt[index]->name, np);
+		if (ret)
+			goto init_err;
+	}
+	if (!IS_ERR(pclk))
+		clk_put(pclk);
+
+	return 0;
+
+init_err:
+register_err:
+	free_irq(clkevt[index]->irq, &clkevt[index]->evt);
+irq_err:
+rst_err:
+clk_err:
+	/* Only unregister the failed timer and the rest timers continue to work. */
+	if (!clkevt[index]->rst) {
+		reset_control_assert(clkevt[index]->rst);
+		reset_control_put(clkevt[index]->rst);
+	}
+	if (!clkevt[index]->clk) {
+		clk_disable_unprepare(clkevt[index]->clk);
+		clk_put(clkevt[index]->clk);
+	}
+	kfree(clkevt[index]);
+clkevt_err:
+count_err:
+prst_err:
+	if (!IS_ERR(pclk)) {
+		/* If no other timer successfully registers, pclk is disabled. */
+		if (!index)
+			clk_disable_unprepare(pclk);
+		clk_put(pclk);
+	}
+err:
+	iounmap(base);
+	return ret;
+}
+
+TIMER_OF_DECLARE(starfive_timer_jh7110, "starfive,jh7110-timers", starfive_timer_jh7110_of_init);
diff --git a/drivers/clocksource/timer-starfive.h b/drivers/clocksource/timer-starfive.h
new file mode 100644
index 000000000000..9fd3303b31d1
--- /dev/null
+++ b/drivers/clocksource/timer-starfive.h
@@ -0,0 +1,104 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2022 StarFive Technology Co., Ltd.
+ */
+
+#ifndef __STARFIVE_TIMER_H__
+#define __STARFIVE_TIMER_H__
+
+#define STARFIVE_NR_TIMERS		TIMERS_MAX
+/* Bias: Timer0-0x0, Timer1-0x40, Timer2-0x80, and so on. */
+#define STARFIVE_PER_TIMER_LEN		0x40
+#define STARFIVE_TIMER_BASE(x)		((TIMER_##x) * STARFIVE_PER_TIMER_LEN)
+
+#define STARFIVE_CLOCK_SOURCE_RATING	200
+#define STARFIVE_VALID_BITS		32
+#define STARFIVE_DELAY_US		0
+#define STARFIVE_TIMEOUT_US		10000
+#define STARFIVE_CLOCKEVENT_RATING	300
+#define STARFIVE_MAX_TICKS		0xffffffff
+#define STARFIVE_MIN_TICKS		0xf
+
+/*
+ * JH7110 timer TIMER_INT_STATUS:
+ * ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
+ * |     Bits     | 08~31 | 7 | 6 | 5 |  4  | 3 | 2 | 1 | 0 |
+ * ----------------------------------------------------------
+ * | timer(n)_int |  res  | 6 | 5 | 4 | Wdt | 3 | 2 | 1 | 0 |
+ * ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
+ *
+ * Software can read this register to know which interrupt is occurred.
+ */
+#define STARFIVE_TIMER_JH7110_INT_STATUS	0x00
+#define STARFIVE_TIMER_JH7110_CTL		0x04
+#define STARFIVE_TIMER_JH7110_LOAD		0x08
+#define STARFIVE_TIMER_JH7110_ENABLE		0x10
+#define STARFIVE_TIMER_JH7110_RELOAD		0x14
+#define STARFIVE_TIMER_JH7110_VALUE		0x18
+#define STARFIVE_TIMER_JH7110_INT_CLR		0x20
+#define STARFIVE_TIMER_JH7110_INT_MASK		0x24
+#define STARFIVE_TIMER_JH7110_INT_STATUS_CLR_AVA	BIT(1)
+
+enum STARFIVE_TIMERS {
+	TIMER_0 = 0,
+	TIMER_1,
+	TIMER_2,
+	TIMER_3,
+	TIMER_4,  /*WDT*/
+	TIMER_5,
+	TIMER_6,
+	TIMER_7,
+	TIMERS_MAX
+};
+
+enum TIMERI_INTMASK {
+	INTMASK_ENABLE_DIS = 0,
+	INTMASK_ENABLE = 1
+};
+
+enum TIMER_MOD {
+	MOD_CONTIN = 0,
+	MOD_SINGLE = 1
+};
+
+enum TIMER_CTL_EN {
+	TIMER_ENA_DIS	= 0,
+	TIMER_ENA	= 1
+};
+
+enum {
+	INT_CLR_AVAILABLE = 0,
+	INT_CLR_NOT_AVAILABLE = 1
+};
+
+struct starfive_timer {
+	u32 ctrl;
+	u32 load;
+	u32 enable;
+	u32 reload;
+	u32 value;
+	u32 intclr;
+	u32 intmask;
+	u32 wdt_lock;   /* 0x3c+i*0x40 watchdog use ONLY */
+	u32 timer_base[STARFIVE_NR_TIMERS];
+};
+
+struct starfive_clkevt {
+	struct clock_event_device evt;
+	struct clk *clk;
+	struct reset_control *rst;
+	char name[20];
+	int irq;
+	u32 periodic;
+	u32 rate;
+	u32 reload_val;
+	void __iomem *base;
+	void __iomem *ctrl;
+	void __iomem *load;
+	void __iomem *enable;
+	void __iomem *reload;
+	void __iomem *value;
+	void __iomem *intclr;
+	void __iomem *intmask;
+};
+#endif /* __STARFIVE_TIMER_H__ */
-- 
2.25.1

