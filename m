Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12D836C7117
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 20:35:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231513AbjCWTfJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 15:35:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbjCWTfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 15:35:06 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BA30196A5;
        Thu, 23 Mar 2023 12:35:04 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 199381C0E45; Thu, 23 Mar 2023 20:35:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1679600103;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Eiy0jwgBZdGjvoP8ZBOj+/dd3JzAbNmzrXq0dSQ7n8w=;
        b=c8OPTMYUMCLJcawejU9Rr358ez2GlkVrxmYQacvsZxRQo1lwcQkMrKXgXf4h0dABa3NPsB
        chXF62rUUL1qQm3gdyt5699RrEdtvi2pG5fTGNjWdekSi96MY9063z39VO6l6ujsRicU0M
        qCw5r1gbTOKdHXwTi2YqIrWpikWl334=
Date:   Thu, 23 Mar 2023 20:35:02 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     "Lin, Meng-Bo" <linmengbo0689@protonmail.com>
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nikita Travkin <nikita@trvn.ru>,
        Stephan Gerhold <stephan@gerhold.net>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v2 2/2] leds: aw2013: Add vddio regulator
Message-ID: <ZByp5gzspOVcYyah@duo.ucw.cz>
References: <20230320174949.174600-1-linmengbo0689@protonmail.com>
 <20230320175150.174711-1-linmengbo0689@protonmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="59RaXGfovOuoCF5q"
Content-Disposition: inline
In-Reply-To: <20230320175150.174711-1-linmengbo0689@protonmail.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--59RaXGfovOuoCF5q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Some LEDs controllers are used with external pull-up for the interrupt
> line and the I2C lines, so we might need to enable a regulator to bring
> the lines into usable state. Otherwise, this might cause spurious
> interrupts and reading from I2C will fail.
>=20
> Implement support for "vddio-supply" that is enabled by the aw2013 driver
> so that the regulator gets enabled when needed.
>=20
> Signed-off-by: Lin, Meng-Bo <linmengbo0689@protonmail.com>

> @@ -348,16 +350,20 @@ static int aw2013_probe(struct i2c_client *client)
>  		goto error;
>  	}
> =20
> -	chip->vcc_regulator =3D devm_regulator_get(&client->dev, "vcc");
> -	ret =3D PTR_ERR_OR_ZERO(chip->vcc_regulator);
> -	if (ret) {
> +	chip->regulators[0].supply =3D "vcc";
> +	chip->regulators[1].supply =3D "vddio";
> +	ret =3D devm_regulator_bulk_get(&client->dev,
> +				      ARRAY_SIZE(chip->regulators),
> +				      chip->regulators);
> +	if (ret < 0) {
>  		if (ret !=3D -EPROBE_DEFER)
>  			dev_err(&client->dev,
>  				"Failed to request regulator: %d\n", ret);
>  		goto error;

Won't this cause failures when optional vddio is unavailable?

BR,
							Pavel
						=09
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--59RaXGfovOuoCF5q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZByp5gAKCRAw5/Bqldv6
8hkzAJ95xl/kGY8uKTWuWX12QJuhBM2uMQCgg21hmFNALojBHzMSFd7aDS+yVfQ=
=646S
-----END PGP SIGNATURE-----

--59RaXGfovOuoCF5q--
