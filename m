Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF45F6C7871
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 08:08:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbjCXHIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 03:08:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbjCXHIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 03:08:17 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A684270B;
        Fri, 24 Mar 2023 00:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679641696; x=1711177696;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1QwNjA/703mfJcIj5DSMOgyWQ/j+uRh45wv8E+wMysE=;
  b=WTsqof7QB+w8HsQPQScXcuo8Fw4ijRo5+OJt7cRp/JmkxlF++//1FRAg
   dLdYVwBn8jVOCr6le+X0/Bdh2MjkgYyqZSxYhzl4SX7S1AvNcjK9+Q47p
   vYFuxCR7il+hxsl8mKRHMyz5iAGn9sK3Du0S8ktcCa7a6qPrC8qM8VnPV
   b5L0Tm3u8sCjrmqAp3SFZ2vr8agLUpT6+w2A/se/U4wT0XlLcuz8yROsU
   QYZ2Mqw5mgH6b8PkVNX4QczPVjqn7a/U6uYOVPJ9+128OiLzuqUs/GiuQ
   pmRtLSGVs5h2IpnVOFEJUBj3omup+OitRjZh8dZu19KfIHbQ9IcJPkpRc
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="402296711"
X-IronPort-AV: E=Sophos;i="5.98,287,1673942400"; 
   d="scan'208";a="402296711"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2023 00:08:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="747046047"
X-IronPort-AV: E=Sophos;i="5.98,287,1673942400"; 
   d="scan'208";a="747046047"
Received: from fli4-mobl1.ccr.corp.intel.com (HELO rzhang1-DESK.intel.com) ([10.255.28.30])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2023 00:08:14 -0700
From:   Zhang Rui <rui.zhang@intel.com>
To:     linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com,
        daniel.lezcano@linaro.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/5] thermal/core: Update cooling device during thermal zone unregistration
Date:   Fri, 24 Mar 2023 15:08:03 +0800
Message-Id: <20230324070807.6342-1-rui.zhang@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When unregistering a thermal zone device, update all cooling devices
bound to the thermal zone device.

This fixes a problem that the frequency of ACPI processors are still
limited after unloading ACPI thermal driver while ACPI passive cooling
is activated.

Cc: stable@vger.kernel.org
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
v1 -> v2
	Changelog update.
	Rearrange the code to elimiate an "iterator used outside loop"
warning.
---
 drivers/thermal/thermal_core.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index cfd4c1afeae7..30ff39154598 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1497,9 +1497,24 @@ void thermal_zone_device_unregister(struct thermal_zone_device *tz)
 
 	/* Unbind all cdevs associated with 'this' thermal zone */
 	list_for_each_entry(cdev, &thermal_cdev_list, node) {
+		struct thermal_instance *ti;
+
+		mutex_lock(&tz->lock);
+		list_for_each_entry(ti, &tz->thermal_instances, tz_node) {
+			if (ti->cdev == cdev) {
+				mutex_unlock(&tz->lock);
+				goto unbind;
+			}
+		}
+
+		/* The cooling device is not bound to current thermal zone */
+		mutex_unlock(&tz->lock);
+		continue;
+
+unbind:
 		if (tz->ops->unbind) {
 			tz->ops->unbind(tz, cdev);
-			continue;
+			goto deactivate;
 		}
 
 		if (!tzp || !tzp->tbp)
@@ -1511,6 +1526,16 @@ void thermal_zone_device_unregister(struct thermal_zone_device *tz)
 				tzp->tbp[i].cdev = NULL;
 			}
 		}
+
+deactivate:
+		/*
+		 * The thermal instances for current thermal zone has been
+		 * removed. Update the cooling device in case it is activated
+		 * by current thermal zone device.
+		 */
+		mutex_lock(&cdev->lock);
+		__thermal_cdev_update(cdev);
+		mutex_unlock(&cdev->lock);
 	}
 
 	mutex_unlock(&thermal_list_lock);
-- 
2.25.1

