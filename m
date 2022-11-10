Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 175476244DD
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 15:53:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbiKJOxg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 09:53:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbiKJOxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 09:53:32 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5559B388
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 06:53:25 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ot8vh-0004vD-Ta; Thu, 10 Nov 2022 15:53:21 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ot8vg-003TLt-58; Thu, 10 Nov 2022 15:53:21 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ot8vg-00Ff2J-Dr; Thu, 10 Nov 2022 15:53:20 +0100
Date:   Thu, 10 Nov 2022 15:53:20 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Steven Price <steven.price@arm.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH] pwm: tegra: Fix 32 bit build
Message-ID: <20221110145320.fwrdsymdfpdjyyga@pengutronix.de>
References: <20221110114549.34121-1-steven.price@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jxpsqp66r5opvunj"
Content-Disposition: inline
In-Reply-To: <20221110114549.34121-1-steven.price@arm.com>
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


--jxpsqp66r5opvunj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Thu, Nov 10, 2022 at 11:45:48AM +0000, Steven Price wrote:
> The value of NSEC_PER_SEC << PWM_DUTY_WIDTH doesn't fix within a 32 bit
> integer causing a build warning/error (and the value truncated):
>=20
>   drivers/pwm/pwm-tegra.c: In function =E2=80=98tegra_pwm_config=E2=80=99:
>   drivers/pwm/pwm-tegra.c:148:53: error: result of =E2=80=981000000000 <<=
 8=E2=80=99 requires 39 bits to represent, but =E2=80=98long int=E2=80=99 o=
nly has 32 bits [-Werror=3Dshift-overflow=3D]
>     148 |   required_clk_rate =3D DIV_ROUND_UP_ULL(NSEC_PER_SEC << PWM_DU=
TY_WIDTH,
>         |                                                     ^~
>=20
> Explicitly cast to a u64 to ensure the correct result.

Hmm, ideally this should have popped up earlier :-\

Anyhow:

Reviewed-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

Thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig         =
   |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--jxpsqp66r5opvunj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmNtEF0ACgkQwfwUeK3K
7AkNFgf/daAqwCjFAGIZAWMCvJka1ChRqqw9pP8inKxOhs6EjG5YKgdNxb1+B2/h
/uvx9A95NyONyEiL6AIms6U2sxCC/dhvF74zSZ+UXsiQ7JjMgsLk88BeO0HwJ04c
xua1f1J1X3e0QL64NHjpu6W/7NW7OQcJLdRSx5vnkLjidziplNnrOVRRFqUNCqro
w9Nr9wALXbmBoC1tcRaAXH5xvA1ymRWY3XcBlXAgWZjJ0/5ZQ6Vnisf5TYAjz48Q
42ABRz5WqdiWoWx8E0/haDWwEK5U77mg8KrTeEG3vyCVEmcYvItQSqAs8kq/oE6n
yulb0W62Dt+u3lfJmvw8duKQdsG4/w==
=HlnY
-----END PGP SIGNATURE-----

--jxpsqp66r5opvunj--
