Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 551F866A509
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 22:20:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbjAMVUF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 16:20:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231217AbjAMVTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 16:19:38 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D79E988DED;
        Fri, 13 Jan 2023 13:19:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673644777; x=1705180777;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7HGXBTJg+LZ/itJ6xK6JijQc5jcuZbLhB2mx9cppSNI=;
  b=JYqj4Xel3jzO52S0+gXnFkvhpBiVxfYjqd9WbgO9XbS7S8j18qiJRp3D
   9np5FkBD8Pn41YN6jukuRHE2S9gugCrzm1B80a+MJbaPxRzq5SjXTjhvn
   EhXgLPyAjh7Xe39RXbVZMwuDK3cuYJ+eWNxtu4+BVxbpZqKqnu0WuadOk
   J9658xkpSRlL/mXMEqO6NoZESZ+JOt74XPGwJWj9rluKF+dKxofvmaz7e
   cIsopI6zQS6kOqhBng7hRsFn4kT8Sp9WG0IJYiYpGWyS/tTJ0iQPGpNM2
   Bk6QEGh3Zl7jS/xbJd++80+EilYG8Hz17lAgcUpL2NbX1yUqbv+at/+zY
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="304482241"
X-IronPort-AV: E=Sophos;i="5.97,214,1669104000"; 
   d="scan'208";a="304482241"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 13:19:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="635910766"
X-IronPort-AV: E=Sophos;i="5.97,214,1669104000"; 
   d="scan'208";a="635910766"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006.jf.intel.com with ESMTP; 13 Jan 2023 13:19:34 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pGRSW-008r5k-2l;
        Fri, 13 Jan 2023 23:19:32 +0200
Date:   Fri, 13 Jan 2023 23:19:32 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Frank Rowand <frowand.list@gmail.com>
Subject: Re: [PATCH v1 1/1] gpiolib: of: Move enum of_gpio_flags to its only
 user
Message-ID: <Y8HK5G/htwYyahi0@smile.fi.intel.com>
References: <20230112145140.67573-1-andriy.shevchenko@linux.intel.com>
 <Y8AzwdCGr4VFjP5X@smile.fi.intel.com>
 <20230113202351.GA2864676-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230113202351.GA2864676-robh@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13, 2023 at 02:23:51PM -0600, Rob Herring wrote:
> On Thu, Jan 12, 2023 at 06:22:25PM +0200, Andy Shevchenko wrote:
> > On Thu, Jan 12, 2023 at 04:51:40PM +0200, Andy Shevchenko wrote:
> > > GPIO library for OF is the only user for enum of_gpio_flags.
> > > Move it there.

...

> > > +/*
> > > + * This is Linux-specific flags. By default controllers' and Linux' mapping
> > > + * match, but GPIO controllers are free to translate their own flags to
> > > + * Linux-specific in their .xlate callback. Though, 1:1 mapping is recommended.
> > > + */
> > 
> > Now that I re-read the comment, I think this can be postponed until we get a
> > consensus that no new driver is ever should do non 1:1 mapping.
> > 
> > If that consensus achieved, we may drop this enum altogether and replace it
> > with the generic flags..
> 
> We don't keep things with no users. We can move this back if there ever 
> is a user.

Yes! But my point to go even deeper and replace this 1:1 mapped bits by
the generic ones.

-- 
With Best Regards,
Andy Shevchenko


