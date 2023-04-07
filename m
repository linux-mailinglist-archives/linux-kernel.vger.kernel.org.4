Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E2F26DB0D1
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 18:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbjDGQp4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 12:45:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbjDGQpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 12:45:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D314E7D8C;
        Fri,  7 Apr 2023 09:45:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 69C5E64FBD;
        Fri,  7 Apr 2023 16:45:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A8EBC433D2;
        Fri,  7 Apr 2023 16:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680885951;
        bh=iqswN3dSq+XLG1LLR/7UGVkU8eNIsxqJUyJVWh+cxqA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Zd/XfKV7rNS9OsyQhfjG00UTKRFMfzXicd8YMN1TdAvZk3VCQsPQVkloiLuT3AG+Z
         a5lJXpH8jfNwzTJwfGxVZW9RZCy3Jv2+W9z6qCE0nwv5WHtgIEaLQWP9IAx5e6kb3B
         CGY6zqaEtHsM0VYHxlDE/vc7zRqLv5Zm01ZYjK0DdkRRildOVE855KY1pTKM9Eur/f
         v6xX9JAYjk08OMrz8nT6lg/4jIg7fRKq7UBK1q3gRgFCoGFuD4DBPGK2gHxuLuhMnx
         KnljJrm26FbK3FuCRqst4q0mnEED24K3nVa4x8YT5s/mhSLf+okLaq3ZyNkCCwcyfH
         ESYyn8N+oHcdw==
Date:   Fri, 7 Apr 2023 18:01:07 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Patrik =?UTF-8?B?RGFobHN0csO2bQ==?= <risca@dalakolonin.se>
Cc:     "H. Nikolaus Schaller" <hns@goldelico.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        letux-kernel@openphoenux.org, kernel@pyra-handheld.com,
        pgoudagunta@nvidia.com, lars@metafoo.de, linux-omap@vger.kernel.org
Subject: Re: [PATCH v2 1/7] iio: adc: palmas: remove adc_wakeupX_data
Message-ID: <20230407180107.1d95cbf4@jic23-huawei>
In-Reply-To: <20230404103328.GD2403322@dalakolonin.se>
References: <20230402164247.3089146-1-risca@dalakolonin.se>
        <20230402164247.3089146-2-risca@dalakolonin.se>
        <ED6919A6-CE57-4C31-9AE5-2C31D288A810@goldelico.com>
        <20230404103328.GD2403322@dalakolonin.se>
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

On Tue, 4 Apr 2023 12:33:28 +0200
Patrik Dahlstr=C3=B6m <risca@dalakolonin.se> wrote:

> On Mon, Apr 03, 2023 at 06:49:36PM +0200, H. Nikolaus Schaller wrote:
> > Hi Patrik,
> >  =20
> > > Am 02.04.2023 um 18:42 schrieb Patrik Dahlstr=C3=B6m <risca@dalakolon=
in.se>:
> > >=20
> > > It does not seem to be used by anyone and later patches in this series
> > > are made simpler by first removing this. There is now a lot of dead c=
ode
> > > that cannot be reached, until later patches revive it. Arguably, this=
 is
> > > preferred over removing the code only to add it again.
> > >=20
> > > Signed-off-by: Patrik Dahlstr=C3=B6m <risca@dalakolonin.se>
> > > ---
> > > drivers/iio/adc/palmas_gpadc.c | 50 ++++------------------------------
> > > include/linux/mfd/palmas.h     |  8 ------
> > > 2 files changed, 6 insertions(+), 52 deletions(-)
> > >=20
> > > diff --git a/drivers/iio/adc/palmas_gpadc.c b/drivers/iio/adc/palmas_=
gpadc.c
> > > index 24d7c096e4b8..943ac579eb1f 100644
> > > --- a/drivers/iio/adc/palmas_gpadc.c
> > > +++ b/drivers/iio/adc/palmas_gpadc.c
> > > @@ -76,6 +76,12 @@ static struct palmas_gpadc_info palmas_gpadc_info[=
] =3D {
> > > 	PALMAS_ADC_INFO(IN15, 0, 0, 0, 0, INVALID, INVALID, true),
> > > };
> > >=20
> > > +struct palmas_adc_wakeup_property {
> > > +	int adc_channel_number;
> > > +	int adc_high_threshold;
> > > +	int adc_low_threshold;
> > > +};
> > > +
> > > /*
> > >  * struct palmas_gpadc - the palmas_gpadc structure
> > >  * @ch0_current:	channel 0 current source setting
> > > @@ -492,11 +498,6 @@ static int palmas_gpadc_get_adc_dt_data(struct p=
latform_device *pdev,
> > > 	return 0;
> > > }
> > >=20
> > > -static void palmas_disable_wakeup(void *dev) =20
> >=20
> > something seems to be mixed up here.
> >=20
> > There is no palmas_disable_wakeup() upstream that can be removed. So th=
is patch
> > can not be applied as 1/7 to any upstream kernel.
> >=20
> > Please rebase your series on either linus/master or linux-next/master. =
=20
>=20
> I'm sorry for the confusion. I should have been more clear in the cover
> letter.
>=20
> This series is based on Jonathan Cameron's iio tree[1], plus the patches =
at
> [2] and [3]. The first patch is already part of linux-next and I was under
> the impression that [3] would be soon too.
>=20
> Would it be best to rebase this series on linux-next instead?
>=20
> [1] git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git
> [2] https://patchwork.kernel.org/project/linux-iio/patch/20230313205029.1=
881745-1-risca@dalakolonin.se/
> [3] https://patchwork.kernel.org/project/linux-iio/patch/20230318163039.5=
6115-1-jic23@kernel.org/
>=20
This gets a bit complex because we have a mixture of fixes and updates and =
the desire
to end up with a fairly simple history in git.

Before [3] can be applied I need to move the togreg tree base to incorporat=
e a newer
version of char-misc/char-misc-next (which is the upstream for IIO pull req=
uests) and
the fix to have made the round trip to get there (which hasn't happened yet=
).
At that point I'll pick up the above and your series will be on top of that.

So you were fine to base this patch as you did, but you should make sure the
cover letter calls out the required patches that haven't yet made it upstre=
am.

I generally don't mind simple cases of needing to rebase if things are based
on rc1 (don't every use linux-next as it is not a stable base) whilst apply=
ing but
in this case the devm change is sufficiently fiddly that you have two obvio=
us choices.
1) Just add it to the start of your patch set (I'm fine with people doing t=
hat with
   anything I post).
2) Listing the patches that should be applied first in the cover letter.

Jonathan

> >=20
> > BR,
> > Nikolaus
> >  =20
> > > -{
> > > -	device_wakeup_disable(dev);
> > > -}
> > > -
> > > static int palmas_gpadc_probe(struct platform_device *pdev)
> > > {
> > > 	struct palmas_gpadc *adc;
> > > @@ -547,36 +548,6 @@ static int palmas_gpadc_probe(struct platform_de=
vice *pdev)
> > > 		return dev_err_probe(adc->dev, ret,
> > > 				     "request irq %d failed\n", adc->irq);
> > >=20
> > > -	if (gpadc_pdata->adc_wakeup1_data) {
> > > -		memcpy(&adc->wakeup1_data, gpadc_pdata->adc_wakeup1_data,
> > > -			sizeof(adc->wakeup1_data));
> > > -		adc->wakeup1_enable =3D true;
> > > -		adc->irq_auto_0 =3D  platform_get_irq(pdev, 1);
> > > -		ret =3D devm_request_threaded_irq(&pdev->dev, adc->irq_auto_0,
> > > -						NULL, palmas_gpadc_irq_auto,
> > > -						IRQF_ONESHOT,
> > > -						"palmas-adc-auto-0", adc);
> > > -		if (ret < 0)
> > > -			return dev_err_probe(adc->dev, ret,
> > > -					     "request auto0 irq %d failed\n",
> > > -					     adc->irq_auto_0);
> > > -	}
> > > -
> > > -	if (gpadc_pdata->adc_wakeup2_data) {
> > > -		memcpy(&adc->wakeup2_data, gpadc_pdata->adc_wakeup2_data,
> > > -				sizeof(adc->wakeup2_data));
> > > -		adc->wakeup2_enable =3D true;
> > > -		adc->irq_auto_1 =3D  platform_get_irq(pdev, 2);
> > > -		ret =3D devm_request_threaded_irq(&pdev->dev, adc->irq_auto_1,
> > > -						NULL, palmas_gpadc_irq_auto,
> > > -						IRQF_ONESHOT,
> > > -						"palmas-adc-auto-1", adc);
> > > -		if (ret < 0)
> > > -			return dev_err_probe(adc->dev, ret,
> > > -					     "request auto1 irq %d failed\n",
> > > -					     adc->irq_auto_1);
> > > -	}
> > > -
> > > 	/* set the current source 0 (value 0/5/15/20 uA =3D> 0..3) */
> > > 	if (gpadc_pdata->ch0_current <=3D 1)
> > > 		adc->ch0_current =3D PALMAS_ADC_CH0_CURRENT_SRC_0;
> > > @@ -616,15 +587,6 @@ static int palmas_gpadc_probe(struct platform_de=
vice *pdev)
> > > 			palmas_gpadc_calibrate(adc, i);
> > > 	}
> > >=20
> > > -	if (adc->wakeup1_enable || adc->wakeup2_enable) {
> > > -		device_wakeup_enable(&pdev->dev);
> > > -		ret =3D devm_add_action_or_reset(&pdev->dev,
> > > -					       palmas_disable_wakeup,
> > > -					       &pdev->dev);
> > > -		if (ret)
> > > -			return ret;
> > > -	}
> > > -
> > > 	return 0;
> > > }
> > >=20
> > > diff --git a/include/linux/mfd/palmas.h b/include/linux/mfd/palmas.h
> > > index 1e61c7e9f50d..55f22adb1a9e 100644
> > > --- a/include/linux/mfd/palmas.h
> > > +++ b/include/linux/mfd/palmas.h
> > > @@ -129,12 +129,6 @@ struct palmas_pmic_driver_data {
> > > 			    struct regulator_config config);
> > > };
> > >=20
> > > -struct palmas_adc_wakeup_property {
> > > -	int adc_channel_number;
> > > -	int adc_high_threshold;
> > > -	int adc_low_threshold;
> > > -};
> > > -
> > > struct palmas_gpadc_platform_data {
> > > 	/* Channel 3 current source is only enabled during conversion */
> > > 	int ch3_current;	/* 0: off; 1: 10uA; 2: 400uA; 3: 800 uA */
> > > @@ -153,8 +147,6 @@ struct palmas_gpadc_platform_data {
> > > 	int start_polarity;
> > >=20
> > > 	int auto_conversion_period_ms;
> > > -	struct palmas_adc_wakeup_property *adc_wakeup1_data;
> > > -	struct palmas_adc_wakeup_property *adc_wakeup2_data;
> > > };
> > >=20
> > > struct palmas_reg_init {
> > > --=20
> > > 2.25.1
> > >  =20
> >  =20

