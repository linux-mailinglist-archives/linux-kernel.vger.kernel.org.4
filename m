Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B84A7132EB
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 09:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231580AbjE0HXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 03:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231637AbjE0HWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 03:22:50 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95CD6E45
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 00:22:47 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5655d99d636so38048397b3.2
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 00:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685172167; x=1687764167;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sTjkcSrIthqBGUF6JyF++nlWwrpLfc1jVqkJtlkt6PQ=;
        b=vkjgchpoH1XPedYIO6/vqF6XE45h/j6eAlFw9kO2YrsTfetys0yIqgYnaYGjje04b5
         UwmnJj+BTaYBeWo/k9KnBbMQp/uHUkF2mxlieD1NpTK6lkq/TNvCF9K6uMh14yp6FqF5
         7sKN1m8k/ZuqlnMfWC1kW0zjDazuJKoaawuPxxR4RGIM1o75Q458EI2HwPtuXFGq5r40
         +meevMGdIBn1ybeDSbALYZ2S2WGHwqheC1Ld9msieGFdT20QVYzIuZGkYwg5XPDypoxk
         7V3b4m1qXojw6WKgdgV5oILZ+DV7b2gRO6Mr2tmbY5y+mZYh6Hn9oZ/0mTsNdjKD9DRS
         Sjbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685172167; x=1687764167;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sTjkcSrIthqBGUF6JyF++nlWwrpLfc1jVqkJtlkt6PQ=;
        b=Y8Nhnf+sTJup5Q6I01rhHAzIZx7Ayxm8PPyyVa0eEKbP5C0GQKWSZO7KAFOA89g8Gr
         V+XToDtu5Kg9PVwZrVFZibVnziO3j7ggMI6LO76pAvcpXJgTj6Hh52+0a0oKCyPCvDNZ
         EV7B97WT7zxXBegOMNsQxc9jrPceeXsQ3E4rgfEPmbNE6/lVx1x6cm9GQdDbiZUQjgZq
         KFDdN/ngIv8073NYuzBRLxhyK36bhmoJIwPDCIUJ5DaxaO0wuXJEXls/TPK/uHX2DnOZ
         IXubD1gOMnYLeeVnehJjOM63bydRnsi3H6pkUA7uRWBZ7LApfMCTQPNk6mUFpcimPG74
         EUSQ==
X-Gm-Message-State: AC+VfDxzSducDSFMT0FM4N8xDVpD3qn+upqx+RVgbRS5flSjDWRNQeDf
        WDHrVIOnm/1RmiEWH5KafuzvMuiBRRfZ
X-Google-Smtp-Source: ACHHUZ64hXEe1Ke8DjqNWXMRsC15N8MX9tNVXda0lKECLIb7tEG39y0EQBt9RQD2u66EgzLH4R+0A9dG6tp/
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:3b4e:312c:644:a642])
 (user=irogers job=sendgmr) by 2002:a05:690c:727:b0:565:a43e:23c7 with SMTP id
 bt7-20020a05690c072700b00565a43e23c7mr2467918ywb.0.1685172166863; Sat, 27 May
 2023 00:22:46 -0700 (PDT)
Date:   Sat, 27 May 2023 00:21:42 -0700
In-Reply-To: <20230527072210.2900565-1-irogers@google.com>
Message-Id: <20230527072210.2900565-7-irogers@google.com>
Mime-Version: 1.0
References: <20230527072210.2900565-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Subject: [PATCH v5 06/34] perf evsel: Add is_pmu_core inorder to interpret own_cpus
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

The behaviour of handling cpu maps varies for core and other PMUs. For
core PMUs the cpu map lists all valid CPUs, whereas for other PMUs the
map is the default CPU. Add a flag in the evsel to indicate if a PMU
is core to help with later interpreting of the cpu maps and populate
it when the evsel is created during parsing. When propagating cpu
maps, core PMUs should intersect the cpu map of the PMU with the user
requested one.

Signed-off-by: Ian Rogers <irogers@google.com>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/lib/perf/include/internal/evsel.h | 9 +++++++++
 tools/perf/util/evsel.c                 | 1 +
 tools/perf/util/parse-events.c          | 1 +
 3 files changed, 11 insertions(+)

diff --git a/tools/lib/perf/include/internal/evsel.h b/tools/lib/perf/include/internal/evsel.h
index a99a75d9e78f..4d6f2a032f45 100644
--- a/tools/lib/perf/include/internal/evsel.h
+++ b/tools/lib/perf/include/internal/evsel.h
@@ -41,7 +41,14 @@ struct perf_sample_id {
 struct perf_evsel {
 	struct list_head	 node;
 	struct perf_event_attr	 attr;
+	/** The commonly used cpu map of CPUs the event should be opened upon, etc. */
 	struct perf_cpu_map	*cpus;
+	/**
+	 * The cpu map read from the PMU. For core PMUs this is the list of all
+	 * CPUs the event can be opened upon. For other PMUs this is the default
+	 * cpu map for opening the event on, for example, the first CPU on a
+	 * socket for an uncore event.
+	 */
 	struct perf_cpu_map	*own_cpus;
 	struct perf_thread_map	*threads;
 	struct xyarray		*fd;
@@ -65,6 +72,8 @@ struct perf_evsel {
 	 * i.e. it cannot be the 'any CPU' value of -1.
 	 */
 	bool			 requires_cpu;
+	/** Is the PMU for the event a core one? Effects the handling of own_cpus. */
+	bool			 is_pmu_core;
 	int			 idx;
 };
 
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 2f5910b31fa9..8c8f371ea2b5 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -415,6 +415,7 @@ struct evsel *evsel__clone(struct evsel *orig)
 	evsel->core.nr_members = orig->core.nr_members;
 	evsel->core.system_wide = orig->core.system_wide;
 	evsel->core.requires_cpu = orig->core.requires_cpu;
+	evsel->core.is_pmu_core = orig->core.is_pmu_core;
 
 	if (orig->name) {
 		evsel->name = strdup(orig->name);
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index b93264f8a37c..1a0be395c887 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -260,6 +260,7 @@ __add_event(struct list_head *list, int *idx,
 	evsel->core.cpus = cpus;
 	evsel->core.own_cpus = perf_cpu_map__get(cpus);
 	evsel->core.requires_cpu = pmu ? pmu->is_uncore : false;
+	evsel->core.is_pmu_core = pmu ? pmu->is_core : false;
 	evsel->auto_merge_stats = auto_merge_stats;
 	evsel->pmu = pmu;
 	evsel->pmu_name = pmu && pmu->name ? strdup(pmu->name) : NULL;
-- 
2.41.0.rc0.172.g3f132b7071-goog

