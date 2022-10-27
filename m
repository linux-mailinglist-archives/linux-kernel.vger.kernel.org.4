Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD98560FF39
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 19:20:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234425AbiJ0RUF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 13:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233619AbiJ0RUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 13:20:01 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23EEC303D0;
        Thu, 27 Oct 2022 10:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666891197; x=1698427197;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=uLUbt4+uG5KMwbCnM+TCrogE8RgHzw0WgZnOBwJ7M2U=;
  b=h//Q2r+EbsDa/1M0DJeKCIebSBUG13lleQocZE4TFly41rFeRNfuv2h7
   C9dR6AqDnKievhQhONXUst+bvoTAIMQ0J3bGm1zeCsxaM1CM68T0lBu2H
   9Cx4o8b/MSvQZ8oFlPU9T9jYcCMC6Fwc9cyFX4IVMPrT3hlgjybzMUNwI
   reQ9ZmUY1GzdyENHOaH0oTYt4ofh6cR3jQGxe164wi0OxAJHF7+poqwan
   j9zc50X9todebTbGnin4S5VpbYT4WjaOZ0IJ8/FHKzl5+s1CVmFUgNIfL
   Q4PwiQxlnp+g6S6DaFge/WfPRFHKXah2liorXJEh+pG05xqrpoZBzgVzN
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10513"; a="309984236"
X-IronPort-AV: E=Sophos;i="5.95,218,1661842800"; 
   d="scan'208";a="309984236"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2022 10:19:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10513"; a="634988307"
X-IronPort-AV: E=Sophos;i="5.95,218,1661842800"; 
   d="scan'208";a="634988307"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by fmsmga007.fm.intel.com with ESMTP; 27 Oct 2022 10:19:54 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     rafael@kernel.org, lenb@kernel.org, viresh.kumar@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] cpufreq: intel_pstate: Allow EPP 0x80 setting by the firmware
Date:   Thu, 27 Oct 2022 10:19:47 -0700
Message-Id: <20221027171947.1465343-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the
"commit 3d13058ed2a6 ("cpufreq: intel_pstate: Use firmware default EPP")"
the firmware can set an EPP, which driver will not overwrite. But the
driver has a valid range check for:
0x40 > firmware epp < 0x80.
Hence firmware can't specify EPP of 0x80.

If the firmware didn't specify in the valid range, the driver has a
hard coded EPP of 102. But some Chrome hardware vendors don't want
this overwrite and wants to boot with chipset default EPP of 0x80 as
this improves battery life.

In this case they want to have capability to specify EPP of 0x80 via
the firmware. This require the valid range to include 0x80 also.
But here the valid range can't be simply extended to include 0x80 as
this is the chipset default EPP. Even without any firmware specifying
EPP, the chipset will always boot with EPP of 0x80.

To make sure that firmware specified EPP of 0x80 and not by the
chipset default, it will require additional check to make sure HWP
was enabled by the firmware before boot. Only way the firmware can
update EPP, is to enable HWP and update EPP via MSR_HWP_REQUEST.

This driver already checks, if the HWP is enabled by the firmware.
Use the same flag and extend valid range to include 0x80.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/cpufreq/intel_pstate.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index fc3ebeb0bbe5..c41875abd8be 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -297,6 +297,7 @@ static int hwp_active __read_mostly;
 static int hwp_mode_bdw __read_mostly;
 static bool per_cpu_limits __read_mostly;
 static bool hwp_boost __read_mostly;
+static bool hwp_forced __read_mostly;
 
 static struct cpufreq_driver *intel_pstate_driver __read_mostly;
 
@@ -1705,12 +1706,12 @@ static void intel_pstate_update_epp_defaults(struct cpudata *cpudata)
 		return;
 
 	/*
-	 * If powerup EPP is something other than chipset default 0x80 and
-	 * - is more performance oriented than 0x80 (default balance_perf EPP)
+	 * If the EPP is set by firmware, which means that firmware enabled HWP
+	 * - Is equal or less than 0x80 (default balance_perf EPP)
 	 * - But less performance oriented than performance EPP
 	 *   then use this as new balance_perf EPP.
 	 */
-	if (cpudata->epp_default < HWP_EPP_BALANCE_PERFORMANCE &&
+	if (hwp_forced && cpudata->epp_default <= HWP_EPP_BALANCE_PERFORMANCE &&
 	    cpudata->epp_default > HWP_EPP_PERFORMANCE) {
 		epp_values[EPP_INDEX_BALANCE_PERFORMANCE] = cpudata->epp_default;
 		return;
@@ -3423,7 +3424,7 @@ static int __init intel_pstate_init(void)
 
 	id = x86_match_cpu(hwp_support_ids);
 	if (id) {
-		bool hwp_forced = intel_pstate_hwp_is_enabled();
+		hwp_forced = intel_pstate_hwp_is_enabled();
 
 		if (hwp_forced)
 			pr_info("HWP enabled by BIOS\n");
-- 
2.31.1

