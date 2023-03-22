Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07F226C4E01
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 15:40:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231609AbjCVOkF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 10:40:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231598AbjCVOjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 10:39:32 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF7E75FA77
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 07:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679495966; x=1711031966;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ORQoLZf18v3gXDfH3BHmV5xqWMBNzteq8nwmowV0t7U=;
  b=Rrj0Lom1dUQX+g9uN5sc2dK2sm9MBMoTnpbb0NQAzQR3rQr2XRuN/jI4
   t/P/6KGxY8EwZ1JIdgR2EUYPbNZYAoehAFYgnEVsn7uZQVoNgl3zeakcE
   d4ZcJaQengIH0eoeMf8Axr/ouzQfGAuZ9M4qsn0AjKGNe+LiGG1UNXvBG
   rZ61YXax5TAuoU+AlegkxVwUxGEQ3LDLa3cJVf7iCzcuAYqBVhx3tVHr9
   0XbR59l/AvMBF/nqKmNaBygMAIf4wtaXpKHqlR5SVXV7ALtApY8nGQNr4
   vYgug7sEdGZfrfrleOmioWFM3nQ/QViZR6rxyqoxC1Yktabln6EFaiZ1M
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="319622132"
X-IronPort-AV: E=Sophos;i="5.98,282,1673942400"; 
   d="scan'208";a="319622132"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2023 07:39:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="856116429"
X-IronPort-AV: E=Sophos;i="5.98,282,1673942400"; 
   d="scan'208";a="856116429"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 22 Mar 2023 07:39:23 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id C9E437E5; Wed, 22 Mar 2023 16:40:06 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bumwoo Lee <bw365.lee@samsung.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH v1 07/14] extcon: Use unique number for the extcon device ID
Date:   Wed, 22 Mar 2023 16:39:58 +0200
Message-Id: <20230322144005.40368-8-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230322144005.40368-1-andriy.shevchenko@linux.intel.com>
References: <20230322144005.40368-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
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
 drivers/extcon/extcon.c | 15 ++++++++++++---
 drivers/extcon/extcon.h |  2 ++
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/extcon/extcon.c b/drivers/extcon/extcon.c
index 14e66e21597f..0d261ec6c473 100644
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
 		dev_err(&edev->dev, "extcon device name is null\n");
 		return -EINVAL;
 	}
-	dev_set_name(&edev->dev, "extcon%lu",
-			(unsigned long)atomic_inc_return(&edev_no));
+
+	ret = ida_simple_get(&extcon_dev_ids, 0, INT_MAX, GFP_KERNEL);
+	if (ret < 0)
+		return ret;
+
+	edev->id = ret;
+
+	dev_set_name(&edev->dev, "extcon%d", edev->id);
 
 	ret = extcon_alloc_cables(edev);
 	if (ret < 0)
@@ -1368,6 +1375,8 @@ void extcon_dev_unregister(struct extcon_dev *edev)
 		return;
 	}
 
+	ida_simple_remove(&extcon_dev_ids, edev->id);
+
 	device_unregister(&edev->dev);
 
 	if (edev->mutually_exclusive && edev->max_supported) {
diff --git a/drivers/extcon/extcon.h b/drivers/extcon/extcon.h
index 15616446140d..877c0860e300 100644
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
+	int id;
 	struct raw_notifier_head nh_all;
 	struct raw_notifier_head *nh;
 	struct list_head entry;
-- 
2.40.0.1.gaa8946217a0b

