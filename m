Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E5F470B549
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 08:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232003AbjEVGqe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 02:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232046AbjEVGpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 02:45:45 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBB9A1713
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 23:44:34 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-ba81b37d9d2so10504067276.3
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 23:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684737853; x=1687329853;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5Al8n0k/MOmhCKwKIt85nYWIEUmpLppr72awr1+CGgU=;
        b=NRSPMRCMMk4yCl9aATyLE1j4w6QMTrj7QYrgxgNA1AZspvYnM4uk+l8p+A1ULzuYB2
         HqylL1p7j5YLFtQXWNlBuOutD312NCh6++Bj2d3p+9WxVsv27krAdNjcZufcLFuXEXps
         3+vrJQx2orTZ34VVMM29lJgjLmc3Nm/NDYqLX7jD2bCXrlpgDtZiv0xltqKIXn99jTBj
         gwAJv3R61atvs+wnZqNw6Jg5r80lTa+v8JbYz4+twz5/I9M5hedFEXkQkXmgVsun0Ay5
         h5qe+GYpNcqjOXaoEABzcl/WLHsjLUj2A0sJXMMEbpvN9dMt28vRzgfCchzMX4S95mum
         0wYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684737853; x=1687329853;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5Al8n0k/MOmhCKwKIt85nYWIEUmpLppr72awr1+CGgU=;
        b=GUuhMK97D2kNvQYJjn2Avsd/fGkRyFh9+cn0ma8A4KNHRpEg25k38sD2bDkRNyF0ZC
         U/gjhBWYLytgl4tKEWQL4IUpDglilZFX90AnaL7DH5nlj7YS6myiZHV9OaPUkZ2n4be+
         Yak1BJDyHEDA0tMtYswgr44T63IvLPVi+NHhRq8lq3Yq5sQ5vZczuN0/pBrIwGJhRiFZ
         4nAOuzktBuuNDwOCO+76znrWw470uPQpHKSrcYsuHZapjPNlutkOF57JJFGt/54L5nfL
         6hvplsy0HpNn5sCMNFddDf+wGbm3gRdBYZbgFAgPg0G7PHER0h0Hv4H0+zJlPSFd7EXS
         7ktw==
X-Gm-Message-State: AC+VfDzYoc+Dc6qG1oN7EV3hygy7X6vqlbQL0eWc6xSsbGhKDaxI5qh1
        YH6OvNNQ6hwaiK5hQ6XWxXyU4Crf2rqP
X-Google-Smtp-Source: ACHHUZ4MopxFK8PkMA8bZw6C/M/45VQoWf5f7qTtr02GP4SbysvIfkITf+LZ6X0zk9St8CWzVHVaiI+Ssqjq
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:48d9:8c21:e099:7301])
 (user=irogers job=sendgmr) by 2002:a25:81cc:0:b0:ba8:6dc0:cacf with SMTP id
 n12-20020a2581cc000000b00ba86dc0cacfmr4107240ybm.12.1684737853151; Sun, 21
 May 2023 23:44:13 -0700 (PDT)
Date:   Sun, 21 May 2023 23:43:23 -0700
In-Reply-To: <20230522064330.189127-1-irogers@google.com>
Message-Id: <20230522064330.189127-17-irogers@google.com>
Mime-Version: 1.0
References: <20230522064330.189127-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
Subject: [PATCH v2 16/23] perf pmu: Remove perf_pmu__hybrid_pmus list
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

Rather than iterate hybrid PMUs, inhererently Intel specific, iterate
all PMUs checking whether they are core. To only get hybrid cores,
first call perf_pmu__has_hybrid.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-record.c        |  1 -
 tools/perf/util/Build              |  1 -
 tools/perf/util/pmu-hybrid.c       | 39 ------------------------------
 tools/perf/util/pmu-hybrid.h       | 29 ----------------------
 tools/perf/util/pmu.c              |  7 ------
 tools/perf/util/pmu.h              |  2 --
 tools/perf/util/print-events.c     |  1 -
 tools/perf/util/python-ext-sources |  1 -
 8 files changed, 81 deletions(-)
 delete mode 100644 tools/perf/util/pmu-hybrid.c
 delete mode 100644 tools/perf/util/pmu-hybrid.h

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index ed7915af7871..aebe103fb734 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -49,7 +49,6 @@
 #include "util/util.h"
 #include "util/pfm.h"
 #include "util/clockid.h"
-#include "util/pmu-hybrid.h"
 #include "util/off_cpu.h"
 #include "util/bpf-filter.h"
 #include "asm/bug.h"
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 21e4cdcba504..0d68be51a739 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -73,7 +73,6 @@ perf-y += pmu.o
 perf-y += pmus.o
 perf-y += pmu-flex.o
 perf-y += pmu-bison.o
-perf-y += pmu-hybrid.o
 perf-y += svghelper.o
 perf-$(CONFIG_LIBTRACEEVENT) += trace-event-info.o
 perf-y += trace-event-scripting.o
diff --git a/tools/perf/util/pmu-hybrid.c b/tools/perf/util/pmu-hybrid.c
deleted file mode 100644
index 7fe943dd3217..000000000000
--- a/tools/perf/util/pmu-hybrid.c
+++ /dev/null
@@ -1,39 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <linux/list.h>
-#include <linux/compiler.h>
-#include <linux/string.h>
-#include <linux/zalloc.h>
-#include <sys/types.h>
-#include <errno.h>
-#include <fcntl.h>
-#include <sys/stat.h>
-#include <unistd.h>
-#include <stdio.h>
-#include <stdbool.h>
-#include <stdarg.h>
-#include <locale.h>
-#include <api/fs/fs.h>
-#include "fncache.h"
-#include "pmu-hybrid.h"
-
-LIST_HEAD(perf_pmu__hybrid_pmus);
-
-static struct perf_pmu *perf_pmu__find_hybrid_pmu(const char *name)
-{
-	struct perf_pmu *pmu;
-
-	if (!name)
-		return NULL;
-
-	perf_pmu__for_each_hybrid_pmu(pmu) {
-		if (!strcmp(name, pmu->name))
-			return pmu;
-	}
-
-	return NULL;
-}
-
-bool perf_pmu__is_hybrid(const char *name)
-{
-	return perf_pmu__find_hybrid_pmu(name) != NULL;
-}
diff --git a/tools/perf/util/pmu-hybrid.h b/tools/perf/util/pmu-hybrid.h
deleted file mode 100644
index 8dbcae935020..000000000000
--- a/tools/perf/util/pmu-hybrid.h
+++ /dev/null
@@ -1,29 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __PMU_HYBRID_H
-#define __PMU_HYBRID_H
-
-#include <linux/perf_event.h>
-#include <linux/compiler.h>
-#include <linux/list.h>
-#include <stdbool.h>
-#include "pmu.h"
-
-extern struct list_head perf_pmu__hybrid_pmus;
-
-#define perf_pmu__for_each_hybrid_pmu(pmu)	\
-	list_for_each_entry(pmu, &perf_pmu__hybrid_pmus, hybrid_list)
-
-bool perf_pmu__is_hybrid(const char *name);
-
-static inline int perf_pmu__hybrid_pmu_num(void)
-{
-	struct perf_pmu *pmu;
-	int num = 0;
-
-	perf_pmu__for_each_hybrid_pmu(pmu)
-		num++;
-
-	return num;
-}
-
-#endif /* __PMU_HYBRID_H */
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index acbf504c895a..bcf9d78a0003 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -32,7 +32,6 @@
 #include "string2.h"
 #include "strbuf.h"
 #include "fncache.h"
-#include "pmu-hybrid.h"
 #include "util/evsel_config.h"
 
 struct perf_pmu perf_pmu__fake;
@@ -967,11 +966,6 @@ static struct perf_pmu *pmu_lookup(int dirfd, const char *lookup_name)
 	list_splice(&aliases, &pmu->aliases);
 	list_add_tail(&pmu->list, &pmus);
 
-	if (!strcmp(name, "cpu_core") || !strcmp(name, "cpu_atom"))
-		list_add_tail(&pmu->hybrid_list, &perf_pmu__hybrid_pmus);
-	else
-		INIT_LIST_HEAD(&pmu->hybrid_list);
-
 	pmu->default_config = perf_pmu__get_default_config(pmu);
 
 	return pmu;
@@ -2144,7 +2138,6 @@ void perf_pmu__destroy(void)
 
 	list_for_each_entry_safe(pmu, tmp, &pmus, list) {
 		list_del(&pmu->list);
-		list_del(&pmu->hybrid_list);
 
 		perf_pmu__delete(pmu);
 	}
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 5f5de7c20ab6..cb51ad6e40fa 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -119,8 +119,6 @@ struct perf_pmu {
 	struct list_head caps;
 	/** @list: Element on pmus list in pmu.c. */
 	struct list_head list;
-	/** @hybrid_list: Element on perf_pmu__hybrid_pmus. */
-	struct list_head hybrid_list;
 
 	/**
 	 * @missing_features: Features to inhibit when events on this PMU are
diff --git a/tools/perf/util/print-events.c b/tools/perf/util/print-events.c
index 69492cbd6921..8d823bc906e6 100644
--- a/tools/perf/util/print-events.c
+++ b/tools/perf/util/print-events.c
@@ -26,7 +26,6 @@
 #include "strlist.h"
 #include "tracepoint.h"
 #include "pfm.h"
-#include "pmu-hybrid.h"
 #include "thread_map.h"
 
 #define MAX_NAME_LEN 100
diff --git a/tools/perf/util/python-ext-sources b/tools/perf/util/python-ext-sources
index aa5156c2bcff..d4c9b4cd35ef 100644
--- a/tools/perf/util/python-ext-sources
+++ b/tools/perf/util/python-ext-sources
@@ -39,5 +39,4 @@ util/affinity.c
 util/rwsem.c
 util/hashmap.c
 util/perf_regs.c
-util/pmu-hybrid.c
 util/fncache.c
-- 
2.40.1.698.g37aff9b760-goog

