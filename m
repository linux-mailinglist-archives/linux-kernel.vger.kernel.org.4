Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D69274F1C1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 16:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231433AbjGKOV1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 10:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbjGKOVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 10:21:25 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A43331731
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 07:21:05 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2b734aea34aso1178821fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 07:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689085260; x=1691677260;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YSKTBplafBxn9qBTvU+oX8v93f247AJHKPJqc+tN6+8=;
        b=Ey+zgeTXJXrgW1S8K0Df2HHB93lSYF8p6K4gY0bfDIeiDHTT4Ul7iZ020Vm0rg06go
         4O8Vw04ajtp0lRaoICRhBBtw/Ony3neabsw0ldmgxkc3WCpJ4iBzxSOO8DR+YdyURz6F
         gH7ky71KyC0EBC+ZkYebGpLKjNlcnEeqPkZ7HerY7+osh7f5G5KNtui+mziGRaBKD1hC
         BU2WuleBZJHMzShZ55MNLksXGmpWjvIQmAX0cX3oSLIaVNH6QGGqZe06137GIUbCMzrZ
         w+fltn9sHuNOgc4TAYY0FdgYOF2166JZLcj1CEFpn09n0Z9uz1+KaeFSaGalnsAByZH+
         75Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689085260; x=1691677260;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YSKTBplafBxn9qBTvU+oX8v93f247AJHKPJqc+tN6+8=;
        b=UliYN6J61duR4MSkBuF9Yz4uuY9B4APveKCnENQQhC8EwmKrHUKn+ujTdCN1MZdiMk
         Y6kOdb+74ydGLOkocPnMbLFVqoEzRds3JG0f6KP+66vqmDH/3POfmE6X1kdDF08vhtYs
         suzVbTKtVkYyo1+LLyzRa6Hd0Yva+t2+7Gl3FBPLHne+7KKi9Kmof740xz8ikS5zchyo
         wOycyupOMET1dJFIcrZKi6WbYlYLnt6b3wE+AVuzCz6gbmvh9FrdIql42ktE6nm8lbYt
         mSkGjXWGI4hLBf1TCeusPexRV96wHJ6XwQyYnGCXYyEkmHh5YoK2z4mQSTJtkKtMY6aP
         9KnQ==
X-Gm-Message-State: ABy/qLbZXEpTc6K5zvDAZRZK23gKkquxuy5qQYyyqnBrGG28NQf9mlVs
        xisN91b7AD9Z0t5AaBz0WT1cVw==
X-Google-Smtp-Source: APBJJlG+GC2YoALaqzoQBZEEmGwybOkfQoxBAGxVlcX2RBUiIPLaL+TYohG34JVuyxo45xSfKka+nw==
X-Received: by 2002:a2e:924e:0:b0:2b6:cecb:2f0f with SMTP id v14-20020a2e924e000000b002b6cecb2f0fmr13641040ljg.2.1689085259858;
        Tue, 11 Jul 2023 07:20:59 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id a6-20020a2e9806000000b002b6bb68c7eesm480090ljj.110.2023.07.11.07.20.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 07:20:59 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        linux-mips@vger.kernel.org, linux-rpi-kernel@lists.infradead.org
Subject: [PATCH v2 05/18] soc: bcm: Move power-domain drivers to the genpd dir
Date:   Tue, 11 Jul 2023 16:20:56 +0200
Message-Id: <20230711142056.751590-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To simplify with maintenance let's move the bcm power-domain drivers to the
new genpd directory. Going forward, patches are intended to be managed
through a separate git tree, according to MAINTAINERS.

While moving the drivers, we end up with a directory for bcm63xx that only
contains a Kconfig file, which seems a bit silly. Let's therefore also move
the Kconfig options into the Kconfig file a directory above, as it allows
us to drop the directory too.

Cc: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Ray Jui <rjui@broadcom.com>
Cc: Scott Branden <sbranden@broadcom.com>
Cc: <linux-mips@vger.kernel.org>
Cc: <linux-rpi-kernel@lists.infradead.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 MAINTAINERS                                   |  4 ++--
 drivers/genpd/Makefile                        |  1 +
 drivers/genpd/bcm/Makefile                    |  5 +++++
 .../{soc/bcm/bcm63xx => genpd/bcm}/bcm-pmb.c  |  0
 drivers/{soc => genpd}/bcm/bcm2835-power.c    |  0
 .../bcm/bcm63xx => genpd/bcm}/bcm63xx-power.c |  0
 .../{soc => genpd}/bcm/raspberrypi-power.c    |  0
 drivers/soc/bcm/Kconfig                       | 22 ++++++++++++++++++-
 drivers/soc/bcm/Makefile                      |  3 ---
 drivers/soc/bcm/bcm63xx/Kconfig               | 21 ------------------
 drivers/soc/bcm/bcm63xx/Makefile              |  3 ---
 11 files changed, 29 insertions(+), 30 deletions(-)
 create mode 100644 drivers/genpd/bcm/Makefile
 rename drivers/{soc/bcm/bcm63xx => genpd/bcm}/bcm-pmb.c (100%)
 rename drivers/{soc => genpd}/bcm/bcm2835-power.c (100%)
 rename drivers/{soc/bcm/bcm63xx => genpd/bcm}/bcm63xx-power.c (100%)
 rename drivers/{soc => genpd}/bcm/raspberrypi-power.c (100%)
 delete mode 100644 drivers/soc/bcm/bcm63xx/Kconfig
 delete mode 100644 drivers/soc/bcm/bcm63xx/Makefile

diff --git a/MAINTAINERS b/MAINTAINERS
index caa221fd0c11..77629ab4a5f0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4009,7 +4009,7 @@ F:	arch/mips/kernel/*bmips*
 F:	drivers/irqchip/irq-bcm63*
 F:	drivers/irqchip/irq-bcm7*
 F:	drivers/irqchip/irq-brcmstb*
-F:	drivers/soc/bcm/bcm63xx
+F:	drivers/genpd/bcm/bcm63xx-power.c
 F:	include/linux/bcm963xx_nvram.h
 F:	include/linux/bcm963xx_tag.h
 
@@ -4224,7 +4224,7 @@ R:	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
 L:	linux-pm@vger.kernel.org
 S:	Maintained
 T:	git https://github.com/broadcom/stblinux.git
-F:	drivers/soc/bcm/bcm63xx/bcm-pmb.c
+F:	drivers/genpd/bcm/bcm-pmb.c
 F:	include/dt-bindings/soc/bcm-pmb.h
 
 BROADCOM SPECIFIC AMBA DRIVER (BCMA)
diff --git a/drivers/genpd/Makefile b/drivers/genpd/Makefile
index 91d4a3808981..6b9e9fe907f3 100644
--- a/drivers/genpd/Makefile
+++ b/drivers/genpd/Makefile
@@ -2,3 +2,4 @@
 obj-y					+= actions/
 obj-y					+= amlogic/
 obj-y					+= apple/
+obj-y					+= bcm/
diff --git a/drivers/genpd/bcm/Makefile b/drivers/genpd/bcm/Makefile
new file mode 100644
index 000000000000..6bfbe4e4db13
--- /dev/null
+++ b/drivers/genpd/bcm/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0-only
+obj-$(CONFIG_BCM_PMB)			+= bcm-pmb.o
+obj-$(CONFIG_BCM2835_POWER)		+= bcm2835-power.o
+obj-$(CONFIG_BCM63XX_POWER)		+= bcm63xx-power.o
+obj-$(CONFIG_RASPBERRYPI_POWER)		+= raspberrypi-power.o
diff --git a/drivers/soc/bcm/bcm63xx/bcm-pmb.c b/drivers/genpd/bcm/bcm-pmb.c
similarity index 100%
rename from drivers/soc/bcm/bcm63xx/bcm-pmb.c
rename to drivers/genpd/bcm/bcm-pmb.c
diff --git a/drivers/soc/bcm/bcm2835-power.c b/drivers/genpd/bcm/bcm2835-power.c
similarity index 100%
rename from drivers/soc/bcm/bcm2835-power.c
rename to drivers/genpd/bcm/bcm2835-power.c
diff --git a/drivers/soc/bcm/bcm63xx/bcm63xx-power.c b/drivers/genpd/bcm/bcm63xx-power.c
similarity index 100%
rename from drivers/soc/bcm/bcm63xx/bcm63xx-power.c
rename to drivers/genpd/bcm/bcm63xx-power.c
diff --git a/drivers/soc/bcm/raspberrypi-power.c b/drivers/genpd/bcm/raspberrypi-power.c
similarity index 100%
rename from drivers/soc/bcm/raspberrypi-power.c
rename to drivers/genpd/bcm/raspberrypi-power.c
diff --git a/drivers/soc/bcm/Kconfig b/drivers/soc/bcm/Kconfig
index 24f92a6e882a..f96906795fa6 100644
--- a/drivers/soc/bcm/Kconfig
+++ b/drivers/soc/bcm/Kconfig
@@ -42,7 +42,27 @@ config SOC_BRCMSTB
 
 	  If unsure, say N.
 
-source "drivers/soc/bcm/bcm63xx/Kconfig"
+config BCM_PMB
+	bool "Broadcom PMB (Power Management Bus) driver"
+	depends on ARCH_BCMBCA || (COMPILE_TEST && OF)
+	default ARCH_BCMBCA
+	select PM_GENERIC_DOMAINS if PM
+	help
+	  This enables support for the Broadcom's PMB (Power Management Bus) that
+	  is used for disabling and enabling SoC devices.
+
+if SOC_BCM63XX
+
+config BCM63XX_POWER
+	bool "BCM63xx power domain driver"
+	depends on BMIPS_GENERIC || (COMPILE_TEST && OF)
+	select PM_GENERIC_DOMAINS if PM
+	help
+	  This enables support for the BCM63xx power domains controller on
+	  BCM6318, BCM6328, BCM6362 and BCM63268 SoCs.
+
+endif # SOC_BCM63XX
+
 source "drivers/soc/bcm/brcmstb/Kconfig"
 
 endmenu
diff --git a/drivers/soc/bcm/Makefile b/drivers/soc/bcm/Makefile
index 0f0efa28d92b..32424b1032c7 100644
--- a/drivers/soc/bcm/Makefile
+++ b/drivers/soc/bcm/Makefile
@@ -1,5 +1,2 @@
 # SPDX-License-Identifier: GPL-2.0-only
-obj-$(CONFIG_BCM2835_POWER)	+= bcm2835-power.o
-obj-$(CONFIG_RASPBERRYPI_POWER)	+= raspberrypi-power.o
-obj-y				+= bcm63xx/
 obj-$(CONFIG_SOC_BRCMSTB)	+= brcmstb/
diff --git a/drivers/soc/bcm/bcm63xx/Kconfig b/drivers/soc/bcm/bcm63xx/Kconfig
deleted file mode 100644
index 355c34482076..000000000000
--- a/drivers/soc/bcm/bcm63xx/Kconfig
+++ /dev/null
@@ -1,21 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-if SOC_BCM63XX
-
-config BCM63XX_POWER
-	bool "BCM63xx power domain driver"
-	depends on BMIPS_GENERIC || (COMPILE_TEST && OF)
-	select PM_GENERIC_DOMAINS if PM
-	help
-	  This enables support for the BCM63xx power domains controller on
-	  BCM6318, BCM6328, BCM6362 and BCM63268 SoCs.
-
-endif # SOC_BCM63XX
-
-config BCM_PMB
-	bool "Broadcom PMB (Power Management Bus) driver"
-	depends on ARCH_BCMBCA || (COMPILE_TEST && OF)
-	default ARCH_BCMBCA
-	select PM_GENERIC_DOMAINS if PM
-	help
-	  This enables support for the Broadcom's PMB (Power Management Bus) that
-	  is used for disabling and enabling SoC devices.
diff --git a/drivers/soc/bcm/bcm63xx/Makefile b/drivers/soc/bcm/bcm63xx/Makefile
deleted file mode 100644
index 557eed3d67bd..000000000000
--- a/drivers/soc/bcm/bcm63xx/Makefile
+++ /dev/null
@@ -1,3 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-obj-$(CONFIG_BCM63XX_POWER) += bcm63xx-power.o
-obj-$(CONFIG_BCM_PMB)		+= bcm-pmb.o
-- 
2.34.1

