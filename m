Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99DA55BB22E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 20:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbiIPScq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 14:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbiIPScf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 14:32:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71D08A8968
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 11:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663353153;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F54pq1Oysxtlf47HLeXyrmlcrZpsuHEQEVGt0+zK5nE=;
        b=in9tPEtgDtl8g3G6Wzp+x8OcwooQeN0VLYOpcc3S7Z/AkciKUdex9qBop+GhDrLg6+mYr1
        QsE0/+8fh2SCWWKXtDyrsmtWcr5leAzAORLNm1Jrzy6DDEF39PgMFvu2kQ/ayT9xj2SrsN
        THkU4tbXZv/KqzzIpwgSiVE1iqjPwqE=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-227-xSrOv6HPNvqs42ETZ-ijTw-1; Fri, 16 Sep 2022 14:32:29 -0400
X-MC-Unique: xSrOv6HPNvqs42ETZ-ijTw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C4E843C0CD54;
        Fri, 16 Sep 2022 18:32:28 +0000 (UTC)
Received: from llong.com (unknown [10.22.17.61])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 21CCD140EBF3;
        Fri, 16 Sep 2022 18:32:28 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v9 3/7] sched: Enforce user requested affinity
Date:   Fri, 16 Sep 2022 14:32:13 -0400
Message-Id: <20220916183217.1172225-4-longman@redhat.com>
In-Reply-To: <20220916183217.1172225-1-longman@redhat.com>
References: <20220916183217.1172225-1-longman@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It was found that the user requested affinity via sched_setaffinity()
can be easily overwritten by other kernel subsystems without an easy way
to reset it back to what the user requested. For example, any change
to the current cpuset hierarchy may reset the cpumask of the tasks in
the affected cpusets to the default cpuset value even if those tasks
have pre-existing user requested affinity. That is especially easy to
trigger under a cgroup v2 environment where writing "+cpuset" to the
root cgroup's cgroup.subtree_control file will reset the cpus affinity
of all the processes in the system.

That is problematic in a nohz_full environment where the tasks running
in the nohz_full CPUs usually have their cpus affinity explicitly set
and will behave incorrectly if cpus affinity changes.

Fix this problem by looking at user_cpus_ptr in __set_cpus_allowed_ptr()
and use it to restrcit the given cpumask unless there is no overlap. In
that case, it will fallback to the given one. The SCA_USER flag is
reused to indicate intent to set user_cpus_ptr and so user_cpus_ptr
masking should be skipped. In addition, masking should also be skipped
if any of the SCA_MIGRATE_* flag is set.

All callers of set_cpus_allowed_ptr() will be affected by this change.
A scratch cpumask is added to percpu runqueues structure for doing
additional masking when user_cpus_ptr is set.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/sched/core.c  | 22 +++++++++++++++++-----
 kernel/sched/sched.h |  3 +++
 2 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index c7c0425974c2..ab8e591dbaf5 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2932,6 +2932,15 @@ static int __set_cpus_allowed_ptr(struct task_struct *p,
 	struct rq *rq;
 
 	rq = task_rq_lock(p, &rf);
+	/*
+	 * Masking should be skipped if SCA_USER or any of the SCA_MIGRATE_*
+	 * flags are set.
+	 */
+	if (p->user_cpus_ptr &&
+	    !(flags & (SCA_USER | SCA_MIGRATE_ENABLE | SCA_MIGRATE_DISABLE)) &&
+	    cpumask_and(rq->scratch_mask, new_mask, p->user_cpus_ptr))
+		new_mask = rq->scratch_mask;
+
 	return __set_cpus_allowed_ptr_locked(p, new_mask, flags, rq, &rf);
 }
 
@@ -3028,7 +3037,7 @@ void force_compatible_cpus_allowed_ptr(struct task_struct *p)
 }
 
 static int
-__sched_setaffinity(struct task_struct *p, const struct cpumask *mask);
+__sched_setaffinity(struct task_struct *p, const struct cpumask *mask, int flags);
 
 /*
  * Restore the affinity of a task @p which was previously restricted by a
@@ -3045,7 +3054,7 @@ void relax_compatible_cpus_allowed_ptr(struct task_struct *p)
 	 * Try to restore the old affinity mask with __sched_setaffinity().
 	 * Cpuset masking will be done there too.
 	 */
-	ret = __sched_setaffinity(p, task_user_cpus(p));
+	ret = __sched_setaffinity(p, task_user_cpus(p), 0);
 	WARN_ON_ONCE(ret);
 }
 
@@ -8049,7 +8058,7 @@ int dl_task_check_affinity(struct task_struct *p, const struct cpumask *mask)
 #endif
 
 static int
-__sched_setaffinity(struct task_struct *p, const struct cpumask *mask)
+__sched_setaffinity(struct task_struct *p, const struct cpumask *mask, int flags)
 {
 	int retval;
 	cpumask_var_t cpus_allowed, new_mask;
@@ -8069,7 +8078,7 @@ __sched_setaffinity(struct task_struct *p, const struct cpumask *mask)
 	if (retval)
 		goto out_free_new_mask;
 again:
-	retval = __set_cpus_allowed_ptr(p, new_mask, SCA_CHECK);
+	retval = __set_cpus_allowed_ptr(p, new_mask, SCA_CHECK | flags);
 	if (retval)
 		goto out_free_new_mask;
 
@@ -8134,7 +8143,7 @@ long sched_setaffinity(pid_t pid, const struct cpumask *in_mask)
 	}
 	cpumask_copy(user_mask, in_mask);
 
-	retval = __sched_setaffinity(p, in_mask);
+	retval = __sched_setaffinity(p, in_mask, SCA_USER);
 
 	/*
 	 * Save in_mask into user_cpus_ptr after a successful
@@ -9647,6 +9656,9 @@ void __init sched_init(void)
 			cpumask_size(), GFP_KERNEL, cpu_to_node(i));
 		per_cpu(select_rq_mask, i) = (cpumask_var_t)kzalloc_node(
 			cpumask_size(), GFP_KERNEL, cpu_to_node(i));
+		per_cpu(runqueues.scratch_mask, i) =
+			(cpumask_var_t)kzalloc_node(cpumask_size(),
+						    GFP_KERNEL, cpu_to_node(i));
 	}
 #endif /* CONFIG_CPUMASK_OFFSTACK */
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index ac235bc8ef08..482b702d65ea 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1159,6 +1159,9 @@ struct rq {
 	unsigned int		core_forceidle_occupation;
 	u64			core_forceidle_start;
 #endif
+
+	/* Scratch cpumask to be temporarily used under rq_lock */
+	cpumask_var_t		scratch_mask;
 };
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
-- 
2.31.1

