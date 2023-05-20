Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8605A70A8F3
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 18:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231694AbjETQBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 12:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjETQBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 12:01:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D29EF103;
        Sat, 20 May 2023 09:01:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 68BF5611AD;
        Sat, 20 May 2023 16:01:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76382C433D2;
        Sat, 20 May 2023 16:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684598498;
        bh=MdQooeElfsooN2WS+bp+2quLDk/tTcKEvG92kyMIT00=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HIXQEXQG+CtPaTE7rTy1zQtkAtA8lmHEXOY/FUggY5Bj6bi7VFIZYE8lNHc9uxWpp
         Y5kzfz3wV223kQ/vmijFnSYGztC28r7RH6IDRKbjnNmUse05UWYbsPuMZGzqJyyn7f
         21cXSWcohekgghbBpxQTskbp+W3Lk+YiumSBwsR02s2OoEeWtTqNBwEHfwhrJbwQRt
         ZUIL0HQmnYZA38JKzuiWHqne8//O/SRI6Vu7qYd0JCUtgTA7uDCkLtoi749WoR9BWH
         p6PIfdhH8X/i4G5JAuBwd0bC/317uVWAlBXh7GdOmaaMttPUPFset1MRtoHnpBugqj
         A9ak9AJD3RTxg==
Date:   Sat, 20 May 2023 17:17:48 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Astrid Rost <astrid.rost@axis.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel@axis.com>,
        Uwe =?UTF-8?B?S2xlaW5l?= =?UTF-8?B?LUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>,
        Mathieu Othacehe <m.othacehe@gmail.com>
Subject: Re: [PATCH v3 5/7] iio: light: vcnl4000: Add period for
 vcnl4040/4200
Message-ID: <20230520171748.5ff504de@jic23-huawei>
In-Reply-To: <20230517151406.368219-6-astrid.rost@axis.com>
References: <20230517151406.368219-1-astrid.rost@axis.com>
        <20230517151406.368219-6-astrid.rost@axis.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 May 2023 17:14:04 +0200
Astrid Rost <astrid.rost@axis.com> wrote:

> Add read/write attribute for proximity and illuminance period.
> The period is set in the interrupt persistence flags
> (PS_PERS and ALS_PERS). An interrupt will not be asserted if the raw
> value is not over (or lower) than the threshold for the set
> continued amount of measurements.
> The time in seconds is calculated by the number of continued refreshes
> multiplied with the integration time.
> It will always pick the next lower possible value. The period changes,
> if the integration time is changed.
> 
> Signed-off-by: Astrid Rost <astrid.rost@axis.com>
Hi Astrid,

A few minor things inline.  I might have ignored these but given the
bot found an issue it seemed sensible to suggest tidying them up for v4.

Jonathan

> ---
>  drivers/iio/light/vcnl4000.c | 255 ++++++++++++++++++++++++++++++-----
>  1 file changed, 220 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
> index 73158bde5686..a0b99f82f8c4 100644
> --- a/drivers/iio/light/vcnl4000.c
> +++ b/drivers/iio/light/vcnl4000.c
> @@ -84,8 +84,10 @@
>  #define VCNL4040_ALS_CONF_ALS_SHUTDOWN	BIT(0)
>  #define VCNL4040_ALS_CONF_IT		GENMASK(7, 6) /* Ambient integration time */
>  #define VCNL4040_ALS_CONF_INT_EN	BIT(1) /* Ambient light Interrupt enable */
> +#define VCNL4040_ALS_CONF_PERS	GENMASK(3, 2) /* Ambient interrupt persistence setting */
>  #define VCNL4040_PS_CONF1_PS_SHUTDOWN	BIT(0)
>  #define VCNL4040_PS_CONF2_PS_IT	GENMASK(3, 1) /* Proximity integration time */
> +#define VCNL4040_CONF1_PS_PERS	GENMASK(5, 4) /* Proximity interrupt persistence setting */
>  #define VCNL4040_PS_CONF2_PS_INT	GENMASK(9, 8) /* Proximity interrupt mode */
>  #define VCNL4040_PS_IF_AWAY		BIT(8) /* Proximity event cross low threshold */
>  #define VCNL4040_PS_IF_CLOSE		BIT(9) /* Proximity event cross high threshold */
> @@ -152,6 +154,8 @@ static const int vcnl4200_als_it_times[][2] = {
>  	{0, 200000},
>  	{0, 400000},
>  };
> +static const int vcnl4040_als_persistence[] = {1, 2, 4, 8};
> +static const int vcnl4040_ps_persistence[] = {1, 2, 3, 4};
>  
>  #define VCNL4000_SLEEP_DELAY_MS	2000 /* before we enter pm_runtime_suspend */
>  
> @@ -646,6 +650,135 @@ static ssize_t vcnl4040_write_ps_it(struct vcnl4000_data *data, int val)
>  	return ret;
>  }
>  
> +static ssize_t vcnl4040_read_als_period(struct vcnl4000_data *data, int *val, int *val2)
> +{
> +	int ret, ret_pers, ret_it;
> +	int64_t val_c;
> +
> +	ret = i2c_smbus_read_word_data(data->client, VCNL4200_AL_CONF);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret_pers = FIELD_GET(VCNL4040_ALS_CONF_PERS, ret);
> +
> +	if (ret_pers >= ARRAY_SIZE(vcnl4040_als_persistence))
> +		return -EINVAL;
> +
> +	ret_it = FIELD_GET(VCNL4040_ALS_CONF_IT, ret);
> +
> +	if (ret_it >= data->chip_spec->num_als_it_times)
> +		return -EINVAL;
> +
> +	val_c = mul_u32_u32((*data->chip_spec->als_it_times)[ret_it][1],
> +	      vcnl4040_als_persistence[ret_pers]);
> +	*val = div_u64_rem(val_c, 1000000, val2);
> +
> +	return IIO_VAL_INT_PLUS_MICRO;
> +}
> +
> +static ssize_t vcnl4040_write_als_period(struct vcnl4000_data *data, int val, int val2)
> +{
> +	unsigned int index;
> +	int ret, ret_it;
> +	u16 regval;
> +	int64_t val_n = mul_u32_u32(val, 1000000) + val2;

Could use MICRO define from units.h to make this more obvious.
Same in other new cases of multiplying by 10^6

> +
> +	ret = i2c_smbus_read_word_data(data->client, VCNL4200_AL_CONF);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret_it = FIELD_GET(VCNL4040_ALS_CONF_IT, ret);
> +
> +	if (ret_it >= data->chip_spec->num_als_it_times)
> +		return -EINVAL;
> +
> +	for (index = 0; index < ARRAY_SIZE(vcnl4040_als_persistence) - 1; index++)
> +		if (val_n < mul_u32_u32(vcnl4040_als_persistence[index],
> +				(*data->chip_spec->als_it_times)[ret_it][1]))
> +			break;
> +
> +	mutex_lock(&data->vcnl4000_lock);
> +
> +	ret = i2c_smbus_read_word_data(data->client, VCNL4200_AL_CONF);
> +	if (ret < 0)
> +		goto out;
> +
> +	regval = (ret & ~VCNL4040_ALS_CONF_PERS) |
> +	    FIELD_PREP(VCNL4040_ALS_CONF_PERS, index);
> +	ret = i2c_smbus_write_word_data(data->client, VCNL4200_AL_CONF,
> +					regval);
> +
> +out:
> +	mutex_unlock(&data->vcnl4000_lock);
> +	return ret;
> +}

...

> +static ssize_t vcnl4040_write_ps_period(struct vcnl4000_data *data, int val, int val2)
> +{
> +	int ret, ret_it, index;
> +	u16 regval;
> +
> +	ret = i2c_smbus_read_word_data(data->client, VCNL4200_PS_CONF1);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret_it = FIELD_GET(VCNL4040_PS_CONF2_PS_IT, ret);
> +
> +	if (ret_it >= data->chip_spec->num_ps_it_times)
> +		return -EINVAL;
> +
> +	if (val > 9)
> +		index = ARRAY_SIZE(vcnl4040_ps_persistence) - 1;
> +	else {
> +		for (index = 0; index < ARRAY_SIZE(vcnl4040_ps_persistence) - 1; index++) {
> +			if (val2 <= vcnl4040_ps_persistence[index]
> +					* (*data->chip_spec->ps_it_times)[ret_it][1])
> +				break;
> +		}
> +	}
> +
> +	mutex_lock(&data->vcnl4000_lock);
> +
> +	ret = i2c_smbus_read_word_data(data->client, VCNL4200_PS_CONF1);
> +	if (ret < 0)
> +		goto out;
> +
> +	regval = (ret & ~VCNL4040_CONF1_PS_PERS) |
> +	    FIELD_PREP(VCNL4040_CONF1_PS_PERS, index);
> +	ret = i2c_smbus_write_word_data(data->client, VCNL4200_PS_CONF1,
> +					regval);
> +
> +out:
> +	mutex_unlock(&data->vcnl4000_lock);
> +	return ret;
> +}
> +

Trivial but as you are going around again: One blank line is enough.

> +
>  static int vcnl4000_read_raw(struct iio_dev *indio_dev,
>  				struct iio_chan_spec const *chan,
