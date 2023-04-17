Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 814256E506D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 20:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbjDQSws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 14:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbjDQSwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 14:52:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EEF08F
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 11:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681757513;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L+Zz2A4a6oXCi75vniy0YiXcn3MLhYcxpdDk4A6UviE=;
        b=IIL/TP9pQ70KymLCorifRPaERuMmTULSv1QfGhYWH7bcB6NDHPUinr922L5nvDYBTez/2z
        V/gjCpf/7zbBABe750H7XcJu0l25wBgjR3Z2EjwPO8sDZIBLeAUOJAnJ/prdcUgqiH0LCN
        6usV+jmfMXqPZmWEbtQZCl+NMaeq9R0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-664-YWgog8K5O76cVU0Sa94r2w-1; Mon, 17 Apr 2023 14:51:50 -0400
X-MC-Unique: YWgog8K5O76cVU0Sa94r2w-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5E9BF101A531;
        Mon, 17 Apr 2023 18:51:48 +0000 (UTC)
Received: from [10.18.17.153] (dhcp-17-153.bos.redhat.com [10.18.17.153])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 848D9492B03;
        Mon, 17 Apr 2023 18:51:45 +0000 (UTC)
Message-ID: <e197ad4d-a60b-f773-dd74-ba91ad66a617@redhat.com>
Date:   Mon, 17 Apr 2023 14:51:45 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v6 2/3] sched/task: Add the put_task_struct_atomic_safe()
 function
Content-Language: en-US
To:     Wander Lairson Costa <wander@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Kees Cook <keescook@chromium.org>,
        Christian Brauner <brauner@kernel.org>,
        Andrei Vagin <avagin@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:PERFORMANCE EVENTS SUBSYSTEM" 
        <linux-perf-users@vger.kernel.org>
Cc:     Hu Chunyu <chuhu@redhat.com>, Paul McKenney <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20230414125532.14958-1-wander@redhat.com>
 <20230414125532.14958-3-wander@redhat.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20230414125532.14958-3-wander@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/14/23 08:55, Wander Lairson Costa wrote:
> Due to the possibility of indirectly acquiring sleeping locks, it is
> unsafe to call put_task_struct() in atomic contexts when the kernel is
> compiled with PREEMPT_RT.
>
> To mitigate this issue, this commit introduces
> put_task_struct_atomic_safe(), which schedules __put_task_struct()
> through call_rcu() when PREEMPT_RT is enabled. While a workqueue would
> be a more natural approach, we cannot allocate dynamic memory from
> atomic context in PREEMPT_RT, making the code more complex.
>
> This implementation ensures safe execution in atomic contexts and
> avoids any potential issues that may arise from using the non-atomic
> version.
>
> Signed-off-by: Wander Lairson Costa <wander@redhat.com>
> Reported-by: Hu Chunyu <chuhu@redhat.com>
> Cc: Paul McKenney <paulmck@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> ---
>   include/linux/sched/task.h | 31 +++++++++++++++++++++++++++++++
>   kernel/fork.c              |  8 ++++++++
>   2 files changed, 39 insertions(+)
>
> diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
> index b597b97b1f8f..5c13b83d7008 100644
> --- a/include/linux/sched/task.h
> +++ b/include/linux/sched/task.h
> @@ -141,6 +141,37 @@ static inline void put_task_struct_many(struct task_struct *t, int nr)
>   
>   void put_task_struct_rcu_user(struct task_struct *task);
>   
> +extern void __delayed_put_task_struct(struct rcu_head *rhp);
> +
> +static inline void put_task_struct_atomic_safe(struct task_struct *task)
> +{
> +	if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
> +		/*
> +		 * Decrement the refcount explicitly to avoid unnecessarily
> +		 * calling call_rcu.
> +		 */
> +		if (refcount_dec_and_test(&task->usage))
> +			/*
> +			 * under PREEMPT_RT, we can't call put_task_struct
> +			 * in atomic context because it will indirectly
> +			 * acquire sleeping locks.
> +			 * call_rcu() will schedule delayed_put_task_struct_rcu()
delayed_put_task_struct_rcu()?
> +			 * to be called in process context.
> +			 *
> +			 * __put_task_struct() is called called when
"called called"?
> +			 * refcount_dec_and_test(&t->usage) succeeds.
> +			 *
> +			 * This means that it can't "conflict" with
> +			 * put_task_struct_rcu_user() which abuses ->rcu the same
> +			 * way; rcu_users has a reference so task->usage can't be
> +			 * zero after rcu_users 1 -> 0 transition.

Note that put_task_struct_rcu_user() isn't the only user of task->rcu. 
delayed_free_task() in kernel/fork.c also uses it, though it is only 
called in the error case. Still you may need to take a look to make sure 
that there is no conflict.

Cheers,
Longman

