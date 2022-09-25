Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75B645E96E6
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 01:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbiIYXZs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 19:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiIYXZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 19:25:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6E5B26556
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 16:25:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 636E660C1B
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 23:25:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1E72C433D6
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 23:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664148343;
        bh=0qWW3ytRn5sqjDChA6hp83Pha33NNRIB+EMSPBMJ1W4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QiEIB8UQYML9DR5RHuTQU83t6r3TU4wJLraulIDsfvfVsNgi/u/Ko7peUvZJrhSIo
         qQGeuc528E/TOFTkdFT5ftrzMAK1Apz+f9/iQQp1zY8j+p9Xr9+7Tkx4VwyoK9VyK6
         sWoovwaVAIisUMA/knsbc7F9SeEabWartQrlOmmOT/1T3uVTU+MeQIvbASIIwahpv4
         RVJ4UsbfHnibswZDjiXsHrHo1Smgz5IpGvS4U/3hZzj1GGqRN0u/iJ2PBHFVTgJPB9
         PBP247rYS6xMKnhDIxjkDZKqVP4M/6NS4OZ7spvr1VJXT1QmICbRy5fLNegNt3jrHd
         S1YGjNm7YBGEQ==
Received: by mail-ot1-f48.google.com with SMTP id f20-20020a9d7b54000000b006574e21f1b6so3469517oto.5
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 16:25:43 -0700 (PDT)
X-Gm-Message-State: ACrzQf2WcDiPv8yAj9cLHxceGjtNQTFko5Y1GS0Ou+w4bliYCz+0+pQA
        SyMSdAS6Qeq15cZjXmFY/NS2xl5uNZd0SQ3YXQc=
X-Google-Smtp-Source: AMsMyM6ks0NsA08B8/+Ccexe8yxOmM2z3hYh5K0DREm4vqGj/TSiiZYOLw8pMRmxxJcEg0vfSeV6UJvIawj0R+0XeQo=
X-Received: by 2002:a05:6830:34a4:b0:65a:b03:54cc with SMTP id
 c36-20020a05683034a400b0065a0b0354ccmr8647715otu.140.1664148342896; Sun, 25
 Sep 2022 16:25:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220925175356.681-1-jszhang@kernel.org> <20220925175356.681-3-jszhang@kernel.org>
In-Reply-To: <20220925175356.681-3-jszhang@kernel.org>
From:   Guo Ren <guoren@kernel.org>
Date:   Mon, 26 Sep 2022 07:25:30 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTqup62EM9LZQ-9daKk11O0geax9Z3HmTMOxYy2mAwm=w@mail.gmail.com>
Message-ID: <CAJF2gTTqup62EM9LZQ-9daKk11O0geax9Z3HmTMOxYy2mAwm=w@mail.gmail.com>
Subject: Re: [PATCH 2/4] riscv: consolidate ret_from_kernel_thread into ret_from_fork
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 26, 2022 at 2:03 AM Jisheng Zhang <jszhang@kernel.org> wrote:
>
> The ret_from_kernel_thread() behaves similarly with ret_from_fork(),
> the only difference is whether call the fn(arg) or not, this can be
> acchieved by testing fn is NULL or not, I.E s0 is 0 or not.
>
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  arch/riscv/kernel/entry.S   | 11 +++--------
>  arch/riscv/kernel/process.c |  5 ++---
>  2 files changed, 5 insertions(+), 11 deletions(-)
>
> diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
> index 2207cf44a3bc..a3e1ed2fa2ac 100644
> --- a/arch/riscv/kernel/entry.S
> +++ b/arch/riscv/kernel/entry.S
> @@ -323,20 +323,15 @@ END(handle_kernel_stack_overflow)
>
>  ENTRY(ret_from_fork)
>         call schedule_tail
> -       move a0, sp /* pt_regs */
> -       la ra, ret_from_exception
> -       tail syscall_exit_to_user_mode
> -ENDPROC(ret_from_fork)
> -
> -ENTRY(ret_from_kernel_thread)
> -       call schedule_tail
> +       beqz s0, 1f     /* not from kernel thread */
We can't use s0 as condition for ret_from_fork/ret_from_kernel_thread.
The s0=0 is also okay for ret_from_fork.

        /* p->thread holds context to be restored by __switch_to() */
        if (unlikely(args->fn)) {
                /* Kernel thread */
                memset(childregs, 0, sizeof(struct pt_regs));
                childregs->gp = gp_in_global;
                /* Supervisor/Machine, irqs on: */
                childregs->status = SR_PP | SR_PIE;

                p->thread.ra = (unsigned long)ret_from_kernel_thread;
                p->thread.s[0] = (unsigned long)args->fn;
                p->thread.s[1] = (unsigned long)args->fn_arg;
        } else {
                *childregs = *(current_pt_regs());
                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
                if (usp) /* User fork */
                        childregs->sp = usp;
                if (clone_flags & CLONE_SETTLS)
                        childregs->tp = tls;
                childregs->a0 = 0; /* Return value of fork() */
                p->thread.ra = (unsigned long)ret_from_fork;
        }
        p->thread.sp = (unsigned long)childregs; /* kernel sp */

>         /* Call fn(arg) */
>         move a0, s1
>         jalr s0
> +1:
>         move a0, sp /* pt_regs */
>         la ra, ret_from_exception
>         tail syscall_exit_to_user_mode
> -ENDPROC(ret_from_kernel_thread)
> +ENDPROC(ret_from_fork)
>
>  #ifdef CONFIG_IRQ_STACKS
>  ENTRY(call_on_stack)
> diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
> index ceb9ebab6558..67e7cd123ceb 100644
> --- a/arch/riscv/kernel/process.c
> +++ b/arch/riscv/kernel/process.c
> @@ -34,7 +34,6 @@ EXPORT_SYMBOL(__stack_chk_guard);
>  #endif
>
>  extern asmlinkage void ret_from_fork(void);
> -extern asmlinkage void ret_from_kernel_thread(void);
>
>  void arch_cpu_idle(void)
>  {
> @@ -172,7 +171,6 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
>                 /* Supervisor/Machine, irqs on: */
>                 childregs->status = SR_PP | SR_PIE;
>
> -               p->thread.ra = (unsigned long)ret_from_kernel_thread;
>                 p->thread.s[0] = (unsigned long)args->fn;
>                 p->thread.s[1] = (unsigned long)args->fn_arg;
>         } else {
> @@ -182,8 +180,9 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
>                 if (clone_flags & CLONE_SETTLS)
>                         childregs->tp = tls;
>                 childregs->a0 = 0; /* Return value of fork() */
> -               p->thread.ra = (unsigned long)ret_from_fork;
> +               p->thread.s[0] = 0;
>         }
> +       p->thread.ra = (unsigned long)ret_from_fork;
>         p->thread.sp = (unsigned long)childregs; /* kernel sp */
>         return 0;
>  }
> --
> 2.34.1
>


-- 
Best Regards
 Guo Ren
