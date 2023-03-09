Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78DC36B272B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 15:41:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbjCIOlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 09:41:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbjCIOlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 09:41:21 -0500
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4BF717CC3
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 06:41:18 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed50:3a77:63e:b168:ae06])
        by albert.telenet-ops.be with bizsmtp
        id WEhE2900554Hw2A06EhEPr; Thu, 09 Mar 2023 15:41:17 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1paHRf-00BKy0-Cr;
        Thu, 09 Mar 2023 15:41:14 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1paHSD-00GSOV-UM;
        Thu, 09 Mar 2023 15:41:13 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        linux-gpio@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux Kernel Functional Testing <lkft@linaro.org>
Subject: [PATCH v2] sh: mach-x3proto: Add missing #include <linux/gpio/driver.h>
Date:   Thu,  9 Mar 2023 15:41:13 +0100
Message-Id: <20230309144113.3922386-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

shx3_defconfig:

    arch/sh/boards/mach-x3proto/setup.c: In function ‘x3proto_devices_setup’:
    arch/sh/boards/mach-x3proto/setup.c:246:62: error: invalid use of undefined type ‘struct gpio_chip’
      246 |                 baseboard_buttons[i].gpio = x3proto_gpio_chip.base + i;
	  |                                                              ^

Fix this by replacing the include of the legacy <linux/gpio.h> by
<linux/gpio/driver.h>.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
Link: https://lore.kernel.org/r/CA+G9fYs7suzGsEDK40G0pzxXyR1o2V4Pn-oy1owTsTWRVEVHog@mail.gmail.com
Fixes: 21d9526d13b5467b ("gpiolib: Make the legacy <linux/gpio.h> consumer-only")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
v2:
  - Add Reviewed-by,
  - Drop inclusion of <linux/gpio.h>.
---
 arch/sh/boards/mach-x3proto/setup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sh/boards/mach-x3proto/setup.c b/arch/sh/boards/mach-x3proto/setup.c
index 95b85f2e13dda75b..ca2802d3056503cb 100644
--- a/arch/sh/boards/mach-x3proto/setup.c
+++ b/arch/sh/boards/mach-x3proto/setup.c
@@ -16,7 +16,7 @@
 #include <linux/input.h>
 #include <linux/usb/r8a66597.h>
 #include <linux/usb/m66592.h>
-#include <linux/gpio.h>
+#include <linux/gpio/driver.h>
 #include <linux/gpio_keys.h>
 #include <mach/ilsel.h>
 #include <mach/hardware.h>
-- 
2.34.1

