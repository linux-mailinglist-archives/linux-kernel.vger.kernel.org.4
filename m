Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3941626C2A
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 23:21:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235050AbiKLWVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 17:21:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234695AbiKLWVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 17:21:05 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4118F5BA
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 14:20:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668291613;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oU8Uioe5AqDTtnEdw4klUnNv+nnvIMtyMCYaMWGnjIg=;
        b=T9kB3I1Ac4NN1SjCe7OCN46rxLAug84APZXi3tDF92Ju50ILuZyDrz2pusRVBlPQKLAHE9
        1ev/QTb0DAQe1CiH267IOp730cZl+Ala9rYE+RwSRESz3QzkJqJgPIhLL+P8UUG0yUb5Vm
        0HIa3n8TnOaAiK204nm4Zny/b2FRMQk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-646-LKRu5Ry_N2a_dV9ShLO1uQ-1; Sat, 12 Nov 2022 17:20:09 -0500
X-MC-Unique: LKRu5Ry_N2a_dV9ShLO1uQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5D31C8027EA;
        Sat, 12 Nov 2022 22:20:09 +0000 (UTC)
Received: from llong.com (unknown [10.22.8.110])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0D1ACC15BA4;
        Sat, 12 Nov 2022 22:20:09 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH 2/2] cgroup/cpuset: Optimize cpuset_attach() on v2
Date:   Sat, 12 Nov 2022 17:19:39 -0500
Message-Id: <20221112221939.1272764-3-longman@redhat.com>
In-Reply-To: <20221112221939.1272764-1-longman@redhat.com>
References: <20221112221939.1272764-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It was found that with the default hierarchy, enabling cpuset in the
child cgroups can trigger a cpuset_attach() call in each of the child
cgroups that have tasks with no change in effective cpus and mems. If
there are many processes in those child cgroups, it will burn quite a
lot of cpu cycles iterating all the tasks without doing useful work.

Optimizing this case by comparing between the old and new cpusets and
skip useless update if there is no change in effective cpus and mems.
Also mems_allowed are less likely to be changed than cpus_allowed. So
skip changing mm if there is no change in effective_mems and
CS_MEMORY_MIGRATE is not set.

By inserting some instrumentation code and running a simple command in
a container 200 times in a cgroup v2 system, it was found that all the
cpuset_attach() calls are skipped (401 times in total) as there was no
change in effective cpus and mems.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 2525905cdf48..b8361f55ef36 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -2513,12 +2513,28 @@ static void cpuset_attach(struct cgroup_taskset *tset)
 	struct cgroup_subsys_state *css;
 	struct cpuset *cs;
 	struct cpuset *oldcs = cpuset_attach_old_cs;
+	bool cpus_updated, mems_updated;
 
 	cgroup_taskset_first(tset, &css);
 	cs = css_cs(css);
 
 	lockdep_assert_cpus_held();	/* see cgroup_attach_lock() */
 	percpu_down_write(&cpuset_rwsem);
+	cpus_updated = !cpumask_equal(cs->effective_cpus,
+				      oldcs->effective_cpus);
+	mems_updated = !nodes_equal(cs->effective_mems, oldcs->effective_mems);
+
+	/*
+	 * In the default hierarchy, enabling cpuset in the child cgroups
+	 * will trigger a number of cpuset_attach() calls with no change
+	 * in effective cpus and mems. In that case, we can optimize out
+	 * by skipping the task iteration and update.
+	 */
+	if (cgroup_subsys_on_dfl(cpuset_cgrp_subsys) &&
+	    !cpus_updated && !mems_updated) {
+		cpuset_attach_nodemask_to = cs->effective_mems;
+		goto out;
+	}
 
 	guarantee_online_mems(cs, &cpuset_attach_nodemask_to);
 
@@ -2539,9 +2555,14 @@ static void cpuset_attach(struct cgroup_taskset *tset)
 
 	/*
 	 * Change mm for all threadgroup leaders. This is expensive and may
-	 * sleep and should be moved outside migration path proper.
+	 * sleep and should be moved outside migration path proper. Skip it
+	 * if there is no change in effective_mems and CS_MEMORY_MIGRATE is
+	 * not set.
 	 */
 	cpuset_attach_nodemask_to = cs->effective_mems;
+	if (!is_memory_migrate(cs) && !mems_updated)
+		goto out;
+
 	cgroup_taskset_for_each_leader(leader, css, tset) {
 		struct mm_struct *mm = get_task_mm(leader);
 
@@ -2564,6 +2585,7 @@ static void cpuset_attach(struct cgroup_taskset *tset)
 		}
 	}
 
+out:
 	cs->old_mems_allowed = cpuset_attach_nodemask_to;
 
 	cs->attach_in_progress--;
-- 
2.31.1

