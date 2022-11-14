Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BEA7628D18
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 00:04:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237933AbiKNXEz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 18:04:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238030AbiKNXES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 18:04:18 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 656471D0DE;
        Mon, 14 Nov 2022 15:02:58 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id c2so11482944plz.11;
        Mon, 14 Nov 2022 15:02:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MYDLtl9GSeaGL91h5dtqz1M8wM/Y9pV3tpLuUgjiMtg=;
        b=ayXvD3OygUKKfObtjdGTFVNkWknwH+E13eYvu+k9krCNg5Btvpjz6mVtFwc/8LELoP
         fbP7RiLe343+ItXzBg1ctFyq2i3RM1J1dz0eWyw/jN7aayLwfGXK0begkf09MRyvWRbu
         oj91KwJ/gru84rlgl/Ak5ymKbJ+vGmJ4ZVA0XuoyewFHDUuLTpL4bn47/hUWr4VjzVXa
         1QAwSMD3SzyV2WiUJvW8CuAO76u0OoQPwfV5NX/Qlrt4lhQWnevME/UymPFsxAMmnNvD
         hA2l8uHFhIKZRuuSWJ1eaCPsU0YUjTXGhrzApyzdcH6GCC8zouonJ8idHnX0P+OSgFdI
         HY4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MYDLtl9GSeaGL91h5dtqz1M8wM/Y9pV3tpLuUgjiMtg=;
        b=5mCKBWIBgknyix/7S5CwJsMqN/4Z2kJxWvx6JyKoKDJFpNge0/P2x9OO8bA4yIK9TG
         8fipPSb7YsWjZ8wMNWafq7sBYFx6OjuWexq1vWYSP7k2Eybprh1gKQT1pS6Su0n33w8J
         CJsOdtdZb32knyOMm5fqn4wtmZ5QfMg3LqItKlw/t2Vm7Y2lrhssTe5Q2DbfSniuXtIJ
         1kBZlI2grfhG0iEKKTCkmqeWNY84cx6Nh1Ada4GK7Lq/hhqKlWzkWnsxeyJ0OYFDqEQe
         0+hakE8F8wyQmjwDCl+5YtvAbZgXAFgzTK3W7AjTuvpi0/L5ifSJ64LSpVyWFaUrrebW
         KpMw==
X-Gm-Message-State: ANoB5pkisqhKURRvCCtftYK3kxllhbDLJa/X0U7CwaRyvkg7Zfi4LE/j
        DBmmfQFV6Cq5d7pBSUAsb0g=
X-Google-Smtp-Source: AA0mqf5TVfG64YT3JMmBzjZClMYJK+r+Q5Xn8LxEQndZ1J9jC8jSCVzVFBRAzY6P9SrySuYzGvrL9Q==
X-Received: by 2002:a17:90a:9dc5:b0:20b:2c3b:4b79 with SMTP id x5-20020a17090a9dc500b0020b2c3b4b79mr15748935pjv.236.1668466977858;
        Mon, 14 Nov 2022 15:02:57 -0800 (PST)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:a80:cf9f:e038:c19b:797e])
        by smtp.gmail.com with ESMTPSA id 132-20020a62148a000000b0056c814a501dsm7534724pfu.10.2022.11.14.15.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 15:02:57 -0800 (PST)
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
Subject: [PATCH 18/19] perf stat: Support --for-each-cgroup and --metric-only
Date:   Mon, 14 Nov 2022 15:02:26 -0800
Message-Id: <20221114230227.1255976-19-namhyung@kernel.org>
X-Mailer: git-send-email 2.38.1.493.g58b659f92b-goog
In-Reply-To: <20221114230227.1255976-1-namhyung@kernel.org>
References: <20221114230227.1255976-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we have events for each cgroup, the metric should be printed for
each cgroup separately.  Add print_cgroup_counter() to handle that
situation properly.

Also change print_metric_headers() not to print duplicate headers
by checking cgroups.

  $ perf stat -a --for-each-cgroup system.slice,user.slice --metric-only sleep 1

   Performance counter stats for 'system wide':

                                     GHz       insn per cycle branch-misses of all branches
   system.slice                   3.792                0.61                                3.24%
   user.slice                     3.661                2.32                                0.37%

         1.016111516 seconds time elapsed

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/stat-display.c | 58 +++++++++++++++++++++++++++-------
 1 file changed, 47 insertions(+), 11 deletions(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 7a0673be720b..cf25ed99b5df 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -168,10 +168,10 @@ static void print_cgroup_json(struct perf_stat_config *config, const char *cgrp_
 	fprintf(config->output, "\"cgroup\" : \"%s\", ", cgrp_name);
 }
 
-static void print_cgroup(struct perf_stat_config *config, struct evsel *evsel)
+static void print_cgroup(struct perf_stat_config *config, struct cgroup *cgrp)
 {
-	if (nr_cgroups) {
-		const char *cgrp_name = evsel->cgrp ? evsel->cgrp->name  : "";
+	if (nr_cgroups || config->cgroup_list) {
+		const char *cgrp_name = cgrp ? cgrp->name  : "";
 
 		if (config->json_output)
 			print_cgroup_json(config, cgrp_name);
@@ -340,6 +340,7 @@ struct outstate {
 	int  nr;
 	struct aggr_cpu_id id;
 	struct evsel *evsel;
+	struct cgroup *cgrp;
 };
 
 static void new_line_std(struct perf_stat_config *config __maybe_unused,
@@ -552,6 +553,9 @@ static void print_metric_header(struct perf_stat_config *config,
 	    os->evsel->priv != os->evsel->evlist->selected->priv)
 		return;
 
+	if (os->evsel->cgrp != os->cgrp)
+		return;
+
 	if (!valid_only_metric(unit))
 		return;
 	unit = fixunit(tbuf, os->evsel, unit);
@@ -642,7 +646,7 @@ static void abs_printout(struct perf_stat_config *config,
 {
 	aggr_printout(config, evsel, id, nr);
 	print_counter_value(config, evsel, avg, ok);
-	print_cgroup(config, evsel);
+	print_cgroup(config, evsel->cgrp);
 }
 
 static bool is_mixed_hw_group(struct evsel *counter)
@@ -838,7 +842,8 @@ static void print_counter_aggrdata(struct perf_stat_config *config,
 
 static void print_metric_begin(struct perf_stat_config *config,
 			       struct evlist *evlist,
-			       char *prefix, int aggr_idx)
+			       char *prefix, int aggr_idx,
+			       struct cgroup *cgrp)
 {
 	struct perf_stat_aggr *aggr;
 	struct aggr_cpu_id id;
@@ -854,6 +859,8 @@ static void print_metric_begin(struct perf_stat_config *config,
 	id = config->aggr_map->map[aggr_idx];
 	aggr = &evsel->stats->aggr[aggr_idx];
 	aggr_printout(config, evsel, id, aggr->nr);
+
+	print_cgroup(config, cgrp);
 }
 
 static void print_metric_end(struct perf_stat_config *config)
@@ -880,7 +887,7 @@ static void print_aggr(struct perf_stat_config *config,
 	 * Without each counter has its own line.
 	 */
 	for (s = 0; s < config->aggr_map->nr; s++) {
-		print_metric_begin(config, evlist, prefix, s);
+		print_metric_begin(config, evlist, prefix, s, /*cgrp=*/NULL);
 
 		evlist__for_each_entry(evlist, counter) {
 			if (counter->merged_stat)
@@ -935,7 +942,8 @@ static void print_no_aggr_metric(struct perf_stat_config *config,
 
 			id = aggr_cpu_id__cpu(cpu, /*data=*/NULL);
 			if (first) {
-				print_metric_begin(config, evlist, prefix, counter_idx);
+				print_metric_begin(config, evlist, prefix,
+						   counter_idx, /*cgrp=*/NULL);
 				first = false;
 			}
 			val = ps->aggr[counter_idx].counts.val;
@@ -960,7 +968,7 @@ static void print_metric_headers_std(struct perf_stat_config *config,
 	if (!no_indent) {
 		int len = aggr_header_lens[config->aggr_mode];
 
-		if (nr_cgroups)
+		if (nr_cgroups || config->cgroup_list)
 			len += CGROUP_LEN + 1;
 
 		fprintf(config->output, "%*s", len, "");
@@ -1012,6 +1020,9 @@ static void print_metric_headers(struct perf_stat_config *config,
 	if (config->iostat_run)
 		iostat_print_header_prefix(config);
 
+	if (config->cgroup_list)
+		os.cgrp = evlist__first(evlist)->cgrp;
+
 	/* Print metrics headers only */
 	evlist__for_each_entry(evlist, counter) {
 		os.evsel = counter;
@@ -1305,6 +1316,28 @@ static void print_percore(struct perf_stat_config *config,
 		fputc('\n', output);
 }
 
+static void print_cgroup_counter(struct perf_stat_config *config, struct evlist *evlist,
+				 char *prefix)
+{
+	struct cgroup *cgrp = NULL;
+	struct evsel *counter;
+
+	evlist__for_each_entry(evlist, counter) {
+		if (cgrp != counter->cgrp) {
+			if (cgrp != NULL)
+				print_metric_end(config);
+
+			cgrp = counter->cgrp;
+			print_metric_begin(config, evlist, prefix,
+					   /*aggr_idx=*/0, cgrp);
+		}
+
+		print_counter(config, counter, prefix);
+	}
+	if (cgrp)
+		print_metric_end(config);
+}
+
 void evlist__print_counters(struct evlist *evlist, struct perf_stat_config *config,
 			    struct target *_target, struct timespec *ts, int argc, const char **argv)
 {
@@ -1332,11 +1365,14 @@ void evlist__print_counters(struct evlist *evlist, struct perf_stat_config *conf
 		break;
 	case AGGR_THREAD:
 	case AGGR_GLOBAL:
-		if (config->iostat_run)
+		if (config->iostat_run) {
 			iostat_print_counters(evlist, config, ts, prefix = buf,
 					      print_counter);
-		else {
-			print_metric_begin(config, evlist, prefix, /*aggr_idx=*/0);
+		} else if (config->cgroup_list) {
+			print_cgroup_counter(config, evlist, prefix);
+		} else {
+			print_metric_begin(config, evlist, prefix,
+					   /*aggr_idx=*/0, /*cgrp=*/NULL);
 			evlist__for_each_entry(evlist, counter) {
 				print_counter(config, counter, prefix);
 			}
-- 
2.38.1.493.g58b659f92b-goog

