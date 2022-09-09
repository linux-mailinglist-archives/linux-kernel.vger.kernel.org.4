Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A6485B42CD
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Sep 2022 01:08:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232091AbiIIXIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 19:08:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231494AbiIIXGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 19:06:48 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39E50115CE1
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 16:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662764800; x=1694300800;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=uWhlQiKfFlJ133UzVFaeiIrxWqUY0rEMtrX3JgRUHEg=;
  b=Sc7GrvPpXtwGL2S+wQAoH4Sjo3KLojt1iUzuZ1i27Qfzr+eiKSSA2xpp
   V85HkyjKX0aqOhPHxCkIAT/v2MtQ+PUy3/wdZao2MmSHPxr/IJnb/r22x
   dxhVs47VycBw9aq2RzJ4078BRmo3exKsJl5009fok61F7SfaUfyc11Kk1
   GEJ/ILfT92fQEs3BIP0d2UTmJMwLbctHPtin2p1i4lzR1+oozqMbvkLC6
   59+2j72+haz4kuBRHJmV8kLLfUm7B3ZtDc2i5tHo10+dE9TJ4plSCTf2o
   s6StVcZV+40nkLWc0+oowLAnwRWQHECB2cTLiQZD2IxVO12bgTJRLlpV4
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10465"; a="298386930"
X-IronPort-AV: E=Sophos;i="5.93,304,1654585200"; 
   d="scan'208";a="298386930"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2022 16:06:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,304,1654585200"; 
   d="scan'208";a="677355058"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga008.fm.intel.com with ESMTP; 09 Sep 2022 16:06:36 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ricardo Neri <ricardo.neri@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Len Brown <len.brown@intel.com>, Mel Gorman <mgorman@suse.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Valentin Schneider <vschneid@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        "Tim C . Chen" <tim.c.chen@intel.com>
Subject: [RFC PATCH 22/23] x86/hreset: Configure history reset
Date:   Fri,  9 Sep 2022 16:12:04 -0700
Message-Id: <20220909231205.14009-23-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220909231205.14009-1-ricardo.neri-calderon@linux.intel.com>
References: <20220909231205.14009-1-ricardo.neri-calderon@linux.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Configure the MSR that controls the behavior of HRESET on each logical
processor.

Cc: Ben Segall <bsegall@google.com>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Len Brown <len.brown@intel.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Tim C. Chen <tim.c.chen@intel.com>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
 arch/x86/kernel/cpu/common.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 3e508f239098..108642fe6761 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -411,6 +411,28 @@ static __always_inline void setup_umip(struct cpuinfo_x86 *c)
 	cr4_clear_bits(X86_CR4_UMIP);
 }
 
+static u32 hardware_history_features __read_mostly;
+
+static __always_inline void setup_hreset(struct cpuinfo_x86 *c)
+{
+	if (!cpu_feature_enabled(X86_FEATURE_HRESET))
+		return;
+
+	/*
+	 * Use on all CPUs the hardware history features that the boot
+	 * CPU supports.
+	 */
+	if (c == &boot_cpu_data)
+		hardware_history_features = cpuid_ebx(0x20);
+
+	if (!hardware_history_features)
+		return;
+
+	wrmsrl(MSR_IA32_HW_HRESET_ENABLE, hardware_history_features);
+
+	pr_info_once("x86/cpu: Intel History Reset (HRESET) activated\n");
+}
+
 /* These bits should not change their value after CPU init is finished. */
 static const unsigned long cr4_pinned_mask =
 	X86_CR4_SMEP | X86_CR4_SMAP | X86_CR4_UMIP |
@@ -1823,10 +1845,11 @@ static void identify_cpu(struct cpuinfo_x86 *c)
 	/* Disable the PN if appropriate */
 	squash_the_stupid_serial_number(c);
 
-	/* Set up SMEP/SMAP/UMIP */
+	/* Set up SMEP/SMAP/UMIP/HRESET */
 	setup_smep(c);
 	setup_smap(c);
 	setup_umip(c);
+	setup_hreset(c);
 
 	/* Enable FSGSBASE instructions if available. */
 	if (cpu_has(c, X86_FEATURE_FSGSBASE)) {
-- 
2.25.1

