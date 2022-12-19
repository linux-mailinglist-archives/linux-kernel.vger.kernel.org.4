Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50397650C6C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 14:06:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231917AbiLSNGr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 08:06:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbiLSNGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 08:06:44 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7ED565E6
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 05:06:40 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1p7FqU-0006uP-H0; Mon, 19 Dec 2022 14:06:18 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1p7FqR-000Kxh-SW; Mon, 19 Dec 2022 14:06:15 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1p7FqQ-006JrB-MX; Mon, 19 Dec 2022 14:06:14 +0100
Date:   Mon, 19 Dec 2022 14:06:10 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Sasha Finkelstein <fnkl.kernel@gmail.com>
Cc:     thierry.reding@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, marcan@marcan.st,
        sven@svenpeter.dev, alyssa@rosenzweig.io, asahi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/4] pwm: Add Apple PWM controller
Message-ID: <20221219130610.yxggztlqnssm4k7c@pengutronix.de>
References: <20221209111313.2701-1-fnkl.kernel@gmail.com>
 <20221209111313.2701-3-fnkl.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cybldnmdxrk2dtsd"
Content-Disposition: inline
In-Reply-To: <20221209111313.2701-3-fnkl.kernel@gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cybldnmdxrk2dtsd
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

over all the driver looks good. Just a few smaller issues below.

I wonder if it's a good idea to call this driver "apple". SoC vendors
seem to reinvent their peripherals (or buy them somewhere else) for
their different generations of processors. Maybe call it "apple-s5l"
already today and not only when the next generation SoC appears?
(I don't feel strong here, if you want to delay that renaming until
there is an incompatible SoC that's fine for me.)

On Fri, Dec 09, 2022 at 02:13:11PM +0300, Sasha Finkelstein wrote:
> diff --git a/drivers/pwm/pwm-apple.c b/drivers/pwm/pwm-apple.c
> new file mode 100644
> index 000000000000..a85fecb20105
> --- /dev/null
> +++ b/drivers/pwm/pwm-apple.c
> @@ -0,0 +1,150 @@
> +// SPDX-License-Identifier: GPL-2.0 OR MIT
> +/*
> + * Driver for the Apple SoC PWM controller
> + *
> + * Copyright The Asahi Linux Contributors
> + *
> + * Limitations:
> + * - The writes to cycle registers are shadowed until a write to
> + *   the control register.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/pwm.h>
> +#include <linux/io.h>
> +#include <linux/clk.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/math64.h>

I didn't test, but I think you don't need pm_runtime.h here. Also maybe
the of headers are not needed?

> +#define APPLE_PWM_CONTROL     0x00
> +#define APPLE_PWM_ON_CYCLES   0x1c
> +#define APPLE_PWM_OFF_CYCLES  0x18
> +
> +#define APPLE_CTRL_ENABLE        BIT(0)
> +#define APPLE_CTRL_MODE          BIT(2)
> +#define APPLE_CTRL_UPDATE        BIT(5)
> +#define APPLE_CTRL_TRIGGER       BIT(9)
> +#define APPLE_CTRL_INVERT        BIT(10)
> +#define APPLE_CTRL_OUTPUT_ENABLE BIT(14)

Would be nice if the register prefix would match the register name. That
is please either rename APPLE_PWM_CONTROL to APPLE_PWM_CTRL or use
APPLE_PWM_CONTROL as prefix for the bit fields in that register.

> +
> +struct apple_pwm {
> +	struct pwm_chip chip;
> +	void __iomem *base;
> +	u64 clkrate;
> +};
> +
> +static inline struct apple_pwm *to_apple_pwm(struct pwm_chip *chip)
> +{
> +	return container_of(chip, struct apple_pwm, chip);
> +}
> +
> +static int apple_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> +			   const struct pwm_state *state)
> +{
> +	struct apple_pwm *fpwm;
> +	u64 on_cycles, off_cycles;

The declaration can move into the if block below.

> +
> +	fpwm =3D to_apple_pwm(chip);
> +	if (state->enabled) {
> +		on_cycles =3D mul_u64_u64_div_u64(fpwm->clkrate,
> +						state->duty_cycle, NSEC_PER_SEC);
> +		if (on_cycles > 0xFFFFFFFF)
> +			return -ERANGE;
> +
> +		off_cycles =3D mul_u64_u64_div_u64(fpwm->clkrate,
> +						 state->period, NSEC_PER_SEC) - on_cycles;
> +		if (off_cycles > 0xFFFFFFFF)
> +			return -ERANGE;
> +
> +		writel(on_cycles, fpwm->base + APPLE_PWM_ON_CYCLES);
> +		writel(off_cycles, fpwm->base + APPLE_PWM_OFF_CYCLES);
> +		writel(APPLE_CTRL_ENABLE | APPLE_CTRL_OUTPUT_ENABLE | APPLE_CTRL_UPDAT=
E,
> +		       fpwm->base + APPLE_PWM_CONTROL);
> +	} else {
> +		writel(0, fpwm->base + APPLE_PWM_CONTROL);
> +	}
> +	return 0;

Assuming clkrate =3D 24000000, I wonder what happens if (duty_cycle and)
period are so small that on_cycles and off_cycles are both zero. How
does the hardware behave in this case?

> +}
> +
> +static void apple_pwm_get_state(struct pwm_chip *chip, struct pwm_device=
 *pwm,
> +			   struct pwm_state *state)
> +{
> +	struct apple_pwm *fpwm;
> +	u32 on_cycles, off_cycles, ctrl;
> +
> +	fpwm =3D to_apple_pwm(chip);
> +
> +	ctrl =3D readl(fpwm->base + APPLE_PWM_CONTROL);
> +	on_cycles =3D readl(fpwm->base + APPLE_PWM_ON_CYCLES);
> +	off_cycles =3D readl(fpwm->base + APPLE_PWM_OFF_CYCLES);
> +
> +	state->enabled =3D (ctrl & APPLE_CTRL_ENABLE) && (ctrl & APPLE_CTRL_OUT=
PUT_ENABLE);
> +	state->polarity =3D PWM_POLARITY_NORMAL;
> +	state->duty_cycle =3D mul_u64_u64_div_u64(on_cycles, NSEC_PER_SEC, fpwm=
->clkrate);
> +	state->period =3D mul_u64_u64_div_u64(off_cycles + on_cycles,
> +					    NSEC_PER_SEC, fpwm->clkrate);

Wrong rounding direction, you need to round up. Did you test with
PWM_DEBUG on? This should point out the more obvious cases. Assuming
clkrate =3D 24000000 for example setting .duty_cycle =3D 3 should trigger a
warning.

Unfortunately there is no variant of mul_u64_u64_div_u64 that rounds up,
maybe we need to introduce one.

> +}

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--cybldnmdxrk2dtsd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmOgYb8ACgkQwfwUeK3K
7AmyGgf/ZLtQ8j885QI9iI+qjelPALAIjeT2vq38/e9XPENLAGqMsl2+Fi9hgqEC
fVv6/DhQyKJpvtcjjZIAnr7yBNXFSSAOoCgcNQ5RekuJ4PLW0Bh3yvOA4rf34Ilv
N/pH5R1CVD1+nRP9VnfctX8cSG1a/fNhuXiSz47Fr2vhvHUGj8x2eLpD+NYZQhzN
Nn0IQK6T5TQ5m45269jzJgfnoNFDaNQsUkW9BkveIBiIfuwzccdyGu1W0U6dwX6e
MWaVcHSOtOl55ijXCtDBg4H6AdYiAgAdD7vyYS4sOZsix+cKoAVvl5bAjhDhTmro
guHL50ggTuXTF6uizUOVGEGUUB1/xw==
=+xU3
-----END PGP SIGNATURE-----

--cybldnmdxrk2dtsd--
