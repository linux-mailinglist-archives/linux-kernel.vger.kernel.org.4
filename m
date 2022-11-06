Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70AE761E23C
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 13:57:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbiKFM45 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 07:56:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbiKFM4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 07:56:52 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 051BF9FC9;
        Sun,  6 Nov 2022 04:56:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 94CDD60C56;
        Sun,  6 Nov 2022 12:56:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DCE8C433D6;
        Sun,  6 Nov 2022 12:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667739410;
        bh=uznMDa7uX4MgGTJpJSbjim1YWIO44mHclIyVTUt1EMA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LHbE6rDmMwD33iMCqeYv9w8cjPdoP+LSnHFmPpOgWPcrwL03qvv67TrMRksi1teTA
         bwxXD6GwRaq4PN0GkteyYxpsn7UE0LW5XgSFkpJeXIJVferuIDaJ5uKwvG8kuYceKS
         WjX1Y5Ll4iiuXOgTQwmSoIBRdqy7hKkecD9WC8Vhrv5wYUryy+K5OmkESfTF1h/MFk
         YQ2Awbj/GB9Ngl84D0/Hz8pKAyARA74F94tcTh8KePruxQVCv0Ny1CYavp64K2u/te
         p39ym4hOfMxwTgwqoplb0ed4AyDns8AKfH24Gs3gwGnzf7IkrWLggDdaWk7krEsus3
         F/kYsa3EVkMYw==
Date:   Sun, 6 Nov 2022 12:56:40 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Ramona Bolboaca <ramona.bolboaca@analog.com>
Cc:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] drivers: iio: accel: Add support for ADXL359
 device
Message-ID: <20221106125640.212471fd@jic23-huawei>
In-Reply-To: <20221031105129.47740-4-ramona.bolboaca@analog.com>
References: <20221031105129.47740-1-ramona.bolboaca@analog.com>
        <20221031105129.47740-4-ramona.bolboaca@analog.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-pc-linux-gnu)
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

On Mon, 31 Oct 2022 12:51:29 +0200
Ramona Bolboaca <ramona.bolboaca@analog.com> wrote:

> Add support for ADXL359 device in already existing ADXL355 driver.
> 
> Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/adxl359.pdf
> Signed-off-by: Ramona Bolboaca <ramona.bolboaca@analog.com>

A few really small things I tweaked whilst applying.

Series applied to the togreg branch of iio.git and initially pushed out as
testing for 0-day to see if it can find anything we missed.

Thanks,

Jonathan

> ---
> changes in v2:
>  - Added missing spaces in subject
>  - Added Datasheet tag in commit message
>  - Removed type field from adxl355_chip_info
>  - Added fields for acceleration scale and temperature offset in 
>    adxl355_chip_info structure
>  - Added constant data for acceleration scale and temperature offset specific
>    to each device in adxl35x_chip_info
>  - Moved scale and offset documentation to adxl35x_chip_info definition
>  - Moved device_get_match_data inside if (!chip_data) {} block
>  drivers/iio/accel/adxl355.h      | 21 +++++++-
>  drivers/iio/accel/adxl355_core.c | 85 +++++++++++++++++++++++++-------
>  drivers/iio/accel/adxl355_i2c.c  | 22 +++++++--
>  drivers/iio/accel/adxl355_spi.c  | 19 +++++--
>  4 files changed, 120 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/iio/accel/adxl355.h b/drivers/iio/accel/adxl355.h
> index 6dd49b13e4fd..3a08a1808e86 100644
> --- a/drivers/iio/accel/adxl355.h
> +++ b/drivers/iio/accel/adxl355.h
> @@ -10,12 +10,31 @@
>  
>  #include <linux/regmap.h>
>  
> +enum adxl355_device_type {
> +	ADXL355,
> +	ADXL359,
> +};
> +
> +struct adxl355_fractional_type {
> +	int integer;
> +	int decimal;
> +};
> +
>  struct device;
>  
> +struct adxl355_chip_info {
> +	const char			*name;
> +	u8				part_id;
> +	struct adxl355_fractional_type	accel_scale;
> +	struct adxl355_fractional_type	temp_offset;
> +

No blank line here.

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
> index dd08253d66d0..c501ad9af631 100644
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
> @@ -83,6 +84,60 @@ const struct regmap_access_table adxl355_writeable_regs_tbl = {
>  };
>  EXPORT_SYMBOL_NS_GPL(adxl355_writeable_regs_tbl, IIO_ADXL355);
>  
> +const struct adxl355_chip_info adxl35x_chip_info[] = {
> +	[ADXL355] = {
> +		.name = "adxl355",
> +		.part_id = ADXL355_PARTID_VAL,
> +		/*
> +		 * At +/- 2g with 20-bit resolution, scale is given in datasheet
> +		 * as 3.9ug/LSB = 0.0000039 * 9.80665 = 0.00003824593 m/s^2.
> +		 */
> +		.accel_scale = {
> +			.integer = 0,
> +			.decimal = 38245,
> +		},
> +		/*
> +		 * The datasheet defines an intercept of 1885 LSB at 25 degC
> +		 * and a slope of -9.05 LSB/C. The following formula can be used
> +		 * to find the temperature:
> +		 * Temp = ((RAW - 1885)/(-9.05)) + 25 but this doesn't follow
> +		 * the format of the IIO which is Temp = (RAW + OFFSET) * SCALE.
> +		 * Hence using some rearranging we get the scale as -110.497238
> +		 * and offset as -2111.25.
> +		 */
> +		.temp_offset = {
> +			.integer =  -2111,
> +			.decimal = 250000,
> +		},
> +	},
> +	[ADXL359] = {
> +		.name = "adxl359",
> +		.part_id = ADXL359_PARTID_VAL,
> +		/*
> +		 * At +/- 10g with 20-bit resolution, scale is given in datasheet
> +		 * as 19.5ug/LSB = 0.0000195 * 9.80665 = 0.0.00019122967 m/s^2.
> +		 */
> +		.accel_scale = {
> +			.integer = 0,
> +			.decimal = 191229,
> +		},
> +		/*
> +		 * The datasheet defines an intercept of 1852 LSB at 25 degC
> +		 * and a slope of -9.05 LSB/C. The following formula can be used
> +		 * to find the temperature:
> +		 * Temp = ((RAW - 1852)/(-9.05)) + 25 but this doesn't follow
> +		 * the format of the IIO which is Temp = (RAW + OFFSET) * SCALE.
> +		 * Hence using some rearranging we get the scale as -110.497238
> +		 * and offset as -2079.25.
> +		 */
> +		.temp_offset = {
> +			.integer = -2079,
> +			.decimal = 250000,
> +		},
> +	},
> +};
> +EXPORT_SYMBOL_NS_GPL(adxl35x_chip_info, IIO_ADXL355);
> +
>  enum adxl355_op_mode {
>  	ADXL355_MEASUREMENT,
>  	ADXL355_STANDBY,
> @@ -162,6 +217,7 @@ static const struct adxl355_chan_info adxl355_chans[] = {
>  };
>  
>  struct adxl355_data {
> +	const struct adxl355_chip_info *chip_info;
>  	struct regmap *regmap;
>  	struct device *dev;
>  	struct mutex lock; /* lock to protect op_mode */
> @@ -456,33 +512,23 @@ static int adxl355_read_raw(struct iio_dev *indio_dev,
>  
>  	case IIO_CHAN_INFO_SCALE:
>  		switch (chan->type) {
> -		/*
> -		 * The datasheet defines an intercept of 1885 LSB at 25 degC
> -		 * and a slope of -9.05 LSB/C. The following formula can be used
> -		 * to find the temperature:
> -		 * Temp = ((RAW - 1885)/(-9.05)) + 25 but this doesn't follow
> -		 * the format of the IIO which is Temp = (RAW + OFFSET) * SCALE.
> -		 * Hence using some rearranging we get the scale as -110.497238
> -		 * and offset as -2111.25.
> -		 */
>  		case IIO_TEMP:
> +			/* Temperature scale is -110.497238.

Wrong comment syntax for IIO...

> +			 * See the detailed explanation in adxl35x_chip_info definition above.
> +			 */

...

> diff --git a/drivers/iio/accel/adxl355_i2c.c b/drivers/iio/accel/adxl355_i2c.c
> index f67d57921c81..6cde5ccac06b 100644
> --- a/drivers/iio/accel/adxl355_i2c.c
> +++ b/drivers/iio/accel/adxl355_i2c.c
> @@ -23,6 +23,20 @@ static const struct regmap_config adxl355_i2c_regmap_config = {
>  static int adxl355_i2c_probe(struct i2c_client *client)
>  {
>  	struct regmap *regmap;
> +	const struct adxl355_chip_info *chip_data;
> +	const struct i2c_device_id *adxl355;
> +
> +	chip_data = device_get_match_data(&client->dev);
> +	if (!chip_data) {
> +		adxl355 = to_i2c_driver(client->dev.driver)->id_table;
> +		if (!adxl355)
> +			return -EINVAL;
> +
> +		chip_data = (void *)i2c_match_id(adxl355, client)->driver_data;

Will will shortly have a nice function to wrap this up in a similar fashion to
done for spi_get_device_id()

> +
> +		if (!chip_data)
> +			return -EINVAL;
> +	}

