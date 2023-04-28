Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A9FB6F1324
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 10:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbjD1ITE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 04:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjD1IS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 04:18:59 -0400
Received: from vm3.sequanux.org (static.55.155.9.5.clients.your-server.de [5.9.155.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0A3C1B1;
        Fri, 28 Apr 2023 01:18:57 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by vm3.sequanux.org (Postfix) with ESMTP id EC60310861F;
        Fri, 28 Apr 2023 10:18:37 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at vm3.sequanux.org
Received: from vm3.sequanux.org ([127.0.0.1])
        by localhost (vm3.sequanux.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id cETKzCeCWx17; Fri, 28 Apr 2023 10:18:09 +0200 (CEST)
Received: from localhost (softwrestling.org [95.216.36.37])
        by vm3.sequanux.org (Postfix) with ESMTPSA id EAD251085B9;
        Fri, 28 Apr 2023 10:18:05 +0200 (CEST)
Date:   Fri, 28 Apr 2023 10:17:52 +0200
From:   Simon Guinot <simon.guinot@sequanux.org>
To:     Henning Schild <henning.schild@siemens.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Xing Tong Wu <xingtong.wu@siemens.com>
Subject: Re: [PATCH v2 1/1] gpio-f7188x: fix chip name and pin count on
 Nuvoton chip
Message-ID: <ZEuBMCxeWAx9OilV@76cbfcf04d45>
References: <20230427152055.18380-1-henning.schild@siemens.com>
 <20230427152055.18380-2-henning.schild@siemens.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="B9ChkufLT3oFgTeo"
Content-Disposition: inline
In-Reply-To: <20230427152055.18380-2-henning.schild@siemens.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--B9ChkufLT3oFgTeo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 27, 2023 at 05:20:55PM +0200, Henning Schild wrote:
> In fact the device with chip id 0xD283 is called NCT6126D, and that is
> the chip id the Nuvoton code was written for. Correct that name to avoid
> confusion, because a NCT6116D in fact exists as well but has another
> chip id, and is currently not supported.
>=20
> The look at the spec also revealed that GPIO group7 in fact has 8 pins,
> so correct the pin count in that group as well.
>=20
> Fixes: d0918a84aff0 ("gpio-f7188x: Add GPIO support for Nuvoton NCT6116")
> Reported-by: Xing Tong Wu <xingtong.wu@siemens.com>
> Signed-off-by: Henning Schild <henning.schild@siemens.com>

Acked-by: Simon Guinot <simon.guinot@sequanux.org>

> ---
>  drivers/gpio/Kconfig       |  2 +-
>  drivers/gpio/gpio-f7188x.c | 28 ++++++++++++++--------------
>  2 files changed, 15 insertions(+), 15 deletions(-)
>=20
> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> index badbe0582318..14b655411aa0 100644
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -879,7 +879,7 @@ config GPIO_F7188X
>  	help
>  	  This option enables support for GPIOs found on Fintek Super-I/O
>  	  chips F71869, F71869A, F71882FG, F71889F and F81866.
> -	  As well as Nuvoton Super-I/O chip NCT6116D.
> +	  As well as Nuvoton Super-I/O chip NCT6126D.
> =20
>  	  To compile this driver as a module, choose M here: the module will
>  	  be called f7188x-gpio.
> diff --git a/drivers/gpio/gpio-f7188x.c b/drivers/gpio/gpio-f7188x.c
> index 9effa7769bef..f54ca5a1775e 100644
> --- a/drivers/gpio/gpio-f7188x.c
> +++ b/drivers/gpio/gpio-f7188x.c
> @@ -48,7 +48,7 @@
>  /*
>   * Nuvoton devices.
>   */
> -#define SIO_NCT6116D_ID		0xD283  /* NCT6116D chipset ID */
> +#define SIO_NCT6126D_ID		0xD283  /* NCT6126D chipset ID */
> =20
>  #define SIO_LD_GPIO_NUVOTON	0x07	/* GPIO logical device */
> =20
> @@ -62,7 +62,7 @@ enum chips {
>  	f81866,
>  	f81804,
>  	f81865,
> -	nct6116d,
> +	nct6126d,
>  };
> =20
>  static const char * const f7188x_names[] =3D {
> @@ -74,7 +74,7 @@ static const char * const f7188x_names[] =3D {
>  	"f81866",
>  	"f81804",
>  	"f81865",
> -	"nct6116d",
> +	"nct6126d",
>  };
> =20
>  struct f7188x_sio {
> @@ -187,8 +187,8 @@ static int f7188x_gpio_set_config(struct gpio_chip *c=
hip, unsigned offset,
>  /* Output mode register (0:open drain 1:push-pull). */
>  #define f7188x_gpio_out_mode(base) ((base) + 3)
> =20
> -#define f7188x_gpio_dir_invert(type)	((type) =3D=3D nct6116d)
> -#define f7188x_gpio_data_single(type)	((type) =3D=3D nct6116d)
> +#define f7188x_gpio_dir_invert(type)	((type) =3D=3D nct6126d)
> +#define f7188x_gpio_data_single(type)	((type) =3D=3D nct6126d)
> =20
>  static struct f7188x_gpio_bank f71869_gpio_bank[] =3D {
>  	F7188X_GPIO_BANK(0, 6, 0xF0, DRVNAME "-0"),
> @@ -274,7 +274,7 @@ static struct f7188x_gpio_bank f81865_gpio_bank[] =3D=
 {
>  	F7188X_GPIO_BANK(60, 5, 0x90, DRVNAME "-6"),
>  };
> =20
> -static struct f7188x_gpio_bank nct6116d_gpio_bank[] =3D {
> +static struct f7188x_gpio_bank nct6126d_gpio_bank[] =3D {
>  	F7188X_GPIO_BANK(0, 8, 0xE0, DRVNAME "-0"),
>  	F7188X_GPIO_BANK(10, 8, 0xE4, DRVNAME "-1"),
>  	F7188X_GPIO_BANK(20, 8, 0xE8, DRVNAME "-2"),
> @@ -282,7 +282,7 @@ static struct f7188x_gpio_bank nct6116d_gpio_bank[] =
=3D {
>  	F7188X_GPIO_BANK(40, 8, 0xF0, DRVNAME "-4"),
>  	F7188X_GPIO_BANK(50, 8, 0xF4, DRVNAME "-5"),
>  	F7188X_GPIO_BANK(60, 8, 0xF8, DRVNAME "-6"),
> -	F7188X_GPIO_BANK(70, 1, 0xFC, DRVNAME "-7"),
> +	F7188X_GPIO_BANK(70, 8, 0xFC, DRVNAME "-7"),
>  };
> =20
>  static int f7188x_gpio_get_direction(struct gpio_chip *chip, unsigned of=
fset)
> @@ -490,9 +490,9 @@ static int f7188x_gpio_probe(struct platform_device *=
pdev)
>  		data->nr_bank =3D ARRAY_SIZE(f81865_gpio_bank);
>  		data->bank =3D f81865_gpio_bank;
>  		break;
> -	case nct6116d:
> -		data->nr_bank =3D ARRAY_SIZE(nct6116d_gpio_bank);
> -		data->bank =3D nct6116d_gpio_bank;
> +	case nct6126d:
> +		data->nr_bank =3D ARRAY_SIZE(nct6126d_gpio_bank);
> +		data->bank =3D nct6126d_gpio_bank;
>  		break;
>  	default:
>  		return -ENODEV;
> @@ -559,9 +559,9 @@ static int __init f7188x_find(int addr, struct f7188x=
_sio *sio)
>  	case SIO_F81865_ID:
>  		sio->type =3D f81865;
>  		break;
> -	case SIO_NCT6116D_ID:
> +	case SIO_NCT6126D_ID:
>  		sio->device =3D SIO_LD_GPIO_NUVOTON;
> -		sio->type =3D nct6116d;
> +		sio->type =3D nct6126d;
>  		break;
>  	default:
>  		pr_info("Unsupported Fintek device 0x%04x\n", devid);
> @@ -569,7 +569,7 @@ static int __init f7188x_find(int addr, struct f7188x=
_sio *sio)
>  	}
> =20
>  	/* double check manufacturer where possible */
> -	if (sio->type !=3D nct6116d) {
> +	if (sio->type !=3D nct6126d) {
>  		manid =3D superio_inw(addr, SIO_FINTEK_MANID);
>  		if (manid !=3D SIO_FINTEK_ID) {
>  			pr_debug("Not a Fintek device at 0x%08x\n", addr);
> @@ -581,7 +581,7 @@ static int __init f7188x_find(int addr, struct f7188x=
_sio *sio)
>  	err =3D 0;
> =20
>  	pr_info("Found %s at %#x\n", f7188x_names[sio->type], (unsigned int)add=
r);
> -	if (sio->type !=3D nct6116d)
> +	if (sio->type !=3D nct6126d)
>  		pr_info("   revision %d\n", superio_inb(addr, SIO_FINTEK_DEVREV));
> =20
>  err:
> --=20
> 2.39.2

--B9ChkufLT3oFgTeo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEXW8DgovlR3VS5hA0zyg/RDPmszoFAmRLgSwACgkQzyg/RDPm
szq2shAAurJ8dl9dytEdiGNmxzy+k/J+9FL0BBtx01vzIoObdd3j7Em+/SwbmaFF
ejlUMOlWZ8LnOfRhCma4eaWFwuvtXbTVts7xSzcVQnAGnHDLbkTz/wDiUR35dsXS
2j/DJjV/hfuBpYtxJDjGEkwAGyx5Wo3W42HYrAUu98lKGeERINWCrUaN7Av8WDad
i2Ux5QRramIuO1fhIKS6w3l/sHBpaTMMi5RPizrHMmmSlkK997FgsFbyyDHJCzmb
G/oaiuT2kdNHd3jPbtR3qjvZafxWvOa6dZ0KfLBxlxuT0IFSURBbiFBaXcoHVjDg
smgnBYgzjoOummfS0KzGOM2E4fHtEAiqyULRjlRM7kFZMfr2kn8ePHQCAJ/rqKb3
jCc+ewaKrP5VBZAeZxciA9XfY0hDfAqmknz9TTSvusxAS0tWOq5jXwNotKnbThM0
tHtiDTKZbEzr//RBDoaUmqWtkodQadxF19XCS4FpSJwvKGpB5wKyoNdaRyozlz7y
3q/BXwAzWdxh9cZcYaeksEFdLZOqFAc9aPOrUgqNjwUtuvleXvZtc8L0DLyf3ZVS
at+4sW/eBPmCJvZmdKRcFZzWa99coT1uJZY6EE30QHwq8Kz3WW4sylff7p8JImEZ
SGqfzmHJa8WstY8PP6DJ8NJUbJKI6xOmQ7I2W30K//kLkvj/8Kk=
=QNPV
-----END PGP SIGNATURE-----

--B9ChkufLT3oFgTeo--
