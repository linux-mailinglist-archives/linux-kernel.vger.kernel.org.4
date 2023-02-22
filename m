Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A58D469EEF8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 07:53:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbjBVGxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 01:53:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjBVGxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 01:53:14 -0500
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4382D11E9F
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 22:53:12 -0800 (PST)
Date:   Wed, 22 Feb 2023 06:52:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1677048791; x=1677307991;
        bh=2fcc02TJKeCbdCgomqwRMSA3e/UKIY5bgqryL685toA=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=wTbYkHmXqoN9GbVNLkKptyKMXGrQgGe+Rdefi2e5zzAIVBb9dRZfp/wSk2l4aXVpU
         1fyrANNEhX7goFrgBwTK/90kdr1xAg/0U3phvpWoVRpyqr+/CXradkJ1bBkgYKO5WZ
         YEoP2/ZoQvfVCuO7JtdHm38RcKWjamat3ojrH3vsHUzL7at8X9l1moZuKeuNyhbkIy
         NnNyrQ73O6/vrHxcaK2tTf4SW7tEloFar7fYwVoz10SnCw9b52SkXuYqqEjKkckEcI
         TqAyDIhSW6gyyG1KF20utZo0wysiPgSXq7feeNZNJPK6XpZhsxAZwcDWT65M8HBz8S
         FRUlXMyvbiSyA==
To:     Asahi Lina <lina@asahilina.net>
From:   Heghedus Razvan <heghedus.razvan@protonmail.com>
Cc:     Boqun Feng <boqun.feng@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        John Stultz <jstultz@google.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        rust-for-linux@vger.kernel.org, asahi@lists.linux.dev
Subject: Re: [PATCH] rust: time: New module for timekeeping functions
Message-ID: <52Hk6hI5jZoH5VNisYoDk6lSpqPoIbZvUKFismYbzOWhUOyli8OmG_h9X-kBJz7jo5GUDUOMZQmY4Gl8aqNEW5b2ufNvjlWyM7wJKcioeng=@protonmail.com>
In-Reply-To: <03e9af69-3fea-032d-6dc3-ac0ea8e57471@asahilina.net>
References: <20230221-gpu-up-time-v1-1-bf8fe74b7f55@asahilina.net> <87v8jvnqq4.ffs@tglx> <Y/TP6as7qqwfcI42@boqun-archlinux> <87h6vfnh0f.ffs@tglx> <7b93bf74-abdc-f8c1-9a12-7c7f080f9e19@asahilina.net> <87edqioo1e.ffs@tglx> <CANiq72n-++roTv3yDNOA=Mi_sscBZX3xPdZ6RZ0Oxx+T82pf5A@mail.gmail.com> <87o7pmmtre.ffs@tglx> <Y/WDz013yBIfQPDq@boqun-archlinux> <03e9af69-3fea-032d-6dc3-ac0ea8e57471@asahilina.net>
Feedback-ID: 1233518:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

------- Original Message -------
On Wednesday, February 22nd, 2023 at 6:45 AM, Asahi Lina <lina@asahilina.ne=
t> wrote:


> On 22/02/2023 11.54, Boqun Feng wrote:
>=20
> > On Wed, Feb 22, 2023 at 01:24:53AM +0100, Thomas Gleixner wrote:
> >=20
> > > Miguel!
> > >=20
> > > On Tue, Feb 21 2023 at 23:29, Miguel Ojeda wrote:
> > >=20
> > > > On Tue, Feb 21, 2023 at 7:45 PM Thomas Gleixner tglx@linutronix.de =
wrote:
> > > >=20
> > > > > But xb abd xr are the same datatype because they represent a time=
 delta.
> > > >=20
> > > > In principle, one could also have different duration types too. For
> > > > instance, C++'s `std::chrono::duration` type is parametrized on the
> > > > representation type and the tick period, and thus an operation betw=
een
> > > > two time points like t1 - t0 returns a duration type that depends o=
n
> > > > the type of the time points, i.e. which clock they were obtained fr=
om.
> > >=20
> > > Correct, but for practical purposes I'd assume that the timestamps
> > > retrieved via ktime_get*() have the same granularity, i.e. 1ns.
> > >=20
> > > TBH, that's not entirely correct because:
> > >=20
> > > - the underlying hardware clocksource might not have a 1ns
> > > resolution
> > >=20
> > > - the CLOCK_*_COARSE implementations are only advanced once per
> > > tick, but are executing significantly faster because they avoid
> > > the hardware counter access.
> > >=20
> > > But that's an assumption which has proven to be workable and correct
> > > with the full zoo of hardware supported by the kernel.
> > >=20
> > > The point is that all CLOCK_* variants, except CLOCK_REALTIME and
> > > CLOCK_TAI are guaranteed to never go backwards.
> > >=20
> > > CLOCK_REALTIME and CLOCK_TAI are special as they can be set by user
> > > space and CLOCK_REALTIME has the extra oddities of leap seconds. But
> > > that's a well understood issue and is not specific to the kernel.
> > >=20
> > > Back to time deltas (or duration types). Independent of the above it
> > > might make sense to be type strict about these as well. Especially if=
 we
> > > go one step further and have timers based on CLOCK_* which need to be
> > > armed by either timestamps for absolute expiry or time deltas for
> > > relative to now expiry. I definitely can see a point for requiring
> > > matching time delta types there.
> > >=20
> > > That said, I have no strong opinions about this particular detail and
> > > leave it to the Rusties to agree on something sensible.
> >=20
> > I'd like to propose something below to make thing forward quickly:
> >=20
> > Given Lina only uses CLOCK_BOOTTIME and CLOCK_MONOTONIC, I'd say we
> > reuse core::time::Duration and probably remain its ">=3D0" semantics ev=
en
> > in the future we change its internal representation to u64.
> >=20
> > For timestamp type, use Instant semantics and use different types for
> > different clocks, i.e. similar to the implementation from Heghedus (muc=
h
> > better than mine!). But we can avoid implementing a fully version of
> > Instant, and focus on just the piece that Lina needs, which I believe
> > it's elapsed()?
> >=20
> > For the future, if we were to support non-monotonic timestamp, maybe we
> > use the different type name like TimeStamp and TimeDelta.
> >=20
> > In short:
> >=20
> > * For monotonic clocks, Instant + Duration, and keep them similar
> > to std semantics.
> >=20
> > * For non-monotonic clocks, don't worry it right now, and
> > probably different types for both stamps and deltas.
> >=20
> > Thoughts?
>=20
>=20
> I actually only used CLOCK_MONOTONIC in the end, so I could even leave
> CLOCK_BOOTTIME for later, though I like the idea of having scaffolding
> for several clock types even if we only implement one initially.
>=20
> This works for me, if you're happy with the idea I'll give it a spin
> based on Heghedus' example. Heghedus, is it okay if I put you down as
> Co-developed-by and can I get a signoff? ^^
Yes, of course. You have my support.

-- Heghedus Razvan (heghedus.razvan@protonmail.com)

>=20
> For the actual Instant type, I was thinking it makes sense to just
> internally represent it as a newtype of Duration as well. Then all the
> math becomes trivial based on Duration operations, and when we replace
> Duration with a new u64 type it'll all work out the same. Fundamentally
> that means Instant types are internally stored as the Duration between
> the epoch (e.g. system boot) subject to the way that clock ticks, which
> I think is a reasonable internal representation? (In other words, it's
> the same as my original patch behind the scenes, but wrapped in type
> safety).
>=20
> ~~ Lina
