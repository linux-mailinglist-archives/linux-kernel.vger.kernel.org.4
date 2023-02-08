Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB84D68E8B4
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 08:09:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbjBHHJP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 02:09:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjBHHJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 02:09:14 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36E9B19F11;
        Tue,  7 Feb 2023 23:09:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675840153; x=1707376153;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YuHcAmeJD6qZKliGgQx5J9sRN0zTfqdpJlYlq7H4eZE=;
  b=eLix0cUl8foFTtjKEQLi1nT6T6Ih2WxviXmFHaHvBcEOUoVd4K/EDq0L
   RmMLSbGNTXuxg+2gXr8NZwy5F39B/P/P+yi3/s9kF5NvV+Hqo+1Sh4tFw
   DHJanVVL6Op5obKLYr/jwOE+rnvgxVV60Ox/i2VPtarI6NoM6fvjzzt48
   Lu6xAE3oWc8eFiIxGM5LLRT7bwFjvRgjAyYdnxIm+771VOTi1EdWnuyNv
   DDQvJv4fQY++fA5TQKajXsiw2jOC4KOsSOepr4DPfnwg/88CdryONIrIv
   SmXbjlWv4CTB496uMilk2nuR2N5a6NNvWbVF3YDt2KDZKPJGi07vjEF1K
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="392126395"
X-IronPort-AV: E=Sophos;i="5.97,280,1669104000"; 
   d="scan'208";a="392126395"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2023 23:09:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="667144392"
X-IronPort-AV: E=Sophos;i="5.97,280,1669104000"; 
   d="scan'208";a="667144392"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by orsmga002.jf.intel.com with ESMTP; 07 Feb 2023 23:09:10 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     rafael@kernel.org, rui.zhang@intel.com, daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] thermal/drivers/intel_powerclamp: Fix module param for duration
Date:   Tue,  7 Feb 2023 23:09:08 -0800
Message-Id: <20230208070908.41702-1-srinivas.pandruvada@linux.intel.com>
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

After switch to use powercap/idle-inject framework in the Intel
powerclamp driver, the idle "duration" is changed to micro seconds.

But the module parameter for idle "duration" is in milli seconds. So,
convert to micro seconds in the set callback and convert back to milli
seconds by adding a get callback.

While here also use mutex protection for setting and getting "duration".
The other uses of "duration" is already protected by mutex.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
This patch is for linux-pm bleeding-edge branch. Can be after patch:
"
commit 8526eb7fc75abcd09d8bd061610215baf0ca948a
Author: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Date:   Wed Feb 1 10:28:53 2023 -0800

    thermal: intel: powerclamp: Use powercap idle-inject feature
"
Can't add Fixes tag as commit ID will change once merged to mainline.
Or wait till the above patch is merged to mainline.

 drivers/thermal/intel/intel_powerclamp.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/intel/intel_powerclamp.c b/drivers/thermal/intel/intel_powerclamp.c
index 1390748706a6..038acccc0509 100644
--- a/drivers/thermal/intel/intel_powerclamp.c
+++ b/drivers/thermal/intel/intel_powerclamp.c
@@ -74,6 +74,7 @@ static struct thermal_cooling_device *cooling_dev;
 
 static DEFINE_MUTEX(powerclamp_lock);
 
+/* This duration is in micro seconds */
 static unsigned int duration;
 static unsigned int pkg_cstate_ratio_cur;
 static unsigned int window_size;
@@ -90,23 +91,34 @@ static int duration_set(const char *arg, const struct kernel_param *kp)
 		pr_err("Out of recommended range %lu, between 6-25ms\n",
 			new_duration);
 		ret = -EINVAL;
+		goto exit;
 	}
 
-	duration = clamp(new_duration, 6ul, 25ul);
-	smp_mb();
-
+	mutex_lock(&powerclamp_lock);
+	duration = clamp(new_duration, 6ul, 25ul) * 1000;
+	mutex_unlock(&powerclamp_lock);
 exit:
 
 	return ret;
 }
 
+static int duration_get(char *buf, const struct kernel_param *kp)
+{
+	int ret;
+
+	mutex_lock(&powerclamp_lock);
+	ret = sysfs_emit(buf, "%d\n", duration / 1000);
+	mutex_unlock(&powerclamp_lock);
+
+	return ret;
+}
+
 static const struct kernel_param_ops duration_ops = {
 	.set = duration_set,
-	.get = param_get_int,
+	.get = duration_get,
 };
 
-
-module_param_cb(duration, &duration_ops, &duration, 0644);
+module_param_cb(duration, &duration_ops, NULL, 0644);
 MODULE_PARM_DESC(duration, "forced idle time for each attempt in msec.");
 
 struct powerclamp_calibration_data {
-- 
2.39.1

