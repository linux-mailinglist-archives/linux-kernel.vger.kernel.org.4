Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95E1A67432F
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 20:54:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbjASTyn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 14:54:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjASTym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 14:54:42 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0B2A3595
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 11:53:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674158038;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=409F5wmel/vUFc3XlkDnkXfgswWyPEf/KY0z/Ahx84E=;
        b=Q469yLaxdjUEeRU982klsene/I7kgiWPzGejPODpIkA75mfH0NlVluChOS4DKhjNdlTKuv
        +AuinWGjoS80zUFL55zziHXLDP0f+u0RelGJCUDIhZZegEvvtxKLO+wmhvNAjQ7cQPK1AC
        TZxFbQRDW3JXRypfPMTh7Ql16ge3M8M=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-483-E8ZZvv1kNkysIVNgPPTL0w-1; Thu, 19 Jan 2023 14:53:56 -0500
X-MC-Unique: E8ZZvv1kNkysIVNgPPTL0w-1
Received: by mail-pj1-f71.google.com with SMTP id s22-20020a17090aad9600b002271d094c82so3835557pjq.7
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 11:53:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=409F5wmel/vUFc3XlkDnkXfgswWyPEf/KY0z/Ahx84E=;
        b=T/lA0xL6oSvZFgcH7n/9q44vKnipcXuwdWX8+T4sRSwl5NCy1jVz4ggrGGrO56B8nu
         uPyVnK6H+iNJQygNLIBQfG85Uxac7T7BuTjs9RoM3XiiFAkzbg+rZr8Oyhsr11tru+I/
         L4V6TN+1WpF5YphwbXaGjn4Abv+9FfZ1t3Qbe3UMHgdSv1+gjfIniVr75InhC6k8o7Rl
         zXCkvAnu/g8stcPcRfxgaDjde8bCrqsX715v1lZz50n5hvq4d8Y1tsez31xUkVakHJC2
         rZyqSkQsIMx/5lDPZjvRAcWvMPlA9pxjLbReyduMJlC5oHDcgrvsNcGABcx1eP3F0sbk
         KIJA==
X-Gm-Message-State: AFqh2kog51BQC0seox6xToBH6Gy/kawGXrPpM5gzatn6VhHVcr1mc1LV
        JONAuQqk+aSguagmJtbzILLIQdpq0AtXqO8eD1TZnk0wJYXGZXFCAFyCIFQyrZ5KzDi79+rhCDM
        s3h47qEieD3UCero48eDiLrjdCWIIt4XFYTKKwRir
X-Received: by 2002:a63:5d4a:0:b0:4cf:7658:d456 with SMTP id o10-20020a635d4a000000b004cf7658d456mr1115842pgm.151.1674158035666;
        Thu, 19 Jan 2023 11:53:55 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtzMzY+ToumeZYsVoUmT15B+VVcTLpTK+fHyL28jlXoMmOlZMSFzetRV7KFsRWdzCdCpWOmzLH17uI37yo3q7k=
X-Received: by 2002:a63:5d4a:0:b0:4cf:7658:d456 with SMTP id
 o10-20020a635d4a000000b004cf7658d456mr1115832pgm.151.1674158035426; Thu, 19
 Jan 2023 11:53:55 -0800 (PST)
MIME-Version: 1.0
References: <20230104181701.43224-1-wander@redhat.com> <xhsmh4jsmieqx.mognet@vschneid.remote.csb>
In-Reply-To: <xhsmh4jsmieqx.mognet@vschneid.remote.csb>
From:   Wander Lairson Costa <wander@redhat.com>
Date:   Thu, 19 Jan 2023 16:53:44 -0300
Message-ID: <CAAq0SUmBCdMVgEqb0U8nAc8cNCc9YKwLp0YtCBtJncQOPi-5qg@mail.gmail.com>
Subject: Re: [PATCH] sched/deadline: fix inactive_task_timer splat with CONFIG_PREEMPT_RT
To:     Valentin Schneider <vschneid@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        "open list:SCHEDULER" <linux-kernel@vger.kernel.org>,
        Paul McKenney <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2023 at 3:03 PM Valentin Schneider <vschneid@redhat.com> wrote:
>
> On 04/01/23 15:17, Wander Lairson Costa wrote:
> > inactive_task_timer() executes in interrupt (atomic) context. It calls
> > put_task_struct(), which indirectly acquires sleeping locks under
> > PREEMPT_RT.
> >
> > Below is an example of a splat that happened in a test environment:
> >
> >  CPU: 1 PID: 2848 Comm: life Kdump: loaded Tainted: G W ---------
> >  Hardware name: HP ProLiant DL388p Gen8, BIOS P70 07/15/2012
> >  Call Trace:
> >  dump_stack_lvl+0x57/0x7d
> >  mark_lock_irq.cold+0x33/0xba
> >  ? stack_trace_save+0x4b/0x70
> >  ? save_trace+0x55/0x150
> >  mark_lock+0x1e7/0x400
> >  mark_usage+0x11d/0x140
> >  __lock_acquire+0x30d/0x930
> >  lock_acquire.part.0+0x9c/0x210
> >  ? refill_obj_stock+0x3d/0x3a0
> >  ? rcu_read_lock_sched_held+0x3f/0x70
> >  ? trace_lock_acquire+0x38/0x140
> >  ? lock_acquire+0x30/0x80
> >  ? refill_obj_stock+0x3d/0x3a0
> >  rt_spin_lock+0x27/0xe0
> >  ? refill_obj_stock+0x3d/0x3a0
> >  refill_obj_stock+0x3d/0x3a0
> >  ? inactive_task_timer+0x1ad/0x340
> >  kmem_cache_free+0x357/0x560
> >  inactive_task_timer+0x1ad/0x340
> >  ? switched_from_dl+0x2d0/0x2d0
> >  __run_hrtimer+0x8a/0x1a0
> >  __hrtimer_run_queues+0x91/0x130
> >  hrtimer_interrupt+0x10f/0x220
> >  __sysvec_apic_timer_interrupt+0x7b/0xd0
> >  sysvec_apic_timer_interrupt+0x4f/0xd0
> >  ? asm_sysvec_apic_timer_interrupt+0xa/0x20
> >  asm_sysvec_apic_timer_interrupt+0x12/0x20
> >  RIP: 0033:0x7fff196bf6f5
> >
> > Instead of calling put_task_struct() directly, we defer it using
> > call_rcu(). A more natural approach would use a workqueue, but since
> > in PREEMPT_RT, we can't allocate dynamic memory from atomic context,
> > the code would become more complex because we would need to put the
> > work_struct instance in the task_struct and initialize it when we
> > allocate a new task_struct.
> >
>
> Sorry to come back on this; Juri reminded me offline that put_task_struct()
> is invoked in other non-sleepable contexts, not just inactive_task_timer().
>

I guess there is no splat because the usage count doesn't reach zero
in those code paths.

> e.g.
>
>   rto_push_irq_work_func() // hard irq work so hardirq context
>   `\
>     push_rt_task()
>     `\
>        put_task_struct()
>

This is paired with a get_task_struct() a few lines above inside in
the same function.

> Or
>
>   cpu_stopper_thread() // stopper callbacks must not sleep
>   `\
>     push_cpu_stop()
>     `\
>       put_task_struct()
>

This is paired with a get_task_struct() from get_push_task()

> ... But then again I'm not aware of any splats happening in these paths. Is
> there something special about inactive_task_timer(), or could it be the
> issue is there for those other paths but we just haven't had them reported
> yet?
>

Given that those calls have corresponding get_task_struct() calls that
are close in time, there is a low probability of the usage count
reaching zero and triggering the splat. In any case, I will work in a
v2 that also addresses those call sites.

