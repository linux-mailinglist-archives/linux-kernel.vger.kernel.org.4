Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A23AB620B5E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 09:42:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233480AbiKHIm1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 03:42:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233358AbiKHImY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 03:42:24 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A20913CD0;
        Tue,  8 Nov 2022 00:42:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667896943; x=1699432943;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5kVqInTilwcBMCkk5iipAl+y1Yp4AvfbYxM7E8TDBYA=;
  b=MXHWf1iIpR15ZGnzGTnW10RhF8EpUXb5/D9XD1D+YPabIWeDtnLFE72q
   nmNk2F7R9wPU3gh9DMFhT4Vwrqpd7xK31j40HLx0xXPJvBxjaEJa8TN6H
   1TGjQVK2Hwq/LFnrDlvQCv57/BFWwxzWNuuN7Ml8DV6fMDxrvg40501UN
   jS5VkGnGlTzhsB2eih4zPSspc0vFn/oLifxE5uJ/CJbZz+zi9MXa0sJw0
   PaQeb1LIEKgx+idAk5aoQ/pt9knQIetu0cByJP5fvt88eGd6++BJKToS9
   6pDL+dAwVyXihY5G47uIbDr2T7s/07mRPEQVQuodgrethcDLoTjyjm1oy
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="311797842"
X-IronPort-AV: E=Sophos;i="5.96,147,1665471600"; 
   d="scan'208";a="311797842"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 00:41:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="741865519"
X-IronPort-AV: E=Sophos;i="5.96,147,1665471600"; 
   d="scan'208";a="741865519"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP; 08 Nov 2022 00:41:44 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1osKAx-0092v7-08;
        Tue, 08 Nov 2022 10:41:43 +0200
Date:   Tue, 8 Nov 2022 10:41:42 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 2/2] gpiolib: of: Integrate
 of_gpiochip_init_valid_mask() into gpiochip_init_valid_mask()
Message-ID: <Y2oWRofuTzPbzHdE@smile.fi.intel.com>
References: <20221107161027.43384-1-andriy.shevchenko@linux.intel.com>
 <20221107161027.43384-2-andriy.shevchenko@linux.intel.com>
 <Y2lMdQ/bE2w4skOO@google.com>
 <Y2lz/4wEDYnaIJF/@smile.fi.intel.com>
 <Y2l7ZRe7+wb9YkEm@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2l7ZRe7+wb9YkEm@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2022 at 01:40:53PM -0800, Dmitry Torokhov wrote:
> On Mon, Nov 07, 2022 at 11:09:19PM +0200, Andy Shevchenko wrote:
> > On Mon, Nov 07, 2022 at 10:20:37AM -0800, Dmitry Torokhov wrote:
> > > On Mon, Nov 07, 2022 at 06:10:27PM +0200, Andy Shevchenko wrote:

...

> > > > +static int gpiochip_apply_reserved_ranges(struct gpio_chip *gc, unsigned int sz)
> > > > +{
> > > > +	u32 *ranges;
> > > > +	int ret;
> > > > +
> > > > +	ranges = kmalloc_array(sz, sizeof(*ranges), GFP_KERNEL);
> > > > +	if (!ranges)
> > > > +		return -ENOMEM;
> > > > +
> > > > +	ret = fwnode_property_read_u32_array(gc->fwnode, "gpio-reserved-ranges", ranges, sz);
> > > > +	if (ret) {
> > > > +		kfree(ranges);
> > > > +		return ret;
> > > > +	}
> > > > +
> > > > +	while (sz) {
> > > > +		u32 count = ranges[--sz];
> > > > +		u32 start = ranges[--sz];
> > > 
> > > I know we checked sz validity, but I wonder if re-checking it in this
> > > function would not insulate us from errors creeping in after some other
> > > code refactoring.
> > 
> > I'm not sure I understand what you meant. The fwnode_property_read_u32_array()
> > will fail if the given sz is too big for the real data, so while (sz) would
> > never even go on the invalid data.
> 
> I am more worried about sz being odd and the loop ending up trying to
> dereference ranges[-1].

I see. What if we take amount of ranges as the parameter and convert to size by
multiplying by 2?

-- 
With Best Regards,
Andy Shevchenko


