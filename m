Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9A8463B1FD
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 20:15:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233280AbiK1TP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 14:15:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233202AbiK1TP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 14:15:57 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAACF1B9E0;
        Mon, 28 Nov 2022 11:15:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669662955; x=1701198955;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LpWlbbMAfvyvXN49N14EHoOc6qV4A4SerKScoYIQzj4=;
  b=VV9wyay060rUWEGKDQNVQEFyyzx7QLZHAE7n3JDan2MFb7HgctCkhz7k
   AeOw7fyXvOFosqZgxrRKDPm3Rl0Z5OVv7Xn4Iy0BOKeKKwrMzzZAszvIS
   umvjpbfzUm6OBZoD63kbpQDBB54P0eb5oeOwNnBduzFHw4FHV+jjnVAKY
   /BcRi0sEioDFtp2J3jHYYCkdtnyHSICQ9hvJL3SL5lPKLAafBV0ed1HNZ
   gdqj5Hk+7ankliy8s7w9SfiewleoOSp/CGh8vMIVktvvcMp7/9EBKgUul
   cNWHsZeUxTEddRi5vx17alL8Us4xPQvpSUOhS6weHlHBoW3zq6/+kXfeu
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="341839983"
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; 
   d="scan'208";a="341839983"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2022 11:15:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="768158313"
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; 
   d="scan'208";a="768158313"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP; 28 Nov 2022 11:15:52 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ozjbb-001MYb-11;
        Mon, 28 Nov 2022 21:15:51 +0200
Date:   Mon, 28 Nov 2022 21:15:51 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v2 1/2] gpiolib: cdev: fix NULL-pointer dereferences
Message-ID: <Y4UI5w2Z+d1Df1KX@smile.fi.intel.com>
References: <20221128175214.602612-1-brgl@bgdev.pl>
 <20221128175214.602612-2-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221128175214.602612-2-brgl@bgdev.pl>
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

On Mon, Nov 28, 2022 at 06:52:13PM +0100, Bartosz Golaszewski wrote:
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

Fine by me,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Not that I'm insisting, but see a nit-pick below. I think it's better
for the sake of maintenance in a long term.

> Fixes: d7c51b47ac11 ("gpio: userspace ABI for reading/writing GPIO lines")
> Fixes: 3c0d9c635ae2 ("gpiolib: cdev: support GPIO_V2_GET_LINE_IOCTL and GPIO_V2_LINE_GET_VALUES_IOCTL")
> Fixes: aad955842d1c ("gpiolib: cdev: support GPIO_V2_GET_LINEINFO_IOCTL and GPIO_V2_GET_LINEINFO_WATCH_IOCTL")
> Fixes: a54756cb24ea ("gpiolib: cdev: support GPIO_V2_LINE_SET_CONFIG_IOCTL")
> Fixes: 7b8e00d98168 ("gpiolib: cdev: support GPIO_V2_LINE_SET_VALUES_IOCTL")
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  drivers/gpio/gpiolib-cdev.c | 36 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
> 
> diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
> index 0cb6b468f364..7a9504fb27f1 100644
> --- a/drivers/gpio/gpiolib-cdev.c
> +++ b/drivers/gpio/gpiolib-cdev.c
> @@ -195,12 +195,16 @@ static long linehandle_ioctl(struct file *file, unsigned int cmd,
>  			     unsigned long arg)
>  {
>  	struct linehandle_state *lh = file->private_data;
> +	struct gpio_device *gdev = lh->gdev;
>  	void __user *ip = (void __user *)arg;
>  	struct gpiohandle_data ghd;
>  	DECLARE_BITMAP(vals, GPIOHANDLES_MAX);
>  	unsigned int i;
>  	int ret;

I would split definition and assignment and put latter here as:

	gdev = lh->gdev;

Same to other places.

> +	if (!gdev->chip)
> +		return -ENODEV;
> +
>  	switch (cmd) {
>  	case GPIOHANDLE_GET_LINE_VALUES_IOCTL:
>  		/* NOTE: It's okay to read values of output lines */
> @@ -1382,8 +1386,12 @@ static long linereq_ioctl(struct file *file, unsigned int cmd,
>  			  unsigned long arg)
>  {
>  	struct linereq *lr = file->private_data;
> +	struct gpio_device *gdev = lr->gdev;
>  	void __user *ip = (void __user *)arg;
>  
> +	if (!gdev->chip)
> +		return -ENODEV;
> +
>  	switch (cmd) {
>  	case GPIO_V2_LINE_GET_VALUES_IOCTL:
>  		return linereq_get_values(lr, ip);
> @@ -1408,8 +1416,12 @@ static __poll_t linereq_poll(struct file *file,
>  			    struct poll_table_struct *wait)
>  {
>  	struct linereq *lr = file->private_data;
> +	struct gpio_device *gdev = lr->gdev;
>  	__poll_t events = 0;
>  
> +	if (!gdev->chip)
> +		return 0;
> +
>  	poll_wait(file, &lr->wait, wait);
>  
>  	if (!kfifo_is_empty_spinlocked_noirqsave(&lr->events,
> @@ -1425,10 +1437,14 @@ static ssize_t linereq_read(struct file *file,
>  			    loff_t *f_ps)
>  {
>  	struct linereq *lr = file->private_data;
> +	struct gpio_device *gdev = lr->gdev;
>  	struct gpio_v2_line_event le;
>  	ssize_t bytes_read = 0;
>  	int ret;
>  
> +	if (!gdev->chip)
> +		return -ENODEV;
> +
>  	if (count < sizeof(le))
>  		return -EINVAL;
>  
> @@ -1714,8 +1730,12 @@ static __poll_t lineevent_poll(struct file *file,
>  			       struct poll_table_struct *wait)
>  {
>  	struct lineevent_state *le = file->private_data;
> +	struct gpio_device *gdev = le->gdev;
>  	__poll_t events = 0;
>  
> +	if (!gdev->chip)
> +		return 0;
> +
>  	poll_wait(file, &le->wait, wait);
>  
>  	if (!kfifo_is_empty_spinlocked_noirqsave(&le->events, &le->wait.lock))
> @@ -1735,11 +1755,15 @@ static ssize_t lineevent_read(struct file *file,
>  			      loff_t *f_ps)
>  {
>  	struct lineevent_state *le = file->private_data;
> +	struct gpio_device *gdev = le->gdev;
>  	struct gpioevent_data ge;
>  	ssize_t bytes_read = 0;
>  	ssize_t ge_size;
>  	int ret;
>  
> +	if (!gdev->chip)
> +		return -ENODEV;
> +
>  	/*
>  	 * When compatible system call is being used the struct gpioevent_data,
>  	 * in case of at least ia32, has different size due to the alignment
> @@ -1818,9 +1842,13 @@ static long lineevent_ioctl(struct file *file, unsigned int cmd,
>  			    unsigned long arg)
>  {
>  	struct lineevent_state *le = file->private_data;
> +	struct gpio_device *gdev = le->gdev;
>  	void __user *ip = (void __user *)arg;
>  	struct gpiohandle_data ghd;
>  
> +	if (!gdev->chip)
> +		return -ENODEV;
> +
>  	/*
>  	 * We can get the value for an event line but not set it,
>  	 * because it is input by definition.
> @@ -2405,8 +2433,12 @@ static __poll_t lineinfo_watch_poll(struct file *file,
>  				    struct poll_table_struct *pollt)
>  {
>  	struct gpio_chardev_data *cdev = file->private_data;
> +	struct gpio_device *gdev = cdev->gdev;
>  	__poll_t events = 0;
>  
> +	if (!gdev->chip)
> +		return 0;
> +
>  	poll_wait(file, &cdev->wait, pollt);
>  
>  	if (!kfifo_is_empty_spinlocked_noirqsave(&cdev->events,
> @@ -2420,11 +2452,15 @@ static ssize_t lineinfo_watch_read(struct file *file, char __user *buf,
>  				   size_t count, loff_t *off)
>  {
>  	struct gpio_chardev_data *cdev = file->private_data;
> +	struct gpio_device *gdev = cdev->gdev;
>  	struct gpio_v2_line_info_changed event;
>  	ssize_t bytes_read = 0;
>  	int ret;
>  	size_t event_size;
>  
> +	if (!gdev->chip)
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


