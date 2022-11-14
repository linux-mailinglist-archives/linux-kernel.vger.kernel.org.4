Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FD81628101
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 14:15:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237024AbiKNNPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 08:15:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236006AbiKNNPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 08:15:03 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECE6863B3;
        Mon, 14 Nov 2022 05:15:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668431702; x=1699967702;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ya4IJduoXapA85hp2rSgUfdmDE9v4JyPdYLuxuYPiSc=;
  b=nriKFfI56UInivaLLaFOH2BGzw6AbFwQdOnaQBZNuWzSVHIdYiD5e8rm
   TA9iUYKxF/Dv4wqkkicZuGbUinjeHAnxLFrn+A438xrL99cF31PE2hocG
   G/4lb3nEx3Tx+F7F596J8G4xo1lkeP4it1BAOpw/PRQnU6rYpQ2NLUV80
   ju2lLK7nYAL7+LNTUPDqRePbF7q8nE3pm3q9j8jvRj7SrzUpiLgT3fhYh
   Dlb+G0ENwT4ly2hpAgcj8EDW6WNVZj7iokyiJHavL6novD/8tIOR8ShuJ
   sh7ADz5JCCiICP+AWK0+YhCT2xkLiT4KVnTmDFp9Le9nFVylbJqUyJ8L/
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="299482303"
X-IronPort-AV: E=Sophos;i="5.96,161,1665471600"; 
   d="scan'208";a="299482303"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 05:15:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="780919340"
X-IronPort-AV: E=Sophos;i="5.96,161,1665471600"; 
   d="scan'208";a="780919340"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP; 14 Nov 2022 05:15:00 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ouZIg-00CBDR-1h;
        Mon, 14 Nov 2022 15:14:58 +0200
Date:   Mon, 14 Nov 2022 15:14:58 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        michael@walle.cc, broonie@kernel.org
Subject: Re: [PATCH v2 4/4] gpio: i8255: Migrate to regmap API
Message-ID: <Y3I/UsI2wyNSybux@smile.fi.intel.com>
References: <cover.1668129763.git.william.gray@linaro.org>
 <61327a67cc308af413471a69a4810b2785e53e8e.1668129763.git.william.gray@linaro.org>
 <Y3Dol6rHduFNQT85@smile.fi.intel.com>
 <Y3D6Lji9bKeSbJaI@fedora>
 <Y3D7jipyk5L655AE@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3D7jipyk5L655AE@fedora>
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

On Sun, Nov 13, 2022 at 09:13:34AM -0500, William Breathitt Gray wrote:
> On Sun, Nov 13, 2022 at 09:07:42AM -0500, William Breathitt Gray wrote:
> > On Sun, Nov 13, 2022 at 02:52:39PM +0200, Andy Shevchenko wrote:
> > > On Thu, Nov 10, 2022 at 08:55:53PM -0500, William Breathitt Gray wrote:

...

> > > >  drivers/gpio/gpio-104-dio-48e.c | 397 ++++++++++-------------------
> > > >  drivers/gpio/gpio-gpio-mm.c     | 151 +++--------
> > > >  drivers/gpio/gpio-i8255.c       | 429 +++++++++++---------------------
> > > >  drivers/gpio/gpio-i8255.h       |  80 +++---
> > > 
> > > Can we actually split this to a few steps:
> > >  - providing gpio-i8255-regmap
> > >  - providing gpio-mm-regmap
> > >  - converting the driver
> > >  - removing not used modules (one by one)
> > > ?
> > > 
> > > In this case if any regression somewhere appears, we can always perform a
> > > (semi-)revert for a certain driver.
> > 
> > Sure, I can split the regmap_irq migration for 104-dio-48e into a
> > separate precursor patch to reduce the amount of changes we see here and
> > provide a revert path for these IRQ changes. I can do a similar change
> > for 104-idi-48 as well.
> > 
> > The rest of the changes for 104-dio-48 and gpio-mm are essentially just
> > the regmap configurations, so the patch will be largely identical even
> > if we migrate gpio-i8255 to regmap API first before migrating again to
> > the gpio_regmap in a second patch.
> 
> Sorry, I realize now that you meant to split the i8255 gpio_regmap
> additions to their own patch, perform the driver migrations in the own
> respective patches, and then finally remove the dangling unused i8255
> functions and structures. Yes I think that would make for a cleaner
> patch series so I'll split it up that way.

Yes, that's what I meant. Thank you!

-- 
With Best Regards,
Andy Shevchenko


