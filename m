Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA9FB6ABA74
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 10:54:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbjCFJyX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 04:54:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjCFJyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 04:54:20 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F351EBD0;
        Mon,  6 Mar 2023 01:54:11 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 4F44724DBBD;
        Mon,  6 Mar 2023 17:54:10 +0800 (CST)
Received: from EXMBX071.cuchost.com (172.16.6.81) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 6 Mar
 2023 17:54:10 +0800
Received: from ubuntu.localdomain (183.27.97.46) by EXMBX071.cuchost.com
 (172.16.6.81) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 6 Mar
 2023 17:54:09 +0800
From:   Minda Chen <minda.chen@starfivetech.com>
To:     Emil Renner Berthing <kernel@esmil.dk>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>,
        Minda Chen <minda.chen@starfivetech.com>
Subject: [PATCH 3/3] dts: usb: add StarFive JH7110 USB dts configuration.
Date:   Mon, 6 Mar 2023 17:54:08 +0800
Message-ID: <20230306095408.26057-1-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [183.27.97.46]
X-ClientProxiedBy: EXCAS064.cuchost.com (172.16.6.24) To EXMBX071.cuchost.com
 (172.16.6.81)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

USB phy dts configuration. Also includes Cadence USB
subnode configuration.

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
---
 .../jh7110-starfive-visionfive-2.dtsi         |  6 +++
 arch/riscv/boot/dts/starfive/jh7110.dtsi      | 39 +++++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
index e8b8f4346fdd..2a9ed8b9ee25 100644
--- a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
@@ -244,3 +244,9 @@
 		};
 	};
 };
+
+&usb0 {
+	starfive,usb2-only;
+	dr_mode = "peripheral";
+	status = "okay";
+};
diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi b/arch/riscv/boot/dts/starfive/jh7110.dtsi
index be180f23963e..ee665cdc3510 100644
--- a/arch/riscv/boot/dts/starfive/jh7110.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
@@ -628,5 +628,44 @@
 			starfive,sysreg = <&sys_syscon 0x9c 0x1 0x3e>;
 			status = "disabled";
 		};
+
+		usb0: usbphy@10200000 {
+			compatible = "starfive,jh7110-usb";
+			reg = <0x0 0x10210000 0x0 0x1000>,
+			      <0x0 0x10200000 0x0 0x1000>;
+			reg-names = "usb3", "usb2";
+			clocks = <&syscrg JH7110_SYSCLK_USB_125M>,
+				 <&stgcrg JH7110_STGCLK_USB0_APP_125>,
+				 <&stgcrg JH7110_STGCLK_USB0_LPM>,
+				 <&stgcrg JH7110_STGCLK_USB0_STB>,
+				 <&stgcrg JH7110_STGCLK_USB0_APB>,
+				 <&stgcrg JH7110_STGCLK_USB0_AXI>,
+				 <&stgcrg JH7110_STGCLK_USB0_UTMI_APB>;
+			clock-names = "usb_125m", "usb0_app_125", "usb0_lpm",
+				"usb0_stb", "usb0_apb", "usb0_axi", "usb0_utmi_apb";
+			resets = <&stgcrg JH7110_STGRST_USB0_PWRUP>,
+				 <&stgcrg JH7110_STGRST_USB0_APB>,
+				 <&stgcrg JH7110_STGRST_USB0_AXI>,
+				 <&stgcrg JH7110_STGRST_USB0_UTMI_APB>;
+			starfive,stg-syscon = <&stg_syscon 0x4 0xc4 0x148 0x1f4>;
+			starfive,sys-syscon = <&sys_syscon 0x18>;
+			status = "disabled";
+			#address-cells = <2>;
+			#size-cells = <2>;
+			#interrupt-cells = <1>;
+			#phy-cells = <0>;
+			ranges;
+			usbdrd_cdns3: usb@10100000 {
+				compatible = "cdns,usb3";
+				reg = <0x0 0x10100000 0x0 0x10000>,
+				      <0x0 0x10110000 0x0 0x10000>,
+				      <0x0 0x10120000 0x0 0x10000>;
+				reg-names = "otg", "xhci", "dev";
+				interrupts = <100>, <108>, <110>;
+				interrupt-names = "host", "peripheral", "otg";
+				phy-names = "cdns3,usb3-phy", "cnds3,usb2-phy";
+				maximum-speed = "super-speed";
+			};
+		};
 	};
 };
-- 
2.17.1

