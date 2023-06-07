Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C08D7251BE
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 03:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240635AbjFGBo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 21:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240507AbjFGBoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 21:44:17 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC4751BC2
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 18:44:15 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-56536dd5f79so111754477b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 18:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686102255; x=1688694255;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JJ5Trkf+zwJ+Qw/wPApXjMzIheakkK4FyusRcx5mBBo=;
        b=ECx+5clfS0XpvyLraFjIR93kikbwRhS4uD2PmePSls40y/2lPWUp9AmA/f2kl2mT6t
         EKcfdKepfqrxYekoTt83zl63nUFfM6tG96Yg+mEpCNP8pml0Cfy/anOzaFdbWYUvMg6I
         uxuTj1LTmltGGxXGmo0tCfOCTRpPbXBKuTYhKjdKdHZfUywYtSfiK+IKn4xDuXrkicKS
         hJfuuNnE0StKvFdlBb7X1TDMDcD2rxqUuAAGe4CMWk64pNnqHOmjr1oPdWcIBeOLzjLk
         PNV3OPhliVBP+XSibjLnrInnHHkDjofiWnLYW0qZg321zk09rfv0Kuc6qiuFyVz6EIin
         JVWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686102255; x=1688694255;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JJ5Trkf+zwJ+Qw/wPApXjMzIheakkK4FyusRcx5mBBo=;
        b=Ptabfma5p0w2sHqSWdURE1fWMwJ5DVkYvkmfK+9acPzcjFb8KFIfYyTOAaYzA6UMVb
         i9NAAhSZirrK1ITeMKhwPo4uuR1AQAdTm8bA6eQJQvKsmtgywnJ21QGkHvpekoSlZYzP
         P8dtGF2Vtyi5wnTIkF9cPw0JkJST6IGE2d8w+G1BKyNqvsKPkaD35MYaTs6IAA5dbOqH
         muXnG/eB2z61rGlsDEag2WMQ6QzMJMwXE2sA68nkiF377eaJW/8T/Q8XqOxGroOt8o1D
         ePh0jhtzN6H10VECJd85JWHLZI7TIkvV/ug9WN6dw4d2pPJqo+LsvnsjMfIcugJZVfos
         eV0Q==
X-Gm-Message-State: AC+VfDyQjcP9bvvC2hlIOXPFAYoXVdbN5rUAVFbCdXup8OvfPb6MXj5C
        eOJOQDWLcBCTpF8u50FR5pXjKHeNPsTv
X-Google-Smtp-Source: ACHHUZ76rg8WrUptE+/K1Hf5i+VQz8ETyzhQr+BRqQcU4eOUY4bp/axgfBMEzvwL3cITsPfWn1mIxOxl9WvN
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:3c35:209f:5d38:b7a1])
 (user=irogers job=sendgmr) by 2002:a81:b289:0:b0:562:837:122f with SMTP id
 q131-20020a81b289000000b005620837122fmr2020660ywh.9.1686102255131; Tue, 06
 Jun 2023 18:44:15 -0700 (PDT)
Date:   Tue,  6 Jun 2023 18:43:35 -0700
In-Reply-To: <20230607014353.3172466-1-irogers@google.com>
Message-Id: <20230607014353.3172466-3-irogers@google.com>
Mime-Version: 1.0
References: <20230607014353.3172466-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Subject: [PATCH v1 02/20] perf thread: Make threads rbtree non-invasive
From:   Ian Rogers <irogers@google.com>
To:     John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        German Gomez <german.gomez@arm.com>,
        Ali Saidi <alisaidi@amazon.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        "=?UTF-8?q?Martin=20Li=C5=A1ka?=" <mliska@suse.cz>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Liam Howlett <liam.howlett@oracle.com>,
        Dmitrii Dolgov <9erthalion6@gmail.com>,
        "Shawn M. Chapla" <schapla@codeweavers.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Changbin Du <changbin.du@huawei.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        Raul Silvera <rsilvera@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Steinar H. Gunderson" <sesse@google.com>,
        Yuan Can <yuancan@huawei.com>,
        Brian Robbins <brianrob@linux.microsoft.com>,
        liuwenyu <liuwenyu7@huawei.com>,
        Ivan Babrou <ivan@cloudflare.com>,
        Fangrui Song <maskray@google.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, coresight@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Separate the rbtree out of thread and into a new struct
thread_rb_node. The refcnt is in thread and the rbtree is responsible
for a single count.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-report.c |   2 +-
 tools/perf/builtin-trace.c  |   2 +-
 tools/perf/util/machine.c   | 101 +++++++++++++++++++++++-------------
 tools/perf/util/thread.c    |   3 --
 tools/perf/util/thread.h    |   6 ++-
 5 files changed, 73 insertions(+), 41 deletions(-)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 92c6797e7cba..c7d526283baf 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -911,7 +911,7 @@ static int tasks_print(struct report *rep, FILE *fp)
 		     nd = rb_next(nd)) {
 			task = tasks + itask++;
 
-			task->thread = rb_entry(nd, struct thread, rb_node);
+			task->thread = rb_entry(nd, struct thread_rb_node, rb_node)->thread;
 			INIT_LIST_HEAD(&task->children);
 			INIT_LIST_HEAD(&task->list);
 			thread__set_priv(task->thread, task);
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 62c7c99a0fe4..b0dd202d14eb 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -4348,7 +4348,7 @@ DEFINE_RESORT_RB(threads, (thread__nr_events(a->thread->priv) < thread__nr_event
 	struct thread *thread;
 )
 {
-	entry->thread = rb_entry(nd, struct thread, rb_node);
+	entry->thread = rb_entry(nd, struct thread_rb_node, rb_node)->thread;
 }
 
 static size_t trace__fprintf_thread_summary(struct trace *trace, FILE *fp)
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index a1954ac85f59..cbf092e32ee9 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -43,7 +43,8 @@
 #include <linux/string.h>
 #include <linux/zalloc.h>
 
-static void __machine__remove_thread(struct machine *machine, struct thread *th, bool lock);
+static void __machine__remove_thread(struct machine *machine, struct thread_rb_node *nd,
+				     struct thread *th, bool lock);
 static int append_inlines(struct callchain_cursor *cursor, struct map_symbol *ms, u64 ip);
 
 static struct dso *machine__kernel_dso(struct machine *machine)
@@ -72,6 +73,21 @@ static void machine__threads_init(struct machine *machine)
 	}
 }
 
+static int thread_rb_node__cmp_tid(const void *key, const struct rb_node *nd)
+{
+	int to_find = (int) *((pid_t *)key);
+
+	return to_find - (int)rb_entry(nd, struct thread_rb_node, rb_node)->thread->tid;
+}
+
+static struct thread_rb_node *thread_rb_node__find(const struct thread *th,
+						   struct rb_root *tree)
+{
+	struct rb_node *nd = rb_find(&th->tid, tree, thread_rb_node__cmp_tid);
+
+	return rb_entry(nd, struct thread_rb_node, rb_node);
+}
+
 static int machine__set_mmap_name(struct machine *machine)
 {
 	if (machine__is_host(machine))
@@ -214,10 +230,10 @@ void machine__delete_threads(struct machine *machine)
 		down_write(&threads->lock);
 		nd = rb_first_cached(&threads->entries);
 		while (nd) {
-			struct thread *t = rb_entry(nd, struct thread, rb_node);
+			struct thread_rb_node *trb = rb_entry(nd, struct thread_rb_node, rb_node);
 
 			nd = rb_next(nd);
-			__machine__remove_thread(machine, t, false);
+			__machine__remove_thread(machine, trb, trb->thread, false);
 		}
 		up_write(&threads->lock);
 	}
@@ -605,6 +621,7 @@ static struct thread *____machine__findnew_thread(struct machine *machine,
 	struct rb_node **p = &threads->entries.rb_root.rb_node;
 	struct rb_node *parent = NULL;
 	struct thread *th;
+	struct thread_rb_node *nd;
 	bool leftmost = true;
 
 	th = threads__get_last_match(threads, machine, pid, tid);
@@ -613,7 +630,7 @@ static struct thread *____machine__findnew_thread(struct machine *machine,
 
 	while (*p != NULL) {
 		parent = *p;
-		th = rb_entry(parent, struct thread, rb_node);
+		th = rb_entry(parent, struct thread_rb_node, rb_node)->thread;
 
 		if (th->tid == tid) {
 			threads__set_last_match(threads, th);
@@ -633,30 +650,39 @@ static struct thread *____machine__findnew_thread(struct machine *machine,
 		return NULL;
 
 	th = thread__new(pid, tid);
-	if (th != NULL) {
-		rb_link_node(&th->rb_node, parent, p);
-		rb_insert_color_cached(&th->rb_node, &threads->entries, leftmost);
+	if (th == NULL)
+		return NULL;
 
-		/*
-		 * We have to initialize maps separately after rb tree is updated.
-		 *
-		 * The reason is that we call machine__findnew_thread
-		 * within thread__init_maps to find the thread
-		 * leader and that would screwed the rb tree.
-		 */
-		if (thread__init_maps(th, machine)) {
-			rb_erase_cached(&th->rb_node, &threads->entries);
-			RB_CLEAR_NODE(&th->rb_node);
-			thread__put(th);
-			return NULL;
-		}
-		/*
-		 * It is now in the rbtree, get a ref
-		 */
-		thread__get(th);
-		threads__set_last_match(threads, th);
-		++threads->nr;
+	nd = malloc(sizeof(*nd));
+	if (nd == NULL) {
+		thread__put(th);
+		return NULL;
+	}
+	nd->thread = th;
+
+	rb_link_node(&nd->rb_node, parent, p);
+	rb_insert_color_cached(&nd->rb_node, &threads->entries, leftmost);
+
+	/*
+	 * We have to initialize maps separately after rb tree is updated.
+	 *
+	 * The reason is that we call machine__findnew_thread within
+	 * thread__init_maps to find the thread leader and that would screwed
+	 * the rb tree.
+	 */
+	if (thread__init_maps(th, machine)) {
+		rb_erase_cached(&nd->rb_node, &threads->entries);
+		RB_CLEAR_NODE(&nd->rb_node);
+		free(nd);
+		thread__put(th);
+		return NULL;
 	}
+	/*
+	 * It is now in the rbtree, get a ref
+	 */
+	thread__get(th);
+	threads__set_last_match(threads, th);
+	++threads->nr;
 
 	return th;
 }
@@ -1109,7 +1135,7 @@ size_t machine__fprintf(struct machine *machine, FILE *fp)
 
 		for (nd = rb_first_cached(&threads->entries); nd;
 		     nd = rb_next(nd)) {
-			struct thread *pos = rb_entry(nd, struct thread, rb_node);
+			struct thread *pos = rb_entry(nd, struct thread_rb_node, rb_node)->thread;
 
 			ret += thread__fprintf(pos, fp);
 		}
@@ -2020,10 +2046,14 @@ int machine__process_mmap_event(struct machine *machine, union perf_event *event
 	return 0;
 }
 
-static void __machine__remove_thread(struct machine *machine, struct thread *th, bool lock)
+static void __machine__remove_thread(struct machine *machine, struct thread_rb_node *nd,
+				     struct thread *th, bool lock)
 {
 	struct threads *threads = machine__threads(machine, th->tid);
 
+	if (!nd)
+		nd = thread_rb_node__find(th, &threads->entries.rb_root);
+
 	if (threads->last_match == th)
 		threads__set_last_match(threads, NULL);
 
@@ -2032,11 +2062,12 @@ static void __machine__remove_thread(struct machine *machine, struct thread *th,
 
 	BUG_ON(refcount_read(&th->refcnt) == 0);
 
-	rb_erase_cached(&th->rb_node, &threads->entries);
-	RB_CLEAR_NODE(&th->rb_node);
+	thread__put(nd->thread);
+	rb_erase_cached(&nd->rb_node, &threads->entries);
+	RB_CLEAR_NODE(&nd->rb_node);
 	--threads->nr;
 
-	thread__put(th);
+	free(nd);
 
 	if (lock)
 		up_write(&threads->lock);
@@ -2044,7 +2075,7 @@ static void __machine__remove_thread(struct machine *machine, struct thread *th,
 
 void machine__remove_thread(struct machine *machine, struct thread *th)
 {
-	return __machine__remove_thread(machine, th, true);
+	return __machine__remove_thread(machine, NULL, th, true);
 }
 
 int machine__process_fork_event(struct machine *machine, union perf_event *event,
@@ -3167,7 +3198,6 @@ int machine__for_each_thread(struct machine *machine,
 {
 	struct threads *threads;
 	struct rb_node *nd;
-	struct thread *thread;
 	int rc = 0;
 	int i;
 
@@ -3175,8 +3205,9 @@ int machine__for_each_thread(struct machine *machine,
 		threads = &machine->threads[i];
 		for (nd = rb_first_cached(&threads->entries); nd;
 		     nd = rb_next(nd)) {
-			thread = rb_entry(nd, struct thread, rb_node);
-			rc = fn(thread, priv);
+			struct thread_rb_node *trb = rb_entry(nd, struct thread_rb_node, rb_node);
+
+			rc = fn(trb->thread, priv);
 			if (rc != 0)
 				return rc;
 		}
diff --git a/tools/perf/util/thread.c b/tools/perf/util/thread.c
index d949bffc0ed6..38d300e3e4d3 100644
--- a/tools/perf/util/thread.c
+++ b/tools/perf/util/thread.c
@@ -66,7 +66,6 @@ struct thread *thread__new(pid_t pid, pid_t tid)
 
 		list_add(&comm->list, &thread->comm_list);
 		refcount_set(&thread->refcnt, 1);
-		RB_CLEAR_NODE(&thread->rb_node);
 		/* Thread holds first ref to nsdata. */
 		thread->nsinfo = nsinfo__new(pid);
 		srccode_state_init(&thread->srccode_state);
@@ -84,8 +83,6 @@ void thread__delete(struct thread *thread)
 	struct namespaces *namespaces, *tmp_namespaces;
 	struct comm *comm, *tmp_comm;
 
-	BUG_ON(!RB_EMPTY_NODE(&thread->rb_node));
-
 	thread_stack__free(thread);
 
 	if (thread->maps) {
diff --git a/tools/perf/util/thread.h b/tools/perf/util/thread.h
index 86737812e06b..3b3f9fb5a916 100644
--- a/tools/perf/util/thread.h
+++ b/tools/perf/util/thread.h
@@ -29,8 +29,12 @@ struct lbr_stitch {
 	struct callchain_cursor_node	*prev_lbr_cursor;
 };
 
+struct thread_rb_node {
+	struct rb_node rb_node;
+	struct thread *thread;
+};
+
 struct thread {
-	struct rb_node		rb_node;
 	struct maps		*maps;
 	pid_t			pid_; /* Not all tools update this */
 	pid_t			tid;
-- 
2.41.0.rc0.172.g3f132b7071-goog

