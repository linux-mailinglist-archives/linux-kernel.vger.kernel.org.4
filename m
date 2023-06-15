Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BED0D731919
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 14:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245559AbjFOMk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 08:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343647AbjFOMkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 08:40:23 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 884812117
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 05:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Qlk5je+Fg4knFDzYRruBCzeUCy1gC1SgH/o3oVamGRM=; b=KeNe3EzniQk/rDCU+SJX1JDilu
        0hoqYPbGeE4owLVEuZc+RtAktenrQI93yc3Sq/oV26IEkGV21zAyNLT0jgjxU4HPVldT+HH85bk4c
        GIgiZZmNh0TegRQWbUGlq1iJzQnJViQ/Dw0g+Ri5MMS/gDKA7/rORTtubRGq7SEOQXAbCaPJR6Yw8
        N7F2YHaH4RZfSlNWSBgCiAEmWbpt4HV3NTUjMCMXGbGVTAF0OZT4AH8p/65H+upG2VpmWAdzCU3XT
        nzZLWRdQKyZ9MI3L5ZsLXYkh+mPE/CAnbG+JOzLTMrMXQX6cv/OcNGFV2jaWSA2JgwQVJsnb61NzA
        xKb+1vOQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q9mGX-00BnPC-0V;
        Thu, 15 Jun 2023 12:39:53 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 895F3300188;
        Thu, 15 Jun 2023 14:39:50 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 63E352453890C; Thu, 15 Jun 2023 14:39:50 +0200 (CEST)
Date:   Thu, 15 Jun 2023 14:39:50 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Hao Jia <jiahao.os@bytedance.com>
Cc:     mingo@redhat.com, mingo@kernel.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        mgorman@techsingularity.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/4] sched/core: Avoid double calling
 update_rq_clock() in __balance_push_cpu_stop()
Message-ID: <20230615123950.GF1683497@hirez.programming.kicks-ass.net>
References: <20230613082012.49615-1-jiahao.os@bytedance.com>
 <20230613082012.49615-3-jiahao.os@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230613082012.49615-3-jiahao.os@bytedance.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 13, 2023 at 04:20:10PM +0800, Hao Jia wrote:
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index a8be5415daba..1eca36299d8b 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -2398,7 +2398,6 @@ static struct rq *__migrate_task(struct rq *rq, struct rq_flags *rf,
>  	if (!is_cpu_allowed(p, dest_cpu))
>  		return rq;
>  
> -	update_rq_clock(rq);
>  	rq = move_queued_task(rq, rf, p, dest_cpu);
>  
>  	return rq;
> @@ -2456,10 +2455,12 @@ static int migration_cpu_stop(void *data)
>  				goto out;
>  		}
>  
> -		if (task_on_rq_queued(p))
> +		if (task_on_rq_queued(p)) {
> +			update_rq_clock(rq);
>  			rq = __migrate_task(rq, &rf, p, arg->dest_cpu);
> -		else
> +		} else {
>  			p->wake_cpu = arg->dest_cpu;
> +		}
>  
>  		/*
>  		 * XXX __migrate_task() can fail, at which point we might end

So now you've got update_rq_clock() in both callers, why not remove it
from __balance_push_cpu_stop() ?

Afaict nothing actually needs it before __migrate_task().

---
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9435,8 +9435,6 @@ static int __balance_push_cpu_stop(void
 	raw_spin_lock_irq(&p->pi_lock);
 	rq_lock(rq, &rf);
 
-	update_rq_clock(rq);
-
 	if (task_rq(p) == rq && task_on_rq_queued(p)) {
 		cpu = select_fallback_rq(rq->cpu, p);
 		rq = __migrate_task(rq, &rf, p, cpu);
