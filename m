Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DB2D6DD5AB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 10:33:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbjDKIdJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 11 Apr 2023 04:33:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230459AbjDKIdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 04:33:03 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F491E62;
        Tue, 11 Apr 2023 01:33:02 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 1910C24E29A;
        Tue, 11 Apr 2023 16:33:01 +0800 (CST)
Received: from EXMBX067.cuchost.com (172.16.6.67) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 11 Apr
 2023 16:33:01 +0800
Received: from localhost.localdomain (113.72.145.176) by EXMBX067.cuchost.com
 (172.16.6.67) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 11 Apr
 2023 16:33:00 +0800
From:   Mason Huo <mason.huo@starfivetech.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor@kernel.org>,
        "Paul Walmsley" <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
CC:     Shengyu Qu <wiagn233@outlook.com>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>,
        Mason Huo <mason.huo@starfivetech.com>
Subject: [PATCH v1 3/3] riscv: dts: starfive: Add cpu scaling for JH7110 SoC
Date:   Tue, 11 Apr 2023 16:32:57 +0800
Message-ID: <20230411083257.16155-4-mason.huo@starfivetech.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230411083257.16155-1-mason.huo@starfivetech.com>
References: <20230411083257.16155-1-mason.huo@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [113.72.145.176]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX067.cuchost.com
 (172.16.6.67)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the operating-points-v2 to support cpu scaling
on StarFive JH7110 SoC.
It supports up to 4 cpu frequency loads.

Signed-off-by: Mason Huo <mason.huo@starfivetech.com>
---
 .../jh7110-starfive-visionfive-2.dtsi         | 25 +++++++++++++++++++
 arch/riscv/boot/dts/starfive/jh7110.dtsi      | 25 +++++++++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
index df582bddae4b..ae446b268e78 100644
--- a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
@@ -228,3 +228,28 @@ &uart0 {
 	pinctrl-0 = <&uart0_pins>;
 	status = "okay";
 };
+
+&U74_1 {
+	clocks =  <&syscrg JH7110_SYSCLK_CPU_CORE>;
+	clock-names = "cpu";
+	cpu-supply = <&reg_dcdc2>;
+};
+
+&U74_2 {
+	clocks =  <&syscrg JH7110_SYSCLK_CPU_CORE>;
+	clock-names = "cpu";
+	cpu-supply = <&reg_dcdc2>;
+};
+
+&U74_3 {
+	clocks =  <&syscrg JH7110_SYSCLK_CPU_CORE>;
+	clock-names = "cpu";
+	cpu-supply = <&reg_dcdc2>;
+};
+
+&U74_4 {
+	clocks =  <&syscrg JH7110_SYSCLK_CPU_CORE>;
+	clock-names = "cpu";
+	cpu-supply = <&reg_dcdc2>;
+};
+
diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi b/arch/riscv/boot/dts/starfive/jh7110.dtsi
index 4c5fdb905da8..c867f968d054 100644
--- a/arch/riscv/boot/dts/starfive/jh7110.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
@@ -53,6 +53,7 @@ U74_1: cpu@1 {
 			next-level-cache = <&ccache>;
 			riscv,isa = "rv64imafdc_zba_zbb";
 			tlb-split;
+			operating-points-v2 = <&cpu_opp>;
 
 			cpu1_intc: interrupt-controller {
 				compatible = "riscv,cpu-intc";
@@ -79,6 +80,7 @@ U74_2: cpu@2 {
 			next-level-cache = <&ccache>;
 			riscv,isa = "rv64imafdc_zba_zbb";
 			tlb-split;
+			operating-points-v2 = <&cpu_opp>;
 
 			cpu2_intc: interrupt-controller {
 				compatible = "riscv,cpu-intc";
@@ -105,6 +107,7 @@ U74_3: cpu@3 {
 			next-level-cache = <&ccache>;
 			riscv,isa = "rv64imafdc_zba_zbb";
 			tlb-split;
+			operating-points-v2 = <&cpu_opp>;
 
 			cpu3_intc: interrupt-controller {
 				compatible = "riscv,cpu-intc";
@@ -131,6 +134,7 @@ U74_4: cpu@4 {
 			next-level-cache = <&ccache>;
 			riscv,isa = "rv64imafdc_zba_zbb";
 			tlb-split;
+			operating-points-v2 = <&cpu_opp>;
 
 			cpu4_intc: interrupt-controller {
 				compatible = "riscv,cpu-intc";
@@ -164,6 +168,27 @@ core4 {
 		};
 	};
 
+	cpu_opp: opp-table-0 {
+			compatible = "operating-points-v2";
+			opp-shared;
+			opp-375000000 {
+					opp-hz = /bits/ 64 <375000000>;
+					opp-microvolt = <800000>;
+			};
+			opp-500000000 {
+					opp-hz = /bits/ 64 <500000000>;
+					opp-microvolt = <800000>;
+			};
+			opp-750000000 {
+					opp-hz = /bits/ 64 <750000000>;
+					opp-microvolt = <800000>;
+			};
+			opp-1500000000 {
+					opp-hz = /bits/ 64 <1500000000>;
+					opp-microvolt = <1040000>;
+			};
+	};
+
 	gmac0_rgmii_rxin: gmac0-rgmii-rxin-clock {
 		compatible = "fixed-clock";
 		clock-output-names = "gmac0_rgmii_rxin";
-- 
2.39.2

