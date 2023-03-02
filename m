Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF2216A8BE3
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 23:34:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbjCBWdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 17:33:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbjCBWdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 17:33:46 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B856A1E2A4
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 14:33:41 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id p36-20020a056a000a2400b005f72df7d97bso280230pfh.19
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 14:33:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677796421;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sLp16thdoL8gYxkkfhRZgItEDw/VHlYRuSQJ2A/KjWw=;
        b=FHHelEMUWiU4Z1GYSeeAuC/PG0LpTrXj2X0KzSfI0aP8qS0YsCb84rIgGnj6+twg9E
         WK07h1t1EpGcjYn+EnWdZLv9ExjZpX8cybG4U515GrFVkdO7CcgNPCav61CCEuVm3IHw
         3v+cJnCk1pelQNJxz/8X0S5pR7d/b6bB7nk0ySAKJvLxFZsX23c8MHrXCMrdLepN4LGn
         CRpkNrQUD558f65BOCA2rXDSPG9YvTYHY2wCSG2uENW3yWOH53I03ZH/j/J5g0tMgEtq
         mtE9Iib+wob7GyHkUPufCPjHTbWGe3GRs8TSlEPOlWaOSgsR4hKkGh8sqIPEdLAC+sSC
         3DrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677796421;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sLp16thdoL8gYxkkfhRZgItEDw/VHlYRuSQJ2A/KjWw=;
        b=Mz9/y6Cwi5x3Mr8Au6kTasEeZZNVAV8tKF4gjingZ9iScP1vpOsS+3sTmBtAD0xIdr
         vI0tLY7Q5z/jmnQUj9OyF8LdX46hY6DQ/ALfifsySYLWvUObPWb+eWaS3AadJTaQ+5JH
         Nwb5/NL98F8OgJia/z58Vgwb6PjmNnQs540YaX5s+fPHVPpWQzK6UMgiclFPKQ6DXIDz
         kYm61v6g1O3r5QGxpAt+oWPpjVOIURpJm8O28BzUBQ6/K/6J1keLN+kpGTJCN6C4K6h5
         b2t3SGDl1jouBkKwejXKiCSHjVpAWqXC5Sgi+9tu1JwZxcv3gej+Z44sfl8hXkUwX6Kp
         wnHA==
X-Gm-Message-State: AO0yUKWS6bChxRYGO+fn7mk+rLUlWF9h5wYoQy03ThRNcKkxVJDxR/7C
        gUGs7FlNLzHjBHQfEYyH8AN+Vt1TF+cZ
X-Google-Smtp-Source: AK7set8IDse27H7uhs55+lpktQZD5WFfNUIFhEks3/sxyTroAWqTYmsTORr1cgwGdzOx42qWESc0pbtFHcKQ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:5f50:6ef4:b4d0:568e])
 (user=irogers job=sendgmr) by 2002:a25:9112:0:b0:9fe:1493:8bb with SMTP id
 v18-20020a259112000000b009fe149308bbmr4926485ybl.13.1677792371865; Thu, 02
 Mar 2023 13:26:11 -0800 (PST)
Date:   Thu,  2 Mar 2023 13:25:24 -0800
In-Reply-To: <20230302212531.1043318-1-irogers@google.com>
Message-Id: <20230302212531.1043318-4-irogers@google.com>
Mime-Version: 1.0
References: <20230302212531.1043318-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.rc0.216.gc4246ad0f0-goog
Subject: [PATCH v2 03/10] perf record: Early auxtrace initialization before
 event parsing
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Steinar H. Gunderson" <sesse@google.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        James Clark <james.clark@arm.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Sean Christopherson <seanjc@google.com>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows event parsing to use the evsel__is_aux_event function,
which is important when determining event grouping.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/x86/util/auxtrace.c | 17 +++++++++++++----
 tools/perf/builtin-record.c         |  6 ++++++
 tools/perf/util/auxtrace.h          |  2 ++
 3 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/tools/perf/arch/x86/util/auxtrace.c b/tools/perf/arch/x86/util/auxtrace.c
index 3da506e13f49..de1e4842ea2e 100644
--- a/tools/perf/arch/x86/util/auxtrace.c
+++ b/tools/perf/arch/x86/util/auxtrace.c
@@ -15,6 +15,19 @@
 #include "../../../util/intel-bts.h"
 #include "../../../util/evlist.h"
 
+void auxtrace__early_init(void)
+{
+	struct perf_pmu *intel_pt_pmu;
+	struct perf_pmu *intel_bts_pmu;
+
+	intel_pt_pmu = perf_pmu__find(INTEL_PT_PMU_NAME);
+	if (intel_pt_pmu)
+		intel_pt_pmu->auxtrace = true;
+	intel_bts_pmu = perf_pmu__find(INTEL_BTS_PMU_NAME);
+	if (intel_bts_pmu)
+		intel_bts_pmu->auxtrace = true;
+}
+
 static
 struct auxtrace_record *auxtrace_record__init_intel(struct evlist *evlist,
 						    int *err)
@@ -26,11 +39,7 @@ struct auxtrace_record *auxtrace_record__init_intel(struct evlist *evlist,
 	bool found_bts = false;
 
 	intel_pt_pmu = perf_pmu__find(INTEL_PT_PMU_NAME);
-	if (intel_pt_pmu)
-		intel_pt_pmu->auxtrace = true;
 	intel_bts_pmu = perf_pmu__find(INTEL_BTS_PMU_NAME);
-	if (intel_bts_pmu)
-		intel_bts_pmu->auxtrace = true;
 
 	evlist__for_each_entry(evlist, evsel) {
 		if (intel_pt_pmu && evsel->core.attr.type == intel_pt_pmu->type)
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 8374117e66f6..a0870c076dc0 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -3940,6 +3940,10 @@ static int record__init_thread_masks(struct record *rec)
 	return ret;
 }
 
+__weak void auxtrace__early_init(void)
+{
+}
+
 int cmd_record(int argc, const char **argv)
 {
 	int err;
@@ -3985,6 +3989,8 @@ int cmd_record(int argc, const char **argv)
 	if (err)
 		return err;
 
+	auxtrace__early_init();
+
 	argc = parse_options(argc, argv, record_options, record_usage,
 			    PARSE_OPT_STOP_AT_NON_OPTION);
 	if (quiet)
diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
index 29eb82dff574..49a86aa6ac94 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -457,6 +457,8 @@ struct addr_filters {
 
 struct auxtrace_cache;
 
+void auxtrace__early_init(void);
+
 #ifdef HAVE_AUXTRACE_SUPPORT
 
 u64 compat_auxtrace_mmap__read_head(struct auxtrace_mmap *mm);
-- 
2.40.0.rc0.216.gc4246ad0f0-goog

