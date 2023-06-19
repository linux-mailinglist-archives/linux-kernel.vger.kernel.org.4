Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 532A67350BC
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 11:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231528AbjFSJpz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 05:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231675AbjFSJpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 05:45:47 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DF951A4
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 02:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+b4uGfghVmzJGGP+k7hS2UNiukzxIntjn/eIk9HyvTE=; b=smEdzvTvJsvo0/rAmU9aw2z45h
        u+vr3Jm24QY97umqCFnINjy5exU1cX5fkDzeQ42MLGVvR83g4kNMvMWwkQm6u5KYAk47m1vF7FMOu
        +XwBim3poImbBRdbvmB+Z9GHh/+fKsuVMwahdA4wZ0B0VKNr6uBaBKWJnLNsH5MFKJM9r08gV8LKm
        CBx8VCD8Uy5FYUUM9QtrMvvL6ssDT8orJh5DN572KcDwnGwFUXdngYkhs3A7Tke/RAr4O0p1JVFqX
        TDclR1aaeEaWYZDGvoSKRjgZP36thex0oHn7Xsc5mHusY+vMgagP9NaH8uHbH55s2KV8RPdveWIEi
        TgVvN5Ig==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qBBRy-00Bi1l-Um; Mon, 19 Jun 2023 09:45:31 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 521B43002F0;
        Mon, 19 Jun 2023 11:45:29 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 377C7245E8A68; Mon, 19 Jun 2023 11:45:29 +0200 (CEST)
Date:   Mon, 19 Jun 2023 11:45:29 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Swapnil Sapkal <swapnil.sapkal@amd.com>
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, iamjoonsoo.kim@lge.com,
        linux-kernel@vger.kernel.org, gautham.shenoy@amd.com,
        kprateek.nayak@amd.com, wyes.karny@amd.com
Subject: Re: [PATCH 2/2] sched/fair: Cleanup in migrate_degrades_locality()
 to improve readability
Message-ID: <20230619094529.GL4253@hirez.programming.kicks-ass.net>
References: <20230614102224.12555-1-swapnil.sapkal@amd.com>
 <20230614102224.12555-3-swapnil.sapkal@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230614102224.12555-3-swapnil.sapkal@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 14, 2023 at 10:22:24AM +0000, Swapnil Sapkal wrote:
> The migrate_degrades_locality() returns tristate value whether
> the migration will improve locality, degrades locality or no
> impact. Handle this return values with enum to improve the
> readability.

I can see how you ended up there, that tristate is weird, but perhaps
don't make it more complicated than it should be?

---
 kernel/sched/fair.c | 39 ++++++++++++++++++++-------------------
 1 file changed, 20 insertions(+), 19 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 373ff5f55884..a8449f594348 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8446,42 +8446,42 @@ static int task_hot(struct task_struct *p, struct lb_env *env)
 #ifdef CONFIG_NUMA_BALANCING
 /*
  * Returns 1, if task migration degrades locality
- * Returns 0, if task migration improves locality i.e migration preferred.
- * Returns -1, if task migration is not affected by locality.
+ * Returns 0, if task migration is not affected by locality.
+ * Returns -1, if task migration improves locality i.e migration preferred.
  */
-static int migrate_degrades_locality(struct task_struct *p, struct lb_env *env)
+static long migrate_degrades_locality(struct task_struct *p, struct lb_env *env)
 {
 	struct numa_group *numa_group = rcu_dereference(p->numa_group);
 	unsigned long src_weight, dst_weight;
 	int src_nid, dst_nid, dist;
 
 	if (!static_branch_likely(&sched_numa_balancing))
-		return -1;
+		return 0;
 
 	if (!p->numa_faults || !(env->sd->flags & SD_NUMA))
-		return -1;
+		return 0;
 
 	src_nid = cpu_to_node(env->src_cpu);
 	dst_nid = cpu_to_node(env->dst_cpu);
 
 	if (src_nid == dst_nid)
-		return -1;
+		return 0;
 
 	/* Migrating away from the preferred node is always bad. */
 	if (src_nid == p->numa_preferred_nid) {
 		if (env->src_rq->nr_running > env->src_rq->nr_preferred_running)
 			return 1;
 		else
-			return -1;
+			return 0;
 	}
 
 	/* Encourage migration to the preferred node. */
 	if (dst_nid == p->numa_preferred_nid)
-		return 0;
+		return -1;
 
 	/* Leaving a core idle is often worse than degrading locality. */
 	if (env->idle == CPU_IDLE)
-		return -1;
+		return 0;
 
 	dist = node_distance(src_nid, dst_nid);
 	if (numa_group) {
@@ -8492,14 +8492,14 @@ static int migrate_degrades_locality(struct task_struct *p, struct lb_env *env)
 		dst_weight = task_weight(p, dst_nid, dist);
 	}
 
-	return dst_weight < src_weight;
+	return src_weight - dst_weight;
 }
 
 #else
-static inline int migrate_degrades_locality(struct task_struct *p,
+static inline long migrate_degrades_locality(struct task_struct *p,
 					     struct lb_env *env)
 {
-	return -1;
+	return 0;
 }
 #endif
 
@@ -8509,7 +8509,7 @@ static inline int migrate_degrades_locality(struct task_struct *p,
 static
 int can_migrate_task(struct task_struct *p, struct lb_env *env)
 {
-	int tsk_cache_hot;
+	long degrades, hot;
 
 	lockdep_assert_rq_held(env->src_rq);
 
@@ -8578,13 +8578,14 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
 	if (env->flags & LBF_ACTIVE_LB)
 		return 1;
 
-	tsk_cache_hot = migrate_degrades_locality(p, env);
-	if (tsk_cache_hot == -1)
-		tsk_cache_hot = task_hot(p, env);
+	degrades = migrate_degrades_locality(p, env);
+	if (!degrades)
+		hot = task_hot(p, env);
+	else
+		hot = degrades > 0;
 
-	if (tsk_cache_hot <= 0 ||
-	    env->sd->nr_balance_failed > env->sd->cache_nice_tries) {
-		if (tsk_cache_hot == 1) {
+	if (env->sd->nr_balance_failed > env->sd->cache_nice_tries) {
+		if (hot) {
 			schedstat_inc(env->sd->lb_hot_gained[env->idle]);
 			schedstat_inc(p->stats.nr_forced_migrations);
 		}
