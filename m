Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01DD770A8F5
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 18:02:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231819AbjETQCt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 12:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjETQCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 12:02:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8336A10F;
        Sat, 20 May 2023 09:02:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 17A9860ADB;
        Sat, 20 May 2023 16:02:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F91FC433D2;
        Sat, 20 May 2023 16:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684598565;
        bh=SKin1Uhx3f3qU7fw0r0HRpUViXLBBxRacZLp7D9vtvs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=sXlZcLhXEo5gd5JFh5V1q2MKCEeiiihVJeVZ6T2RQ4GslebhRebj7cSX5byFR2pti
         iBkD4GKX0wTqHU1XIoEfXDZR19E7nGuspRtc2od2NvXACmS4s5TVRDisCEKc0hOd/P
         d/3ZTjSLcOimFDOBgNKYp7pCxjclRUqWWblu6KDu/o8DaGf+LOQ1x3Q9H9RbQp+2yp
         WYwa5fJZnAmwlmLh7jin4pTDHzMFuiwwyG9c2oX7wGNguEG/I9IHN1YlcNXjECQgkp
         iCOLRCjrkx9gONFBBacgIFjl7PuI6C+T1CwmQWOf7FLEeaAjhEKb3tMRtadGbg0lED
         nSyXIbNSOZuRw==
Date:   Sat, 20 May 2023 17:18:55 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Astrid Rost <astrid.rost@axis.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel@axis.com>,
        Uwe =?UTF-8?B?S2xlaW5l?= =?UTF-8?B?LUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>,
        Mathieu Othacehe <m.othacehe@gmail.com>
Subject: Re: [PATCH v3 7/7] iio: light: vcnl4000: Add calibration bias for
 4040/4200
Message-ID: <20230520171855.058c8256@jic23-huawei>
In-Reply-To: <20230517151406.368219-8-astrid.rost@axis.com>
References: <20230517151406.368219-1-astrid.rost@axis.com>
        <20230517151406.368219-8-astrid.rost@axis.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 May 2023 17:14:06 +0200
Astrid Rost <astrid.rost@axis.com> wrote:

> The calibration bias is setting the LED current to change
> the detection distance.
> Add read/write attribute for proximity calibration bias and read
> attribute for available values.
> This is supported for vcnl4040 and vcnl4200.
> 
> Signed-off-by: Astrid Rost <astrid.rost@axis.com>
This and other patches I didn't comment on look fine to me.

Thanks,

Jonathan

> ---
>  drivers/iio/light/vcnl4000.c | 98 ++++++++++++++++++++++++++++++++++--
>  1 file changed, 95 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
> index 631ed6aa26b2..0a6e38e56a7c 100644
> --- a/drivers/iio/light/vcnl4000.c
> +++ b/drivers/iio/light/vcnl4000.c
> @@ -91,6 +91,7 @@
>  #define VCNL4040_CONF1_PS_PERS	GENMASK(5, 4) /* Proximity interrupt persistence setting */
>  #define VCNL4040_PS_CONF2_PS_INT	GENMASK(9, 8) /* Proximity interrupt mode */
>  #define VCNL4040_PS_CONF3_MPS		GENMASK(6, 5) /* Proximity multi pulse number */
> +#define VCNL4040_PS_MS_LED_I		GENMASK(10, 8) /* Proximity current */
>  #define VCNL4040_PS_IF_AWAY		BIT(8) /* Proximity event cross low threshold */
>  #define VCNL4040_PS_IF_CLOSE		BIT(9) /* Proximity event cross high threshold */
>  #define VCNL4040_ALS_RISING		BIT(12) /* Ambient Light cross high threshold */
> @@ -156,6 +157,18 @@ static const int vcnl4200_als_it_times[][2] = {
>  	{0, 200000},
>  	{0, 400000},
>  };
> +
> +static const int vcnl4040_ps_calibbias_ua[][2] = {
> +	{0, 50000},
> +	{0, 75000},
> +	{0, 100000},
> +	{0, 120000},
> +	{0, 140000},
> +	{0, 160000},
> +	{0, 180000},
> +	{0, 200000},
> +};
> +
>  static const int vcnl4040_als_persistence[] = {1, 2, 4, 8};
>  static const int vcnl4040_ps_persistence[] = {1, 2, 3, 4};
>  static const int vcnl4040_ps_oversampling_ratio[] = {1, 2, 4, 8};
> @@ -831,6 +844,57 @@ static ssize_t vcnl4040_write_ps_oversampling_ratio(struct vcnl4000_data *data,
>  	return ret;
>  }
>  
> +static ssize_t vcnl4040_read_ps_calibbias(struct vcnl4000_data *data, int *val, int *val2)
> +{
> +	int ret;
> +
> +	ret = i2c_smbus_read_word_data(data->client, VCNL4200_PS_CONF3);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = FIELD_GET(VCNL4040_PS_MS_LED_I, ret);
> +
> +	if (ret >= ARRAY_SIZE(vcnl4040_ps_calibbias_ua))
> +		return -EINVAL;
> +
> +	*val = vcnl4040_ps_calibbias_ua[ret][0];
> +	*val2 = vcnl4040_ps_calibbias_ua[ret][1];
> +
> +	return ret;
> +}
> +
> +static ssize_t vcnl4040_write_ps_calibbias(struct vcnl4000_data *data, int val)
> +{
> +	unsigned int i;
> +	int ret, index = -1;
> +	u16 regval;
> +
> +	for (i = 0; i < ARRAY_SIZE(vcnl4040_ps_calibbias_ua); i++) {
> +		if (val == vcnl4040_ps_calibbias_ua[i][1]) {
> +			index = i;
> +			break;
> +		}
> +	}
> +
> +	if (index < 0)
> +		return -EINVAL;
> +
> +	mutex_lock(&data->vcnl4000_lock);
> +
> +	ret = i2c_smbus_read_word_data(data->client, VCNL4200_PS_CONF3);
> +	if (ret < 0)
> +		goto out;
> +
> +	regval = (ret & ~VCNL4040_PS_MS_LED_I) |
> +	    FIELD_PREP(VCNL4040_PS_MS_LED_I, index);
> +	ret = i2c_smbus_write_word_data(data->client, VCNL4200_PS_CONF3,
> +					regval);
> +
> +out:
> +	mutex_unlock(&data->vcnl4000_lock);
> +	return ret;
> +}
> +
>  static int vcnl4000_read_raw(struct iio_dev *indio_dev,
>  				struct iio_chan_spec const *chan,
>  				int *val, int *val2, long mask)
> @@ -891,7 +955,16 @@ static int vcnl4000_read_raw(struct iio_dev *indio_dev,
>  		default:
>  			return -EINVAL;
>  		}
> -
> +	case IIO_CHAN_INFO_CALIBBIAS:
> +		switch (chan->type) {
> +		case IIO_PROXIMITY:
> +			ret = vcnl4040_read_ps_calibbias(data, val, val2);
> +			if (ret < 0)
> +				return ret;
> +			return IIO_VAL_INT_PLUS_MICRO;
> +		default:
> +			return -EINVAL;
> +		}
>  	default:
>  		return -EINVAL;
>  	}
> @@ -922,6 +995,13 @@ static int vcnl4040_write_raw(struct iio_dev *indio_dev,
>  		default:
>  			return -EINVAL;
>  		}
> +	case IIO_CHAN_INFO_CALIBBIAS:
> +		switch (chan->type) {
> +		case IIO_PROXIMITY:
> +			return vcnl4040_write_ps_calibbias(data, val2);
> +		default:
> +			return -EINVAL;
> +		}
>  	default:
>  		return -EINVAL;
>  	}
> @@ -961,6 +1041,16 @@ static int vcnl4040_read_avail(struct iio_dev *indio_dev,
>  		default:
>  			return -EINVAL;
>  		}
> +	case IIO_CHAN_INFO_CALIBBIAS:
> +		switch (chan->type) {
> +		case IIO_PROXIMITY:
> +			*vals = (int *)vcnl4040_ps_calibbias_ua;
> +			*length = 2 * ARRAY_SIZE(vcnl4040_ps_calibbias_ua);
> +			*type = IIO_VAL_INT_PLUS_MICRO;
> +			return IIO_AVAIL_LIST;
> +		default:
> +			return -EINVAL;
> +	}
>  	default:
>  		return -EINVAL;
>  	}
> @@ -1729,9 +1819,11 @@ static const struct iio_chan_spec vcnl4040_channels[] = {
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
>  			BIT(IIO_CHAN_INFO_INT_TIME),
>  		.info_mask_separate_available = BIT(IIO_CHAN_INFO_INT_TIME),
> -			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
> +			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO) |
> +			BIT(IIO_CHAN_INFO_CALIBBIAS),
>  		.info_mask_separate_available = BIT(IIO_CHAN_INFO_INT_TIME) |
> -			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
> +			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO) |
> +			BIT(IIO_CHAN_INFO_CALIBBIAS),
>  		.ext_info = vcnl4000_ext_info,
>  		.event_spec = vcnl4040_event_spec,
>  		.num_event_specs = ARRAY_SIZE(vcnl4040_event_spec),

