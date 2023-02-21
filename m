Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31C3169E988
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 22:33:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjBUVdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 16:33:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjBUVdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 16:33:50 -0500
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C52392D78;
        Tue, 21 Feb 2023 13:33:48 -0800 (PST)
Date:   Tue, 21 Feb 2023 21:33:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1677015226; x=1677274426;
        bh=RL72VfktvZSZwLdg205O+81BI72T3ECpaZs8xJd+WO4=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=hGqbBO7ZNdoE/T5azUEw1vSbnkbSMn0R9j9VkfQ1ZOojcmOiLULDzzsh82thOYiQa
         fjpdvi9tgiTXcE3z2omjMUzZlBKWAdDcMOs6tW35opwPEa8v0Lps3GNijsHZI0sflo
         VNEO9a4tEvkEN1cST/7rCBgULJkWOJ2ZUAzefttPQaTGNLIF8NoBS4bPNDrX16IloD
         sQqbgjBXqQhSs3dEH73bC3T/HltUfxNRaE1OdgyrO90aSDYNAxveHrFYjuFx6IcTzp
         q2xCeSqnY+2jJbS5kNsbJoPnaaNpfxyUxglFlan2I2sutRKzhVE4DSkUTuSx5ol4k8
         rEchqKZ7FpKBg==
To:     Thomas Gleixner <tglx@linutronix.de>
From:   Heghedus Razvan <heghedus.razvan@protonmail.com>
Cc:     Asahi Lina <lina@asahilina.net>, Boqun Feng <boqun.feng@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        John Stultz <jstultz@google.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        rust-for-linux@vger.kernel.org, asahi@lists.linux.dev
Subject: Re: [PATCH] rust: time: New module for timekeeping functions
Message-ID: <p7e4M5-kxxScH56bBMtlzht2_m33oSfMPHtExSVbDn0WIPYBEbiJjr2NvNhqCJotFhmYqH5h27EWPDhfSmmST0D-dSU1Alq4_BzDQUR48FA=@protonmail.com>
In-Reply-To: <87edqioo1e.ffs@tglx>
References: <20230221-gpu-up-time-v1-1-bf8fe74b7f55@asahilina.net> <87v8jvnqq4.ffs@tglx> <Y/TP6as7qqwfcI42@boqun-archlinux> <87h6vfnh0f.ffs@tglx> <7b93bf74-abdc-f8c1-9a12-7c7f080f9e19@asahilina.net> <87edqioo1e.ffs@tglx>
Feedback-ID: 1233518:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, February 21st, 2023 at 8:45 PM, Thomas Gleixner <tglx@linutroni=
x.de> wrote:


> On Wed, Feb 22 2023 at 01:31, Asahi Lina wrote:
>=20
> > On 22/02/2023 01.02, Thomas Gleixner wrote:
> >=20
> > > I'm not rusty enough, but you really want two types:
> > >=20
> > > timestamp and timedelta
> > >=20
> > > timestamp is an absolute time on a specific clock which is read via
> > > now() and you can add time deltas to it. The latter is required for
> > > arming an absolute timer on the clock.
> > >=20
> > > timedelta is a relative time and completely independent of any
> > > clock. That's what you get when you subtract two timestamps, but you =
can
> > > also initialize it from a constant or some other source. timedelta ca=
n
> > > be used to arm a relative timer on any clock.
> >=20
> > If all clocks end up as the same `timestamp` though, then this isn't
> > fully safe, because you could subtract `timestamp`s that came from
> > different clocks and the result would be meaningless. That's why the
> > Rust std Instant is specifically tied to one and only one system clock
> > on each platform.
>=20
>=20
> Fine, but do you agree that:
>=20
> ts1 =3D tboot.now()
> ...
> ts2 =3D tboot.now()
>=20
> xb =3D ts2 - ts1
>=20
> then the result x1 cannot be the same data type as ts1, ts2.
>=20
> From a typesafety perspective
>=20
> ts1 =3D treal.now()
> ...
> ts2 =3D tboot.now()
>=20
> x =3D ts2 - ts1
>=20
> would be an invalid operation, but
>=20
> ts1 =3D treal.now()
> ...
> ts2 =3D treal.now()
>=20
> xr =3D ts2 - ts1
>=20
> is obviously valid.
>=20
> But xb abd xr are the same datatype because they represent a time delta.
>=20
> That's the same the Rust std time semantics:
>=20
> Duration =3D Instance - Instance valid
> Duration =3D Systemtime - SystemTime valid
> Duration =3D Systemtime - Instance invalid
>=20
> No?
>=20
I agree with Thomas on this one. The Rust type system is really powerful an=
d we should take advantage of it. Time deltas can be enforced to be from th=
e same clock at compile time.
Just for the sake of it, I wrote a small example on how this can be achieve=
: https://play.rust-lang.org/?version=3Dstable&mode=3Ddebug&edition=3D2021&=
gist=3D1d0f70bb5329b181f203ce7270e2957a


-- Heghedus Razvan (heghedus.razvan@protonmail.com)

> Thanks,
>=20
> tglx
