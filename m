Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5206C613506
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 12:56:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbiJaL4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 07:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231182AbiJaL4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 07:56:35 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 587E6D85;
        Mon, 31 Oct 2022 04:56:33 -0700 (PDT)
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 338138218;
        Mon, 31 Oct 2022 11:47:02 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Georgi Vlaev <g-vlaev@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Keerthy <j-keerthy@ti.com>,
        Ladislav Michl <ladis@linux-mips.org>,
        Nishanth Menon <nm@ti.com>, Suman Anna <s-anna@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [RFC PATCH 3/3] clocksource/drivers/timer-ti-dm: Add clock provider support
Date:   Mon, 31 Oct 2022 13:56:13 +0200
Message-Id: <20221031115613.56229-4-tony@atomide.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221031115613.56229-1-tony@atomide.com>
References: <20221031115613.56229-1-tony@atomide.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel drivers can use some of the dedicated hardware timer features to
provide a clock source on a timer output pin. Instead of exposing the
timer features with struct omap_dm_timer_ops, let's add clock provider
support. Also the PWM driver can be simplified with clk_set_duty_cycle()
and clk_get_scaled_duty_cycle().

This allows us to eventually deprecate the following functions exposed
by struct omap_dm_timer_ops:

enable()
disable()
start()
stop()
get_fclk()
set_source()

Not-Yet-Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/clocksource/timer-ti-dm.c | 315 +++++++++++++++++++++++++++++-
 include/clocksource/timer-ti-dm.h |   2 +
 2 files changed, 309 insertions(+), 8 deletions(-)

diff --git a/drivers/clocksource/timer-ti-dm.c b/drivers/clocksource/timer-ti-dm.c
--- a/drivers/clocksource/timer-ti-dm.c
+++ b/drivers/clocksource/timer-ti-dm.c
@@ -99,6 +99,16 @@
 #define OMAP_TIMER_TICK_INT_MASK_COUNT_REG				\
 		(_OMAP_TIMER_TICK_INT_MASK_COUNT_OFFSET | (WP_TOWR << WPSHIFT))
 
+/*
+ * Timer counts up with a maximum theoretical value of 0xffffffff meaning one
+ * clock cycle. In counter mode, the timer is however limited to a maximum value
+ * of 0xfffffffe for two clock cycles. And in PWM mode, the timer is limited to
+ * a maximum value of 0xfffffffd for three clock cycles. DMTIMER_CYCLES is only
+ * used for clock cycle calculations, and does not consider the hardware limits.
+ * The related timer functions check for the minimum allowed clock cycles.
+ */
+#define DMTIMER_CYCLES(x)			(0xffffffff - (x) + 1)
+
 struct timer_regs {
 	u32 ocp_cfg;
 	u32 tidr;
@@ -143,11 +153,14 @@ struct dmtimer {
 	int revision;
 	u32 capability;
 	u32 errata;
+	u32 load_val;
+	u32 match_val;
 	struct platform_device *pdev;
 	struct list_head node;
 	struct notifier_block nb;
 	struct irq_chip chip;
 	struct irq_domain *domain;
+	struct clk_hw hw;
 };
 
 static u32 omap_reserved_systimers;
@@ -261,6 +274,19 @@ static inline void __omap_dm_timer_enable_posted(struct dmtimer *timer)
 	timer->posted = OMAP_TIMER_POSTED;
 }
 
+static inline void __omap_dm_timer_start(struct dmtimer *timer, bool autoreload)
+{
+	u32 l, mask;
+
+	mask = OMAP_TIMER_CTRL_ST;
+	if (autoreload)
+		mask |= OMAP_TIMER_CTRL_AR;
+
+	l = dmtimer_read(timer, OMAP_TIMER_CTRL_REG);
+	if ((l & mask) != mask)
+		dmtimer_write(timer, OMAP_TIMER_CTRL_REG, l | mask);
+}
+
 static inline void __omap_dm_timer_stop(struct dmtimer *timer,
 					unsigned long rate)
 {
@@ -610,6 +636,275 @@ static int omap_dm_timer_reset(struct dmtimer *timer)
 	return 0;
 }
 
+/* Clock provider support */
+#if defined(CONFIG_COMMON_CLK)
+
+#define hw_to_dmtimer(x) container_of(x, struct dmtimer, hw)
+
+static int dmtimer_clk_prepare(struct clk_hw *hw)
+{
+	struct dmtimer *timer = hw_to_dmtimer(hw);
+	struct device *dev = &timer->pdev->dev;
+	int rc;
+	u32 l;
+
+	rc = pm_runtime_resume_and_get(dev);
+	if (rc)
+		return rc;
+
+	/* Clear output and set toggle modulation */
+	l = dmtimer_read(timer, OMAP_TIMER_CTRL_REG);
+	l &= ~OMAP_TIMER_CTRL_GPOCFG;
+	l |= OMAP_TIMER_CTRL_PT;
+	l &= ~(OMAP_TIMER_CTRL_TRIGGER_MASK << OMAP_TIMER_CTRL_TRIGGER_SHIFT);
+	l |= OMAP_TIMER_TRIGGER_OVERFLOW_AND_COMPARE << OMAP_TIMER_CTRL_TRIGGER_SHIFT;
+	dmtimer_write(timer, OMAP_TIMER_CTRL_REG, l);
+
+	return rc;
+}
+
+static void dmtimer_clk_unprepare(struct clk_hw *hw)
+{
+	struct dmtimer *timer = hw_to_dmtimer(hw);
+	struct device *dev = &timer->pdev->dev;
+	u32 l;
+
+	/* Clear output and toggle modulation */
+	l = dmtimer_read(timer, OMAP_TIMER_CTRL_REG);
+	l &= ~(OMAP_TIMER_CTRL_GPOCFG | OMAP_TIMER_CTRL_PT);
+	l &= ~(OMAP_TIMER_CTRL_TRIGGER_MASK << OMAP_TIMER_CTRL_TRIGGER_SHIFT);
+	dmtimer_write(timer, OMAP_TIMER_CTRL_REG, l);
+
+	pm_runtime_put_sync(dev);
+}
+
+static int dmtimer_clk_enable(struct clk_hw *hw)
+{
+	struct dmtimer *timer = hw_to_dmtimer(hw);
+	unsigned long flags;
+
+	/* Configure immediate overflow to toggle PWM on first event, see TRM */
+	spin_lock_irqsave(&timer->lock, flags);
+	dmtimer_write(timer, OMAP_TIMER_COUNTER_REG, DMTIMER_CYCLES(1));
+	__omap_dm_timer_start(timer, true);
+	spin_unlock_irqrestore(&timer->lock, flags);
+
+	return 0;
+}
+
+static void dmtimer_clk_disable(struct clk_hw *hw)
+{
+	struct dmtimer *timer = hw_to_dmtimer(hw);
+	unsigned long rate = 0;
+
+	if (!timer->omap1)
+		rate = clk_get_rate(timer->fclk);
+
+	__omap_dm_timer_stop(timer, rate);
+}
+
+static int dmtimer_clk_is_enabled(struct clk_hw *hw)
+{
+	struct dmtimer *timer = hw_to_dmtimer(hw);
+
+	return atomic_read(&timer->enabled);
+}
+
+static int dmtimer_get_prescale(struct dmtimer *timer)
+{
+	u32 l;
+
+	l = dmtimer_read(timer, OMAP_TIMER_CTRL_REG);
+	if (!(l & OMAP_TIMER_CTRL_PRE))
+		return 1;
+
+	return 2 << ((l >> OMAP_TIMER_CTRL_PTV_SHIFT) & 7);
+}
+
+static unsigned long dmtimer_clk_recalc_rate(struct clk_hw *hw,
+					     unsigned long parent_rate)
+{
+	struct dmtimer *timer = hw_to_dmtimer(hw);
+	int prescale;
+	u32 loadval;
+
+	prescale = dmtimer_get_prescale(timer);
+	loadval = dmtimer_read(timer, OMAP_TIMER_LOAD_REG);
+
+	return parent_rate / prescale / DMTIMER_CYCLES(loadval);
+}
+
+static long dmtimer_clk_round_rate(struct clk_hw *hw, unsigned long rate,
+				   unsigned long *parent_rate)
+{
+	unsigned int div;
+
+	div = DIV_ROUND_CLOSEST(*parent_rate, rate);
+
+	return *parent_rate / div;
+}
+
+static int dmtimer_clk_get_duty_cycle(struct clk_hw *hw,
+				      struct clk_duty *duty)
+{
+	struct dmtimer *timer = hw_to_dmtimer(hw);
+	u32 match, load;
+
+	match = dmtimer_read(timer, OMAP_TIMER_MATCH_REG);
+	load = dmtimer_read(timer, OMAP_TIMER_LOAD_REG);
+	duty->num =  match - load;
+	duty->den = DMTIMER_CYCLES(load);
+
+	return 0;
+}
+
+/*
+ * See am62 TRM "Table 12-312. Prescaler Clock Ratio Values" for PWM limits for
+ * the max load register value.
+ */
+static int dmtimer_clk_set_duty_cycle(struct clk_hw *hw,
+				      struct clk_duty *duty)
+{
+	struct dmtimer *timer = hw_to_dmtimer(hw);
+	u32 cycles, match;
+
+	if (!timer->load_val) {
+		dev_err(&timer->pdev->dev, "no rate configured for duty_cycle");
+		return -EINVAL;
+	}
+
+	cycles = DMTIMER_CYCLES(timer->load_val);
+	match = mult_frac(cycles, duty->num, duty->den);
+	timer->match_val = timer->load_val + match;
+	dmtimer_write(timer, OMAP_TIMER_MATCH_REG, timer->match_val);
+
+	return 0;
+}
+
+/*
+ * Note that setting the TCLR register prescaler value is not currently
+ * implemented, it can be added if needed with some clock sources.
+ */
+static int dmtimer_clk_set_rate(struct clk_hw *hw, unsigned long rate,
+				unsigned long parent_rate)
+{
+	struct dmtimer *timer = hw_to_dmtimer(hw);
+	struct device *dev = &timer->pdev->dev;
+	struct clk_duty duty;
+	unsigned int div;
+	int prescale, rc;
+	u32 cycles;
+
+	if (rate > parent_rate)
+		return -EINVAL;
+
+	prescale = dmtimer_get_prescale(timer);
+	div = parent_rate / prescale;
+	cycles = div / rate;
+
+	/*
+	 * TRM "Timer Pulse-Width Modulation" chapter says in PWM mode
+	 * TIMER_TLDR load register must be limited to max 0xfffffffd
+	 * limiting the minimum usable clock cycles to 3.
+	 */
+	if (cycles < 3)
+		return -EINVAL;
+
+	timer->load_val = DMTIMER_CYCLES(cycles);
+	dmtimer_write(timer, OMAP_TIMER_LOAD_REG, timer->load_val);
+
+	/* Configure 50% duty cycle by default */
+	if (!timer->match_val) {
+		duty.num = div / 2;
+		duty.den = div;
+
+		rc = dmtimer_clk_set_duty_cycle(hw, &duty);
+		if (rc)
+			dev_err(dev, "set_rate duty cycle failed: %i\n", rc);
+	}
+
+	return rc;
+}
+
+static int dmtimer_clk_get_phase(struct clk_hw *hw)
+{
+	struct dmtimer *timer = hw_to_dmtimer(hw);
+	u32 l = dmtimer_read(timer, OMAP_TIMER_CTRL_REG);
+
+	return (l & OMAP_TIMER_CTRL_SCPWM) ? 180 : 0;
+}
+
+static int dmtimer_clk_set_phase(struct clk_hw *hw, int degrees)
+{
+	struct dmtimer *timer = hw_to_dmtimer(hw);
+	u32 l = dmtimer_read(timer, OMAP_TIMER_CTRL_REG);
+
+	l &= ~OMAP_TIMER_CTRL_SCPWM;
+
+	switch (degrees) {
+	case 0:
+		break;
+	case 180:
+		l |= OMAP_TIMER_CTRL_SCPWM;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	dmtimer_write(timer, OMAP_TIMER_CTRL_REG, l);
+
+	return 0;
+}
+
+static const struct clk_ops dmtimer_clk_ops = {
+	.prepare = dmtimer_clk_prepare,
+	.unprepare = dmtimer_clk_unprepare,
+	.enable = dmtimer_clk_enable,
+	.disable = dmtimer_clk_disable,
+	.is_enabled = dmtimer_clk_is_enabled,
+	.recalc_rate = dmtimer_clk_recalc_rate,
+	.round_rate = dmtimer_clk_round_rate,
+	.set_rate = dmtimer_clk_set_rate,
+	.get_phase = dmtimer_clk_get_phase,
+	.set_phase = dmtimer_clk_set_phase,
+	.get_duty_cycle = dmtimer_clk_get_duty_cycle,
+	.set_duty_cycle = dmtimer_clk_set_duty_cycle,
+};
+
+static int dmtimer_register_clock(struct dmtimer *timer)
+{
+	struct device *dev = &timer->pdev->dev;
+	struct device_node *np = dev->of_node;
+	struct clk_init_data init = { };
+	struct clk_hw *hw;
+	const char *fck;
+	int ret;
+
+	if (!np || !of_find_property(np, "#clock-cells", NULL))
+		return 0;
+
+	hw = &timer->hw;
+	init.name = dev_name(dev);
+	init.ops = &dmtimer_clk_ops;
+	init.flags = CLK_GET_RATE_NOCACHE;
+	init.num_parents = 1;
+	fck = __clk_get_name(timer->fclk);
+	init.parent_names = &fck;
+	hw->init = &init;
+	ret = devm_clk_hw_register(dev, hw);
+	if (ret)
+		return ret;
+
+	return devm_of_clk_add_hw_provider(dev, of_clk_hw_simple_get, hw);
+}
+
+#else
+static inline int dmtimer_register_clock(struct dmtimer *timer)
+{
+	return 0;
+}
+#endif	/* CONFIG_COMMON_CLK */
+
 /*
  * Functions exposed to PWM and remoteproc drivers via platform_data.
  * Do not use these in the driver, these will get deprecated and will
@@ -885,6 +1180,7 @@ static int omap_dm_timer_free(struct omap_dm_timer *cookie)
 	/* Clear timer configuration */
 	spin_lock_irqsave(&timer->lock, flags);
 	dmtimer_write(timer, OMAP_TIMER_CTRL_REG, 0);
+	dmtimer_write(timer, OMAP_TIMER_LOAD_REG, timer->load_val);
 	spin_unlock_irqrestore(&timer->lock, flags);
 
 	pm_runtime_put_sync(dev);
@@ -967,7 +1263,6 @@ static int omap_dm_timer_start(struct omap_dm_timer *cookie)
 	unsigned long flags;
 	struct device *dev;
 	int rc;
-	u32 l;
 
 	timer = to_dmtimer(cookie);
 	if (unlikely(!timer))
@@ -980,11 +1275,7 @@ static int omap_dm_timer_start(struct omap_dm_timer *cookie)
 		return rc;
 
 	spin_lock_irqsave(&timer->lock, flags);
-	l = dmtimer_read(timer, OMAP_TIMER_CTRL_REG);
-	if (!(l & OMAP_TIMER_CTRL_ST)) {
-		l |= OMAP_TIMER_CTRL_ST;
-		dmtimer_write(timer, OMAP_TIMER_CTRL_REG, l);
-	}
+	__omap_dm_timer_start(timer, false);
 	spin_unlock_irqrestore(&timer->lock, flags);
 
 	return 0;
@@ -1092,12 +1383,14 @@ static int omap_dm_timer_set_pwm(struct omap_dm_timer *cookie, int def_on,
 	spin_lock_irqsave(&timer->lock, flags);
 	l = dmtimer_read(timer, OMAP_TIMER_CTRL_REG);
 	l &= ~(OMAP_TIMER_CTRL_GPOCFG | OMAP_TIMER_CTRL_SCPWM |
-	       OMAP_TIMER_CTRL_PT | (0x03 << 10) | OMAP_TIMER_CTRL_AR);
+	       OMAP_TIMER_CTRL_PT |
+	       (OMAP_TIMER_CTRL_TRIGGER_MASK << OMAP_TIMER_CTRL_TRIGGER_SHIFT) |
+	       OMAP_TIMER_CTRL_AR);
 	if (def_on)
 		l |= OMAP_TIMER_CTRL_SCPWM;
 	if (toggle)
 		l |= OMAP_TIMER_CTRL_PT;
-	l |= trigger << 10;
+	l |= trigger << OMAP_TIMER_CTRL_TRIGGER_SHIFT;
 	if (autoreload)
 		l |= OMAP_TIMER_CTRL_AR;
 	dmtimer_write(timer, OMAP_TIMER_CTRL_REG, l);
@@ -1399,6 +1692,12 @@ static int omap_dm_timer_probe(struct platform_device *pdev)
 		/* Clear timer configuration */
 		dmtimer_write(timer, OMAP_TIMER_CTRL_REG, 0);
 
+		ret = dmtimer_register_clock(timer);
+		if (ret) {
+			dev_err(dev, "clock provider register failed: %i\n", ret);
+			goto err_put;
+		}
+
 		ret = dmtimer_register_irqchip(timer);
 		if (ret) {
 			dev_err(dev, "irqchip register failed: %i\n", ret);
diff --git a/include/clocksource/timer-ti-dm.h b/include/clocksource/timer-ti-dm.h
--- a/include/clocksource/timer-ti-dm.h
+++ b/include/clocksource/timer-ti-dm.h
@@ -98,6 +98,8 @@ u32 omap_dm_timer_modify_idlect_mask(u32 inputmask);
 #define		OMAP_TIMER_CTRL_GPOCFG		(1 << 14)
 #define		OMAP_TIMER_CTRL_CAPTMODE	(1 << 13)
 #define		OMAP_TIMER_CTRL_PT		(1 << 12)
+#define		OMAP_TIMER_CTRL_TRIGGER_SHIFT	10
+#define		OMAP_TIMER_CTRL_TRIGGER_MASK	3
 #define		OMAP_TIMER_CTRL_TCM_LOWTOHIGH	(0x1 << 8)
 #define		OMAP_TIMER_CTRL_TCM_HIGHTOLOW	(0x2 << 8)
 #define		OMAP_TIMER_CTRL_TCM_BOTHEDGES	(0x3 << 8)
-- 
2.37.3
