Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57731636844
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 19:05:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238905AbiKWSE7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 13:04:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239445AbiKWSCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 13:02:40 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA5D75FC0;
        Wed, 23 Nov 2022 10:02:28 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id 62so17348431pgb.13;
        Wed, 23 Nov 2022 10:02:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wLOHc0kNNvswzQicgM/c9gpdZABR952YZCIn6DOjwMU=;
        b=Jfron7PHVA8BP+OdFqiGy6CZW9na10jyamInmtDZkotnRkYXaMR5X1Z+Nbsx0n33bn
         8IbRAAfld4Ao8N3ckQfQkJTVwXZR0JAVHkrtOLCxOYwnPrL8ELyNvLwh14TqWnkPolW1
         FQEkWKiH3AXW7KBhCDAkGQnOLWYqN+9gxnIpQq1DXGbgxYvRyiV/G3SKc9onA7M5I0q0
         s+F43t8oR95FFizfdJj8zv6alqquuH8fbY2M+bU89xjUowaoPibjHD0iU7ujmFvzolYd
         gJliQc08iD1I5Y//IRSI0OxiBzFU9tEn0s5kqJOVNKtzjS6VXHkvLFsl6sy6ZCTBhP6I
         Apjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wLOHc0kNNvswzQicgM/c9gpdZABR952YZCIn6DOjwMU=;
        b=TjHmaHbk5JtwiTD0wZrEGQ/ZrumJoVgmMS1fYZ9Xhp4QF8isEGnqBUHzAXC3JOYfWZ
         GCeSh47voAig+03ojOrGIN8HPtL8gyCcRFT8y2JIGmNQl0Tsdtxy8wPS59EqEMCD0fSN
         qcKk4QaZeoGILf/N5IJOEF5ioZd21fVQa+xSwYy47HJTSEQfKbXTPOJPl4H3RusqSWac
         MSB4zSid6UIYLhN5mksbfx0I51pFL+8ZtTpFeK32QrLuhmAWI6LgroYJe6FKW3/fRv/e
         VV+Cop2poaPTcJ9jPDRDdc5YeKzUk7F0aR/ojOtFt+WeSV5JQxX3ijUCxJndCHyxPS0d
         iVEw==
X-Gm-Message-State: ANoB5pnENt23Cwrz1hSmMYk3OknKHZR6oSByhswi1uavHtPgIhGdSSIP
        A3ocKwOjr/kaq72OK69KeM67gw5d9XI=
X-Google-Smtp-Source: AA0mqf6/PDyYkfsvANeK3sIIV58M4uS/df8+Aji8GRqQzoIfSesKVwj7pNoh0n84lD3Nls6kXJRSAg==
X-Received: by 2002:a65:60c7:0:b0:476:aad3:90e2 with SMTP id r7-20020a6560c7000000b00476aad390e2mr8461159pgv.217.1669226548002;
        Wed, 23 Nov 2022 10:02:28 -0800 (PST)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:a80:c968:76:254b:3790])
        by smtp.gmail.com with ESMTPSA id i15-20020a655b8f000000b00470275c8d6dsm10792364pgr.10.2022.11.23.10.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 10:02:27 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        James Clark <james.clark@arm.com>,
        Athira Jajeev <atrajeev@linux.vnet.ibm.com>
Subject: [PATCH 12/15] perf stat: Pass through struct outstate
Date:   Wed, 23 Nov 2022 10:02:05 -0800
Message-Id: <20221123180208.2068936-13-namhyung@kernel.org>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
In-Reply-To: <20221123180208.2068936-1-namhyung@kernel.org>
References: <20221123180208.2068936-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now most of the print functions take a pointer to the struct outstate.
We have one in the evlist__print_counters() and pass it through the
child functions.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/arch/x86/util/iostat.c |   4 +-
 tools/perf/util/iostat.c          |   3 +-
 tools/perf/util/iostat.h          |   4 +-
 tools/perf/util/stat-display.c    | 102 +++++++++++++-----------------
 4 files changed, 50 insertions(+), 63 deletions(-)

diff --git a/tools/perf/arch/x86/util/iostat.c b/tools/perf/arch/x86/util/iostat.c
index 404de795ec0b..7eb0a7b00b95 100644
--- a/tools/perf/arch/x86/util/iostat.c
+++ b/tools/perf/arch/x86/util/iostat.c
@@ -449,7 +449,7 @@ void iostat_print_metric(struct perf_stat_config *config, struct evsel *evsel,
 
 void iostat_print_counters(struct evlist *evlist,
 			   struct perf_stat_config *config, struct timespec *ts,
-			   char *prefix, iostat_print_counter_t print_cnt_cb)
+			   char *prefix, iostat_print_counter_t print_cnt_cb, void *arg)
 {
 	void *perf_device = NULL;
 	struct evsel *counter = evlist__first(evlist);
@@ -464,7 +464,7 @@ void iostat_print_counters(struct evlist *evlist,
 			iostat_prefix(evlist, config, prefix, ts);
 			fprintf(config->output, "\n%s", prefix);
 		}
-		print_cnt_cb(config, counter, prefix);
+		print_cnt_cb(config, counter, arg);
 	}
 	fputc('\n', config->output);
 }
diff --git a/tools/perf/util/iostat.c b/tools/perf/util/iostat.c
index 57dd49da28fe..b770bd473af7 100644
--- a/tools/perf/util/iostat.c
+++ b/tools/perf/util/iostat.c
@@ -48,6 +48,7 @@ __weak void iostat_print_counters(struct evlist *evlist __maybe_unused,
 				  struct perf_stat_config *config __maybe_unused,
 				  struct timespec *ts __maybe_unused,
 				  char *prefix __maybe_unused,
-				  iostat_print_counter_t print_cnt_cb __maybe_unused)
+				  iostat_print_counter_t print_cnt_cb __maybe_unused,
+				  void *arg __maybe_unused)
 {
 }
diff --git a/tools/perf/util/iostat.h b/tools/perf/util/iostat.h
index c22688f87cb2..a4e7299c5c2f 100644
--- a/tools/perf/util/iostat.h
+++ b/tools/perf/util/iostat.h
@@ -28,7 +28,7 @@ enum iostat_mode_t {
 
 extern enum iostat_mode_t iostat_mode;
 
-typedef void (*iostat_print_counter_t)(struct perf_stat_config *, struct evsel *, const char *);
+typedef void (*iostat_print_counter_t)(struct perf_stat_config *, struct evsel *, void *);
 
 int iostat_prepare(struct evlist *evlist, struct perf_stat_config *config);
 int iostat_parse(const struct option *opt, const char *str,
@@ -42,6 +42,6 @@ void iostat_print_metric(struct perf_stat_config *config, struct evsel *evsel,
 			 struct perf_stat_output_ctx *out);
 void iostat_print_counters(struct evlist *evlist,
 			   struct perf_stat_config *config, struct timespec *ts,
-			   char *prefix, iostat_print_counter_t print_cnt_cb);
+			   char *prefix, iostat_print_counter_t print_cnt_cb, void *arg);
 
 #endif /* _IOSTAT_H */
diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index cdf4ca7f6e3a..335627e8542d 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -796,7 +796,7 @@ static void uniquify_counter(struct perf_stat_config *config, struct evsel *coun
 
 static void print_counter_aggrdata(struct perf_stat_config *config,
 				   struct evsel *counter, int s,
-				   const char *prefix)
+				   struct outstate *os)
 {
 	FILE *output = config->output;
 	u64 ena, run, val;
@@ -806,13 +806,10 @@ static void print_counter_aggrdata(struct perf_stat_config *config,
 	struct aggr_cpu_id id = config->aggr_map->map[s];
 	double avg = aggr->counts.val;
 	bool metric_only = config->metric_only;
-	struct outstate os = {
-		.fh = config->output,
-		.prefix = prefix ? prefix : "",
-		.id = id,
-		.nr = aggr->nr,
-		.evsel = counter,
-	};
+
+	os->id = id;
+	os->nr = aggr->nr;
+	os->evsel = counter;
 
 	if (counter->supported && aggr->nr == 0)
 		return;
@@ -824,8 +821,8 @@ static void print_counter_aggrdata(struct perf_stat_config *config,
 	run = aggr->counts.run;
 
 	if (!metric_only) {
-		if (prefix)
-			fprintf(output, "%s", prefix);
+		if (os->prefix)
+			fprintf(output, "%s", os->prefix);
 		else if (config->summary && config->csv_output &&
 			 !config->no_csv_summary && !config->interval)
 			fprintf(output, "%s%s", "summary", config->csv_sep);
@@ -833,7 +830,7 @@ static void print_counter_aggrdata(struct perf_stat_config *config,
 
 	uval = val * counter->scale;
 
-	printout(config, &os, uval, run, ena, avg, s);
+	printout(config, os, uval, run, ena, avg, s);
 
 	if (!metric_only)
 		fputc('\n', output);
@@ -871,12 +868,9 @@ static void print_metric_end(struct perf_stat_config *config)
 
 static void print_aggr(struct perf_stat_config *config,
 		       struct evlist *evlist,
-		       const char *prefix)
+		       struct outstate *os)
 {
 	struct evsel *counter;
-	struct outstate os = {
-		.prefix = prefix,
-	};
 	int s;
 
 	if (!config->aggr_map || !config->aggr_get_id)
@@ -887,13 +881,13 @@ static void print_aggr(struct perf_stat_config *config,
 	 * Without each counter has its own line.
 	 */
 	for (s = 0; s < config->aggr_map->nr; s++) {
-		print_metric_begin(config, evlist, &os, s);
+		print_metric_begin(config, evlist, os, s);
 
 		evlist__for_each_entry(evlist, counter) {
 			if (counter->merged_stat)
 				continue;
 
-			print_counter_aggrdata(config, counter, s, prefix);
+			print_counter_aggrdata(config, counter, s, os);
 		}
 		print_metric_end(config);
 	}
@@ -901,34 +895,31 @@ static void print_aggr(struct perf_stat_config *config,
 
 static void print_aggr_cgroup(struct perf_stat_config *config,
 			      struct evlist *evlist,
-			      const char *prefix)
+			      struct outstate *os)
 {
 	struct evsel *counter, *evsel;
-	struct outstate os = {
-		.prefix = prefix,
-	};
 	int s;
 
 	if (!config->aggr_map || !config->aggr_get_id)
 		return;
 
 	evlist__for_each_entry(evlist, evsel) {
-		if (os.cgrp == evsel->cgrp)
+		if (os->cgrp == evsel->cgrp)
 			continue;
 
-		os.cgrp = evsel->cgrp;
+		os->cgrp = evsel->cgrp;
 
 		for (s = 0; s < config->aggr_map->nr; s++) {
-			print_metric_begin(config, evlist, &os, s);
+			print_metric_begin(config, evlist, os, s);
 
 			evlist__for_each_entry(evlist, counter) {
 				if (counter->merged_stat)
 					continue;
 
-				if (counter->cgrp != os.cgrp)
+				if (counter->cgrp != os->cgrp)
 					continue;
 
-				print_counter_aggrdata(config, counter, s, prefix);
+				print_counter_aggrdata(config, counter, s, os);
 			}
 			print_metric_end(config);
 		}
@@ -936,7 +927,7 @@ static void print_aggr_cgroup(struct perf_stat_config *config,
 }
 
 static void print_counter(struct perf_stat_config *config,
-			  struct evsel *counter, const char *prefix)
+			  struct evsel *counter, struct outstate *os)
 {
 	int s;
 
@@ -948,19 +939,16 @@ static void print_counter(struct perf_stat_config *config,
 		return;
 
 	for (s = 0; s < config->aggr_map->nr; s++) {
-		print_counter_aggrdata(config, counter, s, prefix);
+		print_counter_aggrdata(config, counter, s, os);
 	}
 }
 
 static void print_no_aggr_metric(struct perf_stat_config *config,
 				 struct evlist *evlist,
-				 const char *prefix)
+				 struct outstate *os)
 {
 	int all_idx;
 	struct perf_cpu cpu;
-	struct outstate os = {
-		.prefix = prefix,
-	};
 
 	perf_cpu_map__for_each_cpu(cpu, all_idx, evlist->core.user_requested_cpus) {
 		struct evsel *counter;
@@ -975,10 +963,10 @@ static void print_no_aggr_metric(struct perf_stat_config *config,
 			if (counter_idx < 0)
 				continue;
 
-			os.evsel = counter;
-			os.id = aggr_cpu_id__cpu(cpu, /*data=*/NULL);
+			os->evsel = counter;
+			os->id = aggr_cpu_id__cpu(cpu, /*data=*/NULL);
 			if (first) {
-				print_metric_begin(config, evlist, &os, counter_idx);
+				print_metric_begin(config, evlist, os, counter_idx);
 				first = false;
 			}
 			val = ps->aggr[counter_idx].counts.val;
@@ -986,7 +974,7 @@ static void print_no_aggr_metric(struct perf_stat_config *config,
 			run = ps->aggr[counter_idx].counts.run;
 
 			uval = val * counter->scale;
-			printout(config, &os, uval, run, ena, 1.0, counter_idx);
+			printout(config, os, uval, run, ena, 1.0, counter_idx);
 		}
 		if (!first)
 			print_metric_end(config);
@@ -1304,7 +1292,7 @@ static void print_footer(struct perf_stat_config *config)
 }
 
 static void print_percore(struct perf_stat_config *config,
-			  struct evsel *counter, const char *prefix)
+			  struct evsel *counter, struct outstate *os)
 {
 	bool metric_only = config->metric_only;
 	FILE *output = config->output;
@@ -1315,7 +1303,7 @@ static void print_percore(struct perf_stat_config *config,
 		return;
 
 	if (config->percore_show_thread)
-		return print_counter(config, counter, prefix);
+		return print_counter(config, counter, os);
 
 	core_map = cpu_aggr_map__empty_new(config->aggr_map->nr);
 	if (core_map == NULL) {
@@ -1337,7 +1325,7 @@ static void print_percore(struct perf_stat_config *config,
 		if (found)
 			continue;
 
-		print_counter_aggrdata(config, counter, s, prefix);
+		print_counter_aggrdata(config, counter, s, os);
 
 		core_map->map[c++] = core_id;
 	}
@@ -1348,30 +1336,28 @@ static void print_percore(struct perf_stat_config *config,
 }
 
 static void print_cgroup_counter(struct perf_stat_config *config, struct evlist *evlist,
-				 const char *prefix)
+				 struct outstate *os)
 {
 	struct evsel *counter;
-	struct outstate os = {
-		.prefix = prefix,
-	};
 
 	evlist__for_each_entry(evlist, counter) {
-		if (os.cgrp != counter->cgrp) {
-			if (os.cgrp != NULL)
+		if (os->cgrp != counter->cgrp) {
+			if (os->cgrp != NULL)
 				print_metric_end(config);
 
-			os.cgrp = counter->cgrp;
-			print_metric_begin(config, evlist, &os, /*aggr_idx=*/0);
+			os->cgrp = counter->cgrp;
+			print_metric_begin(config, evlist, os, /*aggr_idx=*/0);
 		}
 
-		print_counter(config, counter, prefix);
+		print_counter(config, counter, os);
 	}
-	if (os.cgrp)
+	if (os->cgrp)
 		print_metric_end(config);
 }
 
 void evlist__print_counters(struct evlist *evlist, struct perf_stat_config *config,
-			    struct target *_target, struct timespec *ts, int argc, const char **argv)
+			    struct target *_target, struct timespec *ts,
+			    int argc, const char **argv)
 {
 	bool metric_only = config->metric_only;
 	int interval = config->interval;
@@ -1397,34 +1383,34 @@ void evlist__print_counters(struct evlist *evlist, struct perf_stat_config *conf
 	case AGGR_SOCKET:
 	case AGGR_NODE:
 		if (config->cgroup_list)
-			print_aggr_cgroup(config, evlist, os.prefix);
+			print_aggr_cgroup(config, evlist, &os);
 		else
-			print_aggr(config, evlist, os.prefix);
+			print_aggr(config, evlist, &os);
 		break;
 	case AGGR_THREAD:
 	case AGGR_GLOBAL:
 		if (config->iostat_run) {
 			iostat_print_counters(evlist, config, ts, buf,
-					      print_counter);
+					      (iostat_print_counter_t)print_counter, &os);
 		} else if (config->cgroup_list) {
-			print_cgroup_counter(config, evlist, os.prefix);
+			print_cgroup_counter(config, evlist, &os);
 		} else {
 			print_metric_begin(config, evlist, &os, /*aggr_idx=*/0);
 			evlist__for_each_entry(evlist, counter) {
-				print_counter(config, counter, os.prefix);
+				print_counter(config, counter, &os);
 			}
 			print_metric_end(config);
 		}
 		break;
 	case AGGR_NONE:
 		if (metric_only)
-			print_no_aggr_metric(config, evlist, os.prefix);
+			print_no_aggr_metric(config, evlist, &os);
 		else {
 			evlist__for_each_entry(evlist, counter) {
 				if (counter->percore)
-					print_percore(config, counter, os.prefix);
+					print_percore(config, counter, &os);
 				else
-					print_counter(config, counter, os.prefix);
+					print_counter(config, counter, &os);
 			}
 		}
 		break;
-- 
2.38.1.584.g0f3c55d4c2-goog

