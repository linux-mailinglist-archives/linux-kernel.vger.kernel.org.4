Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F807622EBB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 16:07:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231892AbiKIPHc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 10:07:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231934AbiKIPHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 10:07:23 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B84A41EAD0;
        Wed,  9 Nov 2022 07:07:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668006434; x=1699542434;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=12urufDK5YVBXS9P1VBHKN4cADzO9/4e8Qe6/OljC/o=;
  b=O/Pv3IVCpgAJVoC+NX8vGPw4mu6D5H6ETZVTcdbYIqND0BX6YSVP8Xb3
   xtboVIqdFZPK4WA1HTpjnH8OQ/eqByeZdmoHNJkjTxHiKnA+gl/G8K7t2
   TCJIKnWwml65jSF713ND4k2jRWXGf4VYO1NPV65GKx/Ogt6Tb/GFtkDZq
   N8kv1hEZWh1m+Z3vP72hTYOAsz7PWT4y6biabDyvA6L5i1K1/cnFD4a3C
   ELv7ZR9McSwGPqJxZnH3VZBofoVCG8iY1pqIL57t7RCak/enI26WX9R6O
   6x0mcmG6A9fCC41SB3dDCTAYoB2NKxz0YcfbaHLBS35RFvRiFzxJNqHX7
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="312798219"
X-IronPort-AV: E=Sophos;i="5.96,150,1665471600"; 
   d="scan'208";a="312798219"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2022 07:07:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="705736958"
X-IronPort-AV: E=Sophos;i="5.96,150,1665471600"; 
   d="scan'208";a="705736958"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 09 Nov 2022 07:07:11 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 905DB155; Wed,  9 Nov 2022 17:07:35 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/2] gpiolib: of: Prepare of_mm_gpiochip_add_data() for fwnode
Date:   Wed,  9 Nov 2022 17:07:33 +0200
Message-Id: <20221109150734.38874-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GPIO library is getting rid of of_node, fwnode should be utilized instead.
Prepare of_mm_gpiochip_add_data() for fwnode.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpiolib-of.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index 4be3c21aa718..feeb9e8e846d 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -919,14 +919,15 @@ int of_mm_gpiochip_add_data(struct device_node *np,
 			    struct of_mm_gpio_chip *mm_gc,
 			    void *data)
 {
+	struct fwnode_handle *fwnode = of_fwnode_handle(np);
 	int ret = -ENOMEM;
 	struct gpio_chip *gc = &mm_gc->gc;
 
-	gc->label = kasprintf(GFP_KERNEL, "%pOF", np);
+	gc->label = kasprintf(GFP_KERNEL, "%pfw", fwnode);
 	if (!gc->label)
 		goto err0;
 
-	mm_gc->regs = of_iomap(np, 0);
+	mm_gc->regs = fwnode_iomap(fwnode, 0);
 	if (!mm_gc->regs)
 		goto err1;
 
@@ -935,8 +936,8 @@ int of_mm_gpiochip_add_data(struct device_node *np,
 	if (mm_gc->save_regs)
 		mm_gc->save_regs(mm_gc);
 
-	of_node_put(mm_gc->gc.of_node);
-	mm_gc->gc.of_node = of_node_get(np);
+	fwnode_handle_put(mm_gc->gc.fwnode);
+	mm_gc->gc.fwnode = fwnode_handle_get(fwnode);
 
 	ret = gpiochip_add_data(gc, data);
 	if (ret)
@@ -944,12 +945,12 @@ int of_mm_gpiochip_add_data(struct device_node *np,
 
 	return 0;
 err2:
-	of_node_put(np);
+	fwnode_handle_put(fwnode);
 	iounmap(mm_gc->regs);
 err1:
 	kfree(gc->label);
 err0:
-	pr_err("%pOF: GPIO chip registration failed with status %d\n", np, ret);
+	pr_err("%pfw: GPIO chip registration failed with status %d\n", fwnode, ret);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(of_mm_gpiochip_add_data);
-- 
2.35.1

