Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 211F6732D34
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 12:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244891AbjFPKQc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 06:16:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245214AbjFPKQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 06:16:17 -0400
X-Greylist: delayed 613 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 16 Jun 2023 03:16:15 PDT
Received: from 5.mo563.mail-out.ovh.net (5.mo563.mail-out.ovh.net [46.105.53.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 551D730C7
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 03:16:15 -0700 (PDT)
Received: from director3.derp.mail-out.ovh.net (director3.derp.mail-out.ovh.net [152.228.215.222])
        by mo563.mail-out.ovh.net (Postfix) with ESMTPS id BFF98239AA;
        Fri, 16 Jun 2023 09:57:55 +0000 (UTC)
Received: from director3.derp.mail-out.ovh.net (director3.derp.mail-out.ovh.net. [127.0.0.1])
        by director3.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
        for <conor+dt@kernel.org>; Fri, 16 Jun 2023 09:57:55 +0000 (UTC)
Received: from pro2.mail.ovh.net (unknown [10.108.16.74])
        by director3.derp.mail-out.ovh.net (Postfix) with ESMTPS id 93AC7107971;
        Fri, 16 Jun 2023 09:57:55 +0000 (UTC)
Received: from traphandler.com (88.161.25.233) by DAG1EX1.emp2.local
 (172.16.2.1) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 16 Jun
 2023 11:57:55 +0200
From:   Jean-Jacques Hiblot <jjhiblot@traphandler.com>
To:     <lee@kernel.org>, <pavel@ucw.cz>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC:     <linux-leds@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Jean-Jacques Hiblot <jjhiblot@traphandler.com>
Subject: [PATCH v9 3/5] leds: class: store the color index in struct led_classdev
Date:   Fri, 16 Jun 2023 11:57:44 +0200
Message-ID: <20230616095746.872220-4-jjhiblot@traphandler.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230616095746.872220-1-jjhiblot@traphandler.com>
References: <20230616095746.872220-1-jjhiblot@traphandler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [88.161.25.233]
X-ClientProxiedBy: CAS3.emp2.local (172.16.1.3) To DAG1EX1.emp2.local
 (172.16.2.1)
X-Ovh-Tracer-Id: 3612731329022540251
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedrgedvgedgvddvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucenucfjughrpefhvfevufffkffojghfggfgtghisehtkeertdertddtnecuhfhrohhmpeflvggrnhdqlfgrtghquhgvshcujfhisghlohhtuceojhhjhhhisghlohhtsehtrhgrphhhrghnughlvghrrdgtohhmqeenucggtffrrghtthgvrhhnpeduteevleevvefggfdvueffffejhfehheeuiedtgedtjeeghfehueduudegfeefueenucfkpheptddrtddrtddrtddpkeekrdduiedurddvhedrvdeffeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphhouhhtpdhhvghlohepughirhgvtghtohhrfedruggvrhhprdhmrghilhdqohhuthdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepjhhjhhhisghlohhtsehtrhgrphhhrghnughlvghrrdgtohhmpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqlhgvughssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdfovfetjfhoshhtpehmohehieef
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This information might be useful for more than only deriving the led's
name. And since we have this information, we can expose it in the sysfs.

Signed-off-by: Jean-Jacques Hiblot <jjhiblot@traphandler.com>
---
 Documentation/ABI/testing/sysfs-class-led |  9 +++++++++
 drivers/leds/led-class.c                  | 20 ++++++++++++++++++++
 include/linux/leds.h                      |  1 +
 3 files changed, 30 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-led b/Documentation/ABI/testing/sysfs-class-led
index 2e24ac3bd7ef..1509e71fcde1 100644
--- a/Documentation/ABI/testing/sysfs-class-led
+++ b/Documentation/ABI/testing/sysfs-class-led
@@ -59,6 +59,15 @@ Description:
 		brightness. Reading this file when no hw brightness change
 		event has happened will return an ENODATA error.
 
+What:		/sys/class/leds/<led>/color
+Date:		June 2023
+KernelVersion:	6.5
+Description:
+		Color of the led.
+
+		This is a read-only file. Reading this file returns the color
+		of the led as a string (ex: "red", "green", "multicolor").
+
 What:		/sys/class/leds/<led>/trigger
 Date:		March 2006
 KernelVersion:	2.6.17
diff --git a/drivers/leds/led-class.c b/drivers/leds/led-class.c
index eb1a8494dc5b..6cca21b227dd 100644
--- a/drivers/leds/led-class.c
+++ b/drivers/leds/led-class.c
@@ -76,6 +76,18 @@ static ssize_t max_brightness_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(max_brightness);
 
+static ssize_t color_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	const char *color_text = "invalid";
+	struct led_classdev *led_cdev = dev_get_drvdata(dev);
+
+	if (led_cdev->color < LED_COLOR_ID_MAX)
+		color_text = led_colors[led_cdev->color];
+	return sysfs_emit(buf, "%s\n", color_text);
+}
+static DEVICE_ATTR_RO(color);
+
 #ifdef CONFIG_LEDS_TRIGGERS
 static BIN_ATTR(trigger, 0644, led_trigger_read, led_trigger_write, 0);
 static struct bin_attribute *led_trigger_bin_attrs[] = {
@@ -90,6 +102,7 @@ static const struct attribute_group led_trigger_group = {
 static struct attribute *led_class_attrs[] = {
 	&dev_attr_brightness.attr,
 	&dev_attr_max_brightness.attr,
+	&dev_attr_color.attr,
 	NULL,
 };
 
@@ -482,6 +495,10 @@ int led_classdev_register_ext(struct device *parent,
 			if (fwnode_property_present(init_data->fwnode,
 						    "retain-state-shutdown"))
 				led_cdev->flags |= LED_RETAIN_AT_SHUTDOWN;
+
+			if (fwnode_property_present(init_data->fwnode, "color"))
+				fwnode_property_read_u32(init_data->fwnode, "color",
+							 &led_cdev->color);
 		}
 	} else {
 		proposed_name = led_cdev->name;
@@ -491,6 +508,9 @@ int led_classdev_register_ext(struct device *parent,
 	if (ret < 0)
 		return ret;
 
+	if (led_cdev->color >= LED_COLOR_ID_MAX)
+		dev_warn(parent, "LED %s color identifier out of range\n", final_name);
+
 	mutex_init(&led_cdev->led_access);
 	mutex_lock(&led_cdev->led_access);
 	led_cdev->dev = device_create_with_groups(leds_class, parent, 0,
diff --git a/include/linux/leds.h b/include/linux/leds.h
index 95311c70d95c..487d00dac4de 100644
--- a/include/linux/leds.h
+++ b/include/linux/leds.h
@@ -100,6 +100,7 @@ struct led_classdev {
 	const char		*name;
 	unsigned int brightness;
 	unsigned int max_brightness;
+	unsigned int color;
 	int			 flags;
 
 	/* Lower 16 bits reflect status */
-- 
2.34.1

