Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64A41624BA7
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 21:20:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231678AbiKJUUA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 15:20:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231703AbiKJUTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 15:19:38 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3388ADDC
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 12:18:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668111502;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iHxjGbbPF3OR4OiiEormRWEYr1pX7FfWuR3SwWTEAF0=;
        b=Dci+UGyhcx6JyjOZjuoSdzKpM2ryRo6V6KwF9oWPbCOatiBCmPm5+X23heVEK61jqoOEyO
        jcg/TzyOPsdo3I9iSRackv71EHpkDroKizDNehO7NjuGIROIuctcOm4e/cncDfnHPUJ783
        PZ60EV5YRKYaR2NOf5Ee5hvAKHl0aWk=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-610-E1yEEq9ANTebq2DuGE2AtQ-1; Thu, 10 Nov 2022 15:18:18 -0500
X-MC-Unique: E1yEEq9ANTebq2DuGE2AtQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 93A482999B49;
        Thu, 10 Nov 2022 20:18:17 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-3.gru2.redhat.com [10.97.112.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EFC4A141511F;
        Thu, 10 Nov 2022 20:18:16 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 029A8416D896; Thu, 10 Nov 2022 16:14:33 -0300 (-03)
Date:   Thu, 10 Nov 2022 16:14:33 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Rafael Folco <rfolco@redhat.com>,
        Aaron Tomlin <atomlin@redhat.com>, cl@linux.com,
        tglx@linutronix.de, mingo@kernel.org, peterz@infradead.org,
        pauld@redhat.com, neelx@redhat.com, oleksandr@natalenko.name,
        atomlin@atomlin.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v8 4/5] tick/nohz_full: Ensure quiet_vmstat() is called
 on exit to user-mode when the idle tick is stopped
Message-ID: <Y21NmQr4vFejiMrn@fuller.cnet>
References: <20220924152227.819815-1-atomlin@redhat.com>
 <20220924152227.819815-5-atomlin@redhat.com>
 <CAOr2xH5DjEy7agHYx=5+4cr+OeJz52HUeUttkF9ueS8JHbQMFg@mail.gmail.com>
 <20221021145017.GA1265180@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221021145017.GA1265180@lothringen>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 21, 2022 at 04:50:17PM +0200, Frederic Weisbecker wrote:
> On Tue, Sep 27, 2022 at 01:17:02PM -0300, Rafael Folco wrote:
> > Tested this patch w/ nohz_full setup and oslat 8h run on isolated cpus, max
> > latency is 7us versus 15us without the patch.
> > Thanks.
> 
> What about the added overhead upon user enter?
> That is my main worry. For people who want nohz_full for lowest latency
> (or rather lowest noise) then it's a good add. But what if some people want
> to use nohz_full for HPC and prefer faster syscalls over avoiding an interrupt
> once in a while? (although arguably I never heard from users of such
> workloads...)
> 
> Thanks.

The performance reduction on the mlock test below is only 2.6% (see below).

HPC programs would likely be heavy on accesses to userspace memory,
and not so much on syscall performance at this scale?

Anyway, if this overhead turns out to be a problem for some HPC application
(which you consider unlikely) a knob can be added to control the behaviour.

> > On Mon, Sep 26, 2022 at 8:02 PM Aaron Tomlin <atomlin@redhat.com> wrote:
> > 
> > > This patch ensures CPU-specific vmstat differentials do not remain
> > > when the scheduling-tick is stopped and before exiting to user-mode
> > > in the context of nohz_full only.
> > >
> > > A trivial test program was used to determine the impact of the proposed
> > > changes and under vanilla. The mlock(2) and munlock(2) system calls was
> > > used solely to modify vmstat item 'NR_MLOCK'. The following is an average
> > > count of CPU-cycles across the aforementioned system calls:
> > >
> > >                                   Vanilla                 Modified
> > >
> > >   Cycles per syscall              8461                    8690    (+2.6%)
> > >
> > > Signed-off-by: Aaron Tomlin <atomlin@redhat.com>
> > > ---
> > >  include/linux/tick.h     |  5 +++--
> > >  kernel/time/tick-sched.c | 15 +++++++++++++++
> > >  2 files changed, 18 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/include/linux/tick.h b/include/linux/tick.h
> > > index bfd571f18cfd..a2bbd6d32e33 100644
> > > --- a/include/linux/tick.h
> > > +++ b/include/linux/tick.h
> > > @@ -11,7 +11,6 @@
> > >  #include <linux/context_tracking_state.h>
> > >  #include <linux/cpumask.h>
> > >  #include <linux/sched.h>
> > > -#include <linux/rcupdate.h>
> > >
> > >  #ifdef CONFIG_GENERIC_CLOCKEVENTS
> > >  extern void __init tick_init(void);
> > > @@ -272,6 +271,7 @@ static inline void tick_dep_clear_signal(struct
> > > signal_struct *signal,
> > >
> > >  extern void tick_nohz_full_kick_cpu(int cpu);
> > >  extern void __tick_nohz_task_switch(void);
> > > +void __tick_nohz_user_enter_prepare(void);
> > >  extern void __init tick_nohz_full_setup(cpumask_var_t cpumask);
> > >  #else
> > >  static inline bool tick_nohz_full_enabled(void) { return false; }
> > > @@ -296,6 +296,7 @@ static inline void tick_dep_clear_signal(struct
> > > signal_struct *signal,
> > >
> > >  static inline void tick_nohz_full_kick_cpu(int cpu) { }
> > >  static inline void __tick_nohz_task_switch(void) { }
> > > +static inline void __tick_nohz_user_enter_prepare(void) { }
> > >  static inline void tick_nohz_full_setup(cpumask_var_t cpumask) { }
> > >  #endif
> > >
> > > @@ -308,7 +309,7 @@ static inline void tick_nohz_task_switch(void)
> > >  static inline void tick_nohz_user_enter_prepare(void)
> > >  {
> > >         if (tick_nohz_full_cpu(smp_processor_id()))
> > > -               rcu_nocb_flush_deferred_wakeup();
> > > +               __tick_nohz_user_enter_prepare();
> > >  }
> > >
> > >  #endif
> > > diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
> > > index b0e3c9205946..634cd0fac267 100644
> > > --- a/kernel/time/tick-sched.c
> > > +++ b/kernel/time/tick-sched.c
> > > @@ -26,6 +26,7 @@
> > >  #include <linux/posix-timers.h>
> > >  #include <linux/context_tracking.h>
> > >  #include <linux/mm.h>
> > > +#include <linux/rcupdate.h>
> > >
> > >  #include <asm/irq_regs.h>
> > >
> > > @@ -519,6 +520,20 @@ void __tick_nohz_task_switch(void)
> > >         }
> > >  }
> > >
> > > +void __tick_nohz_user_enter_prepare(void)
> > > +{
> > > +       struct tick_sched *ts;
> > > +
> > > +       if (tick_nohz_full_cpu(smp_processor_id())) {
> > > +               ts = this_cpu_ptr(&tick_cpu_sched);
> > > +
> > > +               if (ts->tick_stopped)
> > > +                       quiet_vmstat();
> > > +               rcu_nocb_flush_deferred_wakeup();
> > > +       }
> > > +}
> > > +EXPORT_SYMBOL_GPL(__tick_nohz_user_enter_prepare);
> > > +
> > >  /* Get the boot-time nohz CPU list from the kernel parameters. */
> > >  void __init tick_nohz_full_setup(cpumask_var_t cpumask)
> > >  {
> > > --
> > > 2.37.1
> > >
> > >
> > >
> > 
> > -- 
> > Folco
> 
> 

