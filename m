Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A1A95E723B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 04:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbiIWC6w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 22:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231976AbiIWC6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 22:58:47 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E437211ADDC;
        Thu, 22 Sep 2022 19:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663901926; x=1695437926;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=BaeN9IU6iKvNyY87T+Z0N60aCCF64/bhkIpX8BUMOm0=;
  b=NlQQ9UzBcdUk4sgkVLZ3tQ2AqcNaybOdINvxG3HFFOALd3EYnbYklYAS
   5QByB4BB279L8khJxeQq4f7Y5n0agKsDQEPZb7rr8TcEL7aRD1pEw2VM2
   4c93hIPubu3T8h8UkekaFPrXlXPvSjrpkOfRT2FjBrCKBaAsjHKQY9ZZd
   WW5XPTnMIJDcNYbtHLdauGPXiY4BZhII05t46OQzuhI3KNIr5vS04Q0ol
   bQK1ThszyqdGgO5rS9YL5iITT/JZuU8MTAF6UU5lV/UezXN8kYcNSeGkX
   sHktDGsygk9UfIx4ES2AEGkp5Tyi8wIL0AEpUnRs5xRohw4oW5LjhKxH5
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10478"; a="298093714"
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="298093714"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 19:58:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="615464328"
Received: from zxingrtx.sh.intel.com ([10.239.159.110])
  by orsmga007.jf.intel.com with ESMTP; 22 Sep 2022 19:58:35 -0700
From:   zhengjun.xing@linux.intel.com
To:     acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@intel.com, jolsa@kernel.org, namhyung@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        irogers@google.com, ak@linux.intel.com, kan.liang@linux.intel.com,
        zhengjun.xing@linux.intel.com, Yi Ammy <ammy.yi@intel.com>
Subject: [PATCH v2 1/2] perf print-events: Fix "perf list" can not display the PMU prefix for some hybrid cache events
Date:   Fri, 23 Sep 2022 11:00:12 +0800
Message-Id: <20220923030013.3726410-1-zhengjun.xing@linux.intel.com>
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
Acked-by: Ian Rogers <irogers@google.com>
Reported-by: Yi Ammy <ammy.yi@intel.com>
---
Change log:
  v2:
    * Adds Acked-by from Ian Rogers <irogers@google.com>
    * Adds Reported-by from Yi Ammy <ammy.yi@intel.com>

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

