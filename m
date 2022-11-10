Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C98C2624132
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 12:16:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbiKJLQn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 06:16:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbiKJLQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 06:16:32 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4A4297018A
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 03:16:30 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 39EBF1FB;
        Thu, 10 Nov 2022 03:16:36 -0800 (PST)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 11AEE3F534;
        Thu, 10 Nov 2022 03:16:27 -0800 (PST)
Message-ID: <d2789d23-816b-11f1-d654-a7989f323ac8@arm.com>
Date:   Thu, 10 Nov 2022 12:16:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC PATCH 0/1] sched/pelt: Change PELT halflife at runtime
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>,
        Kajetan Puchalski <kajetan.puchalski@arm.com>
Cc:     Jian-Min Liu <jian-min.liu@mediatek.com>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Vincent Donnefort <vdonnefort@google.com>,
        Quentin Perret <qperret@google.com>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Abhijeet Dharmapurikar <adharmap@quicinc.com>,
        Qais Yousef <qais.yousef@arm.com>,
        linux-kernel@vger.kernel.org,
        Jonathan JMChen <jonathan.jmchen@mediatek.com>
References: <20220829055450.1703092-1-dietmar.eggemann@arm.com>
 <0f82011994be68502fd9833e499749866539c3df.camel@mediatek.com>
 <YzVpqweg21yIn30A@hirez.programming.kicks-ass.net>
 <YzV9Gejo/+DL3UjK@e126311.manchester.arm.com>
 <YzV/yT6OYMgaq0kD@hirez.programming.kicks-ass.net>
 <YzWuq5ShtJC6KWqe@e126311.manchester.arm.com>
 <Y2kLA8x40IiBEPYg@hirez.programming.kicks-ass.net>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <Y2kLA8x40IiBEPYg@hirez.programming.kicks-ass.net>
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

On 07/11/2022 14:41, Peter Zijlstra wrote:
> On Thu, Sep 29, 2022 at 03:41:47PM +0100, Kajetan Puchalski wrote:

[...]

> @@ -2956,13 +2958,26 @@ static inline unsigned long cpu_util_dl(struct rq *rq)
>   */
>  static inline unsigned long cpu_util_cfs(int cpu)
>  {
> +	struct rq *rq = cpu_rq(cpu);
>  	struct cfs_rq *cfs_rq;
>  	unsigned long util;
>  
> -	cfs_rq = &cpu_rq(cpu)->cfs;
> +	cfs_rq = &rq->cfs;
>  	util = READ_ONCE(cfs_rq->avg.util_avg);
>  
>  	if (sched_feat(UTIL_EST)) {
> +		if (sched_feat(UTIL_EST_FASTER)) {
> +			struct task_struct *curr;
> +
> +			rcu_read_lock();
> +			curr = rcu_dereference(rq->curr);
> +			if (likely(curr->sched_class == &fair_sched_class)) {
> +				u64 runtime = curr->se.sum_exec_runtime - curr->se.exec_start;

Don't we and up with gigantic runtime numbers here?

oot@juno:~# cat /proc/1676/task/1676/schedstat
36946300 1150620 11
root@juno:~# cat /proc/1676/task/1676/sched
rt-app (1676, #threads: 2)
-------------------------------------------------------------------
se.exec_start                                :         77766.964240 <- !
se.vruntime                                  :           563.587883
e.sum_exec_runtime                          :            36.946300  <- !
se.nr_migrations                             :                    0
...

I expect cpu_util_cfs() to be ~1024 almost all the time now.

> +				util = max_t(unsigned long, util,
> +					     faster_est_approx(runtime * 2));
> +			}
> +			rcu_read_unlock();
> +		}
>  		util = max_t(unsigned long, util,
>  			     READ_ONCE(cfs_rq->avg.util_est.enqueued));
>  	}

[...]

