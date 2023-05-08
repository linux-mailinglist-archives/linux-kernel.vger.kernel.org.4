Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C25C6FAE14
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 13:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236161AbjEHLkv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 07:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236147AbjEHLkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 07:40:23 -0400
Received: from out0-205.mail.aliyun.com (out0-205.mail.aliyun.com [140.205.0.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D06144510
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 04:40:18 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047201;MF=houwenlong.hwl@antgroup.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---.Sba47YZ_1683546010;
Received: from localhost(mailfrom:houwenlong.hwl@antgroup.com fp:SMTPD_---.Sba47YZ_1683546010)
          by smtp.aliyun-inc.com;
          Mon, 08 May 2023 19:40:11 +0800
Date:   Mon, 08 May 2023 19:40:10 +0800
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
Message-ID: <20230508114010.GA62035@k08j02272.eu95sqa>
References: <cover.1682673542.git.houwenlong.hwl@antgroup.com>
 <c79285bfa4450fd5ad160ddd4919ac9ad826de04.1682673543.git.houwenlong.hwl@antgroup.com>
 <CAMj1kXH8E7AgvmJ-Spa+EwHSz7kcqd+AMGvtxRUo3jFD3PAWsQ@mail.gmail.com>
 <20230508083223.GA116442@k08j02272.eu95sqa>
 <CAMj1kXH1P4owoSV9OmRwEZyKritBFmCpQaa68EMrTHi0LvUrFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXH1P4owoSV9OmRwEZyKritBFmCpQaa68EMrTHi0LvUrFg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLACK
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 08, 2023 at 05:16:34PM +0800, Ard Biesheuvel wrote:
> On Mon, 8 May 2023 at 10:38, Hou Wenlong <houwenlong.hwl@antgroup.com> wrote:
> >
> > On Sat, Apr 29, 2023 at 03:29:32AM +0800, Ard Biesheuvel wrote:
> > > On Fri, 28 Apr 2023 at 10:53, Hou Wenlong <houwenlong.hwl@antgroup.com> wrote:
> > > >
> > > > Adapt module loading to support PIE relocations. No GOT is generared for
> > > > module, all the GOT entry of got references in module should exist in
> > > > kernel GOT.  Currently, there is only one usable got reference for
> > > > __fentry__().
> > > >
> > >
> > > I don't think this is the right approach. We should permit GOTPCREL
> > > relocations properly, which means making them point to a location in
> > > memory that carries the absolute address of the symbol. There are
> > > several ways to go about that, but perhaps the simplest way is to make
> > > the symbol address in ksymtab a 64-bit absolute value (but retain the
> > > PC32 references for the symbol name and the symbol namespace name).
> > > That way, you can always resolve such GOTPCREL relocations by pointing
> > > it to the ksymtab entry. Another option would be to take inspiration
> > > from the PLT code we have on ARM and arm64 (and other architectures,
> > > surely) and to count the GOT based relocations, allocate some extra
> > > r/o module space for each, and allocate slots and populate them with
> > > the right value as you fix up the relocations.
> > >
> > > Then, many such relocations can be relaxed at module load time if the
> > > symbol is in range. IIUC, the module and kernel will still be inside
> > > the same 2G window even after widening the KASLR range to 512G, so
> > > most GOT loads can be converted into RIP relative LEA instructions.
> > >
> > > Note that this will also permit you to do things like
> > >
> > > #define PV_VCPU_PREEMPTED_ASM \
> > >  "leaq __per_cpu_offset(%rip), %rax \n\t" \
> > >  "movq (%rax,%rdi,8), %rax \n\t" \
> > >  "addq steal_time@GOTPCREL(%rip), %rax \n\t" \
> > >  "cmpb $0, " __stringify(KVM_STEAL_TIME_preempted) "(%rax) \n\t" \
> > >  "setne %al\n\t"
> > >
> > > or
> > >
> > > +#ifdef CONFIG_X86_PIE
> > > + " pushq arch_rethook_trampoline@GOTPCREL(%rip)\n"
> > > +#else
> > > " pushq $arch_rethook_trampoline\n"
> > > +#endif
> > >
> > > instead of having these kludgy push/pop sequences to free up temp registers.
> > >
> > > (FYI I have looked into this PIE linking just a few weeks ago [0] so
> > > this is all rather fresh in my memory)
> > >
> > >
> > >
> > >
> > > [0] https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/log/?h=x86-pie
> > >
> > >
> > Hi Ard,
> > Thanks for providing the link, it has been very helpful for me as I am
> > new to the topic of compilers.
> 
> Happy to hear that.
>
 
Thanks for your prompt reply.

> > One key difference I noticed is that you
> > linked the kernel with "-pie" instead of "--emit-reloc". I also noticed
> > that Thomas' initial patchset[0] used "-pie", but in RFC v3 [1], it
> > switched to "--emit-reloc" in order to reduce dynamic relocation space
> > on mapped memory.
> >
> 
> The problem with --emit-relocs is that the relocations emitted into
> the binary may get out of sync with the actual code after the linker
> has applied relocations.
> 
> $ cat /tmp/a.s
> foo:movq foo@GOTPCREL(%rip), %rax
> 
> $ x86_64-linux-gnu-gcc -c -o /tmp/a.o /tmp/a.s
> ard@gambale:~/linux$ x86_64-linux-gnu-objdump -dr /tmp/a.o
> 
> /tmp/a.o:     file format elf64-x86-64
> 
> 
> Disassembly of section .text:
> 
> 0000000000000000 <foo>:
>    0: 48 8b 05 00 00 00 00 mov    0x0(%rip),%rax        # 7 <foo+0x7>
> 3: R_X86_64_REX_GOTPCRELX foo-0x4
> 
> $ x86_64-linux-gnu-gcc -c -o /tmp/a.o /tmp/a.s
> $ x86_64-linux-gnu-objdump -dr /tmp/a.o
> 0000000000000000 <foo>:
>    0: 48 8b 05 00 00 00 00 mov    0x0(%rip),%rax        # 7 <foo+0x7>
> 3: R_X86_64_REX_GOTPCRELX foo-0x4
> 
> $ x86_64-linux-gnu-gcc -o /tmp/a.elf -nostartfiles
> -Wl,-no-pie,-q,--defsym,_start=0x0 /tmp/a.s
> $ x86_64-linux-gnu-objdump -dr /tmp/a.elf
> 0000000000401000 <foo>:
>   401000: 48 c7 c0 00 10 40 00 mov    $0x401000,%rax
> 401003: R_X86_64_32S foo
> 
> $ x86_64-linux-gnu-gcc -o /tmp/a.elf -nostartfiles
> -Wl,-q,--defsym,_start=0x0 /tmp/a.s
> $ x86_64-linux-gnu-objdump -dr /tmp/a.elf
> 0000000000001000 <foo>:
>     1000: 48 8d 05 f9 ff ff ff lea    -0x7(%rip),%rax        # 1000 <foo>
> 1003: R_X86_64_PC32 foo-0x4
> 
> This all looks as expected. However, when using Clang, we end up with
> 
> $ clang -target x86_64-linux-gnu -o /tmp/a.elf -nostartfiles
> -fuse-ld=lld -Wl,--relax,-q,--defsym,_start=0x0 /tmp/a.s
> $ x86_64-linux-gnu-objdump -dr /tmp/a.elf
> 00000000000012c0 <foo>:
>     12c0: 48 8d 05 f9 ff ff ff lea    -0x7(%rip),%rax        # 12c0 <foo>
> 12c3: R_X86_64_REX_GOTPCRELX foo-0x4
> 
> So in this case, what --emit-relocs gives us is not what is actually
> in the binary. We cannot just ignore these either, given that they are
> treated differently depending on whether the symbol is a per-CPU
> symbol or not - in the former case, we need to perform a fixup if the
> relaxed reference is RIP relative, and in the latter case, if the
> relaxed reference is absolute.
>
With symbols hidden and the compile-time address of the kernel image
kept in the top 2G, is it possible for the relaxed reference to be
absolute, even if I keep the percpu section zero-mapping for SMP?  I
didn't see absoulte relaxed reference after dropping
"-mrelax-relocations=no" option.

> On top of that, --emit-relocs does not cover the GOT, so we'd still
> need to process that from the code explicitly.
>
Yes, so the relocs tool would process GOT, and generate
R_X86_64_GLOB_DAT relocation for GOT entries in patch 27:
https://lore.kernel.org/lkml/d25c7644249355785365914398bdba1ed2c52468.1682673543.git.houwenlong.hwl@antgroup.com

> In general, relying on --emit-relocs is kind of dodgy, and I think
> combining PIE linking with --emit-relocs is a bad idea.
> 
> > The another issue is that it requires the addition of the
> > "-mrelax-relocations=no" option to support older compilers and linkers.
> 
> Why? The decompressor is now linked in PIE mode so we should be able
> to drop that. Or do you need to add is somewhere else?
>
I tried to use binutils 2.25 (mini version), it couldn't recognize
R_X86_64_GOTPCRELX and R_X86_64_REX_GOTPCRELX.

> > R_X86_64_GOTPCRELX and R_X86_64_REX_GOTPCRELX relocations are supported
> > in binutils 2.26 and later, but the mini version required for the kernel
> > is 2.25. This option disables relocation relaxation, which makes GOT not
> > empty. I also noticed this option in arch/x86/boot/compressed/Makefile
> > with the reason given in [2]. Without relocation relaxation, GOT
> > references would increase the size of GOT. Therefore, I do not want to
> > use GOT reference in assembly directly.  However, I realized that the
> > compiler could still generate GOT references in some cases such as
> > "fentry" calls and stack canary references.
> >
> 
> The stack canary references are under discussion here [3]. I have also
> sent a patch for kallsyms symbol references [4]. Beyond that, there
> should be very few cases where GOT entries are emitted, so I don't
> think this is fundamentally a problem.
> 
> I haven't run into the __fentry__ issue myself: do you think we should
> fix this in the compiler?
>
The issue about __fentry__ is that the compiler would generate 6-bytes
indirect call through GOT with "-fPIE" option. However, the original
ftrace nop patching assumes it is a 5-bytes direct call. And
"-mnop-mcount" option is not compatiable with "-fPIE" option, so the
complier woudn't patch it as nop.

So we should patch it with one 5-bytes nop followed by one 1-byte nop,
This way, ftrace can handle the previous 5-bytes as before. Also I have
built PIE kernel with relocation relaxation on GCC, and the linker would
relax it as following:
ffffffff810018f0 <do_one_initcall>:
ffffffff810018f0:       f3 0f 1e fa             endbr64
ffffffff810018f4:       67 e8 a6 d6 05 00       addr32 call ffffffff8105efa0 <__fentry__>
			ffffffff810018f6: R_X86_64_PC32 __fentry__-0x4

It still requires a different nop patching for ftrace. I notice
"Optimize GOTPCRELX Relocations" chapter in x86-64 psABI, which suggests
that the GOT indirect call can be relaxed as "call fentry nop" or "nop
call fentry", it appears that the latter is chosen. If the linker could
generate the former, then no fixup would be necessary for ftrace with
PIE.

> > Regarding module loading, I agree that we should support GOT reference
> > for the module itself. I will refactor it according to your suggestion.
> >
> 
> Excellent, good luck with that.
> 
> However, you will still need to make a convincing case for why this is
> all worth the trouble. Especially given that you disable the depth
> tracking code, which I don't think should be mutually exclusive.
>
Actually, I could do relocation for it when apply patching for the
depth tracking code. I'm not sure such case is common or not.

> I am aware that this a rather tricky, and involves rewriting
> RIP-relative per-CPU variable accesses, but it would be good to get a
> discussion started on that topic, and figure out whether there is a
> way forward there. Ignoring it is not going to help.
> 
>
I see that your PIE linking chose to put the per-cpu section in high
kernel image address, I still keep it as zero-mapping. However, both are
in the RIP-relative addressing range.

> >
> > [0] https://yhbt.net/lore/all/20170718223333.110371-20-thgarnie@google.com
> > [1] https://yhbt.net/lore/all/20171004212003.28296-1-thgarnie@google.com
> > [2] https://lore.kernel.org/all/20200903203053.3411268-2-samitolvanen@google.com/
> >
> 
> [3] https://github.com/llvm/llvm-project/issues/60116
> [4] 20230504174320.3930345-1-ardb@kernel.org
> 
> > > > Signed-off-by: Hou Wenlong <houwenlong.hwl@antgroup.com>
> > > > Cc: Thomas Garnier <thgarnie@chromium.org>
> > > > Cc: Lai Jiangshan <jiangshan.ljs@antgroup.com>
> > > > Cc: Kees Cook <keescook@chromium.org>
> > > > ---
> > > >  arch/x86/include/asm/sections.h |  5 +++++
> > > >  arch/x86/kernel/module.c        | 27 +++++++++++++++++++++++++++
> > > >  2 files changed, 32 insertions(+)
> > > >
> > > > diff --git a/arch/x86/include/asm/sections.h b/arch/x86/include/asm/sections.h
> > > > index a6e8373a5170..dc1c2b08ec48 100644
> > > > --- a/arch/x86/include/asm/sections.h
> > > > +++ b/arch/x86/include/asm/sections.h
> > > > @@ -12,6 +12,11 @@ extern char __end_rodata_aligned[];
> > > >
> > > >  #if defined(CONFIG_X86_64)
> > > >  extern char __end_rodata_hpage_align[];
> > > > +
> > > > +#ifdef CONFIG_X86_PIE
> > > > +extern char __start_got[], __end_got[];
> > > > +#endif
> > > > +
> > > >  #endif
> > > >
> > > >  extern char __end_of_kernel_reserve[];
> > > > diff --git a/arch/x86/kernel/module.c b/arch/x86/kernel/module.c
> > > > index 84ad0e61ba6e..051f88e6884e 100644
> > > > --- a/arch/x86/kernel/module.c
> > > > +++ b/arch/x86/kernel/module.c
> > > > @@ -129,6 +129,18 @@ int apply_relocate(Elf32_Shdr *sechdrs,
> > > >         return 0;
> > > >  }
> > > >  #else /*X86_64*/
> > > > +#ifdef CONFIG_X86_PIE
> > > > +static u64 find_got_kernel_entry(Elf64_Sym *sym, const Elf64_Rela *rela)
> > > > +{
> > > > +       u64 *pos;
> > > > +
> > > > +       for (pos = (u64 *)__start_got; pos < (u64 *)__end_got; pos++)
> > > > +               if (*pos == sym->st_value)
> > > > +                       return (u64)pos + rela->r_addend;
> > > > +       return 0;
> > > > +}
> > > > +#endif
> > > > +
> > > >  static int __write_relocate_add(Elf64_Shdr *sechdrs,
> > > >                    const char *strtab,
> > > >                    unsigned int symindex,
> > > > @@ -171,6 +183,7 @@ static int __write_relocate_add(Elf64_Shdr *sechdrs,
> > > >                 case R_X86_64_64:
> > > >                         size = 8;
> > > >                         break;
> > > > +#ifndef CONFIG_X86_PIE
> > > >                 case R_X86_64_32:
> > > >                         if (val != *(u32 *)&val)
> > > >                                 goto overflow;
> > > > @@ -181,6 +194,13 @@ static int __write_relocate_add(Elf64_Shdr *sechdrs,
> > > >                                 goto overflow;
> > > >                         size = 4;
> > > >                         break;
> > > > +#else
> > > > +               case R_X86_64_GOTPCREL:
> > > > +                       val = find_got_kernel_entry(sym, rel);
> > > > +                       if (!val)
> > > > +                               goto unexpected_got_reference;
> > > > +                       fallthrough;
> > > > +#endif
> > > >                 case R_X86_64_PC32:
> > > >                 case R_X86_64_PLT32:
> > > >                         val -= (u64)loc;
> > > > @@ -214,11 +234,18 @@ static int __write_relocate_add(Elf64_Shdr *sechdrs,
> > > >         }
> > > >         return 0;
> > > >
> > > > +#ifdef CONFIG_X86_PIE
> > > > +unexpected_got_reference:
> > > > +       pr_err("Target got entry doesn't exist in kernel got, loc %p\n", loc);
> > > > +       return -ENOEXEC;
> > > > +#else
> > > >  overflow:
> > > >         pr_err("overflow in relocation type %d val %Lx\n",
> > > >                (int)ELF64_R_TYPE(rel[i].r_info), val);
> > > >         pr_err("`%s' likely not compiled with -mcmodel=kernel\n",
> > > >                me->name);
> > > > +#endif
> > > > +
> > > >         return -ENOEXEC;
> > > >  }
> > > >
> > > > --
> > > > 2.31.1
> > > >
