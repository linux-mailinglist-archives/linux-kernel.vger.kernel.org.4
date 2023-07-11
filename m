Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C01CF74F909
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 22:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbjGKUae (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 16:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbjGKUab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 16:30:31 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A30AE10C7
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 13:30:30 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qJK03-0002td-Rm; Tue, 11 Jul 2023 22:30:19 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qJK02-00DjLv-Qr; Tue, 11 Jul 2023 22:30:18 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qJK02-0048Gc-1l; Tue, 11 Jul 2023 22:30:18 +0200
Date:   Tue, 11 Jul 2023 22:30:17 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Guiting Shen <aarongt.shen@gmail.com>
Cc:     claudiu.beznea@microchip.com, thierry.reding@gmail.com,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] pwm: atmel: Enable clk when pwm already enabled in
 bootloader
Message-ID: <20230711203017.cdfe2nrjx7lt25tm@pengutronix.de>
References: <20230711200905.6464-1-aarongt.shen@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6nr4yzoa4725uv5d"
Content-Disposition: inline
In-Reply-To: <20230711200905.6464-1-aarongt.shen@gmail.com>
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


--6nr4yzoa4725uv5d
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Wed, Jul 12, 2023 at 04:09:05AM +0800, Guiting Shen wrote:
> +static int atmel_pwm_enable_clk_if_on(struct atmel_pwm_chip *atmel_pwm)
> +{
> +	unsigned int i;
> +	int err;
> +	u32 sr;
> +
> +	sr =3D atmel_pwm_readl(atmel_pwm, PWM_SR);
> +	if (!sr)
> +		return 0;
> +
> +	for (i =3D 0; i < atmel_pwm->chip.npwm; i++) {
> +		if (!(sr & (1 << i)))
> +			continue;
> +
> +		err =3D clk_enable(atmel_pwm->clk);
> +		if (err) {
> +			dev_err(atmel_pwm->chip.dev,
> +				"failed to enable clock: %pe\n", ERR_PTR(err));

Here you leak possibly a few enables. While it's not likely that the
(say) third enable goes wrong, it's also not that hard to handle?!

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--6nr4yzoa4725uv5d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmStu9gACgkQj4D7WH0S
/k5IAAf/WJCmZ2JlQoyLBuFHPMvT2efkik3JJQWbRGTjdYi/JPgG77RRVGlhtDyN
acKyLmayDKCL9MHg15iRhsh7Us6DWRK3CVadsXtK+sz29fT0j7W20v3QC4oyL3TM
8z/egwginBculUG6gDYrE+q9YJ4CDHfXjSzhvV3y5zV9IHbWasNikd3UlNDRdbAj
Smfbmj6Hb4MBAp2YAbkXBHvDa5KgvjxwoqEq9yZs7DD7RNeDsys8VFsnhP0uRlcQ
t/RYBW0/py3rpEtFvAFQwXdb98MdyXhDOQJyxac4D2WV9vHAVTLicdh6OAER81/A
1E3SfVrdKwiYaJ5H5+Vaew2hPLmDdA==
=ZOFM
-----END PGP SIGNATURE-----

--6nr4yzoa4725uv5d--
