Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12DEC659B2F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 19:01:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235389AbiL3SB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 13:01:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiL3SBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 13:01:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDAB360E7;
        Fri, 30 Dec 2022 10:01:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7987C61B2D;
        Fri, 30 Dec 2022 18:01:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96D4AC433EF;
        Fri, 30 Dec 2022 18:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672423280;
        bh=ILEVj0T2gK+HIo88lJKu2qs6fZn70l7XILyjzXsrudU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gtDtgEiI90dCLi2nOW/PyYIOYWY+IKcO1mP58lS/WW6NyJI3sJMh0PnOGvaMD01nt
         YC0fC0gyqZohmlMuSj1K7cqnYH4/rzPDjno8Q/VS15/bK9IH5xCvdXwFeQbsPwISSm
         6iEVxFAXonHvUoA8/yiFSvY03XZZhVi35FSYMmKYeF4mLfe9GFiBoFtLg9I18Tzup2
         oiXWh7Le4av7rAKg79N1RUdlRZ+1TKphfe8/+CccasF4u19+qFFGK44gV5IPxP4r/O
         gtzHSqcq5ZnD1IJEoBP4LuNBp5VIXKP3Y9cp/VW4J1zJWEbdgYahMmvpxF6/uv2Rg/
         SSaBvmfo5t3tw==
Date:   Fri, 30 Dec 2022 18:14:38 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Angel Iglesias <ang.iglesiasg@gmail.com>
Cc:     linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Andreas Klinger <ak@it-klinger.de>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] iio: pressure: bmp280: Add enumeration to handle
 chip variants
Message-ID: <20221230181438.42e25cb9@jic23-huawei>
In-Reply-To: <f0368a3f460707417110dffdb0166824da20af15.1672062380.git.ang.iglesiasg@gmail.com>
References: <cover.1672062380.git.ang.iglesiasg@gmail.com>
        <f0368a3f460707417110dffdb0166824da20af15.1672062380.git.ang.iglesiasg@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.36; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Dec 2022 15:29:20 +0100
Angel Iglesias <ang.iglesiasg@gmail.com> wrote:

> Adds enumeration to improve handling the different supported sensors
> on driver initialization. This avoid collisions if different variants
> share the same device idetifier on ID register.

If we get two parts with the same ID that need different handling
then we should probably be shouting at Bosch.  Still I don't mind
tidying this up anyway as using the CHIP_IDs is messy - however...

Please be careful to make sure you have responded (either by changes, or by
replying to review to say why you aren't making changes).  If you are not receiving
all emails, then you can always check lore.kernel.org to make sure you didn't miss
any reviews.

As Andy suggested, switch over to using pointers to the chip_info structure as the
data element in *_device_id tables.  It usually ends up neater in the end than
messing around with an indirection via an enum value.

> 
> Signed-off-by: Angel Iglesias <ang.iglesiasg@gmail.com>
> 
> diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
> index c0aff78489b4..46959a91408f 100644
> --- a/drivers/iio/pressure/bmp280-core.c
> +++ b/drivers/iio/pressure/bmp280-core.c
> @@ -186,6 +186,7 @@ struct bmp280_data {
>  
>  struct bmp280_chip_info {
>  	unsigned int id_reg;
> +	const unsigned int chip_id;
>  
>  	const struct iio_chan_spec *channels;
>  	int num_channels;
> @@ -907,6 +908,7 @@ static const int bmp280_oversampling_avail[] = { 1, 2, 4, 8, 16 };
>  
>  static const struct bmp280_chip_info bmp280_chip_info = {
>  	.id_reg = BMP280_REG_ID,
> +	.chip_id = BMP280_CHIP_ID,
>  	.start_up_time = 2000,
>  	.channels = bmp280_channels,
>  	.num_channels = 2,
> @@ -955,6 +957,7 @@ static int bme280_chip_config(struct bmp280_data *data)
>  
>  static const struct bmp280_chip_info bme280_chip_info = {
>  	.id_reg = BMP280_REG_ID,
> +	.chip_id = BME280_CHIP_ID,
>  	.start_up_time = 2000,
>  	.channels = bmp280_channels,
>  	.num_channels = 3,
> @@ -1321,6 +1324,7 @@ static const int bmp380_iir_filter_coeffs_avail[] = { 1, 2, 4, 8, 16, 32, 64, 12
>  
>  static const struct bmp280_chip_info bmp380_chip_info = {
>  	.id_reg = BMP380_REG_ID,
> +	.chip_id = BMP380_CHIP_ID,
>  	.start_up_time = 2000,
>  	.channels = bmp380_channels,
>  	.num_channels = 2,
> @@ -1581,6 +1585,7 @@ static const int bmp180_oversampling_press_avail[] = { 1, 2, 4, 8 };
>  
>  static const struct bmp280_chip_info bmp180_chip_info = {
>  	.id_reg = BMP280_REG_ID,
> +	.chip_id = BMP180_CHIP_ID,
>  	.start_up_time = 2000,
>  	.channels = bmp280_channels,
>  	.num_channels = 2,
> @@ -1685,16 +1690,16 @@ int bmp280_common_probe(struct device *dev,
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  
>  	switch (chip) {
> -	case BMP180_CHIP_ID:
> +	case BMP180:
>  		chip_info = &bmp180_chip_info;
>  		break;
> -	case BMP280_CHIP_ID:
> +	case BMP280:
>  		chip_info = &bmp280_chip_info;
>  		break;
> -	case BME280_CHIP_ID:
> +	case BME280:
>  		chip_info = &bme280_chip_info;
>  		break;
> -	case BMP380_CHIP_ID:
> +	case BMP380:
>  		chip_info = &bmp380_chip_info;

If you use a pointer directly then no need for this switch statement at all.

>  		break;
>  	default:
> @@ -1751,9 +1756,9 @@ int bmp280_common_probe(struct device *dev,
>  	ret = regmap_read(regmap, data->chip_info->id_reg, &chip_id);
>  	if (ret < 0)
>  		return ret;
> -	if (chip_id != chip) {
> +	if (chip_id != data->chip_info->chip_id) {
>  		dev_err(dev, "bad chip id: expected %x got %x\n",
> -			chip, chip_id);
> +			data->chip_info->chip_id, chip_id);
>  		return -EINVAL;
>  	}
>  
> diff --git a/drivers/iio/pressure/bmp280-i2c.c b/drivers/iio/pressure/bmp280-i2c.c
> index 14eab086d24a..59921e8cd592 100644
> --- a/drivers/iio/pressure/bmp280-i2c.c
> +++ b/drivers/iio/pressure/bmp280-i2c.c
> @@ -12,14 +12,14 @@ static int bmp280_i2c_probe(struct i2c_client *client)
>  	const struct i2c_device_id *id = i2c_client_get_device_id(client);
>  
>  	switch (id->driver_data) {
> -	case BMP180_CHIP_ID:
> +	case BMP180:
>  		regmap_config = &bmp180_regmap_config;
>  		break;
> -	case BMP280_CHIP_ID:
> -	case BME280_CHIP_ID:
> +	case BMP280:
> +	case BME280:
>  		regmap_config = &bmp280_regmap_config;
>  		break;
> -	case BMP380_CHIP_ID:
> +	case BMP380:
>  		regmap_config = &bmp380_regmap_config;
>  		break;
>  	default:
> @@ -40,21 +40,21 @@ static int bmp280_i2c_probe(struct i2c_client *client)
>  }
>  
>  static const struct of_device_id bmp280_of_i2c_match[] = {
> -	{ .compatible = "bosch,bmp085", .data = (void *)BMP180_CHIP_ID },
> -	{ .compatible = "bosch,bmp180", .data = (void *)BMP180_CHIP_ID },
> -	{ .compatible = "bosch,bmp280", .data = (void *)BMP280_CHIP_ID },
> -	{ .compatible = "bosch,bme280", .data = (void *)BME280_CHIP_ID },
> -	{ .compatible = "bosch,bmp380", .data = (void *)BMP380_CHIP_ID },
> +	{ .compatible = "bosch,bmp085", .data = (void *)BMP180 },
> +	{ .compatible = "bosch,bmp180", .data = (void *)BMP180 },
> +	{ .compatible = "bosch,bmp280", .data = (void *)BMP280 },
> +	{ .compatible = "bosch,bme280", .data = (void *)BME280 },
> +	{ .compatible = "bosch,bmp380", .data = (void *)BMP380 },
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(of, bmp280_of_i2c_match);
>  
>  static const struct i2c_device_id bmp280_i2c_id[] = {
> -	{"bmp085", BMP180_CHIP_ID },
> -	{"bmp180", BMP180_CHIP_ID },
> -	{"bmp280", BMP280_CHIP_ID },
> -	{"bme280", BME280_CHIP_ID },
> -	{"bmp380", BMP380_CHIP_ID },
> +	{"bmp085", BMP180 },
> +	{"bmp180", BMP180 },
> +	{"bmp280", BMP280 },
> +	{"bme280", BME280 },
> +	{"bmp380", BMP380 },
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(i2c, bmp280_i2c_id);
> diff --git a/drivers/iio/pressure/bmp280-spi.c b/drivers/iio/pressure/bmp280-spi.c
> index 011c68e07ebf..4a2df5b5d838 100644
> --- a/drivers/iio/pressure/bmp280-spi.c
> +++ b/drivers/iio/pressure/bmp280-spi.c
> @@ -59,14 +59,14 @@ static int bmp280_spi_probe(struct spi_device *spi)
>  	}
>  
>  	switch (id->driver_data) {
> -	case BMP180_CHIP_ID:
> +	case BMP180:
>  		regmap_config = &bmp180_regmap_config;
>  		break;
> -	case BMP280_CHIP_ID:
> -	case BME280_CHIP_ID:
> +	case BMP280:
> +	case BME280:
>  		regmap_config = &bmp280_regmap_config;
>  		break;
> -	case BMP380_CHIP_ID:
> +	case BMP380:
>  		regmap_config = &bmp380_regmap_config;
>  		break;
>  	default:
> @@ -101,11 +101,11 @@ static const struct of_device_id bmp280_of_spi_match[] = {
>  MODULE_DEVICE_TABLE(of, bmp280_of_spi_match);
>  
>  static const struct spi_device_id bmp280_spi_id[] = {
> -	{ "bmp180", BMP180_CHIP_ID },
> -	{ "bmp181", BMP180_CHIP_ID },
> -	{ "bmp280", BMP280_CHIP_ID },
> -	{ "bme280", BME280_CHIP_ID },
> -	{ "bmp380", BMP380_CHIP_ID },
> +	{ "bmp180", BMP180 },
> +	{ "bmp181", BMP180 },
> +	{ "bmp280", BMP280 },
> +	{ "bme280", BME280 },
> +	{ "bmp380", BMP380 },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(spi, bmp280_spi_id);
> diff --git a/drivers/iio/pressure/bmp280.h b/drivers/iio/pressure/bmp280.h
> index c791325c7416..efc31bc84708 100644
> --- a/drivers/iio/pressure/bmp280.h
> +++ b/drivers/iio/pressure/bmp280.h
> @@ -191,6 +191,14 @@
>  #define BMP280_PRESS_SKIPPED		0x80000
>  #define BMP280_HUMIDITY_SKIPPED		0x8000
>  
> +/* Enum with supported pressure sensor models */
> +enum bmp280_variant {
> +	BMP180,
> +	BMP280,
> +	BME280,
> +	BMP380,
> +};
> +
>  /* Regmap configurations */
>  extern const struct regmap_config bmp180_regmap_config;
>  extern const struct regmap_config bmp280_regmap_config;

