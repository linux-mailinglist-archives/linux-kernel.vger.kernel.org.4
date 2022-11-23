Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A80B636705
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 18:29:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238271AbiKWR3F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 12:29:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238656AbiKWR27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 12:28:59 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E354968C7E;
        Wed, 23 Nov 2022 09:28:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669224535; x=1700760535;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qHFygkGoX9nmpFI5CLXXf503bQn9fofmn2p0IxhzU3E=;
  b=dWYD8cd92CseVR8CG74Uz29mvs1ppGYh77VmDbPM5RSVdZg/wCwC29pC
   9bpDsk7u2g4WQkxSMH747MElDL/hX1FQesX8Oth+OIjEbeD2xUMtRKS8t
   eFiRU6WEIHk7dXNZdvJVIlAOPRkBETXWPU2ge6mDckWWps8m8WJzkjQYz
   4WKMxVlHUMgycNmqp2yQf09Wfmplnm+yDpLN1aLpsPzQFas2PhVpc2XRx
   197FnBjFpKBVBUw3M7iKskCQheGyo1ZFwRVCEZUnoIsyu0ufEIUXzHJvx
   PHigp71qFENMQq1sqlYL8H6NYjcoUFkW2t99VMRWOggYIBa6KAwjNLkhP
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="315941251"
X-IronPort-AV: E=Sophos;i="5.96,187,1665471600"; 
   d="scan'208";a="315941251"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2022 09:28:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="970941548"
X-IronPort-AV: E=Sophos;i="5.96,187,1665471600"; 
   d="scan'208";a="970941548"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP; 23 Nov 2022 09:28:52 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oxtYI-00GNn3-2h;
        Wed, 23 Nov 2022 19:28:50 +0200
Date:   Wed, 23 Nov 2022 19:28:50 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        michael@walle.cc, broonie@kernel.org
Subject: Re: [PATCH v3 4/9] gpio: 104-idi-48: Migrate to the regmap-irq API
Message-ID: <Y35YUszFUiXwqpdQ@smile.fi.intel.com>
References: <cover.1669100542.git.william.gray@linaro.org>
 <aa9baf89fc61eae62dfb1e1920cd3e5d1a8b3d55.1669100542.git.william.gray@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa9baf89fc61eae62dfb1e1920cd3e5d1a8b3d55.1669100542.git.william.gray@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2022 at 02:11:01AM -0500, William Breathitt Gray wrote:
> The regmap API supports IO port accessors so we can take advantage of
> regmap abstractions rather than handling access to the device registers
> directly in the driver.
> 
> For the 104-idi-48, we get an IRQ register with some status information
> and basic masking, but it's broken down by banks rather than individual
> GPIO. There are six banks (8 GPIO lines each) that correspond to the
> lower six bits of the IRQ register (bits 0-5):
> 
>     Base Address + 7 (Read): IRQ Status Register/IRQ Clear
>         Bit 0-5: Respective Bank IRQ Statuses
>         Bit 6: IRQ Status (Active Low)
>         Bit 7: IRQ Enable Status
>     Base Address + 7 (Write): IRQ Enable/Disable
>         Bit 0-5: Respective Bank IRQ Enable/Disable

> Cc: Mark Brown <broonie@kernel.org>

Hint: you may use --cc parameter to `git send-email ...` to Cc additional people.

...

> +#define IDI48_REGMAP_IRQ(_id) \
> +	[_id] = { \
> +		.mask = BIT((_id) / 8), \
> +		.type = { .types_supported = IRQ_TYPE_EDGE_BOTH, }, \
>  	}

Same comments as per previous patch.

...

> +static const struct regmap_irq idi48_regmap_irqs[IDI48_NGPIO] = {
> +	IDI48_REGMAP_IRQ(0), IDI48_REGMAP_IRQ(1), IDI48_REGMAP_IRQ(2),
> +	IDI48_REGMAP_IRQ(3), IDI48_REGMAP_IRQ(4), IDI48_REGMAP_IRQ(5),
> +	IDI48_REGMAP_IRQ(6), IDI48_REGMAP_IRQ(7), IDI48_REGMAP_IRQ(8),
> +	IDI48_REGMAP_IRQ(9), IDI48_REGMAP_IRQ(10), IDI48_REGMAP_IRQ(11),
> +	IDI48_REGMAP_IRQ(12), IDI48_REGMAP_IRQ(13), IDI48_REGMAP_IRQ(14),
> +	IDI48_REGMAP_IRQ(15), IDI48_REGMAP_IRQ(16), IDI48_REGMAP_IRQ(17),
> +	IDI48_REGMAP_IRQ(18), IDI48_REGMAP_IRQ(19), IDI48_REGMAP_IRQ(20),
> +	IDI48_REGMAP_IRQ(21), IDI48_REGMAP_IRQ(22), IDI48_REGMAP_IRQ(23),
> +	IDI48_REGMAP_IRQ(24), IDI48_REGMAP_IRQ(25), IDI48_REGMAP_IRQ(26),
> +	IDI48_REGMAP_IRQ(27), IDI48_REGMAP_IRQ(28), IDI48_REGMAP_IRQ(29),
> +	IDI48_REGMAP_IRQ(30), IDI48_REGMAP_IRQ(31), IDI48_REGMAP_IRQ(32),
> +	IDI48_REGMAP_IRQ(33), IDI48_REGMAP_IRQ(34), IDI48_REGMAP_IRQ(35),
> +	IDI48_REGMAP_IRQ(36), IDI48_REGMAP_IRQ(37), IDI48_REGMAP_IRQ(38),
> +	IDI48_REGMAP_IRQ(39), IDI48_REGMAP_IRQ(40), IDI48_REGMAP_IRQ(41),
> +	IDI48_REGMAP_IRQ(42), IDI48_REGMAP_IRQ(43), IDI48_REGMAP_IRQ(44),
> +	IDI48_REGMAP_IRQ(45), IDI48_REGMAP_IRQ(46), IDI48_REGMAP_IRQ(47),

Perhaps here would be nice to have it like

	IDI48_REGMAP_IRQ(45), IDI48_REGMAP_IRQ(46), IDI48_REGMAP_IRQ(47), /* 45-47 */

?

> +};

...

> +	err = devm_regmap_add_irq_chip(dev, map, irq[id], IRQF_SHARED, 0, chip,
> +				       &chip_data);
> +	if (err) {

> +		dev_err(dev, "IRQ registration failed (%d)\n", err);
> +		return err;

I'm wondering if you plan to switch to dev_err_probe() at some point.

> +	}

-- 
With Best Regards,
Andy Shevchenko


