Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C36FC608F84
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 22:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbiJVUHl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 16:07:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiJVUHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 16:07:33 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1033D1581D;
        Sat, 22 Oct 2022 13:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1666469251; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I4lDdl2R33Rw3FJFjgrKMP7JH5wxfoEkDuahx5BR0co=;
        b=afQVdLCmOBgCi8h/em20G7kMEf3Yp1+pF3SrRZRXDez3Zd7pgv78v1yvtNotxzpICEz34a
        gPnvMEvJe4Vvbyudvt3USgVGsv2H0kaj9VVvoO+j/uTHDkMrTjZycUahkgEeYn58n9tGlK
        DRoMPymei7Eaag0pF2nXOfn8OKdjsRY=
Date:   Sat, 22 Oct 2022 21:07:21 +0100
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
Message-Id: <9W76KR.NVDSVG4IWZ3A3@crapouillou.net>
In-Reply-To: <20221022165047.4020785-3-lis8215@gmail.com>
References: <20221022165047.4020785-1-lis8215@gmail.com>
        <20221022165047.4020785-3-lis8215@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Siarhei,

Le sam. 22 oct. 2022 =E0 19:50:47 +0300, Siarhei Volkau=20
<lis8215@gmail.com> a =E9crit :
> JZ4750/55/60 (but not JZ4760b) have an extra divisor in between extclk
> and peripheral clock, called CPCCR.ECS, the driver can't figure out=20
> the
> real state of the divisor without dirty hack - peek CGU CPCCR=20
> register.
> However, we can rely on a vendor's bootloader (u-boot 1.1.6) behavior:
> if (extclk > 16MHz)
>     the divisor is enabled, so the UART driving clock is extclk/2.
>=20
> This behavior relies on hardware differences: most boards (if not all)
> with those SoCs have 12 or 24 MHz oscillators but many peripherals=20
> want
> 12Mhz to operate properly (AIC and USB-PHY at least).
>=20
> The patch doesn't affect JZ4760's behavior as it is subject for=20
> another
> patchset with re-classification of all supported ingenic UARTs.
>=20
> Link:=20
> https://github.com/carlos-wong/uboot_jz4755/blob/master/cpu/mips/jz_seria=
l.c#L158
> Signed-off-by: Siarhei Volkau <lis8215@gmail.com>
> ---
>  drivers/tty/serial/8250/8250_ingenic.c | 48=20
> ++++++++++++++++++++++----
>  1 file changed, 42 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/tty/serial/8250/8250_ingenic.c=20
> b/drivers/tty/serial/8250/8250_ingenic.c
> index 2b2f5d8d2..744705467 100644
> --- a/drivers/tty/serial/8250/8250_ingenic.c
> +++ b/drivers/tty/serial/8250/8250_ingenic.c
> @@ -87,24 +87,19 @@ static void __init=20
> ingenic_early_console_setup_clock(struct earlycon_device *dev
>  	dev->port.uartclk =3D be32_to_cpup(prop);
>  }
>=20
> -static int __init ingenic_early_console_setup(struct earlycon_device=20
> *dev,
> +static int __init ingenic_earlycon_setup_tail(struct earlycon_device=20
> *dev,
>  					      const char *opt)
>  {
>  	struct uart_port *port =3D &dev->port;
>  	unsigned int divisor;
>  	int baud =3D 115200;
>=20
> -	if (!dev->port.membase)
> -		return -ENODEV;
> -
>  	if (opt) {
>  		unsigned int parity, bits, flow; /* unused for now */
>=20
>  		uart_parse_options(opt, &baud, &parity, &bits, &flow);
>  	}
>=20
> -	ingenic_early_console_setup_clock(dev);
> -
>  	if (dev->baud)
>  		baud =3D dev->baud;
>  	divisor =3D DIV_ROUND_CLOSEST(port->uartclk, 16 * baud);
> @@ -129,9 +124,49 @@ static int __init=20
> ingenic_early_console_setup(struct earlycon_device *dev,
>  	return 0;
>  }
>=20
> +static int __init ingenic_early_console_setup(struct earlycon_device=20
> *dev,
> +					      const char *opt)
> +{
> +	if (!dev->port.membase)
> +		return -ENODEV;
> +
> +	ingenic_early_console_setup_clock(dev);
> +
> +	return ingenic_earlycon_setup_tail(dev, opt);
> +}
> +
> +static int __init jz4750_early_console_setup(struct earlycon_device=20
> *dev,
> +					     const char *opt)
> +{
> +	if (!dev->port.membase)
> +		return -ENODEV;
> +
> +	/*
> +	 * JZ4750/55/60 (not JZ4760b) have an extra divisor
> +	 * between extclk and peripheral clock, the
> +	 * driver can't figure out the real state of the
> +	 * divisor without dirty hacks (peek CGU register).
> +	 * However, we can rely on a vendor's behavior:
> +	 * if (extclk > 16MHz)
> +	 *   the divisor is enabled.
> +	 * This behavior relies on hardware differences:
> +	 * most boards with those SoCs have 12 or 24 MHz
> +	 * oscillators but many peripherals want 12Mhz
> +	 * to operate properly (AIC and USB-phy at least).
> +	 */
> +	ingenic_early_console_setup_clock(dev);
> +	if (dev->port.uartclk > 16000000)
> +		dev->port.uartclk /=3D 2;

I don't understand, didn't we came up to the conclusion in your V1 that=20
it was better to force-enable the EXT/2 divider in the ingenic init=20
code?

-Paul

> +
> +	return ingenic_earlycon_setup_tail(dev, opt);
> +}
> +
>  OF_EARLYCON_DECLARE(jz4740_uart, "ingenic,jz4740-uart",
>  		    ingenic_early_console_setup);
>=20
> +OF_EARLYCON_DECLARE(jz4750_uart, "ingenic,jz4750-uart",
> +		    jz4750_early_console_setup);
> +
>  OF_EARLYCON_DECLARE(jz4770_uart, "ingenic,jz4770-uart",
>  		    ingenic_early_console_setup);
>=20
> @@ -328,6 +363,7 @@ static const struct ingenic_uart_config=20
> x1000_uart_config =3D {
>=20
>  static const struct of_device_id of_match[] =3D {
>  	{ .compatible =3D "ingenic,jz4740-uart", .data =3D &jz4740_uart_config=20
> },
> +	{ .compatible =3D "ingenic,jz4750-uart", .data =3D &jz4760_uart_config=20
> },
>  	{ .compatible =3D "ingenic,jz4760-uart", .data =3D &jz4760_uart_config=20
> },
>  	{ .compatible =3D "ingenic,jz4770-uart", .data =3D &jz4760_uart_config=20
> },
>  	{ .compatible =3D "ingenic,jz4775-uart", .data =3D &jz4760_uart_config=20
> },
> --
> 2.36.1
>=20


