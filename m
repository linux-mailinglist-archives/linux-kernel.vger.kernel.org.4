Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14A206B2D45
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 19:59:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbjCIS7K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 13:59:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbjCIS7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 13:59:03 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7DA7867F2;
        Thu,  9 Mar 2023 10:59:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678388341; x=1709924341;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UVnjSpsZBJSXcrq/25yza+3iaDPgwDpONa5MymtZ4DU=;
  b=d5sFyUkQZPK3C8A6RC1swppjvbNRak9afN+xFXN0SMPvEtO8+uj9T/o3
   24hMtHVTwROVs64ZASgmFHJHlg8FWO7CnCUB1G75WC0/C/SzqdO9avwEg
   Gb4I59xLhHsEKJIlD8llOITEZvvRfLhK04TC+DYlZIhClutoD1hLejaA+
   b6ard2MKTfFRsDB+ezUinAzB30bbewJAITaXSuMnyHLCPEsOMAts31+Z2
   kiTDer+8DW7nQ/5KKtmb6v9B7mse6TNkpjaebBcYOkwB0K3pPTVBTd1v/
   b00bmPoBJqmIIvkRw9LVhlINfKhcCneNTxZv86zNM4JT4Uqy2SB6HXYcN
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="338082115"
X-IronPort-AV: E=Sophos;i="5.98,247,1673942400"; 
   d="scan'208";a="338082115"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 10:55:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="627483744"
X-IronPort-AV: E=Sophos;i="5.98,247,1673942400"; 
   d="scan'208";a="627483744"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 09 Mar 2023 10:55:22 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 25254143; Thu,  9 Mar 2023 20:56:05 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v1 1/1] gpiolib: Get rid of devprop prefix in one function
Date:   Thu,  9 Mar 2023 20:56:00 +0200
Message-Id: <20230309185600.84948-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The devprop prefix in the devprop_gpiochip_set_names() adds confusion.
Get rid of it.

Note we have more than one function in the same module that handles
one or more device properties. This change will unify the naming schema
for all of them.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpiolib.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 45f79aee451a..8ecfe3afde1e 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -374,7 +374,7 @@ static int gpiochip_set_desc_names(struct gpio_chip *gc)
 }
 
 /*
- * devprop_gpiochip_set_names - Set GPIO line names using device properties
+ * gpiochip_set_names - Set GPIO line names using device properties
  * @chip: GPIO chip whose lines should be named, if possible
  *
  * Looks for device property "gpio-line-names" and if it exists assigns
@@ -382,7 +382,7 @@ static int gpiochip_set_desc_names(struct gpio_chip *gc)
  * names belong to the underlying firmware node and should not be released
  * by the caller.
  */
-static int devprop_gpiochip_set_names(struct gpio_chip *chip)
+static int gpiochip_set_names(struct gpio_chip *chip)
 {
 	struct gpio_device *gdev = chip->gpiodev;
 	struct device *dev = &gdev->dev;
@@ -834,7 +834,7 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 		if (ret)
 			goto err_remove_from_list;
 	}
-	ret = devprop_gpiochip_set_names(gc);
+	ret = gpiochip_set_names(gc);
 	if (ret)
 		goto err_remove_from_list;
 
-- 
2.39.1

