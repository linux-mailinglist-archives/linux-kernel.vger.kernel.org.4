Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A49E65EDB1
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 14:47:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233539AbjAENrp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 08:47:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233744AbjAENr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 08:47:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEDA53E0F7;
        Thu,  5 Jan 2023 05:47:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7C08F61A94;
        Thu,  5 Jan 2023 13:47:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCDB1C433EF;
        Thu,  5 Jan 2023 13:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672926444;
        bh=FJKWxab8jgdL8QRSTYPu5QbZT8XQ3r9MStsrq3HgraI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TnoemKZzlRtc4RbEDYwYrCxMaldvoq9hyvkFjNaiMs5ONNoYxKPPzSjf43HdnWHT7
         Jv74JP+8X5YGEHqPaIgTm3LPX1TA5JwLc/VA8FKXaqF+4RDrdoBrQkBLP1yk2Ux1cw
         He4/DRqeYpjZ+mjxs6CxmaJfUgGXwaJDMCYs+GhhL35wsZ66DwI7ciwkwZOahik8kG
         Iu31DzXvHzbi8gD0KfPvb0wXW1fj0Hyv8+p4NN19KO9YdblTjiCKI5PiAit7Ls4IAy
         /gh112XMwrQWYIkRKDAtGUSYs9atY1N+eydNJENVGsRQyZO+R79V93XCTvl/d63IYp
         wcA2KTxneqmYQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Robert Jarzmik <robert.jarzmik@free.fr>
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Sebastian Reichel <sre@kernel.org>,
        Anton Vorontsov <cbou@mail.ru>, linux-pm@vger.kernel.org
Subject: [PATCH 16/27] power: remove pda_power supply driver
Date:   Thu,  5 Jan 2023 14:46:11 +0100
Message-Id: <20230105134622.254560-17-arnd@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230105134622.254560-1-arnd@kernel.org>
References: <20230105134622.254560-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,TVD_SUBJ_WIPE_DEBT autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

This driver was used for a couple of Intel PXA and Samsung S3C24xx
based PDAs, but all of those are now removed from the kernel, so
the driver itself is no longer useful.

Cc: Sebastian Reichel <sre@kernel.org>
Cc: Anton Vorontsov <cbou@mail.ru>
Cc: linux-pm@vger.kernel.org
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 Documentation/power/power_supply_class.rst |   4 +-
 arch/arm/mach-tegra/tegra.c                |   1 -
 drivers/power/supply/Kconfig               |   9 -
 drivers/power/supply/Makefile              |   1 -
 drivers/power/supply/pda_power.c           | 520 ---------------------
 include/linux/pda_power.h                  |  39 --
 6 files changed, 2 insertions(+), 572 deletions(-)
 delete mode 100644 drivers/power/supply/pda_power.c
 delete mode 100644 include/linux/pda_power.h

diff --git a/Documentation/power/power_supply_class.rst b/Documentation/power/power_supply_class.rst
index c04fabee0a58..da8e275a14ff 100644
--- a/Documentation/power/power_supply_class.rst
+++ b/Documentation/power/power_supply_class.rst
@@ -40,8 +40,8 @@ kind of power supply, and can process/present them to a user in consistent
 manner. Results for different power supplies and machines are also directly
 comparable.
 
-See drivers/power/supply/ds2760_battery.c and drivers/power/supply/pda_power.c
-for the example how to declare and handle attributes.
+See drivers/power/supply/ds2760_battery.c for the example how to declare
+and handle attributes.
 
 
 Units
diff --git a/arch/arm/mach-tegra/tegra.c b/arch/arm/mach-tegra/tegra.c
index ab5008f35803..9ef1dfa7b926 100644
--- a/arch/arm/mach-tegra/tegra.c
+++ b/arch/arm/mach-tegra/tegra.c
@@ -19,7 +19,6 @@
 #include <linux/of_fdt.h>
 #include <linux/of.h>
 #include <linux/of_platform.h>
-#include <linux/pda_power.h>
 #include <linux/platform_device.h>
 #include <linux/serial_8250.h>
 #include <linux/slab.h>
diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index 3c37f3a6431c..e2f8dfcdd2a9 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -28,15 +28,6 @@ config POWER_SUPPLY_HWMON
 	  Say 'Y' here if you want power supplies to
 	  have hwmon sysfs interface too.
 
-
-config PDA_POWER
-	tristate "Generic PDA/phone power driver"
-	depends on !S390
-	help
-	  Say Y here to enable generic power driver for PDAs and phones with
-	  one or two external power supplies (AC/USB) connected to main and
-	  backup batteries, and optional builtin charger.
-
 config APM_POWER
 	tristate "APM emulation for class batteries"
 	depends on APM_EMULATION
diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
index 55c1aae91d1d..8cb3c7f5c111 100644
--- a/drivers/power/supply/Makefile
+++ b/drivers/power/supply/Makefile
@@ -9,7 +9,6 @@ obj-$(CONFIG_POWER_SUPPLY)	+= power_supply.o
 obj-$(CONFIG_POWER_SUPPLY_HWMON) += power_supply_hwmon.o
 obj-$(CONFIG_GENERIC_ADC_BATTERY)	+= generic-adc-battery.o
 
-obj-$(CONFIG_PDA_POWER)		+= pda_power.o
 obj-$(CONFIG_APM_POWER)		+= apm_power.o
 obj-$(CONFIG_AXP20X_POWER)	+= axp20x_usb_power.o
 obj-$(CONFIG_IP5XXX_POWER)	+= ip5xxx_power.o
diff --git a/drivers/power/supply/pda_power.c b/drivers/power/supply/pda_power.c
deleted file mode 100644
index 03a37fd6be27..000000000000
diff --git a/include/linux/pda_power.h b/include/linux/pda_power.h
deleted file mode 100644
index 2a69db4b60b7..000000000000
-- 
2.39.0

