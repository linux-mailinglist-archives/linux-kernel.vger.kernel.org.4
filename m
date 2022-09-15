Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C2705B9481
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 08:37:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbiIOGhA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 02:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiIOGg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 02:36:58 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 633B594EDD;
        Wed, 14 Sep 2022 23:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1663223815; x=1694759815;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ywGGKiwHZmURZQhHIr5KRE/Hb1qVk7n6C8wW7t5bUds=;
  b=rWz+rvSvlZC+z7tlVGKHZKsxpV2wRr65OFn0hS9wsX2tgwev8Lj7cpZs
   GdxUJqMxaBZN/cTeVX6eAtAxq5Pl4KeKekGC23cDErtnxAeY1xSdCB1ys
   wBDQwynO4YLn/NG0KeZKMwB5PoCRdh1ljPusMWXJaiTna5wmC0OjzkQiu
   ImoS94DgwbXuyLLbK6hQYgRvlxQbd9PKeU0hsS4bKAzuI+mIGO7o35goL
   zLYkFv7NwOmMxH+w1tfpuZWsyZvltZoENhWb/AvlbDhvQmhcqohOHRNKL
   7hUEM5YL4herZsymo9BQA7rspPD92zgVv9O8JGw4hx53Pw1wdlDhNjah5
   g==;
X-IronPort-AV: E=Sophos;i="5.93,317,1654585200"; 
   d="scan'208";a="113772105"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 14 Sep 2022 23:36:54 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 14 Sep 2022 23:36:53 -0700
Received: from soft-dev3-1.microsemi.net (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Wed, 14 Sep 2022 23:36:51 -0700
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <claudiu.beznea@microchip.com>, <nicolas.ferre@microchip.com>,
        <UNGLinuxDriver@microchip.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: [PATCH] ARM: dts: lan966x: Add interrupt support for PHYs on pcb8290
Date:   Thu, 15 Sep 2022 08:41:12 +0200
Message-ID: <20220915064112.1935051-1-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add interrupt support for the PHYs found on pcb8290. They are all
sharing the same interrupt line towards lan966x.

Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 arch/arm/boot/dts/lan966x-pcb8290.dts | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/lan966x-pcb8290.dts b/arch/arm/boot/dts/lan966x-pcb8290.dts
index af92bb12bc6cd..2ed53da914acb 100644
--- a/arch/arm/boot/dts/lan966x-pcb8290.dts
+++ b/arch/arm/boot/dts/lan966x-pcb8290.dts
@@ -68,41 +68,57 @@ &mdio0 {
 
 	ext_phy0: ethernet-phy@7 {
 		reg = <7>;
+		interrupts = <24 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-parent = <&gpio>;
 		coma-mode-gpios = <&gpio 60 GPIO_OPEN_DRAIN>;
 	};
 
 	ext_phy1: ethernet-phy@8 {
 		reg = <8>;
+		interrupts = <24 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-parent = <&gpio>;
 		coma-mode-gpios = <&gpio 60 GPIO_OPEN_DRAIN>;
 	};
 
 	ext_phy2: ethernet-phy@9 {
 		reg = <9>;
+		interrupts = <24 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-parent = <&gpio>;
 		coma-mode-gpios = <&gpio 60 GPIO_OPEN_DRAIN>;
 	};
 
 	ext_phy3: ethernet-phy@10 {
 		reg = <10>;
+		interrupts = <24 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-parent = <&gpio>;
 		coma-mode-gpios = <&gpio 60 GPIO_OPEN_DRAIN>;
 	};
 
 	ext_phy4: ethernet-phy@15 {
 		reg = <15>;
+		interrupts = <24 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-parent = <&gpio>;
 		coma-mode-gpios = <&gpio 60 GPIO_OPEN_DRAIN>;
 	};
 
 	ext_phy5: ethernet-phy@16 {
 		reg = <16>;
+		interrupts = <24 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-parent = <&gpio>;
 		coma-mode-gpios = <&gpio 60 GPIO_OPEN_DRAIN>;
 	};
 
 	ext_phy6: ethernet-phy@17 {
 		reg = <17>;
+		interrupts = <24 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-parent = <&gpio>;
 		coma-mode-gpios = <&gpio 60 GPIO_OPEN_DRAIN>;
 	};
 
 	ext_phy7: ethernet-phy@18 {
 		reg = <18>;
+		interrupts = <24 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-parent = <&gpio>;
 		coma-mode-gpios = <&gpio 60 GPIO_OPEN_DRAIN>;
 	};
 };
-- 
2.33.0

