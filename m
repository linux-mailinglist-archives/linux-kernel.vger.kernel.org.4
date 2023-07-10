Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 018B374D88B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 16:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232478AbjGJOH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 10:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232529AbjGJOHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 10:07:01 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C11E2E50;
        Mon, 10 Jul 2023 07:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688997992; x=1720533992;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yQFTo0B2urTk/RCCqud95p7Ixzev6NqE7JeTu/NsTRc=;
  b=BnsVY8ZNOqAG6kLUNNu0sPF2+IqAfrDWLNqyLxbxhFEyhm8SNQNskcms
   Sux+5j64ATfCnFAOYHJFZ+Crt0zcL4JTCvjxwMziSs1F1OlLHXTggJPBC
   idbtALw3VB/auuSBIf3QoRt0opfCAkz4hWoehScctEyJNODBR1zXkJCQX
   0dXmf3fx3zZ1Q2Bob8JPS+7hgRYdirwXNVgBJNJHzrcdFz/d7eL5n9pgh
   4Vul0hhuNymON5sfitC0/vA6GMtt+9REWA3o6CTAPvouBXFmy2E6B0PAO
   GFjAo1tlfz8bdM9Trvm7i5x1PRceW2fhUz7it2KUGvuVE46NhHMPH0Lxl
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="361815087"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="361815087"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 07:05:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="714823019"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="714823019"
Received: from powerlab.fi.intel.com ([10.237.71.25])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 07:05:39 -0700
From:   Michal Wilczynski <michal.wilczynski@intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     rafael@kernel.org, andriy.shevchenko@intel.com,
        artem.bityutskiy@linux.intel.com, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, lenb@kernel.org,
        jgross@suse.com, linux-kernel@vger.kernel.org, x86@kernel.org,
        Michal Wilczynski <michal.wilczynski@intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v4 8/9] acpi: Use _OSC method to convey processor OSPM capabilities
Date:   Mon, 10 Jul 2023 17:03:36 +0300
Message-ID: <20230710140337.1434060-9-michal.wilczynski@intel.com>
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

Change acpi_early_processor_osc() to return value in case of the failure.
Make it more generic - previously it served only to execute workaround
for buggy BIOS in Skylake systems. Now it will walk through ACPI
namespace looking for processor objects and will convey OSPM processor
capabilities using _OSC method.

Introduce new function acpi_early_processor_control_setup(). Call it in
acpi_bus_init(). Make acpi_early_processor_control_setup() call _OSC
method first. In case of the failure of the _OSC, try using _PDC as a
fallback.

Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/acpi/acpi_processor.c | 34 +++++++++++++++++++++++++---------
 drivers/acpi/bus.c            |  5 +----
 drivers/acpi/internal.h       |  9 ++-------
 3 files changed, 28 insertions(+), 20 deletions(-)

diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
index f3c41acdb8ae..50c456dbecea 100644
--- a/drivers/acpi/acpi_processor.c
+++ b/drivers/acpi/acpi_processor.c
@@ -623,16 +623,32 @@ static acpi_status __init acpi_hwp_native_thermal_lvt_osc(acpi_handle handle,
 	return AE_OK;
 }
 
-void __init acpi_early_processor_osc(void)
+acpi_status __init acpi_early_processor_osc(void)
 {
-	if (boot_cpu_has(X86_FEATURE_HWP)) {
-		acpi_walk_namespace(ACPI_TYPE_PROCESSOR, ACPI_ROOT_OBJECT,
-				    ACPI_UINT32_MAX,
-				    acpi_hwp_native_thermal_lvt_osc,
-				    NULL, NULL, NULL);
-		acpi_get_devices(ACPI_PROCESSOR_DEVICE_HID,
-				 acpi_hwp_native_thermal_lvt_osc,
-				 NULL, NULL);
+	acpi_status status;
+
+	acpi_proc_quirk_dmi_check();
+
+	status = acpi_walk_namespace(ACPI_TYPE_PROCESSOR, ACPI_ROOT_OBJECT,
+				     ACPI_UINT32_MAX, acpi_processor_osc, NULL,
+				     NULL, NULL);
+	if (ACPI_FAILURE(status))
+		return status;
+
+	return acpi_get_devices(ACPI_PROCESSOR_DEVICE_HID, acpi_processor_osc,
+				NULL, NULL);
+}
+
+void __init acpi_early_processor_control_setup(void)
+{
+	acpi_status status;
+
+	status = acpi_early_processor_osc();
+	if (ACPI_FAILURE(status)) {
+		pr_err("_OSC methods failed, trying _PDC\n");
+		acpi_early_processor_set_pdc();
+	} else {
+		pr_info("_OSC methods ran successfully\n");
 	}
 }
 #endif
diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 2fc2b43a4ed3..a39f2f3a2cd6 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -1296,9 +1296,6 @@ static int __init acpi_bus_init(void)
 		goto error1;
 	}
 
-	/* Set capability bits for _OSC under processor scope */
-	acpi_early_processor_osc();
-
 	/*
 	 * _OSC method may exist in module level code,
 	 * so it must be run after ACPI_FULL_INITIALIZATION
@@ -1314,7 +1311,7 @@ static int __init acpi_bus_init(void)
 
 	acpi_sysfs_init();
 
-	acpi_early_processor_set_pdc();
+	acpi_early_processor_control_setup();
 
 	/*
 	 * Maybe EC region is required at bus_scan/acpi_get_devices. So it
diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
index 87c343f79900..ccffa04c7060 100644
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -152,18 +152,13 @@ int acpi_wakeup_device_init(void);
                                   Processor
    -------------------------------------------------------------------------- */
 #ifdef CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC
+void acpi_early_processor_control_setup(void);
 void acpi_early_processor_set_pdc(void);
 
 void acpi_proc_quirk_dmi_check(void);
 bool processor_physically_present(acpi_handle handle);
 #else
-static inline void acpi_early_processor_set_pdc(void) {}
-#endif
-
-#ifdef CONFIG_X86
-void acpi_early_processor_osc(void);
-#else
-static inline void acpi_early_processor_osc(void) {}
+void acpi_early_processor_control_setup(void) {}
 #endif
 
 /* --------------------------------------------------------------------------
-- 
2.41.0

