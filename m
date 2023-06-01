Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EC8E719614
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 10:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232399AbjFAIwK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 1 Jun 2023 04:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231667AbjFAIwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 04:52:04 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 153B713D;
        Thu,  1 Jun 2023 01:52:00 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 712BC7FD6;
        Thu,  1 Jun 2023 16:51:58 +0800 (CST)
Received: from EXMBX168.cuchost.com (172.16.6.78) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 1 Jun
 2023 16:51:58 +0800
Received: from williamqiu-virtual-machine.starfivetech.com (171.223.208.138)
 by EXMBX168.cuchost.com (172.16.6.78) with Microsoft SMTP Server (TLS) id
 15.0.1497.42; Thu, 1 Jun 2023 16:51:57 +0800
From:   William Qiu <william.qiu@starfivetech.com>
To:     <devicetree@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
CC:     Thierry Reding <thierry.reding@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Hal Feng <hal.feng@starfivetech.com>,
        William Qiu <william.qiu@starfivetech.com>
Subject: [PATCH v4 3/4] riscv: dts: starfive: jh7110: Add PWM node and pins configuration
Date:   Thu, 1 Jun 2023 16:51:53 +0800
Message-ID: <20230601085154.36938-4-william.qiu@starfivetech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230601085154.36938-1-william.qiu@starfivetech.com>
References: <20230601085154.36938-1-william.qiu@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [171.223.208.138]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX168.cuchost.com
 (172.16.6.78)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add StarFive JH7110 PWM controller node and add PWM pins configuration
on VisionFive 2 board.

Reviewed-by: Hal Feng <hal.feng@starfivetech.com>
Signed-off-by: William Qiu <william.qiu@starfivetech.com>
---
 .../jh7110-starfive-visionfive-2.dtsi         | 22 +++++++++++++++++++
 arch/riscv/boot/dts/starfive/jh7110.dtsi      |  9 ++++++++
 2 files changed, 31 insertions(+)

diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
index 2a6d81609284..bbc2531999bc 100644
--- a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
@@ -126,6 +126,12 @@ &i2c6 {
 	status = "okay";
 };
 
+&ptc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pwm_pins>;
+	status = "okay";
+};
+
 &sysgpio {
 	i2c0_pins: i2c0-0 {
 		i2c-pins {
@@ -183,6 +189,22 @@ GPOEN_SYS_I2C6_DATA,
 		};
 	};
 
+	pwm_pins: pwm-0 {
+		pwm-pins {
+			pinmux = <GPIOMUX(46, GPOUT_SYS_PWM_CHANNEL0,
+					      GPOEN_SYS_PWM0_CHANNEL0,
+					      GPI_NONE)>,
+				 <GPIOMUX(59, GPOUT_SYS_PWM_CHANNEL1,
+					      GPOEN_SYS_PWM0_CHANNEL1,
+					      GPI_NONE)>;
+			bias-disable;
+			drive-strength = <12>;
+			input-disable;
+			input-schmitt-disable;
+			slew-rate = <0>;
+		};
+	};
+
 	uart0_pins: uart0-0 {
 		tx-pins {
 			pinmux = <GPIOMUX(5, GPOUT_SYS_UART0_TX,
diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi b/arch/riscv/boot/dts/starfive/jh7110.dtsi
index 4c5fdb905da8..a82b81d07d88 100644
--- a/arch/riscv/boot/dts/starfive/jh7110.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
@@ -440,6 +440,15 @@ i2c6: i2c@12060000 {
 			status = "disabled";
 		};
 
+		ptc: pwm@120d0000 {
+			compatible = "starfive,jh7110-pwm";
+			reg = <0x0 0x120d0000 0x0 0x10000>;
+			clocks = <&syscrg JH7110_SYSCLK_PWM_APB>;
+			resets = <&syscrg JH7110_SYSRST_PWM_APB>;
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+
 		syscrg: clock-controller@13020000 {
 			compatible = "starfive,jh7110-syscrg";
 			reg = <0x0 0x13020000 0x0 0x10000>;
-- 
2.34.1

