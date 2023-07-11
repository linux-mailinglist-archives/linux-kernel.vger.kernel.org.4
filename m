Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B96E674E334
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 03:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231656AbjGKBQZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 21:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231499AbjGKBP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 21:15:59 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1826B10FB;
        Mon, 10 Jul 2023 18:15:22 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-668704a5b5bso4523843b3a.0;
        Mon, 10 Jul 2023 18:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689038095; x=1691630095;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OR6WuT6qxDsiJGc69gtxzd2kfKgRFY10It5FwH8lr8Q=;
        b=WlBNrxi44z+xZGOoCRXo6Rnvacf3HqerKkCv6eA4/zqAu/Ef9uyjM0EoMWqd8YmRpy
         IbQw/u/Yy19JS46X/od5fnsvf/56FUU71KzIMiD/gzMaaqBba5bhkjkpA9tXZNdySMXm
         /KswPdtzicAcTr8SC6e+Z7v1PYzJjP/M5q3BQIMYm3Hcu/AMdG/3N9/tHL9M3HNurSjr
         2dXijgXuQnCyFDbFVfHcQXK9aD0zSlYK2IOh0UzbwJwLDhnF79DW3E7FyJFKibXceDyn
         oVo8g5+WIb0kR0zYPjM2biTy/K+Sm0jTHWG+OTXc7L2FUWGeCd9pR43id/G4Wahf55At
         1ecw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689038095; x=1691630095;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OR6WuT6qxDsiJGc69gtxzd2kfKgRFY10It5FwH8lr8Q=;
        b=P10sPdMKsFVGUoWf0dWGnrOCFiVB2Vbwa4p86EZ1upyM3oEZqqVfa4yT6bDz00C3sH
         hFccYzZ+XiU98IXPp2haZg9uD+Xk/1BsKB/aKkE52bukx1CWDCor1EmAbJ0t0SBH1qgp
         P0WDJNBCtt2mDnmsGgWzEi0wMwpvpwtrX195Fzd71kw/4VgouuFswNofCOBnXRCBCvsN
         1BX4MnSOTn2LFjM82q767h8TxJ8bhBj+MbPGqsAbg5f0Vszga7OpeZdtDFqv9e8qcYSd
         x6RzkHYQNnxwzew7BQejRwbksNJszMTodG5uDrBuQ7hHUxGHRT6KZod27mBd4sk0ezlu
         FtLQ==
X-Gm-Message-State: ABy/qLZVQ8TrjaKid48GhqTzfwcYwTKyFlZCQxk8QfQ6gBJWLUdhknRS
        wz+rzV7S+WRNiA6NkOeb7Ww=
X-Google-Smtp-Source: APBJJlGP0SHk1MWffl5xLDeoSMGtK6cafQYxFMP/he4MoY4B5DFgpNTRRgA7hJwEV+FRCqPzZ8xZEg==
X-Received: by 2002:a05:6a20:8414:b0:130:d8dd:f75e with SMTP id c20-20020a056a20841400b00130d8ddf75emr10153157pzd.27.1689038094445;
        Mon, 10 Jul 2023 18:14:54 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:e2fe])
        by smtp.gmail.com with ESMTPSA id j9-20020a63b609000000b005572d796b9esm247904pgf.88.2023.07.10.18.14.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 18:14:54 -0700 (PDT)
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
        kernel-team@meta.com, Tejun Heo <tj@kernel.org>,
        Julia Lawall <julia.lawall@inria.fr>
Subject: [PATCH 19/34] sched_ext: Add a central scheduler which makes all scheduling decisions on one CPU
Date:   Mon, 10 Jul 2023 15:13:37 -1000
Message-ID: <20230711011412.100319-20-tj@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230711011412.100319-1-tj@kernel.org>
References: <20230711011412.100319-1-tj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a new example scheduler, scx_central, which demonstrates
central scheduling where one CPU is responsible for making all scheduling
decisions in the system using scx_bpf_kick_cpu(). The central CPU makes
scheduling decisions for all CPUs in the system, queues tasks on the
appropriate local dsq's and preempts the worker CPUs. The worker CPUs in
turn preempt the central CPU when it needs tasks to run.

Currently, every CPU depends on its own tick to expire the current task. A
follow-up patch implementing tickless support for sched_ext will allow the
worker CPUs to go full tickless so that they can run completely undisturbed.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: David Vernet <dvernet@meta.com>
Acked-by: Josh Don <joshdon@google.com>
Acked-by: Hao Luo <haoluo@google.com>
Acked-by: Barret Rhoden <brho@google.com>
Cc: Julia Lawall <julia.lawall@inria.fr>
---
 tools/sched_ext/.gitignore        |   1 +
 tools/sched_ext/Makefile          |   8 +-
 tools/sched_ext/scx_central.bpf.c | 225 ++++++++++++++++++++++++++++++
 tools/sched_ext/scx_central.c     |  93 ++++++++++++
 4 files changed, 325 insertions(+), 2 deletions(-)
 create mode 100644 tools/sched_ext/scx_central.bpf.c
 create mode 100644 tools/sched_ext/scx_central.c

diff --git a/tools/sched_ext/.gitignore b/tools/sched_ext/.gitignore
index b1dd7580a5b4..7e5dec30a87e 100644
--- a/tools/sched_ext/.gitignore
+++ b/tools/sched_ext/.gitignore
@@ -1,5 +1,6 @@
 scx_simple
 scx_qmap
+scx_central
 *.skel.h
 *.subskel.h
 /tools/
diff --git a/tools/sched_ext/Makefile b/tools/sched_ext/Makefile
index f2723a0cde8b..be0445e071ef 100644
--- a/tools/sched_ext/Makefile
+++ b/tools/sched_ext/Makefile
@@ -115,7 +115,7 @@ BPF_CFLAGS = -g -D__TARGET_ARCH_$(SRCARCH)					\
 	     -Wall -Wno-compare-distinct-pointer-types				\
 	     -O2 -mcpu=v3
 
-all: scx_simple scx_qmap
+all: scx_simple scx_qmap scx_central
 
 # sort removes libbpf duplicates when not cross-building
 MAKE_DIRS := $(sort $(BUILD_DIR)/libbpf $(HOST_BUILD_DIR)/libbpf		\
@@ -174,10 +174,14 @@ scx_qmap: scx_qmap.c scx_qmap.skel.h user_exit_info.h
 	$(CC) $(CFLAGS) -c $< -o $@.o
 	$(CC) -o $@ $@.o $(HOST_BPFOBJ) $(LDFLAGS)
 
+scx_central: scx_central.c scx_central.skel.h user_exit_info.h
+	$(CC) $(CFLAGS) -c $< -o $@.o
+	$(CC) -o $@ $@.o $(HOST_BPFOBJ) $(LDFLAGS)
+
 clean:
 	rm -rf $(SCRATCH_DIR) $(HOST_SCRATCH_DIR)
 	rm -f *.o *.bpf.o *.skel.h *.subskel.h
-	rm -f scx_simple scx_qmap
+	rm -f scx_simple scx_qmap scx_central
 
 .PHONY: all clean
 
diff --git a/tools/sched_ext/scx_central.bpf.c b/tools/sched_ext/scx_central.bpf.c
new file mode 100644
index 000000000000..094e089300a2
--- /dev/null
+++ b/tools/sched_ext/scx_central.bpf.c
@@ -0,0 +1,225 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * A central FIFO sched_ext scheduler which demonstrates the followings:
+ *
+ * a. Making all scheduling decisions from one CPU:
+ *
+ *    The central CPU is the only one making scheduling decisions. All other
+ *    CPUs kick the central CPU when they run out of tasks to run.
+ *
+ *    There is one global BPF queue and the central CPU schedules all CPUs by
+ *    dispatching from the global queue to each CPU's local dsq from dispatch().
+ *    This isn't the most straightforward. e.g. It'd be easier to bounce
+ *    through per-CPU BPF queues. The current design is chosen to maximally
+ *    utilize and verify various SCX mechanisms such as LOCAL_ON dispatching.
+ *
+ * b. Preemption
+ *
+ *    SCX_KICK_PREEMPT is used to trigger scheduling and CPUs to move to the
+ *    next tasks.
+ *
+ * This scheduler is designed to maximize usage of various SCX mechanisms. A
+ * more practical implementation would likely put the scheduling loop outside
+ * the central CPU's dispatch() path and add some form of priority mechanism.
+ *
+ * Copyright (c) 2022 Meta Platforms, Inc. and affiliates.
+ * Copyright (c) 2022 Tejun Heo <tj@kernel.org>
+ * Copyright (c) 2022 David Vernet <dvernet@meta.com>
+ */
+#include "scx_common.bpf.h"
+
+char _license[] SEC("license") = "GPL";
+
+enum {
+	FALLBACK_DSQ_ID		= 0,
+	MAX_CPUS		= 4096,
+	MS_TO_NS		= 1000LLU * 1000,
+	TIMER_INTERVAL_NS	= 1 * MS_TO_NS,
+};
+
+const volatile bool switch_partial;
+const volatile s32 central_cpu;
+const volatile u32 nr_cpu_ids = 64;	/* !0 for veristat, set during init */
+
+u64 nr_total, nr_locals, nr_queued, nr_lost_pids;
+u64 nr_dispatches, nr_mismatches, nr_retries;
+u64 nr_overflows;
+
+struct user_exit_info uei;
+
+struct {
+	__uint(type, BPF_MAP_TYPE_QUEUE);
+	__uint(max_entries, 4096);
+	__type(value, s32);
+} central_q SEC(".maps");
+
+/* can't use percpu map due to bad lookups */
+static bool cpu_gimme_task[MAX_CPUS];
+
+struct central_timer {
+	struct bpf_timer timer;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, u32);
+	__type(value, struct central_timer);
+} central_timer SEC(".maps");
+
+s32 BPF_STRUCT_OPS(central_select_cpu, struct task_struct *p,
+		   s32 prev_cpu, u64 wake_flags)
+{
+	/*
+	 * Steer wakeups to the central CPU as much as possible to avoid
+	 * disturbing other CPUs. It's safe to blindly return the central cpu as
+	 * select_cpu() is a hint and if @p can't be on it, the kernel will
+	 * automatically pick a fallback CPU.
+	 */
+	return central_cpu;
+}
+
+void BPF_STRUCT_OPS(central_enqueue, struct task_struct *p, u64 enq_flags)
+{
+	s32 pid = p->pid;
+
+	__sync_fetch_and_add(&nr_total, 1);
+
+	if (bpf_map_push_elem(&central_q, &pid, 0)) {
+		__sync_fetch_and_add(&nr_overflows, 1);
+		scx_bpf_dispatch(p, FALLBACK_DSQ_ID, SCX_SLICE_DFL, enq_flags);
+		return;
+	}
+
+	__sync_fetch_and_add(&nr_queued, 1);
+
+	if (!scx_bpf_task_running(p))
+		scx_bpf_kick_cpu(central_cpu, SCX_KICK_PREEMPT);
+}
+
+static bool dispatch_to_cpu(s32 cpu)
+{
+	struct task_struct *p;
+	s32 pid;
+
+	bpf_repeat(BPF_MAX_LOOPS) {
+		if (bpf_map_pop_elem(&central_q, &pid))
+			break;
+
+		__sync_fetch_and_sub(&nr_queued, 1);
+
+		p = bpf_task_from_pid(pid);
+		if (!p) {
+			__sync_fetch_and_add(&nr_lost_pids, 1);
+			continue;
+		}
+
+		/*
+		 * If we can't run the task at the top, do the dumb thing and
+		 * bounce it to the fallback dsq.
+		 */
+		if (!bpf_cpumask_test_cpu(cpu, p->cpus_ptr)) {
+			__sync_fetch_and_add(&nr_mismatches, 1);
+			scx_bpf_dispatch(p, FALLBACK_DSQ_ID, SCX_SLICE_DFL, 0);
+			bpf_task_release(p);
+			continue;
+		}
+
+		/* dispatch to local and mark that @cpu doesn't need more */
+		scx_bpf_dispatch(p, SCX_DSQ_LOCAL_ON | cpu, SCX_SLICE_DFL, 0);
+
+		if (cpu != central_cpu)
+			scx_bpf_kick_cpu(cpu, 0);
+
+		bpf_task_release(p);
+		return true;
+	}
+
+	return false;
+}
+
+void BPF_STRUCT_OPS(central_dispatch, s32 cpu, struct task_struct *prev)
+{
+	if (cpu == central_cpu) {
+		/* dispatch for all other CPUs first */
+		__sync_fetch_and_add(&nr_dispatches, 1);
+
+		bpf_for(cpu, 0, nr_cpu_ids) {
+			bool *gimme;
+
+			if (!scx_bpf_dispatch_nr_slots())
+				break;
+
+			/* central's gimme is never set */
+			gimme = MEMBER_VPTR(cpu_gimme_task, [cpu]);
+			if (gimme && !*gimme)
+				continue;
+
+			if (dispatch_to_cpu(cpu))
+				*gimme = false;
+		}
+
+		/*
+		 * Retry if we ran out of dispatch buffer slots as we might have
+		 * skipped some CPUs and also need to dispatch for self. The ext
+		 * core automatically retries if the local dsq is empty but we
+		 * can't rely on that as we're dispatching for other CPUs too.
+		 * Kick self explicitly to retry.
+		 */
+		if (!scx_bpf_dispatch_nr_slots()) {
+			__sync_fetch_and_add(&nr_retries, 1);
+			scx_bpf_kick_cpu(central_cpu, SCX_KICK_PREEMPT);
+			return;
+		}
+
+		/* look for a task to run on the central CPU */
+		if (scx_bpf_consume(FALLBACK_DSQ_ID))
+			return;
+		dispatch_to_cpu(central_cpu);
+	} else {
+		bool *gimme;
+
+		if (scx_bpf_consume(FALLBACK_DSQ_ID))
+			return;
+
+		gimme = MEMBER_VPTR(cpu_gimme_task, [cpu]);
+		if (gimme)
+			*gimme = true;
+
+		/*
+		 * Force dispatch on the scheduling CPU so that it finds a task
+		 * to run for us.
+		 */
+		scx_bpf_kick_cpu(central_cpu, SCX_KICK_PREEMPT);
+	}
+}
+
+int BPF_STRUCT_OPS_SLEEPABLE(central_init)
+{
+	if (!switch_partial)
+		scx_bpf_switch_all();
+
+	return scx_bpf_create_dsq(FALLBACK_DSQ_ID, -1);
+}
+
+void BPF_STRUCT_OPS(central_exit, struct scx_exit_info *ei)
+{
+	uei_record(&uei, ei);
+}
+
+SEC(".struct_ops.link")
+struct sched_ext_ops central_ops = {
+	/*
+	 * We are offloading all scheduling decisions to the central CPU and
+	 * thus being the last task on a given CPU doesn't mean anything
+	 * special. Enqueue the last tasks like any other tasks.
+	 */
+	.flags			= SCX_OPS_ENQ_LAST,
+
+	.select_cpu		= (void *)central_select_cpu,
+	.enqueue		= (void *)central_enqueue,
+	.dispatch		= (void *)central_dispatch,
+	.init			= (void *)central_init,
+	.exit			= (void *)central_exit,
+	.name			= "central",
+};
diff --git a/tools/sched_ext/scx_central.c b/tools/sched_ext/scx_central.c
new file mode 100644
index 000000000000..09cb759984a6
--- /dev/null
+++ b/tools/sched_ext/scx_central.c
@@ -0,0 +1,93 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2022 Meta Platforms, Inc. and affiliates.
+ * Copyright (c) 2022 Tejun Heo <tj@kernel.org>
+ * Copyright (c) 2022 David Vernet <dvernet@meta.com>
+ */
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <unistd.h>
+#include <signal.h>
+#include <assert.h>
+#include <libgen.h>
+#include <bpf/bpf.h>
+#include "user_exit_info.h"
+#include "scx_central.skel.h"
+
+const char help_fmt[] =
+"A central FIFO sched_ext scheduler.\n"
+"\n"
+"See the top-level comment in .bpf.c for more details.\n"
+"\n"
+"Usage: %s [-c CPU] [-p]\n"
+"\n"
+"  -c CPU        Override the central CPU (default: 0)\n"
+"  -p            Switch only tasks on SCHED_EXT policy intead of all\n"
+"  -h            Display this help and exit\n";
+
+static volatile int exit_req;
+
+static void sigint_handler(int dummy)
+{
+	exit_req = 1;
+}
+
+int main(int argc, char **argv)
+{
+	struct scx_central *skel;
+	struct bpf_link *link;
+	u64 seq = 0;
+	s32 opt;
+
+	signal(SIGINT, sigint_handler);
+	signal(SIGTERM, sigint_handler);
+
+	libbpf_set_strict_mode(LIBBPF_STRICT_ALL);
+
+	skel = scx_central__open();
+	assert(skel);
+
+	skel->rodata->central_cpu = 0;
+	skel->rodata->nr_cpu_ids = libbpf_num_possible_cpus();
+
+	while ((opt = getopt(argc, argv, "c:ph")) != -1) {
+		switch (opt) {
+		case 'c':
+			skel->rodata->central_cpu = strtoul(optarg, NULL, 0);
+			break;
+		case 'p':
+			skel->rodata->switch_partial = true;
+			break;
+		default:
+			fprintf(stderr, help_fmt, basename(argv[0]));
+			return opt != 'h';
+		}
+	}
+
+	assert(!scx_central__load(skel));
+
+	link = bpf_map__attach_struct_ops(skel->maps.central_ops);
+	assert(link);
+
+	while (!exit_req && !uei_exited(&skel->bss->uei)) {
+		printf("[SEQ %lu]\n", seq++);
+		printf("total   :%10lu    local:%10lu   queued:%10lu  lost:%10lu\n",
+		       skel->bss->nr_total,
+		       skel->bss->nr_locals,
+		       skel->bss->nr_queued,
+		       skel->bss->nr_lost_pids);
+		printf("                    dispatch:%10lu mismatch:%10lu retry:%10lu\n",
+		       skel->bss->nr_dispatches,
+		       skel->bss->nr_mismatches,
+		       skel->bss->nr_retries);
+		printf("overflow:%10lu\n",
+		       skel->bss->nr_overflows);
+		fflush(stdout);
+		sleep(1);
+	}
+
+	bpf_link__destroy(link);
+	uei_print(&skel->bss->uei);
+	scx_central__destroy(skel);
+	return 0;
+}
-- 
2.41.0

