Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3B4E706BEB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 16:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232174AbjEQO70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 10:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232186AbjEQO65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 10:58:57 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 691AB40CE
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 07:58:52 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-ba87bd29e9dso485426276.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 07:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684335531; x=1686927531;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KA2y3jyQTsl7bjOICY6NhHPKj7ufhNOPyvMqFoPtgZA=;
        b=nljeFfxFSjqFfJqFStpIFN0yXSLDlIJAsXrvpuUvYrzfgwPDYXCv05IGjt8JAYLOMu
         GIWqE6phlYNkqkWg1UlvdP9uFzTnCLcKUhhQZhxm0Hpim9t+Z0kHz+ttA/5X72bOa/HG
         gIXZGSBzf9lnCHE0W2XP4S6w8Sqj0vZ+OnuTQAtK0jDwkc52avQEgxhjfSnwPT8NTkKm
         ZqGMOALc5jdW8KC/iXGwy2CMR5Xz/bEot5QGTbz3PBAgzvxOa/0U+N4xOxh07EgCnS1a
         hV4fKa3uvhrgW4ZWmwNZZGwysWZKpw8xHvj6xyvlf+wFUmfwd6vofN5SIYMFcd4Usfu+
         8YBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684335531; x=1686927531;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KA2y3jyQTsl7bjOICY6NhHPKj7ufhNOPyvMqFoPtgZA=;
        b=A2y3qu86oTeVWDVrBdM7ovpBDDEQ+uUFXyn+SzDczA1UwMRhBPmIpsDjEN/dDYFKJB
         03EfAfUlIWHLq52BmHyZpS+yLTwjyrc8dmrfd51vzkdccq5MNW/I46Vkk3siG6Xk18Bt
         0kXTKbDzWcUYOVgZvT+oQUo8x5gOu61edfQ+Y9y9mM6xXxQCIRRMTel8yHTk9GAt8Q1j
         VWNaPdUcrwnbmd+QOOpd0CVJJesEUOrlITnopHaMylgfs0j8pmadHqhr+Wt/SYOUG8F8
         Oc0QUxsBZtr7N/ehbehpsFUCEwuN/YLpzfbh3lv4MHiHtYNthYwa8TJTa/mr7p/VMKG9
         GJog==
X-Gm-Message-State: AC+VfDwByzddTO9M4pILkWQBLZhpjsfIvNW1fC2peVMbShmyUCyiVeio
        W25i/33roxrcJPjXy6BREWya4yfZy5vi
X-Google-Smtp-Source: ACHHUZ7XjP/AcWyCffYYC9nXeJBjM5TS+YMrfsqU5e91nSKBzb1vGFoVNbDb5wbW3KyZZ72fzUAIER8KKBrj
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:628b:7e78:d09b:39b])
 (user=irogers job=sendgmr) by 2002:a25:3211:0:b0:ba8:2415:f27c with SMTP id
 y17-20020a253211000000b00ba82415f27cmr3416215yby.3.1684335531452; Wed, 17 May
 2023 07:58:51 -0700 (PDT)
Date:   Wed, 17 May 2023 07:57:47 -0700
In-Reply-To: <20230517145803.559429-1-irogers@google.com>
Message-Id: <20230517145803.559429-8-irogers@google.com>
Mime-Version: 1.0
References: <20230517145803.559429-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
Subject: [PATCH v1 07/23] perf pmu: Add is_core to pmu
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
        autolearn=ham autolearn_force=no version=3.4.6
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
2.40.1.606.ga4b1b128d6-goog

