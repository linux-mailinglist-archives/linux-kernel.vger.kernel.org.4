Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62AD16F1EC1
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 21:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346466AbjD1T3t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 15:29:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbjD1T3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 15:29:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBCAF46BB
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 12:29:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 869AD61715
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 19:29:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7682C4339C
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 19:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682710185;
        bh=QKguWFLbbI7d4svreGMBv35p89ryQk/ULJHDVtmUiYU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=M+sQjkKSZY5EZmspMWPPIZvxkwzjohIANsRPBfTHZQX+a47IQBkiDtoplAbXfqB5j
         rpmk7nFiFPQ0UmcXfS0YY7jxiwRxESh5muO6TClweh9yQReqO6eaBQoKhJXMAVeCbs
         xvSjk1eQgN8k39VpiiYDq5VsPxa+SDVT9/TiPe7KzdeUB85FTPNMGAVQy3mpsyx5Tq
         h1GYx5z7hbKcl1LJDnvhCPo0TIa4/2WN9mwv8uUay9zstGr/NVe/oBjlX408vCIcHH
         DsBOYXusIVeZGBoR7vMCtEid3L/Ba/9RdCS8nSVsMk10oSPrsHGh9yqMoF72KC+5v5
         WnEUtlgSIYotA==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-4efe8b3f3f7so306051e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 12:29:45 -0700 (PDT)
X-Gm-Message-State: AC+VfDx2/v0i2xJxnnqsr11ATz0ZS5ju6i1HovBddYyeEGLJC753NVGQ
        UpoaT5petNUqJxFvEkQr789LYNl5iB6BKVAGlug=
X-Google-Smtp-Source: ACHHUZ5iAqPS8HhF37ixgYBKbfHgv7kBwkrtBnsO6iJIppW06OoGWUXFL7MZZzukAZYIopN8jY60TZ8X8+PSlbocDk8=
X-Received: by 2002:a19:f010:0:b0:4f0:24b:7f64 with SMTP id
 p16-20020a19f010000000b004f0024b7f64mr1945138lfc.4.1682710183932; Fri, 28 Apr
 2023 12:29:43 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1682673542.git.houwenlong.hwl@antgroup.com> <c79285bfa4450fd5ad160ddd4919ac9ad826de04.1682673543.git.houwenlong.hwl@antgroup.com>
In-Reply-To: <c79285bfa4450fd5ad160ddd4919ac9ad826de04.1682673543.git.houwenlong.hwl@antgroup.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 28 Apr 2023 20:29:32 +0100
X-Gmail-Original-Message-ID: <CAMj1kXH8E7AgvmJ-Spa+EwHSz7kcqd+AMGvtxRUo3jFD3PAWsQ@mail.gmail.com>
Message-ID: <CAMj1kXH8E7AgvmJ-Spa+EwHSz7kcqd+AMGvtxRUo3jFD3PAWsQ@mail.gmail.com>
Subject: Re: [PATCH RFC 31/43] x86/modules: Adapt module loading for PIE support
To:     Hou Wenlong <houwenlong.hwl@antgroup.com>
Cc:     linux-kernel@vger.kernel.org,
        Lai Jiangshan <jiangshan.ljs@antgroup.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>, Song Liu <song@kernel.org>,
        Julian Pidancet <julian.pidancet@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Apr 2023 at 10:53, Hou Wenlong <houwenlong.hwl@antgroup.com> wrote:
>
> Adapt module loading to support PIE relocations. No GOT is generared for
> module, all the GOT entry of got references in module should exist in
> kernel GOT.  Currently, there is only one usable got reference for
> __fentry__().
>

I don't think this is the right approach. We should permit GOTPCREL
relocations properly, which means making them point to a location in
memory that carries the absolute address of the symbol. There are
several ways to go about that, but perhaps the simplest way is to make
the symbol address in ksymtab a 64-bit absolute value (but retain the
PC32 references for the symbol name and the symbol namespace name).
That way, you can always resolve such GOTPCREL relocations by pointing
it to the ksymtab entry. Another option would be to take inspiration
from the PLT code we have on ARM and arm64 (and other architectures,
surely) and to count the GOT based relocations, allocate some extra
r/o module space for each, and allocate slots and populate them with
the right value as you fix up the relocations.

Then, many such relocations can be relaxed at module load time if the
symbol is in range. IIUC, the module and kernel will still be inside
the same 2G window even after widening the KASLR range to 512G, so
most GOT loads can be converted into RIP relative LEA instructions.

Note that this will also permit you to do things like

#define PV_VCPU_PREEMPTED_ASM \
 "leaq __per_cpu_offset(%rip), %rax \n\t" \
 "movq (%rax,%rdi,8), %rax \n\t" \
 "addq steal_time@GOTPCREL(%rip), %rax \n\t" \
 "cmpb $0, " __stringify(KVM_STEAL_TIME_preempted) "(%rax) \n\t" \
 "setne %al\n\t"

or

+#ifdef CONFIG_X86_PIE
+ " pushq arch_rethook_trampoline@GOTPCREL(%rip)\n"
+#else
" pushq $arch_rethook_trampoline\n"
+#endif

instead of having these kludgy push/pop sequences to free up temp registers.

(FYI I have looked into this PIE linking just a few weeks ago [0] so
this is all rather fresh in my memory)




[0] https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/log/?h=x86-pie


> Signed-off-by: Hou Wenlong <houwenlong.hwl@antgroup.com>
> Cc: Thomas Garnier <thgarnie@chromium.org>
> Cc: Lai Jiangshan <jiangshan.ljs@antgroup.com>
> Cc: Kees Cook <keescook@chromium.org>
> ---
>  arch/x86/include/asm/sections.h |  5 +++++
>  arch/x86/kernel/module.c        | 27 +++++++++++++++++++++++++++
>  2 files changed, 32 insertions(+)
>
> diff --git a/arch/x86/include/asm/sections.h b/arch/x86/include/asm/sections.h
> index a6e8373a5170..dc1c2b08ec48 100644
> --- a/arch/x86/include/asm/sections.h
> +++ b/arch/x86/include/asm/sections.h
> @@ -12,6 +12,11 @@ extern char __end_rodata_aligned[];
>
>  #if defined(CONFIG_X86_64)
>  extern char __end_rodata_hpage_align[];
> +
> +#ifdef CONFIG_X86_PIE
> +extern char __start_got[], __end_got[];
> +#endif
> +
>  #endif
>
>  extern char __end_of_kernel_reserve[];
> diff --git a/arch/x86/kernel/module.c b/arch/x86/kernel/module.c
> index 84ad0e61ba6e..051f88e6884e 100644
> --- a/arch/x86/kernel/module.c
> +++ b/arch/x86/kernel/module.c
> @@ -129,6 +129,18 @@ int apply_relocate(Elf32_Shdr *sechdrs,
>         return 0;
>  }
>  #else /*X86_64*/
> +#ifdef CONFIG_X86_PIE
> +static u64 find_got_kernel_entry(Elf64_Sym *sym, const Elf64_Rela *rela)
> +{
> +       u64 *pos;
> +
> +       for (pos = (u64 *)__start_got; pos < (u64 *)__end_got; pos++)
> +               if (*pos == sym->st_value)
> +                       return (u64)pos + rela->r_addend;
> +       return 0;
> +}
> +#endif
> +
>  static int __write_relocate_add(Elf64_Shdr *sechdrs,
>                    const char *strtab,
>                    unsigned int symindex,
> @@ -171,6 +183,7 @@ static int __write_relocate_add(Elf64_Shdr *sechdrs,
>                 case R_X86_64_64:
>                         size = 8;
>                         break;
> +#ifndef CONFIG_X86_PIE
>                 case R_X86_64_32:
>                         if (val != *(u32 *)&val)
>                                 goto overflow;
> @@ -181,6 +194,13 @@ static int __write_relocate_add(Elf64_Shdr *sechdrs,
>                                 goto overflow;
>                         size = 4;
>                         break;
> +#else
> +               case R_X86_64_GOTPCREL:
> +                       val = find_got_kernel_entry(sym, rel);
> +                       if (!val)
> +                               goto unexpected_got_reference;
> +                       fallthrough;
> +#endif
>                 case R_X86_64_PC32:
>                 case R_X86_64_PLT32:
>                         val -= (u64)loc;
> @@ -214,11 +234,18 @@ static int __write_relocate_add(Elf64_Shdr *sechdrs,
>         }
>         return 0;
>
> +#ifdef CONFIG_X86_PIE
> +unexpected_got_reference:
> +       pr_err("Target got entry doesn't exist in kernel got, loc %p\n", loc);
> +       return -ENOEXEC;
> +#else
>  overflow:
>         pr_err("overflow in relocation type %d val %Lx\n",
>                (int)ELF64_R_TYPE(rel[i].r_info), val);
>         pr_err("`%s' likely not compiled with -mcmodel=kernel\n",
>                me->name);
> +#endif
> +
>         return -ENOEXEC;
>  }
>
> --
> 2.31.1
>
