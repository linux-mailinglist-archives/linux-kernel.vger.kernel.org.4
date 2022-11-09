Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D89D622A68
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 12:25:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbiKILZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 06:25:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbiKILZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 06:25:11 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7586318E16;
        Wed,  9 Nov 2022 03:25:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667993110; x=1699529110;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0WhiwUnqDwhyviaYQaX+G73ARB0QDR8JMZMsg4Y0x3A=;
  b=mTzU8U/Fc4pq21F/dJNGwaCTS9F4whcIH6Xg7s28HfvVX67mc0HlfgAB
   TrBFqG22lMpyAO10cvef64JfMtJqew14rcEdjgvFIKjSFwIKAfR9SEsIO
   xCP/Ml1nNfDs6VnsAPUJ6hNzqYzjSQdSKkOrXWQ+8RQlCN/eIuBFK5ZhQ
   aT6AFxv4Fr5hA4tAGdVFAB0XmqS3ipC0ETZ7QQlcY6j0KrMcVxTgq3soN
   M96RL5quyjSp+Oo8gH315GFE/jWDLATymv8leMa41eRvYhvNtVzXyCLk8
   Dq2c56l8E7GiUmfF55Kmu4UI9oJQ4Ho0smZp7b/OMh57rhJpmHcXvp0Bx
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="290670098"
X-IronPort-AV: E=Sophos;i="5.96,150,1665471600"; 
   d="scan'208";a="290670098"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2022 03:25:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="761850558"
X-IronPort-AV: E=Sophos;i="5.96,150,1665471600"; 
   d="scan'208";a="761850558"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP; 09 Nov 2022 03:25:08 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1osjCc-009iUt-2U;
        Wed, 09 Nov 2022 13:25:06 +0200
Date:   Wed, 9 Nov 2022 13:25:06 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-acpi@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/6] gpiolib: consolidate GPIO lookups
Message-ID: <Y2uOEhib5dvIcobF@smile.fi.intel.com>
References: <20221031-gpiolib-swnode-v2-0-81f55af5fa0e@gmail.com>
 <20221031-gpiolib-swnode-v2-5-81f55af5fa0e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221031-gpiolib-swnode-v2-5-81f55af5fa0e@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 08, 2022 at 04:26:50PM -0800, Dmitry Torokhov wrote:
> Ensure that all paths to obtain/look up GPIOD from generic
> consumer-visible APIs go through the new gpiod_find_and_request()
> helper, so that we can easily extend it with support for new firmware
> mechanisms.
> 
> The only exception is OF-specific [devm_]gpiod_get_from_of_node() API
> that is still being used by a couple of drivers and will be removed as
> soon as patches converting them to use generic fwnode/device APIs are
> accepted.

...

> +static struct gpio_desc *gpiod_find_by_fwnode(struct fwnode_handle *fwnode,
> +					      struct device *consumer,
> +					      const char *con_id,
> +					      unsigned int idx,
> +					      enum gpiod_flags *flags,
> +					      unsigned long *lookupflags)
>  {
> -	unsigned long lflags = GPIO_LOOKUP_FLAGS_DEFAULT;

> -	struct gpio_desc *desc = ERR_PTR(-ENODEV);

Not sure why this is needed. Now I see that else branch has been changed,
but looking closer to it, we can drop it completely, while leaving this
line untouched, correct?

> -	int ret;
> +	struct gpio_desc *desc;
>  
> +	dev_dbg(consumer, "GPIO lookup for consumer %s in node '%pfw'\n",
> +		con_id, fwnode);
> +
> +	/* Using device tree? */
>  	if (is_of_node(fwnode)) {
> -		desc = gpiod_get_from_of_node(to_of_node(fwnode),
> -					      propname, index,
> -					      dflags,
> -					      label);
> -		return desc;
> +		dev_dbg(consumer, "using device tree for GPIO lookup\n");
> +		desc = of_find_gpio(to_of_node(fwnode),
> +				    con_id, idx, lookupflags);

At least con_id can be placed on the previous line.

>  	} else if (is_acpi_node(fwnode)) {
> -		desc = acpi_node_get_gpiod(fwnode, propname, index,
> -					   &lflags, &dflags);
> -		if (IS_ERR(desc))
> -			return desc;
> +		dev_dbg(consumer, "using ACPI for GPIO lookup\n");
> +		desc = acpi_find_gpio(fwnode, con_id, idx, flags, lookupflags);
>  	} else {
> -		return ERR_PTR(-EINVAL);
> +		desc = ERR_PTR(-ENOENT);
>  	}
>  
> -	/* Currently only ACPI takes this path */
> +	return desc;
> +}

...

> +	struct gpio_desc *desc = ERR_PTR(-ENOENT);
> +	unsigned long lookupflags;
> +	int ret;

> +	if (!IS_ERR_OR_NULL(fwnode))

I think this is superfluous check.

Now in the form of this series, you have only a single dev_dbg() that tries to
dereference it. Do we really need to have it there, since every branch has its
own dev_dbg() anyway?

> +		desc = gpiod_find_by_fwnode(fwnode, consumer, con_id, idx,
> +					    &flags, &lookupflags);

> +

This blank line can be dropped after addressing above.

> +	if (gpiod_not_found(desc) && platform_lookup_allowed) {
> +		/*
> +		 * Either we are not using DT or ACPI, or their lookup did not
> +		 * return a result. In that case, use platform lookup as a
> +		 * fallback.
> +		 */
> +		dev_dbg(consumer, "using lookup tables for GPIO lookup\n");
> +		desc = gpiod_find(consumer, con_id, idx, &lookupflags);
> +	}
> +
> +	if (IS_ERR(desc)) {
> +		dev_dbg(consumer, "No GPIO consumer %s found\n", con_id);
> +		return desc;
> +	}

...

> +	return gpiod_find_and_request(NULL, fwnode, con_id, index, flags, label,
> +				      false);

One line?

...

> +	return gpiod_find_and_request(dev, fwnode, con_id, idx, flags, label,
> +				      true);

One line?

-- 
With Best Regards,
Andy Shevchenko


