Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09D7F61242C
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 17:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbiJ2P0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 11:26:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiJ2P0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 11:26:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A771555C5A;
        Sat, 29 Oct 2022 08:26:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4437EB80B37;
        Sat, 29 Oct 2022 15:26:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26BC0C433C1;
        Sat, 29 Oct 2022 15:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667057174;
        bh=5ytSdZrjM+32D+WMklSbL13lQGu76cMmV68YmFP8GHc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Xw9ZoBtlLj8kZ6TuLtLF4gng7w5It+UzP7oT+5VEOV7TTc5s4iabKu9k6sk3iSKnD
         LDQ10kGNwuno7uqYjgmiALaDoJIo57oaFJH7G9RA5KC6LRbcIwQeED6sG2KolOhVjx
         8fC2vVEwSfXS1ghs4uyfJvTewPnVtLo5fF9Yhz2w4RPDa+fPmLhMto+NjlOuZ6DPL3
         ZqlIzzSktk4Lzy7Po7pOXlAR0dfiZDOjVVLJ2sMIoO23ejEW0hWwJAUyZG5Kajct0D
         OWVmpN15qQEBlLBEmgM/2t0Wwdt4czX/Afln6G4jYjZNKZtWxYVjvYdx1ma5INORli
         OQqYoMK40JSsg==
Date:   Sat, 29 Oct 2022 16:38:09 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Ramona Bolboaca <ramona.bolboaca@analog.com>
Cc:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] drivers:iio:accel: Add support for ADXL359 device
Message-ID: <20221029163809.4dbcf86a@jic23-huawei>
In-Reply-To: <20221028134454.669509-3-ramona.bolboaca@analog.com>
References: <20221028134454.669509-1-ramona.bolboaca@analog.com>
        <20221028134454.669509-3-ramona.bolboaca@analog.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Oct 2022 16:44:54 +0300
Ramona Bolboaca <ramona.bolboaca@analog.com> wrote:

> Add support for ADXL359 device in already existing ADXL355 driver.
> 
> Signed-off-by: Ramona Bolboaca <ramona.bolboaca@analog.com>

Hi Ramona,

Various comments inline. Most are around moving more from 'code' to
'data' by adding more elements to your chip_info structure.
Experience tells us that almost always ends up cleaner and more maintainable
in the long run.

Thanks,

Jonathan

> ---
>  drivers/iio/accel/adxl355.h      | 14 ++++++-
>  drivers/iio/accel/adxl355_core.c | 67 +++++++++++++++++++++++++-------
>  drivers/iio/accel/adxl355_i2c.c  | 22 +++++++++--
>  drivers/iio/accel/adxl355_spi.c  | 19 +++++++--
>  4 files changed, 101 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/iio/accel/adxl355.h b/drivers/iio/accel/adxl355.h
> index 6dd49b13e4fd..c02106cbd745 100644
> --- a/drivers/iio/accel/adxl355.h
> +++ b/drivers/iio/accel/adxl355.h
> @@ -10,12 +10,24 @@
>  
>  #include <linux/regmap.h>
>  
> +enum adxl355_device_type {
> +	ADXL355,
> +	ADXL359,
> +};
> +
>  struct device;
>  
> +struct adxl355_chip_info {
> +	const char			*name;
> +	u8				part_id;
> +	enum adxl355_device_type	type;
> +};
> +
>  extern const struct regmap_access_table adxl355_readable_regs_tbl;
>  extern const struct regmap_access_table adxl355_writeable_regs_tbl;
> +extern const struct adxl355_chip_info adxl35x_chip_info[];
>  
>  int adxl355_core_probe(struct device *dev, struct regmap *regmap,
> -		       const char *name);
> +		       const struct adxl355_chip_info *chip_info);
>  
>  #endif /* _ADXL355_H_ */
> diff --git a/drivers/iio/accel/adxl355_core.c b/drivers/iio/accel/adxl355_core.c
> index 4bc648eac8b2..069c945aebde 100644
> --- a/drivers/iio/accel/adxl355_core.c
> +++ b/drivers/iio/accel/adxl355_core.c
> @@ -60,6 +60,7 @@
>  #define ADXL355_DEVID_AD_VAL		0xAD
>  #define ADXL355_DEVID_MST_VAL		0x1D
>  #define ADXL355_PARTID_VAL		0xED
> +#define ADXL359_PARTID_VAL		0xE9
>  #define ADXL355_RESET_CODE		0x52
>  
>  static const struct regmap_range adxl355_read_reg_range[] = {
> @@ -83,6 +84,20 @@ const struct regmap_access_table adxl355_writeable_regs_tbl = {
>  };
>  EXPORT_SYMBOL_NS_GPL(adxl355_writeable_regs_tbl, IIO_ADXL355);
>  
> +const struct adxl355_chip_info adxl35x_chip_info[] = {
> +	[ADXL355] = {
> +		.name = "adxl355",
> +		.part_id = ADXL355_PARTID_VAL,
> +		.type = ADXL355,

A type field always makes me look closely.  Generally we are better off not having
type specific switches in the code, but instead pulling the constant data / callbacks
in here.  That always ends up cleaner as we add more parts to a driver (otherwise
those switch statements keep getting bigger and bigger).

> +	},
> +	[ADXL359] = {
> +		.name = "adxl359",
> +		.part_id = ADXL359_PARTID_VAL,
> +		.type = ADXL359,
> +	},
> +};
> +EXPORT_SYMBOL_NS_GPL(adxl35x_chip_info, IIO_ADXL355);
> +
>  enum adxl355_op_mode {
>  	ADXL355_MEASUREMENT,
>  	ADXL355_STANDBY,
> @@ -162,6 +177,7 @@ static const struct adxl355_chan_info adxl355_chans[] = {
>  };
>  
>  struct adxl355_data {
> +	const struct adxl355_chip_info *chip_info;
>  	struct regmap *regmap;
>  	struct device *dev;
>  	struct mutex lock; /* lock to protect op_mode */
> @@ -262,7 +278,7 @@ static int adxl355_setup(struct adxl355_data *data)
>  	if (ret)
>  		return ret;
>  
> -	if (regval != ADXL355_PARTID_VAL) {
> +	if (regval != data->chip_info->part_id) {

Ah.  Whilst we are here, please relax this constraint to warning only (precusor patch ideally)
If a new device is released that has some minor changes but is compatible with a previous
device, it will be normal to use a fallback compatible so that it works with older kernels.
As things stand today this driver will reject such a situation.

It is fine to warn if it is wrong, just not fail driver probe.

The more complex solution is to check if we know about the device and if so, switch
to using the right values (whilst warning the firmware is wrong).
Doing that is entirely optional though as firmware shouldn't be broken!

>  		dev_err(data->dev, "Invalid DEV ID 0x%02x\n", regval);
>  		return -ENODEV;
>  	}
> @@ -459,31 +475,55 @@ static int adxl355_read_raw(struct iio_dev *indio_dev,
>  	case IIO_CHAN_INFO_SCALE:
>  		switch (chan->type) {
>  		/*
> -		 * The datasheet defines an intercept of 1885 LSB at 25 degC
> -		 * and a slope of -9.05 LSB/C. The following formula can be used
> +		 * The datasheet defines an intercept of 1885 LSB for ADXL355 and of 1852 for ADXL359
> +		 * at 25 degC and a slope of -9.05 LSB/C. The following formula can be used
>  		 * to find the temperature:
> -		 * Temp = ((RAW - 1885)/(-9.05)) + 25 but this doesn't follow
> +		 * Temp = ((RAW - 1885)/(-9.05)) + 25 for ADXL355
> +		 * Temp = ((RAW - 1852)/(-9.05)) + 25 for ADXL359
Once you have a field in chip_info for val2 here (see below), move the documentation of the values
at least alongside the values being specified in those structures.  You can have one detailed
explanation and a follow up one that just says "see ADXL355 description" + provides this
line of the formula. 

> +		 * but this doesn't follow
>  		 * the format of the IIO which is Temp = (RAW + OFFSET) * SCALE.
>  		 * Hence using some rearranging we get the scale as -110.497238
> -		 * and offset as -2111.25.
> +		 * and offset as -2111.25 for ADXL355 and -2079.25 for ADXL359
>  		 */
>  		case IIO_TEMP:
>  			*val = -110;
>  			*val2 = 497238;
>  			return IIO_VAL_INT_PLUS_MICRO;
> -		/*
> -		 * At +/- 2g with 20-bit resolution, scale is given in datasheet
> -		 * as 3.9ug/LSB = 0.0000039 * 9.80665 = 0.00003824593 m/s^2.
> -		 */
>  		case IIO_ACCEL:
> +			switch (data->chip_info->type) {
> +			case ADXL355:
> +				/*
> +				 * At +/- 2g with 20-bit resolution, scale is given in datasheet
> +				 * as 3.9ug/LSB = 0.0000039 * 9.80665 = 0.00003824593 m/s^2.
> +				 */
> +				*val2 = 38245;
> +				break;
> +			case ADXL359:
> +				/*
> +				 * At +/- 10g with 20-bit resolution, scale is given in datasheet
> +				 * as 19.5ug/LSB = 0.0000195 * 9.80665 = 0.0.00019122967 m/s^2.
> +				 */
> +				*val2 = 191229;
> +				break;
> +			default:
> +				return -EINVAL;
> +			}
>  			*val = 0;
> -			*val2 = 38245;
>  			return IIO_VAL_INT_PLUS_NANO;
>  		default:
>  			return -EINVAL;
>  		}
>  	case IIO_CHAN_INFO_OFFSET:
> -		*val = -2111;
> +		switch (data->chip_info->type) {

As a general rule, it is more extensible to put these sorts of values in the
chip_info structure than it is to introduce switch statements that will continue growing
as more parts are added to the driver.  So please add fields for offset and temp_scale

> +		case ADXL355:
> +			*val = -2111;
> +			break;
> +		case ADXL359:
> +			*val = -2079;
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
>  		*val2 = 250000;
>  		return IIO_VAL_INT_PLUS_MICRO;
>  	case IIO_CHAN_INFO_CALIBBIAS:
> @@ -707,7 +747,7 @@ static int adxl355_probe_trigger(struct iio_dev *indio_dev, int irq)
>  }
>  

>  	indio_dev->channels = adxl355_channels;
> diff --git a/drivers/iio/accel/adxl355_i2c.c b/drivers/iio/accel/adxl355_i2c.c
> index f67d57921c81..4cf38625fc27 100644
> --- a/drivers/iio/accel/adxl355_i2c.c
> +++ b/drivers/iio/accel/adxl355_i2c.c
> @@ -23,6 +23,20 @@ static const struct regmap_config adxl355_i2c_regmap_config = {
>  static int adxl355_i2c_probe(struct i2c_client *client)
>  {
>  	struct regmap *regmap;
> +	const struct adxl355_chip_info *chip_data;
> +	const struct i2c_device_id *adxl355;
> +
> +	adxl355 = to_i2c_driver(client->dev.driver)->id_table;

There is a discussion ongoing about having something like
spi_device_get_id() for I2C.  This is another good place
to use that.  In the meantime we only use the id_table in the
case that the firmware query fails.  So move it inside the 
if (!chip_data) {} block. There are other reasons that it should exist
but we don't need to care about them here (autoprobing etc)

> +	if (!adxl355)
> +		return -EINVAL;
> +
> +	chip_data = device_get_match_data(&client->dev);
> +	if (!chip_data) {
> +		chip_data = (void *)i2c_match_id(adxl355, client)->driver_data;
> +
> +		if (!chip_data)
> +			return -EINVAL;
> +	}
>  
>  	regmap = devm_regmap_init_i2c(client, &adxl355_i2c_regmap_config);
>  	if (IS_ERR(regmap)) {
> @@ -32,17 +46,19 @@ static int adxl355_i2c_probe(struct i2c_client *client)
>  		return PTR_ERR(regmap);
>  	}
>  
> -	return adxl355_core_probe(&client->dev, regmap, client->name);
> +	return adxl355_core_probe(&client->dev, regmap, chip_data);
>  }
>
