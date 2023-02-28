Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA3CA6A5529
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 10:07:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbjB1JHG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 04:07:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjB1JHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 04:07:04 -0500
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8B4F21975;
        Tue, 28 Feb 2023 01:07:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1677575221; x=1709111221;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bxt5CH6QgERxy6SjGNvJyG5D7z0B+YVQ2jZsCLQY1mM=;
  b=QRsRs1HAe7B1Bdv53cVX0dQuDu17+G4LE/Ptywnyu0KAVpihIstMe38Z
   gYfscLpmRLhQIDYhvVq+a59k7mlLCJQHm6XTsSm53y/7gvX/kQrKdncM2
   KYYV/1Hy8kCDiGPoi3CFRqfLDyP7rU4lBk5M/wu6ZaEoMJhu+hzoykGU3
   SQ55oLRaVkTsH3rbGG748oQCk1zwjgHab4ClYZR8/rfTSznSupsMZp3Yj
   WLfEq1jFaUzqTU/DSRGEZsky2JmA9O8FtTOCDbLwcvXNuksKc4j+9Yfry
   EitfQtoVP6fsSooPmO03jGGH+GmVLYV/RpIp//55D8pKOSfC+/ASmWH3l
   A==;
X-IronPort-AV: E=Sophos;i="5.98,221,1673910000"; 
   d="scan'208";a="29358856"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 28 Feb 2023 10:06:58 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Tue, 28 Feb 2023 10:06:58 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Tue, 28 Feb 2023 10:06:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1677575218; x=1709111218;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bxt5CH6QgERxy6SjGNvJyG5D7z0B+YVQ2jZsCLQY1mM=;
  b=fnpj9xCdyc3yGhZ+1YNVpPKqLy1U6Jhl+KbA6rubYHo6pV4qzyBcTsJ8
   PmglVV54BVrBAP1Tya7ElnMhbR3Oppva6O5AAPZYQYD9NnsV6UhhH6Lix
   bCRW5YSNhKPALf4kQrPmsFv1exMDc1v+IidHhY54FSW5ecdmZ899gHe/n
   H7MI8Lks5sDlrKY5yVyy0VpS6MBtHH7rW3Rsk6Lmjeqy6QSeekCrtF73Q
   V9KeOEsVkOmcgCxxk9GVBPwloLJy2wIQBpWp+2EKBVZ1jYXqPbtCZSwb5
   I2kCesoGJr0TbTyncRmgsl2VqmhZWKp3aM1QHV5ETgzw/Tlp7DNgBqFvK
   w==;
X-IronPort-AV: E=Sophos;i="5.98,221,1673910000"; 
   d="scan'208";a="29358855"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 28 Feb 2023 10:06:58 +0100
Received: from steina-w.localnet (unknown [10.123.53.21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 67718280056;
        Tue, 28 Feb 2023 10:06:58 +0100 (CET)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Marco Felsch <m.felsch@pengutronix.de>
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
Date:   Tue, 28 Feb 2023 10:06:56 +0100
Message-ID: <1900599.taCxCBeP46@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20230228084627.e3afg3tp6tzpepb4@pengutronix.de>
References: <20230226205357.1013504-1-dario.binacchi@amarulasolutions.com> <CABGWkvo=Qnfi+fciQXZ2NWCW2tyMCctaBsYc=VTo_HjYHphkKQ@mail.gmail.com> <20230228084627.e3afg3tp6tzpepb4@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

Am Dienstag, 28. Februar 2023, 09:46:27 CET schrieb Marco Felsch:
> Hi Dario,
>=20
> On 23-02-28, Dario Binacchi wrote:
> > Hi Stefan,
> >=20
> > On Mon, Feb 27, 2023 at 6:52=E2=80=AFPM Stefan Wahren <stefan.wahren@i2=
se.com>=20
wrote:
> > > Hi Dario,
> > >=20
> > > Am 26.02.23 um 21:53 schrieb Dario Binacchi:
> > > > Since commit 502df79b860563d7 ("gpiolib: Warn on drivers still using
> > > > static
> > > > gpiobase allocation"), one or more warnings are printed during boot=
 on
> > > > systems where static allocation of GPIO base is used:
> > > >=20
> > > > [    0.136834] gpio gpiochip0: Static allocation of GPIO base is
> > > > deprecated, use dynamic allocation. [    0.142753] gpio gpiochip1:
> > > > Static allocation of GPIO base is deprecated, use dynamic allocatio=
n.
> > > > [    0.148452] gpio gpiochip2: Static allocation of GPIO base is
> > > > deprecated, use dynamic allocation. [    0.154341] gpio gpiochip3:
> > > > Static allocation of GPIO base is deprecated, use dynamic allocatio=
n.
> > > > [    0.160097] gpio gpiochip4: Static allocation of GPIO base is
> > > > deprecated, use dynamic allocation.
> > > >=20
> > > > So let's follow the suggestion and use dynamic allocation.
> > >=20
> > > i understand the motivation of avoiding these warnings.
> > >=20
> > > AFAIK the MXS platform is older than the dynamic allocation of GPIO
> > > base. In the perfect world all applications has been migrated to
> > > libgpiod / chardev GPIO. But i'm really concerned this hasn't happend
> > > yet, at least for this platform. So i believe this change break
> > > applications, since it affects userspace.
> >=20
> > Thanks for your explanations.
>=20
> There was also a lengthly discussion here:
>=20
> https://lore.kernel.org/all/20230120104647.nwki4silrtd7bt3w@pengutronix.d=
e/
>=20
> > Do you think it makes sense to use a Kconfig option to enable/disable
> > the dynamic allocation of GPIO base?
>=20
> What we could do is to check the GPIO_SYSFS kconfig symbol. If this is
> enabled we should keep the current behaviour to not break the uAPI else
> we can go with the dynamic numbering. What we should avoid is a new
> Kconfig symbol.

Even that is only half of the truth. Apparently this is crucial for=20
GPIO_SYSFS, but even without sysfs it affects the order of the character=20
devices, which might break userspace. The main open issue is, whether GPIO=
=20
aliases shall be supported or not, see see [1] and [2].
Once this is clear, the switch to dynamic base can be done.

Best regards,
Alexander

[1] https://lore.kernel.org/linux-gpio/20230215092421.143199-1-alexander.st=
ein@ew.tq-group.com/T/#u
[2] https://lore.kernel.org/linux-gpio/5941337.lOV4Wx5bFT@steina-w/T/
#m2a74777fc4031b7f6f30ac1dcf65b20e7d3f8f12

> Regards,
>   Marco
>=20
> > As done, if I'm not mistaken, in commit 80d34260f36c6 ("pinctrl:
> > renesas: gpio: Use dynamic GPIO base if no function GPIOs")?
> > With legacy support enabled by default, but the ability to try out the
> > latest dynamic allocation functionality.
> >=20
> > Thanks and regards,
> > Dario
> >=20
> > > Best regards
> > >=20
> > > > Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> > > > ---
> > > >=20
> > > >   drivers/gpio/gpio-mxs.c | 2 +-
> > > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > >=20
> > > > diff --git a/drivers/gpio/gpio-mxs.c b/drivers/gpio/gpio-mxs.c
> > > > index 7f59e5d936c2..b48a7c1fb7c1 100644
> > > > --- a/drivers/gpio/gpio-mxs.c
> > > > +++ b/drivers/gpio/gpio-mxs.c
> > > > @@ -330,7 +330,7 @@ static int mxs_gpio_probe(struct platform_device
> > > > *pdev)
> > > >=20
> > > >       port->gc.to_irq =3D mxs_gpio_to_irq;
> > > >       port->gc.get_direction =3D mxs_gpio_get_direction;
> > > >=20
> > > > -     port->gc.base =3D port->id * 32;
> > > > +     port->gc.base =3D -1;
> > > >=20
> > > >       err =3D gpiochip_add_data(&port->gc, port);
> > > >       if (err)


=2D-=20
TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld, Germ=
any
Amtsgericht M=C3=BCnchen, HRB 105018
Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stefan Sch=
neider
http://www.tq-group.com/


