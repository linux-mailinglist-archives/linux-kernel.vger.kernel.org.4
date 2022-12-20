Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 890A06526DB
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 20:17:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233909AbiLTTQi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 14:16:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbiLTTQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 14:16:34 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEF53E1A;
        Tue, 20 Dec 2022 11:16:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671563793; x=1703099793;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=97uhtqzxN7mmkjSYc5PmGDzPOu4jwieiIShfsEoanek=;
  b=ambKB0C5M1n6OXT2NSmJzTc6g+Ufd6n45Zjqu7SOg/swKAxsP6TZWxJC
   i/0uLxfO/u0GzGiyEy1hyDKoKgUECM0P0psIa5PBPjVJD+mgOy1XLGUQ9
   P0DdRSG5jtC8IjashR+G/eLSFLdYiNcRuxx8zp6QeiigvmJ4Eb2QraOfY
   wSqJZNhUd8wWsWb4ML8kkZlsNZktdsPiz4rnWZS+lz3Kzm1UAxdxEKkRz
   Gs3P2AmR2mUBwTX8WlEBG12DDXBM8phMMG8mz8EyCJTzvGVHTQ6+a5ddT
   hjRLQlYG+FSW1z51kQoNs8fVnnzMvOEQ0Libr1S6VAcSeVxMlMQ93aaR1
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10567"; a="320870894"
X-IronPort-AV: E=Sophos;i="5.96,259,1665471600"; 
   d="scan'208";a="320870894"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2022 11:16:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10567"; a="719690789"
X-IronPort-AV: E=Sophos;i="5.96,259,1665471600"; 
   d="scan'208";a="719690789"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP; 20 Dec 2022 11:16:31 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1p7i6I-00D9CL-02;
        Tue, 20 Dec 2022 21:16:30 +0200
Date:   Tue, 20 Dec 2022 21:16:29 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] gpiolib: of: remove of_get_gpio[_flags]() and
 of_get_named_gpio_flags()
Message-ID: <Y6IKDWVa7+ZQ/Ofi@smile.fi.intel.com>
References: <20221219192016.1396950-1-dmitry.torokhov@gmail.com>
 <20221219192016.1396950-4-dmitry.torokhov@gmail.com>
 <Y6G/cypRVrpmjeqI@smile.fi.intel.com>
 <Y6H+8vss7YPgOrMF@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y6H+8vss7YPgOrMF@google.com>
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

On Tue, Dec 20, 2022 at 10:29:06AM -0800, Dmitry Torokhov wrote:
> On Tue, Dec 20, 2022 at 03:58:11PM +0200, Andy Shevchenko wrote:
> > On Mon, Dec 19, 2022 at 11:20:15AM -0800, Dmitry Torokhov wrote:
> > > There are no more users of these APIs in the mainline kernel, remove
> > > them. This leaves of_get_named_gpio() as the only legacy OF-specific
> > > API.

...

> > > -	desc = of_get_named_gpiod_flags(np, list_name, index, flags);
> > > +	desc = of_get_named_gpiod_flags(np, propname, index, NULL);
> > 
> > I didn't get it. The commit message and the subject says there are no more
> > users of these APIs, why is it still here? How is it compiled?
> 
> gpio vs gpiod strikes again ;) We are removing
> of_get_named_gpio_flags(), but of_get_named_gpiod_flags() is a local
> helper in gpiolib-of.c and is still very much in use there and I have no
> plans removing it.

Right, thank you for clarification.
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


