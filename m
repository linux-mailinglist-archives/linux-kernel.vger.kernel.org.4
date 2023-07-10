Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A413674D88A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 16:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232302AbjGJOHW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 10:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233000AbjGJOGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 10:06:38 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E019918D;
        Mon, 10 Jul 2023 07:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688997988; x=1720533988;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/X+CMAVZ+fFGpEoYBchn+e9YP1RsPOzHxF/nXxtrpeE=;
  b=E/lIF47yjJ24yaMlcjVExp+LFS+h+ARNsunlZ2KUAIoHAdZhY02EaPI/
   b9CDtyLOxZLaj+S9zcznkmv6guljD0FKl+RhdDdO/EylHOOiQRbEBMUTl
   9iCuGUy3rljHmCEiQlXNIePNdT4il6OhioDyxGKnf4cjrHyG4Zd0hr+vC
   akluhxq0LOfTKbebf7+usoD8hWdWjBlAo1/wz9CDt31sIydDoYTK6knra
   SJ406DfLt7CwNjBMo/JtLvV1swO0nrAytIhr3sopgite73XQxaA3ONmJk
   ZAp20XZmTuMa58hxcCod+jkE2gHantF9oWsfJNv6khvVNvMakVlsG20/q
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="361815052"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="361815052"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 07:05:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="714822968"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="714822968"
Received: from powerlab.fi.intel.com ([10.237.71.25])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 07:05:35 -0700
From:   Michal Wilczynski <michal.wilczynski@intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     rafael@kernel.org, andriy.shevchenko@intel.com,
        artem.bityutskiy@linux.intel.com, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, lenb@kernel.org,
        jgross@suse.com, linux-kernel@vger.kernel.org, x86@kernel.org,
        Michal Wilczynski <michal.wilczynski@intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v4 7/9] acpi: Introduce acpi_processor_osc()
Date:   Mon, 10 Jul 2023 17:03:35 +0300
Message-ID: <20230710140337.1434060-8-michal.wilczynski@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230710140337.1434060-1-michal.wilczynski@intel.com>
References: <20230710140337.1434060-1-michal.wilczynski@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
with it by setting correct processor capabilities bits. Don't include
unnecessary acknowledgment present in
acpi_hwp_native_thermal_lvt_osc(). Set ACPI_PROC_CAP_COLLAB_PROC_PERF
in arch code for coherency.

Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 arch/x86/include/asm/acpi.h   |  3 +++
 drivers/acpi/acpi_processor.c | 29 ++++++++++++++++++++++++++++-
 include/acpi/proc_cap_intel.h |  1 +
 3 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/acpi.h b/arch/x86/include/asm/acpi.h
index 6f6752a2ea36..6c3af9486153 100644
--- a/arch/x86/include/asm/acpi.h
+++ b/arch/x86/include/asm/acpi.h
@@ -115,6 +115,9 @@ static inline void arch_acpi_set_proc_cap_bits(u32 *cap)
 	if (cpu_has(c, X86_FEATURE_ACPI))
 		*cap |= ACPI_PROC_CAP_T_FFH;
 
+	if (cpu_has(c, X86_FEATURE_HWP))
+		*cap |= ACPI_PROC_CAP_COLLAB_PROC_PERF;
+
 	/*
 	 * If mwait/monitor is unsupported, C_C1_FFH and
 	 * C2/C3_FFH will be disabled.
diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
index ebb4efd3d0aa..f3c41acdb8ae 100644
--- a/drivers/acpi/acpi_processor.c
+++ b/drivers/acpi/acpi_processor.c
@@ -559,13 +559,40 @@ bool __init processor_physically_present(acpi_handle handle)
 	return !invalid_logical_cpuid(cpuid);
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
+	if (!processor_physically_present(handle))
+		return AE_OK;
+
+	arch_acpi_set_proc_cap_bits(&capbuf[OSC_SUPPORT_DWORD]);
+
+	status = acpi_run_osc(handle, &osc_context);
+	if (ACPI_FAILURE(status))
+		return status;
+
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
diff --git a/include/acpi/proc_cap_intel.h b/include/acpi/proc_cap_intel.h
index 57e5e2628abb..ddcdc41d6c3e 100644
--- a/include/acpi/proc_cap_intel.h
+++ b/include/acpi/proc_cap_intel.h
@@ -19,6 +19,7 @@
 #define ACPI_PROC_CAP_C_C1_FFH			(0x0100)
 #define ACPI_PROC_CAP_C_C2C3_FFH		(0x0200)
 #define ACPI_PROC_CAP_SMP_P_HWCOORD		(0x0800)
+#define ACPI_PROC_CAP_COLLAB_PROC_PERF		(0x1000)
 
 #define ACPI_PROC_CAP_EST_CAPABILITY_SMP	(ACPI_PROC_CAP_SMP_C1PT | \
 						 ACPI_PROC_CAP_C_C1_HALT | \
-- 
2.41.0

