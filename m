Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BBB9679688
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 12:24:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233804AbjAXLYY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 06:24:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233555AbjAXLYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 06:24:23 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A394539BBF
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 03:24:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1674559455; x=1706095455;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JscX8uGA9J9NS0UAyCvYDfV3eL+GjVw5IIsACFtx3L8=;
  b=wOHSJz5wSIWwM8EymoWGABcc/Yfur53UZ2oGui8wrqkGth9VcZ7EdtDM
   jKVu+qykEnC63EjIzC2GIQ/GbNM30czGmxpHkzT2AbU+YeOcHdm9gn6S0
   eFR+oreQxEKcs3A74M4zPW9XQyyrGbeHFexqytXdGAEDOcnjb4UmIDbAT
   Dt8t9kIoz9NfcWIqMhBYal9KpjwOM1bgb16t8Z6Gj3X/JqGp7+cdjmc5/
   cRfSU2UH/xI1DGH83LGgAWf7kDYvG7B1vFDceqeCBastQcQoY9jmK0ZSM
   YhkzyDWvQDM30UAiyvC6wCt/iWKGnUIWj/eYwCBGTN9TeyGHAcCNNAUbe
   Q==;
X-IronPort-AV: E=Sophos;i="5.97,242,1669100400"; 
   d="scan'208";a="209045151"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Jan 2023 04:24:15 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 24 Jan 2023 04:24:15 -0700
Received: from ROU-LT-M43238L.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.16 via Frontend Transport; Tue, 24 Jan 2023 04:24:13 -0700
From:   <nicolas.ferre@microchip.com>
To:     <robh@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        <ryan.wanner@microchip.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH] ARM: at91: remove unnecessary of_platform_default_populate calls
Date:   Tue, 24 Jan 2023 12:23:48 +0100
Message-ID: <20230124112348.74198-1-nicolas.ferre@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20180711161443.GY16084@piout.net>
References: <20180711161443.GY16084@piout.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Herring <robh@kernel.org>

DO NOT APPLY: breaking boot on at91 (sama5d3 xplained / NAND at least)

The DT core will call of_platform_default_populate, so it is not
necessary for machine specific code to call it unless there are custom
match entries, auxdata or parent device. Neither of those apply here, so
remove the call.

Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Rob Herring <robh@kernel.org>
[nicolas.ferre@microchip.com: update to newest kernel, add sama7.c file]
Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
---
Rob, Alexandre,

This is the updated patch by Rob.
Tested on sama5d3 xplained platform it fails at least with NAND and, as you
observed Alexandre, SRAM.

The pinctrl patch [1] applied seem to solve the problem with GPIO/pinctrl.

So, this move is not ready now, but we can make progress, little by little.

Best regards,
  Nicolas

 arch/arm/mach-at91/at91rm9200.c | 5 -----
 arch/arm/mach-at91/at91sam9.c   | 5 -----
 arch/arm/mach-at91/sama5.c      | 7 +------
 arch/arm/mach-at91/sama7.c      | 4 ----
 4 files changed, 1 insertion(+), 20 deletions(-)

diff --git a/arch/arm/mach-at91/at91rm9200.c b/arch/arm/mach-at91/at91rm9200.c
index 4f8186211619..e262f5459c76 100644
--- a/arch/arm/mach-at91/at91rm9200.c
+++ b/arch/arm/mach-at91/at91rm9200.c
@@ -7,17 +7,12 @@
  *                2012 Joachim Eastwood <manabian@gmail.com>
  */
 
-#include <linux/of.h>
-#include <linux/of_platform.h>
-
 #include <asm/mach/arch.h>
 
 #include "generic.h"
 
 static void __init at91rm9200_dt_device_init(void)
 {
-	of_platform_default_populate(NULL, NULL, NULL);
-
 	at91rm9200_pm_init();
 }
 
diff --git a/arch/arm/mach-at91/at91sam9.c b/arch/arm/mach-at91/at91sam9.c
index 7e572189a5eb..74b4dd8403a2 100644
--- a/arch/arm/mach-at91/at91sam9.c
+++ b/arch/arm/mach-at91/at91sam9.c
@@ -6,9 +6,6 @@
  *                2011 Nicolas Ferre <nicolas.ferre@atmel.com>
  */
 
-#include <linux/of.h>
-#include <linux/of_platform.h>
-
 #include <asm/mach/arch.h>
 #include <asm/system_misc.h>
 
@@ -16,8 +13,6 @@
 
 static void __init at91sam9_init(void)
 {
-	of_platform_default_populate(NULL, NULL, NULL);
-
 	at91sam9_pm_init();
 }
 
diff --git a/arch/arm/mach-at91/sama5.c b/arch/arm/mach-at91/sama5.c
index bf2b5c6a18c6..79dfa257b3b4 100644
--- a/arch/arm/mach-at91/sama5.c
+++ b/arch/arm/mach-at91/sama5.c
@@ -6,14 +6,11 @@
  *                2013 Ludovic Desroches <ludovic.desroches@atmel.com>
  */
 
-#include <linux/of.h>
-#include <linux/of_platform.h>
-
-#include <asm/hardware/cache-l2x0.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 #include <asm/outercache.h>
 #include <asm/system_misc.h>
+#include <asm/hardware/cache-l2x0.h>
 
 #include "generic.h"
 #include "sam_secure.h"
@@ -32,7 +29,6 @@ static void __init sama5_secure_cache_init(void)
 
 static void __init sama5_dt_device_init(void)
 {
-	of_platform_default_populate(NULL, NULL, NULL);
 	sama5_pm_init();
 }
 
@@ -61,7 +57,6 @@ MACHINE_END
 
 static void __init sama5d2_init(void)
 {
-	of_platform_default_populate(NULL, NULL, NULL);
 	sama5d2_pm_init();
 }
 
diff --git a/arch/arm/mach-at91/sama7.c b/arch/arm/mach-at91/sama7.c
index bd43733ede18..5faccfe9a9bb 100644
--- a/arch/arm/mach-at91/sama7.c
+++ b/arch/arm/mach-at91/sama7.c
@@ -6,9 +6,6 @@
  *
  */
 
-#include <linux/of.h>
-#include <linux/of_platform.h>
-
 #include <asm/mach/arch.h>
 #include <asm/system_misc.h>
 
@@ -16,7 +13,6 @@
 
 static void __init sama7_dt_device_init(void)
 {
-	of_platform_default_populate(NULL, NULL, NULL);
 	sama7_pm_init();
 }
 
-- 
2.34.1

