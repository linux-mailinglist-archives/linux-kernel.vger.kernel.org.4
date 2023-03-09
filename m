Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB6816B2D13
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 19:46:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbjCISqQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 13:46:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjCISqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 13:46:14 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26530F9D32;
        Thu,  9 Mar 2023 10:46:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678387573; x=1709923573;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=MWfjkyFiaRXBagLW9d5hgMVgjJMLMDz/A3buAj1LPk4=;
  b=Qi8ixyQUO7if4sQMwstRcLLd8n6wtVWFxlGNi5Kmc3h1lgesicP4nyzD
   c3YeAWViu6N69BT/GfVyG75TRoiOnnT6aHnY5XoIvf/Jhk0QzjjFMuYMS
   dJL9uTWrOGdVU10G5pMxHqEWlVq9b44dDmTmORLn82XZuLFDKSyTJ/eCL
   DbOhYO9WtppvFEjDz0iXcb8PVL5I6HwmdN1kWkRYgfyt/n0L3Su6IMdpd
   yyae52naxpZoCoRkLeUq3DtaVkWQHf6Iak5dVhH2tIf5vZR7KBM5cafsc
   MHLWnIUPz9myzalVRpjpgJF2CAiMx6dKKgpKpjsFKNBhIOY//CMQ3W1/G
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="334012434"
X-IronPort-AV: E=Sophos;i="5.98,247,1673942400"; 
   d="scan'208";a="334012434"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 10:45:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="801274606"
X-IronPort-AV: E=Sophos;i="5.98,247,1673942400"; 
   d="scan'208";a="801274606"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 09 Mar 2023 10:45:56 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 0AFE2143; Thu,  9 Mar 2023 20:46:39 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v1 1/2] gpio: sim: Deactivate device in reversed order
Date:   Thu,  9 Mar 2023 20:46:35 +0200
Message-Id: <20230309184636.84124-1-andriy.shevchenko@linux.intel.com>
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

Run the steps to deactivate device in the reserved order to what
it has been done in gpio_sim_device_activate_unlocked().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpio-sim.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-sim.c b/drivers/gpio/gpio-sim.c
index e5dfd636c63c..a1c8702f362c 100644
--- a/drivers/gpio/gpio-sim.c
+++ b/drivers/gpio/gpio-sim.c
@@ -953,9 +953,9 @@ static void gpio_sim_device_deactivate_unlocked(struct gpio_sim_device *dev)
 
 	swnode = dev_fwnode(&dev->pdev->dev);
 	platform_device_unregister(dev->pdev);
+	gpio_sim_remove_hogs(dev);
 	gpio_sim_remove_swnode_recursive(swnode);
 	dev->pdev = NULL;
-	gpio_sim_remove_hogs(dev);
 }
 
 static ssize_t
-- 
2.39.1

