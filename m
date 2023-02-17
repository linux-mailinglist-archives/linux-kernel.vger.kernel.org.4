Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4B0469B2D3
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 20:04:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbjBQTEx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 14:04:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjBQTEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 14:04:51 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEF8A6243E;
        Fri, 17 Feb 2023 11:04:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676660689; x=1708196689;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kmeeG1T8y7jo24RxWK0OXpyrUdfwndWiiCRrTK67ryE=;
  b=SRBmMFmpepf2braFHtQCgDpwUaEeejgdknNYNK6dLgBrx1qiLk8zT0ih
   zrXlxfWn2sGJU4n0U/s+vTnEgu46GZQN/Btkv9W8+UAm1K8Yh1jbjWcjW
   BBLAAYUIj8iRke+bxUgPtOsktNBbj8wLNpW5Q0aDkW2/fjZVrb4fKTu0Q
   O/Acs/VREL5Pr0+wS726Jp5plpkwgWNYzWCxZyVWH9d+cb9Cv+hYMR38d
   NgGkJX+iJQ0Ed8Y7GgajyESyIqTVVu5GyfQRIsraXdK7LR81wgQGIrNCL
   ml5Ypfmi/+KBVYGITNZLwbTWsUEDS2SKKAoc+iXp883SXj6AlBWIv3TzL
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10624"; a="396742931"
X-IronPort-AV: E=Sophos;i="5.97,306,1669104000"; 
   d="scan'208";a="396742931"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2023 11:04:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10624"; a="999546927"
X-IronPort-AV: E=Sophos;i="5.97,306,1669104000"; 
   d="scan'208";a="999546927"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP; 17 Feb 2023 11:04:35 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pT625-008KXS-32;
        Fri, 17 Feb 2023 21:04:33 +0200
Date:   Fri, 17 Feb 2023 21:04:33 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl, broonie@kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] gpio: pci-idio-16: Migrate to the regmap API
Message-ID: <Y+/PwYe3pvtausbe@smile.fi.intel.com>
References: <cover.1675876659.git.william.gray@linaro.org>
 <1bac3155e366fc7da7dbb48f54ab96d4a9649e57.1675876659.git.william.gray@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1bac3155e366fc7da7dbb48f54ab96d4a9649e57.1675876659.git.william.gray@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08, 2023 at 12:18:20PM -0500, William Breathitt Gray wrote:
> The regmap API supports MMIO accessors so we can take advantage of
> regmap abstractions rather than handling access to the device registers
> directly in the driver. Migrate the pci-idio-16 module to the new
> idio-16 library interface leveraging the gpio-regmap API.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Don't you need to allow PIO accessors in the regmap configuration?

> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
> ---
>  drivers/gpio/Kconfig            |   2 +-
>  drivers/gpio/gpio-pci-idio-16.c | 295 ++++++++------------------------
>  2 files changed, 69 insertions(+), 228 deletions(-)
> 
> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> index 8eb1f21c019e..e57744df2160 100644
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -1571,7 +1571,7 @@ config GPIO_PCH
>  
>  config GPIO_PCI_IDIO_16
>  	tristate "ACCES PCI-IDIO-16 GPIO support"
> -	select GPIOLIB_IRQCHIP
> +	select REGMAP_MMIO
>  	select GPIO_IDIO_16
>  	help
>  	  Enables GPIO support for the ACCES PCI-IDIO-16. An interrupt is
> diff --git a/drivers/gpio/gpio-pci-idio-16.c b/drivers/gpio/gpio-pci-idio-16.c
> index a86ce748384b..8ee5787ee1ac 100644
> --- a/drivers/gpio/gpio-pci-idio-16.c
> +++ b/drivers/gpio/gpio-pci-idio-16.c
> @@ -5,208 +5,81 @@
>   */
>  #include <linux/bits.h>
>  #include <linux/device.h>
> -#include <linux/errno.h>
> -#include <linux/gpio/driver.h>
> -#include <linux/interrupt.h>
> -#include <linux/irqdesc.h>
> +#include <linux/err.h>
> +#include <linux/irq.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/pci.h>
> -#include <linux/spinlock.h>
> +#include <linux/regmap.h>
>  #include <linux/types.h>
>  
>  #include "gpio-idio-16.h"
>  
> -/**
> - * struct idio_16_gpio - GPIO device private data structure
> - * @chip:	instance of the gpio_chip
> - * @lock:	synchronization lock to prevent I/O race conditions
> - * @reg:	I/O address offset for the GPIO device registers
> - * @state:	ACCES IDIO-16 device state
> - * @irq_mask:	I/O bits affected by interrupts
> - */
> -struct idio_16_gpio {
> -	struct gpio_chip chip;
> -	raw_spinlock_t lock;
> -	struct idio_16 __iomem *reg;
> -	struct idio_16_state state;
> -	unsigned long irq_mask;
> +static const struct regmap_range idio_16_wr_ranges[] = {
> +	regmap_reg_range(0x0, 0x2), regmap_reg_range(0x3, 0x4),
>  };
> -
> -static int idio_16_gpio_get_direction(struct gpio_chip *chip,
> -	unsigned int offset)
> -{
> -	if (idio_16_get_direction(offset))
> -		return GPIO_LINE_DIRECTION_IN;
> -
> -	return GPIO_LINE_DIRECTION_OUT;
> -}
> -
> -static int idio_16_gpio_direction_input(struct gpio_chip *chip,
> -	unsigned int offset)
> -{
> -	return 0;
> -}
> -
> -static int idio_16_gpio_direction_output(struct gpio_chip *chip,
> -	unsigned int offset, int value)
> -{
> -	chip->set(chip, offset, value);
> -	return 0;
> -}
> -
> -static int idio_16_gpio_get(struct gpio_chip *chip, unsigned int offset)
> -{
> -	struct idio_16_gpio *const idio16gpio = gpiochip_get_data(chip);
> -
> -	return idio_16_get(idio16gpio->reg, &idio16gpio->state, offset);
> -}
> -
> -static int idio_16_gpio_get_multiple(struct gpio_chip *chip,
> -	unsigned long *mask, unsigned long *bits)
> -{
> -	struct idio_16_gpio *const idio16gpio = gpiochip_get_data(chip);
> -
> -	idio_16_get_multiple(idio16gpio->reg, &idio16gpio->state, mask, bits);
> -	return 0;
> -}
> -
> -static void idio_16_gpio_set(struct gpio_chip *chip, unsigned int offset,
> -	int value)
> -{
> -	struct idio_16_gpio *const idio16gpio = gpiochip_get_data(chip);
> -
> -	idio_16_set(idio16gpio->reg, &idio16gpio->state, offset, value);
> -}
> -
> -static void idio_16_gpio_set_multiple(struct gpio_chip *chip,
> -	unsigned long *mask, unsigned long *bits)
> -{
> -	struct idio_16_gpio *const idio16gpio = gpiochip_get_data(chip);
> -
> -	idio_16_set_multiple(idio16gpio->reg, &idio16gpio->state, mask, bits);
> -}
> -
> -static void idio_16_irq_ack(struct irq_data *data)
> -{
> -}
> -
> -static void idio_16_irq_mask(struct irq_data *data)
> -{
> -	struct gpio_chip *chip = irq_data_get_irq_chip_data(data);
> -	struct idio_16_gpio *const idio16gpio = gpiochip_get_data(chip);
> -	const unsigned long mask = BIT(irqd_to_hwirq(data));
> -	unsigned long flags;
> -
> -	idio16gpio->irq_mask &= ~mask;
> -
> -	if (!idio16gpio->irq_mask) {
> -		raw_spin_lock_irqsave(&idio16gpio->lock, flags);
> -
> -		iowrite8(0, &idio16gpio->reg->irq_ctl);
> -
> -		raw_spin_unlock_irqrestore(&idio16gpio->lock, flags);
> -	}
> -}
> -
> -static void idio_16_irq_unmask(struct irq_data *data)
> -{
> -	struct gpio_chip *chip = irq_data_get_irq_chip_data(data);
> -	struct idio_16_gpio *const idio16gpio = gpiochip_get_data(chip);
> -	const unsigned long mask = BIT(irqd_to_hwirq(data));
> -	const unsigned long prev_irq_mask = idio16gpio->irq_mask;
> -	unsigned long flags;
> -
> -	idio16gpio->irq_mask |= mask;
> -
> -	if (!prev_irq_mask) {
> -		raw_spin_lock_irqsave(&idio16gpio->lock, flags);
> -
> -		ioread8(&idio16gpio->reg->irq_ctl);
> -
> -		raw_spin_unlock_irqrestore(&idio16gpio->lock, flags);
> -	}
> -}
> -
> -static int idio_16_irq_set_type(struct irq_data *data, unsigned int flow_type)
> -{
> -	/* The only valid irq types are none and both-edges */
> -	if (flow_type != IRQ_TYPE_NONE &&
> -		(flow_type & IRQ_TYPE_EDGE_BOTH) != IRQ_TYPE_EDGE_BOTH)
> -		return -EINVAL;
> -
> -	return 0;
> -}
> -
> -static struct irq_chip idio_16_irqchip = {
> -	.name = "pci-idio-16",
> -	.irq_ack = idio_16_irq_ack,
> -	.irq_mask = idio_16_irq_mask,
> -	.irq_unmask = idio_16_irq_unmask,
> -	.irq_set_type = idio_16_irq_set_type
> +static const struct regmap_range idio_16_rd_ranges[] = {
> +	regmap_reg_range(0x1, 0x2), regmap_reg_range(0x5, 0x6),
>  };
> -
> -static irqreturn_t idio_16_irq_handler(int irq, void *dev_id)
> -{
> -	struct idio_16_gpio *const idio16gpio = dev_id;
> -	unsigned int irq_status;
> -	struct gpio_chip *const chip = &idio16gpio->chip;
> -	int gpio;
> -
> -	raw_spin_lock(&idio16gpio->lock);
> -
> -	irq_status = ioread8(&idio16gpio->reg->irq_status);
> -
> -	raw_spin_unlock(&idio16gpio->lock);
> -
> -	/* Make sure our device generated IRQ */
> -	if (!(irq_status & 0x3) || !(irq_status & 0x4))
> -		return IRQ_NONE;
> -
> -	for_each_set_bit(gpio, &idio16gpio->irq_mask, chip->ngpio)
> -		generic_handle_domain_irq(chip->irq.domain, gpio);
> -
> -	raw_spin_lock(&idio16gpio->lock);
> -
> -	/* Clear interrupt */
> -	iowrite8(0, &idio16gpio->reg->in0_7);
> -
> -	raw_spin_unlock(&idio16gpio->lock);
> -
> -	return IRQ_HANDLED;
> -}
> -
> -#define IDIO_16_NGPIO 32
> -static const char *idio_16_names[IDIO_16_NGPIO] = {
> -	"OUT0", "OUT1", "OUT2", "OUT3", "OUT4", "OUT5", "OUT6", "OUT7",
> -	"OUT8", "OUT9", "OUT10", "OUT11", "OUT12", "OUT13", "OUT14", "OUT15",
> -	"IIN0", "IIN1", "IIN2", "IIN3", "IIN4", "IIN5", "IIN6", "IIN7",
> -	"IIN8", "IIN9", "IIN10", "IIN11", "IIN12", "IIN13", "IIN14", "IIN15"
> +static const struct regmap_range idio_16_volatile_ranges[] = {
> +	regmap_reg_range(0x1, 0x2), regmap_reg_range(0x5, 0x6),
> +};
> +static const struct regmap_range idio_16_precious_ranges[] = {
> +	regmap_reg_range(0x2, 0x2),
> +};
> +static const struct regmap_access_table idio_16_wr_table = {
> +	.yes_ranges = idio_16_wr_ranges,
> +	.n_yes_ranges = ARRAY_SIZE(idio_16_wr_ranges),
> +};
> +static const struct regmap_access_table idio_16_rd_table = {
> +	.yes_ranges = idio_16_rd_ranges,
> +	.n_yes_ranges = ARRAY_SIZE(idio_16_rd_ranges),
> +};
> +static const struct regmap_access_table idio_16_volatile_table = {
> +	.yes_ranges = idio_16_volatile_ranges,
> +	.n_yes_ranges = ARRAY_SIZE(idio_16_volatile_ranges),
> +};
> +static const struct regmap_access_table idio_16_precious_table = {
> +	.yes_ranges = idio_16_precious_ranges,
> +	.n_yes_ranges = ARRAY_SIZE(idio_16_precious_ranges),
> +};
> +static const struct regmap_config idio_16_regmap_config = {
> +	.reg_bits = 8,
> +	.reg_stride = 1,
> +	.val_bits = 8,
> +	.max_register = 0x6,
> +	.wr_table = &idio_16_wr_table,
> +	.rd_table = &idio_16_rd_table,
> +	.volatile_table = &idio_16_volatile_table,
> +	.precious_table = &idio_16_precious_table,
> +	.cache_type = REGCACHE_FLAT,
>  };
>  
> -static int idio_16_irq_init_hw(struct gpio_chip *gc)
> -{
> -	struct idio_16_gpio *const idio16gpio = gpiochip_get_data(gc);
> -
> -	/* Disable IRQ by default and clear any pending interrupt */
> -	iowrite8(0, &idio16gpio->reg->irq_ctl);
> -	iowrite8(0, &idio16gpio->reg->in0_7);
> +/* Only input lines (GPIO 16-31) support interrupts */
> +#define IDIO_16_REGMAP_IRQ(_id)						\
> +	[16 + _id] = {							\
> +		.mask = BIT(2),						\
> +		.type = { .types_supported = IRQ_TYPE_EDGE_BOTH },	\
> +	}
>  
> -	return 0;
> -}
> +static const struct regmap_irq idio_16_regmap_irqs[] = {
> +	IDIO_16_REGMAP_IRQ(0), IDIO_16_REGMAP_IRQ(1), IDIO_16_REGMAP_IRQ(2), /* 0-2 */
> +	IDIO_16_REGMAP_IRQ(3), IDIO_16_REGMAP_IRQ(4), IDIO_16_REGMAP_IRQ(5), /* 3-5 */
> +	IDIO_16_REGMAP_IRQ(6), IDIO_16_REGMAP_IRQ(7), IDIO_16_REGMAP_IRQ(8), /* 6-8 */
> +	IDIO_16_REGMAP_IRQ(9), IDIO_16_REGMAP_IRQ(10), IDIO_16_REGMAP_IRQ(11), /* 9-11 */
> +	IDIO_16_REGMAP_IRQ(12), IDIO_16_REGMAP_IRQ(13), IDIO_16_REGMAP_IRQ(14), /* 12-14 */
> +	IDIO_16_REGMAP_IRQ(15), /* 15 */
> +};
>  
>  static int idio_16_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  {
>  	struct device *const dev = &pdev->dev;
> -	struct idio_16_gpio *idio16gpio;
>  	int err;
>  	const size_t pci_bar_index = 2;
>  	const char *const name = pci_name(pdev);
> -	struct gpio_irq_chip *girq;
> -
> -	idio16gpio = devm_kzalloc(dev, sizeof(*idio16gpio), GFP_KERNEL);
> -	if (!idio16gpio)
> -		return -ENOMEM;
> +	struct idio_16_regmap_config config = {};
> +	void __iomem *regs;
> +	struct regmap *map;
>  
>  	err = pcim_enable_device(pdev);
>  	if (err) {
> @@ -220,53 +93,21 @@ static int idio_16_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  		return err;
>  	}
>  
> -	idio16gpio->reg = pcim_iomap_table(pdev)[pci_bar_index];
> +	regs = pcim_iomap_table(pdev)[pci_bar_index];
>  
> -	/* Deactivate input filters */
> -	iowrite8(0, &idio16gpio->reg->filter_ctl);
> +	map = devm_regmap_init_mmio(dev, regs, &idio_16_regmap_config);
> +	if (IS_ERR(map))
> +		return dev_err_probe(dev, PTR_ERR(map),
> +				     "Unable to initialize register map\n");
>  
> -	idio16gpio->chip.label = name;
> -	idio16gpio->chip.parent = dev;
> -	idio16gpio->chip.owner = THIS_MODULE;
> -	idio16gpio->chip.base = -1;
> -	idio16gpio->chip.ngpio = IDIO_16_NGPIO;
> -	idio16gpio->chip.names = idio_16_names;
> -	idio16gpio->chip.get_direction = idio_16_gpio_get_direction;
> -	idio16gpio->chip.direction_input = idio_16_gpio_direction_input;
> -	idio16gpio->chip.direction_output = idio_16_gpio_direction_output;
> -	idio16gpio->chip.get = idio_16_gpio_get;
> -	idio16gpio->chip.get_multiple = idio_16_gpio_get_multiple;
> -	idio16gpio->chip.set = idio_16_gpio_set;
> -	idio16gpio->chip.set_multiple = idio_16_gpio_set_multiple;
> -
> -	idio_16_state_init(&idio16gpio->state);
> -
> -	girq = &idio16gpio->chip.irq;
> -	girq->chip = &idio_16_irqchip;
> -	/* This will let us handle the parent IRQ in the driver */
> -	girq->parent_handler = NULL;
> -	girq->num_parents = 0;
> -	girq->parents = NULL;
> -	girq->default_type = IRQ_TYPE_NONE;
> -	girq->handler = handle_edge_irq;
> -	girq->init_hw = idio_16_irq_init_hw;
> -
> -	raw_spin_lock_init(&idio16gpio->lock);
> -
> -	err = devm_gpiochip_add_data(dev, &idio16gpio->chip, idio16gpio);
> -	if (err) {
> -		dev_err(dev, "GPIO registering failed (%d)\n", err);
> -		return err;
> -	}
> -
> -	err = devm_request_irq(dev, pdev->irq, idio_16_irq_handler, IRQF_SHARED,
> -		name, idio16gpio);
> -	if (err) {
> -		dev_err(dev, "IRQ handler registering failed (%d)\n", err);
> -		return err;
> -	}
> +	config.parent = dev;
> +	config.map = map;
> +	config.regmap_irqs = idio_16_regmap_irqs;
> +	config.num_regmap_irqs = ARRAY_SIZE(idio_16_regmap_irqs);
> +	config.irq = pdev->irq;
> +	config.filters = true;
>  
> -	return 0;
> +	return devm_idio_16_regmap_register(dev, &config);
>  }
>  
>  static const struct pci_device_id idio_16_pci_dev_id[] = {
> -- 
> 2.39.1
> 

-- 
With Best Regards,
Andy Shevchenko


