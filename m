Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4278B6641B1
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 14:27:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231519AbjAJN1B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 08:27:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238603AbjAJN0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 08:26:10 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C22125AC47
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 05:25:23 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C64222F4;
        Tue, 10 Jan 2023 05:25:55 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.46.95])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6EDF33F587;
        Tue, 10 Jan 2023 05:24:56 -0800 (PST)
Date:   Tue, 10 Jan 2023 13:24:30 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Jules Maselbas <jmaselbas@kalray.eu>
Cc:     Yann Sionneau <ysionneau@kalray.eu>, Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel@vger.kernel.org,
        Clement Leger <clement.leger@bootlin.com>,
        Julian Vetter <jvetter@kalray.eu>,
        Julien Villette <jvillette@kalray.eu>
Subject: Re: [RFC PATCH 05/25] kvx: Add atomic/locking headers
Message-ID: <Y71nDtFHgDJoWb6s@FVFF77S0Q05N>
References: <20230103164359.24347-1-ysionneau@kalray.eu>
 <20230103164359.24347-6-ysionneau@kalray.eu>
 <Y7VMlPKGEQwvTK4W@FVFF77S0Q05N>
 <20230106141158.GC7446@tellis.lin.mbt.kalray.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230106141158.GC7446@tellis.lin.mbt.kalray.eu>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 06, 2023 at 03:11:58PM +0100, Jules Maselbas wrote:
> Hi Mark,
> 
> On Wed, Jan 04, 2023 at 09:53:24AM +0000, Mark Rutland wrote:
> > On Tue, Jan 03, 2023 at 05:43:39PM +0100, Yann Sionneau wrote:
> > > Add common headers (atomic, bitops, barrier and locking) for basic
> > > kvx support.
> > > 
> > > CC: Will Deacon <will@kernel.org>
> > > CC: Peter Zijlstra <peterz@infradead.org>
> > > CC: Boqun Feng <boqun.feng@gmail.com>
> > > CC: Mark Rutland <mark.rutland@arm.com>
> > > CC: linux-kernel@vger.kernel.org
> > > Co-developed-by: Clement Leger <clement.leger@bootlin.com>
> > > Signed-off-by: Clement Leger <clement.leger@bootlin.com>
> > > Co-developed-by: Jules Maselbas <jmaselbas@kalray.eu>
> > > Signed-off-by: Jules Maselbas <jmaselbas@kalray.eu>
> > > Co-developed-by: Julian Vetter <jvetter@kalray.eu>
> > > Signed-off-by: Julian Vetter <jvetter@kalray.eu>
> > > Co-developed-by: Julien Villette <jvillette@kalray.eu>
> > > Signed-off-by: Julien Villette <jvillette@kalray.eu>
> > > Co-developed-by: Yann Sionneau <ysionneau@kalray.eu>
> > > Signed-off-by: Yann Sionneau <ysionneau@kalray.eu>
> > > ---
> > >  arch/kvx/include/asm/atomic.h  | 104 +++++++++++++++++
> > >  arch/kvx/include/asm/barrier.h |  15 +++
> > >  arch/kvx/include/asm/bitops.h  | 207 +++++++++++++++++++++++++++++++++
> > >  arch/kvx/include/asm/bitrev.h  |  32 +++++
> > >  arch/kvx/include/asm/cmpxchg.h | 185 +++++++++++++++++++++++++++++
> > >  5 files changed, 543 insertions(+)
> > >  create mode 100644 arch/kvx/include/asm/atomic.h
> > >  create mode 100644 arch/kvx/include/asm/barrier.h
> > >  create mode 100644 arch/kvx/include/asm/bitops.h
> > >  create mode 100644 arch/kvx/include/asm/bitrev.h
> > >  create mode 100644 arch/kvx/include/asm/cmpxchg.h
> > > 
> > > diff --git a/arch/kvx/include/asm/atomic.h b/arch/kvx/include/asm/atomic.h
> > > new file mode 100644
> > > index 000000000000..eb8acbcbc70d
> > > --- /dev/null
> > > +++ b/arch/kvx/include/asm/atomic.h
> > > @@ -0,0 +1,104 @@
> > > +/* SPDX-License-Identifier: GPL-2.0-only */
> > > +/*
> > > + * Copyright (C) 2017-2023 Kalray Inc.
> > > + * Author(s): Clement Leger
> > > + */
> > > +
> > > +#ifndef _ASM_KVX_ATOMIC_H
> > > +#define _ASM_KVX_ATOMIC_H
> > > +
> > > +#include <linux/types.h>
> > > +
> > > +#include <asm/cmpxchg.h>
> > > +
> > > +#define ATOMIC64_INIT(i)     { (i) }
> > > +
> > > +#define arch_atomic64_cmpxchg(v, old, new) (arch_cmpxchg(&((v)->counter), old, new))
> > > +#define arch_atomic64_xchg(v, new) (arch_xchg(&((v)->counter), new))
> > > +
> > > +static inline long arch_atomic64_read(const atomic64_t *v)
> > > +{
> > > +	return v->counter;
> > > +}
> > 
> > This is a plain read, and is *not* atomic.
> > 
> > The compiler can replay a plain read an arbitrary number of times, and is
> > permitted to split it into smaller accesses.
> > 
> > At minimum this needs to be
> > 
> >   READ_ONCE(v->counter)
> > 
> > ... which will prevent replay. Whether or not that's actually atomic will
> > depend on the instructions the compiler generates, and how those instructions
> > are defines in your architecture.
> Good point, we are going to use {READ,WRITE}_ONCE macros
> 
> > Do you have a single instruction that can read a 64-bit memory location, and is
> > it guaranteed to result in a single access that cannot be split?
> 
> We do have a single instruction that can read a 64-bit memory location
> (supported sizes are 8, 16, 32, 64, 128, 256).
> All accesses are guaranteed to not be split, unless they are misaligned.
> Furthermore, misaligned write accesses crossing a 32-byte boundary may
> complete in a non-atomic way.

Perfect, thanks for confirming!

[...]

> > > +static inline void arch_atomic64_set(atomic64_t *v, long i)
> > > +{
> > > +	v->counter = i;
> > > +}
> > 
> > Same comments as for arch_atomic64_read(); at minimum this needs to be:
> > 
> >   WRITE_ONCE(v->counter, i)
> > 
> > ... but that may or may not actually be atomic on your architecture.
> > 
> > > +#define ATOMIC64_RETURN_OP(op, c_op)					\
> > > +static inline long arch_atomic64_##op##_return(long i, atomic64_t *v)	\
> > > +{									\
> > > +	long new, old, ret;						\
> > > +									\
> > > +	do {								\
> > > +		old = v->counter;					\
> > > +		new = old c_op i;					\
> > > +		ret = arch_cmpxchg(&v->counter, old, new);		\
> > > +	} while (ret != old);						\
> > > +									\
> > > +	return new;							\
> > > +}
> > > +
> > > +#define ATOMIC64_OP(op, c_op)						\
> > > +static inline void arch_atomic64_##op(long i, atomic64_t *v)		\
> > > +{									\
> > > +	long new, old, ret;						\
> > > +									\
> > > +	do {								\
> > > +		old = v->counter;					\
> > > +		new = old c_op i;					\
> > > +		ret = arch_cmpxchg(&v->counter, old, new);		\
> > > +	} while (ret != old);						\
> > > +}
> > > +
> > > +#define ATOMIC64_FETCH_OP(op, c_op)					\
> > > +static inline long arch_atomic64_fetch_##op(long i, atomic64_t *v)	\
> > > +{									\
> > > +	long new, old, ret;						\
> > > +									\
> > > +	do {								\
> > > +		old = v->counter;					\
> > > +		new = old c_op i;					\
> > > +		ret = arch_cmpxchg(&v->counter, old, new);		\
> > > +	} while (ret != old);						\
> > > +									\
> > > +	return old;							\
> > > +}
> > 
> > These look ok, but it'd be nicer if we could teach the generic atomic64 code to
> > do this, like the generic atomic code does.
> > 
> > We could rename the existing asm-generic/atomic64 code to atomic64-spinlock,
> > and add a separate atomic64-cmpxchg (and likewise for the 32-bit code) to make
> > that clearer and consistent.
> I am not sure what this implies and how big this change might be,
> but I'll take a look at this.

Hmm... from a quick attempt just now it looks like that will be a bit more
churny than I thought.

We can always factor this out later, so feel free to leave it as-is, thgouh if
we could make this genric (and have it look like asm-generic/atomic.h), it'd be
nice for consistency and maintenance.

> > > +
> > > +#define ATOMIC64_OPS(op, c_op)						\
> > > +	ATOMIC64_OP(op, c_op)						\
> > > +	ATOMIC64_RETURN_OP(op, c_op)					\
> > > +	ATOMIC64_FETCH_OP(op, c_op)
> > > +
> > > +ATOMIC64_OPS(and, &)
> > > +ATOMIC64_OPS(or, |)
> > > +ATOMIC64_OPS(xor, ^)
> > > +ATOMIC64_OPS(add, +)
> > > +ATOMIC64_OPS(sub, -)
> > > +
> > > +#undef ATOMIC64_OPS
> > > +#undef ATOMIC64_FETCH_OP
> > > +#undef ATOMIC64_OP
> > > +
> > > +static inline int arch_atomic_add_return(int i, atomic_t *v)
> > > +{
> > > +	int new, old, ret;
> > > +
> > > +	do {
> > > +		old = v->counter;
> > > +		new = old + i;
> > > +		ret = arch_cmpxchg(&v->counter, old, new);
> > > +	} while (ret != old);
> > > +
> > > +	return new;
> > > +}
> > > +
> > > +static inline int arch_atomic_sub_return(int i, atomic_t *v)
> > > +{
> > > +	return arch_atomic_add_return(-i, v);
> > > +}
> > 
> > Likewise for these two.

The 32-bit atomics should come from asm-generic/atomic.h and not be necesary,
that has both arch_atomic_add_return() and arch_atomic_sub_return().

> > > diff --git a/arch/kvx/include/asm/cmpxchg.h b/arch/kvx/include/asm/cmpxchg.h
> > > new file mode 100644
> > > index 000000000000..b1d128b060a2
> > > --- /dev/null
> > > +++ b/arch/kvx/include/asm/cmpxchg.h
> > > @@ -0,0 +1,185 @@
> > > +/* SPDX-License-Identifier: GPL-2.0-only */
> > > +/*
> > > + * Copyright (C) 2017-2023 Kalray Inc.
> > > + * Author(s): Clement Leger
> > > + *            Yann Sionneau
> > > + */
> > > +
> > > +#ifndef _ASM_KVX_CMPXCHG_H
> > > +#define _ASM_KVX_CMPXCHG_H
> > > +
> > > +#include <linux/bits.h>
> > > +#include <linux/types.h>
> > > +#include <linux/build_bug.h>
> > > +
> > > +/*
> > > + * On kvx, we have a boolean compare and swap which means that the operation
> > > + * returns only the success of operation.
> > > + * If operation succeed, this is simple, we just need to return the provided
> > > + * old value. However, if it fails, we need to load the value to return it for
> > > + * the caller. If the loaded value is different from the "old" provided by the
> > > + * caller, we can return it since it will means it failed.
> > > + * However, if for some reason the value we read is equal to the old value
> > > + * provided by the caller, we can't simply return it or the caller will think it
> > > + * succeeded. So if the value we read is the same as the "old" provided by
> > > + * the caller, we try again until either we succeed or we fail with a different
> > > + * value than the provided one.
> > > + */
> > > +#define __cmpxchg(ptr, old, new, op_suffix, load_suffix)		\
> > > +({									\
> > > +	register unsigned long __rn asm("r62");				\
> > > +	register unsigned long __ro asm("r63");				\
> > 
> > Why do you need to specify the exact registers?
> r62 and r63 are hardcoded in the inline assembly, they are caller saved.
> I have a C implementation that uses builtins however this is not merged
> in our tree yet (but I want to).
> 
> > e.g. does some instruction use these implicitly, or do you need two adjacent
> > register for encoding reasons?
> 
> The atomic compare and swap (acswap) instruction needs a register "pair"
> which can only exists with "adjacent" registers:  $r0r1, $r2r3 ect.

Ok; and you don't have a way to ask GCC for an arbitrary register pair, so you
chose r62+r63 as they can be clobbered?

It might be worth looking into using an __int128_t to give you a register pair,
assuming your calling convention mandares adjacency of the two halves. That
could give you the pair while giving the compiler freedom to chose any suitable
pair (assuming you have a suitable operand modifier to extract the low/high
registers from the asm operand.

> > > +	__asm__ __volatile__ (						\
> > > +		/* Fence to guarantee previous store to be committed */	\
> > > +		"fence\n"						\
> > 
> > This implies you can implement the relaxed form of cmpxchg().
> > 
> > What ordering do you get by default, and do you have any other barriers (e.g.
> > for acquire/release semantics), or just "fence" ?
> We have two barrier types:
>  - fence: ensure that all uncached memory operations are committed to
>    memory, typically used to ensure a write to memory is visible to
>    other cores.
>  - barrier: flush the core instruction pipeline and memory system

Ok.

In the absence of barriers do you have any ordering guarantee? e.g. weak like
arm/power, TSO like x86, or something else entirely?

When you say "uncached memory operations", does that mean that you have cached
memory operatins which are not affected by the barriers, or is "uncached memory
operations" just meant to read as "oustanding/incomplete memory operations" ?

Thanks,
Mark.
