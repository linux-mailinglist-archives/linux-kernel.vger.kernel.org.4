Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EBFB627565
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 05:43:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235850AbiKNEnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 23:43:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235376AbiKNEnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 23:43:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50B6F14D11
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 20:43:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 02386B80D13
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 04:43:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A867EC433B5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 04:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668400996;
        bh=NpZB98gWBDyXZ5RzJn1eL+hAWY6MtGqOQO9GINKuPK4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Ie6vH/CdIinUmORiCcFXDtJIBcji6DvHZpJWBHaheHBCVmOhD2aVgLZK4dF6Mk2GH
         sKifITz5JBjRUOZdsUueFskGFkmzYF8KdBvXlwOz7hYl2/7+MDMUHCt8IY/GzcLa93
         ekcCeCaQzfdJ8EAA9mgXbwd4ClC8dWU9D46ym4MCVLRbOQ5IiAwfO1vT2FNVjflIWD
         U/O/Ca/NuZakqIq1lEPhU0g0jyrcaCh5Fzd/CR8GS8ycXNfSkRrINPLaav5MFmr2lk
         9rOvZqoR4hdEONQDA/rW/cfw9SVIFpPU0Su1rJcxannlYChXFFwrRRHSIuSjz3bpng
         Aq8574C9r9HEw==
Received: by mail-ed1-f52.google.com with SMTP id l11so15623912edb.4
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 20:43:16 -0800 (PST)
X-Gm-Message-State: ANoB5plPH/N3KyraS2BmZ7gOzU4JMoMGlLZRlAm/tfdBYSo27ZAD6SNS
        wh4R4xvcnzv6FwPpjoXaFQDqyCmq2/XaCPHQggE=
X-Google-Smtp-Source: AA0mqf7v6j/R0+2HALyYyKNCJHJrXVhNh7a300KpXcwQouOysnQIcBiv/4qQbzSyfmnSqFnQDuL6lcNYJ//tFAD1wRI=
X-Received: by 2002:aa7:c983:0:b0:461:c6e8:452e with SMTP id
 c3-20020aa7c983000000b00461c6e8452emr9655268edt.298.1668400994891; Sun, 13
 Nov 2022 20:43:14 -0800 (PST)
MIME-Version: 1.0
References: <1664326209-13995-1-git-send-email-yangtiezhu@loongson.cn> <1664326209-13995-4-git-send-email-yangtiezhu@loongson.cn>
In-Reply-To: <1664326209-13995-4-git-send-email-yangtiezhu@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Mon, 14 Nov 2022 12:43:02 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7N-N2400ivdczJrfJ9Ht12JUbOADxExF87wVPFEj_c_g@mail.gmail.com>
Message-ID: <CAAhV-H7N-N2400ivdczJrfJ9Ht12JUbOADxExF87wVPFEj_c_g@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] LoongArch: Add kretprobe support
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Tiezhu and Jinyang,

On Wed, Sep 28, 2022 at 8:50 AM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>
> Use the generic kretprobe trampoline handler to add kretprobe
> support for LoongArch.
>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>  arch/loongarch/Kconfig                     |  1 +
>  arch/loongarch/kernel/Makefile             |  2 +-
>  arch/loongarch/kernel/kprobes.c            | 24 ++++++++
>  arch/loongarch/kernel/kprobes_trampoline.S | 97 ++++++++++++++++++++++++++++++
>  4 files changed, 123 insertions(+), 1 deletion(-)
>  create mode 100644 arch/loongarch/kernel/kprobes_trampoline.S
>
> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> index 8debd70..877be6a 100644
> --- a/arch/loongarch/Kconfig
> +++ b/arch/loongarch/Kconfig
> @@ -95,6 +95,7 @@ config LOONGARCH
>         select HAVE_IRQ_EXIT_ON_IRQ_STACK
>         select HAVE_IRQ_TIME_ACCOUNTING
>         select HAVE_KPROBES
> +       select HAVE_KRETPROBES
>         select HAVE_MOD_ARCH_SPECIFIC
>         select HAVE_NMI
>         select HAVE_PCI
> diff --git a/arch/loongarch/kernel/Makefile b/arch/loongarch/kernel/Makefile
> index ff98d8a..48f50607 100644
> --- a/arch/loongarch/kernel/Makefile
> +++ b/arch/loongarch/kernel/Makefile
> @@ -33,6 +33,6 @@ obj-$(CONFIG_UNWINDER_PROLOGUE) += unwind_prologue.o
>
>  obj-$(CONFIG_PERF_EVENTS)      += perf_event.o perf_regs.o
>
> -obj-$(CONFIG_KPROBES)          += kprobes.o
> +obj-$(CONFIG_KPROBES)          += kprobes.o kprobes_trampoline.o
>
>  CPPFLAGS_vmlinux.lds           := $(KBUILD_CFLAGS)
> diff --git a/arch/loongarch/kernel/kprobes.c b/arch/loongarch/kernel/kprobes.c
> index c11f6e0..ca3f1dc 100644
> --- a/arch/loongarch/kernel/kprobes.c
> +++ b/arch/loongarch/kernel/kprobes.c
> @@ -306,6 +306,30 @@ int __init arch_populate_kprobe_blacklist(void)
>                                          (unsigned long)__irqentry_text_end);
>  }
>
> +/* Called from __kretprobe_trampoline */
> +void __used *trampoline_probe_handler(struct pt_regs *regs)
> +{
> +       return (void *)kretprobe_trampoline_handler(regs, NULL);
> +}
> +NOKPROBE_SYMBOL(trampoline_probe_handler);
> +
> +void arch_prepare_kretprobe(struct kretprobe_instance *ri,
> +                           struct pt_regs *regs)
> +{
> +       ri->ret_addr = (kprobe_opcode_t *)regs->regs[1];
> +       ri->fp = NULL;
> +
> +       /* Replace the return addr with trampoline addr */
> +       regs->regs[1] = (unsigned long)&__kretprobe_trampoline;
> +}
> +NOKPROBE_SYMBOL(arch_prepare_kretprobe);
> +
> +int arch_trampoline_kprobe(struct kprobe *p)
> +{
> +       return 0;
> +}
> +NOKPROBE_SYMBOL(arch_trampoline_kprobe);
> +
>  int __init arch_init_kprobes(void)
>  {
>         return 0;
> diff --git a/arch/loongarch/kernel/kprobes_trampoline.S b/arch/loongarch/kernel/kprobes_trampoline.S
> new file mode 100644
> index 0000000..9888ab8
> --- /dev/null
> +++ b/arch/loongarch/kernel/kprobes_trampoline.S
> @@ -0,0 +1,97 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +#include <linux/linkage.h>
> +#include <asm/stackframe.h>
> +
> +       .text
> +
> +       .macro save_all_base_regs
> +       cfi_st  zero, PT_R0
> +       cfi_st  ra, PT_R1
> +       cfi_st  tp, PT_R2
> +       cfi_st  a0, PT_R4
> +       cfi_st  a1, PT_R5
> +       cfi_st  a2, PT_R6
> +       cfi_st  a3, PT_R7
> +       cfi_st  a4, PT_R8
> +       cfi_st  a5, PT_R9
> +       cfi_st  a6, PT_R10
> +       cfi_st  a7, PT_R11
> +       cfi_st  t0, PT_R12
> +       cfi_st  t1, PT_R13
> +       cfi_st  t2, PT_R14
> +       cfi_st  t3, PT_R15
> +       cfi_st  t4, PT_R16
> +       cfi_st  t5, PT_R17
> +       cfi_st  t6, PT_R18
> +       cfi_st  t7, PT_R19
> +       cfi_st  t8, PT_R20
> +       cfi_st  u0, PT_R21
> +       cfi_st  fp, PT_R22
> +       cfi_st  s0, PT_R23
> +       cfi_st  s1, PT_R24
> +       cfi_st  s2, PT_R25
> +       cfi_st  s3, PT_R26
> +       cfi_st  s4, PT_R27
> +       cfi_st  s5, PT_R28
> +       cfi_st  s6, PT_R29
> +       cfi_st  s7, PT_R30
> +       cfi_st  s8, PT_R31
> +       addi.d  t0, sp, PT_SIZE
> +       LONG_S  t0, sp, PT_R3
> +       csrrd   t0, LOONGARCH_CSR_CRMD
> +       andi    t0, t0, 0x7 /* extract bit[1:0] PLV, bit[2] IE */
> +       LONG_S  t0, sp, PT_PRMD
> +       .endm
> +
> +       .macro restore_all_base_regs
> +       cfi_ld  zero, PT_R0
> +       cfi_ld  tp, PT_R2
> +       cfi_ld  a0, PT_R4
> +       cfi_ld  a1, PT_R5
> +       cfi_ld  a2, PT_R6
> +       cfi_ld  a3, PT_R7
> +       cfi_ld  a4, PT_R8
> +       cfi_ld  a5, PT_R9
> +       cfi_ld  a6, PT_R10
> +       cfi_ld  a7, PT_R11
> +       cfi_ld  t0, PT_R12
> +       cfi_ld  t1, PT_R13
> +       cfi_ld  t2, PT_R14
> +       cfi_ld  t3, PT_R15
> +       cfi_ld  t4, PT_R16
> +       cfi_ld  t5, PT_R17
> +       cfi_ld  t6, PT_R18
> +       cfi_ld  t7, PT_R19
> +       cfi_ld  t8, PT_R20
> +       cfi_ld  u0, PT_R21
> +       cfi_ld  fp, PT_R22
> +       cfi_ld  s0, PT_R23
> +       cfi_ld  s1, PT_R24
> +       cfi_ld  s2, PT_R25
> +       cfi_ld  s3, PT_R26
> +       cfi_ld  s4, PT_R27
> +       cfi_ld  s5, PT_R28
> +       cfi_ld  s6, PT_R29
> +       cfi_ld  s7, PT_R30
> +       cfi_ld  s8, PT_R31
> +       LONG_L  t0, sp, PT_PRMD
> +       li.d    t1, 0x7 /* mask bit[1:0] PLV, bit[2] IE */
> +       csrxchg t0, t1, LOONGARCH_CSR_CRMD
> +       .endm
Do you think we need to save and restore all regs here?

Huacai
> +
> +SYM_CODE_START(__kretprobe_trampoline)
> +       addi.d  sp, sp, -PT_SIZE
> +       save_all_base_regs
> +
> +       move a0, sp /* pt_regs */
> +
> +       bl trampoline_probe_handler
> +
> +       /* use the result as the return-address */
> +       move ra, a0
> +
> +       restore_all_base_regs
> +       addi.d  sp, sp, PT_SIZE
> +
> +       jr ra
> +SYM_CODE_END(__kretprobe_trampoline)
> --
> 2.1.0
>
>
