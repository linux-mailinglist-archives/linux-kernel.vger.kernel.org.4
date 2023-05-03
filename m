Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87AA36F6223
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 01:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbjECXi7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 19:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjECXi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 19:38:57 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79F13900E;
        Wed,  3 May 2023 16:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683157136; x=1714693136;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=T+3WkbkI2Doib/EI0wr80Wr5AoN/X5W//IkbnMxJR1s=;
  b=eViJIy11jqQjFhWgluEzGYSG1nxEamEbBstu7L+3KA73mYVbEwW8VfyD
   2IbrJIBQ3umjUPFarlhcSPQ0W3hkfQRrDGkCLTGQRBgx7luUE8y2SZs5S
   yetkd1uJb7AfAHm9IhFEqTv72yLhH43twUrOKqqmZBjv4voz6MiyYLLYX
   DfZFYH2eBdYm30u/9U5mCrDRVOrloc+tjcrBHfQolXbBpDjl4UvyjeZTm
   Q7HBq8FeNo56kaFlLZJ6Xp4gjIbHKbuVHxUK2oucbopsVt3WJs7rijeia
   wMDjy3ILok+qXXfAiBa95YSr+1QBHOo1NlAKMRHUahNe4MUwy83YwSCPe
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10699"; a="329151689"
X-IronPort-AV: E=Sophos;i="5.99,248,1677571200"; 
   d="scan'208";a="329151689"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2023 16:38:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10699"; a="766341008"
X-IronPort-AV: E=Sophos;i="5.99,248,1677571200"; 
   d="scan'208";a="766341008"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by fmsmga004.fm.intel.com with ESMTP; 03 May 2023 16:38:55 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     rafael@kernel.org, rui.zhang@intel.com, daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "Risto A . Paju" <teknohog@iki.fi>, stable@kernel.org
Subject: [PATCH] thermal: intel: powerclamp: Fix NULL pointer access issue
Date:   Wed,  3 May 2023 16:38:50 -0700
Message-Id: <20230503233850.1918041-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the cur_state for the powerclamp cooling device is set to the default
minimum state of 0, without setting first to cur_state > 0, this results
in NULL pointer access.

This NULL pointer access happens in the powercap core idle-inject function
idle_inject_set_duration() as there is no NULL check for idle_inject_device
pointer. This pointer must be allocated by calling idle_inject_register()
or idle_inject_register_full().

In the function powerclamp_set_cur_state(), idle_inject_device pointer is
allocated only when the cur_state > 0. But setting 0 without changing to
any other state, idle_inject_set_duration() will be called with a NULL
idle_inject_device pointer.

To address this just return from powerclamp_set_cur_state(), if the
current cooling device state is same as the last one. Since the powerup
default cooling device state is 0, changing the state to 0 again here
will return without calling idle_inject_set_duration().

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Fixes: 8526eb7fc75a ("thermal: intel: powerclamp: Use powercap idle-inject feature")
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=217386
Tested-by: Risto A. Paju <teknohog@iki.fi>
Cc: stable@kernel.org
---
This issue is can be reproduced from 6.3-rc1 kernel.

 drivers/thermal/intel/intel_powerclamp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/thermal/intel/intel_powerclamp.c b/drivers/thermal/intel/intel_powerclamp.c
index 91fc7e239497..36243a3972fd 100644
--- a/drivers/thermal/intel/intel_powerclamp.c
+++ b/drivers/thermal/intel/intel_powerclamp.c
@@ -703,6 +703,10 @@ static int powerclamp_set_cur_state(struct thermal_cooling_device *cdev,
 
 	new_target_ratio = clamp(new_target_ratio, 0UL,
 				(unsigned long) (max_idle - 1));
+
+	if (powerclamp_data.target_ratio == new_target_ratio)
+		goto exit_set;
+
 	if (!powerclamp_data.target_ratio && new_target_ratio > 0) {
 		pr_info("Start idle injection to reduce power\n");
 		powerclamp_data.target_ratio = new_target_ratio;
-- 
2.25.1

