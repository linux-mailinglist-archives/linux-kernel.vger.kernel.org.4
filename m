Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B35AB719615
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 10:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231437AbjFAIwU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 1 Jun 2023 04:52:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232375AbjFAIwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 04:52:07 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4618F129;
        Thu,  1 Jun 2023 01:52:04 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 9CE0124E255;
        Thu,  1 Jun 2023 16:51:57 +0800 (CST)
Received: from EXMBX168.cuchost.com (172.16.6.78) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 1 Jun
 2023 16:51:57 +0800
Received: from williamqiu-virtual-machine.starfivetech.com (171.223.208.138)
 by EXMBX168.cuchost.com (172.16.6.78) with Microsoft SMTP Server (TLS) id
 15.0.1497.42; Thu, 1 Jun 2023 16:51:56 +0800
From:   William Qiu <william.qiu@starfivetech.com>
To:     <devicetree@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
CC:     Thierry Reding <thierry.reding@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Hal Feng <hal.feng@starfivetech.com>,
        William Qiu <william.qiu@starfivetech.com>
Subject: [PATCH v4 2/4] pwm: starfive: Add PWM driver support
Date:   Thu, 1 Jun 2023 16:51:52 +0800
Message-ID: <20230601085154.36938-3-william.qiu@starfivetech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230601085154.36938-1-william.qiu@starfivetech.com>
References: <20230601085154.36938-1-william.qiu@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [171.223.208.138]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX168.cuchost.com
 (172.16.6.78)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Pulse Width Modulation driver support for StarFive
JH7100 and JH7110 SoC.

Co-developed-by: Hal Feng <hal.feng@starfivetech.com>
Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
Signed-off-by: William Qiu <william.qiu@starfivetech.com>
---
 MAINTAINERS                    |   7 ++
 drivers/pwm/Kconfig            |   9 ++
 drivers/pwm/Makefile           |   1 +
 drivers/pwm/pwm-starfive-ptc.c | 192 +++++++++++++++++++++++++++++++++
 4 files changed, 209 insertions(+)
 create mode 100644 drivers/pwm/pwm-starfive-ptc.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 27ef11624748..34d69e9ce444 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20112,6 +20112,13 @@ F:	drivers/pinctrl/starfive/pinctrl-starfive-jh71*
 F:	include/dt-bindings/pinctrl/pinctrl-starfive-jh7100.h
 F:	include/dt-bindings/pinctrl/starfive,jh7110-pinctrl.h
 
+STARFIVE JH71X0 PWM DRIVERS
+M:	William Qiu <william.qiu@starfivetech.com>
+M:	Hal Feng <hal.feng@starfivetech.com>
+S:	Supported
+F:	Documentation/devicetree/bindings/pwm/starfive,jh7100-pwm.yaml
+F:	drivers/pwm/pwm-starfive-ptc.c
+
 STARFIVE JH71X0 RESET CONTROLLER DRIVERS
 M:	Emil Renner Berthing <kernel@esmil.dk>
 M:	Hal Feng <hal.feng@starfivetech.com>
diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 8df861b1f4a3..df2bc4ce3f1f 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -548,6 +548,15 @@ config PWM_SPRD
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-sprd.
 
+config PWM_STARFIVE_PTC
+	tristate "StarFive PWM PTC support"
+	depends on ARCH_STARFIVE || COMPILE_TEST
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
index 19899b912e00..994104aaa9b4 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -50,6 +50,7 @@ obj-$(CONFIG_PWM_SIFIVE)	+= pwm-sifive.o
 obj-$(CONFIG_PWM_SL28CPLD)	+= pwm-sl28cpld.o
 obj-$(CONFIG_PWM_SPEAR)		+= pwm-spear.o
 obj-$(CONFIG_PWM_SPRD)		+= pwm-sprd.o
+obj-$(CONFIG_PWM_STARFIVE_PTC)	+= pwm-starfive-ptc.o
 obj-$(CONFIG_PWM_STI)		+= pwm-sti.o
 obj-$(CONFIG_PWM_STM32)		+= pwm-stm32.o
 obj-$(CONFIG_PWM_STM32_LP)	+= pwm-stm32-lp.o
diff --git a/drivers/pwm/pwm-starfive-ptc.c b/drivers/pwm/pwm-starfive-ptc.c
new file mode 100644
index 000000000000..57b5736f6732
--- /dev/null
+++ b/drivers/pwm/pwm-starfive-ptc.c
@@ -0,0 +1,192 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PWM driver for the StarFive JH71x0 SoC
+ *
+ * Copyright (C) 2018-2023 StarFive Technology Co., Ltd.
+ */
+
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/pwm.h>
+#include <linux/reset.h>
+#include <linux/slab.h>
+
+/* Access PTC register (CNTR, HRC, LRC and CTRL) */
+#define REG_PTC_BASE_ADDR_SUB(base, N)	\
+((base) + (((N) > 3) ? (((N) % 4) * 0x10 + (1 << 15)) : ((N) * 0x10)))
+#define REG_PTC_RPTC_CNTR(base, N)	(REG_PTC_BASE_ADDR_SUB(base, N))
+#define REG_PTC_RPTC_HRC(base, N)	(REG_PTC_BASE_ADDR_SUB(base, N) + 0x4)
+#define REG_PTC_RPTC_LRC(base, N)	(REG_PTC_BASE_ADDR_SUB(base, N) + 0x8)
+#define REG_PTC_RPTC_CTRL(base, N)	(REG_PTC_BASE_ADDR_SUB(base, N) + 0xC)
+
+/* PTC_RPTC_CTRL register bits*/
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
+	struct pwm_chip chip;
+	struct clk *clk;
+	struct reset_control *rst;
+	void __iomem *regs;
+	u32 clk_rate; /* PWM APB clock frequency */
+};
+
+static inline
+struct starfive_pwm_ptc_device *chip_to_starfive_ptc(struct pwm_chip *c)
+{
+	return container_of(c, struct starfive_pwm_ptc_device, chip);
+}
+
+static int starfive_pwm_ptc_get_state(struct pwm_chip *chip,
+				      struct pwm_device *dev,
+				      struct pwm_state *state)
+{
+	struct starfive_pwm_ptc_device *pwm = chip_to_starfive_ptc(chip);
+	u32 period_data, duty_data, ctrl_data;
+
+	period_data = readl(REG_PTC_RPTC_LRC(pwm->regs, dev->hwpwm));
+	duty_data = readl(REG_PTC_RPTC_HRC(pwm->regs, dev->hwpwm));
+	ctrl_data = readl(REG_PTC_RPTC_CTRL(pwm->regs, dev->hwpwm));
+
+	state->period = DIV_ROUND_CLOSEST_ULL((u64)period_data * NSEC_PER_SEC, pwm->clk_rate);
+	state->duty_cycle = DIV_ROUND_CLOSEST_ULL((u64)duty_data * NSEC_PER_SEC, pwm->clk_rate);
+	state->polarity = PWM_POLARITY_INVERSED;
+	state->enabled = (ctrl_data & PTC_EN) ? true : false;
+
+	return 0;
+}
+
+static int starfive_pwm_ptc_apply(struct pwm_chip *chip,
+				  struct pwm_device *dev,
+				  const struct pwm_state *state)
+{
+	struct starfive_pwm_ptc_device *pwm = chip_to_starfive_ptc(chip);
+	u32 period_data, duty_data, ctrl_data = 0;
+
+	if (state->polarity != PWM_POLARITY_INVERSED)
+		return -EINVAL;
+
+	period_data = DIV_ROUND_CLOSEST_ULL(state->period * pwm->clk_rate,
+					    NSEC_PER_SEC);
+	duty_data = DIV_ROUND_CLOSEST_ULL(state->duty_cycle * pwm->clk_rate,
+					  NSEC_PER_SEC);
+
+	writel(period_data, REG_PTC_RPTC_LRC(pwm->regs, dev->hwpwm));
+	writel(duty_data, REG_PTC_RPTC_HRC(pwm->regs, dev->hwpwm));
+	writel(0,  REG_PTC_RPTC_CNTR(pwm->regs, dev->hwpwm));
+
+	ctrl_data = readl(REG_PTC_RPTC_CTRL(pwm->regs, dev->hwpwm));
+	if (state->enabled)
+		writel(ctrl_data | PTC_EN | PTC_OE, REG_PTC_RPTC_CTRL(pwm->regs, dev->hwpwm));
+	else
+		writel(ctrl_data & ~(PTC_EN | PTC_OE), REG_PTC_RPTC_CTRL(pwm->regs, dev->hwpwm));
+
+	return 0;
+}
+
+static const struct pwm_ops starfive_pwm_ptc_ops = {
+	.get_state	= starfive_pwm_ptc_get_state,
+	.apply		= starfive_pwm_ptc_apply,
+	.owner		= THIS_MODULE,
+};
+
+static int starfive_pwm_ptc_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct starfive_pwm_ptc_device *pwm;
+	struct pwm_chip *chip;
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
+	chip->of_pwm_n_cells = 3;
+
+	pwm->regs = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(pwm->regs))
+		return dev_err_probe(dev, PTR_ERR(pwm->regs),
+				     "Unable to map IO resources\n");
+
+	pwm->clk = devm_clk_get(dev, NULL);
+	if (IS_ERR(pwm->clk))
+		return dev_err_probe(dev, PTR_ERR(pwm->clk),
+				     "Unable to get pwm's clock\n");
+
+	pwm->rst = devm_reset_control_get_exclusive(dev, NULL);
+	if (IS_ERR(pwm->rst))
+		return dev_err_probe(dev, PTR_ERR(pwm->rst),
+				     "Unable to get pwm's reset\n");
+
+	ret = clk_prepare_enable(pwm->clk);
+	if (ret) {
+		dev_err(dev,
+			"Failed to enable clock for pwm: %d\n", ret);
+		return ret;
+	}
+
+	reset_control_deassert(pwm->rst);
+
+	pwm->clk_rate = clk_get_rate(pwm->clk);
+	if (pwm->clk_rate <= 0) {
+		dev_warn(dev, "Failed to get APB clock rate\n");
+		return -EINVAL;
+	}
+
+	ret = devm_pwmchip_add(dev, chip);
+	if (ret < 0) {
+		dev_err(dev, "Cannot register PTC: %d\n", ret);
+		clk_disable_unprepare(pwm->clk);
+		reset_control_assert(pwm->rst);
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
+
+	reset_control_assert(pwm->rst);
+	clk_disable_unprepare(pwm->clk);
+
+	return 0;
+}
+
+static const struct of_device_id starfive_pwm_ptc_of_match[] = {
+	{ .compatible = "starfive,jh7100-pwm" },
+	{ .compatible = "starfive,jh7110-pwm" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, starfive_pwm_ptc_of_match);
+
+static struct platform_driver starfive_pwm_ptc_driver = {
+	.probe = starfive_pwm_ptc_probe,
+	.remove = starfive_pwm_ptc_remove,
+	.driver = {
+		.name = "pwm-starfive-ptc",
+		.of_match_table = starfive_pwm_ptc_of_match,
+	},
+};
+module_platform_driver(starfive_pwm_ptc_driver);
+
+MODULE_AUTHOR("Jieqin Chen");
+MODULE_AUTHOR("Hal Feng <hal.feng@starfivetech.com>");
+MODULE_DESCRIPTION("StarFive PWM PTC driver");
+MODULE_LICENSE("GPL");
-- 
2.34.1

