Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 437986FFDD6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 02:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239655AbjELAS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 20:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239645AbjELASX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 20:18:23 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 193CC271B;
        Thu, 11 May 2023 17:18:22 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1a516fb6523so87212105ad.3;
        Thu, 11 May 2023 17:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683850701; x=1686442701;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZSh/lXvb2BHOKjtlsYRwrKg7nsMqHP1guOfcjbIyJo4=;
        b=m5LAPYtMaTacicx1wH22dagQggM2vRyzfk4W7wHsM2VO+g6neVLBgdswtfELFHIf1O
         FEQBqtDnwlmM058+G6Q7GNJFwpB9zpJ66LijVVWKHLW0tJOMNKZWnVX9UO2Q3dt7KyXI
         PV23kv9aIrsXO65Vf2J3L33BCR0ToPl98uh/q/508QY88paoYvp/6lfd8oEFG2ODoMUo
         xHxfVtRwAf1xSYnBMCu4mzA/ClrDSCe4IFgSYeGErgf1DYF/0/wrOPQ1lbwQPAekElm0
         WKE/+NwB73uVxTGIhMfrFxSt3EvvWVW7ssQu3cN48M4oCrtkHNS+ejt8yC2a5F094lh3
         H9Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683850701; x=1686442701;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZSh/lXvb2BHOKjtlsYRwrKg7nsMqHP1guOfcjbIyJo4=;
        b=bLvIt4USXfh1lMhSqaDWfwdLyCD3HDNl6YezWhsKjENH26QDEezYpxn7mXnc3rKVpE
         8Pr4QmPayYLnyiDIWec+SU0afpp22fG0+2xYCUwcKGM9bngWaPv67YCO6kxRPWZYBHXU
         wKitJ29Z5xN5tNYaTuic1o+sYx2q8Bc1oQgWusbeyz7a7z8Zjy4pYRQc9pVcZIk58N4Z
         BpdhZgWX/Y4AFMWN/mNcVpqZFmyzLGM0kK6JxqhgRY7qFOsWIIR9oETsSAPowYI7V10V
         gOop3ybxRlMiWufgJx+nt/yHju3KpAzKanAeEkyl9ZfDq/ZKWQmdwVAR/0SerwJBp9s6
         PtcA==
X-Gm-Message-State: AC+VfDzm/WGqK8X+KxoEOiXW9AKejZM0EV3DKpcRmXHAoIMvIk2nW9aG
        jPxAmV0DZkA2PN7Bg8NwiLI=
X-Google-Smtp-Source: ACHHUZ6KrrA3tLuygfX3aqerlImOOJGXUMHkUJsO/15i590rpZRr1BlhfnpDbvmEt4UqOcy8eHVdyg==
X-Received: by 2002:a17:903:48e:b0:1ab:15c2:e2fb with SMTP id jj14-20020a170903048e00b001ab15c2e2fbmr21727896plb.9.1683850701121;
        Thu, 11 May 2023 17:18:21 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:53f7:c9da:338e:6206])
        by smtp.gmail.com with ESMTPSA id q16-20020a170902b11000b001ab016ea3f9sm6537409plr.21.2023.05.11.17.18.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 17:18:20 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] platform/x86: x86-android-tablets: convert Goodix devices to GPIO references
Date:   Thu, 11 May 2023 17:18:10 -0700
Message-ID: <20230512001815.591817-2-dmitry.torokhov@gmail.com>
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
driver away from using GPIO lookup tables for Goodex touchscreens to using
PROPERTY_ENTRY_GPIO() to keep all touchscreen properties together.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/platform/x86/x86-android-tablets.c | 85 +++++++++++-----------
 1 file changed, 44 insertions(+), 41 deletions(-)

diff --git a/drivers/platform/x86/x86-android-tablets.c b/drivers/platform/x86/x86-android-tablets.c
index 111b007656fc..e187fb66b6d7 100644
--- a/drivers/platform/x86/x86-android-tablets.c
+++ b/drivers/platform/x86/x86-android-tablets.c
@@ -17,6 +17,7 @@
 #include <linux/gpio/consumer.h>
 #include <linux/gpio/driver.h>
 #include <linux/gpio/machine.h>
+#include <linux/gpio/property.h>
 #include <linux/i2c.h>
 #include <linux/input.h>
 #include <linux/irq.h>
@@ -184,6 +185,20 @@ struct x86_dev_info {
 	void (*exit)(void);
 };
 
+/* Software nodes representing GPIO chips used by varios devices below */
+static const struct software_node int33fc_gpiochip_nodes[] = {
+	{ .name = "INT33FC:00" },
+	{ .name = "INT33FC:01" },
+	{ .name = "INT33FC:02" },
+};
+
+static const struct software_node *int33fc_gpiochip_node_group[] = {
+	&int33fc_gpiochip_nodes[0],
+	&int33fc_gpiochip_nodes[1],
+	&int33fc_gpiochip_nodes[2],
+	NULL
+};
+
 /* Generic / shared charger / battery settings */
 static const char * const tusb1211_chg_det_psy[] = { "tusb1211-charger-detect" };
 static const char * const bq24190_psy[] = { "bq24190-charger" };
@@ -400,6 +415,18 @@ static const struct software_node asus_me176c_ug3105_node = {
 	.properties = asus_me176c_ug3105_props,
 };
 
+static const struct property_entry asus_me176c_touchscreen_props[] = {
+	PROPERTY_ENTRY_GPIO("reset-gpios",
+			    &int33fc_gpiochip_nodes[0], 60, GPIO_ACTIVE_HIGH),
+	PROPERTY_ENTRY_GPIO("irq-gpios",
+			    &int33fc_gpiochip_nodes[2], 28, GPIO_ACTIVE_HIGH),
+	{ }
+};
+
+static const struct software_node asus_me176c_touchscreen_node = {
+	.properties = asus_me176c_touchscreen_props,
+};
+
 static const struct x86_i2c_client_info asus_me176c_i2c_clients[] __initconst = {
 	{
 		/* bq24297 battery charger */
@@ -455,6 +482,7 @@ static const struct x86_i2c_client_info asus_me176c_i2c_clients[] __initconst =
 			.type = "GDIX1001:00",
 			.addr = 0x14,
 			.dev_name = "goodix_ts",
+			.swnode = &asus_me176c_touchscreen_node,
 		},
 		.adapter_path = "\\_SB_.I2C6",
 		.irq_data = {
@@ -475,18 +503,8 @@ static const struct x86_serdev_info asus_me176c_serdevs[] __initconst = {
 	},
 };
 
-static struct gpiod_lookup_table asus_me176c_goodix_gpios = {
-	.dev_id = "i2c-goodix_ts",
-	.table = {
-		GPIO_LOOKUP("INT33FC:00", 60, "reset", GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP("INT33FC:02", 28, "irq", GPIO_ACTIVE_HIGH),
-		{ }
-	},
-};
-
 static struct gpiod_lookup_table * const asus_me176c_gpios[] = {
 	&int3496_gpo2_pin22_gpios,
-	&asus_me176c_goodix_gpios,
 	NULL
 };
 
@@ -1181,6 +1199,10 @@ static const struct software_node medion_lifetab_s10346_accel_node = {
 static const struct property_entry medion_lifetab_s10346_touchscreen_props[] = {
 	PROPERTY_ENTRY_BOOL("touchscreen-inverted-x"),
 	PROPERTY_ENTRY_BOOL("touchscreen-swapped-x-y"),
+	PROPERTY_ENTRY_GPIO("reset-gpios",
+			    &int33fc_gpiochip_nodes[1], 26, GPIO_ACTIVE_HIGH),
+	PROPERTY_ENTRY_GPIO("irq-gpios",
+			    &int33fc_gpiochip_nodes[2], 3, GPIO_ACTIVE_HIGH),
 	{ }
 };
 
@@ -1223,24 +1245,9 @@ static const struct x86_i2c_client_info medion_lifetab_s10346_i2c_clients[] __in
 	},
 };
 
-static struct gpiod_lookup_table medion_lifetab_s10346_goodix_gpios = {
-	.dev_id = "i2c-goodix_ts",
-	.table = {
-		GPIO_LOOKUP("INT33FC:01", 26, "reset", GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP("INT33FC:02", 3, "irq", GPIO_ACTIVE_HIGH),
-		{ }
-	},
-};
-
-static struct gpiod_lookup_table * const medion_lifetab_s10346_gpios[] = {
-	&medion_lifetab_s10346_goodix_gpios,
-	NULL
-};
-
 static const struct x86_dev_info medion_lifetab_s10346_info __initconst = {
 	.i2c_client_info = medion_lifetab_s10346_i2c_clients,
 	.i2c_client_count = ARRAY_SIZE(medion_lifetab_s10346_i2c_clients),
-	.gpiod_lookup_tables = medion_lifetab_s10346_gpios,
 };
 
 /* Nextbook Ares 8 tablets have an Android factory img with everything hardcoded */
@@ -1346,6 +1353,10 @@ static const struct property_entry whitelabel_tm800a550l_goodix_props[] = {
 	PROPERTY_ENTRY_STRING("firmware-name", "gt912-tm800a550l.fw"),
 	PROPERTY_ENTRY_STRING("goodix,config-name", "gt912-tm800a550l.cfg"),
 	PROPERTY_ENTRY_U32("goodix,main-clk", 54),
+	PROPERTY_ENTRY_GPIO("reset-gpios",
+			    &int33fc_gpiochip_nodes[1], 26, GPIO_ACTIVE_HIGH),
+	PROPERTY_ENTRY_GPIO("irq-gpios",
+			    &int33fc_gpiochip_nodes[2], 3, GPIO_ACTIVE_HIGH),
 	{ }
 };
 
@@ -1381,24 +1392,9 @@ static const struct x86_i2c_client_info whitelabel_tm800a550l_i2c_clients[] __in
 	},
 };
 
-static struct gpiod_lookup_table whitelabel_tm800a550l_goodix_gpios = {
-	.dev_id = "i2c-goodix_ts",
-	.table = {
-		GPIO_LOOKUP("INT33FC:01", 26, "reset", GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP("INT33FC:02", 3, "irq", GPIO_ACTIVE_HIGH),
-		{ }
-	},
-};
-
-static struct gpiod_lookup_table * const whitelabel_tm800a550l_gpios[] = {
-	&whitelabel_tm800a550l_goodix_gpios,
-	NULL
-};
-
 static const struct x86_dev_info whitelabel_tm800a550l_info __initconst = {
 	.i2c_client_info = whitelabel_tm800a550l_i2c_clients,
 	.i2c_client_count = ARRAY_SIZE(whitelabel_tm800a550l_i2c_clients),
-	.gpiod_lookup_tables = whitelabel_tm800a550l_gpios,
 };
 
 /*
@@ -1691,6 +1687,7 @@ static void x86_android_tablet_cleanup(void)
 		gpiod_remove_lookup_table(gpiod_lookup_tables[i]);
 
 	software_node_unregister(bat_swnode);
+	software_node_unregister_node_group(int33fc_gpiochip_node_group);
 }
 
 static __init int x86_android_tablet_init(void)
@@ -1727,11 +1724,17 @@ static __init int x86_android_tablet_init(void)
 	for (i = 0; dev_info->modules && dev_info->modules[i]; i++)
 		request_module(dev_info->modules[i]);
 
+	ret = software_node_register_node_group(int33fc_gpiochip_node_group);
+	if (ret)
+		return ret;
+
 	bat_swnode = dev_info->bat_swnode;
 	if (bat_swnode) {
 		ret = software_node_register(bat_swnode);
-		if (ret)
+		if (ret) {
+			x86_android_tablet_cleanup();
 			return ret;
+		}
 	}
 
 	gpiod_lookup_tables = dev_info->gpiod_lookup_tables;
-- 
2.40.1.606.ga4b1b128d6-goog

