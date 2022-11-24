Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB63963805B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 21:49:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbiKXUtR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 15:49:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiKXUtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 15:49:11 -0500
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F28AB7F59A;
        Thu, 24 Nov 2022 12:49:06 -0800 (PST)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id BC1ED5FD25;
        Thu, 24 Nov 2022 23:49:04 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1669322944;
        bh=v1DwxOHL5+Qc+G3jD3a3MTu/9p4iyXPmlGFZ/mAoo5c=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=DZjjdRtl/KTDnxOvUO/fDPlY//5oxH/VarfmM4EAlDOuihXmIhkq9Mo0l7SEgnIu7
         GRTAw/C7QsTb5iOGZnbWcvPwcpLIMA8+EN4hPNDcBgmMxuwcHyd22A3BnPOxEivPem
         uTKN7YB/4v4kJxtLUCz2f+cFe5BkfjW1kD58Pq+XFmW/HplmkwlwNuMIgfm6rvQi6u
         4p5D9NJKebGeILHy9s33n3bXzMceXidhcrtCdWLKD2DsP/16mmMlW3OIf54vQLJ1yT
         1ew/KRI/k9UICzSVb52f1Kf+bDcCwD6mZUBxhfHwjUSYeLwgtuWt4TPyopVSJCt5kd
         He+wibAvTwPEA==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Thu, 24 Nov 2022 23:49:04 +0300 (MSK)
From:   Martin Kurbanov <mmkurbanov@sberdevices.ru>
To:     Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     <linux-leds@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <kernel@sberdevices.ru>,
        Martin Kurbanov <mmkurbanov@sberdevices.ru>
Subject: [PATCH v1 2/2] leds: add aw20xx driver
Date:   Thu, 24 Nov 2022 23:48:07 +0300
Message-ID: <20221124204807.1593241-3-mmkurbanov@sberdevices.ru>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221124204807.1593241-1-mmkurbanov@sberdevices.ru>
References: <20221124204807.1593241-1-mmkurbanov@sberdevices.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH01.sberdevices.ru (172.16.1.4) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2022/11/24 17:43:00 #20605348
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds support for AWINIC AW20036/AW20054/AW20072 LED driver.
This driver supports following AW200XX features:
  - 3 pattern controllers for auto breathing or group dimming control
  - Individual 64-level DIM currents
  - Interrupt output, low active

Signed-off-by: Martin Kurbanov <mmkurbanov@sberdevices.ru>
---
 Documentation/leds/leds-aw200xx.rst |  274 +++++++
 drivers/leds/Kconfig                |   10 +
 drivers/leds/Makefile               |    1 +
 drivers/leds/leds-aw200xx.c         | 1113 +++++++++++++++++++++++++++
 4 files changed, 1398 insertions(+)
 create mode 100644 Documentation/leds/leds-aw200xx.rst
 create mode 100644 drivers/leds/leds-aw200xx.c

diff --git a/Documentation/leds/leds-aw200xx.rst b/Documentation/leds/leds-aw200xx.rst
new file mode 100644
index 000000000000..a751b91dfda6
--- /dev/null
+++ b/Documentation/leds/leds-aw200xx.rst
@@ -0,0 +1,274 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=========================================
+Kernel driver for AW20036/AW20054/AW20072
+=========================================
+
+Description
+-----------
+
+The AW20036/AW20054/AW20072 is a 3x12/6x9/6x12 matrix LED driver programmed via
+an I2C interface. The brightness of each LED is independently controlled by
+FADE and DIM parameter.
+
+Three integrated pattern controllers provide auto breathing or group dimming
+control. Each pattern controller can work in auto breathing or manual control
+mode. All breathing parameters including rising/falling slope, on/off time,
+repeat times, min/max brightness and so on are configurable.
+
+Device attribute
+-----------------------------------
+
+**/sys/class/leds/<led>/dim** - 64-level DIM current. If write negative value
+or "auto", the dim will be calculated according to the brightness.
+
+The configuration files for each pattern are located::
+
+    /sys/bus/i2c/devices/xxxx/pattern0/
+    /sys/bus/i2c/devices/xxxx/pattern1/
+    /sys/bus/i2c/devices/xxxx/pattern2/
+
+Directory layout example for pattern
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+::
+
+    $ ls -l /sys/bus/i2c/devices/xxxx/pattern0/
+    -rw-r--r--    1 root     root          4096 Jan  1 00:00 clear_leds
+    -rw-r--r--    1 root     root          4096 Jan  1 00:00 fall_time
+    -rw-r--r--    1 root     root          4096 Jan  1 00:00 loop_begin
+    -rw-r--r--    1 root     root          4096 Jan  1 00:00 loop_end_on
+    -rw-r--r--    1 root     root          4096 Jan  1 00:00 max_breathing_level
+    -rw-r--r--    1 root     root          4096 Jan  1 00:00 min_breathing_level
+    -rw-r--r--    1 root     root          4096 Jan  1 00:00 mode
+    -rw-r--r--    1 root     root          4096 Jan  1 00:00 off_time
+    -rw-r--r--    1 root     root          4096 Jan  1 00:00 on_time
+    -rw-r--r--    1 root     root          4096 Jan  1 00:00 ramp
+    -rw-r--r--    1 root     root          4096 Jan  1 00:00 repeat
+    -rw-r--r--    1 root     root          4096 Jan  1 00:00 rise_time
+    -r--r--r--    1 root     root          4096 Jan  1 00:00 running
+    -rw-r--r--    1 root     root          4096 Jan  1 00:00 select_leds
+    -rw-r--r--    1 root     root          4096 Jan  1 00:00 start
+    -rw-r--r--    1 root     root          4096 Jan  1 00:00 toggle
+
+Timing parameters
+~~~~~~~~~~~~~~~~~
+
+- **on_time**
+
+- **rise_time**
+
+- **fall_time**
+
+- **off_time**
+
+See :ref:`auto_breath_mode`.
+
+Select from predefined times:
+
+.. flat-table::
+
+    * - Value
+      - Time (in seconds)
+      - Value
+      - Time (in seconds)
+
+    * - 0
+      - 0.00
+      - 8
+      - 2.1
+
+    * - 1
+      - 0.13
+      - 9
+      - 2.6
+
+    * - 2
+      - 0.26
+      - 10
+      - 3.1
+
+    * - 3
+      - 0.38
+      - 11
+      - 4.2
+
+    * - 4
+      - 0.51
+      - 12
+      - 5.2
+
+    * - 5
+      - 0.77
+      - 13
+      - 6.2
+
+    * - 6
+      - 1.04
+      - 14
+      - 7.3
+
+    * - 7
+      - 1.6
+      - 15
+      - 8.3
+
+Example set for rise-time=0.13s, on-time=0.26s,
+fall_time=6.2s, off_time=0.51s:
+
+.. code-block:: bash
+
+    echo 1 > rise_time
+    echo 2 > on_time
+    echo 13 > fall_time
+    echo 4 > off_time
+
+Maximum and minimum breathing Level
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+- **max_breathing_level**
+
+- **min_breathing_level**
+
+Loop
+~~~~~
+
+- **loop_begin** - choose where to start the loop:
+
+    .. flat-table::
+
+        * - Value
+          - Description
+
+        * - 0
+          - Begin from 'rise' state
+
+        * - 1
+          - Begin from 'on' state
+
+        * - 2
+          - Begin from 'fall' state
+
+        * - 3
+          - Begin from 'off' state
+
+- **loop_end_on** - write ``1`` loop end at 'on' state.
+
+- **repeat** - loop times. When write ``0``, the loop is end-less.
+
+Others
+~~~~~~
+
+- **clear_leds** - bitmask for clear leds to pattern.
+        For example clear leds 1, 2, 3, 4, 5, 7 (``10111110``):
+
+        .. code-block:: bash
+
+            echo be > clear_leds
+
+- **select_leds** - bitmask for set leds to pattern.
+        For example select leds 0, 3, 6, 7 (``11001001``):
+
+        .. code-block:: bash
+
+            echo c9 > select_leds
+
+- **mode** - pattern mode:
+    ``0`` - manual control, ``1`` - auto breathing
+
+- **start** - start/stop pattern:
+    ``0`` - to stop, ``1`` - to start
+
+- **toggle** - manual on/off control (see :ref:`manual_breath_mode`):
+    ``0`` - LEDs off, ``1`` - LEDs on
+
+- **ramp** - the smooth ramp up/down function (see :ref:`manual_breath_mode`):
+    ``0`` - disable, ``1`` - enable
+
+- **running** - Reading this file will return the pattern state:
+    ``1`` - is running, ``0`` - is finished (or not running)
+
+This file supports poll() to detect when the pattern finished.
+
+.. _auto_breath_mode:
+
+Auto breathing mode
+~~~~~~~~~~~~~~~~~~~
+
+::
+
+    breathing level
+          ^
+      max _             ________________
+          |            /.              .\
+          |           / .              . \
+          |          /  .              .  \
+          |         /   .              .   \
+          |        /    .              .    \
+          |       /     .              .     \
+      min _   ___/      .              .      \_______
+          |      .      .              .      .
+          |      .      .              .      .
+          |      . rise .      on      . fall .  off
+          |
+         -|------------------------------------------------> time
+
+Example:
+
+.. code-block:: bash
+
+    echo 10 > rise_time # 3.1 seconds
+    echo 4 > on_time # 0.51 seconds
+    echo 1 > off_time # 0.13 seconds
+    echo 10 > fall_time # 3.1 seconds
+    echo 0 > min_breathing_level
+    echo 255 > max_breathing_level
+    echo 0 > loop_begin # begin from 'rise'
+    echo 0 > loop_end_on # loop end at 'off' state
+    echo 1 > mode # auto breathing mode
+    echo 5 > repeat # 5 times repeat
+    echo 1249 > select_leds # select 0, 3, 6, 9 12 leds (1001001001001)
+    echo 1 > start # run
+
+
+.. _manual_breath_mode:
+
+Manual control mode
+~~~~~~~~~~~~~~~~~~~
+
+When 'ramp' enabled (echo 1 > ramp)::
+
+    breathing level
+          ^
+      max _                ____________________
+          |               /                   .\
+          |              /                    . \
+          |             /                     .  \
+          |            /                      .   \
+          |           /                       .    \
+          |          /                        .     \
+      min _   ______/                         .      \_______
+          |         .                         .
+          |         .                         .
+          |         .                         .
+          |  (echo 1 > toggle)        (echo 0 > toggle)
+         -|---------------------------------------------------> time
+
+
+When 'ramp' disabled (echo 0 > ramp)::
+
+    breathing level
+          ^
+      max _          __________________________
+          |         |                          |
+          |         |                          |
+          |         |                          |
+          |         |                          |
+          |         |                          |
+          |         |                          |
+      min _   ______|                          |_______
+          |         .                          .
+          |         .                          .
+          |         .                          .
+          |   echo 1 > toggle          echo 0 > toggle
+         -|---------------------------------------------------> time
diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
index 499d0f215a8b..66e136f43870 100644
--- a/drivers/leds/Kconfig
+++ b/drivers/leds/Kconfig
@@ -94,6 +94,16 @@ config LEDS_ARIEL
 
 	  Say Y to if your machine is a Dell Wyse 3020 thin client.
 
+config LEDS_AW200XX
+	tristate "LED support for Awinic AW20036/AW20054/AW20072"
+	depends on LEDS_CLASS
+	depends on I2C
+	help
+	  This option enables support for the AW20036/AW20054/AW20072 LED driver.
+	  It is a 3x12/6x9/6x12 matrix LED driver programmed via
+	  an I2C interface, up to 36/54/72 LEDs or 12/18/24 RGBs,
+	  3 pattern controllers for auto breathing or group dimming control.
+
 config LEDS_AW2013
 	tristate "LED support for Awinic AW2013"
 	depends on LEDS_CLASS && I2C && OF
diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
index 4fd2f92cd198..f611e48cd3f5 100644
--- a/drivers/leds/Makefile
+++ b/drivers/leds/Makefile
@@ -15,6 +15,7 @@ obj-$(CONFIG_LEDS_AN30259A)		+= leds-an30259a.o
 obj-$(CONFIG_LEDS_APU)			+= leds-apu.o
 obj-$(CONFIG_LEDS_ARIEL)		+= leds-ariel.o
 obj-$(CONFIG_LEDS_ASIC3)		+= leds-asic3.o
+obj-$(CONFIG_LEDS_AW200XX)		+= leds-aw200xx.o
 obj-$(CONFIG_LEDS_AW2013)		+= leds-aw2013.o
 obj-$(CONFIG_LEDS_BCM6328)		+= leds-bcm6328.o
 obj-$(CONFIG_LEDS_BCM6358)		+= leds-bcm6358.o
diff --git a/drivers/leds/leds-aw200xx.c b/drivers/leds/leds-aw200xx.c
new file mode 100644
index 000000000000..273b6a44dee1
--- /dev/null
+++ b/drivers/leds/leds-aw200xx.c
@@ -0,0 +1,1113 @@
+// SPDX-License-Identifier: GPL-2.0
+/**
+ * leds-aw200xx.c - Awinic AW20036/AW20054/AW20072 LED driver
+ *
+ * Copyright (c) 2022, SberDevices. All Rights Reserved.
+ *
+ * Author: Martin Kurbanov <mmkurbanov@sberdevices.ru>
+ */
+
+#include <linux/i2c.h>
+#include <linux/leds.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/mutex.h>
+#include <linux/regmap.h>
+#include <linux/interrupt.h>
+#include <linux/bitfield.h>
+
+#define AW200XX_LEDS_MAX       72
+#define AW200XX_PATTERN_MAX    3
+#define AW200XX_DIM_MAX        0x3F
+#define AW200XX_FADE_MAX       0xFF
+#define AW200XX_IMAX_MAX       15
+#define AW200XX_IMAX_DEFAULT   4 /* 60mA */
+
+/* Page 0 */
+#define AW200XX_REG_PAGE0_BASE 0xc000
+
+/* Select page register */
+#define AW200XX_REG_PAGE       0xF0
+#define AW200XX_PAGE_MASK      (GENMASK(7, 6) | GENMASK(2, 0))
+#define AW200XX_PAGE_SHIFT     0
+#define AW200XX_NUM_PAGES      6
+#define AW200XX_PAGE_SIZE      256
+#define AW200XX_REG(page, reg) \
+	(AW200XX_REG_PAGE0_BASE + ((page) * AW200XX_PAGE_SIZE) + (reg))
+#define AW200XX_REG_MAX \
+	AW200XX_REG(AW200XX_NUM_PAGES - 1, AW200XX_PAGE_SIZE - 1)
+#define AW200XX_PAGE0 0
+#define AW200XX_PAGE1 1
+#define AW200XX_PAGE2 2
+#define AW200XX_PAGE3 3
+#define AW200XX_PAGE4 4
+#define AW200XX_PAGE5 5
+
+/* Chip ID register */
+#define AW200XX_REG_IDR       AW200XX_REG(AW200XX_PAGE0, 0x00)
+#define AW200XX_IDR_CHIPID    0x18
+
+/* Sleep mode register */
+#define AW200XX_REG_SLPCR     AW200XX_REG(AW200XX_PAGE0, 0x01)
+#define AW200XX_SLPCR_ACTIVE  0x00
+
+/* Reset register */
+#define AW200XX_REG_RSTR      AW200XX_REG(AW200XX_PAGE0, 0x02)
+#define AW200XX_RSTR_RESET    0x01
+
+/* Global current configuration register */
+#define AW200XX_REG_GCCR      AW200XX_REG(AW200XX_PAGE0, 0x03)
+#define AW200XX_GCCR_IMAX(x)  ((x) << 4)
+#define AW200XX_GCCR_ALLON    BIT(3)
+
+/* Fast clear display control register */
+#define AW200XX_REG_FCD       AW200XX_REG(AW200XX_PAGE0, 0x04)
+#define AW200XX_FCD_CLEAR     0x01
+
+/* Interrupt status register */
+#define AW200XX_REG_ISRFLT          AW200XX_REG(AW200XX_PAGE0, 0x0B)
+#define AW200XX_ISRFLT_PATIS_MASK   GENMASK(6, 4)
+
+/* Pattern enable control register */
+#define AW200XX_REG_PATCR           AW200XX_REG(AW200XX_PAGE0, 0x43)
+#define AW200XX_PATCR_PAT_IE_MASK   GENMASK(6, 4)
+#define AW200XX_PATCR_PAT_IE_ALL    AW200XX_PATCR_PAT_IE_MASK
+#define AW200XX_PATCR_PAT_ENABLE(x) BIT(x)
+
+/*
+ * Maximum breathing level registers
+ * For patterns 0 - 0x44, 1 - 0x45, 2 - 0x46 (step 1)
+ */
+#define AW200XX_REG_PAT0_MAX_BREATH AW200XX_REG(AW200XX_PAGE0, 0x44)
+
+/*
+ * Minimum breathing level registers
+ * For patterns 0 - 0x47, 1 - 0x48, 2 - 0x49 (step 1)
+ */
+#define AW200XX_REG_PAT0_MIN_BREATH AW200XX_REG(AW200XX_PAGE0, 0x47)
+
+/*
+ * Template 1 (rise-time) & template 2 (on-time) configuration register
+ * For patterns 0 - 0x4A, 1 - 0x4E, 2 - 0x52 (step 4)
+ */
+#define AW200XX_REG_PAT0_T0 AW200XX_REG(AW200XX_PAGE0, 0x4A)
+
+/*
+ * Template 3 (fall-time) & template 4 (off-time) configuration register
+ * For patterns 0 - 0x4B, 1 - 0x4F, 2 - 0x53 (step 4)
+ */
+#define AW200XX_REG_PAT0_T1 AW200XX_REG(AW200XX_PAGE0, 0x4B)
+
+/*
+ * Loop configuration registers:
+ *   loop end point setting (LE)
+ *   loop beginning point setting (LB)
+ *   MSB of loop times (LT)
+ * For patterns 0 - 0x4C, 1 - 0x50, 2 - 0x54 (step 4)
+ */
+#define AW200XX_REG_PAT0_T2     AW200XX_REG(AW200XX_PAGE0, 0x4C)
+#define AW200XX_REG_PATX_T2(x) (AW200XX_REG_PAT0_T2 + (x))
+
+/*
+ * Loop configuration registers:
+ *    LSB of loop times (LT)
+ * For patterns 0 - 0x4D, 1 - 0x51, 2 - 0x55 (step 4)
+ */
+#define AW200XX_REG_PAT0_T3    AW200XX_REG(AW200XX_PAGE0, 0x4D)
+#define AW200XX_REG_PATX_T3(x) (AW200XX_REG_PAT0_T3 + (x))
+
+#define AW200XX_PAT_T2_LE_MASK      GENMASK(7, 6)
+#define AW200XX_PAT_T2_LB_MASK      GENMASK(5, 4)
+#define AW200XX_PAT_T2_LT_MASK      GENMASK(3, 0)
+#define AW200XX_PAT_T3_LT_MASK      0xFF
+#define AW200XX_PAT0_T2_LT_MSB(x)   ((x) >> 8)
+#define AW200XX_PAT0_T3_LT_LSB(x)   ((x) & 0xFF)
+#define AW200XX_PAT0_T_LT(msb, lsb) ((msb) << 8 | (lsb))
+#define AW200XX_PAT0_T_LT_MAX       0xFFF
+
+#define AW200XX_PAT_T_STEP          4
+
+#define AW200XX_PAT_T1_T3_MASK      0xF0
+#define AW200XX_PAT_T2_T4_MASK      0x0F
+#define AW200XX_TEMPLATE_TIME_MAX   0x0F
+
+/*
+ * Pattern mode configuration register
+ * For patterns 0 - 0x56, 1 - 0x57, 2 - 0x58 (step 1)
+ */
+#define AW200XX_REG_PAT0_CFG        AW200XX_REG(AW200XX_PAGE0, 0x56)
+#define AW200XX_PAT_CFG_MODE_MASK   BIT(0)
+#define AW200XX_PAT_CFG_RAMP_MASK   BIT(1)
+#define AW200XX_PAT_CFG_SWITCH_MASK BIT(2)
+
+/* Start pattern register */
+#define AW200XX_REG_PATGO           AW200XX_REG(AW200XX_PAGE0, 0x59)
+#define AW200XX_PATGO(x)            BIT(x)
+#define AW200XX_PATGO_RUN(x, run)   ((run) << (x))
+#define AW200XX_PATGO_STATE(x)      BIT((x) + 4)
+
+/* Display size configuration */
+#define AW200XX_REG_DSIZE          AW200XX_REG(AW200XX_PAGE0, 0x80)
+#define AW200XX_DSIZE_COLUMNS_MAX  12
+
+#define AW200XX_LED2REG(x, columns) \
+	((x) + (((x) / (columns)) * (AW200XX_DSIZE_COLUMNS_MAX - (columns))))
+
+/* Patern selection register*/
+#define AW200XX_REG_PAT_SELECT(x, columns) \
+	AW200XX_REG(AW200XX_PAGE3, AW200XX_LED2REG(x, columns))
+#define AW200XX_PATX_SELECT(x) ((x) + 1)
+
+/*
+ * DIM current configuration register (page 4).
+ * The even address for current DIM configuration.
+ * The odd address for current FADE configuration
+ */
+#define AW200XX_REG_DIM(x, columns) \
+	AW200XX_REG(AW200XX_PAGE4, AW200XX_LED2REG(x, columns) * 2)
+#define AW200XX_REG_DIM2FADE(x) ((x) + 1)
+#define AW200XX_REG_FADE(x, columns) (AW200XX_REG_DIM(x, columns) + 1)
+
+struct aw200xx_led {
+	struct aw200xx *chip;
+	struct led_classdev cdev;
+	int dim;
+	u32 num;
+};
+
+struct aw200xx {
+	const struct aw200xx_chipdef *cdef;
+	struct i2c_client *client;
+	struct regmap *regmap;
+	struct mutex mutex;
+	DECLARE_BITMAP(pattern_leds[AW200XX_PATTERN_MAX], AW200XX_LEDS_MAX);
+	u32 num_leds;
+	u32 imax;
+	u32 display_size;
+	struct aw200xx_led leds[];
+};
+
+struct aw200xx_chipdef {
+	u32 channels;
+	u32 display_size_max;
+	u32 display_size_columns;
+};
+
+struct aw200xx_attribute {
+	struct device_attribute dev_attr;
+	u32 reg;
+	u32 mask;
+	u32 max;
+};
+
+#define to_aw200xx_attr(attr) \
+	container_of(attr, struct aw200xx_attribute, dev_attr)
+
+#define AW200XX_ATTR(_n, _m, _sh, _st, _r, _msk, _max) {		\
+	.dev_attr = __ATTR(_n, _m, _sh, _st),				\
+	.reg = _r,							\
+	.mask = _msk,							\
+	.max = _max,							\
+}
+
+#define AW200XX_DEVICE_ATTR_RW(_v, _n, _sh, _st, _r, _msk, _max)	\
+struct aw200xx_attribute _v##_attr =					\
+	AW200XX_ATTR(_n, 0644, _sh, _st,				\
+		     _r, _msk, _max)
+
+#define AW200XX_DEVICE_ATTR_RO(_v, _n, _sh, _r, _msk, _max)		\
+struct aw200xx_attribute _v##_attr =					\
+	AW200XX_ATTR(_n, 0444, _sh, NULL,				\
+		     _r, _msk, _max)
+
+static ssize_t aw200xx_store_internal(struct device *dev,
+				      struct device_attribute *devattr,
+				      const char *buf, size_t count)
+{
+	struct aw200xx_attribute *attr = to_aw200xx_attr(devattr);
+	struct aw200xx *chip = i2c_get_clientdata(to_i2c_client(dev));
+	u32 val;
+	int ret;
+
+	ret = kstrtouint(buf, 0, &val);
+	if (ret < 0 || val > attr->max)
+		return -EINVAL;
+
+	val <<= __ffs(attr->mask);
+
+	mutex_lock(&chip->mutex);
+	ret = regmap_update_bits(chip->regmap, attr->reg, attr->mask, val);
+	mutex_unlock(&chip->mutex);
+
+	if (ret)
+		return ret;
+
+	return count;
+}
+
+static ssize_t aw200xx_show_internal(struct device *dev,
+				     struct device_attribute *devattr,
+				     char *buf)
+{
+	struct aw200xx_attribute *attr = to_aw200xx_attr(devattr);
+	struct aw200xx *chip = i2c_get_clientdata(to_i2c_client(dev));
+	u32 val;
+	int ret;
+
+	mutex_lock(&chip->mutex);
+	ret = regmap_read(chip->regmap, attr->reg, &val);
+	mutex_unlock(&chip->mutex);
+
+	if (ret)
+		return ret;
+
+	val = (val & attr->mask) >> __ffs(attr->mask);
+
+	return sysfs_emit(buf, "%u\n", val);
+}
+
+static ssize_t aw200xx_template_time_show(struct device *dev,
+					  struct device_attribute *devattr,
+					  char *buf)
+{
+	static const u32 ttimes_ms[] = {
+		0, 130, 260, 380, 510, 770, 1040, 1600,
+		2100, 2600, 3100, 4200, 5200, 6200, 7300, 8300,
+	};
+	struct aw200xx_attribute *attr = to_aw200xx_attr(devattr);
+	struct aw200xx *chip = i2c_get_clientdata(to_i2c_client(dev));
+	u32 ttime;
+	int ret;
+
+	mutex_lock(&chip->mutex);
+	ret = regmap_read(chip->regmap, attr->reg, &ttime);
+	mutex_unlock(&chip->mutex);
+
+	if (ret)
+		return ret;
+
+	ttime = (ttime & attr->mask) >> __ffs(attr->mask);
+	if (ttime >= ARRAY_SIZE(ttimes_ms))
+		return -EIO;
+
+	ttime = ttimes_ms[ttime];
+
+	/* For On & Off time minimum is 40ms */
+	if (ttime == 0 && attr->mask == AW200XX_PAT_T2_T4_MASK)
+		ttime = 40;
+
+	return sysfs_emit(buf, "%ums\n", ttime);
+}
+
+static ssize_t aw200xx_pattern_leds_store(struct device *dev,
+					  struct device_attribute *devattr,
+					  const char *buf, size_t count,
+					  bool clear)
+{
+	struct aw200xx_attribute *attr = to_aw200xx_attr(devattr);
+	struct aw200xx *chip = i2c_get_clientdata(to_i2c_client(dev));
+	unsigned long *pattern_leds = chip->pattern_leds[attr->reg];
+	u32 columns = chip->cdef->display_size_columns;
+	DECLARE_BITMAP(leds, AW200XX_LEDS_MAX);
+	u32 val = clear ? 0 : AW200XX_PATX_SELECT(attr->reg);
+	u32 i;
+	int ret;
+
+	ret = bitmap_parse(buf, count, leds, chip->num_leds);
+	if (ret)
+		return -EINVAL;
+
+	mutex_lock(&chip->mutex);
+
+	for_each_set_bit(i, leds, chip->num_leds) {
+		u32 num = chip->leds[i].num;
+
+		ret = regmap_write(chip->regmap,
+				   AW200XX_REG_PAT_SELECT(num, columns), val);
+		if (ret)
+			goto exit;
+
+		if (clear)
+			__clear_bit(i, pattern_leds);
+		else
+			__set_bit(i, pattern_leds);
+	}
+
+	ret = (int)count;
+
+exit:
+	mutex_unlock(&chip->mutex);
+	return ret;
+}
+
+static ssize_t aw200xx_pattern_select_leds_show(struct device *dev,
+						struct device_attribute *devattr,
+						char *buf)
+{
+	struct aw200xx_attribute *attr = to_aw200xx_attr(devattr);
+	struct aw200xx *chip = i2c_get_clientdata(to_i2c_client(dev));
+	int ret;
+
+	mutex_lock(&chip->mutex);
+	ret = sysfs_emit(buf, "%*pb\n",
+			 chip->num_leds, chip->pattern_leds[attr->reg]);
+	mutex_unlock(&chip->mutex);
+
+	return ret;
+}
+
+static ssize_t aw200xx_pattern_select_leds_store(struct device *dev,
+						 struct device_attribute *devattr,
+						 const char *buf, size_t count)
+{
+	return aw200xx_pattern_leds_store(dev, devattr, buf, count, false);
+}
+
+static ssize_t aw200xx_pattern_clear_leds_show(struct device *dev,
+					       struct device_attribute *devattr,
+					       char *buf)
+{
+	struct aw200xx_attribute *attr = to_aw200xx_attr(devattr);
+	struct aw200xx *chip = i2c_get_clientdata(to_i2c_client(dev));
+	DECLARE_BITMAP(leds, AW200XX_LEDS_MAX);
+	int ret;
+
+	mutex_lock(&chip->mutex);
+	bitmap_fill(leds, chip->num_leds);
+	bitmap_xor(leds, leds, chip->pattern_leds[attr->reg], chip->num_leds);
+	ret = sysfs_emit(buf, "%*pb\n", chip->num_leds, leds);
+	mutex_unlock(&chip->mutex);
+
+	return ret;
+}
+
+static ssize_t aw200xx_pattern_clear_leds_store(struct device *dev,
+						struct device_attribute *devattr,
+						const char *buf, size_t count)
+{
+	return aw200xx_pattern_leds_store(dev, devattr, buf, count, true);
+}
+
+static ssize_t aw200xx_pattern_start_show(struct device *dev,
+					  struct device_attribute *devattr,
+					  char *buf)
+{
+	struct aw200xx_attribute *attr = to_aw200xx_attr(devattr);
+	struct aw200xx *chip = i2c_get_clientdata(to_i2c_client(dev));
+	u32 start = 0;
+	u32 val;
+	int ret;
+
+	mutex_lock(&chip->mutex);
+
+	ret = regmap_read(chip->regmap, AW200XX_REG_PATCR, &val);
+	if (ret)
+		goto exit;
+
+	if (val & AW200XX_PATCR_PAT_ENABLE(attr->reg)) {
+		ret = regmap_read(chip->regmap, AW200XX_REG_PATGO, &val);
+		if (ret)
+			goto exit;
+
+		start = !!(val & AW200XX_PATGO(attr->reg));
+	}
+
+	ret = sysfs_emit(buf, "%u\n", start);
+
+exit:
+	mutex_unlock(&chip->mutex);
+	return ret;
+}
+
+static ssize_t aw200xx_pattern_start_store(struct device *dev,
+					   struct device_attribute *devattr,
+					   const char *buf, size_t count)
+{
+	struct aw200xx_attribute *attr = to_aw200xx_attr(devattr);
+	struct aw200xx *chip = i2c_get_clientdata(to_i2c_client(dev));
+	u32 start;
+	int ret;
+
+	ret = kstrtouint(buf, 0, &start);
+	if (ret < 0 || start > attr->max)
+		return -EINVAL;
+
+	start = AW200XX_PATGO_RUN(attr->reg, start);
+
+	mutex_lock(&chip->mutex);
+
+	ret = regmap_update_bits(chip->regmap, AW200XX_REG_PATCR,
+				 AW200XX_PATCR_PAT_ENABLE(attr->reg), start);
+	if (ret)
+		goto exit;
+
+	ret = regmap_update_bits(chip->regmap, AW200XX_REG_PATGO,
+				 AW200XX_PATGO(attr->reg), start);
+	if (!ret)
+		ret = (int)count;
+
+exit:
+	mutex_unlock(&chip->mutex);
+	return ret;
+}
+
+static ssize_t aw200xx_pattern_running_show(struct device *dev,
+					    struct device_attribute *devattr,
+					    char *buf)
+{
+	struct aw200xx_attribute *attr = to_aw200xx_attr(devattr);
+	struct aw200xx *chip = i2c_get_clientdata(to_i2c_client(dev));
+	u32 running;
+	int ret;
+
+	mutex_lock(&chip->mutex);
+
+	ret = regmap_read(chip->regmap, AW200XX_REG_PATGO, &running);
+	if (ret)
+		goto exit;
+
+	running &= AW200XX_PATGO_STATE(attr->reg);
+	ret = sysfs_emit(buf, "%u\n", !!running);
+
+exit:
+	mutex_unlock(&chip->mutex);
+	return ret;
+}
+
+static ssize_t aw200xx_pattern_repeat_show(struct device *dev,
+					   struct device_attribute *devattr,
+					   char *buf)
+{
+	struct aw200xx_attribute *attr = to_aw200xx_attr(devattr);
+	struct aw200xx *chip = i2c_get_clientdata(to_i2c_client(dev));
+	u32 repeat_msb;
+	u32 repeat_lsb;
+	int ret;
+
+	mutex_lock(&chip->mutex);
+
+	ret = regmap_read(chip->regmap,
+			  AW200XX_REG_PATX_T2(attr->reg), &repeat_msb);
+	if (ret)
+		goto exit;
+
+	ret = regmap_read(chip->regmap,
+			  AW200XX_REG_PATX_T3(attr->reg), &repeat_lsb);
+	if (ret)
+		goto exit;
+
+	repeat_msb &= AW200XX_PAT_T2_LT_MASK;
+	repeat_lsb &= AW200XX_PAT_T3_LT_MASK;
+
+	ret = sysfs_emit(buf, "%u\n",
+			 AW200XX_PAT0_T_LT(repeat_msb, repeat_lsb));
+
+exit:
+	mutex_unlock(&chip->mutex);
+	return ret;
+}
+
+static ssize_t aw200xx_pattern_repeat_store(struct device *dev,
+					    struct device_attribute *devattr,
+					    const char *buf, size_t count)
+{
+	struct aw200xx_attribute *attr = to_aw200xx_attr(devattr);
+	struct aw200xx *chip = i2c_get_clientdata(to_i2c_client(dev));
+	u32 repeat;
+	ssize_t ret;
+
+	ret = kstrtouint(buf, 0, &repeat);
+	if (ret < 0 || repeat > attr->max)
+		return -EINVAL;
+
+	mutex_lock(&chip->mutex);
+
+	ret = regmap_update_bits(chip->regmap,
+				 AW200XX_REG_PATX_T2(attr->reg),
+				 AW200XX_PAT_T2_LT_MASK,
+				 AW200XX_PAT0_T2_LT_MSB(repeat));
+	if (ret)
+		goto exit;
+
+	ret = regmap_update_bits(chip->regmap,
+				 AW200XX_REG_PATX_T3(attr->reg),
+				 AW200XX_PAT_T3_LT_MASK,
+				 AW200XX_PAT0_T3_LT_LSB(repeat));
+	if (!ret)
+		ret = count;
+
+exit:
+	mutex_unlock(&chip->mutex);
+	return ret;
+}
+
+#define AW200XX_DEVICE_ATTR_PAT_RW(_n, _sh, _st, _r, _step, _msk, _max)	\
+static AW200XX_DEVICE_ATTR_RW(_n##0, _n, _sh, _st,			\
+			      _r, _msk, _max);				\
+static AW200XX_DEVICE_ATTR_RW(_n##1, _n, _sh, _st,			\
+			      _r + (1 * (_step)), _msk, _max);		\
+static AW200XX_DEVICE_ATTR_RW(_n##2, _n, _sh, _st,			\
+			      _r + (2 * (_step)), _msk, _max)
+
+#define AW200XX_DEVICE_ATTR_PAT_RO(_n, _sh, _r, _step, _msk, _max)	\
+static AW200XX_DEVICE_ATTR_RO(_n##0, _n, _sh,				\
+			      _r, _msk, _max);				\
+static AW200XX_DEVICE_ATTR_RO(_n##1, _n, _sh,				\
+			      _r + (1 * (_step)), _msk, _max);		\
+static AW200XX_DEVICE_ATTR_RO(_n##2, _n, _sh,				\
+			      _r + (2 * (_step)), _msk, _max)
+
+#define AW200XX_DEFINE_ATTR_GROUP(_idx, _a0, _a1, _a2, _a3, _a4, _a5,	\
+		_a6, _a7, _a8, _a9, _a10, _a11, _a12, _a13, _a14, _a15)	\
+static struct attribute *aw200xx_pattern##_idx##_attributes[] = {	\
+	&_a0##_idx##_attr.dev_attr.attr,				\
+	&_a1##_idx##_attr.dev_attr.attr,				\
+	&_a2##_idx##_attr.dev_attr.attr,				\
+	&_a3##_idx##_attr.dev_attr.attr,				\
+	&_a4##_idx##_attr.dev_attr.attr,				\
+	&_a5##_idx##_attr.dev_attr.attr,				\
+	&_a6##_idx##_attr.dev_attr.attr,				\
+	&_a7##_idx##_attr.dev_attr.attr,				\
+	&_a8##_idx##_attr.dev_attr.attr,				\
+	&_a9##_idx##_attr.dev_attr.attr,				\
+	&_a10##_idx##_attr.dev_attr.attr,				\
+	&_a11##_idx##_attr.dev_attr.attr,				\
+	&_a12##_idx##_attr.dev_attr.attr,				\
+	&_a13##_idx##_attr.dev_attr.attr,				\
+	&_a14##_idx##_attr.dev_attr.attr,				\
+	&_a15##_idx##_attr.dev_attr.attr,				\
+	NULL};								\
+static const struct attribute_group aw200xx_pattern##_idx##_group = {	\
+	.attrs = aw200xx_pattern##_idx##_attributes,			\
+	.name = "pattern"#_idx,						\
+}
+
+#define AW200XX_DEFINE_ATTR_GROUPS(...)					\
+AW200XX_DEFINE_ATTR_GROUP(0, __VA_ARGS__);				\
+AW200XX_DEFINE_ATTR_GROUP(1, __VA_ARGS__);				\
+AW200XX_DEFINE_ATTR_GROUP(2, __VA_ARGS__);				\
+static const struct attribute_group *aw200xx_pattern_groups[] = {	\
+	&aw200xx_pattern0_group,					\
+	&aw200xx_pattern1_group,					\
+	&aw200xx_pattern2_group,					\
+	NULL}
+
+AW200XX_DEVICE_ATTR_PAT_RW(rise_time,
+			   aw200xx_template_time_show, aw200xx_store_internal,
+			   AW200XX_REG_PAT0_T0, AW200XX_PAT_T_STEP,
+			   AW200XX_PAT_T1_T3_MASK, AW200XX_TEMPLATE_TIME_MAX);
+
+AW200XX_DEVICE_ATTR_PAT_RW(on_time,
+			   aw200xx_template_time_show, aw200xx_store_internal,
+			   AW200XX_REG_PAT0_T0, AW200XX_PAT_T_STEP,
+			   AW200XX_PAT_T2_T4_MASK, AW200XX_TEMPLATE_TIME_MAX);
+
+AW200XX_DEVICE_ATTR_PAT_RW(fall_time,
+			   aw200xx_template_time_show, aw200xx_store_internal,
+			   AW200XX_REG_PAT0_T1, AW200XX_PAT_T_STEP,
+			   AW200XX_PAT_T1_T3_MASK, AW200XX_TEMPLATE_TIME_MAX);
+
+AW200XX_DEVICE_ATTR_PAT_RW(off_time,
+			   aw200xx_template_time_show, aw200xx_store_internal,
+			   AW200XX_REG_PAT0_T1, AW200XX_PAT_T_STEP,
+			   AW200XX_PAT_T2_T4_MASK, AW200XX_TEMPLATE_TIME_MAX);
+
+AW200XX_DEVICE_ATTR_PAT_RW(mode,
+			   aw200xx_show_internal, aw200xx_store_internal,
+			   AW200XX_REG_PAT0_CFG, 1,
+			   AW200XX_PAT_CFG_MODE_MASK, 1);
+
+AW200XX_DEVICE_ATTR_PAT_RW(ramp,
+			   aw200xx_show_internal, aw200xx_store_internal,
+			   AW200XX_REG_PAT0_CFG, 1,
+			   AW200XX_PAT_CFG_RAMP_MASK, 1);
+
+AW200XX_DEVICE_ATTR_PAT_RW(toggle,
+			   aw200xx_show_internal, aw200xx_store_internal,
+			   AW200XX_REG_PAT0_CFG, 1,
+			   AW200XX_PAT_CFG_SWITCH_MASK, 1);
+
+AW200XX_DEVICE_ATTR_PAT_RW(loop_end_on,
+			   aw200xx_show_internal, aw200xx_store_internal,
+			   AW200XX_REG_PAT0_T2, AW200XX_PAT_T_STEP,
+			   AW200XX_PAT_T2_LE_MASK, 1);
+
+AW200XX_DEVICE_ATTR_PAT_RW(loop_begin,
+			   aw200xx_show_internal, aw200xx_store_internal,
+			   AW200XX_REG_PAT0_T2, AW200XX_PAT_T_STEP,
+			   AW200XX_PAT_T2_LB_MASK, 3);
+
+AW200XX_DEVICE_ATTR_PAT_RW(max_breathing_level,
+			   aw200xx_show_internal, aw200xx_store_internal,
+			   AW200XX_REG_PAT0_MAX_BREATH, 1,
+			   0xFF, AW200XX_FADE_MAX);
+
+AW200XX_DEVICE_ATTR_PAT_RW(min_breathing_level,
+			   aw200xx_show_internal, aw200xx_store_internal,
+			   AW200XX_REG_PAT0_MIN_BREATH, 1,
+			   0xFF, AW200XX_FADE_MAX);
+
+AW200XX_DEVICE_ATTR_PAT_RW(start,
+			   aw200xx_pattern_start_show,
+			   aw200xx_pattern_start_store,
+			   0, 1, 1, 1);
+
+AW200XX_DEVICE_ATTR_PAT_RO(running,
+			   aw200xx_pattern_running_show, 0, 1, 0, 0);
+
+AW200XX_DEVICE_ATTR_PAT_RW(repeat,
+			   aw200xx_pattern_repeat_show,
+			   aw200xx_pattern_repeat_store,
+			   0, AW200XX_PAT_T_STEP,
+			   0, AW200XX_PAT0_T_LT_MAX);
+
+AW200XX_DEVICE_ATTR_PAT_RW(select_leds,
+			   aw200xx_pattern_select_leds_show,
+			   aw200xx_pattern_select_leds_store,
+			   0, 1, 0, 0);
+
+AW200XX_DEVICE_ATTR_PAT_RW(clear_leds,
+			   aw200xx_pattern_clear_leds_show,
+			   aw200xx_pattern_clear_leds_store,
+			   0, 1, 0, 0);
+
+AW200XX_DEFINE_ATTR_GROUPS(start, running, mode, ramp, toggle, repeat,
+			   loop_end_on, loop_begin, select_leds, clear_leds,
+			   max_breathing_level, min_breathing_level,
+			   rise_time, on_time, fall_time, off_time);
+
+static ssize_t aw200xx_dim_show(struct device *dev,
+				struct device_attribute *devattr,
+				char *buf)
+{
+	struct led_classdev *cdev = dev_get_drvdata(dev);
+	struct aw200xx_led *led = container_of(cdev, struct aw200xx_led, cdev);
+	int dim = led->dim;
+	ssize_t ret;
+
+	if (dim < 0)
+		ret = sysfs_emit(buf, "auto\n");
+	else
+		ret = sysfs_emit(buf, "%d\n", dim);
+
+	return ret;
+}
+
+static ssize_t aw200xx_dim_store(struct device *dev,
+				 struct device_attribute *devattr,
+				 const char *buf, size_t count)
+{
+	struct led_classdev *cdev = dev_get_drvdata(dev);
+	struct aw200xx_led *led = container_of(cdev, struct aw200xx_led, cdev);
+	struct aw200xx *chip = led->chip;
+	u32 columns = chip->cdef->display_size_columns;
+	int dim;
+	ssize_t ret;
+
+	if (sysfs_streq(buf, "auto")) {
+		dim = -1;
+	} else {
+		ret = kstrtoint(buf, 0, &dim);
+		if (ret < 0 || dim > AW200XX_DIM_MAX)
+			return -EINVAL;
+	}
+
+	mutex_lock(&chip->mutex);
+
+	if (dim >= 0) {
+		ret = regmap_write(chip->regmap,
+				   AW200XX_REG_DIM(led->num, columns), dim);
+		if (ret)
+			goto exit;
+	}
+
+	led->dim = dim;
+	ret = count;
+
+exit:
+	mutex_unlock(&chip->mutex);
+	return ret;
+}
+static DEVICE_ATTR(dim, 0644, aw200xx_dim_show, aw200xx_dim_store);
+
+static struct attribute *dim_attrs[] = {
+	&dev_attr_dim.attr,
+	NULL
+};
+ATTRIBUTE_GROUPS(dim);
+
+static int aw200xx_brightness_set(struct led_classdev *cdev,
+				  enum led_brightness brightness)
+{
+	struct aw200xx_led *led = container_of(cdev, struct aw200xx_led, cdev);
+	struct aw200xx *chip = led->chip;
+	int dim;
+	u32 reg;
+	int ret;
+
+	mutex_lock(&chip->mutex);
+
+	reg = AW200XX_REG_DIM(led->num, chip->cdef->display_size_columns);
+	dim = led->dim;
+
+	if (dim < 0) {
+		dim = brightness / (AW200XX_FADE_MAX / AW200XX_DIM_MAX);
+		dim = max(dim, 1);
+	}
+
+	ret = regmap_write(chip->regmap, reg, dim);
+	if (ret)
+		goto error;
+
+	ret = regmap_write(chip->regmap,
+			   AW200XX_REG_DIM2FADE(reg), brightness);
+
+error:
+	mutex_unlock(&chip->mutex);
+
+	return ret;
+}
+
+static irqreturn_t aw200xx_irq_thread(int irq, void *dev_id)
+{
+	struct aw200xx *chip = dev_id;
+	unsigned long pattern_state;
+	u32 interrupt_state;
+	int i;
+	int ret;
+
+	mutex_lock(&chip->mutex);
+	ret = regmap_read(chip->regmap, AW200XX_REG_ISRFLT, &interrupt_state);
+	mutex_unlock(&chip->mutex);
+
+	if (ret) {
+		dev_err(&chip->client->dev,
+			"Failed to get interrupt status: %d\n", ret);
+		return IRQ_HANDLED;
+	}
+
+	pattern_state = FIELD_GET(AW200XX_ISRFLT_PATIS_MASK, interrupt_state);
+
+	for_each_set_bit(i, &pattern_state, AW200XX_PATTERN_MAX) {
+		char dir[sizeof("patternxx")];
+
+		snprintf(dir, sizeof(dir), "pattern%d", i);
+		sysfs_notify(&chip->client->dev.kobj, dir, "running");
+	}
+
+	return IRQ_HANDLED;
+}
+
+static int aw200xx_setup_interrupts(struct aw200xx *chip)
+{
+	struct i2c_client *i2c = chip->client;
+	int ret;
+
+	if (i2c->irq <= 0)
+		return 0;
+
+	ret = devm_request_threaded_irq(&i2c->dev, i2c->irq,
+					NULL,
+					aw200xx_irq_thread,
+					IRQF_ONESHOT,
+					i2c->name,
+					chip);
+	if (ret)
+		return dev_err_probe(&i2c->dev, ret, "Failed to request irq\n");
+
+	ret = regmap_update_bits(chip->regmap, AW200XX_REG_PATCR,
+				 AW200XX_PATCR_PAT_IE_MASK,
+				 AW200XX_PATCR_PAT_IE_ALL);
+	if (ret)
+		dev_err_probe(&i2c->dev, ret, "Failed to enable interrupts\n");
+
+	return ret;
+}
+
+static int aw200xx_chip_reset(const struct aw200xx *const chip)
+{
+	int ret;
+
+	ret = regmap_write(chip->regmap, AW200XX_REG_RSTR, AW200XX_RSTR_RESET);
+	if (ret)
+		return ret;
+
+	regcache_mark_dirty(chip->regmap);
+	ret = regmap_write(chip->regmap, AW200XX_REG_FCD, AW200XX_FCD_CLEAR);
+
+	return ret;
+}
+
+static int aw200xx_chip_init(const struct aw200xx *const chip)
+{
+	int ret;
+
+	ret = regmap_write(chip->regmap, AW200XX_REG_DSIZE, chip->display_size);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(chip->regmap, AW200XX_REG_SLPCR,
+			   AW200XX_SLPCR_ACTIVE);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(chip->regmap, AW200XX_REG_GCCR,
+			   AW200XX_GCCR_IMAX(chip->imax) | AW200XX_GCCR_ALLON);
+
+	return ret;
+}
+
+static int aw200xx_chip_check(const struct aw200xx *const chip)
+{
+	struct device *dev = &chip->client->dev;
+	u32 chipid;
+	int ret;
+
+	ret = regmap_read(chip->regmap, AW200XX_REG_IDR, &chipid);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to read chip ID\n");
+
+	if (chipid != AW200XX_IDR_CHIPID)
+		return dev_err_probe(dev, -ENODEV,
+				     "Chip reported wrong ID: %x\n", chipid);
+
+	return 0;
+}
+
+static int aw200xx_probe_dt(struct device *dev, struct aw200xx *chip)
+{
+	struct fwnode_handle *child;
+	u32 imax;
+	int ret;
+	int i = 0;
+
+	ret = device_property_read_u32(dev, "display-size", &chip->display_size);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Failed to read 'display-size' property\n");
+
+	if (chip->display_size > chip->cdef->display_size_max)
+		return dev_err_probe(dev, ret,
+				     "Invalid leds display size %u\n",
+				     chip->display_size);
+
+	ret = device_property_read_u32(dev, "imax", &imax);
+	if (!ret && imax <= AW200XX_IMAX_MAX) {
+		chip->imax = imax;
+	} else {
+		chip->imax = AW200XX_IMAX_DEFAULT;
+		dev_info(dev, "DT property imax is missing\n");
+	}
+
+	device_for_each_child_node(dev, child) {
+		struct led_init_data init_data = {};
+		struct aw200xx_led *led;
+		u32 source;
+
+		ret = fwnode_property_read_u32(child, "reg", &source);
+		if (ret) {
+			dev_err(dev, "Missing reg property\n");
+			chip->num_leds--;
+			continue;
+		}
+
+		if (source >= chip->cdef->channels) {
+			dev_err(dev, "LED reg %u out of range (max %u)\n",
+				source, chip->cdef->channels);
+			chip->num_leds--;
+			continue;
+		}
+
+		led = &chip->leds[i];
+		led->dim = -1;
+		led->num = source;
+		led->chip = chip;
+		led->cdev.brightness_set_blocking = aw200xx_brightness_set;
+		led->cdev.groups = dim_groups;
+		init_data.fwnode = child;
+
+		ret = devm_led_classdev_register_ext(dev, &led->cdev,
+						     &init_data);
+		if (ret) {
+			fwnode_handle_put(child);
+			break;
+		}
+
+		i++;
+	}
+
+	if (!chip->num_leds)
+		ret = -EINVAL;
+
+	return ret;
+}
+
+static const struct regmap_range_cfg aw200xx_ranges[] = {
+	{
+		.name = "aw200xx",
+		.range_min = 0,
+		.range_max = AW200XX_REG_MAX,
+		.selector_reg = AW200XX_REG_PAGE,
+		.selector_mask = AW200XX_PAGE_MASK,
+		.selector_shift = AW200XX_PAGE_SHIFT,
+		.window_start = 0,
+		.window_len = AW200XX_PAGE_SIZE,
+	},
+};
+
+static const struct regmap_range aw200xx_writeonly_ranges[] = {
+	regmap_reg_range(AW200XX_REG(AW200XX_PAGE1, 0x00), AW200XX_REG_MAX),
+};
+
+static const struct regmap_access_table aw200xx_readable_table = {
+	.no_ranges = aw200xx_writeonly_ranges,
+	.n_no_ranges = ARRAY_SIZE(aw200xx_writeonly_ranges),
+};
+
+static const struct regmap_range aw200xx_readonly_ranges[] = {
+	regmap_reg_range(AW200XX_REG_IDR, AW200XX_REG_IDR),
+	regmap_reg_range(AW200XX_REG_ISRFLT, AW200XX_REG_ISRFLT),
+};
+
+static const struct regmap_access_table aw200xx_writeable_table = {
+	.no_ranges = aw200xx_readonly_ranges,
+	.n_no_ranges = ARRAY_SIZE(aw200xx_readonly_ranges),
+};
+
+static const struct regmap_range aw200xx_volatile_registers[] = {
+	regmap_reg_range(AW200XX_REG_ISRFLT, AW200XX_REG_ISRFLT),
+};
+
+static const struct regmap_access_table aw200xx_volatile_table = {
+	.yes_ranges = aw200xx_volatile_registers,
+	.n_yes_ranges = ARRAY_SIZE(aw200xx_volatile_registers),
+};
+
+static const struct regmap_config aw200xx_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = AW200XX_REG_MAX,
+	.ranges = aw200xx_ranges,
+	.num_ranges = ARRAY_SIZE(aw200xx_ranges),
+	.rd_table = &aw200xx_readable_table,
+	.wr_table = &aw200xx_writeable_table,
+	.volatile_table = &aw200xx_volatile_table,
+	.cache_type = REGCACHE_RBTREE,
+};
+
+static int aw200xx_probe(struct i2c_client *client)
+{
+	const struct aw200xx_chipdef *cdef;
+	struct aw200xx *chip;
+	int count;
+	int ret;
+
+	cdef = device_get_match_data(&client->dev);
+
+	count = device_get_child_node_count(&client->dev);
+	if (!count || count > cdef->channels)
+		return dev_err_probe(&client->dev, -EINVAL,
+				     "Incorrect number of leds (%d)", count);
+
+	chip = devm_kzalloc(&client->dev,
+			    struct_size(chip, leds, count),
+			    GFP_KERNEL);
+	if (!chip)
+		return -ENOMEM;
+
+	chip->cdef = cdef;
+	chip->num_leds = count;
+	chip->client = client;
+	i2c_set_clientdata(client, chip);
+
+	chip->regmap = devm_regmap_init_i2c(client, &aw200xx_regmap_config);
+	if (IS_ERR(chip->regmap))
+		return PTR_ERR(chip->regmap);
+
+	ret = aw200xx_chip_check(chip);
+	if (ret)
+		return ret;
+
+	mutex_init(&chip->mutex);
+
+	/* Need a lock now since after call aw200xx_probe_dt, created sysfs nodes */
+	mutex_lock(&chip->mutex);
+
+	ret = aw200xx_probe_dt(&client->dev, chip);
+	if (ret < 0)
+		goto exit;
+
+	ret = aw200xx_chip_reset(chip);
+	if (ret)
+		goto exit;
+
+	ret = aw200xx_chip_init(chip);
+	if (ret)
+		goto exit;
+
+	ret = aw200xx_setup_interrupts(chip);
+
+exit:
+	mutex_unlock(&chip->mutex);
+	return ret;
+}
+
+static void aw200xx_remove(struct i2c_client *client)
+{
+	struct aw200xx *chip = i2c_get_clientdata(client);
+
+	aw200xx_chip_reset(chip);
+	mutex_destroy(&chip->mutex);
+}
+
+static const struct aw200xx_chipdef aw20036_cdef = {
+	.channels = 36,
+	.display_size_max = 2,
+	.display_size_columns = 12,
+};
+
+static const struct aw200xx_chipdef aw20054_cdef = {
+	.channels = 54,
+	.display_size_max = 5,
+	.display_size_columns = 9,
+};
+
+static const struct aw200xx_chipdef aw20072_cdef = {
+	.channels = 72,
+	.display_size_max = 5,
+	.display_size_columns = 12,
+};
+
+static const struct i2c_device_id aw200xx_id[] = {
+	{ "aw20036" },
+	{ "aw20054" },
+	{ "aw20072" },
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, aw200xx_id);
+
+static const struct of_device_id aw200xx_match_table[] = {
+	{ .compatible = "awinic,aw20036", .data = &aw20036_cdef, },
+	{ .compatible = "awinic,aw20054", .data = &aw20054_cdef, },
+	{ .compatible = "awinic,aw20072", .data = &aw20072_cdef, },
+	{},
+};
+MODULE_DEVICE_TABLE(of, aw200xx_match_table);
+
+static struct i2c_driver aw200xx_driver = {
+	.driver = {
+		.name = "aw200xx",
+		.of_match_table = of_match_ptr(aw200xx_match_table),
+		.dev_groups = aw200xx_pattern_groups,
+	},
+	.probe_new = aw200xx_probe,
+	.remove = aw200xx_remove,
+	.id_table = aw200xx_id,
+};
+
+module_i2c_driver(aw200xx_driver);
+
+MODULE_AUTHOR("Martin Kurbanov <mmkurbanov@sberdevices.ru>");
+MODULE_DESCRIPTION("AW200XX LED driver");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:leds-aw200xx");
-- 
2.38.1

