Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79436710F5B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 17:19:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241364AbjEYPTv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 11:19:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241432AbjEYPTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 11:19:48 -0400
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AB3998;
        Thu, 25 May 2023 08:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:Content-Type:Mime-Version:
        References:In-Reply-To:Message-Id:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=mr2Cj5K3oowCudCR8UhKJOZAwMuxZhepkBF0Gn4truo=; b=Q1Qafwpc2UPxgkGevWlrkLFOLC
        aXGI3T6HF44jqsN3ch6NhhwwKg2UtUyks6636Ue8F8GF1AphicJfS5vxERbHG+2eVKoUYmUEgT4Sj
        zQgRcqpEeU8UWThH0rz77TuuH8NR43RetsMuV3t08ogEbFtPbdnyukKJxyZsVbF+ZB+k=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:46246 helo=pettiford)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1q2Ckb-0000NF-VC; Thu, 25 May 2023 11:19:39 -0400
Date:   Thu, 25 May 2023 11:19:37 -0400
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, Jiri Slaby <jirislaby@kernel.org>,
        jringle@gridpoint.com, tomasz.mon@camlingroup.com,
        l.perczak@camlintechnologies.com,
        linux-serial <linux-serial@vger.kernel.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-gpio@vger.kernel.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>
Message-Id: <20230525111937.e0d3a96d8f95c7a523cdb006@hugovil.com>
In-Reply-To: <b8b6d3d-6c7b-3a94-4d29-b182f12325d@linux.intel.com>
References: <20230525040324.3773741-1-hugo@hugovil.com>
        <20230525040324.3773741-9-hugo@hugovil.com>
        <b8b6d3d-6c7b-3a94-4d29-b182f12325d@linux.intel.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
Subject: Re: [PATCH v3 08/11] serial: sc16is7xx: fix regression with GPIO
 configuration
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 May 2023 15:03:41 +0300 (EEST)
Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com> wrote:

> On Thu, 25 May 2023, Hugo Villeneuve wrote:
>=20
> > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> >=20
> > Commit 679875d1d880 ("sc16is7xx: Separate GPIOs from modem control line=
s")
> > and commit 21144bab4f11 ("sc16is7xx: Handle modem status lines")
> > changed the function of the GPIOs pins to act as modem control
> > lines without any possibility of selecting GPIO function.
> >=20
> > As a consequence, applications that depends on GPIO lines configured
> > by default as GPIO pins no longer work as expected.
> >=20
> > Also, the change to select modem control lines function was done only
> > for channel A of dual UART variants (752/762). This was not documented
> > in the log message.
> >=20
> > This new patch allows to specify GPIO or modem control line function
> > in the device tree, and for each of the ports (A or B).
> >=20
> > This is done by using the new device-tree property named
> > "modem-control-line-ports" (property added in separate patch).
> >=20
> > We also now reduce the number of exported GPIOs according to the
> > modem-status-line-port DT property.
> >=20
> > Boards that need to have GPIOS configured as modem control lines
> > should add that property to their device tree. Here is a list of
> > boards using the sc16is7xx driver in their device tree and that may
> > need to be modified:
> >     arm64/boot/dts/freescale/fsl-ls1012a-frdm.dts
> >     mips/boot/dts/ingenic/cu1830-neo.dts
> >     mips/boot/dts/ingenic/cu1000-neo.dts
> >=20
> > Fixes: 679875d1d880 ("sc16is7xx: Separate GPIOs from modem control line=
s")
> > Fixes: 21144bab4f11 ("sc16is7xx: Handle modem status lines")
> > Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > ---
> >  drivers/tty/serial/sc16is7xx.c | 65 +++++++++++++++++++++++-----------
> >  1 file changed, 44 insertions(+), 21 deletions(-)
> >=20
> > diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is=
7xx.c
> > index a5d8af0f6da0..97ec532a0a19 100644
> > --- a/drivers/tty/serial/sc16is7xx.c
> > +++ b/drivers/tty/serial/sc16is7xx.c
> > @@ -236,7 +236,8 @@
> > =20
> >  /* IOControl register bits (Only 75x/76x) */
> >  #define SC16IS7XX_IOCONTROL_LATCH_BIT	(1 << 0) /* Enable input latchin=
g */
> > -#define SC16IS7XX_IOCONTROL_MODEM_BIT	(1 << 1) /* Enable GPIO[7:4] as =
modem pins */
> > +#define SC16IS7XX_IOCONTROL_MODEM_A_BIT	(1 << 1) /* Enable GPIO[7:4] a=
s modem A pins */
> > +#define SC16IS7XX_IOCONTROL_MODEM_B_BIT	(1 << 2) /* Enable GPIO[3:0] a=
s modem B pins */
> >  #define SC16IS7XX_IOCONTROL_SRESET_BIT	(1 << 3) /* Software Reset */
> > =20
> >  /* EFCR register bits */
> > @@ -301,12 +302,12 @@
> >  /* Misc definitions */
> >  #define SC16IS7XX_FIFO_SIZE		(64)
> >  #define SC16IS7XX_REG_SHIFT		2
> > +#define SC16IS7XX_GPIOS_PER_BANK	4
> > =20
> >  struct sc16is7xx_devtype {
> >  	char	name[10];
> >  	int	nr_gpio;
> >  	int	nr_uart;
> > -	int	has_mctrl;
> >  };
> > =20
> >  #define SC16IS7XX_RECONF_MD		(1 << 0)
> > @@ -336,6 +337,7 @@ struct sc16is7xx_port {
> >  	struct clk			*clk;
> >  #ifdef CONFIG_GPIOLIB
> >  	struct gpio_chip		gpio;
> > +	int				gpio_configured;
> >  #endif
> >  	unsigned char			buf[SC16IS7XX_FIFO_SIZE];
> >  	struct kthread_worker		kworker;
> > @@ -447,35 +449,30 @@ static const struct sc16is7xx_devtype sc16is74x_d=
evtype =3D {
> >  	.name		=3D "SC16IS74X",
> >  	.nr_gpio	=3D 0,
> >  	.nr_uart	=3D 1,
> > -	.has_mctrl	=3D 0,
> >  };
> > =20
> >  static const struct sc16is7xx_devtype sc16is750_devtype =3D {
> >  	.name		=3D "SC16IS750",
> > -	.nr_gpio	=3D 4,
> > +	.nr_gpio	=3D 8,
> >  	.nr_uart	=3D 1,
> > -	.has_mctrl	=3D 1,
> >  };
> > =20
> >  static const struct sc16is7xx_devtype sc16is752_devtype =3D {
> >  	.name		=3D "SC16IS752",
> > -	.nr_gpio	=3D 0,
> > +	.nr_gpio	=3D 8,
> >  	.nr_uart	=3D 2,
> > -	.has_mctrl	=3D 1,
> >  };
> > =20
> >  static const struct sc16is7xx_devtype sc16is760_devtype =3D {
> >  	.name		=3D "SC16IS760",
> > -	.nr_gpio	=3D 4,
> > +	.nr_gpio	=3D 8,
> >  	.nr_uart	=3D 1,
> > -	.has_mctrl	=3D 1,
> >  };
> > =20
> >  static const struct sc16is7xx_devtype sc16is762_devtype =3D {
> >  	.name		=3D "SC16IS762",
> > -	.nr_gpio	=3D 0,
> > +	.nr_gpio	=3D 8,
> >  	.nr_uart	=3D 2,
> > -	.has_mctrl	=3D 1,
> >  };
> > =20
> >  static bool sc16is7xx_regmap_volatile(struct device *dev, unsigned int=
 reg)
> > @@ -1396,6 +1393,10 @@ static int sc16is7xx_probe(struct device *dev,
> >  		return -ENOMEM;
> >  	}
> > =20
> > +#ifdef CONFIG_GPIOLIB
> > +	s->gpio_configured =3D devtype->nr_gpio;
> > +#endif /* CONFIG_GPIOLIB */
> > +
> >  	/* Always ask for fixed clock rate from a property. */
> >  	device_property_read_u32(dev, "clock-frequency", &uartclk);
> > =20
> > @@ -1473,12 +1474,6 @@ static int sc16is7xx_probe(struct device *dev,
> >  				     SC16IS7XX_EFCR_RXDISABLE_BIT |
> >  				     SC16IS7XX_EFCR_TXDISABLE_BIT);
> > =20
> > -		/* Use GPIO lines as modem status registers */
> > -		if (devtype->has_mctrl)
> > -			sc16is7xx_port_write(&s->p[i].port,
> > -					     SC16IS7XX_IOCONTROL_REG,
> > -					     SC16IS7XX_IOCONTROL_MODEM_BIT);
> > -
> >  		/* Initialize kthread work structs */
> >  		kthread_init_work(&s->p[i].tx_work, sc16is7xx_tx_proc);
> >  		kthread_init_work(&s->p[i].reg_work, sc16is7xx_reg_proc);
> > @@ -1514,10 +1509,38 @@ static int sc16is7xx_probe(struct device *dev,
> >  					 prop, p, u)
> >  			if (u < devtype->nr_uart)
> >  				s->p[u].irda_mode =3D true;
> > +
> > +		val =3D 0;
> > +
> > +		of_property_for_each_u32(dev->of_node, "nxp,modem-control-line-ports=
",
> > +					 prop, p, u)
> > +			if (u < devtype->nr_uart) {
>=20
> Reverse logic + use continue. It will help with the indentation levels.

Good suggestion, done.

=20
> > +				/* Use GPIO lines as modem control lines */
> > +				if (u =3D=3D 0)
> > +					val |=3D SC16IS7XX_IOCONTROL_MODEM_A_BIT;
> > +				else if (u =3D=3D 1)
> > +					val |=3D SC16IS7XX_IOCONTROL_MODEM_B_BIT;
> > +
> > +#ifdef CONFIG_GPIOLIB
> > +				if (s->gpio_configured >=3D
> > +				    SC16IS7XX_GPIOS_PER_BANK)
> > +					s->gpio_configured -=3D
> > +						SC16IS7XX_GPIOS_PER_BANK;
> > +#endif /* CONFIG_GPIOLIB */
> > +			}
>=20
> Please use braces for of_property_for_each_u32 block.

Done

=20
> > +
> > +		if (val)
> > +			regmap_update_bits(
> > +				s->regmap,
> > +				SC16IS7XX_IOCONTROL_REG << SC16IS7XX_REG_SHIFT,
> > +				SC16IS7XX_IOCONTROL_MODEM_A_BIT |
> > +				SC16IS7XX_IOCONTROL_MODEM_B_BIT, val);
> >  	}
> > =20
> >  #ifdef CONFIG_GPIOLIB
> > -	if (devtype->nr_gpio) {
> > +	dev_dbg(dev, "GPIOs to configure: %d\n", s->gpio_configured);
> > +
> > +	if (s->gpio_configured) {
> >  		/* Setup GPIO controller */
> >  		s->gpio.owner		 =3D THIS_MODULE;
> >  		s->gpio.parent		 =3D dev;
> > @@ -1527,7 +1550,7 @@ static int sc16is7xx_probe(struct device *dev,
> >  		s->gpio.direction_output =3D sc16is7xx_gpio_direction_output;
> >  		s->gpio.set		 =3D sc16is7xx_gpio_set;
> >  		s->gpio.base		 =3D -1;
> > -		s->gpio.ngpio		 =3D devtype->nr_gpio;
> > +		s->gpio.ngpio		 =3D s->gpio_configured;
> >  		s->gpio.can_sleep	 =3D 1;
> >  		ret =3D gpiochip_add_data(&s->gpio, s);
> >  		if (ret)
> > @@ -1555,7 +1578,7 @@ static int sc16is7xx_probe(struct device *dev,
> >  		return 0;
> > =20
> >  #ifdef CONFIG_GPIOLIB
> > -	if (devtype->nr_gpio)
> > +	if (s->gpio_configured)
> >  		gpiochip_remove(&s->gpio);
> > =20
> >  out_thread:
> > @@ -1581,7 +1604,7 @@ static void sc16is7xx_remove(struct device *dev)
> >  	int i;
> > =20
> >  #ifdef CONFIG_GPIOLIB
> > -	if (s->devtype->nr_gpio)
> > +	if (s->gpio_configured)
> >  		gpiochip_remove(&s->gpio);
> >  #endif
> > =20
> >=20
>=20
> --=20
>  i.
>=20
>=20
