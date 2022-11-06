Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94C4461E0AB
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 09:01:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbiKFIBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 03:01:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbiKFIA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 03:00:59 -0500
Received: from smtp.smtpout.orange.fr (smtp-11.smtpout.orange.fr [80.12.242.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B08E2633D
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 01:00:56 -0700 (PDT)
Received: from pop-os.home ([86.243.100.34])
        by smtp.orange.fr with ESMTPA
        id raaLoCxK7vbzbraaMoTkHw; Sun, 06 Nov 2022 09:00:54 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 06 Nov 2022 09:00:54 +0100
X-ME-IP: 86.243.100.34
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-rtc@vger.kernel.org
Subject: [PATCH] rtc: Include <linux/kstrtox.h> when appropriate
Date:   Sun,  6 Nov 2022 09:00:51 +0100
Message-Id: <786421fd0435a32206288904a1f879436a717529.1667721637.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
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
in rtc-abx80x.c and rtc-ds1307.c.

I've done my best to keep alphabetical order of the included files, to that
is not always easy to achieve!
---
 drivers/rtc/rtc-abx80x.c   | 1 +
 drivers/rtc/rtc-bq32k.c    | 1 +
 drivers/rtc/rtc-ds1307.c   | 1 +
 drivers/rtc/rtc-rv3029c2.c | 1 +
 drivers/rtc/rtc-rx8025.c   | 1 +
 drivers/rtc/sysfs.c        | 1 +
 6 files changed, 6 insertions(+)

diff --git a/drivers/rtc/rtc-abx80x.c b/drivers/rtc/rtc-abx80x.c
index 9b0138d07232..973649d95e13 100644
--- a/drivers/rtc/rtc-abx80x.c
+++ b/drivers/rtc/rtc-abx80x.c
@@ -12,6 +12,7 @@
 
 #include <linux/bcd.h>
 #include <linux/i2c.h>
+#include <linux/kstrtox.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
 #include <linux/rtc.h>
diff --git a/drivers/rtc/rtc-bq32k.c b/drivers/rtc/rtc-bq32k.c
index 6d6a55efb9cc..967ddc6bf76d 100644
--- a/drivers/rtc/rtc-bq32k.c
+++ b/drivers/rtc/rtc-bq32k.c
@@ -13,6 +13,7 @@
 #include <linux/i2c.h>
 #include <linux/rtc.h>
 #include <linux/init.h>
+#include <linux/kstrtox.h>
 #include <linux/errno.h>
 #include <linux/bcd.h>
 
diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
index d51565bcc189..7c2276cf5514 100644
--- a/drivers/rtc/rtc-ds1307.c
+++ b/drivers/rtc/rtc-ds1307.c
@@ -11,6 +11,7 @@
 #include <linux/bcd.h>
 #include <linux/i2c.h>
 #include <linux/init.h>
+#include <linux/kstrtox.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/property.h>
diff --git a/drivers/rtc/rtc-rv3029c2.c b/drivers/rtc/rtc-rv3029c2.c
index eb483a30bd92..e4fdd47ae066 100644
--- a/drivers/rtc/rtc-rv3029c2.c
+++ b/drivers/rtc/rtc-rv3029c2.c
@@ -17,6 +17,7 @@
 #include <linux/of.h>
 #include <linux/hwmon.h>
 #include <linux/hwmon-sysfs.h>
+#include <linux/kstrtox.h>
 #include <linux/regmap.h>
 
 /* Register map */
diff --git a/drivers/rtc/rtc-rx8025.c b/drivers/rtc/rtc-rx8025.c
index dde86f3e2a4b..078b4406acad 100644
--- a/drivers/rtc/rtc-rx8025.c
+++ b/drivers/rtc/rtc-rx8025.c
@@ -19,6 +19,7 @@
 #include <linux/bitops.h>
 #include <linux/i2c.h>
 #include <linux/kernel.h>
+#include <linux/kstrtox.h>
 #include <linux/module.h>
 #include <linux/rtc.h>
 
diff --git a/drivers/rtc/sysfs.c b/drivers/rtc/sysfs.c
index 00f1945bcb7e..e3062c4d3f2c 100644
--- a/drivers/rtc/sysfs.c
+++ b/drivers/rtc/sysfs.c
@@ -6,6 +6,7 @@
  * Author: Alessandro Zummo <a.zummo@towertech.it>
  */
 
+#include <linux/kstrtox.h>
 #include <linux/module.h>
 #include <linux/rtc.h>
 
-- 
2.34.1

