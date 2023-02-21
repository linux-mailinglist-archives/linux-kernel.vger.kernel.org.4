Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F20A69E4B1
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 17:31:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234470AbjBUQbt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 11:31:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234165AbjBUQbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 11:31:43 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 964A62D56;
        Tue, 21 Feb 2023 08:31:34 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: lina@asahilina.net)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 092973FA55;
        Tue, 21 Feb 2023 16:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=asahilina.net;
        s=default; t=1676997093;
        bh=jy36nlq0P5xs/QWgM6Zr80oO0jn/1vgYkz1bjKsF2gI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=F4qDXdqKF6MZKkXDlcljLC80li+ZPN1ugbdvCvR9PgxTp1Y/4GpXP/kUMmnR/agKB
         ZX+FgF7Ab3G5sx//saRUW3rfz7gStFjI544Wzk1+fLkYN9IoRnPfjfpIOdbLLlcbui
         535lHeME192rwIDJ2kkpZAecsJn8pQvofTevWVEthoUakqWiqRlQqckSpY5OHWwX2p
         ydD2RB3GHkf2xKvgERWFKovlYqqVYngN7d+dlZ1u+Zz1sOhB/i0f59S5/9SFXX0A0l
         JeKyijG13bYiXTFFj2o4+RKs98rV+602tr1NqqpyBSUTn3+sIsCbJARNBGIwRs2tyO
         m+i+sVGqI1xIQ==
Message-ID: <7b93bf74-abdc-f8c1-9a12-7c7f080f9e19@asahilina.net>
Date:   Wed, 22 Feb 2023 01:31:28 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] rust: time: New module for timekeeping functions
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>,
        Boqun Feng <boqun.feng@gmail.com>
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
 <87h6vfnh0f.ffs@tglx>
From:   Asahi Lina <lina@asahilina.net>
In-Reply-To: <87h6vfnh0f.ffs@tglx>
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

On 22/02/2023 01.02, Thomas Gleixner wrote:
> On Tue, Feb 21 2023 at 06:06, Boqun Feng wrote:
>> To me, there seems two options to provide Rust types for kernel time
>> management:
>>
>> *	Use KTime which maps to ktime_t, then we have the similar
>> 	semantics around it: sometimes it's a duration, sometimes it's
>> 	a point of time.. but I know "this is a safe language, you
>> 	should do more" ;-)
>>
>> *	Introduce kernel's own types, e.g. BootTime, RawTime, TAI,
>> 	RealTime, and make them play with Duration (actually I'd prefer
>> 	we have own Duration, because Rust core::time::Duration takes
>> 	more than u64), something like below:
>>
>>
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
> 
> I'm not rusty enough, but you really want two types:
> 
>     timestamp and timedelta
> 
> timestamp is an absolute time on a specific clock which is read via
> now() and you can add time deltas to it. The latter is required for
> arming an absolute timer on the clock.
> 
> timedelta is a relative time and completely independent of any
> clock. That's what you get when you subtract two timestamps, but you can
> also initialize it from a constant or some other source. timedelta can
> be used to arm a relative timer on any clock.

If all clocks end up as the same `timestamp` though, then this isn't
fully safe, because you could subtract `timestamp`s that came from
different clocks and the result would be meaningless. That's why the
Rust std Instant is specifically tied to one and only one system clock
on each platform.

~~ Lina
