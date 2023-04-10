Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 756946DCA12
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 19:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbjDJRfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 13:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjDJRfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 13:35:22 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0F372123;
        Mon, 10 Apr 2023 10:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681148121; x=1712684121;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vhVw5OFDRc/HhALHYAky466L4C5uYZxbntzeNjO/Zj0=;
  b=aiWdKKyzVEPL/Ftocwg1fQPIzrPw5g7uqFVNON274nU2E8P10O1xoqFv
   xMLEu6iMtD26QMzConWYApa3aYxqg8Ub72zsukEkEyyg0IrhsDZWvm1Qq
   hBLhWyG6kcvOyScI+x3EOY/LI2GQNoKSYj/wNl0LXcf2LxJb5kQQ3bfZH
   6KmB5LVtb/Y0TCF41zTJs7dZpU/e8y0uVIIl3FUH0zg1VT4neHv6uXVaz
   QLUrPt8cy9rZJ6a9VM24ueniKXb+WFil2inKbWPJRpEglV5eQNfbOHH37
   IBLgMRbm0JF5qd4xBAUZzAm56kNNL9z2roTgrI+S2qR7JVZ63s9qyuUE9
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="406242460"
X-IronPort-AV: E=Sophos;i="5.98,333,1673942400"; 
   d="scan'208";a="406242460"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2023 10:35:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="799573853"
X-IronPort-AV: E=Sophos;i="5.98,333,1673942400"; 
   d="scan'208";a="799573853"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by fmsmga002.fm.intel.com with ESMTP; 10 Apr 2023 10:35:05 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     rafael@kernel.org, rui.zhang@intel.com, daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        bp@alien8.de,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Rui Salvaterra <rsalvaterra@gmail.com>, stable@kernel.org
Subject: [PATCH] thermal: intel: Fix unchecked MSR issue
Date:   Mon, 10 Apr 2023 10:35:01 -0700
Message-Id: <20230410173501.3743570-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.39.1
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

Some older processors don't allow BIT(13) and BIT(15) in the current
mask set by "THERM_STATUS_CLEAR_CORE_MASK". This results in:

unchecked MSR access error: WRMSR to 0x19c (tried to
write 0x000000000000aaa8) at rIP: 0xffffffff816f66a6
(throttle_active_work+0xa6/0x1d0)

To avoid unchecked MSR issues, check cpuid for each feature and then
form core mask. Do the same for package mask set by
"THERM_STATUS_CLEAR_PKG_MASK".

Introduce functions thermal_intr_core_clear_mask() and
thermal_intr_pkg_clear_mask() to set core and package mask respectively.
These functions are called during initialization.

Fixes: 6fe1e64b6026 ("thermal: intel: Prevent accidental clearing of HFI status")
Reported-by: Rui Salvaterra <rsalvaterra@gmail.com>
Link: https://lore.kernel.org/lkml/cdf43fb423368ee3994124a9e8c9b4f8d00712c6.camel@linux.intel.com/T/
Tested-by: Rui Salvaterra <rsalvaterra@gmail.com>
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: stable@kernel.org # 6.2+
---
 drivers/thermal/intel/therm_throt.c | 73 ++++++++++++++++++++++++++---
 1 file changed, 66 insertions(+), 7 deletions(-)

diff --git a/drivers/thermal/intel/therm_throt.c b/drivers/thermal/intel/therm_throt.c
index 2e22bb82b738..d5047676f3d2 100644
--- a/drivers/thermal/intel/therm_throt.c
+++ b/drivers/thermal/intel/therm_throt.c
@@ -193,8 +193,67 @@ static const struct attribute_group thermal_attr_group = {
 #define THERM_THROT_POLL_INTERVAL	HZ
 #define THERM_STATUS_PROCHOT_LOG	BIT(1)
 
-#define THERM_STATUS_CLEAR_CORE_MASK (BIT(1) | BIT(3) | BIT(5) | BIT(7) | BIT(9) | BIT(11) | BIT(13) | BIT(15))
-#define THERM_STATUS_CLEAR_PKG_MASK  (BIT(1) | BIT(3) | BIT(5) | BIT(7) | BIT(9) | BIT(11))
+static u64 def_therm_core_clear_mask;
+static u64 def_therm_pkg_clear_mask;
+
+static void thermal_intr_core_clear_mask(void)
+{
+	if (def_therm_core_clear_mask)
+		return;
+
+	/*
+	 * Reference: Intel SDM  Volume 4
+	 * "Table 2-2. IA-32 Architectural MSRs", MSR 0x19C
+	 * IA32_THERM_STATUS.
+	 */
+
+	/*
+	 * Bit 1, 3, 5: CPUID.01H:EDX[22] = 1. This driver will not
+	 * enable interrupts, when 0 as it checks for X86_FEATURE_ACPI.
+	 */
+	def_therm_core_clear_mask = (BIT(1) | BIT(3) | BIT(5));
+
+	/*
+	 * Bit 7 and 9: Thermal Threshold #1 and #2 log
+	 * If CPUID.01H:ECX[8] = 1
+	 */
+	if (boot_cpu_has(X86_FEATURE_TM2))
+		def_therm_core_clear_mask |= (BIT(7) | BIT(9));
+
+	/* Bit 11: Power Limitation log (R/WC0) If CPUID.06H:EAX[4] = 1 */
+	if (boot_cpu_has(X86_FEATURE_PLN))
+		def_therm_core_clear_mask |= BIT(11);
+
+	/*
+	 * Bit 13: Current Limit log (R/WC0) If CPUID.06H:EAX[7] = 1
+	 * Bit 15: Cross Domain Limit log (R/WC0) If CPUID.06H:EAX[7] = 1
+	 */
+	if (boot_cpu_has(X86_FEATURE_HWP))
+		def_therm_core_clear_mask |= (BIT(13) | BIT(15));
+}
+
+static void thermal_intr_pkg_clear_mask(void)
+{
+	if (def_therm_pkg_clear_mask)
+		return;
+
+	/*
+	 * Reference: Intel SDM  Volume 4
+	 * "Table 2-2. IA-32 Architectural MSRs", MSR 0x1B1
+	 * IA32_PACKAGE_THERM_STATUS.
+	 */
+
+	/* All bits except BIT 26 depends on CPUID.06H: EAX[6] = 1 */
+	if (boot_cpu_has(X86_FEATURE_PTS))
+		def_therm_pkg_clear_mask = (BIT(1) | BIT(3) | BIT(5) | BIT(7) | BIT(9) | BIT(11));
+
+	/*
+	 * Intel SDM Volume 2A: Thermal and Power Management Leaf
+	 * Bit 26: CPUID.06H: EAX[19] = 1
+	 */
+	if (boot_cpu_has(X86_FEATURE_HFI))
+		def_therm_pkg_clear_mask |= BIT(26);
+}
 
 /*
  * Clear the bits in package thermal status register for bit = 1
@@ -207,13 +266,10 @@ void thermal_clear_package_intr_status(int level, u64 bit_mask)
 
 	if (level == CORE_LEVEL) {
 		msr  = MSR_IA32_THERM_STATUS;
-		msr_val = THERM_STATUS_CLEAR_CORE_MASK;
+		msr_val = def_therm_core_clear_mask;
 	} else {
 		msr  = MSR_IA32_PACKAGE_THERM_STATUS;
-		msr_val = THERM_STATUS_CLEAR_PKG_MASK;
-		if (boot_cpu_has(X86_FEATURE_HFI))
-			msr_val |= BIT(26);
-
+		msr_val = def_therm_pkg_clear_mask;
 	}
 
 	msr_val &= ~bit_mask;
@@ -708,6 +764,9 @@ void intel_init_thermal(struct cpuinfo_x86 *c)
 	h = THERMAL_APIC_VECTOR | APIC_DM_FIXED | APIC_LVT_MASKED;
 	apic_write(APIC_LVTTHMR, h);
 
+	thermal_intr_core_clear_mask();
+	thermal_intr_pkg_clear_mask();
+
 	rdmsr(MSR_IA32_THERM_INTERRUPT, l, h);
 	if (cpu_has(c, X86_FEATURE_PLN) && !int_pln_enable)
 		wrmsr(MSR_IA32_THERM_INTERRUPT,
-- 
2.39.1

