Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EDA660C821
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 11:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbiJYJcf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 05:32:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiJYJcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 05:32:32 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D65CF9841
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 02:32:31 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 2AF2C220B5;
        Tue, 25 Oct 2022 09:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1666690350; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=e/F27udNls/La0w0VVha49pBSqumOwyKvES/X6dFtqI=;
        b=LydFanizb31PLCm4IfWPSWf2Ss+RV00mWBwc6OfCJdIIk8WZl/j13QRCedC7luLmTRqPvh
        WXnexUXTw7k57w+Qjb/ri/Bw9RoLq4/mXFbCnXtvODoF8InRoMhQZYhrNMUriv+icPSAe4
        ZfZscQ2vENUHMaMFORwt2soAynCj8XI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1666690350;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=e/F27udNls/La0w0VVha49pBSqumOwyKvES/X6dFtqI=;
        b=rdqQZv87z9e3G4y9XA2vJv1wb1FYuYWoAvzDWKxGNghahAaUDvDrdeEDH69ZflvRgqfucj
        4HvJkFtSSc0+bjCQ==
Received: from suse.de (unknown [10.163.43.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 002492C141;
        Tue, 25 Oct 2022 09:32:27 +0000 (UTC)
Date:   Tue, 25 Oct 2022 10:32:26 +0100
From:   Mel Gorman <mgorman@suse.de>
To:     Hao Jia <jiahao.os@bytedance.com>
Cc:     mingo@redhat.com, peterz@infradead.org, mingo@kernel.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        bristot@redhat.com, vschneid@redhat.com,
        mgorman@techsingularity.net, linux-kernel@vger.kernel.org
Subject: Re: [External] Re: [PATCH 1/2] sched/numa: Stop an exhastive search
 if an idle core is found
Message-ID: <20221025093226.dm4sjvdq2tofkwvc@suse.de>
References: <20221021061558.34767-1-jiahao.os@bytedance.com>
 <20221021061558.34767-2-jiahao.os@bytedance.com>
 <20221024133435.e2kajx5k7jzznp25@suse.de>
 <ced7c05a-121b-a77d-0c57-3e60abaecacd@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <ced7c05a-121b-a77d-0c57-3e60abaecacd@bytedance.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2022 at 11:16:29AM +0800, Hao Jia wrote:
> > Remove the change in the first hunk and call break in the second hunk
> > after updating ns->idle_cpu.
> > 
> 
> Yes, thanks for your review.
> If I understand correctly, some things might look like this.
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index e4a0b8bd941c..dfcb620bfe50 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -1792,7 +1792,7 @@ static void update_numa_stats(struct task_numa_env
> *env,
>                 ns->nr_running += rq->cfs.h_nr_running;
>                 ns->compute_capacity += capacity_of(cpu);
> 
> -               if (find_idle && !rq->nr_running && idle_cpu(cpu)) {
> +               if (find_idle && idle_core < 0 && !rq->nr_running &&
> idle_cpu(cpu)) {
>                         if (READ_ONCE(rq->numa_migrate_on) ||
>                             !cpumask_test_cpu(cpu, env->p->cpus_ptr))
>                                 continue;
> 

I meant more like the below but today I wondered why did I not do this in
the first place? The answer is because it's wrong and broken in concept.

The full loop is needed to calculate approximate NUMA stats at a
point in time. For example, the src and dst nr_running is needed by
task_numa_find_cpu. The search for an idle CPU or core in update_numa_stats
is simply taking advantage of the fact we are scanning anyway to keep
track of an idle CPU or core to avoid a second search as per ff7db0bf24db
("sched/numa: Prefer using an idle CPU as a migration target instead of
comparing tasks")

The patch I had in mind is below but that said, for both your version and
my initial suggestion

Naked-by: Mel Gorman <mgorman@suse.de>

For the record, this is what I was suggesting initially because it's more
efficient but it's wrong, don't do it.

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e4a0b8bd941c..7f1f6a1736a5 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1800,7 +1800,12 @@ static void update_numa_stats(struct task_numa_env *env,
 			if (ns->idle_cpu == -1)
 				ns->idle_cpu = cpu;
 
+			/* If we find an idle core, stop searching. */
 			idle_core = numa_idle_core(idle_core, cpu);
+			if (idle_core >= 0) {
+				ns->idle_cpu = idle_core;
+				break;
+			}
 		}
 	}
 	rcu_read_unlock();
@@ -1808,9 +1813,6 @@ static void update_numa_stats(struct task_numa_env *env,
 	ns->weight = cpumask_weight(cpumask_of_node(nid));
 
 	ns->node_type = numa_classify(env->imbalance_pct, ns);
-
-	if (idle_core >= 0)
-		ns->idle_cpu = idle_core;
 }
 
 static void task_numa_assign(struct task_numa_env *env,

