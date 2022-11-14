Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A81A7628474
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 16:55:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237274AbiKNPzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 10:55:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237259AbiKNPzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 10:55:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F1262E9C9
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 07:55:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E4D4361295
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 15:55:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54A40C43470
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 15:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668441300;
        bh=DBmQL4kXdwF7AMLAjeewLfJPA1FqKsirlKrkclEU9iY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qMs2VgZ4Nd4ymx3YUOb9jaJC8q+TnpQBawz9QFMZbcDIrbMxaFafSnpeo56hHV4BZ
         haDH4TGTldmOwEWofMkg5Fj0HVRWECKcdu92qi63AD8u5v/zEvB9sK3fvFJ4hhMBgi
         XOOyxJve5FA1cDaYjE6cMxohJbyzzKDH61b/GK0wufHKFrATu6Y2Vokm3h0AEhdPTn
         fyEzO3R1EYPna7bvH9dcLIAY0mHMe/NCqmlB1CAMvUiribJG59ulzVNAPVYF6/fMyC
         j4qSX1OyEnaRNq4ne5v/hlL/turnx/XtXYEW3hKmdz4pNLt6poNnAu6ab/SjEbtQIV
         qKBXJK+9btLUA==
Received: by mail-ej1-f51.google.com with SMTP id y14so29418441ejd.9
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 07:55:00 -0800 (PST)
X-Gm-Message-State: ANoB5pmWyztvgkHpQU9xCOFQJeFTvl+FaSrsJo73aOsGhwzVOulOFGmX
        i2DBqaFkFxoxBvWnovCNk0UOh+7q0oXIoKDJX8w=
X-Google-Smtp-Source: AA0mqf4STTfLYE8WIe12v3FMAfYOGojA99Lhm4lw2PgSCBDx7yregbaCOMo04+T5Z66h0M/RtI2+mztoXo03ttWUGFI=
X-Received: by 2002:a17:906:2e85:b0:7ad:b216:f1ce with SMTP id
 o5-20020a1709062e8500b007adb216f1cemr10401866eji.419.1668441298408; Mon, 14
 Nov 2022 07:54:58 -0800 (PST)
MIME-Version: 1.0
References: <20221111223108.1976562-1-abrestic@rivosinc.com>
 <CAJF2gTRbcocqkmkLVmfYO-8ae-kY0bJwZ+sE-WDXfbF0Y_ZkWg@mail.gmail.com>
 <CALE4mHo9uojGyhLo6Sci9VbES1GG=XcEZY-EyY6nkjyWhe2e5A@mail.gmail.com>
 <Y3JfLuRYF/jdjbOY@wendy> <CALE4mHrTWbNDDdSL9kimOcxJOFECwBJCjf64WdxAcdvkMFBfnQ@mail.gmail.com>
In-Reply-To: <CALE4mHrTWbNDDdSL9kimOcxJOFECwBJCjf64WdxAcdvkMFBfnQ@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Mon, 14 Nov 2022 23:54:47 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTZS0YG_C=YkYB+8X78_7Aqp2fmfJrLvSjPLCT34CXjnA@mail.gmail.com>
Message-ID: <CAJF2gTTZS0YG_C=YkYB+8X78_7Aqp2fmfJrLvSjPLCT34CXjnA@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: Fix unannoted hardirqs-on in return to userspace slow-path
To:     Andrew Bresticker <abrestic@rivosinc.com>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@rivosinc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2022 at 11:42 PM Andrew Bresticker
<abrestic@rivosinc.com> wrote:
>
> On Mon, Nov 14, 2022 at 10:31 AM Conor Dooley
> <conor.dooley@microchip.com> wrote:
> >
> > On Mon, Nov 14, 2022 at 10:20:30AM -0500, Andrew Bresticker wrote:
> > > On Mon, Nov 14, 2022 at 9:43 AM Guo Ren <guoren@kernel.org> wrote:
> > > >
> > > > On Sat, Nov 12, 2022 at 6:31 AM Andrew Bresticker <abrestic@rivosinc.com> wrote:
> > > > >
> > > > > The return to userspace path in entry.S may enable interrupts without the
> > > > > corresponding lockdep annotation, producing a splat[0] when DEBUG_LOCKDEP
> > > > > is enabled. Simply calling __trace_hardirqs_on() here gets a bit messy
> > > > > due to the use of RA to point back to ret_from_exception, so just move
> > > > > the whole slow-path loop into C. It's more readable and it lets us use
> > > > > local_irq_{enable,disable}(), avoiding the need for manual annotations
> > > > > altogether.
> > > > Could generic_entry solve your problem? please try:
> > > > https://lore.kernel.org/linux-riscv/20221103075047.1634923-1-guoren@kernel.org/
> > >
> > > Indeed it does, as I mentioned below, however it wasn't clear to me
> > > how close your series was to landing so I'v emailed this small fix for
> > > the existing bug in case your series does not make it into 6.2
> >
> > The backportablilty of this 26+, 26- change has to be considered too.
> > The generic entry patchset has 20x the changes and would not ordinarily
> > be stable material. How much of that series would be required to solve
> > the problem?
>
> We'd need up to patch 6, "riscv: convert to generic entry":
> https://lore.kernel.org/linux-riscv/20221103075047.1634923-7-guoren@kernel.org/
Yes, but 6 needs 1 and 5, and they are very small patches.

>
> -Andrew
>
> >
> > > >
> > > > >
> > > > > [0]:
> > > > >   ------------[ cut here ]------------
> > > > >   DEBUG_LOCKS_WARN_ON(!lockdep_hardirqs_enabled())
> > > > >   WARNING: CPU: 2 PID: 1 at kernel/locking/lockdep.c:5512 check_flags+0x10a/0x1e0
> > > > >   Modules linked in:
> > > > >   CPU: 2 PID: 1 Comm: init Not tainted 6.1.0-rc4-00160-gb56b6e2b4f31 #53
> > > > >   Hardware name: riscv-virtio,qemu (DT)
> > > > >   epc : check_flags+0x10a/0x1e0
> > > > >   ra : check_flags+0x10a/0x1e0
> > > > >   <snip>
> > > > >    status: 0000000200000100 badaddr: 0000000000000000 cause: 0000000000000003
> > > > >   [<ffffffff808edb90>] lock_is_held_type+0x78/0x14e
> > > > >   [<ffffffff8003dae2>] __might_resched+0x26/0x22c
> > > > >   [<ffffffff8003dd24>] __might_sleep+0x3c/0x66
> > > > >   [<ffffffff80022c60>] get_signal+0x9e/0xa70
> > > > >   [<ffffffff800054a2>] do_notify_resume+0x6e/0x422
> > > > >   [<ffffffff80003c68>] ret_from_exception+0x0/0x10
> > > > >   irq event stamp: 44512
> > > > >   hardirqs last  enabled at (44511): [<ffffffff808f901c>] _raw_spin_unlock_irqrestore+0x54/0x62
> > > > >   hardirqs last disabled at (44512): [<ffffffff80008200>] __trace_hardirqs_off+0xc/0x14
> > > > >   softirqs last  enabled at (44472): [<ffffffff808f9fbe>] __do_softirq+0x3de/0x51e
> > > > >   softirqs last disabled at (44467): [<ffffffff80017760>] irq_exit+0xd6/0x104
> > > > >   ---[ end trace 0000000000000000 ]---
> > > > >   possible reason: unannotated irqs-on.
> > > > >
> > > > > Signed-off-by: Andrew Bresticker <abrestic@rivosinc.com>
> > > > > ---
> > > > > This should also theoretically be fixed by the conversion to generic entry,
> > > > > but it's not clear how far away that series is from landing.
> > > > > ---
> > > > >  arch/riscv/kernel/entry.S  | 18 +++++-------------
> > > > >  arch/riscv/kernel/signal.c | 34 +++++++++++++++++++++-------------
> > > > >  2 files changed, 26 insertions(+), 26 deletions(-)
> > > > >
> > > > > diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
> > > > > index b9eda3fcbd6d..58dfa8595e19 100644
> > > > > --- a/arch/riscv/kernel/entry.S
> > > > > +++ b/arch/riscv/kernel/entry.S
> > > > > @@ -263,12 +263,11 @@ ret_from_exception:
> > > > >  #endif
> > > > >         bnez s0, resume_kernel
> > > > >
> > > > > -resume_userspace:
> > > > >         /* Interrupts must be disabled here so flags are checked atomically */
> > > > >         REG_L s0, TASK_TI_FLAGS(tp) /* current_thread_info->flags */
> > > > >         andi s1, s0, _TIF_WORK_MASK
> > > > > -       bnez s1, work_pending
> > > > > -
> > > > > +       bnez s1, resume_userspace_slow
> > > > > +resume_userspace:
> > > > >  #ifdef CONFIG_CONTEXT_TRACKING_USER
> > > > >         call user_enter_callable
> > > > >  #endif
> > > > > @@ -368,19 +367,12 @@ resume_kernel:
> > > > >         j restore_all
> > > > >  #endif
> > > > >
> > > > > -work_pending:
> > > > > +resume_userspace_slow:
> > > > >         /* Enter slow path for supplementary processing */
> > > > > -       la ra, ret_from_exception
> > > > > -       andi s1, s0, _TIF_NEED_RESCHED
> > > > > -       bnez s1, work_resched
> > > > > -work_notifysig:
> > > > > -       /* Handle pending signals and notify-resume requests */
> > > > > -       csrs CSR_STATUS, SR_IE /* Enable interrupts for do_notify_resume() */
> > > > >         move a0, sp /* pt_regs */
> > > > >         move a1, s0 /* current_thread_info->flags */
> > > > > -       tail do_notify_resume
> > > > > -work_resched:
> > > > > -       tail schedule
> > > > > +       call do_work_pending
> > > > > +       j resume_userspace
> > > > >
> > > > >  /* Slow paths for ptrace. */
> > > > >  handle_syscall_trace_enter:
> > > > > diff --git a/arch/riscv/kernel/signal.c b/arch/riscv/kernel/signal.c
> > > > > index 5c591123c440..bfb2afa4135f 100644
> > > > > --- a/arch/riscv/kernel/signal.c
> > > > > +++ b/arch/riscv/kernel/signal.c
> > > > > @@ -313,19 +313,27 @@ static void do_signal(struct pt_regs *regs)
> > > > >  }
> > > > >
> > > > >  /*
> > > > > - * notification of userspace execution resumption
> > > > > - * - triggered by the _TIF_WORK_MASK flags
> > > > > + * Handle any pending work on the resume-to-userspace path, as indicated by
> > > > > + * _TIF_WORK_MASK. Entered from assembly with IRQs off.
> > > > >   */
> > > > > -asmlinkage __visible void do_notify_resume(struct pt_regs *regs,
> > > > > -                                          unsigned long thread_info_flags)
> > > > > +asmlinkage __visible void do_work_pending(struct pt_regs *regs,
> > > > > +                                         unsigned long thread_info_flags)
> > > > >  {
> > > > > -       if (thread_info_flags & _TIF_UPROBE)
> > > > > -               uprobe_notify_resume(regs);
> > > > > -
> > > > > -       /* Handle pending signal delivery */
> > > > > -       if (thread_info_flags & (_TIF_SIGPENDING | _TIF_NOTIFY_SIGNAL))
> > > > > -               do_signal(regs);
> > > > > -
> > > > > -       if (thread_info_flags & _TIF_NOTIFY_RESUME)
> > > > > -               resume_user_mode_work(regs);
> > > > > +       do {
> > > > > +               if (thread_info_flags & _TIF_NEED_RESCHED) {
> > > > > +                       schedule();
> > > > > +               } else {
> > > > > +                       local_irq_enable();
> > > > > +                       if (thread_info_flags & _TIF_UPROBE)
> > > > > +                               uprobe_notify_resume(regs);
> > > > > +                       /* Handle pending signal delivery */
> > > > > +                       if (thread_info_flags & (_TIF_SIGPENDING |
> > > > > +                                                _TIF_NOTIFY_SIGNAL))
> > > > > +                               do_signal(regs);
> > > > > +                       if (thread_info_flags & _TIF_NOTIFY_RESUME)
> > > > > +                               resume_user_mode_work(regs);
> > > > > +               }
> > > > > +               local_irq_disable();
> > > > > +               thread_info_flags = read_thread_flags();
> > > > > +       } while (thread_info_flags & _TIF_WORK_MASK);
> > > > >  }
> > > > The more graceful code has been written in kernel/entry/common.c.
> > > > Let's base it on that:
> > > >
> > > > static unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
> > > >                                             unsigned long ti_work)
> > > > {
> > > >         /*
> > > >          * Before returning to user space ensure that all pending work
> > > >          * items have been completed.
> > > >          */
> > > >         while (ti_work & EXIT_TO_USER_MODE_WORK) {
> > > >
> > > >                 local_irq_enable_exit_to_user(ti_work);
> > > >
> > > >                 if (ti_work & _TIF_NEED_RESCHED)
> > > >                         schedule();
> > > >
> > > >                 if (ti_work & _TIF_UPROBE)
> > > >                         uprobe_notify_resume(regs);
> > > >
> > > >                 if (ti_work & _TIF_PATCH_PENDING)
> > > >                         klp_update_patch_state(current);
> > > >
> > > >                 if (ti_work & (_TIF_SIGPENDING | _TIF_NOTIFY_SIGNAL))
> > > >                         arch_do_signal_or_restart(regs);
> > > >
> > > >                 if (ti_work & _TIF_NOTIFY_RESUME)
> > > >                         resume_user_mode_work(regs);
> > > >
> > > >                 /* Architecture specific TIF work */
> > > >                 arch_exit_to_user_mode_work(regs, ti_work);
> > > >
> > > >                 /*
> > > >                  * Disable interrupts and reevaluate the work flags as they
> > > >                  * might have changed while interrupts and preemption was
> > > >                  * enabled above.
> > > >                  */
> > > >                 local_irq_disable_exit_to_user();
> > > >
> > > >                 /* Check if any of the above work has queued a
> > > > deferred wakeup */
> > > >                 tick_nohz_user_enter_prepare();
> > > >
> > > >                 ti_work = read_thread_flags();
> > > >         }
> > > >
> > > >         /* Return the latest work state for arch_exit_to_user_mode() */
> > > >         return ti_work;
> > > > }
> > > >
> > > > > --
> > > > > 2.25.1
> > > > >
> > > >
> > > >
> > > > --
> > > > Best Regards
> > > >  Guo Ren
> > >
> > > _______________________________________________
> > > linux-riscv mailing list
> > > linux-riscv@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/linux-riscv



-- 
Best Regards
 Guo Ren
