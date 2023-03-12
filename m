Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9EEF6B6C04
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 23:36:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbjCLWgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 18:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbjCLWgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 18:36:14 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80D89132C0;
        Sun, 12 Mar 2023 15:36:13 -0700 (PDT)
Received: from mercury (unknown [185.254.75.29])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 479106602F13;
        Sun, 12 Mar 2023 22:36:12 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1678660572;
        bh=SJfzew+2aNS9FiIgtBkSq0NhB8lkWhj5GA46wF1nmm8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N59x72DP9HqD2W0GdgZTY4vqUlG4/JKai02N39lSD4QHHyBoXGr9RIVKk2hMorMwn
         d9GBeNPUeqOuVzxhWfjIzmRQDMtGO0nE/qOkP8d/XT7sD716x1nw1ksPbHqkyWpuaW
         AOfR9z8477Z7z4WXubmF5iLWwUOQQeRxxwJas36YItznPwqU3pnO6loPXBlAyfBy21
         BOnP22jwEn5jD9cbT+GA07GVMC4uSdbboP8Z4hgJVhc9RKhypmbAnm5YeXeRx/iuIb
         2m9udTzJz8bQzQM0sttQchSW7IMyAURcerMT2kl0SEaCti/CIsTXICRvqfuztHRdig
         nbhw+UD7XXKOg==
Received: by mercury (Postfix, from userid 1000)
        id D3E081060FD4; Sun, 12 Mar 2023 23:36:09 +0100 (CET)
Date:   Sun, 12 Mar 2023 23:36:09 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: supply: charger-manager: Use
 of_property_read_bool() for boolean properties
Message-ID: <1fdf00a0-4830-465a-801c-147472fdcd22@mercury.local>
References: <20230310144735.1546888-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="esdwyao7whnqopbb"
Content-Disposition: inline
In-Reply-To: <20230310144735.1546888-1-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--esdwyao7whnqopbb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Mar 10, 2023 at 08:47:35AM -0600, Rob Herring wrote:
> It is preferred to use typed property access functions (i.e.
> of_property_read_<type> functions) rather than low-level
> of_get_property/of_find_property functions for reading properties.
> Convert reading boolean properties to to of_property_read_bool().
>=20
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/charger-manager.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/charger-manager.c b/drivers/power/suppl=
y/charger-manager.c
> index c9e8450c646f..5fa6ba7f41e1 100644
> --- a/drivers/power/supply/charger-manager.c
> +++ b/drivers/power/supply/charger-manager.c
> @@ -1331,7 +1331,7 @@ static struct charger_desc *of_cm_parse_desc(struct=
 device *dev)
>  	of_property_read_string(np, "cm-thermal-zone", &desc->thermal_zone);
> =20
>  	of_property_read_u32(np, "cm-battery-cold", &desc->temp_min);
> -	if (of_get_property(np, "cm-battery-cold-in-minus", NULL))
> +	if (of_property_read_bool(np, "cm-battery-cold-in-minus"))
>  		desc->temp_min *=3D -1;
>  	of_property_read_u32(np, "cm-battery-hot", &desc->temp_max);
>  	of_property_read_u32(np, "cm-battery-temp-diff", &desc->temp_diff);
> --=20
> 2.39.2
>=20

--esdwyao7whnqopbb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmQOU9kACgkQ2O7X88g7
+pqlDg//Z2CepETxVSTBcXjJs98lElws+51NmKJOfFNnoUvbIw/+lMANJ4AYp+32
yMlk+QIlgng9aRunNPYGXDAkjB3grwZ4sbw3DelADFpDrnz4Q9oPujJJTTbocxVe
Brxk5h0fnBcZevhz8cGP+/mX9iB04eXjLaPwaNsTIi3X0cfNTnZ9g0ghr5OZqMUB
I2QSleKatJRp4XuPzE1sKE+ZJN9IFuD7A0twngv4MOwhbh6ysQYc+PTam1l0Up0J
UcMB/s5NIb/xEbeP96ESsQ4QLXfCtYRMxITVzpMTn0BacuX6fjNOJhmeQCuehBtG
K62CbJjhGPMs1/CLyYw4WcJa+1o0lwr1UA/i0wjBAkSgrkEbWMSrNZYpjWLpRO6y
EjdZwMxMSbWy6GWTjl6FkNnmX+R47MNZflwOFVXkNbbnDsu//xhU63gbavdzM86K
1PaZSIBP8keA+LQwySnLiJuqy/LO6G7HztuaBqvlh/DH/3hIPliEbA8knJFPNMRI
JvCQYX3rb3/V1/g+//nZruUlolQ1zcIVxLzXFMaFWgi6vRp/UhgE8saAu29CdeMA
2q9JAZx8md0+G7UG02qUUZtExeFr06uF9TJ5MWk+hBueI8MrQ+S815WSBd5I8a3F
kQEbjZ2WWk+vHnY9DK09mjpXg39dSsd//pjHv/Gpt68TuVtHk+Q=
=Vnoq
-----END PGP SIGNATURE-----

--esdwyao7whnqopbb--
