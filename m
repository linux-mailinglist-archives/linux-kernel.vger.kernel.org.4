Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F400659B4F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 19:11:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235431AbiL3SLn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 13:11:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235597AbiL3SLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 13:11:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE841DF38;
        Fri, 30 Dec 2022 10:09:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 13EB8B81BFF;
        Fri, 30 Dec 2022 18:09:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F8DEC433D2;
        Fri, 30 Dec 2022 18:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672423775;
        bh=CoZ8Y9DkgEsHZLc653nnSDUcpjzD/J2+Dg3WhtxF4bE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hyt50MJf5YtZUNif3+pr1LX5qM7MB7dJxn8gfQAG6XSmuhF6WuxRYybNmHGwzQOu1
         R8ZRikS7J2okRgSc2M1G5Ai1pcEAgkLhtRUVPjlUEx+ZrIlrNGbH90YTjpyUxrThr7
         glmCx0bDUkbaKam7W4FyLgoEomrR4T4FtI78MuWezurZa0Lw+iG9RqdOMjB63dC9QL
         ZLC+Nf4uWsD3nftzcFXn7JNrEMoO+mNyWR4RRQo/MghL0yImPqDOSR+tiKHbIQKxH4
         HdEEnD5b52+OECbSSrByPUHjtDN/EdEvEWkRh4FuAStm6nOXSyg/WN+oK6aQfMsYDc
         cA/fyrTrz5/cQ==
Date:   Fri, 30 Dec 2022 18:22:53 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Angel Iglesias <ang.iglesiasg@gmail.com>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        ak@it-klinger.de, andriy.shevchenko@linux.intel.com,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, nikita.yoush@cogentembedded.com,
        paul@crapouillou.net, rafael.j.wysocki@intel.com,
        robh+dt@kernel.org, ulf.hansson@linaro.org
Subject: Re: [PATCH v2 3/5] iio: pressure: bmp280: Add support for new
 sensor BMP580
Message-ID: <20221230182253.45fcfdf4@jic23-huawei>
In-Reply-To: <8c4826ea5698e4e1b2910f5b01e66a41970a8053.camel@gmail.com>
References: <cover.1672062380.git.ang.iglesiasg@gmail.com>
        <c053976f56c3810915ca2ead6c358b5997b782e5.1672062380.git.ang.iglesiasg@gmail.com>
        <d0e98b2d-1c00-b7cc-d0b3-4477e27cf822@wanadoo.fr>
        <8c4826ea5698e4e1b2910f5b01e66a41970a8053.camel@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.36; x86_64-pc-linux-gnu)
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

On Thu, 29 Dec 2022 19:23:16 +0100
Angel Iglesias <ang.iglesiasg@gmail.com> wrote:

> On Thu, 2022-12-29 at 18:35 +0100, Christophe JAILLET wrote:
> > Le 26/12/2022 =C3=A0 15:29, Angel Iglesias a =C3=A9crit=C2=A0: =20
> > > Adds compatibility with the new sensor generation, the BMP580.
> > >=20
> > > The measurement and initialization codepaths are adapted from
> > > the device datasheet and the repository from manufacturer at
> > > https://github.com/boschsensortec/BMP5-Sensor-API.
> > >=20
> > > Signed-off-by: Angel Iglesias
> > > <ang.iglesiasg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > >  =20
> >=20
> > [...]
> >  =20
> > > diff --git a/drivers/iio/pressure/bmp280.h b/drivers/iio/pressure/bmp=
280.h
> > > index efc31bc84708..27d2abc17d01 100644
> > > --- a/drivers/iio/pressure/bmp280.h
> > > +++ b/drivers/iio/pressure/bmp280.h =20
> >=20
> > [...]
> >  =20
> > > +#define BMP580_CHIP_ID=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00x50
> > > =C2=A0 #define BMP380_CHIP_ID=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00x50 =20
> >=20
> > Hi,
> >=20
> > this is maybe correct (I've not been able to find the datasheet to chec=
k=20
> > myself), but it looks odd to have the same ID for 2 different chips. =20
>=20
> Yes, I also couldn't find a datasheet for the BMP580 or a devkit anywhere=
. I'm
> developing this using the BMP581, which seems to be a variant almost iden=
tical.
> Something similar happened with the BMP38x; you could find the BMP384 and=
 the
> BMP388, but the BMP380 was unavailable everywhere, datasheet included. My=
 guess
> is this is a similar situation. In any case, the datasheet of the BMP581 =
is
> available here:
> https://www.bosch-sensortec.com/media/boschsensortec/downloads/datasheets=
/bst-bmp581-ds004.pdf
>=20
> Regarding the chip id being the same between generations is weird, but at=
 least
> the datasheet and the sensor I have uses 0x50 as the chip id. After you
> mentioned this, I checked back on the reference API repository from Bosch=
 and it
> has both 0x50 and 0x51 as valid IDs:
> * https://github.com/boschsensortec/BMP5-Sensor-API/blob/master/bmp5_defs=
.h#L198
> * https://github.com/boschsensortec/BMP5-Sensor-API/blob/master/bmp5.c#L1=
444
https://github.com/boschsensortec/BMP3-Sensor-API/blob/master/bmp3_defs.h
I was curious on whether we had a wrong value for bmp380, but nope... Same =
ID.

Huh. As per earlier comment - who wants to moan at Bosch as this is crazy s=
ituation?

Jonathan


>=20
> Angel
>=20
> > CJ
> >  =20
> > > =C2=A0 #define BMP180_CHIP_ID=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00x55
> > > =C2=A0 #define BMP280_CHIP_ID=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00x58 =20
> >  =20
>=20

