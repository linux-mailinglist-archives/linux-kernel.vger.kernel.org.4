Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F12006BBC32
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 19:34:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232147AbjCOSeh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 14:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231875AbjCOSeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 14:34:15 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A6E87DA5;
        Wed, 15 Mar 2023 11:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678905254; x=1710441254;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=n16cQ4kymyynRY6n5R36txntCnbHvo09MUKHWcfcmk0=;
  b=BMtYe1nbaAgf5695fyjDZ3luVhYEZCd2/3SWosp/EWTpbdp++3PP3+w0
   ROTHdEb+bm09ONRmRkwAp5bD4Y5IFDALe10mjxyp603UvnIOQt1ZbIL63
   ejmsWax1H4ejggos+U9G7uRA6zMlReiJrkzpLyhPDFcaBbaX3FPZ3OXhg
   daxxOGz8FeyiVZz0EzsFHv8Fw1tDLIFQ6Iz1Pmrt3OiU3NQ2SdHXTMbq1
   XhHfW8MW5J0e/ynurUfsm8hDaAK5tsN41s0B5itXln6bRQG+6yVatHv9I
   RXSGt2emayU50VGXpBC8pq5AuzdZhPBQFVw2KLvRILWhdLdps1HWAkzyG
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="340154556"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="340154556"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2023 11:34:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="925435217"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="925435217"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga006.fm.intel.com with ESMTP; 15 Mar 2023 11:34:08 -0700
Received: from debox1-desk4.intel.com (unknown [10.209.75.205])
        by linux.intel.com (Postfix) with ESMTP id CF8D1580BF6;
        Wed, 15 Mar 2023 11:34:07 -0700 (PDT)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     irenic.rajneesh@gmail.com, david.e.box@linux.intel.com,
        hdegoede@redhat.com, markgross@kernel.org,
        andy.shevchenko@gmail.com, rajvi.jingar@linux.intel.com,
        xi.pardee@intel.com
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: [PATCH 07/11] platform/x86/intel/pmc: Alder Lake slp_s0_residency fix
Date:   Wed, 15 Mar 2023 11:34:01 -0700
Message-Id: <20230315183405.2465630-8-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230315183405.2465630-1-david.e.box@linux.intel.com>
References: <20230315183405.2465630-1-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
-- 
2.34.1

