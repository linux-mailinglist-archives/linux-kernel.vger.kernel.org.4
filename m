Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58EF8637869
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 13:03:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbiKXMDY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 07:03:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbiKXMDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 07:03:01 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9182A5ADE8;
        Thu, 24 Nov 2022 04:02:59 -0800 (PST)
Date:   Thu, 24 Nov 2022 12:02:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669291378;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8ef96xZAPR2NhzOZjjgPf5exhDtysRveXtabXSfWMkk=;
        b=UHrRhu40rWAAf5CrOQZQM831XdVhtrbeqdeX9tYXqPTwbg99HB35E6PRcxVG9XrQ34U+hI
        n3svGd8fyISr5aRhHLXp0gt3AHbUQDnUGskYhF/KgTNPscDxKUlmlo9MjFHFyJ0uB3RH43
        eZwLJEC1prXvUeH6tyiWzOmNE7XpD1MBTxPM2viRSdUF/HWTW65CNuY9lAJ5weML0mdG7S
        MoxVXosbGS1FLjOyDhLA8GzpVbdSYP2N+zowHJr6ZZbPNqw7XpF/utbC/vOgcyh4olf7ZI
        D4xnzskkzVNJdmnooM3PgQ/McSqr5N9eOjxNHE+8vjxHuXPc1asCdATmTN1/IQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669291378;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8ef96xZAPR2NhzOZjjgPf5exhDtysRveXtabXSfWMkk=;
        b=Ylaq+xJPy9f8U5GNZVcE9maFkUfoJrDZz8L5y2hwNKwCYu6riFRM0VtoZZcModH9qNI5Sm
        VAGE0L/tU5RgtiCg==
From:   "tip-bot2 for Alexander Antonov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel/uncore: Generalize get_topology() for
 SKX PMUs
Cc:     Alexander Antonov <alexander.antonov@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Kan Liang <kan.liang@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221117122833.3103580-6-alexander.antonov@linux.intel.com>
References: <20221117122833.3103580-6-alexander.antonov@linux.intel.com>
MIME-Version: 1.0
Message-ID: <166929137695.4906.15833482649561923555.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     07813e2a59c93f10716ffa33d608d2c0685cf85b
Gitweb:        https://git.kernel.org/tip/07813e2a59c93f10716ffa33d608d2c0685cf85b
Author:        Alexander Antonov <alexander.antonov@linux.intel.com>
AuthorDate:    Thu, 17 Nov 2022 12:28:27 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 24 Nov 2022 11:09:22 +01:00

perf/x86/intel/uncore: Generalize get_topology() for SKX PMUs

Factor out a generic code from skx_iio_get_topology() to skx_pmu_get_topology()
to avoid code duplication. This code will be used by get_topology() procedure
for SKX UPI PMUs in the further patch.

Signed-off-by: Alexander Antonov <alexander.antonov@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Link: https://lore.kernel.org/r/20221117122833.3103580-6-alexander.antonov@linux.intel.com
---
 arch/x86/events/intel/uncore_snbep.c | 38 +++++++++++++++++++--------
 1 file changed, 28 insertions(+), 10 deletions(-)

diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index e14b963..254ba0a 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -3837,14 +3837,14 @@ static void pmu_free_topology(struct intel_uncore_type *type)
 	}
 }
 
-static int skx_iio_get_topology(struct intel_uncore_type *type)
+static int skx_pmu_get_topology(struct intel_uncore_type *type,
+				 int (*topology_cb)(struct intel_uncore_type*, int, int, u64))
 {
 	int die, ret = -EPERM;
-	u64 configuration;
-	int idx;
+	u64 cpu_bus_msr;
 
 	for (die = 0; die < uncore_max_dies(); die++) {
-		ret = skx_msr_cpu_bus_read(die_to_cpu(die), &configuration);
+		ret = skx_msr_cpu_bus_read(die_to_cpu(die), &cpu_bus_msr);
 		if (ret)
 			break;
 
@@ -3852,17 +3852,35 @@ static int skx_iio_get_topology(struct intel_uncore_type *type)
 		if (ret < 0)
 			break;
 
-		for (idx = 0; idx < type->num_boxes; idx++) {
-			type->topology[die][idx].pmu_idx = idx;
-			type->topology[die][idx].iio->segment = ret;
-			type->topology[die][idx].iio->pci_bus_no =
-				(configuration >> (idx * BUS_NUM_STRIDE)) & 0xff;
-		}
+		ret = topology_cb(type, ret, die, cpu_bus_msr);
+		if (ret)
+			break;
 	}
 
 	return ret;
 }
 
+static int skx_iio_topology_cb(struct intel_uncore_type *type, int segment,
+				int die, u64 cpu_bus_msr)
+{
+	int idx;
+	struct intel_uncore_topology *t;
+
+	for (idx = 0; idx < type->num_boxes; idx++) {
+		t = &type->topology[die][idx];
+		t->pmu_idx = idx;
+		t->iio->segment = segment;
+		t->iio->pci_bus_no = (cpu_bus_msr >> (idx * BUS_NUM_STRIDE)) & 0xff;
+	}
+
+	return 0;
+}
+
+static int skx_iio_get_topology(struct intel_uncore_type *type)
+{
+	return skx_pmu_get_topology(type, skx_iio_topology_cb);
+}
+
 static struct attribute_group skx_iio_mapping_group = {
 	.is_visible	= skx_iio_mapping_visible,
 };
