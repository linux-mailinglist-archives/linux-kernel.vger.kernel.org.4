Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49EDE6C96E8
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 18:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231740AbjCZQob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 12:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjCZQoa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 12:44:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28AB94C15;
        Sun, 26 Mar 2023 09:44:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 333FD60F0E;
        Sun, 26 Mar 2023 16:44:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B97D6C433EF;
        Sun, 26 Mar 2023 16:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679849067;
        bh=KwJ0DTE2uOhsnWx4VPuos3R/MTndwYZFk+z4xnUeRaE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=leYzPzlke6VZsZrkqUddDPrd+Wypi6i1g/ycyOiZYgOMO1TvpMlKLBaTplO06I+QU
         JkEOrktxAC4XFMZ591FnotM5JvoSCqDzPsurM4arlfxSVdba5E4LciE/6RwfUhrphd
         cGyCIKFiR+Xu3cXLbiP/04vXiHErgnFNhGK8irLT4hWymEqT+dqc5dlMv/eEySB2cS
         GodbCOdDFn1/q63RbM/SQz+/MSgwLdd4K+FFjxV5FduhCHPfvzoQvMD4NMUf2tVZEs
         lhKNhZ2uvL+9fbC/V0MK0b0hIXbduUnAXoOIJtqZrDw5RrZfkxrZBSdpMupQwtvlQl
         DBr9NzMw7oUvQ==
Date:   Sun, 26 Mar 2023 17:59:28 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Patrik =?UTF-8?B?RGFobHN0csO2bQ==?= <risca@dalakolonin.se>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        letux-kernel@openphoenux.org, kernel@pyra-handheld.com,
        pgoudagunta@nvidia.com, hns@goldelico.com, lars@metafoo.de
Subject: Re: [PATCH 3/3] iio: adc: palmas_gpadc: remove
 palmas_adc_wakeup_property
Message-ID: <20230326175928.0dc26a4f@jic23-huawei>
In-Reply-To: <20230319223908.108540-4-risca@dalakolonin.se>
References: <20230319223908.108540-1-risca@dalakolonin.se>
        <20230319223908.108540-4-risca@dalakolonin.se>
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

On Sun, 19 Mar 2023 23:39:08 +0100
Patrik Dahlstr=C3=B6m <risca@dalakolonin.se> wrote:

> This struct contain essentially the same information as
> palmas_adc_event and palmas_gpadc_thresholds combined, but with more
> ambiguity: the code decided whether to trigger on rising or falling edge
> based on the high threshold being non-zero.
>=20
> Since its use in platform data has now been removed, we can remove it
> entirely.
>=20
> Lastly, the use case for waking up the cpu from sleep mode when a
> threshold has been passed is no longer the primary use for events so all
> code is changed to say "event" instead of "wakeup".
Good. I nearly pointed this out in the earlier patch.  The wakeup naming
was confusing. However, I'd prefer that was done in a separate patch to
any other changes.  It's hard to spot the meaningful stuff when there
is a lot of renaming going on.

A few questions / comments inline.

Jonathan

>=20
> Signed-off-by: Patrik Dahlstr=C3=B6m <risca@dalakolonin.se>
> ---
>  drivers/iio/adc/palmas_gpadc.c | 94 +++++++++++++---------------------
>  include/linux/mfd/palmas.h     |  6 ---
>  2 files changed, 36 insertions(+), 64 deletions(-)
>=20
> diff --git a/drivers/iio/adc/palmas_gpadc.c b/drivers/iio/adc/palmas_gpad=
c.c
> index 419d7db51345..042b68f29444 100644
> --- a/drivers/iio/adc/palmas_gpadc.c
> +++ b/drivers/iio/adc/palmas_gpadc.c
> @@ -122,10 +122,8 @@ struct palmas_gpadc {
>  	int				irq_auto_1;
>  	struct palmas_gpadc_info	*adc_info;
>  	struct completion		conv_completion;
> -	struct palmas_adc_wakeup_property wakeup1_data;
> -	struct palmas_adc_wakeup_property wakeup2_data;
> -	bool				wakeup1_enable;
> -	bool				wakeup2_enable;
> +	bool				event0_enable;
> +	bool				event1_enable;
>  	int				auto_conversion_period;
>  	struct mutex			lock;
>  	struct palmas_adc_event		event0;
> @@ -592,50 +590,26 @@ static int palmas_gpadc_read_event_config(struct ii=
o_dev *indio_dev,
>  	return ret;
>  }
> =20
> -static void palmas_adc_event_to_wakeup(struct palmas_gpadc *adc,
> -				       struct palmas_adc_event *ev,
> -				       struct palmas_adc_wakeup_property *wakeup)
> -{
> -	wakeup->adc_channel_number =3D ev->channel;
> -	if (ev->direction =3D=3D IIO_EV_DIR_RISING) {
> -		wakeup->adc_low_threshold =3D 0;
> -		wakeup->adc_high_threshold =3D
> -			palmas_gpadc_get_high_threshold_raw(adc, &adc->event0);
> -	}
> -	else {
> -		wakeup->adc_low_threshold =3D
> -			palmas_gpadc_get_low_threshold_raw(adc, &adc->event0);
> -		wakeup->adc_high_threshold =3D 0;
> -	}
> -}
> -
> -static int palmas_adc_wakeup_configure(struct palmas_gpadc *adc);
> -static int palmas_adc_wakeup_reset(struct palmas_gpadc *adc);
> +static int palmas_adc_events_configure(struct palmas_gpadc *adc);
> +static int palmas_adc_events_reset(struct palmas_gpadc *adc);
> =20
>  static int palmas_gpadc_reconfigure_event_channels(struct palmas_gpadc *=
adc)
>  {
> -	bool was_enabled =3D adc->wakeup1_enable || adc->wakeup2_enable;
> +	bool was_enabled =3D adc->event0_enable || adc->event1_enable;
>  	bool enable;
> =20
> -	adc->wakeup1_enable =3D adc->event0.channel =3D=3D -1 ? false : true;
> -	adc->wakeup2_enable =3D adc->event1.channel =3D=3D -1 ? false : true;
> +	adc->event0_enable =3D adc->event0.channel =3D=3D -1 ? false : true;
> +	adc->event1_enable =3D adc->event1.channel =3D=3D -1 ? false : true;
> =20
> -	enable =3D adc->wakeup1_enable || adc->wakeup2_enable;
> +	enable =3D adc->event0_enable || adc->event1_enable;
>  	if (!was_enabled && enable)
>  		device_wakeup_enable(adc->dev);
>  	else if (was_enabled && !enable)
>  		device_wakeup_disable(adc->dev);
> =20
> -	if (!enable)
> -		return palmas_adc_wakeup_reset(adc);
> -
> -	// adjust levels
> -	if (adc->wakeup1_enable)
> -		palmas_adc_event_to_wakeup(adc, &adc->event0, &adc->wakeup1_data);
> -	if (adc->wakeup2_enable)
> -		palmas_adc_event_to_wakeup(adc, &adc->event1, &adc->wakeup2_data);
> -
> -	return palmas_adc_wakeup_configure(adc);
> +	return enable ?
> +		palmas_adc_events_configure(adc) :
> +		palmas_adc_events_reset(adc);
>  }
> =20
>  static int palmas_gpadc_enable_event_config(struct palmas_gpadc *adc,
> @@ -864,12 +838,14 @@ static int palmas_gpadc_get_adc_dt_data(struct plat=
form_device *pdev,
>  	return 0;
>  }
> =20
> -static void palmas_disable_wakeup(void *data)
> +static void palmas_disable_events(void *data)
>  {
>  	struct palmas_gpadc *adc =3D data;
> =20
> -	if (adc->wakeup1_enable || adc->wakeup2_enable)
> +	if (adc->event0_enable || adc->event1_enable) {
> +		palmas_adc_events_reset(adc);

I can't immediately follow why this reset is needed when it wasn't before.
Perhaps that will be clearer once the renames aren't in the same patch.

>  		device_wakeup_disable(adc->dev);
> +	}
>  }
> =20
>  static int palmas_gpadc_probe(struct platform_device *pdev)
> @@ -993,7 +969,7 @@ static int palmas_gpadc_probe(struct platform_device =
*pdev)
> =20
>  	device_set_wakeup_capable(&pdev->dev, 1);
>  	ret =3D devm_add_action_or_reset(&pdev->dev,
> -				       palmas_disable_wakeup,
> +				       palmas_disable_events,
>  				       adc);
>  	if (ret)
>  		return ret;
> @@ -1001,7 +977,7 @@ static int palmas_gpadc_probe(struct platform_device=
 *pdev)
>  	return 0;
>  }
> =20
> -static int palmas_adc_wakeup_configure(struct palmas_gpadc *adc)
> +static int palmas_adc_events_configure(struct palmas_gpadc *adc)
>  {
>  	int adc_period, conv;
>  	int i;
> @@ -1027,16 +1003,18 @@ static int palmas_adc_wakeup_configure(struct pal=
mas_gpadc *adc)
>  	}
> =20
>  	conv =3D 0;
> -	if (adc->wakeup1_enable) {
> +	if (adc->event0_enable) {
> +		struct palmas_adc_event *ev =3D &adc->event0;
>  		int polarity;
> =20
> -		ch0 =3D adc->wakeup1_data.adc_channel_number;
> +		ch0 =3D ev->channel;
>  		conv |=3D PALMAS_GPADC_AUTO_CTRL_AUTO_CONV0_EN;
> -		if (adc->wakeup1_data.adc_high_threshold > 0) {
> -			thres =3D adc->wakeup1_data.adc_high_threshold;
> +
> +		if (ev->direction =3D=3D IIO_EV_DIR_RISING) {
> +			thres =3D palmas_gpadc_get_high_threshold_raw(adc, ev);
>  			polarity =3D 0;
>  		} else {
> -			thres =3D adc->wakeup1_data.adc_low_threshold;
> +			thres =3D palmas_gpadc_get_low_threshold_raw(adc, ev);
>  			polarity =3D PALMAS_GPADC_THRES_CONV0_MSB_THRES_CONV0_POL;
>  		}
> =20
> @@ -1058,16 +1036,18 @@ static int palmas_adc_wakeup_configure(struct pal=
mas_gpadc *adc)
>  		}
>  	}
> =20
> -	if (adc->wakeup2_enable) {
> +	if (adc->event1_enable) {
> +		struct palmas_adc_event *ev =3D &adc->event1;
>  		int polarity;
> =20
> -		ch1 =3D adc->wakeup2_data.adc_channel_number;
> +		ch1 =3D ev->channel;
>  		conv |=3D PALMAS_GPADC_AUTO_CTRL_AUTO_CONV1_EN;
> -		if (adc->wakeup2_data.adc_high_threshold > 0) {
> -			thres =3D adc->wakeup2_data.adc_high_threshold;
> +
> +		if (ev->direction =3D=3D IIO_EV_DIR_RISING) {
> +			thres =3D palmas_gpadc_get_high_threshold_raw(adc, ev);
>  			polarity =3D 0;
>  		} else {
> -			thres =3D adc->wakeup2_data.adc_low_threshold;
> +			thres =3D palmas_gpadc_get_low_threshold_raw(adc, ev);
>  			polarity =3D PALMAS_GPADC_THRES_CONV1_MSB_THRES_CONV1_POL;
>  		}
> =20
> @@ -1106,7 +1086,7 @@ static int palmas_adc_wakeup_configure(struct palma=
s_gpadc *adc)
>  	return ret;
>  }
> =20
> -static int palmas_adc_wakeup_reset(struct palmas_gpadc *adc)
> +static int palmas_adc_events_reset(struct palmas_gpadc *adc)
>  {
>  	int ret;
> =20
> @@ -1128,15 +1108,14 @@ static int palmas_gpadc_suspend(struct device *de=
v)
>  {
>  	struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
>  	struct palmas_gpadc *adc =3D iio_priv(indio_dev);
> -	int ret;

?  Seems unrelated - perhaps should be in earlier patch.

> =20
>  	if (!device_may_wakeup(dev))
>  		return 0;
> =20
> -	if (adc->wakeup1_enable)
> +	if (adc->event0_enable)
>  		enable_irq_wake(adc->irq_auto_0);
> =20
> -	if (adc->wakeup2_enable)
> +	if (adc->event1_enable)
>  		enable_irq_wake(adc->irq_auto_1);
> =20
>  	return 0;
> @@ -1146,15 +1125,14 @@ static int palmas_gpadc_resume(struct device *dev)
>  {
>  	struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
>  	struct palmas_gpadc *adc =3D iio_priv(indio_dev);
> -	int ret;

?

> =20
>  	if (!device_may_wakeup(dev))
>  		return 0;
> =20
> -	if (adc->wakeup1_enable)
> +	if (adc->event0_enable)
>  		disable_irq_wake(adc->irq_auto_0);
> =20
> -	if (adc->wakeup2_enable)
> +	if (adc->event1_enable)
>  		disable_irq_wake(adc->irq_auto_1);
> =20
>  	return 0;
