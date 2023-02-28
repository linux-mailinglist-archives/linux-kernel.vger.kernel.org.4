Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B97C46A554D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 10:15:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbjB1JP3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 28 Feb 2023 04:15:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbjB1JPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 04:15:24 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 434992BEE2;
        Tue, 28 Feb 2023 01:15:21 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 1A00624E1A4;
        Tue, 28 Feb 2023 17:13:51 +0800 (CST)
Received: from EXMBX068.cuchost.com (172.16.6.68) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 28 Feb
 2023 17:13:48 +0800
Received: from williamqiu-virtual-machine.starfivetech.com (171.223.208.138)
 by EXMBX068.cuchost.com (172.16.6.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.42; Tue, 28 Feb 2023 17:13:46 +0800
From:   William Qiu <william.qiu@starfivetech.com>
To:     <devicetree@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        William Qiu <william.qiu@starfivetech.com>,
        Hal Feng <hal.feng@starfivetech.com>
Subject: [PATCH v1 2/2] pwm: starfive: Add PWM driver support
Date:   Tue, 28 Feb 2023 17:13:45 +0800
Message-ID: <20230228091345.70515-3-william.qiu@starfivetech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230228091345.70515-1-william.qiu@starfivetech.com>
References: <20230228091345.70515-1-william.qiu@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [171.223.208.138]
X-ClientProxiedBy: EXCAS064.cuchost.com (172.16.6.24) To EXMBX068.cuchost.com
 (172.16.6.68)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Pulse Width Modulation driver support for StarFive
JH7110 soc.

Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
Signed-off-by: William Qiu <william.qiu@starfivetech.com>
---
 MAINTAINERS                    |   7 +
 drivers/pwm/Kconfig            |  10 ++
 drivers/pwm/Makefile           |   1 +
 drivers/pwm/pwm-starfive-ptc.c | 256 +++++++++++++++++++++++++++++++++
 4 files changed, 274 insertions(+)
 create mode 100644 drivers/pwm/pwm-starfive-ptc.c

diff --git a/MAINTAINERS b/MAINTAINERS
index ac151975d0d3..05b59605d864 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19929,6 +19929,13 @@ F:	drivers/pinctrl/starfive/pinctrl-starfive-jh71*
 F:	include/dt-bindings/pinctrl/pinctrl-starfive-jh7100.h
 F:	include/dt-bindings/pinctrl/starfive,jh7110-pinctrl.h
 
+STARFIVE JH71X0 PWM DRIVERS
+M:	William Qiu <william.qiu@starfivetech.com>
+M:	Hal Feng <hal.feng@starfivetech.com>
+S:	Supported
+F:	Documentation/devicetree/bindings/pwm/pwm-starfive.yaml
+F:	drivers/pwm/pwm-starfive-ptc.c
+
 STARFIVE JH71X0 RESET CONTROLLER DRIVERS
 M:	Emil Renner Berthing <kernel@esmil.dk>
 M:	Hal Feng <hal.feng@starfivetech.com>
diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index dae023d783a2..2307a0099994 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -536,6 +536,16 @@ config PWM_SPRD
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-sprd.
 
+config PWM_STARFIVE_PTC
+	tristate "StarFive PWM PTC support"
+	depends on OF
+	depends on COMMON_CLK
+	help
+	  Generic PWM framework driver for StarFive SoCs.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called pwm-starfive-ptc.
+
 config PWM_STI
 	tristate "STiH4xx PWM support"
 	depends on ARCH_STI || COMPILE_TEST
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index 7bf1a29f02b8..577f69904baa 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -49,6 +49,7 @@ obj-$(CONFIG_PWM_SIFIVE)	+= pwm-sifive.o
 obj-$(CONFIG_PWM_SL28CPLD)	+= pwm-sl28cpld.o
 obj-$(CONFIG_PWM_SPEAR)		+= pwm-spear.o
 obj-$(CONFIG_PWM_SPRD)		+= pwm-sprd.o
+obj-$(CONFIG_PWM_STARFIVE_PTC)	+= pwm-starfive-ptc.o
 obj-$(CONFIG_PWM_STI)		+= pwm-sti.o
 obj-$(CONFIG_PWM_STM32)		+= pwm-stm32.o
 obj-$(CONFIG_PWM_STM32_LP)	+= pwm-stm32-lp.o
diff --git a/drivers/pwm/pwm-starfive-ptc.c b/drivers/pwm/pwm-starfive-ptc.c
new file mode 100644
index 000000000000..58831c600168
--- /dev/null
+++ b/drivers/pwm/pwm-starfive-ptc.c
@@ -0,0 +1,256 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PWM driver for the StarFive JH7110 SoC
+ *
+ * Copyright (C) 2018 StarFive Technology Co., Ltd.
+ */
+
+#include <dt-bindings/pwm/pwm.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/pwm.h>
+#include <linux/slab.h>
+#include <linux/clk.h>
+#include <linux/reset.h>
+#include <linux/io.h>
+
+/* how many parameters can be transferred to ptc */
+#define OF_PWM_N_CELLS			3
+
+/* PTC Register offsets */
+#define REG_RPTC_CNTR			0x0
+#define REG_RPTC_HRC			0x4
+#define REG_RPTC_LRC			0x8
+#define REG_RPTC_CTRL			0xC
+
+/* Bit for PWM clock */
+#define BIT_PWM_CLOCK_EN		31
+
+/* Bit for clock gen soft reset */
+#define BIT_CLK_GEN_SOFT_RESET		13
+
+#define NS_PER_SECOND			1000000000
+#define DEFAULT_FREQ_HZ			2000000
+
+/*
+ * Access PTC register (cntr hrc lrc and ctrl),
+ * need to replace PWM_BASE_ADDR
+ */
+#define REG_PTC_BASE_ADDR_SUB(base, N)	\
+((base) + (((N) > 3) ? (((N) % 4) * 0x10 + (1 << 15)) : ((N) * 0x10)))
+#define REG_PTC_RPTC_CNTR(base, N)	(REG_PTC_BASE_ADDR_SUB(base, N))
+#define REG_PTC_RPTC_HRC(base, N)	(REG_PTC_BASE_ADDR_SUB(base, N) + 0x4)
+#define REG_PTC_RPTC_LRC(base, N)	(REG_PTC_BASE_ADDR_SUB(base, N) + 0x8)
+#define REG_PTC_RPTC_CTRL(base, N)	(REG_PTC_BASE_ADDR_SUB(base, N) + 0xC)
+
+/* PTC_RPTC_CTRL */
+#define PTC_EN      BIT(0)
+#define PTC_ECLK    BIT(1)
+#define PTC_NEC     BIT(2)
+#define PTC_OE      BIT(3)
+#define PTC_SIGNLE  BIT(4)
+#define PTC_INTE    BIT(5)
+#define PTC_INT     BIT(6)
+#define PTC_CNTRRST BIT(7)
+#define PTC_CAPTE   BIT(8)
+
+struct starfive_pwm_ptc_device {
+	struct pwm_chip		chip;
+	struct clk		*clk;
+	struct reset_control	*rst;
+	void __iomem		*regs;
+	int			irq;
+	/*pwm apb clock frequency*/
+	unsigned int		approx_freq;
+};
+
+static inline struct starfive_pwm_ptc_device *
+		chip_to_starfive_ptc(struct pwm_chip *c)
+{
+	return container_of(c, struct starfive_pwm_ptc_device, chip);
+}
+
+static int starfive_pwm_ptc_get_state(struct pwm_chip *chip,
+				       struct pwm_device *dev,
+				       struct pwm_state *state)
+{
+	struct starfive_pwm_ptc_device *pwm = chip_to_starfive_ptc(chip);
+	u32 data_lrc, data_hrc;
+	u32 pwm_clk_ns = 0;
+
+	data_lrc = ioread32(REG_PTC_RPTC_LRC(pwm->regs, dev->hwpwm));
+	data_hrc = ioread32(REG_PTC_RPTC_HRC(pwm->regs, dev->hwpwm));
+
+	pwm_clk_ns = NS_PER_SECOND / pwm->approx_freq;
+
+	state->period = data_lrc * pwm_clk_ns;
+	state->duty_cycle = data_hrc * pwm_clk_ns;
+	state->polarity = PWM_POLARITY_NORMAL;
+	state->enabled = 1;
+
+	return 0;
+}
+
+static int starfive_pwm_ptc_apply(struct pwm_chip *chip,
+				  struct pwm_device *dev,
+				  struct pwm_state *state)
+{
+	struct starfive_pwm_ptc_device *pwm = chip_to_starfive_ptc(chip);
+	u32 data_hrc = 0;
+	u32 data_lrc = 0;
+	u32 period_data = 0;
+	u32 duty_data = 0;
+	s64 multi = pwm->approx_freq;
+	s64 div = NS_PER_SECOND;
+	void __iomem *reg_addr;
+
+	if (state->duty_cycle > state->period)
+		state->duty_cycle = state->period;
+
+	while (multi % 10 == 0 && div % 10 == 0 && multi > 0 && div > 0) {
+		multi /= 10;
+		div /= 10;
+	}
+
+	period_data = (u32)(state->period * multi / div);
+	if (abs(period_data * div / multi - state->period)
+	    > abs((period_data + 1) * div / multi - state->period) ||
+	    (state->period > 0 && period_data == 0))
+		period_data += 1;
+
+	if (state->enabled) {
+		duty_data = (u32)(state->duty_cycle * multi / div);
+		if (abs(duty_data * div / multi - state->duty_cycle)
+			> abs((duty_data + 1) * div / multi - state->duty_cycle) ||
+			(state->duty_cycle > 0 && duty_data == 0))
+			duty_data += 1;
+	} else {
+		duty_data = 0;
+	}
+
+	if (state->polarity == PWM_POLARITY_NORMAL)
+		data_hrc = period_data - duty_data;
+	else
+		data_hrc = duty_data;
+
+	data_lrc = period_data;
+
+	reg_addr = REG_PTC_RPTC_HRC(pwm->regs, dev->hwpwm);
+	iowrite32(data_hrc, reg_addr);
+
+	reg_addr = REG_PTC_RPTC_LRC(pwm->regs, dev->hwpwm);
+	iowrite32(data_lrc, reg_addr);
+
+	reg_addr = REG_PTC_RPTC_CNTR(pwm->regs, dev->hwpwm);
+	iowrite32(0, reg_addr);
+
+	reg_addr = REG_PTC_RPTC_CTRL(pwm->regs, dev->hwpwm);
+	iowrite32(PTC_EN | PTC_OE, reg_addr);
+
+	return 0;
+}
+
+static const struct pwm_ops starfive_pwm_ptc_ops = {
+	.get_state	= starfive_pwm_ptc_get_state,
+	.apply		= (void *)starfive_pwm_ptc_apply,
+	.owner		= THIS_MODULE,
+};
+
+static int starfive_pwm_ptc_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct starfive_pwm_ptc_device *pwm;
+	struct pwm_chip *chip;
+	struct resource *res;
+	unsigned int clk_apb_freq;
+	int ret;
+
+	pwm = devm_kzalloc(dev, sizeof(*pwm), GFP_KERNEL);
+	if (!pwm)
+		return -ENOMEM;
+
+	chip = &pwm->chip;
+	chip->dev = dev;
+	chip->ops = &starfive_pwm_ptc_ops;
+	chip->npwm = 8;
+
+	chip->of_pwm_n_cells = OF_PWM_N_CELLS;
+	chip->base = -1;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	pwm->regs = devm_ioremap_resource(dev, res);
+	if (IS_ERR(pwm->regs)) {
+		dev_err(dev, "Unable to map IO resources\n");
+		return PTR_ERR(pwm->regs);
+	}
+
+	pwm->clk = devm_clk_get(dev, NULL);
+	if (IS_ERR(pwm->clk)) {
+		dev_err(dev, "Unable to get pwm clock\n");
+		return PTR_ERR(pwm->clk);
+	}
+
+	pwm->rst = devm_reset_control_get_exclusive(dev, NULL);
+	if (IS_ERR(pwm->rst)) {
+		dev_err(dev, "Unable to get pwm reset\n");
+		return PTR_ERR(pwm->rst);
+	}
+
+	ret = clk_prepare_enable(pwm->clk);
+	if (ret) {
+		dev_err(dev,
+			"Failed to enable pwm clock, %d\n", ret);
+		return ret;
+	}
+
+	reset_control_deassert(pwm->rst);
+
+	clk_apb_freq = (unsigned int)clk_get_rate(pwm->clk);
+	if (!clk_apb_freq)
+		dev_warn(dev,
+			 "get pwm apb clock rate failed.\n");
+	else
+		pwm->approx_freq = clk_apb_freq;
+
+	ret = pwmchip_add(chip);
+	if (ret < 0) {
+		dev_err(dev, "cannot register PTC: %d\n", ret);
+		clk_disable_unprepare(pwm->clk);
+		return ret;
+	}
+
+	platform_set_drvdata(pdev, pwm);
+
+	return 0;
+}
+
+static int starfive_pwm_ptc_remove(struct platform_device *dev)
+{
+	struct starfive_pwm_ptc_device *pwm = platform_get_drvdata(dev);
+	struct pwm_chip *chip = &pwm->chip;
+
+	pwmchip_remove(chip);
+
+	return 0;
+}
+
+static const struct of_device_id starfive_pwm_ptc_of_match[] = {
+	{ .compatible = "starfive,jh7110-pwm" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, starfive_pwm_ptc_of_match);
+
+static struct platform_driver starfive_pwm_ptc_driver = {
+	.probe = starfive_pwm_ptc_probe,
+	.remove = starfive_pwm_ptc_remove,
+	.driver = {
+		.name = "pwm-starfive-ptc",
+		.of_match_table = of_match_ptr(starfive_pwm_ptc_of_match),
+	},
+};
+module_platform_driver(starfive_pwm_ptc_driver);
+
+MODULE_AUTHOR("Jenny Zhang <jenny.zhang@starfivetech.com>");
+MODULE_AUTHOR("Hal Feng <hal.feng@starfivetech.com>");
+MODULE_DESCRIPTION("StarFive PWM PTC driver");
+MODULE_LICENSE("GPL");
-- 
2.34.1

