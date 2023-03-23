Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C18A46C6704
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 12:44:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231636AbjCWLox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 07:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231737AbjCWLou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 07:44:50 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F4671E1FD;
        Thu, 23 Mar 2023 04:44:49 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 2F6131C0E45; Thu, 23 Mar 2023 12:44:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1679571888;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jM80YHQk+qoBrXoBprRCKbkOWR0yfY0BoZNY2Boncck=;
        b=JuTJYK7ERVTE04fpshRfi0SwXMWsa9etje6gBE7wYA1wBW3X18shPj1h8ZgmwdSUwb2Ccl
        XG7y+0JIVCR7BFHeYt5/OHKlWJf7cU1ahbXqcGabybCigYBiQWmEysaDxlHT0MyP2eN+gE
        TFG7pWYp6EqsN7ExqMsfye0uBUV7WCY=
Date:   Thu, 23 Mar 2023 12:44:47 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     Lee Jones <lee@kernel.org>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
Subject: Re: [PATCH 2/2] leds: max597x: Add support for max597x
Message-ID: <ZBw7r12Yq0YMik78@duo.ucw.cz>
References: <20230322124316.2147143-1-Naresh.Solanki@9elements.com>
 <20230322124316.2147143-2-Naresh.Solanki@9elements.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="5c3HESuQ55FnAAW1"
Content-Disposition: inline
In-Reply-To: <20230322124316.2147143-2-Naresh.Solanki@9elements.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5c3HESuQ55FnAAW1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2023-03-22 13:43:16, Naresh Solanki wrote:
> From: Patrick Rudolph <patrick.rudolph@9elements.com>
>=20
> max597x is hot swap controller with indication led support.

"indicator LED"?

> This driver uses DT property to configure led during boot time &
> also provide the led control in sysfs.

LED.

> +++ b/drivers/leds/Kconfig
> @@ -590,6 +590,17 @@ config LEDS_ADP5520
>  	  To compile this driver as a module, choose M here: the module will
>  	  be called leds-adp5520.
> =20
> +config LEDS_MAX597X
> +	tristate "LED Support for Maxim 597x"
> +	depends on LEDS_CLASS
> +	depends on MFD_MAX597X
> +	help
> +	  This option enables support for the Maxim 597x smart switch indicatio=
n LEDs
> +	   via the I2C bus.

Strange whitespace.

> --- /dev/null
> +++ b/drivers/leds/leds-max597x.c
> @@ -0,0 +1,132 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Device driver for regulators in MAX5970 and MAX5978 IC

Regulators go elsewhere.

> +static int max597x_led_set_brightness(struct led_classdev *cdev,
> +				      enum led_brightness brightness)
> +{
> +	struct max597x_led *led =3D ldev_to_maxled(cdev);
> +	int ret;
> +
> +	if (!led || !led->regmap)
> +		return -ENODEV;
> +
> +	ret =3D regmap_update_bits(led->regmap, MAX5970_REG_LED_FLASH,
> +				 1 << led->index, ~brightness << led->index);

~brightness << led->index is quite confusing. Can we get something
else?

> +	led =3D devm_kzalloc(dev, sizeof(struct max597x_led),
> +			   GFP_KERNEL);
> +	if (!led)
> +		return -ENOMEM;
> +
> +	if (of_property_read_string(nc, "label", &led->led.name))
> +		led->led.name =3D nc->name;
> +
> +	led->led.max_brightness =3D 1;
> +	led->led.brightness_set_blocking =3D max597x_led_set_brightness;
> +	led->led.default_trigger =3D "none";
> +	led->index =3D reg;
> +	led->regmap =3D regmap;
> +	ret =3D led_classdev_register(dev, &led->led);
> +	if (ret) {
> +		dev_err(dev, "Error in initializing led %s", led->led.name);
> +		devm_kfree(dev, led);
> +		return ret;
> +	}

You don't need to do the kfree.

> +	if (!of_property_read_string(nc, "default-state", &state)) {
> +		if (!strcmp(state, "on")) {
> +			led->led.brightness =3D 1;
> +			led_set_brightness(&led->led, led->led.brightness);
> +		}
> +	}

Lets get rid of this unless you really need it.

BR,
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--5c3HESuQ55FnAAW1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZBw7rwAKCRAw5/Bqldv6
8uKAAJ9rkKpfkwMFrozN029Qku+1jJRGBgCgnJu0RxOYebZ3Nm+Iwmdw69MMC+A=
=bL1Z
-----END PGP SIGNATURE-----

--5c3HESuQ55FnAAW1--
