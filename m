Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31F9D691AC9
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 10:07:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231903AbjBJJHH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 04:07:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231803AbjBJJGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 04:06:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EACFC37717
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 01:06:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 366C461D1A
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 09:06:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E98CC433EF
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 09:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676019966;
        bh=1r7L+3EHiBcjwCIcanjKDgAqmBUr/TaCmD4Qt2zzwVM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=E7EMdbTSs8yW9HP/CXI9rSifsgdTlu6ilA8Bfv1EZaf0dxEcDIqhdVIA5Hanq//zC
         8q0PQ2qB8UJ1Ph8xJ+LCeDGrGjb8uo/QanmgVKcFy8wUIBCuuVg1j0zqUf/zuJuIlr
         xIRbGx04Js6u/tbtUMSiEhWA9tjO7poCOC+511/HtEEKT3fCvKI9rzCW8rSWQuHcmI
         GOTF+CYcwaPpVJMHZly1qDtRrQOGaDYAKAnFD1xWnrRo+PsAlHsj3KzPKT7SzKgBH6
         Q3Q1pnuyYwvjF4K2fIfrKiAc7VI7SJW1n9LQN/xskUKBpBHd8SnP6VQ99pV9ppW3EE
         vWTlI8VCTdklQ==
Received: by mail-ed1-f48.google.com with SMTP id fj20so4209219edb.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 01:06:06 -0800 (PST)
X-Gm-Message-State: AO0yUKUftnXZ0adVr0o5K5wFLF87dFjxDAWCTpZWxl2AmyBiGRZl3zw6
        tyFNpHnUptotTUHT4IaBBiEGB6dA1Wt8zph09iE=
X-Google-Smtp-Source: AK7set+3oqG6WFGBWVSGztfivQLcSrUNYBhoQbuSp6GlP4aJ27vDBbKw7eJMohUdwy9h8SVTHDDmlW3o5AjwCUSwOhM=
X-Received: by 2002:a50:99c3:0:b0:49d:ec5d:28b1 with SMTP id
 n3-20020a5099c3000000b0049dec5d28b1mr3213137edb.7.1676019964850; Fri, 10 Feb
 2023 01:06:04 -0800 (PST)
MIME-Version: 1.0
References: <1676018856-26520-1-git-send-email-tangyouling@loongson.cn> <1676018856-26520-5-git-send-email-tangyouling@loongson.cn>
In-Reply-To: <1676018856-26520-5-git-send-email-tangyouling@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Fri, 10 Feb 2023 17:05:52 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6NdM014fWuP3=mDMtfroYtfQ9r6orDBXz0D1R99ophQQ@mail.gmail.com>
Message-ID: <CAAhV-H6NdM014fWuP3=mDMtfroYtfQ9r6orDBXz0D1R99ophQQ@mail.gmail.com>
Subject: Re: [PATCH v4 4/5] LoongArch: Add support for kernel relocation
To:     Youling Tang <tangyouling@loongson.cn>
Cc:     Xi Ruoyao <xry111@xry111.site>, Jinyang He <hejinyang@loongson.cn>,
        Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Youling,

On Fri, Feb 10, 2023 at 4:48 PM Youling Tang <tangyouling@loongson.cn> wrote:
>
> This config allows to compile kernel as PIE and to relocate it at
> any virtual address at runtime: this paves the way to KASLR.
> Runtime relocation is possible since relocation metadata are embedded
> into the kernel.
>
> Signed-off-by: Youling Tang <tangyouling@loongson.cn>
> Signed-off-by: Xi Ruoyao <xry111@xry111.site> # Use arch_initcall
> ---
>  arch/loongarch/Kconfig              | 15 ++++++
>  arch/loongarch/Makefile             |  5 ++
>  arch/loongarch/kernel/Makefile      |  2 +
>  arch/loongarch/kernel/head.S        |  5 ++
>  arch/loongarch/kernel/relocate.c    | 78 +++++++++++++++++++++++++++++
>  arch/loongarch/kernel/vmlinux.lds.S | 11 +++-
>  6 files changed, 114 insertions(+), 2 deletions(-)
>  create mode 100644 arch/loongarch/kernel/relocate.c
>
> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> index 9cc8b84f7eb0..089a4695b1b3 100644
> --- a/arch/loongarch/Kconfig
> +++ b/arch/loongarch/Kconfig
> @@ -48,6 +48,7 @@ config LOONGARCH
>         select ARCH_SUPPORTS_ATOMIC_RMW
>         select ARCH_SUPPORTS_HUGETLBFS
>         select ARCH_SUPPORTS_NUMA_BALANCING
> +       select SYS_SUPPORTS_RELOCATABLE
We don't need such a Kconfig option since it is always true.

Huacai
>         select ARCH_USE_BUILTIN_BSWAP
>         select ARCH_USE_CMPXCHG_LOCKREF
>         select ARCH_USE_QUEUED_RWLOCKS
> @@ -229,6 +230,11 @@ config SCHED_OMIT_FRAME_POINTER
>  config AS_HAS_EXPLICIT_RELOCS
>         def_bool $(as-instr,x:pcalau12i \$t0$(comma)%pc_hi20(x))
>
> +config SYS_SUPPORTS_RELOCATABLE
> +       bool
> +       help
> +         Selected if the platform supports relocating the kernel.
> +
>  menu "Kernel type and options"
>
>  source "kernel/Kconfig.hz"
> @@ -474,6 +480,15 @@ config PHYSICAL_START
>           specified in the "crashkernel=YM@XM" command line boot parameter
>           passed to the panic-ed kernel).
>
> +config RELOCATABLE
> +       bool "Relocatable kernel"
> +       depends on SYS_SUPPORTS_RELOCATABLE
> +       help
> +         This builds the kernel as a Position Independent Executable (PIE),
> +         which retains all relocation metadata required to relocate the
> +         kernel binary at runtime to a different virtual address than the
> +         address it was linked at.
> +
>  config SECCOMP
>         bool "Enable seccomp to safely compute untrusted bytecode"
>         depends on PROC_FS
> diff --git a/arch/loongarch/Makefile b/arch/loongarch/Makefile
> index 4402387d2755..27b5a70ff31c 100644
> --- a/arch/loongarch/Makefile
> +++ b/arch/loongarch/Makefile
> @@ -71,6 +71,11 @@ KBUILD_AFLAGS_MODULE         += -Wa,-mla-global-with-abs
>  KBUILD_CFLAGS_MODULE           += -fplt -Wa,-mla-global-with-abs,-mla-local-with-abs
>  endif
>
> +ifeq ($(CONFIG_RELOCATABLE),y)
> +LDFLAGS_vmlinux                        += -static -pie --no-dynamic-linker -z notext
> +KBUILD_CFLAGS_KERNEL           += -fPIE
> +endif
> +
>  cflags-y += -ffreestanding
>  cflags-y += $(call cc-option, -mno-check-zero-division)
>
> diff --git a/arch/loongarch/kernel/Makefile b/arch/loongarch/kernel/Makefile
> index c8cfbd562921..3341dd5f0926 100644
> --- a/arch/loongarch/kernel/Makefile
> +++ b/arch/loongarch/kernel/Makefile
> @@ -31,6 +31,8 @@ endif
>  obj-$(CONFIG_MODULES)          += module.o module-sections.o
>  obj-$(CONFIG_STACKTRACE)       += stacktrace.o
>
> +obj-$(CONFIG_RELOCATABLE)      += relocate.o
> +
>  obj-$(CONFIG_PROC_FS)          += proc.o
>
>  obj-$(CONFIG_SMP)              += smp.o
> diff --git a/arch/loongarch/kernel/head.S b/arch/loongarch/kernel/head.S
> index d2ac26b5b22b..499edc80d8ab 100644
> --- a/arch/loongarch/kernel/head.S
> +++ b/arch/loongarch/kernel/head.S
> @@ -86,6 +86,11 @@ SYM_CODE_START(kernel_entry)                 # kernel entry point
>         PTR_ADD         sp, sp, tp
>         set_saved_sp    sp, t0, t1
>
> +#ifdef CONFIG_RELOCATABLE
> +       /* Apply the relocations */
> +       bl              relocate_kernel
> +#endif
> +
>         bl              start_kernel
>         ASM_BUG()
>
> diff --git a/arch/loongarch/kernel/relocate.c b/arch/loongarch/kernel/relocate.c
> new file mode 100644
> index 000000000000..91ce92433bab
> --- /dev/null
> +++ b/arch/loongarch/kernel/relocate.c
> @@ -0,0 +1,78 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Support for Kernel relocation at boot time
> + *
> + * Copyright (C) 2023 Loongson Technology Corporation Limited
> + */
> +
> +#include <linux/elf.h>
> +#include <linux/kernel.h>
> +#include <linux/printk.h>
> +#include <linux/panic_notifier.h>
> +#include <asm/sections.h>
> +
> +#define RELOCATED(x) ((void *)((long)x + reloc_offset))
> +
> +extern long __rela_dyn_start;
> +extern long __rela_dyn_end;
> +
> +static unsigned long reloc_offset;
> +
> +void __init relocate_kernel(void)
> +{
> +       reloc_offset = (unsigned long)_text - VMLINUX_LOAD_ADDRESS;
> +
> +       if (reloc_offset) {
> +               Elf64_Rela *rela, *rela_end;
> +               rela = (Elf64_Rela *)&__rela_dyn_start;
> +               rela_end = (Elf64_Rela *)&__rela_dyn_end;
> +
> +               for ( ; rela < rela_end; rela++) {
> +                       Elf64_Addr addr = rela->r_offset;
> +                       Elf64_Addr relocated_addr = rela->r_addend;
> +
> +                       if (rela->r_info != R_LARCH_RELATIVE)
> +                               continue;
> +
> +                       if (relocated_addr >= VMLINUX_LOAD_ADDRESS)
> +                               relocated_addr =
> +                                       (Elf64_Addr)RELOCATED(relocated_addr);
> +
> +                       *(Elf64_Addr *)RELOCATED(addr) = relocated_addr;
> +               }
> +       }
> +}
> +
> +/*
> + * Show relocation information on panic.
> + */
> +static void show_kernel_relocation(const char *level)
> +{
> +       if (reloc_offset > 0) {
> +               printk(level);
> +               pr_cont("Kernel relocated offset @ 0x%lx\n", reloc_offset);
> +               pr_cont(" .text @ 0x%lx\n", (unsigned long)&_text);
> +               pr_cont(" .data @ 0x%lx\n", (unsigned long)&_sdata);
> +               pr_cont(" .bss  @ 0x%lx\n", (unsigned long)&__bss_start);
> +       }
> +}
> +
> +static int kernel_location_notifier_fn(struct notifier_block *self,
> +                                      unsigned long v, void *p)
> +{
> +       show_kernel_relocation(KERN_EMERG);
> +       return NOTIFY_DONE;
> +}
> +
> +static struct notifier_block kernel_location_notifier = {
> +       .notifier_call = kernel_location_notifier_fn
> +};
> +
> +static int __init register_kernel_offset_dumper(void)
> +{
> +       atomic_notifier_chain_register(&panic_notifier_list,
> +                                      &kernel_location_notifier);
> +       return 0;
> +}
> +
> +arch_initcall(register_kernel_offset_dumper);
> diff --git a/arch/loongarch/kernel/vmlinux.lds.S b/arch/loongarch/kernel/vmlinux.lds.S
> index 733b16e8d55d..aec0b6567d24 100644
> --- a/arch/loongarch/kernel/vmlinux.lds.S
> +++ b/arch/loongarch/kernel/vmlinux.lds.S
> @@ -70,6 +70,8 @@ SECTIONS
>         .plt : ALIGN(16) { *(.plt) }
>         .got.plt : ALIGN(16) { *(.got.plt) }
>
> +       .data.rel : { *(.data.rel*) }
> +
>         . = ALIGN(PECOFF_SEGMENT_ALIGN);
>         __init_begin = .;
>         __inittext_begin = .;
> @@ -93,8 +95,6 @@ SECTIONS
>         PERCPU_SECTION(1 << CONFIG_L1_CACHE_SHIFT)
>  #endif
>
> -       .rela.dyn : ALIGN(8) { *(.rela.dyn) *(.rela*) }
> -
>         .init.bss : {
>                 *(.init.bss)
>         }
> @@ -107,6 +107,12 @@ SECTIONS
>         RO_DATA(4096)
>         RW_DATA(1 << CONFIG_L1_CACHE_SHIFT, PAGE_SIZE, THREAD_SIZE)
>
> +       .rela.dyn : ALIGN(8) {
> +               __rela_dyn_start = .;
> +                *(.rela.dyn) *(.rela*)
> +               __rela_dyn_end = .;
> +       }
> +
>         .sdata : {
>                 *(.sdata)
>         }
> @@ -133,6 +139,7 @@ SECTIONS
>
>         DISCARDS
>         /DISCARD/ : {
> +               *(.dynamic .dynsym .dynstr .hash .gnu.hash)
>                 *(.gnu.attributes)
>                 *(.options)
>                 *(.eh_frame)
> --
> 2.37.3
>
