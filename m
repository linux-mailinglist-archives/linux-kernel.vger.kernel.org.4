Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 434B5600A06
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 11:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231133AbiJQJMk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 05:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230501AbiJQJM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 05:12:27 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21BF512094;
        Mon, 17 Oct 2022 02:12:20 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id w18so17463870wro.7;
        Mon, 17 Oct 2022 02:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=frrJLARgUrWWi3Mt9s7uQpe32ppn7iBrKVIR2j/gFNs=;
        b=ptoyp83/MlG5dWk/gljcHoXiSSxEyetuV6RHLIMYKr79Be/OdGjDqgeaTWHEd1goIs
         vj86iQ+jA1pwf5a9DUYEvXIQLl7Iqyge1zFBb3YxZrb/NhIWztccPI03gGlAnx715nMX
         RXn7P1Odm+kXxPzC6FdCfTBJuyAeYq6sEHRLi2tlalcc/p7nvHz+ts5b9QpfU/tKNbUY
         tvlHIKCEyTCMCNQS6yr4xqB37TUVdL0QMzlBcr1n4X927oPGAhHYb8urD42bSFoVgvBf
         bibUAMU6Ju7tJcf9UNTLjrq2ZVt0RpEbEVRND1HjSmyJcbY61GFotdWjo1CJ3dwBtxsA
         iVMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=frrJLARgUrWWi3Mt9s7uQpe32ppn7iBrKVIR2j/gFNs=;
        b=AifV1gU2ZVqGJhRKU7fdIDJaH2eES07gX5G4LGxY+0YS09wUlCAvnSsKt42NyQ0AUQ
         D3moGBOmXcjfTROewnparkk61MVzBCJUx/hKB1OYHij1GUU7ND91zybjp2iFKY4j2o4x
         WIcrUiVasBSudOrG82bikw9BjDUMIke1FwSqYbf8Jda5WBiL1Xeo/4Z97uxwSxwsxLyP
         8x2w1iw49Or/6FrKtpqp/dM3XrA0YnH+ymkMcRpqxG4mwtKToUKoA4OxetVkLtzd22t9
         OQcHFyvKf9eKyda21NDbboU0nvOIQO0sn/Hg0fYNQt6NJSnp61RK7+7rTb4NZJqW/9YO
         NCJQ==
X-Gm-Message-State: ACrzQf23fS9lT8721/+Pc+2T7CDWSl1TWpMN+KxMwd6a3OmmyNF/19GN
        jM4mgW5HsuV+vgQj6U7ILqA=
X-Google-Smtp-Source: AMsMyM73lus2yIYE8w3Wt2vJDumJGO4qcKWNPO9+djjQnnsEvWHKQwH86YvNiT9hQckEa7PBV2/Lzw==
X-Received: by 2002:adf:e608:0:b0:22e:42ff:2fe with SMTP id p8-20020adfe608000000b0022e42ff02femr5454369wrm.161.1665997938363;
        Mon, 17 Oct 2022 02:12:18 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:fc4d:6548:d8bd:5bd])
        by smtp.gmail.com with ESMTPSA id n14-20020a5d400e000000b0022ae401e9e0sm7921503wrp.78.2022.10.17.02.12.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 02:12:17 -0700 (PDT)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, linux-arm-kernel@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Samuel Holland <samuel@sholland.org>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [RFC RESEND PATCH 1/2] arm64: dts: renesas: r9a07g043: Introduce SOC_PERIPHERAL_IRQ() macro to specify interrupt property
Date:   Mon, 17 Oct 2022 10:12:00 +0100
Message-Id: <20221017091201.199457-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221017091201.199457-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20221017091201.199457-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75 autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Introduce SOC_PERIPHERAL_IRQ() macro to specify interrupt property so
that we can share the common parts of the SoC DTSI with the RZ/Five
(RISC-V) SoC and the RZ/G2UL (ARM64) SoC.

This patch adds a new file r9a07g043u.dtsi to separate out RZ/G2UL
(ARM64) SoC specific parts. No functional changes (same DTB).

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a07g043.dtsi    | 301 +++++++++---------
 arch/arm64/boot/dts/renesas/r9a07g043u.dtsi   |  12 +
 .../boot/dts/renesas/r9a07g043u11-smarc.dts   |   2 +-
 3 files changed, 163 insertions(+), 152 deletions(-)
 create mode 100644 arch/arm64/boot/dts/renesas/r9a07g043u.dtsi

diff --git a/arch/arm64/boot/dts/renesas/r9a07g043.dtsi b/arch/arm64/boot/dts/renesas/r9a07g043.dtsi
index c1fb29de2fa4..c41840e32c30 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g043.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g043.dtsi
@@ -5,7 +5,6 @@
  * Copyright (C) 2022 Renesas Electronics Corp.
  */
 
-#include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/clock/r9a07g043-cpg.h>
 
 / {
@@ -107,10 +106,10 @@ ssi0: ssi@10049c00 {
 			compatible = "renesas,r9a07g043-ssi",
 				     "renesas,rz-ssi";
 			reg = <0 0x10049c00 0 0x400>;
-			interrupts = <GIC_SPI 326 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 327 IRQ_TYPE_EDGE_RISING>,
-				     <GIC_SPI 328 IRQ_TYPE_EDGE_RISING>,
-				     <GIC_SPI 329 IRQ_TYPE_EDGE_RISING>;
+			interrupts = <SOC_PERIPHERAL_IRQ(326, IRQ_TYPE_LEVEL_HIGH)>,
+				     <SOC_PERIPHERAL_IRQ(327, IRQ_TYPE_EDGE_RISING)>,
+				     <SOC_PERIPHERAL_IRQ(328, IRQ_TYPE_EDGE_RISING)>,
+				     <SOC_PERIPHERAL_IRQ(329, IRQ_TYPE_EDGE_RISING)>;
 			interrupt-names = "int_req", "dma_rx", "dma_tx", "dma_rt";
 			clocks = <&cpg CPG_MOD R9A07G043_SSI0_PCLK2>,
 				 <&cpg CPG_MOD R9A07G043_SSI0_PCLK_SFR>,
@@ -128,10 +127,10 @@ ssi1: ssi@1004a000 {
 			compatible = "renesas,r9a07g043-ssi",
 				     "renesas,rz-ssi";
 			reg = <0 0x1004a000 0 0x400>;
-			interrupts = <GIC_SPI 330 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 331 IRQ_TYPE_EDGE_RISING>,
-				     <GIC_SPI 332 IRQ_TYPE_EDGE_RISING>,
-				     <GIC_SPI 333 IRQ_TYPE_EDGE_RISING>;
+			interrupts = <SOC_PERIPHERAL_IRQ(330, IRQ_TYPE_LEVEL_HIGH)>,
+				     <SOC_PERIPHERAL_IRQ(331, IRQ_TYPE_EDGE_RISING)>,
+				     <SOC_PERIPHERAL_IRQ(332, IRQ_TYPE_EDGE_RISING)>,
+				     <SOC_PERIPHERAL_IRQ(333, IRQ_TYPE_EDGE_RISING)>;
 			interrupt-names = "int_req", "dma_rx", "dma_tx", "dma_rt";
 			clocks = <&cpg CPG_MOD R9A07G043_SSI1_PCLK2>,
 				 <&cpg CPG_MOD R9A07G043_SSI1_PCLK_SFR>,
@@ -149,10 +148,10 @@ ssi2: ssi@1004a400 {
 			compatible = "renesas,r9a07g043-ssi",
 				     "renesas,rz-ssi";
 			reg = <0 0x1004a400 0 0x400>;
-			interrupts = <GIC_SPI 334 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 335 IRQ_TYPE_EDGE_RISING>,
-				     <GIC_SPI 336 IRQ_TYPE_EDGE_RISING>,
-				     <GIC_SPI 337 IRQ_TYPE_EDGE_RISING>;
+			interrupts = <SOC_PERIPHERAL_IRQ(334, IRQ_TYPE_LEVEL_HIGH)>,
+				     <SOC_PERIPHERAL_IRQ(335, IRQ_TYPE_EDGE_RISING)>,
+				     <SOC_PERIPHERAL_IRQ(336, IRQ_TYPE_EDGE_RISING)>,
+				     <SOC_PERIPHERAL_IRQ(337, IRQ_TYPE_EDGE_RISING)>;
 			interrupt-names = "int_req", "dma_rx", "dma_tx", "dma_rt";
 			clocks = <&cpg CPG_MOD R9A07G043_SSI2_PCLK2>,
 				 <&cpg CPG_MOD R9A07G043_SSI2_PCLK_SFR>,
@@ -170,10 +169,10 @@ ssi3: ssi@1004a800 {
 			compatible = "renesas,r9a07g043-ssi",
 				     "renesas,rz-ssi";
 			reg = <0 0x1004a800 0 0x400>;
-			interrupts = <GIC_SPI 338 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 339 IRQ_TYPE_EDGE_RISING>,
-				     <GIC_SPI 340 IRQ_TYPE_EDGE_RISING>,
-				     <GIC_SPI 341 IRQ_TYPE_EDGE_RISING>;
+			interrupts = <SOC_PERIPHERAL_IRQ(338, IRQ_TYPE_LEVEL_HIGH)>,
+				     <SOC_PERIPHERAL_IRQ(339, IRQ_TYPE_EDGE_RISING)>,
+				     <SOC_PERIPHERAL_IRQ(340, IRQ_TYPE_EDGE_RISING)>,
+				     <SOC_PERIPHERAL_IRQ(341, IRQ_TYPE_EDGE_RISING)>;
 			interrupt-names = "int_req", "dma_rx", "dma_tx", "dma_rt";
 			clocks = <&cpg CPG_MOD R9A07G043_SSI3_PCLK2>,
 				 <&cpg CPG_MOD R9A07G043_SSI3_PCLK_SFR>,
@@ -190,9 +189,9 @@ ssi3: ssi@1004a800 {
 		spi0: spi@1004ac00 {
 			compatible = "renesas,r9a07g043-rspi", "renesas,rspi-rz";
 			reg = <0 0x1004ac00 0 0x400>;
-			interrupts = <GIC_SPI 415 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 413 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 414 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <SOC_PERIPHERAL_IRQ(415, IRQ_TYPE_LEVEL_HIGH)>,
+				     <SOC_PERIPHERAL_IRQ(413, IRQ_TYPE_LEVEL_HIGH)>,
+				     <SOC_PERIPHERAL_IRQ(414, IRQ_TYPE_LEVEL_HIGH)>;
 			interrupt-names = "error", "rx", "tx";
 			clocks = <&cpg CPG_MOD R9A07G043_RSPI0_CLKB>;
 			resets = <&cpg R9A07G043_RSPI0_RST>;
@@ -208,9 +207,9 @@ spi0: spi@1004ac00 {
 		spi1: spi@1004b000 {
 			compatible = "renesas,r9a07g043-rspi", "renesas,rspi-rz";
 			reg = <0 0x1004b000 0 0x400>;
-			interrupts = <GIC_SPI 418 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 416 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 417 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <SOC_PERIPHERAL_IRQ(418, IRQ_TYPE_LEVEL_HIGH)>,
+				     <SOC_PERIPHERAL_IRQ(416, IRQ_TYPE_LEVEL_HIGH)>,
+				     <SOC_PERIPHERAL_IRQ(417, IRQ_TYPE_LEVEL_HIGH)>;
 			interrupt-names = "error", "rx", "tx";
 			clocks = <&cpg CPG_MOD R9A07G043_RSPI1_CLKB>;
 			resets = <&cpg R9A07G043_RSPI1_RST>;
@@ -226,9 +225,9 @@ spi1: spi@1004b000 {
 		spi2: spi@1004b400 {
 			compatible = "renesas,r9a07g043-rspi", "renesas,rspi-rz";
 			reg = <0 0x1004b400 0 0x400>;
-			interrupts = <GIC_SPI 421 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 419 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 420 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <SOC_PERIPHERAL_IRQ(421, IRQ_TYPE_LEVEL_HIGH)>,
+				     <SOC_PERIPHERAL_IRQ(419, IRQ_TYPE_LEVEL_HIGH)>,
+				     <SOC_PERIPHERAL_IRQ(420, IRQ_TYPE_LEVEL_HIGH)>;
 			interrupt-names = "error", "rx", "tx";
 			clocks = <&cpg CPG_MOD R9A07G043_RSPI2_CLKB>;
 			resets = <&cpg R9A07G043_RSPI2_RST>;
@@ -245,12 +244,12 @@ scif0: serial@1004b800 {
 			compatible = "renesas,scif-r9a07g043",
 				     "renesas,scif-r9a07g044";
 			reg = <0 0x1004b800 0 0x400>;
-			interrupts = <GIC_SPI 380 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 382 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 383 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 381 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 384 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 384 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <SOC_PERIPHERAL_IRQ(380, IRQ_TYPE_LEVEL_HIGH)>,
+				     <SOC_PERIPHERAL_IRQ(382, IRQ_TYPE_LEVEL_HIGH)>,
+				     <SOC_PERIPHERAL_IRQ(383, IRQ_TYPE_LEVEL_HIGH)>,
+				     <SOC_PERIPHERAL_IRQ(381, IRQ_TYPE_LEVEL_HIGH)>,
+				     <SOC_PERIPHERAL_IRQ(384, IRQ_TYPE_LEVEL_HIGH)>,
+				     <SOC_PERIPHERAL_IRQ(384, IRQ_TYPE_LEVEL_HIGH)>;
 			interrupt-names = "eri", "rxi", "txi",
 					  "bri", "dri", "tei";
 			clocks = <&cpg CPG_MOD R9A07G043_SCIF0_CLK_PCK>;
@@ -264,12 +263,12 @@ scif1: serial@1004bc00 {
 			compatible = "renesas,scif-r9a07g043",
 				     "renesas,scif-r9a07g044";
 			reg = <0 0x1004bc00 0 0x400>;
-			interrupts = <GIC_SPI 385 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 387 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 388 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 386 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 389 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 389 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <SOC_PERIPHERAL_IRQ(385, IRQ_TYPE_LEVEL_HIGH)>,
+				     <SOC_PERIPHERAL_IRQ(387, IRQ_TYPE_LEVEL_HIGH)>,
+				     <SOC_PERIPHERAL_IRQ(388, IRQ_TYPE_LEVEL_HIGH)>,
+				     <SOC_PERIPHERAL_IRQ(386, IRQ_TYPE_LEVEL_HIGH)>,
+				     <SOC_PERIPHERAL_IRQ(389, IRQ_TYPE_LEVEL_HIGH)>,
+				     <SOC_PERIPHERAL_IRQ(389, IRQ_TYPE_LEVEL_HIGH)>;
 			interrupt-names = "eri", "rxi", "txi",
 					  "bri", "dri", "tei";
 			clocks = <&cpg CPG_MOD R9A07G043_SCIF1_CLK_PCK>;
@@ -283,12 +282,12 @@ scif2: serial@1004c000 {
 			compatible = "renesas,scif-r9a07g043",
 				     "renesas,scif-r9a07g044";
 			reg = <0 0x1004c000 0 0x400>;
-			interrupts = <GIC_SPI 390 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 392 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 393 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 391 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 394 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 394 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <SOC_PERIPHERAL_IRQ(390, IRQ_TYPE_LEVEL_HIGH)>,
+				     <SOC_PERIPHERAL_IRQ(392, IRQ_TYPE_LEVEL_HIGH)>,
+				     <SOC_PERIPHERAL_IRQ(393, IRQ_TYPE_LEVEL_HIGH)>,
+				     <SOC_PERIPHERAL_IRQ(391, IRQ_TYPE_LEVEL_HIGH)>,
+				     <SOC_PERIPHERAL_IRQ(394, IRQ_TYPE_LEVEL_HIGH)>,
+				     <SOC_PERIPHERAL_IRQ(394, IRQ_TYPE_LEVEL_HIGH)>;
 			interrupt-names = "eri", "rxi", "txi",
 					  "bri", "dri", "tei";
 			clocks = <&cpg CPG_MOD R9A07G043_SCIF2_CLK_PCK>;
@@ -302,12 +301,12 @@ scif3: serial@1004c400 {
 			compatible = "renesas,scif-r9a07g043",
 				     "renesas,scif-r9a07g044";
 			reg = <0 0x1004c400 0 0x400>;
-			interrupts = <GIC_SPI 395 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 397 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 398 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 396 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 399 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 399 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <SOC_PERIPHERAL_IRQ(395, IRQ_TYPE_LEVEL_HIGH)>,
+				     <SOC_PERIPHERAL_IRQ(397, IRQ_TYPE_LEVEL_HIGH)>,
+				     <SOC_PERIPHERAL_IRQ(398, IRQ_TYPE_LEVEL_HIGH)>,
+				     <SOC_PERIPHERAL_IRQ(396, IRQ_TYPE_LEVEL_HIGH)>,
+				     <SOC_PERIPHERAL_IRQ(399, IRQ_TYPE_LEVEL_HIGH)>,
+				     <SOC_PERIPHERAL_IRQ(399, IRQ_TYPE_LEVEL_HIGH)>;
 			interrupt-names = "eri", "rxi", "txi",
 					  "bri", "dri", "tei";
 			clocks = <&cpg CPG_MOD R9A07G043_SCIF3_CLK_PCK>;
@@ -321,12 +320,12 @@ scif4: serial@1004c800 {
 			compatible = "renesas,scif-r9a07g043",
 				     "renesas,scif-r9a07g044";
 			reg = <0 0x1004c800 0 0x400>;
-			interrupts = <GIC_SPI 400 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 402 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 403 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 401 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 404 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 404 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <SOC_PERIPHERAL_IRQ(400, IRQ_TYPE_LEVEL_HIGH)>,
+				     <SOC_PERIPHERAL_IRQ(402, IRQ_TYPE_LEVEL_HIGH)>,
+				     <SOC_PERIPHERAL_IRQ(403, IRQ_TYPE_LEVEL_HIGH)>,
+				     <SOC_PERIPHERAL_IRQ(401, IRQ_TYPE_LEVEL_HIGH)>,
+				     <SOC_PERIPHERAL_IRQ(404, IRQ_TYPE_LEVEL_HIGH)>,
+				     <SOC_PERIPHERAL_IRQ(404, IRQ_TYPE_LEVEL_HIGH)>;
 			interrupt-names = "eri", "rxi", "txi",
 					  "bri", "dri", "tei";
 			clocks = <&cpg CPG_MOD R9A07G043_SCIF4_CLK_PCK>;
@@ -339,10 +338,10 @@ scif4: serial@1004c800 {
 		sci0: serial@1004d000 {
 			compatible = "renesas,r9a07g043-sci", "renesas,sci";
 			reg = <0 0x1004d000 0 0x400>;
-			interrupts = <GIC_SPI 405 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 406 IRQ_TYPE_EDGE_RISING>,
-				     <GIC_SPI 407 IRQ_TYPE_EDGE_RISING>,
-				     <GIC_SPI 408 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <SOC_PERIPHERAL_IRQ(405, IRQ_TYPE_LEVEL_HIGH)>,
+				     <SOC_PERIPHERAL_IRQ(406, IRQ_TYPE_EDGE_RISING)>,
+				     <SOC_PERIPHERAL_IRQ(407, IRQ_TYPE_EDGE_RISING)>,
+				     <SOC_PERIPHERAL_IRQ(408, IRQ_TYPE_LEVEL_HIGH)>;
 			interrupt-names = "eri", "rxi", "txi", "tei";
 			clocks = <&cpg CPG_MOD R9A07G043_SCI0_CLKP>;
 			clock-names = "fck";
@@ -354,10 +353,10 @@ sci0: serial@1004d000 {
 		sci1: serial@1004d400 {
 			compatible = "renesas,r9a07g043-sci", "renesas,sci";
 			reg = <0 0x1004d400 0 0x400>;
-			interrupts = <GIC_SPI 409 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 410 IRQ_TYPE_EDGE_RISING>,
-				     <GIC_SPI 411 IRQ_TYPE_EDGE_RISING>,
-				     <GIC_SPI 412 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <SOC_PERIPHERAL_IRQ(409, IRQ_TYPE_LEVEL_HIGH)>,
+				     <SOC_PERIPHERAL_IRQ(410, IRQ_TYPE_EDGE_RISING)>,
+				     <SOC_PERIPHERAL_IRQ(411, IRQ_TYPE_EDGE_RISING)>,
+				     <SOC_PERIPHERAL_IRQ(412, IRQ_TYPE_LEVEL_HIGH)>;
 			interrupt-names = "eri", "rxi", "txi", "tei";
 			clocks = <&cpg CPG_MOD R9A07G043_SCI1_CLKP>;
 			clock-names = "fck";
@@ -369,14 +368,14 @@ sci1: serial@1004d400 {
 		canfd: can@10050000 {
 			compatible = "renesas,r9a07g043-canfd", "renesas,rzg2l-canfd";
 			reg = <0 0x10050000 0 0x8000>;
-			interrupts = <GIC_SPI 426 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 427 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 422 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 424 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 428 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 423 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 425 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 429 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <SOC_PERIPHERAL_IRQ(426, IRQ_TYPE_LEVEL_HIGH)>,
+				     <SOC_PERIPHERAL_IRQ(427, IRQ_TYPE_LEVEL_HIGH)>,
+				     <SOC_PERIPHERAL_IRQ(422, IRQ_TYPE_LEVEL_HIGH)>,
+				     <SOC_PERIPHERAL_IRQ(424, IRQ_TYPE_LEVEL_HIGH)>,
+				     <SOC_PERIPHERAL_IRQ(428, IRQ_TYPE_LEVEL_HIGH)>,
+				     <SOC_PERIPHERAL_IRQ(423, IRQ_TYPE_LEVEL_HIGH)>,
+				     <SOC_PERIPHERAL_IRQ(425, IRQ_TYPE_LEVEL_HIGH)>,
+				     <SOC_PERIPHERAL_IRQ(429, IRQ_TYPE_LEVEL_HIGH)>;
 			interrupt-names = "g_err", "g_recc",
 					  "ch0_err", "ch0_rec", "ch0_trx",
 					  "ch1_err", "ch1_rec", "ch1_trx";
@@ -405,14 +404,14 @@ i2c0: i2c@10058000 {
 			#size-cells = <0>;
 			compatible = "renesas,riic-r9a07g043", "renesas,riic-rz";
 			reg = <0 0x10058000 0 0x400>;
-			interrupts = <GIC_SPI 350 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 348 IRQ_TYPE_EDGE_RISING>,
-				     <GIC_SPI 349 IRQ_TYPE_EDGE_RISING>,
-				     <GIC_SPI 352 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 353 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 351 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 354 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 355 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <SOC_PERIPHERAL_IRQ(350, IRQ_TYPE_LEVEL_HIGH)>,
+				     <SOC_PERIPHERAL_IRQ(348, IRQ_TYPE_EDGE_RISING)>,
+				     <SOC_PERIPHERAL_IRQ(349, IRQ_TYPE_EDGE_RISING)>,
+				     <SOC_PERIPHERAL_IRQ(352, IRQ_TYPE_LEVEL_HIGH)>,
+				     <SOC_PERIPHERAL_IRQ(353, IRQ_TYPE_LEVEL_HIGH)>,
+				     <SOC_PERIPHERAL_IRQ(351, IRQ_TYPE_LEVEL_HIGH)>,
+				     <SOC_PERIPHERAL_IRQ(354, IRQ_TYPE_LEVEL_HIGH)>,
+				     <SOC_PERIPHERAL_IRQ(355, IRQ_TYPE_LEVEL_HIGH)>;
 			interrupt-names = "tei", "ri", "ti", "spi", "sti",
 					  "naki", "ali", "tmoi";
 			clocks = <&cpg CPG_MOD R9A07G043_I2C0_PCLK>;
@@ -427,14 +426,14 @@ i2c1: i2c@10058400 {
 			#size-cells = <0>;
 			compatible = "renesas,riic-r9a07g043", "renesas,riic-rz";
 			reg = <0 0x10058400 0 0x400>;
-			interrupts = <GIC_SPI 358 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 356 IRQ_TYPE_EDGE_RISING>,
-				     <GIC_SPI 357 IRQ_TYPE_EDGE_RISING>,
-				     <GIC_SPI 360 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 361 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 359 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 362 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 363 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <SOC_PERIPHERAL_IRQ(358, IRQ_TYPE_LEVEL_HIGH)>,
+				     <SOC_PERIPHERAL_IRQ(356, IRQ_TYPE_EDGE_RISING)>,
+				     <SOC_PERIPHERAL_IRQ(357, IRQ_TYPE_EDGE_RISING)>,
+				     <SOC_PERIPHERAL_IRQ(360, IRQ_TYPE_LEVEL_HIGH)>,
+				     <SOC_PERIPHERAL_IRQ(361, IRQ_TYPE_LEVEL_HIGH)>,
+				     <SOC_PERIPHERAL_IRQ(359, IRQ_TYPE_LEVEL_HIGH)>,
+				     <SOC_PERIPHERAL_IRQ(362, IRQ_TYPE_LEVEL_HIGH)>,
+				     <SOC_PERIPHERAL_IRQ(363, IRQ_TYPE_LEVEL_HIGH)>;
 			interrupt-names = "tei", "ri", "ti", "spi", "sti",
 					  "naki", "ali", "tmoi";
 			clocks = <&cpg CPG_MOD R9A07G043_I2C1_PCLK>;
@@ -449,14 +448,14 @@ i2c2: i2c@10058800 {
 			#size-cells = <0>;
 			compatible = "renesas,riic-r9a07g043", "renesas,riic-rz";
 			reg = <0 0x10058800 0 0x400>;
-			interrupts = <GIC_SPI 366 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 364 IRQ_TYPE_EDGE_RISING>,
-				     <GIC_SPI 365 IRQ_TYPE_EDGE_RISING>,
-				     <GIC_SPI 368 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 369 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 367 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 370 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 371 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <SOC_PERIPHERAL_IRQ(366, IRQ_TYPE_LEVEL_HIGH)>,
+				     <SOC_PERIPHERAL_IRQ(364, IRQ_TYPE_EDGE_RISING)>,
+				     <SOC_PERIPHERAL_IRQ(365, IRQ_TYPE_EDGE_RISING)>,
+				     <SOC_PERIPHERAL_IRQ(368, IRQ_TYPE_LEVEL_HIGH)>,
+				     <SOC_PERIPHERAL_IRQ(369, IRQ_TYPE_LEVEL_HIGH)>,
+				     <SOC_PERIPHERAL_IRQ(367, IRQ_TYPE_LEVEL_HIGH)>,
+				     <SOC_PERIPHERAL_IRQ(370, IRQ_TYPE_LEVEL_HIGH)>,
+				     <SOC_PERIPHERAL_IRQ(371, IRQ_TYPE_LEVEL_HIGH)>;
 			interrupt-names = "tei", "ri", "ti", "spi", "sti",
 					  "naki", "ali", "tmoi";
 			clocks = <&cpg CPG_MOD R9A07G043_I2C2_PCLK>;
@@ -471,14 +470,14 @@ i2c3: i2c@10058c00 {
 			#size-cells = <0>;
 			compatible = "renesas,riic-r9a07g043", "renesas,riic-rz";
 			reg = <0 0x10058c00 0 0x400>;
-			interrupts = <GIC_SPI 374 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 372 IRQ_TYPE_EDGE_RISING>,
-				     <GIC_SPI 373 IRQ_TYPE_EDGE_RISING>,
-				     <GIC_SPI 376 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 377 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 375 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 378 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 379 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <SOC_PERIPHERAL_IRQ(374, IRQ_TYPE_LEVEL_HIGH)>,
+				     <SOC_PERIPHERAL_IRQ(372, IRQ_TYPE_EDGE_RISING)>,
+				     <SOC_PERIPHERAL_IRQ(373, IRQ_TYPE_EDGE_RISING)>,
+				     <SOC_PERIPHERAL_IRQ(376, IRQ_TYPE_LEVEL_HIGH)>,
+				     <SOC_PERIPHERAL_IRQ(377, IRQ_TYPE_LEVEL_HIGH)>,
+				     <SOC_PERIPHERAL_IRQ(375, IRQ_TYPE_LEVEL_HIGH)>,
+				     <SOC_PERIPHERAL_IRQ(378, IRQ_TYPE_LEVEL_HIGH)>,
+				     <SOC_PERIPHERAL_IRQ(379, IRQ_TYPE_LEVEL_HIGH)>;
 			interrupt-names = "tei", "ri", "ti", "spi", "sti",
 					  "naki", "ali", "tmoi";
 			clocks = <&cpg CPG_MOD R9A07G043_I2C3_PCLK>;
@@ -491,7 +490,7 @@ i2c3: i2c@10058c00 {
 		adc: adc@10059000 {
 			compatible = "renesas,r9a07g043-adc", "renesas,rzg2l-adc";
 			reg = <0 0x10059000 0 0x400>;
-			interrupts = <GIC_SPI 347 IRQ_TYPE_EDGE_RISING>;
+			interrupts = <SOC_PERIPHERAL_IRQ(347, IRQ_TYPE_EDGE_RISING)>;
 			clocks = <&cpg CPG_MOD R9A07G043_ADC_ADCLK>,
 				 <&cpg CPG_MOD R9A07G043_ADC_PCLK>;
 			clock-names = "adclk", "pclk";
@@ -551,10 +550,10 @@ cpg: clock-controller@11010000 {
 		sysc: system-controller@11020000 {
 			compatible = "renesas,r9a07g043-sysc";
 			reg = <0 0x11020000 0 0x10000>;
-			interrupts = <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <SOC_PERIPHERAL_IRQ(42, IRQ_TYPE_LEVEL_HIGH)>,
+				     <SOC_PERIPHERAL_IRQ(43, IRQ_TYPE_LEVEL_HIGH)>,
+				     <SOC_PERIPHERAL_IRQ(44, IRQ_TYPE_LEVEL_HIGH)>,
+				     <SOC_PERIPHERAL_IRQ(45, IRQ_TYPE_LEVEL_HIGH)>;
 			interrupt-names = "lpm_int", "ca55stbydone_int",
 					  "cm33stbyr_int", "ca55_deny";
 			status = "disabled";
@@ -578,23 +577,23 @@ dmac: dma-controller@11820000 {
 				     "renesas,rz-dmac";
 			reg = <0 0x11820000 0 0x10000>,
 			      <0 0x11830000 0 0x10000>;
-			interrupts = <GIC_SPI 141 IRQ_TYPE_EDGE_RISING>,
-				     <GIC_SPI 125 IRQ_TYPE_EDGE_RISING>,
-				     <GIC_SPI 126 IRQ_TYPE_EDGE_RISING>,
-				     <GIC_SPI 127 IRQ_TYPE_EDGE_RISING>,
-				     <GIC_SPI 128 IRQ_TYPE_EDGE_RISING>,
-				     <GIC_SPI 129 IRQ_TYPE_EDGE_RISING>,
-				     <GIC_SPI 130 IRQ_TYPE_EDGE_RISING>,
-				     <GIC_SPI 131 IRQ_TYPE_EDGE_RISING>,
-				     <GIC_SPI 132 IRQ_TYPE_EDGE_RISING>,
-				     <GIC_SPI 133 IRQ_TYPE_EDGE_RISING>,
-				     <GIC_SPI 134 IRQ_TYPE_EDGE_RISING>,
-				     <GIC_SPI 135 IRQ_TYPE_EDGE_RISING>,
-				     <GIC_SPI 136 IRQ_TYPE_EDGE_RISING>,
-				     <GIC_SPI 137 IRQ_TYPE_EDGE_RISING>,
-				     <GIC_SPI 138 IRQ_TYPE_EDGE_RISING>,
-				     <GIC_SPI 139 IRQ_TYPE_EDGE_RISING>,
-				     <GIC_SPI 140 IRQ_TYPE_EDGE_RISING>;
+			interrupts = <SOC_PERIPHERAL_IRQ(141, IRQ_TYPE_EDGE_RISING)>,
+				     <SOC_PERIPHERAL_IRQ(125, IRQ_TYPE_EDGE_RISING)>,
+				     <SOC_PERIPHERAL_IRQ(126, IRQ_TYPE_EDGE_RISING)>,
+				     <SOC_PERIPHERAL_IRQ(127, IRQ_TYPE_EDGE_RISING)>,
+				     <SOC_PERIPHERAL_IRQ(128, IRQ_TYPE_EDGE_RISING)>,
+				     <SOC_PERIPHERAL_IRQ(129, IRQ_TYPE_EDGE_RISING)>,
+				     <SOC_PERIPHERAL_IRQ(130, IRQ_TYPE_EDGE_RISING)>,
+				     <SOC_PERIPHERAL_IRQ(131, IRQ_TYPE_EDGE_RISING)>,
+				     <SOC_PERIPHERAL_IRQ(132, IRQ_TYPE_EDGE_RISING)>,
+				     <SOC_PERIPHERAL_IRQ(133, IRQ_TYPE_EDGE_RISING)>,
+				     <SOC_PERIPHERAL_IRQ(134, IRQ_TYPE_EDGE_RISING)>,
+				     <SOC_PERIPHERAL_IRQ(135, IRQ_TYPE_EDGE_RISING)>,
+				     <SOC_PERIPHERAL_IRQ(136, IRQ_TYPE_EDGE_RISING)>,
+				     <SOC_PERIPHERAL_IRQ(137, IRQ_TYPE_EDGE_RISING)>,
+				     <SOC_PERIPHERAL_IRQ(138, IRQ_TYPE_EDGE_RISING)>,
+				     <SOC_PERIPHERAL_IRQ(139, IRQ_TYPE_EDGE_RISING)>,
+				     <SOC_PERIPHERAL_IRQ(140, IRQ_TYPE_EDGE_RISING)>;
 			interrupt-names = "error",
 					  "ch0", "ch1", "ch2", "ch3",
 					  "ch4", "ch5", "ch6", "ch7",
@@ -623,8 +622,8 @@ sdhi0: mmc@11c00000 {
 			compatible = "renesas,sdhi-r9a07g043",
 				     "renesas,rcar-gen3-sdhi";
 			reg = <0x0 0x11c00000 0 0x10000>;
-			interrupts = <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <SOC_PERIPHERAL_IRQ(104, IRQ_TYPE_LEVEL_HIGH)>,
+				     <SOC_PERIPHERAL_IRQ(105, IRQ_TYPE_LEVEL_HIGH)>;
 			clocks = <&cpg CPG_MOD R9A07G043_SDHI0_IMCLK>,
 				 <&cpg CPG_MOD R9A07G043_SDHI0_CLK_HS>,
 				 <&cpg CPG_MOD R9A07G043_SDHI0_IMCLK2>,
@@ -639,8 +638,8 @@ sdhi1: mmc@11c10000 {
 			compatible = "renesas,sdhi-r9a07g043",
 				     "renesas,rcar-gen3-sdhi";
 			reg = <0x0 0x11c10000 0 0x10000>;
-			interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <SOC_PERIPHERAL_IRQ(106, IRQ_TYPE_LEVEL_HIGH)>,
+				     <SOC_PERIPHERAL_IRQ(107, IRQ_TYPE_LEVEL_HIGH)>;
 			clocks = <&cpg CPG_MOD R9A07G043_SDHI1_IMCLK>,
 				 <&cpg CPG_MOD R9A07G043_SDHI1_CLK_HS>,
 				 <&cpg CPG_MOD R9A07G043_SDHI1_IMCLK2>,
@@ -655,9 +654,9 @@ eth0: ethernet@11c20000 {
 			compatible = "renesas,r9a07g043-gbeth",
 				     "renesas,rzg2l-gbeth";
 			reg = <0 0x11c20000 0 0x10000>;
-			interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <SOC_PERIPHERAL_IRQ(84, IRQ_TYPE_LEVEL_HIGH)>,
+				     <SOC_PERIPHERAL_IRQ(85, IRQ_TYPE_LEVEL_HIGH)>,
+				     <SOC_PERIPHERAL_IRQ(86, IRQ_TYPE_LEVEL_HIGH)>;
 			interrupt-names = "mux", "fil", "arp_ns";
 			phy-mode = "rgmii";
 			clocks = <&cpg CPG_MOD R9A07G043_ETH0_CLK_AXI>,
@@ -675,9 +674,9 @@ eth1: ethernet@11c30000 {
 			compatible = "renesas,r9a07g043-gbeth",
 				     "renesas,rzg2l-gbeth";
 			reg = <0 0x11c30000 0 0x10000>;
-			interrupts = <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <SOC_PERIPHERAL_IRQ(87, IRQ_TYPE_LEVEL_HIGH)>,
+				     <SOC_PERIPHERAL_IRQ(88, IRQ_TYPE_LEVEL_HIGH)>,
+				     <SOC_PERIPHERAL_IRQ(89, IRQ_TYPE_LEVEL_HIGH)>;
 			interrupt-names = "mux", "fil", "arp_ns";
 			phy-mode = "rgmii";
 			clocks = <&cpg CPG_MOD R9A07G043_ETH1_CLK_AXI>,
@@ -705,7 +704,7 @@ phyrst: usbphy-ctrl@11c40000 {
 		ohci0: usb@11c50000 {
 			compatible = "generic-ohci";
 			reg = <0 0x11c50000 0 0x100>;
-			interrupts = <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <SOC_PERIPHERAL_IRQ(91, IRQ_TYPE_LEVEL_HIGH)>;
 			clocks = <&cpg CPG_MOD R9A07G043_USB_PCLK>,
 				 <&cpg CPG_MOD R9A07G043_USB_U2H0_HCLK>;
 			resets = <&phyrst 0>,
@@ -719,7 +718,7 @@ ohci0: usb@11c50000 {
 		ohci1: usb@11c70000 {
 			compatible = "generic-ohci";
 			reg = <0 0x11c70000 0 0x100>;
-			interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <SOC_PERIPHERAL_IRQ(96, IRQ_TYPE_LEVEL_HIGH)>;
 			clocks = <&cpg CPG_MOD R9A07G043_USB_PCLK>,
 				 <&cpg CPG_MOD R9A07G043_USB_U2H1_HCLK>;
 			resets = <&phyrst 1>,
@@ -733,7 +732,7 @@ ohci1: usb@11c70000 {
 		ehci0: usb@11c50100 {
 			compatible = "generic-ehci";
 			reg = <0 0x11c50100 0 0x100>;
-			interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <SOC_PERIPHERAL_IRQ(92, IRQ_TYPE_LEVEL_HIGH)>;
 			clocks = <&cpg CPG_MOD R9A07G043_USB_PCLK>,
 				 <&cpg CPG_MOD R9A07G043_USB_U2H0_HCLK>;
 			resets = <&phyrst 0>,
@@ -748,7 +747,7 @@ ehci0: usb@11c50100 {
 		ehci1: usb@11c70100 {
 			compatible = "generic-ehci";
 			reg = <0 0x11c70100 0 0x100>;
-			interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <SOC_PERIPHERAL_IRQ(97, IRQ_TYPE_LEVEL_HIGH)>;
 			clocks = <&cpg CPG_MOD R9A07G043_USB_PCLK>,
 				 <&cpg CPG_MOD R9A07G043_USB_U2H1_HCLK>;
 			resets = <&phyrst 1>,
@@ -764,7 +763,7 @@ usb2_phy0: usb-phy@11c50200 {
 			compatible = "renesas,usb2-phy-r9a07g043",
 				     "renesas,rzg2l-usb2-phy";
 			reg = <0 0x11c50200 0 0x700>;
-			interrupts = <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <SOC_PERIPHERAL_IRQ(94, IRQ_TYPE_LEVEL_HIGH)>;
 			clocks = <&cpg CPG_MOD R9A07G043_USB_PCLK>,
 				 <&cpg CPG_MOD R9A07G043_USB_U2H0_HCLK>;
 			resets = <&phyrst 0>;
@@ -777,7 +776,7 @@ usb2_phy1: usb-phy@11c70200 {
 			compatible = "renesas,usb2-phy-r9a07g043",
 				     "renesas,rzg2l-usb2-phy";
 			reg = <0 0x11c70200 0 0x700>;
-			interrupts = <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <SOC_PERIPHERAL_IRQ(99, IRQ_TYPE_LEVEL_HIGH)>;
 			clocks = <&cpg CPG_MOD R9A07G043_USB_PCLK>,
 				 <&cpg CPG_MOD R9A07G043_USB_U2H1_HCLK>;
 			resets = <&phyrst 1>;
@@ -790,10 +789,10 @@ hsusb: usb@11c60000 {
 			compatible = "renesas,usbhs-r9a07g043",
 				     "renesas,rza2-usbhs";
 			reg = <0 0x11c60000 0 0x10000>;
-			interrupts = <GIC_SPI 100 IRQ_TYPE_EDGE_RISING>,
-				     <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <SOC_PERIPHERAL_IRQ(100, IRQ_TYPE_EDGE_RISING)>,
+				     <SOC_PERIPHERAL_IRQ(101, IRQ_TYPE_LEVEL_HIGH)>,
+				     <SOC_PERIPHERAL_IRQ(102, IRQ_TYPE_LEVEL_HIGH)>,
+				     <SOC_PERIPHERAL_IRQ(103, IRQ_TYPE_LEVEL_HIGH)>;
 			clocks = <&cpg CPG_MOD R9A07G043_USB_PCLK>,
 				 <&cpg CPG_MOD R9A07G043_USB_U2P_EXR_CPUCLK>;
 			resets = <&phyrst 0>,
@@ -812,8 +811,8 @@ wdt0: watchdog@12800800 {
 			clocks = <&cpg CPG_MOD R9A07G043_WDT0_PCLK>,
 				 <&cpg CPG_MOD R9A07G043_WDT0_CLK>;
 			clock-names = "pclk", "oscclk";
-			interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <SOC_PERIPHERAL_IRQ(49, IRQ_TYPE_LEVEL_HIGH)>,
+				     <SOC_PERIPHERAL_IRQ(50, IRQ_TYPE_LEVEL_HIGH)>;
 			interrupt-names = "wdt", "perrout";
 			resets = <&cpg R9A07G043_WDT0_PRESETN>;
 			power-domains = <&cpg>;
@@ -824,7 +823,7 @@ ostm0: timer@12801000 {
 			compatible = "renesas,r9a07g043-ostm",
 				     "renesas,ostm";
 			reg = <0x0 0x12801000 0x0 0x400>;
-			interrupts = <GIC_SPI 46 IRQ_TYPE_EDGE_RISING>;
+			interrupts = <SOC_PERIPHERAL_IRQ(46, IRQ_TYPE_EDGE_RISING)>;
 			clocks = <&cpg CPG_MOD R9A07G043_OSTM0_PCLK>;
 			resets = <&cpg R9A07G043_OSTM0_PRESETZ>;
 			power-domains = <&cpg>;
@@ -835,7 +834,7 @@ ostm1: timer@12801400 {
 			compatible = "renesas,r9a07g043-ostm",
 				     "renesas,ostm";
 			reg = <0x0 0x12801400 0x0 0x400>;
-			interrupts = <GIC_SPI 47 IRQ_TYPE_EDGE_RISING>;
+			interrupts = <SOC_PERIPHERAL_IRQ(47, IRQ_TYPE_EDGE_RISING)>;
 			clocks = <&cpg CPG_MOD R9A07G043_OSTM1_PCLK>;
 			resets = <&cpg R9A07G043_OSTM1_PRESETZ>;
 			power-domains = <&cpg>;
@@ -846,7 +845,7 @@ ostm2: timer@12801800 {
 			compatible = "renesas,r9a07g043-ostm",
 				     "renesas,ostm";
 			reg = <0x0 0x12801800 0x0 0x400>;
-			interrupts = <GIC_SPI 48 IRQ_TYPE_EDGE_RISING>;
+			interrupts = <SOC_PERIPHERAL_IRQ(48, IRQ_TYPE_EDGE_RISING)>;
 			clocks = <&cpg CPG_MOD R9A07G043_OSTM2_PCLK>;
 			resets = <&cpg R9A07G043_OSTM2_PRESETZ>;
 			power-domains = <&cpg>;
diff --git a/arch/arm64/boot/dts/renesas/r9a07g043u.dtsi b/arch/arm64/boot/dts/renesas/r9a07g043u.dtsi
new file mode 100644
index 000000000000..be84392ee47f
--- /dev/null
+++ b/arch/arm64/boot/dts/renesas/r9a07g043u.dtsi
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+/*
+ * Device Tree Source for the RZ/G2UL SoC
+ *
+ * Copyright (C) 2022 Renesas Electronics Corp.
+ */
+
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+#define SOC_PERIPHERAL_IRQ(nr, na)	GIC_SPI nr na
+
+#include "r9a07g043.dtsi"
diff --git a/arch/arm64/boot/dts/renesas/r9a07g043u11-smarc.dts b/arch/arm64/boot/dts/renesas/r9a07g043u11-smarc.dts
index 059885a01ede..01483b4302c2 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g043u11-smarc.dts
+++ b/arch/arm64/boot/dts/renesas/r9a07g043u11-smarc.dts
@@ -17,7 +17,7 @@
 #define SW_SW0_DEV_SEL	1
 #define SW_ET0_EN_N	1
 
-#include "r9a07g043.dtsi"
+#include "r9a07g043u.dtsi"
 #include "rzg2ul-smarc-som.dtsi"
 #include "rzg2ul-smarc.dtsi"
 
-- 
2.25.1

