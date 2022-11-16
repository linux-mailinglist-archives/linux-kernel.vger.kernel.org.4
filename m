Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 082F762BF52
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 14:22:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233877AbiKPNWm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 08:22:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233970AbiKPNWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 08:22:32 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C63CD4045C
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 05:22:26 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id g12so29664548wrs.10
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 05:22:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=10mYJXHgETGoYwxbS03wuTAj/azJ+HiwMNZmVFu7F2w=;
        b=Ub0nfUP9Ckkmse+HllLJUhMzMbUNjSh2UmoT+Mulk8LmQeXOIYX/woJXqIEjVsIXdt
         J9BbMjwXUwT7XlF/o9kCC98Ty6wBhz3SovyIHi2uKFqzHb/uyfqk/HmHfsCbrIBWyV+Y
         KDcJ+ktdJOwdWhIUqQ5UZnRbhKSkSqyEsSNrd3ZF4EDwJhUFwC/GIdx96Mjd4CB4rwtP
         Ox/QyCw727F7KUmJegjHs7O2NEkTBT6MZQz8c2INH/dv0hKFDSrrHjPO1EXSwRx+VqNy
         CWq/khdGFfgYdx0VnN/YTk6qw/qSW0sCIJpw4yJUVl18vEzL5CyYO4JKKBmonA1QPox4
         3K2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=10mYJXHgETGoYwxbS03wuTAj/azJ+HiwMNZmVFu7F2w=;
        b=Tv5Rvd78SCx6KjY8KACeJ2XzhyKaA/3DuE25C+WstCvgW/ewHnT6/ljL2vWugoRdQe
         EQywt1GH+PxiYbq+04RTFBcMfTZ4+wc4g5xHEXCadxvJeDAFciwxK3KR41pyA2TkKp16
         8dnMuALCln9uXOn/CxQpjWgshbKOY7fdr/+CEwcjHbW3+80DlRKNke8/IW/dR3vNOTD9
         kOSnY3ZSJ8hSu/QV5QBJNQ4aRTO0STtmZsFjBEyi8hFlCcVkGyTTuah0Bt9P3GCK+lsd
         gZK6/6FzVk1uzMo2BcaMlLZG/mDgMH3AKjI9FDUOAsQC3DVLY6Aov7e72d35w59322T6
         lLLA==
X-Gm-Message-State: ANoB5pmNu9OdeFtW/dbp0ObIeF6a0UmyhQDLnFxEeloC0DSAYrkXQEP8
        MeUnAKS/xML0pMCOrcoFFizspw==
X-Google-Smtp-Source: AA0mqf4djXReZl9KYp2QbALqe/1PIBn0ztTlkU8ByauqET02QPn0pVRG9AdWTwmw1t2eoBGXuJF7nQ==
X-Received: by 2002:adf:fe41:0:b0:236:8721:ccc with SMTP id m1-20020adffe41000000b0023687210cccmr13995410wrs.678.1668604945002;
        Wed, 16 Nov 2022 05:22:25 -0800 (PST)
Received: from localhost.localdomain ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id e17-20020a05600c4e5100b003cfa81e2eb4sm2322074wmq.38.2022.11.16.05.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 05:22:24 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH 1/2] arm64: dts: qcom: sm8550: Add USB PHYs and controller nodes
Date:   Wed, 16 Nov 2022 15:22:11 +0200
Message-Id: <20221116132212.2842655-2-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221116132212.2842655-1-abel.vesa@linaro.org>
References: <20221116132212.2842655-1-abel.vesa@linaro.org>
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

Add USB host controller and PHY nodes.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8550.dtsi | 99 ++++++++++++++++++++++++++++
 1 file changed, 99 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
index 07ba709ca35f..1b62395fe101 100644
--- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
@@ -1460,6 +1460,105 @@ opp-202000000 {
 			};
 		};
 
+		usb_1_hsphy: phy@88e3000 {
+			compatible = "qcom,sm8550-snps-eusb2-phy";
+			reg = <0x0 0x088e3000 0x0 0x154>;
+			status = "disabled";
+			#phy-cells = <0>;
+
+			clocks = <&tcsr TCSR_USB2_CLKREF_EN>;
+			clock-names = "ref";
+
+			resets = <&gcc GCC_QUSB2PHY_PRIM_BCR>;
+		};
+
+		usb_1_qmpphy: phy-wrapper@88e9000 {
+			compatible = "qcom,sm8550-qmp-usb3-phy";
+			reg = <0x0 0x088e9000 0x0 0x200>,
+			      <0x0 0x088e8000 0x0 0x20>;
+			status = "disabled";
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+
+			clocks = <&gcc GCC_USB3_PRIM_PHY_AUX_CLK>,
+				 <&rpmhcc RPMH_CXO_PAD_CLK>,
+				 <&gcc GCC_USB3_PRIM_PHY_COM_AUX_CLK>;
+			clock-names = "aux", "ref_clk_src", "com_aux";
+
+			resets = <&gcc GCC_USB3_DP_PHY_PRIM_BCR>,
+				<&gcc GCC_USB3_PHY_PRIM_BCR>;
+			reset-names = "phy", "common";
+			power-domains = <&gcc USB3_PHY_GDSC>;
+
+			usb_1_ssphy: phy@88e9200 {
+				reg = <0x0 0x088e9200 0x0 0x200>,
+				      <0x0 0x088e9400 0x0 0x200>,
+				      <0x0 0x088e9c00 0x0 0x400>,
+				      <0x0 0x088e9600 0x0 0x200>,
+				      <0x0 0x088e9800 0x0 0x200>,
+				      <0x0 0x088e9a00 0x0 0x100>;
+				#phy-cells = <0>;
+				#clock-cells = <0>;
+				clocks = <&gcc GCC_USB3_PRIM_PHY_PIPE_CLK>;
+				clock-names = "pipe0";
+				clock-output-names = "usb3_phy_pipe_clk_src";
+			};
+		};
+
+		usb_1: usb@a6f8800 {
+			compatible = "qcom,sm8550-dwc3", "qcom,dwc3";
+			reg = <0x0 0x0a6f8800 0x0 0x400>;
+			status = "disabled";
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+
+			clocks = <&gcc GCC_CFG_NOC_USB3_PRIM_AXI_CLK>,
+				 <&gcc GCC_USB30_PRIM_MASTER_CLK>,
+				 <&gcc GCC_AGGRE_USB3_PRIM_AXI_CLK>,
+				 <&gcc GCC_USB30_PRIM_SLEEP_CLK>,
+				 <&gcc GCC_USB30_PRIM_MOCK_UTMI_CLK>,
+				 <&tcsr TCSR_USB3_CLKREF_EN>;
+			clock-names = "cfg_noc",
+				      "core",
+				      "iface",
+				      "sleep",
+				      "mock_utmi",
+				      "xo";
+
+			assigned-clocks = <&gcc GCC_USB30_PRIM_MOCK_UTMI_CLK>,
+					  <&gcc GCC_USB30_PRIM_MASTER_CLK>;
+			assigned-clock-rates = <19200000>, <200000000>;
+
+			interrupts-extended = <&intc GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>,
+					      <&pdc 17 IRQ_TYPE_LEVEL_HIGH>,
+					      <&pdc 15 IRQ_TYPE_EDGE_RISING>,
+					      <&pdc 14 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "hs_phy_irq",
+					  "ss_phy_irq",
+					  "dm_hs_phy_irq",
+					  "dp_hs_phy_irq";
+
+			power-domains = <&gcc USB30_PRIM_GDSC>;
+
+			resets = <&gcc GCC_USB30_PRIM_BCR>;
+
+			usb_1_dwc3: usb@a600000 {
+				compatible = "snps,dwc3";
+				reg = <0x0 0x0a600000 0x0 0xcd00>;
+				interrupts = <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>;
+				iommus = <&apps_smmu 0x40 0x0>;
+				snps,dis_u2_susphy_quirk;
+				snps,dis_enblslpm_quirk;
+				snps,usb3_lpm_capable;
+				phys = <&usb_1_ssphy>,
+				       <&usb_1_hsphy>;
+				phy-names = "usb3-phy",
+					    "usb2-phy";
+			};
+		};
+
 		pdc: interrupt-controller@b220000 {
 			compatible = "qcom,sm8550-pdc", "qcom,pdc";
 			reg = <0 0x0b220000 0 0x30000>, <0 0x174000f0 0 0x64>;
-- 
2.34.1

