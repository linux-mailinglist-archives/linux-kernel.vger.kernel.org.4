Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 141986B4F0C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 18:40:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbjCJRjp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 12:39:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231604AbjCJRja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 12:39:30 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B1B128010
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 09:38:53 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1paggY-0007mJ-EG; Fri, 10 Mar 2023 18:37:42 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1paggU-003E1P-Ot; Fri, 10 Mar 2023 18:37:38 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1paggT-003r2a-68; Fri, 10 Mar 2023 18:37:37 +0100
Date:   Fri, 10 Mar 2023 18:37:35 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Sasha Finkelstein <fnkl.kernel@gmail.com>
Cc:     thierry.reding@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, marcan@marcan.st,
        sven@svenpeter.dev, alyssa@rosenzweig.io, asahi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 2/5] pwm: Add Apple PWM controller
Message-ID: <20230310173735.2v4smudck2qgt27y@pengutronix.de>
References: <20230114132508.96600-1-fnkl.kernel@gmail.com>
 <20230114132508.96600-3-fnkl.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="27yatcxzmvpgc6bc"
Content-Disposition: inline
In-Reply-To: <20230114132508.96600-3-fnkl.kernel@gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--27yatcxzmvpgc6bc
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Sat, Jan 14, 2023 at 04:25:05PM +0300, Sasha Finkelstein wrote:
> +static int apple_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> +			   const struct pwm_state *state)
> +{
> +	struct apple_pwm *fpwm;
> +
> +	if (state->polarity =3D=3D PWM_POLARITY_INVERSED)
> +		return -EINVAL;
> +
> +	fpwm =3D to_apple_pwm(chip);
> +	if (state->enabled) {
> +		u64 on_cycles, off_cycles;
> +
> +		on_cycles =3D mul_u64_u64_div_u64(fpwm->clkrate,
> +						state->duty_cycle, NSEC_PER_SEC);
> +		if (on_cycles > 0xFFFFFFFF)
> +			return -ERANGE;

The idea is to configure the biggest duty_cycle that is not bigger than
the requested duty_cycle. So don't return an error here, but use
0xffffffff instead.

I should have catched that in my v4 and my v6 review, sorry, I missed
that.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--27yatcxzmvpgc6bc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmQLat0ACgkQwfwUeK3K
7Am66wf/U1bdPVcUR8xgM53HsTx0FsGZBiGJwys2OEYRIJmjFcLdwiPAIoqbbHFQ
t9qU/L0cdxeaaP5Kc9YDoYf2pPWk1/XSEGjyPdAN8VY13mQH118KnrEPX7hU/SkV
wGGXuRX2CkIbar4DUklIQNLU9xzKgZN0RVToA64TKzTLGztVhp5jePyfFFSNdQvd
t/ZcBlhbmP2nUM2n0lMvjr2PwmGDLmIx3y0TXVLuxR68SjhPXfK7StpP4tTN+XQe
V0KFiBzqTeyExVGuBMCcjT6fMkK7rHLq5jPwJd7mhVID91qP//Pnmd7TCY9i4BRS
G24WJ07T3WSdiRpK6sG76SKhQms8iQ==
=h9Aj
-----END PGP SIGNATURE-----

--27yatcxzmvpgc6bc--
