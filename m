Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FD89745E73
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 16:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231161AbjGCOXV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 10:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbjGCOXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 10:23:12 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 668A0E5B;
        Mon,  3 Jul 2023 07:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688394191; x=1719930191;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tQChtNbKGESPPW51x4K39nGYYp9RM7si+0oe9MCGHJo=;
  b=E5FG1hNZ8kb9XJgqT6f4mVncKazYb4mk26aA62zlsnViptpCUi+gtkzM
   sAf5RFQjwRTMxDSX9kupfBrLvXMRIGIR3rWxgrnYebC42+qvJYiQdYkBo
   vWoLu1tJPQaEt4JWnNKiY2nB5wSUZ7Mi5QnFPZSgCZg+kfVZGqfiBH05n
   uXqDKyOggx/2u4inFf52yXr2Ms3aX1Y1O7UL39qEwslx61Ik15nWDUQ0z
   2ozX4c0anFFdhhW0JkxPh4O3V8maMQ5OSs+kvRZf2HWLtfkAW7uAQ11SK
   Y4meI0S57cdBaIA/mxAXhNHBsNUl09KC4TxCBdgD2AQS0XKsA41tSWAvJ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="361752571"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="361752571"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2023 07:23:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="808602022"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="808602022"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 03 Jul 2023 07:23:06 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id BFBB613C; Mon,  3 Jul 2023 17:23:09 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Benjamin Tissoires <bentiss@kernel.org>
Subject: [PATCH v2 1/3] gpiolib: of: Don't use GPIO chip fwnode in of_gpiochip_*()
Date:   Mon,  3 Jul 2023 17:23:06 +0300
Message-Id: <20230703142308.5772-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230703142308.5772-1-andriy.shevchenko@linux.intel.com>
References: <20230703142308.5772-1-andriy.shevchenko@linux.intel.com>
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
of the GPIO device.

JFYI, this is partial revert of 8afe82550240 ("gpiolib: of:
Prepare of_gpiochip_add() / of_gpiochip_remove() for fwnode").

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Tested-by: Benjamin Tissoires <bentiss@kernel.org>
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

