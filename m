Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3137B6C2DFD
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 10:37:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbjCUJhK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 05:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjCUJhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 05:37:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F33982F06B
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 02:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=lj5nNlcpxxOE1Dk3bxxnekM+rohLURaXDIwq3XTg/ww=; b=hiCfpYLP0pdSwtaNnda4Zw0Ifn
        L58qIxQIunadEsE4roGTo4th3z15tSWbmbjnyxfnV+1EHCe73Z8PWAgFnn+qViHKHKq3Yl4qiGVDb
        IpdBl8JiBwLbn4xdJHwTXDqQWkAdXMSLrygY5Z/rkpucbJH/9TH+w7zeY9UTjVLtjD7AEscdiW+BV
        C0RlwyDg0mAsMPw5ctrsKWR3ZvJlkCs9voHNoUd0Rg4cPb7AYgeSZfsOuKkeaSaxIDdud0M9IgTNK
        qaqmkQZdRQRFvs/p7c2xsZ1p7niguxRZgqS7YdL/Ukm1LpYwwZtPU+SFmlhcYObWYk++X1UrWNwBV
        twwtUjXQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1peYQF-001ulV-BS; Tue, 21 Mar 2023 09:36:51 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 10F4B3002FC;
        Tue, 21 Mar 2023 10:36:49 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C7458240BF1A9; Tue, 21 Mar 2023 10:36:49 +0100 (CET)
Date:   Tue, 21 Mar 2023 10:36:49 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     wuchi <wuchi.zero@gmail.com>
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sched/core: Reduce cost of sched_move_task when
 config autogroup
Message-ID: <20230321093649.GD2234901@hirez.programming.kicks-ass.net>
References: <20230321064459.39421-1-wuchi.zero@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230321064459.39421-1-wuchi.zero@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2023 at 02:44:59PM +0800, wuchi wrote:

>  kernel/sched/core.c | 30 ++++++++++++++++++++++++++++--
>  1 file changed, 28 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index a380f34789a2..1e7d6a8c3455 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -10330,7 +10330,7 @@ void sched_release_group(struct task_group *tg)
>  	spin_unlock_irqrestore(&task_group_lock, flags);
>  }
>  
> -static void sched_change_group(struct task_struct *tsk)
> +static struct task_group *sched_get_task_group(struct task_struct *tsk)
>  {
>  	struct task_group *tg;
>  
> @@ -10342,7 +10342,28 @@ static void sched_change_group(struct task_struct *tsk)
>  	tg = container_of(task_css_check(tsk, cpu_cgrp_id, true),
>  			  struct task_group, css);
>  	tg = autogroup_task_group(tsk, tg);
> -	tsk->sched_task_group = tg;
> +
> +	return tg;
> +}
> +
> +static bool sched_task_group_changed(struct task_struct *tsk)
> +{
> +	/*
> +	 * Some sched_move_task calls are useless because that
> +	 * task_struct->sched_task_group maybe not changed (equals
> +	 * task_group of cpu_cgroup) when system enable autogroup.
> +	 * So do some checks in sched_move_task.
> +	 */
> +#ifdef CONFIG_SCHED_AUTOGROUP
> +	return sched_get_task_group(tsk) != tsk->sched_task_group;
> +#else
> +	return true;
> +#endif /* CONFIG_SCHED_AUTOGROUP */
> +}
> +
> +static void sched_change_group(struct task_struct *tsk)
> +{
> +	tsk->sched_task_group = sched_get_task_group(tsk);
>  
>  #ifdef CONFIG_FAIR_GROUP_SCHED
>  	if (tsk->sched_class->task_change_group)
> @@ -10367,6 +10388,10 @@ void sched_move_task(struct task_struct *tsk)
>  	struct rq *rq;
>  
>  	rq = task_rq_lock(tsk, &rf);
> +
> +	if (!sched_task_group_changed(tsk))
> +		goto unlock;
> +
>  	update_rq_clock(rq);
>  
>  	running = task_current(rq, tsk);
> @@ -10391,6 +10416,7 @@ void sched_move_task(struct task_struct *tsk)
>  		resched_curr(rq);
>  	}
>  
> +unlock:
>  	task_rq_unlock(rq, tsk, &rf);
>  }

Would you mind terribly if I change it like so?

---
Subject: sched/core: Reduce cost of sched_move_task when config autogroup
From: wuchi <wuchi.zero@gmail.com>
Date: Tue, 21 Mar 2023 14:44:59 +0800

From: wuchi <wuchi.zero@gmail.com>

Some sched_move_task calls are useless because that
task_struct->sched_task_group maybe not changed (equals task_group
of cpu_cgroup) when system enable autogroup. So do some checks in
sched_move_task.

sched_move_task eg:
task A belongs to cpu_cgroup0 and autogroup0, it will always belong
to cpu_cgroup0 when do_exit. So there is no need to do {de|en}queue.
The call graph is as follow.

  do_exit
    sched_autogroup_exit_task
      sched_move_task
	dequeue_task
	  sched_change_group
	    A.sched_task_group = sched_get_task_group (=cpu_cgroup0)
	enqueue_task

Performance results:
===========================
1. env
        cpu: bogomips=4600.00
     kernel: 6.3.0-rc3
 cpu_cgroup: 6:cpu,cpuacct:/user.slice

2. cmds
do_exit script:

  for i in {0..10000}; do
      sleep 0 &
      done
  wait

Run the above script, then use the following bpftrace cmd to get
the cost of sched_move_task:

  bpftrace -e 'k:sched_move_task { @ts[tid] = nsecs; }
	       kr:sched_move_task /@ts[tid]/
		  { @ns += nsecs - @ts[tid]; delete(@ts[tid]); }'

3. cost time(ns):
  without patch: 43528033
  with    patch: 18541416
           diff:-24986617  -57.4%

As the result show, the patch will save 57.4% in the scenario.

Signed-off-by: wuchi <wuchi.zero@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20230321064459.39421-1-wuchi.zero@gmail.com
---
 kernel/sched/core.c |   22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -10351,7 +10351,7 @@ void sched_release_group(struct task_gro
 	spin_unlock_irqrestore(&task_group_lock, flags);
 }
 
-static void sched_change_group(struct task_struct *tsk)
+static struct task_group *sched_get_task_group(struct task_struct *tsk)
 {
 	struct task_group *tg;
 
@@ -10363,7 +10363,13 @@ static void sched_change_group(struct ta
 	tg = container_of(task_css_check(tsk, cpu_cgrp_id, true),
 			  struct task_group, css);
 	tg = autogroup_task_group(tsk, tg);
-	tsk->sched_task_group = tg;
+
+	return tg;
+}
+
+static void sched_change_group(struct task_struct *tsk, struct task_group *group)
+{
+	tsk->sched_task_group = group;
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
 	if (tsk->sched_class->task_change_group)
@@ -10384,10 +10390,19 @@ void sched_move_task(struct task_struct
 {
 	int queued, running, queue_flags =
 		DEQUEUE_SAVE | DEQUEUE_MOVE | DEQUEUE_NOCLOCK;
+	struct task_group *group;
 	struct rq_flags rf;
 	struct rq *rq;
 
 	rq = task_rq_lock(tsk, &rf);
+	/*
+	 * Esp. with SCHED_AUTOGROUP enabled it is possible to get superfluous
+	 * group changes.
+	 */
+	group = sched_get_task_group(tsk);
+	if (group == tsk->sched_task_group)
+		goto unlock;
+
 	update_rq_clock(rq);
 
 	running = task_current(rq, tsk);
@@ -10398,7 +10413,7 @@ void sched_move_task(struct task_struct
 	if (running)
 		put_prev_task(rq, tsk);
 
-	sched_change_group(tsk);
+	sched_change_group(tsk, group);
 
 	if (queued)
 		enqueue_task(rq, tsk, queue_flags);
@@ -10412,6 +10427,7 @@ void sched_move_task(struct task_struct
 		resched_curr(rq);
 	}
 
+unlock:
 	task_rq_unlock(rq, tsk, &rf);
 }
 
