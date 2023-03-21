Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6CEC6C361B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 16:46:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231169AbjCUPqq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 11:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230478AbjCUPqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 11:46:43 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8542B2ED53;
        Tue, 21 Mar 2023 08:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679413598; x=1710949598;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=yMZXccUu1lBAd8v18L5Z/TESPdIfHYj6uBIHlG8Q0SM=;
  b=bvgnoBTr+OE2TX1zmWXTrgYMk2Qwnzcyzf7XOL9dsilnQoRJboXjPgc7
   RNxt54KFlkgsuBHa/mW08T08YRRetmRXg49OlU41jQCtg3micXTcY/4sQ
   jFR94uS7CYoVXZIYvRKYWD/VCUE1bqsP8IXFixu/MiVieaEpj7NJiiJKd
   5oriMeZW2iaZw7wj1VdrF5VAMg6SQ+CJnUh47HGwXi+s/eIjCZe2+eo8f
   itWTOXJcGUq0sVIiBfVUAClELYPTc4Ptk7vWTrwHY6wi/yFZGC+lazNdM
   +arHZuP6+/4SjIod+kI9HAxr9S/lUWo5+NqEUn9XIURUvypj7LJK6c54V
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="339014467"
X-IronPort-AV: E=Sophos;i="5.98,279,1673942400"; 
   d="scan'208";a="339014467"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2023 08:46:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="683913453"
X-IronPort-AV: E=Sophos;i="5.98,279,1673942400"; 
   d="scan'208";a="683913453"
Received: from gongzhi-mobl1.ccr.corp.intel.com (HELO rzhang1-DESK.intel.com) ([10.254.214.88])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2023 08:46:36 -0700
From:   Zhang Rui <rui.zhang@intel.com>
To:     linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com,
        daniel.lezcano@linaro.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] thermal/core: update cooling device during thermal zone unregistration
Date:   Tue, 21 Mar 2023 23:46:27 +0800
Message-Id: <20230321154627.17787-1-rui.zhang@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When unregistering a thermal zone device, update the cooling device in
case the cooling device is activated by the current thermal zone.

This fixes a problem that the frequency of ACPI processors are still
limited after unloading ACPI thermal driver while ACPI passive cooling
is activated.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/thermal/thermal_core.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index cfd4c1afeae7..9f120e3c9bf0 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1477,6 +1477,7 @@ void thermal_zone_device_unregister(struct thermal_zone_device *tz)
 	const struct thermal_zone_params *tzp;
 	struct thermal_cooling_device *cdev;
 	struct thermal_zone_device *pos = NULL;
+	struct thermal_instance *ti;
 
 	if (!tz)
 		return;
@@ -1497,9 +1498,22 @@ void thermal_zone_device_unregister(struct thermal_zone_device *tz)
 
 	/* Unbind all cdevs associated with 'this' thermal zone */
 	list_for_each_entry(cdev, &thermal_cdev_list, node) {
+		mutex_lock(&tz->lock);
+		list_for_each_entry(ti, &tz->thermal_instances, tz_node) {
+			if (ti->cdev == cdev)
+				break;
+		}
+
+		/* The cooling device is not used by current thermal zone */
+		if (ti->cdev != cdev) {
+			mutex_unlock(&tz->lock);
+			continue;
+		}
+		mutex_unlock(&tz->lock);
+
 		if (tz->ops->unbind) {
 			tz->ops->unbind(tz, cdev);
-			continue;
+			goto deactivate_cdev;
 		}
 
 		if (!tzp || !tzp->tbp)
@@ -1511,6 +1525,16 @@ void thermal_zone_device_unregister(struct thermal_zone_device *tz)
 				tzp->tbp[i].cdev = NULL;
 			}
 		}
+
+deactivate_cdev:
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

