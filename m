Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7FD8710F81
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 17:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241783AbjEYPZb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 11:25:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241532AbjEYPZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 11:25:29 -0400
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 580FC19C;
        Thu, 25 May 2023 08:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:Content-Type:Mime-Version:
        References:In-Reply-To:Message-Id:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=pBbauL/USHBNSfOtpD5kHOjUjf5hfBSxdPRkWcdqI7U=; b=JX9DED8Mz9hNHg3UBaHko4pOJS
        neBjjzsyUALXjDHNz6VPV4Z0b2OIqPyBJBP3WFflQ922YLqV2W2f3rjFFzbDYnjpKNzVVXhhbCc32
        sPAQEhKzpntcyGhKXuyAmFx8gRWaV8ZDP3LGVIUkEEoErCzF1hmPHMHXdwrjz+ntyxGQ=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:45094 helo=pettiford)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1q2Cq7-0000QR-Eu; Thu, 25 May 2023 11:25:20 -0400
Date:   Thu, 25 May 2023 11:25:18 -0400
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
Message-Id: <20230525112518.6589651e814325804744182f@hugovil.com>
In-Reply-To: <73413221-a87c-b619-5171-70cb117cdf@linux.intel.com>
References: <20230525040324.3773741-1-hugo@hugovil.com>
        <20230525040324.3773741-10-hugo@hugovil.com>
        <73413221-a87c-b619-5171-70cb117cdf@linux.intel.com>
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
Subject: Re: [PATCH v3 09/11] serial: sc16is7xx: add I/O register
 translation offset
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 May 2023 15:10:00 +0300 (EEST)
Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com> wrote:

> On Thu, 25 May 2023, Hugo Villeneuve wrote:
>=20
> > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> >=20
> > If the shared GPIO pins on a dual port/channel variant like the
> > SC16IS752 are configured as GPIOs for port A, and modem control lines
> > on port A, we need to translate the Linux GPIO offset to an offset
> > that is compatible with the I/O registers of the SC16IS7XX (IOState,
> > IODir and IOIntEna).
> >=20
> > Add a new variable to store that offset and set it when we detect that
> > special case.
> >=20
> > Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > ---
> >  drivers/tty/serial/sc16is7xx.c | 54 +++++++++++++++++++++++++++++++++-
> >  1 file changed, 53 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is=
7xx.c
> > index 97ec532a0a19..c2cfd057ed9a 100644
> > --- a/drivers/tty/serial/sc16is7xx.c
> > +++ b/drivers/tty/serial/sc16is7xx.c
> > @@ -338,6 +338,7 @@ struct sc16is7xx_port {
> >  #ifdef CONFIG_GPIOLIB
> >  	struct gpio_chip		gpio;
> >  	int				gpio_configured;
> > +	int				gpio_offset;
> >  #endif
> >  	unsigned char			buf[SC16IS7XX_FIFO_SIZE];
> >  	struct kthread_worker		kworker;
> > @@ -1298,12 +1299,50 @@ static const struct uart_ops sc16is7xx_ops =3D {
> >  };
> > =20
> >  #ifdef CONFIG_GPIOLIB
> > +
> > +/*
> > + * We may need to translate the Linux GPIO offset to a SC16IS7XX offse=
t.
> > + * This is needed only for the case where a dual port variant is confi=
gured to
> > + * have only port B as modem status lines.
> > + *
> > + * Example for SC16IS752/762 with upper bank (port A) set as GPIOs, and
> > + * lower bank (port B) set as modem status lines (special case describ=
ed above):
> > + *
> > + * Pin         GPIO pin     Linux GPIO     SC16IS7XX
> > + * name        function     offset         offset
> > + * --------------------------------------------------
> > + * GPIO7/RIA    GPIO7          3              7
> > + * GPIO6/CDA    GPIO6          2              6
> > + * GPIO5/DTRA   GPIO5          1              5
> > + * GPIO4/DSRA   GPIO4          0              4
> > + * GPIO3/RIB    RIB           N/A            N/A
> > + * GPIO2/CDB    CDB           N/A            N/A
> > + * GPIO1/DTRB   DTRB          N/A            N/A
> > + * GPIO0/DSRB   DSRB          N/A            N/A
> > + *
> > + * Example  for SC16IS750/760 with upper bank (7..4) set as modem stat=
us lines,
> > + * and lower bank (3..0) as GPIOs:
> > + *
> > + * Pin         GPIO pin     Linux GPIO     SC16IS7XX
> > + * name        function     offset         offset
> > + * --------------------------------------------------
> > + * GPIO7/RI     RI            N/A            N/A
> > + * GPIO6/CD     CD            N/A            N/A
> > + * GPIO5/DTR    DTR           N/A            N/A
> > + * GPIO4/DSR    DSR           N/A            N/A
> > + * GPIO3        GPIO3          3              3
> > + * GPIO2        GPIO2          2              2
> > + * GPIO1        GPIO1          1              1
> > + * GPIO0        GPIO0          0              0
> > + */
> > +
> >  static int sc16is7xx_gpio_get(struct gpio_chip *chip, unsigned offset)
> >  {
> >  	unsigned int val;
> >  	struct sc16is7xx_port *s =3D gpiochip_get_data(chip);
> >  	struct uart_port *port =3D &s->p[0].port;
> > =20
> > +	offset +=3D s->gpio_offset;
> >  	val =3D sc16is7xx_port_read(port, SC16IS7XX_IOSTATE_REG);
> > =20
> >  	return !!(val & BIT(offset));
> > @@ -1314,6 +1353,7 @@ static void sc16is7xx_gpio_set(struct gpio_chip *=
chip, unsigned offset, int val)
> >  	struct sc16is7xx_port *s =3D gpiochip_get_data(chip);
> >  	struct uart_port *port =3D &s->p[0].port;
> > =20
> > +	offset +=3D s->gpio_offset;
> >  	sc16is7xx_port_update(port, SC16IS7XX_IOSTATE_REG, BIT(offset),
> >  			      val ? BIT(offset) : 0);
> >  }
> > @@ -1324,6 +1364,7 @@ static int sc16is7xx_gpio_direction_input(struct =
gpio_chip *chip,
> >  	struct sc16is7xx_port *s =3D gpiochip_get_data(chip);
> >  	struct uart_port *port =3D &s->p[0].port;
> > =20
> > +	offset +=3D s->gpio_offset;
> >  	sc16is7xx_port_update(port, SC16IS7XX_IODIR_REG, BIT(offset), 0);
> > =20
> >  	return 0;
> > @@ -1336,6 +1377,8 @@ static int sc16is7xx_gpio_direction_output(struct=
 gpio_chip *chip,
> >  	struct uart_port *port =3D &s->p[0].port;
> >  	u8 state =3D sc16is7xx_port_read(port, SC16IS7XX_IOSTATE_REG);
> > =20
> > +	offset +=3D s->gpio_offset;
> > +
> >  	if (val)
> >  		state |=3D BIT(offset);
> >  	else
> > @@ -1395,6 +1438,7 @@ static int sc16is7xx_probe(struct device *dev,
> > =20
> >  #ifdef CONFIG_GPIOLIB
> >  	s->gpio_configured =3D devtype->nr_gpio;
> > +	s->gpio_offset =3D 0;
> >  #endif /* CONFIG_GPIOLIB */
> > =20
> >  	/* Always ask for fixed clock rate from a property. */
> > @@ -1529,16 +1573,24 @@ static int sc16is7xx_probe(struct device *dev,
> >  #endif /* CONFIG_GPIOLIB */
> >  			}
> > =20
> > -		if (val)
> > +		if (val) {
> > +#ifdef CONFIG_GPIOLIB
> > +			/* Additional I/O regs offset. */
> > +			if (val =3D=3D SC16IS7XX_IOCONTROL_MODEM_B_BIT)
> > +				s->gpio_offset =3D SC16IS7XX_GPIOS_PER_BANK;
> > +#endif /* CONFIG_GPIOLIB */
> > +
> >  			regmap_update_bits(
> >  				s->regmap,
> >  				SC16IS7XX_IOCONTROL_REG << SC16IS7XX_REG_SHIFT,
> >  				SC16IS7XX_IOCONTROL_MODEM_A_BIT |
> >  				SC16IS7XX_IOCONTROL_MODEM_B_BIT, val);
> > +		}
> >  	}
> > =20
> >  #ifdef CONFIG_GPIOLIB
> >  	dev_dbg(dev, "GPIOs to configure: %d\n", s->gpio_configured);
> > +	dev_dbg(dev, "GPIOs offset: %d\n", s->gpio_offset);
> > =20
> >  	if (s->gpio_configured) {
> >  		/* Setup GPIO controller */
> >=20
>=20
> Is the order of this and 8/11 patch correct or should this precede that=20
> other patch? That is, is 8/11 alone useful enough or would this also be=20
> wanted? (I'm aware that 8/11 has a Fixes tag).

In fact, this patch (9/11) could be considered to be part of 8/11. I decide=
d to separate it in order to facilitate the review process.

Maybe I should merge them...

Hugo.
