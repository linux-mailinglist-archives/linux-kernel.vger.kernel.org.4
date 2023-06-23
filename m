Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F96773AF7B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 06:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbjFWEiy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 00:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbjFWEiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 00:38:51 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1EB62128
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 21:38:49 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-c01e1c0648aso375425276.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 21:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687495129; x=1690087129;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zSgIO0IVog8h08+2nGqjj2Vojr4jZTwgL22RxcdKB8c=;
        b=pF+CFh8/5u2Z5RBQgr2MWTPNCEUjVpUBMCnSdMzJB/KZWA0IKVKiQ+Wqmlb2mW9RbD
         hVGDqfIWzHjL3ZaXxOw4o9s1mjcwA90CLFIeRTW5g09K98ggbYg5E2c9Q3kcYLd1PFrw
         nFOZnHTQO3pSAxDSyFtmmL5XVCahAcx5K7St5Snxnh575V6f8ErFJBghxg2ida46LmKk
         cml6B1PxYE+CVwP+bmDr188ma2IZmy/ImSLmwU3JZ+nWUCYYoRJqgM38V3P9A0O0RRIs
         Zb43CsELEz5HJUXOaNsLQg9Ya+Ck+HUMWieQePr2zniwLHXD4tMsGv5lmPAE7fEiZNFD
         agDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687495129; x=1690087129;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zSgIO0IVog8h08+2nGqjj2Vojr4jZTwgL22RxcdKB8c=;
        b=C3T2FVXvqEmDlEJXDtxnnxKtwgZ1JUzNRIQkGtgtvX1R02L6s0zAVo7/j5XC0LJcne
         pVhDDWUKBnC+ygkqCFqfw5SgUJUdPGu4JLEwqxgZHSqY3xkeRXmENIHyuLPSmYlcYrmI
         TJE2hUW5lYYa4XGMwyZiOWh1nVKuETNn531bjyxM+PQYuHT838OPFkBnZCLO6JaycWd/
         3QVk+7NpypnWdk9TcD7ZV0tYIyyGiGf/Jf1upj3Q6OjO3w3/053TXXvZYamaOpQRoysu
         kHsMwZ3XPnbUCLY5q9YnqYcmy7SvElyHxdj9m1XnTtBZxJ7U57Ycst/rnstsJr4s63Zx
         buoA==
X-Gm-Message-State: AC+VfDzB2ydoDDUzjYjZdkl9dQtTYfd9Pb+T335Tzc/HQmn4XQlnaqrm
        pGQENiLi50AJ8jpXzLTfc1EndM7sX6yp
X-Google-Smtp-Source: ACHHUZ4D3YHzemZB860M9VC9gPhZL3DKE+p9XnnIPbZKTGwS8Qsz5zuNTyNmErEBA6TM/yBk4wyKOuJ0gtvS
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:6559:8968:cdfe:35b6])
 (user=irogers job=sendgmr) by 2002:a25:d387:0:b0:bd6:9fb7:69bb with SMTP id
 e129-20020a25d387000000b00bd69fb769bbmr8881880ybf.13.1687495129061; Thu, 22
 Jun 2023 21:38:49 -0700 (PDT)
Date:   Thu, 22 Jun 2023 21:38:43 -0700
In-Reply-To: <20230623043843.4080180-1-irogers@google.com>
Message-Id: <20230623043843.4080180-2-irogers@google.com>
Mime-Version: 1.0
References: <20230623043843.4080180-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Subject: [PATCH v2 2/2] perf pmu: Remove a hard coded cpu PMU assumption
From:   Ian Rogers <irogers@google.com>
To:     Thomas Richter <tmricht@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        James Clark <james.clark@arm.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
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

The property of "cpu" when it has no cpu map is true on S390 with the
PMU cpum_cf. Rather than maintain a list of such PMUs, reuse the
is_core test result from the caller.

Signed-off-by: Ian Rogers <irogers@google.com>
Tested-by: Thomas Richter <tmricht@linux.ibm.com>
---
 tools/perf/util/pmu.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 963c12f910c5..64fa568a5426 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -551,7 +551,7 @@ static int pmu_alias_terms(struct perf_pmu_alias *alias,
  * Uncore PMUs have a "cpumask" file under sysfs. CPU PMUs (e.g. on arm/arm64)
  * may have a "cpus" file.
  */
-static struct perf_cpu_map *pmu_cpumask(int dirfd, const char *name)
+static struct perf_cpu_map *pmu_cpumask(int dirfd, const char *name, bool is_core)
 {
 	struct perf_cpu_map *cpus;
 	const char *templates[] = {
@@ -575,7 +575,8 @@ static struct perf_cpu_map *pmu_cpumask(int dirfd, const char *name)
 			return cpus;
 	}
 
-	return !strcmp(name, "cpu") ? perf_cpu_map__get(cpu_map__online()) : NULL;
+	/* Nothing found, for core PMUs assume this means all CPUs. */
+	return is_core ? perf_cpu_map__get(cpu_map__online()) : NULL;
 }
 
 static bool pmu_is_uncore(int dirfd, const char *name)
@@ -886,7 +887,8 @@ struct perf_pmu *perf_pmu__lookup(struct list_head *pmus, int dirfd, const char
 	if (!pmu)
 		return NULL;
 
-	pmu->cpus = pmu_cpumask(dirfd, name);
+	pmu->is_core = is_pmu_core(name);
+	pmu->cpus = pmu_cpumask(dirfd, name, pmu->is_core);
 	pmu->name = strdup(name);
 	if (!pmu->name)
 		goto err;
@@ -903,7 +905,6 @@ struct perf_pmu *perf_pmu__lookup(struct list_head *pmus, int dirfd, const char
 	}
 
 	pmu->type = type;
-	pmu->is_core = is_pmu_core(name);
 	pmu->is_uncore = pmu_is_uncore(dirfd, name);
 	if (pmu->is_uncore)
 		pmu->id = pmu_id(name);
-- 
2.41.0.162.gfafddb0af9-goog

