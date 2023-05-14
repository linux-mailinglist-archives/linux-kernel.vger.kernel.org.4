Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0329E701E9D
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 19:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234837AbjENRM0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 13:12:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237327AbjENRMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 13:12:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A5544C0F;
        Sun, 14 May 2023 10:12:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8E6E1618A2;
        Sun, 14 May 2023 17:12:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05A28C433D2;
        Sun, 14 May 2023 17:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684084327;
        bh=wwW2tfzGFsTEtQjKd+/B4tm0PhHerJiD8U7n5Wpeyik=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=eVQJpTeRSH7bKAhOGKzXot1o+gbdPs4qmk2Q0umCXUvDWZABchFnq7h5y+XIY6h06
         x/yT8ve3EKp0CS93g8xvcCEPBJ01lsSRkt1zjnFtFOi8mC7CoeHSDkFqd1XUAx5C1K
         ATWVsrr1KyC8ALEPcBNVsBV9h/vun1X35055/VVz5p8Vkvf5hr6bKOBuEXRZIb8l8J
         CUH6iOTIhnpLAm111X3gsZvQImmKWEVsholIOqSYP42M/xC0GGqGuNRVGZvr6OVpBi
         SwgjdWb/FiFin8w9BxF9KwJ9qNZBxps2g7adAQ2117A9KgFju6VQKFTD0TWO0KGUUy
         7TBNPg4f4wqqg==
Date:   Sun, 14 May 2023 18:28:08 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Astrid Rost <astrid.rost@axis.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel@axis.com>
Subject: Re: [PATCH v2 3/7] iio: light: vcnl4000: Add als_it for
 vcnl4040/4200
Message-ID: <20230514182808.4dad13b5@jic23-huawei>
In-Reply-To: <20230509140153.3279288-4-astrid.rost@axis.com>
References: <20230509140153.3279288-1-astrid.rost@axis.com>
        <20230509140153.3279288-4-astrid.rost@axis.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 May 2023 16:01:49 +0200
Astrid Rost <astrid.rost@axis.com> wrote:

> Add illumination integration time for vcnl4040 and vcnl4200.
> Add read/write attribute for illumination integration time and read
> attribute for available integration times.
>=20
> Signed-off-by: Astrid Rost <astrid.rost@axis.com>
> ---
>  drivers/iio/light/vcnl4000.c =C3=B8 147 ++++++++++++++++++++++++++++++++=
---
>  1 file changed, 135 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
> index e14475070ac3..d7445b6755fa 100644
> --- a/drivers/iio/light/vcnl4000.c
> +++ b/drivers/iio/light/vcnl4000.c
> @@ -80,6 +80,7 @@
>  #define VCNL4000_SELF_TIMED_EN	BIT(0) /* start self-timed measurement */
> =20
>  #define VCNL4040_ALS_CONF_ALS_SHUTDOWN	BIT(0)
> +#define VCNL4040_ALS_CONF_IT		GENMASK(7, 6) /* Ambient integration time =
*/
>  #define VCNL4040_PS_CONF1_PS_SHUTDOWN	BIT(0)
>  #define VCNL4040_PS_CONF2_PS_IT	GENMASK(3, 1) /* Proximity integration t=
ime */
>  #define VCNL4040_PS_CONF2_PS_INT	GENMASK(9, 8) /* Proximity interrupt mo=
de */
> @@ -133,6 +134,20 @@ static const int vcnl4200_ps_it_times=C3=86=C3=85=C3=
=862=C3=85 =3D =C3=A6
>  	=C3=A60, 864=C3=A5,
>  =C3=A5;
> =20
> +static const int vcnl4040_als_it_times=C3=86=C3=85=C3=862=C3=85 =3D =C3=
=A6
> +	=C3=A60, 80000=C3=A5,

Interesting.  Maybe something went wrong with encoding of this patch?
It's reading very strangely to me.

Content-Type: text/plain; charset=3D"No"
in headers for this one vs previous which ahd
Content-Type: text/plain;

Which 'might' be the cause, I'm not sure.

Reading past the random characters I'm seeing, this has similar form
to earlier patches. I'd like all the chip differences encoded as data, not
as code.

Thanks,

Jonathan



> +	=C3=A60, 160000=C3=A5,
> +	=C3=A60, 320000=C3=A5,
> +	=C3=A60, 640000=C3=A5,
> +=C3=A5;
> +
> +static const int vcnl4200_als_it_times=C3=86=C3=85=C3=862=C3=85 =3D =C3=
=A6
> +	=C3=A60, 50000=C3=A5,
> +	=C3=A60, 100000=C3=A5,
> +	=C3=A60, 200000=C3=A5,
> +	=C3=A60, 400000=C3=A5,
> +=C3=A5;
> +
>  #define VCNL4000_SLEEP_DELAY_MS	2000 /* before we enter pm_runtime_suspe=
nd */
> =20
>  enum vcnl4000_device_ids =C3=A6
> @@ -334,7 +349,7 @@ static int vcnl4200_init(struct vcnl4000_data *data)
>  		data->vcnl4200_al.sampling_rate =3D ktime_set(0, 96000 * 1000);
>  		/* Default wait time is 5ms, add 20% tolerance. */
>  		data->vcnl4200_ps.sampling_rate =3D ktime_set(0, 6000 * 1000);
> -		data->al_scale =3D 120000;
> +		data->al_scale =3D 100000;
>  		break;
>  	=C3=A5
>  	mutex_init(&data->vcnl4200_al.lock);
> @@ -506,6 +521,85 @@ static int vcnl4000_set_pm_runtime_state(struct vcnl=
4000_data *data, bool on)
>  	return ret;
>  =C3=A5
> =20
> +static int vcnl4040_read_als_it(struct vcnl4000_data *data, int *val, in=
t *val2)
> +=C3=A6
> +	int ret;
> +	const int(*als_it_times)=C3=86=C3=85=C3=862=C3=85;
> +	int size;
> +
> +	if (data->id =3D=3D VCNL4200) =C3=A6
> +		als_it_times =3D &vcnl4200_als_it_times;
> +		size =3D ARRAY_SIZE(vcnl4200_als_it_times);
> +	=C3=A5 else =C3=A6
> +		als_it_times =3D &vcnl4040_als_it_times;
> +		size =3D ARRAY_SIZE(vcnl4040_als_it_times);
> +	=C3=A5
> +
> +	ret =3D i2c_smbus_read_word_data(data->client, VCNL4200_AL_CONF);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret =3D FIELD_GET(VCNL4040_ALS_CONF_IT, ret);
> +
> +	if (ret >=3D size)
> +		return -EINVAL;
> +
> +	*val =3D (*als_it_times)=C3=86ret=C3=85=C3=860=C3=85;
> +	*val2 =3D (*als_it_times)=C3=86ret=C3=85=C3=861=C3=85;
> +
> +	return 0;
> +=C3=A5
> +
> +static ssize_t vcnl4040_write_als_it(struct vcnl4000_data *data, int val)
> +=C3=A6
> +	unsigned int i;
> +	int ret, index =3D -1;
> +	u16 regval;
> +	const int(*als_it_times)=C3=86=C3=85=C3=862=C3=85;
> +	int size;
> +
> +	if (data->id =3D=3D VCNL4200) =C3=A6
> +		als_it_times =3D &vcnl4200_als_it_times;
> +		size =3D ARRAY_SIZE(vcnl4200_als_it_times);
> +	=C3=A5 else =C3=A6
> +		als_it_times =3D &vcnl4040_als_it_times;
> +		size =3D ARRAY_SIZE(vcnl4040_als_it_times);
> +	=C3=A5
> +
> +	for (i =3D 0; i < size; i++) =C3=A6
> +		if (val =3D=3D (*als_it_times)=C3=86i=C3=85=C3=861=C3=85) =C3=A6
> +			index =3D i;
> +			break;
> +		=C3=A5
> +	=C3=A5
> +
> +	if (index < 0)
> +		return -EINVAL;
> +
> +	data->vcnl4200_al.sampling_rate =3D ktime_set(0, val * 1200000);
> +	if (data->id =3D=3D VCNL4200)
> +		/* 24000 __lux/step * 50000 __s / val  */
> +		data->al_scale =3D div_u64(1200000000, val);
> +	else
> +		/* 100000 __lux/step * 80000 __s / val */
> +		data->al_scale =3D div_u64(8000000000, val);
> +
> +	mutex_lock(&data->vcnl4000_lock);
> +
> +	ret =3D i2c_smbus_read_word_data(data->client, VCNL4200_AL_CONF);
> +	if (ret < 0)
> +		goto out;
> +
> +	regval =3D (ret & =E2=80=BEVCNL4040_ALS_CONF_IT) =C3=B8
> +	    FIELD_PREP(VCNL4040_ALS_CONF_IT, index);
> +	ret =3D i2c_smbus_write_word_data(data->client, VCNL4200_AL_CONF,
> +					regval);
> +
> +out:
> +	mutex_unlock(&data->vcnl4000_lock);
> +	return ret;
> +=C3=A5
> +
>  static int vcnl4040_read_ps_it(struct vcnl4000_data *data, int *val, int=
 *val2)
>  =C3=A6
>  	int ret;
> @@ -616,9 +710,16 @@ static int vcnl4000_read_raw(struct iio_dev *indio_d=
ev,
>  		*val2 =3D data->al_scale;
>  		return IIO_VAL_INT_PLUS_MICRO;
>  	case IIO_CHAN_INFO_INT_TIME:
> -		if (chan->type !=3D IIO_PROXIMITY)
> +		switch (chan->type) =C3=A6
> +		case IIO_LIGHT:
> +			ret =3D vcnl4040_read_als_it(data, val, val2);
> +			break;
> +		case IIO_PROXIMITY:
> +			ret =3D vcnl4040_read_ps_it(data, val, val2);
> +			break;
> +		default:
>  			return -EINVAL;
> -		ret =3D vcnl4040_read_ps_it(data, val, val2);
> +		=C3=A5
>  		if (ret < 0)
>  			return ret;
>  		return IIO_VAL_INT_PLUS_MICRO;
> @@ -637,9 +738,14 @@ static int vcnl4040_write_raw(struct iio_dev *indio_=
dev,
>  	case IIO_CHAN_INFO_INT_TIME:
>  		if (val !=3D 0)
>  			return -EINVAL;
> -		if (chan->type !=3D IIO_PROXIMITY)
> +		switch (chan->type) =C3=A6
> +		case IIO_LIGHT:
> +			return vcnl4040_write_als_it(data, val2);
> +		case IIO_PROXIMITY:
> +			return vcnl4040_write_ps_it(data, val2);
> +		default:
>  			return -EINVAL;
> -		return vcnl4040_write_ps_it(data, val2);
> +		=C3=A5
>  	default:
>  		return -EINVAL;
>  	=C3=A5
> @@ -654,12 +760,27 @@ static int vcnl4040_read_avail(struct iio_dev *indi=
o_dev,
> =20
>  	switch (mask) =C3=A6
>  	case IIO_CHAN_INFO_INT_TIME:
> -		if (data->id =3D=3D VCNL4200) =C3=A6
> -			*vals =3D (int *)vcnl4200_ps_it_times;
> -			*length =3D 2 * ARRAY_SIZE(vcnl4200_ps_it_times);
> -		=C3=A5 else =C3=A6
> -			*vals =3D (int *)vcnl4040_ps_it_times;
> -			*length =3D 2 * ARRAY_SIZE(vcnl4040_ps_it_times);
> +		switch (chan->type) =C3=A6
> +		case IIO_LIGHT:
> +			if (data->id =3D=3D VCNL4200) =C3=A6
> +				*vals =3D (int *)vcnl4200_als_it_times;
> +				*length =3D 2 * ARRAY_SIZE(vcnl4200_als_it_times);
> +			=C3=A5 else =C3=A6
> +				*vals =3D (int *)vcnl4040_als_it_times;
> +				*length =3D 2 * ARRAY_SIZE(vcnl4040_als_it_times);
> +			=C3=A5
> +			break;
> +		case IIO_PROXIMITY:
> +			if (data->id =3D=3D VCNL4200) =C3=A6
> +				*vals =3D (int *)vcnl4200_ps_it_times;
> +				*length =3D 2 * ARRAY_SIZE(vcnl4200_ps_it_times);
> +			=C3=A5 else =C3=A6
> +				*vals =3D (int *)vcnl4040_ps_it_times;
> +				*length =3D 2 * ARRAY_SIZE(vcnl4040_ps_it_times);
> +			=C3=A5
> +			break;
> +		default:
> +			return -EINVAL;
>  		=C3=A5
>  		*type =3D IIO_VAL_INT_PLUS_MICRO;
>  		return IIO_AVAIL_LIST;
> @@ -1289,7 +1410,9 @@ static const struct iio_chan_spec vcnl4040_channels=
=C3=86=C3=85 =3D =C3=A6
>  	=C3=A6
>  		.type =3D IIO_LIGHT,
>  		.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) =C3=B8
> -			BIT(IIO_CHAN_INFO_SCALE),
> +			BIT(IIO_CHAN_INFO_SCALE) =C3=B8
> +			BIT(IIO_CHAN_INFO_INT_TIME),
> +		.info_mask_separate_available =3D BIT(IIO_CHAN_INFO_INT_TIME),
>  	=C3=A5, =C3=A6
>  		.type =3D IIO_PROXIMITY,
>  		.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) =C3=B8

