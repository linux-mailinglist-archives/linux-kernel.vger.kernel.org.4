Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2B05626CB2
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 00:53:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231972AbiKLXxA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 18:53:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbiKLXwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 18:52:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04C4D14D30
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 15:52:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9876860B18
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 23:52:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 364B0C433C1;
        Sat, 12 Nov 2022 23:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668297173;
        bh=0yNjk6wTO/J4jfLjPiTomN1SND60yLVdVgMUjZT+3hg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oQ8XkzycU8En1x2ZupGuHFYLPwoTlbZ6ONuzTavSTAjVhm1a7xUiWpZEZfJ/TeOkD
         t18LT+WS3hYrXnLLzGiQCA8EagLh0VL4Jfi9W4azvrVCXh5g6jvYgKbAIH/CL08BaS
         HorlGi5PcbkOdqVPU/ssvKQn6X3LLUbWUXW3mG0t5N0qz8zlmff4HRc1RLfw/ozt0D
         Bb8ARuswX/BF9IaiB6Fc789FNBfZdPowEMVn1CVBlUiPzL2WAwav9IsMsuGSgYvhiU
         XWlwMHAl6hUo2Bu1wgSoYEPR+5ANZPaNq4lDWxqINVru9xcPrI+RguLdZiaC8ZyTVR
         XZc/ollQAWslg==
Date:   Sat, 12 Nov 2022 23:52:49 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Andrew Bresticker <abrestic@rivosinc.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@rivosinc.com>, Guo Ren <guoren@kernel.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RISC-V: Fix unannoted hardirqs-on in return to userspace
 slow-path
Message-ID: <Y3Ax0SBy20E2oEuP@spud>
References: <20221111223108.1976562-1-abrestic@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221111223108.1976562-1-abrestic@rivosinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 11, 2022 at 05:31:08PM -0500, Andrew Bresticker wrote:
> The return to userspace path in entry.S may enable interrupts without the
> corresponding lockdep annotation, producing a splat[0] when DEBUG_LOCKDEP
> is enabled. Simply calling __trace_hardirqs_on() here gets a bit messy
> due to the use of RA to point back to ret_from_exception, so just move
> the whole slow-path loop into C. It's more readable and it lets us use
> local_irq_{enable,disable}(), avoiding the need for manual annotations
> altogether.
> 
> [0]:
>   ------------[ cut here ]------------
>   DEBUG_LOCKS_WARN_ON(!lockdep_hardirqs_enabled())
>   WARNING: CPU: 2 PID: 1 at kernel/locking/lockdep.c:5512 check_flags+0x10a/0x1e0
>   Modules linked in:
>   CPU: 2 PID: 1 Comm: init Not tainted 6.1.0-rc4-00160-gb56b6e2b4f31 #53
>   Hardware name: riscv-virtio,qemu (DT)
>   epc : check_flags+0x10a/0x1e0
>   ra : check_flags+0x10a/0x1e0
>   <snip>
>    status: 0000000200000100 badaddr: 0000000000000000 cause: 0000000000000003
>   [<ffffffff808edb90>] lock_is_held_type+0x78/0x14e
>   [<ffffffff8003dae2>] __might_resched+0x26/0x22c
>   [<ffffffff8003dd24>] __might_sleep+0x3c/0x66
>   [<ffffffff80022c60>] get_signal+0x9e/0xa70
>   [<ffffffff800054a2>] do_notify_resume+0x6e/0x422
>   [<ffffffff80003c68>] ret_from_exception+0x0/0x10
>   irq event stamp: 44512
>   hardirqs last  enabled at (44511): [<ffffffff808f901c>] _raw_spin_unlock_irqrestore+0x54/0x62
>   hardirqs last disabled at (44512): [<ffffffff80008200>] __trace_hardirqs_off+0xc/0x14
>   softirqs last  enabled at (44472): [<ffffffff808f9fbe>] __do_softirq+0x3de/0x51e
>   softirqs last disabled at (44467): [<ffffffff80017760>] irq_exit+0xd6/0x104
>   ---[ end trace 0000000000000000 ]---
>   possible reason: unannotated irqs-on.
> 
> Signed-off-by: Andrew Bresticker <abrestic@rivosinc.com>
> ---
> This should also theoretically be fixed by the conversion to generic entry,
> but it's not clear how far away that series is from landing.

Heh.. In case this makes the cut instead - what commit does this fix?

> ---
>  arch/riscv/kernel/entry.S  | 18 +++++-------------
>  arch/riscv/kernel/signal.c | 34 +++++++++++++++++++++-------------
>  2 files changed, 26 insertions(+), 26 deletions(-)
> 
> diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
> index b9eda3fcbd6d..58dfa8595e19 100644
> --- a/arch/riscv/kernel/entry.S
> +++ b/arch/riscv/kernel/entry.S
> @@ -263,12 +263,11 @@ ret_from_exception:
>  #endif
>  	bnez s0, resume_kernel
>  
> -resume_userspace:
>  	/* Interrupts must be disabled here so flags are checked atomically */
>  	REG_L s0, TASK_TI_FLAGS(tp) /* current_thread_info->flags */
>  	andi s1, s0, _TIF_WORK_MASK
> -	bnez s1, work_pending
> -
> +	bnez s1, resume_userspace_slow
> +resume_userspace:
>  #ifdef CONFIG_CONTEXT_TRACKING_USER
>  	call user_enter_callable
>  #endif
> @@ -368,19 +367,12 @@ resume_kernel:
>  	j restore_all
>  #endif
>  
> -work_pending:
> +resume_userspace_slow:
>  	/* Enter slow path for supplementary processing */
> -	la ra, ret_from_exception
> -	andi s1, s0, _TIF_NEED_RESCHED
> -	bnez s1, work_resched
> -work_notifysig:
> -	/* Handle pending signals and notify-resume requests */
> -	csrs CSR_STATUS, SR_IE /* Enable interrupts for do_notify_resume() */
>  	move a0, sp /* pt_regs */
>  	move a1, s0 /* current_thread_info->flags */
> -	tail do_notify_resume
> -work_resched:
> -	tail schedule
> +	call do_work_pending
> +	j resume_userspace
>  
>  /* Slow paths for ptrace. */
>  handle_syscall_trace_enter:
> diff --git a/arch/riscv/kernel/signal.c b/arch/riscv/kernel/signal.c
> index 5c591123c440..bfb2afa4135f 100644
> --- a/arch/riscv/kernel/signal.c
> +++ b/arch/riscv/kernel/signal.c
> @@ -313,19 +313,27 @@ static void do_signal(struct pt_regs *regs)
>  }
>  
>  /*
> - * notification of userspace execution resumption
> - * - triggered by the _TIF_WORK_MASK flags
> + * Handle any pending work on the resume-to-userspace path, as indicated by
> + * _TIF_WORK_MASK. Entered from assembly with IRQs off.
>   */
> -asmlinkage __visible void do_notify_resume(struct pt_regs *regs,
> -					   unsigned long thread_info_flags)
> +asmlinkage __visible void do_work_pending(struct pt_regs *regs,
> +					  unsigned long thread_info_flags)
>  {
> -	if (thread_info_flags & _TIF_UPROBE)
> -		uprobe_notify_resume(regs);
> -
> -	/* Handle pending signal delivery */
> -	if (thread_info_flags & (_TIF_SIGPENDING | _TIF_NOTIFY_SIGNAL))
> -		do_signal(regs);
> -
> -	if (thread_info_flags & _TIF_NOTIFY_RESUME)
> -		resume_user_mode_work(regs);
> +	do {
> +		if (thread_info_flags & _TIF_NEED_RESCHED) {
> +			schedule();
> +		} else {
> +			local_irq_enable();
> +			if (thread_info_flags & _TIF_UPROBE)
> +				uprobe_notify_resume(regs);
> +			/* Handle pending signal delivery */
> +			if (thread_info_flags & (_TIF_SIGPENDING |
> +						 _TIF_NOTIFY_SIGNAL))
> +				do_signal(regs);
> +			if (thread_info_flags & _TIF_NOTIFY_RESUME)
> +				resume_user_mode_work(regs);
> +		}
> +		local_irq_disable();
> +		thread_info_flags = read_thread_flags();
> +	} while (thread_info_flags & _TIF_WORK_MASK);
>  }
> -- 
> 2.25.1
> 
