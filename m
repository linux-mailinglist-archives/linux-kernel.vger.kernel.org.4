Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11FDD6CA1DE
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 12:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232127AbjC0K7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 06:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232106AbjC0K7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 06:59:47 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ADB044A0;
        Mon, 27 Mar 2023 03:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679914786; x=1711450786;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aJzI+wMPKlXPUgKnnSLNAYwqiP4hDT7bkOx2JUB8ZsU=;
  b=IMAr4m20fzhnjSR/WaP3nV2bazINcf7U/RNNP3fXS809fhBp+us5P5/V
   2atAyJmqSneEVNLkiP9vkmZ7BoM+awM28e4DknexTKSBoSeDT9ceQEoe9
   AOmCLK5rClcNJhvfVOEJ2ndV0/GfEnTnDZHSsmapbcIrzyo50sfCDlKYH
   IGq8vwzJTm0/bou16+NTvNQRoneDA3fJZczOGOG3iPOa7DVPSqtIicZFv
   2wimg+HmzY7LbhfXFE4S7RhI1NBJNNEd3W5C6Uz55q2/Iiq2SKDGP6MOt
   8aJ2EmlYsMJHhw/21/+iyH7EfAEZcM1XIZ8P81pYcSTNj2mJZ+cUiMEIV
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10661"; a="319891371"
X-IronPort-AV: E=Sophos;i="5.98,294,1673942400"; 
   d="scan'208";a="319891371"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2023 03:59:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10661"; a="747958128"
X-IronPort-AV: E=Sophos;i="5.98,294,1673942400"; 
   d="scan'208";a="747958128"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008.fm.intel.com with ESMTP; 27 Mar 2023 03:59:40 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pgkZe-009BUh-2x;
        Mon, 27 Mar 2023 13:59:38 +0300
Date:   Mon, 27 Mar 2023 13:59:38 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Arnaud de Turckheim <quarium@gmail.com>,
        John Hentges <jhentges@accesio.com>,
        Jay Dolan <jay.dolan@accesio.com>,
        Michael Walle <michael@walle.cc>
Subject: Re: [PATCH v5 2/3] gpio: pcie-idio-24: Migrate to the regmap API
Message-ID: <ZCF3Gnn0qt3hxv8K@smile.fi.intel.com>
References: <cover.1679845842.git.william.gray@linaro.org>
 <8ae7f448360068172b06fedb6a568373b73521bc.1679845842.git.william.gray@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ae7f448360068172b06fedb6a568373b73521bc.1679845842.git.william.gray@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 26, 2023 at 12:25:58PM -0400, William Breathitt Gray wrote:
> The regmap API supports IO port accessors so we can take advantage of
> regmap abstractions rather than handling access to the device registers
> directly in the driver.
> 
> For the PCIe-IDIO-24 series of devices, the following BARs are
> available:
> 
>     BAR[0]: memory mapped PEX8311
>     BAR[1]: I/O mapped PEX8311
>     BAR[2]: I/O mapped card registers
> 
> There are 24 FET Output lines, 24 Isolated Input lines, and 8 TTL/CMOS
> lines (which may be configured for either output or input). The GPIO
> lines are exposed by the following card registers:
> 
>     Base +0x0-0x2 (Read/Write): FET Outputs
>     Base +0xB (Read/Write): TTL/CMOS
>     Base +0x4-0x6 (Read): Isolated Inputs
>     Base +0x7 (Read): TTL/CMOS
> 
> In order for the device to support interrupts, the PLX PEX8311 internal
> PCI wire interrupt and local interrupt input must first be enabled.
> 
> The following card registers for Change-Of-State may be used:
> 
>     Base +0x8-0xA (Read): COS Status Inputs
>     Base +0x8-0xA (Write): COS Clear Inputs
>     Base +0xB (Read): COS Status TTL/CMOS
>     Base +0xB (Write): COS Clear TTL/CMOS
>     Base +0xE (Read/Write): COS Enable
> 
> The COS Enable register is used to enable/disable interrupts and
> configure the interrupt levels; each bit maps to a group of eight inputs
> as described below:
> 
>     Bit 0: IRQ EN Rising Edge IN0-7
>     Bit 1: IRQ EN Rising Edge IN8-15
>     Bit 2: IRQ EN Rising Edge IN16-23
>     Bit 3: IRQ EN Rising Edge TTL0-7
>     Bit 4: IRQ EN Falling Edge IN0-7
>     Bit 5: IRQ EN Falling Edge IN8-15
>     Bit 6: IRQ EN Falling Edge IN16-23
>     Bit 7: IRQ EN Falling Edge TTL0-7
> 
> An interrupt is asserted when a change-of-state matching the interrupt
> level configuration respective for a particular group of eight inputs
> with enabled COS is detected.
> 
> The COS Status registers may be read to determine which inputs have
> changed; if interrupts were enabled, an IRQ will be generated for the
> set bits in these registers. Writing the value read from the COS Status
> register back to the respective COS Clear register will clear just those
> interrupts.

...

> Cc: Arnaud de Turckheim <quarium@gmail.com>
> Cc: John Hentges <jhentges@accesio.com>
> Cc: Jay Dolan <jay.dolan@accesio.com>

You can use --cc parameter to the `git format-patch`.

...

> +static const struct regmap_config pex8311_intcsr_regmap_config = {
> +	.name = "pex8311_intcsr",
> +	.reg_bits = 32,
> +	.reg_stride = 1,
> +	.reg_base = PLX_PEX8311_PCI_LCS_INTCSR,
> +	.val_bits = 32,
> +	.io_port = true,
> +	.max_register = 0x0,
> +};

Do you need regmap lock? If so, what for?

...

> +static const struct regmap_config idio_24_regmap_config = {
> +	.reg_bits = 8,
> +	.reg_stride = 1,
> +	.val_bits = 8,
> +	.io_port = true,
> +	.max_register = 0xF,
> +	.wr_table = &idio_24_wr_table,
> +	.rd_table = &idio_24_rd_table,
> +	.volatile_table = &idio_24_volatile_table,
> +	.cache_type = REGCACHE_FLAT,
> +};

Ditto.

...

> +static int idio_24_set_type_config(unsigned int **const buf, const unsigned int type,
> +				   const struct regmap_irq *const irq_data, const int idx,
> +				   void *const irq_drv_data)
>  {
> +	const unsigned int offset = irq_data->reg_offset;
> +	const unsigned int rising = COS_ENABLE_RISING << offset;
> +	const unsigned int falling = COS_ENABLE_FALLING << offset;
> +	const unsigned int mask = COS_ENABLE_BOTH << offset;
> +	struct idio_24_gpio *const idio24gpio = irq_drv_data;
> +	unsigned int new;
> +	unsigned int cos_enable;
> +	int ret;
> +
> +	switch (type) {
> +	case IRQ_TYPE_EDGE_RISING:
> +		new = rising;
> +		break;
> +	case IRQ_TYPE_EDGE_FALLING:
> +		new = falling;
> +		break;
> +	case IRQ_TYPE_EDGE_BOTH:
> +		new = mask;
> +		break;
> +	default:
> +		return -EINVAL;
>  	}
>  
> +	raw_spin_lock(&idio24gpio->lock);
>  
> +	/* replace old bitmap with new bitmap */
> +	idio24gpio->irq_type = (idio24gpio->irq_type & ~mask) | (new & mask);
>  
> +	ret = regmap_read(idio24gpio->map, IDIO_24_COS_ENABLE, &cos_enable);
> +	if (ret)
> +		goto exit_early;
>  
> +	/* if COS is currently enabled then update the edge type */
> +	if (cos_enable & mask) {
> +		ret = regmap_update_bits(idio24gpio->map, IDIO_24_COS_ENABLE, mask,
> +					 idio24gpio->irq_type);
> +		goto exit_early;
>  	}

> +exit_early:

More descriptive is to call it

exit_unlock:

The rule of thumb is to explain what _will_ happen, if we goto $LABEL.

> +	raw_spin_unlock(&idio24gpio->lock);
>  
> +	return ret;
>  }

-- 
With Best Regards,
Andy Shevchenko


