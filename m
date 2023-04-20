Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 075E86E91D1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 13:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234443AbjDTLGF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 07:06:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235358AbjDTLEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 07:04:53 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D4501B4;
        Thu, 20 Apr 2023 04:03:29 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id E4AFE24E2AB;
        Thu, 20 Apr 2023 19:01:00 +0800 (CST)
Received: from EXMBX171.cuchost.com (172.16.6.91) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 20 Apr
 2023 19:01:00 +0800
Received: from ubuntu.localdomain (113.72.144.253) by EXMBX171.cuchost.com
 (172.16.6.91) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 20 Apr
 2023 19:00:59 +0800
From:   Minda Chen <minda.chen@starfivetech.com>
To:     Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Conor Dooley <conor@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Pawel Laszczak <pawell@cadence.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Chen <peter.chen@kernel.org>,
        Roger Quadros <rogerq@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <linux-usb@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Minda Chen" <minda.chen@starfivetech.com>,
        Mason Huo <mason.huo@starfivetech.com>
Subject: [PATCH v5 7/7] riscv: dts: starfive: Add USB dts configuration for JH7110
Date:   Thu, 20 Apr 2023 19:00:52 +0800
Message-ID: <20230420110052.3182-8-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230420110052.3182-1-minda.chen@starfivetech.com>
References: <20230420110052.3182-1-minda.chen@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [113.72.144.253]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX171.cuchost.com
 (172.16.6.91)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add USB wrapper layer and Cadence USB3 controller dts
configuration for StarFive JH7110 SoC and VisionFive2
Board.
USB controller connect to PHY, The PHY dts configuration
are also added.

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
---
 .../jh7110-starfive-visionfive-2.dtsi         |  7 +++
 arch/riscv/boot/dts/starfive/jh7110.dtsi      | 44 +++++++++++++++++++
 2 files changed, 51 insertions(+)

diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
index 1155b97b593d..fa97ebfd93ad 100644
--- a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
@@ -221,3 +221,10 @@
 	pinctrl-0 = <&uart0_pins>;
 	status = "okay";
 };
+
+&usb0 {
+	phys = <&usbphy0>;
+	phy-names = "usb2";
+	dr_mode = "peripheral";
+	status = "okay";
+};
diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi b/arch/riscv/boot/dts/starfive/jh7110.dtsi
index 29cd798b6732..eee395e19cdb 100644
--- a/arch/riscv/boot/dts/starfive/jh7110.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
@@ -366,6 +366,50 @@
 			status = "disabled";
 		};
 
+		usb0: usb@10100000 {
+			compatible = "starfive,jh7110-usb";
+			reg = <0x0 0x10100000 0x0 0x10000>,
+			      <0x0 0x10110000 0x0 0x10000>,
+			      <0x0 0x10120000 0x0 0x10000>;
+			reg-names = "otg", "xhci", "dev";
+			interrupts = <100>, <108>, <110>;
+			interrupt-names = "host", "peripheral", "otg";
+			clocks = <&stgcrg JH7110_STGCLK_USB0_LPM>,
+				 <&stgcrg JH7110_STGCLK_USB0_STB>,
+				 <&stgcrg JH7110_STGCLK_USB0_APB>,
+				 <&stgcrg JH7110_STGCLK_USB0_AXI>,
+				 <&stgcrg JH7110_STGCLK_USB0_UTMI_APB>;
+			clock-names = "lpm", "stb", "apb", "axi", "utmi_apb";
+			resets = <&stgcrg JH7110_STGRST_USB0_PWRUP>,
+				 <&stgcrg JH7110_STGRST_USB0_APB>,
+				 <&stgcrg JH7110_STGRST_USB0_AXI>,
+				 <&stgcrg JH7110_STGRST_USB0_UTMI_APB>;
+			reset-names = "pwrup", "apb", "axi", "utmi_apb";
+			starfive,stg-syscon = <&stg_syscon 0x4>;
+			status = "disabled";
+		};
+
+		usbphy0: phy@10200000 {
+			compatible = "starfive,jh7110-usb-phy";
+			reg = <0x0 0x10200000 0x0 0x10000>;
+			clocks = <&syscrg JH7110_SYSCLK_USB_125M>,
+				 <&stgcrg JH7110_STGCLK_USB0_APP_125>;
+			clock-names = "125m", "app_125m";
+			#phy-cells = <0>;
+		};
+
+		pciephy0: phy@10210000 {
+			compatible = "starfive,jh7110-pcie-phy";
+			reg = <0x0 0x10210000 0x0 0x10000>;
+			#phy-cells = <0>;
+		};
+
+		pciephy1: phy@10220000 {
+			compatible = "starfive,jh7110-pcie-phy";
+			reg = <0x0 0x10220000 0x0 0x10000>;
+			#phy-cells = <0>;
+		};
+
 		stgcrg: clock-controller@10230000 {
 			compatible = "starfive,jh7110-stgcrg";
 			reg = <0x0 0x10230000 0x0 0x10000>;
-- 
2.17.1

