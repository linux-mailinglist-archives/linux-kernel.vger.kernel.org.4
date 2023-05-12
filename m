Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4739B6FFDDA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 02:18:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239675AbjELASh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 20:18:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239657AbjELAS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 20:18:26 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 479D772A4;
        Thu, 11 May 2023 17:18:25 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-528cdc9576cso6354174a12.0;
        Thu, 11 May 2023 17:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683850704; x=1686442704;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HGlXat0EtJJBtaak2uCMBVeJwYvrV5UtPoFSqHWuZ/k=;
        b=PAjqlBvpAb5ZeFLkWolJVFg4/mZG3UvU5pKRJhh7J1P8LRbU6oS3vOiisaFST+GShU
         VEX7CKtIALgy7mDq32phfTao0UQPErcx9OvLefQGvdD01s453zXSXiavJBWVKx0AKc4q
         MayVm750yoW0LxCaWmAupmtCOM2XOikdn9uigV3HA4caf61euQrTLHRCa8//kLNHum9d
         K3av+0EqA7ikc2nzYoRrYiAKryPbpmxrbpr4xqv2vnlSblDd+ukqIC6uiHn78qbTC+6q
         q28Ct7FRj798aXM+cVhJVNEwrhmpClGFrGtMAL/47g3CPvMdN18bdi61yFuIQpvlilat
         N5kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683850704; x=1686442704;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HGlXat0EtJJBtaak2uCMBVeJwYvrV5UtPoFSqHWuZ/k=;
        b=dRqvPptWKN07Pt3kP31+TrPrYG5X7gQUnu6kuXBMrcPJacp85I3BsBzrj1cSovU5/h
         oFCOrXm7fD68E3HaV+3Zuv8Nx5cTHSxXPBBwYE0N3wfxSD4Z4OaVKvsA1tdG6wJ6Cnno
         I5YLvg1uOXBCYusocU1QQrRTyhyVgSokQjeAnlQHVngHzimmZkK7PaSEJi5tJhVD9pAh
         oqKf/PFRMfFjTt0b+6W7WxGed9peHReH4khr17rco0C632pzhLpQrNG2OBKrH0SArQmT
         v7WTZFSl4DEREy9W1bJ67ANvfAHdzCGFzZ7vtRtQw5ncbTaQr6yeKO3wos11l1tfF4Yh
         CEww==
X-Gm-Message-State: AC+VfDzWOXxrWpeaQujHYdgdZjJcY10DuCToQGeVEr7ZJpX2nFWWbhqe
        +l7c1ekazCuzgGiivuS1FNs=
X-Google-Smtp-Source: ACHHUZ6a1+ZWiKa6vjexnagahRo4FYtbiR0UoQuUcRn1HxjJsSeW/sCbksafCTvmnlxvV0Dag306ZA==
X-Received: by 2002:a17:902:a9c4:b0:1ac:8def:db2a with SMTP id b4-20020a170902a9c400b001ac8defdb2amr11506158plr.0.1683850704537;
        Thu, 11 May 2023 17:18:24 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:53f7:c9da:338e:6206])
        by smtp.gmail.com with ESMTPSA id q16-20020a170902b11000b001ab016ea3f9sm6537409plr.21.2023.05.11.17.18.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 17:18:23 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] platform/x86: x86-android-tablets: convert wm1502 devices to GPIO references
Date:   Thu, 11 May 2023 17:18:12 -0700
Message-ID: <20230512001815.591817-4-dmitry.torokhov@gmail.com>
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

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/platform/x86/x86-android-tablets.c | 64 +++++++++++++++++-----
 1 file changed, 50 insertions(+), 14 deletions(-)

diff --git a/drivers/platform/x86/x86-android-tablets.c b/drivers/platform/x86/x86-android-tablets.c
index f7f80237cfa9..02ee793a934e 100644
--- a/drivers/platform/x86/x86-android-tablets.c
+++ b/drivers/platform/x86/x86-android-tablets.c
@@ -874,19 +874,37 @@ static const struct platform_device_info lenovo_yoga_tab2_830_1050_pdevs[] __ini
 
 #define LENOVO_YOGA_TAB2_830_1050_CODEC_NAME "spi-10WM5102:00"
 
-static struct gpiod_lookup_table lenovo_yoga_tab2_830_1050_codec_gpios = {
-	.dev_id = LENOVO_YOGA_TAB2_830_1050_CODEC_NAME,
-	.table = {
-		GPIO_LOOKUP("gpio_crystalcove", 3, "reset", GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP("INT33FC:01", 23, "wlf,ldoena", GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP("arizona", 2, "wlf,spkvdd-ena", GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP("arizona", 4, "wlf,micd-pol", GPIO_ACTIVE_LOW),
-		{ }
-	},
+static const struct software_node lenovo_yoga_tab2_830_1050_crystalcove = {
+	.name = "gpio_crystalcove",
+};
+
+static const struct software_node lenovo_yoga_tab2_830_1050_arizona = {
+	.name = "arizona",
+};
+
+static const struct property_entry lenovo_yoga_tab2_830_1050_wm1502_props[] = {
+	PROPERTY_ENTRY_GPIO("reset-gpios",
+			    &lenovo_yoga_tab2_830_1050_crystalcove,
+			    3, GPIO_ACTIVE_HIGH),
+	PROPERTY_ENTRY_GPIO("wlf,ldoena-gpios",
+			     &int33fc_gpiochip_nodes[1], 23, GPIO_ACTIVE_HIGH),
+	PROPERTY_ENTRY_GPIO("wlf,spkvdd-ena-gpios",
+			    &lenovo_yoga_tab2_830_1050_arizona,
+			    2, GPIO_ACTIVE_HIGH),
+	PROPERTY_ENTRY_GPIO("wlf,micd-pol-gpios",
+			    &lenovo_yoga_tab2_830_1050_arizona,
+			    4, GPIO_ACTIVE_HIGH),
+	{ }
+};
+
+static const struct software_node lenovo_yoga_tab2_830_1050_wm5102 = {
+	.properties = lenovo_yoga_tab2_830_1050_wm1502_props,
 };
 
-static struct gpiod_lookup_table * const lenovo_yoga_tab2_830_1050_gpios[] = {
-	&lenovo_yoga_tab2_830_1050_codec_gpios,
+static const struct software_node *lenovo_yoga_tab2_830_1050_swnodes[] = {
+	&lenovo_yoga_tab2_830_1050_crystalcove,
+	&lenovo_yoga_tab2_830_1050_arizona,
+	&lenovo_yoga_tab2_830_1050_wm5102,
 	NULL
 };
 
@@ -898,7 +916,6 @@ static struct x86_dev_info lenovo_yoga_tab2_830_1050_info __initdata = {
 	/* i2c_client_count gets set by lenovo_yoga_tab2_830_1050_init() */
 	.pdev_info = lenovo_yoga_tab2_830_1050_pdevs,
 	.pdev_count = ARRAY_SIZE(lenovo_yoga_tab2_830_1050_pdevs),
-	.gpiod_lookup_tables = lenovo_yoga_tab2_830_1050_gpios,
 	.bat_swnode = &generic_lipo_hv_4v35_battery_node,
 	.modules = bq24190_modules,
 	.invalid_aei_gpiochip = "INT33FC:02",
@@ -955,6 +972,7 @@ static const struct pinctrl_map lenovo_yoga_tab2_830_1050_codec_pinctrl_map =
 	PIN_MAP_MUX_GROUP(LENOVO_YOGA_TAB2_830_1050_CODEC_NAME, "codec_32khz_clk",
 			  "INT33FC:02", "pmu_clk2_grp", "pmu_clk");
 
+static struct device *lenovo_yoga_tab2_830_1050_codec_dev;
 static struct pinctrl *lenovo_yoga_tab2_830_1050_codec_pinctrl;
 static struct sys_off_handler *lenovo_yoga_tab2_830_1050_sys_off_handler;
 
@@ -981,12 +999,24 @@ static int __init lenovo_yoga_tab2_830_1050_init_codec(void)
 		goto err_unregister_mappings;
 	}
 
-	/* We're done with the codec_dev now */
-	put_device(codec_dev);
+	ret = software_node_register_node_group(lenovo_yoga_tab2_830_1050_swnodes);
+	if (ret) {
+		ret = dev_err_probe(codec_dev, ret, "registering software nodes\n");
+		goto err_unregister_mappings;
+	}
 
+	ret = device_add_software_node(codec_dev, &lenovo_yoga_tab2_830_1050_wm5102);
+	if (ret) {
+		ret = dev_err_probe(codec_dev, ret, "adding software node\n");
+		goto err_unregister_swnodes;
+	}
+
+	lenovo_yoga_tab2_830_1050_codec_dev = codec_dev;
 	lenovo_yoga_tab2_830_1050_codec_pinctrl = pinctrl;
 	return 0;
 
+err_unregister_swnodes:
+	software_node_unregister_node_group(lenovo_yoga_tab2_830_1050_swnodes);
 err_unregister_mappings:
 	pinctrl_unregister_mappings(&lenovo_yoga_tab2_830_1050_codec_pinctrl_map);
 err_put_device:
@@ -1034,6 +1064,12 @@ static void lenovo_yoga_tab2_830_1050_exit(void)
 {
 	unregister_sys_off_handler(lenovo_yoga_tab2_830_1050_sys_off_handler);
 
+	if (lenovo_yoga_tab2_830_1050_codec_dev) {
+		device_remove_software_node(lenovo_yoga_tab2_830_1050_codec_dev);
+		put_device(lenovo_yoga_tab2_830_1050_codec_dev);
+		software_node_unregister_node_group(lenovo_yoga_tab2_830_1050_swnodes);
+	}
+
 	if (lenovo_yoga_tab2_830_1050_codec_pinctrl) {
 		pinctrl_put(lenovo_yoga_tab2_830_1050_codec_pinctrl);
 		pinctrl_unregister_mappings(&lenovo_yoga_tab2_830_1050_codec_pinctrl_map);
-- 
2.40.1.606.ga4b1b128d6-goog

