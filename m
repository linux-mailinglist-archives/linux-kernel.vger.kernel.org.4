Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6427363673F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 18:31:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239130AbiKWRb0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 12:31:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239116AbiKWRbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 12:31:09 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61D988CF09;
        Wed, 23 Nov 2022 09:31:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669224668; x=1700760668;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9y/SMjCFDkeuOrin0QIRW260F2k/I5+MRvsD4FQ5dFQ=;
  b=i4DQy5YYWacvE3RHFuDkhhHWgU2htjKm6ptBQfezyPLsSy5Vb5XDkAMk
   vqsV7Gjf0+m8yVrPJ8H7qyjPA6jA8VkHlj3pa4DDJmypHQuCM2DeywdPM
   95/5Mv82m8VpzfjqnqsotkMaG/h63wm13N6HrEhodaAMQP4IAis2qNgUE
   AuAx3piIWlIjZme9zm70qejstBm6Udkp1wB9uaEqTHO5LOyiNoU9HDgj2
   8zcaawxPK+crqsoTv7bXh5qvb8FX9QntnXQGgTIVDYRHwDNHUMdraEfka
   AwazAhMl6K4TLYw2PCSTbqwXh3AoG6rjwiu8kYCqoOwjRzt3ytbEwnwb2
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="301682112"
X-IronPort-AV: E=Sophos;i="5.96,187,1665471600"; 
   d="scan'208";a="301682112"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2022 09:31:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="816554707"
X-IronPort-AV: E=Sophos;i="5.96,187,1665471600"; 
   d="scan'208";a="816554707"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP; 23 Nov 2022 09:31:06 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oxtaS-00GNp6-1Z;
        Wed, 23 Nov 2022 19:31:04 +0200
Date:   Wed, 23 Nov 2022 19:31:04 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        michael@walle.cc, broonie@kernel.org
Subject: Re: [PATCH v3 5/9] gpio: 104-idi-48: Migrate to gpio-regmap API
Message-ID: <Y35Y2BM8VoVQFZeJ@smile.fi.intel.com>
References: <cover.1669100542.git.william.gray@linaro.org>
 <5cf249405b0ac5f7408ec06cf7a65382a2ef5126.1669100542.git.william.gray@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5cf249405b0ac5f7408ec06cf7a65382a2ef5126.1669100542.git.william.gray@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2022 at 02:11:02AM -0500, William Breathitt Gray wrote:
> The regmap API supports IO port accessors so we can take advantage of
> regmap abstractions rather than handling access to the device registers
> directly in the driver. Despite the underlying interface being based on
> i8255, it is simpler to use the gpio-regmap API directly because the
> 104-IDI-48 device features only input signals. Therefore, the dependence
> on the i8255 GPIO library is removed in this patch.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

(One nit-pick below)

> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
> ---
>  drivers/gpio/Kconfig           |  2 +-
>  drivers/gpio/gpio-104-idi-48.c | 97 +++++++---------------------------
>  2 files changed, 21 insertions(+), 78 deletions(-)
> 
> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> index 6892979e511a..dd34039fc31b 100644
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -873,7 +873,7 @@ config GPIO_104_IDI_48
>  	select ISA_BUS_API
>  	select REGMAP_IRQ
>  	select GPIOLIB_IRQCHIP
> -	select GPIO_I8255
> +	select GPIO_REGMAP
>  	help
>  	  Enables GPIO support for the ACCES 104-IDI-48 family (104-IDI-48A,
>  	  104-IDI-48AC, 104-IDI-48B, 104-IDI-48BC). The base port addresses for
> diff --git a/drivers/gpio/gpio-104-idi-48.c b/drivers/gpio/gpio-104-idi-48.c
> index f77c05571062..2584f411ae67 100644
> --- a/drivers/gpio/gpio-104-idi-48.c
> +++ b/drivers/gpio/gpio-104-idi-48.c
> @@ -9,7 +9,7 @@
>  #include <linux/bits.h>
>  #include <linux/device.h>
>  #include <linux/err.h>
> -#include <linux/gpio/driver.h>
> +#include <linux/gpio/regmap.h>
>  #include <linux/interrupt.h>
>  #include <linux/ioport.h>
>  #include <linux/irq.h>
> @@ -20,10 +20,6 @@
>  #include <linux/regmap.h>
>  #include <linux/types.h>
>  
> -#include "gpio-i8255.h"
> -
> -MODULE_IMPORT_NS(I8255);
> -
>  #define IDI_48_EXTENT 8
>  #define MAX_NUM_IDI_48 max_num_isa_dev(IDI_48_EXTENT)
>  
> @@ -40,56 +36,17 @@ MODULE_PARM_DESC(irq, "ACCES 104-IDI-48 interrupt line numbers");
>  #define IDI48_IRQ_STATUS 0x7
>  #define IDI48_IRQ_ENABLE IDI48_IRQ_STATUS
>  
> -/**
> - * struct idi_48_reg - device register structure
> - * @port0:	Port 0 Inputs
> - * @unused:	Unused
> - * @port1:	Port 1 Inputs
> - * @irq:	Read: IRQ Status Register/IRQ Clear
> - *		Write: IRQ Enable/Disable
> - */
> -struct idi_48_reg {
> -	u8 port0[3];
> -	u8 unused;
> -	u8 port1[3];
> -	u8 irq;
> -};
> -
> -/**
> - * struct idi_48_gpio - GPIO device private data structure
> - * @chip:	instance of the gpio_chip
> - * @reg:	I/O address offset for the device registers
> - */
> -struct idi_48_gpio {
> -	struct gpio_chip chip;
> -	struct idi_48_reg __iomem *reg;
> -};
> -
> -static int idi_48_gpio_get_direction(struct gpio_chip *chip, unsigned int offset)
> -{
> -	return GPIO_LINE_DIRECTION_IN;
> -}
> -
> -static int idi_48_gpio_direction_input(struct gpio_chip *chip, unsigned int offset)
> -{
> -	return 0;
> -}
> -
> -static int idi_48_gpio_get(struct gpio_chip *chip, unsigned int offset)
> -{
> -	struct idi_48_gpio *const idi48gpio = gpiochip_get_data(chip);
> -	void __iomem *const ppi = idi48gpio->reg;
> -
> -	return i8255_get(ppi, offset);
> -}
> -
> -static int idi_48_gpio_get_multiple(struct gpio_chip *chip, unsigned long *mask,
> -	unsigned long *bits)
> +static int idi_48_reg_mask_xlate(struct gpio_regmap *gpio, unsigned int base,
> +				 unsigned int offset, unsigned int *reg,
> +				 unsigned int *mask)
>  {
> -	struct idi_48_gpio *const idi48gpio = gpiochip_get_data(chip);
> -	void __iomem *const ppi = idi48gpio->reg;
> +	const unsigned int line = offset % 8;
> +	const unsigned int stride = offset / 8;
> +	const unsigned int port = (stride / 3) * 4;
> +	const unsigned int port_stride = stride % 3;
>  
> -	i8255_get_multiple(ppi, mask, bits, chip->ngpio);
> +	*reg = base + port + port_stride;
> +	*mask = BIT(line);
>  
>  	return 0;
>  }
> @@ -166,18 +123,14 @@ static const char *idi48_names[IDI48_NGPIO] = {
>  
>  static int idi_48_probe(struct device *dev, unsigned int id)
>  {
> -	struct idi_48_gpio *idi48gpio;
>  	const char *const name = dev_name(dev);
> +	struct gpio_regmap_config config = {0};

{} will work in the same way.

>  	void __iomem *regs;
>  	struct regmap *map;
>  	struct regmap_irq_chip *chip;
>  	struct regmap_irq_chip_data *chip_data;
>  	int err;
>  
> -	idi48gpio = devm_kzalloc(dev, sizeof(*idi48gpio), GFP_KERNEL);
> -	if (!idi48gpio)
> -		return -ENOMEM;
> -
>  	if (!devm_request_region(dev, base[id], IDI_48_EXTENT, name)) {
>  		dev_err(dev, "Unable to lock port addresses (0x%X-0x%X)\n",
>  			base[id], base[id] + IDI_48_EXTENT);
> @@ -187,7 +140,6 @@ static int idi_48_probe(struct device *dev, unsigned int id)
>  	regs = devm_ioport_map(dev, base[id], IDI_48_EXTENT);
>  	if (!regs)
>  		return -ENOMEM;
> -	idi48gpio->reg = regs;
>  
>  	map = devm_regmap_init_mmio(dev, regs, &idi48_regmap_config);
>  	if (IS_ERR(map))
> @@ -212,25 +164,16 @@ static int idi_48_probe(struct device *dev, unsigned int id)
>  		return err;
>  	}
>  
> -	idi48gpio->chip.label = name;
> -	idi48gpio->chip.parent = dev;
> -	idi48gpio->chip.owner = THIS_MODULE;
> -	idi48gpio->chip.base = -1;
> -	idi48gpio->chip.ngpio = IDI48_NGPIO;
> -	idi48gpio->chip.names = idi48_names;
> -	idi48gpio->chip.get_direction = idi_48_gpio_get_direction;
> -	idi48gpio->chip.direction_input = idi_48_gpio_direction_input;
> -	idi48gpio->chip.get = idi_48_gpio_get;
> -	idi48gpio->chip.get_multiple = idi_48_gpio_get_multiple;
> -
> -	err = devm_gpiochip_add_data(dev, &idi48gpio->chip, idi48gpio);
> -	if (err) {
> -		dev_err(dev, "GPIO registering failed (%d)\n", err);
> -		return err;
> -	}
> +	config.parent = dev;
> +	config.regmap = map;
> +	config.ngpio = IDI48_NGPIO;
> +	config.names = idi48_names;
> +	config.reg_dat_base = GPIO_REGMAP_ADDR(0x0);
> +	config.ngpio_per_reg = 8;
> +	config.reg_mask_xlate = idi_48_reg_mask_xlate;
> +	config.irq_domain = regmap_irq_get_domain(chip_data);
>  
> -	return gpiochip_irqchip_add_domain(&idi48gpio->chip,
> -					   regmap_irq_get_domain(chip_data));
> +	return PTR_ERR_OR_ZERO(devm_gpio_regmap_register(dev, &config));
>  }
>  
>  static struct isa_driver idi_48_driver = {
> -- 
> 2.38.1
> 

-- 
With Best Regards,
Andy Shevchenko


