Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92D5A5EE80A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 23:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234789AbiI1VLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 17:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234548AbiI1VLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 17:11:15 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4BA54D4CD
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 14:06:13 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 189-20020a250fc6000000b006ba7d16cef3so10144868ybp.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 14:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=iK+3+/MBq4Ko/Iq0akPW1zi9oRN+462u3MVK+oB2vRY=;
        b=oGuUYgWh+bPKVUae6haoZ9qm4kNCkj0Orwh/b7dvnQZrC+WFeMDyYTAFtMbv9L8pnm
         fIIDHya3RwrGCoJR5T8EP5Tz9PosJ1FIzNUmvFxO5sKrJE3grWkTXKMZHf9c7wcJ8tdW
         mQwmQJ2Bg1SdO1x1ZhQ/jpd7DqmOa/sz/ewx2cu3DS/O6T9SF0L+6qvKIVTPwsBhUTHe
         NphdUL4f5wVZ9RFp0YUXNEAM1E6Mk/4+YdifKpwpoQox2znO2+SXvuVWS8LKTP4T6MZj
         hZ9+PPGHmPCcYpagg4DN/lKbhMvmR8iTPBasFK/AXDIFIE+tzBn+q13OwCEYF7nfd7Q/
         ZXEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=iK+3+/MBq4Ko/Iq0akPW1zi9oRN+462u3MVK+oB2vRY=;
        b=DPLdWzs4kGb7HRekeGJ1mDz4wrMwQ29HBfGMwI/WjfqbealZhZmhOy/XZLG4llRUms
         gK7fVxu8N7XbalE3TUlOu5p9/4NcgIXzkR4EY0eOdemGEzK0pl5P3pxILdccpfG8g8lD
         vxBK9UqSEbvWgq8GqfFIIheuW8ooFoblZPox1c9+kZ7EYJ3Uw8di19Cb8xbqJAaT2CJu
         2a+RK/dhQ5V6Ez1my3KUkn8nV1KIIHcEmN2uyM5DUhyrGFZXgfFb+fbvU+1Cv86oedlE
         iwhc4H/JYhm4gZ58TJiEFFN7Hk/Rirv9ybpJO+i1Kph1X9myrM7LIyI3tdFm7FZyX8/j
         xqRQ==
X-Gm-Message-State: ACrzQf2DMT8N2uekhoWBypoz1KYgaMnUuVFCwEg7hFvvaEBizDQMn4oP
        D5eHksqS63lWQ5OkwinWPcbZzcymvqIGa7C73IM=
X-Google-Smtp-Source: AMsMyM5voGsn1OObVWqBJDUwyUMgfrATksOa8xOkl/mn/mIZv9U93ROL0WoZGDTo4G6MyZbK2oEcQtlvcsC++9EB6Gw=
X-Received: from ndesaulniers-desktop.svl.corp.google.com ([2620:0:100e:712:ded7:5ff3:c545:6856])
 (user=ndesaulniers job=sendgmr) by 2002:a0d:f885:0:b0:34c:e156:71dc with SMTP
 id i127-20020a0df885000000b0034ce15671dcmr32394830ywf.63.1664399117805; Wed,
 28 Sep 2022 14:05:17 -0700 (PDT)
Date:   Wed, 28 Sep 2022 14:05:12 -0700
In-Reply-To: <CAKwvOdkaKTa2aiA90VzFrChNQM6O_ro+b7VWs=op70jx-DKaXA@mail.gmail.com>
Mime-Version: 1.0
References: <CAKwvOdkaKTa2aiA90VzFrChNQM6O_ro+b7VWs=op70jx-DKaXA@mail.gmail.com>
X-Developer-Key: i=ndesaulniers@google.com; a=ed25519; pk=UIrHvErwpgNbhCkRZAYSX0CFd/XFEwqX3D0xqtqjNug=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1664399112; l=13883;
 i=ndesaulniers@google.com; s=20220923; h=from:subject; bh=14GK4GjksPgaTr3Bi3K+yBY+kamZm4ziv8oSohZKQJY=;
 b=ebjUE5F+w5nWukpgktI0KUif9AHnGVUMDnvkApWbgDBID9plWhKg0V5RJVHvvEKYguj+TBg9T8qv
 sRqPAZRyByb04orICzXyWVXPxfhz0mrN6yXblwsCyHSIzkY4/OQ1
X-Mailer: git-send-email 2.37.3.998.g577e59143f-goog
Message-ID: <20220928210512.642594-1-ndesaulniers@google.com>
Subject: [PATCH v4] x86, mem: move memmove to out of line assembler
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
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
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

Also, add a test that tickles the `rep movsl` implementation to test it
for correctness, since it has implicit operands.

Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
Changes v3 -> v4:
* Fix bug I introduced in v1 when I changed src and dest to use
  different scratch registers, which breaks `rep movsl` as pointed out
  by Rasmus. This requires 2 `movl`s earlier on, changing the tmp
  registers, then adjusting which registers we save/restore by the
  calling convention. I intentionally did not carry forward tags from
  Kees from v3 due to this bug.
* Add a Kunit test that hangs on v3, but passes on v4. It uses a few
  magic constants as well in order to test the `rep movsl` paths.

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
 arch/x86/lib/memcpy_32.c  | 187 -------------------------------
 arch/x86/lib/memmove_32.S | 226 ++++++++++++++++++++++++++++++++++++++
 lib/memcpy_kunit.c        |  21 ++++
 4 files changed, 248 insertions(+), 187 deletions(-)
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
index 000000000000..35d9dd24624e
--- /dev/null
+++ b/arch/x86/lib/memmove_32.S
@@ -0,0 +1,226 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#include <linux/linkage.h>
+#include <asm/export.h>
+
+SYM_FUNC_START(memmove)
+/*
+ * void *memmove(void *dest_in, const void *src_in, size_t n)
+ * -mregparm=3 passes these in registers:
+ * dest_in: %eax
+ * src_in: %edx
+ * n: %ecx
+ *
+ * n can remain in %ecx, but for `rep movsl`, we'll need dest in %edi and src
+ * in %esi.
+ */
+.set dest_in, %eax
+.set dest, %edi
+.set src_in, %edx
+.set src, %esi
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
+.set tmp0, %edx
+.set tmp0w, %dx
+.set tmp1, %ebx
+.set tmp1w, %bx
+.set tmp2, %eax
+.set tmp3b, %cl
+
+	pushl	%ebp
+	movl	%esp, %ebp
+
+	pushl	dest_in
+	pushl	dest
+	pushl	src
+	pushl	tmp1
+
+	movl src_in, src
+	movl dest_in, dest
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
+	popl	tmp1
+	popl	src
+	popl	dest
+	popl	%eax // memmove returns dest_in
+	popl	%ebp
+	RET
+SYM_FUNC_END(memmove)
+EXPORT_SYMBOL(memmove)
diff --git a/lib/memcpy_kunit.c b/lib/memcpy_kunit.c
index 62f8ffcbbaa3..52bce4f697a5 100644
--- a/lib/memcpy_kunit.c
+++ b/lib/memcpy_kunit.c
@@ -107,6 +107,8 @@ static void memcpy_test(struct kunit *test)
 #undef TEST_OP
 }
 
+static unsigned char larger_array [2048];
+
 static void memmove_test(struct kunit *test)
 {
 #define TEST_OP "memmove"
@@ -181,6 +183,25 @@ static void memmove_test(struct kunit *test)
 	ptr = &overlap.data[2];
 	memmove(ptr, overlap.data, 5);
 	compare("overlapping write", overlap, overlap_expected);
+
+	/* Verify larger overlapping moves. */
+	larger_array[256] = 0xAAu;
+	/* Test a backwards overlapping memmove first. 256 and 1024 are
+	 * important for i386 to use rep movsl.
+	 */
+	memmove(larger_array, larger_array + 256, 1024);
+	KUNIT_ASSERT_EQ(test, larger_array[0], 0xAAu);
+	KUNIT_ASSERT_EQ(test, larger_array[256], 0x00);
+	KUNIT_ASSERT_NULL(test,
+		memchr(larger_array + 1, 0xaa, ARRAY_SIZE(larger_array) - 1));
+	/* Test a forwards overlapping memmove. */
+	larger_array[0] = 0xBBu;
+	memmove(larger_array + 256, larger_array, 1024);
+	KUNIT_ASSERT_EQ(test, larger_array[0], 0xBBu);
+	KUNIT_ASSERT_EQ(test, larger_array[256], 0xBBu);
+	KUNIT_ASSERT_NULL(test, memchr(larger_array + 1, 0xBBu, 256 - 1));
+	KUNIT_ASSERT_NULL(test,
+		memchr(larger_array + 257, 0xBBu, ARRAY_SIZE(larger_array) - 257));
 #undef TEST_OP
 }
 
-- 
2.37.3.998.g577e59143f-goog

