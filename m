Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85F79637D33
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 16:47:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbiKXPrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 10:47:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiKXPrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 10:47:12 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C7DA93CF6;
        Thu, 24 Nov 2022 07:47:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1669304830; x=1700840830;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3Jq2Ya7j+dCP/5S6u7y8siYW5FauuShQoOmL5T0kS2c=;
  b=xc3HfUaNpQl3QQq1ddDJr6k2lkwSRH+JYv+4l1jicjoVkrLwY8HTKaXw
   ivpxQQg/TzgBdC+D0UifjDXEA2+ak6zZxzA2xOrA5OJGMRYUUUC8TAUNu
   C7M1sc7Rce4XH6MwFw8CgH8+Hf1HTwZ5aD4XUGsbtcNsuvtR2zX8rcNPB
   /31z9HUQhpOXDaKpqhVbCkYXBp5BeYnMOtFkB2eCgGNSU+EgtvPeq35/N
   sIyfN48Sp8QdBIRwINbhKHGl28+Fg6lyidVrgVlKBQXVm0C9Bhv1dh5HH
   eHZmaUG0aN0x6r5mZ3sxmt3w6r61z9N2ovSeaQp/hcU6J4LgM/SFWMYeO
   A==;
X-IronPort-AV: E=Sophos;i="5.96,190,1665471600"; 
   d="scan'208";a="124978161"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Nov 2022 08:47:09 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Thu, 24 Nov 2022 08:47:08 -0700
Received: from ROB-ULT-M18282.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Thu, 24 Nov 2022 08:47:07 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <robh+dt@kernel.org>, <claudiu.beznea@microchip.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Eugen Hristev <eugen.hristev@microchip.com>
Subject: [PATCH] ARM: dts: at91: sama7g5ek: align power rails for sdmmc0/1
Date:   Thu, 24 Nov 2022 17:46:10 +0200
Message-ID: <20221124154610.246790-1-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On this board SDMMC0 has a 1.8 signaled eMMC device powered at
3.3 V .
Hence, correctly describe the connected rails from the PMIC.

SDMMC1 is connected to a voltage switch that can change from
3.3V to 1.8V by a hardware controlled pin.
However SDMMC1 at the moment works only 3.3V mode (default speed,
no UHS-I modes), thus connect the signaling to the 3.3V rail.

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
 arch/arm/boot/dts/at91-sama7g5ek.dts | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/at91-sama7g5ek.dts b/arch/arm/boot/dts/at91-sama7g5ek.dts
index 3b25c67795dd..aa5cc0e98bba 100644
--- a/arch/arm/boot/dts/at91-sama7g5ek.dts
+++ b/arch/arm/boot/dts/at91-sama7g5ek.dts
@@ -764,8 +764,9 @@ &rtt {
 &sdmmc0 {
 	bus-width = <8>;
 	non-removable;
-	no-1-8-v;
 	sdhci-caps-mask = <0x0 0x00200000>;
+	vmmc-supply = <&vdd_3v3>;
+	vqmmc-supply = <&vldo1>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_sdmmc0_default>;
 	status = "okay";
@@ -775,6 +776,8 @@ &sdmmc1 {
 	bus-width = <4>;
 	no-1-8-v;
 	sdhci-caps-mask = <0x0 0x00200000>;
+	vmmc-supply = <&vdd_3v3>;
+	vqmmc-supply = <&vdd_3v3>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_sdmmc1_default>;
 	status = "okay";
-- 
2.25.1

