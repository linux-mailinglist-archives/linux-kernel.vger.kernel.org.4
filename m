Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FBDE6091FA
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 11:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbiJWJQm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 05:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbiJWJQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 05:16:36 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE53974DE4;
        Sun, 23 Oct 2022 02:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1666516580; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H7RtD++1u5fevcptE9TXwCT0AimO9ZvWvbekTS/uCbE=;
        b=oUXmfxcwPCLfN0I+Ng6Nc9Hy6xMGMcrMvu1yGSiiv4jCf1fL2WzeOZOiBCU2Na1PT5oC4Z
        ztcTqE13tr7tZbF7VFrajGZOKAHUX9U6/Gep6ruUc6X5CRfxfBm97HTX/nM5uoA2sdZ1Mr
        myYoO0eezCUzbSsX8u7Uh4gPY5ho5Y8=
Date:   Sun, 23 Oct 2022 10:16:10 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v3 2/2] serial: 8250/ingenic: Add support for the
 JZ4750/JZ4755
To:     Siarhei Volkau <lis8215@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org
Message-Id: <YE87KR.VC65A15U1PH41@crapouillou.net>
In-Reply-To: <CAKNVLfZmUpFzKsdzY1e_mUTVsM-jnL65Fi6EXYcF80-oNV+DGQ@mail.gmail.com>
References: <20221022165047.4020785-1-lis8215@gmail.com>
        <20221022165047.4020785-3-lis8215@gmail.com>
        <9W76KR.NVDSVG4IWZ3A3@crapouillou.net>
        <CAKNVLfZmUpFzKsdzY1e_mUTVsM-jnL65Fi6EXYcF80-oNV+DGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le dim. 23 oct. 2022 =C3=A0 08:29:45 +0300, Siarhei Volkau=20
<lis8215@gmail.com> a =C3=A9crit :
> =D1=81=D0=B1, 22 =D0=BE=D0=BA=D1=82. 2022 =D0=B3. =D0=B2 23:07, Paul Cerc=
ueil=20
> <paul@crapouillou.net>:
>>=20
>>  Hi Siarhei,
>>=20
>>  Le sam. 22 oct. 2022 =C3=A0 19:50:47 +0300, Siarhei Volkau
>>  <lis8215@gmail.com> a =C3=A9crit :
>>  > JZ4750/55/60 (but not JZ4760b) have an extra divisor in between=20
>> extclk
>>  > and peripheral clock, called CPCCR.ECS, the driver can't figure=20
>> out
>>  > the
>>  > real state of the divisor without dirty hack - peek CGU CPCCR
>>  > register.
>>  > However, we can rely on a vendor's bootloader (u-boot 1.1.6)=20
>> behavior:
>>  > if (extclk > 16MHz)
>>  >     the divisor is enabled, so the UART driving clock is extclk/2.
>>  >
>>  > This behavior relies on hardware differences: most boards (if not=20
>> all)
>>  > with those SoCs have 12 or 24 MHz oscillators but many peripherals
>>  > want
>>  > 12Mhz to operate properly (AIC and USB-PHY at least).
>>  >
>>  > The patch doesn't affect JZ4760's behavior as it is subject for
>>  > another
>>  > patchset with re-classification of all supported ingenic UARTs.
>>  >
>>  > Link:
>>  >=20
>> https://github.com/carlos-wong/uboot_jz4755/blob/master/cpu/mips/jz_seri=
al.c#L158
>>  > Signed-off-by: Siarhei Volkau <lis8215@gmail.com>
>>  > ---
>>  >  drivers/tty/serial/8250/8250_ingenic.c | 48
>>  > ++++++++++++++++++++++----
>>  >  1 file changed, 42 insertions(+), 6 deletions(-)
>>  >
>>  > diff --git a/drivers/tty/serial/8250/8250_ingenic.c
>>  > b/drivers/tty/serial/8250/8250_ingenic.c
>>  > index 2b2f5d8d2..744705467 100644
>>  > --- a/drivers/tty/serial/8250/8250_ingenic.c
>>  > +++ b/drivers/tty/serial/8250/8250_ingenic.c
>>  > @@ -87,24 +87,19 @@ static void __init
>>  > ingenic_early_console_setup_clock(struct earlycon_device *dev
>>  >       dev->port.uartclk =3D be32_to_cpup(prop);
>>  >  }
>>  >
>>  > -static int __init ingenic_early_console_setup(struct=20
>> earlycon_device
>>  > *dev,
>>  > +static int __init ingenic_earlycon_setup_tail(struct=20
>> earlycon_device
>>  > *dev,
>>  >                                             const char *opt)
>>  >  {
>>  >       struct uart_port *port =3D &dev->port;
>>  >       unsigned int divisor;
>>  >       int baud =3D 115200;
>>  >
>>  > -     if (!dev->port.membase)
>>  > -             return -ENODEV;
>>  > -
>>  >       if (opt) {
>>  >               unsigned int parity, bits, flow; /* unused for now=20
>> */
>>  >
>>  >               uart_parse_options(opt, &baud, &parity, &bits,=20
>> &flow);
>>  >       }
>>  >
>>  > -     ingenic_early_console_setup_clock(dev);
>>  > -
>>  >       if (dev->baud)
>>  >               baud =3D dev->baud;
>>  >       divisor =3D DIV_ROUND_CLOSEST(port->uartclk, 16 * baud);
>>  > @@ -129,9 +124,49 @@ static int __init
>>  > ingenic_early_console_setup(struct earlycon_device *dev,
>>  >       return 0;
>>  >  }
>>  >
>>  > +static int __init ingenic_early_console_setup(struct=20
>> earlycon_device
>>  > *dev,
>>  > +                                           const char *opt)
>>  > +{
>>  > +     if (!dev->port.membase)
>>  > +             return -ENODEV;
>>  > +
>>  > +     ingenic_early_console_setup_clock(dev);
>>  > +
>>  > +     return ingenic_earlycon_setup_tail(dev, opt);
>>  > +}
>>  > +
>>  > +static int __init jz4750_early_console_setup(struct=20
>> earlycon_device
>>  > *dev,
>>  > +                                          const char *opt)
>>  > +{
>>  > +     if (!dev->port.membase)
>>  > +             return -ENODEV;
>>  > +
>>  > +     /*
>>  > +      * JZ4750/55/60 (not JZ4760b) have an extra divisor
>>  > +      * between extclk and peripheral clock, the
>>  > +      * driver can't figure out the real state of the
>>  > +      * divisor without dirty hacks (peek CGU register).
>>  > +      * However, we can rely on a vendor's behavior:
>>  > +      * if (extclk > 16MHz)
>>  > +      *   the divisor is enabled.
>>  > +      * This behavior relies on hardware differences:
>>  > +      * most boards with those SoCs have 12 or 24 MHz
>>  > +      * oscillators but many peripherals want 12Mhz
>>  > +      * to operate properly (AIC and USB-phy at least).
>>  > +      */
>>  > +     ingenic_early_console_setup_clock(dev);
>>  > +     if (dev->port.uartclk > 16000000)
>>  > +             dev->port.uartclk /=3D 2;
>>=20
>>  I don't understand, didn't we came up to the conclusion in your V1=20
>> that
>>  it was better to force-enable the EXT/2 divider in the ingenic init
>>  code?
>>=20
>>  -Paul
>>=20
>=20
> That was better at that moment. I dived deeper in the situation and=20
> found
> a more simple and universal solution, as I think.
> Your proposal doesn't cover following situations:
>  - JZ475x with 12MHz crystal
>  - JZ4760 with 24MHz crystal
> which are legal and might appear in some hardware.

Do you have such hardware?

Don't add support for cases you can't test.

For what we know - all JZ475x use a 24 MHz crystal and all JZ4760(B)=20
use a 12 MHz crystal, until proven otherwise.

-Paul

>>  > +
>>  > +     return ingenic_earlycon_setup_tail(dev, opt);
>>  > +}
>>  > +
>>  >  OF_EARLYCON_DECLARE(jz4740_uart, "ingenic,jz4740-uart",
>>  >                   ingenic_early_console_setup);
>>  >
>>  > +OF_EARLYCON_DECLARE(jz4750_uart, "ingenic,jz4750-uart",
>>  > +                 jz4750_early_console_setup);
>>  > +
>>  >  OF_EARLYCON_DECLARE(jz4770_uart, "ingenic,jz4770-uart",
>>  >                   ingenic_early_console_setup);
>>  >
>>  > @@ -328,6 +363,7 @@ static const struct ingenic_uart_config
>>  > x1000_uart_config =3D {
>>  >
>>  >  static const struct of_device_id of_match[] =3D {
>>  >       { .compatible =3D "ingenic,jz4740-uart", .data =3D=20
>> &jz4740_uart_config
>>  > },
>>  > +     { .compatible =3D "ingenic,jz4750-uart", .data =3D=20
>> &jz4760_uart_config
>>  > },
>>  >       { .compatible =3D "ingenic,jz4760-uart", .data =3D=20
>> &jz4760_uart_config
>>  > },
>>  >       { .compatible =3D "ingenic,jz4770-uart", .data =3D=20
>> &jz4760_uart_config
>>  > },
>>  >       { .compatible =3D "ingenic,jz4775-uart", .data =3D=20
>> &jz4760_uart_config
>>  > },
>>  > --
>>  > 2.36.1
>>  >
>>=20
>>=20


