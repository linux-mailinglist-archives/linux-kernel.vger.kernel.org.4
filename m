Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DED6D6C02A3
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 16:17:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbjCSPRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 11:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbjCSPRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 11:17:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33E9216338;
        Sun, 19 Mar 2023 08:17:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BBCB56103A;
        Sun, 19 Mar 2023 15:17:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3034DC433EF;
        Sun, 19 Mar 2023 15:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679239029;
        bh=ZNjkIU2Gg45vXdRXZGDZjrv9hYr8qsdYciUmSSwkVqc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KTTi7NYIqE2Hihc+wnBzgFXS1ZtQqfgVghnw9bxEHvPbik9nTWAnc4W5Ow1FvQ0NV
         iW66I5tx5Ton3UhIAvOr6aWrrN+/fJ10EWf0072143IHSWsmBljS6bxQ/fZhv9GCU9
         NMZXfG9CKBvXeMznKJdKcN4j/g2FMuLv2cLGx1vx13EHuywQ+fhi5ShgozF07z1QXZ
         ibBHFCpreyAyvR8ty/VhSynTOG2iy1VSTVsFXvR83dUzVupn7qyeKyMD+4x94C3Vs4
         BsFpipNnMw2MrqeuTB/sDW5Ah3EP+ZQW7GZrmRE29Tpp7rV23sBqrVwuTA1m/TkK8u
         djhLth73hpbcA==
Date:   Sun, 19 Mar 2023 15:32:03 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Patrik =?UTF-8?B?RGFobHN0csO2bQ==?= <risca@dalakolonin.se>
Cc:     lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, hns@goldelico.com
Subject: Re: [PATCH] iio: adc: palmas_gpadc: fix NULL dereference on rmmod
Message-ID: <20230319153203.54a40887@jic23-huawei>
In-Reply-To: <20230318192253.GB3605556@dalakolonin.se>
References: <20230313205029.1881745-1-risca@dalakolonin.se>
        <20230318163033.161d6fd5@jic23-huawei>
        <20230318192253.GB3605556@dalakolonin.se>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Mar 2023 20:22:53 +0100
Patrik Dahlstr=C3=B6m <risca@dalakolonin.se> wrote:

> On Sat, Mar 18, 2023 at 04:30:33PM +0000, Jonathan Cameron wrote:
> > On Mon, 13 Mar 2023 21:50:29 +0100
> > Patrik Dahlstr=C3=B6m <risca@dalakolonin.se> wrote:
> >  =20
> > > Calling dev_to_iio_dev() on a platform device pointer is undefined and
> > > will make adc NULL.
> > >=20
> > > Signed-off-by: Patrik Dahlstr=C3=B6m <risca@dalakolonin.se> =20
> >=20
> > Hi Patrik,
> >=20
> > Looks good so applied to the fixes-togreg branch of iio.git.
> >=20
> > Whilst we are here, this would be a trivial driver to take fully device
> > managed.  The only slightly messy bit is that it would need
> > a devm_add_action_or_reset() + custom callback to handle the
> > device_wakeup_enable().
> >=20
> > On the off chance you can test it I'll send a patch in a few mins.
> > Note that will depend on this one going up stream first and that
> > I haven't done more than build test it. =20
> I got the patch and it looks good, but it will take a few days before I
> have the time to test it.
>=20
> I have some more patches coming for this driver to configure the adc
> thresholds from userspace, employing the iio channel event subsystem, but
> they need a bit more work. In particular, to ensure backwards compatibili=
ty
> with the adc_wakeupX_data platform data. However, I don't see this platfo=
rm
> data being used by anyone.
> How important is it to retain support for adc_wakeupX_data?

It's a somewhat unusual feature, so I doubt it was implemented without some=
one
needing it.  However as you observe there is no upstream user.

As it is causing you problems, I'd just rip out the palmas_adc_platform_data
completely and see if anyone objects.  You can do that as a standalone patch
prior to posting your events stuff if you like.  Or hopefully
H. Nikolaus Schaller might be able to give us some background on why
that feature is there but not used.

> >=20
> > Thanks,
> >=20
> > Jonathan =20
>=20
> Thank you for going the extra mile :)

No problem.  I jumped on the opportunity to get it tested - takes way longer
than writing a little patch like that ;)

Jonathan

> >=20
> >  =20
> > > ---
> > >  drivers/iio/adc/palmas_gpadc.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >=20
> > > diff --git a/drivers/iio/adc/palmas_gpadc.c b/drivers/iio/adc/palmas_=
gpadc.c
> > > index 61e80bf3d05e..6db6f3bc768a 100644
> > > --- a/drivers/iio/adc/palmas_gpadc.c
> > > +++ b/drivers/iio/adc/palmas_gpadc.c
> > > @@ -638,7 +638,7 @@ static int palmas_gpadc_probe(struct platform_dev=
ice *pdev)
> > > =20
> > >  static int palmas_gpadc_remove(struct platform_device *pdev)
> > >  {
> > > -	struct iio_dev *indio_dev =3D dev_to_iio_dev(&pdev->dev);
> > > +	struct iio_dev *indio_dev =3D dev_get_drvdata(&pdev->dev);
> > >  	struct palmas_gpadc *adc =3D iio_priv(indio_dev);
> > > =20
> > >  	if (adc->wakeup1_enable || adc->wakeup2_enable) =20
> >  =20

