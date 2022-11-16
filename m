Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A392362C098
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 15:10:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233770AbiKPOKt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 09:10:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbiKPOKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 09:10:23 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FBC610F1;
        Wed, 16 Nov 2022 06:09:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668607796; x=1700143796;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PTFTwy9am/rL9bfTGp21MH6S3HdH2Uspt6lqcCj4nEc=;
  b=lhu+kwbpWaEoo9lrzmI6GqX1hAGTNt0y/tFQGaN0SKNoDf8As781UenF
   tdnVRChdBZsYQtGHxxgMaToclhE8EzZS1/pKcETw5IjnCnQsXU7JBcGUE
   SLNwWbnRkWVY9v9gFFJc74gQn2B5ERH09O1ZKlmsdryikp9JKx9IDseLT
   7DC9CiMrY6DMFLYuzQLpP/1MYHpp+yJIfbmDpo9N++dq68vq4Ja+hU5r2
   SE4KnEQnztkFuk67o39dSBfwH8ZaahJ62vqwdWLOdLAO4i2u3FPwP41mB
   BC/u2kecXpQXbXD0496tg9/CsfUmuYUGOPpYCufT98sY+JAn9G70WIYDt
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="398837203"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="398837203"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2022 06:09:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="745063906"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="745063906"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP; 16 Nov 2022 06:09:46 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ovJ6m-00D9hw-2y;
        Wed, 16 Nov 2022 16:09:44 +0200
Date:   Wed, 16 Nov 2022 16:09:44 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Thierry Reding <treding@nvidia.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [rft, PATCH v3 1/1] gpiolib: Get rid of not used of_node member
Message-ID: <Y3TvKJAejVAZEVPJ@smile.fi.intel.com>
References: <20221116091859.64725-1-andriy.shevchenko@linux.intel.com>
 <Y3Tp2y9U8PcDh1r/@orome>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3Tp2y9U8PcDh1r/@orome>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2022 at 02:47:07PM +0100, Thierry Reding wrote:
> On Wed, Nov 16, 2022 at 11:18:59AM +0200, Andy Shevchenko wrote:
> > All new drivers should use fwnode and / or parent to provide the
> > necessary information to the GPIO library.

...

> > +	/* If the calling driver did not initialize firmware node, do it here */
> >  	if (gc->fwnode)
> >  		fwnode = gc->fwnode;
> >  	else if (gc->parent)
> >  		fwnode = dev_fwnode(gc->parent);
> > +	gc->fwnode = fwnode;
> 
> I'm not sure we want to set this one. We recently discussed this in
> another thread and my reading is that gc->fwnode is supposed to be used
> only to explicitly override which fwnode to use if the default isn't
> appropriate. Right now the standard way to access the device's fwnode
> seems to be dev_fwnode(&gdev->dev), with only very few exceptions, so
> it'd be great if we could settle on that, rather than introduce a second
> field that contains the same value and use them interchangeably.
> 
> One way we could enforce this is by setting gc->fwnode to NULL here
> instead of fwnode. That should cause a crash anywhere it's used after
> this, so we should be able to easily weed out any abuses.
> 
> Of course if people prefer to use gc->fwnode instead, then we may want
> to remove all uses of gdev->dev.fwnode. There's simply no point in
> keeping the same value in two different place, it's just going to lead
> to a big mess.

I prefer that we explicitly use GPIO device firmware node.
Independently on this message I came up with another patch
(I'm just about to sent it right away) which I think it
the best to have in current case.

Ideally I would like to see const struct gpio_chip *gc to be a parameter
to the GPIO chip add(). But it may happen in distant future.

-- 
With Best Regards,
Andy Shevchenko


