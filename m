Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FBCB7274DC
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 04:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233083AbjFHCQr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 22:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233385AbjFHCQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 22:16:41 -0400
Received: from mail.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DC0B26A9;
        Wed,  7 Jun 2023 19:16:35 -0700 (PDT)
Received: from BillyTsai-pc.aspeed.com (192.168.1.221) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 8 Jun
 2023 10:16:22 +0800
From:   Billy Tsai <billy_tsai@aspeedtech.com>
To:     <jdelvare@suse.com>, <linux@roeck-us.net>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <joel@jms.id.au>,
        <andrew@aj.id.au>, <thierry.reding@gmail.com>,
        <u.kleine-koenig@pengutronix.de>, <corbet@lwn.net>,
        <p.zabel@pengutronix.de>, <billy_tsai@aspeedtech.com>,
        <linux-hwmon@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <linux-pwm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <patrick@stwcx.xyz>
Subject: [v6 4/4] hwmon: Add Aspeed ast2600 TACH support
Date:   Thu, 8 Jun 2023 10:18:39 +0800
Message-ID: <20230608021839.12769-5-billy_tsai@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230608021839.12769-1-billy_tsai@aspeedtech.com>
References: <20230608021839.12769-1-billy_tsai@aspeedtech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.1.221]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the support of Tachometer which can use to monitor the frequency of
the input. In Aspeed AST2600 SoC features 16 TACH controllers, with each
controller capable of supporting up to 1 input.

Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
---
 Documentation/hwmon/index.rst               |   1 +
 Documentation/hwmon/tach-aspeed-ast2600.rst |  25 ++
 drivers/hwmon/Kconfig                       |  10 +
 drivers/hwmon/Makefile                      |   1 +
 drivers/hwmon/tach-aspeed-ast2600.c         | 305 ++++++++++++++++++++
 5 files changed, 342 insertions(+)
 create mode 100644 Documentation/hwmon/tach-aspeed-ast2600.rst
 create mode 100644 drivers/hwmon/tach-aspeed-ast2600.c

diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
index ddff3c5713d7..4c3dd74675ef 100644
--- a/Documentation/hwmon/index.rst
+++ b/Documentation/hwmon/index.rst
@@ -194,6 +194,7 @@ Hardware Monitoring Kernel Drivers
    sparx5-temp
    stpddc60
    sy7636a-hwmon
+   tach-aspeed-ast2600
    tc654
    tc74
    thmc50
diff --git a/Documentation/hwmon/tach-aspeed-ast2600.rst b/Documentation/hwmon/tach-aspeed-ast2600.rst
new file mode 100644
index 000000000000..b08c73a4237f
--- /dev/null
+++ b/Documentation/hwmon/tach-aspeed-ast2600.rst
@@ -0,0 +1,25 @@
+Kernel driver tach-aspeed-ast2600
+=================================
+
+Supported chips:
+	ASPEED AST2600
+
+Authors:
+	<billy_tsai@aspeedtech.com>
+
+Description:
+------------
+This driver implements support for ASPEED AST2600 Fan Tacho controller.
+The controller supports up to 1 tachometer inputs.
+
+The driver provides the following sensor accesses in sysfs:
+
+=============== ======= ======================================================
+fanX_input	ro	provide current fan rotation value in RPM as reported
+			by the fan to the device.
+fanX_div	rw	Fan divisor: Supported value are power of 4 (1, 4, 16
+                        64, ... 4194304)
+                        The larger divisor, the less rpm accuracy and the less
+                        affected by fan signal glitch.
+fanX_pulses	rw      Fan pulses per resolution.
+=============== ======= ======================================================
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index a5253abb7ea7..5948a63e44e7 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -411,6 +411,16 @@ config SENSORS_ASPEED
 	  This driver can also be built as a module. If so, the module
 	  will be called aspeed_pwm_tacho.
 
+config SENSORS_TACH_ASPEED_AST2600
+	tristate "ASPEED ast2600 Tachometer support"
+	depends on ARCH_ASPEED || COMPILE_TEST
+	depends on HAVE_CLK && HAS_IOMEM
+	help
+	  This driver provides support for Aspeed ast2600 Tachometer.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called tach-aspeed-ast2600.
+
 config SENSORS_ATXP1
 	tristate "Attansic ATXP1 VID controller"
 	depends on I2C
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index c5cd7e3a67ff..a3bf5b438e0f 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -53,6 +53,7 @@ obj-$(CONFIG_SENSORS_ARM_SCMI)	+= scmi-hwmon.o
 obj-$(CONFIG_SENSORS_ARM_SCPI)	+= scpi-hwmon.o
 obj-$(CONFIG_SENSORS_AS370)	+= as370-hwmon.o
 obj-$(CONFIG_SENSORS_ASC7621)	+= asc7621.o
+obj-$(CONFIG_SENSORS_TACH_ASPEED_AST2600) += tach-aspeed-ast2600.o
 obj-$(CONFIG_SENSORS_ASPEED)	+= aspeed-pwm-tacho.o
 obj-$(CONFIG_SENSORS_ATXP1)	+= atxp1.o
 obj-$(CONFIG_SENSORS_AXI_FAN_CONTROL) += axi-fan-control.o
diff --git a/drivers/hwmon/tach-aspeed-ast2600.c b/drivers/hwmon/tach-aspeed-ast2600.c
new file mode 100644
index 000000000000..8be66ee25a31
--- /dev/null
+++ b/drivers/hwmon/tach-aspeed-ast2600.c
@@ -0,0 +1,305 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) ASPEED Technology Inc.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/errno.h>
+#include <linux/hwmon.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/reset.h>
+#include <linux/sysfs.h>
+
+/* TACH Control Register */
+#define TACH_ASPEED_CTRL		(0x00)
+#define TACH_ASPEED_IER			BIT(31)
+#define TACH_ASPEED_INVERS_LIMIT	BIT(30)
+#define TACH_ASPEED_LOOPBACK		BIT(29)
+#define TACH_ASPEED_ENABLE		BIT(28)
+#define TACH_ASPEED_DEBOUNCE_MASK	GENMASK(27, 26)
+#define TACH_ASPEED_DEBOUNCE_BIT	26
+#define TACH_ASPEED_IO_EDGE_MASK	GENMASK(25, 24)
+#define TACH_ASPEED_IO_EDGE_BIT		24
+#define TACH_ASPEED_CLK_DIV_T_MASK	GENMASK(23, 20)
+#define TACH_ASPEED_CLK_DIV_BIT		20
+#define TACH_ASPEED_THRESHOLD_MASK	GENMASK(19, 0)
+/* [27:26] */
+#define DEBOUNCE_3_CLK			0x00
+#define DEBOUNCE_2_CLK			0x01
+#define DEBOUNCE_1_CLK			0x02
+#define DEBOUNCE_0_CLK			0x03
+/* [25:24] */
+#define F2F_EDGES			0x00
+#define R2R_EDGES			0x01
+#define BOTH_EDGES			0x02
+/* [23:20] */
+/* divisor = 4 to the nth power, n = register value */
+#define DEFAULT_TACH_DIV		1024
+#define DIV_TO_REG(divisor)		(ilog2(divisor) >> 1)
+
+/* TACH Status Register */
+#define TACH_ASPEED_STS			(0x04)
+
+/*PWM_TACH_STS */
+#define TACH_ASPEED_ISR			BIT(31)
+#define TACH_ASPEED_PWM_OUT		BIT(25)
+#define TACH_ASPEED_PWM_OEN		BIT(24)
+#define TACH_ASPEED_DEB_INPUT		BIT(23)
+#define TACH_ASPEED_RAW_INPUT		BIT(22)
+#define TACH_ASPEED_VALUE_UPDATE	BIT(21)
+#define TACH_ASPEED_FULL_MEASUREMENT	BIT(20)
+#define TACH_ASPEED_VALUE_MASK		GENMASK(19, 0)
+/**********************************************************
+ * Software setting
+ *********************************************************/
+#define DEFAULT_FAN_PULSE_PR		2
+
+struct aspeed_tach_channel_params {
+	u8 pulse_pr;
+	u32 divisor;
+};
+
+struct aspeed_tach_data {
+	struct device *dev;
+	void __iomem *base;
+	struct clk *clk;
+	struct reset_control *reset;
+	bool tach_present;
+	struct aspeed_tach_channel_params tach_channel;
+	unsigned long clk_source;
+};
+
+static void aspeed_tach_ch_enable(struct aspeed_tach_data *priv, bool enable)
+{
+	if (enable)
+		writel(readl(priv->base + TACH_ASPEED_CTRL) |
+			       (TACH_ASPEED_ENABLE),
+		       priv->base + TACH_ASPEED_CTRL);
+	else
+		writel(readl(priv->base + TACH_ASPEED_CTRL) &
+			       ~(TACH_ASPEED_ENABLE),
+		       priv->base + TACH_ASPEED_CTRL);
+}
+
+static u64 aspeed_tach_val_to_rpm(struct aspeed_tach_data *priv, u32 tach_val)
+{
+	u64 rpm;
+	u32 tach_div;
+
+	tach_div = tach_val * (priv->tach_channel.divisor) *
+		   (priv->tach_channel.pulse_pr);
+
+	dev_dbg(priv->dev, "clk %ld, tach_val %d , tach_div %d\n",
+		priv->clk_source, tach_val, tach_div);
+
+	rpm = (u64)priv->clk_source * 60;
+	do_div(rpm, tach_div);
+
+	return rpm;
+}
+
+static int aspeed_get_fan_tach_ch_rpm(struct aspeed_tach_data *priv)
+{
+	u32 val;
+	u64 rpm;
+
+	val = readl(priv->base + TACH_ASPEED_STS);
+
+	if (!(val & TACH_ASPEED_FULL_MEASUREMENT))
+		return 0;
+	rpm = aspeed_tach_val_to_rpm(priv, val & TACH_ASPEED_VALUE_MASK);
+
+	return rpm;
+}
+
+static int aspeed_tach_hwmon_read(struct device *dev,
+				  enum hwmon_sensor_types type, u32 attr,
+				  int channel, long *val)
+{
+	struct aspeed_tach_data *priv = dev_get_drvdata(dev);
+	u32 reg_val;
+	int ret;
+
+	switch (attr) {
+	case hwmon_fan_input:
+		ret = aspeed_get_fan_tach_ch_rpm(priv);
+		if (ret < 0)
+			return ret;
+		*val = ret;
+		break;
+	case hwmon_fan_div:
+		reg_val = readl(priv->base + TACH_ASPEED_CTRL);
+		reg_val = FIELD_GET(TACH_ASPEED_CLK_DIV_T_MASK, reg_val);
+		*val = BIT(reg_val << 1);
+		break;
+	case hwmon_fan_pulses:
+		*val = priv->tach_channel.pulse_pr;
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+	return 0;
+}
+
+static int aspeed_tach_hwmon_write(struct device *dev,
+				   enum hwmon_sensor_types type, u32 attr,
+				   int channel, long val)
+{
+	struct aspeed_tach_data *priv = dev_get_drvdata(dev);
+
+	switch (attr) {
+	case hwmon_fan_div:
+		if (!is_power_of_2(val) || (ilog2(val) % 2))
+			return -EINVAL;
+		else if (DIV_TO_REG(val) > 0xb)
+			return -ERANGE;
+		priv->tach_channel.divisor = val;
+		writel((readl(priv->base + TACH_ASPEED_CTRL) &
+			~(TACH_ASPEED_CLK_DIV_T_MASK)) |
+			       (DIV_TO_REG(priv->tach_channel.divisor)
+				<< TACH_ASPEED_CLK_DIV_BIT),
+		       priv->base + TACH_ASPEED_CTRL);
+		break;
+	case hwmon_fan_pulses:
+		priv->tach_channel.pulse_pr = val;
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
+static umode_t aspeed_tach_dev_is_visible(const void *drvdata,
+					  enum hwmon_sensor_types type,
+					  u32 attr, int channel)
+{
+	const struct aspeed_tach_data *priv = drvdata;
+
+	if (!priv->tach_present)
+		return 0;
+	switch (attr) {
+	case hwmon_fan_input:
+		return 0444;
+	case hwmon_fan_div:
+	case hwmon_fan_pulses:
+		return 0644;
+	}
+	return 0;
+}
+
+static const struct hwmon_ops aspeed_tach_ops = {
+	.is_visible = aspeed_tach_dev_is_visible,
+	.read = aspeed_tach_hwmon_read,
+	.write = aspeed_tach_hwmon_write,
+};
+
+static const struct hwmon_channel_info *aspeed_tach_info[] = {
+	HWMON_CHANNEL_INFO(fan, HWMON_F_INPUT | HWMON_F_DIV | HWMON_F_PULSES),
+	NULL
+};
+
+static const struct hwmon_chip_info aspeed_tach_chip_info = {
+	.ops = &aspeed_tach_ops,
+	.info = aspeed_tach_info,
+};
+
+static void aspeed_present_fan_tach(struct aspeed_tach_data *priv)
+{
+	priv->tach_present = true;
+	priv->tach_channel.divisor = DEFAULT_TACH_DIV;
+	priv->tach_channel.pulse_pr = DEFAULT_FAN_PULSE_PR;
+
+	writel((readl(priv->base + TACH_ASPEED_CTRL) &
+		~(TACH_ASPEED_INVERS_LIMIT | TACH_ASPEED_DEBOUNCE_MASK |
+		  TACH_ASPEED_IO_EDGE_MASK | TACH_ASPEED_CLK_DIV_T_MASK |
+		  TACH_ASPEED_THRESHOLD_MASK)) |
+		       ((DEBOUNCE_3_CLK << TACH_ASPEED_DEBOUNCE_BIT) |
+			F2F_EDGES |
+			(DIV_TO_REG(priv->tach_channel.divisor)
+			 << TACH_ASPEED_CLK_DIV_BIT)),
+	       priv->base + TACH_ASPEED_CTRL);
+
+	aspeed_tach_ch_enable(priv, true);
+}
+
+static void aspeed_tach_reset_assert(void *data)
+{
+	struct reset_control *rst = data;
+
+	reset_control_assert(rst);
+}
+
+static int aspeed_tach_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct aspeed_tach_data *priv;
+	struct device *hwmon;
+	int ret;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+	priv->dev = &pdev->dev;
+	priv->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(priv->base))
+		return PTR_ERR(priv->base);
+	priv->clk = devm_clk_get_enabled(dev, NULL);
+	if (IS_ERR(priv->clk))
+		return dev_err_probe(dev, PTR_ERR(priv->clk),
+				     "Couldn't get clock\n");
+
+	priv->clk_source = clk_get_rate(priv->clk);
+	priv->reset = devm_reset_control_get_shared(dev, NULL);
+	if (IS_ERR(priv->reset))
+		return dev_err_probe(dev, PTR_ERR(priv->reset),
+				     "Couldn't get reset control\n");
+
+	ret = reset_control_deassert(priv->reset);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Couldn't deassert reset control\n");
+
+	ret = devm_add_action_or_reset(dev, aspeed_tach_reset_assert,
+				       priv->reset);
+	if (ret)
+		return ret;
+
+	aspeed_present_fan_tach(priv);
+
+	hwmon = devm_hwmon_device_register_with_info(dev, "aspeed_tach", priv,
+						     &aspeed_tach_chip_info, NULL);
+	ret = PTR_ERR_OR_ZERO(hwmon);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Failed to register hwmon device\n");
+	return 0;
+}
+
+static const struct of_device_id of_stach_match_table[] = {
+	{
+		.compatible = "aspeed,ast2600-tach",
+	},
+	{},
+};
+MODULE_DEVICE_TABLE(of, of_stach_match_table);
+
+static struct platform_driver aspeed_tach_driver = {
+	.probe		= aspeed_tach_probe,
+	.driver		= {
+		.name	= "aspeed_tach",
+		.of_match_table = of_stach_match_table,
+	},
+};
+
+module_platform_driver(aspeed_tach_driver);
+
+MODULE_AUTHOR("Billy Tsai <billy_tsai@aspeedtech.com>");
+MODULE_DESCRIPTION("Aspeed ast2600 TACH device driver");
+MODULE_LICENSE("GPL");
-- 
2.25.1

