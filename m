Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34E6E72266F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 14:54:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233660AbjFEMyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 08:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233640AbjFEMyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 08:54:13 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71698A1;
        Mon,  5 Jun 2023 05:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685969652; x=1717505652;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=eyiiu2NGIlMKr/bvnrnFxZhwYLUvQ3Dg9QM/a+w5bMU=;
  b=IJSSg5Y4G+AjLsM+Rb0zHzc2FddLjU/ucM+wpGmfYSGrw3d2kVY1Bs+y
   xIsMcATiA69j5bDCM1bBBqHfIkzqwvqDyxNdVhxr1z46mzQQBk634kL3r
   wM9ciSS+/RMj+pS7hmVjDof+v62ae7QOfy9kqkOyIaeBrFB/I73RHT5I4
   keeCYhehfL1Lt39DWiM0F5+f/BbyULsUHBMAfOjpYWai+BNbGLhzkk8lw
   Pvc+s08v9quG4euD8nEOgcFupAV9ldwbUXxTaK17TBz/JOezVcBsFwfBU
   8PYLHvk/R5pLlCC/I1aAX2kt3SQPCCBYLzMkStrqRSiPZhjE9FJKjii6e
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10731"; a="384662412"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="384662412"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2023 05:54:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10731"; a="686101791"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="686101791"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 05 Jun 2023 05:54:07 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 281A52A6; Mon,  5 Jun 2023 15:54:13 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-gpio@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc-tw-discuss@lists.sourceforge.net,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Jonathan Corbet <corbet@lwn.net>, Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        Hu Haowen <src.res@email.cn>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: [PATCH v2 1/1] gpiolib: Remove unused gpio_cansleep()
Date:   Mon,  5 Jun 2023 15:54:11 +0300
Message-Id: <20230605125411.60378-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is not a single user in the entire kernel of this deprecated API,
kill it for good.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: amended Chinese translation (thanks to Yanteng Si)
 Documentation/driver-api/gpio/legacy.rst           | 12 +-----------
 .../translations/zh_CN/driver-api/gpio/legacy.rst  | 14 +++-----------
 Documentation/translations/zh_TW/gpio.txt          | 14 +++-----------
 arch/m68k/include/asm/mcfgpio.h                    |  8 --------
 arch/mips/include/asm/mach-au1x00/gpio-au1000.h    |  5 -----
 arch/mips/include/asm/mach-au1x00/gpio-au1300.h    |  5 -----
 include/linux/gpio.h                               | 12 ------------
 7 files changed, 7 insertions(+), 63 deletions(-)

diff --git a/Documentation/driver-api/gpio/legacy.rst b/Documentation/driver-api/gpio/legacy.rst
index 9eda54811faa..b6505914791c 100644
--- a/Documentation/driver-api/gpio/legacy.rst
+++ b/Documentation/driver-api/gpio/legacy.rst
@@ -165,8 +165,7 @@ Most GPIO controllers can be accessed with memory read/write instructions.
 Those don't need to sleep, and can safely be done from inside hard
 (nonthreaded) IRQ handlers and similar contexts.
 
-Use the following calls to access such GPIOs,
-for which gpio_cansleep() will always return false (see below)::
+Use the following calls to access such GPIOs::
 
 	/* GPIO INPUT:  return zero or nonzero */
 	int gpio_get_value(unsigned gpio);
@@ -200,13 +199,6 @@ Some GPIO controllers must be accessed using message based busses like I2C
 or SPI.  Commands to read or write those GPIO values require waiting to
 get to the head of a queue to transmit a command and get its response.
 This requires sleeping, which can't be done from inside IRQ handlers.
-
-Platforms that support this type of GPIO distinguish them from other GPIOs
-by returning nonzero from this call (which requires a valid GPIO number,
-which should have been previously allocated with gpio_request)::
-
-	int gpio_cansleep(unsigned gpio);
-
 To access such GPIOs, a different set of accessors is defined::
 
 	/* GPIO INPUT:  return zero or nonzero, might sleep */
@@ -215,7 +207,6 @@ To access such GPIOs, a different set of accessors is defined::
 	/* GPIO OUTPUT, might sleep */
 	void gpio_set_value_cansleep(unsigned gpio, int value);
 
-
 Accessing such GPIOs requires a context which may sleep,  for example
 a threaded IRQ handler, and those accessors must be used instead of
 spinlock-safe accessors without the cansleep() name suffix.
@@ -537,7 +528,6 @@ code, which always dispatches through the gpio_chip::
 
   #define gpio_get_value	__gpio_get_value
   #define gpio_set_value	__gpio_set_value
-  #define gpio_cansleep		__gpio_cansleep
 
 Fancier implementations could instead define those as inline functions with
 logic optimizing access to specific SOC-based GPIOs.  For example, if the
diff --git a/Documentation/translations/zh_CN/driver-api/gpio/legacy.rst b/Documentation/translations/zh_CN/driver-api/gpio/legacy.rst
index 1bddecf73670..aeccff777170 100644
--- a/Documentation/translations/zh_CN/driver-api/gpio/legacy.rst
+++ b/Documentation/translations/zh_CN/driver-api/gpio/legacy.rst
@@ -153,8 +153,7 @@ get/set(获取/设置)函数调用没法返回错误,且有可能是配置错误
 大多数 GPIO 控制器可以通过内存读/写指令来访问。这些指令不会休眠,可以
 安全地在硬(非线程)中断例程和类似的上下文中完成。
 
-对于那些用 gpio_cansleep()测试总是返回失败的 GPIO(见下文)，使用
-以下的函数访问::
+对于那些 GPIO，使用以下的函数访问::
 
 	/* GPIO 输入:返回零或非零 */
 	int gpio_get_value(unsigned gpio);
@@ -186,11 +185,6 @@ GPIO值是布尔值，零表示低电平，非零表示高电平。当读取一
 GPIO 值的命令需要等待其信息排到队首才发送命令，再获得其反馈。期间需要
 休眠，这不能在 IRQ 例程(中断上下文)中执行。
 
-支持此类 GPIO 的平台通过以下函数返回非零值来区分出这种 GPIO。(此函数需要
-一个之前通过 gpio_request 分配到的有效 GPIO 编号)::
-
-	int gpio_cansleep(unsigned gpio);
-
 为了访问这种 GPIO,内核定义了一套不同的函数::
 
 	/* GPIO 输入:返回零或非零 ,可能会休眠 */
@@ -199,7 +193,6 @@ GPIO 值的命令需要等待其信息排到队首才发送命令，再获得其
 	/* GPIO 输出,可能会休眠 */
 	void gpio_set_value_cansleep(unsigned gpio, int value);
 
-
 访问这样的 GPIO 需要一个允许休眠的上下文，例如线程 IRQ 处理例程，并用以上的
 访问函数替换那些没有 cansleep()后缀的自旋锁安全访问函数。
 
@@ -483,8 +476,8 @@ GPIO 实现者的框架（可选）
 
 为了支持这个框架，一个平台的 Kconfig 文件将会 "select"(选择)
 ARCH_REQUIRE_GPIOLIB 或 ARCH_WANT_OPTIONAL_GPIOLIB，并让它的
-<asm/gpio.h> 包含 <asm-generic/gpio.h>，同时定义三个方法:
-gpio_get_value()、gpio_set_value()和 gpio_cansleep()。
+<asm/gpio.h> 包含 <asm-generic/gpio.h>，同时定义两个方法:
+gpio_get_value()、gpio_set_value()。
 
 它也应提供一个 ARCH_NR_GPIOS 的定义值，这样可以更好地反映该平台 GPIO
 的实际数量,节省静态表的空间。(这个定义值应该包含片上系统内建 GPIO 和
@@ -502,7 +495,6 @@ ARCH_WANT_OPTIONAL_GPIOLIB 意味着 gpiolib 核心默认关闭,且用户可以
 
   #define gpio_get_value	__gpio_get_value
   #define gpio_set_value	__gpio_set_value
-  #define gpio_cansleep		__gpio_cansleep
 
 这些定义可以用更理想的实现方法替代，那就是使用经过逻辑优化的内联函数来访问
 基于特定片上系统的 GPIO。例如,若引用的 GPIO (寄存器位偏移)是常量“12”，
diff --git a/Documentation/translations/zh_TW/gpio.txt b/Documentation/translations/zh_TW/gpio.txt
index 66bc7f2bbe53..b93788a2628b 100644
--- a/Documentation/translations/zh_TW/gpio.txt
+++ b/Documentation/translations/zh_TW/gpio.txt
@@ -161,8 +161,7 @@ get/set(獲取/設置)函數調用沒法返回錯誤,且有可能是配置錯誤
 大多數 GPIO 控制器可以通過內存讀/寫指令來訪問。這些指令不會休眠,可以
 安全地在硬(非線程)中斷例程和類似的上下文中完成。
 
-對於那些用 gpio_cansleep()測試總是返回失敗的 GPIO(見下文)，使用
-以下的函數訪問:
+對於那些 GPIO，使用以下的函數訪問:
 
 	/* GPIO 輸入:返回零或非零 */
 	int gpio_get_value(unsigned gpio);
@@ -193,11 +192,6 @@ GPIO值是布爾值，零表示低電平，非零表示高電平。當讀取一
 GPIO 值的命令需要等待其信息排到隊首才發送命令，再獲得其反饋。期間需要
 休眠，這不能在 IRQ 例程(中斷上下文)中執行。
 
-支持此類 GPIO 的平台通過以下函數返回非零值來區分出這種 GPIO。(此函數需要
-一個之前通過 gpio_request 分配到的有效 GPIO 編號):
-
-	int gpio_cansleep(unsigned gpio);
-
 爲了訪問這種 GPIO,內核定義了一套不同的函數:
 
 	/* GPIO 輸入:返回零或非零 ,可能會休眠 */
@@ -206,7 +200,6 @@ GPIO 值的命令需要等待其信息排到隊首才發送命令，再獲得其
 	/* GPIO 輸出,可能會休眠 */
 	void gpio_set_value_cansleep(unsigned gpio, int value);
 
-
 訪問這樣的 GPIO 需要一個允許休眠的上下文，例如線程 IRQ 處理例程，並用以上的
 訪問函數替換那些沒有 cansleep()後綴的自旋鎖安全訪問函數。
 
@@ -449,8 +442,8 @@ GPIO 實現者的框架 (可選)
 -------
 爲了支持這個框架，一個平台的 Kconfig 文件將會 "select"(選擇)
 ARCH_REQUIRE_GPIOLIB 或 ARCH_WANT_OPTIONAL_GPIOLIB，並讓它的
-<asm/gpio.h> 包含 <asm-generic/gpio.h>，同時定義三個方法:
-gpio_get_value()、gpio_set_value()和 gpio_cansleep()。
+<asm/gpio.h> 包含 <asm-generic/gpio.h>，同時定義二個方法:
+gpio_get_value()、gpio_set_value()。
 
 它也應提供一個 ARCH_NR_GPIOS 的定義值，這樣可以更好地反映該平台 GPIO
 的實際數量,節省靜態表的空間。(這個定義值應該包含片上系統內建 GPIO 和
@@ -468,7 +461,6 @@ ARCH_WANT_OPTIONAL_GPIOLIB 意味著 gpiolib 核心默認關閉,且用戶可以
 
   #define gpio_get_value	__gpio_get_value
   #define gpio_set_value	__gpio_set_value
-  #define gpio_cansleep		__gpio_cansleep
 
 這些定義可以用更理想的實現方法替代，那就是使用經過邏輯優化的內聯函數來訪問
 基於特定片上系統的 GPIO。例如,若引用的 GPIO (寄存器位偏移)是常量「12」，
diff --git a/arch/m68k/include/asm/mcfgpio.h b/arch/m68k/include/asm/mcfgpio.h
index 2cefe8445980..7abd322c019f 100644
--- a/arch/m68k/include/asm/mcfgpio.h
+++ b/arch/m68k/include/asm/mcfgpio.h
@@ -34,14 +34,6 @@ static inline void __gpio_set_value(unsigned gpio, int value)
 		__mcfgpio_set_value(gpio, value);
 }
 
-static inline int __gpio_cansleep(unsigned gpio)
-{
-	if (gpio < MCFGPIO_PIN_MAX)
-		return 0;
-	else
-		return -EINVAL;
-}
-
 static inline int __gpio_to_irq(unsigned gpio)
 {
 	return -EINVAL;
diff --git a/arch/mips/include/asm/mach-au1x00/gpio-au1000.h b/arch/mips/include/asm/mach-au1x00/gpio-au1000.h
index adde1fa5097e..82bc2766e2ec 100644
--- a/arch/mips/include/asm/mach-au1x00/gpio-au1000.h
+++ b/arch/mips/include/asm/mach-au1x00/gpio-au1000.h
@@ -500,11 +500,6 @@ static inline int alchemy_gpio_is_valid(int gpio)
 		alchemy_gpio1_is_valid(gpio);
 }
 
-static inline int alchemy_gpio_cansleep(int gpio)
-{
-	return 0;	/* Alchemy never gets tired */
-}
-
 static inline int alchemy_gpio_to_irq(int gpio)
 {
 	return (gpio >= ALCHEMY_GPIO2_BASE) ?
diff --git a/arch/mips/include/asm/mach-au1x00/gpio-au1300.h b/arch/mips/include/asm/mach-au1x00/gpio-au1300.h
index d16add7ba49d..43d44f384f97 100644
--- a/arch/mips/include/asm/mach-au1x00/gpio-au1300.h
+++ b/arch/mips/include/asm/mach-au1x00/gpio-au1300.h
@@ -98,11 +98,6 @@ static inline int au1300_gpio_is_valid(unsigned int gpio)
 	return ret;
 }
 
-static inline int au1300_gpio_cansleep(unsigned int gpio)
-{
-	return 0;
-}
-
 /* hardware remembers gpio 0-63 levels on powerup */
 static inline int au1300_gpio_getinitlvl(unsigned int gpio)
 {
diff --git a/include/linux/gpio.h b/include/linux/gpio.h
index 88efac969754..7ecc25c543ce 100644
--- a/include/linux/gpio.h
+++ b/include/linux/gpio.h
@@ -108,11 +108,6 @@ static inline void gpio_set_value(unsigned gpio, int value)
 	return gpiod_set_raw_value(gpio_to_desc(gpio), value);
 }
 
-static inline int gpio_cansleep(unsigned gpio)
-{
-	return gpiod_cansleep(gpio_to_desc(gpio));
-}
-
 static inline int gpio_to_irq(unsigned gpio)
 {
 	return gpiod_to_irq(gpio_to_desc(gpio));
@@ -195,13 +190,6 @@ static inline void gpio_set_value(unsigned gpio, int value)
 	WARN_ON(1);
 }
 
-static inline int gpio_cansleep(unsigned gpio)
-{
-	/* GPIO can never have been requested or set as {in,out}put */
-	WARN_ON(1);
-	return 0;
-}
-
 static inline int gpio_get_value_cansleep(unsigned gpio)
 {
 	/* GPIO can never have been requested or set as {in,out}put */
-- 
2.40.0.1.gaa8946217a0b

