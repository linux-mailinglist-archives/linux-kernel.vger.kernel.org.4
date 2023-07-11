Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE8CB74E342
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 03:17:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231646AbjGKBQx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 21:16:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230486AbjGKBQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 21:16:14 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 175E1E6B;
        Mon, 10 Jul 2023 18:15:36 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-666ed230c81so4465424b3a.0;
        Mon, 10 Jul 2023 18:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689038107; x=1691630107;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WV8m1/eouXEL4OqwvswiIQb409b0jWppG6vq8Jtk5q4=;
        b=UQgRbZFTNVkyd762WDk61tWM/fFLBeEBsdds+WC3QUOAERqrUgDkbvxB+DHjlPglxY
         QNFnSFm1gz7lPT8KwKYU/thCjXKGYlbEgWw4Ddz9eg5wmO2talurBWuHqiMztlhmoPdH
         U1kk/cIvX4ZKR74oaoK4sFFZUIDxQS5yFU2kt9hjJHJSnYat76rIg+cNo1XlsWEGhqXT
         8iuxXAGLLIynCaJqIBK6aNcMD4qaUS2HNqLxQfEQo4fcFH91Xs0QTZaaLgilR1nTMSSD
         IQQEpj0EOysNjSPJWb2smyYHdT24tM7SexxRL6+g9HRPikYkwoujTZpuPBWxaxGsCSyJ
         BnkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689038107; x=1691630107;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WV8m1/eouXEL4OqwvswiIQb409b0jWppG6vq8Jtk5q4=;
        b=F8N9wXfsCUurQVLPHzazng8bBHfAJYZTUaxeGi6J/daeSFBu7tH5m8CJwIzI2rQMap
         goy77vafQyTY+x/LzUHtKo5TUYzfh3Bt+EHjVt3+8ThgrRIlBK5rRk7e4sPlxBbCkUOn
         RXSnAvBJS9JEvNXdAM28gsr+ej3HLQ3Z701l3+y91ghfD6IpVravMQRFJtSgUtLl1tk4
         o8nHkUuaJGUXK0B5dH3v5ZLE7Lzz23oMj1kAyXkdkAhFkKhIx+RcUeR6kYOeEpNtJU2e
         TwS9cnCs5TUVJEejaFz1gTknnr4mdd8vR+RvXEfEZS2tJVHQcnje6C4DTU7Tq21ve5sD
         GXfg==
X-Gm-Message-State: ABy/qLY+VddeUTkM1waGF/5U5jEengKte8PAFRuq0CRgCey1JwtntUMy
        4CX+p+wnRxIdlzbw1Y3NNn4=
X-Google-Smtp-Source: APBJJlEFXQbWclVaivEiG83zK7EntVy3pOSxyMBXoz6y13ZCLwwYBSIsg7uHIU7UVwkDkcvDSsnfpw==
X-Received: by 2002:a05:6a00:22c9:b0:66e:8635:a18e with SMTP id f9-20020a056a0022c900b0066e8635a18emr18366353pfj.22.1689038106329;
        Mon, 10 Jul 2023 18:15:06 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:e2fe])
        by smtp.gmail.com with ESMTPSA id d22-20020aa78e56000000b0064aea45b040sm387712pfr.168.2023.07.10.18.15.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 18:15:05 -0700 (PDT)
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
Subject: [PATCH 25/34] sched_ext: Add a cgroup-based core-scheduling scheduler
Date:   Mon, 10 Jul 2023 15:13:43 -1000
Message-ID: <20230711011412.100319-26-tj@kernel.org>
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

This patch adds scx_pair example scheduler which implements a variant of
core scheduling where a hyperthread pair only run tasks from the same
cgroup. The BPF scheduler achieves this by putting tasks into per-cgroup
queues, time-slicing the cgroup to run for each pair first, and then
scheduling within the cgroup. See the header comment in scx_pair.bpf.c for
more details.

Note that scx_pair's cgroup-boundary guarantee breaks down for tasks running
in higher priority scheduler classes. This will be addressed by a followup
patch which implements a mechanism to track CPU preemption.

v2: * Improved stride parameter input verification.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: David Vernet <dvernet@meta.com>
Acked-by: Josh Don <joshdon@google.com>
Acked-by: Hao Luo <haoluo@google.com>
Acked-by: Barret Rhoden <brho@google.com>
---
 tools/sched_ext/.gitignore     |   1 +
 tools/sched_ext/Makefile       |   8 +-
 tools/sched_ext/scx_pair.bpf.c | 536 +++++++++++++++++++++++++++++++++
 tools/sched_ext/scx_pair.c     | 164 ++++++++++
 tools/sched_ext/scx_pair.h     |  10 +
 5 files changed, 717 insertions(+), 2 deletions(-)
 create mode 100644 tools/sched_ext/scx_pair.bpf.c
 create mode 100644 tools/sched_ext/scx_pair.c
 create mode 100644 tools/sched_ext/scx_pair.h

diff --git a/tools/sched_ext/.gitignore b/tools/sched_ext/.gitignore
index 7e5dec30a87e..4659a15b8daf 100644
--- a/tools/sched_ext/.gitignore
+++ b/tools/sched_ext/.gitignore
@@ -1,6 +1,7 @@
 scx_simple
 scx_qmap
 scx_central
+scx_pair
 *.skel.h
 *.subskel.h
 /tools/
diff --git a/tools/sched_ext/Makefile b/tools/sched_ext/Makefile
index be0445e071ef..f3f8f083de16 100644
--- a/tools/sched_ext/Makefile
+++ b/tools/sched_ext/Makefile
@@ -115,7 +115,7 @@ BPF_CFLAGS = -g -D__TARGET_ARCH_$(SRCARCH)					\
 	     -Wall -Wno-compare-distinct-pointer-types				\
 	     -O2 -mcpu=v3
 
-all: scx_simple scx_qmap scx_central
+all: scx_simple scx_qmap scx_central scx_pair
 
 # sort removes libbpf duplicates when not cross-building
 MAKE_DIRS := $(sort $(BUILD_DIR)/libbpf $(HOST_BUILD_DIR)/libbpf		\
@@ -178,10 +178,14 @@ scx_central: scx_central.c scx_central.skel.h user_exit_info.h
 	$(CC) $(CFLAGS) -c $< -o $@.o
 	$(CC) -o $@ $@.o $(HOST_BPFOBJ) $(LDFLAGS)
 
+scx_pair: scx_pair.c scx_pair.skel.h user_exit_info.h
+	$(CC) $(CFLAGS) -c $< -o $@.o
+	$(CC) -o $@ $@.o $(HOST_BPFOBJ) $(LDFLAGS)
+
 clean:
 	rm -rf $(SCRATCH_DIR) $(HOST_SCRATCH_DIR)
 	rm -f *.o *.bpf.o *.skel.h *.subskel.h
-	rm -f scx_simple scx_qmap scx_central
+	rm -f scx_simple scx_qmap scx_central scx_pair scx_flatcg
 
 .PHONY: all clean
 
diff --git a/tools/sched_ext/scx_pair.bpf.c b/tools/sched_ext/scx_pair.bpf.c
new file mode 100644
index 000000000000..f980d301dbbe
--- /dev/null
+++ b/tools/sched_ext/scx_pair.bpf.c
@@ -0,0 +1,536 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * A demo sched_ext core-scheduler which always makes every sibling CPU pair
+ * execute from the same CPU cgroup.
+ *
+ * This scheduler is a minimal implementation and would need some form of
+ * priority handling both inside each cgroup and across the cgroups to be
+ * practically useful.
+ *
+ * Each CPU in the system is paired with exactly one other CPU, according to a
+ * "stride" value that can be specified when the BPF scheduler program is first
+ * loaded. Throughout the runtime of the scheduler, these CPU pairs guarantee
+ * that they will only ever schedule tasks that belong to the same CPU cgroup.
+ *
+ * Scheduler Initialization
+ * ------------------------
+ *
+ * The scheduler BPF program is first initialized from user space, before it is
+ * enabled. During this initialization process, each CPU on the system is
+ * assigned several values that are constant throughout its runtime:
+ *
+ * 1. *Pair CPU*: The CPU that it synchronizes with when making scheduling
+ *		  decisions. Paired CPUs always schedule tasks from the same
+ *		  CPU cgroup, and synchronize with each other to guarantee
+ *		  that this constraint is not violated.
+ * 2. *Pair ID*:  Each CPU pair is assigned a Pair ID, which is used to access
+ *		  a struct pair_ctx object that is shared between the pair.
+ * 3. *In-pair-index*: An index, 0 or 1, that is assigned to each core in the
+ *		       pair. Each struct pair_ctx has an active_mask field,
+ *		       which is a bitmap used to indicate whether each core
+ *		       in the pair currently has an actively running task.
+ *		       This index specifies which entry in the bitmap corresponds
+ *		       to each CPU in the pair.
+ *
+ * During this initialization, the CPUs are paired according to a "stride" that
+ * may be specified when invoking the user space program that initializes and
+ * loads the scheduler. By default, the stride is 1/2 the total number of CPUs.
+ *
+ * Tasks and cgroups
+ * -----------------
+ *
+ * Every cgroup in the system is registered with the scheduler using the
+ * pair_cgroup_init() callback, and every task in the system is associated with
+ * exactly one cgroup. At a high level, the idea with the pair scheduler is to
+ * always schedule tasks from the same cgroup within a given CPU pair. When a
+ * task is enqueued (i.e. passed to the pair_enqueue() callback function), its
+ * cgroup ID is read from its task struct, and then a corresponding queue map
+ * is used to FIFO-enqueue the task for that cgroup.
+ *
+ * If you look through the implementation of the scheduler, you'll notice that
+ * there is quite a bit of complexity involved with looking up the per-cgroup
+ * FIFO queue that we enqueue tasks in. For example, there is a cgrp_q_idx_hash
+ * BPF hash map that is used to map a cgroup ID to a globally unique ID that's
+ * allocated in the BPF program. This is done because we use separate maps to
+ * store the FIFO queue of tasks, and the length of that map, per cgroup. This
+ * complexity is only present because of current deficiencies in BPF that will
+ * soon be addressed. The main point to keep in mind is that newly enqueued
+ * tasks are added to their cgroup's FIFO queue.
+ *
+ * Dispatching tasks
+ * -----------------
+ *
+ * This section will describe how enqueued tasks are dispatched and scheduled.
+ * Tasks are dispatched in pair_dispatch(), and at a high level the workflow is
+ * as follows:
+ *
+ * 1. Fetch the struct pair_ctx for the current CPU. As mentioned above, this is
+ *    the structure that's used to synchronize amongst the two pair CPUs in their
+ *    scheduling decisions. After any of the following events have occurred:
+ *
+ * - The cgroup's slice run has expired, or
+ * - The cgroup becomes empty, or
+ * - Either CPU in the pair is preempted by a higher priority scheduling class
+ *
+ * The cgroup transitions to the draining state and stops executing new tasks
+ * from the cgroup.
+ *
+ * 2. If the pair is still executing a task, mark the pair_ctx as draining, and
+ *    wait for the pair CPU to be preempted.
+ *
+ * 3. Otherwise, if the pair CPU is not running a task, we can move onto
+ *    scheduling new tasks. Pop the next cgroup id from the top_q queue.
+ *
+ * 4. Pop a task from that cgroup's FIFO task queue, and begin executing it.
+ *
+ * Note again that this scheduling behavior is simple, but the implementation
+ * is complex mostly because this it hits several BPF shortcomings and has to
+ * work around in often awkward ways. Most of the shortcomings are expected to
+ * be resolved in the near future which should allow greatly simplifying this
+ * scheduler.
+ *
+ * Copyright (c) 2022 Meta Platforms, Inc. and affiliates.
+ * Copyright (c) 2022 Tejun Heo <tj@kernel.org>
+ * Copyright (c) 2022 David Vernet <dvernet@meta.com>
+ */
+#include "scx_common.bpf.h"
+#include "scx_pair.h"
+
+char _license[] SEC("license") = "GPL";
+
+const volatile bool switch_partial;
+
+/* !0 for veristat, set during init */
+const volatile u32 nr_cpu_ids = 64;
+
+/* a pair of CPUs stay on a cgroup for this duration */
+const volatile u32 pair_batch_dur_ns = SCX_SLICE_DFL;
+
+/* cpu ID -> pair cpu ID */
+const volatile s32 pair_cpu[MAX_CPUS] = { [0 ... MAX_CPUS - 1] = -1 };
+
+/* cpu ID -> pair_id */
+const volatile u32 pair_id[MAX_CPUS];
+
+/* CPU ID -> CPU # in the pair (0 or 1) */
+const volatile u32 in_pair_idx[MAX_CPUS];
+
+struct pair_ctx {
+	struct bpf_spin_lock	lock;
+
+	/* the cgroup the pair is currently executing */
+	u64			cgid;
+
+	/* the pair started executing the current cgroup at */
+	u64			started_at;
+
+	/* whether the current cgroup is draining */
+	bool			draining;
+
+	/* the CPUs that are currently active on the cgroup */
+	u32			active_mask;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, MAX_CPUS / 2);
+	__type(key, u32);
+	__type(value, struct pair_ctx);
+} pair_ctx SEC(".maps");
+
+/* queue of cgrp_q's possibly with tasks on them */
+struct {
+	__uint(type, BPF_MAP_TYPE_QUEUE);
+	/*
+	 * Because it's difficult to build strong synchronization encompassing
+	 * multiple non-trivial operations in BPF, this queue is managed in an
+	 * opportunistic way so that we guarantee that a cgroup w/ active tasks
+	 * is always on it but possibly multiple times. Once we have more robust
+	 * synchronization constructs and e.g. linked list, we should be able to
+	 * do this in a prettier way but for now just size it big enough.
+	 */
+	__uint(max_entries, 4 * MAX_CGRPS);
+	__type(value, u64);
+} top_q SEC(".maps");
+
+/* per-cgroup q which FIFOs the tasks from the cgroup */
+struct cgrp_q {
+	__uint(type, BPF_MAP_TYPE_QUEUE);
+	__uint(max_entries, MAX_QUEUED);
+	__type(value, u32);
+};
+
+/*
+ * Ideally, we want to allocate cgrp_q and cgrq_q_len in the cgroup local
+ * storage; however, a cgroup local storage can only be accessed from the BPF
+ * progs attached to the cgroup. For now, work around by allocating array of
+ * cgrp_q's and then allocating per-cgroup indices.
+ *
+ * Another caveat: It's difficult to populate a large array of maps statically
+ * or from BPF. Initialize it from userland.
+ */
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY_OF_MAPS);
+	__uint(max_entries, MAX_CGRPS);
+	__type(key, s32);
+	__array(values, struct cgrp_q);
+} cgrp_q_arr SEC(".maps");
+
+static u64 cgrp_q_len[MAX_CGRPS];
+
+/*
+ * This and cgrp_q_idx_hash combine into a poor man's IDR. This likely would be
+ * useful to have as a map type.
+ */
+static u32 cgrp_q_idx_cursor;
+static u64 cgrp_q_idx_busy[MAX_CGRPS];
+
+/*
+ * All added up, the following is what we do:
+ *
+ * 1. When a cgroup is enabled, RR cgroup_q_idx_busy array doing cmpxchg looking
+ *    for a free ID. If not found, fail cgroup creation with -EBUSY.
+ *
+ * 2. Hash the cgroup ID to the allocated cgrp_q_idx in the following
+ *    cgrp_q_idx_hash.
+ *
+ * 3. Whenever a cgrp_q needs to be accessed, first look up the cgrp_q_idx from
+ *    cgrp_q_idx_hash and then access the corresponding entry in cgrp_q_arr.
+ *
+ * This is sadly complicated for something pretty simple. Hopefully, we should
+ * be able to simplify in the future.
+ */
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(max_entries, MAX_CGRPS);
+	__uint(key_size, sizeof(u64));		/* cgrp ID */
+	__uint(value_size, sizeof(s32));	/* cgrp_q idx */
+} cgrp_q_idx_hash SEC(".maps");
+
+/* statistics */
+u64 nr_total, nr_dispatched, nr_missing, nr_kicks, nr_preemptions;
+u64 nr_exps, nr_exp_waits, nr_exp_empty;
+u64 nr_cgrp_next, nr_cgrp_coll, nr_cgrp_empty;
+
+struct user_exit_info uei;
+
+static bool time_before(u64 a, u64 b)
+{
+	return (s64)(a - b) < 0;
+}
+
+void BPF_STRUCT_OPS(pair_enqueue, struct task_struct *p, u64 enq_flags)
+{
+	struct cgroup *cgrp;
+	struct cgrp_q *cgq;
+	s32 pid = p->pid;
+	u64 cgid;
+	u32 *q_idx;
+	u64 *cgq_len;
+
+	__sync_fetch_and_add(&nr_total, 1);
+
+	cgrp = scx_bpf_task_cgroup(p);
+	cgid = cgrp->kn->id;
+	bpf_cgroup_release(cgrp);
+
+	/* find the cgroup's q and push @p into it */
+	q_idx = bpf_map_lookup_elem(&cgrp_q_idx_hash, &cgid);
+	if (!q_idx) {
+		scx_bpf_error("failed to lookup q_idx for cgroup[%llu]", cgid);
+		return;
+	}
+
+	cgq = bpf_map_lookup_elem(&cgrp_q_arr, q_idx);
+	if (!cgq) {
+		scx_bpf_error("failed to lookup q_arr for cgroup[%llu] q_idx[%u]",
+			      cgid, *q_idx);
+		return;
+	}
+
+	if (bpf_map_push_elem(cgq, &pid, 0)) {
+		scx_bpf_error("cgroup[%llu] queue overflow", cgid);
+		return;
+	}
+
+	/* bump q len, if going 0 -> 1, queue cgroup into the top_q */
+	cgq_len = MEMBER_VPTR(cgrp_q_len, [*q_idx]);
+	if (!cgq_len) {
+		scx_bpf_error("MEMBER_VTPR malfunction");
+		return;
+	}
+
+	if (!__sync_fetch_and_add(cgq_len, 1) &&
+	    bpf_map_push_elem(&top_q, &cgid, 0)) {
+		scx_bpf_error("top_q overflow");
+		return;
+	}
+}
+
+static int lookup_pairc_and_mask(s32 cpu, struct pair_ctx **pairc, u32 *mask)
+{
+	u32 *vptr;
+
+	vptr = (u32 *)MEMBER_VPTR(pair_id, [cpu]);
+	if (!vptr)
+		return -EINVAL;
+
+	*pairc = bpf_map_lookup_elem(&pair_ctx, vptr);
+	if (!(*pairc))
+		return -EINVAL;
+
+	vptr = (u32 *)MEMBER_VPTR(in_pair_idx, [cpu]);
+	if (!vptr)
+		return -EINVAL;
+
+	*mask = 1U << *vptr;
+
+	return 0;
+}
+
+static int try_dispatch(s32 cpu)
+{
+	struct pair_ctx *pairc;
+	struct bpf_map *cgq_map;
+	struct task_struct *p;
+	u64 now = bpf_ktime_get_ns();
+	bool kick_pair = false;
+	bool expired;
+	u32 *vptr, in_pair_mask;
+	s32 pid, q_idx;
+	u64 cgid;
+	int ret;
+
+	ret = lookup_pairc_and_mask(cpu, &pairc, &in_pair_mask);
+	if (ret) {
+		scx_bpf_error("failed to lookup pairc and in_pair_mask for cpu[%d]",
+			      cpu);
+		return -ENOENT;
+	}
+
+	bpf_spin_lock(&pairc->lock);
+	pairc->active_mask &= ~in_pair_mask;
+
+	expired = time_before(pairc->started_at + pair_batch_dur_ns, now);
+	if (expired || pairc->draining) {
+		u64 new_cgid = 0;
+
+		__sync_fetch_and_add(&nr_exps, 1);
+
+		/*
+		 * We're done with the current cgid. An obvious optimization
+		 * would be not draining if the next cgroup is the current one.
+		 * For now, be dumb and always expire.
+		 */
+		pairc->draining = true;
+
+		if (pairc->active_mask) {
+			/*
+			 * The other CPU is still active We want to wait until
+			 * this cgroup expires.
+			 *
+			 * If the pair controls its CPU, and the time already
+			 * expired, kick.  When the other CPU arrives at
+			 * dispatch and clears its active mask, it'll push the
+			 * pair to the next cgroup and kick this CPU.
+			 */
+			__sync_fetch_and_add(&nr_exp_waits, 1);
+			bpf_spin_unlock(&pairc->lock);
+			if (expired)
+				kick_pair = true;
+			goto out_maybe_kick;
+		}
+
+		bpf_spin_unlock(&pairc->lock);
+
+		/*
+		 * Pick the next cgroup. It'd be easier / cleaner to not drop
+		 * pairc->lock and use stronger synchronization here especially
+		 * given that we'll be switching cgroups significantly less
+		 * frequently than tasks. Unfortunately, bpf_spin_lock can't
+		 * really protect anything non-trivial. Let's do opportunistic
+		 * operations instead.
+		 */
+		bpf_repeat(BPF_MAX_LOOPS) {
+			u32 *q_idx;
+			u64 *cgq_len;
+
+			if (bpf_map_pop_elem(&top_q, &new_cgid)) {
+				/* no active cgroup, go idle */
+				__sync_fetch_and_add(&nr_exp_empty, 1);
+				return 0;
+			}
+
+			q_idx = bpf_map_lookup_elem(&cgrp_q_idx_hash, &new_cgid);
+			if (!q_idx)
+				continue;
+
+			/*
+			 * This is the only place where empty cgroups are taken
+			 * off the top_q.
+			 */
+			cgq_len = MEMBER_VPTR(cgrp_q_len, [*q_idx]);
+			if (!cgq_len || !*cgq_len)
+				continue;
+
+			/*
+			 * If it has any tasks, requeue as we may race and not
+			 * execute it.
+			 */
+			bpf_map_push_elem(&top_q, &new_cgid, 0);
+			break;
+		}
+
+		bpf_spin_lock(&pairc->lock);
+
+		/*
+		 * The other CPU may already have started on a new cgroup while
+		 * we dropped the lock. Make sure that we're still draining and
+		 * start on the new cgroup.
+		 */
+		if (pairc->draining && !pairc->active_mask) {
+			__sync_fetch_and_add(&nr_cgrp_next, 1);
+			pairc->cgid = new_cgid;
+			pairc->started_at = now;
+			pairc->draining = false;
+			kick_pair = true;
+		} else {
+			__sync_fetch_and_add(&nr_cgrp_coll, 1);
+		}
+	}
+
+	cgid = pairc->cgid;
+	pairc->active_mask |= in_pair_mask;
+	bpf_spin_unlock(&pairc->lock);
+
+	/* again, it'd be better to do all these with the lock held, oh well */
+	vptr = bpf_map_lookup_elem(&cgrp_q_idx_hash, &cgid);
+	if (!vptr) {
+		scx_bpf_error("failed to lookup q_idx for cgroup[%llu]", cgid);
+		return -ENOENT;
+	}
+	q_idx = *vptr;
+
+	/* claim one task from cgrp_q w/ q_idx */
+	bpf_repeat(BPF_MAX_LOOPS) {
+		u64 *cgq_len, len;
+
+		cgq_len = MEMBER_VPTR(cgrp_q_len, [q_idx]);
+		if (!cgq_len || !(len = *(volatile u64 *)cgq_len)) {
+			/* the cgroup must be empty, expire and repeat */
+			__sync_fetch_and_add(&nr_cgrp_empty, 1);
+			bpf_spin_lock(&pairc->lock);
+			pairc->draining = true;
+			pairc->active_mask &= ~in_pair_mask;
+			bpf_spin_unlock(&pairc->lock);
+			return -EAGAIN;
+		}
+
+		if (__sync_val_compare_and_swap(cgq_len, len, len - 1) != len)
+			continue;
+
+		break;
+	}
+
+	cgq_map = bpf_map_lookup_elem(&cgrp_q_arr, &q_idx);
+	if (!cgq_map) {
+		scx_bpf_error("failed to lookup cgq_map for cgroup[%llu] q_idx[%d]",
+			      cgid, q_idx);
+		return -ENOENT;
+	}
+
+	if (bpf_map_pop_elem(cgq_map, &pid)) {
+		scx_bpf_error("cgq_map is empty for cgroup[%llu] q_idx[%d]",
+			      cgid, q_idx);
+		return -ENOENT;
+	}
+
+	p = bpf_task_from_pid(pid);
+	if (p) {
+		__sync_fetch_and_add(&nr_dispatched, 1);
+		scx_bpf_dispatch(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, 0);
+		bpf_task_release(p);
+	} else {
+		/* we don't handle dequeues, retry on lost tasks */
+		__sync_fetch_and_add(&nr_missing, 1);
+		return -EAGAIN;
+	}
+
+out_maybe_kick:
+	if (kick_pair) {
+		s32 *pair = (s32 *)MEMBER_VPTR(pair_cpu, [cpu]);
+		if (pair) {
+			__sync_fetch_and_add(&nr_kicks, 1);
+			scx_bpf_kick_cpu(*pair, SCX_KICK_PREEMPT);
+		}
+	}
+	return 0;
+}
+
+void BPF_STRUCT_OPS(pair_dispatch, s32 cpu, struct task_struct *prev)
+{
+	bpf_repeat(BPF_MAX_LOOPS) {
+		if (try_dispatch(cpu) != -EAGAIN)
+			break;
+	}
+}
+
+s32 BPF_STRUCT_OPS(pair_cgroup_init, struct cgroup *cgrp)
+{
+	u64 cgid = cgrp->kn->id;
+	s32 i, q_idx;
+
+	bpf_for(i, 0, MAX_CGRPS) {
+		q_idx = __sync_fetch_and_add(&cgrp_q_idx_cursor, 1) % MAX_CGRPS;
+		if (!__sync_val_compare_and_swap(&cgrp_q_idx_busy[q_idx], 0, 1))
+			break;
+	}
+	if (i == MAX_CGRPS)
+		return -EBUSY;
+
+	if (bpf_map_update_elem(&cgrp_q_idx_hash, &cgid, &q_idx, BPF_ANY)) {
+		u64 *busy = MEMBER_VPTR(cgrp_q_idx_busy, [q_idx]);
+		if (busy)
+			*busy = 0;
+		return -EBUSY;
+	}
+
+	return 0;
+}
+
+void BPF_STRUCT_OPS(pair_cgroup_exit, struct cgroup *cgrp)
+{
+	u64 cgid = cgrp->kn->id;
+	s32 *q_idx;
+
+	q_idx = bpf_map_lookup_elem(&cgrp_q_idx_hash, &cgid);
+	if (q_idx) {
+		u64 *busy = MEMBER_VPTR(cgrp_q_idx_busy, [*q_idx]);
+		if (busy)
+			*busy = 0;
+		bpf_map_delete_elem(&cgrp_q_idx_hash, &cgid);
+	}
+}
+
+s32 BPF_STRUCT_OPS(pair_init)
+{
+	if (!switch_partial)
+		scx_bpf_switch_all();
+	return 0;
+}
+
+void BPF_STRUCT_OPS(pair_exit, struct scx_exit_info *ei)
+{
+	uei_record(&uei, ei);
+}
+
+SEC(".struct_ops.link")
+struct sched_ext_ops pair_ops = {
+	.enqueue		= (void *)pair_enqueue,
+	.dispatch		= (void *)pair_dispatch,
+	.cgroup_init		= (void *)pair_cgroup_init,
+	.cgroup_exit		= (void *)pair_cgroup_exit,
+	.init			= (void *)pair_init,
+	.exit			= (void *)pair_exit,
+	.name			= "pair",
+};
diff --git a/tools/sched_ext/scx_pair.c b/tools/sched_ext/scx_pair.c
new file mode 100644
index 000000000000..4d24fcedc2cd
--- /dev/null
+++ b/tools/sched_ext/scx_pair.c
@@ -0,0 +1,164 @@
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
+#include "scx_pair.h"
+#include "scx_pair.skel.h"
+
+const char help_fmt[] =
+"A demo sched_ext core-scheduler which always makes every sibling CPU pair\n"
+"execute from the same CPU cgroup.\n"
+"\n"
+"See the top-level comment in .bpf.c for more details.\n"
+"\n"
+"Usage: %s [-S STRIDE] [-p]\n"
+"\n"
+"  -S STRIDE     Override CPU pair stride (default: nr_cpus_ids / 2)\n"
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
+	struct scx_pair *skel;
+	struct bpf_link *link;
+	u64 seq = 0;
+	s32 stride, i, opt, outer_fd;
+
+	signal(SIGINT, sigint_handler);
+	signal(SIGTERM, sigint_handler);
+
+	libbpf_set_strict_mode(LIBBPF_STRICT_ALL);
+
+	skel = scx_pair__open();
+	assert(skel);
+
+	skel->rodata->nr_cpu_ids = libbpf_num_possible_cpus();
+
+	/* pair up the earlier half to the latter by default, override with -s */
+	stride = skel->rodata->nr_cpu_ids / 2;
+
+	while ((opt = getopt(argc, argv, "S:ph")) != -1) {
+		switch (opt) {
+		case 'S':
+			stride = strtoul(optarg, NULL, 0);
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
+	printf("Pairs: ");
+	for (i = 0; i < skel->rodata->nr_cpu_ids; i++) {
+		int j = (i + stride) % skel->rodata->nr_cpu_ids;
+
+		if (skel->rodata->pair_cpu[i] >= 0)
+			continue;
+
+		if (i == j) {
+			printf("\n");
+			fprintf(stderr, "Invalid stride %d - CPU%d wants to be its own pair\n",
+				stride, i);
+			return 1;
+		}
+
+		if (skel->rodata->pair_cpu[j] >= 0) {
+			printf("\n");
+			fprintf(stderr, "Invalid stride %d - three CPUs (%d, %d, %d) want to be a pair\n",
+				stride, i, j, skel->rodata->pair_cpu[j]);
+			return 1;
+		}
+
+		skel->rodata->pair_cpu[i] = j;
+		skel->rodata->pair_cpu[j] = i;
+		skel->rodata->pair_id[i] = i;
+		skel->rodata->pair_id[j] = i;
+		skel->rodata->in_pair_idx[i] = 0;
+		skel->rodata->in_pair_idx[j] = 1;
+
+		printf("[%d, %d] ", i, j);
+	}
+	printf("\n");
+
+	assert(!scx_pair__load(skel));
+
+	/*
+	 * Populate the cgrp_q_arr map which is an array containing per-cgroup
+	 * queues. It'd probably be better to do this from BPF but there are too
+	 * many to initialize statically and there's no way to dynamically
+	 * populate from BPF.
+	 */
+	outer_fd = bpf_map__fd(skel->maps.cgrp_q_arr);
+	assert(outer_fd >= 0);
+
+	printf("Initializing");
+        for (i = 0; i < MAX_CGRPS; i++) {
+		s32 inner_fd;
+
+		if (exit_req)
+			break;
+
+		inner_fd = bpf_map_create(BPF_MAP_TYPE_QUEUE, NULL, 0,
+					  sizeof(u32), MAX_QUEUED, NULL);
+		assert(inner_fd >= 0);
+		assert(!bpf_map_update_elem(outer_fd, &i, &inner_fd, BPF_ANY));
+		close(inner_fd);
+
+		if (!(i % 10))
+			printf(".");
+		fflush(stdout);
+        }
+	printf("\n");
+
+	/*
+	 * Fully initialized, attach and run.
+	 */
+	link = bpf_map__attach_struct_ops(skel->maps.pair_ops);
+	assert(link);
+
+	while (!exit_req && !uei_exited(&skel->bss->uei)) {
+		printf("[SEQ %lu]\n", seq++);
+		printf(" total:%10lu dispatch:%10lu   missing:%10lu\n",
+		       skel->bss->nr_total,
+		       skel->bss->nr_dispatched,
+		       skel->bss->nr_missing);
+		printf(" kicks:%10lu preemptions:%7lu\n",
+		       skel->bss->nr_kicks,
+		       skel->bss->nr_preemptions);
+		printf("   exp:%10lu exp_wait:%10lu exp_empty:%10lu\n",
+		       skel->bss->nr_exps,
+		       skel->bss->nr_exp_waits,
+		       skel->bss->nr_exp_empty);
+		printf("cgnext:%10lu   cgcoll:%10lu   cgempty:%10lu\n",
+		       skel->bss->nr_cgrp_next,
+		       skel->bss->nr_cgrp_coll,
+		       skel->bss->nr_cgrp_empty);
+		fflush(stdout);
+		sleep(1);
+	}
+
+	bpf_link__destroy(link);
+	uei_print(&skel->bss->uei);
+	scx_pair__destroy(skel);
+	return 0;
+}
diff --git a/tools/sched_ext/scx_pair.h b/tools/sched_ext/scx_pair.h
new file mode 100644
index 000000000000..f60b824272f7
--- /dev/null
+++ b/tools/sched_ext/scx_pair.h
@@ -0,0 +1,10 @@
+#ifndef __SCX_EXAMPLE_PAIR_H
+#define __SCX_EXAMPLE_PAIR_H
+
+enum {
+	MAX_CPUS		= 4096,
+	MAX_QUEUED		= 4096,
+	MAX_CGRPS		= 4096,
+};
+
+#endif /* __SCX_EXAMPLE_PAIR_H */
-- 
2.41.0

