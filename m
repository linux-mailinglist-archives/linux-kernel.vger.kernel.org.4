Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9AA96B012A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 09:25:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbjCHIZo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 03:25:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbjCHIZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 03:25:02 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2AEB29149
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 00:24:54 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id y15-20020a17090aa40f00b00237ad8ee3a0so1203601pjp.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 00:24:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678263894;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eLVjhutA2hfGCZ6M883YUXMDKjvpwcVnGmnnfjx/2V0=;
        b=JZgivbmib2JBc4xEDzQ8oGcl/APFNGx+KsS+9Iy+NNra0VL+pqjs5BekmHJLnHapBU
         mF/CtoU05zcIBbyqx9lV/bnpDmEhYCasDKiQZfhrqfsJ1ozTKk722NSnO9VIjaERI9ML
         5SVmzIYLUzgHWOXJC1zO7SkCZ1iFirQsX8XBqHAH2+hD69mPjuWOMRklpXCTFrAUyhlG
         4v/lRpTJ7EfXBR89BTlWyiUzLyeCUXX3ZGnW2t1Nct0NC671DJCdP0nPWt35tem6lB7v
         h7+zveBybLMYdfXoRzsmSWuHMppzfG2NjAC4Sa8uwEUUxJ/evsQLBJ+RJE1P6rPjFSpO
         g88Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678263894;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eLVjhutA2hfGCZ6M883YUXMDKjvpwcVnGmnnfjx/2V0=;
        b=tGOT3yhItnY76LS+PfD55sqSSiiCL6CwFbGMEtV0HoXErz+A281XHSfrj49C5j6VZ3
         UKHqujH86ruQDZQr/ZHfLKDp5BtMCd0j55pzFyjRpEG54Zq3TVHNhck/G/ICiETWEdBv
         d3anMGMrwUYPUTLPr4SKqxD/F+0SJhkGepvuhKMCxXgf0Sgo8T7BE2hH8tkBBTfVuO4n
         anCLGwk9caxkuUQyxGZEkrx++6cVF1GokDFqyS+s2AVRXmdUctMtYCCNamox72xOFf4u
         xzoJoHF4oAQgMDkS3JEPaZAO52eacP9/Ndkumy0JHklxcbn4BHcUrk0QDgH5qpPZ2SX7
         Ev+w==
X-Gm-Message-State: AO0yUKW88E0K02ymeYgdqCe7rImV2gE9IrWzFimtLo+6pXyLk6wrZ3tC
        8Bepfws26APY5NgSSDd+K+yI
X-Google-Smtp-Source: AK7set91RovMZQ6AND4VBKAYwNmUQMvjbtMSJridqM/I4ZipYdc2rWKaVNf6WpTp6n1sdMvtcw9iLg==
X-Received: by 2002:a17:902:d492:b0:19d:abd:bb7e with SMTP id c18-20020a170902d49200b0019d0abdbb7emr21509188plg.34.1678263894378;
        Wed, 08 Mar 2023 00:24:54 -0800 (PST)
Received: from localhost.localdomain ([59.97.52.140])
        by smtp.gmail.com with ESMTPSA id s10-20020a170902ea0a00b0019aaab3f9d7sm9448086plg.113.2023.03.08.00.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 00:24:54 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, lpieralisi@kernel.org, robh@kernel.org,
        kw@linux.com, krzysztof.kozlowski+dt@linaro.org, vkoul@kernel.org
Cc:     konrad.dybcio@linaro.org, bhelgaas@google.com, kishon@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 05/13] ARM: dts: qcom: sdx55: Fix the unit address of PCIe EP node
Date:   Wed,  8 Mar 2023 13:54:16 +0530
Message-Id: <20230308082424.140224-6-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230308082424.140224-1-manivannan.sadhasivam@linaro.org>
References: <20230308082424.140224-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unit address of PCIe EP node should be 0x1c00000 as it has to match the
first address specified in the reg property.

This also requires sorting the node in the ascending order.

Fixes: e6b69813283f ("ARM: dts: qcom: sdx55: Add support for PCIe EP")
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm/boot/dts/qcom-sdx55.dtsi | 78 +++++++++++++++----------------
 1 file changed, 39 insertions(+), 39 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-sdx55.dtsi b/arch/arm/boot/dts/qcom-sdx55.dtsi
index df7303c5c843..7fa542249f1a 100644
--- a/arch/arm/boot/dts/qcom-sdx55.dtsi
+++ b/arch/arm/boot/dts/qcom-sdx55.dtsi
@@ -304,6 +304,45 @@ qpic_nand: nand-controller@1b30000 {
 			status = "disabled";
 		};
 
+		pcie_ep: pcie-ep@1c00000 {
+			compatible = "qcom,sdx55-pcie-ep";
+			reg = <0x01c00000 0x3000>,
+			      <0x40000000 0xf1d>,
+			      <0x40000f20 0xc8>,
+			      <0x40001000 0x1000>,
+			      <0x40200000 0x100000>,
+			      <0x01c03000 0x3000>;
+			reg-names = "parf", "dbi", "elbi", "atu", "addr_space",
+				    "mmio";
+
+			qcom,perst-regs = <&tcsr 0xb258 0xb270>;
+
+			clocks = <&gcc GCC_PCIE_AUX_CLK>,
+				 <&gcc GCC_PCIE_CFG_AHB_CLK>,
+				 <&gcc GCC_PCIE_MSTR_AXI_CLK>,
+				 <&gcc GCC_PCIE_SLV_AXI_CLK>,
+				 <&gcc GCC_PCIE_SLV_Q2A_AXI_CLK>,
+				 <&gcc GCC_PCIE_SLEEP_CLK>,
+				 <&gcc GCC_PCIE_0_CLKREF_CLK>;
+			clock-names = "aux", "cfg", "bus_master", "bus_slave",
+				      "slave_q2a", "sleep", "ref";
+
+			interrupts = <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "global", "doorbell";
+			reset-gpios = <&tlmm 57 GPIO_ACTIVE_LOW>;
+			wake-gpios = <&tlmm 53 GPIO_ACTIVE_LOW>;
+			resets = <&gcc GCC_PCIE_BCR>;
+			reset-names = "core";
+			power-domains = <&gcc PCIE_GDSC>;
+			phys = <&pcie0_lane>;
+			phy-names = "pciephy";
+			max-link-speed = <3>;
+			num-lanes = <2>;
+
+			status = "disabled";
+		};
+
 		pcie0_phy: phy@1c07000 {
 			compatible = "qcom,sdx55-qmp-pcie-phy";
 			reg = <0x01c07000 0x1c4>;
@@ -401,45 +440,6 @@ sdhc_1: mmc@8804000 {
 			status = "disabled";
 		};
 
-		pcie_ep: pcie-ep@40000000 {
-			compatible = "qcom,sdx55-pcie-ep";
-			reg = <0x01c00000 0x3000>,
-			      <0x40000000 0xf1d>,
-			      <0x40000f20 0xc8>,
-			      <0x40001000 0x1000>,
-			      <0x40200000 0x100000>,
-			      <0x01c03000 0x3000>;
-			reg-names = "parf", "dbi", "elbi", "atu", "addr_space",
-				    "mmio";
-
-			qcom,perst-regs = <&tcsr 0xb258 0xb270>;
-
-			clocks = <&gcc GCC_PCIE_AUX_CLK>,
-				 <&gcc GCC_PCIE_CFG_AHB_CLK>,
-				 <&gcc GCC_PCIE_MSTR_AXI_CLK>,
-				 <&gcc GCC_PCIE_SLV_AXI_CLK>,
-				 <&gcc GCC_PCIE_SLV_Q2A_AXI_CLK>,
-				 <&gcc GCC_PCIE_SLEEP_CLK>,
-				 <&gcc GCC_PCIE_0_CLKREF_CLK>;
-			clock-names = "aux", "cfg", "bus_master", "bus_slave",
-				      "slave_q2a", "sleep", "ref";
-
-			interrupts = <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "global", "doorbell";
-			reset-gpios = <&tlmm 57 GPIO_ACTIVE_LOW>;
-			wake-gpios = <&tlmm 53 GPIO_ACTIVE_LOW>;
-			resets = <&gcc GCC_PCIE_BCR>;
-			reset-names = "core";
-			power-domains = <&gcc PCIE_GDSC>;
-			phys = <&pcie0_lane>;
-			phy-names = "pciephy";
-			max-link-speed = <3>;
-			num-lanes = <2>;
-
-			status = "disabled";
-		};
-
 		remoteproc_mpss: remoteproc@4080000 {
 			compatible = "qcom,sdx55-mpss-pas";
 			reg = <0x04080000 0x4040>;
-- 
2.25.1

