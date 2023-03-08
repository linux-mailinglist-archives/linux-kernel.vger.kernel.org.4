Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C06D26AFD4C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 04:15:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbjCHDPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 22:15:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbjCHDPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 22:15:12 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B705F93E26
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 19:15:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678245311; x=1709781311;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=IFN6xHY9SbzCu233JrTYyNu0t0LxvmuaSBt9LRp9bvY=;
  b=I5foEhg3DeKPZ/FN3+deaeMG+UhG4RRLZ1IYo6b6aiMBOALlWEx6mvlh
   F1qunVD0dBg4wSJK6wiqgFa2nJGd8qlTsWQQ4jsfl7YSH0t5Su3MGs4mK
   KrLvRWRIateb6/HWPeXsKW6vFts1V8UeYdDWQXW2XhuEXqGNNunBEWtwH
   x53gnGy+1qrAmXA3WJ6oZwcj+TVIQZgpYPULdQOqpJouA7nGsy63R5p5q
   QrHZaJONzT5JzSVk45f1g+2eywFkHzl5pNv6y5jr8P5J0Xz/A81DXGd9f
   F67RrOS++VgVZzwyuCDcAcXbAf/GDSX1weYHc2Na1Gc473CrtXMSpDhik
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="363678587"
X-IronPort-AV: E=Sophos;i="5.98,242,1673942400"; 
   d="scan'208";a="363678587"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2023 19:15:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="740956061"
X-IronPort-AV: E=Sophos;i="5.98,242,1673942400"; 
   d="scan'208";a="740956061"
Received: from qingwan2-mobl.ccr.corp.intel.com (HELO zwan2-desk1.ccr.corp.intel.com) ([10.254.209.37])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2023 19:15:09 -0800
From:   Zhenyu Wang <zhenyuw@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH] perf/x86/intel: use hexidecimal value for cpuid
Date:   Wed,  8 Mar 2023 11:15:01 +0800
Message-Id: <20230308031501.4688-1-zhenyuw@linux.intel.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's easier to use hexidecimal value instead of decimal for reading
and following with SDM doc, also align with other cpuid calls.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Zhenyu Wang <zhenyuw@linux.intel.com>
---
 arch/x86/events/intel/core.c | 2 +-
 arch/x86/events/intel/lbr.c  | 2 +-
 arch/x86/events/intel/pt.c   | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 14f0a746257d..5af084198c8f 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -5903,7 +5903,7 @@ __init int intel_pmu_init(void)
 	 * Check whether the Architectural PerfMon supports
 	 * Branch Misses Retired hw_event or not.
 	 */
-	cpuid(10, &eax.full, &ebx.full, &fixed_mask, &edx.full);
+	cpuid(0xA, &eax.full, &ebx.full, &fixed_mask, &edx.full);
 	if (eax.split.mask_length < ARCH_PERFMON_EVENTS_COUNT)
 		return -ENODEV;
 
diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index c3b0d15a9841..27048b7f23a0 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -1506,7 +1506,7 @@ void __init intel_pmu_arch_lbr_init(void)
 	u64 lbr_nr;
 
 	/* Arch LBR Capabilities */
-	cpuid(28, &eax.full, &ebx.full, &ecx.full, &unused_edx);
+	cpuid(0x1C, &eax.full, &ebx.full, &ecx.full, &unused_edx);
 
 	lbr_nr = fls(eax.split.lbr_depth_mask) * 8;
 	if (!lbr_nr)
diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
index 42a55794004a..da3c5d748365 100644
--- a/arch/x86/events/intel/pt.c
+++ b/arch/x86/events/intel/pt.c
@@ -235,7 +235,7 @@ static int __init pt_pmu_hw_init(void)
 	}
 
 	for (i = 0; i < PT_CPUID_LEAVES; i++) {
-		cpuid_count(20, i,
+		cpuid_count(0x14, i,
 			    &pt_pmu.caps[CPUID_EAX + i*PT_CPUID_REGS_NUM],
 			    &pt_pmu.caps[CPUID_EBX + i*PT_CPUID_REGS_NUM],
 			    &pt_pmu.caps[CPUID_ECX + i*PT_CPUID_REGS_NUM],
-- 
2.39.2

