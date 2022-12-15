Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F40A64E48F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 00:12:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbiLOXM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 18:12:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbiLOXMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 18:12:33 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 607C662EA5
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 15:12:32 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id 1so833757lfz.4
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 15:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AG4+hvpLE5WGnkco+PflXfHP5Nt2Zm5cqKaYqL7QYbQ=;
        b=bQ5fFy8c3bB/z3+SbJvnIkhTphh27Y0ckVwYyvEk/jSICew6xTX/jO5KLU66ijtuUO
         GODXJZqoHuPpxnruVZiCDgJtg99a/9Y9Uj11k5avwo93Jmhthd+z1wcFRuPr1yrkMW7r
         J9bgAvjq1MD1CliTxG5uARr34WXsoJx7TVaVk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AG4+hvpLE5WGnkco+PflXfHP5Nt2Zm5cqKaYqL7QYbQ=;
        b=XlHa5q1qGQAS8/5+66nO/kHZZ7HQosFAlUnG107Zocwuti12en0lJjtZuVOFtyAj1D
         yANCdDjeNNnaRcWXBXc9JMJ6pbttFqL8w8F0AiiP1CVLDAsFtiVSHOMXJnsB1RK7rY5q
         7rtuu2Z1C7tziGjX+6SqQUPGbOz0Fkv4PZ+ZS04VsCloOGBgetWOM1wa/guTTwIjQ+hH
         USH8AC438f+2Fv7hMQZ/wMFLbs3QgfzRrJwhCi+nT/WCWYzTGaDTQQu3TiW2yZd61wMy
         7g0llRtDWo64nWtfuHVJL/WDmX409TiX6z2JH26V71g4G6C2ShvdbvRM4VGCCB0Hu26i
         2VEQ==
X-Gm-Message-State: ANoB5pn000/MGhm+7CT0JVApyhhSf2VrW2StfhQiE+PhYNpRjhP0OFE2
        wvE4SIpr+oP+O2BFGxfkXgdpDgVEjMZguJRePSB/KA==
X-Google-Smtp-Source: AA0mqf63WE18OugfqywHqz2gEepTSzaA8gaIXfPsUihoOUF0PgiwYiIMwbnpdNK2UmRMhkP/E2Ny+ucuRgjlS7B+1IQ=
X-Received: by 2002:a05:6512:224c:b0:4b5:ad89:8174 with SMTP id
 i12-20020a056512224c00b004b5ad898174mr2344797lfu.84.1671145950629; Thu, 15
 Dec 2022 15:12:30 -0800 (PST)
MIME-Version: 1.0
References: <20221123012104.3317665-1-joel@joelfernandes.org>
 <20221123012104.3317665-2-joel@joelfernandes.org> <38ab85af-7cc2-55b5-7e3b-2b8444b95133@arm.com>
 <CAEXW_YTJjLLH2u8AeyAm7zN2q083rM2ArRo2QOVBQ0KBYcV13Q@mail.gmail.com> <40db2fab-0a7f-6ead-28a3-e4408737c6f4@arm.com>
In-Reply-To: <40db2fab-0a7f-6ead-28a3-e4408737c6f4@arm.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Thu, 15 Dec 2022 18:12:19 -0500
Message-ID: <CAEXW_YQdTgdoPbPWsf3zwvSdk=KPyPPEGG2m5aEWS4e5z9zo+Q@mail.gmail.com>
Subject: Re: [PATCH RFC 1/3] sched/pe: Exclude balance callback queuing during
 proxy()'s migrate
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     linux-kernel@vger.kernel.org, Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        kernel-team@android.com, John Stultz <jstultz@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Connor O'Brien" <connoro@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 12, 2022 at 9:39 AM Dietmar Eggemann
<dietmar.eggemann@arm.com> wrote:
>
> Hi Joel,
>
> On 09/12/2022 17:52, Joel Fernandes wrote:
> > Hi Dietmar!
> >
> > On Fri, Dec 9, 2022 at 3:07 PM Dietmar Eggemann
> > <dietmar.eggemann@arm.com> wrote:
> >>
> >> On 23/11/2022 02:21, Joel Fernandes (Google) wrote:
>
> [...]
>
> >> You consider rt_mutex_setprio() and __sched_setscheduler() versus
> >> proxy() but what about all the other places like load_balance(),
> >> update_blocked_averages(),  __set_cpus_allowed_ptr() and many
> >> more in which we take the rq lock (via task_rq_lock() or
> >> rq_lock{_xxx}())?
> >
> > You are right. Those paths potentially need updates as well. Any
>
> IMHO, you would still have to lock the entire `queue->execute` (1)->(2)
> thing, like keeping the rq lock currently.
>
> __schedule()
>
>   pick_next_task()
>     pick_next_task_{rt/dl}()
>       set_next_task_{rt/dl}()
>        {rt/deadline}_queue_push_tasks()
>          queue_balance_callback() -->    (1)
>
>   proxy()                         ---    !!!
>
>   finish_lock_switch()
>     __balance_callbacks()         <--    (2)
>
>   __balance_callbacks(rq)         <--    (2)

Instead of locking it throughout, I think we can keep my initial patch
and just execute the balance callbacks in proxy() before dropping the
rq lock. I *think* that will make it work properly, but I could be
missing something.

Anyway I see the issue you bring up, I took care of balance CBs queued
from *other CPUs* while the rq lock is dropped, but the current CPU
executing proxy() could itself have queued balance callbacks. Dropping
the rq lock then causes other CPUs to see the proxy() CPU's balance
CBs in the callback list.

Anyway I will try the above and get back to you. Thanks so much again
for the insights. Will test as you suggested below.

Thanks,

 - Joel


> Otherwise. something like this could happen:
>
> With `x-x` : smp_processor_id()-cpu_of(rq)
>
> lock_torture_wr-1745 [003] 338.270963: queue_balance_callback: 3-3->
> lock_torture_wr-1745 [003] 338.270965: queue_balance_callback: 3-3<-
>             cat-1726 [001] 338.270969: __schedule: proxy() 1-1->
> lock_torture_wr-1745 [003] 338.270971: __schedule: proxy() 3-3->
>             cat-1726 [001] 338.270972: __schedule: proxy() 1-1<-
> lock_torture_wr-1745 [003] 338.270979: __schedule: proxy() 3-3<-
>          <idle>-0    [002] 338.270981: __schedule: proxy() 2-2->
>          <idle>-0    [002] 338.270984: __schedule: proxy() 2-2<-
> lock_torture_wr-1745 [003] 338.270985: __schedule: proxy() 3-3->
>     migration/4-34   [004] 338.270989: active_load_balance_cpu_stop: rq_pin_lock() 4-3 <-- ! cb on CPU3 still enqueued
>
> > chance you could post stack traces or logs of those issues, just in
> > case they have new nuggets of information? If you don't have them,
> > don't bother, I'll reproduce it.
>
> insmod /lib/modules/torture.ko random_shuffle=1 lock_torture_writer_fifo=1
> insmod /lib/modules/locktorture.ko torture_type=mutex_lock nlocks=3
>
> [  447.046916] rq->balance_callback && rq->balance_callback != &balance_push_callback
> [  447.046926] WARNING: CPU: 1 PID: 1648 at kernel/sched/sched.h:1583 task_rq_lock+0x148/0x170
> [  447.062914] Modules linked in: locktorture(O) torture(O)
> [  447.068254] CPU: 1 PID: 1648 Comm: torture_shuffle Tainted: G W  O 6.1.0-rc2-00036-g397ce37b37a8-dirty #203
> [  447.079168] Hardware name: ARM Juno development board (r0) (DT)
> [  447.085106] pstate: 600000c5 (nZCv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [  447.092095] pc : task_rq_lock+0x148/0x170
> [  447.096121] lr : task_rq_lock+0x148/0x170
> [  447.100146] sp : ffff80000b85bd30
> ...
> [  447.175138] Call trace:
> [  447.177589]  task_rq_lock+0x148/0x170
> [  447.181267]  __set_cpus_allowed_ptr+0x34/0xc0
> [  447.185643]  set_cpus_allowed_ptr+0x30/0x60
> [  447.189843]  torture_shuffle+0x158/0x224 [torture]
> [  447.194666]  kthread+0x10c/0x110
> [  447.197906]  ret_from_fork+0x10/0x20
> ...
> [  447.233560] ---[ end trace 0000000000000000 ]---
>
>
> [  446.542532] ------------[ cut here ]------------
> [  446.553224] rq->balance_callback && rq->balance_callback != &balance_push_callback
> [  446.553243] WARNING: CPU: 3 PID: 0 at kernel/sched/sched.h:1583 update_blocked_averages+0x784/0x78c
> [  446.576089] Modules linked in: locktorture(O+) torture(O)
> [  446.581551] CPU: 3 PID: 0 Comm: swapper/3 Tainted: G O 6.1.0-rc2-00036-g397ce37b37a8-dirty #203
> [  446.591723] Hardware name: ARM Juno development board (r0) (DT)
> [  446.597691] pstate: 600000c5 (nZCv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [  446.604712] pc : update_blocked_averages+0x784/0x78c
> [  446.609723] lr : update_blocked_averages+0x784/0x78c
> [  446.614733] sp : ffff80000b403b70
> ...
> [  446.690142] Call trace:
> [  446.692609]  update_blocked_averages+0x784/0x78c
> [  446.697270]  newidle_balance+0x184/0x5f0
> [  446.701232]  pick_next_task_fair+0x2c/0x500
> [  446.705456]  __schedule+0x1d4/0x1084
> [  446.709070]  schedule_idle+0x28/0x4c
> [  446.712682]  do_idle+0x1d4/0x2d0
> [  446.715946]  cpu_startup_entry+0x28/0x30
> [  446.719909]  secondary_start_kernel+0x138/0x15c
> [  446.724486]  __secondary_switched+0xb0/0xb4
> ...
> [  446.765848] ---[ end trace 0000000000000000 ]---
>
>
> [   95.091675] ------------[ cut here ]------------
> [   95.096301] rq->balance_callback && rq->balance_callback != &balance_push_callback
> [   95.096322] WARNING: CPU: 5 PID: 39 at kernel/sched/sched.h:1583 load_balance+0x644/0xdc0
> [   95.103135] mutex_lock-torture: Creating lock_torture_writer task
> [   95.103238] mutex_lock-torture: lock_torture_writer task started
> [   95.110692] Modules linked in: locktorture(O+) torture(O)
> [   95.136699] CPU: 5 PID: 39 Comm: migration/5 Tainted: G O 6.1.0-rc2-00036-g397ce37b37a8-dirty #204
> [   95.147137] Hardware name: ARM Juno development board (r0) (DT)
> [   95.153105] Stopper: 0x0 <- 0x0
> [   95.156282] pstate: 600000c5 (nZCv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [   95.163306] pc : load_balance+0x644/0xdc0
> [   95.167356] lr : load_balance+0x644/0xdc0
> [   95.171405] sp : ffff80000b4cbaf0
> ...
> [   95.246833] Call trace:
> [   95.249300]  load_balance+0x644/0xdc0
> [   95.253000]  newidle_balance+0x290/0x6f0
> [   95.256963]  pick_next_task_fair+0x2c/0x510
> [   95.261188]  __schedule+0x1d4/0x1084
> [   95.264801]  schedule+0x64/0x11c
> [   95.268063]  smpboot_thread_fn+0xa4/0x270
> [   95.272115]  kthread+0x10c/0x110
> [   95.275375]  ret_from_fork+0x10/0x20
> ...
> [   95.316477] ---[ end trace 0000000000000000 ]---
>
>
> [  134.893379] ------------[ cut here ]------------
> [  134.898066] rq->balance_callback && rq->balance_callback != &balance_push_callback
> [  134.898088] WARNING: CPU: 4 PID: 0 at kernel/sched/sched.h:1583 sched_rt_period_timer+0x1dc/0x3f0
> [  134.914683] Modules linked in: locktorture(O) torture(O)
> [  134.920059] CPU: 4 PID: 0 Comm: swapper/4 Tainted: G W  O 6.1.0-rc2-00036-g397ce37b37a8-dirty #204
> [  134.930235] Hardware name: ARM Juno development board (r0) (DT)
> [  134.936205] pstate: 600000c5 (nZCv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [  134.943229] pc : sched_rt_period_timer+0x1dc/0x3f0
> [  134.948069] lr : sched_rt_period_timer+0x1dc/0x3f0
> [  134.952908] sp : ffff80000b2cbde0
> ...
> [  135.028342] Call trace:
> [  135.030810]  sched_rt_period_timer+0x1dc/0x3f0
> [  135.035300]  __hrtimer_run_queues+0x184/0x504
> [  135.039700]  hrtimer_interrupt+0xe8/0x244
> [  135.043749]  arch_timer_handler_phys+0x2c/0x44
> [  135.048239]  handle_percpu_devid_irq+0x8c/0x150
> [  135.052815]  generic_handle_domain_irq+0x2c/0x44
> [  135.057480]  gic_handle_irq+0x44/0xc4
> [  135.061180]  call_on_irq_stack+0x2c/0x5c
> [  135.065143]  do_interrupt_handler+0x80/0x84
> ...
> [  135.141122] ---[ end trace 0000000000000000 ]---
>
> >> With your changes to locktorture in {2-3}/3 you still run CFS
> >> lock_torture_writers but you should see the issue popping up
> >> in __set_cpus_allowed_ptr() (from torture_shuffle()) for example.
> >>
> >> Tried with:
> >>
> >> insmod /lib/modules/torture.ko
> >> insmod /lib/modules/locktorture.ko torture_type=mutex_lock rt_boost=1 rt_boost_factor=1 nlocks=3
> >>                                                                       ^^^^^^^^^^^^^^^^^
> >>
> >> When changing all lock_torture_writer's to FIFO it becomes even
> >> more visible.
> >
> > Ok, thank you, I will make it more aggressively set to RT. The
> > previous locktorture was setting RT once every minute or so, at least
> > now that is down to 10 seconds ;-). But as you highlight with the
> > locktorture diff below, it needs to go further.
>
> Yeah, the test env is more aggressive this way and you spot potential
> issues quicker.
>
> > Anyway, this is going to be a nice holiday/Christmas project for me,
> > so thank you in advance for the holiday gift  :-)  ^_^
>
> Enjoy ;-)
