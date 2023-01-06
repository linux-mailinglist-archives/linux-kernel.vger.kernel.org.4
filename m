Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78DDE6601D1
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 15:12:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234002AbjAFOMJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 09:12:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234735AbjAFOMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 09:12:05 -0500
Received: from fx304.security-mail.net (smtpout30.security-mail.net [85.31.212.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3D5577D30
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 06:12:02 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by fx304.security-mail.net (Postfix) with ESMTP id E317F9D04F
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 15:12:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalray.eu;
        s=sec-sig-email; t=1673014320;
        bh=lm64IKt5w1lI+gFEYSIMCLrr3xKxn0GDirRbIhHBtCU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=ZRweARJs0E0gTbLwburOKLHH0+T0jsO66MZxNR5J6nwzWVZhBehtrInnLDwR7xpnF
         unAQpJf1BdrGYAyv/YxKrA8VSnoGbGHUr2bfC0VVgVCh3FyJJVuL9XK7tCHli5qURs
         NpH+67vy0QgEGTNDBxS9Wq9/tI562BWO5mE6V3YQ=
Received: from fx304 (localhost [127.0.0.1]) by fx304.security-mail.net
 (Postfix) with ESMTP id C81E59D04A; Fri,  6 Jan 2023 15:12:00 +0100 (CET)
Received: from zimbra2.kalray.eu (unknown [217.181.231.53]) by
 fx304.security-mail.net (Postfix) with ESMTPS id 0BD389D012; Fri,  6 Jan
 2023 15:12:00 +0100 (CET)
Received: from zimbra2.kalray.eu (localhost [127.0.0.1]) by
 zimbra2.kalray.eu (Postfix) with ESMTPS id D885227E028C; Fri,  6 Jan 2023
 15:11:59 +0100 (CET)
Received: from localhost (localhost [127.0.0.1]) by zimbra2.kalray.eu
 (Postfix) with ESMTP id BCF6927E02E4; Fri,  6 Jan 2023 15:11:59 +0100 (CET)
Received: from zimbra2.kalray.eu ([127.0.0.1]) by localhost
 (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10026) with ESMTP id
 JoOAzJw61IJl; Fri,  6 Jan 2023 15:11:59 +0100 (CET)
Received: from tellis.lin.mbt.kalray.eu (unknown [192.168.36.206]) by
 zimbra2.kalray.eu (Postfix) with ESMTPSA id A11AD27E028C; Fri,  6 Jan 2023
 15:11:59 +0100 (CET)
X-Virus-Scanned: E-securemail
Secumail-id: <1485.63b82c30.a9dc.0>
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra2.kalray.eu BCF6927E02E4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalray.eu;
 s=32AE1B44-9502-11E5-BA35-3734643DEF29; t=1673014319;
 bh=JOgo99MytJ707M3fuvMx42ry2oXteg75a75vnVAqqQQ=;
 h=Date:From:To:Message-ID:MIME-Version;
 b=jH2MCfj042xYMKRdaycEGCx/TuOpfRw0TymOZg08/nc9PrempoJ+eXktTAJr1BGqO
 teHw27Dc8IJtdmUnG7zkjBTKX4433Dl4mvHrJk8AnzkzP70866bHbzLSL1nyHdRX6U
 ZqahuB2I/97vWIWuBqGfBBvddCBIxo0qlpyfqDlY=
Date:   Fri, 6 Jan 2023 15:11:58 +0100
From:   Jules Maselbas <jmaselbas@kalray.eu>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Yann Sionneau <ysionneau@kalray.eu>, Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel@vger.kernel.org,
        Clement Leger <clement.leger@bootlin.com>,
        Julian Vetter <jvetter@kalray.eu>,
        Julien Villette <jvillette@kalray.eu>
Subject: Re: [RFC PATCH 05/25] kvx: Add atomic/locking headers
Message-ID: <20230106141158.GC7446@tellis.lin.mbt.kalray.eu>
References: <20230103164359.24347-1-ysionneau@kalray.eu>
 <20230103164359.24347-6-ysionneau@kalray.eu> <Y7VMlPKGEQwvTK4W@FVFF77S0Q05N>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y7VMlPKGEQwvTK4W@FVFF77S0Q05N>
User-Agent: Mutt/1.9.4 (2018-02-28)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-ALTERMIMEV2_out: done
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On Wed, Jan 04, 2023 at 09:53:24AM +0000, Mark Rutland wrote:
> On Tue, Jan 03, 2023 at 05:43:39PM +0100, Yann Sionneau wrote:
> > Add common headers (atomic, bitops, barrier and locking) for basic
> > kvx support.
> > 
> > CC: Will Deacon <will@kernel.org>
> > CC: Peter Zijlstra <peterz@infradead.org>
> > CC: Boqun Feng <boqun.feng@gmail.com>
> > CC: Mark Rutland <mark.rutland@arm.com>
> > CC: linux-kernel@vger.kernel.org
> > Co-developed-by: Clement Leger <clement.leger@bootlin.com>
> > Signed-off-by: Clement Leger <clement.leger@bootlin.com>
> > Co-developed-by: Jules Maselbas <jmaselbas@kalray.eu>
> > Signed-off-by: Jules Maselbas <jmaselbas@kalray.eu>
> > Co-developed-by: Julian Vetter <jvetter@kalray.eu>
> > Signed-off-by: Julian Vetter <jvetter@kalray.eu>
> > Co-developed-by: Julien Villette <jvillette@kalray.eu>
> > Signed-off-by: Julien Villette <jvillette@kalray.eu>
> > Co-developed-by: Yann Sionneau <ysionneau@kalray.eu>
> > Signed-off-by: Yann Sionneau <ysionneau@kalray.eu>
> > ---
> >  arch/kvx/include/asm/atomic.h  | 104 +++++++++++++++++
> >  arch/kvx/include/asm/barrier.h |  15 +++
> >  arch/kvx/include/asm/bitops.h  | 207 +++++++++++++++++++++++++++++++++
> >  arch/kvx/include/asm/bitrev.h  |  32 +++++
> >  arch/kvx/include/asm/cmpxchg.h | 185 +++++++++++++++++++++++++++++
> >  5 files changed, 543 insertions(+)
> >  create mode 100644 arch/kvx/include/asm/atomic.h
> >  create mode 100644 arch/kvx/include/asm/barrier.h
> >  create mode 100644 arch/kvx/include/asm/bitops.h
> >  create mode 100644 arch/kvx/include/asm/bitrev.h
> >  create mode 100644 arch/kvx/include/asm/cmpxchg.h
> > 
> > diff --git a/arch/kvx/include/asm/atomic.h b/arch/kvx/include/asm/atomic.h
> > new file mode 100644
> > index 000000000000..eb8acbcbc70d
> > --- /dev/null
> > +++ b/arch/kvx/include/asm/atomic.h
> > @@ -0,0 +1,104 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +/*
> > + * Copyright (C) 2017-2023 Kalray Inc.
> > + * Author(s): Clement Leger
> > + */
> > +
> > +#ifndef _ASM_KVX_ATOMIC_H
> > +#define _ASM_KVX_ATOMIC_H
> > +
> > +#include <linux/types.h>
> > +
> > +#include <asm/cmpxchg.h>
> > +
> > +#define ATOMIC64_INIT(i)     { (i) }
> > +
> > +#define arch_atomic64_cmpxchg(v, old, new) (arch_cmpxchg(&((v)->counter), old, new))
> > +#define arch_atomic64_xchg(v, new) (arch_xchg(&((v)->counter), new))
> > +
> > +static inline long arch_atomic64_read(const atomic64_t *v)
> > +{
> > +	return v->counter;
> > +}
> 
> This is a plain read, and is *not* atomic.
> 
> The compiler can replay a plain read an arbitrary number of times, and is
> permitted to split it into smaller accesses.
> 
> At minimum this needs to be
> 
>   READ_ONCE(v->counter)
> 
> ... which will prevent replay. Whether or not that's actually atomic will
> depend on the instructions the compiler generates, and how those instructions
> are defines in your architecture.
Good point, we are going to use {READ,WRITE}_ONCE macros

> Do you have a single instruction that can read a 64-bit memory location, and is
> it guaranteed to result in a single access that cannot be split?

We do have a single instruction that can read a 64-bit memory location
(supported sizes are 8, 16, 32, 64, 128, 256).
All accesses are guaranteed to not be split, unless they are misaligned.
Furthermore, misaligned write accesses crossing a 32-byte boundary may
complete in a non-atomic way.

> 
> > +static inline void arch_atomic64_set(atomic64_t *v, long i)
> > +{
> > +	v->counter = i;
> > +}
> 
> Same comments as for arch_atomic64_read(); at minimum this needs to be:
> 
>   WRITE_ONCE(v->counter, i)
> 
> ... but that may or may not actually be atomic on your architecture.
> 
> > +#define ATOMIC64_RETURN_OP(op, c_op)					\
> > +static inline long arch_atomic64_##op##_return(long i, atomic64_t *v)	\
> > +{									\
> > +	long new, old, ret;						\
> > +									\
> > +	do {								\
> > +		old = v->counter;					\
> > +		new = old c_op i;					\
> > +		ret = arch_cmpxchg(&v->counter, old, new);		\
> > +	} while (ret != old);						\
> > +									\
> > +	return new;							\
> > +}
> > +
> > +#define ATOMIC64_OP(op, c_op)						\
> > +static inline void arch_atomic64_##op(long i, atomic64_t *v)		\
> > +{									\
> > +	long new, old, ret;						\
> > +									\
> > +	do {								\
> > +		old = v->counter;					\
> > +		new = old c_op i;					\
> > +		ret = arch_cmpxchg(&v->counter, old, new);		\
> > +	} while (ret != old);						\
> > +}
> > +
> > +#define ATOMIC64_FETCH_OP(op, c_op)					\
> > +static inline long arch_atomic64_fetch_##op(long i, atomic64_t *v)	\
> > +{									\
> > +	long new, old, ret;						\
> > +									\
> > +	do {								\
> > +		old = v->counter;					\
> > +		new = old c_op i;					\
> > +		ret = arch_cmpxchg(&v->counter, old, new);		\
> > +	} while (ret != old);						\
> > +									\
> > +	return old;							\
> > +}
> 
> These look ok, but it'd be nicer if we could teach the generic atomic64 code to
> do this, like the generic atomic code does.
> 
> We could rename the existing asm-generic/atomic64 code to atomic64-spinlock,
> and add a separate atomic64-cmpxchg (and likewise for the 32-bit code) to make
> that clearer and consistent.
I am not sure what this implies and how big this change might be,
but I'll take a look at this.

> > +
> > +#define ATOMIC64_OPS(op, c_op)						\
> > +	ATOMIC64_OP(op, c_op)						\
> > +	ATOMIC64_RETURN_OP(op, c_op)					\
> > +	ATOMIC64_FETCH_OP(op, c_op)
> > +
> > +ATOMIC64_OPS(and, &)
> > +ATOMIC64_OPS(or, |)
> > +ATOMIC64_OPS(xor, ^)
> > +ATOMIC64_OPS(add, +)
> > +ATOMIC64_OPS(sub, -)
> > +
> > +#undef ATOMIC64_OPS
> > +#undef ATOMIC64_FETCH_OP
> > +#undef ATOMIC64_OP
> > +
> > +static inline int arch_atomic_add_return(int i, atomic_t *v)
> > +{
> > +	int new, old, ret;
> > +
> > +	do {
> > +		old = v->counter;
> > +		new = old + i;
> > +		ret = arch_cmpxchg(&v->counter, old, new);
> > +	} while (ret != old);
> > +
> > +	return new;
> > +}
> > +
> > +static inline int arch_atomic_sub_return(int i, atomic_t *v)
> > +{
> > +	return arch_atomic_add_return(-i, v);
> > +}
> 
> Likewise for these two.
> 
> > +
> > +#include <asm-generic/atomic.h>
> > +
> > +#endif	/* _ASM_KVX_ATOMIC_H */
> > diff --git a/arch/kvx/include/asm/barrier.h b/arch/kvx/include/asm/barrier.h
> > new file mode 100644
> > index 000000000000..371f1c70746d
> > --- /dev/null
> > +++ b/arch/kvx/include/asm/barrier.h
> > @@ -0,0 +1,15 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +/*
> > + * Copyright (C) 2017-2023 Kalray Inc.
> > + * Author(s): Clement Leger
> > + */
> > +
> > +#ifndef _ASM_KVX_BARRIER_H
> > +#define _ASM_KVX_BARRIER_H
> 
> > +/* Bitmask modifiers */
> > +#define __NOP(x)	(x)
> > +#define __NOT(x)	(~(x))
> > +
> > +
> > +#define __test_and_op_bit(nr, addr, op, mod)				\
> > +({									\
> > +	unsigned long __mask = BIT_MASK(nr);				\
> > +	unsigned long __new, __old, __ret;				\
> > +	do {								\
> > +		__old = *(&addr[BIT_WORD(nr)]);				\
> > +		__new = __old op mod(__mask);				\
> > +		__ret = cmpxchg(addr, __old, __new);			\
> > +	} while (__ret != __old);					\
> > +	(__old & __mask);						\
> > +})
> 
> Please use <asm-generic/bitops/atomic.h> which should give you the common
> bit operations "for free" atop your regular atomics.
Yes

> 
> [...]
> 
> > diff --git a/arch/kvx/include/asm/cmpxchg.h b/arch/kvx/include/asm/cmpxchg.h
> > new file mode 100644
> > index 000000000000..b1d128b060a2
> > --- /dev/null
> > +++ b/arch/kvx/include/asm/cmpxchg.h
> > @@ -0,0 +1,185 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +/*
> > + * Copyright (C) 2017-2023 Kalray Inc.
> > + * Author(s): Clement Leger
> > + *            Yann Sionneau
> > + */
> > +
> > +#ifndef _ASM_KVX_CMPXCHG_H
> > +#define _ASM_KVX_CMPXCHG_H
> > +
> > +#include <linux/bits.h>
> > +#include <linux/types.h>
> > +#include <linux/build_bug.h>
> > +
> > +/*
> > + * On kvx, we have a boolean compare and swap which means that the operation
> > + * returns only the success of operation.
> > + * If operation succeed, this is simple, we just need to return the provided
> > + * old value. However, if it fails, we need to load the value to return it for
> > + * the caller. If the loaded value is different from the "old" provided by the
> > + * caller, we can return it since it will means it failed.
> > + * However, if for some reason the value we read is equal to the old value
> > + * provided by the caller, we can't simply return it or the caller will think it
> > + * succeeded. So if the value we read is the same as the "old" provided by
> > + * the caller, we try again until either we succeed or we fail with a different
> > + * value than the provided one.
> > + */
> > +#define __cmpxchg(ptr, old, new, op_suffix, load_suffix)		\
> > +({									\
> > +	register unsigned long __rn asm("r62");				\
> > +	register unsigned long __ro asm("r63");				\
> 
> Why do you need to specify the exact registers?
r62 and r63 are hardcoded in the inline assembly, they are caller saved.
I have a C implementation that uses builtins however this is not merged
in our tree yet (but I want to).

> e.g. does some instruction use these implicitly, or do you need two adjacent
> register for encoding reasons?

The atomic compare and swap (acswap) instruction needs a register "pair"
which can only exists with "adjacent" registers:  $r0r1, $r2r3 ect.

> > +	__asm__ __volatile__ (						\
> > +		/* Fence to guarantee previous store to be committed */	\
> > +		"fence\n"						\
> 
> This implies you can implement the relaxed form of cmpxchg().
> 
> What ordering do you get by default, and do you have any other barriers (e.g.
> for acquire/release semantics), or just "fence" ?
We have two barrier types:
 - fence: ensure that all uncached memory operations are committed to
   memory, typically used to ensure a write to memory is visible to
   other cores.
 - barrier: flush the core instruction pipeline and memory system

Thanks,
-- Jules




