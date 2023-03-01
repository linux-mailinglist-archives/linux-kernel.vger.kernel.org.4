Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 697D66A77D1
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 00:39:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbjCAXjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 18:39:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbjCAXiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 18:38:20 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBF0D4DE15
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 15:38:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677713890; x=1709249890;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=TJtWiEKn9cKtWyiPL16X6Q+Hc9VuKWnOfoMEGJZdAM0=;
  b=CN9ZqS2A6M7CTyw2HrQ9LPPab2TAbSgoTKFV34IoPMWgHQvq4uiC/nh2
   Plw0p7q/ivDM1yCqHWh5JghApc4NZIhvSIApHSSPY45tx76us/lpmY+KS
   QAt/y0KqFWQNw8+Y5TPV7yjoyMmBk3XEPs7jZmzVngFG3vCKpAsYPAYCr
   MXiZx5QIN0Na5w0qB6inVciEclvLpC6IDFEG1kmFpnEjRNpIbBXAk2SqK
   pda73z5XBccd3vv8nV/8AC/QBM/lNW+kXoG7sMLvpYqVRRb1Wj91IcaDR
   XSS9EEsaTK1YAxvxKHVqycYCqX+plQJ/EbqvNvv7gUCAwywiI8ZDiob47
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="420818803"
X-IronPort-AV: E=Sophos;i="5.98,225,1673942400"; 
   d="scan'208";a="420818803"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 15:38:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="738826874"
X-IronPort-AV: E=Sophos;i="5.98,225,1673942400"; 
   d="scan'208";a="738826874"
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
Subject: [PATCH v7 23/24] watchdog: Introduce hardlockup_detector_mark_unavailable()
Date:   Wed,  1 Mar 2023 15:47:52 -0800
Message-Id: <20230301234753.28582-24-ricardo.neri-calderon@linux.intel.com>
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

The NMI watchdog may become unreliable during runtime. This is the case
in x86 if, for instance, the HPET-based hardlockup detector is in use and
the TSC counter becomes unstable.

Introduce a new interface to mark the hardlockup detector as unavailable
in such cases. When doing this, update the state of /proc/sys/kernel/
nmi_watchdog to keep it consistent.

Cc: Andi Kleen <ak@linux.intel.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
Cc: iommu@lists.linux-foundation.org
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Changes since v6:
 * Introduced this patch

Changes since v5:
 * N/A

Changes since v4
 * N/A

Changes since v3
 * N/A

Changes since v2:
 * N/A

Changes since v1:
 * N/A
---
 include/linux/nmi.h |  2 ++
 kernel/watchdog.c   | 20 ++++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/include/linux/nmi.h b/include/linux/nmi.h
index a38c4509f9eb..40a97139ec65 100644
--- a/include/linux/nmi.h
+++ b/include/linux/nmi.h
@@ -83,9 +83,11 @@ static inline void reset_hung_task_detector(void) { }
 
 #if defined(CONFIG_HARDLOCKUP_DETECTOR)
 extern void hardlockup_detector_disable(void);
+extern void hardlockup_detector_mark_unavailable(void);
 extern unsigned int hardlockup_panic;
 #else
 static inline void hardlockup_detector_disable(void) {}
+static inline void hardlockup_detector_mark_unavailable(void) {}
 #endif
 
 #if defined(CONFIG_HAVE_NMI_WATCHDOG) || defined(CONFIG_HARDLOCKUP_DETECTOR)
diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 8e61f21e7e33..0e4fed6d95b9 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -47,6 +47,8 @@ static int __read_mostly nmi_watchdog_available;
 struct cpumask watchdog_cpumask __read_mostly;
 unsigned long *watchdog_cpumask_bits = cpumask_bits(&watchdog_cpumask);
 
+static void __lockup_detector_reconfigure(void);
+
 #ifdef CONFIG_HARDLOCKUP_DETECTOR
 
 # ifdef CONFIG_SMP
@@ -85,6 +87,24 @@ static int __init hardlockup_panic_setup(char *str)
 }
 __setup("nmi_watchdog=", hardlockup_panic_setup);
 
+/**
+ * hardlockup_detector_mark_unavailable - Mark the NMI watchdog as unavailable
+ *
+ * Indicate that the hardlockup detector has become unavailable. This may
+ * happen if the hardware resources that the detector uses have become
+ * unreliable.
+ */
+void hardlockup_detector_mark_unavailable(void)
+{
+	mutex_lock(&watchdog_mutex);
+
+	/* These variables can be updated without stopping the detector. */
+	nmi_watchdog_user_enabled = 0;
+	nmi_watchdog_available = false;
+
+	__lockup_detector_reconfigure();
+	mutex_unlock(&watchdog_mutex);
+}
 #endif /* CONFIG_HARDLOCKUP_DETECTOR */
 
 /*
-- 
2.25.1

