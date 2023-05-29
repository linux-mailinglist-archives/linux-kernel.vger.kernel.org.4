Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8AB71497F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 14:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231753AbjE2M1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 08:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230210AbjE2M1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 08:27:34 -0400
Received: from vm3.sequanux.org (static.55.155.9.5.clients.your-server.de [5.9.155.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E2370AB;
        Mon, 29 May 2023 05:27:31 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by vm3.sequanux.org (Postfix) with ESMTP id 3DA9A10861C;
        Mon, 29 May 2023 14:27:09 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at vm3.sequanux.org
Received: from vm3.sequanux.org ([127.0.0.1])
        by localhost (vm3.sequanux.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id K99ER9AJhBoN; Mon, 29 May 2023 14:26:40 +0200 (CEST)
Received: from localhost (ns3093303.ip-145-239-244.eu [145.239.244.120])
        by vm3.sequanux.org (Postfix) with ESMTPSA id 372EF1080DD;
        Mon, 29 May 2023 14:26:40 +0200 (CEST)
Date:   Mon, 29 May 2023 14:26:29 +0200
From:   simon.guinot@sequanux.org
To:     xingtong_wu@163.com
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        henning.schild@siemens.com, xingtong.wu@siemens.com
Subject: Re: [PATCH v2 1/1] gpio-f7188x: fix base values conflicts with other
 gpio pins
Message-ID: <ZHSZ9cK78qc5QeZD@localhost>
References: <20230529025011.2806-1-xingtong_wu@163.com>
 <20230529025011.2806-2-xingtong_wu@163.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Pn04Kz12XNGOy554"
Content-Disposition: inline
In-Reply-To: <20230529025011.2806-2-xingtong_wu@163.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Pn04Kz12XNGOy554
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 29, 2023 at 10:50:12AM +0800, xingtong_wu@163.com wrote:
> From: "xingtong.wu" <xingtong.wu@siemens.com>
>=20
> switch pin base from static to automatic allocation to
> avoid conflicts and align with other gpio chip drivers

Hi xingtong,

I suppose this patch is correct but I am not a big fan.

It would be nice if a pin number found in the device datasheet could
still be converted into a Linux GPIO number by adding the base of the
first bank.

With this patch it is no longer possible. All the F7188x controllers
have holes in their pin namespace (between the banks/chips). And a base
number assigned dynamically to each chip won't take these holes into
account.

Simon

>=20
> Signed-off-by: xingtong.wu <xingtong.wu@siemens.com>
> ---
>  drivers/gpio/gpio-f7188x.c | 138 ++++++++++++++++++-------------------
>  1 file changed, 69 insertions(+), 69 deletions(-)
>=20
> diff --git a/drivers/gpio/gpio-f7188x.c b/drivers/gpio/gpio-f7188x.c
> index f54ca5a1775e..3875fd940ccb 100644
> --- a/drivers/gpio/gpio-f7188x.c
> +++ b/drivers/gpio/gpio-f7188x.c
> @@ -163,7 +163,7 @@ static void f7188x_gpio_set(struct gpio_chip *chip, u=
nsigned offset, int value);
>  static int f7188x_gpio_set_config(struct gpio_chip *chip, unsigned offse=
t,
>  				  unsigned long config);
> =20
> -#define F7188X_GPIO_BANK(_base, _ngpio, _regbase, _label)			\
> +#define F7188X_GPIO_BANK(_ngpio, _regbase, _label)			\
>  	{								\
>  		.chip =3D {						\
>  			.label            =3D _label,			\
> @@ -174,7 +174,7 @@ static int f7188x_gpio_set_config(struct gpio_chip *c=
hip, unsigned offset,
>  			.direction_output =3D f7188x_gpio_direction_out,	\
>  			.set              =3D f7188x_gpio_set,		\
>  			.set_config	  =3D f7188x_gpio_set_config,	\
> -			.base             =3D _base,			\
> +			.base             =3D -1,				\
>  			.ngpio            =3D _ngpio,			\
>  			.can_sleep        =3D true,			\
>  		},							\
> @@ -191,98 +191,98 @@ static int f7188x_gpio_set_config(struct gpio_chip =
*chip, unsigned offset,
>  #define f7188x_gpio_data_single(type)	((type) =3D=3D nct6126d)
> =20
>  static struct f7188x_gpio_bank f71869_gpio_bank[] =3D {
> -	F7188X_GPIO_BANK(0, 6, 0xF0, DRVNAME "-0"),
> -	F7188X_GPIO_BANK(10, 8, 0xE0, DRVNAME "-1"),
> -	F7188X_GPIO_BANK(20, 8, 0xD0, DRVNAME "-2"),
> -	F7188X_GPIO_BANK(30, 8, 0xC0, DRVNAME "-3"),
> -	F7188X_GPIO_BANK(40, 8, 0xB0, DRVNAME "-4"),
> -	F7188X_GPIO_BANK(50, 5, 0xA0, DRVNAME "-5"),
> -	F7188X_GPIO_BANK(60, 6, 0x90, DRVNAME "-6"),
> +	F7188X_GPIO_BANK(6, 0xF0, DRVNAME "-0"),
> +	F7188X_GPIO_BANK(8, 0xE0, DRVNAME "-1"),
> +	F7188X_GPIO_BANK(8, 0xD0, DRVNAME "-2"),
> +	F7188X_GPIO_BANK(8, 0xC0, DRVNAME "-3"),
> +	F7188X_GPIO_BANK(8, 0xB0, DRVNAME "-4"),
> +	F7188X_GPIO_BANK(5, 0xA0, DRVNAME "-5"),
> +	F7188X_GPIO_BANK(6, 0x90, DRVNAME "-6"),
>  };
> =20
>  static struct f7188x_gpio_bank f71869a_gpio_bank[] =3D {
> -	F7188X_GPIO_BANK(0, 6, 0xF0, DRVNAME "-0"),
> -	F7188X_GPIO_BANK(10, 8, 0xE0, DRVNAME "-1"),
> -	F7188X_GPIO_BANK(20, 8, 0xD0, DRVNAME "-2"),
> -	F7188X_GPIO_BANK(30, 8, 0xC0, DRVNAME "-3"),
> -	F7188X_GPIO_BANK(40, 8, 0xB0, DRVNAME "-4"),
> -	F7188X_GPIO_BANK(50, 5, 0xA0, DRVNAME "-5"),
> -	F7188X_GPIO_BANK(60, 8, 0x90, DRVNAME "-6"),
> -	F7188X_GPIO_BANK(70, 8, 0x80, DRVNAME "-7"),
> +	F7188X_GPIO_BANK(6, 0xF0, DRVNAME "-0"),
> +	F7188X_GPIO_BANK(8, 0xE0, DRVNAME "-1"),
> +	F7188X_GPIO_BANK(8, 0xD0, DRVNAME "-2"),
> +	F7188X_GPIO_BANK(8, 0xC0, DRVNAME "-3"),
> +	F7188X_GPIO_BANK(8, 0xB0, DRVNAME "-4"),
> +	F7188X_GPIO_BANK(5, 0xA0, DRVNAME "-5"),
> +	F7188X_GPIO_BANK(8, 0x90, DRVNAME "-6"),
> +	F7188X_GPIO_BANK(8, 0x80, DRVNAME "-7"),
>  };
> =20
>  static struct f7188x_gpio_bank f71882_gpio_bank[] =3D {
> -	F7188X_GPIO_BANK(0, 8, 0xF0, DRVNAME "-0"),
> -	F7188X_GPIO_BANK(10, 8, 0xE0, DRVNAME "-1"),
> -	F7188X_GPIO_BANK(20, 8, 0xD0, DRVNAME "-2"),
> -	F7188X_GPIO_BANK(30, 4, 0xC0, DRVNAME "-3"),
> -	F7188X_GPIO_BANK(40, 4, 0xB0, DRVNAME "-4"),
> +	F7188X_GPIO_BANK(8, 0xF0, DRVNAME "-0"),
> +	F7188X_GPIO_BANK(8, 0xE0, DRVNAME "-1"),
> +	F7188X_GPIO_BANK(8, 0xD0, DRVNAME "-2"),
> +	F7188X_GPIO_BANK(4, 0xC0, DRVNAME "-3"),
> +	F7188X_GPIO_BANK(4, 0xB0, DRVNAME "-4"),
>  };
> =20
>  static struct f7188x_gpio_bank f71889a_gpio_bank[] =3D {
> -	F7188X_GPIO_BANK(0, 7, 0xF0, DRVNAME "-0"),
> -	F7188X_GPIO_BANK(10, 7, 0xE0, DRVNAME "-1"),
> -	F7188X_GPIO_BANK(20, 8, 0xD0, DRVNAME "-2"),
> -	F7188X_GPIO_BANK(30, 8, 0xC0, DRVNAME "-3"),
> -	F7188X_GPIO_BANK(40, 8, 0xB0, DRVNAME "-4"),
> -	F7188X_GPIO_BANK(50, 5, 0xA0, DRVNAME "-5"),
> -	F7188X_GPIO_BANK(60, 8, 0x90, DRVNAME "-6"),
> -	F7188X_GPIO_BANK(70, 8, 0x80, DRVNAME "-7"),
> +	F7188X_GPIO_BANK(7, 0xF0, DRVNAME "-0"),
> +	F7188X_GPIO_BANK(7, 0xE0, DRVNAME "-1"),
> +	F7188X_GPIO_BANK(8, 0xD0, DRVNAME "-2"),
> +	F7188X_GPIO_BANK(8, 0xC0, DRVNAME "-3"),
> +	F7188X_GPIO_BANK(8, 0xB0, DRVNAME "-4"),
> +	F7188X_GPIO_BANK(5, 0xA0, DRVNAME "-5"),
> +	F7188X_GPIO_BANK(8, 0x90, DRVNAME "-6"),
> +	F7188X_GPIO_BANK(8, 0x80, DRVNAME "-7"),
>  };
> =20
>  static struct f7188x_gpio_bank f71889_gpio_bank[] =3D {
> -	F7188X_GPIO_BANK(0, 7, 0xF0, DRVNAME "-0"),
> -	F7188X_GPIO_BANK(10, 7, 0xE0, DRVNAME "-1"),
> -	F7188X_GPIO_BANK(20, 8, 0xD0, DRVNAME "-2"),
> -	F7188X_GPIO_BANK(30, 8, 0xC0, DRVNAME "-3"),
> -	F7188X_GPIO_BANK(40, 8, 0xB0, DRVNAME "-4"),
> -	F7188X_GPIO_BANK(50, 5, 0xA0, DRVNAME "-5"),
> -	F7188X_GPIO_BANK(60, 8, 0x90, DRVNAME "-6"),
> -	F7188X_GPIO_BANK(70, 8, 0x80, DRVNAME "-7"),
> +	F7188X_GPIO_BANK(7, 0xF0, DRVNAME "-0"),
> +	F7188X_GPIO_BANK(7, 0xE0, DRVNAME "-1"),
> +	F7188X_GPIO_BANK(8, 0xD0, DRVNAME "-2"),
> +	F7188X_GPIO_BANK(8, 0xC0, DRVNAME "-3"),
> +	F7188X_GPIO_BANK(8, 0xB0, DRVNAME "-4"),
> +	F7188X_GPIO_BANK(5, 0xA0, DRVNAME "-5"),
> +	F7188X_GPIO_BANK(8, 0x90, DRVNAME "-6"),
> +	F7188X_GPIO_BANK(8, 0x80, DRVNAME "-7"),
>  };
> =20
>  static struct f7188x_gpio_bank f81866_gpio_bank[] =3D {
> -	F7188X_GPIO_BANK(0, 8, 0xF0, DRVNAME "-0"),
> -	F7188X_GPIO_BANK(10, 8, 0xE0, DRVNAME "-1"),
> -	F7188X_GPIO_BANK(20, 8, 0xD0, DRVNAME "-2"),
> -	F7188X_GPIO_BANK(30, 8, 0xC0, DRVNAME "-3"),
> -	F7188X_GPIO_BANK(40, 8, 0xB0, DRVNAME "-4"),
> -	F7188X_GPIO_BANK(50, 8, 0xA0, DRVNAME "-5"),
> -	F7188X_GPIO_BANK(60, 8, 0x90, DRVNAME "-6"),
> -	F7188X_GPIO_BANK(70, 8, 0x80, DRVNAME "-7"),
> -	F7188X_GPIO_BANK(80, 8, 0x88, DRVNAME "-8"),
> +	F7188X_GPIO_BANK(8, 0xF0, DRVNAME "-0"),
> +	F7188X_GPIO_BANK(8, 0xE0, DRVNAME "-1"),
> +	F7188X_GPIO_BANK(8, 0xD0, DRVNAME "-2"),
> +	F7188X_GPIO_BANK(8, 0xC0, DRVNAME "-3"),
> +	F7188X_GPIO_BANK(8, 0xB0, DRVNAME "-4"),
> +	F7188X_GPIO_BANK(8, 0xA0, DRVNAME "-5"),
> +	F7188X_GPIO_BANK(8, 0x90, DRVNAME "-6"),
> +	F7188X_GPIO_BANK(8, 0x80, DRVNAME "-7"),
> +	F7188X_GPIO_BANK(8, 0x88, DRVNAME "-8"),
>  };
> =20
> =20
>  static struct f7188x_gpio_bank f81804_gpio_bank[] =3D {
> -	F7188X_GPIO_BANK(0, 8, 0xF0, DRVNAME "-0"),
> -	F7188X_GPIO_BANK(10, 8, 0xE0, DRVNAME "-1"),
> -	F7188X_GPIO_BANK(20, 8, 0xD0, DRVNAME "-2"),
> -	F7188X_GPIO_BANK(50, 8, 0xA0, DRVNAME "-3"),
> -	F7188X_GPIO_BANK(60, 8, 0x90, DRVNAME "-4"),
> -	F7188X_GPIO_BANK(70, 8, 0x80, DRVNAME "-5"),
> -	F7188X_GPIO_BANK(90, 8, 0x98, DRVNAME "-6"),
> +	F7188X_GPIO_BANK(8, 0xF0, DRVNAME "-0"),
> +	F7188X_GPIO_BANK(8, 0xE0, DRVNAME "-1"),
> +	F7188X_GPIO_BANK(8, 0xD0, DRVNAME "-2"),
> +	F7188X_GPIO_BANK(8, 0xA0, DRVNAME "-3"),
> +	F7188X_GPIO_BANK(8, 0x90, DRVNAME "-4"),
> +	F7188X_GPIO_BANK(8, 0x80, DRVNAME "-5"),
> +	F7188X_GPIO_BANK(8, 0x98, DRVNAME "-6"),
>  };
> =20
>  static struct f7188x_gpio_bank f81865_gpio_bank[] =3D {
> -	F7188X_GPIO_BANK(0, 8, 0xF0, DRVNAME "-0"),
> -	F7188X_GPIO_BANK(10, 8, 0xE0, DRVNAME "-1"),
> -	F7188X_GPIO_BANK(20, 8, 0xD0, DRVNAME "-2"),
> -	F7188X_GPIO_BANK(30, 8, 0xC0, DRVNAME "-3"),
> -	F7188X_GPIO_BANK(40, 8, 0xB0, DRVNAME "-4"),
> -	F7188X_GPIO_BANK(50, 8, 0xA0, DRVNAME "-5"),
> -	F7188X_GPIO_BANK(60, 5, 0x90, DRVNAME "-6"),
> +	F7188X_GPIO_BANK(8, 0xF0, DRVNAME "-0"),
> +	F7188X_GPIO_BANK(8, 0xE0, DRVNAME "-1"),
> +	F7188X_GPIO_BANK(8, 0xD0, DRVNAME "-2"),
> +	F7188X_GPIO_BANK(8, 0xC0, DRVNAME "-3"),
> +	F7188X_GPIO_BANK(8, 0xB0, DRVNAME "-4"),
> +	F7188X_GPIO_BANK(8, 0xA0, DRVNAME "-5"),
> +	F7188X_GPIO_BANK(5, 0x90, DRVNAME "-6"),
>  };
> =20
>  static struct f7188x_gpio_bank nct6126d_gpio_bank[] =3D {
> -	F7188X_GPIO_BANK(0, 8, 0xE0, DRVNAME "-0"),
> -	F7188X_GPIO_BANK(10, 8, 0xE4, DRVNAME "-1"),
> -	F7188X_GPIO_BANK(20, 8, 0xE8, DRVNAME "-2"),
> -	F7188X_GPIO_BANK(30, 8, 0xEC, DRVNAME "-3"),
> -	F7188X_GPIO_BANK(40, 8, 0xF0, DRVNAME "-4"),
> -	F7188X_GPIO_BANK(50, 8, 0xF4, DRVNAME "-5"),
> -	F7188X_GPIO_BANK(60, 8, 0xF8, DRVNAME "-6"),
> -	F7188X_GPIO_BANK(70, 8, 0xFC, DRVNAME "-7"),
> +	F7188X_GPIO_BANK(8, 0xE0, DRVNAME "-0"),
> +	F7188X_GPIO_BANK(8, 0xE4, DRVNAME "-1"),
> +	F7188X_GPIO_BANK(8, 0xE8, DRVNAME "-2"),
> +	F7188X_GPIO_BANK(8, 0xEC, DRVNAME "-3"),
> +	F7188X_GPIO_BANK(8, 0xF0, DRVNAME "-4"),
> +	F7188X_GPIO_BANK(8, 0xF4, DRVNAME "-5"),
> +	F7188X_GPIO_BANK(8, 0xF8, DRVNAME "-6"),
> +	F7188X_GPIO_BANK(8, 0xFC, DRVNAME "-7"),
>  };
> =20
>  static int f7188x_gpio_get_direction(struct gpio_chip *chip, unsigned of=
fset)
> --=20
> 2.25.1

--Pn04Kz12XNGOy554
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEXW8DgovlR3VS5hA0zyg/RDPmszoFAmR0mfIACgkQzyg/RDPm
szqPNQ/+ORnhQrZozv4ND0hqfV87L0W4KgqAuS1bvuJrNCTYx6D6XEMLzbn1q9Cj
rOduiE79E5TZ9RtJVgn7pxEwBecjieNquhm5GptZ+vdUu7Uz3aR3VTOeE/TQjlJE
gfEHYzBp5xS7fo6TbVXLoyTP1KlC/P1xk10XxAkuTJafchpuYLKCa8iowB6Xl3SU
3dsXlEcleJbrw3LBfiBr2ayIc76G1k7XSMwi3KTUl6UYIhjuLbdKf8nQ9xOW5vy7
gn/hKMnCSVwqTfzKM3rNHSZ0dlniu05NDMD4udXzCY+rChu/Gd+u3l0yUFginZ4n
2R6pFu/ZzYGIMz2YMeML9oWLe3KVMBGiwYoL6qX/urDjFTx1kqX6mJcrU4cmyy1t
zRt99kabOaPgoZsvPN26bnqHzW1z7xAp3+PlDak48V9LRhZGOQ3dIq1XdUULU2yq
QZDb9ev4CDiAO0pER3ven/VyXPVd9UDjRVrE2n4xAHa0SRayhOq7MgUFd/FNBJ9N
FCVMcsXf/QPOQfxhUgwieSJ4v3Sz5yCo1MsUJa8auB1JY6RFYOV5V1kNLaV537LO
hnlc/Gz4WSjFpG8oDHIJvZC8Wf52/L5kvELglnGVeZIpd0quIuCR1+6riVSE9Q85
2ypT2hPis9kKSzl0EXRiAhq5fswRuwbjwV5UTJfwpATD5ZdaqO8=
=OaOH
-----END PGP SIGNATURE-----

--Pn04Kz12XNGOy554--
