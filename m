Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1508D5EC8AC
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 17:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232499AbiI0PyO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 11:54:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiI0Pxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 11:53:37 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A06A2FF3E2;
        Tue, 27 Sep 2022 08:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664294010; x=1695830010;
  h=from:to:cc:subject:date:message-id;
  bh=/nxN0okOGZiwmsrSNCONXjNxH/jms7oatin6pcoG7eQ=;
  b=AuatI+AVhdos4uijr/bpWNBa1xYcJ3JC5Kck/YKM2BBmkOfcvFnJm9fK
   kkqIpqDuKhYntpFPvtOZloAnLTougV8SKcY+Y9H/X35JUTemTfOGDukDh
   W4GKSQhQdS2XY+vHJxZqI6M6zs01FWuhCGl+1AYoyoPJX6YiTwp/NuaeF
   rVyk6GaloYNE/nybBoAZbGbJZFxby8C4Sq9RfzeffdI4peHUchvtKvMtN
   QFbt7oiAqzvZA+VY/IvvgHA8vA4LZBkXcXwkL84ViEXGa3oVrSrY4JLHc
   dn5ZOw0M1I6wpyR31m2Mzoyz/ThdG9IWqudykCMB9hLTTqE4pW1Nt9pHR
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="365395800"
X-IronPort-AV: E=Sophos;i="5.93,349,1654585200"; 
   d="scan'208";a="365395800"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2022 08:53:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="950335547"
X-IronPort-AV: E=Sophos;i="5.93,349,1654585200"; 
   d="scan'208";a="950335547"
Received: from srpawnik.iind.intel.com ([10.99.123.68])
  by fmsmga005.fm.intel.com with ESMTP; 27 Sep 2022 08:53:27 -0700
From:   Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
To:     rafael@kernel.org, srinivas.pandruvada@linux.intel.com,
        rui.zhang@intel.com, daniel.lezcano@linaro.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     andriy.shevchenko@linux.intel.com, sumeet.r.pawnikar@intel.com
Subject: [PATCH] thermal: Increase maximum number of trip points
Date:   Tue, 27 Sep 2022 21:17:09 +0530
Message-Id: <20220927154709.5479-1-sumeet.r.pawnikar@intel.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On one of the Chrome system, if we define more than 12 trip points,
probe for thermal sensor fails with
"int3403 thermal: probe of INTC1046:03 failed with error -22"
and throws an error as
"thermal_sys: Error: Incorrect number of thermal trips".

The thermal_zone_device_register() interface needs maximum
number of trip points supported in a zone as an argument.
This number can't exceed THERMAL_MAX_TRIPS, which is currently
set to 12. To address this issue, THERMAL_MAX_TRIPS value
has to be increased.

This interface also has an argument to specify a mask of trips
which are writable. This mask is defined as an int.
This mask sets the ceiling for increasing maximum number of
supported trips. With the current implementation, maximum number
of trips can be supported is 31.

Also, THERMAL_MAX_TRIPS macro is used in one place only.
So, remove THERMAL_MAX_TRIPS macro and compare num_trips
directly with using a macro BITS_PER_TYPE(int)-1.

Signed-off-by: Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
---
 drivers/thermal/thermal_core.c | 15 ++++++++++++++-
 include/linux/thermal.h        |  2 --
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 50d50cec7774..589dd82fe10c 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1212,7 +1212,20 @@ thermal_zone_device_register_with_trips(const char *type, struct thermal_trip *t
 		return ERR_PTR(-EINVAL);
 	}
 
-	if (num_trips > THERMAL_MAX_TRIPS || num_trips < 0 || mask >> num_trips) {
+	/*
+	 * Max trip count can't exceed 31 as the "mask >> num_trips" condition.
+	 * For example, shifting by 32 will result in compiler warning:
+	 * warning: right shift count >= width of type [-Wshift-count- overflow]
+	 *
+	 * Also "mask >> num_trips" will always be true with 32 bit shift.
+	 * E.g. mask = 0x80000000 for trip id 31 to be RW. Then
+	 * mask >> 32 = 0x80000000
+	 * This will result in failure for the below condition.
+	 *
+	 * Check will be true when the bit 31 of the mask is set.
+	 * 32 bit shift will cause overflow of 4 byte integer.
+	 */
+	if (num_trips > (BITS_PER_TYPE(int) - 1) || num_trips < 0 || mask >> num_trips) {
 		pr_err("Incorrect number of thermal trips\n");
 		return ERR_PTR(-EINVAL);
 	}
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 1386c713885d..c05f5c78a0f2 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -17,8 +17,6 @@
 #include <linux/workqueue.h>
 #include <uapi/linux/thermal.h>
 
-#define THERMAL_MAX_TRIPS	12
-
 /* invalid cooling state */
 #define THERMAL_CSTATE_INVALID -1UL
 
-- 
2.17.1

