Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BBB1607B9E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 17:57:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbiJUP5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 11:57:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230243AbiJUP4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 11:56:54 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D0E2018E73E
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 08:56:31 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 96D9B1063;
        Fri, 21 Oct 2022 08:56:37 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.6.231])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9017B3F792;
        Fri, 21 Oct 2022 08:56:29 -0700 (PDT)
Date:   Fri, 21 Oct 2022 16:56:20 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     llvm@lists.linux.dev
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Fangrui Song <maskray@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sami Tolvanen <samitolvanen@google.com>
Subject: kCFI && patchable-function-entry=M,N
Message-ID: <Y1LBGZPMfCZ8A1bl@FVFF77S0Q05N>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

For arm64, I'd like to use -fatchable-function-entry=M,N (where N > 0), for our
ftrace implementation, which instruments *some* but not all functions.
Unfortuntately, this doesn't play nicely with -fsanitize=kcfi, as instrumented
and non-instrumented functions don't agree on where the type hash should live
relative to the function entry point, making them incompatible with one another.
AFAICT, there's no mechanism today to get them to agree.

Today we use -fatchable-function-entry=2, which happens to avoid this.

For example, in the below, functions with N=0 expect the type hash to be placed
4 bytes before the entry point, and functions with N=2 expect the type hash to
be placed 12 bytes before the entry point.

| % cat test.c
| #define __notrace       __attribute__((patchable_function_entry(0, 0)))
| 
| void callee_patchable(void)
| {
| }
| 
| void __notrace callee_non_patchable(void)
| {
| }
| 
| typedef void (*callee_fn_t)(void);
| 
| void caller_patchable(callee_fn_t callee)
| {
|         callee();
| }
| 
| void __notrace caller_non_patchable(callee_fn_t callee)
| {
|         callee();
| }
| % clang --target=aarch64-linux -c test.c -fpatchable-function-entry=2,2 -fsanitize=kcfi -O2
| % aarch64-linux-objdump -d test.o
| 
| test.o:     file format elf64-littleaarch64
| 
| 
| Disassembly of section .text:
| 
| 0000000000000000 <callee_patchable-0xc>:
|    0:   a540670c        .word   0xa540670c
|    4:   d503201f        nop
|    8:   d503201f        nop
| 
| 000000000000000c <callee_patchable>:
|    c:   d65f03c0        ret
|   10:   a540670c        .word   0xa540670c
| 
| 0000000000000014 <callee_non_patchable>:
|   14:   d65f03c0        ret
|   18:   07d85f31        .word   0x07d85f31
|   1c:   d503201f        nop
|   20:   d503201f        nop
| 
| 0000000000000024 <caller_patchable>:
|   24:   b85f4010        ldur    w16, [x0, #-12]
|   28:   728ce191        movk    w17, #0x670c
|   2c:   72b4a811        movk    w17, #0xa540, lsl #16
|   30:   6b11021f        cmp     w16, w17
|   34:   54000040        b.eq    3c <caller_patchable+0x18>  // b.none
|   38:   d4304400        brk     #0x8220
|   3c:   d61f0000        br      x0
|   40:   07d85f31        .word   0x07d85f31
| 
| 0000000000000044 <caller_non_patchable>:
|   44:   b85fc010        ldur    w16, [x0, #-4]
|   48:   728ce191        movk    w17, #0x670c
|   4c:   72b4a811        movk    w17, #0xa540, lsl #16
|   50:   6b11021f        cmp     w16, w17
|   54:   54000040        b.eq    5c <caller_non_patchable+0x18>  // b.none
|   58:   d4304400        brk     #0x8220
|   5c:   d61f0000        br      x0

On arm64, I'd like to use -fpatchable-function-entry=4,2 on arm64, along with
-falign-functions=8, so that we can place a naturally-aligned 8-byte literal
before the function (e.g. a pointer value). That allows us to implement an
efficient per-callsite hook without hitting branch range limitations and/or
requiring trampolines. I have a PoC that works without kCFI at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/log/?h=arm64/ftrace/per-callsite-ops

I mentioned this in the #clangbuiltlinux IRQ channel, and Sami wrote up a
github issue at: https://github.com/ClangBuiltLinux/linux/issues/1744

Currently clang generates:

| 	< HASH >
| 	NOP
| 	NOP
| func:	BTI	// optional
| 	NOP
| 	NOP

... and to make this consistent with non-instrumented functions, the
non-instrumented functions would need pre-function padding before their hashes.

For my use-case, it doesn't matter where the pre-function NOPs are placed
relative to the type hash, so long as the location is consistent, and it might
be nicer to have the option to place the pre-function NOPs before the hash,
which would avoid needing to change non-instrumented functions (and save some
space) e.g.

| 	NOP
| 	NOP
| 	< HASH >
| func:	BTI	// optional
| 	NOP
| 	NOP

... but I understand that for x86, folk want the pre-function NOPs to
fall-through into the body of the function.

Is there any mechanism today that we could use to solve this, or could we
extend clang to have some options to control this behaviour?

It would also be helpful to have a symbol before both the hash and pre-function
NOPs so that we can filter those out of probes patching (I see that x86 does
this with the __cfi_function symbol).

Thanks,
Mark.
