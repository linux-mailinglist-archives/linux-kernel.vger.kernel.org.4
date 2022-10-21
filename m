Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD7B9607FDB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 22:39:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbiJUUjD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 16:39:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbiJUUi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 16:38:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92C5E29E9BC;
        Fri, 21 Oct 2022 13:38:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 50F88B82D4A;
        Fri, 21 Oct 2022 20:38:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BEFCC433D6;
        Fri, 21 Oct 2022 20:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666384736;
        bh=oApeJB65dHHGk0FGZpBTdXtePZh16PGmOvugpwr59QE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bzMmvQTkB+9QRYoYXud5vjOSYi7QS5pmuHpCSpsmuW317bUTNRlFh3LxqOJBWSJYO
         o7dcKLAsQNpaeigxRUJS/HLg8ekRoFwC30hD43aOpdrtTq2zMAWjmiQsSUWwFTN8pW
         PNgpWNhSVbRSXIY2EfOmlA3ouBmDuRT1+ZicqPSzcgQOh3jb8EgozEzO97MGXgkRBf
         ZALktUSIiLjVE+I5Y3khskZ7eSVCO2WOXeKKcuoIwDHEtqCeuozz69dHzn8zk6K3a0
         LY53IrJp1FuWzGpcYGub9FECem4hNtZTUtUaV1NoEv0yNB1fBLUy2x5W6kLXxO4WnX
         VTuLUc5LW9z3A==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>,
        Simtec Linux Team <linux@simtec.co.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        linux-samsung-soc@vger.kernel.org, patches@opensource.cirrus.com
Subject: [PATCH 04/21] ARM: s3c: remove adc.c
Date:   Fri, 21 Oct 2022 22:27:37 +0200
Message-Id: <20221021203329.4143397-4-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20221021202254.4142411-1-arnd@kernel.org>
References: <20221021202254.4142411-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

This driver could not be enabled on s3c64xx for a long time
because of the ARCH_MULTIPLATFORM dependency, so remove it.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-s3c/Kconfig           |  15 -
 arch/arm/mach-s3c/Kconfig.s3c64xx   |   1 -
 arch/arm/mach-s3c/Makefile          |   4 -
 arch/arm/mach-s3c/adc.c             | 510 ----------------------------
 arch/arm/mach-s3c/mach-crag6410.c   |   1 -
 arch/arm/mach-s3c/regs-adc.h        |  64 ----
 include/linux/soc/samsung/s3c-adc.h |  32 --
 7 files changed, 627 deletions(-)
 delete mode 100644 arch/arm/mach-s3c/adc.c
 delete mode 100644 arch/arm/mach-s3c/regs-adc.h
 delete mode 100644 include/linux/soc/samsung/s3c-adc.h

diff --git a/arch/arm/mach-s3c/Kconfig b/arch/arm/mach-s3c/Kconfig
index 809f84fca0b8..0dde4010aa64 100644
--- a/arch/arm/mach-s3c/Kconfig
+++ b/arch/arm/mach-s3c/Kconfig
@@ -63,16 +63,6 @@ config S3C_GPIO_TRACK
 	  Internal configuration option to enable the s3c specific gpio
 	  chip tracking if the platform requires it.
 
-# ADC driver
-
-config S3C_ADC
-	bool "ADC common driver support"
-	depends on !ARCH_MULTIPLATFORM
-	help
-	  Core support for the ADC block found in the Samsung SoC systems
-	  for drivers such as the touchscreen and hwmon to use to share
-	  this resource.
-
 # device definitions to compile in
 
 config S3C_DEV_HSMMC
@@ -165,11 +155,6 @@ config S3C_DEV_RTC
 	help
 	  Compile in platform device definition for RTC
 
-config SAMSUNG_DEV_ADC
-	bool
-	help
-	  Compile in platform device definition for ADC controller
-
 config S3C64XX_DEV_SPI0
 	bool
 	help
diff --git a/arch/arm/mach-s3c/Kconfig.s3c64xx b/arch/arm/mach-s3c/Kconfig.s3c64xx
index 0da214c43fba..c403d7642f0a 100644
--- a/arch/arm/mach-s3c/Kconfig.s3c64xx
+++ b/arch/arm/mach-s3c/Kconfig.s3c64xx
@@ -125,7 +125,6 @@ config MACH_WLF_CRAGG_6410
 	select S3C_DEV_USB_HOST
 	select S3C_DEV_USB_HSOTG
 	select S3C_DEV_WDT
-	select SAMSUNG_DEV_ADC
 	select SAMSUNG_DEV_KEYPAD
 	select SAMSUNG_DEV_PWM
 	help
diff --git a/arch/arm/mach-s3c/Makefile b/arch/arm/mach-s3c/Makefile
index a5135137e648..bae7316be5c7 100644
--- a/arch/arm/mach-s3c/Makefile
+++ b/arch/arm/mach-s3c/Makefile
@@ -8,10 +8,6 @@ include $(src)/Makefile.s3c64xx
 
 obj-y				+= init.o cpu.o
 
-# ADC
-
-obj-$(CONFIG_S3C_ADC)	+= adc.o
-
 # devices
 
 obj-$(CONFIG_SAMSUNG_ATAGS)	+= platformdata.o
diff --git a/arch/arm/mach-s3c/adc.c b/arch/arm/mach-s3c/adc.c
deleted file mode 100644
index 0232520d3c13..000000000000
diff --git a/arch/arm/mach-s3c/mach-crag6410.c b/arch/arm/mach-s3c/mach-crag6410.c
index 9a45474d1bf7..fab6b3efc9f6 100644
--- a/arch/arm/mach-s3c/mach-crag6410.c
+++ b/arch/arm/mach-s3c/mach-crag6410.c
@@ -57,7 +57,6 @@
 #include "keypad.h"
 #include "devs.h"
 #include "cpu.h"
-#include <linux/soc/samsung/s3c-adc.h>
 #include <linux/platform_data/i2c-s3c2410.h>
 #include "pm.h"
 
diff --git a/arch/arm/mach-s3c/regs-adc.h b/arch/arm/mach-s3c/regs-adc.h
deleted file mode 100644
index 58953c7381dd..000000000000
diff --git a/include/linux/soc/samsung/s3c-adc.h b/include/linux/soc/samsung/s3c-adc.h
deleted file mode 100644
index 591c94ef957d..000000000000
-- 
2.29.2

