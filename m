Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C91560926A
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 13:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbiJWLGH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 07:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbiJWLGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 07:06:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6177D60EBD;
        Sun, 23 Oct 2022 04:06:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 00D11B80D1A;
        Sun, 23 Oct 2022 11:06:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0544C433D6;
        Sun, 23 Oct 2022 11:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666523160;
        bh=8rOlNiffgPzLVub62XDxQM2DQLZXmwSEQjbUkRpZbA8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hKHwWy12Da7ZqAGPfm/DRBTKABGmHkjr0caS2HvWJPfYirvuDMut2SLFWfCbWeYs+
         eFykS0mjJYEI4KuDy/g9qqoxXu72emwfiHvCeVxRdiSL7r9BxqkgMkXHYAP/Eytx4L
         29vpk3BqVoQHbfWWQJDhFPQzYeEqHnPR3itH2GWTANRODsVLouQA6ifFI9FYHRkBig
         txXpv5gKioZdeFj44B0V7fy2hXnl26b5dYrKBJDqmyblv8sAqvihbLZdbZOpnuX8JJ
         CmxguN+lT3pKTNXVJ6v9JAUId/KSFRaBT+aPPLFt6JOfPXhZjx7r2TCoBVvvSxF0cp
         4edcEcFE0wCFA==
Date:   Sun, 23 Oct 2022 12:06:34 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mitja Spes <mitja@lxnav.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        =?UTF-8?B?SsOpcsO0bWU=?= Pouiller <jerome.pouiller@silabs.com>,
        Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>,
        Tomasz Duszynski <tduszyns@gmail.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] iio: pressure: ms5611: fixed value compensation
 bug
Message-ID: <20221023120634.0dda4b5f@jic23-huawei>
In-Reply-To: <20221021135827.1444793-2-mitja@lxnav.com>
References: <20221021135827.1444793-1-mitja@lxnav.com>
        <20221021135827.1444793-2-mitja@lxnav.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
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

On Fri, 21 Oct 2022 15:58:20 +0200
Mitja Spes <mitja@lxnav.com> wrote:

> When using multiple instances of this driver the compensation PROM was
> overwritten by the last initialized sensor. Now each sensor has own PROM
> storage.
> 
> Signed-off-by: Mitja Spes <mitja@lxnav.com>
Fixes tag?

I think this is one we will want to backport. 

> ---
>  drivers/iio/pressure/ms5611.h      | 12 +++----
>  drivers/iio/pressure/ms5611_core.c | 51 ++++++++++++++++--------------
>  2 files changed, 31 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/iio/pressure/ms5611.h b/drivers/iio/pressure/ms5611.h
> index cbc9349c342a..550b75b7186f 100644
> --- a/drivers/iio/pressure/ms5611.h
> +++ b/drivers/iio/pressure/ms5611.h
> @@ -25,13 +25,6 @@ enum {
>  	MS5607,
>  };
>  
> -struct ms5611_chip_info {
> -	u16 prom[MS5611_PROM_WORDS_NB];
> -
> -	int (*temp_and_pressure_compensate)(struct ms5611_chip_info *chip_info,
> -					    s32 *temp, s32 *pressure);
> -};
> -
>  /*
>   * OverSampling Rate descriptor.
>   * Warning: cmd MUST be kept aligned on a word boundary (see
> @@ -50,12 +43,15 @@ struct ms5611_state {
>  	const struct ms5611_osr *pressure_osr;
>  	const struct ms5611_osr *temp_osr;
>  
> +	u16 prom[MS5611_PROM_WORDS_NB];
> +
>  	int (*reset)(struct ms5611_state *st);
>  	int (*read_prom_word)(struct ms5611_state *st, int index, u16 *word);
>  	int (*read_adc_temp_and_pressure)(struct ms5611_state *st,
>  					  s32 *temp, s32 *pressure);
>  
> -	struct ms5611_chip_info *chip_info;
> +	int (*compensate_temp_and_pressure)(struct ms5611_state *st, s32 *temp,
> +					  s32 *pressure);
>  	struct regulator *vdd;
>  };
>  
> diff --git a/drivers/iio/pressure/ms5611_core.c b/drivers/iio/pressure/ms5611_core.c
> index 717521de66c4..c564a1d6cafe 100644
> --- a/drivers/iio/pressure/ms5611_core.c
> +++ b/drivers/iio/pressure/ms5611_core.c
> @@ -85,7 +85,7 @@ static int ms5611_read_prom(struct iio_dev *indio_dev)
>  	struct ms5611_state *st = iio_priv(indio_dev);
>  
>  	for (i = 0; i < MS5611_PROM_WORDS_NB; i++) {
> -		ret = st->read_prom_word(st, i, &st->chip_info->prom[i]);
> +		ret = st->read_prom_word(st, i, &st->prom[i]);
>  		if (ret < 0) {
>  			dev_err(&indio_dev->dev,
>  				"failed to read prom at %d\n", i);
> @@ -93,7 +93,7 @@ static int ms5611_read_prom(struct iio_dev *indio_dev)
>  		}
>  	}
>  
> -	if (!ms5611_prom_is_valid(st->chip_info->prom, MS5611_PROM_WORDS_NB)) {
> +	if (!ms5611_prom_is_valid(st->prom, MS5611_PROM_WORDS_NB)) {
>  		dev_err(&indio_dev->dev, "PROM integrity check failed\n");
>  		return -ENODEV;
>  	}
> @@ -114,21 +114,20 @@ static int ms5611_read_temp_and_pressure(struct iio_dev *indio_dev,
>  		return ret;
>  	}
>  
> -	return st->chip_info->temp_and_pressure_compensate(st->chip_info,
> -							   temp, pressure);
> +	return st->compensate_temp_and_pressure(st, temp, pressure);
>  }
>  
> -static int ms5611_temp_and_pressure_compensate(struct ms5611_chip_info *chip_info,
> +static int ms5611_temp_and_pressure_compensate(struct ms5611_state *st,
>  					       s32 *temp, s32 *pressure)
>  {
>  	s32 t = *temp, p = *pressure;
>  	s64 off, sens, dt;
>  
> -	dt = t - (chip_info->prom[5] << 8);
> -	off = ((s64)chip_info->prom[2] << 16) + ((chip_info->prom[4] * dt) >> 7);
> -	sens = ((s64)chip_info->prom[1] << 15) + ((chip_info->prom[3] * dt) >> 8);
> +	dt = t - (st->prom[5] << 8);
> +	off = ((s64)st->prom[2] << 16) + ((st->prom[4] * dt) >> 7);
> +	sens = ((s64)st->prom[1] << 15) + ((st->prom[3] * dt) >> 8);
>  
> -	t = 2000 + ((chip_info->prom[6] * dt) >> 23);
> +	t = 2000 + ((st->prom[6] * dt) >> 23);
>  	if (t < 2000) {
>  		s64 off2, sens2, t2;
>  
> @@ -154,17 +153,17 @@ static int ms5611_temp_and_pressure_compensate(struct ms5611_chip_info *chip_inf
>  	return 0;
>  }
>  
> -static int ms5607_temp_and_pressure_compensate(struct ms5611_chip_info *chip_info,
> +static int ms5607_temp_and_pressure_compensate(struct ms5611_state *st,
>  					       s32 *temp, s32 *pressure)
>  {
>  	s32 t = *temp, p = *pressure;
>  	s64 off, sens, dt;
>  
> -	dt = t - (chip_info->prom[5] << 8);
> -	off = ((s64)chip_info->prom[2] << 17) + ((chip_info->prom[4] * dt) >> 6);
> -	sens = ((s64)chip_info->prom[1] << 16) + ((chip_info->prom[3] * dt) >> 7);
> +	dt = t - (st->prom[5] << 8);
> +	off = ((s64)st->prom[2] << 17) + ((st->prom[4] * dt) >> 6);
> +	sens = ((s64)st->prom[1] << 16) + ((st->prom[3] * dt) >> 7);
>  
> -	t = 2000 + ((chip_info->prom[6] * dt) >> 23);
> +	t = 2000 + ((st->prom[6] * dt) >> 23);
>  	if (t < 2000) {
>  		s64 off2, sens2, t2, tmp;
>  
> @@ -342,15 +341,6 @@ static int ms5611_write_raw(struct iio_dev *indio_dev,
>  
>  static const unsigned long ms5611_scan_masks[] = {0x3, 0};
>  
> -static struct ms5611_chip_info chip_info_tbl[] = {
> -	[MS5611] = {
> -		.temp_and_pressure_compensate = ms5611_temp_and_pressure_compensate,
> -	},
> -	[MS5607] = {
> -		.temp_and_pressure_compensate = ms5607_temp_and_pressure_compensate,
> -	}
> -};
> -
>  static const struct iio_chan_spec ms5611_channels[] = {
>  	{
>  		.type = IIO_PRESSURE,
> @@ -433,7 +423,20 @@ int ms5611_probe(struct iio_dev *indio_dev, struct device *dev,
>  	struct ms5611_state *st = iio_priv(indio_dev);
>  
>  	mutex_init(&st->lock);
> -	st->chip_info = &chip_info_tbl[type];
> +
> +	switch (type) {
> +	case MS5611:
> +		st->compensate_temp_and_pressure =
> +			ms5611_temp_and_pressure_compensate;
> +		break;
> +	case MS5607:
> +		st->compensate_temp_and_pressure =
> +			ms5607_temp_and_pressure_compensate;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
>  	st->temp_osr =
>  		&ms5611_avail_temp_osr[ARRAY_SIZE(ms5611_avail_temp_osr) - 1];
>  	st->pressure_osr =

