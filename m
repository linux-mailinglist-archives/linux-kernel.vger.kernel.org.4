Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C9C46621AD
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 10:34:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236590AbjAIJdx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 04:33:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233393AbjAIJdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 04:33:47 -0500
X-Greylist: delayed 91 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 09 Jan 2023 01:33:43 PST
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 42E83EF;
        Mon,  9 Jan 2023 01:33:42 -0800 (PST)
X-MailGates: (flag:3,DYNAMIC,RELAY,NOHOST:PASS)(compute_score:DELIVER,40
        ,3)
Received: from 192.168.8.21
        by mg.richtek.com with MailGates ESMTP Server V3.0(2734:0:AUTH_RELAY)
        (envelope-from <prvs=1372AFEF34=gene_chen@richtek.com>); Mon, 09 Jan 2023 17:33:39 +0800 (CST)
X-MailGates: (compute_score:DELIVER,40,3)
Received: from 192.168.10.46
        by mg.richtek.com with MailGates ESMTP Server V5.0(16500:0:AUTH_RELAY)
        (envelope-from <gene_chen@richtek.com>); Mon, 09 Jan 2023 17:31:40 +0800 (CST)
Received: from ex4.rt.l (192.168.10.47) by ex3.rt.l (192.168.10.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.20; Mon, 9 Jan
 2023 17:31:39 +0800
Received: from linuxcarl2.richtek.com (192.168.10.154) by ex4.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1118.20 via Frontend
 Transport; Mon, 9 Jan 2023 17:31:39 +0800
From:   <gene_chen@richtek.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <linux@roeck-us.net>, <heikki.krogerus@linux.intel.com>
CC:     <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Gene Chen <gene_chen@richtek.com>
Subject: [PATCH 2/2] usb: typec: tcpci_rt1718s: Add Richtek RT1718S tcpci driver
Date:   Mon, 9 Jan 2023 17:31:14 +0800
Message-ID: <1673256674-25165-2-git-send-email-gene_chen@richtek.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1673256674-25165-1-git-send-email-gene_chen@richtek.com>
References: <1673256674-25165-1-git-send-email-gene_chen@richtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gene Chen <gene_chen@richtek.com>

Richtek RT1718S is highly integrated TCPC and Power Delivery (PD)
controller with IEC-ESD Protection on SBU/CC/DP/DM, USB2.0 Switch,
Charging Port Controller and Power-Path Control.

Signed-off-by: Gene Chen <gene_chen@richtek.com>
---
 drivers/usb/typec/tcpm/Kconfig         |   9 +
 drivers/usb/typec/tcpm/Makefile        |   1 +
 drivers/usb/typec/tcpm/tcpci_rt1718s.c | 349 +++++++++++++++++++++++++++++++++
 3 files changed, 359 insertions(+)
 create mode 100644 drivers/usb/typec/tcpm/tcpci_rt1718s.c

diff --git a/drivers/usb/typec/tcpm/Kconfig b/drivers/usb/typec/tcpm/Kconfig
index e6b88ca..f0efb34 100644
--- a/drivers/usb/typec/tcpm/Kconfig
+++ b/drivers/usb/typec/tcpm/Kconfig
@@ -27,6 +27,15 @@ config TYPEC_RT1711H
 	  Type-C Port Controller Manager to provide USB PD and USB
 	  Type-C functionalities.
 
+config TYPEC_RT1718S
+	tristate "Richtek RT1718S Type-C chip driver"
+	depends on I2C
+	help
+	  Richtek RT1718S Type-C chip driver that works with
+	  Type-C Port Controller Manager to provide USB PD and USB
+	  Type-C functionalities.
+	  Additionally, it supports BC1.2 and power-path control.
+
 config TYPEC_MT6360
 	tristate "Mediatek MT6360 Type-C driver"
 	depends on MFD_MT6360
diff --git a/drivers/usb/typec/tcpm/Makefile b/drivers/usb/typec/tcpm/Makefile
index 906d9dc..db33ffc 100644
--- a/drivers/usb/typec/tcpm/Makefile
+++ b/drivers/usb/typec/tcpm/Makefile
@@ -5,6 +5,7 @@ obj-$(CONFIG_TYPEC_WCOVE)		+= typec_wcove.o
 typec_wcove-y				:= wcove.o
 obj-$(CONFIG_TYPEC_TCPCI)		+= tcpci.o
 obj-$(CONFIG_TYPEC_RT1711H)		+= tcpci_rt1711h.o
+obj-$(CONFIG_TYPEC_RT1718S)		+= tcpci_rt1718s.o
 obj-$(CONFIG_TYPEC_MT6360)		+= tcpci_mt6360.o
 obj-$(CONFIG_TYPEC_TCPCI_MT6370)	+= tcpci_mt6370.o
 obj-$(CONFIG_TYPEC_TCPCI_MAXIM)		+= tcpci_maxim.o
diff --git a/drivers/usb/typec/tcpm/tcpci_rt1718s.c b/drivers/usb/typec/tcpm/tcpci_rt1718s.c
new file mode 100644
index 00000000..305b39c
--- /dev/null
+++ b/drivers/usb/typec/tcpm/tcpci_rt1718s.c
@@ -0,0 +1,349 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2020 richtek Inc.
+ *
+ * Author: ChiYuan Huang <cy_huang@richtek.com>
+ */
+
+#include <linux/gpio/consumer.h>
+#include <linux/i2c.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+#include <linux/usb/tcpci.h>
+#include <linux/usb/tcpm.h>
+#include <linux/usb/pd_vdo.h>
+
+#define RT1718S_VID	0x29CF
+#define RT1718S_PID	0x1718
+
+#define RT1718S_P1PREFIX	0x00
+#define RT1718S_P1START		(RT1718S_P1PREFIX << 8)
+#define RT1718S_P1END		((RT1718S_P1PREFIX << 8) + 0xFF)
+#define RT1718S_P2PREFIX	0xF2
+#define RT1718S_P2START		(RT1718S_P2PREFIX << 8)
+#define RT1718S_P2END		((RT1718S_P2PREFIX << 8) + 0xFF)
+
+#define RT1718S_SYS_CTRL3	0xB0
+#define RT1718S_SWRESET_MASK	BIT(0)
+
+struct rt1718s_chip {
+	struct tcpci_data tdata;
+	struct tcpci *tcpci;
+	struct device *dev;
+	struct regulator *vbus;
+	bool src_en;
+};
+
+static bool rt1718s_is_readwrite_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case RT1718S_P1START ... RT1718S_P1END:
+	fallthrough;
+	case RT1718S_P2START ... RT1718S_P2END:
+		return true;
+	}
+
+	return false;
+}
+
+static const struct regmap_config rt1718s_regmap_config = {
+	.reg_bits		= 16,
+	.val_bits		= 8,
+
+	.reg_format_endian	= REGMAP_ENDIAN_BIG,
+
+	/* page 1(TCPC) : 0x00 ~ 0xff, page 2 : 0xf200 ~0xf2ff */
+	.max_register		= RT1718S_P2END,
+	.writeable_reg		= rt1718s_is_readwrite_reg,
+	.readable_reg		= rt1718s_is_readwrite_reg,
+};
+
+static int rt1718s_regmap_read(void *context, const void *reg, size_t reg_size,
+			      void *val, size_t val_size)
+{
+	struct device *dev = context;
+	struct i2c_client *i2c = to_i2c_client(dev);
+	struct i2c_msg xfer[2];
+	int ret;
+
+	xfer[0].addr = i2c->addr;
+	xfer[0].flags = 0;
+	xfer[0].len = reg_size;
+	xfer[0].buf = (u8 *)reg;
+
+	if (*(u8 *)reg == RT1718S_P1PREFIX) {
+		xfer[0].len = 1,
+		xfer[0].buf = (u8 *)(reg + 1);
+	}
+
+	xfer[1].addr = i2c->addr;
+	xfer[1].flags = I2C_M_RD;
+	xfer[1].len = val_size;
+	xfer[1].buf = (u8 *)val;
+
+	ret = i2c_transfer(i2c->adapter, xfer, 2);
+	//pr_info("wtf i2c_read [0x%04x]:0x%02x\n", *(u16 *)(reg), *(u8 *)val);
+	if (ret < 0)
+		return ret;
+	else if (ret != 2)
+		return -EIO;
+
+	return 0;
+}
+
+static int rt1718s_regmap_write(void *context, const void *val, size_t val_size)
+{
+	struct device *dev = context;
+	struct i2c_client *i2c = to_i2c_client(dev);
+	struct i2c_msg xfer;
+	int ret;
+
+	xfer.addr = i2c->addr;
+	xfer.flags = 0;
+	xfer.len = val_size;
+	xfer.buf = (u8 *)val;
+
+	if (*(u8 *)val == RT1718S_P1PREFIX) {
+		xfer.len = val_size - 1;
+		xfer.buf = (u8 *)(val + 1);
+	}
+
+	ret = i2c_transfer(i2c->adapter, &xfer, 1);
+	//pr_info("wtf i2c_write [0x%04x]:0x%02x\n", *(u16 *)(val), *(u8 *)(val+2));
+	if (ret < 0)
+		return ret;
+	if (ret != 1)
+		return -EIO;
+
+	return 0;
+}
+
+static const struct regmap_bus rt1718s_regmap_bus = {
+	.read	= rt1718s_regmap_read,
+	.write	= rt1718s_regmap_write,
+};
+
+static const struct reg_sequence rt1718s_init_settings[] = {
+	/* config I2C timeout reset enable , and timeout to 200ms */
+	{ 0xBF, 0x8F, 0 },
+	/* config CC Detect Debounce : 250us (25*val us) */
+	{ 0xB1, 0x0A, 0 },
+	/* DRP Toggle Cycle : 76.8ms (51.2 + 6.4*val ms) */
+	{ 0xB2, 0x04, 0 },
+	/* DRP Duyt Ctrl : dcSRC: 331/1024 ((val+1)/1024) */
+	{ 0xB3, 0x4A, 0 },
+	{ 0xB4, 0x01, 0 },
+	/* Enable VCONN Current Limit function */
+	{ 0x8C, 0x41, 0 },
+	/* Enable cc open 40ms when pmic send vsysuv signal */
+	{ 0xCA, 0xB3, 0 },
+	/* Set GPIO2 push-pull, output-low */
+	{ 0xEE, 0x0C, 0},
+	/* bg en, low power en, vbus valid detect off, vbus present on, osc off */
+	{ 0xB8, 0x1A, 0},
+	/* Link GPIO2 source default vbus to TCPC command */
+	{ 0xEB, 0x08, 0},
+	/* Set GPIO2 vbus path */
+	{ 0xEC, 0x8E, 0 },
+	/* auto low power timer 2.5s, auto low power en, auto low power mode */
+	{ 0xF210, 0x35, 0 },
+	/* Set shipping mode off, AUTOIDLE on with timeout 96ms */
+	{ 0x8F, 0x7F, 0 },
+};
+
+static int rt1718s_init(struct tcpci *tcpci, struct tcpci_data *tdata)
+{
+	int ret;
+
+	ret = regmap_register_patch(tdata->regmap, rt1718s_init_settings,
+				    ARRAY_SIZE(rt1718s_init_settings));
+	pr_info("%s: [TCPC-] ret=%d\n", __func__, ret);
+	return ret;
+}
+
+static int rt1718s_set_vbus(struct tcpci *tcpci, struct tcpci_data *tdata,
+			    bool src, bool snk)
+{
+	struct rt1718s_chip *chip = container_of(tdata, struct rt1718s_chip, tdata);
+	int ret;
+
+	if (chip->src_en == src)
+		return 0;
+
+	if (src)
+		ret = regulator_enable(chip->vbus);
+	else
+		ret = regulator_disable(chip->vbus);
+
+	if (!ret)
+		chip->src_en = src;
+	return ret;
+}
+
+static irqreturn_t rt1718s_irq(int irq, void *dev_id)
+{
+	struct rt1718s_chip *chip = dev_id;
+
+	return tcpci_irq(chip->tcpci);
+}
+
+static int rt1718s_sw_reset(struct rt1718s_chip *chip)
+{
+	int ret;
+
+	ret = regmap_update_bits(chip->tdata.regmap, RT1718S_SYS_CTRL3,
+				 RT1718S_SWRESET_MASK, RT1718S_SWRESET_MASK);
+	if (ret < 0)
+		return ret;
+
+	/* Wait for IC to reset done*/
+	usleep_range(1000, 2000);
+
+	return 0;
+}
+
+static int rt1718s_check_chip_exist(struct i2c_client *i2c)
+{
+	int ret;
+
+	ret = i2c_smbus_read_word_data(i2c, TCPC_VENDOR_ID);
+	if (ret < 0)
+		return ret;
+	if (ret != RT1718S_VID) {
+		dev_err(&i2c->dev, "vid is not correct, 0x%04x\n", ret);
+		return -ENODEV;
+	}
+	ret = i2c_smbus_read_word_data(i2c, TCPC_PRODUCT_ID);
+	if (ret < 0)
+		return ret;
+	if (ret != RT1718S_PID) {
+		dev_err(&i2c->dev, "pid is not correct, 0x%04x\n", ret);
+		return -ENODEV;
+	}
+	return 0;
+}
+
+static int rt1718s_probe(struct i2c_client *i2c)
+{
+	struct rt1718s_chip *chip;
+	struct gpio_desc *gpiod;
+	int ret;
+	u16 clr_events = 0;
+
+	ret = rt1718s_check_chip_exist(i2c);
+	if (ret < 0) {
+		dev_err(&i2c->dev, "check vid/pid fail(%d)\n", ret);
+		return ret;
+	}
+
+	chip = devm_kzalloc(&i2c->dev, sizeof(*chip), GFP_KERNEL);
+	if (!chip)
+		return -ENOMEM;
+
+	chip->dev = &i2c->dev;
+
+	chip->tdata.regmap = devm_regmap_init(&i2c->dev,
+					      &rt1718s_regmap_bus, &i2c->dev,
+					      &rt1718s_regmap_config);
+	if (IS_ERR(chip->tdata.regmap))
+		return dev_err_probe(&i2c->dev, PTR_ERR(chip->tdata.regmap),
+				     "Failed to init regmap\n");
+
+	chip->vbus = devm_regulator_get(&i2c->dev, "vbus");
+	if (IS_ERR(chip->vbus))
+		return dev_err_probe(&i2c->dev, PTR_ERR(chip->vbus),
+				     "Failed to get vbus regulator\n");
+
+	ret = rt1718s_sw_reset(chip);
+	if (ret < 0)
+		return ret;
+
+	ret = regmap_raw_write(chip->tdata.regmap, TCPC_ALERT_MASK, &clr_events,
+			       sizeof(clr_events));
+
+	chip->tdata.init = rt1718s_init;
+	chip->tdata.set_vbus = rt1718s_set_vbus;
+	chip->tcpci = tcpci_register_port(&i2c->dev, &chip->tdata);
+	if (IS_ERR(chip->tcpci))
+		return dev_err_probe(&i2c->dev, PTR_ERR(chip->tcpci),
+				     "Failed to register tcpci port\n");
+
+	/* for platform set gpio default inpull_high */
+	gpiod = devm_gpiod_get(&i2c->dev, NULL, GPIOD_IN);
+	if (IS_ERR(gpiod))
+		return dev_err_probe(&i2c->dev, PTR_ERR(gpiod),
+				     "Failed to get gpio\n");
+
+	ret = devm_request_threaded_irq(&i2c->dev, i2c->irq, NULL,
+					rt1718s_irq, IRQF_ONESHOT,
+					dev_name(&i2c->dev), chip);
+	if (ret) {
+		dev_err(chip->dev, "Failed to register irq\n");
+		tcpci_unregister_port(chip->tcpci);
+		return ret;
+	}
+
+	device_init_wakeup(&i2c->dev, true);
+	i2c_set_clientdata(i2c, chip);
+
+	dev_info(&i2c->dev, "%s:successfully\n", __func__);
+	return 0;
+}
+
+static void rt1718s_remove(struct i2c_client *i2c)
+{
+	struct rt1718s_chip *chip = i2c_get_clientdata(i2c);
+
+	tcpci_unregister_port(chip->tcpci);
+}
+
+static int __maybe_unused rt1718s_suspend(struct device *dev)
+{
+	struct i2c_client *i2c = to_i2c_client(dev);
+
+	if (device_may_wakeup(dev))
+		enable_irq_wake(i2c->irq);
+	disable_irq(i2c->irq);
+
+	return 0;
+}
+
+static int __maybe_unused rt1718s_resume(struct device *dev)
+{
+	struct i2c_client *i2c = to_i2c_client(dev);
+
+	if (device_may_wakeup(dev))
+		disable_irq_wake(i2c->irq);
+	enable_irq(i2c->irq);
+
+	return 0;
+}
+
+static SIMPLE_DEV_PM_OPS(rt1718s_pm_ops, rt1718s_suspend, rt1718s_resume);
+
+static const struct of_device_id __maybe_unused rt1718s_of_id[] = {
+	{ .compatible = "richtek,rt1718s", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, rt1718s_of_id);
+
+static struct i2c_driver rt1718s_i2c_driver = {
+	.driver = {
+		.name = "rt1718s",
+		.pm = &rt1718s_pm_ops,
+		.of_match_table = rt1718s_of_id,
+	},
+	.probe_new = rt1718s_probe,
+	.remove = rt1718s_remove,
+};
+module_i2c_driver(rt1718s_i2c_driver);
+
+MODULE_AUTHOR("Gene Chen <gene_chen@richtek.com>");
+MODULE_DESCRIPTION("RT1718S USB Type-C Port Controller Interface Driver");
+MODULE_LICENSE("GPL");
-- 
2.7.4

