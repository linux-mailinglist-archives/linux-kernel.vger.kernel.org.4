Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4D576038AA
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 05:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbiJSDht (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 23:37:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbiJSDhj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 23:37:39 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61E9867CB0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 20:37:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id C0E61CE200A
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 03:37:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D518EC43143
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 03:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666150654;
        bh=EBF7VIq95F0DlBovf75OXNo51TgwpOaJQk8sFi+3rGk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UGg9XV5EIZthWJmdnrWrxtPEA4SN8lCB3zDnH4dLN9nwDYjDWHlR440bIlui36/LY
         DF8X7ZslF+D5wzuGoOooFhPss2UAYFMLqOdptKBWzHRk0tAC2kg6hmCCN8rtCM66Dp
         R5CThAhrZxSRzjhX0YxFaXuWs1unVvDHtUFD7mhzpdfGXxsZiTlCP2fnA38eRcfHWf
         cP+7RcvupWGiozxXtrAWavzX5ZlBed6krW4ZKPpiRTW9UXbR4eGito1gwGczZ1t3AU
         TwTTB9XsBxAScv1+BPuljdsFkrMpgIEiXvjOiBud3Uud4HfgPItn7GzdUUhO8xQCjR
         18z/2JZR5VFxA==
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-136b5dd6655so19225949fac.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 20:37:34 -0700 (PDT)
X-Gm-Message-State: ACrzQf1l1a0vJaxNU3ft3MyumGpAwmKdIZgyk8AKYxOdjjoHvRoyqkH7
        U9S4DG1/VZ51lvvJea6EUzG3UkBnEajgcuqVJt4=
X-Google-Smtp-Source: AMsMyM6s66yoxrTHtul+Q7dLuF9JNyuwHLHxceRCvOIwSBtvoSv327hMUd/fYCGuUid+/N63e/gy/y1T88F8Ij1MX3w=
X-Received: by 2002:a05:6870:4413:b0:136:66cc:6af8 with SMTP id
 u19-20020a056870441300b0013666cc6af8mr20753144oah.112.1666150653930; Tue, 18
 Oct 2022 20:37:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220928162007.3791-1-jszhang@kernel.org> <20220928162007.3791-3-jszhang@kernel.org>
In-Reply-To: <20220928162007.3791-3-jszhang@kernel.org>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 19 Oct 2022 11:37:21 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQNiv=HSZUcgOeLWmvoEgx6=YdGAruH56LOhUv-gG2HMQ@mail.gmail.com>
Message-ID: <CAJF2gTQNiv=HSZUcgOeLWmvoEgx6=YdGAruH56LOhUv-gG2HMQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] riscv: consolidate ret_from_kernel_thread into ret_from_fork
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I would involve this patch in the generic entry series. It would help
remove the ret_from_kernel_thread part in the entry.S.

On Thu, Sep 29, 2022 at 12:29 AM Jisheng Zhang <jszhang@kernel.org> wrote:
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
