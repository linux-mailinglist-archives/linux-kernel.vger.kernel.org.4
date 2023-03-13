Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C32066B72EC
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 10:43:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbjCMJnz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 05:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbjCMJnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 05:43:53 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A6481E1D9
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 02:43:50 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pbeiZ-0001bb-NA; Mon, 13 Mar 2023 10:43:47 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pbeiX-003okP-IY; Mon, 13 Mar 2023 10:43:45 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pbeiW-004UsW-RW; Mon, 13 Mar 2023 10:43:44 +0100
Date:   Mon, 13 Mar 2023 10:43:44 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/5] clocksource: timer-stm32-lp: Mark driver as
 non-removable
Message-ID: <20230313094344.emv6pazrvberusil@pengutronix.de>
References: <20230313075430.2730803-1-u.kleine-koenig@pengutronix.de>
 <20230313075430.2730803-3-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rm7zyqg5zd7u5psn"
Content-Disposition: inline
In-Reply-To: <20230313075430.2730803-3-u.kleine-koenig@pengutronix.de>
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


--rm7zyqg5zd7u5psn
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Mon, Mar 13, 2023 at 08:54:27AM +0100, Uwe Kleine-K=F6nig wrote:
> The comment in the remove callback suggests that the driver is not
> supposed to be unbound. However returning an error code in the remove
> callback doesn't accomplish that. Instead set the suppress_bind_attrs
> property (which makes it impossible to unbind the driver via sysfs).
> The only remaining way to unbind an stm32-lp device would be module
> unloading, but that doesn't apply here, as the driver cannot be built as
> a module.
>=20
> Also drop the useless remove callback.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/clocksource/timer-stm32-lp.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
>=20
> diff --git a/drivers/clocksource/timer-stm32-lp.c b/drivers/clocksource/t=
imer-stm32-lp.c
> index db2841d0beb8..616ea4fe4234 100644
> --- a/drivers/clocksource/timer-stm32-lp.c
> +++ b/drivers/clocksource/timer-stm32-lp.c
> @@ -195,11 +195,6 @@ static int stm32_clkevent_lp_probe(struct platform_d=
evice *pdev)
>  	return ret;
>  }
> =20
> -static int stm32_clkevent_lp_remove(struct platform_device *pdev)
> -{
> -	return -EBUSY; /* cannot unregister clockevent */
> -}
> -
>  static const struct of_device_id stm32_clkevent_lp_of_match[] =3D {
>  	{ .compatible =3D "st,stm32-lptimer-timer", },
>  	{},
> @@ -207,11 +202,11 @@ static const struct of_device_id stm32_clkevent_lp_=
of_match[] =3D {
>  MODULE_DEVICE_TABLE(of, stm32_clkevent_lp_of_match);
> =20
>  static struct platform_driver stm32_clkevent_lp_driver =3D {
> -	.probe	=3D stm32_clkevent_lp_probe,
>  	.remove =3D stm32_clkevent_lp_remove,

This is of course broken, I intended to drop the remove line ... and
only noticed that breakage after sending out the patch set :-\

So please either skip this patch, or fixup while applying. If you do the
former I'll come back to this driver and send a fixed patch.

Best regards and sorry
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--rm7zyqg5zd7u5psn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmQO8E0ACgkQwfwUeK3K
7Ama0Af9EAieyD1ilr+oUAsZ/Eghf0bXKulJmBLB9iw5CfGxUqr9e6wgKKREjimg
HNzY5n//YrM0/VjyRSmSVmO5ZTs0MfuHPt7aj6S5bP/EPX8C7WmfJ6e7+KdJqJvN
Gqfy9pn5/yFprpiM7Uv1o7vxFIDTqLfWIf3s0tLwxEY7IE5TZcFewmF5Y70UhyyZ
sPC4zKtimQf2q4e6JiB8OwX8LICHALRsVAwrb4WN+CkM84TcMPihc0rB4XvJEgpJ
ZKIRG0Riq7fB1TYc5RA+K1dwdSPbEXy7oFHJ9YaHg7fnU6g8OII42DoVxUI3Oyht
HGZ8yjATI4rGmdPfj79+s3n7B6g0fQ==
=51x9
-----END PGP SIGNATURE-----

--rm7zyqg5zd7u5psn--
