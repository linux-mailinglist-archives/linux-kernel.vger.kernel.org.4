Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4196C6E0C36
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 13:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbjDMLNr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 07:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbjDMLNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 07:13:43 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3FCA59F0;
        Thu, 13 Apr 2023 04:13:41 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id C9B481C0AB2; Thu, 13 Apr 2023 13:13:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1681384420;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vCIpjfZvvQlTpSXYXfukLmY/Y9Ggejc/B41Mf02Snis=;
        b=UE2bT/m3hT8caCNL2ta5mkB7uUvRCDxk2U3/QMnUT3K1DnW+JG2gj+UXbCTdslvyMdh9pj
        lDhqAC24uoT+Qgcmf5qB84hNsHYmtgpZhRcrhZ6eD6XewRQosb6mB9Mk7xmcr+6gyx6P8L
        hVdkrFn6Gl1p9PHXByKDzUHlpjjbQ7U=
Date:   Thu, 13 Apr 2023 13:13:40 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     Lee Jones <lee@kernel.org>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
Subject: Re: [PATCH v4] leds: max597x: Add support for max597x
Message-ID: <ZDfj5I3l4O1FkiW3@duo.ucw.cz>
References: <20230413102624.3561299-1-Naresh.Solanki@9elements.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="sSZQJFNp+45xoekT"
Content-Disposition: inline
In-Reply-To: <20230413102624.3561299-1-Naresh.Solanki@9elements.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sSZQJFNp+45xoekT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Patrick Rudolph <patrick.rudolph@9elements.com>
>=20
> max597x is hot swap controller with indicator LED support.
> This driver uses DT property to configure led during boot time &
> also provide the LED control in sysfs.
>=20
> DTS example:
>     i2c {
>         #address-cells =3D <1>;
>         #size-cells =3D <0>;
>         regulator@3a {
>             compatible =3D "maxim,max5978";
>             reg =3D <0x3a>;
>             vss1-supply =3D <&p3v3>;
>=20
>             regulators {
>                 sw0_ref_0: sw0 {
>                     shunt-resistor-micro-ohms =3D <12000>;
>                 };
>             };
>=20
>             leds {
>                 #address-cells =3D <1>;
>                 #size-cells =3D <0>;
>                 led@0 {
>                     reg =3D <0>;
>                     label =3D "led0";
>                     default-state =3D "on";
>                 };
>                 led@1 {
>                     reg =3D <1>;
>                     label =3D "led1";
>                     default-state =3D "on";
>                 };
>             };
>         };
>     };
>

Yeah, well, dts bindings need to be properly documented, and example
goes to the binding, right?

Plus, we should have better names than led0/led1. Something like
hdd0:green:something, based on what the LED does and what are you hot
swapping. See/modify Documentation/leds/well-known-leds.txt .


> +static int max597x_led_set_brightness(struct led_classdev *cdev,
> +				      enum led_brightness brightness)
> +{
> +	struct max597x_led *ddata =3D ldev_to_maxled(cdev);
> +	int ret, val;
> +
> +	if (!ddata->regmap)
> +		return -ENODEV;
> +
> +	/* Set/Clear corresponding bit for given led index */

"/clear".

> +	val =3D !brightness ? BIT(ddata->index) : 0;
> +	ret =3D regmap_update_bits(ddata->regmap, MAX5970_REG_LED_FLASH, BIT(dd=
ata->index), val);
> +	if (ret < 0)
> +		dev_err(cdev->dev, "failed to set brightness %d", ret);

'\n"'.

> +	ddata->cdev.brightness_set_blocking =3D max597x_led_set_brightness;
> +	ddata->cdev.default_trigger =3D "none";

So what do these leds normally do? Should they be registered with
common function to handle default triggers etc?

> +	ddata->index =3D reg;
> +	ddata->regmap =3D regmap;
> +	ret =3D devm_led_classdev_register(dev, &ddata->cdev);
> +	if (ret)
> +		dev_err(dev, "Error initializing LED %s", ddata->cdev.name);

'\n"'.

> +module_platform_driver(max597x_led_driver);
> +MODULE_AUTHOR("Patrick Rudolph <patrick.rudolph@9elements.com>");
> +MODULE_DESCRIPTION("MAX5970_hot-swap controller LED driver");

"MAX5970 hot-swap"?

> +MODULE_LICENSE("GPL");
>=20
> base-commit: 11e572d06c23d61683e20a98bd16f550ef17ac65
> prerequisite-patch-id: 456044abe991b2ff3b521d337825432789d71b29

?? Send prerequisites in the series?

BR,
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--sSZQJFNp+45xoekT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZDfj5AAKCRAw5/Bqldv6
8kTGAJ0cmC74jNxVMx/HIsoOrBJ0fYa7YACgtuilPkn5Bng+sZqy1AOoczAtaW0=
=IFx5
-----END PGP SIGNATURE-----

--sSZQJFNp+45xoekT--
