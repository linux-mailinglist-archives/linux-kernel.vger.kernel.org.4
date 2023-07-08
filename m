Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D491374BDC8
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 16:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230454AbjGHOTU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 10:19:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjGHOTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 10:19:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16DE9170F;
        Sat,  8 Jul 2023 07:19:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A962A60C98;
        Sat,  8 Jul 2023 14:19:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2AC5C433C7;
        Sat,  8 Jul 2023 14:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688825956;
        bh=obibsx/JGl5slXu0QUFvJaKyO31+ka5zkOld73J0s1E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=iAQv4Djf/AZ2RglDt7xtuGmYiqhGaP1kBkO8ZvlZ6ZSsbPNW+vhRYafWEvbKiQvYM
         TzpdN6tiSASsya0c8wI5fafINeRSS7aO+ktD8xjd4hctt0zCOKWMo3/car08LgkcJw
         plrsU3cfen6W1vGkpVjQ6nSqVCgvShzBaJ7zGV3AvNP5FWIj+H4BKVvmDe4++aHGFv
         DXDlfhIkF0O82U+GLw0Itfo8EasBt8nddpEfXxim6/21ZyI1oVJ5DghojnNAjOo5FS
         kglAylaCIwPdE/1x5ikgjK/VZXbpwK3O7jG+dImGj3kD9Bs8HP7BKIfS+j5dLYulFz
         FWu8TyaLoF3Mg==
Date:   Sat, 8 Jul 2023 15:19:12 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alvin =?UTF-8?B?xaBpcHJhZ2E=?= <alvin@pqrs.dk>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Marc Titinger <mtitinger@baylibre.com>,
        Alvin =?UTF-8?B?xaBpcHJhZ2E=?= <alsi@bang-olufsen.dk>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ina2xx: avoid NULL pointer dereference on OF
 device match
Message-ID: <20230708151912.7f5fd378@jic23-huawei>
In-Reply-To: <20230619141239.2257392-1-alvin@pqrs.dk>
References: <20230619141239.2257392-1-alvin@pqrs.dk>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Jun 2023 16:12:39 +0200
Alvin =C5=A0ipraga <alvin@pqrs.dk> wrote:

> From: Alvin =C5=A0ipraga <alsi@bang-olufsen.dk>
>=20
> The affected lines were resulting in a NULL pointer dereference on our
> platform because the device tree contained the following list of
> compatible strings:
>=20
>     power-sensor@40 {
>         compatible =3D "ti,ina232", "ti,ina231";
>         ...
>     };
>=20
> Since the driver doesn't declare a compatible string "ti,ina232", the OF
> matching succeeds on "ti,ina231". But the I2C device ID info is
> populated via the first compatible string, cf. modalias population in
> of_i2c_get_board_info(). Since there is no "ina232" entry in the legacy
> I2C device ID table either, the struct i2c_device_id *id pointer in the
> probe function is NULL.
>=20
> Fix this by using the already populated type variable instead, which
> points to the proper driver data. Since the name is also wanted, add a
> generic one to the ina2xx_config table.
>=20
> Signed-off-by: Alvin =C5=A0ipraga <alsi@bang-olufsen.dk>
> Fixes: c43a102e67db ("iio: ina2xx: add support for TI INA2xx Power Monito=
rs")

Ouch.  We've cleaned a bunch of these up over the years but I guess this
one got through because it did define the data in both id tables so we didn=
't
notice it still assumed id was set.

I'd forgotten this was one of the rare drivers where we have a driver in bo=
th
hwmon and IIO for the same devices.  So any binding update to include the n=
ew
part (making the fallback compatible explicit as well) would need to be in =
the
binding under hwmon.

Applied this as a fix to the fixes-togreg branch of iio.git and marked it f=
or
stable.

Thanks,

Jonathan


> ---
>  drivers/iio/adc/ina2xx-adc.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ina2xx-adc.c b/drivers/iio/adc/ina2xx-adc.c
> index 213526c1592f..aea83f369437 100644
> --- a/drivers/iio/adc/ina2xx-adc.c
> +++ b/drivers/iio/adc/ina2xx-adc.c
> @@ -124,6 +124,7 @@ static const struct regmap_config ina2xx_regmap_confi=
g =3D {
>  enum ina2xx_ids { ina219, ina226 };
> =20
>  struct ina2xx_config {
> +	const char *name;
>  	u16 config_default;
>  	int calibration_value;
>  	int shunt_voltage_lsb;	/* nV */
> @@ -155,6 +156,7 @@ struct ina2xx_chip_info {
> =20
>  static const struct ina2xx_config ina2xx_config[] =3D {
>  	[ina219] =3D {
> +		.name =3D "ina219",
>  		.config_default =3D INA219_CONFIG_DEFAULT,
>  		.calibration_value =3D 4096,
>  		.shunt_voltage_lsb =3D 10000,
> @@ -164,6 +166,7 @@ static const struct ina2xx_config ina2xx_config[] =3D=
 {
>  		.chip_id =3D ina219,
>  	},
>  	[ina226] =3D {
> +		.name =3D "ina226",
>  		.config_default =3D INA226_CONFIG_DEFAULT,
>  		.calibration_value =3D 2048,
>  		.shunt_voltage_lsb =3D 2500,
> @@ -996,7 +999,7 @@ static int ina2xx_probe(struct i2c_client *client)
>  	/* Patch the current config register with default. */
>  	val =3D chip->config->config_default;
> =20
> -	if (id->driver_data =3D=3D ina226) {
> +	if (type =3D=3D ina226) {
>  		ina226_set_average(chip, INA226_DEFAULT_AVG, &val);
>  		ina226_set_int_time_vbus(chip, INA226_DEFAULT_IT, &val);
>  		ina226_set_int_time_vshunt(chip, INA226_DEFAULT_IT, &val);
> @@ -1015,7 +1018,7 @@ static int ina2xx_probe(struct i2c_client *client)
>  	}
> =20
>  	indio_dev->modes =3D INDIO_DIRECT_MODE;
> -	if (id->driver_data =3D=3D ina226) {
> +	if (type =3D=3D ina226) {
>  		indio_dev->channels =3D ina226_channels;
>  		indio_dev->num_channels =3D ARRAY_SIZE(ina226_channels);
>  		indio_dev->info =3D &ina226_info;
> @@ -1024,7 +1027,7 @@ static int ina2xx_probe(struct i2c_client *client)
>  		indio_dev->num_channels =3D ARRAY_SIZE(ina219_channels);
>  		indio_dev->info =3D &ina219_info;
>  	}
> -	indio_dev->name =3D id->name;
> +	indio_dev->name =3D id ? id->name : chip->config->name;
> =20
>  	ret =3D devm_iio_kfifo_buffer_setup(&client->dev, indio_dev,
>  					  &ina2xx_setup_ops);

