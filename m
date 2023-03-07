Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48BF96AF103
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 19:38:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232983AbjCGSiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 13:38:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbjCGShh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 13:37:37 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D10AA72AB;
        Tue,  7 Mar 2023 10:29:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678213744; x=1709749744;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QLqrVKhYTI6UhfmMR2KhHIzSzpuaBoCKkQO+o6CeEBw=;
  b=ZIFTHxHeOaaUWNbYD83MO6eMuE2lBFHcI3h0dT6cGdpCsJ20ezA2ek02
   jjV88S2YQaEqL5LTeogWp6HBVLCSxRK75d000xCrWfx4p5UtPshrhEV03
   GmK6QUN/e59sLfFun6YSwPWAG/Mw0dDSksJNF4LVax8T3k4pHPRD1WsRF
   fADffrYbm2jdeMTw22bPPHxDm7q0jHPXA4l4rNsGkDWw1FjtuF4JMR0ol
   XmnP/TiSRRMv67q9z24l69j7tFgLgA9UgEjns8OajtoVaoU06xZx2LKP0
   lM1TeVgqJYs7WlxtLfnKqtW49WNT0vSFlsh6D0gOOiJATv8X8JhHCTtVB
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="316333922"
X-IronPort-AV: E=Sophos;i="5.98,241,1673942400"; 
   d="scan'208";a="316333922"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2023 10:25:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="706902044"
X-IronPort-AV: E=Sophos;i="5.98,241,1673942400"; 
   d="scan'208";a="706902044"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 07 Mar 2023 10:25:15 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 1B563354; Tue,  7 Mar 2023 20:25:59 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v1 3/3] gpiolib: Move gpiodevice_*() to gpiodev namespace
Date:   Tue,  7 Mar 2023 20:25:57 +0200
Message-Id: <20230307182557.42215-4-andriy.shevchenko@linux.intel.com>
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

The functions that operates on the same device object would
have the same namespace for better code understanding and
maintenance.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpiolib.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index a44a1b0f2766..45f79aee451a 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -573,7 +573,7 @@ bool gpiochip_line_is_valid(const struct gpio_chip *gc,
 }
 EXPORT_SYMBOL_GPL(gpiochip_line_is_valid);
 
-static void gpiodevice_release(struct device *dev)
+static void gpiodev_release(struct device *dev)
 {
 	struct gpio_device *gdev = to_gpio_device(dev);
 	unsigned long flags;
@@ -617,7 +617,7 @@ static int gpiochip_setup_dev(struct gpio_device *gdev)
 		return ret;
 
 	/* From this point, the .release() function cleans up gpio_device */
-	gdev->dev.release = gpiodevice_release;
+	gdev->dev.release = gpiodev_release;
 
 	ret = gpiochip_sysfs_register(gdev);
 	if (ret)
-- 
2.39.1

