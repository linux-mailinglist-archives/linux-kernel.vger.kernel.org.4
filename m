Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B69E9734F94
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 11:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbjFSJXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 05:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231338AbjFSJW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 05:22:56 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49DB0130
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 02:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bqDIKquGHw3g3calx5DzbvSgxcG22leCJf4wVVnOVH8=; b=t+V7DZqAOqTHfHmp0fIwahTswf
        StZOt8LD/eZPWdNp7S8RfPpOS0FPB/bHNXN9KceNBrf1YatHgWFhmy1tMuGF754IqeTjHwBL84ggn
        ZfFcgFK27PNq5fhQNfbuxW2kE/IkZRgDZMcckiWfI4FgSjifpf+a/RbX+yChZdUTO02l4titDSF4U
        3SFo+h/967Lk0tJuuilMHQC2cmEXD4AsW+bcOZHT5hVOCWSGcFKsWtH8L0ageW5r5EP1J3iBbGiw0
        /UtDrLyHhzpkvk89B4zUc6Zd/sLGSUw4medg8qK6I7xOqm3lVYiH7YOenpipcNF95FreLTRebCpoJ
        tzO3GHkw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qBB5i-00Bgeb-U3; Mon, 19 Jun 2023 09:22:31 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6535D3001E7;
        Mon, 19 Jun 2023 11:22:28 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4B929245ED567; Mon, 19 Jun 2023 11:22:28 +0200 (CEST)
Date:   Mon, 19 Jun 2023 11:22:28 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Swapnil Sapkal <swapnil.sapkal@amd.com>
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, iamjoonsoo.kim@lge.com,
        linux-kernel@vger.kernel.org, gautham.shenoy@amd.com,
        kprateek.nayak@amd.com, wyes.karny@amd.com
Subject: Re: [PATCH 1/2] sched/fair: Fix value reported by hot tasks pulled
 in /proc/schedstat
Message-ID: <20230619092228.GK4253@hirez.programming.kicks-ass.net>
References: <20230614102224.12555-1-swapnil.sapkal@amd.com>
 <20230614102224.12555-2-swapnil.sapkal@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230614102224.12555-2-swapnil.sapkal@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 14, 2023 at 10:22:23AM +0000, Swapnil Sapkal wrote:
> In /proc/schedstat, lb_hot_gained reports the number hot tasks pulled
> during load balance. This value is incremented in can_migrate_task()
> if the task is migratable and hot. After incrementing the value,
> load balancer can still decide not to migrate this task leading to wrong
> accounting. Fix this by incrementing stats when hot tasks are detached.
> This issue only exits in detach_tasks() where we can decide to not
> migrate hot task even if it is migratable. However, in detach_one_task(),
> we migrate it unconditionally.
> 
> Fixes: d31980846f96 ("sched: Move up affinity check to mitigate useless redoing overhead")
> Reported-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
> Signed-off-by: Swapnil Sapkal <swapnil.sapkal@amd.com>
> ---
>  kernel/sched/fair.c | 47 +++++++++++++++++++++++++++++----------------
>  1 file changed, 30 insertions(+), 17 deletions(-)

All this for just a number hardly anybody looks at :-(

Does this also work?

Please double check the order of the task_struct::sched_bitfield thing,
I've not had much wake-up juice.

---
 include/linux/sched.h |  1 +
 kernel/sched/fair.c   | 14 ++++++++++----
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 1292d38d66cc..eba0a78ac2a9 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -887,6 +887,7 @@ struct task_struct {
 	unsigned			sched_reset_on_fork:1;
 	unsigned			sched_contributes_to_load:1;
 	unsigned			sched_migrated:1;
+	unsigned			sched_task_hot:1;
 
 	/* Force alignment to the next boundary: */
 	unsigned			:0;
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 6189d1a45635..a88577132b20 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8569,6 +8569,8 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
 	int tsk_cache_hot;
 
 	lockdep_assert_rq_held(env->src_rq);
+	if (p->sched_task_hot)
+		p->sched_task_hot = 0;
 
 	/*
 	 * We do not migrate tasks that are:
@@ -8641,10 +8643,8 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
 
 	if (tsk_cache_hot <= 0 ||
 	    env->sd->nr_balance_failed > env->sd->cache_nice_tries) {
-		if (tsk_cache_hot == 1) {
-			schedstat_inc(env->sd->lb_hot_gained[env->idle]);
-			schedstat_inc(p->stats.nr_forced_migrations);
-		}
+		if (tsk_cache_hot == 1)
+			p->sched_task_hot = 1;
 		return 1;
 	}
 
@@ -8659,6 +8659,12 @@ static void detach_task(struct task_struct *p, struct lb_env *env)
 {
 	lockdep_assert_rq_held(env->src_rq);
 
+	if (p->sched_task_hot) {
+		p->sched_task_hot = 0;
+		schedstat_inc(env->sd->lb_hot_gained[env->idle]);
+		schedstat_inc(p->stats.nr_forced_migrations);
+	}
+
 	deactivate_task(env->src_rq, p, DEQUEUE_NOCLOCK);
 	set_task_cpu(p, env->dst_cpu);
 }
