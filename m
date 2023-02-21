Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A1E469E422
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 17:02:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234526AbjBUQCr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 11:02:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233085AbjBUQCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 11:02:43 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CFB323656;
        Tue, 21 Feb 2023 08:02:42 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1676995361;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mTy3mHOSw0bgUzp6ZeDA/Qw3wRl91nnGoDhM5mRLjqs=;
        b=YReyvwSHzy6DnYqrf4RxaRGUyHlCDcEXykgA9chLQ0IA5ZY1ljiq0rpWgwjbsR4Oj1plO/
        1FlNSGRae6OXLwdsr4UmxOXbs3xlVcELvpoxGiQ7CfkLY6ouV3PYN0qbWDXd8DMvKWyFVO
        gqwfxWc1Rlmrb8AM4V5GXrmZBwv8faWNZmTrlFqhWnsBC5+EBvBExV4SzFUyq3ZCeKL8rA
        z2T/v4oL8Z3e/zKZzOlN34uwYBhsXXtlBTlDlqoftzQsg+mBU5jXxPtIVDqLaA/lGrAbJl
        r+qLL5d45oeKXnrBo35OyvMH675AisT+BQMoT3aRbFAPn83EUQEjaKjZR7L6MQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1676995361;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mTy3mHOSw0bgUzp6ZeDA/Qw3wRl91nnGoDhM5mRLjqs=;
        b=d55FjnATdzhIZkEyw3Hi/IevMHOl0SibWAlgYC0WkS7z5DCuvNaLjSWUIFv9RyBcGJj3nK
        Z9zrbagXToTflOCw==
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     Asahi Lina <lina@asahilina.net>, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        John Stultz <jstultz@google.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        rust-for-linux@vger.kernel.org, asahi@lists.linux.dev
Subject: Re: [PATCH] rust: time: New module for timekeeping functions
In-Reply-To: <Y/TP6as7qqwfcI42@boqun-archlinux>
References: <20230221-gpu-up-time-v1-1-bf8fe74b7f55@asahilina.net>
 <87v8jvnqq4.ffs@tglx> <Y/TP6as7qqwfcI42@boqun-archlinux>
Date:   Tue, 21 Feb 2023 17:02:40 +0100
Message-ID: <87h6vfnh0f.ffs@tglx>
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

On Tue, Feb 21 2023 at 06:06, Boqun Feng wrote:
> On Tue, Feb 21, 2023 at 01:32:51PM +0100, Thomas Gleixner wrote:
>> Similar to 'Instant' 'SystemTime' is strictly bound to CLOCK_REALTIME
>> by specification and there is no way to read CLOCK_TAI.
>> 
> ..'Instant' and 'SystemTime' are in Rust std, we cannot use them
> directly, similar as we cannot use userspace libc.

Sure. Was Rust std defined based on SysV from 30 years ago? :)

> To me, there seems two options to provide Rust types for kernel time
> management:
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

I'm not rusty enough, but you really want two types:

    timestamp and timedelta

timestamp is an absolute time on a specific clock which is read via
now() and you can add time deltas to it. The latter is required for
arming an absolute timer on the clock.

timedelta is a relative time and completely independent of any
clock. That's what you get when you subtract two timestamps, but you can
also initialize it from a constant or some other source. timedelta can
be used to arm a relative timer on any clock.

Playing games with a single type is neither safe nor intuitive, right?

Thanks,

        tglx
