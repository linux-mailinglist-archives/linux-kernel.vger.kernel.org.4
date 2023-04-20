Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 378AF6E9C75
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 21:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbjDTT2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 15:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230357AbjDTT21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 15:28:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0374C4210
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 12:28:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8F80964B76
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 19:28:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BBCFC433D2;
        Thu, 20 Apr 2023 19:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682018903;
        bh=55944/j7amgiAeKBTI7/yyWLkmNNzLaK6Anokxe5UZA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UHEIDGN/ckNCoTzhWpg8uDJIeLK8fzAJdRmlYUXni4CdthEjeJb3Ihq8HJ68V4NWC
         3cRJcF1ETUMxayTUx4XbCGW++nefwIIyrQ4uDNj8bd5RztIuUr+++0+/ZPjso1kirM
         LdRrrHLPSI0C/AsVR9PoWhyMEgdLWeDLRVF+865ics3gFe4QjA4fa78OYdjxT0vs8p
         joigN5/lwEbZ6Q9Az7MVR0aLcOyP/3dE6IUbcBrUgmQ6n56yjsy45RHGm1XkGy/qSZ
         npngawzhe7aewgU3/LGU6NXkVWPgCInWoSFvSBJlRAhCvuNToDXBUtOHySgnFAjOVn
         ZGu1bdY2XVS0w==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E33BC403C5; Thu, 20 Apr 2023 16:28:19 -0300 (-03)
Date:   Thu, 20 Apr 2023 16:28:19 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        "Liang, Kan" <kan.liang@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH 1/1] perf evsel: Introduce evsel__name_is() method to
 check if the evsel name is equal to a given string
Message-ID: <ZEGSU5DrAODcLmc3@kernel.org>
References: <ZEGLM8VehJbS0gP2@kernel.org>
 <ZEGOJuJd4uLS2392@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZEGOJuJd4uLS2392@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Apr 20, 2023 at 04:10:30PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Thu, Apr 20, 2023 at 03:57:55PM -0300, Arnaldo Carvalho de Melo escreveu:
> > This makes the logic a bit clear by avoiding the !strcmp() pattern and
> > also a way to intercept the pointer if we need to do extra validation on
> > it or to do lazy setting of evsel->name via evsel__name(evsel).
> 
> + this, looking if there are others...

Somehow the first message didn't go thru, so below is the combined
patch, this is an effort to avoid accessing evsel->name directly as the
preferred way to get an evsel name is evsel__name(), so looking for
direct access and providing accessors that avoid that.

- Arnaldo

From e60455d6a4e35ba0c376966443294586a1adc3ec Mon Sep 17 00:00:00 2001
From: Arnaldo Carvalho de Melo <acme@redhat.com>
Date: Thu, 20 Apr 2023 15:54:11 -0300
Subject: [PATCH 1/1] perf evsel: Introduce evsel__name_is() method to check if
 the evsel name is equal to a given string

This makes the logic a bit clear by avoiding the !strcmp() pattern and
also a way to intercept the pointer if we need to do extra validation on
it or to do lazy setting of evsel->name via evsel__name(evsel).

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lore.kernel.org/lkml/ZEGLM8VehJbS0gP2@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/arm64/util/kvm-stat.c   |  4 ++--
 tools/perf/arch/powerpc/util/kvm-stat.c |  4 ++--
 tools/perf/arch/x86/util/kvm-stat.c     |  8 ++++----
 tools/perf/builtin-kvm.c                |  6 +++---
 tools/perf/builtin-stat.c               |  2 +-
 tools/perf/tests/expand-cgroup.c        |  2 +-
 tools/perf/tests/parse-events.c         | 12 ++++++------
 tools/perf/tests/parse-metric.c         |  2 +-
 tools/perf/tests/pmu-events.c           |  2 +-
 tools/perf/util/evsel.c                 |  7 ++++++-
 tools/perf/util/evsel.h                 |  1 +
 11 files changed, 28 insertions(+), 22 deletions(-)

diff --git a/tools/perf/arch/arm64/util/kvm-stat.c b/tools/perf/arch/arm64/util/kvm-stat.c
index 72ca9bb45804d109..6611aa21cba957d9 100644
--- a/tools/perf/arch/arm64/util/kvm-stat.c
+++ b/tools/perf/arch/arm64/util/kvm-stat.c
@@ -44,14 +44,14 @@ static bool event_begin(struct evsel *evsel,
 			struct perf_sample *sample __maybe_unused,
 			struct event_key *key __maybe_unused)
 {
-	return !strcmp(evsel->name, kvm_entry_trace);
+	return evsel__name_is(evsel, kvm_entry_trace);
 }
 
 static bool event_end(struct evsel *evsel,
 		      struct perf_sample *sample,
 		      struct event_key *key)
 {
-	if (!strcmp(evsel->name, kvm_exit_trace)) {
+	if (evsel__name_is(evsel, kvm_exit_trace)) {
 		event_get_key(evsel, sample, key);
 		return true;
 	}
diff --git a/tools/perf/arch/powerpc/util/kvm-stat.c b/tools/perf/arch/powerpc/util/kvm-stat.c
index d04a08c9fd19c58c..ea1220d66b6758b2 100644
--- a/tools/perf/arch/powerpc/util/kvm-stat.c
+++ b/tools/perf/arch/powerpc/util/kvm-stat.c
@@ -60,13 +60,13 @@ static bool hcall_event_end(struct evsel *evsel,
 			    struct perf_sample *sample __maybe_unused,
 			    struct event_key *key __maybe_unused)
 {
-	return (!strcmp(evsel->name, kvm_events_tp[3]));
+	return (evsel__name_is(evsel, kvm_events_tp[3]));
 }
 
 static bool hcall_event_begin(struct evsel *evsel,
 			      struct perf_sample *sample, struct event_key *key)
 {
-	if (!strcmp(evsel->name, kvm_events_tp[2])) {
+	if (evsel__name_is(evsel, kvm_events_tp[2])) {
 		hcall_event_get_key(evsel, sample, key);
 		return true;
 	}
diff --git a/tools/perf/arch/x86/util/kvm-stat.c b/tools/perf/arch/x86/util/kvm-stat.c
index ef513def03bac71c..424716518b755915 100644
--- a/tools/perf/arch/x86/util/kvm-stat.c
+++ b/tools/perf/arch/x86/util/kvm-stat.c
@@ -46,7 +46,7 @@ static bool mmio_event_begin(struct evsel *evsel,
 		return true;
 
 	/* MMIO write begin event in kernel. */
-	if (!strcmp(evsel->name, "kvm:kvm_mmio") &&
+	if (evsel__name_is(evsel, "kvm:kvm_mmio") &&
 	    evsel__intval(evsel, sample, "type") == KVM_TRACE_MMIO_WRITE) {
 		mmio_event_get_key(evsel, sample, key);
 		return true;
@@ -63,7 +63,7 @@ static bool mmio_event_end(struct evsel *evsel, struct perf_sample *sample,
 		return true;
 
 	/* MMIO read end event in kernel.*/
-	if (!strcmp(evsel->name, "kvm:kvm_mmio") &&
+	if (evsel__name_is(evsel, "kvm:kvm_mmio") &&
 	    evsel__intval(evsel, sample, "type") == KVM_TRACE_MMIO_READ) {
 		mmio_event_get_key(evsel, sample, key);
 		return true;
@@ -101,7 +101,7 @@ static bool ioport_event_begin(struct evsel *evsel,
 			       struct perf_sample *sample,
 			       struct event_key *key)
 {
-	if (!strcmp(evsel->name, "kvm:kvm_pio")) {
+	if (evsel__name_is(evsel, "kvm:kvm_pio")) {
 		ioport_event_get_key(evsel, sample, key);
 		return true;
 	}
@@ -145,7 +145,7 @@ static bool msr_event_begin(struct evsel *evsel,
 			       struct perf_sample *sample,
 			       struct event_key *key)
 {
-	if (!strcmp(evsel->name, "kvm:kvm_msr")) {
+	if (evsel__name_is(evsel, "kvm:kvm_msr")) {
 		msr_event_get_key(evsel, sample, key);
 		return true;
 	}
diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index 747d19336340f28f..71165036e4cac89b 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -625,7 +625,7 @@ void exit_event_get_key(struct evsel *evsel,
 
 bool kvm_exit_event(struct evsel *evsel)
 {
-	return !strcmp(evsel->name, kvm_exit_trace);
+	return evsel__name_is(evsel, kvm_exit_trace);
 }
 
 bool exit_event_begin(struct evsel *evsel,
@@ -641,7 +641,7 @@ bool exit_event_begin(struct evsel *evsel,
 
 bool kvm_entry_event(struct evsel *evsel)
 {
-	return !strcmp(evsel->name, kvm_entry_trace);
+	return evsel__name_is(evsel, kvm_entry_trace);
 }
 
 bool exit_event_end(struct evsel *evsel,
@@ -878,7 +878,7 @@ static bool is_child_event(struct perf_kvm_stat *kvm,
 		return false;
 
 	for (; child_ops->name; child_ops++) {
-		if (!strcmp(evsel->name, child_ops->name)) {
+		if (evsel__name_is(evsel, child_ops->name)) {
 			child_ops->get_key(evsel, sample, key);
 			return true;
 		}
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index d3cbee7460fcc48e..efda63f6bf329b51 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -2170,7 +2170,7 @@ static void setup_system_wide(int forks)
 
 		evlist__for_each_entry(evsel_list, counter) {
 			if (!counter->core.requires_cpu &&
-			    strcmp(counter->name, "duration_time")) {
+			    !evsel__name_is(counter, "duration_time")) {
 				return;
 			}
 		}
diff --git a/tools/perf/tests/expand-cgroup.c b/tools/perf/tests/expand-cgroup.c
index ec340880a848d907..9c1a1f18db750607 100644
--- a/tools/perf/tests/expand-cgroup.c
+++ b/tools/perf/tests/expand-cgroup.c
@@ -61,7 +61,7 @@ static int test_expand_events(struct evlist *evlist,
 
 	i = 0;
 	evlist__for_each_entry(evlist, evsel) {
-		if (strcmp(evsel->name, ev_name[i % nr_events])) {
+		if (!evsel__name_is(evsel, ev_name[i % nr_events])) {
 			pr_debug("event name doesn't match:\n");
 			pr_debug("  evsel[%d]: %s\n  expected: %s\n",
 				 i, evsel->name, ev_name[i % nr_events]);
diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index 6eb1400443adddee..8068cfd89b84f723 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -1401,7 +1401,7 @@ static int test__checkevent_config_symbol(struct evlist *evlist)
 {
 	struct evsel *evsel = evlist__first(evlist);
 
-	TEST_ASSERT_VAL("wrong name setting", strcmp(evsel->name, "insn") == 0);
+	TEST_ASSERT_VAL("wrong name setting", evsel__name_is(evsel, "insn"));
 	return TEST_OK;
 }
 
@@ -1409,7 +1409,7 @@ static int test__checkevent_config_raw(struct evlist *evlist)
 {
 	struct evsel *evsel = evlist__first(evlist);
 
-	TEST_ASSERT_VAL("wrong name setting", strcmp(evsel->name, "rawpmu") == 0);
+	TEST_ASSERT_VAL("wrong name setting", evsel__name_is(evsel, "rawpmu"));
 	return TEST_OK;
 }
 
@@ -1417,7 +1417,7 @@ static int test__checkevent_config_num(struct evlist *evlist)
 {
 	struct evsel *evsel = evlist__first(evlist);
 
-	TEST_ASSERT_VAL("wrong name setting", strcmp(evsel->name, "numpmu") == 0);
+	TEST_ASSERT_VAL("wrong name setting", evsel__name_is(evsel, "numpmu"));
 	return TEST_OK;
 }
 
@@ -1425,7 +1425,7 @@ static int test__checkevent_config_cache(struct evlist *evlist)
 {
 	struct evsel *evsel = evlist__first(evlist);
 
-	TEST_ASSERT_VAL("wrong name setting", strcmp(evsel->name, "cachepmu") == 0);
+	TEST_ASSERT_VAL("wrong name setting", evsel__name_is(evsel, "cachepmu"));
 	return TEST_OK;
 }
 
@@ -1438,7 +1438,7 @@ static int test__intel_pt(struct evlist *evlist)
 {
 	struct evsel *evsel = evlist__first(evlist);
 
-	TEST_ASSERT_VAL("wrong name setting", strcmp(evsel->name, "intel_pt//u") == 0);
+	TEST_ASSERT_VAL("wrong name setting", evsel__name_is(evsel, "intel_pt//u"));
 	return TEST_OK;
 }
 
@@ -1446,7 +1446,7 @@ static int test__checkevent_complex_name(struct evlist *evlist)
 {
 	struct evsel *evsel = evlist__first(evlist);
 
-	TEST_ASSERT_VAL("wrong complex name parsing", strcmp(evsel->name, "COMPLEX_CYCLES_NAME:orig=cycles,desc=chip-clock-ticks") == 0);
+	TEST_ASSERT_VAL("wrong complex name parsing", evsel__name_is(evsel, "COMPLEX_CYCLES_NAME:orig=cycles,desc=chip-clock-ticks"));
 	return TEST_OK;
 }
 
diff --git a/tools/perf/tests/parse-metric.c b/tools/perf/tests/parse-metric.c
index c43b056f9fa395f4..1185b79e6274886e 100644
--- a/tools/perf/tests/parse-metric.c
+++ b/tools/perf/tests/parse-metric.c
@@ -39,7 +39,7 @@ static void load_runtime_stat(struct evlist *evlist, struct value *vals)
 	evlist__for_each_entry(evlist, evsel) {
 		count = find_value(evsel->name, vals);
 		evsel->stats->aggr->counts.val = count;
-		if (!strcmp(evsel->name, "duration_time"))
+		if (evsel__name_is(evsel, "duration_time"))
 			update_stats(&walltime_nsecs_stats, count);
 	}
 }
diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
index 7f8e864525271483..1dff863b9711cf6d 100644
--- a/tools/perf/tests/pmu-events.c
+++ b/tools/perf/tests/pmu-events.c
@@ -866,7 +866,7 @@ static int test__parsing_callback(const struct pmu_metric *pm,
 	evlist__alloc_aggr_stats(evlist, 1);
 	evlist__for_each_entry(evlist, evsel) {
 		evsel->stats->aggr->counts.val = k;
-		if (!strcmp(evsel->name, "duration_time"))
+		if (evsel__name_is(evsel, "duration_time"))
 			update_stats(&walltime_nsecs_stats, k);
 		k++;
 	}
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index a85a987128aad281..81b854650160c2b0 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -821,6 +821,11 @@ const char *evsel__name(struct evsel *evsel)
 	return "unknown";
 }
 
+bool evsel__name_is(struct evsel *evsel, const char *name)
+{
+	return !strcmp(evsel->name, name);
+}
+
 const char *evsel__group_pmu_name(const struct evsel *evsel)
 {
 	const struct evsel *leader;
@@ -1146,7 +1151,7 @@ static void evsel__set_default_freq_period(struct record_opts *opts,
 
 static bool evsel__is_offcpu_event(struct evsel *evsel)
 {
-	return evsel__is_bpf_output(evsel) && !strcmp(evsel->name, OFFCPU_EVENT);
+	return evsel__is_bpf_output(evsel) && evsel__name_is(evsel, OFFCPU_EVENT);
 }
 
 /*
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 68072ec655ce9fff..1e5d640e4a9bd0f1 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -282,6 +282,7 @@ int arch_evsel__hw_name(struct evsel *evsel, char *bf, size_t size);
 
 int __evsel__hw_cache_type_op_res_name(u8 type, u8 op, u8 result, char *bf, size_t size);
 const char *evsel__name(struct evsel *evsel);
+bool evsel__name_is(struct evsel *evsel, const char *name);
 const char *evsel__group_pmu_name(const struct evsel *evsel);
 const char *evsel__metric_id(const struct evsel *evsel);
 
-- 
2.39.2

