Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B87F7143AA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 07:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231347AbjE2FUU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 01:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230427AbjE2FUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 01:20:15 -0400
Received: from fgw21-7.mail.saunalahti.fi (fgw21-7.mail.saunalahti.fi [62.142.5.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B50F89E
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 22:20:13 -0700 (PDT)
Received: from localhost (88-113-26-95.elisa-laajakaista.fi [88.113.26.95])
        by fgw21.mail.saunalahti.fi (Halon) with ESMTP
        id 7a5c1941-fde0-11ed-abf4-005056bdd08f;
        Mon, 29 May 2023 08:20:09 +0300 (EEST)
From:   andy.shevchenko@gmail.com
Date:   Mon, 29 May 2023 08:20:08 +0300
To:     Astrid Rost <astrid.rost@axis.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@axis.com,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Mathieu Othacehe <m.othacehe@gmail.com>
Subject: Re: [PATCH v4 5/7] iio: light: vcnl4000: Add period for vcnl4040/4200
Message-ID: <ZHQ2CGSnB-CaYqSy@surfacebook>
References: <20230522142621.1680563-1-astrid.rost@axis.com>
 <20230522142621.1680563-6-astrid.rost@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230522142621.1680563-6-astrid.rost@axis.com>
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mon, May 22, 2023 at 04:26:19PM +0200, Astrid Rost kirjoitti:
> Add read/write attribute for proximity and illuminance period.
> The period is set in the interrupt persistence flags
> (PS_PERS and ALS_PERS). An interrupt will not be asserted if the raw
> value is not over (or lower) than the threshold for the set
> continued amount of measurements.
> The time in seconds is calculated by the number of continued refreshes
> multiplied with the integration time.
> It will always pick the next lower possible value. The period changes,
> if the integration time is changed.

Something interesting happened to the indentation in the above text.

...

> +out:

out_unlock:

> +	mutex_unlock(&data->vcnl4000_lock);
> +	return ret;

...

> +	*val2 = (*data->chip_spec->ps_it_times)[ret_it][1]
> +		* vcnl4040_ps_persistence[ret_pers];

' *' can be placed on the previous line.

...

> +			if (val2 <= vcnl4040_ps_persistence[index]
> +					* (*data->chip_spec->ps_it_times)[ret_it][1])

Ditto.

> +				break;

...

> +out:

out_unlock:

> +	mutex_unlock(&data->vcnl4000_lock);
> +	return ret;

...

> +			case IIO_EV_DIR_RISING:
> +				ret = i2c_smbus_write_word_data(
> +					data->client, VCNL4040_ALS_THDH_LM, val);

Indentation.

> +				break;
> +			case IIO_EV_DIR_FALLING:
> +				ret = i2c_smbus_write_word_data(
> +					data->client, VCNL4040_ALS_THDL_LM, val);

Ditto.

> +				break;

...

> +			case IIO_EV_DIR_RISING:
> +				ret = i2c_smbus_write_word_data(
> +					data->client, VCNL4040_PS_THDH_LM, val);
> +				break;
> +			case IIO_EV_DIR_FALLING:
> +				ret = i2c_smbus_write_word_data(
> +					data->client, VCNL4040_PS_THDL_LM, val);
> +				break;

Ditto.

...

> +	{
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_RISING,
> +		.mask_separate = BIT(IIO_EV_INFO_VALUE),
> +	}, {
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_FALLING,
> +		.mask_separate = BIT(IIO_EV_INFO_VALUE),
> +	}, {
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_EITHER,
> +		.mask_separate = BIT(IIO_EV_INFO_ENABLE) |  BIT(IIO_EV_INFO_PERIOD),
> +	}

Can we keep trailing comma here?

...

> -	},

Stray change (and see just above).

> +	}, {
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_EITHER,
> +		.mask_separate = BIT(IIO_EV_INFO_PERIOD),
> +	}

-- 
With Best Regards,
Andy Shevchenko


