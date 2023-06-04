Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C4C47218DF
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 19:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231709AbjFDRoE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 13:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjFDRoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 13:44:02 -0400
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C25F9DA;
        Sun,  4 Jun 2023 10:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:Content-Type:Mime-Version:
        References:In-Reply-To:Message-Id:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=8Z6PfFP6zRo9DlPnznqiNNc4wG4kWbC1Jiv5BsdVuvQ=; b=Q5a77oaHUDamCEZelb08p4/uN+
        p9YXYIqAl8/AeNsh1tv5gCODANU2JDYeedxFkJRAN+XA11Jsb/I735qNqJcu/5ZxznjhNWIil1Eo0
        +Ztz7p/ek7HUTELTRXRuNOvRF0I2l9rjsLXrAIu+fuGmGpvYd6rrJmJcG2eVKHIbbAWQ=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:57854 helo=pettiford)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1q5rlZ-00067R-JR; Sun, 04 Jun 2023 13:43:46 -0400
Date:   Sun, 4 Jun 2023 13:43:44 -0400
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, jirislaby@kernel.org, jringle@gridpoint.com,
        tomasz.mon@camlingroup.com, l.perczak@camlintechnologies.com,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        stable@vger.kernel.org, Andy Shevchenko <andy.shevchenko@gmail.com>
Message-Id: <20230604134344.73dc3cbb57d335d4a0b4b33a@hugovil.com>
In-Reply-To: <2023060454-cotton-paramount-e33e@gregkh>
References: <20230602152626.284324-1-hugo@hugovil.com>
        <20230602152626.284324-6-hugo@hugovil.com>
        <2023060454-cotton-paramount-e33e@gregkh>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
Subject: Re: [PATCH v7 5/9] serial: sc16is7xx: fix regression with GPIO
 configuration
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 4 Jun 2023 09:47:44 +0200
Greg KH <gregkh@linuxfoundation.org> wrote:

> On Fri, Jun 02, 2023 at 11:26:21AM -0400, Hugo Villeneuve wrote:
> > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > 
> > Commit 679875d1d880 ("sc16is7xx: Separate GPIOs from modem control lines")
> > and commit 21144bab4f11 ("sc16is7xx: Handle modem status lines")
> > changed the function of the GPIOs pins to act as modem control
> > lines without any possibility of selecting GPIO function.
> > 
> > As a consequence, applications that depends on GPIO lines configured
> > by default as GPIO pins no longer work as expected.
> > 
> > Also, the change to select modem control lines function was done only
> > for channel A of dual UART variants (752/762). This was not documented
> > in the log message.
> > 
> > Allow to specify GPIO or modem control line function in the device
> > tree, and for each of the ports (A or B).
> > 
> > Do so by using the new device-tree property named
> > "modem-control-line-ports" (property added in separate patch).
> > 
> > When registering GPIO chip controller, mask-out GPIO pins declared as
> > modem control lines according to this new "modem-control-line-ports"
> > DT property.
> > 
> > Boards that need to have GPIOS configured as modem control lines
> > should add that property to their device tree. Here is a list of
> > boards using the sc16is7xx driver in their device tree and that may
> > need to be modified:
> >     arm64/boot/dts/freescale/fsl-ls1012a-frdm.dts
> >     mips/boot/dts/ingenic/cu1830-neo.dts
> >     mips/boot/dts/ingenic/cu1000-neo.dts
> > 
> > Fixes: 679875d1d880 ("sc16is7xx: Separate GPIOs from modem control lines")
> > Fixes: 21144bab4f11 ("sc16is7xx: Handle modem status lines")
> > Cc: <stable@vger.kernel.org> # 6.1.x: 35210b22 dt-bindings: sc16is7xx: Add property to change GPIO function
> > Cc: <stable@vger.kernel.org> # 6.1.x: 7d61ca47 serial: sc16is7xx: refactor GPIO controller registration
> > Cc: <stable@vger.kernel.org> # 6.1.x: 322470ed serial: sc16is7xx: mark IOCONTROL register as volatile
> > Cc: <stable@vger.kernel.org> # 6.1.x: a0077362 serial: sc16is7xx: fix broken port 0 uart init
> > Cc: <stable@vger.kernel.org> # 6.1.x
> > Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > ---
> >  drivers/tty/serial/sc16is7xx.c | 103 ++++++++++++++++++++++++++-------
> >  1 file changed, 82 insertions(+), 21 deletions(-)
> > 
> > diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
> > index 7d50674d2d0e..edc83f5f6340 100644
> > --- a/drivers/tty/serial/sc16is7xx.c
> > +++ b/drivers/tty/serial/sc16is7xx.c
> > @@ -236,7 +236,8 @@
> >  
> >  /* IOControl register bits (Only 750/760) */
> >  #define SC16IS7XX_IOCONTROL_LATCH_BIT	(1 << 0) /* Enable input latching */
> > -#define SC16IS7XX_IOCONTROL_MODEM_BIT	(1 << 1) /* Enable GPIO[7:4] as modem pins */
> > +#define SC16IS7XX_IOCONTROL_MODEM_A_BIT	(1 << 1) /* Enable GPIO[7:4] as modem A pins */
> > +#define SC16IS7XX_IOCONTROL_MODEM_B_BIT	(1 << 2) /* Enable GPIO[3:0] as modem B pins */
> >  #define SC16IS7XX_IOCONTROL_SRESET_BIT	(1 << 3) /* Software Reset */
> >  
> >  /* EFCR register bits */
> > @@ -301,12 +302,12 @@
> >  /* Misc definitions */
> >  #define SC16IS7XX_FIFO_SIZE		(64)
> >  #define SC16IS7XX_REG_SHIFT		2
> > +#define SC16IS7XX_GPIOS_PER_BANK	4
> >  
> >  struct sc16is7xx_devtype {
> >  	char	name[10];
> >  	int	nr_gpio;
> >  	int	nr_uart;
> > -	int	has_mctrl;
> >  };
> >  
> >  #define SC16IS7XX_RECONF_MD		(1 << 0)
> > @@ -336,6 +337,7 @@ struct sc16is7xx_port {
> >  	struct clk			*clk;
> >  #ifdef CONFIG_GPIOLIB
> >  	struct gpio_chip		gpio;
> > +	unsigned long			gpio_valid_mask;
> >  #endif
> >  	unsigned char			buf[SC16IS7XX_FIFO_SIZE];
> >  	struct kthread_worker		kworker;
> > @@ -447,35 +449,30 @@ static const struct sc16is7xx_devtype sc16is74x_devtype = {
> >  	.name		= "SC16IS74X",
> >  	.nr_gpio	= 0,
> >  	.nr_uart	= 1,
> > -	.has_mctrl	= 0,
> >  };
> >  
> >  static const struct sc16is7xx_devtype sc16is750_devtype = {
> >  	.name		= "SC16IS750",
> > -	.nr_gpio	= 4,
> > +	.nr_gpio	= 8,
> >  	.nr_uart	= 1,
> > -	.has_mctrl	= 1,
> >  };
> >  
> >  static const struct sc16is7xx_devtype sc16is752_devtype = {
> >  	.name		= "SC16IS752",
> > -	.nr_gpio	= 0,
> > +	.nr_gpio	= 8,
> >  	.nr_uart	= 2,
> > -	.has_mctrl	= 1,
> >  };
> >  
> >  static const struct sc16is7xx_devtype sc16is760_devtype = {
> >  	.name		= "SC16IS760",
> > -	.nr_gpio	= 4,
> > +	.nr_gpio	= 8,
> >  	.nr_uart	= 1,
> > -	.has_mctrl	= 1,
> >  };
> >  
> >  static const struct sc16is7xx_devtype sc16is762_devtype = {
> >  	.name		= "SC16IS762",
> > -	.nr_gpio	= 0,
> > +	.nr_gpio	= 8,
> >  	.nr_uart	= 2,
> > -	.has_mctrl	= 1,
> >  };
> >  
> >  static bool sc16is7xx_regmap_volatile(struct device *dev, unsigned int reg)
> > @@ -1350,16 +1347,45 @@ static int sc16is7xx_gpio_direction_output(struct gpio_chip *chip,
> >  	return 0;
> >  }
> >  
> > -static int sc16is7xx_setup_gpio_chip(struct device *dev)
> > +static int sc16is7xx_gpio_init_valid_mask(struct gpio_chip *chip,
> > +					  unsigned long *valid_mask,
> > +					  unsigned int ngpios)
> > +{
> > +	struct sc16is7xx_port *s = gpiochip_get_data(chip);
> > +
> > +	*valid_mask = s->gpio_valid_mask;
> > +
> > +	return 0;
> > +}
> > +
> > +static int sc16is7xx_setup_gpio_chip(struct device *dev, u8 mctrl_mask)
> >  {
> >  	struct sc16is7xx_port *s = dev_get_drvdata(dev);
> >  
> >  	if (!s->devtype->nr_gpio)
> >  		return 0;
> >  
> > +	switch (mctrl_mask) {
> > +	case 0:
> > +		s->gpio_valid_mask = GENMASK(7, 0);
> > +		break;
> > +	case SC16IS7XX_IOCONTROL_MODEM_A_BIT:
> > +		s->gpio_valid_mask = GENMASK(3, 0);
> > +		break;
> > +	case SC16IS7XX_IOCONTROL_MODEM_B_BIT:
> > +		s->gpio_valid_mask = GENMASK(7, 4);
> > +		break;
> > +	default:
> > +		break;
> > +	}
> > +
> > +	if (s->gpio_valid_mask == 0)
> > +		return 0;
> > +
> >  	s->gpio.owner		 = THIS_MODULE;
> >  	s->gpio.parent		 = dev;
> >  	s->gpio.label		 = dev_name(dev);
> > +	s->gpio.init_valid_mask	 = sc16is7xx_gpio_init_valid_mask;
> >  	s->gpio.direction_input	 = sc16is7xx_gpio_direction_input;
> >  	s->gpio.get		 = sc16is7xx_gpio_get;
> >  	s->gpio.direction_output = sc16is7xx_gpio_direction_output;
> > @@ -1371,6 +1397,44 @@ static int sc16is7xx_setup_gpio_chip(struct device *dev)
> >  }
> >  #endif
> >  
> > +static u8 sc16is7xx_setup_mctrl_ports(struct device *dev)
> 
> This returns what, mctrl?  If so, please document that, it doesn't look
> obvious.  And as the kernel test robot reported, you do nothing with the
> return value so why compute it?

Hi Greg,
I will  the following comment to document return value:

/*
 * Configure ports designated to operate as modem control lines.
 * Return mask of ports configured as modem control lines.
 */
static u8 sc16is7xx_setup_mctrl_ports(struct device *dev)


The kernel test robot identified a case, when CONFIG_GPIOLIB is not defined, where the value returned by sc16is7xx_setup_mctrl_ports() is not used. But the function sc16is7xx_setup_mctrl_ports() still need to be called to configure the modem status line ports correctly in that case.

And if CONFIG_GPIOLIB is defined, the value is definitely used (and needed).

Here is what I suggest to silence the warning:

	mctrl_mask = sc16is7xx_setup_mctrl_ports(dev);

#ifdef CONFIG_GPIOLIB
	ret = sc16is7xx_setup_gpio_chip(dev, mctrl_mask);
	if (ret)
		goto out_thread;
#else
	(void) mctrl_mask;
#endif

I could also store (define new variable) mctrl_mask directly inside struct sc16is7xx_port...


> And you have a real port here, no need to pass in a "raw" struct device,
> right?

The function operates globally on both ports (or nr_uart), not just a single port. That is why I pass the "raw" struct device, in order to extract the 
struct sc16is7xx_port from it:

    struct sc16is7xx_port *s = dev_get_drvdata(dev);

Inside the function, I also need the "raw" struc device. If we pass a struct sc16is7xx_port to the function, then I can get the "raw" struc device with this:

static u8 sc16is7xx_setup_mctrl_ports(struct sc16is7xx_port *s)
{
	struct device *dev = &s->p[0].port.dev;

But I find this more obfuscated and hard to understand than to simply pass a "raw" struct device...

Hugo.
