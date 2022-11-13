Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45ED6626FEC
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 14:51:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235378AbiKMNvs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 08:51:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235366AbiKMNvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 08:51:47 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 186F611148
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 05:51:46 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id ml12so6451022qvb.0
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 05:51:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lxnav.com; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WRhNcr9+layh98hn4bBSSTjB1kA3mJMo/7oEATsDq6k=;
        b=CKiSMHSkwUcyuWbN1zsZ5QVyeAPZh1Y7GrNlb5vGk1GFPWbX5MsWLQT87p2QsHuEXZ
         Vuofg+i0BsnjSNYr+4oeyYOGJZQLjNjRzFtJ46gax02A06BYvbIOieWqwZDoZZN0q11g
         6yF6QFSVqPysoJnkL8Kj3R2wKhLOroKBXTUyQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WRhNcr9+layh98hn4bBSSTjB1kA3mJMo/7oEATsDq6k=;
        b=uReZBtbG1lKs3+zTkSoubQU7+UNg8Y604TcFZxdO5Sjsj93DxldkS4pzVr/4YUtd4+
         sDgW8wyh6NExsXu6xCzCpJSyhXluJ/fXDZzSKvKInHKHJONQF2INovzVbYbCfCEVhVR2
         96wz4EhDYhU7PtI40DmRs9ydXp0YggaIteJuqABPOswDyd7JPV71J2sFMrXbxguwjmwS
         afUnJ+P1FvcPcJK31ASscOxVcJmGCXqMw0dq13FvCQtBoXnYGaVhbQY9+7pxkPns3wn8
         0HLI+8kV/y99Pf+IbvD9VLzkfngeegx2wHy3CK9mphkL3mln22yNvT8g5ZxpwT96XCd4
         wvpg==
X-Gm-Message-State: ANoB5pl5nlfiYDxrOG3rk8uZtIb1BHYAj2THIXGd+k1foJAHY4AbC/++
        G4SkBoXIluQPYI1+TfgSbUynfy6b6z/yByCSvvFoKg==
X-Google-Smtp-Source: AA0mqf4bQ9Y1C8qzFnuIQww5ymJnSJgZYXhi9VKX1j5Wn7ixrB39xdJ3ooPBv24sQNhXPfPa+uUraK7Uq9BDqoV2KWQ=
X-Received: by 2002:ad4:4432:0:b0:4b1:9054:b54a with SMTP id
 e18-20020ad44432000000b004b19054b54amr8886663qvt.122.1668347505140; Sun, 13
 Nov 2022 05:51:45 -0800 (PST)
MIME-Version: 1.0
References: <20221111112657.1521307-1-mitja@lxnav.com> <20221111112657.1521307-4-mitja@lxnav.com>
 <20221112173222.0ca56017@jic23-huawei> <CACbQKWe5xGT80_ZcQmTYrGThtFyw6xKD_OmGLi8XGi0pvR1RBA@mail.gmail.com>
 <20221113123338.5b3848df@jic23-huawei>
In-Reply-To: <20221113123338.5b3848df@jic23-huawei>
From:   =?UTF-8?Q?Mitja_=C5=A0pes?= <mitja@lxnav.com>
Date:   Sun, 13 Nov 2022 14:51:21 +0100
Message-ID: <CACbQKWciZHmF_hmNSkV7FXAiYfYg9=dVA-_7j1vLMF4_0BbtUQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] iio: adc: mcp3422: add hardware gain attribute
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Angelo Compagnucci <angelo.compagnucci@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for the explanations.

Kind regards,
Mitja

On Sun, Nov 13, 2022 at 1:21 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Sat, 12 Nov 2022 22:19:07 +0100
> Mitja =C5=A0pes <mitja@lxnav.com> wrote:
>
> > Hi Jonathan,
> >
> > On Sat, Nov 12, 2022 at 6:20 PM Jonathan Cameron <jic23@kernel.org> wro=
te:
> > > How are the separate?  We normally only use hardwaregain if
> > > changing it has no input on the scale that we need to apply in usersp=
ace
> > > to raw channels.  This normally happens for two reasons
> > > 1) There is a micro controller on the sensor that is doing a bunch of
> > >    maths so whilst changing the PGA value changes the range measurabl=
e it
> > >    doesn't affect the representation when we read from the device.
> > > 2) The hardware gain is controlling say the sensitivity of a light se=
nsor
> > >    in a time of flight device - it affects if we can get a measuremen=
t, but
> > >    not the measurement itself.
> > >
> > > Any of that true here?
> > No. I see I misunderstood the hardwaregain attribute. For me this is a =
user
> > friendly way of setting the gain and subsequently scale.
> >
> > What I don't understand is why set scale at all?
>
> Key issue here is the ABI is not designed against one part. It is designe=
d against
> many. Also it is inherently biased in favour of the parts that were aroun=
d when
> we originally created it - I'll note that at that time the trade off of r=
esolution
> against sampling period (oversampling or cutting off the measurement) was=
 not common.
>
> That means userspace code has been written that assumes a certain set of =
attributes.
> The cost of starting to use new attributes is high because no userspace c=
ode knows
> about them.  Hence we put a lot of effort into avoiding doing so.  I agre=
e that your
> argument makes sense for your particular device - it doesn't for many oth=
er ADCs.
>
> Many ADCs (I'd go as far as to say most though I could be wrong on that) =
do not
> couple scale and sampling frequency at all.
>
> > It's a result of sampling
> > rate and gain settings. Using it as a setting, for which input value ra=
nge also
> > changes depending on another attribute is quite cumbersome.
> > To use a sensor the program has to do this:
> > 1. set the sampling rate
> > 2. read available scales for this sampling rate
> > 3. set the scale according to desired gain
> > or know the scales for each sampling rate in advance...which makes avai=
lable
> > scales attribute quite useless.
>
> For this last point, I think trying to match against previous scale makes=
 a lot of
> sense as there is considerable overlap available here between the differe=
nt rates.
> I think that would be an improvement.  Another improvement would be to at=
 least
> expose the current resolution - that can be done by providing and _availa=
ble
> for the raw reading.  Not an idea way to undestand what is going on but i=
t would
> make more data available to userspace.  (_raw_available(max) * scale woul=
d give
> the range of the device and allow an adjustment of the scale to achieve w=
hat the
> user wants).
>
> ABI design is hard.  We don't always get it right and often there is no r=
ight answer.
> Reality is that sometimes userspace code needs to search the space if it =
is trying
> to get as close as possible to a particular set of constraints.  However =
lets assume
> in most cases the code has limits of:
>
> 1) A minimum data rate with which it is happy (controls
> the sampling frequency - higher is normally fine, but wastes power etc).
> To get best possible power usage (and in case of this device resolution) =
it will pick
> the lowest sampling frequency to meet this constraint.
>
> 2) A range of values it is interested in (here related to the PGA setting=
s but not
>    the sampling frequency).  Adding _raw_avail would help it to have visi=
bility of
>    what the range is.
>
> 3) A resolution it cares about getting data at (scale)
>
> We have to present 'scale' because that's necessary to allow userspace to=
 calculate the
> actual voltage.  That adds a constraint to the ABI design.  We also don't=
 want to provide
> more overlapping controls than absolutely necessary as that makes it hard=
 for userspace
> to know which one to use.
>
> So upshot is that userspace has to search to find a value that works for =
it.
>
> In this particular case the set of ranges at all sampling frequencies are=
 the same.
> So if we assume a constraint on how often data is wanted is more importan=
t than the
> resolution (have to pick one or the other to be more important) then we s=
et that
> first to the minimum value to meet the requirement.  Then scale is tweake=
d to set
> the PGA to match the range desired.  Sure, not super clean but consistent=
 with the
> ABI as it stands (and we can't change that other than very very carefully=
).
>
> As a fun side note, if the device (or driver) had justified the lower res=
olutions the other way
> (so the zeros ended up in least significant bits) a common solution would=
 have been
> to just present that to userspace as is, thus the scale would have been d=
ecoupled from
> the sampling frequency.  Not this is what oversampling devices normally d=
o...
> We obviously could fake that now, but the issue would then be that it was=
 a major
> driver ABI change. So we can't.
>
> Jonathan
>
>
>
>
>
>
> >
> > Kind regards,
> > Mitja
>
