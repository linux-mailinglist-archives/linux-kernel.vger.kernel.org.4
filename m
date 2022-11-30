Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAE7463D5A5
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 13:32:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234815AbiK3Mb5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 07:31:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbiK3Mby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 07:31:54 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1D7A4A59C;
        Wed, 30 Nov 2022 04:31:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669811512; x=1701347512;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zKETJrfvjw63GEKgdDVGoEq/Ye/042EOL11iLLnZW9M=;
  b=j/x5TX+HSBvF+8SD3czI6tiMUss7Q+ue0CLhb0Ap0yld6WBlcnPcKUw0
   UeJAA4V8ry90yTdRHyOBmuo+jfD6IeB4Ly1d1hu530lAjhjSy8zIpIVmq
   nrmfU3orWV2H7r36e/w0LXNUVK1NeQlnNH9HyLimNLXw2X4Pb9VnxZymn
   wUrC6AGb6AKpPyvjJ5s12D4iWEUWu/2jS+M5KtUGyox1E8CP2yJBk0JO5
   tatOEY+gIDPRq3cfgJVDkwbE063wvCSm64PMWv5oG5c+Wngtvv1gUSXrD
   UcYAzPIhfJeGepyQaqw01Z0LGDTmEZX+HNEnyHym3I7zoGpQWut2Axp7G
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="295079868"
X-IronPort-AV: E=Sophos;i="5.96,206,1665471600"; 
   d="scan'208";a="295079868"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2022 04:31:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="644197486"
X-IronPort-AV: E=Sophos;i="5.96,206,1665471600"; 
   d="scan'208";a="644197486"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP; 30 Nov 2022 04:31:50 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1p0MFg-002G4C-2p;
        Wed, 30 Nov 2022 14:31:48 +0200
Date:   Wed, 30 Nov 2022 14:31:48 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v4 2/2] gpiolib: protect the GPIO device against being
 dropped while in use by user-space
Message-ID: <Y4dNNAHOFU5izEbm@smile.fi.intel.com>
References: <20221130090556.40280-1-brgl@bgdev.pl>
 <20221130090556.40280-3-brgl@bgdev.pl>
 <Y4dGNy4vlDEUUFlw@smile.fi.intel.com>
 <CAMRc=Meo7_YuNEHPn0zH7FoRaNOXhd5B0Z664jeZcrhzngW=KA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMRc=Meo7_YuNEHPn0zH7FoRaNOXhd5B0Z664jeZcrhzngW=KA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 30, 2022 at 01:05:30PM +0100, Bartosz Golaszewski wrote:
> On Wed, Nov 30, 2022 at 1:02 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Wed, Nov 30, 2022 at 10:05:56AM +0100, Bartosz Golaszewski wrote:

> > > +     down_read(&gdev->sem);
> >
> > Thinking more about this, wouldn't be better to actually
> >
> >         ret = down_read_trylock(&gdev->sem);
> >         if (ret)
> >                 return ret;
> >
> > ?
> 
> You mean as in: try to take the lock, but if we're already removing
> the device (as the down_write() can only happen in gpiochip_remove()),
> then die right away? Smart! Yeah, I'll do it this way.

But please check return values properly (it seems not obvious what it does
return).

-- 
With Best Regards,
Andy Shevchenko


