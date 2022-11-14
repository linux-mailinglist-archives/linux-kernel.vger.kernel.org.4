Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49AC06276BF
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 08:52:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236065AbiKNHwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 02:52:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235893AbiKNHwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 02:52:34 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4491192BD
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 23:52:26 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id t5-20020a5b07c5000000b006dfa2102debso4423102ybq.4
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 23:52:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Rl5NpkjPzTE4Fls6Plwx5I6VTiNxD2kr5kHqIS0Pzx4=;
        b=XqSweAfbUuRwICXIEsBeKYZgc/LZnmTQ0jtybP/LAJRBtvNF8yizWk+du66+43CYAB
         70Wgy4NzWRXDr0jfMtDjaRHxCjP4yFrs4WKPOvp1HcGBc0g+8uXlSxEKjBg1c0c4kReJ
         AcHw7AwS1ocCNsFNrNbrvxgkILE9yXqtP1byzrPNavv2mhY25kLKt/UFQSksaUyGsJbe
         bMn3dJjhi+oFn/6p77bSuXHQYhHVr3srtwHYOIHWDUvCEu5mzrF+VVacpvX+mPHokLk6
         KE2hj2mJLHDTa5bMUwl7+kCgGPjfPgC7Po3yE/BsN/oTYMraNoOQ8Mcht3sMHZ/XD9dd
         lqYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rl5NpkjPzTE4Fls6Plwx5I6VTiNxD2kr5kHqIS0Pzx4=;
        b=Y4fyHGFm/8adZ+9GLEWleApLualbElzxZ2yFZS/tjJurACnhIyPvXAAWkJ2spePanF
         lC0vG42lTvm9PaKiWmmND3LsXZokZWyLO1P5nDFpTI/UzlFlaDv0UvpfesRUd6Ao4UG8
         UrUx9BDk3ifeJhf8plNIZahWG4wTNKQln51pQelTO2gUJYSMzz0B0bV5beGsHUFW1AFu
         /ChKFqW4srdugzBAZ5GFu2cZ+C5LYH4AbxkLJESI+GqJmcvKVC1xhXHxmz2rNrHAfCd5
         Fihf28iCr99aeaaCovNms7vYe9JZ8e+MrWfF7w5kYqbscCVvYOUeKIhAXnj52ueC9qyE
         q5tA==
X-Gm-Message-State: ANoB5pmK+CoLe5msKpB/ZRQ4S01eJBVpk3mHQsK2EONQb0lisKEwT+GO
        2nurH68ez8dfph5d2t2dXZZ7ttJ8/N8k
X-Google-Smtp-Source: AA0mqf79aD0/uo7D00ZVL1Io9KSSYcuptA4m3js37yU+UiYYLhONp0PF+ZQPwA4uT8IS1JFObFuy0zZUn87H
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:cba6:8279:98e6:3d6e])
 (user=irogers job=sendgmr) by 2002:a81:3804:0:b0:370:7cf2:9c5a with SMTP id
 f4-20020a813804000000b003707cf29c5amr12143856ywa.211.1668412346044; Sun, 13
 Nov 2022 23:52:26 -0800 (PST)
Date:   Sun, 13 Nov 2022 23:51:22 -0800
In-Reply-To: <20221114075127.2650315-1-irogers@google.com>
Message-Id: <20221114075127.2650315-5-irogers@google.com>
Mime-Version: 1.0
References: <20221114075127.2650315-1-irogers@google.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Subject: [PATCH v1 4/9] perf list: Generalize limiting to a PMU name
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
index a8f9f47c6ed9..9c771f136b81 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1694,10 +1694,8 @@ void print_pmu_events(const char *event_glob, bool name_only, bool quiet_flag,
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

