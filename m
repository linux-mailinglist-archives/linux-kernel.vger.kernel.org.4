Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2F2E73CA6B
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 12:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233071AbjFXKOP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 06:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233060AbjFXKON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 06:14:13 -0400
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DDDC1BF2
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jun 2023 03:14:11 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id C64B8240103
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jun 2023 12:14:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1687601649; bh=iaUVSnuKkwJ5a4hvz5q/EtjfvAaUpU9k26WNESxBnHk=;
        h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:
         Content-Disposition:From;
        b=FkwnP9SG0IAJ1xf2B2Ao385/XAu2sz4Zi+knE//LcNf+GyMt6qAzLwGDx5gBMAQTc
         l64GcuNCJQ7Qo/LT8y1QQcMA4GPusrqW3SuUoTaDabKCUXGbdD1P9mDt7S8NKUlonf
         NuFloxpxHo9GIYB0HAh1EO3HHRxDN0a0bn6h1TNcGxR5u4RikJtxVzZBMoo7OrHyIj
         n3v5OMagFISTVak5mF+nkaociI10RNQ1QyPSzY3buIKuT7t3t8yU/LQjmkvX7avevS
         tjSR0h6z02ONspL33X+pOtALudwn52hdGn1G9CsH/vgY4k6An9Kt55Jz5UKhhK5Pb0
         UVAAgJsRJbgoA==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4Qp91r6Ppfz6tvJ;
        Sat, 24 Jun 2023 12:14:08 +0200 (CEST)
Date:   Sat, 24 Jun 2023 10:14:07 +0000
From:   Wilken Gottwalt <wilken.gottwalt@posteo.net>
To:     linux-kernel@vger.kernel.org
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org
Subject: [PATCH] hwmon: corsair-psu: update Series 2022 and 2023 support
Message-ID: <ZJbB72CAPmLflhHG@monster.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The series 2022/2023 reports slightly longer vendor/product strings
and shares USB ids. Technically the reply size is the USB HID packet
size (64 bytes) but all the supported commands do not use more than 8
bytes and replies reporting back strings do not use more then 24 bytes
(vendor and product are in one string in the newer devices now). The
rest of the reply is always filled with '\0'. Also update comments
and documentation accordingly.

Signed-off-by: Wilken Gottwalt <wilken.gottwalt@posteo.net>
---
 Documentation/hwmon/corsair-psu.rst | 13 ++++++++-----
 drivers/hwmon/corsair-psu.c         |  9 ++++++---
 2 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/Documentation/hwmon/corsair-psu.rst b/Documentation/hwmon/corsair-psu.rst
index 47f8ff632267..16db34d464dd 100644
--- a/Documentation/hwmon/corsair-psu.rst
+++ b/Documentation/hwmon/corsair-psu.rst
@@ -15,11 +15,11 @@ Supported devices:
 
   Corsair HX850i
 
-  Corsair HX1000i (Series 2022 and Series 2023)
+  Corsair HX1000i (Series 2022 and 2023)
 
   Corsair HX1200i
 
-  Corsair HX1500i (Series 2022)
+  Corsair HX1500i (Series 2022 and 2023)
 
   Corsair RM550i
 
@@ -80,11 +80,14 @@ temp2_crit		Temperature max critical value of psu case
 Usage Notes
 -----------
 
-It is an USB HID device, so it is auto-detected and supports hot-swapping.
+It is an USB HID device, so it is auto-detected, supports hot-swapping and
+several devices at once.
 
 Flickering values in the rail voltage levels can be an indicator for a failing
-PSU. The driver also provides some additional useful values via debugfs, which
-do not fit into the hwmon class.
+PSU. Accordingly to the default automatic fan speed plan the fan starts at about
+30% of the wattage rating. If this does not happen, a fan failure is likely. The
+driver also provides some additional useful values via debugfs, which do not fit
+into the hwmon class.
 
 Debugfs entries
 ---------------
diff --git a/drivers/hwmon/corsair-psu.c b/drivers/hwmon/corsair-psu.c
index 9e3e3c0a3bdd..904890598c11 100644
--- a/drivers/hwmon/corsair-psu.c
+++ b/drivers/hwmon/corsair-psu.c
@@ -42,12 +42,15 @@
  *	- the driver supports debugfs for values not fitting into the hwmon class
  *	- not every device class (HXi or RMi) supports all commands
  *	- if configured wrong the PSU resets or shuts down, often before actually hitting the
- *	- reported critical temperature
+ *	  reported critical temperature
+ *	- new models like HX1500i Series 2023 have changes in the reported vendor and product
+ *	  strings, both are slightly longer now, report vendor and product in one string and are
+ *	  the same now
  */
 
 #define DRIVER_NAME		"corsair-psu"
 
-#define REPLY_SIZE		16 /* max length of a reply to a single command */
+#define REPLY_SIZE		24 /* max length of a reply to a single command */
 #define CMD_BUFFER_SIZE		64
 #define CMD_TIMEOUT_MS		250
 #define SECONDS_PER_HOUR	(60 * 60)
@@ -880,7 +883,7 @@ static const struct hid_device_id corsairpsu_idtable[] = {
 	{ HID_USB_DEVICE(0x1b1c, 0x1c0c) }, /* Corsair RM850i */
 	{ HID_USB_DEVICE(0x1b1c, 0x1c0d) }, /* Corsair RM1000i */
 	{ HID_USB_DEVICE(0x1b1c, 0x1c1e) }, /* Corsair HX1000i Series 2023 */
-	{ HID_USB_DEVICE(0x1b1c, 0x1c1f) }, /* Corsair HX1500i Series 2022 */
+	{ HID_USB_DEVICE(0x1b1c, 0x1c1f) }, /* Corsair HX1500i Series 2022 and 2023 */
 	{ },
 };
 MODULE_DEVICE_TABLE(hid, corsairpsu_idtable);
-- 
2.41.0

