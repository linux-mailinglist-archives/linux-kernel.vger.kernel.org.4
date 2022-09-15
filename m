Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 542A95B9DCC
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 16:55:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230339AbiIOOy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 10:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbiIOOyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 10:54:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B0023D5B9;
        Thu, 15 Sep 2022 07:54:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AA28A624B6;
        Thu, 15 Sep 2022 14:54:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B9CFC433C1;
        Thu, 15 Sep 2022 14:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663253687;
        bh=9SSMerRgvEAnF1+q9niiJ/NULx9LoHqC7BnQpUnclSg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=n+m6bVEIvgxwb4wcdUFyCuOqpcSD5as4OljLZvRTX3J6zVxM5Eem8G3/kMRunn9BE
         8yZeUiT98oyQhbyUr6LI/W9fibk66hlPLv2wlAvsHlriKRFZBIgE4Z/PN3m/jBjK+e
         TQsyiw8k4x0OVnSM/JFAm2h539mcr+VGrhcfTIDLz/Te1lQhb8DEmqa9m7WhboO74y
         DTDlxuG9L9s3UEkj+GifMgqEf+Rd2L6ma5dfM+vwoH0u2lZdboS2hkw1r2UPPelFWE
         cQ2+m4g4bnz+Br7OyiOigVHjuOaQRJjg+IlCu7pqJrKm82KCqjqHSCmE+mmGK6fHVH
         wEfa/utSio8Yg==
Date:   Thu, 15 Sep 2022 15:54:47 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Angel Iglesias <ang.iglesiasg@gmail.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/9] iio: pressure: bmp280: use FIELD_GET, FIELD_PREP
 and GENMASK
Message-ID: <20220915155424.5061b005@jic23-huawei>
In-Reply-To: <3cbe56f29c2a46bc5dc23c5b72e1b43c9207f44d.1663025017.git.ang.iglesiasg@gmail.com>
References: <cover.1663025017.git.ang.iglesiasg@gmail.com>
        <3cbe56f29c2a46bc5dc23c5b72e1b43c9207f44d.1663025017.git.ang.iglesiasg@gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
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

On Tue, 13 Sep 2022 01:45:49 +0200
Angel Iglesias <ang.iglesiasg@gmail.com> wrote:

> Cleaned and simplified register values construction and extraction
> converting to use FIELD_PREP and FIELD_GET macros.
> 
> Replaced hardcoded bit masks with GENMASK macro.
> 
> Signed-off-by: Angel Iglesias <ang.iglesiasg@gmail.com>
Random thought whilst checking this..

I wonder how many users a FIELD_GET_SIGNED() would have
with the assumption it returned a sign extended value...

Anyhow, I'm picking up these patches as I look through
them (mainly because I'm waiting for a late flight and not
sure how far I'll get!)

So applied up to here so far...

Jonathan

> ---
>  drivers/iio/pressure/bmp280-core.c | 25 ++++++----
>  drivers/iio/pressure/bmp280.h      | 78 ++++++++++++++++--------------
>  2 files changed, 57 insertions(+), 46 deletions(-)
> 
> diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
> index 42b29f30e9d1..0ba4ff999f33 100644
> --- a/drivers/iio/pressure/bmp280-core.c
> +++ b/drivers/iio/pressure/bmp280-core.c
> @@ -16,6 +16,8 @@
>  
>  #define pr_fmt(fmt) "bmp280: " fmt
>  
> +#include <linux/bitops.h>
> +#include <linux/bitfield.h>
>  #include <linux/device.h>
>  #include <linux/module.h>
>  #include <linux/regmap.h>
> @@ -242,7 +244,7 @@ static int bmp280_read_calib(struct bmp280_data *data,
>  		dev_err(dev, "failed to read H5 comp value\n");
>  		return ret;
>  	}
> -	calib->H5 = sign_extend32(((le16_to_cpu(l16) >> 4) & 0xfff), 11);
> +	calib->H5 = sign_extend32(FIELD_GET(BMP280_COMP_H5_MASK, le16_to_cpu(l16)), 11);
>  
>  	ret = regmap_read(data->regmap, BMP280_REG_COMP_H6, &tmp);
>  	if (ret < 0) {
> @@ -346,7 +348,7 @@ static int bmp280_read_temp(struct bmp280_data *data,
>  		return ret;
>  	}
>  
> -	adc_temp = be32_to_cpu(tmp) >> 12;
> +	adc_temp = FIELD_GET(BMP280_MEAS_TRIM_MASK, be32_to_cpu(tmp));
>  	if (adc_temp == BMP280_TEMP_SKIPPED) {
>  		/* reading was skipped */
>  		dev_err(data->dev, "reading temperature skipped\n");
> @@ -385,7 +387,7 @@ static int bmp280_read_press(struct bmp280_data *data,
>  		return ret;
>  	}
>  
> -	adc_press = be32_to_cpu(tmp) >> 12;
> +	adc_press = FIELD_GET(BMP280_MEAS_TRIM_MASK, be32_to_cpu(tmp));
>  	if (adc_press == BMP280_PRESS_SKIPPED) {
>  		/* reading was skipped */
>  		dev_err(data->dev, "reading pressure skipped\n");
> @@ -611,8 +613,8 @@ static const struct iio_info bmp280_info = {
>  
>  static int bmp280_chip_config(struct bmp280_data *data)
>  {
> -	u8 osrs = BMP280_OSRS_TEMP_X(data->oversampling_temp + 1) |
> -		  BMP280_OSRS_PRESS_X(data->oversampling_press + 1);
> +	u8 osrs = FIELD_PREP(BMP280_OSRS_TEMP_MASK, data->oversampling_temp + 1) |
> +		  FIELD_PREP(BMP280_OSRS_PRESS_MASK, data->oversampling_press + 1);
>  	int ret;
>  
>  	ret = regmap_write_bits(data->regmap, BMP280_REG_CTRL_MEAS,
> @@ -654,7 +656,7 @@ static const struct bmp280_chip_info bmp280_chip_info = {
>  
>  static int bme280_chip_config(struct bmp280_data *data)
>  {
> -	u8 osrs = BMP280_OSRS_HUMIDITIY_X(data->oversampling_humid + 1);
> +	u8 osrs = FIELD_PREP(BMP280_OSRS_HUMIDITY_MASK, data->oversampling_humid + 1);
>  	int ret;
>  
>  	/*
> @@ -711,7 +713,7 @@ static int bmp180_measure(struct bmp280_data *data, u8 ctrl_meas)
>  		if (!ret)
>  			dev_err(data->dev, "timeout waiting for completion\n");
>  	} else {
> -		if (ctrl_meas == BMP180_MEAS_TEMP)
> +		if (FIELD_GET(BMP180_MEAS_CTRL_MASK, ctrl_meas) == BMP180_MEAS_TEMP)
>  			delay_us = 4500;
>  		else
>  			delay_us =
> @@ -736,7 +738,9 @@ static int bmp180_read_adc_temp(struct bmp280_data *data, int *val)
>  	__be16 tmp;
>  	int ret;
>  
> -	ret = bmp180_measure(data, BMP180_MEAS_TEMP);
> +	ret = bmp180_measure(data,
> +			     FIELD_PREP(BMP180_MEAS_CTRL_MASK, BMP180_MEAS_TEMP) |
> +			     BMP180_MEAS_SCO);
>  	if (ret)
>  		return ret;
>  
> @@ -833,7 +837,10 @@ static int bmp180_read_adc_press(struct bmp280_data *data, int *val)
>  	__be32 tmp = 0;
>  	int ret;
>  
> -	ret = bmp180_measure(data, BMP180_MEAS_PRESS_X(oss));
> +	ret = bmp180_measure(data,
> +			     FIELD_PREP(BMP180_MEAS_CTRL_MASK, BMP180_MEAS_PRESS) |
> +			     FIELD_PREP(BMP180_OSRS_PRESS_MASK, oss) |
> +			     BMP180_MEAS_SCO);
>  	if (ret)
>  		return ret;
>  
> diff --git a/drivers/iio/pressure/bmp280.h b/drivers/iio/pressure/bmp280.h
> index 57ba0e85db91..4a501836d27a 100644
> --- a/drivers/iio/pressure/bmp280.h
> +++ b/drivers/iio/pressure/bmp280.h
> @@ -13,6 +13,9 @@
>  #define BMP280_REG_PRESS_LSB		0xF8
>  #define BMP280_REG_PRESS_MSB		0xF7
>  
> +/* Helper mask to truncate excess 12 bits on pressure and temp readings */
> +#define BMP280_MEAS_TRIM_MASK		GENMASK(31, 12)
> +
>  #define BMP280_REG_CONFIG		0xF5
>  #define BMP280_REG_CTRL_MEAS		0xF4
>  #define BMP280_REG_STATUS		0xF3
> @@ -32,44 +35,43 @@
>  #define BMP280_REG_COMP_PRESS_START	0x8E
>  #define BMP280_COMP_PRESS_REG_COUNT	18
>  
> -#define BMP280_FILTER_MASK		(BIT(4) | BIT(3) | BIT(2))
> +#define BMP280_COMP_H5_MASK		GENMASK(15, 4)
> +
> +#define BMP280_FILTER_MASK		GENMASK(4, 2)
>  #define BMP280_FILTER_OFF		0
> -#define BMP280_FILTER_2X		BIT(2)
> -#define BMP280_FILTER_4X		BIT(3)
> -#define BMP280_FILTER_8X		(BIT(3) | BIT(2))
> -#define BMP280_FILTER_16X		BIT(4)
> +#define BMP280_FILTER_2X		1
> +#define BMP280_FILTER_4X		2
> +#define BMP280_FILTER_8X		3
> +#define BMP280_FILTER_16X		4
>  
> -#define BMP280_OSRS_HUMIDITY_MASK	(BIT(2) | BIT(1) | BIT(0))
> -#define BMP280_OSRS_HUMIDITIY_X(osrs_h)	((osrs_h) << 0)
> +#define BMP280_OSRS_HUMIDITY_MASK	GENMASK(2, 0)
>  #define BMP280_OSRS_HUMIDITY_SKIP	0
> -#define BMP280_OSRS_HUMIDITY_1X		BMP280_OSRS_HUMIDITIY_X(1)
> -#define BMP280_OSRS_HUMIDITY_2X		BMP280_OSRS_HUMIDITIY_X(2)
> -#define BMP280_OSRS_HUMIDITY_4X		BMP280_OSRS_HUMIDITIY_X(3)
> -#define BMP280_OSRS_HUMIDITY_8X		BMP280_OSRS_HUMIDITIY_X(4)
> -#define BMP280_OSRS_HUMIDITY_16X	BMP280_OSRS_HUMIDITIY_X(5)
> +#define BMP280_OSRS_HUMIDITY_1X		1
> +#define BMP280_OSRS_HUMIDITY_2X		2
> +#define BMP280_OSRS_HUMIDITY_4X		3
> +#define BMP280_OSRS_HUMIDITY_8X		4
> +#define BMP280_OSRS_HUMIDITY_16X	5
>  
> -#define BMP280_OSRS_TEMP_MASK		(BIT(7) | BIT(6) | BIT(5))
> +#define BMP280_OSRS_TEMP_MASK		GENMASK(7, 5)
>  #define BMP280_OSRS_TEMP_SKIP		0
> -#define BMP280_OSRS_TEMP_X(osrs_t)	((osrs_t) << 5)
> -#define BMP280_OSRS_TEMP_1X		BMP280_OSRS_TEMP_X(1)
> -#define BMP280_OSRS_TEMP_2X		BMP280_OSRS_TEMP_X(2)
> -#define BMP280_OSRS_TEMP_4X		BMP280_OSRS_TEMP_X(3)
> -#define BMP280_OSRS_TEMP_8X		BMP280_OSRS_TEMP_X(4)
> -#define BMP280_OSRS_TEMP_16X		BMP280_OSRS_TEMP_X(5)
> -
> -#define BMP280_OSRS_PRESS_MASK		(BIT(4) | BIT(3) | BIT(2))
> +#define BMP280_OSRS_TEMP_1X		1
> +#define BMP280_OSRS_TEMP_2X		2
> +#define BMP280_OSRS_TEMP_4X		3
> +#define BMP280_OSRS_TEMP_8X		4
> +#define BMP280_OSRS_TEMP_16X		5
> +
> +#define BMP280_OSRS_PRESS_MASK		GENMASK(4, 2)
>  #define BMP280_OSRS_PRESS_SKIP		0
> -#define BMP280_OSRS_PRESS_X(osrs_p)	((osrs_p) << 2)
> -#define BMP280_OSRS_PRESS_1X		BMP280_OSRS_PRESS_X(1)
> -#define BMP280_OSRS_PRESS_2X		BMP280_OSRS_PRESS_X(2)
> -#define BMP280_OSRS_PRESS_4X		BMP280_OSRS_PRESS_X(3)
> -#define BMP280_OSRS_PRESS_8X		BMP280_OSRS_PRESS_X(4)
> -#define BMP280_OSRS_PRESS_16X		BMP280_OSRS_PRESS_X(5)
> -
> -#define BMP280_MODE_MASK		(BIT(1) | BIT(0))
> +#define BMP280_OSRS_PRESS_1X		1
> +#define BMP280_OSRS_PRESS_2X		2
> +#define BMP280_OSRS_PRESS_4X		3
> +#define BMP280_OSRS_PRESS_8X		4
> +#define BMP280_OSRS_PRESS_16X		5
> +
> +#define BMP280_MODE_MASK		GENMASK(1, 0)
>  #define BMP280_MODE_SLEEP		0
> -#define BMP280_MODE_FORCED		BIT(0)
> -#define BMP280_MODE_NORMAL		(BIT(1) | BIT(0))
> +#define BMP280_MODE_FORCED		1
> +#define BMP280_MODE_NORMAL		3
>  
>  /* BMP180 specific registers */
>  #define BMP180_REG_OUT_XLSB		0xF8
> @@ -79,13 +81,15 @@
>  #define BMP180_REG_CALIB_START		0xAA
>  #define BMP180_REG_CALIB_COUNT		22
>  
> +#define BMP180_MEAS_CTRL_MASK		GENMASK(4, 0)
> +#define BMP180_MEAS_TEMP		0x0E
> +#define BMP180_MEAS_PRESS		0x14
>  #define BMP180_MEAS_SCO			BIT(5)
> -#define BMP180_MEAS_TEMP		(0x0E | BMP180_MEAS_SCO)
> -#define BMP180_MEAS_PRESS_X(oss)	((oss) << 6 | 0x14 | BMP180_MEAS_SCO)
> -#define BMP180_MEAS_PRESS_1X		BMP180_MEAS_PRESS_X(0)
> -#define BMP180_MEAS_PRESS_2X		BMP180_MEAS_PRESS_X(1)
> -#define BMP180_MEAS_PRESS_4X		BMP180_MEAS_PRESS_X(2)
> -#define BMP180_MEAS_PRESS_8X		BMP180_MEAS_PRESS_X(3)
> +#define BMP180_OSRS_PRESS_MASK		GENMASK(7, 6)
> +#define BMP180_MEAS_PRESS_1X		0
> +#define BMP180_MEAS_PRESS_2X		1
> +#define BMP180_MEAS_PRESS_4X		2
> +#define BMP180_MEAS_PRESS_8X		3
>  
>  /* BMP180 and BMP280 common registers */
>  #define BMP280_REG_CTRL_MEAS		0xF4

