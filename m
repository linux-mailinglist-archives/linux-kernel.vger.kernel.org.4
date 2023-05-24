Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF05A7100CB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 00:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237706AbjEXWVJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 18:21:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236692AbjEXWUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 18:20:33 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8816E69
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 15:19:50 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-babb5e91ab4so2931976276.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 15:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684966772; x=1687558772;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a6taGAsuRUZNNlfmTueUaSzwpbmizvV1tsVG1sacRHQ=;
        b=aLHieteVM59/jfF+zT9UAD6nXuFByztQxXY9T1ueT4vVv0zaJAH7Y2Qq1+voD20jfg
         T3q9lfDpNykjST8+Ubtyh+uAFrzOCAbTMzaUY4dPlU9n5bZsvyIJRsMORWxMM7V+hAfU
         kitwaJ3DkRzG+xljHUznqNjBVdADH+mo/Z1hvCC+xUsy7JOldru37a1IjGyZ5iM5Hxnf
         /IPItkCcX6N/TakUDD6RCpyDQUt8eQ0x5Mn3z4qe84SSn54qgNhNUGGbWmbRQLThVu1H
         RpNA5WP7t8D5eaWjKqojokKHTF3TJudlndfR3FMTag1oUyLpvzLaLuTV/VmHW3ADo83B
         clZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684966772; x=1687558772;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a6taGAsuRUZNNlfmTueUaSzwpbmizvV1tsVG1sacRHQ=;
        b=L2tre87m1CfppOeXLWli7/+2eRyjTMRvyFd2Agh8pY1m9gPWmiW4YTG+byOYburlz7
         KstIyhbruMjF74IYjZKmcN6f4YL+/MDeGBqhMg/fuTKBsWExlahC1Ztv2PQDvpsuhtLO
         HXtUTYV7Swdu3k45AkrGquhVlowSgKN6uKMo780Qep1vQU6gmI2DdVxckoCFu+wfhuKB
         Eg1eBAToikud+WvcZZ4Og+ygYGHUKRHsrX9wzFSjFhYk9WneahMIlSyxpK7GFmIExuBJ
         JxX2vp/sKFQ1LydYyUieZF7Zz+nKYzHkwneJgFxUxYVMM9wnEWNwSqwwJla+R8fGGC+f
         Jvqg==
X-Gm-Message-State: AC+VfDyBL81ldAT2ecZeyDdYgK9KsFhu8muzGKZublUIPYlkGNHeIlXW
        R+6GRUaPfbEEWgvtMGFugZ334liCx9oE
X-Google-Smtp-Source: ACHHUZ7mltbDViAiAbhpjxYBrIhENa03TRP7my9wrpYDBzhEgBy0Y+fK9QOpyt6T7RQ0fSMa5vSPBU/j2e4m
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:7aa7:3d2d:76ae:8e96])
 (user=irogers job=sendgmr) by 2002:a25:c5c4:0:b0:bab:a1e6:c882 with SMTP id
 v187-20020a25c5c4000000b00baba1e6c882mr802148ybe.1.1684966772300; Wed, 24 May
 2023 15:19:32 -0700 (PDT)
Date:   Wed, 24 May 2023 15:18:21 -0700
In-Reply-To: <20230524221831.1741381-1-irogers@google.com>
Message-Id: <20230524221831.1741381-26-irogers@google.com>
Mime-Version: 1.0
References: <20230524221831.1741381-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
Subject: [PATCH v3 25/35] perf pmu: Remove perf_pmu__hybrid_pmus list
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
index e30e8d6a6575..2abcad2998f6 100644
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
index 12446f63d1b3..62cd795e2fd3 100644
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

