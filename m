Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8ADA701EBB
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 19:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237762AbjENR2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 13:28:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237624AbjENR2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 13:28:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 999342102;
        Sun, 14 May 2023 10:28:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 27BC660ADE;
        Sun, 14 May 2023 17:28:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D086C433EF;
        Sun, 14 May 2023 17:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684085327;
        bh=o3SzUgk5jsdY0Si6hbeTlwqShrDXw+aPYZYtbFPQwvw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kNigjTeYq4ee8RdaGzF3T7a0CAqxL7gw+Unhssc7ONTVwmchF8JjPGun8CtL0pkhN
         KcfVQv+4x99qhx/QKXkEyoFK7OfTsfufs3ZLDajThwcdlCxMrJek1n3oRQTXJG5sV1
         9R5l7/NOt6LepvTbjsLZm3K6nr7+rEjqnG1UHkW4xIBdWEJ07m04cRvfCF1UlTocGF
         AFrP7bG5DBwl0elW1XgVZHpG+PJ7e3MYC+ydJHPxRWNrIY7gKR8fUmhKqvXjeyLFcZ
         thWX1bKTUgO+kz6d90C9ZR5UN6KRMyc1rl36PmqH6ugFqcOawzVy0GbErIX2bTyZeD
         ufbHbsx/1BfUg==
Date:   Sun, 14 May 2023 18:44:49 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Astrid Rost <astrid.rost@axis.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel@axis.com>
Subject: Re: [PATCH v2 7/7] iio: light: vcnl4000: Add calibration bias for
 4040/4200
Message-ID: <20230514184449.72aa1ab8@jic23-huawei>
In-Reply-To: <20230509140153.3279288-8-astrid.rost@axis.com>
References: <20230509140153.3279288-1-astrid.rost@axis.com>
        <20230509140153.3279288-8-astrid.rost@axis.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 May 2023 16:01:53 +0200
Astrid Rost <astrid.rost@axis.com> wrote:

> The calibration bias is setting the LED current to change
> the detection distance.
> Add read/write attribute for proximity calibration bias and read
> attribute for available values.
> This is supported for vcnl4040 and vcnl4200.
Another interesting mapping onto standard ABI.
I guess it sort of ends up mapping to calibbias so I think I'm fine with th=
is
one if other reviewers agree.

=46rom a quick look (run out of time again today!) this looks fine to me.
Will take another look at v3.

Thanks,

Jonathan

>=20
> Signed-off-by: Astrid Rost <astrid.rost@axis.com>
> ---
>  drivers/iio/light/vcnl4000.c | 97 ++++++++++++++++++++++++++++++++++--
>  1 file changed, 94 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
> index 1fd1eaaa4620..f0bf078dcdbe 100644
> --- a/drivers/iio/light/vcnl4000.c
> +++ b/drivers/iio/light/vcnl4000.c
> @@ -91,6 +91,7 @@
>  #define VCNL4040_CONF1_PS_PERS	GENMASK(5, 4) /* Proximity interrupt pers=
istence setting */
>  #define VCNL4040_PS_CONF2_PS_INT	GENMASK(9, 8) /* Proximity interrupt mo=
de */
>  #define VCNL4040_PS_CONF3_MPS		GENMASK(6, 5) /* Proximity multi pulse nu=
mber */
> +#define VCNL4040_PS_MS_LED_I		GENMASK(10, 8) /* Proximity current */
>  #define VCNL4040_PS_IF_AWAY		BIT(8) /* Proximity event cross low thresho=
ld */
>  #define VCNL4040_PS_IF_CLOSE		BIT(9) /* Proximity event cross high thres=
hold */
>  #define VCNL4040_ALS_RISING		BIT(12) /* Ambient Light cross high thresho=
ld */
> @@ -157,6 +158,17 @@ static const int vcnl4200_als_it_times[][2] =3D {
>  	{0, 400000},
>  };
> =20
> +static const int vcnl4040_ps_calibbias_ua[][2] =3D {
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
>  static const int vcnl4040_als_debounce_count[] =3D {1, 2, 4, 8};
>  static const int vcnl4040_ps_debounce_count[] =3D {1, 2, 3, 4};
>  static const int vcnl4040_ps_oversampling_ratio[] =3D {1, 2, 4, 8};
> @@ -838,6 +850,57 @@ static ssize_t vcnl4040_write_ps_oversampling_ratio(=
struct vcnl4000_data *data,
>  	return ret;
>  }
> =20
> +static ssize_t vcnl4040_read_ps_calibbias(struct vcnl4000_data *data, in=
t *val, int *val2)
> +{
> +	int ret;
> +
> +	ret =3D i2c_smbus_read_word_data(data->client, VCNL4200_PS_CONF3);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret =3D FIELD_GET(VCNL4040_PS_MS_LED_I, ret);
> +
> +	if (ret >=3D ARRAY_SIZE(vcnl4040_ps_calibbias_ua))
> +		return -EINVAL;
> +
> +	*val =3D vcnl4040_ps_calibbias_ua[ret][0];
> +	*val2 =3D vcnl4040_ps_calibbias_ua[ret][1];
> +
> +	return ret;
> +}
> +
> +static ssize_t vcnl4040_write_ps_calibbias(struct vcnl4000_data *data, i=
nt val)
> +{
> +	unsigned int i;
> +	int ret, index =3D -1;
> +	u16 regval;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(vcnl4040_ps_calibbias_ua); i++) {
> +		if (val =3D=3D vcnl4040_ps_calibbias_ua[i][1]) {
> +			index =3D i;
> +			break;
> +		}
> +	}
> +
> +	if (index < 0)
> +		return -EINVAL;
> +
> +	mutex_lock(&data->vcnl4000_lock);
> +
> +	ret =3D i2c_smbus_read_word_data(data->client, VCNL4200_PS_CONF3);
> +	if (ret < 0)
> +		goto out;
> +
> +	regval =3D (ret & ~VCNL4040_PS_MS_LED_I) |
> +	    FIELD_PREP(VCNL4040_PS_MS_LED_I, index);
> +	ret =3D i2c_smbus_write_word_data(data->client, VCNL4200_PS_CONF3,
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
> @@ -912,7 +975,16 @@ static int vcnl4000_read_raw(struct iio_dev *indio_d=
ev,
>  		default:
>  			return -EINVAL;
>  		}
> -
> +	case IIO_CHAN_INFO_CALIBBIAS:
> +		switch (chan->type) {
> +		case IIO_PROXIMITY:
> +			ret =3D vcnl4040_read_ps_calibbias(data, val, val2);
> +			if (ret < 0)
> +				return ret;
> +			return IIO_VAL_INT_PLUS_MICRO;
> +		default:
> +			return -EINVAL;
> +		}
>  	default:
>  		return -EINVAL;
>  	}
> @@ -952,6 +1024,13 @@ static int vcnl4040_write_raw(struct iio_dev *indio=
_dev,
>  		default:
>  			return -EINVAL;
>  		}
> +	case IIO_CHAN_INFO_CALIBBIAS:
> +		switch (chan->type) {
> +		case IIO_PROXIMITY:
> +			return vcnl4040_write_ps_calibbias(data, val2);
> +		default:
> +			return -EINVAL;
> +		}
>  	default:
>  		return -EINVAL;
>  	}
> @@ -1015,6 +1094,16 @@ static int vcnl4040_read_avail(struct iio_dev *ind=
io_dev,
>  		default:
>  			return -EINVAL;
>  		}
> +	case IIO_CHAN_INFO_CALIBBIAS:
> +		switch (chan->type) {
> +		case IIO_PROXIMITY:
> +			*vals =3D (int *)vcnl4040_ps_calibbias_ua;
> +			*length =3D 2 * ARRAY_SIZE(vcnl4040_ps_calibbias_ua);
> +			*type =3D IIO_VAL_INT_PLUS_MICRO;
> +			return IIO_AVAIL_LIST;
> +		default:
> +			return -EINVAL;
> +	}
>  	default:
>  		return -EINVAL;
>  	}
> @@ -1739,10 +1828,12 @@ static const struct iio_chan_spec vcnl4040_channe=
ls[] =3D {
>  		.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |
>  			BIT(IIO_CHAN_INFO_INT_TIME) |
>  			BIT(IIO_CHAN_INFO_DEBOUNCE_COUNT) |
> -			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
> +			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO) |
> +			BIT(IIO_CHAN_INFO_CALIBBIAS),
>  		.info_mask_separate_available =3D BIT(IIO_CHAN_INFO_INT_TIME) |
>  			BIT(IIO_CHAN_INFO_DEBOUNCE_COUNT) |
> -			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
> +			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO) |
> +			BIT(IIO_CHAN_INFO_CALIBBIAS),
>  		.ext_info =3D vcnl4000_ext_info,
>  		.event_spec =3D vcnl4040_event_spec,
>  		.num_event_specs =3D ARRAY_SIZE(vcnl4040_event_spec),

