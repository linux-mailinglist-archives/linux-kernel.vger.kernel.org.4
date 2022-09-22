Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD3365E583D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 03:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbiIVBrc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 21:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbiIVBr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 21:47:27 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D939AAA35E;
        Wed, 21 Sep 2022 18:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663811245; x=1695347245;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CSBjn97OmBQd8eV1Z5VouDeBJ9rMyVgyf0XkPPuQxZU=;
  b=fFI7xHm156c4Phwn2dO0Xmf7xICHPvwWnIyFXlx7ZcQSet+Av3lYoC/9
   AIHuslTCGpv9Scw6lpcFS0Y6HRia0+/8mx2bqcZmKy82SV4NX9IPtIX7A
   RwEauTWHP8R2XKP9KINhNwwYrf/oSAdfc0eT3RdxP8bUTZWimjAzpVgjI
   qlbpwt0Y/iJko9pPwyyo02oRuJod09HnTB2VPRbzUw7oO3LS8zIV9LzUY
   S9dkPFC94NbTWSvJzb+qtaqNuBgJW+pK4P7XAEgoVt+v23A5lEMx3qrUu
   mCppMY3FZcA/jmdiXVl4wXLQnleUfo+Era5o6PisPNKlTfTunsCWVEqL9
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10477"; a="297771671"
X-IronPort-AV: E=Sophos;i="5.93,335,1654585200"; 
   d="scan'208";a="297771671"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2022 18:47:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,335,1654585200"; 
   d="scan'208";a="615029106"
Received: from zxingrtx.sh.intel.com ([10.239.159.110])
  by orsmga007.jf.intel.com with ESMTP; 21 Sep 2022 18:47:22 -0700
From:   zhengjun.xing@linux.intel.com
To:     acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@intel.com, jolsa@kernel.org, namhyung@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        irogers@google.com, ak@linux.intel.com, kan.liang@linux.intel.com,
        zhengjun.xing@linux.intel.com
Subject: [PATCH 2/2] perf parse-events: Remove "not supported" hybrid cache events
Date:   Thu, 22 Sep 2022 09:49:04 +0800
Message-Id: <20220922014904.3665674-2-zhengjun.xing@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220922014904.3665674-1-zhengjun.xing@linux.intel.com>
References: <20220922014904.3665674-1-zhengjun.xing@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhengjun Xing <zhengjun.xing@linux.intel.com>

By default, we create two hybrid cache events, one is for cpu_core, and
another is for cpu_atom. But Some hybrid hardware cache events are only
available on one CPU PMU. For example, the 'L1-dcache-load-misses' is only
available on cpu_core, while the 'L1-icache-loads' is only available on
cpu_atom. We need to remove "not supported" hybrid cache events. By
extending is_event_supported() to global API and using it to check if the
hybrid cache events are supported before being created, we can remove the
"not supported" hybrid cache events.

Before:

 # ./perf stat -e L1-dcache-load-misses,L1-icache-loads -a sleep 1

 Performance counter stats for 'system wide':

            52,570      cpu_core/L1-dcache-load-misses/
   <not supported>      cpu_atom/L1-dcache-load-misses/
   <not supported>      cpu_core/L1-icache-loads/
         1,471,817      cpu_atom/L1-icache-loads/

       1.004915229 seconds time elapsed

After:

 # ./perf stat -e L1-dcache-load-misses,L1-icache-loads -a sleep 1

 Performance counter stats for 'system wide':

            54,510      cpu_core/L1-dcache-load-misses/
         1,441,286      cpu_atom/L1-icache-loads/

       1.005114281 seconds time elapsed

Fixes: 30def61f64ba ("perf parse-events: Create two hybrid cache events")
Signed-off-by: Zhengjun Xing <zhengjun.xing@linux.intel.com>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/util/parse-events-hybrid.c | 8 +++++++-
 tools/perf/util/print-events.c        | 2 +-
 tools/perf/util/print-events.h        | 3 ++-
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/parse-events-hybrid.c b/tools/perf/util/parse-events-hybrid.c
index 284f8eabd3b9..cf2e1c2e968f 100644
--- a/tools/perf/util/parse-events-hybrid.c
+++ b/tools/perf/util/parse-events-hybrid.c
@@ -14,6 +14,7 @@
 #include "pmu.h"
 #include "pmu-hybrid.h"
 #include "perf.h"
+#include "print-events.h"
 
 static void config_hybrid_attr(struct perf_event_attr *attr,
 			       int type, int pmu_type)
@@ -48,13 +49,18 @@ static int create_event_hybrid(__u32 config_type, int *idx,
 	__u64 config = attr->config;
 
 	config_hybrid_attr(attr, config_type, pmu->type);
+
+	if (attr->type == PERF_TYPE_HW_CACHE
+	    && !is_event_supported(attr->type, attr->config))
+		goto out;
+
 	evsel = parse_events__add_event_hybrid(list, idx, attr, name, metric_id,
 					       pmu, config_terms);
 	if (evsel)
 		evsel->pmu_name = strdup(pmu->name);
 	else
 		return -ENOMEM;
-
+out:
 	attr->type = type;
 	attr->config = config;
 	return 0;
diff --git a/tools/perf/util/print-events.c b/tools/perf/util/print-events.c
index 04050d4f6db8..fa5cc94cfcfe 100644
--- a/tools/perf/util/print-events.c
+++ b/tools/perf/util/print-events.c
@@ -239,7 +239,7 @@ void print_sdt_events(const char *subsys_glob, const char *event_glob,
 	strlist__delete(sdtlist);
 }
 
-static bool is_event_supported(u8 type, u64 config)
+bool is_event_supported(u8 type, u64 config)
 {
 	bool ret = true;
 	int open_return;
diff --git a/tools/perf/util/print-events.h b/tools/perf/util/print-events.h
index 1da9910d83a6..ad2902fd0507 100644
--- a/tools/perf/util/print-events.h
+++ b/tools/perf/util/print-events.h
@@ -1,14 +1,15 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #ifndef __PERF_PRINT_EVENTS_H
 #define __PERF_PRINT_EVENTS_H
-
 #include <stdbool.h>
+#include <linux/types.h>
 
 struct event_symbol;
 
 void print_events(const char *event_glob, bool name_only, bool quiet_flag,
 		  bool long_desc, bool details_flag, bool deprecated,
 		  const char *pmu_name);
+bool is_event_supported(u8 type, u64 config);
 int print_hwcache_events(const char *event_glob, bool name_only);
 void print_sdt_events(const char *subsys_glob, const char *event_glob,
 		      bool name_only);
-- 
2.25.1

