Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B06C073B8DF
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 15:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbjFWNgg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 09:36:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbjFWNge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 09:36:34 -0400
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E059D2130
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 06:36:32 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 8B173240101
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 15:36:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1687527390; bh=HEsqMhFRDkwmdAjCfvjXucvtqzCC+HB2ZMDR5SjPs/Y=;
        h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:
         Content-Disposition:From;
        b=RvWrRRgls+9oQjfasr9n6K3i4ml7ebJvkAwgNUCloKRPtW/G8UliG7I4uZDBy3xKZ
         gaLUTkNfRQfy4kh1OQWMhe85Twk4RgqfEkr6KIi1/PE2BxkgIW2dhaP4lP9gVXR8e7
         l5HY4/20Klqvk3vY0/09ErSQjwsv/NSPol158f58EMps44pcF/d3A9Wv8I9CTYKBnq
         wQTVlrYl6qU9+oMF6F4KWn2szR5HS46eCy3xGUHgWV9rSU9OdNsWHtefn3Fw6o4tRz
         bPhMtsm+PZBD1MP5S7my65QIZewJhzf/bi90NiGYg+4LMI/skeSZymYJP9qC+thyqa
         GszWQC3aklcLw==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4QndYn441yz6tvr;
        Fri, 23 Jun 2023 15:36:29 +0200 (CEST)
Date:   Fri, 23 Jun 2023 13:36:28 +0000
From:   Wilken Gottwalt <wilken.gottwalt@posteo.net>
To:     linux-kernel@vger.kernel.org
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org
Subject: [PATCH] hwmon: corsair-psu: various cleanups
Message-ID: <ZJWf3H972hGgLK-8@monster.localdomain>
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

Fix some typos, adjust documentation and comments to current state of
knowledge and update coding style to be more uniform.

Signed-off-by: Wilken Gottwalt <wilken.gottwalt@posteo.net>
---
 Documentation/hwmon/corsair-psu.rst |  4 ++--
 drivers/hwmon/corsair-psu.c         | 23 +++++++++++------------
 2 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/Documentation/hwmon/corsair-psu.rst b/Documentation/hwmon/corsair-psu.rst
index fc798c3df1d0..47f8ff632267 100644
--- a/Documentation/hwmon/corsair-psu.rst
+++ b/Documentation/hwmon/corsair-psu.rst
@@ -15,11 +15,11 @@ Supported devices:
 
   Corsair HX850i
 
-  Corsair HX1000i (revision 1 and 2)
+  Corsair HX1000i (Series 2022 and Series 2023)
 
   Corsair HX1200i
 
-  Corsair HX1500i
+  Corsair HX1500i (Series 2022)
 
   Corsair RM550i
 
diff --git a/drivers/hwmon/corsair-psu.c b/drivers/hwmon/corsair-psu.c
index 2389f605ca16..9e3e3c0a3bdd 100644
--- a/drivers/hwmon/corsair-psu.c
+++ b/drivers/hwmon/corsair-psu.c
@@ -32,18 +32,17 @@
  *	  but it is better to not rely on this (it is also hard to parse)
  *	- the driver uses raw events to be accessible from userspace (though this is not really
  *	  supported, it is just there for convenience, may be removed in the future)
- *	- a reply always start with the length and command in the same order the request used it
+ *	- a reply always starts with the length and command in the same order the request used it
  *	- length of the reply data is specific to the command used
  *	- some of the commands work on a rail and can be switched to a specific rail (0 = 12v,
  *	  1 = 5v, 2 = 3.3v)
  *	- the format of the init command 0xFE is swapped length/command bytes
  *	- parameter bytes amount and values are specific to the command (rail setting is the only
- *	  for now that uses non-zero values)
- *	- there are much more commands, especially for configuring the device, but they are not
- *	  supported because a wrong command/length can lockup the micro-controller
+ *	  one for now that uses non-zero values)
  *	- the driver supports debugfs for values not fitting into the hwmon class
- *	- not every device class (HXi, RMi or AXi) supports all commands
- *	- it is a pure sensors reading driver (will not support configuring)
+ *	- not every device class (HXi or RMi) supports all commands
+ *	- if configured wrong the PSU resets or shuts down, often before actually hitting the
+ *	- reported critical temperature
  */
 
 #define DRIVER_NAME		"corsair-psu"
@@ -254,8 +253,8 @@ static int corsairpsu_get_value(struct corsairpsu_data *priv, u8 cmd, u8 rail, l
 	/*
 	 * the biggest value here comes from the uptime command and to exceed MAXINT total uptime
 	 * needs to be about 68 years, the rest are u16 values and the biggest value coming out of
-	 * the LINEAR11 conversion are the watts values which are about 1200 for the strongest psu
-	 * supported (HX1200i)
+	 * the LINEAR11 conversion are the watts values which are about 1500 for the strongest psu
+	 * supported (HX1500i)
 	 */
 	tmp = ((long)data[3] << 24) + (data[2] << 16) + (data[1] << 8) + data[0];
 	switch (cmd) {
@@ -629,7 +628,7 @@ static const struct hwmon_ops corsairpsu_hwmon_ops = {
 	.read_string	= corsairpsu_hwmon_ops_read_string,
 };
 
-static const struct hwmon_channel_info * const corsairpsu_info[] = {
+static const struct hwmon_channel_info *const corsairpsu_info[] = {
 	HWMON_CHANNEL_INFO(chip,
 			   HWMON_C_REGISTER_TZ),
 	HWMON_CHANNEL_INFO(temp,
@@ -873,15 +872,15 @@ static const struct hid_device_id corsairpsu_idtable[] = {
 	{ HID_USB_DEVICE(0x1b1c, 0x1c04) }, /* Corsair HX650i */
 	{ HID_USB_DEVICE(0x1b1c, 0x1c05) }, /* Corsair HX750i */
 	{ HID_USB_DEVICE(0x1b1c, 0x1c06) }, /* Corsair HX850i */
-	{ HID_USB_DEVICE(0x1b1c, 0x1c07) }, /* Corsair HX1000i revision 1 */
+	{ HID_USB_DEVICE(0x1b1c, 0x1c07) }, /* Corsair HX1000i Series 2022 */
 	{ HID_USB_DEVICE(0x1b1c, 0x1c08) }, /* Corsair HX1200i */
 	{ HID_USB_DEVICE(0x1b1c, 0x1c09) }, /* Corsair RM550i */
 	{ HID_USB_DEVICE(0x1b1c, 0x1c0a) }, /* Corsair RM650i */
 	{ HID_USB_DEVICE(0x1b1c, 0x1c0b) }, /* Corsair RM750i */
 	{ HID_USB_DEVICE(0x1b1c, 0x1c0c) }, /* Corsair RM850i */
 	{ HID_USB_DEVICE(0x1b1c, 0x1c0d) }, /* Corsair RM1000i */
-	{ HID_USB_DEVICE(0x1b1c, 0x1c1e) }, /* Corsair HX1000i revision 2 */
-	{ HID_USB_DEVICE(0x1b1c, 0x1c1f) }, /* Corsair HX1500i */
+	{ HID_USB_DEVICE(0x1b1c, 0x1c1e) }, /* Corsair HX1000i Series 2023 */
+	{ HID_USB_DEVICE(0x1b1c, 0x1c1f) }, /* Corsair HX1500i Series 2022 */
 	{ },
 };
 MODULE_DEVICE_TABLE(hid, corsairpsu_idtable);
-- 
2.41.0

