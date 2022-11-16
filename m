Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DCCC62CE96
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 00:16:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233056AbiKPXQj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 18:16:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231126AbiKPXQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 18:16:37 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A9C10FE8;
        Wed, 16 Nov 2022 15:16:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668640596; x=1700176596;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qqwWgejappy/k3mRhaxSaxdFyg89ME16FnWhZAGgCI8=;
  b=AkpUu9MgA5QmBqs9o/a5WDYexpyLpsHsRxxDCeeoJPc1mqV75z0FDnAJ
   ntZFVhzfZBNYhyk+HsU1IqlseMsv+CSMlBCbYT9aTaRNC8kiw2d3TVnZu
   GqL7W09AGGT97wiCOu7CuHHF7UHQvZIpB7DQSmoGuwgJKgVo5aFDpmyZX
   7GILg3ydNrILxx1xMYqWlUmOljraxg8t7euinBFL1ChxAg59WyOnDEPuc
   Dkhz6+86aHwGASxGZ+VBkpmOj17aCbn/5B9swM3bfWLxZG3MXKQP9H69u
   +Hd0HygBUNxtL5avL5SJp2cxNiXPIqgILG2xIQiTQZFJNUnLePPCQBQQP
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="398981913"
X-IronPort-AV: E=Sophos;i="5.96,169,1665471600"; 
   d="scan'208";a="398981913"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2022 15:15:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="764516508"
X-IronPort-AV: E=Sophos;i="5.96,169,1665471600"; 
   d="scan'208";a="764516508"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by orsmga004.jf.intel.com with ESMTP; 16 Nov 2022 15:15:02 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     rafael@kernel.org, daniel.lezcano@linaro.org, amitk@kernel.org,
        rui.zhang@intel.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Arshad@vger.kernel.org, Adeel <adeel.arshad@intel.com>
Subject: [PATCH] thermal: intel: hfi: ACK HFI for the same timestamp
Date:   Wed, 16 Nov 2022 15:14:59 -0800
Message-Id: <20221116231459.2632710-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some processors issue more than one HFI interrupt with the same
timestamp. Each interrupt must be acknowledged to let the hardware issue
new HFI interrupts. But this can't be done without some additional flow
modification in the existing interrupt handling.

For background, the HFI interrupt is a package level thermal interrupt
delivered via a LVT. This LVT is common for both the CPU and package
level interrupts. Hence, all CPUs receive the HFI interrupts. But only
one CPU should process interrupt and others simply exit by issuing EOI
to LAPIC.

The current HFI interrupt processing flow:

1. Receive Thermal interrupt
2. Check if there is an active HFI status in MSR_IA32_THERM_STATUS
3. Try and get spinlock, one CPU will enter spinlock and others
will simply return from here to issue EOI.
   (Let's assume CPU 4 is processing interrupt)
4. Check the stored time-stamp from the HFI memory time-stamp
5. if same
6.      ignore interrupt, unlock and return
7. Copy the HFI message to local buffer
8. unlock spinlock
9. ACK HFI interrupt
10. Queue the message for processing in a work-queue

It is tempting to simply acknowledge all the interrupts even if they
have the same timestamp. This may cause some interrupts to not be
processed.

Let's say CPU5 is slightly late and reaches step 4 while CPU4 is
between steps 8 and 9.

Currently we simply ignore interrupts with the same timestamp. No
issue here for CPU5. When CPU4 acknowledges the interrupt, the next
HFI interrupt can be delivered.

If we acknowledge interrupts with the same timestamp (at step 6), there
is a race condition. Under the same scenario, CPU 5 will acknowledge
the HFI interrupt. This lets hardware generate another HFI interrupt,
before CPU 4 start executing step 9. Once CPU 4 complete step 9, it
will acknowledge the newly arrived HFI interrupt, without actually
processing it.

Acknowledge the interrupt when holding the spinlock. This avoids
contention of the interrupt acknowledgment.

Updated flow:

1. Receive HFI Thermal interrupt
2. Check if there is an active HFI status in MSR_IA32_THERM_STATUS
3. Try and get spin-lock
   Let's assume CPU 4 is processing interrupt
4.1 Read MSR_IA32_PACKAGE_THERM_STATUS and check HFI status bit
4.2	If hfi status is 0
4.3		unlock spinlock
4.4		return
4.5 Check the stored time-stamp from the HFI memory time-stamp
5. if same
6.1      ACK HFI Interrupt,
6.2	unlock spinlock
6.3	return
7. Copy the HFI message to local buffer
8. ACK HFI interrupt
9. unlock spinlock
10. Queue the message for processing in a work-queue

To avoid taking the lock unnecessarily, intel_hfi_process_event() checks
the status of the HFI interrupt before taking the lock. If CPU5 is late,
when it starts processing the interrupt there are two scenarios:

a) CPU4 acknowledged the HFI interrupt before CPU5 read
MSR_IA32_THERM_STATUS. CPU5 exits.

b) CPU5 reads MSR_IA32_THERM_STATUS before CPU4 has acknowledged the
interrupt. CPU5 will take the lock if CPU4 has released it. It then
re-reads MSR_IA32_THERM_STATUS. If there is not a new interrupt, the HFI
status bit is clear and CPU5 exits. If a new HFI interrupt was generated
it will find that the status bit is set and it will continue to process
the interrupt. In this case even if timestamp is not changed, the ACK
can be issued as this is a new interrupt.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Reviewed-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Tested-by: Arshad, Adeel<adeel.arshad@intel.com>
---
This patch depends on two other patches posted before:
[PATCH RESEND 1/2] thermal: intel: Prevent accidental clearing of HFI status
[PATCH RESEND 2/2] thermal: intel: Protect clearing of thermal status bits

 drivers/thermal/intel/intel_hfi.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/intel/intel_hfi.c b/drivers/thermal/intel/intel_hfi.c
index c9e0827c9ebe..c543a967cd50 100644
--- a/drivers/thermal/intel/intel_hfi.c
+++ b/drivers/thermal/intel/intel_hfi.c
@@ -250,7 +250,7 @@ void intel_hfi_process_event(__u64 pkg_therm_status_msr_val)
 	struct hfi_instance *hfi_instance;
 	int cpu = smp_processor_id();
 	struct hfi_cpu_info *info;
-	u64 new_timestamp;
+	u64 new_timestamp, msr, hfi;
 
 	if (!pkg_therm_status_msr_val)
 		return;
@@ -279,9 +279,21 @@ void intel_hfi_process_event(__u64 pkg_therm_status_msr_val)
 	if (!raw_spin_trylock(&hfi_instance->event_lock))
 		return;
 
-	/* Skip duplicated updates. */
+	rdmsrl(MSR_IA32_PACKAGE_THERM_STATUS, msr);
+	hfi = msr & PACKAGE_THERM_STATUS_HFI_UPDATED;
+	if (!hfi) {
+		raw_spin_unlock(&hfi_instance->event_lock);
+		return;
+	}
+
+	/*
+	 * Ack duplicate update. Since there is an active HFI
+	 * status from HW, it must be a new event, not a case
+	 * where a lagging CPU entered the locked region.
+	 */
 	new_timestamp = *(u64 *)hfi_instance->hw_table;
 	if (*hfi_instance->timestamp == new_timestamp) {
+		thermal_clear_package_intr_status(PACKAGE_LEVEL, PACKAGE_THERM_STATUS_HFI_UPDATED);
 		raw_spin_unlock(&hfi_instance->event_lock);
 		return;
 	}
@@ -295,15 +307,15 @@ void intel_hfi_process_event(__u64 pkg_therm_status_msr_val)
 	memcpy(hfi_instance->local_table, hfi_instance->hw_table,
 	       hfi_features.nr_table_pages << PAGE_SHIFT);
 
-	raw_spin_unlock(&hfi_instance->table_lock);
-	raw_spin_unlock(&hfi_instance->event_lock);
-
 	/*
 	 * Let hardware know that we are done reading the HFI table and it is
 	 * free to update it again.
 	 */
 	thermal_clear_package_intr_status(PACKAGE_LEVEL, PACKAGE_THERM_STATUS_HFI_UPDATED);
 
+	raw_spin_unlock(&hfi_instance->table_lock);
+	raw_spin_unlock(&hfi_instance->event_lock);
+
 	queue_delayed_work(hfi_updates_wq, &hfi_instance->update_work,
 			   HFI_UPDATE_INTERVAL);
 }
-- 
2.31.1

