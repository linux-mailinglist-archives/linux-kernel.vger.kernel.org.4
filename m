Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F4F0706BF6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 17:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232363AbjEQPAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 11:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232438AbjEQO7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 10:59:49 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42394A5DF
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 07:59:10 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id d2e1a72fcca58-64378a8b2e7so583189b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 07:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684335549; x=1686927549;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PQELA9dygliHhugHONhOHu8rviJ4MVgnxyXfBOR963U=;
        b=jHsbemsA1TZquLshENLqe4oijPjfN3yl6ZsS21ZVx06bh+tX5j0q9XDtD8LwOdVH8n
         AlwjtH/MzGkjgmMsnT5naSM8qMhLoabC3o8lPftGVT/qz0KQDil49mxU39nqx/9aDMbu
         HahKJx4okpqIc2MUn9ZCIxmIlD+5NaN1OSsWnXLBKFw5wlpjYRuKvbyX6Nui9SYkIJ7t
         qMs15Hpv5pGv7f2PpuSZHlWy6QEJk2txJTd1ZY8LuerMhFfnuiUNsUCzt2V4tux30Hjt
         3jZ/Zkky68aJZwj+ZFBkOWagoPyM/On4jtJToyVzlTtU+VYwNImmtcIncHLxxygfVILb
         WzXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684335549; x=1686927549;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PQELA9dygliHhugHONhOHu8rviJ4MVgnxyXfBOR963U=;
        b=eXfJNakot47tETkP+JVW+UBbAhY4x8yr0/DuYzpRQG224jFyClCwOUVX+85Yp6H1jR
         jzMxqoFabshL9tRVBeGipOeUFpp3CEiNarpQTBnLvU+77QJmG1z6MMdTynOdLWjKJ2FE
         tZ4ovOga1f7/+80f8U51Cl8vD7VEJXcRa3XlYqrlPfNDh/HGEtyfIaG9DUNabPUtgDai
         4iSleXq9gYGSoanDjkxvr1xNWW/BB/SNbJkKKCHeUzwYjRKIHYbWyxeE0j5NXVt/dSVk
         IL7hpRsXAtm94L1NZP4dpME7P0zawhrKhC6kgS0aehBosbGnvzVNCVO9uqDMlS+IPfer
         Z2ng==
X-Gm-Message-State: AC+VfDxoHz/tCKE+NGuA/FDstJkm1TV411xyXLEkoaCcYZYfSb543Wpy
        EWrEbenDl0FC2Rl9fLdkBYRBi0EvkDT2
X-Google-Smtp-Source: ACHHUZ6siVVymk0LoQ94GGZ6axmK1Qp5NQOCLmGGBJeP5Zo58YeQcY6rOkjhCG0XmlOSFqsv9jOJlCJdS9fA
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:628b:7e78:d09b:39b])
 (user=irogers job=sendgmr) by 2002:a05:6a00:1916:b0:643:599b:4dd1 with SMTP
 id y22-20020a056a00191600b00643599b4dd1mr424011pfi.6.1684335549439; Wed, 17
 May 2023 07:59:09 -0700 (PDT)
Date:   Wed, 17 May 2023 07:57:55 -0700
In-Reply-To: <20230517145803.559429-1-irogers@google.com>
Message-Id: <20230517145803.559429-16-irogers@google.com>
Mime-Version: 1.0
References: <20230517145803.559429-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
Subject: [PATCH v1 15/23] perf mem: Avoid hybrid PMU list
From:   Ian Rogers <irogers@google.com>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Ming Wang <wangming01@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        Sandipan Das <sandipan.das@amd.com>,
        Dmitrii Dolgov <9erthalion6@gmail.com>,
        Sean Christopherson <seanjc@google.com>,
        Raul Silvera <rsilvera@google.com>,
        Ali Saidi <alisaidi@amazon.com>, Rob Herring <robh@kernel.org>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Kang Minchul <tegongkang@gmail.com>,
        linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add perf_pmu__num_mem_pmus that scans/counts the number of PMUs for
mem events. Switch perf_pmu__for_each_hybrid_pmu to iterating all PMUs
and only handling is_core ones.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-c2c.c     |  7 ++-----
 tools/perf/builtin-mem.c     |  7 ++-----
 tools/perf/util/mem-events.c | 20 ++++++++++++++------
 tools/perf/util/pmu.c        | 17 +++++++++++++++++
 tools/perf/util/pmu.h        |  1 +
 5 files changed, 36 insertions(+), 16 deletions(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 08455e26b606..2757ccc19c5e 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -42,7 +42,6 @@
 #include "ui/ui.h"
 #include "ui/progress.h"
 #include "pmu.h"
-#include "pmu-hybrid.h"
 #include "string2.h"
 #include "util/util.h"
 
@@ -3259,10 +3258,8 @@ static int perf_c2c__record(int argc, const char **argv)
 	argc = parse_options(argc, argv, options, record_mem_usage,
 			     PARSE_OPT_KEEP_UNKNOWN);
 
-	if (!perf_pmu__has_hybrid())
-		rec_argc = argc + 11; /* max number of arguments */
-	else
-		rec_argc = argc + 11 * perf_pmu__hybrid_pmu_num();
+	/* Max number of arguments multiplied by number of PMUs that can support them. */
+	rec_argc = argc + 11 * perf_pmu__num_mem_pmus();
 
 	rec_argv = calloc(rec_argc + 1, sizeof(char *));
 	if (!rec_argv)
diff --git a/tools/perf/builtin-mem.c b/tools/perf/builtin-mem.c
index 65465930ef8e..f4f1ff76d49d 100644
--- a/tools/perf/builtin-mem.c
+++ b/tools/perf/builtin-mem.c
@@ -18,7 +18,6 @@
 #include "util/map.h"
 #include "util/symbol.h"
 #include "util/pmu.h"
-#include "util/pmu-hybrid.h"
 #include "util/sample.h"
 #include "util/string2.h"
 #include "util/util.h"
@@ -93,10 +92,8 @@ static int __cmd_record(int argc, const char **argv, struct perf_mem *mem)
 	argc = parse_options(argc, argv, options, record_mem_usage,
 			     PARSE_OPT_KEEP_UNKNOWN);
 
-	if (!perf_pmu__has_hybrid())
-		rec_argc = argc + 9; /* max number of arguments */
-	else
-		rec_argc = argc + 9 * perf_pmu__hybrid_pmu_num();
+	/* Max number of arguments multiplied by number of PMUs that can support them. */
+	rec_argc = argc + 9 * perf_pmu__num_mem_pmus();
 
 	if (mem->cpu_list)
 		rec_argc += 2;
diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
index ed1ee4b05356..c9e422a38258 100644
--- a/tools/perf/util/mem-events.c
+++ b/tools/perf/util/mem-events.c
@@ -13,7 +13,6 @@
 #include "debug.h"
 #include "symbol.h"
 #include "pmu.h"
-#include "pmu-hybrid.h"
 
 unsigned int perf_mem_events__loads_ldlat = 30;
 
@@ -120,7 +119,6 @@ int perf_mem_events__init(void)
 
 	for (j = 0; j < PERF_MEM_EVENTS__MAX; j++) {
 		struct perf_mem_event *e = perf_mem_events__ptr(j);
-		struct perf_pmu *pmu;
 		char sysfs_name[100];
 
 		/*
@@ -135,7 +133,12 @@ int perf_mem_events__init(void)
 				  e->sysfs_name, "cpu");
 			e->supported = perf_mem_event__supported(mnt, sysfs_name);
 		} else {
-			perf_pmu__for_each_hybrid_pmu(pmu) {
+			struct perf_pmu *pmu = NULL;
+
+			while ((pmu = perf_pmu__scan(pmu)) != NULL) {
+				if (!pmu->is_core)
+					continue;
+
 				scnprintf(sysfs_name, sizeof(sysfs_name),
 					  e->sysfs_name, pmu->name);
 				e->supported |= perf_mem_event__supported(mnt, sysfs_name);
@@ -170,9 +173,12 @@ static void perf_mem_events__print_unsupport_hybrid(struct perf_mem_event *e,
 {
 	const char *mnt = sysfs__mount();
 	char sysfs_name[100];
-	struct perf_pmu *pmu;
+	struct perf_pmu *pmu = NULL;
+
+	while ((pmu = perf_pmu__scan(pmu)) != NULL) {
+		if (!pmu->is_core)
+			continue;
 
-	perf_pmu__for_each_hybrid_pmu(pmu) {
 		scnprintf(sysfs_name, sizeof(sysfs_name), e->sysfs_name,
 			  pmu->name);
 		if (!perf_mem_event__supported(mnt, sysfs_name)) {
@@ -210,7 +216,9 @@ int perf_mem_events__record_args(const char **rec_argv, int *argv_nr,
 				return -1;
 			}
 
-			perf_pmu__for_each_hybrid_pmu(pmu) {
+			while ((pmu = perf_pmu__scan(pmu)) != NULL) {
+				if (!pmu->is_core)
+					continue;
 				rec_argv[i++] = "-e";
 				s = perf_mem_events__name(j, pmu->name);
 				if (s) {
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 2da28739e0d3..acbf504c895a 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1673,6 +1673,23 @@ bool perf_pmu__auto_merge_stats(const struct perf_pmu *pmu)
 	return !is_pmu_hybrid(pmu->name);
 }
 
+static bool perf_pmu__is_mem_pmu(const struct perf_pmu *pmu)
+{
+	return pmu->is_core;
+}
+
+int perf_pmu__num_mem_pmus(void)
+{
+	struct perf_pmu *pmu = NULL;
+	int count = 0;
+
+	while ((pmu = perf_pmu__scan(pmu)) != NULL) {
+		if (perf_pmu__is_mem_pmu(pmu))
+			count++;
+	}
+	return count;
+}
+
 static bool pmu_alias_is_duplicate(struct sevent *alias_a,
 				   struct sevent *alias_b)
 {
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index af10d137e2b5..5f5de7c20ab6 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -231,6 +231,7 @@ bool is_pmu_hybrid(const char *name);
 bool perf_pmu__supports_legacy_cache(const struct perf_pmu *pmu);
 bool perf_pmu__supports_wildcard_numeric(const struct perf_pmu *pmu);
 bool perf_pmu__auto_merge_stats(const struct perf_pmu *pmu);
+int perf_pmu__num_mem_pmus(void);
 void print_pmu_events(const struct print_callbacks *print_cb, void *print_state);
 bool pmu_have_event(const char *pname, const char *name);
 
-- 
2.40.1.606.ga4b1b128d6-goog

