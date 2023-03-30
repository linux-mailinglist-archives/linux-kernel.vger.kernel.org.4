Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 769B76CF8A8
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 03:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbjC3BXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 21:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjC3BXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 21:23:42 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35B5C4EDB;
        Wed, 29 Mar 2023 18:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680139420; x=1711675420;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=VTxGweIAXTyub8ayicN0Qd452cPhoT+4Iswx+Pz3KLY=;
  b=fjFCTQ51VMf+tMx7+zhOUwyaBhHTb84CQx3SGwJHiw6kRKnFg8LlchCS
   COotoHsYZW3YouRBl7mbvDqUjrJVCVuJebqzxgQpy5h/H1neXGzNh46AT
   oI8BEr2fHqrPR1p7QSE2mnapDg6u8rAJkpFd+DQ1XgNCj7016GywHd4kv
   QCe5FoV4ZnzGowQnj4iG6tuTPR2C61k4KOUKDu6DPrunO12HnDZVgqb61
   IEVqdhURMSo3n1GNpVXaCzi3OMAVeO7MUjXz8QYbnYxyKUkNi5i0nVElp
   evdX0nE4W1di8of4bW2B3dI2MXzfEGQs2vyyJ6qfLPpPkkQ88C515goTB
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="343489873"
X-IronPort-AV: E=Sophos;i="5.98,301,1673942400"; 
   d="scan'208";a="343489873"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 18:23:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="678001234"
X-IronPort-AV: E=Sophos;i="5.98,301,1673942400"; 
   d="scan'208";a="678001234"
Received: from dmi-pnp-i7.sh.intel.com ([10.239.159.155])
  by orsmga007.jf.intel.com with ESMTP; 29 Mar 2023 18:23:35 -0700
From:   Dapeng Mi <dapeng1.mi@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhang Tinghao <tinghao.zhang@intel.com>,
        Zhuocheng Ding <zhuocheng.ding@intel.com>,
        Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [PATCH] perf/x86/intel: Define bit macros for FixCntrCtl MSR
Date:   Thu, 30 Mar 2023 09:28:46 +0800
Message-Id: <20230330012846.2927220-1-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
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
index 070cc4ef2672..b7c0bb78ed59 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2451,7 +2451,7 @@ static void intel_pmu_disable_fixed(struct perf_event *event)
 
 	intel_clear_masks(event, idx);
 
-	mask = 0xfULL << ((idx - INTEL_PMC_IDX_FIXED) * 4);
+	mask = intel_fixed_bits(idx - INTEL_PMC_IDX_FIXED, INTEL_FIXED_BITS_MASK);
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
+	bits = intel_fixed_bits(idx, bits);
+	mask = intel_fixed_bits(idx, INTEL_FIXED_BITS_MASK);
 
 	if (x86_pmu.intel_cap.pebs_baseline && event->attr.precise_ip) {
-		bits |= ICL_FIXED_0_ADAPTIVE << (idx * 4);
-		mask |= ICL_FIXED_0_ADAPTIVE << (idx * 4);
+		bits |= intel_fixed_bits(idx, ICL_FIXED_0_ADAPTIVE);
+		mask |= intel_fixed_bits(idx, ICL_FIXED_0_ADAPTIVE);
 	}
 
 	cpuc->fixed_ctrl_val &= ~mask;
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 8fc15ed5e60b..bdaf015a620e 100644
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
 
+#define intel_fixed_bits(_idx, _bits)			\
+	((_bits) << ((_idx) * INTEL_FIXED_BITS_STRIDE))
+
 #define AMD64_EVENTSEL_INT_CORE_ENABLE			(1ULL << 36)
 #define AMD64_EVENTSEL_GUESTONLY			(1ULL << 40)
 #define AMD64_EVENTSEL_HOSTONLY				(1ULL << 41)
-- 
2.34.1

