Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA89731A89
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 15:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344635AbjFONyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 09:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241356AbjFONyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 09:54:40 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7388E1FC3;
        Thu, 15 Jun 2023 06:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686837279; x=1718373279;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pzcNb5kzn61KFdcjmKe2H8uk6m6tCd/c1IAgVezvkmo=;
  b=UdgCB5w9RC+9Q8UwPeWd1lWxYWbLN6gFHG0/98Uywji7uQrQ648/Op1s
   SXLL18IJr8q/j3gSy6CPfs8/PpGMJzAunMwUkf/niZb01Zm/ybPewkoal
   fFzeyXn5eVMP998i1//p21Wt3BWImcDeh4p8AGnGyr+AB7+hvmZzBKVVN
   4B+p1ERR4pemFmuZZwCmC+73IwB8OQdOVlOICEcPb37TKBiLUsMod6KGY
   H0wMFAG70Rs5b2ptmO1JzMb5lUfJGJIQdeiVoPHkbUmOqm71Hy7aybWvn
   KlnNxfwxxyiwtnOAnqblW03y8ZwrnMCnUvkX1CHHRO4Di91AeyZLrrt2L
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="356411384"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="356411384"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 06:54:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="782527046"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="782527046"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmsmga004.fm.intel.com with ESMTP; 15 Jun 2023 06:54:36 -0700
From:   kan.liang@linux.intel.com
To:     acme@kernel.org, mingo@redhat.com, peterz@infradead.org,
        irogers@google.com, namhyung@kernel.org, jolsa@kernel.org,
        adrian.hunter@intel.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     ak@linux.intel.com, eranian@google.com, ahmad.yasin@intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V3 1/8] perf evsel: Fix the annotation for hardware events on hybrid
Date:   Thu, 15 Jun 2023 06:53:08 -0700
Message-Id: <20230615135315.3662428-2-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230615135315.3662428-1-kan.liang@linux.intel.com>
References: <20230615135315.3662428-1-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The annotation for hardware events is wrong on hybrid. For example,

 # ./perf stat -a sleep 1

 Performance counter stats for 'system wide':

         32,148.85 msec cpu-clock                        #   32.000 CPUs utilized
               374      context-switches                 #   11.633 /sec
                33      cpu-migrations                   #    1.026 /sec
               295      page-faults                      #    9.176 /sec
        18,979,960      cpu_core/cycles/                 #  590.378 K/sec
       261,230,783      cpu_atom/cycles/                 #    8.126 M/sec                       (54.21%)
        17,019,732      cpu_core/instructions/           #  529.404 K/sec
        38,020,470      cpu_atom/instructions/           #    1.183 M/sec                       (63.36%)
         3,296,743      cpu_core/branches/               #  102.546 K/sec
         6,692,338      cpu_atom/branches/               #  208.167 K/sec                       (63.40%)
            96,421      cpu_core/branch-misses/          #    2.999 K/sec
         1,016,336      cpu_atom/branch-misses/          #   31.613 K/sec                       (63.38%)

The hardware events have extended type on hybrid, but the evsel__match()
doesn't take it into account.

Filter the config on hybrid before checking.

With the patch,

 # ./perf stat -a sleep 1

 Performance counter stats for 'system wide':

         32,139.90 msec cpu-clock                        #   32.003 CPUs utilized
               343      context-switches                 #   10.672 /sec
                32      cpu-migrations                   #    0.996 /sec
                73      page-faults                      #    2.271 /sec
        13,712,841      cpu_core/cycles/                 #    0.000 GHz
       258,301,691      cpu_atom/cycles/                 #    0.008 GHz                         (54.20%)
        12,428,163      cpu_core/instructions/           #    0.91  insn per cycle
        37,786,557      cpu_atom/instructions/           #    2.76  insn per cycle              (63.35%)
         2,418,826      cpu_core/branches/               #   75.259 K/sec
         6,965,962      cpu_atom/branches/               #  216.739 K/sec                       (63.38%)
            72,150      cpu_core/branch-misses/          #    2.98% of all branches
         1,032,746      cpu_atom/branch-misses/          #   42.70% of all branches             (63.35%)

Suggested-by: Ian Rogers <irogers@google.com>
Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/util/evsel.h | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index b365b449c6ea..cc6fb3049b99 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -10,6 +10,7 @@
 #include <internal/evsel.h>
 #include <perf/evsel.h>
 #include "symbol_conf.h"
+#include "pmus.h"
 
 struct bpf_object;
 struct cgroup;
@@ -350,9 +351,19 @@ u64 format_field__intval(struct tep_format_field *field, struct perf_sample *sam
 
 struct tep_format_field *evsel__field(struct evsel *evsel, const char *name);
 
-#define evsel__match(evsel, t, c)		\
-	(evsel->core.attr.type == PERF_TYPE_##t &&	\
-	 evsel->core.attr.config == PERF_COUNT_##c)
+static inline bool __evsel__match(const struct evsel *evsel, u32 type, u64 config)
+{
+	if (evsel->core.attr.type != type)
+		return false;
+
+	if ((type == PERF_TYPE_HARDWARE || type == PERF_TYPE_HW_CACHE)  &&
+	    perf_pmus__supports_extended_type())
+		return (evsel->core.attr.config & PERF_HW_EVENT_MASK) == config;
+
+	return evsel->core.attr.config == config;
+}
+
+#define evsel__match(evsel, t, c) __evsel__match(evsel, PERF_TYPE_##t, PERF_COUNT_##c)
 
 static inline bool evsel__match2(struct evsel *e1, struct evsel *e2)
 {
-- 
2.35.1

