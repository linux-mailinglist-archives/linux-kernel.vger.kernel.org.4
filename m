Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEEA661A2E1
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 22:07:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbiKDVHL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 17:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbiKDVHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 17:07:03 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B609E49B45;
        Fri,  4 Nov 2022 14:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667596022; x=1699132022;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/D997vsdjgzIz+4j58rEhTtFF8fMpwj1DOcdGYY+b2w=;
  b=LNL6XAV8HTh9RShiYVCq82DPrvBFfxx5YKicT4ziXhMTbwwULrXqN4E6
   CB3J1/EwPbUUnhsVB5t5+FPgBuTzxmxfHqMljJkHsEkBqQqdAhWJ6wQAd
   cOaCVIPXg8sZuK+sckMFqXLhQfWM68mlhklaKfHRYZrItE0ZNFrj1HTWw
   ymnvO99TtH3i7RexpCEiQBHiVjalqupEOdwcVFVXRCAfE3wA0HofP7zLH
   tQzacQW6K2BmUCG0P1g89eylQjlPB3ChMat3ObYLVcc1AObx7VkZ2+QTw
   3mxINM59I9dLdXG0Sgz6SZX62XkPnOsScgWzDUCJAopGXHHS7iZlQwgPE
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10521"; a="310073918"
X-IronPort-AV: E=Sophos;i="5.96,138,1665471600"; 
   d="scan'208";a="310073918"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2022 14:07:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10521"; a="666504183"
X-IronPort-AV: E=Sophos;i="5.96,138,1665471600"; 
   d="scan'208";a="666504183"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP; 04 Nov 2022 14:07:00 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1or3ty-007ZRD-1W;
        Fri, 04 Nov 2022 23:06:58 +0200
Date:   Fri, 4 Nov 2022 23:06:58 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-acpi@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] gpiolib: consolidate GPIO lookups
Message-ID: <Y2V+8tiwstXbTWoq@smile.fi.intel.com>
References: <20221031-gpiolib-swnode-v1-0-a0ab48d229c7@gmail.com>
 <20221031-gpiolib-swnode-v1-5-a0ab48d229c7@gmail.com>
 <Y2VJJ8CYhGY69c/z@smile.fi.intel.com>
 <Y2Vfatm3VRGcktNN@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2Vfatm3VRGcktNN@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 04, 2022 at 11:52:26AM -0700, Dmitry Torokhov wrote:
> On Fri, Nov 04, 2022 at 07:17:27PM +0200, Andy Shevchenko wrote:
> > On Thu, Nov 03, 2022 at 11:10:15PM -0700, Dmitry Torokhov wrote:

...

> > > +static struct gpio_desc *gpiod_find_by_fwnode(struct fwnode_handle *fwnode,
> > > +					      struct device *consumer,
> > > +					      const char *con_id,
> > > +					      unsigned int idx,
> > > +					      enum gpiod_flags *flags,
> > > +					      unsigned long *lookupflags)
> > >  {
> > 
> > > +	struct gpio_desc *desc = ERR_PTR(-ENOENT);
> > 
> > No need, just return directly.
> > 
> > > +	dev_dbg(consumer, "GPIO lookup for consumer %s in node '%s'\n",
> > > +		con_id, fwnode_get_name(fwnode));
> > 
> > %pfwP ?
> 
> OK. Although, I think I like %pfw (without 'P') better as it gives
> results like:
> 
> 	/soc/i2c@11007000/edp-bridge@8
> 
> or
> 
> 	\_SB.PCI0.I2C1.D010
> 
> which should help identifying the exact node.

I agree.

> > > +	/* Using device tree? */
> > >  	if (is_of_node(fwnode)) {
> > > +		dev_dbg(consumer, "using device tree for GPIO lookup\n");
> > > +		desc = of_find_gpio(to_of_node(fwnode),
> > > +				    con_id, idx, lookupflags);
> > >  	} else if (is_acpi_node(fwnode)) {
> > 
> > With direct return, no need for 'else' here.
> 
> When we have several branches of equal weight I prefer not to have
> early/inline returns, but I can add:
> 
> 	} else {
> 		desc = ERR_PTR(-ENOENT);
> 	}
> 
> at the end, what do you think?

No strong opinion here.

> > > +		dev_dbg(consumer, "using ACPI for GPIO lookup\n");
> > > +		desc = acpi_find_gpio(fwnode, con_id, idx, flags, lookupflags);
> > >  	}
> > >  
> > > +	return desc;
> > > +}

...

> > > +	struct gpio_desc *desc = ERR_PTR(-ENOENT);
> > 
> > We can get rid of the assignment, see below.

Still below another thought which affects this.

> > > +	if (fwnode)
> > 
> > Do we need this check?
> 
> Yes, I would prefer to have it as it clearly informs the reader that we
> are only doing lookup by node if we actually have a node.
> 
> gpiod_find_and_request() expects that it gets a valid node and in the
> followup change it will be dereferencing fwnode without checking for
> NULL-ness.

But most of the code will check for the NULL anyway. The exceptions are
dev_dbg() and accessing to the secondary fwnode.

> > Debug message above (when %pfw is used) would be even useful when
> > fwnode == NULL.

> > > +		desc = gpiod_find_by_fwnode(fwnode, consumer, con_id, idx,
> > > +					    &flags, &lookupflags);

Looking into drivers/base/property.c makes me realize that you might need to
test for error pointer as well.

Perhaps something like

	if (IS_ERR_OR_NULL(fwnode))
		return ERR_PTR(-ENOENT);

in the gpiod_find_by_fwnode() needs to be added. Can you check this?

-- 
With Best Regards,
Andy Shevchenko


