Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0180750418
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 12:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232310AbjGLKFw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 06:05:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231969AbjGLKFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 06:05:45 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A09C10FA
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 03:05:43 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qJWix-0007B6-E8; Wed, 12 Jul 2023 12:05:31 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qJWiu-00DrBe-B9; Wed, 12 Jul 2023 12:05:28 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qJWit-004Gd7-DD; Wed, 12 Jul 2023 12:05:27 +0200
Date:   Wed, 12 Jul 2023 12:05:27 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     Guillaume La Roque <glaroque@baylibre.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/27] thermal/drivers/amlogic: Convert to platform
 remove callback returning void
Message-ID: <20230712100527.33gei4nyfvejhy2q@pengutronix.de>
References: <20230712081258.29254-1-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="st54h4lvkk4iirjp"
Content-Disposition: inline
In-Reply-To: <20230712081258.29254-1-frank.li@vivo.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--st54h4lvkk4iirjp
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 12, 2023 at 04:12:32PM +0800, Yangtao Li wrote:
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is (mostly) ignored
> and this typically results in resource leaks. To improve here there is a
> quest to make the remove callback return void. In the first step of this
> quest all drivers are converted to .remove_new() which already returns
> void.
>=20
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
>=20
> Cc: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>  drivers/thermal/amlogic_thermal.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/thermal/amlogic_thermal.c b/drivers/thermal/amlogic_=
thermal.c
> index 756b218880a7..a95c8959e5af 100644
> --- a/drivers/thermal/amlogic_thermal.c
> +++ b/drivers/thermal/amlogic_thermal.c
> @@ -293,11 +293,11 @@ static int amlogic_thermal_probe(struct platform_de=
vice *pdev)
>  	return ret;
>  }
> =20
> -static int amlogic_thermal_remove(struct platform_device *pdev)
> +static void amlogic_thermal_remove(struct platform_device *pdev)
>  {
>  	struct amlogic_thermal *data =3D platform_get_drvdata(pdev);
> =20
> -	return amlogic_thermal_disable(data);
> +	amlogic_thermal_disable(data);

I'd make amlogic_thermal_disable() return void, too.

Otherwise looks ok.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--st54h4lvkk4iirjp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmSueuYACgkQj4D7WH0S
/k6IaAf/Tc1hMZUjWFoPJ7YHR9dJiBEfDNwycNw/iawByqBJErgwBllns9wyhBHd
Wiu2QAHKEZeJSvbwP0g8gAeKMLk3WKaooWUBGtcJiMG29HfcO/INO1BG+g08xJrB
615/bLjUCoamEQeuJqBa7Fs06D1FOqDw4SZ9p0HUtIar2m6Ws3C6/0EJvbwFOguK
UfsG8QnTXtjerJwHyBYViU9h3S41acOY2mpNXzgVwjk5xMwaUD2vdPQPklxBXuLN
rhc7DG7PgJ8nKfTBw6xKmPv9d/Bnke6YuUnd4U2fAoWscznbEmRUl3EcFKhQA8vu
qxycJcrx1/j2Gsv0fAkDaXP1lR9xdQ==
=EaAv
-----END PGP SIGNATURE-----

--st54h4lvkk4iirjp--
