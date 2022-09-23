Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBD7D5E8047
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 19:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbiIWRCc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 13:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbiIWRCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 13:02:30 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F5D1280DA
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 10:02:28 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-34a00eb8bc7so4840677b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 10:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date;
        bh=eWO8y7IKJvgsgCw3MooGox+2jloLd9sOwVdTlC0FzfU=;
        b=U+v5byszcMTyPi65DUXHeq40T/mw22xnhn5c41jsyqLtnpMcHCOhlhhKJ+xkoOrog1
         3hi0uECQu8KQtfpRA589NNvijvs1/gplYT/RMxLPITNX++Z3s5l0TC2AYVnnVCbk18uP
         62bHxuxAKnC1a/8AhC5rikjlwGWB22WiSOyqzdnjowlsS5mz7T6imC5srj6avskWva6v
         35So0jUnoYKLMjO7cOOo1Fv577wyFoLbu5ZSll9RHK04bKvjhPqRDEYCGaMWUSlvHK9j
         6+gJuaZRmx2I6K/U/FQnroypMCtqfKmuuGgEWK9p41Tvu69C8oHieT4G7pwPbvLaDu59
         qMwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date;
        bh=eWO8y7IKJvgsgCw3MooGox+2jloLd9sOwVdTlC0FzfU=;
        b=cqREjrcVIAZCM7kAaaSIiwVTSpx0PDGwdCiQ40hlaXJ4/T8qV2cz0pQTTPRgJJsbYr
         oEPard6Ql5iGFl0qQfXrIle1Ge20Ix6WEJ5kw7YBwfpYr8amsNgSrAUaAekMUkHJNdtt
         UHd3To81GTllDmUpR43uG3ufhFYxyuSRq52whBurcvCsaP6T0RaQwS4fJ0Zpfs3lDiVt
         +xOvCiimVK6/Ns9adwpkIcOiV+NJJHp2Wyl1phLI+e9VrAi1a8Wvyl1b1w1j2Gvi3BAJ
         w5DhWggqdC9jjJgzyEQ9vFmvYno8/Du1sPNh65aoWVoD83BVZG8igguwk+Cs1oI1toS1
         C0Aw==
X-Gm-Message-State: ACrzQf1XAA6l7Kt9oho6jGpqb9rE16XSSAcRlR524/4R982aWriO0Axs
        ppQCs5XP5zPem9a7qKsvTPPllZAk8EYRO/43Stw=
X-Google-Smtp-Source: AMsMyM44OXM8tFuGIBxRH9dw0jYFykZH+CPWi03i8pexNTsHPOf+sq+k0ZIi/v8gupViH8zFr/scaHoCrYcpjXaMfYI=
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:0:100e:712:fce1:be5b:26d5:2809])
 (user=ndesaulniers job=sendgmr) by 2002:a25:e60d:0:b0:6b0:cd5:f346 with SMTP
 id d13-20020a25e60d000000b006b00cd5f346mr10428011ybh.233.1663952547659; Fri,
 23 Sep 2022 10:02:27 -0700 (PDT)
Date:   Fri, 23 Sep 2022 10:02:18 -0700
Mime-Version: 1.0
X-Developer-Key: i=ndesaulniers@google.com; a=ed25519; pk=lvO/pmg+aaCb6dPhyGC1GyOCvPueDrrc8Zeso5CaGKE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1663952537; l=10714;
 i=ndesaulniers@google.com; s=20211004; h=from:subject; bh=X+Sz5mnlbfuGx0ZV1RzX3j/4mMe5t8IGTWpvHEdspIA=;
 b=NYAIzrW7uSLATRSqa7MCTP7kjK0zKn0RsvPjLxsW9sZGtM4j/BJHNeJPG96gykjo4xEK/gIHmtCX
 i/lB5Fi2DcOiBVjC24K4ZyKJtVkInO+VNqDV9mmx3yYonb4EmnrH
X-Mailer: git-send-email 2.37.3.998.g577e59143f-goog
Message-ID: <20220923170218.1188423-1-ndesaulniers@google.com>
Subject: [PATCH] x86, mem: move memmove to out of line assembler
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        llvm@lists.linux.dev, Andy Lutomirski <luto@kernel.org>,
        Ma Ling <ling.ma@intel.com>,
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

Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
An alternative, lower risk approach:
Rather than do all of the above, we could simply provide a macro in the
vain of noinline_for_stack to document that we don't want LTO to inline
a particular function across translation unit boundaries, then apply
that to memmove. Up to the x86 maintainers' risk tolerances.

Also, this leaves arch/x86/lib/memcpy_32.c pretty sparse/nearly empty.
Perhaps I should clean that up here, too? Perhaps in
arch/x86/include/asm/string_32.h? That would probably allow for inlining
calls to memcpy and memset.


 arch/x86/lib/Makefile     |   1 +
 arch/x86/lib/memcpy_32.c  | 187 -----------------------------------
 arch/x86/lib/memmove_32.S | 202 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 203 insertions(+), 187 deletions(-)
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
index 000000000000..096feb154f64
--- /dev/null
+++ b/arch/x86/lib/memmove_32.S
@@ -0,0 +1,202 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#include <linux/linkage.h>
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
-- 
2.37.3.998.g577e59143f-goog

