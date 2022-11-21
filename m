Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33D48631943
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 05:41:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbiKUEl0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 23:41:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiKUElY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 23:41:24 -0500
X-Greylist: delayed 903 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 20 Nov 2022 20:41:22 PST
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com [136.143.188.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B2322127F;
        Sun, 20 Nov 2022 20:41:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1669004760; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=YHNJ2+HJ/H0Gw+bVFdlR0NjlJ758AT7J9xaH/PHyn0kMFLBDeeEvWNv2BWUyxr3i1bJ/N3lh6bBf4DrRbEaF4V/3USPjXymIhAiAsBn4jz8YBxx1z76Dj/xwXCUx482OY9S5n7W/+g3JFX/mdSI2rql6C/A9FxdcOO6IojV4jSg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1669004760; h=Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=nrvjuWaqfgia/nQtjvDopsLAbAQfTzd2pgSuh5fj1Wo=; 
        b=Liywa23A/kyZlHgCxAd1FMAxfCzQ49O6vpCgXoZWdXSFm8mYbGT2JybvLVuuhtveADtkba2l457RhHTupY+sCwAIPc+xs0a6F40Ju4mfVOsHUEoPx7MHsEIG3d9e9FTeY4/YGF1F2ku39F07bzosgjMYNl5bBjoS1rCJ7c4Uc44=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=icenowy.me;
        spf=pass  smtp.mailfrom=uwu@icenowy.me;
        dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1669004760;
        s=zmail; d=icenowy.me; i=uwu@icenowy.me;
        h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
        bh=nrvjuWaqfgia/nQtjvDopsLAbAQfTzd2pgSuh5fj1Wo=;
        b=a1+AicE/JmUQYF+Qx67A/IoBckTC9e7zIR8J5XcYtWAhqoWijWcsnAUkxAYLwrQB
        eVJY9OAfVwacprKaNzL8h9QVfFhkQOwYS9Njv7KjIq3cqttI3p2Pn0pkR5XyC7dId9H
        M1yxYBZZc80uY9pYv8iiY5/OXQf4+3Nm/zjIi7rs=
Received: from edelgard.fodlan.icenowy.me (112.94.100.29 [112.94.100.29]) by mx.zohomail.com
        with SMTPS id 1669004758460662.1681125118431; Sun, 20 Nov 2022 20:25:58 -0800 (PST)
From:   Icenowy Zheng <uwu@icenowy.me>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Karol Gugala <kgugala@antmicro.com>,
        Mateusz Holenko <mholenko@antmicro.com>,
        Gabriel Somlo <gsomlo@gmail.com>, Joel Stanley <joel@jms.id.au>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Icenowy Zheng <uwu@icenowy.me>
Subject: [PATCH 2/2] clocksource/drivers: add LiteX timer
Date:   Mon, 21 Nov 2022 12:25:45 +0800
Message-Id: <20221121042545.421532-2-uwu@icenowy.me>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221121042545.421532-1-uwu@icenowy.me>
References: <20221121042545.421532-1-uwu@icenowy.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a driver for the timer as part of LiteX SoC generator. By default,
it's a 32-bit down counter with reload support.

It has an optional uptime counter, however because it's noe defaultly
enabled, it's not supported yet.

Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
---
 MAINTAINERS                       |   1 +
 drivers/clocksource/Kconfig       |  10 ++
 drivers/clocksource/Makefile      |   1 +
 drivers/clocksource/timer-litex.c | 163 ++++++++++++++++++++++++++++++
 4 files changed, 175 insertions(+)
 create mode 100644 drivers/clocksource/timer-litex.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 1df62c469bd9..5892a0083531 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11973,6 +11973,7 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/*/litex,*.yaml
 F:	arch/openrisc/boot/dts/or1klitex.dts
 F:	include/linux/litex.h
+F:	drivers/clocksource/timer-litex.c
 F:	drivers/tty/serial/liteuart.c
 F:	drivers/soc/litex/*
 F:	drivers/net/ethernet/litex/*
diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 4469e7f555e9..6936e09d1898 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -657,6 +657,16 @@ config GX6605S_TIMER
 	help
 	  This option enables support for gx6605s SOC's timer.
 
+config LITEX_TIMER
+	bool "LiteX SoC timer"
+	default LITEX
+	depends on OF
+	select TIMER_OF
+	help
+	  Say yes here to enable LiteX SoC timer driver automatically
+	  generated in a LiteX SoC. This timer could be useful when the
+	  CPU core itself does not contain a supported timer.
+
 config MILBEAUT_TIMER
 	bool "Milbeaut timer driver" if COMPILE_TEST
 	depends on OF
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index 64ab547de97b..c7d3eda617a7 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -59,6 +59,7 @@ obj-$(CONFIG_MILBEAUT_TIMER)	+= timer-milbeaut.o
 obj-$(CONFIG_SPRD_TIMER)	+= timer-sprd.o
 obj-$(CONFIG_NPCM7XX_TIMER)	+= timer-npcm7xx.o
 obj-$(CONFIG_RDA_TIMER)		+= timer-rda.o
+obj-$(CONFIG_LITEX_TIMER)	+= timer-litex.o
 
 obj-$(CONFIG_ARC_TIMERS)		+= arc_timer.o
 obj-$(CONFIG_ARM_ARCH_TIMER)		+= arm_arch_timer.o
diff --git a/drivers/clocksource/timer-litex.c b/drivers/clocksource/timer-litex.c
new file mode 100644
index 000000000000..609023403602
--- /dev/null
+++ b/drivers/clocksource/timer-litex.c
@@ -0,0 +1,163 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * LiteX SoC builder timer handling.
+ *
+ * Copyright (C) 2022 Icenowy Zheng <uwu@icenowy.me>
+ */
+
+#include <linux/clk.h>
+#include <linux/clockchips.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/irqreturn.h>
+#include <linux/sched_clock.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+
+#include "timer-of.h"
+
+/*
+ * CSRs definitions (base address offsets + width)
+ *
+ * The definitions below are true for LiteX SoC configured for 32-bit CSR Bus,
+ * 32-bit aligned, and the timer configured as 32-bit.
+ *
+ * Supporting other configurations might require new definitions or a more
+ * generic way of indexing the LiteX CSRs.
+ *
+ * For more details on how CSRs are defined and handled in LiteX, see comments
+ * in the LiteX SoC Driver: drivers/soc/litex/litex_soc_ctrl.c
+ */
+#define OFF_LOAD		0x00
+#define OFF_RELOAD		0x04
+#define OFF_EN			0x08
+#define OFF_UPDATE_VALUE	0x0c
+#define OFF_VALUE		0x10
+#define OFF_EV_STATUS		0x14
+#define OFF_EV_PENDING		0x18
+#define OFF_EV_ENABLE		0x1c
+
+/* events */
+#define EV_ZERO			BIT(0)
+
+static void litex_timer_enable(struct timer_of *to, bool enable)
+{
+	writel(enable ? EV_ZERO : 0, timer_of_base(to) + OFF_EV_ENABLE);
+	writel(enable ? 1 : 0, timer_of_base(to) + OFF_EN);
+}
+
+static int litex_timer_next_event(unsigned long delta,
+				  struct clock_event_device *evt)
+{
+	struct timer_of *to = to_timer_of(evt);
+
+	litex_timer_enable(to, false);
+	writel((uint32_t) delta, timer_of_base(to) + OFF_LOAD);
+	litex_timer_enable(to, true);
+
+	return 0;
+}
+
+static int litex_timer_state_oneshot(struct clock_event_device *evt)
+{
+	struct timer_of *to = to_timer_of(evt);
+
+	litex_timer_enable(to, false);
+	writel(0, timer_of_base(to) + OFF_RELOAD);
+	litex_timer_enable(to, true);
+
+	return 0;
+}
+
+static int litex_timer_state_periodic(struct clock_event_device *evt)
+{
+	struct timer_of *to = to_timer_of(evt);
+
+	litex_timer_enable(to, false);
+	writel((uint32_t) timer_of_period(to), timer_of_base(to) + OFF_RELOAD);
+	writel((uint32_t) timer_of_period(to), timer_of_base(to) + OFF_LOAD);
+	litex_timer_enable(to, true);
+
+	return 0;
+}
+
+static int litex_timer_state_shutdown(struct clock_event_device *evt)
+{
+	struct timer_of *to = to_timer_of(evt);
+
+	litex_timer_enable(to, false);
+
+	return 0;
+}
+
+static irqreturn_t litex_timer_interrupt(int irq, void *dev_id)
+{
+	struct clock_event_device *evt = dev_id;
+	struct timer_of *to = to_timer_of(evt);
+	u32 val;
+
+	val = readl(timer_of_base(to) + OFF_EV_PENDING);
+	if (!(val & EV_ZERO))
+		return IRQ_NONE;
+
+	writel(EV_ZERO, timer_of_base(to) + OFF_EV_PENDING);
+
+	evt->event_handler(evt);
+
+	return IRQ_HANDLED;
+}
+
+static struct timer_of to_litex = {
+	.flags = TIMER_OF_IRQ | TIMER_OF_BASE | TIMER_OF_CLOCK,
+	.clkevt = {
+		.name			= "LiteX Timer",
+		.features		= CLOCK_EVT_FEAT_ONESHOT |
+					  CLOCK_EVT_FEAT_PERIODIC,
+		.set_state_oneshot	= litex_timer_state_oneshot,
+		.set_state_periodic	= litex_timer_state_periodic,
+		.set_next_event		= litex_timer_next_event,
+		.set_state_shutdown	= litex_timer_state_shutdown,
+		.rating			= 101,
+	},
+	.of_irq = {
+		.handler		= litex_timer_interrupt,
+		.flags			= IRQF_TIMER,
+	},
+};
+
+static void __init litex_clockevent_init(void)
+{
+	to_litex.clkevt.cpumask = cpu_possible_mask;
+
+	clockevents_config_and_register(&to_litex.clkevt,
+					timer_of_rate(&to_litex),
+					0x1, 0xffffffff);
+}
+
+static int __init litex_timer_init(struct device_node *np)
+{
+	int ret = 0;
+	u32 width;
+
+	ret = of_property_read_u32(np, "litex,width", &width);
+	if (ret) {
+		pr_err("Cannot retrieve width\n");
+		return ret;
+	}
+	if (width != 32) {
+		pr_err("Unsupported width\n");
+		return -ENOTSUPP;
+	}
+
+	ret = timer_of_init(np, &to_litex);
+	if (ret) {
+		pr_err("Cannot parse DT for LiteX timer\n");
+		return ret;
+	}
+
+	litex_clockevent_init();
+
+	return 0;
+}
+TIMER_OF_DECLARE(litex, "litex,timer", litex_timer_init);
-- 
2.37.1

