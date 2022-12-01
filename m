Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EDCF63F016
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 13:01:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231250AbiLAMBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 07:01:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbiLAMBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 07:01:42 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F309793E;
        Thu,  1 Dec 2022 04:01:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669896101; x=1701432101;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GYMk+ScCtSDFzTYzzO2pPPdEThdcAhKA1dnDQGGoQYI=;
  b=XQPe9BXpIbg6QgmOAQ6O1knXaiVAlwVrQ6MbsTwMhw7KvGkYbQh+VghL
   okxDjOeZpwH4hLZlX4z0GIaYO5iFfsOZx6cVpogBX4gzvMowBp77Id3D7
   mNfxx3gdub4gbRwqy69VyABAuFNwqPBZxBHRcQycPW4L6RFSrnF4kByJ6
   IU3WZeKcCLsD1b/3pqoiuINYjOXuNR16XRl27cfQMHhRRS18zJ4Bsw3re
   puVUyS1SCbVN2yQ2ZmffVAvEyWoF4uE6gebGtJJkFCZrHCk24hpU5d1tW
   qgkRTjkGLqDoyBbaChDc9eTncBZTLW4GQ6i6c/DfuI3rL0542bo1xvG83
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="401939340"
X-IronPort-AV: E=Sophos;i="5.96,209,1665471600"; 
   d="scan'208";a="401939340"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2022 04:01:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="677193736"
X-IronPort-AV: E=Sophos;i="5.96,209,1665471600"; 
   d="scan'208";a="677193736"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP; 01 Dec 2022 04:01:38 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1p0iG1-002lxl-0I;
        Thu, 01 Dec 2022 14:01:37 +0200
Date:   Thu, 1 Dec 2022 14:01:36 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v5 2/2] gpiolib: protect the GPIO device against being
 dropped while in use by user-space
Message-ID: <Y4iXoC+AE6AH5ze4@smile.fi.intel.com>
References: <20221201083335.819190-1-brgl@bgdev.pl>
 <20221201083335.819190-3-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221201083335.819190-3-brgl@bgdev.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 01, 2022 at 09:33:35AM +0100, Bartosz Golaszewski wrote:
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
> 
> Fixes: d7c51b47ac11 ("gpio: userspace ABI for reading/writing GPIO lines")
> Fixes: 3c0d9c635ae2 ("gpiolib: cdev: support GPIO_V2_GET_LINE_IOCTL and GPIO_V2_LINE_GET_VALUES_IOCTL")
> Fixes: aad955842d1c ("gpiolib: cdev: support GPIO_V2_GET_LINEINFO_IOCTL and GPIO_V2_GET_LINEINFO_WATCH_IOCTL")
> Fixes: a54756cb24ea ("gpiolib: cdev: support GPIO_V2_LINE_SET_CONFIG_IOCTL")
> Fixes: 7b8e00d98168 ("gpiolib: cdev: support GPIO_V2_LINE_SET_VALUES_IOCTL")
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> Reviewed-by: Kent Gibson <warthog618@gmail.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/gpio/gpiolib-cdev.c | 166 +++++++++++++++++++++++++++++++-----
>  drivers/gpio/gpiolib.c      |   4 +
>  drivers/gpio/gpiolib.h      |   5 ++
>  3 files changed, 153 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
> index 911d91668903..18c5e70ee7de 100644
> --- a/drivers/gpio/gpiolib-cdev.c
> +++ b/drivers/gpio/gpiolib-cdev.c
> @@ -84,6 +84,53 @@ struct linehandle_state {
>  	GPIOHANDLE_REQUEST_OPEN_DRAIN | \
>  	GPIOHANDLE_REQUEST_OPEN_SOURCE)
>  
> +typedef __poll_t (*poll_fn)(struct file *, struct poll_table_struct *);
> +typedef long (*ioctl_fn)(struct file *, unsigned int, unsigned long);
> +typedef ssize_t (*read_fn)(struct file *, char __user *,
> +			   size_t count, loff_t *);
> +
> +static __poll_t call_poll_locked(struct file *file,
> +				 struct poll_table_struct *wait,
> +				 struct gpio_device *gdev, poll_fn func)
> +{
> +	__poll_t ret;
> +
> +	if (!down_read_trylock(&gdev->sem))

> +		return 0;

EPOLLHUP?

> +	ret = func(file, wait);
> +	up_read(&gdev->sem);
> +
> +	return ret;
> +}
> +
> +static long call_ioctl_locked(struct file *file, unsigned int cmd,
> +			      unsigned long arg, struct gpio_device *gdev,
> +			      ioctl_fn func)
> +{
> +	long ret;
> +
> +	if (!down_read_trylock(&gdev->sem))
> +		return -ENODEV;
> +	ret = func(file, cmd, arg);
> +	up_read(&gdev->sem);
> +
> +	return ret;
> +}
> +
> +static ssize_t call_read_locked(struct file *file, char __user *buf,
> +				size_t count, loff_t *f_ps,
> +				struct gpio_device *gdev, read_fn func)
> +{
> +	ssize_t ret;
> +
> +	if (!down_read_trylock(&gdev->sem))
> +		return -ENODEV;
> +	ret = func(file, buf, count, f_ps);
> +	up_read(&gdev->sem);
> +
> +	return ret;
> +}
> +
>  static int linehandle_validate_flags(u32 flags)
>  {
>  	/* Return an error if an unknown flag is set */
> @@ -191,8 +238,8 @@ static long linehandle_set_config(struct linehandle_state *lh,
>  	return 0;
>  }
>  
> -static long linehandle_ioctl(struct file *file, unsigned int cmd,
> -			     unsigned long arg)
> +static long linehandle_ioctl_unlocked(struct file *file, unsigned int cmd,
> +				      unsigned long arg)
>  {
>  	struct linehandle_state *lh = file->private_data;
>  	void __user *ip = (void __user *)arg;
> @@ -250,6 +297,15 @@ static long linehandle_ioctl(struct file *file, unsigned int cmd,
>  	}
>  }
>  
> +static long linehandle_ioctl(struct file *file, unsigned int cmd,
> +			     unsigned long arg)
> +{
> +	struct linehandle_state *lh = file->private_data;
> +
> +	return call_ioctl_locked(file, cmd, arg, lh->gdev,
> +				 linehandle_ioctl_unlocked);
> +}
> +
>  #ifdef CONFIG_COMPAT
>  static long linehandle_ioctl_compat(struct file *file, unsigned int cmd,
>  				    unsigned long arg)
> @@ -1381,8 +1437,8 @@ static long linereq_set_config(struct linereq *lr, void __user *ip)
>  	return ret;
>  }
>  
> -static long linereq_ioctl(struct file *file, unsigned int cmd,
> -			  unsigned long arg)
> +static long linereq_ioctl_unlocked(struct file *file, unsigned int cmd,
> +				   unsigned long arg)
>  {
>  	struct linereq *lr = file->private_data;
>  	void __user *ip = (void __user *)arg;
> @@ -1402,6 +1458,15 @@ static long linereq_ioctl(struct file *file, unsigned int cmd,
>  	}
>  }
>  
> +static long linereq_ioctl(struct file *file, unsigned int cmd,
> +			  unsigned long arg)
> +{
> +	struct linereq *lr = file->private_data;
> +
> +	return call_ioctl_locked(file, cmd, arg, lr->gdev,
> +				 linereq_ioctl_unlocked);
> +}
> +
>  #ifdef CONFIG_COMPAT
>  static long linereq_ioctl_compat(struct file *file, unsigned int cmd,
>  				 unsigned long arg)
> @@ -1410,8 +1475,8 @@ static long linereq_ioctl_compat(struct file *file, unsigned int cmd,
>  }
>  #endif
>  
> -static __poll_t linereq_poll(struct file *file,
> -			    struct poll_table_struct *wait)
> +static __poll_t linereq_poll_unlocked(struct file *file,
> +				      struct poll_table_struct *wait)
>  {
>  	struct linereq *lr = file->private_data;
>  	__poll_t events = 0;
> @@ -1428,10 +1493,16 @@ static __poll_t linereq_poll(struct file *file,
>  	return events;
>  }
>  
> -static ssize_t linereq_read(struct file *file,
> -			    char __user *buf,
> -			    size_t count,
> -			    loff_t *f_ps)
> +static __poll_t linereq_poll(struct file *file,
> +			     struct poll_table_struct *wait)
> +{
> +	struct linereq *lr = file->private_data;
> +
> +	return call_poll_locked(file, wait, lr->gdev, linereq_poll_unlocked);
> +}
> +
> +static ssize_t linereq_read_unlocked(struct file *file, char __user *buf,
> +				     size_t count, loff_t *f_ps)
>  {
>  	struct linereq *lr = file->private_data;
>  	struct gpio_v2_line_event le;
> @@ -1485,6 +1556,15 @@ static ssize_t linereq_read(struct file *file,
>  	return bytes_read;
>  }
>  
> +static ssize_t linereq_read(struct file *file, char __user *buf,
> +			    size_t count, loff_t *f_ps)
> +{
> +	struct linereq *lr = file->private_data;
> +
> +	return call_read_locked(file, buf, count, f_ps, lr->gdev,
> +				linereq_read_unlocked);
> +}
> +
>  static void linereq_free(struct linereq *lr)
>  {
>  	unsigned int i;
> @@ -1722,8 +1802,8 @@ struct lineevent_state {
>  	(GPIOEVENT_REQUEST_RISING_EDGE | \
>  	GPIOEVENT_REQUEST_FALLING_EDGE)
>  
> -static __poll_t lineevent_poll(struct file *file,
> -			       struct poll_table_struct *wait)
> +static __poll_t lineevent_poll_unlocked(struct file *file,
> +					struct poll_table_struct *wait)
>  {
>  	struct lineevent_state *le = file->private_data;
>  	__poll_t events = 0;
> @@ -1739,15 +1819,21 @@ static __poll_t lineevent_poll(struct file *file,
>  	return events;
>  }
>  
> +static __poll_t lineevent_poll(struct file *file,
> +			       struct poll_table_struct *wait)
> +{
> +	struct lineevent_state *le = file->private_data;
> +
> +	return call_poll_locked(file, wait, le->gdev, lineevent_poll_unlocked);
> +}
> +
>  struct compat_gpioeevent_data {
>  	compat_u64	timestamp;
>  	u32		id;
>  };
>  
> -static ssize_t lineevent_read(struct file *file,
> -			      char __user *buf,
> -			      size_t count,
> -			      loff_t *f_ps)
> +static ssize_t lineevent_read_unlocked(struct file *file, char __user *buf,
> +				       size_t count, loff_t *f_ps)
>  {
>  	struct lineevent_state *le = file->private_data;
>  	struct gpioevent_data ge;
> @@ -1815,6 +1901,15 @@ static ssize_t lineevent_read(struct file *file,
>  	return bytes_read;
>  }
>  
> +static ssize_t lineevent_read(struct file *file, char __user *buf,
> +			      size_t count, loff_t *f_ps)
> +{
> +	struct lineevent_state *le = file->private_data;
> +
> +	return call_read_locked(file, buf, count, f_ps, le->gdev,
> +				lineevent_read_unlocked);
> +}
> +
>  static void lineevent_free(struct lineevent_state *le)
>  {
>  	if (le->irq)
> @@ -1832,8 +1927,8 @@ static int lineevent_release(struct inode *inode, struct file *file)
>  	return 0;
>  }
>  
> -static long lineevent_ioctl(struct file *file, unsigned int cmd,
> -			    unsigned long arg)
> +static long lineevent_ioctl_unlocked(struct file *file, unsigned int cmd,
> +				     unsigned long arg)
>  {
>  	struct lineevent_state *le = file->private_data;
>  	void __user *ip = (void __user *)arg;
> @@ -1864,6 +1959,15 @@ static long lineevent_ioctl(struct file *file, unsigned int cmd,
>  	return -EINVAL;
>  }
>  
> +static long lineevent_ioctl(struct file *file, unsigned int cmd,
> +			    unsigned long arg)
> +{
> +	struct lineevent_state *le = file->private_data;
> +
> +	return call_ioctl_locked(file, cmd, arg, le->gdev,
> +				 lineevent_ioctl_unlocked);
> +}
> +
>  #ifdef CONFIG_COMPAT
>  static long lineevent_ioctl_compat(struct file *file, unsigned int cmd,
>  				   unsigned long arg)
> @@ -2422,8 +2526,8 @@ static int lineinfo_changed_notify(struct notifier_block *nb,
>  	return NOTIFY_OK;
>  }
>  
> -static __poll_t lineinfo_watch_poll(struct file *file,
> -				    struct poll_table_struct *pollt)
> +static __poll_t lineinfo_watch_poll_unlocked(struct file *file,
> +					     struct poll_table_struct *pollt)
>  {
>  	struct gpio_chardev_data *cdev = file->private_data;
>  	__poll_t events = 0;
> @@ -2440,8 +2544,17 @@ static __poll_t lineinfo_watch_poll(struct file *file,
>  	return events;
>  }
>  
> -static ssize_t lineinfo_watch_read(struct file *file, char __user *buf,
> -				   size_t count, loff_t *off)
> +static __poll_t lineinfo_watch_poll(struct file *file,
> +				    struct poll_table_struct *pollt)
> +{
> +	struct gpio_chardev_data *cdev = file->private_data;
> +
> +	return call_poll_locked(file, pollt, cdev->gdev,
> +				lineinfo_watch_poll_unlocked);
> +}
> +
> +static ssize_t lineinfo_watch_read_unlocked(struct file *file, char __user *buf,
> +					    size_t count, loff_t *off)
>  {
>  	struct gpio_chardev_data *cdev = file->private_data;
>  	struct gpio_v2_line_info_changed event;
> @@ -2519,6 +2632,15 @@ static ssize_t lineinfo_watch_read(struct file *file, char __user *buf,
>  	return bytes_read;
>  }
>  
> +static ssize_t lineinfo_watch_read(struct file *file, char __user *buf,
> +				   size_t count, loff_t *off)
> +{
> +	struct gpio_chardev_data *cdev = file->private_data;
> +
> +	return call_read_locked(file, buf, count, off, cdev->gdev,
> +				lineinfo_watch_read_unlocked);
> +}
> +
>  /**
>   * gpio_chrdev_open() - open the chardev for ioctl operations
>   * @inode: inode for this chardev
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index 4756ea08894f..e0e73bd756ca 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -731,6 +731,7 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
>  	spin_unlock_irqrestore(&gpio_lock, flags);
>  
>  	BLOCKING_INIT_NOTIFIER_HEAD(&gdev->notifier);
> +	init_rwsem(&gdev->sem);
>  
>  #ifdef CONFIG_PINCTRL
>  	INIT_LIST_HEAD(&gdev->pin_ranges);
> @@ -865,6 +866,8 @@ void gpiochip_remove(struct gpio_chip *gc)
>  	unsigned long	flags;
>  	unsigned int	i;
>  
> +	down_write(&gdev->sem);
> +
>  	/* FIXME: should the legacy sysfs handling be moved to gpio_device? */
>  	gpiochip_sysfs_unregister(gdev);
>  	gpiochip_free_hogs(gc);
> @@ -899,6 +902,7 @@ void gpiochip_remove(struct gpio_chip *gc)
>  	 * gone.
>  	 */
>  	gcdev_unregister(gdev);
> +	up_write(&gdev->sem);
>  	put_device(&gdev->dev);
>  }
>  EXPORT_SYMBOL_GPL(gpiochip_remove);
> diff --git a/drivers/gpio/gpiolib.h b/drivers/gpio/gpiolib.h
> index d900ecdbac46..9ad68a0adf4a 100644
> --- a/drivers/gpio/gpiolib.h
> +++ b/drivers/gpio/gpiolib.h
> @@ -15,6 +15,7 @@
>  #include <linux/device.h>
>  #include <linux/module.h>
>  #include <linux/cdev.h>
> +#include <linux/rwsem.h>
>  
>  #define GPIOCHIP_NAME	"gpiochip"
>  
> @@ -39,6 +40,9 @@
>   * @list: links gpio_device:s together for traversal
>   * @notifier: used to notify subscribers about lines being requested, released
>   *            or reconfigured
> + * @sem: protects the structure from a NULL-pointer dereference of @chip by
> + *       user-space operations when the device gets unregistered during
> + *       a hot-unplug event
>   * @pin_ranges: range of pins served by the GPIO driver
>   *
>   * This state container holds most of the runtime variable data
> @@ -60,6 +64,7 @@ struct gpio_device {
>  	void			*data;
>  	struct list_head        list;
>  	struct blocking_notifier_head notifier;
> +	struct rw_semaphore	sem;
>  
>  #ifdef CONFIG_PINCTRL
>  	/*
> -- 
> 2.37.2
> 

-- 
With Best Regards,
Andy Shevchenko


