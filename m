Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 749CB667C00
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 17:53:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240917AbjALQxJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 11:53:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241490AbjALQu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 11:50:27 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A4735F91E;
        Thu, 12 Jan 2023 08:39:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673541565; x=1705077565;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fVWXQlK37xmphsZHTjVPbnx5CD+Mvd7qdaqifrAOEdQ=;
  b=RWaEbQPGCblTqH7MEVnFhCXiyWq52amsFuTZ7dFUovOWDdJZmHPJGOAH
   MD5hmVtztlSrrAtNv/sQ8sOhmK/w+ZJCwCF1P/+d71B6+4PdVnVnYY4ho
   9hDtiZtrApsQsE2j0BMkp4c7DUhFyY8uE5Lrq53egwlyEAR33OIC+tZlm
   FamH2RwMwtqRICkwgOwjNVvmxRXpfjBYxqBLk4ucT2+us4cRSFJdt7XrK
   p7SHNs97InZaqsJVeAH3IQA4SwCboH/t3DlhL6OOBKm+ZEtP1gzmRZlEf
   T5ZqLKV89Gg4WaniTfeNY5wF2/HWxTnyvyq0Y8vU/7kA2BcZcNtnV7Qc/
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="304132775"
X-IronPort-AV: E=Sophos;i="5.97,211,1669104000"; 
   d="scan'208";a="304132775"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 08:39:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="635447461"
X-IronPort-AV: E=Sophos;i="5.97,211,1669104000"; 
   d="scan'208";a="635447461"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 12 Jan 2023 08:39:01 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 7536B7C; Thu, 12 Jan 2023 18:39:35 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v1 2/2] gpio: wcd934x: Use proper headers and drop OF_GPIO dependency
Date:   Thu, 12 Jan 2023 18:39:20 +0200
Message-Id: <20230112163920.73102-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230112163920.73102-1-andriy.shevchenko@linux.intel.com>
References: <20230112163920.73102-1-andriy.shevchenko@linux.intel.com>
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
 drivers/gpio/Kconfig        | 2 +-
 drivers/gpio/gpio-wcd934x.c | 5 +++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 9711fcb9a4e9..3b2078a654ce 100644
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
index 817750e4e033..e6a8df7211f8 100644
--- a/drivers/gpio/gpio-wcd934x.c
+++ b/drivers/gpio/gpio-wcd934x.c
@@ -1,11 +1,12 @@
 // SPDX-License-Identifier: GPL-2.0
 // Copyright (c) 2019, Linaro Limited
 
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
-#include <linux/gpio/driver.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
-#include <linux/of_device.h>
+
+#include <linux/gpio/driver.h>
 
 #define WCD_PIN_MASK(p) BIT(p)
 #define WCD_REG_DIR_CTL_OFFSET 0x42
-- 
2.39.0

