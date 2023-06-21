Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5D097391B2
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 23:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbjFUVgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 17:36:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230420AbjFUVf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 17:35:57 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4CEA19B9;
        Wed, 21 Jun 2023 14:35:51 -0700 (PDT)
Received: from pps.filterd (m0134421.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35LL290f011935;
        Wed, 21 Jun 2023 21:35:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=pps0720;
 bh=ZaAMxQm6m/mGUMJTQ+5RfplSyslHC7ztGaUYxxke++8=;
 b=Ahx1Qvtec46KtgEDJJMQLuwNkv+ARdSPUpSSJc3jhj5KVc/fz6zDXSfyjkVLD5bkG7CU
 xChWxalG+EB/+pKTetoFYUwOU4CgdE1ZROFu1AzVga+MHxG8brd9PkQILyuVp1GBhVAA
 k7kbbCyAg33ku+PEM17mfXuCX7In8wtjLqnjxDRyi/Ub55zdlOZYbUAWY/vQKnMdDJwf
 mt6HcWy2dBbVmDf4/CDXQIqK3Hi9Ka21sN1iv2fTjDh29wwHUarb17N949/6d91vflRo
 ciwhJWbbSdMSfr8u/Uu6K5uSg8TmY74PgS8VnZk6B0pQHWnUNud+qrE8CAxxiRv8RxSo iA== 
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3rbduf5s9t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Jun 2023 21:35:25 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14880.it.hpe.com (Postfix) with ESMTPS id 8792E800197;
        Wed, 21 Jun 2023 21:35:24 +0000 (UTC)
Received: from hpe.com (unknown [16.231.227.36])
        by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id F24F2801AF9;
        Wed, 21 Jun 2023 21:35:23 +0000 (UTC)
From:   nick.hawkins@hpe.com
To:     verdun@hpe.com, nick.hawkins@hpe.com, linus.walleij@linaro.org,
        brgl@bgdev.pl, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jdelvare@suse.com,
        linux@roeck-us.net, andy.shevchenko@gmail.com,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
Subject: [PATCH v4 2/5] gpio: gxp: Add HPE GXP GPIO PL
Date:   Wed, 21 Jun 2023 16:31:12 -0500
Message-Id: <20230621213115.113266-3-nick.hawkins@hpe.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230621213115.113266-1-nick.hawkins@hpe.com>
References: <20230621213115.113266-1-nick.hawkins@hpe.com>
X-Proofpoint-GUID: cyCojdnax8h9H-bGL-dkMCa02fmYCpDy
X-Proofpoint-ORIG-GUID: cyCojdnax8h9H-bGL-dkMCa02fmYCpDy
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-21_12,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 mlxscore=0 adultscore=0 phishscore=0 priorityscore=1501 mlxlogscore=999
 impostorscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306210181
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
CPLD and Host. The gpio-gxp-pl driver covers the CPLD which takes
physical I/O from the board and shares it with GXP via a proprietary
interface that maps the I/O onto a specific register area of the GXP.
This driver supports interrupts from the CPLD.

Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>

---
v4:
 *New commit: Broke GPIO into two different commits one for each driver
 *Explain psu_presence global
 *Moved gpio_chip to first in gxp_gpio_drvdata
 *Moved regmap_config out of function and made it static const
 *Removed unnecessary variables
 *Removed redundant conditional
 *Modified regmap_read switch statements to calculate offset and mask
  then read at end.
 *Removed use of -EOPNOTSUPP
 *Removed redundant casting
 *Switched generic_handle_irq -> generic_handle_domain_irq
 *Used GENMASK where applicable
 *Used bitmap_xor and for_each_bit_set
 *Made GPIO chip const and marked as a template (in the name)
 *Made irq_chip const and immutable
 *Removed casting in one case
 *Corrected check on devm_gpiochip_add_data
 *Remove dev_err_probe on platform_get_irq
 *Changed return 0 to devm_request_irq
 *Added debug FS call to enable reading of the server_id
v3:
 *Did not exist
v:2
 *Did not exist
v1:
 *Did not exist
---
 drivers/gpio/Kconfig       |   9 +
 drivers/gpio/Makefile      |   1 +
 drivers/gpio/gpio-gxp-pl.c | 582 +++++++++++++++++++++++++++++++++++++
 3 files changed, 592 insertions(+)
 create mode 100644 drivers/gpio/gpio-gxp-pl.c

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index fa0c9fdbb50c..b0a24ef18392 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -1244,6 +1244,15 @@ config GPIO_GXP
 	  support for the multiple GPIO interfaces available to be
 	  available to the Host.
 
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
index a7ce0ab097aa..1f285c630e15 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -64,6 +64,7 @@ obj-$(CONFIG_GPIO_GE_FPGA)		+= gpio-ge.o
 obj-$(CONFIG_GPIO_GPIO_MM)		+= gpio-gpio-mm.o
 obj-$(CONFIG_GPIO_GRGPIO)		+= gpio-grgpio.o
 obj-$(CONFIG_GPIO_GXP)                  += gpio-gxp.o
+obj-$(CONFIG_GPIO_GXP_PL)               += gpio-gxp-pl.o
 obj-$(CONFIG_GPIO_GW_PLD)		+= gpio-gw-pld.o
 obj-$(CONFIG_GPIO_HISI)                 += gpio-hisi.o
 obj-$(CONFIG_GPIO_HLWD)			+= gpio-hlwd.o
diff --git a/drivers/gpio/gpio-gxp-pl.c b/drivers/gpio/gpio-gxp-pl.c
new file mode 100644
index 000000000000..8506e2a96da4
--- /dev/null
+++ b/drivers/gpio/gpio-gxp-pl.c
@@ -0,0 +1,582 @@
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
+#define PLREG_INT_GRP5_STATE	0x32
+#define PLREG_INT_GRP6_FLAG	0x34
+
+/* Specific bits to enable Group 4 and Group 5 interrupts */
+#define PLREG_GRP4_GRP5_MASK	GENMASK(5, 4)
+
+/* Specific offsets in CPLD registers */
+#define PLREG_SERVER_ID		0x01 /* 2 Bytes */
+#define PLREG_IOP_LED		0x04
+#define PLREG_IDENT_LED		0x05
+#define PLREG_HEALTH_LED	0x0D
+#define PLREG_PSU_INST		0x19
+#define PLREG_PSU_AC		0x1B
+#define PLREG_PSU_DC		0x1C
+#define PLREG_FAN_INST		0x27
+#define PLREG_FAN_FAIL		0x29
+#define PLREG_SIDEBAND		0x40
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
+	SIDEBAND_SEL_L = 63,
+	SIDEBAND_SEL_H = 64
+};
+
+/*
+ * When an interrupt fires for a PSU config change
+ * there is a need to know the previous PSU configuration
+ * so that the appropriate gpio line is interrupted for
+ * the correct PSU. In order to keep this variable up to
+ * date it is global so that it can be set at init and
+ * each time the interrupt fires.
+ */
+u8 psu_presence;
+
+struct gxp_gpio_drvdata {
+	struct gpio_chip chip;
+	struct regmap *base;
+	struct regmap *interrupt;
+	int irq;
+};
+
+static const struct regmap_config gxp_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = 0x80,
+	.name = "gxp-gpio-pl",
+};
+
+static const struct regmap_config gxp_int_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = 0x7f,
+	.name = "gxp-gpio-pl-int",
+};
+
+static struct regmap *gxp_gpio_init_regmap(struct platform_device *pdev,
+					   char *reg_name, bool is_interrupt)
+{
+	void __iomem *base;
+
+	base = devm_platform_ioremap_resource_byname(pdev, reg_name);
+	if (IS_ERR(base))
+		return ERR_CAST(base);
+
+	if (is_interrupt)
+		return devm_regmap_init_mmio(&pdev->dev, base, &gxp_int_regmap_config);
+	else
+		return devm_regmap_init_mmio(&pdev->dev, base, &gxp_regmap_config);
+}
+
+#ifdef CONFIG_DEBUG_FS
+
+#include <linux/debugfs.h>
+
+static int gxp_gpio_serverid_show(struct seq_file *s, void *unused)
+{
+	struct gxp_gpio_drvdata *drvdata = dev_get_drvdata(s->private);
+	unsigned int server_id_l;
+	unsigned int server_id_h;
+
+	regmap_read(drvdata->base, PLREG_SERVER_ID, &server_id_l);
+	regmap_read(drvdata->base, PLREG_SERVER_ID + 0x01, &server_id_h);
+
+	seq_printf(s, "%02x %02x", server_id_h, server_id_l);
+
+	return 0;
+}
+
+static void gxp_gpio_debuginit(struct platform_device *pdev)
+{
+	debugfs_create_devm_seqfile(&pdev->dev, "gxp_gpio_serverid", NULL,
+				    gxp_gpio_serverid_show);
+}
+
+#else
+
+static inline void gxp_gpio_debuginit(struct platform_device *pdev)
+{
+}
+
+#endif
+
+static int gxp_gpio_pl_get(struct gpio_chip *chip, unsigned int offset)
+{
+	struct gxp_gpio_drvdata *drvdata = dev_get_drvdata(chip->parent);
+	unsigned int val;
+	unsigned int reg_offset;
+	u8 reg_mask;
+	bool is_active_low = false;
+
+	switch (offset) {
+	case IOP_LED1 ... IOP_LED8:
+		reg_offset = PLREG_IOP_LED;
+		reg_mask = BIT(offset);
+		break;
+	case FAN1_INST ...FAN8_INST:
+		regmap_read(drvdata->base, PLREG_FAN_INST, &val);
+		reg_mask = BIT(offset - FAN1_INST);
+		break;
+	case FAN1_FAIL ... FAN8_FAIL:
+		regmap_read(drvdata->base, PLREG_FAN_FAIL, &val);
+		reg_mask = BIT(offset - FAN1_FAIL);
+		break;
+	case PWR_BTN_INT ... SLP_INT:
+		/* Note this is active low */
+		reg_offset = PLREG_INT_GRP5_STATE;
+		reg_mask = BIT(offset - PWR_BTN_INT);
+		is_active_low = true;
+		break;
+	case  PSU1_INST ... PSU8_INST:
+		reg_offset = PLREG_PSU_INST;
+		reg_mask = BIT(offset - PSU1_INST);
+		break;
+	case PSU1_AC ... PSU8_AC:
+		reg_offset = PLREG_PSU_AC;
+		reg_mask = BIT(offset - PSU1_AC);
+		break;
+	case PSU1_DC ... PSU8_DC:
+		reg_offset = PLREG_PSU_DC;
+		reg_mask = BIT(offset - PSU1_DC);
+		break;
+	case LED_IDENTIFY:
+		reg_offset = PLREG_IDENT_LED;
+		reg_mask = BIT(1);
+		break;
+	case LED_HEALTH_RED:
+		reg_offset = PLREG_HEALTH_LED;
+		reg_mask = GENMASK(5, 4); /* Bit 5 set, bit 4 clear */
+		break;
+	case LED_HEALTH_AMBER:
+		reg_offset = PLREG_HEALTH_LED;
+		reg_mask = GENMASK(5, 4); /* Bit 5, bit 4 set */
+		break;
+	case SIDEBAND_SEL_L:
+		reg_offset = PLREG_SIDEBAND;
+		reg_mask = BIT(0);
+		break;
+	case SIDEBAND_SEL_H:
+		reg_offset = PLREG_SIDEBAND;
+		reg_mask = BIT(1);
+		break;
+	default:
+		return -ENOTSUPP;
+	}
+
+	regmap_read(drvdata->base, reg_offset, &val);
+
+	/* Special case: Check two bits for Health LED */
+	if (offset == LED_HEALTH_RED)
+		/* Bit 5 set, bit 4 not set */
+		return ((val & reg_mask) == BIT(5) ? 1 : 0);
+	else if (offset == LED_HEALTH_AMBER)
+		/* Bit 5 and 4 set */
+		return ((val & reg_mask) == reg_mask ? 1 : 0);
+
+	val = val & reg_mask;
+
+	if (is_active_low)
+		return (val ? 0 : 1);
+	else
+		return (val ? 1 : 0);
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
+				   GENMASK(7, 6),
+				   value == 0 ? BIT(7) : GENMASK(7, 6));
+		break;
+	case LED_HEALTH_RED:
+		regmap_update_bits(drvdata->base,
+				   PLREG_HEALTH_LED,
+				   GENMASK(7, 6),
+				   value == 0 ? 0 : BIT(7));
+		break;
+	case LED_HEALTH_AMBER:
+		regmap_update_bits(drvdata->base,
+				   PLREG_HEALTH_LED,
+				   GENMASK(7, 6),
+				   value == 0 ? 0 : BIT(6));
+		break;
+	case SIDEBAND_SEL_L ... SIDEBAND_SEL_H:
+		regmap_update_bits(drvdata->base,
+				   PLREG_SIDEBAND,
+				   BIT(offset - SIDEBAND_SEL_L),
+				   value == 0 ? 0 : BIT(offset - SIDEBAND_SEL_L));
+		break;
+	default:
+		break;
+	}
+}
+
+static int gxp_gpio_pl_get_direction(struct gpio_chip *chip, unsigned int offset)
+{
+	switch (offset) {
+	case IOP_LED1 ... IOP_LED8:
+	case LED_IDENTIFY ... LED_HEALTH_AMBER:
+	case ACM_FORCE_OFF:
+	case ACM_REQ_N:
+	case SIDEBAND_SEL_L ... SIDEBAND_SEL_H:
+		return GXP_GPIO_DIR_OUT;
+	default:
+		return -ENOTSUPP;
+	}
+}
+
+static int gxp_gpio_pl_direction_input(struct gpio_chip *chip,
+				       unsigned int offset)
+{
+	switch (offset) {
+	case FAN1_INST ... FAN8_FAIL:
+		return GXP_GPIO_DIR_OUT;
+	case PWR_BTN_INT ... SLP_INT:
+		return GXP_GPIO_DIR_OUT;
+	default:
+		return -ENOTSUPP;
+	}
+}
+
+static int gxp_gpio_pl_direction_output(struct gpio_chip *chip,
+					unsigned int offset, int value)
+{
+	switch (offset) {
+	case IOP_LED1 ... IOP_LED8:
+	case LED_IDENTIFY ... LED_HEALTH_AMBER:
+	case ACM_FORCE_OFF:
+	case ACM_REQ_N:
+	case SIDEBAND_SEL_L ... SIDEBAND_SEL_H:
+		gxp_gpio_pl_set(chip, offset, value);
+		return GXP_GPIO_DIR_OUT;
+	default:
+		return -ENOTSUPP;
+	}
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
+	struct gxp_gpio_drvdata *drvdata = _drvdata;
+	unsigned int val, i;
+	unsigned long temp;
+
+	/* Check group 5 interrupts */
+
+	regmap_read(drvdata->base, PLREG_INT_GRP5_FLAG, &val);
+
+	temp = (unsigned long)val;
+	for_each_set_bit(i, &temp, 3) {
+		generic_handle_domain_irq(drvdata->chip.irq.domain,
+					  i + PWR_BTN_INT);
+	}
+
+		/* Clear latched interrupt */
+	regmap_update_bits(drvdata->interrupt, PLREG_INT_GRP5_FLAG,
+			   GENMASK(7, 0), GENMASK(7, 0));
+	regmap_update_bits(drvdata->interrupt, PLREG_INT_GRP5_BASE,
+			   BIT(0) | BIT(2), 0);
+
+	/* Check group 6 interrupts */
+
+	regmap_read(drvdata->base, PLREG_INT_GRP6_FLAG, &val);
+
+	if (val & BIT(2)) {
+		u8 old_psu = psu_presence;
+
+		regmap_read(drvdata->base, PLREG_PSU_INST, &val);
+		psu_presence = val;
+
+		if (old_psu != psu_presence) {
+			/* Identify all bits which differs */
+			unsigned long current_val = psu_presence;
+			unsigned long old_val = old_psu;
+			unsigned long changed_bits;
+
+			bitmap_xor(&changed_bits, &current_val, &old_val, 8);
+
+			for_each_set_bit(i, &changed_bits, 8) {
+				/* PSU state has changed */
+				generic_handle_domain_irq(drvdata->chip.irq.domain,
+							  i + PSU1_INST);
+			}
+		}
+	}
+
+	/* Clear latched interrupt */
+	regmap_update_bits(drvdata->interrupt, PLREG_INT_GRP6_FLAG,
+			   GENMASK(7, 0), GENMASK(7, 0));
+	regmap_update_bits(drvdata->interrupt, PLREG_INT_GRP6_BASE,
+			   BIT(2), 0);
+
+	return IRQ_HANDLED;
+}
+
+static const struct gpio_chip template_chip = {
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
+static const struct irq_chip gxp_plreg_irqchip = {
+	.name		= "gxp_plreg",
+	.irq_ack	= gxp_gpio_pl_irq_ack,
+	.irq_mask	= gxp_gpio_pl_irq_mask,
+	.irq_unmask	= gxp_gpio_pl_irq_unmask,
+	.irq_set_type	= gxp_gpio_pl_set_type,
+	.flags = IRQCHIP_IMMUTABLE,
+};
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
+	struct gpio_irq_chip *girq;
+	unsigned int val;
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
+	drvdata->base = gxp_gpio_init_regmap(pdev, "base", false);
+	if (IS_ERR(drvdata->base))
+		return dev_err_probe(&pdev->dev, PTR_ERR(drvdata->base),
+				     "failed to map base\n");
+
+	drvdata->interrupt = gxp_gpio_init_regmap(pdev, "interrupt", true);
+	if (IS_ERR(drvdata->interrupt))
+		return dev_err_probe(&pdev->dev, PTR_ERR(drvdata->interrupt),
+				     "failed to map interrupt base\n");
+
+	/* Necessary to read the server id */
+	gxp_gpio_debuginit(pdev);
+
+	/* Initialize psu_presence variable */
+	regmap_read(drvdata->base, PLREG_PSU_INST, &val);
+	psu_presence = val;
+
+	drvdata->chip = template_chip;
+	drvdata->chip.ngpio = 80;
+	drvdata->chip.parent = &pdev->dev;
+
+	girq = &drvdata->chip.irq;
+	gpio_irq_chip_set_chip(girq, &gxp_plreg_irqchip);
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
+		return dev_err_probe(&pdev->dev, ret, "Could not register gpiochip for plreg\n");
+
+	regmap_update_bits(drvdata->interrupt,
+			   PLREG_INT_HI_PRI_EN,
+			   PLREG_GRP4_GRP5_MASK,
+			   PLREG_GRP4_GRP5_MASK);
+	regmap_update_bits(drvdata->interrupt,
+			   PLREG_INT_GRP_STAT_MASK,
+			   PLREG_GRP4_GRP5_MASK,
+			   0x00);
+
+	regmap_read(drvdata->interrupt, PLREG_INT_HI_PRI_EN, &val);
+	regmap_read(drvdata->interrupt, PLREG_INT_GRP_STAT_MASK, &val);
+
+	ret = platform_get_irq(pdev, 0);
+	if (ret < 0)
+		return ret;
+
+	drvdata->irq = ret;
+
+	return devm_request_irq(&pdev->dev, drvdata->irq, gxp_gpio_pl_irq_handle,
+				IRQF_SHARED, "gxp-pl", drvdata);
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
-- 
2.17.1

