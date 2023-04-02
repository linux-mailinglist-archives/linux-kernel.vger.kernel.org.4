Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B22ED6D36B4
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 11:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbjDBJvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 05:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbjDBJvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 05:51:11 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B59605FF9;
        Sun,  2 Apr 2023 02:51:09 -0700 (PDT)
Received: from localhost (unknown [188.27.34.213])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 658BD660312B;
        Sun,  2 Apr 2023 10:51:08 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1680429068;
        bh=XO/BROgu9s186EZyA4Y0THzEjWTcDSJbUQnZjuYVoLk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VaYy3P1c5C4yOiVjw4jLJMVn6oiNQLeU6vIS3veMtCPgK//cvJXZe7EjMFPQ6yWkk
         UwnKKjqIBRn7tj2zhPtm9gIE66LX+ORhkyhVP76/mImhtBsENGXLLoQRGG26ujSjpa
         Vrzu8CUkcfGd74qgJnz5vWHX5UR3lB8N/A1I8W1Atf6jEjTbPi5P34aswjDV8qqAjL
         JJ5THpKvVrh24ccUgNEMfDbuyIilxrdb3/D+cOle4/7RXRK5Ji1QlJ6pMlwgvBCl7p
         FyiI7RCD9113eBy/D0pzcIdUrnFqIu3q0wBzr7AUu1/QFWZ3ut7shhUdhXTyqMLx1r
         RKzmoDWUvwUqg==
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Sugar Zhang <sugar.zhang@rock-chips.com>,
        Jagan Teki <jagan@edgeble.ai>,
        Kever Yang <kever.yang@rock-chips.com>,
        Elaine Zhang <zhangqing@rock-chips.com>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: [PATCH v4 3/5] arm64: dts: rockchip: rk3588s: Add I2S nodes
Date:   Sun,  2 Apr 2023 12:50:52 +0300
Message-Id: <20230402095054.384739-4-cristian.ciocaltea@collabora.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230402095054.384739-1-cristian.ciocaltea@collabora.com>
References: <20230402095054.384739-1-cristian.ciocaltea@collabora.com>
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

There are five I2S/PCM/TDM controllers and two I2S/PCM controllers
embedded in the RK3588 and RK3588S SoCs.

Add the DT nodes corresponding to the above mentioned Rockchip
controllers.

Also note RK3588 SoC contains four additional I2S/PCM/TDM controllers,
which are handled via a separate patch.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 arch/arm64/boot/dts/rockchip/rk3588s.dtsi | 148 ++++++++++++++++++++++
 1 file changed, 148 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
index e3546cfacc88..cabf1cfe208e 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
@@ -821,6 +821,57 @@ power-domain@RK3588_PD_SDMMC {
 		};
 	};
 
+	i2s4_8ch: i2s@fddc0000 {
+		compatible = "rockchip,rk3588-i2s-tdm";
+		reg = <0x0 0xfddc0000 0x0 0x1000>;
+		interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH 0>;
+		clocks = <&cru MCLK_I2S4_8CH_TX>, <&cru MCLK_I2S4_8CH_TX>, <&cru HCLK_I2S4_8CH>;
+		clock-names = "mclk_tx", "mclk_rx", "hclk";
+		assigned-clocks = <&cru CLK_I2S4_8CH_TX_SRC>;
+		assigned-clock-parents = <&cru PLL_AUPLL>;
+		dmas = <&dmac2 0>;
+		dma-names = "tx";
+		power-domains = <&power RK3588_PD_VO0>;
+		resets = <&cru SRST_M_I2S4_8CH_TX>;
+		reset-names = "tx-m";
+		#sound-dai-cells = <0>;
+		status = "disabled";
+	};
+
+	i2s5_8ch: i2s@fddf0000 {
+		compatible = "rockchip,rk3588-i2s-tdm";
+		reg = <0x0 0xfddf0000 0x0 0x1000>;
+		interrupts = <GIC_SPI 185 IRQ_TYPE_LEVEL_HIGH 0>;
+		clocks = <&cru MCLK_I2S5_8CH_TX>, <&cru MCLK_I2S5_8CH_TX>, <&cru HCLK_I2S5_8CH>;
+		clock-names = "mclk_tx", "mclk_rx", "hclk";
+		assigned-clocks = <&cru CLK_I2S5_8CH_TX_SRC>;
+		assigned-clock-parents = <&cru PLL_AUPLL>;
+		dmas = <&dmac2 2>;
+		dma-names = "tx";
+		power-domains = <&power RK3588_PD_VO1>;
+		resets = <&cru SRST_M_I2S5_8CH_TX>;
+		reset-names = "tx-m";
+		#sound-dai-cells = <0>;
+		status = "disabled";
+	};
+
+	i2s9_8ch: i2s@fddfc000 {
+		compatible = "rockchip,rk3588-i2s-tdm";
+		reg = <0x0 0xfddfc000 0x0 0x1000>;
+		interrupts = <GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH 0>;
+		clocks = <&cru MCLK_I2S9_8CH_RX>, <&cru MCLK_I2S9_8CH_RX>, <&cru HCLK_I2S9_8CH>;
+		clock-names = "mclk_tx", "mclk_rx", "hclk";
+		assigned-clocks = <&cru CLK_I2S9_8CH_RX_SRC>;
+		assigned-clock-parents = <&cru PLL_AUPLL>;
+		dmas = <&dmac2 23>;
+		dma-names = "rx";
+		power-domains = <&power RK3588_PD_VO1>;
+		resets = <&cru SRST_M_I2S9_8CH_RX>;
+		reset-names = "rx-m";
+		#sound-dai-cells = <0>;
+		status = "disabled";
+	};
+
 	qos_gpu_m0: qos@fdf35000 {
 		compatible = "rockchip,rk3588-qos", "syscon";
 		reg = <0x0 0xfdf35000 0x0 0x20>;
@@ -1143,6 +1194,103 @@ sdhci: mmc@fe2e0000 {
 		status = "disabled";
 	};
 
+	i2s0_8ch: i2s@fe470000 {
+		compatible = "rockchip,rk3588-i2s-tdm";
+		reg = <0x0 0xfe470000 0x0 0x1000>;
+		interrupts = <GIC_SPI 180 IRQ_TYPE_LEVEL_HIGH 0>;
+		clocks = <&cru MCLK_I2S0_8CH_TX>, <&cru MCLK_I2S0_8CH_RX>, <&cru HCLK_I2S0_8CH>;
+		clock-names = "mclk_tx", "mclk_rx", "hclk";
+		assigned-clocks = <&cru CLK_I2S0_8CH_TX_SRC>, <&cru CLK_I2S0_8CH_RX_SRC>;
+		assigned-clock-parents = <&cru PLL_AUPLL>, <&cru PLL_AUPLL>;
+		dmas = <&dmac0 0>, <&dmac0 1>;
+		dma-names = "tx", "rx";
+		power-domains = <&power RK3588_PD_AUDIO>;
+		resets = <&cru SRST_M_I2S0_8CH_TX>, <&cru SRST_M_I2S0_8CH_RX>;
+		reset-names = "tx-m", "rx-m";
+		rockchip,trcm-sync-tx-only;
+		pinctrl-names = "default";
+		pinctrl-0 = <&i2s0_lrck
+			     &i2s0_sclk
+			     &i2s0_sdi0
+			     &i2s0_sdi1
+			     &i2s0_sdi2
+			     &i2s0_sdi3
+			     &i2s0_sdo0
+			     &i2s0_sdo1
+			     &i2s0_sdo2
+			     &i2s0_sdo3>;
+		#sound-dai-cells = <0>;
+		status = "disabled";
+	};
+
+	i2s1_8ch: i2s@fe480000 {
+		compatible = "rockchip,rk3588-i2s-tdm";
+		reg = <0x0 0xfe480000 0x0 0x1000>;
+		interrupts = <GIC_SPI 181 IRQ_TYPE_LEVEL_HIGH 0>;
+		clocks = <&cru MCLK_I2S1_8CH_TX>, <&cru MCLK_I2S1_8CH_RX>, <&cru HCLK_I2S1_8CH>;
+		clock-names = "mclk_tx", "mclk_rx", "hclk";
+		dmas = <&dmac0 2>, <&dmac0 3>;
+		dma-names = "tx", "rx";
+		resets = <&cru SRST_M_I2S1_8CH_TX>, <&cru SRST_M_I2S1_8CH_RX>;
+		reset-names = "tx-m", "rx-m";
+		rockchip,trcm-sync-tx-only;
+		pinctrl-names = "default";
+		pinctrl-0 = <&i2s1m0_lrck
+			     &i2s1m0_sclk
+			     &i2s1m0_sdi0
+			     &i2s1m0_sdi1
+			     &i2s1m0_sdi2
+			     &i2s1m0_sdi3
+			     &i2s1m0_sdo0
+			     &i2s1m0_sdo1
+			     &i2s1m0_sdo2
+			     &i2s1m0_sdo3>;
+		#sound-dai-cells = <0>;
+		status = "disabled";
+	};
+
+	i2s2_2ch: i2s@fe490000 {
+		compatible = "rockchip,rk3588-i2s", "rockchip,rk3066-i2s";
+		reg = <0x0 0xfe490000 0x0 0x1000>;
+		interrupts = <GIC_SPI 182 IRQ_TYPE_LEVEL_HIGH 0>;
+		clocks = <&cru MCLK_I2S2_2CH>, <&cru HCLK_I2S2_2CH>;
+		clock-names = "i2s_clk", "i2s_hclk";
+		assigned-clocks = <&cru CLK_I2S2_2CH_SRC>;
+		assigned-clock-parents = <&cru PLL_AUPLL>;
+		dmas = <&dmac1 0>, <&dmac1 1>;
+		dma-names = "tx", "rx";
+		power-domains = <&power RK3588_PD_AUDIO>;
+		rockchip,trcm-sync-tx-only;
+		pinctrl-names = "default";
+		pinctrl-0 = <&i2s2m1_lrck
+			     &i2s2m1_sclk
+			     &i2s2m1_sdi
+			     &i2s2m1_sdo>;
+		#sound-dai-cells = <0>;
+		status = "disabled";
+	};
+
+	i2s3_2ch: i2s@fe4a0000 {
+		compatible = "rockchip,rk3588-i2s", "rockchip,rk3066-i2s";
+		reg = <0x0 0xfe4a0000 0x0 0x1000>;
+		interrupts = <GIC_SPI 183 IRQ_TYPE_LEVEL_HIGH 0>;
+		clocks = <&cru MCLK_I2S3_2CH>, <&cru HCLK_I2S3_2CH>;
+		clock-names = "i2s_clk", "i2s_hclk";
+		assigned-clocks = <&cru CLK_I2S3_2CH_SRC>;
+		assigned-clock-parents = <&cru PLL_AUPLL>;
+		dmas = <&dmac1 2>, <&dmac1 3>;
+		dma-names = "tx", "rx";
+		power-domains = <&power RK3588_PD_AUDIO>;
+		rockchip,trcm-sync-tx-only;
+		pinctrl-names = "default";
+		pinctrl-0 = <&i2s3_lrck
+			     &i2s3_sclk
+			     &i2s3_sdi
+			     &i2s3_sdo>;
+		#sound-dai-cells = <0>;
+		status = "disabled";
+	};
+
 	gic: interrupt-controller@fe600000 {
 		compatible = "arm,gic-v3";
 		reg = <0x0 0xfe600000 0 0x10000>, /* GICD */
-- 
2.40.0

