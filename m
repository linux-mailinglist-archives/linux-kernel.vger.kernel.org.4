Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C38126A58A2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 12:54:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231548AbjB1LyZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 06:54:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231591AbjB1LyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 06:54:13 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBE5721A2E
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 03:53:47 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id bh1so10081117plb.11
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 03:53:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Go6hF74oM9whxRdOC2jPPk3Baai7a+bxN4rdxUN/CiI=;
        b=IvzC3IakH+fK1BEQY63uauxpg+WVe9tccSJZyqnanc8BdCUkMFp0ZaYBuhrVxevXbX
         q0MCshvratVLASORVQqJPpy430sKHn7c7fsiVCWGB+PApiQTxglljCZbYVv9n1uvmFpJ
         R98GIQFCc67bmNH5zXHW0JIkZLptBhHu2871M5vfJN6paXVTLpBtfAsipCkANwM1kKhD
         jT3Q3Be15bxpqKRPADv/Zz7dI+J5CDlOZ/J4XMtWR4/N7htWMGVeMTZw2VaUpt3GGLp6
         zqxeYzWXsTZtKOeUBEtTShQ/vn63ptOxp0YCQixjAG2IFjDyVGkJJn6Z1Xw6M+bXaUOT
         b1BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Go6hF74oM9whxRdOC2jPPk3Baai7a+bxN4rdxUN/CiI=;
        b=p/Ls7QXOxsMYweQyu42W/3gjP8Zy1R1jLpSif8njLahiloXj9X8OBQfP3RHCnKpQT7
         UYojtNRCLtzOo5EojSZRIThFIWu3b6S7frP8Sv6BMLTr+9VEp9BfwX5/E+A6R07+Xu+Q
         KNm9efSf7CVvGDmwnxBEh3O0iki+EYNj4IY2/rlyycLrzRqAo20N1jw03dk0mU/JgFff
         PoQOgf7l6C1msjn7dF9af6UUMcEpYHtnap5BSrYJGqC9kzqxHq5IwKjrH3Txh/q7uC79
         CvoaG1w9togayX90o11nkLBi6wpuF9x6C9Vu1+Svn3zzT7SWJMDlnEU2aXZwWxiuX3+B
         FiQQ==
X-Gm-Message-State: AO0yUKXKNxYYAPLSUYnTyD0mtuNls+hDDmwYreHOjwKySiJ+P9mcamF5
        MDeTJu8K77mA1UK1Aec3m6xpayaNlYU8Pjsix7A=
X-Google-Smtp-Source: AK7set97q+9fn1H9imEIK6nqwOZzi3tMPnplmhMOltAnQ8lhJoiuIPLqkzAcHnD7StS5kdFHxmktuw==
X-Received: by 2002:a17:90a:3e05:b0:237:2045:5198 with SMTP id j5-20020a17090a3e0500b0023720455198mr2995551pjc.36.1677585218806;
        Tue, 28 Feb 2023 03:53:38 -0800 (PST)
Received: from leoy-huanghe.lan (n058152048225.netvigator.com. [58.152.48.225])
        by smtp.gmail.com with ESMTPSA id gk8-20020a17090b118800b002339491ead6sm7922317pjb.5.2023.02.28.03.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 03:53:38 -0800 (PST)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v3 09/14] perf kvm: Use histograms list to replace cached list
Date:   Tue, 28 Feb 2023 19:51:20 +0800
Message-Id: <20230228115125.144172-10-leo.yan@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230228115125.144172-1-leo.yan@linaro.org>
References: <20230228115125.144172-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

perf kvm tool defines its own cached list which is managed with RB tree,
histograms also provide RB tree to manage data entries.  Since now we
have introduced histograms in the tool, it's not necessary to use the
self defined list and we can directly use histograms list to manage
KVM events.

This patch changes to use histograms list to track KVM events, and it
invokes the common function hists__output_resort_cb() to sort result,
this also give us flexibility to extend more sorting key words easily.

After histograms list supported, the cached list is redundant so remove
the relevant code for it.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: James Clark <james.clark@arm.com>
---
 tools/perf/builtin-kvm.c   | 186 +++++++++++++++++++------------------
 tools/perf/util/kvm-stat.h |   7 --
 2 files changed, 94 insertions(+), 99 deletions(-)

diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index da84f5063d4d..32dc697ff707 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -421,44 +421,37 @@ struct vcpu_event_record {
 	struct kvm_event *last_event;
 };
 
-
-static void init_kvm_event_record(struct perf_kvm_stat *kvm)
-{
-	unsigned int i;
-
-	for (i = 0; i < EVENTS_CACHE_SIZE; i++)
-		INIT_LIST_HEAD(&kvm->kvm_events_cache[i]);
-}
-
 #ifdef HAVE_TIMERFD_SUPPORT
-static void clear_events_cache_stats(struct list_head *kvm_events_cache)
+static void clear_events_cache_stats(void)
 {
-	struct list_head *head;
+	struct rb_root_cached *root;
+	struct rb_node *nd;
 	struct kvm_event *event;
-	unsigned int i;
-	int j;
-
-	for (i = 0; i < EVENTS_CACHE_SIZE; i++) {
-		head = &kvm_events_cache[i];
-		list_for_each_entry(event, head, hash_entry) {
-			/* reset stats for event */
-			event->total.time = 0;
-			init_stats(&event->total.stats);
-
-			for (j = 0; j < event->max_vcpu; ++j) {
-				event->vcpu[j].time = 0;
-				init_stats(&event->vcpu[j].stats);
-			}
+	int i;
+
+	if (hists__has(&kvm_hists.hists, need_collapse))
+		root = &kvm_hists.hists.entries_collapsed;
+	else
+		root = kvm_hists.hists.entries_in;
+
+	for (nd = rb_first_cached(root); nd; nd = rb_next(nd)) {
+		struct hist_entry *he;
+
+		he = rb_entry(nd, struct hist_entry, rb_node_in);
+		event = container_of(he, struct kvm_event, he);
+
+		/* reset stats for event */
+		event->total.time = 0;
+		init_stats(&event->total.stats);
+
+		for (i = 0; i < event->max_vcpu; ++i) {
+			event->vcpu[i].time = 0;
+			init_stats(&event->vcpu[i].stats);
 		}
 	}
 }
 #endif
 
-static int kvm_events_hash_fn(u64 key)
-{
-	return key & (EVENTS_CACHE_SIZE - 1);
-}
-
 static bool kvm_event_expand(struct kvm_event *event, int vcpu_id)
 {
 	int old_max_vcpu = event->max_vcpu;
@@ -484,21 +477,51 @@ static bool kvm_event_expand(struct kvm_event *event, int vcpu_id)
 	return true;
 }
 
+static void *kvm_he_zalloc(size_t size)
+{
+	struct kvm_event *kvm_ev;
+
+	kvm_ev = zalloc(size + sizeof(*kvm_ev));
+	if (!kvm_ev)
+		return NULL;
+
+	return &kvm_ev->he;
+}
+
+static void kvm_he_free(void *he)
+{
+	struct kvm_event *kvm_ev;
+
+	kvm_ev = container_of(he, struct kvm_event, he);
+	free(kvm_ev);
+}
+
+static struct hist_entry_ops kvm_ev_entry_ops = {
+	.new	= kvm_he_zalloc,
+	.free	= kvm_he_free,
+};
+
 static struct kvm_event *kvm_alloc_init_event(struct perf_kvm_stat *kvm,
 					      struct event_key *key,
-					      struct perf_sample *sample __maybe_unused)
+					      struct perf_sample *sample)
 {
 	struct kvm_event *event;
+	struct hist_entry *he;
 
-	event = zalloc(sizeof(*event));
-	if (!event) {
-		pr_err("Not enough memory\n");
+	he = hists__add_entry_ops(&kvm_hists.hists, &kvm_ev_entry_ops,
+				  &kvm->al, NULL, NULL, NULL, sample, true);
+	if (he == NULL) {
+		pr_err("Failed to allocate hist entry\n");
 		return NULL;
 	}
 
+	hists__inc_nr_samples(&kvm_hists.hists, 0);
+
+	event = container_of(he, struct kvm_event, he);
 	event->perf_kvm = kvm;
 	event->key = *key;
 	init_stats(&event->total.stats);
+
 	return event;
 }
 
@@ -507,22 +530,26 @@ static struct kvm_event *find_create_kvm_event(struct perf_kvm_stat *kvm,
 					       struct perf_sample *sample)
 {
 	struct kvm_event *event;
-	struct list_head *head;
+	struct rb_root_cached *root;
+	struct rb_node *nd;
 
 	BUG_ON(key->key == INVALID_KEY);
 
-	head = &kvm->kvm_events_cache[kvm_events_hash_fn(key->key)];
-	list_for_each_entry(event, head, hash_entry) {
+	if (hists__has(&kvm_hists.hists, need_collapse))
+		root = &kvm_hists.hists.entries_collapsed;
+	else
+		root = kvm_hists.hists.entries_in;
+
+	for (nd = rb_first_cached(root); nd; nd = rb_next(nd)) {
+		struct hist_entry *he = rb_entry(nd, struct hist_entry,
+						 rb_node_in);
+
+		event = container_of(he, struct kvm_event, he);
 		if (event->key.key == key->key && event->key.info == key->info)
 			return event;
 	}
 
-	event = kvm_alloc_init_event(kvm, key, sample);
-	if (!event)
-		return NULL;
-
-	list_add(&event->hash_entry, head);
-	return event;
+	return kvm_alloc_init_event(kvm, key, sample);
 }
 
 static bool handle_begin_event(struct perf_kvm_stat *kvm,
@@ -754,58 +781,29 @@ static bool select_key(struct perf_kvm_stat *kvm)
 	return false;
 }
 
-static void insert_to_result(struct rb_root *result, struct kvm_event *event,
-			     key_cmp_fun bigger, int vcpu)
-{
-	struct rb_node **rb = &result->rb_node;
-	struct rb_node *parent = NULL;
-	struct kvm_event *p;
-
-	while (*rb) {
-		p = container_of(*rb, struct kvm_event, rb);
-		parent = *rb;
-
-		if (bigger(event, p, vcpu) > 0)
-			rb = &(*rb)->rb_left;
-		else
-			rb = &(*rb)->rb_right;
-	}
-
-	rb_link_node(&event->rb, parent, rb);
-	rb_insert_color(&event->rb, result);
-}
-
 static bool event_is_valid(struct kvm_event *event, int vcpu)
 {
 	return !!get_event_count(event, vcpu);
 }
 
-static void sort_result(struct perf_kvm_stat *kvm)
+static int filter_cb(struct hist_entry *he, void *arg __maybe_unused)
 {
-	unsigned int i;
-	int vcpu = kvm->trace_vcpu;
 	struct kvm_event *event;
+	struct perf_kvm_stat *perf_kvm;
 
-	for (i = 0; i < EVENTS_CACHE_SIZE; i++) {
-		list_for_each_entry(event, &kvm->kvm_events_cache[i], hash_entry) {
-			if (event_is_valid(event, vcpu)) {
-				insert_to_result(&kvm->result, event,
-						 kvm->compare, vcpu);
-			}
-		}
-	}
+	event = container_of(he, struct kvm_event, he);
+	perf_kvm = event->perf_kvm;
+	if (!event_is_valid(event, perf_kvm->trace_vcpu))
+		he->filtered = 1;
+	else
+		he->filtered = 0;
+	return 0;
 }
 
-/* returns left most element of result, and erase it */
-static struct kvm_event *pop_from_result(struct rb_root *result)
+static void sort_result(void)
 {
-	struct rb_node *node = rb_first(result);
-
-	if (!node)
-		return NULL;
-
-	rb_erase(node, result);
-	return container_of(node, struct kvm_event, rb);
+	hists__collapse_resort(&kvm_hists.hists, NULL);
+	hists__output_resort_cb(&kvm_hists.hists, NULL, filter_cb);
 }
 
 static void print_vcpu_info(struct perf_kvm_stat *kvm)
@@ -848,6 +846,7 @@ static void print_result(struct perf_kvm_stat *kvm)
 	char decode[decode_str_len];
 	struct kvm_event *event;
 	int vcpu = kvm->trace_vcpu;
+	struct rb_node *nd;
 
 	if (kvm->live) {
 		puts(CONSOLE_CLEAR);
@@ -866,9 +865,15 @@ static void print_result(struct perf_kvm_stat *kvm)
 	pr_info("%16s ", "Avg time");
 	pr_info("\n\n");
 
-	while ((event = pop_from_result(&kvm->result))) {
+	for (nd = rb_first_cached(&kvm_hists.hists.entries); nd; nd = rb_next(nd)) {
+		struct hist_entry *he;
 		u64 ecount, etime, max, min;
 
+		he = rb_entry(nd, struct hist_entry, rb_node);
+		if (he->filtered)
+			continue;
+
+		event = container_of(he, struct kvm_event, he);
 		ecount = get_event_count(event, vcpu);
 		etime = get_event_time(event, vcpu);
 		max = get_event_max(event, vcpu);
@@ -1142,11 +1147,11 @@ static int perf_kvm__handle_timerfd(struct perf_kvm_stat *kvm)
 		pr_debug("Missed timer beats: %" PRIu64 "\n", c-1);
 
 	/* update display */
-	sort_result(kvm);
+	sort_result();
 	print_result(kvm);
 
 	/* reset counts */
-	clear_events_cache_stats(kvm->kvm_events_cache);
+	clear_events_cache_stats();
 	kvm->total_count = 0;
 	kvm->total_time = 0;
 	kvm->lost_events = 0;
@@ -1202,8 +1207,6 @@ static int kvm_events_live_report(struct perf_kvm_stat *kvm)
 	}
 
 	set_term_quiet_input(&save);
-	init_kvm_event_record(kvm);
-
 	kvm_hists__init(kvm);
 
 	signal(SIGINT, sig_handler);
@@ -1250,7 +1253,7 @@ static int kvm_events_live_report(struct perf_kvm_stat *kvm)
 	evlist__disable(kvm->evlist);
 
 	if (err == 0) {
-		sort_result(kvm);
+		sort_result();
 		print_result(kvm);
 	}
 
@@ -1398,7 +1401,6 @@ static int kvm_events_report_vcpu(struct perf_kvm_stat *kvm)
 	if (!register_kvm_events_ops(kvm))
 		goto exit;
 
-	init_kvm_event_record(kvm);
 	setup_pager();
 
 	kvm_hists__init(kvm);
@@ -1407,7 +1409,7 @@ static int kvm_events_report_vcpu(struct perf_kvm_stat *kvm)
 	if (ret)
 		goto exit;
 
-	sort_result(kvm);
+	sort_result();
 	print_result(kvm);
 
 exit:
diff --git a/tools/perf/util/kvm-stat.h b/tools/perf/util/kvm-stat.h
index ca5796959f66..c38d320c7cbe 100644
--- a/tools/perf/util/kvm-stat.h
+++ b/tools/perf/util/kvm-stat.h
@@ -30,7 +30,6 @@ struct perf_kvm_stat;
 
 struct kvm_event {
 	struct list_head hash_entry;
-	struct rb_node rb;
 
 	struct perf_kvm_stat *perf_kvm;
 	struct event_key key;
@@ -75,9 +74,6 @@ struct exit_reasons_table {
 	const char *reason;
 };
 
-#define EVENTS_BITS		12
-#define EVENTS_CACHE_SIZE	(1UL << EVENTS_BITS)
-
 struct perf_kvm_stat {
 	struct perf_tool    tool;
 	struct record_opts  opts;
@@ -97,7 +93,6 @@ struct perf_kvm_stat {
 
 	struct kvm_events_ops *events_ops;
 	key_cmp_fun compare;
-	struct list_head kvm_events_cache[EVENTS_CACHE_SIZE];
 
 	u64 total_time;
 	u64 total_count;
@@ -106,8 +101,6 @@ struct perf_kvm_stat {
 
 	struct intlist *pid_list;
 
-	struct rb_root result;
-
 	int timerfd;
 	unsigned int display_time;
 	bool live;
-- 
2.34.1

