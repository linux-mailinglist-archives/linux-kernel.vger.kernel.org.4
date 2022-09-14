Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B9795B8D7A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 18:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbiINQrp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 12:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbiINQrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 12:47:37 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61A57844C1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 09:47:30 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oYVXm-0008JN-GU; Wed, 14 Sep 2022 18:47:22 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oYVXm-000jK6-KY; Wed, 14 Sep 2022 18:47:21 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oYVXk-000uI3-Hc; Wed, 14 Sep 2022 18:47:20 +0200
Date:   Wed, 14 Sep 2022 18:47:20 +0200
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
Subject: Re: [RFC v4 08/10] pwm: dwc: add of/platform support
Message-ID: <20220914164720.bjh6tqw6zb66vsyz@pengutronix.de>
References: <20220816211454.237751-1-ben.dooks@sifive.com>
 <20220816211454.237751-9-ben.dooks@sifive.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vrox3ufov6gdtdde"
Content-Disposition: inline
In-Reply-To: <20220816211454.237751-9-ben.dooks@sifive.com>
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


--vrox3ufov6gdtdde
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 16, 2022 at 10:14:52PM +0100, Ben Dooks wrote:
> The dwc pwm controller can be used in non-PCI systems, so allow
> either platform or OF based probing.
>=20
> Signed-off-by: Ben Dooks <ben.dooks@sifive.com>
> ---
> v4:
>  - split the of code out of the core
>  - moved the compile test code earlier
>  - fixed review comments
>   - used NS_PER_SEC
>   - use devm_clk_get_enabled
> v3:
>  - changed compatible name
> ---
>  drivers/pwm/Kconfig      |  9 +++++
>  drivers/pwm/Makefile     |  1 +
>  drivers/pwm/pwm-dwc-of.c | 78 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 88 insertions(+)
>  create mode 100644 drivers/pwm/pwm-dwc-of.c
>=20
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index a9f1c554db2b..f1735653365f 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -192,6 +192,15 @@ config PWM_DWC_PCI
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm-dwc-pci.
> =20
> +config PWM_DWC_OF
> +	tristate "DesignWare PWM Controller (OF bus)
> +	depends on PWM_DWC && OF
> +	help
> +	  PWM driver for Synopsys DWC PWM Controller on an OF bus.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called pwm-dwc-of.
> +
>  config PWM_EP93XX
>  	tristate "Cirrus Logic EP93xx PWM support"
>  	depends on ARCH_EP93XX || COMPILE_TEST
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index a70d36623129..d1fd1641f077 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -15,6 +15,7 @@ obj-$(CONFIG_PWM_CLPS711X)	+=3D pwm-clps711x.o
>  obj-$(CONFIG_PWM_CRC)		+=3D pwm-crc.o
>  obj-$(CONFIG_PWM_CROS_EC)	+=3D pwm-cros-ec.o
>  obj-$(CONFIG_PWM_DWC)		+=3D pwm-dwc.o
> +obj-$(CONFIG_PWM_DWC_OF)	+=3D pwm-dwc-of.o
>  obj-$(CONFIG_PWM_DWC_PCI)	+=3D pwm-dwc-pci.o
>  obj-$(CONFIG_PWM_EP93XX)	+=3D pwm-ep93xx.o
>  obj-$(CONFIG_PWM_FSL_FTM)	+=3D pwm-fsl-ftm.o
> diff --git a/drivers/pwm/pwm-dwc-of.c b/drivers/pwm/pwm-dwc-of.c
> new file mode 100644
> index 000000000000..d18fac287325
> --- /dev/null
> +++ b/drivers/pwm/pwm-dwc-of.c
> @@ -0,0 +1,78 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * DesignWare PWM Controller driver OF
> + *
> + * Copyright (C) 2022 SiFive, Inc.
> + */
> +
> +#include <linux/bitops.h>
> +#include <linux/export.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/clk.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/pwm.h>
> +#include <linux/io.h>
> +
> +#include "pwm-dwc.h"
> +
> +static int dwc_pwm_plat_probe(struct platform_device *pdev)
> +{
> +	struct device *dev =3D &pdev->dev;
> +	struct dwc_pwm *dwc;
> +	int ret;
> +
> +	dwc =3D dwc_pwm_alloc(dev);
> +	if (!dwc)
> +		return -ENOMEM;
> +
> +	dwc->base =3D devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(dwc->base))
> +		return dev_err_probe(dev, PTR_ERR(dwc->base),
> +				     "failed to map IO\n");

devm_platform_ioremap_resource() already emits an error message.

> +
> +	dwc->clk =3D devm_clk_get_enabled(dev, "timer");
> +	if (IS_ERR(dwc->clk))
> +		return dev_err_probe(dev, PTR_ERR(dwc->clk),
> +				     "failed to get timer clock\n");
> +
> +	clk_prepare_enable(dwc->clk);

You don't need clk_prepare_enable() as you used devm_clk_get_enabled().

(Otherwise, when keeping clk_prepare_enable() you need to check the
return value.)

> +	dwc->clk_ns =3D NSEC_PER_SEC / clk_get_rate(dwc->clk);

I think I already pointed out this is non-optimal.

Later you use clk_ns in __dwc_pwm_configure_timer():

	tmp =3D DIV_ROUND_CLOSEST_ULL(state->duty_cycle, dwc->clk_ns);

So what you really want here is:

	tmp =3D DIV_ROUND_CLOSEST_ULL(state->duty_cycle * clk_get_rate(dwc->clk), =
NSEC_PER_SEC);

With for example clk_get_rate(dwc->clk) =3D 201171875 and duty_cycle =3D
4096 you now get clk_ns =3D 4 (while the exact value is 4.97087..), tmp =3D
1024, while the exact value is 824.

So the idea is to add a clkrate member to the private driver struct, let
it default to 100000000 for the pci case and use the line I suggested
above.

> +
> +	ret =3D devm_pwmchip_add(dev, &dwc->chip);
> +	if (ret)
> +		return ret;
> +
> +	return 0;

This is equivalent to

	return ret;

> +}
> +
> +static int dwc_pwm_plat_remove(struct platform_device *pdev)
> +{
> +	struct dwc_pwm *dwc =3D platform_get_drvdata(pdev);
> +
> +	clk_disable_unprepare(dwc->clk);
> +	return 0;
> +}

When dropping clk_prepare_enable() the .remove callback can go away,
too.

> +
> +static const struct of_device_id dwc_pwm_dt_ids[] =3D {
> +	{ .compatible =3D "snps,dw-apb-timers-pwm2" },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, dwc_pwm_dt_ids);
> +
> +static struct platform_driver dwc_pwm_plat_driver =3D {
> +	.driver =3D {
> +		.name		=3D "dwc-pwm",
> +		.of_match_table  =3D dwc_pwm_dt_ids,
> +	},
> +	.probe	=3D dwc_pwm_plat_probe,
> +	.remove	=3D dwc_pwm_plat_remove,
> +};
> +
> +module_platform_driver(dwc_pwm_plat_driver);
> +
> +MODULE_ALIAS("platform:dwc-pwm-of");
> +MODULE_AUTHOR("Ben Dooks <ben.dooks@sifive.com>");
> +MODULE_DESCRIPTION("DesignWare PWM Controller");
> +MODULE_LICENSE("GPL");

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--vrox3ufov6gdtdde
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmMiBZUACgkQwfwUeK3K
7AnUEAf8DFcFvAocXFQ0aMZh9EkwREAF7JEemItwF1/YrUeR+Xz1IHCm98kt5Xjw
QzhyguClvQwxABq9mYryRYG7zf/7jw9KAyI/zScuUzpCS6rrLiEKiG66EgkA3gdp
v/uHc2QMr/03l+D0tgJkxOhgN8FLdx9264oOnvhDqRzkLSEnN4xDTK+4CpIJuSZZ
o1DfHKWejBTD2WM3KEraacvjc4hlgobIB+B3C5jFmXx6h+hWCt4SptPK0HRjMSOw
x/e9e5boXikSD9cG0PgpuuNMiwfgPwarER+Io/BgDKWA1f95PA5EzZDogJmGdX0W
iT9ULfqDkYQsDnmLLZNXjLBXC1EfNQ==
=LGzt
-----END PGP SIGNATURE-----

--vrox3ufov6gdtdde--
