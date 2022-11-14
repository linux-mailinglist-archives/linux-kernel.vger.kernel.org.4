Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02A62628292
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 15:31:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236663AbiKNObY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 09:31:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236156AbiKNObW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 09:31:22 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C4C12A41B
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 06:31:21 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id kt23so28766573ejc.7
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 06:31:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0+kjSSlddPk22SVRMFggPq/N9KnLax/UbPP+YXtClA8=;
        b=1idhRw3Rk+WYVSbROB1Ca175BIS4sNqD5ZsdmUQetjRpB7gqx49HLW6E2Pi3HAPvdN
         cZlx/05gtg3vgAq4NINYu+fQqBR3Sk8t7tiM1jjpg3gDAKdv7C/VeEWSBp8pxWRhHlm3
         BrfzNsNCVasHIi6R9q2t8B7+6ptOmMERdAhg0wOcgRny4jUF9lKcczBXfBLyVmOmwLUC
         R+YsUtCkQJ0WyNcc85hn5SlJIredaTdoLxNFxHu/95ML9FsrL99CTYrvMiRjZD4juF6U
         AzrEbFeywYgq75CGW29TPbHce9E4z9ZDfhkHliPdmyKnF8OgFYAttKrKDmLi+6aoAiHh
         rGfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0+kjSSlddPk22SVRMFggPq/N9KnLax/UbPP+YXtClA8=;
        b=i8E5+xeK1reDKnaQdhPP8GOGI8BiRYR2omNPNs6AWWBb0rSJJ/B3+HOFMzVXxkwdH9
         mtz6SwiM+lCczajtrgsGgJDXk1fXSSdCzRxDM80CYRG1nWwFFoQNn+1vKw19b+aQ/dqj
         i73kO6lhTxGuCy16oIyUZQSYRn4vHHUcQ4LZKNcsbWyUA2e0iJtlVEZ/eQ6btFTwC713
         OaKYYZhBYANAkshr0OgwgH2pprlJH7MQkRXVmICHzZ2kM+t/z0MHb0NXWmdax3Ew7vvQ
         ZKrTQ61ptWcx3GHDKv2QQMB4x3WlAL+D/1n8LcXrWQm7bhnHSxt/K5Z0b2pk+E+Fmogy
         MB8Q==
X-Gm-Message-State: ANoB5pkhqPJvk1KNlNjRWFdmlr1ReL50O6XUNVCEBQSeQiFY41gli1ao
        jdmX/c4OOtmmBhYqzvqkGvHL1j1DnFQvYzMq+u0WMw==
X-Google-Smtp-Source: AA0mqf60ai9BHo0GcwXkrNjXmCjq91Ikp1TTN943sqQTLI4NqRKO/RIfJEpCxDyG+uuPn6nt16qH0IK1zMcpukpZJM8=
X-Received: by 2002:a17:906:339b:b0:78d:3862:4488 with SMTP id
 v27-20020a170906339b00b0078d38624488mr9901616eja.683.1668436279748; Mon, 14
 Nov 2022 06:31:19 -0800 (PST)
MIME-Version: 1.0
References: <20221111223108.1976562-1-abrestic@rivosinc.com> <Y3Ax0SBy20E2oEuP@spud>
In-Reply-To: <Y3Ax0SBy20E2oEuP@spud>
From:   Andrew Bresticker <abrestic@rivosinc.com>
Date:   Mon, 14 Nov 2022 09:31:08 -0500
Message-ID: <CALE4mHqw9J=+NoO_ixWFs4f=k-dRghU8fPa0swC-fwTyhTAYsw@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: Fix unannoted hardirqs-on in return to userspace slow-path
To:     Conor Dooley <conor@kernel.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@rivosinc.com>, Guo Ren <guoren@kernel.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 12, 2022 at 6:52 PM Conor Dooley <conor@kernel.org> wrote:
>
> On Fri, Nov 11, 2022 at 05:31:08PM -0500, Andrew Bresticker wrote:
> > The return to userspace path in entry.S may enable interrupts without the
> > corresponding lockdep annotation, producing a splat[0] when DEBUG_LOCKDEP
> > is enabled. Simply calling __trace_hardirqs_on() here gets a bit messy
> > due to the use of RA to point back to ret_from_exception, so just move
> > the whole slow-path loop into C. It's more readable and it lets us use
> > local_irq_{enable,disable}(), avoiding the need for manual annotations
> > altogether.
> >
> > [0]:
> >   ------------[ cut here ]------------
> >   DEBUG_LOCKS_WARN_ON(!lockdep_hardirqs_enabled())
> >   WARNING: CPU: 2 PID: 1 at kernel/locking/lockdep.c:5512 check_flags+0x10a/0x1e0
> >   Modules linked in:
> >   CPU: 2 PID: 1 Comm: init Not tainted 6.1.0-rc4-00160-gb56b6e2b4f31 #53
> >   Hardware name: riscv-virtio,qemu (DT)
> >   epc : check_flags+0x10a/0x1e0
> >   ra : check_flags+0x10a/0x1e0
> >   <snip>
> >    status: 0000000200000100 badaddr: 0000000000000000 cause: 0000000000000003
> >   [<ffffffff808edb90>] lock_is_held_type+0x78/0x14e
> >   [<ffffffff8003dae2>] __might_resched+0x26/0x22c
> >   [<ffffffff8003dd24>] __might_sleep+0x3c/0x66
> >   [<ffffffff80022c60>] get_signal+0x9e/0xa70
> >   [<ffffffff800054a2>] do_notify_resume+0x6e/0x422
> >   [<ffffffff80003c68>] ret_from_exception+0x0/0x10
> >   irq event stamp: 44512
> >   hardirqs last  enabled at (44511): [<ffffffff808f901c>] _raw_spin_unlock_irqrestore+0x54/0x62
> >   hardirqs last disabled at (44512): [<ffffffff80008200>] __trace_hardirqs_off+0xc/0x14
> >   softirqs last  enabled at (44472): [<ffffffff808f9fbe>] __do_softirq+0x3de/0x51e
> >   softirqs last disabled at (44467): [<ffffffff80017760>] irq_exit+0xd6/0x104
> >   ---[ end trace 0000000000000000 ]---
> >   possible reason: unannotated irqs-on.
> >
> > Signed-off-by: Andrew Bresticker <abrestic@rivosinc.com>
> > ---
> > This should also theoretically be fixed by the conversion to generic entry,
> > but it's not clear how far away that series is from landing.
>
> Heh.. In case this makes the cut instead - what commit does this fix?

Ah, right --

Fixes: 3c4697982982 ("riscv: Enable LOCKDEP_SUPPORT & fixup
TRACE_IRQFLAGS_SUPPORT")

-Andrew

>
> > ---
> >  arch/riscv/kernel/entry.S  | 18 +++++-------------
> >  arch/riscv/kernel/signal.c | 34 +++++++++++++++++++++-------------
> >  2 files changed, 26 insertions(+), 26 deletions(-)
> >
> > diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
> > index b9eda3fcbd6d..58dfa8595e19 100644
> > --- a/arch/riscv/kernel/entry.S
> > +++ b/arch/riscv/kernel/entry.S
> > @@ -263,12 +263,11 @@ ret_from_exception:
> >  #endif
> >       bnez s0, resume_kernel
> >
> > -resume_userspace:
> >       /* Interrupts must be disabled here so flags are checked atomically */
> >       REG_L s0, TASK_TI_FLAGS(tp) /* current_thread_info->flags */
> >       andi s1, s0, _TIF_WORK_MASK
> > -     bnez s1, work_pending
> > -
> > +     bnez s1, resume_userspace_slow
> > +resume_userspace:
> >  #ifdef CONFIG_CONTEXT_TRACKING_USER
> >       call user_enter_callable
> >  #endif
> > @@ -368,19 +367,12 @@ resume_kernel:
> >       j restore_all
> >  #endif
> >
> > -work_pending:
> > +resume_userspace_slow:
> >       /* Enter slow path for supplementary processing */
> > -     la ra, ret_from_exception
> > -     andi s1, s0, _TIF_NEED_RESCHED
> > -     bnez s1, work_resched
> > -work_notifysig:
> > -     /* Handle pending signals and notify-resume requests */
> > -     csrs CSR_STATUS, SR_IE /* Enable interrupts for do_notify_resume() */
> >       move a0, sp /* pt_regs */
> >       move a1, s0 /* current_thread_info->flags */
> > -     tail do_notify_resume
> > -work_resched:
> > -     tail schedule
> > +     call do_work_pending
> > +     j resume_userspace
> >
> >  /* Slow paths for ptrace. */
> >  handle_syscall_trace_enter:
> > diff --git a/arch/riscv/kernel/signal.c b/arch/riscv/kernel/signal.c
> > index 5c591123c440..bfb2afa4135f 100644
> > --- a/arch/riscv/kernel/signal.c
> > +++ b/arch/riscv/kernel/signal.c
> > @@ -313,19 +313,27 @@ static void do_signal(struct pt_regs *regs)
> >  }
> >
> >  /*
> > - * notification of userspace execution resumption
> > - * - triggered by the _TIF_WORK_MASK flags
> > + * Handle any pending work on the resume-to-userspace path, as indicated by
> > + * _TIF_WORK_MASK. Entered from assembly with IRQs off.
> >   */
> > -asmlinkage __visible void do_notify_resume(struct pt_regs *regs,
> > -                                        unsigned long thread_info_flags)
> > +asmlinkage __visible void do_work_pending(struct pt_regs *regs,
> > +                                       unsigned long thread_info_flags)
> >  {
> > -     if (thread_info_flags & _TIF_UPROBE)
> > -             uprobe_notify_resume(regs);
> > -
> > -     /* Handle pending signal delivery */
> > -     if (thread_info_flags & (_TIF_SIGPENDING | _TIF_NOTIFY_SIGNAL))
> > -             do_signal(regs);
> > -
> > -     if (thread_info_flags & _TIF_NOTIFY_RESUME)
> > -             resume_user_mode_work(regs);
> > +     do {
> > +             if (thread_info_flags & _TIF_NEED_RESCHED) {
> > +                     schedule();
> > +             } else {
> > +                     local_irq_enable();
> > +                     if (thread_info_flags & _TIF_UPROBE)
> > +                             uprobe_notify_resume(regs);
> > +                     /* Handle pending signal delivery */
> > +                     if (thread_info_flags & (_TIF_SIGPENDING |
> > +                                              _TIF_NOTIFY_SIGNAL))
> > +                             do_signal(regs);
> > +                     if (thread_info_flags & _TIF_NOTIFY_RESUME)
> > +                             resume_user_mode_work(regs);
> > +             }
> > +             local_irq_disable();
> > +             thread_info_flags = read_thread_flags();
> > +     } while (thread_info_flags & _TIF_WORK_MASK);
> >  }
> > --
> > 2.25.1
> >
