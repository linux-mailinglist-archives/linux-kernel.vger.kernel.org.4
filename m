Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DDFD63D9A2
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 16:42:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbiK3PmV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 10:42:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbiK3PmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 10:42:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73985252A5;
        Wed, 30 Nov 2022 07:42:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2783AB81B80;
        Wed, 30 Nov 2022 15:42:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DCA2C433D6;
        Wed, 30 Nov 2022 15:42:14 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="MxRj9dwk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1669822931;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=y/JyZnolFsNU/DtisgU1TQMbXNJVT8YzDCxIA1dG6rY=;
        b=MxRj9dwkPu9bL05ltCfBAE4o+L3ukf0+VKg3D+SJQqMDA2Kul//U9rFPYhetiSvkfYUkRY
        soKIN+KloBgarP+NJn/I1aqKPXfx/VYvYGPsHBkzSywiEfcPlIc0D2jncq7zcy00BclZfg
        8igxieSmQre+FhGlu74GZ4ghSd2pVpg=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 18a6a81c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 30 Nov 2022 15:42:11 +0000 (UTC)
Date:   Wed, 30 Nov 2022 16:39:55 +0100
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        tglx@linutronix.de, linux-crypto@vger.kernel.org,
        linux-api@vger.kernel.org, x86@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
        Carlos O'Donell <carlos@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v10 1/4] random: add vgetrandom_alloc() syscall
Message-ID: <Y4d5SyU3akA9ZBaJ@zx2c4.com>
References: <20221129210639.42233-1-Jason@zx2c4.com>
 <20221129210639.42233-2-Jason@zx2c4.com>
 <877czc7m0g.fsf@oldenburg.str.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <877czc7m0g.fsf@oldenburg.str.redhat.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian,

On Wed, Nov 30, 2022 at 11:51:59AM +0100, Florian Weimer wrote:
> * Jason A. Donenfeld:
> 
> > +#ifdef CONFIG_VGETRANDOM_ALLOC_SYSCALL
> > +/**
> > + * vgetrandom_alloc - allocate opaque states for use with vDSO getrandom().
> > + *
> > + * @num: on input, a pointer to a suggested hint of how many states to
> > + * allocate, and on output the number of states actually allocated.
> 
> Should userspace call this system call again if it needs more states?
> The interface description doesn't make this clear.

Yes. And indeed that's what Adhemerval's patch does.

> 
> > + * @size_per_each: the size of each state allocated, so that the caller can
> > + * split up the returned allocation into individual states.
> > + *
> > + * @flags: currently always zero.
> > + *
> > + * The getrandom() vDSO function in userspace requires an opaque state, which
> > + * this function allocates by mapping a certain number of special pages into
> > + * the calling process. It takes a hint as to the number of opaque states
> > + * desired, and provides the caller with the number of opaque states actually
> > + * allocated, the size of each one in bytes, and the address of the first
> > + * state.
> > +
> > + * Returns a pointer to the first state in the allocation.
> > + *
> > + */
> 
> How do we deallocate this memory?  Must it remain permanently allocated?

It can be deallocated with munmap.

> Can userspace use the memory for something else if it's not passed to
> getrandom?

I suspect the documentation answer here is, "no", even if technically it
might happen to work on this kernel or that kernel. I suppose this could
even be quasi-enforced by xoring the top bits with some vdso
compile-time constant, so you can't rely on being able to dereference
it yourself.

> The separate system call strongly suggests that the
> allocation is completely owned by the kernel, but there isn't
> documentation here how the allocation life-cycle is supposed to look
> like.  In particular, it is not clear if vgetrandom_alloc or getrandom
> could retain a reference to the allocation in a future implementation of
> these interfaces.
> 
> Some users might want to zap the memory for extra hardening after use,
> and it's not clear if that's allowed, either.

I don't think zapping that memory is supported, or even a sensible thing
to do. In the first place, I don't think we should suggest that the user
can dereference that pointer, at all. In that sense, maybe it's best to
call it a "handle" or something similar (a "HANDLE"! a "HWND"? a "HRNG"?
just kidding). In the second place, the fast erasure aspect of this
means that such hardening would have no effect -- the key is overwritten
after using for forward secrecy, anyway, and batched bytes are zeroed.
(There is a corner case that might make it interesting to wipe in the
parent, not just the child, on fork, but that's sort of a separate
matter and would ideally be handled by kernel space anyway.)

> If there's no registration of the allocation, it's not clear why we need
> a separate system call for this.  From a documentation perspective, it
> may be easier to describe proper use of the getrandom vDSO call if
> ownership resides with userspace.

No, absolutely not, for the multiple reasons already listed in the
commit messages and cover letter and previous emails. But you seem
aware of this:

> But it will constrain future
> evolution of the implementation because you can't add registration
> (retaining a reference to the passed-in area in getrandom) after the
> fact.  But I'm not sure if this is possible with the current interface,
> either.  Userspace has to make some assumptions about the life-cycle to
> avoid a memory leak on thread exit.

It sounds like this is sort of a different angle on Rasmus' earlier
comment about how munmap leaks implementation details. Maybe there's
something to that after all? Or not? I see two approaches:

1) Keep munmap as the allocation function. If later on we do fancy
   registration and in-kernel state tracking, or add fancy protection
   flags, or whatever else, munmap should be able to identify these
   pages and carry out whatever special treatment is necessary.

2) Convert vgetrandom_alloc() into a clone3-style syscall, as Christian
   suggested earlier, which might allow for a bit more overloading
   capability. That would be a struct that looks like:

      struct vgetrandom_alloc_args {
	  __aligned_u64 flags;
          __aligned_u64 states;
	  __aligned_u64 num;
	  __aligned_u64 size_of_each;
      }

  - If flags is VGRA_ALLOCATE, states and size_of_each must be zero on
    input, while num is the hint, as is the case now. On output, states,
    size_of_each, and num are filled in.

  - If flags is VGRA_DEALLOCATE, states, size_of_each, and num must be as
    they were originally, and then it deallocates.

I suppose (2) would alleviate your concerns entirely, without future
uncertainty over what it'd be like to add special cases to munmap(). And
it'd add a bit more future proofing to the syscall, depending on what we
do.

So maybe I'm warming up to that approach a bit.

> > +	num_states = clamp_t(size_t, num_hint, 1, (SIZE_MAX & PAGE_MASK) / state_size);
> > +	alloc_size = PAGE_ALIGN(num_states * state_size);
> 
> Doesn't this waste space for one state if state_size happens to be a
> power of 2?  Why do this SIZE_MAX & PAGE_MASK thing at all?  Shouldn't
> it be PAGE_SIZE / state_size?

The first line is a clamp. That fixes num_hint between 1 and the largest
number that when multiplied and rounded up won't overflow.

So, if state_size is a power of two, let's say 256, and there's only one
state, here's what that looks like:

    num_states = clamp(1, 1, (0xffffffff & (~(4096 - 1))) / 256 = 16777200) = 1
    alloc_size = PAGE_ALIGN(1 * 256) = 4096

So that seems like it's working as intended, right? Or if not, maybe
it'd help to write out the digits you're concerned about?

> > +	if (put_user(alloc_size / state_size, num) || put_user(state_size, size_per_each))
> > +		return -EFAULT;
> > +
> > +	pages_addr = vm_mmap(NULL, 0, alloc_size, PROT_READ | PROT_WRITE,
> > +			     MAP_PRIVATE | MAP_ANONYMOUS | MAP_LOCKED, 0);
> 
> I think Rasmus has already raised questions about MAP_LOCKED.
> 
> I think the kernel cannot rely on it because userspace could call
> munlock on the allocation.

Then they're caught holding the bag? This doesn't seem much different
from userspace shooting themselves in general, like writing garbage into
the allocated states and then trying to use them. If this is something
you really, really are concerned about, then maybe my cheesy dumb xor
thing mentioned above would be a low effort mitigation here.

Jason
