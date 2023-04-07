Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45BA86DB124
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 19:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbjDGRHc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 13:07:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjDGRH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 13:07:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D85AA5E1;
        Fri,  7 Apr 2023 10:07:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BBE9164D7B;
        Fri,  7 Apr 2023 17:07:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59346C433EF;
        Fri,  7 Apr 2023 17:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680887248;
        bh=SpgPykkClHKAhThs+z4qn0YQxf/SrPcL9DTrCA/21d8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Yj4TwwHHIGXKcFAdDpcOLQ5YtgMcs4EDZrRJaZZSLtZqNhDWeVroia9WTUjrZHzyR
         hrARDAdjnayEDYP/u0oGr759GyI2LmqbWUK8Gu4CRQAdM1rwZZdDEzK/uCVUhavumm
         90fnoIZ2EKrRb0/S7Vuv/ZM8Pv2tQjFCJIiM0ha+BtyudueX1EHqPIrBWwPKlI0LdA
         m2rUNS+HilT9TB63qjaCzgpnRf1fTlXTaj5GHpVYtb7nHJVSZDzQ+FFQd8lajo5/DZ
         OYDAZmIoXmRONOTj0s7TtkbUcsMaSnJUbX1qqOLDePMdwU8/S3FnVX24dpsuWXBJsQ
         WhF+QOKr8p6uA==
Date:   Fri, 7 Apr 2023 18:22:43 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Patrik =?UTF-8?B?RGFobHN0csO2bQ==?= <risca@dalakolonin.se>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        letux-kernel@openphoenux.org, kernel@pyra-handheld.com,
        pgoudagunta@nvidia.com, hns@goldelico.com, lars@metafoo.de,
        linux-omap@vger.kernel.org
Subject: Re: [PATCH v3 7/7] iio: adc: palmas: don't alter event config on
 suspend/resume
Message-ID: <20230407182243.5df2eaeb@jic23-huawei>
In-Reply-To: <20230405212233.4167986-8-risca@dalakolonin.se>
References: <20230405212233.4167986-1-risca@dalakolonin.se>
        <20230405212233.4167986-8-risca@dalakolonin.se>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  5 Apr 2023 23:22:33 +0200
Patrik Dahlstr=C3=B6m <risca@dalakolonin.se> wrote:

> The event config is controlled through the IIO events subsystem and
> device wakeup is controlled by /sys/devices/.../power/wakeup. Let's keep
> those two knobs independent.
>=20
> Signed-off-by: Patrik Dahlstr=C3=B6m <risca@dalakolonin.se>

Rest of series that I haven't replied to looks fine to me.

Once the fix patch dependency is in the right upstream branch
I'll get this and the devm patch queued up if no other comments come
in. =20

> ---
>  drivers/iio/adc/palmas_gpadc.c | 16 ++--------------
>  1 file changed, 2 insertions(+), 14 deletions(-)
>=20
> diff --git a/drivers/iio/adc/palmas_gpadc.c b/drivers/iio/adc/palmas_gpad=
c.c
> index 2e0755e9e3a4..ba3cc0e68197 100644
> --- a/drivers/iio/adc/palmas_gpadc.c
> +++ b/drivers/iio/adc/palmas_gpadc.c
> @@ -1137,16 +1137,10 @@ static int palmas_gpadc_suspend(struct device *de=
v)
>  {
>  	struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
>  	struct palmas_gpadc *adc =3D iio_priv(indio_dev);
> -	int wakeup =3D adc->event0.enabled || adc->event1.enabled;
> -	int ret;
> =20
> -	if (!device_may_wakeup(dev) || !wakeup)
> +	if (!device_may_wakeup(dev))
>  		return 0;
> =20
> -	ret =3D palmas_adc_configure_events(adc);
> -	if (ret < 0)
> -		return ret;
> -
>  	if (adc->event0.enabled)
>  		enable_irq_wake(adc->irq_auto_0);
> =20
> @@ -1160,16 +1154,10 @@ static int palmas_gpadc_resume(struct device *dev)
>  {
>  	struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
>  	struct palmas_gpadc *adc =3D iio_priv(indio_dev);
> -	int wakeup =3D adc->event0.enabled || adc->event1.enabled;
> -	int ret;
> =20
> -	if (!device_may_wakeup(dev) || !wakeup)
> +	if (!device_may_wakeup(dev))
>  		return 0;
> =20
> -	ret =3D palmas_adc_reset_events(adc);
> -	if (ret < 0)
> -		return ret;
> -
>  	if (adc->event0.enabled)
>  		disable_irq_wake(adc->irq_auto_0);
> =20

