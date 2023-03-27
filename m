Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4FB36CA252
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 13:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231987AbjC0L0o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 07:26:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjC0L0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 07:26:42 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB95A423A;
        Mon, 27 Mar 2023 04:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679916401; x=1711452401;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hC5O2GCfOP2p66Bv6Vdwwm3MQaXMKKcdAvP9wRixTW8=;
  b=bMIo5+P9DaAlzmi0Deh/UUWQ5cDooDIlBYEhziFyijTub82qIEdQcwFy
   VD8mc4QLm1hnwMaoPyKTH/R7FaV8xOsohWCLR+MXf5vPX/jJOPyzDhT/U
   piykB+DdhbmA28CSQlcz6f+3MGXFtA8C8E4R8BAerFVoIKRvG2HghZt+x
   XAEDJnZh8dm1v0lmYjM/RnEXUe9Fq5Jk9juS09ZW7MSV7MSqpJA42K3JV
   XwQFwSS0nCF+/d9HCKx7pgUj1npq8pY/WYyyOPcSCD4EIMibizdr32yRZ
   XqBYDqc0K/xN/R5Nvp+VPe+0HHoaZhZ1yKW7SRjjiX8ifepjLo/ei8WFJ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10661"; a="320639759"
X-IronPort-AV: E=Sophos;i="5.98,294,1673942400"; 
   d="scan'208";a="320639759"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2023 04:26:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10661"; a="827009535"
X-IronPort-AV: E=Sophos;i="5.98,294,1673942400"; 
   d="scan'208";a="827009535"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP; 27 Mar 2023 04:26:39 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pgkzl-009Bwz-1c;
        Mon, 27 Mar 2023 14:26:37 +0300
Date:   Mon, 27 Mar 2023 14:26:37 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, techsupport@winsystems.com,
        Paul Demetrotion <pdemetrotion@winsystems.com>,
        Michael Walle <michael@walle.cc>
Subject: Re: [PATCH v5 3/3] gpio: ws16c48: Migrate to the regmap API
Message-ID: <ZCF9bdyefA/oDmdG@smile.fi.intel.com>
References: <cover.1679845842.git.william.gray@linaro.org>
 <58531b1b2428e4d5d2ea79e721f7ef6450665280.1679845842.git.william.gray@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58531b1b2428e4d5d2ea79e721f7ef6450665280.1679845842.git.william.gray@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 26, 2023 at 12:25:59PM -0400, William Breathitt Gray wrote:
> The regmap API supports IO port accessors so we can take advantage of
> regmap abstractions rather than handling access to the device registers
> directly in the driver.
> 
> The WinSystems WS16C48 provides the following registers:
> 
>     Offset 0x0-0x5: Port 0-5 I/O
>     Offset 0x6: Int_Pending
>     Offset 0x7: Page/Lock
>     Offset 0x8-0xA (Page 1): Pol_0-Pol_2
>     Offset 0x8-0xA (Page 2): Enab_0-Enab_2
>     Offset 0x8-0xA (Page 3): Int_ID0-Int_ID2
> 
> Port 0-5 I/O provides access to 48 lines of digital I/O across six
> registers, each bit position corresponding to the respective line.
> Writing a 1 to a respective bit position causes that output pin to sink
> current, while writing a 0 to the same bit position causes that output
> pin to go to a high-impedance state and allows it to be used an input.
> Reads on a port report the inverted state (0 = high, 1 = low) of an I/O
> pin when used in input mode. Interrupts are supported on Port 0-2.
> 
> Int_Pending is a read-only register that reports the combined state of
> the INT_ID0 through INT_ID2 registers; an interrupt pending is indicated
> when any of the low three bits are set.
> 
> The Page/Lock register provides the following bits:
> 
>     Bit 0-5: Port 0-5 I/O Lock
>     Bit 6-7: Page 0-3 Selection
> 
> For Bits 0-5, writing a 1 to a respective bit position locks the output
> state of the corresponding I/O port. Writing the page number to Bits 6-7
> selects that respective register page for use.
> 
> Pol_0-Pol_2 are accessible when Page 1 is selected. Writing a 1 to a
> respective bit position selects the rising edge detection interrupts for
> that input line, while writing a 0 to the same bit position selects the
> falling edge detection interrupts.
> 
> Enab_0-Enab_2 are accessible when Page 2 is selected. Writing a 1 to a
> respective bit position enables interrupts for that input line, while
> writing a 0 to that same bit position clears and disables interrupts for
> that input line.
> 
> Int_ID0-Int_ID2 are accessible when Page 3 is selected. A respective bit
> when read as a 1 indicates that an edge of the polarity set in the
> corresponding polarity register was detected for the corresponding input
> line. Writing any value to this register clears all pending interrupts
> for the register.

...

> +static const struct regmap_config ws16c48_regmap_config = {
> +	.reg_bits = 8,
> +	.reg_stride = 1,
> +	.val_bits = 8,
> +	.io_port = true,
> +	.max_register = 0xA,
> +	.wr_table = &ws16c48_wr_table,
> +	.rd_table = &ws16c48_rd_table,
> +	.volatile_table = &ws16c48_volatile_table,
> +	.cache_type = REGCACHE_FLAT,
> +};

Do we need regmap lock?

...

>  /**
>   * struct ws16c48_gpio - GPIO device private data structure
> - * @chip:	instance of the gpio_chip
> - * @io_state:	bit I/O state (whether bit is set to input or output)
> - * @out_state:	output bits state
> + * @map:	regmap for the device
>   * @lock:	synchronization lock to prevent I/O race conditions
>   * @irq_mask:	I/O bits affected by interrupts
> - * @flow_mask:	IRQ flow type mask for the respective I/O bits
> - * @reg:	I/O address offset for the device registers
>   */
>  struct ws16c48_gpio {
> -	struct gpio_chip chip;
> -	unsigned char io_state[6];
> -	unsigned char out_state[6];
> +	struct regmap *map;
>  	raw_spinlock_t lock;
> -	unsigned long irq_mask;
> -	unsigned long flow_mask;
> -	struct ws16c48_reg __iomem *reg;
> +	u8 irq_mask[WS16C48_NUM_IRQS / WS16C48_NGPIO_PER_REG];

Looking at this (and also thinking about the previous patch) perhaps this
should be declared as

	DECLARE_BITMAP(...);

and corresponding bit ops to be used?

>  };

...

> +static int ws16c48_handle_pre_irq(void *const irq_drv_data)
>  {
> +	struct ws16c48_gpio *const ws16c48gpio = irq_drv_data;
>  
> +	/* Lock to prevent Page/Lock register change while we handle IRQ */
> +	raw_spin_lock(&ws16c48gpio->lock);
>  
>  	return 0;
>  }

Hmm... Don't we have irq bus lock and unlock callbacks for this?

...

> +static int ws16c48_handle_post_irq(void *const irq_drv_data)
>  {
> +	struct ws16c48_gpio *const ws16c48gpio = irq_drv_data;
>  
> +	raw_spin_unlock(&ws16c48gpio->lock);
>  
>  	return 0;
>  }

Ditto.

Also shouldn't you annotate them for sparse so it won't complain about
unbalanced locks?

...

> +exit_early:

exit_unlock() ?

>  	raw_spin_unlock_irqrestore(&ws16c48gpio->lock, flags);

> +	return ret;

...

> +	err = regmap_write(map, WS16C48_ENAB, 0x00);

				WS16C48_ENAB + 0

(for the sake of symmetry with the below)?

> +	if (err)
> +		return err;
> +	err = regmap_write(map, WS16C48_ENAB + 1, 0x00);
> +	if (err)
> +		return err;
> +	err = regmap_write(map, WS16C48_ENAB + 2, 0x00);
> +	if (err)
> +		return err;

-- 
With Best Regards,
Andy Shevchenko


