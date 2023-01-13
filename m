Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 455BF66A573
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 22:53:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbjAMVxs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 16:53:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231202AbjAMVxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 16:53:39 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6993589BE3;
        Fri, 13 Jan 2023 13:53:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673646818; x=1705182818;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Y3oi7Gj2ErV8+ybgUGSfWPirQT8+KB+Vm+W6w2+sHKU=;
  b=PwyQitnIHdPil6OYFRrSA6GhsoV5BTYUU2lBulxY/xQfcpUDeNVhoSeP
   3wXQsinn4ElwFvrKRbBtAn1mG/BcLdq/lmUnpEpojnjNcrBcxo9blqetV
   IhPCG6XUZkjzI4Bn3mrNV4p/twcckJJZcb5cCgMBxxOG3HDp8u31oPt8B
   Cnweihs9W4nB6XAmt6B4r9LBbgjfSpLEJwmcPv14vf7SL+8J8xEFZzoaM
   XGkS6dMeQ4oLNHpx4BGF/LsSIKaaMmpZX9B1zehCtJHfiqr2wDVqQiYcd
   suNFnXPfY8Im9E0g889IATwwtjydmsH+r6sOCqZo+54w8xHTyDW2bLnNM
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="351343147"
X-IronPort-AV: E=Sophos;i="5.97,214,1669104000"; 
   d="scan'208";a="351343147"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 13:53:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="766170867"
X-IronPort-AV: E=Sophos;i="5.97,215,1669104000"; 
   d="scan'208";a="766170867"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 13 Jan 2023 13:53:22 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 658C292; Fri, 13 Jan 2023 23:53:56 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH v3 1/4] gpiolib: Check "gpio-ranges" before calling ->add_pin_ranges()
Date:   Fri, 13 Jan 2023 23:53:49 +0200
Message-Id: <20230113215352.44272-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230113215352.44272-1-andriy.shevchenko@linux.intel.com>
References: <20230113215352.44272-1-andriy.shevchenko@linux.intel.com>
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

The ->add_pin_ranges() is supposed to be called for the backward
compatiblity on Device Tree platforms or non-DT ones. Ensure that
by checking presense of the "gpio-ranges" property.

This allows to clean up a few existing drivers to avoid duplication
of the check.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpiolib.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 16858ef4dac1..49cfcc7510e1 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -533,6 +533,14 @@ static void gpiochip_free_valid_mask(struct gpio_chip *gc)
 
 static int gpiochip_add_pin_ranges(struct gpio_chip *gc)
 {
+	/*
+	 * Device Tree platforms are supposed to use "gpio-ranges"
+	 * property. This check ensures that the ->add_pin_ranges()
+	 * won't be called for them.
+	 */
+	if (device_property_present(&gc->gpiodev->dev, "gpio-ranges"))
+		return 0;
+
 	if (gc->add_pin_ranges)
 		return gc->add_pin_ranges(gc);
 
-- 
2.39.0

