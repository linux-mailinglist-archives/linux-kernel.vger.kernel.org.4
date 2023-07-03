Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF399745E72
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 16:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbjGCOXS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 10:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230258AbjGCOXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 10:23:12 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6779EE5C;
        Mon,  3 Jul 2023 07:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688394191; x=1719930191;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DNmqWKEUkkpN5FpohkxiaOCL3JlrnO8cxsg2K7hyZ1U=;
  b=UAw3yuAdSrsx+cmvhnd2skVGDP8IHq1rDSsV1POL75Xf4Sq2ZKFF12U/
   tLxuLWDan/WOGbmODDHYC1ra9c+fqkP2aK2Dh6GwXrsmp6C1NqeMNPui+
   G7fQ973wUBkNftIp6TmxsIWt1GUSbV6gYanUyV5RrudewNocFnBLnamw5
   s4vkOSvXN5FN6iu5Fst1jdD7BVxnW8X6PnJN68qPx+CUp72FuhfQbboPV
   GEDoi/86zmwQUUuCUSlFJjaHQNVCesJrJ3pxUdSRmC6gmYaKmLQXFBc0f
   OmFonCXY/glOJdzcgET5L4FnshuSAMfmLQj0uF8rlzUJrwUkJ20SMGOZN
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="347681270"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="347681270"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2023 07:23:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="783917061"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="783917061"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 03 Jul 2023 07:23:06 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id C9B44177; Mon,  3 Jul 2023 17:23:09 +0300 (EEST)
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
Subject: [PATCH v2 2/3] gpiolib: acpi: Don't use GPIO chip fwnode in acpi_gpiochip_find()
Date:   Mon,  3 Jul 2023 17:23:07 +0300
Message-Id: <20230703142308.5772-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230703142308.5772-1-andriy.shevchenko@linux.intel.com>
References: <20230703142308.5772-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GPIO library should rely only on the GPIO device's fwnode.
Hence, replace GPIO chip fwnode usage by respective handle
of the GPIO device.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Tested-by: Benjamin Tissoires <bentiss@kernel.org>
---
 drivers/gpio/gpiolib-acpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index 97496c0f9133..fbda452fb4d6 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -128,7 +128,7 @@ static bool acpi_gpio_deferred_req_irqs_done;
 
 static int acpi_gpiochip_find(struct gpio_chip *gc, void *data)
 {
-	return ACPI_HANDLE_FWNODE(gc->fwnode) == data;
+	return device_match_acpi_handle(&gc->gpiodev->dev, data);
 }
 
 /**
-- 
2.40.0.1.gaa8946217a0b

