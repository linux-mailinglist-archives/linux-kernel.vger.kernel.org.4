Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F50561DB40
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 15:54:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbiKEOys (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 10:54:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiKEOyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 10:54:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4646FCC5;
        Sat,  5 Nov 2022 07:54:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5CB19B80064;
        Sat,  5 Nov 2022 14:54:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A5B1C433C1;
        Sat,  5 Nov 2022 14:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667660083;
        bh=/s8f7cVivOw8Fsc07Scg3akhDQlrwqbg4k+q724J/ZY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Z42LswfNnBwpGES6TiX16Em80TSNIQkuZxtxJ7P82hXM64xaEPr6NavqjDTO1r1qo
         /Xv981rHTzJRnlcGIcyL7l8JrScMCYPYP5MmSit3gyBnJ6T6TKXUFeiLjriqIPOIRN
         oApHaCYkgBICzjsYq48JG7aPu7CDXPA1ZAAQOHMbpiDtnMKoYFIxODvpiq7mZzQIiv
         vETfASCqDULVzZ5fn6erJYbNdpUDIrRK/+CoyrSN/ya/Lm1/fyXDu5++SJeDKULUP4
         b0I58b+uS+iVRmnuEJAdIFH9T47QSxc6F2Ehjv8vuhCOoHp/eptiqvxOiXr+TC75bl
         XQQIpOiW1FO3g==
Date:   Sat, 5 Nov 2022 14:54:31 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Angel Iglesias <ang.iglesiasg@gmail.com>
Cc:     Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>, linux-iio@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] iio: pressure: bmp280: convert to i2c's
 .probe_new()
Message-ID: <20221105145431.4c2a7092@jic23-huawei>
In-Reply-To: <ae43aa9c3a9f29d0ecef69756a539ebf00a84ab1.camel@gmail.com>
References: <cover.1667151588.git.ang.iglesiasg@gmail.com>
        <af8ed10a85d48531c50823163e6c55b2a72371ef.1667151588.git.ang.iglesiasg@gmail.com>
        <20221101215236.ihoqkx2xckilom67@pengutronix.de>
        <ae43aa9c3a9f29d0ecef69756a539ebf00a84ab1.camel@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 02 Nov 2022 01:16:44 +0100
Angel Iglesias <ang.iglesiasg@gmail.com> wrote:

> On Tue, 2022-11-01 at 22:52 +0100, Uwe Kleine-K=C3=B6nig wrote:
> > Hello,
> >=20
> > On Sun, Oct 30, 2022 at 06:53:11PM +0100, Angel Iglesias wrote: =20
> > > Use i2c_client_get_device_id() to get the i2c_device_id* parameter in=
 the
> > > .new_probe() callback.
> > >=20
> > > Signed-off-by: Angel Iglesias <ang.iglesiasg@gmail.com>
> > > ---
> > > =C2=A0drivers/iio/pressure/bmp280-i2c.c | 8 ++++----
> > > =C2=A01 file changed, 4 insertions(+), 4 deletions(-)
> > >=20
> > > diff --git a/drivers/iio/pressure/bmp280-i2c.c
> > > b/drivers/iio/pressure/bmp280-i2c.c
> > > index 0c27211f3ea0..20073b09b3e3 100644
> > > --- a/drivers/iio/pressure/bmp280-i2c.c
> > > +++ b/drivers/iio/pressure/bmp280-i2c.c
> > > @@ -5,11 +5,11 @@
> > > =C2=A0
> > > =C2=A0#include "bmp280.h"
> > > =C2=A0
> > > -static int bmp280_i2c_probe(struct i2c_client *client,
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 const struct i2c_device_id *id)
> > > +static int bmp280_i2c_probe(struct i2c_client *client)
> > > =C2=A0{
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct regmap *regmap;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0const struct i2c_device_id=
 *id =3D i2c_client_get_device_id(client);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0const struct regmap_c=
onfig *regmap_config;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct regmap *regmap;
> > > =C2=A0
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0switch (id->driver_da=
ta) {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0case BMP180_CHIP_ID: =
=20
> >=20
> > What is the motivation for moving regmap? I thought reverse christmas
> > tree is only a thing in network code? I would have left the regmap
> > declaration where it is. =20
>=20
> Long story short, I worked previously on a small refactor of this driver =
to add
> support for a new family of sensors. During the different iterations of t=
he
> patchset, one thing that was agreed was unifying the driver coding style =
to
> reverse xmas tree. For some extra context, here's the thread:
> https://lore.kernel.org/all/20220814145249.701f1261@jic23-huawei/

Not something I feel strongly enough about either way, but has benefit of
consistency. However, it's an unrelated change in this patch, so drop it
to avoid the noise in a patch where you have more significant changes.

Jonathan

>=20
> > > @@ -65,7 +65,7 @@ static struct i2c_driver bmp280_i2c_driver =3D {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0.of_match_table =3D bmp280_of_i2c_match,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0.pm =3D pm_ptr(&bmp280_dev_pm_ops),
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0},
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.probe=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=3D bmp280_i2c_probe,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.probe_new=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=3D bmp280_i2c_probe,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.id_table=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=3D bmp280_i2c_id,
> > > =C2=A0};
> > > =C2=A0module_i2c_driver(bmp280_i2c_driver); =20
> >=20
> > Best regards
> > Uwe
> >  =20
> Kind regards
> Angel

