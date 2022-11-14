Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F545628818
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 19:14:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237555AbiKNSOZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 13:14:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238304AbiKNSNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 13:13:55 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C76F923BC7
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 10:13:47 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-373569200ceso111806947b3.4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 10:13:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9hnG/tZfedfD7kZp3YcxBNSD1DkQV4xbq+gqS8LIB1s=;
        b=HyrY1Y+Xx86vg03nHkyU3umeFhhUR4CLNDRYP4KrojHNuXKY/D4P9BxYVco/N9GbPL
         i6W2IQXpl1rwPi9h1dwBOC+QVQSVuosYPrnObBug5QzAq63R8rOfaZJOqbpYa09K+L+u
         fj/dOq1eSB7ZP+1EgFIjL1UjD1cwNnkGgakJ9UT1lFFj/m1+gz5MmO6MnaK1Q2WuxnHi
         XxizBmJuqGs11LBseX8QO7ZfuLjfONuDot9BaZFDvf1KwRoRHrEWFu5WvHbhCYME1JTr
         xCxPSJflHJVoYcKh4DxOq2dHbk79l5yv97EF4BErWnq8BQqyNqXuHkMc5Ad+OPwKYh0D
         YAnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9hnG/tZfedfD7kZp3YcxBNSD1DkQV4xbq+gqS8LIB1s=;
        b=3pyqtO8GgBkRDJ74KN6NMt4lJBPK9bU1EhudVh1Q2CH5x8kqPXI3aO7vEi/Bor2M6i
         2FqayHL4xKmNtIMt9vgiCWAmHcBAcO2ZFcpQ+DCi1MMfB0zrzNyM9QE6WEP/nxvDhU2M
         AgLcpKM7SlqtCZoMB8W9dYDfoW4rFn07CB8dIuh6ff2vn6UWUWuu/RSO7p1KXf7CIwtN
         M22oBnJDz9QQjfkDGwvQ1m7gRvUzanMWSS1sPHRutzyi7k1688WDELAmZs/CMNTVtyJk
         uwImtupsQBROXjnyPg+D5yaHhPQAvxO7gLeKrJiU+id4fOKyEAwtPewE4BFWiC85TAvU
         JZiA==
X-Gm-Message-State: ACrzQf0KwjBMIwS4bxOmXDXw7fsv3IP3XrJVxACP/VWHfEEy7s1SEqmX
        NT0MjR6XBPduSJVr4N5LxT04we1b9xaW
X-Google-Smtp-Source: AMsMyM7rL714AiObYJ83ODO0GktRmyzMhdEfqlNKNZu9U/+4WtDYNzEo0N31pmI/hOwZcODkngnUBY4N7K8c
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:553:438f:b86a:87f])
 (user=irogers job=sendgmr) by 2002:a0d:f246:0:b0:373:5992:dd23 with SMTP id
 b67-20020a0df246000000b003735992dd23mr43961109ywf.36.1668449626510; Mon, 14
 Nov 2022 10:13:46 -0800 (PST)
Date:   Mon, 14 Nov 2022 10:12:46 -0800
In-Reply-To: <20221114181251.2683871-1-irogers@google.com>
Message-Id: <20221114181251.2683871-5-irogers@google.com>
Mime-Version: 1.0
References: <20221114181251.2683871-1-irogers@google.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Subject: [PATCH v2 4/9] perf list: Generalize limiting to a PMU name
From:   Ian Rogers <irogers@google.com>
To:     Weilin Wang <weilin.wang@intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Sandipan Das <sandipan.das@amd.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Xin Gao <gaoxin@cdjrlc.com>, Rob Herring <robh@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
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

Deprecate the --cputype option and add a --unit option where '--unit
cpu_atom' behaves like '--cputype atom'. The --unit option can be used
with arbitrary PMUs, for example:

```
$ perf list --unit msr pmu

List of pre-defined events (to be used in -e or -M):

  msr/aperf/                                         [Kernel PMU event]
  msr/cpu_thermal_margin/                            [Kernel PMU event]
  msr/mperf/                                         [Kernel PMU event]
  msr/pperf/                                         [Kernel PMU event]
  msr/smi/                                           [Kernel PMU event]
  msr/tsc/                                           [Kernel PMU event]
```

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Documentation/perf-list.txt |  6 +++---
 tools/perf/builtin-list.c              | 18 ++++++++++++------
 tools/perf/util/metricgroup.c          |  3 ++-
 tools/perf/util/pmu.c                  |  4 +---
 4 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/tools/perf/Documentation/perf-list.txt b/tools/perf/Documentation/perf-list.txt
index 57384a97c04f..44a819af573d 100644
--- a/tools/perf/Documentation/perf-list.txt
+++ b/tools/perf/Documentation/perf-list.txt
@@ -39,9 +39,9 @@ any extra expressions computed by perf stat.
 --deprecated::
 Print deprecated events. By default the deprecated events are hidden.
 
---cputype::
-Print events applying cpu with this type for hybrid platform
-(e.g. --cputype core or --cputype atom)
+--unit::
+Print PMU events and metrics limited to the specific PMU name.
+(e.g. --unit cpu, --unit msr, --unit cpu_core, --unit cpu_atom)
 
 [[EVENT_MODIFIERS]]
 EVENT MODIFIERS
diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
index 58e1ec1654ef..cc84ced6da26 100644
--- a/tools/perf/builtin-list.c
+++ b/tools/perf/builtin-list.c
@@ -21,7 +21,6 @@
 
 static bool desc_flag = true;
 static bool details_flag;
-static const char *hybrid_type;
 
 int cmd_list(int argc, const char **argv)
 {
@@ -30,6 +29,8 @@ int cmd_list(int argc, const char **argv)
 	bool long_desc_flag = false;
 	bool deprecated = false;
 	char *pmu_name = NULL;
+	const char *hybrid_name = NULL;
+	const char *unit_name = NULL;
 	struct option list_options[] = {
 		OPT_BOOLEAN(0, "raw-dump", &raw_dump, "Dump raw events"),
 		OPT_BOOLEAN('d', "desc", &desc_flag,
@@ -40,9 +41,10 @@ int cmd_list(int argc, const char **argv)
 			    "Print information on the perf event names and expressions used internally by events."),
 		OPT_BOOLEAN(0, "deprecated", &deprecated,
 			    "Print deprecated events."),
-		OPT_STRING(0, "cputype", &hybrid_type, "hybrid cpu type",
-			   "Print events applying cpu with this type for hybrid platform "
-			   "(e.g. core or atom)"),
+		OPT_STRING(0, "cputype", &hybrid_name, "hybrid cpu type",
+			   "Limit PMU or metric printing to the given hybrid PMU (e.g. core or atom)."),
+		OPT_STRING(0, "unit", &unit_name, "PMU name",
+			   "Limit PMU or metric printing to the specified PMU."),
 		OPT_INCR(0, "debug", &verbose,
 			     "Enable debugging output"),
 		OPT_END()
@@ -53,6 +55,8 @@ int cmd_list(int argc, const char **argv)
 	};
 
 	set_option_flag(list_options, 0, "raw-dump", PARSE_OPT_HIDDEN);
+	/* Hide hybrid flag for the more generic 'unit' flag. */
+	set_option_flag(list_options, 0, "cputype", PARSE_OPT_HIDDEN);
 
 	argc = parse_options(argc, argv, list_options, list_usage,
 			     PARSE_OPT_STOP_AT_NON_OPTION);
@@ -62,8 +66,10 @@ int cmd_list(int argc, const char **argv)
 	if (!raw_dump && pager_in_use())
 		printf("\nList of pre-defined events (to be used in -e or -M):\n\n");
 
-	if (hybrid_type) {
-		pmu_name = perf_pmu__hybrid_type_to_pmu(hybrid_type);
+	if (unit_name)
+		pmu_name = strdup(unit_name);
+	else if (hybrid_name) {
+		pmu_name = perf_pmu__hybrid_type_to_pmu(hybrid_name);
 		if (!pmu_name)
 			pr_warning("WARNING: hybrid cputype is not supported!\n");
 	}
diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 4c98ac29ee13..1943fed9b6d9 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -556,11 +556,12 @@ static int metricgroup__print_callback(const struct pmu_event *pe,
 				       void *vdata)
 {
 	struct metricgroup_print_data *data = vdata;
+	const char *pmu = pe->pmu ?: "cpu";
 
 	if (!pe->metric_expr)
 		return 0;
 
-	if (data->pmu_name && perf_pmu__is_hybrid(pe->pmu) && strcmp(data->pmu_name, pe->pmu))
+	if (data->pmu_name && strcmp(data->pmu_name, pmu))
 		return 0;
 
 	return metricgroup__print_pmu_event(pe, data->metricgroups, data->filter,
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 8396504855cc..779839525437 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1696,10 +1696,8 @@ void print_pmu_events(const char *event_glob, bool name_only, bool quiet_flag,
 	pmu = NULL;
 	j = 0;
 	while ((pmu = perf_pmu__scan(pmu)) != NULL) {
-		if (pmu_name && perf_pmu__is_hybrid(pmu->name) &&
-		    strcmp(pmu_name, pmu->name)) {
+		if (pmu_name && pmu->name && strcmp(pmu_name, pmu->name))
 			continue;
-		}
 
 		list_for_each_entry(alias, &pmu->aliases, list) {
 			char *name = alias->desc ? alias->name :
-- 
2.38.1.431.g37b22c650d-goog

