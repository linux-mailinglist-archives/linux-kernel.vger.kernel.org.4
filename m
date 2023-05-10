Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36B106FE138
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 17:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237511AbjEJPKQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 11:10:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237554AbjEJPKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 11:10:15 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83C9110E6
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 08:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HGqryz+5dw5/hkPA1z2QF1Cgznarv3iiUKZtAoiU3RI=; b=IiW0OkbSH9SJlpgcUU0EOaBJ9Z
        PiU6KhyisEp75+9rDNpO/9oCxZwLBR4zLJvPFZ1tmeP1Ulj+aKwjHYjGY4RKjHfig8R9kCK4FA2iq
        ibLLabvD5NRctQZsfx2q2bumfTD+Ibt82yXtPf5pHFCsk6mEAyN8nBSpLUGHuPNgV728c6jwPOIdv
        SsKydN8f42EIHuYNVp7JdEYRzIqmS/k3CzrWM4Ubjwh9lEY1idC3dQZr2htvF6bN/5U4spDvtJtFZ
        zTCgaY2EuqvuOcHruZD4WaPiT41bYf8/phzUhO3FlpgqvVH37M1C3DQK4iz7+SEGkrZyfyFcksU1W
        Q3dOJyxg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pwlRr-007U1N-2Y;
        Wed, 10 May 2023 15:09:47 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0B5343000D5;
        Wed, 10 May 2023 17:09:47 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E22AF202FCE9B; Wed, 10 May 2023 17:09:46 +0200 (CEST)
Date:   Wed, 10 May 2023 17:09:46 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     jiangshanlai@gmail.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com,
        Hillf Danton <hdanton@sina.com>
Subject: Re: [PATCH 4/6] workqueue: Automatically mark CPU-hogging work items
 CPU_INTENSIVE
Message-ID: <20230510150946.GO4253@hirez.programming.kicks-ass.net>
References: <20230510030752.542340-1-tj@kernel.org>
 <20230510030752.542340-5-tj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230510030752.542340-5-tj@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 09, 2023 at 05:07:50PM -1000, Tejun Heo wrote:

> @@ -976,24 +981,54 @@ void notrace wq_worker_stopping(struct task_struct *task, bool voluntary)
>  
>  	pool = worker->pool;
>  
> -	/* Return if preempted before wq_worker_running() was reached */
> -	if (worker->sleeping)
> -		return;
> +	if (!voluntary || task_is_running(task)) {
> +		/*
> +		 * Concurrency-managed @worker is still RUNNING. See if the
> +		 * current work is hogging CPU stalling other per-cpu work
> +		 * items. If so, mark @worker CPU_INTENSIVE to exclude it from
> +		 * concurrency management. @worker->current_* are stable as they
> +		 * can only be modified by @task which is %current.
> +		 */
> +		if (!worker->current_work ||
> +		    task->se.sum_exec_runtime - worker->current_at <
> +		    wq_cpu_intensive_thresh_us * NSEC_PER_USEC)
> +			return;
>  

> @@ -2348,6 +2382,7 @@ __acquires(&pool->lock)
>  	worker->current_work = work;
>  	worker->current_func = work->func;
>  	worker->current_pwq = pwq;
> +	worker->current_at = worker->task->se.sum_exec_runtime;

That only gets updated at scheduling events, it's not a 'running' clock.

>  	work_data = *work_data_bits(work);
>  	worker->current_color = get_work_color(work_data);
>  


Anyway, it occurs to me that if all you want is to measure long running
works, then would it not be much easier to simply forward the tick?

Something like the below.. Then this tick handler (which will have just
updated ->sum_exec_runtime BTW) can do that above 'work-be-long-running'
check.

Or am I missing something? Seems simpler than hijacking preempt-out.

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 944c3ae39861..3484cada9a4a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5632,6 +5632,9 @@ void scheduler_tick(void)
 
 	perf_event_task_tick();
 
+	if (curr->flags & PF_WQ_WORKER)
+		wq_worker_tick(curr);
+
 #ifdef CONFIG_SMP
 	rq->idle_balance = idle_cpu(cpu);
 	trigger_load_balance(rq);
