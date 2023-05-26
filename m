Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FBDF712F3F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 23:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244181AbjEZVzI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 17:55:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244157AbjEZVyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 17:54:49 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B394FE66
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 14:54:35 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-561bad0999aso31284027b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 14:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685138074; x=1687730074;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6VCKvRGvQOyrxybTaQrpXvOpYk1EydxEOVUgh/PqmgI=;
        b=uEP9U0nKmj8Ymr7ZepfrEW5aT5lelMPt3agjhkx5Hd62wHoNVyQhPIarzyb93cTaof
         qEF+JjQRput/yCXcaSUK5c1Y8Wi10/o9AbUmWWegqf0kGgW9uFoDO4soCi43EdVVKJd6
         DnW5dGgnk6Km784NW11TV6D4IV4hTP8xcRzkmg4p23zhYWpZVgGVoBBkYr5blhiSHZ7s
         vszRrPl3ILHCVfGuPJhQ/110ab+lNdLR2JIKoQQQEe4oJj0dtKVuP4NNXHgU1v6AQrgD
         qwyf2BrAM6o97lBuBJetI3C+KdgQNUVXjHFi1IL1DVK0PPXiy7Q3f8KtllQeWaSkVlsN
         paQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685138074; x=1687730074;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6VCKvRGvQOyrxybTaQrpXvOpYk1EydxEOVUgh/PqmgI=;
        b=MgcpJK3dl/rI2LVbP4IBG8O5aHn1mSWNQN3DeDbxNxamUYJz02xzu3GAy+MGepMlmz
         JlEWruf09NeyfRkA0yIqNfqvfsUS2lunbZxM9kGt8GwN6sa2Y2pBnD7PHFza4q0LY29h
         /+2DpeyJVL+xi7adQJb6582ViyEIU00M2YNKy7ciuORtYOaWr/22lre6zn1QM3XzIWVS
         mBiIe4fBv/y6k02gamS3j1MQA1eKowdhV/xbPHdgSGB0Is1HuVDCp4fRSoOHsOg/5Kup
         x9GT4+h2zHMtS5fn7bFuuyX9bomAv2c0y8lrx+eHdRwu31E0zbtI/onaO/B0QvrQiNqp
         IMuQ==
X-Gm-Message-State: AC+VfDxIrXaa4KAvN0PWWtGVSrPQc8B/liOfO0tVtLzgI6UVhxQ3C2v2
        jfWmqqY1Vfrt3MGJnwWgs1ZQ7n7eCESw
X-Google-Smtp-Source: ACHHUZ5T/7yAUIvjTc4+VaRWlhjcegjXRqmqsz6bUjSqb1T23XSW4W+5lov5726eTFuZg5EgBmj4O/Ky+rzg
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:3b4e:312c:644:a642])
 (user=irogers job=sendgmr) by 2002:a81:de06:0:b0:561:856f:69d3 with SMTP id
 k6-20020a81de06000000b00561856f69d3mr1828697ywj.7.1685138074694; Fri, 26 May
 2023 14:54:34 -0700 (PDT)
Date:   Fri, 26 May 2023 14:53:44 -0700
In-Reply-To: <20230526215410.2435674-1-irogers@google.com>
Message-Id: <20230526215410.2435674-10-irogers@google.com>
Mime-Version: 1.0
References: <20230526215410.2435674-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Subject: [PATCH v4 09/35] perf evlist: Propagate user CPU maps intersecting
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
complex behavior. Fix the related comments for system_wide in struct
perf_evsel.

Signed-off-by: Ian Rogers <irogers@google.com>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/lib/perf/evlist.c                 | 25 ++++++++++++++++++++-----
 tools/lib/perf/include/internal/evsel.h |  6 +++---
 2 files changed, 23 insertions(+), 8 deletions(-)

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
diff --git a/tools/lib/perf/include/internal/evsel.h b/tools/lib/perf/include/internal/evsel.h
index 4d6f2a032f45..5cd220a61962 100644
--- a/tools/lib/perf/include/internal/evsel.h
+++ b/tools/lib/perf/include/internal/evsel.h
@@ -62,9 +62,9 @@ struct perf_evsel {
 	int			 nr_members;
 	/*
 	 * system_wide is for events that need to be on every CPU, irrespective
-	 * of user requested CPUs or threads. Map propagation will set cpus to
-	 * this event's own_cpus, whereby they will contribute to evlist
-	 * all_cpus.
+	 * of user requested CPUs or threads. Tha main example of this is the
+	 * dummy event. Map propagation will set cpus for this event to all CPUs
+	 * as software PMU events like dummy, have a CPU map that is empty.
 	 */
 	bool			 system_wide;
 	/*
-- 
2.41.0.rc0.172.g3f132b7071-goog

