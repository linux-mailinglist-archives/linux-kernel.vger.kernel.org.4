Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF31969F03F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 09:33:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbjBVIdN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 03:33:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbjBVIdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 03:33:10 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A62CF1D907;
        Wed, 22 Feb 2023 00:33:07 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1677054784;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4Vi0hyCmETvO266sIihn2iEfnC+waPbsYfKs7U90/uU=;
        b=KsZfcpE+jZ3CcraoQykrDMrguuCa8oeL7pD5UMapAwCF7/BeF5ce+IeBujSKrb/bObtJEe
        mfoDdLu0uw3i0a1ciULvrwi4RGwUiOsi6VTVFVKbsnBjQkc20fjBSecSjrMz/lzhlIV9Bt
        UuUxFIOtLOXvYglH8AyYm68IjR0apmBphaHw9QeQsAIgozLdB2ri+iPyHmt8PNqwvwuCwf
        qRP73sq2zd9myBrggnpa4P7r2UwzEauTCnWMc3Guhk0CvAXhOXpgM+FVG2TLQQcxWwzRs5
        el/4yozlEK+cnDPJGFi0jOcenm5qYs4vSFT038UehohkM2zMtoNtu+lLnhup3w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1677054784;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4Vi0hyCmETvO266sIihn2iEfnC+waPbsYfKs7U90/uU=;
        b=TfTnEicpwBjyS9gA7fZpVKA6kDubSILcMFW0M8PSVFHuul62H5KG/fVGqGX/zHZ2JSdeuU
        ZT0Q5G4hzFwzDfAg==
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
In-Reply-To: <98de1e48-085b-6edb-f1cc-2bf85180196f@asahilina.net>
References: <20230221-gpu-up-time-v1-1-bf8fe74b7f55@asahilina.net>
 <87v8jvnqq4.ffs@tglx> <Y/TP6as7qqwfcI42@boqun-archlinux>
 <6aa15295-219b-225c-607d-e87e3d51d048@asahilina.net> <87bklmonbv.ffs@tglx>
 <98de1e48-085b-6edb-f1cc-2bf85180196f@asahilina.net>
Date:   Wed, 22 Feb 2023 09:33:03 +0100
Message-ID: <87lekqm75s.ffs@tglx>
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

Lina !

On Wed, Feb 22 2023 at 13:56, Asahi Lina wrote:
> On 22/02/2023 04.00, Thomas Gleixner wrote:
>> Be aware that my Rust foo is not even rusty it's close to non-existant.
>> That's probaly true for many maintainers you need to interact with.
>
> Please do feel free to reach out and ask any questions about all this
> crazy Rust stuff stuff! We're here to help and I know this is all new to
> a lot of maintainers. I want people to be comfortable that we aren't
> just creating more maintenance burden for everyone else.

I can only speak for myself. I'm comfortable and sufficiently curious
about this particular flavour of crazy.

I don't think these abstractions are a huge burden as long as the folks
who implement them talk to the relevant maintainers so we don't end
up with Rust inflicted burdens or ill defined abstractions.

> That's also another conversation that we probably need to have, how do
> we handle maintainership of Rust abstractions? I think Miguel mentioned
> that ideally existing subsystem maintainers take over their bits of the
> Rust side too over time, but of course a lot of people aren't going to
> be comfortable with that if they don't have a lot of Rust experience
> yet... personally I'm happy to sign up as co-maintainer or supporter of
> the abstractions I contribute, or maybe we can just pool resources and
> have people interested in Rust agree to help support this stuff for
> every subsystem?

Having subsystem maintainer teams supplemented with a Rust wizard, is
probably the best option at the moment. Time will tell as always.

Thanks,

        tglx


