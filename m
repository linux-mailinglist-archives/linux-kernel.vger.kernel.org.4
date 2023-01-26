Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC1867CD39
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 15:02:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbjAZOC4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 09:02:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231644AbjAZOCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 09:02:42 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 432E86ACA4;
        Thu, 26 Jan 2023 06:02:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674741738; x=1706277738;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=PS05jjEDpy/yAsZOPr8j87cutyiw8U+Z+Nga2JKzuyw=;
  b=BLXEBThgpmM8iv2K5iGLc+bK+mAx/D7Us70Ly1U+FH8fR0fQ9p7bIGJC
   CjwLFqwHjTk8D7PHHk3AWXHkdVf+6InvDyentusUwxfB6PqGFnotyLL/s
   5BqyjGSDWpABJbfyWQ4xNSv1rka0ouKeEXAUD57aD3e4hupkwIhRX8NYV
   MARCOOt6qxlwe15dHvD81eXCT64+vwxcCPw3sDzoDbEpCnq8D5li9OIYP
   K58sIyUtD7buLGv+3+MD1oTmW6lQxpOYIqkQ/5v4nWWxSePDDxcsd9fGe
   kkWuHx57lqKENWFfpsqQUTr/h30CcU5rTYwzyxSVNZCj7Pvrmsa5ultXb
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="389153689"
X-IronPort-AV: E=Sophos;i="5.97,248,1669104000"; 
   d="scan'208";a="389153689"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2023 06:00:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="805379222"
X-IronPort-AV: E=Sophos;i="5.97,248,1669104000"; 
   d="scan'208";a="805379222"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP; 26 Jan 2023 06:00:18 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pL2nZ-00FQZF-0d;
        Thu, 26 Jan 2023 16:00:17 +0200
Date:   Thu, 26 Jan 2023 16:00:16 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     linux-gpio@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/8] gpiolib: remove legacy gpio_export
Message-ID: <Y9KHcPYPUIjiP3zQ@smile.fi.intel.com>
References: <20230126132801.2042371-1-arnd@kernel.org>
 <20230126132801.2042371-6-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230126132801.2042371-6-arnd@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2023 at 02:27:58PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> There are only a handful of users of gpio_export() and
> related functions.
> 
> As these are just wrappers around the modern gpiod_export()
> helper, remove the wrappers and open-code the gpio_to_desc
> in all callers to shrink the legacy API.


A couple of comments below, after addressing:
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  Documentation/admin-guide/gpio/sysfs.rst      |  2 +-
>  Documentation/driver-api/gpio/legacy.rst      | 21 ---------------
>  .../zh_CN/driver-api/gpio/legacy.rst          | 20 --------------
>  Documentation/translations/zh_TW/gpio.txt     | 18 -------------
>  arch/arm/mach-omap2/pdata-quirks.c            |  9 ++++---
>  arch/sh/boards/mach-ap325rxa/setup.c          |  7 ++---
>  drivers/gpio/gpiolib-sysfs.c                  |  4 +--
>  drivers/media/pci/sta2x11/sta2x11_vip.c       | 10 ++++---
>  drivers/net/ieee802154/ca8210.c               |  3 ++-
>  include/linux/gpio.h                          | 27 -------------------
>  10 files changed, 21 insertions(+), 100 deletions(-)
> 
> diff --git a/Documentation/admin-guide/gpio/sysfs.rst b/Documentation/admin-guide/gpio/sysfs.rst
> index ec09ffd983e7..35171d15f78d 100644
> --- a/Documentation/admin-guide/gpio/sysfs.rst
> +++ b/Documentation/admin-guide/gpio/sysfs.rst
> @@ -145,7 +145,7 @@ requested using gpio_request()::
>  	/* export the GPIO to userspace */
>  	int gpiod_export(struct gpio_desc *desc, bool direction_may_change);
>  
> -	/* reverse gpio_export() */
> +	/* reverse gpiod_export() */
>  	void gpiod_unexport(struct gpio_desc *desc);
>  
>  	/* create a sysfs link to an exported GPIO node */
> diff --git a/Documentation/driver-api/gpio/legacy.rst b/Documentation/driver-api/gpio/legacy.rst
> index e0306e78e34b..78372853c6d4 100644
> --- a/Documentation/driver-api/gpio/legacy.rst
> +++ b/Documentation/driver-api/gpio/legacy.rst
> @@ -714,27 +714,6 @@ gpiochip nodes (possibly in conjunction with schematics) to determine
>  the correct GPIO number to use for a given signal.
>  
>  
> -Exporting from Kernel code
> ---------------------------
> -Kernel code can explicitly manage exports of GPIOs which have already been
> -requested using gpio_request()::
> -
> -	/* export the GPIO to userspace */
> -	int gpio_export(unsigned gpio, bool direction_may_change);
> -
> -	/* reverse gpio_export() */
> -	void gpio_unexport();
> -
> -After a kernel driver requests a GPIO, it may only be made available in
> -the sysfs interface by gpio_export().  The driver can control whether the
> -signal direction may change.  This helps drivers prevent userspace code
> -from accidentally clobbering important system state.
> -
> -This explicit exporting can help with debugging (by making some kinds
> -of experiments easier), or can provide an always-there interface that's
> -suitable for documenting as part of a board support package.
> -
> -
>  API Reference
>  =============
>  
> diff --git a/Documentation/translations/zh_CN/driver-api/gpio/legacy.rst b/Documentation/translations/zh_CN/driver-api/gpio/legacy.rst
> index 74fa473bb504..2164999077a6 100644
> --- a/Documentation/translations/zh_CN/driver-api/gpio/legacy.rst
> +++ b/Documentation/translations/zh_CN/driver-api/gpio/legacy.rst
> @@ -654,26 +654,6 @@ GPIO 控制器的路径类似 /sys/class/gpio/gpiochip42/ (对于从#42 GPIO
>  确定给定信号所用的 GPIO 编号。
>  
>  
> -从内核代码中导出
> -----------------
> -
> -内核代码可以明确地管理那些已通过 gpio_request()申请的 GPIO 的导出::
> -
> -	/* 导出 GPIO 到用户空间 */
> -	int gpio_export(unsigned gpio, bool direction_may_change);
> -
> -	/* gpio_export()的逆操作 */
> -	void gpio_unexport();
> -
> -在一个内核驱动申请一个 GPIO 之后，它可以通过 gpio_export()使其在 sysfs
> -接口中可见。该驱动可以控制信号方向是否可修改。这有助于防止用户空间代码无意间
> -破坏重要的系统状态。
> -
> -这个明确的导出有助于(通过使某些实验更容易来)调试，也可以提供一个始终存在的接口，
> -与文档配合作为板级支持包的一部分。
> -
> -

> -API参考

Mistakenly removed?

>  =======
>  
>  本节中列出的函数已被废弃。在新的代码中应该使用基于GPIO描述符的API。
> diff --git a/Documentation/translations/zh_TW/gpio.txt b/Documentation/translations/zh_TW/gpio.txt
> index 1b986bbb0909..79076f535faa 100644
> --- a/Documentation/translations/zh_TW/gpio.txt
> +++ b/Documentation/translations/zh_TW/gpio.txt
> @@ -615,21 +615,3 @@ GPIO 控制器的路徑類似 /sys/class/gpio/gpiochip42/ (對於從#42 GPIO
>  固定的,例如在擴展卡上的 GPIO會根據所使用的主板或所在堆疊架構中其他的板子而
>  有所不同。在這種情況下,你可能需要使用 gpiochip 節點(儘可能地結合電路圖)來
>  確定給定信號所用的 GPIO 編號。
> -
> -
> -從內核代碼中導出
> --------------
> -內核代碼可以明確地管理那些已通過 gpio_request()申請的 GPIO 的導出:
> -
> -	/* 導出 GPIO 到用戶空間 */
> -	int gpio_export(unsigned gpio, bool direction_may_change);
> -
> -	/* gpio_export()的逆操作 */
> -	void gpio_unexport();
> -
> -在一個內核驅動申請一個 GPIO 之後，它可以通過 gpio_export()使其在 sysfs
> -接口中可見。該驅動可以控制信號方向是否可修改。這有助於防止用戶空間代碼無意間
> -破壞重要的系統狀態。
> -
> -這個明確的導出有助於(通過使某些實驗更容易來)調試，也可以提供一個始終存在的接口，
> -與文檔配合作爲板級支持包的一部分。
> diff --git a/arch/arm/mach-omap2/pdata-quirks.c b/arch/arm/mach-omap2/pdata-quirks.c
> index 248478af5bfa..ee90fb42c955 100644
> --- a/arch/arm/mach-omap2/pdata-quirks.c
> +++ b/arch/arm/mach-omap2/pdata-quirks.c
> @@ -6,6 +6,7 @@
>   */
>  #include <linux/clk.h>
>  #include <linux/davinci_emac.h>
> +#include <linux/gpio/consumer.h>
>  #include <linux/gpio.h>
>  #include <linux/init.h>
>  #include <linux/kernel.h>
> @@ -108,7 +109,7 @@ static int omap3_sbc_t3730_twl_callback(struct device *dev,
>  	if (res)
>  		return res;
>  
> -	gpio_export(gpio, 0);
> +	gpiod_export(gpio_to_desc(gpio), 0);
>  
>  	return 0;
>  }
> @@ -123,7 +124,7 @@ static void __init omap3_sbc_t3x_usb_hub_init(int gpio, char *hub_name)
>  		return;
>  	}
>  
> -	gpio_export(gpio, 0);
> +	gpiod_export(gpio_to_desc(gpio), 0);
>  
>  	udelay(10);
>  	gpio_set_value(gpio, 1);
> @@ -200,8 +201,8 @@ static void __init omap3_sbc_t3517_wifi_init(void)
>  		return;
>  	}
>  
> -	gpio_export(cm_t3517_wlan_gpios[0].gpio, 0);
> -	gpio_export(cm_t3517_wlan_gpios[1].gpio, 0);
> +	gpiod_export(gpio_to_desc(cm_t3517_wlan_gpios[0].gpio), 0);
> +	gpiod_export(gpio_to_desc(cm_t3517_wlan_gpios[1].gpio), 0);
>  
>  	msleep(100);
>  	gpio_set_value(cm_t3517_wlan_gpios[1].gpio, 0);
> diff --git a/arch/sh/boards/mach-ap325rxa/setup.c b/arch/sh/boards/mach-ap325rxa/setup.c
> index 6e66ac194f7d..48055991152c 100644
> --- a/arch/sh/boards/mach-ap325rxa/setup.c
> +++ b/arch/sh/boards/mach-ap325rxa/setup.c
> @@ -18,6 +18,7 @@
>  #include <linux/delay.h>
>  #include <linux/device.h>
>  #include <linux/gpio.h>
> +#include <linux/gpio/consumer.h>
>  #include <linux/gpio/machine.h>
>  #include <linux/i2c.h>
>  #include <linux/init.h>
> @@ -411,16 +412,16 @@ static int __init ap325rxa_devices_setup(void)
>  	/* LD3 and LD4 LEDs */
>  	gpio_request(GPIO_PTX5, NULL); /* RUN */
>  	gpio_direction_output(GPIO_PTX5, 1);
> -	gpio_export(GPIO_PTX5, 0);
> +	gpiod_export(gpio_to_desc(GPIO_PTX5), 0);
>  
>  	gpio_request(GPIO_PTX4, NULL); /* INDICATOR */
>  	gpio_direction_output(GPIO_PTX4, 0);
> -	gpio_export(GPIO_PTX4, 0);
> +	gpiod_export(gpio_to_desc(GPIO_PTX4), 0);
>  
>  	/* SW1 input */
>  	gpio_request(GPIO_PTF7, NULL); /* MODE */
>  	gpio_direction_input(GPIO_PTF7);
> -	gpio_export(GPIO_PTF7, 0);
> +	gpiod_export(gpio_to_desc(GPIO_PTF7), 0);
>  
>  	/* LCDC */
>  	gpio_request(GPIO_FN_LCDD15, NULL);
> diff --git a/drivers/gpio/gpiolib-sysfs.c b/drivers/gpio/gpiolib-sysfs.c
> index cd27bf173dec..cee135eb768e 100644
> --- a/drivers/gpio/gpiolib-sysfs.c
> +++ b/drivers/gpio/gpiolib-sysfs.c
> @@ -491,7 +491,7 @@ static ssize_t unexport_store(struct class *class,
>  		goto done;
>  
>  	desc = gpio_to_desc(gpio);
> -	/* reject bogus commands (gpio_unexport ignores them) */
> +	/* reject bogus commands (gpiod_unexport ignores them) */

While at it,

	/* reject bogus commands (gpiod_unexport() ignores them) */

>  	if (!desc) {
>  		pr_warn("%s: invalid GPIO %ld\n", __func__, gpio);
>  		return -EINVAL;
> @@ -790,7 +790,7 @@ static int __init gpiolib_sysfs_init(void)
>  	 * early (e.g. before the class_register above was called).
>  	 *
>  	 * We run before arch_initcall() so chip->dev nodes can have
> -	 * registered, and so arch_initcall() can always gpio_export().
> +	 * registered, and so arch_initcall() can always gpiod_export().
>  	 */
>  	spin_lock_irqsave(&gpio_lock, flags);
>  	list_for_each_entry(gdev, &gpio_devices, list) {
> diff --git a/drivers/media/pci/sta2x11/sta2x11_vip.c b/drivers/media/pci/sta2x11/sta2x11_vip.c
> index 8535e49a4c4f..e4cf9d63e926 100644
> --- a/drivers/media/pci/sta2x11/sta2x11_vip.c
> +++ b/drivers/media/pci/sta2x11/sta2x11_vip.c
> @@ -18,6 +18,7 @@
>  #include <linux/pci.h>
>  #include <linux/interrupt.h>
>  #include <linux/io.h>
> +#include <linux/gpio/consumer.h>
>  #include <linux/gpio.h>
>  #include <linux/i2c.h>
>  #include <linux/delay.h>
> @@ -889,6 +890,7 @@ static int sta2x11_vip_init_controls(struct sta2x11_vip *vip)
>  static int vip_gpio_reserve(struct device *dev, int pin, int dir,
>  			    const char *name)
>  {
> +	struct gpio_desc *desc = gpio_to_desc(pin);
>  	int ret = -ENODEV;
>  
>  	if (!gpio_is_valid(pin))
> @@ -900,7 +902,7 @@ static int vip_gpio_reserve(struct device *dev, int pin, int dir,
>  		return ret;
>  	}
>  
> -	ret = gpio_direction_output(pin, dir);
> +	ret = gpiod_direction_output(desc, dir);
>  	if (ret) {
>  		dev_err(dev, "Failed to set direction for pin %d (%s)\n",
>  			pin, name);
> @@ -908,7 +910,7 @@ static int vip_gpio_reserve(struct device *dev, int pin, int dir,
>  		return ret;
>  	}
>  
> -	ret = gpio_export(pin, false);
> +	ret = gpiod_export(desc, false);
>  	if (ret) {
>  		dev_err(dev, "Failed to export pin %d (%s)\n", pin, name);
>  		gpio_free(pin);
> @@ -928,8 +930,10 @@ static int vip_gpio_reserve(struct device *dev, int pin, int dir,
>  static void vip_gpio_release(struct device *dev, int pin, const char *name)
>  {
>  	if (gpio_is_valid(pin)) {
> +		struct gpio_desc *desc = gpio_to_desc(pin);
> +
>  		dev_dbg(dev, "releasing pin %d (%s)\n",	pin, name);
> -		gpio_unexport(pin);
> +		gpiod_unexport(desc);
>  		gpio_free(pin);
>  	}
>  }
> diff --git a/drivers/net/ieee802154/ca8210.c b/drivers/net/ieee802154/ca8210.c
> index e1a569b99e4a..5c0be6a3ec5e 100644
> --- a/drivers/net/ieee802154/ca8210.c
> +++ b/drivers/net/ieee802154/ca8210.c
> @@ -51,6 +51,7 @@
>  #include <linux/clk-provider.h>
>  #include <linux/debugfs.h>
>  #include <linux/delay.h>
> +#include <linux/gpio/consumer.h>
>  #include <linux/gpio.h>
>  #include <linux/ieee802154.h>
>  #include <linux/io.h>
> @@ -2853,7 +2854,7 @@ static int ca8210_interrupt_init(struct spi_device *spi)
>  	);
>  	if (ret) {
>  		dev_crit(&spi->dev, "request_irq %d failed\n", pdata->irq_id);
> -		gpio_unexport(pdata->gpio_irq);
> +		gpiod_unexport(gpio_to_desc(pdata->gpio_irq));
>  		gpio_free(pdata->gpio_irq);
>  	}
>  
> diff --git a/include/linux/gpio.h b/include/linux/gpio.h
> index da7a5ae68e47..57ec3975b656 100644
> --- a/include/linux/gpio.h
> +++ b/include/linux/gpio.h
> @@ -127,20 +127,6 @@ extern int gpio_request_one(unsigned gpio, unsigned long flags, const char *labe
>  extern int gpio_request_array(const struct gpio *array, size_t num);
>  extern void gpio_free_array(const struct gpio *array, size_t num);
>  
> -/*
> - * A sysfs interface can be exported by individual drivers if they want,
> - * but more typically is configured entirely from userspace.
> - */
> -static inline int gpio_export(unsigned gpio, bool direction_may_change)
> -{
> -	return gpiod_export(gpio_to_desc(gpio), direction_may_change);
> -}
> -
> -static inline void gpio_unexport(unsigned gpio)
> -{
> -	gpiod_unexport(gpio_to_desc(gpio));
> -}
> -
>  /* CONFIG_GPIOLIB: bindings for managed devices that want to request gpios */
>  
>  struct device;
> @@ -231,19 +217,6 @@ static inline void gpio_set_value_cansleep(unsigned gpio, int value)
>  	WARN_ON(1);
>  }
>  
> -static inline int gpio_export(unsigned gpio, bool direction_may_change)
> -{
> -	/* GPIO can never have been requested or set as {in,out}put */
> -	WARN_ON(1);
> -	return -EINVAL;
> -}
> -
> -static inline void gpio_unexport(unsigned gpio)
> -{
> -	/* GPIO can never have been exported */
> -	WARN_ON(1);
> -}
> -
>  static inline int gpio_to_irq(unsigned gpio)
>  {
>  	/* GPIO can never have been requested or set as input */
> -- 
> 2.39.0
> 

-- 
With Best Regards,
Andy Shevchenko


