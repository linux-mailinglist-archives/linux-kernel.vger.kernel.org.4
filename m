Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36647702D2F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 14:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242025AbjEOMy4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 15 May 2023 08:54:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242038AbjEOMyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 08:54:31 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D004B199F;
        Mon, 15 May 2023 05:54:29 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 2AF1880A8;
        Mon, 15 May 2023 20:54:28 +0800 (CST)
Received: from EXMBX168.cuchost.com (172.16.6.78) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 15 May
 2023 20:54:28 +0800
Received: from ubuntu.localdomain (161.142.156.10) by EXMBX168.cuchost.com
 (172.16.6.78) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 15 May
 2023 20:54:21 +0800
From:   Jia Jie Ho <jiajie.ho@starfivetech.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Conor Dooley <conor@kernel.org>
CC:     <linux-crypto@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
Subject: [PATCH v8 3/4] riscv: dts: starfive: Add crypto and DMA node for VisionFive 2
Date:   Mon, 15 May 2023 20:53:54 +0800
Message-ID: <20230515125355.624250-4-jiajie.ho@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230515125355.624250-1-jiajie.ho@starfivetech.com>
References: <20230515125355.624250-1-jiajie.ho@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [161.142.156.10]
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

Add StarFive cryptographic module and dedicated DMA controller node to
VisionFive 2 SoCs.

Co-developed-by: Huan Feng <huan.feng@starfivetech.com>
Signed-off-by: Huan Feng <huan.feng@starfivetech.com>
Signed-off-by: Jia Jie Ho <jiajie.ho@starfivetech.com>
Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 arch/riscv/boot/dts/starfive/jh7110.dtsi | 28 ++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi b/arch/riscv/boot/dts/starfive/jh7110.dtsi
index 9acb5fb1716d..7a0ba2748582 100644
--- a/arch/riscv/boot/dts/starfive/jh7110.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
@@ -570,5 +570,33 @@ voutcrg: clock-controller@295c0000 {
 			#reset-cells = <1>;
 			power-domains = <&pwrc JH7110_PD_VOUT>;
 		};
+
+		sdma: dma@16008000 {
+			compatible = "arm,pl080", "arm,primecell";
+			arm,primecell-periphid = <0x00041080>;
+			reg = <0x0 0x16008000 0x0 0x4000>;
+			interrupts = <29>;
+			clocks = <&stgcrg JH7110_STGCLK_SEC_AHB>,
+				 <&stgcrg JH7110_STGCLK_SEC_MISC_AHB>;
+			clock-names = "hclk", "apb_pclk";
+			resets = <&stgcrg JH7110_STGRST_SEC_AHB>;
+			lli-bus-interface-ahb1;
+			mem-bus-interface-ahb1;
+			memcpy-burst-size = <256>;
+			memcpy-bus-width = <32>;
+			#dma-cells = <2>;
+		};
+
+		crypto: crypto@16000000 {
+			compatible = "starfive,jh7110-crypto";
+			reg = <0x0 0x16000000 0x0 0x4000>;
+			clocks = <&stgcrg JH7110_STGCLK_SEC_AHB>,
+				 <&stgcrg JH7110_STGCLK_SEC_MISC_AHB>;
+			clock-names = "hclk", "ahb";
+			interrupts = <28>;
+			resets = <&stgcrg JH7110_STGRST_SEC_AHB>;
+			dmas = <&sdma 1 2>, <&sdma 0 2>;
+			dma-names = "tx", "rx";
+		};
 	};
 };
-- 
2.25.1

