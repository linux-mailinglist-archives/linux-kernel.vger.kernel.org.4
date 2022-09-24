Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02B9C5E8B46
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 12:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233718AbiIXKAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 06:00:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233683AbiIXJ74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 05:59:56 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EEFC275C1
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 02:59:52 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oc1ws-00086J-Tt; Sat, 24 Sep 2022 11:59:50 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oc1wt-002cgD-3g; Sat, 24 Sep 2022 11:59:49 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oc1wq-003Bvw-QV; Sat, 24 Sep 2022 11:59:48 +0200
Date:   Sat, 24 Sep 2022 11:59:45 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2 2/9] pwm: lpss: Move exported symbols to PWM_LPSS
 namespace
Message-ID: <20220924095945.pzyhc24jhjwlfdin@pengutronix.de>
References: <20220908135658.64463-1-andriy.shevchenko@linux.intel.com>
 <20220908135658.64463-3-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dlacduo5ix5zixyd"
Content-Disposition: inline
In-Reply-To: <20220908135658.64463-3-andriy.shevchenko@linux.intel.com>
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


--dlacduo5ix5zixyd
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Thu, Sep 08, 2022 at 04:56:51PM +0300, Andy Shevchenko wrote:
> Avoid unnecessary pollution of the global symbol namespace by
> moving library functions in to a specific namespace and import
> that into the drivers that make use of the functions.
>=20
> For more info: https://lwn.net/Articles/760045/
>=20
> Suggested-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/pwm/pwm-lpss-pci.c      | 1 +
>  drivers/pwm/pwm-lpss-platform.c | 1 +
>  drivers/pwm/pwm-lpss.c          | 2 ++
>  3 files changed, 4 insertions(+)
>=20
> diff --git a/drivers/pwm/pwm-lpss-pci.c b/drivers/pwm/pwm-lpss-pci.c
> index 75b778e839b3..9f2c666b95ec 100644
> --- a/drivers/pwm/pwm-lpss-pci.c
> +++ b/drivers/pwm/pwm-lpss-pci.c
> @@ -92,3 +92,4 @@ module_pci_driver(pwm_lpss_driver_pci);
> =20
>  MODULE_DESCRIPTION("PWM PCI driver for Intel LPSS");
>  MODULE_LICENSE("GPL v2");
> +MODULE_IMPORT_NS(PWM_LPSS);

Each user of the lpss.h header needs that, right? Then the
MODULE_IMPORT_NS statement can go into the header, too.

Even without this change:

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--dlacduo5ix5zixyd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmMu1Q4ACgkQwfwUeK3K
7Amq6wf/Qt4UZSDc2gCjKKXzTBHLD5YcIWmecTE0GQTvy7Dp5ThWyIyMXPfbI44u
/mtwj1cr0iD6rZk1Dtw6FM24DQ4cEAAPKjmJycNrgKurZG6oiyhhRQWmj7TuKfKd
gDeM26tERkj3sYhPnOkG1ctzE+pYvqOulhu4yA3fO8w1rE5nFfnyr+VedRzLn8Mx
NXbbsOMiuExFS7WE2ssuNZRi9azvA+2wCSDn90upeHWBFVMMHIxfZ80+qaWxxcfH
1STfFno/Q3my0njzV/RzePiselPkuc8QjNgMshuU7TeM7qE1rGmXtBfnHnwkPJqL
hmGNDZ6n5bTukbazEgJZU96Vv3ZUFQ==
=RsRm
-----END PGP SIGNATURE-----

--dlacduo5ix5zixyd--
