Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6611E5B5C58
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 16:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbiILOic (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 10:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiILOia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 10:38:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA2132ED7B
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 07:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662993508;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=k+KaS0fM2LtTWTqQre34n/5PD+Y3KKlfchETGtwq+Wo=;
        b=dtZz514Egw0ido86riPlkCu8k6Kf6RWODsBjMUyTCASLL7nSsBJgGmCkOV6tPiNBDuIZzY
        zRK4GRrnmqcQfabmw7JSFYmoaq1/Jsx829AlHzWtBzxtv9LNZeG92vlrE/zzW6lKTT4eNF
        lscVZguVldXL+5NBlTrxSj+QmGeV+Uk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-414-W0_iQyY6M2mqJsPinexiCQ-1; Mon, 12 Sep 2022 10:38:26 -0400
X-MC-Unique: W0_iQyY6M2mqJsPinexiCQ-1
Received: by mail-wm1-f71.google.com with SMTP id c5-20020a7bc005000000b003a63a3570f2so3098139wmb.8
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 07:38:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=k+KaS0fM2LtTWTqQre34n/5PD+Y3KKlfchETGtwq+Wo=;
        b=XoWjoRyPrQZURVd9igwIBW4gsLZ8l4rtsicN5KDft5XxCRPThjt/YnGlqHJLEgWo44
         eqSoqRHC4puGXc3JeHAnt5af6hunSnkCsuTv8du+tjHyJQjAdSsTlHT8IbCte5LyZHm2
         D1oRfZ4U4P3W5HzAxUcoSO+AfvVoJuAucKfR7o0sALzJuU9ITahGpv3lJV8k71PNP2Zb
         U1qZHeg0tnIG6ThUgiaKW5JvUUZlO0BZ8vkxQgigxPO05stnq0byoIsUCY11BdkktFat
         4K9ytGs1gups5M7zYCpEqpLeQpOqeWjSkd/gqVbBe7tAz2hV6DHeT59jUD754eKd1PXs
         89Qg==
X-Gm-Message-State: ACgBeo1M7vuYAuptPVfIyZK7y0SWXYa/IQvd502mahdOmjw6Vt+2VQ2O
        e6V17VWg3uvbZnX9x+dNDvyPGvrzqNBOuGKdwZU2ef/NN4wDdB/KvOEEEbxu6d9ZgW/ckWOvtKW
        MulgY9k6NaRqkV3aCYVQV0UU=
X-Received: by 2002:a05:600c:4e89:b0:3b4:8648:c4e1 with SMTP id f9-20020a05600c4e8900b003b48648c4e1mr4043676wmq.26.1662993504714;
        Mon, 12 Sep 2022 07:38:24 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5ayv/qWTCTw5RPK88jYtq0JR4D1IAi2vB6wkp8G23D0cBKEqTvSUyTpTgCjSUnKT2mRKr2hg==
X-Received: by 2002:a05:600c:4e89:b0:3b4:8648:c4e1 with SMTP id f9-20020a05600c4e8900b003b48648c4e1mr4043656wmq.26.1662993504497;
        Mon, 12 Sep 2022 07:38:24 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id y25-20020a05600c365900b003b483000583sm4934789wmq.48.2022.09.12.07.38.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 07:38:23 -0700 (PDT)
Date:   Mon, 12 Sep 2022 15:38:23 +0100
From:   Aaron Tomlin <atomlin@redhat.com>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     Frederic Weisbecker <frederic@kernel.org>, cl@linux.com,
        tglx@linutronix.de, mingo@kernel.org, peterz@infradead.org,
        pauld@redhat.com, neelx@redhat.com, oleksandr@natalenko.name,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v7 2/3] tick/sched: Ensure quiet_vmstat() is called when
 the idle tick was stopped too
Message-ID: <20220912143822.irn6xhs2etmumqlt@ava.usersys.com>
X-PGP-Key: http://pgp.mit.edu/pks/lookup?search=atomlin%40redhat.com
X-PGP-Fingerprint: 7906 84EB FA8A 9638 8D1E  6E9B E2DE 9658 19CC 77D6
References: <20220817191346.287594886@redhat.com>
 <20220817191524.201253713@redhat.com>
 <20220909121224.GA220905@lothringen>
 <YxuViCnKcIYVE02B@fuller.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YxuViCnKcIYVE02B@fuller.cnet>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2022-09-09 16:35 -0300, Marcelo Tosatti wrote:
> For the scenario where we re-enter idle without calling quiet_vmstat:
> 
> 
> CPU-0			CPU-1
> 
> 0) vmstat_shepherd notices its necessary to queue vmstat work 
> to remote CPU, queues deferrable timer into timer wheel, and calls
> trigger_dyntick_cpu (target_cpu == cpu-1).
> 
> 			1) Stop the tick (get_next_timer_interrupt will not take deferrable
> 			   timers into account), calls quiet_vmstat, which keeps the vmstat work
> 			   (vmstat_update function) queued.
> 			2) Idle
> 			3) Idle exit
> 			4) Run thread on CPU, some activity marks vmstat dirty
> 			5) Idle
> 			6) Goto 3
> 
> At 5, since the tick is already stopped, the deferrable 
> timer for the delayed work item will not execute,
> and vmstat_shepherd will consider 
> 
> static void vmstat_shepherd(struct work_struct *w)
> {
>         int cpu;
> 
>         cpus_read_lock();
>         /* Check processors whose vmstat worker threads have been disabled */
>         for_each_online_cpu(cpu) {
>                 struct delayed_work *dw = &per_cpu(vmstat_work, cpu);
> 
>                 if (!delayed_work_pending(dw) && need_update(cpu))
>                         queue_delayed_work_on(cpu, mm_percpu_wq, dw, 0);
> 
>                 cond_resched();
>         }
>         cpus_read_unlock();
> 
>         schedule_delayed_work(&shepherd,
>                 round_jiffies_relative(sysctl_stat_interval));
> }
> 
> As far as i can tell...

Hi Marcelo,

Yes, I agree with the scenario above.

> > > Consider the following theoretical scenario:
> > > 
> > >         1.      CPU Y migrated running task A to CPU X that was
> > >                 in an idle state i.e. waiting for an IRQ - not
> > >                 polling; marked the current task on CPU X to
> > >                 need/or require a reschedule i.e., set
> > >                 TIF_NEED_RESCHED and invoked a reschedule IPI to
> > >                 CPU X (see sched_move_task())
> > 
> > CPU Y is nohz_full right?
> > 
> > > 
> > >         2.      CPU X acknowledged the reschedule IPI from CPU Y;
> > >                 generic idle loop code noticed the
> > >                 TIF_NEED_RESCHED flag against the idle task and
> > >                 attempts to exit of the loop and calls the main
> > >                 scheduler function i.e. __schedule().
> > > 
> > >                 Since the idle tick was previously stopped no
> > >                 scheduling-clock tick would occur.
> > >                 So, no deferred timers would be handled
> > > 
> > >         3.      Post transition to kernel execution Task A
> > >                 running on CPU Y, indirectly released a few pages
> > >                 (e.g. see __free_one_page()); CPU Y's
> > >                 'vm_stat_diff[NR_FREE_PAGES]' was updated and zone
> > >                 specific 'vm_stat[]' update was deferred as per the
> > >                 CPU-specific stat threshold
> > > 
> > >         4.      Task A does invoke exit(2) and the kernel does
> > >                 remove the task from the run-queue; the idle task
> > >                 was selected to execute next since there are no
> > >                 other runnable tasks assigned to the given CPU
> > >                 (see pick_next_task() and pick_next_task_idle())
> > 
> > This happens on CPU X, right?
> > 
> > > 
> > >         5.      On return to the idle loop since the idle tick
> > >                 was already stopped and can remain so (see [1]
> > >                 below) e.g. no pending soft IRQs, no attempt is
> > >                 made to zero and fold CPU Y's vmstat counters
> > >                 since reprogramming of the scheduling-clock tick
> > >                 is not required/or needed (see [2])
> > 
> > And now back to CPU Y, confused...
> 
> Aaron, can you explain the diagram above? 

Hi Frederic,

Sorry about that. How about the following:

 - Note: CPU X is part of 'tick_nohz_full_mask'

    1.      CPU Y migrated running task A to CPU X that
	    was in an idle state i.e. waiting for an IRQ;
	    marked the current task on CPU X to need/or
	    require a reschedule i.e., set TIF_NEED_RESCHED
	    and invoked a reschedule IPI to CPU X
	    (see sched_move_task())

    2.      CPU X acknowledged the reschedule IPI. Generic
	    idle loop code noticed the TIF_NEED_RESCHED flag
	    against the idle task and attempts to exit of the
	    loop and calls the main scheduler function i.e.
	    __schedule().

	    Since the idle tick was previously stopped no
	    scheduling-clock tick would occur.
	    So, no deferred timers would be handled

    3.      Post transition to kernel execution Task A
	    running on CPU X, indirectly released a few pages
	    (e.g. see __free_one_page()); CPU X's
	    'vm_stat_diff[NR_FREE_PAGES]' was updated and zone
	    specific 'vm_stat[]' update was deferred as per the
	    CPU-specific stat threshold

    4.      Task A does invoke exit(2) and the kernel does
	    remove the task from the run-queue; the idle task
	    was selected to execute next since there are no
	    other runnable tasks assigned to the given CPU
	    (see pick_next_task() and pick_next_task_idle())

    5.      On return to the idle loop since the idle tick
	    was already stopped and can remain so (see [1]
	    below) e.g. no pending soft IRQs, no attempt is
	    made to zero and fold CPU X's vmstat counters
	    since reprogramming of the scheduling-clock tick
	    is not required/or needed (see [2])



Kind regards,

-- 
Aaron Tomlin

