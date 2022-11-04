Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B001619E2B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 18:09:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231539AbiKDRJm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 13:09:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbiKDRJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 13:09:40 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EAEE3326C0
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 10:09:38 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6EDFC1FB;
        Fri,  4 Nov 2022 10:09:44 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 53AC33F703;
        Fri,  4 Nov 2022 10:09:35 -0700 (PDT)
Message-ID: <4ec6ab79-9f0f-e14b-dd06-d2840a1bf71a@arm.com>
Date:   Fri, 4 Nov 2022 18:09:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC PATCH 07/11] sched: Add proxy execution
Content-Language: en-US
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Connor O'Brien <connoro@google.com>, linux-kernel@vger.kernel.org,
        kernel-team@android.com, John Stultz <jstultz@google.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
References: <dab347c1-3724-8ac6-c051-9d2caea20101@arm.com>
 <34B2D8B9-A0C1-4280-944D-17224FB24339@joelfernandes.org>
 <4e396924-c3be-1932-91a3-5f458cc843fe@arm.com> <Y2ANPi7y5HhHvelr@google.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <Y2ANPi7y5HhHvelr@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/10/2022 19:00, Joel Fernandes wrote:
> On Mon, Oct 31, 2022 at 05:39:45PM +0100, Dietmar Eggemann wrote:
>> On 29/10/2022 05:31, Joel Fernandes wrote:
>>> Hello Dietmar,
>>>
>>>> On Oct 24, 2022, at 6:13 AM, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>>>>
>>>> ﻿On 03/10/2022 23:44, Connor O'Brien wrote:
>>>>> From: Peter Zijlstra <peterz@infradead.org>

[...]

>>>>> +    rq_unpin_lock(rq, rf);
>>>>> +    raw_spin_rq_unlock(rq);
>>>>
>>>> Don't we run into rq_pin_lock()'s:
>>>>
>>>> SCHED_WARN_ON(rq->balance_callback && rq->balance_callback !=
>>>> &balance_push_callback)
>>>>
>>>> by releasing rq lock between queue_balance_callback(, push_rt/dl_tasks)
>>>> and __balance_callbacks()?
>>>
>>> Apologies, I’m a bit lost here. The code you are responding to inline does not call rq_pin_lock, it calls rq_unpin_lock.  So what scenario does the warning trigger according to you?
>>
>> True, but the code which sneaks in between proxy()'s
>> raw_spin_rq_unlock(rq) and raw_spin_rq_lock(rq) does.
>>
> 
> Got it now, thanks a lot for clarifying. Can this be fixed by do a
> __balance_callbacks() at:

I tried the: 

   head = splice_balance_callbacks(rq)
   task_rq_unlock(rq, p, &rf);
   ...
   balance_callbacks(rq, head);

separation known from __sched_setscheduler() in __schedule() (right
after pick_next_task()) but it doesn't work. Lot of `BUG: scheduling
while atomic:`

[    0.384135] BUG: scheduling while atomic: swapper/0/1/0x00000002
[    0.384198] INFO: lockdep is turned off.
[    0.384241] Modules linked in:
[    0.384289] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G W 6.1.0-rc2-00023-g8a4c0a9d97ce-dirty #166
[    0.384375] Hardware name: ARM Juno development board (r0) (DT)
[    0.384426] Call trace:  
[    0.384454]  dump_backtrace.part.0+0xe4/0xf0
[    0.384501]  show_stack+0x18/0x40
[    0.384540]  dump_stack_lvl+0x8c/0xb8
[    0.384582]  dump_stack+0x18/0x34
[    0.384622]  __schedule_bug+0x88/0xa0
[    0.384666]  __schedule+0xae0/0xba4
[    0.384711]  schedule+0x5c/0xfc
[    0.384754]  schedule_timeout+0xcc/0x10c
[    0.384798]  __wait_for_common+0xe4/0x1f4
[    0.384847]  wait_for_completion+0x20/0x2c
[    0.384897]  kthread_park+0x58/0xd0
...

> 
>> __schedule()
>>
>>   rq->proxy = next = pick_next_task()
>>
>>     __pick_next_task()
>>
>>       pick_next_task_rt()
>>
>>         set_next_task_rt()
>>
>>           rt_queue_push_tasks()
>>
>>             queue_balance_callback(..., push_rt_tasks); <-- queue rt cb
>>
>>   proxy()
>>
> 
> ... here, before doing the following unlock?
> 
>>     raw_spin_rq_unlock(rq)
>>
>>                  ... <-- other thread does rq_lock_XXX(rq)
>>                                               raw_spin_rq_lock_XXX(rq)
>>                                                 rq_pin_lock(rq)
>>
>>     raw_spin_rq_lock(rq)
>>
>>   context_switch()
>>
>>      finish_task_switch()
>>
>>        finish_lock_switch()
>>
>>          __balance_callbacks(rq) <-- run rt cb here
>>
>>   __balance_callbacks(rq)() <-- or run rt cb here
> 
> 
> Hmm also Connor, does locktorture do hotplug? Maybe it should to reproduce
> the balance issues.

I can reproduce this reliably with making the locktorture writer realtime.

--%<--

diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
index bc3557677eed..23aabb4f34e5 100644
--- a/kernel/locking/locktorture.c
+++ b/kernel/locking/locktorture.c
@@ -676,7 +676,8 @@ static int lock_torture_writer(void *arg)
        DEFINE_TORTURE_RANDOM(rand);
 
        VERBOSE_TOROUT_STRING("lock_torture_writer task started");
-       set_user_nice(current, MAX_NICE);
+       if (!rt_task(current))
+               set_user_nice(current, MAX_NICE);
 
        do {
                if ((torture_random(&rand) & 0xfffff) == 0)
diff --git a/kernel/torture.c b/kernel/torture.c
index 1d0dd88369e3..55d8ac417a4a 100644
--- a/kernel/torture.c
+++ b/kernel/torture.c
@@ -57,6 +57,9 @@ module_param(verbose_sleep_duration, int, 0444);
 static int random_shuffle;
 module_param(random_shuffle, int, 0444);
 
+static int lock_torture_writer_fifo;
+module_param(lock_torture_writer_fifo, int, 0444);
+
 static char *torture_type;
 static int verbose;
 
@@ -734,7 +737,7 @@ bool stutter_wait(const char *title)
        cond_resched_tasks_rcu_qs();
        spt = READ_ONCE(stutter_pause_test);
        for (; spt; spt = READ_ONCE(stutter_pause_test)) {
-               if (!ret) {
+               if (!ret && !rt_task(current)) {
                        sched_set_normal(current, MAX_NICE);
                        ret = true;
                }
@@ -944,6 +947,11 @@ int _torture_create_kthread(int (*fn)(void *arg), void *arg, char *s, char *m,
                *tp = NULL;
                return ret;
        }
+
+       if (lock_torture_writer_fifo &&
+           !strncmp(s, "lock_torture_writer", strlen(s)))
+               sched_set_fifo(*tp);
+
        wake_up_process(*tp);  // Process is sleeping, so ordering provided.
        torture_shuffle_task_register(*tp);
        return ret;
