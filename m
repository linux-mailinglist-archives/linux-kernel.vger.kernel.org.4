Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A983D6C8D77
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 12:29:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232019AbjCYL3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 07:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231949AbjCYL31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 07:29:27 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDB5212CDE;
        Sat, 25 Mar 2023 04:29:05 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id g17so5401654lfv.4;
        Sat, 25 Mar 2023 04:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679743744;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pqojHmxDqpx2GPiUKbXqxXhw5zwdp35Yf/FdDi53lVM=;
        b=E+qLd6D3IBWrXNJWdvXpCGGyn2FHMUBfdfUpO4DErx3Bv2X/O7uxbGNP69xmAPfV43
         tIeOelKglRpACbCd4XRF9Q+aemcNPy6th/FALBoFg5QPcKs6sLD9EZLOwyjJ5hYrVXLk
         T83Ikz3GZbIGC9EwmtJijR9Gt3kh+0ubUtENrRP3zjKjqduqwscmvhkIQr+2XaSnIlRK
         nPhs0/HHZqEkN5r8YCv4UVgOs8S2or9TtyPXqqcfEI/gpsqRufKIujpgrar24rx/zEqx
         hGMUA6CCzlp7OOwUlNmoNTreK+g9nRaxdMPDJWO+tGF7+fjCov4VjtjCWEgPzbeKtcRN
         Gk7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679743744;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pqojHmxDqpx2GPiUKbXqxXhw5zwdp35Yf/FdDi53lVM=;
        b=mRNyTpBkGUKDUqMjlffIW9IJbQ8IiiBQBFJl6Y0vqW1EHKJ10GmDpvJIV4z6axNW8P
         zTUyKjmnfIPC2yLlThFal30iFu/KZg3PMoXEI9V2GAMLBh37bVJ77FRlzikeE5blJ1Le
         frTtJ9giymTM0OXS2+ieuKE/uejg80jQh2RbXSqL/W+o6ygceQuzYP9LRbMdwYDRyZRo
         4Y6jvoZX+dBiIT08NCAmdE0t18eiq7LSbHdlfQuRCJUeUnMmKwT4vS8Si0m1ufU+2x9u
         fe0NCWxRTd0uQQZE2EbtdD4fg/dlAcJ5N03IUepZR1VezJeQQRwjhCcs2bTW3OJR5gAM
         BmgQ==
X-Gm-Message-State: AAQBX9eIkRCEPOv9fBiW+8ARJizL3spQRflcFZjxJXshQQnjs9+X3Eb2
        9zZ+HJzlCP5GrDvd6RTQVqZ9wEhc9KLrfg==
X-Google-Smtp-Source: AKy350ZJiFNHgeszcLJLtls1SDbcilB7bjdmB7/DtYOR+nav6cvhspC+75BvWRo5KUY50AHGBjfyeA==
X-Received: by 2002:a19:5208:0:b0:4eb:680:3920 with SMTP id m8-20020a195208000000b004eb06803920mr1392204lfb.40.1679743744158;
        Sat, 25 Mar 2023 04:29:04 -0700 (PDT)
Received: from localhost.localdomain (cdb25.neoplus.adsl.tpnet.pl. [83.30.151.25])
        by smtp.gmail.com with ESMTPSA id m30-20020ac24ade000000b004eaf55936eesm1502510lfp.233.2023.03.25.04.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Mar 2023 04:29:03 -0700 (PDT)
From:   Adam Skladowski <a39.skl@gmail.com>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Adam Skladowski <a39.skl@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] arm64: dts: msm8953: Pad regs to 8 digits
Date:   Sat, 25 Mar 2023 12:28:52 +0100
Message-Id: <20230325112852.18841-4-a39.skl@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230325112852.18841-1-a39.skl@gmail.com>
References: <20230325112852.18841-1-a39.skl@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Follow other dtses and pad regs to 8 digits.

Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
---
 arch/arm64/boot/dts/qcom/msm8953.dtsi | 98 +++++++++++++--------------
 1 file changed, 49 insertions(+), 49 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8953.dtsi b/arch/arm64/boot/dts/qcom/msm8953.dtsi
index 0a1bf1058cbf..684668170353 100644
--- a/arch/arm64/boot/dts/qcom/msm8953.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8953.dtsi
@@ -350,12 +350,12 @@ soc: soc@0 {
 
 		rpm_msg_ram: sram@60000 {
 			compatible = "qcom,rpm-msg-ram";
-			reg = <0x60000 0x8000>;
+			reg = <0x00060000 0x8000>;
 		};
 
 		hsusb_phy: phy@79000 {
 			compatible = "qcom,msm8953-qusb2-phy";
-			reg = <0x79000 0x180>;
+			reg = <0x00079000 0x180>;
 			#phy-cells = <0>;
 
 			clocks = <&gcc GCC_USB_PHY_CFG_AHB_CLK>,
@@ -378,8 +378,8 @@ rng@e3000 {
 
 		tsens0: thermal-sensor@4a9000 {
 			compatible = "qcom,msm8953-tsens", "qcom,tsens-v2";
-			reg = <0x4a9000 0x1000>, /* TM */
-			      <0x4a8000 0x1000>; /* SROT */
+			reg = <0x004a9000 0x1000>, /* TM */
+			      <0x004a8000 0x1000>; /* SROT */
 			#qcom,sensors = <16>;
 			interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 314 IRQ_TYPE_LEVEL_HIGH>;
@@ -389,12 +389,12 @@ tsens0: thermal-sensor@4a9000 {
 
 		restart@4ab000 {
 			compatible = "qcom,pshold";
-			reg = <0x4ab000 0x4>;
+			reg = <0x004ab000 0x4>;
 		};
 
 		tlmm: pinctrl@1000000 {
 			compatible = "qcom,msm8953-pinctrl";
-			reg = <0x1000000 0x300000>;
+			reg = <0x01000000 0x300000>;
 			interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
 			gpio-controller;
 			gpio-ranges = <&tlmm 0 0 142>;
@@ -634,7 +634,7 @@ i2c_8_sleep: i2c-8-sleep-state {
 
 		gcc: clock-controller@1800000 {
 			compatible = "qcom,gcc-msm8953";
-			reg = <0x1800000 0x80000>;
+			reg = <0x01800000 0x80000>;
 			#clock-cells = <1>;
 			#reset-cells = <1>;
 			#power-domain-cells = <1>;
@@ -654,25 +654,25 @@ gcc: clock-controller@1800000 {
 
 		tcsr_mutex: hwlock@1905000 {
 			compatible = "qcom,tcsr-mutex";
-			reg = <0x1905000 0x20000>;
+			reg = <0x01905000 0x20000>;
 			#hwlock-cells = <1>;
 		};
 
 		tcsr: syscon@1937000 {
 			compatible = "qcom,tcsr-msm8953", "syscon";
-			reg = <0x1937000 0x30000>;
+			reg = <0x01937000 0x30000>;
 		};
 
 		tcsr_phy_clk_scheme_sel: syscon@193f044 {
 			compatible = "qcom,tcsr-msm8953", "syscon";
-			reg = <0x193f044 0x4>;
+			reg = <0x0193f044 0x4>;
 		};
 
 		mdss: display-subsystem@1a00000 {
 			compatible = "qcom,mdss";
 
-			reg = <0x1a00000 0x1000>,
-			      <0x1ab0000 0x1040>;
+			reg = <0x01a00000 0x1000>,
+			      <0x01ab0000 0x1040>;
 			reg-names = "mdss_phys",
 				    "vbif_phys";
 
@@ -699,7 +699,7 @@ mdss: display-subsystem@1a00000 {
 
 			mdp: display-controller@1a01000 {
 				compatible = "qcom,msm8953-mdp5", "qcom,mdp5";
-				reg = <0x1a01000 0x89000>;
+				reg = <0x01a01000 0x89000>;
 				reg-names = "mdp_phys";
 
 				interrupt-parent = <&mdss>;
@@ -740,7 +740,7 @@ mdp5_intf2_out: endpoint {
 
 			dsi0: dsi@1a94000 {
 				compatible = "qcom,msm8953-dsi-ctrl", "qcom,mdss-dsi-ctrl";
-				reg = <0x1a94000 0x400>;
+				reg = <0x01a94000 0x400>;
 				reg-names = "dsi_ctrl";
 
 				interrupt-parent = <&mdss>;
@@ -792,9 +792,9 @@ dsi0_out: endpoint {
 
 			dsi0_phy: phy@1a94400 {
 				compatible = "qcom,dsi-phy-14nm-8953";
-				reg = <0x1a94400 0x100>,
-				      <0x1a94500 0x300>,
-				      <0x1a94800 0x188>;
+				reg = <0x01a94400 0x100>,
+				      <0x01a94500 0x300>,
+				      <0x01a94800 0x188>;
 				reg-names = "dsi_phy",
 					    "dsi_phy_lane",
 					    "dsi_pll";
@@ -810,7 +810,7 @@ dsi0_phy: phy@1a94400 {
 
 			dsi1: dsi@1a96000 {
 				compatible = "qcom,msm8953-dsi-ctrl", "qcom,mdss-dsi-ctrl";
-				reg = <0x1a96000 0x400>;
+				reg = <0x01a96000 0x400>;
 				reg-names = "dsi_ctrl";
 
 				interrupt-parent = <&mdss>;
@@ -859,9 +859,9 @@ dsi1_out: endpoint {
 
 			dsi1_phy: phy@1a96400 {
 				compatible = "qcom,dsi-phy-14nm-8953";
-				reg = <0x1a96400 0x100>,
-				      <0x1a96500 0x300>,
-				      <0x1a96800 0x188>;
+				reg = <0x01a96400 0x100>,
+				      <0x01a96500 0x300>,
+				      <0x01a96800 0x188>;
 				reg-names = "dsi_phy",
 					    "dsi_phy_lane",
 					    "dsi_pll";
@@ -878,7 +878,7 @@ dsi1_phy: phy@1a96400 {
 
 		apps_iommu: iommu@1e00000 {
 			compatible = "qcom,msm8953-iommu", "qcom,msm-iommu-v1";
-			ranges  = <0 0x1e20000 0x20000>;
+			ranges  = <0 0x01e20000 0x20000>;
 
 			clocks = <&gcc GCC_SMMU_CFG_CLK>,
 				 <&gcc GCC_APSS_TCU_ASYNC_CLK>;
@@ -914,11 +914,11 @@ iommu-ctx@16000 {
 
 		spmi_bus: spmi@200f000 {
 			compatible = "qcom,spmi-pmic-arb";
-			reg = <0x200f000 0x1000>,
-			      <0x2400000 0x800000>,
-			      <0x2c00000 0x800000>,
-			      <0x3800000 0x200000>,
-			      <0x200a000 0x2100>;
+			reg = <0x0200f000 0x1000>,
+			      <0x02400000 0x800000>,
+			      <0x02c00000 0x800000>,
+			      <0x03800000 0x200000>,
+			      <0x0200a000 0x2100>;
 			reg-names = "core", "chnls", "obsrvr", "intr", "cnfg";
 			interrupt-names = "periph_irq";
 			interrupts = <GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>;
@@ -933,7 +933,7 @@ spmi_bus: spmi@200f000 {
 
 		usb3: usb@70f8800 {
 			compatible = "qcom,msm8953-dwc3", "qcom,dwc3";
-			reg = <0x70f8800 0x400>;
+			reg = <0x070f8800 0x400>;
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges;
@@ -983,7 +983,7 @@ usb3_dwc3: usb@7000000 {
 		sdhc_1: mmc@7824900 {
 			compatible = "qcom,msm8953-sdhci", "qcom,sdhci-msm-v4";
 
-			reg = <0x7824900 0x500>, <0x7824000 0x800>;
+			reg = <0x07824900 0x500>, <0x07824000 0x800>;
 			reg-names = "hc", "core";
 
 			interrupts = <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
@@ -1043,7 +1043,7 @@ opp-384000000 {
 		sdhc_2: mmc@7864900 {
 			compatible = "qcom,msm8953-sdhci", "qcom,sdhci-msm-v4";
 
-			reg = <0x7864900 0x500>, <0x7864000 0x800>;
+			reg = <0x07864900 0x500>, <0x07864000 0x800>;
 			reg-names = "hc", "core";
 
 			interrupts = <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>,
@@ -1098,7 +1098,7 @@ opp-200000000 {
 
 		uart_0: serial@78af000 {
 			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
-			reg = <0x78af000 0x200>;
+			reg = <0x078af000 0x200>;
 			interrupts = <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&gcc GCC_BLSP1_UART1_APPS_CLK>,
 				 <&gcc GCC_BLSP1_AHB_CLK>;
@@ -1109,7 +1109,7 @@ uart_0: serial@78af000 {
 
 		i2c_1: i2c@78b5000 {
 			compatible = "qcom,i2c-qup-v2.2.1";
-			reg = <0x78b5000 0x600>;
+			reg = <0x078b5000 0x600>;
 			interrupts = <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>;
 			clock-names = "core", "iface";
 			clocks = <&gcc GCC_BLSP1_QUP1_I2C_APPS_CLK>,
@@ -1127,7 +1127,7 @@ i2c_1: i2c@78b5000 {
 
 		i2c_2: i2c@78b6000 {
 			compatible = "qcom,i2c-qup-v2.2.1";
-			reg = <0x78b6000 0x600>;
+			reg = <0x078b6000 0x600>;
 			interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
 			clock-names = "core", "iface";
 			clocks = <&gcc GCC_BLSP1_QUP2_I2C_APPS_CLK>,
@@ -1145,7 +1145,7 @@ i2c_2: i2c@78b6000 {
 
 		i2c_3: i2c@78b7000 {
 			compatible = "qcom,i2c-qup-v2.2.1";
-			reg = <0x78b7000 0x600>;
+			reg = <0x078b7000 0x600>;
 			interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
 			clock-names = "core", "iface";
 			clocks = <&gcc GCC_BLSP1_QUP3_I2C_APPS_CLK>,
@@ -1162,7 +1162,7 @@ i2c_3: i2c@78b7000 {
 
 		i2c_4: i2c@78b8000 {
 			compatible = "qcom,i2c-qup-v2.2.1";
-			reg = <0x78b8000 0x600>;
+			reg = <0x078b8000 0x600>;
 			interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
 			clock-names = "core", "iface";
 			clocks = <&gcc GCC_BLSP1_QUP4_I2C_APPS_CLK>,
@@ -1179,7 +1179,7 @@ i2c_4: i2c@78b8000 {
 
 		i2c_5: i2c@7af5000 {
 			compatible = "qcom,i2c-qup-v2.2.1";
-			reg = <0x7af5000 0x600>;
+			reg = <0x07af5000 0x600>;
 			interrupts = <GIC_SPI 299 IRQ_TYPE_LEVEL_HIGH>;
 			clock-names = "core", "iface";
 			clocks = <&gcc GCC_BLSP2_QUP1_I2C_APPS_CLK>,
@@ -1196,7 +1196,7 @@ i2c_5: i2c@7af5000 {
 
 		i2c_6: i2c@7af6000 {
 			compatible = "qcom,i2c-qup-v2.2.1";
-			reg = <0x7af6000 0x600>;
+			reg = <0x07af6000 0x600>;
 			interrupts = <GIC_SPI 300 IRQ_TYPE_LEVEL_HIGH>;
 			clock-names = "core", "iface";
 			clocks = <&gcc GCC_BLSP2_QUP2_I2C_APPS_CLK>,
@@ -1213,7 +1213,7 @@ i2c_6: i2c@7af6000 {
 
 		i2c_7: i2c@7af7000 {
 			compatible = "qcom,i2c-qup-v2.2.1";
-			reg = <0x7af7000 0x600>;
+			reg = <0x07af7000 0x600>;
 			interrupts = <GIC_SPI 301 IRQ_TYPE_LEVEL_HIGH>;
 			clock-names = "core", "iface";
 			clocks = <&gcc GCC_BLSP2_QUP3_I2C_APPS_CLK>,
@@ -1230,7 +1230,7 @@ i2c_7: i2c@7af7000 {
 
 		i2c_8: i2c@7af8000 {
 			compatible = "qcom,i2c-qup-v2.2.1";
-			reg = <0x7af8000 0x600>;
+			reg = <0x07af8000 0x600>;
 			interrupts = <GIC_SPI 302 IRQ_TYPE_LEVEL_HIGH>;
 			clock-names = "core", "iface";
 			clocks = <&gcc GCC_BLSP2_QUP4_I2C_APPS_CLK>,
@@ -1254,13 +1254,13 @@ intc: interrupt-controller@b000000 {
 
 		apcs: mailbox@b011000 {
 			compatible = "qcom,msm8953-apcs-kpss-global", "syscon";
-			reg = <0xb011000 0x1000>;
+			reg = <0x0b011000 0x1000>;
 			#mbox-cells = <1>;
 		};
 
 		timer@b120000 {
 			compatible = "arm,armv7-timer-mem";
-			reg = <0xb120000 0x1000>;
+			reg = <0x0b120000 0x1000>;
 			#address-cells = <0x01>;
 			#size-cells = <0x01>;
 			ranges;
@@ -1269,49 +1269,49 @@ frame@b121000 {
 				frame-number = <0>;
 				interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
 					     <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0xb121000 0x1000>,
-				      <0xb122000 0x1000>;
+				reg = <0x0b121000 0x1000>,
+				      <0x0b122000 0x1000>;
 			};
 
 			frame@b123000 {
 				frame-number = <1>;
 				interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0xb123000 0x1000>;
+				reg = <0x0b123000 0x1000>;
 				status = "disabled";
 			};
 
 			frame@b124000 {
 				frame-number = <2>;
 				interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0xb124000 0x1000>;
+				reg = <0x0b124000 0x1000>;
 				status = "disabled";
 			};
 
 			frame@b125000 {
 				frame-number = <3>;
 				interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0xb125000 0x1000>;
+				reg = <0x0b125000 0x1000>;
 				status = "disabled";
 			};
 
 			frame@b126000 {
 				frame-number = <4>;
 				interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0xb126000 0x1000>;
+				reg = <0x0b126000 0x1000>;
 				status = "disabled";
 			};
 
 			frame@b127000 {
 				frame-number = <5>;
 				interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0xb127000 0x1000>;
+				reg = <0x0b127000 0x1000>;
 				status = "disabled";
 			};
 
 			frame@b128000 {
 				frame-number = <6>;
 				interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0xb128000 0x1000>;
+				reg = <0x0b128000 0x1000>;
 				status = "disabled";
 			};
 		};
-- 
2.25.1

