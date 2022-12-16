Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9093C64ECFB
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 15:36:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231214AbiLPOgn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 09:36:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230339AbiLPOga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 09:36:30 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 265AD5C774;
        Fri, 16 Dec 2022 06:36:30 -0800 (PST)
Received: from beast.luon.net (simons.connected.by.freedominter.net [45.83.240.172])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sjoerd)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D7C956602C97;
        Fri, 16 Dec 2022 14:36:28 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1671201389;
        bh=gwg+FXKZU5KF0sKSHfukB4xVb0UPjDiYXwiEsS4bEsc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N32LXhPL5oNa5NdOonz6odUH/VoH3wd3dBTp39dg1ipLkBsCjHCy1BbzIImlPt5lK
         2dIOj1RlpbCjnMoMU/gTrkuCbJpdk+PXJSVN15i/ZZ5zrMY5+YjrnvMNqdu9fXRZLK
         LFJzXP+qGvAslsAnWsM/L/P/QhViC8vbCV6L0bTX2e42mgCAFdkuJloNThtaEAhArN
         Vap6tKGIPLytrLAizqL0Ep3TK2AOx5w8eDQkM2DOTE6ajlNLd8HU0rWKZJ6YEDEPib
         cz8KJbDwM76QoD9wg4908499gxBkUX67C8I9U4rXQGxK+4rn3vrTJINR1vzjntJIgc
         bh1kn7mjFoLIA==
Received: by beast.luon.net (Postfix, from userid 1000)
        id B31B75E3315A; Fri, 16 Dec 2022 15:36:26 +0100 (CET)
From:   Sjoerd Simons <sjoerd@collabora.com>
To:     Nishanth Menon <nm@ti.com>
Cc:     martyn.welch@collabora.com, Nitin Yadav <n-yadav@ti.com>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Tero Kristo <kristo@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] arm64: dts: ti: k3-am625-sk: Add support for USB
Date:   Fri, 16 Dec 2022 15:36:23 +0100
Message-Id: <20221216143624.23708-4-sjoerd@collabora.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221216143624.23708-1-sjoerd@collabora.com>
References: <20221216143624.23708-1-sjoerd@collabora.com>
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

 arch/arm64/boot/dts/ti/k3-am625-sk.dts | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am625-sk.dts b/arch/arm64/boot/dts/ti/k3-am625-sk.dts
index 93a5f0817efc..c165fa0a4109 100644
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
@@ -275,6 +277,12 @@ main_gpio1_ioexp_intr_pins_default: main-gpio1-ioexp-intr-pins-default {
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
@@ -514,3 +522,17 @@ &epwm1 {
 &epwm2 {
 	status = "disabled";
 };
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

