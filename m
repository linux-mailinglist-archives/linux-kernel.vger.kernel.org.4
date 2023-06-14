Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC6457267E6
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 20:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232105AbjFGSAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 14:00:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbjFGSAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 14:00:50 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4E7FEB;
        Wed,  7 Jun 2023 11:00:47 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-65299178ac5so7437639b3a.1;
        Wed, 07 Jun 2023 11:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686160847; x=1688752847;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EcKMov27uwVjVyly49MGTwG427GG+d6TEpG2hoha14o=;
        b=mpKnXh7tA4hSCCH6oq3hzMkX0oRe2q4I9XJZZQlrUsAmral1RB++f8ie2rTi8yZZ/a
         LB6AlRRgu3nM0Rn4/4uDBLg1JpUKfdsx99ADENOal0psiTFC3xr5yr/aKfFxPFgoNNnP
         YfI4p6Da0VxGIewIdcdprKB4Xramfuux3SoJB4yl6fMsp0PGDOJviuwOl4UiG8LguDBq
         Noy4IyJeiDfn2IZ+UGNY4SQCkFRN2dL+gIyqzh+0URbcBhgOpuJjjQxhA2fxXSRhM8Mk
         skyA+8WGKcS11myEAmsmCUf+aWxmust0BTL6GIgjEGWX7VKz4mYX3Yco46PkNu6xttSR
         KiHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686160847; x=1688752847;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EcKMov27uwVjVyly49MGTwG427GG+d6TEpG2hoha14o=;
        b=EObpBqHR21g7UDzdS6RTP1mfVjHu+CpVdVcaWHNutFNlFGibLXB76G77nR3utjDOP8
         ZPqs6t000gdfcEwq1eNreiWD01y0V8+Me/+GJkKqyRK07evihEhlJfe1TSCuFZ5xFt/i
         lYV1Lkyvha9XBxV4cD41hYEJD6v+RIBEYs6cNpBrR3B4RjWUg/nj9n/BnhUmPTCREL2d
         IJNtNErZ9qhNTPYh2Oz3HW26qZ4neh3ZEVc2bl996CdvyP+9BYVuakeS2LdghIuDmvnP
         qv9+s0y1xIbpmxvg7NkggaddxT5Qn14/VRUKQssbpD+SdkJF0oQWFjKwW51B+goVutMH
         1OlQ==
X-Gm-Message-State: AC+VfDx4tcVEo1+51FDom9j1y8SNSE2Ml4qyVR3/nqj7qBwJTCYJGsYg
        FZqWtFwb0mmFJ5/Bqf4vO1E=
X-Google-Smtp-Source: ACHHUZ77bsgrrHeUo7JYOp8lnxbFUNvnv972TswbHP9nn/2WzERJVfhbwLFxJm6eaurr4maECpkzGg==
X-Received: by 2002:a05:6a21:9986:b0:10b:e88f:5983 with SMTP id ve6-20020a056a21998600b0010be88f5983mr4178972pzb.43.1686160846698;
        Wed, 07 Jun 2023 11:00:46 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k185-20020a6324c2000000b00513cc8c9597sm9217892pgk.10.2023.06.07.11.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 11:00:46 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 7 Jun 2023 11:00:44 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Zev Weiss <zev@bewilderbeest.net>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org
Subject: Re: [PATCH 2/2] hwmon: (nct7362) Add nct7362 driver
Message-ID: <f927c9e4-8f75-4e1e-97f6-71b24bab1a9f@roeck-us.net>
References: <20230607101827.8544-4-zev@bewilderbeest.net>
 <20230607101827.8544-6-zev@bewilderbeest.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230607101827.8544-6-zev@bewilderbeest.net>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 07, 2023 at 03:18:30AM -0700, Zev Weiss wrote:
> This driver supports the Nuvoton NCT7362Y, an I2C fan controller with
> 16 channels independently configurable for operation as PWM outputs,
> fan tachometer inputs, or GPIOs.  Most aspects of the chip's

Is this a secret chip ?

> functionality are supported, including PWM duty cycle, frequency,
> enable/disable, and DC-mode operation.  To support its GPIO
> functionality, the driver also exposes a gpiochip interface if
> CONFIG_SENSORS_NCT7362_GPIO is enabled.

I do not see the point of this configuration flag. Why not just
always enable it ?

> 
> Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
> ---
>  MAINTAINERS             |   7 +
>  drivers/hwmon/Kconfig   |  18 ++
>  drivers/hwmon/Makefile  |   1 +
>  drivers/hwmon/nct7362.c | 697 ++++++++++++++++++++++++++++++++++++++++

Driver documentation is missing.

>  4 files changed, 723 insertions(+)
>  create mode 100644 drivers/hwmon/nct7362.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e0ad886d3163..7b2abff6d049 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14468,6 +14468,13 @@ S:	Maintained
>  F:	Documentation/devicetree/bindings/hwmon/nuvoton,nct6775.yaml
>  F:	drivers/hwmon/nct6775-i2c.c
>  
> +NCT7362 HARDWARE MONITOR DRIVER
> +M:	Zev Weiss <zev@bewilderbeest.net>
> +L:	linux-hwmon@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/hwmon/nuvoton,nct7362.yaml
> +F:	drivers/hwmon/nct7362.c
> +
>  NETDEVSIM
>  M:	Jakub Kicinski <kuba@kernel.org>
>  S:	Maintained
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index fc640201a2de..5ca51b4b52b6 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -1562,6 +1562,24 @@ config SENSORS_NCT6775_I2C
>  	  This driver can also be built as a module. If so, the module
>  	  will be called nct6775-i2c.
>  
> +config SENSORS_NCT7362
> +	tristate "Nuvoton NCT7362Y fan controller"
> +	depends on I2C
> +	select REGMAP_I2C
> +	help
> +	  If you say yes here you get support for the Nuvoton NCT7362Y
> +	  fan controller.
> +
> +	  This driver can also be built as a module. If so, the module
> +	  will be called nct7362.
> +
> +config SENSORS_NCT7362_GPIO
> +	bool "Enable NCT7362Y GPIO support"
> +	depends on SENSORS_NCT7362 && GPIOLIB

Why depends on GPIOLIB and not "select GPIOLIB" like everywhere else ?

> +	help
> +	  Allow nct7362 pins not used as PWM outputs or tach inputs to
> +	  be used as GPIOs.
> +
>  config SENSORS_NCT7802
>  	tristate "Nuvoton NCT7802Y"
>  	depends on I2C
> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> index cd8c568c80a9..29c674979280 100644
> --- a/drivers/hwmon/Makefile
> +++ b/drivers/hwmon/Makefile
> @@ -162,6 +162,7 @@ obj-$(CONFIG_SENSORS_NCT6775_CORE) += nct6775-core.o
>  nct6775-objs			:= nct6775-platform.o
>  obj-$(CONFIG_SENSORS_NCT6775)	+= nct6775.o
>  obj-$(CONFIG_SENSORS_NCT6775_I2C) += nct6775-i2c.o
> +obj-$(CONFIG_SENSORS_NCT7362)	+= nct7362.o
>  obj-$(CONFIG_SENSORS_NCT7802)	+= nct7802.o
>  obj-$(CONFIG_SENSORS_NCT7904)	+= nct7904.o
>  obj-$(CONFIG_SENSORS_NPCM7XX)	+= npcm750-pwm-fan.o
> diff --git a/drivers/hwmon/nct7362.c b/drivers/hwmon/nct7362.c
> new file mode 100644
> index 000000000000..8f8e49097710
> --- /dev/null
> +++ b/drivers/hwmon/nct7362.c
> @@ -0,0 +1,697 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * nct7362 - Driver for Nuvoton NCT7362Y fan controller
> + *
> + * Copyright (C) 2023 Zev Weiss <zev@bewilderbeest.net>
> + */
> +
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +#include <linux/of.h>
> +#include <linux/i2c.h>
> +#include <linux/regmap.h>
> +#include <linux/hwmon.h>
> +#include <linux/module.h>
> +#include <linux/gpio/driver.h>

Alphabetic order, please.

> +
> +#define DRVNAME "nct7362"
> +
> +#define REG_GPIO0_INPUT 0x00
> +#define REG_GPIO1_INPUT 0x10

Please always use

#define<space>DEFINE<tab>value

> +
> +#define REG_GPIO0_OUTPUT 0x01
> +#define REG_GPIO1_OUTPUT 0x11
> +
> +#define REG_GPIO0_IOCFG 0x03
> +#define REG_GPIO1_IOCFG 0x13
> +
> +#define REG_GPIO0_OUTMODE 0x05
> +#define REG_GPIO1_OUTMODE 0x15
> +
> +#define REG_PINCTRL_00 0x20
> +#define REG_PINCTRL_04 0x21
> +#define REG_PINCTRL_10 0x22
> +#define REG_PINCTRL_14 0x23
> +
> +#define REG_PWM_0_7_EN 0x38
> +#define REG_PWM_8_15_EN 0x39
> +
> +#define REG_TACH_GLOBAL_CTL 0x40
> +#define REG_TACH_0_7_EN 0x41
> +#define REG_TACH_8_15_EN 0x42
> +
> +#define REG_TACH_HVAL(n) (0x48 + (2 * (n)))
> +#define REG_TACH_LVAL(n) (0x49 + (2 * (n)))
> +
> +#define REG_FSCP_DUTY(n) (0x90 + (2 * (n)))
> +#define REG_FSCP_DIV(n) (0x91 + (2 * (n)))
> +#define REG_FSCP_CFG_BASE 0xb0
> +
> +/*
> + * For use in REG_PINCTRL_xx sub-fields.  ALERT (3) also exists for some pins,
> + * but is currently unsupported.
> + */
> +#define PIN_MODE_GPIO 0
> +#define PIN_MODE_PWM  1
> +#define PIN_MODE_TACH 2
> +
> +#define NUM_CHANNELS 16
> +
> +/* Default all PWM channels to 100% */
> +#define DEFAULT_PWM_DUTY 0xff
> +
> +/* Default all PWMs to 1/256 resolution, non-inverted, PWM mode (non-DC) */
> +#define DEFAULT_FSCP_CFG 0x44
> +
> +struct nct7362_data {
> +	struct i2c_client *client;
> +	struct regmap *regmap;
> +
> +	/*
> +	 * Bitmasks of which channels of which functions are enabled (offset by
> +	 * one so channel 1 is at bit 0).  Because the correspondence between
> +	 * pin numbers and tach channels differs from that of GPIO/PWM channels,
> +	 * some bit positions may be set in more than one of these (and some may
> +	 * be set in none).
> +	 */
> +	struct {
> +		u16 gpio;
> +		u16 pwm;
> +		u16 tach;
> +	} functions;
> +
> +	/* Pulses-per-revolution for each tach channel */
> +	u32 tach_ppr[NUM_CHANNELS];
> +
> +#ifdef CONFIG_SENSORS_NCT7362_GPIO
> +	/* In-use pins, either as PWM/tach or an actively-used GPIO */
> +	unsigned long active_pins;
> +
> +	struct gpio_chip gpio;
> +#endif
> +};
> +
> +#ifdef CONFIG_SENSORS_NCT7362_GPIO
> +static int nct7362_gpio_direction_input(struct gpio_chip *gpio, unsigned int offset)
> +{
> +	struct nct7362_data *chip = gpiochip_get_data(gpio);
> +	u8 iocfg = offset < 8 ? REG_GPIO0_IOCFG : REG_GPIO1_IOCFG;
> +	u8 bit = BIT(offset % 8);
> +
> +	return regmap_update_bits(chip->regmap, iocfg, bit, bit);
> +}
> +
> +static int nct7362_gpio_direction_output(struct gpio_chip *gpio, unsigned int offset, int val)
> +{
> +	int status;
> +	struct nct7362_data *chip = gpiochip_get_data(gpio);
> +	u8 outreg = offset < 8 ? REG_GPIO0_OUTPUT : REG_GPIO1_OUTPUT;
> +	u8 iocfg = offset < 8 ? REG_GPIO0_IOCFG : REG_GPIO1_IOCFG;
> +	u8 bit = BIT(offset % 8);
> +
> +	status = regmap_update_bits(chip->regmap, iocfg, bit, 0);
> +	if (status)
> +		return status;
> +
> +	return regmap_update_bits(chip->regmap, outreg, bit, val ? bit : 0);
> +}
> +
> +static int nct7362_gpio_get_value(struct gpio_chip *gpio, unsigned int offset)
> +{
> +	unsigned int inbits;
> +	struct nct7362_data *chip = gpiochip_get_data(gpio);
> +	u8 inreg = offset < 8 ? REG_GPIO0_INPUT : REG_GPIO1_INPUT;
> +	int status = regmap_read(chip->regmap, inreg, &inbits);
> +
> +	return status ? : !!(inbits & BIT(offset % 8));
> +}
> +
> +static void nct7362_gpio_set_value(struct gpio_chip *gpio, unsigned int offset, int value)
> +{
> +	struct nct7362_data *chip = gpiochip_get_data(gpio);
> +	u8 outreg = offset < 8 ? REG_GPIO0_OUTPUT : REG_GPIO1_OUTPUT;
> +	u8 bit = BIT(offset % 8);
> +	int status = regmap_update_bits(chip->regmap, outreg, bit, value ? bit : 0);
> +
> +	/* No other way to report failure */
> +	if (status)
> +		dev_dbg(&chip->client->dev, "regmap_update_bits() failed: %d\n", status);
> +}
> +
> +static int nct7362_gpio_request_pin(struct gpio_chip *gpio, unsigned int offset)
> +{
> +	struct nct7362_data *chip = gpiochip_get_data(gpio);
> +
> +	return test_and_set_bit(offset, &chip->active_pins) ? -EBUSY : 0;
> +}
> +
> +static void nct7362_gpio_free_pin(struct gpio_chip *gpio, unsigned int offset)
> +{
> +	struct nct7362_data *chip = gpiochip_get_data(gpio);
> +
> +	clear_bit(offset, &chip->active_pins);
> +}
> +
> +static int nct7362_gpio_set_config(struct gpio_chip *gpio, unsigned int offset,
> +				   unsigned long config)
> +{
> +	struct nct7362_data *chip = gpiochip_get_data(gpio);
> +	u8 modereg = offset < 8 ? REG_GPIO0_OUTMODE : REG_GPIO1_OUTMODE;
> +	u8 bit = BIT(offset % 8);
> +	int setting;
> +	enum pin_config_param param = pinconf_to_config_param(config);
> +
> +	switch (param) {
> +	case PIN_CONFIG_DRIVE_OPEN_DRAIN:
> +		setting = 0;
> +		break;
> +	case PIN_CONFIG_DRIVE_PUSH_PULL:
> +		setting = 1;
> +		break;
> +	default:
> +		dev_dbg(&chip->client->dev, "unsupported config param %d\n", param);
> +		return -ENOTSUPP;

checkpatch:

WARNING: ENOTSUPP is not a SUSV4 error code, prefer EOPNOTSUPP
#268: FILE: drivers/hwmon/nct7362.c:173:
+		return -ENOTSUPP;

> +	}
> +
> +	return regmap_update_bits(chip->regmap, modereg, bit, setting ? bit : 0);

Why not just set "setting" to "bit" directly and avoid the conditinal here ?

> +}
> +#endif
> +
> +/* Convert a pin number to a PWM channel number */
> +static inline int pin_to_pwm(int pin)
> +{
> +	return pin < 9 ? (pin - 1) : (pin - 2);
> +}
> +
> +#ifdef CONFIG_SENSORS_NCT7362_GPIO
> +/*
> + * Convert a pin number to a GPIO number -- interpreting the numbers in the
> + * datasheet as octal, these are the same as the (decimal) PWM numbers.
> + */
> +static inline int pin_to_gpio(int pin)
> +{
> +	return pin_to_pwm(pin);
> +}
> +
> +/* GPIO that shares the same pin as the given PWM */
> +static inline int pwm_to_gpio(int pwm)
> +{
> +	/* GPIO & PWM numbering are the same */
> +	return pwm;
> +}
> +
> +/* GPIO that shares the same pin as the given tach */
> +static inline int tach_to_gpio(int tach)
> +{
> +	int pin = tach < 8 ? (tach + 10) : (tach - 7);
> +
> +	return pin_to_gpio(pin);
> +}
> +#endif
> +
> +/* Convert a pin number to a tach (FANIN) channel number */
> +static inline int pin_to_tach(int pin)
> +{
> +	return pin < 9 ? (pin + 7) : (pin - 10);
> +}
> +
> +static int nct7362_init_pin_functions(struct nct7362_data *chip)
> +{
> +	int channel, reg, status;
> +	u16 *mask;
> +	u8 function;
> +	struct device_node *child;
> +	u8 pinctrl[] = { 0, 0, 0, 0, };
> +	struct device *dev = &chip->client->dev;
> +
> +	for_each_available_child_of_node(dev->of_node, child) {
> +		int pwmnum, pinctrl_idx, pinctrl_shift;
> +		u32 pin;
> +
> +		if (of_property_read_u32(child, "reg", &pin)) {
> +			dev_warn(dev, "skipping %pOF due to missing 'reg' property\n", child);
> +			continue;

This should abort with an error.

> +		}
> +
> +		if (pin == 0 || pin == 9 || pin > 17) {
> +			dev_warn(dev, "skipping %pOF with invalid pin number %u\n", child, pin);
> +			continue;

Same here.

> +		}
> +
> +		pwmnum = pin_to_pwm(pin);
> +		pinctrl_idx = pwmnum / 4;
> +		pinctrl_shift = 2 * (pwmnum % 4);
> +
> +		if (of_node_name_prefix(child, "pwm")) {
> +			function = PIN_MODE_PWM;
> +			channel = pin_to_pwm(pin);
> +			mask = &chip->functions.pwm;
> +		} else if (of_node_name_prefix(child, "tach")) {
> +			function = PIN_MODE_TACH;
> +			channel = pin_to_tach(pin);
> +			mask = &chip->functions.tach;
> +			if (of_property_read_u32(child, "nuvoton,pulses-per-revolution",
> +						 &chip->tach_ppr[channel]))
> +				chip->tach_ppr[channel] = 2;
> +#ifdef CONFIG_SENSORS_NCT7362_GPIO
> +		} else if (of_node_name_prefix(child, "gpio")) {
> +			function = PIN_MODE_GPIO;
> +			channel = pin_to_gpio(pin);
> +			mask = &chip->functions.gpio;
> +#endif
> +		} else {
> +			dev_warn(dev, "skipping %pOF of unknown function\n", child);

and here.

> +			continue;
> +		}
> +
> +		*mask |= BIT(channel);
> +
> +		pinctrl[pinctrl_idx] |= function << pinctrl_shift;
> +	}
> +
> +	for (reg = 0; reg < 4; reg++) {
> +		status = regmap_write(chip->regmap, REG_PINCTRL_00 + reg, pinctrl[reg]);
> +		if (status)
> +			return status;
> +	}
> +
> +	return 0;
> +}
> +
> +static int nct7362_init_pwm(struct nct7362_data *chip)
> +{
> +	int ret;
> +
> +	for (int i = 0; i < 8; i++) {
> +		ret = regmap_write(chip->regmap, REG_FSCP_CFG_BASE + i, DEFAULT_FSCP_CFG);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	for (int i = 0; i < NUM_CHANNELS; i++) {
> +		ret = regmap_write(chip->regmap, REG_FSCP_DUTY(i), DEFAULT_PWM_DUTY);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	for (int i = 0; i < 2; i++) {
> +		ret = regmap_write(chip->regmap, REG_PWM_0_7_EN + i, 0xff);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int nct7362_init_fan(struct nct7362_data *chip)
> +{
> +	int ret;
> +
> +	/*
> +	 * tach_ppr *should* be set for all configured tach channels by this
> +	 * point, but to ensure we don't end up dividing by zero let's make sure.
> +	 */
> +	for (int i = 0; i < 16; i++) {
> +		if (!chip->tach_ppr[i])
> +			chip->tach_ppr[i] = 2;
> +	}
> +
> +	/* Enable individual fan tachs */
> +	for (int i = 0; i < 2; i++) {
> +		ret = regmap_write(chip->regmap, REG_TACH_0_7_EN + i, 0xff);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	/* Ensure global fan tach enable is on */
> +	return regmap_update_bits(chip->regmap, REG_TACH_GLOBAL_CTL, 0x80, 0x80);
> +}
> +
> +static int nct7362_init_gpio(struct nct7362_data *chip)
> +{
> +#ifdef CONFIG_SENSORS_NCT7362_GPIO
> +	struct gpio_chip *gpio = &chip->gpio;
> +
> +	for (int i = 0; i < 16; i++) {
> +		/* Pins in use as PWM or tach are permanently active */
> +		if (chip->functions.pwm & BIT(i))
> +			set_bit(pwm_to_gpio(i), &chip->active_pins);
> +		if (chip->functions.tach & BIT(i))
> +			set_bit(tach_to_gpio(i), &chip->active_pins);
> +	}
> +
> +	gpio->label = dev_name(&chip->client->dev);
> +	gpio->direction_input = nct7362_gpio_direction_input;
> +	gpio->direction_output = nct7362_gpio_direction_output;
> +	gpio->get = nct7362_gpio_get_value;
> +	gpio->set = nct7362_gpio_set_value;
> +	gpio->request = nct7362_gpio_request_pin;
> +	gpio->free = nct7362_gpio_free_pin;
> +	gpio->set_config = nct7362_gpio_set_config;
> +	gpio->can_sleep = 1;
> +	gpio->base = -1;
> +	gpio->ngpio = NUM_CHANNELS;
> +	gpio->parent = &chip->client->dev;
> +	gpio->owner = THIS_MODULE;
> +
> +	return devm_gpiochip_add_data(&chip->client->dev, gpio, chip);
> +#else
> +	return 0;
> +#endif
> +}
> +
> +static umode_t nct7362_is_visible(const void *data, enum hwmon_sensor_types type,
> +				  u32 attr, int channel)
> +{
> +	umode_t mode = 0;
> +	const struct nct7362_data *chip = data;
> +

Please try to declare variables in reverse christmas tree order where
possible to improve readability.

> +	switch (type) {
> +	case hwmon_pwm:
> +		if (!(chip->functions.pwm & BIT(channel)))
> +			break;
> +		switch (attr) {
> +		case hwmon_pwm_enable:
> +		case hwmon_pwm_input:
> +		case hwmon_pwm_freq:
> +		case hwmon_pwm_mode:
> +			mode = 0644;
> +			break;
> +		default:
> +			break;
> +		}
> +		break;
> +	case hwmon_fan:
> +		if (!(chip->functions.tach & BIT(channel)))
> +			break;
> +		switch (attr) {
> +		case hwmon_fan_input:
> +			mode = 0444;
> +			break;
> +		default:
> +			break;
> +		}
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	return mode;
> +}
> +
> +/*
> + * We set STEP to 1 on all PWM channels during initialization (for
> + * higher-resolution duty cycle control) and never change it, so our frequency
> + * calculations all assume it's set to 1 rather than re-reading the register all
> + * the time.
> + *
> + * Supported frequency ranges:
> + *  DIVSEL=0: 488Hz - 62.5KHz
> + *  DIVSEL=1: 2Hz - 244Hz
> + */
> +#define PWM_STEP 1
> +#define BASE_FANCLK 16000000
> +#define PWM_FREQ_MIN_DIVSEL0 (BASE_FANCLK / 32768) /* 488 */
> +#define PWM_FREQ_MAX_DIVSEL1 (BASE_FANCLK / 65536) /* 244 */
> +
> +/* Frequency threshold below which we switch to DIVSEL=1 */
> +#define PWM_DIVSEL_CUTOFF ((PWM_FREQ_MIN_DIVSEL0 + PWM_FREQ_MAX_DIVSEL1) / 2)
> +
> +static long nct7362_pwm_freq(long divisor, bool divsel)
> +{
> +	long denom = (divisor + 1) << (7 + PWM_STEP + (divsel ? 8 : 0));
> +
> +	return BASE_FANCLK / denom;
> +}
> +
> +static int nct7362_read_pwm(struct nct7362_data *chip, u32 attr, int channel, long *val)
> +{
> +	u8 reg;
> +	int status;
> +	unsigned int tmp;
> +
> +	if (!(chip->functions.pwm & BIT(channel)))
> +		return -EBUSY;

Why is this needed ? If the bit is configured as gpio the pwm channel
should not be available.

> +
> +	switch (attr) {
> +	case hwmon_pwm_enable:
> +		reg = channel < 8 ? REG_PWM_0_7_EN : REG_PWM_8_15_EN;
> +		status = regmap_read(chip->regmap, reg, &tmp);
> +		if (!status)
> +			*val = !!(tmp & BIT(channel % 8));

Please consistently use
		if (status)
			return status;
		*val = ...

> +		break;
> +
> +	case hwmon_pwm_freq:
> +		reg = REG_FSCP_DIV(channel);
> +		status = regmap_read(chip->regmap, reg, &tmp);
> +		if (status)
> +			return status;
> +
> +		*val = nct7362_pwm_freq(tmp & 0x7f, !!(tmp & 0x80));
> +		break;
> +
> +	case hwmon_pwm_input:
> +		reg = REG_FSCP_DUTY(channel);
> +		status = regmap_read(chip->regmap, reg, &tmp);
> +		if (!status)
> +			*val = tmp;
> +		break;
> +
> +	case hwmon_pwm_mode:
> +		reg = REG_FSCP_CFG_BASE + (channel / 2);
> +		status = regmap_read(chip->regmap, reg, &tmp);
> +		if (!status)
> +			*val = !(tmp & BIT(4 * (channel % 2)));
> +		break;
> +
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +
> +	return status;
> +}
> +
> +static int nct7362_write_pwm(struct nct7362_data *chip, u32 attr, int channel, long val)
> +{
> +	u8 reg, bit, divsel;
> +	long divisor;
> +	int status;
> +
> +	if (!(chip->functions.pwm & BIT(channel)))
> +		return -EBUSY;

Same question as above.

> +
> +	switch (attr) {
> +	case hwmon_pwm_input:
> +		reg = REG_FSCP_DUTY(channel);
> +		status = regmap_write(chip->regmap, reg, val);
> +		break;
> +
> +	case hwmon_pwm_enable:
> +		reg = channel < 8 ? REG_PWM_0_7_EN : REG_PWM_8_15_EN;
> +		bit = BIT(channel % 8);
> +		status = regmap_update_bits(chip->regmap, reg, bit, val ? bit : 0);

This (and other functions below) should not accept random values.

> +		break;
> +
> +	case hwmon_pwm_mode:
> +		reg = REG_FSCP_CFG_BASE + (channel / 2);
> +		bit = BIT(4 * (channel % 2));
> +		status = regmap_update_bits(chip->regmap, reg, bit, val ? 0 : bit);
> +		break;
> +
> +	case hwmon_pwm_freq:
> +		divsel = val < PWM_DIVSEL_CUTOFF;
> +
> +		divisor = BASE_FANCLK / (val << (7 + PWM_STEP + (divsel ? 8 : 0))) - 1;
> +		divisor = clamp(divisor, 0L, 0x7fL);
> +		divisor |= divsel << 7;
> +
> +		reg = REG_FSCP_DIV(channel);
> +		status = regmap_write(chip->regmap, reg, divisor);
> +		break;
> +
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +
> +	return status;
> +}
> +
> +static int nct7362_read_fan_speed(struct nct7362_data *chip, int channel, long *val)
> +{
> +	unsigned int hi, lo, count;
> +	int status;
> +
> +	status = regmap_read(chip->regmap, REG_TACH_HVAL(channel), &hi);
> +	if (status)
> +		return status;
> +
> +	status = regmap_read(chip->regmap, REG_TACH_LVAL(channel), &lo);
> +	if (status)
> +		return status;
> +
> +	count = (hi << 5) | (lo & 0x1f);
> +

The problem with this approach is that hval could change after it was read.
The datasheet is not public, so there is no means for me to verify if the
chip prevents this from happening. Please add a comment explaining why this
can not result in bogus readings.

> +	*val = 1350000 / (count * chip->tach_ppr[channel] / 2);
> +
> +	return 0;
> +}
> +
> +static int nct7362_read_tach(struct nct7362_data *chip, u32 attr, int channel, long *val)
> +{
> +	if (!(chip->functions.tach & BIT(channel)))
> +		return -EBUSY;
> +

Same question as above.

> +	switch (attr) {
> +	case hwmon_fan_input:
> +		return nct7362_read_fan_speed(chip, channel, val);
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
> +static int nct7362_read(struct device *dev, enum hwmon_sensor_types type,
> +			u32 attr, int channel, long *val)
> +{
> +	struct nct7362_data *chip = dev_get_drvdata(dev);
> +
> +	switch (type) {
> +	case hwmon_pwm:
> +		return nct7362_read_pwm(chip, attr, channel, val);
> +	case hwmon_fan:
> +		return nct7362_read_tach(chip, attr, channel, val);
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
> +static int nct7362_write(struct device *dev, enum hwmon_sensor_types type,
> +			 u32 attr, int channel, long val)
> +{
> +	struct nct7362_data *chip = dev_get_drvdata(dev);
> +
> +	switch (type) {
> +	case hwmon_pwm:
> +		return nct7362_write_pwm(chip, attr, channel, val);
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
> +static const struct hwmon_ops nct7362_hwmon_ops = {
> +	.is_visible = nct7362_is_visible,
> +	.read = nct7362_read,
> +	.write = nct7362_write,
> +};
> +
> +static const struct hwmon_channel_info *nct7362_info[] = {
> +	HWMON_CHANNEL_INFO(fan,
> +			   HWMON_F_INPUT,
> +			   HWMON_F_INPUT,
> +			   HWMON_F_INPUT,
> +			   HWMON_F_INPUT,
> +			   HWMON_F_INPUT,
> +			   HWMON_F_INPUT,
> +			   HWMON_F_INPUT,
> +			   HWMON_F_INPUT,
> +			   HWMON_F_INPUT,
> +			   HWMON_F_INPUT,
> +			   HWMON_F_INPUT,
> +			   HWMON_F_INPUT,
> +			   HWMON_F_INPUT,
> +			   HWMON_F_INPUT,
> +			   HWMON_F_INPUT,
> +			   HWMON_F_INPUT),
> +	HWMON_CHANNEL_INFO(pwm,
> +			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE | HWMON_PWM_FREQ | HWMON_PWM_MODE,
> +			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE | HWMON_PWM_FREQ | HWMON_PWM_MODE,
> +			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE | HWMON_PWM_FREQ | HWMON_PWM_MODE,
> +			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE | HWMON_PWM_FREQ | HWMON_PWM_MODE,
> +			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE | HWMON_PWM_FREQ | HWMON_PWM_MODE,
> +			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE | HWMON_PWM_FREQ | HWMON_PWM_MODE,
> +			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE | HWMON_PWM_FREQ | HWMON_PWM_MODE,
> +			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE | HWMON_PWM_FREQ | HWMON_PWM_MODE,
> +			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE | HWMON_PWM_FREQ | HWMON_PWM_MODE,
> +			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE | HWMON_PWM_FREQ | HWMON_PWM_MODE,
> +			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE | HWMON_PWM_FREQ | HWMON_PWM_MODE,
> +			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE | HWMON_PWM_FREQ | HWMON_PWM_MODE,
> +			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE | HWMON_PWM_FREQ | HWMON_PWM_MODE,
> +			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE | HWMON_PWM_FREQ | HWMON_PWM_MODE,
> +			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE | HWMON_PWM_FREQ | HWMON_PWM_MODE,
> +			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE | HWMON_PWM_FREQ | HWMON_PWM_MODE),
> +	NULL,
> +};
> +
> +static const struct hwmon_chip_info nct7362_chip_info = {
> +	.ops = &nct7362_hwmon_ops,
> +	.info = nct7362_info,
> +};
> +
> +static const struct regmap_config nct7362_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +};
> +
> +static int nct7362_probe(struct i2c_client *client)
> +{
> +	struct device *hwmon_dev;
> +	struct device *dev = &client->dev;
> +	struct nct7362_data *chip;
> +	int ret;
> +
> +	chip = devm_kzalloc(dev, sizeof(*chip), GFP_KERNEL);
> +	if (!chip)
> +		return -ENOMEM;
> +
> +	chip->client = client;
> +	chip->regmap = devm_regmap_init_i2c(client, &nct7362_regmap_config);
> +	if (IS_ERR(chip->regmap))
> +		return PTR_ERR(chip->regmap);
> +
> +	ret = nct7362_init_pin_functions(chip);
> +	if (ret)
> +		return ret;
> +
> +	ret = nct7362_init_pwm(chip);
> +	if (ret)
> +		return ret;
> +
> +	ret = nct7362_init_fan(chip);
> +	if (ret)
> +		return ret;
> +
> +	ret = nct7362_init_gpio(chip);
> +	if (ret)
> +		return ret;
> +
> +	hwmon_dev = devm_hwmon_device_register_with_info(dev, client->name, chip,
> +							 &nct7362_chip_info, NULL);
> +	return PTR_ERR_OR_ZERO(hwmon_dev);
> +}
> +
> +static const struct i2c_device_id nct7362_idtable[] = {
> +	{ "nct7362", },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, nct7362_idtable);
> +
> +static const struct of_device_id __maybe_unused nct7362_of_match[] = {
> +	{ .compatible = "nuvoton,nct7362", },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, nct7362_of_match);
> +
> +static struct i2c_driver nct7362_driver = {
> +	.class = I2C_CLASS_HWMON,
> +	.driver = {
> +		.name = DRVNAME,
> +		.of_match_table = of_match_ptr(nct7362_of_match),
> +	},
> +	.probe_new = nct7362_probe,
> +	.id_table = nct7362_idtable,
> +};
> +
> +module_i2c_driver(nct7362_driver);
> +
> +MODULE_AUTHOR("Zev Weiss <zev@bewilderbeest.net>");
> +MODULE_DESCRIPTION("NCT7362Y fan controller driver");
> +MODULE_LICENSE("GPL");
> -- 
> 2.40.0.5.gf6e3b97ba6d2.dirty
> 
