Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5EA7132F0
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 09:23:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231824AbjE0HXU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 03:23:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231583AbjE0HXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 03:23:03 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2554E61
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 00:22:52 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-ba8c3186735so3209461276.3
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 00:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685172172; x=1687764172;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6VCKvRGvQOyrxybTaQrpXvOpYk1EydxEOVUgh/PqmgI=;
        b=yV1YZNOsvfeF4Ft293I2i0bt5grnyJq5eVrNGq/gtSC3F/RgJNaIZhMktW37517hxO
         rof3nnNYGR/xHOPf25XZqdFVhDeQXyElDr5mQE/HnNITL60AcuZ0Q4xLCR8Po5aWKycf
         cg26fe0UkDqsuMJP2PbvP4i2YEZKPeV/TC6PHtTivv7tQzoVb06r3uWpM1G1qSi/dhIN
         dTl2NIeqYJjyTILMSjOxLZiiOhs8MfVJNJpuvSEGaHjlDrvPPyFBDG2Uy1O/6YwW6y1D
         Z/KMbDXZpkXpfOJosj4KbCDjkf6SnPGvaTheTL0xAm83+xHi4G8/Z3wtNq/ExN3NiZ9V
         LA7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685172172; x=1687764172;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6VCKvRGvQOyrxybTaQrpXvOpYk1EydxEOVUgh/PqmgI=;
        b=RkyvdBd25qfVd+NURtTcTD4BHS7kz0jyOVg8aGFC5p3Ec+sAc848/UUhwQs5saiscp
         r1G8Te8uShCQczV521MIshduX0aW9yhSrgG3Gg6eM81sBqZkNpQLtfJI30DbYaZ8sdQr
         hPOFys8GtBvUBJKjEc7gc1Tgx/jq8CF6CG4TLKZLHSI12YubujNoTK0Q9/pcHIycoXp1
         iFPBbewLI07AaI4hw1hCw25HePbpCaNJDnPgYITI79L8N+Ub2AhFb4h7mR0h4sig+BdT
         Ay51kXlR0TtDonbnHaSk33exoD26ZLLhm9DHkEMsBmR+FfK/vxxVOwckVRTKKV47sBJW
         9XGA==
X-Gm-Message-State: AC+VfDxYvbNKr2CHz/Gk17N1gHRhYwkxivKkB7I/hr4UAv429sL5gbx9
        GaOyuDyaslTbYF5mmr9Q7U6T+cBeoCCZ
X-Google-Smtp-Source: ACHHUZ5JeQ9nyVEs3oW+zOQKSK/IHbI+WzsmAygnPimX7a4dLNlsSwWaFNTetcMS7UG08rHYiIQSghAtW2ax
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:3b4e:312c:644:a642])
 (user=irogers job=sendgmr) by 2002:a25:8211:0:b0:ba7:5bec:7772 with SMTP id
 q17-20020a258211000000b00ba75bec7772mr1632189ybk.5.1685172171783; Sat, 27 May
 2023 00:22:51 -0700 (PDT)
Date:   Sat, 27 May 2023 00:21:44 -0700
In-Reply-To: <20230527072210.2900565-1-irogers@google.com>
Message-Id: <20230527072210.2900565-9-irogers@google.com>
Mime-Version: 1.0
References: <20230527072210.2900565-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Subject: [PATCH v5 08/34] perf evlist: Propagate user CPU maps intersecting
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

