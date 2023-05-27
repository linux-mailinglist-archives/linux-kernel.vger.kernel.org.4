Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31CCF7132F4
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 09:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231864AbjE0HYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 03:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbjE0HXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 03:23:55 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E96D513A
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 00:23:26 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1ae437c2b32so9860095ad.2
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 00:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685172185; x=1687764185;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=299vrUdS9j5al0BdA54HhQrig6BBYgEJkkDcFDXNhaw=;
        b=T4oQTZ2/l53kn3micJBSOvZsvIqHsAkIdK393d+boPipITXtZnzIVp7FWD0snX7ONj
         2AcEsSxA0rDLJmLw/+Js0LsIZca+3KCUeaw6Rbfw/IjckG3iJoP9lcBHMoeU+4nAuTMg
         i37T3bWOhoOsz0UWSa4tiKr7aseY3WMMAVhgjiOHs94BiOU+3TgUa8xQ9Ef4Ny8AJFiK
         71w2mrAhZHr4G2kGOO+T3CviWrDxTRWUxSRcEtwLZ+snZc4jPHYzsn7KUlUv/s7Q1hne
         oFyX/TuH1yLDPJwNSQ99S1grNto1PajZHcAoDnInskj1ua2SkR79hM+R0OsiMDcLVnEJ
         SHQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685172185; x=1687764185;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=299vrUdS9j5al0BdA54HhQrig6BBYgEJkkDcFDXNhaw=;
        b=O9zRpriOg5cGAIX4vFtSKKbdXeieUttpbJWHhrZjVrUnXprG3Au3JouTDysrhEFuJx
         Y6gprgN2GfLoKiitc0tJuChq3wt/6ip8krkl2nJKHztgDjY8J8R9rDwUCtpLRjYTbklI
         2DyAysU50eRbJwvLHjO7rTE1veLgzF4V5A/ZGBDUIQQCD9U4xtfdGekcVi5EBdLl0GSO
         DiafB54VWb4+LSD6gSl3JheG9ZL22kySSOuXTL2+1fGuOikWPzlOjRFMWoYNa1esW85l
         JG5To2feei1V/c1gDEfNxfZ18JN+/+K4U4iA1q8whf7oN68udcx6q1oIQRidt7VCmDAM
         R7sA==
X-Gm-Message-State: AC+VfDxbQHiLQWCwqo1teZVB6CGAQrnjJellwLRSxy8l1SqqTnD3RgSd
        JKfOwxEf8A/BPZ5WSCJTtLgPOqELGGyf
X-Google-Smtp-Source: ACHHUZ5dZ6hqt7MX6zOuSA8yLL67KYEBhD1h1jlIyT6OGhgGtW3o8/q40j6Lbw4REK1FshcE0vbFduVhLrkO
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:3b4e:312c:644:a642])
 (user=irogers job=sendgmr) by 2002:a17:902:7608:b0:1ac:921c:87f6 with SMTP id
 k8-20020a170902760800b001ac921c87f6mr1284929pll.8.1685172185596; Sat, 27 May
 2023 00:23:05 -0700 (PDT)
Date:   Sat, 27 May 2023 00:21:50 -0700
In-Reply-To: <20230527072210.2900565-1-irogers@google.com>
Message-Id: <20230527072210.2900565-15-irogers@google.com>
Mime-Version: 1.0
References: <20230527072210.2900565-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Subject: [PATCH v5 14/34] perf evlist: Reduce scope of evlist__has_hybrid
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

Function is only used in printout, reduce scope to
stat-display.c. Remove the now empty evlist-hybrid.c and
evlist-hybrid.h.

Signed-off-by: Ian Rogers <irogers@google.com>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
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
index d80b54a6f450..e30e8d6a6575 100644
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
index d414ee30dcf9..62bbeea93bf3 100644
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
index 63f8821a5395..82c0b3d0c822 100644
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
index 319f456f0673..4cce7d3c5e52 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -20,7 +20,6 @@
 #include "util.h"
 #include "iostat.h"
 #include "pmu-hybrid.h"
-#include "evlist-hybrid.h"
 
 #define CNTR_NOT_SUPPORTED	"<not supported>"
 #define CNTR_NOT_COUNTED	"<not counted>"
@@ -692,6 +691,20 @@ static bool is_mixed_hw_group(struct evsel *counter)
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
2.41.0.rc0.172.g3f132b7071-goog

