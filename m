Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A2456A77CB
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 00:38:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbjCAXiu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 18:38:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbjCAXiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 18:38:13 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76AF0191
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 15:38:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677713886; x=1709249886;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=7e3va9vu9qwj2yqdORjxuaJ7bdwskL9Kry8TAY9yGpM=;
  b=kLMismFmccNqXMTR9+TGPOKBXXk6J75ZV7zHYJAuMTzWyaDbU4Z4jw1Y
   p0jpsD4f4ugbwsdXCjOR110N5zZd7EpggcdlDrNs6NjCOu4Jhtdh+R038
   HXQfFk7NsOp/cLsnb04an5lmzSbB5Ma/GlzYlFANpM02Qxo7dUL85uMOd
   Vuh6/KWv5JFawH3aUwqNF8IDfIWQNj5v7iS+U2SsimxUzYjFLunEVzPpV
   xBBhBNS30H4vj+fmIFQOtlved7BlJFUifdtn3KBe3EyURLNsxaBF+/iaV
   YSgw25ued7DnSbO+uZ0odDcz3EuTVsvsDg1hnf63LkHE9Vh/cbN0C5agv
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="420818761"
X-IronPort-AV: E=Sophos;i="5.98,225,1673942400"; 
   d="scan'208";a="420818761"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 15:37:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="738826849"
X-IronPort-AV: E=Sophos;i="5.98,225,1673942400"; 
   d="scan'208";a="738826849"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga008.fm.intel.com with ESMTP; 01 Mar 2023 15:37:59 -0800
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
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v7 16/24] watchdog/hardlockup: Define a generic function to detect hardlockups
Date:   Wed,  1 Mar 2023 15:47:45 -0800
Message-Id: <20230301234753.28582-17-ricardo.neri-calderon@linux.intel.com>
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

The procedure to detect hardlockups is independent of the source of the
the non-maskable interrupt that drives it. Place it in a separate, generic
function to be invoked by various implementations of the NMI watchdog.

Move the bulk of watchdog_overflow_callback() to the new function
inspect_for_hardlockups(). This function can then be called from the
applicable NMI handlers. No functional changes.

Cc: Andi Kleen <ak@linux.intel.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
Cc: iommu@lists.linux-foundation.org
Cc: linuxppc-dev@lists.ozlabs.org
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Changes since v6:
 * None

Changes since v5:
 * None

Changes since v4:
 * None

Changes since v3:
 * None

Changes since v2:
 * None

Changes since v1:
 * None
---
 include/linux/nmi.h   |  1 +
 kernel/watchdog_hld.c | 18 +++++++++++-------
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/include/linux/nmi.h b/include/linux/nmi.h
index 048c0b9aa623..75038cb2710e 100644
--- a/include/linux/nmi.h
+++ b/include/linux/nmi.h
@@ -209,6 +209,7 @@ int proc_nmi_watchdog(struct ctl_table *, int , void *, size_t *, loff_t *);
 int proc_soft_watchdog(struct ctl_table *, int , void *, size_t *, loff_t *);
 int proc_watchdog_thresh(struct ctl_table *, int , void *, size_t *, loff_t *);
 int proc_watchdog_cpumask(struct ctl_table *, int, void *, size_t *, loff_t *);
+void inspect_for_hardlockups(struct pt_regs *regs);
 
 #ifdef CONFIG_HAVE_ACPI_APEI_NMI
 #include <asm/nmi.h>
diff --git a/kernel/watchdog_hld.c b/kernel/watchdog_hld.c
index 247bf0b1582c..b352e507b17f 100644
--- a/kernel/watchdog_hld.c
+++ b/kernel/watchdog_hld.c
@@ -106,14 +106,8 @@ static struct perf_event_attr wd_hw_attr = {
 	.disabled	= 1,
 };
 
-/* Callback function for perf event subsystem */
-static void watchdog_overflow_callback(struct perf_event *event,
-				       struct perf_sample_data *data,
-				       struct pt_regs *regs)
+void inspect_for_hardlockups(struct pt_regs *regs)
 {
-	/* Ensure the watchdog never gets throttled */
-	event->hw.interrupts = 0;
-
 	if (__this_cpu_read(watchdog_nmi_touch) == true) {
 		__this_cpu_write(watchdog_nmi_touch, false);
 		return;
@@ -163,6 +157,16 @@ static void watchdog_overflow_callback(struct perf_event *event,
 	return;
 }
 
+/* Callback function for perf event subsystem */
+static void watchdog_overflow_callback(struct perf_event *event,
+				       struct perf_sample_data *data,
+				       struct pt_regs *regs)
+{
+	/* Ensure the watchdog never gets throttled */
+	event->hw.interrupts = 0;
+	inspect_for_hardlockups(regs);
+}
+
 static int hardlockup_detector_event_create(void)
 {
 	unsigned int cpu = smp_processor_id();
-- 
2.25.1

