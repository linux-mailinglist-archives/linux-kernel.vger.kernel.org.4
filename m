Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E60B6E683C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 17:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232357AbjDRPcV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 11:32:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232305AbjDRPcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 11:32:11 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 532B212CB4;
        Tue, 18 Apr 2023 08:32:08 -0700 (PDT)
Received: from pps.filterd (m0134422.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33I7g3O4027489;
        Tue, 18 Apr 2023 15:31:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=pps0720;
 bh=Tt4JzqIKEid4oeg7pCnXRGju7fBjcdE/E0n7Dx1eby8=;
 b=AyUo4KuzQy9QPt0mDcea465Y84vT2aqnvfMF+3uN0V9LWsKMBCfCE/pkeITzbmO67SXn
 t5Phb2KILxlbk8hu0fJ9Z5dE621MD6bx++DEHuKEIQImWc9zj5sm5OP6wxu0b1D93vmJ
 NePxI2LYOtf0Xnu1pmRrJ2I0Y+Lv2Pr9GM2GuteQ2lF49ZdrwAGB42J0MOjy4gaeebwB
 PGNV8cZz5gcdHoNYU858QQ4o4v1+jopgNkvg3ZHQyOWThxdpcG94KFS/br14tL8y0kVh
 z8yzezVZK16dUPcxo5yPqrM5gNZw9xaoUD39jjxj/lBqMTxd+zvzZr/AvhIA1KyxMxKN iw== 
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3q1mhrmxcx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Apr 2023 15:31:36 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14881.it.hpe.com (Postfix) with ESMTPS id CFA32804788;
        Tue, 18 Apr 2023 15:31:35 +0000 (UTC)
Received: from hpe.com (unknown [16.231.227.36])
        by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id 2AE9681532D;
        Tue, 18 Apr 2023 15:31:35 +0000 (UTC)
From:   nick.hawkins@hpe.com
To:     verdun@hpe.com, nick.hawkins@hpe.com, linus.walleij@linaro.org,
        brgl@bgdev.pl, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jdelvare@suse.com,
        linux@roeck-us.net, linux@armlinux.org.uk,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v1 1/9] gpio: gxp: Add HPE GXP GPIO
Date:   Tue, 18 Apr 2023 10:28:16 -0500
Message-Id: <20230418152824.110823-2-nick.hawkins@hpe.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230418152824.110823-1-nick.hawkins@hpe.com>
References: <20230418152824.110823-1-nick.hawkins@hpe.com>
X-Proofpoint-ORIG-GUID: 7agTXQ4YaY-0JUjdZOtoPjxiE3naG5NX
X-Proofpoint-GUID: 7agTXQ4YaY-0JUjdZOtoPjxiE3naG5NX
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-18_11,2023-04-18_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 spamscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 adultscore=0 phishscore=0 lowpriorityscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304180132
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Hawkins <nick.hawkins@hpe.com>

The GXP SoC supports GPIO on multiple interfaces: Host, CPLD and Soc
pins. The interface from CPLD and Host are interruptable from vic0
and vic1. This driver allows support for both of these interfaces
through the use of different compatible bindings.

Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>
---
 drivers/gpio/Kconfig    |    9 +
 drivers/gpio/Makefile   |    1 +
 drivers/gpio/gpio-gxp.c | 1056 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 1066 insertions(+)
 create mode 100644 drivers/gpio/gpio-gxp.c

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 13be729710f2..47435307698c 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -1235,6 +1235,15 @@ config HTC_EGPIO
 	  several HTC phones.  It provides basic support for input
 	  pins, output pins, and IRQs.
 
+config GPIO_GXP
+        tristate "GXP GPIO support"
+        depends on ARCH_HPE_GXP
+        select GPIOLIB_IRQCHIP
+        help
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
index 000000000000..86f69174434d
--- /dev/null
+++ b/drivers/gpio/gpio-gxp.c
@@ -0,0 +1,1056 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (C) 2023 Hewlett-Packard Enterprise Development Company, L.P. */
+
+#include <linux/gpio.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+#define GPIDATL		0x40
+#define GPIDATH		0x60
+#define GPODATL		0xb0
+#define GPODATH		0xb4
+#define GPODAT2L	0xf8
+#define GPODAT2H	0xfc
+#define GPOOWNL		0x110
+#define GPOOWNH		0x114
+#define GPOOWN2L	0x118
+#define GPOOWN2H	0x11c
+
+#define GPIO_DIR_OUT	0
+#define GPIO_DIR_IN	1
+
+#define PGOOD_MASK		1
+
+#define PLREG_INT_GRP_STAT_MASK	0x8
+#define PLREG_INT_HI_PRI_EN	0xC
+#define PLREG_INT_GRP5_BASE	0x31
+#define PLREG_INT_GRP6_BASE	0x35
+#define PLREG_INT_GRP5_FLAG	0x30
+#define PLREG_INT_GRP6_FLAG	0x34
+#define PLREG_INT_GRP5_PIN_BASE	59
+#define PLREG_INT_GRP6_PIN_BASE	90
+
+enum pl_gpio_pn {
+	IOP_LED1 = 0,
+	IOP_LED2,
+	IOP_LED3,
+	IOP_LED4,
+	IOP_LED5,
+	IOP_LED6,
+	IOP_LED7,
+	IOP_LED8,
+	FAN1_INST = 8,
+	FAN2_INST,
+	FAN3_INST,
+	FAN4_INST,
+	FAN5_INST,
+	FAN6_INST,
+	FAN7_INST,
+	FAN8_INST,
+	FAN1_FAIL,
+	FAN2_FAIL,
+	FAN3_FAIL,
+	FAN4_FAIL,
+	FAN5_FAIL,
+	FAN6_FAIL,
+	FAN7_FAIL,
+	FAN8_FAIL,
+	LED_IDENTIFY = 56,
+	LED_HEALTH_RED,
+	LED_HEALTH_AMBER,
+	PWR_BTN_INT = 59,
+	UID_PRESS_INT,
+	SLP_INT,
+	ACM_FORCE_OFF = 70,
+	ACM_REMOVED,
+	ACM_REQ_N,
+	PSU1_INST,
+	PSU2_INST,
+	PSU3_INST,
+	PSU4_INST,
+	PSU5_INST,
+	PSU6_INST,
+	PSU7_INST,
+	PSU8_INST,
+	PSU1_AC,
+	PSU2_AC,
+	PSU3_AC,
+	PSU4_AC,
+	PSU5_AC,
+	PSU6_AC,
+	PSU7_AC,
+	PSU8_AC,
+	PSU1_DC,
+	PSU2_DC,
+	PSU3_DC,
+	PSU4_DC,
+	PSU5_DC,
+	PSU6_DC,
+	PSU7_DC,
+	PSU8_DC
+};
+
+enum plreg_gpio_pn {
+	RESET = 192,
+	NMI_OUT = 193,
+	VPBTN = 210,
+	PGOOD,
+	PERST,
+	POST_COMPLETE,
+};
+
+struct gxp_gpio_drvdata {
+	struct regmap *csm_map;
+	void __iomem *fn2_vbtn;
+	struct regmap *fn2_stat;
+	struct regmap *vuhc0_map;
+	void __iomem *vbtn;
+	struct regmap *pl_led;
+	struct regmap *pl_health;
+	struct regmap *pl_int;
+	struct gpio_chip chip;
+	int irq;
+};
+
+extern u8 get_psu_inst(void);
+extern u8 get_psu_ac(void);
+extern u8 get_psu_dc(void);
+extern u8 get_fans_installed(void);
+extern u8 get_fans_failed(void);
+
+static int gxp_gpio_csm_get(struct gpio_chip *chip, unsigned int offset)
+{
+	struct gxp_gpio_drvdata *drvdata = dev_get_drvdata(chip->parent);
+	int ret = 0;
+
+	switch (offset) {
+	case 0 ... 31:
+		regmap_read(drvdata->csm_map, GPIDATL,	&ret);
+		ret = (ret & BIT(offset)) ? 1 : 0;
+		break;
+	case 32 ... 63:
+		regmap_read(drvdata->csm_map, GPIDATH,	&ret);
+		ret = (ret & BIT(offset - 32)) ? 1 : 0;
+		break;
+	case 64 ... 95:
+		regmap_read(drvdata->csm_map, GPODATL,	&ret);
+		ret = (ret & BIT(offset - 64)) ? 1 : 0;
+		break;
+	case 96 ... 127:
+		regmap_read(drvdata->csm_map, GPODATH,	&ret);
+		ret = (ret & BIT(offset - 96)) ? 1 : 0;
+		break;
+	case 128 ...  159:
+		regmap_read(drvdata->csm_map, GPODAT2L,	&ret);
+		ret = (ret & BIT(offset - 128)) ? 1 : 0;
+		break;
+	case 160 ... 191:
+		regmap_read(drvdata->csm_map, GPODAT2H,	&ret);
+		ret = (ret & BIT(offset - 160)) ? 1 : 0;
+		break;
+	case 192:
+		/* SW_RESET */
+		regmap_read(drvdata->csm_map, 0x5C, &ret);
+		ret = (ret & BIT(15)) ? 1 : 0;
+		break;
+	default:
+		break;
+	}
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
+		regmap_read(drvdata->csm_map, GPOOWNL, &tmp);
+		tmp = (tmp & BIT(offset - 64)) ? 1 : 0;
+
+		regmap_update_bits(drvdata->csm_map, GPOOWNL,
+				   BIT(offset - 64), BIT(offset - 64));
+		regmap_update_bits(drvdata->csm_map, GPODATL,
+				   BIT(offset - 64), value ? BIT(offset - 64) : 0);
+
+		/* Restore ownership setting */
+		regmap_update_bits(drvdata->csm_map, GPOOWNL,
+				   BIT(offset - 64), tmp ? BIT(offset - 64) : 0);
+		break;
+	case 96 ... 127:
+		/* Keep ownership setting */
+		regmap_read(drvdata->csm_map, GPOOWNH, &tmp);
+		tmp = (tmp & BIT(offset - 96)) ? 1 : 0;
+
+		regmap_update_bits(drvdata->csm_map, GPOOWNH,
+				   BIT(offset - 96), BIT(offset - 96));
+		regmap_update_bits(drvdata->csm_map, GPODATH,
+				   BIT(offset - 96), value ? BIT(offset - 96) : 0);
+
+		/* Restore ownership setting */
+		regmap_update_bits(drvdata->csm_map, GPOOWNH,
+				   BIT(offset - 96), tmp ? BIT(offset - 96) : 0);
+		break;
+	case 128 ... 159:
+		/* Keep ownership setting */
+		regmap_read(drvdata->csm_map, GPOOWN2L, &tmp);
+		tmp = (tmp & BIT(offset - 128)) ? 1 : 0;
+
+		regmap_update_bits(drvdata->csm_map, GPOOWN2L,
+				   BIT(offset - 128), BIT(offset - 128));
+		regmap_update_bits(drvdata->csm_map, GPODAT2L,
+				   BIT(offset - 128), value ? BIT(offset - 128) : 0);
+
+		/* Restore ownership setting */
+		regmap_update_bits(drvdata->csm_map, GPOOWN2L,
+				   BIT(offset - 128), tmp ? BIT(offset - 128) : 0);
+		break;
+	case 160 ... 191:
+		/* Keep ownership setting */
+		regmap_read(drvdata->csm_map, GPOOWN2H,	&tmp);
+		tmp = (tmp & BIT(offset - 160)) ? 1 : 0;
+
+		regmap_update_bits(drvdata->csm_map, GPOOWN2H,
+				   BIT(offset - 160), BIT(offset - 160));
+		regmap_update_bits(drvdata->csm_map, GPODAT2H,
+				   BIT(offset - 160), value ? BIT(offset - 160) : 0);
+
+		/* Restore ownership setting */
+		regmap_update_bits(drvdata->csm_map, GPOOWN2H,
+				   BIT(offset - 160), tmp ? BIT(offset - 160) : 0);
+		break;
+	case 192:
+		if (value) {
+			regmap_update_bits(drvdata->csm_map, 0x5C,
+					   BIT(0), BIT(0));
+			regmap_update_bits(drvdata->csm_map, 0x5C,
+					   BIT(15), BIT(15));
+		} else {
+			regmap_update_bits(drvdata->csm_map, 0x5C,
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
+		ret = GPIO_DIR_IN;
+		break;
+	case 64 ... 191:
+		ret = GPIO_DIR_OUT;
+		break;
+	case 192 ... 193:
+		ret = GPIO_DIR_OUT;
+		break;
+	case 194:
+		ret = GPIO_DIR_IN;
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
+		ret = GPIO_DIR_IN;
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
+		ret = (val & BIT(24)) ? 1 : 0;
+
+		break;
+	case PERST:
+		regmap_read(drvdata->fn2_stat, 0, &val);
+		ret = (val & BIT(25)) ? 1 : 0;
+
+		break;
+	default:
+		break;
+	}
+
+	return ret;
+}
+
+static void gxp_gpio_fn2_set(struct gpio_chip *chip, unsigned int offset,
+			     int value)
+{
+	struct gxp_gpio_drvdata *drvdata = dev_get_drvdata(chip->parent);
+
+	switch (offset) {
+	case VPBTN:
+		writeb(4, drvdata->vbtn);
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
+	int ret = GPIO_DIR_IN;
+
+	switch (offset) {
+	case VPBTN:
+		ret = GPIO_DIR_OUT;
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
+#define FN2_SEVMASK 4
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
+static int gxp_gpio_pl_get(struct gpio_chip *chip, unsigned int offset)
+{
+	struct gxp_gpio_drvdata *drvdata = dev_get_drvdata(chip->parent);
+	unsigned int val;
+	int ret = 0;
+
+	switch (offset) {
+	case IOP_LED1 ... IOP_LED8:
+		regmap_read(drvdata->pl_led, 0x00, &val);
+		ret = (val & BIT(offset)) ? 1 : 0;
+		break;
+	case FAN1_INST ...FAN8_INST:
+		ret = (get_fans_installed() & BIT((offset - FAN1_INST))) ? 1 : 0;
+		break;
+	case FAN1_FAIL ... FAN8_FAIL:
+		ret = (get_fans_failed() & BIT((offset - FAN1_FAIL))) ? 1 : 0;
+		break;
+	case PWR_BTN_INT ... SLP_INT:
+		regmap_read(drvdata->pl_int, PLREG_INT_GRP5_FLAG, &val);
+		/* Active low */
+		ret = (val & BIT((offset - PWR_BTN_INT) + 16)) ? 0 : 1;
+		break;
+	case  PSU1_INST ... PSU8_INST:
+		ret = (get_psu_inst() & BIT((offset - PSU1_INST))) ? 1 : 0;
+		break;
+	case PSU1_AC ... PSU8_AC:
+		ret = (get_psu_ac() & BIT((offset - PSU1_AC))) ? 1 : 0;
+		break;
+	case PSU1_DC ... PSU8_DC:
+		ret = (get_psu_dc() & BIT((offset - PSU1_DC))) ? 1 : 0;
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
+		regmap_update_bits(drvdata->pl_led, 0x00, BIT(offset),
+				   value == 0 ? 0 : BIT(offset));
+		break;
+	case LED_IDENTIFY:
+		regmap_update_bits(drvdata->pl_led, 0x01, BIT(7) | BIT(6),
+				   value == 0 ? BIT(7) : BIT(7) | BIT(6));
+		break;
+	case LED_HEALTH_RED:
+		regmap_update_bits(drvdata->pl_health, 0x0, BIT(7),
+				   value == 0 ? 0 : BIT(7));
+		break;
+	case LED_HEALTH_AMBER:
+		regmap_update_bits(drvdata->pl_health, 0x0, BIT(6),
+				   value == 0 ? 0 : BIT(6));
+		break;
+	default:
+		break;
+	}
+}
+
+static int gxp_gpio_pl_get_direction(struct gpio_chip *chip, unsigned int offset)
+{
+	int ret = GPIO_DIR_IN;
+
+	switch (offset) {
+	case IOP_LED1 ... IOP_LED8:
+	case LED_IDENTIFY ... LED_HEALTH_AMBER:
+	case ACM_FORCE_OFF:
+	case ACM_REQ_N:
+		ret = GPIO_DIR_OUT;
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
+		ret = 0;
+		break;
+	case 59 ... 65:
+		ret = 0;
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
+		ret = 0;
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
+	regmap_read(drvdata->pl_int, PLREG_INT_GRP5_FLAG, &val);
+	/* Clear latched interrupt */
+	regmap_update_bits(drvdata->pl_int, PLREG_INT_GRP5_FLAG,
+			   0xFF, 0xFF);
+
+	/* Read latched interrupt for group 6 */
+	regmap_read(drvdata->pl_int, PLREG_INT_GRP6_FLAG, &val);
+	/* Clear latched interrupt */
+	regmap_update_bits(drvdata->pl_int, PLREG_INT_GRP6_FLAG,
+			   0xFF, 0xFF);
+}
+
+static void gxp_gpio_pl_irq_set_mask(struct irq_data *d, bool set)
+{
+	struct gpio_chip *chip = irq_data_get_irq_chip_data(d);
+	struct gxp_gpio_drvdata *drvdata = dev_get_drvdata(chip->parent);
+
+	regmap_update_bits(drvdata->pl_int, PLREG_INT_GRP5_BASE,
+			   BIT(0) | BIT(2), set ? 0 : BIT(0) | BIT(2));
+
+	regmap_update_bits(drvdata->pl_int, PLREG_INT_GRP6_BASE,
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
+	regmap_update_bits(drvdata->pl_int, PLREG_INT_GRP5_BASE,
+			   BIT(0) | BIT(2), 0);
+
+	regmap_update_bits(drvdata->pl_int, PLREG_INT_GRP6_BASE,
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
+	regmap_read(drvdata->pl_int, PLREG_INT_GRP5_FLAG, &val);
+
+	if (val) {
+		for_each_set_bit(i, (unsigned long *)&val, 3) {
+			girq = irq_find_mapping(drvdata->chip.irq.domain,
+						i + PLREG_INT_GRP5_PIN_BASE);
+			generic_handle_irq(girq);
+		}
+
+		/* Clear latched interrupt */
+		regmap_update_bits(drvdata->pl_int, PLREG_INT_GRP5_FLAG,
+				   0xFF, 0xFF);
+		regmap_update_bits(drvdata->pl_int, PLREG_INT_GRP5_BASE,
+				   BIT(0) | BIT(2), 0);
+	}
+
+	/* Check group 6 interrupts */
+
+	regmap_read(drvdata->pl_int, PLREG_INT_GRP6_FLAG, &val);
+
+	if (val) {
+		for_each_set_bit(i, (unsigned long *)&val, 3) {
+			girq = irq_find_mapping(drvdata->chip.irq.domain,
+						i + PLREG_INT_GRP6_PIN_BASE);
+			generic_handle_irq(girq);
+		}
+
+		/* Clear latched interrupt */
+		regmap_update_bits(drvdata->pl_int, PLREG_INT_GRP6_FLAG,
+				   0xFF, 0xFF);
+		regmap_update_bits(drvdata->pl_int, PLREG_INT_GRP6_BASE,
+				   BIT(2), 0);
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
+	drvdata->vbtn = devm_platform_ioremap_resource_byname(pdev, "vbtn");
+	if (IS_ERR(drvdata->vbtn))
+		return dev_err_probe(&pdev->dev, PTR_ERR(drvdata->vbtn),
+				     "failed to map vbtn\n");
+	girq = &drvdata->chip.irq;
+	girq->chip = &gxp_gpio_irqchip;
+	girq->parent_handler = NULL;
+	girq->num_parents = 0;
+	girq->parents = NULL;
+	girq->default_type = IRQ_TYPE_NONE;
+	girq->handler = handle_edge_irq;
+
+	ret = platform_get_irq(pdev, 0);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Get irq from platform fail - %d\n", ret);
+		return ret;
+	}
+	drvdata->irq = ret;
+
+	ret = devm_request_irq(&pdev->dev, drvdata->irq, gxp_gpio_fn2_irq_handle,
+			       IRQF_SHARED, "gxp-fn2", drvdata);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "IRQ handler failed - %d\n", ret);
+		return ret;
+	}
+	drvdata->chip = common_chip;
+	drvdata->chip.ngpio = 300;
+
+	drvdata->chip.parent = &pdev->dev;
+	ret = devm_gpiochip_add_data(&pdev->dev, &drvdata->chip, NULL);
+	if (ret < 0)
+		dev_err(&pdev->dev,
+			"Could not register gpiochip for fn2, %d\n", ret);
+	dev_info(&pdev->dev, "HPE GXP FN2 driver loaded.\n");
+
+	return 0;
+}
+
+static int gxp_gpio_pl_init(struct platform_device *pdev)
+{
+	struct gxp_gpio_drvdata *drvdata = dev_get_drvdata(&pdev->dev);
+	struct gpio_irq_chip *girq;
+	int ret;
+	unsigned int val;
+
+	drvdata->pl_led = gxp_gpio_init_regmap(pdev, "pl-led", 8);
+	if (IS_ERR(drvdata->pl_led))
+		return dev_err_probe(&pdev->dev, PTR_ERR(drvdata->pl_int),
+				     "failed to map pl_led\n");
+
+	drvdata->pl_health = gxp_gpio_init_regmap(pdev, "pl-health", 8);
+	if (IS_ERR(drvdata->pl_health))
+		return dev_err_probe(&pdev->dev, PTR_ERR(drvdata->pl_int),
+				     "failed to map pl_health\n");
+
+	drvdata->pl_int = gxp_gpio_init_regmap(pdev, "pl-int", 8);
+	if (IS_ERR(drvdata->pl_int))
+		return dev_err_probe(&pdev->dev, PTR_ERR(drvdata->pl_int),
+				     "failed to map pl_int\n");
+
+	drvdata->chip = plreg_chip;
+	drvdata->chip.ngpio = 100;
+	drvdata->chip.parent = &pdev->dev;
+
+	girq = &drvdata->chip.irq;
+	girq->chip = &gxp_plreg_irqchip;
+	girq->parent_handler = NULL;
+	girq->num_parents = 0;
+	girq->parents = NULL;
+	girq->default_type = IRQ_TYPE_NONE;
+	girq->handler = handle_edge_irq;
+
+	girq->init_hw = gxp_gpio_irq_init_hw;
+
+	ret = devm_gpiochip_add_data(&pdev->dev, &drvdata->chip, drvdata);
+	if (ret < 0)
+		dev_err(&pdev->dev, "Could not register gpiochip for plreg, %d\n",
+			ret);
+
+	regmap_update_bits(drvdata->pl_int, PLREG_INT_HI_PRI_EN,
+			   BIT(4) | BIT(5), BIT(4) | BIT(5));
+	regmap_update_bits(drvdata->pl_int, PLREG_INT_GRP_STAT_MASK,
+			   BIT(4) | BIT(5), 0x00);
+	regmap_read(drvdata->pl_int, PLREG_INT_HI_PRI_EN, &val);
+	regmap_read(drvdata->pl_int, PLREG_INT_GRP_STAT_MASK, &val);
+
+	ret = platform_get_irq(pdev, 0);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Get irq from platform fail - %d\n", ret);
+		return ret;
+	}
+
+	drvdata->irq = ret;
+
+	ret = devm_request_irq(&pdev->dev, drvdata->irq, gxp_gpio_pl_irq_handle,
+			       IRQF_SHARED, "gxp-pl", drvdata);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "IRQ handler failed - %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static const struct of_device_id gxp_gpio_of_match[] = {
+	{ .compatible = "hpe,gxp-gpio"},
+	{ .compatible = "hpe,gxp-gpio-pl"},
+	{}
+};
+MODULE_DEVICE_TABLE(of, gxp_gpio_of_match);
+
+static int gxp_gpio_probe(struct platform_device *pdev)
+{
+	int ret;
+	struct gxp_gpio_drvdata *drvdata;
+	struct device *dev = &pdev->dev;
+	struct device *parent;
+	const struct of_device_id *match = of_match_device(gxp_gpio_of_match, dev);
+
+	if (!match) {
+		dev_err(dev, "device is not compatible");
+		return -EINVAL;
+	}
+
+	parent = dev->parent;
+	if (!parent) {
+		dev_err(dev, "no parent\n");
+		return -ENODEV;
+	}
+
+	drvdata = devm_kzalloc(&pdev->dev, sizeof(struct gxp_gpio_drvdata),
+			       GFP_KERNEL);
+	if (!drvdata)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, drvdata);
+
+	if (strcmp(match->compatible, "hpe,gxp-gpio-pl") == 0)
+		ret = gxp_gpio_pl_init(pdev);
+	else
+		ret = gxp_gpio_init(pdev);
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

