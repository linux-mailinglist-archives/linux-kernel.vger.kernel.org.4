Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C59B626F6B
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 13:21:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235242AbiKMMVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 07:21:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233792AbiKMMV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 07:21:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BA82EE3D;
        Sun, 13 Nov 2022 04:21:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E2C34B80B86;
        Sun, 13 Nov 2022 12:21:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F236C433D6;
        Sun, 13 Nov 2022 12:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668342083;
        bh=ljl9zDJlpRxVWK4mjDQBtQIeBXs0GrVWogCMwAilnL8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CY/sHeNmlD5o1SGmWou1L/acB1x6PudgStUawcfkgVGqeSD+AXRZiPdfEYiIMqDJ1
         fp7pnenS0vpeW4U0w5mCKdwkHm5n1VTeeT7/FGq8Db/FsL+0m7ATt495zktSuRg7XB
         K+EbVrD+GviemTVHaPkI6h1qFg5Dzcrc9Hj3gmJnJXhujuVoSC1XR2qaHYnQTK30Ox
         9vmjjI/sTvW4FSNquPQb4dbI6PkCf/wYOWTXD6+8iW5J78JrZcgOJMQZ0LT0fS7mN0
         8TFpyRU5u2RxMhAnNGaRdupG/vOF8Wgs41+xFSXoF19W+UoL3EAEEogCbgGKsbDVLQ
         07C6CNRagtMDA==
Date:   Sun, 13 Nov 2022 12:33:38 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mitja =?UTF-8?B?xaBwZXM=?= <mitja@lxnav.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Angelo Compagnucci <angelo.compagnucci@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] iio: adc: mcp3422: add hardware gain attribute
Message-ID: <20221113123338.5b3848df@jic23-huawei>
In-Reply-To: <CACbQKWe5xGT80_ZcQmTYrGThtFyw6xKD_OmGLi8XGi0pvR1RBA@mail.gmail.com>
References: <20221111112657.1521307-1-mitja@lxnav.com>
        <20221111112657.1521307-4-mitja@lxnav.com>
        <20221112173222.0ca56017@jic23-huawei>
        <CACbQKWe5xGT80_ZcQmTYrGThtFyw6xKD_OmGLi8XGi0pvR1RBA@mail.gmail.com>
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

On Sat, 12 Nov 2022 22:19:07 +0100
Mitja =C5=A0pes <mitja@lxnav.com> wrote:

> Hi Jonathan,
>=20
> On Sat, Nov 12, 2022 at 6:20 PM Jonathan Cameron <jic23@kernel.org> wrote:
> > How are the separate?  We normally only use hardwaregain if
> > changing it has no input on the scale that we need to apply in userspace
> > to raw channels.  This normally happens for two reasons
> > 1) There is a micro controller on the sensor that is doing a bunch of
> >    maths so whilst changing the PGA value changes the range measurable =
it
> >    doesn't affect the representation when we read from the device.
> > 2) The hardware gain is controlling say the sensitivity of a light sens=
or
> >    in a time of flight device - it affects if we can get a measurement,=
 but
> >    not the measurement itself.
> >
> > Any of that true here? =20
> No. I see I misunderstood the hardwaregain attribute. For me this is a us=
er
> friendly way of setting the gain and subsequently scale.
>=20
> What I don't understand is why set scale at all?=20

Key issue here is the ABI is not designed against one part. It is designed =
against
many. Also it is inherently biased in favour of the parts that were around =
when
we originally created it - I'll note that at that time the trade off of res=
olution
against sampling period (oversampling or cutting off the measurement) was n=
ot common.

That means userspace code has been written that assumes a certain set of at=
tributes.
The cost of starting to use new attributes is high because no userspace cod=
e knows
about them.  Hence we put a lot of effort into avoiding doing so.  I agree =
that your
argument makes sense for your particular device - it doesn't for many other=
 ADCs.

Many ADCs (I'd go as far as to say most though I could be wrong on that) do=
 not
couple scale and sampling frequency at all.=20

> It's a result of sampling
> rate and gain settings. Using it as a setting, for which input value rang=
e also
> changes depending on another attribute is quite cumbersome.
> To use a sensor the program has to do this:
> 1. set the sampling rate
> 2. read available scales for this sampling rate
> 3. set the scale according to desired gain
> or know the scales for each sampling rate in advance...which makes availa=
ble
> scales attribute quite useless.

For this last point, I think trying to match against previous scale makes a=
 lot of
sense as there is considerable overlap available here between the different=
 rates.
I think that would be an improvement.  Another improvement would be to at l=
east
expose the current resolution - that can be done by providing and _available
for the raw reading.  Not an idea way to undestand what is going on but it =
would
make more data available to userspace.  (_raw_available(max) * scale would =
give
the range of the device and allow an adjustment of the scale to achieve wha=
t the
user wants).

ABI design is hard.  We don't always get it right and often there is no rig=
ht answer.
Reality is that sometimes userspace code needs to search the space if it is=
 trying
to get as close as possible to a particular set of constraints.  However le=
ts assume
in most cases the code has limits of:

1) A minimum data rate with which it is happy (controls
the sampling frequency - higher is normally fine, but wastes power etc).
To get best possible power usage (and in case of this device resolution) it=
 will pick
the lowest sampling frequency to meet this constraint.

2) A range of values it is interested in (here related to the PGA settings =
but not
   the sampling frequency).  Adding _raw_avail would help it to have visibi=
lity of
   what the range is.

3) A resolution it cares about getting data at (scale)

We have to present 'scale' because that's necessary to allow userspace to c=
alculate the
actual voltage.  That adds a constraint to the ABI design.  We also don't w=
ant to provide
more overlapping controls than absolutely necessary as that makes it hard f=
or userspace
to know which one to use.

So upshot is that userspace has to search to find a value that works for it.

In this particular case the set of ranges at all sampling frequencies are t=
he same.
So if we assume a constraint on how often data is wanted is more important =
than the
resolution (have to pick one or the other to be more important) then we set=
 that
first to the minimum value to meet the requirement.  Then scale is tweaked =
to set
the PGA to match the range desired.  Sure, not super clean but consistent w=
ith the
ABI as it stands (and we can't change that other than very very carefully).

As a fun side note, if the device (or driver) had justified the lower resol=
utions the other way
(so the zeros ended up in least significant bits) a common solution would h=
ave been
to just present that to userspace as is, thus the scale would have been dec=
oupled from
the sampling frequency.  Not this is what oversampling devices normally do.=
..
We obviously could fake that now, but the issue would then be that it was a=
 major
driver ABI change. So we can't.

Jonathan






>=20
> Kind regards,
> Mitja

