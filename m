Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 016AA63911F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 22:33:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbiKYVdl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 16:33:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbiKYVdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 16:33:36 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E35B26122;
        Fri, 25 Nov 2022 13:33:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669412014; x=1700948014;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pY4yQrfrdHBInr63yt3UqXabjin1uiUkELI23CKrcLE=;
  b=mTHbmqLxMhi0AYLgky+2AN2eb1VC6CvEKJSjtIpQFadfd9w9sw8P4K3G
   AjtqIS2QF0FnAIOTHUIlSEN0CpkvhHAYnkSDfUlWWz64pwuYfNWbuR03I
   yARrVpnce1D8lLVIZBrOQzubdqgXCXSFEDoQDr8e6lKKCqDFaNwLfRK2h
   6A/et0eZF70KNu4a8MD9HPNAp4fetF6JhOqmZ0h3ncyQ50K8LWWIz+CBE
   ImVURgcaaPj/IxRWfJEgBsz09AhZPHkTRUIDc83XLwgwKEHWyo3MFD2WN
   cOpJhr2+GLXUGUbomLxJWf/dedlS/8xEbfZ9VnLJxqMzwJghhzTLAk78V
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10542"; a="341447330"
X-IronPort-AV: E=Sophos;i="5.96,194,1665471600"; 
   d="scan'208";a="341447330"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2022 13:33:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10542"; a="748696380"
X-IronPort-AV: E=Sophos;i="5.96,194,1665471600"; 
   d="scan'208";a="748696380"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP; 25 Nov 2022 13:33:32 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oygKA-00HQnO-2L;
        Fri, 25 Nov 2022 23:33:30 +0200
Date:   Fri, 25 Nov 2022 23:33:30 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH] gpiolib: cdev: fix NULL-pointer dereferences
Message-ID: <Y4E0qoab4sbBY5la@smile.fi.intel.com>
References: <20221125153257.528826-1-brgl@bgdev.pl>
 <Y4DsTxPH1tv5eEwf@sol>
 <CAMRc=Me83-_oiGEmwy4BUrzLEMT6ZsoMwWYsb6iXwg19yHMHdQ@mail.gmail.com>
 <Y4EBubusGqo4IroP@smile.fi.intel.com>
 <CAMRc=MdHtJC4Tmn3KgcnefmHTrpXy=ROAAXJLN9uv=ouJ-hQSw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMRc=MdHtJC4Tmn3KgcnefmHTrpXy=ROAAXJLN9uv=ouJ-hQSw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 25, 2022 at 10:03:06PM +0100, Bartosz Golaszewski wrote:
> On Fri, Nov 25, 2022 at 6:56 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Fri, Nov 25, 2022 at 05:48:02PM +0100, Bartosz Golaszewski wrote:
> > > On Fri, Nov 25, 2022 at 5:24 PM Kent Gibson <warthog618@gmail.com> wrote:

...

> > > Then at the subsystem level, the GPIO device struct would need a lock
> > > that would be taken by every user-space operation AND the code
> > > unregistering the device so that we don't do what you described (i.e.
> > > if there's a thread doing a read(), then let's wait until it returns
> > > before we drop the device).
> >
> > It's called a reference counting, basically you need to get device and then
> > put when it makes sense.
> 
> Andy: I am aware of struct device reference counting but this isn't
> it. You can count references all you want, but when I disconnect my
> CP2112, the USB bus calls gpiochip_remove(), struct gpio_chip * inside
> struct gpio_device is set to NULL and while the underlying struct
> device itself is still alive, the GPIO chip is no longer usable.
> 
> Reference counting won't help because the device is no longer there,
> so this behavior is correct but there's an issue with user-space still
> being able to hold certain resources and we need to make sure that
> when it tries to use them, we return an error instead of crashing.

Thank you for the detailed explanation of the case.

> I think that a good solution is to make sure, we cannot set gdev->gc
> to NULL as long as there are user-space operations in progress. After
> all, it's better to try to send a USB request to an unplugged device
> than to dereference a NULL pointer. To that end, we could have a
> user-space lock that would also be taken by gpiochip_remove().
> 
> But this is still a per-subsystem solution. Most other subsystems
> suffer from the same issue.

Yeah, many subsystems are not ready for hotplug...

-- 
With Best Regards,
Andy Shevchenko


