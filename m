Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E68EF72103E
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 15:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbjFCNvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jun 2023 09:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjFCNvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jun 2023 09:51:08 -0400
Received: from fgw23-7.mail.saunalahti.fi (fgw23-7.mail.saunalahti.fi [62.142.5.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B81D123
        for <linux-kernel@vger.kernel.org>; Sat,  3 Jun 2023 06:51:05 -0700 (PDT)
Received: from localhost (88-113-26-95.elisa-laajakaista.fi [88.113.26.95])
        by fgw23.mail.saunalahti.fi (Halon) with ESMTP
        id adf7629f-0215-11ee-b972-005056bdfda7;
        Sat, 03 Jun 2023 16:51:03 +0300 (EEST)
From:   andy.shevchenko@gmail.com
Date:   Sat, 3 Jun 2023 16:51:03 +0300
To:     Astrid Rost <astrid.rost@axis.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@axis.com,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Mathieu Othacehe <m.othacehe@gmail.com>
Subject: Re: [PATCH v5 5/7] iio: light: vcnl4000: Add period for vcnl4040/4200
Message-ID: <ZHtFR6_jdi10bFdH@surfacebook>
References: <20230530142405.1679146-1-astrid.rost@axis.com>
 <20230530142405.1679146-6-astrid.rost@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530142405.1679146-6-astrid.rost@axis.com>
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tue, May 30, 2023 at 04:24:03PM +0200, Astrid Rost kirjoitti:
> Add read/write attribute for proximity and illuminance period. The
> period is set in the interrupt persistence flags(PS_PERS and ALS_PERS).
> An interrupt will not be asserted if the raw value is not over (or lower)
> than the threshold for the set continued amount of measurements.
> The time in seconds is calculated by the number of continued refreshes
> multiplied with the integration time.
> It will always pick the next lower possible value. The period changes,
> if the integration time is changed.

...

> +static ssize_t vcnl4040_read_als_period(struct vcnl4000_data *data, int *val, int *val2)
> +{
> +	int ret, ret_pers, ret_it;
> +	int64_t val_c;
> +
> +	ret = i2c_smbus_read_word_data(data->client, VCNL4200_AL_CONF);
> +	if (ret < 0)
> +		return ret;

> +	ret_pers = FIELD_GET(VCNL4040_ALS_CONF_PERS, ret);

> +

Redundant blank line.

> +	if (ret_pers >= ARRAY_SIZE(vcnl4040_als_persistence))
> +		return -EINVAL;
> +
> +	ret_it = FIELD_GET(VCNL4040_ALS_CONF_IT, ret);

> +

Ditto.

> +	if (ret_it >= data->chip_spec->num_als_it_times)
> +		return -EINVAL;

Also name them better, at least by dropping ret prefix.

> +	val_c = mul_u32_u32((*data->chip_spec->als_it_times)[ret_it][1],
> +			    vcnl4040_als_persistence[ret_pers]);
> +	*val = div_u64_rem(val_c, MICRO, val2);
> +
> +	return IIO_VAL_INT_PLUS_MICRO;
> +}

...

> +static ssize_t vcnl4040_write_als_period(struct vcnl4000_data *data, int val, int val2)
> +{
> +	unsigned int index;
> +	int ret, ret_it;

Name variable better.

> +	u16 regval;
> +	int64_t val_n = mul_u32_u32(val, MICRO) + val2;

It is inconsistent to use uXX and intXX_t in the same module. Can you explain
the intention?

> +
> +	ret = i2c_smbus_read_word_data(data->client, VCNL4200_AL_CONF);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret_it = FIELD_GET(VCNL4040_ALS_CONF_IT, ret);

> +

Redundant blank line.

> +	if (ret_it >= data->chip_spec->num_als_it_times)
> +		return -EINVAL;
> +
> +	for (index = 0; index < ARRAY_SIZE(vcnl4040_als_persistence) - 1; index++)

In one case you use i, here index. Please, be consistent with your code.

> +		if (val_n < mul_u32_u32(vcnl4040_als_persistence[index],
> +					(*data->chip_spec->als_it_times)[ret_it][1]))
> +			break;

It would be better to have

	for (...) {
		...
	}


> +	mutex_lock(&data->vcnl4000_lock);
> +
> +	ret = i2c_smbus_read_word_data(data->client, VCNL4200_AL_CONF);
> +	if (ret < 0)
> +		goto out_unlock;
> +
> +	regval = (ret & ~VCNL4040_ALS_CONF_PERS) |
> +		 FIELD_PREP(VCNL4040_ALS_CONF_PERS, index);
> +	ret = i2c_smbus_write_word_data(data->client, VCNL4200_AL_CONF,
> +					regval);
> +
> +out_unlock:
> +	mutex_unlock(&data->vcnl4000_lock);
> +	return ret;
> +}

...

All the same to the other functions applies.
I stopped here.

-- 
With Best Regards,
Andy Shevchenko


