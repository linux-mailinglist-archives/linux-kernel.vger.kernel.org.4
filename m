Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0628B701EB6
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 19:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237512AbjENRZp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 13:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234395AbjENRZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 13:25:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DB061985;
        Sun, 14 May 2023 10:25:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1A8B761503;
        Sun, 14 May 2023 17:25:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 897B5C433D2;
        Sun, 14 May 2023 17:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684085141;
        bh=vDjoEmmoLbZ0gMvwE+1U4cTtiVJubZVr7kEO6Md5Wf0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=N5QzigqV/aHCr+IB/Aavo3eSb3ViKKHek4PS/aEJJ3+ZQ/E8BfBQSNBoy456ooSqS
         klJaABE1APNj+zA3SiD1ttWFUBe6pDuYUUmWwXm/UOkM3cgXs8ft41A254JrukKHq3
         6pmitGR5+/j2DiqSEYTaIRwxE8HaNm8btMIF4okly9NhQp2qMkECCgM+NewBegu9jj
         Tf9TBu4CLB5ZQ5jyJEiZ41zdMFSUvOszJVQs9KicxHBuW8WkGrAzlsrjhDrfgbQSi4
         ikIyZ1ahqKzCAx+APP3vQGPqSny28b3E2X/wp6UtisMrPamNoV0l6+hTRplun7mlX/
         aDzGUqGxJfksA==
Date:   Sun, 14 May 2023 18:41:42 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Astrid Rost <astrid.rost@axis.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel@axis.com>
Subject: Re: [PATCH v2 6/7] iio: light: vcnl4000: Add oversampling_ratio for
 4040/4200
Message-ID: <20230514184142.59796c2f@jic23-huawei>
In-Reply-To: <20230509140153.3279288-7-astrid.rost@axis.com>
References: <20230509140153.3279288-1-astrid.rost@axis.com>
        <20230509140153.3279288-7-astrid.rost@axis.com>
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

On Tue, 9 May 2023 16:01:52 +0200
Astrid Rost <astrid.rost@axis.com> wrote:

> Add the proximity multi pulse (PS_MPS) as oversampling_ratio.
> One raw value is calculated out of the set amount of pulses.
> Add read/write attribute for proximity oversampling-ratio and read
> attribute for available oversampling-ratio.
> This is supported for vcnl4040 and vcnl4200.
> 
> Signed-off-by: Astrid Rost <astrid.rost@axis.com>
Hi Astrid,

I'm finding very little definition in for this Multi pulse setting.
Do we know if it does averaging, or some other form of outlier detection?

For oversampling we'd expect it to be averaging in ordering to improve the SNR.
I have no idea if that is what this feature is doing!

Otherwise code looks fine to me.

Thanks,

Jonathan

> ---
>  drivers/iio/light/vcnl4000.c | 86 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 84 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
> index b8ce4ed6b0bb..1fd1eaaa4620 100644
> --- a/drivers/iio/light/vcnl4000.c
> +++ b/drivers/iio/light/vcnl4000.c
> @@ -60,6 +60,7 @@
>  
>  #define VCNL4200_AL_CONF	0x00 /* Ambient light configuration */
>  #define VCNL4200_PS_CONF1	0x03 /* Proximity configuration */
> +#define VCNL4200_PS_CONF3	0x04 /* Proximity configuration */
>  #define VCNL4040_PS_THDL_LM	0x06 /* Proximity threshold low */
>  #define VCNL4040_PS_THDH_LM	0x07 /* Proximity threshold high */
>  #define VCNL4040_ALS_THDL_LM	0x02 /* Ambient light threshold low */
> @@ -89,6 +90,7 @@
>  #define VCNL4040_PS_CONF2_PS_IT	GENMASK(3, 1) /* Proximity integration time */
>  #define VCNL4040_CONF1_PS_PERS	GENMASK(5, 4) /* Proximity interrupt persistence setting */
>  #define VCNL4040_PS_CONF2_PS_INT	GENMASK(9, 8) /* Proximity interrupt mode */
> +#define VCNL4040_PS_CONF3_MPS		GENMASK(6, 5) /* Proximity multi pulse number */
>  #define VCNL4040_PS_IF_AWAY		BIT(8) /* Proximity event cross low threshold */
>  #define VCNL4040_PS_IF_CLOSE		BIT(9) /* Proximity event cross high threshold */
>  #define VCNL4040_ALS_RISING		BIT(12) /* Ambient Light cross high threshold */
> @@ -157,6 +159,7 @@ static const int vcnl4200_als_it_times[][2] = {
>  
>  static const int vcnl4040_als_debounce_count[] = {1, 2, 4, 8};
>  static const int vcnl4040_ps_debounce_count[] = {1, 2, 3, 4};
> +static const int vcnl4040_ps_oversampling_ratio[] = {1, 2, 4, 8};
>  
>  #define VCNL4000_SLEEP_DELAY_MS	2000 /* before we enter pm_runtime_suspend */
>  
> @@ -785,6 +788,56 @@ static ssize_t vcnl4040_write_ps_debounce_count(struct vcnl4000_data *data, int
>  	return ret;
>  }
>  
> +static ssize_t vcnl4040_read_ps_oversampling_ratio(struct vcnl4000_data *data, int *val)
> +{
> +	int ret;
> +
> +	ret = i2c_smbus_read_word_data(data->client, VCNL4200_PS_CONF3);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = FIELD_GET(VCNL4040_PS_CONF3_MPS, ret);
> +
> +	if (ret >= ARRAY_SIZE(vcnl4040_ps_oversampling_ratio))
> +		return -EINVAL;
> +
> +	*val = vcnl4040_ps_oversampling_ratio[ret];
> +
> +	return ret;
> +}
> +
> +static ssize_t vcnl4040_write_ps_oversampling_ratio(struct vcnl4000_data *data, int val)
> +{
> +	unsigned int i;
> +	int ret, index = -1;
> +	u16 regval;
> +
> +	for (i = 0; i < ARRAY_SIZE(vcnl4040_ps_oversampling_ratio); i++) {
> +		if (val == vcnl4040_ps_oversampling_ratio[i]) {
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
> +	regval = (ret & ~VCNL4040_PS_CONF3_MPS) |
> +	    FIELD_PREP(VCNL4040_PS_CONF3_MPS, index);
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
> @@ -849,6 +902,16 @@ static int vcnl4000_read_raw(struct iio_dev *indio_dev,
>  		if (ret < 0)
>  			return ret;
>  		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> +		switch (chan->type) {
> +		case IIO_PROXIMITY:
> +			ret = vcnl4040_read_ps_oversampling_ratio(data, val);
> +			if (ret < 0)
> +				return ret;
> +			return IIO_VAL_INT;
> +		default:
> +			return -EINVAL;
> +		}
>  
>  	default:
>  		return -EINVAL;
> @@ -882,6 +945,13 @@ static int vcnl4040_write_raw(struct iio_dev *indio_dev,
>  		default:
>  			return -EINVAL;
>  		}
> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> +		switch (chan->type) {
> +		case IIO_PROXIMITY:
> +			return vcnl4040_write_ps_oversampling_ratio(data, val);
> +		default:
> +			return -EINVAL;
> +		}
>  	default:
>  		return -EINVAL;
>  	}
> @@ -935,6 +1005,16 @@ static int vcnl4040_read_avail(struct iio_dev *indio_dev,
>  		}
>  		*type = IIO_VAL_INT;
>  		return IIO_AVAIL_LIST;
> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> +		switch (chan->type) {
> +		case IIO_PROXIMITY:
> +			*vals = (int *)vcnl4040_ps_oversampling_ratio;
> +			*length = ARRAY_SIZE(vcnl4040_ps_oversampling_ratio);
> +			*type = IIO_VAL_INT;
> +			return IIO_AVAIL_LIST;
> +		default:
> +			return -EINVAL;
> +		}
>  	default:
>  		return -EINVAL;
>  	}
> @@ -1658,9 +1738,11 @@ static const struct iio_chan_spec vcnl4040_channels[] = {
>  		.type = IIO_PROXIMITY,
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
>  			BIT(IIO_CHAN_INFO_INT_TIME) |
> -			BIT(IIO_CHAN_INFO_DEBOUNCE_COUNT),
> +			BIT(IIO_CHAN_INFO_DEBOUNCE_COUNT) |
> +			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
>  		.info_mask_separate_available = BIT(IIO_CHAN_INFO_INT_TIME) |
> -			BIT(IIO_CHAN_INFO_DEBOUNCE_COUNT),
> +			BIT(IIO_CHAN_INFO_DEBOUNCE_COUNT) |
> +			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
>  		.ext_info = vcnl4000_ext_info,
>  		.event_spec = vcnl4040_event_spec,
>  		.num_event_specs = ARRAY_SIZE(vcnl4040_event_spec),

