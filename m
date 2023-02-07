Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C14A68CB15
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 01:24:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbjBGAYY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 19:24:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbjBGAYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 19:24:19 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8750331E30;
        Mon,  6 Feb 2023 16:24:10 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id rm7-20020a17090b3ec700b0022c05558d22so13089082pjb.5;
        Mon, 06 Feb 2023 16:24:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P9sShE61TSArb/nEuS124KBODim/DGmiNXlZC4Mp9U0=;
        b=QzR+Zmc9ckngA12uJ8IuZ3lCO7HLJmcHvrIuKT6gi8gXsS1aUhdgwAM9Ss6YfMIv60
         LLHjSByaScdNp/+N2ntSIIm1wxX3Ma8YrXbVaPGnYyBuGViuYxpu+SvKwsyclOOZ4ony
         Qw6iJZYzJ4xDkuBb93Yeb3xAmnxGHEBx+wPwKVZQrRw/3Zcf6kvWm9LrpZX02tXkELyT
         wL/6qG073ja8gAe3BsCWur2IEBTteQkNYMUkwxFF8dbhO43xu74Xzesq6alkTxt74pgC
         qSvH9kBFmN36XD77zutpr/rjq5RlwZFOgqq1JCki1IHYOcuABcg1fU8ncODFaQWZmnYu
         u6QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=P9sShE61TSArb/nEuS124KBODim/DGmiNXlZC4Mp9U0=;
        b=xyJdBCJRHUS2UlU1o+INNWd6myZjsaSVqHXRewYK9Xk0OcPVg534jhvnOwxSz/48dS
         MVBo/OOB2mSxQeKQGMPeCT2Pk9M2I8SWuKeul2Bx+gRMuosyNqAHnMXK7L3hW8SgsxBQ
         pdj3anDQ8JZls7X0e+QkLd5FMzGN1W/24lL3fzMdyPsxRwHP9bhGK0Rif+xvu2W20KlF
         7MiX/CjTv/lIFXMBAcYbi9pYSLjdHrnoKz5jD8zdDRhV/RAvixzExauF9He9b7zfEDk/
         uJimdnrGOP+VCV51zPzNBvte9aFq04u9slaNkxCGK9v6Meo40A17lbUZimhHN+3E4uLG
         T8iA==
X-Gm-Message-State: AO0yUKUIVPfc08+ArRhua6dgcstopzqbPH9SfQHfFE4T61/Qy9ac3hD2
        /C6qS1VxHm/t0hN9kWRlCZE=
X-Google-Smtp-Source: AK7set8OEwDrC4Xnq8eKyrPC9uoZHXP653QOrshj7Phom9h8X/wR2eUYHXqOZ8n1Cp9rkoBYsz+Tqg==
X-Received: by 2002:a17:903:2289:b0:199:190c:3c15 with SMTP id b9-20020a170903228900b00199190c3c15mr736965plh.49.1675729449792;
        Mon, 06 Feb 2023 16:24:09 -0800 (PST)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:ff0:47cc:64dd:1572:cf18])
        by smtp.gmail.com with ESMTPSA id y1-20020a1709029b8100b00189b2b8dbedsm3544080plp.228.2023.02.06.16.24.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 16:24:09 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>,
        bpf@vger.kernel.org
Subject: [PATCH 2/3] perf lock contention: Add -o/--lock-owner option
Date:   Mon,  6 Feb 2023 16:24:02 -0800
Message-Id: <20230207002403.63590-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.39.1.519.gcb327c4b5f-goog
In-Reply-To: <20230207002403.63590-1-namhyung@kernel.org>
References: <20230207002403.63590-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When there're many lock contentions in the system, people sometimes
want to know who caused the contention, IOW who's the owner of the
locks.

The -o/--lock-owner option tries to follow the lock owners for the
contended mutexes and rwsems from BPF, and then attributes the
contention time to the owner instead of the waiter.  It's a best
effort approach to get the owner info at the time of the contention
and doesn't guarantee to have the precise tracking of owners if it's
changing over time.

Currently it only handles mutex and rwsem that have owner field in
their struct and it basically points to a task_struct that owns the
lock at the moment.

Technically its type is atomic_long_t and it comes with some LSB bits
used for other meaninigs.  So it needs to clear them when casting it
to a pointer to task_struct.

Also the atomic_long_t is a typedef of the atomic 32 or 64 bit types
depending on arch which is a wrapper struct for the counter value.
I'm not aware of proper ways to access those kernel atomic types from
BPF so I just read the internal counter value directly.  Please let me
know if there's a better way.

When -o/--lock-owner option is used, it goes to the task aggregation
mode like -t/--threads option does.  However it cannot get the owner
for other lock types like spinlock and sometimes even for mutex.

  $ sudo ./perf lock con -abo -- ./perf bench sched pipe
  # Running 'sched/pipe' benchmark:
  # Executed 1000000 pipe operations between two processes

       Total time: 4.766 [sec]

         4.766540 usecs/op
           209795 ops/sec
   contended   total wait     max wait     avg wait          pid   owner

         403    565.32 us     26.81 us      1.40 us           -1   Unknown
           4     27.99 us      8.57 us      7.00 us      1583145   sched-pipe
           1      8.25 us      8.25 us      8.25 us      1583144   sched-pipe
           1      2.03 us      2.03 us      2.03 us         5068   chrome

As you can see, the owner is unknown for the most cases.  But if we
filter only for the mutex locks, it'd more likely get the onwers.

  $ sudo ./perf lock con -abo -Y mutex -- ./perf bench sched pipe
  # Running 'sched/pipe' benchmark:
  # Executed 1000000 pipe operations between two processes

       Total time: 4.910 [sec]

         4.910435 usecs/op
           203647 ops/sec
   contended   total wait     max wait     avg wait          pid   owner

           2     15.50 us      8.29 us      7.75 us      1582852   sched-pipe
           7      7.20 us      2.47 us      1.03 us           -1   Unknown
           1      6.74 us      6.74 us      6.74 us      1582851   sched-pipe

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/Documentation/perf-lock.txt        |  5 ++
 tools/perf/builtin-lock.c                     | 49 ++++++++++++---
 tools/perf/util/bpf_lock_contention.c         |  1 +
 .../perf/util/bpf_skel/lock_contention.bpf.c  | 60 +++++++++++++++++--
 tools/perf/util/lock-contention.h             |  1 +
 5 files changed, 102 insertions(+), 14 deletions(-)

diff --git a/tools/perf/Documentation/perf-lock.txt b/tools/perf/Documentation/perf-lock.txt
index 11b8901d8d13..37aae194a2a1 100644
--- a/tools/perf/Documentation/perf-lock.txt
+++ b/tools/perf/Documentation/perf-lock.txt
@@ -172,6 +172,11 @@ CONTENTION OPTIONS
 --lock-addr::
 	Show lock contention stat by address
 
+-o::
+--lock-owner::
+	Show lock contention stat by owners.  Implies --threads and
+	requires --use-bpf.
+
 -Y::
 --type-filter=<value>::
 	Show lock contention only for given lock types (comma separated list).
diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index a4b5c481129c..054997edd98b 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -58,6 +58,7 @@ static struct rb_root		thread_stats;
 static bool combine_locks;
 static bool show_thread_stats;
 static bool show_lock_addrs;
+static bool show_lock_owner;
 static bool use_bpf;
 static unsigned long bpf_map_entries = 10240;
 static int max_stack_depth = CONTENTION_STACK_DEPTH;
@@ -1616,7 +1617,8 @@ static void print_contention_result(struct lock_contention *con)
 
 		switch (aggr_mode) {
 		case LOCK_AGGR_TASK:
-			pr_info("  %10s   %s\n\n", "pid", "comm");
+			pr_info("  %10s   %s\n\n", "pid",
+				show_lock_owner ? "owner" : "comm");
 			break;
 		case LOCK_AGGR_CALLER:
 			pr_info("  %10s   %s\n\n", "type", "caller");
@@ -1656,7 +1658,8 @@ static void print_contention_result(struct lock_contention *con)
 		case LOCK_AGGR_TASK:
 			pid = st->addr;
 			t = perf_session__findnew(session, pid);
-			pr_info("  %10d   %s\n", pid, thread__comm_str(t));
+			pr_info("  %10d   %s\n",
+				pid, pid == -1 ? "Unknown" : thread__comm_str(t));
 			break;
 		case LOCK_AGGR_ADDR:
 			pr_info("  %016llx   %s\n", (unsigned long long)st->addr,
@@ -1768,6 +1771,37 @@ static void sighandler(int sig __maybe_unused)
 {
 }
 
+static int check_lock_contention_options(const struct option *options,
+					 const char * const *usage)
+
+{
+	if (show_thread_stats && show_lock_addrs) {
+		pr_err("Cannot use thread and addr mode together\n");
+		parse_options_usage(usage, options, "threads", 0);
+		parse_options_usage(NULL, options, "lock-addr", 0);
+		return -1;
+	}
+
+	if (show_lock_owner && !use_bpf) {
+		pr_err("Lock owners are available only with BPF\n");
+		parse_options_usage(usage, options, "lock-owner", 0);
+		parse_options_usage(NULL, options, "use-bpf", 0);
+		return -1;
+	}
+
+	if (show_lock_owner && show_lock_addrs) {
+		pr_err("Cannot use owner and addr mode together\n");
+		parse_options_usage(usage, options, "lock-owner", 0);
+		parse_options_usage(NULL, options, "lock-addr", 0);
+		return -1;
+	}
+
+	if (show_lock_owner)
+		show_thread_stats = true;
+
+	return 0;
+}
+
 static int __cmd_contention(int argc, const char **argv)
 {
 	int err = -EINVAL;
@@ -1793,6 +1827,7 @@ static int __cmd_contention(int argc, const char **argv)
 		.stack_skip = stack_skip,
 		.filters = &filters,
 		.save_callstack = needs_callstack(),
+		.owner = show_lock_owner,
 	};
 
 	session = perf_session__new(use_bpf ? NULL : &data, &eops);
@@ -2272,6 +2307,7 @@ int cmd_lock(int argc, const char **argv)
 		     "Filter specific address/symbol of locks", parse_lock_addr),
 	OPT_CALLBACK('S', "callstack-filter", NULL, "NAMES",
 		     "Filter specific function in the callstack", parse_call_stack),
+	OPT_BOOLEAN('o', "lock-owner", &show_lock_owner, "show lock owners instead of waiters"),
 	OPT_PARENT(lock_options)
 	};
 
@@ -2342,14 +2378,9 @@ int cmd_lock(int argc, const char **argv)
 					     contention_usage, 0);
 		}
 
-		if (show_thread_stats && show_lock_addrs) {
-			pr_err("Cannot use thread and addr mode together\n");
-			parse_options_usage(contention_usage, contention_options,
-					    "threads", 0);
-			parse_options_usage(NULL, contention_options,
-					    "lock-addr", 0);
+		if (check_lock_contention_options(contention_options,
+						  contention_usage) < 0)
 			return -1;
-		}
 
 		rc = __cmd_contention(argc, argv);
 	} else {
diff --git a/tools/perf/util/bpf_lock_contention.c b/tools/perf/util/bpf_lock_contention.c
index 72cf81114982..fadcacb9d501 100644
--- a/tools/perf/util/bpf_lock_contention.c
+++ b/tools/perf/util/bpf_lock_contention.c
@@ -149,6 +149,7 @@ int lock_contention_prepare(struct lock_contention *con)
 	skel->bss->stack_skip = con->stack_skip;
 	skel->bss->aggr_mode = con->aggr_mode;
 	skel->bss->needs_callstack = con->save_callstack;
+	skel->bss->lock_owner = con->owner;
 
 	lock_contention_bpf__attach(skel);
 	return 0;
diff --git a/tools/perf/util/bpf_skel/lock_contention.bpf.c b/tools/perf/util/bpf_skel/lock_contention.bpf.c
index 7ce276ed987e..c5556606134e 100644
--- a/tools/perf/util/bpf_skel/lock_contention.bpf.c
+++ b/tools/perf/util/bpf_skel/lock_contention.bpf.c
@@ -10,6 +10,14 @@
 /* default buffer size */
 #define MAX_ENTRIES  10240
 
+/* lock contention flags from include/trace/events/lock.h */
+#define LCB_F_SPIN	(1U << 0)
+#define LCB_F_READ	(1U << 1)
+#define LCB_F_WRITE	(1U << 2)
+#define LCB_F_RT	(1U << 3)
+#define LCB_F_PERCPU	(1U << 4)
+#define LCB_F_MUTEX	(1U << 5)
+
 struct tstamp_data {
 	__u64 timestamp;
 	__u64 lock;
@@ -84,6 +92,7 @@ int has_type;
 int has_addr;
 int needs_callstack;
 int stack_skip;
+int lock_owner;
 
 /* determine the key of lock stat */
 int aggr_mode;
@@ -132,17 +141,24 @@ static inline int can_record(u64 *ctx)
 	return 1;
 }
 
-static inline void update_task_data(__u32 pid)
+static inline int update_task_data(struct task_struct *task)
 {
 	struct contention_task_data *p;
+	int pid, err;
+
+	err = bpf_core_read(&pid, sizeof(pid), &task->pid);
+	if (err)
+		return -1;
 
 	p = bpf_map_lookup_elem(&task_data, &pid);
 	if (p == NULL) {
-		struct contention_task_data data;
+		struct contention_task_data data = {};
 
-		bpf_get_current_comm(data.comm, sizeof(data.comm));
+		BPF_CORE_READ_STR_INTO(&data.comm, task, comm);
 		bpf_map_update_elem(&task_data, &pid, &data, BPF_NOEXIST);
 	}
+
+	return 0;
 }
 
 SEC("tp_btf/contention_begin")
@@ -179,6 +195,38 @@ int contention_begin(u64 *ctx)
 						  BPF_F_FAST_STACK_CMP | stack_skip);
 		if (pelem->stack_id < 0)
 			lost++;
+	} else if (aggr_mode == LOCK_AGGR_TASK) {
+		struct task_struct *task;
+
+		if (lock_owner) {
+			if (pelem->flags & LCB_F_MUTEX) {
+				struct mutex *lock = (void *)pelem->lock;
+				unsigned long owner = BPF_CORE_READ(lock, owner.counter);
+
+				task = (void *)(owner & ~7UL);
+			} else if (pelem->flags == LCB_F_READ || pelem->flags == LCB_F_WRITE) {
+				struct rw_semaphore *lock = (void *)pelem->lock;
+				unsigned long owner = BPF_CORE_READ(lock, owner.counter);
+
+				task = (void *)(owner & ~7UL);
+			} else {
+				task = NULL;
+			}
+
+			/* The flags is not used anymore.  Pass the owner pid. */
+			if (task)
+				pelem->flags = BPF_CORE_READ(task, pid);
+			else
+				pelem->flags = -1U;
+
+		} else {
+			task = bpf_get_current_task_btf();
+		}
+
+		if (task) {
+			if (update_task_data(task) < 0 && lock_owner)
+				pelem->flags = -1U;
+		}
 	}
 
 	return 0;
@@ -208,8 +256,10 @@ int contention_end(u64 *ctx)
 		key.stack_id = pelem->stack_id;
 		break;
 	case LOCK_AGGR_TASK:
-		key.pid = pid;
-		update_task_data(pid);
+		if (lock_owner)
+			key.pid = pelem->flags;
+		else
+			key.pid = pid;
 		if (needs_callstack)
 			key.stack_id = pelem->stack_id;
 		break;
diff --git a/tools/perf/util/lock-contention.h b/tools/perf/util/lock-contention.h
index e5fc036108ec..040b618b2215 100644
--- a/tools/perf/util/lock-contention.h
+++ b/tools/perf/util/lock-contention.h
@@ -133,6 +133,7 @@ struct lock_contention {
 	int max_stack;
 	int stack_skip;
 	int aggr_mode;
+	int owner;
 	bool save_callstack;
 };
 
-- 
2.39.1.519.gcb327c4b5f-goog

