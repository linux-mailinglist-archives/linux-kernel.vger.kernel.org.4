Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FA97745C12
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 14:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230460AbjGCMTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 08:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbjGCMSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 08:18:55 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F5B198;
        Mon,  3 Jul 2023 05:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688386734; x=1719922734;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WIw/lYPfjECKbt13n6a0kFhIAeRW5JIxgsAB/IJQ1rk=;
  b=NR7pOi/Du+1ITsJMKe0RoIJO3/1xVABhTDx1bF8B3Ja9FxqBiFCfkn9w
   NYj3LV3OuqZwTL0sKQa1IcgYdNPH3mdljLFZ+8pAchd/K8PHdDN22TnCZ
   QvigVOzxxjLOXlcHwxa8AYpIn2ZrgQk2xzVpPSWJ8sD6FNbXXWOqhTHEs
   Nf9QZ8gMykawZ5PJ/8RXFW4dfSNaf8ONKVfgXMy1zjYb1l3a5nrEHUW7o
   hYvMzD2agldkLZh1Kmfn5tgwvN9zgvlGL7L5GkP1RaSlO7DQ2X4j7NKhC
   C3qNuxU1JttvpuIOzQiqh0b868QE2vEUIYklN4whoAJD9mnbhbs7VCZHe
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10759"; a="343200935"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="343200935"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2023 05:18:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10759"; a="831811640"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="831811640"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 03 Jul 2023 05:18:39 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 288F9177; Mon,  3 Jul 2023 15:18:42 +0300 (EEST)
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
Subject: [PATCH v1 2/3] gpiolib: acpi: Don't use GPIO chip fwnode in acpi_gpiochip_find()
Date:   Mon,  3 Jul 2023 15:18:37 +0300
Message-Id: <20230703121838.70898-3-andriy.shevchenko@linux.intel.com>
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
Hence, replace GPIO chip fwnode usage by respective fwnode
from GPIO device.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpiolib-acpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index 97496c0f9133..cafbf9597ead 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -128,7 +128,7 @@ static bool acpi_gpio_deferred_req_irqs_done;
 
 static int acpi_gpiochip_find(struct gpio_chip *gc, void *data)
 {
-	return ACPI_HANDLE_FWNODE(gc->fwnode) == data;
+	return ACPI_HANDLE(&gc->gpiodev->dev) == data;
 }
 
 /**
-- 
2.40.0.1.gaa8946217a0b

