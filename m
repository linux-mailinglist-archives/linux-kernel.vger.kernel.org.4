Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB5C972E7FA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 18:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243024AbjFMQNH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 12:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243015AbjFMQM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 12:12:59 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59B641BFA;
        Tue, 13 Jun 2023 09:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686672774; x=1718208774;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kxUL6ph3VcSEU60xTmGTf3diW42CGsvE/pDl8/raJiY=;
  b=aOu4l5ctz/3RiyB8rFPiWzKShw4IsEdxx0vEEMr+7pywfl5MInRB2xQh
   GrcjSNpKK7Q7mBo5dtaLcVs1sH7pggc94K5WVw+4lVMQLLnhcORYoFcCL
   Iv5zaj+CigjmFdgdST3UtIArUVVKkSNS7wzKuLKO6H/cPxbCqHZ4Ze7fD
   hsL8oq4kmloiV+29z1qHmsXIBeZc4eIAlg8E43osxwBjaG/ryZiJIuFdE
   3zbLNgee7sLhGc/FzgPT8BWjmeGcgZUrNwuvQ5ocwuUKE2BnTy7/X3g+w
   AMFvT7prDdh147PwjNotrXgeJRBtr7gH0MWxMQ4t389Yi8ZYRjldLwyRz
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="348038888"
X-IronPort-AV: E=Sophos;i="6.00,240,1681196400"; 
   d="scan'208";a="348038888"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 09:11:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="714863574"
X-IronPort-AV: E=Sophos;i="6.00,240,1681196400"; 
   d="scan'208";a="714863574"
Received: from powerlab.fi.intel.com ([10.237.71.25])
  by fmsmga007.fm.intel.com with ESMTP; 13 Jun 2023 09:11:05 -0700
From:   Michal Wilczynski <michal.wilczynski@intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     rafael@kernel.org, andriy.shevchenko@intel.com,
        artem.bityutskiy@linux.intel.com, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, lenb@kernel.org,
        jgross@suse.com, linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [PATCH v3 4/5] acpi: Use _OSC method to convey processor OSPM capabilities
Date:   Tue, 13 Jun 2023 19:10:33 +0300
Message-Id: <20230613161034.3496047-5-michal.wilczynski@intel.com>
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

Change acpi_early_processor_osc() to return value in case of the failure.
Make it more generic - previously it served only to execute workaround
for buggy BIOS in Skylake systems. Now it will walk through ACPI
namespace looking for processor objects and will convey OSPM processor
capabilities using _OSC method.

Prefer using _OSC method over deprecated _PDC in the acpi_bus_init(). In
case of the failure of the _OSC, try using  _PDC as a fallback.

Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/acpi/acpi_processor.c | 23 +++++++++++++----------
 drivers/acpi/bus.c            | 13 +++++++++----
 drivers/acpi/internal.h       |  9 +--------
 3 files changed, 23 insertions(+), 22 deletions(-)

diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
index 0de0b05b6f53..8965e01406e0 100644
--- a/drivers/acpi/acpi_processor.c
+++ b/drivers/acpi/acpi_processor.c
@@ -669,17 +669,20 @@ static acpi_status __init acpi_hwp_native_thermal_lvt_osc(acpi_handle handle,
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
-	}
+	acpi_status status;
+
+	processor_dmi_check();
+
+	status = acpi_walk_namespace(ACPI_TYPE_PROCESSOR, ACPI_ROOT_OBJECT,
+				     ACPI_UINT32_MAX, acpi_processor_osc, NULL,
+				     NULL, NULL);
+	if (ACPI_FAILURE(status))
+		return status;
+
+	return acpi_get_devices(ACPI_PROCESSOR_DEVICE_HID, acpi_processor_osc,
+				NULL, NULL);
 }
 #endif
 
diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index d161ff707de4..e8d1f645224f 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -1317,9 +1317,6 @@ static int __init acpi_bus_init(void)
 		goto error1;
 	}
 
-	/* Set capability bits for _OSC under processor scope */
-	acpi_early_processor_osc();
-
 	/*
 	 * _OSC method may exist in module level code,
 	 * so it must be run after ACPI_FULL_INITIALIZATION
@@ -1335,7 +1332,15 @@ static int __init acpi_bus_init(void)
 
 	acpi_sysfs_init();
 
-	acpi_early_processor_set_pdc();
+#ifdef CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC
+	status = acpi_early_processor_osc();
+	if (ACPI_FAILURE(status)) {
+		pr_err("_OSC methods failed, trying _PDC\n");
+		acpi_early_processor_set_pdc();
+	} else {
+		pr_info("_OSC methods ran successfully\n");
+	}
+#endif
 
 	/*
 	 * Maybe EC region is required at bus_scan/acpi_get_devices. So it
diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
index f979a2f7077c..e7cc41313997 100644
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -151,17 +151,10 @@ int acpi_wakeup_device_init(void);
    -------------------------------------------------------------------------- */
 #ifdef CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC
 void acpi_early_processor_set_pdc(void);
+acpi_status acpi_early_processor_osc(void);
 
 void processor_dmi_check(void);
 bool processor_physically_present(acpi_handle handle);
-#else
-static inline void acpi_early_processor_set_pdc(void) {}
-#endif
-
-#ifdef CONFIG_X86
-void acpi_early_processor_osc(void);
-#else
-static inline void acpi_early_processor_osc(void) {}
 #endif
 
 /* --------------------------------------------------------------------------
-- 
2.41.0

