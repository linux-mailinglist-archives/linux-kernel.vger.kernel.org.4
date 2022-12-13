Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6768964C032
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 00:02:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236904AbiLMXC3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 18:02:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236954AbiLMXCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 18:02:10 -0500
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3E8FF2AED;
        Tue, 13 Dec 2022 15:02:03 -0800 (PST)
X-IronPort-AV: E=Sophos;i="5.96,242,1665414000"; 
   d="scan'208";a="143231157"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 14 Dec 2022 08:02:02 +0900
Received: from mulinux.home (unknown [10.226.93.1])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 1F508400D4F6;
        Wed, 14 Dec 2022 08:01:56 +0900 (JST)
From:   Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo@jmondi.org>
Subject: [PATCH 4/4] arm64: dts: renesas: r9a09g011: Add eMMC and SDHI support
Date:   Tue, 13 Dec 2022 23:01:29 +0000
Message-Id: <20221213230129.549968-5-fabrizio.castro.jz@renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221213230129.549968-1-fabrizio.castro.jz@renesas.com>
References: <20221213230129.549968-1-fabrizio.castro.jz@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RZ/V2M comes with 2 SDHI interfaces and 1 eMMC interface.
Add the relevant nodes to the SoC specific device tree.

Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a09g011.dtsi | 48 ++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g011.dtsi b/arch/arm64/boot/dts/renesas/r9a09g011.dtsi
index 0373ec409d54..dd35a8ff72ee 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g011.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a09g011.dtsi
@@ -69,6 +69,54 @@ gic: interrupt-controller@82010000 {
 			clock-names = "clk";
 		};
 
+		sdhi0: mmc@85000000 {
+			compatible = "renesas,sdhi-r9a09g011",
+				     "renesas,rcar-gen3-sdhi";
+			reg = <0x0 0x85000000 0 0x2000>;
+			interrupts = <GIC_SPI 356 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 357 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD R9A09G011_SDI0_IMCLK>,
+				 <&cpg CPG_MOD R9A09G011_SDI0_CLK_HS>,
+				 <&cpg CPG_MOD R9A09G011_SDI0_IMCLK2>,
+				 <&cpg CPG_MOD R9A09G011_SDI0_ACLK>;
+			clock-names = "core", "clkh", "cd", "aclk";
+			resets = <&cpg R9A09G011_SDI0_IXRST>;
+			power-domains = <&cpg>;
+			status = "disabled";
+		};
+
+		sdhi1: mmc@85010000  {
+			compatible = "renesas,sdhi-r9a09g011",
+				     "renesas,rcar-gen3-sdhi";
+			reg = <0x0 0x85010000 0 0x2000>;
+			interrupts = <GIC_SPI 358 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 359 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD R9A09G011_SDI1_IMCLK>,
+				 <&cpg CPG_MOD R9A09G011_SDI1_CLK_HS>,
+				 <&cpg CPG_MOD R9A09G011_SDI1_IMCLK2>,
+				 <&cpg CPG_MOD R9A09G011_SDI1_ACLK>;
+			clock-names = "core", "clkh", "cd", "aclk";
+			resets = <&cpg R9A09G011_SDI1_IXRST>;
+			power-domains = <&cpg>;
+			status = "disabled";
+		};
+
+		emmc: mmc@85020000  {
+			compatible = "renesas,sdhi-r9a09g011",
+				     "renesas,rcar-gen3-sdhi";
+			reg = <0x0 0x85020000 0 0x2000>;
+			interrupts = <GIC_SPI 354 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 355 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD R9A09G011_EMM_IMCLK>,
+				 <&cpg CPG_MOD R9A09G011_EMM_CLK_HS>,
+				 <&cpg CPG_MOD R9A09G011_EMM_IMCLK2>,
+				 <&cpg CPG_MOD R9A09G011_EMM_ACLK>;
+			clock-names = "core", "clkh", "cd", "aclk";
+			resets = <&cpg R9A09G011_EMM_IXRST>;
+			power-domains = <&cpg>;
+			status = "disabled";
+		};
+
 		avb: ethernet@a3300000 {
 			compatible = "renesas,etheravb-r9a09g011","renesas,etheravb-rzv2m";
 			reg = <0 0xa3300000 0 0x800>;
-- 
2.34.1

