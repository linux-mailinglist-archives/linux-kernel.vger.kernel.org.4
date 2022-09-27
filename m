Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E59C85ECAD7
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 19:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232516AbiI0R3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 13:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232033AbiI0R3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 13:29:00 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4ED51D2608
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 10:28:58 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-3524fac9dbcso15881427b3.14
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 10:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=L0W2YbdGelpLBBhnQ093QmU58Jj5BkI2M5+XUp6L86g=;
        b=saMO7FlJV4bJZe6KIHgzw9X3kBi3Qmhyv0A+06hXmeSn5Up0RUC/lRtKkZJa1NI0xr
         H95arRp2Hv4jpEt73Q95LhlPylZmt8AlKD4BYm3iVWce3YzUALhi34WMyky7rlmhsev5
         WfEVZA2jPVj7ZUJfp62CxPR+XbQcgrwgsjQ5AfEyTlRPJCsCP17OsrEllcYhSsE0Ylb7
         mrBSv5Mu3nNHvnedj3qbiJG/hFL+CqXyP+MNlEHDICVpuzJcHNRd5O00qzQIoqa9spSG
         z9s1ipM/sJ8o0j15+u+HC6xVQNB3d36ktszYM/IyhkSppJZimI5S1zP0RCBBNKwOOchf
         AtPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=L0W2YbdGelpLBBhnQ093QmU58Jj5BkI2M5+XUp6L86g=;
        b=DQcA1a2yxoYPDiHmpJJE0ZnHkenuNL6xspLquu1zB8RQwHga2NFuAriO3NimIc0qb7
         LP0R098YH9GvdrqrxyrHOh6t31Y2Bd7WRIFp97ieuiz0unPVHC3NsKfzsgRTneUs0Kwc
         pJHjXBibUwj0TwW84Vtt73lf37IUMy5hDhZ79sgrDMggcgMypGOYkDGOZWE2HGXoVbT9
         rfdc7Uy4OVoUt1hEA+ZX53qdvfvLrLQhOj3khOapjz9IPcuWzlCkxHl4cGxVUF0XFEWU
         3sj/oek/EL3nP5h2HjbFrp9NJ+az2+/4N+ELM/9jjpB6UNJUi0072MrZqrKzueYEfoHV
         y6vQ==
X-Gm-Message-State: ACrzQf3+4C34fSsrJo15r/hzQzjyx5NDRfqJBckok684n62wkiQkrl5t
        ybHFoRJnSdQ5O5V3yT998nX2XtG5U/s4Ch4yfNI=
X-Google-Smtp-Source: AMsMyM4lIwKFaub7SyBpj6x9nikreyg0KK1RlF57anzPWbtQiI1mx8wQp/DQDgdhTEA6ossH3UPPncNGolRZG4HtZ2o=
X-Received: from ndesaulniers-desktop.svl.corp.google.com ([2620:0:100e:712:5d88:f716:dcf7:513])
 (user=ndesaulniers job=sendgmr) by 2002:a25:be8a:0:b0:6a7:3314:52c8 with SMTP
 id i10-20020a25be8a000000b006a7331452c8mr27045309ybk.210.1664299738216; Tue,
 27 Sep 2022 10:28:58 -0700 (PDT)
Date:   Tue, 27 Sep 2022 10:28:39 -0700
In-Reply-To: <CAKwvOd=a+0VNP-d=mHnbM4ujdtPrujru4dxHtfDo+EEM+b6deg@mail.gmail.com>
Mime-Version: 1.0
References: <CAKwvOd=a+0VNP-d=mHnbM4ujdtPrujru4dxHtfDo+EEM+b6deg@mail.gmail.com>
X-Developer-Key: i=ndesaulniers@google.com; a=ed25519; pk=UIrHvErwpgNbhCkRZAYSX0CFd/XFEwqX3D0xqtqjNug=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1664299719; l=10493;
 i=ndesaulniers@google.com; s=20220923; h=from:subject; bh=cbaacreCpwr160wOAaY8kRcfVzHpmLtmXY/T/uOwcto=;
 b=fshInz2dJdq4lJ08zZrtt3Fa3LucaxopqnO2iBFyLpiBlgd8wY5pwaDdSqxJS+BaCuu6s2A0nvoS
 fGuiaBU4BxfS8WTf+EwcoPEfwncRDF5afMnZg1RPu1bvACoVHRWX
X-Mailer: git-send-email 2.37.3.998.g577e59143f-goog
Message-ID: <20220927172839.3708280-1-ndesaulniers@google.com>
Subject: [PATCH v2] x86, mem: move memmove to out of line assembler
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

Moving this to out of line assembler guarantees that the compiler cannot
inline calls to memmove.

This has been done previously for 64b:
commit 9599ec0471de ("x86-64, mem: Convert memmove() to assembly file
and fix return value bug")

Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
Changes v1 -> v2:
* Add reference to 9599ec0471de in commit message.
* Include asm/export.h then make sure to EXPORT_SYMBOL(memmove).

 arch/x86/lib/Makefile     |   1 +
 arch/x86/lib/memcpy_32.c  | 187 ----------------------------------
 arch/x86/lib/memmove_32.S | 204 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 205 insertions(+), 187 deletions(-)
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
index 000000000000..73314a391a72
--- /dev/null
+++ b/arch/x86/lib/memmove_32.S
@@ -0,0 +1,204 @@
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
+/* Need 3 scratch registers. These need to be saved+restored. */
+.set tmp0, %edi
+.set tmp1, %ebx
+.set tmp2, %esi
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
+	movw	0*2(src), %di
+	movw	-1*2(src, n), %bx
+	movw	%dx, 0*2(dest)
+	movw	%bx, -1*2(dest, n)
+	jmp	.Ldone
+
+	/*
+	 * Move data for 1 byte.
+	 */
+.p2align 4
+.Lbyteswap:
+	cmpl	$1, n
+	jb	.Ldone
+	movb	(src), %cl
+	movb	%cl, (dest)
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

