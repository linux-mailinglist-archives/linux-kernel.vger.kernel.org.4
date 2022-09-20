Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD4C15BE41D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 13:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbiITLIK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 07:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbiITLIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 07:08:05 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F277667CB0;
        Tue, 20 Sep 2022 04:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663672085; x=1695208085;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=C/x7ktM6FiOGp/5hT9uOGPRNQjpe7jAmhOwT0sQRHAw=;
  b=CyQ8tVwdZ7G950wgzcvRVLjnDiszsMBVxr0pfIT3ipzco8EXopUD+D8n
   bSCiecQojb67UwFhX+SilEqKt0UKcDgT7Lpq0g192bu1h3uRVcx9wSTV8
   KtDhsdkuZDdRSLffvN3eiv7HwNESvUjqHfGHJ6j6+HwvYR7gopCY5/BVZ
   JCui4cihxt+Rr07RdWdUFMRoj7GETHIj5JeuwWEwFvpyGSucmW9i5Kpbf
   QyELElV2AQq5Vl1IeCUijc7MTVvDP+bxs1PnVDkvqFdrG/IdEOaRL73gC
   FC5GY4200iJPSKrpvYxrLF9TVTWLHzwFAwBlVxr2o2/IsScrZD/J+xros
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10475"; a="282693585"
X-IronPort-AV: E=Sophos;i="5.93,330,1654585200"; 
   d="scan'208";a="282693585"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2022 04:08:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,330,1654585200"; 
   d="scan'208";a="722699201"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by fmsmga002.fm.intel.com with ESMTP; 20 Sep 2022 04:08:03 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     rafael@kernel.org, rui.zhang@intel.com, daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] thermal/drivers/intel_powerclamp: Remove accounting for IRQ wakes
Date:   Tue, 20 Sep 2022 04:08:02 -0700
Message-Id: <20220920110802.1948434-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a static variable "idle_wakeup_counter", which accounts for
number of wake ups because of IRQs and take actions to compensate idle
injection. This is now read and reset to 0, but never incremented.
So all the usage of this counter for idle injection has no use.

Also another static variable "reduce_irq", which depends on
"idle_wakeup_counter", so remove usage of "reduce_irq" also.

commit feb6cd6a0f9f ("thermal/intel_powerclamp: stop sched tick in
forced idle") replaced local use of "mwait_idle_with_hints" with
play_idle(). This removed possibility of updating "idle_wakeup_counter"
without change in the play_idle(). This change was done in the Linux
kernel version 4.10.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/thermal/intel/intel_powerclamp.c | 21 +++------------------
 1 file changed, 3 insertions(+), 18 deletions(-)

diff --git a/drivers/thermal/intel/intel_powerclamp.c b/drivers/thermal/intel/intel_powerclamp.c
index c841ab37e7c6..8bb28aa433b6 100644
--- a/drivers/thermal/intel/intel_powerclamp.c
+++ b/drivers/thermal/intel/intel_powerclamp.c
@@ -62,8 +62,7 @@ static struct dentry *debug_dir;
 static unsigned int set_target_ratio;
 static unsigned int current_ratio;
 static bool should_skip;
-static bool reduce_irq;
-static atomic_t idle_wakeup_counter;
+
 static unsigned int control_cpu; /* The cpu assigned to collect stat and update
 				  * control parameters. default to BSP but BSP
 				  * can be offlined.
@@ -285,9 +284,6 @@ static unsigned int get_compensation(int ratio)
 			cal_data[ratio + 1].steady_comp) / 3;
 	}
 
-	/* REVISIT: simple penalty of double idle injection */
-	if (reduce_irq)
-		comp = ratio;
 	/* do not exceed limit */
 	if (comp + ratio >= MAX_TARGET_RATIO)
 		comp = MAX_TARGET_RATIO - ratio - 1;
@@ -301,13 +297,9 @@ static void adjust_compensation(int target_ratio, unsigned int win)
 	struct powerclamp_calibration_data *d = &cal_data[target_ratio];
 
 	/*
-	 * adjust compensations if confidence level has not been reached or
-	 * there are too many wakeups during the last idle injection period, we
-	 * cannot trust the data for compensation.
+	 * adjust compensations if confidence level has not been reached.
 	 */
-	if (d->confidence >= CONFIDENCE_OK ||
-		atomic_read(&idle_wakeup_counter) >
-		win * num_online_cpus())
+	if (d->confidence >= CONFIDENCE_OK)
 		return;
 
 	delta = set_target_ratio - current_ratio;
@@ -347,14 +339,7 @@ static bool powerclamp_adjust_controls(unsigned int target_ratio,
 	tsc_last = tsc_now;
 
 	adjust_compensation(target_ratio, win);
-	/*
-	 * too many external interrupts, set flag such
-	 * that we can take measure later.
-	 */
-	reduce_irq = atomic_read(&idle_wakeup_counter) >=
-		2 * win * num_online_cpus();
 
-	atomic_set(&idle_wakeup_counter, 0);
 	/* if we are above target+guard, skip */
 	return set_target_ratio + guard <= current_ratio;
 }
-- 
2.35.3

