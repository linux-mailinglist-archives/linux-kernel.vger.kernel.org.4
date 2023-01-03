Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 466A165C489
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 18:04:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238351AbjACRBG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 12:01:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238245AbjACRAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 12:00:11 -0500
Received: from fx409.security-mail.net (smtpout253.security-mail.net [46.30.205.253])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3DF913CF5
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 09:00:05 -0800 (PST)
Received: from localhost (fx409.security-mail.net [127.0.0.1])
        by fx409.security-mail.net (Postfix) with ESMTP id F1F60349891
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 17:44:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalray.eu;
        s=sec-sig-email; t=1672764273;
        bh=jUHjYOhyrYCUbEm+VR8OYdUWk6B/jIcLyB2A1JdBO34=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=BP+MWc+qKjg/rBKUi7zSh5t0e6g8+7QKGEAOe/BuyNw+/T7hf4RVhsKaXG4grKr3+
         4seCHrkwRJLkO9O81lb99dYDuLCEIQ662YQVz/E+nQxS1UfHdFufXB6BTejjO7ee5D
         SSdkNj5eUg0ZgGkV+xn6m29QEthij9yoCF9VVga4=
Received: from fx409 (fx409.security-mail.net [127.0.0.1]) by
 fx409.security-mail.net (Postfix) with ESMTP id 858033497A5; Tue,  3 Jan
 2023 17:44:32 +0100 (CET)
Received: from zimbra2.kalray.eu (unknown [217.181.231.53]) by
 fx409.security-mail.net (Postfix) with ESMTPS id B092334962A; Tue,  3 Jan
 2023 17:44:31 +0100 (CET)
Received: from zimbra2.kalray.eu (localhost [127.0.0.1]) by
 zimbra2.kalray.eu (Postfix) with ESMTPS id 76CC127E03F4; Tue,  3 Jan 2023
 17:44:31 +0100 (CET)
Received: from localhost (localhost [127.0.0.1]) by zimbra2.kalray.eu
 (Postfix) with ESMTP id 39D3727E0401; Tue,  3 Jan 2023 17:44:31 +0100 (CET)
Received: from zimbra2.kalray.eu ([127.0.0.1]) by localhost
 (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10026) with ESMTP id
 cR9EOqemCNkN; Tue,  3 Jan 2023 17:44:31 +0100 (CET)
Received: from junon.lin.mbt.kalray.eu (unknown [192.168.37.161]) by
 zimbra2.kalray.eu (Postfix) with ESMTPSA id 1154D27E03F4; Tue,  3 Jan 2023
 17:44:31 +0100 (CET)
X-Virus-Scanned: E-securemail
Secumail-id: <117be.63b45b6f.ae1c9.0>
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra2.kalray.eu 39D3727E0401
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalray.eu;
 s=32AE1B44-9502-11E5-BA35-3734643DEF29; t=1672764271;
 bh=/t2gS4eaeImmTDnVmtv07mt1x1AaQ3f6rnoIVIG42fk=;
 h=From:To:Date:Message-Id:MIME-Version;
 b=As3QRekIenaBULRuHV1xV16oQNq9ZNoC2IrD6FX3BtVekXo/7Yr0men2j82ghXLII
 3/fu4kEeNXtvWjgae1xJK2kpEdFit473WjUs//kZK+VEc7CZTeOruDZLSGD5su4RQe
 H8f6/YoYftK7cF3Y4lDczfLBzj75Lr6Ahl1HxVyg=
From:   Yann Sionneau <ysionneau@kalray.eu>
Cc:     Yann Sionneau <ysionneau@kalray.eu>, Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org,
        Clement Leger <clement.leger@bootlin.com>,
        Jules Maselbas <jmaselbas@kalray.eu>,
        Julian Vetter <jvetter@kalray.eu>,
        Julien Villette <jvillette@kalray.eu>
Subject: [RFC PATCH 05/25] kvx: Add atomic/locking headers
Date:   Tue,  3 Jan 2023 17:43:39 +0100
Message-ID: <20230103164359.24347-6-ysionneau@kalray.eu>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230103164359.24347-1-ysionneau@kalray.eu>
References: <20230103164359.24347-1-ysionneau@kalray.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8
X-ALTERMIMEV2_out: done
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add common headers (atomic, bitops, barrier and locking) for basic
kvx support.

CC: Will Deacon <will@kernel.org>
CC: Peter Zijlstra <peterz@infradead.org>
CC: Boqun Feng <boqun.feng@gmail.com>
CC: Mark Rutland <mark.rutland@arm.com>
CC: linux-kernel@vger.kernel.org
Co-developed-by: Clement Leger <clement.leger@bootlin.com>
Signed-off-by: Clement Leger <clement.leger@bootlin.com>
Co-developed-by: Jules Maselbas <jmaselbas@kalray.eu>
Signed-off-by: Jules Maselbas <jmaselbas@kalray.eu>
Co-developed-by: Julian Vetter <jvetter@kalray.eu>
Signed-off-by: Julian Vetter <jvetter@kalray.eu>
Co-developed-by: Julien Villette <jvillette@kalray.eu>
Signed-off-by: Julien Villette <jvillette@kalray.eu>
Co-developed-by: Yann Sionneau <ysionneau@kalray.eu>
Signed-off-by: Yann Sionneau <ysionneau@kalray.eu>
---
 arch/kvx/include/asm/atomic.h  | 104 +++++++++++++++++
 arch/kvx/include/asm/barrier.h |  15 +++
 arch/kvx/include/asm/bitops.h  | 207 +++++++++++++++++++++++++++++++++
 arch/kvx/include/asm/bitrev.h  |  32 +++++
 arch/kvx/include/asm/cmpxchg.h | 185 +++++++++++++++++++++++++++++
 5 files changed, 543 insertions(+)
 create mode 100644 arch/kvx/include/asm/atomic.h
 create mode 100644 arch/kvx/include/asm/barrier.h
 create mode 100644 arch/kvx/include/asm/bitops.h
 create mode 100644 arch/kvx/include/asm/bitrev.h
 create mode 100644 arch/kvx/include/asm/cmpxchg.h

diff --git a/arch/kvx/include/asm/atomic.h b/arch/kvx/include/asm/atomic.h
new file mode 100644
index 000000000000..eb8acbcbc70d
--- /dev/null
+++ b/arch/kvx/include/asm/atomic.h
@@ -0,0 +1,104 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ */
+
+#ifndef _ASM_KVX_ATOMIC_H
+#define _ASM_KVX_ATOMIC_H
+
+#include <linux/types.h>
+
+#include <asm/cmpxchg.h>
+
+#define ATOMIC64_INIT(i)     { (i) }
+
+#define arch_atomic64_cmpxchg(v, old, new) (arch_cmpxchg(&((v)->counter), old, new))
+#define arch_atomic64_xchg(v, new) (arch_xchg(&((v)->counter), new))
+
+static inline long arch_atomic64_read(const atomic64_t *v)
+{
+	return v->counter;
+}
+
+static inline void arch_atomic64_set(atomic64_t *v, long i)
+{
+	v->counter = i;
+}
+
+#define ATOMIC64_RETURN_OP(op, c_op)					\
+static inline long arch_atomic64_##op##_return(long i, atomic64_t *v)	\
+{									\
+	long new, old, ret;						\
+									\
+	do {								\
+		old = v->counter;					\
+		new = old c_op i;					\
+		ret = arch_cmpxchg(&v->counter, old, new);		\
+	} while (ret != old);						\
+									\
+	return new;							\
+}
+
+#define ATOMIC64_OP(op, c_op)						\
+static inline void arch_atomic64_##op(long i, atomic64_t *v)		\
+{									\
+	long new, old, ret;						\
+									\
+	do {								\
+		old = v->counter;					\
+		new = old c_op i;					\
+		ret = arch_cmpxchg(&v->counter, old, new);		\
+	} while (ret != old);						\
+}
+
+#define ATOMIC64_FETCH_OP(op, c_op)					\
+static inline long arch_atomic64_fetch_##op(long i, atomic64_t *v)	\
+{									\
+	long new, old, ret;						\
+									\
+	do {								\
+		old = v->counter;					\
+		new = old c_op i;					\
+		ret = arch_cmpxchg(&v->counter, old, new);		\
+	} while (ret != old);						\
+									\
+	return old;							\
+}
+
+#define ATOMIC64_OPS(op, c_op)						\
+	ATOMIC64_OP(op, c_op)						\
+	ATOMIC64_RETURN_OP(op, c_op)					\
+	ATOMIC64_FETCH_OP(op, c_op)
+
+ATOMIC64_OPS(and, &)
+ATOMIC64_OPS(or, |)
+ATOMIC64_OPS(xor, ^)
+ATOMIC64_OPS(add, +)
+ATOMIC64_OPS(sub, -)
+
+#undef ATOMIC64_OPS
+#undef ATOMIC64_FETCH_OP
+#undef ATOMIC64_OP
+
+static inline int arch_atomic_add_return(int i, atomic_t *v)
+{
+	int new, old, ret;
+
+	do {
+		old = v->counter;
+		new = old + i;
+		ret = arch_cmpxchg(&v->counter, old, new);
+	} while (ret != old);
+
+	return new;
+}
+
+static inline int arch_atomic_sub_return(int i, atomic_t *v)
+{
+	return arch_atomic_add_return(-i, v);
+}
+
+#include <asm-generic/atomic.h>
+
+#endif	/* _ASM_KVX_ATOMIC_H */
diff --git a/arch/kvx/include/asm/barrier.h b/arch/kvx/include/asm/barrier.h
new file mode 100644
index 000000000000..371f1c70746d
--- /dev/null
+++ b/arch/kvx/include/asm/barrier.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ */
+
+#ifndef _ASM_KVX_BARRIER_H
+#define _ASM_KVX_BARRIER_H
+
+/* fence is sufficient to guarantee write ordering */
+#define mb()	__builtin_kvx_fence()
+
+#include <asm-generic/barrier.h>
+
+#endif /* _ASM_KVX_BARRIER_H */
diff --git a/arch/kvx/include/asm/bitops.h b/arch/kvx/include/asm/bitops.h
new file mode 100644
index 000000000000..03b861169ce8
--- /dev/null
+++ b/arch/kvx/include/asm/bitops.h
@@ -0,0 +1,207 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ *            Yann Sionneau
+ */
+
+#ifndef _ASM_KVX_BITOPS_H
+#define _ASM_KVX_BITOPS_H
+
+#ifdef __KERNEL__
+
+#ifndef _LINUX_BITOPS_H
+#error only <linux/bitops.h> can be included directly
+#endif
+
+#include <asm/cmpxchg.h>
+
+static inline unsigned long __ffs(unsigned long word);
+
+#include <asm-generic/bitops/const_hweight.h>
+#include <asm-generic/bitops/ffz.h>
+#include <asm-generic/bitops/non-atomic.h>
+#include <asm-generic/bitops/lock.h>
+#include <asm-generic/bitops/sched.h>
+
+static inline int fls(int x)
+{
+	return 32 - __builtin_kvx_clzw(x);
+}
+
+static inline int fls64(__u64 x)
+{
+	return 64 - __builtin_kvx_clzd(x);
+}
+
+/**
+ * __ffs - find first set bit in word
+ * @word: The word to search
+ *
+ * Undefined if no set bit exists, so code should check against 0 first.
+ */
+static inline unsigned long __ffs(unsigned long word)
+{
+	return __builtin_kvx_ctzd(word);
+}
+
+/**
+ * __fls - find last set bit in word
+ * @word: The word to search
+ *
+ * Undefined if no set bit exists, so code should check against 0 first.
+ */
+static inline unsigned long __fls(unsigned long word)
+{
+	return 63 - __builtin_kvx_clzd(word);
+}
+
+
+/**
+ * ffs - find first set bit in word
+ * @x: the word to search
+ *
+ * This is defined the same way as the libc and compiler builtin ffs
+ * routines, therefore differs in spirit from the other bitops.
+ *
+ * ffs(value) returns 0 if value is 0 or the position of the first
+ * set bit if value is nonzero. The first (least significant) bit
+ * is at position 1.
+ */
+static inline int ffs(int x)
+{
+	if (!x)
+		return 0;
+	return __builtin_kvx_ctzw(x) + 1;
+}
+
+
+static inline unsigned int __arch_hweight32(unsigned int w)
+{
+	unsigned int count;
+
+	asm volatile ("cbsw %0 = %1\n\t;;"
+	: "=r" (count)
+	: "r" (w));
+
+	return count;
+}
+
+static inline unsigned int __arch_hweight64(__u64 w)
+{
+	unsigned int count;
+
+	asm volatile ("cbsd %0 = %1\n\t;;"
+	: "=r" (count)
+	: "r" (w));
+
+	return count;
+}
+
+static inline unsigned int __arch_hweight16(unsigned int w)
+{
+	return __arch_hweight32(w & 0xffff);
+}
+
+static inline unsigned int __arch_hweight8(unsigned int w)
+{
+	return __arch_hweight32(w & 0xff);
+}
+
+
+/* Bitmask modifiers */
+#define __NOP(x)	(x)
+#define __NOT(x)	(~(x))
+
+
+#define __test_and_op_bit(nr, addr, op, mod)				\
+({									\
+	unsigned long __mask = BIT_MASK(nr);				\
+	unsigned long __new, __old, __ret;				\
+	do {								\
+		__old = *(&addr[BIT_WORD(nr)]);				\
+		__new = __old op mod(__mask);				\
+		__ret = cmpxchg(addr, __old, __new);			\
+	} while (__ret != __old);					\
+	(__old & __mask);						\
+})
+
+/**
+ * test_and_set_bit - Set a bit and return its old value
+ * @nr: Bit to set
+ * @addr: Address to count from
+ *
+ * This operation may be reordered on other architectures than x86.
+ */
+static inline int test_and_set_bit(int nr, volatile unsigned long *addr)
+{
+	return __test_and_op_bit(nr, addr, |, __NOP) != 0;
+}
+
+/**
+ * test_and_clear_bit - Clear a bit and return its old value
+ * @nr: Bit to clear
+ * @addr: Address to count from
+ *
+ * This operation can be reordered on other architectures other than x86.
+ */
+static inline int test_and_clear_bit(int nr, volatile unsigned long *addr)
+{
+	return __test_and_op_bit(nr, addr, &, __NOT);
+}
+
+#define __atomic_op(nr, addr, op, mod)					\
+({									\
+	unsigned long __new, __old, __ret;				\
+	__ret = addr[BIT_WORD(nr)];					\
+	do {								\
+		__old = __ret;						\
+		__new = __old op mod(BIT_MASK(nr));			\
+		__ret = cmpxchg(&addr[BIT_WORD(nr)], __old, __new);	\
+	} while (__ret != __old);					\
+})
+
+/**
+ * set_bit - Atomically set a bit in memory
+ * @nr: the bit to set
+ * @addr: the address to start counting from
+ *
+ * Note that @nr may be almost arbitrarily large; this function is not
+ * restricted to acting on a single-word quantity.
+ */
+static inline void set_bit(int nr, volatile unsigned long *addr)
+{
+	__atomic_op(nr, addr, |, __NOP);
+}
+
+/**
+ * clear_bit - Clears a bit in memory
+ * @nr: Bit to clear
+ * @addr: Address to start counting from
+ */
+static inline void clear_bit(int nr, volatile unsigned long *addr)
+{
+	__atomic_op(nr, addr, &, __NOT);
+}
+
+/**
+ * change_bit - Toggle a bit in memory
+ * @nr: Bit to change
+ * @addr: Address to start counting from
+ *
+ * Note that @nr may be almost arbitrarily large; this function is not
+ * restricted to acting on a single-word quantity.
+ */
+static inline void change_bit(int nr, volatile unsigned long *addr)
+{
+	__atomic_op(nr, addr, ^, __NOP);
+}
+
+#include <asm-generic/bitops/lock.h>
+#include <asm-generic/bitops/non-atomic.h>
+#include <asm-generic/bitops/le.h>
+#include <asm-generic/bitops/ext2-atomic.h>
+
+#endif
+
+#endif
diff --git a/arch/kvx/include/asm/bitrev.h b/arch/kvx/include/asm/bitrev.h
new file mode 100644
index 000000000000..79865081905a
--- /dev/null
+++ b/arch/kvx/include/asm/bitrev.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ */
+
+#ifndef _ASM_KVX_BITREV_H
+#define _ASM_KVX_BITREV_H
+
+#include <linux/swab.h>
+
+/* Bit reversal constant for matrix multiply */
+#define BIT_REVERSE 0x0102040810204080ULL
+
+static __always_inline __attribute_const__ u32 __arch_bitrev32(u32 x)
+{
+	/* Reverse all bits for each bytes and then byte-reverse the 32 LSB */
+	return swab32(__builtin_kvx_sbmm8(BIT_REVERSE, x));
+}
+
+static __always_inline __attribute_const__ u16 __arch_bitrev16(u16 x)
+{
+	/* Reverse all bits for each bytes and then byte-reverse the 16 LSB */
+	return swab16(__builtin_kvx_sbmm8(BIT_REVERSE, x));
+}
+
+static __always_inline __attribute_const__ u8 __arch_bitrev8(u8 x)
+{
+	return __builtin_kvx_sbmm8(BIT_REVERSE, x);
+}
+
+#endif
diff --git a/arch/kvx/include/asm/cmpxchg.h b/arch/kvx/include/asm/cmpxchg.h
new file mode 100644
index 000000000000..b1d128b060a2
--- /dev/null
+++ b/arch/kvx/include/asm/cmpxchg.h
@@ -0,0 +1,185 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ *            Yann Sionneau
+ */
+
+#ifndef _ASM_KVX_CMPXCHG_H
+#define _ASM_KVX_CMPXCHG_H
+
+#include <linux/bits.h>
+#include <linux/types.h>
+#include <linux/build_bug.h>
+
+/*
+ * On kvx, we have a boolean compare and swap which means that the operation
+ * returns only the success of operation.
+ * If operation succeed, this is simple, we just need to return the provided
+ * old value. However, if it fails, we need to load the value to return it for
+ * the caller. If the loaded value is different from the "old" provided by the
+ * caller, we can return it since it will means it failed.
+ * However, if for some reason the value we read is equal to the old value
+ * provided by the caller, we can't simply return it or the caller will think it
+ * succeeded. So if the value we read is the same as the "old" provided by
+ * the caller, we try again until either we succeed or we fail with a different
+ * value than the provided one.
+ */
+#define __cmpxchg(ptr, old, new, op_suffix, load_suffix)		\
+({									\
+	register unsigned long __rn asm("r62");				\
+	register unsigned long __ro asm("r63");				\
+	__asm__ __volatile__ (						\
+		/* Fence to guarantee previous store to be committed */	\
+		"fence\n"						\
+		/* Init "expect" with previous value */			\
+		"copyd $r63 = %[rOld]\n"				\
+		";;\n"							\
+		"1:\n"							\
+		/* Init "update" value with new */			\
+		"copyd $r62 = %[rNew]\n"				\
+		";;\n"							\
+		"acswap" #op_suffix " 0[%[rPtr]], $r62r63\n"		\
+		";;\n"							\
+		/* if acswap succeed, simply return */			\
+		"cb.dnez $r62? 2f\n"					\
+		";;\n"							\
+		/* We failed, load old value */				\
+		"l"  #op_suffix  #load_suffix" $r63 = 0[%[rPtr]]\n"	\
+		";;\n"							\
+		/* Check if equal to "old" one */			\
+		"comp" #op_suffix ".ne $r62 = $r63, %[rOld]\n"		\
+		";;\n"							\
+		/* If different from "old", return it to caller */	\
+		"cb.deqz $r62? 1b\n"					\
+		";;\n"							\
+		"2:\n"							\
+		: "+r" (__rn), "+r" (__ro)				\
+		: [rPtr] "r" (ptr), [rOld] "r" (old), [rNew] "r" (new)	\
+		: "memory");						\
+	(__ro);								\
+})
+
+#define arch_cmpxchg(ptr, o, n)						\
+({									\
+	unsigned long __ret;						\
+	BUILD_BUG_ON(sizeof(*(ptr)) != 4 && sizeof(*(ptr)) != 8);	\
+	switch (sizeof(*(ptr))) {					\
+	case 4:								\
+		__ret = __cmpxchg((ptr), (o), (n), w, s);		\
+		break;							\
+	case 8:								\
+		__ret = __cmpxchg((ptr), (o), (n), d, );		\
+		break;							\
+	}								\
+	(__typeof__(*(ptr))) (__ret);					\
+})
+
+/*
+ * In order to optimize xchg for 16 byte, we can use insf/extfs if we know the
+ * bounds. This way, we only take one more bundle than standard xchg.
+ * We simply do a read modify acswap on a 32 bit word.
+ */
+#define __xchg_small_asm(ptr, new, start, stop)				\
+({									\
+	register unsigned long __rn asm("r62");				\
+	register unsigned long __ro asm("r63");				\
+	__asm__ __volatile__ (						\
+		"fence\n"						\
+		";;\n"							\
+		"1:\n"							\
+		/* Load original old value */				\
+		"lws $r62 = 0[%[rPtr]]\n"				\
+		";;\n"							\
+		/* Copy read value into "expect" */			\
+		"copyd $r63 = $r62\n"					\
+		/* Prepare new value with insf */			\
+		"insf $r62 = %[rNew], " #stop "," #start "\n"		\
+		";;\n"							\
+		/* Try compare & swap with loaded value */		\
+		"acswapw 0[%[rPtr]], $r62r63\n"				\
+		";;\n"							\
+		/* Did we succeed ?, if no, try again */		\
+		"cb.deqz $r62? 1b\n"					\
+		/* Extract old value for ret value */			\
+		"extfs $r63 = $r63, " #stop "," #start "\n"		\
+		";;\n"							\
+		: "+r" (__rn), "+r" (__ro)				\
+		: [rPtr] "r" (ptr), [rNew] "r" (new)			\
+		: "memory");						\
+	(__ro);								\
+})
+
+/* Needed for generic qspinlock implementation */
+static inline unsigned long xchg_u16(volatile void *ptr, unsigned long new,
+				     int size)
+{
+	int off = (unsigned long)ptr % sizeof(u32);
+	volatile u32 *p = ptr - off;
+
+	/*
+	 * GCC is smart enough to eliminate the dead branches by detecting
+	 * the offset statically
+	 */
+	if (off == 0)
+		return __xchg_small_asm(p, new, 0, 15);
+	else
+		return __xchg_small_asm(p, new, 16, 31);
+}
+
+#define __xchg_asm(ptr, new, op_suffix, load_suffix)			\
+({									\
+	register unsigned long __rn asm("r62") = (unsigned long) (new);	\
+	register unsigned long __ro asm("r63");				\
+	__asm__ __volatile__ (						\
+		"fence\n"						\
+		";;\n"							\
+		"1:\n"							\
+		/* Load original old value */				\
+		"l" #op_suffix #load_suffix " $r63 = 0[%[rPtr]]\n"	\
+		";;\n"							\
+		/* Try compare & swap with loaded value */		\
+		"acswap" #op_suffix " 0[%[rPtr]], $r62r63\n"		\
+		";;\n"							\
+		/* Did we succeed ?, if no, try again */		\
+		"cb.deqz $r62? 1b\n"					\
+		/* $r62 has been cloberred by acswap, restore it */	\
+		"copyd $r62 = %[rNew]\n"				\
+		";;\n"							\
+		: "+r" (__rn), "+r" (__ro)				\
+		: [rPtr] "r" (ptr), [rNew] "r" (new)			\
+		: "memory");						\
+	(__ro);								\
+})
+
+/*
+ * This function doesn't exist, so you'll get a linker error if
+ * something tries to do an invalidly-sized xchg().
+ */
+extern unsigned long __xchg_called_with_bad_pointer(void)
+	__compiletime_error("Bad argument size for xchg");
+
+static inline unsigned long __xchg(volatile void *ptr, unsigned long val,
+				   int size)
+{
+	switch (size) {
+	case 2:
+		return xchg_u16(ptr, val, size);
+	case 4:
+		return __xchg_asm(ptr, val, w, s);
+	case 8:
+		return __xchg_asm(ptr, val, d, );
+	}
+	__xchg_called_with_bad_pointer();
+
+	return val;
+}
+
+#define arch_xchg(ptr, with)						\
+	({								\
+		(__typeof__(*(ptr))) __xchg((ptr),			\
+					    (unsigned long)(with),	\
+					    sizeof(*(ptr)));		\
+	})
+
+#endif
-- 
2.37.2





