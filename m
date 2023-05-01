Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A637B6F324D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 16:50:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232370AbjEAOuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 10:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232249AbjEAOud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 10:50:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 065E01701;
        Mon,  1 May 2023 07:50:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8D96961191;
        Mon,  1 May 2023 14:50:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBCE5C433EF;
        Mon,  1 May 2023 14:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682952624;
        bh=uFo5D/hKo2Cb0E3C50X08BuXfEGAwYmK9E6G2PVtDG0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VoRY9R+ygwBCVH6oj9e7Z9osb0H10X0uZfI5HOm3xHzbAh0kD0KpmOMFYoru3cqZ5
         E9xk+jaMv7lYy5M0m+vZhWQ6aUIScbQFXJSMamNcTZtGivQTDbrDQAXVseEgfbAn9z
         5OSeZm0wQ6AGwp/0kNzWCJBeuAHQTScd3bIY011ZZT+N4zGh9P3+e+R+ITyKxe2WI+
         X+C4ybjDozKWXENtZR8eE0jDIMvcO7G+RGZaJIhyWR5R+P6h9kwBFgo5kdrlNg/jph
         5DW/4zjRG0CBPvjjigH32u/fqDM11j3mUIVOphg9BbzOyvC246xbo6s7qrpBcCNaLd
         Q4c4zRXhMvsUQ==
Date:   Mon, 1 May 2023 16:06:09 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Patrik =?UTF-8?B?RGFobHN0csO2bQ==?= <risca@dalakolonin.se>
Cc:     Dan Carpenter <dan.carpenter@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] iio: adc: palmas: fix off by one bugs
Message-ID: <20230501160609.4f2d8aab@jic23-huawei>
In-Reply-To: <20230429202538.GC1404696@dalakolonin.se>
References: <14fee94a-7db7-4371-b7d6-e94d86b9561e@kili.mountain>
        <20230423141124.3d4dc91d@jic23-huawei>
        <20230429202538.GC1404696@dalakolonin.se>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Apr 2023 22:25:38 +0200
Patrik Dahlstr=C3=B6m <risca@dalakolonin.se> wrote:

> On Sun, Apr 23, 2023 at 02:11:24PM +0100, Jonathan Cameron wrote:
> > On Fri, 21 Apr 2023 13:41:56 +0300
> > Dan Carpenter <dan.carpenter@linaro.org> wrote:
> >  =20
> > > Valid values for "adc_chan" are zero to (PALMAS_ADC_CH_MAX - 1).
> > > Smatch detects some buffer overflows caused by this:
> > > drivers/iio/adc/palmas_gpadc.c:721 palmas_gpadc_read_event_value() er=
ror: buffer overflow 'adc->thresholds' 16 <=3D 16
> > > drivers/iio/adc/palmas_gpadc.c:758 palmas_gpadc_write_event_value() e=
rror: buffer overflow 'adc->thresholds' 16 <=3D 16
> > >=20
> > > The effect of this bug in other functions is more complicated but
> > > obviously we should fix all of them.
> > >=20
> > > Fixes: a99544c6c883 ("iio: adc: palmas: add support for iio threshold=
 events")
> > > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org> =20
> >=20
> > Looks good to me.  Slight shuffle at the moment will delay me applying =
this.
> >=20
> > I'll wait for Linus to pick up Greg's pull request then rebase my fixes=
 branch
> > on top of that.  Otherwise I make a mess of linux-next ordering and thi=
ngs might
> > blow up.
> >=20
> > In meantime, Patrik, please take a look. =20
>=20
> Sorry for the long delay.
>=20
> The changes look good to me. I've checked all other uses of adc_chan in t=
he
> code and they all seem to be guarded by the checks below.
>=20
> Best regards
> Patrik
>=20
My tree has now advanced appropriately.

Applied to the fixes-togreg branch of iio.git.

Thanks,

Jonathan

> >=20
> > Jonathan
> >  =20
> > > ---
> > > ---
> > >  drivers/iio/adc/palmas_gpadc.c | 10 +++++-----
> > >  1 file changed, 5 insertions(+), 5 deletions(-)
> > >=20
> > > diff --git a/drivers/iio/adc/palmas_gpadc.c b/drivers/iio/adc/palmas_=
gpadc.c
> > > index c1c439215aeb..7dfc9c927a23 100644
> > > --- a/drivers/iio/adc/palmas_gpadc.c
> > > +++ b/drivers/iio/adc/palmas_gpadc.c
> > > @@ -547,7 +547,7 @@ static int palmas_gpadc_read_raw(struct iio_dev *=
indio_dev,
> > >  	int adc_chan =3D chan->channel;
> > >  	int ret =3D 0;
> > > =20
> > > -	if (adc_chan > PALMAS_ADC_CH_MAX)
> > > +	if (adc_chan >=3D PALMAS_ADC_CH_MAX)
> > >  		return -EINVAL;
> > > =20
> > >  	mutex_lock(&adc->lock);
> > > @@ -595,7 +595,7 @@ static int palmas_gpadc_read_event_config(struct =
iio_dev *indio_dev,
> > >  	int adc_chan =3D chan->channel;
> > >  	int ret =3D 0;
> > > =20
> > > -	if (adc_chan > PALMAS_ADC_CH_MAX || type !=3D IIO_EV_TYPE_THRESH)
> > > +	if (adc_chan >=3D PALMAS_ADC_CH_MAX || type !=3D IIO_EV_TYPE_THRESH)
> > >  		return -EINVAL;
> > > =20
> > >  	mutex_lock(&adc->lock);
> > > @@ -684,7 +684,7 @@ static int palmas_gpadc_write_event_config(struct=
 iio_dev *indio_dev,
> > >  	int adc_chan =3D chan->channel;
> > >  	int ret;
> > > =20
> > > -	if (adc_chan > PALMAS_ADC_CH_MAX || type !=3D IIO_EV_TYPE_THRESH)
> > > +	if (adc_chan >=3D PALMAS_ADC_CH_MAX || type !=3D IIO_EV_TYPE_THRESH)
> > >  		return -EINVAL;
> > > =20
> > >  	mutex_lock(&adc->lock);
> > > @@ -710,7 +710,7 @@ static int palmas_gpadc_read_event_value(struct i=
io_dev *indio_dev,
> > >  	int adc_chan =3D chan->channel;
> > >  	int ret;
> > > =20
> > > -	if (adc_chan > PALMAS_ADC_CH_MAX || type !=3D IIO_EV_TYPE_THRESH)
> > > +	if (adc_chan >=3D PALMAS_ADC_CH_MAX || type !=3D IIO_EV_TYPE_THRESH)
> > >  		return -EINVAL;
> > > =20
> > >  	mutex_lock(&adc->lock);
> > > @@ -744,7 +744,7 @@ static int palmas_gpadc_write_event_value(struct =
iio_dev *indio_dev,
> > >  	int old;
> > >  	int ret;
> > > =20
> > > -	if (adc_chan > PALMAS_ADC_CH_MAX || type !=3D IIO_EV_TYPE_THRESH)
> > > +	if (adc_chan >=3D PALMAS_ADC_CH_MAX || type !=3D IIO_EV_TYPE_THRESH)
> > >  		return -EINVAL;
> > > =20
> > >  	mutex_lock(&adc->lock); =20
> >  =20

