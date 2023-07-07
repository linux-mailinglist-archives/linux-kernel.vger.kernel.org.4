Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2281074B289
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 16:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232842AbjGGOFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 10:05:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232501AbjGGOEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 10:04:52 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F4481FF7
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 07:04:50 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2b703caf344so29112781fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 07:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688738688; x=1691330688;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B37Xu/vMDheXY8lYTD8GAgDOjIWMB+sxN84zK2+50sY=;
        b=kawc8ItC9cmWzRfifiqLJicdU4cwbMtFuX0C94hJ6r94bmcZ3LDThbBK8XnDvkMNRw
         7ph0D0wcaONyllwuoEScFdGhct+uQ6/l8hXZbyisQv0v8b9A0biQncanffq/EEdfIO/8
         GarAfWrbW0fWOSbyyBtme6ocAs61DKtd/9Kpi6r+ZnodnmPAl/M/scOyA/6plRFYHsYK
         oYjcNGIksvPGWYJoREiqoecQB5L4vYbdFF25ooHTU2nmIzXyPijePQ0bDQy6uiJmmg5t
         SJqjnMHATQ9Upc6KXLxInRWu3p3NAxzV8EvrCen1ocTpiZ7phat+ymG88Hb/D+VxNGZz
         atBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688738688; x=1691330688;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B37Xu/vMDheXY8lYTD8GAgDOjIWMB+sxN84zK2+50sY=;
        b=iIuS2R5VT7eNJ3nxI5TlQT0WNUjLCd9Jo7qLuqE9iZsY7pw92TrzdThi1hBbBbV+DU
         g6g+NhLOeirt6rSwG6JNSd0ysK0WYFctU47s+hL6XDpOB/zRjV1I/vAr3fPn90AVQct+
         +EfMK/XddOiNpEeykjKy6uvkeiQG27i1jriMdhJsVeTbtAF22NSWDl1pUyZjXdenAQ3p
         cQV3C1Ds8aE0hGD7HpgHouzAFQHHjzr5fpeu728eaa70VVFdi7CE+r4khYLESNizIOA9
         5e6Puzg87GsKB+bLoXacKrUaqe/C2UKV0alJbWOe4+ubydy4vR/ysYqxiHUu+bUGpaEa
         LeFg==
X-Gm-Message-State: ABy/qLa5bt0+ljs6qXtOEygGt6hJBe1UT9nQZ7m/UjKANyzCaIUJ9yZ6
        Ez1L62K+CRNqxz38+8oDPeWBsuKhFtkMkSd/LLs=
X-Google-Smtp-Source: APBJJlFpNs0g5rZCoqmKKClxn6bLNNiD6cxfdIuVmomJm4irVq1SXMZY0nb6x1jaEozd+QSyScSGtQ==
X-Received: by 2002:a2e:9c58:0:b0:2b6:e19e:b769 with SMTP id t24-20020a2e9c58000000b002b6e19eb769mr3551612ljj.49.1688738688394;
        Fri, 07 Jul 2023 07:04:48 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id u21-20020a2e8555000000b002b6cb25e3f1sm760341ljj.108.2023.07.07.07.04.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 07:04:47 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        linux-mips@vger.kernel.org, linux-rpi-kernel@lists.infradead.org
Subject: [PATCH 05/18] soc: bcm: Move power-domain drivers to the genpd dir
Date:   Fri,  7 Jul 2023 16:04:21 +0200
Message-Id: <20230707140434.723349-6-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230707140434.723349-1-ulf.hansson@linaro.org>
References: <20230707140434.723349-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
index 98a6847c8c3b..9fad7f6033f4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4007,7 +4007,7 @@ F:	arch/mips/kernel/*bmips*
 F:	drivers/irqchip/irq-bcm63*
 F:	drivers/irqchip/irq-bcm7*
 F:	drivers/irqchip/irq-brcmstb*
-F:	drivers/soc/bcm/bcm63xx
+F:	drivers/genpd/bcm/bcm63xx-power.c
 F:	include/linux/bcm963xx_nvram.h
 F:	include/linux/bcm963xx_tag.h
 
@@ -4222,7 +4222,7 @@ R:	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
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

