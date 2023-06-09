Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A596C729CAE
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 16:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241160AbjFIOWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 10:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241119AbjFIOWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 10:22:05 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 301203598
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 07:22:04 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1q7d01-0007ok-Tg; Fri, 09 Jun 2023 16:21:57 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q7d00-006Dw8-Nd; Fri, 09 Jun 2023 16:21:56 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q7d00-00CbtK-3b; Fri, 09 Jun 2023 16:21:56 +0200
Date:   Fri, 9 Jun 2023 16:21:55 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-pwm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pwm: stm32: Implement .get_state()
Message-ID: <20230609142155.h5fvn4fxdcleoznw@pengutronix.de>
References: <20230608-pwm-stm32-get-state-v1-1-db7e58a7461b@pengutronix.de>
 <dac9c545-fcbc-3aec-c341-abc62f551703@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wkz2lg5pii5fhdhh"
Content-Disposition: inline
In-Reply-To: <dac9c545-fcbc-3aec-c341-abc62f551703@foss.st.com>
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


--wkz2lg5pii5fhdhh
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Fabrice,

On Fri, Jun 09, 2023 at 03:06:47PM +0200, Fabrice Gasnier wrote:
> On 6/8/23 16:06, Philipp Zabel wrote:
> > +static int stm32_pwm_get_state(struct pwm_chip *chip,
> > +			       struct pwm_device *pwm, struct pwm_state *state)
> > +{
> > +	struct stm32_pwm *priv =3D to_stm32_pwm_dev(chip);
> > +	int ch =3D pwm->hwpwm;
> > +	unsigned long rate;
> > +	u32 ccer, psc, arr, ccr;
> > +	u64 dty, prd;
> > +	int ret;
> > +
> > +	ret =3D regmap_read(priv->regmap, TIM_CCER, &ccer);
> > +	if (ret)
> > +		return ret;
> > +
> > +	state->enabled =3D ccer & (TIM_CCER_CC1E << (ch * 4));
> > +	state->polarity =3D (ccer & (TIM_CCER_CC1P << (ch * 4))) ?
> > +			  PWM_POLARITY_INVERSED : PWM_POLARITY_NORMAL;
> > +	regmap_read(priv->regmap, TIM_PSC, &psc);
> > +	regmap_read(priv->regmap, TIM_ARR, &arr);
> > +	read_ccrx(priv, ch, &ccr);
> > +	rate =3D clk_get_rate(priv->clk);
> > +
> > +	prd =3D (u64)NSEC_PER_SEC * (psc + 1) * (arr + 1);
> > +	state->period =3D DIV_ROUND_UP_ULL(prd, rate);
> > +	dty =3D (u64)NSEC_PER_SEC * (psc + 1) * ccr;
> > +	state->duty_cycle =3D DIV_ROUND_UP_ULL(dty, rate);
>=20
> Just a question/thought, could it be worth to use DIV_ROUND_CLOSEST_ULL()=
 ?

No, round up is the right choice. The reason for that is that .apply()
rounds down in its divisions. If you use ROUND_CLOSEST here, reapplying
the result from .get_state() might not be idempotent.

> > +
> > +	return ret;
> > +}

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--wkz2lg5pii5fhdhh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmSDNYMACgkQj4D7WH0S
/k7s5Af/RT0ZOdJvsT4ylvLPggQkwlMTUHV0alz7e2/4+uYnw8bv5kN9Ly38Mnm5
IKwDWxm5tRbuUNm658LqBYi4xXRnPdvkR3Sx18PE8KZsIkbjRcaizPk2UnkpIJKd
UWtztLyKTT5LUp2mn9WGjzUgC+eXW67uSY0/ChoWVANu9/J2bpbp2rpIz3l2vk30
jwdWMX61A7j5kS/XanteA7nKuFwI94MdzrfqCMSAW2w2YKS63RcA/aPr1tKtlPZv
77UHlviGhFPm7R4LrAaX3Swj2OIq3Lj7nREr9YUT5/vO+AULV9pX2nUvR9zAMVVw
y/4kR4atPgutjQ19zD+pfpXz/jlQGQ==
=yi3A
-----END PGP SIGNATURE-----

--wkz2lg5pii5fhdhh--
