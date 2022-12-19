Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9B15650CA7
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 14:31:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231894AbiLSNa6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 08:30:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231515AbiLSNay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 08:30:54 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FAB86372
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 05:30:52 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1p7GE2-0001Ma-6s; Mon, 19 Dec 2022 14:30:38 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1p7GE0-000LSN-QW; Mon, 19 Dec 2022 14:30:36 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1p7GDz-006KMX-Qh; Mon, 19 Dec 2022 14:30:35 +0100
Date:   Mon, 19 Dec 2022 14:30:34 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Sasha Finkelstein <fnkl.kernel@gmail.com>
Cc:     thierry.reding@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, marcan@marcan.st,
        sven@svenpeter.dev, alyssa@rosenzweig.io, asahi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/4] pwm: Add Apple PWM controller
Message-ID: <20221219133034.3ikaxesgfc6znbrs@pengutronix.de>
References: <20221209111313.2701-1-fnkl.kernel@gmail.com>
 <20221209111313.2701-3-fnkl.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vram75tz7mrsla2b"
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


--vram75tz7mrsla2b
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 09, 2022 at 02:13:11PM +0300, Sasha Finkelstein wrote:
> Adds the Apple PWM controller driver.
>=20
> Signed-off-by: Sasha Finkelstein <fnkl.kernel@gmail.com>
> Acked-by: Sven Peter <sven@svenpeter.dev>
> ---
>  drivers/pwm/Kconfig     |  12 ++++
>  drivers/pwm/Makefile    |   1 +
>  drivers/pwm/pwm-apple.c | 150 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 163 insertions(+)
>  create mode 100644 drivers/pwm/pwm-apple.c
>=20
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 60d13a949bc5..c3be11468414 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -51,6 +51,18 @@ config PWM_AB8500
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm-ab8500.
> =20
> +config PWM_APPLE
> +	tristate "Apple SoC PWM support"
> +	depends on ARCH_APPLE || COMPILE_TEST
> +	help
> +	  Generic PWM framework driver for PWM controller present on
> +	  Apple SoCs
> +
> +	  Say Y here if you have an ARM Apple laptop, otherwise say N
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called pwm-apple.
> +
>  config PWM_ATMEL
>  	tristate "Atmel PWM support"
>  	depends on ARCH_AT91 || COMPILE_TEST
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index 7bf1a29f02b8..19899b912e00 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -2,6 +2,7 @@
>  obj-$(CONFIG_PWM)		+=3D core.o
>  obj-$(CONFIG_PWM_SYSFS)		+=3D sysfs.o
>  obj-$(CONFIG_PWM_AB8500)	+=3D pwm-ab8500.o
> +obj-$(CONFIG_PWM_APPLE)		+=3D pwm-apple.o
>  obj-$(CONFIG_PWM_ATMEL)		+=3D pwm-atmel.o
>  obj-$(CONFIG_PWM_ATMEL_HLCDC_PWM)	+=3D pwm-atmel-hlcdc.o
>  obj-$(CONFIG_PWM_ATMEL_TCB)	+=3D pwm-atmel-tcb.o
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
> +
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
> +

polarity handling is missing here and in .get_state(). I assume you
want:

	if (state->polarity =3D=3D PWM_POLARITY_INVERSED)
		return -EINVAL;

here and

	state->polarity =3D PWM_POLARITY_NORMAL;

in .get_state().

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
> +}

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--vram75tz7mrsla2b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmOgZ3cACgkQwfwUeK3K
7AlxYQf/YOLbw1yO2jBlVQEjyOtuOia2YlkAog7s7FlPoS8ngtUMT+T770LKj35M
YgpfVMdR5jVbnjaojsF6WU4IcPyrg1CnaqU2SinaWfsKToWRkkBanb+0NZ8rN7gP
jhOg9tbPnNt139EvZlP0FNoo+9Cs0orP0Q3lOQ9JXcMzgT+CwlumClwuDuTJQC+q
kMUfvOw0aiS1X5T3dpiOih9Cl8vHvdX9IEdvYWmFSAeUPV9LSvcXPh+vKpUR+Bxs
tmZ69lI576BB/W/F9AL0oos6Ps3/irJsw2bVUfl+ffx9u4mJEo5B4nbnLStU6p4H
gbbPQIUGYaVHim3wT08zgK2A99Y/Qw==
=teLZ
-----END PGP SIGNATURE-----

--vram75tz7mrsla2b--
