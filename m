Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD83567CC1B
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 14:28:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236836AbjAZN2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 08:28:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234698AbjAZN2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 08:28:36 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 357D32727;
        Thu, 26 Jan 2023 05:28:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CCA8CB81D47;
        Thu, 26 Jan 2023 13:28:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93F8CC433EF;
        Thu, 26 Jan 2023 13:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674739688;
        bh=X/e1QpKlP0TaO/2I6C21LQlgX7Xhrhxcls2EuFYB8wc=;
        h=From:To:Cc:Subject:Date:From;
        b=iirqD7chO/qx3fiQageG97IR/EngDqExj5r3XFKXLD4jpPklBbeybLQ2mVqhIpwSx
         5AwdL3jgnCHRNPT1BONmyeCibvtiR2HE59LF5SlqHbOxz/QcUmmki/ZhihBvzGOhVT
         lXMi/U/lIZo24tpSmi26HqIZFvnO6utseKmxfVUVjxTQg1rmOPmP2ZWK1bIwRmqufO
         PVjuYVn2I2E1FENv0fbquEkPiN1LQCQi8rTHicHqVuiUU/1H5BqTZNPRieIQq03qwM
         nhnpQfO728nq92IodqYrw1qxlsP1y2Xz5kT/OZsRKzyOqifc+dW12/NsczWGWX1pWN
         QbInOQd8uuICA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-gpio@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/8] gpiolib cleanups
Date:   Thu, 26 Jan 2023 14:27:53 +0100
Message-Id: <20230126132801.2042371-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

These are some older patches I did last year, rebased to linux-next-20230125.

The main goal is to remove some of the legacy bits of the gpiolib
interfaces, where the corner cases are easily avoided or replaced
with gpio descriptor based interfaces.

We seem to all be touching the same functions at the moement, let
me know if this conflicts with your work.

   Arnd

Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-gpio@vger.kernel.org>
Cc: linux-kernel@vger.kernel.org

Arnd Bergmann (8):
  gpiolib: remove empty asm/gpio.h files
  gpiolib: coldfire: remove custom asm/gpio.h
  gpiolib: remove asm-generic/gpio.h
  gpiolib: remove gpio_set_debounce
  gpiolib: remove legacy gpio_export
  gpiolib: split linux/gpio/driver.h out of linux/gpio.h
  gpiolib: split of_mm_gpio_chip out of linux/of_gpio.h
  gpiolib: move of_gpio_flags into gpiolib-of.c

 Documentation/admin-guide/gpio/sysfs.rst      |   2 +-
 Documentation/driver-api/gpio/legacy.rst      |  23 ---
 .../zh_CN/driver-api/gpio/legacy.rst          |  20 ---
 Documentation/translations/zh_TW/gpio.txt     |  18 ---
 MAINTAINERS                                   |   1 -
 arch/arm/Kconfig                              |   1 -
 arch/arm/include/asm/gpio.h                   |  21 ---
 arch/arm/mach-omap1/irq.c                     |   1 +
 arch/arm/mach-omap2/pdata-quirks.c            |   9 +-
 arch/arm/mach-orion5x/board-rd88f5182.c       |   1 +
 arch/arm/mach-s3c/s3c64xx.c                   |   1 +
 arch/arm/mach-sa1100/assabet.c                |   1 +
 arch/arm/plat-orion/gpio.c                    |   1 +
 arch/m68k/Kconfig.cpu                         |   1 -
 arch/m68k/include/asm/gpio.h                  |  95 -----------
 arch/m68k/include/asm/mcfgpio.h               |   2 +-
 arch/powerpc/platforms/44x/Kconfig            |   1 +
 arch/powerpc/platforms/4xx/gpio.c             |   2 +-
 arch/powerpc/platforms/8xx/Kconfig            |   1 +
 arch/powerpc/platforms/8xx/cpm1.c             |   2 +-
 arch/powerpc/platforms/Kconfig                |   2 +
 arch/powerpc/sysdev/cpm_common.c              |   2 +-
 arch/sh/Kconfig                               |   1 -
 arch/sh/boards/board-magicpanelr2.c           |   1 +
 arch/sh/boards/mach-ap325rxa/setup.c          |   7 +-
 arch/sh/include/asm/gpio.h                    |  45 ------
 drivers/gpio/Kconfig                          |  19 ++-
 drivers/gpio/TODO                             |  15 +-
 drivers/gpio/gpio-altera.c                    |   2 +-
 drivers/gpio/gpio-davinci.c                   |   3 +-
 drivers/gpio/gpio-mm-lantiq.c                 |   2 +-
 drivers/gpio/gpio-mpc5200.c                   |   2 +-
 drivers/gpio/gpiolib-of.c                     |  18 +++
 drivers/gpio/gpiolib-sysfs.c                  |   4 +-
 drivers/input/touchscreen/ads7846.c           |  24 +--
 drivers/media/pci/sta2x11/sta2x11_vip.c       |  10 +-
 drivers/net/ieee802154/ca8210.c               |   3 +-
 .../broadcom/brcm80211/brcmsmac/led.c         |   1 +
 drivers/pinctrl/core.c                        |   2 +-
 drivers/soc/fsl/qe/gpio.c                     |   2 +-
 include/asm-generic/gpio.h                    | 147 ------------------
 include/linux/gpio.h                          |  93 ++++++-----
 include/linux/gpio/legacy-of-mm-gpiochip.h    |  36 +++++
 include/linux/mfd/ucb1x00.h                   |   1 +
 include/linux/of_gpio.h                       |  36 -----
 45 files changed, 186 insertions(+), 496 deletions(-)
 delete mode 100644 arch/arm/include/asm/gpio.h
 delete mode 100644 arch/m68k/include/asm/gpio.h
 delete mode 100644 arch/sh/include/asm/gpio.h
 delete mode 100644 include/asm-generic/gpio.h
 create mode 100644 include/linux/gpio/legacy-of-mm-gpiochip.h

-- 
2.39.0

