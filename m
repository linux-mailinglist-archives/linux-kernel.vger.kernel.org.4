Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F6796C4DF8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 15:40:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231644AbjCVOjk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 10:39:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231422AbjCVOjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 10:39:25 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0C2F410AB
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 07:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679495964; x=1711031964;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fDzjemeuLsru23paImIk8ffwUuduPpzCedRvBa6jMLo=;
  b=CIsnt/nm5+QJXCD9nc11q3cm7138lGOzoMnEbLnN22aZWxHTOan7ZDjs
   M0idP2ZoBF63gYNw6hln/xGZNcOLkny3vx2M+lB46sF60YAEFcIBYpSbn
   B4QE3TjJVCJ4wD0J8Hc/VVDA5lbo9qIatv1ESyKgSk5nv3Su+ryy72MMn
   VmDg71Km4tmsVsaXzXpf9NWR96zctRhQgeQogaE8oBFZugHz8mmeE8L5J
   JWCJP4s/Fr/hkMwJnRo0zZFySnB25cnA8W/kbeY5BRk/MHZBRk0cmm1GA
   beuxywqBbCW9ty9lRS7Q5bSmsDxjfAdx7GiX1h7XAjlhxE0yJ3/XUMMIr
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="327609304"
X-IronPort-AV: E=Sophos;i="5.98,282,1673942400"; 
   d="scan'208";a="327609304"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2023 07:39:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="792579434"
X-IronPort-AV: E=Sophos;i="5.98,282,1673942400"; 
   d="scan'208";a="792579434"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 22 Mar 2023 07:39:22 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id CED2C3DD; Wed, 22 Mar 2023 16:40:06 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bumwoo Lee <bw365.lee@samsung.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH v1 08/14] extcon: Switch to use kasprintf_strarray()
Date:   Wed, 22 Mar 2023 16:39:59 +0200
Message-Id: <20230322144005.40368-9-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230322144005.40368-1-andriy.shevchenko@linux.intel.com>
References: <20230322144005.40368-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we have a generic helper, switch the module to use it.
No functional change intended.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/extcon/extcon.c | 25 +++++++++++--------------
 drivers/extcon/extcon.h |  1 +
 2 files changed, 12 insertions(+), 14 deletions(-)

diff --git a/drivers/extcon/extcon.c b/drivers/extcon/extcon.c
index 0d261ec6c473..a63e7eef02fd 100644
--- a/drivers/extcon/extcon.c
+++ b/drivers/extcon/extcon.c
@@ -23,6 +23,7 @@
 #include <linux/err.h>
 #include <linux/of.h>
 #include <linux/slab.h>
+#include <linux/string_helpers.h>
 #include <linux/sysfs.h>
 
 #include "extcon.h"
@@ -1104,19 +1105,17 @@ static int extcon_alloc_cables(struct extcon_dev *edev)
 	if (!edev->cables)
 		return -ENOMEM;
 
+	edev->cable_names = kasprintf_strarray(GFP_KERNEL, "cable", edev->max_supported);
+	if (!edev->cable_names) {
+		kfree(edev->cables);
+		return -ENOMEM;
+	}
+
 	for (index = 0; index < edev->max_supported; index++) {
 		cable = &edev->cables[index];
 
-		str = kasprintf(GFP_KERNEL, "cable.%d", index);
-		if (!str) {
-			for (index--; index >= 0; index--) {
-				cable = &edev->cables[index];
-				kfree(cable->attr_g.name);
-			}
-
-			kfree(edev->cables);
-			return -ENOMEM;
-		}
+		str = edev->cable_names[index];
+		strreplace(str, '-', '.');
 
 		cable->edev = edev;
 		cable->cable_index = index;
@@ -1341,8 +1340,7 @@ int extcon_dev_register(struct extcon_dev *edev)
 		kfree(edev->attrs_muex);
 	}
 err_alloc_muex:
-	for (index = 0; index < edev->max_supported; index++)
-		kfree(edev->cables[index].attr_g.name);
+	kfree_strarray(edev->cable_names, edev->max_supported);
 	if (edev->max_supported)
 		kfree(edev->cables);
 err_alloc_cables:
@@ -1387,8 +1385,7 @@ void extcon_dev_unregister(struct extcon_dev *edev)
 		kfree(edev->attrs_muex);
 	}
 
-	for (index = 0; index < edev->max_supported; index++)
-		kfree(edev->cables[index].attr_g.name);
+	kfree_strarray(edev->cable_names, edev->max_supported);
 
 	if (edev->max_supported) {
 		kfree(edev->extcon_dev_type.groups);
diff --git a/drivers/extcon/extcon.h b/drivers/extcon/extcon.h
index 877c0860e300..5624f65ba17a 100644
--- a/drivers/extcon/extcon.h
+++ b/drivers/extcon/extcon.h
@@ -58,6 +58,7 @@ struct extcon_dev {
 	/* /sys/class/extcon/.../cable.n/... */
 	struct device_type extcon_dev_type;
 	struct extcon_cable *cables;
+	char **cable_names;
 
 	/* /sys/class/extcon/.../mutually_exclusive/... */
 	struct attribute_group attr_g_muex;
-- 
2.40.0.1.gaa8946217a0b

