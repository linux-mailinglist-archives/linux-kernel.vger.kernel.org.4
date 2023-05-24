Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24A4F7100CF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 00:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237902AbjEXWVF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 18:21:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234015AbjEXWU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 18:20:29 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB2761711
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 15:19:44 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-babb76a9831so2835862276.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 15:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684966770; x=1687558770;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/wfJ/y0HTXpP4SfThXWLklmlTbbjNt14J5e/cCO34dg=;
        b=M/5LKeZsS4Join3b/N5o6PtajiBLqms83/4Mg/i9sUlIxdRAMOlgGeShcs7f0zn9+6
         9m0jZ9d+614Klo2TUlv1UW/82rTEO6fPxhi0PWMzyEgoCEb54VA/tY1RkfNBPB7SDnBB
         wxB/HdoAslerbOD5a67EB0p6Wvw5JMGR4lYQQl8eoy+LTHqfMIq0r3PsmpNWW5ka4nMe
         iCHfEeLIULrVHjr2WqvFikaZXCA5YrikMy884vYw+eOm3Tlq3LSVttTjOLVmVR7GseiB
         YPfQAr82fT1ufBvYh0eIgGyt2L7ivZBCdJpn2ejnbXCW7nHgvhG4fg50R2epB4W4wSqW
         zuYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684966770; x=1687558770;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/wfJ/y0HTXpP4SfThXWLklmlTbbjNt14J5e/cCO34dg=;
        b=WQOOxwoyvQYtv/e86hycDfth8Gq4xvQnzepF8UjviSs1H9SEegf/HF7H4EANT7kO8M
         MQGbkRoo0T5bOT01FrBcZBDYpnwFNcW03tjK+2zKPcxa5q46VaWw22MI2mCeZB5lTvkR
         ueRSGjh7N+U8PUrsJixJ5D3xvDhVuTeR2I23EGlMkuK48VqASlDXBrMJAga/PH/CAiQ+
         fRj8ew0SSw9C/GQvZLPGf8GycChyUingZZ+VUQlM+iIcXTNIGGt6RVZO2EknxhWjOzxp
         0399QdD91q+dh5RaNVlT9UrUfIFqlKFAiRUegYvFIRa6eYK8/d5LJx6ZqoauJ1c4wLk2
         VgcA==
X-Gm-Message-State: AC+VfDy3cDWt69pIB5ij0yMvK1tOl9vOyVjs8XsG2RCGpkXjEVdQxMXr
        GfJy5HDdBHUD2jvXRPEMrlh5IPK0+Rdq
X-Google-Smtp-Source: ACHHUZ4sXK5s0yERreneq9mdtnEvAqW6QA0zbmcOGvUusUrlV8hiTT2jVHqi7N3SONXjS0akNs4cu3eJ9/j+
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:7aa7:3d2d:76ae:8e96])
 (user=irogers job=sendgmr) by 2002:a25:db47:0:b0:ba8:6148:4300 with SMTP id
 g68-20020a25db47000000b00ba861484300mr577608ybf.6.1684966770047; Wed, 24 May
 2023 15:19:30 -0700 (PDT)
Date:   Wed, 24 May 2023 15:18:20 -0700
In-Reply-To: <20230524221831.1741381-1-irogers@google.com>
Message-Id: <20230524221831.1741381-25-irogers@google.com>
Mime-Version: 1.0
References: <20230524221831.1741381-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
Subject: [PATCH v3 24/35] perf mem: Avoid hybrid PMU list
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
        autolearn=ham autolearn_force=no version=3.4.6
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
index 821cdd79db48..12446f63d1b3 100644
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
2.40.1.698.g37aff9b760-goog

