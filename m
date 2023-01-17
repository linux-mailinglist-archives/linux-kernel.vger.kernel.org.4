Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF4DD66E4CE
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 18:22:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbjAQRWy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 12:22:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235184AbjAQRWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 12:22:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC6071E5D6;
        Tue, 17 Jan 2023 09:21:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 76B20614E7;
        Tue, 17 Jan 2023 17:21:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABC2BC433EF;
        Tue, 17 Jan 2023 17:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673976085;
        bh=9wwVcHjy8o8R0Tm0Qxk0hELS+dDYumTePIwYrvyTEIY=;
        h=From:To:Cc:Subject:Date:From;
        b=O5jTplu/i3ONiBA9HU0qKqCmWa0/F0c4cFMbTxaeekS3wvpkEEVXmn6euceZpoLo9
         CzVuXu47gE4tdP2lTVtCcNzuiEQoPW0sKlGCuMw09RJMvNghyPOcCqxYA+B7V87HLx
         a30FSP83a8egkNEn0nT5ekf1+IidZyWIoblRaU8J6shDsDXZwCfa+11WekhS0CyGuB
         u63nHRq38XrEJa3g+sZlLk/G5dpSfe0CrXJR43DfHzjTfdvMNEp2vVQSSuRvenJTWd
         /Sx7IWWqbi35PXCNV1Cj2sYzch8OML+BKFUZw93KRVDB9gfPxxPWHL/JpP5TXfJhG5
         XlU06G5WiokQA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Basavaraj Natikar <basavaraj.natikar@amd.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Douglas Anderson <dianders@chromium.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] hid: stop drivers from selecting CONFIG_HID
Date:   Tue, 17 Jan 2023 18:20:55 +0100
Message-Id: <20230117172121.2715953-1-arnd@kernel.org>
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

There is a mix of drivers using either 'depends on HID' or 'select HID',
which causes both circular dependencies and missed dependencies for
a 'select':

WARNING: unment direct dependencies for HID
  Depends on [m]: HID_SUPPORT [=y] && INPUT [=m]
  Selected by [y]:
  - AMD_SFH_HID [=y] && HID_SUPPORT [=y] && (X86_64 || COMPILE_TEST [=y]) && PCI [=y]
  Selected by [m]:
  - I2C_HID_CORE [=m] && HID_SUPPORT [=y]

WARNING: unmet direct dependencies detected for INPUT_FF_MEMLESS
  Depends on [m]: INPUT [=m]
  Selected by [y]:
  - DRAGONRISE_FF [=y] && HID_SUPPORT [=y] && HID [=y] && HID_DRAGONRISE [=y]
  - HID_MICROSOFT [=y] && HID_SUPPORT [=y] && HID [=y]
  - GREENASIA_FF [=y] && HID_SUPPORT [=y] && HID [=y] && HID_GREENASIA [=y]
  Selected by [m]:
  - INPUT_ARIZONA_HAPTICS [=m] && INPUT [=m] && INPUT_MISC [=y] && MFD_ARIZONA [=y] && SND_SOC [=m]
  - INPUT_PM8XXX_VIBRATOR [=m] && INPUT [=m] && INPUT_MISC [=y] && (MFD_PM8XXX [=m] || MFD_SPMI_PMIC [=n])
  - INPUT_MAX8997_HAPTIC [=m] && INPUT [=m] && INPUT_MISC [=y] && PWM [=y] && MFD_MAX8997 [=y]
  - INPUT_GPIO_VIBRA [=m] && INPUT [=m] && INPUT_MISC [=y] && (GPIOLIB [=y] || COMPILE_TEST [=y])
  - INPUT_REGULATOR_HAPTIC [=m] && INPUT [=m] && INPUT_MISC [=y] && REGULATOR [=y]
  - INPUT_TWL6040_VIBRA [=m] && INPUT [=m] && INPUT_MISC [=y] && TWL6040_CORE [=y]
  - INPUT_PWM_VIBRA [=m] && INPUT [=m] && INPUT_MISC [=y] && PWM [=y]
  - INPUT_DRV260X_HAPTICS [=m] && INPUT_MISC [=y] && INPUT [=m] && I2C [=y] && (GPIOLIB [=y] || COMPILE_TEST [=y])
  - INPUT_DRV2665_HAPTICS [=m] && INPUT_MISC [=y] && INPUT [=m] && I2C [=y]
  - INPUT_DRV2667_HAPTICS [=m] && INPUT_MISC [=y] && INPUT [=m] && I2C [=y]
  - INPUT_SC27XX_VIBRA [=m] && INPUT [=m] && INPUT_MISC [=y] && (MFD_SC27XX_PMIC [=y] || COMPILE_TEST [=y])
  - HID_MAYFLASH [=m] && HID_SUPPORT [=y] && HID [=y]

Avoid this by changing all HID client drivers to use 'depends on HID'.
For I2C_HID, this requires a larger rework of the Kconfig description,
but it hopefully becomes easier to understand without the complex
I2C_HID_CORE definition.

Fixes: 25621bcc8976 ("HID: Kconfig: split HID support and hid-core compilation")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/hid/amd-sfh-hid/Kconfig   |  2 +-
 drivers/hid/i2c-hid/Kconfig       | 31 ++++++++++++++++---------------
 drivers/hid/intel-ish-hid/Kconfig |  2 +-
 3 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/drivers/hid/amd-sfh-hid/Kconfig b/drivers/hid/amd-sfh-hid/Kconfig
index 56e473fc3c93..af752dd3a340 100644
--- a/drivers/hid/amd-sfh-hid/Kconfig
+++ b/drivers/hid/amd-sfh-hid/Kconfig
@@ -5,7 +5,7 @@ menu "AMD SFH HID Support"
 
 config AMD_SFH_HID
 	tristate "AMD Sensor Fusion Hub"
-	select HID
+	depends on HID
 	help
 	  If you say yes to this option, support will be included for the
 	  AMD Sensor Fusion Hub.
diff --git a/drivers/hid/i2c-hid/Kconfig b/drivers/hid/i2c-hid/Kconfig
index d65abe65ce73..b72b7f1ceca8 100644
--- a/drivers/hid/i2c-hid/Kconfig
+++ b/drivers/hid/i2c-hid/Kconfig
@@ -1,11 +1,15 @@
 # SPDX-License-Identifier: GPL-2.0-only
-menu "I2C HID support"
-	depends on I2C
+menuconfig I2C_HID
+	tristate "I2C HID support"
+	default y
+	depends on I2C && INPUT && HID
+
+if I2C_HID
 
 config I2C_HID_ACPI
 	tristate "HID over I2C transport layer ACPI driver"
-	default n
-	depends on I2C && INPUT && ACPI
+	depends on ACPI
+	select I2C_HID_CORE
 	help
 	  Say Y here if you use a keyboard, a touchpad, a touchscreen, or any
 	  other HID based devices which is connected to your computer via I2C.
@@ -19,8 +23,8 @@ config I2C_HID_ACPI
 
 config I2C_HID_OF
 	tristate "HID over I2C transport layer Open Firmware driver"
-	default n
-	depends on I2C && INPUT && OF
+	depends on OF
+	select I2C_HID_CORE
 	help
 	  Say Y here if you use a keyboard, a touchpad, a touchscreen, or any
 	  other HID based devices which is connected to your computer via I2C.
@@ -34,8 +38,8 @@ config I2C_HID_OF
 
 config I2C_HID_OF_ELAN
 	tristate "Driver for Elan hid-i2c based devices on OF systems"
-	default n
-	depends on I2C && INPUT && OF
+	depends on OF
+	select I2C_HID_CORE
 	help
 	  Say Y here if you want support for Elan i2c devices that use
 	  the i2c-hid protocol on Open Firmware (Device Tree)-based
@@ -49,8 +53,8 @@ config I2C_HID_OF_ELAN
 
 config I2C_HID_OF_GOODIX
 	tristate "Driver for Goodix hid-i2c based devices on OF systems"
-	default n
-	depends on I2C && INPUT && OF
+	depends on OF
+	select I2C_HID_CORE
 	help
 	  Say Y here if you want support for Goodix i2c devices that use
 	  the i2c-hid protocol on Open Firmware (Device Tree)-based
@@ -62,10 +66,7 @@ config I2C_HID_OF_GOODIX
 	  will be called i2c-hid-of-goodix.  It will also build/depend on
 	  the module i2c-hid.
 
-endmenu
-
 config I2C_HID_CORE
 	tristate
-	default y if I2C_HID_ACPI=y || I2C_HID_OF=y || I2C_HID_OF_ELAN=y || I2C_HID_OF_GOODIX=y
-	default m if I2C_HID_ACPI=m || I2C_HID_OF=m || I2C_HID_OF_ELAN=m || I2C_HID_OF_GOODIX=m
-	select HID
+
+endif
diff --git a/drivers/hid/intel-ish-hid/Kconfig b/drivers/hid/intel-ish-hid/Kconfig
index 689da84a520d..253dc10d35ef 100644
--- a/drivers/hid/intel-ish-hid/Kconfig
+++ b/drivers/hid/intel-ish-hid/Kconfig
@@ -6,7 +6,7 @@ config INTEL_ISH_HID
 	tristate "Intel Integrated Sensor Hub"
 	default n
 	depends on X86
-	select HID
+	depends on HID
 	help
 	  The Integrated Sensor Hub (ISH) enables the ability to offload
 	  sensor polling and algorithm processing to a dedicated low power
-- 
2.39.0

