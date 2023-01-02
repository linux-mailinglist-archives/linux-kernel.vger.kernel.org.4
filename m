Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99D0365AEE2
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 10:47:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232183AbjABJrR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 04:47:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232406AbjABJqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 04:46:55 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5899960C5
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 01:46:51 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id p36so40900959lfa.12
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jan 2023 01:46:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oOa/DhlWEEop0wDZoQQBXu4xCCDVxctL8eoPnJiX5DM=;
        b=jxt+aRT4Hz5Cz7lOzWEro8mp12GKDiB06g5dtf4gFErie6oKDLH1InKGz3AvtBFL3V
         G2A1rd6zVtZyQwaUrdd1qRWld5JMGW308+VhX8s6XmsV7X0xJMS6o0xLma3G9SHDFrh+
         vS+BhUgLgmRQbGbW9kFOSfSBeyXj020mwa7NSIAVsRhagb3sw4dFH0UEtWmIgRfTC/PW
         c8VD0ZjCgR5Vcxrl3Pd+3lWRVxMHXe0Doi6DK0VXmbZAQ1HuWuUWWUkOIAgSbMeurFaZ
         4cUwMhADYrqKqFJV9rfecjTprHn1aZ26H6f6BPtwOmUb7R3zN6nEFudOJTOLm4KENzZ2
         Re4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oOa/DhlWEEop0wDZoQQBXu4xCCDVxctL8eoPnJiX5DM=;
        b=EdGpd7O2MMXd8Ezal/WlA4nyWC2YgVFjLMkcMeBEzZfYb+Hjv2tD/GFcEIpJ4i+8Gn
         vAe6+M8e8nOqe63NoEOTKtWZULXul/G3LZLqzKiQjzUOgS4HCT1iFeA/75POL3Fy1xFa
         xa/5252oQ/1GwB5jFdMI87Yj/RtSctV3f8f/gjgVptirEkQeS9q8exvDM26sA75v/z8I
         +GPlwX458mtuhkpRjK879DszcH05YOIqdV7o0CW01aaJsFLSLTkcANOHOy4Dnne53oXT
         prVXr7iX1Qqysn7hS6QO1HqeYv3FL+H0dLc6YD2cvMULbIxT+oNHZMZ/xG4Ses3/ky6o
         oV1w==
X-Gm-Message-State: AFqh2kpoocwUsRZOl3WF5GG3CvfAaiRdgEpWJcHFkFYzrcRf+KjclbfE
        +Ptw7VzkuPh+Ac4Sdo01L6WQIw==
X-Google-Smtp-Source: AMrXdXs7sjuPlXRZ8GFpLox6S7OzWzETTvIJR1DX+v8mkr5d/O+76MvvIJNoc1pUTuz9s3RNZGkPmA==
X-Received: by 2002:a05:6512:2822:b0:4a4:68b9:60ae with SMTP id cf34-20020a056512282200b004a468b960aemr13323206lfb.57.1672652809658;
        Mon, 02 Jan 2023 01:46:49 -0800 (PST)
Received: from localhost.localdomain (abxi45.neoplus.adsl.tpnet.pl. [83.9.2.45])
        by smtp.gmail.com with ESMTPSA id x11-20020a0565123f8b00b004b5adb59ed5sm4382143lfa.297.2023.01.02.01.46.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jan 2023 01:46:49 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 03/17] arm64: dts: qcom: ipq6018: Sort nodes properly
Date:   Mon,  2 Jan 2023 10:46:28 +0100
Message-Id: <20230102094642.74254-4-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230102094642.74254-1-konrad.dybcio@linaro.org>
References: <20230102094642.74254-1-konrad.dybcio@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Order nodes by unit address if one exists and alphabetically otherwise.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
v1 -> v2:
No changes

 arch/arm64/boot/dts/qcom/ipq6018.dtsi | 562 +++++++++++++-------------
 1 file changed, 281 insertions(+), 281 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq6018.dtsi b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
index d1c02efc2ea9..8937b10748f3 100644
--- a/arch/arm64/boot/dts/qcom/ipq6018.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
@@ -87,6 +87,12 @@ L2_0: l2-cache {
 		};
 	};
 
+	firmware {
+		scm {
+			compatible = "qcom,scm-ipq6018", "qcom,scm";
+		};
+	};
+
 	cpu_opp_table: opp-table-cpu {
 		compatible = "operating-points-v2";
 		opp-shared;
@@ -123,12 +129,6 @@ opp-1800000000 {
 		};
 	};
 
-	firmware {
-		scm {
-			compatible = "qcom,scm-ipq6018", "qcom,scm";
-		};
-	};
-
 	pmuv8: pmu {
 		compatible = "arm,cortex-a53-pmu";
 		interrupts = <GIC_PPI 7 (GIC_CPU_MASK_SIMPLE(4) |
@@ -166,6 +166,28 @@ q6_region: memory@4ab00000 {
 		};
 	};
 
+	rpm-glink {
+		compatible = "qcom,glink-rpm";
+		interrupts = <GIC_SPI 168 IRQ_TYPE_EDGE_RISING>;
+		qcom,rpm-msg-ram = <&rpm_msg_ram>;
+		mboxes = <&apcs_glb 0>;
+
+		rpm_requests: glink-channel {
+			compatible = "qcom,rpm-ipq6018";
+			qcom,glink-channels = "rpm_requests";
+
+			regulators {
+				compatible = "qcom,rpm-mp5496-regulators";
+
+				ipq6018_s2: s2 {
+					regulator-min-microvolt = <725000>;
+					regulator-max-microvolt = <1062500>;
+					regulator-always-on;
+				};
+			};
+		};
+	};
+
 	smem {
 		compatible = "qcom,smem";
 		memory-region = <&smem_region>;
@@ -179,6 +201,102 @@ soc: soc {
 		dma-ranges;
 		compatible = "simple-bus";
 
+		qusb_phy_1: qusb@59000 {
+			compatible = "qcom,ipq6018-qusb2-phy";
+			reg = <0x0 0x00059000 0x0 0x180>;
+			#phy-cells = <0>;
+
+			clocks = <&gcc GCC_USB1_PHY_CFG_AHB_CLK>,
+				 <&xo>;
+			clock-names = "cfg_ahb", "ref";
+
+			resets = <&gcc GCC_QUSB2_1_PHY_BCR>;
+			status = "disabled";
+		};
+
+		ssphy_0: ssphy@78000 {
+			compatible = "qcom,ipq6018-qmp-usb3-phy";
+			reg = <0x0 0x00078000 0x0 0x1c4>;
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+
+			clocks = <&gcc GCC_USB0_AUX_CLK>,
+				 <&gcc GCC_USB0_PHY_CFG_AHB_CLK>, <&xo>;
+			clock-names = "aux", "cfg_ahb", "ref";
+
+			resets = <&gcc GCC_USB0_PHY_BCR>,
+				 <&gcc GCC_USB3PHY_0_PHY_BCR>;
+			reset-names = "phy","common";
+			status = "disabled";
+
+			usb0_ssphy: phy@78200 {
+				reg = <0x0 0x00078200 0x0 0x130>, /* Tx */
+				      <0x0 0x00078400 0x0 0x200>, /* Rx */
+				      <0x0 0x00078800 0x0 0x1f8>, /* PCS */
+				      <0x0 0x00078600 0x0 0x044>; /* PCS misc */
+				#phy-cells = <0>;
+				#clock-cells = <0>;
+				clocks = <&gcc GCC_USB0_PIPE_CLK>;
+				clock-names = "pipe0";
+				clock-output-names = "gcc_usb0_pipe_clk_src";
+			};
+		};
+
+		qusb_phy_0: qusb@79000 {
+			compatible = "qcom,ipq6018-qusb2-phy";
+			reg = <0x0 0x00079000 0x0 0x180>;
+			#phy-cells = <0>;
+
+			clocks = <&gcc GCC_USB0_PHY_CFG_AHB_CLK>,
+				<&xo>;
+			clock-names = "cfg_ahb", "ref";
+
+			resets = <&gcc GCC_QUSB2_0_PHY_BCR>;
+			status = "disabled";
+		};
+
+		pcie_phy: phy@84000 {
+			compatible = "qcom,ipq6018-qmp-pcie-phy";
+			reg = <0x0 0x00084000 0x0 0x1bc>; /* Serdes PLL */
+			status = "disabled";
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+
+			clocks = <&gcc GCC_PCIE0_AUX_CLK>,
+				<&gcc GCC_PCIE0_AHB_CLK>;
+			clock-names = "aux", "cfg_ahb";
+
+			resets = <&gcc GCC_PCIE0_PHY_BCR>,
+				<&gcc GCC_PCIE0PHY_PHY_BCR>;
+			reset-names = "phy",
+				      "common";
+
+			pcie_phy0: phy@84200 {
+				reg = <0x0 0x00084200 0x0 0x16c>, /* Serdes Tx */
+				      <0x0 0x00084400 0x0 0x200>, /* Serdes Rx */
+				      <0x0 0x00084800 0x0 0x1f0>, /* PCS: Lane0, COM, PCIE */
+				      <0x0 0x00084c00 0x0 0xf4>; /* pcs_misc */
+				#phy-cells = <0>;
+
+				clocks = <&gcc GCC_PCIE0_PIPE_CLK>;
+				clock-names = "pipe0";
+				clock-output-names = "gcc_pcie0_pipe_clk_src";
+				#clock-cells = <0>;
+			};
+		};
+
+		mdio: mdio@90000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "qcom,ipq6018-mdio", "qcom,ipq4019-mdio";
+			reg = <0x0 0x00090000 0x0 0x64>;
+			clocks = <&gcc GCC_MDIO_AHB_CLK>;
+			clock-names = "gcc_mdio_ahb_clk";
+			status = "disabled";
+		};
+
 		prng: qrng@e1000 {
 			compatible = "qcom,prng-ee";
 			reg = <0x0 0x000e3000 0x0 0x1000>;
@@ -257,6 +375,41 @@ tcsr: syscon@1937000 {
 			reg = <0x0 0x01937000 0x0 0x21000>;
 		};
 
+		usb2: usb@70f8800 {
+			compatible = "qcom,ipq6018-dwc3", "qcom,dwc3";
+			reg = <0x0 0x070F8800 0x0 0x400>;
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+			clocks = <&gcc GCC_USB1_MASTER_CLK>,
+				 <&gcc GCC_USB1_SLEEP_CLK>,
+				 <&gcc GCC_USB1_MOCK_UTMI_CLK>;
+			clock-names = "core",
+				      "sleep",
+				      "mock_utmi";
+
+			assigned-clocks = <&gcc GCC_USB1_MASTER_CLK>,
+					  <&gcc GCC_USB1_MOCK_UTMI_CLK>;
+			assigned-clock-rates = <133330000>,
+					       <24000000>;
+			resets = <&gcc GCC_USB1_BCR>;
+			status = "disabled";
+
+			dwc_1: usb@7000000 {
+				compatible = "snps,dwc3";
+				reg = <0x0 0x07000000 0x0 0xcd00>;
+				interrupts = <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>;
+				phys = <&qusb_phy_1>;
+				phy-names = "usb2-phy";
+				tx-fifo-resize;
+				snps,is-utmi-l1-suspend;
+				snps,hird-threshold = /bits/ 8 <0x0>;
+				snps,dis_u2_susphy_quirk;
+				snps,dis_u3_susphy_quirk;
+				dr_mode = "host";
+			};
+		};
+
 		blsp_dma: dma-controller@7884000 {
 			compatible = "qcom,bam-v1.7.0";
 			reg = <0x0 0x07884000 0x0 0x2b000>;
@@ -366,6 +519,49 @@ qpic_nand: nand-controller@79b0000 {
 			status = "disabled";
 		};
 
+		usb3: usb@8af8800 {
+			compatible = "qcom,ipq6018-dwc3", "qcom,dwc3";
+			reg = <0x0 0x08af8800 0x0 0x400>;
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+
+			clocks = <&gcc GCC_SYS_NOC_USB0_AXI_CLK>,
+				<&gcc GCC_USB0_MASTER_CLK>,
+				<&gcc GCC_USB0_SLEEP_CLK>,
+				<&gcc GCC_USB0_MOCK_UTMI_CLK>;
+			clock-names = "cfg_noc",
+				"core",
+				"sleep",
+				"mock_utmi";
+
+			assigned-clocks = <&gcc GCC_SYS_NOC_USB0_AXI_CLK>,
+					  <&gcc GCC_USB0_MASTER_CLK>,
+					  <&gcc GCC_USB0_MOCK_UTMI_CLK>;
+			assigned-clock-rates = <133330000>,
+					       <133330000>,
+					       <20000000>;
+
+			resets = <&gcc GCC_USB0_BCR>;
+			status = "disabled";
+
+			dwc_0: usb@8a00000 {
+				compatible = "snps,dwc3";
+				reg = <0x0 0x08a00000 0x0 0xcd00>;
+				interrupts = <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
+				phys = <&qusb_phy_0>, <&usb0_ssphy>;
+				phy-names = "usb2-phy", "usb3-phy";
+				clocks = <&xo>;
+				clock-names = "ref";
+				tx-fifo-resize;
+				snps,is-utmi-l1-suspend;
+				snps,hird-threshold = /bits/ 8 <0x0>;
+				snps,dis_u2_susphy_quirk;
+				snps,dis_u3_susphy_quirk;
+				dr_mode = "host";
+			};
+		};
+
 		intc: interrupt-controller@b000000 {
 			compatible = "qcom,msm-qgic2";
 			#address-cells = <2>;
@@ -386,130 +582,29 @@ v2m@0 {
 			};
 		};
 
-		pcie_phy: phy@84000 {
-			compatible = "qcom,ipq6018-qmp-pcie-phy";
-			reg = <0x0 0x00084000 0x0 0x1bc>; /* Serdes PLL */
-			status = "disabled";
-			#address-cells = <2>;
-			#size-cells = <2>;
-			ranges;
-
-			clocks = <&gcc GCC_PCIE0_AUX_CLK>,
-				<&gcc GCC_PCIE0_AHB_CLK>;
-			clock-names = "aux", "cfg_ahb";
-
-			resets = <&gcc GCC_PCIE0_PHY_BCR>,
-				<&gcc GCC_PCIE0PHY_PHY_BCR>;
-			reset-names = "phy",
-				      "common";
+		watchdog@b017000 {
+			compatible = "qcom,kpss-wdt";
+			interrupts = <GIC_SPI 3 IRQ_TYPE_EDGE_RISING>;
+			reg = <0x0 0x0b017000 0x0 0x40>;
+			clocks = <&sleep_clk>;
+			timeout-sec = <10>;
+		};
 
-			pcie_phy0: phy@84200 {
-				reg = <0x0 0x00084200 0x0 0x16c>, /* Serdes Tx */
-				      <0x0 0x00084400 0x0 0x200>, /* Serdes Rx */
-				      <0x0 0x00084800 0x0 0x1f0>, /* PCS: Lane0, COM, PCIE */
-				      <0x0 0x00084c00 0x0 0xf4>; /* pcs_misc */
-				#phy-cells = <0>;
+		apcs_glb: mailbox@b111000 {
+			compatible = "qcom,ipq6018-apcs-apps-global";
+			reg = <0x0 0x0b111000 0x0 0x1000>;
+			#clock-cells = <1>;
+			clocks = <&a53pll>, <&xo>;
+			clock-names = "pll", "xo";
+			#mbox-cells = <1>;
+		};
 
-				clocks = <&gcc GCC_PCIE0_PIPE_CLK>;
-				clock-names = "pipe0";
-				clock-output-names = "gcc_pcie0_pipe_clk_src";
-				#clock-cells = <0>;
-			};
-		};
-
-		pcie0: pci@20000000 {
-			compatible = "qcom,pcie-ipq6018";
-			reg = <0x0 0x20000000 0x0 0xf1d>,
-			      <0x0 0x20000f20 0x0 0xa8>,
-			      <0x0 0x20001000 0x0 0x1000>,
-			      <0x0 0x80000 0x0 0x4000>,
-			      <0x0 0x20100000 0x0 0x1000>;
-			reg-names = "dbi", "elbi", "atu", "parf", "config";
-
-			device_type = "pci";
-			linux,pci-domain = <0>;
-			bus-range = <0x00 0xff>;
-			num-lanes = <1>;
-			max-link-speed = <3>;
-			#address-cells = <3>;
-			#size-cells = <2>;
-
-			phys = <&pcie_phy0>;
-			phy-names = "pciephy";
-
-			ranges = <0x81000000 0 0x20200000 0 0x20200000
-				  0 0x10000>, /* downstream I/O */
-				 <0x82000000 0 0x20220000 0 0x20220000
-				  0 0xfde0000>; /* non-prefetchable memory */
-
-			interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "msi";
-
-			#interrupt-cells = <1>;
-			interrupt-map-mask = <0 0 0 0x7>;
-			interrupt-map = <0 0 0 1 &intc 0 75
-					 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
-					<0 0 0 2 &intc 0 78
-					 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
-					<0 0 0 3 &intc 0 79
-					 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
-					<0 0 0 4 &intc 0 83
-					 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
-
-			clocks = <&gcc GCC_SYS_NOC_PCIE0_AXI_CLK>,
-				 <&gcc GCC_PCIE0_AXI_M_CLK>,
-				 <&gcc GCC_PCIE0_AXI_S_CLK>,
-				 <&gcc GCC_PCIE0_AXI_S_BRIDGE_CLK>,
-				 <&gcc PCIE0_RCHNG_CLK>;
-			clock-names = "iface",
-				      "axi_m",
-				      "axi_s",
-				      "axi_bridge",
-				      "rchng";
-
-			resets = <&gcc GCC_PCIE0_PIPE_ARES>,
-				 <&gcc GCC_PCIE0_SLEEP_ARES>,
-				 <&gcc GCC_PCIE0_CORE_STICKY_ARES>,
-				 <&gcc GCC_PCIE0_AXI_MASTER_ARES>,
-				 <&gcc GCC_PCIE0_AXI_SLAVE_ARES>,
-				 <&gcc GCC_PCIE0_AHB_ARES>,
-				 <&gcc GCC_PCIE0_AXI_MASTER_STICKY_ARES>,
-				 <&gcc GCC_PCIE0_AXI_SLAVE_STICKY_ARES>;
-			reset-names = "pipe",
-				      "sleep",
-				      "sticky",
-				      "axi_m",
-				      "axi_s",
-				      "ahb",
-				      "axi_m_sticky",
-				      "axi_s_sticky";
-
-			status = "disabled";
-		};
-
-		watchdog@b017000 {
-			compatible = "qcom,kpss-wdt";
-			interrupts = <GIC_SPI 3 IRQ_TYPE_EDGE_RISING>;
-			reg = <0x0 0x0b017000 0x0 0x40>;
-			clocks = <&sleep_clk>;
-			timeout-sec = <10>;
-		};
-
-		apcs_glb: mailbox@b111000 {
-			compatible = "qcom,ipq6018-apcs-apps-global";
-			reg = <0x0 0x0b111000 0x0 0x1000>;
-			#clock-cells = <1>;
-			clocks = <&a53pll>, <&xo>;
-			clock-names = "pll", "xo";
-			#mbox-cells = <1>;
-		};
-
-		a53pll: clock@b116000 {
-			compatible = "qcom,ipq6018-a53pll";
-			reg = <0x0 0x0b116000 0x0 0x40>;
-			#clock-cells = <0>;
-			clocks = <&xo>;
-			clock-names = "xo";
+		a53pll: clock@b116000 {
+			compatible = "qcom,ipq6018-a53pll";
+			reg = <0x0 0x0b116000 0x0 0x40>;
+			#clock-cells = <0>;
+			clocks = <&xo>;
+			clock-names = "xo";
 		};
 
 		timer@b120000 {
@@ -619,147 +714,74 @@ qrtr_requests {
 			};
 		};
 
-		mdio: mdio@90000 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "qcom,ipq6018-mdio", "qcom,ipq4019-mdio";
-			reg = <0x0 0x00090000 0x0 0x64>;
-			clocks = <&gcc GCC_MDIO_AHB_CLK>;
-			clock-names = "gcc_mdio_ahb_clk";
-			status = "disabled";
-		};
-
-		qusb_phy_1: qusb@59000 {
-			compatible = "qcom,ipq6018-qusb2-phy";
-			reg = <0x0 0x00059000 0x0 0x180>;
-			#phy-cells = <0>;
-
-			clocks = <&gcc GCC_USB1_PHY_CFG_AHB_CLK>,
-				 <&xo>;
-			clock-names = "cfg_ahb", "ref";
-
-			resets = <&gcc GCC_QUSB2_1_PHY_BCR>;
-			status = "disabled";
-		};
-
-		usb2: usb@70f8800 {
-			compatible = "qcom,ipq6018-dwc3", "qcom,dwc3";
-			reg = <0x0 0x070F8800 0x0 0x400>;
-			#address-cells = <2>;
-			#size-cells = <2>;
-			ranges;
-			clocks = <&gcc GCC_USB1_MASTER_CLK>,
-				 <&gcc GCC_USB1_SLEEP_CLK>,
-				 <&gcc GCC_USB1_MOCK_UTMI_CLK>;
-			clock-names = "core",
-				      "sleep",
-				      "mock_utmi";
-
-			assigned-clocks = <&gcc GCC_USB1_MASTER_CLK>,
-					  <&gcc GCC_USB1_MOCK_UTMI_CLK>;
-			assigned-clock-rates = <133330000>,
-					       <24000000>;
-			resets = <&gcc GCC_USB1_BCR>;
-			status = "disabled";
-
-			dwc_1: usb@7000000 {
-				compatible = "snps,dwc3";
-				reg = <0x0 0x07000000 0x0 0xcd00>;
-				interrupts = <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>;
-				phys = <&qusb_phy_1>;
-				phy-names = "usb2-phy";
-				tx-fifo-resize;
-				snps,is-utmi-l1-suspend;
-				snps,hird-threshold = /bits/ 8 <0x0>;
-				snps,dis_u2_susphy_quirk;
-				snps,dis_u3_susphy_quirk;
-				dr_mode = "host";
-			};
-		};
+		pcie0: pci@20000000 {
+			compatible = "qcom,pcie-ipq6018";
+			reg = <0x0 0x20000000 0x0 0xf1d>,
+			      <0x0 0x20000f20 0x0 0xa8>,
+			      <0x0 0x20001000 0x0 0x1000>,
+			      <0x0 0x80000 0x0 0x4000>,
+			      <0x0 0x20100000 0x0 0x1000>;
+			reg-names = "dbi", "elbi", "atu", "parf", "config";
 
-		ssphy_0: ssphy@78000 {
-			compatible = "qcom,ipq6018-qmp-usb3-phy";
-			reg = <0x0 0x00078000 0x0 0x1c4>;
-			#address-cells = <2>;
+			device_type = "pci";
+			linux,pci-domain = <0>;
+			bus-range = <0x00 0xff>;
+			num-lanes = <1>;
+			max-link-speed = <3>;
+			#address-cells = <3>;
 			#size-cells = <2>;
-			ranges;
-
-			clocks = <&gcc GCC_USB0_AUX_CLK>,
-				 <&gcc GCC_USB0_PHY_CFG_AHB_CLK>, <&xo>;
-			clock-names = "aux", "cfg_ahb", "ref";
-
-			resets = <&gcc GCC_USB0_PHY_BCR>,
-				 <&gcc GCC_USB3PHY_0_PHY_BCR>;
-			reset-names = "phy","common";
-			status = "disabled";
-
-			usb0_ssphy: phy@78200 {
-				reg = <0x0 0x00078200 0x0 0x130>, /* Tx */
-				      <0x0 0x00078400 0x0 0x200>, /* Rx */
-				      <0x0 0x00078800 0x0 0x1f8>, /* PCS */
-				      <0x0 0x00078600 0x0 0x044>; /* PCS misc */
-				#phy-cells = <0>;
-				#clock-cells = <0>;
-				clocks = <&gcc GCC_USB0_PIPE_CLK>;
-				clock-names = "pipe0";
-				clock-output-names = "gcc_usb0_pipe_clk_src";
-			};
-		};
 
-		qusb_phy_0: qusb@79000 {
-			compatible = "qcom,ipq6018-qusb2-phy";
-			reg = <0x0 0x00079000 0x0 0x180>;
-			#phy-cells = <0>;
+			phys = <&pcie_phy0>;
+			phy-names = "pciephy";
 
-			clocks = <&gcc GCC_USB0_PHY_CFG_AHB_CLK>,
-				<&xo>;
-			clock-names = "cfg_ahb", "ref";
+			ranges = <0x81000000 0 0x20200000 0 0x20200000
+				  0 0x10000>, /* downstream I/O */
+				 <0x82000000 0 0x20220000 0 0x20220000
+				  0 0xfde0000>; /* non-prefetchable memory */
 
-			resets = <&gcc GCC_QUSB2_0_PHY_BCR>;
-			status = "disabled";
-		};
+			interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "msi";
 
-		usb3: usb@8af8800 {
-			compatible = "qcom,ipq6018-dwc3", "qcom,dwc3";
-			reg = <0x0 0x8af8800 0x0 0x400>;
-			#address-cells = <2>;
-			#size-cells = <2>;
-			ranges;
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 0x7>;
+			interrupt-map = <0 0 0 1 &intc 0 75
+					 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
+					<0 0 0 2 &intc 0 78
+					 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
+					<0 0 0 3 &intc 0 79
+					 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
+					<0 0 0 4 &intc 0 83
+					 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
 
-			clocks = <&gcc GCC_SYS_NOC_USB0_AXI_CLK>,
-				<&gcc GCC_USB0_MASTER_CLK>,
-				<&gcc GCC_USB0_SLEEP_CLK>,
-				<&gcc GCC_USB0_MOCK_UTMI_CLK>;
-			clock-names = "cfg_noc",
-				"core",
-				"sleep",
-				"mock_utmi";
+			clocks = <&gcc GCC_SYS_NOC_PCIE0_AXI_CLK>,
+				 <&gcc GCC_PCIE0_AXI_M_CLK>,
+				 <&gcc GCC_PCIE0_AXI_S_CLK>,
+				 <&gcc GCC_PCIE0_AXI_S_BRIDGE_CLK>,
+				 <&gcc PCIE0_RCHNG_CLK>;
+			clock-names = "iface",
+				      "axi_m",
+				      "axi_s",
+				      "axi_bridge",
+				      "rchng";
 
-			assigned-clocks = <&gcc GCC_SYS_NOC_USB0_AXI_CLK>,
-					  <&gcc GCC_USB0_MASTER_CLK>,
-					  <&gcc GCC_USB0_MOCK_UTMI_CLK>;
-			assigned-clock-rates = <133330000>,
-					       <133330000>,
-					       <20000000>;
+			resets = <&gcc GCC_PCIE0_PIPE_ARES>,
+				 <&gcc GCC_PCIE0_SLEEP_ARES>,
+				 <&gcc GCC_PCIE0_CORE_STICKY_ARES>,
+				 <&gcc GCC_PCIE0_AXI_MASTER_ARES>,
+				 <&gcc GCC_PCIE0_AXI_SLAVE_ARES>,
+				 <&gcc GCC_PCIE0_AHB_ARES>,
+				 <&gcc GCC_PCIE0_AXI_MASTER_STICKY_ARES>,
+				 <&gcc GCC_PCIE0_AXI_SLAVE_STICKY_ARES>;
+			reset-names = "pipe",
+				      "sleep",
+				      "sticky",
+				      "axi_m",
+				      "axi_s",
+				      "ahb",
+				      "axi_m_sticky",
+				      "axi_s_sticky";
 
-			resets = <&gcc GCC_USB0_BCR>;
 			status = "disabled";
-
-			dwc_0: usb@8a00000 {
-				compatible = "snps,dwc3";
-				reg = <0x0 0x8a00000 0x0 0xcd00>;
-				interrupts = <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
-				phys = <&qusb_phy_0>, <&usb0_ssphy>;
-				phy-names = "usb2-phy", "usb3-phy";
-				clocks = <&xo>;
-				clock-names = "ref";
-				tx-fifo-resize;
-				snps,is-utmi-l1-suspend;
-				snps,hird-threshold = /bits/ 8 <0x0>;
-				snps,dis_u2_susphy_quirk;
-				snps,dis_u3_susphy_quirk;
-				dr_mode = "host";
-			};
 		};
 	};
 
@@ -794,26 +816,4 @@ wcss_smp2p_in: slave-kernel {
 			#interrupt-cells = <2>;
 		};
 	};
-
-	rpm-glink {
-		compatible = "qcom,glink-rpm";
-		interrupts = <GIC_SPI 168 IRQ_TYPE_EDGE_RISING>;
-		qcom,rpm-msg-ram = <&rpm_msg_ram>;
-		mboxes = <&apcs_glb 0>;
-
-		rpm_requests: glink-channel {
-			compatible = "qcom,rpm-ipq6018";
-			qcom,glink-channels = "rpm_requests";
-
-			regulators {
-				compatible = "qcom,rpm-mp5496-regulators";
-
-				ipq6018_s2: s2 {
-					regulator-min-microvolt = <725000>;
-					regulator-max-microvolt = <1062500>;
-					regulator-always-on;
-				};
-			};
-		};
-	};
 };
-- 
2.39.0

