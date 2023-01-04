Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB82965CFFF
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 10:54:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234008AbjADJx5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 04:53:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234656AbjADJxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 04:53:37 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B31A21C13D
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 01:53:32 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DCCD51063;
        Wed,  4 Jan 2023 01:54:13 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.37.146])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B3AA73F71A;
        Wed,  4 Jan 2023 01:53:30 -0800 (PST)
Date:   Wed, 4 Jan 2023 09:53:24 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Yann Sionneau <ysionneau@kalray.eu>
Cc:     Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel@vger.kernel.org,
        Clement Leger <clement.leger@bootlin.com>,
        Jules Maselbas <jmaselbas@kalray.eu>,
        Julian Vetter <jvetter@kalray.eu>,
        Julien Villette <jvillette@kalray.eu>
Subject: Re: [RFC PATCH 05/25] kvx: Add atomic/locking headers
Message-ID: <Y7VMlPKGEQwvTK4W@FVFF77S0Q05N>
References: <20230103164359.24347-1-ysionneau@kalray.eu>
 <20230103164359.24347-6-ysionneau@kalray.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230103164359.24347-6-ysionneau@kalray.eu>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 03, 2023 at 05:43:39PM +0100, Yann Sionneau wrote:
> Add common headers (atomic, bitops, barrier and locking) for basic
> kvx support.
> 
> CC: Will Deacon <will@kernel.org>
> CC: Peter Zijlstra <peterz@infradead.org>
> CC: Boqun Feng <boqun.feng@gmail.com>
> CC: Mark Rutland <mark.rutland@arm.com>
> CC: linux-kernel@vger.kernel.org
> Co-developed-by: Clement Leger <clement.leger@bootlin.com>
> Signed-off-by: Clement Leger <clement.leger@bootlin.com>
> Co-developed-by: Jules Maselbas <jmaselbas@kalray.eu>
> Signed-off-by: Jules Maselbas <jmaselbas@kalray.eu>
> Co-developed-by: Julian Vetter <jvetter@kalray.eu>
> Signed-off-by: Julian Vetter <jvetter@kalray.eu>
> Co-developed-by: Julien Villette <jvillette@kalray.eu>
> Signed-off-by: Julien Villette <jvillette@kalray.eu>
> Co-developed-by: Yann Sionneau <ysionneau@kalray.eu>
> Signed-off-by: Yann Sionneau <ysionneau@kalray.eu>
> ---
>  arch/kvx/include/asm/atomic.h  | 104 +++++++++++++++++
>  arch/kvx/include/asm/barrier.h |  15 +++
>  arch/kvx/include/asm/bitops.h  | 207 +++++++++++++++++++++++++++++++++
>  arch/kvx/include/asm/bitrev.h  |  32 +++++
>  arch/kvx/include/asm/cmpxchg.h | 185 +++++++++++++++++++++++++++++
>  5 files changed, 543 insertions(+)
>  create mode 100644 arch/kvx/include/asm/atomic.h
>  create mode 100644 arch/kvx/include/asm/barrier.h
>  create mode 100644 arch/kvx/include/asm/bitops.h
>  create mode 100644 arch/kvx/include/asm/bitrev.h
>  create mode 100644 arch/kvx/include/asm/cmpxchg.h
> 
> diff --git a/arch/kvx/include/asm/atomic.h b/arch/kvx/include/asm/atomic.h
> new file mode 100644
> index 000000000000..eb8acbcbc70d
> --- /dev/null
> +++ b/arch/kvx/include/asm/atomic.h
> @@ -0,0 +1,104 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (C) 2017-2023 Kalray Inc.
> + * Author(s): Clement Leger
> + */
> +
> +#ifndef _ASM_KVX_ATOMIC_H
> +#define _ASM_KVX_ATOMIC_H
> +
> +#include <linux/types.h>
> +
> +#include <asm/cmpxchg.h>
> +
> +#define ATOMIC64_INIT(i)     { (i) }
> +
> +#define arch_atomic64_cmpxchg(v, old, new) (arch_cmpxchg(&((v)->counter), old, new))
> +#define arch_atomic64_xchg(v, new) (arch_xchg(&((v)->counter), new))
> +
> +static inline long arch_atomic64_read(const atomic64_t *v)
> +{
> +	return v->counter;
> +}

This is a plain read, and is *not* atomic.

The compiler can replay a plain read an arbitrary number of times, and is
permitted to split it into smaller accesses.

At minimum this needs to be

  READ_ONCE(v->counter)

... which will prevent replay. Whether or not that's actually atomic will
depend on the instructions the compiler generates, and how those instructions
are defines in your architecture.

Do you have a single instruction that can read a 64-bit memory location, and is
it guaranteed to result in a single access that cannot be split?

> +static inline void arch_atomic64_set(atomic64_t *v, long i)
> +{
> +	v->counter = i;
> +}

Same comments as for arch_atomic64_read(); at minimum this needs to be:

  WRITE_ONCE(v->counter, i)

... but that may or may not actually be atomic on your architecture.

> +#define ATOMIC64_RETURN_OP(op, c_op)					\
> +static inline long arch_atomic64_##op##_return(long i, atomic64_t *v)	\
> +{									\
> +	long new, old, ret;						\
> +									\
> +	do {								\
> +		old = v->counter;					\
> +		new = old c_op i;					\
> +		ret = arch_cmpxchg(&v->counter, old, new);		\
> +	} while (ret != old);						\
> +									\
> +	return new;							\
> +}
> +
> +#define ATOMIC64_OP(op, c_op)						\
> +static inline void arch_atomic64_##op(long i, atomic64_t *v)		\
> +{									\
> +	long new, old, ret;						\
> +									\
> +	do {								\
> +		old = v->counter;					\
> +		new = old c_op i;					\
> +		ret = arch_cmpxchg(&v->counter, old, new);		\
> +	} while (ret != old);						\
> +}
> +
> +#define ATOMIC64_FETCH_OP(op, c_op)					\
> +static inline long arch_atomic64_fetch_##op(long i, atomic64_t *v)	\
> +{									\
> +	long new, old, ret;						\
> +									\
> +	do {								\
> +		old = v->counter;					\
> +		new = old c_op i;					\
> +		ret = arch_cmpxchg(&v->counter, old, new);		\
> +	} while (ret != old);						\
> +									\
> +	return old;							\
> +}

These look ok, but it'd be nicer if we could teach the generic atomic64 code to
do this, like the generic atomic code does.

We could rename the existing asm-generic/atomic64 code to atomic64-spinlock,
and add a separate atomic64-cmpxchg (and likewise for the 32-bit code) to make
that clearer and consistent.

> +
> +#define ATOMIC64_OPS(op, c_op)						\
> +	ATOMIC64_OP(op, c_op)						\
> +	ATOMIC64_RETURN_OP(op, c_op)					\
> +	ATOMIC64_FETCH_OP(op, c_op)
> +
> +ATOMIC64_OPS(and, &)
> +ATOMIC64_OPS(or, |)
> +ATOMIC64_OPS(xor, ^)
> +ATOMIC64_OPS(add, +)
> +ATOMIC64_OPS(sub, -)
> +
> +#undef ATOMIC64_OPS
> +#undef ATOMIC64_FETCH_OP
> +#undef ATOMIC64_OP
> +
> +static inline int arch_atomic_add_return(int i, atomic_t *v)
> +{
> +	int new, old, ret;
> +
> +	do {
> +		old = v->counter;
> +		new = old + i;
> +		ret = arch_cmpxchg(&v->counter, old, new);
> +	} while (ret != old);
> +
> +	return new;
> +}
> +
> +static inline int arch_atomic_sub_return(int i, atomic_t *v)
> +{
> +	return arch_atomic_add_return(-i, v);
> +}

Likewise for these two.

> +
> +#include <asm-generic/atomic.h>
> +
> +#endif	/* _ASM_KVX_ATOMIC_H */
> diff --git a/arch/kvx/include/asm/barrier.h b/arch/kvx/include/asm/barrier.h
> new file mode 100644
> index 000000000000..371f1c70746d
> --- /dev/null
> +++ b/arch/kvx/include/asm/barrier.h
> @@ -0,0 +1,15 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (C) 2017-2023 Kalray Inc.
> + * Author(s): Clement Leger
> + */
> +
> +#ifndef _ASM_KVX_BARRIER_H
> +#define _ASM_KVX_BARRIER_H

> +/* Bitmask modifiers */
> +#define __NOP(x)	(x)
> +#define __NOT(x)	(~(x))
> +
> +
> +#define __test_and_op_bit(nr, addr, op, mod)				\
> +({									\
> +	unsigned long __mask = BIT_MASK(nr);				\
> +	unsigned long __new, __old, __ret;				\
> +	do {								\
> +		__old = *(&addr[BIT_WORD(nr)]);				\
> +		__new = __old op mod(__mask);				\
> +		__ret = cmpxchg(addr, __old, __new);			\
> +	} while (__ret != __old);					\
> +	(__old & __mask);						\
> +})

Please use <asm-generic/bitops/atomic.h> which should give you the common
bit operations "for free" atop your regular atomics.

[...]

> diff --git a/arch/kvx/include/asm/cmpxchg.h b/arch/kvx/include/asm/cmpxchg.h
> new file mode 100644
> index 000000000000..b1d128b060a2
> --- /dev/null
> +++ b/arch/kvx/include/asm/cmpxchg.h
> @@ -0,0 +1,185 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (C) 2017-2023 Kalray Inc.
> + * Author(s): Clement Leger
> + *            Yann Sionneau
> + */
> +
> +#ifndef _ASM_KVX_CMPXCHG_H
> +#define _ASM_KVX_CMPXCHG_H
> +
> +#include <linux/bits.h>
> +#include <linux/types.h>
> +#include <linux/build_bug.h>
> +
> +/*
> + * On kvx, we have a boolean compare and swap which means that the operation
> + * returns only the success of operation.
> + * If operation succeed, this is simple, we just need to return the provided
> + * old value. However, if it fails, we need to load the value to return it for
> + * the caller. If the loaded value is different from the "old" provided by the
> + * caller, we can return it since it will means it failed.
> + * However, if for some reason the value we read is equal to the old value
> + * provided by the caller, we can't simply return it or the caller will think it
> + * succeeded. So if the value we read is the same as the "old" provided by
> + * the caller, we try again until either we succeed or we fail with a different
> + * value than the provided one.
> + */
> +#define __cmpxchg(ptr, old, new, op_suffix, load_suffix)		\
> +({									\
> +	register unsigned long __rn asm("r62");				\
> +	register unsigned long __ro asm("r63");				\

Why do you need to specify the exact registers?

e.g. does some instruction use these implicitly, or do you need two adjacent
register for encoding reasons?

> +	__asm__ __volatile__ (						\
> +		/* Fence to guarantee previous store to be committed */	\
> +		"fence\n"						\

This implies you can implement the relaxed form of cmpxchg().

What ordering do you get by default, and do you have any other barriers (e.g.
for acquire/release semantics), or just "fence" ?

Thanks,
Mark.

> +		/* Init "expect" with previous value */			\
> +		"copyd $r63 = %[rOld]\n"				\
> +		";;\n"							\
> +		"1:\n"							\
> +		/* Init "update" value with new */			\
> +		"copyd $r62 = %[rNew]\n"				\
> +		";;\n"							\
> +		"acswap" #op_suffix " 0[%[rPtr]], $r62r63\n"		\
> +		";;\n"							\
> +		/* if acswap succeed, simply return */			\
> +		"cb.dnez $r62? 2f\n"					\
> +		";;\n"							\
> +		/* We failed, load old value */				\
> +		"l"  #op_suffix  #load_suffix" $r63 = 0[%[rPtr]]\n"	\
> +		";;\n"							\
> +		/* Check if equal to "old" one */			\
> +		"comp" #op_suffix ".ne $r62 = $r63, %[rOld]\n"		\
> +		";;\n"							\
> +		/* If different from "old", return it to caller */	\
> +		"cb.deqz $r62? 1b\n"					\
> +		";;\n"							\
> +		"2:\n"							\
> +		: "+r" (__rn), "+r" (__ro)				\
> +		: [rPtr] "r" (ptr), [rOld] "r" (old), [rNew] "r" (new)	\
> +		: "memory");						\
> +	(__ro);								\
> +})
> +
> +#define arch_cmpxchg(ptr, o, n)						\
> +({									\
> +	unsigned long __ret;						\
> +	BUILD_BUG_ON(sizeof(*(ptr)) != 4 && sizeof(*(ptr)) != 8);	\
> +	switch (sizeof(*(ptr))) {					\
> +	case 4:								\
> +		__ret = __cmpxchg((ptr), (o), (n), w, s);		\
> +		break;							\
> +	case 8:								\
> +		__ret = __cmpxchg((ptr), (o), (n), d, );		\
> +		break;							\
> +	}								\
> +	(__typeof__(*(ptr))) (__ret);					\
> +})
> +
> +/*
> + * In order to optimize xchg for 16 byte, we can use insf/extfs if we know the
> + * bounds. This way, we only take one more bundle than standard xchg.
> + * We simply do a read modify acswap on a 32 bit word.
> + */
> +#define __xchg_small_asm(ptr, new, start, stop)				\
> +({									\
> +	register unsigned long __rn asm("r62");				\
> +	register unsigned long __ro asm("r63");				\
> +	__asm__ __volatile__ (						\
> +		"fence\n"						\
> +		";;\n"							\
> +		"1:\n"							\
> +		/* Load original old value */				\
> +		"lws $r62 = 0[%[rPtr]]\n"				\
> +		";;\n"							\
> +		/* Copy read value into "expect" */			\
> +		"copyd $r63 = $r62\n"					\
> +		/* Prepare new value with insf */			\
> +		"insf $r62 = %[rNew], " #stop "," #start "\n"		\
> +		";;\n"							\
> +		/* Try compare & swap with loaded value */		\
> +		"acswapw 0[%[rPtr]], $r62r63\n"				\
> +		";;\n"							\
> +		/* Did we succeed ?, if no, try again */		\
> +		"cb.deqz $r62? 1b\n"					\
> +		/* Extract old value for ret value */			\
> +		"extfs $r63 = $r63, " #stop "," #start "\n"		\
> +		";;\n"							\
> +		: "+r" (__rn), "+r" (__ro)				\
> +		: [rPtr] "r" (ptr), [rNew] "r" (new)			\
> +		: "memory");						\
> +	(__ro);								\
> +})
> +
> +/* Needed for generic qspinlock implementation */
> +static inline unsigned long xchg_u16(volatile void *ptr, unsigned long new,
> +				     int size)
> +{
> +	int off = (unsigned long)ptr % sizeof(u32);
> +	volatile u32 *p = ptr - off;
> +
> +	/*
> +	 * GCC is smart enough to eliminate the dead branches by detecting
> +	 * the offset statically
> +	 */
> +	if (off == 0)
> +		return __xchg_small_asm(p, new, 0, 15);
> +	else
> +		return __xchg_small_asm(p, new, 16, 31);
> +}
> +
> +#define __xchg_asm(ptr, new, op_suffix, load_suffix)			\
> +({									\
> +	register unsigned long __rn asm("r62") = (unsigned long) (new);	\
> +	register unsigned long __ro asm("r63");				\
> +	__asm__ __volatile__ (						\
> +		"fence\n"						\
> +		";;\n"							\
> +		"1:\n"							\
> +		/* Load original old value */				\
> +		"l" #op_suffix #load_suffix " $r63 = 0[%[rPtr]]\n"	\
> +		";;\n"							\
> +		/* Try compare & swap with loaded value */		\
> +		"acswap" #op_suffix " 0[%[rPtr]], $r62r63\n"		\
> +		";;\n"							\
> +		/* Did we succeed ?, if no, try again */		\
> +		"cb.deqz $r62? 1b\n"					\
> +		/* $r62 has been cloberred by acswap, restore it */	\
> +		"copyd $r62 = %[rNew]\n"				\
> +		";;\n"							\
> +		: "+r" (__rn), "+r" (__ro)				\
> +		: [rPtr] "r" (ptr), [rNew] "r" (new)			\
> +		: "memory");						\
> +	(__ro);								\
> +})
> +
> +/*
> + * This function doesn't exist, so you'll get a linker error if
> + * something tries to do an invalidly-sized xchg().
> + */
> +extern unsigned long __xchg_called_with_bad_pointer(void)
> +	__compiletime_error("Bad argument size for xchg");
> +
> +static inline unsigned long __xchg(volatile void *ptr, unsigned long val,
> +				   int size)
> +{
> +	switch (size) {
> +	case 2:
> +		return xchg_u16(ptr, val, size);
> +	case 4:
> +		return __xchg_asm(ptr, val, w, s);
> +	case 8:
> +		return __xchg_asm(ptr, val, d, );
> +	}
> +	__xchg_called_with_bad_pointer();
> +
> +	return val;
> +}
> +
> +#define arch_xchg(ptr, with)						\
> +	({								\
> +		(__typeof__(*(ptr))) __xchg((ptr),			\
> +					    (unsigned long)(with),	\
> +					    sizeof(*(ptr)));		\
> +	})
> +
> +#endif
> -- 
> 2.37.2
> 
> 
> 
> 
> 
