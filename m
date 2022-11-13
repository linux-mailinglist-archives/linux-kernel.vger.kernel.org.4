Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1A60626FA2
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 14:07:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235318AbiKMNH5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 08:07:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233794AbiKMNH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 08:07:56 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64EBD2DE4;
        Sun, 13 Nov 2022 05:07:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668344875; x=1699880875;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6w4/HuZSKBn1ULdEYMPCcnr1BIe4XuqcxBf8rpKCE70=;
  b=S3HyHrzJ4AW5+pz7+nudTwCvRMWhAwb4QU5rZJsy/OmQyQAAy9PDn2ES
   NiG0ypPE7llyPB3jE15f5MsONUez41nnk2I6Jlhgo7At6z8SsWfI6SlB3
   +KR906Ni6TgAm2sRwpta5jA+rvhSdMA42yu1LimmXm+l4SKo9yF30RCis
   FrsFwgQmaFA/FBBqByRLnfd5QAO9txfbIVlJe637VfAFAV/hwoqfH22gH
   gMLSMozHr6vhGjj5zQh5RKy81ZOMDP31ME9O3fXEoRWm1H+y74hAleVWW
   J9yLpzowi0gGQ+Y05pFs7YlYzGpIet994r729akVCLvFxb5oND5rsRf2U
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10529"; a="310519815"
X-IronPort-AV: E=Sophos;i="5.96,161,1665471600"; 
   d="scan'208";a="310519815"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2022 05:07:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10529"; a="638120509"
X-IronPort-AV: E=Sophos;i="5.96,161,1665471600"; 
   d="scan'208";a="638120509"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP; 13 Nov 2022 05:07:52 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ouCiF-00BgY5-10;
        Sun, 13 Nov 2022 15:07:51 +0200
Date:   Sun, 13 Nov 2022 15:07:50 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH v4 5/6] gpiolib: consolidate GPIO lookups
Message-ID: <Y3DsJubv/t0nDCa7@smile.fi.intel.com>
References: <20221031-gpiolib-swnode-v4-0-6c1671890027@gmail.com>
 <20221031-gpiolib-swnode-v4-5-6c1671890027@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221031-gpiolib-swnode-v4-5-6c1671890027@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 11, 2022 at 02:19:07PM -0800, Dmitry Torokhov wrote:
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

> +static struct gpio_desc *gpiod_find_and_request(struct device *consumer,
> +						struct fwnode_handle *fwnode,
> +						const char *con_id,
> +						unsigned int idx,
> +						enum gpiod_flags flags,
> +						const char *label,
> +						bool platform_lookup_allowed)
> +{
> +	struct gpio_desc *desc = ERR_PTR(-ENOENT);
> +	unsigned long lookupflags;
> +	int ret;

> +	if (!IS_ERR_OR_NULL(fwnode))

Just for the record. I haven't given my tag to this patch, because I think that
the above check (and respective assignment above) are redundant. Even comment
inside the below condition clarifies the point of the meaning of descriptor
being not found. Besides that many of device property APIs designed the way
that input fwnode can be invalid.

Nevertheless, we agreed with Dmitry that this disagreement should be solved on
maintainer's level, while it doesn't affect code functionality.

The rest of the patch is fine.

> +		desc = gpiod_find_by_fwnode(fwnode, consumer, con_id, idx,
> +					    &flags, &lookupflags);
> +
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

-- 
With Best Regards,
Andy Shevchenko


