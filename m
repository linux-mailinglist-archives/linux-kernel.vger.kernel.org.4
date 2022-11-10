Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18E50624374
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 14:43:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbiKJNnM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 08:43:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231218AbiKJNm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 08:42:58 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 954D76B23A;
        Thu, 10 Nov 2022 05:42:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668087777; x=1699623777;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fTAuXuJ4jKin+JcE3huOPfi/0se7PcE3kuFaiJBuDfk=;
  b=OrrVuKXXi+XOmoDwAgOYFIJRWmm8LFslRUJMgu/doWwzdM8TIu/+zT75
   BRsotRJpL37k9D25Yx9gbJm2h6LqB5Kt1+gXdwYZ2PGvBsTTAQkw8YSqU
   OJS2mxTixbl7mrRqVwfpulstOpvkQ3B5BNDls5Zdvl8vIfv3Jca3ct+Us
   8k12Osojnjvzf1qv/ff0z+4E23CLaiaO2CC4GPaTNHMUcYOxCmZm54Yf/
   YSfRMB70/OXpEm/bGd/CB1qS+p7aBInh/tgeFoQczFnAJSX2t3r3MGsTB
   gzK3Sz6wNEgkIsQ36Fw60zr1phWwKrpPlbQWj9CNCKEYvuZQwWEsh4v9V
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="308932359"
X-IronPort-AV: E=Sophos;i="5.96,153,1665471600"; 
   d="scan'208";a="308932359"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2022 05:42:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="588177624"
X-IronPort-AV: E=Sophos;i="5.96,153,1665471600"; 
   d="scan'208";a="588177624"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP; 10 Nov 2022 05:42:42 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ot7pJ-00A9hz-12;
        Thu, 10 Nov 2022 15:42:41 +0200
Date:   Thu, 10 Nov 2022 15:42:40 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-acpi@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/6] gpiolib: consolidate GPIO lookups
Message-ID: <Y2z/0IUOQMSonASw@smile.fi.intel.com>
References: <20221031-gpiolib-swnode-v2-0-81f55af5fa0e@gmail.com>
 <20221031-gpiolib-swnode-v2-5-81f55af5fa0e@gmail.com>
 <Y2uOEhib5dvIcobF@smile.fi.intel.com>
 <Y2v4ze4y8qDThjrv@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2v4ze4y8qDThjrv@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 09, 2022 at 11:00:29AM -0800, Dmitry Torokhov wrote:
> On Wed, Nov 09, 2022 at 01:25:06PM +0200, Andy Shevchenko wrote:
> > On Tue, Nov 08, 2022 at 04:26:50PM -0800, Dmitry Torokhov wrote:

...

> > > +static struct gpio_desc *gpiod_find_by_fwnode(struct fwnode_handle *fwnode,
> > > +					      struct device *consumer,
> > > +					      const char *con_id,
> > > +					      unsigned int idx,
> > > +					      enum gpiod_flags *flags,
> > > +					      unsigned long *lookupflags)
> > >  {
> > > -	unsigned long lflags = GPIO_LOOKUP_FLAGS_DEFAULT;
> > 
> > > -	struct gpio_desc *desc = ERR_PTR(-ENODEV);
> > 
> > Not sure why this is needed. Now I see that else branch has been changed,
> > but looking closer to it, we can drop it completely, while leaving this
> > line untouched, correct?
> 
> Yes. I believe removing an initializer and doing a series of if/else
> if/else was discussed and [soft] agreed-on in the previous review cycle,
> but I can change it back.
> 
> I think we still need to have it return -ENOENT and not -ENODEV/-EINVAL
> so that we can fall back to GPIO lookup tables when dealing with an
> unsupported node type.

Right, okay, let's go with whatever variant you find better.

...

> > > +	if (!IS_ERR_OR_NULL(fwnode))
> > 
> > I think this is superfluous check.
> > 
> > Now in the form of this series, you have only a single dev_dbg() that tries to
> > dereference it. Do we really need to have it there, since every branch has its
> > own dev_dbg() anyway?
> 
> As I mentioned, I like to keep this check to show the reader that we
> should only descend into gpiod_find_by_fwnode() if we have a valid
> fwnode. It is less about code generation and more about the intent.

Yes, but if fwnode is not found, we have a next check for that. I really don't
think we lose anything by dropping the check and gaining the code generation as
a side effect.

-- 
With Best Regards,
Andy Shevchenko


