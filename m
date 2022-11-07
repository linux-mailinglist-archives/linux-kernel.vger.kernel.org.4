Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A2FD61F887
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 17:11:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232348AbiKGQLH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 11:11:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231557AbiKGQLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 11:11:04 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23BF9254;
        Mon,  7 Nov 2022 08:11:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667837464; x=1699373464;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/kSwwswIzgCUAxVBjbvEobr7bEAkyBfEjUc94Vf2hq4=;
  b=MVthJ47D5e0Q/HsA/oSXeNIhCmeE81stHEEqQ+vuIxLbaiEXwC5TTUht
   ADRZ/9c+kQmvqJoV+O9yhemIpm0B+Y+XhVb5DVgCJOF7v9KNB0OJqPRfK
   eNpEm5Nn/08LVu9nxLukGbl081mDISD3IHAFh2e90RtTRISvGPffNHX5o
   j+nXQ3AyE0Qa031B+v0h41qczPP44NPASdyVasOk/jF1dm1M2X1W8piSE
   HkKrMHv1Vbwt4Fhm67+e6aRqgdFfszx2mZEvupxwRw4wWwXZi99Ikqmaj
   oCLqeLKD1XYWe8XflwfvXpkME5ArLyyMTcYemQwcvjuDshZkukYjUXHUE
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="310451919"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="310451919"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 08:10:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="778543956"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="778543956"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 07 Nov 2022 08:10:08 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id E6B49F7; Mon,  7 Nov 2022 18:10:31 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v1 1/2] gpiolib: of: Prepare of_gpiochip_add() / of_gpiochip_remove() for fwnode
Date:   Mon,  7 Nov 2022 18:10:26 +0200
Message-Id: <20221107161027.43384-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GPIO library is getting rid of of_node, fwnode should be utilized instead.
Prepare of_gpiochip_add() / of_gpiochip_remove() for fwnode.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpiolib-of.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index be9c34cca322..000020eb78d8 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -1104,9 +1104,11 @@ static int of_gpiochip_add_pin_range(struct gpio_chip *chip) { return 0; }
 
 int of_gpiochip_add(struct gpio_chip *chip)
 {
+	struct device_node *np;
 	int ret;
 
-	if (!chip->of_node)
+	np = to_of_node(chip->fwnode);
+	if (!np)
 		return 0;
 
 	if (!chip->of_xlate) {
@@ -1123,18 +1125,18 @@ int of_gpiochip_add(struct gpio_chip *chip)
 	if (ret)
 		return ret;
 
-	of_node_get(chip->of_node);
+	fwnode_handle_get(chip->fwnode);
 
 	ret = of_gpiochip_scan_gpios(chip);
 	if (ret)
-		of_node_put(chip->of_node);
+		fwnode_handle_put(chip->fwnode);
 
 	return ret;
 }
 
 void of_gpiochip_remove(struct gpio_chip *chip)
 {
-	of_node_put(chip->of_node);
+	fwnode_handle_put(chip->fwnode);
 }
 
 void of_gpio_dev_init(struct gpio_chip *gc, struct gpio_device *gdev)
-- 
2.35.1

