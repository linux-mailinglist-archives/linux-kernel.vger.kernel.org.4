Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A05AE7391B1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 23:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbjFUVgL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 17:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230403AbjFUVf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 17:35:56 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4C0E19B5;
        Wed, 21 Jun 2023 14:35:51 -0700 (PDT)
Received: from pps.filterd (m0150242.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35LGPm1S032004;
        Wed, 21 Jun 2023 21:35:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=pps0720;
 bh=ZCL5FttdyAPtD9AmhElk+raRcRc+P3HJCTeIptM8TeM=;
 b=RA8c949UlIr2uNONmriwPIifhzqniG4PfNBbGgbO2eq7TjYRsLXGEtkMEuM6yKZ01pJm
 Zsf07EzekOn/oZiRazMupQqXEjA+bAAsSJW17F7Qi/KqqWsjmP0Fd9eWogXPY1njM5oe
 oA60oaBQjkH6WwkPLYBQQ8zz0ICo23ZiXTm0Q5KVrjzib/8ogOPCE3cPYLmb2iUEkqKm
 oNKAOdYqaClf8TQKT7ab4EsE5A1UjTrAhwhEIGr5rt4Fy0FzXlwGZxJ6OLlO7p8tDxbE
 947cJ+XeiDpb10w7nZv+a4YygDHHGuuY3h9SVozXnByLeTn4yzdvezXEuUdExyAzFwuU NQ== 
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3rc4qja82p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Jun 2023 21:35:25 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14878.it.hpe.com (Postfix) with ESMTPS id F354214792;
        Wed, 21 Jun 2023 21:35:23 +0000 (UTC)
Received: from hpe.com (unknown [16.231.227.36])
        by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id 6951980FEEB;
        Wed, 21 Jun 2023 21:35:23 +0000 (UTC)
From:   nick.hawkins@hpe.com
To:     verdun@hpe.com, nick.hawkins@hpe.com, linus.walleij@linaro.org,
        brgl@bgdev.pl, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jdelvare@suse.com,
        linux@roeck-us.net, andy.shevchenko@gmail.com,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
Subject: [PATCH v4 1/5] gpio: gxp: Add HPE GXP GPIO
Date:   Wed, 21 Jun 2023 16:31:11 -0500
Message-Id: <20230621213115.113266-2-nick.hawkins@hpe.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230621213115.113266-1-nick.hawkins@hpe.com>
References: <20230621213115.113266-1-nick.hawkins@hpe.com>
X-Proofpoint-ORIG-GUID: qUDUYC8PKIr0JSwDitoUQyGt0D6UOGYS
X-Proofpoint-GUID: qUDUYC8PKIr0JSwDitoUQyGt0D6UOGYS
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-21_12,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 priorityscore=1501 mlxscore=0 mlxlogscore=999 spamscore=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2305260000 definitions=main-2306210181
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
driver supports interrupts from the host.

Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>

---

v4:
 *Moved gpio-gxp-pl.c to a separate commit.
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
 drivers/gpio/Kconfig    |   9 +
 drivers/gpio/Makefile   |   1 +
 drivers/gpio/gpio-gxp.c | 573 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 583 insertions(+)
 create mode 100644 drivers/gpio/gpio-gxp.c

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 13be729710f2..fa0c9fdbb50c 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -1235,6 +1235,15 @@ config HTC_EGPIO
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
 config GPIO_JANZ_TTL
 	tristate "Janz VMOD-TTL Digital IO Module"
 	depends on MFD_JANZ_CMODIO
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index c048ba003367..a7ce0ab097aa 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -63,6 +63,7 @@ obj-$(CONFIG_GPIO_FTGPIO010)		+= gpio-ftgpio010.o
 obj-$(CONFIG_GPIO_GE_FPGA)		+= gpio-ge.o
 obj-$(CONFIG_GPIO_GPIO_MM)		+= gpio-gpio-mm.o
 obj-$(CONFIG_GPIO_GRGPIO)		+= gpio-grgpio.o
+obj-$(CONFIG_GPIO_GXP)                  += gpio-gxp.o
 obj-$(CONFIG_GPIO_GW_PLD)		+= gpio-gw-pld.o
 obj-$(CONFIG_GPIO_HISI)                 += gpio-hisi.o
 obj-$(CONFIG_GPIO_HLWD)			+= gpio-hlwd.o
diff --git a/drivers/gpio/gpio-gxp.c b/drivers/gpio/gpio-gxp.c
new file mode 100644
index 000000000000..4fe086137e86
--- /dev/null
+++ b/drivers/gpio/gpio-gxp.c
@@ -0,0 +1,573 @@
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
+#define VUHC_OFS	0x064
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
+	unsigned int reg_offset;
+	unsigned int reg_mask;
+
+	switch (offset) {
+	case 0 ... 31:
+		reg_offset = GPIDAT;
+		reg_mask = BIT(offset);
+		break;
+	case 32 ... 63:
+		reg_offset = GPIDAT + 0x20;
+		reg_mask = BIT(offset - 32);
+		break;
+	case 64 ... 95:
+		reg_offset = GPODAT;
+		reg_mask = BIT(offset - 64);
+		break;
+	case 96 ... 127:
+		reg_offset = GPODAT + 0x04;
+		reg_mask = BIT(offset - 96);
+		break;
+	case 128 ...  159:
+		reg_offset = GPODAT2;
+		reg_mask = BIT(offset - 128);
+		break;
+	case 160 ... 191:
+		reg_offset = GPODAT2 + 0x04;
+		reg_mask = BIT(offset - 160);
+		break;
+	case RESET:
+		/* SW_RESET */
+		reg_offset = ASR_OFS;
+		reg_mask = BIT(15);
+		break;
+	default:
+		break;
+	}
+
+	regmap_read(drvdata->csm_map, reg_offset, &ret);
+	ret = (ret & reg_mask) ? 1 : 0;
+
+	return ret;
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
+	switch (offset) {
+	case 0 ... 63:
+		return GXP_GPIO_DIR_IN;
+	case 64 ... 191:
+		return GXP_GPIO_DIR_OUT;
+	case 192 ... 193:
+		return GXP_GPIO_DIR_OUT;
+	case 194:
+		return GXP_GPIO_DIR_IN;
+	default:
+		return -ENOTSUPP;
+	}
+}
+
+static int gxp_gpio_csm_direction_input(struct gpio_chip *chip,
+					unsigned int offset)
+{
+	switch (offset) {
+	case 0 ... 63:
+		return 0;
+	case 194:
+		return 0;
+	default:
+		return -ENOTSUPP;
+	}
+}
+
+static int gxp_gpio_csm_direction_output(struct gpio_chip *chip,
+					 unsigned int offset, int value)
+{
+	switch (offset) {
+	case 64 ... 191:
+	case 192 ... 193:
+		gxp_gpio_csm_set(chip, offset, value);
+		return 0;
+	default:
+		return -ENOTSUPP;
+	}
+}
+
+static int gxp_gpio_vuhc_get(struct gpio_chip *chip, unsigned int offset)
+{
+	struct gxp_gpio_drvdata *drvdata = dev_get_drvdata(chip->parent);
+	unsigned int val;
+	int ret = 0;
+
+	if (offset < 8) {
+		regmap_read(drvdata->vuhc0_map, VUHC_OFS + 4 * offset,   &val);
+		ret = (val & BIT(13)) ? 1 : 0;
+	}
+
+	return ret;
+}
+
+static void gxp_gpio_vuhc_set(struct gpio_chip *chip, unsigned int offset,
+			      int value)
+{
+	/* Currently we are not supporting setting of these values yet */
+	switch (offset) {
+	default:
+		break;
+	}
+}
+
+static int gxp_gpio_vuhc_get_direction(struct gpio_chip *chip,
+				       unsigned int offset)
+{
+	switch (offset) {
+	case 0:
+	case 1:
+	case 2:
+		return GXP_GPIO_DIR_IN;
+	default:
+		return -ENOTSUPP;
+	}
+}
+
+static int gxp_gpio_vuhc_direction_input(struct gpio_chip *chip,
+					 unsigned int offset)
+{
+	switch (offset) {
+	case 0:
+	case 1:
+	case 2:
+		return 0;
+	default:
+		return -ENOTSUPP;
+	}
+}
+
+static int gxp_gpio_vuhc_direction_output(struct gpio_chip *chip,
+					  unsigned int offset, int value)
+{
+	switch (offset) {
+	default:
+		return -ENOTSUPP;
+	}
+}
+
+static int gxp_gpio_fn2_get(struct gpio_chip *chip, unsigned int offset)
+{
+	struct gxp_gpio_drvdata *drvdata = dev_get_drvdata(chip->parent);
+	unsigned int val;
+	int ret = 0;
+	unsigned int reg_mask;
+
+	switch (offset) {
+	case PGOOD:
+		regmap_read(drvdata->fn2_stat, 0, &val);
+		reg_mask = BIT(24);
+
+		break;
+	case PERST:
+		regmap_read(drvdata->fn2_stat, 0, &val);
+		reg_mask = BIT(25);
+
+		break;
+	default:
+		return -ENOTSUPP;
+	}
+
+	regmap_read(drvdata->fn2_stat, 0, &val);
+	ret = (val & reg_mask);
+	/* Return either 1 or 0 */
+	return ret ? 1 : 0;
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
+	switch (offset) {
+	case VPBTN:
+		return GXP_GPIO_DIR_OUT;
+	default:
+		return GXP_GPIO_DIR_IN;
+	}
+}
+
+static int gxp_gpio_fn2_direction_input(struct gpio_chip *chip,
+					unsigned int offset)
+{
+	switch (offset) {
+	case PGOOD:
+	case PERST:
+	case POST_COMPLETE:
+		return 0;
+	default:
+		return -ENOTSUPP;
+	}
+}
+
+static int gxp_gpio_get(struct gpio_chip *chip, unsigned int offset)
+{
+	if (offset < 200)
+		return gxp_gpio_csm_get(chip, offset);
+	else if (offset >= 200 && offset < 210)
+		return gxp_gpio_vuhc_get(chip, offset - 200);
+	else if (offset >= 210)
+		return gxp_gpio_fn2_get(chip, offset);
+
+	return 0;
+}
+
+static void gxp_gpio_set(struct gpio_chip *chip,
+			 unsigned int offset, int value)
+{
+	if (offset < 200)
+		gxp_gpio_csm_set(chip, offset, value);
+	else if (offset >= 200 && offset < 210)
+		gxp_gpio_vuhc_set(chip, offset - 200, value);
+	else if (offset >= 210)
+		gxp_gpio_fn2_set(chip, offset, value);
+}
+
+static int gxp_gpio_get_direction(struct gpio_chip *chip,
+				  unsigned int offset)
+{
+	if (offset < 200)
+		return gxp_gpio_csm_get_direction(chip, offset);
+	else if (offset >= 200 && offset < 210)
+		return gxp_gpio_vuhc_get_direction(chip, offset - 200);
+	else if (offset >= 210)
+		return gxp_gpio_fn2_get_direction(chip, offset);
+
+	return 0;
+}
+
+static int gxp_gpio_direction_input(struct gpio_chip *chip,
+				    unsigned int offset)
+{
+	if (offset < 200)
+		return gxp_gpio_csm_direction_input(chip, offset);
+	else if (offset >= 200 && offset < 210)
+		return gxp_gpio_vuhc_direction_input(chip, offset - 200);
+	else if (offset >= 210)
+		return gxp_gpio_fn2_direction_input(chip, offset);
+
+	return 0;
+}
+
+static int gxp_gpio_direction_output(struct gpio_chip *chip,
+				     unsigned int offset, int value)
+{
+	if (offset < 200)
+		return gxp_gpio_csm_direction_output(chip, offset, value);
+	else if (offset >= 200 && offset < 210)
+		return gxp_gpio_vuhc_direction_output(chip, offset - 200, value);
+
+	return 0;
+}
+
+static const struct regmap_config gxp_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.name = "gxp",
+};
+
+static struct regmap *gxp_gpio_init_regmap(struct platform_device *pdev,
+					   char *reg_name)
+{
+	void __iomem *base;
+
+	base = devm_platform_ioremap_resource_byname(pdev, reg_name);
+	if (IS_ERR(base))
+		return ERR_CAST(base);
+
+	return devm_regmap_init_mmio(&pdev->dev, base, &gxp_regmap_config);
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
+			   GENMASK(15, 0), GENMASK(15, 0));
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
+	unsigned int val;
+
+	regmap_read(drvdata->fn2_stat, 0, &val);
+
+	if (val & PGOOD_MASK)
+		generic_handle_domain_irq(drvdata->chip.irq.domain, PGOOD);
+
+	return IRQ_HANDLED;
+}
+
+static const struct irq_chip gxp_gpio_irqchip = {
+	.name		= "gxp_fn2",
+	.irq_ack	= gxp_gpio_fn2_irq_ack,
+	.irq_mask	= gxp_gpio_fn2_irq_mask,
+	.irq_unmask	= gxp_gpio_fn2_irq_unmask,
+	.irq_set_type	= gxp_gpio_fn2_set_type,
+	.flags = IRQCHIP_IMMUTABLE,
+};
+
+static const struct gpio_chip common_chip_template = {
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
+	struct gpio_irq_chip *girq;
+
+	drvdata = devm_kzalloc(&pdev->dev, sizeof(*drvdata), GFP_KERNEL);
+	if (!drvdata)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, drvdata);
+
+	drvdata->csm_map = gxp_gpio_init_regmap(pdev, "csm");
+	if (IS_ERR(drvdata->csm_map))
+		return dev_err_probe(&pdev->dev, PTR_ERR(drvdata->csm_map),
+				     "failed to map csm_handle\n");
+
+	drvdata->fn2_vbtn = devm_platform_ioremap_resource_byname(pdev, "fn2-vbtn");
+	if (IS_ERR(drvdata->fn2_vbtn))
+		return dev_err_probe(&pdev->dev, PTR_ERR(drvdata->fn2_vbtn),
+				     "failed to map fn2_vbtn\n");
+
+	drvdata->fn2_stat = gxp_gpio_init_regmap(pdev, "fn2-stat");
+	if (IS_ERR(drvdata->fn2_stat))
+		return dev_err_probe(&pdev->dev, PTR_ERR(drvdata->fn2_stat),
+				     "failed to map fn2_stat\n");
+
+	drvdata->vuhc0_map = gxp_gpio_init_regmap(pdev, "vuhc");
+	if (IS_ERR(drvdata->vuhc0_map))
+		return dev_err_probe(&pdev->dev, PTR_ERR(drvdata->vuhc0_map),
+				     "failed to map vuhc0_map\n");
+
+	girq = &drvdata->chip.irq;
+	gpio_irq_chip_set_chip(girq, &gxp_gpio_irqchip);
+	girq->parent_handler = NULL;
+	girq->num_parents = 0;
+	girq->parents = NULL;
+	girq->default_type = IRQ_TYPE_NONE;
+	girq->handler = handle_bad_irq;
+
+	ret = platform_get_irq(pdev, 0);
+	if (ret < 0)
+		return ret;
+
+	drvdata->irq = ret;
+
+	ret = devm_request_irq(&pdev->dev, drvdata->irq, gxp_gpio_fn2_irq_handle,
+			       IRQF_SHARED, "gxp-fn2", drvdata);
+	if (ret < 0)
+		return ret;
+
+	drvdata->chip = common_chip_template;
+	drvdata->chip.ngpio = 220;
+
+	drvdata->chip.parent = &pdev->dev;
+
+	return devm_gpiochip_add_data(&pdev->dev, &drvdata->chip, NULL);
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

