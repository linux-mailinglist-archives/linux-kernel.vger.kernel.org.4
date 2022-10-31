Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49BD3613B76
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 17:40:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231904AbiJaQkC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 12:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231894AbiJaQj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 12:39:59 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CFBE92BC3
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 09:39:58 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D8B501FB;
        Mon, 31 Oct 2022 09:40:04 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 258FE3F703;
        Mon, 31 Oct 2022 09:39:51 -0700 (PDT)
Message-ID: <4e396924-c3be-1932-91a3-5f458cc843fe@arm.com>
Date:   Mon, 31 Oct 2022 17:39:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC PATCH 07/11] sched: Add proxy execution
Content-Language: en-US
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Connor O'Brien <connoro@google.com>, linux-kernel@vger.kernel.org,
        kernel-team@android.com, John Stultz <jstultz@google.com>,
        Joel Fernandes <joelaf@google.com>,
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
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <34B2D8B9-A0C1-4280-944D-17224FB24339@joelfernandes.org>
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

On 29/10/2022 05:31, Joel Fernandes wrote:
> Hello Dietmar,
> 
>> On Oct 24, 2022, at 6:13 AM, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>>
>> ﻿On 03/10/2022 23:44, Connor O'Brien wrote:
>>> From: Peter Zijlstra <peterz@infradead.org>

[...]

>>> +    put_prev_task(rq, next);
>>> +    if (curr_in_chain) {
>>> +        rq->proxy = rq->idle;
>>> +        set_tsk_need_resched(rq->idle);
>>> +        /*
>>> +         * XXX [juril] don't we still need to migrate @next to
>>> +         * @owner's CPU?
>>> +         */
>>> +        return rq->idle;
>>> +    }
>>
>> --> (1)
> 
> Sorry but what has this got to do with your comment below?

This was the place where fake_task was used in:

https://lkml.kernel.org/r/20181009092434.26221-6-juri.lelli@redhat.com

+migrate_task:
   ...
+	 }
+	 rq->proxy = &fake_task;           <-- !!!
+
+	 for (; p; p = p->blocked_task) {

>>> +    rq->proxy = rq->idle;

We use `rq->idle` now,

[...]

>>> +    rq_unpin_lock(rq, rf);
>>> +    raw_spin_rq_unlock(rq);
>>
>> Don't we run into rq_pin_lock()'s:
>>
>> SCHED_WARN_ON(rq->balance_callback && rq->balance_callback !=
>> &balance_push_callback)
>>
>> by releasing rq lock between queue_balance_callback(, push_rt/dl_tasks)
>> and __balance_callbacks()?
> 
> Apologies, I’m a bit lost here. The code you are responding to inline does not call rq_pin_lock, it calls rq_unpin_lock.  So what scenario does the warning trigger according to you?

True, but the code which sneaks in between proxy()'s
raw_spin_rq_unlock(rq) and raw_spin_rq_lock(rq) does.


__schedule()

  rq->proxy = next = pick_next_task()

    __pick_next_task()

      pick_next_task_rt()

        set_next_task_rt()

          rt_queue_push_tasks()

            queue_balance_callback(..., push_rt_tasks); <-- queue rt cb

  proxy()

    raw_spin_rq_unlock(rq)

                 ... <-- other thread does rq_lock_XXX(rq)
                                              raw_spin_rq_lock_XXX(rq)
                                                rq_pin_lock(rq)

    raw_spin_rq_lock(rq)

  context_switch()

     finish_task_switch()

       finish_lock_switch()

         __balance_callbacks(rq) <-- run rt cb here

  __balance_callbacks(rq)() <-- or run rt cb here
