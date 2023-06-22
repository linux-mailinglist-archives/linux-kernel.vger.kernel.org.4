Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2907073969A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 07:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbjFVFDw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 01:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbjFVFDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 01:03:46 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1830C19B4
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 22:03:46 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-bd5f9d084c9so7762562276.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 22:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687410225; x=1690002225;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x8Rsb54/MYGUaB2iRhrucGZnS8r6HVo39FnjfvBr1XU=;
        b=GpRUf2G0Kjjc8MioX56rzakjdiz2XaTj+A/amagDGFOs4eS0bJAORFDFntoapgIt9K
         AG9Q/X7yigaaRwdGjSNTjAD9vPnnSxMGLlrDwOfydk+lxX43+Guai4OsLplPRJ882O6D
         hHm5Nyacar5+Hrp3AlLhQxZZgk7HvmvdUlUp7jO5mnkcrpvZjGChdxImGgdCsRWG/8L+
         a/+D/g91D+Ogsp4+zYrQ9Ybr4jFz+2mH3f50sHqjcJyRTvzOgkHFOtKloGIXG63IWMdm
         UrJnTgT+980It2KL1Jz0B0WyhMN8wzB4eUtrzBWh2Z7n3RAjVYS5xFeDb8ZdUpotebjH
         0WAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687410225; x=1690002225;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x8Rsb54/MYGUaB2iRhrucGZnS8r6HVo39FnjfvBr1XU=;
        b=g7ciQFszf7ZAOkaGU7w96ZokJ6D45sOcWmRqhFJUa9TcuCsoOeu2RR3giaqPGcP/p1
         V2pW2ilAw3lzOHFxLIowdVYVQVpLpTxyYT74AzYgorYmcLeZuLepd8p1+FR/R/gnIzwB
         rNpFChdmBUnvQz7yZAJKKVkaXNGMbhuZA/0ZSOofci6zKfrPd4eY11jGOwH9FLreSOh7
         yXJXfaPz4nlcSLYMLW417Z7Y4z93r7ykEL3U+59Px/egXvrRnxucdZbUmXoeaRhY16OY
         D2LM+0Z8nnyYJOJ3Bp3ZpbsSKDb5D3emObcDsCUha0IM5GLjp/YJYWMU9dJCHLntcmI/
         U2NA==
X-Gm-Message-State: AC+VfDw0WGpizXBmx4705i8fTsOjcYxOKuLA4t91UdHF2sDDQyfGwxVn
        nwjiCuuLoPIrs+2xMfWUxO1pTu7E5/sg
X-Google-Smtp-Source: ACHHUZ7ARfJoVAEvnUkQb8tQpVCFdx+usSVxdKSOM+7ibrCp77WpcmrZhsekCA+OnSG5YZJ3g4/sqKxl+fRn
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:91f3:1da5:6427:50d6])
 (user=irogers job=sendgmr) by 2002:a25:7346:0:b0:bfe:9259:8f1d with SMTP id
 o67-20020a257346000000b00bfe92598f1dmr2318249ybc.6.1687410225349; Wed, 21 Jun
 2023 22:03:45 -0700 (PDT)
Date:   Wed, 21 Jun 2023 22:03:29 -0700
In-Reply-To: <20230622050330.3733114-1-irogers@google.com>
Message-Id: <20230622050330.3733114-2-irogers@google.com>
Mime-Version: 1.0
References: <20230622050330.3733114-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Subject: [PATCH v1 2/2] perf pmu: Remove a hard coded cpu PMU assumption
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The property of "cpu" when it has no cpu map is true on S390 with the
PMU cpum_cf. Rather than maintain a list of such PMUs, reuse the
is_core test result from the caller.

Signed-off-by: Ian Rogers <irogers@google.com>
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

