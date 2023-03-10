Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48C886B4F5A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 18:47:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231548AbjCJRrJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 12:47:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbjCJRq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 12:46:57 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CAD212B67E
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 09:46:11 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pagnw-0000ta-RG; Fri, 10 Mar 2023 18:45:20 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pagnv-003E23-LO; Fri, 10 Mar 2023 18:45:19 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pagnv-003r3X-07; Fri, 10 Mar 2023 18:45:19 +0100
Date:   Fri, 10 Mar 2023 18:45:17 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Leif Middelschulte <leif.middelschulte@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Leif Middelschulte <Leif.Middelschulte@klsmartin.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH v2] pwm: imx27: fix race condition .apply,.get_state
Message-ID: <20230310174517.rb7xxrougkse2lrc@pengutronix.de>
References: <20230126150313.764284-1-Leif.Middelschulte@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6am3e32nnpz6yvqk"
Content-Disposition: inline
In-Reply-To: <20230126150313.764284-1-Leif.Middelschulte@gmail.com>
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


--6am3e32nnpz6yvqk
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 26, 2023 at 04:03:13PM +0100, Leif Middelschulte wrote:
> From: Leif Middelschulte <Leif.Middelschulte@klsmartin.com>
>=20
> With CONFIG_PWM_DEBUG=3Dy after writing a value to the PWMSAR
> register in .apply(), the register is read in .get_state().
> Unless a period completed in the meantime, this read yields the
> previously used duty cycle configuration. As the PWM_DEBUG code
> applies the read out configuration for testing purposes this
> effectively undoes the intended effect by rewriting the previous
> hardware state.
>=20
> Note that this change merely implements a sensible heuristic.
> The i.MX has a 4 slot FIFO to configure the duty cycle. This FIFO
> cannot be read back in its entirety. The "write x then read back
> x from hw" semantics are therefore not easily applicable.
> With this change, the .get_state() function tries to wait for some
> stabilization in the FIFO (empty state). In this state it keeps
> applying the last value written to the sample register.
>=20
> Signed-off-by: Leif Middelschulte <Leif.Middelschulte@klsmartin.com>
> ---
>  drivers/pwm/pwm-imx27.c | 50 ++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 47 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-imx27.c b/drivers/pwm/pwm-imx27.c
> index 29a3089c534c..32389ca2da3e 100644
> --- a/drivers/pwm/pwm-imx27.c
> +++ b/drivers/pwm/pwm-imx27.c
> @@ -75,6 +75,7 @@
>  						   (x)) + 1)
> =20
>  #define MX3_PWM_SWR_LOOP		5
> +#define MX3_PWM_FIFOAV_EMPTY_LOOP	4
> =20
>  /* PWMPR register value of 0xffff has the same effect as 0xfffe */
>  #define MX3_PWMPR_MAX			0xfffe
> @@ -118,8 +119,28 @@ static void pwm_imx27_clk_disable_unprepare(struct p=
wm_imx27_chip *imx)
>  	clk_disable_unprepare(imx->clk_ipg);
>  }
> =20
> +static int pwm_imx27_wait_fifo_empty(struct pwm_chip *chip,
> +				     struct pwm_device *pwm)
> +{
> +	struct pwm_imx27_chip *imx =3D to_pwm_imx27_chip(chip);
> +	struct device *dev =3D chip->dev;
> +	unsigned int period_ms =3D DIV_ROUND_UP_ULL(pwm_get_period(pwm), NSEC_P=
ER_MSEC);

Please don't use pwm_get_period. This one is intended for PWM consumers
only. Directly using pwm->state.period is fine however.

> +	int tries =3D MX3_PWM_FIFOAV_EMPTY_LOOP;
> +	int fifoav;
> +	u32 sr;
> +
> +	while (tries--) {
> +		sr =3D readl(imx->mmio_base + MX3_PWMSR);
> +		fifoav =3D FIELD_GET(MX3_PWMSR_FIFOAV, sr);
> +		if (fifoav =3D=3D MX3_PWMSR_FIFOAV_EMPTY)
> +			return;
> +		msleep(period_ms);

This is a rather long sleep. Maybe check in each iteration that fifoav
decreases as expected?

> +	}
> +	dev_warn(dev, "FIFO has been refilled concurrently\n");
> +}
> +
>  static int pwm_imx27_get_state(struct pwm_chip *chip,
> -			       struct pwm_device *pwm, struct pwm_state *state)
> +				struct pwm_device *pwm, struct pwm_state *state)
>  {
>  	struct pwm_imx27_chip *imx =3D to_pwm_imx27_chip(chip);
>  	u32 period, prescaler, pwm_clk, val;
> @@ -161,10 +182,33 @@ static int pwm_imx27_get_state(struct pwm_chip *chi=
p,
>  	 * PWMSAR can be read only if PWM is enabled. If the PWM is disabled,
>  	 * use the cached value.
>  	 */
> -	if (state->enabled)
> +	if (state->enabled) {
> +		/*
> +		 * From the i.MX PWM reference manual:
> +		 * "A read on the sample register yields the current FIFO value that
> +		 *  is being used, or will be used, by the PWM for generation on the
> +		 *  output signal. Therefore, a write and a subsequent read on the
> +		 *  sample register may result in different values being obtained."
> +		 * Furthermore:
> +		 * "When a new value is written, the duty cycle changes after the
> +		 *  current period is over."
> +		 * Note "changes" vs. "changes to the given value"!
> +		 * Finally:
> +		 * "The PWM will run at the last set duty-cycle setting if all the
> +		 *  values of the FIFO has been utilized, until the FIFO is reloaded
> +		 *  or the PWM is disabled."
> +		 * Try to be at least a bit more deterministic about which value is
> +		 * read by waiting until the FIFO is empty. In this state the last/most
> +		 * recently pushed sample (duty cycle) value is continuously applied.
> +		 * Beware that this approach is still racy, as a new value could have
> +		 * been supplied and a period expired between the call of the wait
> +		 * function and the subsequent readl.
> +		 */
> +		pwm_imx27_wait_fifo_empty(chip, pwm);

Instead of issuing a warning, I'd return an error code if
wait_fifo_empty fails.

>  		val =3D readl(imx->mmio_base + MX3_PWMSAR);
> -	else
> +	} else {
>  		val =3D imx->duty_cycle;
> +	}
> =20
>  	tmp =3D NSEC_PER_SEC * (u64)(val) * prescaler;
>  	state->duty_cycle =3D DIV_ROUND_UP_ULL(tmp, pwm_clk);

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--6am3e32nnpz6yvqk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmQLbKsACgkQwfwUeK3K
7Ak4Dwf+Oa5+Ln/xophbN2Lsb9fHLgDx9hWgNMAwBCOhewWYt447N5SWJD7QXQDA
D5s5Z44XMbu5aOTxmYusOniHhgxyhZCYOgG6BGXbZXIi+F3P9hxNMiwtDRCAjpmS
cwDQv1TQ/6CbwxOuOj85Wy+LTradRa4XLs42wPie+BUWVvZl5H5RlUUGQEpA2yiW
gfF0dzKuX668ccjS5tKYIzAl/s1YhNbn8aetJbMR26g1KWuKmtuBFJGyZST3A5h8
ffxcqxW73Xx7vUZJFidVZrk+F4jqSBE9FpB/OzKsGS9o+2hnKwSzME022WTD3WNF
DQYQOHedFSCxb3dZnDy7AlSNvWjJ7g==
=7doX
-----END PGP SIGNATURE-----

--6am3e32nnpz6yvqk--
