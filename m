Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFD28710BA8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 14:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241103AbjEYMDw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 08:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240999AbjEYMDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 08:03:50 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9F3512F;
        Thu, 25 May 2023 05:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685016228; x=1716552228;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=V5ddAqCEQX3VA0kkYibfs41pf17kYhAUFUF1wg2QkC4=;
  b=kAvRiC5GxC75yveAgLJ+n9GN+cG+RLFy9YsfWfH18kuIDxNWP8PzhmOM
   ejgUuBMz6JrITfv7Gx9t4prRmyqd77xKFI2hLZymuOdBtfrzRg7J7nuUj
   azfFXG3qzx+RXLBR1/MVOa1Vkbv56HlMn0w8TA5fSyCeUTEqT36N4W3A7
   Rmu+6z7K87bnXy9dwmnwZ/zeZt3cXdgKu8Kdi8VvPLpCbWcjxFRTJbCiO
   61S5pX/MLUWIsDJR822pAnmoVgIknzOqaprxY+W7qYVkpfqeq2sm9gtkR
   lDdtHx9tmV+n9qXiGiZLme0VVfXLivn8DFLOh3hZinyiOTLvvlxadfTvl
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10720"; a="353887166"
X-IronPort-AV: E=Sophos;i="6.00,191,1681196400"; 
   d="scan'208";a="353887166"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2023 05:03:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10720"; a="879076305"
X-IronPort-AV: E=Sophos;i="6.00,191,1681196400"; 
   d="scan'208";a="879076305"
Received: from aghiriba-mobl.ger.corp.intel.com ([10.249.40.17])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2023 05:03:43 -0700
Date:   Thu, 25 May 2023 15:03:41 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Hugo Villeneuve <hugo@hugovil.com>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, Jiri Slaby <jirislaby@kernel.org>,
        jringle@gridpoint.com, tomasz.mon@camlingroup.com,
        l.perczak@camlintechnologies.com,
        linux-serial <linux-serial@vger.kernel.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-gpio@vger.kernel.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>
Subject: Re: [PATCH v3 08/11] serial: sc16is7xx: fix regression with GPIO
 configuration
In-Reply-To: <20230525040324.3773741-9-hugo@hugovil.com>
Message-ID: <b8b6d3d-6c7b-3a94-4d29-b182f12325d@linux.intel.com>
References: <20230525040324.3773741-1-hugo@hugovil.com> <20230525040324.3773741-9-hugo@hugovil.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 May 2023, Hugo Villeneuve wrote:

> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> 
> Commit 679875d1d880 ("sc16is7xx: Separate GPIOs from modem control lines")
> and commit 21144bab4f11 ("sc16is7xx: Handle modem status lines")
> changed the function of the GPIOs pins to act as modem control
> lines without any possibility of selecting GPIO function.
> 
> As a consequence, applications that depends on GPIO lines configured
> by default as GPIO pins no longer work as expected.
> 
> Also, the change to select modem control lines function was done only
> for channel A of dual UART variants (752/762). This was not documented
> in the log message.
> 
> This new patch allows to specify GPIO or modem control line function
> in the device tree, and for each of the ports (A or B).
> 
> This is done by using the new device-tree property named
> "modem-control-line-ports" (property added in separate patch).
> 
> We also now reduce the number of exported GPIOs according to the
> modem-status-line-port DT property.
> 
> Boards that need to have GPIOS configured as modem control lines
> should add that property to their device tree. Here is a list of
> boards using the sc16is7xx driver in their device tree and that may
> need to be modified:
>     arm64/boot/dts/freescale/fsl-ls1012a-frdm.dts
>     mips/boot/dts/ingenic/cu1830-neo.dts
>     mips/boot/dts/ingenic/cu1000-neo.dts
> 
> Fixes: 679875d1d880 ("sc16is7xx: Separate GPIOs from modem control lines")
> Fixes: 21144bab4f11 ("sc16is7xx: Handle modem status lines")
> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> ---
>  drivers/tty/serial/sc16is7xx.c | 65 +++++++++++++++++++++++-----------
>  1 file changed, 44 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
> index a5d8af0f6da0..97ec532a0a19 100644
> --- a/drivers/tty/serial/sc16is7xx.c
> +++ b/drivers/tty/serial/sc16is7xx.c
> @@ -236,7 +236,8 @@
>  
>  /* IOControl register bits (Only 75x/76x) */
>  #define SC16IS7XX_IOCONTROL_LATCH_BIT	(1 << 0) /* Enable input latching */
> -#define SC16IS7XX_IOCONTROL_MODEM_BIT	(1 << 1) /* Enable GPIO[7:4] as modem pins */
> +#define SC16IS7XX_IOCONTROL_MODEM_A_BIT	(1 << 1) /* Enable GPIO[7:4] as modem A pins */
> +#define SC16IS7XX_IOCONTROL_MODEM_B_BIT	(1 << 2) /* Enable GPIO[3:0] as modem B pins */
>  #define SC16IS7XX_IOCONTROL_SRESET_BIT	(1 << 3) /* Software Reset */
>  
>  /* EFCR register bits */
> @@ -301,12 +302,12 @@
>  /* Misc definitions */
>  #define SC16IS7XX_FIFO_SIZE		(64)
>  #define SC16IS7XX_REG_SHIFT		2
> +#define SC16IS7XX_GPIOS_PER_BANK	4
>  
>  struct sc16is7xx_devtype {
>  	char	name[10];
>  	int	nr_gpio;
>  	int	nr_uart;
> -	int	has_mctrl;
>  };
>  
>  #define SC16IS7XX_RECONF_MD		(1 << 0)
> @@ -336,6 +337,7 @@ struct sc16is7xx_port {
>  	struct clk			*clk;
>  #ifdef CONFIG_GPIOLIB
>  	struct gpio_chip		gpio;
> +	int				gpio_configured;
>  #endif
>  	unsigned char			buf[SC16IS7XX_FIFO_SIZE];
>  	struct kthread_worker		kworker;
> @@ -447,35 +449,30 @@ static const struct sc16is7xx_devtype sc16is74x_devtype = {
>  	.name		= "SC16IS74X",
>  	.nr_gpio	= 0,
>  	.nr_uart	= 1,
> -	.has_mctrl	= 0,
>  };
>  
>  static const struct sc16is7xx_devtype sc16is750_devtype = {
>  	.name		= "SC16IS750",
> -	.nr_gpio	= 4,
> +	.nr_gpio	= 8,
>  	.nr_uart	= 1,
> -	.has_mctrl	= 1,
>  };
>  
>  static const struct sc16is7xx_devtype sc16is752_devtype = {
>  	.name		= "SC16IS752",
> -	.nr_gpio	= 0,
> +	.nr_gpio	= 8,
>  	.nr_uart	= 2,
> -	.has_mctrl	= 1,
>  };
>  
>  static const struct sc16is7xx_devtype sc16is760_devtype = {
>  	.name		= "SC16IS760",
> -	.nr_gpio	= 4,
> +	.nr_gpio	= 8,
>  	.nr_uart	= 1,
> -	.has_mctrl	= 1,
>  };
>  
>  static const struct sc16is7xx_devtype sc16is762_devtype = {
>  	.name		= "SC16IS762",
> -	.nr_gpio	= 0,
> +	.nr_gpio	= 8,
>  	.nr_uart	= 2,
> -	.has_mctrl	= 1,
>  };
>  
>  static bool sc16is7xx_regmap_volatile(struct device *dev, unsigned int reg)
> @@ -1396,6 +1393,10 @@ static int sc16is7xx_probe(struct device *dev,
>  		return -ENOMEM;
>  	}
>  
> +#ifdef CONFIG_GPIOLIB
> +	s->gpio_configured = devtype->nr_gpio;
> +#endif /* CONFIG_GPIOLIB */
> +
>  	/* Always ask for fixed clock rate from a property. */
>  	device_property_read_u32(dev, "clock-frequency", &uartclk);
>  
> @@ -1473,12 +1474,6 @@ static int sc16is7xx_probe(struct device *dev,
>  				     SC16IS7XX_EFCR_RXDISABLE_BIT |
>  				     SC16IS7XX_EFCR_TXDISABLE_BIT);
>  
> -		/* Use GPIO lines as modem status registers */
> -		if (devtype->has_mctrl)
> -			sc16is7xx_port_write(&s->p[i].port,
> -					     SC16IS7XX_IOCONTROL_REG,
> -					     SC16IS7XX_IOCONTROL_MODEM_BIT);
> -
>  		/* Initialize kthread work structs */
>  		kthread_init_work(&s->p[i].tx_work, sc16is7xx_tx_proc);
>  		kthread_init_work(&s->p[i].reg_work, sc16is7xx_reg_proc);
> @@ -1514,10 +1509,38 @@ static int sc16is7xx_probe(struct device *dev,
>  					 prop, p, u)
>  			if (u < devtype->nr_uart)
>  				s->p[u].irda_mode = true;
> +
> +		val = 0;
> +
> +		of_property_for_each_u32(dev->of_node, "nxp,modem-control-line-ports",
> +					 prop, p, u)
> +			if (u < devtype->nr_uart) {

Reverse logic + use continue. It will help with the indentation levels.

> +				/* Use GPIO lines as modem control lines */
> +				if (u == 0)
> +					val |= SC16IS7XX_IOCONTROL_MODEM_A_BIT;
> +				else if (u == 1)
> +					val |= SC16IS7XX_IOCONTROL_MODEM_B_BIT;
> +
> +#ifdef CONFIG_GPIOLIB
> +				if (s->gpio_configured >=
> +				    SC16IS7XX_GPIOS_PER_BANK)
> +					s->gpio_configured -=
> +						SC16IS7XX_GPIOS_PER_BANK;
> +#endif /* CONFIG_GPIOLIB */
> +			}

Please use braces for of_property_for_each_u32 block.

> +
> +		if (val)
> +			regmap_update_bits(
> +				s->regmap,
> +				SC16IS7XX_IOCONTROL_REG << SC16IS7XX_REG_SHIFT,
> +				SC16IS7XX_IOCONTROL_MODEM_A_BIT |
> +				SC16IS7XX_IOCONTROL_MODEM_B_BIT, val);
>  	}
>  
>  #ifdef CONFIG_GPIOLIB
> -	if (devtype->nr_gpio) {
> +	dev_dbg(dev, "GPIOs to configure: %d\n", s->gpio_configured);
> +
> +	if (s->gpio_configured) {
>  		/* Setup GPIO controller */
>  		s->gpio.owner		 = THIS_MODULE;
>  		s->gpio.parent		 = dev;
> @@ -1527,7 +1550,7 @@ static int sc16is7xx_probe(struct device *dev,
>  		s->gpio.direction_output = sc16is7xx_gpio_direction_output;
>  		s->gpio.set		 = sc16is7xx_gpio_set;
>  		s->gpio.base		 = -1;
> -		s->gpio.ngpio		 = devtype->nr_gpio;
> +		s->gpio.ngpio		 = s->gpio_configured;
>  		s->gpio.can_sleep	 = 1;
>  		ret = gpiochip_add_data(&s->gpio, s);
>  		if (ret)
> @@ -1555,7 +1578,7 @@ static int sc16is7xx_probe(struct device *dev,
>  		return 0;
>  
>  #ifdef CONFIG_GPIOLIB
> -	if (devtype->nr_gpio)
> +	if (s->gpio_configured)
>  		gpiochip_remove(&s->gpio);
>  
>  out_thread:
> @@ -1581,7 +1604,7 @@ static void sc16is7xx_remove(struct device *dev)
>  	int i;
>  
>  #ifdef CONFIG_GPIOLIB
> -	if (s->devtype->nr_gpio)
> +	if (s->gpio_configured)
>  		gpiochip_remove(&s->gpio);
>  #endif
>  
> 

-- 
 i.

