Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCFE661054A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 00:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234820AbiJ0WBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 18:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234800AbiJ0WBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 18:01:23 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBAF49E688;
        Thu, 27 Oct 2022 15:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666908060; x=1698444060;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=fujCfldGBPIDZRrZhsgY+3RvDLnevLWFmVpeF8wnuOo=;
  b=aFT3EVIWxlGtAs6snjxocbyCOqULwuuxpkcWu9D8j2dXtQecjvO9bkG6
   BURWLTRRjLKB1MZ9hxzy/GqtRSOKYcvDmm+F+hyHaCgMORkKetI25wyoV
   jfg6IthJAwW5x3HnNWgx1cw+DVKusfdAurgGI1oTcszDOhNIoATbZjMqg
   aROsSb/rcdME6XK1ePLPKRrRJdbboWI1KBclAaByExvX0WbGewMVBI5Io
   XYygRXrLh1TH8KwHBDPqgtVkqSVCVwNno3LHKWOkdNTyl4VyhnYWkLR1+
   deAukGLztTWzmKKfHzCroux8W4XzRewft9KVShpRpgz6qOBydFWNtKRkP
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10513"; a="394665997"
X-IronPort-AV: E=Sophos;i="5.95,219,1661842800"; 
   d="scan'208";a="394665997"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2022 15:00:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10513"; a="635071032"
X-IronPort-AV: E=Sophos;i="5.95,219,1661842800"; 
   d="scan'208";a="635071032"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by fmsmga007.fm.intel.com with ESMTP; 27 Oct 2022 15:00:58 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, rafael@kernel.org,
        len.brown@intel.com
Cc:     peterz@infradead.org, x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] x86: intel_epb: Set Alder Lake N and Raptor Lake P normal EPB
Date:   Thu, 27 Oct 2022 15:00:56 -0700
Message-Id: <20221027220056.1534264-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Intel processors support additional software hint called EPB ("Energy
Performance Bias") to guide the hardware heuristic of power management
features to favor increasing dynamic performance or conserve energy
consumption.

Since this EPB hint is processor specific, the same value of hint can
result in different behavior across generations of processors.

commit 4ecc933b7d1f ("x86: intel_epb: Allow model specific normal EPB
value")' introduced capability to update the default power up EPB
based on the CPU model and updated the default EPB to 7 for Alder Lake
mobile CPUs.

The same change is required for other Alder Lake-N and Raptor Lake-P
mobile CPUs as the current default of 6 results in higher uncore power
consumption. This increase in power is related to memory clock
frequency setting based on the EPB value.

Depending on the EPB the minimum memory frequency is set by the
firmware. At EPB = 7, the minimum memory frequency is 1/4th compared to
EPB = 6. This results in significant power saving for idle and
semi-idle workload on a Chrome platform.

For example Change in power and performance from EPB change from 6 to 7
on Alder Lake-N:

Workload    Performance diff (%)    power diff
----------------------------------------------------
VP9 FHD30	0 (FPS)		-218 mw
Google meet	0 (FPS)		-385 mw

This 200+ mw power saving is very significant for mobile platform for
battery life and thermal reasons.

But as the workload demands more memory bandwidth, the memory frequency
will be increased very fast. There is no power savings for such busy
workloads.

For example:

Workload		Performance diff (%) from EPB 6 to 7
-------------------------------------------------------
Speedometer 2.0		-0.8
WebGL Aquarium 10K
Fish    		-0.5
Unity 3D 2018		0.2
WebXPRT3		-0.5

There are run to run variations for performance scores for
such busy workloads. So the difference is not significant.

Add a new define ENERGY_PERF_BIAS_NORMAL_POWERSAVE for EPB 7
and use it for Alder Lake-N and Raptor Lake-P mobile CPUs.

This modification is done originally by
Jeremy Compostella <jeremy.compostella@intel.com>.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 arch/x86/include/asm/msr-index.h | 1 +
 arch/x86/kernel/cpu/intel_epb.c  | 7 ++++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 10ac52705892..a3eb4d3e70b8 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -796,6 +796,7 @@
 #define ENERGY_PERF_BIAS_PERFORMANCE		0
 #define ENERGY_PERF_BIAS_BALANCE_PERFORMANCE	4
 #define ENERGY_PERF_BIAS_NORMAL			6
+#define ENERGY_PERF_BIAS_NORMAL_POWERSAVE	7
 #define ENERGY_PERF_BIAS_BALANCE_POWERSAVE	8
 #define ENERGY_PERF_BIAS_POWERSAVE		15
 
diff --git a/arch/x86/kernel/cpu/intel_epb.c b/arch/x86/kernel/cpu/intel_epb.c
index fbaf12e43f41..3b8476158236 100644
--- a/arch/x86/kernel/cpu/intel_epb.c
+++ b/arch/x86/kernel/cpu/intel_epb.c
@@ -204,7 +204,12 @@ static int intel_epb_offline(unsigned int cpu)
 }
 
 static const struct x86_cpu_id intel_epb_normal[] = {
-	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L, 7),
+	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L,
+				   ENERGY_PERF_BIAS_NORMAL_POWERSAVE),
+	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_N,
+				   ENERGY_PERF_BIAS_NORMAL_POWERSAVE),
+	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_P,
+				   ENERGY_PERF_BIAS_NORMAL_POWERSAVE),
 	{}
 };
 
-- 
2.31.1

