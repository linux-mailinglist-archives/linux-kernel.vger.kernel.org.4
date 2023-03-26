Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBC806C96E5
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 18:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232233AbjCZQiy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 12:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231740AbjCZQiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 12:38:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95C7B4C0C;
        Sun, 26 Mar 2023 09:38:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3301960F25;
        Sun, 26 Mar 2023 16:38:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F05E0C433D2;
        Sun, 26 Mar 2023 16:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679848729;
        bh=OBdemdIxYJmzk93mQDMIoImsVPhmvmbUXWelCaNpn1I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AEM450Is5hGpqGpnN3d5MVHG+LRejcc6y9JUFq4WNGkHQAXJdj6z8qsQq3A4RYAHD
         yf8b+2og1162RVTmV1HCFYggKjySEMsBU1L1awRBb9xYdrs51MklOrVcrIx5Kr6wkX
         g+7N+snZrKtt/zSD/IfM9VOFRDW5c3p8SwP+YQqIlB/DkTZMThvQlErOgG1OHC232A
         nqc6UQBOrUayY6ksAWLFIHb469nOoSMPU6g+D7yuLHLUkVuEFX2UK/zsjhUD5okCil
         ScE/hObNQHNu1Zr/6wyNc8iMhuUH/6eGyflfyajeDM32CfRhdJv9TXr5erLXEdWlqh
         o2yNWGq+Cr+8Q==
Date:   Sun, 26 Mar 2023 17:53:51 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Patrik =?UTF-8?B?RGFobHN0csO2bQ==?= <risca@dalakolonin.se>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        letux-kernel@openphoenux.org, kernel@pyra-handheld.com,
        pgoudagunta@nvidia.com, hns@goldelico.com, lars@metafoo.de
Subject: Re: [PATCH 2/3] iio: adc: palmas_gpadc: remove adc_wakeupX_data
Message-ID: <20230326175258.2ba6abb1@jic23-huawei>
In-Reply-To: <20230319223908.108540-3-risca@dalakolonin.se>
References: <20230319223908.108540-1-risca@dalakolonin.se>
        <20230319223908.108540-3-risca@dalakolonin.se>
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

On Sun, 19 Mar 2023 23:39:07 +0100
Patrik Dahlstr=C3=B6m <risca@dalakolonin.se> wrote:

> It does not seem to be used by anyone and having two ways to configure
> the same thing but for different use cases is bound to introduce bugs.
> This removes the special use case and leaves the generic one. It's still
> possible to achieve the same thing as before from userspace.

It wasn't possible to do it from userspace previously and there
is no way to turn it off without userspace having to explicitly disable eve=
nts
before suspending.

We could look at adding a userspace control on whether wakeup is enabled.
However, I'd raise the question of does anyone care for this particular dev=
ice
anymore.

As mentioned in patch 1 review, alternative is support either events or wak=
eup
configured at boot (if clever maybe allow for one of each combination as we=
ll).
That would keep to the old flows working and enable what you want.

Jonathan


>=20
> Signed-off-by: Patrik Dahlstr=C3=B6m <risca@dalakolonin.se>
> ---
>  drivers/iio/adc/palmas_gpadc.c | 18 ------------------
>  include/linux/mfd/palmas.h     |  2 --
>  2 files changed, 20 deletions(-)
>=20
> diff --git a/drivers/iio/adc/palmas_gpadc.c b/drivers/iio/adc/palmas_gpad=
c.c
> index 84c6e3b66205..419d7db51345 100644
> --- a/drivers/iio/adc/palmas_gpadc.c
> +++ b/drivers/iio/adc/palmas_gpadc.c
> @@ -948,18 +948,6 @@ static int palmas_gpadc_probe(struct platform_device=
 *pdev)
>  				     "request auto1 irq %d failed\n",
>  				     adc->irq_auto_1);
> =20
> -	if (gpadc_pdata->adc_wakeup1_data) {
> -		memcpy(&adc->wakeup1_data, gpadc_pdata->adc_wakeup1_data,
> -			sizeof(adc->wakeup1_data));
> -		adc->wakeup1_enable =3D true;
> -	}
> -
> -	if (gpadc_pdata->adc_wakeup2_data) {
> -		memcpy(&adc->wakeup2_data, gpadc_pdata->adc_wakeup2_data,
> -				sizeof(adc->wakeup2_data));
> -		adc->wakeup2_enable =3D true;
> -	}
> -
>  	adc->event0.channel =3D -1;
>  	adc->event0.direction =3D IIO_EV_DIR_NONE;
>  	adc->event1.channel =3D -1;
> @@ -1004,12 +992,6 @@ static int palmas_gpadc_probe(struct platform_devic=
e *pdev)
>  	}
> =20
>  	device_set_wakeup_capable(&pdev->dev, 1);
> -	if (adc->wakeup1_enable || adc->wakeup2_enable) {
> -		ret =3D palmas_adc_wakeup_configure(adc);
> -		if (ret)
> -			return ret;
> -		device_wakeup_enable(&pdev->dev);
> -	}
>  	ret =3D devm_add_action_or_reset(&pdev->dev,
>  				       palmas_disable_wakeup,
>  				       adc);
> diff --git a/include/linux/mfd/palmas.h b/include/linux/mfd/palmas.h
> index 1e61c7e9f50d..dc79d5e2d680 100644
> --- a/include/linux/mfd/palmas.h
> +++ b/include/linux/mfd/palmas.h
> @@ -153,8 +153,6 @@ struct palmas_gpadc_platform_data {
>  	int start_polarity;
> =20
>  	int auto_conversion_period_ms;
> -	struct palmas_adc_wakeup_property *adc_wakeup1_data;
> -	struct palmas_adc_wakeup_property *adc_wakeup2_data;
>  };
> =20
>  struct palmas_reg_init {

