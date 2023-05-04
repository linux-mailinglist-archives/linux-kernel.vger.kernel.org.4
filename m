Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BE4F6F67A8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 10:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbjEDInb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 04:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbjEDIn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 04:43:29 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FBEB90;
        Thu,  4 May 2023 01:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=A7O/KcuuPv1NDPSd7/lkTSPyE9V7WRyc8ePThK7wq/A=; b=mxyKF1PrnMqIYWnEYkfWMTJPXp
        r8MXIoM6sdXuPMgydTjDpjke6rYEHM8LJxSeRTx+YyrRZnNez/rA1wfqBo/1nVcChGRqTCUQsaOKC
        c0JZS9Cl0L6VtL2ZWxLyqAd+UltHjaIdNo8HnDibOL7ga6KBqyhE7YTGvphdikQeqeE5ZnJGjzWUe
        2+ClryzP5Uhi4E7z4HP/UdPMfjPZAfIrDojqgiSJGHpmU9oKkIlJPttZ8C6kGVYyu82v++v8VDhVp
        DiovOrXuJQWZyAavjxj2M4UNcQcrolh1NWUuJ7CCbgHvjAQZMNRAV3J4KjktdhvFL1OUR2WQkMhM4
        hN4UGwLA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1puUXq-00APp4-6q; Thu, 04 May 2023 08:42:34 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DE43A302DAA;
        Thu,  4 May 2023 10:42:29 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9C4312111BE00; Thu,  4 May 2023 10:42:29 +0200 (CEST)
Date:   Thu, 4 May 2023 10:42:29 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Wander Lairson Costa <wander@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Brian Cain <bcain@quicinc.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Christian Brauner <brauner@kernel.org>,
        Andrei Vagin <avagin@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:PERFORMANCE EVENTS SUBSYSTEM" 
        <linux-perf-users@vger.kernel.org>, Hu Chunyu <chuhu@redhat.com>,
        Paul McKenney <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v7 2/3] sched/task: Add the put_task_struct_atomic_safe()
 function
Message-ID: <20230504084229.GI1734100@hirez.programming.kicks-ass.net>
References: <20230425114307.36889-1-wander@redhat.com>
 <20230425114307.36889-3-wander@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230425114307.36889-3-wander@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 25, 2023 at 08:43:02AM -0300, Wander Lairson Costa wrote:
> diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
> index b597b97b1f8f..cf774b83b2ec 100644
> --- a/include/linux/sched/task.h
> +++ b/include/linux/sched/task.h
> @@ -141,6 +141,41 @@ static inline void put_task_struct_many(struct task_struct *t, int nr)
>  
>  void put_task_struct_rcu_user(struct task_struct *task);
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
> +			 * call_rcu() will schedule __delayed_put_task_struct()
> +			 * to be called in process context.
> +			 *
> +			 * __put_task_struct() is called when
> +			 * refcount_dec_and_test(&t->usage) succeeds.
> +			 *
> +			 * This means that it can't conflict with
> +			 * put_task_struct_rcu_user() which abuses ->rcu the same
> +			 * way; rcu_users has a reference so task->usage can't be
> +			 * zero after rcu_users 1 -> 0 transition.
> +			 *
> +			 * delayed_free_task() also uses ->rcu, but it is only called
> +			 * when it fails to fork a process. Therefore, there is no
> +			 * way it can conflict with put_task_struct().
> +			 */
> +			call_rcu(&task->rcu, __delayed_put_task_struct);
> +	} else {
> +		put_task_struct(task);
> +	}
> +}

Urgh.. that's plenty horrible. And I'm sure everybody plus kitchen sink
has already asked why can't we just rcu free the thing unconditionally.

Google only found me an earlier version of this same patch set, but I'm
sure we've had that discussion many times over the past several years.
The above and your follow up patch is just horrible.

It requires users to know the RT specific context and gives them no help
what so ever for !RT builds.


