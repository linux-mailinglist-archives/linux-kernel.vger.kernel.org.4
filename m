Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95ABF61FA04
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 17:36:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232255AbiKGQgZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 11:36:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbiKGQgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 11:36:22 -0500
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FCFFBBF;
        Mon,  7 Nov 2022 08:36:20 -0800 (PST)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 05E97FF805;
        Mon,  7 Nov 2022 16:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1667838978;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jAQbTqH/8jaUUZTUsIcTg0UMfuDAaFx9RDuuc7CD6OU=;
        b=mRLAG34oGiKMZsOczQaNZAqu5C9aJHXgCfyyCd8LH9HZwBvSCy+L/c9P+JVoUf+p0broxK
        xfgxk+9R8zv0qqRFZWZ7IHRXu4CKjo3sZD8oqW8+pdtOrT7Ov1VIVJwGTT3o6P7vU2N3jb
        UINzMeYNXZo8hUKJTVP0IyZOnuCydNM2Vu2CTPJp9xpfk7F2rfxJCQgCWK7KNzZiRfuhjV
        IWDHNxLHQ1kfjiSqDVfyYuAGQ1Ja0YeQyUBbyI+9kwnhpkYsCWyea4qp/b5KW3fe9fSpRo
        TroQdjfXazJf2+x5p4W8NNr7TNrKjgJoTjfFcREsCyxPe5tASXxI5Xi7C71SIA==
Date:   Mon, 7 Nov 2022 17:36:14 +0100
From:   Herve Codina <herve.codina@bootlin.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH 3/7] soc: renesas: r9a06g032-sysctrl: Handle h2mode
 device-tree property
Message-ID: <20221107173614.474707d7@bootlin.com>
In-Reply-To: <CAMuHMdX17=GJgn3=gYUHo7=1r3amXnPYE4h-45pEH=neAV4oKQ@mail.gmail.com>
References: <20221107135825.583877-1-herve.codina@bootlin.com>
        <20221107135825.583877-4-herve.codina@bootlin.com>
        <CAMuHMdX17=GJgn3=gYUHo7=1r3amXnPYE4h-45pEH=neAV4oKQ@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On Mon, 7 Nov 2022 16:18:06 +0100
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> Hi Herv=C3=A9,
>=20
> On Mon, Nov 7, 2022 at 2:59 PM Herve Codina <herve.codina@bootlin.com> wr=
ote:
> > Handle the h2mode property and forces the CFG_USB[H2MODE] bit
> > accordingly.
> >
> > Signed-off-by: Herve Codina <herve.codina@bootlin.com> =20
>=20
> Thanks for your patch!
>=20
> > --- a/drivers/clk/renesas/r9a06g032-clocks.c
> > +++ b/drivers/clk/renesas/r9a06g032-clocks.c
> > @@ -946,6 +946,7 @@ static int __init r9a06g032_clocks_probe(struct pla=
tform_device *pdev)
> >         struct clk *mclk;
> >         unsigned int i;
> >         u16 uart_group_sel[2];
> > +       u32 usb, h2mode;
> >         int error;
> >
> >         clocks =3D devm_kzalloc(dev, sizeof(*clocks), GFP_KERNEL);
> > @@ -966,6 +967,26 @@ static int __init r9a06g032_clocks_probe(struct pl=
atform_device *pdev)
> >         clocks->reg =3D of_iomap(np, 0);
> >         if (WARN_ON(!clocks->reg))
> >                 return -ENOMEM;
> > +
> > +       error =3D of_property_read_u32(np, "renesas,h2mode", &h2mode);
> > +       if (!error) {
> > +               usb =3D readl(clocks->reg + R9A06G032_SYSCTRL_USB);
> > +               switch (h2mode) {
> > +               case 0:
> > +                       /* 1 host, 1 device */
> > +                       usb &=3D ~R9A06G032_SYSCTRL_USB_H2MODE;
> > +                       break;
> > +               case 1:
> > +                       /* 2 hosts */
> > +                       usb |=3D R9A06G032_SYSCTRL_USB_H2MODE;
> > +                       break;
> > +               default:
> > +                       dev_err(dev, "invalid h2mode %d\n", h2mode);
> > +                       return -EINVAL;
> > +               }
> > +               writel(usb, clocks->reg + R9A06G032_SYSCTRL_USB); =20
>=20
> Reading the big fat warnings in the documentation about changing
> this at runtime (disconnect nodes, reset clocks, ...), I'm wondering if
> the above is sufficient?

Well, indeed we should "disconnect all module operated by USBPLL clock=20
from the NoC interconnect".

I am a bit lost in the sysctrl driver and the clock/reset stuffs.
In fact, I don't really know how to do that.

I thought that setting the H2MODE value at the clock probe function would
be sufficient, expecting that the connections would not be already done
and I didn't see any issues on my system.

Maybe I missed the bootloader that could have already done some connections.

Can someone help ?

>=20
> > +       }
> > +
> >         for (i =3D 0; i < ARRAY_SIZE(r9a06g032_clocks); ++i) {
> >                 const struct r9a06g032_clkdesc *d =3D &r9a06g032_clocks=
[i];
> >                 const char *parent_name =3D d->source ? =20
>=20
> Gr{oetje,eeting}s,
>=20
>                         Geert
>=20
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m6=
8k.org
>=20
> In personal conversations with technical people, I call myself a hacker. =
But
> when I'm talking to journalists I just say "programmer" or something like=
 that.
>                                 -- Linus Torvalds

Thanks,
Herv=C3=A9

--=20
Herv=C3=A9 Codina, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
