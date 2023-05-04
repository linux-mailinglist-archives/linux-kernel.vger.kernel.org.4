Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58F796F6597
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 09:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbjEDHPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 03:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjEDHPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 03:15:12 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 128DA1731;
        Thu,  4 May 2023 00:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683184511; x=1714720511;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CyVV9r/J36vPs8Amt+XKv1VeMXKDAyxKEBpx5xFq2aw=;
  b=ex6despMTO3wjAQv806SU0oqdpyZLlWCFQBNYtqha6W326Qo6feXnYlU
   h7D96wnrJ4MaaeSVvAw5Qon/ttybf3J3DHdZ4TPnfEcNyEpwkx7dP1gtV
   aHW3D7PYhGm5+VnguQSgsvhBEA+WLZbVx4Umzo/+FN06wX7Rv8MXUoOSr
   bQpyVozEhKg9XsydNkJClKUB05iSxJdMM1CQGrsv/O+pBtimfg5YlEIcd
   ji75oHgWKxfxXSQEq7cHUtM2NbDtHi6Dg7AXSeYB0S+JeobWWdfclDeGf
   9hccH5s8PAqSoHMkUnaKsU1BDOziV1Dz5dWZEUip+nZQHHAwsF02UzIaQ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10699"; a="346326356"
X-IronPort-AV: E=Sophos;i="5.99,249,1677571200"; 
   d="scan'208";a="346326356"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2023 00:15:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10699"; a="699729388"
X-IronPort-AV: E=Sophos;i="5.99,249,1677571200"; 
   d="scan'208";a="699729388"
Received: from dmi-pnp-i7.sh.intel.com ([10.239.159.155])
  by fmsmga007.fm.intel.com with ESMTP; 04 May 2023 00:14:43 -0700
From:   Dapeng Mi <dapeng1.mi@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhang Tinghao <tinghao.zhang@intel.com>,
        Dapeng Mi <dapeng1.mi@intel.com>,
        Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [PATCH v2] perf/x86/intel: Define bit macros for FixCntrCtl MSR
Date:   Thu,  4 May 2023 15:21:28 +0800
Message-Id: <20230504072128.3653470-1-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define bit macros for FixCntrCtl MSR and replace the bit hardcoding
with these bit macros. This would make code be more human-readable.

Perf commands 'perf stat -e "instructions,cycles,ref-cycles"' and
'perf record -e "instructions,cycles,ref-cycles"' pass.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/core.c      | 18 +++++++++---------
 arch/x86/include/asm/perf_event.h | 10 ++++++++++
 2 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index a3fb996a86a1..7beebbd15343 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2451,7 +2451,7 @@ static void intel_pmu_disable_fixed(struct perf_event *event)
 
 	intel_clear_masks(event, idx);
 
-	mask = 0xfULL << ((idx - INTEL_PMC_IDX_FIXED) * 4);
+	mask = intel_fixed_bits_by_idx(idx - INTEL_PMC_IDX_FIXED, INTEL_FIXED_BITS_MASK);
 	cpuc->fixed_ctrl_val &= ~mask;
 }
 
@@ -2750,25 +2750,25 @@ static void intel_pmu_enable_fixed(struct perf_event *event)
 	 * if requested:
 	 */
 	if (!event->attr.precise_ip)
-		bits |= 0x8;
+		bits |= INTEL_FIXED_0_ENABLE_PMI;
 	if (hwc->config & ARCH_PERFMON_EVENTSEL_USR)
-		bits |= 0x2;
+		bits |= INTEL_FIXED_0_USER;
 	if (hwc->config & ARCH_PERFMON_EVENTSEL_OS)
-		bits |= 0x1;
+		bits |= INTEL_FIXED_0_KERNEL;
 
 	/*
 	 * ANY bit is supported in v3 and up
 	 */
 	if (x86_pmu.version > 2 && hwc->config & ARCH_PERFMON_EVENTSEL_ANY)
-		bits |= 0x4;
+		bits |= INTEL_FIXED_0_ANYTHREAD;
 
 	idx -= INTEL_PMC_IDX_FIXED;
-	bits <<= (idx * 4);
-	mask = 0xfULL << (idx * 4);
+	bits = intel_fixed_bits_by_idx(idx, bits);
+	mask = intel_fixed_bits_by_idx(idx, INTEL_FIXED_BITS_MASK);
 
 	if (x86_pmu.intel_cap.pebs_baseline && event->attr.precise_ip) {
-		bits |= ICL_FIXED_0_ADAPTIVE << (idx * 4);
-		mask |= ICL_FIXED_0_ADAPTIVE << (idx * 4);
+		bits |= intel_fixed_bits_by_idx(idx, ICL_FIXED_0_ADAPTIVE);
+		mask |= intel_fixed_bits_by_idx(idx, ICL_FIXED_0_ADAPTIVE);
 	}
 
 	cpuc->fixed_ctrl_val &= ~mask;
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 8fc15ed5e60b..d879dbf62284 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -32,11 +32,21 @@
 #define ARCH_PERFMON_EVENTSEL_INV			(1ULL << 23)
 #define ARCH_PERFMON_EVENTSEL_CMASK			0xFF000000ULL
 
+#define INTEL_FIXED_BITS_MASK				0xFULL
+#define INTEL_FIXED_BITS_STRIDE			4
+#define INTEL_FIXED_0_KERNEL				(1ULL << 0)
+#define INTEL_FIXED_0_USER				(1ULL << 1)
+#define INTEL_FIXED_0_ANYTHREAD			(1ULL << 2)
+#define INTEL_FIXED_0_ENABLE_PMI			(1ULL << 3)
+
 #define HSW_IN_TX					(1ULL << 32)
 #define HSW_IN_TX_CHECKPOINTED				(1ULL << 33)
 #define ICL_EVENTSEL_ADAPTIVE				(1ULL << 34)
 #define ICL_FIXED_0_ADAPTIVE				(1ULL << 32)
 
+#define intel_fixed_bits_by_idx(_idx, _bits)			\
+	((_bits) << ((_idx) * INTEL_FIXED_BITS_STRIDE))
+
 #define AMD64_EVENTSEL_INT_CORE_ENABLE			(1ULL << 36)
 #define AMD64_EVENTSEL_GUESTONLY			(1ULL << 40)
 #define AMD64_EVENTSEL_HOSTONLY				(1ULL << 41)
-- 
2.34.1

