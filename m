Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C50085B8CB0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 18:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbiINQSC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 12:18:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiINQR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 12:17:57 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F6A75FCD
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 09:17:56 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oYV5E-0004Qa-3U; Wed, 14 Sep 2022 18:17:52 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oYV5E-000jHC-BQ; Wed, 14 Sep 2022 18:17:50 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oYV5C-000uDx-0B; Wed, 14 Sep 2022 18:17:50 +0200
Date:   Wed, 14 Sep 2022 18:17:49 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Ben Dooks <ben.dooks@sifive.com>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        jarkko.nikula@linux.intel.com,
        William Salmon <william.salmon@sifive.com>,
        Jude Onyenegecha <jude.onyenegecha@sifive.com>
Subject: Re: [RFC v4 07/10] pwm: dwc: make timer clock configurable
Message-ID: <20220914161749.uqdjtsr57dydu4jm@pengutronix.de>
References: <20220816211454.237751-1-ben.dooks@sifive.com>
 <20220816211454.237751-8-ben.dooks@sifive.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7ggtuwrutrl7fzkk"
Content-Disposition: inline
In-Reply-To: <20220816211454.237751-8-ben.dooks@sifive.com>
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


--7ggtuwrutrl7fzkk
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Ben,

On Tue, Aug 16, 2022 at 10:14:51PM +0100, Ben Dooks wrote:
> Add a configurable clock base rate for the pwm as when being built
> for non-PCI the block may be sourced from an internal clock.
>=20
> Signed-off-by: Ben Dooks <ben.dooks@sifive.com>
> ---
> v4:
>  - moved earlier before the of changes to make the of changes one patch
> v2:
>   - removed the ifdef and merged the other clock patch in here
> ---
>  drivers/pwm/pwm-dwc-pci.c |  1 +
>  drivers/pwm/pwm-dwc.c     | 10 ++++++----
>  drivers/pwm/pwm-dwc.h     |  2 ++
>  3 files changed, 9 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-dwc-pci.c b/drivers/pwm/pwm-dwc-pci.c
> index 2213d0e7f3c8..949423e368f9 100644
> --- a/drivers/pwm/pwm-dwc-pci.c
> +++ b/drivers/pwm/pwm-dwc-pci.c
> @@ -20,6 +20,7 @@
>  #include <linux/pci.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/pwm.h>
> +#include <linux/clk.h>
> =20
>  #include "pwm-dwc.h"
> =20

This hunk is strange. Why do you add a header but no user of a symbol
declared in that header? Maybe it should go to pwm-dwc.h?

> diff --git a/drivers/pwm/pwm-dwc.c b/drivers/pwm/pwm-dwc.c
> index 90a8ae1252a1..1251620ab771 100644
> --- a/drivers/pwm/pwm-dwc.c
> +++ b/drivers/pwm/pwm-dwc.c
> @@ -14,6 +14,7 @@
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/pci.h>
> +#include <linux/clk.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/pwm.h>
> =20
> @@ -47,13 +48,13 @@ static int __dwc_pwm_configure_timer(struct dwc_pwm *=
dwc,
>  	 * periods and check are the result within HW limits between 1 and
>  	 * 2^32 periods.
>  	 */
> -	tmp =3D DIV_ROUND_CLOSEST_ULL(state->duty_cycle, DWC_CLK_PERIOD_NS);
> +	tmp =3D DIV_ROUND_CLOSEST_ULL(state->duty_cycle, dwc->clk_ns);
>  	if (tmp < 1 || tmp > (1ULL << 32))
>  		return -ERANGE;
>  	low =3D tmp - 1;
> =20
>  	tmp =3D DIV_ROUND_CLOSEST_ULL(state->period - state->duty_cycle,
> -				    DWC_CLK_PERIOD_NS);
> +				    dwc->clk_ns);
>  	if (tmp < 1 || tmp > (1ULL << 32))
>  		return -ERANGE;
>  	high =3D tmp - 1;
> @@ -128,12 +129,12 @@ static void dwc_pwm_get_state(struct pwm_chip *chip=
, struct pwm_device *pwm,
> =20
>  	duty =3D dwc_pwm_readl(dwc, DWC_TIM_LD_CNT(pwm->hwpwm));
>  	duty +=3D 1;
> -	duty *=3D DWC_CLK_PERIOD_NS;
> +	duty *=3D dwc->clk_ns;
>  	state->duty_cycle =3D duty;
> =20
>  	period =3D dwc_pwm_readl(dwc, DWC_TIM_LD_CNT2(pwm->hwpwm));
>  	period +=3D 1;
> -	period *=3D DWC_CLK_PERIOD_NS;
> +	period *=3D dwc->clk_ns;
>  	period +=3D duty;
>  	state->period =3D period;
> =20
> @@ -156,6 +157,7 @@ struct dwc_pwm *dwc_pwm_alloc(struct device *dev)
>  	if (!dwc)
>  		return NULL;
> =20
> +	dwc->clk_ns =3D 10;
>  	dwc->chip.dev =3D dev;
>  	dwc->chip.ops =3D &dwc_pwm_ops;
>  	dwc->chip.npwm =3D DWC_TIMERS_TOTAL;

After this conversion all usage of DWC_CLK_PERIOD_NS is done so the
#define can go away?

> diff --git a/drivers/pwm/pwm-dwc.h b/drivers/pwm/pwm-dwc.h
> index 68f98eb76152..e5a1f7be7bc8 100644
> --- a/drivers/pwm/pwm-dwc.h
> +++ b/drivers/pwm/pwm-dwc.h
> @@ -41,6 +41,8 @@ struct dwc_pwm_ctx {
>  struct dwc_pwm {
>  	struct pwm_chip chip;
>  	void __iomem *base;
> +	struct clk *clk;
> +	unsigned int clk_ns;
>  	struct dwc_pwm_ctx ctx[DWC_TIMERS_TOTAL];
>  };
>  #define to_dwc_pwm(p)	(container_of((p), struct dwc_pwm, chip))
> --=20
> 2.35.1
>=20
>=20

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--7ggtuwrutrl7fzkk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmMh/qoACgkQwfwUeK3K
7AmVUAgAl/Pel6F6G4l1cQUDFfo/EmALiRQCkARq4P+N5pznEUJFbNEzb7iY5FHP
aaRoIYSUCZhIfr3aNI57ZrWPThxRcnSnpmBc8CD/e8/7o8ixdS/7/jNtcbSQ0Ztl
ho6Rdb7X89W7wIjeHHdKrXws54BSWdLqgJdzVsx8l27bHV6utbW4HZ5B8o3BLgFu
+e/nPG9CSUadsHbYkvgzgL+sS9fJaJBPdEGh6S9Y2j3hBdfqZt0gFMpSga2w12wy
2aT663OfVTHxuPUoL7fDhcLRglArSiFWuD+THNqD5WhW4qr/s87oAcgRC+MQbgEZ
ICINuQJNIb6jWPbzdT4Ds+sGxf0NNg==
=W5Dx
-----END PGP SIGNATURE-----

--7ggtuwrutrl7fzkk--
