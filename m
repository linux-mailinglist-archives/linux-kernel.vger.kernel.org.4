Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59FF96DD388
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 08:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbjDKG62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 02:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbjDKG60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 02:58:26 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 181F710F0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 23:58:25 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-6323e36064aso709157b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 23:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1681196304;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ncPE3HgOzt6ii2dxf/TVQgxDoOPzo9kXvSGxZ1YSrno=;
        b=U9X1HyoD7KFf5kQSoltVmCTUwDifCKSDJ0Mq0NJRRY5a7vfRwuuqxOqiKAry3M/XOW
         zOFfNH7gfx1o120mDIzdrqkDD+wElOfP+3vKuPp2AEiHAMcgpxbi2Epvj8KiZSK0qfpP
         9otCPc1QlqpuWD6tyIqym2Jg+0lo99z1DJK6Q8nYpDJ+XFPgosQ7QCEjkZ6HwYUJsC+O
         Xx37gfiRuOJmqVjUYVESzD+eOkJu1JTR0/U7CGTzOodJk0NOSKPY3jHb345oz6p6fOxn
         ckQlGs173omtz27f+C2EodDi3+krjrO1E9XxZlbA5pOCZtCJMimr7NPIqcgOH7rghnh7
         uE+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681196304;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ncPE3HgOzt6ii2dxf/TVQgxDoOPzo9kXvSGxZ1YSrno=;
        b=5W/1CuZwQbmxPNoYZDwsnGVAszy+zRUFy+nFkyV7nNGCmW+U0p3oIGtvAHIydPrOWg
         hLXlB4UTjrlNN7eQ42/7sEOwIF4F9AnvfsK/fiTKdocSQjUqnUUQt/OGTINMFxefybSZ
         o9jPdjU4+TlXzI4YNKNUfdlXwx8KeCGsF2sDu2vs+/LEruAmvkRMS+rq0SV9ziepHnHF
         2do2IZ/V/IBYI5j1eTZhKUljgEQ2Y3WyHn36KpyhmmOdgPMX72fEc8fPf7Ao8ZeTj2wE
         ojNmcassHUz6jnkPJHJ1ASh7SicSAbWZn7udOY1wA6cCTNEVz7H8F4j4YXcxWM3f1++W
         GIfw==
X-Gm-Message-State: AAQBX9c1mLX768dA+tCZyJWP40or/2yla6M2QEisPY4/KUasYkjINaS/
        losClzne9f3OsT+4ZEiYrvIiqQ==
X-Google-Smtp-Source: AKy350at+azI+kWGdlkXmI4bpDXWT0RsYeV7z7NshkuWqXGxrTXNHokuIbpy+pF+zzCKIWWegENK8A==
X-Received: by 2002:a62:1a8d:0:b0:636:f899:46a0 with SMTP id a135-20020a621a8d000000b00636f89946a0mr6340939pfa.15.1681196304384;
        Mon, 10 Apr 2023 23:58:24 -0700 (PDT)
Received: from C02FT5A6MD6R.bytedance.net ([61.213.176.7])
        by smtp.gmail.com with ESMTPSA id 188-20020a6305c5000000b005186e562db0sm4247682pgf.82.2023.04.10.23.58.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 23:58:23 -0700 (PDT)
From:   Gang Li <ligang.bdlg@bytedance.com>
To:     Waiman Long <longman@redhat.com>, Michal Hocko <mhocko@suse.com>
Cc:     Gang Li <ligang.bdlg@bytedance.com>, cgroups@vger.kernel.org,
        linux-mm@kvack.org, rientjes@google.com,
        Zefan Li <lizefan.x@bytedance.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4] mm: oom: introduce cpuset oom
Date:   Tue, 11 Apr 2023 14:58:15 +0800
Message-Id: <20230411065816.9798-1-ligang.bdlg@bytedance.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cpusets constrain the CPU and Memory placement of tasks.
`CONSTRAINT_CPUSET` type in oom  has existed for a long time, but
has never been utilized.

When a process in cpuset which constrain memory placement triggers
oom, it may kill a completely irrelevant process on other numa nodes,
which will not release any memory for this cpuset.

We can easily achieve node aware oom by using `CONSTRAINT_CPUSET` and
selecting victim from cpusets with the same mems_allowed as the
current one.

Example:

Create two processes named mem_on_node0 and mem_on_node1 constrained
by cpusets respectively. These two processes alloc memory on their
own node. Now node0 has run out of memory, OOM will be invokled by
mem_on_node0.

Before this patch:

Since `CONSTRAINT_CPUSET` do nothing, the victim will be selected from
the entire system. Therefore, the OOM is highly likely to kill
mem_on_node1, which will not free any memory for mem_on_node0. This
is a useless kill.

```
[ 2786.519080] mem_on_node0 invoked oom-killer
[ 2786.885738] [  pid  ]   uid  tgid total_vm      rss pgtables_bytes swapents oom_score_adj name
[ 2787.181724] [  13432]     0 13432   787016   786745  6344704        0             0 mem_on_node1
[ 2787.189115] [  13457]     0 13457   787002   785504  6340608        0             0 mem_on_node0
[ 2787.216534] oom-kill:constraint=CONSTRAINT_CPUSET,nodemask=(null),cpuset=test,mems_allowed=0
[ 2787.229991] Out of memory: Killed process 13432 (mem_on_node1)
```

After this patch:

The victim will be selected only in all cpusets that have the same
mems_allowed as the cpuset that invoked oom. This will prevent
useless kill and protect innocent victims.

```
[  395.922444] mem_on_node0 invoked oom-killer
[  396.239777] [  pid  ]   uid  tgid total_vm      rss pgtables_bytes swapents oom_score_adj name
[  396.246128] [   2614]     0  2614  1311294  1144192  9224192        0             0 mem_on_node0
[  396.252655] oom-kill:constraint=CONSTRAINT_CPUSET,nodemask=(null),cpuset=test,mems_allowed=0
[  396.264068] Out of memory: Killed process 2614 (mem_on_node0)
```

Suggested-by: Michal Hocko <mhocko@suse.com>
Cc: <cgroups@vger.kernel.org>
Cc: <linux-mm@kvack.org>
Cc: <rientjes@google.com>
Cc: Waiman Long <longman@redhat.com>
Cc: Zefan Li <lizefan.x@bytedance.com>
Signed-off-by: Gang Li <ligang.bdlg@bytedance.com>
---
Changes in v4:
- Modify comments and documentation.

Changes in v3:
- https://lore.kernel.org/all/20230410025056.22103-1-ligang.bdlg@bytedance.com/
- Provide more details about the use case, testing, implementation.
- Document the userspace visible change in Documentation.
- Rename cpuset_cgroup_scan_tasks() to cpuset_scan_tasks() and add
  a doctext comment about its purpose and how it should be used.
- Take cpuset_rwsem to ensure that cpusets are stable.

Changes in v2:
- https://lore.kernel.org/all/20230404115509.14299-1-ligang.bdlg@bytedance.com/
- Select victim from all cpusets with the same mems_allowed as the current cpuset.

v1:
- https://lore.kernel.org/all/20220921064710.89663-1-ligang.bdlg@bytedance.com/
- Introduce cpuset oom.
---
 .../admin-guide/cgroup-v1/cpusets.rst         | 16 ++++++-
 Documentation/admin-guide/cgroup-v2.rst       |  4 ++
 include/linux/cpuset.h                        |  6 +++
 kernel/cgroup/cpuset.c                        | 43 +++++++++++++++++++
 mm/oom_kill.c                                 |  4 ++
 5 files changed, 71 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v1/cpusets.rst b/Documentation/admin-guide/cgroup-v1/cpusets.rst
index 5d844ed4df69..51ffdc0eb167 100644
--- a/Documentation/admin-guide/cgroup-v1/cpusets.rst
+++ b/Documentation/admin-guide/cgroup-v1/cpusets.rst
@@ -25,7 +25,8 @@ Written by Simon.Derr@bull.net
      1.6 What is memory spread ?
      1.7 What is sched_load_balance ?
      1.8 What is sched_relax_domain_level ?
-     1.9 How do I use cpusets ?
+     1.9 What is cpuset oom ?
+     1.10 How do I use cpusets ?
    2. Usage Examples and Syntax
      2.1 Basic Usage
      2.2 Adding/removing cpus
@@ -607,8 +608,19 @@ If your situation is:
  - The latency is required even it sacrifices cache hit rate etc.
    then increasing 'sched_relax_domain_level' would benefit you.
 
+1.9 What is cpuset oom ?
+--------------------------
+If there is no available memory to allocate on the nodes specified by
+cpuset.mems, then an OOM (Out-Of-Memory) will be invoked.
+
+Since the victim selection is a heuristic algorithm, we cannot select
+the "perfect" victim. Therefore, currently, the victim will be selected
+from all the cpusets that have the same mems_allowed as the cpuset
+which invoked OOM.
+
+Cpuset oom works in both cgroup v1 and v2.
 
-1.9 How do I use cpusets ?
+1.10 How do I use cpusets ?
 --------------------------
 
 In order to minimize the impact of cpusets on critical kernel
diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index f67c0829350b..594aa71cf441 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -2199,6 +2199,10 @@ Cpuset Interface Files
 	a need to change "cpuset.mems" with active tasks, it shouldn't
 	be done frequently.
 
+	When a process invokes oom due to the constraint of cpuset.mems,
+	the victim will be selected from cpusets with the same
+	mems_allowed as the current one.
+
   cpuset.mems.effective
 	A read-only multiple values file which exists on all
 	cpuset-enabled cgroups.
diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
index 980b76a1237e..75465bf58f74 100644
--- a/include/linux/cpuset.h
+++ b/include/linux/cpuset.h
@@ -171,6 +171,8 @@ static inline void set_mems_allowed(nodemask_t nodemask)
 	task_unlock(current);
 }
 
+int cpuset_scan_tasks(int (*fn)(struct task_struct *, void *), void *arg);
+
 #else /* !CONFIG_CPUSETS */
 
 static inline bool cpusets_enabled(void) { return false; }
@@ -287,6 +289,10 @@ static inline bool read_mems_allowed_retry(unsigned int seq)
 	return false;
 }
 
+static inline int cpuset_scan_tasks(int (*fn)(struct task_struct *, void *), void *arg)
+{
+	return 0;
+}
 #endif /* !CONFIG_CPUSETS */
 
 #endif /* _LINUX_CPUSET_H */
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index bc4dcfd7bee5..cb6b49245e18 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -4013,6 +4013,49 @@ void cpuset_print_current_mems_allowed(void)
 	rcu_read_unlock();
 }
 
+/**
+ * cpuset_scan_tasks - specify the oom scan range
+ * @fn: callback function to select oom victim
+ * @arg: argument for callback function, usually a pointer to struct oom_control
+ *
+ * Description: This function is used to specify the oom scan range. Return 0 if
+ * no task is selected, otherwise return 1. The selected task will be stored in
+ * arg->chosen. This function can only be called in cpuset oom context.
+ *
+ * The selection algorithm is heuristic, therefore requires constant iteration
+ * based on user feedback. Currently, we just iterate through all cpusets with
+ * the same mems_allowed as the current cpuset.
+ */
+int cpuset_scan_tasks(int (*fn)(struct task_struct *, void *), void *arg)
+{
+	int ret = 0;
+	struct css_task_iter it;
+	struct task_struct *task;
+	struct cpuset *cs;
+	struct cgroup_subsys_state *pos_css;
+
+	/*
+	 * Situation gets complex with overlapping nodemasks in different cpusets.
+	 * TODO: Maybe we should calculate the "distance" between different mems_allowed.
+	 *
+	 * But for now, let's make it simple. Just iterate through all cpusets
+	 * with the same mems_allowed as the current cpuset.
+	 */
+	cpuset_read_lock();
+	rcu_read_lock();
+	cpuset_for_each_descendant_pre(cs, pos_css, &top_cpuset) {
+		if (nodes_equal(cs->mems_allowed, task_cs(current)->mems_allowed)) {
+			css_task_iter_start(&(cs->css), CSS_TASK_ITER_PROCS, &it);
+			while (!ret && (task = css_task_iter_next(&it)))
+				ret = fn(task, arg);
+			css_task_iter_end(&it);
+		}
+	}
+	rcu_read_unlock();
+	cpuset_read_unlock();
+	return ret;
+}
+
 /*
  * Collection of memory_pressure is suppressed unless
  * this flag is enabled by writing "1" to the special
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 044e1eed720e..228257788d9e 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -367,6 +367,8 @@ static void select_bad_process(struct oom_control *oc)
 
 	if (is_memcg_oom(oc))
 		mem_cgroup_scan_tasks(oc->memcg, oom_evaluate_task, oc);
+	else if (oc->constraint == CONSTRAINT_CPUSET)
+		cpuset_scan_tasks(oom_evaluate_task, oc);
 	else {
 		struct task_struct *p;
 
@@ -427,6 +429,8 @@ static void dump_tasks(struct oom_control *oc)
 
 	if (is_memcg_oom(oc))
 		mem_cgroup_scan_tasks(oc->memcg, dump_task, oc);
+	else if (oc->constraint == CONSTRAINT_CPUSET)
+		cpuset_scan_tasks(dump_task, oc);
 	else {
 		struct task_struct *p;
 
-- 
2.20.1
