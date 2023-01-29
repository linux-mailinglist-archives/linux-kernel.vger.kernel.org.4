Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3C56680323
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 00:47:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234930AbjA2XrM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 18:47:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbjA2XrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 18:47:11 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E22B18B13;
        Sun, 29 Jan 2023 15:47:09 -0800 (PST)
Received: from mercury (unknown [185.209.196.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D50D56600869;
        Sun, 29 Jan 2023 23:47:07 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1675036027;
        bh=wVdCDbX//15XU9SAoM/QArO9BYUKf7pmj9SJ+DPb7EY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Jsq3ArveKi07WigNpRneAJWQ0F0xAr5dvfhqyWsesBpPfjfYw7+nrbY9/74XGxesR
         hbApfcnCiUx1Ul0rbZ9DyinxgvpEcuLt+UFZ1FNDsDK1wVY/+CF8Ih6Ax2DzB+7iAE
         2T5WKKqfo4VxVRSzmPy/qyK8YO+X1FoLDFn6u44wQFLtUt1h9DV7uXkKsI+LvadpWh
         +Snqy4Sz/OZr2W4HQZN5BA6XOkgb768m8JaHZb1rnKmEKDGFiBpOl9BWnrKzmAUs3J
         adbYVVUBvDTKq7TdKsyxuBIg2guMPg0xKKG9vTx+DeDywn9nqpN63bfxeGYkz3EFEx
         Bo26KI8jj2fSA==
Received: by mercury (Postfix, from userid 1000)
        id 2F0831060A24; Mon, 30 Jan 2023 00:47:05 +0100 (CET)
Date:   Mon, 30 Jan 2023 00:47:05 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Subject: Re: [PATCH v2] power: reset: add Odroid Go Ultra poweroff driver
Message-ID: <20230129234705.djmoir4wsshoptwo@mercury.elektranox.org>
References: <20230126-b4-odroid-go-ultra-poweroff-v2-1-a8c50866f4ac@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bv2xur4blb3a3f77"
Content-Disposition: inline
In-Reply-To: <20230126-b4-odroid-go-ultra-poweroff-v2-1-a8c50866f4ac@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bv2xur4blb3a3f77
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jan 26, 2023 at 06:11:21PM +0100, Neil Armstrong wrote:
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
> Changes in v2:
> - Switched to devm_register_sys_off_handler()
> - Link to v1: https://lore.kernel.org/r/20221031-b4-odroid-go-ultra-initi=
al-v1-2-42e3dbea86d5@linaro.org
> ---
>  drivers/power/reset/Kconfig                    |   7 ++
>  drivers/power/reset/Makefile                   |   1 +
>  drivers/power/reset/odroid-go-ultra-poweroff.c | 151 +++++++++++++++++++=
++++++
>  3 files changed, 159 insertions(+)
>=20
> diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
> index a8c46ba5878f..26860c2e05a9 100644
> --- a/drivers/power/reset/Kconfig
> +++ b/drivers/power/reset/Kconfig
> @@ -141,6 +141,13 @@ config POWER_RESET_OCELOT_RESET
>  	help
>  	  This driver supports restart for Microsemi Ocelot SoC and similar.
> =20
> +config POWER_RESET_ODROID_GO_ULTRA_POWEROFF
> +	bool "Odroid Go Ultra power-off driver"
> +	depends on ARCH_MESON || COMPILE_TEST
> +	depends on MFD_RK808

You are not accessing any symbols from the MFD driver, so you can
append "|| COMPILE_TEST".

It will be fun to coordinate the merging, because of my series
renaming it to MFD_RK8XX :/

https://lore.kernel.org/all/20230127181244.160887-1-sebastian.reichel@colla=
bora.com/

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
> index 000000000000..51f54e65c927
> --- /dev/null
> +++ b/drivers/power/reset/odroid-go-ultra-poweroff.c
> @@ -0,0 +1,151 @@
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
> +	struct rk808 *rk817;
> +	struct rk808 *rk818;
> +};
> +
> +static int odroid_go_ultra_poweroff_prepare(struct sys_off_data *data)
> +{
> +	struct odroid_go_ultra_poweroff_data *poweroff_data =3D data->cb_data;
> +	int ret;
> +
> +	dev_info(poweroff_data->dev, "Setting PMICs for power off");
> +
> +	/* RK817 */
> +	ret =3D regmap_update_bits(poweroff_data->rk817->regmap, RK817_SYS_CFG(=
3), DEV_OFF, DEV_OFF);
> +	if (ret) {
> +		dev_err(poweroff_data->dev, "failed to poweroff rk817\n");
> +		return notifier_from_errno(ret);
> +	}
> +
> +	/* RK818 */
> +	ret =3D regmap_update_bits(poweroff_data->rk818->regmap, RK818_DEVCTRL_=
REG, DEV_OFF, DEV_OFF);
> +	if (ret) {
> +		dev_err(poweroff_data->dev, "failed to poweroff rk818\n");
> +		return notifier_from_errno(ret);
> +	}
> +
> +	return NOTIFY_OK;
> +}
> +
> +static int odroid_go_ultra_poweroff_get_pmic_drvdata(const char *compati=
ble, struct rk808 **pmic)
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
> +	*pmic =3D i2c_get_clientdata(pmic_client);

You are only using the regmap, so you can skip the rk808 struct step
and directly get and store the regmap:

*pmic =3D dev_get_regmap(&pmic_client->dev, NULL);

> +	put_device(&pmic_client->dev);

Technically this allows releasing the PMIC device with the poweroff
driver still probed. I guess it's mostly a theoretical thing in this
case, but people tend to cargo copy. I suggest to store the struct
device handle in odroid_go_ultra_poweroff_data and then use
dev_get_regmap() in the poweroff handler. Finally add a put_device()
via devm_add_action_or_reset().

> +	if (!*pmic)
> +		return -EPROBE_DEFER;
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
> +	/* RK818 */
> +	ret =3D odroid_go_ultra_poweroff_get_pmic_drvdata("rockchip,rk818",
> +							&poweroff_data->rk818);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret, "failed to get rk818 mfd data\n"=
);
> +
> +	/* RK817 */
> +	ret =3D odroid_go_ultra_poweroff_get_pmic_drvdata("rockchip,rk817",
> +							&poweroff_data->rk817);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret, "failed to get rk817 mfd data\n"=
);
> +
> +	/* Register as SYS_OFF_MODE_POWER_OFF_PREPARE because regmap_update_bit=
s may sleep */
> +	ret =3D devm_register_sys_off_handler(&pdev->dev,
> +					    SYS_OFF_MODE_POWER_OFF_PREPARE,
> +					    SYS_OFF_PRIO_DEFAULT,
> +					    odroid_go_ultra_poweroff_prepare,
> +					    poweroff_data);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret, "failed to register sys-off hand=
ler\n");
> +
> +	dev_info(&pdev->dev, "Registered Power-Off handler\n");
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
> +	return PTR_ERR_OR_ZERO(pdev);

This is missing platform_driver_unregister() in the error path.

> +}
> +
> +static void __exit odroid_go_ultra_poweroff_exit(void)
> +{

if (!of_device_is_compatible(of_root, "hardkernel,odroid-go-ultra"))
		return;

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

Thanks,

-- Sebastian

--bv2xur4blb3a3f77
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmPXBW0ACgkQ2O7X88g7
+pp/XxAAirA9/9utQHFjr+MqxNOEj+6O8473x58ks602hPEY9x+HjY9AOhUyowYG
B3IUWaW3lLItIiMzNmmCU3oy7L5Px2Lg3WsL52AKHBTSFRX34MDMKekA6D+sgfkn
eB4G0bVthOlI9OZrnUicbmS4KY2fgcAf5o1ccoNsUmK382la/c9Dh2SFA8SIacUE
gHR7LwHDSx1S9T43JU3mnY92n/KrDwHZVPMze+rsCwbAYsy9RrHmbbRQg39/p2/b
VeBbhqdrD8XJ8iBJxQS3byUxxPqad3Vb0Y0tdN30gCvFWWHheDXVE4L42cTbmSoQ
xoDeDNB761YId0K8YuOxw3hbtx0q7Q1v5/ezJT1ky+vMSs0fnLhQOd7QqJfkKGiJ
5rPCl63B7pECxI0Pei8RSL3DfPI32uLbe3ub/CPIo512r6zGBT4jNwvM4hcKMPP6
0ZpeH0S4B6uaVgvBrJXlVPYOS2II9nT0IfpiAuIscqh7QNTTHa7uGa51F7ObDYhr
jEix1vVHfUIYqsM3hPRY/6EOrV3OnEWjluDyfFmswMle+E4/D+tRZokTHAUDL9iM
aHgHTT3FK3CrqPEkw71623wdSs3+QYwTngN3O9iABdirM+OEz7Edyf0xuJ1kknhS
NAmNiQf6UHd2dm+LWIdYQcaNzxv6H3/uSDykb3CWZHWvDoH9jr8=
=MaHe
-----END PGP SIGNATURE-----

--bv2xur4blb3a3f77--
