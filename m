Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA76F639D6B
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Nov 2022 22:53:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbiK0VxE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 16:53:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbiK0VxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 16:53:03 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBB8563D3;
        Sun, 27 Nov 2022 13:53:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5B111B80B77;
        Sun, 27 Nov 2022 21:53:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93AB1C433C1;
        Sun, 27 Nov 2022 21:52:57 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Mua/GiX8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1669585975;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GipSCw0c5SilGhSAEbKV6kdq9Cs5CMW1q5zEQv1Mc1g=;
        b=Mua/GiX8b50SJzJq0j1kT6vnmM1fGOVsYSflL8gcy7amvnp2ESprc0dCZ2gBeNvORuXlPq
        tBnk4N5+ZMTgQp901w6orMWd7CfE4lcd/BM6Bui99JbvrKVpvZFgRvPMw8Iw64T/jkUO7I
        WzDOO47FLb5LiilnnRTkIQUQXlXJ2jw=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 6b150d2b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Sun, 27 Nov 2022 21:52:54 +0000 (UTC)
Date:   Sun, 27 Nov 2022 22:52:46 +0100
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        linux-crypto@vger.kernel.org, linux-api@vger.kernel.org,
        x86@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
        Carlos O'Donell <carlos@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v7 2/3] random: introduce generic vDSO getrandom()
 implementation
Message-ID: <Y4PcLi8c010MEfTA@zx2c4.com>
References: <20221124165536.1631325-1-Jason@zx2c4.com>
 <20221124165536.1631325-3-Jason@zx2c4.com>
 <877cziy7zg.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <877cziy7zg.ffs@tglx>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Jason!
Thomas!

On Fri, Nov 25, 2022 at 11:39:15PM +0100, Thomas Gleixner wrote:
> > +struct vdso_rng_data {
> > +	unsigned long generation;
> > +	bool is_ready;
> > +};
> 
> Please follow the coding style in this header:
> 
>        - make the struct definition tabular aligned
>        - provide kernel doc which explains the struct members

Will do.

> > +
> > +#include <linux/kernel.h>
> > +#include <linux/atomic.h>
> > +#include <linux/fs.h>
> 
> No. This is VDSO and builds a userspace library. You cannot include
> random kernel headers, which in turn include the world and some more. It
> might build today, but any legitimate change to fs.h or one of the
> headers included by it will make it explode.
> 
> I just fixed up some other instance which included world and I have zero
> interest to get more of this "works by chance" things.
> 
> If you really need anything from fs.h then please isolate it out into a
> separate header file which is included by fs.h and here.

Hm. I need MAX_RW_COUNT from linux/fs.h. I could just hardcode `(INT_MAX
& PAGE_MASK)`, though, if you'd prefer, and leave a comment. I'll do
that. Or I could move MAX_RW_COUNT into linux/kernel.h? But maybe that's
undesirable.

So:

    ssize_t ret = min_t(size_t, INT_MAX & PAGE_MASK /* = MAX_RW_COUNT */, len);

I'll do that, if it's okay with you. Or tell me if you want me to
instead move MAX_RW_COUNT into linux/kernel.h.

Also, if I remove linux/fs.h, I need to include linux/time.h in its
place, because vdso/datapage.h implicitly depends on it. Alternatively,
I could add linux/time.h to vdso/datapage.h, but I don't want to touch
too many files uninvited.


> 	MEMCPY_AND_ZERO_SRC(u8, dst, src, len);
> }
> 
> Can you spot the difference in readability and formatting?

Nice suggestion, will do.

> > +
> > +static __always_inline ssize_t
> > +__cvdso_getrandom_data(const struct vdso_rng_data *rng_info, void *buffer, size_t len,
> > +		       unsigned int flags, void *opaque_state)
> 
> Lacks kernel-doc explaining the arguments and the functionality.

I'll add one.

> > +
> > +	if (unlikely(!len))
> > +		return 0;
> 
> Why go into the kernel above when len == 0?

If the kernel's RNG isn't ready, then the behavior here can't easily be
emulated by userspace alone. For the len == 0 case, if flags == 0, then
the syscall will block until it's ready, for example, and that blocking
behavior is something we want to retain.

However, I recognize that the fact you had to ask this question is
simply indicative of the fact that this function is under-documented or
otherwise incomprehensible, per your other comments, so I'll try to make
this more clear for v8.

> Sorry, this is word salad which raises a -ENOPARSE here.
> Sorry, I really fail to understand this sloppy wording coming from
> someone who educates everyone else about the importance of correctness.
> If you can't be bothered to express yourself in correct terms
> consistently then why do you expect that anyone else understands
> randomness or cryptography correctly?
> I really appreciate your efforts to make all of this more accessible to
> the average user, but please get your act together.

Your individual specific points as well as the overarching one are well
taken, and I'll overhaul all of the documentation for v8, in hopes of
making this function a lot more clear.

> > +	batch_len = min_t(size_t, sizeof(state->batch) - state->pos, len);
> 
> Where is the sanity check for state->pos <= sizeof(state->batch)?

That condition cannot happen. "Does the compiler or some other checker
prove that as part of the development cycle?" No, unfortunately. So what
would you like to do here? Per Linus' email on an unrelated topic [1],
"We don't test for things that can't happen." And there's no
WARN_ON/BUG_ON primitive that'd be wise to use here -- nobody wants to
emit a ud2 into vDSO code I assume. So what would you like? For me to
add that check and bail out of the function if it's wrong, even if that
should normally never happen? Or adhere to the [1] more strictly and do
nothing, as is the case now? I'll do what you want here.

And please don't tell me, "if you even have to ask what to do, you
shouldn't be anywhere near... bla bla bla", because I *am* cognisant of
defense coding, yet at the same time I'm trying to respect kernel norms,
and balancing the two tends to be more subjective than, say, the results
of a verifier. So, anyway, let me know what behavior you want here --
the sanity check-->fallback path, or doing nothing, or something else.

[1] https://lore.kernel.org/all/CAHk-=wheoU5mkht1xk_4Tyw78oa-8iGvGE9nBdUmGqCykgo1xw@mail.gmail.com/

> 
> > +	if (batch_len) {
> > +		/* Zero out bytes as they're copied out, to preserve forward secrecy. */
> 
> Please name the function so it is self explaining and add an
> comprehensive comment to it so you can spare the comment here.

I'll take your memcpy_and_zero_*src* suggestion from earlier.

> > +		memcpy_and_zero(buffer, state->batch + state->pos, batch_len);
> > +		state->pos += batch_len;
> > +		buffer += batch_len;
> > +		len -= batch_len;
> 
> buffer and state->pos could be updated by that non-fail copy function to
> aid the compiler, but I might be wrong about the ability of compilers to
> optimize code like that.

memcpy_and_zero(_src) is inlined, and the codegen looks okay enough I
think.

> > +	/* Refill the batch and then overwrite the key, in order to preserve forward secrecy. */
> > +	BUILD_BUG_ON(sizeof(state->batch_key) % CHACHA_BLOCK_SIZE != 0);
> 
> Does this build bug really need to be glued in between the comment
> explaining the function call and the function call itself?

I thought of these two lines as sort of one thing together. But I'll
reverse the order of the comment and the BUILD_BUG_ON, per your
suggestion.

Thanks again for the extremely thorough review.

Jason
