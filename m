Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0428D6A54AE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 09:48:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbjB1IsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 03:48:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbjB1Irg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 03:47:36 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7A1ABB87
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 00:46:31 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1pWvcy-0008MU-Vq; Tue, 28 Feb 2023 09:46:28 +0100
Received: from mfe by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1pWvcx-0005zu-Uv; Tue, 28 Feb 2023 09:46:27 +0100
Date:   Tue, 28 Feb 2023 09:46:27 +0100
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc:     Stefan Wahren <stefan.wahren@i2se.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] gpio: mxs: use dynamic allocation of base
Message-ID: <20230228084627.e3afg3tp6tzpepb4@pengutronix.de>
References: <20230226205357.1013504-1-dario.binacchi@amarulasolutions.com>
 <33714d4c-31a9-527c-f80a-1f51c9a37f98@i2se.com>
 <CABGWkvo=Qnfi+fciQXZ2NWCW2tyMCctaBsYc=VTo_HjYHphkKQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABGWkvo=Qnfi+fciQXZ2NWCW2tyMCctaBsYc=VTo_HjYHphkKQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dario,

On 23-02-28, Dario Binacchi wrote:
> Hi Stefan,
> 
> On Mon, Feb 27, 2023 at 6:52 PM Stefan Wahren <stefan.wahren@i2se.com> wrote:
> >
> > Hi Dario,
> >
> > Am 26.02.23 um 21:53 schrieb Dario Binacchi:
> > > Since commit 502df79b860563d7 ("gpiolib: Warn on drivers still using static
> > > gpiobase allocation"), one or more warnings are printed during boot on
> > > systems where static allocation of GPIO base is used:
> > >
> > > [    0.136834] gpio gpiochip0: Static allocation of GPIO base is deprecated, use dynamic allocation.
> > > [    0.142753] gpio gpiochip1: Static allocation of GPIO base is deprecated, use dynamic allocation.
> > > [    0.148452] gpio gpiochip2: Static allocation of GPIO base is deprecated, use dynamic allocation.
> > > [    0.154341] gpio gpiochip3: Static allocation of GPIO base is deprecated, use dynamic allocation.
> > > [    0.160097] gpio gpiochip4: Static allocation of GPIO base is deprecated, use dynamic allocation.
> > >
> > > So let's follow the suggestion and use dynamic allocation.
> >
> > i understand the motivation of avoiding these warnings.
> >
> > AFAIK the MXS platform is older than the dynamic allocation of GPIO
> > base. In the perfect world all applications has been migrated to
> > libgpiod / chardev GPIO. But i'm really concerned this hasn't happend
> > yet, at least for this platform. So i believe this change break
> > applications, since it affects userspace.
> 
> Thanks for your explanations.

There was also a lengthly discussion here:

https://lore.kernel.org/all/20230120104647.nwki4silrtd7bt3w@pengutronix.de/

> Do you think it makes sense to use a Kconfig option to enable/disable
> the dynamic allocation of GPIO base?

What we could do is to check the GPIO_SYSFS kconfig symbol. If this is
enabled we should keep the current behaviour to not break the uAPI else
we can go with the dynamic numbering. What we should avoid is a new
Kconfig symbol.

Regards,
  Marco

> As done, if I'm not mistaken, in commit 80d34260f36c6 ("pinctrl:
> renesas: gpio: Use dynamic GPIO base if no function GPIOs")?
> With legacy support enabled by default, but the ability to try out the
> latest dynamic allocation functionality.
> 
> Thanks and regards,
> Dario
> 
> >
> > Best regards
> >
> > >
> > > Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> > > ---
> > >
> > >   drivers/gpio/gpio-mxs.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/gpio/gpio-mxs.c b/drivers/gpio/gpio-mxs.c
> > > index 7f59e5d936c2..b48a7c1fb7c1 100644
> > > --- a/drivers/gpio/gpio-mxs.c
> > > +++ b/drivers/gpio/gpio-mxs.c
> > > @@ -330,7 +330,7 @@ static int mxs_gpio_probe(struct platform_device *pdev)
> > >
> > >       port->gc.to_irq = mxs_gpio_to_irq;
> > >       port->gc.get_direction = mxs_gpio_get_direction;
> > > -     port->gc.base = port->id * 32;
> > > +     port->gc.base = -1;
> > >
> > >       err = gpiochip_add_data(&port->gc, port);
> > >       if (err)
> 
> 
> 
> -- 
> 
> Dario Binacchi
> 
> Senior Embedded Linux Developer
> 
> dario.binacchi@amarulasolutions.com
> 
> __________________________________
> 
> 
> Amarula Solutions SRL
> 
> Via Le Canevare 30, 31100 Treviso, Veneto, IT
> 
> T. +39 042 243 5310
> info@amarulasolutions.com
> 
> www.amarulasolutions.com
> 
> 
