Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5FE26614FE
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 13:21:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232900AbjAHMVl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 07:21:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjAHMVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 07:21:38 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E9B43A0;
        Sun,  8 Jan 2023 04:21:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 45EEFB802C5;
        Sun,  8 Jan 2023 12:21:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F4D6C433EF;
        Sun,  8 Jan 2023 12:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673180494;
        bh=sumaWNlW6h6EpYfqkJMvJgEGwlLMZ5uFCOzdsK0PYVE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=I0NlSy2+B5Nex2MHHK44qgc/HfX1HanGEkJRdAMxtytbf/hLmNV3cE3hK1EcpwIJU
         LyY/AcLxhpUAZV0mo8Qcx/npR7k//j3OwvypXhiKyiPuBL4XNRLsTKkPoYsR6bSBod
         LmdsBuFSKQIupW4uTt/sbMd/vdic5MQ0Szalm2xQ9IINFpqfDUy6TLUN9/N5y3SI1P
         Ow3Ib2SFQtOynLGwS24PX0kjqWA4myHzlrgjTE45061Xi1Pu+BaF36MEXr8loKT2cB
         AtyvDYW9Isw/kRtRxEyr079gwkLyKOADNxnr863e+jq/L1H8HSI8LnfYnTOy7p1ZZU
         sFSF5KMEPGIjQ==
Date:   Sun, 8 Jan 2023 12:35:01 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Angel Iglesias <ang.iglesiasg@gmail.com>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        ak@it-klinger.de, andriy.shevchenko@linux.intel.com,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, nikita.yoush@cogentembedded.com,
        paul@crapouillou.net, rafael.j.wysocki@intel.com,
        robh+dt@kernel.org, ulf.hansson@linaro.org,
        "contact@bosch-sensortec.com" <contact@bosch-sensortec.com>
Subject: Re: [PATCH v2 3/5] iio: pressure: bmp280: Add support for new
 sensor BMP580
Message-ID: <20230108123501.3f88c11c@jic23-huawei>
In-Reply-To: <0f86cf66a14b4d5900ddee68cd7b49807128b7e9.camel@gmail.com>
References: <cover.1672062380.git.ang.iglesiasg@gmail.com>
        <c053976f56c3810915ca2ead6c358b5997b782e5.1672062380.git.ang.iglesiasg@gmail.com>
        <d0e98b2d-1c00-b7cc-d0b3-4477e27cf822@wanadoo.fr>
        <8c4826ea5698e4e1b2910f5b01e66a41970a8053.camel@gmail.com>
        <20221230182253.45fcfdf4@jic23-huawei>
        <0f86cf66a14b4d5900ddee68cd7b49807128b7e9.camel@gmail.com>
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

On Sun, 01 Jan 2023 12:16:28 +0100
Angel Iglesias <ang.iglesiasg@gmail.com> wrote:

> On Fri, 2022-12-30 at 18:22 +0000, Jonathan Cameron wrote:
> > On Thu, 29 Dec 2022 19:23:16 +0100
> > Angel Iglesias <ang.iglesiasg@gmail.com> wrote:
> >  =20
> > > On Thu, 2022-12-29 at 18:35 +0100, Christophe JAILLET wrote: =20
> > > > Le 26/12/2022 =C3=A0 15:29, Angel Iglesias a =C3=A9crit=C2=A0:=C2=
=A0  =20
> > > > > Adds compatibility with the new sensor generation, the BMP580.
> > > > >=20
> > > > > The measurement and initialization codepaths are adapted from
> > > > > the device datasheet and the repository from manufacturer at
> > > > > https://github.com/boschsensortec/BMP5-Sensor-API.
> > > > >=20
> > > > > Signed-off-by: Angel Iglesias
> > > > > <ang.iglesiasg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > > > > =C2=A0  =20
> > > >=20
> > > > [...]
> > > > =C2=A0  =20
> > > > > diff --git a/drivers/iio/pressure/bmp280.h
> > > > > b/drivers/iio/pressure/bmp280.h
> > > > > index efc31bc84708..27d2abc17d01 100644
> > > > > --- a/drivers/iio/pressure/bmp280.h
> > > > > +++ b/drivers/iio/pressure/bmp280.h=C2=A0  =20
> > > >=20
> > > > [...]
> > > > =C2=A0  =20
> > > > > +#define BMP580_CHIP_ID=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00x50
> > > > > =C2=A0 #define BMP380_CHIP_ID=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00x50=C2=A0  =20
> > > >=20
> > > > Hi,
> > > >=20
> > > > this is maybe correct (I've not been able to find the datasheet to =
check=20
> > > > myself), but it looks odd to have the same ID for 2 different chips=
.=C2=A0  =20
> > >=20
> > > Yes, I also couldn't find a datasheet for the BMP580 or a devkit anyw=
here.
> > > I'm
> > > developing this using the BMP581, which seems to be a variant almost
> > > identical.
> > > Something similar happened with the BMP38x; you could find the BMP384=
 and
> > > the
> > > BMP388, but the BMP380 was unavailable everywhere, datasheet included=
. My
> > > guess
> > > is this is a similar situation. In any case, the datasheet of the BMP=
581 is
> > > available here:
> > > https://www.bosch-sensortec.com/media/boschsensortec/downloads/datash=
eets/bst-bmp581-ds004.pdf
> > >=20
> > > Regarding the chip id being the same between generations is weird, bu=
t at
> > > least
> > > the datasheet and the sensor I have uses 0x50 as the chip id. After y=
ou
> > > mentioned this, I checked back on the reference API repository from B=
osch
> > > and it
> > > has both 0x50 and 0x51 as valid IDs:
> > > *
> > > https://github.com/boschsensortec/BMP5-Sensor-API/blob/master/bmp5_de=
fs.h#L198
> > > * https://github.com/boschsensortec/BMP5-Sensor-API/blob/master/bmp5.=
c#L1444 =20
> > https://github.com/boschsensortec/BMP3-Sensor-API/blob/master/bmp3_defs=
.h
> > I was curious on whether we had a wrong value for bmp380, but nope... S=
ame ID.
> >=20
> > Huh. As per earlier comment - who wants to moan at Bosch as this is cra=
zy
> > situation?
> >=20
> > Jonathan =20
>=20
> Well I'm doing this in my free time beacuse I wanted to setup a meteo sta=
tion
> and got annoyed needing to patch-up userspace code for reading pressure a=
nd
> temperature sensors on a very underpowered ARM device when there is a ker=
nel
> subsystem for this kind of things. The rest is history on the mailing lis=
t.
> I don't think I have any leverage to have Bosch listening to my complaints

Sadly I don't have a good contact in Bosch. So all we can do is +CC the
contact address.

If anyone else has a good channel to point out this silliness please do!

Jonathan

>=20
> Angel
>=20
> >  =20
> > >=20
> > > Angel
> > >  =20
> > > > CJ
> > > > =C2=A0  =20
> > > > > =C2=A0 #define BMP180_CHIP_ID=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00x55
> > > > > =C2=A0 #define BMP280_CHIP_ID=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00x58=C2=A0  =20
> > > > =C2=A0  =20
> > >  =20
> >  =20
>=20

