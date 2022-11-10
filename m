Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9894A62431C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 14:22:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbiKJNWr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 08:22:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbiKJNWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 08:22:45 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF1EA716CE;
        Thu, 10 Nov 2022 05:22:44 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id bj12so4825132ejb.13;
        Thu, 10 Nov 2022 05:22:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/18V6DEHc1m62ka1bnYxz/SFLrQNISW3e95B0eVyUzc=;
        b=L7BV7JuQOOcc6F2Jv0F5cWFQAlELaRgYGhpBgtfTvasDVYxIOCNO5h9Ysl47KyiD9r
         aiVduYnZNtbHj9Aq6azLNlzsn18S521/vo/saE9Alqw/C4hswJpsY0rNpbfIIlcc1LbR
         P2XGizUWbJfSXl31R4AvjZpK1F4AC+gtZ5SqpPE9XOiymYQtI8/KPc0j6yOcy/2+VTWO
         BUQYO/okF3TWY5nJ2AyBrM0pWejZcb3oTn3xrEexlRH4Y7LpKoORzywudE9VIlDBGY1y
         UIIaYgaLH/je/46GlgSdZ32JsvwU+WihVzBikJ8zdQzJ/tGnzHGjJC41dHbFLk6qhEli
         Ra7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/18V6DEHc1m62ka1bnYxz/SFLrQNISW3e95B0eVyUzc=;
        b=pIunYZwsbltKjFT18O5ZrzdUqWAahPUJm+NpsGGxmihIfvp6Z5c+xPj1jQEloQfJjn
         TBtV2KokQ8Taxcbtws6iAXUigkkt++7oSM4+7bWNyJj1LpolPkrcOUCmp1RKwZxi+rJc
         BNpVak8yklLWVwIwQC2HIQ+vP2hUe14qXwnesNgDthPf4omN6syar2kcpsWSHbsNW3ZF
         VkLWyCXH4bJpAvgu8Qi6MoGHbzMOZ5RIdnaKleJgQQXGIP2veSSZg+zAwuBQmJEo0LCE
         Lza4xOhqQg5uIzRlW7rGpzrMERS8ASWGIlj/qsJUZblJ5rHvq9SGGHqrwsTseix1YeSs
         t01g==
X-Gm-Message-State: ACrzQf0qxlj30GfPl0JlujpuvhTX5/HJpdMqmwpxGO2yxszEPNE33jRr
        DYOOR9TfA8saaLqY+h/x/fg=
X-Google-Smtp-Source: AMsMyM5u23u12SbRkdxyRIp1Xi4Wx+0pjLHXzzVURVBGzc+IWlAkTg5/ZsKut6rsISsUJqcy7GjegA==
X-Received: by 2002:a17:906:444d:b0:7ad:eb7f:8697 with SMTP id i13-20020a170906444d00b007adeb7f8697mr41939612ejp.770.1668086563245;
        Thu, 10 Nov 2022 05:22:43 -0800 (PST)
Received: from orome (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id f19-20020a1709064dd300b0077a1dd3e7b7sm7214132ejw.102.2022.11.10.05.22.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 05:22:42 -0800 (PST)
Date:   Thu, 10 Nov 2022 14:22:40 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 1/2] gpiolib: of: Prepare of_gpiochip_add() /
 of_gpiochip_remove() for fwnode
Message-ID: <Y2z7IJv2IQy+Mlsh@orome>
References: <20221108133853.61884-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="/mBCcUfC9k4UM3tz"
Content-Disposition: inline
In-Reply-To: <20221108133853.61884-1-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/mBCcUfC9k4UM3tz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 08, 2022 at 03:38:52PM +0200, Andy Shevchenko wrote:
> GPIO library is getting rid of of_node, fwnode should be utilized instead.
> Prepare of_gpiochip_add() / of_gpiochip_remove() for fwnode.
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
> v2: added tag (Dmitry)
>  drivers/gpio/gpiolib-of.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
> index be9c34cca322..000020eb78d8 100644
> --- a/drivers/gpio/gpiolib-of.c
> +++ b/drivers/gpio/gpiolib-of.c
> @@ -1104,9 +1104,11 @@ static int of_gpiochip_add_pin_range(struct gpio_c=
hip *chip) { return 0; }
> =20
>  int of_gpiochip_add(struct gpio_chip *chip)
>  {
> +	struct device_node *np;
>  	int ret;
> =20
> -	if (!chip->of_node)
> +	np =3D to_of_node(chip->fwnode);
> +	if (!np)

This breaks a number of GPIO controllers on Tegra where chip->fwnode
ends up never getting set. I also see this break drivers like the MFD-
based gpio-max77620, so I don't think this is anything specific to the
Tegra drivers.

Looking at how fwnode handling works, it seems like we're checking the
wrong value here, since chip->fwnode is only for explicit overrides of
the fwnode value.

The below patch fixes the regression for me:

--- >8 ---
diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index 4be3c21aa718..760f018ae7de 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -1067,7 +1067,7 @@ int of_gpiochip_add(struct gpio_chip *chip)
        struct device_node *np;
        int ret;

-       np =3D to_of_node(chip->fwnode);
+       np =3D to_of_node(chip->gpiodev->dev.fwnode);
        if (!np)
                return 0;

--- >8 ---

That uses the GPIO device's fwnode, which can be chip->fwnode if
chip->fwnode was explicitly specified. Otherwise this defaults to=20

See gpiochip_add_data_with_key() in drivers/gpio/gpiolib.c:

    677 |	/*
    678 |	 * Assign fwnode depending on the result of the previous calls,
    679 |	 * if none of them succeed, assign it to the parent's one.
    680 |	 */
    681 |	gdev->dev.fwnode =3D dev_fwnode(&gdev->dev) ?: fwnode;

Looks like this is only important to make sure gdev->dev.fwnode is valid
for OF, for ACPI this should be a no-op.

Thierry

--/mBCcUfC9k4UM3tz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmNs+x4ACgkQ3SOs138+
s6Fabw/9Ez3zRB8odDhkKTz+3aOmy7YcMqcp4oS2/TIuznqOTAEGk5yFId/rClH8
zrborlaubJde/K9j2v8CjfyMg9Ev4sJa5OehZoWx+rRV7dtTG4PBjsfzMOO6Q40n
308PRiQx5lTlJw4v6/qNb7TGDj4TxVf/EfP8YI/301Bmyc2NglRZsja9r//9ZnsW
Ka2NFY+utfgIKYnCsWoix0qc9Xn/Be0F94TpwKiKwCwnPSkgWIEisGPhlKNv0RVh
y7+DPV4KVlXJproeG8dH3g6R5zIEMJ87kI/AXKlKf6BV8IU6pjnYs8PjObClOHO+
g+yyPvUfq1S4vNRqW3GLb8nnYlEp6H/dIJmbxm0PxdzLzuYf+TSkBlAWQv8VgTRi
tvbIto4Q2pXjcnMvb7tYq/YFg0mo+Z/0dNMhyaUptjj+zFCpz73EvsLm6kQouIWG
A3SSWeCabkEHWQqSgkGSbtmWwjxFyhJ5DDZkjkVU0U2wXw4lbnyn5+Pwpu+UBO/4
4lJn3YglelJpYQKi4x9WS6ZFNte/u03Jk4hUP1JvE0M1T5g725lL4qyARa4CXCaY
1KfrXQhekbDwX29PmiztWAya5YkCIp6zIVnVuvZtU9FKtaI6TDCanX1csVx0HY5A
1DgF2X4xTxVRqMJyxpOAtu66saLz5X4LrFDOKlwMLTRcipp6W3A=
=Mxfw
-----END PGP SIGNATURE-----

--/mBCcUfC9k4UM3tz--
