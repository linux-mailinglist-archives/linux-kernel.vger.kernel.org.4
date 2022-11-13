Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E69A9626F5D
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 12:54:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235218AbiKMLyB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 06:54:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235215AbiKMLx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 06:53:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70204659E;
        Sun, 13 Nov 2022 03:53:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CE30760B65;
        Sun, 13 Nov 2022 11:53:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31279C433C1;
        Sun, 13 Nov 2022 11:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668340436;
        bh=R7L9DwjMGjPDVgVWUnGAS5Oy3kDJRhA4HxcWsDkaOjI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=eRlKLLv+8il+Ee01Gsebcs6vUDP/7tM0gF0eopcfpsHEOC2UpTTEBGrZYe9Lsv/tz
         onTyWQSeuu/CtI53DgMQLpHDgJlZdFW9tAzINJEigJU5zl3CVOvdXiCuZQ1wPFovnH
         cLggm09JTCy6yc0bIBGZrUJZ/pl7qsDeDUVCI8c23FU/h5/+Z5dOBHboHPxkDbxvzT
         cumlR9T9bGoI3GH70iqXWIuuC9n4A5Yv1jsXMLJgwqe/aXX+Sy6Qx5ql7EZNdnNpzA
         Ihh7QiFh4v/PWqpIXba0ezOWE1JzimHCvn4ZnqNW1VYekh65ZmCHJRiaycorH96MBI
         LJzUmHMMpK5vg==
Date:   Sun, 13 Nov 2022 12:06:10 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mitja =?UTF-8?B?xaBwZXM=?= <mitja@lxnav.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Angelo Compagnucci <angelo.compagnucci@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] iio: adc: mcp3422: allow setting gain and sampling
 per channel
Message-ID: <20221113120610.6568f9e6@jic23-huawei>
In-Reply-To: <CACbQKWfEa64Fv4CmW8BDp2rXw504YyL_s2TWiA_SwH-zCKKvCA@mail.gmail.com>
References: <20221111112657.1521307-1-mitja@lxnav.com>
        <20221111112657.1521307-3-mitja@lxnav.com>
        <20221112172806.6db090eb@jic23-huawei>
        <CACbQKWfEa64Fv4CmW8BDp2rXw504YyL_s2TWiA_SwH-zCKKvCA@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-pc-linux-gnu)
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

On Sat, 12 Nov 2022 21:51:36 +0100
Mitja =C5=A0pes <mitja@lxnav.com> wrote:

> Hi Jonathan,

Hi Mitja,

For future reference please keep the comments inline with the code and
reply there.  On this occasion I'm coming back this one day alter so it's
not too bad - but if it's a week later as often happens it can be hard
to follow if the code isn't there.

>=20
> On Sat, Nov 12, 2022 at 6:15 PM Jonathan Cameron <jic23@kernel.org> wrote:
> > Was it possible for these scales to differ before this change? =20
> Yes. The difference is that before this change you could only see and set
> available scales that were available for specified sampling rate. Now you=
're
> able to set gain and sampling rate via scale. So before the change you got
> these (@240sps):
>=20
> 0.001000000 0.000500000 0.000250000 0.000125000
>=20
> Now you get the complete set:
> /*                 gain x1     gain x2     gain x4     gain x8  */
> /* 240 sps    */ 0.001000000 0.000500000 0.000250000 0.000125000
> /*  60 sps    */ 0.000250000 0.000125000 0.000062500 0.000031250
> /*  15 sps    */ 0.000062500 0.000031250 0.000015625 0.000007812
> /*   3.75 sps */ 0.000015625 0.000007812 0.000003906 0.000001953

Ok. That doesn't work as a standard interface because userspace code wants =
to pick say
0.00062500 which appears twice.

I'm not understanding why you should see scales for other sampling rates.
We always allow any IIO attribute to have side effects on others, precisely
to allow for cases where they interact like here.  It's not ideal but there
isn't really a clean solution (as we are seeing here).

>=20
> > If not, then why was the previous patch a fix rather than simply a prec=
ursor
> > to this change (where it now matters). =20
> I wanted to separate a bug fix from improvements, if these were rejected =
for
> for some reason.

Is it a bug fix?  The way I read it is that, before this patch there is only
one scale that is applied to all channels.  As such, the current value =3D=
=3D the
value set and the code works as expected.
So the previous patch is only necessary once this one is applied.  Hence no
bug, just a rework that is useful to enabling this feature.

>=20
> > There are a number of changes in here which are more stylistic cleanup
> > than anything to do with the functional change. Please pull those out
> > to a precursor patch where we can quickly check they make not functiona=
l changes
> > rather than having them mixed in here. =20
> Will do.
>=20
> > I have no particular problem with taking these from hex
> > to decimal, though I'm not really seeing the necessity.
> >
> > However, it is really a style question and should not be in this
> > patch where it mostly adds noise making it slightly harder
> > to spot the functional changes. =20
> My styling preference. I think indexes should be decimal so they are not
> confused with flags.

They are also field values as used in the existing code - rather than simply
indexes.  Still field values can be either hex or decimal so given the comb=
ined
use I'm fine with the change.  However, precursor patch so we don't have no=
ise
in this patch where closer review is needed.

>=20
> > >               .info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) \
> > > -                             | BIT(IIO_CHAN_INFO_SCALE), \
> > > -             .info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SAMP_FR=
EQ), \
> > > +                             | BIT(IIO_CHAN_INFO_SCALE) \
> > > +                             | BIT(IIO_CHAN_INFO_SAMP_FREQ), \ =20
> >
> > Hmm. This is an ABI change.  Hopefully no one will notice however. =20
> Indeed. I've noted this in the cover letter.
No one reads cover letters :)  Also not in the git log so you want to call =
attention to
it in the description of this patch as well.

>=20
> > > +     for (i =3D 0; i < MCP3422_SRATE_COUNT; i++) {
> > > +             count +=3D sprintf(buf + count, "0.%09u 0.%09u 0.%09u 0=
.%09u%s",
> > > +                     mcp3422_scales[i][0],
> > > +                     mcp3422_scales[i][1],
> > > +                     mcp3422_scales[i][2],
> > > +                     mcp3422_scales[i][3],
> > > +                     (i < MCP3422_SRATE_COUNT - 1 ? " " : "\n")); =20
> >
> > What does the output of this now look like? =20
> 0.001000000 0.000500000 0.000250000 0.000125000
> 0.000250000 0.000125000 0.000062500 0.000031250
> 0.000062500 0.000031250 0.000015625 0.000007812
> 0.000015625 0.000007812 0.000003906 0.000001953
> All in one line.

Repetition is liable to confuse userspace so if we went this way you would
definitely need to stop doing that.

>=20
> > For available attributes we tend to only show the values available assu=
ming
> > just the one thing is changing.  Hence hold sampling frequency static, =
then
> > show what scales are available
> > It can get complex if there are nasty interactions so we might have a
> > situation where one attribute allows to all the possible values.
> > So maybe we have all scales available and on a write try to find
> > the nearest frequency to the current at which we can deliver the
> > required scale. =20
> That's what's being done here:

I don't follow.  This seems to just take the scale and match the first
instance of that it sees. That may not match the option that was available
at the current sampling frequency because of the repetition of possible sca=
les.

> + for (j =3D 0; j < MCP3422_SRATE_COUNT; j++) {
> + for (i =3D 0; i < MCP3422_PGA_COUNT; i++) {
> + if (val2 =3D=3D mcp3422_scales[j][i]) {
> + config &=3D ~MCP3422_PGA_MASK;
> + config |=3D MCP3422_PGA_VALUE(i);
> + config &=3D ~MCP3422_SRATE_MASK;
> + config |=3D MCP3422_SAMPLE_RATE_VALUE(j);
> + adc->ch_config[req_channel] =3D config;
> + return 0;
> + }
>   }
>   }
>=20
> Before it looked at only one sampling frequency and all gains, now it loo=
ks at
> all combinations.
> Looking at this I agree that it would be better to find nearest instead of
> looking for an exact match.
>=20
> > My gut feeling for this device is make the sampling frequency the domin=
ant
> > attribute.  So just list the available sampling frequencies not taking
> > scale into account.  For current sampling frequency just list the avail=
able
> > scales and only accept those to be written to the scale attr. =20
> That way the order in which you set attributes matters. Is that really be=
tter?
> This device has a settable sampling rate and gain and they are independen=
t.
> But we could only set gain via scale which values were sampling rate depe=
ndent.

This is a very common situation. If you expose all the scales, user who car=
es about
sampling frequency picks a scale that changes that as well as the pga value.
That is not what they expect to happen. So there is no good answer in cases
like this. Nature of ABI design is that we will always hit corner cases.  T=
he
get of jail free card here was the fact we let changing one attribute affect
others.

Trade off needs to be made and that decision was made in original version o=
f this
driver. I'm not seeing a strong enough reason to change it.

An improvement that does seem logical to me would be to have a change in ei=
ther
sampling frequency or scale attempt to maintain the nearest value of the ot=
her.
In some cases it can be exactly the same.  Any userspace code that already =
taking
advantage of how the two attributes affect each other will set sampling fre=
quency
first then set the scale.  This optimisation would not affect that so even =
though
the ABI would change a little it would not be in a way likely to break user=
space
code.

Jonathan



>=20
> > >       /* meaningful default configuration */
> > > +     for (i =3D 0; i < 4; i++) {
> > > +             adc->ch_config[i] =3D (MCP3422_CONT_SAMPLING
> > > +             | MCP3422_CHANNEL_VALUE(i)
> > > +             | MCP3422_PGA_VALUE(MCP3422_PGA_1)
> > > +             | MCP3422_SAMPLE_RATE_VALUE(MCP3422_SRATE_240));
> > > +     }
> > > +
> > >       config =3D (MCP3422_CONT_SAMPLING
> > >               | MCP3422_CHANNEL_VALUE(0)
> > >               | MCP3422_PGA_VALUE(MCP3422_PGA_1) =20
> >
> > Perhaps use the first channel configuration for this? =20
> Will fix.
>=20
> Kind regards,
> Mitja

