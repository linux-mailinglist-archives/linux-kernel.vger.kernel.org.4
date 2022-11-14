Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E73BF628B0E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 22:08:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237633AbiKNVIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 16:08:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237606AbiKNVIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 16:08:35 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD1C6B5D
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 13:08:33 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id pj8-20020a17090b4f4800b002140219b2b3so50324pjb.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 13:08:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xTvigGR2TZpPyDR4wvE6cl7h65F616i4JiHpM7NGI4g=;
        b=qh+bQXa8qXtlPKafIbt/qub27YV/6bwdGsur0mog3yFgqhnOu8lpu+FinXZBNRnkh8
         GRYVjsVviqHBLQJJwqIK5e/d05fGmLi3qoC4eDX0QINmKP2TbRxN/xi9z+WgVa4hSuPh
         2oefMp99D68M0gjQB58HPclQ3d5RjmtPh66ZPEzzu5fyyMUIq+fIS9rNVBebAz4bc514
         dqaSAVg6Yz3rc6Xku+nHmKDCCXboQIck5vwSPw35NGGOhHqjLbsdGiIGY+mo5dIP4alF
         Ug8q0wkajQ4pQsQmCWaDYHDmVW7lgpFJLpc1Da12UF79YVnYy+YCIknYU5uVlDifNew+
         fBNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xTvigGR2TZpPyDR4wvE6cl7h65F616i4JiHpM7NGI4g=;
        b=ZTlLdNQl3roLE/QbyxR193gtnscZxvv6Wd/3KT0G0txF3N0JvdM4BiUnSR+WYsBQUn
         n2EgA9ftSOK8uXfH//fmXngJp37kO9beMl/dZukic0zJwzXqJaELUeT5GNIKl/b9k8qU
         fDf1hCdE/NhS13R3ipkVeGz4N+vF2NZSidFGJapbqN4jYGVieSLskD/wBgnDbRysbotS
         gfJWekIPSoh6iUSzDWTYaZm+NMyWSkuBbmDoG9jSd6D/K5EjHHrWqJW0DzL0cScC2nms
         IJCAKk+0uGWGvkiIE5nkL8MhlbgaZKfE/kxbxK9RRrAzQ+z2yEPN3Aafhmt4eKlDKIXr
         J7dQ==
X-Gm-Message-State: ANoB5pnbr1a+usgu2PHJkHaqkHi5Xpl/vnjQq/rAjs2BJkPvhSwQ0ijG
        R2n9oF1+0Kc3140hBShLW3Z4JtbxZ8oB
X-Google-Smtp-Source: AA0mqf7RcItl+6JEAoD9l+pvnFWhCZiCtWk8U6jOG63njbUTz3DuRQc/WEBDfkDPcydmXrqBtv5NfPD3zWTY
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:553:438f:b86a:87f])
 (user=irogers job=sendgmr) by 2002:aa7:86d5:0:b0:56d:3de3:c401 with SMTP id
 h21-20020aa786d5000000b0056d3de3c401mr15620037pfo.6.1668460113210; Mon, 14
 Nov 2022 13:08:33 -0800 (PST)
Date:   Mon, 14 Nov 2022 13:07:18 -0800
In-Reply-To: <20221114210723.2749751-1-irogers@google.com>
Message-Id: <20221114210723.2749751-6-irogers@google.com>
Mime-Version: 1.0
References: <20221114210723.2749751-1-irogers@google.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Subject: [PATCH v3 05/10] perf list: Generalize limiting to a PMU name
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
index 057e1528c32f..e6790175307b 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1695,10 +1695,8 @@ void print_pmu_events(const char *event_glob, bool name_only, bool quiet_flag,
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

