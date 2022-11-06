Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9785861E58D
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 20:34:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbiKFTeg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 14:34:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbiKFTe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 14:34:26 -0500
Received: from smtp.smtpout.orange.fr (smtp-16.smtpout.orange.fr [80.12.242.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 375B9E095
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 11:34:24 -0800 (PST)
Received: from pop-os.home ([86.243.100.34])
        by smtp.orange.fr with ESMTPA
        id rlPRo1bQcsfCIrlPRomc2E; Sun, 06 Nov 2022 20:34:22 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 06 Nov 2022 20:34:22 +0100
X-ME-IP: 86.243.100.34
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-hwmon@vger.kernel.org
Subject: [PATCH v2] hwmon: Include <linux/kstrtox.h> when appropriate
Date:   Sun,  6 Nov 2022 20:34:16 +0100
Message-Id: <51688cf50bda44e2731381a31287c62319388783.1667763218.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
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

Changes in v2:
   - Include <linux/kstrtox.h> in <linux/hwmon-sysfs.h> so that much less
     drivers need to be updated   [Guenter Roeck]

v1: https://lore.kernel.org/all/0e819645f8d607f7b4550c8aaf4a563b1404bf40.1667730675.git.christophe.jaillet@wanadoo.fr/
---
 drivers/hwmon/atxp1.c            | 1 +
 drivers/hwmon/gpio-fan.c         | 1 +
 drivers/hwmon/hwmon.c            | 1 +
 drivers/hwmon/lm90.c             | 1 +
 drivers/hwmon/mr75203.c          | 1 +
 drivers/hwmon/pcf8591.c          | 1 +
 drivers/hwmon/pmbus/q54sj108a2.c | 1 +
 include/linux/hwmon-sysfs.h      | 1 +
 8 files changed, 8 insertions(+)

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
diff --git a/drivers/hwmon/gpio-fan.c b/drivers/hwmon/gpio-fan.c
index ba408942dbe7..e75db6f64e8c 100644
--- a/drivers/hwmon/gpio-fan.c
+++ b/drivers/hwmon/gpio-fan.c
@@ -14,6 +14,7 @@
 #include <linux/irq.h>
 #include <linux/platform_device.h>
 #include <linux/err.h>
+#include <linux/kstrtox.h>
 #include <linux/mutex.h>
 #include <linux/hwmon.h>
 #include <linux/gpio/consumer.h>
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
diff --git a/include/linux/hwmon-sysfs.h b/include/linux/hwmon-sysfs.h
index cb26d02f52f3..d896713359cd 100644
--- a/include/linux/hwmon-sysfs.h
+++ b/include/linux/hwmon-sysfs.h
@@ -8,6 +8,7 @@
 #define _LINUX_HWMON_SYSFS_H
 
 #include <linux/device.h>
+#include <linux/kstrtox.h>
 
 struct sensor_device_attribute{
 	struct device_attribute dev_attr;
-- 
2.34.1

