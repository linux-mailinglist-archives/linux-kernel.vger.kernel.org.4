Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 663DC6C96DF
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 18:36:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbjCZQgD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 12:36:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbjCZQgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 12:36:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29A1B2D73;
        Sun, 26 Mar 2023 09:36:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ABA1760EF4;
        Sun, 26 Mar 2023 16:35:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A082C433EF;
        Sun, 26 Mar 2023 16:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679848559;
        bh=O2eHfTyT1HItcQBZ5o2WjevCq9I/p9DrsApKQGuz50Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uMz5f2ZSWbbsj+/7gYXCaZWleL6cPvRbol4trxw9I4xoLaaNemoqfRHEw8/XttdsU
         jk5dIBvNv9T/4j43gf6wOzHKLJGo+xiRZ2uyQZjI3kj/ZHUyQXOZbVIeyr5/+AUOOr
         R5fKhy/QrnCpPg+em+Hzel6iLpqPgqiRLoKRmzpZwnFidmAUj+640kzX1ReC3wrY15
         icTA0+HJnmwwBr/HlHSgmZWUMVyE+p0H39COotQ+jsLX1rrGxJpWhqhiEoGhBPU2vS
         xKDr5XgSgb4G91z07K38Nbk7h9oeLxdKKsBJ54Ai2EHfJgkR6U/9ETdh6ryxrnc+y1
         REnmg5SrN8zug==
Date:   Sun, 26 Mar 2023 17:51:01 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Patrik =?UTF-8?B?RGFobHN0csO2bQ==?= <risca@dalakolonin.se>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        letux-kernel@openphoenux.org, kernel@pyra-handheld.com,
        pgoudagunta@nvidia.com, hns@goldelico.com, lars@metafoo.de
Subject: Re: [PATCH 1/3] iio: adc: palmas_gpadc: add support for iio
 threshold events
Message-ID: <20230326175101.0ef2d6ae@jic23-huawei>
In-Reply-To: <20230319223908.108540-2-risca@dalakolonin.se>
References: <20230319223908.108540-1-risca@dalakolonin.se>
        <20230319223908.108540-2-risca@dalakolonin.se>
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

On Sun, 19 Mar 2023 23:39:06 +0100
Patrik Dahlstr=C3=B6m <risca@dalakolonin.se> wrote:

> The palmas gpadc block has support for monitoring up to 2 ADC channels
> and issue an interrupt if they reach past a set threshold. The gpadc
> driver had limited support for this through the adc_wakeup{1,2}_data
> platform data. This however only allow a fixed threshold to be set at
> boot, and would only enable it when entering sleep mode.
>=20
> This change hooks into the IIO events system and exposes to userspace
> the ability to configure threshold values for each channel individually,
> but only allow up to 2 such thresholds to be enabled at any given time.

Add a comment here on what happens if userspace tries to set more than two.
It's not as obvious as you'd think as we have some drivers that use a fifo
approach so on setting the third event they push the oldest one out.

>=20
> The logic around suspend and resume had to be adjusted so that user
> space configuration don't get reset on resume. Instead, any configured
> adc auto wakeup gets enabled during probe.
>=20
> Enabling a threshold from userspace will overwrite the adc wakeup
> configuration set during probe. Depending on how you look at it, this
> could also mean we allow userspace to update the adc wakeup thresholds.

I'm not sure I read the code right, but can you end up enabling a wakeup
that wasn't previously present?  That seems likely something we should
not be doing after boot.

One option here would be to make it either wakeup is supported, or events
are supported.  I suspect no one uses the wakeup anyway so that shouldn't
matter much (+ you remove it in next patch - do that first and this code
becomes more obvious).


A few trivial comments inline.
>=20
> Signed-off-by: Patrik Dahlstr=C3=B6m <risca@dalakolonin.se>

> =20
> @@ -280,6 +326,9 @@ static int palmas_gpadc_read_prepare(struct palmas_gp=
adc *adc, int adc_chan)
>  {
>  	int ret;
> =20
> +	if (palmas_gpadc_channel_is_freerunning(adc, adc_chan))
> +		return 0; // ADC already running

/* */

...

> =20
> +static int palmas_gpadc_get_high_threshold_raw(struct palmas_gpadc *adc,
> +					       struct palmas_adc_event *ev)
> +{
> +	const int INL =3D 2;
> +	const int adc_chan =3D ev->channel;
> +	const int orig =3D adc->thresh_data[adc_chan].high_thresh;
> +	int val =3D orig;
> +	int gain_drift;
> +	int offset_drift;
> +
> +	if (!val)
> +		return 0;
> +
> +	val =3D (val * 1000) / adc->adc_info[adc_chan].gain;
> +
> +	if (!adc->adc_info[adc_chan].is_uncalibrated) {
> +		val =3D (val * adc->adc_info[adc_chan].gain_error +
> +		       adc->adc_info[adc_chan].offset) /
> +			1000;
> +		gain_drift =3D 1002;
> +		offset_drift =3D 2;
> +	}
> +	else {
> +		gain_drift =3D 1022;
> +		offset_drift =3D 36;
> +	}
> +
> +	// add tolerance to threshold
> +	val =3D ((val + INL) * gain_drift) / 1000 + offset_drift;
> +
> +	// clamp to max possible value
/* clamp .. */
val =3D min(val, 0xFFF);


> +	if (val > 0xFFF)
> +		val =3D 0xFFF;
> +
> +	return val;
> +}
> +
> +static int palmas_gpadc_get_low_threshold_raw(struct palmas_gpadc *adc,
> +					      struct palmas_adc_event *ev)
> +{
> +	const int INL =3D 2;
> +	const int adc_chan =3D ev->channel;
> +	const int orig =3D adc->thresh_data[adc_chan].low_thresh;
> +	int val =3D orig;
> +	int gain_drift;
> +	int offset_drift;
> +
> +	if (!val)
> +		return val;
> +
> +	val =3D (val * 1000) / adc->adc_info[adc_chan].gain;
> +
> +        if (!adc->adc_info[adc_chan].is_uncalibrated) {
> +            val =3D (val * adc->adc_info[adc_chan].gain_error -
> +		   adc->adc_info[adc_chan].offset) /
> +		    1000;
> +            gain_drift =3D 998;
> +            offset_drift =3D 2;
> +        }
> +        else {
> +            gain_drift =3D 978;
> +            offset_drift =3D 36;
> +        }
> +
> +	// calculate tolerances
/* */

+ I think this could do with more information on why a tweak is needed.

> +	val =3D ((val - INL) * gain_drift) / 1000 - offset_drift;
> +
> +	// clamp to minimum 0

/* */ for all comments.=20

val =3D max(0, val); then comment may not be needed.

> +	if (val < 0)
> +		val =3D 0;
> +
> +	return val;
> +}

> +static int palmas_gpadc_reconfigure_event_channels(struct palmas_gpadc *=
adc)
> +{
> +	bool was_enabled =3D adc->wakeup1_enable || adc->wakeup2_enable;
> +	bool enable;
> +
> +	adc->wakeup1_enable =3D adc->event0.channel =3D=3D -1 ? false : true;
> +	adc->wakeup2_enable =3D adc->event1.channel =3D=3D -1 ? false : true;
> +
> +	enable =3D adc->wakeup1_enable || adc->wakeup2_enable;
> +	if (!was_enabled && enable)
> +		device_wakeup_enable(adc->dev);
> +	else if (was_enabled && !enable)
> +		device_wakeup_disable(adc->dev);
> +
> +	if (!enable)
> +		return palmas_adc_wakeup_reset(adc);
> +
> +	// adjust levels

/* adjust levels */=20

> +	if (adc->wakeup1_enable)
> +		palmas_adc_event_to_wakeup(adc, &adc->event0, &adc->wakeup1_data);
> +	if (adc->wakeup2_enable)
> +		palmas_adc_event_to_wakeup(adc, &adc->event1, &adc->wakeup2_data);
> +
> +	return palmas_adc_wakeup_configure(adc);
> +}
> +
> +static int palmas_gpadc_enable_event_config(struct palmas_gpadc *adc,
> +	const struct iio_chan_spec *chan, enum iio_event_direction dir)
> +{
> +	struct palmas_adc_event *ev;
> +	int adc_chan =3D chan->channel;
> +
> +	if (palmas_gpadc_get_event_channel(adc, adc_chan, dir))
> +		/* already enabled */
> +		return 0;
> +
> +	if (adc->event0.channel =3D=3D -1)

I'd add brackets for all legs of this if / else once one of them needs
it. Tends to end up more readable.

> +		ev =3D &adc->event0;
> +	else if (adc->event1.channel =3D=3D -1) {
> +		/* event0 has to be the lowest channel */
> +		if (adc_chan < adc->event0.channel) {
> +			adc->event1 =3D adc->event0;
> +			ev =3D &adc->event0;
> +		}
> +		else
> +			ev =3D &adc->event1;
> +	}

} else /*...

> +	else /* both AUTO channels already in use */ {
> +		dev_warn(adc->dev, "event0 - %d, event1 - %d\n",
> +			 adc->event0.channel, adc->event1.channel);
> +		return -EBUSY;
> +	}
> +
> +	ev->channel =3D adc_chan;
> +	ev->direction =3D dir;
> +
> +	return palmas_gpadc_reconfigure_event_channels(adc);
> +}

> +
> +static int palmas_gpadc_write_event_value(struct iio_dev *indio_dev,
> +	const struct iio_chan_spec *chan, enum iio_event_type type,
> +	enum iio_event_direction dir, enum iio_event_info info, int val,
> +	int val2)

Prefer parameters aligned just after (

> +{
...


> =20
>  static int palmas_gpadc_probe(struct platform_device *pdev)

...

>  	/* set the current source 0 (value 0/5/15/20 uA =3D> 0..3) */
>  	if (gpadc_pdata->ch0_current <=3D 1)
>  		adc->ch0_current =3D PALMAS_ADC_CH0_CURRENT_SRC_0;
> @@ -610,20 +998,23 @@ static int palmas_gpadc_probe(struct platform_devic=
e *pdev)
>  		return dev_err_probe(adc->dev, ret,
>  				     "iio_device_register() failed\n");
> =20
> -	device_set_wakeup_capable(&pdev->dev, 1);
>  	for (i =3D 0; i < PALMAS_ADC_CH_MAX; i++) {
>  		if (!(adc->adc_info[i].is_uncalibrated))
>  			palmas_gpadc_calibrate(adc, i);
>  	}
> =20
> +	device_set_wakeup_capable(&pdev->dev, 1);
>  	if (adc->wakeup1_enable || adc->wakeup2_enable) {
> -		device_wakeup_enable(&pdev->dev);
> -		ret =3D devm_add_action_or_reset(&pdev->dev,
> -					       palmas_disable_wakeup,
> -					       &pdev->dev);
> +		ret =3D palmas_adc_wakeup_configure(adc);
>  		if (ret)
>  			return ret;
> +		device_wakeup_enable(&pdev->dev);

>  	}
> +	ret =3D devm_add_action_or_reset(&pdev->dev,

Add a comment for this to explain why it might need disabling even if
it wasn't enabled above.  I think if you just drop wakeup support in
general that will be fine given we have no known users.


> +				       palmas_disable_wakeup,
> +				       adc);
> +	if (ret)
> +		return ret;
> =20
>  	return 0;
>  }

