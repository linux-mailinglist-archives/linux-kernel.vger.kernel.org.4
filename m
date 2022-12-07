Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 076D0645A94
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 14:17:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbiLGNRm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 7 Dec 2022 08:17:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbiLGNRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 08:17:37 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EED591172;
        Wed,  7 Dec 2022 05:17:35 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id D0E4624E2AF;
        Wed,  7 Dec 2022 21:17:34 +0800 (CST)
Received: from EXMBX068.cuchost.com (172.16.6.68) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 7 Dec
 2022 21:17:35 +0800
Received: from williamqiu-virtual-machine.starfivetech.com (171.223.208.138)
 by EXMBX068.cuchost.com (172.16.6.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.42; Wed, 7 Dec 2022 21:17:34 +0800
From:   William Qiu <william.qiu@starfivetech.com>
To:     <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        William Qiu <william.qiu@starfivetech.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 3/3] riscv: dts: starfive: Add mmc node
Date:   Wed, 7 Dec 2022 21:17:31 +0800
Message-ID: <20221207131731.1291517-4-william.qiu@starfivetech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221207131731.1291517-1-william.qiu@starfivetech.com>
References: <20221207131731.1291517-1-william.qiu@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [171.223.208.138]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX068.cuchost.com
 (172.16.6.68)
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
Set sdioo node to emmc and set sdio1 node to sd.

Signed-off-by: William Qiu <william.qiu@starfivetech.com>
---
 .../jh7110-starfive-visionfive-v2.dts         | 25 ++++++++++++
 arch/riscv/boot/dts/starfive/jh7110.dtsi      | 38 +++++++++++++++++++
 2 files changed, 63 insertions(+)

diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-v2.dts b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-v2.dts
index c8946cf3a268..6ef8e303c2e6 100644
--- a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-v2.dts
+++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-v2.dts
@@ -47,6 +47,31 @@ &clk_rtc {
 	clock-frequency = <32768>;
 };
 
+&sdio0 {
+	max-frequency = <100000000>;
+	card-detect-delay = <300>;
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
+&sdio1 {
+	max-frequency = <100000000>;
+	card-detect-delay = <300>;
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
index c22e8f1d2640..e90b085d7e41 100644
--- a/arch/riscv/boot/dts/starfive/jh7110.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
@@ -331,6 +331,11 @@ aoncrg: clock-controller@17000000 {
 			#reset-cells = <1>;
 		};
 
+		sys_syscon: sys_syscon@13030000 {
+			compatible = "syscon";
+			reg = <0x0 0x13030000 0x0 0x1000>;
+		};
+
 		gpio: gpio@13040000 {
 			compatible = "starfive,jh7110-sys-pinctrl";
 			reg = <0x0 0x13040000 0x0 0x10000>;
@@ -433,5 +438,38 @@ uart5: serial@12020000 {
 			reg-shift = <2>;
 			status = "disabled";
 		};
+
+		/* unremovable emmc as mmcblk0 */
+		sdio0: mmc@16010000 {
+			compatible = "starfive,jh7110-sdio";
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
+			starfive,sys-syscon = <&sys_syscon 0x14 0x1a 0x7c000000>;
+			status = "disabled";
+		};
+
+		sdio1: mmc@16020000 {
+			compatible = "starfive,jh7110-sdio";
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
+			starfive,sys-syscon = <&sys_syscon 0x9c 0x1 0x3e>;
+			status = "disabled";
+		};
 	};
 };
-- 
2.34.1

