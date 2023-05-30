Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3044A715E20
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 13:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231650AbjE3L4v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 07:56:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231312AbjE3L4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 07:56:49 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F859E42
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 04:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yPLDzEYFr7Uv0xJ6+5vuSMqjQXaHZO1SYK+pWm+AqYY=; b=Uftqarp6cOtJ46fr19yoy1AxXc
        zvvb8sstUUikefEW6Bx0HaG3iWfChkR/VI2/VW7rCGocAlWD/VRW3+L/fhrA+pGXgjaZDoxRzUh2m
        oupscK53EVNiE6NpJQj2LY/1PvVbllmHASyApBfbXSXRyft7G5NEPA3cPkeu/3lodpiayBAKkBodN
        2G3XwdHdhz+UR88E9SKzYXAa2tzg81QorHUR+5UMv3Cm5scDBsq58Ih/+qzo+2ELIrNf2zixNSDJ9
        2+wqLq3mopg6XxTCjh/vOHQl14QvFLaCZ1XWEFT2zd85leS0IIZQqOvSWYd6eFGBBSyBxnSr6x2aa
        BLu+e7xQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q3xwp-00DiLN-0t;
        Tue, 30 May 2023 11:55:31 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 88232300194;
        Tue, 30 May 2023 13:55:27 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6C796207AE7AC; Tue, 30 May 2023 13:55:27 +0200 (CEST)
Date:   Tue, 30 May 2023 13:55:27 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Yicong Yang <yangyicong@huawei.com>
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        tim.c.chen@linux.intel.com, yu.c.chen@intel.com,
        gautham.shenoy@amd.com, mgorman@suse.de, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com,
        prime.zeng@huawei.com, yangyicong@hisilicon.com,
        jonathan.cameron@huawei.com, ego@linux.vnet.ibm.com,
        srikar@linux.vnet.ibm.com, linuxarm@huawei.com, 21cnbao@gmail.com,
        kprateek.nayak@amd.com, wuyun.abel@bytedance.com,
        Barry Song <song.bao.hua@hisilicon.com>
Subject: Re: [PATCH v8 2/2] sched/fair: Scan cluster before scanning LLC in
 wake-up path
Message-ID: <20230530115527.GC156198@hirez.programming.kicks-ass.net>
References: <20230530070253.33306-1-yangyicong@huawei.com>
 <20230530070253.33306-3-yangyicong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530070253.33306-3-yangyicong@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2023 at 03:02:53PM +0800, Yicong Yang wrote:

> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 373ff5f55884..b8c129ed8b47 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6994,6 +6994,30 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
>  		}
>  	}
>  
> +	if (static_branch_unlikely(&sched_cluster_active)) {
> +		struct sched_domain *sdc = rcu_dereference(per_cpu(sd_cluster, target));
> +
> +		if (sdc) {
> +			for_each_cpu_wrap(cpu, sched_domain_span(sdc), target + 1) {
> +				if (!cpumask_test_cpu(cpu, cpus))
> +					continue;
> +
> +				if (has_idle_core) {
> +					i = select_idle_core(p, cpu, cpus, &idle_cpu);
> +					if ((unsigned int)i < nr_cpumask_bits)
> +						return i;
> +				} else {
> +					if (--nr <= 0)
> +						return -1;
> +					idle_cpu = __select_idle_cpu(cpu, p);
> +					if ((unsigned int)idle_cpu < nr_cpumask_bits)
> +						return idle_cpu;
> +				}
> +			}
> +			cpumask_andnot(cpus, cpus, sched_domain_span(sdc));
> +		}
> +	}

Would not this:

--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6994,6 +6994,29 @@ static int select_idle_cpu(struct task_s
 		}
 	}
 
+	if (static_branch_unlikely(&sched_cluster_active)) {
+		struct sched_group *sg = sd->groups;
+		if (sg->flags & SD_CLUSTER) {
+			for_each_cpu_wrap(cpu, sched_group_span(sg), target+1) {
+				if (!cpumask_test_cpu(cpu, cpus))
+					continue;
+
+				if (has_idle_core) {
+					i = select_idle_core(p, cpu, cpus, &idle_cpu);
+					if ((unsigned)i < nr_cpumask_bits)
+						return 1;
+				} else {
+					if (--nr <= 0)
+						return -1;
+					idle_cpu = __select_idle_cpu(cpu, p);
+					if ((unsigned)idle_cpu < nr_cpumask_bits)
+						return idle_cpu;
+				}
+			}
+			cpumask_andnot(cpus, cpus, sched_group_span(sg));
+		}
+	}
+
 	for_each_cpu_wrap(cpu, cpus, target + 1) {
 		if (has_idle_core) {
 			i = select_idle_core(p, cpu, cpus, &idle_cpu);

also work? Then we can avoid the extra sd_cluster per-cpu variable.
