Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AEC16DBA56
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 13:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbjDHLGf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 07:06:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbjDHLGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 07:06:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5514040F6;
        Sat,  8 Apr 2023 04:06:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E430E6146E;
        Sat,  8 Apr 2023 11:06:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC5EFC433D2;
        Sat,  8 Apr 2023 11:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680951987;
        bh=vL184DlSzKqsfMF8kW16LhImYTnUC5L6dsQUTbGCWrw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EKU8VeH4ENYtToAU270VzFGrQdsXkh5gNrbHjvC56uQe0PpreiL7+2FrFjU10xLE5
         er6s2VaACepOtioJ0yqW3zm3sFufRuTopkz/6wWhO1O3EloPKxWxzSiAK3kG9Qro4N
         qVPAW9JYCBaOZMLVXoDDsobXNH/1Vra7Yw/z4ynCKEIE29QB11jelmaOEaEfwscKRC
         lA3Rc8/CKqxvmsPBX0dpue82T5Xet0EWpnmLhivWrNZwqJ+S1C1iR5j8uI8p5obNAl
         6NpSmQaGwgexovBHpjgiUj9KMgzPP/3ir37qC/lzoRwyNVEYfdKhguuFl2Xy6Sv/dh
         lVC5gfaN2GQPA==
Date:   Sat, 8 Apr 2023 12:21:40 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Paul Gazzillo <paul@pgazz.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v7 4/5] iio: light: ROHM BU27034 Ambient Light Sensor
Message-ID: <20230408122140.25332d15@jic23-huawei>
In-Reply-To: <2a7efb6f335da5526fbe34b95137c5e45db5c5d3.1680263956.git.mazziesaccount@gmail.com>
References: <cover.1680263956.git.mazziesaccount@gmail.com>
        <2a7efb6f335da5526fbe34b95137c5e45db5c5d3.1680263956.git.mazziesaccount@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 Mar 2023 15:41:58 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> ROHM BU27034 is an ambient light sensor with 3 channels and 3 photo diodes
> capable of detecting a very wide range of illuminance. Typical application
> is adjusting LCD and backlight power of TVs and mobile phones.
> 
> Add initial  support for the ROHM BU27034 ambient light sensor.
> 
> NOTE:
> 	- Driver exposes 4 channels. One IIO_LIGHT channel providing the
> 	  calculated lux values based on measured data from diodes #0 and
> 	  #1. In addition, 3 IIO_INTENSITY channels are emitting the raw
> 	  register data from all diodes for more intense user-space
> 	  computations.
> 	- Sensor has GAIN values that can be adjusted from 1x to 4096x.
> 	- Sensor has adjustible measurement times of 5, 55, 100, 200 and
> 	  400 mS. Driver does not support 5 mS which has special
> 	  limitations.
> 	- Driver exposes standard 'scale' adjustment which is
> 	  implemented by:
> 		1) Trying to adjust only the GAIN
> 		2) If GAIN adjustment alone can't provide requested
> 		   scale, adjusting both the time and the gain is
> 		   attempted.
> 	- Driver exposes writable INT_TIME property that can be used
> 	  for adjusting the measurement time. Time adjustment will also
> 	  cause the driver to try to adjust the GAIN so that the
> 	  overall scale is kept as close to the original as possible.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

A few trivial comments inline but nothing that stops me applying this version.

> 
> +static int bu27034_read_raw(struct iio_dev *idev,
> +			   struct iio_chan_spec const *chan,
> +			   int *val, int *val2, long mask)
> +{
> +	struct bu27034_data *data = iio_priv(idev);
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_INT_TIME:
> +		*val = bu27034_get_int_time(data);
> +		if (*val < 0)
> +			return *val;
> +
> +		return IIO_VAL_INT;
> +
> +	case IIO_CHAN_INFO_SCALE:
> +		return bu27034_get_scale(data, chan->channel, val, val2);
> +
> +	case IIO_CHAN_INFO_RAW:
> +	{
> +		int (*result_get)(struct bu27034_data *data, int chan, int *val);

I don't care that much about this, but the function pointer dance seems
unnecessary.

You could probably also drop the paranoid checking (or default to one of the
choices).

So at call sight of result_get() currently have
		if (chan->type == IIO_INTENSITY)
			ret = bu27034_get_single-result()...
		else
			ret = bu27034_get_mlux()

etc

meh. I didn't raise it earlier so I'll leave this alone.

> +
> +		if (chan->type == IIO_INTENSITY)
> +			result_get = bu27034_get_single_result;
> +		else if (chan->type == IIO_LIGHT)
> +			result_get = bu27034_get_mlux;
> +		else
> +			return -EINVAL;
> +
> +		/* Don't mess with measurement enabling while buffering */
> +		ret = iio_device_claim_direct_mode(idev);
> +		if (ret)
> +			return ret;
> +
> +		mutex_lock(&data->mutex);
> +		/*
> +		 * Reading one channel at a time is inefficient but we
> +		 * don't care here. Buffered version should be used if
> +		 * performance is an issue.
> +		 */
> +		ret = result_get(data, chan->channel, val);
> +
> +		mutex_unlock(&data->mutex);
> +		iio_device_release_direct_mode(idev);
> +
> +		if (ret)
> +			return ret;
> +
> +		return IIO_VAL_INT;
> +	}
> +	default:
> +		return -EINVAL;
> +
> +	}
> +}

I will fix the excess blank line above though.  Serves no purpose
so gone in the version I applied.

Thanks,

Jonathan


