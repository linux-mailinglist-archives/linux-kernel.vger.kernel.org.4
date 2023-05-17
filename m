Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26BDD706BE8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 16:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232245AbjEQO7G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 10:59:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231975AbjEQO6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 10:58:48 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50425110
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 07:58:45 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-ba712bb7b28so12473667276.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 07:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684335524; x=1686927524;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=teh0Pm56RFznH4cxkDKohWyHgUByyEY0rmKe5R5AKbA=;
        b=wWB8dU0B/1m8OAWhyWPhbMoCb17J0pVHH/Nn8OOvAlhtzMj3PFhsQv28cHl2/LKmNd
         OoSbnLQo9Xf2ARgZc4vVBjIyoWOoNa9Tf0g7QdD6stBADHbAD5QzTmRJN1IIoml0rSra
         qMzZd16fsFwGpKJB7AuKGZPB/gwTY6H0yRwhXamE/WM4jKlXjykrkBAuhxe1Xgt3BYDJ
         A5ICdu5Aqdx3OV8ioh21rHffUc7AL7tZlQf/bkTwIwlnpRR8iVXX07CQUkCdqWEzJ0Z2
         A57SJD4hFnmRcw+Dj4IAtnOg8vbOCOuJ1n40PV/YySW/8QgyuELnt30DU08bzW5dw46V
         AiCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684335524; x=1686927524;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=teh0Pm56RFznH4cxkDKohWyHgUByyEY0rmKe5R5AKbA=;
        b=CJuhv+q0fcukit9E6eoENcjv0WaYltqdjerpfuyqamo/B86ihhgttSrmdV5F2Gkc2i
         Hci72OrbzFmEJ3jso3fwveaYQcuOw49etTn0hXsotBtHKSHHnvwaagMkcToG9ee/sNOa
         BwlF/e5v66E8kyZF6xYdGNdVGiRXgFBERU3VoxEQ+XO5atRrdFGAKVszvTl4yO67xvuy
         kGfT6uI0cnKxOuQUb9irgPhLJ9pZOTi4JgK+cxwB5JiCpye8FeVKk/YsjCyRzuJYSNb1
         uz68j1CbduCJLfab59H7vTpIZI3Jd2+vcAGDa3bVL7yt7yJ6r8rmjxLMf8MIxlF1vOky
         F8mw==
X-Gm-Message-State: AC+VfDyouEt85pGqRNMyqg2Y6dyA4ATPIWCdqK5TGeCV1SnNpmrBlMHd
        SbRzUxth+s2rXXHGtGtTvyd/D4594zGr
X-Google-Smtp-Source: ACHHUZ6aWp5bxbOg1yJ6tAm7uZDYxctfA/HJomA7YEauHsizgUYJzlmvyLfg+V0tXVLIvDwNb5sUOFMeJ+NI
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:628b:7e78:d09b:39b])
 (user=irogers job=sendgmr) by 2002:a25:b10e:0:b0:b8f:5474:2f33 with SMTP id
 g14-20020a25b10e000000b00b8f54742f33mr1624564ybj.5.1684335524558; Wed, 17 May
 2023 07:58:44 -0700 (PDT)
Date:   Wed, 17 May 2023 07:57:44 -0700
In-Reply-To: <20230517145803.559429-1-irogers@google.com>
Message-Id: <20230517145803.559429-5-irogers@google.com>
Mime-Version: 1.0
References: <20230517145803.559429-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
Subject: [PATCH v1 04/23] perf evlist: Reduce scope of evlist__has_hybrid
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
index 85f2bd035a94..42135be760ab 100644
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
index b8ca99afdfe5..cb996d94bd64 100644
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
2.40.1.606.ga4b1b128d6-goog

