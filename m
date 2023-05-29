Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE2A7143BC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 07:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbjE2F04 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 01:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbjE2F0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 01:26:54 -0400
Received: from fgw22-7.mail.saunalahti.fi (fgw22-7.mail.saunalahti.fi [62.142.5.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E7879B
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 22:26:51 -0700 (PDT)
Received: from localhost (88-113-26-95.elisa-laajakaista.fi [88.113.26.95])
        by fgw22.mail.saunalahti.fi (Halon) with ESMTP
        id 68d7f7da-fde1-11ed-a9de-005056bdf889;
        Mon, 29 May 2023 08:26:49 +0300 (EEST)
From:   andy.shevchenko@gmail.com
Date:   Mon, 29 May 2023 08:26:48 +0300
To:     Astrid Rost <astrid.rost@axis.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@axis.com,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Mathieu Othacehe <m.othacehe@gmail.com>
Subject: Re: [PATCH v4 7/7] iio: light: vcnl4000: Add calibration bias for
 4040/4200
Message-ID: <ZHQ3mPXcdD1G3c2S@surfacebook>
References: <20230522142621.1680563-1-astrid.rost@axis.com>
 <20230522142621.1680563-8-astrid.rost@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230522142621.1680563-8-astrid.rost@axis.com>
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mon, May 22, 2023 at 04:26:21PM +0200, Astrid Rost kirjoitti:
> The calibration bias is setting the LED current to change
> the detection distance.
> Add read/write attribute for proximity calibration bias and read
> attribute for available values.
> This is supported for vcnl4040 and vcnl4200.

Indentation of the commit message is rather random.

...

> +

This means that one of the previous change missed the blank line here.

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

>  	return ret;
>  }

...

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

> +	return ret;

Are you sure this is correct?

> +}

...

> +static ssize_t vcnl4040_write_ps_calibbias(struct vcnl4000_data *data, int val)
> +{
> +	unsigned int i;
> +	int ret, index = -1;

i or index is redundant.

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

out_unlock:

> +	mutex_unlock(&data->vcnl4000_lock);
> +	return ret;
> +}

...

>  		default:
>  			return -EINVAL;
>  		}
> -

Stray and ping-pong style of change at the same time.

Avoid ping-pong style when you add something in the series which is being
removed aftewards in the same series without need to be added in the first
place.

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

-- 
With Best Regards,
Andy Shevchenko


