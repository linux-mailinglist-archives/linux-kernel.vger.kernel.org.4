Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7771067407C
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 19:04:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbjASSEQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 13:04:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbjASSD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 13:03:57 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6D0C8CE79
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 10:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674151389;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YbUkbqMkEBPKSmJ1vfZa2Mg+yeA76P/YKFbZPM+Flqg=;
        b=D38UUg1gh/O6LMzfVIP7ESj9gikBFzQeWRmHpSN5eBNI5x2nQJ+h4jXyeu600ZIdnXav6j
        V0Gas3KApK72AxWUGkvleSzUyqeJpP5PmusJWEaEU8hnnsDr9IN0nL80j8+eRgC4q9+BbI
        dcVflj+xC7Q78pmZf6kD/Bv9n5DP5Ik=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-42-b8H_ri3SN7awEO4Pl2aasw-1; Thu, 19 Jan 2023 13:03:08 -0500
X-MC-Unique: b8H_ri3SN7awEO4Pl2aasw-1
Received: by mail-qt1-f198.google.com with SMTP id a13-20020ac8610d000000b003a8151cadebso1288587qtm.10
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 10:03:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YbUkbqMkEBPKSmJ1vfZa2Mg+yeA76P/YKFbZPM+Flqg=;
        b=pWEPAUtzBVICiODohvfRUIJhDUzWV2ex6EnD2HBwDafsqDZRUoYlN8HEEemj1Yzhk6
         ZH6c6nkAt/hxWuHwRf3PCNNZdnKYpfoV36yHRZKzOfhpUHSNe4Mo4tgA7929iTGIe1cK
         f1vsw9d8rftdUnxB2AItAYlMF6odbmi6n2Z/m4nazjLy9yuLIV/zpiNuXz2QWjakUfRD
         ysmCUh3+w6sqCd3G+fxWSxGefbnwxFpTZcuU6Y1AgE0ftNwYOHaBe8CJpRvkGPdLwphb
         cU4TM/EyF3YIDfEuoHmPwg9ISBCFX9CCvHubBHBqwjxSGsFWP7DRPNIIqAa/G+cL4svj
         aBgA==
X-Gm-Message-State: AFqh2kogxSUY+sGLj2dq8CuXCuwYGa3ZCat0C78I+mFdpOhd5mNwGNDM
        sm+nXBIrVpqFis2QR1CqnwTbHS6d5YqujOOV2PO2IR4LYhwv1Nfd4uFCqR8smrzQpOxN+wv+WZ7
        adBB38OSOkxzP7H9fs3Nkd0Gl
X-Received: by 2002:ac8:5189:0:b0:3b6:3ab8:6394 with SMTP id c9-20020ac85189000000b003b63ab86394mr15475539qtn.50.1674151386762;
        Thu, 19 Jan 2023 10:03:06 -0800 (PST)
X-Google-Smtp-Source: AMrXdXse34mSeOx/iNRz/1YnaGHBIPAqAPtflOY6Z/YoxOlClLzH7H6Y/EuQ1Og2os7DxIz4BRtDPw==
X-Received: by 2002:ac8:5189:0:b0:3b6:3ab8:6394 with SMTP id c9-20020ac85189000000b003b63ab86394mr15475517qtn.50.1674151386458;
        Thu, 19 Jan 2023 10:03:06 -0800 (PST)
Received: from vschneid.remote.csb ([154.57.232.159])
        by smtp.gmail.com with ESMTPSA id ew3-20020a05622a514300b003b440ab16fasm6785934qtb.61.2023.01.19.10.03.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 10:03:05 -0800 (PST)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Wander Lairson Costa <wander@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        "open list:SCHEDULER" <linux-kernel@vger.kernel.org>
Cc:     Wander Lairson Costa <wander@redhat.com>,
        Paul McKenney <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] sched/deadline: fix inactive_task_timer splat with
 CONFIG_PREEMPT_RT
In-Reply-To: <20230104181701.43224-1-wander@redhat.com>
References: <20230104181701.43224-1-wander@redhat.com>
Date:   Thu, 19 Jan 2023 18:03:02 +0000
Message-ID: <xhsmh4jsmieqx.mognet@vschneid.remote.csb>
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

On 04/01/23 15:17, Wander Lairson Costa wrote:
> inactive_task_timer() executes in interrupt (atomic) context. It calls
> put_task_struct(), which indirectly acquires sleeping locks under
> PREEMPT_RT.
>
> Below is an example of a splat that happened in a test environment:
>
>  CPU: 1 PID: 2848 Comm: life Kdump: loaded Tainted: G W ---------
>  Hardware name: HP ProLiant DL388p Gen8, BIOS P70 07/15/2012
>  Call Trace:
>  dump_stack_lvl+0x57/0x7d
>  mark_lock_irq.cold+0x33/0xba
>  ? stack_trace_save+0x4b/0x70
>  ? save_trace+0x55/0x150
>  mark_lock+0x1e7/0x400
>  mark_usage+0x11d/0x140
>  __lock_acquire+0x30d/0x930
>  lock_acquire.part.0+0x9c/0x210
>  ? refill_obj_stock+0x3d/0x3a0
>  ? rcu_read_lock_sched_held+0x3f/0x70
>  ? trace_lock_acquire+0x38/0x140
>  ? lock_acquire+0x30/0x80
>  ? refill_obj_stock+0x3d/0x3a0
>  rt_spin_lock+0x27/0xe0
>  ? refill_obj_stock+0x3d/0x3a0
>  refill_obj_stock+0x3d/0x3a0
>  ? inactive_task_timer+0x1ad/0x340
>  kmem_cache_free+0x357/0x560
>  inactive_task_timer+0x1ad/0x340
>  ? switched_from_dl+0x2d0/0x2d0
>  __run_hrtimer+0x8a/0x1a0
>  __hrtimer_run_queues+0x91/0x130
>  hrtimer_interrupt+0x10f/0x220
>  __sysvec_apic_timer_interrupt+0x7b/0xd0
>  sysvec_apic_timer_interrupt+0x4f/0xd0
>  ? asm_sysvec_apic_timer_interrupt+0xa/0x20
>  asm_sysvec_apic_timer_interrupt+0x12/0x20
>  RIP: 0033:0x7fff196bf6f5
>
> Instead of calling put_task_struct() directly, we defer it using
> call_rcu(). A more natural approach would use a workqueue, but since
> in PREEMPT_RT, we can't allocate dynamic memory from atomic context,
> the code would become more complex because we would need to put the
> work_struct instance in the task_struct and initialize it when we
> allocate a new task_struct.
>

Sorry to come back on this; Juri reminded me offline that put_task_struct()
is invoked in other non-sleepable contexts, not just inactive_task_timer().

e.g.

  rto_push_irq_work_func() // hard irq work so hardirq context
  `\
    push_rt_task()
    `\
       put_task_struct()

Or

  cpu_stopper_thread() // stopper callbacks must not sleep
  `\
    push_cpu_stop()
    `\
      put_task_struct()

... But then again I'm not aware of any splats happening in these paths. Is
there something special about inactive_task_timer(), or could it be the
issue is there for those other paths but we just haven't had them reported
yet?

