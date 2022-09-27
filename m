Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB9C55ECF0E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 23:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232676AbiI0VDE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 17:03:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbiI0VC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 17:02:59 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD7EE78BD6
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 14:02:56 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id v17-20020a259d91000000b006b4c31c0640so9574752ybp.18
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 14:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=FiUQwbw/K3PWDajAgxyDvdNkiQcWFYTMqZWiwI919S8=;
        b=lwqmRRqO39oklD0EjVFaIblRb5yr8EHZ4w17UBJ9TCozFbx5UIN9HWmkM58sbrilgY
         nYhZF5QNbLcxTQj1DSNX/yC0h+b/DBHCRa9s8G2VBWwF24ue3PxwGFlVkm+CNK/ldkSH
         tirvWES6q/Agbx58Gs0Dmzkh0iONaY/E0gH4eeyR62MId85kQNmA98qSyBmcqNsocHIb
         D78AIPs5W6Lw47O7GvjfqvtRRabddJpwu1KZaSauImp9njKyG7NT6pbJmzfcPEUTC2Gr
         BCqhqFl83+qJFYtqtFLJYh7rgFvV23W7Fy/L3N15vhOWt4qhkVxbOrshHb0AhVagcHpF
         4xaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=FiUQwbw/K3PWDajAgxyDvdNkiQcWFYTMqZWiwI919S8=;
        b=gdULwisAkOgjqqjjF52Km3Rfi1BmidnYSPLOnlvXoKW0f5Zr9tGZNgahttDmHDiCZ7
         7eH+XsYr5yh2mKA+rcSw1fBIu1O1t+nUSBeqf3uorGzvL3qXkbjILHavU3g+TY7iwRnC
         ci0nzawyRPsUz4PiQE7HFDvaYb9Zs+XG1nUFY+pNvNjDmOMlsUs0cQ674XZzVYUD4Gui
         TlZqjR1ayfkNN7pySdVwTU/c3i+aATl9NwGdOw+FzhesfzXOMkp620T9SShl/JW0WksX
         MxdYVVd1WZfsXgNVzRp6EkvZG0yD9D7sX3mE/g1xSUWgBRiWlzQyBxw2ygQb7kivRqbV
         Z9NA==
X-Gm-Message-State: ACrzQf02VtBAV5U7GGNwfOW+ywbDmM+P6WIm6lJYTS9EQJA6Z59TOKA9
        WL2yWW3dOeBzLmDA2rV2QKWokjxTn/sYmntqIMg=
X-Google-Smtp-Source: AMsMyM7uXko43YDq4oJb+NcL+0b9zkeN3AYMYNEs0PfjglCk4TMxi/imeb7qZMnLEle5iCqk7gZ2YXlhf8Nhjeo/M9w=
X-Received: from ndesaulniers-desktop.svl.corp.google.com ([2620:0:100e:712:5d88:f716:dcf7:513])
 (user=ndesaulniers job=sendgmr) by 2002:a25:b790:0:b0:66f:7978:f166 with SMTP
 id n16-20020a25b790000000b0066f7978f166mr26994725ybh.17.1664312575961; Tue,
 27 Sep 2022 14:02:55 -0700 (PDT)
Date:   Tue, 27 Sep 2022 14:02:48 -0700
In-Reply-To: <202209271333.10AE3E1D@keescook>
Mime-Version: 1.0
References: <202209271333.10AE3E1D@keescook>
X-Developer-Key: i=ndesaulniers@google.com; a=ed25519; pk=UIrHvErwpgNbhCkRZAYSX0CFd/XFEwqX3D0xqtqjNug=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1664312568; l=11508;
 i=ndesaulniers@google.com; s=20220923; h=from:subject; bh=E9dqHqgrx4iCHolRjiLF7r4lhsWqQ1o4NbALhoV2fj8=;
 b=dvwxNwKx9zrqPIEQoHKhRtc+EmFQjAJl+5xWnG+GKPTcpGJSE53xmVUJsmaMZuvh47jR0B9qlyeC
 El5GKCNFBiTEqy8Xo5q9eoQP56fvnnV+/JqunREGeMriiQv3RtZJ
X-Mailer: git-send-email 2.37.3.998.g577e59143f-goog
Message-ID: <20220927210248.3950201-1-ndesaulniers@google.com>
Subject: [PATCH v3] x86, mem: move memmove to out of line assembler
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        llvm@lists.linux.dev, Andy Lutomirski <luto@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building ARCH=i386 with CONFIG_LTO_CLANG_FULL=y, it's possible
(depending on additional configs which I have not been able to isolate)
to observe a failure during register allocation:

  error: inline assembly requires more registers than available

when memmove is inlined into tcp_v4_fill_cb() or tcp_v6_fill_cb().

memmove is quite large and probably shouldn't be inlined due to size
alone. A noinline function attribute would be the simplest fix, but
there's a few things that stand out with the current definition:

In addition to having complex constraints that can't always be resolved,
the clobber list seems to be missing %bx and %dx, and possibly %cl. By
using numbered operands rather than symbolic operands, the constraints
are quite obnoxious to refactor.

Having a large function be 99% inline asm is a code smell that this
function should simply be written in stand-alone out-of-line assembler.
That gives the opportunity for other cleanups like fixing the
inconsistent use of tabs vs spaces and instruction suffixes, and the
label 3 appearing twice.  Symbolic operands and local labels would
provide this code with a fresh coat of paint.

Moving this to out of line assembler guarantees that the
compiler cannot inline calls to memmove.

This has been done previously for 64b:
commit 9599ec0471de ("x86-64, mem: Convert memmove() to assembly file
and fix return value bug")

Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
Changes v2 -> v3:
* Fix bug I introduced in v1 when I changed one of temp register
  operands for one of the two instructions performing a mem to mem swap,
  but not the other instruction's operand, and discovered by Kees.
  Verified KUnit memcpy tests are passing via:
  $ ./tools/testing/kunit/kunit.py run --arch=i386 --make_options LLVM=1
  $ ./tools/testing/kunit/kunit.py run --arch=i386
  Fixed by using symbolic identifiers rather than open coded registers
  for the less-than-word-size temporary registers.
* Expand the comment about callee saved registers on i386 with a
  reference to the psABI.

Changes v1 -> v2:
* Add reference to 9599ec0471de in commit message.
* Include asm/export.h then make sure to EXPORT_SYMBOL(memmove).

 arch/x86/lib/Makefile     |   1 +
 arch/x86/lib/memcpy_32.c  | 187 ---------------------------------
 arch/x86/lib/memmove_32.S | 215 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 216 insertions(+), 187 deletions(-)
 create mode 100644 arch/x86/lib/memmove_32.S

diff --git a/arch/x86/lib/Makefile b/arch/x86/lib/Makefile
index f76747862bd2..9a0b8ed782e2 100644
--- a/arch/x86/lib/Makefile
+++ b/arch/x86/lib/Makefile
@@ -60,6 +60,7 @@ ifeq ($(CONFIG_X86_32),y)
         lib-y += checksum_32.o
         lib-y += strstr_32.o
         lib-y += string_32.o
+        lib-y += memmove_32.o
 ifneq ($(CONFIG_X86_CMPXCHG64),y)
         lib-y += cmpxchg8b_emu.o atomic64_386_32.o
 endif
diff --git a/arch/x86/lib/memcpy_32.c b/arch/x86/lib/memcpy_32.c
index ef3af7ff2c8a..a29b64befb93 100644
--- a/arch/x86/lib/memcpy_32.c
+++ b/arch/x86/lib/memcpy_32.c
@@ -17,190 +17,3 @@ __visible void *memset(void *s, int c, size_t count)
 	return __memset(s, c, count);
 }
 EXPORT_SYMBOL(memset);
-
-__visible void *memmove(void *dest, const void *src, size_t n)
-{
-	int d0,d1,d2,d3,d4,d5;
-	char *ret = dest;
-
-	__asm__ __volatile__(
-		/* Handle more 16 bytes in loop */
-		"cmp $0x10, %0\n\t"
-		"jb	1f\n\t"
-
-		/* Decide forward/backward copy mode */
-		"cmp %2, %1\n\t"
-		"jb	2f\n\t"
-
-		/*
-		 * movs instruction have many startup latency
-		 * so we handle small size by general register.
-		 */
-		"cmp  $680, %0\n\t"
-		"jb 3f\n\t"
-		/*
-		 * movs instruction is only good for aligned case.
-		 */
-		"mov %1, %3\n\t"
-		"xor %2, %3\n\t"
-		"and $0xff, %3\n\t"
-		"jz 4f\n\t"
-		"3:\n\t"
-		"sub $0x10, %0\n\t"
-
-		/*
-		 * We gobble 16 bytes forward in each loop.
-		 */
-		"3:\n\t"
-		"sub $0x10, %0\n\t"
-		"mov 0*4(%1), %3\n\t"
-		"mov 1*4(%1), %4\n\t"
-		"mov  %3, 0*4(%2)\n\t"
-		"mov  %4, 1*4(%2)\n\t"
-		"mov 2*4(%1), %3\n\t"
-		"mov 3*4(%1), %4\n\t"
-		"mov  %3, 2*4(%2)\n\t"
-		"mov  %4, 3*4(%2)\n\t"
-		"lea  0x10(%1), %1\n\t"
-		"lea  0x10(%2), %2\n\t"
-		"jae 3b\n\t"
-		"add $0x10, %0\n\t"
-		"jmp 1f\n\t"
-
-		/*
-		 * Handle data forward by movs.
-		 */
-		".p2align 4\n\t"
-		"4:\n\t"
-		"mov -4(%1, %0), %3\n\t"
-		"lea -4(%2, %0), %4\n\t"
-		"shr $2, %0\n\t"
-		"rep movsl\n\t"
-		"mov %3, (%4)\n\t"
-		"jmp 11f\n\t"
-		/*
-		 * Handle data backward by movs.
-		 */
-		".p2align 4\n\t"
-		"6:\n\t"
-		"mov (%1), %3\n\t"
-		"mov %2, %4\n\t"
-		"lea -4(%1, %0), %1\n\t"
-		"lea -4(%2, %0), %2\n\t"
-		"shr $2, %0\n\t"
-		"std\n\t"
-		"rep movsl\n\t"
-		"mov %3,(%4)\n\t"
-		"cld\n\t"
-		"jmp 11f\n\t"
-
-		/*
-		 * Start to prepare for backward copy.
-		 */
-		".p2align 4\n\t"
-		"2:\n\t"
-		"cmp  $680, %0\n\t"
-		"jb 5f\n\t"
-		"mov %1, %3\n\t"
-		"xor %2, %3\n\t"
-		"and $0xff, %3\n\t"
-		"jz 6b\n\t"
-
-		/*
-		 * Calculate copy position to tail.
-		 */
-		"5:\n\t"
-		"add %0, %1\n\t"
-		"add %0, %2\n\t"
-		"sub $0x10, %0\n\t"
-
-		/*
-		 * We gobble 16 bytes backward in each loop.
-		 */
-		"7:\n\t"
-		"sub $0x10, %0\n\t"
-
-		"mov -1*4(%1), %3\n\t"
-		"mov -2*4(%1), %4\n\t"
-		"mov  %3, -1*4(%2)\n\t"
-		"mov  %4, -2*4(%2)\n\t"
-		"mov -3*4(%1), %3\n\t"
-		"mov -4*4(%1), %4\n\t"
-		"mov  %3, -3*4(%2)\n\t"
-		"mov  %4, -4*4(%2)\n\t"
-		"lea  -0x10(%1), %1\n\t"
-		"lea  -0x10(%2), %2\n\t"
-		"jae 7b\n\t"
-		/*
-		 * Calculate copy position to head.
-		 */
-		"add $0x10, %0\n\t"
-		"sub %0, %1\n\t"
-		"sub %0, %2\n\t"
-
-		/*
-		 * Move data from 8 bytes to 15 bytes.
-		 */
-		".p2align 4\n\t"
-		"1:\n\t"
-		"cmp $8, %0\n\t"
-		"jb 8f\n\t"
-		"mov 0*4(%1), %3\n\t"
-		"mov 1*4(%1), %4\n\t"
-		"mov -2*4(%1, %0), %5\n\t"
-		"mov -1*4(%1, %0), %1\n\t"
-
-		"mov  %3, 0*4(%2)\n\t"
-		"mov  %4, 1*4(%2)\n\t"
-		"mov  %5, -2*4(%2, %0)\n\t"
-		"mov  %1, -1*4(%2, %0)\n\t"
-		"jmp 11f\n\t"
-
-		/*
-		 * Move data from 4 bytes to 7 bytes.
-		 */
-		".p2align 4\n\t"
-		"8:\n\t"
-		"cmp $4, %0\n\t"
-		"jb 9f\n\t"
-		"mov 0*4(%1), %3\n\t"
-		"mov -1*4(%1, %0), %4\n\t"
-		"mov  %3, 0*4(%2)\n\t"
-		"mov  %4, -1*4(%2, %0)\n\t"
-		"jmp 11f\n\t"
-
-		/*
-		 * Move data from 2 bytes to 3 bytes.
-		 */
-		".p2align 4\n\t"
-		"9:\n\t"
-		"cmp $2, %0\n\t"
-		"jb 10f\n\t"
-		"movw 0*2(%1), %%dx\n\t"
-		"movw -1*2(%1, %0), %%bx\n\t"
-		"movw %%dx, 0*2(%2)\n\t"
-		"movw %%bx, -1*2(%2, %0)\n\t"
-		"jmp 11f\n\t"
-
-		/*
-		 * Move data for 1 byte.
-		 */
-		".p2align 4\n\t"
-		"10:\n\t"
-		"cmp $1, %0\n\t"
-		"jb 11f\n\t"
-		"movb (%1), %%cl\n\t"
-		"movb %%cl, (%2)\n\t"
-		".p2align 4\n\t"
-		"11:"
-		: "=&c" (d0), "=&S" (d1), "=&D" (d2),
-		  "=r" (d3),"=r" (d4), "=r"(d5)
-		:"0" (n),
-		 "1" (src),
-		 "2" (dest)
-		:"memory");
-
-	return ret;
-
-}
-EXPORT_SYMBOL(memmove);
diff --git a/arch/x86/lib/memmove_32.S b/arch/x86/lib/memmove_32.S
new file mode 100644
index 000000000000..146664b7eb92
--- /dev/null
+++ b/arch/x86/lib/memmove_32.S
@@ -0,0 +1,215 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#include <linux/linkage.h>
+#include <asm/export.h>
+
+SYM_FUNC_START(memmove)
+/*
+ * void *memmove(void *dest, const void *src, size_t n)
+ * -mregparm=3 passes these in registers:
+ */
+.set dest, %eax
+.set src, %edx
+.set n, %ecx
+
+/*
+ * Need 3 scratch registers. These need to be saved+restored. Section 3.2.1
+ * Footnote 7 of the System V Application Binary Interface Version 1.0 aka
+ * "psABI" notes:
+ *   Note that in contrast to the Intel386 ABI, %rdi, and %rsi belong to the
+ *   called function, not the caller.
+ * i.e. %edi and %esi are callee saved for i386 (because they belong to the
+ * caller).
+ */
+.set tmp0, %edi
+.set tmp0w, %di
+.set tmp1, %ebx
+.set tmp1w, %bx
+.set tmp2, %esi
+.set tmp3b, %cl
+
+	pushl	%ebp
+	movl	%esp, %ebp
+
+	pushl	dest
+	pushl	tmp0
+	pushl	tmp1
+	pushl	tmp2
+
+	/* Handle more 16 bytes in loop */
+	cmpl	$0x10, n
+	jb	.L16_byteswap
+
+	/* Decide forward/backward copy mode */
+	cmpl	dest, src
+	jb	.Lbackwards_header
+
+	/*
+	 * movs instruction have many startup latency
+	 * so we handle small size by general register.
+	 */
+	cmpl	$680, n
+	jb	.Ltoo_small_forwards
+	/*
+	 * movs instruction is only good for aligned case.
+	 */
+	movl	src, tmp0
+	xorl	dest, tmp0
+	andl	$0xff, tmp0
+	jz	.Lforward_movs
+.Ltoo_small_forwards:
+	subl	$0x10, n
+
+	/*
+	 * We gobble 16 bytes forward in each loop.
+	 */
+.L16_byteswap_forwards_loop:
+	subl	$0x10, n
+	movl	0*4(src), tmp0
+	movl	1*4(src), tmp1
+	movl	tmp0, 0*4(dest)
+	movl	tmp1, 1*4(dest)
+	movl	2*4(src), tmp0
+	movl	3*4(src), tmp1
+	movl	tmp0, 2*4(dest)
+	movl	tmp1, 3*4(dest)
+	leal	0x10(src), src
+	leal	0x10(dest), dest
+	jae	.L16_byteswap_forwards_loop
+	addl	$0x10, n
+	jmp	.L16_byteswap
+
+	/*
+	 * Handle data forward by movs.
+	 */
+.p2align 4
+.Lforward_movs:
+	movl	-4(src, n), tmp0
+	leal	-4(dest, n), tmp1
+	shrl	$2, n
+	rep	movsl
+	movl	tmp0, (tmp1)
+	jmp	.Ldone
+	/*
+	 * Handle data backward by movs.
+	 */
+.p2align 4
+.Lbackwards_movs:
+	movl	(src), tmp0
+	movl	dest, tmp1
+	leal	-4(src, n), src
+	leal	-4(dest, n), dest
+	shrl	$2, n
+	std
+	rep	movsl
+	movl	tmp0,(tmp1)
+	cld
+	jmp	.Ldone
+
+	/*
+	 * Start to prepare for backward copy.
+	 */
+.p2align 4
+.Lbackwards_header:
+	cmpl	$680, n
+	jb	.Ltoo_small_backwards
+	movl	src, tmp0
+	xorl	dest, tmp0
+	andl	$0xff, tmp0
+	jz	.Lbackwards_movs
+
+	/*
+	 * Calculate copy position to tail.
+	 */
+.Ltoo_small_backwards:
+	addl	n, src
+	addl	n, dest
+	subl	$0x10, n
+
+	/*
+	 * We gobble 16 bytes backward in each loop.
+	 */
+.L16_byteswap_backwards_loop:
+	subl	$0x10, n
+
+	movl	-1*4(src), tmp0
+	movl	-2*4(src), tmp1
+	movl	tmp0, -1*4(dest)
+	movl	tmp1, -2*4(dest)
+	movl	-3*4(src), tmp0
+	movl	-4*4(src), tmp1
+	movl	tmp0, -3*4(dest)
+	movl	tmp1, -4*4(dest)
+	leal	-0x10(src), src
+	leal	-0x10(dest), dest
+	jae	.L16_byteswap_backwards_loop
+	/*
+	 * Calculate copy position to head.
+	 */
+	addl	$0x10, n
+	subl	n, src
+	subl	n, dest
+
+	/*
+	 * Move data from 8 bytes to 15 bytes.
+	 */
+.p2align 4
+.L16_byteswap:
+	cmpl	$8, n
+	jb	.L8_byteswap
+	movl	0*4(src), tmp0
+	movl	1*4(src), tmp1
+	movl	-2*4(src, n), tmp2
+	movl	-1*4(src, n), src
+
+	movl	tmp0, 0*4(dest)
+	movl	tmp1, 1*4(dest)
+	movl	tmp2, -2*4(dest, n)
+	movl	src, -1*4(dest, n)
+	jmp	.Ldone
+
+	/*
+	 * Move data from 4 bytes to 7 bytes.
+	 */
+.p2align 4
+.L8_byteswap:
+	cmpl	$4, n
+	jb	.L4_byteswap
+	movl	0*4(src), tmp0
+	movl	-1*4(src, n), tmp1
+	movl	tmp0, 0*4(dest)
+	movl	tmp1, -1*4(dest, n)
+	jmp	.Ldone
+
+	/*
+	 * Move data from 2 bytes to 3 bytes.
+	 */
+.p2align 4
+.L4_byteswap:
+	cmpl	$2, n
+	jb	.Lbyteswap
+	movw	0*2(src), tmp0w
+	movw	-1*2(src, n), tmp1w
+	movw	tmp0w, 0*2(dest)
+	movw	tmp1w, -1*2(dest, n)
+	jmp	.Ldone
+
+	/*
+	 * Move data for 1 byte.
+	 */
+.p2align 4
+.Lbyteswap:
+	cmpl	$1, n
+	jb	.Ldone
+	movb	(src), tmp3b
+	movb	tmp3b, (dest)
+.p2align 4
+.Ldone:
+	popl	tmp2
+	popl	tmp1
+	popl	tmp0
+	popl	%eax
+	popl	%ebp
+	RET
+SYM_FUNC_END(memmove)
+EXPORT_SYMBOL(memmove)
-- 
2.37.3.998.g577e59143f-goog

