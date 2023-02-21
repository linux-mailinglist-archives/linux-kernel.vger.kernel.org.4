Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0001269E4A2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 17:28:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234527AbjBUQ2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 11:28:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233285AbjBUQ2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 11:28:16 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B21DD2D14E;
        Tue, 21 Feb 2023 08:27:31 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: lina@asahilina.net)
        by mail.marcansoft.com (Postfix) with ESMTPSA id A3FD13FA55;
        Tue, 21 Feb 2023 16:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=asahilina.net;
        s=default; t=1676996847;
        bh=1Qmc+N085tR+w7y6RozOctPj3HPL1Q8tU2am4x/B8n0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=TwXd7BZkxOFVCVkp6+1oDEHP/hT3TJVJYd5MQdbcXKadi1zNVDYEUu2iraf+l1QMB
         C6LCeCHrdCCLoe8B5sK3VEGvRU8ODKjgiV8N6Au6w/vRQHUJCvy4xqng84q4rSbq/p
         lWExjsNChrZjSYZzsZ0vRj5HSdS2qKtXQ56Bv9gchZLc57JtbQCucLlRAvYQ4gm1CQ
         A7OcZOELDb4K1QsOa5+mShj5CvrKcU9caSDSSaLU0A9DDiuOdEWS6Tw0/el98MZEVR
         DxeKYmzSl7QQWW54J+CX7DfEOAB4jeDA7bzS1gK++r6DcI6PAeMxkZeKTLW1FsFQJI
         x1QzCnCov7b7g==
Message-ID: <6aa15295-219b-225c-607d-e87e3d51d048@asahilina.net>
Date:   Wed, 22 Feb 2023 01:27:22 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] rust: time: New module for timekeeping functions
Content-Language: en-US
To:     Boqun Feng <boqun.feng@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        John Stultz <jstultz@google.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        rust-for-linux@vger.kernel.org, asahi@lists.linux.dev
References: <20230221-gpu-up-time-v1-1-bf8fe74b7f55@asahilina.net>
 <87v8jvnqq4.ffs@tglx> <Y/TP6as7qqwfcI42@boqun-archlinux>
From:   Asahi Lina <lina@asahilina.net>
In-Reply-To: <Y/TP6as7qqwfcI42@boqun-archlinux>
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

On 21/02/2023 23.06, Boqun Feng wrote:
> On Tue, Feb 21, 2023 at 01:32:51PM +0100, Thomas Gleixner wrote:
>> On Tue, Feb 21 2023 at 16:06, Asahi Lina wrote:
>>> +
>>> +use crate::bindings;
>>> +use core::time::Duration;
>>> +
>>> +/// Returns the kernel time elapsed since boot, excluding time spent sleeping, as a [`Duration`].
>>> +pub fn ktime_get() -> Duration {
>>> +    // SAFETY: Function has no side effects and no inputs.
>>> +    Duration::from_nanos(unsafe { bindings::ktime_get() }.try_into().unwrap())
>>
>> Why is this a Duration? From the spec:
>>
> 
> I agree that returning a Duration may not be ideal, but..

>> In my understanding 'Duration' is a time span between two points, while
>> ktime_get() and ktime_get_boottime() return the current time of
>> monotonically nondecreasing clocks, i.e. they fall into the 'Instant'
>> category.

The return values are analogous to `Instant` (which is not available in
the kernel, so we can't use it anyway), but they can't be the same type
in that case. `Instant` in std refers to a specific clock and its
invariants only hold if all instances of the type refer to the same
clock. So if we want to do something analogous here, we need separate
types for each clock as Boqun mentioned...

>> Now the problem is that 'Instant' in it's specification is bound to
>> CLOCK_MONOTONIC and there is no way to express CLOCK_BOOTTIME, but
>> that's a shortcoming of the spec which ignores CLOCK_BOOTTIME
>> completely. IOW, that's also a problem for user space.

It's sort of inherent in the idea that all `Instant` instances must
share the same clock, so there can only be one canonical clock on any
given platform that is represented by `Instant`.

Of course std could have separate types to support more than one clock,
but then you'd end up with platform-specific variants... and I don't
think the goal was to support all possible platform-specific clocks in
that std API.

That's also why I went with Duration, since that doesn't try to claim
those invariants and represents "a time duration since boot" in this
case (measured according to different rules depending on what API you
call). Basically it punts the problem of not mixing clocks to the API
user...  which is not ideal, but it's exactly what the C API does.
ktime_t naturally maps well to Duration since it does not encode any
clock/epoch information in the type.

> To me, there seems
> two options to provide Rust types for kernel time management:
> 
> *	Use KTime which maps to ktime_t, then we have the similar
> 	semantics around it: sometimes it's a duration, sometimes it's
> 	a point of time.. but I know "this is a safe language, you
> 	should do more" ;-)
> 
> *	Introduce kernel's own types, e.g. BootTime, RawTime, TAI,
> 	RealTime, and make them play with Duration (actually I'd prefer
> 	we have own Duration, because Rust core::time::Duration takes
> 	more than u64), something like below:
> 
> 
> 	pub struct BootTime {
> 	    d: Duration
> 	}
> 
> 	impl BootTime {
> 	    fn now() -> Self {
> 	        unsafe { BootTime { d: ktime_to_duration(ktime_get_boottime())} }
> 	    }
> 	    fn add(self, d: Duration) -> Self {
> 	        <Add a duration, similar to ktime_add>
> 	    }
> 	    fn sub(self, other: Self) -> Duration {
> 	        ...
> 	    }
> 	...
> 	}
> 
> Thoughts?

I think that's the better approach, but I was hoping to leave that for a
future patch, especially since right now I'm the only user of this API
in the upcoming Apple GPU driver and it only uses it to implement some
really simple timeouts for polled operations, which isn't much API
coverage... I figured we might get a better idea for what to do once a
second user comes along. For example, do we want straight methods like
that or std::ops trait impls? And do we make everything fallible or
panic on overflow or just wrap?

It also means we basically have to reimplement all of
core::time::Duration if we want to offer an equally ergonomic API with a
64-bit type (for reference, Duration is a struct with u64 secs and u32
nanoseconds).

>>> +}
>>> +
>>> +/// Returns the kernel time elapsed since boot, including time spent sleeping, as a [`Duration`].
>>> +pub fn ktime_get_boottime() -> Duration {
>>> +    Duration::from_nanos(
>>> +        // SAFETY: Function has no side effects and no variable inputs.
>>> +        unsafe { bindings::ktime_get_with_offset(bindings::tk_offsets_TK_OFFS_BOOT) }
>>
>> No. Please use ktime_get_boottime() and not the timekeeping internal function.

`ktime_get_boottime()` is static inline, so it will need a manual helper
wrapper to be callable from Rust (at least until bindgen implements
automatic helper generation, which I hear is coming soon). I was trying
to avoid introducing even more helpers, since helpers.c is kind of
already getting out of hand in my branch with all the stuff that's
getting added... but I can add it if you don't want me to use
ktime_get_with_offset(). It'll also be slower this way though (since the
helper introduces another layer of function calling), and I figured of
all things we probably want time functions to be fast, since they tend
to get called a lot...

~~ Lina
