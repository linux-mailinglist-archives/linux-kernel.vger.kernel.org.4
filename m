Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F530613984
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 15:58:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231375AbiJaO6l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 10:58:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbiJaO6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 10:58:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87441FD2C;
        Mon, 31 Oct 2022 07:58:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 135DB6129A;
        Mon, 31 Oct 2022 14:58:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BF90C433C1;
        Mon, 31 Oct 2022 14:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667228315;
        bh=xKf/cPCTyp1qEiVTHgWxTY2DMEgM80Amt8DA3IJQs+4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kZ5DeTjOYWcY0aTTNeaYGsHkAefsC4Rz0vYxecJjkJYR9RPNWnn3CnaVr3jyDgLSx
         DPk0B2ojV0q8YxlgMYNRIB2hd4Jf9Sh+ACMkL1ZJv5/ABBi8M+Q+Jqynjyg5UtnhPj
         txr3zf9kK746+BPAyXy5Zy9EaBs5xWH7er2alLIhkP3tav1g/jzEZ1WSbhqYcX1h+J
         rvk163H3E2gmBgANEHybEkVts2D3kNTbyEXQbKgiXP5nSHdY8dP4PbhAp8Gtzh8VEJ
         i8KoyVNUG1roPTGEuU+K2eD1B307860bF4nNAUreK+2iX+6kn+850poQI37Ef1tU3y
         S8JbLYMcoesKQ==
Date:   Mon, 31 Oct 2022 14:58:27 +0000
From:   Lee Jones <lee@kernel.org>
To:     chengwei <foxfly.lai.tw@gmail.com>
Cc:     broonie@kernel.org, rafael@kernel.org,
        mika.westerberg@linux.intel.com, andriy.shevchenko@linux.intel.com,
        linus.walleij@linaro.org, brgl@bgdev.pl,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-gpio@vger.kernel.org, GaryWang@aaeon.com.tw,
        musa.lin@yunjingtech.com, jack.chang@yunjingtech.com,
        chengwei <larry.lai@yunjingtech.com>,
        Javier Arteaga <javier@emutex.com>,
        Nicola Lunghi <nicola.lunghi@emutex.com>
Subject: Re: [PATCH 1/5] mfd: Add support for UP board CPLD/FPGA
Message-ID: <Y1/ik4XGNWsOg5KH@google.com>
References: <20221019022450.16851-1-larry.lai@yunjingtech.com>
 <20221019022450.16851-2-larry.lai@yunjingtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221019022450.16851-2-larry.lai@yunjingtech.com>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Oct 2022, chengwei wrote:

> The UP Squared board <http://www.upboard.com> implements certain
> features (pin control, onboard LEDs or CEC) through an on-board CPLD/FPGA.
> 
> This mfd driver implements the line protocol to read and write registers
> from the FPGA through regmap. The register address map is also included.
> 
> The UP Boards provide a few I/O pin headers (for both GPIO and
> functions), including a 40-pin Raspberry Pi compatible header.
> 
> This patch implements support for the FPGA-based pin controller that
> manages direction and enable state for those header pins.
> 
> Partial support UP boards:
> * UP core + CREX
> * UP core + CRST02
> 
> Signed-off-by: Javier Arteaga <javier@emutex.com>
> [merge various fixes]
> Signed-off-by: Nicola Lunghi <nicola.lunghi@emutex.com>
> Signed-off-by: chengwei <larry.lai@yunjingtech.com>

Why does your name not match your email?

> ---

What happened to all of the other versions?

And the change-log?

>  drivers/mfd/Kconfig              |  12 +
>  drivers/mfd/Makefile             |   1 +
>  drivers/mfd/upboard-fpga.c       | 482 +++++++++++++++++++++++++++++++
>  include/linux/mfd/upboard-fpga.h |  49 ++++
>  4 files changed, 544 insertions(+)
>  create mode 100644 drivers/mfd/upboard-fpga.c
>  create mode 100644 include/linux/mfd/upboard-fpga.h
> 
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index abb58ab1a1a4..c1d72a70e5f2 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -2104,6 +2104,18 @@ config MFD_QCOM_PM8008
>  	  under it in the device tree. Additional drivers must be enabled in
>  	  order to use the functionality of the device.
>  
> +config MFD_UPBOARD_FPGA
> +	tristate "Support for the UP board FPGA"

"Intel"?

> +	select MFD_CORE
> +	depends on X86 && ACPI
> +	help
> +	  Select this option to enable the Intel AAEON UP and UP^2 on-board FPGA.
> +	  The UP board implements certain features (pin control, onboard LEDs or
> +	  CEC) through an on-board FPGA.
> +
> +	  To compile this driver as a module, choose M here: the module will be
> +	  called upboard-fpga.
> +
>  menu "Multimedia Capabilities Port drivers"
>  	depends on ARCH_SA1100
>  
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index 858cacf659d6..d9d10e3664f7 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -250,6 +250,7 @@ obj-$(CONFIG_MFD_ALTERA_A10SR)	+= altera-a10sr.o
>  obj-$(CONFIG_MFD_ALTERA_SYSMGR) += altera-sysmgr.o
>  obj-$(CONFIG_MFD_STPMIC1)	+= stpmic1.o
>  obj-$(CONFIG_MFD_SUN4I_GPADC)	+= sun4i-gpadc.o
> +obj-$(CONFIG_MFD_UPBOARD_FPGA)	+= upboard-fpga.o
>  
>  obj-$(CONFIG_MFD_STM32_LPTIMER)	+= stm32-lptimer.o
>  obj-$(CONFIG_MFD_STM32_TIMERS) 	+= stm32-timers.o
> diff --git a/drivers/mfd/upboard-fpga.c b/drivers/mfd/upboard-fpga.c
> new file mode 100644
> index 000000000000..6f73c2fa6f4a
> --- /dev/null
> +++ b/drivers/mfd/upboard-fpga.c
> @@ -0,0 +1,482 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * UP Board main platform driver and FPGA configuration support

"Intel AAEON UP and UP^2"

> + * Copyright (c) 2017, Emutex Ltd. All rights reserved.

No changes since 2017?

> + * Author: Javier Arteaga <javier@emutex.com>
> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/dmi.h>
> +#include <linux/gpio.h>
> +#include <linux/kernel.h>
> +#include <linux/leds.h>
> +#include <linux/mfd/core.h>
> +#include <linux/mfd/upboard-fpga.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +
> +static int upboard_fpga_read(void *, unsigned int, unsigned int *);
> +static int upboard_fpga_write(void *, unsigned int, unsigned int);

No prototypes please.

Reorder the file instead.

> +struct upboard_fpga_data {
> +	const struct regmap_config *regmapconf;

> +	const struct mfd_cell *cells;
> +	size_t ncells;

This is unlikely to be acceptable.

Please reference the tables where you use them, instead of passing
MFD initialisation pointers through the ACPI API.

> +};
> +
> +#define UPBOARD_LED_CELL(led_data, n)                   \
> +	{                                               \
> +		.name = "upboard-led",                  \
> +		.id = (n),                              \
> +		.platform_data = &led_data[(n)],        \
> +		.pdata_size = sizeof(*(led_data)),      \
> +	}

We already have defines like this.  Please use them instead.

> +/* UP board */
> +
> +static const struct regmap_range upboard_up_readable_ranges[] = {
> +	regmap_reg_range(UPFPGA_REG_PLATFORM_ID, UPFPGA_REG_FIRMWARE_ID),
> +	regmap_reg_range(UPFPGA_REG_FUNC_EN0, UPFPGA_REG_FUNC_EN0),
> +	regmap_reg_range(UPFPGA_REG_GPIO_DIR0, UPFPGA_REG_GPIO_DIR1),
> +};
> +
> +static const struct regmap_range upboard_up_writable_ranges[] = {
> +	regmap_reg_range(UPFPGA_REG_FUNC_EN0, UPFPGA_REG_FUNC_EN0),
> +	regmap_reg_range(UPFPGA_REG_GPIO_DIR0, UPFPGA_REG_GPIO_DIR1),
> +};
> +
> +static const struct regmap_access_table upboard_up_readable_table = {
> +	.yes_ranges = upboard_up_readable_ranges,
> +	.n_yes_ranges = ARRAY_SIZE(upboard_up_readable_ranges),
> +};
> +
> +static const struct regmap_access_table upboard_up_writable_table = {
> +	.yes_ranges = upboard_up_writable_ranges,
> +	.n_yes_ranges = ARRAY_SIZE(upboard_up_writable_ranges),
> +};
> +
> +static const struct regmap_config upboard_up_regmap_config = {
> +	.reg_bits = UPFPGA_ADDRESS_SIZE,
> +	.val_bits = UPFPGA_REGISTER_SIZE,
> +	.max_register = UPFPGA_REG_MAX,
> +	.reg_read = upboard_fpga_read,
> +	.reg_write = upboard_fpga_write,
> +	.fast_io = false,
> +	.cache_type = REGCACHE_RBTREE,
> +	.rd_table = &upboard_up_readable_table,
> +	.wr_table = &upboard_up_writable_table,
> +};
> +
> +static struct upboard_led_data upboard_up_led_data[] = {
> +	{ .bit = 0, .colour = "yellow" },
> +	{ .bit = 1, .colour = "green" },
> +	{ .bit = 2, .colour = "red" },
> +};

Not a big deal, but can't this info be derived from the ACPI tables?

> +static const struct mfd_cell upboard_up_mfd_cells[] = {
> +	{ .name = "upboard-pinctrl" },
> +	UPBOARD_LED_CELL(upboard_up_led_data, 0),
> +	UPBOARD_LED_CELL(upboard_up_led_data, 1),
> +	UPBOARD_LED_CELL(upboard_up_led_data, 2),
> +};
> +
> +static const struct upboard_fpga_data upboard_up_fpga_data = {
> +	.regmapconf = &upboard_up_regmap_config,
> +	.cells = upboard_up_mfd_cells,
> +	.ncells = ARRAY_SIZE(upboard_up_mfd_cells),
> +};
> +
> +/* UP^2 board */
> +
> +static const struct regmap_range upboard_up2_readable_ranges[] = {
> +	regmap_reg_range(UPFPGA_REG_PLATFORM_ID, UPFPGA_REG_FIRMWARE_ID),
> +	regmap_reg_range(UPFPGA_REG_FUNC_EN0, UPFPGA_REG_FUNC_EN1),
> +	regmap_reg_range(UPFPGA_REG_GPIO_EN0, UPFPGA_REG_GPIO_EN2),
> +	regmap_reg_range(UPFPGA_REG_GPIO_DIR0, UPFPGA_REG_GPIO_DIR2),
> +};
> +
> +static const struct regmap_range upboard_up2_writable_ranges[] = {
> +	regmap_reg_range(UPFPGA_REG_FUNC_EN0, UPFPGA_REG_FUNC_EN1),
> +	regmap_reg_range(UPFPGA_REG_GPIO_EN0, UPFPGA_REG_GPIO_EN2),
> +	regmap_reg_range(UPFPGA_REG_GPIO_DIR0, UPFPGA_REG_GPIO_DIR2),
> +};
> +
> +static const struct regmap_access_table upboard_up2_readable_table = {
> +	.yes_ranges = upboard_up2_readable_ranges,
> +	.n_yes_ranges = ARRAY_SIZE(upboard_up2_readable_ranges),
> +};
> +
> +static const struct regmap_access_table upboard_up2_writable_table = {
> +	.yes_ranges = upboard_up2_writable_ranges,
> +	.n_yes_ranges = ARRAY_SIZE(upboard_up2_writable_ranges),
> +};
> +
> +static const struct regmap_config upboard_up2_regmap_config = {
> +	.reg_bits = UPFPGA_ADDRESS_SIZE,
> +	.val_bits = UPFPGA_REGISTER_SIZE,
> +	.max_register = UPFPGA_REG_MAX,
> +	.reg_read = upboard_fpga_read,
> +	.reg_write = upboard_fpga_write,
> +	.fast_io = false,
> +	.cache_type = REGCACHE_RBTREE,
> +	.rd_table = &upboard_up2_readable_table,
> +	.wr_table = &upboard_up2_writable_table,
> +};
> +
> +static struct upboard_led_data upboard_up2_led_data[] = {
> +	{ .bit = 0, .colour = "blue" },
> +	{ .bit = 1, .colour = "yellow" },
> +	{ .bit = 2, .colour = "green" },
> +	{ .bit = 3, .colour = "red" },
> +};
> +
> +static const struct mfd_cell upboard_up2_mfd_cells[] = {
> +	{ .name = "upboard-pinctrl" },
> +	UPBOARD_LED_CELL(upboard_up2_led_data, 0),
> +	UPBOARD_LED_CELL(upboard_up2_led_data, 1),
> +	UPBOARD_LED_CELL(upboard_up2_led_data, 2),
> +	UPBOARD_LED_CELL(upboard_up2_led_data, 3),
> +};
> +
> +static const struct upboard_fpga_data upboard_up2_fpga_data = {
> +	.regmapconf = &upboard_up2_regmap_config,
> +	.cells = upboard_up2_mfd_cells,
> +	.ncells = ARRAY_SIZE(upboard_up2_mfd_cells),
> +};
> +
> +/* UP-CREX carrier board for UP Core */
> +
> +/* same MAXV config as UP1 (proto2 release) */
> +#define upboard_upcore_crex_fpga_data upboard_up_fpga_data
> +
> +/* UP-CRST02 carrier board for UP Core */
> +
> +/* same MAX10 config as UP2, but same LED cells as UP1 */
> +static const struct upboard_fpga_data upboard_upcore_crst02_fpga_data = {
> +	.regmapconf = &upboard_up2_regmap_config,
> +	.cells = upboard_up_mfd_cells,
> +	.ncells = ARRAY_SIZE(upboard_up_mfd_cells),
> +};
> +
> +static int upboard_fpga_read(void *context, unsigned int reg, unsigned int *val)
> +{
> +	struct upboard_fpga * const fpga = context;
> +	int i;
> +
> +	gpiod_set_value(fpga->clear_gpio, 0);
> +	gpiod_set_value(fpga->clear_gpio, 1);
> +
> +	reg |= UPFPGA_READ_FLAG;
> +
> +	for (i = UPFPGA_ADDRESS_SIZE; i >= 0; i--) {
> +		gpiod_set_value(fpga->strobe_gpio, 0);
> +		gpiod_set_value(fpga->datain_gpio, (reg >> i) & 0x1);
> +		gpiod_set_value(fpga->strobe_gpio, 1);
> +	}
> +
> +	gpiod_set_value(fpga->strobe_gpio, 0);
> +	*val = 0;
> +
> +	for (i = UPFPGA_REGISTER_SIZE - 1; i >= 0; i--) {
> +		gpiod_set_value(fpga->strobe_gpio, 1);
> +		gpiod_set_value(fpga->strobe_gpio, 0);
> +		*val |= gpiod_get_value(fpga->dataout_gpio) << i;
> +	}
> +
> +	gpiod_set_value(fpga->strobe_gpio, 1);

A little bit of commentary in here would help us understand how this
works.

> +	return 0;
> +};
> +
> +static int upboard_fpga_write(void *context, unsigned int reg, unsigned int val)
> +{
> +	struct upboard_fpga * const fpga = context;
> +	int i;
> +
> +	gpiod_set_value(fpga->clear_gpio, 0);
> +	gpiod_set_value(fpga->clear_gpio, 1);
> +
> +	for (i = UPFPGA_ADDRESS_SIZE; i >= 0; i--) {
> +		gpiod_set_value(fpga->strobe_gpio, 0);
> +		gpiod_set_value(fpga->datain_gpio, (reg >> i) & 0x1);
> +		gpiod_set_value(fpga->strobe_gpio, 1);
> +	}
> +
> +	gpiod_set_value(fpga->strobe_gpio, 0);
> +
> +	for (i = UPFPGA_REGISTER_SIZE - 1; i >= 0; i--) {
> +		gpiod_set_value(fpga->datain_gpio, (val >> i) & 0x1);
> +		gpiod_set_value(fpga->strobe_gpio, 1);
> +		gpiod_set_value(fpga->strobe_gpio, 0);
> +	}
> +
> +	gpiod_set_value(fpga->strobe_gpio, 1);

As above.

> +	return 0;
> +};
> +
> +static int __init upboard_fpga_gpio_init(struct upboard_fpga *fpga)
> +{
> +	enum gpiod_flags flags;
> +
> +	flags = fpga->uninitialised ? GPIOD_OUT_LOW : GPIOD_ASIS;

Nit: '\n'

> +	fpga->enable_gpio = devm_gpiod_get(fpga->dev, "enable", flags);
> +	if (IS_ERR(fpga->enable_gpio))
> +		return PTR_ERR(fpga->enable_gpio);
> +
> +	fpga->clear_gpio = devm_gpiod_get(fpga->dev, "clear", GPIOD_OUT_LOW);
> +	if (IS_ERR(fpga->clear_gpio))
> +		return PTR_ERR(fpga->clear_gpio);
> +
> +	fpga->strobe_gpio = devm_gpiod_get(fpga->dev, "strobe", GPIOD_OUT_LOW);
> +	if (IS_ERR(fpga->strobe_gpio))
> +		return PTR_ERR(fpga->strobe_gpio);
> +
> +	fpga->datain_gpio = devm_gpiod_get(fpga->dev, "datain", GPIOD_OUT_LOW);
> +	if (IS_ERR(fpga->datain_gpio))
> +		return PTR_ERR(fpga->datain_gpio);
> +
> +	fpga->dataout_gpio = devm_gpiod_get(fpga->dev, "dataout", GPIOD_IN);
> +	if (IS_ERR(fpga->dataout_gpio))
> +		return PTR_ERR(fpga->dataout_gpio);
> +
> +	/* The SoC pinctrl driver may not support reserving the GPIO line for
> +	 * FPGA reset without causing an undesired reset pulse. This will clear
> +	 * any settings on the FPGA, so only do it if we must.
> +	 */

Please use correctly formatted multi-line comments.

> +	if (fpga->uninitialised) {
> +		fpga->reset_gpio = devm_gpiod_get(fpga->dev, "reset",
> +						  GPIOD_OUT_LOW);
> +		if (IS_ERR(fpga->reset_gpio))
> +			return PTR_ERR(fpga->reset_gpio);
> +
> +		gpiod_set_value(fpga->reset_gpio, 1);
> +	}
> +
> +	gpiod_set_value(fpga->enable_gpio, 1);
> +	fpga->uninitialised = false;
> +
> +	return 0;
> +}
> +
> +static int __init upboard_fpga_detect_firmware(struct upboard_fpga *fpga)
> +{
> +	const unsigned int AAEON_MANUFACTURER_ID = 0x01;

Please define these.

Variables should be lower case.

> +	const unsigned int SUPPORTED_FW_MAJOR = 0x0;
> +	unsigned int platform_id, manufacturer_id;
> +	unsigned int firmware_id, build, major, minor, patch;
> +	int ret;
> +
> +	ret = regmap_read(fpga->regmap, UPFPGA_REG_PLATFORM_ID, &platform_id);
> +	if (ret)
> +		return ret;
> +
> +	manufacturer_id = platform_id & 0xff;

#define the 0xff - perhaps MANUFACTURER_MASK.

> +	if (manufacturer_id != AAEON_MANUFACTURER_ID) {
> +		dev_dbg(fpga->dev,
> +			"driver not compatible with custom FPGA FW from manufacturer id 0x%02x. Exiting",
> +			manufacturer_id);
> +		return -ENODEV;

If this is an error, your print messages should be dev_err().

> +	}
> +
> +	ret = regmap_read(fpga->regmap, UPFPGA_REG_FIRMWARE_ID, &firmware_id);
> +	if (ret)
> +		return ret;
> +
> +	build = (firmware_id >> 12) & 0xf;
> +	major = (firmware_id >> 8) & 0xf;
> +	minor = (firmware_id >> 4) & 0xf;
> +	patch = firmware_id & 0xf;

Nit: '\n'

> +	if (major != SUPPORTED_FW_MAJOR) {
> +		dev_dbg(fpga->dev, "unsupported FPGA FW v%u.%u.%u build 0x%02x",
> +			major, minor, patch, build);
> +		return -ENODEV;
> +	}
> +
> +	dev_info(fpga->dev, "compatible FPGA FW v%u.%u.%u build 0x%02x",
> +		 major, minor, patch, build);

Nit: '\n'

> +	return 0;
> +}
> +
> +static const struct acpi_device_id upboard_fpga_acpi_match[] = {
> +	{ "AANT0F00", (kernel_ulong_t)&upboard_up_fpga_data },
> +	{ "AANT0F01", (kernel_ulong_t)&upboard_up2_fpga_data },
> +	{ "AANT0F02", (kernel_ulong_t)&upboard_upcore_crex_fpga_data },
> +	{ "AANT0F03", (kernel_ulong_t)&upboard_upcore_crst02_fpga_data },
> +	{ "AANT0F04", (kernel_ulong_t)&upboard_up_fpga_data },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(acpi, upboard_fpga_acpi_match);

Please don't mix platform registration strategies.

Pass platform / hardware IDs instead and to the selecting in C.

> +#define UPFPGA_QUIRK_UNINITIALISED  BIT(0)
> +#define UPFPGA_QUIRK_HRV1_IS_PROTO2 BIT(1)
> +#define UPFPGA_QUIRK_GPIO_LED       BIT(2)
> +
> +static const struct dmi_system_id upboard_dmi_table[] __initconst = {
> +	{
> +		.matches = { /* UP */
> +			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "AAEON"),
> +			DMI_EXACT_MATCH(DMI_BOARD_NAME, "UP-CHT01"),
> +			DMI_EXACT_MATCH(DMI_BOARD_VERSION, "V0.4"),
> +		},
> +		.driver_data = (void *)UPFPGA_QUIRK_UNINITIALISED,
> +	},
> +	{
> +		.matches = { /* UP2 */
> +			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "AAEON"),
> +			DMI_EXACT_MATCH(DMI_BOARD_NAME, "UP-APL01"),
> +			DMI_EXACT_MATCH(DMI_BOARD_VERSION, "V0.3"),
> +		},
> +		.driver_data = (void *)(UPFPGA_QUIRK_UNINITIALISED |
> +			UPFPGA_QUIRK_HRV1_IS_PROTO2),
> +	},
> +	{
> +		.matches = { /* UP2 Pro*/
> +			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "AAEON"),
> +			DMI_EXACT_MATCH(DMI_BOARD_NAME, "UPN-APL01"),
> +			DMI_EXACT_MATCH(DMI_BOARD_VERSION, "V1.0"),
> +		},
> +		.driver_data = (void *)UPFPGA_QUIRK_HRV1_IS_PROTO2,
> +	},
> +	{
> +		.matches = { /* UP2 */
> +			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "AAEON"),
> +			DMI_EXACT_MATCH(DMI_BOARD_NAME, "UP-APL01"),
> +			DMI_EXACT_MATCH(DMI_BOARD_VERSION, "V0.4"),
> +		},
> +		.driver_data = (void *)UPFPGA_QUIRK_HRV1_IS_PROTO2,
> +	},
> +	{
> +		.matches = { /* UP Xtreme */
> +			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "AAEON"),
> +			DMI_EXACT_MATCH(DMI_BOARD_NAME, "UP-WHL01"),
> +			DMI_EXACT_MATCH(DMI_BOARD_VERSION, "V0.1"),
> +		},
> +	},
> +	{
> +		.matches = { /* UP APL03 */
> +			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "AAEON"),
> +			DMI_EXACT_MATCH(DMI_BOARD_NAME, "UP-APL03"),
> +			DMI_EXACT_MATCH(DMI_BOARD_VERSION, "V1.0"),
> +		},
> +		.driver_data = (void *)(UPFPGA_QUIRK_HRV1_IS_PROTO2 |
> +			UPFPGA_QUIRK_GPIO_LED),
> +	},
> +	{ },
> +};
> +
> +#define UPFPGA_PROTOCOL_V2_HRV 2

How does this differ from UPFPGA_QUIRK_HRV1_IS_PROTO2?

> +static int __init upboard_fpga_probe(struct platform_device *pdev)
> +{
> +	struct upboard_fpga *fpga;

This is more widely known as 'ddata'.

> +	const struct acpi_device_id *id;
> +	const struct upboard_fpga_data *fpga_data;
> +	const struct dmi_system_id *system_id;
> +	acpi_handle handle;
> +	acpi_status status;
> +	unsigned long long hrv;
> +	unsigned long quirks = 0;
> +	int ret;
> +
> +	id = acpi_match_device(upboard_fpga_acpi_match, &pdev->dev);
> +	if (!id)
> +		return -ENODEV;
> +
> +	handle = ACPI_HANDLE(&pdev->dev);
> +	status = acpi_evaluate_integer(handle, "_HRV", NULL, &hrv);
> +	if (ACPI_FAILURE(status)) {
> +		dev_err(&pdev->dev, "failed to get PCTL revision");
> +		return -ENODEV;
> +	}
> +
> +	system_id = dmi_first_match(upboard_dmi_table);
> +	if (system_id)
> +		quirks = (unsigned long)system_id->driver_data;
> +
> +	if (hrv == 1 && (quirks & UPFPGA_QUIRK_HRV1_IS_PROTO2))

What is HRV?  And what is 1?  Please define.

> +		hrv = UPFPGA_PROTOCOL_V2_HRV;
> +
> +	if (hrv != UPFPGA_PROTOCOL_V2_HRV) {
> +		dev_dbg(&pdev->dev, "unsupported PCTL revision: %llu", hrv);
> +		return -ENODEV;
> +	}
> +
> +	fpga_data = (const struct upboard_fpga_data *) id->driver_data;
> +
> +	fpga = devm_kzalloc(&pdev->dev, sizeof(*fpga), GFP_KERNEL);
> +	if (!fpga)
> +		return -ENOMEM;
> +
> +	if (quirks & UPFPGA_QUIRK_UNINITIALISED) {
> +		dev_info(&pdev->dev, "FPGA not initialised by this BIOS");
> +		fpga->uninitialised = true;
> +	}
> +
> +	dev_set_drvdata(&pdev->dev, fpga);
> +	fpga->dev = &pdev->dev;
> +	fpga->regmap = devm_regmap_init(&pdev->dev, NULL, fpga,
> +					fpga_data->regmapconf);
> +	if (IS_ERR(fpga->regmap))
> +		return PTR_ERR(fpga->regmap);
> +
> +	ret = upboard_fpga_gpio_init(fpga);
> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to init FPGA comm GPIOs: %d", ret);

Please expand 'init' and 'comm'.

> +		return ret;
> +	}
> +
> +	ret = upboard_fpga_detect_firmware(fpga);
> +	if (ret)
> +		return ret;
> +
> +	if (quirks & UPFPGA_QUIRK_GPIO_LED) {
> +#define APL_GPIO_218	507

Please define somewhere more central.

> +		static struct gpio_led upboard_gpio_leds[] = {
> +			{
> +				.name = "upboard:blue:",
> +				.gpio = APL_GPIO_218,
> +				.default_state = LEDS_GPIO_DEFSTATE_KEEP,
> +			},
> +		};
> +		static struct gpio_led_platform_data upboard_gpio_led_platform_data = {
> +			.num_leds = ARRAY_SIZE(upboard_gpio_leds),
> +			.leds = upboard_gpio_leds,
> +		};
> +		static const struct mfd_cell upboard_gpio_led_cells[] = {
> +			{
> +				.name = "leds-gpio",
> +				.id = 0,
> +				.platform_data = &upboard_gpio_led_platform_data,
> +				.pdata_size = sizeof(upboard_gpio_led_platform_data),
> +			},
> +		};

This is ugly and serves little purpose.

Place all of these structs with the others above.

> +		ret =  devm_mfd_add_devices(&pdev->dev, 0, upboard_gpio_led_cells,

Not '0'.  Please use the defines provided.

> +				    ARRAY_SIZE(upboard_gpio_led_cells), NULL, 0, NULL);
> +		if (ret) {
> +			dev_err(&pdev->dev, "Failed to add GPIO leds");
> +			return ret;
> +		}
> +

Superfluous line.

> +	}
> +
> +	return devm_mfd_add_devices(&pdev->dev, 0, fpga_data->cells,

As above.

> +				    fpga_data->ncells, NULL, 0, NULL);
> +}
> +
> +static struct platform_driver upboard_fpga_driver = {
> +	.driver = {
> +		.name = "upboard-fpga",
> +		.acpi_match_table = upboard_fpga_acpi_match,
> +	},
> +};
> +
> +module_platform_driver_probe(upboard_fpga_driver, upboard_fpga_probe);
> +
> +MODULE_AUTHOR("Javier Arteaga <javier@emutex.com>");
> +MODULE_DESCRIPTION("UP Board FPGA driver");
> +MODULE_LICENSE("GPL v2");
> diff --git a/include/linux/mfd/upboard-fpga.h b/include/linux/mfd/upboard-fpga.h
> new file mode 100644
> index 000000000000..e0940120514d
> --- /dev/null
> +++ b/include/linux/mfd/upboard-fpga.h
> @@ -0,0 +1,49 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * UP Board FPGA MFD driver interface

Please remove the term MFD.

> + * Copyright (c) 2017, Emutex Ltd. All rights reserved.
> + *
> + * Author: Javier Arteaga <javier@emutex.com>
> + */
> +
> +#ifndef __LINUX_MFD_UPBOARD_FPGA_H
> +#define __LINUX_MFD_UPBOARD_FPGA_H
> +
> +#define UPFPGA_ADDRESS_SIZE  7
> +#define UPFPGA_REGISTER_SIZE 16
> +
> +#define UPFPGA_READ_FLAG     (1 << UPFPGA_ADDRESS_SIZE)
> +
> +enum upboard_fpgareg {
> +	UPFPGA_REG_PLATFORM_ID   = 0x10,
> +	UPFPGA_REG_FIRMWARE_ID   = 0x11,
> +	UPFPGA_REG_FUNC_EN0      = 0x20,
> +	UPFPGA_REG_FUNC_EN1      = 0x21,
> +	UPFPGA_REG_GPIO_EN0      = 0x30,
> +	UPFPGA_REG_GPIO_EN1      = 0x31,
> +	UPFPGA_REG_GPIO_EN2      = 0x32,
> +	UPFPGA_REG_GPIO_DIR0     = 0x40,
> +	UPFPGA_REG_GPIO_DIR1     = 0x41,
> +	UPFPGA_REG_GPIO_DIR2     = 0x42,
> +	UPFPGA_REG_MAX,
> +};
> +
> +struct upboard_fpga {
> +	struct device *dev;
> +	struct regmap *regmap;
> +	struct gpio_desc *enable_gpio;
> +	struct gpio_desc *reset_gpio;
> +	struct gpio_desc *clear_gpio;
> +	struct gpio_desc *strobe_gpio;
> +	struct gpio_desc *datain_gpio;
> +	struct gpio_desc *dataout_gpio;
> +	bool uninitialised;
> +};
> +
> +struct upboard_led_data {
> +	unsigned int bit;
> +	const char *colour;
> +};
> +
> +#endif /*  __LINUX_MFD_UPBOARD_FPGA_H */

-- 
Lee Jones [李琼斯]
