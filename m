Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A40326AFD7C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 04:40:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbjCHDky convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 7 Mar 2023 22:40:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbjCHDks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 22:40:48 -0500
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8D4495451;
        Tue,  7 Mar 2023 19:40:40 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 7F67424E320;
        Wed,  8 Mar 2023 11:40:39 +0800 (CST)
Received: from EXMBX061.cuchost.com (172.16.6.61) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 8 Mar
 2023 11:40:39 +0800
Received: from localhost.localdomain (183.27.97.46) by EXMBX061.cuchost.com
 (172.16.6.61) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 8 Mar
 2023 11:40:38 +0800
From:   Xingyu Wu <xingyu.wu@starfivetech.com>
To:     <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-watchdog@vger.kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Conor Dooley <conor@kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Xingyu Wu <xingyu.wu@starfivetech.com>,
        Samin Guo <samin.guo@starfivetech.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 2/3] drivers: watchdog: Add StarFive Watchdog driver
Date:   Wed, 8 Mar 2023 11:40:35 +0800
Message-ID: <20230308034036.99213-3-xingyu.wu@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230308034036.99213-1-xingyu.wu@starfivetech.com>
References: <20230308034036.99213-1-xingyu.wu@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [183.27.97.46]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX061.cuchost.com
 (172.16.6.61)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add watchdog driver for the StarFive JH7100 and JH7110 SoC.

Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
---
 MAINTAINERS                     |   7 +
 drivers/watchdog/Kconfig        |   9 +
 drivers/watchdog/Makefile       |   2 +
 drivers/watchdog/starfive-wdt.c | 675 ++++++++++++++++++++++++++++++++
 4 files changed, 693 insertions(+)
 create mode 100644 drivers/watchdog/starfive-wdt.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 8d5bc223f305..721d0e4e8a0d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19962,6 +19962,13 @@ S:	Supported
 F:	Documentation/devicetree/bindings/rng/starfive*
 F:	drivers/char/hw_random/jh7110-trng.c
 
+STARFIVE WATCHDOG DRIVER
+M:	Xingyu Wu <xingyu.wu@starfivetech.com>
+M:	Samin Guo <samin.guo@starfivetech.com>
+S:	Supported
+F:	Documentation/devicetree/bindings/watchdog/starfive*
+F:	drivers/watchdog/starfive-wdt.c
+
 STATIC BRANCH/CALL
 M:	Peter Zijlstra <peterz@infradead.org>
 M:	Josh Poimboeuf <jpoimboe@kernel.org>
diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index f0872970daf9..9d825ffaf292 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -2090,6 +2090,15 @@ config UML_WATCHDOG
 	tristate "UML watchdog"
 	depends on UML || COMPILE_TEST
 
+config STARFIVE_WATCHDOG
+	tristate "StarFive Watchdog support"
+	depends on ARCH_STARFIVE || COMPILE_TEST
+	select WATCHDOG_CORE
+	default ARCH_STARFIVE
+	help
+	  Say Y here to support the watchdog of StarFive JH7100 and JH7110
+	  SoC. This driver can also be built as a module if choose M.
+
 #
 # ISA-based Watchdog Cards
 #
diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
index 9cbf6580f16c..4c0bd377e92a 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -211,6 +211,8 @@ obj-$(CONFIG_WATCHDOG_SUN4V)		+= sun4v_wdt.o
 # Xen
 obj-$(CONFIG_XEN_WDT) += xen_wdt.o
 
+obj-$(CONFIG_STARFIVE_WATCHDOG) += starfive-wdt.o
+
 # Architecture Independent
 obj-$(CONFIG_BD957XMUF_WATCHDOG) += bd9576_wdt.o
 obj-$(CONFIG_DA9052_WATCHDOG) += da9052_wdt.o
diff --git a/drivers/watchdog/starfive-wdt.c b/drivers/watchdog/starfive-wdt.c
new file mode 100644
index 000000000000..8ce9f985f068
--- /dev/null
+++ b/drivers/watchdog/starfive-wdt.c
@@ -0,0 +1,675 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Starfive Watchdog driver
+ *
+ * Copyright (C) 2022 StarFive Technology Co., Ltd.
+ */
+
+#include <linux/clk.h>
+#include <linux/iopoll.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/reset.h>
+#include <linux/watchdog.h>
+
+/* JH7100 Watchdog register define */
+#define STARFIVE_WDT_JH7100_INTSTAUS	0x000	/* RO: [4]: Watchdog Interrupt status */
+#define STARFIVE_WDT_JH7100_CONTROL	0x104	/* RW: reset enable */
+#define STARFIVE_WDT_JH7100_LOAD	0x108	/* RW: Watchdog Load register */
+#define STARFIVE_WDT_JH7100_EN		0x110	/* RW: Watchdog Enable Register */
+#define STARFIVE_WDT_JH7100_RELOAD	0x114	/* RW: Write 0 or 1 to reload preset value */
+#define STARFIVE_WDT_JH7100_VALUE	0x118	/* RO: The current value for watchdog counter */
+#define STARFIVE_WDT_JH7100_INTCLR	0x120	/*
+						 * RW: Watchdog Clear Interrupt Register
+						 * [0]: Write 1 to clear interrupt
+						 * [1]: 1 mean clearing and 0 mean complete
+						 */
+#define STARFIVE_WDT_JH7100_LOCK	0x13c	/* RW: Lock Register, write 0x378f0765 to unlock */
+
+/* JH7110 Watchdog register define */
+#define STARFIVE_WDT_JH7110_LOAD	0x000	/* RW: Watchdog Load register */
+#define STARFIVE_WDT_JH7110_VALUE	0x004	/* RO: The current value for watchdog counter */
+#define STARFIVE_WDT_JH7110_CONTROL	0x008	/*
+						 * RW:
+						 * [0]: reset enable;
+						 * [1]: int enable/wdt enable/reload counter;
+						 * [31:2]: reserved.
+						 */
+#define STARFIVE_WDT_JH7110_INTCLR	0x00c	/* WO: clear intterupt && reload the counter */
+#define STARFIVE_WDT_JH7110_IMS		0x014	/* RO: Enabled interrupt status from the counter */
+#define STARFIVE_WDT_JH7110_LOCK	0xc00	/* RW: Lock Register, write 0x1ACCE551 to unlock */
+
+/* WDOGCONTROL */
+#define STARFIVE_WDT_ENABLE			0x1
+#define STARFIVE_WDT_EN_SHIFT			0
+#define STARFIVE_WDT_RESET_EN			0x1
+#define STARFIVE_WDT_JH7100_RESEN_SHIFT		0
+#define STARFIVE_WDT_JH7110_RESEN_SHIFT		1
+
+/* WDOGLOCK */
+#define STARFIVE_WDT_LOCKED			BIT(0)
+#define STARFIVE_WDT_JH7100_UNLOCK_KEY		0x378f0765
+#define STARFIVE_WDT_JH7110_UNLOCK_KEY		0x1acce551
+
+/* WDOGINTCLR */
+#define STARFIVE_WDT_INTCLR			0x1
+#define STARFIVE_WDT_JH7100_INTCLR_AVA_SHIFT	1	/* Watchdog can clear interrupt when 0 */
+
+#define STARFIVE_WDT_MAXCNT			0xffffffff
+#define STARFIVE_WDT_DEFAULT_TIME		(15)
+#define STARFIVE_WDT_DELAY_US			0
+#define STARFIVE_WDT_TIMEOUT_US			10000
+
+/* module parameter */
+#define STARFIVE_WDT_EARLY_ENA			0
+
+static bool nowayout = WATCHDOG_NOWAYOUT;
+static int heartbeat;
+static bool early_enable = STARFIVE_WDT_EARLY_ENA;
+
+module_param(heartbeat, int, 0);
+module_param(early_enable, bool, 0);
+module_param(nowayout, bool, 0);
+
+MODULE_PARM_DESC(heartbeat, "Watchdog heartbeat in seconds. (default="
+		 __MODULE_STRING(STARFIVE_WDT_DEFAULT_TIME) ")");
+MODULE_PARM_DESC(early_enable,
+		 "Watchdog is started at boot time if set to 1, default="
+		 __MODULE_STRING(STARFIVE_WDT_EARLY_ENA));
+MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
+		 __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+
+struct starfive_wdt_variant {
+	/* resgister */
+	unsigned int control;
+	unsigned int load;
+	unsigned int reload;
+	unsigned int enable;
+	unsigned int value;
+	unsigned int int_clr;
+	unsigned int unlock;
+	unsigned int int_status;
+
+	u32 unlock_key;
+	u8 enrst_shift;
+	u8 en_shift;
+	bool intclr_check;	/*  whether need to check it before clearing interrupt */
+	u8 intclr_ava_shift;
+	bool double_timeout;	/* The watchdog need twice timeout to reboot */
+};
+
+struct starfive_wdt {
+	unsigned long freq;
+	struct device *dev;
+	struct watchdog_device wdt_device;
+	struct clk *core_clk;
+	struct clk *apb_clk;
+	struct reset_control *rsts;
+	u32 count;	/*count of timeout*/
+	u32 reload;	/*restore the count*/
+	void __iomem *base;
+	spinlock_t lock;	/* spinlock for register handling */
+	const struct starfive_wdt_variant *drv_data;
+};
+
+/* Register layout and configuration for the JH7100 */
+static const struct starfive_wdt_variant drv_data_jh7100 = {
+	.control = STARFIVE_WDT_JH7100_CONTROL,
+	.load = STARFIVE_WDT_JH7100_LOAD,
+	.reload = STARFIVE_WDT_JH7100_RELOAD,
+	.enable = STARFIVE_WDT_JH7100_EN,
+	.value = STARFIVE_WDT_JH7100_VALUE,
+	.int_clr = STARFIVE_WDT_JH7100_INTCLR,
+	.unlock = STARFIVE_WDT_JH7100_LOCK,
+	.unlock_key = STARFIVE_WDT_JH7100_UNLOCK_KEY,
+	.int_status = STARFIVE_WDT_JH7100_INTSTAUS,
+	.enrst_shift = STARFIVE_WDT_JH7100_RESEN_SHIFT,
+	.en_shift = STARFIVE_WDT_EN_SHIFT,
+	.intclr_check = true,
+	.intclr_ava_shift = STARFIVE_WDT_JH7100_INTCLR_AVA_SHIFT,
+	.double_timeout = false,
+};
+
+/* Register layout and configuration for the JH7110 */
+static const struct starfive_wdt_variant drv_data_jh7110 = {
+	.control = STARFIVE_WDT_JH7110_CONTROL,
+	.load = STARFIVE_WDT_JH7110_LOAD,
+	.enable = STARFIVE_WDT_JH7110_CONTROL,
+	.value = STARFIVE_WDT_JH7110_VALUE,
+	.int_clr = STARFIVE_WDT_JH7110_INTCLR,
+	.unlock = STARFIVE_WDT_JH7110_LOCK,
+	.unlock_key = STARFIVE_WDT_JH7110_UNLOCK_KEY,
+	.int_status = STARFIVE_WDT_JH7110_IMS,
+	.enrst_shift = STARFIVE_WDT_JH7110_RESEN_SHIFT,
+	.en_shift = STARFIVE_WDT_EN_SHIFT,
+	.intclr_check = false,
+	.double_timeout = true,
+};
+
+static const struct of_device_id starfive_wdt_match[] = {
+	{ .compatible = "starfive,jh7100-wdt", .data = &drv_data_jh7100 },
+	{ .compatible = "starfive,jh7110-wdt", .data = &drv_data_jh7110 },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, starfive_wdt_match);
+
+static int starfive_wdt_get_clock_rate(struct starfive_wdt *wdt)
+{
+	wdt->freq = clk_get_rate(wdt->core_clk);
+	if (!wdt->freq) {
+		dev_err(wdt->dev, "get clock rate failed.\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int starfive_wdt_enable_clock(struct starfive_wdt *wdt)
+{
+	int ret;
+
+	ret = clk_prepare_enable(wdt->apb_clk);
+	if (ret)
+		return dev_err_probe(wdt->dev, ret, "failed to enable apb_clk.\n");
+
+	ret = clk_prepare_enable(wdt->core_clk);
+	if (ret)
+		return dev_err_probe(wdt->dev, ret, "failed to enable core_clk.\n");
+
+	return 0;
+}
+
+static void starfive_wdt_disable_clock(struct starfive_wdt *wdt)
+{
+	clk_disable_unprepare(wdt->core_clk);
+	clk_disable_unprepare(wdt->apb_clk);
+}
+
+static int starfive_wdt_get_clock(struct starfive_wdt *wdt)
+{
+	wdt->apb_clk = devm_clk_get(wdt->dev, "apb");
+	if (IS_ERR(wdt->apb_clk))
+		return dev_err_probe(wdt->dev, PTR_ERR(wdt->apb_clk),
+				     "failed to get apb clock.\n");
+
+	wdt->core_clk = devm_clk_get(wdt->dev, "core");
+	if (IS_ERR(wdt->core_clk))
+		return dev_err_probe(wdt->dev, PTR_ERR(wdt->core_clk),
+				     "failed to get core clock.\n");
+
+	return 0;
+}
+
+static int starfive_wdt_reset_init(struct starfive_wdt *wdt)
+{
+	int ret;
+
+	wdt->rsts = devm_reset_control_array_get_exclusive(wdt->dev);
+	if (IS_ERR(wdt->rsts))
+		return dev_err_probe(wdt->dev, PTR_ERR(wdt->rsts),
+				     "failed to get resets.\n");
+
+	ret = reset_control_deassert(wdt->rsts);
+	if (ret)
+		return dev_err_probe(wdt->dev, ret,
+				     "failed to deassert resets.\n");
+
+	return 0;
+}
+
+static u32 starfive_wdt_ticks_to_sec(struct starfive_wdt *wdt, u32 ticks)
+{
+	return DIV_ROUND_CLOSEST(ticks, wdt->freq);
+}
+
+/*
+ * Write unlock-key to unlock. Write other value to lock. When lock bit is 1,
+ * external accesses to other watchdog registers are ignored.
+ */
+static bool starfive_wdt_is_locked(struct starfive_wdt *wdt)
+{
+	u32 val;
+
+	val = readl(wdt->base + wdt->drv_data->unlock);
+	return !!(val & STARFIVE_WDT_LOCKED);
+}
+
+static void starfive_wdt_unlock(struct starfive_wdt *wdt)
+{
+	if (starfive_wdt_is_locked(wdt))
+		writel(wdt->drv_data->unlock_key,
+		       wdt->base + wdt->drv_data->unlock);
+}
+
+static void starfive_wdt_lock(struct starfive_wdt *wdt)
+{
+	if (!starfive_wdt_is_locked(wdt))
+		writel(~wdt->drv_data->unlock_key,
+		       wdt->base + wdt->drv_data->unlock);
+}
+
+/* enable watchdog interrupt to reset/reboot */
+static void starfive_wdt_enable_reset(struct starfive_wdt *wdt)
+{
+	u32 val;
+
+	val = readl(wdt->base + wdt->drv_data->control);
+	val |= STARFIVE_WDT_RESET_EN << wdt->drv_data->enrst_shift;
+	writel(val, wdt->base + wdt->drv_data->control);
+}
+
+/* interrupt status whether has been raised from the counter */
+static bool starfive_wdt_raise_irq_status(struct starfive_wdt *wdt)
+{
+	return !!readl(wdt->base + wdt->drv_data->int_status);
+}
+
+/* waiting interrupt can be free to clear */
+static int starfive_wdt_wait_int_free(struct starfive_wdt *wdt)
+{
+	u32 value;
+
+	value = readl(wdt->base + wdt->drv_data->int_clr);
+	return readl_poll_timeout_atomic(wdt->base + wdt->drv_data->int_clr, value,
+					 !(value & BIT(wdt->drv_data->intclr_ava_shift)),
+					 STARFIVE_WDT_DELAY_US, STARFIVE_WDT_TIMEOUT_US);
+}
+
+/* clear interrupt signal before initialization or reload */
+static int starfive_wdt_int_clr(struct starfive_wdt *wdt)
+{
+	int ret;
+
+	if (wdt->drv_data->intclr_check) {
+		ret = starfive_wdt_wait_int_free(wdt);
+		if (ret)
+			return dev_err_probe(wdt->dev, ret,
+					     "watchdog is not ready to clear interrupt.\n");
+	}
+	writel(STARFIVE_WDT_INTCLR, wdt->base + wdt->drv_data->int_clr);
+
+	return 0;
+}
+
+static inline void starfive_wdt_set_count(struct starfive_wdt *wdt, u32 val)
+{
+	writel(val, wdt->base + wdt->drv_data->load);
+}
+
+static inline u32 starfive_wdt_get_count(struct starfive_wdt *wdt)
+{
+	return readl(wdt->base + wdt->drv_data->value);
+}
+
+/* enable watchdog */
+static inline void starfive_wdt_enable(struct starfive_wdt *wdt)
+{
+	u32 val;
+
+	val = readl(wdt->base + wdt->drv_data->enable);
+	val |= STARFIVE_WDT_ENABLE << wdt->drv_data->en_shift;
+	writel(val, wdt->base + wdt->drv_data->enable);
+}
+
+/* disable watchdog */
+static inline void starfive_wdt_disable(struct starfive_wdt *wdt)
+{
+	u32 val;
+
+	val = readl(wdt->base + wdt->drv_data->enable);
+	val &= ~(STARFIVE_WDT_ENABLE << wdt->drv_data->en_shift);
+	writel(val, wdt->base + wdt->drv_data->enable);
+}
+
+static inline void starfive_wdt_set_reload_count(struct starfive_wdt *wdt, u32 count)
+{
+	starfive_wdt_set_count(wdt, count);
+
+	/* 7100 need set any value to reload register and could reload value to counter */
+	if (wdt->drv_data->reload)
+		writel(0x1, wdt->base + wdt->drv_data->reload);
+}
+
+static unsigned int starfive_wdt_max_timeout(struct starfive_wdt *wdt)
+{
+	unsigned int timeout_num = wdt->drv_data->double_timeout ? 2 : 1;
+
+	return DIV_ROUND_UP(STARFIVE_WDT_MAXCNT, (wdt->freq / timeout_num)) - 1;
+}
+
+static unsigned int starfive_wdt_get_timeleft(struct watchdog_device *wdd)
+{
+	struct starfive_wdt *wdt = watchdog_get_drvdata(wdd);
+	u32 count;
+
+	starfive_wdt_unlock(wdt);
+	/*
+	 * If the watchdog takes twice timeout and set half count value,
+	 * timeleft value should add the count value before first timeout.
+	 */
+	count = starfive_wdt_get_count(wdt);
+	if (wdt->drv_data->double_timeout && !starfive_wdt_raise_irq_status(wdt))
+		count += wdt->count;
+
+	starfive_wdt_lock(wdt);
+
+	return starfive_wdt_ticks_to_sec(wdt, count);
+}
+
+static int starfive_wdt_keepalive(struct watchdog_device *wdd)
+{
+	struct starfive_wdt *wdt = watchdog_get_drvdata(wdd);
+	int ret;
+
+	spin_lock(&wdt->lock);
+
+	starfive_wdt_unlock(wdt);
+	ret = starfive_wdt_int_clr(wdt);
+	if (ret)
+		return ret;
+
+	starfive_wdt_set_reload_count(wdt, wdt->count);
+	starfive_wdt_lock(wdt);
+
+	spin_unlock(&wdt->lock);
+
+	return 0;
+}
+
+static int starfive_wdt_stop(struct watchdog_device *wdd)
+{
+	struct starfive_wdt *wdt = watchdog_get_drvdata(wdd);
+
+	spin_lock(&wdt->lock);
+
+	starfive_wdt_unlock(wdt);
+	starfive_wdt_disable(wdt);
+	starfive_wdt_lock(wdt);
+
+	spin_unlock(&wdt->lock);
+
+	return 0;
+}
+
+static int starfive_wdt_pm_stop(struct watchdog_device *wdd)
+{
+	struct starfive_wdt *wdt = watchdog_get_drvdata(wdd);
+
+	starfive_wdt_stop(wdd);
+	pm_runtime_put_sync(wdt->dev);
+
+	return 0;
+}
+
+static int starfive_wdt_start(struct watchdog_device *wdd)
+{
+	struct starfive_wdt *wdt = watchdog_get_drvdata(wdd);
+	int ret;
+
+	spin_lock(&wdt->lock);
+	starfive_wdt_unlock(wdt);
+	/* disable watchdog, to be safe */
+	starfive_wdt_disable(wdt);
+
+	starfive_wdt_enable_reset(wdt);
+	ret = starfive_wdt_int_clr(wdt);
+	if (ret)
+		return ret;
+
+	starfive_wdt_set_count(wdt, wdt->count);
+	starfive_wdt_enable(wdt);
+
+	starfive_wdt_lock(wdt);
+	spin_unlock(&wdt->lock);
+
+	return 0;
+}
+
+static int starfive_wdt_pm_start(struct watchdog_device *wdd)
+{
+	struct starfive_wdt *wdt = watchdog_get_drvdata(wdd);
+
+	pm_runtime_get_sync(wdt->dev);
+
+	return starfive_wdt_start(wdd);
+}
+
+static int starfive_wdt_set_timeout(struct watchdog_device *wdd,
+				    unsigned int timeout)
+{
+	struct starfive_wdt *wdt = watchdog_get_drvdata(wdd);
+	unsigned long freq = wdt->freq;
+	unsigned int timeout_num = wdt->drv_data->double_timeout ? 2 : 1;
+
+	spin_lock(&wdt->lock);
+
+	/*
+	 * This watchdog takes twice timeouts to reset.
+	 * In order to reduce time to reset, should set half count value.
+	 */
+	wdt->count = timeout * freq / timeout_num;
+	wdd->timeout = timeout;
+
+	starfive_wdt_unlock(wdt);
+	starfive_wdt_disable(wdt);
+	starfive_wdt_set_reload_count(wdt, wdt->count);
+	starfive_wdt_enable(wdt);
+	starfive_wdt_lock(wdt);
+
+	spin_unlock(&wdt->lock);
+
+	return 0;
+}
+
+#define OPTIONS (WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE)
+
+static const struct watchdog_info starfive_wdt_ident = {
+	.options = OPTIONS,
+	.identity = "StarFive Watchdog",
+};
+
+static const struct watchdog_ops starfive_wdt_ops = {
+	.owner = THIS_MODULE,
+	.start = starfive_wdt_pm_start,
+	.stop = starfive_wdt_pm_stop,
+	.ping = starfive_wdt_keepalive,
+	.set_timeout = starfive_wdt_set_timeout,
+	.get_timeleft = starfive_wdt_get_timeleft,
+};
+
+static const struct watchdog_device starfive_wdd = {
+	.info = &starfive_wdt_ident,
+	.ops = &starfive_wdt_ops,
+	.timeout = STARFIVE_WDT_DEFAULT_TIME,
+};
+
+static int starfive_wdt_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct starfive_wdt *wdt;
+	int ret;
+
+	wdt = devm_kzalloc(dev, sizeof(*wdt), GFP_KERNEL);
+	if (!wdt)
+		return -ENOMEM;
+
+	wdt->dev = dev;
+	spin_lock_init(&wdt->lock);
+	wdt->wdt_device = starfive_wdd;
+	wdt->drv_data = of_device_get_match_data(&pdev->dev);
+
+	/* get the memory region for the watchdog timer */
+	wdt->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(wdt->base)) {
+		ret = PTR_ERR(wdt->base);
+		return ret;
+	}
+
+	platform_set_drvdata(pdev, wdt);
+	pm_runtime_enable(wdt->dev);
+
+	ret = starfive_wdt_get_clock(wdt);
+	if (ret)
+		return ret;
+
+	if (pm_runtime_enabled(wdt->dev)) {
+		ret = pm_runtime_get_sync(wdt->dev);
+		if (ret < 0)
+			return ret;
+	} else {
+		/* runtime PM is disabled but clocks need to be enabled */
+		ret = starfive_wdt_enable_clock(wdt);
+		if (ret)
+			return ret;
+	}
+
+	ret = starfive_wdt_get_clock_rate(wdt);
+	if (ret)
+		goto err_exit;
+
+	ret = starfive_wdt_reset_init(wdt);
+	if (ret)
+		goto err_exit;
+
+	wdt->wdt_device.min_timeout = 1;
+	wdt->wdt_device.max_timeout = starfive_wdt_max_timeout(wdt);
+
+	watchdog_set_drvdata(&wdt->wdt_device, wdt);
+
+	wdt->wdt_device.timeout = STARFIVE_WDT_DEFAULT_TIME;
+	watchdog_init_timeout(&wdt->wdt_device, heartbeat, dev);
+	starfive_wdt_set_timeout(&wdt->wdt_device, wdt->wdt_device.timeout);
+
+	watchdog_set_nowayout(&wdt->wdt_device, nowayout);
+	watchdog_stop_on_reboot(&wdt->wdt_device);
+	watchdog_stop_on_unregister(&wdt->wdt_device);
+
+	wdt->wdt_device.parent = dev;
+
+	if (early_enable) {
+		starfive_wdt_start(&wdt->wdt_device);
+		set_bit(WDOG_HW_RUNNING, &wdt->wdt_device.status);
+	} else {
+		starfive_wdt_stop(&wdt->wdt_device);
+	}
+
+	ret = watchdog_register_device(&wdt->wdt_device);
+	if (ret)
+		goto err_exit;
+
+	if (!early_enable)
+		pm_runtime_put_sync(wdt->dev);
+
+	return 0;
+
+err_exit:
+	starfive_wdt_disable_clock(wdt);
+	pm_runtime_disable(wdt->dev);
+
+	return ret;
+}
+
+static int starfive_wdt_remove(struct platform_device *dev)
+{
+	struct starfive_wdt *wdt = platform_get_drvdata(dev);
+
+	starfive_wdt_stop(&wdt->wdt_device);
+	watchdog_unregister_device(&wdt->wdt_device);
+
+	if (pm_runtime_enabled(wdt->dev))
+		pm_runtime_disable(wdt->dev);
+	else
+		/* disable clock without PM */
+		starfive_wdt_disable_clock(wdt);
+
+	return 0;
+}
+
+static void starfive_wdt_shutdown(struct platform_device *dev)
+{
+	struct starfive_wdt *wdt = platform_get_drvdata(dev);
+
+	starfive_wdt_pm_stop(&wdt->wdt_device);
+}
+
+#ifdef CONFIG_PM_SLEEP
+static int starfive_wdt_suspend(struct device *dev)
+{
+	int ret;
+	struct starfive_wdt *wdt = dev_get_drvdata(dev);
+
+	starfive_wdt_unlock(wdt);
+
+	/* Save watchdog state, and turn it off. */
+	wdt->reload = starfive_wdt_get_count(wdt);
+
+	/* Note that WTCNT doesn't need to be saved. */
+	starfive_wdt_stop(&wdt->wdt_device);
+	pm_runtime_force_suspend(dev);
+
+	starfive_wdt_lock(wdt);
+
+	return 0;
+}
+
+static int starfive_wdt_resume(struct device *dev)
+{
+	int ret;
+	struct starfive_wdt *wdt = dev_get_drvdata(dev);
+
+	starfive_wdt_unlock(wdt);
+
+	pm_runtime_force_resume(dev);
+
+	/* Restore watchdog state. */
+	starfive_wdt_set_reload_count(wdt, wdt->reload);
+
+	starfive_wdt_start(&wdt->wdt_device);
+
+	starfive_wdt_lock(wdt);
+
+	return 0;
+}
+#endif /* CONFIG_PM_SLEEP */
+
+#ifdef CONFIG_PM
+static int starfive_wdt_runtime_suspend(struct device *dev)
+{
+	struct starfive_wdt *wdt = dev_get_drvdata(dev);
+
+	starfive_wdt_disable_clock(wdt);
+
+	return 0;
+}
+
+static int starfive_wdt_runtime_resume(struct device *dev)
+{
+	struct starfive_wdt *wdt = dev_get_drvdata(dev);
+
+	return starfive_wdt_enable_clock(wdt);
+}
+#endif /* CONFIG_PM */
+
+static const struct dev_pm_ops starfive_wdt_pm_ops = {
+	SET_RUNTIME_PM_OPS(starfive_wdt_runtime_suspend, starfive_wdt_runtime_resume, NULL)
+	SET_SYSTEM_SLEEP_PM_OPS(starfive_wdt_suspend, starfive_wdt_resume)
+};
+
+static struct platform_driver starfive_wdt_driver = {
+	.probe		= starfive_wdt_probe,
+	.remove		= starfive_wdt_remove,
+	.shutdown	= starfive_wdt_shutdown,
+	.driver		= {
+		.name	= "starfive-wdt",
+		.pm	= &starfive_wdt_pm_ops,
+		.of_match_table = of_match_ptr(starfive_wdt_match),
+	},
+};
+
+module_platform_driver(starfive_wdt_driver);
+
+MODULE_AUTHOR("Xingyu Wu <xingyu.wu@starfivetech.com>");
+MODULE_AUTHOR("Samin Guo <samin.guo@starfivetech.com>");
+MODULE_DESCRIPTION("StarFive Watchdog Device Driver");
+MODULE_LICENSE("GPL");
-- 
2.25.1

