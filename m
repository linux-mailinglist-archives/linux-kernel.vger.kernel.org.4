Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFB107319B3
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 15:15:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343841AbjFONPX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 09:15:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343697AbjFONPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 09:15:05 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C2052D49;
        Thu, 15 Jun 2023 06:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686834881; x=1718370881;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dSdnIrqkytXoK4h1PEhPHBhTw26jP5/ExIfFAh92pC4=;
  b=lcA2p9sOezWFJYw+SB44bIIC2Oa19POVSX+IMhbFIsbDV16XaG+hqAzp
   Q7+QfKZ/h2vhJvWOHgi39idDOx69bZO4I6F/tSmhNofhxQ1BGiV5eKpow
   w5YOjOnxQOne32bFKGH6YTEtWq1kCmWHWYK3roG8Q2QL2yC6yiA0WrkIn
   DBZpLyVBwKH2ds15Tc0UCfMhfE9Zz6hYpP7JYfE0xz/TeXckpBqQr8fMe
   XvRLCo7y7eS7xVDsdC2u2WgCu4SHpj2rd75yKdq+wmMkKFx4OowMHnlcO
   CkR5dyYnNH28Q9urdkRBWhhVCmYYtqDiHqzhHeH/vXDurQ05jbfhV6WEm
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="356402056"
X-IronPort-AV: E=Sophos;i="6.00,244,1681196400"; 
   d="scan'208";a="356402056"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 06:14:40 -0700
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="745544435"
X-IronPort-AV: E=Sophos;i="6.00,244,1681196400"; 
   d="scan'208";a="745544435"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP; 15 Jun 2023 06:14:38 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1q9mo8-003wjU-2m;
        Thu, 15 Jun 2023 16:14:36 +0300
Date:   Thu, 15 Jun 2023 16:14:36 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Raag Jadav <raag.jadav@intel.com>
Cc:     linus.walleij@linaro.org, mika.westerberg@linux.intel.com,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        mallikarjunappa.sangannavar@intel.com, pandith.n@intel.com
Subject: Re: [PATCH v4] pinctrl: intel: refine ->irq_set_type() hook
Message-ID: <ZIsOvBGLJTCo45jp@smile.fi.intel.com>
References: <20230615125022.27421-1-raag.jadav@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230615125022.27421-1-raag.jadav@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15, 2023 at 06:20:22PM +0530, Raag Jadav wrote:
> Refine ->irq_set_type() hook and improve its readability by:
> 
> - Reducing scope of spinlock by moving unneeded operations out of it.
> - Dropping redundant PADCFG0_RXEVCFG_SHIFT and including it directly
>   into PADCFG0_RXEVCFG_* definitions.
> - Utilizing temporary variables for common operations.
> - Simplifying if-else-if chain.

Two questions out of curiosity.
Do we gain or lose bytes with this?

> Signed-off-by: Raag Jadav <raag.jadav@intel.com>
> ---
>  drivers/pinctrl/intel/pinctrl-intel.c | 45 ++++++++++++++-------------
>  1 file changed, 24 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/pinctrl/intel/pinctrl-intel.c b/drivers/pinctrl/intel/pinctrl-intel.c
> index e8adf2580321..036eae74c479 100644
> --- a/drivers/pinctrl/intel/pinctrl-intel.c
> +++ b/drivers/pinctrl/intel/pinctrl-intel.c
> @@ -55,12 +55,11 @@
>  
>  /* Offset from pad_regs */
>  #define PADCFG0				0x000
> -#define PADCFG0_RXEVCFG_SHIFT		25
>  #define PADCFG0_RXEVCFG_MASK		GENMASK(26, 25)
> -#define PADCFG0_RXEVCFG_LEVEL		0
> -#define PADCFG0_RXEVCFG_EDGE		1
> -#define PADCFG0_RXEVCFG_DISABLED	2
> -#define PADCFG0_RXEVCFG_EDGE_BOTH	3
> +#define PADCFG0_RXEVCFG_LEVEL		(0 << 25)
> +#define PADCFG0_RXEVCFG_EDGE		(1 << 25)
> +#define PADCFG0_RXEVCFG_DISABLED	(2 << 25)
> +#define PADCFG0_RXEVCFG_EDGE_BOTH	(3 << 25)
>  #define PADCFG0_PREGFRXSEL		BIT(24)
>  #define PADCFG0_RXINV			BIT(23)
>  #define PADCFG0_GPIROUTIOXAPIC		BIT(20)
> @@ -1127,9 +1126,9 @@ static int intel_gpio_irq_type(struct irq_data *d, unsigned int type)
>  	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
>  	struct intel_pinctrl *pctrl = gpiochip_get_data(gc);
>  	unsigned int pin = intel_gpio_to_pin(pctrl, irqd_to_hwirq(d), NULL, NULL);
> +	u32 rxevcfg, rxinv, value;
>  	unsigned long flags;
>  	void __iomem *reg;
> -	u32 value;
>  
>  	reg = intel_get_padcfg(pctrl, pin, PADCFG0);
>  	if (!reg)
> @@ -1145,28 +1144,32 @@ static int intel_gpio_irq_type(struct irq_data *d, unsigned int type)
>  		return -EPERM;
>  	}
>  
> -	raw_spin_lock_irqsave(&pctrl->lock, flags);
> -
> -	intel_gpio_set_gpio_mode(reg);
> -
> -	value = readl(reg);
> -
> -	value &= ~(PADCFG0_RXEVCFG_MASK | PADCFG0_RXINV);
> -
>  	if ((type & IRQ_TYPE_EDGE_BOTH) == IRQ_TYPE_EDGE_BOTH) {
> -		value |= PADCFG0_RXEVCFG_EDGE_BOTH << PADCFG0_RXEVCFG_SHIFT;
> +		rxevcfg = PADCFG0_RXEVCFG_EDGE_BOTH;
>  	} else if (type & IRQ_TYPE_EDGE_FALLING) {
> -		value |= PADCFG0_RXEVCFG_EDGE << PADCFG0_RXEVCFG_SHIFT;
> -		value |= PADCFG0_RXINV;
> +		rxevcfg = PADCFG0_RXEVCFG_EDGE;
>  	} else if (type & IRQ_TYPE_EDGE_RISING) {
> -		value |= PADCFG0_RXEVCFG_EDGE << PADCFG0_RXEVCFG_SHIFT;
> +		rxevcfg = PADCFG0_RXEVCFG_EDGE;
>  	} else if (type & IRQ_TYPE_LEVEL_MASK) {
> -		if (type & IRQ_TYPE_LEVEL_LOW)
> -			value |= PADCFG0_RXINV;
> +		rxevcfg = PADCFG0_RXEVCFG_LEVEL;
>  	} else {
> -		value |= PADCFG0_RXEVCFG_DISABLED << PADCFG0_RXEVCFG_SHIFT;
> +		rxevcfg = PADCFG0_RXEVCFG_DISABLED;
>  	}
>  
> +	if (type == IRQ_TYPE_EDGE_FALLING || type == IRQ_TYPE_LEVEL_LOW)
> +		rxinv = PADCFG0_RXINV;
> +	else
> +		rxinv = 0;
> +
> +	raw_spin_lock_irqsave(&pctrl->lock, flags);
> +
> +	intel_gpio_set_gpio_mode(reg);
> +
> +	value = readl(reg);

> +	value = (value & ~PADCFG0_RXINV) | rxinv;
> +	value = (value & ~PADCFG0_RXEVCFG_MASK) | rxevcfg;

Same question if we change this to be similar to the current code, i.e.

	value = readl(reg);

	value &= ~(PADCFG0_RXEVCFG_MASK | PADCFG0_RXINV);
	value |= rxevcfg;
	value |= rxinv;

And I would keep blank lines after readl() and before writel() since we have
more than a single line in between.

>  	writel(value, reg);
>  
>  	if (type & IRQ_TYPE_EDGE_BOTH)
> 
> base-commit: e95433c367e681dc6d4613706bd74f483a25acd8
> -- 
> 2.17.1
> 

-- 
With Best Regards,
Andy Shevchenko


