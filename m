Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A21D566736F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 14:42:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233480AbjALNl5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 08:41:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234088AbjALNl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 08:41:29 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F06850F7F;
        Thu, 12 Jan 2023 05:39:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673530768; x=1705066768;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Fiq7O/W4y1Cb9Aw+M/Hi2kk/28EdDxDe2am7SsMM7o4=;
  b=dwGGnMD+oNLutEXuNzDl/G1bzhFj9WVxUIgQhkR5ybwLRfe6LYp3V2mT
   4Pxrmxn1twvKc1VJsgVr8qbRFh392X3niXALY+oqsbLHiSQAR4u7SH3Xu
   n0lUqKRStz6wc34UQ1SNYLWmpR/9fVFfWMFShqek5kPGFyhnbb5JinNci
   Z0+I9ta8qbRdTFB1q1lMPNDyYbV/L8PicsW3qPMPL51WVM6RIl+F5561V
   lbjf1wZCME09sbJt7dbOGwp+3mrXaq5/xWvcg6IdiUycd7pm+S3w7ILOo
   MxGX5iSXYfu5V7Col+BjFpvT8hbO0BZwStONlTdepz/l/yOSSzOAiNCFB
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10587"; a="307227124"
X-IronPort-AV: E=Sophos;i="5.97,211,1669104000"; 
   d="scan'208";a="307227124"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 05:39:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10587"; a="831695528"
X-IronPort-AV: E=Sophos;i="5.97,211,1669104000"; 
   d="scan'208";a="831695528"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 12 Jan 2023 05:39:24 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id D190EE1; Thu, 12 Jan 2023 15:39:57 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-doc-tw-discuss@lists.sourceforge.net,
        linux-m68k@lists.linux-m68k.org, linux-sh@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Jonathan Corbet <corbet@lwn.net>, Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        Hu Haowen <src.res@email.cn>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>
Subject: [PATCH v1 1/1] gpio: Remove unused and obsoleted irq_to_gpio()
Date:   Thu, 12 Jan 2023 15:39:42 +0200
Message-Id: <20230112133942.58471-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

irq_to_gpio() is legacy and unused API, remove it for good.

This leaves gpio_to_irq() as it's used yet in many places.
Nevertheless, removal of its counterpart is a good signal
to whoever even trying to consider using them that do not.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 Documentation/driver-api/gpio/legacy.rst             |  8 --------
 .../translations/zh_CN/driver-api/gpio/legacy.rst    |  7 -------
 Documentation/translations/zh_TW/gpio.txt            |  7 -------
 arch/m68k/include/asm/gpio.h                         |  7 -------
 arch/sh/include/asm/gpio.h                           |  5 -----
 include/linux/gpio.h                                 | 12 ------------
 6 files changed, 46 deletions(-)

diff --git a/Documentation/driver-api/gpio/legacy.rst b/Documentation/driver-api/gpio/legacy.rst
index e3e9d26a60ce..a0559d93efd1 100644
--- a/Documentation/driver-api/gpio/legacy.rst
+++ b/Documentation/driver-api/gpio/legacy.rst
@@ -387,9 +387,6 @@ map between them using calls like::
 	/* map GPIO numbers to IRQ numbers */
 	int gpio_to_irq(unsigned gpio);
 
-	/* map IRQ numbers to GPIO numbers (avoid using this) */
-	int irq_to_gpio(unsigned irq);
-
 Those return either the corresponding number in the other namespace, or
 else a negative errno code if the mapping can't be done.  (For example,
 some GPIOs can't be used as IRQs.)  It is an unchecked error to use a GPIO
@@ -405,11 +402,6 @@ devices, by the board-specific initialization code.  Note that IRQ trigger
 options are part of the IRQ interface, e.g. IRQF_TRIGGER_FALLING, as are
 system wakeup capabilities.
 
-Non-error values returned from irq_to_gpio() would most commonly be used
-with gpio_get_value(), for example to initialize or update driver state
-when the IRQ is edge-triggered.  Note that some platforms don't support
-this reverse mapping, so you should avoid using it.
-
 
 Emulating Open Drain Signals
 ----------------------------
diff --git a/Documentation/translations/zh_CN/driver-api/gpio/legacy.rst b/Documentation/translations/zh_CN/driver-api/gpio/legacy.rst
index 8599e253fcc5..74fa473bb504 100644
--- a/Documentation/translations/zh_CN/driver-api/gpio/legacy.rst
+++ b/Documentation/translations/zh_CN/driver-api/gpio/legacy.rst
@@ -358,9 +358,6 @@ GPIO 编号是无符号整数;IRQ 编号也是。这些构成了两个逻辑上
 	/* 映射 GPIO 编号到 IRQ 编号 */
 	int gpio_to_irq(unsigned gpio);
 
-	/* 映射 IRQ 编号到 GPIO 编号 (尽量避免使用) */
-	int irq_to_gpio(unsigned irq);
-
 它们的返回值为对应命名空间的相关编号，或是负的错误代码(如果无法映射)。
 (例如,某些 GPIO 无法做为 IRQ 使用。)以下的编号错误是未经检测的:使用一个
 未通过 gpio_direction_input()配置为输入的 GPIO 编号，或者使用一个
@@ -373,10 +370,6 @@ gpio_to_irq()返回的非错误值可以传递给 request_irq()或者 free_irq()
 触发选项是 IRQ 接口的一部分，如 IRQF_TRIGGER_FALLING，系统唤醒能力
 也是如此。
 
-irq_to_gpio()返回的非错误值大多数通常可以被 gpio_get_value()所使用，
-比如在 IRQ 是沿触发时初始化或更新驱动状态。注意某些平台不支持反映射,所以
-你应该尽量避免使用它。
-
 
 模拟开漏信号
 ------------
diff --git a/Documentation/translations/zh_TW/gpio.txt b/Documentation/translations/zh_TW/gpio.txt
index abd8e4c0973e..1b986bbb0909 100644
--- a/Documentation/translations/zh_TW/gpio.txt
+++ b/Documentation/translations/zh_TW/gpio.txt
@@ -363,9 +363,6 @@ GPIO 編號是無符號整數;IRQ 編號也是。這些構成了兩個邏輯上
 	/* 映射 GPIO 編號到 IRQ 編號 */
 	int gpio_to_irq(unsigned gpio);
 
-	/* 映射 IRQ 編號到 GPIO 編號 (儘量避免使用) */
-	int irq_to_gpio(unsigned irq);
-
 它們的返回值爲對應命名空間的相關編號，或是負的錯誤代碼(如果無法映射)。
 (例如,某些 GPIO 無法做爲 IRQ 使用。)以下的編號錯誤是未經檢測的:使用一個
 未通過 gpio_direction_input()配置爲輸入的 GPIO 編號，或者使用一個
@@ -378,10 +375,6 @@ gpio_to_irq()返回的非錯誤值可以傳遞給 request_irq()或者 free_irq()
 觸發選項是 IRQ 接口的一部分，如 IRQF_TRIGGER_FALLING，系統喚醒能力
 也是如此。
 
-irq_to_gpio()返回的非錯誤值大多數通常可以被 gpio_get_value()所使用，
-比如在 IRQ 是沿觸發時初始化或更新驅動狀態。注意某些平台不支持反映射,所以
-你應該儘量避免使用它。
-
 
 模擬開漏信號
 ----------------------------
diff --git a/arch/m68k/include/asm/gpio.h b/arch/m68k/include/asm/gpio.h
index a50b27719a58..5cfc0996ba94 100644
--- a/arch/m68k/include/asm/gpio.h
+++ b/arch/m68k/include/asm/gpio.h
@@ -66,13 +66,6 @@ static inline int gpio_to_irq(unsigned gpio)
 		return __gpio_to_irq(gpio);
 }
 
-static inline int irq_to_gpio(unsigned irq)
-{
-	return (irq >= MCFGPIO_IRQ_VECBASE &&
-		irq < (MCFGPIO_IRQ_VECBASE + MCFGPIO_IRQ_MAX)) ?
-		irq - MCFGPIO_IRQ_VECBASE : -ENXIO;
-}
-
 static inline int gpio_cansleep(unsigned gpio)
 {
 	return gpio < MCFGPIO_PIN_MAX ? 0 : __gpio_cansleep(gpio);
diff --git a/arch/sh/include/asm/gpio.h b/arch/sh/include/asm/gpio.h
index d643250f0a0f..588c1380e4cb 100644
--- a/arch/sh/include/asm/gpio.h
+++ b/arch/sh/include/asm/gpio.h
@@ -40,11 +40,6 @@ static inline int gpio_to_irq(unsigned gpio)
 	return __gpio_to_irq(gpio);
 }
 
-static inline int irq_to_gpio(unsigned int irq)
-{
-	return -ENOSYS;
-}
-
 #endif /* CONFIG_GPIOLIB */
 
 #endif /* __ASM_SH_GPIO_H */
diff --git a/include/linux/gpio.h b/include/linux/gpio.h
index e94815b3ce1d..85beb236c925 100644
--- a/include/linux/gpio.h
+++ b/include/linux/gpio.h
@@ -81,11 +81,6 @@ static inline int gpio_to_irq(unsigned int gpio)
 	return __gpio_to_irq(gpio);
 }
 
-static inline int irq_to_gpio(unsigned int irq)
-{
-	return -EINVAL;
-}
-
 #endif /* ! CONFIG_ARCH_HAVE_CUSTOM_GPIO_H */
 
 /* CONFIG_GPIOLIB: bindings for managed devices that want to request gpios */
@@ -210,13 +205,6 @@ static inline int gpio_to_irq(unsigned gpio)
 	return -EINVAL;
 }
 
-static inline int irq_to_gpio(unsigned irq)
-{
-	/* irq can never have been returned from gpio_to_irq() */
-	WARN_ON(1);
-	return -EINVAL;
-}
-
 static inline int devm_gpio_request(struct device *dev, unsigned gpio,
 				    const char *label)
 {
-- 
2.39.0

