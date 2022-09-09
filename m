Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA415B42D8
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Sep 2022 01:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232010AbiIIXHb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 19:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231419AbiIIXGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 19:06:48 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D0831153A3
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 16:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662764797; x=1694300797;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=CwP0yLdD5IOcRYascjBO09AMkETiFtnfwLcTZhiigTk=;
  b=DaS/wBndgIPN/GAau4vdQcrvafXwlBCnFCp5CYJOhwm9tTyujm+h3gXp
   kcXYUgC8nXywmxMIx1+plhr5n5kJlzQE3JVbFk7zHBEjgNSCOqH63NfjB
   4ueweSP5TD72n61CTWo1lPqBHAExwWIrh+E3dVSOItX9saZfSu9/ynXzg
   Ozfxljh2XXrKfntAHYIAXWjEBsu3r0I+6JA8eWs4H/MNY1lyvl0+1cO7T
   TTp0JFQYL2yO1sbQM/CNxaPtFIdrO4uHK5SI4EKMSS+wd18ZOQzUEcAii
   +EPalVUT3y55U2KYYrovKKL0LDM112C8JTMA9qgmIrvpawc9U4BToVuQm
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10465"; a="298386916"
X-IronPort-AV: E=Sophos;i="5.93,304,1654585200"; 
   d="scan'208";a="298386916"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2022 16:06:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,304,1654585200"; 
   d="scan'208";a="677355010"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga008.fm.intel.com with ESMTP; 09 Sep 2022 16:06:34 -0700
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
Subject: [RFC PATCH 12/23] thermal: intel: hfi: Convert table_lock to use flags-handling variants
Date:   Fri,  9 Sep 2022 16:11:54 -0700
Message-Id: <20220909231205.14009-13-ricardo.neri-calderon@linux.intel.com>
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

Currently, the table of an HFI instance is only accessed from the HFI
thermal interrupt handler and from the delayed work that sends the thermal
netlink event to user space.

When using Intel Thread Director to support classes of tasks in the
scheduler, the HFI table will also be accessed from the timer interrupt
handler.

As two interrupt handlers will concurrently access the table, update locks
to use raw_spin_[un]lock_irq[save|restore].

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
 drivers/thermal/intel/intel_hfi.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/intel/intel_hfi.c b/drivers/thermal/intel/intel_hfi.c
index 405495dad0b2..4bafe6848d5d 100644
--- a/drivers/thermal/intel/intel_hfi.c
+++ b/drivers/thermal/intel/intel_hfi.c
@@ -175,9 +175,10 @@ static struct workqueue_struct *hfi_updates_wq;
 static void get_hfi_caps(struct hfi_instance *hfi_instance,
 			 struct thermal_genl_cpu_caps *cpu_caps)
 {
+	unsigned long flags;
 	int cpu, i = 0;
 
-	raw_spin_lock_irq(&hfi_instance->table_lock);
+	raw_spin_lock_irqsave(&hfi_instance->table_lock, flags);
 	for_each_cpu(cpu, hfi_instance->cpus) {
 		struct hfi_cpu_data *caps;
 		s16 index;
@@ -199,7 +200,7 @@ static void get_hfi_caps(struct hfi_instance *hfi_instance,
 
 		++i;
 	}
-	raw_spin_unlock_irq(&hfi_instance->table_lock);
+	raw_spin_unlock_irqrestore(&hfi_instance->table_lock, flags);
 }
 
 /*
@@ -262,6 +263,7 @@ void intel_hfi_process_event(__u64 pkg_therm_status_msr_val)
 	struct hfi_instance *hfi_instance;
 	int cpu = smp_processor_id();
 	struct hfi_cpu_info *info;
+	unsigned long flags;
 	u64 new_timestamp;
 
 	if (!pkg_therm_status_msr_val)
@@ -298,7 +300,7 @@ void intel_hfi_process_event(__u64 pkg_therm_status_msr_val)
 		return;
 	}
 
-	raw_spin_lock(&hfi_instance->table_lock);
+	raw_spin_lock_irqsave(&hfi_instance->table_lock, flags);
 
 	/*
 	 * Copy the updated table into our local copy. This includes the new
@@ -307,7 +309,7 @@ void intel_hfi_process_event(__u64 pkg_therm_status_msr_val)
 	memcpy(hfi_instance->local_table, hfi_instance->hw_table,
 	       hfi_features.nr_table_pages << PAGE_SHIFT);
 
-	raw_spin_unlock(&hfi_instance->table_lock);
+	raw_spin_unlock_irqrestore(&hfi_instance->table_lock, flags);
 	raw_spin_unlock(&hfi_instance->event_lock);
 
 	/*
-- 
2.25.1

