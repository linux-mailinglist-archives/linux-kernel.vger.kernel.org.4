Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB906685A2
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 22:39:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232743AbjALVjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 16:39:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240608AbjALVhj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 16:37:39 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D03251096
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 13:30:26 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pG59N-0002VT-Mb; Thu, 12 Jan 2023 22:30:17 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pG59M-005coA-LE; Thu, 12 Jan 2023 22:30:16 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pG59M-00CN00-0U; Thu, 12 Jan 2023 22:30:16 +0100
Date:   Thu, 12 Jan 2023 22:30:15 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Mubin Sayyed <mubin.sayyed@amd.com>
Cc:     robh+dt@kernel.org, treding@nvidia.com, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, git@amd.com, michal.simek@amd.com,
        siva.durga.prasad.paladugu@amd.com, mubin10@gmail.com
Subject: Re: [LINUX PATCH 1/3] clocksource: timer-cadence-ttc: Do not probe
 TTC device configured as PWM
Message-ID: <20230112213015.sw5uxirsrltx3pih@pengutronix.de>
References: <20230112071526.3035949-1-mubin.sayyed@amd.com>
 <20230112071526.3035949-2-mubin.sayyed@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7qvaaxqaocpm7pj5"
Content-Disposition: inline
In-Reply-To: <20230112071526.3035949-2-mubin.sayyed@amd.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7qvaaxqaocpm7pj5
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 12, 2023 at 12:45:24PM +0530, Mubin Sayyed wrote:
> TTC device can act either as clocksource/clockevent or
> PWM generator, it would be decided by pwm-cells property.
> TTC PWM feature would be supported through separate driver
> based on PWM framework.
>=20
> If pwm-cells property is present in TTC node, it would be
> treated as PWM device, and clocksource driver should just
> skip it.
>=20
> Signed-off-by: Mubin Sayyed <mubin.sayyed@amd.com>
> ---
>  drivers/clocksource/timer-cadence-ttc.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/clocksource/timer-cadence-ttc.c b/drivers/clocksourc=
e/timer-cadence-ttc.c
> index 4efd0cf3b602..ba46649148b1 100644
> --- a/drivers/clocksource/timer-cadence-ttc.c
> +++ b/drivers/clocksource/timer-cadence-ttc.c
> @@ -476,6 +476,9 @@ static int __init ttc_timer_probe(struct platform_dev=
ice *pdev)
>  	u32 timer_width =3D 16;
>  	struct device_node *timer =3D pdev->dev.of_node;
> =20
While it's more obvious here than in the PWM driver, a comment here
would be good, too.

> +	if (of_property_read_bool(timer, "#pwm-cells"))
> +		return -ENODEV;
> +
>  	if (initialized)
>  		return 0;
> =20
> --=20
> 2.25.1
>=20
>=20

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--7qvaaxqaocpm7pj5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmPAe+QACgkQwfwUeK3K
7AkUDgf+KIetGF0gWW6g8OkoyM38lCShOVsRVSiy1HszSnswoz5btFRoyngs9aMs
5GH9zt8BePcWiCzgm4uF2GWrz7221Us2orfw+FUf+44Dd5PvHFisuFT4l8rcxgui
Q79H9PmsAigq5fH+fq8sVNLKGQqNbm4B5QfDBUDFknR5VU30PZwUMW0XgQ3zkcr6
K6EoWKslmdEaHP7b5nBHRBeZll0PXnGnMwEaYgqcpLVnXl6uODCmVRi2RKLR0xAC
boUHFwuHy8qxAw+eJYhkN6j/fJ8rSDfoa/TeO9mfAibdDIZeef+j8J6UipWSqO2F
6vu68mcg2tSe56AlF7ITbg0uX8Qp3A==
=e7Bd
-----END PGP SIGNATURE-----

--7qvaaxqaocpm7pj5--
