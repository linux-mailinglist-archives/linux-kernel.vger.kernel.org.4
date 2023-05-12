Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5D446FFDDB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 02:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239576AbjELASo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 20:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239666AbjELAS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 20:18:28 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDBDF659C;
        Thu, 11 May 2023 17:18:26 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1ab14cb3aaeso66502695ad.2;
        Thu, 11 May 2023 17:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683850706; x=1686442706;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3AmXM8Nw8W3m9nSsQzdTt/ndXawpxM/cZvvmq+1bgsw=;
        b=N//IhBz+EmhD39v50VoSAPlobOMAQXxtUUG3ZsdVDvpKN6l3oy13UoDq/pJK3Jb/wD
         KJ57Tbx5eU+e7jxiToWi0H1Dds646XbRuQcit4lNmtpHcZ6W8xDYMWjAVZVRKScXMnzq
         oYe6fiDie0HQeqjKh4YKTcx/wW9jFVFOFYVfImcZwt+nwphAJhEhPhZ8CU+F62iVA33H
         TODGQY9XUQWv3pnMDxIpkpr+/sjh9HqEEHg0BA5btATBx68EBtmy1tG3slz+HXfxpxxU
         XyZKSHGjt4q1/tYogzpGqClkEhEtWAqJYg5QcByW83VyndehMop0Lb8sc/EDpkrl72hp
         BMrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683850706; x=1686442706;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3AmXM8Nw8W3m9nSsQzdTt/ndXawpxM/cZvvmq+1bgsw=;
        b=iOdEg0kNPxeZesXgxKUw0aFj3oqywW1gcB8a4zlAc6tJDMLxHowtK2uPPpF4Nks2SO
         y5TEZymuaFIN9LFhqW+U5vg76piUBgQTTjo1GZ4jxSV0sigma8tHjAgQiQdiNXHMz0yO
         u76Y1nKkZ5yPFc9sBuvpbSdPxl3QK7Fw0oZ6pFXy+Nj8oD9MJp2Bxe6qxaU1PTbORVXX
         0Fjk6DfjXweLFygxCXJeCQu9myhuEcvzqWZ5f04Kn+AjeMHAqEED2QFG9R0tXmlhenTw
         S48FO7QxPD6u//7pBB4vYAnkwjt7XH0JuIORuloDDAUV9TKk5aoJeOWNjyoMZFNbMBTP
         6hYg==
X-Gm-Message-State: AC+VfDzUf8sBjByJ84c9D3vQrd+rI09A6nZZ2k4nO3z39m68J3HYeP1e
        3dNc/ZBRNeP3M9Gw9O/iVARfqUp0Eaw=
X-Google-Smtp-Source: ACHHUZ5xtmMPSMy3URma36O7T3rcQKVbBtifE7t1Kmfw83Aufka+zoMwzYmUfd4dJqSxRv2sfokSEw==
X-Received: by 2002:a17:902:a417:b0:19e:e001:6a75 with SMTP id p23-20020a170902a41700b0019ee0016a75mr1472763plq.6.1683850706224;
        Thu, 11 May 2023 17:18:26 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:53f7:c9da:338e:6206])
        by smtp.gmail.com with ESMTPSA id q16-20020a170902b11000b001ab016ea3f9sm6537409plr.21.2023.05.11.17.18.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 17:18:25 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] platform/x86: x86-android-tablets: convert gpio_keys devices to GPIO references
Date:   Thu, 11 May 2023 17:18:13 -0700
Message-ID: <20230512001815.591817-5-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
In-Reply-To: <20230512001815.591817-1-dmitry.torokhov@gmail.com>
References: <20230512001815.591817-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that gpiolib supports software nodes to describe GPIOs, switch the
driver away from using GPIO lookup tables for wm1502 devices to using
PROPERTY_ENTRY_GPIO().

With that we can remove support for gpiod_lookup_tables from the driver.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/platform/x86/x86-android-tablets.c | 117 ++++++++++++---------
 1 file changed, 69 insertions(+), 48 deletions(-)

diff --git a/drivers/platform/x86/x86-android-tablets.c b/drivers/platform/x86/x86-android-tablets.c
index 02ee793a934e..878b2b72d214 100644
--- a/drivers/platform/x86/x86-android-tablets.c
+++ b/drivers/platform/x86/x86-android-tablets.c
@@ -16,7 +16,6 @@
 #include <linux/gpio_keys.h>
 #include <linux/gpio/consumer.h>
 #include <linux/gpio/driver.h>
-#include <linux/gpio/machine.h>
 #include <linux/gpio/property.h>
 #include <linux/i2c.h>
 #include <linux/input.h>
@@ -29,6 +28,7 @@
 #include <linux/platform_data/lp855x.h>
 #include <linux/platform_device.h>
 #include <linux/power/bq24190_charger.h>
+#include <linux/property.h>
 #include <linux/reboot.h>
 #include <linux/rmi.h>
 #include <linux/serdev.h>
@@ -174,7 +174,6 @@ struct x86_dev_info {
 	char *invalid_aei_gpiochip;
 	const char * const *modules;
 	const struct software_node *bat_swnode;
-	struct gpiod_lookup_table * const *gpiod_lookup_tables;
 	const struct x86_i2c_client_info *i2c_client_info;
 	const struct platform_device_info *pdev_info;
 	const struct x86_serdev_info *serdev_info;
@@ -269,79 +268,102 @@ static const char * const bq24190_modules[] __initconst = {
  * which is not described in the ACPI tables in anyway.
  * Use the x86-android-tablets infra to create a gpio-button device for this.
  */
-static struct gpio_keys_button advantech_mica_071_button = {
-	.code = KEY_PROG1,
-	/* .gpio gets filled in by advantech_mica_071_init() */
-	.active_low = true,
-	.desc = "prog1_key",
-	.type = EV_KEY,
-	.wakeup = false,
-	.debounce_interval = 50,
-};
-
-static const struct gpio_keys_platform_data advantech_mica_071_button_pdata __initconst = {
-	.buttons = &advantech_mica_071_button,
-	.nbuttons = 1,
+static const struct software_node advantech_mica_071_gpio_keys_node = {
 	.name = "prog1_key",
 };
 
-static const struct platform_device_info advantech_mica_071_pdevs[] __initconst = {
+static const struct property_entry advantech_mica_071_prog1_key_props[] = {
+	PROPERTY_ENTRY_U32("linux,code", KEY_PROG1),
+	PROPERTY_ENTRY_STRING("label", "prog1_key"),
+	PROPERTY_ENTRY_GPIO("gpios",
+			    &int33fc_gpiochip_nodes[0], 2, GPIO_ACTIVE_LOW),
+	PROPERTY_ENTRY_U32("debounce-interval", 50),
+	{ }
+};
+
+static const struct software_node advantech_mica_071_prog1_key_node = {
+	.parent = &advantech_mica_071_gpio_keys_node,
+	.properties = advantech_mica_071_prog1_key_props,
+};
+
+static const struct software_node *advantech_mica_071_swnodes[] = {
+	&advantech_mica_071_gpio_keys_node,
+	&advantech_mica_071_prog1_key_node,
+	NULL
+};
+
+static struct platform_device_info advantech_mica_071_pdevs[] = {
 	{
 		.name = "gpio-keys",
 		.id = PLATFORM_DEVID_AUTO,
-		.data = &advantech_mica_071_button_pdata,
-		.size_data = sizeof(advantech_mica_071_button_pdata),
+		/* .fwnode will be filled by advantech_mica_071_init() */
 	},
 };
 
 static int __init advantech_mica_071_init(void)
 {
-	struct gpio_desc *gpiod;
 	int ret;
 
-	ret = x86_android_tablet_get_gpiod("INT33FC:00", 2, &gpiod);
+	ret = software_node_register_node_group(advantech_mica_071_swnodes);
 	if (ret < 0)
 		return ret;
-	advantech_mica_071_button.gpio = desc_to_gpio(gpiod);
+
+	advantech_mica_071_pdevs[0].fwnode =
+			software_node_fwnode(advantech_mica_071_swnodes[0]);
 
 	return 0;
 }
 
+static void __exit advantech_mica_071_exit(void)
+{
+	software_node_unregister_node_group(advantech_mica_071_swnodes);
+}
+
 static const struct x86_dev_info advantech_mica_071_info __initconst = {
 	.pdev_info = advantech_mica_071_pdevs,
 	.pdev_count = ARRAY_SIZE(advantech_mica_071_pdevs),
 	.init = advantech_mica_071_init,
+	.exit = advantech_mica_071_exit,
 };
 
 /* Asus ME176C and TF103C tablets shared data */
-static struct gpio_keys_button asus_me176c_tf103c_lid = {
-	.code = SW_LID,
-	/* .gpio gets filled in by asus_me176c_tf103c_init() */
-	.active_low = true,
-	.desc = "lid_sw",
-	.type = EV_SW,
-	.wakeup = true,
-	.debounce_interval = 50,
-};
-
-static const struct gpio_keys_platform_data asus_me176c_tf103c_lid_pdata __initconst = {
-	.buttons = &asus_me176c_tf103c_lid,
-	.nbuttons = 1,
+static const struct software_node asus_me176c_tf103c_gpio_keys_node = {
 	.name = "lid_sw",
 };
 
+static const struct property_entry asus_me176c_tf103c_lid_props[] = {
+	PROPERTY_ENTRY_U32("linux,input-type", EV_SW),
+	PROPERTY_ENTRY_U32("linux,code", SW_LID),
+	PROPERTY_ENTRY_STRING("label", "lid_sw"),
+	PROPERTY_ENTRY_GPIO("gpios",
+			    &int33fc_gpiochip_nodes[2], 2, GPIO_ACTIVE_LOW),
+	PROPERTY_ENTRY_U32("debounce-interval", 50),
+	PROPERTY_ENTRY_BOOL("wakeup-source"),
+	{ }
+};
+
+static const struct software_node asus_me176c_tf103c_lid_node = {
+	.parent = &asus_me176c_tf103c_gpio_keys_node,
+	.properties = asus_me176c_tf103c_lid_props,
+};
+
+static const struct software_node *asus_me176c_tf103c_lid_swnodes[] = {
+	&asus_me176c_tf103c_gpio_keys_node,
+	&asus_me176c_tf103c_lid_node,
+	NULL
+};
+
 static const struct property_entry asus_me176c_tf103c_int3496_props[] = {
 	PROPERTY_ENTRY_GPIO("id-gpios",
 			    &int33fc_gpiochip_nodes[2], 22, GPIO_ACTIVE_HIGH),
 	{ }
 };
 
-static const struct platform_device_info asus_me176c_tf103c_pdevs[] __initconst = {
+static struct platform_device_info asus_me176c_tf103c_pdevs[] = {
 	{
 		.name = "gpio-keys",
 		.id = PLATFORM_DEVID_AUTO,
-		.data = &asus_me176c_tf103c_lid_pdata,
-		.size_data = sizeof(asus_me176c_tf103c_lid_pdata),
+		/* .fwnode will be filled by asus_me176c_tf103c_init() */
 	},
 	{
 		/* For micro USB ID pin handling */
@@ -353,17 +375,22 @@ static const struct platform_device_info asus_me176c_tf103c_pdevs[] __initconst
 
 static int __init asus_me176c_tf103c_init(void)
 {
-	struct gpio_desc *gpiod;
 	int ret;
 
-	ret = x86_android_tablet_get_gpiod("INT33FC:02", 12, &gpiod);
+	ret = software_node_register_node_group(asus_me176c_tf103c_lid_swnodes);
 	if (ret < 0)
 		return ret;
-	asus_me176c_tf103c_lid.gpio = desc_to_gpio(gpiod);
+
+	asus_me176c_tf103c_pdevs[0].fwnode =
+			software_node_fwnode(asus_me176c_tf103c_lid_swnodes[0]);
 
 	return 0;
 }
 
+static void __exit asus_me176c_tf103c_exit(void)
+{
+	software_node_unregister_node_group(asus_me176c_tf103c_lid_swnodes);
+}
 
 /* Asus ME176C tablets have an Android factory img with everything hardcoded */
 static const char * const asus_me176c_accel_mount_matrix[] = {
@@ -504,6 +531,7 @@ static const struct x86_dev_info asus_me176c_info __initconst = {
 	.modules = bq24190_modules,
 	.invalid_aei_gpiochip = "INT33FC:02",
 	.init = asus_me176c_tf103c_init,
+	.exit = asus_me176c_tf103c_exit,
 };
 
 /* Asus TF103C tablets have an Android factory img with everything hardcoded */
@@ -641,6 +669,7 @@ static const struct x86_dev_info asus_tf103c_info __initconst = {
 	.modules = bq24190_modules,
 	.invalid_aei_gpiochip = "INT33FC:02",
 	.init = asus_me176c_tf103c_init,
+	.exit = asus_me176c_tf103c_exit,
 };
 
 /*
@@ -1583,7 +1612,6 @@ static int serdev_count;
 static struct i2c_client **i2c_clients;
 static struct platform_device **pdevs;
 static struct serdev_device **serdevs;
-static struct gpiod_lookup_table * const *gpiod_lookup_tables;
 static const struct software_node *bat_swnode;
 static void (*exit_handler)(void);
 
@@ -1706,9 +1734,6 @@ static void x86_android_tablet_cleanup(void)
 	if (exit_handler)
 		exit_handler();
 
-	for (i = 0; gpiod_lookup_tables && gpiod_lookup_tables[i]; i++)
-		gpiod_remove_lookup_table(gpiod_lookup_tables[i]);
-
 	software_node_unregister(bat_swnode);
 	software_node_unregister_node_group(int33fc_gpiochip_node_group);
 }
@@ -1760,10 +1785,6 @@ static __init int x86_android_tablet_init(void)
 		}
 	}
 
-	gpiod_lookup_tables = dev_info->gpiod_lookup_tables;
-	for (i = 0; gpiod_lookup_tables && gpiod_lookup_tables[i]; i++)
-		gpiod_add_lookup_table(gpiod_lookup_tables[i]);
-
 	if (dev_info->init) {
 		ret = dev_info->init();
 		if (ret < 0) {
-- 
2.40.1.606.ga4b1b128d6-goog

