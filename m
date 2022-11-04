Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC56D619F72
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 19:08:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbiKDSIQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 14:08:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiKDSIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 14:08:12 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03B1B2AE26;
        Fri,  4 Nov 2022 11:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667585291; x=1699121291;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zNHEcvSskJAUK54MphoYaB9GZqt7VYoOfB3nL+MgM4A=;
  b=RX2ZnH0tWIAAl4jTU8fCa1swujNlFauPSuwe3RJ5yvRxLpKOUkCbGn0k
   jIs5cighHI2n+P7LPUlxS/g7yY5N1dIpI38nvV4U/3h3t2XAnlGK6a/ai
   uCrQxh4sA8i4fZe+Z+XqqRrBaDf4M3sHXYL4NHCQjUEYRillf49D+EtJC
   Mm+9oWDpum125knyiWDKwIvyCviZFqNSM5knwGL69C/0NOkhGhGBSNddq
   L41hJJ8hYX6SuH7XZuEvo7ni5ZKN/2hUDvHdHK9okXua83xg1/qasxgQK
   Tfg9CrfBXafQdsEto6ztSlSfxId2hsxrK851cw4hjJ5Zebl6J5IerAkuA
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10521"; a="307656670"
X-IronPort-AV: E=Sophos;i="5.96,138,1665471600"; 
   d="scan'208";a="307656670"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2022 11:08:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10521"; a="760411612"
X-IronPort-AV: E=Sophos;i="5.96,138,1665471600"; 
   d="scan'208";a="760411612"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP; 04 Nov 2022 11:08:05 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1or16p-007Thj-2s;
        Fri, 04 Nov 2022 20:08:03 +0200
Date:   Fri, 4 Nov 2022 20:08:03 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-acpi@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] gpiolib: add support for software nodes
Message-ID: <Y2VVA2Wp1IWoJf3m@smile.fi.intel.com>
References: <20221031-gpiolib-swnode-v1-0-a0ab48d229c7@gmail.com>
 <20221031-gpiolib-swnode-v1-6-a0ab48d229c7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221031-gpiolib-swnode-v1-6-a0ab48d229c7@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 03, 2022 at 11:10:16PM -0700, Dmitry Torokhov wrote:
> Now that static device properties understand notion of child nodes and
> references, let's teach gpiolib to handle them:
> 
> - GPIOs are represented as a references to software nodes representing
>   gpiochip
> - references must have 2 arguments - GPIO number within the chip and
>   GPIO flags (GPIO_ACTIVE_LOW/GPIO_ACTIVE_HIGH, etc).
> - name of the software node representing gpiochip must match label of
>   the gpiochip, as we use it to locate gpiochip structure at runtime.
> 
> const struct software_node gpio_bank_b_node = {
> 	.name = "B",
> };
> 
> const struct property_entry simone_key_enter_props[] __initconst = {
> 	PROPERTY_ENTRY_U32("linux,code", KEY_ENTER),

> 	PROPERTY_ENTRY_STRING("label", "enter"),
> 	PROPERTY_ENTRY_REF("gpios", &gpio_bank_b_node, 123, GPIO_ACTIVE_LOW),

Okay, can we have an example for something like reset-gpios? Because from
the above I can't easily get what label is and how in the `gpioinfo` tool
the requested line will look like.

> 	{ }
> };

...

> +#include <linux/err.h>
> +#include <linux/errno.h>
> +#include <linux/gpio/consumer.h>

It seems you are using much more that these ones.

...

> +	char prop_name[32]; /* 32 is max size of property name */

Why is it not defined then?

...

> +	/*
> +	 * Note we do not need to try both -gpios and -gpio suffixes,
> +	 * as, unlike OF and ACPI, we can fix software nodes to conform
> +	 * to the proper binding.
> +	 */

True, but for the sake of consistency between providers perhaps it makes sense
to check that as well. Dunno, up to Linus and Bart to decide.

...

> +	/*
> +	 * We expect all swnode-described GPIOs have GPIO number and
> +	 * polarity arguments, hence nargs is set to 2.
> +	 */

Maybe instead you can provide a custom macro wrapper that will check the number
of arguments at compile time?

...

> +		pr_debug("%s: can't parse '%s' property of node '%pfwP[%d]'\n",
> +			__func__, prop_name, fwnode, idx);

__func__ is not needed. Dynamic Debug can automatically add it.
Since you have an fwnode, use that as a marker.

...

> +	chip = gpiochip_find((void *)chip_node->name,
> +			     swnode_gpiochip_match_name);

One line?

...

> +	pr_debug("%s: parsed '%s' property of node '%pfwP[%d]' - status (%d)\n",
> +		 __func__, prop_name, fwnode, idx, PTR_ERR_OR_ZERO(desc));

Same as above.

...

> +	char prop_name[32];

> +	if (con_id)
> +		snprintf(prop_name, sizeof(prop_name), "%s-gpios", con_id);
> +	else
> +		strscpy(prop_name, "gpios", sizeof(prop_name));

I saw this code, please deduplicate.

...

> +	/*
> +	 * This is not very efficient, but GPIO lists usually have only
> +	 * 1 or 2 entries.
> +	 */
> +	count = 0;
> +	while (fwnode_property_get_reference_args(fwnode, prop_name, NULL,
> +						  0, count, &args) == 0)

I would put it into for loop (and looking into property.h I think propname
is fine variable name):

	for (count = 0; ; count++) {
		if (fwnode_property_get_reference_args(fwnode, propname, NULL, 0, count, &args))
			break;
	}

Btw, what about reference counting? Do we need to care about it?

> +	return count ? count : -ENOENT;

Elvis would work as well.

	return count ?: -ENOENT;


...

> +struct fwnode_handle;

struct gpio_desc;

> +
> +struct gpio_desc *swnode_find_gpio(struct fwnode_handle *fwnode,
> +				   const char *con_id, unsigned int idx,
> +				   unsigned long *flags);
> +int swnode_gpio_count(struct fwnode_handle *fwnode, const char *con_id);

...

> +	/*
> +	 * First look up GPIO in the secondary software node in case
> +	 * it was used to store updated properties.

Why this is done first? We don't try secondary before we have checked primary.

> +	 */

> +	if (is_software_node(fwnode->secondary)) {

With the previous comments it would become

	if (fwnode && is_...)

> +		dev_dbg(consumer,
> +			"using secondary software node for GPIO lookup\n");
> +		desc = swnode_find_gpio(fwnode->secondary,
> +					con_id, idx, lookupflags);
> +		if (!gpiod_not_found(desc))
> +			return desc;
> +	}

...

>  int gpiod_count(struct device *dev, const char *con_id)
>  {
> +	struct fwnode_handle *fwnode = dev ? dev_fwnode(dev) : NULL;
> +	int count;
> +
> +	/*
> +	 * First look up GPIO in the secondary software node in case
> +	 * it was used to store updated properties.
> +	 */

Same question as above.

> +	if (!IS_ERR_OR_NULL(fwnode) && is_software_node(fwnode->secondary)) {
> +		count = swnode_gpio_count(fwnode->secondary, con_id);
> +		if (count > 0)
> +			return count;
> +	}
>  
>  	if (is_of_node(fwnode))
>  		count = of_gpio_get_count(dev, con_id);
>  	else if (is_acpi_node(fwnode))
>  		count = acpi_gpio_count(dev, con_id);
> +	else if (is_software_node(fwnode))
> +		count = swnode_gpio_count(fwnode, con_id);
> +	else
> +		count = -ENOENT;
>  
>  	if (count < 0)
>  		count = platform_gpio_count(dev, con_id);

-- 
With Best Regards,
Andy Shevchenko


