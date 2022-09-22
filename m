Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01EB55E583C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 03:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbiIVBrY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 21:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbiIVBrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 21:47:22 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87218A223A;
        Wed, 21 Sep 2022 18:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663811241; x=1695347241;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FKN2yI+UVtsu9XnfpWVcIsFtljXOPyPIl7CfiOHtP8U=;
  b=kRMPpLMcErnyBhQ8VMABB/dmLVZoqZUy9T2khTivd+ifcy5WTRsgHh6+
   wOhgmUCZXqouIrz8Z4u0hMNHBBNitPhgrW9uI1Yn++V8uMCtD9EJ7LGiG
   L5O4ZrTf7a3ZywsEab5JjcZM4aODSImGsSPnLlBE0YECmMWekhdWwPfzP
   eGOTvJmZIxazCC48edeIWyRNbmXRxR9IrzF03qoVKKu90IZLuQmZs36PL
   zZBaMkp1K+NjhF0nfFaR81WO1CPTLjgsmGY7RmnPngEBwpfrEydE1vpF9
   vBLQyPGKq0wKCT19cC3cTI/sTeKwBmG+b+75nx9ZerBBYufQ8qSR3u3KQ
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10477"; a="297771668"
X-IronPort-AV: E=Sophos;i="5.93,335,1654585200"; 
   d="scan'208";a="297771668"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2022 18:47:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,335,1654585200"; 
   d="scan'208";a="615029088"
Received: from zxingrtx.sh.intel.com ([10.239.159.110])
  by orsmga007.jf.intel.com with ESMTP; 21 Sep 2022 18:47:18 -0700
From:   zhengjun.xing@linux.intel.com
To:     acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@intel.com, jolsa@kernel.org, namhyung@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        irogers@google.com, ak@linux.intel.com, kan.liang@linux.intel.com,
        zhengjun.xing@linux.intel.com
Subject: [PATCH 1/2] perf print-events: Fix "perf list" can not display the PMU prefix for some hybrid cache events
Date:   Thu, 22 Sep 2022 09:49:03 +0800
Message-Id: <20220922014904.3665674-1-zhengjun.xing@linux.intel.com>
X-Mailer: git-send-email 2.25.1
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

Some hybrid hardware cache events are only available on one CPU PMU. For
example, 'L1-dcache-load-misses' is only available on cpu_core. We have
supported in the perf list clearly reporting this info, the function works
fine before but recently the argument "config" in API is_event_supported()
is changed from "u64" to "unsigned int" which caused a regression, the
"perf list" then can not display the PMU prefix for some hybrid cache
events. For the hybrid systems, the PMU type ID is stored at config[63:32],
define config to "unsigned int" will miss the PMU type ID information, then
the regression happened, the config should be defined as "u64".

Before:
 # ./perf list |grep "Hardware cache event"
  L1-dcache-load-misses                              [Hardware cache event]
  L1-dcache-loads                                    [Hardware cache event]
  L1-dcache-stores                                   [Hardware cache event]
  L1-icache-load-misses                              [Hardware cache event]
  L1-icache-loads                                    [Hardware cache event]
  LLC-load-misses                                    [Hardware cache event]
  LLC-loads                                          [Hardware cache event]
  LLC-store-misses                                   [Hardware cache event]
  LLC-stores                                         [Hardware cache event]
  branch-load-misses                                 [Hardware cache event]
  branch-loads                                       [Hardware cache event]
  dTLB-load-misses                                   [Hardware cache event]
  dTLB-loads                                         [Hardware cache event]
  dTLB-store-misses                                  [Hardware cache event]
  dTLB-stores                                        [Hardware cache event]
  iTLB-load-misses                                   [Hardware cache event]
  node-load-misses                                   [Hardware cache event]
  node-loads                                         [Hardware cache event]

After:
 # ./perf list |grep "Hardware cache event"
  L1-dcache-loads                                    [Hardware cache event]
  L1-dcache-stores                                   [Hardware cache event]
  L1-icache-load-misses                              [Hardware cache event]
  LLC-load-misses                                    [Hardware cache event]
  LLC-loads                                          [Hardware cache event]
  LLC-store-misses                                   [Hardware cache event]
  LLC-stores                                         [Hardware cache event]
  branch-load-misses                                 [Hardware cache event]
  branch-loads                                       [Hardware cache event]
  cpu_atom/L1-icache-loads/                          [Hardware cache event]
  cpu_core/L1-dcache-load-misses/                    [Hardware cache event]
  cpu_core/node-load-misses/                         [Hardware cache event]
  cpu_core/node-loads/                               [Hardware cache event]
  dTLB-load-misses                                   [Hardware cache event]
  dTLB-loads                                         [Hardware cache event]
  dTLB-store-misses                                  [Hardware cache event]
  dTLB-stores                                        [Hardware cache event]
  iTLB-load-misses                                   [Hardware cache event]

Fixes: 9b7c7728f4e4 ("perf parse-events: Break out tracepoint and printing")
Signed-off-by: Zhengjun Xing <zhengjun.xing@linux.intel.com>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/util/print-events.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/print-events.c b/tools/perf/util/print-events.c
index ba1ab5134685..04050d4f6db8 100644
--- a/tools/perf/util/print-events.c
+++ b/tools/perf/util/print-events.c
@@ -239,7 +239,7 @@ void print_sdt_events(const char *subsys_glob, const char *event_glob,
 	strlist__delete(sdtlist);
 }
 
-static bool is_event_supported(u8 type, unsigned int config)
+static bool is_event_supported(u8 type, u64 config)
 {
 	bool ret = true;
 	int open_return;
-- 
2.25.1

