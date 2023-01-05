Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB3EE65EDCB
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 14:49:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233501AbjAENtC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 08:49:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233114AbjAENrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 08:47:33 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C85944C6D;
        Thu,  5 Jan 2023 05:47:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4CB37B81AE1;
        Thu,  5 Jan 2023 13:47:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA95DC433D2;
        Thu,  5 Jan 2023 13:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672926450;
        bh=d2eMyq0HGhLsx1LltDWv2G7RIn4/aKrP4wiNiXXsPEA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BfWqQLHFhgoo16rgfAP2Sv9vMmx2kHvNdbYjrUOhNYKIvudziRsWab1f8x+tR94IE
         BXDa0f/HbhRq1HFpeTqNVHelI4izq/TNrzBjnGq5GcQI7EgeoSD9Z+xC3Z9cRQ9Hw9
         Hs9cfJbKZSwV5Pezpru3M7hhssThbYqLSE4Ytw2N25OGK0Kq/CUOWOqhh7k4jEVbU4
         9Kg52uuO/3L3Qe7KEW/uL91nMnGRuhEuj4JAgTqhoY1x1TT3+x5C/MfGMriVeCwI0E
         Z64laSpnN+eDO/TlyU2kP/PtNe5kZFj2muHuMu0efJirCpFkCsA942Dwi5N5uCsFZn
         DHFFjU9ydpd3A==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Robert Jarzmik <robert.jarzmik@free.fr>
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Lee Jones <lee@kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: [PATCH 18/27] mfd: remove toshiba tmio drivers
Date:   Thu,  5 Jan 2023 14:46:13 +0100
Message-Id: <20230105134622.254560-19-arnd@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230105134622.254560-1-arnd@kernel.org>
References: <20230105134622.254560-1-arnd@kernel.org>
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

Four separate mfd drivers are in the "tmio" family, and all of
them were used in now-removed PXA machines (eseries, tosa, and
hx4700), so the mfd drivers and all its children can be removed
as well.

Cc: Lee Jones <lee@kernel.org>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-mmc@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/mfd/Kconfig          |   38 --
 drivers/mfd/Makefile         |    4 -
 drivers/mfd/asic3.c          | 1071 ----------------------------------
 drivers/mfd/t7l66xb.c        |  427 --------------
 drivers/mfd/tc6387xb.c       |  228 --------
 drivers/mfd/tc6393xb.c       |  907 ----------------------------
 drivers/mfd/tmio_core.c      |   70 ---
 include/linux/mfd/asic3.h    |  313 ----------
 include/linux/mfd/t7l66xb.h  |   29 -
 include/linux/mfd/tc6387xb.h |   19 -
 include/linux/mfd/tc6393xb.h |   53 --
 include/linux/mfd/tmio.h     |    5 -
 12 files changed, 3164 deletions(-)
 delete mode 100644 drivers/mfd/asic3.c
 delete mode 100644 drivers/mfd/t7l66xb.c
 delete mode 100644 drivers/mfd/tc6387xb.c
 delete mode 100644 drivers/mfd/tc6393xb.c
 delete mode 100644 drivers/mfd/tmio_core.c
 delete mode 100644 include/linux/mfd/asic3.h
 delete mode 100644 include/linux/mfd/t7l66xb.h
 delete mode 100644 include/linux/mfd/tc6387xb.h
 delete mode 100644 include/linux/mfd/tc6393xb.h

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 2cd06e63e32f..da57ebf22630 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -300,15 +300,6 @@ config MFD_CS47L92
 	help
 	  Support for Cirrus Logic CS42L92, CS47L92 and CS47L93 Smart Codecs
 
-config MFD_ASIC3
-	bool "Compaq ASIC3"
-	depends on GPIOLIB
-	depends on ARM || COMPILE_TEST
-	select MFD_CORE
-	help
-	  This driver supports the ASIC3 multifunction chip found on many
-	  PDAs (mainly iPAQ and HTC based ones)
-
 config PMIC_DA903X
 	bool "Dialog Semiconductor DA9030/DA9034 PMIC Support"
 	depends on I2C=y
@@ -1795,35 +1786,6 @@ config MFD_TC3589X
 	  additional drivers must be enabled in order to use the
 	  functionality of the device.
 
-config MFD_TMIO
-	bool
-	default n
-
-config MFD_T7L66XB
-	bool "Toshiba T7L66XB"
-	depends on ARM && HAVE_CLK
-	select MFD_CORE
-	select MFD_TMIO
-	help
-	  Support for Toshiba Mobile IO Controller T7L66XB
-
-config MFD_TC6387XB
-	bool "Toshiba TC6387XB"
-	depends on ARM && HAVE_CLK
-	select MFD_CORE
-	select MFD_TMIO
-	help
-	  Support for Toshiba Mobile IO Controller TC6387XB
-
-config MFD_TC6393XB
-	bool "Toshiba TC6393XB"
-	depends on ARM && HAVE_CLK
-	select GPIOLIB
-	select MFD_CORE
-	select MFD_TMIO
-	help
-	  Support for Toshiba Mobile IO Controller TC6393XB
-
 config MFD_TQMX86
 	tristate "TQ-Systems IO controller TQMX86"
 	select MFD_CORE
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index 457471478a93..9ba9d711c492 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -9,7 +9,6 @@ obj-$(CONFIG_MFD_88PM800)	+= 88pm800.o 88pm80x.o
 obj-$(CONFIG_MFD_88PM805)	+= 88pm805.o 88pm80x.o
 obj-$(CONFIG_MFD_ACT8945A)	+= act8945a.o
 obj-$(CONFIG_MFD_SM501)		+= sm501.o
-obj-$(CONFIG_MFD_ASIC3)		+= asic3.o tmio_core.o
 obj-$(CONFIG_ARCH_BCM2835)	+= bcm2835-pm.o
 obj-$(CONFIG_MFD_BCM590XX)	+= bcm590xx.o
 obj-$(CONFIG_MFD_BD9571MWV)	+= bd9571mwv.o
@@ -30,9 +29,6 @@ obj-$(CONFIG_STMPE_I2C)		+= stmpe-i2c.o
 obj-$(CONFIG_STMPE_SPI)		+= stmpe-spi.o
 obj-$(CONFIG_MFD_SUN6I_PRCM)	+= sun6i-prcm.o
 obj-$(CONFIG_MFD_TC3589X)	+= tc3589x.o
-obj-$(CONFIG_MFD_T7L66XB)	+= t7l66xb.o tmio_core.o
-obj-$(CONFIG_MFD_TC6387XB)	+= tc6387xb.o tmio_core.o
-obj-$(CONFIG_MFD_TC6393XB)	+= tc6393xb.o tmio_core.o
 obj-$(CONFIG_MFD_TQMX86)	+= tqmx86.o
 
 obj-$(CONFIG_MFD_LOCHNAGAR)	+= lochnagar-i2c.o
diff --git a/drivers/mfd/asic3.c b/drivers/mfd/asic3.c
deleted file mode 100644
index 4fb7e35eb5ed..000000000000
diff --git a/drivers/mfd/t7l66xb.c b/drivers/mfd/t7l66xb.c
deleted file mode 100644
index 1d9d1d38d068..000000000000
diff --git a/drivers/mfd/tc6387xb.c b/drivers/mfd/tc6387xb.c
deleted file mode 100644
index 5392da6ba7b0..000000000000
diff --git a/drivers/mfd/tc6393xb.c b/drivers/mfd/tc6393xb.c
deleted file mode 100644
index 997bb8b5881d..000000000000
diff --git a/drivers/mfd/tmio_core.c b/drivers/mfd/tmio_core.c
deleted file mode 100644
index 7ee873551482..000000000000
diff --git a/include/linux/mfd/asic3.h b/include/linux/mfd/asic3.h
deleted file mode 100644
index 61e686dbaa74..000000000000
diff --git a/include/linux/mfd/t7l66xb.h b/include/linux/mfd/t7l66xb.h
deleted file mode 100644
index ae3e7a5c5219..000000000000
diff --git a/include/linux/mfd/tc6387xb.h b/include/linux/mfd/tc6387xb.h
deleted file mode 100644
index aacf1dcc86b9..000000000000
diff --git a/include/linux/mfd/tc6393xb.h b/include/linux/mfd/tc6393xb.h
deleted file mode 100644
index d17807f2d0c9..000000000000
diff --git a/include/linux/mfd/tmio.h b/include/linux/mfd/tmio.h
index e8bf90281ba0..eace8ea6cda0 100644
--- a/include/linux/mfd/tmio.h
+++ b/include/linux/mfd/tmio.h
@@ -84,11 +84,6 @@
 /* Some controllers have a CBSY bit */
 #define TMIO_MMC_HAVE_CBSY		BIT(11)
 
-int tmio_core_mmc_enable(void __iomem *cnf, int shift, unsigned long base);
-int tmio_core_mmc_resume(void __iomem *cnf, int shift, unsigned long base);
-void tmio_core_mmc_pwr(void __iomem *cnf, int shift, int state);
-void tmio_core_mmc_clk_div(void __iomem *cnf, int shift, int state);
-
 struct dma_chan;
 
 /*
-- 
2.39.0

