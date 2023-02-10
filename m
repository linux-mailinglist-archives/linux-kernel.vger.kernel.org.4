Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E72C691AE6
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 10:10:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231809AbjBJJKM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 04:10:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231945AbjBJJJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 04:09:47 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5B313773E
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 01:09:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 636ED61D19
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 09:09:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7664C4339C
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 09:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676020170;
        bh=oZPXyic7VPrXb0mlNH+WsejmlN/4EoEt33/UI4JicQs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RySNLaXpfZAVQcq/K7wwGXMpiXnhy5WSPwifrYQJbdwnjelOhzsFtySFGBsA9tCpC
         cqjMFcJOzI1ZSUDptt7E5SztnsxkbdGj+iRkVz5i8Vc4KfxozyeSjfzXUZRqeuIbkv
         gOo4sMvuaUnV17h73IbC2z6B80hmNlLQ7lH4Sx73C1VIypUHhWXnPkr1FJhGb4EFAp
         Z07Vfq7CF8aDSYOazsC/hhT1AT02saUkOdPIzpvyLn4tFloOGrZI//hvJC4AzaUEHs
         ZsLHlg58SWxzoPo8AqLl5wWhZdvAVljciWe9SoKSEGR329N+ZvwKCAFlkZl6OLeR0k
         Ptf1GEi+Hvlog==
Received: by mail-ej1-f46.google.com with SMTP id dr8so13945724ejc.12
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 01:09:30 -0800 (PST)
X-Gm-Message-State: AO0yUKXaKQ+AjWa/h7aK2bptjxdIV2NEgpfsJqSEzOchJJ61la0h2iXy
        wN6idiBvKe+3VdHRv6j8hWs98nC56vTD651r2SU=
X-Google-Smtp-Source: AK7set+dODTfILVJJhsdV9pPLuqhLHFA+bL1lKqcef3mfLPqvkEf11HkrNSqLBuHQHKgwczYb9TuQVz89tTQIWmiMDg=
X-Received: by 2002:a17:906:40d3:b0:8af:3e28:acc with SMTP id
 a19-20020a17090640d300b008af3e280accmr953377ejk.1.1676020168794; Fri, 10 Feb
 2023 01:09:28 -0800 (PST)
MIME-Version: 1.0
References: <1676018856-26520-1-git-send-email-tangyouling@loongson.cn> <1676018856-26520-3-git-send-email-tangyouling@loongson.cn>
In-Reply-To: <1676018856-26520-3-git-send-email-tangyouling@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Fri, 10 Feb 2023 17:09:17 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4Bs5n_ek3mq6zwxAgVw0nvER1XUA+WUA8M12eKcYVPDQ@mail.gmail.com>
Message-ID: <CAAhV-H4Bs5n_ek3mq6zwxAgVw0nvER1XUA+WUA8M12eKcYVPDQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] LoongArch: Use la.pcrel instead of la.abs for
 exception handlers
To:     Youling Tang <tangyouling@loongson.cn>
Cc:     Xi Ruoyao <xry111@xry111.site>, Jinyang He <hejinyang@loongson.cn>,
        Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev,
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

Hi, Youling and Ruoyao,

Thank you very much for implementing the per-node exceptions. But I
want to know if the per-node solution is really worthy for a PIE
kernel. So, could you please test the performance? Maybe we can reduce
the complexity if we give up the per-node solution.

Huacai

On Fri, Feb 10, 2023 at 4:47 PM Youling Tang <tangyouling@loongson.cn> wrote:
>
> From: Xi Ruoyao <xry111@xry111.site>
>
> It's needed to build the kernel as a PIE, or the linker will complain.
>
> For the consideration about performance, we copy the exception handlers
> to a dedicated 64 KB area for each CPU.  So, the PC-relative offset
> calculated at link time will be incorrect and we need to relocate the
> exception handlers after copying them.
>
> For the simplicity, we don't use the ELF R_LARCH_* relocations, but code
> an relocation entry as simply (offset_in_the_handler, symbol_addr).  For
> each exception handler, we also code the number of relocation entries.
> Then we can use the relocation information to fix up the handlers after
> copying them.
>
> Signed-off-by: Xi Ruoyao <xry111@xry111.site>
> ---
>  arch/loongarch/include/asm/inst.h       |   1 +
>  arch/loongarch/include/asm/setup.h      |   6 +-
>  arch/loongarch/include/asm/stackframe.h |   3 +-
>  arch/loongarch/kernel/genex.S           |  40 +++++-
>  arch/loongarch/kernel/traps.c           | 158 ++++++++++++++++++++----
>  arch/loongarch/mm/tlb.c                 |  23 ++--
>  arch/loongarch/mm/tlbex.S               |  69 +++++++++--
>  7 files changed, 255 insertions(+), 45 deletions(-)
>
> diff --git a/arch/loongarch/include/asm/inst.h b/arch/loongarch/include/asm/inst.h
> index 7eedd83fd0d7..426054518a3d 100644
> --- a/arch/loongarch/include/asm/inst.h
> +++ b/arch/loongarch/include/asm/inst.h
> @@ -32,6 +32,7 @@ enum reg1i20_op {
>         lu12iw_op       = 0x0a,
>         lu32id_op       = 0x0b,
>         pcaddi_op       = 0x0c,
> +       pcalau12i_op    = 0x0d,
>         pcaddu12i_op    = 0x0e,
>         pcaddu18i_op    = 0x0f,
>  };
> diff --git a/arch/loongarch/include/asm/setup.h b/arch/loongarch/include/asm/setup.h
> index 72ead58039f3..f0a2b34365f1 100644
> --- a/arch/loongarch/include/asm/setup.h
> +++ b/arch/loongarch/include/asm/setup.h
> @@ -11,6 +11,9 @@
>
>  #define VECSIZE 0x200
>
> +struct handler_reloc;
> +
> +extern struct handler_reloc *eentry_reloc[];
>  extern unsigned long eentry;
>  extern unsigned long tlbrentry;
>  extern char init_command_line[COMMAND_LINE_SIZE];
> @@ -18,7 +21,8 @@ extern void tlb_init(int cpu);
>  extern void cpu_cache_init(void);
>  extern void cache_error_setup(void);
>  extern void per_cpu_trap_init(int cpu);
> -extern void set_handler(unsigned long offset, void *addr, unsigned long len);
> +extern void set_handler(unsigned long exccode, void *addr);
>  extern void set_merr_handler(unsigned long offset, void *addr, unsigned long len);
> +extern void reloc_handler(unsigned long handler, struct handler_reloc *rel);
>
>  #endif /* __SETUP_H */
> diff --git a/arch/loongarch/include/asm/stackframe.h b/arch/loongarch/include/asm/stackframe.h
> index 7deb043ce387..bbec1e56b61b 100644
> --- a/arch/loongarch/include/asm/stackframe.h
> +++ b/arch/loongarch/include/asm/stackframe.h
> @@ -77,7 +77,8 @@
>   * new value in sp.
>   */
>         .macro  get_saved_sp docfi=0
> -       la.abs    t1, kernelsp
> +       /* The label is used for generating reloc tables for handlers */
> +514:   la.pcrel  t1, t0, kernelsp
>  #ifdef CONFIG_SMP
>         csrrd     t0, PERCPU_BASE_KS
>         LONG_ADD  t1, t1, t0
> diff --git a/arch/loongarch/kernel/genex.S b/arch/loongarch/kernel/genex.S
> index 7e5c293ed89f..005a10fe5a50 100644
> --- a/arch/loongarch/kernel/genex.S
> +++ b/arch/loongarch/kernel/genex.S
> @@ -34,7 +34,7 @@ SYM_FUNC_END(__arch_cpu_idle)
>  SYM_FUNC_START(handle_vint)
>         BACKUP_T0T1
>         SAVE_ALL
> -       la.abs  t1, __arch_cpu_idle
> +0:     la.pcrel t1, t2, __arch_cpu_idle
>         LONG_L  t0, sp, PT_ERA
>         /* 32 byte rollback region */
>         ori     t0, t0, 0x1f
> @@ -43,11 +43,25 @@ SYM_FUNC_START(handle_vint)
>         LONG_S  t0, sp, PT_ERA
>  1:     move    a0, sp
>         move    a1, sp
> -       la.abs  t0, do_vint
> +2:     la.pcrel t0, t2, do_vint
>         jirl    ra, t0, 0
>         RESTORE_ALL_AND_RET
>  SYM_FUNC_END(handle_vint)
>
> +SYM_DATA_START(rel_handle_vint)
> +LONG   3
> +
> +LONG   514b - handle_vint
> +LONG   kernelsp
> +
> +LONG   0b - handle_vint
> +LONG   __arch_cpu_idle
> +
> +LONG   2b - handle_vint
> +LONG   do_vint
> +
> +SYM_DATA_END(rel_handle_vint)
> +
>  SYM_FUNC_START(except_vec_cex)
>         b       cache_parity_error
>  SYM_FUNC_END(except_vec_cex)
> @@ -72,12 +86,24 @@ SYM_FUNC_END(except_vec_cex)
>         SAVE_ALL
>         build_prep_\prep
>         move    a0, sp
> -       la.abs  t0, do_\handler
> +       667:
> +       la.pcrel t0, t1, do_\handler
>         jirl    ra, t0, 0
>         668:
>         RESTORE_ALL_AND_RET
>         SYM_FUNC_END(handle_\exception)
>         SYM_DATA(unwind_hint_\exception, .word 668b - 666b)
> +
> +       SYM_DATA_START(rel_handle_\exception)
> +       LONG    2
> +
> +       LONG    514b - 666b
> +       LONG    kernelsp
> +
> +       LONG    667b - 666b
> +       LONG    do_\handler
> +
> +       SYM_DATA_END(rel_handle_\exception)
>         .endm
>
>         BUILD_HANDLER ade ade badv
> @@ -93,6 +119,12 @@ SYM_FUNC_END(except_vec_cex)
>         BUILD_HANDLER reserved reserved none    /* others */
>
>  SYM_FUNC_START(handle_sys)
> -       la.abs  t0, handle_syscall
> +       la.pcrel t0, t1, handle_syscall
>         jr      t0
>  SYM_FUNC_END(handle_sys)
> +
> +SYM_DATA_START(rel_handle_sys)
> +LONG   1
> +LONG   0
> +LONG   handle_syscall
> +SYM_DATA_END(rel_handle_sys)
> diff --git a/arch/loongarch/kernel/traps.c b/arch/loongarch/kernel/traps.c
> index c38a146a973b..7e073854f493 100644
> --- a/arch/loongarch/kernel/traps.c
> +++ b/arch/loongarch/kernel/traps.c
> @@ -62,6 +62,127 @@ extern asmlinkage void handle_reserved(void);
>  extern asmlinkage void handle_watch(void);
>  extern asmlinkage void handle_vint(void);
>
> +struct handler_reloc_entry {
> +       unsigned long offset;
> +       unsigned long sym;
> +};
> +
> +struct handler_reloc {
> +       unsigned long cnt;
> +       struct handler_reloc_entry entries[];
> +};
> +
> +extern struct handler_reloc rel_handle_tlb_load;
> +extern struct handler_reloc rel_handle_tlb_store;
> +extern struct handler_reloc rel_handle_tlb_modify;
> +extern struct handler_reloc rel_handle_tlb_protect;
> +extern struct handler_reloc rel_handle_ade;
> +extern struct handler_reloc rel_handle_ale;
> +extern struct handler_reloc rel_handle_sys;
> +extern struct handler_reloc rel_handle_bp;
> +extern struct handler_reloc rel_handle_ri;
> +extern struct handler_reloc rel_handle_fpu;
> +extern struct handler_reloc rel_handle_lsx;
> +extern struct handler_reloc rel_handle_lasx;
> +extern struct handler_reloc rel_handle_fpe;
> +extern struct handler_reloc rel_handle_lbt;
> +extern struct handler_reloc rel_handle_watch;
> +extern struct handler_reloc rel_handle_reserved;
> +extern struct handler_reloc rel_handle_vint;
> +
> +struct handler_reloc *eentry_reloc[128] = {
> +       [0] = NULL, /* merr handler */
> +       [EXCCODE_TLBL] = &rel_handle_tlb_load,
> +       [EXCCODE_TLBS] = &rel_handle_tlb_store,
> +       [EXCCODE_TLBI] = &rel_handle_tlb_load,
> +       [EXCCODE_TLBM] = &rel_handle_tlb_modify,
> +       [EXCCODE_TLBNR] = &rel_handle_tlb_protect,
> +       [EXCCODE_TLBNX] = &rel_handle_tlb_protect,
> +       [EXCCODE_TLBPE] = &rel_handle_tlb_protect,
> +       [EXCCODE_ADE] = &rel_handle_ade,
> +       [EXCCODE_ALE] = &rel_handle_ale,
> +       [EXCCODE_SYS] = &rel_handle_sys,
> +       [EXCCODE_BP] = &rel_handle_bp,
> +       [EXCCODE_INE] = &rel_handle_ri,
> +       [EXCCODE_IPE] = &rel_handle_ri,
> +       [EXCCODE_FPDIS] = &rel_handle_fpu,
> +       [EXCCODE_LSXDIS] = &rel_handle_lsx,
> +       [EXCCODE_LASXDIS] = &rel_handle_lasx,
> +       [EXCCODE_FPE] = &rel_handle_fpe,
> +       [EXCCODE_BTDIS] = &rel_handle_lbt,
> +       [EXCCODE_WATCH] = &rel_handle_watch,
> +       [(EXCCODE_WATCH + 1) ... (EXCCODE_INT_START - 1)] = &rel_handle_reserved,
> +       [EXCCODE_INT_START ... (EXCCODE_INT_END - 1)] = &rel_handle_vint,
> +};
> +
> +void reloc_handler(unsigned long handler, struct handler_reloc *rel)
> +{
> +       if (!rel)
> +               return;
> +
> +       for (unsigned long i = 0; i < rel->cnt; i++) {
> +               unsigned long pc = handler + rel->entries[i].offset;
> +               union loongarch_instruction *insn =
> +                       (union loongarch_instruction *)pc;
> +               u32 imm[4];
> +               unsigned long v = rel->entries[i].sym;
> +
> +               /* GNU as >= 2.40 uses pcalau12i for la.pcrel, but GNU ld <= 2.39
> +                * uses pcaddu12i.
> +                */
> +               if (insn->reg1i20_format.opcode == pcalau12i_op) {
> +                       /* Use s32 deliberately for sign extension. */
> +                       s32 offset_hi20 = ((v + 0x800) & ~0xfff) -
> +                                         (pc & ~0xfff);
> +                       unsigned long anchor = (pc & ~0xfff) + offset_hi20;
> +                       unsigned long offset_rem = v - anchor;
> +
> +                       imm[0] = (offset_hi20 >> 12) & 0xfffff;
> +                       imm[1] = v & 0xfff;
> +                       imm[2] = (offset_rem >> 32) & 0xfffff;
> +                       imm[3] = offset_rem >> 52;
> +               } else if (insn->reg1i20_format.opcode == pcaddu12i_op) {
> +                       /* Use s32 deliberately for sign extension. */
> +                       s32 offset_lo = v - pc;
> +                       unsigned long offset_hi = v - pc - offset_lo;
> +
> +                       imm[0] = (offset_lo >> 12) & 0xfffff;
> +                       imm[1] = offset_lo & 0xfff;
> +                       imm[2] = (offset_hi >> 32) & 0xfffff;
> +                       imm[3] = offset_hi >> 52;
> +               } else
> +                       panic("Cannot fixup la.pcrel for exception handler at %lu: unexpected instruction %d!",
> +                             pc, insn->word);
> +
> +               insn[0].reg1i20_format.immediate = imm[0];
> +               insn[1].reg2i12_format.immediate = imm[1];
> +               insn[2].reg1i20_format.immediate = imm[2];
> +               insn[3].reg2i12_format.immediate = imm[3];
> +       }
> +}
> +
> +/* Install CPU exception handler */
> +static void do_set_handler(unsigned long exccode, void *addr,
> +                          struct handler_reloc *rel)
> +{
> +       unsigned long dest_addr = eentry + exccode * VECSIZE;
> +
> +       memcpy((void *)dest_addr, addr, VECSIZE);
> +       reloc_handler(dest_addr, rel);
> +       local_flush_icache_range(dest_addr, dest_addr + VECSIZE);
> +}
> +
> +/* Install CPU exception handler, with the reloc table from eentry_reloc */
> +void set_handler(unsigned long exccode, void *addr)
> +{
> +       do_set_handler(exccode, addr, eentry_reloc[exccode]);
> +}
> +
> +static void set_handler_reserved(unsigned long exccode)
> +{
> +       do_set_handler(exccode, handle_reserved, &rel_handle_reserved);
> +}
> +
>  static void show_backtrace(struct task_struct *task, const struct pt_regs *regs,
>                            const char *loglvl, bool user)
>  {
> @@ -704,19 +825,12 @@ void per_cpu_trap_init(int cpu)
>         /* Initialise exception handlers */
>         if (cpu == 0)
>                 for (i = 0; i < 64; i++)
> -                       set_handler(i * VECSIZE, handle_reserved, VECSIZE);
> +                       set_handler_reserved(i);
>
>         tlb_init(cpu);
>         cpu_cache_init();
>  }
>
> -/* Install CPU exception handler */
> -void set_handler(unsigned long offset, void *addr, unsigned long size)
> -{
> -       memcpy((void *)(eentry + offset), addr, size);
> -       local_flush_icache_range(eentry + offset, eentry + offset + size);
> -}
> -
>  static const char panic_null_cerr[] =
>         "Trying to set NULL cache error exception handler\n";
>
> @@ -741,20 +855,20 @@ void __init trap_init(void)
>
>         /* Set interrupt vector handler */
>         for (i = EXCCODE_INT_START; i < EXCCODE_INT_END; i++)
> -               set_handler(i * VECSIZE, handle_vint, VECSIZE);
> -
> -       set_handler(EXCCODE_ADE * VECSIZE, handle_ade, VECSIZE);
> -       set_handler(EXCCODE_ALE * VECSIZE, handle_ale, VECSIZE);
> -       set_handler(EXCCODE_SYS * VECSIZE, handle_sys, VECSIZE);
> -       set_handler(EXCCODE_BP * VECSIZE, handle_bp, VECSIZE);
> -       set_handler(EXCCODE_INE * VECSIZE, handle_ri, VECSIZE);
> -       set_handler(EXCCODE_IPE * VECSIZE, handle_ri, VECSIZE);
> -       set_handler(EXCCODE_FPDIS * VECSIZE, handle_fpu, VECSIZE);
> -       set_handler(EXCCODE_LSXDIS * VECSIZE, handle_lsx, VECSIZE);
> -       set_handler(EXCCODE_LASXDIS * VECSIZE, handle_lasx, VECSIZE);
> -       set_handler(EXCCODE_FPE * VECSIZE, handle_fpe, VECSIZE);
> -       set_handler(EXCCODE_BTDIS * VECSIZE, handle_lbt, VECSIZE);
> -       set_handler(EXCCODE_WATCH * VECSIZE, handle_watch, VECSIZE);
> +               set_handler(i, handle_vint);
> +
> +       set_handler(EXCCODE_ADE, handle_ade);
> +       set_handler(EXCCODE_ALE, handle_ale);
> +       set_handler(EXCCODE_SYS, handle_sys);
> +       set_handler(EXCCODE_BP, handle_bp);
> +       set_handler(EXCCODE_INE, handle_ri);
> +       set_handler(EXCCODE_IPE, handle_ri);
> +       set_handler(EXCCODE_FPDIS, handle_fpu);
> +       set_handler(EXCCODE_LSXDIS, handle_lsx);
> +       set_handler(EXCCODE_LASXDIS, handle_lasx);
> +       set_handler(EXCCODE_FPE, handle_fpe);
> +       set_handler(EXCCODE_BTDIS, handle_lbt);
> +       set_handler(EXCCODE_WATCH, handle_watch);
>
>         cache_error_setup();
>
> diff --git a/arch/loongarch/mm/tlb.c b/arch/loongarch/mm/tlb.c
> index 8bad6b0cff59..6f70aab7202a 100644
> --- a/arch/loongarch/mm/tlb.c
> +++ b/arch/loongarch/mm/tlb.c
> @@ -253,7 +253,6 @@ static void output_pgtable_bits_defines(void)
>  #ifdef CONFIG_NUMA
>  unsigned long pcpu_handlers[NR_CPUS];
>  #endif
> -extern long exception_handlers[VECSIZE * 128 / sizeof(long)];
>
>  void setup_tlb_handler(int cpu)
>  {
> @@ -264,19 +263,20 @@ void setup_tlb_handler(int cpu)
>         if (cpu == 0) {
>                 memcpy((void *)tlbrentry, handle_tlb_refill, 0x80);
>                 local_flush_icache_range(tlbrentry, tlbrentry + 0x80);
> -               set_handler(EXCCODE_TLBI * VECSIZE, handle_tlb_load, VECSIZE);
> -               set_handler(EXCCODE_TLBL * VECSIZE, handle_tlb_load, VECSIZE);
> -               set_handler(EXCCODE_TLBS * VECSIZE, handle_tlb_store, VECSIZE);
> -               set_handler(EXCCODE_TLBM * VECSIZE, handle_tlb_modify, VECSIZE);
> -               set_handler(EXCCODE_TLBNR * VECSIZE, handle_tlb_protect, VECSIZE);
> -               set_handler(EXCCODE_TLBNX * VECSIZE, handle_tlb_protect, VECSIZE);
> -               set_handler(EXCCODE_TLBPE * VECSIZE, handle_tlb_protect, VECSIZE);
> +               set_handler(EXCCODE_TLBI, handle_tlb_load);
> +               set_handler(EXCCODE_TLBL, handle_tlb_load);
> +               set_handler(EXCCODE_TLBS, handle_tlb_store);
> +               set_handler(EXCCODE_TLBM, handle_tlb_modify);
> +               set_handler(EXCCODE_TLBNR, handle_tlb_protect);
> +               set_handler(EXCCODE_TLBNX, handle_tlb_protect);
> +               set_handler(EXCCODE_TLBPE, handle_tlb_protect);
>         }
>  #ifdef CONFIG_NUMA
>         else {
>                 void *addr;
> +               unsigned long addr_ul;
>                 struct page *page;
> -               const int vec_sz = sizeof(exception_handlers);
> +               const int vec_sz = VECSIZE * 128;
>
>                 if (pcpu_handlers[cpu])
>                         return;
> @@ -286,8 +286,11 @@ void setup_tlb_handler(int cpu)
>                         return;
>
>                 addr = page_address(page);
> +               addr_ul = (unsigned long)addr;
>                 pcpu_handlers[cpu] = (unsigned long)addr;
> -               memcpy((void *)addr, (void *)eentry, vec_sz);
> +               memcpy(addr, (void *)eentry, vec_sz);
> +               for (unsigned long i = 0; i < 128; i++)
> +                       reloc_handler(addr_ul + i * VECSIZE, eentry_reloc[i]);
>                 local_flush_icache_range((unsigned long)addr, (unsigned long)addr + vec_sz);
>                 csr_write64(pcpu_handlers[cpu], LOONGARCH_CSR_EENTRY);
>                 csr_write64(pcpu_handlers[cpu], LOONGARCH_CSR_MERRENTRY);
> diff --git a/arch/loongarch/mm/tlbex.S b/arch/loongarch/mm/tlbex.S
> index 3dd2a9615cd9..044c2190771a 100644
> --- a/arch/loongarch/mm/tlbex.S
> +++ b/arch/loongarch/mm/tlbex.S
> @@ -39,11 +39,21 @@ SYM_FUNC_START(handle_tlb_protect)
>         move            a1, zero
>         csrrd           a2, LOONGARCH_CSR_BADV
>         REG_S           a2, sp, PT_BVADDR
> -       la.abs          t0, do_page_fault
> +1:     la.pcrel        t0, t1, do_page_fault
>         jirl            ra, t0, 0
>         RESTORE_ALL_AND_RET
>  SYM_FUNC_END(handle_tlb_protect)
>
> +SYM_DATA_START(rel_handle_tlb_protect)
> +       LONG    2
> +
> +       LONG    514b - handle_tlb_protect
> +       LONG    kernelsp
> +
> +       LONG    1b - handle_tlb_protect
> +       LONG    do_page_fault
> +SYM_DATA_END(rel_handle_tlb_protect)
> +
>  SYM_FUNC_START(handle_tlb_load)
>         csrwr           t0, EXCEPTION_KS0
>         csrwr           t1, EXCEPTION_KS1
> @@ -115,7 +125,8 @@ smp_pgtable_change_load:
>
>  #ifdef CONFIG_64BIT
>  vmalloc_load:
> -       la.abs          t1, swapper_pg_dir
> +       /* The first insn of vmalloc_done_load overwrites ra */
> +1:     la.pcrel        t1, ra, swapper_pg_dir
>         b               vmalloc_done_load
>  #endif
>
> @@ -186,10 +197,24 @@ tlb_huge_update_load:
>  nopage_tlb_load:
>         dbar            0
>         csrrd           ra, EXCEPTION_KS2
> -       la.abs          t0, tlb_do_page_fault_0
> +2:     la.pcrel        t0, t1, tlb_do_page_fault_0
>         jr              t0
>  SYM_FUNC_END(handle_tlb_load)
>
> +SYM_DATA_START(rel_handle_tlb_load)
> +#ifdef CONFIG_64BIT
> +       LONG    2
> +
> +       LONG    1b - handle_tlb_load
> +       LONG    swapper_pg_dir
> +#else
> +       LONG    1
> +#endif
> +
> +       LONG    2b - handle_tlb_load
> +       LONG    tlb_do_page_fault_0
> +SYM_DATA_END(rel_handle_tlb_load)
> +
>  SYM_FUNC_START(handle_tlb_store)
>         csrwr           t0, EXCEPTION_KS0
>         csrwr           t1, EXCEPTION_KS1
> @@ -262,7 +287,8 @@ smp_pgtable_change_store:
>
>  #ifdef CONFIG_64BIT
>  vmalloc_store:
> -       la.abs          t1, swapper_pg_dir
> +       /* The first insn of vmalloc_done_store overwrites ra */
> +1:     la.pcrel        t1, ra, swapper_pg_dir
>         b               vmalloc_done_store
>  #endif
>
> @@ -335,10 +361,24 @@ tlb_huge_update_store:
>  nopage_tlb_store:
>         dbar            0
>         csrrd           ra, EXCEPTION_KS2
> -       la.abs          t0, tlb_do_page_fault_1
> +2:     la.pcrel        t0, t1, tlb_do_page_fault_1
>         jr              t0
>  SYM_FUNC_END(handle_tlb_store)
>
> +SYM_DATA_START(rel_handle_tlb_store)
> +#ifdef CONFIG_64BIT
> +       LONG    2
> +
> +       LONG    1b - handle_tlb_store
> +       LONG    swapper_pg_dir
> +#else
> +       LONG    1
> +#endif
> +
> +       LONG    2b - handle_tlb_store
> +       LONG    tlb_do_page_fault_1
> +SYM_DATA_END(rel_handle_tlb_store)
> +
>  SYM_FUNC_START(handle_tlb_modify)
>         csrwr           t0, EXCEPTION_KS0
>         csrwr           t1, EXCEPTION_KS1
> @@ -410,7 +450,8 @@ smp_pgtable_change_modify:
>
>  #ifdef CONFIG_64BIT
>  vmalloc_modify:
> -       la.abs          t1, swapper_pg_dir
> +       /* The first insn of vmalloc_done_modify overwrites ra */
> +1:     la.pcrel        t1, ra, swapper_pg_dir
>         b               vmalloc_done_modify
>  #endif
>
> @@ -482,10 +523,24 @@ tlb_huge_update_modify:
>  nopage_tlb_modify:
>         dbar            0
>         csrrd           ra, EXCEPTION_KS2
> -       la.abs          t0, tlb_do_page_fault_1
> +2:     la.pcrel        t0, t1, tlb_do_page_fault_1
>         jr              t0
>  SYM_FUNC_END(handle_tlb_modify)
>
> +SYM_DATA_START(rel_handle_tlb_modify)
> +#ifdef CONFIG_64BIT
> +       LONG    2
> +
> +       LONG    1b - handle_tlb_modify
> +       LONG    swapper_pg_dir
> +#else
> +       LONG    1
> +#endif
> +
> +       LONG    2b - handle_tlb_modify
> +       LONG    tlb_do_page_fault_1
> +SYM_DATA_END(rel_handle_tlb_modify)
> +
>  SYM_FUNC_START(handle_tlb_refill)
>         csrwr           t0, LOONGARCH_CSR_TLBRSAVE
>         csrrd           t0, LOONGARCH_CSR_PGD
> --
> 2.37.3
>
