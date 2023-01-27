Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83A7167E0B0
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 10:49:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233311AbjA0Jta (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 04:49:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232484AbjA0JtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 04:49:10 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 595CF820CC;
        Fri, 27 Jan 2023 01:49:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674812942; x=1706348942;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WQDah4XnNOj5Pca4shOfSlMJSAErvbAWwt7Xbf4ZdQw=;
  b=K+xgBR+Npd/PwIjD6nA132BQzEGKsQzkNRw4AfeVpzvWZzlRs168Gr6y
   jJHNmNXz0IBDvkxgsA4MV8suu6Xx8srFlGdJD11lpkWp6pvZ6tE1Nbbwg
   QlfrgyB+dUM21bVo0m6ece2BtiWTIbjVTGrzf0Ll/jeiJMV01Wu1QD7ci
   h+88F79jot5iWF1dcMS3uTD43L3ImOopD4mCFPgLJ6TEwr0pvv3vQzUPb
   ye7ZNDtugXoZygOzCCyz27mUGMig2WLUVof7vdCDqLliWlU0/o+L0bUBI
   kIvLlbRgI3j+4Y9yzDQHVy+NEANshRNRbvuPHeBQPPL8JYHyIHRaD08u/
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="328339940"
X-IronPort-AV: E=Sophos;i="5.97,250,1669104000"; 
   d="scan'208";a="328339940"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2023 01:48:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="731794443"
X-IronPort-AV: E=Sophos;i="5.97,250,1669104000"; 
   d="scan'208";a="731794443"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP; 27 Jan 2023 01:48:41 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pLLLb-00Ftyd-1f;
        Fri, 27 Jan 2023 11:48:39 +0200
Date:   Fri, 27 Jan 2023 11:48:39 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Arnd Bergmann <arnd@arndb.de>, Arnd Bergmann <arnd@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/8] gpiolib: move of_gpio_flags into gpiolib-of.c
Message-ID: <Y9Od984ZJN3clYHH@smile.fi.intel.com>
References: <20230126132801.2042371-1-arnd@kernel.org>
 <20230126132801.2042371-9-arnd@kernel.org>
 <Y9KJpU4rynmTdQMj@smile.fi.intel.com>
 <21657e6c-1101-4c56-91e3-6b2f6f9e10c9@app.fastmail.com>
 <Y9OQ9/3IuVIU8VK7@smile.fi.intel.com>
 <CAMRc=McAAwdtCo9VCFtSuQm9hDRVWHZUQe+tMC9Fec=1YhJ+Ng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMRc=McAAwdtCo9VCFtSuQm9hDRVWHZUQe+tMC9Fec=1YhJ+Ng@mail.gmail.com>
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

On Fri, Jan 27, 2023 at 10:43:37AM +0100, Bartosz Golaszewski wrote:
> On Fri, Jan 27, 2023 at 9:53 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Thu, Jan 26, 2023 at 03:47:42PM +0100, Arnd Bergmann wrote:
> > > On Thu, Jan 26, 2023, at 15:09, Andy Shevchenko wrote:
> > > > On Thu, Jan 26, 2023 at 02:28:01PM +0100, Arnd Bergmann wrote:

...

> > > >> There is no need for this in the header any more, it's just
> > > >> an implementation detail now.
> > > >
> > > > I have published
> > > > https://lore.kernel.org/r/20230112145140.67573-1-andriy.shevchenko@linux.intel.com
> > > > Can it be used?
> > >
> > > Sure, I added a Reviewed-by: on that now. Your patch will conflict
> > > with my patch 7/8, but we can work that out.
> >
> > Either Bart takes it independently or you may attach it into your series.
> > Bart?
> 
> I applied it to my for-next branch, is that fine?

Good for me, thanks!
Arnd?

-- 
With Best Regards,
Andy Shevchenko


