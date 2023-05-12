Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0DF76FFDD8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 02:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239665AbjELASc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 20:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239446AbjELASY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 20:18:24 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52B7955B1;
        Thu, 11 May 2023 17:18:23 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-51b4ef5378bso8269978a12.1;
        Thu, 11 May 2023 17:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683850703; x=1686442703;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NK4r2Il/bYylcgQXePHqcvcFJGcKhjM3BDNYciswW+w=;
        b=DmKWgzlcljB8I9x8V7MCFmE/ObJ14bDJj1lz5Lw+TcKpM3rH3m+OeF2prpf8iT0+GD
         wrQ4BhnOptW5tV8s0IFulgKsqGGKN42UweKd/EypK1pYNFnYERaUEMyVehwXAS4UEaz5
         bqDc8Eyw8dvI5mJPdjt4GQdSoDqWi1wO5gKMKl3iaQFim4SXBY++M3oTEUZIaXtaBYTp
         yr7/wwJkvT8lLBmVNIxpZQbZ8IfAnNTEKXu861vaLwWHOe8BiyrW7FAK/hgKA2ZB7yWf
         awyZGiVWe1hvRA0IMCWshVHxcjdAS6sDmY113MvvwTBMnIUEVA25OsrThBMIXknDyX3T
         E+Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683850703; x=1686442703;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NK4r2Il/bYylcgQXePHqcvcFJGcKhjM3BDNYciswW+w=;
        b=EDuxR7megBmIp6rxgYCeNZgpZ+1zpHpiyg+/SKwKoJ3Q1xo9mxNard4bv16CFLOLWn
         YKtgBwQyKF1h2FeqX8xElBVpPtTz28mt9hDAkeqjQI5dp+ODyggfmrQz9V6wzRikjWy0
         BXgofJV7FQQQaclOx09PNC2OHQ2cFio4NIx2ViCS3hFwe5R/M0QuoMHJvDeCsgAyEJ9R
         mP1nJq3yXD2h2AsDm9n/L3hpsbQhHQ+H5Uajk91Aw7KtrRVofcJAouJynTrW8CvGF/hz
         +HZKj1y9IGPPNYsFglXbAnLxnwzs5g5zSIX6qk+jUFt5uDXYP8AndUw7yLr2Wn503BDF
         YRJA==
X-Gm-Message-State: AC+VfDxpwcMvBDBcU1flv2DPXTcw2bpjipJNJ1LecDC/6Hvx9QTh2DY7
        EF+lvkz3yAujZcCWT8bUhPc=
X-Google-Smtp-Source: ACHHUZ7FGveyi07VtBbfSxpZ7gy506o8Udf11Yswsy5Cv+8zecbl03P0pPvB/ICSXeRdljUwEtwwJA==
X-Received: by 2002:a17:902:e751:b0:1ab:b120:8efe with SMTP id p17-20020a170902e75100b001abb1208efemr26601785plf.22.1683850702628;
        Thu, 11 May 2023 17:18:22 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:53f7:c9da:338e:6206])
        by smtp.gmail.com with ESMTPSA id q16-20020a170902b11000b001ab016ea3f9sm6537409plr.21.2023.05.11.17.18.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 17:18:21 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] platform/x86: x86-android-tablets: convert int3496 devices to GPIO references
Date:   Thu, 11 May 2023 17:18:11 -0700
Message-ID: <20230512001815.591817-3-dmitry.torokhov@gmail.com>
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
driver away from using GPIO lookup tables for int3496 devices to using
PROPERTY_ENTRY_GPIO().

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/platform/x86/x86-android-tablets.c | 89 +++++++++-------------
 1 file changed, 38 insertions(+), 51 deletions(-)

diff --git a/drivers/platform/x86/x86-android-tablets.c b/drivers/platform/x86/x86-android-tablets.c
index e187fb66b6d7..f7f80237cfa9 100644
--- a/drivers/platform/x86/x86-android-tablets.c
+++ b/drivers/platform/x86/x86-android-tablets.c
@@ -263,23 +263,6 @@ static const char * const bq24190_modules[] __initconst = {
 	NULL
 };
 
-/* Generic pdevs array and gpio-lookups for micro USB ID pin handling */
-static const struct platform_device_info int3496_pdevs[] __initconst = {
-	{
-		/* For micro USB ID pin handling */
-		.name = "intel-int3496",
-		.id = PLATFORM_DEVID_NONE,
-	},
-};
-
-static struct gpiod_lookup_table int3496_gpo2_pin22_gpios = {
-	.dev_id = "intel-int3496",
-	.table = {
-		GPIO_LOOKUP("INT33FC:02", 22, "id", GPIO_ACTIVE_HIGH),
-		{ }
-	},
-};
-
 /*
  * Advantech MICA-071
  * This is a standard Windows tablet, but it has an extra "quick launch" button
@@ -347,6 +330,12 @@ static const struct gpio_keys_platform_data asus_me176c_tf103c_lid_pdata __initc
 	.name = "lid_sw",
 };
 
+static const struct property_entry asus_me176c_tf103c_int3496_props[] = {
+	PROPERTY_ENTRY_GPIO("id-gpios",
+			    &int33fc_gpiochip_nodes[2], 22, GPIO_ACTIVE_HIGH),
+	{ }
+};
+
 static const struct platform_device_info asus_me176c_tf103c_pdevs[] __initconst = {
 	{
 		.name = "gpio-keys",
@@ -358,6 +347,7 @@ static const struct platform_device_info asus_me176c_tf103c_pdevs[] __initconst
 		/* For micro USB ID pin handling */
 		.name = "intel-int3496",
 		.id = PLATFORM_DEVID_NONE,
+		.properties = asus_me176c_tf103c_int3496_props,
 	},
 };
 
@@ -503,11 +493,6 @@ static const struct x86_serdev_info asus_me176c_serdevs[] __initconst = {
 	},
 };
 
-static struct gpiod_lookup_table * const asus_me176c_gpios[] = {
-	&int3496_gpo2_pin22_gpios,
-	NULL
-};
-
 static const struct x86_dev_info asus_me176c_info __initconst = {
 	.i2c_client_info = asus_me176c_i2c_clients,
 	.i2c_client_count = ARRAY_SIZE(asus_me176c_i2c_clients),
@@ -515,7 +500,6 @@ static const struct x86_dev_info asus_me176c_info __initconst = {
 	.pdev_count = ARRAY_SIZE(asus_me176c_tf103c_pdevs),
 	.serdev_info = asus_me176c_serdevs,
 	.serdev_count = ARRAY_SIZE(asus_me176c_serdevs),
-	.gpiod_lookup_tables = asus_me176c_gpios,
 	.bat_swnode = &generic_lipo_hv_4v35_battery_node,
 	.modules = bq24190_modules,
 	.invalid_aei_gpiochip = "INT33FC:02",
@@ -648,17 +632,11 @@ static const struct x86_i2c_client_info asus_tf103c_i2c_clients[] __initconst =
 	},
 };
 
-static struct gpiod_lookup_table * const asus_tf103c_gpios[] = {
-	&int3496_gpo2_pin22_gpios,
-	NULL
-};
-
 static const struct x86_dev_info asus_tf103c_info __initconst = {
 	.i2c_client_info = asus_tf103c_i2c_clients,
 	.i2c_client_count = ARRAY_SIZE(asus_tf103c_i2c_clients),
 	.pdev_info = asus_me176c_tf103c_pdevs,
 	.pdev_count = ARRAY_SIZE(asus_me176c_tf103c_pdevs),
-	.gpiod_lookup_tables = asus_tf103c_gpios,
 	.bat_swnode = &asus_tf103c_battery_node,
 	.modules = bq24190_modules,
 	.invalid_aei_gpiochip = "INT33FC:02",
@@ -877,12 +855,20 @@ static const struct x86_i2c_client_info lenovo_yoga_tab2_830_1050_i2c_clients[]
 	},
 };
 
-static struct gpiod_lookup_table lenovo_yoga_tab2_830_1050_int3496_gpios = {
-	.dev_id = "intel-int3496",
-	.table = {
-		GPIO_LOOKUP("INT33FC:02", 1, "mux", GPIO_ACTIVE_LOW),
-		GPIO_LOOKUP("INT33FC:02", 24, "id", GPIO_ACTIVE_HIGH),
-		{ }
+static const struct property_entry lenovo_yoga_tab2_830_1050_int3496_props[] = {
+	PROPERTY_ENTRY_GPIO("mux-gpios",
+			    &int33fc_gpiochip_nodes[2], 1, GPIO_ACTIVE_LOW),
+	PROPERTY_ENTRY_GPIO("id-gpios",
+			    &int33fc_gpiochip_nodes[2], 24, GPIO_ACTIVE_HIGH),
+	{ }
+};
+
+static const struct platform_device_info lenovo_yoga_tab2_830_1050_pdevs[] __initconst = {
+	{
+		/* For micro USB ID pin handling */
+		.name = "intel-int3496",
+		.id = PLATFORM_DEVID_NONE,
+		.properties = lenovo_yoga_tab2_830_1050_int3496_props,
 	},
 };
 
@@ -900,7 +886,6 @@ static struct gpiod_lookup_table lenovo_yoga_tab2_830_1050_codec_gpios = {
 };
 
 static struct gpiod_lookup_table * const lenovo_yoga_tab2_830_1050_gpios[] = {
-	&lenovo_yoga_tab2_830_1050_int3496_gpios,
 	&lenovo_yoga_tab2_830_1050_codec_gpios,
 	NULL
 };
@@ -911,8 +896,8 @@ static void lenovo_yoga_tab2_830_1050_exit(void);
 static struct x86_dev_info lenovo_yoga_tab2_830_1050_info __initdata = {
 	.i2c_client_info = lenovo_yoga_tab2_830_1050_i2c_clients,
 	/* i2c_client_count gets set by lenovo_yoga_tab2_830_1050_init() */
-	.pdev_info = int3496_pdevs,
-	.pdev_count = ARRAY_SIZE(int3496_pdevs),
+	.pdev_info = lenovo_yoga_tab2_830_1050_pdevs,
+	.pdev_count = ARRAY_SIZE(lenovo_yoga_tab2_830_1050_pdevs),
 	.gpiod_lookup_tables = lenovo_yoga_tab2_830_1050_gpios,
 	.bat_swnode = &generic_lipo_hv_4v35_battery_node,
 	.modules = bq24190_modules,
@@ -1305,26 +1290,28 @@ static const struct x86_i2c_client_info nextbook_ares8_i2c_clients[] __initconst
 	},
 };
 
-static struct gpiod_lookup_table nextbook_ares8_int3496_gpios = {
-	.dev_id = "intel-int3496",
-	.table = {
-		GPIO_LOOKUP("INT33FC:02", 1, "mux", GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP("INT33FC:02", 18, "id", GPIO_ACTIVE_HIGH),
-		{ }
-	},
+static const struct property_entry nextbook_ares8_int3496_props[] = {
+	PROPERTY_ENTRY_GPIO("mux-gpios",
+			    &int33fc_gpiochip_nodes[2], 1, GPIO_ACTIVE_HIGH),
+	PROPERTY_ENTRY_GPIO("id-gpios",
+			    &int33fc_gpiochip_nodes[2], 18, GPIO_ACTIVE_HIGH),
+	{ }
 };
 
-static struct gpiod_lookup_table * const nextbook_ares8_gpios[] = {
-	&nextbook_ares8_int3496_gpios,
-	NULL
+static const struct platform_device_info nextbook_ares8_pdevs[] __initconst = {
+	{
+		/* For micro USB ID pin handling */
+		.name = "intel-int3496",
+		.id = PLATFORM_DEVID_NONE,
+		.properties = nextbook_ares8_int3496_props,
+	},
 };
 
 static const struct x86_dev_info nextbook_ares8_info __initconst = {
 	.i2c_client_info = nextbook_ares8_i2c_clients,
 	.i2c_client_count = ARRAY_SIZE(nextbook_ares8_i2c_clients),
-	.pdev_info = int3496_pdevs,
-	.pdev_count = ARRAY_SIZE(int3496_pdevs),
-	.gpiod_lookup_tables = nextbook_ares8_gpios,
+	.pdev_info = nextbook_ares8_pdevs,
+	.pdev_count = ARRAY_SIZE(nextbook_ares8_pdevs),
 	.invalid_aei_gpiochip = "INT33FC:02",
 };
 
-- 
2.40.1.606.ga4b1b128d6-goog

