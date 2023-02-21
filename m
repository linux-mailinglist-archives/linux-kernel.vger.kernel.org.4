Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 908B569E7F6
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 20:01:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbjBUTA5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 14:00:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbjBUTAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 14:00:55 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F5062D15D;
        Tue, 21 Feb 2023 11:00:54 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1677006052;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bQh4MrQJq8GfVQ2HTa2wSc/rS3yLHD1uj/LONuY9eC4=;
        b=av4f2bcV0vhrczhnaR2Bt/CRJNv+CzGZNoYFglqi1IonfiQH+SDrb0PwS786Q9mwVzNImN
        YRxysPzjvAXD5xOsJ22WaBLj5Aq3CcsL19AIpPVdKNCuzEZv8Syd5yLX0Bm8LD1rqXe/Wv
        Q2UUjGIAlKKqCGq7vkijnn5qmkoLlfBkwES+uBpXhLOCx4UZMFHvZkY9/SVlfzkcLAsGqo
        x34vWUiHF5NrJ1gWyLeT8NESdrNi6ntvrlrhHphYD+tTAvwyiG1W0CGhPUISjIYQWviqFM
        /LWzoKfUJ7mv31LblSUPLMMEfH3Im3RXsL3kULAG3Nfd5qpvFvzU6OYKiDMlpg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1677006052;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bQh4MrQJq8GfVQ2HTa2wSc/rS3yLHD1uj/LONuY9eC4=;
        b=mk/DYm3L90Hrtvc/ayXrNDfVCgdByDh6b6XrOc9iD43V6AHzZcIWtopYH8D/87KieZFvbf
        cA53nmACYvr18QAQ==
To:     Asahi Lina <lina@asahilina.net>, Boqun Feng <boqun.feng@gmail.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        John Stultz <jstultz@google.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        rust-for-linux@vger.kernel.org, asahi@lists.linux.dev
Subject: Re: [PATCH] rust: time: New module for timekeeping functions
In-Reply-To: <6aa15295-219b-225c-607d-e87e3d51d048@asahilina.net>
References: <20230221-gpu-up-time-v1-1-bf8fe74b7f55@asahilina.net>
 <87v8jvnqq4.ffs@tglx> <Y/TP6as7qqwfcI42@boqun-archlinux>
 <6aa15295-219b-225c-607d-e87e3d51d048@asahilina.net>
Date:   Tue, 21 Feb 2023 20:00:52 +0100
Message-ID: <87bklmonbv.ffs@tglx>
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

Lina!

On Wed, Feb 22 2023 at 01:27, Asahi Lina wrote:
> On 21/02/2023 23.06, Boqun Feng wrote:
>> On Tue, Feb 21, 2023 at 01:32:51PM +0100, Thomas Gleixner wrote:
>>> On Tue, Feb 21 2023 at 16:06, Asahi Lina wrote:
>>>> +    Duration::from_nanos(unsafe { bindings::ktime_get() }.try_into().unwrap())
>>>
>>> Why is this a Duration? From the spec:
>>>
>> I agree that returning a Duration may not be ideal, but..
>
>>> In my understanding 'Duration' is a time span between two points, while
>>> ktime_get() and ktime_get_boottime() return the current time of
>>> monotonically nondecreasing clocks, i.e. they fall into the 'Instant'
>>> category.
>
> The return values are analogous to `Instant` (which is not available in
> the kernel, so we can't use it anyway), but they can't be the same type
> in that case. `Instant` in std refers to a specific clock and its
> invariants only hold if all instances of the type refer to the same
> clock. So if we want to do something analogous here, we need separate
> types for each clock as Boqun mentioned...

Sure. I'm understanding that part and fully agree.

>>> Now the problem is that 'Instant' in it's specification is bound to
>>> CLOCK_MONOTONIC and there is no way to express CLOCK_BOOTTIME, but
>>> that's a shortcoming of the spec which ignores CLOCK_BOOTTIME
>>> completely. IOW, that's also a problem for user space.
>
> It's sort of inherent in the idea that all `Instant` instances must
> share the same clock, so there can only be one canonical clock on any
> given platform that is represented by `Instant`.
>
> Of course std could have separate types to support more than one clock,
> but then you'd end up with platform-specific variants... and I don't
> think the goal was to support all possible platform-specific clocks in
> that std API.

I can understand the idea, but I'm pretty sure that this will run into
issues sooner than later if someone tries to rewrite Linux userspace low
level system components in Rust.

> That's also why I went with Duration, since that doesn't try to claim
> those invariants and represents "a time duration since boot" in this
> case (measured according to different rules depending on what API you
> call). Basically it punts the problem of not mixing clocks to the API
> user...  which is not ideal, but it's exactly what the C API does.
> ktime_t naturally maps well to Duration since it does not encode any
> clock/epoch information in the type.

Sure, but ktime_t is also prone to issues which allow things you want to
prevent, i.e. substracting different clocks to calculate a duration.

>> 	pub struct BootTime {
>> 	    d: Duration
>> 	}
>> 
>> 	impl BootTime {
>> 	    fn now() -> Self {
>> 	        unsafe { BootTime { d: ktime_to_duration(ktime_get_boottime())} }
>> 	    }
>> 	    fn add(self, d: Duration) -> Self {
>> 	        <Add a duration, similar to ktime_add>
>> 	    }
>> 	    fn sub(self, other: Self) -> Duration {
>> 	        ...
>> 	    }
>> 	...
>> 	}
>> 
>> Thoughts?
>
> I think that's the better approach, but I was hoping to leave that for a
> future patch, especially since right now I'm the only user of this API
> in the upcoming Apple GPU driver and it only uses it to implement some
> really simple timeouts for polled operations, which isn't much API
> coverage...

That's a patently bad approach, really. You are doing exactly what Rust
is trying to avoid and writing ad hoc APIs is generally frowned upon
even on the C side of the kernel. The requirements for kernel time(r)
interfaces are pretty well known.

> I figured we might get a better idea for what to do once a
> second user comes along. For example, do we want straight methods like
> that or std::ops trait impls? And do we make everything fallible or
> panic on overflow or just wrap?
>
> It also means we basically have to reimplement all of
> core::time::Duration if we want to offer an equally ergonomic API with a
> 64-bit type (for reference, Duration is a struct with u64 secs and u32
> nanoseconds).

As you said yourself: The kernel can't use Rust std lib. So you better
implement sensible interfaces which are straight forward and simple to
use in the context you are aiming for.

>>>> +}
>>>> +
>>>> +/// Returns the kernel time elapsed since boot, including time spent sleeping, as a [`Duration`].
>>>> +pub fn ktime_get_boottime() -> Duration {
>>>> +    Duration::from_nanos(
>>>> +        // SAFETY: Function has no side effects and no variable inputs.
>>>> +        unsafe { bindings::ktime_get_with_offset(bindings::tk_offsets_TK_OFFS_BOOT) }
>>>
>>> No. Please use ktime_get_boottime() and not the timekeeping internal function.
>
> `ktime_get_boottime()` is static inline, so it will need a manual helper
> wrapper to be callable from Rust (at least until bindgen implements
> automatic helper generation, which I hear is coming soon). I was trying
> to avoid introducing even more helpers, since helpers.c is kind of
> already getting out of hand in my branch with all the stuff that's
> getting added... but I can add it if you don't want me to use
> ktime_get_with_offset(). It'll also be slower this way though (since the
> helper introduces another layer of function calling), and I figured of
> all things we probably want time functions to be fast, since they tend
> to get called a lot...

I can understand that, but please add proper comments and an explanation
to the changelog then. That would have avoided tripping my taste sensor.

Be aware that my Rust foo is not even rusty it's close to non-existant.
That's probaly true for many maintainers you need to interact with.

Thanks,

        tglx
