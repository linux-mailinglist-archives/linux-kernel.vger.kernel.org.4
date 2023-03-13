Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 959496B7651
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 12:43:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231365AbjCMLm7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 07:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231226AbjCMLmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 07:42:06 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2959565448
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 04:41:34 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id a2so12596937plm.4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 04:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678707689;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LbWTiwsNLCzhmnfJIO7ZAOWJugOE9iyft/rP2uRGCC8=;
        b=nZ8i5WMS0zGdM96heslrKJUIiOb1D7ofUN3SjacWtXfTVuSHaMD9cIkbY/tUTbZfmh
         nrLHpWAfXQavr0jWc8kCwfpXwMFxJGdFcK2WBhjk3s3iN3EhOW0bjnL2lbkgAV/l3KYR
         AZ3DEM/B8cFHgDYR7SlLG+B+/R46eeqwiJ3rw89Zn63nX+bLW30xeJGgJYdHPC2G0Yxk
         usB13ToHqBp7Dmk9JoZETT7VjOuH/1TOA4isEi8PrNUy7QDgBrs9jOmAK8VHIGOG+Yzx
         ilf56Z++S3UpY997GBOfGN8CDRhWHlkuEAuJDmpX60BPmx+6Eur2+MRv2mIH6ntlrujG
         u/fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678707689;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LbWTiwsNLCzhmnfJIO7ZAOWJugOE9iyft/rP2uRGCC8=;
        b=kLxIe6AaNU0C3tFyu3Ags3K4RGNOlxX7UMOqqn0re4jRKmqGosh6beqFM+O+mjHCyS
         BnuIpIJuWqwcM/HfqNmfCzqV248vjVXZ8sCCM+8gkk8dFct+WJWQ3pQB50cVYj4NmaiE
         1hGs/2qRvMtVjm4sinOcRohZymtNxYYX4pTgXDLrseisoujLvpoyuB0jZPty3TTsxmFh
         Eio96d2mGUq2aVvF77o87wMvTKRC88KzDs5biL1VF5f2A2Qvl7+YjHq+YLVKixynMNp6
         YdceeKdHUcaQ2U7EBkiKggxwa7l2mMvxljFwsT8AKGRUTHtXNf6lMux4grmqIdaBJJTy
         rBxA==
X-Gm-Message-State: AO0yUKX1QBbJFeFOe0W0wO7LqoD8qWKwxa/unLjeklkmO3M/6uplhWZi
        h1HR7GvIDhJVKpUPOtzsvuPDbw==
X-Google-Smtp-Source: AK7set8WqNlf7dj/GMmV4Uw0lWZ5Rte24uCy7j8wI2Vo0/UwEBhQE3vjtSMKNpzD/MjfTmuR6vTWtg==
X-Received: by 2002:a17:90a:dac3:b0:23b:446b:bbfe with SMTP id g3-20020a17090adac300b0023b446bbbfemr5713335pjx.10.1678707688565;
        Mon, 13 Mar 2023 04:41:28 -0700 (PDT)
Received: from leoy-huanghe.lan ([156.59.236.112])
        by smtp.gmail.com with ESMTPSA id q21-20020a17090a2e1500b0022335f1dae2sm4281625pjd.22.2023.03.13.04.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 04:41:28 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        John Garry <john.g.garry@oracle.com>,
        James Clark <james.clark@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v4 11/16] perf kvm: Use histograms list to replace cached list
Date:   Mon, 13 Mar 2023 19:40:13 +0800
Message-Id: <20230313114018.543254-12-leo.yan@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230313114018.543254-1-leo.yan@linaro.org>
References: <20230313114018.543254-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
---
 tools/perf/builtin-kvm.c   | 189 +++++++++++++++++++------------------
 tools/perf/util/kvm-stat.h |   7 --
 2 files changed, 95 insertions(+), 101 deletions(-)

diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index 3f601ccb7aab..ba3134613bcb 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -323,6 +323,12 @@ static int kvm_hists__init(void)
 	return kvm_hpp_list__parse(&kvm_hists.list, NULL, "ev_name");
 }
 
+static int kvm_hists__reinit(const char *output, const char *sort)
+{
+	perf_hpp__reset_output_field(&kvm_hists.list);
+	return kvm_hpp_list__parse(&kvm_hists.list, output, sort);
+}
+
 static const char *get_filename_for_perf_kvm(void)
 {
 	const char *filename;
@@ -420,44 +426,37 @@ struct vcpu_event_record {
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
@@ -483,44 +482,64 @@ static bool kvm_event_expand(struct kvm_event *event, int vcpu_id)
 	return true;
 }
 
-static struct kvm_event *kvm_alloc_init_event(struct perf_kvm_stat *kvm,
-					      struct event_key *key,
-					      struct perf_sample *sample __maybe_unused)
+static void *kvm_he_zalloc(size_t size)
 {
-	struct kvm_event *event;
+	struct kvm_event *kvm_ev;
 
-	event = zalloc(sizeof(*event));
-	if (!event) {
-		pr_err("Not enough memory\n");
+	kvm_ev = zalloc(size + sizeof(*kvm_ev));
+	if (!kvm_ev)
 		return NULL;
-	}
 
-	event->perf_kvm = kvm;
-	event->key = *key;
-	init_stats(&event->total.stats);
-	return event;
+	init_stats(&kvm_ev->total.stats);
+	hists__inc_nr_samples(&kvm_hists.hists, 0);
+	return &kvm_ev->he;
+}
+
+static void kvm_he_free(void *he)
+{
+	struct kvm_event *kvm_ev;
+
+	free(((struct hist_entry *)he)->kvm_info);
+	kvm_ev = container_of(he, struct kvm_event, he);
+	free(kvm_ev);
 }
 
+static struct hist_entry_ops kvm_ev_entry_ops = {
+	.new	= kvm_he_zalloc,
+	.free	= kvm_he_free,
+};
+
 static struct kvm_event *find_create_kvm_event(struct perf_kvm_stat *kvm,
 					       struct event_key *key,
 					       struct perf_sample *sample)
 {
 	struct kvm_event *event;
-	struct list_head *head;
+	struct hist_entry *he;
+	struct kvm_info *ki;
 
 	BUG_ON(key->key == INVALID_KEY);
 
-	head = &kvm->kvm_events_cache[kvm_events_hash_fn(key->key)];
-	list_for_each_entry(event, head, hash_entry) {
-		if (event->key.key == key->key && event->key.info == key->info)
-			return event;
+	ki = zalloc(sizeof(*ki));
+	if (!ki) {
+		pr_err("Failed to allocate kvm info\n");
+		return NULL;
 	}
 
-	event = kvm_alloc_init_event(kvm, key, sample);
-	if (!event)
+	kvm->events_ops->decode_key(kvm, key, ki->name);
+	he = hists__add_entry_ops(&kvm_hists.hists, &kvm_ev_entry_ops,
+				  &kvm->al, NULL, NULL, NULL, ki, sample, true);
+	if (he == NULL) {
+		pr_err("Failed to allocate hist entry\n");
+		free(ki);
 		return NULL;
+	}
+
+	event = container_of(he, struct kvm_event, he);
+	if (!event->perf_kvm) {
+		event->perf_kvm = kvm;
+		event->key = *key;
+	}
 
-	list_add(&event->hash_entry, head);
 	return event;
 }
 
@@ -753,58 +772,32 @@ static bool select_key(struct perf_kvm_stat *kvm)
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
+static void sort_result(struct perf_kvm_stat *kvm)
 {
-	struct rb_node *node = rb_first(result);
-
-	if (!node)
-		return NULL;
+	const char *output_columns = "ev_name,sample,time,max_t,min_t,mean_t";
 
-	rb_erase(node, result);
-	return container_of(node, struct kvm_event, rb);
+	kvm_hists__reinit(output_columns, kvm->sort_key);
+	hists__collapse_resort(&kvm_hists.hists, NULL);
+	hists__output_resort_cb(&kvm_hists.hists, NULL, filter_cb);
 }
 
 static void print_vcpu_info(struct perf_kvm_stat *kvm)
@@ -847,6 +840,7 @@ static void print_result(struct perf_kvm_stat *kvm)
 	char decode[KVM_EVENT_NAME_LEN];
 	struct kvm_event *event;
 	int vcpu = kvm->trace_vcpu;
+	struct rb_node *nd;
 
 	if (kvm->live) {
 		puts(CONSOLE_CLEAR);
@@ -865,9 +859,15 @@ static void print_result(struct perf_kvm_stat *kvm)
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
@@ -1144,8 +1144,11 @@ static int perf_kvm__handle_timerfd(struct perf_kvm_stat *kvm)
 	sort_result(kvm);
 	print_result(kvm);
 
+	/* Reset sort list to "ev_name" */
+	kvm_hists__reinit(NULL, "ev_name");
+
 	/* reset counts */
-	clear_events_cache_stats(kvm->kvm_events_cache);
+	clear_events_cache_stats();
 	kvm->total_count = 0;
 	kvm->total_time = 0;
 	kvm->lost_events = 0;
@@ -1201,7 +1204,6 @@ static int kvm_events_live_report(struct perf_kvm_stat *kvm)
 	}
 
 	set_term_quiet_input(&save);
-	init_kvm_event_record(kvm);
 
 	kvm_hists__init();
 
@@ -1397,7 +1399,6 @@ static int kvm_events_report_vcpu(struct perf_kvm_stat *kvm)
 	if (!register_kvm_events_ops(kvm))
 		goto exit;
 
-	init_kvm_event_record(kvm);
 	setup_pager();
 
 	kvm_hists__init();
diff --git a/tools/perf/util/kvm-stat.h b/tools/perf/util/kvm-stat.h
index 92da2fb87380..4385be769eee 100644
--- a/tools/perf/util/kvm-stat.h
+++ b/tools/perf/util/kvm-stat.h
@@ -36,7 +36,6 @@ struct perf_kvm_stat;
 
 struct kvm_event {
 	struct list_head hash_entry;
-	struct rb_node rb;
 
 	struct perf_kvm_stat *perf_kvm;
 	struct event_key key;
@@ -81,9 +80,6 @@ struct exit_reasons_table {
 	const char *reason;
 };
 
-#define EVENTS_BITS		12
-#define EVENTS_CACHE_SIZE	(1UL << EVENTS_BITS)
-
 struct perf_kvm_stat {
 	struct perf_tool    tool;
 	struct record_opts  opts;
@@ -103,7 +99,6 @@ struct perf_kvm_stat {
 
 	struct kvm_events_ops *events_ops;
 	key_cmp_fun compare;
-	struct list_head kvm_events_cache[EVENTS_CACHE_SIZE];
 
 	u64 total_time;
 	u64 total_count;
@@ -112,8 +107,6 @@ struct perf_kvm_stat {
 
 	struct intlist *pid_list;
 
-	struct rb_root result;
-
 	int timerfd;
 	unsigned int display_time;
 	bool live;
-- 
2.34.1

