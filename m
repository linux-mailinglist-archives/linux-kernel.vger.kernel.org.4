Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46F26701EAB
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 19:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235251AbjENRVv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 13:21:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbjENRVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 13:21:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35E2F173F;
        Sun, 14 May 2023 10:21:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AC54760C70;
        Sun, 14 May 2023 17:21:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 175EEC433EF;
        Sun, 14 May 2023 17:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684084907;
        bh=TcetyUCI+AsbF+Vy7hr/9FPI2TlWf5ITYIqwxpu/kn0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FEczCHQysfyZF6QFJYB9bOho5Z4yTv0QxivlWnoGiU6miNLy5onnZNj37Z0RTD6ns
         HSEAf3l3t5OHxTN1TRofi+gjKFOYgKLhqxg23pseUfnwtmWrRUHTVfNfgdyIr9vqro
         PLxKuj+GOzIBkFGbAciwyEgFH1duEBqdrgGk34ckdQW5pWnxAn7+hJBMj+St75JkIz
         DbAJKTifpHZXnxh0/t0RckQAH0uSMYSk/7Gj9b5JZT5Nmib5Zx+Kx3V52qQ5FN3YZl
         AURnrQXg4O9V+ToFYkVGBO07IA6WZeuy/sesjMSWCodD0e7t0cjPZQyHLnhulRW1rr
         epOQD82GBj+eg==
Date:   Sun, 14 May 2023 18:37:48 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Astrid Rost <astrid.rost@axis.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel@axis.com>
Subject: Re: [PATCH v2 5/7] iio: light: vcnl4000: Add debounce count for
 vcnl4040/4200
Message-ID: <20230514183748.256a210c@jic23-huawei>
In-Reply-To: <20230509140153.3279288-6-astrid.rost@axis.com>
References: <20230509140153.3279288-1-astrid.rost@axis.com>
        <20230509140153.3279288-6-astrid.rost@axis.com>
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

On Tue, 9 May 2023 16:01:51 +0200
Astrid Rost <astrid.rost@axis.com> wrote:

> Add read/write attribute for proximity and illumination debounce-count
> and read attribute for available debounce-counts.
> The debounce-count is set in the interrupt persistence flags
> (PS_PERS and ALS_PERS). An interrupt will not be asserted if the raw
> value is not over (or lower) than the threshold for the set
> continued refresh times.
> This is supported for vcnl4040 vcnl4200.

Why debounce count? That has previously just been used for step detection
on accelerometers and has a pretty specific definition in
See Documentation/ABI/testing/sysfs-bus-iio

"
What:		/sys/.../iio:deviceX/in_steps_debounce_count
...
		Specifies the number of steps that must occur within
		in_steps_filter_debounce_time for the pedometer to decide the
		consumer is making steps.
"

What you probably want is period, though that is defined in seconds so
you may need some unit conversions.  That is defined for events, not for
a channel so IIO_EV_INFO_PERIOD.
"
		Period of time (in seconds) for which the condition must be
		met before an event is generated. If direction is not
		specified then this period applies to both directions.
"

> 
> Signed-off-by: Astrid Rost <astrid.rost@axis.com>
> ---
>  drivers/iio/light/vcnl4000.c | 156 ++++++++++++++++++++++++++++++++++-
>  1 file changed, 152 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
> index 68eea686b2dc..b8ce4ed6b0bb 100644
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
> @@ -153,6 +155,9 @@ static const int vcnl4200_als_it_times[][2] = {
>  	{0, 400000},
>  };
>  
> +static const int vcnl4040_als_debounce_count[] = {1, 2, 4, 8};
> +static const int vcnl4040_ps_debounce_count[] = {1, 2, 3, 4};
> +
>  #define VCNL4000_SLEEP_DELAY_MS	2000 /* before we enter pm_runtime_suspend */
>  
>  enum vcnl4000_device_ids {
> @@ -680,6 +685,106 @@ static ssize_t vcnl4040_write_ps_it(struct vcnl4000_data *data, int val)
>  	return ret;
>  }
>  
> +static ssize_t vcnl4040_read_als_debounce_count(struct vcnl4000_data *data, int *val)
> +{
> +	int ret;
> +
> +	ret = i2c_smbus_read_word_data(data->client, VCNL4200_AL_CONF);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = FIELD_GET(VCNL4040_ALS_CONF_PERS, ret);
> +
> +	if (ret >= ARRAY_SIZE(vcnl4200_als_it_times))
> +		return -EINVAL;
> +
> +	*val = vcnl4040_als_debounce_count[ret];
> +
> +	return ret;
> +}
> +
> +static ssize_t vcnl4040_write_als_debounce_count(struct vcnl4000_data *data, int val)
> +{
> +	unsigned int i;
> +	int ret, index = -1;
> +	u16 regval;
> +
> +	for (i = 0; i < ARRAY_SIZE(vcnl4040_als_debounce_count); i++) {
> +		if (val == vcnl4040_als_debounce_count[i]) {
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
> +
> +static ssize_t vcnl4040_read_ps_debounce_count(struct vcnl4000_data *data, int *val)
> +{
> +	int ret;
> +
> +	ret = i2c_smbus_read_word_data(data->client, VCNL4200_PS_CONF1);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = FIELD_GET(VCNL4040_CONF1_PS_PERS, ret);
> +
> +	if (ret >= ARRAY_SIZE(vcnl4200_ps_it_times))
> +		return -EINVAL;
> +
> +	*val = vcnl4040_ps_debounce_count[ret];
> +
> +	return ret;
> +}
> +
> +static ssize_t vcnl4040_write_ps_debounce_count(struct vcnl4000_data *data, int val)
> +{
> +	unsigned int i;
> +	int ret, index = -1;
> +	u16 regval;
> +
> +	for (i = 0; i < ARRAY_SIZE(vcnl4040_ps_debounce_count); i++) {
> +		if (val == vcnl4040_ps_debounce_count[i]) {
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
>  static int vcnl4000_read_raw(struct iio_dev *indio_dev,
>  				struct iio_chan_spec const *chan,
>  				int *val, int *val2, long mask)
> @@ -730,6 +835,21 @@ static int vcnl4000_read_raw(struct iio_dev *indio_dev,
>  		if (ret < 0)
>  			return ret;
>  		return IIO_VAL_INT_PLUS_MICRO;
> +	case IIO_CHAN_INFO_DEBOUNCE_COUNT:
> +		switch (chan->type) {
> +		case IIO_LIGHT:
> +			ret = vcnl4040_read_als_debounce_count(data, val);
> +			break;
> +		case IIO_PROXIMITY:
> +			ret = vcnl4040_read_ps_debounce_count(data, val);
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +		if (ret < 0)
> +			return ret;
> +		return IIO_VAL_INT;
> +
>  	default:
>  		return -EINVAL;
>  	}
> @@ -753,6 +873,15 @@ static int vcnl4040_write_raw(struct iio_dev *indio_dev,
>  		default:
>  			return -EINVAL;
>  		}
> +	case IIO_CHAN_INFO_DEBOUNCE_COUNT:
> +		switch (chan->type) {
> +		case IIO_LIGHT:
> +			return vcnl4040_write_als_debounce_count(data, val);
> +		case IIO_PROXIMITY:
> +			return vcnl4040_write_ps_debounce_count(data, val);
> +		default:
> +			return -EINVAL;
> +		}
>  	default:
>  		return -EINVAL;
>  	}
> @@ -791,6 +920,21 @@ static int vcnl4040_read_avail(struct iio_dev *indio_dev,
>  		}
>  		*type = IIO_VAL_INT_PLUS_MICRO;
>  		return IIO_AVAIL_LIST;
> +	case IIO_CHAN_INFO_DEBOUNCE_COUNT:
> +		switch (chan->type) {
> +		case IIO_LIGHT:
> +			*vals = (int *)vcnl4040_als_debounce_count;
> +			*length = ARRAY_SIZE(vcnl4040_als_debounce_count);
> +			break;
> +		case IIO_PROXIMITY:
> +			*vals = (int *)vcnl4040_ps_debounce_count;
> +			*length = ARRAY_SIZE(vcnl4040_ps_debounce_count);
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +		*type = IIO_VAL_INT;
> +		return IIO_AVAIL_LIST;
>  	default:
>  		return -EINVAL;
>  	}
> @@ -1504,15 +1648,19 @@ static const struct iio_chan_spec vcnl4040_channels[] = {
>  		.type = IIO_LIGHT,
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
>  			BIT(IIO_CHAN_INFO_SCALE) |
> -			BIT(IIO_CHAN_INFO_INT_TIME),
> -		.info_mask_separate_available = BIT(IIO_CHAN_INFO_INT_TIME),
> +			BIT(IIO_CHAN_INFO_INT_TIME) |
> +			BIT(IIO_CHAN_INFO_DEBOUNCE_COUNT),
> +		.info_mask_separate_available = BIT(IIO_CHAN_INFO_INT_TIME) |
> +			BIT(IIO_CHAN_INFO_DEBOUNCE_COUNT),
>  		.event_spec = vcnl4000_event_spec,
>  		.num_event_specs = ARRAY_SIZE(vcnl4000_event_spec),
>  	}, {
>  		.type = IIO_PROXIMITY,
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> -			BIT(IIO_CHAN_INFO_INT_TIME),
> -		.info_mask_separate_available = BIT(IIO_CHAN_INFO_INT_TIME),
> +			BIT(IIO_CHAN_INFO_INT_TIME) |
> +			BIT(IIO_CHAN_INFO_DEBOUNCE_COUNT),
> +		.info_mask_separate_available = BIT(IIO_CHAN_INFO_INT_TIME) |
> +			BIT(IIO_CHAN_INFO_DEBOUNCE_COUNT),
>  		.ext_info = vcnl4000_ext_info,
>  		.event_spec = vcnl4040_event_spec,
>  		.num_event_specs = ARRAY_SIZE(vcnl4040_event_spec),

