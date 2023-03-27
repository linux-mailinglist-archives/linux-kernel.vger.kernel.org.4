Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9B606CA19A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 12:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233581AbjC0KpH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 06:45:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232655AbjC0KpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 06:45:05 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAA8630E6;
        Mon, 27 Mar 2023 03:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679913904; x=1711449904;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lqsOs/9uwPbqpr7690QeQLSmC4PI44TEKkuNiKcJQEA=;
  b=DNF1rCKrG0+KiAVmlq2DFpfhdc5G47Ubu7QVlfpTP+kWS29HW1DG5QXJ
   F4VFbv2z0rUCd473FTqqcvxosyzLLG1NlAK4+3pxfmn2tIORumcShAUl8
   vZuYuXEmlf3im+Uqs0nx+zNWT0iOdqY0w+ouEKM4O0olHSTsxMaw14Axv
   9v6P+Bgm0Iv6IIMcnkqlLz/MvDlDGA9417hkxQr6HUBLrXrUmckS601Oo
   dklJdy6nUTnRDnXkCCd/ZKCmGhjAZ+LAxaMo39jk9PKVn7b8V1M/pGbh/
   u9NZoqN6tjyBA1dclirN/Z20YGYqrDF1SXhqXVbvztHuQXmb1OSACLdAB
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10661"; a="319889241"
X-IronPort-AV: E=Sophos;i="5.98,294,1673942400"; 
   d="scan'208";a="319889241"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2023 03:45:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10661"; a="747953593"
X-IronPort-AV: E=Sophos;i="5.98,294,1673942400"; 
   d="scan'208";a="747953593"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008.fm.intel.com with ESMTP; 27 Mar 2023 03:44:54 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pgkLN-009BEd-1k;
        Mon, 27 Mar 2023 13:44:53 +0300
Date:   Mon, 27 Mar 2023 13:44:53 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/4] gpio: idio-16: Migrate to the regmap API
Message-ID: <ZCFzpVKEFvgNLAAT@smile.fi.intel.com>
References: <cover.1679693714.git.william.gray@linaro.org>
 <dc230046590e27f7c349456a087bc7ddbe635fee.1679693714.git.william.gray@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc230046590e27f7c349456a087bc7ddbe635fee.1679693714.git.william.gray@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2023 at 05:45:41PM -0400, William Breathitt Gray wrote:
> The regmap API supports IO port accessors so we can take advantage of
> regmap abstractions rather than handling access to the device registers
> directly in the driver.
> 
> By leveraging the regmap API, the idio-16 library is reduced to simply a
> devm_idio_16_regmap_register() function and a configuration structure
> struct idio_16_regmap_config.
> 
> Legacy functions and code will be removed once all consumers have
> migrated to the new idio-16 library interface.
> 
> For IDIO-16 devices we have the following IRQ registers:
> 
>     Base Address +1 (Write): Clear Interrupt
>     Base Address +2 (Read): Enable Interrupt
>     Base Address +2 (Write): Disable Interrupt
> 
> An interrupt is asserted whenever a change-of-state is detected on any
> of the inputs. Any write to 0x2 will disable interrupts, while any read
> will enable interrupts. Interrupts are cleared by a write to 0x1.
> 
> For 104-IDIO-16 devices, there is no IRQ status register, so software
> has to assume that if an interrupt is raised then it was for the
> 104-IDIO-16 device.
> 
> For PCI-IDIO-16 devices, there is an additional IRQ register:
> 
>     Base Address +6 (Read): Interrupt Status
> 
> Interrupt status can be read from 0x6 where bit 2 set indicates that an
> IRQ has been generated.

...

> +static int idio_16_reg_mask_xlate(struct gpio_regmap *const gpio, const unsigned int base,
> +				  const unsigned int offset, unsigned int *const reg,
> +				  unsigned int *const mask)
> +{
> +	unsigned int stride;

> +	if (base != IDIO_16_DAT_BASE)
> +		/* Should never reach this path */
> +		return -EINVAL;

Then why do we have this test at all?

> +	/* Input lines start at GPIO 16 */
> +	if (offset < 16) {
> +		stride = offset / IDIO_16_NGPIO_PER_REG;
> +		*reg = IDIO_16_OUT_BASE + stride * IDIO_16_REG_STRIDE;
> +	} else {
> +		stride = (offset - 16) / IDIO_16_NGPIO_PER_REG;
> +		*reg = IDIO_16_IN_BASE + stride * IDIO_16_REG_STRIDE;
> +	}
> +
> +	*mask = BIT(offset % IDIO_16_NGPIO_PER_REG);
> +
> +	return 0;
> +}

...

> +static const char *idio_16_names[IDIO_16_NGPIO] = {
> +	"OUT0", "OUT1", "OUT2", "OUT3", "OUT4", "OUT5", "OUT6", "OUT7", "OUT8", "OUT9", "OUT10",
> +	"OUT11", "OUT12", "OUT13", "OUT14", "OUT15", "IIN0", "IIN1", "IIN2", "IIN3", "IIN4", "IIN5",
> +	"IIN6", "IIN7", "IIN8", "IIN9", "IIN10", "IIN11", "IIN12", "IIN13", "IIN14", "IIN15",

I believe this would look much better if formatted on the 8 basis per line.

> +};

...

> +int devm_idio_16_regmap_register(struct device *const dev,
> +				 const struct idio_16_regmap_config *const config)
> +{
> +	struct gpio_regmap_config gpio_config = {};
> +	int err;
> +	struct idio_16_data *data;
> +	struct regmap_irq_chip *chip;
> +	struct regmap_irq_chip_data *chip_data;
> +
> +	if (!config->parent)
> +		return -EINVAL;
> +
> +	if (!config->map)
> +		return -EINVAL;
> +
> +	if (!config->regmap_irqs)
> +		return -EINVAL;
> +
> +	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +	data->map = config->map;
> +
> +	chip = devm_kzalloc(dev, sizeof(*chip), GFP_KERNEL);
> +	if (!chip)
> +		return -ENOMEM;
> +
> +	chip->name = dev_name(dev);
> +	chip->status_base = IDIO_16_INTERRUPT_STATUS;
> +	chip->mask_base = IDIO_16_ENABLE_IRQ;
> +	chip->ack_base = IDIO_16_CLEAR_INTERRUPT;
> +	chip->no_status = config->no_status;
> +	chip->num_regs = 1;
> +	chip->irqs = config->regmap_irqs;
> +	chip->num_irqs = config->num_regmap_irqs;
> +	chip->handle_mask_sync = idio_16_handle_mask_sync;
> +	chip->irq_drv_data = data;
> +
> +	/* Disable IRQ to prevent spurious interrupts before we're ready */
> +	err = regmap_write(data->map, IDIO_16_DISABLE_IRQ, 0x00);
> +	if (err)
> +		return err;
> +
> +	err = devm_regmap_add_irq_chip(dev, data->map, config->irq, 0, 0, chip, &chip_data);
> +	if (err) {

> +		dev_err(dev, "IRQ registration failed (%d)\n", err);
> +		return err;

		return dev_err_probe(...);

devm_*() can't be called otherwise. If it's not the case the caller abuses
devm_*() to begin with. So, it's the _part_ of the ->probe() sequence.

> +	}
> +
> +	if (config->filters) {
> +		/* Deactivate input filters */
> +		err = regmap_write(data->map, IDIO_16_DEACTIVATE_INPUT_FILTERS, 0x00);
> +		if (err)
> +			return err;
> +	}
> +
> +	gpio_config.parent = config->parent;
> +	gpio_config.regmap = data->map;
> +	gpio_config.ngpio = IDIO_16_NGPIO;
> +	gpio_config.names = idio_16_names;
> +	gpio_config.reg_dat_base = GPIO_REGMAP_ADDR(IDIO_16_DAT_BASE);
> +	gpio_config.reg_set_base = GPIO_REGMAP_ADDR(IDIO_16_DAT_BASE);
> +	gpio_config.ngpio_per_reg = IDIO_16_NGPIO_PER_REG;
> +	gpio_config.reg_stride = IDIO_16_REG_STRIDE;
> +	gpio_config.irq_domain = regmap_irq_get_domain(chip_data);
> +	gpio_config.reg_mask_xlate = idio_16_reg_mask_xlate;
> +
> +	return PTR_ERR_OR_ZERO(devm_gpio_regmap_register(dev, &gpio_config));
> +}

-- 
With Best Regards,
Andy Shevchenko


