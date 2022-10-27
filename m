Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37C8660F41D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 11:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234995AbiJ0Jza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 05:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234975AbiJ0JzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 05:55:19 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 861865052B;
        Thu, 27 Oct 2022 02:55:17 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A63F466028D0;
        Thu, 27 Oct 2022 10:55:15 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1666864516;
        bh=fGsfOe2bAmOVkry45CNvtIEGojv6PfIqmE22PGHK688=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Rc3JAj1zQyYp1VwfxOFOGFOZ+GDbLEUYNn4qeoyaqE/GMuExuAQmEQy2Q2nI2HLh+
         SfE2HnuFP9P/ovZLCgIf4ZIATGyPoyN3CQi1kqt4R7TTFjhoUsIZM2R3ct+c4FQ+9j
         UQmhjB4KneDIQM2RTPNU1MIKkw1mixop8pW2PKjOONRM9e0B8gyW9dzSSoTilZuZp4
         1Ln648Vvg1ztouXOEzbtwCaE9AP49XJv6lzIgpE7i5KNZukzVaG3UvMFlkXulK1xTn
         pxUyVnQLfl6s9rqPBI1sii3JWuHFIR3UaQPj8yJ7lZHps1ovuSWTxl8VZjRCJ2+7vx
         Ex1xdxu9hK3/A==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        angelogioacchino.delregno@collabora.com, hsinyi@chromium.org,
        nfraprado@collabora.com, allen-kh.cheng@mediatek.com,
        sam.shih@mediatek.com, andrew@lunn.ch, sean.wang@mediatek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v2 3/6] arm64: dts: mediatek: mt6795: Add support for APDMA and wire up UART DMAs
Date:   Thu, 27 Oct 2022 11:55:01 +0200
Message-Id: <20221027095504.37432-4-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221027095504.37432-1-angelogioacchino.delregno@collabora.com>
References: <20221027095504.37432-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This SoC has a DMA controller with tx/rx channels for all of the
UART controller IPs: add the apdma node and wire up the DMAs on
all controllers.
When one of the UART controllers is used as a serial console,
the DMA will be automatically ignored.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt6795.dtsi | 34 ++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt6795.dtsi b/arch/arm64/boot/dts/mediatek/mt6795.dtsi
index 60a07410ff63..39677eec388b 100644
--- a/arch/arm64/boot/dts/mediatek/mt6795.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt6795.dtsi
@@ -316,6 +316,8 @@ uart0: serial@11002000 {
 			interrupts = <GIC_SPI 91 IRQ_TYPE_LEVEL_LOW>;
 			clocks = <&pericfg CLK_PERI_UART0_SEL>, <&pericfg CLK_PERI_UART0>;
 			clock-names = "baud", "bus";
+			dmas = <&apdma 0>, <&apdma 1>;
+			dma-names = "tx", "rx";
 			status = "disabled";
 		};
 
@@ -326,9 +328,37 @@ uart1: serial@11003000 {
 			interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_LOW>;
 			clocks = <&pericfg CLK_PERI_UART1_SEL>, <&pericfg CLK_PERI_UART1>;
 			clock-names = "baud", "bus";
+			dmas = <&apdma 2>, <&apdma 3>;
+			dma-names = "tx", "rx";
 			status = "disabled";
 		};
 
+		apdma: dma-controller@11000380 {
+			compatible = "mediatek,mt6795-uart-dma",
+				     "mediatek,mt6577-uart-dma";
+			reg = <0 0x11000380 0 0x60>,
+			      <0 0x11000400 0 0x60>,
+			      <0 0x11000480 0 0x60>,
+			      <0 0x11000500 0 0x60>,
+			      <0 0x11000580 0 0x60>,
+			      <0 0x11000600 0 0x60>,
+			      <0 0x11000680 0 0x60>,
+			      <0 0x11000700 0 0x60>;
+			interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_LOW>,
+				     <GIC_SPI 104 IRQ_TYPE_LEVEL_LOW>,
+				     <GIC_SPI 105 IRQ_TYPE_LEVEL_LOW>,
+				     <GIC_SPI 106 IRQ_TYPE_LEVEL_LOW>,
+				     <GIC_SPI 107 IRQ_TYPE_LEVEL_LOW>,
+				     <GIC_SPI 108 IRQ_TYPE_LEVEL_LOW>,
+				     <GIC_SPI 109 IRQ_TYPE_LEVEL_LOW>,
+				     <GIC_SPI 110 IRQ_TYPE_LEVEL_LOW>;
+			dma-requests = <8>;
+			clocks = <&pericfg CLK_PERI_AP_DMA>;
+			clock-names = "apdma";
+			mediatek,dma-33bits;
+			#dma-cells = <1>;
+		};
+
 		uart2: serial@11004000 {
 			compatible = "mediatek,mt6795-uart",
 				     "mediatek,mt6577-uart";
@@ -336,6 +366,8 @@ uart2: serial@11004000 {
 			interrupts = <GIC_SPI 93 IRQ_TYPE_LEVEL_LOW>;
 			clocks = <&pericfg CLK_PERI_UART2_SEL>, <&pericfg CLK_PERI_UART2>;
 			clock-names = "baud", "bus";
+			dmas = <&apdma 4>, <&apdma 5>;
+			dma-names = "tx", "rx";
 			status = "disabled";
 		};
 
@@ -346,6 +378,8 @@ uart3: serial@11005000 {
 			interrupts = <GIC_SPI 94 IRQ_TYPE_LEVEL_LOW>;
 			clocks = <&pericfg CLK_PERI_UART3_SEL>, <&pericfg CLK_PERI_UART3>;
 			clock-names = "baud", "bus";
+			dmas = <&apdma 6>, <&apdma 7>;
+			dma-names = "tx", "rx";
 			status = "disabled";
 		};
 	};
-- 
2.37.2

