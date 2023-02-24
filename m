Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 415596A2308
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 21:07:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbjBXUHc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 15:07:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbjBXUH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 15:07:27 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0897411E93
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 12:07:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677269235; x=1708805235;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=a6+nfG7a4Kkpk7FP1rUfILI2yvSsEp9IQE/r4kYcYcM=;
  b=SMffRVOZuYnsXNj+jfJv5r/IPIMiIqI+JtuZSpHRopX3XycZ8VPsI4YP
   Nq1WNS438HHtC9hZ4ye4CQ0OFNtiVaxyJ8qflR8gW68Orljmo4LfNMQOI
   HQliVijMTTVbIs5LqhrH7E+WcScugtzdC7QC1pRzqHIqh2DgF91UDAKm3
   2WLPxM32833IkaPlnEvO7X6FYuX6SgiDKQC+tDQalv3gGGqUsddcMuQPg
   smkPV/LBxPBhtWvS+FTdbSviSN3kp0UfbZM4vGEX/m0cCdwSdzTroG2QG
   gIfv7sIfoEjEFJfG0H25xnOZ5BvU61BS9/BKMh/yxpSEPTUmMhnjAWAb1
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10631"; a="317328939"
X-IronPort-AV: E=Sophos;i="5.97,325,1669104000"; 
   d="scan'208";a="317328939"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2023 12:07:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10631"; a="705397917"
X-IronPort-AV: E=Sophos;i="5.97,325,1669104000"; 
   d="scan'208";a="705397917"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 24 Feb 2023 12:07:10 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id A08B4147; Fri, 24 Feb 2023 22:07:51 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] devres: Pass unique name of the resource to devm_add_action()
Date:   Fri, 24 Feb 2023 22:07:45 +0200
Message-Id: <20230224200745.17324-1-andriy.shevchenko@linux.intel.com>
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

Pass the unique name of the resource to devm_add_action(),
so it will be easier to debug managed resources.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/base/devres.c  | 11 ++++++-----
 include/linux/device.h |  5 ++++-
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/base/devres.c b/drivers/base/devres.c
index c0e100074aa3..5c998cfac335 100644
--- a/drivers/base/devres.c
+++ b/drivers/base/devres.c
@@ -722,20 +722,21 @@ static void devm_action_release(struct device *dev, void *res)
 }
 
 /**
- * devm_add_action() - add a custom action to list of managed resources
+ * __devm_add_action() - add a custom action to list of managed resources
  * @dev: Device that owns the action
  * @action: Function that should be called
  * @data: Pointer to data passed to @action implementation
+ * @name: Name of the resource (for debugging purposes)
  *
  * This adds a custom action to the list of managed resources so that
  * it gets executed as part of standard resource unwinding.
  */
-int devm_add_action(struct device *dev, void (*action)(void *), void *data)
+int __devm_add_action(struct device *dev, void (*action)(void *), void *data, const char *name)
 {
 	struct action_devres *devres;
 
-	devres = devres_alloc(devm_action_release,
-			      sizeof(struct action_devres), GFP_KERNEL);
+	devres = __devres_alloc_node(devm_action_release, sizeof(struct action_devres),
+				     GFP_KERNEL, NUMA_NO_NODE, name);
 	if (!devres)
 		return -ENOMEM;
 
@@ -745,7 +746,7 @@ int devm_add_action(struct device *dev, void (*action)(void *), void *data)
 	devres_add(dev, devres);
 	return 0;
 }
-EXPORT_SYMBOL_GPL(devm_add_action);
+EXPORT_SYMBOL_GPL(__devm_add_action);
 
 /**
  * devm_remove_action() - removes previously added custom action
diff --git a/include/linux/device.h b/include/linux/device.h
index 1508e637bb26..5b9f3cb22f78 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -243,10 +243,13 @@ void __iomem *devm_of_iomap(struct device *dev,
 			    resource_size_t *size);
 
 /* allows to add/remove a custom action to devres stack */
-int devm_add_action(struct device *dev, void (*action)(void *), void *data);
 void devm_remove_action(struct device *dev, void (*action)(void *), void *data);
 void devm_release_action(struct device *dev, void (*action)(void *), void *data);
 
+int __devm_add_action(struct device *dev, void (*action)(void *), void *data, const char *name);
+#define devm_add_action(release, action, data) \
+	__devm_add_action(release, action, data, #action)
+
 static inline int devm_add_action_or_reset(struct device *dev,
 					   void (*action)(void *), void *data)
 {
-- 
2.39.1

