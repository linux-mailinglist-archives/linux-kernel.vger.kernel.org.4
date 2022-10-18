Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E642602874
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 11:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbiJRJeq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 05:34:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbiJRJei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 05:34:38 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B55E415718
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 02:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mMRpxxlN8o/ODALW17jn0PVRFfe49AUcBRM48oEDvMs=; b=OL+JRMZzFGZAIlwBmVi36Qydpf
        +i9XR1cY9KUdJH2kApfGVqzMMQ6vC4qaDbmiGDd2/Rt5GoXJWAHAev+3Eqtor9Xplah5xr6w5qdE4
        5e94XA8b29ja4uBuOPyXOBibKKlLEwE6n+RmK9kJapiavXjiHV4YrVpTyFFxDsh/AmYfVurvhfHgg
        kseST+e496rek8O8BB+Ypfxnh3Ql34AKUVeHW7WHRBVlpo9b8Lw2SeOEa6zj74lBBzWHyK+51Gbcj
        G1wGSj3KrE81x/3V4yGl3oIj7+/uHRs9APxPFrCp7FN2LvxgRlVfHE6aR7HYXNfVRcxznO38SY/hL
        3RB7xrIg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1okizD-00AdER-4I; Tue, 18 Oct 2022 09:34:11 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 07668300431;
        Tue, 18 Oct 2022 11:34:04 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B37432C3855A4; Tue, 18 Oct 2022 11:34:04 +0200 (CEST)
Date:   Tue, 18 Oct 2022 11:34:04 +0200
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
Subject: Re: [PATCH 1/4] sched/fair: Simplify asym_packing logic for SMT
 sched groups
Message-ID: <Y05zDJ7ecDJphdFS@hirez.programming.kicks-ass.net>
References: <20220825225529.26465-1-ricardo.neri-calderon@linux.intel.com>
 <20220825225529.26465-2-ricardo.neri-calderon@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220825225529.26465-2-ricardo.neri-calderon@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2022 at 03:55:26PM -0700, Ricardo Neri wrote:
> When the destination CPU is an SMT sibling and idle, it can only help the
> busiest group if all of its other SMT siblings are also idle. Otherwise,
> there is not increase in throughput.
> 
> It does not matter whether the busiest group has SMT siblings. Simply
> check if there are any tasks running on the local group before proceeding.

> Reviewed-by: Len Brown <len.brown@intel.com>
> Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> ---
>  kernel/sched/fair.c | 29 +++++++++--------------------
>  1 file changed, 9 insertions(+), 20 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 77b2048a9326..91f271ea02d2 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -8603,12 +8603,10 @@ static bool asym_smt_can_pull_tasks(int dst_cpu, struct sd_lb_stats *sds,
>  				    struct sched_group *sg)
>  {
>  #ifdef CONFIG_SCHED_SMT
> -	bool local_is_smt, sg_is_smt;
> +	bool local_is_smt;
>  	int sg_busy_cpus;
>  
>  	local_is_smt = sds->local->flags & SD_SHARE_CPUCAPACITY;
> -	sg_is_smt = sg->flags & SD_SHARE_CPUCAPACITY;
> -
>  	sg_busy_cpus = sgs->group_weight - sgs->idle_cpus;
>  
>  	if (!local_is_smt) {
> @@ -8629,25 +8627,16 @@ static bool asym_smt_can_pull_tasks(int dst_cpu, struct sd_lb_stats *sds,
>  		return sched_asym_prefer(dst_cpu, sg->asym_prefer_cpu);
>  	}
>  
> -	/* @dst_cpu has SMT siblings. */
> -
> -	if (sg_is_smt) {
> -		int local_busy_cpus = sds->local->group_weight -
> -				      sds->local_stat.idle_cpus;
> -		int busy_cpus_delta = sg_busy_cpus - local_busy_cpus;
> -
> -		if (busy_cpus_delta == 1)
> -			return sched_asym_prefer(dst_cpu, sg->asym_prefer_cpu);
> -
> -		return false;
> -	}
> -
>  	/*
> -	 * @sg does not have SMT siblings. Ensure that @sds::local does not end
> -	 * up with more than one busy SMT sibling and only pull tasks if there
> -	 * are not busy CPUs (i.e., no CPU has running tasks).
> +	 * @dst_cpu has SMT siblings. When both @dst_cpu and the busiest core
> +	 * have one or more busy siblings, moving tasks between them results
> +	 * in the same throughput. Only if all the siblings of @dst_cpu are
> +	 * idle throughput can increase.
> +	 *
> +	 * If the difference in the number of busy CPUs is two or more, let
> +	 * find_busiest_group() take care of it.
>  	 */
> -	if (!sds->local_stat.sum_nr_running)
> +	if (sg_busy_cpus == 1 && !sds->local_stat.sum_nr_running)
>  		return sched_asym_prefer(dst_cpu, sg->asym_prefer_cpu);
>  

I can't follow this logic; doesn't this hard assume SMT2 at the very
least? The case for Power7 with SMT8 is that SMT1 is faster than SMT2 is
faster than SMT4, only once you have more than 4 threads active it no
longer matters.

