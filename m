Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F17025E6CDB
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 22:15:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232490AbiIVUPr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 16:15:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232367AbiIVUPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 16:15:45 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7342A026D
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 13:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663877744; x=1695413744;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UKrj8Pz/BHLPd/5kjb6wZYPYya+vQWgLKd+9jKqnjWU=;
  b=dm3g5OZQEV/xziCYmUiwJy2EInadLj0EDBOGoum99vSVcPe+TFrlQWFd
   oTRbxb5eJ5uncTwU2JSWHmZsvQesnYMCU/BhnG51uhP57BQzgzFVpOTpI
   MBN+bJ5VPR9vs/mt3lpt8JGz15uvvrnmmfosvad8iitBbYXh3kiWHEWc3
   tfB+mWWAeMkFAf3uRgwz97JrTtxlXfYKs/wMcnN4PxS1Ym+d4sbdlu1VB
   amOJ0nCdFEFkqpiGdUR3qLN+2HZF47PCblOCE39oTMjNKIMHrVi0gOGN7
   vpsYSMvalHalp+VCJCRyaGr0pGhrIe9Fq/0uP9FetcXybPB9+4AN7z74/
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10478"; a="301297377"
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="301297377"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 13:15:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="682378312"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmsmga008.fm.intel.com with ESMTP; 22 Sep 2022 13:15:02 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, joe.jin@oracle.com, likexu@tencent.com,
        dongli.zhang@oracle.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH] perf/x86/intel: Hide Topdown metrics events if slots is not enumerated
Date:   Thu, 22 Sep 2022 13:15:05 -0700
Message-Id: <20220922201505.2721654-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The below error is observed on Ice Lake VM.

$ perf stat
Error:
The sys_perf_event_open() syscall returned with 22 (Invalid argument)
for event (slots).
/bin/dmesg | grep -i perf may provide additional information.

In a virtualization env, the Topdown metrics and the slots event haven't
been supported yet. The guest CPUID doesn't enumerate them. However, the
current kernel unconditionally exposes the slots event and the Topdown
metrics events to sysfs, which misleads the perf tool and triggers the
error.

Hide the perf metrics topdown events and the slots event if the slots
event is not enumerated.

The big core of a hybrid platform can also supports the perf-metrics
feature. Fix the hybrid platform as well.

Reported-by: Dongli Zhang <dongli.zhang@oracle.com>
Tested-by: Dongli Zhang <dongli.zhang@oracle.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/core.c | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index b16c91ac9219..a0a62b67c440 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -5335,6 +5335,19 @@ static struct attribute *intel_pmu_attrs[] = {
 	NULL,
 };
 
+static umode_t
+td_is_visible(struct kobject *kobj, struct attribute *attr, int i)
+{
+	/*
+	 * Hide the perf metrics topdown events
+	 * if the slots is not enumerated.
+	 */
+	if (x86_pmu.num_topdown_events)
+		return (x86_pmu.intel_ctrl & INTEL_PMC_MSK_FIXED_SLOTS) ? attr->mode : 0;
+
+	return attr->mode;
+}
+
 static umode_t
 tsx_is_visible(struct kobject *kobj, struct attribute *attr, int i)
 {
@@ -5370,6 +5383,7 @@ default_is_visible(struct kobject *kobj, struct attribute *attr, int i)
 
 static struct attribute_group group_events_td  = {
 	.name = "events",
+	.is_visible = td_is_visible,
 };
 
 static struct attribute_group group_events_mem = {
@@ -5522,6 +5536,23 @@ static inline int hybrid_find_supported_cpu(struct x86_hybrid_pmu *pmu)
 	return (cpu >= nr_cpu_ids) ? -1 : cpu;
 }
 
+static umode_t hybrid_td_is_visible(struct kobject *kobj,
+					struct attribute *attr, int i)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct x86_hybrid_pmu *pmu =
+		 container_of(dev_get_drvdata(dev), struct x86_hybrid_pmu, pmu);
+
+	if (!is_attr_for_this_pmu(kobj, attr))
+		return 0;
+
+	/* Only check the big core which supports perf metrics */
+	if (pmu->cpu_type == hybrid_big)
+		return (pmu->intel_ctrl & INTEL_PMC_MSK_FIXED_SLOTS) ? attr->mode : 0;
+
+	return attr->mode;
+}
+
 static umode_t hybrid_tsx_is_visible(struct kobject *kobj,
 				     struct attribute *attr, int i)
 {
@@ -5548,7 +5579,7 @@ static umode_t hybrid_format_is_visible(struct kobject *kobj,
 
 static struct attribute_group hybrid_group_events_td  = {
 	.name		= "events",
-	.is_visible	= hybrid_events_is_visible,
+	.is_visible	= hybrid_td_is_visible,
 };
 
 static struct attribute_group hybrid_group_events_mem = {
-- 
2.35.1

