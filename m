Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 822B573F41F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 07:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbjF0Fxf convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 27 Jun 2023 01:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbjF0FxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 01:53:24 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE5AA19A1;
        Mon, 26 Jun 2023 22:53:19 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 5A6BF24DBCE;
        Tue, 27 Jun 2023 13:53:16 +0800 (CST)
Received: from EXMBX061.cuchost.com (172.16.6.61) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 27 Jun
 2023 13:53:16 +0800
Received: from localhost.localdomain (183.27.97.206) by EXMBX061.cuchost.com
 (172.16.6.61) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 27 Jun
 2023 13:53:15 +0800
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
        <linux-kernel@vger.kernel.org>, Conor Dooley <conor+dt@kernel.org>
Subject: [PATCH v3 2/3] clocksource: Add JH7110 timer driver
Date:   Tue, 27 Jun 2023 13:53:12 +0800
Message-ID: <20230627055313.252519-3-xingyu.wu@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230627055313.252519-1-xingyu.wu@starfivetech.com>
References: <20230627055313.252519-1-xingyu.wu@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [183.27.97.206]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX061.cuchost.com
 (172.16.6.61)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add timer driver for the StarFive JH7110 SoC.

Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
---
 MAINTAINERS                        |   7 +
 drivers/clocksource/Kconfig        |  11 +
 drivers/clocksource/Makefile       |   1 +
 drivers/clocksource/timer-jh7110.c | 485 +++++++++++++++++++++++++++++
 4 files changed, 504 insertions(+)
 create mode 100644 drivers/clocksource/timer-jh7110.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 6992b7cc7095..4e8e39ae685c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20125,6 +20125,13 @@ S:	Supported
 F:	Documentation/devicetree/bindings/mmc/starfive*
 F:	drivers/mmc/host/dw_mmc-starfive.c
 
+STARFIVE JH7110 TIMER DRIVER
+M:	Samin Guo <samin.guo@starfivetech.com>
+M:	Xingyu Wu <xingyu.wu@starfivetech.com>
+S:	Supported
+F:	Documentation/devicetree/bindings/timer/starfive,jh7110-timer.yaml
+F:	drivers/clocksource/timer-jh7110.c
+
 STARFIVE JH71X0 CLOCK DRIVERS
 M:	Emil Renner Berthing <kernel@esmil.dk>
 M:	Hal Feng <hal.feng@starfivetech.com>
diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 526382dc7482..a1393ec074c0 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -639,6 +639,17 @@ config RISCV_TIMER
 	  is accessed via both the SBI and the rdcycle instruction.  This is
 	  required for all RISC-V systems.
 
+config STARFIVE_JH7110_TIMER
+	bool "Timer for the STARFIVE JH7110 SoC"
+	depends on ARCH_STARFIVE || COMPILE_TEST
+	select TIMER_OF
+	select CLKSRC_MMIO
+	default ARCH_STARFIVE
+	help
+	  This enables the timer for StarFive JH7110 SoCs. On RISC-V platform,
+	  the system has started RISCV_TIMER. But you can also use this timer
+	  which can provides four channels to do a lot more on JH7110 SoC.
+
 config CLINT_TIMER
 	bool "CLINT Timer for the RISC-V platform" if COMPILE_TEST
 	depends on GENERIC_SCHED_CLOCK && RISCV
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index f12d3987a960..791fb3379f50 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -81,6 +81,7 @@ obj-$(CONFIG_INGENIC_TIMER)		+= ingenic-timer.o
 obj-$(CONFIG_CLKSRC_ST_LPC)		+= clksrc_st_lpc.o
 obj-$(CONFIG_X86_NUMACHIP)		+= numachip.o
 obj-$(CONFIG_RISCV_TIMER)		+= timer-riscv.o
+obj-$(CONFIG_STARFIVE_JH7110_TIMER)	+= timer-jh7110.o
 obj-$(CONFIG_CLINT_TIMER)		+= timer-clint.o
 obj-$(CONFIG_CSKY_MP_TIMER)		+= timer-mp-csky.o
 obj-$(CONFIG_GX6605S_TIMER)		+= timer-gx6605s.o
diff --git a/drivers/clocksource/timer-jh7110.c b/drivers/clocksource/timer-jh7110.c
new file mode 100644
index 000000000000..b88334a916fb
--- /dev/null
+++ b/drivers/clocksource/timer-jh7110.c
@@ -0,0 +1,485 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Starfive JH7110 Timer driver
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
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/reset.h>
+#include <linux/sched_clock.h>
+
+/* Bias: Ch0-0x0, Ch1-0x40, Ch2-0x80, and so on. */
+#define JH7110_TIMER_CH_LEN		0x40
+#define JH7110_TIMER_CH_BASE(x)		((x) * JH7110_TIMER_CH_LEN)
+
+#define JH7110_CLOCK_SOURCE_RATING	200
+#define JH7110_VALID_BITS		32
+#define JH7110_DELAY_US			0
+#define JH7110_TIMEOUT_US		10000
+#define JH7110_CLOCKEVENT_RATING	300
+#define JH7110_TIMER_MAX_TICKS		0xffffffff
+#define JH7110_TIMER_MIN_TICKS		0xf
+#define JH7110_TIMER_NAME_NUM		20
+
+#define JH7110_TIMER_INT_STATUS		0x00 /* RO[0:4]: Interrupt Status for channel0~4 */
+#define JH7110_TIMER_CTL		0x04 /* RW[0]: 0-continuous run, 1-single run */
+#define JH7110_TIMER_LOAD		0x08 /* RW: load value to counter */
+#define JH7110_TIMER_ENABLE		0x10 /* RW[0]: timer enable register */
+#define JH7110_TIMER_RELOAD		0x14 /* RW: write 1 or 0 both reload counter */
+#define JH7110_TIMER_VALUE		0x18 /* RO: timer value register */
+#define JH7110_TIMER_INT_CLR		0x20 /* RW: timer interrupt clear register */
+#define JH7110_TIMER_INT_MASK		0x24 /* RW[0]: timer interrupt mask register */
+#define JH7110_TIMER_INT_CLR_AVA_MASK	BIT(1)
+
+enum JH7110_TIMER_CH {
+	JH7110_TIMER_CH_0 = 0,
+	JH7110_TIMER_CH_1,
+	JH7110_TIMER_CH_2,
+	JH7110_TIMER_CH_3,
+	JH7110_TIMER_CH_MAX
+};
+
+enum JH7110_TIMER_INTMASK {
+	JH7110_TIMER_INTMASK_DIS = 0,
+	JH7110_TIMER_INTMASK_ENA = 1
+};
+
+enum JH7110_TIMER_MOD {
+	JH7110_TIMER_MOD_CONTIN = 0,
+	JH7110_TIMER_MOD_SINGLE = 1
+};
+
+enum JH7110_TIMER_CTL_EN {
+	JH7110_TIMER_DIS = 0,
+	JH7110_TIMER_ENA = 1
+};
+
+struct jh7110_timer_info {
+	/* Resgister */
+	unsigned int ctrl;
+	unsigned int load;
+	unsigned int enable;
+	unsigned int reload;
+	unsigned int value;
+	unsigned int intclr;
+	unsigned int intmask;
+	unsigned int channel_base[JH7110_TIMER_CH_MAX];
+};
+
+struct jh7110_clkevt {
+	struct clock_event_device evt;
+	struct clocksource cs;
+	struct clk *clk;
+	char name[JH7110_TIMER_NAME_NUM];
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
+
+struct jh7110_timer_priv {
+	struct device *dev;
+	void __iomem *base;
+	struct jh7110_clkevt clkevt[JH7110_TIMER_CH_MAX];
+};
+
+static const struct jh7110_timer_info jh7110_timer_data = {
+	.ctrl		= JH7110_TIMER_CTL,
+	.load		= JH7110_TIMER_LOAD,
+	.enable		= JH7110_TIMER_ENABLE,
+	.reload		= JH7110_TIMER_RELOAD,
+	.value		= JH7110_TIMER_VALUE,
+	.intclr		= JH7110_TIMER_INT_CLR,
+	.intmask	= JH7110_TIMER_INT_MASK,
+	.channel_base	= {JH7110_TIMER_CH_BASE(JH7110_TIMER_CH_0),
+			   JH7110_TIMER_CH_BASE(JH7110_TIMER_CH_1),
+			   JH7110_TIMER_CH_BASE(JH7110_TIMER_CH_2),
+			   JH7110_TIMER_CH_BASE(JH7110_TIMER_CH_3)},
+};
+
+static inline struct jh7110_clkevt *to_jh7110_clkevt(struct clock_event_device *evt)
+{
+	return container_of(evt, struct jh7110_clkevt, evt);
+}
+
+/* 0:continuous-run mode, 1:single-run mode */
+static inline void jh7110_timer_set_mod(struct jh7110_clkevt *clkevt, int mod)
+{
+	writel(mod, clkevt->ctrl);
+}
+
+/* Interrupt Mask Register, 0:Unmask, 1:Mask */
+static inline void jh7110_timer_int_enable(struct jh7110_clkevt *clkevt)
+{
+	writel(JH7110_TIMER_INTMASK_DIS, clkevt->intmask);
+}
+
+static inline void jh7110_timer_int_disable(struct jh7110_clkevt *clkevt)
+{
+	writel(JH7110_TIMER_INTMASK_ENA, clkevt->intmask);
+}
+
+/*
+ * BIT(0): Read value represent channel intr status.
+ * Write 1 to this bit to clear interrupt. Write 0 has no effects.
+ * BIT(1): "1" means that it is clearing interrupt. BIT(0) can not be written.
+ */
+static inline int jh7110_timer_int_clear(struct jh7110_clkevt *clkevt)
+{
+	u32 value;
+	int ret;
+
+	/* waiting interrupt can be to clearing */
+	ret = readl_poll_timeout_atomic(clkevt->intclr, value,
+					!(value & JH7110_TIMER_INT_CLR_AVA_MASK),
+					JH7110_DELAY_US, JH7110_TIMEOUT_US);
+	if (!ret)
+		writel(0x1, clkevt->intclr);
+
+	return ret;
+}
+
+/*
+ * The initial value to be loaded into the
+ * counter and is also used as the reload value.
+ * val = clock rate --> 1s
+ */
+static inline void jh7110_timer_set_load(struct jh7110_clkevt *clkevt, u32 val)
+{
+	writel(val, clkevt->load);
+}
+
+static inline u32 jh7110_timer_get_val(struct jh7110_clkevt *clkevt)
+{
+	return readl(clkevt->value);
+}
+
+/*
+ * Write RELOAD register to reload preset value to counter.
+ * Write 0 and write 1 are both ok.
+ */
+static inline void jh7110_timer_set_reload(struct jh7110_clkevt *clkevt)
+{
+	writel(0, clkevt->reload);
+}
+
+static inline void jh7110_timer_enable(struct jh7110_clkevt *clkevt)
+{
+	writel(JH7110_TIMER_ENA, clkevt->enable);
+}
+
+static inline void jh7110_timer_disable(struct jh7110_clkevt *clkevt)
+{
+	writel(JH7110_TIMER_DIS, clkevt->enable);
+}
+
+static int jh7110_timer_int_init_enable(struct jh7110_clkevt *clkevt)
+{
+	int ret;
+
+	jh7110_timer_int_disable(clkevt);
+	ret = jh7110_timer_int_clear(clkevt);
+	if (ret)
+		return ret;
+
+	jh7110_timer_int_enable(clkevt);
+	jh7110_timer_enable(clkevt);
+
+	return 0;
+}
+
+static int jh7110_timer_shutdown(struct clock_event_device *evt)
+{
+	struct jh7110_clkevt *clkevt = to_jh7110_clkevt(evt);
+
+	jh7110_timer_disable(clkevt);
+	return jh7110_timer_int_clear(clkevt);
+}
+
+static void jh7110_timer_suspend(struct clock_event_device *evt)
+{
+	struct jh7110_clkevt *clkevt = to_jh7110_clkevt(evt);
+
+	clkevt->reload_val = jh7110_timer_get_val(clkevt);
+	jh7110_timer_shutdown(evt);
+}
+
+static void jh7110_timer_resume(struct clock_event_device *evt)
+{
+	struct jh7110_clkevt *clkevt = to_jh7110_clkevt(evt);
+
+	jh7110_timer_set_load(clkevt, clkevt->reload_val);
+	jh7110_timer_set_reload(clkevt);
+	jh7110_timer_int_enable(clkevt);
+	jh7110_timer_enable(clkevt);
+}
+
+static int jh7110_timer_tick_resume(struct clock_event_device *evt)
+{
+	jh7110_timer_resume(evt);
+
+	return 0;
+}
+
+static u64 jh7110_timer_clocksource_read(struct clocksource *cs)
+{
+	struct jh7110_clkevt *clkevt = container_of(cs, struct jh7110_clkevt, cs);
+
+	return (u64)jh7110_timer_get_val(clkevt);
+}
+
+static int jh7110_clocksource_init(struct jh7110_clkevt *clkevt)
+{
+	int ret;
+
+	jh7110_timer_set_mod(clkevt, JH7110_TIMER_MOD_CONTIN);
+	jh7110_timer_set_load(clkevt, JH7110_TIMER_MAX_TICKS);
+
+	ret = jh7110_timer_int_init_enable(clkevt);
+	if (ret)
+		return ret;
+
+	clkevt->cs.name = clkevt->name;
+	clkevt->cs.rating = JH7110_CLOCK_SOURCE_RATING;
+	clkevt->cs.read = jh7110_timer_clocksource_read;
+	clkevt->cs.mask = CLOCKSOURCE_MASK(JH7110_VALID_BITS);
+	clkevt->cs.flags = CLOCK_SOURCE_IS_CONTINUOUS;
+
+	return clocksource_register_hz(&clkevt->cs, clkevt->rate);
+}
+
+/* IRQ handler for the timer */
+static irqreturn_t jh7110_timer_interrupt(int irq, void *priv)
+{
+	struct clock_event_device *evt = (struct clock_event_device *)priv;
+	struct jh7110_clkevt *clkevt = to_jh7110_clkevt(evt);
+
+	if (jh7110_timer_int_clear(clkevt))
+		return IRQ_NONE;
+
+	if (evt->event_handler)
+		evt->event_handler(evt);
+
+	return IRQ_HANDLED;
+}
+
+static int jh7110_timer_set_periodic(struct clock_event_device *evt)
+{
+	struct jh7110_clkevt *clkevt = to_jh7110_clkevt(evt);
+
+	clkevt->periodic = DIV_ROUND_CLOSEST(clkevt->rate, HZ);
+	jh7110_timer_disable(clkevt);
+	jh7110_timer_set_mod(clkevt, JH7110_TIMER_MOD_CONTIN);
+	jh7110_timer_set_load(clkevt, clkevt->periodic);
+
+	return jh7110_timer_int_init_enable(clkevt);
+}
+
+static int jh7110_timer_set_oneshot(struct clock_event_device *evt)
+{
+	struct jh7110_clkevt *clkevt = to_jh7110_clkevt(evt);
+
+	jh7110_timer_disable(clkevt);
+	jh7110_timer_set_mod(clkevt, JH7110_TIMER_MOD_SINGLE);
+	jh7110_timer_set_load(clkevt, JH7110_TIMER_MAX_TICKS);
+
+	return jh7110_timer_int_init_enable(clkevt);
+}
+
+static int jh7110_timer_set_next_event(unsigned long next,
+				       struct clock_event_device *evt)
+{
+	struct jh7110_clkevt *clkevt = to_jh7110_clkevt(evt);
+
+	jh7110_timer_disable(clkevt);
+	jh7110_timer_set_mod(clkevt, JH7110_TIMER_MOD_SINGLE);
+	jh7110_timer_set_load(clkevt, next);
+	jh7110_timer_enable(clkevt);
+
+	return 0;
+}
+
+static void jh7110_set_clockevent(struct clock_event_device *evt)
+{
+	evt->features = CLOCK_EVT_FEAT_PERIODIC |
+			CLOCK_EVT_FEAT_ONESHOT |
+			CLOCK_EVT_FEAT_DYNIRQ;
+	evt->set_state_shutdown = jh7110_timer_shutdown;
+	evt->set_state_periodic = jh7110_timer_set_periodic;
+	evt->set_state_oneshot = jh7110_timer_set_oneshot;
+	evt->set_state_oneshot_stopped = jh7110_timer_shutdown;
+	evt->tick_resume = jh7110_timer_tick_resume;
+	evt->set_next_event = jh7110_timer_set_next_event;
+	evt->suspend = jh7110_timer_suspend;
+	evt->resume = jh7110_timer_resume;
+	evt->rating = JH7110_CLOCKEVENT_RATING;
+}
+
+static void jh7110_clockevents_register(struct jh7110_clkevt *clkevt)
+{
+	clkevt->rate = clk_get_rate(clkevt->clk);
+
+	jh7110_set_clockevent(&clkevt->evt);
+	clkevt->evt.name = clkevt->name;
+	clkevt->evt.irq = clkevt->irq;
+	clkevt->evt.cpumask = cpu_possible_mask;
+
+	clockevents_config_and_register(&clkevt->evt, clkevt->rate,
+					JH7110_TIMER_MIN_TICKS, JH7110_TIMER_MAX_TICKS);
+}
+
+static void jh7110_clkevt_base_init(const struct jh7110_timer_info *data,
+				    struct jh7110_clkevt *clkevt,
+				    void __iomem *base, int ch)
+{
+	void __iomem *channel_base;
+
+	channel_base = base + data->channel_base[ch];
+	clkevt->base = channel_base;
+	clkevt->ctrl = channel_base + data->ctrl;
+	clkevt->load = channel_base + data->load;
+	clkevt->enable = channel_base + data->enable;
+	clkevt->reload = channel_base + data->reload;
+	clkevt->value = channel_base + data->value;
+	clkevt->intclr = channel_base + data->intclr;
+	clkevt->intmask = channel_base + data->intmask;
+}
+
+static int jh7110_timer_probe(struct platform_device *pdev)
+{
+	const struct jh7110_timer_info *data = of_device_get_match_data(&pdev->dev);
+	char name[JH7110_TIMER_NAME_NUM];
+	struct jh7110_timer_priv *priv;
+	struct jh7110_clkevt *clkevt;
+	struct clk *pclk;
+	struct reset_control *rst;
+	int ch;
+	int ret;
+
+	if (!data)
+		return -ENOENT;
+
+	priv = devm_kzalloc(&pdev->dev, struct_size(priv, clkevt, JH7110_TIMER_CH_MAX),
+			    GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(priv->base))
+		return dev_err_probe(&pdev->dev, PTR_ERR(priv->base),
+				     "failed to map registers\n");
+
+	rst = devm_reset_control_get_exclusive(&pdev->dev, "apb");
+	if (IS_ERR(rst))
+		return dev_err_probe(&pdev->dev, PTR_ERR(rst), "failed to get apb reset\n");
+
+	pclk = devm_clk_get_enabled(&pdev->dev, "apb");
+	if (IS_ERR(pclk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(pclk),
+				     "failed to get & enable apb clock\n");
+
+	ret = reset_control_deassert(rst);
+	if (ret)
+		goto err;
+
+	priv->dev = &pdev->dev;
+	platform_set_drvdata(pdev, priv);
+
+	for (ch = 0; ch < JH7110_TIMER_CH_MAX; ch++) {
+		clkevt = &priv->clkevt[ch];
+		snprintf(name, sizeof(name), "ch%d", ch);
+
+		jh7110_clkevt_base_init(data, clkevt, priv->base, ch);
+		/* Ensure timers are disabled */
+		jh7110_timer_disable(clkevt);
+
+		rst = devm_reset_control_get_exclusive(&pdev->dev, name);
+		if (IS_ERR(rst)) {
+			ret = PTR_ERR(rst);
+			goto err;
+		}
+
+		clkevt->clk = devm_clk_get_enabled(&pdev->dev, name);
+		if (IS_ERR(clkevt->clk)) {
+			ret = PTR_ERR(clkevt->clk);
+			goto err;
+		}
+
+		ret = reset_control_deassert(rst);
+		if (ret)
+			goto ch_err;
+
+		clkevt->irq = platform_get_irq(pdev, ch);
+		if (clkevt->irq < 0) {
+			ret = clkevt->irq;
+			goto ch_err;
+		}
+
+		snprintf(clkevt->name, sizeof(clkevt->name), "%s.ch%d", pdev->name, ch);
+		jh7110_clockevents_register(clkevt);
+
+		ret = devm_request_irq(&pdev->dev, clkevt->irq, jh7110_timer_interrupt,
+				       IRQF_TIMER | IRQF_IRQPOLL,
+				       clkevt->name, &clkevt->evt);
+		if (ret)
+			goto ch_err;
+
+		ret = jh7110_clocksource_init(clkevt);
+		if (ret)
+			goto ch_err;
+	}
+
+	return 0;
+
+ch_err:
+	for (; ch < 0; ch--)
+		clk_disable_unprepare(priv->clkevt[ch].clk);
+err:
+	clk_disable_unprepare(pclk);
+
+	return ret;
+}
+
+static const struct of_device_id jh7110_timer_match[] = {
+	{ .compatible = "starfive,jh7110-timer", .data = &jh7110_timer_data },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, jh7110_timer_match);
+
+static struct platform_driver jh7110_timer_driver = {
+	.probe = jh7110_timer_probe,
+	.driver = {
+		.name = "jh7110-timer",
+		.of_match_table = jh7110_timer_match,
+	},
+};
+module_platform_driver(jh7110_timer_driver);
+
+MODULE_AUTHOR("Xingyu Wu <xingyu.wu@starfivetech.com>");
+MODULE_DESCRIPTION("StarFive JH7110 timer driver");
+MODULE_LICENSE("GPL");
-- 
2.17.1

