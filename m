Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F030C6AF0F7
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 19:37:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232771AbjCGShR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 13:37:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233540AbjCGSg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 13:36:26 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F538B1B10;
        Tue,  7 Mar 2023 10:28:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678213721; x=1709749721;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rGBqWdQ85mwHw6XZdhJV0eATsB9VhhV7gsdN4gandxs=;
  b=oKqkDT/5hd8AygDg+hN9QP1ozpfhNRSFv6VuFx+oTciGjsgFM0dWq+X5
   rARtEVr7xMID+BcexoSvWyovjNyv5g8Brl7iNH7WwwRvQPhwttcblkjUO
   YP8uEIq+qJLaeHBzTGXMO4mz9Ne+sN3jqY3m4R0pdm8Ofx4cbhukbfBUB
   skx1Qm4zF3YdFcuk/gnqlAok5F/jD0oOkwSfahyiYq9qrNnV6H0C9BETP
   wLzNcVHJs+hLBRW0bw1zRGCY0eFR/BYpygcFRF2hLHiQlVoEwJiQi3Flt
   z9IxBTYSzrK7R+zNU+aZmLum+ngie50r5B0OkQbCRvoAJ6UsDrF7qFKaQ
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="316333919"
X-IronPort-AV: E=Sophos;i="5.98,241,1673942400"; 
   d="scan'208";a="316333919"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2023 10:25:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="706902043"
X-IronPort-AV: E=Sophos;i="5.98,241,1673942400"; 
   d="scan'208";a="706902043"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 07 Mar 2023 10:25:15 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 074AF94; Tue,  7 Mar 2023 20:25:58 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v1 1/3] gpiolib: Access device's fwnode via dev_fwnode()
Date:   Tue,  7 Mar 2023 20:25:55 +0200
Message-Id: <20230307182557.42215-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230307182557.42215-1-andriy.shevchenko@linux.intel.com>
References: <20230307182557.42215-1-andriy.shevchenko@linux.intel.com>
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

GPIO device's fwnode should be accessed via dev_fwnode().
Make sure that gpiochip_setup_dev() follows that.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpiolib.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index b554ad435245..c7f35f0e7d15 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -589,14 +589,15 @@ static void gpiodevice_release(struct device *dev)
 
 static int gpiochip_setup_dev(struct gpio_device *gdev)
 {
+	struct fwnode_handle *fwnode = dev_fwnode(&gdev->dev);
 	int ret;
 
 	/*
 	 * If fwnode doesn't belong to another device, it's safe to clear its
 	 * initialized flag.
 	 */
-	if (gdev->dev.fwnode && !gdev->dev.fwnode->dev)
-		fwnode_dev_initialized(gdev->dev.fwnode, false);
+	if (fwnode && !fwnode->dev)
+		fwnode_dev_initialized(fwnode, false);
 
 	ret = gcdev_register(gdev, gpio_devt);
 	if (ret)
-- 
2.39.1

