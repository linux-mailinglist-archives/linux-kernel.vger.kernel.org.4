Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC2863B21F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 20:22:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233499AbiK1TWC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 14:22:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233265AbiK1TV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 14:21:56 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CAD42AE5;
        Mon, 28 Nov 2022 11:21:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669663316; x=1701199316;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6X77xpVMdoDe+kk4gQibRxsZcp91e1R8TXiTUHEC/Ac=;
  b=BBDWzt1uO/UjTNYx2TzeserP5Zuj37+srbQeEWC18PJYB/wtMIrhhAPB
   oIS9ZqqKTStx146kfq4bWuHIAPw1SnKcWTdyAeHIBQ8sZqWpZPsGHtach
   9cRx2iXHXwx3x+Tdn9ZWT94aTflbyFgrMN12fJz6/C0gqMHZlsDBN/Xls
   gV6+FtbVN4ZOemoJk5ChV5/zVQ/5udc0w/2J22clrmoO2RhUZVyN9DLNv
   7EU5hRc77uotn/Sln1OuFWxhQtq9KXLzCiE4eJ00Bi/0txpeIeNkrHLD8
   XiV5v1hUB1w0YnjHje+gTdSalMAbpjud2Nwi52/wjnAa9BmsipsfhPCS+
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="379188600"
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; 
   d="scan'208";a="379188600"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2022 11:21:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="732263555"
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; 
   d="scan'208";a="732263555"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP; 28 Nov 2022 11:21:53 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ozjhQ-001MhJ-0u;
        Mon, 28 Nov 2022 21:21:52 +0200
Date:   Mon, 28 Nov 2022 21:21:51 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v2 2/2] gpiolib: protect the GPIO device against being
 dropped while in use by user-space
Message-ID: <Y4UKT2kIHi4T0tu8@smile.fi.intel.com>
References: <20221128175214.602612-1-brgl@bgdev.pl>
 <20221128175214.602612-3-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221128175214.602612-3-brgl@bgdev.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28, 2022 at 06:52:14PM +0100, Bartosz Golaszewski wrote:
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

Missed also Dependency (the previous change).

> Fixes: d7c51b47ac11 ("gpio: userspace ABI for reading/writing GPIO lines")
> Fixes: 3c0d9c635ae2 ("gpiolib: cdev: support GPIO_V2_GET_LINE_IOCTL and GPIO_V2_LINE_GET_VALUES_IOCTL")
> Fixes: aad955842d1c ("gpiolib: cdev: support GPIO_V2_GET_LINEINFO_IOCTL and GPIO_V2_GET_LINEINFO_WATCH_IOCTL")
> Fixes: a54756cb24ea ("gpiolib: cdev: support GPIO_V2_LINE_SET_CONFIG_IOCTL")
> Fixes: 7b8e00d98168 ("gpiolib: cdev: support GPIO_V2_LINE_SET_VALUES_IOCTL")

...

> +	down_read(&gdev->sem);
>  
> -	if (!gdev->chip)
> +	if (!gdev->chip) {
> +		up_read(&gdev->sem);
>  		return -ENODEV;
> +	}

Wouldn't be easier to wrap existing functions (with their renaming) into a new
ones with semaphore?

You can even start that in the previous patch.


-- 
With Best Regards,
Andy Shevchenko


