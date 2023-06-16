Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59A0173328D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 15:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343939AbjFPNxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 09:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbjFPNxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 09:53:11 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CE8C2702;
        Fri, 16 Jun 2023 06:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686923590; x=1718459590;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+QO+MDFPjf3DM3i+P0PsLuvBxZJWReEj53mswRyVrnc=;
  b=fnkgKFYwNvlrKbqGyeEmy8EOTtrCTtO7bawkhmtxDXgk40L1djVzEfDi
   YEK9/pY+EqW4dDraKW9jZxp3rTkeHmUMWMm9fc/UnT6m07t20jFFOdm1a
   S2YN3yLOkVTiJewPMvIfN6Y6XY5nvRFL5vu0mzpGRjdvPyX9OrNGiPqVf
   3eb25jxgT0oMvWFDxnakPsHZGMUvz+kAm2TRuWxWUyPri7bHfq4JRy4d7
   QWmea3Nwiy3NFRwizzLbz+qLvihS0wion3HK6gKdF+h6+dEHHHU5jhkWg
   qEhQiWkCrO0PA48rh/tO5qFMpAvSy2tmAOtfGPz/iyp8h5xy4YetwwLzH
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="339546529"
X-IronPort-AV: E=Sophos;i="6.00,247,1681196400"; 
   d="scan'208";a="339546529"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2023 06:53:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="1043100681"
X-IronPort-AV: E=Sophos;i="6.00,247,1681196400"; 
   d="scan'208";a="1043100681"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 16 Jun 2023 06:53:08 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 621C0379; Fri, 16 Jun 2023 16:53:17 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v1 1/1] gpiolib: Drop unused domain_ops memeber of GPIO IRQ chip
Date:   Fri, 16 Jun 2023 16:53:13 +0300
Message-Id: <20230616135313.76338-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It seems there is no driver that requires custom IRQ chip
domain options. Drop the member and respective code.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpiolib.c      | 3 +--
 include/linux/gpio/driver.h | 7 -------
 2 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 5fb64c7d7473..4b404beddcf2 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1668,11 +1668,10 @@ static int gpiochip_add_irqchip(struct gpio_chip *gc,
 		if (ret)
 			return ret;
 	} else {
-		/* Some drivers provide custom irqdomain ops */
 		gc->irq.domain = irq_domain_create_simple(fwnode,
 			gc->ngpio,
 			gc->irq.first,
-			gc->irq.domain_ops ?: &gpiochip_domain_ops,
+			&gpiochip_domain_ops,
 			gc);
 		if (!gc->irq.domain)
 			return -EINVAL;
diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
index 5c6db5533be6..6879b5436480 100644
--- a/include/linux/gpio/driver.h
+++ b/include/linux/gpio/driver.h
@@ -61,13 +61,6 @@ struct gpio_irq_chip {
 	 */
 	struct irq_domain *domain;
 
-	/**
-	 * @domain_ops:
-	 *
-	 * Table of interrupt domain operations for this IRQ chip.
-	 */
-	const struct irq_domain_ops *domain_ops;
-
 #ifdef CONFIG_IRQ_DOMAIN_HIERARCHY
 	/**
 	 * @fwnode:
-- 
2.40.0.1.gaa8946217a0b

