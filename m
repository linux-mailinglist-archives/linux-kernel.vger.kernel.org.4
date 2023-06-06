Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C0D67234D2
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 03:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232112AbjFFBr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 21:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234027AbjFFBrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 21:47:11 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A043D1A5;
        Mon,  5 Jun 2023 18:46:54 -0700 (PDT)
Received: from pps.filterd (m0148663.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 355KA0Hf029576;
        Tue, 6 Jun 2023 01:46:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=pps0720;
 bh=CIVk0iyfiCqEM3+pTjLBiagcz4I6zrxsQOsvByMoFnE=;
 b=BQgKfeyvuaPBbz9DBGCOizAok1c0GawMhEHC6M9lhJzkW2WpmyMXNmXbQg/VcJMgcxHF
 K+EBjhh5Irg3EnEh8hYHzpdsSDdMFxnxInM7J3jnBVJbEADmgB0xj0Ex3p1FjYr3yt8I
 WcQPYf1fAs9Lq4/upeTgSU0vPGtNQ+SK1jfuZ2wI/klKKNjLog6jPYz/XNTo2iN0hM7w
 nKRmzHItWmmhMtdPvRGTW+yZNDK5xABWVk5QjJ4cBMMpZJdtcF79yqqWbnY1n2KQGvOj
 cwvxcNE5aBKQjR8wj7AAd6Ode1de5tXUknI+ovYYyrMxIWPL1q/UKtH2z0QDmXeSvPkc PA== 
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3r1pg3sqqx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Jun 2023 01:46:32 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14881.it.hpe.com (Postfix) with ESMTPS id E31F6804DD0;
        Tue,  6 Jun 2023 01:46:31 +0000 (UTC)
Received: from hpe.com (unknown [16.231.227.36])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id 13ECE80A543;
        Tue,  6 Jun 2023 01:46:31 +0000 (UTC)
From:   nick.hawkins@hpe.com
To:     verdun@hpe.com, nick.hawkins@hpe.com, linus.walleij@linaro.org,
        brgl@bgdev.pl, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jdelvare@suse.com,
        linux@roeck-us.net, andy.shevchenko@gmail.com,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
Subject: [PATCH v3 2/5] gpio: gxp: Add HPE GXP GPIO
Date:   Mon,  5 Jun 2023 20:42:31 -0500
Message-Id: <20230606014234.29491-3-nick.hawkins@hpe.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230606014234.29491-1-nick.hawkins@hpe.com>
References: <20230606014234.29491-1-nick.hawkins@hpe.com>
X-Proofpoint-ORIG-GUID: pHPAGnG9mFpo36bPTrSOAIyqBqs8-TMK
X-Proofpoint-GUID: pHPAGnG9mFpo36bPTrSOAIyqBqs8-TMK
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-05_35,2023-06-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 phishscore=0 mlxlogscore=999 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 impostorscore=0 suspectscore=0 spamscore=0
 clxscore=1015 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2306060014
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Hawkins <nick.hawkins@hpe.com>

The GXP SoC supports GPIO on multiple interfaces. The interfaces are
CPLD and Host. The GPIOs is a combination of both physical and virtual
I/O across the interfaces. The gpio-gxp driver specifically covers the
CSM(physical), FN2(virtual), and VUHC(virtual) which are the host. The
gpio-gxp-pl driver covers the CPLD which takes physical I/O from the
board and shares it with GXP via a propriety interface that maps the I/O
onto a specific register area of the GXP. The drivers both support
interrupts but from different interrupt parents.

Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>

---

v3:
 *Remove shared variables with gxp-fan-ctrl
v2:
 *Separated code into two files to keep size down: gpio-gxp.c and
  gpio-gxp-pl.c
 *Fixed Kconfig indentation as well as add new entry for gpio-gxp-pl
 *Removed use of linux/of.h and linux/of_device.h
 *Added mod_devicetable.h and property.h
 *Fixed indentation of defines and uses consistent number of digits
 *Corrected defines with improper GPIO_ namespace.
 *For masks now use BIT()
 *Added comment for PLREG offsets
 *Move gpio_chip to be first in structure
 *Calculate offset for high and low byte GPIO reads instead of having
  H(High) and L(Low) letters added to the variables.
 *Removed repeditive use of "? 1 : 0"
 *Switched to handle_bad_irq()
 *Removed improper bailout on gpiochip_add_data
 *Used GENMASK to arm interrupts
 *Removed use of of_match_device
 *fixed sizeof in devm_kzalloc
 *Added COMPILE_TEST to Kconfig
 *Added dev_err_probe
 *Removed unecessary parent and compatible checks
---
 drivers/gpio/Kconfig       |  18 ++
 drivers/gpio/Makefile      |   2 +
 drivers/gpio/gpio-gxp-pl.c | 519 ++++++++++++++++++++++++++++++
 drivers/gpio/gpio-gxp.c    | 637 +++++++++++++++++++++++++++++++++++++
 4 files changed, 1176 insertions(+)
 create mode 100644 drivers/gpio/gpio-gxp-pl.c
 create mode 100644 drivers/gpio/gpio-gxp.c

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 13be729710f2..b0a24ef18392 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -1235,6 +1235,24 @@ config HTC_EGPIO
 	  several HTC phones.  It provides basic support for input
 	  pins, output pins, and IRQs.
 
+config GPIO_GXP
+	tristate "GXP GPIO support"
+	depends on ARCH_HPE_GXP || COMPILE_TEST
+	select GPIOLIB_IRQCHIP
+	help
+	  Say Y here to support GXP GPIO controllers. It provides
+	  support for the multiple GPIO interfaces available to be
+	  available to the Host.
+
+config GPIO_GXP_PL
+	tristate "GXP GPIO PL support"
+	depends on ARCH_HPE_GXP || COMPILE_TEST
+	select GPIOLIB_IRQCHIP
+	help
+	  Say Y here to support GXP GPIO PL controller. It provides
+	  support for the GPIO PL interface available to be
+	  available to the Host.
+
 config GPIO_JANZ_TTL
 	tristate "Janz VMOD-TTL Digital IO Module"
 	depends on MFD_JANZ_CMODIO
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index c048ba003367..a401dd472c93 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -63,6 +63,8 @@ obj-$(CONFIG_GPIO_FTGPIO010)		+= gpio-ftgpio010.o
 obj-$(CONFIG_GPIO_GE_FPGA)		+= gpio-ge.o
 obj-$(CONFIG_GPIO_GPIO_MM)		+= gpio-gpio-mm.o
 obj-$(CONFIG_GPIO_GRGPIO)		+= gpio-grgpio.o
+obj-$(CONFIG_GPIO_GXP)                  += gpio-gxp.o
+obj-$(CONFIG_GPIO_GXP_PL)		+= gpio-gxp-pl.o
 obj-$(CONFIG_GPIO_GW_PLD)		+= gpio-gw-pld.o
 obj-$(CONFIG_GPIO_HISI)                 += gpio-hisi.o
 obj-$(CONFIG_GPIO_HLWD)			+= gpio-hlwd.o
diff --git a/drivers/gpio/gpio-gxp-pl.c b/drivers/gpio/gpio-gxp-pl.c
new file mode 100644
index 000000000000..eaa2ffe2edfa
--- /dev/null
+++ b/drivers/gpio/gpio-gxp-pl.c
@@ -0,0 +1,519 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (C) 2023 Hewlett-Packard Enterprise Development Company, L.P. */
+
+#include <linux/gpio/driver.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
+#include <linux/regmap.h>
+
+/* Specific offsets in CPLD registers for interrupts */
+#define PLREG_INT_GRP_STAT_MASK	0x08
+#define PLREG_INT_HI_PRI_EN	0x0C
+#define PLREG_INT_GRP5_BASE	0x31
+#define PLREG_INT_GRP6_BASE	0x35
+#define PLREG_INT_GRP5_FLAG	0x30
+#define PLREG_INT_GRP6_FLAG	0x34
+
+/* Specific bits to enable Group 4 and Group 5 interrupts */
+#define PLREG_GRP4_GRP5_MASK	GENMASK(5, 4)
+
+/* Specific offsets in CPLD registers */
+#define PLREG_IOP_LED		0x04
+#define PLREG_IDENT_LED		0x05
+#define PLREG_HEALTH_LED	0x0D
+#define PLREG_PSU_INST		0x19
+#define PLREG_PSU_AC		0x1B
+#define PLREG_PSU_DC		0x1C
+#define PLREG_FAN_INST		0x27
+#define PLREG_FAN_FAIL		0x29
+
+#define GXP_GPIO_DIR_OUT        0x00
+#define GXP_GPIO_DIR_IN         0x01
+
+enum pl_gpio_pn {
+	IOP_LED1 = 0,
+	IOP_LED2 = 1,
+	IOP_LED3 = 2,
+	IOP_LED4 = 3,
+	IOP_LED5 = 4,
+	IOP_LED6 = 5,
+	IOP_LED7 = 6,
+	IOP_LED8 = 7,
+	FAN1_INST = 8,
+	FAN2_INST = 9,
+	FAN3_INST = 10,
+	FAN4_INST = 11,
+	FAN5_INST = 12,
+	FAN6_INST = 13,
+	FAN7_INST = 14,
+	FAN8_INST = 15,
+	FAN1_FAIL = 16,
+	FAN2_FAIL = 17,
+	FAN3_FAIL = 18,
+	FAN4_FAIL = 19,
+	FAN5_FAIL = 20,
+	FAN6_FAIL = 21,
+	FAN7_FAIL = 22,
+	FAN8_FAIL = 23,
+	LED_IDENTIFY = 24,
+	LED_HEALTH_RED = 25,
+	LED_HEALTH_AMBER = 26,
+	PWR_BTN_INT = 27,
+	UID_PRESS_INT = 28,
+	SLP_INT = 29,
+	ACM_FORCE_OFF = 30,
+	ACM_REMOVED = 31,
+	ACM_REQ_N = 32,
+	PSU1_INST = 33,
+	PSU2_INST = 34,
+	PSU3_INST = 35,
+	PSU4_INST = 36,
+	PSU5_INST = 37,
+	PSU6_INST = 38,
+	PSU7_INST = 39,
+	PSU8_INST = 40,
+	PSU1_AC = 41,
+	PSU2_AC = 42,
+	PSU3_AC = 43,
+	PSU4_AC = 44,
+	PSU5_AC = 45,
+	PSU6_AC = 46,
+	PSU7_AC = 47,
+	PSU8_AC = 48,
+	PSU1_DC = 49,
+	PSU2_DC = 50,
+	PSU3_DC = 51,
+	PSU4_DC = 52,
+	PSU5_DC = 53,
+	PSU6_DC = 54,
+	PSU7_DC = 55,
+	PSU8_DC = 56,
+	RESET = 57,
+	NMI_OUT = 58,
+	VPBTN = 59,
+	PGOOD = 60,
+	PERST = 61,
+	POST_COMPLETE = 62,
+};
+
+/* Remember last PSU config */
+u8 psu_presence;
+
+struct gxp_gpio_drvdata {
+	struct regmap *base;
+	struct regmap *interrupt;
+	struct gpio_chip chip;
+	int irq;
+};
+
+static struct regmap *gxp_gpio_init_regmap(struct platform_device *pdev,
+					   char *reg_name, u8 bits)
+{
+	struct regmap_config regmap_config = {
+		.reg_bits = 32,
+		.reg_stride = 4,
+		.val_bits = 32,
+	};
+	void __iomem *base;
+
+	if (bits == 8) {
+		regmap_config.reg_bits = 8;
+		regmap_config.reg_stride = 1;
+		regmap_config.val_bits = 8;
+		regmap_config.max_register = 0xff;
+	}
+
+	base = devm_platform_ioremap_resource_byname(pdev, reg_name);
+	if (IS_ERR(base))
+		return ERR_CAST(base);
+
+	regmap_config.name = reg_name;
+
+	return devm_regmap_init_mmio(&pdev->dev, base, &regmap_config);
+}
+
+static int gxp_gpio_pl_get(struct gpio_chip *chip, unsigned int offset)
+{
+	struct gxp_gpio_drvdata *drvdata = dev_get_drvdata(chip->parent);
+	unsigned int val;
+	int ret = 0;
+
+	switch (offset) {
+	case IOP_LED1 ... IOP_LED8:
+		regmap_read(drvdata->base, PLREG_IOP_LED, &val);
+		ret = (val & BIT(offset)) ? 1 : 0;
+		break;
+	case FAN1_INST ...FAN8_INST:
+		regmap_read(drvdata->base, PLREG_FAN_INST, &val);
+		ret = (val & BIT((offset - FAN1_INST))) ? 1 : 0;
+		break;
+	case FAN1_FAIL ... FAN8_FAIL:
+		regmap_read(drvdata->base, PLREG_FAN_FAIL, &val);
+		ret = (val & BIT((offset - FAN1_FAIL))) ? 1 : 0;
+		break;
+	case PWR_BTN_INT ... SLP_INT:
+		regmap_read(drvdata->base, PLREG_INT_GRP5_FLAG, &val);
+		/* Active low */
+		ret = (val & BIT((offset - PWR_BTN_INT) + 16)) ? 0 : 1;
+		break;
+	case  PSU1_INST ... PSU8_INST:
+		regmap_read(drvdata->base, PLREG_PSU_INST, &val);
+		psu_presence = (u8)val;
+		ret = (psu_presence & BIT((offset - PSU1_INST))) ? 1 : 0;
+		break;
+	case PSU1_AC ... PSU8_AC:
+		regmap_read(drvdata->base, PLREG_PSU_AC, &val);
+		ret = (val & BIT((offset - PSU1_AC))) ? 1 : 0;
+		break;
+	case PSU1_DC ... PSU8_DC:
+		regmap_read(drvdata->base, PLREG_PSU_DC, &val);
+		ret = (val & BIT((offset - PSU1_DC))) ? 1 : 0;
+		break;
+	default:
+		break;
+	}
+
+	return ret;
+}
+
+static void gxp_gpio_pl_set(struct gpio_chip *chip,
+			    unsigned int offset, int value)
+{
+	struct gxp_gpio_drvdata *drvdata = dev_get_drvdata(chip->parent);
+
+	switch (offset) {
+	case IOP_LED1 ... IOP_LED8:
+		regmap_update_bits(drvdata->base,
+				   PLREG_IOP_LED,
+				   BIT(offset),
+				   value == 0 ? 0 : BIT(offset));
+		break;
+	case LED_IDENTIFY:
+		regmap_update_bits(drvdata->base,
+				   PLREG_IDENT_LED,
+				   BIT(7) | BIT(6),
+				   value == 0 ? BIT(7) : BIT(7) | BIT(6));
+		break;
+	case LED_HEALTH_RED:
+		regmap_update_bits(drvdata->base,
+				   PLREG_HEALTH_LED,
+				   BIT(7),
+				   value == 0 ? 0 : BIT(7));
+		break;
+	case LED_HEALTH_AMBER:
+		regmap_update_bits(drvdata->base,
+				   PLREG_HEALTH_LED,
+				   BIT(6),
+				   value == 0 ? 0 : BIT(6));
+		break;
+	default:
+		break;
+	}
+}
+
+static int gxp_gpio_pl_get_direction(struct gpio_chip *chip, unsigned int offset)
+{
+	int ret = GXP_GPIO_DIR_IN;
+
+	switch (offset) {
+	case IOP_LED1 ... IOP_LED8:
+	case LED_IDENTIFY ... LED_HEALTH_AMBER:
+	case ACM_FORCE_OFF:
+	case ACM_REQ_N:
+		ret = GXP_GPIO_DIR_OUT;
+		break;
+	default:
+		break;
+	}
+
+	return ret;
+}
+
+static int gxp_gpio_pl_direction_input(struct gpio_chip *chip,
+				       unsigned int offset)
+{
+	int ret = -EOPNOTSUPP;
+
+	switch (offset) {
+	case 8 ... 55:
+		ret = GXP_GPIO_DIR_OUT;
+		break;
+	case 59 ... 65:
+		ret = GXP_GPIO_DIR_OUT;
+		break;
+	default:
+		break;
+	}
+
+	return ret;
+}
+
+static int gxp_gpio_pl_direction_output(struct gpio_chip *chip,
+					unsigned int offset, int value)
+{
+	int ret = -EOPNOTSUPP;
+
+	switch (offset) {
+	case IOP_LED1 ... IOP_LED8:
+	case LED_IDENTIFY ... LED_HEALTH_AMBER:
+	case ACM_FORCE_OFF:
+	case ACM_REQ_N:
+		gxp_gpio_pl_set(chip, offset, value);
+		ret = GXP_GPIO_DIR_OUT;
+		break;
+	default:
+		break;
+	}
+
+	return ret;
+}
+
+static void gxp_gpio_pl_irq_ack(struct irq_data *d)
+{
+	struct gpio_chip *chip = irq_data_get_irq_chip_data(d);
+	struct gxp_gpio_drvdata *drvdata = dev_get_drvdata(chip->parent);
+	unsigned int val;
+
+	/* Read latched interrupt for group 5 */
+	regmap_read(drvdata->interrupt, PLREG_INT_GRP5_FLAG, &val);
+	/* Clear latched interrupt */
+	regmap_update_bits(drvdata->interrupt, PLREG_INT_GRP5_FLAG,
+			   0xFF, 0xFF);
+
+	/* Read latched interrupt for group 6 */
+	regmap_read(drvdata->interrupt, PLREG_INT_GRP6_FLAG, &val);
+	/* Clear latched interrupt */
+	regmap_update_bits(drvdata->interrupt, PLREG_INT_GRP6_FLAG,
+			   0xFF, 0xFF);
+}
+
+static void gxp_gpio_pl_irq_set_mask(struct irq_data *d, bool set)
+{
+	struct gpio_chip *chip = irq_data_get_irq_chip_data(d);
+	struct gxp_gpio_drvdata *drvdata = dev_get_drvdata(chip->parent);
+
+	regmap_update_bits(drvdata->interrupt, PLREG_INT_GRP5_BASE,
+			   BIT(0) | BIT(2), set ? 0 : BIT(0) | BIT(2));
+
+	regmap_update_bits(drvdata->interrupt, PLREG_INT_GRP6_BASE,
+			   BIT(2), set ? 0 : BIT(2));
+}
+
+static void gxp_gpio_pl_irq_mask(struct irq_data *d)
+{
+	gxp_gpio_pl_irq_set_mask(d, false);
+}
+
+static void gxp_gpio_pl_irq_unmask(struct irq_data *d)
+{
+	gxp_gpio_pl_irq_set_mask(d, true);
+}
+
+static int gxp_gpio_irq_init_hw(struct gpio_chip *chip)
+{
+	struct gxp_gpio_drvdata *drvdata = dev_get_drvdata(chip->parent);
+
+	regmap_update_bits(drvdata->interrupt, PLREG_INT_GRP5_BASE,
+			   BIT(0) | BIT(2), 0);
+
+	regmap_update_bits(drvdata->interrupt, PLREG_INT_GRP6_BASE,
+			   BIT(2), 0);
+
+	return 0;
+}
+
+static int gxp_gpio_pl_set_type(struct irq_data *d, unsigned int type)
+{
+	if (type & IRQ_TYPE_LEVEL_MASK)
+		irq_set_handler_locked(d, handle_level_irq);
+	else
+		irq_set_handler_locked(d, handle_edge_irq);
+
+	return 0;
+}
+
+static irqreturn_t gxp_gpio_pl_irq_handle(int irq, void *_drvdata)
+{
+	struct gxp_gpio_drvdata *drvdata = (struct gxp_gpio_drvdata *)_drvdata;
+	unsigned int val, girq, i;
+
+	/* Check group 5 interrupts */
+
+	regmap_read(drvdata->base, PLREG_INT_GRP5_FLAG, &val);
+
+	if (val) {
+		for_each_set_bit(i, (unsigned long *)&val, 3) {
+			girq = irq_find_mapping(drvdata->chip.irq.domain,
+						i + PWR_BTN_INT);
+			generic_handle_irq(girq);
+		}
+
+		/* Clear latched interrupt */
+		regmap_update_bits(drvdata->interrupt, PLREG_INT_GRP5_FLAG,
+				   0xFF, 0xFF);
+		regmap_update_bits(drvdata->interrupt, PLREG_INT_GRP5_BASE,
+				   BIT(0) | BIT(2), 0);
+	}
+
+	/* Check group 6 interrupts */
+
+	regmap_read(drvdata->base, PLREG_INT_GRP6_FLAG, &val);
+
+	if (val & BIT(2)) {
+		u8 old_psu = psu_presence;
+
+		regmap_read(drvdata->base, PLREG_PSU_INST, &val);
+		psu_presence = (u8)val;
+
+		if (old_psu != psu_presence) {
+			/* Identify all bits which differs */
+			u8 current_val = psu_presence;
+			u8 old_val = old_psu;
+
+			for (i = 0 ; i < 8 ; i++) {
+				if ((current_val & 0x1) != (old_val & 0x1)) {
+				/* PSU state has changed */
+					girq = irq_find_mapping(drvdata->chip.irq.domain,
+								i + PSU1_INST);
+					if (girq)
+						generic_handle_irq(girq);
+				}
+				current_val = current_val >> 1;
+				old_val = old_val >> 1;
+			}
+		}
+	}
+
+	/* Clear latched interrupt */
+	regmap_update_bits(drvdata->interrupt, PLREG_INT_GRP6_FLAG,
+			   0xFF, 0xFF);
+	regmap_update_bits(drvdata->interrupt, PLREG_INT_GRP6_BASE,
+			   BIT(2), 0);
+
+	return IRQ_HANDLED;
+}
+
+static struct gpio_chip plreg_chip = {
+	.label			= "gxp_gpio_plreg",
+	.owner			= THIS_MODULE,
+	.get			= gxp_gpio_pl_get,
+	.set			= gxp_gpio_pl_set,
+	.get_direction = gxp_gpio_pl_get_direction,
+	.direction_input = gxp_gpio_pl_direction_input,
+	.direction_output = gxp_gpio_pl_direction_output,
+	.base = -1,
+};
+
+static struct irq_chip gxp_plreg_irqchip = {
+	.name		= "gxp_plreg",
+	.irq_ack	= gxp_gpio_pl_irq_ack,
+	.irq_mask	= gxp_gpio_pl_irq_mask,
+	.irq_unmask	= gxp_gpio_pl_irq_unmask,
+	.irq_set_type	= gxp_gpio_pl_set_type,
+};
+
+static int gxp_gpio_pl_init(struct platform_device *pdev)
+{
+	struct gxp_gpio_drvdata *drvdata = dev_get_drvdata(&pdev->dev);
+	struct gpio_irq_chip *girq;
+	int ret;
+	unsigned int val;
+
+	drvdata->base = gxp_gpio_init_regmap(pdev, "base", 8);
+	if (IS_ERR(drvdata->base))
+		return dev_err_probe(&pdev->dev, PTR_ERR(drvdata->base),
+				     "failed to map base\n");
+
+	drvdata->interrupt = gxp_gpio_init_regmap(pdev, "interrupt", 8);
+	if (IS_ERR(drvdata->interrupt))
+		return dev_err_probe(&pdev->dev, PTR_ERR(drvdata->interrupt),
+				     "failed to map interrupt base\n");
+
+	regmap_read(drvdata->base, PLREG_PSU_INST, &val);
+	psu_presence = (u8)val;
+
+	drvdata->chip = plreg_chip;
+	drvdata->chip.ngpio = 57;
+	drvdata->chip.parent = &pdev->dev;
+
+	girq = &drvdata->chip.irq;
+	girq->chip = &gxp_plreg_irqchip;
+	girq->parent_handler = NULL;
+	girq->num_parents = 0;
+	girq->parents = NULL;
+	girq->default_type = IRQ_TYPE_NONE;
+	girq->handler = handle_bad_irq;
+
+	girq->init_hw = gxp_gpio_irq_init_hw;
+
+	ret = devm_gpiochip_add_data(&pdev->dev, &drvdata->chip, drvdata);
+	if (ret < 0)
+		dev_err_probe(&pdev->dev, ret, "Could not register gpiochip for plreg\n");
+
+	regmap_update_bits(drvdata->base,
+			   PLREG_INT_HI_PRI_EN,
+			   PLREG_GRP4_GRP5_MASK,
+			   PLREG_GRP4_GRP5_MASK);
+	regmap_update_bits(drvdata->base,
+			   PLREG_INT_GRP_STAT_MASK,
+			   PLREG_GRP4_GRP5_MASK,
+			   0x00);
+	regmap_read(drvdata->base, PLREG_INT_HI_PRI_EN, &val);
+	regmap_read(drvdata->base, PLREG_INT_GRP_STAT_MASK, &val);
+
+	ret = platform_get_irq(pdev, 0);
+	if (ret < 0)
+		return dev_err_probe(&pdev->dev, ret, "Get irq from platform fail\n");
+
+	drvdata->irq = ret;
+
+	ret = devm_request_irq(&pdev->dev, drvdata->irq, gxp_gpio_pl_irq_handle,
+			       IRQF_SHARED, "gxp-pl", drvdata);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static const struct of_device_id gxp_gpio_of_match[] = {
+	{ .compatible = "hpe,gxp-gpio-pl" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, gxp_gpio_of_match);
+
+static int gxp_gpio_probe(struct platform_device *pdev)
+{
+	int ret;
+	struct gxp_gpio_drvdata *drvdata;
+
+	/* Initialize global vars */
+	psu_presence = 0;
+
+	drvdata = devm_kzalloc(&pdev->dev, sizeof(*drvdata), GFP_KERNEL);
+	if (!drvdata)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, drvdata);
+
+	ret = gxp_gpio_pl_init(pdev);
+
+	return ret;
+}
+
+static struct platform_driver gxp_gpio_driver = {
+	.driver = {
+		.name = "gxp-gpio-pl",
+		.of_match_table = gxp_gpio_of_match,
+	},
+	.probe = gxp_gpio_probe,
+};
+module_platform_driver(gxp_gpio_driver);
+
+MODULE_AUTHOR("Nick Hawkins <nick.hawkins@hpe.com>");
+MODULE_DESCRIPTION("GPIO PL interface for GXP");
+MODULE_LICENSE("GPL");
diff --git a/drivers/gpio/gpio-gxp.c b/drivers/gpio/gpio-gxp.c
new file mode 100644
index 000000000000..ed6d8577e6b7
--- /dev/null
+++ b/drivers/gpio/gpio-gxp.c
@@ -0,0 +1,637 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (C) 2023 Hewlett-Packard Enterprise Development Company, L.P. */
+
+#include <linux/gpio/driver.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
+#include <linux/regmap.h>
+
+#define GPIDAT		0x040
+#define GPODAT		0x0b0
+#define GPODAT2		0x0f8
+#define GPOOWN		0x110
+#define GPOOWN2		0x118
+#define ASR_OFS		0x05c
+
+#define GXP_GPIO_DIR_OUT	0
+#define GXP_GPIO_DIR_IN		1
+
+#define PGOOD_MASK	BIT(0)
+
+struct gxp_gpio_drvdata {
+	struct gpio_chip chip;
+	struct regmap *csm_map;
+	void __iomem *fn2_vbtn;
+	struct regmap *fn2_stat;
+	struct regmap *vuhc0_map;
+	int irq;
+};
+
+/*
+ * Note: Instead of definining all PINs here are the select few that
+ * are specifically defined in DTS and offsets are used here.
+ */
+enum gxp_gpio_pn {
+	RESET = 192,
+	VPBTN = 210, /* aka POWER_OK */
+	PGOOD = 211, /* aka PS_PWROK */
+	PERST = 212, /* aka PCIERST */
+	POST_COMPLETE = 213,
+};
+
+static int gxp_gpio_csm_get(struct gpio_chip *chip, unsigned int offset)
+{
+	struct gxp_gpio_drvdata *drvdata = dev_get_drvdata(chip->parent);
+	int ret = 0;
+
+	switch (offset) {
+	case 0 ... 31:
+		regmap_read(drvdata->csm_map, GPIDAT, &ret);
+		ret = (ret & BIT(offset));
+		break;
+	case 32 ... 63:
+		regmap_read(drvdata->csm_map, GPIDAT + 0x20, &ret);
+		ret = (ret & BIT(offset - 32));
+		break;
+	case 64 ... 95:
+		regmap_read(drvdata->csm_map, GPODAT, &ret);
+		ret = (ret & BIT(offset - 64));
+		break;
+	case 96 ... 127:
+		regmap_read(drvdata->csm_map, GPODAT + 0x04, &ret);
+		ret = (ret & BIT(offset - 96));
+		break;
+	case 128 ...  159:
+		regmap_read(drvdata->csm_map, GPODAT2, &ret);
+		ret = (ret & BIT(offset - 128));
+		break;
+	case 160 ... 191:
+		regmap_read(drvdata->csm_map, GPODAT2 + 0x04, &ret);
+		ret = (ret & BIT(offset - 160));
+		break;
+	case RESET:
+		/* SW_RESET */
+		regmap_read(drvdata->csm_map, ASR_OFS, &ret);
+		ret = (ret & BIT(15));
+		break;
+	default:
+		break;
+	}
+
+	/* Return either 1 or 0 */
+	return (ret ? 1 : 0);
+}
+
+static void gxp_gpio_csm_set(struct gpio_chip *chip, unsigned int offset,
+			     int value)
+{
+	struct gxp_gpio_drvdata *drvdata = dev_get_drvdata(chip->parent);
+	u32 tmp;
+
+	switch (offset) {
+	case 64 ... 95:
+		/* Keep ownership setting */
+		regmap_read(drvdata->csm_map, GPOOWN, &tmp);
+		tmp = (tmp & BIT(offset - 64)) ? 1 : 0;
+
+		regmap_update_bits(drvdata->csm_map, GPOOWN,
+				   BIT(offset - 64), BIT(offset - 64));
+		regmap_update_bits(drvdata->csm_map, GPODAT,
+				   BIT(offset - 64), value ? BIT(offset - 64) : 0);
+
+		/* Restore ownership setting */
+		regmap_update_bits(drvdata->csm_map, GPOOWN,
+				   BIT(offset - 64), tmp ? BIT(offset - 64) : 0);
+		break;
+	case 96 ... 127:
+		/* Keep ownership setting */
+		regmap_read(drvdata->csm_map, GPOOWN + 0x04, &tmp);
+		tmp = (tmp & BIT(offset - 96)) ? 1 : 0;
+
+		regmap_update_bits(drvdata->csm_map, GPOOWN + 0x04,
+				   BIT(offset - 96), BIT(offset - 96));
+		regmap_update_bits(drvdata->csm_map, GPODAT + 0x04,
+				   BIT(offset - 96), value ? BIT(offset - 96) : 0);
+
+		/* Restore ownership setting */
+		regmap_update_bits(drvdata->csm_map, GPOOWN + 0x04,
+				   BIT(offset - 96), tmp ? BIT(offset - 96) : 0);
+		break;
+	case 128 ... 159:
+		/* Keep ownership setting */
+		regmap_read(drvdata->csm_map, GPOOWN2, &tmp);
+		tmp = (tmp & BIT(offset - 128)) ? 1 : 0;
+
+		regmap_update_bits(drvdata->csm_map, GPOOWN2,
+				   BIT(offset - 128), BIT(offset - 128));
+		regmap_update_bits(drvdata->csm_map, GPODAT2,
+				   BIT(offset - 128), value ? BIT(offset - 128) : 0);
+
+		/* Restore ownership setting */
+		regmap_update_bits(drvdata->csm_map, GPOOWN2,
+				   BIT(offset - 128), tmp ? BIT(offset - 128) : 0);
+		break;
+	case 160 ... 191:
+		/* Keep ownership setting */
+		regmap_read(drvdata->csm_map, GPOOWN2 + 0x04,	&tmp);
+		tmp = (tmp & BIT(offset - 160)) ? 1 : 0;
+
+		regmap_update_bits(drvdata->csm_map, GPOOWN2 + 0x04,
+				   BIT(offset - 160), BIT(offset - 160));
+		regmap_update_bits(drvdata->csm_map, GPODAT2 + 0x04,
+				   BIT(offset - 160), value ? BIT(offset - 160) : 0);
+
+		/* Restore ownership setting */
+		regmap_update_bits(drvdata->csm_map, GPOOWN2 + 0x04,
+				   BIT(offset - 160), tmp ? BIT(offset - 160) : 0);
+		break;
+	case 192:
+		if (value) {
+			regmap_update_bits(drvdata->csm_map, ASR_OFS,
+					   BIT(0), BIT(0));
+			regmap_update_bits(drvdata->csm_map, ASR_OFS,
+					   BIT(15), BIT(15));
+		} else {
+			regmap_update_bits(drvdata->csm_map, ASR_OFS,
+					   BIT(15), 0);
+		}
+		break;
+	default:
+		break;
+	}
+}
+
+static int gxp_gpio_csm_get_direction(struct gpio_chip *chip,
+				      unsigned int offset)
+{
+	int ret = 0;
+
+	switch (offset) {
+	case 0 ... 63:
+		ret = GXP_GPIO_DIR_IN;
+		break;
+	case 64 ... 191:
+		ret = GXP_GPIO_DIR_OUT;
+		break;
+	case 192 ... 193:
+		ret = GXP_GPIO_DIR_OUT;
+		break;
+	case 194:
+		ret = GXP_GPIO_DIR_IN;
+		break;
+	default:
+		break;
+	}
+
+	return ret;
+}
+
+static int gxp_gpio_csm_direction_input(struct gpio_chip *chip,
+					unsigned int offset)
+{
+	int ret = -EOPNOTSUPP;
+
+	switch (offset) {
+	case 0 ... 63:
+		ret = 0;
+		break;
+	case 194:
+		ret = 0;
+		break;
+	default:
+		break;
+	}
+
+	return ret;
+}
+
+static int gxp_gpio_csm_direction_output(struct gpio_chip *chip,
+					 unsigned int offset, int value)
+{
+	int ret = -EOPNOTSUPP;
+
+	switch (offset) {
+	case 64 ... 191:
+	case 192 ... 193:
+		gxp_gpio_csm_set(chip, offset, value);
+		ret = 0;
+		break;
+	default:
+		break;
+	}
+
+	return ret;
+}
+
+static int gxp_gpio_vuhc_get(struct gpio_chip *chip, unsigned int offset)
+{
+	struct gxp_gpio_drvdata *drvdata = dev_get_drvdata(chip->parent);
+	unsigned int val;
+	int ret = 0;
+
+	if (offset < 8) {
+		regmap_read(drvdata->vuhc0_map, 0x64 + 4 * offset,   &val);
+		ret = (val & BIT(13)) ? 1 : 0;
+	}
+
+	return ret;
+}
+
+static void gxp_gpio_vuhc_set(struct gpio_chip *chip, unsigned int offset,
+			      int value)
+{
+	switch (offset) {
+	default:
+		break;
+	}
+}
+
+static int gxp_gpio_vuhc_get_direction(struct gpio_chip *chip,
+				       unsigned int offset)
+{
+	int ret = 0;
+
+	switch (offset) {
+	case 0:
+	case 1:
+	case 2:
+		ret = GXP_GPIO_DIR_IN;
+		break;
+	default:
+		break;
+	}
+
+	return ret;
+}
+
+static int gxp_gpio_vuhc_direction_input(struct gpio_chip *chip,
+					 unsigned int offset)
+{
+	int ret = -EOPNOTSUPP;
+
+	switch (offset) {
+	case 0:
+	case 1:
+	case 2:
+		ret = 0;
+		break;
+	default:
+		break;
+	}
+
+	return ret;
+}
+
+static int gxp_gpio_vuhc_direction_output(struct gpio_chip *chip,
+					  unsigned int offset, int value)
+{
+	int ret = -EOPNOTSUPP;
+
+	switch (offset) {
+	default:
+		break;
+	}
+
+	return ret;
+}
+
+static int gxp_gpio_fn2_get(struct gpio_chip *chip, unsigned int offset)
+{
+	struct gxp_gpio_drvdata *drvdata = dev_get_drvdata(chip->parent);
+	unsigned int val;
+	int ret = 0;
+
+	switch (offset) {
+	case PGOOD:
+		regmap_read(drvdata->fn2_stat, 0, &val);
+		ret = (val & BIT(24));
+
+		break;
+	case PERST:
+		regmap_read(drvdata->fn2_stat, 0, &val);
+		ret = (val & BIT(25));
+
+		break;
+	default:
+		break;
+	}
+
+	/* Return either 1 or 0 */
+	return (ret ? 1 : 0);
+}
+
+static void gxp_gpio_fn2_set(struct gpio_chip *chip, unsigned int offset,
+			     int value)
+{
+	struct gxp_gpio_drvdata *drvdata = dev_get_drvdata(chip->parent);
+
+	switch (offset) {
+	case VPBTN:
+		writeb(1, drvdata->fn2_vbtn);
+		break;
+	default:
+		break;
+	}
+}
+
+static int gxp_gpio_fn2_get_direction(struct gpio_chip *chip,
+				      unsigned int offset)
+{
+	int ret = GXP_GPIO_DIR_IN;
+
+	switch (offset) {
+	case VPBTN:
+		ret = GXP_GPIO_DIR_OUT;
+		break;
+	default:
+		break;
+	}
+
+	return ret;
+}
+
+static int gxp_gpio_fn2_direction_input(struct gpio_chip *chip,
+					unsigned int offset)
+{
+	int ret = -EOPNOTSUPP;
+
+	switch (offset) {
+	case PGOOD:
+	case PERST:
+	case POST_COMPLETE:
+		ret = 0;
+		break;
+	default:
+		break;
+	}
+
+	return ret;
+}
+
+static int gxp_gpio_get(struct gpio_chip *chip, unsigned int offset)
+{
+	int ret = 0;
+
+	if (offset < 200)
+		ret = gxp_gpio_csm_get(chip, offset);
+	else if (offset >= 250 && offset < 300)
+		ret = gxp_gpio_vuhc_get(chip, offset - 250);
+	else if (offset >= 300)
+		ret = gxp_gpio_fn2_get(chip, offset);
+
+	return ret;
+}
+
+static void gxp_gpio_set(struct gpio_chip *chip,
+			 unsigned int offset, int value)
+{
+	if (offset < 200)
+		gxp_gpio_csm_set(chip, offset, value);
+	else if (offset >= 250 && offset < 300)
+		gxp_gpio_vuhc_set(chip, offset - 250, value);
+	else if (offset >= 300)
+		gxp_gpio_fn2_set(chip, offset, value);
+}
+
+static int gxp_gpio_get_direction(struct gpio_chip *chip,
+				  unsigned int offset)
+{
+	int ret = 0;
+
+	if (offset < 200)
+		ret = gxp_gpio_csm_get_direction(chip, offset);
+	else if (offset >= 250 && offset < 300)
+		ret = gxp_gpio_vuhc_get_direction(chip, offset - 250);
+	else if (offset >= 300)
+		ret = gxp_gpio_fn2_get_direction(chip, offset);
+
+	return ret;
+}
+
+static int gxp_gpio_direction_input(struct gpio_chip *chip,
+				    unsigned int offset)
+{
+	int ret = 0;
+
+	if (offset < 200)
+		ret = gxp_gpio_csm_direction_input(chip, offset);
+	else if (offset >= 250 && offset < 300)
+		ret = gxp_gpio_vuhc_direction_input(chip, offset - 250);
+	else if (offset >= 300)
+		ret = gxp_gpio_fn2_direction_input(chip, offset);
+
+	return ret;
+}
+
+static int gxp_gpio_direction_output(struct gpio_chip *chip,
+				     unsigned int offset, int value)
+{
+	int ret = 0;
+
+	if (offset < 200)
+		ret = gxp_gpio_csm_direction_output(chip, offset, value);
+	else if (offset >= 250 && offset < 300)
+		ret = gxp_gpio_vuhc_direction_output(chip, offset - 250, value);
+	return ret;
+}
+
+static struct regmap *gxp_gpio_init_regmap(struct platform_device *pdev,
+					   char *reg_name, u8 bits)
+{
+	struct regmap_config regmap_config = {
+		.reg_bits = 32,
+		.reg_stride = 4,
+		.val_bits = 32,
+	};
+	void __iomem *base;
+
+	if (bits == 8) {
+		regmap_config.reg_bits = 8;
+		regmap_config.reg_stride = 1;
+		regmap_config.val_bits = 8;
+		regmap_config.max_register = 0xff;
+	}
+
+	base = devm_platform_ioremap_resource_byname(pdev, reg_name);
+	if (IS_ERR(base))
+		return ERR_CAST(base);
+
+	regmap_config.name = reg_name;
+
+	return devm_regmap_init_mmio(&pdev->dev, base, &regmap_config);
+}
+
+static void gxp_gpio_fn2_irq_ack(struct irq_data *d)
+{
+	struct gpio_chip *chip = irq_data_get_irq_chip_data(d);
+	struct gxp_gpio_drvdata *drvdata = dev_get_drvdata(chip->parent);
+	unsigned int val;
+
+	/* Read latched interrupt */
+	regmap_read(drvdata->fn2_stat, 0, &val);
+	/* Clear latched interrupt */
+	regmap_update_bits(drvdata->fn2_stat, 0,
+			   0xFFFF, 0xFFFF);
+}
+
+#define FN2_SEVMASK BIT(2)
+static void gxp_gpio_fn2_irq_set_mask(struct irq_data *d, bool set)
+{
+	struct gpio_chip *chip = irq_data_get_irq_chip_data(d);
+	struct gxp_gpio_drvdata *drvdata = dev_get_drvdata(chip->parent);
+
+	regmap_update_bits(drvdata->fn2_stat, FN2_SEVMASK,
+			   BIT(0), set ? BIT(0) : 0);
+}
+
+static void gxp_gpio_fn2_irq_mask(struct irq_data *d)
+{
+	gxp_gpio_fn2_irq_set_mask(d, false);
+}
+
+static void gxp_gpio_fn2_irq_unmask(struct irq_data *d)
+{
+	gxp_gpio_fn2_irq_set_mask(d, true);
+}
+
+static int gxp_gpio_fn2_set_type(struct irq_data *d, unsigned int type)
+{
+	if (type & IRQ_TYPE_LEVEL_MASK)
+		irq_set_handler_locked(d, handle_level_irq);
+	else
+		irq_set_handler_locked(d, handle_edge_irq);
+
+	return 0;
+}
+
+static irqreturn_t gxp_gpio_fn2_irq_handle(int irq, void *_drvdata)
+{
+	struct gxp_gpio_drvdata *drvdata = (struct gxp_gpio_drvdata *)_drvdata;
+	unsigned int val, girq;
+
+	regmap_read(drvdata->fn2_stat, 0, &val);
+
+	if (val & PGOOD_MASK) {
+		girq = irq_find_mapping(drvdata->chip.irq.domain, PGOOD);
+		generic_handle_irq(girq);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static struct irq_chip gxp_gpio_irqchip = {
+	.name		= "gxp_fn2",
+	.irq_ack	= gxp_gpio_fn2_irq_ack,
+	.irq_mask	= gxp_gpio_fn2_irq_mask,
+	.irq_unmask	= gxp_gpio_fn2_irq_unmask,
+	.irq_set_type	= gxp_gpio_fn2_set_type,
+};
+
+static struct gpio_chip common_chip = {
+	.label			= "gxp_gpio",
+	.owner                  = THIS_MODULE,
+	.get                    = gxp_gpio_get,
+	.set                    = gxp_gpio_set,
+	.get_direction		= gxp_gpio_get_direction,
+	.direction_input	= gxp_gpio_direction_input,
+	.direction_output	= gxp_gpio_direction_output,
+	.base = 0,
+};
+
+static int gxp_gpio_init(struct platform_device *pdev)
+{
+	struct gxp_gpio_drvdata *drvdata = dev_get_drvdata(&pdev->dev);
+	struct gpio_irq_chip *girq;
+	int ret;
+
+	drvdata->csm_map = gxp_gpio_init_regmap(pdev, "csm", 32);
+	if (IS_ERR(drvdata->csm_map))
+		return dev_err_probe(&pdev->dev, PTR_ERR(drvdata->csm_map),
+				     "failed to map csm_handle\n");
+
+	drvdata->fn2_vbtn = devm_platform_ioremap_resource_byname(pdev, "fn2-vbtn");
+	if (IS_ERR(drvdata->fn2_vbtn))
+		return dev_err_probe(&pdev->dev, PTR_ERR(drvdata->fn2_vbtn),
+				     "failed to map fn2_vbtn\n");
+
+	drvdata->fn2_stat = gxp_gpio_init_regmap(pdev, "fn2-stat", 32);
+	if (IS_ERR(drvdata->fn2_stat))
+		return dev_err_probe(&pdev->dev, PTR_ERR(drvdata->fn2_stat),
+				     "failed to map fn2_stat\n");
+
+	drvdata->vuhc0_map = gxp_gpio_init_regmap(pdev, "vuhc", 32);
+	if (IS_ERR(drvdata->vuhc0_map))
+		return dev_err_probe(&pdev->dev, PTR_ERR(drvdata->vuhc0_map),
+				     "failed to map vuhc0_map\n");
+
+	girq = &drvdata->chip.irq;
+	girq->chip = &gxp_gpio_irqchip;
+	girq->parent_handler = NULL;
+	girq->num_parents = 0;
+	girq->parents = NULL;
+	girq->default_type = IRQ_TYPE_NONE;
+	girq->handler = handle_bad_irq;
+
+	ret = platform_get_irq(pdev, 0);
+	if (ret < 0)
+		return dev_err_probe(&pdev->dev, ret,
+				     "Get irq from platform fail\n");
+
+	drvdata->irq = ret;
+
+	ret = devm_request_irq(&pdev->dev, drvdata->irq, gxp_gpio_fn2_irq_handle,
+			       IRQF_SHARED, "gxp-fn2", drvdata);
+	if (ret < 0)
+		return ret;
+
+	drvdata->chip = common_chip;
+	drvdata->chip.ngpio = 220;
+
+	drvdata->chip.parent = &pdev->dev;
+	ret = devm_gpiochip_add_data(&pdev->dev, &drvdata->chip, NULL);
+	if (ret < 0)
+		return dev_err_probe(&pdev->dev, ret,
+			"Could not register gpiochip for fn2\n");
+
+	return 0;
+}
+
+static const struct of_device_id gxp_gpio_of_match[] = {
+	{ .compatible = "hpe,gxp-gpio" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, gxp_gpio_of_match);
+
+static int gxp_gpio_probe(struct platform_device *pdev)
+{
+	int ret;
+	struct gxp_gpio_drvdata *drvdata;
+
+	drvdata = devm_kzalloc(&pdev->dev, sizeof(*drvdata), GFP_KERNEL);
+	if (!drvdata)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, drvdata);
+
+	ret = gxp_gpio_init(pdev);
+
+	return ret;
+}
+
+static struct platform_driver gxp_gpio_driver = {
+	.driver = {
+		.name = "gxp-gpio",
+		.of_match_table = gxp_gpio_of_match,
+	},
+	.probe = gxp_gpio_probe,
+};
+module_platform_driver(gxp_gpio_driver);
+
+MODULE_AUTHOR("Nick Hawkins <nick.hawkins@hpe.com>");
+MODULE_DESCRIPTION("GPIO interface for GXP");
+MODULE_LICENSE("GPL");
-- 
2.17.1

