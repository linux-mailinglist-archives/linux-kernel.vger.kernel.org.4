Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A757074E355
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 03:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbjGKBS0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 21:18:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231811AbjGKBQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 21:16:50 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C69361992;
        Mon, 10 Jul 2023 18:16:01 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-66f3fc56ef4so3990908b3a.0;
        Mon, 10 Jul 2023 18:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689038123; x=1691630123;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UYS30FzDpm+Xg0fpSQMoCRPqUT4+RoLXR0VNA6/hzws=;
        b=kkhGa2Yky+0neoGWsmYrnKhB7ZO1tbhEtVlKuX5Tb1RHqk4KYsl7Stj185myfmpp8e
         5/AEfvvgoXdIlvsjijbSV476JE2QSwuMfIyHw/tyn5FrNKou8e9P/CKGzrDfj+QP8I4c
         vt+bsQA9WLPHJk2raw0XHx2HzP78KGRUNvx03PQRLEA2BTlY2kBm5nX4bqsOeGy88Q0l
         /bdUVeBN1JZc2RAIgXXV+iaJPWiwj90rQ4iUbKTmfGc1h4RBfK5MYGaVwGHymsvbOqbJ
         i9KKtHTe9HaYfg8gviUGn0sERYzwGKg0DNj34RcQn+jhGlUwG0UqoiQYm4SD5Z+SGrK7
         0cGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689038123; x=1691630123;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UYS30FzDpm+Xg0fpSQMoCRPqUT4+RoLXR0VNA6/hzws=;
        b=Vzu5BBLKDgf9R1yvcUeTyyNYNyPL/m4+IM7evmE3uRbm+Iftp2BUAsU+9T6KFhU7MH
         Wt8qPdqZojRRTe5p/6quDuupCaCCDhLXvGTVWcPv/Jyy3uaAdkMWKonh7p7U2iNYlEi6
         p6L/D1IvPIDUL+T007BHtMRpn6CZJaWoumtGocRoCHObIqEUUuZiYrcpIsOMmkS+M/Xc
         XIPy8OpotiUNrJlDFv8ujQs0zatXKCwZ9/NozFVdrHIdH5dYuEV8foymnRXW4IjSBdh1
         gIFkrkNv+lP+CUwIQu93rGTzttBlau+Jl9kSkr08Zmpf1j6yJim93Q0xN+Tgvv3kccwy
         1qKw==
X-Gm-Message-State: ABy/qLabQJMsTDZGJJLe/5w7eOY6IGYq+K6PfgOjhwo96SakSzeF5SLu
        un1ajhMRwfhhZbIzSmQhQGh+ZmERnj3SUw==
X-Google-Smtp-Source: APBJJlHoSH+hyqXlidJGLzAl7AXoVvt6pOF/4uwnc6w2bRB5ZGtu22UZiJKiorbZP6eYLqYtrf26RA==
X-Received: by 2002:a05:6a20:3ca1:b0:125:aeeb:f8de with SMTP id b33-20020a056a203ca100b00125aeebf8demr24220721pzj.15.1689038122481;
        Mon, 10 Jul 2023 18:15:22 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:e2fe])
        by smtp.gmail.com with ESMTPSA id t9-20020a63b709000000b0055be951145csm269550pgf.36.2023.07.10.18.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 18:15:22 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From:   Tejun Heo <tj@kernel.org>
To:     torvalds@linux-foundation.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
        joshdon@google.com, brho@google.com, pjt@google.com,
        derkling@google.com, haoluo@google.com, dvernet@meta.com,
        dschatzberg@meta.com, dskarlat@cs.cmu.edu, riel@surriel.com
Cc:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        kernel-team@meta.com, Tejun Heo <tj@kernel.org>
Subject: [PATCH 33/34] sched_ext: Add a basic, userland vruntime scheduler
Date:   Mon, 10 Jul 2023 15:13:51 -1000
Message-ID: <20230711011412.100319-34-tj@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230711011412.100319-1-tj@kernel.org>
References: <20230711011412.100319-1-tj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Vernet <dvernet@meta.com>

This patch adds a new scx_userland BPF scheduler that implements a
fairly unsophisticated sorted-list vruntime scheduler in userland to
demonstrate how most scheduling decisions can be delegated to userland. The
scheduler doesn't implement load balancing, and treats all tasks as part of
a single domain.

v2: * Converted to BPF inline iterators.

Signed-off-by: David Vernet <dvernet@meta.com>
Reviewed-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 tools/sched_ext/.gitignore         |   1 +
 tools/sched_ext/Makefile           |   8 +-
 tools/sched_ext/scx_userland.bpf.c | 262 +++++++++++++++++++
 tools/sched_ext/scx_userland.c     | 402 +++++++++++++++++++++++++++++
 tools/sched_ext/scx_userland.h     |  19 ++
 5 files changed, 690 insertions(+), 2 deletions(-)
 create mode 100644 tools/sched_ext/scx_userland.bpf.c
 create mode 100644 tools/sched_ext/scx_userland.c
 create mode 100644 tools/sched_ext/scx_userland.h

diff --git a/tools/sched_ext/.gitignore b/tools/sched_ext/.gitignore
index d5a4923919ce..c63ee5e4f4bb 100644
--- a/tools/sched_ext/.gitignore
+++ b/tools/sched_ext/.gitignore
@@ -3,6 +3,7 @@ scx_qmap
 scx_central
 scx_pair
 scx_flatcg
+scx_userland
 *.skel.h
 *.subskel.h
 /tools/
diff --git a/tools/sched_ext/Makefile b/tools/sched_ext/Makefile
index a0dacea5993c..092c3859228f 100644
--- a/tools/sched_ext/Makefile
+++ b/tools/sched_ext/Makefile
@@ -115,7 +115,7 @@ BPF_CFLAGS = -g -D__TARGET_ARCH_$(SRCARCH)					\
 	     -Wall -Wno-compare-distinct-pointer-types				\
 	     -O2 -mcpu=v3
 
-all: scx_simple scx_qmap scx_central scx_pair scx_flatcg
+all: scx_simple scx_qmap scx_central scx_pair scx_flatcg scx_userland
 
 # sort removes libbpf duplicates when not cross-building
 MAKE_DIRS := $(sort $(BUILD_DIR)/libbpf $(HOST_BUILD_DIR)/libbpf		\
@@ -186,10 +186,14 @@ scx_flatcg: scx_flatcg.c scx_flatcg.skel.h user_exit_info.h
 	$(CC) $(CFLAGS) -c $< -o $@.o
 	$(CC) -o $@ $@.o $(HOST_BPFOBJ) $(LDFLAGS)
 
+scx_userland: scx_userland.c scx_userland.skel.h scx_userland.h user_exit_info.h
+	$(CC) $(CFLAGS) -c $< -o $@.o
+	$(CC) -o $@ $@.o $(HOST_BPFOBJ) $(LDFLAGS)
+
 clean:
 	rm -rf $(SCRATCH_DIR) $(HOST_SCRATCH_DIR)
 	rm -f *.o *.bpf.o *.skel.h *.subskel.h
-	rm -f scx_simple scx_qmap scx_central scx_pair scx_flatcg
+	rm -f scx_simple scx_qmap scx_central scx_pair scx_flatcg scx_userland
 
 .PHONY: all clean
 
diff --git a/tools/sched_ext/scx_userland.bpf.c b/tools/sched_ext/scx_userland.bpf.c
new file mode 100644
index 000000000000..9e107a874a92
--- /dev/null
+++ b/tools/sched_ext/scx_userland.bpf.c
@@ -0,0 +1,262 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * A minimal userland scheduler.
+ *
+ * In terms of scheduling, this provides two different types of behaviors:
+ * 1. A global FIFO scheduling order for _any_ tasks that have CPU affinity.
+ *    All such tasks are direct-dispatched from the kernel, and are never
+ *    enqueued in user space.
+ * 2. A primitive vruntime scheduler that is implemented in user space, for all
+ *    other tasks.
+ *
+ * Some parts of this example user space scheduler could be implemented more
+ * efficiently using more complex and sophisticated data structures. For
+ * example, rather than using BPF_MAP_TYPE_QUEUE's,
+ * BPF_MAP_TYPE_{USER_}RINGBUF's could be used for exchanging messages between
+ * user space and kernel space. Similarly, we use a simple vruntime-sorted list
+ * in user space, but an rbtree could be used instead.
+ *
+ * Copyright (c) 2022 Meta Platforms, Inc. and affiliates.
+ * Copyright (c) 2022 Tejun Heo <tj@kernel.org>
+ * Copyright (c) 2022 David Vernet <dvernet@meta.com>
+ */
+#include <string.h>
+#include "scx_common.bpf.h"
+#include "scx_userland.h"
+
+char _license[] SEC("license") = "GPL";
+
+const volatile bool switch_partial;
+const volatile s32 usersched_pid;
+
+/* !0 for veristat, set during init */
+const volatile u32 num_possible_cpus = 64;
+
+/* Stats that are printed by user space. */
+u64 nr_failed_enqueues, nr_kernel_enqueues, nr_user_enqueues;
+
+struct user_exit_info uei;
+
+/*
+ * Whether the user space scheduler needs to be scheduled due to a task being
+ * enqueued in user space.
+ */
+static bool usersched_needed;
+
+/*
+ * The map containing tasks that are enqueued in user space from the kernel.
+ *
+ * This map is drained by the user space scheduler.
+ */
+struct {
+	__uint(type, BPF_MAP_TYPE_QUEUE);
+	__uint(max_entries, USERLAND_MAX_TASKS);
+	__type(value, struct scx_userland_enqueued_task);
+} enqueued SEC(".maps");
+
+/*
+ * The map containing tasks that are dispatched to the kernel from user space.
+ *
+ * Drained by the kernel in userland_dispatch().
+ */
+struct {
+	__uint(type, BPF_MAP_TYPE_QUEUE);
+	__uint(max_entries, USERLAND_MAX_TASKS);
+	__type(value, s32);
+} dispatched SEC(".maps");
+
+/* Per-task scheduling context */
+struct task_ctx {
+	bool force_local; /* Dispatch directly to local DSQ */
+};
+
+/* Map that contains task-local storage. */
+struct {
+	__uint(type, BPF_MAP_TYPE_TASK_STORAGE);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__type(key, int);
+	__type(value, struct task_ctx);
+} task_ctx_stor SEC(".maps");
+
+static bool is_usersched_task(const struct task_struct *p)
+{
+	return p->pid == usersched_pid;
+}
+
+static bool keep_in_kernel(const struct task_struct *p)
+{
+	return p->nr_cpus_allowed < num_possible_cpus;
+}
+
+static struct task_struct *usersched_task(void)
+{
+	struct task_struct *p;
+
+	p = bpf_task_from_pid(usersched_pid);
+	/*
+	 * Should never happen -- the usersched task should always be managed
+	 * by sched_ext.
+	 */
+	if (!p)
+		scx_bpf_error("Failed to find usersched task %d", usersched_pid);
+
+	return p;
+}
+
+s32 BPF_STRUCT_OPS(userland_select_cpu, struct task_struct *p,
+		   s32 prev_cpu, u64 wake_flags)
+{
+	if (keep_in_kernel(p)) {
+		s32 cpu;
+		struct task_ctx *tctx;
+
+		tctx = bpf_task_storage_get(&task_ctx_stor, p, 0, 0);
+		if (!tctx) {
+			scx_bpf_error("Failed to look up task-local storage for %s", p->comm);
+			return -ESRCH;
+		}
+
+		if (p->nr_cpus_allowed == 1 ||
+		    scx_bpf_test_and_clear_cpu_idle(prev_cpu)) {
+			tctx->force_local = true;
+			return prev_cpu;
+		}
+
+		cpu = scx_bpf_pick_idle_cpu(p->cpus_ptr, 0);
+		if (cpu >= 0) {
+			tctx->force_local = true;
+			return cpu;
+		}
+	}
+
+	return prev_cpu;
+}
+
+static void dispatch_user_scheduler(void)
+{
+	struct task_struct *p;
+
+	usersched_needed = false;
+	p = usersched_task();
+	if (p) {
+		scx_bpf_dispatch(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, 0);
+		bpf_task_release(p);
+	}
+}
+
+static void enqueue_task_in_user_space(struct task_struct *p, u64 enq_flags)
+{
+	struct scx_userland_enqueued_task task;
+
+	memset(&task, 0, sizeof(task));
+	task.pid = p->pid;
+	task.sum_exec_runtime = p->se.sum_exec_runtime;
+	task.weight = p->scx.weight;
+
+	if (bpf_map_push_elem(&enqueued, &task, 0)) {
+		/*
+		 * If we fail to enqueue the task in user space, put it
+		 * directly on the global DSQ.
+		 */
+		__sync_fetch_and_add(&nr_failed_enqueues, 1);
+		scx_bpf_dispatch(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, enq_flags);
+	} else {
+		__sync_fetch_and_add(&nr_user_enqueues, 1);
+		usersched_needed = true;
+	}
+}
+
+void BPF_STRUCT_OPS(userland_enqueue, struct task_struct *p, u64 enq_flags)
+{
+	if (keep_in_kernel(p)) {
+		u64 dsq_id = SCX_DSQ_GLOBAL;
+		struct task_ctx *tctx;
+
+		tctx = bpf_task_storage_get(&task_ctx_stor, p, 0, 0);
+		if (!tctx) {
+			scx_bpf_error("Failed to lookup task ctx for %s", p->comm);
+			return;
+		}
+
+		if (tctx->force_local)
+			dsq_id = SCX_DSQ_LOCAL;
+		tctx->force_local = false;
+		scx_bpf_dispatch(p, dsq_id, SCX_SLICE_DFL, enq_flags);
+		__sync_fetch_and_add(&nr_kernel_enqueues, 1);
+		return;
+	} else if (!is_usersched_task(p)) {
+		enqueue_task_in_user_space(p, enq_flags);
+	}
+}
+
+void BPF_STRUCT_OPS(userland_dispatch, s32 cpu, struct task_struct *prev)
+{
+	if (usersched_needed)
+		dispatch_user_scheduler();
+
+	bpf_repeat(4096) {
+		s32 pid;
+		struct task_struct *p;
+
+		if (bpf_map_pop_elem(&dispatched, &pid))
+			break;
+
+		/*
+		 * The task could have exited by the time we get around to
+		 * dispatching it. Treat this as a normal occurrence, and simply
+		 * move onto the next iteration.
+		 */
+		p = bpf_task_from_pid(pid);
+		if (!p)
+			continue;
+
+		scx_bpf_dispatch(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, 0);
+		bpf_task_release(p);
+	}
+}
+
+s32 BPF_STRUCT_OPS(userland_prep_enable, struct task_struct *p,
+		   struct scx_enable_args *args)
+{
+	if (bpf_task_storage_get(&task_ctx_stor, p, 0,
+				 BPF_LOCAL_STORAGE_GET_F_CREATE))
+		return 0;
+	else
+		return -ENOMEM;
+}
+
+s32 BPF_STRUCT_OPS(userland_init)
+{
+	if (num_possible_cpus == 0) {
+		scx_bpf_error("User scheduler # CPUs uninitialized (%d)",
+			      num_possible_cpus);
+		return -EINVAL;
+	}
+
+	if (usersched_pid <= 0) {
+		scx_bpf_error("User scheduler pid uninitialized (%d)",
+			      usersched_pid);
+		return -EINVAL;
+	}
+
+	if (!switch_partial)
+		scx_bpf_switch_all();
+	return 0;
+}
+
+void BPF_STRUCT_OPS(userland_exit, struct scx_exit_info *ei)
+{
+	uei_record(&uei, ei);
+}
+
+SEC(".struct_ops.link")
+struct sched_ext_ops userland_ops = {
+	.select_cpu		= (void *)userland_select_cpu,
+	.enqueue		= (void *)userland_enqueue,
+	.dispatch		= (void *)userland_dispatch,
+	.prep_enable		= (void *)userland_prep_enable,
+	.init			= (void *)userland_init,
+	.exit			= (void *)userland_exit,
+	.timeout_ms		= 3000,
+	.name			= "userland",
+};
diff --git a/tools/sched_ext/scx_userland.c b/tools/sched_ext/scx_userland.c
new file mode 100644
index 000000000000..a63adae74f21
--- /dev/null
+++ b/tools/sched_ext/scx_userland.c
@@ -0,0 +1,402 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * A demo sched_ext user space scheduler which provides vruntime semantics
+ * using a simple ordered-list implementation.
+ *
+ * Each CPU in the system resides in a single, global domain. This precludes
+ * the need to do any load balancing between domains. The scheduler could
+ * easily be extended to support multiple domains, with load balancing
+ * happening in user space.
+ *
+ * Any task which has any CPU affinity is scheduled entirely in BPF. This
+ * program only schedules tasks which may run on any CPU.
+ *
+ * Copyright (c) 2022 Meta Platforms, Inc. and affiliates.
+ * Copyright (c) 2022 Tejun Heo <tj@kernel.org>
+ * Copyright (c) 2022 David Vernet <dvernet@meta.com>
+ */
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <unistd.h>
+#include <sched.h>
+#include <signal.h>
+#include <assert.h>
+#include <libgen.h>
+#include <pthread.h>
+#include <bpf/bpf.h>
+#include <sys/mman.h>
+#include <sys/queue.h>
+#include <sys/syscall.h>
+
+#include "user_exit_info.h"
+#include "scx_userland.h"
+#include "scx_userland.skel.h"
+
+const char help_fmt[] =
+"A minimal userland sched_ext scheduler.\n"
+"\n"
+"See the top-level comment in .bpf.c for more details.\n"
+"\n"
+"Usage: %s [-b BATCH] [-p]\n"
+"\n"
+"  -b BATCH      The number of tasks to batch when dispatching (default: 8)\n"
+"  -p            Don't switch all, switch only tasks on SCHED_EXT policy\n"
+"  -h            Display this help and exit\n";
+
+/* Defined in UAPI */
+#define SCHED_EXT 7
+
+/* Number of tasks to batch when dispatching to user space. */
+static __u32 batch_size = 8;
+
+static volatile int exit_req;
+static int enqueued_fd, dispatched_fd;
+
+static struct scx_userland *skel;
+static struct bpf_link *ops_link;
+
+/* Stats collected in user space. */
+static __u64 nr_vruntime_enqueues, nr_vruntime_dispatches;
+
+/* The data structure containing tasks that are enqueued in user space. */
+struct enqueued_task {
+	LIST_ENTRY(enqueued_task) entries;
+	__u64 sum_exec_runtime;
+	double vruntime;
+};
+
+/*
+ * Use a vruntime-sorted list to store tasks. This could easily be extended to
+ * a more optimal data structure, such as an rbtree as is done in CFS. We
+ * currently elect to use a sorted list to simplify the example for
+ * illustrative purposes.
+ */
+LIST_HEAD(listhead, enqueued_task);
+
+/*
+ * A vruntime-sorted list of tasks. The head of the list contains the task with
+ * the lowest vruntime. That is, the task that has the "highest" claim to be
+ * scheduled.
+ */
+static struct listhead vruntime_head = LIST_HEAD_INITIALIZER(vruntime_head);
+
+/*
+ * The statically allocated array of tasks. We use a statically allocated list
+ * here to avoid having to allocate on the enqueue path, which could cause a
+ * deadlock. A more substantive user space scheduler could e.g. provide a hook
+ * for newly enabled tasks that are passed to the scheduler from the
+ * .prep_enable() callback to allows the scheduler to allocate on safe paths.
+ */
+struct enqueued_task tasks[USERLAND_MAX_TASKS];
+
+static double min_vruntime;
+
+static void sigint_handler(int userland)
+{
+	exit_req = 1;
+}
+
+static __u32 task_pid(const struct enqueued_task *task)
+{
+	return ((uintptr_t)task - (uintptr_t)tasks) / sizeof(*task);
+}
+
+static int dispatch_task(s32 pid)
+{
+	int err;
+
+	err = bpf_map_update_elem(dispatched_fd, NULL, &pid, 0);
+	if (err) {
+		fprintf(stderr, "Failed to dispatch task %d\n", pid);
+		exit_req = 1;
+	} else {
+		nr_vruntime_dispatches++;
+	}
+
+	return err;
+}
+
+static struct enqueued_task *get_enqueued_task(__s32 pid)
+{
+	if (pid >= USERLAND_MAX_TASKS)
+		return NULL;
+
+	return &tasks[pid];
+}
+
+static double calc_vruntime_delta(__u64 weight, __u64 delta)
+{
+	double weight_f = (double)weight / 100.0;
+	double delta_f = (double)delta;
+
+	return delta_f / weight_f;
+}
+
+static void update_enqueued(struct enqueued_task *enqueued, const struct scx_userland_enqueued_task *bpf_task)
+{
+	__u64 delta;
+
+	delta = bpf_task->sum_exec_runtime - enqueued->sum_exec_runtime;
+
+	enqueued->vruntime += calc_vruntime_delta(bpf_task->weight, delta);
+	if (min_vruntime > enqueued->vruntime)
+		enqueued->vruntime = min_vruntime;
+	enqueued->sum_exec_runtime = bpf_task->sum_exec_runtime;
+}
+
+static int vruntime_enqueue(const struct scx_userland_enqueued_task *bpf_task)
+{
+	struct enqueued_task *curr, *enqueued, *prev;
+
+	curr = get_enqueued_task(bpf_task->pid);
+	if (!curr)
+		return ENOENT;
+
+	update_enqueued(curr, bpf_task);
+	nr_vruntime_enqueues++;
+
+	/*
+	 * Enqueue the task in a vruntime-sorted list. A more optimal data
+	 * structure such as an rbtree could easily be used as well. We elect
+	 * to use a list here simply because it's less code, and thus the
+	 * example is less convoluted and better serves to illustrate what a
+	 * user space scheduler could look like.
+	 */
+
+	if (LIST_EMPTY(&vruntime_head)) {
+		LIST_INSERT_HEAD(&vruntime_head, curr, entries);
+		return 0;
+	}
+
+	LIST_FOREACH(enqueued, &vruntime_head, entries) {
+		if (curr->vruntime <= enqueued->vruntime) {
+			LIST_INSERT_BEFORE(enqueued, curr, entries);
+			return 0;
+		}
+		prev = enqueued;
+	}
+
+	LIST_INSERT_AFTER(prev, curr, entries);
+
+	return 0;
+}
+
+static void drain_enqueued_map(void)
+{
+	while (1) {
+		struct scx_userland_enqueued_task task;
+		int err;
+
+		if (bpf_map_lookup_and_delete_elem(enqueued_fd, NULL, &task))
+			return;
+
+		err = vruntime_enqueue(&task);
+		if (err) {
+			fprintf(stderr, "Failed to enqueue task %d: %s\n",
+				task.pid, strerror(err));
+			exit_req = 1;
+			return;
+		}
+	}
+}
+
+static void dispatch_batch(void)
+{
+	__u32 i;
+
+	for (i = 0; i < batch_size; i++) {
+		struct enqueued_task *task;
+		int err;
+		__s32 pid;
+
+		task = LIST_FIRST(&vruntime_head);
+		if (!task)
+			return;
+
+		min_vruntime = task->vruntime;
+		pid = task_pid(task);
+		LIST_REMOVE(task, entries);
+		err = dispatch_task(pid);
+		if (err) {
+			fprintf(stderr, "Failed to dispatch task %d in %u\n",
+				pid, i);
+			return;
+		}
+	}
+}
+
+static void *run_stats_printer(void *arg)
+{
+	while (!exit_req) {
+		__u64 nr_failed_enqueues, nr_kernel_enqueues, nr_user_enqueues, total;
+
+		nr_failed_enqueues = skel->bss->nr_failed_enqueues;
+		nr_kernel_enqueues = skel->bss->nr_kernel_enqueues;
+		nr_user_enqueues = skel->bss->nr_user_enqueues;
+		total = nr_failed_enqueues + nr_kernel_enqueues + nr_user_enqueues;
+
+		printf("o-----------------------o\n");
+		printf("| BPF ENQUEUES          |\n");
+		printf("|-----------------------|\n");
+		printf("|  kern:     %10llu |\n", nr_kernel_enqueues);
+		printf("|  user:     %10llu |\n", nr_user_enqueues);
+		printf("|  failed:   %10llu |\n", nr_failed_enqueues);
+		printf("|  -------------------- |\n");
+		printf("|  total:    %10llu |\n", total);
+		printf("|                       |\n");
+		printf("|-----------------------|\n");
+		printf("| VRUNTIME / USER       |\n");
+		printf("|-----------------------|\n");
+		printf("|  enq:      %10llu |\n", nr_vruntime_enqueues);
+		printf("|  disp:     %10llu |\n", nr_vruntime_dispatches);
+		printf("o-----------------------o\n");
+		printf("\n\n");
+		sleep(1);
+	}
+
+	return NULL;
+}
+
+static int spawn_stats_thread(void)
+{
+	pthread_t stats_printer;
+
+	return pthread_create(&stats_printer, NULL, run_stats_printer, NULL);
+}
+
+static int bootstrap(int argc, char **argv)
+{
+	int err;
+	__u32 opt;
+	struct sched_param sched_param = {
+		.sched_priority = sched_get_priority_max(SCHED_EXT),
+	};
+	bool switch_partial = false;
+
+	signal(SIGINT, sigint_handler);
+	signal(SIGTERM, sigint_handler);
+	libbpf_set_strict_mode(LIBBPF_STRICT_ALL);
+
+	/*
+	 * Enforce that the user scheduler task is managed by sched_ext. The
+	 * task eagerly drains the list of enqueued tasks in its main work
+	 * loop, and then yields the CPU. The BPF scheduler only schedules the
+	 * user space scheduler task when at least one other task in the system
+	 * needs to be scheduled.
+	 */
+	err = syscall(__NR_sched_setscheduler, getpid(), SCHED_EXT, &sched_param);
+	if (err) {
+		fprintf(stderr, "Failed to set scheduler to SCHED_EXT: %s\n", strerror(err));
+		return err;
+	}
+
+	while ((opt = getopt(argc, argv, "b:ph")) != -1) {
+		switch (opt) {
+		case 'b':
+			batch_size = strtoul(optarg, NULL, 0);
+			break;
+		case 'p':
+			switch_partial = true;
+			break;
+		default:
+			fprintf(stderr, help_fmt, basename(argv[0]));
+			exit(opt != 'h');
+		}
+	}
+
+	/*
+	 * It's not always safe to allocate in a user space scheduler, as an
+	 * enqueued task could hold a lock that we require in order to be able
+	 * to allocate.
+	 */
+	err = mlockall(MCL_CURRENT | MCL_FUTURE);
+	if (err) {
+		fprintf(stderr, "Failed to prefault and lock address space: %s\n",
+			strerror(err));
+		return err;
+	}
+
+	skel = scx_userland__open();
+	if (!skel) {
+		fprintf(stderr, "Failed to open scheduler: %s\n", strerror(errno));
+		return errno;
+	}
+	skel->rodata->num_possible_cpus = libbpf_num_possible_cpus();
+	assert(skel->rodata->num_possible_cpus > 0);
+	skel->rodata->usersched_pid = getpid();
+	assert(skel->rodata->usersched_pid > 0);
+	skel->rodata->switch_partial = switch_partial;
+
+	err = scx_userland__load(skel);
+	if (err) {
+		fprintf(stderr, "Failed to load scheduler: %s\n", strerror(err));
+		goto destroy_skel;
+	}
+
+	enqueued_fd = bpf_map__fd(skel->maps.enqueued);
+	dispatched_fd = bpf_map__fd(skel->maps.dispatched);
+	assert(enqueued_fd > 0);
+	assert(dispatched_fd > 0);
+
+	err = spawn_stats_thread();
+	if (err) {
+		fprintf(stderr, "Failed to spawn stats thread: %s\n", strerror(err));
+		goto destroy_skel;
+	}
+
+	ops_link = bpf_map__attach_struct_ops(skel->maps.userland_ops);
+	if (!ops_link) {
+		fprintf(stderr, "Failed to attach struct ops: %s\n", strerror(errno));
+		err = errno;
+		goto destroy_skel;
+	}
+
+	return 0;
+
+destroy_skel:
+	scx_userland__destroy(skel);
+	exit_req = 1;
+	return err;
+}
+
+static void sched_main_loop(void)
+{
+	while (!exit_req) {
+		/*
+		 * Perform the following work in the main user space scheduler
+		 * loop:
+		 *
+		 * 1. Drain all tasks from the enqueued map, and enqueue them
+		 *    to the vruntime sorted list.
+		 *
+		 * 2. Dispatch a batch of tasks from the vruntime sorted list
+		 *    down to the kernel.
+		 *
+		 * 3. Yield the CPU back to the system. The BPF scheduler will
+		 *    reschedule the user space scheduler once another task has
+		 *    been enqueued to user space.
+		 */
+		drain_enqueued_map();
+		dispatch_batch();
+		sched_yield();
+	}
+}
+
+int main(int argc, char **argv)
+{
+	int err;
+
+	err = bootstrap(argc, argv);
+	if (err) {
+		fprintf(stderr, "Failed to bootstrap scheduler: %s\n", strerror(err));
+		return err;
+	}
+
+	sched_main_loop();
+
+	exit_req = 1;
+	bpf_link__destroy(ops_link);
+	uei_print(&skel->bss->uei);
+	scx_userland__destroy(skel);
+	return 0;
+}
diff --git a/tools/sched_ext/scx_userland.h b/tools/sched_ext/scx_userland.h
new file mode 100644
index 000000000000..639c6809c5ff
--- /dev/null
+++ b/tools/sched_ext/scx_userland.h
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022 Meta, Inc */
+
+#ifndef __SCX_USERLAND_COMMON_H
+#define __SCX_USERLAND_COMMON_H
+
+#define USERLAND_MAX_TASKS 8192
+
+/*
+ * An instance of a task that has been enqueued by the kernel for consumption
+ * by a user space global scheduler thread.
+ */
+struct scx_userland_enqueued_task {
+	__s32 pid;
+	u64 sum_exec_runtime;
+	u64 weight;
+};
+
+#endif  // __SCX_USERLAND_COMMON_H
-- 
2.41.0

