Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A652733206
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 15:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345495AbjFPNTF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 09:19:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345594AbjFPNS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 09:18:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E3F2358C;
        Fri, 16 Jun 2023 06:18:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C084C61EF9;
        Fri, 16 Jun 2023 13:18:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63EEBC433C0;
        Fri, 16 Jun 2023 13:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686921529;
        bh=0pu0X2SPWMxt5JJ65o5tAUskJ9Xk9kKnXMbXLVjzKKw=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=RtDQpDu5/HcaOuIagLMhuA094Yv+8pwvksCEQ63FVJEnCdUI7DzjBFNtECpuaGiAO
         GF1XidvCBs9j/SgPzU6ELebBtTAg0V71S6VBVu1jxKrFkskB0+P6k4w+LqRLNXt7Z8
         PwBhAgRjy7iLXh85UVPKxSrVRHYBfOnwPRPXO63+M8+GnXbW9GNBA/y1dzOJRq7fSW
         FiDnlPpszUui0Qlq+kkyxWH70JZWhqQP0HOyDVarEi3yMY2AOY+9fd4xynJY1i/Ig2
         Q1ix2KdbbDHJ9cn29QhrPBnOQO9U6kbjdzSLXUvjysfZ6TWMuyihRVcBdeHDPcbZ9m
         Zn7l4SYSn00yA==
From:   Michael Walle <mwalle@kernel.org>
Date:   Fri, 16 Jun 2023 15:18:41 +0200
Subject: [PATCH 3/3] ARM: dts: lan966x: kontron-d10: add PHY interrupts
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230616-feature-d10-dt-cleanups-v1-3-50dd0452b8fe@kernel.org>
References: <20230616-feature-d10-dt-cleanups-v1-0-50dd0452b8fe@kernel.org>
In-Reply-To: <20230616-feature-d10-dt-cleanups-v1-0-50dd0452b8fe@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Michael Walle <michael@walle.cc>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michael Walle <mwalle@kernel.org>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With interrupt handling fixed in the MaxLinear PHY driver, see commit
97a89ed101bb ("net: phy: mxl-gpy: disable interrupts on GPY215 by
default"), we can finally add the correct interrupt description to the
device tree.

Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt-8g.dts |  2 ++
 arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt.dtsi   | 13 +++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt-8g.dts b/arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt-8g.dts
index 5feef9a59a79..ad5d8b56e6fa 100644
--- a/arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt-8g.dts
+++ b/arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt-8g.dts
@@ -15,10 +15,12 @@ / {
 &mdio0 {
 	phy2: ethernet-phy@3 {
 		reg = <3>;
+		interrupts-extended = <&gpio 24 IRQ_TYPE_LEVEL_LOW>;
 	};
 
 	phy3: ethernet-phy@4 {
 		reg = <4>;
+		interrupts-extended = <&gpio 24 IRQ_TYPE_LEVEL_LOW>;
 	};
 };
 
diff --git a/arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt.dtsi b/arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt.dtsi
index 2e16217ac88e..83a1c23887e7 100644
--- a/arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt.dtsi
+++ b/arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt.dtsi
@@ -49,6 +49,9 @@ spi3: spi@400 {
 };
 
 &gpio {
+	pinctrl-0 = <&phy_int_pins>;
+	pinctrl-names = "default";
+
 	fc3_b_pins: fc3-b-pins {
 		/* SCK, MISO, MOSI */
 		pins = "GPIO_51", "GPIO_52", "GPIO_53";
@@ -61,6 +64,12 @@ miim_c_pins: miim-c-pins {
 		function = "miim_c";
 	};
 
+	phy_int_pins: phy-int-pins {
+		/* PHY_INT# */
+		pins = "GPIO_24";
+		function = "gpio";
+	};
+
 	reset_pins: reset-pins {
 		/* SYS_RST# */
 		pins = "GPIO_56";
@@ -107,21 +116,25 @@ &mdio0 {
 
 	phy4: ethernet-phy@5 {
 		reg = <5>;
+		interrupts-extended = <&gpio 24 IRQ_TYPE_LEVEL_LOW>;
 		coma-mode-gpios = <&gpio 37 GPIO_OPEN_DRAIN>;
 	};
 
 	phy5: ethernet-phy@6 {
 		reg = <6>;
+		interrupts-extended = <&gpio 24 IRQ_TYPE_LEVEL_LOW>;
 		coma-mode-gpios = <&gpio 37 GPIO_OPEN_DRAIN>;
 	};
 
 	phy6: ethernet-phy@7 {
 		reg = <7>;
+		interrupts-extended = <&gpio 24 IRQ_TYPE_LEVEL_LOW>;
 		coma-mode-gpios = <&gpio 37 GPIO_OPEN_DRAIN>;
 	};
 
 	phy7: ethernet-phy@8 {
 		reg = <8>;
+		interrupts-extended = <&gpio 24 IRQ_TYPE_LEVEL_LOW>;
 		coma-mode-gpios = <&gpio 37 GPIO_OPEN_DRAIN>;
 	};
 };

-- 
2.30.2

