Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54FB3702FEF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 16:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237188AbjEOOdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 10:33:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239978AbjEOOdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 10:33:18 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07072183
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 07:32:42 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pyZFQ-0008Mh-Mp; Mon, 15 May 2023 16:32:24 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pyZFP-000OBu-P0; Mon, 15 May 2023 16:32:23 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pyZFP-004iUa-1B; Mon, 15 May 2023 16:32:23 +0200
Date:   Mon, 15 May 2023 16:32:22 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Arnd Bergmann <arnd@kernel.org>, Linus Walleij <linusw@kernel.org>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 36/43] pwm: ep93xx: drop legacy pinctrl
Message-ID: <20230515143222.dlhxcze5254773r4@pengutronix.de>
References: <20230424123522.18302-1-nikita.shubin@maquefel.me>
 <20230424123522.18302-37-nikita.shubin@maquefel.me>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uehgxcqdeovzrqox"
Content-Disposition: inline
In-Reply-To: <20230424123522.18302-37-nikita.shubin@maquefel.me>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uehgxcqdeovzrqox
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 24, 2023 at 03:34:52PM +0300, Nikita Shubin wrote:
> Drop legacy gpio request/free since we are using
> pinctrl for this now.
>=20
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> ---
>  drivers/pwm/pwm-ep93xx.c | 16 ----------------
>  1 file changed, 16 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-ep93xx.c b/drivers/pwm/pwm-ep93xx.c
> index 8bfe6cfbb3db..657adb011aeb 100644
> --- a/drivers/pwm/pwm-ep93xx.c
> +++ b/drivers/pwm/pwm-ep93xx.c
> @@ -45,20 +45,6 @@ static inline struct ep93xx_pwm *to_ep93xx_pwm(struct =
pwm_chip *chip)
>  	return container_of(chip, struct ep93xx_pwm, chip);
>  }
> =20
> -static int ep93xx_pwm_request(struct pwm_chip *chip, struct pwm_device *=
pwm)
> -{
> -	struct platform_device *pdev =3D to_platform_device(chip->dev);
> -
> -	return ep93xx_pwm_acquire_gpio(pdev);

I didn't get the whole series and didn't spot a relevant followup change
on lore.k.o, so: I assume ep93xx_pwm_acquire_gpio() and
ep93xx_pwm_release_gpio() will be unused in the end? Do you drop them?

I assume this series target to be taken via arm-soc (once the review
feedback is positive)?

I wonder if this change breaks non-dt machine support?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--uehgxcqdeovzrqox
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmRiQnYACgkQj4D7WH0S
/k6W6QgAuF9cx7Bag66ydz8UBm679CwAYAJNaGeY1zDYaBem2ijQT1uFfdS+cCaG
uuyO0fBB+ZYAUY5ffcsAvCPs0wKLuLMD25isTpo5CCP+r4RDn5RwIMfsecEjH32X
mjReNtGgvNc8P2P5xD4h9MwwZ5JvnLxCGWCEJuql+PcBelSQfbZ9akYexZymU7PF
DmipR0eaiS3qA+7PdFzpryfR5Gmm0VKRelb3FQmPTKOs5ZTW+9nppMgWyf5PghRV
wwkyYSx/9xJbKzzfQHpJWZGYnVNKpqjX4k9uAT/YXMG6tjLIyqJsYO1qhSmIxkiK
bE0VN2Vds9v/Els4kreXxN1swq+D3g==
=7bKc
-----END PGP SIGNATURE-----

--uehgxcqdeovzrqox--
