Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0E316CD957
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 14:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbjC2M0r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 08:26:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjC2M0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 08:26:46 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9A921FDB;
        Wed, 29 Mar 2023 05:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680092805; x=1711628805;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=OgXKX8f5LtCP6F/FCEPIp0Qcorekvwc2ZSrKnL0cKeY=;
  b=Z62vlp1Yr2LN9WrknpHw8gWZAogOrSxJMYuCBx4uoYhHoTy0t5tKvhG3
   HgijylMset3TNnGhq4OFsP9clWtBRz6FvwWIu3BbYmqmSGnYKG8VDnQGh
   x56f2D7O8nK1C6tXoK2mQEHJLrXyn7sp6BdOdanQ84x70IV5Z62/sx1DX
   sp0Jh5mc1QkoNzuuEXf+C8ubpqNp5q4NL6POvsWdrIMs1k+ceuozReCu3
   hQAkPgF80Q4Pv+iSHwgdkAPphtieqrcHDX1A+KciUJQjkFpEDyUPoI83f
   D6eQepRhhB7yNO+TeZ2zuSI2UKfxnF2MP7SMW3RvD0J3hgUVlt47+eYJ4
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="329328841"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="329328841"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 05:26:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="684248568"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="684248568"
Received: from juhuangx-mobl1.ccr.corp.intel.com (HELO rzhang1-DESK.intel.com) ([10.255.30.109])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 05:26:43 -0700
From:   Zhang Rui <rui.zhang@intel.com>
To:     linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com,
        daniel.lezcano@linaro.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2 -next] thermal/drivers/thermal_hwmon: Fix a kernel NULL pointer dereference
Date:   Wed, 29 Mar 2023 20:26:29 +0800
Message-Id: <20230329122629.3614-1-rui.zhang@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the hwmon device node of a thermal zone device is not found,
using hwmon->device causes a kernel NULL pointer dereference.

Skip removing hwmon device for thermal zones without hwmon device, and
fix the kernel NULL pointer dereference when hwmon device is not found.

Fixes: dec07d399cc8 ("thermal: Don't use 'device' internal thermal zone structure field")
Reported-by: Preble Adam C <adam.c.preble@intel.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
v1 -> v2
   Add check for devices without hwmon device.
   Use pr_debug instead of dev_dbg.
---
 drivers/thermal/thermal_hwmon.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/thermal_hwmon.c b/drivers/thermal/thermal_hwmon.c
index c59db17dddd6..1cdee2ee8d4d 100644
--- a/drivers/thermal/thermal_hwmon.c
+++ b/drivers/thermal/thermal_hwmon.c
@@ -226,10 +226,12 @@ void thermal_remove_hwmon_sysfs(struct thermal_zone_device *tz)
 	struct thermal_hwmon_device *hwmon;
 	struct thermal_hwmon_temp *temp;
 
+	if (tz->tzp && tz->tzp->no_hwmon)
+		return;
+
 	hwmon = thermal_hwmon_lookup_by_type(tz);
 	if (unlikely(!hwmon)) {
-		/* Should never happen... */
-		dev_dbg(hwmon->device, "hwmon device lookup failed!\n");
+		pr_debug("hwmon device lookup failed!\n");
 		return;
 	}
 
-- 
2.25.1

