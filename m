Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24C4970B540
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 08:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232032AbjEVGo2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 02:44:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231833AbjEVGoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 02:44:03 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4DA61A4
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 23:43:51 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-ba81b24b8a4so6825995276.2
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 23:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684737831; x=1687329831;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BuxkA8aKV6AKQDyTxhZEBY1QXMea1aO9KvWEXYFaDV0=;
        b=Wny7cS+8agscH7kiozGeG/23zdqV5hRMOkq3A76rYH7Gjbw+CuOVfq2iXuHsu80E5T
         YRmQ5Ona7FHZ1dy38IzXa5Ub8HbHqjf0+cD4vzsZtUP7ARHh9ObtC3nlrqguhQ/FQnV8
         +mrTO0UrA54cA6dRwbCCFiXgr7vFm8p+nzvcQLzSPD8Cfwhz5yhZQPCL9F4rxlrGjqOz
         pAcaKtIyc3laswVYRolExGhwKtFcq3KeB74OtdfCgwVbpLLE9L6s7EfeAu8+X1AhGyg+
         PleeLkMwUQPddCrjR6XMGLmVKePX+zENoGBSjIa9K1G04TJKGfblzqceYty0PmYtIy4W
         j09g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684737831; x=1687329831;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BuxkA8aKV6AKQDyTxhZEBY1QXMea1aO9KvWEXYFaDV0=;
        b=LaPzoS5qxkGSIrO9+mfmOAdpbeeJVAy0AGYKtfWXqlmpZSW3H8UNe7lokCGW2DVEC4
         ZRhCW0VNcWRc36QZBZ2WDXPVQ6ib/3DZy0p+/B3Ge+o+O7PcM86Zf7z4NXwj+ZzRdSAB
         TP4d8QqEbosnww7XOLL5aBdJbJ8OXvD7mKKoq81EmEoNp+z+upq1NnWpm3Ko3/doZYbb
         xTnVl97x3Y+Bia/pwLFxBYWpdlEKuVMhkNL7fa8R3T+G17/PjDTx8HKKlZWnpq99s/zm
         DP81QB/moDUCrsEDPzaZJCtUK8mY+quO7eL+k6ISyINqENkhfksW1oKhw5VfakwTZr5w
         lTkg==
X-Gm-Message-State: AC+VfDyz4afLc7HspzuSilml8qpBkYl1ZPaR7Lys1X4roGQKntsWvugt
        Pb/AkvT0nJpf0ghkZDgNwrWJsXoklC2m
X-Google-Smtp-Source: ACHHUZ7yBhemL5Zfp+6Mb1mVUpfqt5JkMqFSlUv27bdZVJmzGQnH4k6PtMTPKLmkxP6cJJfNK5hvrNYe0npN
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:48d9:8c21:e099:7301])
 (user=irogers job=sendgmr) by 2002:a05:6902:283:b0:ba8:4c16:78b7 with SMTP id
 v3-20020a056902028300b00ba84c1678b7mr5956768ybh.12.1684737830760; Sun, 21 May
 2023 23:43:50 -0700 (PDT)
Date:   Sun, 21 May 2023 23:43:14 -0700
In-Reply-To: <20230522064330.189127-1-irogers@google.com>
Message-Id: <20230522064330.189127-8-irogers@google.com>
Mime-Version: 1.0
References: <20230522064330.189127-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
Subject: [PATCH v2 07/23] perf pmu: Add is_core to pmu
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
index 0fa451c60c77..930ec3786964 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -954,6 +954,7 @@ static struct perf_pmu *pmu_lookup(int dirfd, const char *lookup_name)
 	}
 
 	pmu->type = type;
+	pmu->is_core = is_pmu_core(name);
 	pmu->is_uncore = pmu_is_uncore(dirfd, name);
 	if (pmu->is_uncore)
 		pmu->id = pmu_id(name);
@@ -1661,12 +1662,12 @@ bool is_pmu_hybrid(const char *name)
 
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
@@ -1725,7 +1726,7 @@ void print_pmu_events(const struct print_callbacks *print_cb, void *print_state)
 	pmu = NULL;
 	j = 0;
 	while ((pmu = perf_pmu__scan(pmu)) != NULL) {
-		bool is_cpu = is_pmu_core(pmu->name);
+		bool is_cpu = pmu->is_core;
 
 		list_for_each_entry(event, &pmu->aliases, list) {
 			aliases[j].event = event;
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 99e0273027bf..af10d137e2b5 100644
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

