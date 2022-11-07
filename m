Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C83756200A1
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 22:13:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233427AbiKGVNC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 16:13:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233398AbiKGVMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 16:12:40 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E26B32CE21;
        Mon,  7 Nov 2022 13:09:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667855383; x=1699391383;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HTsBKVww/lBiHbmW5CXHOsngpI27SY25t3BgTeA8cZE=;
  b=eS2O9daLUJ8MdSXAe7eSYpbg3D65//08lWn6su+cBocbVuBpyMZYUmsN
   V5SM1ZdE8wbYp4F6mIqfxvvyL/96Eaj9e0Ze6ylk+Q24AdDs+DP9wNc1s
   fQ03z9cqSseemxG9RXLigUaq/oWBsfUAaeags0HZQ3eMl12haN26k35Lv
   EUkMV/JGXTYMtVB6zLRWYPR8YhnD0fqxUsviVr7Y3kDOKmgjoDn1VYh4Y
   RcDo0rotVsH1L9Mg8Gty6K/wSPKCGUoxF0vg+95pQC8yynEreEkTR4iJC
   bYMwtJRSfC2tqo7OHkhVc0ArTb+0G4rCLlBIKvrayMqBV+/SOxgmedIcR
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="372665387"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="372665387"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 13:09:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="669292614"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="669292614"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP; 07 Nov 2022 13:09:21 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1os9Mt-008pqW-1P;
        Mon, 07 Nov 2022 23:09:19 +0200
Date:   Mon, 7 Nov 2022 23:09:19 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 2/2] gpiolib: of: Integrate
 of_gpiochip_init_valid_mask() into gpiochip_init_valid_mask()
Message-ID: <Y2lz/4wEDYnaIJF/@smile.fi.intel.com>
References: <20221107161027.43384-1-andriy.shevchenko@linux.intel.com>
 <20221107161027.43384-2-andriy.shevchenko@linux.intel.com>
 <Y2lMdQ/bE2w4skOO@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2lMdQ/bE2w4skOO@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2022 at 10:20:37AM -0800, Dmitry Torokhov wrote:
> On Mon, Nov 07, 2022 at 06:10:27PM +0200, Andy Shevchenko wrote:
> > +static unsigned int gpiochip_count_reserved_ranges(struct gpio_chip *gc)
> > +{
> > +	int size;
> > +
> > +	size = fwnode_property_count_u32(gc->fwnode, "gpio-reserved-ranges");
> 
> I wonder if a comment why we need even size would not be helpful.

Was it in the original code?
Anyway, if Bart thinks so as well, I may add it in v2.

> > +	if (size > 0 && size % 2 == 0)
> > +		return size;
> > +
> > +	return 0;
> > +}
> > +
> >  static int gpiochip_alloc_valid_mask(struct gpio_chip *gc)
> >  {
> > -	if (!(of_gpio_need_valid_mask(gc) || gc->init_valid_mask))
> > +	if (!(gpiochip_count_reserved_ranges(gc) || gc->init_valid_mask))
> >  		return 0;
> >  
> >  	gc->valid_mask = gpiochip_allocate_mask(gc);
> > @@ -457,8 +468,47 @@ static int gpiochip_alloc_valid_mask(struct gpio_chip *gc)
> >  	return 0;
> >  }
> >  
> > +static int gpiochip_apply_reserved_ranges(struct gpio_chip *gc, unsigned int sz)
> > +{
> > +	u32 *ranges;
> > +	int ret;
> > +
> > +	ranges = kmalloc_array(sz, sizeof(*ranges), GFP_KERNEL);
> > +	if (!ranges)
> > +		return -ENOMEM;
> > +
> > +	ret = fwnode_property_read_u32_array(gc->fwnode, "gpio-reserved-ranges", ranges, sz);
> > +	if (ret) {
> > +		kfree(ranges);
> > +		return ret;
> > +	}
> > +
> > +	while (sz) {
> > +		u32 count = ranges[--sz];
> > +		u32 start = ranges[--sz];
> 
> I know we checked sz validity, but I wonder if re-checking it in this
> function would not insulate us from errors creeping in after some other
> code refactoring.

I'm not sure I understand what you meant. The fwnode_property_read_u32_array()
will fail if the given sz is too big for the real data, so while (sz) would
never even go on the invalid data.

> In any case,
> 
> Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Thank you!

-- 
With Best Regards,
Andy Shevchenko


