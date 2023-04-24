Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81D5E6ECA3F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 12:22:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231831AbjDXKWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 06:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231644AbjDXKV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 06:21:29 -0400
Received: from forward502b.mail.yandex.net (forward502b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d502])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F2333C27
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 03:20:51 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:261e:0:640:2e3d:0])
        by forward502b.mail.yandex.net (Yandex) with ESMTP id B58305EC04;
        Mon, 24 Apr 2023 12:35:36 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id JZBb1pbWwKo0-K7G2D1Vp;
        Mon, 24 Apr 2023 12:35:36 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail; t=1682328936;
        bh=F6ZqrcN/SPT+NEKdvisviYYJ0nz6Hh0jgcWtDLBhcrI=;
        h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
        b=htlHupDTDM1JNR4utO/0XPqY03mws+YZwIA1NTdLFVHmBQl7SKzqAkd7CsuasTD6Q
         saC+o/01fGtI9LaF8YQfyWwDjRCW/SZ233vWZs/LKEe00i8hm38UlJKLn16OGdhpHx
         hpjO9UjvZil4KK0+OCnQwHoWCv7xH1Hr3pcvcfGE=
Authentication-Results: mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net; dkim=pass header.i=@maquefel.me
From:   Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Arnd Bergmann <arnd@kernel.org>, Linus Walleij <linusw@kernel.org>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Joel Stanley <joel@jms.id.au>,
        Conor Dooley <conor.dooley@microchip.com>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Walker Chen <walker.chen@starfivetech.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Sven Peter <sven@svenpeter.dev>,
        Brian Norris <briannorris@chromium.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Yinbo Zhu <zhuyinbo@loongson.cn>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 02/43] soc: Add SoC driver for Cirrus ep93xx
Date:   Mon, 24 Apr 2023 15:34:18 +0300
Message-Id: <20230424123522.18302-3-nikita.shubin@maquefel.me>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230424123522.18302-1-nikita.shubin@maquefel.me>
References: <20230424123522.18302-1-nikita.shubin@maquefel.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds an SoC driver for the ep93xx. Currently there
is only one thing not fitting into any other framework,
and that is the swlock setting.

It's used for clock settings and restart.

Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---

Notes:
    rfc -> v0
    Alexander Sverdlin:
    - replace spinlock with local_irq
    
    Arnd Bergmann:
    - wildcards changed to ep9301
    
    Linus Walleij:
    - added tag, i hope changes are not significant enough to drop
      Reviewed-by tag

 drivers/soc/Kconfig               |   1 +
 drivers/soc/Makefile              |   1 +
 drivers/soc/cirrus/Kconfig        |  11 +++
 drivers/soc/cirrus/Makefile       |   2 +
 drivers/soc/cirrus/soc-ep93xx.c   | 134 ++++++++++++++++++++++++++++++
 include/linux/soc/cirrus/ep93xx.h |  16 +++-
 6 files changed, 161 insertions(+), 4 deletions(-)
 create mode 100644 drivers/soc/cirrus/Kconfig
 create mode 100644 drivers/soc/cirrus/Makefile
 create mode 100644 drivers/soc/cirrus/soc-ep93xx.c

diff --git a/drivers/soc/Kconfig b/drivers/soc/Kconfig
index 4e176280113a..6149f0447b61 100644
--- a/drivers/soc/Kconfig
+++ b/drivers/soc/Kconfig
@@ -30,5 +30,6 @@ source "drivers/soc/ti/Kconfig"
 source "drivers/soc/ux500/Kconfig"
 source "drivers/soc/versatile/Kconfig"
 source "drivers/soc/xilinx/Kconfig"
+source "drivers/soc/cirrus/Kconfig"
 
 endmenu
diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
index 3b0f9fb3b5c8..2ba52d7560bf 100644
--- a/drivers/soc/Makefile
+++ b/drivers/soc/Makefile
@@ -36,3 +36,4 @@ obj-y				+= ti/
 obj-$(CONFIG_ARCH_U8500)	+= ux500/
 obj-$(CONFIG_PLAT_VERSATILE)	+= versatile/
 obj-y				+= xilinx/
+obj-$(CONFIG_SOC_EP93XX)	+= cirrus/
diff --git a/drivers/soc/cirrus/Kconfig b/drivers/soc/cirrus/Kconfig
new file mode 100644
index 000000000000..d7262c96a5dc
--- /dev/null
+++ b/drivers/soc/cirrus/Kconfig
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0
+
+if ARCH_EP93XX
+
+config SOC_EP93XX
+	bool "Cirrus EP93xx chips SoC"
+	default y
+	help
+	  Support Soc for Cirrus EP93xx chips.
+
+endif
diff --git a/drivers/soc/cirrus/Makefile b/drivers/soc/cirrus/Makefile
new file mode 100644
index 000000000000..ed6752844c6f
--- /dev/null
+++ b/drivers/soc/cirrus/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-y	+= soc-ep93xx.o
diff --git a/drivers/soc/cirrus/soc-ep93xx.c b/drivers/soc/cirrus/soc-ep93xx.c
new file mode 100644
index 000000000000..64842e9e2316
--- /dev/null
+++ b/drivers/soc/cirrus/soc-ep93xx.c
@@ -0,0 +1,134 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Soc driver for Cirrus EP93xx chips.
+ * Copyright (C) 2022 Nikita Shubin <nikita.shubin@maquefel.me>
+ *
+ * Based on a rewrite of arch/arm/mach-ep93xx/core.c
+ * Copyright (C) 2006 Lennert Buytenhek <buytenh@wantstofly.org>
+ * Copyright (C) 2007 Herbert Valerio Riedel <hvr@gnu.org>
+ *
+ * Thanks go to Michael Burian and Ray Lehtiniemi for their key
+ * role in the ep93xx linux community
+ */
+
+#include <linux/soc/cirrus/ep93xx.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/mfd/syscon.h>
+#include <linux/regmap.h>
+#include <linux/of.h>
+
+#define EP93XX_SYSCON_DEVCFG		0x80
+
+#define EP93XX_SWLOCK_MAGICK		0xaa
+#define EP93XX_SYSCON_SWLOCK		0xc0
+#define EP93XX_SYSCON_SYSCFG		0x9c
+#define EP93XX_SYSCON_SYSCFG_REV_MASK	(0xf0000000)
+#define EP93XX_SYSCON_SYSCFG_REV_SHIFT	(28)
+
+static struct regmap *map;
+
+/* EP93xx System Controller software locked register write */
+void ep93xx_syscon_swlocked_write(unsigned int val, unsigned int reg)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+
+	regmap_write(map, EP93XX_SYSCON_SWLOCK, EP93XX_SWLOCK_MAGICK);
+	regmap_write(map, reg, val);
+
+	local_irq_restore(flags);
+}
+EXPORT_SYMBOL_GPL(ep93xx_syscon_swlocked_write);
+
+void ep93xx_devcfg_set_clear(unsigned int set_bits, unsigned int clear_bits)
+{
+	unsigned long flags;
+	unsigned int val;
+
+	local_irq_save(flags);
+
+	regmap_read(map, EP93XX_SYSCON_DEVCFG, &val);
+	val &= ~clear_bits;
+	val |= set_bits;
+	regmap_write(map, EP93XX_SYSCON_SWLOCK, EP93XX_SWLOCK_MAGICK);
+	regmap_write(map, EP93XX_SYSCON_DEVCFG, val);
+
+	local_irq_restore(flags);
+}
+EXPORT_SYMBOL_GPL(ep93xx_devcfg_set_clear);
+
+void ep93xx_swlocked_update_bits(unsigned int reg,
+				 unsigned int mask,
+				 unsigned int val)
+{
+	unsigned long flags;
+	unsigned int tmp, orig;
+
+	local_irq_save(flags);
+
+	regmap_read(map, EP93XX_SYSCON_DEVCFG, &orig);
+	tmp = orig & ~mask;
+	tmp |= val & mask;
+	if (tmp != orig) {
+		regmap_write(map, EP93XX_SYSCON_SWLOCK, EP93XX_SWLOCK_MAGICK);
+		regmap_write(map, reg, tmp);
+	}
+
+	local_irq_restore(flags);
+}
+EXPORT_SYMBOL_GPL(ep93xx_swlocked_update_bits);
+
+/**
+ * ep93xx_chip_revision() - returns the EP93xx chip revision
+ *
+ */
+unsigned int ep93xx_chip_revision(void)
+{
+	unsigned int val;
+
+	regmap_read(map, EP93XX_SYSCON_SYSCFG, &val);
+	val &= EP93XX_SYSCON_SYSCFG_REV_MASK;
+	val >>= EP93XX_SYSCON_SYSCFG_REV_SHIFT;
+	return val;
+}
+EXPORT_SYMBOL_GPL(ep93xx_chip_revision);
+
+static const char __init *ep93xx_get_soc_rev(void)
+{
+	int rev = ep93xx_chip_revision();
+
+	switch (rev) {
+	case EP93XX_CHIP_REV_D0:
+		return "D0";
+	case EP93XX_CHIP_REV_D1:
+		return "D1";
+	case EP93XX_CHIP_REV_E0:
+		return "E0";
+	case EP93XX_CHIP_REV_E1:
+		return "E1";
+	case EP93XX_CHIP_REV_E2:
+		return "E2";
+	default:
+		return "unknown";
+	}
+}
+
+static int __init ep93xx_soc_init(void)
+{
+	/* Multiplatform guard, only proceed on ep93xx */
+	if (!of_machine_is_compatible("cirrus,ep9301"))
+		return 0;
+
+	map = syscon_regmap_lookup_by_compatible("cirrus,ep9301-syscon");
+	if (IS_ERR(map))
+		return PTR_ERR(map);
+
+	pr_info("EP93xx SoC revision %s\n", ep93xx_get_soc_rev());
+
+	return 0;
+}
+
+core_initcall(ep93xx_soc_init);
+
diff --git a/include/linux/soc/cirrus/ep93xx.h b/include/linux/soc/cirrus/ep93xx.h
index 56fbe2dc59b1..f0f770a103be 100644
--- a/include/linux/soc/cirrus/ep93xx.h
+++ b/include/linux/soc/cirrus/ep93xx.h
@@ -10,7 +10,7 @@ struct platform_device;
 #define EP93XX_CHIP_REV_E1	6
 #define EP93XX_CHIP_REV_E2	7
 
-#ifdef CONFIG_ARCH_EP93XX
+#if defined(CONFIG_ARCH_EP93XX) && !defined(CONFIG_OF)
 int ep93xx_pwm_acquire_gpio(struct platform_device *pdev);
 void ep93xx_pwm_release_gpio(struct platform_device *pdev);
 int ep93xx_ide_acquire_gpio(struct platform_device *pdev);
@@ -19,8 +19,6 @@ int ep93xx_keypad_acquire_gpio(struct platform_device *pdev);
 void ep93xx_keypad_release_gpio(struct platform_device *pdev);
 int ep93xx_i2s_acquire(void);
 void ep93xx_i2s_release(void);
-unsigned int ep93xx_chip_revision(void);
-
 #else
 static inline int ep93xx_pwm_acquire_gpio(struct platform_device *pdev) { return 0; }
 static inline void ep93xx_pwm_release_gpio(struct platform_device *pdev) {}
@@ -30,8 +28,18 @@ static inline int ep93xx_keypad_acquire_gpio(struct platform_device *pdev) { ret
 static inline void ep93xx_keypad_release_gpio(struct platform_device *pdev) {}
 static inline int ep93xx_i2s_acquire(void) { return 0; }
 static inline void ep93xx_i2s_release(void) {}
-static inline unsigned int ep93xx_chip_revision(void) { return 0; }
+#endif
 
+#if defined(CONFIG_ARCH_EP93XX)
+unsigned int ep93xx_chip_revision(void);
+#ifdef CONFIG_SOC_EP93XX
+void ep93xx_devcfg_set_clear(unsigned int set_bits, unsigned int clear_bits);
+void ep93xx_syscon_swlocked_write(unsigned int val, unsigned int reg);
+void ep93xx_swlocked_update_bits(unsigned int reg,
+				 unsigned int mask, unsigned int val);
+#endif
+#else
+static inline unsigned int ep93xx_chip_revision(void) { return 0; }
 #endif
 
 #endif
-- 
2.39.2

