Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D245E5BEBC0
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 19:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbiITRTj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 13:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiITRTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 13:19:35 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0F3E2FA;
        Tue, 20 Sep 2022 10:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663694368; x=1695230368;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YHeX8KqiCGEuO7hZn5tECjp6JIpCg4NbTW4+9gOhRTQ=;
  b=NhVsGZD8CoC338fd9kLege2H/kkAbRiKf/eWsHm6frr5NZodfqRWLC0J
   NUUcKCVJyZnQU29ejrX4yMPCesi0HzT6cHON447DFk4CVfEewBMel5Yta
   HtSyowg1r9ZqWDE7S2HTRPSw1Nn+pcCHR6pSjem+sSb+iqDcVYAT3X/yq
   hxy2FWkp4px+WLliNXy21l2CG9B/XAeVbdqPy1LWtNKp6owd/+X6ID9uy
   K2w7EEqGi1bxJ+vcK5r/Cm0aPWlNzls+GnpPH/K/MRsNkSSfOX1LrHP/D
   UTKzJVfNdb1yzeUWzldAacmYRfB8xWsQNs5SAvWPC020Mjv8jwSFu33oe
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10476"; a="299750011"
X-IronPort-AV: E=Sophos;i="5.93,331,1654585200"; 
   d="scan'208";a="299750011"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2022 10:19:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,331,1654585200"; 
   d="scan'208";a="794340908"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP; 20 Sep 2022 10:19:26 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oagu5-00595C-0O;
        Tue, 20 Sep 2022 20:19:25 +0300
Date:   Tue, 20 Sep 2022 20:19:24 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpiolib: cdev: add fdinfo output for line request file
 descriptors
Message-ID: <Yyn2HEBPPWlJ3E0W@smile.fi.intel.com>
References: <20220920135435.15593-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220920135435.15593-1-brgl@bgdev.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 20, 2022 at 03:54:35PM +0200, Bartosz Golaszewski wrote:
> Add fdinfo output for file descriptors created for user-space line
> requests in GPIO uAPI v2. The fdinfo file now contains the name of the
> GPIO device that is the "parent" of the request as well as offsets of
> the lines requested. This allows user-space to parse the /proc/$PID/fdinfo
> entries and deduct the PID of the process that requested a specific line.

In principle I'm fine, but see below.

> Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
> ---
>  drivers/gpio/gpiolib-cdev.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
> index f8041d4898d1..0f7b5562c410 100644
> --- a/drivers/gpio/gpiolib-cdev.c
> +++ b/drivers/gpio/gpiolib-cdev.c
> @@ -1497,6 +1497,21 @@ static int linereq_release(struct inode *inode, struct file *file)
>  	return 0;
>  }
>  
> +#ifdef CONFIG_PROC_FS
> +static void linereq_show_fdinfo(struct seq_file *out, struct file *file)
> +{
> +	struct linereq *lr = file->private_data;
> +	struct device *dev = &lr->gdev->dev;
> +	u16 i;
> +
> +	seq_printf(out, "gpio-device:\t%s\n", dev_name(dev));
> +
> +	for (i = 0; i < lr->num_lines; i++)
> +		seq_printf(out, "gpio-line:\t%d\n",
> +			   gpio_chip_hwgpio(lr->lines[i].desc));

Hmm... Not sure which variant is better (as for machine parsing and for human),
but I was thinking of

	gpio-lines: 1,4,6, ...

Also don't forget that sizes over PAGE_SIZE in sysfs sometimes problematic and
racy.(the commit 888be6067b97 ("ACPI: sysfs: Fix a buffer overrun problem with
description_show()") for the reference).

> +}
> +#endif
> +
>  static const struct file_operations line_fileops = {
>  	.release = linereq_release,
>  	.read = linereq_read,
> @@ -1507,6 +1522,9 @@ static const struct file_operations line_fileops = {
>  #ifdef CONFIG_COMPAT
>  	.compat_ioctl = linereq_ioctl_compat,
>  #endif
> +#ifdef CONFIG_PROC_FS
> +	.show_fdinfo = linereq_show_fdinfo,
> +#endif
>  };
>  
>  static int linereq_create(struct gpio_device *gdev, void __user *ip)
> -- 
> 2.34.1
> 

-- 
With Best Regards,
Andy Shevchenko


