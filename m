Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76CC35F3D72
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 09:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbiJDHrw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 03:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiJDHru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 03:47:50 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F87541990
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 00:47:48 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id fw14so5153020pjb.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 00:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=OxFgsJmbLQ2aLfAesK762d6UHHKxWQcEyEj73L9Cy2U=;
        b=K1asntrqxpzRs4+T02GZj1BNrRJVUrafV8prehWP6pHt76jkFYF1FDSfE2BMwBW6bf
         YkeZJ7axASpltMCfVTM2HPCPBm30oQhCHNLXKWIAUhXuEib41WlP6NhjC+V5iQdFGuFq
         +a2hBLg9Vl9gA3RpQfXhtAsFOiypcp1oE7OJuo7o852OMRu571CnyoZBdMvdW6FGShEi
         dYZTkKwU7jGUBxy1HY+qQ6bukseXuxF2hMvMIvgHRrr/XVfFp9lCmmedSRWENzOwmqaN
         vmatht6vP78ov3vN4lL1+N8z08DfB4jp2EtqOHIRh0GEZS86GEnFewpOMdzPzT4XkTsD
         F4nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=OxFgsJmbLQ2aLfAesK762d6UHHKxWQcEyEj73L9Cy2U=;
        b=O+38JIehE+8rigSGR76uA0PsyrDJPn2rRijnFu/1YLcCnJS3d9NpcXcWLHVxX5YM0u
         e8fcT9UnDRAE0OqL5h1S4tMuMPl3K5yjvSS8UwZB8D+JYT8KEkz9hrIWkGdo9ilYBaj/
         Me485pp9O7IzCOB1opabZ77uNZp+9xPJkEy6y8is57jFg19wryDfDnYFeoTAsQI0BNN4
         a5XGt69xatKTr2SNDhYLAdmXyRH5ZyyfXOlPdLavPsM5kDZ3hcAvTLo5eJeK8ghlZzdN
         aADb3m9OAaHLDt0g7c/Y74Wipl+3V+u29rN6mzpnlMcAZ4lM/Qc2j21XBL/kw79a5VAh
         9nBA==
X-Gm-Message-State: ACrzQf3OEpEktelvT6SuFJwRkToOaGjpBNJwMbNiYJqiKfACQrdfKNmX
        T08UuarGTDQVNHwfKT2gFI8t26x6fQen
X-Google-Smtp-Source: AMsMyM5nN7pDePs4XX1axqXq4RXX9zx2oXsmOiwJ/YVvLc3Lfo8imIzcj873+8oawgDy1BbzzUHOiA==
X-Received: by 2002:a17:903:11cd:b0:170:cde8:18b7 with SMTP id q13-20020a17090311cd00b00170cde818b7mr25680094plh.165.1664869667205;
        Tue, 04 Oct 2022 00:47:47 -0700 (PDT)
Received: from localhost.localdomain ([106.104.115.142])
        by smtp.gmail.com with ESMTPSA id mv8-20020a17090b198800b00209f96e4616sm7218791pjb.19.2022.10.04.00.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 00:47:46 -0700 (PDT)
From:   chengwei <foxfly.lai.tw@gmail.com>
X-Google-Original-From: chengwei <larry.lai@yunjingtech.com>
To:     lee@kernel.org
Cc:     linux-kernel@vger.kernel.org, GaryWang@aaeon.com.tw,
        musa.lin@yunjingtech.com, jack.chang@yunjingtech.com,
        chengwei <larry.lai@yunjingtech.com>,
        Javier Arteaga <javier@emutex.com>,
        Nicola Lunghi <nicola.lunghi@emutex.com>
Subject: [PATCH] mfd: Add support for UP board CPLD/FPGA
Date:   Tue,  4 Oct 2022 15:47:04 +0800
Message-Id: <20221004074704.12177-1-larry.lai@yunjingtech.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The UP Squared board <http://www.upboard.com> implements certain
features (pin control, onboard LEDs or CEC) through an on-board CPLD/FPGA.

This mfd driver implements the line protocol to read and write registers
from the FPGA through regmap. The register address map is also included.

The UP Boards provide a few I/O pin headers (for both GPIO and
functions), including a 40-pin Raspberry Pi compatible header.

This patch implements support for the FPGA-based pin controller that
manages direction and enable state for those header pins.

Partial support UP boards:
* UP core + CREX
* UP core + CRST02

Signed-off-by: Javier Arteaga <javier@emutex.com>
[merge various fixes]
Signed-off-by: Nicola Lunghi <nicola.lunghi@emutex.com>
Signed-off-by: chengwei <larry.lai@yunjingtech.com>
---
 drivers/mfd/Kconfig              |  11 +
 drivers/mfd/Makefile             |   1 +
 drivers/mfd/upboard-fpga.c       | 482 +++++++++++++++++++++++++++++++
 include/linux/mfd/upboard-fpga.h |  49 ++++
 4 files changed, 543 insertions(+)
 create mode 100644 drivers/mfd/upboard-fpga.c
 create mode 100644 include/linux/mfd/upboard-fpga.h

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index abb58ab1a1a4..f86e264eb4f3 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -2104,6 +2104,17 @@ config MFD_QCOM_PM8008
 	  under it in the device tree. Additional drivers must be enabled in
 	  order to use the functionality of the device.
 
+config MFD_UPBOARD_FPGA
+	tristate "Support for the UP board FPGA"
+	select MFD_CORE
+	help
+	  Select this option to enable the UP and UP^2 on-board FPGA. The UP
+	  board implements certain features (pin control, onboard LEDs or CEC)
+	  through an on-board FPGA.
+
+	  To compile this driver as a module, choose M here: the module will be
+	  called upboard-fpga.
+
 menu "Multimedia Capabilities Port drivers"
 	depends on ARCH_SA1100
 
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index 858cacf659d6..d9d10e3664f7 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -250,6 +250,7 @@ obj-$(CONFIG_MFD_ALTERA_A10SR)	+= altera-a10sr.o
 obj-$(CONFIG_MFD_ALTERA_SYSMGR) += altera-sysmgr.o
 obj-$(CONFIG_MFD_STPMIC1)	+= stpmic1.o
 obj-$(CONFIG_MFD_SUN4I_GPADC)	+= sun4i-gpadc.o
+obj-$(CONFIG_MFD_UPBOARD_FPGA)	+= upboard-fpga.o
 
 obj-$(CONFIG_MFD_STM32_LPTIMER)	+= stm32-lptimer.o
 obj-$(CONFIG_MFD_STM32_TIMERS) 	+= stm32-timers.o
diff --git a/drivers/mfd/upboard-fpga.c b/drivers/mfd/upboard-fpga.c
new file mode 100644
index 000000000000..6f73c2fa6f4a
--- /dev/null
+++ b/drivers/mfd/upboard-fpga.c
@@ -0,0 +1,482 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * UP Board main platform driver and FPGA configuration support
+ *
+ * Copyright (c) 2017, Emutex Ltd. All rights reserved.
+ *
+ * Author: Javier Arteaga <javier@emutex.com>
+ */
+
+#include <linux/acpi.h>
+#include <linux/dmi.h>
+#include <linux/gpio.h>
+#include <linux/kernel.h>
+#include <linux/leds.h>
+#include <linux/mfd/core.h>
+#include <linux/mfd/upboard-fpga.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+static int upboard_fpga_read(void *, unsigned int, unsigned int *);
+static int upboard_fpga_write(void *, unsigned int, unsigned int);
+
+struct upboard_fpga_data {
+	const struct regmap_config *regmapconf;
+	const struct mfd_cell *cells;
+	size_t ncells;
+};
+
+#define UPBOARD_LED_CELL(led_data, n)                   \
+	{                                               \
+		.name = "upboard-led",                  \
+		.id = (n),                              \
+		.platform_data = &led_data[(n)],        \
+		.pdata_size = sizeof(*(led_data)),      \
+	}
+
+/* UP board */
+
+static const struct regmap_range upboard_up_readable_ranges[] = {
+	regmap_reg_range(UPFPGA_REG_PLATFORM_ID, UPFPGA_REG_FIRMWARE_ID),
+	regmap_reg_range(UPFPGA_REG_FUNC_EN0, UPFPGA_REG_FUNC_EN0),
+	regmap_reg_range(UPFPGA_REG_GPIO_DIR0, UPFPGA_REG_GPIO_DIR1),
+};
+
+static const struct regmap_range upboard_up_writable_ranges[] = {
+	regmap_reg_range(UPFPGA_REG_FUNC_EN0, UPFPGA_REG_FUNC_EN0),
+	regmap_reg_range(UPFPGA_REG_GPIO_DIR0, UPFPGA_REG_GPIO_DIR1),
+};
+
+static const struct regmap_access_table upboard_up_readable_table = {
+	.yes_ranges = upboard_up_readable_ranges,
+	.n_yes_ranges = ARRAY_SIZE(upboard_up_readable_ranges),
+};
+
+static const struct regmap_access_table upboard_up_writable_table = {
+	.yes_ranges = upboard_up_writable_ranges,
+	.n_yes_ranges = ARRAY_SIZE(upboard_up_writable_ranges),
+};
+
+static const struct regmap_config upboard_up_regmap_config = {
+	.reg_bits = UPFPGA_ADDRESS_SIZE,
+	.val_bits = UPFPGA_REGISTER_SIZE,
+	.max_register = UPFPGA_REG_MAX,
+	.reg_read = upboard_fpga_read,
+	.reg_write = upboard_fpga_write,
+	.fast_io = false,
+	.cache_type = REGCACHE_RBTREE,
+	.rd_table = &upboard_up_readable_table,
+	.wr_table = &upboard_up_writable_table,
+};
+
+static struct upboard_led_data upboard_up_led_data[] = {
+	{ .bit = 0, .colour = "yellow" },
+	{ .bit = 1, .colour = "green" },
+	{ .bit = 2, .colour = "red" },
+};
+
+static const struct mfd_cell upboard_up_mfd_cells[] = {
+	{ .name = "upboard-pinctrl" },
+	UPBOARD_LED_CELL(upboard_up_led_data, 0),
+	UPBOARD_LED_CELL(upboard_up_led_data, 1),
+	UPBOARD_LED_CELL(upboard_up_led_data, 2),
+};
+
+static const struct upboard_fpga_data upboard_up_fpga_data = {
+	.regmapconf = &upboard_up_regmap_config,
+	.cells = upboard_up_mfd_cells,
+	.ncells = ARRAY_SIZE(upboard_up_mfd_cells),
+};
+
+/* UP^2 board */
+
+static const struct regmap_range upboard_up2_readable_ranges[] = {
+	regmap_reg_range(UPFPGA_REG_PLATFORM_ID, UPFPGA_REG_FIRMWARE_ID),
+	regmap_reg_range(UPFPGA_REG_FUNC_EN0, UPFPGA_REG_FUNC_EN1),
+	regmap_reg_range(UPFPGA_REG_GPIO_EN0, UPFPGA_REG_GPIO_EN2),
+	regmap_reg_range(UPFPGA_REG_GPIO_DIR0, UPFPGA_REG_GPIO_DIR2),
+};
+
+static const struct regmap_range upboard_up2_writable_ranges[] = {
+	regmap_reg_range(UPFPGA_REG_FUNC_EN0, UPFPGA_REG_FUNC_EN1),
+	regmap_reg_range(UPFPGA_REG_GPIO_EN0, UPFPGA_REG_GPIO_EN2),
+	regmap_reg_range(UPFPGA_REG_GPIO_DIR0, UPFPGA_REG_GPIO_DIR2),
+};
+
+static const struct regmap_access_table upboard_up2_readable_table = {
+	.yes_ranges = upboard_up2_readable_ranges,
+	.n_yes_ranges = ARRAY_SIZE(upboard_up2_readable_ranges),
+};
+
+static const struct regmap_access_table upboard_up2_writable_table = {
+	.yes_ranges = upboard_up2_writable_ranges,
+	.n_yes_ranges = ARRAY_SIZE(upboard_up2_writable_ranges),
+};
+
+static const struct regmap_config upboard_up2_regmap_config = {
+	.reg_bits = UPFPGA_ADDRESS_SIZE,
+	.val_bits = UPFPGA_REGISTER_SIZE,
+	.max_register = UPFPGA_REG_MAX,
+	.reg_read = upboard_fpga_read,
+	.reg_write = upboard_fpga_write,
+	.fast_io = false,
+	.cache_type = REGCACHE_RBTREE,
+	.rd_table = &upboard_up2_readable_table,
+	.wr_table = &upboard_up2_writable_table,
+};
+
+static struct upboard_led_data upboard_up2_led_data[] = {
+	{ .bit = 0, .colour = "blue" },
+	{ .bit = 1, .colour = "yellow" },
+	{ .bit = 2, .colour = "green" },
+	{ .bit = 3, .colour = "red" },
+};
+
+static const struct mfd_cell upboard_up2_mfd_cells[] = {
+	{ .name = "upboard-pinctrl" },
+	UPBOARD_LED_CELL(upboard_up2_led_data, 0),
+	UPBOARD_LED_CELL(upboard_up2_led_data, 1),
+	UPBOARD_LED_CELL(upboard_up2_led_data, 2),
+	UPBOARD_LED_CELL(upboard_up2_led_data, 3),
+};
+
+static const struct upboard_fpga_data upboard_up2_fpga_data = {
+	.regmapconf = &upboard_up2_regmap_config,
+	.cells = upboard_up2_mfd_cells,
+	.ncells = ARRAY_SIZE(upboard_up2_mfd_cells),
+};
+
+/* UP-CREX carrier board for UP Core */
+
+/* same MAXV config as UP1 (proto2 release) */
+#define upboard_upcore_crex_fpga_data upboard_up_fpga_data
+
+/* UP-CRST02 carrier board for UP Core */
+
+/* same MAX10 config as UP2, but same LED cells as UP1 */
+static const struct upboard_fpga_data upboard_upcore_crst02_fpga_data = {
+	.regmapconf = &upboard_up2_regmap_config,
+	.cells = upboard_up_mfd_cells,
+	.ncells = ARRAY_SIZE(upboard_up_mfd_cells),
+};
+
+static int upboard_fpga_read(void *context, unsigned int reg, unsigned int *val)
+{
+	struct upboard_fpga * const fpga = context;
+	int i;
+
+	gpiod_set_value(fpga->clear_gpio, 0);
+	gpiod_set_value(fpga->clear_gpio, 1);
+
+	reg |= UPFPGA_READ_FLAG;
+
+	for (i = UPFPGA_ADDRESS_SIZE; i >= 0; i--) {
+		gpiod_set_value(fpga->strobe_gpio, 0);
+		gpiod_set_value(fpga->datain_gpio, (reg >> i) & 0x1);
+		gpiod_set_value(fpga->strobe_gpio, 1);
+	}
+
+	gpiod_set_value(fpga->strobe_gpio, 0);
+	*val = 0;
+
+	for (i = UPFPGA_REGISTER_SIZE - 1; i >= 0; i--) {
+		gpiod_set_value(fpga->strobe_gpio, 1);
+		gpiod_set_value(fpga->strobe_gpio, 0);
+		*val |= gpiod_get_value(fpga->dataout_gpio) << i;
+	}
+
+	gpiod_set_value(fpga->strobe_gpio, 1);
+
+	return 0;
+};
+
+static int upboard_fpga_write(void *context, unsigned int reg, unsigned int val)
+{
+	struct upboard_fpga * const fpga = context;
+	int i;
+
+	gpiod_set_value(fpga->clear_gpio, 0);
+	gpiod_set_value(fpga->clear_gpio, 1);
+
+	for (i = UPFPGA_ADDRESS_SIZE; i >= 0; i--) {
+		gpiod_set_value(fpga->strobe_gpio, 0);
+		gpiod_set_value(fpga->datain_gpio, (reg >> i) & 0x1);
+		gpiod_set_value(fpga->strobe_gpio, 1);
+	}
+
+	gpiod_set_value(fpga->strobe_gpio, 0);
+
+	for (i = UPFPGA_REGISTER_SIZE - 1; i >= 0; i--) {
+		gpiod_set_value(fpga->datain_gpio, (val >> i) & 0x1);
+		gpiod_set_value(fpga->strobe_gpio, 1);
+		gpiod_set_value(fpga->strobe_gpio, 0);
+	}
+
+	gpiod_set_value(fpga->strobe_gpio, 1);
+
+	return 0;
+};
+
+static int __init upboard_fpga_gpio_init(struct upboard_fpga *fpga)
+{
+	enum gpiod_flags flags;
+
+	flags = fpga->uninitialised ? GPIOD_OUT_LOW : GPIOD_ASIS;
+	fpga->enable_gpio = devm_gpiod_get(fpga->dev, "enable", flags);
+	if (IS_ERR(fpga->enable_gpio))
+		return PTR_ERR(fpga->enable_gpio);
+
+	fpga->clear_gpio = devm_gpiod_get(fpga->dev, "clear", GPIOD_OUT_LOW);
+	if (IS_ERR(fpga->clear_gpio))
+		return PTR_ERR(fpga->clear_gpio);
+
+	fpga->strobe_gpio = devm_gpiod_get(fpga->dev, "strobe", GPIOD_OUT_LOW);
+	if (IS_ERR(fpga->strobe_gpio))
+		return PTR_ERR(fpga->strobe_gpio);
+
+	fpga->datain_gpio = devm_gpiod_get(fpga->dev, "datain", GPIOD_OUT_LOW);
+	if (IS_ERR(fpga->datain_gpio))
+		return PTR_ERR(fpga->datain_gpio);
+
+	fpga->dataout_gpio = devm_gpiod_get(fpga->dev, "dataout", GPIOD_IN);
+	if (IS_ERR(fpga->dataout_gpio))
+		return PTR_ERR(fpga->dataout_gpio);
+
+	/* The SoC pinctrl driver may not support reserving the GPIO line for
+	 * FPGA reset without causing an undesired reset pulse. This will clear
+	 * any settings on the FPGA, so only do it if we must.
+	 */
+	if (fpga->uninitialised) {
+		fpga->reset_gpio = devm_gpiod_get(fpga->dev, "reset",
+						  GPIOD_OUT_LOW);
+		if (IS_ERR(fpga->reset_gpio))
+			return PTR_ERR(fpga->reset_gpio);
+
+		gpiod_set_value(fpga->reset_gpio, 1);
+	}
+
+	gpiod_set_value(fpga->enable_gpio, 1);
+	fpga->uninitialised = false;
+
+	return 0;
+}
+
+static int __init upboard_fpga_detect_firmware(struct upboard_fpga *fpga)
+{
+	const unsigned int AAEON_MANUFACTURER_ID = 0x01;
+	const unsigned int SUPPORTED_FW_MAJOR = 0x0;
+	unsigned int platform_id, manufacturer_id;
+	unsigned int firmware_id, build, major, minor, patch;
+	int ret;
+
+	ret = regmap_read(fpga->regmap, UPFPGA_REG_PLATFORM_ID, &platform_id);
+	if (ret)
+		return ret;
+
+	manufacturer_id = platform_id & 0xff;
+	if (manufacturer_id != AAEON_MANUFACTURER_ID) {
+		dev_dbg(fpga->dev,
+			"driver not compatible with custom FPGA FW from manufacturer id 0x%02x. Exiting",
+			manufacturer_id);
+		return -ENODEV;
+	}
+
+	ret = regmap_read(fpga->regmap, UPFPGA_REG_FIRMWARE_ID, &firmware_id);
+	if (ret)
+		return ret;
+
+	build = (firmware_id >> 12) & 0xf;
+	major = (firmware_id >> 8) & 0xf;
+	minor = (firmware_id >> 4) & 0xf;
+	patch = firmware_id & 0xf;
+	if (major != SUPPORTED_FW_MAJOR) {
+		dev_dbg(fpga->dev, "unsupported FPGA FW v%u.%u.%u build 0x%02x",
+			major, minor, patch, build);
+		return -ENODEV;
+	}
+
+	dev_info(fpga->dev, "compatible FPGA FW v%u.%u.%u build 0x%02x",
+		 major, minor, patch, build);
+	return 0;
+}
+
+static const struct acpi_device_id upboard_fpga_acpi_match[] = {
+	{ "AANT0F00", (kernel_ulong_t)&upboard_up_fpga_data },
+	{ "AANT0F01", (kernel_ulong_t)&upboard_up2_fpga_data },
+	{ "AANT0F02", (kernel_ulong_t)&upboard_upcore_crex_fpga_data },
+	{ "AANT0F03", (kernel_ulong_t)&upboard_upcore_crst02_fpga_data },
+	{ "AANT0F04", (kernel_ulong_t)&upboard_up_fpga_data },
+	{ }
+};
+MODULE_DEVICE_TABLE(acpi, upboard_fpga_acpi_match);
+
+#define UPFPGA_QUIRK_UNINITIALISED  BIT(0)
+#define UPFPGA_QUIRK_HRV1_IS_PROTO2 BIT(1)
+#define UPFPGA_QUIRK_GPIO_LED       BIT(2)
+
+static const struct dmi_system_id upboard_dmi_table[] __initconst = {
+	{
+		.matches = { /* UP */
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "AAEON"),
+			DMI_EXACT_MATCH(DMI_BOARD_NAME, "UP-CHT01"),
+			DMI_EXACT_MATCH(DMI_BOARD_VERSION, "V0.4"),
+		},
+		.driver_data = (void *)UPFPGA_QUIRK_UNINITIALISED,
+	},
+	{
+		.matches = { /* UP2 */
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "AAEON"),
+			DMI_EXACT_MATCH(DMI_BOARD_NAME, "UP-APL01"),
+			DMI_EXACT_MATCH(DMI_BOARD_VERSION, "V0.3"),
+		},
+		.driver_data = (void *)(UPFPGA_QUIRK_UNINITIALISED |
+			UPFPGA_QUIRK_HRV1_IS_PROTO2),
+	},
+	{
+		.matches = { /* UP2 Pro*/
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "AAEON"),
+			DMI_EXACT_MATCH(DMI_BOARD_NAME, "UPN-APL01"),
+			DMI_EXACT_MATCH(DMI_BOARD_VERSION, "V1.0"),
+		},
+		.driver_data = (void *)UPFPGA_QUIRK_HRV1_IS_PROTO2,
+	},
+	{
+		.matches = { /* UP2 */
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "AAEON"),
+			DMI_EXACT_MATCH(DMI_BOARD_NAME, "UP-APL01"),
+			DMI_EXACT_MATCH(DMI_BOARD_VERSION, "V0.4"),
+		},
+		.driver_data = (void *)UPFPGA_QUIRK_HRV1_IS_PROTO2,
+	},
+	{
+		.matches = { /* UP Xtreme */
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "AAEON"),
+			DMI_EXACT_MATCH(DMI_BOARD_NAME, "UP-WHL01"),
+			DMI_EXACT_MATCH(DMI_BOARD_VERSION, "V0.1"),
+		},
+	},
+	{
+		.matches = { /* UP APL03 */
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "AAEON"),
+			DMI_EXACT_MATCH(DMI_BOARD_NAME, "UP-APL03"),
+			DMI_EXACT_MATCH(DMI_BOARD_VERSION, "V1.0"),
+		},
+		.driver_data = (void *)(UPFPGA_QUIRK_HRV1_IS_PROTO2 |
+			UPFPGA_QUIRK_GPIO_LED),
+	},
+	{ },
+};
+
+#define UPFPGA_PROTOCOL_V2_HRV 2
+
+static int __init upboard_fpga_probe(struct platform_device *pdev)
+{
+	struct upboard_fpga *fpga;
+	const struct acpi_device_id *id;
+	const struct upboard_fpga_data *fpga_data;
+	const struct dmi_system_id *system_id;
+	acpi_handle handle;
+	acpi_status status;
+	unsigned long long hrv;
+	unsigned long quirks = 0;
+	int ret;
+
+	id = acpi_match_device(upboard_fpga_acpi_match, &pdev->dev);
+	if (!id)
+		return -ENODEV;
+
+	handle = ACPI_HANDLE(&pdev->dev);
+	status = acpi_evaluate_integer(handle, "_HRV", NULL, &hrv);
+	if (ACPI_FAILURE(status)) {
+		dev_err(&pdev->dev, "failed to get PCTL revision");
+		return -ENODEV;
+	}
+
+	system_id = dmi_first_match(upboard_dmi_table);
+	if (system_id)
+		quirks = (unsigned long)system_id->driver_data;
+
+	if (hrv == 1 && (quirks & UPFPGA_QUIRK_HRV1_IS_PROTO2))
+		hrv = UPFPGA_PROTOCOL_V2_HRV;
+
+	if (hrv != UPFPGA_PROTOCOL_V2_HRV) {
+		dev_dbg(&pdev->dev, "unsupported PCTL revision: %llu", hrv);
+		return -ENODEV;
+	}
+
+	fpga_data = (const struct upboard_fpga_data *) id->driver_data;
+
+	fpga = devm_kzalloc(&pdev->dev, sizeof(*fpga), GFP_KERNEL);
+	if (!fpga)
+		return -ENOMEM;
+
+	if (quirks & UPFPGA_QUIRK_UNINITIALISED) {
+		dev_info(&pdev->dev, "FPGA not initialised by this BIOS");
+		fpga->uninitialised = true;
+	}
+
+	dev_set_drvdata(&pdev->dev, fpga);
+	fpga->dev = &pdev->dev;
+	fpga->regmap = devm_regmap_init(&pdev->dev, NULL, fpga,
+					fpga_data->regmapconf);
+	if (IS_ERR(fpga->regmap))
+		return PTR_ERR(fpga->regmap);
+
+	ret = upboard_fpga_gpio_init(fpga);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to init FPGA comm GPIOs: %d", ret);
+		return ret;
+	}
+
+	ret = upboard_fpga_detect_firmware(fpga);
+	if (ret)
+		return ret;
+
+	if (quirks & UPFPGA_QUIRK_GPIO_LED) {
+#define APL_GPIO_218	507
+		static struct gpio_led upboard_gpio_leds[] = {
+			{
+				.name = "upboard:blue:",
+				.gpio = APL_GPIO_218,
+				.default_state = LEDS_GPIO_DEFSTATE_KEEP,
+			},
+		};
+		static struct gpio_led_platform_data upboard_gpio_led_platform_data = {
+			.num_leds = ARRAY_SIZE(upboard_gpio_leds),
+			.leds = upboard_gpio_leds,
+		};
+		static const struct mfd_cell upboard_gpio_led_cells[] = {
+			{
+				.name = "leds-gpio",
+				.id = 0,
+				.platform_data = &upboard_gpio_led_platform_data,
+				.pdata_size = sizeof(upboard_gpio_led_platform_data),
+			},
+		};
+
+		ret =  devm_mfd_add_devices(&pdev->dev, 0, upboard_gpio_led_cells,
+				    ARRAY_SIZE(upboard_gpio_led_cells), NULL, 0, NULL);
+		if (ret) {
+			dev_err(&pdev->dev, "Failed to add GPIO leds");
+			return ret;
+		}
+
+	}
+
+	return devm_mfd_add_devices(&pdev->dev, 0, fpga_data->cells,
+				    fpga_data->ncells, NULL, 0, NULL);
+}
+
+static struct platform_driver upboard_fpga_driver = {
+	.driver = {
+		.name = "upboard-fpga",
+		.acpi_match_table = upboard_fpga_acpi_match,
+	},
+};
+
+module_platform_driver_probe(upboard_fpga_driver, upboard_fpga_probe);
+
+MODULE_AUTHOR("Javier Arteaga <javier@emutex.com>");
+MODULE_DESCRIPTION("UP Board FPGA driver");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/mfd/upboard-fpga.h b/include/linux/mfd/upboard-fpga.h
new file mode 100644
index 000000000000..e0940120514d
--- /dev/null
+++ b/include/linux/mfd/upboard-fpga.h
@@ -0,0 +1,49 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * UP Board FPGA MFD driver interface
+ *
+ * Copyright (c) 2017, Emutex Ltd. All rights reserved.
+ *
+ * Author: Javier Arteaga <javier@emutex.com>
+ */
+
+#ifndef __LINUX_MFD_UPBOARD_FPGA_H
+#define __LINUX_MFD_UPBOARD_FPGA_H
+
+#define UPFPGA_ADDRESS_SIZE  7
+#define UPFPGA_REGISTER_SIZE 16
+
+#define UPFPGA_READ_FLAG     (1 << UPFPGA_ADDRESS_SIZE)
+
+enum upboard_fpgareg {
+	UPFPGA_REG_PLATFORM_ID   = 0x10,
+	UPFPGA_REG_FIRMWARE_ID   = 0x11,
+	UPFPGA_REG_FUNC_EN0      = 0x20,
+	UPFPGA_REG_FUNC_EN1      = 0x21,
+	UPFPGA_REG_GPIO_EN0      = 0x30,
+	UPFPGA_REG_GPIO_EN1      = 0x31,
+	UPFPGA_REG_GPIO_EN2      = 0x32,
+	UPFPGA_REG_GPIO_DIR0     = 0x40,
+	UPFPGA_REG_GPIO_DIR1     = 0x41,
+	UPFPGA_REG_GPIO_DIR2     = 0x42,
+	UPFPGA_REG_MAX,
+};
+
+struct upboard_fpga {
+	struct device *dev;
+	struct regmap *regmap;
+	struct gpio_desc *enable_gpio;
+	struct gpio_desc *reset_gpio;
+	struct gpio_desc *clear_gpio;
+	struct gpio_desc *strobe_gpio;
+	struct gpio_desc *datain_gpio;
+	struct gpio_desc *dataout_gpio;
+	bool uninitialised;
+};
+
+struct upboard_led_data {
+	unsigned int bit;
+	const char *colour;
+};
+
+#endif /*  __LINUX_MFD_UPBOARD_FPGA_H */
-- 
2.17.1

