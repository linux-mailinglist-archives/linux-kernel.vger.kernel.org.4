Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7B727132F9
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 09:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232068AbjE0HYY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 03:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231849AbjE0HYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 03:24:07 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08EB1E7D
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 00:23:38 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-ba2b9ecfadaso3292500276.2
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 00:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685172193; x=1687764193;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nSaQksCEVnEDaXN3VKZfEAQXs7LM72JmREmXfmsPZ08=;
        b=aTychtkFPXXXaZtgAy5O0ZzWjhhqV7bEL51lpZOXoOBxqvfIhGcaSHMGbFqwP9Ngc+
         wqO+JRuarryPdG2qBv/YGZpVmvM5QlnwNYTn1xI9rb9ZocBFIVeDffh2hHj843C1geFa
         fuX/nAt4TIaGNkoKYt5YAphA44UxHtKQ6SA68hDF47Y1iThkFrm5t9fKGsbjGpkg2h6t
         rlc43ycR0O/hsxlY6k241jw+kkv8ppTTJh064nj4OjURPabOd//Sr4+YmNyxWeYEBUdM
         YfRFKny2wYLIv68cvjjL7Sb+UPdCgulsOGfKDDVbwv6OMcl7RorRTKUIpJmXn49jhGjL
         jm2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685172193; x=1687764193;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nSaQksCEVnEDaXN3VKZfEAQXs7LM72JmREmXfmsPZ08=;
        b=NYC2CufQSnizrUBLoq4YOmbuzvWsUAt0AKUw4gOI0XSDjV3w+dVRxF7omol9ggIbeo
         qAZ4O4KvBdx1GF+CUyX0Jx1FjkaC1JWfa68XD7CnQodHZjeUj5b11YMbQ8qGlNI49ERw
         t5NY0FtmKrq50W4y5Tny5JXDpahXVTKjMRO73gMzW5ATu4S9v8Q88ICwWQfDeqryHf6t
         2ucAYSN96VJRotFNi8J+VlcgG86D9BFwVcOWcm3imdkp4ZkAxLj/sxL48ChAKh4C/b1P
         QLA67Bnb7xeD/GNsRDAzEYO/Q5HNkJoWV29OJsQEsouh2kOW2viP6HrgwGR2f65h1cP0
         1PqA==
X-Gm-Message-State: AC+VfDzeUGgC3KOPwfB4ypENLlXuDfTOoQus2LVZ49ddxSgR3MbT3uyU
        xMARVpu0b2KMaMV/lQAZ+Lo8ETHvtf3j
X-Google-Smtp-Source: ACHHUZ6Q8KFmnDXQQJwiBVojBYy3Z6GVSok1hJcxoePeiSvGkW/9JF2ZeO9TL4CovC7wLLfgtlWzmz1qHCkW
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:3b4e:312c:644:a642])
 (user=irogers job=sendgmr) by 2002:a25:4582:0:b0:ba8:91c2:268a with SMTP id
 s124-20020a254582000000b00ba891c2268amr2372187yba.0.1685172193104; Sat, 27
 May 2023 00:23:13 -0700 (PDT)
Date:   Sat, 27 May 2023 00:21:53 -0700
In-Reply-To: <20230527072210.2900565-1-irogers@google.com>
Message-Id: <20230527072210.2900565-18-irogers@google.com>
Mime-Version: 1.0
References: <20230527072210.2900565-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Subject: [PATCH v5 17/34] perf x86: Iterate hybrid PMUs as core PMUs
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

Rather than iterating over a separate hybrid list, iterate all PMUs
with the hybrid ones having is_core as true.

Signed-off-by: Ian Rogers <irogers@google.com>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/arch/x86/tests/hybrid.c   |  2 +-
 tools/perf/arch/x86/util/evlist.c    | 25 +++++++++++++++++--------
 tools/perf/arch/x86/util/perf_regs.c | 14 ++++++++++----
 3 files changed, 28 insertions(+), 13 deletions(-)

diff --git a/tools/perf/arch/x86/tests/hybrid.c b/tools/perf/arch/x86/tests/hybrid.c
index 941a9edfed4e..944bd1b4bab6 100644
--- a/tools/perf/arch/x86/tests/hybrid.c
+++ b/tools/perf/arch/x86/tests/hybrid.c
@@ -3,7 +3,7 @@
 #include "debug.h"
 #include "evlist.h"
 #include "evsel.h"
-#include "pmu-hybrid.h"
+#include "pmu.h"
 #include "tests/tests.h"
 
 static bool test_config(const struct evsel *evsel, __u64 expected_config)
diff --git a/tools/perf/arch/x86/util/evlist.c b/tools/perf/arch/x86/util/evlist.c
index 1b6065841fb0..03f7eb4cf0a4 100644
--- a/tools/perf/arch/x86/util/evlist.c
+++ b/tools/perf/arch/x86/util/evlist.c
@@ -4,7 +4,6 @@
 #include "util/evlist.h"
 #include "util/parse-events.h"
 #include "util/event.h"
-#include "util/pmu-hybrid.h"
 #include "topdown.h"
 #include "evsel.h"
 
@@ -12,9 +11,6 @@ static int ___evlist__add_default_attrs(struct evlist *evlist,
 					struct perf_event_attr *attrs,
 					size_t nr_attrs)
 {
-	struct perf_cpu_map *cpus;
-	struct evsel *evsel, *n;
-	struct perf_pmu *pmu;
 	LIST_HEAD(head);
 	size_t i = 0;
 
@@ -25,15 +21,24 @@ static int ___evlist__add_default_attrs(struct evlist *evlist,
 		return evlist__add_attrs(evlist, attrs, nr_attrs);
 
 	for (i = 0; i < nr_attrs; i++) {
+		struct perf_pmu *pmu = NULL;
+
 		if (attrs[i].type == PERF_TYPE_SOFTWARE) {
-			evsel = evsel__new(attrs + i);
+			struct evsel *evsel = evsel__new(attrs + i);
+
 			if (evsel == NULL)
 				goto out_delete_partial_list;
 			list_add_tail(&evsel->core.node, &head);
 			continue;
 		}
 
-		perf_pmu__for_each_hybrid_pmu(pmu) {
+		while ((pmu = perf_pmu__scan(pmu)) != NULL) {
+			struct perf_cpu_map *cpus;
+			struct evsel *evsel;
+
+			if (!pmu->is_core)
+				continue;
+
 			evsel = evsel__new(attrs + i);
 			if (evsel == NULL)
 				goto out_delete_partial_list;
@@ -51,8 +56,12 @@ static int ___evlist__add_default_attrs(struct evlist *evlist,
 	return 0;
 
 out_delete_partial_list:
-	__evlist__for_each_entry_safe(&head, n, evsel)
-		evsel__delete(evsel);
+	{
+		struct evsel *evsel, *n;
+
+		__evlist__for_each_entry_safe(&head, n, evsel)
+			evsel__delete(evsel);
+	}
 	return -1;
 }
 
diff --git a/tools/perf/arch/x86/util/perf_regs.c b/tools/perf/arch/x86/util/perf_regs.c
index 0ed177991ad0..26abc159fc0e 100644
--- a/tools/perf/arch/x86/util/perf_regs.c
+++ b/tools/perf/arch/x86/util/perf_regs.c
@@ -10,7 +10,6 @@
 #include "../../../util/debug.h"
 #include "../../../util/event.h"
 #include "../../../util/pmu.h"
-#include "../../../util/pmu-hybrid.h"
 
 const struct sample_reg sample_reg_masks[] = {
 	SMPL_REG(AX, PERF_REG_X86_AX),
@@ -286,7 +285,6 @@ uint64_t arch__intr_reg_mask(void)
 		.disabled 		= 1,
 		.exclude_kernel		= 1,
 	};
-	struct perf_pmu *pmu;
 	int fd;
 	/*
 	 * In an unnamed union, init it here to build on older gcc versions
@@ -294,12 +292,20 @@ uint64_t arch__intr_reg_mask(void)
 	attr.sample_period = 1;
 
 	if (perf_pmu__has_hybrid()) {
+		struct perf_pmu *pmu = NULL;
+		__u64 type = PERF_TYPE_RAW;
+
 		/*
 		 * The same register set is supported among different hybrid PMUs.
 		 * Only check the first available one.
 		 */
-		pmu = list_first_entry(&perf_pmu__hybrid_pmus, typeof(*pmu), hybrid_list);
-		attr.config |= (__u64)pmu->type << PERF_PMU_TYPE_SHIFT;
+		while ((pmu = perf_pmu__scan(pmu)) != NULL) {
+			if (pmu->is_core) {
+				type = pmu->type;
+				break;
+			}
+		}
+		attr.config |= type << PERF_PMU_TYPE_SHIFT;
 	}
 
 	event_attr_init(&attr);
-- 
2.41.0.rc0.172.g3f132b7071-goog

