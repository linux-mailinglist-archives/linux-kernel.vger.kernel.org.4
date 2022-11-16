Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DDB662BE46
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 13:37:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238950AbiKPMhZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 07:37:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239089AbiKPMg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 07:36:57 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 887A832B9E
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 04:36:24 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id m22so43667370eji.10
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 04:36:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wJ4LXLUuVrv6zFSflxxTlPtNIH6eGmu9CDdhaBfrfx0=;
        b=A7n6QEdSnW3L7+Ik5Q4uPU1+XXtD8goFQDsGeVGFQyK9sBClQKDr1r8+ceINCFzxq4
         ZPdjxR86y7o6PECHIeKjo5SaRMfDmS2NQwIttaICi53RxavpcMhsaQxZgs9bOj/U5IIf
         EVq+j1QgCQhfLbJ2vJSOmlV66e22dPb9nt5fvdvZyd7qTDPlQOH9TbVIHdUaqI7V/Gsn
         fEwsj1sdujNCVEpQS8Q3trQxvolqWrad3Wn/8S3lii65hMjLmWije09J3QFhUtJI8LCq
         MDm8kPtT3x7nEA+E6SO8ci9yo38JtuRWiLKxhuQOM+Ai+D/8eNTsFlvZ/lKBCfop/s73
         /HrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wJ4LXLUuVrv6zFSflxxTlPtNIH6eGmu9CDdhaBfrfx0=;
        b=lWm0P+Zunb1TM9z/MySlGJU+vnkTFwHkhrJrZj34TU+kR5wLOPdUxoJkAAWrINDBYA
         o+k7sTxosHTfAtzqW+xYG7MGypUqOVnZQ/xJDwMBkV03F8+hoYGzZkbEeWbkv+V0D1H2
         1BEH53WlsDpFgqHwfTkCsMqooTfGY6BRx8+iabr/HdLgbQaMWB30fUFPc2aXrZjFQtf5
         45Tfmx9dzJx5m5eUgcEtLfAPWteOpJsZa56zTj8MaQ9mdr/mEduq1okfWHTKbx7MFpUx
         /IeuDfKM+6uZsIU/24ytQLxnbI9q23CVnChexzGHump6Z20FvvQSrxY/DdGeFEzd53No
         9Utw==
X-Gm-Message-State: ANoB5pljxDqPOBIYmVEAAp44AuotmCrymnDKRM8Wrd1rOTgErcL37/mD
        jhiJTr7BBwskZ4hQPUD6njlXgw==
X-Google-Smtp-Source: AA0mqf69fFJxYsqpCdCIH07Vnmsmmae/PINzR1v/fHy04rT9WpQycvoBe3mQcAgvzcFC8yDJB+tOsA==
X-Received: by 2002:a17:907:76ec:b0:78d:5966:b093 with SMTP id kg12-20020a17090776ec00b0078d5966b093mr18665190ejc.343.1668602183064;
        Wed, 16 Nov 2022 04:36:23 -0800 (PST)
Received: from localhost.localdomain ([194.29.137.22])
        by smtp.gmail.com with ESMTPSA id cb13-20020a170906a44d00b007abafe43c3bsm6773346ejb.86.2022.11.16.04.36.21
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 16 Nov 2022 04:36:22 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     patches@linaro.org, Konrad Dybcio <konrad.dybcio@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Subject: [PATCH v2 2/4] arm64: dts: qcom: sm8350: Add SDHCI2
Date:   Wed, 16 Nov 2022 13:36:10 +0100
Message-Id: <20221116123612.34302-2-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20221116123612.34302-1-konrad.dybcio@linaro.org>
References: <20221116123612.34302-1-konrad.dybcio@linaro.org>
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

Add and configure the SDHCI host responsible for (mostly) SD Card and
its corresponding pins' sleep states.

The setup is *literally* 1:1 with 8450 (bar SDR50/104 may not be
broken).

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
No changes in v2.

 arch/arm64/boot/dts/qcom/sm8350.dtsi | 79 ++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
index 552c0da3c479..9a118112facb 100644
--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -1761,6 +1761,46 @@ tlmm: pinctrl@f100000 {
 			gpio-ranges = <&tlmm 0 0 204>;
 			wakeup-parent = <&pdc>;
 
+			sdc2_default_state: sdc2-default-state {
+				clk-pins {
+					pins = "sdc2_clk";
+					drive-strength = <16>;
+					bias-disable;
+				};
+
+				cmd-pins {
+					pins = "sdc2_cmd";
+					drive-strength = <16>;
+					bias-pull-up;
+				};
+
+				data-pins {
+					pins = "sdc2_data";
+					drive-strength = <16>;
+					bias-pull-up;
+				};
+			};
+
+			sdc2_sleep_state: sdc2-sleep-state {
+				clk-pins {
+					pins = "sdc2_clk";
+					drive-strength = <2>;
+					bias-disable;
+				};
+
+				cmd-pins {
+					pins = "sdc2_cmd";
+					drive-strength = <2>;
+					bias-pull-up;
+				};
+
+				data-pins {
+					pins = "sdc2_data";
+					drive-strength = <2>;
+					bias-pull-up;
+				};
+			};
+
 			qup_uart3_default_state: qup-uart3-default-state {
 				rx-pins {
 					pins = "gpio18";
@@ -2329,6 +2369,45 @@ compute-cb@8 {
 			};
 		};
 
+		sdhc_2: sdhci@8804000 {
+			compatible = "qcom,sm8350-sdhci", "qcom,sdhci-msm-v5";
+			reg = <0 0x08804000 0 0x1000>;
+
+			interrupts = <GIC_SPI 207 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 223 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "hc_irq", "pwr_irq";
+
+			clocks = <&gcc GCC_SDCC2_AHB_CLK>,
+				 <&gcc GCC_SDCC2_APPS_CLK>,
+				 <&rpmhcc RPMH_CXO_CLK>;
+			clock-names = "iface", "core", "xo";
+			resets = <&gcc GCC_SDCC2_BCR>;
+			interconnects = <&aggre2_noc MASTER_SDCC_2 0 &mc_virt SLAVE_EBI1 0>,
+					<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_SDCC_2 0>;
+			interconnect-names = "sdhc-ddr","cpu-sdhc";
+			iommus = <&apps_smmu 0x4a0 0x0>;
+			power-domains = <&rpmhpd SM8350_CX>;
+			operating-points-v2 = <&sdhc2_opp_table>;
+			bus-width = <4>;
+			dma-coherent;
+
+			status = "disabled";
+
+			sdhc2_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				opp-100000000 {
+					opp-hz = /bits/ 64 <100000000>;
+					required-opps = <&rpmhpd_opp_low_svs>;
+				};
+
+				opp-202000000 {
+					opp-hz = /bits/ 64 <202000000>;
+					required-opps = <&rpmhpd_opp_svs_l1>;
+				};
+			};
+		};
+
 		usb_1_hsphy: phy@88e3000 {
 			compatible = "qcom,sm8350-usb-hs-phy",
 				     "qcom,usb-snps-hs-7nm-phy";
-- 
2.38.1

