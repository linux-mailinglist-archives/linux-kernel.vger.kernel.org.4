Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30D1663122F
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Nov 2022 02:51:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbiKTBvJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Nov 2022 20:51:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiKTBvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Nov 2022 20:51:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C38CFB8FAD;
        Sat, 19 Nov 2022 17:51:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5C6F8B801BA;
        Sun, 20 Nov 2022 01:51:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87CA0C433D6;
        Sun, 20 Nov 2022 01:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668909063;
        bh=El15VWDdgksRCN/WPGVj5AEcvb7V7Y1dygEuy92nPcU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=buOop9cfhLH6l9zCdRG66qwWw2Kzuf9uGT+iez3n57OnbkfwLgV2jc/fH++Xuxqj9
         1BKpI8Y1N4nlLq2i3xVxW5vpZKJWdw9U5fZQoy6ZgNjlWdGcUUSmHN1j94Ftgo7V55
         DEXt+eIYjkIZcWUFgSmFLvIfDGfT4L7WWC+Y6fb0ceLEiFdewiwOmElzlLdlheDAsw
         OYmgnFTbOwsg7jFTuiTiXR8ADYgzcEOQYuWcHsp686leUKGMV1Jmyi3APulxhOZupc
         +Ox1AZMEjw6kuTBJM/YWAfcQiYCYb1Je/bH1n7fZAOdOxuOGmfiJdGZ3Aim3AAjPYB
         8eF8rXVlnMExg==
Date:   Sat, 19 Nov 2022 17:51:01 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        linux-crypto@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
        Carlos O'Donell <carlos@redhat.com>
Subject: Re: [PATCH v5 2/3] random: introduce generic vDSO getrandom()
 implementation
Message-ID: <Y3mIBTzgqTv/ArDG@sol.localdomain>
References: <20221119120929.2963813-1-Jason@zx2c4.com>
 <20221119120929.2963813-3-Jason@zx2c4.com>
 <Y3liVEdYByF2gZZU@sol.localdomain>
 <Y3l6ocn1dTN0+1GK@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y3l6ocn1dTN0+1GK@zx2c4.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 20, 2022 at 01:53:53AM +0100, Jason A. Donenfeld wrote:
> Hi Eric,
> 
> On Sat, Nov 19, 2022 at 03:10:12PM -0800, Eric Biggers wrote:
> > > +	if (IS_ENABLED(CONFIG_HAVE_VDSO_GETRANDOM))
> > > +		smp_store_release(&_vdso_rng_data.generation, next_gen + 1);
> > 
> > Is the purpose of the smp_store_release() here to order the writes of
> > base_crng.generation and _vdso_rng_data.generation?  It could use a comment.
> > 
> > > +		if (IS_ENABLED(CONFIG_HAVE_VDSO_GETRANDOM))
> > > +			smp_store_release(&_vdso_rng_data.is_ready, true);
> > 
> > Similarly, is the purpose of this smp_store_release() to order the writes to the
> > the generation counters and is_ready?  It could use a comment.
> 
> Yes, I guess so. Actually this comes from an unexplored IRC comment from
> Andy back in July:
> 
> 2022-07-29 21:21:56 <amluto> zx2c4: WRITE_ONCE(_vdso_rng_data.generation, next_gen + 1);
> 2022-07-29 21:22:23 <amluto> For x86 it shouldn’t matter much. For portability, smp_store_release
> 
> Though maybe that doesn't actually matter much? When the userspace CPU
> learns about a change to vdso_rng_data, it's only course of action is
> make a syscall to getrandom(), anyway, and those paths should be
> consistent with themselves, thanks to the same locking and
> synchronization there's always been there. So maybe I actually should
> move back to WRITE_ONCE() here? Hm?

Well, sys_getrandom() will just do:

	if (unlikely(crng->generation != READ_ONCE(base_crng.generation)))

So I think you do need ordering between base_crng.generation and
_vdso_rng_data.generation.  If _vdso_rng_data.generation is changed, the change
in base_crng.generation needs to be visible too.

> > One question I have is about forking.  So, when a thread calls fork(), in the
> > child the kernel automatically replaces all vgetrandom_state pages with zeroed
> > pages (due to MADV_WIPEONFORK).  If the child calls __cvdso_getrandom_data()
> > afterwards, it sees the zeroed state.  But that's indistinguishable from the
> > state at the very beginning, after sys_vgetrandom_alloc() was just called,
> > right?  So as long as this code handles initializing the state at the beginning,
> > then I'd think it would naturally handle fork() as well.
> 
> Right, for this simple fork() case, it works fine. There are other cases
> though that are trickier...
> 
> > However, it seems you have something a bit more subtle in mind, where the thread
> > calls fork() *while* it's in the middle of __cvdso_getrandom_data().  I guess
> > you are thinking of the case where a signal is sent to the thread while it's
> > executing __cvdso_getrandom_data(), and then the signal handler calls fork()?
> > Note that it doesn't matter if a different thread in the *process* calls fork().
> > 
> > If it's possible for the thread to fork() (and hence for the vgetrandom_state to
> > be zeroed) at absolutely any time, it probably would be a good idea to mark that
> > whole struct as volatile.
> 
> Actually, this isn't something that matters, I don't think. If
> state->key_batch is zeroed, the result will be wrong, but the function
> logic will be fine. If state->pos is zeroed, it'll write to the
> beginning of the batch, which might be wrong, but the function logic
> will still be fine. That is, in both of these cases, even if the
> calculation is wrong, there's no memory corruption or anything. So then,
> the remaining member is state->generation. If this is zeroed, then it's
> actually something we detect with that READ_ONCE()! And in this case,
> it's a sign that something is off -- we forked -- and so we should start
> over from the beginning. So I don't think there's a reason to mark the
> whole struct as volatile. The one we care about is state->generation,
> and for that we READ_ONCE() it at the place that matters.

It's undefined behavior for C code to be working on values that can be mutated
underneath it, though, unless they are volatile.  Granted, people still do this
all the time, but I'd hope we can be a bit more careful here...

> There's actually a different scenario, though, that I'm concerned about,
> and this is the case in which a multithreaded program forks in the
> middle of one of its threads running this. Indeed, only the calling
> thread will carry forward into the child process, but all the memory is
> still left around from any concurrent threads in the middle of
> vgetrandom(). And if they're in the middle of a vgetrandom() call, that
> means they haven't yet done erasure and cleaned up the stack to prevent
> their state from leaking, and so forward secrecy is potentially lost,
> since the child process now has some state from the parent.

That is a separate problem though, right?  It does *not* mean that the
vgetrandom_state can be zeroed out from underneath __cvdso_getrandom_data().

- Eric
