Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28214712F51
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 23:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244351AbjEZV4c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 17:56:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244294AbjEZVz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 17:55:56 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0492C10DB
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 14:55:29 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-ba8c3186735so2606328276.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 14:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685138108; x=1687730108;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RcROT9jp6OZa4Pd3xwGvZ+cvDZqw5Cwo0zsZ9qLHIG4=;
        b=PRpGI04BjG6Nf2Geo2iXSnO+vuKQ7zMaN4/+RitHxWHXbECoECRvjp5iOrkgoKFlDU
         lTaFWwhRNYtcYb5X16Lt3Gn8oiBJhhkIPqTZVGChjjKQmBJ3MNqojpVgu1RfVSxF7tXw
         +PWeBr/DZF5dASCKgJcnV1GlXA7/XM89A7t3AYPbYqNt7FzOfvzw2HTbSBWR4OB/FZsY
         V6mDJDAJ5SVVY930XtO+buo46H2cxA1rJK1n1YkcSXEYHWBiMaTZich+dm/KEjb5VMIC
         0UtKxaVQbiH5DtwUEe54bVfZKGmyvzIO9mw9FvjAsuC77fh/GK9asmhSv7d1VIg4T1Ml
         UeaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685138108; x=1687730108;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RcROT9jp6OZa4Pd3xwGvZ+cvDZqw5Cwo0zsZ9qLHIG4=;
        b=bhnjHu4oFe4IG9VWLC4IVq5JUfn7hIT8BNOjUJ4PzO47H9AVx7laReGSH61TcafCtP
         feWrj/J6rNkkJhmPk4F321de7CX8fCkwv4rjWDLwDFd52Yq2d9sbv8exEEAixtVUEmk5
         gKDtkgKDqF2tQwVL6mG5+g9mkBn7JH48NoP3qTrn3D3LZcAUjDVcI65XCzxU7g/l3i2L
         LAJ27vgx9HW55M/0XbsqIMqEUJVVZ73P1PGczVFjKf4eBvs55h5T9FY673Ca65Zs+Nkf
         KOxKzrxM0AnrZxVBCBklS6UTCogU9lfvUd8tqSoDUqIssAVq4IJqEEkc/hLnjgWbJqYB
         USFQ==
X-Gm-Message-State: AC+VfDydgB7s3UVnzX+ayUbyQTwaIAvCLr93WrKwB3xd6tGZZYeDsMOH
        bUBHmbWIXGgIkZpAhd20W2PxWvAdeNe2
X-Google-Smtp-Source: ACHHUZ5Pnlf2xMgGAhdYazUVA8pJkRIOBL3CvGPM/60yY1Pw5MnOiedoe4bXGIoHhJnLmOMajJrDNVolzAqT
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:3b4e:312c:644:a642])
 (user=irogers job=sendgmr) by 2002:a05:6902:1341:b0:ba8:2e79:c193 with SMTP
 id g1-20020a056902134100b00ba82e79c193mr1253763ybu.12.1685138107923; Fri, 26
 May 2023 14:55:07 -0700 (PDT)
Date:   Fri, 26 May 2023 14:53:59 -0700
In-Reply-To: <20230526215410.2435674-1-irogers@google.com>
Message-Id: <20230526215410.2435674-25-irogers@google.com>
Mime-Version: 1.0
References: <20230526215410.2435674-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Subject: [PATCH v4 24/35] perf mem: Avoid hybrid PMU list
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
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
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
index 5a7bfbf621d0..65daa0cc71d6 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1660,6 +1660,23 @@ bool perf_pmu__auto_merge_stats(const struct perf_pmu *pmu)
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
2.41.0.rc0.172.g3f132b7071-goog

