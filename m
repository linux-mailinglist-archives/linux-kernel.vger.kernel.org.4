Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8067F6147C0
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 11:34:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbiKAKe0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 06:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbiKAKeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 06:34:22 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACC8CDF74
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 03:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=iPJVYSSrsREKVV6e45Jc8Aee33Xv4Zmq2z7M+AlUKm0=; b=RTOJ96LhsvSb1Uo7OUXKbzo9iO
        O46VvMwhBpVyrLI+H7CDgGVI6/9fsMZjYZaNlGIyw2MaCWC5rpT0PTJaZZcKRFmmJQ88cBz8CcQKC
        VqQci6zdQEROI9KpM08YjlNwpL4jJbZs0Numnnyg02vphRprLwNNM0HUyO7ij36L2SOwZbEWAaKCK
        XW4pGTdEpbGTrCFe/bsuE5+eKAMMy+9WQhjpUcL0pNQm9hMgAPEbhLOChsNQJ8RJKKn4lleXSqhUl
        AM14J/Pnt0AvdzcnH7aEZWNbOTi8I73kHOGHaw5bVN8wMCIym9FhelL0QG7TsS54WU6qZD/957e8k
        CAjmMqaQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1opoax-004Wil-3Z; Tue, 01 Nov 2022 10:34:11 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E83DF30020B;
        Tue,  1 Nov 2022 11:34:04 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8BE182BB7C856; Tue,  1 Nov 2022 11:34:04 +0100 (CET)
Date:   Tue, 1 Nov 2022 11:34:04 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Tianchen Ding <dtcccc@linux.alibaba.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched: Clear ttwu_pending after enqueue_task
Message-ID: <Y2D2HIZuGP81w25+@hirez.programming.kicks-ass.net>
References: <20221101073630.2797-1-dtcccc@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221101073630.2797-1-dtcccc@linux.alibaba.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 01, 2022 at 03:36:30PM +0800, Tianchen Ding wrote:
> We found a long tail latency in schbench whem m*t is close to nr_cpus.
> (e.g., "schbench -m 2 -t 16" on a machine with 32 cpus.)
> 
> This is because when the wakee cpu is idle, rq->ttwu_pending is cleared
> too early, and idle_cpu() will return true until the wakee task enqueued.
> This will mislead the waker when selecting idle cpu, and wake multiple
> worker threads on the same wakee cpu. This situation is enlarged by
> commit f3dd3f674555 ("sched: Remove the limitation of WF_ON_CPU on
> wakelist if wakee cpu is idle") because it tends to use wakelist.
> 
> Here is the result of "schbench -m 2 -t 16" on a VM with 32vcpu
> (Intel(R) Xeon(R) Platinum 8369B).
> 
> Latency percentiles (usec):
>                 base      base+revert_f3dd3f674555   base+this_patch
> 50.0000th:         9                            13                 9
> 75.0000th:        12                            19                12
> 90.0000th:        15                            22                15
> 95.0000th:        18                            24                17
> *99.0000th:       27                            31                24
> 99.5000th:      3364                            33                27
> 99.9000th:     12560                            36                30

Nice; but have you also ran other benchmarks and confirmed it doesn't
negatively affect those?

If so; mentioning that is very helpful. If not; best go do so :-)

> Signed-off-by: Tianchen Ding <dtcccc@linux.alibaba.com>
> ---
>  kernel/sched/core.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 87c9cdf37a26..b07de1753be5 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3739,13 +3739,6 @@ void sched_ttwu_pending(void *arg)
>  	if (!llist)
>  		return;
>  
> -	/*
> -	 * rq::ttwu_pending racy indication of out-standing wakeups.
> -	 * Races such that false-negatives are possible, since they
> -	 * are shorter lived that false-positives would be.
> -	 */
> -	WRITE_ONCE(rq->ttwu_pending, 0);
> -
>  	rq_lock_irqsave(rq, &rf);
>  	update_rq_clock(rq);
>  

Could you try the below instead? Also note the comment; since you did
the work to figure out why -- best record that for posterity.

@@ -3737,6 +3730,13 @@ void sched_ttwu_pending(void *arg)
 			set_task_cpu(p, cpu_of(rq));
 
 		ttwu_do_activate(rq, p, p->sched_remote_wakeup ? WF_MIGRATED : 0, &rf);
+		/*
+		 * Must be after enqueueing at least once task such that
+		 * idle_cpu() does not observe a false-negative -- if it does,
+		 * it is possible for select_idle_siblings() to stack a number
+		 * of tasks on this CPU during that window.
+		 */
+		WRITE_ONCE(rq->ttwu_pending, 0);
 	}
 
 	rq_unlock_irqrestore(rq, &rf);
