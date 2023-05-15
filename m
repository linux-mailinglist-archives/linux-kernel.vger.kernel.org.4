Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2692570410D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 00:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343500AbjEOWjn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 18:39:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231416AbjEOWjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 18:39:41 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C95BA5DA;
        Mon, 15 May 2023 15:39:39 -0700 (PDT)
Received: from mercury (unknown [185.254.75.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 573D366031CE;
        Mon, 15 May 2023 23:39:38 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1684190378;
        bh=6vM/tOGnmSln8Pv6kLk4Nazaz+fmc1Ds2gNBAqt+6QY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DFnrYCBNczfCveW7dnMU+fPv/O26FpDbqbPIpYed+dTvvmEQ+MgMqX5tX0hg9XpvA
         gYUcqumzHphpwrpQFmPiGPln0se6QiGfDu9zGvRozoyONGQcYQjCWB06+NH3zjo3OJ
         NGLoh+zMdz1TV+Wtk1Yfk3yG2OmXHgze2qCtClJ7fQr+hhfwJkdahdx3Bk5QQeHjCR
         hQqHcs00KcPTMU4+p9daYFfLZfgG98ty1X81iXopQUYqQ5ms3r8dK2so63/SCy5W1G
         9tC5PAn1Px/zaRbIzggH7TrjKbJeiGbpPAj79+BJ/MXS5tHIM4ScXuTyYdRgIXEN9l
         oriZFsc2waV7w==
Received: by mercury (Postfix, from userid 1000)
        id 26E0E1060F7F; Tue, 16 May 2023 00:39:36 +0200 (CEST)
Date:   Tue, 16 May 2023 00:39:36 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Svyatoslav Ryhel <clamor95@gmail.com>
Cc:     Iskren Chernev <me@iskren.info>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Matheus Castello <matheus@castello.eng.br>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 4/4] power: max17040: get thermal data from adc if
 available
Message-ID: <20230515223936.fwayzfd77hvgpscy@mercury.elektranox.org>
References: <20230308084419.11934-1-clamor95@gmail.com>
 <20230308084419.11934-5-clamor95@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qf65dea75uga2xk7"
Content-Disposition: inline
In-Reply-To: <20230308084419.11934-5-clamor95@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qf65dea75uga2xk7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Mar 08, 2023 at 10:44:19AM +0200, Svyatoslav Ryhel wrote:
> Since fuel gauge does not support thermal monitoring,
> some vendors may couple this fuel gauge with thermal/adc
> sensor to monitor battery cell exact temperature.
>=20
> Add this feature by adding optional iio thermal channel.
>=20
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  drivers/power/supply/max17040_battery.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>=20
> diff --git a/drivers/power/supply/max17040_battery.c b/drivers/power/supp=
ly/max17040_battery.c
> index 6dfce7b1309e..8c743c26dc6e 100644
> --- a/drivers/power/supply/max17040_battery.c
> +++ b/drivers/power/supply/max17040_battery.c
> @@ -18,6 +18,7 @@
>  #include <linux/of_device.h>
>  #include <linux/regmap.h>
>  #include <linux/slab.h>
> +#include <linux/iio/consumer.h>
> =20
>  #define MAX17040_VCELL	0x02
>  #define MAX17040_SOC	0x04
> @@ -143,6 +144,7 @@ struct max17040_chip {
>  	struct power_supply		*battery;
>  	struct power_supply_battery_info	*batt_info;
>  	struct chip_data		data;
> +	struct iio_channel		*channel_temp;
> =20
>  	/* battery capacity */
>  	int soc;
> @@ -416,6 +418,11 @@ static int max17040_get_property(struct power_supply=
 *psy,
>  	case POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN:
>  		val->intval =3D chip->batt_info->charge_full_design_uah;
>  		break;
> +	case POWER_SUPPLY_PROP_TEMP:
> +		iio_read_channel_raw(chip->channel_temp,
> +				     &val->intval);
> +		val->intval *=3D 10;

return iio_read_channel_processed_scale(chip->channel_temp, &val->intval, 1=
0);

> +		break;
>  	case POWER_SUPPLY_PROP_TEMP_MIN:
>  		if (chip->batt_info->temp_min =3D=3D INT_MIN)
>  			return -ENODATA;
> @@ -452,6 +459,7 @@ static enum power_supply_property max17040_battery_pr=
ops[] =3D {
>  	POWER_SUPPLY_PROP_HEALTH,
>  	POWER_SUPPLY_PROP_ENERGY_FULL_DESIGN,
>  	POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
> +	POWER_SUPPLY_PROP_TEMP,

You should only expose this, if chip->channel_temp is not NULL. Use
devm_kmemdup() to copy the array into a private copy in chip and
modify it on the fly.
   =20
>  	POWER_SUPPLY_PROP_TEMP_MIN,
>  	POWER_SUPPLY_PROP_TEMP_MAX,
>  };
> @@ -560,9 +568,24 @@ static int max17040_probe(struct i2c_client *client)
>  		}
>  	}
> =20
> +	if (of_property_read_bool(client->dev.of_node, "io-channels")) {

device_property_present()

> +		chip->channel_temp =3D iio_channel_get(&client->dev, "temp");

devm_iio_channel_get()

> +		if (IS_ERR(chip->channel_temp))
> +			return dev_err_probe(&client->dev, PTR_ERR(chip->channel_temp),
> +					     "failed to get temp\n");
> +	};

Also this must be acquired before registering the power-supply device.

-- Sebastian

> +
>  	return 0;
>  }
> =20
> +static void max17040_remove(struct i2c_client *client)
> +{
> +	struct max17040_chip *chip =3D i2c_get_clientdata(client);
> +
> +	if (chip->channel_temp)
> +		iio_channel_release(chip->channel_temp);
> +}
> +
>  #ifdef CONFIG_PM_SLEEP
> =20
>  static int max17040_suspend(struct device *dev)
> @@ -642,6 +665,7 @@ static struct i2c_driver max17040_i2c_driver =3D {
>  		.pm	=3D MAX17040_PM_OPS,
>  	},
>  	.probe_new	=3D max17040_probe,
> +	.remove		=3D max17040_remove,
>  	.id_table	=3D max17040_id,
>  };
>  module_i2c_driver(max17040_i2c_driver);
> --=20
> 2.37.2
>=20

--qf65dea75uga2xk7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmRitKQACgkQ2O7X88g7
+poRgBAAoaWYMbFxktJscB6lYr/T3va54JzJqn51XXuvWr1kUghcrL4NPSVlxfWS
MVbgljHERs0DeNmnXTT0cPwBh7q0Bur9Fttn+hsRWN7iHsSb4DCPpZALdNO5f+gI
d+eFiqSPPMm40gOBYn/vyQRVJ4TloU9yeglbCWkA1EKeG0Glg/PtYO3PYiXnkrE8
5LNjRd8+zVyC0S678gDCIp6qhlLWh8vjQoJhxWT51OSnSEUnXSb9G1OO2bXyPiNU
+eqrPfvtpLP5PvYzuJAXoN3tH8wQxZQAgnGZvlvOC3FcvZYZuj6T8OUIVzCWTi5j
sdidzm8sgAdHaQBq7uF7UtWgZU+FzFMZAtWaz73UuQErSqUB5gxaWS4jNU3ij92M
ZgPop+nwTSWfW8bpd5ozmKoPqxdBghO3K02DdgPk2sAzWg/G6B5vDP2swDosgiX1
Y5MMwYUQB1zPF01o6T0JEEapvqwWqNGE5i+0QBD8thqezFDZVrxlE95sAcwU6au2
JKmqBsUppYR1qBhJFOhkmrpaYBMxBQpXiioUr5VLjoOX7dqDQOkDzWA783iAVMFS
0NqdCv8VyTyDUUb/1asqaWZZ+YGhml4LYY/R8aJ89MczGEpgcEo8j3XStxSASzTz
hsXURUNYifNWvPH0xWYEzNLsIBsnwpgFYi/SqpWNn+1tI8H7LJ8=
=+09U
-----END PGP SIGNATURE-----

--qf65dea75uga2xk7--
