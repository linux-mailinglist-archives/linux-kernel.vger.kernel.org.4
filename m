Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CE2B6C237F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 22:20:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbjCTVUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 17:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbjCTVUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 17:20:32 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA5FB2887D;
        Mon, 20 Mar 2023 14:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679347231; x=1710883231;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7xQHgXbzZUle4rIgGnDA5qyL/krFHQPTUEfjR3Qvmg8=;
  b=hqVgUx+zFEatCoEdkpRFHWfnHddunI7CQduuktFIwOzY7sxTkKRgQK5y
   p7D2zwE0ueu2A0/sSkgE863NHdsbNBGvE3KOKnm/Cem5hzUj/liT6ixAN
   MvIqb7kSVmMbnlHEaBrWsH3Z8ueSBfHv0Zfs6ptgbxS09arFWGrI3/Q36
   w2IT3DzuJddlA71nW/vLkGpP8hIdio8FG3GRmMrddaUUBajIuQEYn3rkD
   d+lyNqMekUlDFhk8RxfjPfOoffa8TW+qU16CabtBM9QW5+B60EKuzzIYf
   D01fHxwkWS9hedoQ1Z5UDIcL34AaRO4ppgmwgAXOpT+npLayaxMrA9mu0
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="337498886"
X-IronPort-AV: E=Sophos;i="5.98,276,1673942400"; 
   d="scan'208";a="337498886"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 14:20:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="674565826"
X-IronPort-AV: E=Sophos;i="5.98,276,1673942400"; 
   d="scan'208";a="674565826"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga007.jf.intel.com with ESMTP; 20 Mar 2023 14:20:31 -0700
Received: from debox1-desk4.intel.com (unknown [10.251.19.209])
        by linux.intel.com (Postfix) with ESMTP id EDEDF580110;
        Mon, 20 Mar 2023 14:20:30 -0700 (PDT)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     irenic.rajneesh@gmail.com, rajvi.jingar@linux.intel.com,
        david.e.box@linux.intel.com, hdegoede@redhat.com,
        markgross@kernel.org, andy.shevchenko@gmail.com
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: [PATCH] platform/x86/intel/pmc: Alder Lake PCH slp_s0_residency fix
Date:   Mon, 20 Mar 2023 14:20:29 -0700
Message-Id: <20230320212029.3154407-1-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.34.1
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

From: Rajvi Jingar <rajvi.jingar@linux.intel.com>

For platforms with Alder Lake PCH (Alder Lake S and Raptor Lake S) the
slp_s0_residency attribute has been reporting the wrong value. Unlike other
platforms, ADL PCH does not have a counter for the time that the SLP_S0
signal was asserted. Instead, firmware uses the aggregate of the Low Power
Mode (LPM) substate counters as the S0ix value.  Since the LPM counters run
at a different frequency, this lead to misreporting of the S0ix time.

Add a check for Alder Lake PCH and adjust the frequency accordingly when
display slp_s0_residency.

Fixes: bbab31101f44 ("platform/x86/intel: pmc/core: Add Alderlake support to pmc core driver")
Signed-off-by: Rajvi Jingar <rajvi.jingar@linux.intel.com>
Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---
 drivers/platform/x86/intel/pmc/core.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
index e489d2175e42..61ca7c37fb02 100644
--- a/drivers/platform/x86/intel/pmc/core.c
+++ b/drivers/platform/x86/intel/pmc/core.c
@@ -66,7 +66,18 @@ static inline void pmc_core_reg_write(struct pmc_dev *pmcdev, int reg_offset,
 
 static inline u64 pmc_core_adjust_slp_s0_step(struct pmc_dev *pmcdev, u32 value)
 {
-	return (u64)value * pmcdev->map->slp_s0_res_counter_step;
+	/*
+	 * ADL PCH does not have the SLP_S0 counter and LPM Residency counters are
+	 * used as a workaround which uses 30.5 usec tick. All other client
+	 * programs have the legacy SLP_S0 residency counter that is using the 122
+	 * usec tick.
+	 */
+	const int lpm_adj_x2 = pmcdev->map->lpm_res_counter_step_x2;
+
+	if (pmcdev->map == &adl_reg_map)
+		return (u64)value * GET_X2_COUNTER((u64)lpm_adj_x2);
+	else
+		return (u64)value * pmcdev->map->slp_s0_res_counter_step;
 }
 
 static int set_etr3(struct pmc_dev *pmcdev)

base-commit: 02c464b73645404654359ad21f368a13735e2850
-- 
2.34.1

