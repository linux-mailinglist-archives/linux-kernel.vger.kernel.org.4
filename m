Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B33AF650976
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 10:43:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231455AbiLSJnE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 19 Dec 2022 04:43:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231344AbiLSJms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 04:42:48 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2920B959F;
        Mon, 19 Dec 2022 01:42:43 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 5A8A824E1CE;
        Mon, 19 Dec 2022 17:42:41 +0800 (CST)
Received: from EXMBX161.cuchost.com (172.16.6.71) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 19 Dec
 2022 17:42:41 +0800
Received: from localhost.localdomain (183.27.97.120) by EXMBX161.cuchost.com
 (172.16.6.71) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 19 Dec
 2022 17:42:40 +0800
From:   Xingyu Wu <xingyu.wu@starfivetech.com>
To:     <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-watchdog@vger.kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Xingyu Wu <xingyu.wu@starfivetech.com>,
        Samin Guo <samin.guo@starfivetech.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/3] drivers: watchdog: Add StarFive Watchdog driver
Date:   Mon, 19 Dec 2022 17:42:32 +0800
Message-ID: <20221219094233.179153-3-xingyu.wu@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221219094233.179153-1-xingyu.wu@starfivetech.com>
References: <20221219094233.179153-1-xingyu.wu@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [183.27.97.120]
X-ClientProxiedBy: EXCAS064.cuchost.com (172.16.6.24) To EXMBX161.cuchost.com
 (172.16.6.71)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add watchdog driver for the StarFive JH7110 SoC.

Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
---
 MAINTAINERS                     |   7 +
 drivers/watchdog/Kconfig        |  11 +
 drivers/watchdog/Makefile       |   3 +
 drivers/watchdog/starfive-wdt.c | 720 ++++++++++++++++++++++++++++++++
 4 files changed, 741 insertions(+)
 create mode 100644 drivers/watchdog/starfive-wdt.c

diff --git a/MAINTAINERS b/MAINTAINERS
index a70c1d0f303e..9c1758e7d034 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19623,6 +19623,13 @@ F:	Documentation/devicetree/bindings/reset/starfive,jh7100-reset.yaml
 F:	drivers/reset/starfive/
 F:	include/dt-bindings/reset/starfive*
 
+STARFIVE JH7110 WATCHDOG DRIVER
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
index b64bc49c7f30..8eeb0e23e98d 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -2082,6 +2082,17 @@ config UML_WATCHDOG
 	tristate "UML watchdog"
 	depends on UML || COMPILE_TEST
 
+# RISCV Architecture
+
+config STARFIVE_WATCHDOG
+	tristate "StarFive Watchdog support"
+	depends on RISCV
+	select WATCHDOG_CORE
+	default SOC_STARFIVE
+	help
+	  Say Y here to support the watchdog of StarFive JH7110 SoC.
+	  This driver can also be built as a module if choose M.
+
 #
 # ISA-based Watchdog Cards
 #
diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
index d41e5f830ae7..9c22f1a43d5c 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -210,6 +210,9 @@ obj-$(CONFIG_WATCHDOG_SUN4V)		+= sun4v_wdt.o
 # Xen
 obj-$(CONFIG_XEN_WDT) += xen_wdt.o
 
+# RISCV Architecture
+obj-$(CONFIG_STARFIVE_WATCHDOG) += starfive-wdt.o
+
 # Architecture Independent
 obj-$(CONFIG_BD957XMUF_WATCHDOG) += bd9576_wdt.o
 obj-$(CONFIG_DA9052_WATCHDOG) += da9052_wdt.o
diff --git a/drivers/watchdog/starfive-wdt.c b/drivers/watchdog/starfive-wdt.c
new file mode 100644
index 000000000000..d7fad0a2207c
--- /dev/null
+++ b/drivers/watchdog/starfive-wdt.c
@@ -0,0 +1,720 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Starfive Watchdog driver
+ *
+ * Copyright (C) 2022 StarFive Technology Co., Ltd.
+ */
+
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/reset.h>
+#include <linux/reset-controller.h>
+#include <linux/slab.h>
+#include <linux/timer.h>
+#include <linux/types.h>
+#include <linux/uaccess.h>
+#include <linux/watchdog.h>
+
+/* JH7110 WatchDog register define */
+#define STARFIVE_WDT_JH7110_LOAD	0x000	/* RW: Watchdog load register */
+#define STARFIVE_WDT_JH7110_VALUE	0x004	/* RO: The current value for the watchdog counter */
+#define STARFIVE_WDT_JH7110_CONTROL	0x008	/*
+						 * RW:
+						 * [0]: reset enable;
+						 * [1]: int enable/wdt enable/reload counter;
+						 * [31:2]: reserve.
+						 */
+#define STARFIVE_WDT_JH7110_INTCLR	0x00c	/* WO: clear intterupt && reload the counter */
+#define STARFIVE_WDT_JH7110_RIS		0x010	/* RO: Raw interrupt status from the counter */
+#define STARFIVE_WDT_JH7110_IMS		0x014	/* RO: Enabled interrupt status from the counter */
+#define STARFIVE_WDT_JH7110_LOCK	0xc00	/*
+						 * RO: Enable write access to all other registers
+						 * by writing 0x1ACCE551.
+						 */
+
+#define STARFIVE_WDT_JH7110_UNLOCK_KEY		0x1acce551
+#define STARFIVE_WDT_JH7110_RESEN_SHIFT		1
+#define STARFIVE_WDT_JH7110_EN_SHIFT		0
+
+/* WDOGCONTROL */
+#define STARFIVE_WDT_ENABLE	0x1
+#define STARFIVE_WDT_RESET_EN	0x1
+
+/* WDOGLOCK */
+#define STARFIVE_WDT_LOCKED	BIT(0)
+
+/* WDOGINTCLR */
+#define STARFIVE_WDT_INTCLR	0x1
+
+#define STARFIVE_WDT_ATBOOT	0x0
+#define STARFIVE_WDT_MAXCNT	0xffffffff
+
+#define STARFIVE_WDT_DEFAULT_TIME	(15)
+#define STARFIVE_WDT_DELAY_US		0
+#define STARFIVE_WDT_TIMEOUT_US		10000
+
+static bool nowayout = WATCHDOG_NOWAYOUT;
+static int tmr_margin;
+static int tmr_atboot = STARFIVE_WDT_ATBOOT;
+static int soft_noboot;
+
+module_param(tmr_margin, int, 0);
+module_param(tmr_atboot, int, 0);
+module_param(nowayout, bool, 0);
+module_param(soft_noboot, int, 0);
+
+MODULE_PARM_DESC(tmr_margin, "Watchdog tmr_margin in seconds. (default="
+		 __MODULE_STRING(STARFIVE_WDT_DEFAULT_TIME) ")");
+MODULE_PARM_DESC(tmr_atboot,
+		 "Watchdog is started at boot time if set to 1, default="
+		 __MODULE_STRING(STARFIVE_WDT_ATBOOT));
+MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
+		 __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+MODULE_PARM_DESC(soft_noboot,
+		 "Watchdog action, set to 1 to ignore reboots, 0 to reboot (default 0)");
+
+struct starfive_wdt_variant {
+	u32 control;
+	u32 load;
+	u32 enable;
+	u32 value;
+	u32 int_clr;
+	u32 unlock;
+	u32 unlock_key;
+	u32 irq_is_raise;
+	u8 enrst_shift;
+	u8 en_shift;
+};
+
+struct starfive_wdt {
+	unsigned long freq;
+	struct device *dev;
+	struct watchdog_device wdt_device;
+	struct clk *core_clk;
+	struct clk *apb_clk;
+	struct reset_control *rsts;
+	const struct starfive_wdt_variant *drv_data;
+	u32 count;	/*count of timeout*/
+	u32 reload;	/*restore the count*/
+	void __iomem *base;
+	spinlock_t lock;	/* spinlock for register handling */
+};
+
+#ifdef CONFIG_OF
+/* Register bias in JH7110 */
+static const struct starfive_wdt_variant drv_data_jh7110 = {
+	.control = STARFIVE_WDT_JH7110_CONTROL,
+	.load = STARFIVE_WDT_JH7110_LOAD,
+	.enable = STARFIVE_WDT_JH7110_CONTROL,
+	.value = STARFIVE_WDT_JH7110_VALUE,
+	.int_clr = STARFIVE_WDT_JH7110_INTCLR,
+	.unlock = STARFIVE_WDT_JH7110_LOCK,
+	.unlock_key = STARFIVE_WDT_JH7110_UNLOCK_KEY,
+	.irq_is_raise = STARFIVE_WDT_JH7110_IMS,
+	.enrst_shift = STARFIVE_WDT_JH7110_RESEN_SHIFT,
+	.en_shift = STARFIVE_WDT_JH7110_EN_SHIFT,
+};
+
+static const struct of_device_id starfive_wdt_match[] = {
+	{ .compatible = "starfive,jh7110-wdt", .data = &drv_data_jh7110 },
+	{}
+};
+MODULE_DEVICE_TABLE(of, starfive_wdt_match);
+#endif
+
+static const struct platform_device_id starfive_wdt_ids[] = {
+	{
+		.name = "starfive-jh7110-wdt",
+		.driver_data = (unsigned long)&drv_data_jh7110,
+	},
+	{}
+};
+MODULE_DEVICE_TABLE(platform, starfive_wdt_ids);
+
+static int starfive_wdt_get_clock_rate(struct starfive_wdt *wdt)
+{
+	if (!IS_ERR(wdt->core_clk)) {
+		wdt->freq = clk_get_rate(wdt->core_clk);
+		return 0;
+	}
+	dev_err(wdt->dev, "get clock rate failed.\n");
+
+	return -ENOENT;
+}
+
+static int starfive_wdt_enable_clock(struct starfive_wdt *wdt)
+{
+	int ret = 0;
+
+	wdt->apb_clk = devm_clk_get_enabled(wdt->dev, "apb");
+	if (IS_ERR(wdt->apb_clk)) {
+		dev_err(wdt->dev, "failed to get and enable apb clock.\n");
+		ret = PTR_ERR(wdt->apb_clk);
+		return ret;
+	}
+
+	wdt->core_clk = devm_clk_get_enabled(wdt->dev, "core");
+	if (IS_ERR(wdt->core_clk)) {
+		dev_err(wdt->dev, "failed to get and enable core clock.\n");
+		ret = PTR_ERR(wdt->core_clk);
+	}
+
+	return ret;
+}
+
+static int starfive_wdt_reset_init(struct starfive_wdt *wdt)
+{
+	int ret = 0;
+
+	wdt->rsts = devm_reset_control_array_get_exclusive(wdt->dev);
+	if (!IS_ERR(wdt->rsts)) {
+		ret = reset_control_deassert(wdt->rsts);
+		if (ret)
+			dev_err(wdt->dev, "failed to deassert rsts.\n");
+	} else {
+		dev_err(wdt->dev, "failed to get rsts error.\n");
+		ret = PTR_ERR(wdt->rsts);
+	}
+
+	return ret;
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
+/* enable watchdog interrupt to reset */
+static void starfive_wdt_enable_reset(struct starfive_wdt *wdt)
+{
+	u32 val;
+
+	val = readl(wdt->base + wdt->drv_data->control);
+	val |= STARFIVE_WDT_RESET_EN << wdt->drv_data->enrst_shift;
+	writel(val, wdt->base + wdt->drv_data->control);
+}
+
+/* disable watchdog interrupt to reset */
+static void starfive_wdt_disable_reset(struct starfive_wdt *wdt)
+{
+	u32 val;
+
+	val = readl(wdt->base + wdt->drv_data->control);
+	val &= ~(STARFIVE_WDT_RESET_EN << wdt->drv_data->enrst_shift);
+	writel(val, wdt->base + wdt->drv_data->control);
+}
+
+/* interrupt status whether has been raised from the counter */
+static bool starfive_wdt_raise_irq_status(struct starfive_wdt *wdt)
+{
+	return !!readl(wdt->base + wdt->drv_data->irq_is_raise);
+}
+
+static void starfive_wdt_int_clr(struct starfive_wdt *wdt)
+{
+	writel(STARFIVE_WDT_INTCLR, wdt->base + wdt->drv_data->int_clr);
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
+static inline void starfive_wdt_enable(struct starfive_wdt *wdt)
+{
+	u32 val;
+
+	val = readl(wdt->base + wdt->drv_data->enable);
+	val |= STARFIVE_WDT_ENABLE << wdt->drv_data->en_shift;
+	writel(val, wdt->base + wdt->drv_data->enable);
+}
+
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
+	/* need enable controller to reload counter */
+	starfive_wdt_enable(wdt);
+}
+
+static void starfive_wdt_mask_and_disable_reset(struct starfive_wdt *wdt, bool mask)
+{
+	starfive_wdt_unlock(wdt);
+
+	if (mask)
+		starfive_wdt_disable_reset(wdt);
+	else
+		starfive_wdt_enable_reset(wdt);
+
+	starfive_wdt_lock(wdt);
+}
+
+static unsigned int starfive_wdt_max_timeout(struct starfive_wdt *wdt)
+{
+	return DIV_ROUND_UP(STARFIVE_WDT_MAXCNT, wdt->freq) - 1;
+}
+
+static unsigned int starfive_wdt_get_timeleft(struct watchdog_device *wdd)
+{
+	struct starfive_wdt *wdt = watchdog_get_drvdata(wdd);
+	u32 count;
+
+	starfive_wdt_unlock(wdt);
+	/*
+	 * Because set half count value,
+	 * timeleft value should add the count value before first timeout.
+	 */
+	count = starfive_wdt_get_count(wdt);
+	if (!starfive_wdt_raise_irq_status(wdt))
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
+
+	spin_lock(&wdt->lock);
+
+	starfive_wdt_unlock(wdt);
+	starfive_wdt_int_clr(wdt);
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
+	starfive_wdt_int_clr(wdt);
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
+	pm_runtime_put(wdt->dev);
+
+	return 0;
+}
+
+static int starfive_wdt_start(struct watchdog_device *wdd)
+{
+	struct starfive_wdt *wdt = watchdog_get_drvdata(wdd);
+
+	pm_runtime_get_sync(wdt->dev);
+
+	spin_lock(&wdt->lock);
+
+	starfive_wdt_unlock(wdt);
+
+	if (soft_noboot)
+		starfive_wdt_disable_reset(wdt);
+	else
+		starfive_wdt_enable_reset(wdt);
+
+	starfive_wdt_int_clr(wdt);
+	starfive_wdt_set_count(wdt, wdt->count);
+	starfive_wdt_enable(wdt);
+
+	starfive_wdt_lock(wdt);
+
+	spin_unlock(&wdt->lock);
+
+	return 0;
+}
+
+static int starfive_wdt_restart(struct watchdog_device *wdd, unsigned long action,
+				void *data)
+{
+	struct starfive_wdt *wdt = watchdog_get_drvdata(wdd);
+
+	spin_lock(&wdt->lock);
+	starfive_wdt_unlock(wdt);
+	/* disable watchdog, to be safe */
+	starfive_wdt_disable(wdt);
+
+	if (soft_noboot)
+		starfive_wdt_disable_reset(wdt);
+	else
+		starfive_wdt_enable_reset(wdt);
+
+	/* put native values into count */
+	starfive_wdt_set_count(wdt, wdt->count);
+
+	/* set the watchdog to go and reset */
+	starfive_wdt_int_clr(wdt);
+	starfive_wdt_enable(wdt);
+
+	starfive_wdt_lock(wdt);
+	spin_unlock(&wdt->lock);
+
+	return 0;
+}
+
+static int starfive_wdt_set_timeout(struct watchdog_device *wdd,
+				    unsigned int timeout)
+{
+	struct starfive_wdt *wdt = watchdog_get_drvdata(wdd);
+
+	unsigned long freq = wdt->freq;
+	unsigned int count;
+
+	spin_lock(&wdt->lock);
+
+	if (timeout < wdt->wdt_device.min_timeout)
+		return -EINVAL;
+
+	/*
+	 * This watchdog takes twice timeouts to reset.
+	 * In order to reduce time to reset, should set half count value.
+	 */
+	count = timeout * freq / 2;
+
+	if (count > STARFIVE_WDT_MAXCNT) {
+		dev_warn(wdt->dev, "timeout %d too big,use the MAX-timeout set.\n",
+			 timeout);
+		timeout = starfive_wdt_max_timeout(wdt);
+		count = timeout * freq;
+	}
+
+	dev_info(wdt->dev, "Heartbeat: timeout=%d, count/2=%d (%08x)\n",
+		 timeout, count, count);
+
+	starfive_wdt_unlock(wdt);
+	starfive_wdt_disable(wdt);
+	starfive_wdt_set_reload_count(wdt, count);
+	starfive_wdt_enable(wdt);
+	starfive_wdt_lock(wdt);
+
+	wdt->count = count;
+	wdd->timeout = timeout;
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
+	.firmware_version = 0,
+	.identity = "StarFive Watchdog",
+};
+
+static const struct watchdog_ops starfive_wdt_ops = {
+	.owner = THIS_MODULE,
+	.start = starfive_wdt_start,
+	.stop = starfive_wdt_pm_stop,
+	.ping = starfive_wdt_keepalive,
+	.set_timeout = starfive_wdt_set_timeout,
+	.restart = starfive_wdt_restart,
+	.get_timeleft = starfive_wdt_get_timeleft,
+};
+
+static const struct watchdog_device starfive_wdd = {
+	.info = &starfive_wdt_ident,
+	.ops = &starfive_wdt_ops,
+	.timeout = STARFIVE_WDT_DEFAULT_TIME,
+};
+
+static inline const struct starfive_wdt_variant *
+starfive_wdt_get_drv_data(struct platform_device *pdev)
+{
+	const struct starfive_wdt_variant *variant;
+
+	variant = of_device_get_match_data(&pdev->dev);
+	if (!variant) {
+		/* Device matched by platform_device_id */
+		variant = (struct starfive_wdt_variant *)
+			   platform_get_device_id(pdev)->driver_data;
+	}
+
+	return variant;
+}
+
+static int starfive_wdt_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct starfive_wdt *wdt;
+	int started = 0;
+	int ret;
+
+	pm_runtime_enable(dev);
+
+	wdt = devm_kzalloc(dev, sizeof(*wdt), GFP_KERNEL);
+	if (!wdt)
+		return -ENOMEM;
+
+	wdt->dev = dev;
+	spin_lock_init(&wdt->lock);
+	wdt->wdt_device = starfive_wdd;
+
+	wdt->drv_data = starfive_wdt_get_drv_data(pdev);
+
+	/* get the memory region for the watchdog timer */
+	wdt->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(wdt->base)) {
+		ret = PTR_ERR(wdt->base);
+		return ret;
+	}
+
+	ret = starfive_wdt_enable_clock(wdt);
+	if (ret)
+		return ret;
+
+	ret = starfive_wdt_get_clock_rate(wdt);
+	if (ret)
+		goto err_clk_disable;
+
+	ret = starfive_wdt_reset_init(wdt);
+	if (ret)
+		goto err_clk_disable;
+
+	wdt->wdt_device.min_timeout = 1;
+	wdt->wdt_device.max_timeout = starfive_wdt_max_timeout(wdt);
+
+	watchdog_set_drvdata(&wdt->wdt_device, wdt);
+
+	/*
+	 * see if we can actually set the requested timer margin,
+	 * and if not, try the default value.
+	 */
+	watchdog_init_timeout(&wdt->wdt_device, tmr_margin, dev);
+
+	ret = starfive_wdt_set_timeout(&wdt->wdt_device,
+				       wdt->wdt_device.timeout);
+	if (ret) {
+		dev_err(dev, "tmr_margin value out of range, default %d used\n",
+			STARFIVE_WDT_DEFAULT_TIME);
+		starfive_wdt_set_timeout(&wdt->wdt_device,
+					 STARFIVE_WDT_DEFAULT_TIME);
+	}
+
+	watchdog_set_nowayout(&wdt->wdt_device, nowayout);
+	watchdog_set_restart_priority(&wdt->wdt_device, 128);
+	watchdog_stop_on_reboot(&wdt->wdt_device);
+	watchdog_stop_on_unregister(&wdt->wdt_device);
+
+	wdt->wdt_device.parent = dev;
+
+	ret = watchdog_register_device(&wdt->wdt_device);
+	if (ret)
+		goto err_clk_disable;
+
+	starfive_wdt_mask_and_disable_reset(wdt, false);
+
+	if (tmr_atboot && started == 0) {
+		starfive_wdt_start(&wdt->wdt_device);
+	} else if (!tmr_atboot) {
+		/*
+		 *if we're not enabling the watchdog, then ensure it is
+		 * disabled if it has been left running from the bootloader
+		 * or other source.
+		 */
+		starfive_wdt_stop(&wdt->wdt_device);
+	}
+
+#ifdef CONFIG_PM
+	clk_disable_unprepare(wdt->core_clk);
+	clk_disable_unprepare(wdt->apb_clk);
+#endif
+
+	platform_set_drvdata(pdev, wdt);
+
+	return 0;
+
+err_clk_disable:
+	clk_disable_unprepare(wdt->core_clk);
+	clk_disable_unprepare(wdt->apb_clk);
+
+	return ret;
+}
+
+static int starfive_wdt_remove(struct platform_device *dev)
+{
+	struct starfive_wdt *wdt = platform_get_drvdata(dev);
+
+	starfive_wdt_mask_and_disable_reset(wdt, true);
+	watchdog_unregister_device(&wdt->wdt_device);
+
+	clk_disable_unprepare(wdt->core_clk);
+	clk_disable_unprepare(wdt->apb_clk);
+	pm_runtime_disable(wdt->dev);
+
+	return 0;
+}
+
+static void starfive_wdt_shutdown(struct platform_device *dev)
+{
+	struct starfive_wdt *wdt = platform_get_drvdata(dev);
+
+	starfive_wdt_mask_and_disable_reset(wdt, true);
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
+	starfive_wdt_mask_and_disable_reset(wdt, true);
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
+	starfive_wdt_restart(&wdt->wdt_device, 0, NULL);
+
+	starfive_wdt_mask_and_disable_reset(wdt, false);
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
+	clk_disable_unprepare(wdt->apb_clk);
+	clk_disable_unprepare(wdt->core_clk);
+
+	return 0;
+}
+
+static int starfive_wdt_runtime_resume(struct device *dev)
+{
+	struct starfive_wdt *wdt = dev_get_drvdata(dev);
+	int ret;
+
+	ret = clk_prepare_enable(wdt->apb_clk);
+	if (ret) {
+		dev_err(wdt->dev, "failed to enable apb_clk.\n");
+		return ret;
+	}
+
+	ret = clk_prepare_enable(wdt->core_clk);
+	if (ret)
+		dev_err(wdt->dev, "failed to enable core_clk.\n");
+
+	return ret;
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
+	.id_table	= starfive_wdt_ids,
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
+MODULE_LICENSE("GPL v2");
-- 
2.25.1

