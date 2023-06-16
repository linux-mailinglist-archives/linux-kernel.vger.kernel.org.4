Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7CE7334CF
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 17:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346007AbjFPPaJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 11:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244396AbjFPP3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 11:29:47 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A62BD26AF;
        Fri, 16 Jun 2023 08:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1686929385; x=1718465385;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=rI9R9UXytJokNpAttrGnBytdwyPaCRl1wE974W1E3pU=;
  b=2d/vUspPDKwq9v4wk/0gasUbxuhsPOHUJWhUDXwGemSFix2Xa1lSI+eK
   zMbIq0zInAbqqL+9smjrJjb+4WVZy1bZA/FPa0+gM03069iUI3YkKy/XP
   e+hAjH0WK4l9OXY/FhhbnHa23UlNzAejjca4/+M+CjH9mehOZi68y5C4j
   MDGdg/pyAItx/UtGYuodx5hZvnO54pqqHq9XtHrAiq55l8EQGlaQj0W59
   m2Q9hoWqcMYHgovSUfJmt3anY//on6oxlXXeC8tih6TnkHMTVQvikmldc
   44aEOC1LE10KSsOfqbONgehrTNHw7zfb++EZiLFACmBCtKRuc0cj45s0i
   g==;
X-IronPort-AV: E=Sophos;i="6.00,247,1681196400"; 
   d="scan'208";a="218283789"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Jun 2023 08:29:44 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 16 Jun 2023 08:29:44 -0700
Received: from rob-ult-m91496.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Fri, 16 Jun 2023 08:29:42 -0700
From:   <cristian.birsan@microchip.com>
To:     <arnd@arndb.de>, <olof@lixom.net>, <soc@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Cristian Birsan <cristian.birsan@microchip.com>
Subject: [PATCH] arm: dts: Enable device-tree overlay support for AT91 boards
Date:   Fri, 16 Jun 2023 18:29:32 +0300
Message-ID: <20230616152932.1484154-1-cristian.birsan@microchip.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cristian Birsan <cristian.birsan@microchip.com>

Add the '-@' DTC option for AT91 boards that have device-tree overlays.
This option populates the '__symbols__' node that contains all the
necessary symbols for supporting device-tree overlays (from bootloader)
on these devices.

This change increases the size of the resulting DTB with ~30%-40%. Below
are the measurements performed v6.4-rc6:

at91-sam9x60_curiosity.dtb	28499 -> 36641 bytes
at91-sam9x60ek.dtb		30867 -> 39609 bytes
at91-sama5d27_som1_ek.dtb	26086 -> 34166 bytes
at91-sama5d27_wlsom1_ek.dtb	26045 -> 33184 bytes
at91-sama5d2_icp.dtb		27521 -> 36155 bytes
at91-sama5d2_ptc_ek.dtb		23237 -> 29612 bytes
at91-sama5d2_xplained.dtb	27262 -> 35326 bytes
at91-sama5d3_eds.dtb		27924 -> 39939 bytes
at91-sama5d3_xplained.dtb	28400 -> 40650 bytes
at91-sama5d4_xplained.dtb	26456 -> 36107 bytes
at91-sama7g5ek.dtb		29212 -> 37289 bytes

Signed-off-by: Cristian Birsan <cristian.birsan@microchip.com>
---
 arch/arm/boot/dts/Makefile | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 59829fc90315..38b82af2bf69 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -50,9 +50,21 @@ dtb-$(CONFIG_SOC_AT91SAM9) += \
 	at91sam9g35ek.dtb \
 	at91sam9x25ek.dtb \
 	at91sam9x35ek.dtb
+# Enables support for device-tree overlays
+DTC_FLAGS_at91-sam9x60_curiosity := -@
+DTC_FLAGS_at91-sam9x60ek := -@
 dtb-$(CONFIG_SOC_SAM9X60) += \
 	at91-sam9x60_curiosity.dtb \
 	at91-sam9x60ek.dtb
+# Enables support for device-tree overlays
+DTC_FLAGS_at91-sama5d27_som1_ek := -@
+DTC_FLAGS_at91-sama5d27_wlsom1_ek := -@
+DTC_FLAGS_at91-sama5d2_icp := -@
+DTC_FLAGS_at91-sama5d2_ptc_ek := -@
+DTC_FLAGS_at91-sama5d2_xplained := -@
+DTC_FLAGS_at91-sama5d3_eds := -@
+DTC_FLAGS_at91-sama5d3_xplained := -@
+DTC_FLAGS_at91-sama5d4_xplained := -@
 dtb-$(CONFIG_SOC_SAM_V7) += \
 	at91-kizbox2-2.dtb \
 	at91-kizbox3-hs.dtb \
@@ -79,6 +91,8 @@ dtb-$(CONFIG_SOC_SAM_V7) += \
 	at91-sama5d4_xplained.dtb \
 	at91-sama5d4ek.dtb \
 	at91-vinco.dtb
+# Enables support for device-tree overlays
+DTC_FLAGS_at91-sama7g5ek := -@
 dtb-$(CONFIG_SOC_SAMA7G5) += \
 	at91-sama7g5ek.dtb
 dtb-$(CONFIG_SOC_SP7021) += \
-- 
2.34.1

