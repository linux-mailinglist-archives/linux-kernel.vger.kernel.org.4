Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CAA7721008
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 14:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232282AbjFCMQE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jun 2023 08:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbjFCMQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jun 2023 08:16:01 -0400
Received: from fgw21-7.mail.saunalahti.fi (fgw21-7.mail.saunalahti.fi [62.142.5.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBC931A4
        for <linux-kernel@vger.kernel.org>; Sat,  3 Jun 2023 05:15:59 -0700 (PDT)
Received: from localhost (88-113-26-95.elisa-laajakaista.fi [88.113.26.95])
        by fgw21.mail.saunalahti.fi (Halon) with ESMTP
        id 65404ae6-0208-11ee-abf4-005056bdd08f;
        Sat, 03 Jun 2023 15:15:57 +0300 (EEST)
From:   andy.shevchenko@gmail.com
Date:   Sat, 3 Jun 2023 15:15:57 +0300
To:     Astrid Rost <astrid.rost@axis.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@axis.com,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Mathieu Othacehe <m.othacehe@gmail.com>
Subject: Re: [PATCH v5 3/7] iio: light: vcnl4000: Add als_it for vcnl4040/4200
Message-ID: <ZHsu_T_0yBKLdcIu@surfacebook>
References: <20230530142405.1679146-1-astrid.rost@axis.com>
 <20230530142405.1679146-4-astrid.rost@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530142405.1679146-4-astrid.rost@axis.com>
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tue, May 30, 2023 at 04:24:01PM +0200, Astrid Rost kirjoitti:
> Add illuminance integration time for vcnl4040 and vcnl4200.
> Add read/write attribute for illuminance integration time and read
> attribute for available integration times.
> Set scale and sampling rate according to the integration time.

...

> +static int vcnl4040_read_als_it(struct vcnl4000_data *data, int *val, int *val2)
> +{
> +	int ret;
> +
> +	ret = i2c_smbus_read_word_data(data->client, VCNL4200_AL_CONF);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = FIELD_GET(VCNL4040_ALS_CONF_IT, ret);

> +

Redundant blank line.

> +	if (ret >= data->chip_spec->num_als_it_times)
> +		return -EINVAL;
> +
> +	*val = (*data->chip_spec->als_it_times)[ret][0];
> +	*val2 = (*data->chip_spec->als_it_times)[ret][1];
> +
> +	return 0;
> +}

...

> +static ssize_t vcnl4040_write_als_it(struct vcnl4000_data *data, int val)
> +{
> +	unsigned int i;
> +	int ret, reg_val = -1;
> +	u16 regval;

Besides confusing naming schema (two variables with only a _ difference)

	unsigned int i;
	u16 regval;
	int ret;

> +	for (i = 0; i < data->chip_spec->num_als_it_times; i++) {
> +		if (val == (*data->chip_spec->als_it_times)[i][1]) {

> +			reg_val = i;

Remove.

> +			break;
> +		}
> +	}

> +	if (reg_val < 0)

	if (i == data->chip_spec->num_als_it_times)

> +		return -EINVAL;

(1)

> +	data->vcnl4200_al.sampling_rate = ktime_set(0, val * 1200);
> +	data->al_scale = div_u64(mul_u32_u32(data->chip_spec->ulux_step,
> +			 (*data->chip_spec->als_it_times)[0][1]),
> +			 val);
> +
> +	mutex_lock(&data->vcnl4000_lock);
> +
> +	ret = i2c_smbus_read_word_data(data->client, VCNL4200_AL_CONF);
> +	if (ret < 0)
> +		goto out_unlock;
> +
> +	regval = (ret & ~VCNL4040_ALS_CONF_IT) |
> +		 FIELD_PREP(VCNL4040_ALS_CONF_IT, reg_val);

Use temporary variable for this field,

	u16 als_conf;
	...See (1)...
	als_conf = FIELD_PREP(..., i);

> +	ret = i2c_smbus_write_word_data(data->client,
> +					VCNL4200_AL_CONF,
> +					regval);
> +
> +out_unlock:
> +	mutex_unlock(&data->vcnl4000_lock);
> +	return ret;
> +}

-- 
With Best Regards,
Andy Shevchenko


