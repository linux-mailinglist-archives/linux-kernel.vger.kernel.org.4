Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE6EA60F7FF
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 14:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235832AbiJ0MvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 08:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235838AbiJ0MvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 08:51:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CEE2642D1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 05:51:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 08DDD622EE
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 12:51:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D311C433D7
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 12:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666875059;
        bh=4Of75k3K0Mf911rTR//ktCTyryI7pdo2KcSf6UAy0cw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bNYAfAi09rvEsm99n6QYvgBMz0AAPGgpivi8q1XjGYysRXkF9qzQkeGVBSmJazuXg
         IQL9pn6zAQ11XjDJL+CJtIP7rgLEW0/qZ5JM1C310a3Oi9M86Haa2fYlaiMnbJsEjG
         y8Hw7XGP6Z1b/dKKNaZTrSy/EwL6Iyi1Mgc9UgkxiYPpwpEQhFAAOXTZQpv/p1huuD
         pbXGCQP1aNAtes7pP0qQ3wBEKoDadcpUlLU/IvcEYamcbTdlUiQZ66nWzHru5GaXZ6
         fkr0I5BB7E1TZsnOxMyCBEMgyzCspnK6eIO1LFmWDNNTxRFK80Uiz0Lv4ic+qyhwIw
         +LMZwaR6LSnsg==
Received: by mail-ej1-f53.google.com with SMTP id ud5so4274578ejc.4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 05:50:59 -0700 (PDT)
X-Gm-Message-State: ACrzQf3NMKFcUGD+1c9r0+z8MoOF4S6zwVmWYI8/Gt9fc7TqwRPtMZuD
        q2JC81cF1FyjBFGGt0QocdR9LDIFmPr2nFMKZdg=
X-Google-Smtp-Source: AMsMyM6nGwdpAZf6hd4+cSzP9r/xF4DvKXl2JqkqwCmdzy7IVxAbgFGgs4IUdgBED8knRbJmAvElFbs2lZ5DsDt48vA=
X-Received: by 2002:a17:907:2cf7:b0:78d:c7fc:29ff with SMTP id
 hz23-20020a1709072cf700b0078dc7fc29ffmr43009028ejc.748.1666875057345; Thu, 27
 Oct 2022 05:50:57 -0700 (PDT)
MIME-Version: 1.0
References: <20221027111149.27414-1-hejinyang@loongson.cn>
In-Reply-To: <20221027111149.27414-1-hejinyang@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Thu, 27 Oct 2022 20:50:45 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7DOKx4CzPZDgYVHF-zZ8j9NY6CesZCGvtc+_fqoWrXRQ@mail.gmail.com>
Message-ID: <CAAhV-H7DOKx4CzPZDgYVHF-zZ8j9NY6CesZCGvtc+_fqoWrXRQ@mail.gmail.com>
Subject: Re: [PATCH v3] LoongArch: Remove unused kernel stack padding
To:     Jinyang He <hejinyang@loongson.cn>
Cc:     WANG Xuerui <kernel@xen0n.name>, Oleg Nesterov <oleg@redhat.com>,
        Xi Ruoyao <xry111@xry111.site>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org, WANG Xuerui <git@xen0n.name>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Queued for loongarch-next, thanks.

Huacai

On Thu, Oct 27, 2022 at 7:12 PM Jinyang He <hejinyang@loongson.cn> wrote:
>
> The current LoongArch kernel stack is padded as if obeying the
> MIPS o32 calling convention, signifying the port's MIPS lineage
> but no longer making sense. Remove the padding for clarity.
>
> Link: https://lore.kernel.org/loongarch/1662130897-13156-1-git-send-email-hejinyang@loongson.cn/
> Reviewed-by: WANG Xuerui <git@xen0n.name>
> Signed-off-by: Jinyang He <hejinyang@loongson.cn>
> ---
> v2: Remove TOP_OF_KERNEL_STACK_PADDING
>     Remove 'init stack pointer' in head.S
> v3: Improve commit message suggested by Xuerui
>     Add Reviewed-by tags
>
>  arch/loongarch/include/asm/processor.h | 2 +-
>  arch/loongarch/include/asm/ptrace.h    | 2 +-
>  arch/loongarch/kernel/head.S           | 3 +--
>  arch/loongarch/kernel/process.c        | 4 ++--
>  arch/loongarch/kernel/switch.S         | 2 +-
>  5 files changed, 6 insertions(+), 7 deletions(-)
>
> diff --git a/arch/loongarch/include/asm/processor.h b/arch/loongarch/include/asm/processor.h
> index 6954dc5d24e9..7184f1dc61f2 100644
> --- a/arch/loongarch/include/asm/processor.h
> +++ b/arch/loongarch/include/asm/processor.h
> @@ -191,7 +191,7 @@ static inline void flush_thread(void)
>  unsigned long __get_wchan(struct task_struct *p);
>
>  #define __KSTK_TOS(tsk) ((unsigned long)task_stack_page(tsk) + \
> -                        THREAD_SIZE - 32 - sizeof(struct pt_regs))
> +                        THREAD_SIZE - sizeof(struct pt_regs))
>  #define task_pt_regs(tsk) ((struct pt_regs *)__KSTK_TOS(tsk))
>  #define KSTK_EIP(tsk) (task_pt_regs(tsk)->csr_era)
>  #define KSTK_ESP(tsk) (task_pt_regs(tsk)->regs[3])
> diff --git a/arch/loongarch/include/asm/ptrace.h b/arch/loongarch/include/asm/ptrace.h
> index 7437b9366c3b..59c4608de91d 100644
> --- a/arch/loongarch/include/asm/ptrace.h
> +++ b/arch/loongarch/include/asm/ptrace.h
> @@ -133,7 +133,7 @@ static inline void die_if_kernel(const char *str, struct pt_regs *regs)
>  #define current_pt_regs()                                              \
>  ({                                                                     \
>         unsigned long sp = (unsigned long)__builtin_frame_address(0);   \
> -       (struct pt_regs *)((sp | (THREAD_SIZE - 1)) + 1 - 32) - 1;      \
> +       (struct pt_regs *)((sp | (THREAD_SIZE - 1)) + 1) - 1;           \
>  })
>
>  /* Helpers for working with the user stack pointer */
> diff --git a/arch/loongarch/kernel/head.S b/arch/loongarch/kernel/head.S
> index 97425779ce9f..84970e266658 100644
> --- a/arch/loongarch/kernel/head.S
> +++ b/arch/loongarch/kernel/head.S
> @@ -84,10 +84,9 @@ SYM_CODE_START(kernel_entry)                 # kernel entry point
>
>         la.pcrel        tp, init_thread_union
>         /* Set the SP after an empty pt_regs.  */
> -       PTR_LI          sp, (_THREAD_SIZE - 32 - PT_SIZE)
> +       PTR_LI          sp, (_THREAD_SIZE - PT_SIZE)
>         PTR_ADD         sp, sp, tp
>         set_saved_sp    sp, t0, t1
> -       PTR_ADDI        sp, sp, -4 * SZREG      # init stack pointer
>
>         bl              start_kernel
>         ASM_BUG()
> diff --git a/arch/loongarch/kernel/process.c b/arch/loongarch/kernel/process.c
> index 1256e3582475..2526b68f1c0f 100644
> --- a/arch/loongarch/kernel/process.c
> +++ b/arch/loongarch/kernel/process.c
> @@ -129,7 +129,7 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
>         unsigned long clone_flags = args->flags;
>         struct pt_regs *childregs, *regs = current_pt_regs();
>
> -       childksp = (unsigned long)task_stack_page(p) + THREAD_SIZE - 32;
> +       childksp = (unsigned long)task_stack_page(p) + THREAD_SIZE;
>
>         /* set up new TSS. */
>         childregs = (struct pt_regs *) childksp - 1;
> @@ -236,7 +236,7 @@ bool in_task_stack(unsigned long stack, struct task_struct *task,
>                         struct stack_info *info)
>  {
>         unsigned long begin = (unsigned long)task_stack_page(task);
> -       unsigned long end = begin + THREAD_SIZE - 32;
> +       unsigned long end = begin + THREAD_SIZE;
>
>         if (stack < begin || stack >= end)
>                 return false;
> diff --git a/arch/loongarch/kernel/switch.S b/arch/loongarch/kernel/switch.S
> index 43ebbc3990f7..202a163cb32f 100644
> --- a/arch/loongarch/kernel/switch.S
> +++ b/arch/loongarch/kernel/switch.S
> @@ -26,7 +26,7 @@ SYM_FUNC_START(__switch_to)
>         move    tp, a2
>         cpu_restore_nonscratch a1
>
> -       li.w            t0, _THREAD_SIZE - 32
> +       li.w            t0, _THREAD_SIZE
>         PTR_ADD         t0, t0, tp
>         set_saved_sp    t0, t1, t2
>
> --
> 2.34.3
>
