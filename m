Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ABFC659B68
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 19:32:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235405AbiL3Sc0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 13:32:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbiL3ScW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 13:32:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF068F007;
        Fri, 30 Dec 2022 10:32:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 39024B81CE7;
        Fri, 30 Dec 2022 18:32:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98FFBC433EF;
        Fri, 30 Dec 2022 18:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672425138;
        bh=q6dxdiPRmnb7ATdJDwQm0o3BYVCv5WtHe6vm0DLbXfw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SaYb07nBJFyqVfPWFYnCjvfqJtirvMvn1NjT+Gb0Kug2HnStObxqLbThFLwspwsDH
         TkSBqAuuLiTL1x4d6lLnpY2XUT5tkbucwC8kWBWfVNgSpzcT2k0S5mHWWw5jwPvs+y
         Hn5Hr/C645A3BCYmCVoLcmApF6H9wWJIA4k+0U2BcobE+C4trrrflvyWoCpevq/gd4
         SsqjzcUT2yeEoWECMxsS3R5BKG5t5ng1cmPbqmkDUxVTPC+g2RKU2BmtRTBJSB4JUe
         WHYHjmGe4OIp6WerK+a1JE7Gbj5UAcpjOiSmQiwVoNNZAXB5emzWijZL61O2pR9kvl
         nSMKWpe3LMPfw==
Date:   Fri, 30 Dec 2022 18:45:35 +0000
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
Subject: Re: [PATCH v2 3/5] iio: pressure: bmp280: Add support for new
 sensor BMP580
Message-ID: <20221230184535.6f684337@jic23-huawei>
In-Reply-To: <c053976f56c3810915ca2ead6c358b5997b782e5.1672062380.git.ang.iglesiasg@gmail.com>
References: <cover.1672062380.git.ang.iglesiasg@gmail.com>
        <c053976f56c3810915ca2ead6c358b5997b782e5.1672062380.git.ang.iglesiasg@gmail.com>
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

On Mon, 26 Dec 2022 15:29:22 +0100
Angel Iglesias <ang.iglesiasg@gmail.com> wrote:

> Adds compatibility with the new sensor generation, the BMP580.
> 
> The measurement and initialization codepaths are adapted from
> the device datasheet and the repository from manufacturer at
> https://github.com/boschsensortec/BMP5-Sensor-API.
> 
> Signed-off-by: Angel Iglesias <ang.iglesiasg@gmail.com>

Hi Angel,

Some comments inline,

Thanks,

Jonathan

> 
> diff --git a/drivers/iio/pressure/Kconfig b/drivers/iio/pressure/Kconfig
> index c9453389e4f7..1c18e3b2c501 100644
> --- a/drivers/iio/pressure/Kconfig
> +++ b/drivers/iio/pressure/Kconfig
> @@ -17,14 +17,14 @@ config ABP060MG
>  	  will be called abp060mg.
>  
>  config BMP280
> -	tristate "Bosch Sensortec BMP180/BMP280/BMP380 pressure sensor I2C driver"
> +	tristate "Bosch Sensortec BMP180/BMP280/BMP380/BMP580 pressure sensor I2C driver"
Future reference:  If this gets much longer we'll have to shorten to
"BMP280 and similar" like we have already had to do for a bunch of other drivers
that support too many parts to fit in the short description.  We carry on listing
them all in the help though.

I think this is the last time we can get aways with it.

I2C driver?  Looks to be handling SPI as well.

>  	depends on (I2C || SPI_MASTER)
>  	select REGMAP
>  	select BMP280_I2C if (I2C)
>  	select BMP280_SPI if (SPI_MASTER)
>  	help
> -	  Say yes here to build support for Bosch Sensortec BMP180, BMP280 and
> -	  BMP380 pressure and temperature sensors. Also supports the BME280 with
> +	  Say yes here to build support for Bosch Sensortec BMP180, BMP280, BMP380
> +	  and BMP580 pressure and temperature sensors. Also supports the BME280 with
>  	  an additional humidity sensor channel.
>  
>  	  To compile this driver as a module, choose M here: the core module

...


> +
> +/*
> + * Helper function to send a command to BMP5XX sensors.
> + *
> + * BMP5xx sensors have a series of commands actionable
> + * writing specific sequences on the CMD register:
> + * SOFT_RESET: performs a reset of the system.
> + * NVM_READ: read the contents of a user position of the nvm memory.
> + * NVM_WRITE: write new data to a user position of the nvm memory.
> + * EXT_MODE: enable extended mode with additional debug pages.
> + */
> +static int bmp580_cmd(struct bmp280_data *data, enum bmp580_commands cmd)

Is there an advantage in rolling these up in one function?  There seems to be no real
shared code.  Also most of this isn't used currently I think, so perhaps should be
introduced alongside code that uses it.

> +{
> +	unsigned long deadline;
> +	unsigned int reg;
> +	int ret;
> +
> +	switch (cmd) {
> +	case BMP580_SOFT_RESET_CMD:
> +		/* Send reset word */
> +		ret = regmap_write(data->regmap, BMP580_REG_CMD, BMP580_CMD_SOFT_RESET);
> +		if (ret) {
> +			dev_err(data->dev, "failed to send reset command to device\n");
> +			return ret;
> +		}
> +		/* Wait 2ms for reset completion */
> +		usleep_range(2000, 2500);

blank line.

> +		/* Dummy read of chip_id */
> +		ret = regmap_read(data->regmap, BMP580_REG_CHIP_ID, &reg);
> +		if (ret) {
> +			dev_err(data->dev, "failed to reestablish comms after reset\n");
> +			return ret;
> +		}

blank line etc.  See below for reasoning.

> +		/* Check if POR bit is set on interrupt reg */
> +		ret = regmap_read(data->regmap, BMP580_REG_INT_STATUS, &reg);
> +		if (ret) {
> +			dev_err(data->dev, "error reading interrupt status register\n");
> +			return ret;
> +		}
> +		if (!(reg & BMP580_INT_STATUS_POR_MASK)) {
> +			dev_err(data->dev, "error resetting sensor\n");
> +			return -EINVAL;
> +		}
> +		break;
> +	case BMP580_NVM_WRITE_CMD:
> +	case BMP580_NVM_READ_CMD:
> +		/* Check nvm ready flag */
> +		ret = regmap_read(data->regmap, BMP580_REG_STATUS, &reg);
> +		if (ret) {
> +			dev_err(data->dev, "failed to check nvm status\n");
> +			return ret;
> +		}
> +		if (!(reg & BMP580_STATUS_NVM_RDY_MASK)) {
> +			dev_err(data->dev, "sensor's nvm is not ready\n");
> +			return -EIO;
> +		}
> +		/* Send NVM operation sequence */
> +		ret = regmap_write(data->regmap, BMP580_REG_CMD, BMP580_CMD_NVM_OP_SEQ_0);
> +		if (ret) {
> +			dev_err(data->dev, "failed to send nvm operation's first sequence\n");
> +			return ret;
> +		}
> +		if (cmd == BMP580_NVM_WRITE_CMD) {
> +			/* Send write sequence */
> +			ret = regmap_write(data->regmap, BMP580_REG_CMD,
> +					   BMP580_CMD_NVM_WRITE_SEQ_1);
> +			if (ret) {
> +				dev_err(data->dev, "failed to send nvm write sequence\n");
> +				return ret;
> +			}
> +			/* Datasheet says on 4.8.1.2 it takes approximately 10ms */
> +			usleep_range(10000, 10500);
> +			deadline = jiffies + msecs_to_jiffies(10);
> +		} else {
> +			/* Send read sequence */
> +			ret = regmap_write(data->regmap, BMP580_REG_CMD,
> +					   BMP580_CMD_NVM_READ_SEQ_1);
> +			if (ret) {
> +				dev_err(data->dev, "failed to send nvm read sequence\n");
> +				return ret;
> +			}
> +			/* Datasheet says on 4.8.1.1 it takes approximately 200us */
> +			usleep_range(200, 250);
> +			deadline = jiffies + usecs_to_jiffies(200);
> +		}
> +		if (ret) {
> +			dev_err(data->dev, "failed to write command sequence\n");
> +			return -EIO;
> +		}
> +		/* Wait until NVM is ready again */
> +		do {
> +			ret = regmap_read(data->regmap, BMP580_REG_STATUS, &reg);
> +			if (ret) {
> +				dev_err(data->dev, "failed to check nvm status\n");
> +				reg &= ~BMP580_STATUS_NVM_RDY_MASK;
> +			}
> +		} while (time_before(jiffies, deadline) && !(reg & BMP580_STATUS_NVM_RDY_MASK));
> +
> +		if (!(reg & BMP580_STATUS_NVM_RDY_MASK)) {
> +			dev_err(data->dev,
> +				"reached timeout waiting for nvm operation completion\n");
> +			return -ETIMEDOUT;
> +		}
> +		/* Checks nvm error flags */
> +		if ((reg & BMP580_STATUS_NVM_ERR_MASK) || (reg & BMP580_STATUS_NVM_CMD_ERR_MASK)) {
> +			dev_err(data->dev, "error processing nvm operation\n");
> +			return -EIO;
> +		}
> +		break;
> +	case BMP580_EXT_MODE_CMD:
> +		ret = regmap_write(data->regmap, BMP580_REG_CMD, BMP580_CMD_EXTMODE_SEQ_0);
> +		if (ret) {
> +			dev_err(data->dev, "failed to send ext_mode first sequence\n");
> +			return ret;
> +		}
> +		ret = regmap_write(data->regmap, BMP580_REG_CMD, BMP580_CMD_EXTMODE_SEQ_1);
> +		if (ret) {
> +			dev_err(data->dev, "failed to send ext_mode second sequence\n");
> +			return ret;
> +		}
> +		ret = regmap_write(data->regmap, BMP580_REG_CMD, BMP580_CMD_EXTMODE_SEQ_2);
> +		if (ret) {
> +			dev_err(data->dev, "failed to send ext_mode second sequence\n");
> +			return ret;
> +		}
> +		break;

Might as well return from each of the instead of break.  slightly reduces the code
anyone interested in a particular flow needs to look at.


> +	}
> +
> +	return 0;
> +}

...

> +
> +static int bmp580_read_press(struct bmp280_data *data, int *val, int *val2)
> +{
> +	u32 raw_press;
> +	int ret;
> +
> +	ret = regmap_bulk_read(data->regmap, BMP580_REG_PRESS_XLSB, data->buf,
> +			       sizeof(data->buf));
> +	if (ret) {
> +		dev_err(data->dev, "failed to read pressure\n");
> +		return ret;
> +	}
> +
> +	raw_press = get_unaligned_le24(data->buf);
> +	if (raw_press == BMP580_PRESS_SKIPPED) {
> +		dev_err(data->dev, "reading pressure skipped\n");
> +		return -EIO;
> +	}
> +	/*
> +	 * Pressure is returned in Pascals in fractional form down 2^16.
> +	 * We reescale /1000 to convert to kilopascal to respect IIO ABI.
> +	 */
> +	*val = raw_press;
> +	*val2 = 64000; // 2^6 * 1000

/* */ syntax for comments in IIO.

> +	return IIO_VAL_FRACTIONAL;
> +}

...

> +static int bmp580_preinit(struct bmp280_data *data)
> +{
> +	unsigned int reg;
> +	int ret;
> +
> +	/* Issue soft-reset command */
> +	ret = bmp580_cmd(data, BMP580_SOFT_RESET_CMD);
> +	if (ret)
> +		return ret;
Blank line here and similar places.  Nice to keep unrelated blocks of
code separate.

> +	/* Post powerup sequence */
> +	ret = regmap_read(data->regmap, BMP580_REG_CHIP_ID, &reg);
> +	if (ret)
> +		return ret;
> +	if (reg != BMP580_CHIP_ID) {
> +		dev_err(data->dev, "preinit: unexpected chip_id\n");

I'd rather this was just an info print and carry on.  If Bosch brings
another device out that is sufficiently compatible and we use a fallback
dt compatible for it - so that it works with older kernels then we might
want to indicate we aren't sure we can handle the chip correctly but then assume
the DT description was correct and carry on anyway. 

> +		return -EINVAL;
> +	}
> +	ret = regmap_read(data->regmap, BMP580_REG_STATUS, &reg);
> +	if (ret)
> +		return ret;
> +	/* Check nvm status */
> +	if (!(reg & BMP580_STATUS_NVM_RDY_MASK) || (reg & BMP580_STATUS_NVM_ERR_MASK)) {
> +		dev_err(data->dev, "preinit: nvm error on powerup sequence\n");
> +		return -EIO;
> +	}
> +
> +	return 0;
> +}
> +

...

> +static const int bmp580_oversampling_avail[] = { 1, 2, 4, 8, 16, 32, 64, 128 };
> +static const int bmp580_iir_filter_coeffs_avail[] = { 1, 2, 4, 8, 16, 32, 64, 128 };

Up to you, but you could take advantage of the fact this array matches the bmp380 one.
It is arguable that the code is clearer with it not being reused though so your choice.

> +
> +static const struct bmp280_chip_info bmp580_chip_info = {
> +	.id_reg = BMP580_REG_CHIP_ID,
> +	.chip_id = BMP580_CHIP_ID,
> +	.start_up_time = 2000,
> +	.channels = bmp380_channels,
> +	.num_channels = 2,
> +
> +	.oversampling_temp_avail = bmp580_oversampling_avail,
> +	.num_oversampling_temp_avail = ARRAY_SIZE(bmp580_oversampling_avail),
> +	.oversampling_temp_default = ilog2(1),
> +
> +	.oversampling_press_avail = bmp580_oversampling_avail,
> +	.num_oversampling_press_avail = ARRAY_SIZE(bmp580_oversampling_avail),
> +	.oversampling_press_default = ilog2(4),
> +
> +	.sampling_freq_avail = bmp580_odr_table,
> +	.num_sampling_freq_avail = ARRAY_SIZE(bmp580_odr_table) * 2,
> +	.sampling_freq_default = BMP580_ODR_50HZ,
> +
> +	.iir_filter_coeffs_avail = bmp580_iir_filter_coeffs_avail,
> +	.num_iir_filter_coeffs_avail = ARRAY_SIZE(bmp580_iir_filter_coeffs_avail),
> +	.iir_filter_coeff_default = 2,
> +
> +	.chip_config = bmp580_chip_config,
> +	.read_temp = bmp580_read_temp,
> +	.read_press = bmp580_read_press,
> +	.read_calib = NULL,

As in previous patch, I'd prefer not to see explicit NULL being set for
optional elements. Their absence should be enough.

> +	.preinit = bmp580_preinit,
> +};
> +
>  static int bmp180_measure(struct bmp280_data *data, u8 ctrl_meas)
>  {
>  	const int conversion_time_max[] = { 4500, 7500, 13500, 25500 };
> @@ -1713,6 +2142,9 @@ int bmp280_common_probe(struct device *dev,
>  	case BMP380:
>  		chip_info = &bmp380_chip_info;
>  		break;
> +	case BMP580:
> +		chip_info = &bmp580_chip_info;
> +		break;
>  	default:
>  		return -EINVAL;
>  	}
> @@ -1779,9 +2211,10 @@ int bmp280_common_probe(struct device *dev,
>  	 */
>  	if (data->chip_info->preinit) {
>  		ret = data->chip_info->preinit(data);
> -		dev_err(dev, "error running preinit tasks");
> -		if (ret < 0)
> +		if (ret) {
> +			dev_err(dev, "error running preinit tasks\n");
>  			return ret;
Wrong patch.  + use dev_error_probe() like the case below already does.

> +		}
>  	}
>  
>  	ret = data->chip_info->chip_config(data);
> @@ -1795,11 +2228,12 @@ int bmp280_common_probe(struct device *dev,
>  	 * non-volatile memory during production". Let's read them out at probe
>  	 * time once. They will not change.
>  	 */
> -
> -	ret = data->chip_info->read_calib(data);
> -	if (ret < 0)
> -		return dev_err_probe(data->dev, ret,
> -				     "failed to read calibration coefficients\n");
> +	if (data->chip_info->read_calib) {

Small thing, but ideally this no op refactoring should have been a precursor patch
rather than buried in here. It's small enough though that I don't care enough to insist
you break it out.

> +		ret = data->chip_info->read_calib(data);
> +		if (ret < 0)
> +			return dev_err_probe(data->dev, ret,
> +					     "failed to read calibration coefficients\n");
> +	}
>  
>  	/*
>  	 * Attempt to grab an optional EOC IRQ - only the BMP085 has this
> diff --git a/drivers/iio/pressure/bmp280-i2c.c b/drivers/iio/pressure/bmp280-i2c.c
> index 59921e8cd592..c52d2b477bb7 100644
> --- a/drivers/iio/pressure/bmp280-i2c.c
> +++ b/drivers/iio/pressure/bmp280-i2c.c
> @@ -22,6 +22,9 @@ static int bmp280_i2c_probe(struct i2c_client *client)
>  	case BMP380:
>  		regmap_config = &bmp380_regmap_config;
>  		break;
> +	case BMP580:
> +		regmap_config = &bmp580_regmap_config;

whilst here, similar to below, it would be nice to switch to generic
firmware methods as default way to get the match data then fallback to the
i2c_device_id table if that fails (as we did old school i2c probing from
a board file or from userspace).

> +		break;
>  	default:
>  		return -EINVAL;
>  	}
> @@ -45,6 +48,7 @@ static const struct of_device_id bmp280_of_i2c_match[] = {
>  	{ .compatible = "bosch,bmp280", .data = (void *)BMP280 },
>  	{ .compatible = "bosch,bme280", .data = (void *)BME280 },
>  	{ .compatible = "bosch,bmp380", .data = (void *)BMP380 },
> +	{ .compatible = "bosch,bmp580", .data = (void *)BMP580 },
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(of, bmp280_of_i2c_match);
> @@ -55,6 +59,7 @@ static const struct i2c_device_id bmp280_i2c_id[] = {
>  	{"bmp280", BMP280 },
>  	{"bme280", BME280 },
>  	{"bmp380", BMP380 },
> +	{"bmp580", BMP580 },
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(i2c, bmp280_i2c_id);

> diff --git a/drivers/iio/pressure/bmp280-spi.c b/drivers/iio/pressure/bmp280-spi.c
> index 4a2df5b5d838..5653c3c33081 100644
> --- a/drivers/iio/pressure/bmp280-spi.c
> +++ b/drivers/iio/pressure/bmp280-spi.c
> @@ -69,6 +69,9 @@ static int bmp280_spi_probe(struct spi_device *spi)
>  	case BMP380:
>  		regmap_config = &bmp380_regmap_config;
>  		break;
> +	case BMP580:
> +		regmap_config = &bmp580_regmap_config;

If using a pointer as suggested you'd get this for free :)

I'd also like to see this driver move to using the of_device_id table
via device_get_match_data() first then fallback to the spi_device_id table
only if that fails.   Otherwise for dt supprot, we are relying on a match
based on stripping the bosch prefix of the of compatible and that is nasty.

> +		break;
>  	default:
>  		return -EINVAL;
>  	}
> @@ -96,6 +99,7 @@ static const struct of_device_id bmp280_of_spi_match[] = {
>  	{ .compatible = "bosch,bmp280", },
>  	{ .compatible = "bosch,bme280", },
>  	{ .compatible = "bosch,bmp380", },
> +	{ .compatible = "bosch,bmp580", },
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(of, bmp280_of_spi_match);
> @@ -106,6 +110,7 @@ static const struct spi_device_id bmp280_spi_id[] = {
>  	{ "bmp280", BMP280 },
>  	{ "bme280", BME280 },
>  	{ "bmp380", BMP380 },
> +	{ "bmp580", BMP580 },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(spi, bmp280_spi_id);
> diff --git a/drivers/iio/pressure/bmp280.h b/drivers/iio/pressure/bmp280.h
> index efc31bc84708..27d2abc17d01 100644
> --- a/drivers/iio/pressure/bmp280.h
> +++ b/drivers/iio/pressure/bmp280.h
> @@ -3,6 +3,107 @@

...

> +#define BMP580_CHIP_ID			0x50
>  #define BMP380_CHIP_ID			0x50

Well given we can't order them by ID value, probably best
to have the set with a given ID in alphabetical order.  So
swap the two above.

>  #define BMP180_CHIP_ID			0x55
>  #define BMP280_CHIP_ID			0x58
> @@ -197,12 +299,14 @@ enum bmp280_variant {
>  	BMP280,
>  	BME280,
>  	BMP380,
> +	BMP580,
>  };
>  
>  /* Regmap configurations */
>  extern const struct regmap_config bmp180_regmap_config;
>  extern const struct regmap_config bmp280_regmap_config;
>  extern const struct regmap_config bmp380_regmap_config;
> +extern const struct regmap_config bmp580_regmap_config;
>  
>  /* Probe called from different transports */
>  int bmp280_common_probe(struct device *dev,

