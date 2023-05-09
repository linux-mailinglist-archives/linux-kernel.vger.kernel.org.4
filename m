Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA59F6FC300
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 11:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234832AbjEIJmm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 05:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234663AbjEIJmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 05:42:38 -0400
Received: from out0-200.mail.aliyun.com (out0-200.mail.aliyun.com [140.205.0.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A8BA4211
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 02:42:34 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R901e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047211;MF=houwenlong.hwl@antgroup.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---.ScSlSmw_1683625346;
Received: from localhost(mailfrom:houwenlong.hwl@antgroup.com fp:SMTPD_---.ScSlSmw_1683625346)
          by smtp.aliyun-inc.com;
          Tue, 09 May 2023 17:42:27 +0800
Date:   Tue, 09 May 2023 17:42:26 +0800
From:   "Hou Wenlong" <houwenlong.hwl@antgroup.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     <linux-kernel@vger.kernel.org>,
        "Lai Jiangshan" <jiangshan.ljs@antgroup.com>,
        "Kees Cook" <keescook@chromium.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "Dave Hansen" <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Petr Mladek" <pmladek@suse.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        "Song Liu" <song@kernel.org>,
        "Julian Pidancet" <julian.pidancet@oracle.com>
Subject: Re: [PATCH RFC 31/43] x86/modules: Adapt module loading for PIE
 support
Message-ID: <20230509094226.GA74483@k08j02272.eu95sqa>
References: <cover.1682673542.git.houwenlong.hwl@antgroup.com>
 <c79285bfa4450fd5ad160ddd4919ac9ad826de04.1682673543.git.houwenlong.hwl@antgroup.com>
 <CAMj1kXH8E7AgvmJ-Spa+EwHSz7kcqd+AMGvtxRUo3jFD3PAWsQ@mail.gmail.com>
 <20230508083223.GA116442@k08j02272.eu95sqa>
 <CAMj1kXH1P4owoSV9OmRwEZyKritBFmCpQaa68EMrTHi0LvUrFg@mail.gmail.com>
 <20230508114010.GA62035@k08j02272.eu95sqa>
 <CAMj1kXGcO+r0u-8R_g0Ysbxgjmqj+q2fDD5USAAxqvStjE75oQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXGcO+r0u-8R_g0Ysbxgjmqj+q2fDD5USAAxqvStjE75oQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 09, 2023 at 01:47:53AM +0800, Ard Biesheuvel wrote:
> On Mon, 8 May 2023 at 13:45, Hou Wenlong <houwenlong.hwl@antgroup.com> wrote:
> >
> > On Mon, May 08, 2023 at 05:16:34PM +0800, Ard Biesheuvel wrote:
> > > On Mon, 8 May 2023 at 10:38, Hou Wenlong <houwenlong.hwl@antgroup.com> wrote:
> > > >
> > > > On Sat, Apr 29, 2023 at 03:29:32AM +0800, Ard Biesheuvel wrote:
> > > > > On Fri, 28 Apr 2023 at 10:53, Hou Wenlong <houwenlong.hwl@antgroup.com> wrote:
> > > > > >
> > > > > > Adapt module loading to support PIE relocations. No GOT is generared for
> > > > > > module, all the GOT entry of got references in module should exist in
> > > > > > kernel GOT.  Currently, there is only one usable got reference for
> > > > > > __fentry__().
> > > > > >
> > > > >
> > > > > I don't think this is the right approach. We should permit GOTPCREL
> > > > > relocations properly, which means making them point to a location in
> > > > > memory that carries the absolute address of the symbol. There are
> > > > > several ways to go about that, but perhaps the simplest way is to make
> > > > > the symbol address in ksymtab a 64-bit absolute value (but retain the
> > > > > PC32 references for the symbol name and the symbol namespace name).
> > > > > That way, you can always resolve such GOTPCREL relocations by pointing
> > > > > it to the ksymtab entry. Another option would be to take inspiration
> > > > > from the PLT code we have on ARM and arm64 (and other architectures,
> > > > > surely) and to count the GOT based relocations, allocate some extra
> > > > > r/o module space for each, and allocate slots and populate them with
> > > > > the right value as you fix up the relocations.
> > > > >
> > > > > Then, many such relocations can be relaxed at module load time if the
> > > > > symbol is in range. IIUC, the module and kernel will still be inside
> > > > > the same 2G window even after widening the KASLR range to 512G, so
> > > > > most GOT loads can be converted into RIP relative LEA instructions.
> > > > >
> > > > > Note that this will also permit you to do things like
> > > > >
> > > > > #define PV_VCPU_PREEMPTED_ASM \
> > > > >  "leaq __per_cpu_offset(%rip), %rax \n\t" \
> > > > >  "movq (%rax,%rdi,8), %rax \n\t" \
> > > > >  "addq steal_time@GOTPCREL(%rip), %rax \n\t" \
> > > > >  "cmpb $0, " __stringify(KVM_STEAL_TIME_preempted) "(%rax) \n\t" \
> > > > >  "setne %al\n\t"
> > > > >
> > > > > or
> > > > >
> > > > > +#ifdef CONFIG_X86_PIE
> > > > > + " pushq arch_rethook_trampoline@GOTPCREL(%rip)\n"
> > > > > +#else
> > > > > " pushq $arch_rethook_trampoline\n"
> > > > > +#endif
> > > > >
> > > > > instead of having these kludgy push/pop sequences to free up temp registers.
> > > > >
> > > > > (FYI I have looked into this PIE linking just a few weeks ago [0] so
> > > > > this is all rather fresh in my memory)
> > > > >
> > > > >
> > > > >
> > > > >
> > > > > [0] https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/log/?h=x86-pie
> > > > >
> > > > >
> > > > Hi Ard,
> > > > Thanks for providing the link, it has been very helpful for me as I am
> > > > new to the topic of compilers.
> > >
> > > Happy to hear that.
> > >
> >
> > Thanks for your prompt reply.
> >
> > > > One key difference I noticed is that you
> > > > linked the kernel with "-pie" instead of "--emit-reloc". I also noticed
> > > > that Thomas' initial patchset[0] used "-pie", but in RFC v3 [1], it
> > > > switched to "--emit-reloc" in order to reduce dynamic relocation space
> > > > on mapped memory.
> > > >
> > >
> > > The problem with --emit-relocs is that the relocations emitted into
> > > the binary may get out of sync with the actual code after the linker
> > > has applied relocations.
> > >
> > > $ cat /tmp/a.s
> > > foo:movq foo@GOTPCREL(%rip), %rax
> > >
> > > $ x86_64-linux-gnu-gcc -c -o /tmp/a.o /tmp/a.s
> > > ard@gambale:~/linux$ x86_64-linux-gnu-objdump -dr /tmp/a.o
> > >
> > > /tmp/a.o:     file format elf64-x86-64
> > >
> > >
> > > Disassembly of section .text:
> > >
> > > 0000000000000000 <foo>:
> > >    0: 48 8b 05 00 00 00 00 mov    0x0(%rip),%rax        # 7 <foo+0x7>
> > > 3: R_X86_64_REX_GOTPCRELX foo-0x4
> > >
> > > $ x86_64-linux-gnu-gcc -c -o /tmp/a.o /tmp/a.s
> > > $ x86_64-linux-gnu-objdump -dr /tmp/a.o
> > > 0000000000000000 <foo>:
> > >    0: 48 8b 05 00 00 00 00 mov    0x0(%rip),%rax        # 7 <foo+0x7>
> > > 3: R_X86_64_REX_GOTPCRELX foo-0x4
> > >
> > > $ x86_64-linux-gnu-gcc -o /tmp/a.elf -nostartfiles
> > > -Wl,-no-pie,-q,--defsym,_start=0x0 /tmp/a.s
> > > $ x86_64-linux-gnu-objdump -dr /tmp/a.elf
> > > 0000000000401000 <foo>:
> > >   401000: 48 c7 c0 00 10 40 00 mov    $0x401000,%rax
> > > 401003: R_X86_64_32S foo
> > >
> > > $ x86_64-linux-gnu-gcc -o /tmp/a.elf -nostartfiles
> > > -Wl,-q,--defsym,_start=0x0 /tmp/a.s
> > > $ x86_64-linux-gnu-objdump -dr /tmp/a.elf
> > > 0000000000001000 <foo>:
> > >     1000: 48 8d 05 f9 ff ff ff lea    -0x7(%rip),%rax        # 1000 <foo>
> > > 1003: R_X86_64_PC32 foo-0x4
> > >
> > > This all looks as expected. However, when using Clang, we end up with
> > >
> > > $ clang -target x86_64-linux-gnu -o /tmp/a.elf -nostartfiles
> > > -fuse-ld=lld -Wl,--relax,-q,--defsym,_start=0x0 /tmp/a.s
> > > $ x86_64-linux-gnu-objdump -dr /tmp/a.elf
> > > 00000000000012c0 <foo>:
> > >     12c0: 48 8d 05 f9 ff ff ff lea    -0x7(%rip),%rax        # 12c0 <foo>
> > > 12c3: R_X86_64_REX_GOTPCRELX foo-0x4
> > >
> > > So in this case, what --emit-relocs gives us is not what is actually
> > > in the binary. We cannot just ignore these either, given that they are
> > > treated differently depending on whether the symbol is a per-CPU
> > > symbol or not - in the former case, we need to perform a fixup if the
> > > relaxed reference is RIP relative, and in the latter case, if the
> > > relaxed reference is absolute.
> > >
> > With symbols hidden and the compile-time address of the kernel image
> > kept in the top 2G, is it possible for the relaxed reference to be
> > absolute, even if I keep the percpu section zero-mapping for SMP?  I
> > didn't see absoulte relaxed reference after dropping
> > "-mrelax-relocations=no" option.
> >
> 
> If you link in PIE mode, you should never see absolute references
> after relaxation.
> 
> > > On top of that, --emit-relocs does not cover the GOT, so we'd still
> > > need to process that from the code explicitly.
> > >
> > Yes, so the relocs tool would process GOT, and generate
> > R_X86_64_GLOB_DAT relocation for GOT entries in patch 27:
> > https://lore.kernel.org/lkml/d25c7644249355785365914398bdba1ed2c52468.1682673543.git.houwenlong.hwl@antgroup.com
> >
> 
> Yes, something like that is needed. I'd lean towards generating the
> reloc data directly instead of creating an artifiical RELA section
> with GLOB_DAT relocations, but that is a minor detail.
> 
> > > In general, relying on --emit-relocs is kind of dodgy, and I think
> > > combining PIE linking with --emit-relocs is a bad idea.
> > >
> > > > The another issue is that it requires the addition of the
> > > > "-mrelax-relocations=no" option to support older compilers and linkers.
> > >
> > > Why? The decompressor is now linked in PIE mode so we should be able
> > > to drop that. Or do you need to add is somewhere else?
> > >
> > I tried to use binutils 2.25 (mini version), it couldn't recognize
> > R_X86_64_GOTPCRELX and R_X86_64_REX_GOTPCRELX.
> >
> 
> I'm not sure that matters. If the assembler accepts @GOTPCREL
> notation, it should generate the relocations that the linker can
> understand. If the toolchain is not internally consistent in this
> regard, I don't think it is our problem.
>
I get it. Thanks.
 
> This might mean that we end up with more residual GOT entries than
> with a more recent toolchain, but I don't think that is a big deal.
> 
> > > > R_X86_64_GOTPCRELX and R_X86_64_REX_GOTPCRELX relocations are supported
> > > > in binutils 2.26 and later, but the mini version required for the kernel
> > > > is 2.25. This option disables relocation relaxation, which makes GOT not
> > > > empty. I also noticed this option in arch/x86/boot/compressed/Makefile
> > > > with the reason given in [2]. Without relocation relaxation, GOT
> > > > references would increase the size of GOT. Therefore, I do not want to
> > > > use GOT reference in assembly directly.  However, I realized that the
> > > > compiler could still generate GOT references in some cases such as
> > > > "fentry" calls and stack canary references.
> > > >
> > >
> > > The stack canary references are under discussion here [3]. I have also
> > > sent a patch for kallsyms symbol references [4]. Beyond that, there
> > > should be very few cases where GOT entries are emitted, so I don't
> > > think this is fundamentally a problem.
> > >
> > > I haven't run into the __fentry__ issue myself: do you think we should
> > > fix this in the compiler?
> > >
> > The issue about __fentry__ is that the compiler would generate 6-bytes
> > indirect call through GOT with "-fPIE" option. However, the original
> > ftrace nop patching assumes it is a 5-bytes direct call. And
> > "-mnop-mcount" option is not compatiable with "-fPIE" option, so the
> > complier woudn't patch it as nop.
> >
> > So we should patch it with one 5-bytes nop followed by one 1-byte nop,
> > This way, ftrace can handle the previous 5-bytes as before. Also I have
> > built PIE kernel with relocation relaxation on GCC, and the linker would
> > relax it as following:
> > ffffffff810018f0 <do_one_initcall>:
> > ffffffff810018f0:       f3 0f 1e fa             endbr64
> > ffffffff810018f4:       67 e8 a6 d6 05 00       addr32 call ffffffff8105efa0 <__fentry__>
> >                         ffffffff810018f6: R_X86_64_PC32 __fentry__-0x4
> >
> 
> But if fentry is a function symbol, I would not expect the codegen to
> be different at all. Are you using -fno-plt?
>
No, even with -fno-plt added, the compiler still generates a GOT
reference for fentry. Therefore, the problem may be visibility, as you
said.

> > It still requires a different nop patching for ftrace. I notice
> > "Optimize GOTPCRELX Relocations" chapter in x86-64 psABI, which suggests
> > that the GOT indirect call can be relaxed as "call fentry nop" or "nop
> > call fentry", it appears that the latter is chosen. If the linker could
> > generate the former, then no fixup would be necessary for ftrace with
> > PIE.
> >
> 
> Right. I think this may be a result of __fentry__ not being subject to
> the same rules wrt visibility etc, similar to __stack_chk_guard. These
> are arguably compiler issues that could qualify as bugs, given that
> these symbol references don't behave like ordinary symbol references.
> 
> > > > Regarding module loading, I agree that we should support GOT reference
> > > > for the module itself. I will refactor it according to your suggestion.
> > > >
> > >
> > > Excellent, good luck with that.
> > >
> > > However, you will still need to make a convincing case for why this is
> > > all worth the trouble. Especially given that you disable the depth
> > > tracking code, which I don't think should be mutually exclusive.
> > >
> > Actually, I could do relocation for it when apply patching for the
> > depth tracking code. I'm not sure such case is common or not.
> >
> 
> I think that alternatives patching in general would need to support
> RIP relative references in the alternatives. The depth tracking
> template is a bit different in this regard, and could be fixed more
> easily, I think.
> 
> > > I am aware that this a rather tricky, and involves rewriting
> > > RIP-relative per-CPU variable accesses, but it would be good to get a
> > > discussion started on that topic, and figure out whether there is a
> > > way forward there. Ignoring it is not going to help.
> > >
> > >
> > I see that your PIE linking chose to put the per-cpu section in high
> > kernel image address, I still keep it as zero-mapping. However, both are
> > in the RIP-relative addressing range.
> >
> 
> Pure PIE linking cannot support the zero mapping - it can only work
> with --emit-relocs, which I was trying to avoid.
Sorry, why doesn't PIE linking support zero mapping? I noticed in the
commit message for your PIE linking that it stated, "if we randomize the
kernel's VA by increasing it by X bytes, every RIP-relative per-CPU
reference needs to be decreased by the same amount in order for the
produced offset to remain correct." As a result, I decided to decrease
the GS base and not relocate the RIP-relative per-CPU reference in the
relocs. Consequently, all RIP-relative references, regardless of whether
they are per-CPU variables or not, do not require relocation.

Furthermore, all symbols are hidden, which implies that all per-CPU
references will not generate a GOT reference and will be relaxed as
absolute reference due to zero mapping. However, the __stack_chk_guard
on CLANG always generates a GOT reference, but I didn't see it being
relaxed as absolute reference on LLVM.

Thanks!
