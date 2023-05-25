Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF43710BCD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 14:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241168AbjEYMKU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 08:10:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241132AbjEYMKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 08:10:08 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4474CE6;
        Thu, 25 May 2023 05:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685016607; x=1716552607;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=+wbTcPlTDMlWKSZMtcI8BM7oQvOICFoJz9nitmvrsjY=;
  b=mlcryji269Ft/ZYTbw1b1ma+1y410n7ctz3Suq7LfE1JFcZZ8dQ837DS
   2S/SKITnBgXaxj8kpIRtQKPItXdsZ5ns2ZZZaRQAF6KTUxcYbq8obDNs3
   h6gCnW0CUj7G+KZo+olZdbOXJ9KABCfHxN3HzSXmS94zPTY118VL9e7G6
   wkN3STkmyhA84GCb4wxCK2DWhbZ0Pgu3rcqKyDJRl+xYqw1Q2q4NPAa0I
   HIcuV2bwEBWQjrcdZzz0XlkztbBqiQRZ6hopToVxu8pBkE/M56Ul6HBxc
   xrVvkS7b8uXwT9iLTNAFhTwU8t8DT82cIqDvNQhEbSYp2VLs30eKLzRSH
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10720"; a="419587146"
X-IronPort-AV: E=Sophos;i="6.00,191,1681196400"; 
   d="scan'208";a="419587146"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2023 05:10:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10720"; a="794619703"
X-IronPort-AV: E=Sophos;i="6.00,191,1681196400"; 
   d="scan'208";a="794619703"
Received: from aghiriba-mobl.ger.corp.intel.com ([10.249.40.17])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2023 05:10:02 -0700
Date:   Thu, 25 May 2023 15:10:00 +0300 (EEST)
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
Subject: Re: [PATCH v3 09/11] serial: sc16is7xx: add I/O register translation
 offset
In-Reply-To: <20230525040324.3773741-10-hugo@hugovil.com>
Message-ID: <73413221-a87c-b619-5171-70cb117cdf@linux.intel.com>
References: <20230525040324.3773741-1-hugo@hugovil.com> <20230525040324.3773741-10-hugo@hugovil.com>
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
> If the shared GPIO pins on a dual port/channel variant like the
> SC16IS752 are configured as GPIOs for port A, and modem control lines
> on port A, we need to translate the Linux GPIO offset to an offset
> that is compatible with the I/O registers of the SC16IS7XX (IOState,
> IODir and IOIntEna).
> 
> Add a new variable to store that offset and set it when we detect that
> special case.
> 
> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> ---
>  drivers/tty/serial/sc16is7xx.c | 54 +++++++++++++++++++++++++++++++++-
>  1 file changed, 53 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
> index 97ec532a0a19..c2cfd057ed9a 100644
> --- a/drivers/tty/serial/sc16is7xx.c
> +++ b/drivers/tty/serial/sc16is7xx.c
> @@ -338,6 +338,7 @@ struct sc16is7xx_port {
>  #ifdef CONFIG_GPIOLIB
>  	struct gpio_chip		gpio;
>  	int				gpio_configured;
> +	int				gpio_offset;
>  #endif
>  	unsigned char			buf[SC16IS7XX_FIFO_SIZE];
>  	struct kthread_worker		kworker;
> @@ -1298,12 +1299,50 @@ static const struct uart_ops sc16is7xx_ops = {
>  };
>  
>  #ifdef CONFIG_GPIOLIB
> +
> +/*
> + * We may need to translate the Linux GPIO offset to a SC16IS7XX offset.
> + * This is needed only for the case where a dual port variant is configured to
> + * have only port B as modem status lines.
> + *
> + * Example for SC16IS752/762 with upper bank (port A) set as GPIOs, and
> + * lower bank (port B) set as modem status lines (special case described above):
> + *
> + * Pin         GPIO pin     Linux GPIO     SC16IS7XX
> + * name        function     offset         offset
> + * --------------------------------------------------
> + * GPIO7/RIA    GPIO7          3              7
> + * GPIO6/CDA    GPIO6          2              6
> + * GPIO5/DTRA   GPIO5          1              5
> + * GPIO4/DSRA   GPIO4          0              4
> + * GPIO3/RIB    RIB           N/A            N/A
> + * GPIO2/CDB    CDB           N/A            N/A
> + * GPIO1/DTRB   DTRB          N/A            N/A
> + * GPIO0/DSRB   DSRB          N/A            N/A
> + *
> + * Example  for SC16IS750/760 with upper bank (7..4) set as modem status lines,
> + * and lower bank (3..0) as GPIOs:
> + *
> + * Pin         GPIO pin     Linux GPIO     SC16IS7XX
> + * name        function     offset         offset
> + * --------------------------------------------------
> + * GPIO7/RI     RI            N/A            N/A
> + * GPIO6/CD     CD            N/A            N/A
> + * GPIO5/DTR    DTR           N/A            N/A
> + * GPIO4/DSR    DSR           N/A            N/A
> + * GPIO3        GPIO3          3              3
> + * GPIO2        GPIO2          2              2
> + * GPIO1        GPIO1          1              1
> + * GPIO0        GPIO0          0              0
> + */
> +
>  static int sc16is7xx_gpio_get(struct gpio_chip *chip, unsigned offset)
>  {
>  	unsigned int val;
>  	struct sc16is7xx_port *s = gpiochip_get_data(chip);
>  	struct uart_port *port = &s->p[0].port;
>  
> +	offset += s->gpio_offset;
>  	val = sc16is7xx_port_read(port, SC16IS7XX_IOSTATE_REG);
>  
>  	return !!(val & BIT(offset));
> @@ -1314,6 +1353,7 @@ static void sc16is7xx_gpio_set(struct gpio_chip *chip, unsigned offset, int val)
>  	struct sc16is7xx_port *s = gpiochip_get_data(chip);
>  	struct uart_port *port = &s->p[0].port;
>  
> +	offset += s->gpio_offset;
>  	sc16is7xx_port_update(port, SC16IS7XX_IOSTATE_REG, BIT(offset),
>  			      val ? BIT(offset) : 0);
>  }
> @@ -1324,6 +1364,7 @@ static int sc16is7xx_gpio_direction_input(struct gpio_chip *chip,
>  	struct sc16is7xx_port *s = gpiochip_get_data(chip);
>  	struct uart_port *port = &s->p[0].port;
>  
> +	offset += s->gpio_offset;
>  	sc16is7xx_port_update(port, SC16IS7XX_IODIR_REG, BIT(offset), 0);
>  
>  	return 0;
> @@ -1336,6 +1377,8 @@ static int sc16is7xx_gpio_direction_output(struct gpio_chip *chip,
>  	struct uart_port *port = &s->p[0].port;
>  	u8 state = sc16is7xx_port_read(port, SC16IS7XX_IOSTATE_REG);
>  
> +	offset += s->gpio_offset;
> +
>  	if (val)
>  		state |= BIT(offset);
>  	else
> @@ -1395,6 +1438,7 @@ static int sc16is7xx_probe(struct device *dev,
>  
>  #ifdef CONFIG_GPIOLIB
>  	s->gpio_configured = devtype->nr_gpio;
> +	s->gpio_offset = 0;
>  #endif /* CONFIG_GPIOLIB */
>  
>  	/* Always ask for fixed clock rate from a property. */
> @@ -1529,16 +1573,24 @@ static int sc16is7xx_probe(struct device *dev,
>  #endif /* CONFIG_GPIOLIB */
>  			}
>  
> -		if (val)
> +		if (val) {
> +#ifdef CONFIG_GPIOLIB
> +			/* Additional I/O regs offset. */
> +			if (val == SC16IS7XX_IOCONTROL_MODEM_B_BIT)
> +				s->gpio_offset = SC16IS7XX_GPIOS_PER_BANK;
> +#endif /* CONFIG_GPIOLIB */
> +
>  			regmap_update_bits(
>  				s->regmap,
>  				SC16IS7XX_IOCONTROL_REG << SC16IS7XX_REG_SHIFT,
>  				SC16IS7XX_IOCONTROL_MODEM_A_BIT |
>  				SC16IS7XX_IOCONTROL_MODEM_B_BIT, val);
> +		}
>  	}
>  
>  #ifdef CONFIG_GPIOLIB
>  	dev_dbg(dev, "GPIOs to configure: %d\n", s->gpio_configured);
> +	dev_dbg(dev, "GPIOs offset: %d\n", s->gpio_offset);
>  
>  	if (s->gpio_configured) {
>  		/* Setup GPIO controller */
> 

Is the order of this and 8/11 patch correct or should this precede that 
other patch? That is, is 8/11 alone useful enough or would this also be 
wanted? (I'm aware that 8/11 has a Fixes tag).

-- 
 i.

