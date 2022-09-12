Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C0A35B5540
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 09:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbiILHUF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 03:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbiILHS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 03:18:57 -0400
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5AEE22DABE;
        Mon, 12 Sep 2022 00:17:11 -0700 (PDT)
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 12 Sep 2022 16:16:00 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id DEA102059027;
        Mon, 12 Sep 2022 16:15:59 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Mon, 12 Sep 2022 16:15:59 +0900
Received: from plum.e01.socionext.com (unknown [10.212.243.119])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 2E24BB62AE;
        Mon, 12 Sep 2022 16:15:59 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     soc@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH v2 9/9] arm64: dts: uniphier: Add L2 cache node
Date:   Mon, 12 Sep 2022 16:15:54 +0900
Message-Id: <20220912071554.1480-10-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220912071554.1480-1-hayashi.kunihiko@socionext.com>
References: <20220912071554.1480-1-hayashi.kunihiko@socionext.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a L2 cache node referenced from CPU nodes as the missing cache
hierarchy information because the following warning was issued.

  cacheinfo: Unable to detect cache hierarchy for CPU 0
  Early cacheinfo failed, ret = -2

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi |  6 ++++++
 arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi | 12 ++++++++++++
 arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi |  8 ++++++++
 3 files changed, 26 insertions(+)

diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi b/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
index 6a7d7973e9dd..a75356db006b 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
@@ -36,6 +36,7 @@ cpu0: cpu@0 {
 			reg = <0 0x000>;
 			clocks = <&sys_clk 33>;
 			enable-method = "psci";
+			next-level-cache = <&l2>;
 			operating-points-v2 = <&cluster0_opp>;
 		};
 
@@ -45,8 +46,13 @@ cpu1: cpu@1 {
 			reg = <0 0x001>;
 			clocks = <&sys_clk 33>;
 			enable-method = "psci";
+			next-level-cache = <&l2>;
 			operating-points-v2 = <&cluster0_opp>;
 		};
+
+		l2: l2-cache {
+			compatible = "cache";
+		};
 	};
 
 	cluster0_opp: opp-table {
diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi b/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
index e24784e12b7b..1e6317e371ba 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
@@ -46,6 +46,7 @@ cpu0: cpu@0 {
 			reg = <0 0x000>;
 			clocks = <&sys_clk 32>;
 			enable-method = "psci";
+			next-level-cache = <&a72_l2>;
 			operating-points-v2 = <&cluster0_opp>;
 			#cooling-cells = <2>;
 		};
@@ -56,6 +57,7 @@ cpu1: cpu@1 {
 			reg = <0 0x001>;
 			clocks = <&sys_clk 32>;
 			enable-method = "psci";
+			next-level-cache = <&a72_l2>;
 			operating-points-v2 = <&cluster0_opp>;
 			#cooling-cells = <2>;
 		};
@@ -66,6 +68,7 @@ cpu2: cpu@100 {
 			reg = <0 0x100>;
 			clocks = <&sys_clk 33>;
 			enable-method = "psci";
+			next-level-cache = <&a53_l2>;
 			operating-points-v2 = <&cluster1_opp>;
 			#cooling-cells = <2>;
 		};
@@ -76,9 +79,18 @@ cpu3: cpu@101 {
 			reg = <0 0x101>;
 			clocks = <&sys_clk 33>;
 			enable-method = "psci";
+			next-level-cache = <&a53_l2>;
 			operating-points-v2 = <&cluster1_opp>;
 			#cooling-cells = <2>;
 		};
+
+		a72_l2: l2-cache0 {
+			compatible = "cache";
+		};
+
+		a53_l2: l2-cache1 {
+			compatible = "cache";
+		};
 	};
 
 	cluster0_opp: opp-table-0 {
diff --git a/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi b/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi
index 6277be04a974..72ba6a52233e 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi
@@ -43,6 +43,7 @@ cpu0: cpu@0 {
 			reg = <0 0x000>;
 			clocks = <&sys_clk 33>;
 			enable-method = "psci";
+			next-level-cache = <&l2>;
 			operating-points-v2 = <&cluster0_opp>;
 			#cooling-cells = <2>;
 		};
@@ -53,6 +54,7 @@ cpu1: cpu@1 {
 			reg = <0 0x001>;
 			clocks = <&sys_clk 33>;
 			enable-method = "psci";
+			next-level-cache = <&l2>;
 			operating-points-v2 = <&cluster0_opp>;
 			#cooling-cells = <2>;
 		};
@@ -63,6 +65,7 @@ cpu2: cpu@2 {
 			reg = <0 0x002>;
 			clocks = <&sys_clk 33>;
 			enable-method = "psci";
+			next-level-cache = <&l2>;
 			operating-points-v2 = <&cluster0_opp>;
 			#cooling-cells = <2>;
 		};
@@ -73,9 +76,14 @@ cpu3: cpu@3 {
 			reg = <0 0x003>;
 			clocks = <&sys_clk 33>;
 			enable-method = "psci";
+			next-level-cache = <&l2>;
 			operating-points-v2 = <&cluster0_opp>;
 			#cooling-cells = <2>;
 		};
+
+		l2: l2-cache {
+			compatible = "cache";
+		};
 	};
 
 	cluster0_opp: opp-table {
-- 
2.25.1

