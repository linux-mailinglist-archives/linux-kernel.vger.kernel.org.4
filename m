Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC81D687058
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 22:07:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231642AbjBAVH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 16:07:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231185AbjBAVH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 16:07:26 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A221E6D5C6;
        Wed,  1 Feb 2023 13:07:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675285634; x=1706821634;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=yL+AMeADaYah1JlX3xyOr7TA/KaBboijzv98KqvU194=;
  b=BgZoCtx/algIw5eQQ+2yreQshQMMJzkXTRomByz2U+LDCO3uqCt/a7Ri
   rtWyXORGGrP3GAqsrxr3NOENz1uly3tmFkVQwsoyUVfkuoNbDZBaMuOOH
   UNxQXnjkEpWUE7hkOl7+lsH+0+iH2kxcL+oKv8/AVkW2sBigWGpuEAY0J
   8QX6Zel3RUedIRO4zlNK6L0j34YmqZhi1QwZwC3IhlazxsM9f/v6T3Kd5
   Hs0wN1fe5oJAGaAj1JmgE2rAncT/AJ3EsswBIT9jfXb9oZuPr0ZvsPn56
   QlpS1p1iua+KXOuQ4t/s8MbjtXLXBOokpeGUGf+2KhWaafCabjdWCRToD
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="311919614"
X-IronPort-AV: E=Sophos;i="5.97,265,1669104000"; 
   d="scan'208";a="311919614"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2023 13:07:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="838931372"
X-IronPort-AV: E=Sophos;i="5.97,265,1669104000"; 
   d="scan'208";a="838931372"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by orsmga005.jf.intel.com with ESMTP; 01 Feb 2023 13:07:13 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     rafael@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        daniel.lezcano@linaro.org, rui.zhang@intel.com,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] thermal: intel_powerclamp: Return last requested state as cur_state
Date:   Wed,  1 Feb 2023 13:07:12 -0800
Message-Id: <20230201210712.2170312-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.39.1
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

When the user is reading cur_state from the thermal cooling device for
Intel powerclamp device:
- It returns the idle ratio from Package C-state counters when
there is active idle injection session.
- -1, when there is no active idle injection session.

This information is not very useful as the package C-state counters vary
a lot from read to read. Instead just return the last requested cur_state.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/thermal/intel/intel_powerclamp.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/thermal/intel/intel_powerclamp.c b/drivers/thermal/intel/intel_powerclamp.c
index 2f4cbfdf26a0..72a45cf2708c 100644
--- a/drivers/thermal/intel/intel_powerclamp.c
+++ b/drivers/thermal/intel/intel_powerclamp.c
@@ -590,17 +590,7 @@ static int powerclamp_get_max_state(struct thermal_cooling_device *cdev,
 static int powerclamp_get_cur_state(struct thermal_cooling_device *cdev,
 				 unsigned long *state)
 {
-	if (clamping) {
-		if (poll_pkg_cstate_enable)
-			*state = pkg_cstate_ratio_cur;
-		else
-			*state = set_target_ratio;
-	} else {
-		/* to save power, do not poll idle ratio while not clamping */
-		*state = -1; /* indicates invalid state */
-	}
-
-	return 0;
+	return set_target_ratio;
 }
 
 static int powerclamp_set_cur_state(struct thermal_cooling_device *cdev,
-- 
2.39.1

