Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF1F69EE05
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 05:46:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbjBVEqM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 23:46:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjBVEqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 23:46:10 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0444C34313;
        Tue, 21 Feb 2023 20:46:06 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: lina@asahilina.net)
        by mail.marcansoft.com (Postfix) with ESMTPSA id A5FB941A42;
        Wed, 22 Feb 2023 04:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=asahilina.net;
        s=default; t=1677041164;
        bh=YefTKoatxpMrsoyHQZsN7uOgHmOyYEP0llX+E4XLaI0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=mwbrEHlYFM2LLXsWSzj6/R/gvTddOcyPMIA0rr6nhBG0xwNBYJJnA1hljVj+Xw5Vf
         zJO314/CeAFJ09brEXce0k4Q+QhvcYZpHHe6Dxni+3TfYzC2NvEjwxPpIK6v+g9R0S
         6+MUr+kcD4fhSKk6UeNO9PfrUQf0/GHfuFO4wgLOx2Uwt+w6tdI5pYQWW5NFFbX6SR
         lc/qdwssIk/OYLiE1CCeC5XgUIDuRJWMgLF2vfz1/UZsqwXHofOzOKOyp5qlehufT7
         Ym+7+/OQI1nYSCN73WpSUYtJvrQki60zq0EOGXKUWCezkxPs5Bo9mhgJs1+wpzTmmA
         yry5lmvc+zZnQ==
Message-ID: <03e9af69-3fea-032d-6dc3-ac0ea8e57471@asahilina.net>
Date:   Wed, 22 Feb 2023 13:45:58 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] rust: time: New module for timekeeping functions
Content-Language: en-US
To:     Boqun Feng <boqun.feng@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        John Stultz <jstultz@google.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        rust-for-linux@vger.kernel.org, asahi@lists.linux.dev,
        Heghedus Razvan <heghedus.razvan@protonmail.com>
References: <20230221-gpu-up-time-v1-1-bf8fe74b7f55@asahilina.net>
 <87v8jvnqq4.ffs@tglx> <Y/TP6as7qqwfcI42@boqun-archlinux>
 <87h6vfnh0f.ffs@tglx> <7b93bf74-abdc-f8c1-9a12-7c7f080f9e19@asahilina.net>
 <87edqioo1e.ffs@tglx>
 <CANiq72n-++roTv3yDNOA=Mi_sscBZX3xPdZ6RZ0Oxx+T82pf5A@mail.gmail.com>
 <87o7pmmtre.ffs@tglx> <Y/WDz013yBIfQPDq@boqun-archlinux>
From:   Asahi Lina <lina@asahilina.net>
In-Reply-To: <Y/WDz013yBIfQPDq@boqun-archlinux>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/02/2023 11.54, Boqun Feng wrote:
> On Wed, Feb 22, 2023 at 01:24:53AM +0100, Thomas Gleixner wrote:
>> Miguel!
>>
>> On Tue, Feb 21 2023 at 23:29, Miguel Ojeda wrote:
>>> On Tue, Feb 21, 2023 at 7:45 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>>>>
>>>> But xb abd xr are the same datatype because they represent a time delta.
>>>
>>> In principle, one could also have different duration types too. For
>>> instance, C++'s `std::chrono::duration` type is parametrized on the
>>> representation type and the tick period, and thus an operation between
>>> two time points like t1 - t0 returns a duration type that depends on
>>> the type of the time points, i.e. which clock they were obtained from.
>>
>> Correct, but for practical purposes I'd assume that the timestamps
>> retrieved via ktime_get*() have the same granularity, i.e. 1ns.
>>
>> TBH, that's not entirely correct because:
>>
>>     - the underlying hardware clocksource might not have a 1ns
>>       resolution
>>
>>     - the CLOCK_*_COARSE implementations are only advanced once per
>>       tick, but are executing significantly faster because they avoid
>>       the hardware counter access.
>>
>> But that's an assumption which has proven to be workable and correct
>> with the full zoo of hardware supported by the kernel.
>>
>> The point is that all CLOCK_* variants, except CLOCK_REALTIME and
>> CLOCK_TAI are guaranteed to never go backwards.
>>
>> CLOCK_REALTIME and CLOCK_TAI are special as they can be set by user
>> space and CLOCK_REALTIME has the extra oddities of leap seconds.  But
>> that's a well understood issue and is not specific to the kernel.
>>
>> Back to time deltas (or duration types). Independent of the above it
>> might make sense to be type strict about these as well. Especially if we
>> go one step further and have timers based on CLOCK_* which need to be
>> armed by either timestamps for absolute expiry or time deltas for
>> relative to now expiry. I definitely can see a point for requiring
>> matching time delta types there.
>>
>> That said, I have no strong opinions about this particular detail and
>> leave it to the Rusties to agree on something sensible.
>>
> 
> I'd like to propose something below to make thing forward quickly:
> 
> Given Lina only uses CLOCK_BOOTTIME and CLOCK_MONOTONIC, I'd say we
> reuse core::time::Duration and probably remain its ">=0" semantics even
> in the future we change its internal representation to u64.
> 
> For timestamp type, use Instant semantics and use different types for
> different clocks, i.e. similar to the implementation from Heghedus (much
> better than mine!). But we can avoid implementing a fully version of
> Instant, and focus on just the piece that Lina needs, which I believe
> it's elapsed()?
> 
> For the future, if we were to support non-monotonic timestamp, maybe we
> use the different type name like TimeStamp and TimeDelta.
> 
> In short:
> 
> *	For monotonic clocks, Instant + Duration, and keep them similar
> 	to std semantics.
> 
> *	For non-monotonic clocks, don't worry it right now, and
> 	probably different types for both stamps and deltas.
> 
> Thoughts?

I actually only used CLOCK_MONOTONIC in the end, so I could even leave
CLOCK_BOOTTIME for later, though I like the idea of having scaffolding
for several clock types even if we only implement one initially.

This works for me, if you're happy with the idea I'll give it a spin
based on Heghedus' example. Heghedus, is it okay if I put you down as
Co-developed-by and can I get a signoff? ^^

For the actual Instant type, I was thinking it makes sense to just
internally represent it as a newtype of Duration as well. Then all the
math becomes trivial based on Duration operations, and when we replace
Duration with a new u64 type it'll all work out the same. Fundamentally
that means Instant types are internally stored as the Duration between
the epoch (e.g. system boot) subject to the way that clock ticks, which
I think is a reasonable internal representation? (In other words, it's
the same as my original patch behind the scenes, but wrapped in type
safety).

~~ Lina
