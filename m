Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A58BA68396C
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 23:36:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231838AbjAaWgB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 17:36:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231827AbjAaWf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 17:35:57 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0F1E13D5B;
        Tue, 31 Jan 2023 14:35:48 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id r2so15628058wrv.7;
        Tue, 31 Jan 2023 14:35:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9mbTVx8FxTfMXPO88ig9RYaCFweThZBwI2jxlquHSGI=;
        b=jaau6Vc3tnJ7qJhMlo7lj468TK1jNtLja/x9+Wl4H5P4nqE9g9kD5dYLtyPow/0jou
         PFYAOeCUCoNRPhydd4Nfyc2StVzfFvqkmNuDq4gU+k1H7jX3zVRgG3FJ5QntZHM3Ssyp
         RcWQwUJH3BDRX6X3T3Q8WqEVb7Nwp3DHLQya2I39tyOLz0em8tP0Yc66OjhM436RMMf0
         hRIo8S0PY0pPRIjQYCP4iVWtgW8xTlW+jtMDOVl426k+yKOiyEyABkSPEABt51EEpIjf
         FytlN/n3y8AaXr3l2k4QZTxyNtxR980trlf3sRFr1XV/XfEXf3vyln2Q0clDxJZxFhtz
         Gh8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9mbTVx8FxTfMXPO88ig9RYaCFweThZBwI2jxlquHSGI=;
        b=ul4BTVWgc2a6SjnCMTZIEn+w11fsLudUOHevlPvZUsN7HCWO3UsfH667Y5sIJAncWM
         a5VpDH6ubG4fiyfmvhL+EECM1pzpYlqWj6/tfSjiizZ3QKDdBmGLMb+RQ7z0w4CTe4et
         UATRpFa3l8Y09N6OXhafvbY+26MYvQPXpqxciJC9P8/5hwV4OYxW8AL8LqGI2bPKU2EF
         A8oRXXKgQMZkK2WCoIjkvurIlGAiFQM9JnmjtkiYSYNblH8ORBBxifqjcgS2q9SIYeD1
         3SbyKl7mJIK2Z6TGuU36ObWj7zbckLadVGdBZuw2VHeAnzutW6c8L/iFebaYQhNbIMqn
         B3mw==
X-Gm-Message-State: AO0yUKXE5WbePLRJKsJmcoj2VLTpohcJYh0GBOnZZ42nVTe/194C6C8H
        eOC8g2nbe8NuJA8JMLsQpUo=
X-Google-Smtp-Source: AK7set+Toql+MMyxBfHf+r6+Z/TufLL2C+XMDbfzCEoGzsunnJnWlDBFfAels3hjzo/jPmS7DBReRQ==
X-Received: by 2002:a05:6000:102:b0:2bf:abce:ba26 with SMTP id o2-20020a056000010200b002bfabceba26mr493883wrx.71.1675204547243;
        Tue, 31 Jan 2023 14:35:47 -0800 (PST)
Received: from prasmi.home ([2a00:23c8:2501:c701:a572:ff5:a6d8:66bc])
        by smtp.gmail.com with ESMTPSA id e10-20020a5d500a000000b002be0b1e556esm15523184wrt.59.2023.01.31.14.35.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 14:35:46 -0800 (PST)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v2 1/2] arm64: dts: renesas: r9a07g044: Use SoC specific macro for CPG and RESET
Date:   Tue, 31 Jan 2023 22:35:28 +0000
Message-Id: <20230131223529.11905-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230131223529.11905-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20230131223529.11905-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Use a SoC specific macro for CPG and RESET so that we can re-use the
RZ/G2L SoC DTSI for RZ/V2L SoC by just updating the SoC specific macro.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v1->v2
* No change
---
 arch/arm64/boot/dts/renesas/r9a07g044.dtsi | 254 +++++++++++----------
 1 file changed, 129 insertions(+), 125 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r9a07g044.dtsi b/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
index 487536696d90..80b2332798d9 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
@@ -1,12 +1,16 @@
 // SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 /*
- * Device Tree Source for the RZ/G2L and RZ/G2LC common SoC parts
+ * Device Tree Source for the RZ/G2L, RZ/G2LC and RZ/V2L common SoC parts
  *
  * Copyright (C) 2021 Renesas Electronics Corp.
  */
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+#ifndef SOC_CPG_PREFIX
 #include <dt-bindings/clock/r9a07g044-cpg.h>
+#define SOC_CPG_PREFIX(X)	R9A07G044_ ## X
+#endif
 
 / {
 	compatible = "renesas,r9a07g044";
@@ -91,7 +95,7 @@ cpu0: cpu@0 {
 			#cooling-cells = <2>;
 			next-level-cache = <&L3_CA55>;
 			enable-method = "psci";
-			clocks = <&cpg CPG_CORE R9A07G044_CLK_I>;
+			clocks = <&cpg CPG_CORE SOC_CPG_PREFIX(CLK_I)>;
 			operating-points-v2 = <&cluster0_opp>;
 		};
 
@@ -101,7 +105,7 @@ cpu1: cpu@100 {
 			device_type = "cpu";
 			next-level-cache = <&L3_CA55>;
 			enable-method = "psci";
-			clocks = <&cpg CPG_CORE R9A07G044_CLK_I>;
+			clocks = <&cpg CPG_CORE SOC_CPG_PREFIX(CLK_I)>;
 			operating-points-v2 = <&cluster0_opp>;
 		};
 
@@ -178,11 +182,11 @@ ssi0: ssi@10049c00 {
 				     <GIC_SPI 328 IRQ_TYPE_EDGE_RISING>,
 				     <GIC_SPI 329 IRQ_TYPE_EDGE_RISING>;
 			interrupt-names = "int_req", "dma_rx", "dma_tx", "dma_rt";
-			clocks = <&cpg CPG_MOD R9A07G044_SSI0_PCLK2>,
-				 <&cpg CPG_MOD R9A07G044_SSI0_PCLK_SFR>,
+			clocks = <&cpg CPG_MOD SOC_CPG_PREFIX(SSI0_PCLK2)>,
+				 <&cpg CPG_MOD SOC_CPG_PREFIX(SSI0_PCLK_SFR)>,
 				 <&audio_clk1>, <&audio_clk2>;
 			clock-names = "ssi", "ssi_sfr", "audio_clk1", "audio_clk2";
-			resets = <&cpg R9A07G044_SSI0_RST_M2_REG>;
+			resets = <&cpg SOC_CPG_PREFIX(SSI0_RST_M2_REG)>;
 			dmas = <&dmac 0x2655>, <&dmac 0x2656>;
 			dma-names = "tx", "rx";
 			power-domains = <&cpg>;
@@ -199,11 +203,11 @@ ssi1: ssi@1004a000 {
 				     <GIC_SPI 332 IRQ_TYPE_EDGE_RISING>,
 				     <GIC_SPI 333 IRQ_TYPE_EDGE_RISING>;
 			interrupt-names = "int_req", "dma_rx", "dma_tx", "dma_rt";
-			clocks = <&cpg CPG_MOD R9A07G044_SSI1_PCLK2>,
-				 <&cpg CPG_MOD R9A07G044_SSI1_PCLK_SFR>,
+			clocks = <&cpg CPG_MOD SOC_CPG_PREFIX(SSI1_PCLK2)>,
+				 <&cpg CPG_MOD SOC_CPG_PREFIX(SSI1_PCLK_SFR)>,
 				 <&audio_clk1>, <&audio_clk2>;
 			clock-names = "ssi", "ssi_sfr", "audio_clk1", "audio_clk2";
-			resets = <&cpg R9A07G044_SSI1_RST_M2_REG>;
+			resets = <&cpg SOC_CPG_PREFIX(SSI1_RST_M2_REG)>;
 			dmas = <&dmac 0x2659>, <&dmac 0x265a>;
 			dma-names = "tx", "rx";
 			power-domains = <&cpg>;
@@ -220,11 +224,11 @@ ssi2: ssi@1004a400 {
 				     <GIC_SPI 336 IRQ_TYPE_EDGE_RISING>,
 				     <GIC_SPI 337 IRQ_TYPE_EDGE_RISING>;
 			interrupt-names = "int_req", "dma_rx", "dma_tx", "dma_rt";
-			clocks = <&cpg CPG_MOD R9A07G044_SSI2_PCLK2>,
-				 <&cpg CPG_MOD R9A07G044_SSI2_PCLK_SFR>,
+			clocks = <&cpg CPG_MOD SOC_CPG_PREFIX(SSI2_PCLK2)>,
+				 <&cpg CPG_MOD SOC_CPG_PREFIX(SSI2_PCLK_SFR)>,
 				 <&audio_clk1>, <&audio_clk2>;
 			clock-names = "ssi", "ssi_sfr", "audio_clk1", "audio_clk2";
-			resets = <&cpg R9A07G044_SSI2_RST_M2_REG>;
+			resets = <&cpg SOC_CPG_PREFIX(SSI2_RST_M2_REG)>;
 			dmas = <&dmac 0x265f>;
 			dma-names = "rt";
 			power-domains = <&cpg>;
@@ -241,11 +245,11 @@ ssi3: ssi@1004a800 {
 				     <GIC_SPI 340 IRQ_TYPE_EDGE_RISING>,
 				     <GIC_SPI 341 IRQ_TYPE_EDGE_RISING>;
 			interrupt-names = "int_req", "dma_rx", "dma_tx", "dma_rt";
-			clocks = <&cpg CPG_MOD R9A07G044_SSI3_PCLK2>,
-				 <&cpg CPG_MOD R9A07G044_SSI3_PCLK_SFR>,
+			clocks = <&cpg CPG_MOD SOC_CPG_PREFIX(SSI3_PCLK2)>,
+				 <&cpg CPG_MOD SOC_CPG_PREFIX(SSI3_PCLK_SFR)>,
 				 <&audio_clk1>, <&audio_clk2>;
 			clock-names = "ssi", "ssi_sfr", "audio_clk1", "audio_clk2";
-			resets = <&cpg R9A07G044_SSI3_RST_M2_REG>;
+			resets = <&cpg SOC_CPG_PREFIX(SSI3_RST_M2_REG)>;
 			dmas = <&dmac 0x2661>, <&dmac 0x2662>;
 			dma-names = "tx", "rx";
 			power-domains = <&cpg>;
@@ -260,8 +264,8 @@ spi0: spi@1004ac00 {
 				     <GIC_SPI 413 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 414 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "error", "rx", "tx";
-			clocks = <&cpg CPG_MOD R9A07G044_RSPI0_CLKB>;
-			resets = <&cpg R9A07G044_RSPI0_RST>;
+			clocks = <&cpg CPG_MOD SOC_CPG_PREFIX(RSPI0_CLKB)>;
+			resets = <&cpg SOC_CPG_PREFIX(RSPI0_RST)>;
 			dmas = <&dmac 0x2e95>, <&dmac 0x2e96>;
 			dma-names = "tx", "rx";
 			power-domains = <&cpg>;
@@ -278,8 +282,8 @@ spi1: spi@1004b000 {
 				     <GIC_SPI 416 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 417 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "error", "rx", "tx";
-			clocks = <&cpg CPG_MOD R9A07G044_RSPI1_CLKB>;
-			resets = <&cpg R9A07G044_RSPI1_RST>;
+			clocks = <&cpg CPG_MOD SOC_CPG_PREFIX(RSPI1_CLKB)>;
+			resets = <&cpg SOC_CPG_PREFIX(RSPI1_RST)>;
 			dmas = <&dmac 0x2e99>, <&dmac 0x2e9a>;
 			dma-names = "tx", "rx";
 			power-domains = <&cpg>;
@@ -296,8 +300,8 @@ spi2: spi@1004b400 {
 				     <GIC_SPI 419 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 420 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "error", "rx", "tx";
-			clocks = <&cpg CPG_MOD R9A07G044_RSPI2_CLKB>;
-			resets = <&cpg R9A07G044_RSPI2_RST>;
+			clocks = <&cpg CPG_MOD SOC_CPG_PREFIX(RSPI2_CLKB)>;
+			resets = <&cpg SOC_CPG_PREFIX(RSPI2_RST)>;
 			dmas = <&dmac 0x2e9d>, <&dmac 0x2e9e>;
 			dma-names = "tx", "rx";
 			power-domains = <&cpg>;
@@ -318,10 +322,10 @@ scif0: serial@1004b800 {
 				     <GIC_SPI 384 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "eri", "rxi", "txi",
 					  "bri", "dri", "tei";
-			clocks = <&cpg CPG_MOD R9A07G044_SCIF0_CLK_PCK>;
+			clocks = <&cpg CPG_MOD SOC_CPG_PREFIX(SCIF0_CLK_PCK)>;
 			clock-names = "fck";
 			power-domains = <&cpg>;
-			resets = <&cpg R9A07G044_SCIF0_RST_SYSTEM_N>;
+			resets = <&cpg SOC_CPG_PREFIX(SCIF0_RST_SYSTEM_N)>;
 			status = "disabled";
 		};
 
@@ -336,10 +340,10 @@ scif1: serial@1004bc00 {
 				     <GIC_SPI 389 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "eri", "rxi", "txi",
 					  "bri", "dri", "tei";
-			clocks = <&cpg CPG_MOD R9A07G044_SCIF1_CLK_PCK>;
+			clocks = <&cpg CPG_MOD SOC_CPG_PREFIX(SCIF1_CLK_PCK)>;
 			clock-names = "fck";
 			power-domains = <&cpg>;
-			resets = <&cpg R9A07G044_SCIF1_RST_SYSTEM_N>;
+			resets = <&cpg SOC_CPG_PREFIX(SCIF1_RST_SYSTEM_N)>;
 			status = "disabled";
 		};
 
@@ -354,10 +358,10 @@ scif2: serial@1004c000 {
 				     <GIC_SPI 394 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "eri", "rxi", "txi",
 					  "bri", "dri", "tei";
-			clocks = <&cpg CPG_MOD R9A07G044_SCIF2_CLK_PCK>;
+			clocks = <&cpg CPG_MOD SOC_CPG_PREFIX(SCIF2_CLK_PCK)>;
 			clock-names = "fck";
 			power-domains = <&cpg>;
-			resets = <&cpg R9A07G044_SCIF2_RST_SYSTEM_N>;
+			resets = <&cpg SOC_CPG_PREFIX(SCIF2_RST_SYSTEM_N)>;
 			status = "disabled";
 		};
 
@@ -372,10 +376,10 @@ scif3: serial@1004c400 {
 				     <GIC_SPI 399 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "eri", "rxi", "txi",
 					  "bri", "dri", "tei";
-			clocks = <&cpg CPG_MOD R9A07G044_SCIF3_CLK_PCK>;
+			clocks = <&cpg CPG_MOD SOC_CPG_PREFIX(SCIF3_CLK_PCK)>;
 			clock-names = "fck";
 			power-domains = <&cpg>;
-			resets = <&cpg R9A07G044_SCIF3_RST_SYSTEM_N>;
+			resets = <&cpg SOC_CPG_PREFIX(SCIF3_RST_SYSTEM_N)>;
 			status = "disabled";
 		};
 
@@ -390,10 +394,10 @@ scif4: serial@1004c800 {
 				     <GIC_SPI 404 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "eri", "rxi", "txi",
 					  "bri", "dri", "tei";
-			clocks = <&cpg CPG_MOD R9A07G044_SCIF4_CLK_PCK>;
+			clocks = <&cpg CPG_MOD SOC_CPG_PREFIX(SCIF4_CLK_PCK)>;
 			clock-names = "fck";
 			power-domains = <&cpg>;
-			resets = <&cpg R9A07G044_SCIF4_RST_SYSTEM_N>;
+			resets = <&cpg SOC_CPG_PREFIX(SCIF4_RST_SYSTEM_N)>;
 			status = "disabled";
 		};
 
@@ -405,10 +409,10 @@ sci0: serial@1004d000 {
 				     <GIC_SPI 407 IRQ_TYPE_EDGE_RISING>,
 				     <GIC_SPI 408 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "eri", "rxi", "txi", "tei";
-			clocks = <&cpg CPG_MOD R9A07G044_SCI0_CLKP>;
+			clocks = <&cpg CPG_MOD SOC_CPG_PREFIX(SCI0_CLKP)>;
 			clock-names = "fck";
 			power-domains = <&cpg>;
-			resets = <&cpg R9A07G044_SCI0_RST>;
+			resets = <&cpg SOC_CPG_PREFIX(SCI0_RST)>;
 			status = "disabled";
 		};
 
@@ -420,10 +424,10 @@ sci1: serial@1004d400 {
 				     <GIC_SPI 411 IRQ_TYPE_EDGE_RISING>,
 				     <GIC_SPI 412 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "eri", "rxi", "txi", "tei";
-			clocks = <&cpg CPG_MOD R9A07G044_SCI1_CLKP>;
+			clocks = <&cpg CPG_MOD SOC_CPG_PREFIX(SCI1_CLKP)>;
 			clock-names = "fck";
 			power-domains = <&cpg>;
-			resets = <&cpg R9A07G044_SCI1_RST>;
+			resets = <&cpg SOC_CPG_PREFIX(SCI1_RST)>;
 			status = "disabled";
 		};
 
@@ -441,14 +445,14 @@ canfd: can@10050000 {
 			interrupt-names = "g_err", "g_recc",
 					  "ch0_err", "ch0_rec", "ch0_trx",
 					  "ch1_err", "ch1_rec", "ch1_trx";
-			clocks = <&cpg CPG_MOD R9A07G044_CANFD_PCLK>,
-				 <&cpg CPG_CORE R9A07G044_CLK_P0_DIV2>,
+			clocks = <&cpg CPG_MOD SOC_CPG_PREFIX(CANFD_PCLK)>,
+				 <&cpg CPG_CORE SOC_CPG_PREFIX(CLK_P0_DIV2)>,
 				 <&can_clk>;
 			clock-names = "fck", "canfd", "can_clk";
-			assigned-clocks = <&cpg CPG_CORE R9A07G044_CLK_P0_DIV2>;
+			assigned-clocks = <&cpg CPG_CORE SOC_CPG_PREFIX(CLK_P0_DIV2)>;
 			assigned-clock-rates = <50000000>;
-			resets = <&cpg R9A07G044_CANFD_RSTP_N>,
-				 <&cpg R9A07G044_CANFD_RSTC_N>;
+			resets = <&cpg SOC_CPG_PREFIX(CANFD_RSTP_N)>,
+				 <&cpg SOC_CPG_PREFIX(CANFD_RSTC_N)>;
 			reset-names = "rstp_n", "rstc_n";
 			power-domains = <&cpg>;
 			status = "disabled";
@@ -476,9 +480,9 @@ i2c0: i2c@10058000 {
 				     <GIC_SPI 355 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "tei", "ri", "ti", "spi", "sti",
 					  "naki", "ali", "tmoi";
-			clocks = <&cpg CPG_MOD R9A07G044_I2C0_PCLK>;
+			clocks = <&cpg CPG_MOD SOC_CPG_PREFIX(I2C0_PCLK)>;
 			clock-frequency = <100000>;
-			resets = <&cpg R9A07G044_I2C0_MRST>;
+			resets = <&cpg SOC_CPG_PREFIX(I2C0_MRST)>;
 			power-domains = <&cpg>;
 			status = "disabled";
 		};
@@ -498,9 +502,9 @@ i2c1: i2c@10058400 {
 				     <GIC_SPI 363 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "tei", "ri", "ti", "spi", "sti",
 					  "naki", "ali", "tmoi";
-			clocks = <&cpg CPG_MOD R9A07G044_I2C1_PCLK>;
+			clocks = <&cpg CPG_MOD SOC_CPG_PREFIX(I2C1_PCLK)>;
 			clock-frequency = <100000>;
-			resets = <&cpg R9A07G044_I2C1_MRST>;
+			resets = <&cpg SOC_CPG_PREFIX(I2C1_MRST)>;
 			power-domains = <&cpg>;
 			status = "disabled";
 		};
@@ -520,9 +524,9 @@ i2c2: i2c@10058800 {
 				     <GIC_SPI 371 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "tei", "ri", "ti", "spi", "sti",
 					  "naki", "ali", "tmoi";
-			clocks = <&cpg CPG_MOD R9A07G044_I2C2_PCLK>;
+			clocks = <&cpg CPG_MOD SOC_CPG_PREFIX(I2C2_PCLK)>;
 			clock-frequency = <100000>;
-			resets = <&cpg R9A07G044_I2C2_MRST>;
+			resets = <&cpg SOC_CPG_PREFIX(I2C2_MRST)>;
 			power-domains = <&cpg>;
 			status = "disabled";
 		};
@@ -542,9 +546,9 @@ i2c3: i2c@10058c00 {
 				     <GIC_SPI 379 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "tei", "ri", "ti", "spi", "sti",
 					  "naki", "ali", "tmoi";
-			clocks = <&cpg CPG_MOD R9A07G044_I2C3_PCLK>;
+			clocks = <&cpg CPG_MOD SOC_CPG_PREFIX(I2C3_PCLK)>;
 			clock-frequency = <100000>;
-			resets = <&cpg R9A07G044_I2C3_MRST>;
+			resets = <&cpg SOC_CPG_PREFIX(I2C3_MRST)>;
 			power-domains = <&cpg>;
 			status = "disabled";
 		};
@@ -553,11 +557,11 @@ adc: adc@10059000 {
 			compatible = "renesas,r9a07g044-adc", "renesas,rzg2l-adc";
 			reg = <0 0x10059000 0 0x400>;
 			interrupts = <GIC_SPI 347 IRQ_TYPE_EDGE_RISING>;
-			clocks = <&cpg CPG_MOD R9A07G044_ADC_ADCLK>,
-				 <&cpg CPG_MOD R9A07G044_ADC_PCLK>;
+			clocks = <&cpg CPG_MOD SOC_CPG_PREFIX(ADC_ADCLK)>,
+				 <&cpg CPG_MOD SOC_CPG_PREFIX(ADC_PCLK)>;
 			clock-names = "adclk", "pclk";
-			resets = <&cpg R9A07G044_ADC_PRESETN>,
-				 <&cpg R9A07G044_ADC_ADRST_N>;
+			resets = <&cpg SOC_CPG_PREFIX(ADC_PRESETN)>,
+				 <&cpg SOC_CPG_PREFIX(ADC_ADRST_N)>;
 			reset-names = "presetn", "adrst-n";
 			power-domains = <&cpg>;
 			status = "disabled";
@@ -595,8 +599,8 @@ tsu: thermal@10059400 {
 			compatible = "renesas,r9a07g044-tsu",
 				     "renesas,rzg2l-tsu";
 			reg = <0 0x10059400 0 0x400>;
-			clocks = <&cpg CPG_MOD R9A07G044_TSU_PCLK>;
-			resets = <&cpg R9A07G044_TSU_PRESETN>;
+			clocks = <&cpg CPG_MOD SOC_CPG_PREFIX(TSU_PCLK)>;
+			resets = <&cpg SOC_CPG_PREFIX(TSU_PRESETN)>;
 			power-domains = <&cpg>;
 			#thermal-sensor-cells = <1>;
 		};
@@ -609,9 +613,9 @@ sbc: spi@10060000 {
 			      <0 0x10070000 0 0x10000>;
 			reg-names = "regs", "dirmap", "wbuf";
 			interrupts = <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD R9A07G044_SPI_CLK2>,
-				 <&cpg CPG_MOD R9A07G044_SPI_CLK>;
-			resets = <&cpg R9A07G044_SPI_RST>;
+			clocks = <&cpg CPG_MOD SOC_CPG_PREFIX(SPI_CLK2)>,
+				 <&cpg CPG_MOD SOC_CPG_PREFIX(SPI_CLK)>;
+			resets = <&cpg SOC_CPG_PREFIX(SPI_RST)>;
 			power-domains = <&cpg>;
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -649,11 +653,11 @@ pinctrl: pinctrl@11030000 {
 			interrupt-parent = <&irqc>;
 			interrupt-controller;
 			gpio-ranges = <&pinctrl 0 0 392>;
-			clocks = <&cpg CPG_MOD R9A07G044_GPIO_HCLK>;
+			clocks = <&cpg CPG_MOD SOC_CPG_PREFIX(GPIO_HCLK)>;
 			power-domains = <&cpg>;
-			resets = <&cpg R9A07G044_GPIO_RSTN>,
-				 <&cpg R9A07G044_GPIO_PORT_RESETN>,
-				 <&cpg R9A07G044_GPIO_SPARE_RESETN>;
+			resets = <&cpg SOC_CPG_PREFIX(GPIO_RSTN)>,
+				 <&cpg SOC_CPG_PREFIX(GPIO_PORT_RESETN)>,
+				 <&cpg SOC_CPG_PREFIX(GPIO_SPARE_RESETN)>;
 		};
 
 		irqc: interrupt-controller@110a0000 {
@@ -704,11 +708,11 @@ irqc: interrupt-controller@110a0000 {
 				     <GIC_SPI 473 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 474 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 475 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD R9A07G044_IA55_CLK>,
-				 <&cpg CPG_MOD R9A07G044_IA55_PCLK>;
+			clocks = <&cpg CPG_MOD SOC_CPG_PREFIX(IA55_CLK)>,
+				 <&cpg CPG_MOD SOC_CPG_PREFIX(IA55_PCLK)>;
 			clock-names = "clk", "pclk";
 			power-domains = <&cpg>;
-			resets = <&cpg R9A07G044_IA55_RESETN>;
+			resets = <&cpg SOC_CPG_PREFIX(IA55_RESETN)>;
 		};
 
 		dmac: dma-controller@11820000 {
@@ -738,11 +742,11 @@ dmac: dma-controller@11820000 {
 					  "ch4", "ch5", "ch6", "ch7",
 					  "ch8", "ch9", "ch10", "ch11",
 					  "ch12", "ch13", "ch14", "ch15";
-			clocks = <&cpg CPG_MOD R9A07G044_DMAC_ACLK>,
-				 <&cpg CPG_MOD R9A07G044_DMAC_PCLK>;
+			clocks = <&cpg CPG_MOD SOC_CPG_PREFIX(DMAC_ACLK)>,
+				 <&cpg CPG_MOD SOC_CPG_PREFIX(DMAC_PCLK)>;
 			power-domains = <&cpg>;
-			resets = <&cpg R9A07G044_DMAC_ARESETN>,
-				 <&cpg R9A07G044_DMAC_RST_ASYNC>;
+			resets = <&cpg SOC_CPG_PREFIX(DMAC_ARESETN)>,
+				 <&cpg SOC_CPG_PREFIX(DMAC_RST_ASYNC)>;
 			#dma-cells = <1>;
 			dma-channels = <16>;
 		};
@@ -756,14 +760,14 @@ gpu: gpu@11840000 {
 				     <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 156 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "job", "mmu", "gpu", "event";
-			clocks = <&cpg CPG_MOD R9A07G044_GPU_CLK>,
-				 <&cpg CPG_MOD R9A07G044_GPU_AXI_CLK>,
-				 <&cpg CPG_MOD R9A07G044_GPU_ACE_CLK>;
+			clocks = <&cpg CPG_MOD SOC_CPG_PREFIX(GPU_CLK)>,
+				 <&cpg CPG_MOD SOC_CPG_PREFIX(GPU_AXI_CLK)>,
+				 <&cpg CPG_MOD SOC_CPG_PREFIX(GPU_ACE_CLK)>;
 			clock-names = "gpu", "bus", "bus_ace";
 			power-domains = <&cpg>;
-			resets = <&cpg R9A07G044_GPU_RESETN>,
-				 <&cpg R9A07G044_GPU_AXI_RESETN>,
-				 <&cpg R9A07G044_GPU_ACE_RESETN>;
+			resets = <&cpg SOC_CPG_PREFIX(GPU_RESETN)>,
+				 <&cpg SOC_CPG_PREFIX(GPU_AXI_RESETN)>,
+				 <&cpg SOC_CPG_PREFIX(GPU_ACE_RESETN)>;
 			reset-names = "rst", "axi_rst", "ace_rst";
 			operating-points-v2 = <&gpu_opp_table>;
 		};
@@ -784,12 +788,12 @@ sdhi0: mmc@11c00000 {
 			reg = <0x0 0x11c00000 0 0x10000>;
 			interrupts = <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD R9A07G044_SDHI0_IMCLK>,
-				 <&cpg CPG_MOD R9A07G044_SDHI0_CLK_HS>,
-				 <&cpg CPG_MOD R9A07G044_SDHI0_IMCLK2>,
-				 <&cpg CPG_MOD R9A07G044_SDHI0_ACLK>;
+			clocks = <&cpg CPG_MOD SOC_CPG_PREFIX(SDHI0_IMCLK)>,
+				 <&cpg CPG_MOD SOC_CPG_PREFIX(SDHI0_CLK_HS)>,
+				 <&cpg CPG_MOD SOC_CPG_PREFIX(SDHI0_IMCLK2)>,
+				 <&cpg CPG_MOD SOC_CPG_PREFIX(SDHI0_ACLK)>;
 			clock-names = "core", "clkh", "cd", "aclk";
-			resets = <&cpg R9A07G044_SDHI0_IXRST>;
+			resets = <&cpg SOC_CPG_PREFIX(SDHI0_IXRST)>;
 			power-domains = <&cpg>;
 			status = "disabled";
 		};
@@ -800,12 +804,12 @@ sdhi1: mmc@11c10000 {
 			reg = <0x0 0x11c10000 0 0x10000>;
 			interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD R9A07G044_SDHI1_IMCLK>,
-				 <&cpg CPG_MOD R9A07G044_SDHI1_CLK_HS>,
-				 <&cpg CPG_MOD R9A07G044_SDHI1_IMCLK2>,
-				 <&cpg CPG_MOD R9A07G044_SDHI1_ACLK>;
+			clocks = <&cpg CPG_MOD SOC_CPG_PREFIX(SDHI1_IMCLK)>,
+				 <&cpg CPG_MOD SOC_CPG_PREFIX(SDHI1_CLK_HS)>,
+				 <&cpg CPG_MOD SOC_CPG_PREFIX(SDHI1_IMCLK2)>,
+				 <&cpg CPG_MOD SOC_CPG_PREFIX(SDHI1_ACLK)>;
 			clock-names = "core", "clkh", "cd", "aclk";
-			resets = <&cpg R9A07G044_SDHI1_IXRST>;
+			resets = <&cpg SOC_CPG_PREFIX(SDHI1_IXRST)>;
 			power-domains = <&cpg>;
 			status = "disabled";
 		};
@@ -819,11 +823,11 @@ eth0: ethernet@11c20000 {
 				     <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "mux", "fil", "arp_ns";
 			phy-mode = "rgmii";
-			clocks = <&cpg CPG_MOD R9A07G044_ETH0_CLK_AXI>,
-				 <&cpg CPG_MOD R9A07G044_ETH0_CLK_CHI>,
-				 <&cpg CPG_CORE R9A07G044_CLK_HP>;
+			clocks = <&cpg CPG_MOD SOC_CPG_PREFIX(ETH0_CLK_AXI)>,
+				 <&cpg CPG_MOD SOC_CPG_PREFIX(ETH0_CLK_CHI)>,
+				 <&cpg CPG_CORE SOC_CPG_PREFIX(CLK_HP>);
 			clock-names = "axi", "chi", "refclk";
-			resets = <&cpg R9A07G044_ETH0_RST_HW_N>;
+			resets = <&cpg SOC_CPG_PREFIX(ETH0_RST_HW_N)>;
 			power-domains = <&cpg>;
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -839,11 +843,11 @@ eth1: ethernet@11c30000 {
 				     <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "mux", "fil", "arp_ns";
 			phy-mode = "rgmii";
-			clocks = <&cpg CPG_MOD R9A07G044_ETH1_CLK_AXI>,
-				 <&cpg CPG_MOD R9A07G044_ETH1_CLK_CHI>,
-				 <&cpg CPG_CORE R9A07G044_CLK_HP>;
+			clocks = <&cpg CPG_MOD SOC_CPG_PREFIX(ETH1_CLK_AXI)>,
+				 <&cpg CPG_MOD SOC_CPG_PREFIX(ETH1_CLK_CHI)>,
+				 <&cpg CPG_CORE SOC_CPG_PREFIX(CLK_HP)>;
 			clock-names = "axi", "chi", "refclk";
-			resets = <&cpg R9A07G044_ETH1_RST_HW_N>;
+			resets = <&cpg SOC_CPG_PREFIX(ETH1_RST_HW_N)>;
 			power-domains = <&cpg>;
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -854,8 +858,8 @@ phyrst: usbphy-ctrl@11c40000 {
 			compatible = "renesas,r9a07g044-usbphy-ctrl",
 				     "renesas,rzg2l-usbphy-ctrl";
 			reg = <0 0x11c40000 0 0x10000>;
-			clocks = <&cpg CPG_MOD R9A07G044_USB_PCLK>;
-			resets = <&cpg R9A07G044_USB_PRESETN>;
+			clocks = <&cpg CPG_MOD SOC_CPG_PREFIX(USB_PCLK)>;
+			resets = <&cpg SOC_CPG_PREFIX(USB_PRESETN)>;
 			power-domains = <&cpg>;
 			#reset-cells = <1>;
 			status = "disabled";
@@ -865,10 +869,10 @@ ohci0: usb@11c50000 {
 			compatible = "generic-ohci";
 			reg = <0 0x11c50000 0 0x100>;
 			interrupts = <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD R9A07G044_USB_PCLK>,
-				 <&cpg CPG_MOD R9A07G044_USB_U2H0_HCLK>;
+			clocks = <&cpg CPG_MOD SOC_CPG_PREFIX(USB_PCLK)>,
+				 <&cpg CPG_MOD SOC_CPG_PREFIX(USB_U2H0_HCLK)>;
 			resets = <&phyrst 0>,
-				 <&cpg R9A07G044_USB_U2H0_HRESETN>;
+				 <&cpg SOC_CPG_PREFIX(USB_U2H0_HRESETN)>;
 			phys = <&usb2_phy0 1>;
 			phy-names = "usb";
 			power-domains = <&cpg>;
@@ -879,10 +883,10 @@ ohci1: usb@11c70000 {
 			compatible = "generic-ohci";
 			reg = <0 0x11c70000 0 0x100>;
 			interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD R9A07G044_USB_PCLK>,
-				 <&cpg CPG_MOD R9A07G044_USB_U2H1_HCLK>;
+			clocks = <&cpg CPG_MOD SOC_CPG_PREFIX(USB_PCLK)>,
+				 <&cpg CPG_MOD SOC_CPG_PREFIX(USB_U2H1_HCLK)>;
 			resets = <&phyrst 1>,
-				 <&cpg R9A07G044_USB_U2H1_HRESETN>;
+				 <&cpg SOC_CPG_PREFIX(USB_U2H1_HRESETN)>;
 			phys = <&usb2_phy1 1>;
 			phy-names = "usb";
 			power-domains = <&cpg>;
@@ -893,10 +897,10 @@ ehci0: usb@11c50100 {
 			compatible = "generic-ehci";
 			reg = <0 0x11c50100 0 0x100>;
 			interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD R9A07G044_USB_PCLK>,
-				 <&cpg CPG_MOD R9A07G044_USB_U2H0_HCLK>;
+			clocks = <&cpg CPG_MOD SOC_CPG_PREFIX(USB_PCLK)>,
+				 <&cpg CPG_MOD SOC_CPG_PREFIX(USB_U2H0_HCLK)>;
 			resets = <&phyrst 0>,
-				 <&cpg R9A07G044_USB_U2H0_HRESETN>;
+				 <&cpg SOC_CPG_PREFIX(USB_U2H0_HRESETN)>;
 			phys = <&usb2_phy0 2>;
 			phy-names = "usb";
 			companion = <&ohci0>;
@@ -908,10 +912,10 @@ ehci1: usb@11c70100 {
 			compatible = "generic-ehci";
 			reg = <0 0x11c70100 0 0x100>;
 			interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD R9A07G044_USB_PCLK>,
-				 <&cpg CPG_MOD R9A07G044_USB_U2H1_HCLK>;
+			clocks = <&cpg CPG_MOD SOC_CPG_PREFIX(USB_PCLK)>,
+				 <&cpg CPG_MOD SOC_CPG_PREFIX(USB_U2H1_HCLK)>;
 			resets = <&phyrst 1>,
-				 <&cpg R9A07G044_USB_U2H1_HRESETN>;
+				 <&cpg SOC_CPG_PREFIX(USB_U2H1_HRESETN)>;
 			phys = <&usb2_phy1 2>;
 			phy-names = "usb";
 			companion = <&ohci1>;
@@ -924,8 +928,8 @@ usb2_phy0: usb-phy@11c50200 {
 				     "renesas,rzg2l-usb2-phy";
 			reg = <0 0x11c50200 0 0x700>;
 			interrupts = <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD R9A07G044_USB_PCLK>,
-				 <&cpg CPG_MOD R9A07G044_USB_U2H0_HCLK>;
+			clocks = <&cpg CPG_MOD SOC_CPG_PREFIX(USB_PCLK)>,
+				 <&cpg CPG_MOD SOC_CPG_PREFIX(USB_U2H0_HCLK)>;
 			resets = <&phyrst 0>;
 			#phy-cells = <1>;
 			power-domains = <&cpg>;
@@ -937,8 +941,8 @@ usb2_phy1: usb-phy@11c70200 {
 				     "renesas,rzg2l-usb2-phy";
 			reg = <0 0x11c70200 0 0x700>;
 			interrupts = <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD R9A07G044_USB_PCLK>,
-				 <&cpg CPG_MOD R9A07G044_USB_U2H1_HCLK>;
+			clocks = <&cpg CPG_MOD SOC_CPG_PREFIX(USB_PCLK)>,
+				 <&cpg CPG_MOD SOC_CPG_PREFIX(USB_U2H1_HCLK)>;
 			resets = <&phyrst 1>;
 			#phy-cells = <1>;
 			power-domains = <&cpg>;
@@ -953,10 +957,10 @@ hsusb: usb@11c60000 {
 				     <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD R9A07G044_USB_PCLK>,
-				 <&cpg CPG_MOD R9A07G044_USB_U2P_EXR_CPUCLK>;
+			clocks = <&cpg CPG_MOD SOC_CPG_PREFIX(USB_PCLK)>,
+				 <&cpg CPG_MOD SOC_CPG_PREFIX(USB_U2P_EXR_CPUCLK)>;
 			resets = <&phyrst 0>,
-				 <&cpg R9A07G044_USB_U2P_EXL_SYSRST>;
+				 <&cpg SOC_CPG_PREFIX(USB_U2P_EXL_SYSRST)>;
 			renesas,buswait = <7>;
 			phys = <&usb2_phy0 3>;
 			phy-names = "usb";
@@ -968,13 +972,13 @@ wdt0: watchdog@12800800 {
 			compatible = "renesas,r9a07g044-wdt",
 				     "renesas,rzg2l-wdt";
 			reg = <0 0x12800800 0 0x400>;
-			clocks = <&cpg CPG_MOD R9A07G044_WDT0_PCLK>,
-				 <&cpg CPG_MOD R9A07G044_WDT0_CLK>;
+			clocks = <&cpg CPG_MOD SOC_CPG_PREFIX(WDT0_PCLK)>,
+				 <&cpg CPG_MOD SOC_CPG_PREFIX(WDT0_CLK)>;
 			clock-names = "pclk", "oscclk";
 			interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "wdt", "perrout";
-			resets = <&cpg R9A07G044_WDT0_PRESETN>;
+			resets = <&cpg SOC_CPG_PREFIX(WDT0_PRESETN)>;
 			power-domains = <&cpg>;
 			status = "disabled";
 		};
@@ -983,13 +987,13 @@ wdt1: watchdog@12800c00 {
 			compatible = "renesas,r9a07g044-wdt",
 				     "renesas,rzg2l-wdt";
 			reg = <0 0x12800C00 0 0x400>;
-			clocks = <&cpg CPG_MOD R9A07G044_WDT1_PCLK>,
-				 <&cpg CPG_MOD R9A07G044_WDT1_CLK>;
+			clocks = <&cpg CPG_MOD SOC_CPG_PREFIX(WDT1_PCLK)>,
+				 <&cpg CPG_MOD SOC_CPG_PREFIX(WDT1_CLK)>;
 			clock-names = "pclk", "oscclk";
 			interrupts = <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "wdt", "perrout";
-			resets = <&cpg R9A07G044_WDT1_PRESETN>;
+			resets = <&cpg SOC_CPG_PREFIX(WDT1_PRESETN)>;
 			power-domains = <&cpg>;
 			status = "disabled";
 		};
@@ -999,8 +1003,8 @@ ostm0: timer@12801000 {
 				     "renesas,ostm";
 			reg = <0x0 0x12801000 0x0 0x400>;
 			interrupts = <GIC_SPI 46 IRQ_TYPE_EDGE_RISING>;
-			clocks = <&cpg CPG_MOD R9A07G044_OSTM0_PCLK>;
-			resets = <&cpg R9A07G044_OSTM0_PRESETZ>;
+			clocks = <&cpg CPG_MOD SOC_CPG_PREFIX(OSTM0_PCLK)>;
+			resets = <&cpg SOC_CPG_PREFIX(OSTM0_PRESETZ)>;
 			power-domains = <&cpg>;
 			status = "disabled";
 		};
@@ -1010,8 +1014,8 @@ ostm1: timer@12801400 {
 				     "renesas,ostm";
 			reg = <0x0 0x12801400 0x0 0x400>;
 			interrupts = <GIC_SPI 47 IRQ_TYPE_EDGE_RISING>;
-			clocks = <&cpg CPG_MOD R9A07G044_OSTM1_PCLK>;
-			resets = <&cpg R9A07G044_OSTM1_PRESETZ>;
+			clocks = <&cpg CPG_MOD SOC_CPG_PREFIX(OSTM1_PCLK)>;
+			resets = <&cpg SOC_CPG_PREFIX(OSTM1_PRESETZ)>;
 			power-domains = <&cpg>;
 			status = "disabled";
 		};
@@ -1021,8 +1025,8 @@ ostm2: timer@12801800 {
 				     "renesas,ostm";
 			reg = <0x0 0x12801800 0x0 0x400>;
 			interrupts = <GIC_SPI 48 IRQ_TYPE_EDGE_RISING>;
-			clocks = <&cpg CPG_MOD R9A07G044_OSTM2_PCLK>;
-			resets = <&cpg R9A07G044_OSTM2_PRESETZ>;
+			clocks = <&cpg CPG_MOD SOC_CPG_PREFIX(OSTM2_PCLK)>;
+			resets = <&cpg SOC_CPG_PREFIX(OSTM2_PRESETZ)>;
 			power-domains = <&cpg>;
 			status = "disabled";
 		};
-- 
2.25.1

