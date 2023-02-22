Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0DAC69EE11
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 05:56:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbjBVE4e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 23:56:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbjBVE41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 23:56:27 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AE7E3527A;
        Tue, 21 Feb 2023 20:56:25 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: lina@asahilina.net)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 2F44442468;
        Wed, 22 Feb 2023 04:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=asahilina.net;
        s=default; t=1677041784;
        bh=/iiU3vAWbjH5xw1OvZM1qRoWYsNgQONMqzT7xx1tB2o=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=v0gmhEzGcu4zLdnDBT0N29zW/CZAgJMs1PXz1jNwqoQrCO/pOSC4FzbaJkMEK22QZ
         IfjKy6GT2wwOvrG3mkepuosX4lOcHCM4Z/jWQKJwol91vkK1ztqALoKKNGNyktOqeE
         PPFnwkHcqyWMVKMM65j/JS8G97DXdYwJiWeDKoJnP0sERu43TAefxJ0zxzRoYi1IgD
         Zgzvog/7tng9ca0XgGjgdxI5Mb3PfELqwrpvAT2IZVMVPj+GWFI7cCqdj6Kl2GDZvi
         01dhXITb43QlrhYAqs/F0qBfQrC+GVtK9b3JSVmE2rIs8u8TTzmdx9I1fmrMbfRhX1
         E5s4K2RKuj+tA==
Message-ID: <98de1e48-085b-6edb-f1cc-2bf85180196f@asahilina.net>
Date:   Wed, 22 Feb 2023 13:56:19 +0900
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
 <6aa15295-219b-225c-607d-e87e3d51d048@asahilina.net> <87bklmonbv.ffs@tglx>
From:   Asahi Lina <lina@asahilina.net>
In-Reply-To: <87bklmonbv.ffs@tglx>
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

On 22/02/2023 04.00, Thomas Gleixner wrote:
>>>>> +}
>>>>> +
>>>>> +/// Returns the kernel time elapsed since boot, including time spent sleeping, as a [`Duration`].
>>>>> +pub fn ktime_get_boottime() -> Duration {
>>>>> +    Duration::from_nanos(
>>>>> +        // SAFETY: Function has no side effects and no variable inputs.
>>>>> +        unsafe { bindings::ktime_get_with_offset(bindings::tk_offsets_TK_OFFS_BOOT) }
>>>>
>>>> No. Please use ktime_get_boottime() and not the timekeeping internal function.
>>
>> `ktime_get_boottime()` is static inline, so it will need a manual helper
>> wrapper to be callable from Rust (at least until bindgen implements
>> automatic helper generation, which I hear is coming soon). I was trying
>> to avoid introducing even more helpers, since helpers.c is kind of
>> already getting out of hand in my branch with all the stuff that's
>> getting added... but I can add it if you don't want me to use
>> ktime_get_with_offset(). It'll also be slower this way though (since the
>> helper introduces another layer of function calling), and I figured of
>> all things we probably want time functions to be fast, since they tend
>> to get called a lot...
> 
> I can understand that, but please add proper comments and an explanation
> to the changelog then. That would have avoided tripping my taste sensor.
> 
> Be aware that my Rust foo is not even rusty it's close to non-existant.
> That's probaly true for many maintainers you need to interact with.

I'll add a comment ^^

Please do feel free to reach out and ask any questions about all this
crazy Rust stuff stuff! We're here to help and I know this is all new to
a lot of maintainers. I want people to be comfortable that we aren't
just creating more maintenance burden for everyone else.

That's also another conversation that we probably need to have, how do
we handle maintainership of Rust abstractions? I think Miguel mentioned
that ideally existing subsystem maintainers take over their bits of the
Rust side too over time, but of course a lot of people aren't going to
be comfortable with that if they don't have a lot of Rust experience
yet... personally I'm happy to sign up as co-maintainer or supporter of
the abstractions I contribute, or maybe we can just pool resources and
have people interested in Rust agree to help support this stuff for
every subsystem?

~~ Lina
