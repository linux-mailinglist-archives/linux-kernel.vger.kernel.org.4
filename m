Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D9FA6DDC4C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 15:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbjDKNh5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 09:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbjDKNhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 09:37:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F43D3C25
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 06:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681220185;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uYcLtg+5b5UC5zlkP1+hLNis1rBXu0TWvq3MyhigVbA=;
        b=B30YUB+07Ko331WVvVCCrXwdD0sNsx5j6azWdUEsOqOT086PF7ckWsZroS914mEMmvAMzV
        /itPO9KuDbB8ATyAtm6mVIt1zw5r/hnay751AvhxZrWb3NAnWQhj0uGQ3ZxdtUZPiT4l+U
        Ro5tJq7kWJFlvKbqc3WUd/fxAf9xkZA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-622-AstwV-79MBeNhDWsoe8GHg-1; Tue, 11 Apr 2023 09:36:20 -0400
X-MC-Unique: AstwV-79MBeNhDWsoe8GHg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EFEBC855429;
        Tue, 11 Apr 2023 13:36:18 +0000 (UTC)
Received: from llong.com (unknown [10.22.33.155])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 83B7F47CD0;
        Tue, 11 Apr 2023 13:36:18 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Christian Brauner <brauner@kernel.org>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v4 2/5] cgroup/cpuset: Make cpuset_fork() handle CLONE_INTO_CGROUP properly
Date:   Tue, 11 Apr 2023 09:35:58 -0400
Message-Id: <20230411133601.2969636-3-longman@redhat.com>
In-Reply-To: <20230411133601.2969636-1-longman@redhat.com>
References: <20230411133601.2969636-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By default, the clone(2) syscall spawn a child process into the same
cgroup as its parent. With the use of the CLONE_INTO_CGROUP flag
introduced by commit ef2c41cf38a7 ("clone3: allow spawning processes
into cgroups"), the child will be spawned into a different cgroup which
is somewhat similar to writing the child's tid into "cgroup.threads".

The current cpuset_fork() method does not properly handle the
CLONE_INTO_CGROUP case where the cpuset of the child may be different
from that of its parent.  Update the cpuset_fork() method to treat the
CLONE_INTO_CGROUP case similar to cpuset_attach().

Since the newly cloned task has not been running yet, its actual
memory usage isn't known. So it is not necessary to make change to mm
in cpuset_fork().

Fixes: ef2c41cf38a7 ("clone3: allow spawning processes into cgroups")
Reported-by: Giuseppe Scrivano <gscrivan@redhat.com>
Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 62 ++++++++++++++++++++++++++++--------------
 1 file changed, 42 insertions(+), 20 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 066689a7dcc3..e954d5abb784 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -2520,16 +2520,33 @@ static void cpuset_cancel_attach(struct cgroup_taskset *tset)
 }
 
 /*
- * Protected by cpuset_rwsem.  cpus_attach is used only by cpuset_attach()
+ * Protected by cpuset_rwsem. cpus_attach is used only by cpuset_attach_task()
  * but we can't allocate it dynamically there.  Define it global and
  * allocate from cpuset_init().
  */
 static cpumask_var_t cpus_attach;
+static nodemask_t cpuset_attach_nodemask_to;
+
+static void cpuset_attach_task(struct cpuset *cs, struct task_struct *task)
+{
+	percpu_rwsem_assert_held(&cpuset_rwsem);
+
+	if (cs != &top_cpuset)
+		guarantee_online_cpus(task, cpus_attach);
+	else
+		cpumask_copy(cpus_attach, task_cpu_possible_mask(task));
+	/*
+	 * can_attach beforehand should guarantee that this doesn't
+	 * fail.  TODO: have a better way to handle failure here
+	 */
+	WARN_ON_ONCE(set_cpus_allowed_ptr(task, cpus_attach));
+
+	cpuset_change_task_nodemask(task, &cpuset_attach_nodemask_to);
+	cpuset_update_task_spread_flags(cs, task);
+}
 
 static void cpuset_attach(struct cgroup_taskset *tset)
 {
-	/* static buf protected by cpuset_rwsem */
-	static nodemask_t cpuset_attach_nodemask_to;
 	struct task_struct *task;
 	struct task_struct *leader;
 	struct cgroup_subsys_state *css;
@@ -2560,20 +2577,8 @@ static void cpuset_attach(struct cgroup_taskset *tset)
 
 	guarantee_online_mems(cs, &cpuset_attach_nodemask_to);
 
-	cgroup_taskset_for_each(task, css, tset) {
-		if (cs != &top_cpuset)
-			guarantee_online_cpus(task, cpus_attach);
-		else
-			cpumask_copy(cpus_attach, task_cpu_possible_mask(task));
-		/*
-		 * can_attach beforehand should guarantee that this doesn't
-		 * fail.  TODO: have a better way to handle failure here
-		 */
-		WARN_ON_ONCE(set_cpus_allowed_ptr(task, cpus_attach));
-
-		cpuset_change_task_nodemask(task, &cpuset_attach_nodemask_to);
-		cpuset_update_task_spread_flags(cs, task);
-	}
+	cgroup_taskset_for_each(task, css, tset)
+		cpuset_attach_task(cs, task);
 
 	/*
 	 * Change mm for all threadgroup leaders. This is expensive and may
@@ -3271,11 +3276,28 @@ static void cpuset_bind(struct cgroup_subsys_state *root_css)
  */
 static void cpuset_fork(struct task_struct *task)
 {
-	if (task_css_is_root(task, cpuset_cgrp_id))
+	struct cpuset *cs;
+	bool same_cs;
+
+	rcu_read_lock();
+	cs = task_cs(task);
+	same_cs = (cs == task_cs(current));
+	rcu_read_unlock();
+
+	if (same_cs) {
+		if (cs == &top_cpuset)
+			return;
+
+		set_cpus_allowed_ptr(task, current->cpus_ptr);
+		task->mems_allowed = current->mems_allowed;
 		return;
+	}
 
-	set_cpus_allowed_ptr(task, current->cpus_ptr);
-	task->mems_allowed = current->mems_allowed;
+	/* CLONE_INTO_CGROUP */
+	percpu_down_write(&cpuset_rwsem);
+	guarantee_online_mems(cs, &cpuset_attach_nodemask_to);
+	cpuset_attach_task(cs, task);
+	percpu_up_write(&cpuset_rwsem);
 }
 
 struct cgroup_subsys cpuset_cgrp_subsys = {
-- 
2.31.1

