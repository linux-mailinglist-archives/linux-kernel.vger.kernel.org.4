Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B265D72A361
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 21:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232003AbjFITtf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 15:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231959AbjFITtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 15:49:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8B6B1FEC;
        Fri,  9 Jun 2023 12:49:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3784065AEE;
        Fri,  9 Jun 2023 19:49:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DD04C433D2;
        Fri,  9 Jun 2023 19:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686340166;
        bh=iJi4ALVAq/3ioZTaaJrPkSC4vqGKvQsSwSDA51kge/0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qupH/+6kQvuQnlPLzBG49Yn6fOp7Teawbf1UQdBtIMIUe4vHMxca43jc6AwXx+QcM
         B0cBaymaOkee1HszzFHAfbU08CjYdr4PIhFx6qh1fB8ihulxsBq8RTb63s7/IBEPmr
         q7Yx2PdwR6qcF259N18mElzUUwGh6hwzXW86CeHLFTKCkxA0D0ajn3vx3DxScMGymt
         d3D/mf99eAX+UJmXdTue/QBqkSME2B1/3ozDnw3W7S5DiZGmBy2jzD6x9JJzT/xzmU
         PUwGaPdLEsuV3gIkK/zjlrfH7+wT0OsOFlv+jc+1vysNzc9wjkmK37xi2KbCTjmDW4
         ch0mBFM0MOrzw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 9FF0E40692; Fri,  9 Jun 2023 16:49:23 -0300 (-03)
Date:   Fri, 9 Jun 2023 16:49:23 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
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
Subject: Re: [PATCH v2 24/26] perf callchain: Use pthread keys for tls
 callchain_cursor
Message-ID: <ZIOCQ0Sf1SL4xj7t@kernel.org>
References: <20230608232823.4027869-1-irogers@google.com>
 <20230608232823.4027869-25-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230608232823.4027869-25-irogers@google.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Jun 08, 2023 at 04:28:21PM -0700, Ian Rogers escreveu:
> Pthread keys are more portable than __thread and allow the association
> of a destructor with the key. Use the destructor to clean up TLS
> callchain cursors to aid understanding memory leaks.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>

Had to add this, and added this to the cset commit log:

    Committer notes:

    Had to fixup a series of unconverted places and also check for the
    return of get_tls_callchain_cursor() as it may fail and return NULL.

    In that unlikely case we now either print something to a file, if the
    caller was expecting to print a callchain, or return an error code to
    state that resolving the callchain isn't possible.

    In some cases this was made easier because thread__resolve_callchain()
    already can fail for other reasons, so this new one (cursor == NULL) can
    be added and the callers don't have to explicitely check for this new
    condition.

Now building it with the containers, will continue reviewing, more eyes
on this would be most welcome...

- Arnaldo

diff --git a/tools/perf/builtin-kmem.c b/tools/perf/builtin-kmem.c
index 96a6611e4e53f448..9714327fd0eadd1b 100644
--- a/tools/perf/builtin-kmem.c
+++ b/tools/perf/builtin-kmem.c
@@ -399,6 +399,7 @@ static u64 find_callsite(struct evsel *evsel, struct perf_sample *sample)
 	struct addr_location al;
 	struct machine *machine = &kmem_session->machines.host;
 	struct callchain_cursor_node *node;
+	struct callchain_cursor *cursor;
 	u64 result = sample->ip;
 
 	addr_location__init(&al);
@@ -408,14 +409,19 @@ static u64 find_callsite(struct evsel *evsel, struct perf_sample *sample)
 	}
 
 	al.thread = machine__findnew_thread(machine, sample->pid, sample->tid);
-	sample__resolve_callchain(sample, &callchain_cursor, NULL, evsel, &al, 16);
 
-	callchain_cursor_commit(&callchain_cursor);
+	cursor = get_tls_callchain_cursor();
+	if (cursor == NULL)
+		goto out;
+
+	sample__resolve_callchain(sample, cursor, NULL, evsel, &al, 16);
+
+	callchain_cursor_commit(cursor);
 	while (true) {
 		struct alloc_func key, *caller;
 		u64 addr;
 
-		node = callchain_cursor_current(&callchain_cursor);
+		node = callchain_cursor_current(cursor);
 		if (node == NULL)
 			break;
 
@@ -434,7 +440,7 @@ static u64 find_callsite(struct evsel *evsel, struct perf_sample *sample)
 		} else
 			pr_debug3("skipping alloc function: %s\n", caller->name);
 
-		callchain_cursor_advance(&callchain_cursor);
+		callchain_cursor_advance(cursor);
 	}
 
 	pr_debug2("unknown callsite: %"PRIx64 "\n", sample->ip);
diff --git a/tools/perf/builtin-kwork.c b/tools/perf/builtin-kwork.c
index 2d80aef4ecccece0..14bf7a8429e76f89 100644
--- a/tools/perf/builtin-kwork.c
+++ b/tools/perf/builtin-kwork.c
@@ -589,7 +589,7 @@ static void timehist_save_callchain(struct perf_kwork *kwork,
 	struct symbol *sym;
 	struct thread *thread;
 	struct callchain_cursor_node *node;
-	struct callchain_cursor *cursor = &callchain_cursor;
+	struct callchain_cursor *cursor;
 
 	if (!kwork->show_callchain || sample->callchain == NULL)
 		return;
@@ -601,6 +601,8 @@ static void timehist_save_callchain(struct perf_kwork *kwork,
 		return;
 	}
 
+	cursor = get_tls_callchain_cursor();
+
 	if (thread__resolve_callchain(thread, cursor, evsel, sample,
 				      NULL, NULL, kwork->max_stack + 2) != 0) {
 		pr_debug("Failed to resolve callchain, skipping\n");
@@ -686,12 +688,18 @@ static void timehist_print_event(struct perf_kwork *kwork,
 	 * callchain
 	 */
 	if (kwork->show_callchain) {
+		struct callchain_cursor *cursor = get_tls_callchain_cursor();
+
+		if (cursor == NULL)
+			return;
+
 		printf(" ");
+
 		sample__fprintf_sym(sample, al, 0,
 				    EVSEL__PRINT_SYM | EVSEL__PRINT_ONELINE |
 				    EVSEL__PRINT_CALLCHAIN_ARROW |
 				    EVSEL__PRINT_SKIP_IGNORED,
-				    &callchain_cursor, symbol_conf.bt_stop_list,
+				    cursor, symbol_conf.bt_stop_list,
 				    stdout);
 	}
 
diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index fc8356bd6e3a1d99..8b505e1e5002a680 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -911,7 +911,7 @@ static int lock_contention_caller(struct evsel *evsel, struct perf_sample *sampl
 				  char *buf, int size)
 {
 	struct thread *thread;
-	struct callchain_cursor *cursor = &callchain_cursor;
+	struct callchain_cursor *cursor;
 	struct machine *machine = &session->machines.host;
 	struct symbol *sym;
 	int skip = 0;
@@ -925,6 +925,8 @@ static int lock_contention_caller(struct evsel *evsel, struct perf_sample *sampl
 	if (thread == NULL)
 		return -1;
 
+	cursor = get_tls_callchain_cursor();
+
 	/* use caller function name from the callchain */
 	ret = thread__resolve_callchain(thread, cursor, evsel, sample,
 					NULL, NULL, max_stack_depth);
@@ -962,7 +964,7 @@ static int lock_contention_caller(struct evsel *evsel, struct perf_sample *sampl
 
 static u64 callchain_id(struct evsel *evsel, struct perf_sample *sample)
 {
-	struct callchain_cursor *cursor = &callchain_cursor;
+	struct callchain_cursor *cursor;
 	struct machine *machine = &session->machines.host;
 	struct thread *thread;
 	u64 hash = 0;
@@ -973,6 +975,7 @@ static u64 callchain_id(struct evsel *evsel, struct perf_sample *sample)
 	if (thread == NULL)
 		return -1;
 
+	cursor = get_tls_callchain_cursor();
 	/* use caller function name from the callchain */
 	ret = thread__resolve_callchain(thread, cursor, evsel, sample,
 					NULL, NULL, max_stack_depth);
diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index cd79068200e5653e..c9ddf73689cd6c07 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -2111,7 +2111,7 @@ static void timehist_print_sample(struct perf_sched *sched,
 			    EVSEL__PRINT_SYM | EVSEL__PRINT_ONELINE |
 			    EVSEL__PRINT_CALLCHAIN_ARROW |
 			    EVSEL__PRINT_SKIP_IGNORED,
-			    &callchain_cursor, symbol_conf.bt_stop_list,  stdout);
+			    get_tls_callchain_cursor(), symbol_conf.bt_stop_list,  stdout);
 
 out:
 	printf("\n");
@@ -2196,7 +2196,7 @@ static void save_task_callchain(struct perf_sched *sched,
 				struct evsel *evsel,
 				struct machine *machine)
 {
-	struct callchain_cursor *cursor = &callchain_cursor;
+	struct callchain_cursor *cursor;
 	struct thread *thread;
 
 	/* want main thread for process - has maps */
@@ -2209,6 +2209,8 @@ static void save_task_callchain(struct perf_sched *sched,
 	if (!sched->show_callchain || sample->callchain == NULL)
 		return;
 
+	cursor = get_tls_callchain_cursor();
+
 	if (thread__resolve_callchain(thread, cursor, evsel, sample,
 				      NULL, NULL, sched->max_stack + 2) != 0) {
 		if (verbose > 0)
@@ -2338,10 +2340,16 @@ static void save_idle_callchain(struct perf_sched *sched,
 				struct idle_thread_runtime *itr,
 				struct perf_sample *sample)
 {
+	struct callchain_cursor *cursor;
+
 	if (!sched->show_callchain || sample->callchain == NULL)
 		return;
 
-	callchain_cursor__copy(&itr->cursor, &callchain_cursor);
+	cursor = get_tls_callchain_cursor();
+	if (cursor == NULL)
+		return;
+
+	callchain_cursor__copy(&itr->cursor, cursor);
 }
 
 static struct thread *timehist_get_thread(struct perf_sched *sched,
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 6a1e75f06832bf35..66d4eb185ca7428a 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2411,8 +2411,7 @@ static int trace__fprintf_sys_enter(struct trace *trace, struct evsel *evsel,
 }
 
 static int trace__resolve_callchain(struct trace *trace, struct evsel *evsel,
-				    struct perf_sample *sample,
-				    struct callchain_cursor *cursor)
+				    struct perf_sample *sample, struct callchain_cursor *cursor)
 {
 	struct addr_location al;
 	int max_stack = evsel->core.attr.sample_max_stack ?
@@ -2437,7 +2436,7 @@ static int trace__fprintf_callchain(struct trace *trace, struct perf_sample *sam
 				        EVSEL__PRINT_DSO |
 				        EVSEL__PRINT_UNKNOWN_AS_ADDR;
 
-	return sample__fprintf_callchain(sample, 38, print_opts, &callchain_cursor, symbol_conf.bt_stop_list, trace->output);
+	return sample__fprintf_callchain(sample, 38, print_opts, get_tls_callchain_cursor(), symbol_conf.bt_stop_list, trace->output);
 }
 
 static const char *errno_to_name(struct evsel *evsel, int err)
@@ -2491,9 +2490,11 @@ static int trace__sys_exit(struct trace *trace, struct evsel *evsel,
 		goto out;
 
 	if (sample->callchain) {
-		callchain_ret = trace__resolve_callchain(trace, evsel, sample, &callchain_cursor);
+		struct callchain_cursor *cursor = get_tls_callchain_cursor();
+
+		callchain_ret = trace__resolve_callchain(trace, evsel, sample, cursor);
 		if (callchain_ret == 0) {
-			if (callchain_cursor.nr < trace->min_stack)
+			if (cursor->nr < trace->min_stack)
 				goto out;
 			callchain_ret = 1;
 		}
@@ -2795,9 +2796,11 @@ static int trace__event_handler(struct trace *trace, struct evsel *evsel,
 	thread = machine__findnew_thread(trace->host, sample->pid, sample->tid);
 
 	if (sample->callchain) {
-		callchain_ret = trace__resolve_callchain(trace, evsel, sample, &callchain_cursor);
+		struct callchain_cursor *cursor = get_tls_callchain_cursor();
+
+		callchain_ret = trace__resolve_callchain(trace, evsel, sample, cursor);
 		if (callchain_ret == 0) {
-			if (callchain_cursor.nr < trace->min_stack)
+			if (cursor->nr < trace->min_stack)
 				goto out;
 			callchain_ret = 1;
 		}
@@ -2899,9 +2902,11 @@ static int trace__pgfault(struct trace *trace,
 	thread = machine__findnew_thread(trace->host, sample->pid, sample->tid);
 
 	if (sample->callchain) {
-		callchain_ret = trace__resolve_callchain(trace, evsel, sample, &callchain_cursor);
+		struct callchain_cursor *cursor = get_tls_callchain_cursor();
+
+		callchain_ret = trace__resolve_callchain(trace, evsel, sample, cursor);
 		if (callchain_ret == 0) {
-			if (callchain_cursor.nr < trace->min_stack)
+			if (cursor->nr < trace->min_stack)
 				goto out_put;
 			callchain_ret = 1;
 		}
diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
index 7e9bd3b6be9f2655..aee937d14fbbf101 100644
--- a/tools/perf/util/callchain.c
+++ b/tools/perf/util/callchain.c
@@ -987,6 +987,9 @@ int callchain_append(struct callchain_root *root,
 		     struct callchain_cursor *cursor,
 		     u64 period)
 {
+	if (cursor == NULL)
+		return -1;
+
 	if (!cursor->nr)
 		return 0;
 
@@ -1601,6 +1604,8 @@ struct callchain_cursor *get_tls_callchain_cursor(void)
 	cursor = pthread_getspecific(callchain_cursor);
 	if (!cursor) {
 		cursor = zalloc(sizeof(*cursor));
+		if (!cursor)
+			pr_debug3("%s: not enough memory\n", __func__);
 		pthread_setspecific(callchain_cursor, cursor);
 	}
 	return cursor;
diff --git a/tools/perf/util/callchain.h b/tools/perf/util/callchain.h
index ce9410018cf7a1d5..d2618a47deca8f27 100644
--- a/tools/perf/util/callchain.h
+++ b/tools/perf/util/callchain.h
@@ -209,6 +209,8 @@ int callchain_cursor_append(struct callchain_cursor *cursor, u64 ip,
 /* Close a cursor writing session. Initialize for the reader */
 static inline void callchain_cursor_commit(struct callchain_cursor *cursor)
 {
+	if (cursor == NULL)
+		return;
 	cursor->curr = cursor->first;
 	cursor->pos = 0;
 }
@@ -217,7 +219,7 @@ static inline void callchain_cursor_commit(struct callchain_cursor *cursor)
 static inline struct callchain_cursor_node *
 callchain_cursor_current(struct callchain_cursor *cursor)
 {
-	if (cursor->pos == cursor->nr)
+	if (cursor == NULL || cursor->pos == cursor->nr)
 		return NULL;
 
 	return cursor->curr;
diff --git a/tools/perf/util/evsel_fprintf.c b/tools/perf/util/evsel_fprintf.c
index cf45ca0e768fb882..8719b3cb5646614d 100644
--- a/tools/perf/util/evsel_fprintf.c
+++ b/tools/perf/util/evsel_fprintf.c
@@ -127,6 +127,9 @@ int sample__fprintf_callchain(struct perf_sample *sample, int left_alignment,
 	char s = print_oneline ? ' ' : '\t';
 	bool first = true;
 
+	if (cursor == NULL)
+		return fprintf(fp, "<not enough memory for the callchain cursor>%s", print_oneline ? "" : "\n");
+
 	if (sample->callchain) {
 		callchain_cursor_commit(cursor);
 
diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index 4004c0915e4f471a..efaf7ac784fc8483 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -1031,6 +1031,9 @@ iter_prepare_cumulative_entry(struct hist_entry_iter *iter,
 	struct hist_entry **he_cache;
 	struct callchain_cursor *cursor = get_tls_callchain_cursor();
 
+	if (cursor == NULL)
+		return -ENOMEM;
+
 	callchain_cursor_commit(cursor);
 
 	/*
@@ -1135,6 +1138,9 @@ iter_add_next_cumulative_entry(struct hist_entry_iter *iter,
 	struct callchain_cursor cursor, *tls_cursor = get_tls_callchain_cursor();
 	bool fast = hists__has(he_tmp.hists, sym);
 
+	if (tls_cursor == NULL)
+		return -ENOMEM;
+
 	callchain_cursor_snapshot(&cursor, tls_cursor);
 
 	callchain_cursor_advance(tls_cursor);
@@ -1571,6 +1577,9 @@ static int hists__hierarchy_insert_entry(struct hists *hists,
 		    symbol_conf.use_callchain) {
 			struct callchain_cursor *cursor = get_tls_callchain_cursor();
 
+			if (cursor == NULL)
+				return -1;
+
 			callchain_cursor_reset(cursor);
 			if (callchain_merge(cursor,
 					    new_he->callchain,
@@ -1615,11 +1624,13 @@ static int hists__collapse_insert_entry(struct hists *hists,
 			if (hist_entry__has_callchains(he) && symbol_conf.use_callchain) {
 				struct callchain_cursor *cursor = get_tls_callchain_cursor();
 
-				callchain_cursor_reset(cursor);
-				if (callchain_merge(cursor,
-						    iter->callchain,
-						    he->callchain) < 0)
-					ret = -1;
+				if (cursor != NULL) {
+					callchain_cursor_reset(cursor);
+					if (callchain_merge(cursor, iter->callchain, he->callchain) < 0)
+						ret = -1;
+				} else {
+					ret = 0;
+				}
 			}
 			hist_entry__delete(he);
 			return ret;
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index bdad4b8bf77deb4e..4e62843d51b7dbf9 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -3180,6 +3180,9 @@ int thread__resolve_callchain(struct thread *thread,
 {
 	int ret = 0;
 
+	if (cursor == NULL)
+		return -ENOMEM;
+
 	callchain_cursor_reset(cursor);
 
 	if (callchain_param.order == ORDER_CALLEE) {
diff --git a/tools/perf/util/scripting-engines/trace-event-perl.c b/tools/perf/util/scripting-engines/trace-event-perl.c
index 65b761d83a1f8c3c..603091317bed9be4 100644
--- a/tools/perf/util/scripting-engines/trace-event-perl.c
+++ b/tools/perf/util/scripting-engines/trace-event-perl.c
@@ -260,6 +260,7 @@ static SV *perl_process_callchain(struct perf_sample *sample,
 				  struct evsel *evsel,
 				  struct addr_location *al)
 {
+	struct callchain_cursor *cursor;
 	AV *list;
 
 	list = newAV();
@@ -269,18 +270,20 @@ static SV *perl_process_callchain(struct perf_sample *sample,
 	if (!symbol_conf.use_callchain || !sample->callchain)
 		goto exit;
 
-	if (thread__resolve_callchain(al->thread, &callchain_cursor, evsel,
+	cursor = get_tls_callchain_cursor();
+
+	if (thread__resolve_callchain(al->thread, cursor, evsel,
 				      sample, NULL, NULL, scripting_max_stack) != 0) {
 		pr_err("Failed to resolve callchain. Skipping\n");
 		goto exit;
 	}
-	callchain_cursor_commit(&callchain_cursor);
+	callchain_cursor_commit(cursor);
 
 
 	while (1) {
 		HV *elem;
 		struct callchain_cursor_node *node;
-		node = callchain_cursor_current(&callchain_cursor);
+		node = callchain_cursor_current(cursor);
 		if (!node)
 			break;
 
@@ -328,7 +331,7 @@ static SV *perl_process_callchain(struct perf_sample *sample,
 			}
 		}
 
-		callchain_cursor_advance(&callchain_cursor);
+		callchain_cursor_advance(cursor);
 		av_push(list, newRV_noinc((SV*)elem));
 	}
 
