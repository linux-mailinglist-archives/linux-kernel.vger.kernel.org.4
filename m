Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4546710F3B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 17:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241519AbjEYPLv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 11:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240923AbjEYPLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 11:11:48 -0400
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8677CE7B;
        Thu, 25 May 2023 08:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:Content-Type:Mime-Version:
        References:In-Reply-To:Message-Id:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=z7+nMZ9RFV52bXnLVvhiG04oxR20pwfVjg7lkDTaJjw=; b=V9GE/J7fz5RM6iLW+KQaCqCpCM
        Vpi+7HFGIeJeaEgAJBxCh94gQqEs2yD8Uu00Gqw/R/FuWQNwZBD2/9Eo3FyKAQh8yryxXYclXUkhA
        LjXAww/r0LardvpxWHUo62udMvLxASeXb4nPj4RqxQU37LWXYYNKw9entBzxb66iL/TI=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:47616 helo=pettiford)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1q2Cbq-0000IA-Q9; Thu, 25 May 2023 11:10:35 -0400
Date:   Thu, 25 May 2023 11:10:34 -0400
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
Message-Id: <20230525111034.fc59852a7f91c752ed39499d@hugovil.com>
In-Reply-To: <2936e18f-44ea-faed-9fa0-2ddefe7c3194@linux.intel.com>
References: <20230525040324.3773741-1-hugo@hugovil.com>
        <20230525040324.3773741-6-hugo@hugovil.com>
        <2936e18f-44ea-faed-9fa0-2ddefe7c3194@linux.intel.com>
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
Subject: Re: [PATCH v3 05/11] serial: sc16is7xx: fix broken port 0 uart init
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 May 2023 14:20:59 +0300 (EEST)
Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com> wrote:

> On Thu, 25 May 2023, Hugo Villeneuve wrote:
>=20
> > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> >=20
> > While experimenting with rs485 configuration on a SC16IS752 dual UART,
>=20
> You can remove this intro, it's not necessary.

Fixed.

=20
> > I found that the sc16is7xx_config_rs485() function was called only for
> > the second port (index 1, channel B), causing initialization problems
> > for the first port.
>=20
> Just start with:
>=20
> sc16is7xx_config_rs485() function is called only for ...
>=20
> > For the sc16is7xx driver, port->membase and port->mapbase are not set,
> > and their default values are 0. And we set port->iobase to the device
> > index. This means that when the first device is registered using the
> > uart_add_one_port() function, the following values will be in the port
> > structure:
> >     port->membase =3D 0
> >     port->mapbase =3D 0
> >     port->iobase  =3D 0
> >=20
> > Therefore, the function uart_configure_port() in serial_core.c will
> > exit early because of the following check:
> > 	/*
> > 	 * If there isn't a port here, don't do anything further.
> > 	 */
> > 	if (!port->iobase && !port->mapbase && !port->membase)
> > 		return;
> >=20
> > Typically, I2C and SPI drivers do not set port->membase and
> > port->mapbase. But I found that the max310x driver sets
> > port->membase to ~0 (all ones).
>=20
> The max310x driver sets port->membase to ~0 (all ones) to solve the same=
=20
> problem.

Fixed.


> > By implementing the same change in our
> > driver, uart_configure_port() is now correctly executed.
>=20
> our driver -> this driver

Fixed.

=20
> This changelog was really well describing the problem! :-)
>=20
> > Fixes: dfeae619d781 ("serial: sc16is7xx")
> > Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > ---
> > I am not sure if this change is the best long-term solution to this
> > problem, and maybe uart_configure_port() itself could be modified to
> > take into account the fact that some devices have all three *base
> > values set to zero?
>=20
> Yeah, some other solution should be devised. Maybe we should add another=
=20
> .iotype for thse kind of devices. But I'm fine with this for this fix.
> After editing the changelog, feel free to add:
>=20
> Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

Added.

=20
> > Also, many drivers use port->iobase as an index, is it the correct way
> > to use it?
>=20
> "Many" for this and max310x? Besides that, uartlite.c has a comment which=
=20
> says "mark port in use".

Ok,=20
anyway with your approval I will remove these comments which will not part =
of the final commit message anyway.

Hugo.


> > For example, for our driver, there was
> > commit 5da6b1c079e6 ("sc16is7xx: Set iobase to device index") with the
> > following explanation:
> >     "Set the .iobase value to the relative index within the device to a=
llow
> >     infering the order through sysfs."
> >=20
> >  drivers/tty/serial/sc16is7xx.c | 1 +
> >  1 file changed, 1 insertion(+)
> >=20
> > diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is=
7xx.c
> > index af7e66db54b4..8a2fc6f89d36 100644
> > --- a/drivers/tty/serial/sc16is7xx.c
> > +++ b/drivers/tty/serial/sc16is7xx.c
> > @@ -1443,6 +1443,7 @@ static int sc16is7xx_probe(struct device *dev,
> >  		s->p[i].port.fifosize	=3D SC16IS7XX_FIFO_SIZE;
> >  		s->p[i].port.flags	=3D UPF_FIXED_TYPE | UPF_LOW_LATENCY;
> >  		s->p[i].port.iobase	=3D i;
> > +		s->p[i].port.membase	=3D (void __iomem *)~0;
> >  		s->p[i].port.iotype	=3D UPIO_PORT;
> >  		s->p[i].port.uartclk	=3D freq;
> >  		s->p[i].port.rs485_config =3D sc16is7xx_config_rs485;
> >=20
