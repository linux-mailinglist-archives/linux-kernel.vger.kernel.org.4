Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15F02667C02
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 17:54:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240960AbjALQxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 11:53:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241620AbjALQu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 11:50:56 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B5855B149;
        Thu, 12 Jan 2023 08:39:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673541585; x=1705077585;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WIWZ0DmAMKPeq1ebVrtoFWO2d/xuqrJNfK25fBjzBSY=;
  b=boCmxMT389eKgtro9IqEkxHiFSysEpRNfuWj4YhKfbz2HMzWEDZzHwrE
   o5aXMcIn6hf6NU6M1SFyLdnbrluwThKvv/bgAn5W6ulHOMuw0FYpdIIXO
   82zoHlxEPUlLcaJloz/KE+TMw3mJdBy22OhxsRfxCGLDqRt5T/HuHfFWw
   lkPOsAqQ2jsE9qnJfzYF82gvZDEtSD14d8jUyh3nQ//sbYwnh3CxxK8rq
   G7teWj2Dd9oGwL/spohvjuvbJeYRsAYfW3xHHQUL2w1FCD4pa5kENkoXL
   Cdk/y0sXOPmTc5xgRXV8B20/LwmHJOH6RSJMlW293zBWbJ5zcqEBJuctC
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="304132815"
X-IronPort-AV: E=Sophos;i="5.97,211,1669104000"; 
   d="scan'208";a="304132815"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 08:39:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="635447556"
X-IronPort-AV: E=Sophos;i="5.97,211,1669104000"; 
   d="scan'208";a="635447556"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 12 Jan 2023 08:39:10 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 26792130; Thu, 12 Jan 2023 18:39:44 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Moses Christopher Bollavarapu <mosescb.dev@gmail.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v1 2/2] gpio: zevio: Use proper headers and drop OF_GPIO dependency
Date:   Thu, 12 Jan 2023 18:39:41 +0200
Message-Id: <20230112163941.73143-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230112163941.73143-1-andriy.shevchenko@linux.intel.com>
References: <20230112163941.73143-1-andriy.shevchenko@linux.intel.com>
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

The driver doesn't depend on the OF_GPIO to be compiled. Hence
the proper header to use is mod_devicetable.h. Replace of*.h with
the above mentioned and drop redundant dependency.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/Kconfig      | 2 +-
 drivers/gpio/gpio-zevio.c | 7 ++++---
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 3b2078a654ce..a2f64f880163 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -751,7 +751,7 @@ config GPIO_XTENSA
 
 config GPIO_ZEVIO
 	bool "LSI ZEVIO SoC memory mapped GPIOs"
-	depends on ARM && OF_GPIO
+	depends on ARM
 	help
 	  Say yes here to support the GPIO controller in LSI ZEVIO SoCs.
 
diff --git a/drivers/gpio/gpio-zevio.c b/drivers/gpio/gpio-zevio.c
index c9f4c26cae3d..61e47456c33a 100644
--- a/drivers/gpio/gpio-zevio.c
+++ b/drivers/gpio/gpio-zevio.c
@@ -5,13 +5,14 @@
  * Author: Fabian Vogt <fabian@ritter-vogt.de>
  */
 
-#include <linux/spinlock.h>
+#include <linux/bitops.h>
 #include <linux/errno.h>
 #include <linux/init.h>
-#include <linux/bitops.h>
 #include <linux/io.h>
-#include <linux/of_device.h>
+#include <linux/mod_devicetable.h>
 #include <linux/slab.h>
+#include <linux/spinlock.h>
+
 #include <linux/gpio/driver.h>
 
 /*
-- 
2.39.0

