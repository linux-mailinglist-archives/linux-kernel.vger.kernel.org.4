Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 052CB6BED32
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 16:44:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231240AbjCQPol (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 11:44:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230335AbjCQPob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 11:44:31 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91B7018AA4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 08:44:30 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id l15so1411411ilv.4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 08:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jeremypeper-com.20210112.gappssmtp.com; s=20210112; t=1679067870;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8+zMWg5FWXdbzfzgwcJaNMLRtf/RCGBVCiQMxd97hjQ=;
        b=zocALH3uJ+qtBqRJSqM4+Gpq1reI9wkxJuxt+7I+VL4M7LsZoTqQOs/You4nv8PBav
         MpTbPm1MOzV7NBXTqShhCm8ty5sQMz/1LfaJAugOHu6g2m8sUfW9+ulnG5CJbzQbpJ0D
         XIIZxUJS+V1l9PcqO0fzGhnp3gsBGaXLi4Cu+TbUxFEqvHJtCW3CP2QLmazirVPhNTom
         aqS9CHdyR8sZQHAlc/vFqGZDBjg5EwWIILx+IiLoUoAcDMm5pjXFloEiYyP4jOZPjPxp
         0xJqc3FHKDSD5uT/I0pqUK+zBfFCcWqXIkyrvONK60rgummbC8Lw7b5ASf+GD5p6Fo4s
         vcMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679067870;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8+zMWg5FWXdbzfzgwcJaNMLRtf/RCGBVCiQMxd97hjQ=;
        b=lGY2T17Bt1tekVP3mxl5IkwfOOavhrBePlCRzOvUlhVwkx3M/cFjZyF1OwhuDia+Lw
         mA2tIGJUm1pAH09UVQzsVZ/jzrWPxvkMUm586Z764QhpQ3dURTdhavvmJeeKYi8tFhgI
         ftkEfCML1PMdRnxtQybsjIBOl69y4ODz5kUdOJekYvLHA2G1DvXLekUknvt0KMYkpTF1
         W/2vnOa8GzyJQodSwurxsauy/NUHpPsFEJnNPeUhgDyZ0UhuFCdjqYA49QMrweu51HyW
         8T64XYd/2FwjZvZbpIuGK4l/hBrx0GbGxd85eCFszI4+zp2HzxQffvRQsCrGitJOBwZY
         /Rvw==
X-Gm-Message-State: AO0yUKUkaefTMVj1qyCmYNvcc4839qUHPOVs62GfFwgSmKji7UybSbGc
        aQkSjw2UX93zpgGKp0k7s/822YttazC9xM3kWN9YrA==
X-Google-Smtp-Source: AK7set+2tZ5OKKqW71TkmBUQDV0zJMO2JBsP/s5FM9hn1UVyF/xOPeJEA/zKbr/EOg01gF2OCubEaw==
X-Received: by 2002:a05:6e02:783:b0:323:cab8:3c05 with SMTP id q3-20020a056e02078300b00323cab83c05mr38146ils.5.1679067869979;
        Fri, 17 Mar 2023 08:44:29 -0700 (PDT)
Received: from earth (70-59-64-215.mpls.qwest.net. [70.59.64.215])
        by smtp.gmail.com with ESMTPSA id y4-20020a92d804000000b003231396e317sm660935ilm.88.2023.03.17.08.44.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 08:44:29 -0700 (PDT)
Received: by earth (Postfix, from userid 1000)
        id DECB21060082; Fri, 17 Mar 2023 10:44:28 -0500 (CDT)
From:   "Jeremy J. Peper" <jeremy@jeremypeper.com>
To:     linux-kernel@vger.kernel.org, arnd@kernel.org
Cc:     "Jeremy J . Peper" <jeremy@jeremypeper.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 4/4] fix entries for gpios, buttons and usb ports
Date:   Fri, 17 Mar 2023 10:43:47 -0500
Message-Id: <20230317154411.3727514-4-jeremy@jeremypeper.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230317154411.3727514-1-jeremy@jeremypeper.com>
References: <20230317154411.3727514-1-jeremy@jeremypeper.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Original code was largely copy-pasted from the reference board code, correct values to reflect the hardware actually present in the TS-WXL.

Signed-off-by: Jeremy J. Peper <jeremy@jeremypeper.com>
---
 arch/arm/mach-mv78xx0/buffalo-wxl-setup.c | 66 +++++++++++++++++------
 1 file changed, 51 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-mv78xx0/buffalo-wxl-setup.c b/arch/arm/mach-mv78xx0/buffalo-wxl-setup.c
index 31359f586..62e982f74 100644
--- a/arch/arm/mach-mv78xx0/buffalo-wxl-setup.c
+++ b/arch/arm/mach-mv78xx0/buffalo-wxl-setup.c
@@ -14,6 +14,9 @@
 #include <linux/mv643xx_eth.h>
 #include <linux/ethtool.h>
 #include <linux/i2c.h>
+#include <linux/gpio.h>
+#include <linux/gpio_keys.h>
+#include <linux/input.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include "mv78xx0.h"
@@ -21,6 +24,11 @@
 #include "mpp.h"
 
 
+#define TSWXL_AUTO_SWITCH	15
+#define TSWXL_USB_POWER1	30
+#define TSWXL_USB_POWER2	31
+
+
 /* This arch has 2 Giga Ethernet */
 
 static struct mv643xx_eth_platform_data db78x00_ge00_data = {
@@ -57,9 +65,9 @@ static unsigned int wxl_mpp_config[] __initdata = {
 	MPP10_GE1_RXD2,
 	MPP11_GE1_RXD3,
 	MPP12_GPIO,
-	MPP13_SYSRST_OUTn,
-	MPP14_SATA1_ACTn,
-	MPP15_SATA0_ACTn,
+	MPP13_GPIO,
+	MPP14_GPIO,
+	MPP15_GPIO,
 	MPP16_GPIO,
 	MPP17_GPIO,
 	MPP18_GPIO,
@@ -73,7 +81,7 @@ static unsigned int wxl_mpp_config[] __initdata = {
 	MPP26_UA2_CTSn,
 	MPP27_UA2_RTSn,
 	MPP28_GPIO,
-	MPP29_SYSRST_OUTn,
+	MPP29_GPIO,
 	MPP30_GPIO,
 	MPP31_GPIO,
 	MPP32_GPIO,
@@ -84,19 +92,41 @@ static unsigned int wxl_mpp_config[] __initdata = {
 	MPP37_GPIO,
 	MPP38_GPIO,
 	MPP39_GPIO,
-	MPP40_UNUSED,
-	MPP41_UNUSED,
-	MPP42_UNUSED,
-	MPP43_UNUSED,
-	MPP44_UNUSED,
-	MPP45_UNUSED,
-	MPP46_UNUSED,
-	MPP47_UNUSED,
-	MPP48_SATA1_ACTn,
-	MPP49_SATA0_ACTn,
+	MPP40_GPIO,
+	MPP41_GPIO,
+	MPP42_GPIO,
+	MPP43_GPIO,
+	MPP44_GPIO,
+	MPP45_GPIO,
+	MPP46_GPIO,
+	MPP47_GPIO,
+	MPP48_GPIO,
+	MPP49_GPIO,
 	0
 };
 
+static struct gpio_keys_button tswxl_buttons[] = {
+	{
+		.code	   = KEY_OPTION,
+		.gpio	   = TSWXL_AUTO_SWITCH,
+		.desc	   = "Power-auto Switch",
+		.active_low     = 1,
+	}
+};
+
+static struct gpio_keys_platform_data tswxl_button_data = {
+	.buttons	= tswxl_buttons,
+	.nbuttons       = ARRAY_SIZE(tswxl_buttons),
+};
+
+static struct platform_device tswxl_button_device = {
+	.name	   = "gpio-keys",
+	.id	     = -1,
+	.num_resources  = 0,
+	.dev	    = {
+		.platform_data  = &tswxl_button_data,
+	},
+};
 
 static void __init wxl_init(void)
 {
@@ -111,7 +141,6 @@ static void __init wxl_init(void)
 	 */
 	mv78xx0_ehci0_init();
 	mv78xx0_ehci1_init();
-	mv78xx0_ehci2_init();
 	mv78xx0_ge00_init(&db78x00_ge00_data);
 	mv78xx0_ge01_init(&db78x00_ge01_data);
 	mv78xx0_sata_init(&db78x00_sata_data);
@@ -123,6 +152,13 @@ static void __init wxl_init(void)
 	mv78xx0_crypto_init();
 	mv78xx0_i2c_init();
 	i2c_register_board_info(0, &db78x00_i2c_rtc, 1);
+
+	//enable both usb ports
+	gpio_direction_output(TSWXL_USB_POWER1, 1);
+	gpio_direction_output(TSWXL_USB_POWER2, 1);
+
+	//enable rear switch
+	platform_device_register(&tswxl_button_device);
 }
 
 static int __init wxl_pci_init(void)
-- 
2.30.2

