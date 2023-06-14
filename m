Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE0F7304D4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 18:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233011AbjFNQWq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 12:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjFNQWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 12:22:44 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57EB1ED;
        Wed, 14 Jun 2023 09:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686759763; x=1718295763;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=li6GYo+wwMWYVTIEewqCORPcFr5mex3K6+KDY2sj2uw=;
  b=dp8UBQeMhSIZrvlZzLWP4V1QRetd1rrXT/aU+YXyjybWLNzIFikWk8U8
   1Vj03sdF2wyHU23fNewKqTkFoLZMQ8ZCGHicn5dVCknxs89IglxKxyqXQ
   08HnwCDzcyq9r1pt9U+f1HHdu+5e+zumVakXiVq2C3NkC25n3v7Plc1O7
   /HnkqgwqZKYFX6U1H9/NedA2Vv/Lj4va00nosIzdxpDxtciYEE4sO0hn2
   F0Mj8wNsUAruPXywtHTRzAFw1LtAaWA9tdKX0jx/VIHK+cMdOlOp0sKdt
   co52NRlEBwIPjbi5h3etb656ZOU9QoOg3XxAQ59wCp+N0uR+E6ctNArgf
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="424549372"
X-IronPort-AV: E=Sophos;i="6.00,243,1681196400"; 
   d="scan'208";a="424549372"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 09:22:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="824876952"
X-IronPort-AV: E=Sophos;i="6.00,243,1681196400"; 
   d="scan'208";a="824876952"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP; 14 Jun 2023 09:22:39 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1q9TGZ-003jp9-1Y;
        Wed, 14 Jun 2023 19:22:39 +0300
Date:   Wed, 14 Jun 2023 19:22:39 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Raag Jadav <raag.jadav@intel.com>
Cc:     linus.walleij@linaro.org, mika.westerberg@linux.intel.com,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        mallikarjunappa.sangannavar@intel.com, pandith.n@intel.com
Subject: Re: [PATCH v3 2/3] pinctrl: intel: refine ->irq_set_type() hook
Message-ID: <ZInpT0dUUVUcKdqv@smile.fi.intel.com>
References: <20230613085054.10976-1-raag.jadav@intel.com>
 <20230613085054.10976-3-raag.jadav@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230613085054.10976-3-raag.jadav@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 13, 2023 at 02:20:53PM +0530, Raag Jadav wrote:
> Utilize a temporary variable for common shift operation
> in ->irq_set_type() hook and improve readability.
> While at it, simplify if-else-if chain and save a few bytes.
> 
> add/remove: 0/0 grow/shrink: 0/1 up/down: 0/-16 (-16)
> Function                                     old     new   delta
> intel_gpio_irq_type                          317     301     -16
> Total: Before=10469, After=10453, chg -0.15%

...

>  	value = readl(reg);
> -
>  	value &= ~(PADCFG0_RXEVCFG_MASK | PADCFG0_RXINV);
>  
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
> +		value |= PADCFG0_RXINV;
> +
> +	value |= rxevcfg << PADCFG0_RXEVCFG_SHIFT;
>  	writel(value, reg);

Looking at this I realized that entire temporary variable assignments can be
done outside of spin lock. You probably would need another one for keeping
rxinv value.

Will it give us any memory reduction in comparison to the current code?

-- 
With Best Regards,
Andy Shevchenko


