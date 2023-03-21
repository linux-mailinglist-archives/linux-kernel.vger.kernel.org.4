Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D6AC6C3370
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 14:54:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbjCUNyK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 09:54:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231341AbjCUNyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 09:54:00 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1EC713DDE;
        Tue, 21 Mar 2023 06:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679406816; x=1710942816;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=DfICKX1W2R7vQASH04NFqYi2PpmnHCZONn2UQmTBkkU=;
  b=A9ObHXqcAW2mIxUyil8fJqiVSD9F1K2VrHAIPQEFekUCPEvksduv6HCy
   6r+sRBRODrSyF9gg9tBZIV7xniOgMNh3yIPr7ySOGHnRoNfzZ1TteW3vh
   KOTdMUZhvJOSbBNuoiJGWsusd3dmf+cQ5XlLn+qVexxqEOErh1Ec/2qd+
   H6v7CIbQWtiuk2CYiK6/iu/sH9HDs+/vcj1CVmtFFlqCl1M+bVv1/Lkb6
   STbTNN6OPSYsc78eBH2MUaQ2tWYqLeJkOOsP4sNEknG7BhaZo7lVHWLt3
   QHxjBOEcC920WUEYqiQTATtghclseffUBlWe2ilSYzIBBrrMOFK9RUOe+
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="319333151"
X-IronPort-AV: E=Sophos;i="5.98,279,1673942400"; 
   d="scan'208";a="319333151"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2023 06:53:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="713999589"
X-IronPort-AV: E=Sophos;i="5.98,279,1673942400"; 
   d="scan'208";a="713999589"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 21 Mar 2023 06:53:29 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id F39203DD; Tue, 21 Mar 2023 15:54:15 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v1 1/2] gpiolib: Replace open coded krealloc()
Date:   Tue, 21 Mar 2023 15:54:11 +0200
Message-Id: <20230321135412.73240-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gpiod_get_array() does a new allocation in some cases, followed
by copying previously allocated placeholder for the descriptors.

Replace that with krealloc(__GFP_ZERO), since it was kzalloc()
originally.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpiolib.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 112d99a5eec4..3e94990f1f90 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -4283,12 +4283,14 @@ struct gpio_descs *__must_check gpiod_get_array(struct device *dev,
 	struct gpio_array *array_info = NULL;
 	struct gpio_chip *gc;
 	int count, bitmap_size;
+	size_t descs_size;
 
 	count = gpiod_count(dev, con_id);
 	if (count < 0)
 		return ERR_PTR(count);
 
-	descs = kzalloc(struct_size(descs, desc, count), GFP_KERNEL);
+	descs_size = struct_size(descs, desc, count);
+	descs = kzalloc(descs_size, GFP_KERNEL);
 	if (!descs)
 		return ERR_PTR(-ENOMEM);
 
@@ -4312,20 +4314,17 @@ struct gpio_descs *__must_check gpiod_get_array(struct device *dev,
 			bitmap_size = BITS_TO_LONGS(gc->ngpio > count ?
 						    gc->ngpio : count);
 
-			array = kzalloc(struct_size(descs, desc, count) +
-					struct_size(array_info, invert_mask,
-					3 * bitmap_size), GFP_KERNEL);
+			array = krealloc(descs, descs_size +
+					 struct_size(array_info, invert_mask, 3 * bitmap_size),
+					 GFP_KERNEL | __GFP_ZERO);
 			if (!array) {
 				gpiod_put_array(descs);
 				return ERR_PTR(-ENOMEM);
 			}
 
-			memcpy(array, descs,
-			       struct_size(descs, desc, descs->ndescs + 1));
-			kfree(descs);
-
 			descs = array;
-			array_info = (void *)(descs->desc + count);
+
+			array_info = (void *)descs + descs_size;
 			array_info->get_mask = array_info->invert_mask +
 						  bitmap_size;
 			array_info->set_mask = array_info->get_mask +
-- 
2.40.0.1.gaa8946217a0b

