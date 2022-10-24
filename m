Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B08AD609EC8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 12:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbiJXKNp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 06:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbiJXKNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 06:13:43 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 87751C35
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 03:13:42 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2FAAAED1;
        Mon, 24 Oct 2022 03:13:48 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D5F263F7B4;
        Mon, 24 Oct 2022 03:13:37 -0700 (PDT)
Message-ID: <dab347c1-3724-8ac6-c051-9d2caea20101@arm.com>
Date:   Mon, 24 Oct 2022 12:13:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC PATCH 07/11] sched: Add proxy execution
Content-Language: en-US
To:     Connor O'Brien <connoro@google.com>, linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com, John Stultz <jstultz@google.com>,
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
References: <20221003214501.2050087-1-connoro@google.com>
 <20221003214501.2050087-8-connoro@google.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20221003214501.2050087-8-connoro@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/10/2022 23:44, Connor O'Brien wrote:
> From: Peter Zijlstra <peterz@infradead.org>

[...]

> + * Returns the task that is going to be used as execution context (the one
> + * that is actually going to be put to run on cpu_of(rq)).
> + */
> +static struct task_struct *
> +proxy(struct rq *rq, struct task_struct *next, struct rq_flags *rf)
> +{

[...]

> +migrate_task:

[...]

> +	/*
> +	 * Since we're going to drop @rq, we have to put(@next) first,
> +	 * otherwise we have a reference that no longer belongs to us.  Use
> +	 * @fake_task to fill the void and make the next pick_next_task()
           ^^^^^^^^^^

There was a `static struct task_struct fake_task` in
https://lkml.kernel.org/r/20181009092434.26221-6-juri.lelli@redhat.com
but now IMHO we use `rq->idle` <-- (1)

> +	 * invocation happy.
> +	 *
> +	 * XXX double, triple think about this.
> +	 * XXX put doesn't work with ON_RQ_MIGRATE
> +	 *
> +	 * CPU0				CPU1
> +	 *
> +	 *				B mutex_lock(X)
> +	 *
> +	 * A mutex_lock(X) <- B
> +	 * A __schedule()
> +	 * A pick->A
> +	 * A proxy->B
> +	 * A migrate A to CPU1
> +	 *				B mutex_unlock(X) -> A
> +	 *				B __schedule()
> +	 *				B pick->A
> +	 *				B switch_to (A)
> +	 *				A ... does stuff
> +	 * A ... is still running here
> +	 *
> +	 *		* BOOM *
> +	 */
> +	put_prev_task(rq, next);
> +	if (curr_in_chain) {
> +		rq->proxy = rq->idle;
> +		set_tsk_need_resched(rq->idle);
> +		/*
> +		 * XXX [juril] don't we still need to migrate @next to
> +		 * @owner's CPU?
> +		 */
> +		return rq->idle;
> +	}

--> (1)

> +	rq->proxy = rq->idle;
> +
> +	for (; p; p = p->blocked_proxy) {
> +		int wake_cpu = p->wake_cpu;
> +
> +		WARN_ON(p == rq->curr);
> +
> +		deactivate_task(rq, p, 0);
> +		set_task_cpu(p, that_cpu);
> +		/*
> +		 * We can abuse blocked_entry to migrate the thing, because @p is
> +		 * still on the rq.
> +		 */
> +		list_add(&p->blocked_entry, &migrate_list);
> +
> +		/*
> +		 * Preserve p->wake_cpu, such that we can tell where it
> +		 * used to run later.
> +		 */
> +		p->wake_cpu = wake_cpu;
> +	}
> +
> +	rq_unpin_lock(rq, rf);
> +	raw_spin_rq_unlock(rq);

Don't we run into rq_pin_lock()'s:

SCHED_WARN_ON(rq->balance_callback && rq->balance_callback !=
&balance_push_callback)

by releasing rq lock between queue_balance_callback(, push_rt/dl_tasks)
and __balance_callbacks()?

[...]
