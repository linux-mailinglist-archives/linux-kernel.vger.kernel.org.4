Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA0E86BDD13
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 00:41:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbjCPXlK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 19:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbjCPXlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 19:41:02 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38767B6914
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 16:40:28 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id l9so1919171iln.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 16:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jeremypeper-com.20210112.gappssmtp.com; s=20210112; t=1679010024;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4CyaT9uDipnsFuj99i8Vwth5QLX2HZnSmnBVG1vs7MQ=;
        b=L0GC4PZVXnJJhanHBqC6rqaEaAiAUtP5L+/3Q8/F0ACoMyUFVymhh0+eed6abMq1z3
         o77tpZUy+OMuwufZELG3aGUg+80Isb5AEgahpx5DESW5Lxf7udqs6nipoTJnwfaHy6DD
         Xmve4kCsr+4wYXt3IUzQvjdC0zAiTm5a7BChcLjbPbP1XInwUZ9l6o/Ch2wf6+tdFHhb
         782y/nDhmNuepIHaksrY9LUImceWR/2L69d3u7klk2STtmgsZf2SHsUtRp/b4TKYruMJ
         JFNj2oK77aQ2wmmp/qekdzxz6JIebWOzh9sMfH6tGFmzwNK7pLLzCrK673zYLbykjQiW
         62cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679010024;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4CyaT9uDipnsFuj99i8Vwth5QLX2HZnSmnBVG1vs7MQ=;
        b=ZOz6O2ue8cugjZUfLIRm5VKwtfV5wc02CUABTjRJdpoCcy91XolTEA3pV1S135r5MQ
         Bxe06T7+RMEI6J/ct4gOh6N5JyoVYp5RUsy1tnbGPX9d6mFGot2t7V1CNtWXG6Da3+NG
         Wojaz4wR+FQDbSvqj0dnIXe7094UzARSoXViTY9xVQbemPDri6YA+Wc6TNyNV0Y0uBdM
         DKFans83Yz5DPMUuy3ItZbKutfYYlUiZ3GicRF5YFOR9B6wA164Ef1f4YHFvcXzRT5F0
         3ENpoji5OSxiQM45m4os1Sgi/01LYkHE9Wr47d/kTjE6umtrFtnE2WCdGiGmvqJR9y7e
         COzA==
X-Gm-Message-State: AO0yUKW14ey4IIg0U/TgUjlw0o3IqQc2+ZW/oxVpuQqhSZZAJhCfl2zT
        Rh0HvGkiKRSaEJRwXsxB8o4Pnr38LWATSeUe+jI=
X-Google-Smtp-Source: AK7set/o5+7xRgQ1cV2+A0Q6YumbMg2Rnb5B6Y4dXF5cT+4qTPVDKW+gbM3aI/APdIC45TPgpC2XCg==
X-Received: by 2002:a05:6e02:1527:b0:317:e415:bc55 with SMTP id i7-20020a056e02152700b00317e415bc55mr11075010ilu.23.1679010024707;
        Thu, 16 Mar 2023 16:40:24 -0700 (PDT)
Received: from earth (70-59-64-215.mpls.qwest.net. [70.59.64.215])
        by smtp.gmail.com with ESMTPSA id h22-20020a056638339600b00374bf3b62a0sm196741jav.99.2023.03.16.16.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 16:40:23 -0700 (PDT)
From:   1000001101000 <systemalerts@jeremypeper.com>
X-Google-Original-From: 1000001101000 <1000001101000@earth>
Received: by earth (Postfix, from userid 1000)
        id D719E10601ED; Thu, 16 Mar 2023 18:40:22 -0500 (CDT)
To:     linux-kernel@vger.kernel.org, arnd@kernel.org
Cc:     "Jeremy J . Peper" <jeremy@jeremypeper.com>
Subject: [PATCH 3/3] fix entries for gpios, buttons and usb ports
Date:   Thu, 16 Mar 2023 18:40:09 -0500
Message-Id: <20230316234009.2115005-3-user@earth>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230316234009.2115005-1-user@earth>
References: <20230316234009.2115005-1-user@earth>
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

From: Jeremy J. Peper <jeremy@jeremypeper.com>

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

