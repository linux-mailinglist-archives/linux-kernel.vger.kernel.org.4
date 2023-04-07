Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC2F96DB117
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 19:05:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbjDGREh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 13:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjDGREf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 13:04:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 708DEAD1A;
        Fri,  7 Apr 2023 10:04:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0C89461284;
        Fri,  7 Apr 2023 17:04:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C19C9C433EF;
        Fri,  7 Apr 2023 17:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680887072;
        bh=84GG4GqddxbvAIsmuTYd6nCuYTWPg+lSmfhnPE4ojYk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XemRHQHH5RiDgK2T26wY95xXRCWrJq5xvSG2AvR1R1VCdkSZANtkIHoIihwqfAt3v
         XIav9VvxZZTls2AfIhpx+tDliAsdn34WtUrTXp3o9t5QNIZl7qq/1ZGDxx/VTvzXv3
         HD6Ou89Ha/EoFSwbLpO9+vpckiQaDHAtCrIyr8hWky5lbkQW5vDi74P0iL0VP0Vj3N
         NpASHU/wowBf7RtRrVHs6KDXIiVJfUBRbuZf7rc9rblpUSIX1tDsoUQ1JqS4HRDGEp
         SELYYG+ylapIpXPxwqC7VTKOZH7GXzAlqjQ9RJaXMUZKR1GzoVd1GcrD69EEYlHPXc
         BE9TXcm51gwzw==
Date:   Fri, 7 Apr 2023 18:19:47 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Patrik =?UTF-8?B?RGFobHN0csO2bQ==?= <risca@dalakolonin.se>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        letux-kernel@openphoenux.org, kernel@pyra-handheld.com,
        pgoudagunta@nvidia.com, hns@goldelico.com, lars@metafoo.de,
        linux-omap@vger.kernel.org
Subject: Re: [PATCH v3 6/7] iio: adc: palmas: add support for iio threshold
 events
Message-ID: <20230407181947.667614ed@jic23-huawei>
In-Reply-To: <20230405212233.4167986-7-risca@dalakolonin.se>
References: <20230405212233.4167986-1-risca@dalakolonin.se>
        <20230405212233.4167986-7-risca@dalakolonin.se>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  5 Apr 2023 23:22:32 +0200
Patrik Dahlstr=C3=B6m <risca@dalakolonin.se> wrote:

> The palmas gpadc block has support for monitoring up to 2 ADC channels
> and issue an interrupt if they reach past a set threshold. This change
> hooks into the IIO events system and exposes to userspace the ability to
> configure these threshold values for each channel, but only allow up to
> 2 such thresholds to be enabled at any given time. Trying to enable a
> third channel will result in an error.
>=20
> Userspace is expected to input calibrated, as opposed to raw, values as
> threshold. However, it is not enough to do the opposite of what is done
> when converting the other way around. To account for tolerances in the
> ADC, the calculated raw threshold should be adjusted based on the ADC
> specifications for the device. These specifications include the integral
> nonlinearity (INL), offset, and gain error. To adjust the high
> threshold, use the following equation:
>=20
>   (calibrated value + INL) * Gain error + offset =3D maximum value  [1]
>=20
> Likewise, use the following equation for the low threshold:
>=20
>   (calibrated value - INL) * Gain error - offset =3D minimum value
>=20
> The gain error is a combination of gain error, as listed in the
> datasheet, and gain error drift due to temperature and supply. The exact
> values for these specifications vary between palmas devices. This patch
> sets the values found in TWL6035, TWL6037 datasheet.
>=20
> [1] TI Application Report, SLIA087A, Guide to Using the GPADC in
>     TPS65903x, TPS65917-Q1, TPS65919-Q1, and TPS65916 Devices.
>=20
> Signed-off-by: Patrik Dahlstr=C3=B6m <risca@dalakolonin.se>
Hi Patrik,

A few really trivial formatting things inline. If we don't end up
with a v4 for other reasons I can tidy this stuff up whilst applying.

Jonathan


> =20
> +/**

Not kernel-doc so /* only
Even if it were the indent for the following should align the * with the fi=
rst * not
the second one.

> +  * The high and low threshold values are calculated based on the advice=
 given
> +  * in TI Application Report SLIA087A, "Guide to Using the GPADC in PS65=
903x,
> +  * TPS65917-Q1, TPS65919-Q1, and TPS65916 Devices". This document recom=
mend
> +  * taking ADC tolerances into account and is based on the device integr=
al non-
> +  * linearity (INL), offset error and gain error:
> +  *
> +  *   raw high threshold =3D (ideal threshold + INL) * gain error + offs=
et error
> +  *
> +  * The gain error include both gain error, as specified in the datashee=
t, and
> +  * the gain error drift. These paramenters vary depending on device and=
 whether
> +  * the the channel is calibrated (trimmed) or not.
> +  */
> +static int palmas_gpadc_threshold_with_tolerance(int val, const int INL,
> +						 const int gain_error,
> +						 const int offset_error)
> +{
> +	val =3D ((val + INL) * (1000 + gain_error)) / 1000 + offset_error;
> +
> +	return clamp(val, 0, 0xFFF);
> +}
> +
> +/**

/*

> +  * The values below are taken from the datasheet of TWL6035, TWL6037.
> +  * todo: get max INL, gain error, and offset error from OF.
> +  */
> +static int palmas_gpadc_get_high_threshold_raw(struct palmas_gpadc *adc,
> +					       struct palmas_adc_event *ev)
> +{
> +	const int adc_chan =3D ev->channel;
> +	int val =3D adc->thresholds[adc_chan].high;
> +	/* integral nonlinearity, measured in LSB */
> +	const int max_INL =3D 2;
> +	/* measured in LSB */
> +	int max_offset_error;
> +	/* 0.2% when calibrated */
> +	int max_gain_error =3D 2;
> +
> +	val =3D (val * 1000) / adc->adc_info[adc_chan].gain;
> +
> +	if (adc->adc_info[adc_chan].is_uncalibrated) {
> +		/* 2% worse */
> +		max_gain_error +=3D 20;
> +		max_offset_error =3D 36;
> +	} else {
> +		val =3D (val * adc->adc_info[adc_chan].gain_error +
> +		       adc->adc_info[adc_chan].offset) /
> +			1000;
> +		max_offset_error =3D 2;
> +	}
> +
> +	return palmas_gpadc_threshold_with_tolerance(val,
> +						     max_INL,
> +						     max_gain_error,
> +						     max_offset_error);
> +}
> +
> +/**

This isn't kernel-doc so just /*=20

> +  * The values below are taken from the datasheet of TWL6035, TWL6037.
> +  * todo: get min INL, gain error, and offset error from OF.
> +  */
> +static int palmas_gpadc_get_low_threshold_raw(struct palmas_gpadc *adc,
> +					      struct palmas_adc_event *ev)
> +{
> +	const int adc_chan =3D ev->channel;
> +	int val =3D adc->thresholds[adc_chan].low;
> +	/* integral nonlinearity, measured in LSB */
> +	const int min_INL =3D -2;
> +	/* measured in LSB */
> +	int min_offset_error;
> +	/* -0.6% when calibrated */
> +	int min_gain_error =3D -6;
> +
> +	val =3D (val * 1000) / adc->adc_info[adc_chan].gain;
> +
> +        if (adc->adc_info[adc_chan].is_uncalibrated) {
> +		/* 2% worse */
> +		min_gain_error -=3D 20;
> +		min_offset_error =3D -36;
> +        } else {
> +		val =3D (val * adc->adc_info[adc_chan].gain_error -
> +		       adc->adc_info[adc_chan].offset) /
> +			1000;
> +		min_offset_error =3D -2;
> +        }
> +
> +	return palmas_gpadc_threshold_with_tolerance(val,
> +						     min_INL,
> +						     min_gain_error,
> +						     min_offset_error);
> +}
> +
>  static int palmas_gpadc_read_raw(struct iio_dev *indio_dev,
>  	struct iio_chan_spec const *chan, int *val, int *val2, long mask)
>  {
> @@ -437,8 +586,221 @@ static int palmas_gpadc_read_raw(struct iio_dev *in=
dio_dev,
>  	return ret;
>  }
> =20
> +static int palmas_gpadc_read_event_config(struct iio_dev *indio_dev,
> +					  const struct iio_chan_spec *chan,
> +					  enum iio_event_type type,
> +					  enum iio_event_direction dir)
> +{
> +	struct palmas_gpadc *adc =3D iio_priv(indio_dev);
> +	int adc_chan =3D chan->channel;
> +	int ret =3D 0;
> +
> +	if (adc_chan > PALMAS_ADC_CH_MAX || type !=3D IIO_EV_TYPE_THRESH)
> +		return -EINVAL;
> +
> +	mutex_lock(&adc->lock);
> +
> +	if (palmas_gpadc_get_event(adc, adc_chan, dir)) {
> +		ret =3D 1;

Trivial: No brackets needed here for kernel style.

> +	}
> +
> +	mutex_unlock(&adc->lock);
> +
> +	return ret;
> +}
...

> +static int palmas_gpadc_write_event_config(struct iio_dev *indio_dev,
> +					   const struct iio_chan_spec *chan,
> +					   enum iio_event_type type,
> +					   enum iio_event_direction dir,
> +					   int state)
> +{
> +	struct palmas_gpadc *adc =3D iio_priv(indio_dev);
> +	int adc_chan =3D chan->channel;
> +	int ret =3D 0;

This initial value isn't used so shouldn't be set.
One of the static analysis tools will spot this so if we don't tidy it up
now chances of it getting 'fixed' later is high.  Better to avoid the
overhead of such a patch.

> +
> +	if (adc_chan > PALMAS_ADC_CH_MAX || type !=3D IIO_EV_TYPE_THRESH)
> +		return -EINVAL;
> +
> +	mutex_lock(&adc->lock);
> +
> +	if (state)
> +		ret =3D palmas_gpadc_enable_event_config(adc, chan, dir);
> +	else
> +		ret =3D palmas_gpadc_disable_event_config(adc, chan, dir);
> +
> +	mutex_unlock(&adc->lock);
> +
> +	return ret;
> +}
> +
> +static int palmas_gpadc_read_event_value(struct iio_dev *indio_dev,
> +					 const struct iio_chan_spec *chan,
> +					 enum iio_event_type type,
> +					 enum iio_event_direction dir,
> +					 enum iio_event_info info,
> +					 int *val, int *val2)
> +{
> +	struct palmas_gpadc *adc =3D iio_priv(indio_dev);
> +	int adc_chan =3D chan->channel;
> +	int ret =3D 0;

Trivial: I can't see a path where this initial value is used so it
shouldn't be initialized here.

> +
> +	if (adc_chan > PALMAS_ADC_CH_MAX || type !=3D IIO_EV_TYPE_THRESH)
> +		return -EINVAL;
> +
> +	mutex_lock(&adc->lock);
> +
> +	switch (info) {
> +	case IIO_EV_INFO_VALUE:
> +		*val =3D (dir =3D=3D IIO_EV_DIR_RISING) ?
> +			adc->thresholds[adc_chan].high :
> +			adc->thresholds[adc_chan].low;
> +		ret =3D IIO_VAL_INT;
> +		break;
> +	default:
> +		ret =3D -EINVAL;
> +		break;
> +	}
> +
> +	mutex_unlock(&adc->lock);
> +
> +	return ret;
> +}
> +
