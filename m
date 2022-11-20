Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C6A263120E
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Nov 2022 01:54:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbiKTAyJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Nov 2022 19:54:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiKTAyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Nov 2022 19:54:06 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 794D0B10ED;
        Sat, 19 Nov 2022 16:54:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2572CB80A3A;
        Sun, 20 Nov 2022 00:54:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CAD1C433D6;
        Sun, 20 Nov 2022 00:53:58 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="pvoHQHqV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1668905636;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FULu1Q/R0+VeycCL68dPfbDP/Ga3miiXDWri1BQ6mXA=;
        b=pvoHQHqV36ye0LiiuIq8hjj8mpZn7fHMacpZSb+LT50mP6qaDpeVxij5gR2hs0Kh7RNFHJ
        WDc5GchA3f9donHrYRZLx6RkUOs+KIVLb9lv2g/pZIuRCu2RQ09Zn1EdZEcPglV8JbC0VT
        VL1C3Xpk868v/xDnvgAnebMb+pTMvuE=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id ac7f67a7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Sun, 20 Nov 2022 00:53:55 +0000 (UTC)
Date:   Sun, 20 Nov 2022 01:53:53 +0100
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        linux-crypto@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
        Carlos O'Donell <carlos@redhat.com>
Subject: Re: [PATCH v5 2/3] random: introduce generic vDSO getrandom()
 implementation
Message-ID: <Y3l6ocn1dTN0+1GK@zx2c4.com>
References: <20221119120929.2963813-1-Jason@zx2c4.com>
 <20221119120929.2963813-3-Jason@zx2c4.com>
 <Y3liVEdYByF2gZZU@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y3liVEdYByF2gZZU@sol.localdomain>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

On Sat, Nov 19, 2022 at 03:10:12PM -0800, Eric Biggers wrote:
> > +	if (IS_ENABLED(CONFIG_HAVE_VDSO_GETRANDOM))
> > +		smp_store_release(&_vdso_rng_data.generation, next_gen + 1);
> 
> Is the purpose of the smp_store_release() here to order the writes of
> base_crng.generation and _vdso_rng_data.generation?  It could use a comment.
> 
> > +		if (IS_ENABLED(CONFIG_HAVE_VDSO_GETRANDOM))
> > +			smp_store_release(&_vdso_rng_data.is_ready, true);
> 
> Similarly, is the purpose of this smp_store_release() to order the writes to the
> the generation counters and is_ready?  It could use a comment.

Yes, I guess so. Actually this comes from an unexplored IRC comment from
Andy back in July:

2022-07-29 21:21:56 <amluto> zx2c4: WRITE_ONCE(_vdso_rng_data.generation, next_gen + 1);
2022-07-29 21:22:23 <amluto> For x86 it shouldn’t matter much. For portability, smp_store_release

Though maybe that doesn't actually matter much? When the userspace CPU
learns about a change to vdso_rng_data, it's only course of action is
make a syscall to getrandom(), anyway, and those paths should be
consistent with themselves, thanks to the same locking and
synchronization there's always been there. So maybe I actually should
move back to WRITE_ONCE() here? Hm?

> > +static void memcpy_and_zero(void *dst, void *src, size_t len)
> > +{
> > +#define CASCADE(type) \
> > +	while (len >= sizeof(type)) { \
> > +		*(type *)dst = *(type *)src; \
> > +		*(type *)src = 0; \
> > +		dst += sizeof(type); \
> > +		src += sizeof(type); \
> > +		len -= sizeof(type); \
> > +	}
> > +#ifdef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
> > +#if BITS_PER_LONG == 64
> > +	CASCADE(u64);
> > +#endif
> > +	CASCADE(u32);
> > +	CASCADE(u16);
> > +#endif
> > +	CASCADE(u8);
> > +#undef CASCADE
> > +}
> 
> CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS doesn't mean that dereferencing
> misaligned pointers is okay.  You still need to use get_unaligned() and
> put_unaligned().  Take a look at crypto_xor(), for example.

Right, thanks. Will do.

> There's a lot of subtle stuff going on here.  Adding some more comments would be
> helpful.  Maybe bring in some of the explanation that's currently only in the
> commit message.

Good idea.

> One question I have is about forking.  So, when a thread calls fork(), in the
> child the kernel automatically replaces all vgetrandom_state pages with zeroed
> pages (due to MADV_WIPEONFORK).  If the child calls __cvdso_getrandom_data()
> afterwards, it sees the zeroed state.  But that's indistinguishable from the
> state at the very beginning, after sys_vgetrandom_alloc() was just called,
> right?  So as long as this code handles initializing the state at the beginning,
> then I'd think it would naturally handle fork() as well.

Right, for this simple fork() case, it works fine. There are other cases
though that are trickier...

> However, it seems you have something a bit more subtle in mind, where the thread
> calls fork() *while* it's in the middle of __cvdso_getrandom_data().  I guess
> you are thinking of the case where a signal is sent to the thread while it's
> executing __cvdso_getrandom_data(), and then the signal handler calls fork()?
> Note that it doesn't matter if a different thread in the *process* calls fork().
> 
> If it's possible for the thread to fork() (and hence for the vgetrandom_state to
> be zeroed) at absolutely any time, it probably would be a good idea to mark that
> whole struct as volatile.

Actually, this isn't something that matters, I don't think. If
state->key_batch is zeroed, the result will be wrong, but the function
logic will be fine. If state->pos is zeroed, it'll write to the
beginning of the batch, which might be wrong, but the function logic
will still be fine. That is, in both of these cases, even if the
calculation is wrong, there's no memory corruption or anything. So then,
the remaining member is state->generation. If this is zeroed, then it's
actually something we detect with that READ_ONCE()! And in this case,
it's a sign that something is off -- we forked -- and so we should start
over from the beginning. So I don't think there's a reason to mark the
whole struct as volatile. The one we care about is state->generation,
and for that we READ_ONCE() it at the place that matters.

There's actually a different scenario, though, that I'm concerned about,
and this is the case in which a multithreaded program forks in the
middle of one of its threads running this. Indeed, only the calling
thread will carry forward into the child process, but all the memory is
still left around from any concurrent threads in the middle of
vgetrandom(). And if they're in the middle of a vgetrandom() call, that
means they haven't yet done erasure and cleaned up the stack to prevent
their state from leaking, and so forward secrecy is potentially lost,
since the child process now has some state from the parent.

I'm not quite sure what the best approach here is. One idea would be to
just note that libcs should wait until vgetrandom() has returned
everywhere before forking, using its atfork functionality. Another
approach would be to say that multithreaded programs using this
shouldn't fork or something, but that seems disappointing. Or more state
could be allocated in the zeroing region, to hold a chacha state, so
another 64 bytes, which would be sort of unfortunate. Or something else?
I'd be interested to hear your impression of this quandary.

Jason
