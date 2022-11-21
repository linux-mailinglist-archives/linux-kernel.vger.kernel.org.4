Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9020D631B22
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 09:19:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbiKUITb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 03:19:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbiKUITX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 03:19:23 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 207861F9C0;
        Mon, 21 Nov 2022 00:19:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669018763; x=1700554763;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SALMsWOGV4XtaaAn3zEVXo18HKV62v95+UsvHOqzjyQ=;
  b=dbVZpUF9RHpizZm0xEE+fLBjParEFko+DxM4Xykz/R7OvMPZuRrcuRpV
   sZ8w+UKm2FfS8it9yyOMziBEF338HynP5c/RFBsdIj6of00EsqSWiGA0n
   zlfzRj1G06rSU0m8GuKB49T2NnNN2bExMmX4dwIEL4qP58K3xjvG/N5vd
   00V9UQByR8DNSyXGCm0rt9jVoqVUGXqj7fuPUQU4HkNOM4ZDGshDoVGr5
   OqMACs7/g0GQy+0lYJKTh8aW7Z1wHtULbdF13r++ePlYZW/QQTlPprpLg
   GhnJatMWG9Wk8BUlXerJEZx6sUTed+vfEaiT9tfFI4P/GyDZQ1SyxPyCj
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10537"; a="314649255"
X-IronPort-AV: E=Sophos;i="5.96,180,1665471600"; 
   d="scan'208";a="314649255"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2022 00:19:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10537"; a="704471816"
X-IronPort-AV: E=Sophos;i="5.96,180,1665471600"; 
   d="scan'208";a="704471816"
Received: from zxingrtx.sh.intel.com ([10.239.159.110])
  by fmsmga008.fm.intel.com with ESMTP; 21 Nov 2022 00:19:19 -0800
From:   zhengjun.xing@linux.intel.com
To:     acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@intel.com, jolsa@kernel.org, namhyung@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        irogers@google.com, ak@linux.intel.com, kan.liang@linux.intel.com,
        zhengjun.xing@linux.intel.com
Subject: [PATCH v2 4/5] perf vendor events: Add the cpuid for Alderlake-N
Date:   Mon, 21 Nov 2022 16:20:57 +0800
Message-Id: <20221121082058.64578-4-zhengjun.xing@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221121082058.64578-1-zhengjun.xing@linux.intel.com>
References: <20221121082058.64578-1-zhengjun.xing@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhengjun Xing <zhengjun.xing@linux.intel.com>

Alderlake-N only has E-core, it has been moved to non-hybrid code path on
the kernel side, add the cpuid for Alderlake-N separately.

Signed-off-by: Zhengjun Xing <zhengjun.xing@linux.intel.com>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
---
Change log:
  v2:
    * Regenerate the mapfile with the new converter scripts.
      (https://github.com/intel/perfmon/pull/32 and add the ADL-N fix)
    * Change to the end of the ADL-N patch series
    * Only update the version for ADL-N

 tools/perf/pmu-events/arch/x86/mapfile.csv | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-events/arch/x86/mapfile.csv
index 5e609b876790..78af105ca236 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -1,5 +1,6 @@
 Family-model,Version,Filename,EventType
-GenuineIntel-6-(97|9A|B7|BA|BE|BF),v1.15,alderlake,core
+GenuineIntel-6-(97|9A|B7|BA|BF),v1.15,alderlake,core
+GenuineIntel-6-BE,v1.16,alderlaken,core
 GenuineIntel-6-(1C|26|27|35|36),v4,bonnell,core
 GenuineIntel-6-(3D|47),v26,broadwell,core
 GenuineIntel-6-56,v23,broadwellde,core
-- 
2.25.1

