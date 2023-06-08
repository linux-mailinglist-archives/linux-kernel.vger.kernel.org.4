Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD4A728BC3
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 01:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237189AbjFHX3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 19:29:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236417AbjFHX3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 19:29:18 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 006C030E6
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 16:29:16 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-561eb6c66f6so15567747b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 16:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686266956; x=1688858956;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ymnu/Vh789GfEOnzVpYprmKEH//VXYvaO1C6m6tLSA0=;
        b=pMSj7Ub+6mggNvEGxkdRszmf2MR1mNcKbiXbHyO+YlRxOoMzO2pRequho83r+bBf/I
         cBWn2zjyhiXt3ThfivITYJApq2Ft1QCg9S8IH9WZPZkGqy4u/uyB/IB5OWc0iiYr7EpW
         csXvR+0Sz7qKHkIRrrQ7Dv6+tzaTz8BkY3KRrQyXeHFv5JV4DONx4HXXBATZUeW1/Nvk
         AQs7WZNIKJ0ByeZeukd5Xgk4fkRtFPj4jGn+nlLgTdqq4F6Np1MotVYBHVbI6BXH2D15
         s2J/JRwTvk/Bt9oksqYcOTykoU57gRI8OGtX3+/7tHPeJ570ajQ/1d3Wg/o3WjIP0bYV
         o4EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686266956; x=1688858956;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ymnu/Vh789GfEOnzVpYprmKEH//VXYvaO1C6m6tLSA0=;
        b=XCr171v8J31+XmL2aQ2twcrVzVncYyNkoT3lQnxsDB8IkXw8fAcLTaMDsIOExaS3pQ
         7b54Fxp6zGYznBspd2q5NLQJL7rIk3bRleyf6pQ2hcwN2PKr+Oj4gSEd5lHD5jUOQolW
         Bh80h5aifddmJCSM8L216R655nCnHoJDZzInYaQBZRe4lINhqCQTNIU9z/AaUIoa4KLO
         F/5gVX4uhkDfh9ugot8FsedXekM16r+oPSq7XLARQjeLHQuQOqQbdTj5Rc5HzxycttbC
         ynth5sgKlvY2Oe3iIpCukzNaOSP3y9+8VGpKsY8vdeYYbeMZ9CkSiGpOXsAbnw7s/g9g
         vlOA==
X-Gm-Message-State: AC+VfDxdl3yw25z/0Iyqm6ZgNSMZ4NMnq4nedUZ2f55bNnB9rGUHQkuy
        qBlesekAA5qgudEmR8b37QQaxE76ilPZ
X-Google-Smtp-Source: ACHHUZ5i/+bckY1F3BVJityBZtENtui7ryds3PgsPmPbW4Zj1MTXKkbG1FZ038KzAc0HXgDF+4Zdk0bhUCur
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:c3e5:ebc6:61e5:c73f])
 (user=irogers job=sendgmr) by 2002:a81:a745:0:b0:567:289c:2642 with SMTP id
 e66-20020a81a745000000b00567289c2642mr684171ywh.10.1686266956242; Thu, 08 Jun
 2023 16:29:16 -0700 (PDT)
Date:   Thu,  8 Jun 2023 16:27:59 -0700
In-Reply-To: <20230608232823.4027869-1-irogers@google.com>
Message-Id: <20230608232823.4027869-3-irogers@google.com>
Mime-Version: 1.0
References: <20230608232823.4027869-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Subject: [PATCH v2 02/26] perf thread: Make threads rbtree non-invasive
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
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Liam Howlett <liam.howlett@oracle.com>,
        Dmitrii Dolgov <9erthalion6@gmail.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Changbin Du <changbin.du@huawei.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Sean Christopherson <seanjc@google.com>,
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
2.41.0.162.gfafddb0af9-goog

