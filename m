Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6A67100B5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 00:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237012AbjEXWTT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 18:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236692AbjEXWS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 18:18:58 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 985301B1
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 15:18:49 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-ba8c3186735so2677288276.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 15:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684966728; x=1687558728;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f6ARFnsShab3VUnC8Sy2LkNPFWjyLZdSNydBFV23IFk=;
        b=WkyS6Afb90FUud0LxsdKmCb0VbkRe9m484H8ADjpO6UNGvuAHVAye0aaglkXIEFVci
         ckvJxndJzT5yWtkwTLmT1ZRih/WAMKK8iVbl6mGg+Fg9UcBPc2ps+iXFU3RMUCfxMwlA
         zuKUkJErOORn83lxGeoRqOTkPYzw3QjsrSGo3KVE892ZYbtlt/k4h1936SSVfQxQ+ORC
         15y3qDa9T2WnhVp1VIhnOdJ2oNHOIo5ntJhJREFMQ6gHS21QkbzfSlJaKOaHkxxrOVOk
         9qW2OOKj3CgzG8OzkC5OhAuj1pMCs6fMC/TQmQX9Kzi2NeoFk9+P3bRLLaKtJBX/3dd6
         HbOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684966728; x=1687558728;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f6ARFnsShab3VUnC8Sy2LkNPFWjyLZdSNydBFV23IFk=;
        b=Y3bkP3kh6vUaPPwTq6Y4lxOg/3i1o+IHQhYLtoqPmPvQqY1x+Tl1niX5hcpEIK4wXl
         q5uAPg0Vgj1MBVaRlmcF8ARAHpvSIXc5Yr2bdcCQzIoelc/iN51aKzYh7YpQQSEtWNQQ
         RwfVz+HcxFu1vrB8zK5/C+nuVjQsWWoG9fLMXdZZ3Pai6DeK3VaGb0xvuyA3acNt52VL
         pgsgVO49OTFEvRf/l6/NFwE/XrK7vpVMrb2FXPE3xGya0LR+rb+eDvz78PQHwmJ9//Fg
         Hc7zDFhWz1RVVqn0v0u2ufOn28YHus8F6NZmwJ9qLiR7PH92eMyEbAlFK8J0CHgO03RM
         Ap3Q==
X-Gm-Message-State: AC+VfDwHUiCKrezekJHGTdXxRFkK4JhCHjoRgifLuXcps4rO0Ksp80W9
        j8LWeQW0Z3aBV7SoP3vmBlD9U6Pr2eol
X-Google-Smtp-Source: ACHHUZ7XBYnZO2uhMGuSnsWVJiC7PL6RhVQiB0SP4HBy2wQ3gSfqdJASvFAp3xt8/SSnxEeIybbl30w+RhCp
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:7aa7:3d2d:76ae:8e96])
 (user=irogers job=sendgmr) by 2002:a5b:652:0:b0:ba8:8fad:c19d with SMTP id
 o18-20020a5b0652000000b00ba88fadc19dmr556589ybq.8.1684966728557; Wed, 24 May
 2023 15:18:48 -0700 (PDT)
Date:   Wed, 24 May 2023 15:18:02 -0700
In-Reply-To: <20230524221831.1741381-1-irogers@google.com>
Message-Id: <20230524221831.1741381-7-irogers@google.com>
Mime-Version: 1.0
References: <20230524221831.1741381-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
Subject: [PATCH v3 06/35] perf pmu: Add is_core to pmu
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cache is_pmu_core in the pmu to avoid recomputation.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmu.c | 7 ++++---
 tools/perf/util/pmu.h | 7 +++++++
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 7392cec725bf..e8c0762c311a 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -952,6 +952,7 @@ static struct perf_pmu *pmu_lookup(int dirfd, const char *lookup_name)
 	}
 
 	pmu->type = type;
+	pmu->is_core = is_pmu_core(name);
 	pmu->is_uncore = pmu_is_uncore(dirfd, name);
 	if (pmu->is_uncore)
 		pmu->id = pmu_id(name);
@@ -1659,12 +1660,12 @@ bool is_pmu_hybrid(const char *name)
 
 bool perf_pmu__supports_legacy_cache(const struct perf_pmu *pmu)
 {
-	return is_pmu_core(pmu->name);
+	return pmu->is_core;
 }
 
 bool perf_pmu__supports_wildcard_numeric(const struct perf_pmu *pmu)
 {
-	return is_pmu_core(pmu->name);
+	return pmu->is_core;
 }
 
 bool perf_pmu__auto_merge_stats(const struct perf_pmu *pmu)
@@ -1723,7 +1724,7 @@ void print_pmu_events(const struct print_callbacks *print_cb, void *print_state)
 	pmu = NULL;
 	j = 0;
 	while ((pmu = perf_pmu__scan(pmu)) != NULL) {
-		bool is_cpu = is_pmu_core(pmu->name);
+		bool is_cpu = pmu->is_core;
 
 		list_for_each_entry(event, &pmu->aliases, list) {
 			aliases[j].event = event;
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index f50919f1b34c..96236a79c6fd 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -59,6 +59,13 @@ struct perf_pmu {
 	 * @selectable: Can the PMU name be selected as if it were an event?
 	 */
 	bool selectable;
+	/**
+	 * @is_core: Is the PMU the core CPU PMU? Determined by the name being
+	 * "cpu" or by the presence of
+	 * <sysfs>/bus/event_source/devices/<name>/cpus. There may be >1 core
+	 * PMU on systems like Intel hybrid.
+	 */
+	bool is_core;
 	/**
 	 * @is_uncore: Is the PMU not within the CPU core? Determined by the
 	 * presence of <sysfs>/bus/event_source/devices/<name>/cpumask.
-- 
2.40.1.698.g37aff9b760-goog

