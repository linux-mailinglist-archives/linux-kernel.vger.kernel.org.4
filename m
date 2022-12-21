Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83B7B6531CF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 14:31:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233556AbiLUNbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 08:31:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231334AbiLUNa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 08:30:58 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 316221BEB2;
        Wed, 21 Dec 2022 05:30:57 -0800 (PST)
Received: from beast.luon.net (unknown [IPv6:2a10:3781:2531::8])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sjoerd)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id AB1366602CC7;
        Wed, 21 Dec 2022 13:30:55 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1671629455;
        bh=2k9liHIna4KFWxtP8eE1o52G4O3DbqUbH/l1lszJKUM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LzPsFYvJAVcpWIHbii8uCyIgFc2seyp8lU4/SxWyrACxeZh5zqtbAwCVPbrowdm/9
         K54WFXsTCQZY+XhK+deBTgDy/ylnXDNMxxmtR6m7N9K/ZKX1QLnWqS2Dm8oTtzpSLn
         yOWTQsgwj6JuW2Cn43GoxoqTR1eTL4dp8KO9PRvC6FVLC06TW3nqswceRKdMHV5VP+
         IG3lEAhW0YfB5OGJa0YrjVBdUHqhyJcemLkTIgHbD9U2NS17ZhSAl3s2ZSyC8ilsCY
         UcCIRhf4e3I7a4Obc4GYXlPtJs+yIpo59bvOdpmEu9HuAfjp+3H7SNv4gxjboOrGUr
         mjcI4o7nhfRMw==
Received: by beast.luon.net (Postfix, from userid 1000)
        id 64A865EC4843; Wed, 21 Dec 2022 14:30:53 +0100 (CET)
From:   Sjoerd Simons <sjoerd@collabora.com>
To:     Nishanth Menon <nm@ti.com>
Cc:     martyn.welch@collabora.com, Nitin Yadav <n-yadav@ti.com>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Tero Kristo <kristo@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] arm64: dts: ti: k3-am625-sk: Add support for USB
Date:   Wed, 21 Dec 2022 14:30:50 +0100
Message-Id: <20221221133051.1069480-4-sjoerd@collabora.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221221133051.1069480-1-sjoerd@collabora.com>
References: <20221221133051.1069480-1-sjoerd@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aswath Govindraju <a-govindraju@ti.com>

AM62 SoC has two instances of USB and they are brought on to the board
in the following way,

-> USB0 instance
 - This is brought out to a USB TypeC connector on board through TPS6598 PD
   controller. The PD controller should decide the role based on CC pin in
   the connector. Unfortunately the irq line for the TPS isn't hooked up
   which is a mode not yet support by the driver (some patches were
   submitted earlier this year[0]). So for now the PD controller is left
   out and periphal mode chosen.

-> USB1 instance
 - This is brought out to a USB TypeA connector on board.

Therefore, add the required device tree support for the above in the board
dts file.

0: https://lore.kernel.org/lkml/f714ee55-ef47-317d-81b9-57020dda064b@ti.com/T/

Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
[merge from vendor bsp, drop TPS6598 support, reword commit message]
Signed-off-by: Sjoerd Simons <sjoerd@collabora.com>

---

Changes in v2:
  - Rebase against linux-next 20221220

 arch/arm64/boot/dts/ti/k3-am625-sk.dts | 50 ++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am625-sk.dts b/arch/arm64/boot/dts/ti/k3-am625-sk.dts
index 4f179b146cab..c82a0ebf6772 100644
--- a/arch/arm64/boot/dts/ti/k3-am625-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am625-sk.dts
@@ -24,6 +24,8 @@ aliases {
 		spi0 = &ospi0;
 		ethernet0 = &cpsw_port1;
 		ethernet1 = &cpsw_port2;
+		usb0 = &usb0;
+		usb1 = &usb1;
 	};
 
 	chosen {
@@ -284,6 +286,12 @@ main_gpio1_ioexp_intr_pins_default: main-gpio1-ioexp-intr-pins-default {
 			AM62X_IOPAD(0x01d4, PIN_INPUT, 7) /* (B15) UART0_RTSn.GPIO1_23 */
 		>;
 	};
+
+	main_usb1_pins_default: main-usb1-pins-default {
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x0258, PIN_OUTPUT, 0) /* (F18) USB1_DRVVBUS */
+		>;
+	};
 };
 
 &wkup_uart0 {
@@ -464,3 +472,45 @@ partition@3fc0000 {
 		};
 	};
 };
+
+&ecap0 {
+	status = "disabled";
+};
+
+&ecap1 {
+	status = "disabled";
+};
+
+&ecap2 {
+	status = "disabled";
+};
+
+&main_mcan0 {
+	status = "disabled";
+};
+
+&epwm0 {
+	status = "disabled";
+};
+
+&epwm1 {
+	status = "disabled";
+};
+
+&epwm2 {
+	status = "disabled";
+};
+
+&usbss0 {
+	ti,vbus-divider;
+};
+
+&usb0 {
+	dr_mode = "peripheral";
+};
+
+&usb1 {
+	dr_mode = "host";
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_usb1_pins_default>;
+};
-- 
2.39.0

