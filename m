Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAC9C67CB39
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 13:47:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236608AbjAZMrf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 07:47:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236575AbjAZMrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 07:47:18 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F6F56DB0D
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 04:47:08 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id h12so1636525wrv.10
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 04:47:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u16Q/10dUAiJnPHRN7rZ/LQzB/Z00hmLxF5RI+QozW4=;
        b=gVAU+g208Bc+N7E9I6ST/Un/+oBKKoekGq22v27ilYzdL5RT+hQuku2qf0Kg3fReYC
         yEUlqSZwP2y9Tu4tkvBNxrylgWB3SKvTa84ioW/gLK1C85zsT3jyOWC6TzD21amJM0FA
         QmzfMn0dx8Kg458E1DoZ4eVUIeCkvaHlBZqiOWPB7kjN/IiulQmf7+qHkF03sCbUnW+r
         ojB2Z47BfsqWrIPByoQDjN3+pb0VzBhprppBpvtapx/aukpcbVnyIqeQqfpxfjU5/L3n
         GlsMdR8OJhTRPoLHBPuju/4b7UdHXpAmTo4RMLNBSPBuT5JIfFFDlmEXQzjHJBvf53lV
         ECyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u16Q/10dUAiJnPHRN7rZ/LQzB/Z00hmLxF5RI+QozW4=;
        b=nTlrnSSDB8wfQ3IGiylQHEtwYYo0x/E/cvV9x/Xgh5kYE5FicMWPzhJenl6lhhv15h
         tAhEVzhh2ATzLhRak54UTxNh5a/l1PBkNUur4tC+PyPMzw6SbOxhPkdb2Ap3eU1D4QNZ
         nbD0kF5PDzHJbBDXUz9XPMJaJ8Qjhnl1Aj5tYMPYQFN1kEoSFLHM5+WgnqdOOk1AQUmm
         Qea1+lQ/ZCRfO3F1BfM61IhtPzqobN1vfsHRuAjZ/8vToo0U7jdBe5YtIQweeyll4693
         d629QLD7GkuM0X8babmlDMIsOWTAJzhpHcV94IVUuTCxjztyo1Fwhz77HBxTcVsIAGBl
         fkNg==
X-Gm-Message-State: AO0yUKXmzFkHGXNvaRe3OQIWSGAQdo2uyxcdnrtypolw3TiZez8+fIg2
        oZXag585BAgBz6TX9TpFOQBq5Q==
X-Google-Smtp-Source: AK7set+cTl4MgW8hiaCowW7x72Q9W4kmydO2WFy72x1ft9MbHMw8MZRArXYUI00qlR0i/OXUXqnBcQ==
X-Received: by 2002:a5d:4e86:0:b0:2bf:bfc1:f626 with SMTP id e6-20020a5d4e86000000b002bfbfc1f626mr3396304wru.41.1674737226577;
        Thu, 26 Jan 2023 04:47:06 -0800 (PST)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id v11-20020adff68b000000b002bfb8f829eesm1198681wrp.71.2023.01.26.04.47.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 04:47:06 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-phy@lists.infradead.org
Subject: [PATCH v2 7/8] arm64: dts: qcom: sm8550: Add USB PHYs and controller nodes
Date:   Thu, 26 Jan 2023 14:46:50 +0200
Message-Id: <20230126124651.1362533-8-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230126124651.1362533-1-abel.vesa@linaro.org>
References: <20230126124651.1362533-1-abel.vesa@linaro.org>
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

NOTE: This patch has been already merged. It is here only to provide
context for the rest of the patchset. There is a change with respect to the
clocks, but that will be sent as a separate/individual fix patch.

 arch/arm64/boot/dts/qcom/sm8550.dtsi | 92 +++++++++++++++++++++++++++-
 1 file changed, 91 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
index 4daf1f03d79f..6801454bbe10 100644
--- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
@@ -13,6 +13,7 @@
 #include <dt-bindings/mailbox/qcom-ipcc.h>
 #include <dt-bindings/power/qcom-rpmpd.h>
 #include <dt-bindings/soc/qcom,rpmh-rsc.h>
+#include <dt-bindings/phy/phy-qcom-qmp.h>
 #include <dt-bindings/thermal/thermal.h>
 
 / {
@@ -652,7 +653,7 @@ gcc: clock-controller@100000 {
 				 <&ufs_mem_phy 0>,
 				 <&ufs_mem_phy 1>,
 				 <&ufs_mem_phy 2>,
-				 <0>;
+				 <&usb_dp_qmpphy QMP_USB43DP_USB3_PIPE_CLK>;
 		};
 
 		ipcc: mailbox@408000 {
@@ -1924,6 +1925,95 @@ opp-202000000 {
 			};
 		};
 
+		usb_1_hsphy: phy@88e3000 {
+			compatible = "qcom,sm8550-snps-eusb2-phy";
+			reg = <0x0 0x088e3000 0x0 0x154>;
+			#phy-cells = <0>;
+
+			clocks = <&tcsr TCSR_USB2_CLKREF_EN>;
+			clock-names = "ref";
+
+			resets = <&gcc GCC_QUSB2PHY_PRIM_BCR>;
+
+			status = "disabled";
+		};
+
+		usb_dp_qmpphy: phy@88e8000 {
+			compatible = "qcom,sm8550-qmp-usb3-dp-phy";
+			reg = <0x0 0x088e8000 0x0 0x3000>;
+
+			clocks = <&gcc GCC_USB3_PRIM_PHY_AUX_CLK>,
+				 <&rpmhcc RPMH_CXO_CLK>,
+				 <&gcc GCC_USB3_PRIM_PHY_COM_AUX_CLK>,
+				 <&gcc GCC_USB3_PRIM_PHY_PIPE_CLK>;
+			clock-names = "aux", "ref", "com_aux", "usb3_pipe";
+
+			power-domains = <&gcc USB3_PHY_GDSC>;
+
+			resets = <&gcc GCC_USB3_DP_PHY_PRIM_BCR>,
+				 <&gcc GCC_USB3_PHY_PRIM_BCR>;
+			reset-names = "phy", "common";
+
+			#clock-cells = <1>;
+			#phy-cells = <1>;
+
+			status = "disabled";
+		};
+
+		usb_1: usb@a6f8800 {
+			compatible = "qcom,sm8550-dwc3", "qcom,dwc3";
+			reg = <0x0 0x0a6f8800 0x0 0x400>;
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+
+			clocks = <&gcc GCC_CFG_NOC_USB3_PRIM_AXI_CLK>,
+				 <&gcc GCC_USB30_PRIM_MASTER_CLK>,
+				 <&gcc GCC_AGGRE_USB3_PRIM_AXI_CLK>,
+				 <&gcc GCC_USB30_PRIM_SLEEP_CLK>,
+				 <&gcc GCC_USB30_PRIM_MOCK_UTMI_CLK>,
+				 <&rpmhcc TCSR_USB3_CLKREF_EN>;
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
+			required-opps = <&rpmhpd_opp_nom>;
+
+			resets = <&gcc GCC_USB30_PRIM_BCR>;
+
+			status = "disabled";
+
+			usb_1_dwc3: usb@a600000 {
+				compatible = "snps,dwc3";
+				reg = <0x0 0x0a600000 0x0 0xcd00>;
+				interrupts = <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>;
+				iommus = <&apps_smmu 0x40 0x0>;
+				snps,dis_u2_susphy_quirk;
+				snps,dis_enblslpm_quirk;
+				snps,usb3_lpm_capable;
+				phys = <&usb_1_hsphy>,
+				       <&usb_dp_qmpphy QMP_USB43DP_USB3_PHY>;
+				phy-names = "usb2-phy", "usb3-phy";
+			};
+		};
+
 		pdc: interrupt-controller@b220000 {
 			compatible = "qcom,sm8550-pdc", "qcom,pdc";
 			reg = <0 0x0b220000 0 0x30000>, <0 0x174000f0 0 0x64>;
-- 
2.34.1

