Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5285D656971
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 11:25:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231603AbiL0KYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 05:24:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231611AbiL0KYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 05:24:20 -0500
Received: from smtpout1.mo528.mail-out.ovh.net (smtpout1.mo528.mail-out.ovh.net [46.105.34.251])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CC10A47A;
        Tue, 27 Dec 2022 02:24:14 -0800 (PST)
Received: from pro2.mail.ovh.net (unknown [10.108.1.71])
        by mo528.mail-out.ovh.net (Postfix) with ESMTPS id 6A908147C1BF8;
        Tue, 27 Dec 2022 11:07:07 +0100 (CET)
Received: from localhost.localdomain (88.161.25.233) by DAG1EX1.emp2.local
 (172.16.2.1) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16; Tue, 27 Dec
 2022 11:07:06 +0100
From:   Jean-Jacques Hiblot <jjhiblot@traphandler.com>
To:     <lee@kernel.org>, <pavel@ucw.cz>, <robh+dt@kernel.org>,
        <sven.schwermer@disruptive-technologies.com>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <johan+linaro@kernel.org>, <marijn.suijten@somainline.org>,
        <bjorn.andersson@linaro.org>, <andy.shevchenko@gmail.com>,
        <jacek.anaszewski@gmail.com>, <linux-leds@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jean-Jacques Hiblot <jjhiblot@traphandler.com>
Subject: [RESEND PATCH v6 4/6] leds: class: store the color index in struct led_classdev
Date:   Tue, 27 Dec 2022 11:06:57 +0100
Message-ID: <20221227100659.157071-5-jjhiblot@traphandler.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221227100659.157071-1-jjhiblot@traphandler.com>
References: <20221227100659.157071-1-jjhiblot@traphandler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [88.161.25.233]
X-ClientProxiedBy: DAG3EX1.emp2.local (172.16.2.21) To DAG1EX1.emp2.local
 (172.16.2.1)
X-Ovh-Tracer-Id: 14108370258890013147
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedriedtgdduudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhephffvvefufffkofgjfhgggfgtihesthekredtredttdenucfhrhhomheplfgvrghnqdflrggtqhhuvghsucfjihgslhhothcuoehjjhhhihgslhhothesthhrrghphhgrnhgulhgvrhdrtghomheqnecuggftrfgrthhtvghrnhepudetveelveevgffgvdeuffffjefhheehueeitdegtdejgefhheeuuddugeeffeeunecukfhppeduvdejrddtrddtrddupdekkedrudeiuddrvdehrddvfeefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpeeojhhjhhhisghlohhtsehtrhgrphhhrghnughlvghrrdgtohhmqedpnhgspghrtghpthhtohepuddprhgtphhtthhopehlvggvsehkvghrnhgvlhdrohhrghdpphgrvhgvlhesuhgtfidrtgiipdhrohgshhdoughtsehkvghrnhgvlhdrohhrghdpshhvvghnrdhstghhfigvrhhmvghrseguihhsrhhuphhtihhvvgdqthgvtghhnhholhhoghhivghsrdgtohhmpdhkrhiihihsiihtohhfrdhkohiilhhofihskhhiodgutheslhhinhgrrhhordhorhhgpdhjohhhrghnodhlihhnrghroheskhgvrhhnvghlrdhorhhgpdhmrghrihhjnhdrshhuihhjthgvnhesshhomhgrihhnlhhinhgvrd
 horhhgpdgsjhhorhhnrdgrnhguvghrshhsohhnsehlihhnrghrohdrohhrghdprghnugihrdhshhgvvhgthhgvnhhkohesghhmrghilhdrtghomhdpjhgrtggvkhdrrghnrghsiigvfihskhhisehgmhgrihhlrdgtohhmpdhlihhnuhigqdhlvggushesvhhgvghrrdhkvghrnhgvlhdrohhrghdpuggvvhhitggvthhrvggvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhohedvkedpmhhouggvpehsmhhtphhouhht
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_NONE,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
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
index 2e24ac3bd7ef..6f38edd69d2a 100644
--- a/Documentation/ABI/testing/sysfs-class-led
+++ b/Documentation/ABI/testing/sysfs-class-led
@@ -59,6 +59,15 @@ Description:
 		brightness. Reading this file when no hw brightness change
 		event has happened will return an ENODATA error.
 
+What:		/sys/class/leds/<led>/color
+Date:		Dec 2022
+KernelVersion:	6.2
+Description:
+		Color of the led.
+
+		This is a read-only file. Reading this file returns the color
+		of the led as a string (ex: "red", "green").
+
 What:		/sys/class/leds/<led>/trigger
 Date:		March 2006
 KernelVersion:	2.6.17
diff --git a/drivers/leds/led-class.c b/drivers/leds/led-class.c
index 9cddcd908bce..4432e85a5fc6 100644
--- a/drivers/leds/led-class.c
+++ b/drivers/leds/led-class.c
@@ -74,6 +74,18 @@ static ssize_t max_brightness_show(struct device *dev,
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
@@ -88,6 +100,7 @@ static const struct attribute_group led_trigger_group = {
 static struct attribute *led_class_attrs[] = {
 	&dev_attr_brightness.attr,
 	&dev_attr_max_brightness.attr,
+	&dev_attr_color.attr,
 	NULL,
 };
 
@@ -375,6 +388,10 @@ int led_classdev_register_ext(struct device *parent,
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
@@ -384,6 +401,9 @@ int led_classdev_register_ext(struct device *parent,
 	if (ret < 0)
 		return ret;
 
+	if (led_cdev->color >= LED_COLOR_ID_MAX)
+		dev_warn(parent, "LED %s color identifier out of range\n", final_name);
+
 	mutex_init(&led_cdev->led_access);
 	mutex_lock(&led_cdev->led_access);
 	led_cdev->dev = device_create_with_groups(leds_class, parent, 0,
diff --git a/include/linux/leds.h b/include/linux/leds.h
index 41df18f42d00..9d38cb90331d 100644
--- a/include/linux/leds.h
+++ b/include/linux/leds.h
@@ -71,6 +71,7 @@ struct led_classdev {
 	const char		*name;
 	unsigned int brightness;
 	unsigned int max_brightness;
+	unsigned int color;
 	int			 flags;
 
 	/* Lower 16 bits reflect status */
-- 
2.25.1

