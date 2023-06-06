Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD00E724051
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 12:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236805AbjFFK6V convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 6 Jun 2023 06:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235920AbjFFK5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 06:57:17 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B9B6170C;
        Tue,  6 Jun 2023 03:57:01 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 41B3781DC;
        Tue,  6 Jun 2023 18:57:00 +0800 (CST)
Received: from EXMBX067.cuchost.com (172.16.6.67) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 6 Jun
 2023 18:57:00 +0800
Received: from localhost.localdomain (183.27.98.75) by EXMBX067.cuchost.com
 (172.16.6.67) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 6 Jun
 2023 18:56:59 +0800
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
Subject: [PATCH v4 3/3] riscv: dts: starfive: Add cpu scaling for JH7110 SoC
Date:   Tue, 6 Jun 2023 18:56:56 +0800
Message-ID: <20230606105656.124355-4-mason.huo@starfivetech.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230606105656.124355-1-mason.huo@starfivetech.com>
References: <20230606105656.124355-1-mason.huo@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [183.27.98.75]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX067.cuchost.com
 (172.16.6.67)
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

Add the operating-points-v2 to support cpu scaling on StarFive JH7110 SoC.
It supports up to 4 cpu frequency loads.

Signed-off-by: Mason Huo <mason.huo@starfivetech.com>
---
 .../jh7110-starfive-visionfive-2.dtsi         | 16 +++++++++
 arch/riscv/boot/dts/starfive/jh7110.dtsi      | 33 +++++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
index 9714da5550d7..fa0061eb33a7 100644
--- a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
@@ -230,3 +230,19 @@ &uart0 {
 	pinctrl-0 = <&uart0_pins>;
 	status = "okay";
 };
+
+&U74_1 {
+	cpu-supply = <&vdd_cpu>;
+};
+
+&U74_2 {
+	cpu-supply = <&vdd_cpu>;
+};
+
+&U74_3 {
+	cpu-supply = <&vdd_cpu>;
+};
+
+&U74_4 {
+	cpu-supply = <&vdd_cpu>;
+};
diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi b/arch/riscv/boot/dts/starfive/jh7110.dtsi
index 4c5fdb905da8..7eef88d2cedb 100644
--- a/arch/riscv/boot/dts/starfive/jh7110.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
@@ -53,6 +53,9 @@ U74_1: cpu@1 {
 			next-level-cache = <&ccache>;
 			riscv,isa = "rv64imafdc_zba_zbb";
 			tlb-split;
+			operating-points-v2 = <&cpu_opp>;
+			clocks = <&syscrg JH7110_SYSCLK_CPU_CORE>;
+			clock-names = "cpu";
 
 			cpu1_intc: interrupt-controller {
 				compatible = "riscv,cpu-intc";
@@ -79,6 +82,9 @@ U74_2: cpu@2 {
 			next-level-cache = <&ccache>;
 			riscv,isa = "rv64imafdc_zba_zbb";
 			tlb-split;
+			operating-points-v2 = <&cpu_opp>;
+			clocks = <&syscrg JH7110_SYSCLK_CPU_CORE>;
+			clock-names = "cpu";
 
 			cpu2_intc: interrupt-controller {
 				compatible = "riscv,cpu-intc";
@@ -105,6 +111,9 @@ U74_3: cpu@3 {
 			next-level-cache = <&ccache>;
 			riscv,isa = "rv64imafdc_zba_zbb";
 			tlb-split;
+			operating-points-v2 = <&cpu_opp>;
+			clocks = <&syscrg JH7110_SYSCLK_CPU_CORE>;
+			clock-names = "cpu";
 
 			cpu3_intc: interrupt-controller {
 				compatible = "riscv,cpu-intc";
@@ -131,6 +140,9 @@ U74_4: cpu@4 {
 			next-level-cache = <&ccache>;
 			riscv,isa = "rv64imafdc_zba_zbb";
 			tlb-split;
+			operating-points-v2 = <&cpu_opp>;
+			clocks = <&syscrg JH7110_SYSCLK_CPU_CORE>;
+			clock-names = "cpu";
 
 			cpu4_intc: interrupt-controller {
 				compatible = "riscv,cpu-intc";
@@ -164,6 +176,27 @@ core4 {
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

