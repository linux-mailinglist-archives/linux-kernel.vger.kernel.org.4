Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0820A5BDCF5
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 08:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbiITGOz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 02:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbiITGOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 02:14:52 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2E2513DE0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 23:14:48 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oaWWm-00024b-80; Tue, 20 Sep 2022 08:14:40 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oaWWm-001o7S-1M; Tue, 20 Sep 2022 08:14:38 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oaWWj-0028m5-Op; Tue, 20 Sep 2022 08:14:37 +0200
Date:   Tue, 20 Sep 2022 08:14:34 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Olof Johansson <olof@lixom.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Subject: Re: [PATCH] serial: sifive: enable clocks for UART when probed
Message-ID: <20220920061434.ettul5ae2bw6mxme@pengutronix.de>
References: <20220919223915.5146-1-olof@lixom.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="esuswvtwlxfa63tf"
Content-Disposition: inline
In-Reply-To: <20220919223915.5146-1-olof@lixom.net>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--esuswvtwlxfa63tf
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Mon, Sep 19, 2022 at 03:39:15PM -0700, Olof Johansson wrote:
> When the PWM driver was changed to disable clocks if no PWMs are enabled,
> it ended up also disabling the shared parent with the UART, since the
> UART doesn't do any clock enablement on its own.
>=20
> To avoid these surprises, add clk_prepare_enable/clk_disable_unprepare
> calls.
>=20
> Fixes: ace41d7564e655 ("pwm: sifive: Ensure the clk is enabled exactly on=
ce per running PWM")
> Cc: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> Cc: Emil Renner Berthing <emil.renner.berthing@canonical.com>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Paul Walmsley <paul.walmsley@sifive.com>
> Signed-off-by: Olof Johansson <olof@lixom.net>
> ---
>  drivers/tty/serial/sifive.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/tty/serial/sifive.c b/drivers/tty/serial/sifive.c
> index 5c3a07546a58..751f98068806 100644
> --- a/drivers/tty/serial/sifive.c
> +++ b/drivers/tty/serial/sifive.c
> @@ -950,23 +950,28 @@ static int sifive_serial_probe(struct platform_devi=
ce *pdev)
>  		dev_err(&pdev->dev, "unable to find controller clock\n");
>  		return PTR_ERR(clk);
>  	}
> +	clk_prepare_enable(clk);

The return code of clk_prepare_enable() must be checked. Also there is a
simpler patch to fix that problem. I didn't test but I expect just doing=20

diff --git a/drivers/tty/serial/sifive.c b/drivers/tty/serial/sifive.c
index 5c3a07546a58..4b1d4fe8458e 100644
--- a/drivers/tty/serial/sifive.c
+++ b/drivers/tty/serial/sifive.c
@@ -945,7 +945,7 @@ static int sifive_serial_probe(struct platform_device *=
pdev)
 		return PTR_ERR(base);
 	}
=20
-	clk =3D devm_clk_get(&pdev->dev, NULL);
+	clk =3D devm_clk_get_enabled(&pdev->dev, NULL);
 	if (IS_ERR(clk)) {
 		dev_err(&pdev->dev, "unable to find controller clock\n");
 		return PTR_ERR(clk);

would be enough and also cares for disabling the clock on remove.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--esuswvtwlxfa63tf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmMpWkYACgkQwfwUeK3K
7AnywQf7BdspOW1w2yf0sn2zzN7vZ8uTyeaUdaeAPp30OHYQrYxG8NItdzcFeAjQ
SgP7GV52s0NzSYLquIRHJ60xVOfS15fnJaJkzHu9P0Bq9I3dRqVE1KmB7+VNF0jh
eMfr+DyWJan6s2EjS3U1AwnDP5lkZz+S81RSxgEnlGSxoFnuIYS5lrQeLNBWx3dv
1vGSPC2qKbHBNuAAMCSFoJvvG0fljA5iUcXolnmL0bWsoywEY5tq0PpfVRLvQltx
gDqi7XshrO5YjTux/MMEWHLnLD+LtpCt+lerGnVkw1t5rNdBIvP/b5UqSUmlCWPg
7EkuwFzXLwZiUTyZfYqlIeTkxGc+mw==
=1mpl
-----END PGP SIGNATURE-----

--esuswvtwlxfa63tf--
