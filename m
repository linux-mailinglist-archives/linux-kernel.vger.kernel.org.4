Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECD296937B8
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Feb 2023 15:14:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbjBLOOB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 09:14:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjBLOOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 09:14:00 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DF6E10AAA;
        Sun, 12 Feb 2023 06:13:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676211239; x=1707747239;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=dJjoevxJv8WPOiMchNdMnrmz/kafLm9V9v9ypKCpfUU=;
  b=lGISNlXhlnjhaMJ/j/iv6c0oNDaKDuhTksnU81i4ZcP6GljQq3Ymxneq
   78DbSZx8Ps8oRzEG2jsPSASWL64YJjrcRi2Y1xU2R5/xlqumPPnxNJPQ5
   E5tLy7RFnz5ltQi9nHwFs+Kbed1oQMLPPs0SF1Qc/GLBOnD3yY0EFrzSh
   qrIh/22i/G4LygB+zFoypsOvGz3l9XS2LBtpCYjV3zeUUraO2kD5Ifwc7
   uIT/BmSJOy+JNchZWuiLu1JyYw56X+GXy1dBpe8gzR2CPmB0Cc8OaoKC1
   xXN5JL34/y17cx+Bzq7gMkHUV/S6RVWV1XkVxGzJCJG/6HsfXZaiOjaJz
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10618"; a="395330837"
X-IronPort-AV: E=Sophos;i="5.97,291,1669104000"; 
   d="scan'208";a="395330837"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2023 06:13:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10618"; a="646124893"
X-IronPort-AV: E=Sophos;i="5.97,291,1669104000"; 
   d="scan'208";a="646124893"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 12 Feb 2023 06:13:56 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id E36071A6; Sun, 12 Feb 2023 16:14:35 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v1 1/1] gpio: sim: Use %pfwP specifier instead of calling fwnode API directly
Date:   Sun, 12 Feb 2023 16:13:55 +0200
Message-Id: <20230212141355.12794-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.39.1
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

Instead of calling fwnode_get_name() and supply as %s, use %pfwP which
will do the same inside printf() call.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpio-sim.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/gpio/gpio-sim.c b/drivers/gpio/gpio-sim.c
index 60514bc5454f..a51b5ea38ad5 100644
--- a/drivers/gpio/gpio-sim.c
+++ b/drivers/gpio/gpio-sim.c
@@ -377,8 +377,8 @@ static int gpio_sim_add_bank(struct fwnode_handle *swnode, struct device *dev)
 
 	ret = fwnode_property_read_string(swnode, "gpio-sim,label", &label);
 	if (ret) {
-		label = devm_kasprintf(dev, GFP_KERNEL, "%s-%s",
-				       dev_name(dev), fwnode_get_name(swnode));
+		label = devm_kasprintf(dev, GFP_KERNEL, "%s-%pfwP",
+				       dev_name(dev), swnode);
 		if (!label)
 			return -ENOMEM;
 	}
@@ -784,10 +784,9 @@ static int gpio_sim_add_hogs(struct gpio_sim_device *dev)
 							  GFP_KERNEL);
 			else
 				hog->chip_label = kasprintf(GFP_KERNEL,
-							"gpio-sim.%u-%s",
+							"gpio-sim.%u-%pfwP",
 							dev->id,
-							fwnode_get_name(
-								bank->swnode));
+							bank->swnode);
 			if (!hog->chip_label) {
 				gpio_sim_remove_hogs(dev);
 				return -ENOMEM;
-- 
2.39.1

