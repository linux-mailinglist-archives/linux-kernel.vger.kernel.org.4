Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90D9A67225B
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 17:02:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231207AbjARQCa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 11:02:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231663AbjARQBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 11:01:09 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 756E8552AA
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 07:57:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674057463;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iNYvcO8kkg3p5y89N6EBYflH2VhVy1FVGt01miODe+k=;
        b=dB8VGVXsQEyxRx7aHAOGOlj3JOMeDjYyYGlJDfTjgVPHtAVOlMP4/97Ojb3c19JWySlbNU
        Bt7oBdZTmNYBojX2IT6beLCuKRYPtipV+MB/GIeefIcRDaFapRMyhVJbXf7FZHifMhi6J7
        yOUC1KW8ZVGTMkdYAFU3aiCAQEbWHeQ=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-358-fu-BimyBMN-XDi4j86n4gQ-1; Wed, 18 Jan 2023 10:57:42 -0500
X-MC-Unique: fu-BimyBMN-XDi4j86n4gQ-1
Received: by mail-qv1-f71.google.com with SMTP id o95-20020a0c9068000000b005320eb4e959so17558371qvo.16
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 07:57:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iNYvcO8kkg3p5y89N6EBYflH2VhVy1FVGt01miODe+k=;
        b=sqZd9bwsqLBhyzlSCN8s9Afx9NLmH1v9IX0cRZFc/Yxzwnj+Avb3gqXjpsZ0IQ6gXu
         NOT9Jr7AbXsLOycZyFNk0Yq/D2M1H6AHKEUkK3/dGSCIBr8A21tVlMJAOQAJ0rn9u/2X
         Mn3UtWuqUbJ9e0j0F97MX5zvtkVWoJFI9LQ0zowMJXgb/k51Y3kLEEb/hNpqKt4lOPCK
         cG7YNgqgUWNtz6XByuKkDJ+yaf3sgteDg3EV89Yyl1VcMstJKjEGc/NZDG4wc7+AQaRZ
         Lp2q9JWUOwioe8gZDlM88k+ckvn62oxdzvp5Gc2Q5ZOwGqfWt08Vn5dYHzW2nvgBQ1h3
         C1pQ==
X-Gm-Message-State: AFqh2kqBEkGgLcLis/W3F1+A4wpYXbicLfepDy9XIpk9GanA8m+fEicg
        FGc2nLM6SKqU0WxcudLAJKXGlvjcyYjDIGoY1wuOnG3j/cPPyby5qU0Ge5Zco9O/XOTLBx4nhVd
        Ffigoacpz5TmTp3niSNQj/jIM
X-Received: by 2002:ac8:7ee6:0:b0:3a8:28fb:b076 with SMTP id r6-20020ac87ee6000000b003a828fbb076mr8483820qtc.31.1674057461882;
        Wed, 18 Jan 2023 07:57:41 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuVWXnOCF8JTjm7zJQVw9CUCXsITa2sgH9hf9ruDJWzjDR7UWTeJ100E80orMu3VXlFhW4mHg==
X-Received: by 2002:ac8:7ee6:0:b0:3a8:28fb:b076 with SMTP id r6-20020ac87ee6000000b003a828fbb076mr8483790qtc.31.1674057461609;
        Wed, 18 Jan 2023 07:57:41 -0800 (PST)
Received: from vschneid.remote.csb ([154.57.232.159])
        by smtp.gmail.com with ESMTPSA id s11-20020a05620a0bcb00b00704a9942708sm22529918qki.73.2023.01.18.07.57.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 07:57:40 -0800 (PST)
From:   Valentin Schneider <vschneid@redhat.com>
To:     paulmck@kernel.org, Wander Lairson Costa <wander@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        "open list:SCHEDULER" <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] sched/deadline: fix inactive_task_timer splat with
 CONFIG_PREEMPT_RT
In-Reply-To: <20230110222725.GT4028633@paulmck-ThinkPad-P17-Gen-1>
References: <20230104181701.43224-1-wander@redhat.com>
 <20230110013333.GH4028633@paulmck-ThinkPad-P17-Gen-1>
 <CAAq0SUm+VkoM38ULJE6zuajA3Tc7KYbiH51uc9oKjGE+RhDmXg@mail.gmail.com>
 <20230110222725.GT4028633@paulmck-ThinkPad-P17-Gen-1>
Date:   Wed, 18 Jan 2023 15:57:38 +0000
Message-ID: <xhsmha62fj0nh.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/01/23 14:27, Paul E. McKenney wrote:
> On Tue, Jan 10, 2023 at 05:52:03PM -0300, Wander Lairson Costa wrote:
>> On Mon, Jan 9, 2023 at 10:40 PM Paul E. McKenney <paulmck@kernel.org> wrote:
>> >
>> > On Wed, Jan 04, 2023 at 03:17:01PM -0300, Wander Lairson Costa wrote:
>> > > inactive_task_timer() executes in interrupt (atomic) context. It calls
>> > > put_task_struct(), which indirectly acquires sleeping locks under
>> > > PREEMPT_RT.
>> > >
>> > > Below is an example of a splat that happened in a test environment:
>> > >
>> > >  CPU: 1 PID: 2848 Comm: life Kdump: loaded Tainted: G W ---------
>> > >  Hardware name: HP ProLiant DL388p Gen8, BIOS P70 07/15/2012
>> > >  Call Trace:
>> > >  dump_stack_lvl+0x57/0x7d
>> > >  mark_lock_irq.cold+0x33/0xba
>> > >  ? stack_trace_save+0x4b/0x70
>> > >  ? save_trace+0x55/0x150
>> > >  mark_lock+0x1e7/0x400
>> > >  mark_usage+0x11d/0x140
>> > >  __lock_acquire+0x30d/0x930
>> > >  lock_acquire.part.0+0x9c/0x210
>> > >  ? refill_obj_stock+0x3d/0x3a0
>> > >  ? rcu_read_lock_sched_held+0x3f/0x70
>> > >  ? trace_lock_acquire+0x38/0x140
>> > >  ? lock_acquire+0x30/0x80
>> > >  ? refill_obj_stock+0x3d/0x3a0
>> > >  rt_spin_lock+0x27/0xe0
>> > >  ? refill_obj_stock+0x3d/0x3a0
>> > >  refill_obj_stock+0x3d/0x3a0
>> > >  ? inactive_task_timer+0x1ad/0x340
>> > >  kmem_cache_free+0x357/0x560
>> > >  inactive_task_timer+0x1ad/0x340
>> > >  ? switched_from_dl+0x2d0/0x2d0
>> > >  __run_hrtimer+0x8a/0x1a0
>> > >  __hrtimer_run_queues+0x91/0x130
>> > >  hrtimer_interrupt+0x10f/0x220
>> > >  __sysvec_apic_timer_interrupt+0x7b/0xd0
>> > >  sysvec_apic_timer_interrupt+0x4f/0xd0
>> > >  ? asm_sysvec_apic_timer_interrupt+0xa/0x20
>> > >  asm_sysvec_apic_timer_interrupt+0x12/0x20
>> > >  RIP: 0033:0x7fff196bf6f5
>> > >
>> > > Instead of calling put_task_struct() directly, we defer it using
>> > > call_rcu(). A more natural approach would use a workqueue, but since
>> > > in PREEMPT_RT, we can't allocate dynamic memory from atomic context,
>> > > the code would become more complex because we would need to put the
>> > > work_struct instance in the task_struct and initialize it when we
>> > > allocate a new task_struct.
>> > >
>> > > Signed-off-by: Wander Lairson Costa <wander@redhat.com>
>> > > Cc: Paul McKenney <paulmck@kernel.org>
>> > > Cc: Thomas Gleixner <tglx@linutronix.de>
>> > > ---
>> > >  kernel/sched/build_policy.c |  1 +
>> > >  kernel/sched/deadline.c     | 24 +++++++++++++++++++++++-
>> > >  2 files changed, 24 insertions(+), 1 deletion(-)
>> > >
>> > > diff --git a/kernel/sched/build_policy.c b/kernel/sched/build_policy.c
>> > > index d9dc9ab3773f..f159304ee792 100644
>> > > --- a/kernel/sched/build_policy.c
>> > > +++ b/kernel/sched/build_policy.c
>> > > @@ -28,6 +28,7 @@
>> > >  #include <linux/suspend.h>
>> > >  #include <linux/tsacct_kern.h>
>> > >  #include <linux/vtime.h>
>> > > +#include <linux/rcupdate.h>
>> > >
>> > >  #include <uapi/linux/sched/types.h>
>> > >
>> > > diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
>> > > index 9ae8f41e3372..ab9301d4cc24 100644
>> > > --- a/kernel/sched/deadline.c
>> > > +++ b/kernel/sched/deadline.c
>> > > @@ -1405,6 +1405,13 @@ static void update_curr_dl(struct rq *rq)
>> > >       }
>> > >  }
>> > >
>> > > +static void delayed_put_task_struct(struct rcu_head *rhp)
>> > > +{
>> > > +     struct task_struct *task = container_of(rhp, struct task_struct, rcu);
>> > > +
>> > > +     __put_task_struct(task);
>> >
>> > Please note that BH is disabled here.  Don't you therefore
>> > need to schedule a workqueue handler?  Perhaps directly from
>> > inactive_task_timer(), or maybe from this point.  If the latter, one
>> > way to skip the extra step is to use queue_rcu_work().
>> >
>>
>> My initial work was using a workqueue [1,2]. However, I realized I
>> could reach a much simpler code with call_rcu().
>> I am afraid my ignorance doesn't allow me to get your point. Does
>> disabling softirq imply atomic context?
>
> Given that this problem occurred in PREEMPT_RT, I am assuming that the
> appropriate definition of "atomic context" is "cannot call schedule()".
> And you are in fact not permitted to call schedule() from a bh-disabled
> region.
>
> This also means that you cannot acquire a non-raw spinlock in a
> bh-disabled region of code in a PREEMPT_RT kernel, because doing
> so can invoke schedule.
>

But per the PREEMPT_RT lock "replacement", non-raw spinlocks end up
invoking schedule_rtlock(), which should be safe vs BH disabled
(local_lock() + rcu_read_lock()):

  6991436c2b5d ("sched/core: Provide a scheduling point for RT locks")

Unless I'm missing something else?

