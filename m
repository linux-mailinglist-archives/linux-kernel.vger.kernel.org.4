Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46E9863C31E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 15:49:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235825AbiK2OtF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 09:49:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234692AbiK2Osi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 09:48:38 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F83F5EFA9;
        Tue, 29 Nov 2022 06:47:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669733270; x=1701269270;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=l0cK1aBpkD0ZwUr4YViGznz7dGf0qRZSdpdtsh04nes=;
  b=ikULDCs9n1fJNw8IMf3/kLcLZCrDqh1pejlW5zxyq57BHnEAPkBUoPWB
   pUeu7vDB6OrjqfOXc6hHqHsWYHdYEL4jzddhq65J/iCOVkWGSkVK0ar9i
   7exM4O3hofJu4mu6mhRV4Z4mMMz119o4CG1iJBstFuj1QiSZmn0tqNXkI
   An6Ttq5S5LZjGhj5Qnv9xUsjyjyfQIVZsydnLHD6bSDplM7S8+9oZF9R3
   cxkZeC9M1W/0/x5McoU+2TPlPpDrlOqkrgg7/Gxj0sWBlCub4g/D4ZMHK
   Dw1bt+Zakr73qhmzKFquWAijIOcoqkD4dkX4bgoj4itXgqVpoy2DtEgJJ
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="377270640"
X-IronPort-AV: E=Sophos;i="5.96,203,1665471600"; 
   d="scan'208";a="377270640"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2022 06:47:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="594283825"
X-IronPort-AV: E=Sophos;i="5.96,203,1665471600"; 
   d="scan'208";a="594283825"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP; 29 Nov 2022 06:47:47 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1p01th-001kGj-2Q;
        Tue, 29 Nov 2022 16:47:45 +0200
Date:   Tue, 29 Nov 2022 16:47:45 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 2/2] gpiolib: Introduce gpio_device_get() and
 gpio_device_put()
Message-ID: <Y4YbkUX+bTM5ZEGg@smile.fi.intel.com>
References: <20221125181158.67265-1-andriy.shevchenko@linux.intel.com>
 <20221125181158.67265-2-andriy.shevchenko@linux.intel.com>
 <CAMRc=Mf14Q7_gMXaK+hZ8PdV2U5GiL97QRc3SGKLPqmEuSyDxA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMRc=Mf14Q7_gMXaK+hZ8PdV2U5GiL97QRc3SGKLPqmEuSyDxA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 29, 2022 at 02:54:10PM +0100, Bartosz Golaszewski wrote:
> On Fri, Nov 25, 2022 at 7:11 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > Introduce gpio_device_get() and gpio_device_put() helpers
> > and convert existing users.

> This doesn't apply to my for-next branch, can you rebase and resend
> (just this one, the other is applied).

The problem is that you don't merge or cherry-pick fixes into your
for-next branch and they are getting diverged.

In PDx86 subsystem we decided to cherry-pick the fixes into for-next.
Some other subsystems are doing back-merges (but I remember that Linus
T. complained about back merges, although I dunno if it's still
the case). Some subsystems merges their fixes into for-next, dunno
if it's the best practice either.

That said, this can be submitted after v6.2-rc1 is out.

-- 
With Best Regards,
Andy Shevchenko


