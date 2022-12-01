Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A78DE63F02B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 13:08:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbiLAMIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 07:08:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbiLAMIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 07:08:35 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B92485673;
        Thu,  1 Dec 2022 04:08:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669896514; x=1701432514;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=v8Awrxaj1ue8HHnJerJK41Na9ZZisQbb0WsAzLQjuhc=;
  b=c9WzpMgwmBsNd/modFAdE+NvU+A/O8741e83dv40DyMD5n2zwZAvowqZ
   VbSZLyfF7r1hCwien05Iv5LgQG07x42NGLSlsvM4LJwYfEJE5S3Rr2KqJ
   T5DgDHPAe5haGEC+Audlc2jTnxjcHuyOCn0qEQG2ZiRUbJjFXddtwoz6X
   rT8ke16sMw4n6wYvWaWDmDLIfueH65Tc+ODy9+ra1YA9MaBpr1Ar4myX+
   rgWlQwle5pmgg7Em9rfyleTd2tIxFi8O9PYrbZZ6UFFUAKnDwzSs7S+vv
   s46uSWQDBO8cnikxPYzB4IeRas0I5Uk2BTC83PU1SmA1MbSGA7chJ9XEX
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="314366862"
X-IronPort-AV: E=Sophos;i="5.96,209,1665471600"; 
   d="scan'208";a="314366862"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2022 04:07:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="675415280"
X-IronPort-AV: E=Sophos;i="5.96,209,1665471600"; 
   d="scan'208";a="675415280"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP; 01 Dec 2022 04:07:17 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1p0iLT-002m5J-2D;
        Thu, 01 Dec 2022 14:07:15 +0200
Date:   Thu, 1 Dec 2022 14:07:15 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v5 1/2] gpiolib: cdev: fix NULL-pointer dereferences
Message-ID: <Y4iY8wFBhMh7paXT@smile.fi.intel.com>
References: <20221201083335.819190-1-brgl@bgdev.pl>
 <20221201083335.819190-2-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221201083335.819190-2-brgl@bgdev.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 01, 2022 at 09:33:34AM +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> There are several places where we can crash the kernel by requesting
> lines, unbinding the GPIO device, then calling any of the system calls
> relevant to the GPIO character device's annonymous file descriptors:
> ioctl(), read(), poll().
> 
> While I observed it with the GPIO simulator, it will also happen for any
> of the GPIO devices that can be hot-unplugged - for instance any HID GPIO
> expander (e.g. CP2112).
> 
> This affects both v1 and v2 uAPI.
> 
> This fixes it partially by checking if gdev->chip is not NULL but it
> doesn't entirely remedy the situation as we still have a race condition
> in which another thread can remove the device after the check.
> 
> Fixes: d7c51b47ac11 ("gpio: userspace ABI for reading/writing GPIO lines")
> Fixes: 3c0d9c635ae2 ("gpiolib: cdev: support GPIO_V2_GET_LINE_IOCTL and GPIO_V2_LINE_GET_VALUES_IOCTL")
> Fixes: aad955842d1c ("gpiolib: cdev: support GPIO_V2_GET_LINEINFO_IOCTL and GPIO_V2_GET_LINEINFO_WATCH_IOCTL")
> Fixes: a54756cb24ea ("gpiolib: cdev: support GPIO_V2_LINE_SET_CONFIG_IOCTL")
> Fixes: 7b8e00d98168 ("gpiolib: cdev: support GPIO_V2_LINE_SET_VALUES_IOCTL")
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/gpio/gpiolib-cdev.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
> index 0cb6b468f364..911d91668903 100644
> --- a/drivers/gpio/gpiolib-cdev.c
> +++ b/drivers/gpio/gpiolib-cdev.c
> @@ -201,6 +201,9 @@ static long linehandle_ioctl(struct file *file, unsigned int cmd,
>  	unsigned int i;
>  	int ret;
>  
> +	if (!lh->gdev->chip)
> +		return -ENODEV;
> +
>  	switch (cmd) {
>  	case GPIOHANDLE_GET_LINE_VALUES_IOCTL:
>  		/* NOTE: It's okay to read values of output lines */
> @@ -1384,6 +1387,9 @@ static long linereq_ioctl(struct file *file, unsigned int cmd,
>  	struct linereq *lr = file->private_data;
>  	void __user *ip = (void __user *)arg;
>  
> +	if (!lr->gdev->chip)
> +		return -ENODEV;
> +
>  	switch (cmd) {
>  	case GPIO_V2_LINE_GET_VALUES_IOCTL:
>  		return linereq_get_values(lr, ip);
> @@ -1410,6 +1416,9 @@ static __poll_t linereq_poll(struct file *file,
>  	struct linereq *lr = file->private_data;
>  	__poll_t events = 0;
>  
> +	if (!lr->gdev->chip)
> +		return 0;

EPOLLHUP ?

>  	poll_wait(file, &lr->wait, wait);
>  
>  	if (!kfifo_is_empty_spinlocked_noirqsave(&lr->events,
> @@ -1429,6 +1438,9 @@ static ssize_t linereq_read(struct file *file,
>  	ssize_t bytes_read = 0;
>  	int ret;
>  
> +	if (!lr->gdev->chip)
> +		return -ENODEV;
> +
>  	if (count < sizeof(le))
>  		return -EINVAL;
>  
> @@ -1716,6 +1728,9 @@ static __poll_t lineevent_poll(struct file *file,
>  	struct lineevent_state *le = file->private_data;
>  	__poll_t events = 0;
>  
> +	if (!le->gdev->chip)
> +		return 0;
> +
>  	poll_wait(file, &le->wait, wait);
>  
>  	if (!kfifo_is_empty_spinlocked_noirqsave(&le->events, &le->wait.lock))
> @@ -1740,6 +1755,9 @@ static ssize_t lineevent_read(struct file *file,
>  	ssize_t ge_size;
>  	int ret;
>  
> +	if (!le->gdev->chip)
> +		return -ENODEV;
> +
>  	/*
>  	 * When compatible system call is being used the struct gpioevent_data,
>  	 * in case of at least ia32, has different size due to the alignment
> @@ -1821,6 +1839,9 @@ static long lineevent_ioctl(struct file *file, unsigned int cmd,
>  	void __user *ip = (void __user *)arg;
>  	struct gpiohandle_data ghd;
>  
> +	if (!le->gdev->chip)
> +		return -ENODEV;
> +
>  	/*
>  	 * We can get the value for an event line but not set it,
>  	 * because it is input by definition.
> @@ -2407,6 +2428,9 @@ static __poll_t lineinfo_watch_poll(struct file *file,
>  	struct gpio_chardev_data *cdev = file->private_data;
>  	__poll_t events = 0;
>  
> +	if (!cdev->gdev->chip)
> +		return 0;
> +
>  	poll_wait(file, &cdev->wait, pollt);
>  
>  	if (!kfifo_is_empty_spinlocked_noirqsave(&cdev->events,
> @@ -2425,6 +2449,9 @@ static ssize_t lineinfo_watch_read(struct file *file, char __user *buf,
>  	int ret;
>  	size_t event_size;
>  
> +	if (!cdev->gdev->chip)
> +		return -ENODEV;
> +
>  #ifndef CONFIG_GPIO_CDEV_V1
>  	event_size = sizeof(struct gpio_v2_line_info_changed);
>  	if (count < event_size)
> -- 
> 2.37.2
> 

-- 
With Best Regards,
Andy Shevchenko


