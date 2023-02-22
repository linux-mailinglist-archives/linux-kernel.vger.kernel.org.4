Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD5369EBE8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 01:25:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbjBVAY6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 19:24:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjBVAY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 19:24:56 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F615311C6;
        Tue, 21 Feb 2023 16:24:55 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1677025494;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RFxbMXXmu1KSWmkyS7CNaBdRPgAJukHwXn3uC7mnL08=;
        b=Nt9NCiwE+E85SFvkEKjZghHHoGFdoJzJZFovt6bf0Svcxsq/6HikW4zCdeKhLNPh+JqDLh
        MdEnHXVBVtEkc2Si84GNYmIsOh+k4Meqegjnh56KfIYFibKprJkfMpVEPCtE4ewixknoUL
        KBVWDT30DpTzj4Hpfthp9jyVrrK9Y+xc26vE/3yFanSd4elbDn+WARhvqO5IA1LVhZ27zN
        2bYEjsO/bT8FgElwLUqg1zQyqSeU1o7NUA8TjKzpOxY0fGtR7/d9WpGTIrWVpB+qZCcAJs
        BXrbW6nDl+n6z7+tN4tKgrm/xlcegCxOH+fhAFHA8Yv3ZL4vMW8Fz4z2fiwlDA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1677025494;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RFxbMXXmu1KSWmkyS7CNaBdRPgAJukHwXn3uC7mnL08=;
        b=bPACesJRTqkEvI7v6VwG5UPWY6UuHlhFP3pfLOwSNlH2AszNtq10x52yRx7m2JRdXjqXrJ
        6pKXsh75FtmgEDBg==
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Asahi Lina <lina@asahilina.net>, Boqun Feng <boqun.feng@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        John Stultz <jstultz@google.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        rust-for-linux@vger.kernel.org, asahi@lists.linux.dev,
        Heghedus Razvan <heghedus.razvan@protonmail.com>
Subject: Re: [PATCH] rust: time: New module for timekeeping functions
In-Reply-To: <CANiq72n-++roTv3yDNOA=Mi_sscBZX3xPdZ6RZ0Oxx+T82pf5A@mail.gmail.com>
References: <20230221-gpu-up-time-v1-1-bf8fe74b7f55@asahilina.net>
 <87v8jvnqq4.ffs@tglx> <Y/TP6as7qqwfcI42@boqun-archlinux>
 <87h6vfnh0f.ffs@tglx> <7b93bf74-abdc-f8c1-9a12-7c7f080f9e19@asahilina.net>
 <87edqioo1e.ffs@tglx>
 <CANiq72n-++roTv3yDNOA=Mi_sscBZX3xPdZ6RZ0Oxx+T82pf5A@mail.gmail.com>
Date:   Wed, 22 Feb 2023 01:24:53 +0100
Message-ID: <87o7pmmtre.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Miguel!

On Tue, Feb 21 2023 at 23:29, Miguel Ojeda wrote:
> On Tue, Feb 21, 2023 at 7:45 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>>
>> But xb abd xr are the same datatype because they represent a time delta.
>
> In principle, one could also have different duration types too. For
> instance, C++'s `std::chrono::duration` type is parametrized on the
> representation type and the tick period, and thus an operation between
> two time points like t1 - t0 returns a duration type that depends on
> the type of the time points, i.e. which clock they were obtained from.

Correct, but for practical purposes I'd assume that the timestamps
retrieved via ktime_get*() have the same granularity, i.e. 1ns.

TBH, that's not entirely correct because:

    - the underlying hardware clocksource might not have a 1ns
      resolution

    - the CLOCK_*_COARSE implementations are only advanced once per
      tick, but are executing significantly faster because they avoid
      the hardware counter access.

But that's an assumption which has proven to be workable and correct
with the full zoo of hardware supported by the kernel.

The point is that all CLOCK_* variants, except CLOCK_REALTIME and
CLOCK_TAI are guaranteed to never go backwards.

CLOCK_REALTIME and CLOCK_TAI are special as they can be set by user
space and CLOCK_REALTIME has the extra oddities of leap seconds.  But
that's a well understood issue and is not specific to the kernel.

Back to time deltas (or duration types). Independent of the above it
might make sense to be type strict about these as well. Especially if we
go one step further and have timers based on CLOCK_* which need to be
armed by either timestamps for absolute expiry or time deltas for
relative to now expiry. I definitely can see a point for requiring
matching time delta types there.

That said, I have no strong opinions about this particular detail and
leave it to the Rusties to agree on something sensible.

Thanks,

        tglx
