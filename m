Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 137CC728BD6
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 01:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237365AbjFHXb0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 19:31:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236296AbjFHXai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 19:30:38 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F5F73598
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 16:30:02 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-ba81b24b878so1544451276.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 16:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686267002; x=1688859002;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ICM4PzzdQpiNY9bNg8tMI2f6UHi152aJK3ihYGkS2Lc=;
        b=W4SQ7+xcYX6EMFelWxpkyco/G8WU+FJndMiWcsdzQGvTkiq0YyhE5WzDP2lp3BeAjm
         /xVv2zYOCCep5CHUk9+kYjRV2oA1/l+ATXVWHowmJxfA255rYr/Zouqj3Wtwl/gQ3Plk
         Hxd8FLXrmTzv/hb+AW4EyEpEya9b9Pnly0PDcVGeWSjr9EsQy7AFUYDIZEBjvTqexbAO
         vfmDalsbl0euAryMTdGZ0FoxeVln2gYnljOnOEPpup9FvsDg+ByXYuZA+T3miWW2k/cZ
         H01/5ZgSqD6l74GL7JVfvN/uiOkQ3ypeDQGIrBOIFWhuEVR6f30++SD/Z4XXSz9Skna1
         EQQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686267002; x=1688859002;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ICM4PzzdQpiNY9bNg8tMI2f6UHi152aJK3ihYGkS2Lc=;
        b=UJ9+Yn20LZ1zvwsM/T9QRNPfzXX8LCsVFNvaN7js3LEZjFHBq5VUrUWsENziybpxGw
         Ds+dq5tXCXHGfr96k82iEdV1tHHcEepAYIHmAhrAZ06k/6j/C4f1B1mR3Xs9APLF7/8T
         WI1GYJvZ99WYgR0SRP81YAQgGuLLz8s3/N0uS6Wh/TaR63KYe3uE00BQYEb5lzOuDQ2J
         ijpV9Qxf8aZxfH96hz2NCQSSkOTKSnqM5oLeGxGzOK/upFrP+A2Gw6uhPm3zAO1vbeau
         nzO3ooJ0yQHnL0kCbRyc3wSIYzdRz2LX18c3U3qtzO7g4Gp+ovDWOCI6t+QAcV7weMEt
         yQsg==
X-Gm-Message-State: AC+VfDwwwkERJiYGE27G6gmgQ3wj77nulimiPVIzVDXRvGa61MLvg0nQ
        7E6EchDpZjGTTHCzy8NNRnWLgDhrvmpX
X-Google-Smtp-Source: ACHHUZ4AZm4uKUIg8KKxAHmokqtp8JqUnmhXm0gePazMoCbE9TBXxkaQBbhvWmzgMSkIsOrL28dplH6fOi9k
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:c3e5:ebc6:61e5:c73f])
 (user=irogers job=sendgmr) by 2002:a25:ae01:0:b0:bb6:c0d2:2451 with SMTP id
 a1-20020a25ae01000000b00bb6c0d22451mr348578ybj.6.1686267001758; Thu, 08 Jun
 2023 16:30:01 -0700 (PDT)
Date:   Thu,  8 Jun 2023 16:28:17 -0700
In-Reply-To: <20230608232823.4027869-1-irogers@google.com>
Message-Id: <20230608232823.4027869-21-irogers@google.com>
Mime-Version: 1.0
References: <20230608232823.4027869-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Subject: [PATCH v2 20/26] perf map/maps/thread: Changes to reference counting
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

Fix missed reference count gets and puts as detected with leak
sanitizer and reference count checking.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/callchain.c | 28 ++++++++++++++++++++++------
 tools/perf/util/event.c     |  3 +++
 tools/perf/util/hist.c      |  6 ++++--
 tools/perf/util/machine.c   | 29 +++++++++++++++++------------
 4 files changed, 46 insertions(+), 20 deletions(-)

diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
index b0dafc758173..909f62b3b266 100644
--- a/tools/perf/util/callchain.c
+++ b/tools/perf/util/callchain.c
@@ -590,6 +590,7 @@ fill_node(struct callchain_node *node, struct callchain_cursor *cursor)
 		call->ip = cursor_node->ip;
 		call->ms = cursor_node->ms;
 		call->ms.map = map__get(call->ms.map);
+		call->ms.maps = maps__get(call->ms.maps);
 		call->srcline = cursor_node->srcline;
 
 		if (cursor_node->branch) {
@@ -649,6 +650,7 @@ add_child(struct callchain_node *parent,
 		list_for_each_entry_safe(call, tmp, &new->val, list) {
 			list_del_init(&call->list);
 			map__zput(call->ms.map);
+			maps__zput(call->ms.maps);
 			free(call);
 		}
 		free(new);
@@ -1010,10 +1012,16 @@ merge_chain_branch(struct callchain_cursor *cursor,
 	int err = 0;
 
 	list_for_each_entry_safe(list, next_list, &src->val, list) {
-		callchain_cursor_append(cursor, list->ip, &list->ms,
-					false, NULL, 0, 0, 0, list->srcline);
+		struct map_symbol ms = {
+			.maps = maps__get(list->ms.maps),
+			.map = map__get(list->ms.map),
+		};
+		callchain_cursor_append(cursor, list->ip, &ms, false, NULL, 0, 0, 0, list->srcline);
 		list_del_init(&list->list);
+		map__zput(ms.map);
+		maps__zput(ms.maps);
 		map__zput(list->ms.map);
+		maps__zput(list->ms.maps);
 		free(list);
 	}
 
@@ -1065,9 +1073,11 @@ int callchain_cursor_append(struct callchain_cursor *cursor,
 	}
 
 	node->ip = ip;
+	maps__zput(node->ms.maps);
 	map__zput(node->ms.map);
 	node->ms = *ms;
-	node->ms.map = map__get(node->ms.map);
+	node->ms.maps = maps__get(ms->maps);
+	node->ms.map = map__get(ms->map);
 	node->branch = branch;
 	node->nr_loop_iter = nr_loop_iter;
 	node->iter_cycles = iter_cycles;
@@ -1114,7 +1124,8 @@ int fill_callchain_info(struct addr_location *al, struct callchain_cursor_node *
 {
 	struct machine *machine = maps__machine(node->ms.maps);
 
-	al->maps = node->ms.maps;
+	maps__put(al->maps);
+	al->maps = maps__get(node->ms.maps);
 	map__put(al->map);
 	al->map = map__get(node->ms.map);
 	al->sym = node->ms.sym;
@@ -1127,7 +1138,7 @@ int fill_callchain_info(struct addr_location *al, struct callchain_cursor_node *
 		if (al->map == NULL)
 			goto out;
 	}
-	if (al->maps == machine__kernel_maps(machine)) {
+	if (RC_CHK_ACCESS(al->maps) == RC_CHK_ACCESS(machine__kernel_maps(machine))) {
 		if (machine__is_host(machine)) {
 			al->cpumode = PERF_RECORD_MISC_KERNEL;
 			al->level = 'k';
@@ -1460,12 +1471,14 @@ static void free_callchain_node(struct callchain_node *node)
 	list_for_each_entry_safe(list, tmp, &node->parent_val, list) {
 		list_del_init(&list->list);
 		map__zput(list->ms.map);
+		maps__zput(list->ms.maps);
 		free(list);
 	}
 
 	list_for_each_entry_safe(list, tmp, &node->val, list) {
 		list_del_init(&list->list);
 		map__zput(list->ms.map);
+		maps__zput(list->ms.maps);
 		free(list);
 	}
 
@@ -1551,6 +1564,7 @@ int callchain_node__make_parent_list(struct callchain_node *node)
 	list_for_each_entry_safe(chain, new, &head, list) {
 		list_del_init(&chain->list);
 		map__zput(chain->ms.map);
+		maps__zput(chain->ms.maps);
 		free(chain);
 	}
 	return -ENOMEM;
@@ -1596,8 +1610,10 @@ void callchain_cursor_reset(struct callchain_cursor *cursor)
 	cursor->nr = 0;
 	cursor->last = &cursor->first;
 
-	for (node = cursor->first; node != NULL; node = node->next)
+	for (node = cursor->first; node != NULL; node = node->next) {
 		map__zput(node->ms.map);
+		maps__zput(node->ms.maps);
+	}
 }
 
 void callchain_param_setup(u64 sample_type, const char *arch)
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index 2fcfba38fc48..3860b0c74829 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -711,6 +711,9 @@ int machine__resolve(struct machine *machine, struct addr_location *al,
 	if (thread__is_filtered(thread))
 		al->filtered |= (1 << HIST_FILTER__THREAD);
 
+	thread__put(thread);
+	thread = NULL;
+
 	al->sym = NULL;
 	al->cpu = sample->cpu;
 	al->socket = -1;
diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index dfda52d348a3..fb218b3e8a7c 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -450,6 +450,7 @@ static int hist_entry__init(struct hist_entry *he,
 			memset(&he->stat, 0, sizeof(he->stat));
 	}
 
+	he->ms.maps = maps__get(he->ms.maps);
 	he->ms.map = map__get(he->ms.map);
 
 	if (he->branch_info) {
@@ -497,7 +498,7 @@ static int hist_entry__init(struct hist_entry *he,
 	}
 
 	INIT_LIST_HEAD(&he->pairs.node);
-	thread__get(he->thread);
+	he->thread = thread__get(he->thread);
 	he->hroot_in  = RB_ROOT_CACHED;
 	he->hroot_out = RB_ROOT_CACHED;
 
@@ -523,6 +524,7 @@ static int hist_entry__init(struct hist_entry *he,
 		map__put(he->mem_info->daddr.ms.map);
 	}
 err:
+	maps__zput(he->ms.maps);
 	map__zput(he->ms.map);
 	zfree(&he->stat_acc);
 	return -ENOMEM;
@@ -611,7 +613,6 @@ static struct hist_entry *hists__findnew_entry(struct hists *hists,
 		 * keys were used.
 		 */
 		cmp = hist_entry__cmp(he, entry);
-
 		if (!cmp) {
 			if (sample_self) {
 				he_stat__add_period(&he->stat, period);
@@ -1309,6 +1310,7 @@ void hist_entry__delete(struct hist_entry *he)
 	struct hist_entry_ops *ops = he->ops;
 
 	thread__zput(he->thread);
+	maps__zput(he->ms.maps);
 	map__zput(he->ms.map);
 
 	if (he->branch_info) {
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 359ef6b4e840..bdad4b8bf77d 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -539,7 +539,7 @@ static void machine__update_thread_pid(struct machine *machine,
 		goto out_err;
 
 	if (thread__maps(th) == thread__maps(leader))
-		return;
+		goto out_put;
 
 	if (thread__maps(th)) {
 		/*
@@ -579,7 +579,7 @@ __threads__get_last_match(struct threads *threads, struct machine *machine,
 			machine__update_thread_pid(machine, th, pid);
 			return thread__get(th);
 		}
-
+		thread__put(threads->last_match);
 		threads->last_match = NULL;
 	}
 
@@ -601,7 +601,8 @@ threads__get_last_match(struct threads *threads, struct machine *machine,
 static void
 __threads__set_last_match(struct threads *threads, struct thread *th)
 {
-	threads->last_match = th;
+	thread__put(threads->last_match);
+	threads->last_match = thread__get(th);
 }
 
 static void
@@ -664,7 +665,6 @@ static struct thread *____machine__findnew_thread(struct machine *machine,
 
 	rb_link_node(&nd->rb_node, parent, p);
 	rb_insert_color_cached(&nd->rb_node, &threads->entries, leftmost);
-
 	/*
 	 * We have to initialize maps separately after rb tree is updated.
 	 *
@@ -673,6 +673,7 @@ static struct thread *____machine__findnew_thread(struct machine *machine,
 	 * the rb tree.
 	 */
 	if (thread__init_maps(th, machine)) {
+		pr_err("Thread init failed thread %d\n", pid);
 		rb_erase_cached(&nd->rb_node, &threads->entries);
 		RB_CLEAR_NODE(&nd->rb_node);
 		free(nd);
@@ -682,11 +683,10 @@ static struct thread *____machine__findnew_thread(struct machine *machine,
 	/*
 	 * It is now in the rbtree, get a ref
 	 */
-	thread__get(th);
 	threads__set_last_match(threads, th);
 	++threads->nr;
 
-	return th;
+	return thread__get(th);
 }
 
 struct thread *__machine__findnew_thread(struct machine *machine, pid_t pid, pid_t tid)
@@ -2321,7 +2321,7 @@ static int add_callchain_ip(struct thread *thread,
 			    struct iterations *iter,
 			    u64 branch_from)
 {
-	struct map_symbol ms;
+	struct map_symbol ms = {};
 	struct addr_location al;
 	int nr_loop_iter = 0, err = 0;
 	u64 iter_cycles = 0;
@@ -2395,6 +2395,8 @@ static int add_callchain_ip(struct thread *thread,
 				      iter_cycles, branch_from, srcline);
 out:
 	addr_location__exit(&al);
+	maps__put(ms.maps);
+	map__put(ms.map);
 	return err;
 }
 
@@ -3089,6 +3091,7 @@ static int append_inlines(struct callchain_cursor *cursor, struct map_symbol *ms
 	struct dso *dso;
 	u64 addr;
 	int ret = 1;
+	struct map_symbol ilist_ms;
 
 	if (!symbol_conf.inline_name || !map || !sym)
 		return ret;
@@ -3105,18 +3108,20 @@ static int append_inlines(struct callchain_cursor *cursor, struct map_symbol *ms
 		inlines__tree_insert(&dso->inlined_nodes, inline_node);
 	}
 
+	ilist_ms = (struct map_symbol) {
+		.maps = maps__get(ms->maps),
+		.map = map__get(map),
+	};
 	list_for_each_entry(ilist, &inline_node->val, list) {
-		struct map_symbol ilist_ms = {
-			.maps = ms->maps,
-			.map = map,
-			.sym = ilist->symbol,
-		};
+		ilist_ms.sym = ilist->symbol;
 		ret = callchain_cursor_append(cursor, ip, &ilist_ms, false,
 					      NULL, 0, 0, 0, ilist->srcline);
 
 		if (ret != 0)
 			return ret;
 	}
+	map__put(ilist_ms.map);
+	maps__put(ilist_ms.maps);
 
 	return ret;
 }
-- 
2.41.0.162.gfafddb0af9-goog

