Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15E58728BD9
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 01:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237778AbjFHXbp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 19:31:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237652AbjFHXa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 19:30:59 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28EB73A97
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 16:30:12 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5618857518dso15406307b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 16:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686267011; x=1688859011;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Fdzksl/kkftTB43GevdApw1PAO/LnxMdJnRBtlfxhEE=;
        b=jUUrlAd0jFtx3gT8HHmiIn6ov/tGeo1Py3GP8BHc6orX8wxf2GSx0d3z64vOZamkLl
         l/Rn2B157YaRbKvWQKYRUxyu9DF/kxOScXlwbieTmGChV7a9VFKNzVv5yqmgtjZOZLvI
         EIgCMRTqv33YJZNKnwQEDnI7vuoO7RVCt3t3Crrp2tDmTVse1oCbPFF7ztH06ZD7nTWM
         QNbHvW0h1qNsM012dkqb6aTN0M6Ht/kvOC1mhjtakrw7ep9PlK44Jazk2Hyl4HsUB2t/
         /4rthPvbW9t9Rc/T7jAdig/pzIkyWS4B7eM4VfPrdD2U0HGx/Jn8/yzoWwqjtS9ggVmP
         nXOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686267011; x=1688859011;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fdzksl/kkftTB43GevdApw1PAO/LnxMdJnRBtlfxhEE=;
        b=RG3Es0no6C4UA8bK2xDnE0k5lGpIQisxsRWSzuUhfOj7ahKWBz2mblet6qWacI2QZK
         OlcYVnAbEnyaEhmTeBPuw+Ok/7kjEw2BYbX9uQ5BMaILwLOX0zMh6TEjw0fSDZPpdPmk
         a8CPuMUenAuUT5T13vpdwxZyqWDrcTbq66j//vRwvB5D7ykNkuifC07etVDfbcvl/+GD
         nOisMhiW9IaAMJoT8agq6BZ0wVsGHmzead3ddpsF54v0JQ3WN6gUI+cO6zt/B1YhftaI
         nno1u4wiBxn40HAKkGRk6E/2mkjukgvJ7eAHAKJ7U8mHxPsWmrk38dJdWfdI2stK1Jnd
         1RxA==
X-Gm-Message-State: AC+VfDzUvZ5wjh/wLA6k11PS6S2DKJQ3z/SPkD71E8Xckw4l9OXkMl/X
        SxKMS7s+WPRLNYXeYbwqz6JAYk0LczSn
X-Google-Smtp-Source: ACHHUZ5g5uyVZlOsr7pjdyZV6VH+phjABBlaux+DG9mdlabFHUh/Yg+4aAt5onkwPIjHgENJ5dKopd2fJFO0
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:c3e5:ebc6:61e5:c73f])
 (user=irogers job=sendgmr) by 2002:a81:bc4e:0:b0:569:5003:7d79 with SMTP id
 b14-20020a81bc4e000000b0056950037d79mr704640ywl.3.1686267011178; Thu, 08 Jun
 2023 16:30:11 -0700 (PDT)
Date:   Thu,  8 Jun 2023 16:28:21 -0700
In-Reply-To: <20230608232823.4027869-1-irogers@google.com>
Message-Id: <20230608232823.4027869-25-irogers@google.com>
Mime-Version: 1.0
References: <20230608232823.4027869-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Subject: [PATCH v2 24/26] perf callchain: Use pthread keys for tls callchain_cursor
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

Pthread keys are more portable than __thread and allow the association
of a destructor with the key. Use the destructor to clean up TLS
callchain cursors to aid understanding memory leaks.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-c2c.c                      |  4 +-
 tools/perf/builtin-script.c                   | 24 ++++++-----
 tools/perf/util/callchain.c                   | 40 ++++++++++++++++++-
 tools/perf/util/callchain.h                   |  4 +-
 tools/perf/util/db-export.c                   | 10 +++--
 tools/perf/util/hist.c                        | 29 ++++++++------
 .../scripting-engines/trace-event-python.c    | 10 +++--
 7 files changed, 86 insertions(+), 35 deletions(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 530a44a59f41..a4cf9de7a7b5 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -284,6 +284,7 @@ static int process_sample_event(struct perf_tool *tool __maybe_unused,
 	struct hist_entry *he;
 	struct addr_location al;
 	struct mem_info *mi, *mi_dup;
+	struct callchain_cursor *cursor;
 	int ret;
 
 	addr_location__init(&al);
@@ -297,7 +298,8 @@ static int process_sample_event(struct perf_tool *tool __maybe_unused,
 	if (c2c.stitch_lbr)
 		thread__set_lbr_stitch_enable(al.thread, true);
 
-	ret = sample__resolve_callchain(sample, &callchain_cursor, NULL,
+	cursor = get_tls_callchain_cursor();
+	ret = sample__resolve_callchain(sample, cursor, NULL,
 					evsel, &al, sysctl_perf_event_max_stack);
 	if (ret)
 		goto out;
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 784d478c2e05..e3f435e6a7d0 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -1557,11 +1557,13 @@ static int perf_sample__fprintf_bts(struct perf_sample *sample,
 		unsigned int print_opts = output[type].print_ip_opts;
 		struct callchain_cursor *cursor = NULL;
 
-		if (symbol_conf.use_callchain && sample->callchain &&
-		    thread__resolve_callchain(al->thread, &callchain_cursor, evsel,
-					      sample, NULL, NULL, scripting_max_stack) == 0)
-			cursor = &callchain_cursor;
-
+		if (symbol_conf.use_callchain && sample->callchain) {
+			cursor = get_tls_callchain_cursor();
+			if (thread__resolve_callchain(al->thread, cursor, evsel,
+						      sample, NULL, NULL,
+						      scripting_max_stack))
+				cursor = NULL;
+		}
 		if (cursor == NULL) {
 			printed += fprintf(fp, " ");
 			if (print_opts & EVSEL__PRINT_SRCLINE) {
@@ -2203,11 +2205,13 @@ static void process_event(struct perf_script *script,
 		if (script->stitch_lbr)
 			thread__set_lbr_stitch_enable(al->thread, true);
 
-		if (symbol_conf.use_callchain && sample->callchain &&
-		    thread__resolve_callchain(al->thread, &callchain_cursor, evsel,
-					      sample, NULL, NULL, scripting_max_stack) == 0)
-			cursor = &callchain_cursor;
-
+		if (symbol_conf.use_callchain && sample->callchain) {
+			cursor = get_tls_callchain_cursor();
+			if (thread__resolve_callchain(al->thread, cursor, evsel,
+						      sample, NULL, NULL,
+						      scripting_max_stack))
+				cursor = NULL;
+		}
 		fputc(cursor ? '\n' : ' ', fp);
 		sample__fprintf_sym(sample, al, 0, output[type].print_ip_opts, cursor,
 				    symbol_conf.bt_stop_list, fp);
diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
index 909f62b3b266..7e9bd3b6be9f 100644
--- a/tools/perf/util/callchain.c
+++ b/tools/perf/util/callchain.c
@@ -58,7 +58,8 @@ struct callchain_param callchain_param_default = {
 	CALLCHAIN_PARAM_DEFAULT
 };
 
-__thread struct callchain_cursor callchain_cursor;
+/* Used for thread-local struct callchain_cursor. */
+static pthread_key_t callchain_cursor;
 
 int parse_callchain_record_opt(const char *arg, struct callchain_param *param)
 {
@@ -1116,7 +1117,7 @@ int hist_entry__append_callchain(struct hist_entry *he, struct perf_sample *samp
 	if ((!symbol_conf.use_callchain || sample->callchain == NULL) &&
 		!symbol_conf.show_branchflag_count)
 		return 0;
-	return callchain_append(he->callchain, &callchain_cursor, sample->period);
+	return callchain_append(he->callchain, get_tls_callchain_cursor(), sample->period);
 }
 
 int fill_callchain_info(struct addr_location *al, struct callchain_cursor_node *node,
@@ -1570,6 +1571,41 @@ int callchain_node__make_parent_list(struct callchain_node *node)
 	return -ENOMEM;
 }
 
+static void callchain_cursor__delete(void *vcursor)
+{
+	struct callchain_cursor *cursor = vcursor;
+	struct callchain_cursor_node *node, *next;
+
+	callchain_cursor_reset(cursor);
+	for (node = cursor->first; node != NULL; node = next) {
+		next = node->next;
+		free(node);
+	}
+	free(cursor);
+}
+
+static void init_callchain_cursor_key(void)
+{
+	if (pthread_key_create(&callchain_cursor, callchain_cursor__delete)) {
+		pr_err("callchain cursor creation failed");
+		abort();
+	}
+}
+
+struct callchain_cursor *get_tls_callchain_cursor(void)
+{
+	static pthread_once_t once_control = PTHREAD_ONCE_INIT;
+	struct callchain_cursor *cursor;
+
+	pthread_once(&once_control, init_callchain_cursor_key);
+	cursor = pthread_getspecific(callchain_cursor);
+	if (!cursor) {
+		cursor = zalloc(sizeof(*cursor));
+		pthread_setspecific(callchain_cursor, cursor);
+	}
+	return cursor;
+}
+
 int callchain_cursor__copy(struct callchain_cursor *dst,
 			   struct callchain_cursor *src)
 {
diff --git a/tools/perf/util/callchain.h b/tools/perf/util/callchain.h
index d95615daed73..ce9410018cf7 100644
--- a/tools/perf/util/callchain.h
+++ b/tools/perf/util/callchain.h
@@ -168,8 +168,6 @@ struct callchain_cursor {
 	struct callchain_cursor_node	*curr;
 };
 
-extern __thread struct callchain_cursor callchain_cursor;
-
 static inline void callchain_init(struct callchain_root *root)
 {
 	INIT_LIST_HEAD(&root->node.val);
@@ -231,6 +229,8 @@ static inline void callchain_cursor_advance(struct callchain_cursor *cursor)
 	cursor->pos++;
 }
 
+struct callchain_cursor *get_tls_callchain_cursor(void);
+
 int callchain_cursor__copy(struct callchain_cursor *dst,
 			   struct callchain_cursor *src);
 
diff --git a/tools/perf/util/db-export.c b/tools/perf/util/db-export.c
index 6184696dc266..b9fb71ab7a73 100644
--- a/tools/perf/util/db-export.c
+++ b/tools/perf/util/db-export.c
@@ -215,6 +215,7 @@ static struct call_path *call_path_from_sample(struct db_export *dbe,
 	u64 kernel_start = machine__kernel_start(machine);
 	struct call_path *current = &dbe->cpr->call_path;
 	enum chain_order saved_order = callchain_param.order;
+	struct callchain_cursor *cursor;
 	int err;
 
 	if (!symbol_conf.use_callchain || !sample->callchain)
@@ -226,13 +227,14 @@ static struct call_path *call_path_from_sample(struct db_export *dbe,
 	 * the callchain starting with the root node and ending with the leaf.
 	 */
 	callchain_param.order = ORDER_CALLER;
-	err = thread__resolve_callchain(thread, &callchain_cursor, evsel,
+	cursor = get_tls_callchain_cursor();
+	err = thread__resolve_callchain(thread, cursor, evsel,
 					sample, NULL, NULL, PERF_MAX_STACK_DEPTH);
 	if (err) {
 		callchain_param.order = saved_order;
 		return NULL;
 	}
-	callchain_cursor_commit(&callchain_cursor);
+	callchain_cursor_commit(cursor);
 
 	while (1) {
 		struct callchain_cursor_node *node;
@@ -240,7 +242,7 @@ static struct call_path *call_path_from_sample(struct db_export *dbe,
 		u64 dso_db_id = 0, sym_db_id = 0, offset = 0;
 
 
-		node = callchain_cursor_current(&callchain_cursor);
+		node = callchain_cursor_current(cursor);
 		if (!node)
 			break;
 
@@ -265,7 +267,7 @@ static struct call_path *call_path_from_sample(struct db_export *dbe,
 					     al.sym, node->ip,
 					     kernel_start);
 
-		callchain_cursor_advance(&callchain_cursor);
+		callchain_cursor_advance(cursor);
 		addr_location__exit(&al);
 	}
 
diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index fb218b3e8a7c..4004c0915e4f 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -1029,15 +1029,16 @@ iter_prepare_cumulative_entry(struct hist_entry_iter *iter,
 			      struct addr_location *al __maybe_unused)
 {
 	struct hist_entry **he_cache;
+	struct callchain_cursor *cursor = get_tls_callchain_cursor();
 
-	callchain_cursor_commit(&callchain_cursor);
+	callchain_cursor_commit(cursor);
 
 	/*
 	 * This is for detecting cycles or recursions so that they're
 	 * cumulated only one time to prevent entries more than 100%
 	 * overhead.
 	 */
-	he_cache = malloc(sizeof(*he_cache) * (callchain_cursor.nr + 1));
+	he_cache = malloc(sizeof(*he_cache) * (cursor->nr + 1));
 	if (he_cache == NULL)
 		return -ENOMEM;
 
@@ -1072,7 +1073,7 @@ iter_add_single_cumulative_entry(struct hist_entry_iter *iter,
 	 * We need to re-initialize the cursor since callchain_append()
 	 * advanced the cursor to the end.
 	 */
-	callchain_cursor_commit(&callchain_cursor);
+	callchain_cursor_commit(get_tls_callchain_cursor());
 
 	hists__inc_nr_samples(hists, he->filtered);
 
@@ -1085,7 +1086,7 @@ iter_next_cumulative_entry(struct hist_entry_iter *iter,
 {
 	struct callchain_cursor_node *node;
 
-	node = callchain_cursor_current(&callchain_cursor);
+	node = callchain_cursor_current(get_tls_callchain_cursor());
 	if (node == NULL)
 		return 0;
 
@@ -1131,12 +1132,12 @@ iter_add_next_cumulative_entry(struct hist_entry_iter *iter,
 		.raw_size = sample->raw_size,
 	};
 	int i;
-	struct callchain_cursor cursor;
+	struct callchain_cursor cursor, *tls_cursor = get_tls_callchain_cursor();
 	bool fast = hists__has(he_tmp.hists, sym);
 
-	callchain_cursor_snapshot(&cursor, &callchain_cursor);
+	callchain_cursor_snapshot(&cursor, tls_cursor);
 
-	callchain_cursor_advance(&callchain_cursor);
+	callchain_cursor_advance(tls_cursor);
 
 	/*
 	 * Check if there's duplicate entries in the callchain.
@@ -1222,7 +1223,7 @@ int hist_entry_iter__add(struct hist_entry_iter *iter, struct addr_location *al,
 	if (al)
 		alm = map__get(al->map);
 
-	err = sample__resolve_callchain(iter->sample, &callchain_cursor, &iter->parent,
+	err = sample__resolve_callchain(iter->sample, get_tls_callchain_cursor(), &iter->parent,
 					iter->evsel, al, max_stack_depth);
 	if (err) {
 		map__put(alm);
@@ -1568,8 +1569,10 @@ static int hists__hierarchy_insert_entry(struct hists *hists,
 
 		if (hist_entry__has_callchains(new_he) &&
 		    symbol_conf.use_callchain) {
-			callchain_cursor_reset(&callchain_cursor);
-			if (callchain_merge(&callchain_cursor,
+			struct callchain_cursor *cursor = get_tls_callchain_cursor();
+
+			callchain_cursor_reset(cursor);
+			if (callchain_merge(cursor,
 					    new_he->callchain,
 					    he->callchain) < 0)
 				ret = -1;
@@ -1610,8 +1613,10 @@ static int hists__collapse_insert_entry(struct hists *hists,
 				he_stat__add_stat(iter->stat_acc, he->stat_acc);
 
 			if (hist_entry__has_callchains(he) && symbol_conf.use_callchain) {
-				callchain_cursor_reset(&callchain_cursor);
-				if (callchain_merge(&callchain_cursor,
+				struct callchain_cursor *cursor = get_tls_callchain_cursor();
+
+				callchain_cursor_reset(cursor);
+				if (callchain_merge(cursor,
 						    iter->callchain,
 						    he->callchain) < 0)
 					ret = -1;
diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index d96e5c0fef45..59063ec98619 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -417,6 +417,7 @@ static PyObject *python_process_callchain(struct perf_sample *sample,
 					 struct addr_location *al)
 {
 	PyObject *pylist;
+	struct callchain_cursor *cursor;
 
 	pylist = PyList_New(0);
 	if (!pylist)
@@ -425,19 +426,20 @@ static PyObject *python_process_callchain(struct perf_sample *sample,
 	if (!symbol_conf.use_callchain || !sample->callchain)
 		goto exit;
 
-	if (thread__resolve_callchain(al->thread, &callchain_cursor, evsel,
+	cursor = get_tls_callchain_cursor();
+	if (thread__resolve_callchain(al->thread, cursor, evsel,
 				      sample, NULL, NULL,
 				      scripting_max_stack) != 0) {
 		pr_err("Failed to resolve callchain. Skipping\n");
 		goto exit;
 	}
-	callchain_cursor_commit(&callchain_cursor);
+	callchain_cursor_commit(cursor);
 
 
 	while (1) {
 		PyObject *pyelem;
 		struct callchain_cursor_node *node;
-		node = callchain_cursor_current(&callchain_cursor);
+		node = callchain_cursor_current(cursor);
 		if (!node)
 			break;
 
@@ -493,7 +495,7 @@ static PyObject *python_process_callchain(struct perf_sample *sample,
 					_PyUnicode_FromString(dsoname));
 		}
 
-		callchain_cursor_advance(&callchain_cursor);
+		callchain_cursor_advance(cursor);
 		PyList_Append(pylist, pyelem);
 		Py_DECREF(pyelem);
 	}
-- 
2.41.0.162.gfafddb0af9-goog

