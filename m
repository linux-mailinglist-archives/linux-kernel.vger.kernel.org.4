Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C21F863D52A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 13:02:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233568AbiK3MCP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 07:02:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235162AbiK3MCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 07:02:04 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 467426F0F2;
        Wed, 30 Nov 2022 04:02:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669809723; x=1701345723;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PnI8aqM3RQIQ+6IAusUZnxwdz+1ZvJ8Twd/lT6aBops=;
  b=EJwZ4nL37eBlo36H1q8GxSTSIKfMTOwvETy/wZGCUzEnPATyoYZGk6N+
   flpnT5HrAurKnWekWQMoeyMm5N0KxjdqDxc1MugKccNsIEqUH1/Cg2nKx
   84pE5XoIv7aE+2sZatHQV7Z0VYsg5OX4jGkTThiboZ6HhWvaXeqnaiJ9b
   w1FTc5l4uuvHaxKXVeTmxUx1AkjHQkBNI7Kds+wQLYm33neMruevIxv62
   K/4KO8ZFEhKhypclonIGSRvM5KxPD3qr6UHeCJTJ5vhe/Cz1WHJhAjZLV
   J2GdSgSbaij+nzWPOOX4b8J+HmwGyXxGJ7zS39kqSh7/LZIYcYJTobISM
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="314071477"
X-IronPort-AV: E=Sophos;i="5.96,206,1665471600"; 
   d="scan'208";a="314071477"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2022 04:02:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="973078191"
X-IronPort-AV: E=Sophos;i="5.96,206,1665471600"; 
   d="scan'208";a="973078191"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP; 30 Nov 2022 04:02:00 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1p0Lmp-002FNO-1G;
        Wed, 30 Nov 2022 14:01:59 +0200
Date:   Wed, 30 Nov 2022 14:01:59 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v4 2/2] gpiolib: protect the GPIO device against being
 dropped while in use by user-space
Message-ID: <Y4dGNy4vlDEUUFlw@smile.fi.intel.com>
References: <20221130090556.40280-1-brgl@bgdev.pl>
 <20221130090556.40280-3-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221130090556.40280-3-brgl@bgdev.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 30, 2022 at 10:05:56AM +0100, Bartosz Golaszewski wrote:
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

Bikeshedding below and one question.
(As per tag I'm fine with this version anyway)

...

> +typedef __poll_t (*poll_fn)(struct file *, struct poll_table_struct *);
> +typedef long (*ioctl_fn)(struct file *, unsigned int, unsigned long);

> +typedef ssize_t (*read_fn)(struct file *, char __user *,
> +			   size_t count, loff_t *);

<bikeshedding>
It's only 84 is on a single line.

Dunno if it's better to have typedef followed by wrapper pairs rather than
all typedefs and wrappers grouped.
</bikeshedding>

> +static __poll_t call_poll_locked(struct file *file,
> +				 struct poll_table_struct *wait,
> +				 struct gpio_device *gdev, poll_fn func)
> +{
> +	__poll_t ret;

> +	down_read(&gdev->sem);

Thinking more about this, wouldn't be better to actually

	ret = down_read_trylock(&gdev->sem);
	if (ret)
		return ret;

?

> +	ret = func(file, wait);
> +	up_read(&gdev->sem);
> +
> +	return ret;
> +}

-- 
With Best Regards,
Andy Shevchenko


