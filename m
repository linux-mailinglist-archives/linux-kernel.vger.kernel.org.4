Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 869CD60F41E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 11:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233283AbiJ0Jzd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 05:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234596AbiJ0JzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 05:55:19 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67B7F5246F;
        Thu, 27 Oct 2022 02:55:18 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 817CD66028D1;
        Thu, 27 Oct 2022 10:55:16 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1666864517;
        bh=WgoDvhQSuu9tCIfcj5g2O+S6s8LD3ydjrKtrkug1bN8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SnKNDqmZtNk88QMipJd9MBel8LetO0m14vAXi+1AN6ZMUBQcwyma2gpDrn4WqMyNP
         w7bIFB2zyhQ5HHAuyg+YVo+VezBU9CFCJ0jSxp4CRr91z4hTW+CpLNWVPMoBJSZBc1
         lLH37j84X32yTegGV2SPVOZlM4f2I5tV0VC9yWynRspbJXgRg7NdRQJ+y1FH7MEAYa
         CEquSj+IFB8KgjiD7eFvVqzB8auWh4xsWthPf3lO7Je6aWS/W+ijqEL2HC2SgnAWIn
         t3a76O4ei/O8+helnxhfCZuZJcsOoWH84HKBdKYrDynXMWXgKoKULhkuvvS4V4i6k6
         6x+SYGwIECTQQ==
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
Subject: [PATCH v2 4/6] arm64: dts: mediatek: mt6795: Add support for eMMC/SD/SDIO controllers
Date:   Thu, 27 Oct 2022 11:55:02 +0200
Message-Id: <20221027095504.37432-5-angelogioacchino.delregno@collabora.com>
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

Add the mmc nodes to support all of the four controllers, used for
eMMC, SD/MicroSD and SDIO storage.
All of these controller nodes are left disabled by default, as
usage is board dependent.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt6795.dtsi | 41 ++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt6795.dtsi b/arch/arm64/boot/dts/mediatek/mt6795.dtsi
index 39677eec388b..1564f2c127c4 100644
--- a/arch/arm64/boot/dts/mediatek/mt6795.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt6795.dtsi
@@ -382,5 +382,46 @@ uart3: serial@11005000 {
 			dma-names = "tx", "rx";
 			status = "disabled";
 		};
+
+		mmc0: mmc@11230000 {
+			compatible = "mediatek,mt6795-mmc";
+			reg = <0 0x11230000 0 0x1000>;
+			interrupts = <GIC_SPI 79 IRQ_TYPE_LEVEL_LOW>;
+			clocks = <&pericfg CLK_PERI_MSDC30_0>,
+				 <&topckgen CLK_TOP_MSDC50_0_H_SEL>,
+				 <&topckgen CLK_TOP_MSDC50_0_SEL>;
+			clock-names = "source", "hclk", "source_cg";
+			status = "disabled";
+		};
+
+		mmc1: mmc@11240000 {
+			compatible = "mediatek,mt6795-mmc";
+			reg = <0 0x11240000 0 0x1000>;
+			interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_LOW>;
+			clocks = <&pericfg CLK_PERI_MSDC30_1>,
+				 <&topckgen CLK_TOP_AXI_SEL>;
+			clock-names = "source", "hclk";
+			status = "disabled";
+		};
+
+		mmc2: mmc@11250000 {
+			compatible = "mediatek,mt6795-mmc";
+			reg = <0 0x11250000 0 0x1000>;
+			interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_LOW>;
+			clocks = <&pericfg CLK_PERI_MSDC30_2>,
+				 <&topckgen CLK_TOP_AXI_SEL>;
+			clock-names = "source", "hclk";
+			status = "disabled";
+		};
+
+		mmc3: mmc@11260000 {
+			compatible = "mediatek,mt6795-mmc";
+			reg = <0 0x11260000 0 0x1000>;
+			interrupts = <GIC_SPI 82 IRQ_TYPE_LEVEL_LOW>;
+			clocks = <&pericfg CLK_PERI_MSDC30_3>,
+				 <&topckgen CLK_TOP_AXI_SEL>;
+			clock-names = "source", "hclk";
+			status = "disabled";
+		};
 	};
 };
-- 
2.37.2

