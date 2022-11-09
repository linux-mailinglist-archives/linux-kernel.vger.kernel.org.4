Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2344622E2C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 15:42:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231646AbiKIOmN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 09:42:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231387AbiKIOmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 09:42:09 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 396CC1408D
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 06:42:05 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id g12so25903669lfh.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 06:42:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CMkwg3UOSNgMtgN2XJcpsMMMbgMvXKg9usMWTCrDWOU=;
        b=gSQN8uPnDGc1mwAOH71Dv6dCPsOcZw36/y6MZOW1Hx6fxd7yZ+CZ491SeYlKjV6d5y
         +/FB6vV29oS7q21Exb8Nt64P18YxAPAebyKhX8ynT8A2YG4ty/SMC7F+rgVl2iouoZbe
         NMY1bpZta6m+E9TgOq3LmUVHlUhqqUIcqSbO802IzRaIti2QVpI7RXW1p2mjLCWkiCTA
         BuRIV8QtLWOz1D3W5boE2RVRhuzk2j1rLttDuF2AuaJpJYgBEOk5sYK/4bTeN+IDM7oX
         qghmZegvOPgBQTYjVPiiiNREMQ7cJjR88eE4DjAHBPUec2gXSxN02p9Q1ICqVRXygs+x
         NDtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CMkwg3UOSNgMtgN2XJcpsMMMbgMvXKg9usMWTCrDWOU=;
        b=daKD5OmvLQAXkveyF3VnGF6q+lLeo/RlZ6O46tgXff4aHgJgcQ5Ih18nY/92h0KOMS
         BEvRt2MgOccJM8+y14YCv+LQxkONOTROcH61IdMVtFlApxVfU2gb0cC5ho9cY8wHHwMq
         uLu5pcFwFxcj4UjzQuTeUm9u7QZXWDWzKMFE3EUlxXwHUx1utxZkVl6rkoWXbkFRpii3
         mEUeU72MDnlPwYfnwA2LVJlI6c7e5eRyg9qABJTyLkRWkeBrswpnU9lmu08OOd2GkTch
         rprr74cYQdHKLgDd7xh6QC2kx0tv6hYoYYY7AxJm02EQgFsQJ+hBGWFNHZmbmt4PVjvd
         AuFw==
X-Gm-Message-State: ACrzQf3wYLRuXN0NPIlnjtmDPzSvTOvUODshc/Eeqcmi8bRw3qnXxJnx
        EAcm5bOA69o/H7o87YDiI1+g0Q==
X-Google-Smtp-Source: AMsMyM78Rg1WNByl2t4OsGrVMUZFhE5n8yNJ87ipA406xzFTDq604Sh8MeNW3kpjD7t8t4wRXpI5uQ==
X-Received: by 2002:ac2:5933:0:b0:4a2:b77e:6228 with SMTP id v19-20020ac25933000000b004a2b77e6228mr20733125lfi.221.1668004923579;
        Wed, 09 Nov 2022 06:42:03 -0800 (PST)
Received: from localhost.localdomain ([194.29.137.22])
        by smtp.gmail.com with ESMTPSA id q10-20020a056512210a00b004a478c2f4desm2235229lfr.163.2022.11.09.06.42.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 09 Nov 2022 06:42:03 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     patches@linaro.org, Konrad Dybcio <konrad.dybcio@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] arm64: dts: qcom: sm6375: Add SDHCI2
Date:   Wed,  9 Nov 2022 15:41:52 +0100
Message-Id: <20221109144153.53630-3-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20221109144153.53630-1-konrad.dybcio@linaro.org>
References: <20221109144153.53630-1-konrad.dybcio@linaro.org>
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

Configure the second SDHCI bus controller, which usually the
interface used for SD cards.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Changes since v1:
- use mmc@ node name instead of sdhci@

 arch/arm64/boot/dts/qcom/sm6375.dtsi | 82 ++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6375.dtsi b/arch/arm64/boot/dts/qcom/sm6375.dtsi
index 6adffd927a8e..08587c8681b2 100644
--- a/arch/arm64/boot/dts/qcom/sm6375.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6375.dtsi
@@ -540,6 +540,46 @@ tlmm: pinctrl@500000 {
 			#interrupt-cells = <2>;
 			#gpio-cells = <2>;
 
+			sdc2_off_state: sdc2-off-state {
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
+			sdc2_on_state: sdc2-on-state {
+				clk-pins {
+					pins = "sdc2_clk";
+					drive-strength = <16>;
+					bias-disable;
+				};
+
+				cmd-pins {
+					pins = "sdc2_cmd";
+					drive-strength = <10>;
+					bias-pull-up;
+				};
+
+				data-pins {
+					pins = "sdc2_data";
+					drive-strength = <10>;
+					bias-pull-up;
+				};
+			};
+
 			qup_i2c0_default: qup-i2c0-default-state {
 				pins = "gpio0", "gpio1";
 				function = "qup00";
@@ -630,6 +670,48 @@ rpm_msg_ram: sram@45f0000 {
 			reg = <0 0x045f0000 0 0x7000>;
 		};
 
+		sdhc_2: mmc@4784000 {
+			compatible = "qcom,sm6375-sdhci", "qcom,sdhci-msm-v5";
+			reg = <0 0x04784000 0 0x1000>;
+
+			interrupts = <GIC_SPI 350 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 353 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "hc_irq", "pwr_irq";
+
+			clocks = <&gcc GCC_SDCC2_AHB_CLK>,
+				 <&gcc GCC_SDCC2_APPS_CLK>,
+				 <&rpmcc RPM_SMD_XO_CLK_SRC>;
+			clock-names = "iface", "core", "xo";
+			resets = <&gcc GCC_SDCC2_BCR>;
+			iommus = <&apps_smmu 0x40 0x0>;
+
+			pinctrl-0 = <&sdc2_on_state>;
+			pinctrl-1 = <&sdc2_off_state>;
+			pinctrl-names = "default", "sleep";
+
+			qcom,dll-config = <0x0007642c>;
+			qcom,ddr-config = <0x80040868>;
+			power-domains = <&rpmpd SM6375_VDDCX>;
+			operating-points-v2 = <&sdhc2_opp_table>;
+			bus-width = <4>;
+
+			status = "disabled";
+
+			sdhc2_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				opp-100000000 {
+					opp-hz = /bits/ 64 <100000000>;
+					required-opps = <&rpmpd_opp_low_svs>;
+				};
+
+				opp-202000000 {
+					opp-hz = /bits/ 64 <202000000>;
+					required-opps = <&rpmpd_opp_svs_plus>;
+				};
+			};
+		};
+
 		gpi_dma0: dma-controller@4a00000 {
 			compatible = "qcom,sm6375-gpi-dma", "qcom,sm6350-gpi-dma";
 			reg = <0 0x04a00000 0 0x60000>;
-- 
2.38.1

