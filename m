Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 490A75B9DE5
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 16:57:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbiIOO5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 10:57:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbiIOO5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 10:57:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C62EB83042;
        Thu, 15 Sep 2022 07:57:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CDFBBB8212E;
        Thu, 15 Sep 2022 14:57:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FAE5C433C1;
        Thu, 15 Sep 2022 14:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663253862;
        bh=zC/4TNClKqfGeJHSvCyVQfKIVXftcz349TXx7htkS8w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AQNA5VkxHaWz6DX1kzzHJwvTZHDcjtM/3dkft2IS55EwOzvIPpqIN4Jj1BN8G3w8G
         7wTNC/hJj+ZT+ObEGB9eo49erg7nL5hvKhe7aj534JacA5eSxVRCjv+YErbwHlToDR
         u3Z9r7ITVE4YI7FO2WpBIH+5TpXKrXlOLoDrLvwP4Kv6h0jkwHKZe4M3dfLP9gsgYC
         fLraSuhz0ZS530CYskF5S/XZRKZrW/YoYnn2O7TEZHQusaTS4xF/EZOkFXz8Y1lHtv
         Tlja/Shf3xyGIREaka5qV1vs10BwD8cF7soOYJJ0/ottt5X3c8x6VKIY7RBvpYOH3d
         I3xZf8qDzOG6g==
Date:   Thu, 15 Sep 2022 15:57:41 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Angel Iglesias <ang.iglesiasg@gmail.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Paul Cercueil <paul@crapouillou.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 3/9] iio: pressure: bmp280: Simplify bmp280
 calibration data reading
Message-ID: <20220915155741.2c19e927@jic23-huawei>
In-Reply-To: <96d81282c95006d857f4d836d2ff3ee0740a85a0.1663025017.git.ang.iglesiasg@gmail.com>
References: <cover.1663025017.git.ang.iglesiasg@gmail.com>
        <96d81282c95006d857f4d836d2ff3ee0740a85a0.1663025017.git.ang.iglesiasg@gmail.com>
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

On Tue, 13 Sep 2022 01:46:42 +0200
Angel Iglesias <ang.iglesiasg@gmail.com> wrote:

> On bmp280 and bme280, the temperature and pressure calibration parameters
> are available on a contiguous memory region. Considering this arrangement,
> simplified the calibration reading function by using only one buffer
> to read in batch temperature and pressure registers.
> 
> Signed-off-by: Angel Iglesias <ang.iglesiasg@gmail.com>
Applied.  Apparently we have a plane, so I'll stop here for now...

Jonathan

> ---
>  drivers/iio/pressure/bmp280-core.c | 58 ++++++++++++------------------
>  drivers/iio/pressure/bmp280.h      |  3 ++
>  2 files changed, 26 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
> index 0ba4ff999f33..4793bcd9f0b3 100644
> --- a/drivers/iio/pressure/bmp280-core.c
> +++ b/drivers/iio/pressure/bmp280-core.c
> @@ -128,8 +128,7 @@ struct bmp280_chip_info {
>   * These enums are used for indexing into the array of compensation
>   * parameters for BMP280.
>   */
> -enum { T1, T2, T3 };
> -enum { P1, P2, P3, P4, P5, P6, P7, P8, P9 };
> +enum { T1, T2, T3, P1, P2, P3, P4, P5, P6, P7, P8, P9 };
>  
>  static const struct iio_chan_spec bmp280_channels[] = {
>  	{
> @@ -153,8 +152,7 @@ static int bmp280_read_calib(struct bmp280_data *data,
>  			     struct bmp280_calib *calib,
>  			     unsigned int chip)
>  {
> -	__le16 p_buf[BMP280_COMP_PRESS_REG_COUNT / 2];
> -	__le16 t_buf[BMP280_COMP_TEMP_REG_COUNT / 2];
> +	__le16 c_buf[BMP280_CONTIGUOUS_CALIB_REGS / 2];
>  	struct device *dev = data->dev;
>  	unsigned int tmp;
>  	__le16 l16;
> @@ -162,43 +160,33 @@ static int bmp280_read_calib(struct bmp280_data *data,
>  	int ret;
>  
>  
> -	/* Read temperature calibration values. */
> +	/* Read temperature and pressure calibration values. */
>  	ret = regmap_bulk_read(data->regmap, BMP280_REG_COMP_TEMP_START,
> -			       t_buf, BMP280_COMP_TEMP_REG_COUNT);
> +			       c_buf, sizeof(c_buf));
>  	if (ret < 0) {
>  		dev_err(data->dev,
> -			"failed to read temperature calibration parameters\n");
> +			"failed to read temperature and pressure calibration parameters\n");
>  		return ret;
>  	}
>  
> -	/* Toss the temperature calibration data into the entropy pool */
> -	add_device_randomness(t_buf, sizeof(t_buf));
> -
> -	calib->T1 = le16_to_cpu(t_buf[T1]);
> -	calib->T2 = le16_to_cpu(t_buf[T2]);
> -	calib->T3 = le16_to_cpu(t_buf[T3]);
> -
> -	/* Read pressure calibration values. */
> -	ret = regmap_bulk_read(data->regmap, BMP280_REG_COMP_PRESS_START,
> -			       p_buf, BMP280_COMP_PRESS_REG_COUNT);
> -	if (ret < 0) {
> -		dev_err(data->dev,
> -			"failed to read pressure calibration parameters\n");
> -		return ret;
> -	}
> -
> -	/* Toss the pressure calibration data into the entropy pool */
> -	add_device_randomness(p_buf, sizeof(p_buf));
> -
> -	calib->P1 = le16_to_cpu(p_buf[P1]);
> -	calib->P2 = le16_to_cpu(p_buf[P2]);
> -	calib->P3 = le16_to_cpu(p_buf[P3]);
> -	calib->P4 = le16_to_cpu(p_buf[P4]);
> -	calib->P5 = le16_to_cpu(p_buf[P5]);
> -	calib->P6 = le16_to_cpu(p_buf[P6]);
> -	calib->P7 = le16_to_cpu(p_buf[P7]);
> -	calib->P8 = le16_to_cpu(p_buf[P8]);
> -	calib->P9 = le16_to_cpu(p_buf[P9]);
> +	/* Toss the temperature and pressure calibration data into the entropy pool */
> +	add_device_randomness(c_buf, sizeof(c_buf));
> +
> +	/* Parse temperature calibration values. */
> +	calib->T1 = le16_to_cpu(c_buf[T1]);
> +	calib->T2 = le16_to_cpu(c_buf[T2]);
> +	calib->T3 = le16_to_cpu(c_buf[T3]);
> +
> +	/* Parse pressure calibration values. */
> +	calib->P1 = le16_to_cpu(c_buf[P1]);
> +	calib->P2 = le16_to_cpu(c_buf[P2]);
> +	calib->P3 = le16_to_cpu(c_buf[P3]);
> +	calib->P4 = le16_to_cpu(c_buf[P4]);
> +	calib->P5 = le16_to_cpu(c_buf[P5]);
> +	calib->P6 = le16_to_cpu(c_buf[P6]);
> +	calib->P7 = le16_to_cpu(c_buf[P7]);
> +	calib->P8 = le16_to_cpu(c_buf[P8]);
> +	calib->P9 = le16_to_cpu(c_buf[P9]);
>  
>  	/*
>  	 * Read humidity calibration values.
> diff --git a/drivers/iio/pressure/bmp280.h b/drivers/iio/pressure/bmp280.h
> index 4a501836d27a..03a539223417 100644
> --- a/drivers/iio/pressure/bmp280.h
> +++ b/drivers/iio/pressure/bmp280.h
> @@ -37,6 +37,9 @@
>  
>  #define BMP280_COMP_H5_MASK		GENMASK(15, 4)
>  
> +#define BMP280_CONTIGUOUS_CALIB_REGS	(BMP280_COMP_TEMP_REG_COUNT + \
> +					 BMP280_COMP_PRESS_REG_COUNT)
> +
>  #define BMP280_FILTER_MASK		GENMASK(4, 2)
>  #define BMP280_FILTER_OFF		0
>  #define BMP280_FILTER_2X		1

