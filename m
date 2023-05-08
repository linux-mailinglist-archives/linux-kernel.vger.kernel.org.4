Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A0326FA24B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 10:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232840AbjEHIcg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 04:32:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjEHIce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 04:32:34 -0400
Received: from out0-211.mail.aliyun.com (out0-211.mail.aliyun.com [140.205.0.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31AB626B1
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 01:32:32 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R331e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047188;MF=houwenlong.hwl@antgroup.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---.SbR-kOs_1683534743;
Received: from localhost(mailfrom:houwenlong.hwl@antgroup.com fp:SMTPD_---.SbR-kOs_1683534743)
          by smtp.aliyun-inc.com;
          Mon, 08 May 2023 16:32:24 +0800
Date:   Mon, 08 May 2023 16:32:23 +0800
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
Message-ID: <20230508083223.GA116442@k08j02272.eu95sqa>
References: <cover.1682673542.git.houwenlong.hwl@antgroup.com>
 <c79285bfa4450fd5ad160ddd4919ac9ad826de04.1682673543.git.houwenlong.hwl@antgroup.com>
 <CAMj1kXH8E7AgvmJ-Spa+EwHSz7kcqd+AMGvtxRUo3jFD3PAWsQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXH8E7AgvmJ-Spa+EwHSz7kcqd+AMGvtxRUo3jFD3PAWsQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 29, 2023 at 03:29:32AM +0800, Ard Biesheuvel wrote:
> On Fri, 28 Apr 2023 at 10:53, Hou Wenlong <houwenlong.hwl@antgroup.com> wrote:
> >
> > Adapt module loading to support PIE relocations. No GOT is generared for
> > module, all the GOT entry of got references in module should exist in
> > kernel GOT.  Currently, there is only one usable got reference for
> > __fentry__().
> >
> 
> I don't think this is the right approach. We should permit GOTPCREL
> relocations properly, which means making them point to a location in
> memory that carries the absolute address of the symbol. There are
> several ways to go about that, but perhaps the simplest way is to make
> the symbol address in ksymtab a 64-bit absolute value (but retain the
> PC32 references for the symbol name and the symbol namespace name).
> That way, you can always resolve such GOTPCREL relocations by pointing
> it to the ksymtab entry. Another option would be to take inspiration
> from the PLT code we have on ARM and arm64 (and other architectures,
> surely) and to count the GOT based relocations, allocate some extra
> r/o module space for each, and allocate slots and populate them with
> the right value as you fix up the relocations.
> 
> Then, many such relocations can be relaxed at module load time if the
> symbol is in range. IIUC, the module and kernel will still be inside
> the same 2G window even after widening the KASLR range to 512G, so
> most GOT loads can be converted into RIP relative LEA instructions.
> 
> Note that this will also permit you to do things like
> 
> #define PV_VCPU_PREEMPTED_ASM \
>  "leaq __per_cpu_offset(%rip), %rax \n\t" \
>  "movq (%rax,%rdi,8), %rax \n\t" \
>  "addq steal_time@GOTPCREL(%rip), %rax \n\t" \
>  "cmpb $0, " __stringify(KVM_STEAL_TIME_preempted) "(%rax) \n\t" \
>  "setne %al\n\t"
> 
> or
> 
> +#ifdef CONFIG_X86_PIE
> + " pushq arch_rethook_trampoline@GOTPCREL(%rip)\n"
> +#else
> " pushq $arch_rethook_trampoline\n"
> +#endif
> 
> instead of having these kludgy push/pop sequences to free up temp registers.
> 
> (FYI I have looked into this PIE linking just a few weeks ago [0] so
> this is all rather fresh in my memory)
> 
> 
> 
> 
> [0] https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/log/?h=x86-pie
> 
>
Hi Ard,
Thanks for providing the link, it has been very helpful for me as I am
new to the topic of compilers. One key difference I noticed is that you
linked the kernel with "-pie" instead of "--emit-reloc". I also noticed
that Thomas' initial patchset[0] used "-pie", but in RFC v3 [1], it
switched to "--emit-reloc" in order to reduce dynamic relocation space
on mapped memory.

The another issue is that it requires the addition of the
"-mrelax-relocations=no" option to support older compilers and linkers.
R_X86_64_GOTPCRELX and R_X86_64_REX_GOTPCRELX relocations are supported
in binutils 2.26 and later, but the mini version required for the kernel
is 2.25. This option disables relocation relaxation, which makes GOT not
empty. I also noticed this option in arch/x86/boot/compressed/Makefile
with the reason given in [2]. Without relocation relaxation, GOT
references would increase the size of GOT. Therefore, I do not want to
use GOT reference in assembly directly.  However, I realized that the
compiler could still generate GOT references in some cases such as
"fentry" calls and stack canary references.

Regarding module loading, I agree that we should support GOT reference
for the module itself. I will refactor it according to your suggestion.

Thanks.

[0] https://yhbt.net/lore/all/20170718223333.110371-20-thgarnie@google.com
[1] https://yhbt.net/lore/all/20171004212003.28296-1-thgarnie@google.com
[2] https://lore.kernel.org/all/20200903203053.3411268-2-samitolvanen@google.com/

> > Signed-off-by: Hou Wenlong <houwenlong.hwl@antgroup.com>
> > Cc: Thomas Garnier <thgarnie@chromium.org>
> > Cc: Lai Jiangshan <jiangshan.ljs@antgroup.com>
> > Cc: Kees Cook <keescook@chromium.org>
> > ---
> >  arch/x86/include/asm/sections.h |  5 +++++
> >  arch/x86/kernel/module.c        | 27 +++++++++++++++++++++++++++
> >  2 files changed, 32 insertions(+)
> >
> > diff --git a/arch/x86/include/asm/sections.h b/arch/x86/include/asm/sections.h
> > index a6e8373a5170..dc1c2b08ec48 100644
> > --- a/arch/x86/include/asm/sections.h
> > +++ b/arch/x86/include/asm/sections.h
> > @@ -12,6 +12,11 @@ extern char __end_rodata_aligned[];
> >
> >  #if defined(CONFIG_X86_64)
> >  extern char __end_rodata_hpage_align[];
> > +
> > +#ifdef CONFIG_X86_PIE
> > +extern char __start_got[], __end_got[];
> > +#endif
> > +
> >  #endif
> >
> >  extern char __end_of_kernel_reserve[];
> > diff --git a/arch/x86/kernel/module.c b/arch/x86/kernel/module.c
> > index 84ad0e61ba6e..051f88e6884e 100644
> > --- a/arch/x86/kernel/module.c
> > +++ b/arch/x86/kernel/module.c
> > @@ -129,6 +129,18 @@ int apply_relocate(Elf32_Shdr *sechdrs,
> >         return 0;
> >  }
> >  #else /*X86_64*/
> > +#ifdef CONFIG_X86_PIE
> > +static u64 find_got_kernel_entry(Elf64_Sym *sym, const Elf64_Rela *rela)
> > +{
> > +       u64 *pos;
> > +
> > +       for (pos = (u64 *)__start_got; pos < (u64 *)__end_got; pos++)
> > +               if (*pos == sym->st_value)
> > +                       return (u64)pos + rela->r_addend;
> > +       return 0;
> > +}
> > +#endif
> > +
> >  static int __write_relocate_add(Elf64_Shdr *sechdrs,
> >                    const char *strtab,
> >                    unsigned int symindex,
> > @@ -171,6 +183,7 @@ static int __write_relocate_add(Elf64_Shdr *sechdrs,
> >                 case R_X86_64_64:
> >                         size = 8;
> >                         break;
> > +#ifndef CONFIG_X86_PIE
> >                 case R_X86_64_32:
> >                         if (val != *(u32 *)&val)
> >                                 goto overflow;
> > @@ -181,6 +194,13 @@ static int __write_relocate_add(Elf64_Shdr *sechdrs,
> >                                 goto overflow;
> >                         size = 4;
> >                         break;
> > +#else
> > +               case R_X86_64_GOTPCREL:
> > +                       val = find_got_kernel_entry(sym, rel);
> > +                       if (!val)
> > +                               goto unexpected_got_reference;
> > +                       fallthrough;
> > +#endif
> >                 case R_X86_64_PC32:
> >                 case R_X86_64_PLT32:
> >                         val -= (u64)loc;
> > @@ -214,11 +234,18 @@ static int __write_relocate_add(Elf64_Shdr *sechdrs,
> >         }
> >         return 0;
> >
> > +#ifdef CONFIG_X86_PIE
> > +unexpected_got_reference:
> > +       pr_err("Target got entry doesn't exist in kernel got, loc %p\n", loc);
> > +       return -ENOEXEC;
> > +#else
> >  overflow:
> >         pr_err("overflow in relocation type %d val %Lx\n",
> >                (int)ELF64_R_TYPE(rel[i].r_info), val);
> >         pr_err("`%s' likely not compiled with -mcmodel=kernel\n",
> >                me->name);
> > +#endif
> > +
> >         return -ENOEXEC;
> >  }
> >
> > --
> > 2.31.1
> >
