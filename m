Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99B436DDA05
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 13:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbjDKLtD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 07:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbjDKLsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 07:48:54 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 682BB49D9
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 04:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681213714; x=1712749714;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IQmuM7vKMWhAKUjAzRnsD5sMpdUzY1CJtq2zna0j1Rk=;
  b=GiUqo90n6BK9bJA4zl6aqYo++xBUWpLb0n0bkjO6PFFFxCBOG17kess/
   zFuVPOR3eFrGFRHxuUoeHmVilHk1sP6EXUXM1TvBmf1sdACqVPsaEiwkT
   HsACAuWbJ7dIgnwIkLj+OmW41YyYR6/1XGFFir2UlfhMsfCuOP/gtIzyL
   iwU+MagVEWaEwrYMCs9b8xDUa1zlq5bY1kOgDyUeuFmio+P3e19jRYTKK
   CCuvlig1GGXlqOndquuTJ3Bw8SjMOUlafxideRiEDOorZz/7/gfyDCLUy
   MfBv4wxyOLxOWbyOTkQnkA1kvI1Wd/1JDS9GM87kSpBmGT5oJEIvX+EkH
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="332281209"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="332281209"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2023 04:48:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="691123837"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="691123837"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 11 Apr 2023 04:48:23 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 3BAB314B; Tue, 11 Apr 2023 14:48:26 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Bumwoo Lee <bw365.lee@samsung.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: [PATCH v3 1/3] extcon: Use unique number for the extcon device ID
Date:   Tue, 11 Apr 2023 14:48:22 +0300
Message-Id: <20230411114824.82960-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230411114824.82960-1-andriy.shevchenko@linux.intel.com>
References: <20230411114824.82960-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The use of atomic variable is still racy when we do not control which
device has been unregistered and there is a (theoretical) possibility
of the overflow that may cause a duplicate extcon device ID number
to be allocated next time a device is registered.

Replace above mentioned approach by using IDA framework.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/extcon/extcon.c | 16 +++++++++++++---
 drivers/extcon/extcon.h |  2 ++
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/extcon/extcon.c b/drivers/extcon/extcon.c
index 47819c5144d5..5da1cc60582a 100644
--- a/drivers/extcon/extcon.c
+++ b/drivers/extcon/extcon.c
@@ -16,6 +16,7 @@
 
 #include <linux/module.h>
 #include <linux/types.h>
+#include <linux/idr.h>
 #include <linux/init.h>
 #include <linux/device.h>
 #include <linux/fs.h>
@@ -238,6 +239,7 @@ struct extcon_cable {
 
 static struct class *extcon_class;
 
+static DEFINE_IDA(extcon_dev_ids);
 static LIST_HEAD(extcon_dev_list);
 static DEFINE_MUTEX(extcon_dev_list_lock);
 
@@ -1248,7 +1250,6 @@ static int extcon_alloc_groups(struct extcon_dev *edev)
 int extcon_dev_register(struct extcon_dev *edev)
 {
 	int ret, index = 0;
-	static atomic_t edev_no = ATOMIC_INIT(-1);
 
 	ret = create_extcon_class();
 	if (ret < 0)
@@ -1275,8 +1276,14 @@ int extcon_dev_register(struct extcon_dev *edev)
 			"extcon device name is null\n");
 		return -EINVAL;
 	}
-	dev_set_name(&edev->dev, "extcon%lu",
-			(unsigned long)atomic_inc_return(&edev_no));
+
+	ret = ida_alloc(&extcon_dev_ids, GFP_KERNEL);
+	if (ret < 0)
+		return ret;
+
+	edev->id = ret;
+
+	dev_set_name(&edev->dev, "extcon%d", edev->id);
 
 	ret = extcon_alloc_cables(edev);
 	if (ret < 0)
@@ -1339,6 +1346,7 @@ int extcon_dev_register(struct extcon_dev *edev)
 	if (edev->max_supported)
 		kfree(edev->cables);
 err_alloc_cables:
+	ida_free(&extcon_dev_ids, edev->id);
 
 	return ret;
 }
@@ -1367,6 +1375,8 @@ void extcon_dev_unregister(struct extcon_dev *edev)
 		return;
 	}
 
+	ida_free(&extcon_dev_ids, edev->id);
+
 	device_unregister(&edev->dev);
 
 	if (edev->mutually_exclusive && edev->max_supported) {
diff --git a/drivers/extcon/extcon.h b/drivers/extcon/extcon.h
index 15616446140d..946182687786 100644
--- a/drivers/extcon/extcon.h
+++ b/drivers/extcon/extcon.h
@@ -20,6 +20,7 @@
  *			{0x3, 0x6, 0x5, 0}. If it is {0xFFFFFFFF, 0}, there
  *			can be no simultaneous connections.
  * @dev:		Device of this extcon.
+ * @id:			Unique device ID of this extcon.
  * @state:		Attach/detach state of this extcon. Do not provide at
  *			register-time.
  * @nh_all:		Notifier for the state change events for all supported
@@ -46,6 +47,7 @@ struct extcon_dev {
 
 	/* Internal data. Please do not set. */
 	struct device dev;
+	unsigned int id;
 	struct raw_notifier_head nh_all;
 	struct raw_notifier_head *nh;
 	struct list_head entry;
-- 
2.40.0.1.gaa8946217a0b

