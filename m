Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D7C7619E52
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 18:17:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231794AbiKDRRw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 13:17:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231756AbiKDRRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 13:17:33 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA2A842F4E;
        Fri,  4 Nov 2022 10:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667582251; x=1699118251;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WgIQx6ItQN2BeraUn6yfs2aWC/9lQldfAk5Z+hzj/fo=;
  b=fyUeHYKgo4a4p5EmcFycRi4SX96uiC+pe1a1b7PeYjBxBQmRZXUEO5fi
   sI6C5WTRYbwXPNKC0dZqb10EjFENB+YsCjRHgtaLHY7FpQMkxvJScLSB3
   1mEHGnvKk4bF96TFRi0tLaZIPwLdwoBj0lDXJoHoSGVI4zCxkwj8CCDSz
   Cdge3WTIBf4BzMlhoxG/PehrqSIR2m/dIXSPB3gwZMyIMitf+aCzsrUj3
   fRMEQ16hUYDOLDQVzKHL2d1O4jD9T9aCC70LOv4RIlsYNR2NVr63r5ypG
   l30woRefiL9JnsCcY5rkNu6AP8Xebn7Mee5KnZ0A+Cct/q5fP+bFrH8cn
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10521"; a="311768225"
X-IronPort-AV: E=Sophos;i="5.96,138,1665471600"; 
   d="scan'208";a="311768225"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2022 10:17:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10521"; a="668427097"
X-IronPort-AV: E=Sophos;i="5.96,138,1665471600"; 
   d="scan'208";a="668427097"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP; 04 Nov 2022 10:17:29 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1or0Js-007SvW-0G;
        Fri, 04 Nov 2022 19:17:28 +0200
Date:   Fri, 4 Nov 2022 19:17:27 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-acpi@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] gpiolib: consolidate GPIO lookups
Message-ID: <Y2VJJ8CYhGY69c/z@smile.fi.intel.com>
References: <20221031-gpiolib-swnode-v1-0-a0ab48d229c7@gmail.com>
 <20221031-gpiolib-swnode-v1-5-a0ab48d229c7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221031-gpiolib-swnode-v1-5-a0ab48d229c7@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 03, 2022 at 11:10:15PM -0700, Dmitry Torokhov wrote:
> Ensure that all paths to obtain/look up GPIOD from generic
> consumer-visible APIs go through the new gpiod_find_and_request()
> helper, so that we can easily extend it with support for new firmware
> mechanisms.

...

> +static struct gpio_desc *gpiod_find_by_fwnode(struct fwnode_handle *fwnode,
> +					      struct device *consumer,
> +					      const char *con_id,
> +					      unsigned int idx,
> +					      enum gpiod_flags *flags,
> +					      unsigned long *lookupflags)
>  {

> +	struct gpio_desc *desc = ERR_PTR(-ENOENT);

No need, just return directly.

> +	dev_dbg(consumer, "GPIO lookup for consumer %s in node '%s'\n",
> +		con_id, fwnode_get_name(fwnode));

%pfwP ?

> +
> +	/* Using device tree? */
>  	if (is_of_node(fwnode)) {
> +		dev_dbg(consumer, "using device tree for GPIO lookup\n");
> +		desc = of_find_gpio(to_of_node(fwnode),
> +				    con_id, idx, lookupflags);
>  	} else if (is_acpi_node(fwnode)) {

With direct return, no need for 'else' here.

> +		dev_dbg(consumer, "using ACPI for GPIO lookup\n");
> +		desc = acpi_find_gpio(fwnode, con_id, idx, flags, lookupflags);
>  	}
>  
> +	return desc;
> +}

...

> +static struct gpio_desc *gpiod_find_and_request(struct device *consumer,
> +						struct fwnode_handle *fwnode,
> +						const char *con_id,
> +						unsigned int idx,
> +						enum gpiod_flags flags,
> +						const char *label,
> +						bool platform_lookup_allowed)
> +{

> +	struct gpio_desc *desc = ERR_PTR(-ENOENT);

We can get rid of the assignment, see below.


> +	unsigned long lookupflags;
> +	int ret;

> +	if (fwnode)

Do we need this check?

Debug message above (when %pfw is used) would be even useful when
fwnode == NULL.

> +		desc = gpiod_find_by_fwnode(fwnode, consumer, con_id, idx,
> +					    &flags, &lookupflags);

> +

The blank line can be removed after above comments being addressed.

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
> +
> +	/*
> +	 * If a connection label was passed use that, else attempt to use
> +	 * the device name as label
> +	 */
>  	ret = gpiod_request(desc, label);
> +	if (ret) {
> +		if (!(ret == -EBUSY && flags & GPIOD_FLAGS_BIT_NONEXCLUSIVE))
> +			return ERR_PTR(ret);
> +
> +		/*
> +		 * This happens when there are several consumers for
> +		 * the same GPIO line: we just return here without
> +		 * further initialization. It is a bit of a hack.
> +		 * This is necessary to support fixed regulators.
> +		 *
> +		 * FIXME: Make this more sane and safe.
> +		 */

> +		dev_info(consumer,
> +			 "nonexclusive access to GPIO for %s\n", con_id);

Cam be one line.

> +		return desc;
> +	}
>  
> +	ret = gpiod_configure_flags(desc, con_id, lookupflags, flags);
>  	if (ret < 0) {
> +		dev_dbg(consumer, "setup of GPIO %s failed\n", con_id);
>  		gpiod_put(desc);
>  		return ERR_PTR(ret);
>  	}

...

>  struct gpio_desc *fwnode_gpiod_get_index(struct fwnode_handle *fwnode,
> +					 const char *con_id,
> +					 int index,
>  					 enum gpiod_flags flags,
>  					 const char *label)
>  {
>  

Unnecessary blank line?

> +	return gpiod_find_and_request(NULL, fwnode, con_id, index, flags, label,
> +				      false);

Can be one line.

>  }

...


> +	return gpiod_find_and_request(dev, fwnode, con_id, idx, flags, label,
> +				      true);

Ditto.

-- 
With Best Regards,
Andy Shevchenko


