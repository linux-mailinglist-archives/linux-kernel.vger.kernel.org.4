Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11F7D6079EB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 16:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbiJUOu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 10:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbiJUOu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 10:50:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E5097285B
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 07:50:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1941AB82C38
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 14:50:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67EF3C433C1;
        Fri, 21 Oct 2022 14:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666363820;
        bh=TQO+7YCcmwX5Ypn+TVh8IgVc3EYK8fr9049/M7h40nM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gnyArhmCk3HkvP208bggZCievQlUMH58blr6O/smRjn+IZVLv1Xg/NUycNe+9G5q+
         j2uzlqWN7MNkDw94XuP5LI0swKptccokAXE2KAFHChetDu/IHkoHeelUUY58ahujI3
         EkJ76WT7ownhhrXtRhSA1oL9rVmh6PUg0ZQcyl1ByVhJ/V3q4XHvHKXI0HlLPL0WtQ
         HT8Buvijn+PdCYLzbBllBgtub9/c0qu/rTnMP46AMmedJ1kD5LhLqxyc/lITm8gkhO
         C9EH2kxF3LYwEPCI4u7mVHvNk2LOObYNOzPHCG4qrPtCSPXfb66wr8g1bjlF2FPXNO
         /6vUbzMqgptvQ==
Date:   Fri, 21 Oct 2022 16:50:17 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Rafael Folco <rfolco@redhat.com>
Cc:     Aaron Tomlin <atomlin@redhat.com>, mtosatti@redhat.com,
        cl@linux.com, tglx@linutronix.de, mingo@kernel.org,
        peterz@infradead.org, pauld@redhat.com, neelx@redhat.com,
        oleksandr@natalenko.name, atomlin@atomlin.com,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v8 4/5] tick/nohz_full: Ensure quiet_vmstat() is called
 on exit to user-mode when the idle tick is stopped
Message-ID: <20221021145017.GA1265180@lothringen>
References: <20220924152227.819815-1-atomlin@redhat.com>
 <20220924152227.819815-5-atomlin@redhat.com>
 <CAOr2xH5DjEy7agHYx=5+4cr+OeJz52HUeUttkF9ueS8JHbQMFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOr2xH5DjEy7agHYx=5+4cr+OeJz52HUeUttkF9ueS8JHbQMFg@mail.gmail.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2022 at 01:17:02PM -0300, Rafael Folco wrote:
> Tested this patch w/ nohz_full setup and oslat 8h run on isolated cpus, max
> latency is 7us versus 15us without the patch.
> Thanks.

What about the added overhead upon user enter?
That is my main worry. For people who want nohz_full for lowest latency
(or rather lowest noise) then it's a good add. But what if some people want
to use nohz_full for HPC and prefer faster syscalls over avoiding an interrupt
once in a while? (although arguably I never heard from users of such
workloads...)

Thanks.


> 
> On Mon, Sep 26, 2022 at 8:02 PM Aaron Tomlin <atomlin@redhat.com> wrote:
> 
> > This patch ensures CPU-specific vmstat differentials do not remain
> > when the scheduling-tick is stopped and before exiting to user-mode
> > in the context of nohz_full only.
> >
> > A trivial test program was used to determine the impact of the proposed
> > changes and under vanilla. The mlock(2) and munlock(2) system calls was
> > used solely to modify vmstat item 'NR_MLOCK'. The following is an average
> > count of CPU-cycles across the aforementioned system calls:
> >
> >                                   Vanilla                 Modified
> >
> >   Cycles per syscall              8461                    8690    (+2.6%)
> >
> > Signed-off-by: Aaron Tomlin <atomlin@redhat.com>
> > ---
> >  include/linux/tick.h     |  5 +++--
> >  kernel/time/tick-sched.c | 15 +++++++++++++++
> >  2 files changed, 18 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/linux/tick.h b/include/linux/tick.h
> > index bfd571f18cfd..a2bbd6d32e33 100644
> > --- a/include/linux/tick.h
> > +++ b/include/linux/tick.h
> > @@ -11,7 +11,6 @@
> >  #include <linux/context_tracking_state.h>
> >  #include <linux/cpumask.h>
> >  #include <linux/sched.h>
> > -#include <linux/rcupdate.h>
> >
> >  #ifdef CONFIG_GENERIC_CLOCKEVENTS
> >  extern void __init tick_init(void);
> > @@ -272,6 +271,7 @@ static inline void tick_dep_clear_signal(struct
> > signal_struct *signal,
> >
> >  extern void tick_nohz_full_kick_cpu(int cpu);
> >  extern void __tick_nohz_task_switch(void);
> > +void __tick_nohz_user_enter_prepare(void);
> >  extern void __init tick_nohz_full_setup(cpumask_var_t cpumask);
> >  #else
> >  static inline bool tick_nohz_full_enabled(void) { return false; }
> > @@ -296,6 +296,7 @@ static inline void tick_dep_clear_signal(struct
> > signal_struct *signal,
> >
> >  static inline void tick_nohz_full_kick_cpu(int cpu) { }
> >  static inline void __tick_nohz_task_switch(void) { }
> > +static inline void __tick_nohz_user_enter_prepare(void) { }
> >  static inline void tick_nohz_full_setup(cpumask_var_t cpumask) { }
> >  #endif
> >
> > @@ -308,7 +309,7 @@ static inline void tick_nohz_task_switch(void)
> >  static inline void tick_nohz_user_enter_prepare(void)
> >  {
> >         if (tick_nohz_full_cpu(smp_processor_id()))
> > -               rcu_nocb_flush_deferred_wakeup();
> > +               __tick_nohz_user_enter_prepare();
> >  }
> >
> >  #endif
> > diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
> > index b0e3c9205946..634cd0fac267 100644
> > --- a/kernel/time/tick-sched.c
> > +++ b/kernel/time/tick-sched.c
> > @@ -26,6 +26,7 @@
> >  #include <linux/posix-timers.h>
> >  #include <linux/context_tracking.h>
> >  #include <linux/mm.h>
> > +#include <linux/rcupdate.h>
> >
> >  #include <asm/irq_regs.h>
> >
> > @@ -519,6 +520,20 @@ void __tick_nohz_task_switch(void)
> >         }
> >  }
> >
> > +void __tick_nohz_user_enter_prepare(void)
> > +{
> > +       struct tick_sched *ts;
> > +
> > +       if (tick_nohz_full_cpu(smp_processor_id())) {
> > +               ts = this_cpu_ptr(&tick_cpu_sched);
> > +
> > +               if (ts->tick_stopped)
> > +                       quiet_vmstat();
> > +               rcu_nocb_flush_deferred_wakeup();
> > +       }
> > +}
> > +EXPORT_SYMBOL_GPL(__tick_nohz_user_enter_prepare);
> > +
> >  /* Get the boot-time nohz CPU list from the kernel parameters. */
> >  void __init tick_nohz_full_setup(cpumask_var_t cpumask)
> >  {
> > --
> > 2.37.1
> >
> >
> >
> 
> -- 
> Folco
