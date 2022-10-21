Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 664D460800A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 22:43:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbiJUUnU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 16:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbiJUUm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 16:42:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D53E22A17D1;
        Fri, 21 Oct 2022 13:42:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 744E761F1A;
        Fri, 21 Oct 2022 20:42:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68425C433D7;
        Fri, 21 Oct 2022 20:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666384946;
        bh=OzXG9cO8TgE4LXZUmE+an4SXeiNKfPtvb8eemwziMgg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SlEHXZ9W2VW1K52a5l4DiStfpB9gQRQ6g2Tk+CoAgvtDQeGYfFsYhfq7Frqyctheq
         luxePxPLnWV3P9teeQoo9DosYZ2TiinjkErIM/X1hVivH6/ahkulu7cB4NQ5cComLR
         QL4mayyptJxKtQIxIi/ZbJ7OOysW4KQ0pbF49GQa4rNxhX29ZW8xkoO8ly8VoYQdnu
         BQsgZHlftzNJ7NY8Y7TpmoTHNWuq6hiJqHelMhzMC5DlO0pyviGOb1vLpjJ+c9jzbd
         rrA0XiCMxMTFOB+vD9WwMgs9CB9/O16x30FOsGCjSOyYsb4oWgx4Ml+iuFA7MLjMRW
         t+dlMmUNYQh8g==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sebastian Reichel <sre@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>,
        Simtec Linux Team <linux@simtec.co.uk>,
        Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Joe Perches <joe@perches.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Luca Ceresoli <luca.ceresoli@bootlin.com>,
        Lee Jones <lee@kernel.org>, linux-pm@vger.kernel.org
Subject: [PATCH 07/21] power: remove s3c adc battery driver
Date:   Fri, 21 Oct 2022 22:27:40 +0200
Message-Id: <20221021203329.4143397-7-arnd@kernel.org>
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

The s3c-adc driver is removed along with the s3c24xx platform,
so the battery driver is no longer needed either.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 MAINTAINERS                            |   7 -
 drivers/power/supply/Kconfig           |   6 -
 drivers/power/supply/Makefile          |   1 -
 drivers/power/supply/s3c_adc_battery.c | 453 -------------------------
 include/linux/s3c_adc_battery.h        |  39 ---
 5 files changed, 506 deletions(-)
 delete mode 100644 drivers/power/supply/s3c_adc_battery.c
 delete mode 100644 include/linux/s3c_adc_battery.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 071d64e2a7ca..2caf42b0328a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17920,13 +17920,6 @@ S:	Supported
 W:	http://www.ibm.com/developerworks/linux/linux390/
 F:	drivers/s390/scsi/zfcp_*
 
-S3C ADC BATTERY DRIVER
-M:	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
-L:	linux-samsung-soc@vger.kernel.org
-S:	Odd Fixes
-F:	drivers/power/supply/s3c_adc_battery.c
-F:	include/linux/s3c_adc_battery.h
-
 S3C24XX SD/MMC Driver
 M:	Ben Dooks <ben-linux@fluff.org>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index 568b3ede993a..e2f8dfcdd2a9 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -406,12 +406,6 @@ config BATTERY_MAX1721X
 	  Say Y here to enable support for the MAX17211/MAX17215 standalone
 	  battery gas-gauge.
 
-config BATTERY_S3C_ADC
-	tristate "Battery driver for Samsung ADC based monitoring"
-	depends on S3C_ADC
-	help
-	  Say Y here to enable support for iPAQ h1930/h1940/rx1950 battery
-
 config BATTERY_TWL4030_MADC
 	tristate "TWL4030 MADC battery driver"
 	depends on TWL4030_MADC
diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
index af43866b3980..8cb3c7f5c111 100644
--- a/drivers/power/supply/Makefile
+++ b/drivers/power/supply/Makefile
@@ -54,7 +54,6 @@ obj-$(CONFIG_BATTERY_MAX17042)	+= max17042_battery.o
 obj-$(CONFIG_BATTERY_MAX1721X)	+= max1721x_battery.o
 obj-$(CONFIG_BATTERY_RT5033)	+= rt5033_battery.o
 obj-$(CONFIG_CHARGER_RT9455)	+= rt9455_charger.o
-obj-$(CONFIG_BATTERY_S3C_ADC)	+= s3c_adc_battery.o
 obj-$(CONFIG_BATTERY_TWL4030_MADC)	+= twl4030_madc_battery.o
 obj-$(CONFIG_CHARGER_88PM860X)	+= 88pm860x_charger.o
 obj-$(CONFIG_CHARGER_PCF50633)	+= pcf50633-charger.o
diff --git a/drivers/power/supply/s3c_adc_battery.c b/drivers/power/supply/s3c_adc_battery.c
deleted file mode 100644
index 68d31a3bee48..000000000000
diff --git a/include/linux/s3c_adc_battery.h b/include/linux/s3c_adc_battery.h
deleted file mode 100644
index 57f982c375f8..000000000000
-- 
2.29.2

