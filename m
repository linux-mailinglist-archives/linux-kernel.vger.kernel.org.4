Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 071A0664F95
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 00:07:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234634AbjAJXH1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 18:07:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235187AbjAJXHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 18:07:17 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3E2A51331
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 15:06:50 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pFNhL-0002oM-5n; Wed, 11 Jan 2023 00:06:27 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pFNhG-005Ai6-Sd; Wed, 11 Jan 2023 00:06:22 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pFNhF-00BpK3-Vd; Wed, 11 Jan 2023 00:06:22 +0100
Date:   Wed, 11 Jan 2023 00:06:18 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Sasha Finkelstein <fnkl.kernel@gmail.com>
Cc:     thierry.reding@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, marcan@marcan.st,
        sven@svenpeter.dev, alyssa@rosenzweig.io, asahi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/5] pwm: Add Apple PWM controller
Message-ID: <20230110230618.pfz267jj5ne34ava@pengutronix.de>
References: <20230106135839.18676-1-fnkl.kernel@gmail.com>
 <20230106135839.18676-3-fnkl.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nhj3lt2xyxvt3eo2"
Content-Disposition: inline
In-Reply-To: <20230106135839.18676-3-fnkl.kernel@gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nhj3lt2xyxvt3eo2
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Sasha,

On Fri, Jan 06, 2023 at 04:58:39PM +0300, Sasha Finkelstein wrote:
> Adds the Apple PWM controller driver.
>=20
> Signed-off-by: Sasha Finkelstein <fnkl.kernel@gmail.com>
> Acked-by: Sven Peter <sven@svenpeter.dev>
> ---
>  drivers/pwm/Kconfig     |  12 ++++
>  drivers/pwm/Makefile    |   1 +
>  drivers/pwm/pwm-apple.c | 156 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 169 insertions(+)
>  create mode 100644 drivers/pwm/pwm-apple.c
>=20
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index dae023d783a2..8df861b1f4a3 100644
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
> index 000000000000..5360583a5fa6
> --- /dev/null
> +++ b/drivers/pwm/pwm-apple.c
> @@ -0,0 +1,156 @@
> +// SPDX-License-Identifier: GPL-2.0 OR MIT
> +/*
> + * Driver for the Apple SoC PWM controller
> + *
> + * Copyright The Asahi Linux Contributors
> + *
> + * Limitations:
> + * - The writes to cycle registers are shadowed until a write to
> + *   the control register.
> + * - If both OFF_CYCLES and ON_CYCLES are set to 0, the output
> + *   is a constant off signal.

How does the PWM behave with *APPLE_PWM_CTRLAPPLE_PWM_CTRL =3D 0?
(typically: drives constant low)

> + */
> +
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/pwm.h>
> +#include <linux/io.h>
> +#include <linux/clk.h>
> +#include <linux/math64.h>
> +
> +#define APPLE_PWM_CTRL        0x00
> +#define APPLE_PWM_ON_CYCLES   0x1c
> +#define APPLE_PWM_OFF_CYCLES  0x18
> +
> +#define APPLE_CTRL_ENABLE        BIT(0)
> +#define APPLE_CTRL_MODE          BIT(2)
> +#define APPLE_CTRL_UPDATE        BIT(5)
> +#define APPLE_CTRL_TRIGGER       BIT(9)
> +#define APPLE_CTRL_INVERT        BIT(10)
> +#define APPLE_CTRL_OUTPUT_ENABLE BIT(14)

In reply to v4 I wrote:

| Would be nice if the register prefix would match the register name. That
| is please either rename APPLE_PWM_CONTROL to APPLE_PWM_CTRL or use
| APPLE_PWM_CONTROL as prefix for the bit fields in that register.

well, one of the two options was bogus because it doesn't result in the
intended effect. You picked that broken option :-\
Can you please rename such that the (maybe new) name for APPLE_PWM_CTRL
is a prefix for the (maybe new) APPLE_CTRL_ENABLE and the other register
bit definitions?

> [...]
> +static int apple_pwm_probe(struct platform_device *pdev)
> +{
> +	struct apple_pwm *fpwm;
> +	struct clk *clk;
> +	int ret;
> +
> +	fpwm =3D devm_kzalloc(&pdev->dev, sizeof(*fpwm), GFP_KERNEL);
> +	if (!fpwm)
> +		return -ENOMEM;
> +
> +	fpwm->base =3D devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(fpwm->base))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(fpwm->base), "unable to map m=
mio");

devm_platform_ioremap_resource() already emits an error message if there
is a problem. So please don't add another message here.

> +	clk =3D devm_clk_get_enabled(&pdev->dev, NULL);
> +	if (IS_ERR(clk))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(clk), "unable to get the cloc=
k");
> +
> +	/*
> +	 * uses the 24MHz system clock on all existing devices, can only
> +	 * happen if the device tree is broken
> +	 */
> +	fpwm->clkrate =3D clk_get_rate(clk);
> +	if (fpwm->clkrate > NSEC_PER_SEC)
> +		return dev_err_probe(&pdev->dev, -EINVAL, "pwm clock out of range");

This check is done to prevent an overflow in .apply, right? Please point
that out in a comment.

> +	fpwm->chip.dev =3D &pdev->dev;
> +	fpwm->chip.npwm =3D 1;
> +	fpwm->chip.ops =3D &apple_pwm_ops;
> +
> +	ret =3D devm_pwmchip_add(&pdev->dev, &fpwm->chip);
> +	if (ret < 0)
> +		return dev_err_probe(&pdev->dev, ret, "unable to add pwm chip");
> +
> +	return 0;
> +}
> +
> [...]

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--nhj3lt2xyxvt3eo2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmO972cACgkQwfwUeK3K
7AlyMQf/fr+3quRS974KGObjeliI2qcMCqP2Tq0qjhRCKGwEsHMEFKPg7ixkOJko
oRly+N3zqIs6S+b0eo2MObRMB9ABl3+42m7V5jLiGDiIEJzoBESE1/9XqwgQKISO
p8CgaHZktwFIZoMOTakjuTJA7UNmGnB/JsQaSWnh2pi1qYfE2Ft4U18pTZNcSijv
Eq4oY/3UNZV9+MCtB/EC6g9d3Mvi7fEkLdgp5OVZ4Z0NJqDFUz+klIDIfBiS7n+U
u/heswafcPYiKo88tKKZcC449+1se/kX6+kwDUWIvdp2fKLhaWaX+jlgtCcMs9R7
AUaPg6vD6bqhRtIWGP7r0ZfDO/eH/w==
=Nwbo
-----END PGP SIGNATURE-----

--nhj3lt2xyxvt3eo2--
