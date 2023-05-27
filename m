Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED3787132FC
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 09:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231986AbjE0HYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 03:24:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231272AbjE0HYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 03:24:15 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 008B010CF
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 00:23:48 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5655d99da53so37959707b3.0
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 00:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685172197; x=1687764197;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v8YbnF9L4ZF9j63CWhkMvTIXHU3Z9l4QqepjKSE7OCA=;
        b=zBACDVp/uVRqo6jlQZN78DTV9f6Vi7SuV0yUUxfi66S7migqKvwiARNhFjYTqiuCcP
         j7peLROa9rTX+D2341498rphj0hTJ0c9FxubbEwZVVazrLzI1P3iNDr3vVj+bktVYHuc
         JSVz5ZD2Hcc4xci/PH085f0BvQR81YdFik5r+hOx4f1iAUfbzxwB+gmOs87X9xwi2n6m
         pEN+ZWXrvvJTZmo6/RKNFogf3xvrp1fZcJSzQq8EnQ68w1mzuoDDAtlfBHgqwT1O0uSy
         56Z5gpii2WBFsyGnCA7fR9mV/Bn3n6kj8UfME6Ty1XDspJhwns6Z+/8fNIK31q+ViMn3
         1SxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685172197; x=1687764197;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v8YbnF9L4ZF9j63CWhkMvTIXHU3Z9l4QqepjKSE7OCA=;
        b=HYBM7VVk6uZzcr65tjspHlGnausbf5OKYitcyzn7TmTZSXye1IhWIPyvn4mrL+Jq5P
         vW5DqXMMmoVZfMaki2UYhucjwoNu5hSDxKgo0KTBInPnPdJDsLbjpYELiAVMrOYqMrOE
         XmuQADQGOVkcVI61ljrtZ4bcbPSioGfk4m8mB78OY1n7pq/GUR6378/b9T1R40oIBGf6
         2ub/DYy3BPutjZCfzyOUs68p3BCOEjahah4fq14McaW3vqKOaeaWLhh56A4k6YRhfh+8
         BUuf1bRgi8FmF56E18NvUvZMYewUqcQa9s1xP93A9v5oX8j0wSa0eJH0v/XiCFw+ta1e
         qXzA==
X-Gm-Message-State: AC+VfDzfRj0ro77XezcUhHLhkbVVh048jpep41VEKHNIXqKxGQgA5W23
        trRRt6+GGrU1gilyNDEydHxYg7wP0mRs
X-Google-Smtp-Source: ACHHUZ56s9RCBStSO9zg3YkfoAdtsibqz1n+C6l1phLn6KkUkry++jh9O/vGcYSc3BOzdmPPjSc9tiMGl1Ek
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:3b4e:312c:644:a642])
 (user=irogers job=sendgmr) by 2002:a81:fe07:0:b0:565:8b2e:b324 with SMTP id
 j7-20020a81fe07000000b005658b2eb324mr923014ywn.3.1685172197762; Sat, 27 May
 2023 00:23:17 -0700 (PDT)
Date:   Sat, 27 May 2023 00:21:55 -0700
In-Reply-To: <20230527072210.2900565-1-irogers@google.com>
Message-Id: <20230527072210.2900565-20-irogers@google.com>
Mime-Version: 1.0
References: <20230527072210.2900565-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Subject: [PATCH v5 19/34] perf evsel: Compute is_hybrid from PMU being core
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

Short-cut when has_hybrid is false, otherwise return if the evsel's
PMU is core. Add a comment for the some what surprising no PMU cases
of hardware and legacy cache events.

Signed-off-by: Ian Rogers <irogers@google.com>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/util/evsel.c  | 12 ++++++++++--
 tools/perf/util/python.c |  5 +++++
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 1df8f967d2eb..1c6e22e3f345 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -46,8 +46,8 @@
 #include "memswap.h"
 #include "util.h"
 #include "util/hashmap.h"
-#include "pmu-hybrid.h"
 #include "off_cpu.h"
+#include "pmu.h"
 #include "../perf-sys.h"
 #include "util/parse-branch-options.h"
 #include "util/bpf-filter.h"
@@ -3132,9 +3132,17 @@ void evsel__zero_per_pkg(struct evsel *evsel)
 	}
 }
 
+/**
+ * evsel__is_hybrid - does the evsel have a known PMU that is hybrid. Note, this
+ *                    will be false on hybrid systems for hardware and legacy
+ *                    cache events.
+ */
 bool evsel__is_hybrid(const struct evsel *evsel)
 {
-	return evsel->pmu_name && perf_pmu__is_hybrid(evsel->pmu_name);
+	if (!perf_pmu__has_hybrid())
+		return false;
+
+	return evsel->core.is_pmu_core;
 }
 
 struct evsel *evsel__leader(const struct evsel *evsel)
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 3c1f4c979c9e..b27b27086422 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -102,6 +102,11 @@ int perf_pmu__scan_file(struct perf_pmu *pmu, const char *name, const char *fmt,
 	return EOF;
 }
 
+bool perf_pmu__has_hybrid(void)
+{
+	return false;
+}
+
 bool evsel__is_aux_event(const struct evsel *evsel __maybe_unused)
 {
 	return false;
-- 
2.41.0.rc0.172.g3f132b7071-goog

