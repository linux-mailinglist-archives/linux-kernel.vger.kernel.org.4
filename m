Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D877A5C0030
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 16:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbiIUOof (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 10:44:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbiIUOoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 10:44:18 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D71E7979D6;
        Wed, 21 Sep 2022 07:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663771452; x=1695307452;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PzDPq9dHEadZ3ppTnShYkGzdGPGSMZ/Ld+bPiejZucY=;
  b=ekWhMOlyoIMdxcfLg6By2Pfo0wr9/RvTV6uoLOeFDNK9KZtyxRPPQV5t
   sCcJuDjJWJa1yb8ElzRpFjPs3tRHCpK43VoqtLDNsHctUaJiOEhK0ih7+
   hOM4p+g62z7zTJ3wZcemojDELyucrVAvkHyFox965PwEXH3/mC9b4z3en
   SsmYUR72Gj0uxR/t10ZBdAuGZMTOWAK9eAWUNbFkIDzxZ9HEnJ5AupmdR
   qCCSLRqxPK9d6/Juhm+yOmoWLvBLSSqegFbrJlmizMuf86h/mZTZP8jLL
   QW4kJhnYPkL5+dke/75txjk6VU8b4h6z+ZctinhkfUd1bBUgQTgXxwHSI
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10477"; a="361779948"
X-IronPort-AV: E=Sophos;i="5.93,333,1654585200"; 
   d="scan'208";a="361779948"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2022 07:44:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,333,1654585200"; 
   d="scan'208";a="652556403"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP; 21 Sep 2022 07:44:09 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ob0xM-005awr-11;
        Wed, 21 Sep 2022 17:44:08 +0300
Date:   Wed, 21 Sep 2022 17:44:08 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpiolib: cdev: add fdinfo output for line request file
 descriptors
Message-ID: <YysjOJpsZkpdDx7W@smile.fi.intel.com>
References: <20220920135435.15593-1-brgl@bgdev.pl>
 <Yyn2HEBPPWlJ3E0W@smile.fi.intel.com>
 <CAMRc=McjOhUBa0QQbZYh0f_2rN=ESxAtPROAzXEt+KNDJKqWiQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMRc=McjOhUBa0QQbZYh0f_2rN=ESxAtPROAzXEt+KNDJKqWiQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 20, 2022 at 10:35:25PM +0200, Bartosz Golaszewski wrote:
> On Tue, Sep 20, 2022 at 7:19 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Tue, Sep 20, 2022 at 03:54:35PM +0200, Bartosz Golaszewski wrote:

...

> > > +     seq_printf(out, "gpio-device:\t%s\n", dev_name(dev));
> > > +
> > > +     for (i = 0; i < lr->num_lines; i++)
> > > +             seq_printf(out, "gpio-line:\t%d\n",
> > > +                        gpio_chip_hwgpio(lr->lines[i].desc));
> >
> > Hmm... Not sure which variant is better (as for machine parsing and for human),
> > but I was thinking of
> 
> IMO it's pretty clear that the variant in this patch is easier for
> machine parsing - one less tokenization.

For human it's harder in my opinion... But okay.

> >         gpio-lines: 1,4,6, ...
> >
> > Also don't forget that sizes over PAGE_SIZE in sysfs sometimes problematic and
> > racy.(the commit 888be6067b97 ("ACPI: sysfs: Fix a buffer overrun problem with
> > description_show()") for the reference).
> 
> In most systems PAGE_SIZE will be at least 4096 bytes. With this patch
> a single "gpio-line:\t65535\n" is at most 17 bytes long x max 64 lines
> = 1088 bytes. We're still way below the size where it would be
> problematic.

Okay, for now it's 64, but it will be problematic starting from ~300 requested
lines. Also, in case we add something more, who knows?

-- 
With Best Regards,
Andy Shevchenko


