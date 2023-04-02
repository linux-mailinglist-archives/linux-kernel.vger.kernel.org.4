Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 505336D38FB
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 18:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbjDBQ2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 12:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbjDBQ2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 12:28:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1F46CC38;
        Sun,  2 Apr 2023 09:28:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6B71AB80E8D;
        Sun,  2 Apr 2023 16:28:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9538DC433EF;
        Sun,  2 Apr 2023 16:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680452919;
        bh=cuTBAuoULmrxBtyY0st+jaww9kfkYIFHqyfOSXRfx3g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WtXbyvJgxVnQR4eGofeazpC1szyjZW7cMj1/uq0dVaeapUIrHute/RD1pogJez5uA
         RKjTuHsqwnbkeDU0tWCQJCuT7WvsCe4lZ9RFozZ8mRCV/90nT+Wz4wLiy4ypQ3jqNr
         xsyRLVQSigcpp3kCuUuuvMc6W/Y9UITbg65MlcL4osQA1Yi6hWCL+Rf+x5G7L5qHpq
         u0/3hYzDJPuwlhI07lbSsBJ4LZtDLvYlVsQmYaGY37ncXAsbuGoiN0uVfwPo0NNkbZ
         KmwokFwkxs4V2w3zgOngdaO8E0KOPT7rhylmPJmX4OO89CoelifeuFxQUjZYmNc3EF
         M/XEPTCC7Pwww==
Date:   Sun, 2 Apr 2023 17:43:47 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Patrik =?UTF-8?B?RGFobHN0csO2bQ==?= <risca@dalakolonin.se>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        letux-kernel@openphoenux.org, kernel@pyra-handheld.com,
        pgoudagunta@nvidia.com, hns@goldelico.com, lars@metafoo.de
Subject: Re: [PATCH 1/3] iio: adc: palmas_gpadc: add support for iio
 threshold events
Message-ID: <20230402174347.25e5ff06@jic23-huawei>
In-Reply-To: <20230401184507.GB2403322@dalakolonin.se>
References: <20230319223908.108540-1-risca@dalakolonin.se>
        <20230319223908.108540-2-risca@dalakolonin.se>
        <20230326175101.0ef2d6ae@jic23-huawei>
        <20230401184507.GB2403322@dalakolonin.se>
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

On Sat, 1 Apr 2023 20:45:07 +0200
Patrik Dahlstr=C3=B6m <risca@dalakolonin.se> wrote:

> On Sun, Mar 26, 2023 at 05:51:01PM +0100, Jonathan Cameron wrote:
> > On Sun, 19 Mar 2023 23:39:06 +0100
> > Patrik Dahlstr=C3=B6m <risca@dalakolonin.se> wrote:
> >  =20
> > > The palmas gpadc block has support for monitoring up to 2 ADC channels
> > > and issue an interrupt if they reach past a set threshold. The gpadc
> > > driver had limited support for this through the adc_wakeup{1,2}_data
> > > platform data. This however only allow a fixed threshold to be set at
> > > boot, and would only enable it when entering sleep mode.
> > >=20
> > > This change hooks into the IIO events system and exposes to userspace
> > > the ability to configure threshold values for each channel individual=
ly,
> > > but only allow up to 2 such thresholds to be enabled at any given tim=
e. =20
> >=20
> > Add a comment here on what happens if userspace tries to set more than =
two.
> > It's not as obvious as you'd think as we have some drivers that use a f=
ifo
> > approach so on setting the third event they push the oldest one out. =20
>=20
> Will do!
>=20
> Is there any preference to any one approach?

Not really.  Userspace should be checking either for an error, or that
the setup matches what it thinks it configured (after finishing configuring)
so it should cope with either.

>=20
> >  =20
> > >=20
> > > The logic around suspend and resume had to be adjusted so that user
> > > space configuration don't get reset on resume. Instead, any configured
> > > adc auto wakeup gets enabled during probe.
> > >=20
> > > Enabling a threshold from userspace will overwrite the adc wakeup
> > > configuration set during probe. Depending on how you look at it, this
> > > could also mean we allow userspace to update the adc wakeup threshold=
s. =20
> >=20
> > I'm not sure I read the code right, but can you end up enabling a wakeup
> > that wasn't previously present?  That seems likely something we should
> > not be doing after boot.
> >=20
> > One option here would be to make it either wakeup is supported, or even=
ts
> > are supported.  I suspect no one uses the wakeup anyway so that shouldn=
't
> > matter much (+ you remove it in next patch - do that first and this code
> > becomes more obvious).
> >  =20
>=20
> My use case is for monitoring a volume wheel connected to one of the ADC
> inputs of the palmas chip. By off-loading the monitoring to a separate
> chip, the SoC can go to sleep and only wake up when the wheel is moved.
>=20
> It made sense for my use case, but I see your point. IIO events and wakeup
> triggers should be treated as separate things. I will look into defining
> the dev_pm_info of the device. Then userspace should be able to control
> wakeup from /sys/devices/.../power/wakeup.
>=20
> However, suspend and resume is a bit flaky on my board so testing might be
> too. If the board reacts and at least tries to resume should indicate that
> the code works, no?

That will be fine. Obviously good to debug the other issues with resume tho=
ugh!

>=20
> In any case, I will remove the old wakeup code first in v2.
>=20
> >=20
> > A few trivial comments inline. =20
>=20
> I will adress them in v2. They all made perfect sense.
>> > > +	ret =3D devm_add_action_or_reset(&pdev->dev, =20
> >=20
> > Add a comment for this to explain why it might need disabling even if
> > it wasn't enabled above.  I think if you just drop wakeup support in
> > general that will be fine given we have no known users.
> >  =20
>=20
> I'm one such user.
Fair enough :)

Jonathan

>=20
> >  =20
> > > +				       palmas_disable_wakeup,
> > > +				       adc);
> > > +	if (ret)
> > > +		return ret;
> > > =20
> > >  	return 0;
> > >  } =20
> >=20
> >=20
> >  =20

