Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BFA468A82D
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 05:29:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232416AbjBDE3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 23:29:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232463AbjBDE3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 23:29:41 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A7824940C;
        Fri,  3 Feb 2023 20:29:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675484980; x=1707020980;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=H3qJvq+FzGAE9XTRUCeAHJMizsLeIwMpWifCW4lw7W4=;
  b=j09chemjD7BoNzpLU5CqjspeAKl+0MhjRYgLNy+QO3acSukR2QXFMmjf
   zrCip6CYktbJyztiCrL5XuFgHYlXRzj6mo1L/kdbvl/cRJYs8z5JjWNFa
   KTozxY+CinGYmUFOLsHdFNQvYpEDsdyanLNj/giQk8fI725oHuIlCqrwu
   4pjhjKpQWuE1ky8FlHSsdG1m2mxfWlEGE1mBV4T73KYN9bB6tIScW/T/W
   sk9ItMrHRtlQC0Lybn2auzDR925F/+DJcZv4MH9WFAO8JFowQ595Lu095
   efvVCzAPk7/7+N10N+i+mu/5Ikt+F8wYWIPjIiaViQ14auswY1+42HtGb
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10610"; a="391310591"
X-IronPort-AV: E=Sophos;i="5.97,272,1669104000"; 
   d="scan'208";a="391310591"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2023 20:29:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10610"; a="734577007"
X-IronPort-AV: E=Sophos;i="5.97,272,1669104000"; 
   d="scan'208";a="734577007"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by fmsmga004.fm.intel.com with ESMTP; 03 Feb 2023 20:29:28 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     rafael@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        daniel.lezcano@linaro.org, rui.zhang@intel.com,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2] thermal: intel_powerclamp: Return last requested state as cur_state
Date:   Fri,  3 Feb 2023 20:29:02 -0800
Message-Id: <20230204042902.2555347-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.39.1
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

When the user is reading cur_state from the thermal cooling device for
Intel powerclamp device:
- It returns the idle ratio from Package C-state counters when
there is active idle injection session.
- -1, when there is no active idle injection session.

This information is not very useful as the package C-state counters vary
a lot from read to read. Instead just return the last requested cur_state.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
v2:
Fixed setting of *state

 drivers/thermal/intel/intel_powerclamp.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/thermal/intel/intel_powerclamp.c b/drivers/thermal/intel/intel_powerclamp.c
index 5f54c88b1977..0282503ecaaf 100644
--- a/drivers/thermal/intel/intel_powerclamp.c
+++ b/drivers/thermal/intel/intel_powerclamp.c
@@ -539,17 +539,7 @@ static int powerclamp_get_cur_state(struct thermal_cooling_device *cdev,
 				 unsigned long *state)
 {
 	mutex_lock(&powerclamp_lock);
-
-	if (powerclamp_data.clamping) {
-		if (poll_pkg_cstate_enable)
-			*state = pkg_cstate_ratio_cur;
-		else
-			*state = powerclamp_data.target_ratio;
-	} else {
-		/* to save power, do not poll idle ratio while not clamping */
-		*state = -1; /* indicates invalid state */
-	}
-
+	*state = powerclamp_data.target_ratio;
 	mutex_unlock(&powerclamp_lock);
 
 	return 0;
-- 
2.17.1

