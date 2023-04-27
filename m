Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90DEE6F0BF5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 20:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244522AbjD0Sbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 14:31:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244039AbjD0Sbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 14:31:50 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C572A40F2;
        Thu, 27 Apr 2023 11:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682620308; x=1714156308;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gt14tsep8YaumMAQAuCJ/wwA0Gu1TPM7Y2+3L5l7Fok=;
  b=eC1MYMdBqfWed3vPDA8B3WH5V870rAT1RKRgJLcDnFnqkgrl/prMlyDV
   C+qhFLSwYGtq1FTq5iQoaqKqHo1RvrVBRSPErYBelqhPFBj2HQc02i5lE
   qxIravXNGC6/oHx+Gevkk6knMQUOp8/5JcBAMnXxsaUe1I9yc8V7a1AAn
   EJvQmZmhAwlbUTnxJG41Jk79kebZZ9yrIbIbH6n6Y1/kjfKy2fl6UrKAq
   wsBAe+WSF/yaIMjMJ1v4Mh9uEUv3oAML2RlRnAMYC1aOp8IGmL3lzk9+x
   f1fP+SZNR4GlcQCfBVTgMsuxw1Ra8LIP1YIiRgF9cIAXRAh+pskAjY2el
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="336521627"
X-IronPort-AV: E=Sophos;i="5.99,232,1677571200"; 
   d="scan'208";a="336521627"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2023 11:29:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="806053169"
X-IronPort-AV: E=Sophos;i="5.99,232,1677571200"; 
   d="scan'208";a="806053169"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmsmga002.fm.intel.com with ESMTP; 27 Apr 2023 11:29:24 -0700
From:   kan.liang@linux.intel.com
To:     acme@kernel.org, irogers@google.com
Cc:     peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, adrian.hunter@intel.com, eranian@google.com,
        ahmad.yasin@intel.com, ak@linux.intel.com, perry.taylor@intel.com,
        samantha.alt@intel.com, caleb.biggers@intel.com,
        weilin.wang@intel.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH] perf stat: Add arch-specific TopdownL1 check for the default mode
Date:   Thu, 27 Apr 2023 11:29:06 -0700
Message-Id: <20230427182906.3411695-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The default of perf stat fails on several Intel platforms.
Skylake:

$ perf stat true
Error:
Access to performance monitoring and observability operations is limited.
Consider adjusting /proc/sys/kernel/perf_event_paranoid setting to open
access to performance monitoring and observability operations for processes
without CAP_PERFMON, CAP_SYS_PTRACE or CAP_SYS_ADMIN Linux capability.
More information can be found at 'Perf events and tool security' document:
https://www.kernel.org/doc/html/latest/admin-guide/perf-security.html
perf_event_paranoid setting is 2:
  -1: Allow use of (almost) all events by all users
      Ignore mlock limit after perf_event_mlock_kb without CAP_IPC_LOCK
> = 0: Disallow raw and ftrace function tracepoint access
> = 1: Disallow CPU event access
> = 2: Disallow kernel profiling

ADL (hybrid):

./perf stat
Segmentation fault (core dumped)

The default of perf stat was switched to TopdownL1 Json metric since
commit 94b1a603fca7("perf stat: Add TopdownL1 metric as a default if
present"). But the patch only checks whether the TopdownL1 is present
in the event list. It doesn't check whether the hardware has the
capability to provide a clean output for the default mode.

Add arch_has_topdown_metric() to check the hardware capability as well.
Drop the TopdownL1 support in the defalut mode for pre-ICL and hybrid
platforms. Users can still use -M TopdownL1 to access the TopdownL1
on pre-ICL platforms.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---

The patch tries to workaround the serious issues on pre-ICL and hybrid
platforms with the default mode of perf stat. It could be a temporary
fix for the upcoming 6.4. So we have more time to look for a proper fix
for all metrics issues and output issues with 6.5.

Thanks,
Kan

 tools/perf/arch/x86/util/topdown.c | 14 ++++++++++++++
 tools/perf/builtin-stat.c          |  2 +-
 tools/perf/util/stat-display.c     |  2 +-
 tools/perf/util/topdown.c          |  6 ++++++
 tools/perf/util/topdown.h          |  2 ++
 5 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/tools/perf/arch/x86/util/topdown.c b/tools/perf/arch/x86/util/topdown.c
index 9ad5e5c7bd27..5d861e851619 100644
--- a/tools/perf/arch/x86/util/topdown.c
+++ b/tools/perf/arch/x86/util/topdown.c
@@ -3,6 +3,7 @@
 #include "util/evsel.h"
 #include "util/pmu.h"
 #include "util/topdown.h"
+#include "util/metricgroup.h"
 #include "topdown.h"
 #include "evsel.h"
 
@@ -48,3 +49,16 @@ bool arch_topdown_sample_read(struct evsel *leader)
 
 	return false;
 }
+
+bool arch_has_topdown_metric(const char *name)
+{
+	/*
+	 * Disable the Topdown events in the default mode
+	 * for hybrid platforms and old platform which
+	 * doesn't support the Topdown metric feature.
+	 */
+	if (!pmu_have_event("cpu", "slots"))
+		return false;
+
+	return metricgroup__has_metric(name);
+}
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index efda63f6bf32..0b865155656d 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1885,7 +1885,7 @@ static int add_default_attributes(void)
 		 * Add TopdownL1 metrics if they exist. To minimize
 		 * multiplexing, don't request threshold computation.
 		 */
-		if (metricgroup__has_metric("TopdownL1") &&
+		if (arch_has_topdown_metric("TopdownL1") &&
 		    metricgroup__parse_groups(evsel_list, "TopdownL1",
 					    /*metric_no_group=*/false,
 					    /*metric_no_merge=*/false,
diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index e6035ecbeee8..73b2ff2ddf29 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -747,7 +747,7 @@ static void uniquify_event_name(struct evsel *counter)
 	int ret = 0;
 
 	if (counter->uniquified_name || counter->use_config_name ||
-	    !counter->pmu_name || !strncmp(counter->name, counter->pmu_name,
+	    !counter->pmu_name || !strncmp(evsel__name(counter), counter->pmu_name,
 					   strlen(counter->pmu_name)))
 		return;
 
diff --git a/tools/perf/util/topdown.c b/tools/perf/util/topdown.c
index 18fd5fed5d1a..f3a9ebc52f8b 100644
--- a/tools/perf/util/topdown.c
+++ b/tools/perf/util/topdown.c
@@ -1,8 +1,14 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "topdown.h"
+#include "metricgroup.h"
 #include <linux/kernel.h>
 
 __weak bool arch_topdown_sample_read(struct evsel *leader __maybe_unused)
 {
 	return false;
 }
+
+__weak bool arch_has_topdown_metric(const char *name)
+{
+	return metricgroup__has_metric(name);
+}
diff --git a/tools/perf/util/topdown.h b/tools/perf/util/topdown.h
index 1996c5fedcd7..7e83c8b247f2 100644
--- a/tools/perf/util/topdown.h
+++ b/tools/perf/util/topdown.h
@@ -8,4 +8,6 @@ struct evsel;
 
 bool arch_topdown_sample_read(struct evsel *leader);
 
+bool arch_has_topdown_metric(const char *name);
+
 #endif
-- 
2.35.1

