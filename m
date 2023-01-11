Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA336662C4
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 19:29:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236651AbjAKS2Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 13:28:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231841AbjAKS2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 13:28:04 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E36EB32EA7;
        Wed, 11 Jan 2023 10:28:02 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B9C2DFEC;
        Wed, 11 Jan 2023 10:28:44 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.46.211])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5BB283F587;
        Wed, 11 Jan 2023 10:28:00 -0800 (PST)
Date:   Wed, 11 Jan 2023 18:27:53 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        ndesaulniers@google.com, ojeda@kernel.org, peterz@infradead.org,
        rafael.j.wysocki@intel.com, revest@chromium.org,
        robert.moore@intel.com, rostedt@goodmis.org, will@kernel.org
Subject: Re: [PATCH 1/8] Compiler attributes: GCC function alignment
 workarounds
Message-ID: <Y77/qVgvaJidFpYt@FVFF77S0Q05N>
References: <20230109135828.879136-1-mark.rutland@arm.com>
 <20230109135828.879136-2-mark.rutland@arm.com>
 <CANiq72kgmFYEO_EB_NxAF=S7VOf45KM7W3uwxxvftVErwfWzjg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiq72kgmFYEO_EB_NxAF=S7VOf45KM7W3uwxxvftVErwfWzjg@mail.gmail.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 09, 2023 at 03:43:16PM +0100, Miguel Ojeda wrote:
> On Mon, Jan 9, 2023 at 2:58 PM Mark Rutland <mark.rutland@arm.com> wrote:
> >
> > As far as I can tell, GCC doesn't respect '-falign-functions=N':
> >
> > * When the __weak__ attribute is used
> >
> >   GCC seems to forget the alignment specified by '-falign-functions=N',
> >   but will respect the '__aligned__(N)' function attribute. Thus, we can
> >   work around this by explciitly setting the alignment for weak
> >   functions.
> >
> > * When the __cold__ attribute is used
> >
> >   GCC seems to forget the alignment specified by '-falign-functions=N',
> >   and also doesn't seem to respect the '__aligned__(N)' function
> >   attribute. The only way to work around this is to not use the __cold__
> >   attibute.
> 
> If you happen to have a reduced case, then it would be nice to link it
> in the commit. A bug report to GCC would also be nice.
> 
> I gave it a very quick try in Compiler Explorer, but I couldn't
> reproduce it, so I guess it depends on flags, non-trivial functions or
> something else.

So having spent today coming up with tests, it turns out it's not quite as I
described above, but in a sense worse. I'm posting a summary here for
posterity; I'll try to get this to compiler folk shortly.

GCC appears to not align cold functions to the alignment specified by
`-falign-functions=N` when compiling at `-O1` or above. Alignment *can* be
restored with explicit attributes on each function, but due to some
interprocedural analysis, callees can be implicitly marked as cold (losing
their default alignment), which means we don't have a reliable mechanism to
ensure functions are always aligned short of annotating *every* function
explicitly (and I suspect that's not sufficient due to some interprocedural optimizations).

I've tested with the 12.1.0 binary release from the kernel.org cross toolchains
page).

LLVM always seems to repsect `-falign-functions=N` at both `-O1` and `-O2` (I
tested the 10.0.0, 11.0.0, 11.0.1, 15.0.6 binary releases from llvm.org).

For example:

| [mark@lakrids:/mnt/data/tests/gcc-alignment]% cat test-cold.c                                           
| #define __cold \
|         __attribute__((cold))
| 
| #define EXPORT_FUNC_PTR(func) \
|         typeof((func)) *__ptr_##func = (func)
| 
| __cold
| void cold_func_a(void) { }
| 
| __cold
| void cold_func_b(void) { }
| 
| __cold
| void cold_func_c(void) { }
| 
| static __cold
| void static_cold_func_a(void) { }
| EXPORT_FUNC_PTR(static_cold_func_a);
| 
| static __cold
| void static_cold_func_b(void) { }
| EXPORT_FUNC_PTR(static_cold_func_b);
| 
| static __cold
| void static_cold_func_c(void) { }
| EXPORT_FUNC_PTR(static_cold_func_c);
| [mark@lakrids:/mnt/data/tests/gcc-alignment]% usekorg 12.1.0 aarch64-linux-gcc -falign-functions=16 -c test-cold.c -O1
| [mark@lakrids:/mnt/data/tests/gcc-alignment]% usekorg 12.1.0 aarch64-linux-objdump -d test-cold.o                     
| 
| test-cold.o:     file format elf64-littleaarch64
| 
| 
| Disassembly of section .text:
| 
| 0000000000000000 <static_cold_func_a>:
|    0:   d65f03c0        ret
| 
| 0000000000000004 <static_cold_func_b>:
|    4:   d65f03c0        ret
| 
| 0000000000000008 <static_cold_func_c>:
|    8:   d65f03c0        ret
| 
| 000000000000000c <cold_func_a>:
|    c:   d65f03c0        ret
| 
| 0000000000000010 <cold_func_b>:
|   10:   d65f03c0        ret
| 
| 0000000000000014 <cold_func_c>:
|   14:   d65f03c0        ret
| [mark@lakrids:/mnt/data/tests/gcc-alignment]% usekorg 12.1.0 aarch64-linux-objdump -h test-cold.o
| 
| test-cold.o:     file format elf64-littleaarch64
| 
| Sections:
| Idx Name          Size      VMA               LMA               File off  Algn
|   0 .text         00000018  0000000000000000  0000000000000000  00000040  2**2
|                   CONTENTS, ALLOC, LOAD, READONLY, CODE
|   1 .data         00000018  0000000000000000  0000000000000000  00000058  2**3
|                   CONTENTS, ALLOC, LOAD, RELOC, DATA
|   2 .bss          00000000  0000000000000000  0000000000000000  00000070  2**0
|                   ALLOC
|   3 .comment      00000013  0000000000000000  0000000000000000  00000070  2**0
|                   CONTENTS, READONLY
|   4 .note.GNU-stack 00000000  0000000000000000  0000000000000000  00000083  2**0
|                   CONTENTS, READONLY
|   5 .eh_frame     00000090  0000000000000000  0000000000000000  00000088  2**3
|                   CONTENTS, ALLOC, LOAD, RELOC, READONLY, DATA

In simple cases, alignment *can* be restored if an explicit function attribute
is used. For example:

| [mark@lakrids:/mnt/data/tests/gcc-alignment]% cat test-aligned-cold.c                            
| #define __aligned(n) \
|         __attribute__((aligned(n)))
| 
| #define __cold \
|         __attribute__((cold)) __aligned(16)
| 
| #define EXPORT_FUNC_PTR(func) \
|         typeof((func)) *__ptr_##func = (func)
| 
| __cold
| void cold_func_a(void) { }
| 
| __cold
| void cold_func_b(void) { }
| 
| __cold
| void cold_func_c(void) { }
| 
| static __cold
| void static_cold_func_a(void) { }
| EXPORT_FUNC_PTR(static_cold_func_a);
| 
| static __cold
| void static_cold_func_b(void) { }
| EXPORT_FUNC_PTR(static_cold_func_b);
| 
| static __cold
| void static_cold_func_c(void) { }
| EXPORT_FUNC_PTR(static_cold_func_c);
| [mark@lakrids:/mnt/data/tests/gcc-alignment]% usekorg 12.1.0 aarch64-linux-gcc -falign-functions=16 -c test-aligned-cold.c -O1
| [mark@lakrids:/mnt/data/tests/gcc-alignment]% usekorg 12.1.0 aarch64-linux-objdump -d test-aligned-cold.o                     
| 
| test-aligned-cold.o:     file format elf64-littleaarch64
| 
| 
| Disassembly of section .text:
| 
| 0000000000000000 <static_cold_func_a>:
|    0:   d65f03c0        ret
|    4:   d503201f        nop
|    8:   d503201f        nop
|    c:   d503201f        nop
| 
| 0000000000000010 <static_cold_func_b>:
|   10:   d65f03c0        ret
|   14:   d503201f        nop
|   18:   d503201f        nop
|   1c:   d503201f        nop
| 
| 0000000000000020 <static_cold_func_c>:
|   20:   d65f03c0        ret
|   24:   d503201f        nop
|   28:   d503201f        nop
|   2c:   d503201f        nop
| 
| 0000000000000030 <cold_func_a>:
|   30:   d65f03c0        ret
|   34:   d503201f        nop
|   38:   d503201f        nop
|   3c:   d503201f        nop
| 
| 0000000000000040 <cold_func_b>:
|   40:   d65f03c0        ret
|   44:   d503201f        nop
|   48:   d503201f        nop
|   4c:   d503201f        nop
| 
| 0000000000000050 <cold_func_c>:
|   50:   d65f03c0        ret
| [mark@lakrids:/mnt/data/tests/gcc-alignment]% usekorg 12.1.0 aarch64-linux-objdump -h test-aligned-cold.o
| 
| test-aligned-cold.o:     file format elf64-littleaarch64
| 
| Sections:
| Idx Name          Size      VMA               LMA               File off  Algn
|   0 .text         00000054  0000000000000000  0000000000000000  00000040  2**4
|                   CONTENTS, ALLOC, LOAD, READONLY, CODE
|   1 .data         00000018  0000000000000000  0000000000000000  00000098  2**3
|                   CONTENTS, ALLOC, LOAD, RELOC, DATA
|   2 .bss          00000000  0000000000000000  0000000000000000  000000b0  2**0
|                   ALLOC
|   3 .comment      00000013  0000000000000000  0000000000000000  000000b0  2**0
|                   CONTENTS, READONLY
|   4 .note.GNU-stack 00000000  0000000000000000  0000000000000000  000000c3  2**0
|                   CONTENTS, READONLY
|   5 .eh_frame     00000090  0000000000000000  0000000000000000  000000c8  2**3
|                   CONTENTS, ALLOC, LOAD, RELOC, READONLY, DATA


Unfortunately it appears that some interprocedural analysis determines that if
a callee is only called/referenced from cold callers, the callee is marked as
cold, and the alignment it would have got from the command line option is
dropped. If it's given an explicit alignment attribute, the alignment is
retained.

For example:

| [mark@lakrids:/mnt/data/tests/gcc-alignment]% cat test-aligned-cold-caller.c                                    
| #define noinline \
|         __attribute__((noinline))
| 
| #define __aligned(n) \
|         __attribute__((aligned(n)))
| 
| #define __cold \
|         __attribute__((cold)) __aligned(16)
| 
| #define EXPORT_FUNC_PTR(func) \
|         typeof((func)) *__ptr_##func = (func)
| 
| static noinline void callee_a(void)
| {
|         asm volatile("// callee_a\n" ::: "memory");
| }
| 
| static noinline void callee_b(void)
| {
|         asm volatile("// callee_b\n" ::: "memory");
| }
| 
| static noinline void callee_c(void)
| {
|         asm volatile("// callee_c\n" ::: "memory");
| }
| __cold
| void cold_func_a(void) { callee_a(); }
| 
| __cold
| void cold_func_b(void) { callee_b(); }
| 
| __cold
| void cold_func_c(void) { callee_c(); }
| 
| static __cold
| void static_cold_func_a(void) { callee_a(); }
| EXPORT_FUNC_PTR(static_cold_func_a);
| 
| static __cold
| void static_cold_func_b(void) { callee_b(); }
| EXPORT_FUNC_PTR(static_cold_func_b);
| 
| static __cold
| void static_cold_func_c(void) { callee_c(); }
| EXPORT_FUNC_PTR(static_cold_func_c);
| [mark@lakrids:/mnt/data/tests/gcc-alignment]% usekorg 12.1.0 aarch64-linux-gcc -falign-functions=16 -c test-aligned-cold-caller.c -O1
| [mark@lakrids:/mnt/data/tests/gcc-alignment]% usekorg 12.1.0 aarch64-linux-objdump -d test-aligned-cold-caller.o                     
| 
| test-aligned-cold-caller.o:     file format elf64-littleaarch64
| 
| 
| Disassembly of section .text:
| 
| 0000000000000000 <callee_a>:
|    0:   d65f03c0        ret
| 
| 0000000000000004 <callee_b>:
|    4:   d65f03c0        ret
| 
| 0000000000000008 <callee_c>:
|    8:   d65f03c0        ret
|    c:   d503201f        nop
| 
| 0000000000000010 <static_cold_func_a>:
|   10:   a9bf7bfd        stp     x29, x30, [sp, #-16]!
|   14:   910003fd        mov     x29, sp
|   18:   97fffffa        bl      0 <callee_a>
|   1c:   a8c17bfd        ldp     x29, x30, [sp], #16
|   20:   d65f03c0        ret
|   24:   d503201f        nop
|   28:   d503201f        nop
|   2c:   d503201f        nop
| 
| 0000000000000030 <static_cold_func_b>:
|   30:   a9bf7bfd        stp     x29, x30, [sp, #-16]!
|   34:   910003fd        mov     x29, sp
|   38:   97fffff3        bl      4 <callee_b>
|   3c:   a8c17bfd        ldp     x29, x30, [sp], #16
|   40:   d65f03c0        ret
|   44:   d503201f        nop
|   48:   d503201f        nop
|   4c:   d503201f        nop
| 
| 0000000000000050 <static_cold_func_c>:
|   50:   a9bf7bfd        stp     x29, x30, [sp, #-16]!
|   54:   910003fd        mov     x29, sp
|   58:   97ffffec        bl      8 <callee_c>
|   5c:   a8c17bfd        ldp     x29, x30, [sp], #16
|   60:   d65f03c0        ret
|   64:   d503201f        nop
|   68:   d503201f        nop
|   6c:   d503201f        nop
| 
| 0000000000000070 <cold_func_a>:
|   70:   a9bf7bfd        stp     x29, x30, [sp, #-16]!
|   74:   910003fd        mov     x29, sp
|   78:   97ffffe2        bl      0 <callee_a>
|   7c:   a8c17bfd        ldp     x29, x30, [sp], #16
|   80:   d65f03c0        ret
|   84:   d503201f        nop
|   88:   d503201f        nop
|   8c:   d503201f        nop
| 
| 0000000000000090 <cold_func_b>:
|   90:   a9bf7bfd        stp     x29, x30, [sp, #-16]!
|   94:   910003fd        mov     x29, sp
|   98:   97ffffdb        bl      4 <callee_b>
|   9c:   a8c17bfd        ldp     x29, x30, [sp], #16
|   a0:   d65f03c0        ret
|   a4:   d503201f        nop
|   a8:   d503201f        nop
|   ac:   d503201f        nop
| 
| 00000000000000b0 <cold_func_c>:
|   b0:   a9bf7bfd        stp     x29, x30, [sp, #-16]!
|   b4:   910003fd        mov     x29, sp
|   b8:   97ffffd4        bl      8 <callee_c>
|   bc:   a8c17bfd        ldp     x29, x30, [sp], #16
|   c0:   d65f03c0        ret
| [mark@lakrids:/mnt/data/tests/gcc-alignment]% usekorg 12.1.0 aarch64-linux-objdump -h test-aligned-cold-caller.o
| 
| test-aligned-cold-caller.o:     file format elf64-littleaarch64
| 
| Sections:
| Idx Name          Size      VMA               LMA               File off  Algn
|   0 .text         000000c4  0000000000000000  0000000000000000  00000040  2**4
|                   CONTENTS, ALLOC, LOAD, READONLY, CODE
|   1 .data         00000018  0000000000000000  0000000000000000  00000108  2**3
|                   CONTENTS, ALLOC, LOAD, RELOC, DATA
|   2 .bss          00000000  0000000000000000  0000000000000000  00000120  2**0
|                   ALLOC
|   3 .comment      00000013  0000000000000000  0000000000000000  00000120  2**0
|                   CONTENTS, READONLY
|   4 .note.GNU-stack 00000000  0000000000000000  0000000000000000  00000133  2**0
|                   CONTENTS, READONLY
|   5 .eh_frame     00000110  0000000000000000  0000000000000000  00000138  2**3
|                   CONTENTS, ALLOC, LOAD, RELOC, READONLY, DATA

Thanks,
Mark.
