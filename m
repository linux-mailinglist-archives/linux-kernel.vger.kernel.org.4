Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFB88609151
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 07:30:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229455AbiJWFaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 01:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbiJWF36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 01:29:58 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 052833B958;
        Sat, 22 Oct 2022 22:29:57 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id p16so5442248iod.6;
        Sat, 22 Oct 2022 22:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ajr4b2M1NseOmrgXuO1WvhLor3nIr3hL7MajP70+3S4=;
        b=MvwxpN42UqqM+GW440gJil1Wm5UBvV757kK6aKzIE0B15zWaHAtNAq1qeCX6cWbzJN
         mM15wopWC7YT0pLvpKcmoyymdt3VqYS88igCUCYqnFzllPzNgxamybnXMafrdeZk6mpZ
         g7d/kRaPETgykdmaGC0+oS4nl3SJIYywCTFUykpU7CTrjH+VY7VkveuecrCD/O0xKwzi
         XIwPJX21lYqqyrGqWYRSjrEEqdeaGVHHoWR/NWK/jC5cd1NkZJPyyRGhO2Oq0To+dfA0
         C8yacmpmwVqXChFtofdp+DVR2WD7tbUsWHgdlMKYmdNC8x1yPl1huTmg7WCRqsm5fgpa
         LBZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ajr4b2M1NseOmrgXuO1WvhLor3nIr3hL7MajP70+3S4=;
        b=3ukblYryGRRXCo7/8B+9HAq+HCwgCcOZImXR2w3D84rP+iTPrSJjMj7Cnf8qgM1qzV
         m0AH/s15sNELQfvcCszZbPwgvdKIMSk11Zer2m+s5j8GyFf4oMpF8N6BtHiRQ8nRNhOo
         malmP75xZ1m2UVBIumZfxeoNSP/sVctNVHi+zmOrZcj87VbdfcLT+OkgbU6zUR1x4yZO
         vrMTDVJqeVhXV8UPtUrMlZeP/tc7F8Cbfsh73QaU6P7utFAYePYVzcJrmT6qyf6mRWMp
         MzZhQgamUUA4EtFAU5yXncFSRIvv4qKyyp2VBavn7Wyh1GEbMsO3HvEm9Dp/M5Vr2ad1
         rFyg==
X-Gm-Message-State: ACrzQf0UXZUSDhPzi1Ii2DEafS196buDpLCasIvdk89Pa8XAZUEwlztQ
        uzWHptZ+zIQulbmGrvE4Oif9XgC6JGUczQA3BNgoEChdhOznukAu
X-Google-Smtp-Source: AMsMyM5TJWUEMWOLbHL1SXvjGe6NmehHzeD7rlzJ7E9o/9XQNoX6RSEd7lNjLN5Pb2S5l9UUPusH7WGwpmnoZLd6btc=
X-Received: by 2002:a05:6602:1648:b0:6bc:e8b6:8cc9 with SMTP id
 y8-20020a056602164800b006bce8b68cc9mr16877726iow.77.1666502996379; Sat, 22
 Oct 2022 22:29:56 -0700 (PDT)
MIME-Version: 1.0
References: <20221022165047.4020785-1-lis8215@gmail.com> <20221022165047.4020785-3-lis8215@gmail.com>
 <9W76KR.NVDSVG4IWZ3A3@crapouillou.net>
In-Reply-To: <9W76KR.NVDSVG4IWZ3A3@crapouillou.net>
From:   Siarhei Volkau <lis8215@gmail.com>
Date:   Sun, 23 Oct 2022 08:29:45 +0300
Message-ID: <CAKNVLfZmUpFzKsdzY1e_mUTVsM-jnL65Fi6EXYcF80-oNV+DGQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] serial: 8250/ingenic: Add support for the JZ4750/JZ4755
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=D1=81=D0=B1, 22 =D0=BE=D0=BA=D1=82. 2022 =D0=B3. =D0=B2 23:07, Paul Cercue=
il <paul@crapouillou.net>:
>
> Hi Siarhei,
>
> Le sam. 22 oct. 2022 =C3=A0 19:50:47 +0300, Siarhei Volkau
> <lis8215@gmail.com> a =C3=A9crit :
> > JZ4750/55/60 (but not JZ4760b) have an extra divisor in between extclk
> > and peripheral clock, called CPCCR.ECS, the driver can't figure out
> > the
> > real state of the divisor without dirty hack - peek CGU CPCCR
> > register.
> > However, we can rely on a vendor's bootloader (u-boot 1.1.6) behavior:
> > if (extclk > 16MHz)
> >     the divisor is enabled, so the UART driving clock is extclk/2.
> >
> > This behavior relies on hardware differences: most boards (if not all)
> > with those SoCs have 12 or 24 MHz oscillators but many peripherals
> > want
> > 12Mhz to operate properly (AIC and USB-PHY at least).
> >
> > The patch doesn't affect JZ4760's behavior as it is subject for
> > another
> > patchset with re-classification of all supported ingenic UARTs.
> >
> > Link:
> > https://github.com/carlos-wong/uboot_jz4755/blob/master/cpu/mips/jz_ser=
ial.c#L158
> > Signed-off-by: Siarhei Volkau <lis8215@gmail.com>
> > ---
> >  drivers/tty/serial/8250/8250_ingenic.c | 48
> > ++++++++++++++++++++++----
> >  1 file changed, 42 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/tty/serial/8250/8250_ingenic.c
> > b/drivers/tty/serial/8250/8250_ingenic.c
> > index 2b2f5d8d2..744705467 100644
> > --- a/drivers/tty/serial/8250/8250_ingenic.c
> > +++ b/drivers/tty/serial/8250/8250_ingenic.c
> > @@ -87,24 +87,19 @@ static void __init
> > ingenic_early_console_setup_clock(struct earlycon_device *dev
> >       dev->port.uartclk =3D be32_to_cpup(prop);
> >  }
> >
> > -static int __init ingenic_early_console_setup(struct earlycon_device
> > *dev,
> > +static int __init ingenic_earlycon_setup_tail(struct earlycon_device
> > *dev,
> >                                             const char *opt)
> >  {
> >       struct uart_port *port =3D &dev->port;
> >       unsigned int divisor;
> >       int baud =3D 115200;
> >
> > -     if (!dev->port.membase)
> > -             return -ENODEV;
> > -
> >       if (opt) {
> >               unsigned int parity, bits, flow; /* unused for now */
> >
> >               uart_parse_options(opt, &baud, &parity, &bits, &flow);
> >       }
> >
> > -     ingenic_early_console_setup_clock(dev);
> > -
> >       if (dev->baud)
> >               baud =3D dev->baud;
> >       divisor =3D DIV_ROUND_CLOSEST(port->uartclk, 16 * baud);
> > @@ -129,9 +124,49 @@ static int __init
> > ingenic_early_console_setup(struct earlycon_device *dev,
> >       return 0;
> >  }
> >
> > +static int __init ingenic_early_console_setup(struct earlycon_device
> > *dev,
> > +                                           const char *opt)
> > +{
> > +     if (!dev->port.membase)
> > +             return -ENODEV;
> > +
> > +     ingenic_early_console_setup_clock(dev);
> > +
> > +     return ingenic_earlycon_setup_tail(dev, opt);
> > +}
> > +
> > +static int __init jz4750_early_console_setup(struct earlycon_device
> > *dev,
> > +                                          const char *opt)
> > +{
> > +     if (!dev->port.membase)
> > +             return -ENODEV;
> > +
> > +     /*
> > +      * JZ4750/55/60 (not JZ4760b) have an extra divisor
> > +      * between extclk and peripheral clock, the
> > +      * driver can't figure out the real state of the
> > +      * divisor without dirty hacks (peek CGU register).
> > +      * However, we can rely on a vendor's behavior:
> > +      * if (extclk > 16MHz)
> > +      *   the divisor is enabled.
> > +      * This behavior relies on hardware differences:
> > +      * most boards with those SoCs have 12 or 24 MHz
> > +      * oscillators but many peripherals want 12Mhz
> > +      * to operate properly (AIC and USB-phy at least).
> > +      */
> > +     ingenic_early_console_setup_clock(dev);
> > +     if (dev->port.uartclk > 16000000)
> > +             dev->port.uartclk /=3D 2;
>
> I don't understand, didn't we came up to the conclusion in your V1 that
> it was better to force-enable the EXT/2 divider in the ingenic init
> code?
>
> -Paul
>

That was better at that moment. I dived deeper in the situation and found
a more simple and universal solution, as I think.
Your proposal doesn't cover following situations:
 - JZ475x with 12MHz crystal
 - JZ4760 with 24MHz crystal
which are legal and might appear in some hardware.

> > +
> > +     return ingenic_earlycon_setup_tail(dev, opt);
> > +}
> > +
> >  OF_EARLYCON_DECLARE(jz4740_uart, "ingenic,jz4740-uart",
> >                   ingenic_early_console_setup);
> >
> > +OF_EARLYCON_DECLARE(jz4750_uart, "ingenic,jz4750-uart",
> > +                 jz4750_early_console_setup);
> > +
> >  OF_EARLYCON_DECLARE(jz4770_uart, "ingenic,jz4770-uart",
> >                   ingenic_early_console_setup);
> >
> > @@ -328,6 +363,7 @@ static const struct ingenic_uart_config
> > x1000_uart_config =3D {
> >
> >  static const struct of_device_id of_match[] =3D {
> >       { .compatible =3D "ingenic,jz4740-uart", .data =3D &jz4740_uart_c=
onfig
> > },
> > +     { .compatible =3D "ingenic,jz4750-uart", .data =3D &jz4760_uart_c=
onfig
> > },
> >       { .compatible =3D "ingenic,jz4760-uart", .data =3D &jz4760_uart_c=
onfig
> > },
> >       { .compatible =3D "ingenic,jz4770-uart", .data =3D &jz4760_uart_c=
onfig
> > },
> >       { .compatible =3D "ingenic,jz4775-uart", .data =3D &jz4760_uart_c=
onfig
> > },
> > --
> > 2.36.1
> >
>
>
