Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24F30696FD0
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 22:37:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231843AbjBNVhc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 16:37:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbjBNVh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 16:37:29 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88EAEF1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 13:37:28 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id d8-20020a17090ad98800b002344fa17c8bso76634pjv.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 13:37:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YUOXQtPV5HxbWl0ZT7D6CB3QexzdAfb6h1qvaGJEWF0=;
        b=j7XYmGhdPds1R+ssaR6j3Qq49I/DjYf4fE8j3UHN+cgJ4eVnWqMt5SlzK57jtD31Ut
         GHOTSWVZuwt5TJynXJunoftdRk5MUGhbbfMwFK8luxKS1knh33HQ4PLqsijN0o1NMzZH
         srpIo25RcAwbrhIFm5rSXIYbmQAw9v6jkfOjgYmGRb7I5AIqexpkp3mjKu8P2EAyR4QH
         7RahfB6XYGF88tz8hCg/6KgAE2ZzNeAdyeSbXh+8mTwETyGAzcLH2krnrp7LlTFefYOe
         8gn95K+RNIqrCRxUVeJBafcrBhhWZ8GVZ0ZHhAz5rPy1b3JHFw2e94SqO3L0JmzPQl8z
         ah1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YUOXQtPV5HxbWl0ZT7D6CB3QexzdAfb6h1qvaGJEWF0=;
        b=PgkKOc+9OnyVCaddiViMAAvemnMIOWU9ETc7MO0Az4J6zQxcqBgETVudsbCizPZwew
         eji9mDoUBjYLe+2ePmXF6h+HD+He18zPf/LYqYT/VxcIvcSXgxqcdjFtgBlvlVQurzfX
         93ABRoARf/EwpxD8XULQLzUycQPmEfuGh5dwrLMefvnS4FjFuqus6KgJBBItjWZ1ugxr
         NzDVsmnaojzXOMWUn8q5D55huVoiJuuRs6QcKKwpicnNnUbZkoUCwrqMyDsDuuy9H1Lw
         nYXQtnpBig5SoiiOWpPCipzN1xAqVXHIf7QyqWgax3hg7ZIX3tVz+JKArf88fdx+uSPu
         oxPw==
X-Gm-Message-State: AO0yUKWhNJgg6COmu3LptmAA8+XCO/2qgRjB1J8SURtk2qZxk4cbcmo0
        Sz1tkeg+dt+A/jwiiK5IRVffhZN+NGZ+OcGrFbbGvw==
X-Google-Smtp-Source: AK7set9zJBEdlMl8Pt+2itmba+ZDzoKx2wP6+76IHr2NH4zlAqMSVWMYAJG9JAzdSW34RHSSCVSjXg==
X-Received: by 2002:a17:902:e886:b0:198:af50:e4de with SMTP id w6-20020a170902e88600b00198af50e4demr356106plg.4.1676410647194;
        Tue, 14 Feb 2023 13:37:27 -0800 (PST)
Received: from bsegall-glaptop.localhost (c-67-188-112-16.hsd1.ca.comcast.net. [67.188.112.16])
        by smtp.gmail.com with ESMTPSA id cp9-20020a170902e78900b00198d7b52eefsm2934182plb.257.2023.02.14.13.37.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 13:37:25 -0800 (PST)
From:   Benjamin Segall <bsegall@google.com>
To:     Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
Cc:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, tglx@linutronix.de,
        srikar@linux.vnet.ibm.com, arjan@linux.intel.com,
        svaidy@linux.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] sched/fair: Interleave cfs bandwidth timers for
 improved single thread performance at low utilization
References: <20230214120502.934324-1-sshegde@linux.vnet.ibm.com>
Date:   Tue, 14 Feb 2023 13:37:24 -0800
In-Reply-To: <20230214120502.934324-1-sshegde@linux.vnet.ibm.com> (Shrikanth
        Hegde's message of "Tue, 14 Feb 2023 17:35:02 +0530")
Message-ID: <xm268rh06i97.fsf@google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shrikanth Hegde <sshegde@linux.vnet.ibm.com> writes:

> CPU cfs bandwidth controller uses hrtimer called period timer. Quota is
> refilled upon the timer expiry and re-started when there are running tasks
> within the cgroup. Each cgroup has a separate period timer which manages
> the period and quota for that cgroup.
>
> start_cfs_bandwidth calls hrtimer_forward_now which set the expiry value
> based on the below logic. expiry = $initial_value + $N * $period
>
> However, start_cfs_bandwidth doesn't set any initial value. Hence
> multiple such timers would align on expiry if their period value is
> same. This happens when there are multiple cgroups and each has runnable
> task. Upon expiry each timer will unthrottle respective rq's and all the
> rq would start at same time, competing for CPU time and use all
> the SMT threads likely.
>
> There is performance gain that can be achieved here if the timers are
> interleaved when the utilization of each CPU cgroup is low and total
> utilization of all the CPU cgroup's is less than 50%. This is likely
> true when using containers. If the timers are interleaved, then the
> unthrottled cgroup can run freely without many context switches and can
> also benefit from SMT Folding[1]. This effect will be further amplified in
> SPLPAR environment[2] as this would cause less hypervisor preemptions.
> There can be benefit due to less IPI storm as well. Docker provides a
> config option of period timer value, whereas the kubernetes only
> provides millicore option. Hence with typical deployment period values
> will be set to 100ms as kubernetes millicore will set the quota
> accordingly without altering period values.
>
> [1] SMT folding is a mechanism where processor core is reconfigured to
> lower SMT mode to improve performance when some sibling threads are
> idle. In a SMT8 core, when only one or two threads are running on a
> core, we get the best throughput compared to running all 8 threads.
>
> [2] SPLPAR is an Shared Processor Logical PARtition. There can be many
> SPLPARs running on the same physical machine sharing the CPU resources.
> One SPLPAR can consume all CPU resource it can, if the other SPLPARs are
> idle. Processors within the SPLPAR are called vCPU. vCPU can be higher
> than CPU.  Hence at an instance of time if there are more requested vCPU
> than CPU, then vCPU can be preempted. When the timers align, there will
> be spike in requested vCPU when the timers expire. This can lead to
> preemption when the other SPLPARs are not idle.
>
> Since we are trading off between the performance vs power here,
> benchmarked both the numbers. Frequency is set to 3.00Ghz and
> socket power has been measured. Ran the stress-ng with two
> cgroups. The numbers are with patch and without patch on a Power
> system with SMT=8. Below table shows time taken by each group to
> complete. Here each cgroup is assigned 25% runtime. period value is
> set to 100ms.
>
> workload: stress-ng --cpu=4 --cpu-ops=50000
> data shows time it took to complete in seconds for each run.
> Tried to interleave by best effort with the patch.
> 1CG - time to finish when only 1 cgroup is running.
> 2CG - time to finish when 2 cgroups are running together.
> power - power consumed in Watts for the socket running the workload.
> Performance gain is indicated in +ve percentage numbers and power
> increase is indicated in -ve numbers. 1CG numbers are same as expected.
> We are looking at improvement in 2CG Mainly.
>
>              6.2.rc5                           with patch
>         1CG    power   2CG    power   | 1CG  power     2CG        power
> 1Core   218     44     315      46    | 219    45    277(+12%)    47(-2%)
>         219     43     315      45    | 219    44    244(+22%)    48(-6%)
> 	                              |
> 2Core   108     48     158      52    | 109    50    114(+26%)    59(-13%)
>         109     49     157      52    | 109    49    136(+13%)    56(-7%)
>                                       |
> 4Core    60     59      89      65    |  62    58     72(+19%)    68(-5%)
>          61     61      90      65    |  62    60     68(+24%)    73(-12%)
>                                       |
> 8Core    33     77      48      83    |  33    77     37(+23%)    91(-10%)
>          33     77      48      84    |  33    77     38(+21%)    90(-7%)
>
> There is no benefit at higher utilization of 50% or more. There is no
> degradation also.
>
> This is RFC PATCH V2, where the code has been shifted from hrtimer to
> sched. This patch sets an initial value as multiple of period/10.
> Here timers can still align if the time started the cgroup is within the
> period/10 interval. On a real life workload, time gives sufficient
> randomness. There can be a better interleaving by being more
> deterministic. For example, when there are 2 cgroups, they should
> have initial value of 0/50ms or 10/60ms so on. When there are 3 cgroups,
> 0/3/6ms or 1/4/7ms etc. That is more complicated as it has to account
> for cgroup addition/deletion and accuracy w.r.t to period/quota.
> If that approach is better here, then will come up with that patch.

This does seem vaguely reasonable, though the power argument of
consolidating wakeups and such is something that we intentionally do in
other situations.

How reasonable do you think it is to just say (and what do the
equivalent numbers look like on your particular benchmark) "put some
variance on your period config if you want variance"?


>
> Signed-off-by: Shrikanth Hegde<sshegde@linux.vnet.ibm.com>
> ---
>  kernel/sched/fair.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index ff4dbbae3b10..7b69c329e05d 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5939,14 +5939,25 @@ static void init_cfs_rq_runtime(struct cfs_rq *cfs_rq)
>
>  void start_cfs_bandwidth(struct cfs_bandwidth *cfs_b)
>  {
> -	lockdep_assert_held(&cfs_b->lock);
> +	struct hrtimer *period_timer = &cfs_b->period_timer;
> +	s64 incr = ktime_to_ns(cfs_b->period) / 10;
> +	ktime_t delta;
> +	u64 orun = 1;
>
> +	lockdep_assert_held(&cfs_b->lock);
>  	if (cfs_b->period_active)
>  		return;
>
>  	cfs_b->period_active = 1;
> -	hrtimer_forward_now(&cfs_b->period_timer, cfs_b->period);
> -	hrtimer_start_expires(&cfs_b->period_timer, HRTIMER_MODE_ABS_PINNED);
> +	delta = ktime_sub(period_timer->base->get_time(),
> +			hrtimer_get_expires(period_timer));
> +	if (unlikely(delta >= cfs_b->period)) {

Probably could have a short comment here that's something like "forward
the hrtimer by period / 10 to reduce synchronized wakeups"

> +		orun = ktime_divns(delta, incr);
> +		hrtimer_add_expires_ns(period_timer, incr * orun);
> +	}
> +
> +	hrtimer_forward_now(period_timer, cfs_b->period);
> +	hrtimer_start_expires(period_timer, HRTIMER_MODE_ABS_PINNED);
>  }
>
>  static void destroy_cfs_bandwidth(struct cfs_bandwidth *cfs_b)
> --
> 2.31.1
