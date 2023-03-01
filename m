Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 203D86A77CE
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 00:39:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbjCAXjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 18:39:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbjCAXiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 18:38:14 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E62994109C
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 15:38:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677713889; x=1709249889;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=OqhPN6kNm1+6G6yIlNPIASa1IBCFVuZdDvhvGUbI0q8=;
  b=mGGKiJ8656qcKHEVk2HuleYl4YvAhOPW0pgtz2MhJAI8Wa4y1uyQAzN/
   v3UPUm5NYEAiQK9osQYoE5zuidaaGgLwaEhvViNxfK2KdCgEle7sBN4Rz
   IkCxlmjpGYsr0EDrGxGzbFXV4Zqg797ct0+HsrhxdCwR7nYVHUFFzMtcT
   7Dc6QUeWQAO5pAFo7enjsHF2f8ko6e9IDSYLllp8fwH2NlO201LsJvm0+
   xDeZd0hmEfklfsnfiSnxk5RxrSFzneqJbJYA6z5xpek5ah1rogQT2Hx3P
   j1PvS/yUjALJH9ubGwWdA0Jepj4TWzJStLWuAx5H1AMl8XD3fkHO5IBx4
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="420818794"
X-IronPort-AV: E=Sophos;i="5.98,225,1673942400"; 
   d="scan'208";a="420818794"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 15:38:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="738826868"
X-IronPort-AV: E=Sophos;i="5.98,225,1673942400"; 
   d="scan'208";a="738826868"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga008.fm.intel.com with ESMTP; 01 Mar 2023 15:38:00 -0800
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Len Brown <len.brown@intel.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        linuxppc-dev@lists.ozlabs.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Subject: [PATCH v7 21/24] watchdog/hardlockup/hpet: Only enable the HPET watchdog via a boot parameter
Date:   Wed,  1 Mar 2023 15:47:50 -0800
Message-Id: <20230301234753.28582-22-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230301234753.28582-1-ricardo.neri-calderon@linux.intel.com>
References: <20230301234753.28582-1-ricardo.neri-calderon@linux.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Keep the HPET-based hardlockup detector disabled unless explicitly enabled
via a command-line argument. If such parameter is not given, the
initialization of the HPET-based hardlockup detector fails and the NMI
watchdog will fall back to use the perf-based implementation.

Cc: Andi Kleen <ak@linux.intel.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
Cc: iommu@lists.linux-foundation.org
Cc: linuxppc-dev@lists.ozlabs.org
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
--
Changes since v6:
 * Do not reuse the nmi_watchdog command line option. Instead, use a
   separate command line option. (Nicholas Piggin)
 * Document conflict with conflict between `hpet_nmi_watchdog` and
   `nohz_full` and dependency on `no_ipi_broadcast`.

Changes since v5:
 * None

Changes since v4:
 * None

Changes since v3:
 * None

Changes since v2:
 * Do not imply that using nmi_watchdog=hpet means the detector is
   enabled. Instead, print a warning in such case.

Changes since v1:
 * Added documentation to the function handing the nmi_watchdog
   kernel command-line argument.
---
 Documentation/admin-guide/kernel-parameters.txt |  8 ++++++++
 arch/x86/kernel/watchdog_hld_hpet.c             | 17 +++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 46268d6baa43..2d1262bb99c7 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1708,6 +1708,14 @@
 	hpet_mmap=	[X86, HPET_MMAP] Allow userspace to mmap HPET
 			registers.  Default set by CONFIG_HPET_MMAP_DEFAULT.
 
+	hpet_nmi_watchdog [X86, KNL]
+			Drive the NMI watchdog with an HPET channel. This option
+			has no effect if the NMI watchdog is not enabled.
+			The HPET NMI watchdog conflicts with the parameters
+			nohz_full, no_ipi_broadcast, and hpet=disable. If any
+			of these parameters is present the NMI watchdog will
+			fall back to the perf-driven implementation.
+
 	hugepages=	[HW] Number of HugeTLB pages to allocate at boot.
 			If this follows hugepagesz (below), it specifies
 			the number of pages of hugepagesz to be allocated.
diff --git a/arch/x86/kernel/watchdog_hld_hpet.c b/arch/x86/kernel/watchdog_hld_hpet.c
index a03126e02eda..0fc728ad6f15 100644
--- a/arch/x86/kernel/watchdog_hld_hpet.c
+++ b/arch/x86/kernel/watchdog_hld_hpet.c
@@ -39,6 +39,7 @@
 #include "apic/local.h"
 
 static struct hpet_hld_data *hld_data;
+static bool hardlockup_use_hpet;
 static u64 tsc_next_error;
 
 static void __init setup_hpet_channel(struct hpet_hld_data *hdata)
@@ -366,6 +367,19 @@ void hardlockup_detector_hpet_start(void)
 	enable_timer(hld_data);
 }
 
+/**
+ * hardlockup_detector_hpet_setup() - Parse command-line parameters
+ * @str:	A string containing the kernel command line
+ *
+ * If selected by the user, enable this hardlockup detector.
+ */
+static int __init hardlockup_detector_hpet_setup(char *str)
+{
+	hardlockup_use_hpet = true;
+	return 1;
+}
+__setup("hpet_nmi_watchdog", hardlockup_detector_hpet_setup);
+
 static const char hpet_hld_init_failed[] = "Initialization failed:";
 
 /**
@@ -382,6 +396,9 @@ int __init hardlockup_detector_hpet_init(void)
 {
 	int ret;
 
+	if (!hardlockup_use_hpet)
+		return -ENODEV;
+
 	if (!is_hpet_enabled()) {
 		pr_info("%s HPET unavailable\n", hpet_hld_init_failed);
 		return -ENODEV;
-- 
2.25.1

