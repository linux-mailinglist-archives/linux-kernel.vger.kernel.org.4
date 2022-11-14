Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46D3F628A16
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 21:07:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237505AbiKNUGi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 15:06:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237149AbiKNUGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 15:06:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D95B313F74;
        Mon, 14 Nov 2022 12:06:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6F26361423;
        Mon, 14 Nov 2022 20:06:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC90FC433C1;
        Mon, 14 Nov 2022 20:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668456382;
        bh=32WuxjarVSsybhggfkXelIieAyRDG9Oi2Cnquw9S+no=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qou8gf1sxX7yh6CAisII5jwtTRb+MtV3oHDYrArNOGIOC6OsxcLSHDLgQszAKPLd4
         cLsvC3zzXW6DhTpqsanQZ3fBT/bUrqq2KXePtTLPPUZ2I+JucP6CvJAqIS4MCxhmbw
         fUJ5OmPQ3BIAq7tm8ulZIbSOJYUp6PM/QIlnotedQUg+V64bi0+kYP36j2DVHX/YB6
         MF616Ynmsv1Y9eJ5T5tH/EiPZrS8HjA4nS+n9v9GwqZaEwFCMR25LrP09yeVvN4qiV
         xdAbpp+3fzzrGqq4D9Bwo6frr2xDQsDqiu8a5cTcT+CYN12wQB/V1IioqryLb3f019
         MdVsjs4S2bIoA==
Date:   Mon, 14 Nov 2022 20:18:40 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mitja =?UTF-8?B?xaBwZXM=?= <mitja@lxnav.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Angelo Compagnucci <angelo.compagnucci@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] iio: adc: mcp3422: allow setting gain and sampling
 per channel
Message-ID: <20221114201840.71a1326c@jic23-huawei>
In-Reply-To: <CACbQKWfzbxS2SKzd3v=h8-3oQw3hRhZJr_fJMaiTKaFwLn-jJg@mail.gmail.com>
References: <20221111112657.1521307-1-mitja@lxnav.com>
        <20221111112657.1521307-3-mitja@lxnav.com>
        <20221112172806.6db090eb@jic23-huawei>
        <CACbQKWfEa64Fv4CmW8BDp2rXw504YyL_s2TWiA_SwH-zCKKvCA@mail.gmail.com>
        <20221113120610.6568f9e6@jic23-huawei>
        <CACbQKWfzbxS2SKzd3v=h8-3oQw3hRhZJr_fJMaiTKaFwLn-jJg@mail.gmail.com>
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

On Sun, 13 Nov 2022 14:39:03 +0100
Mitja =C5=A0pes <mitja@lxnav.com> wrote:

> On Sun, Nov 13, 2022 at 12:53 PM Jonathan Cameron <jic23@kernel.org> wrot=
e:
> > > On Sat, Nov 12, 2022 at 6:15 PM Jonathan Cameron <jic23@kernel.org> w=
rote: =20
> > > > Was it possible for these scales to differ before this change? =20
> > > Yes. The difference is that before this change you could only see and=
 set
> > > available scales that were available for specified sampling rate. Now=
 you're
> > > able to set gain and sampling rate via scale. So before the change yo=
u got
> > > these (@240sps):
> > >
> > > 0.001000000 0.000500000 0.000250000 0.000125000
> > >
> > > Now you get the complete set:
> > > /*                 gain x1     gain x2     gain x4     gain x8  */
> > > /* 240 sps    */ 0.001000000 0.000500000 0.000250000 0.000125000
> > > /*  60 sps    */ 0.000250000 0.000125000 0.000062500 0.000031250
> > > /*  15 sps    */ 0.000062500 0.000031250 0.000015625 0.000007812
> > > /*   3.75 sps */ 0.000015625 0.000007812 0.000003906 0.000001953 =20
> >
> > Ok. That doesn't work as a standard interface because userspace code wa=
nts to pick say
> > 0.00062500 which appears twice. =20
> I don't know how I missed that. It's clear to me now that this patch is w=
rong.
>=20
>=20
> > > > If not, then why was the previous patch a fix rather than simply a =
precursor
> > > > to this change (where it now matters). =20
> > > I wanted to separate a bug fix from improvements, if these were rejec=
ted for
> > > for some reason. =20
> >
> > Is it a bug fix?  The way I read it is that, before this patch there is=
 only
> > one scale that is applied to all channels.  As such, the current value =
=3D=3D the
> > value set and the code works as expected.
> > So the previous patch is only necessary once this one is applied.  Henc=
e no
> > bug, just a rework that is useful to enabling this feature. =20
> I'll post the previous snippet here and write the comments inline:
> ----
> @@ -164,8 +164,9 @@ static int mcp3422_read_raw(struct iio_dev *iio,
>   struct mcp3422 *adc =3D iio_priv(iio);
>   int err;
>=20
> + u8 req_channel =3D channel->channel;
>   u8 sample_rate =3D MCP3422_SAMPLE_RATE(adc->config);
> - u8 pga =3D MCP3422_PGA(adc->config);  /* <- this uses the "current" con=
fig
>       which changes depending on the last read channel */
> + u8 pga =3D adc->pga[req_channel];          /* this now returns the PGA =
for the
>       selected channel */
>=20
>   switch (mask) {
>   case IIO_CHAN_INFO_RAW:
> ----
> I hope this clarifies the bugfix.

Ah I see. The bit that threw me off was the title of this patch.
"allow setting gain ... per channel" which made me think that before this p=
atch
there was one gain for all channels.  I was too lazy to actually check and =
discover
that it has always been per channel on the write side of things.

Jonathan


>=20
>=20
> Thanks for in depth look at this and sorry for wasting your time with this
> flawed patch.
>=20
> Kind regards,
> Mitja

