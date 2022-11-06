Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A87CF61E1A0
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 11:32:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbiKFKcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 05:32:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbiKFKcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 05:32:02 -0500
Received: from smtp.smtpout.orange.fr (smtp-29.smtpout.orange.fr [80.12.242.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5E1065AA
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 02:31:57 -0800 (PST)
Received: from pop-os.home ([86.243.100.34])
        by smtp.orange.fr with ESMTPA
        id rcwOoBLdlJvOZrcwOoFab5; Sun, 06 Nov 2022 11:31:56 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 06 Nov 2022 11:31:56 +0100
X-ME-IP: 86.243.100.34
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Hans de Goede <hdegoede@redhat.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Corentin Labbe <clabbe.montjoie@gmail.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        George Joseph <george.joseph@fairview5.com>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Juerg Haefliger <juergh@proton.me>,
        Steve Glendinning <steve.glendinning@shawell.net>,
        Riku Voipio <riku.voipio@iki.fi>,
        Huang Rui <ray.huang@amd.com>,
        Tim Harvey <tharvey@gateworks.com>,
        Guillaume Ligneul <guillaume.ligneul@gmail.com>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        Jim Cromie <jim.cromie@gmail.com>,
        Roger Lucas <vt8231@hiddenengine.co.uk>,
        Marc Hulsman <m.hulsman@tudelft.nl>,
        Rudolf Marek <r.marek@assembler.cz>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-hwmon@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org
Subject: [PATCH] hwmon: Include <linux/kstrtox.h> when appropriate
Date:   Sun,  6 Nov 2022 11:31:27 +0100
Message-Id: <0e819645f8d607f7b4550c8aaf4a563b1404bf40.1667730675.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kstrto<something>() functions have been moved from kernel.h to
kstrtox.h.

So, include the latter directly in the appropriate files.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
The goal of this patch is to eventually remove <linux/kernel.h> from
<linux/watchdog.h>.

This patch is needed to avoid indirect inclusion, via <linux/watchdog.h>,
in fschmd.c, ftsteutates.c and w83793.c.


Maybe, just including <linux/kstrtox.h> in <linux/hwmon.h> would also do
the job. It is likely that this file is included in all hwmon's drivers.
Let me know if this less intrusive approach is preferred.

I've done my best to keep alphabetical order of the included files, but
that is not always easy to achieve!
---
 drivers/hwmon/abituguru.c        | 1 +
 drivers/hwmon/acpi_power_meter.c | 1 +
 drivers/hwmon/ad7414.c           | 1 +
 drivers/hwmon/ad7418.c           | 1 +
 drivers/hwmon/adc128d818.c       | 1 +
 drivers/hwmon/adcxx.c            | 1 +
 drivers/hwmon/adm1025.c          | 1 +
 drivers/hwmon/adm1026.c          | 1 +
 drivers/hwmon/adm1029.c          | 1 +
 drivers/hwmon/adm1031.c          | 1 +
 drivers/hwmon/adm9240.c          | 1 +
 drivers/hwmon/adt7411.c          | 1 +
 drivers/hwmon/adt7462.c          | 1 +
 drivers/hwmon/adt7470.c          | 1 +
 drivers/hwmon/adt7475.c          | 1 +
 drivers/hwmon/amc6821.c          | 1 +
 drivers/hwmon/applesmc.c         | 1 +
 drivers/hwmon/asb100.c           | 1 +
 drivers/hwmon/asc7621.c          | 1 +
 drivers/hwmon/aspeed-pwm-tacho.c | 1 +
 drivers/hwmon/atxp1.c            | 1 +
 drivers/hwmon/axi-fan-control.c  | 1 +
 drivers/hwmon/dme1737.c          | 1 +
 drivers/hwmon/ds1621.c           | 1 +
 drivers/hwmon/ds620.c            | 1 +
 drivers/hwmon/emc1403.c          | 1 +
 drivers/hwmon/emc2103.c          | 1 +
 drivers/hwmon/emc6w201.c         | 1 +
 drivers/hwmon/f71805f.c          | 1 +
 drivers/hwmon/f71882fg.c         | 1 +
 drivers/hwmon/f75375s.c          | 1 +
 drivers/hwmon/fam15h_power.c     | 1 +
 drivers/hwmon/fschmd.c           | 1 +
 drivers/hwmon/ftsteutates.c      | 1 +
 drivers/hwmon/g760a.c            | 1 +
 drivers/hwmon/g762.c             | 1 +
 drivers/hwmon/gl518sm.c          | 1 +
 drivers/hwmon/gl520sm.c          | 1 +
 drivers/hwmon/gpio-fan.c         | 1 +
 drivers/hwmon/gsc-hwmon.c        | 1 +
 drivers/hwmon/hwmon.c            | 1 +
 drivers/hwmon/i5k_amb.c          | 1 +
 drivers/hwmon/ibmaem.c           | 1 +
 drivers/hwmon/ina209.c           | 1 +
 drivers/hwmon/ina2xx.c           | 1 +
 drivers/hwmon/ina3221.c          | 1 +
 drivers/hwmon/it87.c             | 1 +
 drivers/hwmon/lm63.c             | 1 +
 drivers/hwmon/lm73.c             | 1 +
 drivers/hwmon/lm77.c             | 1 +
 drivers/hwmon/lm78.c             | 1 +
 drivers/hwmon/lm80.c             | 1 +
 drivers/hwmon/lm85.c             | 1 +
 drivers/hwmon/lm87.c             | 1 +
 drivers/hwmon/lm90.c             | 1 +
 drivers/hwmon/lm92.c             | 1 +
 drivers/hwmon/lm93.c             | 1 +
 drivers/hwmon/lm95234.c          | 1 +
 drivers/hwmon/ltc2945.c          | 1 +
 drivers/hwmon/max16065.c         | 1 +
 drivers/hwmon/max1619.c          | 1 +
 drivers/hwmon/max1668.c          | 1 +
 drivers/hwmon/max197.c           | 1 +
 drivers/hwmon/max31760.c         | 1 +
 drivers/hwmon/max6639.c          | 1 +
 drivers/hwmon/max6697.c          | 1 +
 drivers/hwmon/mr75203.c          | 1 +
 drivers/hwmon/nct6683.c          | 1 +
 drivers/hwmon/nct6775-core.c     | 1 +
 drivers/hwmon/nct6775-platform.c | 1 +
 drivers/hwmon/nct7802.c          | 1 +
 drivers/hwmon/occ/common.c       | 1 +
 drivers/hwmon/pc87360.c          | 1 +
 drivers/hwmon/pc87427.c          | 1 +
 drivers/hwmon/pcf8591.c          | 1 +
 drivers/hwmon/pmbus/isl68137.c   | 1 +
 drivers/hwmon/pmbus/pmbus_core.c | 1 +
 drivers/hwmon/pmbus/q54sj108a2.c | 1 +
 drivers/hwmon/sht15.c            | 1 +
 drivers/hwmon/sht3x.c            | 1 +
 drivers/hwmon/sis5595.c          | 1 +
 drivers/hwmon/smsc47m1.c         | 1 +
 drivers/hwmon/smsc47m192.c       | 1 +
 drivers/hwmon/stts751.c          | 1 +
 drivers/hwmon/tc654.c            | 1 +
 drivers/hwmon/thmc50.c           | 1 +
 drivers/hwmon/via686a.c          | 1 +
 drivers/hwmon/vt1211.c           | 1 +
 drivers/hwmon/vt8231.c           | 1 +
 drivers/hwmon/w83627ehf.c        | 1 +
 drivers/hwmon/w83627hf.c         | 1 +
 drivers/hwmon/w83781d.c          | 1 +
 drivers/hwmon/w83791d.c          | 1 +
 drivers/hwmon/w83792d.c          | 1 +
 drivers/hwmon/w83793.c           | 1 +
 drivers/hwmon/w83795.c           | 1 +
 drivers/hwmon/w83l786ng.c        | 1 +
 97 files changed, 97 insertions(+)

diff --git a/drivers/hwmon/abituguru.c b/drivers/hwmon/abituguru.c
index a7cae6568155..92a2d0fbbe6e 100644
--- a/drivers/hwmon/abituguru.c
+++ b/drivers/hwmon/abituguru.c
@@ -15,6 +15,7 @@
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/jiffies.h>
+#include <linux/kstrtox.h>
 #include <linux/mutex.h>
 #include <linux/err.h>
 #include <linux/delay.h>
diff --git a/drivers/hwmon/acpi_power_meter.c b/drivers/hwmon/acpi_power_meter.c
index 0962c12eba5a..8f78141f5664 100644
--- a/drivers/hwmon/acpi_power_meter.c
+++ b/drivers/hwmon/acpi_power_meter.c
@@ -10,6 +10,7 @@
 #include <linux/hwmon.h>
 #include <linux/hwmon-sysfs.h>
 #include <linux/jiffies.h>
+#include <linux/kstrtox.h>
 #include <linux/mutex.h>
 #include <linux/dmi.h>
 #include <linux/slab.h>
diff --git a/drivers/hwmon/ad7414.c b/drivers/hwmon/ad7414.c
index 0afb89c4629d..9209d77539d0 100644
--- a/drivers/hwmon/ad7414.c
+++ b/drivers/hwmon/ad7414.c
@@ -21,6 +21,7 @@
 #include <linux/hwmon.h>
 #include <linux/hwmon-sysfs.h>
 #include <linux/err.h>
+#include <linux/kstrtox.h>
 #include <linux/mutex.h>
 #include <linux/sysfs.h>
 #include <linux/slab.h>
diff --git a/drivers/hwmon/ad7418.c b/drivers/hwmon/ad7418.c
index 22bdb7e5b9e0..6fb1a8304497 100644
--- a/drivers/hwmon/ad7418.c
+++ b/drivers/hwmon/ad7418.c
@@ -15,6 +15,7 @@
 #include <linux/hwmon.h>
 #include <linux/hwmon-sysfs.h>
 #include <linux/err.h>
+#include <linux/kstrtox.h>
 #include <linux/mutex.h>
 #include <linux/of_device.h>
 #include <linux/delay.h>
diff --git a/drivers/hwmon/adc128d818.c b/drivers/hwmon/adc128d818.c
index 97b330b6c165..47305b930a12 100644
--- a/drivers/hwmon/adc128d818.c
+++ b/drivers/hwmon/adc128d818.c
@@ -17,6 +17,7 @@
 #include <linux/hwmon-sysfs.h>
 #include <linux/err.h>
 #include <linux/regulator/consumer.h>
+#include <linux/kstrtox.h>
 #include <linux/mutex.h>
 #include <linux/bitops.h>
 #include <linux/of.h>
diff --git a/drivers/hwmon/adcxx.c b/drivers/hwmon/adcxx.c
index de37bce24fa6..dcc867d4d1a7 100644
--- a/drivers/hwmon/adcxx.c
+++ b/drivers/hwmon/adcxx.c
@@ -30,6 +30,7 @@
 #include <linux/sysfs.h>
 #include <linux/hwmon.h>
 #include <linux/hwmon-sysfs.h>
+#include <linux/kstrtox.h>
 #include <linux/mutex.h>
 #include <linux/mod_devicetable.h>
 #include <linux/spi/spi.h>
diff --git a/drivers/hwmon/adm1025.c b/drivers/hwmon/adm1025.c
index 2984c4f98496..f399e6df9d5f 100644
--- a/drivers/hwmon/adm1025.c
+++ b/drivers/hwmon/adm1025.c
@@ -41,6 +41,7 @@
 #include <linux/hwmon-sysfs.h>
 #include <linux/hwmon-vid.h>
 #include <linux/err.h>
+#include <linux/kstrtox.h>
 #include <linux/mutex.h>
 
 /*
diff --git a/drivers/hwmon/adm1026.c b/drivers/hwmon/adm1026.c
index 1f084f708743..4cb06b68fcbd 100644
--- a/drivers/hwmon/adm1026.c
+++ b/drivers/hwmon/adm1026.c
@@ -19,6 +19,7 @@
 #include <linux/hwmon-sysfs.h>
 #include <linux/hwmon-vid.h>
 #include <linux/err.h>
+#include <linux/kstrtox.h>
 #include <linux/mutex.h>
 
 /* Addresses to scan */
diff --git a/drivers/hwmon/adm1029.c b/drivers/hwmon/adm1029.c
index eaf6e5e04aac..a2423317d660 100644
--- a/drivers/hwmon/adm1029.c
+++ b/drivers/hwmon/adm1029.c
@@ -20,6 +20,7 @@
 #include <linux/hwmon-sysfs.h>
 #include <linux/hwmon.h>
 #include <linux/err.h>
+#include <linux/kstrtox.h>
 #include <linux/mutex.h>
 
 /*
diff --git a/drivers/hwmon/adm1031.c b/drivers/hwmon/adm1031.c
index b42797bcb5b4..f42a3e664639 100644
--- a/drivers/hwmon/adm1031.c
+++ b/drivers/hwmon/adm1031.c
@@ -16,6 +16,7 @@
 #include <linux/hwmon.h>
 #include <linux/hwmon-sysfs.h>
 #include <linux/err.h>
+#include <linux/kstrtox.h>
 #include <linux/mutex.h>
 
 /* Following macros takes channel parameter starting from 0 to 2 */
diff --git a/drivers/hwmon/adm9240.c b/drivers/hwmon/adm9240.c
index 40e3558d3709..d319a2fe38ba 100644
--- a/drivers/hwmon/adm9240.c
+++ b/drivers/hwmon/adm9240.c
@@ -37,6 +37,7 @@
 #include <linux/hwmon.h>
 #include <linux/hwmon-vid.h>
 #include <linux/err.h>
+#include <linux/kstrtox.h>
 #include <linux/mutex.h>
 #include <linux/regmap.h>
 
diff --git a/drivers/hwmon/adt7411.c b/drivers/hwmon/adt7411.c
index bf5c5618f8d0..a9371eb46d63 100644
--- a/drivers/hwmon/adt7411.c
+++ b/drivers/hwmon/adt7411.c
@@ -16,6 +16,7 @@
 #include <linux/i2c.h>
 #include <linux/hwmon.h>
 #include <linux/hwmon-sysfs.h>
+#include <linux/kstrtox.h>
 #include <linux/slab.h>
 
 #define ADT7411_REG_STAT_1			0x00
diff --git a/drivers/hwmon/adt7462.c b/drivers/hwmon/adt7462.c
index 9c0235849d4b..6b42b69f92b8 100644
--- a/drivers/hwmon/adt7462.c
+++ b/drivers/hwmon/adt7462.c
@@ -12,6 +12,7 @@
 #include <linux/hwmon.h>
 #include <linux/hwmon-sysfs.h>
 #include <linux/err.h>
+#include <linux/kstrtox.h>
 #include <linux/mutex.h>
 #include <linux/log2.h>
 #include <linux/slab.h>
diff --git a/drivers/hwmon/adt7470.c b/drivers/hwmon/adt7470.c
index 927f8df05b7c..389d4984c506 100644
--- a/drivers/hwmon/adt7470.c
+++ b/drivers/hwmon/adt7470.c
@@ -17,6 +17,7 @@
 #include <linux/mutex.h>
 #include <linux/delay.h>
 #include <linux/log2.h>
+#include <linux/kstrtox.h>
 #include <linux/kthread.h>
 #include <linux/regmap.h>
 #include <linux/sched.h>
diff --git a/drivers/hwmon/adt7475.c b/drivers/hwmon/adt7475.c
index 51b3d16c3223..7da0828f27de 100644
--- a/drivers/hwmon/adt7475.c
+++ b/drivers/hwmon/adt7475.c
@@ -19,6 +19,7 @@
 #include <linux/hwmon-vid.h>
 #include <linux/err.h>
 #include <linux/jiffies.h>
+#include <linux/kstrtox.h>
 #include <linux/of.h>
 #include <linux/util_macros.h>
 
diff --git a/drivers/hwmon/amc6821.c b/drivers/hwmon/amc6821.c
index 3bfd12ff4b3c..ae5a9e0458af 100644
--- a/drivers/hwmon/amc6821.c
+++ b/drivers/hwmon/amc6821.c
@@ -17,6 +17,7 @@
 #include <linux/hwmon.h>
 #include <linux/hwmon-sysfs.h>
 #include <linux/err.h>
+#include <linux/kstrtox.h>
 #include <linux/mutex.h>
 
 /*
diff --git a/drivers/hwmon/applesmc.c b/drivers/hwmon/applesmc.c
index fc6d6a9053ce..dd45d03ac9de 100644
--- a/drivers/hwmon/applesmc.c
+++ b/drivers/hwmon/applesmc.c
@@ -28,6 +28,7 @@
 #include <linux/mutex.h>
 #include <linux/hwmon-sysfs.h>
 #include <linux/io.h>
+#include <linux/kstrtox.h>
 #include <linux/leds.h>
 #include <linux/hwmon.h>
 #include <linux/workqueue.h>
diff --git a/drivers/hwmon/asb100.c b/drivers/hwmon/asb100.c
index ce4da836765c..aab9610f888c 100644
--- a/drivers/hwmon/asb100.c
+++ b/drivers/hwmon/asb100.c
@@ -34,6 +34,7 @@
 #include <linux/err.h>
 #include <linux/init.h>
 #include <linux/jiffies.h>
+#include <linux/kstrtox.h>
 #include <linux/mutex.h>
 #include "lm75.h"
 
diff --git a/drivers/hwmon/asc7621.c b/drivers/hwmon/asc7621.c
index 54595454537b..bb0bdc40071a 100644
--- a/drivers/hwmon/asc7621.c
+++ b/drivers/hwmon/asc7621.c
@@ -12,6 +12,7 @@
 #include <linux/hwmon.h>
 #include <linux/hwmon-sysfs.h>
 #include <linux/err.h>
+#include <linux/kstrtox.h>
 #include <linux/mutex.h>
 
 /* Addresses to scan */
diff --git a/drivers/hwmon/aspeed-pwm-tacho.c b/drivers/hwmon/aspeed-pwm-tacho.c
index d11f674e3dc3..8f0653fd973d 100644
--- a/drivers/hwmon/aspeed-pwm-tacho.c
+++ b/drivers/hwmon/aspeed-pwm-tacho.c
@@ -11,6 +11,7 @@
 #include <linux/hwmon-sysfs.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
+#include <linux/kstrtox.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
 #include <linux/of_platform.h>
diff --git a/drivers/hwmon/atxp1.c b/drivers/hwmon/atxp1.c
index 4fd8de8022bc..118297ea1dcf 100644
--- a/drivers/hwmon/atxp1.c
+++ b/drivers/hwmon/atxp1.c
@@ -16,6 +16,7 @@
 #include <linux/hwmon.h>
 #include <linux/hwmon-vid.h>
 #include <linux/err.h>
+#include <linux/kstrtox.h>
 #include <linux/mutex.h>
 #include <linux/sysfs.h>
 #include <linux/slab.h>
diff --git a/drivers/hwmon/axi-fan-control.c b/drivers/hwmon/axi-fan-control.c
index 6724e0dd3088..b8087f3fe497 100644
--- a/drivers/hwmon/axi-fan-control.c
+++ b/drivers/hwmon/axi-fan-control.c
@@ -12,6 +12,7 @@
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
+#include <linux/kstrtox.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
diff --git a/drivers/hwmon/dme1737.c b/drivers/hwmon/dme1737.c
index 66c48f70fae7..9d5807aff570 100644
--- a/drivers/hwmon/dme1737.c
+++ b/drivers/hwmon/dme1737.c
@@ -24,6 +24,7 @@
 #include <linux/hwmon-sysfs.h>
 #include <linux/hwmon-vid.h>
 #include <linux/err.h>
+#include <linux/kstrtox.h>
 #include <linux/mutex.h>
 #include <linux/acpi.h>
 #include <linux/io.h>
diff --git a/drivers/hwmon/ds1621.c b/drivers/hwmon/ds1621.c
index 0886abf6ebab..0f0dbc9b7709 100644
--- a/drivers/hwmon/ds1621.c
+++ b/drivers/hwmon/ds1621.c
@@ -29,6 +29,7 @@
 #include <linux/hwmon.h>
 #include <linux/hwmon-sysfs.h>
 #include <linux/err.h>
+#include <linux/kstrtox.h>
 #include <linux/mutex.h>
 #include <linux/sysfs.h>
 #include <linux/kernel.h>
diff --git a/drivers/hwmon/ds620.c b/drivers/hwmon/ds620.c
index 82d7c3d58f49..870e809e4d21 100644
--- a/drivers/hwmon/ds620.c
+++ b/drivers/hwmon/ds620.c
@@ -15,6 +15,7 @@
 #include <linux/hwmon.h>
 #include <linux/hwmon-sysfs.h>
 #include <linux/err.h>
+#include <linux/kstrtox.h>
 #include <linux/mutex.h>
 #include <linux/sysfs.h>
 #include <linux/platform_data/ds620.h>
diff --git a/drivers/hwmon/emc1403.c b/drivers/hwmon/emc1403.c
index 61d59189a6d1..ddf4d9237f95 100644
--- a/drivers/hwmon/emc1403.c
+++ b/drivers/hwmon/emc1403.c
@@ -17,6 +17,7 @@
 #include <linux/hwmon-sysfs.h>
 #include <linux/err.h>
 #include <linux/sysfs.h>
+#include <linux/kstrtox.h>
 #include <linux/mutex.h>
 #include <linux/regmap.h>
 
diff --git a/drivers/hwmon/emc2103.c b/drivers/hwmon/emc2103.c
index 361cf9292456..6f9a448e0bd1 100644
--- a/drivers/hwmon/emc2103.c
+++ b/drivers/hwmon/emc2103.c
@@ -12,6 +12,7 @@
 #include <linux/hwmon.h>
 #include <linux/hwmon-sysfs.h>
 #include <linux/err.h>
+#include <linux/kstrtox.h>
 #include <linux/mutex.h>
 
 /* Addresses scanned */
diff --git a/drivers/hwmon/emc6w201.c b/drivers/hwmon/emc6w201.c
index bcd93f0fe982..7eeb9d56ce3d 100644
--- a/drivers/hwmon/emc6w201.c
+++ b/drivers/hwmon/emc6w201.c
@@ -12,6 +12,7 @@
 #include <linux/hwmon.h>
 #include <linux/hwmon-sysfs.h>
 #include <linux/err.h>
+#include <linux/kstrtox.h>
 #include <linux/mutex.h>
 
 /*
diff --git a/drivers/hwmon/f71805f.c b/drivers/hwmon/f71805f.c
index 7f20edb0677c..2d772bf07225 100644
--- a/drivers/hwmon/f71805f.c
+++ b/drivers/hwmon/f71805f.c
@@ -25,6 +25,7 @@
 #include <linux/hwmon.h>
 #include <linux/hwmon-sysfs.h>
 #include <linux/err.h>
+#include <linux/kstrtox.h>
 #include <linux/mutex.h>
 #include <linux/sysfs.h>
 #include <linux/ioport.h>
diff --git a/drivers/hwmon/f71882fg.c b/drivers/hwmon/f71882fg.c
index 70121482a617..62743d278352 100644
--- a/drivers/hwmon/f71882fg.c
+++ b/drivers/hwmon/f71882fg.c
@@ -15,6 +15,7 @@
 #include <linux/hwmon.h>
 #include <linux/hwmon-sysfs.h>
 #include <linux/err.h>
+#include <linux/kstrtox.h>
 #include <linux/mutex.h>
 #include <linux/io.h>
 #include <linux/acpi.h>
diff --git a/drivers/hwmon/f75375s.c b/drivers/hwmon/f75375s.c
index 64fbb8cf687c..734279b2ce7f 100644
--- a/drivers/hwmon/f75375s.c
+++ b/drivers/hwmon/f75375s.c
@@ -22,6 +22,7 @@
 #include <linux/hwmon-sysfs.h>
 #include <linux/i2c.h>
 #include <linux/err.h>
+#include <linux/kstrtox.h>
 #include <linux/mutex.h>
 #include <linux/f75375s.h>
 #include <linux/slab.h>
diff --git a/drivers/hwmon/fam15h_power.c b/drivers/hwmon/fam15h_power.c
index 521534d5c1e5..b1e71ba6d7f4 100644
--- a/drivers/hwmon/fam15h_power.c
+++ b/drivers/hwmon/fam15h_power.c
@@ -15,6 +15,7 @@
 #include <linux/bitops.h>
 #include <linux/cpu.h>
 #include <linux/cpumask.h>
+#include <linux/kstrtox.h>
 #include <linux/time.h>
 #include <linux/sched.h>
 #include <asm/processor.h>
diff --git a/drivers/hwmon/fschmd.c b/drivers/hwmon/fschmd.c
index e1f426e86f36..b405d25e531d 100644
--- a/drivers/hwmon/fschmd.c
+++ b/drivers/hwmon/fschmd.c
@@ -27,6 +27,7 @@
 #include <linux/hwmon.h>
 #include <linux/hwmon-sysfs.h>
 #include <linux/err.h>
+#include <linux/kstrtox.h>
 #include <linux/mutex.h>
 #include <linux/sysfs.h>
 #include <linux/dmi.h>
diff --git a/drivers/hwmon/ftsteutates.c b/drivers/hwmon/ftsteutates.c
index f5b8e724a8ca..fd5a3a18144f 100644
--- a/drivers/hwmon/ftsteutates.c
+++ b/drivers/hwmon/ftsteutates.c
@@ -12,6 +12,7 @@
 #include <linux/i2c.h>
 #include <linux/init.h>
 #include <linux/jiffies.h>
+#include <linux/kstrtox.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/slab.h>
diff --git a/drivers/hwmon/g760a.c b/drivers/hwmon/g760a.c
index 36717b524dbd..02481726f6b5 100644
--- a/drivers/hwmon/g760a.c
+++ b/drivers/hwmon/g760a.c
@@ -17,6 +17,7 @@
 #include <linux/hwmon.h>
 #include <linux/hwmon-sysfs.h>
 #include <linux/err.h>
+#include <linux/kstrtox.h>
 #include <linux/mutex.h>
 #include <linux/sysfs.h>
 
diff --git a/drivers/hwmon/g762.c b/drivers/hwmon/g762.c
index 64a0599b2da5..8ca0cf06042f 100644
--- a/drivers/hwmon/g762.c
+++ b/drivers/hwmon/g762.c
@@ -35,6 +35,7 @@
 #include <linux/hwmon.h>
 #include <linux/hwmon-sysfs.h>
 #include <linux/err.h>
+#include <linux/kstrtox.h>
 #include <linux/mutex.h>
 #include <linux/kernel.h>
 #include <linux/clk.h>
diff --git a/drivers/hwmon/gl518sm.c b/drivers/hwmon/gl518sm.c
index 95286c40f55a..53e6b64fbf98 100644
--- a/drivers/hwmon/gl518sm.c
+++ b/drivers/hwmon/gl518sm.c
@@ -27,6 +27,7 @@
 #include <linux/hwmon.h>
 #include <linux/hwmon-sysfs.h>
 #include <linux/err.h>
+#include <linux/kstrtox.h>
 #include <linux/mutex.h>
 #include <linux/sysfs.h>
 
diff --git a/drivers/hwmon/gl520sm.c b/drivers/hwmon/gl520sm.c
index 394da4ac977c..4605a604195c 100644
--- a/drivers/hwmon/gl520sm.c
+++ b/drivers/hwmon/gl520sm.c
@@ -16,6 +16,7 @@
 #include <linux/hwmon-sysfs.h>
 #include <linux/hwmon-vid.h>
 #include <linux/err.h>
+#include <linux/kstrtox.h>
 #include <linux/mutex.h>
 #include <linux/sysfs.h>
 
diff --git a/drivers/hwmon/gpio-fan.c b/drivers/hwmon/gpio-fan.c
index ba408942dbe7..4996042cd784 100644
--- a/drivers/hwmon/gpio-fan.c
+++ b/drivers/hwmon/gpio-fan.c
@@ -17,6 +17,7 @@
 #include <linux/mutex.h>
 #include <linux/hwmon.h>
 #include <linux/gpio/consumer.h>
+#include <linux/kstrtox.h>
 #include <linux/of.h>
 #include <linux/of_platform.h>
 #include <linux/thermal.h>
diff --git a/drivers/hwmon/gsc-hwmon.c b/drivers/hwmon/gsc-hwmon.c
index b60ec95b5edb..741e2762d79d 100644
--- a/drivers/hwmon/gsc-hwmon.c
+++ b/drivers/hwmon/gsc-hwmon.c
@@ -7,6 +7,7 @@
 #include <linux/hwmon.h>
 #include <linux/hwmon-sysfs.h>
 #include <linux/mfd/gsc.h>
+#include <linux/kstrtox.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
diff --git a/drivers/hwmon/hwmon.c b/drivers/hwmon/hwmon.c
index 4218750d5a66..33edb5c02f7d 100644
--- a/drivers/hwmon/hwmon.c
+++ b/drivers/hwmon/hwmon.c
@@ -15,6 +15,7 @@
 #include <linux/gfp.h>
 #include <linux/hwmon.h>
 #include <linux/idr.h>
+#include <linux/kstrtox.h>
 #include <linux/list.h>
 #include <linux/module.h>
 #include <linux/pci.h>
diff --git a/drivers/hwmon/i5k_amb.c b/drivers/hwmon/i5k_amb.c
index 783fa936e4d1..7a72d8dd0050 100644
--- a/drivers/hwmon/i5k_amb.c
+++ b/drivers/hwmon/i5k_amb.c
@@ -12,6 +12,7 @@
 #include <linux/hwmon-sysfs.h>
 #include <linux/err.h>
 #include <linux/mutex.h>
+#include <linux/kstrtox.h>
 #include <linux/log2.h>
 #include <linux/pci.h>
 #include <linux/platform_device.h>
diff --git a/drivers/hwmon/ibmaem.c b/drivers/hwmon/ibmaem.c
index 157e232aace0..f5cf5c8d9f3f 100644
--- a/drivers/hwmon/ibmaem.c
+++ b/drivers/hwmon/ibmaem.c
@@ -16,6 +16,7 @@
 #include <linux/jiffies.h>
 #include <linux/mutex.h>
 #include <linux/kdev_t.h>
+#include <linux/kstrtox.h>
 #include <linux/spinlock.h>
 #include <linux/idr.h>
 #include <linux/slab.h>
diff --git a/drivers/hwmon/ina209.c b/drivers/hwmon/ina209.c
index 9b58655d2de4..3c4332098cf0 100644
--- a/drivers/hwmon/ina209.c
+++ b/drivers/hwmon/ina209.c
@@ -18,6 +18,7 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/kstrtox.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/err.h>
diff --git a/drivers/hwmon/ina2xx.c b/drivers/hwmon/ina2xx.c
index 00fc70305a89..ab790b8a3de0 100644
--- a/drivers/hwmon/ina2xx.c
+++ b/drivers/hwmon/ina2xx.c
@@ -31,6 +31,7 @@
 #include <linux/hwmon.h>
 #include <linux/hwmon-sysfs.h>
 #include <linux/jiffies.h>
+#include <linux/kstrtox.h>
 #include <linux/of_device.h>
 #include <linux/of.h>
 #include <linux/delay.h>
diff --git a/drivers/hwmon/ina3221.c b/drivers/hwmon/ina3221.c
index 2a57f4b60c29..6262927c291d 100644
--- a/drivers/hwmon/ina3221.c
+++ b/drivers/hwmon/ina3221.c
@@ -9,6 +9,7 @@
 #include <linux/hwmon.h>
 #include <linux/hwmon-sysfs.h>
 #include <linux/i2c.h>
+#include <linux/kstrtox.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/of.h>
diff --git a/drivers/hwmon/it87.c b/drivers/hwmon/it87.c
index 73ed21ab325b..97f38cb4c505 100644
--- a/drivers/hwmon/it87.c
+++ b/drivers/hwmon/it87.c
@@ -52,6 +52,7 @@
 #include <linux/hwmon-sysfs.h>
 #include <linux/hwmon-vid.h>
 #include <linux/err.h>
+#include <linux/kstrtox.h>
 #include <linux/mutex.h>
 #include <linux/sysfs.h>
 #include <linux/string.h>
diff --git a/drivers/hwmon/lm63.c b/drivers/hwmon/lm63.c
index 9ab2cab4c710..99c3a6226fd2 100644
--- a/drivers/hwmon/lm63.c
+++ b/drivers/hwmon/lm63.c
@@ -32,6 +32,7 @@
 #include <linux/hwmon-sysfs.h>
 #include <linux/hwmon.h>
 #include <linux/err.h>
+#include <linux/kstrtox.h>
 #include <linux/mutex.h>
 #include <linux/of_device.h>
 #include <linux/sysfs.h>
diff --git a/drivers/hwmon/lm73.c b/drivers/hwmon/lm73.c
index 1346b3b3f463..704f34791043 100644
--- a/drivers/hwmon/lm73.c
+++ b/drivers/hwmon/lm73.c
@@ -18,6 +18,7 @@
 #include <linux/hwmon.h>
 #include <linux/hwmon-sysfs.h>
 #include <linux/err.h>
+#include <linux/kstrtox.h>
 
 
 /* Addresses scanned */
diff --git a/drivers/hwmon/lm77.c b/drivers/hwmon/lm77.c
index 645cb2191abe..f5866047a106 100644
--- a/drivers/hwmon/lm77.c
+++ b/drivers/hwmon/lm77.c
@@ -20,6 +20,7 @@
 #include <linux/hwmon.h>
 #include <linux/hwmon-sysfs.h>
 #include <linux/err.h>
+#include <linux/kstrtox.h>
 #include <linux/mutex.h>
 
 /* Addresses to scan */
diff --git a/drivers/hwmon/lm78.c b/drivers/hwmon/lm78.c
index 694e171cab7f..44fa4e40c318 100644
--- a/drivers/hwmon/lm78.c
+++ b/drivers/hwmon/lm78.c
@@ -17,6 +17,7 @@
 #include <linux/hwmon-vid.h>
 #include <linux/hwmon-sysfs.h>
 #include <linux/err.h>
+#include <linux/kstrtox.h>
 #include <linux/mutex.h>
 
 #ifdef CONFIG_ISA
diff --git a/drivers/hwmon/lm80.c b/drivers/hwmon/lm80.c
index 35db0b97f912..5460ef9a09ea 100644
--- a/drivers/hwmon/lm80.c
+++ b/drivers/hwmon/lm80.c
@@ -16,6 +16,7 @@
 #include <linux/hwmon.h>
 #include <linux/hwmon-sysfs.h>
 #include <linux/err.h>
+#include <linux/kstrtox.h>
 #include <linux/mutex.h>
 
 /* Addresses to scan */
diff --git a/drivers/hwmon/lm85.c b/drivers/hwmon/lm85.c
index 8d33c2484755..522c590d370c 100644
--- a/drivers/hwmon/lm85.c
+++ b/drivers/hwmon/lm85.c
@@ -21,6 +21,7 @@
 #include <linux/hwmon-vid.h>
 #include <linux/hwmon-sysfs.h>
 #include <linux/err.h>
+#include <linux/kstrtox.h>
 #include <linux/mutex.h>
 #include <linux/util_macros.h>
 
diff --git a/drivers/hwmon/lm87.c b/drivers/hwmon/lm87.c
index 818fb6195245..9748c6a6acec 100644
--- a/drivers/hwmon/lm87.c
+++ b/drivers/hwmon/lm87.c
@@ -52,6 +52,7 @@
 #include <linux/hwmon-sysfs.h>
 #include <linux/hwmon-vid.h>
 #include <linux/err.h>
+#include <linux/kstrtox.h>
 #include <linux/mutex.h>
 #include <linux/regulator/consumer.h>
 
diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
index a3f95ba00dbf..6498d5acf705 100644
--- a/drivers/hwmon/lm90.c
+++ b/drivers/hwmon/lm90.c
@@ -103,6 +103,7 @@
 #include <linux/interrupt.h>
 #include <linux/jiffies.h>
 #include <linux/hwmon.h>
+#include <linux/kstrtox.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/of_device.h>
diff --git a/drivers/hwmon/lm92.c b/drivers/hwmon/lm92.c
index 2ff3044a677d..10d99c2264da 100644
--- a/drivers/hwmon/lm92.c
+++ b/drivers/hwmon/lm92.c
@@ -34,6 +34,7 @@
 #include <linux/hwmon.h>
 #include <linux/hwmon-sysfs.h>
 #include <linux/err.h>
+#include <linux/kstrtox.h>
 #include <linux/mutex.h>
 #include <linux/jiffies.h>
 
diff --git a/drivers/hwmon/lm93.c b/drivers/hwmon/lm93.c
index 4cf50d5f4f59..52de6fe74534 100644
--- a/drivers/hwmon/lm93.c
+++ b/drivers/hwmon/lm93.c
@@ -35,6 +35,7 @@
 #include <linux/err.h>
 #include <linux/delay.h>
 #include <linux/jiffies.h>
+#include <linux/kstrtox.h>
 
 /* LM93 REGISTER ADDRESSES */
 
diff --git a/drivers/hwmon/lm95234.c b/drivers/hwmon/lm95234.c
index b4a9d0c223c4..d94aa2c9662b 100644
--- a/drivers/hwmon/lm95234.c
+++ b/drivers/hwmon/lm95234.c
@@ -16,6 +16,7 @@
 #include <linux/hwmon.h>
 #include <linux/hwmon-sysfs.h>
 #include <linux/err.h>
+#include <linux/kstrtox.h>
 #include <linux/mutex.h>
 #include <linux/sysfs.h>
 
diff --git a/drivers/hwmon/ltc2945.c b/drivers/hwmon/ltc2945.c
index 9adebb59f604..8bf6ef2bf6c7 100644
--- a/drivers/hwmon/ltc2945.c
+++ b/drivers/hwmon/ltc2945.c
@@ -13,6 +13,7 @@
 #include <linux/hwmon.h>
 #include <linux/hwmon-sysfs.h>
 #include <linux/jiffies.h>
+#include <linux/kstrtox.h>
 #include <linux/regmap.h>
 
 /* chip registers */
diff --git a/drivers/hwmon/max16065.c b/drivers/hwmon/max16065.c
index daa5d8af1e69..bfd76b1f4a8f 100644
--- a/drivers/hwmon/max16065.c
+++ b/drivers/hwmon/max16065.c
@@ -20,6 +20,7 @@
 #include <linux/hwmon.h>
 #include <linux/hwmon-sysfs.h>
 #include <linux/jiffies.h>
+#include <linux/kstrtox.h>
 
 enum chips { max16065, max16066, max16067, max16068, max16070, max16071 };
 
diff --git a/drivers/hwmon/max1619.c b/drivers/hwmon/max1619.c
index 445c77197f69..a57ff4ee77c5 100644
--- a/drivers/hwmon/max1619.c
+++ b/drivers/hwmon/max1619.c
@@ -20,6 +20,7 @@
 #include <linux/hwmon.h>
 #include <linux/hwmon-sysfs.h>
 #include <linux/err.h>
+#include <linux/kstrtox.h>
 #include <linux/mutex.h>
 #include <linux/sysfs.h>
 
diff --git a/drivers/hwmon/max1668.c b/drivers/hwmon/max1668.c
index 9f748973d6a3..5dbb71fb95e2 100644
--- a/drivers/hwmon/max1668.c
+++ b/drivers/hwmon/max1668.c
@@ -14,6 +14,7 @@
 #include <linux/hwmon.h>
 #include <linux/hwmon-sysfs.h>
 #include <linux/err.h>
+#include <linux/kstrtox.h>
 #include <linux/mutex.h>
 
 /* Addresses to scan */
diff --git a/drivers/hwmon/max197.c b/drivers/hwmon/max197.c
index 56add579e32f..aa020dfdf110 100644
--- a/drivers/hwmon/max197.c
+++ b/drivers/hwmon/max197.c
@@ -19,6 +19,7 @@
 #include <linux/sysfs.h>
 #include <linux/hwmon.h>
 #include <linux/hwmon-sysfs.h>
+#include <linux/kstrtox.h>
 #include <linux/platform_device.h>
 #include <linux/platform_data/max197.h>
 
diff --git a/drivers/hwmon/max31760.c b/drivers/hwmon/max31760.c
index 06d5f39dc33d..4be2a4ec2277 100644
--- a/drivers/hwmon/max31760.c
+++ b/drivers/hwmon/max31760.c
@@ -6,6 +6,7 @@
 #include <linux/hwmon.h>
 #include <linux/hwmon-sysfs.h>
 #include <linux/i2c.h>
+#include <linux/kstrtox.h>
 #include <linux/regmap.h>
 #include <linux/util_macros.h>
 
diff --git a/drivers/hwmon/max6639.c b/drivers/hwmon/max6639.c
index 9b895402c80d..eb73b440d0ac 100644
--- a/drivers/hwmon/max6639.c
+++ b/drivers/hwmon/max6639.c
@@ -18,6 +18,7 @@
 #include <linux/hwmon.h>
 #include <linux/hwmon-sysfs.h>
 #include <linux/err.h>
+#include <linux/kstrtox.h>
 #include <linux/mutex.h>
 #include <linux/platform_data/max6639.h>
 
diff --git a/drivers/hwmon/max6697.c b/drivers/hwmon/max6697.c
index 2895cea54193..8f62eaa07c77 100644
--- a/drivers/hwmon/max6697.c
+++ b/drivers/hwmon/max6697.c
@@ -14,6 +14,7 @@
 #include <linux/hwmon.h>
 #include <linux/hwmon-sysfs.h>
 #include <linux/err.h>
+#include <linux/kstrtox.h>
 #include <linux/mutex.h>
 #include <linux/of_device.h>
 #include <linux/of.h>
diff --git a/drivers/hwmon/mr75203.c b/drivers/hwmon/mr75203.c
index 394a4c7e46ab..50a8b9c3f94d 100644
--- a/drivers/hwmon/mr75203.c
+++ b/drivers/hwmon/mr75203.c
@@ -11,6 +11,7 @@
 #include <linux/clk.h>
 #include <linux/debugfs.h>
 #include <linux/hwmon.h>
+#include <linux/kstrtox.h>
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
 #include <linux/mutex.h>
diff --git a/drivers/hwmon/nct6683.c b/drivers/hwmon/nct6683.c
index a872f783e9cc..eaf7bd67be43 100644
--- a/drivers/hwmon/nct6683.c
+++ b/drivers/hwmon/nct6683.c
@@ -29,6 +29,7 @@
 #include <linux/jiffies.h>
 #include <linux/hwmon.h>
 #include <linux/hwmon-sysfs.h>
+#include <linux/kstrtox.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/platform_device.h>
diff --git a/drivers/hwmon/nct6775-core.c b/drivers/hwmon/nct6775-core.c
index da9ec6983e13..6650883f7ad2 100644
--- a/drivers/hwmon/nct6775-core.c
+++ b/drivers/hwmon/nct6775-core.c
@@ -47,6 +47,7 @@
 #include <linux/hwmon.h>
 #include <linux/hwmon-sysfs.h>
 #include <linux/err.h>
+#include <linux/kstrtox.h>
 #include <linux/mutex.h>
 #include <linux/bitops.h>
 #include <linux/nospec.h>
diff --git a/drivers/hwmon/nct6775-platform.c b/drivers/hwmon/nct6775-platform.c
index b34783784213..300ed5a31903 100644
--- a/drivers/hwmon/nct6775-platform.c
+++ b/drivers/hwmon/nct6775-platform.c
@@ -14,6 +14,7 @@
 #include <linux/hwmon-vid.h>
 #include <linux/init.h>
 #include <linux/io.h>
+#include <linux/kstrtox.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
diff --git a/drivers/hwmon/nct7802.c b/drivers/hwmon/nct7802.c
index a175f8283695..d2deaa97af30 100644
--- a/drivers/hwmon/nct7802.c
+++ b/drivers/hwmon/nct7802.c
@@ -13,6 +13,7 @@
 #include <linux/hwmon.h>
 #include <linux/hwmon-sysfs.h>
 #include <linux/jiffies.h>
+#include <linux/kstrtox.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/regmap.h>
diff --git a/drivers/hwmon/occ/common.c b/drivers/hwmon/occ/common.c
index dd690f700d49..f51a7a21144b 100644
--- a/drivers/hwmon/occ/common.c
+++ b/drivers/hwmon/occ/common.c
@@ -7,6 +7,7 @@
 #include <linux/hwmon-sysfs.h>
 #include <linux/jiffies.h>
 #include <linux/kernel.h>
+#include <linux/kstrtox.h>
 #include <linux/math64.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
diff --git a/drivers/hwmon/pc87360.c b/drivers/hwmon/pc87360.c
index a4adc8bd531f..a1a03fe3ac72 100644
--- a/drivers/hwmon/pc87360.c
+++ b/drivers/hwmon/pc87360.c
@@ -31,6 +31,7 @@
 #include <linux/hwmon-sysfs.h>
 #include <linux/hwmon-vid.h>
 #include <linux/err.h>
+#include <linux/kstrtox.h>
 #include <linux/mutex.h>
 #include <linux/acpi.h>
 #include <linux/io.h>
diff --git a/drivers/hwmon/pc87427.c b/drivers/hwmon/pc87427.c
index eaab83d879fb..cb2dc42a888e 100644
--- a/drivers/hwmon/pc87427.c
+++ b/drivers/hwmon/pc87427.c
@@ -24,6 +24,7 @@
 #include <linux/hwmon.h>
 #include <linux/hwmon-sysfs.h>
 #include <linux/err.h>
+#include <linux/kstrtox.h>
 #include <linux/mutex.h>
 #include <linux/sysfs.h>
 #include <linux/ioport.h>
diff --git a/drivers/hwmon/pcf8591.c b/drivers/hwmon/pcf8591.c
index af9614e918a4..1dbe209ae13f 100644
--- a/drivers/hwmon/pcf8591.c
+++ b/drivers/hwmon/pcf8591.c
@@ -14,6 +14,7 @@
 #include <linux/mutex.h>
 #include <linux/err.h>
 #include <linux/hwmon.h>
+#include <linux/kstrtox.h>
 
 /* Insmod parameters */
 
diff --git a/drivers/hwmon/pmbus/isl68137.c b/drivers/hwmon/pmbus/isl68137.c
index 1a8caff1ac5f..ac2be54936dd 100644
--- a/drivers/hwmon/pmbus/isl68137.c
+++ b/drivers/hwmon/pmbus/isl68137.c
@@ -12,6 +12,7 @@
 #include <linux/i2c.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
+#include <linux/kstrtox.h>
 #include <linux/module.h>
 #include <linux/string.h>
 #include <linux/sysfs.h>
diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
index 7ec04934747e..2763f05c2894 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -16,6 +16,7 @@
 #include <linux/i2c.h>
 #include <linux/hwmon.h>
 #include <linux/hwmon-sysfs.h>
+#include <linux/kstrtox.h>
 #include <linux/pmbus.h>
 #include <linux/regulator/driver.h>
 #include <linux/regulator/machine.h>
diff --git a/drivers/hwmon/pmbus/q54sj108a2.c b/drivers/hwmon/pmbus/q54sj108a2.c
index fa298b4265a1..d3ba12951324 100644
--- a/drivers/hwmon/pmbus/q54sj108a2.c
+++ b/drivers/hwmon/pmbus/q54sj108a2.c
@@ -8,6 +8,7 @@
 
 #include <linux/debugfs.h>
 #include <linux/i2c.h>
+#include <linux/kstrtox.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
 #include "pmbus.h"
diff --git a/drivers/hwmon/sht15.c b/drivers/hwmon/sht15.c
index ae4d14257a11..e193eb68d35d 100644
--- a/drivers/hwmon/sht15.c
+++ b/drivers/hwmon/sht15.c
@@ -25,6 +25,7 @@
 #include <linux/delay.h>
 #include <linux/jiffies.h>
 #include <linux/err.h>
+#include <linux/kstrtox.h>
 #include <linux/regulator/consumer.h>
 #include <linux/slab.h>
 #include <linux/atomic.h>
diff --git a/drivers/hwmon/sht3x.c b/drivers/hwmon/sht3x.c
index 3f279aa1cee5..fe0e1e7c5d99 100644
--- a/drivers/hwmon/sht3x.c
+++ b/drivers/hwmon/sht3x.c
@@ -17,6 +17,7 @@
 #include <linux/i2c.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
+#include <linux/kstrtox.h>
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/jiffies.h>
diff --git a/drivers/hwmon/sis5595.c b/drivers/hwmon/sis5595.c
index b0b05fd12221..69287e47e87b 100644
--- a/drivers/hwmon/sis5595.c
+++ b/drivers/hwmon/sis5595.c
@@ -50,6 +50,7 @@
 #include <linux/err.h>
 #include <linux/init.h>
 #include <linux/jiffies.h>
+#include <linux/kstrtox.h>
 #include <linux/mutex.h>
 #include <linux/sysfs.h>
 #include <linux/acpi.h>
diff --git a/drivers/hwmon/smsc47m1.c b/drivers/hwmon/smsc47m1.c
index 37531b5c8254..331170c7795a 100644
--- a/drivers/hwmon/smsc47m1.c
+++ b/drivers/hwmon/smsc47m1.c
@@ -24,6 +24,7 @@
 #include <linux/hwmon-sysfs.h>
 #include <linux/err.h>
 #include <linux/init.h>
+#include <linux/kstrtox.h>
 #include <linux/mutex.h>
 #include <linux/sysfs.h>
 #include <linux/acpi.h>
diff --git a/drivers/hwmon/smsc47m192.c b/drivers/hwmon/smsc47m192.c
index 70d2152234e2..fa9fb6930cbc 100644
--- a/drivers/hwmon/smsc47m192.c
+++ b/drivers/hwmon/smsc47m192.c
@@ -17,6 +17,7 @@
 #include <linux/hwmon-sysfs.h>
 #include <linux/hwmon-vid.h>
 #include <linux/err.h>
+#include <linux/kstrtox.h>
 #include <linux/sysfs.h>
 #include <linux/mutex.h>
 
diff --git a/drivers/hwmon/stts751.c b/drivers/hwmon/stts751.c
index 2f67c6747ead..d0fc5cbe6131 100644
--- a/drivers/hwmon/stts751.c
+++ b/drivers/hwmon/stts751.c
@@ -19,6 +19,7 @@
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/jiffies.h>
+#include <linux/kstrtox.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/property.h>
diff --git a/drivers/hwmon/tc654.c b/drivers/hwmon/tc654.c
index 54cd33d09688..ff31d75264a2 100644
--- a/drivers/hwmon/tc654.c
+++ b/drivers/hwmon/tc654.c
@@ -12,6 +12,7 @@
 #include <linux/i2c.h>
 #include <linux/init.h>
 #include <linux/jiffies.h>
+#include <linux/kstrtox.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/slab.h>
diff --git a/drivers/hwmon/thmc50.c b/drivers/hwmon/thmc50.c
index 81cdb012993c..e1a015e95dc2 100644
--- a/drivers/hwmon/thmc50.c
+++ b/drivers/hwmon/thmc50.c
@@ -14,6 +14,7 @@
 #include <linux/hwmon.h>
 #include <linux/hwmon-sysfs.h>
 #include <linux/err.h>
+#include <linux/kstrtox.h>
 #include <linux/mutex.h>
 #include <linux/jiffies.h>
 
diff --git a/drivers/hwmon/via686a.c b/drivers/hwmon/via686a.c
index 37d7374896f6..8576e1db995d 100644
--- a/drivers/hwmon/via686a.c
+++ b/drivers/hwmon/via686a.c
@@ -29,6 +29,7 @@
 #include <linux/hwmon-sysfs.h>
 #include <linux/err.h>
 #include <linux/init.h>
+#include <linux/kstrtox.h>
 #include <linux/mutex.h>
 #include <linux/sysfs.h>
 #include <linux/acpi.h>
diff --git a/drivers/hwmon/vt1211.c b/drivers/hwmon/vt1211.c
index 4a5e911d26eb..926660a2971b 100644
--- a/drivers/hwmon/vt1211.c
+++ b/drivers/hwmon/vt1211.c
@@ -19,6 +19,7 @@
 #include <linux/hwmon-sysfs.h>
 #include <linux/hwmon-vid.h>
 #include <linux/err.h>
+#include <linux/kstrtox.h>
 #include <linux/mutex.h>
 #include <linux/ioport.h>
 #include <linux/acpi.h>
diff --git a/drivers/hwmon/vt8231.c b/drivers/hwmon/vt8231.c
index 3b7f8922b0d5..164578d3ab0c 100644
--- a/drivers/hwmon/vt8231.c
+++ b/drivers/hwmon/vt8231.c
@@ -24,6 +24,7 @@
 #include <linux/hwmon-sysfs.h>
 #include <linux/hwmon-vid.h>
 #include <linux/err.h>
+#include <linux/kstrtox.h>
 #include <linux/mutex.h>
 #include <linux/acpi.h>
 #include <linux/io.h>
diff --git a/drivers/hwmon/w83627ehf.c b/drivers/hwmon/w83627ehf.c
index 939d4c35e713..3d997b3f3cee 100644
--- a/drivers/hwmon/w83627ehf.c
+++ b/drivers/hwmon/w83627ehf.c
@@ -41,6 +41,7 @@
 #include <linux/hwmon-sysfs.h>
 #include <linux/hwmon-vid.h>
 #include <linux/err.h>
+#include <linux/kstrtox.h>
 #include <linux/mutex.h>
 #include <linux/acpi.h>
 #include <linux/io.h>
diff --git a/drivers/hwmon/w83627hf.c b/drivers/hwmon/w83627hf.c
index b638d672ac45..cf926375a168 100644
--- a/drivers/hwmon/w83627hf.c
+++ b/drivers/hwmon/w83627hf.c
@@ -32,6 +32,7 @@
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/jiffies.h>
+#include <linux/kstrtox.h>
 #include <linux/platform_device.h>
 #include <linux/hwmon.h>
 #include <linux/hwmon-sysfs.h>
diff --git a/drivers/hwmon/w83781d.c b/drivers/hwmon/w83781d.c
index dacabf25e83f..977cb4221e92 100644
--- a/drivers/hwmon/w83781d.c
+++ b/drivers/hwmon/w83781d.c
@@ -32,6 +32,7 @@
 #include <linux/hwmon-sysfs.h>
 #include <linux/sysfs.h>
 #include <linux/err.h>
+#include <linux/kstrtox.h>
 #include <linux/mutex.h>
 
 #ifdef CONFIG_ISA
diff --git a/drivers/hwmon/w83791d.c b/drivers/hwmon/w83791d.c
index eaf691365023..decb04481100 100644
--- a/drivers/hwmon/w83791d.c
+++ b/drivers/hwmon/w83791d.c
@@ -27,6 +27,7 @@
 #include <linux/hwmon-vid.h>
 #include <linux/hwmon-sysfs.h>
 #include <linux/err.h>
+#include <linux/kstrtox.h>
 #include <linux/mutex.h>
 #include <linux/jiffies.h>
 
diff --git a/drivers/hwmon/w83792d.c b/drivers/hwmon/w83792d.c
index 6d160eee1446..9853e0b70e93 100644
--- a/drivers/hwmon/w83792d.c
+++ b/drivers/hwmon/w83792d.c
@@ -29,6 +29,7 @@
 #include <linux/hwmon.h>
 #include <linux/hwmon-sysfs.h>
 #include <linux/err.h>
+#include <linux/kstrtox.h>
 #include <linux/mutex.h>
 #include <linux/sysfs.h>
 #include <linux/jiffies.h>
diff --git a/drivers/hwmon/w83793.c b/drivers/hwmon/w83793.c
index a4926d907198..4c83c6ab031a 100644
--- a/drivers/hwmon/w83793.c
+++ b/drivers/hwmon/w83793.c
@@ -31,6 +31,7 @@
 #include <linux/miscdevice.h>
 #include <linux/uaccess.h>
 #include <linux/kref.h>
+#include <linux/kstrtox.h>
 #include <linux/notifier.h>
 #include <linux/reboot.h>
 #include <linux/jiffies.h>
diff --git a/drivers/hwmon/w83795.c b/drivers/hwmon/w83795.c
index 84ff5c57e98c..eaf32d5aceb3 100644
--- a/drivers/hwmon/w83795.c
+++ b/drivers/hwmon/w83795.c
@@ -20,6 +20,7 @@
 #include <linux/hwmon.h>
 #include <linux/hwmon-sysfs.h>
 #include <linux/err.h>
+#include <linux/kstrtox.h>
 #include <linux/mutex.h>
 #include <linux/jiffies.h>
 #include <linux/util_macros.h>
diff --git a/drivers/hwmon/w83l786ng.c b/drivers/hwmon/w83l786ng.c
index 2c4646fa8426..f0a894412791 100644
--- a/drivers/hwmon/w83l786ng.c
+++ b/drivers/hwmon/w83l786ng.c
@@ -19,6 +19,7 @@
 #include <linux/hwmon-vid.h>
 #include <linux/hwmon-sysfs.h>
 #include <linux/err.h>
+#include <linux/kstrtox.h>
 #include <linux/mutex.h>
 #include <linux/jiffies.h>
 
-- 
2.34.1

