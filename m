Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0871360DD94
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 10:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233126AbiJZIzm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 04:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232208AbiJZIzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 04:55:39 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BCF55A8C7
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 01:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=cLkJYxIr1IyVWUTJ6UiahEJA+eYgKa/tpB2kz92PDOg=; b=ghVfqn4YFMQ62y4ShXWVm/Kmaq
        Ux01lD8W4HqUNGlQFPxLXCt8XOW7ayKAlSAljS55pLqBABYaMcftozY6TJl2qw4UVBHUaYqb2Gtz5
        fuiHj7k8lZ+NI+kAuGGTnlP9L0ixIiLn1pzbsrOw3wv9vm/PMEp4P+2Z8NLBo4T7Vk7BKJGFlXhUW
        peKfCP20QzbHMpvm65gZpwZ1fr8KxkcEG3DoHaXmK1rNnHQgT/HQFRBj+azZzvOUrTiYMCVeiW0AE
        JQQIaSzGpN6Ek09oW8T2I7u16gOxlR639eMLiB7VIgMyEcByySu6hymZ2JsEOzE/fp/OadaTdyYa8
        snOeG00g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oncBs-006Xox-FB; Wed, 26 Oct 2022 08:55:12 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7CA2330020C;
        Wed, 26 Oct 2022 10:55:11 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 598BA2C259E91; Wed, 26 Oct 2022 10:55:11 +0200 (CEST)
Date:   Wed, 26 Oct 2022 10:55:11 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc:     Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ricardo Neri <ricardo.neri@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Len Brown <len.brown@intel.com>, Mel Gorman <mgorman@suse.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Valentin Schneider <vschneid@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, "Tim C . Chen" <tim.c.chen@intel.com>
Subject: Re: [RFC PATCH 08/23] sched/fair: Compute task-class performance
 scores for load balancing
Message-ID: <Y1j170UQc5DJPYgR@hirez.programming.kicks-ass.net>
References: <20220909231205.14009-1-ricardo.neri-calderon@linux.intel.com>
 <20220909231205.14009-9-ricardo.neri-calderon@linux.intel.com>
 <YzK/QisKmix6hrKG@hirez.programming.kicks-ass.net>
 <20221026035724.GA21523@ranerica-svr.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221026035724.GA21523@ranerica-svr.sc.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2022 at 08:57:24PM -0700, Ricardo Neri wrote:

> Do you want me to add your Signed-off-by and Co-developed-by tags?

Nah; who cares ;-)


> > @@ -8749,32 +8747,18 @@ static void compute_ilb_sg_task_class_sc
> >  	if (!busy_cpus)
> >  		return;
> >  
> > -	score_on_dst_cpu = arch_get_task_class_score(class_sgs->p_min_score->class,
> > -						     dst_cpu);
> > +	score_on_dst_cpu = arch_get_task_class_score(sgcs->min_class, dst_cpu);
> >  
> > -	/*
> > -	 * The simpest case. The single busy CPU in the current group will
> > -	 * become idle after pulling its current task. The destination CPU is
> > -	 * idle.
> > -	 */
> > -	if (busy_cpus == 1) {
> > -		sgs->task_class_score_before = class_sgs->sum_score;
> > -		sgs->task_class_score_after = score_on_dst_cpu;
> > -		return;
> > -	}
> > +	before = sgcs->sum_score
> > +	after  = before - sgcs->min_score + score_on_dst_cpu;
> 
> This works when the sched group being evaluated has only one busy CPU
> because it will become idle if the destination CPU (which was idle) pulls
> the current task.
> 
> >  
> > -	/*
> > -	 * Now compute the group score with and without the task with the
> > -	 * lowest score. We assume that the tasks that remain in the group share
> > -	 * the CPU resources equally.
> > -	 */
> > -	group_score = class_sgs->sum_score / busy_cpus;
> > -
> > -	group_score_without =  (class_sgs->sum_score - class_sgs->min_score) /
> > -			       (busy_cpus - 1);
> > +	if (busy_cpus > 1) {
> > +		before /= busy_cpus;
> > +		after  /= busy_cpus;
> 
> 
> However, I don't think this works when the sched group has more than one
> busy CPU. 'before' and 'after' reflect the total throughput score of both
> the sched group *and* the destination CPU.
> 
> One of the CPUs in the sched group will become idle after the balance.
> 
> Also, at this point we have already added score_on_dst_cpu. We are incorrectly
> scaling it by the number of busy CPUs in the sched group.
> 
> We instead must scale 'after' by busy_cpus - 1 and then add score_on_dst_cpu.

So none of that makes sense.

'x/n + y' != '(x+y)/(n+1)'

IOW:

> > +	}
> >  
> > -	sgs->task_class_score_after = group_score_without + score_on_dst_cpu;
> > -	sgs->task_class_score_before = group_score;
> > +	sgs->task_class_score_before = before;
> > +	sgs->task_class_score_after  = after;

your task_class_score_after is a sum value for 2 cpus worth, not a value
for a single cpu, while your task_class_score_before is a single cpu
average. You can't compare these numbers and have a sensible outcome.

If you have a number of values: x_1....x_n, their average is
Sum(x_1...x_n) / n, which is a single value again.

If you want to update one of the x's, say x_i->x'_i, then the average
changes like:

	Sum(x_1...x_n-x_i+x'_i) / n

If you want to remove one of the x's, then you get:

	Sum(x_1...x_n-x_i) / (n-1) ; 0<i<n

if you want to add an x:

	Sum(x_1...x_n+i_i) / (n+1) ; i>n

Nowhere would you ever get:

	Sum(x_1...x_n) / n + x_i

That's just straight up nonsense.

So I might buy an argument for:

	if (busy_cpus > 1) {
		before /= (busy_cpus-1);
		after  /= (busy_cpus+1);
	}

Or something along those lines (where you remove an entry from before
and add it to after), but not this.

