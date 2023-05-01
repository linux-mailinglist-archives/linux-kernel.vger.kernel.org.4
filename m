Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DCB76F332E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 17:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232658AbjEAPvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 11:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232231AbjEAPvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 11:51:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94F01A9;
        Mon,  1 May 2023 08:51:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 34B9C614E4;
        Mon,  1 May 2023 15:51:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 509D0C433D2;
        Mon,  1 May 2023 15:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682956280;
        bh=aV+Dz7671E26jI690tHeBhxMC+FmcjFpgAnZr8gc0lg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QbbqJgwmf7HvS5iu5RPnIwP1Ipkay85U98dgrCh7/9PHZXrB3WW/7BZP+oK30OGWq
         6eYwqSb2vdslSKdp+i/RvRjRAbCxnUyiCyNOJCXGwiVVlP9ZF7/jvjhvD1kHrraNcS
         zAfunxEdzWiuX+TQ5M5A7wJSbJNaa/M1jLaYix01QfxthjHdebaMJ2w1JLvjjx86KG
         fKgdQ8xF0HOxtC2yAX8vPk9AaDxfP508f1apmTjYvam0MnbqqMAc6Sr4lrL/c6Nte1
         /MJ3YvQWRxeL9fPcryldrhix0+6arcsU3fEaRTtGflt0Ferzidlg3VMUcGRzcGO6KB
         eAHnclVGkujaw==
Date:   Mon, 1 May 2023 17:07:06 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alisa Roman <alisa.roman@analog.com>,
        Fabrizio Lamarque <fl.scratchpad@gmail.com>
Subject: Re: [PATCH] iio: adc: ad7192: Change "shorted" channels to
 differential
Message-ID: <20230501170706.415768be@jic23-huawei>
In-Reply-To: <86b68c3a06aecfbdb58ddff77b4e5059f6acd2b5.camel@crapouillou.net>
References: <20230330102100.17590-1-paul@crapouillou.net>
        <20230401154220.755e52cb@jic23-huawei>
        <86b68c3a06aecfbdb58ddff77b4e5059f6acd2b5.camel@crapouillou.net>
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

On Tue, 25 Apr 2023 11:07:11 +0200
Paul Cercueil <paul@crapouillou.net> wrote:

> Hi Jonathan,
>=20
> Le samedi 01 avril 2023 =C3=A0 15:42 +0100, Jonathan Cameron a =C3=A9crit=
=C2=A0:
> > On Thu, 30 Mar 2023 12:21:00 +0200
> > Paul Cercueil <paul@crapouillou.net> wrote:
> >  =20
> > > The AD7192 provides a specific channel configuration where both
> > > negative
> > > and positive inputs are connected to AIN2. This was represented in
> > > the
> > > ad7192 driver as a IIO channel with .channel =3D 2 and .extended_name
> > > set
> > > to "shorted".
> > >=20
> > > The problem with this approach, is that the driver provided two IIO
> > > channels with the identifier .channel =3D 2; one "shorted" and the
> > > other
> > > not. This goes against the IIO ABI, as a channel identifier should
> > > be
> > > unique.
> > >=20
> > > Address this issue by changing "shorted" channels to being
> > > differential
> > > instead, with channel 2 vs. itself, as we're actually measuring
> > > AIN2 vs.
> > > itself.
> > >=20
> > > Note that the fix tag is for the commit that moved the driver out
> > > of
> > > staging. The bug existed before that, but backporting would become
> > > very
> > > complex further down and unlikely to happen.
> > >=20
> > > Fixes: b581f748cce0 ("staging: iio: adc: ad7192: move out of
> > > staging")
> > > Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> > > Co-developed-by: Alisa Roman <alisa.roman@analog.com>
> > > Signed-off-by: Alisa Roman <alisa.roman@analog.com> =20
> >=20
> > +CC Fabrizio who has a fix series under review for the same driver.
> >=20
> > I'm going to let this one sit on the list for a little while.
> > It is a breaking ABI change (that hopefully no one will notice -
> > given
> > the first fix from Fabrizio shows the driver crashes on probe
> > currently we
> > should be safe on that).
> >=20
> > Arguably just changing the index would also have been an ABI change,
> > but
> > that would have gotten past any code that didn't take much notice of
> > the
> > channel index whereas this won't.
> >=20
> > Anyhow, will give it a little while for comments then pick this up
> > on top of Fabrizio's fixes series.=C2=A0 Give me a poke in 2-3 weeks if=
 I
> > seem to have lost it. =20
>=20
> Friendly ping :)

Wise move :)

Applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks,

Jonathan

>=20
> Cheers,
> -Paul
>=20
> >=20
> > Jonathan
> >=20
> >  =20
> > > ---
> > > =C2=A0drivers/iio/adc/ad7192.c | 8 ++------
> > > =C2=A01 file changed, 2 insertions(+), 6 deletions(-)
> > >=20
> > > diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
> > > index 55a6ab591016..99bb604b78c8 100644
> > > --- a/drivers/iio/adc/ad7192.c
> > > +++ b/drivers/iio/adc/ad7192.c
> > > @@ -897,10 +897,6 @@ static const struct iio_info ad7195_info =3D {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0__AD719x_CHANNEL(_si,=
 _channel1, -1, _address, NULL,
> > > IIO_VOLTAGE, \
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0BIT(IIO_CHAN_INFO_SCALE), ad7192_calibsys_ext_in=
fo)
> > > =C2=A0
> > > -#define AD719x_SHORTED_CHANNEL(_si, _channel1, _address) \
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0__AD719x_CHANNEL(_si, _cha=
nnel1, -1, _address, "shorted",
> > > IIO_VOLTAGE, \
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0BIT(IIO_CHAN_INFO_SCALE), ad7192_calibsys_ext_info)
> > > -
> > > =C2=A0#define AD719x_TEMP_CHANNEL(_si, _address) \
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0__AD719x_CHANNEL(_si,=
 0, -1, _address, NULL, IIO_TEMP, 0,
> > > NULL)
> > > =C2=A0
> > > @@ -908,7 +904,7 @@ static const struct iio_chan_spec
> > > ad7192_channels[] =3D {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0AD719x_DIFF_CHANNEL(0=
, 1, 2, AD7192_CH_AIN1P_AIN2M),
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0AD719x_DIFF_CHANNEL(1=
, 3, 4, AD7192_CH_AIN3P_AIN4M),
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0AD719x_TEMP_CHANNEL(2=
, AD7192_CH_TEMP),
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0AD719x_SHORTED_CHANNEL(3, =
2, AD7192_CH_AIN2P_AIN2M),
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0AD719x_DIFF_CHANNEL(3, 2, =
2, AD7192_CH_AIN2P_AIN2M),
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0AD719x_CHANNEL(4, 1, =
AD7192_CH_AIN1),
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0AD719x_CHANNEL(5, 2, =
AD7192_CH_AIN2),
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0AD719x_CHANNEL(6, 3, =
AD7192_CH_AIN3),
> > > @@ -922,7 +918,7 @@ static const struct iio_chan_spec
> > > ad7193_channels[] =3D {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0AD719x_DIFF_CHANNEL(2=
, 5, 6, AD7193_CH_AIN5P_AIN6M),
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0AD719x_DIFF_CHANNEL(3=
, 7, 8, AD7193_CH_AIN7P_AIN8M),
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0AD719x_TEMP_CHANNEL(4=
, AD7193_CH_TEMP),
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0AD719x_SHORTED_CHANNEL(5, =
2, AD7193_CH_AIN2P_AIN2M),
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0AD719x_DIFF_CHANNEL(5, 2, =
2, AD7193_CH_AIN2P_AIN2M),
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0AD719x_CHANNEL(6, 1, =
AD7193_CH_AIN1),
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0AD719x_CHANNEL(7, 2, =
AD7193_CH_AIN2),
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0AD719x_CHANNEL(8, 3, =
AD7193_CH_AIN3), =20
> >  =20
>=20

