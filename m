Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4772F7100BC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 00:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234337AbjEXWTf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 18:19:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237204AbjEXWTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 18:19:09 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ED9EE53
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 15:18:56 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-56561689700so28562357b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 15:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684966735; x=1687558735;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Cy7gJw+E0ntMAmmRtEPYe8LOCyWrq0W20Q546Olgu7k=;
        b=mczbeLVP6vX9XhKEziiSA4SHBbGgx2XKtK4C8T3nL2qBfrmK8L0ktZhE+3H+9hl3wO
         vZBzFZdDzO387cRVpPmDkguqDFclulv6SykRF7vHY81JkGOb3sxhp1Jr7cAI2qNBeIco
         MKYHE6p0rfCgmH5GZ3JTHfaMHatUYVk/wSF4UxFUjqLXJFh3oBytoVa0EENGQJ4fuVF1
         kM2BtrC35B9cQwKcRzeuKSH00qpZ7cthUKCBntTvCVwwX5aKebznc7SOtjQBl1NnYD7y
         A7P1KhlD3aEUqrQ2DS2ennyo05n4LJide3clV07VmLmnno5PPoUIi9vPNlmkIouyd6js
         R77w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684966735; x=1687558735;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cy7gJw+E0ntMAmmRtEPYe8LOCyWrq0W20Q546Olgu7k=;
        b=H0cqxx/13NjEKpkmzcM8KiB+ehIG8+bRALe3FfyGwydo5wG8KWwZTIu1jSnX7WEHNr
         k4QBwJeyp3AXBZihzUVkLOhxxxF3N+DjGWD4LAytCJsxzJZdymU3kWGRFwWtxuQ7Tto5
         Ef7xNKG5NW5/CNCX3TCvybpud8XkhWYX2xz8h1cGNfNwLaQXFIFuGSFHS1wvqPTOSY6K
         aKfxaPpWMGJhvEXhTXSrElqt4yPblj2w03mrKd4R1SVqWevE9JZW1XXswk/mk2ZGnP56
         /aDW8UbjhIA2C4EHwu3PRucXraCjslIGcGklkH5GdmhU/KqoXMAjnvo8LgyyKoPvu1kT
         5Ixw==
X-Gm-Message-State: AC+VfDy05nwTxkMSKzpswMpreOmJOUOFxGY1/ajMgmuRXInoJKJYSKHl
        zmMom4Ncpy3VV5bi9WVQbI/gVN+0r8na
X-Google-Smtp-Source: ACHHUZ4+pI9OmzMNkQ1yM/rYnP9CZDetV7ZHH1aIpmqtDz+7oLUAKsSkrbsqtJtcIdRYOtffR7G25A/eVQXh
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:7aa7:3d2d:76ae:8e96])
 (user=irogers job=sendgmr) by 2002:a81:b717:0:b0:560:d237:43dc with SMTP id
 v23-20020a81b717000000b00560d23743dcmr11977209ywh.3.1684966735605; Wed, 24
 May 2023 15:18:55 -0700 (PDT)
Date:   Wed, 24 May 2023 15:18:05 -0700
In-Reply-To: <20230524221831.1741381-1-irogers@google.com>
Message-Id: <20230524221831.1741381-10-irogers@google.com>
Mime-Version: 1.0
References: <20230524221831.1741381-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
Subject: [PATCH v3 09/35] perf evlist: Propagate user CPU maps intersecting
 core PMU maps
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

The CPU map for a non-core PMU gives a default CPU value for
perf_event_open. For core PMUs the CPU map lists all CPUs the evsel
may be opened on. If there are >1 core PMU, the CPU maps will list the
CPUs for that core PMU, but the user_requested_cpus may contain CPUs
that are invalid for the PMU and cause perf_event_open to fail. To
avoid this, when propagating the CPU map for core PMUs intersect it
with the CPU map of the PMU (the evsel's "own_cpus").

Add comments to __perf_evlist__propagate_maps to explain its somewhat
complex behavior.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/perf/evlist.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
index 81e8b5fcd8ba..b8b066d0dc5e 100644
--- a/tools/lib/perf/evlist.c
+++ b/tools/lib/perf/evlist.c
@@ -36,18 +36,33 @@ void perf_evlist__init(struct perf_evlist *evlist)
 static void __perf_evlist__propagate_maps(struct perf_evlist *evlist,
 					  struct perf_evsel *evsel)
 {
-	/*
-	 * We already have cpus for evsel (via PMU sysfs) so
-	 * keep it, if there's no target cpu list defined.
-	 */
 	if (evsel->system_wide) {
+		/* System wide: set the cpu map of the evsel to all online CPUs. */
 		perf_cpu_map__put(evsel->cpus);
 		evsel->cpus = perf_cpu_map__new(NULL);
+	} else if (evlist->has_user_cpus && evsel->is_pmu_core) {
+		/*
+		 * User requested CPUs on a core PMU, ensure the requested CPUs
+		 * are valid by intersecting with those of the PMU.
+		 */
+		perf_cpu_map__put(evsel->cpus);
+		evsel->cpus = perf_cpu_map__intersect(evlist->user_requested_cpus, evsel->own_cpus);
 	} else if (!evsel->own_cpus || evlist->has_user_cpus ||
-		   (!evsel->requires_cpu && perf_cpu_map__empty(evlist->user_requested_cpus))) {
+		(!evsel->requires_cpu && perf_cpu_map__has_any_cpu(evlist->user_requested_cpus))) {
+		/*
+		 * The PMU didn't specify a default cpu map, this isn't a core
+		 * event and the user requested CPUs or the evlist user
+		 * requested CPUs have the "any CPU" (aka dummy) CPU value. In
+		 * which case use the user requested CPUs rather than the PMU
+		 * ones.
+		 */
 		perf_cpu_map__put(evsel->cpus);
 		evsel->cpus = perf_cpu_map__get(evlist->user_requested_cpus);
 	} else if (evsel->cpus != evsel->own_cpus) {
+		/*
+		 * No user requested cpu map but the PMU cpu map doesn't match
+		 * the evsel's. Reset it back to the PMU cpu map.
+		 */
 		perf_cpu_map__put(evsel->cpus);
 		evsel->cpus = perf_cpu_map__get(evsel->own_cpus);
 	}
-- 
2.40.1.698.g37aff9b760-goog

