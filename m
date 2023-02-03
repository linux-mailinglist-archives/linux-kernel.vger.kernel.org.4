Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D818689200
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 09:23:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233045AbjBCIVf convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 3 Feb 2023 03:21:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232749AbjBCIVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 03:21:10 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 184DB6DB2E;
        Fri,  3 Feb 2023 00:19:43 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id B102024E28F;
        Fri,  3 Feb 2023 16:19:16 +0800 (CST)
Received: from EXMBX168.cuchost.com (172.16.6.78) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 3 Feb
 2023 16:19:16 +0800
Received: from williamqiu-virtual-machine.starfivetech.com (171.223.208.138)
 by EXMBX168.cuchost.com (172.16.6.78) with Microsoft SMTP Server (TLS) id
 15.0.1497.42; Fri, 3 Feb 2023 16:19:15 +0800
From:   William Qiu <william.qiu@starfivetech.com>
To:     <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        William Qiu <william.qiu@starfivetech.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 3/3] riscv: dts: starfive: Add mmc node
Date:   Fri, 3 Feb 2023 16:19:13 +0800
Message-ID: <20230203081913.81968-4-william.qiu@starfivetech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230203081913.81968-1-william.qiu@starfivetech.com>
References: <20230203081913.81968-1-william.qiu@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [171.223.208.138]
X-ClientProxiedBy: EXCAS064.cuchost.com (172.16.6.24) To EXMBX168.cuchost.com
 (172.16.6.78)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the mmc node for the StarFive JH7110 SoC.
Set mmco node to emmc and set mmc1 node to sd.

Signed-off-by: William Qiu <william.qiu@starfivetech.com>
---
 .../jh7110-starfive-visionfive-2.dtsi         | 23 ++++++++++++
 arch/riscv/boot/dts/starfive/jh7110.dtsi      | 37 +++++++++++++++++++
 2 files changed, 60 insertions(+)

diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
index c60280b89c73..e1a0248e907f 100644
--- a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
@@ -42,6 +42,29 @@ &rtc_osc {
 	clock-frequency = <32768>;
 };
 
+&mmc0 {
+	max-frequency = <100000000>;
+	bus-width = <8>;
+	cap-mmc-highspeed;
+	mmc-ddr-1_8v;
+	mmc-hs200-1_8v;
+	non-removable;
+	cap-mmc-hw-reset;
+	post-power-on-delay-ms = <200>;
+	status = "okay";
+};
+
+&mmc1 {
+	max-frequency = <100000000>;
+	bus-width = <4>;
+	no-sdio;
+	no-mmc;
+	broken-cd;
+	cap-sd-highspeed;
+	post-power-on-delay-ms = <200>;
+	status = "okay";
+};
+
 &gmac0_rmii_refin {
 	clock-frequency = <50000000>;
 };
diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi b/arch/riscv/boot/dts/starfive/jh7110.dtsi
index 64d260ea1f29..ae1a664e7af5 100644
--- a/arch/riscv/boot/dts/starfive/jh7110.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
@@ -370,6 +370,11 @@ syscrg: clock-controller@13020000 {
 			#reset-cells = <1>;
 		};
 
+		sysreg: syscon@13030000 {
+			compatible = "starfive,sysreg", "syscon";
+			reg = <0x0 0x13030000 0x0 0x1000>;
+		};
+
 		gpio: gpio@13040000 {
 			compatible = "starfive,jh7110-sys-pinctrl";
 			reg = <0x0 0x13040000 0x0 0x10000>;
@@ -407,5 +412,37 @@ gpioa: gpio@17020000 {
 			gpio-controller;
 			#gpio-cells = <2>;
 		};
+
+		mmc0: mmc@16010000 {
+			compatible = "starfive,jh7110-mmc";
+			reg = <0x0 0x16010000 0x0 0x10000>;
+			clocks = <&syscrg JH7110_SYSCLK_SDIO0_AHB>,
+				 <&syscrg JH7110_SYSCLK_SDIO0_SDCARD>;
+			clock-names = "biu","ciu";
+			resets = <&syscrg JH7110_SYSRST_SDIO0_AHB>;
+			reset-names = "reset";
+			interrupts = <74>;
+			fifo-depth = <32>;
+			fifo-watermark-aligned;
+			data-addr = <0>;
+			starfive,sysreg = <&sysreg 0x14 0x1a 0x7c000000>;
+			status = "disabled";
+		};
+
+		mmc1: mmc@16020000 {
+			compatible = "starfive,jh7110-mmc";
+			reg = <0x0 0x16020000 0x0 0x10000>;
+			clocks = <&syscrg JH7110_SYSCLK_SDIO1_AHB>,
+				 <&syscrg JH7110_SYSCLK_SDIO1_SDCARD>;
+			clock-names = "biu","ciu";
+			resets = <&syscrg JH7110_SYSRST_SDIO1_AHB>;
+			reset-names = "reset";
+			interrupts = <75>;
+			fifo-depth = <32>;
+			fifo-watermark-aligned;
+			data-addr = <0>;
+			starfive,sysreg = <&sysreg 0x9c 0x1 0x3e>;
+			status = "disabled";
+		};
 	};
 };
-- 
2.34.1

