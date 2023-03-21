Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF7546C3621
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 16:47:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231730AbjCUPrx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 11:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231140AbjCUPrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 11:47:51 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B5D7CDC5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 08:47:50 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1peeCx-0004fu-Rx; Tue, 21 Mar 2023 16:47:31 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1peeCw-005is5-0N; Tue, 21 Mar 2023 16:47:30 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1peeCv-006nh6-05; Tue, 21 Mar 2023 16:47:29 +0100
Date:   Tue, 21 Mar 2023 16:47:28 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
Cc:     gregkh@linuxfoundation.org, outreachy@lists.linux.dev,
        johan@kernel.org, elder@kernel.org, vireshk@kernel.org,
        thierry.reding@gmail.com, greybus-dev@lists.linaro.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-pwm@vger.kernel.org, Julia Lawall <julia.lawall@inria.fr>
Subject: Re: [PATCH 2/3] staging: greybus: use inline function for macros
Message-ID: <20230321154728.3r7ut3rl2pccmo2e@pengutronix.de>
References: <cover.1679352669.git.eng.mennamahmoud.mm@gmail.com>
 <1274302b52ae905dab6f75377d625598facbbdf1.1679352669.git.eng.mennamahmoud.mm@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="spy665gboibxpu7h"
Content-Disposition: inline
In-Reply-To: <1274302b52ae905dab6f75377d625598facbbdf1.1679352669.git.eng.mennamahmoud.mm@gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--spy665gboibxpu7h
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

just some nitpicks:

On Tue, Mar 21, 2023 at 01:04:33AM +0200, Menna Mahmoud wrote:
> Convert `to_gbphy_dev` and `to_gbphy_driver` macros into a
> static inline function.
>=20
> it is not great to have macro that use `container_of` macro,

s/it/It/; s/macro/macros/; s/use/use the/;

> because from looking at the definition one cannot tell what type
> it applies to.
> [...]
> -#define to_gbphy_dev(d) container_of(d, struct gbphy_device, dev)
> +static inline struct gbphy_device *to_gbphy_dev(const struct device *d)

drivers/staging/greybus/gbphy.c always passes a variable named
"dev" to this macro. So I'd call the parameter "dev", too, instead of
"d". This is also a more typical name for variables of that type.

> +{
> +	return container_of(d, struct gbphy_device, dev);
> +}
> [...]
>  };
> -#define to_gbphy_driver(d) container_of(d, struct gbphy_driver, driver)
> +static inline struct gbphy_driver *to_gbphy_driver(struct device_driver =
*d)
> +{
> +	return container_of(d, struct gbphy_driver, driver);
> +}

With a similar reasoning (and also to not have "d"s that are either
device or device_driver) I'd recommend "drv" here.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--spy665gboibxpu7h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmQZ0Y8ACgkQj4D7WH0S
/k4qLAf+OTmsDZSmp40zMixg9DyMOELi6eqVdtJNU0qCtkilPtrhsOc1vhA3SamR
4rtAve/7j2BN+tb4WuiZ7YwaMXs5KJ3RItbk5imECAeAvRY0BDfHHJUZY2DrBSEY
LyRButIl87Gx7CVaylbyORucxyTsU1h/Pj94t5kxAp9Xa5zkSaFwBxh3rP2L5bjd
nxyRUG7tt+LYeR8+53BlcQqRARzpeiunRsIp3HhiPIi819GZEJh6eDEGNbTUYRED
uzyBRgvEL47X2nJZG6d8TgcGWlUicJyqBMDeQavLQxMlb8URXu2qUCfph/gscRi3
1xxyP135o/YY4eUmw3946Nxbj2t0oA==
=eLyP
-----END PGP SIGNATURE-----

--spy665gboibxpu7h--
