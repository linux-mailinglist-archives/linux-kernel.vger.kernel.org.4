Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10EB6621285
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 14:38:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233858AbiKHNig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 08:38:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233838AbiKHNie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 08:38:34 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03D5E140A5;
        Tue,  8 Nov 2022 05:38:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667914713; x=1699450713;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=y5ikHZVDzBDAbzXZVQX8BOA8McQsKuEoNy6zaj2sDcE=;
  b=W3sbYhR8I9r6umV3qD0KSslXzg083T84gQl5SWAj9PHE5TS2RuXK/Ixm
   OFhb7n1vjy5UYdWad1duz/GDofLxjjPvUjTon1xrntOW+USd8cuoUmGGV
   dFE59UjllPPCcu24O1cOtriCPkhx4oCPbgta2hzDWK3IuytLvY93x5Mfx
   GR9w3kOTZW4mLFpD/xSkEqX+p6JS57BhkvCdyiSnVYc2OQmp9Q3sVBABB
   9CO7p/Z4oFrh65FFkGjX3Tjr6H09OORFiEvl0xvcRNESe22WlqcMcrb43
   hMrzqYpb6WJfBPGc/J6HiB59mRHxrqIBQ2HXsahPN18KGPnJldbwYliTA
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="311848580"
X-IronPort-AV: E=Sophos;i="5.96,147,1665471600"; 
   d="scan'208";a="311848580"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 05:38:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="614280814"
X-IronPort-AV: E=Sophos;i="5.96,147,1665471600"; 
   d="scan'208";a="614280814"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 08 Nov 2022 05:38:30 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id B7BC615C; Tue,  8 Nov 2022 15:38:54 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v2 1/2] gpiolib: of: Prepare of_gpiochip_add() / of_gpiochip_remove() for fwnode
Date:   Tue,  8 Nov 2022 15:38:52 +0200
Message-Id: <20221108133853.61884-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
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

GPIO library is getting rid of of_node, fwnode should be utilized instead.
Prepare of_gpiochip_add() / of_gpiochip_remove() for fwnode.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
v2: added tag (Dmitry)
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

base-commit: 80280df758c1498485988b30cf6887fde7796056
-- 
2.35.1

