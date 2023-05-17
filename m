Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C3FA706BE9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 16:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232255AbjEQO7N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 10:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231980AbjEQO6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 10:58:49 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D262F40DF
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 07:58:47 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-ba87d7d2988so1394131276.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 07:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684335527; x=1686927527;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dGJ3I0sfnW9+HhqJrbZVaDNsnOcUvsKxgQCM/RuCj1g=;
        b=0fdnUhY+TMWb9aEJBfbvo+Ecs2aVlGpoHeshyuUuYq3uNW0RTZbbnZTQHswiL+XzoF
         6Rgv++pxqPZG8yrFpDciCSjvrdPCtmj5wJ5zvRi0HcFLMfuVH2azHA8xeZtanM4KW0i+
         qZXO1Y0Y/SCyUWSmdV/rPGFoOh28GmwSILrXaq2dyHMYDaHopWy/xYWJBlktXJia1Nsy
         MFGyeidGam/4Q8nA5zl2XvS3kHh6rM/TOhHaaZfHhpHJ6nBZFBs0UA1NO4VOpLM+2QFm
         eWi1qvJylP9lPcIa0JfUnYo+T7o1Jae2GTu7wBIMHLTSH73PKSwbe/DljbjGQqHfR9gF
         7wSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684335527; x=1686927527;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dGJ3I0sfnW9+HhqJrbZVaDNsnOcUvsKxgQCM/RuCj1g=;
        b=PSZXnfY9Geru6+rmwWXWAVgmQRuLUgWw+nmA51rwOPGzlIp8AgzH4+2W8uHuHnT5+/
         bsc0ErXfL2B+5w248iH75qZci1P+2IfTEFLGGJGrkq8xVwDebgy4J6Zgi50KrUQ1FCBl
         RazpLcxhi6coMtWSdq9eGqN7B7GURojFHVWjMRCqHeuDaCgadPqRRku05c5DEYgIANd8
         1CDswoSH6X32B93MUC6U8LkBtJ//8T0FLbKIO2bBBS+GbLgbzqNfU8jEZj2oodfoVqFL
         UCLLYaSOYQsqSdAqN9IfJChwTghAC7hoHGnvgIMmAdIkSy+OuEH+tqKTgOQqLTwKfmKa
         vn1g==
X-Gm-Message-State: AC+VfDyvP5h8LFzxOLCST61WYsDY+/Y7EVU/gZa5/wkzNb445iRpax/o
        UB+/8wExSnZx/Hb5hdoRIj279xLFLrgu
X-Google-Smtp-Source: ACHHUZ6TGmbGisEH9U1Doeu6RHHiqlYqMzqFuYh0bS2DqarU1ktis49bisL9SmtMJub1VDAq7mlqISDKyEWI
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:628b:7e78:d09b:39b])
 (user=irogers job=sendgmr) by 2002:a05:6902:104:b0:ba7:8628:93e2 with SMTP id
 o4-20020a056902010400b00ba7862893e2mr1612679ybh.4.1684335527084; Wed, 17 May
 2023 07:58:47 -0700 (PDT)
Date:   Wed, 17 May 2023 07:57:45 -0700
In-Reply-To: <20230517145803.559429-1-irogers@google.com>
Message-Id: <20230517145803.559429-6-irogers@google.com>
Mime-Version: 1.0
References: <20230517145803.559429-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
Subject: [PATCH v1 05/23] perf pmu: Remove perf_pmu__hybrid_mounted
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

perf_pmu__hybrid_mounted is used to detect whether cpu_core or
cpu_atom is mounted with a non-empty cpus file by
pmu_lookup. pmu_lookup will attempt to read the cpus file too and so
the check can be folded into this.

Checking hybrid_mounted in pmu_is_uncore is redundant as the next
cpumask read will fail returning false.

Reduce the scope of perf_pmu__find_hybrid_pmu by making it static.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmu-hybrid.c | 15 +--------------
 tools/perf/util/pmu-hybrid.h |  3 ---
 tools/perf/util/pmu.c        | 26 ++++++++++++++------------
 3 files changed, 15 insertions(+), 29 deletions(-)

diff --git a/tools/perf/util/pmu-hybrid.c b/tools/perf/util/pmu-hybrid.c
index bc4cb0738c35..7fe943dd3217 100644
--- a/tools/perf/util/pmu-hybrid.c
+++ b/tools/perf/util/pmu-hybrid.c
@@ -18,20 +18,7 @@
 
 LIST_HEAD(perf_pmu__hybrid_pmus);
 
-bool perf_pmu__hybrid_mounted(const char *name)
-{
-	int cpu;
-	char pmu_name[PATH_MAX];
-	struct perf_pmu pmu = {.name = pmu_name};
-
-	if (strncmp(name, "cpu_", 4))
-		return false;
-
-	strlcpy(pmu_name, name, sizeof(pmu_name));
-	return perf_pmu__scan_file(&pmu, "cpus", "%u", &cpu) > 0;
-}
-
-struct perf_pmu *perf_pmu__find_hybrid_pmu(const char *name)
+static struct perf_pmu *perf_pmu__find_hybrid_pmu(const char *name)
 {
 	struct perf_pmu *pmu;
 
diff --git a/tools/perf/util/pmu-hybrid.h b/tools/perf/util/pmu-hybrid.h
index 206b94931531..8dbcae935020 100644
--- a/tools/perf/util/pmu-hybrid.h
+++ b/tools/perf/util/pmu-hybrid.h
@@ -13,9 +13,6 @@ extern struct list_head perf_pmu__hybrid_pmus;
 #define perf_pmu__for_each_hybrid_pmu(pmu)	\
 	list_for_each_entry(pmu, &perf_pmu__hybrid_pmus, hybrid_list)
 
-bool perf_pmu__hybrid_mounted(const char *name);
-
-struct perf_pmu *perf_pmu__find_hybrid_pmu(const char *name);
 bool perf_pmu__is_hybrid(const char *name);
 
 static inline int perf_pmu__hybrid_pmu_num(void)
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 1e0be23d4dd7..729b1f166f80 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -617,9 +617,6 @@ static bool pmu_is_uncore(int dirfd, const char *name)
 {
 	int fd;
 
-	if (perf_pmu__hybrid_mounted(name))
-		return false;
-
 	fd = perf_pmu__pathname_fd(dirfd, name, "cpumask", O_PATH);
 	if (fd < 0)
 		return false;
@@ -898,6 +895,16 @@ static int pmu_max_precise(int dirfd, struct perf_pmu *pmu)
 	return max_precise;
 }
 
+/**
+ * perf_pmu__skip_empty_cpus() - should pmu_lookup skip the named PMU if the
+ *      cpus or cpumask file isn't present?
+ * @name: Name of PMU.
+ */
+static bool perf_pmu__skip_empty_cpus(const char *name)
+{
+	return !strcmp(name, "cpu_core") || !strcmp(name, "cpu_atom");
+}
+
 static struct perf_pmu *pmu_lookup(int dirfd, const char *lookup_name)
 {
 	struct perf_pmu *pmu;
@@ -905,15 +912,8 @@ static struct perf_pmu *pmu_lookup(int dirfd, const char *lookup_name)
 	LIST_HEAD(aliases);
 	__u32 type;
 	char *name = pmu_find_real_name(lookup_name);
-	bool is_hybrid = perf_pmu__hybrid_mounted(name);
 	char *alias_name;
 
-	/*
-	 * Check pmu name for hybrid and the pmu may be invalid in sysfs
-	 */
-	if (!strncmp(name, "cpu_", 4) && !is_hybrid)
-		return NULL;
-
 	/*
 	 * The pmu data we store & need consists of the pmu
 	 * type value and format definitions. Load both right
@@ -933,8 +933,10 @@ static struct perf_pmu *pmu_lookup(int dirfd, const char *lookup_name)
 		return NULL;
 
 	pmu->cpus = pmu_cpumask(dirfd, name);
-	pmu->name = strdup(name);
+	if (!pmu->cpus && perf_pmu__skip_empty_cpus(name))
+		goto err;
 
+	pmu->name = strdup(name);
 	if (!pmu->name)
 		goto err;
 
@@ -964,7 +966,7 @@ static struct perf_pmu *pmu_lookup(int dirfd, const char *lookup_name)
 	list_splice(&aliases, &pmu->aliases);
 	list_add_tail(&pmu->list, &pmus);
 
-	if (is_hybrid)
+	if (!strcmp(name, "cpu_core") || !strcmp(name, "cpu_atom"))
 		list_add_tail(&pmu->hybrid_list, &perf_pmu__hybrid_pmus);
 	else
 		INIT_LIST_HEAD(&pmu->hybrid_list);
-- 
2.40.1.606.ga4b1b128d6-goog

