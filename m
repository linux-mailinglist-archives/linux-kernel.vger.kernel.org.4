Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54A2D6D198A
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 10:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231534AbjCaIM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 04:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231494AbjCaIMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 04:12:48 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A997A1D842;
        Fri, 31 Mar 2023 01:12:40 -0700 (PDT)
Received: from localhost (unknown [188.27.34.213])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 4B94B6603130;
        Fri, 31 Mar 2023 09:12:39 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1680250359;
        bh=VEHW/c/2s4Nzddue0SQRQN8yI6FlgApEF6XFoJ9BplU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jl6ZovPdDx+rPOAQgtUzYm5GbNL4w2nABSX0veFQXNFGpiD39FK0gh8cf6ZGBfc77
         lIwcQAzeDvLrfTNHvpbx6+WXzmms3dk79joh1k3SJBbt4/6Ya1EAmkKoB6QGHujXqe
         v0wbsiTdQh0JthrbN4Df9srL6CFFX4lansfarSkXutfE51RPJhQ7a1L2MfdP6v864o
         lfqALpPVPaFn/xPldO+zlyJEHBHGA4n7q/ZJFdgpdW5XUZemt4Xbd+6MjTGEYVo+dU
         UC4cmVW70CAK3HtVOgWzZKhCBznqebfXHjwyFncLCdH+OTQ9C0/HSsxsTRtyEFaH8q
         XjuvaGsHyKAmQ==
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: [PATCH v3 3/4] arm64: dts: rockchip: rk3588: Add I2S nodes
Date:   Fri, 31 Mar 2023 11:12:25 +0300
Message-Id: <20230331081226.245881-4-cristian.ciocaltea@collabora.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230331081226.245881-1-cristian.ciocaltea@collabora.com>
References: <20230331081226.245881-1-cristian.ciocaltea@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In addition to the five I2S/PCM/TDM controllers and the two I2S/PCM
controllers shared between the RK3588 and RK3588S SoCs, RK3588 provides
another group of four I2S/PCM/TDM controllers.

Add the DT nodes corresponding to the additional controllers.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 arch/arm64/boot/dts/rockchip/rk3588.dtsi | 68 ++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588.dtsi b/arch/arm64/boot/dts/rockchip/rk3588.dtsi
index d085e57fbc4c..8be75556af8f 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588.dtsi
@@ -7,6 +7,74 @@
 #include "rk3588-pinctrl.dtsi"
 
 / {
+	i2s8_8ch: i2s@fddc8000 {
+		compatible = "rockchip,rk3588-i2s-tdm";
+		reg = <0x0 0xfddc8000 0x0 0x1000>;
+		interrupts = <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH 0>;
+		clocks = <&cru MCLK_I2S8_8CH_TX>, <&cru MCLK_I2S8_8CH_TX>, <&cru HCLK_I2S8_8CH>;
+		clock-names = "mclk_tx", "mclk_rx", "hclk";
+		assigned-clocks = <&cru CLK_I2S8_8CH_TX_SRC>;
+		assigned-clock-parents = <&cru PLL_AUPLL>;
+		dmas = <&dmac2 22>;
+		dma-names = "tx";
+		power-domains = <&power RK3588_PD_VO0>;
+		resets = <&cru SRST_M_I2S8_8CH_TX>;
+		reset-names = "tx-m";
+		#sound-dai-cells = <0>;
+		status = "disabled";
+	};
+
+	i2s6_8ch: i2s@fddf4000 {
+		compatible = "rockchip,rk3588-i2s-tdm";
+		reg = <0x0 0xfddf4000 0x0 0x1000>;
+		interrupts = <GIC_SPI 186 IRQ_TYPE_LEVEL_HIGH 0>;
+		clocks = <&cru MCLK_I2S6_8CH_TX>, <&cru MCLK_I2S6_8CH_TX>, <&cru HCLK_I2S6_8CH>;
+		clock-names = "mclk_tx", "mclk_rx", "hclk";
+		assigned-clocks = <&cru CLK_I2S6_8CH_TX_SRC>;
+		assigned-clock-parents = <&cru PLL_AUPLL>;
+		dmas = <&dmac2 4>;
+		dma-names = "tx";
+		power-domains = <&power RK3588_PD_VO1>;
+		resets = <&cru SRST_M_I2S6_8CH_TX>;
+		reset-names = "tx-m";
+		#sound-dai-cells = <0>;
+		status = "disabled";
+	};
+
+	i2s7_8ch: i2s@fddf8000 {
+		compatible = "rockchip,rk3588-i2s-tdm";
+		reg = <0x0 0xfddf8000 0x0 0x1000>;
+		interrupts = <GIC_SPI 187 IRQ_TYPE_LEVEL_HIGH 0>;
+		clocks = <&cru MCLK_I2S7_8CH_RX>, <&cru MCLK_I2S7_8CH_RX>, <&cru HCLK_I2S7_8CH>;
+		clock-names = "mclk_tx", "mclk_rx", "hclk";
+		assigned-clocks = <&cru CLK_I2S7_8CH_RX_SRC>;
+		assigned-clock-parents = <&cru PLL_AUPLL>;
+		dmas = <&dmac2 21>;
+		dma-names = "rx";
+		power-domains = <&power RK3588_PD_VO1>;
+		resets = <&cru SRST_M_I2S7_8CH_RX>;
+		reset-names = "rx-m";
+		#sound-dai-cells = <0>;
+		status = "disabled";
+	};
+
+	i2s10_8ch: i2s@fde00000 {
+		compatible = "rockchip,rk3588-i2s-tdm";
+		reg = <0x0 0xfde00000 0x0 0x1000>;
+		interrupts = <GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH 0>;
+		clocks = <&cru MCLK_I2S10_8CH_RX>, <&cru MCLK_I2S10_8CH_RX>, <&cru HCLK_I2S10_8CH>;
+		clock-names = "mclk_tx", "mclk_rx", "hclk";
+		assigned-clocks = <&cru CLK_I2S10_8CH_RX_SRC>;
+		assigned-clock-parents = <&cru PLL_AUPLL>;
+		dmas = <&dmac2 24>;
+		dma-names = "rx";
+		power-domains = <&power RK3588_PD_VO1>;
+		resets = <&cru SRST_M_I2S10_8CH_RX>;
+		reset-names = "rx-m";
+		#sound-dai-cells = <0>;
+		status = "disabled";
+	};
+
 	gmac0: ethernet@fe1b0000 {
 		compatible = "rockchip,rk3588-gmac", "snps,dwmac-4.20a";
 		reg = <0x0 0xfe1b0000 0x0 0x10000>;
-- 
2.40.0

