Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB4166362A8
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 16:02:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238009AbiKWPCI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 10:02:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237496AbiKWPCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 10:02:05 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0725F2F3A4;
        Wed, 23 Nov 2022 07:02:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669215725; x=1700751725;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cu3IGHk+KWNT4/J9/yQSAfLQbKsbIpwvyl5b794H6aw=;
  b=bB6AxfCUBvndPrkYs4+8EVAERCMFneLV4Fhy7QzMhWbWxuRxe4g907hF
   1zyAODwz217vS3AS2BUWDUSIjQ0zoL3m95ujEo9YuqlB/AROHmu8YPg9T
   MMIO8E/9g27scjjfRwvfBP+joWOu7dfidSjA106JAnWTV/tr3YE8eVyN9
   Dz6UNDss2Y2zzRE0VU1iaN+1XxWu+MnjXA0ZHzkcghzl3vBd0/ixyO3H7
   9u1iA8NqpZDt9lpgx0Zz6rtYjBejCS8RjCMq1ihSn0M0G8+VwjsgpC9hn
   sZiENVUmdr/Q+Z6SocNtEvXljORT3WbCIEETtIZU9qyats+bc9VT2WV4M
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="378341376"
X-IronPort-AV: E=Sophos;i="5.96,187,1665471600"; 
   d="scan'208";a="378341376"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2022 07:01:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="635941367"
X-IronPort-AV: E=Sophos;i="5.96,187,1665471600"; 
   d="scan'208";a="635941367"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP; 23 Nov 2022 07:01:55 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oxrG5-00GKhH-1v;
        Wed, 23 Nov 2022 17:01:53 +0200
Date:   Wed, 23 Nov 2022 17:01:53 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        michael@walle.cc, broonie@kernel.org
Subject: Re: [PATCH v3 3/9] gpio: 104-dio-48e: Migrate to the regmap-irq API
Message-ID: <Y3414YhVjqKakddV@smile.fi.intel.com>
References: <cover.1669100542.git.william.gray@linaro.org>
 <80fc819bcafe9697b6e02c0750d3cf0ea4ec9e1b.1669100542.git.william.gray@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80fc819bcafe9697b6e02c0750d3cf0ea4ec9e1b.1669100542.git.william.gray@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2022 at 02:11:00AM -0500, William Breathitt Gray wrote:
> The regmap API supports IO port accessors so we can take advantage of
> regmap abstractions rather than handling access to the device registers
> directly in the driver.
> 
> For the 104-dio-48e we have the following IRQ registers (0xB and 0xF):
> 
>     Base Address +B (Write): Enable Interrupt
>     Base Address +B (Read): Disable Interrupt
>     Base Address +F (Read/Write): Clear Interrupt
> 
> Any write to 0xB will enable interrupts, while any read will disable
> interrupts. Interrupts are cleared by a read or any write to 0xF.
> There's no IRQ status register, so software has to assume that if an
> interrupt is raised then it was for the 104-DIO-48E device.

...

> +/* only bit 3 on each respective Port C supports interrupts */
> +#define DIO48E_REGMAP_IRQ(_ppi) \
> +	[19 + (_ppi) * 24] = { \
> +		.mask = BIT(_ppi), \
> +		.type = { .types_supported = IRQ_TYPE_EDGE_RISING, }, \

When {} on a single line, the trailing comma is not needed.

		.type = { .types_supported = IRQ_TYPE_EDGE_RISING }, \

would work as well.

A nit: I would put \ on the same column by using TABs before each of them.

>  	}

...

> +	/* if all previously masked, enable interrupts when unmasking */
> +	if (prev_mask == all_masked) {
> +		err = regmap_write(map, DIO48E_ENABLE_INTERRUPT, 0x00);
> +		if (err)
> +			return err;
> +	/* if all are currently masked, disable interrupts */
> +	} else if (mask_buf == all_masked) {
> +		err = regmap_read(map, DIO48E_DISABLE_INTERRUPT, &val);
> +		if (err)
> +			return err;
> +	}

Haven't looked at the rest of the series, but if there is nothing with this
code piece, the above can be optimized to

	if (prev_mask == all_masked)
		return regmap_write(map, DIO48E_ENABLE_INTERRUPT, 0x00);

	if (mask_buf == all_masked)
		return regmap_read(map, DIO48E_DISABLE_INTERRUPT, &val);

...

> +	/* Initialize device interrupt state */
> +	err = regmap_read(map, DIO48E_DISABLE_INTERRUPT, &val);
> +	if (err)
> +		return err;

Use ->init_hw() callback for this.

...

> +	err = devm_regmap_add_irq_chip(dev, map, irq[id], 0, 0, chip,
> +				       &chip_data);

I would leave this on one line. It's only 82.

> +	if (err) {
> +		dev_err(dev, "IRQ registration failed (%d)\n", err);
> +		return err;
> +	}

-- 
With Best Regards,
Andy Shevchenko


