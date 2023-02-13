Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD97C695216
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 21:43:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbjBMUnD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 15:43:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbjBMUnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 15:43:00 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5333814207;
        Mon, 13 Feb 2023 12:42:56 -0800 (PST)
Received: from mercury (unknown [185.209.196.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B07146602158;
        Mon, 13 Feb 2023 20:42:51 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676320971;
        bh=hEGAMQG8C31QWPd+UGPA4AN/5pu062Q8cho3gBhFd1I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fad4qpIsqRfdnfKEmLNV8GcsADY29hTEIapDIhrs5JkIYcyWlcrKvCBh64UbihRTM
         jgvIK5b1z735t88mxk2S67jlwqdoF7dUSLnz/gsZ8AG0SGS8Soed4zypT7ifrYyce0
         cpyeWpTbzB0cHNU2FrTaT6WWqMdjmhAJugnr0jD0X8dc685YQMMD1AHPnvCnK4hmq+
         ytvS138b0KIidgw9BhllxwW22cdb3d4IOJGt3e0kM9FL6b9dVjD7F8w3ZdLQ5TeVMd
         8zR3y9zXiIL+fZsZxyMeC6NGDIEY2VwnVpVdPM6P/4Af3HtBSa//H0WSHyTxS5OC3k
         BEIA0gw4x7PrQ==
Received: by mercury (Postfix, from userid 1000)
        id 28B701060961; Mon, 13 Feb 2023 21:42:49 +0100 (CET)
Date:   Mon, 13 Feb 2023 21:42:49 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Subject: Re: [PATCH v3] power: reset: add Odroid Go Ultra poweroff driver
Message-ID: <20230213204249.nj5snnoezwobquon@mercury.elektranox.org>
References: <20230126-b4-odroid-go-ultra-poweroff-v3-1-0a7fd3d5c4b3@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fyn3jskcfoowlt3u"
Content-Disposition: inline
In-Reply-To: <20230126-b4-odroid-go-ultra-poweroff-v3-1-0a7fd3d5c4b3@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fyn3jskcfoowlt3u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Feb 10, 2023 at 11:03:36AM +0100, Neil Armstrong wrote:
> The Hardkernel Odroid Go Ultra poweroff scheme requires requesting a powe=
roff
> to its two PMICs in order, this represents the poweroff scheme needed to =
complete
> a clean poweroff of the system.
>=20
> This implement this scheme by implementing a self registering driver to p=
ermit
> using probe defer until both pmics are finally probed.
>=20
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
> Previous submission was at [1], but I converted it to an independent
> platform device with device auto registration to permit waiting for
> both the PMICs drivers to probe.
>=20
> [1] https://lore.kernel.org/all/20221031-b4-odroid-go-ultra-initial-v1-2-=
42e3dbea86d5@linaro.org/
> ---
> Changes in v3:
> - Removed dependency with rk08
> - Switched to storing struct device of pmics
> - Fixed module init/exit
> - Link to v2: https://lore.kernel.org/r/20230126-b4-odroid-go-ultra-power=
off-v2-1-a8c50866f4ac@linaro.org
>=20
> Changes in v2:
> - Switched to devm_register_sys_off_handler()
> - Link to v1: https://lore.kernel.org/r/20221031-b4-odroid-go-ultra-initi=
al-v1-2-42e3dbea86d5@linaro.org
> ---
>  drivers/power/reset/Kconfig                    |   7 +
>  drivers/power/reset/Makefile                   |   1 +
>  drivers/power/reset/odroid-go-ultra-poweroff.c | 193 +++++++++++++++++++=
++++++
>  3 files changed, 201 insertions(+)
>=20
> diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
> index a8c46ba5878f..a47ef7a9fc13 100644
> --- a/drivers/power/reset/Kconfig
> +++ b/drivers/power/reset/Kconfig
> @@ -141,6 +141,13 @@ config POWER_RESET_OCELOT_RESET
>  	help
>  	  This driver supports restart for Microsemi Ocelot SoC and similar.
> =20
> +config POWER_RESET_ODROID_GO_ULTRA_POWEROFF
> +	bool "Odroid Go Ultra power-off driver"
> +	depends on ARCH_MESON || COMPILE_TEST
> +	depends on OF
> +	help
> +	  This driver supports Power off for Odroid Go Ultra device.
> +
>  config POWER_RESET_OXNAS
>  	bool "OXNAS SoC restart driver"
>  	depends on ARCH_OXNAS
> diff --git a/drivers/power/reset/Makefile b/drivers/power/reset/Makefile
> index 0a39424fc558..d763e6735ee3 100644
> --- a/drivers/power/reset/Makefile
> +++ b/drivers/power/reset/Makefile
> @@ -17,6 +17,7 @@ obj-$(CONFIG_POWER_RESET_MT6323) +=3D mt6323-poweroff.o
>  obj-$(CONFIG_POWER_RESET_OXNAS) +=3D oxnas-restart.o
>  obj-$(CONFIG_POWER_RESET_QCOM_PON) +=3D qcom-pon.o
>  obj-$(CONFIG_POWER_RESET_OCELOT_RESET) +=3D ocelot-reset.o
> +obj-$(CONFIG_POWER_RESET_ODROID_GO_ULTRA_POWEROFF) +=3D odroid-go-ultra-=
poweroff.o
>  obj-$(CONFIG_POWER_RESET_PIIX4_POWEROFF) +=3D piix4-poweroff.o
>  obj-$(CONFIG_POWER_RESET_LTC2952) +=3D ltc2952-poweroff.o
>  obj-$(CONFIG_POWER_RESET_QNAP) +=3D qnap-poweroff.o
> diff --git a/drivers/power/reset/odroid-go-ultra-poweroff.c b/drivers/pow=
er/reset/odroid-go-ultra-poweroff.c
> new file mode 100644
> index 000000000000..30a005088fbe
> --- /dev/null
> +++ b/drivers/power/reset/odroid-go-ultra-poweroff.c
> @@ -0,0 +1,193 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (c) 2023 Neil Armstrong <neil.armstrong@linaro.org>
> + */
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/of_platform.h>
> +#include <linux/mfd/rk808.h>
> +#include <linux/regmap.h>
> +#include <linux/module.h>
> +#include <linux/reboot.h>
> +#include <linux/i2c.h>
> +
> +/*
> + * The Odroid Go Ultra has 2 PMICs:
> + * - RK818 (manages the battery and USB-C power supply)
> + * - RK817
> + * Both PMICs feeds power to the S922X SoC, so they must be powered-off =
in sequence.
> + * Vendor does power-off the RK817 first, then the RK818 so here we foll=
ow this sequence.
> + */
> +
> +struct odroid_go_ultra_poweroff_data {
> +	struct device *dev;
> +	struct device *rk817;
> +	struct device *rk818;
> +};
> +
> +static int odroid_go_ultra_poweroff_prepare(struct sys_off_data *data)
> +{
> +	struct odroid_go_ultra_poweroff_data *poweroff_data =3D data->cb_data;
> +	struct regmap *rk817, *rk818;
> +	int ret;
> +
> +	/* RK817 Regmap */
> +	rk817 =3D dev_get_regmap(poweroff_data->rk817, NULL);
> +	if (!rk817) {
> +		dev_err(poweroff_data->dev, "failed to get rk817 regmap\n");
> +		return notifier_from_errno(-EINVAL);
> +	}
> +
> +	/* RK818 Regmap */
> +	rk818 =3D dev_get_regmap(poweroff_data->rk818, NULL);
> +	if (!rk818) {
> +		dev_err(poweroff_data->dev, "failed to get rk818 regmap\n");
> +		return notifier_from_errno(-EINVAL);
> +	}
> +
> +	dev_info(poweroff_data->dev, "Setting PMICs for power off");
> +
> +	/* RK817 */
> +	ret =3D regmap_update_bits(rk817, RK817_SYS_CFG(3), DEV_OFF, DEV_OFF);
> +	if (ret) {
> +		dev_err(poweroff_data->dev, "failed to poweroff rk817\n");
> +		return notifier_from_errno(ret);
> +	}
> +
> +	/* RK818 */
> +	ret =3D regmap_update_bits(rk818, RK818_DEVCTRL_REG, DEV_OFF, DEV_OFF);
> +	if (ret) {
> +		dev_err(poweroff_data->dev, "failed to poweroff rk818\n");
> +		return notifier_from_errno(ret);
> +	}
> +
> +	return NOTIFY_OK;
> +}
> +
> +static int odroid_go_ultra_poweroff_get_pmic_device(const char *compatib=
le, struct device **pmic)
> +{
> +	struct device_node *pmic_node;
> +	struct i2c_client *pmic_client;
> +
> +	pmic_node =3D of_find_compatible_node(NULL, NULL, compatible);
> +	if (!pmic_node)
> +		return -ENODEV;
> +
> +	pmic_client =3D of_find_i2c_device_by_node(pmic_node);
> +	of_node_put(pmic_node);
> +	if (!pmic_client)
> +		return -EPROBE_DEFER;
> +
> +	*pmic =3D &pmic_client->dev;
> +
> +	return 0;
> +}
> +
> +static int odroid_go_ultra_poweroff_probe(struct platform_device *pdev)
> +{
> +	struct odroid_go_ultra_poweroff_data *poweroff_data;
> +	int ret;
> +
> +	poweroff_data =3D devm_kzalloc(&pdev->dev, sizeof(*poweroff_data), GFP_=
KERNEL);
> +	if (!poweroff_data)
> +		return -ENOMEM;
> +
> +	dev_set_drvdata(&pdev->dev, poweroff_data);
> +
> +	/* RK818 PMIC Device */
> +	ret =3D odroid_go_ultra_poweroff_get_pmic_device("rockchip,rk818",
> +						       &poweroff_data->rk818);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret, "failed to get rk818 mfd data\n"=
);
> +
> +	/* RK817 PMIC Device */
> +	ret =3D odroid_go_ultra_poweroff_get_pmic_device("rockchip,rk817",
> +						       &poweroff_data->rk817);
> +	if (ret) {
> +		ret  =3D dev_err_probe(&pdev->dev, ret, "failed to get rk817 mfd data\=
n");
> +		goto put_rk818_device;
> +	}
> +
> +	/* Register as SYS_OFF_MODE_POWER_OFF_PREPARE because regmap_update_bit=
s may sleep */
> +	ret =3D devm_register_sys_off_handler(&pdev->dev,
> +					    SYS_OFF_MODE_POWER_OFF_PREPARE,
> +					    SYS_OFF_PRIO_DEFAULT,
> +					    odroid_go_ultra_poweroff_prepare,
> +					    poweroff_data);
> +	if (ret) {
> +		ret =3D dev_err_probe(&pdev->dev, ret, "failed to register sys-off han=
dler\n");
> +		goto put_rk817_device;
> +	}

Allocating managed resources after a traditional allocation always
rings an alarm bell. The problem is, that the order at removal time
will not be the reverse of the allocation chain in this case.

You can fix this by handling the put_device for rk817 and rk818 via
devm_add_action_or_reset() (preferred by me) or by switching
devm_register_sys_off_handler() to register_sys_off_handler.

Otherwise the driver LGTM.

-- Sebastian

> +
> +	dev_info(&pdev->dev, "Registered Power-Off handler\n");
> +
> +	return 0;
> +
> +put_rk817_device:
> +	put_device(poweroff_data->rk817);
> +
> +put_rk818_device:
> +	put_device(poweroff_data->rk818);
> +
> +	return ret;
> +}
> +
> +static int odroid_go_ultra_poweroff_remove(struct platform_device *pdev)
> +{
> +	struct odroid_go_ultra_poweroff_data *poweroff_data =3D dev_get_drvdata=
(&pdev->dev);
> +
> +	put_device(poweroff_data->rk818);
> +	put_device(poweroff_data->rk817);
> +
> +	return 0;
> +}
> +
> +static struct platform_device *pdev;
> +
> +static struct platform_driver odroid_go_ultra_poweroff_driver =3D {
> +	.driver =3D {
> +		.name	=3D "odroid-go-ultra-poweroff",
> +	},
> +	.probe =3D odroid_go_ultra_poweroff_probe,
> +	.remove =3D odroid_go_ultra_poweroff_remove,
> +};
> +
> +static int __init odroid_go_ultra_poweroff_init(void)
> +{
> +	int ret;
> +
> +	/* Only create when running on the Odroid Go Ultra device */
> +	if (!of_device_is_compatible(of_root, "hardkernel,odroid-go-ultra"))
> +		return -ENODEV;
> +
> +	ret =3D platform_driver_register(&odroid_go_ultra_poweroff_driver);
> +	if (ret)
> +		return ret;
> +
> +	pdev =3D platform_device_register_resndata(NULL, "odroid-go-ultra-power=
off", -1,
> +						 NULL, 0, NULL, 0);
> +
> +	if (IS_ERR(pdev)) {
> +		platform_driver_unregister(&odroid_go_ultra_poweroff_driver);
> +		return PTR_ERR(pdev);
> +	}
> +
> +	return 0;
> +}
> +
> +static void __exit odroid_go_ultra_poweroff_exit(void)
> +{
> +	/* Only delete when running on the Odroid Go Ultra device */
> +	if (!of_device_is_compatible(of_root, "hardkernel,odroid-go-ultra"))
> +		return;
> +
> +	platform_device_unregister(pdev);
> +	platform_driver_unregister(&odroid_go_ultra_poweroff_driver);
> +}
> +
> +module_init(odroid_go_ultra_poweroff_init);
> +module_exit(odroid_go_ultra_poweroff_exit);
> +
> +MODULE_AUTHOR("Neil Armstrong <neil.armstrong@linaro.org>");
> +MODULE_DESCRIPTION("Odroid Go Ultra poweroff driver");
> +MODULE_LICENSE("GPL");
>=20
> ---
> base-commit: 38d2b86a665b5e86371a1a30228bce259aa6c101
> change-id: 20230126-b4-odroid-go-ultra-poweroff-c8fdca93f3eb
>=20
> Best regards,
> --=20
> Neil Armstrong <neil.armstrong@linaro.org>
>=20

--fyn3jskcfoowlt3u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmPqoMUACgkQ2O7X88g7
+pr0uw//WgE006DuNmNju2Q6J7mTAMzN0N+4fPDMEAnvAXArFpeRrilt3iuQJamM
DKUXNBTjZa9xm8u4ImfF7/ihfUbU1t7gEH0I29tn9QLUbS1RAfAhb8TGx2aKq+pj
/+DeUqoAJ+d1CVuOu+PU6WhnqaPhXwXvZCBdXWlw901ZVeNofkfQ6SCsPVnYBA/j
fl2Z1rHSeozYbRSL/PXl0syOftF1aDWtEH2nFjp8g+XJNUcuKgxIGkmUBmUrL9i4
qlqDx5jHkrH3DFBD+OuCJjiOTIHlktzF7hjuXS8mGdXaJqWSu3KUfYEO3FeHX9VJ
qij8TrftlPsStc134tVn1I4jeq7/3DuvTjb1wTUtoY8xtMXem3QSMDG1xjoi/ykB
uoYJ3NwHd356L5+QirzL+scidasGApMDmfSC0Dvb3r0ytROw0LWS+w3nk0b7UuOi
l86dMxeIkANhvgO9zYMn4F/KPGVEDfN74zyzwr/0qPi89c81e00nsP2PUxLkzTPj
lZNAX8EHyHaRrNz3hsrYDKNKObRlBbl5NX2uwXvu27GdS0NXI34TiAsQLRUMC0QN
5uylIRBg1nmq/jz1Dd9WbtmjvMA6JK3q39U8NE770DyIufDBhx1uaBlSqaMnL108
49yg+GlqFP2kePGfuq+aFxIItsmOm0zS6TzRdMFk4tW5+xqrAMU=
=Joye
-----END PGP SIGNATURE-----

--fyn3jskcfoowlt3u--
