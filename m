Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 690B97143B0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 07:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231468AbjE2FWv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 01:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231479AbjE2FWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 01:22:48 -0400
Received: from fgw21-7.mail.saunalahti.fi (fgw21-7.mail.saunalahti.fi [62.142.5.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19FEA9B
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 22:22:45 -0700 (PDT)
Received: from localhost (88-113-26-95.elisa-laajakaista.fi [88.113.26.95])
        by fgw21.mail.saunalahti.fi (Halon) with ESMTP
        id d5de9746-fde0-11ed-abf4-005056bdd08f;
        Mon, 29 May 2023 08:22:42 +0300 (EEST)
From:   andy.shevchenko@gmail.com
Date:   Mon, 29 May 2023 08:22:41 +0300
To:     Astrid Rost <astrid.rost@axis.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@axis.com,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Mathieu Othacehe <m.othacehe@gmail.com>
Subject: Re: [PATCH v4 6/7] iio: light: vcnl4000: Add oversampling_ratio for
 4040/4200
Message-ID: <ZHQ2obeWHEHZsVOG@surfacebook>
References: <20230522142621.1680563-1-astrid.rost@axis.com>
 <20230522142621.1680563-7-astrid.rost@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230522142621.1680563-7-astrid.rost@axis.com>
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mon, May 22, 2023 at 04:26:20PM +0200, Astrid Rost kirjoitti:
> Add the proximity multi pulse (PS_MPS) as oversampling_ratio.
> Instead of one single pulse per every defined time frame,
> one can program 2, 4, or even 8 pulses. This leads to a
> longer IRED on-time for each proximity measurement value, which
> also results in a higher detection range.
> 
> Add read/write attribute for proximity oversampling-ratio and read
> attribute for available oversampling-ratio.
> This is supported for vcnl4040 and vcnl4200.

...

> +static ssize_t vcnl4040_write_ps_oversampling_ratio(struct vcnl4000_data *data, int val)
> +{
> +	unsigned int i;
> +	int ret, index = -1;

Either i or index is redundant.

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

out_unlock:

> +	mutex_unlock(&data->vcnl4000_lock);
> +	return ret;
> +}

...

>  		if (ret < 0)
>  			return ret;
>  		return IIO_VAL_INT_PLUS_MICRO;
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

> +

This is inconsistent blank line.

>  	default:
>  		return -EINVAL;
>  	}

-- 
With Best Regards,
Andy Shevchenko


