Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64A9A7151AF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 00:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbjE2WQY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 18:16:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbjE2WQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 18:16:18 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84E5B11B;
        Mon, 29 May 2023 15:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685398565; x=1716934565;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0gSXcrJw4rVVIbYtKUetrZyc67LpvOlFnbAG461PqkA=;
  b=WKhKI2X0NJfp0KmVzaCuY3wZzY/avxQcjX4jm2fGTuOh+g7D6+iL9cSa
   saIWd3iuDLY+XBJAHBgPBSL0NLYUXpu/jUNffS7DtjTWvFMPVW5Ugl/Rw
   NYHyfbZBU48dZWLFlk7RrodppDAcxHGJv8q06fH9fOZa46rl9NGkrQkGe
   Rw4n7OJVP4uNeTXJ3b0nxKUOql32q87w0JxwVFjx0I6GxmkrogegrODQM
   +t4vhd6sHWdtkfx9OYfpro3jb9PYuWXtHzx5mJAylbM7xXgWjVVdoK1bh
   RwW0PDOGcNGjoIAmyCUNvA/yIAgeh7NkEm3gAn2hiniUag3OM7fsNUq9a
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="353615846"
X-IronPort-AV: E=Sophos;i="6.00,201,1681196400"; 
   d="scan'208";a="353615846"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2023 15:14:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="700382378"
X-IronPort-AV: E=Sophos;i="6.00,201,1681196400"; 
   d="scan'208";a="700382378"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 29 May 2023 15:14:45 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id E63AC24F; Tue, 30 May 2023 01:14:49 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-gpio@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc-tw-discuss@lists.sourceforge.net
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Jonathan Corbet <corbet@lwn.net>, Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        Hu Haowen <src.res@email.cn>
Subject: [PATCH v2 1/2] gpiolib: Kill unused GPIOF_EXPORT and Co
Date:   Tue, 30 May 2023 01:14:45 +0300
Message-Id: <20230529221446.87785-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no use of the GPIOF_EXPORT in the kernel. Kill it for good.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
v2: added tag (Linus)
 Documentation/driver-api/gpio/legacy.rst                    | 3 ---
 Documentation/translations/zh_CN/driver-api/gpio/legacy.rst | 3 ---
 Documentation/translations/zh_TW/gpio.txt                   | 3 ---
 drivers/gpio/gpiolib-legacy.c                               | 6 ------
 include/linux/gpio.h                                        | 5 -----
 5 files changed, 20 deletions(-)

diff --git a/Documentation/driver-api/gpio/legacy.rst b/Documentation/driver-api/gpio/legacy.rst
index 78372853c6d4..c5f98a78499f 100644
--- a/Documentation/driver-api/gpio/legacy.rst
+++ b/Documentation/driver-api/gpio/legacy.rst
@@ -322,9 +322,6 @@ where 'flags' is currently defined to specify the following properties:
 	* GPIOF_OPEN_DRAIN	- gpio pin is open drain type.
 	* GPIOF_OPEN_SOURCE	- gpio pin is open source type.
 
-	* GPIOF_EXPORT_DIR_FIXED	- export gpio to sysfs, keep direction
-	* GPIOF_EXPORT_DIR_CHANGEABLE	- also export, allow changing direction
-
 since GPIOF_INIT_* are only valid when configured as output, so group valid
 combinations as:
 
diff --git a/Documentation/translations/zh_CN/driver-api/gpio/legacy.rst b/Documentation/translations/zh_CN/driver-api/gpio/legacy.rst
index 84ce2322fdba..8720970393fb 100644
--- a/Documentation/translations/zh_CN/driver-api/gpio/legacy.rst
+++ b/Documentation/translations/zh_CN/driver-api/gpio/legacy.rst
@@ -297,9 +297,6 @@ gpio_request()前将这类细节配置好，例如使用引脚控制子系统的
 	* GPIOF_OPEN_DRAIN	- gpio引脚为开漏信号
 	* GPIOF_OPEN_SOURCE	- gpio引脚为源极开路信号
 
-	* GPIOF_EXPORT_DIR_FIXED	- 将 gpio 导出到 sysfs，并保持方向
-	* GPIOF_EXPORT_DIR_CHANGEABLE	- 同样是导出, 但允许改变方向
-
 因为 GPIOF_INIT_* 仅有在配置为输出的时候才存在,所以有效的组合为:
 
 	* GPIOF_IN		- 配置为输入
diff --git a/Documentation/translations/zh_TW/gpio.txt b/Documentation/translations/zh_TW/gpio.txt
index 62e560ffe628..e0b96d897fa7 100644
--- a/Documentation/translations/zh_TW/gpio.txt
+++ b/Documentation/translations/zh_TW/gpio.txt
@@ -303,9 +303,6 @@ gpio_request()前將這類細節配置好，例如使用 pinctrl 子系統的映
 	* GPIOF_OPEN_DRAIN	- gpio引腳爲開漏信號
 	* GPIOF_OPEN_SOURCE	- gpio引腳爲源極開路信號
 
-	* GPIOF_EXPORT_DIR_FIXED	- 將 gpio 導出到 sysfs，並保持方向
-	* GPIOF_EXPORT_DIR_CHANGEABLE	- 同樣是導出, 但允許改變方向
-
 因爲 GPIOF_INIT_* 僅有在配置爲輸出的時候才存在,所以有效的組合爲:
 
 	* GPIOF_IN		- 配置爲輸入
diff --git a/drivers/gpio/gpiolib-legacy.c b/drivers/gpio/gpiolib-legacy.c
index 028f7f504209..969f737012f6 100644
--- a/drivers/gpio/gpiolib-legacy.c
+++ b/drivers/gpio/gpiolib-legacy.c
@@ -50,12 +50,6 @@ int gpio_request_one(unsigned gpio, unsigned long flags, const char *label)
 	if (err)
 		goto free_gpio;
 
-	if (flags & GPIOF_EXPORT) {
-		err = gpiod_export(desc, flags & GPIOF_EXPORT_CHANGEABLE);
-		if (err)
-			goto free_gpio;
-	}
-
 	return 0;
 
  free_gpio:
diff --git a/include/linux/gpio.h b/include/linux/gpio.h
index 8528353e073b..86963a00b018 100644
--- a/include/linux/gpio.h
+++ b/include/linux/gpio.h
@@ -38,11 +38,6 @@ struct device;
 /* Gpio pin is open source */
 #define GPIOF_OPEN_SOURCE	(1 << 4)
 
-#define GPIOF_EXPORT		(1 << 5)
-#define GPIOF_EXPORT_CHANGEABLE	(1 << 6)
-#define GPIOF_EXPORT_DIR_FIXED	(GPIOF_EXPORT)
-#define GPIOF_EXPORT_DIR_CHANGEABLE (GPIOF_EXPORT | GPIOF_EXPORT_CHANGEABLE)
-
 /**
  * struct gpio - a structure describing a GPIO with configuration
  * @gpio:	the GPIO number
-- 
2.40.0.1.gaa8946217a0b

