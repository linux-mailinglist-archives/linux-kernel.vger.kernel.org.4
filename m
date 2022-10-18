Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22A556033FC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 22:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbiJRUbs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 16:31:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbiJRUbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 16:31:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20DCB61D90
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 13:31:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E1EC0616E2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 20:31:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68201C433C1;
        Tue, 18 Oct 2022 20:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666125097;
        bh=hTGwUWlxe+DFtAUSJ1aOT1yIbf6PtI8HpfQSXkXP62M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sikZnQLYE+id9VgocxG/2kzyIgaCbKgslRIPY+AHJ09zwxTNOU1E7ihNWAjDgNMWX
         klbwZMa65cgyldlrievc5aZhtsP6/MwBUlzETV7zOtRaSNFwDimSseGbRt7or5nvSp
         7Ywt41cA6lU9ejgFZkXm8fG2o3kh3v7V5urtHdam5/5oBx0QGYFO5uySEcFFy6H9pB
         ubcBI9IWNNJqVE1kmgdLrRXKxNmeFr/D2u5UU3tbM+jmtbFPynKAZPcbas+Vyx+2Ba
         J3QPJnfN6IMtb6FPY1da+FnEok4H3Vd/QiHcmeLrOagDg1C09nliKFu3ANXhyUDQ+d
         i5FC6rFDiFAoA==
Date:   Tue, 18 Oct 2022 13:31:34 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     bp@alien8.de, dave.hansen@linux.intel.com, mingo@kernel.org,
        tglx@linutronix.de, David.Laight@aculab.com, hpa@zytor.com,
        keescook@chromium.org, linux-kernel@vger.kernel.org,
        linux@rasmusvillemoes.dk, llvm@lists.linux.dev, luto@kernel.org,
        mingo@redhat.com, peterz@infradead.org,
        torvalds@linux-foundation.org, x86@kernel.org
Subject: Re: [RESEND PATCH v5] x86, mem: move memmove to out of line assembler
Message-ID: <Y08NJohEeoYX2aIf@thelio-3990X>
References: <20221018172155.287409-1-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221018172155.287409-1-ndesaulniers@google.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 10:21:55AM -0700, Nick Desaulniers wrote:
> When building ARCH=i386 with CONFIG_LTO_CLANG_FULL=y, it's possible
> (depending on additional configs which I have not been able to isolate)
> to observe a failure during register allocation:
> 
>   error: inline assembly requires more registers than available
> 
> when memmove is inlined into tcp_v4_fill_cb() or tcp_v6_fill_cb().
> 
> memmove is quite large and probably shouldn't be inlined due to size
> alone. A noinline function attribute would be the simplest fix, but
> there's a few things that stand out with the current definition:
> 
> In addition to having complex constraints that can't always be resolved,
> the clobber list seems to be missing %bx. By using numbered operands
> rather than symbolic operands, the constraints are quite obnoxious to
> refactor.
> 
> Having a large function be 99% inline asm is a code smell that this
> function should simply be written in stand-alone out-of-line assembler.
> 
> Moving this to out of line assembler guarantees that the
> compiler cannot inline calls to memmove.
> 
> This has been done previously for 64b:
> commit 9599ec0471de ("x86-64, mem: Convert memmove() to assembly file
> and fix return value bug")
> 
> That gives the opportunity for other cleanups like fixing the
> inconsistent use of tabs vs spaces and instruction suffixes, and the
> label 3 appearing twice.  Symbolic operands, local labels, and
> additional comments would provide this code with a fresh coat of paint.
> 
> Finally, add a test that tickles the `rep movsl` implementation to test
> it for correctness, since it has implicit operands.
> 
> Suggested-by: Ingo Molnar <mingo@kernel.org>
> Suggested-by: David Laight <David.Laight@aculab.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Tested-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>

I ran

$ tools/testing/kunit/kunit.py run --arch i386 --cross_compile x86_64-linux- memcpy

with GCC 6 through 12 from
https://mirrors.edge.kernel.org/pub/tools/crosstool/ (my GCC 5 container
is based on Ubuntu Xenial, which does not have a new enough Python for
kunit.py) and

$ tools/testing/kunit/kunit.py run --arch i386 --make_options LLVM=1 memcpy

with LLVM 11 through 16 from Debian with this change on top of Kees's
expanding of the memcpy() KUnit tests [1] and everything passed.

Tested-by: Nathan Chancellor <nathan@kernel.org>

[1]: https://lore.kernel.org/20221018082038.gonna.300-kees@kernel.org/

> ---
> Resend v5:
> * rebased on tip/master.
> 
> Changes v4 -> v5:
> * Reword+reorder commit message, in particular drop the "maybe" language
>   around %dx and %cl clobber, now that I know of arch/x86/entry/calling.h.
> * Drop most of my previous comments about caller vs. callee saved, as
>   per Ingo, and use Ingo's comments verbatim.
> * Reference arch/x86/entry/calling.h in comment.
> * Reorder pushl/popl. NFC
> * Rename labels as per David. 16_byteswap -> move_16B
> * Use /* comments */ more consistently, as per Ingo.
> * Add Ingo's+David's SB tags.
> * Carry forward Kees' RB/TB tags.
> 
> Changes v3 -> v4:
> * Fix bug I introduced in v1 when I changed src and dest to use
>   different scratch registers, which breaks `rep movsl` as pointed out
>   by Rasmus. This requires 2 `movl`s earlier on, changing the tmp
>   registers, then adjusting which registers we save/restore by the
>   calling convention. I intentionally did not carry forward tags from
>   Kees from v3 due to this bug.
> * Add a Kunit test that hangs on v3, but passes on v4. It uses a few
>   magic constants as well in order to test the `rep movsl` paths.
> 
> Changes v2 -> v3:
> * Fix bug I introduced in v1 when I changed one of temp register
>   operands for one of the two instructions performing a mem to mem swap,
>   but not the other instruction's operand, and discovered by Kees.
>   Verified KUnit memcpy tests are passing via:
>   $ ./tools/testing/kunit/kunit.py run --arch=i386 --make_options LLVM=1
>   $ ./tools/testing/kunit/kunit.py run --arch=i386
>   Fixed by using symbolic identifiers rather than open coded registers
>   for the less-than-word-size temporary registers.
> * Expand the comment about callee saved registers on i386 with a
>   reference to the psABI.
> 
> Changes v1 -> v2:
> * Add reference to 9599ec0471de in commit message.
> * Include asm/export.h then make sure to EXPORT_SYMBOL(memmove).
> 
>  arch/x86/lib/Makefile     |   1 +
>  arch/x86/lib/memcpy_32.c  | 187 -----------------------------------
>  arch/x86/lib/memmove_32.S | 200 ++++++++++++++++++++++++++++++++++++++
>  lib/memcpy_kunit.c        |  22 +++++
>  4 files changed, 223 insertions(+), 187 deletions(-)
>  create mode 100644 arch/x86/lib/memmove_32.S
> 
> diff --git a/arch/x86/lib/Makefile b/arch/x86/lib/Makefile
> index 7ba5f61d7273..4f1a40a86534 100644
> --- a/arch/x86/lib/Makefile
> +++ b/arch/x86/lib/Makefile
> @@ -60,6 +60,7 @@ ifeq ($(CONFIG_X86_32),y)
>          lib-y += checksum_32.o
>          lib-y += strstr_32.o
>          lib-y += string_32.o
> +        lib-y += memmove_32.o
>  ifneq ($(CONFIG_X86_CMPXCHG64),y)
>          lib-y += cmpxchg8b_emu.o atomic64_386_32.o
>  endif
> diff --git a/arch/x86/lib/memcpy_32.c b/arch/x86/lib/memcpy_32.c
> index ef3af7ff2c8a..a29b64befb93 100644
> --- a/arch/x86/lib/memcpy_32.c
> +++ b/arch/x86/lib/memcpy_32.c
> @@ -17,190 +17,3 @@ __visible void *memset(void *s, int c, size_t count)
>  	return __memset(s, c, count);
>  }
>  EXPORT_SYMBOL(memset);
> -
> -__visible void *memmove(void *dest, const void *src, size_t n)
> -{
> -	int d0,d1,d2,d3,d4,d5;
> -	char *ret = dest;
> -
> -	__asm__ __volatile__(
> -		/* Handle more 16 bytes in loop */
> -		"cmp $0x10, %0\n\t"
> -		"jb	1f\n\t"
> -
> -		/* Decide forward/backward copy mode */
> -		"cmp %2, %1\n\t"
> -		"jb	2f\n\t"
> -
> -		/*
> -		 * movs instruction have many startup latency
> -		 * so we handle small size by general register.
> -		 */
> -		"cmp  $680, %0\n\t"
> -		"jb 3f\n\t"
> -		/*
> -		 * movs instruction is only good for aligned case.
> -		 */
> -		"mov %1, %3\n\t"
> -		"xor %2, %3\n\t"
> -		"and $0xff, %3\n\t"
> -		"jz 4f\n\t"
> -		"3:\n\t"
> -		"sub $0x10, %0\n\t"
> -
> -		/*
> -		 * We gobble 16 bytes forward in each loop.
> -		 */
> -		"3:\n\t"
> -		"sub $0x10, %0\n\t"
> -		"mov 0*4(%1), %3\n\t"
> -		"mov 1*4(%1), %4\n\t"
> -		"mov  %3, 0*4(%2)\n\t"
> -		"mov  %4, 1*4(%2)\n\t"
> -		"mov 2*4(%1), %3\n\t"
> -		"mov 3*4(%1), %4\n\t"
> -		"mov  %3, 2*4(%2)\n\t"
> -		"mov  %4, 3*4(%2)\n\t"
> -		"lea  0x10(%1), %1\n\t"
> -		"lea  0x10(%2), %2\n\t"
> -		"jae 3b\n\t"
> -		"add $0x10, %0\n\t"
> -		"jmp 1f\n\t"
> -
> -		/*
> -		 * Handle data forward by movs.
> -		 */
> -		".p2align 4\n\t"
> -		"4:\n\t"
> -		"mov -4(%1, %0), %3\n\t"
> -		"lea -4(%2, %0), %4\n\t"
> -		"shr $2, %0\n\t"
> -		"rep movsl\n\t"
> -		"mov %3, (%4)\n\t"
> -		"jmp 11f\n\t"
> -		/*
> -		 * Handle data backward by movs.
> -		 */
> -		".p2align 4\n\t"
> -		"6:\n\t"
> -		"mov (%1), %3\n\t"
> -		"mov %2, %4\n\t"
> -		"lea -4(%1, %0), %1\n\t"
> -		"lea -4(%2, %0), %2\n\t"
> -		"shr $2, %0\n\t"
> -		"std\n\t"
> -		"rep movsl\n\t"
> -		"mov %3,(%4)\n\t"
> -		"cld\n\t"
> -		"jmp 11f\n\t"
> -
> -		/*
> -		 * Start to prepare for backward copy.
> -		 */
> -		".p2align 4\n\t"
> -		"2:\n\t"
> -		"cmp  $680, %0\n\t"
> -		"jb 5f\n\t"
> -		"mov %1, %3\n\t"
> -		"xor %2, %3\n\t"
> -		"and $0xff, %3\n\t"
> -		"jz 6b\n\t"
> -
> -		/*
> -		 * Calculate copy position to tail.
> -		 */
> -		"5:\n\t"
> -		"add %0, %1\n\t"
> -		"add %0, %2\n\t"
> -		"sub $0x10, %0\n\t"
> -
> -		/*
> -		 * We gobble 16 bytes backward in each loop.
> -		 */
> -		"7:\n\t"
> -		"sub $0x10, %0\n\t"
> -
> -		"mov -1*4(%1), %3\n\t"
> -		"mov -2*4(%1), %4\n\t"
> -		"mov  %3, -1*4(%2)\n\t"
> -		"mov  %4, -2*4(%2)\n\t"
> -		"mov -3*4(%1), %3\n\t"
> -		"mov -4*4(%1), %4\n\t"
> -		"mov  %3, -3*4(%2)\n\t"
> -		"mov  %4, -4*4(%2)\n\t"
> -		"lea  -0x10(%1), %1\n\t"
> -		"lea  -0x10(%2), %2\n\t"
> -		"jae 7b\n\t"
> -		/*
> -		 * Calculate copy position to head.
> -		 */
> -		"add $0x10, %0\n\t"
> -		"sub %0, %1\n\t"
> -		"sub %0, %2\n\t"
> -
> -		/*
> -		 * Move data from 8 bytes to 15 bytes.
> -		 */
> -		".p2align 4\n\t"
> -		"1:\n\t"
> -		"cmp $8, %0\n\t"
> -		"jb 8f\n\t"
> -		"mov 0*4(%1), %3\n\t"
> -		"mov 1*4(%1), %4\n\t"
> -		"mov -2*4(%1, %0), %5\n\t"
> -		"mov -1*4(%1, %0), %1\n\t"
> -
> -		"mov  %3, 0*4(%2)\n\t"
> -		"mov  %4, 1*4(%2)\n\t"
> -		"mov  %5, -2*4(%2, %0)\n\t"
> -		"mov  %1, -1*4(%2, %0)\n\t"
> -		"jmp 11f\n\t"
> -
> -		/*
> -		 * Move data from 4 bytes to 7 bytes.
> -		 */
> -		".p2align 4\n\t"
> -		"8:\n\t"
> -		"cmp $4, %0\n\t"
> -		"jb 9f\n\t"
> -		"mov 0*4(%1), %3\n\t"
> -		"mov -1*4(%1, %0), %4\n\t"
> -		"mov  %3, 0*4(%2)\n\t"
> -		"mov  %4, -1*4(%2, %0)\n\t"
> -		"jmp 11f\n\t"
> -
> -		/*
> -		 * Move data from 2 bytes to 3 bytes.
> -		 */
> -		".p2align 4\n\t"
> -		"9:\n\t"
> -		"cmp $2, %0\n\t"
> -		"jb 10f\n\t"
> -		"movw 0*2(%1), %%dx\n\t"
> -		"movw -1*2(%1, %0), %%bx\n\t"
> -		"movw %%dx, 0*2(%2)\n\t"
> -		"movw %%bx, -1*2(%2, %0)\n\t"
> -		"jmp 11f\n\t"
> -
> -		/*
> -		 * Move data for 1 byte.
> -		 */
> -		".p2align 4\n\t"
> -		"10:\n\t"
> -		"cmp $1, %0\n\t"
> -		"jb 11f\n\t"
> -		"movb (%1), %%cl\n\t"
> -		"movb %%cl, (%2)\n\t"
> -		".p2align 4\n\t"
> -		"11:"
> -		: "=&c" (d0), "=&S" (d1), "=&D" (d2),
> -		  "=r" (d3),"=r" (d4), "=r"(d5)
> -		:"0" (n),
> -		 "1" (src),
> -		 "2" (dest)
> -		:"memory");
> -
> -	return ret;
> -
> -}
> -EXPORT_SYMBOL(memmove);
> diff --git a/arch/x86/lib/memmove_32.S b/arch/x86/lib/memmove_32.S
> new file mode 100644
> index 000000000000..0588b2c0fc95
> --- /dev/null
> +++ b/arch/x86/lib/memmove_32.S
> @@ -0,0 +1,200 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#include <linux/linkage.h>
> +#include <asm/export.h>
> +
> +SYM_FUNC_START(memmove)
> +/*
> + * void *memmove(void *dest_in, const void *src_in, size_t n)
> + * -mregparm=3 passes these in registers:
> + * dest_in: %eax
> + * src_in: %edx
> + * n: %ecx
> + * See also: arch/x86/entry/calling.h for description of the calling convention.
> + *
> + * n can remain in %ecx, but for `rep movsl`, we'll need dest in %edi and src
> + * in %esi.
> + */
> +.set dest_in, %eax
> +.set dest, %edi
> +.set src_in, %edx
> +.set src, %esi
> +.set n, %ecx
> +.set tmp0, %edx
> +.set tmp0w, %dx
> +.set tmp1, %ebx
> +.set tmp1w, %bx
> +.set tmp2, %eax
> +.set tmp3b, %cl
> +
> +/*
> + * Save all callee-saved registers, because this function is going to clobber
> + * all of them:
> + */
> +	pushl	%ebp
> +	movl	%esp, %ebp	// set standard frame pointer
> +
> +	pushl	%ebx
> +	pushl	%edi
> +	pushl	%esi
> +	pushl	%eax		// save 'dest_in' parameter [eax] as the return value
> +
> +	movl src_in, src
> +	movl dest_in, dest
> +
> +	/* Handle more 16 bytes in loop */
> +	cmpl	$0x10, n
> +	jb	.Lmove_16B
> +
> +	/* Decide forward/backward copy mode */
> +	cmpl	dest, src
> +	jb	.Lbackwards_header
> +
> +	/*
> +	 * movs instruction have many startup latency
> +	 * so we handle small size by general register.
> +	 */
> +	cmpl	$680, n
> +	jb	.Ltoo_small_forwards
> +	/* movs instruction is only good for aligned case. */
> +	movl	src, tmp0
> +	xorl	dest, tmp0
> +	andl	$0xff, tmp0
> +	jz	.Lforward_movs
> +.Ltoo_small_forwards:
> +	subl	$0x10, n
> +
> +	/* We gobble 16 bytes forward in each loop. */
> +.Lmove_16B_forwards_loop:
> +	subl	$0x10, n
> +	movl	0*4(src), tmp0
> +	movl	1*4(src), tmp1
> +	movl	tmp0, 0*4(dest)
> +	movl	tmp1, 1*4(dest)
> +	movl	2*4(src), tmp0
> +	movl	3*4(src), tmp1
> +	movl	tmp0, 2*4(dest)
> +	movl	tmp1, 3*4(dest)
> +	leal	0x10(src), src
> +	leal	0x10(dest), dest
> +	jae	.Lmove_16B_forwards_loop
> +	addl	$0x10, n
> +	jmp	.Lmove_16B
> +
> +	/* Handle data forward by movs. */
> +.p2align 4
> +.Lforward_movs:
> +	movl	-4(src, n), tmp0
> +	leal	-4(dest, n), tmp1
> +	shrl	$2, n
> +	rep	movsl
> +	movl	tmp0, (tmp1)
> +	jmp	.Ldone
> +
> +	/* Handle data backward by movs. */
> +.p2align 4
> +.Lbackwards_movs:
> +	movl	(src), tmp0
> +	movl	dest, tmp1
> +	leal	-4(src, n), src
> +	leal	-4(dest, n), dest
> +	shrl	$2, n
> +	std
> +	rep	movsl
> +	movl	tmp0,(tmp1)
> +	cld
> +	jmp	.Ldone
> +
> +	/* Start to prepare for backward copy. */
> +.p2align 4
> +.Lbackwards_header:
> +	cmpl	$680, n
> +	jb	.Ltoo_small_backwards
> +	movl	src, tmp0
> +	xorl	dest, tmp0
> +	andl	$0xff, tmp0
> +	jz	.Lbackwards_movs
> +
> +	/* Calculate copy position to tail. */
> +.Ltoo_small_backwards:
> +	addl	n, src
> +	addl	n, dest
> +	subl	$0x10, n
> +
> +	/* We gobble 16 bytes backward in each loop. */
> +.Lmove_16B_backwards_loop:
> +	subl	$0x10, n
> +
> +	movl	-1*4(src), tmp0
> +	movl	-2*4(src), tmp1
> +	movl	tmp0, -1*4(dest)
> +	movl	tmp1, -2*4(dest)
> +	movl	-3*4(src), tmp0
> +	movl	-4*4(src), tmp1
> +	movl	tmp0, -3*4(dest)
> +	movl	tmp1, -4*4(dest)
> +	leal	-0x10(src), src
> +	leal	-0x10(dest), dest
> +	jae	.Lmove_16B_backwards_loop
> +	/* Calculate copy position to head. */
> +	addl	$0x10, n
> +	subl	n, src
> +	subl	n, dest
> +
> +	/* Move data from 8 bytes to 15 bytes. */
> +.p2align 4
> +.Lmove_16B:
> +	cmpl	$8, n
> +	jb	.Lmove_8B
> +	movl	0*4(src), tmp0
> +	movl	1*4(src), tmp1
> +	movl	-2*4(src, n), tmp2
> +	movl	-1*4(src, n), src
> +
> +	movl	tmp0, 0*4(dest)
> +	movl	tmp1, 1*4(dest)
> +	movl	tmp2, -2*4(dest, n)
> +	movl	src, -1*4(dest, n)
> +	jmp	.Ldone
> +
> +	/* Move data from 4 bytes to 7 bytes. */
> +.p2align 4
> +.Lmove_8B:
> +	cmpl	$4, n
> +	jb	.Lmove_4B
> +	movl	0*4(src), tmp0
> +	movl	-1*4(src, n), tmp1
> +	movl	tmp0, 0*4(dest)
> +	movl	tmp1, -1*4(dest, n)
> +	jmp	.Ldone
> +
> +	/* Move data from 2 bytes to 3 bytes. */
> +.p2align 4
> +.Lmove_4B:
> +	cmpl	$2, n
> +	jb	.Lmove_1B
> +	movw	0*2(src), tmp0w
> +	movw	-1*2(src, n), tmp1w
> +	movw	tmp0w, 0*2(dest)
> +	movw	tmp1w, -1*2(dest, n)
> +	jmp	.Ldone
> +
> +	/* Move data for 1 byte. */
> +.p2align 4
> +.Lmove_1B:
> +	cmpl	$1, n
> +	jb	.Ldone
> +	movb	(src), tmp3b
> +	movb	tmp3b, (dest)
> +.p2align 4
> +.Ldone:
> +	popl	dest_in	// restore 'dest_in' [eax] as the return value
> +	/* Restore all callee-saved registers: */
> +	popl	%esi
> +	popl	%edi
> +	popl	%ebx
> +	popl	%ebp
> +
> +	RET
> +SYM_FUNC_END(memmove)
> +EXPORT_SYMBOL(memmove)
> diff --git a/lib/memcpy_kunit.c b/lib/memcpy_kunit.c
> index 2b5cc70ac53f..7513e6d5dc90 100644
> --- a/lib/memcpy_kunit.c
> +++ b/lib/memcpy_kunit.c
> @@ -105,6 +105,8 @@ static void memcpy_test(struct kunit *test)
>  #undef TEST_OP
>  }
>  
> +static unsigned char larger_array [2048];
> +
>  static void memmove_test(struct kunit *test)
>  {
>  #define TEST_OP "memmove"
> @@ -179,6 +181,26 @@ static void memmove_test(struct kunit *test)
>  	ptr = &overlap.data[2];
>  	memmove(ptr, overlap.data, 5);
>  	compare("overlapping write", overlap, overlap_expected);
> +
> +	/* Verify larger overlapping moves. */
> +	larger_array[256] = 0xAAu;
> +	/*
> +	 * Test a backwards overlapping memmove first. 256 and 1024 are
> +	 * important for i386 to use rep movsl.
> +	 */
> +	memmove(larger_array, larger_array + 256, 1024);
> +	KUNIT_ASSERT_EQ(test, larger_array[0], 0xAAu);
> +	KUNIT_ASSERT_EQ(test, larger_array[256], 0x00);
> +	KUNIT_ASSERT_NULL(test,
> +		memchr(larger_array + 1, 0xaa, ARRAY_SIZE(larger_array) - 1));
> +	/* Test a forwards overlapping memmove. */
> +	larger_array[0] = 0xBBu;
> +	memmove(larger_array + 256, larger_array, 1024);
> +	KUNIT_ASSERT_EQ(test, larger_array[0], 0xBBu);
> +	KUNIT_ASSERT_EQ(test, larger_array[256], 0xBBu);
> +	KUNIT_ASSERT_NULL(test, memchr(larger_array + 1, 0xBBu, 256 - 1));
> +	KUNIT_ASSERT_NULL(test,
> +		memchr(larger_array + 257, 0xBBu, ARRAY_SIZE(larger_array) - 257));
>  #undef TEST_OP
>  }
>  
> 
> base-commit: de1e44cd1509314b2f77d431754fd2f2b2b0a08a
> -- 
> 2.38.0.413.g74048e4d9e-goog
> 
> 
