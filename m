Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA8565AEDF
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 10:47:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232116AbjABJrK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 04:47:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232334AbjABJqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 04:46:52 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 115592DC1
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 01:46:48 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id f34so40882107lfv.10
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jan 2023 01:46:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FYFTgnpz1KiF+ExXwhiE68/Pe5v4vZYUMWLxyvATRtg=;
        b=a2lR1XiTo5Ezn0rwvlvjerOo7HVgoNzOArW7qwgi9d6o4ZygIvd+0OF3mxov2rF4uL
         +7qRBuoiSXiFXY1LCkAyxI8eDpHziE9FYvR4Tt4L7eydEG8L3UWwhKriCj2TUNIJp6ew
         T9QqkEqs6c16lnFqZ1ku2jsgsrCqU6xZ7hGHx4m5vmHvsLwykZLXnsKyHqTHRNV8IFVe
         VaZh0CXoQ+5NyMWYe4NQRoFmJRXyWZYSHLoj7gmA++L4bF8XnvHZ5vdUf36cZ6JSqkTM
         O5HopVMgPAbsK1jj8qCq7LpRzzc1VVCC9zcA5kKpfpuPF3vJA4JQU1JHOhIFhpVHS0d8
         Vwxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FYFTgnpz1KiF+ExXwhiE68/Pe5v4vZYUMWLxyvATRtg=;
        b=nam88+3xLbSk2CnFK1e/TLvg807QnxzA1MGS+x3htOoN0o3m7rb3lUXKAJwwfDQ07C
         UkhqZom37qUq6h+wLyhhRTL9Omugd0Obsyq15uaIxDZ4FVZMc+47vuSF4NkLWYVgoyeC
         vI9joxDi90rAYnaAhj1A3L7n0dwB8W9f7LfKsX4HlV/pnal71lT5ISN/uWe7MkzHWYJW
         Lv4SwEDBmTiA4vDUeMPfKFY85qvmxc17Y9vUK9wEErlyLv/aPH9wcsspBAF6QcxjWX+D
         uszBcy5Jf0TKFX6bNClIUk7+PmGOHBbZfTx3W0wYuJ8NiCJS3mvDSz+OrUIqZJ7CazuB
         TTJw==
X-Gm-Message-State: AFqh2ko1bjebq7+4ARvn7iWJ7wUbg6duJGW6T9VSZHThW7Q+PG47Ha1o
        K/BRr3Fw5I25WOzGdMAKol0C7Q==
X-Google-Smtp-Source: AMrXdXvHyWoKljZOjhDukRo4yZ55k31WeGQgaLh1Rsc0psMT466Hy2lvWICuFK+M6bc0Mf7jDjy6cQ==
X-Received: by 2002:ac2:5f46:0:b0:4c2:7049:5fae with SMTP id 6-20020ac25f46000000b004c270495faemr10169848lfz.20.1672652806445;
        Mon, 02 Jan 2023 01:46:46 -0800 (PST)
Received: from localhost.localdomain (abxi45.neoplus.adsl.tpnet.pl. [83.9.2.45])
        by smtp.gmail.com with ESMTPSA id x11-20020a0565123f8b00b004b5adb59ed5sm4382143lfa.297.2023.01.02.01.46.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jan 2023 01:46:46 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 01/17] arm64: dts: qcom: ipq6018: Pad addresses to 8 hex digits
Date:   Mon,  2 Jan 2023 10:46:26 +0100
Message-Id: <20230102094642.74254-2-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230102094642.74254-1-konrad.dybcio@linaro.org>
References: <20230102094642.74254-1-konrad.dybcio@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some addresses were 7-hex-digits long, or less. Fix that.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
v1 -> v2:
- Remove stray duplicated usb node

 arch/arm64/boot/dts/qcom/ipq6018.dtsi | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq6018.dtsi b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
index 2ceae73a6069..6f12c1a8f90f 100644
--- a/arch/arm64/boot/dts/qcom/ipq6018.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
@@ -146,7 +146,7 @@ reserved-memory {
 		ranges;
 
 		rpm_msg_ram: memory@60000 {
-			reg = <0x0 0x60000 0x0 0x6000>;
+			reg = <0x0 0x00060000 0x0 0x6000>;
 			no-map;
 		};
 
@@ -181,7 +181,7 @@ soc: soc {
 
 		prng: qrng@e1000 {
 			compatible = "qcom,prng-ee";
-			reg = <0x0 0xe3000 0x0 0x1000>;
+			reg = <0x0 0x000e3000 0x0 0x1000>;
 			clocks = <&gcc GCC_PRNG_AHB_CLK>;
 			clock-names = "core";
 		};
@@ -388,7 +388,7 @@ v2m@0 {
 
 		pcie_phy: phy@84000 {
 			compatible = "qcom,ipq6018-qmp-pcie-phy";
-			reg = <0x0 0x84000 0x0 0x1bc>; /* Serdes PLL */
+			reg = <0x0 0x00084000 0x0 0x1bc>; /* Serdes PLL */
 			status = "disabled";
 			#address-cells = <2>;
 			#size-cells = <2>;
@@ -404,10 +404,10 @@ pcie_phy: phy@84000 {
 				      "common";
 
 			pcie_phy0: phy@84200 {
-				reg = <0x0 0x84200 0x0 0x16c>, /* Serdes Tx */
-				      <0x0 0x84400 0x0 0x200>, /* Serdes Rx */
-				      <0x0 0x84800 0x0 0x1f0>, /* PCS: Lane0, COM, PCIE */
-				      <0x0 0x84c00 0x0 0xf4>; /* pcs_misc */
+				reg = <0x0 0x00084200 0x0 0x16c>, /* Serdes Tx */
+				      <0x0 0x00084400 0x0 0x200>, /* Serdes Rx */
+				      <0x0 0x00084800 0x0 0x1f0>, /* PCS: Lane0, COM, PCIE */
+				      <0x0 0x00084c00 0x0 0xf4>; /* pcs_misc */
 				#phy-cells = <0>;
 
 				clocks = <&gcc GCC_PCIE0_PIPE_CLK>;
@@ -623,7 +623,7 @@ mdio: mdio@90000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			compatible = "qcom,ipq6018-mdio", "qcom,ipq4019-mdio";
-			reg = <0x0 0x90000 0x0 0x64>;
+			reg = <0x0 0x00090000 0x0 0x64>;
 			clocks = <&gcc GCC_MDIO_AHB_CLK>;
 			clock-names = "gcc_mdio_ahb_clk";
 			status = "disabled";
@@ -631,7 +631,7 @@ mdio: mdio@90000 {
 
 		qusb_phy_1: qusb@59000 {
 			compatible = "qcom,ipq6018-qusb2-phy";
-			reg = <0x0 0x059000 0x0 0x180>;
+			reg = <0x0 0x00059000 0x0 0x180>;
 			#phy-cells = <0>;
 
 			clocks = <&gcc GCC_USB1_PHY_CFG_AHB_CLK>,
@@ -664,7 +664,7 @@ usb2: usb@70f8800 {
 
 			dwc_1: usb@7000000 {
 			       compatible = "snps,dwc3";
-			       reg = <0x0 0x7000000 0x0 0xcd00>;
+			       reg = <0x0 0x07000000 0x0 0xcd00>;
 			       interrupts = <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>;
 			       phys = <&qusb_phy_1>;
 			       phy-names = "usb2-phy";
@@ -679,7 +679,7 @@ dwc_1: usb@7000000 {
 
 		ssphy_0: ssphy@78000 {
 			compatible = "qcom,ipq6018-qmp-usb3-phy";
-			reg = <0x0 0x78000 0x0 0x1c4>;
+			reg = <0x0 0x00078000 0x0 0x1c4>;
 			#address-cells = <2>;
 			#size-cells = <2>;
 			ranges;
@@ -708,7 +708,7 @@ usb0_ssphy: phy@78200 {
 
 		qusb_phy_0: qusb@79000 {
 			compatible = "qcom,ipq6018-qusb2-phy";
-			reg = <0x0 0x079000 0x0 0x180>;
+			reg = <0x0 0x00079000 0x0 0x180>;
 			#phy-cells = <0>;
 
 			clocks = <&gcc GCC_USB0_PHY_CFG_AHB_CLK>,
-- 
2.39.0

