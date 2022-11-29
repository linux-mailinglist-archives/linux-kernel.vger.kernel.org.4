Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5515663C654
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 18:21:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236585AbiK2RVk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 12:21:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236566AbiK2RVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 12:21:37 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB5C16150D;
        Tue, 29 Nov 2022 09:21:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669742495; x=1701278495;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2LMdGOwU9JIK5rvq/D95NYGoaCMrWIZWXFQnmpG85k0=;
  b=VCVXtNfl5DGHXh7Ot2uwnhUtAyNqOW88gIYVgRjH/nqU0knj6eCV171t
   kt69NUySe+u+nLWHSXfxPe28EKgeqoIBKcCOnStvyDG7JwycUzF3W+l2G
   5A/rNIzBgVWL9NTCoVgMHysUxjLrlk3aB80Mnx+7uI9oTs0NZyFRVOJ+F
   STmiaAvpNAPCpRkmgYiW0r4GanEGhjNdF4HnW5LirviA5ZRCR9U/4Hvx7
   RCcTsKHPiHBE14yoBLRauJXzk5pS/V6xYM8WVnmg1dj3XIq5yjLEPRXFr
   9xNFEqcTXmHn4PSORqp5PQZ2MtyFCx27LTtzvYBDE3cjKmaXAkO3ZEg3H
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="316320006"
X-IronPort-AV: E=Sophos;i="5.96,203,1665471600"; 
   d="scan'208";a="316320006"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2022 08:53:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="768492367"
X-IronPort-AV: E=Sophos;i="5.96,203,1665471600"; 
   d="scan'208";a="768492367"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP; 29 Nov 2022 08:53:28 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1p03rK-001nHg-2L;
        Tue, 29 Nov 2022 18:53:26 +0200
Date:   Tue, 29 Nov 2022 18:53:26 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v3 2/2] gpiolib: protect the GPIO device against being
 dropped while in use by user-space
Message-ID: <Y4Y5BjTwVCF5bAn5@smile.fi.intel.com>
References: <20221129123553.353410-1-brgl@bgdev.pl>
 <20221129123553.353410-3-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221129123553.353410-3-brgl@bgdev.pl>
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

On Tue, Nov 29, 2022 at 01:35:53PM +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> While any of the GPIO cdev syscalls is in progress, the kernel can call
> gpiochip_remove() (for instance, when a USB GPIO expander is disconnected)
> which will set gdev->chip to NULL after which any subsequent access will
> cause a crash.
> 
> To avoid that: use an RW-semaphore in which the syscalls take it for
> reading (so that we don't needlessly prohibit the user-space from calling
> syscalls simultaneously) while gpiochip_remove() takes it for writing so
> that it can only happen once all syscalls return.

...

I would do

typedef __poll_t (*poll_fn)(struct file *, struct poll_table_struct *);

and so on and use that one in the respective parameters.

BUT. Since it's a fix, up to you which one to choose.

> +static __poll_t call_poll_locked(struct file *file,
> +				 struct poll_table_struct *wait,
> +				 struct gpio_device *gdev,
> +				 __poll_t (*func)(struct file *,
> +						  struct poll_table_struct *))
> +{
> +	__poll_t ret;
> +
> +	down_read(&gdev->sem);
> +	ret = func(file, wait);
> +	up_read(&gdev->sem);
> +
> +	return ret;
> +}

...

> +	down_write(&gdev->sem);

+ Blank line?

>  	/* FIXME: should the legacy sysfs handling be moved to gpio_device? */
>  	gpiochip_sysfs_unregister(gdev);
>  	gpiochip_free_hogs(gc);

...

>  	gcdev_unregister(gdev);

+ Blank line ?

> +	up_write(&gdev->sem);
>  	put_device(&gdev->dev);

-- 
With Best Regards,
Andy Shevchenko


