Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03C7C61F0F8
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 11:44:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231572AbiKGKoo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 05:44:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231501AbiKGKom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 05:44:42 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC82117E33;
        Mon,  7 Nov 2022 02:44:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667817881; x=1699353881;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5MDBSNazN+stxKATiIsjwIv/7ZUGHGTaPVJKKdrTNO4=;
  b=WAfNzR8ZeZ+NkWHWY6dwCBFDVfyv9BXwYa4pPLJb0+cowyDC3nesZFYG
   tjtMIYsLCaXxlmkQl4Di0+paP79Qxd0JyNKweWqGrxyxGsU+IboXtSDp7
   BvYnjn0nMXlMUz3LjGuCsmK9Z6nOi86Asy869pTlmUwMBj7JACOYEZHHC
   7HyFe2OKd7LfrGU6bLxGyppjpibzg/u2LYYRjOSzVX4tAnzZk1RsG5JW1
   T0WQipexHLqcWp0AQm7x4/Q4y9mYWRx/TaohOBCBZH/yWzElBlswqU8cy
   ZdJBfAdXD5LvZCVa3NXhXGc2OvXWJvabx4ohfrCBWDU0u3ZX/OZLTF4km
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10523"; a="297873426"
X-IronPort-AV: E=Sophos;i="5.96,143,1665471600"; 
   d="scan'208";a="297873426"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 02:44:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10523"; a="778442885"
X-IronPort-AV: E=Sophos;i="5.96,143,1665471600"; 
   d="scan'208";a="778442885"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP; 07 Nov 2022 02:44:39 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1orzcL-008b3M-29;
        Mon, 07 Nov 2022 12:44:37 +0200
Date:   Mon, 7 Nov 2022 12:44:37 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-acpi@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] gpiolib: consolidate GPIO lookups
Message-ID: <Y2jhlY+rnNeQ8aEk@smile.fi.intel.com>
References: <20221031-gpiolib-swnode-v1-0-a0ab48d229c7@gmail.com>
 <20221031-gpiolib-swnode-v1-5-a0ab48d229c7@gmail.com>
 <Y2VJJ8CYhGY69c/z@smile.fi.intel.com>
 <Y2Vfatm3VRGcktNN@google.com>
 <Y2V+8tiwstXbTWoq@smile.fi.intel.com>
 <Y2XtGTAjEB24tqrF@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2XtGTAjEB24tqrF@google.com>
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

On Fri, Nov 04, 2022 at 09:56:57PM -0700, Dmitry Torokhov wrote:
> On Fri, Nov 04, 2022 at 11:06:58PM +0200, Andy Shevchenko wrote:
> > On Fri, Nov 04, 2022 at 11:52:26AM -0700, Dmitry Torokhov wrote:
> > > On Fri, Nov 04, 2022 at 07:17:27PM +0200, Andy Shevchenko wrote:
> > > > On Thu, Nov 03, 2022 at 11:10:15PM -0700, Dmitry Torokhov wrote:

...

> > > > > +		desc = gpiod_find_by_fwnode(fwnode, consumer, con_id, idx,
> > > > > +					    &flags, &lookupflags);
> > 
> > Looking into drivers/base/property.c makes me realize that you might need to
> > test for error pointer as well.
> > 
> > Perhaps something like
> > 
> > 	if (IS_ERR_OR_NULL(fwnode))
> > 		return ERR_PTR(-ENOENT);
> > 
> > in the gpiod_find_by_fwnode() needs to be added. Can you check this?
> 
> No, only fwnode->secondary pointer can be PTR_ERR()-encoded.
> 
> From comment to set_primary_fwnode() in drivers/base/core.c
> 
>  * Valid fwnode cases are:
>  *  - primary --> secondary --> -ENODEV
>  *  - primary --> NULL
>  *  - secondary --> -ENODEV
>  *  - NULL
> 
> I do not believe we should be concerned about someone passing secondary
> pointers from fwnodes directly into gpiolib.

It's not only about secondary vs. primary notation, some of fwnode API calls
may return error pointer and hence entire stack should be prepared for that.

See 002752af7b89 ("device property: Allow error pointer to be passed to
fwnode APIs") as an example.

-- 
With Best Regards,
Andy Shevchenko


