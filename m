Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20610745C0B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 14:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230441AbjGCMS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 08:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjGCMSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 08:18:49 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBA3410E;
        Mon,  3 Jul 2023 05:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688386728; x=1719922728;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=f5cSMS9Hc/IEGZhdqhDLhD3xAE26SJ8iHGtEWOKDz/4=;
  b=GUqLaMmnCfAMT1FkTY3g/JBFtHgAbOAk4wIzHmyYLFv68uwpkhpBbGfx
   1QzTVRFGjDX8eBKhKSo+Znc4JBeweHOUuRkXDZYucw2I/0HyuX//Q21Vj
   7czSzPjc6X4jRrzZ3KVp+6jiBILbhC9UdY2N+fmL0ZvT7MzN+ttb0gERz
   Q6Eut9fYtPJD8Gvgt/ZQ5xUIClNyKUHx7RKYISmcbF1Pfau19ZROuVkzf
   EeFJWKOpn/J4QFs0Xy/NIQv8H1YeBxPRIge3CpFmUC4LV6Mr9ly+Se7PI
   vlkVqqsBS7/Jc81Xfz2cyIgMVWxdlhrUeICi6BO32nE45x9zEyUpoto5c
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10759"; a="449242344"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="449242344"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2023 05:18:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10759"; a="863065885"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="863065885"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 03 Jul 2023 05:18:39 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 22F6113C; Mon,  3 Jul 2023 15:18:42 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v1 1/3] gpiolib: of: Don't use GPIO chip fwnode in of_gpiochip_*()
Date:   Mon,  3 Jul 2023 15:18:36 +0300
Message-Id: <20230703121838.70898-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230703121838.70898-1-andriy.shevchenko@linux.intel.com>
References: <20230703121838.70898-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GPIO library should rely only on the GPIO device's fwnode.
Hence, replace GPIO chip fwnode usage by respective OF node
from GPIO device.

JFYI, this is partial revert of 8afe82550240 ("gpiolib: of:
Prepare of_gpiochip_add() / of_gpiochip_remove() for fwnode").

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpiolib-of.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index 1436cdb5fa26..5fde5a3f5118 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -1078,16 +1078,16 @@ int of_gpiochip_add(struct gpio_chip *chip)
 	if (ret)
 		return ret;
 
-	fwnode_handle_get(chip->fwnode);
+	of_node_get(np);
 
 	ret = of_gpiochip_scan_gpios(chip);
 	if (ret)
-		fwnode_handle_put(chip->fwnode);
+		of_node_put(np);
 
 	return ret;
 }
 
 void of_gpiochip_remove(struct gpio_chip *chip)
 {
-	fwnode_handle_put(chip->fwnode);
+	of_node_put(dev_of_node(&chip->gpiodev->dev));
 }
-- 
2.40.0.1.gaa8946217a0b

