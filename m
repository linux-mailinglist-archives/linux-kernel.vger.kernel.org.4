Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFD1D70B53D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 08:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231825AbjEVGoD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 02:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231808AbjEVGnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 02:43:50 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B12CFA
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 23:43:44 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-561e68fe434so69893317b3.1
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 23:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684737823; x=1687329823;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kNgNWBNSvhI2LdRPQMDKfimHjU6ZbLIi1N3gayQ3XwM=;
        b=fLfeMNWhWGjBnz8I2kF02sEXnlbyKMewm4HvVki+LT09eA/ZO6QerDU4WcLWmJx5/5
         8pafXQAyqHA10+IbZAI11bcyGeUriZtsy7bfEFkSrB62lDrOvPPAUMeG6kEapKrEdRcc
         Op3chXdMIOONy9MvG6ESbDbhZuZvAI1f8NRWD8iqNV19qDkKHwjxCP8QyBsp3Ijq8/Qk
         yX+nxttzJ/Bdag/Dw+le8WAEs7d1xGeHFgejRD19trWwgIGfApdiZZLN9+8YqJGHSJjv
         gC4zwEiz55pG+XeRq5NSTFZT27tYXO8IwfVNpGPmHnxdKzS3lkLXK8WWoLsOyLySL5qe
         mxqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684737823; x=1687329823;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kNgNWBNSvhI2LdRPQMDKfimHjU6ZbLIi1N3gayQ3XwM=;
        b=GZ/DgMX16LC2bw8lz+m7Qim/A6CxByzzyfUPLmQkpYAyBBqieaCh4FbhpRJnV7ZKxF
         meQA0301aK87UMFhaJW52DZDJYP/Wiz242Hyt9COy+JjzbTKOve9fhFPLgl0bCU2Ohnv
         0JS9sJHlu1ajBizi85HVuzgSdWxJI2UiUBvVGUKrNg1Av/W0s8gUL/8y7ripA66v2XT9
         aiSCuzfYA5MlMxkM0esBeYlZroKUp8PqcMQGjDWXAj9p8FO3QStpnhDhM5l23fQIsqB6
         A7vrpVXmURt/r69o8kZOQZssOTWlLf3nJ8e4/w9SpNBtJsBAqUu8HWQX91EXYceFJeCU
         es0w==
X-Gm-Message-State: AC+VfDy+9fDokTU+wqyuSo4UjDd4Uov3bMNgxx1uzTBLnKuMpBY/Vga3
        UCW0psRyZR9e6/pENRtYhsVvwZAr1JK4
X-Google-Smtp-Source: ACHHUZ65ZxYkd4VjzV2wILE/JAKZwhUl0VdjsxL84Uua3GHluPKtGiZsSXQcDjfNUuh5Hu0e7v6ymNYhu3rX
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:48d9:8c21:e099:7301])
 (user=irogers job=sendgmr) by 2002:a05:690c:2e85:b0:55a:6bb1:c91 with SMTP id
 eu5-20020a05690c2e8500b0055a6bb10c91mr5596191ywb.3.1684737823768; Sun, 21 May
 2023 23:43:43 -0700 (PDT)
Date:   Sun, 21 May 2023 23:43:11 -0700
In-Reply-To: <20230522064330.189127-1-irogers@google.com>
Message-Id: <20230522064330.189127-5-irogers@google.com>
Mime-Version: 1.0
References: <20230522064330.189127-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
Subject: [PATCH v2 04/23] perf evlist: Reduce scope of evlist__has_hybrid
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

Function is only used in printout, reduce scope to
stat-display.c. Remove the now empty evlist-hybrid.c and
evlist-hybrid.h.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-record.c     |  1 -
 tools/perf/builtin-stat.c       |  1 -
 tools/perf/util/Build           |  1 -
 tools/perf/util/evlist-hybrid.c | 31 -------------------------------
 tools/perf/util/evlist-hybrid.h | 12 ------------
 tools/perf/util/evlist.c        |  1 -
 tools/perf/util/stat-display.c  | 15 ++++++++++++++-
 7 files changed, 14 insertions(+), 48 deletions(-)
 delete mode 100644 tools/perf/util/evlist-hybrid.c
 delete mode 100644 tools/perf/util/evlist-hybrid.h

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index a107a7adbcf4..ed7915af7871 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -50,7 +50,6 @@
 #include "util/pfm.h"
 #include "util/clockid.h"
 #include "util/pmu-hybrid.h"
-#include "util/evlist-hybrid.h"
 #include "util/off_cpu.h"
 #include "util/bpf-filter.h"
 #include "asm/bug.h"
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 084cc570b8e8..bd51da5fd3a5 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -48,7 +48,6 @@
 #include "util/pmu.h"
 #include "util/event.h"
 #include "util/evlist.h"
-#include "util/evlist-hybrid.h"
 #include "util/evsel.h"
 #include "util/debug.h"
 #include "util/color.h"
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index c146736ead19..21e4cdcba504 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -11,7 +11,6 @@ perf-y += db-export.o
 perf-y += env.o
 perf-y += event.o
 perf-y += evlist.o
-perf-y += evlist-hybrid.o
 perf-y += sideband_evlist.o
 perf-y += evsel.o
 perf-y += evsel_fprintf.o
diff --git a/tools/perf/util/evlist-hybrid.c b/tools/perf/util/evlist-hybrid.c
deleted file mode 100644
index 64f78d06fe19..000000000000
--- a/tools/perf/util/evlist-hybrid.c
+++ /dev/null
@@ -1,31 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-#include <errno.h>
-#include <inttypes.h>
-#include "cpumap.h"
-#include "evlist.h"
-#include "evsel.h"
-#include "../perf.h"
-#include "util/pmu-hybrid.h"
-#include "util/evlist-hybrid.h"
-#include "debug.h"
-#include <unistd.h>
-#include <stdlib.h>
-#include <linux/err.h>
-#include <linux/string.h>
-#include <perf/evlist.h>
-#include <perf/evsel.h>
-#include <perf/cpumap.h>
-
-bool evlist__has_hybrid(struct evlist *evlist)
-{
-	struct evsel *evsel;
-
-	evlist__for_each_entry(evlist, evsel) {
-		if (evsel->pmu_name &&
-		    perf_pmu__is_hybrid(evsel->pmu_name)) {
-			return true;
-		}
-	}
-
-	return false;
-}
diff --git a/tools/perf/util/evlist-hybrid.h b/tools/perf/util/evlist-hybrid.h
deleted file mode 100644
index 0cded76eb344..000000000000
--- a/tools/perf/util/evlist-hybrid.h
+++ /dev/null
@@ -1,12 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __PERF_EVLIST_HYBRID_H
-#define __PERF_EVLIST_HYBRID_H
-
-#include <linux/compiler.h>
-#include <linux/kernel.h>
-#include "evlist.h"
-#include <unistd.h>
-
-bool evlist__has_hybrid(struct evlist *evlist);
-
-#endif /* __PERF_EVLIST_HYBRID_H */
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index ae05761b3dc9..f301484ea9a6 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -28,7 +28,6 @@
 #include "util/string2.h"
 #include "util/perf_api_probe.h"
 #include "util/evsel_fprintf.h"
-#include "util/evlist-hybrid.h"
 #include "util/pmu.h"
 #include "util/sample.h"
 #include "util/bpf-filter.h"
diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index bf5a6c14dfcd..ede0477d958a 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -20,7 +20,6 @@
 #include "util.h"
 #include "iostat.h"
 #include "pmu-hybrid.h"
-#include "evlist-hybrid.h"
 
 #define CNTR_NOT_SUPPORTED	"<not supported>"
 #define CNTR_NOT_COUNTED	"<not counted>"
@@ -677,6 +676,20 @@ static bool is_mixed_hw_group(struct evsel *counter)
 	return false;
 }
 
+static bool evlist__has_hybrid(struct evlist *evlist)
+{
+	struct evsel *evsel;
+
+	evlist__for_each_entry(evlist, evsel) {
+		if (evsel->pmu_name &&
+		    perf_pmu__is_hybrid(evsel->pmu_name)) {
+			return true;
+		}
+	}
+
+	return false;
+}
+
 static void printout(struct perf_stat_config *config, struct outstate *os,
 		     double uval, u64 run, u64 ena, double noise, int aggr_idx)
 {
-- 
2.40.1.698.g37aff9b760-goog

