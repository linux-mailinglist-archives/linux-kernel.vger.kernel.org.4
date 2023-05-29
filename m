Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2412714DEC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 18:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbjE2QKw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 12:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjE2QKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 12:10:50 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BA6DA3;
        Mon, 29 May 2023 09:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685376649; x=1716912649;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=uX5G8j5S3YoVRfqWgQ4v6q8WIzripHxImx8piZ0NEAo=;
  b=FOeme0cI9qy/E0kKooYTx5IniMXMTK+faXijWeYhabLBVZ5qRPMTvJ/P
   NUZMGzIi5ovD2xVtis/LjtybOSj17c4izKJMfawUvwwUoOEf23cyr24bT
   3efdTI+iEiosA7oA+/+NL+kVdlXvE1LSV31n4Rc9m8w/opPIP9hjWFkG7
   steeo5+dcIoG71smLKG4AwUItjrXnLV9An9esEI2kTATannumEMfpGyGU
   mQObZ+1Wfu9m+s7kSzAPxCMsB8QJokH8IiUkYpWg1ItXWIgzVR0JohVFi
   22/HtQDY//y4ntuQOHekjCnvNo7ro5DzK9PScUPgrZjSRux7bXbKda8tt
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="352237454"
X-IronPort-AV: E=Sophos;i="6.00,201,1681196400"; 
   d="scan'208";a="352237454"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2023 09:10:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="952808944"
X-IronPort-AV: E=Sophos;i="6.00,201,1681196400"; 
   d="scan'208";a="952808944"
Received: from btaubert-mobl1.ger.corp.intel.com ([10.252.55.237])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2023 09:10:45 -0700
Date:   Mon, 29 May 2023 19:10:42 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Hugo Villeneuve <hugo@hugovil.com>
cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jirislaby@kernel.org, jringle@gridpoint.com,
        l.perczak@camlintechnologies.com, tomasz.mon@camlingroup.com,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>
Subject: Re: [PATCH v4 7/9] serial: sc16is7xx: fix regression with GPIO
 configuration
In-Reply-To: <20230529140711.896830-8-hugo@hugovil.com>
Message-ID: <27928546-e241-7ff9-5e48-56eabf6c3aaa@linux.intel.com>
References: <20230529140711.896830-1-hugo@hugovil.com> <20230529140711.896830-8-hugo@hugovil.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1968919879-1685376460=:2737"
Content-ID: <783c8dfd-8370-3f2-699d-4abf8892bc2@linux.intel.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1968919879-1685376460=:2737
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <b3f440cd-d687-4e96-1bfd-d69241eb8eb9@linux.intel.com>

On Mon, 29 May 2023, Hugo Villeneuve wrote:

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
> Allow to specify GPIO or modem control line function in the device
> tree, and for each of the ports (A or B).
> 
> Do so by using the new device-tree property named
> "modem-control-line-ports" (property added in separate patch).
> 
> When registering GPIO chip controller, mask-out GPIO pins declared as
> modem control lines according to this new "modem-control-line-ports"
> DT property.
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

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
 i.


> ---
>  drivers/tty/serial/sc16is7xx.c | 82 +++++++++++++++++++++++++---------
>  1 file changed, 62 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
> index 7a993add3f04..34739b31b44b 100644
> --- a/drivers/tty/serial/sc16is7xx.c
> +++ b/drivers/tty/serial/sc16is7xx.c
> @@ -236,7 +236,8 @@
>  
>  /* IOControl register bits (Only 750/760) */
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
> +	unsigned long			gpio_valid_mask;
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
> @@ -1359,16 +1356,45 @@ static int sc16is7xx_gpio_direction_output(struct gpio_chip *chip,
>  	return 0;
>  }
>  
> -static int sc16is7xx_setup_gpio_chip(struct device *dev)
> +static int sc16is7xx_gpio_init_valid_mask(struct gpio_chip *chip,
> +					  unsigned long *valid_mask,
> +					  unsigned int ngpios)
> +{
> +	struct sc16is7xx_port *s = gpiochip_get_data(chip);
> +
> +	*valid_mask = s->gpio_valid_mask;
> +
> +	return 0;
> +}
> +
> +static int sc16is7xx_setup_gpio_chip(struct device *dev, u8 mctrl_mask)
>  {
>  	struct sc16is7xx_port *s = dev_get_drvdata(dev);
>  
>  	if (!s->devtype->nr_gpio)
>  		return 0;
>  
> +	switch (mctrl_mask) {
> +	case 0:
> +		s->gpio_valid_mask = 0xFF;
> +		break;
> +	case SC16IS7XX_IOCONTROL_MODEM_A_BIT:
> +		s->gpio_valid_mask = 0x0F;
> +		break;
> +	case SC16IS7XX_IOCONTROL_MODEM_B_BIT:
> +		s->gpio_valid_mask = 0xF0;
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	if (!s->gpio_valid_mask)
> +		return 0;
> +
>  	s->gpio.owner		 = THIS_MODULE;
>  	s->gpio.parent		 = dev;
>  	s->gpio.label		 = dev_name(dev);
> +	s->gpio.init_valid_mask	 = sc16is7xx_gpio_init_valid_mask;
>  	s->gpio.direction_input	 = sc16is7xx_gpio_direction_input;
>  	s->gpio.get		 = sc16is7xx_gpio_get;
>  	s->gpio.direction_output = sc16is7xx_gpio_direction_output;
> @@ -1392,6 +1418,7 @@ static int sc16is7xx_probe(struct device *dev,
>  {
>  	unsigned long freq = 0, *pfreq = dev_get_platdata(dev);
>  	unsigned int val;
> +	u8 mctrl_mask = 0;
>  	u32 uartclk = 0;
>  	int i, ret;
>  	struct sc16is7xx_port *s;
> @@ -1493,12 +1520,6 @@ static int sc16is7xx_probe(struct device *dev,
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
> @@ -1534,6 +1555,27 @@ static int sc16is7xx_probe(struct device *dev,
>  					 prop, p, u)
>  			if (u < devtype->nr_uart)
>  				s->p[u].irda_mode = true;
> +
> +		of_property_for_each_u32(dev->of_node, "nxp,modem-control-line-ports",
> +					 prop, p, u) {
> +			if (u >= devtype->nr_uart)
> +				continue;
> +
> +			/* Use GPIO lines as modem control lines */
> +			if (u == 0)
> +				mctrl_mask |= SC16IS7XX_IOCONTROL_MODEM_A_BIT;
> +			else if (u == 1)
> +				mctrl_mask |= SC16IS7XX_IOCONTROL_MODEM_B_BIT;
> +		}
> +
> +		if (mctrl_mask) {
> +			regmap_update_bits(
> +				s->regmap,
> +				SC16IS7XX_IOCONTROL_REG << SC16IS7XX_REG_SHIFT,
> +				SC16IS7XX_IOCONTROL_MODEM_A_BIT |
> +				SC16IS7XX_IOCONTROL_MODEM_B_BIT,
> +				mctrl_mask);
> +		}
>  	}
>  
>  #ifdef CONFIG_GPIOLIB
> @@ -1562,7 +1604,7 @@ static int sc16is7xx_probe(struct device *dev,
>  		return 0;
>  
>  #ifdef CONFIG_GPIOLIB
> -	if (devtype->nr_gpio)
> +	if (s->gpio_valid_mask)
>  		gpiochip_remove(&s->gpio);
>  
>  out_thread:
> @@ -1588,7 +1630,7 @@ static void sc16is7xx_remove(struct device *dev)
>  	int i;
>  
>  #ifdef CONFIG_GPIOLIB
> -	if (s->devtype->nr_gpio)
> +	if (s->gpio_valid_mask)
>  		gpiochip_remove(&s->gpio);
>  #endif
>  
> 
--8323329-1968919879-1685376460=:2737--
