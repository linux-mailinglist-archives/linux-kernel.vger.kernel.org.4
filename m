Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2F9E7132F7
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 09:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231398AbjE0HYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 03:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbjE0HYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 03:24:00 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D790E68
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 00:23:30 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1b00f70e6b0so17247795ad.0
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 00:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685172188; x=1687764188;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oDuqTopdZxG/tZhzCpsOUxdl3hr1CdgTwDzFadwyJDk=;
        b=oBlR1tSCzKq0s0LSoPmfz2djLlR2JY1U34JfKZKwznkJjmKhZk/RvdTioa8+q4fLjx
         TpwS0r+d9cii6tRr5zF2F2ok0wLIa0tDwnU2W/zqhfPOlizuFbSSD2SXQvMB1z6c5NXo
         hTgOaIhnrZBuzm2I8alnTR7M8RAjDRLbSTeF/vqsy1BzeY6Bw1npOOfEeZlxgAgTGiyC
         JiiC2+pDODqDVfPosRcBt1Bd87uhc9OkhsSclVMlXiuEtbe8od2DcBHTTRX0xkAsdCcn
         2zM1gcKArV0Ke5cWa8SpS/cMyeXlllCPzuRInLBitJW97+z6/i/8TtRxJl/VQEnzsJQi
         WBsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685172188; x=1687764188;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oDuqTopdZxG/tZhzCpsOUxdl3hr1CdgTwDzFadwyJDk=;
        b=VPPl5bYoZaWJOe8A3BFggS+b0oRYU9Uqv3GsPM58ysnuktQ+JVRJClzSLFSgqs4bDi
         3SxhSQJ1ATiQNguuMZfLvIrgd8D0ErpixRsDw5N0e39id97bmRm5LcRp4+DK4gO4XlVW
         LxEk1roIAuxrwSSdUK+skZIplDvAzrU/EkbOQGcRdyu5FFX1hPbI/6s3w7uQiT7CIqBv
         qRwbpnfvxNt+I07wknk3CZB0ndWzbVG+n75F2nL836NIUaFGtGOumN8nH8NHZLfzHnGq
         jnH+qJBUkhuOYSsLqLLIMjhinG4EjeGOdJ9iAX32GZudnkwJJcHllm1tG7qo+itN5yb4
         nh7w==
X-Gm-Message-State: AC+VfDykramvUDClzYOb2Y/FXL6uiEj3agpZjRsLeAHSsmZ4E5tgSH0D
        yU5fTs/RleF6+9yCksksoanOtzsxXmbK
X-Google-Smtp-Source: ACHHUZ7DY38xUWWvbJCVd1fK6G0AJ4aTIxafAEHZ/Mds9Jq2tgo4+2Mgs+r+3/FVPiCUM8bqZzT1ZnmhrIdt
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:3b4e:312c:644:a642])
 (user=irogers job=sendgmr) by 2002:a17:903:1cf:b0:1a6:a899:fe78 with SMTP id
 e15-20020a17090301cf00b001a6a899fe78mr1208114plh.2.1685172188090; Sat, 27 May
 2023 00:23:08 -0700 (PDT)
Date:   Sat, 27 May 2023 00:21:51 -0700
In-Reply-To: <20230527072210.2900565-1-irogers@google.com>
Message-Id: <20230527072210.2900565-16-irogers@google.com>
Mime-Version: 1.0
References: <20230527072210.2900565-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Subject: [PATCH v5 15/34] perf pmu: Remove perf_pmu__hybrid_mounted
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

perf_pmu__hybrid_mounted is used to detect whether cpu_core or
cpu_atom is mounted with a non-empty cpus file by
pmu_lookup. Discussion [1] showed the empty cpus file check to be
redundant and so pmu_lookup needn't have a call to
perf_pmu__hybrid_mounted.

Checking hybrid_mounted in pmu_is_uncore is redundant as the next
cpumask read will fail returning false.

Reduce the scope of perf_pmu__find_hybrid_pmu by making it static.

[1] https://lore.kernel.org/lkml/20230524221831.1741381-17-irogers@google.com/

Signed-off-by: Ian Rogers <irogers@google.com>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/util/pmu-hybrid.c | 15 +--------------
 tools/perf/util/pmu-hybrid.h |  3 ---
 tools/perf/util/pmu.c        | 13 +------------
 3 files changed, 2 insertions(+), 29 deletions(-)

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
index cd94abe7a87a..83c7eeb8abea 100644
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
@@ -907,15 +904,8 @@ static struct perf_pmu *pmu_lookup(int dirfd, const char *lookup_name)
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
@@ -936,7 +926,6 @@ static struct perf_pmu *pmu_lookup(int dirfd, const char *lookup_name)
 
 	pmu->cpus = pmu_cpumask(dirfd, name);
 	pmu->name = strdup(name);
-
 	if (!pmu->name)
 		goto err;
 
@@ -967,7 +956,7 @@ static struct perf_pmu *pmu_lookup(int dirfd, const char *lookup_name)
 	list_splice(&aliases, &pmu->aliases);
 	list_add_tail(&pmu->list, &pmus);
 
-	if (is_hybrid)
+	if (!strcmp(name, "cpu_core") || !strcmp(name, "cpu_atom"))
 		list_add_tail(&pmu->hybrid_list, &perf_pmu__hybrid_pmus);
 	else
 		INIT_LIST_HEAD(&pmu->hybrid_list);
-- 
2.41.0.rc0.172.g3f132b7071-goog

