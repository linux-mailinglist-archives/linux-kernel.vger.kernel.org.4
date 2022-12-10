Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C77766490F6
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Dec 2022 23:06:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbiLJWF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Dec 2022 17:05:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbiLJWFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Dec 2022 17:05:39 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A644111C3B;
        Sat, 10 Dec 2022 14:05:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670709938; x=1702245938;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MnNwcdMxEciJeVyGc4ORlNy3VU7ZtA7su0OonJmjLgM=;
  b=MGAAQ4RqqMkoNzrU6bj0+pmfGzB6amo9IJaRA3kIpibd6naKqy6WV1jQ
   rQZovSo8d5nCVTtZ2IOGwNOWWOLqfXw8gA7LeQBj4ZTFwjwIU0dENa+AV
   XOlxUFykZK41Ow5OAxvgVf17pu9jyRhp/lqp+P/CtaCIwawbxNsHRbscS
   S4aLq84iC3oneIpghS0vDW80/8A30o6tLWLa4XJPHfXk8q4Qnsu3eCjJU
   iG/tFCqjN9QC6I3QfkGB+iOdgREvt5GUXvDQqv9UwAq4ew6gZoiYdSxPA
   muvztjwocE+xOSsu6O/RXv+bMa9JN3OL/qqfHxHMMxng9wk8aunpRuu8c
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10557"; a="298001324"
X-IronPort-AV: E=Sophos;i="5.96,235,1665471600"; 
   d="scan'208";a="298001324"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2022 14:05:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10557"; a="754448425"
X-IronPort-AV: E=Sophos;i="5.96,235,1665471600"; 
   d="scan'208";a="754448425"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 10 Dec 2022 14:05:36 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 64A8A6E2; Sun, 11 Dec 2022 00:06:05 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 4/4] gpio: pca953x: Remove unused PCAL953X_OUT_CONF from pcal6534_recalc_addr()
Date:   Sun, 11 Dec 2022 00:06:01 +0200
Message-Id: <20221210220601.77648-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221210220601.77648-1-andriy.shevchenko@linux.intel.com>
References: <20221210220601.77648-1-andriy.shevchenko@linux.intel.com>
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

First of all, PCAL953X_OUT_CONF is not used in the driver.
Second, it's not a per-bank register, it's a single for the
chip and should be handled differently anyway.

To avoid confusion, drop PCAL953X_OUT_CONF from pcal6534_recalc_addr().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: new patch
 drivers/gpio/gpio-pca953x.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpio/gpio-pca953x.c b/drivers/gpio/gpio-pca953x.c
index 8aba8df393bd..1286b22ef23a 100644
--- a/drivers/gpio/gpio-pca953x.c
+++ b/drivers/gpio/gpio-pca953x.c
@@ -461,7 +461,6 @@ static u8 pcal6534_recalc_addr(struct pca953x_chip *chip, int reg, int off)
 	case PCAL953X_PULL_SEL:
 	case PCAL953X_INT_MASK:
 	case PCAL953X_INT_STAT:
-	case PCAL953X_OUT_CONF:
 		pinctrl = ((reg & PCAL_PINCTRL_MASK) >> 1) + 0x20;
 		break;
 	case PCAL6524_INT_EDGE:
-- 
2.35.1

