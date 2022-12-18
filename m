Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E01064FEE4
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Dec 2022 13:44:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbiLRMo2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Dec 2022 07:44:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbiLRMoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Dec 2022 07:44:25 -0500
Received: from out-111.mta0.migadu.com (out-111.mta0.migadu.com [91.218.175.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9E7AC0F
        for <linux-kernel@vger.kernel.org>; Sun, 18 Dec 2022 04:44:23 -0800 (PST)
Message-ID: <83c2ef58243f12f5e3fa36fb7a4e2d74faf28990.camel@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1671367461;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Vw9cJnccZBgvAQIi+XuStsPuQH4rQLQ9Ak8DoTFHcDw=;
        b=EKU08Hezk6JNk37SUP/8qJRdEzVPoqCuEL6dwfr/pXFFX50+ZfFhWMCjtcrRYCPzwGljiB
        x5zopbwaxlTcrO9CJcTqVqyQcSyTN6a5ykl+LM6Wnhm4bME2zlJPsYHAlLpJV/Z+plhOlz
        H2fmumHS0/BmI1Pyr5dLlviBbgDUPwY=
Subject: Re: [PATCH] gpio: sprd: Make irq_chip immutable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Cixi Geng <cixi.geng@linux.dev>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>,
        linus.walleij@linaro.org, brgl@bgdev.pl, orsonzhai@gmail.com,
        zhang.lyra@gmail.com, gengcixi@gmail.com
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Sun, 18 Dec 2022 20:44:11 +0800
In-Reply-To: <97e244d4-6b5c-31c9-7329-b8deef615645@linux.alibaba.com>
References: <20221216041708.32768-1-cixi.geng@linux.dev>
         <97e244d4-6b5c-31c9-7329-b8deef615645@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-12-16 at 14:50 +0800, Baolin Wang wrote:
> >=20
> >=20
> > On 12/16/2022 12:17 PM, Cixi Geng wrote:
> > > > From: Cixi Geng <cixi.geng1@unisoc.com>
> > > >=20
> > > > Kernel warns about mutable irq_chips:
> > > >=20
> > > > =C2=A0=C2=A0=C2=A0=C2=A0 "not an immutable chip, please consider fi=
xing!"
> > > >=20
> > > > Make the struct irq_chip const, flag it as IRQCHIP_IMMUTABLE,
> > > > add > > the
> > > > new helper functions, and call the appropriate gpiolib
> > > > functions.
> >=20
> > Please split them into 3 patches and each patch converts one
> > driver,=20
> > which is easy to review.
Thanks for reviewing, I will modify the comments in the next version
> >=20
> > > >=20
> > > > Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>
> > > > ---
> > > > =C2=A0 drivers/gpio/gpio-eic-sprd.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0 4 ++--
> > > > =C2=A0 drivers/gpio/gpio-pmic-eic-sprd.c |=C2=A0 4 ++--
> > > > =C2=A0 drivers/gpio/gpio-sprd.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 | 11 +++++++++--
> > > > =C2=A0 3 files changed, 13 insertions(+), 6 deletions(-)
> > > >=20
> > > > diff --git a/drivers/gpio/gpio-eic-sprd.c > >
> > > > b/drivers/gpio/gpio-eic-sprd.c
> > > > index 8d722e026e9c..07b9099f2a6d 100644
> > > > --- a/drivers/gpio/gpio-eic-sprd.c
> > > > +++ b/drivers/gpio/gpio-eic-sprd.c
> > > > @@ -631,10 +631,10 @@ static int sprd_eic_probe(struct > >
> > > > platform_device *pdev)
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0sprd_eic->intc.irq_=
mask =3D sprd_eic_irq_mask;
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0sprd_eic->intc.irq_=
unmask =3D sprd_eic_irq_unmask;
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0sprd_eic->intc.irq_=
set_type =3D sprd_eic_irq_set_type;
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0sprd_eic->intc.flags =3D=
 IRQCHIP_SKIP_SET_WAKE;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0sprd_eic->intc.flags =3D=
 IRQCHIP_SKIP_SET_WAKE | > >
> > > > IRQCHIP_IMMUTABLE;
> > > > =C2=A0=20
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0irq =3D &sprd_eic->=
chip.irq;
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0irq->chip =3D &sprd_eic-=
>intc;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0gpio_irq_chip_set_chip(i=
rq, &sprd_eic->intc);
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0irq->handler =3D ha=
ndle_bad_irq;
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0irq->default_type =
=3D IRQ_TYPE_NONE;
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0irq->parent_handler=
 =3D sprd_eic_irq_handler;
> > > > diff --git a/drivers/gpio/gpio-pmic-eic-sprd.c > >
> > > > b/drivers/gpio/gpio-pmic-eic-sprd.c
> > > > index e518490c4b68..d96604ea10e7 100644
> > > > --- a/drivers/gpio/gpio-pmic-eic-sprd.c
> > > > +++ b/drivers/gpio/gpio-pmic-eic-sprd.c
> > > > @@ -344,10 +344,10 @@ static int sprd_pmic_eic_probe(struct > >
> > > > platform_device *pdev)
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pmic_eic->intc.irq_=
set_type =3D
> > > > sprd_pmic_eic_irq_set_type;
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pmic_eic->intc.irq_=
bus_lock =3D sprd_pmic_eic_bus_lock;
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pmic_eic->intc.irq_=
bus_sync_unlock =3D > >
> > > > sprd_pmic_eic_bus_sync_unlock;
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pmic_eic->intc.flags =3D=
 IRQCHIP_SKIP_SET_WAKE;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pmic_eic->intc.flags =3D=
 IRQCHIP_SKIP_SET_WAKE | > >
> > > > IRQCHIP_IMMUTABLE;
> >=20
> > Why not add GPIOCHIP_IRQ_RESOURCE_HELPERS for above 2 drivers?
> > Seems > we=20
> > can remove the irq_chip from pmic_eic structure, instead we can >
> > define=20
> > it statically with adding GPIOCHIP_IRQ_RESOURCE_HELPERS like other
> > > patch=20
> > [1] did?
> >=20
> > [1] >
> > https://lore.kernel.org/all/20220419141846.598305-6-maz@kernel.org/
> >=20
> > > > =C2=A0=20
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0irq =3D &pmic_eic->=
chip.irq;
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0irq->chip =3D &pmic_eic-=
>intc;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0gpio_irq_chip_set_chip(i=
rq, &pmic_eic->intc);
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0irq->threaded =3D t=
rue;
> > > > =C2=A0=20
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret =3D devm_gpioch=
ip_add_data(&pdev->dev, &pmic_eic-
> > > > >chip, > > pmic_eic);
> > > > diff --git a/drivers/gpio/gpio-sprd.c b/drivers/gpio/gpio-
> > > > sprd.c
> > > > index 9bff63990eee..8398f9707ec0 100644
> > > > --- a/drivers/gpio/gpio-sprd.c
> > > > +++ b/drivers/gpio/gpio-sprd.c
> > > > @@ -64,6 +64,11 @@ static void sprd_gpio_update(struct
> > > > gpio_chip > > *chip, unsigned int offset,
> > > > =C2=A0=20
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0writel_relaxed(tmp,=
 base + reg);
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0spin_unlock_irqrest=
ore(&sprd_gpio->lock, flags);
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (reg =3D=3D SPRD_GPIO=
_IE && val =3D=3D 1)
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0gpiochip_enable_irq(chip, offset);
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0else if (reg =3D=3D SPRD=
_GPIO_IE && val =3D=3D 0)
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0gpiochip_disable_irq(chip, offset);
> >=20
> > Looks incorrect to me, IIUC you should move=20
> > gpiochip_enable_irq/gpiochip_disable_irq() into
> > sprd_gpio_irq_mask() > and=20
> > sprd_gpio_irq_unmask().
> >=20
> > > > =C2=A0 }
> > > > =C2=A0=20
> > > > =C2=A0 static int sprd_gpio_read(struct gpio_chip *chip, unsigned
> > > > int > > offset, u16 reg)
> > > > @@ -205,13 +210,15 @@ static void sprd_gpio_irq_handler(struct
> > > > > > irq_desc *desc)
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0chained_irq_exit(ic=
, desc);
> > > > =C2=A0 }
> > > > =C2=A0=20
> > > > -static struct irq_chip sprd_gpio_irqchip =3D {
> > > > +static const struct irq_chip sprd_gpio_irqchip =3D {
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.name =3D "sprd-gpi=
o",
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.irq_ack =3D sprd_g=
pio_irq_ack,
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.irq_mask =3D sprd_=
gpio_irq_mask,
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.irq_unmask =3D spr=
d_gpio_irq_unmask,
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.irq_set_type =3D s=
prd_gpio_irq_set_type,
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.flags =3D IRQCHIP_=
SKIP_SET_WAKE,
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.flags =3D IRQCHIP_SKIP_=
SET_WAKE | IRQCHIP_IMMUTABLE,
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0GPIOCHIP_IRQ_RESOURCE_HE=
LPERS,
> > > > =C2=A0 };
> > > > =C2=A0=20
> > > > =C2=A0 static int sprd_gpio_probe(struct platform_device *pdev)
> > > > @@ -245,7 +252,7 @@ static int sprd_gpio_probe(struct > >
> > > > platform_device *pdev)
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0sprd_gpio->chip.dir=
ection_output =3D > >
> > > > sprd_gpio_direction_output;
> > > > =C2=A0=20
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0irq =3D &sprd_gpio-=
>chip.irq;
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0irq->chip =3D &sprd_gpio=
_irqchip;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0gpio_irq_chip_set_chip(i=
rq, &sprd_gpio_irqchip);
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0irq->handler =3D ha=
ndle_bad_irq;
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0irq->default_type =
=3D IRQ_TYPE_NONE;
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0irq->parent_handler=
 =3D sprd_gpio_irq_handler;

