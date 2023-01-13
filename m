Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B26766A216
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 19:30:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbjAMSaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 13:30:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbjAMS3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 13:29:49 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 725BF54713;
        Fri, 13 Jan 2023 10:25:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673634353; x=1705170353;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yEyvIA73WWBK7QiaW0fyWgPeZ4RwekQQZmsZrEdJq5k=;
  b=m+2+MGijumBrjGwsxFA8jb19vvKSMznI+Z2CluvP+9mTzXh6lHfu7vE5
   brUogOIJl84KEDnM3iFM3++lB5AYfPygfss5Ak2s+6MznmrO/AR6lSZa6
   vlH1EdVyXT8RV1SpBFz7pnDlVZ5tw5SRGeaFuSYC/63BpA84TCkU/AtdF
   ipDr52XF6lIrhTa0linyNB19H3keQ1tGMe2DrE0Z2LW9qXeaiHuRPpQ36
   FVU6IE5Jd2LxxNOQ/+6zps/U4RtI0iPPBtDpcoA8xVgx4oYtRphYc4aaQ
   JJLrmgQy+ukbd7J4k1IH7MfSkoQjHn1FKS1I54Op7hynlRdwUlAzRN+vt
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="410303424"
X-IronPort-AV: E=Sophos;i="5.97,214,1669104000"; 
   d="scan'208";a="410303424"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 10:25:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="800676179"
X-IronPort-AV: E=Sophos;i="5.97,214,1669104000"; 
   d="scan'208";a="800676179"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 13 Jan 2023 10:25:47 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 3D35F92; Fri, 13 Jan 2023 20:26:21 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v2 2/2] gpio: wcd934x: Use proper headers and drop OF_GPIO dependency
Date:   Fri, 13 Jan 2023 20:26:19 +0200
Message-Id: <20230113182619.16800-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230113182619.16800-1-andriy.shevchenko@linux.intel.com>
References: <20230113182619.16800-1-andriy.shevchenko@linux.intel.com>
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

The driver doesn't depend on the OF_GPIO to be complied. Hence
the proper header to use is mod_devicetable.h. Replace of*.h with
the above mentioned and drop redundant dependency.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: added one more missing header (LKP)
 drivers/gpio/Kconfig        | 2 +-
 drivers/gpio/gpio-wcd934x.c | 6 ++++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 9995e23673dd..a2f64f880163 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -700,7 +700,7 @@ config GPIO_VX855
 
 config GPIO_WCD934X
 	tristate "Qualcomm Technologies Inc WCD9340/WCD9341 GPIO controller driver"
-	depends on MFD_WCD934X && OF_GPIO
+	depends on MFD_WCD934X
 	help
          This driver is to support GPIO block found on the Qualcomm Technologies
 	 Inc WCD9340/WCD9341 Audio Codec.
diff --git a/drivers/gpio/gpio-wcd934x.c b/drivers/gpio/gpio-wcd934x.c
index 817750e4e033..b999af6b900b 100644
--- a/drivers/gpio/gpio-wcd934x.c
+++ b/drivers/gpio/gpio-wcd934x.c
@@ -1,11 +1,13 @@
 // SPDX-License-Identifier: GPL-2.0
 // Copyright (c) 2019, Linaro Limited
 
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
-#include <linux/gpio/driver.h>
+#include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
-#include <linux/of_device.h>
+
+#include <linux/gpio/driver.h>
 
 #define WCD_PIN_MASK(p) BIT(p)
 #define WCD_REG_DIR_CTL_OFFSET 0x42
-- 
2.39.0

