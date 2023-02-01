Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 706C0679108
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 07:35:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233248AbjAXGe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 01:34:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233335AbjAXGer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 01:34:47 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BC1C3D930
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 22:34:19 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-4d4b54d0731so143784487b3.18
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 22:34:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OBn5Y2//Eo6oNIMMK9wBJfM2lVt0TpL9hFeMLIkCb84=;
        b=VbiAlV566W8BcZzTiYIJsdKZM9D4RJcp+8b9AmI3YWoFQS0vWZcmYp39M6IyCyJMQ8
         5k3Fmj7omdaZFFvPPfxuEphMIxDSXtLFV4VgKMnalM88qGLbXcY+1Fml8hNOCZpFGFF0
         YOcQFiyoHRRHmc5fT9jZSvSYIKeI4D9ogMYGDZFr/4NKvNipo0ZS8FyIomcMZtwAool5
         pZybwJMm17m/oTPBm7LGHEOVkExhFJJIMCML8mU56T85eJS5eAHYicSL3LSSSZwNflaw
         NDBn9khAlYqQa47cK8utfNv/urMigVllQJVZQc8lTFGc8sW0pJn1ZeNZGjagP7LjrTtq
         sQCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OBn5Y2//Eo6oNIMMK9wBJfM2lVt0TpL9hFeMLIkCb84=;
        b=iE+f3FGiC6Jqd2q6/qDmK6T9mxpLv7ypeMsjGczSVTDmBSaFNawJsZrqfJ2XJnDVaN
         4SRRyTD2MJW3nbOVS9N4r/0SVZeqJsW17z206hq4jK/FAkFEL2UuEwGmWZru63bPV4eY
         6hC0LM23rdF0G+L61wpT0WC7THKebHXrGYhSZbR9oKaPfuQBCDizIX5FH+BUPjMoMBLX
         yD/N/82tY1pbgvgMYv5K/V1ybJo2TTbImMm5rW5+YqAoglqhIKV0J5ELRKRjTsubOrI5
         eJcEp/a0lrI/bwUmcId+bLycvhPIQC30fgB0jKwvIpnw1zUGXNxkprv/GI7iNakFe3dR
         zFGw==
X-Gm-Message-State: AFqh2kr/R3Luo7snnTGHnNoMcDh8NsI4dintik2K5NZvogrkHq+p5YVr
        97iZZ3vNQLXq1FjJasWK220sJ3oShofa
X-Google-Smtp-Source: AMrXdXtjzAnFGUH+D3iFKg8PZ4idgaV33fF0x9+0tKZVdRtaLfAFWr+Vz22S7lqRjhACrGvGvfCVpesFvrjK
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:460d:1b4a:acb8:ae9a])
 (user=irogers job=sendgmr) by 2002:a05:690c:dc3:b0:4fc:f2fc:526 with SMTP id
 db3-20020a05690c0dc300b004fcf2fc0526mr2042491ywb.116.1674542058813; Mon, 23
 Jan 2023 22:34:18 -0800 (PST)
Date:   Mon, 23 Jan 2023 22:33:15 -0800
In-Reply-To: <20230124063320.668917-1-irogers@google.com>
Message-Id: <20230124063320.668917-7-irogers@google.com>
Mime-Version: 1.0
References: <20230124063320.668917-1-irogers@google.com>
X-Mailer: git-send-email 2.39.0.246.g2a6d74b583-goog
Subject: [PATCH v3 06/11] perf pmu-events: Remove now unused event and metric variables
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
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Rob Herring <robh@kernel.org>,
        Kang Minchul <tegongkang@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sandipan Das <sandipan.das@amd.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        linuxppc-dev@lists.ozlabs.org, Kajol Jain <kjain@linux.ibm.com>
Cc:     Stephane Eranian <eranian@google.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previous changes separated the uses of pmu_event and pmu_metric,
however, both structures contained all the variables of event and
metric. This change removes the event variables from metric and the
metric variables from event.

Note, this change removes the setting of evsel's metric_name/expr as
these fields are no longer part of struct pmu_event. The metric
remains but is no longer implicitly requested when the event is. This
impacts a few Intel uncore events, however, as the ScaleUnit is shared
by the event and the metric this utility is questionable. Also the
MetricNames look broken (contain spaces) in some cases and when trying
to use the functionality with '-e' the metrics fail but regular
metrics with '-M' work. For example, on SkylakeX '-M' works:

```
$ perf stat -M LLC_MISSES.PCIE_WRITE -a sleep 1

 Performance counter stats for 'system wide':

                 0      UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART2 #  57896.0 Bytes  LLC_MISSES.PCIE_WRITE  (49.84%)
             7,174      UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART1                                        (49.85%)
                 0      UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART3                                        (50.16%)
                63      UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART0                                        (50.15%)

       1.004576381 seconds time elapsed
```

whilst the event '-e' version is broken even with --group/-g (fwiw, we should also remove -g [1]):

```
$ perf stat -g -e LLC_MISSES.PCIE_WRITE -g -a sleep 1
Add UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART2 event to groups to get metric expression for LLC_MISSES.PCIE_WRITE
Add UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART1 event to groups to get metric expression for LLC_MISSES.PCIE_WRITE
Add UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART3 event to groups to get metric expression for LLC_MISSES.PCIE_WRITE
Add UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART0 event to groups to get metric expression for LLC_MISSES.PCIE_WRITE
Add UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART2 event to groups to get metric expression for LLC_MISSES.PCIE_WRITE
Add UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART1 event to groups to get metric expression for LLC_MISSES.PCIE_WRITE
Add UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART3 event to groups to get metric expression for LLC_MISSES.PCIE_WRITE
Add UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART0 event to groups to get metric expression for LLC_MISSES.PCIE_WRITE
Add UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART2 event to groups to get metric expression for LLC_MISSES.PCIE_WRITE
Add UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART1 event to groups to get metric expression for LLC_MISSES.PCIE_WRITE
Add UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART3 event to groups to get metric expression for LLC_MISSES.PCIE_WRITE
Add UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART0 event to groups to get metric expression for LLC_MISSES.PCIE_WRITE
Add UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART2 event to groups to get metric expression for LLC_MISSES.PCIE_WRITE
Add UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART1 event to groups to get metric expression for LLC_MISSES.PCIE_WRITE
Add UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART3 event to groups to get metric expression for LLC_MISSES.PCIE_WRITE
Add UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART0 event to groups to get metric expression for LLC_MISSES.PCIE_WRITE
Add UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART2 event to groups to get metric expression for LLC_MISSES.PCIE_WRITE
Add UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART1 event to groups to get metric expression for LLC_MISSES.PCIE_WRITE
Add UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART3 event to groups to get metric expression for LLC_MISSES.PCIE_WRITE
Add UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART0 event to groups to get metric expression for LLC_MISSES.PCIE_WRITE
Add UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART2 event to groups to get metric expression for LLC_MISSES.PCIE_WRITE
Add UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART1 event to groups to get metric expression for LLC_MISSES.PCIE_WRITE
Add UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART3 event to groups to get metric expression for LLC_MISSES.PCIE_WRITE
Add UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART0 event to groups to get metric expression for LLC_MISSES.PCIE_WRITE

 Performance counter stats for 'system wide':

            27,316 Bytes LLC_MISSES.PCIE_WRITE

       1.004505469 seconds time elapsed
```

The code also carries warnings where the user is supposed to select
events for metrics [2] but given the lack of use of such a feature,
let's clean the code and just remove.

[1] https://lore.kernel.org/lkml/20220707195610.303254-1-irogers@google.com/
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/perf/util/stat-shadow.c?id=01b8957b738f42f96a130079bc951b3cc78c5b8a#n425

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-list.c          | 20 ++---------------
 tools/perf/pmu-events/jevents.py   | 20 +++++++++++++----
 tools/perf/pmu-events/pmu-events.h | 22 +++++--------------
 tools/perf/tests/pmu-events.c      | 27 -----------------------
 tools/perf/util/parse-events.c     |  2 --
 tools/perf/util/pmu.c              | 35 +++---------------------------
 tools/perf/util/pmu.h              |  9 --------
 tools/perf/util/print-events.c     | 32 +++++++--------------------
 tools/perf/util/print-events.h     |  3 +--
 9 files changed, 36 insertions(+), 134 deletions(-)

diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
index 137d73edb541..791f513ae5b4 100644
--- a/tools/perf/builtin-list.c
+++ b/tools/perf/builtin-list.c
@@ -99,8 +99,7 @@ static void default_print_event(void *ps, const char *pmu_name, const char *topi
 				const char *scale_unit __maybe_unused,
 				bool deprecated, const char *event_type_desc,
 				const char *desc, const char *long_desc,
-				const char *encoding_desc,
-				const char *metric_name, const char *metric_expr)
+				const char *encoding_desc)
 {
 	struct print_state *print_state = ps;
 	int pos;
@@ -159,10 +158,6 @@ static void default_print_event(void *ps, const char *pmu_name, const char *topi
 	if (print_state->detailed && encoding_desc) {
 		printf("%*s", 8, "");
 		wordwrap(encoding_desc, 8, pager_get_columns(), 0);
-		if (metric_name)
-			printf(" MetricName: %s", metric_name);
-		if (metric_expr)
-			printf(" MetricExpr: %s", metric_expr);
 		putchar('\n');
 	}
 }
@@ -308,8 +303,7 @@ static void json_print_event(void *ps, const char *pmu_name, const char *topic,
 			     const char *scale_unit,
 			     bool deprecated, const char *event_type_desc,
 			     const char *desc, const char *long_desc,
-			     const char *encoding_desc,
-			     const char *metric_name, const char *metric_expr)
+			     const char *encoding_desc)
 {
 	struct json_print_state *print_state = ps;
 	bool need_sep = false;
@@ -366,16 +360,6 @@ static void json_print_event(void *ps, const char *pmu_name, const char *topic,
 				  encoding_desc);
 		need_sep = true;
 	}
-	if (metric_name) {
-		fix_escape_printf(&buf, "%s\t\"MetricName\": \"%S\"", need_sep ? ",\n" : "",
-				  metric_name);
-		need_sep = true;
-	}
-	if (metric_expr) {
-		fix_escape_printf(&buf, "%s\t\"MetricExpr\": \"%S\"", need_sep ? ",\n" : "",
-				  metric_expr);
-		need_sep = true;
-	}
 	printf("%s}", need_sep ? "\n" : "");
 	strbuf_release(&buf);
 }
diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index 8df14ab14fcf..4cdbf34b7298 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -37,6 +37,11 @@ _json_event_attributes = [
     'metric_constraint', 'metric_expr', 'long_desc'
 ]
 
+# Attributes that are in pmu_metric rather than pmu_event.
+_json_metric_attributes = [
+    'metric_name', 'metric_group', 'metric_constraint', 'metric_expr', 'desc',
+    'long_desc', 'unit', 'compat', 'aggr_mode'
+]
 
 def removesuffix(s: str, suffix: str) -> str:
   """Remove the suffix from a string
@@ -569,21 +574,28 @@ static void decompress_event(int offset, struct pmu_event *pe)
 \tconst char *p = &big_c_string[offset];
 """)
   for attr in _json_event_attributes:
-    _args.output_file.write(f"""
+    if attr in _json_metric_attributes and 'metric_' in attr:
+      _args.output_file.write(f'\n\t/* Skip {attr} */\n')
+    else:
+      _args.output_file.write(f"""
 \tpe->{attr} = (*p == '\\0' ? NULL : p);
 """)
     if attr == _json_event_attributes[-1]:
       continue
     _args.output_file.write('\twhile (*p++);')
   _args.output_file.write("""}
-static void decompress_metric(int offset, struct pmu_metric *pe)
+
+static void decompress_metric(int offset, struct pmu_metric *pm)
 {
 \tconst char *p = &big_c_string[offset];
 """)
   for attr in _json_event_attributes:
-    _args.output_file.write(f"""
-\tpe->{attr} = (*p == '\\0' ? NULL : p);
+    if attr in _json_metric_attributes:
+      _args.output_file.write(f"""
+\tpm->{attr} = (*p == '\\0' ? NULL : p);
 """)
+    else:
+      _args.output_file.write(f'\n\t/* Skip {attr} */\n')
     if attr == _json_event_attributes[-1]:
       continue
     _args.output_file.write('\twhile (*p++);')
diff --git a/tools/perf/pmu-events/pmu-events.h b/tools/perf/pmu-events/pmu-events.h
index e2cd3e61acef..dca32979d6a4 100644
--- a/tools/perf/pmu-events/pmu-events.h
+++ b/tools/perf/pmu-events/pmu-events.h
@@ -23,29 +23,19 @@ struct pmu_event {
 	const char *unit;
 	const char *perpkg;
 	const char *aggr_mode;
-	const char *metric_expr;
-	const char *metric_name;
-	const char *metric_group;
 	const char *deprecated;
-	const char *metric_constraint;
 };
 
 struct pmu_metric {
-	const char *name;
-	const char *compat;
-	const char *event;
-	const char *desc;
-	const char *topic;
-	const char *long_desc;
-	const char *pmu;
-	const char *unit;
-	const char *perpkg;
-	const char *aggr_mode;
-	const char *metric_expr;
 	const char *metric_name;
 	const char *metric_group;
-	const char *deprecated;
+	const char *metric_expr;
+	const char *unit;
+	const char *compat;
+	const char *aggr_mode;
 	const char *metric_constraint;
+	const char *desc;
+	const char *long_desc;
 };
 
 struct pmu_events_table;
diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
index e5fb3d5a06c3..c2b3ada57cbc 100644
--- a/tools/perf/tests/pmu-events.c
+++ b/tools/perf/tests/pmu-events.c
@@ -337,36 +337,12 @@ static int compare_pmu_events(const struct pmu_event *e1, const struct pmu_event
 		return -1;
 	}
 
-	if (!is_same(e1->metric_expr, e2->metric_expr)) {
-		pr_debug2("testing event e1 %s: mismatched metric_expr, %s vs %s\n",
-			  e1->name, e1->metric_expr, e2->metric_expr);
-		return -1;
-	}
-
-	if (!is_same(e1->metric_name, e2->metric_name)) {
-		pr_debug2("testing event e1 %s: mismatched metric_name, %s vs %s\n",
-			  e1->name,	e1->metric_name, e2->metric_name);
-		return -1;
-	}
-
-	if (!is_same(e1->metric_group, e2->metric_group)) {
-		pr_debug2("testing event e1 %s: mismatched metric_group, %s vs %s\n",
-			  e1->name, e1->metric_group, e2->metric_group);
-		return -1;
-	}
-
 	if (!is_same(e1->deprecated, e2->deprecated)) {
 		pr_debug2("testing event e1 %s: mismatched deprecated, %s vs %s\n",
 			  e1->name, e1->deprecated, e2->deprecated);
 		return -1;
 	}
 
-	if (!is_same(e1->metric_constraint, e2->metric_constraint)) {
-		pr_debug2("testing event e1 %s: mismatched metric_constant, %s vs %s\n",
-			  e1->name, e1->metric_constraint, e2->metric_constraint);
-		return -1;
-	}
-
 	return 0;
 }
 
@@ -432,9 +408,6 @@ static int test__pmu_event_table_core_callback(const struct pmu_event *pe,
 	struct perf_pmu_test_event const **test_event_table;
 	bool found = false;
 
-	if (!pe->name)
-		return 0;
-
 	if (pe->pmu)
 		test_event_table = &uncore_events[0];
 	else
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 21cce83462b3..0336ff27c15f 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1570,8 +1570,6 @@ int parse_events_add_pmu(struct parse_events_state *parse_state,
 	evsel->scale = info.scale;
 	evsel->per_pkg = info.per_pkg;
 	evsel->snapshot = info.snapshot;
-	evsel->metric_expr = info.metric_expr;
-	evsel->metric_name = info.metric_name;
 	return 0;
 }
 
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 3a67b17b4a16..f8c214d8815f 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -280,10 +280,6 @@ static void perf_pmu_update_alias(struct perf_pmu_alias *old,
 	perf_pmu_assign_str(old->name, "long_desc", &old->long_desc,
 			    &newalias->long_desc);
 	perf_pmu_assign_str(old->name, "topic", &old->topic, &newalias->topic);
-	perf_pmu_assign_str(old->name, "metric_expr", &old->metric_expr,
-			    &newalias->metric_expr);
-	perf_pmu_assign_str(old->name, "metric_name", &old->metric_name,
-			    &newalias->metric_name);
 	perf_pmu_assign_str(old->name, "value", &old->str, &newalias->str);
 	old->scale = newalias->scale;
 	old->per_pkg = newalias->per_pkg;
@@ -299,8 +295,6 @@ void perf_pmu_free_alias(struct perf_pmu_alias *newalias)
 	zfree(&newalias->long_desc);
 	zfree(&newalias->topic);
 	zfree(&newalias->str);
-	zfree(&newalias->metric_expr);
-	zfree(&newalias->metric_name);
 	zfree(&newalias->pmu_name);
 	parse_events_terms__purge(&newalias->terms);
 	free(newalias);
@@ -337,16 +331,13 @@ static int __perf_pmu__new_alias(struct list_head *list, char *dir, char *name,
 	int num;
 	char newval[256];
 	char *long_desc = NULL, *topic = NULL, *unit = NULL, *perpkg = NULL,
-	     *metric_expr = NULL, *metric_name = NULL, *deprecated = NULL,
-	     *pmu_name = NULL;
+	     *deprecated = NULL, *pmu_name = NULL;
 
 	if (pe) {
 		long_desc = (char *)pe->long_desc;
 		topic = (char *)pe->topic;
 		unit = (char *)pe->unit;
 		perpkg = (char *)pe->perpkg;
-		metric_expr = (char *)pe->metric_expr;
-		metric_name = (char *)pe->metric_name;
 		deprecated = (char *)pe->deprecated;
 		pmu_name = (char *)pe->pmu;
 	}
@@ -401,8 +392,6 @@ static int __perf_pmu__new_alias(struct list_head *list, char *dir, char *name,
 		perf_pmu__parse_snapshot(alias, dir, name);
 	}
 
-	alias->metric_expr = metric_expr ? strdup(metric_expr) : NULL;
-	alias->metric_name = metric_name ? strdup(metric_name): NULL;
 	alias->desc = desc ? strdup(desc) : NULL;
 	alias->long_desc = long_desc ? strdup(long_desc) :
 				desc ? strdup(desc) : NULL;
@@ -756,9 +745,6 @@ static int pmu_add_cpu_aliases_map_callback(const struct pmu_event *pe,
 	struct pmu_add_cpu_aliases_map_data *data = vdata;
 	const char *pname = pe->pmu ? pe->pmu : data->cpu_name;
 
-	if (!pe->name)
-		return 0;
-
 	if (data->pmu->is_uncore && pmu_uncore_alias_match(pname, data->name))
 		goto new_alias;
 
@@ -813,12 +799,6 @@ static int pmu_add_sys_aliases_iter_fn(const struct pmu_event *pe,
 	struct pmu_sys_event_iter_data *idata = data;
 	struct perf_pmu *pmu = idata->pmu;
 
-	if (!pe->name) {
-		if (pe->metric_group || pe->metric_name)
-			return 0;
-		return -EINVAL;
-	}
-
 	if (!pe->compat || !pe->pmu)
 		return 0;
 
@@ -1400,8 +1380,6 @@ int perf_pmu__check_alias(struct perf_pmu *pmu, struct list_head *head_terms,
 	info->unit     = NULL;
 	info->scale    = 0.0;
 	info->snapshot = false;
-	info->metric_expr = NULL;
-	info->metric_name = NULL;
 
 	list_for_each_entry_safe(term, h, head_terms, list) {
 		alias = pmu_find_alias(pmu, term);
@@ -1417,8 +1395,6 @@ int perf_pmu__check_alias(struct perf_pmu *pmu, struct list_head *head_terms,
 
 		if (alias->per_pkg)
 			info->per_pkg = true;
-		info->metric_expr = alias->metric_expr;
-		info->metric_name = alias->metric_name;
 
 		list_del_init(&term->list);
 		parse_events_term__delete(term);
@@ -1634,8 +1610,7 @@ void print_pmu_events(const struct print_callbacks *print_cb, void *print_state)
 	for (j = 0; j < len; j++) {
 		const char *name, *alias = NULL, *scale_unit = NULL,
 			*desc = NULL, *long_desc = NULL,
-			*encoding_desc = NULL, *topic = NULL,
-			*metric_name = NULL, *metric_expr = NULL;
+			*encoding_desc = NULL, *topic = NULL;
 		bool deprecated = false;
 		size_t buf_used;
 
@@ -1673,8 +1648,6 @@ void print_pmu_events(const struct print_callbacks *print_cb, void *print_state)
 			buf_used += snprintf(buf + buf_used, sizeof(buf) - buf_used,
 					"%s/%s/", aliases[j].pmu->name,
 					aliases[j].event->str) + 1;
-			metric_name = aliases[j].event->metric_name;
-			metric_expr = aliases[j].event->metric_expr;
 			deprecated = aliases[j].event->deprecated;
 		}
 		print_cb->print_event(print_state,
@@ -1687,9 +1660,7 @@ void print_pmu_events(const struct print_callbacks *print_cb, void *print_state)
 				"Kernel PMU event",
 				desc,
 				long_desc,
-				encoding_desc,
-				metric_name,
-				metric_expr);
+				encoding_desc);
 	}
 	if (printed && pager_in_use())
 		printf("\n");
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 2bdc560f19c7..64c596a358cc 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -132,8 +132,6 @@ extern struct perf_pmu perf_pmu__fake;
 
 struct perf_pmu_info {
 	const char *unit;
-	const char *metric_expr;
-	const char *metric_name;
 	double scale;
 	bool per_pkg;
 	bool snapshot;
@@ -187,13 +185,6 @@ struct perf_pmu_alias {
 	 * default.
 	 */
 	bool deprecated;
-	/**
-	 * @metric_expr: A metric expression associated with an event. Doing
-	 * this makes little sense due to scale and unit applying to both.
-	 */
-	char *metric_expr;
-	/** @metric_name: A name for the metric. unit applying to both. */
-	char *metric_name;
 	/** @pmu_name: The name copied from struct perf_pmu. */
 	char *pmu_name;
 };
diff --git a/tools/perf/util/print-events.c b/tools/perf/util/print-events.c
index 2646ae18d9f9..62e9ea7dcf40 100644
--- a/tools/perf/util/print-events.c
+++ b/tools/perf/util/print-events.c
@@ -101,9 +101,7 @@ void print_tracepoint_events(const struct print_callbacks *print_cb, void *print
 					"Tracepoint event",
 					/*desc=*/NULL,
 					/*long_desc=*/NULL,
-					/*encoding_desc=*/NULL,
-					/*metric_name=*/NULL,
-					/*metric_expr=*/NULL);
+					/*encoding_desc=*/NULL);
 		}
 		free(dir_path);
 		free(evt_namelist);
@@ -195,9 +193,7 @@ void print_sdt_events(const struct print_callbacks *print_cb, void *print_state)
 				"SDT event",
 				/*desc=*/NULL,
 				/*long_desc=*/NULL,
-				/*encoding_desc=*/NULL,
-				/*metric_name=*/NULL,
-				/*metric_expr=*/NULL);
+				/*encoding_desc=*/NULL);
 
 		free(evt_name);
 	}
@@ -255,9 +251,7 @@ int print_hwcache_events(const struct print_callbacks *print_cb, void *print_sta
 				event_type_descriptors[PERF_TYPE_HW_CACHE],
 				/*desc=*/NULL,
 				/*long_desc=*/NULL,
-				/*encoding_desc=*/NULL,
-				/*metric_name=*/NULL,
-				/*metric_expr=*/NULL);
+				/*encoding_desc=*/NULL);
 	}
 	strlist__delete(evt_name_list);
 	return 0;
@@ -277,9 +271,7 @@ void print_tool_events(const struct print_callbacks *print_cb, void *print_state
 				"Tool event",
 				/*desc=*/NULL,
 				/*long_desc=*/NULL,
-				/*encoding_desc=*/NULL,
-				/*metric_name=*/NULL,
-				/*metric_expr=*/NULL);
+				/*encoding_desc=*/NULL);
 	}
 }
 
@@ -331,9 +323,7 @@ void print_symbol_events(const struct print_callbacks *print_cb, void *print_sta
 				event_type_descriptors[type],
 				/*desc=*/NULL,
 				/*long_desc=*/NULL,
-				/*encoding_desc=*/NULL,
-				/*metric_name=*/NULL,
-				/*metric_expr=*/NULL);
+				/*encoding_desc=*/NULL);
 	}
 	strlist__delete(evt_name_list);
 }
@@ -364,9 +354,7 @@ void print_events(const struct print_callbacks *print_cb, void *print_state)
 			event_type_descriptors[PERF_TYPE_RAW],
 			/*desc=*/NULL,
 			/*long_desc=*/NULL,
-			/*encoding_desc=*/NULL,
-			/*metric_name=*/NULL,
-			/*metric_expr=*/NULL);
+			/*encoding_desc=*/NULL);
 
 	print_cb->print_event(print_state,
 			/*topic=*/NULL,
@@ -378,9 +366,7 @@ void print_events(const struct print_callbacks *print_cb, void *print_state)
 			event_type_descriptors[PERF_TYPE_RAW],
 			"(see 'man perf-list' on how to encode it)",
 			/*long_desc=*/NULL,
-			/*encoding_desc=*/NULL,
-			/*metric_name=*/NULL,
-			/*metric_expr=*/NULL);
+			/*encoding_desc=*/NULL);
 
 	print_cb->print_event(print_state,
 			/*topic=*/NULL,
@@ -392,9 +378,7 @@ void print_events(const struct print_callbacks *print_cb, void *print_state)
 			event_type_descriptors[PERF_TYPE_BREAKPOINT],
 			/*desc=*/NULL,
 			/*long_desc=*/NULL,
-			/*encoding_desc=*/NULL,
-			/*metric_name=*/NULL,
-			/*metric_expr=*/NULL);
+			/*encoding_desc=*/NULL);
 
 	print_tracepoint_events(print_cb, print_state);
 
diff --git a/tools/perf/util/print-events.h b/tools/perf/util/print-events.h
index c237e53c4487..716dcf4b4859 100644
--- a/tools/perf/util/print-events.h
+++ b/tools/perf/util/print-events.h
@@ -16,8 +16,7 @@ struct print_callbacks {
 			const char *scale_unit,
 			bool deprecated, const char *event_type_desc,
 			const char *desc, const char *long_desc,
-			const char *encoding_desc,
-			const char *metric_name, const char *metric_expr);
+			const char *encoding_desc);
 	void (*print_metric)(void *print_state,
 			const char *group,
 			const char *name,
-- 
2.39.0.246.g2a6d74b583-goog

