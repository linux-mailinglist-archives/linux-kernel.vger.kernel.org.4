Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A498716963
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 18:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232960AbjE3Q0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 12:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232662AbjE3Q0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 12:26:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACB8E133;
        Tue, 30 May 2023 09:25:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7C13962CD7;
        Tue, 30 May 2023 16:25:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A94CC433A1;
        Tue, 30 May 2023 16:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685463934;
        bh=RnQbeJH9LOqDlc/lhZAIJ3tBGtegkRJ2CBq804dfyoE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BvujgzeXENEw2nIpAJLGD3qJZjd1/A/vxa3caQNElmxPw+2XTSL1g3oxJS1eKie1O
         0ZTgoXwEohEQ+tjv36XUVC04w8fdxu15XVhCejVwutWZxwSoPV8mwAbpjLgqELtI62
         xbfdfND1VuG/OuntUp/phfVa9C3a5bsw4BSFQxTEs/RmmWJlex7FtgIqHtER3QKehB
         ZthKOK3nQGexM+CjbvWz8qVI3DJik8EeTPA+Gi2Q7Hhy0RG0eDpS+u2700tixg/Fi8
         6qJgiB5S1zbZ/TTzPWtmZsqGIVHvx+u9EPgZnrh1VIN31s/vF4l72Smwcd7si7DwcU
         F3F4oer8x52Tg==
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vinod Koul <vkoul@kernel.org>
Subject: [PATCH v3 09/15] arm64: dts: qcom: sc8180x: Add QUPs
Date:   Tue, 30 May 2023 21:54:48 +0530
Message-Id: <20230530162454.51708-10-vkoul@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230530162454.51708-1-vkoul@kernel.org>
References: <20230530162454.51708-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds qup instances and i2c, spi, serial ports

Co-developed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 arch/arm64/boot/dts/qcom/sc8180x.dtsi | 859 ++++++++++++++++++++++++++
 1 file changed, 859 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc8180x.dtsi b/arch/arm64/boot/dts/qcom/sc8180x.dtsi
index da7c08e70540..b50673b7c147 100644
--- a/arch/arm64/boot/dts/qcom/sc8180x.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8180x.dtsi
@@ -780,6 +780,865 @@ gcc: clock-controller@100000 {
 				      "sleep_clk";
 		};
 
+		qupv3_id_0: geniqup@8c0000 {
+			compatible = "qcom,geni-se-qup";
+			reg = <0 0x008c0000 0 0x6000>;
+			clocks = <&gcc GCC_QUPV3_WRAP_0_M_AHB_CLK>,
+				 <&gcc GCC_QUPV3_WRAP_0_S_AHB_CLK>;
+			clock-names = "m-ahb", "s-ahb";
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+			iommus = <&apps_smmu 0x4c3 0>;
+			status = "disabled";
+
+			i2c0: i2c@880000 {
+				compatible = "qcom,geni-i2c";
+				reg = <0 0x00880000 0 0x4000>;
+				clocks = <&gcc GCC_QUPV3_WRAP0_S0_CLK>;
+				clock-names = "se";
+				interrupts = <GIC_SPI 601 IRQ_TYPE_LEVEL_HIGH>;
+				interconnects = <&qup_virt MASTER_QUP_CORE_0 0 &qup_virt SLAVE_QUP_CORE_0 0>,
+						<&gem_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_QUP_0 0>,
+						<&aggre2_noc MASTER_QUP_0 0 &mc_virt SLAVE_EBI_CH0 0>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			spi0: spi@880000 {
+				compatible = "qcom,geni-spi";
+				reg = <0 0x00880000 0 0x4000>;
+				clocks = <&gcc GCC_QUPV3_WRAP0_S0_CLK>;
+				clock-names = "se";
+				interrupts = <GIC_SPI 601 IRQ_TYPE_LEVEL_HIGH>;
+				interconnects = <&qup_virt MASTER_QUP_CORE_0 0 &qup_virt SLAVE_QUP_CORE_0 0>,
+						<&gem_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_QUP_0 0>;
+				interconnect-names = "qup-core", "qup-config";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			uart0: serial@880000 {
+				compatible = "qcom,geni-uart";
+				reg = <0 0x00880000 0 0x4000>;
+				clocks = <&gcc GCC_QUPV3_WRAP0_S0_CLK>;
+				clock-names = "se";
+				interrupts = <GIC_SPI 601 IRQ_TYPE_LEVEL_HIGH>;
+				interconnects = <&qup_virt MASTER_QUP_CORE_0 0 &qup_virt SLAVE_QUP_CORE_0 0>,
+						<&gem_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_QUP_0 0>;
+				interconnect-names = "qup-core", "qup-config";
+				status = "disabled";
+			};
+
+			i2c1: i2c@884000 {
+				compatible = "qcom,geni-i2c";
+				reg = <0 0x00884000 0 0x4000>;
+				clocks = <&gcc GCC_QUPV3_WRAP0_S1_CLK>;
+				clock-names = "se";
+				interrupts = <GIC_SPI 602 IRQ_TYPE_LEVEL_HIGH>;
+				interconnects = <&qup_virt MASTER_QUP_CORE_0 0 &qup_virt SLAVE_QUP_CORE_0 0>,
+						<&gem_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_QUP_0 0>,
+						<&aggre2_noc MASTER_QUP_0 0 &mc_virt SLAVE_EBI_CH0 0>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			spi1: spi@884000 {
+				compatible = "qcom,geni-spi";
+				reg = <0 0x00884000 0 0x4000>;
+				clocks = <&gcc GCC_QUPV3_WRAP0_S1_CLK>;
+				clock-names = "se";
+				interrupts = <GIC_SPI 602 IRQ_TYPE_LEVEL_HIGH>;
+				interconnects = <&qup_virt MASTER_QUP_CORE_0 0 &qup_virt SLAVE_QUP_CORE_0 0>,
+						<&gem_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_QUP_0 0>;
+				interconnect-names = "qup-core", "qup-config";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			uart1: serial@884000 {
+				compatible = "qcom,geni-uart";
+				reg = <0 0x00884000 0 0x4000>;
+				clocks = <&gcc GCC_QUPV3_WRAP0_S1_CLK>;
+				clock-names = "se";
+				interrupts = <GIC_SPI 602 IRQ_TYPE_LEVEL_HIGH>;
+				interconnects = <&qup_virt MASTER_QUP_CORE_0 0 &qup_virt SLAVE_QUP_CORE_0 0>,
+						<&gem_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_QUP_0 0>;
+				interconnect-names = "qup-core", "qup-config";
+				status = "disabled";
+			};
+
+			i2c2: i2c@888000 {
+				compatible = "qcom,geni-i2c";
+				reg = <0 0x00888000 0 0x4000>;
+				clocks = <&gcc GCC_QUPV3_WRAP0_S2_CLK>;
+				clock-names = "se";
+				interrupts = <GIC_SPI 603 IRQ_TYPE_LEVEL_HIGH>;
+				interconnects = <&qup_virt MASTER_QUP_CORE_0 0 &qup_virt SLAVE_QUP_CORE_0 0>,
+						<&gem_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_QUP_0 0>,
+						<&aggre2_noc MASTER_QUP_0 0 &mc_virt SLAVE_EBI_CH0 0>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			spi2: spi@888000 {
+				compatible = "qcom,geni-spi";
+				reg = <0 0x00888000 0 0x4000>;
+				clocks = <&gcc GCC_QUPV3_WRAP0_S2_CLK>;
+				clock-names = "se";
+				interrupts = <GIC_SPI 603 IRQ_TYPE_LEVEL_HIGH>;
+				interconnects = <&qup_virt MASTER_QUP_CORE_0 0 &qup_virt SLAVE_QUP_CORE_0 0>,
+						<&gem_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_QUP_0 0>;
+				interconnect-names = "qup-core", "qup-config";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			uart2: serial@888000 {
+				compatible = "qcom,geni-uart";
+				reg = <0 0x00888000 0 0x4000>;
+				clocks = <&gcc GCC_QUPV3_WRAP0_S2_CLK>;
+				clock-names = "se";
+				interrupts = <GIC_SPI 603 IRQ_TYPE_LEVEL_HIGH>;
+				interconnects = <&qup_virt MASTER_QUP_CORE_0 0 &qup_virt SLAVE_QUP_CORE_0 0>,
+						<&gem_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_QUP_0 0>;
+				interconnect-names = "qup-core", "qup-config";
+				status = "disabled";
+			};
+
+			i2c3: i2c@88c000 {
+				compatible = "qcom,geni-i2c";
+				reg = <0 0x0088c000 0 0x4000>;
+				clocks = <&gcc GCC_QUPV3_WRAP0_S3_CLK>;
+				clock-names = "se";
+				interrupts = <GIC_SPI 604 IRQ_TYPE_LEVEL_HIGH>;
+				interconnects = <&qup_virt MASTER_QUP_CORE_0 0 &qup_virt SLAVE_QUP_CORE_0 0>,
+						<&gem_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_QUP_0 0>,
+						<&aggre2_noc MASTER_QUP_0 0 &mc_virt SLAVE_EBI_CH0 0>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			spi3: spi@88c000 {
+				compatible = "qcom,geni-spi";
+				reg = <0 0x0088c000 0 0x4000>;
+				clocks = <&gcc GCC_QUPV3_WRAP0_S3_CLK>;
+				clock-names = "se";
+				interrupts = <GIC_SPI 604 IRQ_TYPE_LEVEL_HIGH>;
+				interconnects = <&qup_virt MASTER_QUP_CORE_0 0 &qup_virt SLAVE_QUP_CORE_0 0>,
+						<&gem_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_QUP_0 0>;
+				interconnect-names = "qup-core", "qup-config";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			uart3: serial@88c000 {
+				compatible = "qcom,geni-uart";
+				reg = <0 0x0088c000 0 0x4000>;
+				clocks = <&gcc GCC_QUPV3_WRAP0_S3_CLK>;
+				clock-names = "se";
+				interrupts = <GIC_SPI 604 IRQ_TYPE_LEVEL_HIGH>;
+				interconnects = <&qup_virt MASTER_QUP_CORE_0 0 &qup_virt SLAVE_QUP_CORE_0 0>,
+						<&gem_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_QUP_0 0>;
+				interconnect-names = "qup-core", "qup-config";
+				status = "disabled";
+			};
+
+			i2c4: i2c@890000 {
+				compatible = "qcom,geni-i2c";
+				reg = <0 0x00890000 0 0x4000>;
+				clocks = <&gcc GCC_QUPV3_WRAP0_S4_CLK>;
+				clock-names = "se";
+				interrupts = <GIC_SPI 605 IRQ_TYPE_LEVEL_HIGH>;
+				interconnects = <&qup_virt MASTER_QUP_CORE_0 0 &qup_virt SLAVE_QUP_CORE_0 0>,
+						<&gem_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_QUP_0 0>,
+						<&aggre2_noc MASTER_QUP_0 0 &mc_virt SLAVE_EBI_CH0 0>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			spi4: spi@890000 {
+				compatible = "qcom,geni-spi";
+				reg = <0 0x00890000 0 0x4000>;
+				clocks = <&gcc GCC_QUPV3_WRAP0_S4_CLK>;
+				clock-names = "se";
+				interrupts = <GIC_SPI 605 IRQ_TYPE_LEVEL_HIGH>;
+				interconnects = <&qup_virt MASTER_QUP_CORE_0 0 &qup_virt SLAVE_QUP_CORE_0 0>,
+						<&gem_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_QUP_0 0>;
+				interconnect-names = "qup-core", "qup-config";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			uart4: serial@890000 {
+				compatible = "qcom,geni-uart";
+				reg = <0 0x00890000 0 0x4000>;
+				clocks = <&gcc GCC_QUPV3_WRAP0_S4_CLK>;
+				clock-names = "se";
+				interrupts = <GIC_SPI 605 IRQ_TYPE_LEVEL_HIGH>;
+				interconnects = <&qup_virt MASTER_QUP_CORE_0 0 &qup_virt SLAVE_QUP_CORE_0 0>,
+						<&gem_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_QUP_0 0>;
+				interconnect-names = "qup-core", "qup-config";
+				status = "disabled";
+			};
+
+			i2c5: i2c@894000 {
+				compatible = "qcom,geni-i2c";
+				reg = <0 0x00894000 0 0x4000>;
+				clocks = <&gcc GCC_QUPV3_WRAP0_S5_CLK>;
+				clock-names = "se";
+				interrupts = <GIC_SPI 606 IRQ_TYPE_LEVEL_HIGH>;
+				interconnects = <&qup_virt MASTER_QUP_CORE_0 0 &qup_virt SLAVE_QUP_CORE_0 0>,
+						<&gem_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_QUP_0 0>,
+						<&aggre2_noc MASTER_QUP_0 0 &mc_virt SLAVE_EBI_CH0 0>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			spi5: spi@894000 {
+				compatible = "qcom,geni-spi";
+				reg = <0 0x00894000 0 0x4000>;
+				clocks = <&gcc GCC_QUPV3_WRAP0_S5_CLK>;
+				clock-names = "se";
+				interrupts = <GIC_SPI 606 IRQ_TYPE_LEVEL_HIGH>;
+				interconnects = <&qup_virt MASTER_QUP_CORE_0 0 &qup_virt SLAVE_QUP_CORE_0 0>,
+						<&gem_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_QUP_0 0>;
+				interconnect-names = "qup-core", "qup-config";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			uart5: serial@894000 {
+				compatible = "qcom,geni-uart";
+				reg = <0 0x00894000 0 0x4000>;
+				clocks = <&gcc GCC_QUPV3_WRAP0_S5_CLK>;
+				clock-names = "se";
+				interrupts = <GIC_SPI 606 IRQ_TYPE_LEVEL_HIGH>;
+				interconnects = <&qup_virt MASTER_QUP_CORE_0 0 &qup_virt SLAVE_QUP_CORE_0 0>,
+						<&gem_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_QUP_0 0>;
+				interconnect-names = "qup-core", "qup-config";
+				status = "disabled";
+			};
+
+			i2c6: i2c@898000 {
+				compatible = "qcom,geni-i2c";
+				reg = <0 0x00898000 0 0x4000>;
+				clocks = <&gcc GCC_QUPV3_WRAP0_S6_CLK>;
+				clock-names = "se";
+				interrupts = <GIC_SPI 607 IRQ_TYPE_LEVEL_HIGH>;
+				interconnects = <&qup_virt MASTER_QUP_CORE_0 0 &qup_virt SLAVE_QUP_CORE_0 0>,
+						<&gem_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_QUP_0 0>,
+						<&aggre2_noc MASTER_QUP_0 0 &mc_virt SLAVE_EBI_CH0 0>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			spi6: spi@898000 {
+				compatible = "qcom,geni-spi";
+				reg = <0 0x00898000 0 0x4000>;
+				clocks = <&gcc GCC_QUPV3_WRAP0_S6_CLK>;
+				clock-names = "se";
+				interrupts = <GIC_SPI 607 IRQ_TYPE_LEVEL_HIGH>;
+				interconnects = <&qup_virt MASTER_QUP_CORE_0 0 &qup_virt SLAVE_QUP_CORE_0 0>,
+						<&gem_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_QUP_0 0>;
+				interconnect-names = "qup-core", "qup-config";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			uart6: serial@898000 {
+				compatible = "qcom,geni-uart";
+				reg = <0 0x00898000 0 0x4000>;
+				clocks = <&gcc GCC_QUPV3_WRAP0_S6_CLK>;
+				clock-names = "se";
+				interrupts = <GIC_SPI 607 IRQ_TYPE_LEVEL_HIGH>;
+				interconnects = <&qup_virt MASTER_QUP_CORE_0 0 &qup_virt SLAVE_QUP_CORE_0 0>,
+						<&gem_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_QUP_0 0>;
+				interconnect-names = "qup-core", "qup-config";
+				status = "disabled";
+			};
+
+			i2c7: i2c@89c000 {
+				compatible = "qcom,geni-i2c";
+				reg = <0 0x0089c000 0 0x4000>;
+				clocks = <&gcc GCC_QUPV3_WRAP0_S7_CLK>;
+				clock-names = "se";
+				interrupts = <GIC_SPI 608 IRQ_TYPE_LEVEL_HIGH>;
+				interconnects = <&qup_virt MASTER_QUP_CORE_0 0 &qup_virt SLAVE_QUP_CORE_0 0>,
+						<&gem_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_QUP_0 0>,
+						<&aggre2_noc MASTER_QUP_0 0 &mc_virt SLAVE_EBI_CH0 0>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			spi7: spi@89c000 {
+				compatible = "qcom,geni-spi";
+				reg = <0 0x0089c000 0 0x4000>;
+				clocks = <&gcc GCC_QUPV3_WRAP0_S7_CLK>;
+				clock-names = "se";
+				interrupts = <GIC_SPI 608 IRQ_TYPE_LEVEL_HIGH>;
+				interconnects = <&qup_virt MASTER_QUP_CORE_0 0 &qup_virt SLAVE_QUP_CORE_0 0>,
+						<&gem_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_QUP_0 0>;
+				interconnect-names = "qup-core", "qup-config";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			uart7: serial@89c000 {
+				compatible = "qcom,geni-uart";
+				reg = <0 0x0089c000 0 0x4000>;
+				clocks = <&gcc GCC_QUPV3_WRAP0_S7_CLK>;
+				clock-names = "se";
+				interrupts = <GIC_SPI 608 IRQ_TYPE_LEVEL_HIGH>;
+				interconnects = <&qup_virt MASTER_QUP_CORE_0 0 &qup_virt SLAVE_QUP_CORE_0 0>,
+						<&gem_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_QUP_0 0>;
+				interconnect-names = "qup-core", "qup-config";
+				status = "disabled";
+			};
+		};
+
+		qupv3_id_1: geniqup@ac0000 {
+			compatible = "qcom,geni-se-qup";
+			reg = <0x0 0x00ac0000 0x0 0x6000>;
+			clocks = <&gcc GCC_QUPV3_WRAP_1_M_AHB_CLK>,
+				 <&gcc GCC_QUPV3_WRAP_1_S_AHB_CLK>;
+			clock-names = "m-ahb", "s-ahb";
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+			iommus = <&apps_smmu 0x603 0>;
+			status = "disabled";
+
+			i2c8: i2c@a80000 {
+				compatible = "qcom,geni-i2c";
+				reg = <0 0x00a80000 0 0x4000>;
+				clocks = <&gcc GCC_QUPV3_WRAP1_S0_CLK>;
+				clock-names = "se";
+				interrupts = <GIC_SPI 353 IRQ_TYPE_LEVEL_HIGH>;
+				interconnects = <&qup_virt MASTER_QUP_CORE_1 0 &qup_virt SLAVE_QUP_CORE_1 0>,
+						<&gem_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_QUP_1 0>,
+						<&aggre2_noc MASTER_QUP_1 0 &mc_virt SLAVE_EBI_CH0 0>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			spi8: spi@a80000 {
+				compatible = "qcom,geni-spi";
+				reg = <0 0x00a80000 0 0x4000>;
+				clocks = <&gcc GCC_QUPV3_WRAP1_S0_CLK>;
+				clock-names = "se";
+				interrupts = <GIC_SPI 353 IRQ_TYPE_LEVEL_HIGH>;
+				interconnects = <&qup_virt MASTER_QUP_CORE_1 0 &qup_virt SLAVE_QUP_CORE_1 0>,
+						<&gem_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_QUP_1 0>;
+				interconnect-names = "qup-core", "qup-config";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			uart8: serial@a80000 {
+				compatible = "qcom,geni-uart";
+				reg = <0 0x00a80000 0 0x4000>;
+				clocks = <&gcc GCC_QUPV3_WRAP1_S0_CLK>;
+				clock-names = "se";
+				interrupts = <GIC_SPI 353 IRQ_TYPE_LEVEL_HIGH>;
+				interconnects = <&qup_virt MASTER_QUP_CORE_1 0 &qup_virt SLAVE_QUP_CORE_1 0>,
+						<&gem_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_QUP_1 0>;
+				interconnect-names = "qup-core", "qup-config";
+				status = "disabled";
+			};
+
+			i2c9: i2c@a84000 {
+				compatible = "qcom,geni-i2c";
+				reg = <0 0x00a84000 0 0x4000>;
+				clocks = <&gcc GCC_QUPV3_WRAP1_S1_CLK>;
+				clock-names = "se";
+				interrupts = <GIC_SPI 354 IRQ_TYPE_LEVEL_HIGH>;
+				interconnects = <&qup_virt MASTER_QUP_CORE_1 0 &qup_virt SLAVE_QUP_CORE_1 0>,
+						<&gem_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_QUP_1 0>,
+						<&aggre2_noc MASTER_QUP_1 0 &mc_virt SLAVE_EBI_CH0 0>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			spi9: spi@a84000 {
+				compatible = "qcom,geni-spi";
+				reg = <0 0x00a84000 0 0x4000>;
+				clocks = <&gcc GCC_QUPV3_WRAP1_S1_CLK>;
+				clock-names = "se";
+				interrupts = <GIC_SPI 354 IRQ_TYPE_LEVEL_HIGH>;
+				interconnects = <&qup_virt MASTER_QUP_CORE_1 0 &qup_virt SLAVE_QUP_CORE_1 0>,
+						<&gem_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_QUP_1 0>;
+				interconnect-names = "qup-core", "qup-config";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			uart9: serial@a84000 {
+				compatible = "qcom,geni-debug-uart";
+				reg = <0 0x00a84000 0 0x4000>;
+				clocks = <&gcc GCC_QUPV3_WRAP1_S1_CLK>;
+				clock-names = "se";
+				interrupts = <GIC_SPI 354 IRQ_TYPE_LEVEL_HIGH>;
+				interconnects = <&qup_virt MASTER_QUP_CORE_1 0 &qup_virt SLAVE_QUP_CORE_1 0>,
+						<&gem_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_QUP_1 0>;
+				interconnect-names = "qup-core", "qup-config";
+				status = "disabled";
+			};
+
+			i2c10: i2c@a88000 {
+				compatible = "qcom,geni-i2c";
+				reg = <0 0x00a88000 0 0x4000>;
+				clocks = <&gcc GCC_QUPV3_WRAP1_S2_CLK>;
+				clock-names = "se";
+				interrupts = <GIC_SPI 355 IRQ_TYPE_LEVEL_HIGH>;
+				interconnects = <&qup_virt MASTER_QUP_CORE_1 0 &qup_virt SLAVE_QUP_CORE_1 0>,
+						<&gem_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_QUP_1 0>,
+						<&aggre2_noc MASTER_QUP_1 0 &mc_virt SLAVE_EBI_CH0 0>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			spi10: spi@a88000 {
+				compatible = "qcom,geni-spi";
+				reg = <0 0x00a88000 0 0x4000>;
+				clocks = <&gcc GCC_QUPV3_WRAP1_S2_CLK>;
+				clock-names = "se";
+				interrupts = <GIC_SPI 355 IRQ_TYPE_LEVEL_HIGH>;
+				interconnects = <&qup_virt MASTER_QUP_CORE_1 0 &qup_virt SLAVE_QUP_CORE_1 0>,
+						<&gem_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_QUP_1 0>;
+				interconnect-names = "qup-core", "qup-config";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			uart10: serial@a88000 {
+				compatible = "qcom,geni-uart";
+				reg = <0 0x00a88000 0 0x4000>;
+				clocks = <&gcc GCC_QUPV3_WRAP1_S2_CLK>;
+				clock-names = "se";
+				interrupts = <GIC_SPI 355 IRQ_TYPE_LEVEL_HIGH>;
+				interconnects = <&qup_virt MASTER_QUP_CORE_1 0 &qup_virt SLAVE_QUP_CORE_1 0>,
+						<&gem_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_QUP_1 0>;
+				interconnect-names = "qup-core", "qup-config";
+				status = "disabled";
+			};
+
+			i2c11: i2c@a8c000 {
+				compatible = "qcom,geni-i2c";
+				reg = <0 0x00a8c000 0 0x4000>;
+				clocks = <&gcc GCC_QUPV3_WRAP1_S3_CLK>;
+				clock-names = "se";
+				interrupts = <GIC_SPI 356 IRQ_TYPE_LEVEL_HIGH>;
+				interconnects = <&qup_virt MASTER_QUP_CORE_1 0 &qup_virt SLAVE_QUP_CORE_1 0>,
+						<&gem_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_QUP_1 0>,
+						<&aggre2_noc MASTER_QUP_1 0 &mc_virt SLAVE_EBI_CH0 0>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			spi11: spi@a8c000 {
+				compatible = "qcom,geni-spi";
+				reg = <0 0x00a8c000 0 0x4000>;
+				clocks = <&gcc GCC_QUPV3_WRAP1_S3_CLK>;
+				clock-names = "se";
+				interrupts = <GIC_SPI 356 IRQ_TYPE_LEVEL_HIGH>;
+				interconnects = <&qup_virt MASTER_QUP_CORE_1 0 &qup_virt SLAVE_QUP_CORE_1 0>,
+						<&gem_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_QUP_1 0>;
+				interconnect-names = "qup-core", "qup-config";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			uart11: serial@a8c000 {
+				compatible = "qcom,geni-uart";
+				reg = <0 0x00a8c000 0 0x4000>;
+				clocks = <&gcc GCC_QUPV3_WRAP1_S3_CLK>;
+				clock-names = "se";
+				interrupts = <GIC_SPI 356 IRQ_TYPE_LEVEL_HIGH>;
+				interconnects = <&qup_virt MASTER_QUP_CORE_1 0 &qup_virt SLAVE_QUP_CORE_1 0>,
+						<&gem_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_QUP_1 0>;
+				interconnect-names = "qup-core", "qup-config";
+				status = "disabled";
+			};
+
+			i2c12: i2c@a90000 {
+				compatible = "qcom,geni-i2c";
+				reg = <0 0x00a90000 0 0x4000>;
+				clocks = <&gcc GCC_QUPV3_WRAP1_S4_CLK>;
+				clock-names = "se";
+				interrupts = <GIC_SPI 357 IRQ_TYPE_LEVEL_HIGH>;
+				interconnects = <&qup_virt MASTER_QUP_CORE_1 0 &qup_virt SLAVE_QUP_CORE_1 0>,
+						<&gem_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_QUP_1 0>,
+						<&aggre2_noc MASTER_QUP_1 0 &mc_virt SLAVE_EBI_CH0 0>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			spi12: spi@a90000 {
+				compatible = "qcom,geni-spi";
+				reg = <0 0x00a90000 0 0x4000>;
+				clocks = <&gcc GCC_QUPV3_WRAP1_S4_CLK>;
+				clock-names = "se";
+				interrupts = <GIC_SPI 357 IRQ_TYPE_LEVEL_HIGH>;
+				interconnects = <&qup_virt MASTER_QUP_CORE_1 0 &qup_virt SLAVE_QUP_CORE_1 0>,
+						<&gem_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_QUP_1 0>;
+				interconnect-names = "qup-core", "qup-config";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			uart12: serial@a90000 {
+				compatible = "qcom,geni-uart";
+				reg = <0 0x00a90000 0 0x4000>;
+				clocks = <&gcc GCC_QUPV3_WRAP1_S4_CLK>;
+				clock-names = "se";
+				interrupts = <GIC_SPI 357 IRQ_TYPE_LEVEL_HIGH>;
+				interconnects = <&qup_virt MASTER_QUP_CORE_1 0 &qup_virt SLAVE_QUP_CORE_1 0>,
+						<&gem_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_QUP_1 0>;
+				interconnect-names = "qup-core", "qup-config";
+				status = "disabled";
+			};
+
+			i2c16: i2c@a94000 {
+				compatible = "qcom,geni-i2c";
+				reg = <0 0x00a94000 0 0x4000>;
+				clocks = <&gcc GCC_QUPV3_WRAP1_S5_CLK>;
+				clock-names = "se";
+				interrupts = <GIC_SPI 358 IRQ_TYPE_LEVEL_HIGH>;
+				interconnects = <&qup_virt MASTER_QUP_CORE_1 0 &qup_virt SLAVE_QUP_CORE_1 0>,
+						<&gem_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_QUP_1 0>,
+						<&aggre2_noc MASTER_QUP_1 0 &mc_virt SLAVE_EBI_CH0 0>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			spi16: spi@a94000 {
+				compatible = "qcom,geni-spi";
+				reg = <0 0x00a94000 0 0x4000>;
+				clocks = <&gcc GCC_QUPV3_WRAP1_S5_CLK>;
+				clock-names = "se";
+				interrupts = <GIC_SPI 358 IRQ_TYPE_LEVEL_HIGH>;
+				interconnects = <&qup_virt MASTER_QUP_CORE_1 0 &qup_virt SLAVE_QUP_CORE_1 0>,
+						<&gem_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_QUP_1 0>;
+				interconnect-names = "qup-core", "qup-config";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			uart16: serial@a94000 {
+				compatible = "qcom,geni-uart";
+				reg = <0 0x00a94000 0 0x4000>;
+				clocks = <&gcc GCC_QUPV3_WRAP1_S5_CLK>;
+				clock-names = "se";
+				interrupts = <GIC_SPI 358 IRQ_TYPE_LEVEL_HIGH>;
+				interconnects = <&qup_virt MASTER_QUP_CORE_1 0 &qup_virt SLAVE_QUP_CORE_1 0>,
+						<&gem_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_QUP_1 0>;
+				interconnect-names = "qup-core", "qup-config";
+				status = "disabled";
+			};
+		};
+
+		qupv3_id_2: geniqup@cc0000 {
+			compatible = "qcom,geni-se-qup";
+			reg = <0x0 0x00cc0000 0x0 0x6000>;
+			clocks = <&gcc GCC_QUPV3_WRAP_2_M_AHB_CLK>,
+				 <&gcc GCC_QUPV3_WRAP_2_S_AHB_CLK>;
+			clock-names = "m-ahb", "s-ahb";
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+			iommus = <&apps_smmu 0x7a3 0>;
+			status = "disabled";
+
+			i2c17: i2c@c80000 {
+				compatible = "qcom,geni-i2c";
+				reg = <0 0x00c80000 0 0x4000>;
+				clocks = <&gcc GCC_QUPV3_WRAP2_S0_CLK>;
+				clock-names = "se";
+				interrupts = <GIC_SPI 373 IRQ_TYPE_LEVEL_HIGH>;
+				interconnects = <&qup_virt MASTER_QUP_CORE_2 0 &qup_virt SLAVE_QUP_CORE_2 0>,
+						<&gem_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_QUP_2 0>,
+						<&aggre2_noc MASTER_QUP_2 0 &mc_virt SLAVE_EBI_CH0 0>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			spi17: spi@c80000 {
+				compatible = "qcom,geni-spi";
+				reg = <0 0x00c80000 0 0x4000>;
+				clocks = <&gcc GCC_QUPV3_WRAP2_S0_CLK>;
+				clock-names = "se";
+				interrupts = <GIC_SPI 373 IRQ_TYPE_LEVEL_HIGH>;
+				interconnects = <&qup_virt MASTER_QUP_CORE_2 0 &qup_virt SLAVE_QUP_CORE_2 0>,
+						<&gem_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_QUP_2 0>;
+				interconnect-names = "qup-core", "qup-config";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			uart17: serial@c80000 {
+				compatible = "qcom,geni-uart";
+				reg = <0 0x00c80000 0 0x4000>;
+				clocks = <&gcc GCC_QUPV3_WRAP2_S0_CLK>;
+				clock-names = "se";
+				interrupts = <GIC_SPI 373 IRQ_TYPE_LEVEL_HIGH>;
+				interconnects = <&qup_virt MASTER_QUP_CORE_2 0 &qup_virt SLAVE_QUP_CORE_2 0>,
+						<&gem_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_QUP_2 0>;
+				interconnect-names = "qup-core", "qup-config";
+				status = "disabled";
+			};
+
+			i2c18: i2c@c84000 {
+				compatible = "qcom,geni-i2c";
+				reg = <0 0x00c84000 0 0x4000>;
+				clocks = <&gcc GCC_QUPV3_WRAP2_S1_CLK>;
+				clock-names = "se";
+				interrupts = <GIC_SPI 583 IRQ_TYPE_LEVEL_HIGH>;
+				interconnects = <&qup_virt MASTER_QUP_CORE_2 0 &qup_virt SLAVE_QUP_CORE_2 0>,
+						<&gem_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_QUP_2 0>,
+						<&aggre2_noc MASTER_QUP_2 0 &mc_virt SLAVE_EBI_CH0 0>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			spi18: spi@c84000 {
+				compatible = "qcom,geni-spi";
+				reg = <0 0x00c84000 0 0x4000>;
+				clocks = <&gcc GCC_QUPV3_WRAP2_S1_CLK>;
+				clock-names = "se";
+				interrupts = <GIC_SPI 583 IRQ_TYPE_LEVEL_HIGH>;
+				interconnects = <&qup_virt MASTER_QUP_CORE_2 0 &qup_virt SLAVE_QUP_CORE_2 0>,
+						<&gem_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_QUP_2 0>;
+				interconnect-names = "qup-core", "qup-config";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			uart18: serial@c84000 {
+				compatible = "qcom,geni-uart";
+				reg = <0 0x00c84000 0 0x4000>;
+				clocks = <&gcc GCC_QUPV3_WRAP2_S1_CLK>;
+				clock-names = "se";
+				interrupts = <GIC_SPI 583 IRQ_TYPE_LEVEL_HIGH>;
+				interconnects = <&qup_virt MASTER_QUP_CORE_2 0 &qup_virt SLAVE_QUP_CORE_2 0>,
+						<&gem_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_QUP_2 0>;
+				interconnect-names = "qup-core", "qup-config";
+				status = "disabled";
+			};
+
+			i2c19: i2c@c88000 {
+				compatible = "qcom,geni-i2c";
+				reg = <0 0x00c88000 0 0x4000>;
+				clocks = <&gcc GCC_QUPV3_WRAP2_S2_CLK>;
+				clock-names = "se";
+				interrupts = <GIC_SPI 584 IRQ_TYPE_LEVEL_HIGH>;
+				interconnects = <&qup_virt MASTER_QUP_CORE_2 0 &qup_virt SLAVE_QUP_CORE_2 0>,
+						<&gem_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_QUP_2 0>,
+						<&aggre2_noc MASTER_QUP_2 0 &mc_virt SLAVE_EBI_CH0 0>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			spi19: spi@c88000 {
+				compatible = "qcom,geni-spi";
+				reg = <0 0x00c88000 0 0x4000>;
+				clocks = <&gcc GCC_QUPV3_WRAP2_S2_CLK>;
+				clock-names = "se";
+				interrupts = <GIC_SPI 584 IRQ_TYPE_LEVEL_HIGH>;
+				interconnects = <&qup_virt MASTER_QUP_CORE_2 0 &qup_virt SLAVE_QUP_CORE_2 0>,
+						<&gem_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_QUP_2 0>;
+				interconnect-names = "qup-core", "qup-config";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			uart19: serial@c88000 {
+				compatible = "qcom,geni-uart";
+				reg = <0 0x00c88000 0 0x4000>;
+				clocks = <&gcc GCC_QUPV3_WRAP2_S2_CLK>;
+				clock-names = "se";
+				interrupts = <GIC_SPI 584 IRQ_TYPE_LEVEL_HIGH>;
+				interconnects = <&qup_virt MASTER_QUP_CORE_2 0 &qup_virt SLAVE_QUP_CORE_2 0>,
+						<&gem_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_QUP_2 0>;
+				interconnect-names = "qup-core", "qup-config";
+				status = "disabled";
+			};
+
+			i2c13: i2c@c8c000 {
+				compatible = "qcom,geni-i2c";
+				reg = <0 0x00c8c000 0 0x4000>;
+				clocks = <&gcc GCC_QUPV3_WRAP2_S3_CLK>;
+				clock-names = "se";
+				interrupts = <GIC_SPI 585 IRQ_TYPE_LEVEL_HIGH>;
+				interconnects = <&qup_virt MASTER_QUP_CORE_2 0 &qup_virt SLAVE_QUP_CORE_2 0>,
+						<&gem_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_QUP_2 0>,
+						<&aggre2_noc MASTER_QUP_2 0 &mc_virt SLAVE_EBI_CH0 0>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			spi13: spi@c8c000 {
+				compatible = "qcom,geni-spi";
+				reg = <0 0x00c8c000 0 0x4000>;
+				clocks = <&gcc GCC_QUPV3_WRAP2_S3_CLK>;
+				clock-names = "se";
+				interrupts = <GIC_SPI 585 IRQ_TYPE_LEVEL_HIGH>;
+				interconnects = <&qup_virt MASTER_QUP_CORE_2 0 &qup_virt SLAVE_QUP_CORE_2 0>,
+						<&gem_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_QUP_2 0>;
+				interconnect-names = "qup-core", "qup-config";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			uart13: serial@c8c000 {
+				compatible = "qcom,geni-uart";
+				reg = <0 0x00c8c000 0 0x4000>;
+				clocks = <&gcc GCC_QUPV3_WRAP2_S3_CLK>;
+				clock-names = "se";
+				interrupts = <GIC_SPI 585 IRQ_TYPE_LEVEL_HIGH>;
+				interconnects = <&qup_virt MASTER_QUP_CORE_2 0 &qup_virt SLAVE_QUP_CORE_2 0>,
+						<&gem_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_QUP_2 0>;
+				interconnect-names = "qup-core", "qup-config";
+				status = "disabled";
+			};
+
+			i2c14: i2c@c90000 {
+				compatible = "qcom,geni-i2c";
+				reg = <0 0x00c90000 0 0x4000>;
+				clocks = <&gcc GCC_QUPV3_WRAP2_S4_CLK>;
+				clock-names = "se";
+				interrupts = <GIC_SPI 586 IRQ_TYPE_LEVEL_HIGH>;
+				interconnects = <&qup_virt MASTER_QUP_CORE_2 0 &qup_virt SLAVE_QUP_CORE_2 0>,
+						<&gem_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_QUP_2 0>,
+						<&aggre2_noc MASTER_QUP_2 0 &mc_virt SLAVE_EBI_CH0 0>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			spi14: spi@c90000 {
+				compatible = "qcom,geni-spi";
+				reg = <0 0x00c90000 0 0x4000>;
+				clocks = <&gcc GCC_QUPV3_WRAP2_S4_CLK>;
+				clock-names = "se";
+				interrupts = <GIC_SPI 586 IRQ_TYPE_LEVEL_HIGH>;
+				interconnects = <&qup_virt MASTER_QUP_CORE_2 0 &qup_virt SLAVE_QUP_CORE_2 0>,
+						<&gem_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_QUP_2 0>;
+				interconnect-names = "qup-core", "qup-config";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			uart14: serial@c90000 {
+				compatible = "qcom,geni-uart";
+				reg = <0 0x00c90000 0 0x4000>;
+				clocks = <&gcc GCC_QUPV3_WRAP2_S4_CLK>;
+				clock-names = "se";
+				interrupts = <GIC_SPI 586 IRQ_TYPE_LEVEL_HIGH>;
+				interconnects = <&qup_virt MASTER_QUP_CORE_2 0 &qup_virt SLAVE_QUP_CORE_2 0>,
+						<&gem_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_QUP_2 0>;
+				interconnect-names = "qup-core", "qup-config";
+				status = "disabled";
+			};
+
+			i2c15: i2c@c94000 {
+				compatible = "qcom,geni-i2c";
+				reg = <0 0x00c94000 0 0x4000>;
+				clocks = <&gcc GCC_QUPV3_WRAP2_S5_CLK>;
+				clock-names = "se";
+				interrupts = <GIC_SPI 587 IRQ_TYPE_LEVEL_HIGH>;
+				interconnects = <&qup_virt MASTER_QUP_CORE_2 0 &qup_virt SLAVE_QUP_CORE_2 0>,
+						<&gem_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_QUP_2 0>,
+						<&aggre2_noc MASTER_QUP_2 0 &mc_virt SLAVE_EBI_CH0 0>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			spi15: spi@c94000 {
+				compatible = "qcom,geni-spi";
+				reg = <0 0x00c94000 0 0x4000>;
+				clocks = <&gcc GCC_QUPV3_WRAP2_S5_CLK>;
+				clock-names = "se";
+				interrupts = <GIC_SPI 587 IRQ_TYPE_LEVEL_HIGH>;
+				interconnects = <&qup_virt MASTER_QUP_CORE_2 0 &qup_virt SLAVE_QUP_CORE_2 0>,
+						<&gem_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_QUP_2 0>;
+				interconnect-names = "qup-core", "qup-config";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			uart15: serial@c94000 {
+				compatible = "qcom,geni-uart";
+				reg = <0 0x00c94000 0 0x4000>;
+				clocks = <&gcc GCC_QUPV3_WRAP2_S5_CLK>;
+				clock-names = "se";
+				interrupts = <GIC_SPI 587 IRQ_TYPE_LEVEL_HIGH>;
+				interconnects = <&qup_virt MASTER_QUP_CORE_2 0 &qup_virt SLAVE_QUP_CORE_2 0>,
+						<&gem_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_QUP_2 0>;
+				interconnect-names = "qup-core", "qup-config";
+				status = "disabled";
+			};
+		};
+
 		config_noc: interconnect@1500000 {
 			compatible = "qcom,sc8180x-config-noc";
 			reg = <0 0x01500000 0 0x7400>;
-- 
2.40.1

