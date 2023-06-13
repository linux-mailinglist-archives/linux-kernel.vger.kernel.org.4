Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A02072E7F8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 18:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243014AbjFMQM7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 12:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243007AbjFMQMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 12:12:52 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABCA6199C;
        Tue, 13 Jun 2023 09:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686672769; x=1718208769;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=q6hZmWD+34oqCL6/IAdani4632AKiZB8VpAcTJgImVQ=;
  b=AID3wy79ynN2oNRwLEKtK8jbPZhqhcdLO61F9vCV00Kxi1aFtRSi2wP3
   uMi9zsxW/1NRajUUwXtB2Nv2B++x0o0UwIaQCViVVVsszVtWCQvmjoUEI
   tWp4ci0c1BDYdth03SNYUlDTbj7aC1+lm8H53BZl6WPydsuTGGwpaK7Ov
   1tVSS1915Io2cerqNGFef7PhtMFkjgmwCOCxeNhFn3l4U7I/eYUIJj9Vn
   ScKHp8/5ls5Tpc8gYTGZ7HeA3rv6Sphc8R4grl+76a8NVxUQjy7tG/NEC
   qjseYnQnOayLWA7qxnyf4KfMWqC/YQoQBIrR9aV8Oh3Fa7NtYDq2bxvl0
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="348038856"
X-IronPort-AV: E=Sophos;i="6.00,240,1681196400"; 
   d="scan'208";a="348038856"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 09:11:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="714863563"
X-IronPort-AV: E=Sophos;i="6.00,240,1681196400"; 
   d="scan'208";a="714863563"
Received: from powerlab.fi.intel.com ([10.237.71.25])
  by fmsmga007.fm.intel.com with ESMTP; 13 Jun 2023 09:11:01 -0700
From:   Michal Wilczynski <michal.wilczynski@intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     rafael@kernel.org, andriy.shevchenko@intel.com,
        artem.bityutskiy@linux.intel.com, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, lenb@kernel.org,
        jgross@suse.com, linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [PATCH v3 3/5] acpi: Introduce new function callback for _OSC
Date:   Tue, 13 Jun 2023 19:10:32 +0300
Message-Id: <20230613161034.3496047-4-michal.wilczynski@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230613161034.3496047-1-michal.wilczynski@intel.com>
References: <20230613161034.3496047-1-michal.wilczynski@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently in ACPI code _OSC method is already used for workaround
introduced in commit a21211672c9a ("ACPI / processor: Request native
thermal interrupt handling via _OSC"). Create new function, similar to
already existing acpi_hwp_native_thermal_lvt_osc(). Call new function
acpi_processor_osc(). Make this function fulfill the purpose previously
fulfilled by the workaround plus convey OSPM processor capabilities
with it by setting correct processor capability bits.

Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 arch/x86/include/asm/acpi.h   |  3 +++
 drivers/acpi/acpi_processor.c | 43 ++++++++++++++++++++++++++++++++++-
 include/acpi/pdc_intel.h      |  1 +
 3 files changed, 46 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/acpi.h b/arch/x86/include/asm/acpi.h
index 6a498d1781e7..6c25ce2dad18 100644
--- a/arch/x86/include/asm/acpi.h
+++ b/arch/x86/include/asm/acpi.h
@@ -112,6 +112,9 @@ static inline void arch_acpi_set_proc_cap_bits(u32 *cap)
 	if (cpu_has(c, X86_FEATURE_ACPI))
 		*cap |= ACPI_PDC_T_FFH;
 
+	if (cpu_has(c, X86_FEATURE_HWP))
+		*cap |= ACPI_PDC_COLLAB_PROC_PERF;
+
 	/*
 	 * If mwait/monitor is unsupported, C2/C3_FFH will be disabled
 	 */
diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
index 8c5d0295a042..0de0b05b6f53 100644
--- a/drivers/acpi/acpi_processor.c
+++ b/drivers/acpi/acpi_processor.c
@@ -591,13 +591,54 @@ void __init processor_dmi_check(void)
 	dmi_check_system(processor_idle_dmi_table);
 }
 
+/* vendor specific UUID indicating an Intel platform */
+static u8 sb_uuid_str[] = "4077A616-290C-47BE-9EBD-D87058713953";
 static bool acpi_hwp_native_thermal_lvt_set;
+static acpi_status __init acpi_processor_osc(acpi_handle handle, u32 lvl,
+					     void *context, void **rv)
+{
+	u32 capbuf[2] = {};
+	acpi_status status;
+	struct acpi_osc_context osc_context = {
+		.uuid_str = sb_uuid_str,
+		.rev = 1,
+		.cap.length = 8,
+		.cap.pointer = capbuf,
+	};
+
+	if (processor_physically_present(handle) == false)
+		return AE_OK;
+
+	arch_acpi_set_proc_cap_bits(&capbuf[OSC_SUPPORT_DWORD]);
+
+	if (boot_option_idle_override == IDLE_NOMWAIT)
+		capbuf[OSC_SUPPORT_DWORD] &=
+			~(ACPI_PDC_C_C2C3_FFH | ACPI_PDC_C_C1_FFH);
+
+	status = acpi_run_osc(handle, &osc_context);
+	if (ACPI_FAILURE(status))
+		return status;
+
+	if (osc_context.ret.pointer && osc_context.ret.length > 1) {
+		u32 *capbuf_ret = osc_context.ret.pointer;
+
+		if (!acpi_hwp_native_thermal_lvt_set &&
+		    capbuf_ret[1] & ACPI_PDC_COLLAB_PROC_PERF) {
+			acpi_handle_info(handle,
+					 "_OSC native thermal LVT Acked\n");
+			acpi_hwp_native_thermal_lvt_set = true;
+		}
+	}
+	kfree(osc_context.ret.pointer);
+
+	return AE_OK;
+}
+
 static acpi_status __init acpi_hwp_native_thermal_lvt_osc(acpi_handle handle,
 							  u32 lvl,
 							  void *context,
 							  void **rv)
 {
-	u8 sb_uuid_str[] = "4077A616-290C-47BE-9EBD-D87058713953";
 	u32 capbuf[2];
 	struct acpi_osc_context osc_context = {
 		.uuid_str = sb_uuid_str,
diff --git a/include/acpi/pdc_intel.h b/include/acpi/pdc_intel.h
index 967c552d1cd3..9427f639287f 100644
--- a/include/acpi/pdc_intel.h
+++ b/include/acpi/pdc_intel.h
@@ -16,6 +16,7 @@
 #define ACPI_PDC_C_C1_FFH		(0x0100)
 #define ACPI_PDC_C_C2C3_FFH		(0x0200)
 #define ACPI_PDC_SMP_P_HWCOORD		(0x0800)
+#define ACPI_PDC_COLLAB_PROC_PERF	(0x1000)
 
 #define ACPI_PDC_EST_CAPABILITY_SMP	(ACPI_PDC_SMP_C1PT | \
 					 ACPI_PDC_C_C1_HALT | \
-- 
2.41.0

