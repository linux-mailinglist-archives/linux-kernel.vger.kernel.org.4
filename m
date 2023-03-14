Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 649436B9297
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 13:05:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231811AbjCNMF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 08:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231736AbjCNMFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 08:05:15 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D47D570A5;
        Tue, 14 Mar 2023 05:04:39 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 3574E5FD65;
        Tue, 14 Mar 2023 15:03:02 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1678795382;
        bh=X4pfFsCQH8YTRhFTF0Ot55idPttHQqLJw67lEgyuAZI=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=c/a1Wbu2UAuXfrEPrUKB03Ig6UTZF9ajAFkSKgmWVir0le6Os7jDkXAGzYbrUCtXd
         qSc2YHkjpUoi3V4dzwR0ialddcj2W16T1tCF/kqmOwabyc98VQnteQdW2tIPXxjPSa
         WxTbwcG4wsoqShdJ2yhMp9r3GxhaIenyRVsoHRCgLzwF/dwRtpADfwMvW6brvvOBwq
         UXQyTevaHooBeSTtgveParzFzkOlgAgszCFG0SiMWBYdik05nWsqZ+GdxRgRn2r3SC
         sZbNkp1YhH6kQvACciIIHngVmxtk2PSqeI8JuXyoiyTxLJssQwohsHfozuguF+vBab
         FRE+VaOQqR6Wg==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Tue, 14 Mar 2023 15:03:02 +0300 (MSK)
From:   Martin Kurbanov <mmkurbanov@sberdevices.ru>
To:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     <linux-leds@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel@sberdevices.ru>, <devicetree@vger.kernel.org>,
        Martin Kurbanov <mmkurbanov@sberdevices.ru>
Subject: [PATCH v3 2/2] leds: add aw20xx driver
Date:   Tue, 14 Mar 2023 15:02:52 +0300
Message-ID: <20230314120252.48263-3-mmkurbanov@sberdevices.ru>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230314120252.48263-1-mmkurbanov@sberdevices.ru>
References: <20230314120252.48263-1-mmkurbanov@sberdevices.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH01.sberdevices.ru (172.16.1.4) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/03/14 06:01:00 #20942017
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds support for AWINIC AW20036/AW20054/AW20072 LED driver.
This driver supports following AW200XX features:
  - Individual 64-level DIM currents

Signed-off-by: Martin Kurbanov <mmkurbanov@sberdevices.ru>
---
 .../testing/sysfs-class-led-driver-aw200xx    |   5 +
 drivers/leds/Kconfig                          |  14 +
 drivers/leds/Makefile                         |   1 +
 drivers/leds/leds-aw200xx.c                   | 638 ++++++++++++++++++
 4 files changed, 658 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-class-led-driver-aw200xx
 create mode 100644 drivers/leds/leds-aw200xx.c

diff --git a/Documentation/ABI/testing/sysfs-class-led-driver-aw200xx b/Documentation/ABI/testing/sysfs-class-led-driver-aw200xx
new file mode 100644
index 000000000000..2122e3ee3d95
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-class-led-driver-aw200xx
@@ -0,0 +1,5 @@
+What:		/sys/class/leds/<led>/dim
+Date:		March 2023
+Description:	64-level DIM current. If you write a negative value or
+		"auto", the dim will be calculated according to the
+		brightness.
diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
index 499d0f215a8b..546e5aeccc43 100644
--- a/drivers/leds/Kconfig
+++ b/drivers/leds/Kconfig
@@ -94,6 +94,20 @@ config LEDS_ARIEL

 	  Say Y to if your machine is a Dell Wyse 3020 thin client.

+config LEDS_AW200XX
+	tristate "LED support for Awinic AW20036/AW20054/AW20072"
+	depends on LEDS_CLASS
+	depends on I2C
+	depends on OF
+	help
+	  This option enables support for the AW20036/AW20054/AW20072 LED driver.
+	  It is a 3x12/6x9/6x12 matrix LED driver programmed via
+	  an I2C interface, up to 36/54/72 LEDs or 12/18/24 RGBs,
+	  3 pattern controllers for auto breathing or group dimming control.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called leds-aw200xx.
+
 config LEDS_AW2013
 	tristate "LED support for Awinic AW2013"
 	depends on LEDS_CLASS && I2C && OF
diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
index 4fd2f92cd198..f611e48cd3f5 100644
--- a/drivers/leds/Makefile
+++ b/drivers/leds/Makefile
@@ -15,6 +15,7 @@ obj-$(CONFIG_LEDS_AN30259A)		+= leds-an30259a.o
 obj-$(CONFIG_LEDS_APU)			+= leds-apu.o
 obj-$(CONFIG_LEDS_ARIEL)		+= leds-ariel.o
 obj-$(CONFIG_LEDS_ASIC3)		+= leds-asic3.o
+obj-$(CONFIG_LEDS_AW200XX)		+= leds-aw200xx.o
 obj-$(CONFIG_LEDS_AW2013)		+= leds-aw2013.o
 obj-$(CONFIG_LEDS_BCM6328)		+= leds-bcm6328.o
 obj-$(CONFIG_LEDS_BCM6358)		+= leds-bcm6358.o
diff --git a/drivers/leds/leds-aw200xx.c b/drivers/leds/leds-aw200xx.c
new file mode 100644
index 000000000000..83cabb85c26f
--- /dev/null
+++ b/drivers/leds/leds-aw200xx.c
@@ -0,0 +1,638 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Awinic AW20036/AW20054/AW20072 LED driver
+ *
+ * Copyright (c) 2023, SberDevices. All Rights Reserved.
+ *
+ * Author: Martin Kurbanov <mmkurbanov@sberdevices.ru>
+ */
+
+#include <linux/bitfield.h>
+#include <linux/i2c.h>
+#include <linux/leds.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/regmap.h>
+
+#define AW200XX_LEDS_MAX                 72
+#define AW200XX_PATTERN_MAX              3
+#define AW200XX_DIM_MAX                  (BIT(6) - 1)
+#define AW200XX_FADE_MAX                 (BIT(8) - 1)
+#define AW200XX_IMAX_DEFAULT_uA          60000
+#define AW200XX_IMAX_MAX_uA              160000
+#define AW200XX_IMAX_MIN_uA              3300
+
+/* Page 0 */
+#define AW200XX_REG_PAGE0_BASE 0xc000
+
+/* Select page register */
+#define AW200XX_REG_PAGE       0xF0
+#define AW200XX_PAGE_MASK      (GENMASK(7, 6) | GENMASK(2, 0))
+#define AW200XX_PAGE_SHIFT     0
+#define AW200XX_NUM_PAGES      6
+#define AW200XX_PAGE_SIZE      256
+#define AW200XX_REG(page, reg) \
+	(AW200XX_REG_PAGE0_BASE + (page) * AW200XX_PAGE_SIZE + (reg))
+#define AW200XX_REG_MAX \
+	AW200XX_REG(AW200XX_NUM_PAGES - 1, AW200XX_PAGE_SIZE - 1)
+#define AW200XX_PAGE0 0
+#define AW200XX_PAGE1 1
+#define AW200XX_PAGE2 2
+#define AW200XX_PAGE3 3
+#define AW200XX_PAGE4 4
+#define AW200XX_PAGE5 5
+
+/* Chip ID register */
+#define AW200XX_REG_IDR       AW200XX_REG(AW200XX_PAGE0, 0x00)
+#define AW200XX_IDR_CHIPID    0x18
+
+/* Sleep mode register */
+#define AW200XX_REG_SLPCR     AW200XX_REG(AW200XX_PAGE0, 0x01)
+#define AW200XX_SLPCR_ACTIVE  0x00
+
+/* Reset register */
+#define AW200XX_REG_RSTR      AW200XX_REG(AW200XX_PAGE0, 0x02)
+#define AW200XX_RSTR_RESET    0x01
+
+/* Global current configuration register */
+#define AW200XX_REG_GCCR        AW200XX_REG(AW200XX_PAGE0, 0x03)
+#define AW200XX_GCCR_IMAX_MASK  GENMASK(7, 4)
+#define AW200XX_GCCR_IMAX(x)    ((x) << 4)
+#define AW200XX_GCCR_ALLON      BIT(3)
+
+/* Fast clear display control register */
+#define AW200XX_REG_FCD       AW200XX_REG(AW200XX_PAGE0, 0x04)
+#define AW200XX_FCD_CLEAR     0x01
+
+/* Interrupt status register */
+#define AW200XX_REG_ISRFLT          AW200XX_REG(AW200XX_PAGE0, 0x0B)
+#define AW200XX_ISRFLT_PATIS_MASK   GENMASK(6, 4)
+
+/* Pattern enable control register */
+#define AW200XX_REG_PATCR           AW200XX_REG(AW200XX_PAGE0, 0x43)
+#define AW200XX_PATCR_PAT_IE_MASK   GENMASK(6, 4)
+#define AW200XX_PATCR_PAT_IE_ALL    AW200XX_PATCR_PAT_IE_MASK
+#define AW200XX_PATCR_PAT_ENABLE(x) BIT(x)
+
+/*
+ * Maximum breathing level registers
+ * For patterns 0 - 0x44, 1 - 0x45, 2 - 0x46 (step 1)
+ */
+#define AW200XX_REG_PAT0_MAX_BREATH AW200XX_REG(AW200XX_PAGE0, 0x44)
+
+/*
+ * Minimum breathing level registers
+ * For patterns 0 - 0x47, 1 - 0x48, 2 - 0x49 (step 1)
+ */
+#define AW200XX_REG_PAT0_MIN_BREATH AW200XX_REG(AW200XX_PAGE0, 0x47)
+
+/*
+ * Template 1 (rise-time) & template 2 (on-time) configuration register
+ * For patterns 0 - 0x4A, 1 - 0x4E, 2 - 0x52 (step 4)
+ */
+#define AW200XX_REG_PAT0_T0 AW200XX_REG(AW200XX_PAGE0, 0x4A)
+
+/*
+ * Template 3 (fall-time) & template 4 (off-time) configuration register
+ * For patterns 0 - 0x4B, 1 - 0x4F, 2 - 0x53 (step 4)
+ */
+#define AW200XX_REG_PAT0_T1 AW200XX_REG(AW200XX_PAGE0, 0x4B)
+
+/*
+ * Loop configuration registers:
+ *   loop end point setting (LE)
+ *   loop beginning point setting (LB)
+ *   MSB of loop times (LT)
+ * For patterns 0 - 0x4C, 1 - 0x50, 2 - 0x54 (step 4)
+ */
+#define AW200XX_REG_PAT0_T2     AW200XX_REG(AW200XX_PAGE0, 0x4C)
+#define AW200XX_REG_PATX_T2(x) (AW200XX_REG_PAT0_T2 + (x))
+
+/*
+ * Loop configuration registers:
+ *    LSB of loop times (LT)
+ * For patterns 0 - 0x4D, 1 - 0x51, 2 - 0x55 (step 4)
+ */
+#define AW200XX_REG_PAT0_T3    AW200XX_REG(AW200XX_PAGE0, 0x4D)
+#define AW200XX_REG_PATX_T3(x) (AW200XX_REG_PAT0_T3 + (x))
+
+#define AW200XX_PAT_T2_LE_MASK      GENMASK(7, 6)
+#define AW200XX_PAT_T2_LB_MASK      GENMASK(5, 4)
+#define AW200XX_PAT_T2_LT_MASK      GENMASK(3, 0)
+#define AW200XX_PAT_T3_LT_MASK      GENMASK(7, 0)
+#define AW200XX_PAT0_T2_LT_MSB(x)   ((x) >> 8)
+#define AW200XX_PAT0_T3_LT_LSB(x)   ((x) & 0xFF)
+#define AW200XX_PAT0_T_LT(msb, lsb) ((msb) << 8 | (lsb))
+#define AW200XX_PAT0_T_LT_MAX       (BIT(12) - 1)
+
+#define AW200XX_PAT_T_STEP          4
+
+#define AW200XX_PAT_T1_T3_MASK      GENMASK(7, 4)
+#define AW200XX_PAT_T2_T4_MASK      GENMASK(3, 0)
+#define AW200XX_TEMPLATE_TIME_MAX   (BIT(4) - 1)
+
+/*
+ * Pattern mode configuration register
+ * For patterns 0 - 0x56, 1 - 0x57, 2 - 0x58 (step 1)
+ */
+#define AW200XX_REG_PAT0_CFG        AW200XX_REG(AW200XX_PAGE0, 0x56)
+#define AW200XX_PAT_CFG_MODE_MASK   BIT(0)
+#define AW200XX_PAT_CFG_RAMP_MASK   BIT(1)
+#define AW200XX_PAT_CFG_SWITCH_MASK BIT(2)
+
+/* Start pattern register */
+#define AW200XX_REG_PATGO           AW200XX_REG(AW200XX_PAGE0, 0x59)
+#define AW200XX_PATGO(x)            BIT(x)
+#define AW200XX_PATGO_RUN(x, run)   ((run) << (x))
+#define AW200XX_PATGO_STATE(x)      BIT((x) + 4)
+
+/* Display size configuration */
+#define AW200XX_REG_DSIZE          AW200XX_REG(AW200XX_PAGE0, 0x80)
+#define AW200XX_DSIZE_COLUMNS_MAX  12
+
+#define AW200XX_LED2REG(x, columns) \
+	((x) + (((x) / (columns)) * (AW200XX_DSIZE_COLUMNS_MAX - (columns))))
+
+/* Patern selection register*/
+#define AW200XX_REG_PAT_SELECT(x, columns) \
+	AW200XX_REG(AW200XX_PAGE3, AW200XX_LED2REG(x, columns))
+#define AW200XX_PATX_SELECT(x) ((x) + 1)
+
+/*
+ * DIM current configuration register (page 4).
+ * The even address for current DIM configuration.
+ * The odd address for current FADE configuration
+ */
+#define AW200XX_REG_DIM(x, columns) \
+	AW200XX_REG(AW200XX_PAGE4, AW200XX_LED2REG(x, columns) * 2)
+#define AW200XX_REG_DIM2FADE(x) ((x) + 1)
+#define AW200XX_REG_FADE(x, columns) (AW200XX_REG_DIM(x, columns) + 1)
+
+/* Duty ratio of display scan (see p.15 of datasheet for formula) */
+#define AW200XX_DUTY_RATIO(rows) \
+	(((592UL * 1000000UL) / 600500UL) * (1000UL / (rows)) / 1000UL)
+
+struct aw200xx_led {
+	struct led_classdev cdev;
+	struct aw200xx *chip;
+	int dim;
+	u32 num;
+};
+
+struct aw200xx {
+	const struct aw200xx_chipdef *cdef;
+	struct i2c_client *client;
+	struct regmap *regmap;
+	struct mutex mutex;
+	u32 num_leds;
+	u32 display_rows;
+	struct aw200xx_led leds[];
+};
+
+struct aw200xx_chipdef {
+	u32 channels;
+	u32 display_size_rows_max;
+	u32 display_size_columns;
+};
+
+static ssize_t aw200xx_dim_show(struct device *dev,
+				struct device_attribute *devattr,
+				char *buf)
+{
+	struct led_classdev *cdev = dev_get_drvdata(dev);
+	struct aw200xx_led *led = container_of(cdev, struct aw200xx_led, cdev);
+	int dim = led->dim;
+
+	if (dim < 0)
+		return sysfs_emit(buf, "auto\n");
+
+	return sysfs_emit(buf, "%d\n", dim);
+}
+
+static ssize_t aw200xx_dim_store(struct device *dev,
+				 struct device_attribute *devattr,
+				 const char *buf, size_t count)
+{
+	struct led_classdev *cdev = dev_get_drvdata(dev);
+	struct aw200xx_led *led = container_of(cdev, struct aw200xx_led, cdev);
+	struct aw200xx *chip = led->chip;
+	u32 columns = chip->cdef->display_size_columns;
+	int dim;
+	ssize_t ret;
+
+	if (sysfs_streq(buf, "auto")) {
+		dim = -1;
+	} else {
+		ret = kstrtoint(buf, 0, &dim);
+		if (ret)
+			return ret;
+
+		if (dim > AW200XX_DIM_MAX)
+			return -EINVAL;
+	}
+
+	mutex_lock(&chip->mutex);
+
+	if (dim >= 0) {
+		ret = regmap_write(chip->regmap,
+				   AW200XX_REG_DIM(led->num, columns), dim);
+		if (ret)
+			goto exit;
+	}
+
+	led->dim = dim;
+	ret = count;
+
+exit:
+	mutex_unlock(&chip->mutex);
+	return ret;
+}
+static DEVICE_ATTR(dim, 0644, aw200xx_dim_show, aw200xx_dim_store);
+
+static struct attribute *dim_attrs[] = {
+	&dev_attr_dim.attr,
+	NULL
+};
+ATTRIBUTE_GROUPS(dim);
+
+static int aw200xx_brightness_set(struct led_classdev *cdev,
+				  enum led_brightness brightness)
+{
+	struct aw200xx_led *led = container_of(cdev, struct aw200xx_led, cdev);
+	struct aw200xx *chip = led->chip;
+	int dim;
+	u32 reg;
+	int ret;
+
+	mutex_lock(&chip->mutex);
+
+	reg = AW200XX_REG_DIM(led->num, chip->cdef->display_size_columns);
+	dim = led->dim;
+
+	if (dim < 0) {
+		dim = brightness / (AW200XX_FADE_MAX / AW200XX_DIM_MAX);
+		dim = max(dim, 1);
+	}
+
+	ret = regmap_write(chip->regmap, reg, dim);
+	if (ret)
+		goto error;
+
+	ret = regmap_write(chip->regmap,
+			   AW200XX_REG_DIM2FADE(reg), brightness);
+
+error:
+	mutex_unlock(&chip->mutex);
+
+	return ret;
+}
+
+static u32 aw200xx_imax_from_global(const struct aw200xx *const chip,
+				    u32 global_imax_uA)
+{
+	unsigned long long duty = AW200XX_DUTY_RATIO(chip->display_rows);
+
+	/* The output current of each LED (see p.14 of datasheet for formula) */
+	return (duty * global_imax_uA) / 1000U;
+}
+
+static u32 aw200xx_imax_to_global(const struct aw200xx *const chip,
+				  u32 led_imax_uA)
+{
+	u32 duty = AW200XX_DUTY_RATIO(chip->display_rows);
+
+	/* The output current of each LED (see p.14 of datasheet for formula) */
+	return (led_imax_uA * 1000U) / duty;
+}
+
+static int aw200xx_set_imax(const struct aw200xx *const chip,
+			    u32 led_imax_uA)
+{
+	struct imax_global {
+		u32 regval;
+		u32 microamp;
+	} imaxs[] = {
+		{ 8,  3300 },
+		{ 9,  6700 },
+		{ 0,  10000 },
+		{ 11, 13300 },
+		{ 1,  20000 },
+		{ 13, 26700 },
+		{ 2,  30000 },
+		{ 3,  40000 },
+		{ 15, 53300 },
+		{ 4,  60000 },
+		{ 5,  80000 },
+		{ 6,  120000 },
+		{ 7,  160000 },
+	};
+	u32 g_imax_uA = aw200xx_imax_to_global(chip, led_imax_uA);
+	int i = ARRAY_SIZE(imaxs);
+
+	while (i--) {
+		if (g_imax_uA >= imaxs[i].microamp)
+			break;
+	}
+	if (i < 0)
+		return -EINVAL;
+
+	return regmap_update_bits(chip->regmap, AW200XX_REG_GCCR,
+				  AW200XX_GCCR_IMAX_MASK,
+				  AW200XX_GCCR_IMAX(imaxs[i].regval));
+}
+
+static int aw200xx_chip_reset(const struct aw200xx *const chip)
+{
+	int ret;
+
+	ret = regmap_write(chip->regmap, AW200XX_REG_RSTR, AW200XX_RSTR_RESET);
+	if (ret)
+		return ret;
+
+	regcache_mark_dirty(chip->regmap);
+	return regmap_write(chip->regmap, AW200XX_REG_FCD, AW200XX_FCD_CLEAR);
+}
+
+static int aw200xx_chip_init(const struct aw200xx *const chip)
+{
+	int ret;
+
+	ret = regmap_write(chip->regmap, AW200XX_REG_DSIZE,
+			   chip->display_rows - 1);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(chip->regmap, AW200XX_REG_SLPCR,
+			   AW200XX_SLPCR_ACTIVE);
+	if (ret)
+		return ret;
+
+	return regmap_update_bits(chip->regmap, AW200XX_REG_GCCR,
+				  AW200XX_GCCR_ALLON, AW200XX_GCCR_ALLON);
+}
+
+static int aw200xx_chip_check(const struct aw200xx *const chip)
+{
+	struct device *dev = &chip->client->dev;
+	u32 chipid;
+	int ret;
+
+	ret = regmap_read(chip->regmap, AW200XX_REG_IDR, &chipid);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to read chip ID\n");
+
+	if (chipid != AW200XX_IDR_CHIPID)
+		return dev_err_probe(dev, -ENODEV,
+				     "Chip reported wrong ID: %x\n", chipid);
+
+	return 0;
+}
+
+static int aw200xx_probe_dt(struct device *dev, struct aw200xx *chip)
+{
+	struct fwnode_handle *child;
+	u32 current_min, current_max, min_uA;
+	int ret;
+	int i = 0;
+
+	ret = device_property_read_u32(dev, "awinic,display-rows",
+				       &chip->display_rows);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Failed to read 'display-rows' property\n");
+
+	if (!chip->display_rows ||
+	    chip->display_rows > chip->cdef->display_size_rows_max) {
+		return dev_err_probe(dev, ret,
+				     "Invalid leds display size %u\n",
+				     chip->display_rows);
+	}
+
+	current_max = aw200xx_imax_from_global(chip, AW200XX_IMAX_MAX_uA);
+	current_min = aw200xx_imax_from_global(chip, AW200XX_IMAX_MIN_uA);
+	min_uA = UINT_MAX;
+
+	device_for_each_child_node(dev, child) {
+		struct led_init_data init_data = {};
+		struct aw200xx_led *led;
+		u32 source, imax;
+
+		ret = fwnode_property_read_u32(child, "reg", &source);
+		if (ret) {
+			dev_err(dev, "Missing reg property\n");
+			chip->num_leds--;
+			continue;
+		}
+
+		if (source >= chip->cdef->channels) {
+			dev_err(dev, "LED reg %u out of range (max %u)\n",
+				source, chip->cdef->channels);
+			chip->num_leds--;
+			continue;
+		}
+
+		ret = fwnode_property_read_u32(child, "led-max-microamp",
+					       &imax);
+		if (ret) {
+			dev_info(&chip->client->dev,
+				 "DT property led-max-microamp is missing\n");
+		} else if (imax < current_min || imax > current_max) {
+			dev_err(dev, "Invalid value %u for led-max-microamp\n",
+				imax);
+			chip->num_leds--;
+			continue;
+		} else {
+			min_uA = min(min_uA, imax);
+		}
+
+		led = &chip->leds[i];
+		led->dim = -1;
+		led->num = source;
+		led->chip = chip;
+		led->cdev.brightness_set_blocking = aw200xx_brightness_set;
+		led->cdev.groups = dim_groups;
+		init_data.fwnode = child;
+
+		ret = devm_led_classdev_register_ext(dev, &led->cdev,
+						     &init_data);
+		if (ret) {
+			fwnode_handle_put(child);
+			break;
+		}
+
+		i++;
+	}
+
+	if (!chip->num_leds)
+		return -EINVAL;
+
+	if (min_uA == UINT_MAX) {
+		min_uA = aw200xx_imax_from_global(chip,
+						  AW200XX_IMAX_DEFAULT_uA);
+	}
+
+	return aw200xx_set_imax(chip, min_uA);
+}
+
+static const struct regmap_range_cfg aw200xx_ranges[] = {
+	{
+		.name = "aw200xx",
+		.range_min = 0,
+		.range_max = AW200XX_REG_MAX,
+		.selector_reg = AW200XX_REG_PAGE,
+		.selector_mask = AW200XX_PAGE_MASK,
+		.selector_shift = AW200XX_PAGE_SHIFT,
+		.window_start = 0,
+		.window_len = AW200XX_PAGE_SIZE,
+	},
+};
+
+static const struct regmap_range aw200xx_writeonly_ranges[] = {
+	regmap_reg_range(AW200XX_REG(AW200XX_PAGE1, 0x00), AW200XX_REG_MAX),
+};
+
+static const struct regmap_access_table aw200xx_readable_table = {
+	.no_ranges = aw200xx_writeonly_ranges,
+	.n_no_ranges = ARRAY_SIZE(aw200xx_writeonly_ranges),
+};
+
+static const struct regmap_range aw200xx_readonly_ranges[] = {
+	regmap_reg_range(AW200XX_REG_IDR, AW200XX_REG_IDR),
+	regmap_reg_range(AW200XX_REG_ISRFLT, AW200XX_REG_ISRFLT),
+};
+
+static const struct regmap_access_table aw200xx_writeable_table = {
+	.no_ranges = aw200xx_readonly_ranges,
+	.n_no_ranges = ARRAY_SIZE(aw200xx_readonly_ranges),
+};
+
+static const struct regmap_range aw200xx_volatile_registers[] = {
+	regmap_reg_range(AW200XX_REG_ISRFLT, AW200XX_REG_ISRFLT),
+};
+
+static const struct regmap_access_table aw200xx_volatile_table = {
+	.yes_ranges = aw200xx_volatile_registers,
+	.n_yes_ranges = ARRAY_SIZE(aw200xx_volatile_registers),
+};
+
+static const struct regmap_config aw200xx_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = AW200XX_REG_MAX,
+	.ranges = aw200xx_ranges,
+	.num_ranges = ARRAY_SIZE(aw200xx_ranges),
+	.rd_table = &aw200xx_readable_table,
+	.wr_table = &aw200xx_writeable_table,
+	.volatile_table = &aw200xx_volatile_table,
+	.cache_type = REGCACHE_RBTREE,
+};
+
+static int aw200xx_probe(struct i2c_client *client)
+{
+	const struct aw200xx_chipdef *cdef;
+	struct aw200xx *chip;
+	int count;
+	int ret;
+
+	cdef = device_get_match_data(&client->dev);
+
+	count = device_get_child_node_count(&client->dev);
+	if (!count || count > cdef->channels)
+		return dev_err_probe(&client->dev, -EINVAL,
+				     "Incorrect number of leds (%d)", count);
+
+	chip = devm_kzalloc(&client->dev, struct_size(chip, leds, count),
+			    GFP_KERNEL);
+	if (!chip)
+		return -ENOMEM;
+
+	chip->cdef = cdef;
+	chip->num_leds = count;
+	chip->client = client;
+	i2c_set_clientdata(client, chip);
+
+	chip->regmap = devm_regmap_init_i2c(client, &aw200xx_regmap_config);
+	if (IS_ERR(chip->regmap))
+		return PTR_ERR(chip->regmap);
+
+	ret = aw200xx_chip_check(chip);
+	if (ret)
+		return ret;
+
+	mutex_init(&chip->mutex);
+
+	/* Need a lock now since after call aw200xx_probe_dt, sysfs nodes created */
+	mutex_lock(&chip->mutex);
+
+	ret = aw200xx_probe_dt(&client->dev, chip);
+	if (ret < 0)
+		goto exit;
+
+	ret = aw200xx_chip_reset(chip);
+	if (ret)
+		goto exit;
+
+	ret = aw200xx_chip_init(chip);
+
+exit:
+	mutex_unlock(&chip->mutex);
+	return ret;
+}
+
+static void aw200xx_remove(struct i2c_client *client)
+{
+	struct aw200xx *chip = i2c_get_clientdata(client);
+
+	aw200xx_chip_reset(chip);
+	mutex_destroy(&chip->mutex);
+}
+
+static const struct aw200xx_chipdef aw20036_cdef = {
+	.channels = 36,
+	.display_size_rows_max = 3,
+	.display_size_columns = 12,
+};
+
+static const struct aw200xx_chipdef aw20054_cdef = {
+	.channels = 54,
+	.display_size_rows_max = 6,
+	.display_size_columns = 9,
+};
+
+static const struct aw200xx_chipdef aw20072_cdef = {
+	.channels = 72,
+	.display_size_rows_max = 6,
+	.display_size_columns = 12,
+};
+
+static const struct i2c_device_id aw200xx_id[] = {
+	{ "aw20036" },
+	{ "aw20054" },
+	{ "aw20072" },
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, aw200xx_id);
+
+static const struct of_device_id aw200xx_match_table[] = {
+	{ .compatible = "awinic,aw20036", .data = &aw20036_cdef, },
+	{ .compatible = "awinic,aw20054", .data = &aw20054_cdef, },
+	{ .compatible = "awinic,aw20072", .data = &aw20072_cdef, },
+	{}
+};
+MODULE_DEVICE_TABLE(of, aw200xx_match_table);
+
+static struct i2c_driver aw200xx_driver = {
+	.driver = {
+		.name = "aw200xx",
+		.of_match_table = aw200xx_match_table,
+	},
+	.probe_new = aw200xx_probe,
+	.remove = aw200xx_remove,
+	.id_table = aw200xx_id,
+};
+module_i2c_driver(aw200xx_driver);
+
+MODULE_AUTHOR("Martin Kurbanov <mmkurbanov@sberdevices.ru>");
+MODULE_DESCRIPTION("AW200XX LED driver");
+MODULE_LICENSE("GPL");
--
2.37.2

