Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05F416D81D3
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 17:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238672AbjDEP2j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 11:28:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238432AbjDEP2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 11:28:33 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 529F9198A
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 08:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680708512; x=1712244512;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mokMk0IKOxShItonDjkrLXw1m8ClqXJpU5y5fyGrFXM=;
  b=J/6l7q14SAkYgST0FXd8NbFjZLitRVkbAirp8XaEIUHN3C7214V9Sd/f
   4r64lRUjLFor9Wn+NjZUNhOURW+D6ODXzWZAULP04FavZ2jTYjKVptyhK
   dEN0iCLKfIfGLcwaPsYqD7CzrRpqNX28dPW8eryTa0O3MAikkPmJtk/Uk
   RkhHCK6yw3x14PY61sdyjtY2vw2gZNK4Yk6l7rJ83HsnVrp5PTTQt2YEG
   RFd6vZ7kimGjptNzXtWbqcHjaxxdkOkxLJC+r6LS1k3p2HckQEOcav4Ty
   XZJLB0+lNwPHdUwtEGwa/sEPnrRihwGvudFikk4fB0C9htjNRsVGK33H2
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10671"; a="345064766"
X-IronPort-AV: E=Sophos;i="5.98,321,1673942400"; 
   d="scan'208";a="345064766"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2023 08:27:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10671"; a="756028425"
X-IronPort-AV: E=Sophos;i="5.98,321,1673942400"; 
   d="scan'208";a="756028425"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 05 Apr 2023 08:27:50 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id B2415443; Wed,  5 Apr 2023 18:27:52 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Bumwoo Lee <bw365.lee@samsung.com>
Subject: [PATCH v2 3/5] extcon: Use unique number for the extcon device ID
Date:   Wed,  5 Apr 2023 18:27:43 +0300
Message-Id: <20230405152745.24959-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230405152745.24959-1-andriy.shevchenko@linux.intel.com>
References: <20230405152745.24959-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
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
Acked-by: Bumwoo Lee <bw365.lee@samsung.com>
---
 drivers/extcon/extcon.c | 15 ++++++++++++---
 drivers/extcon/extcon.h |  2 ++
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/extcon/extcon.c b/drivers/extcon/extcon.c
index 75a0147703c0..daaded92cf80 100644
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
@@ -1269,8 +1270,13 @@ int extcon_dev_register(struct extcon_dev *edev)
 	edev->dev.class = extcon_class;
 	edev->dev.release = extcon_dev_release;
 
-	dev_set_name(&edev->dev, "extcon%lu",
-			(unsigned long)atomic_inc_return(&edev_no));
+	ret = ida_alloc(&extcon_dev_ids, GFP_KERNEL);
+	if (ret < 0)
+		return ret;
+
+	edev->id = ret;
+
+	dev_set_name(&edev->dev, "extcon%d", edev->id);
 
 	ret = extcon_alloc_cables(edev);
 	if (ret < 0)
@@ -1333,6 +1339,7 @@ int extcon_dev_register(struct extcon_dev *edev)
 	if (edev->max_supported)
 		kfree(edev->cables);
 err_alloc_cables:
+	ida_free(&extcon_dev_ids, edev->id);
 
 	return ret;
 }
@@ -1361,6 +1368,8 @@ void extcon_dev_unregister(struct extcon_dev *edev)
 		return;
 	}
 
+	ida_free(&extcon_dev_ids, edev->id);
+
 	device_unregister(&edev->dev);
 
 	if (edev->mutually_exclusive && edev->max_supported) {
diff --git a/drivers/extcon/extcon.h b/drivers/extcon/extcon.h
index 9ce7042606d7..5744c325e226 100644
--- a/drivers/extcon/extcon.h
+++ b/drivers/extcon/extcon.h
@@ -18,6 +18,7 @@
  *			{0x3, 0x6, 0x5, 0}. If it is {0xFFFFFFFF, 0}, there
  *			can be no simultaneous connections.
  * @dev:		Device of this extcon.
+ * @id:			Unique device ID of this extcon.
  * @state:		Attach/detach state of this extcon. Do not provide at
  *			register-time.
  * @nh_all:		Notifier for the state change events for all supported
@@ -43,6 +44,7 @@ struct extcon_dev {
 
 	/* Internal data. Please do not set. */
 	struct device dev;
+	unsigned int id;
 	struct raw_notifier_head nh_all;
 	struct raw_notifier_head *nh;
 	struct list_head entry;
-- 
2.40.0.1.gaa8946217a0b

