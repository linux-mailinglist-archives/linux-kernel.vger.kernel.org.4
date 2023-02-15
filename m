Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78119697FB3
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 16:40:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbjBOPkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 10:40:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbjBOPkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 10:40:16 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E56E5E398
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 07:40:12 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id k8-20020a05600c1c8800b003dc57ea0dfeso1933195wms.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 07:40:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AdnjpOdJAMHVLdPdxFho8dG1WvHp5HoPzZyrAfKLUyU=;
        b=7BU7RnXXKEVo535IajHNoKPiziRSRrHfvBOnt9f34nOiu52UcvVHbdnCGN45CYs+7K
         Wi6eWquiLiNtYWGjy8RZK5k3GJT2qM2XZfOg/DW2a8lvmJ9+1Es6G0u6rhw0nEWR03jc
         NrrGAERDpXGDgY/vkn+VWOsWV7/3TyFT0C/37Rxd68L16yNILMc2GqfYrbFMrhIM9OmE
         gjy8TwKLj9X4qRqHjFZp/zVgQFc3qCme+Bakv64cSkdivJ55sW4aYFKCLMR7qLgbFv5U
         CSnJ7w8wZqtZ23scfQoQXMVjCzesw274t4Nw9CEgPaQE4k9r2++Z7CMahLi1RsMdd25b
         LcIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AdnjpOdJAMHVLdPdxFho8dG1WvHp5HoPzZyrAfKLUyU=;
        b=VmotUf9UVCgCmOWjI9+K2hhliTaXjZCyqpw2PAGzO19at4kqjLamOzkkvUsHyvGPIJ
         kZ+m49cM0vtpDEIzpk8oJKRNAktzcWsoNP/99q3ra8NM2GUrhmcILYWA1B1lpufXs0ci
         /fir8YLaE6szQ/D+9im9cWmve7L3eI/2Zgvf56OTGL7cvFJ5ZLF0mcLSVyCeUfSlnLYb
         77QP+HqO14uVtnOharfXtkcTqZM/bJXuSzko4m8aDom9uuZzJtwAQRxysu8tBViGyJq8
         j9FCydVgVBYjmS5y02vfSRLjG+azYLowuNa6VE25U6vKeNX3rxQMd0p06CJSovaKDjRz
         wS7w==
X-Gm-Message-State: AO0yUKVFTU+VSrbeC5Ip+VRNmaaKjLtk/J7wjTehcGi+N26mQzMj6OGi
        peD/7LOg7CJgXclR4fdCrLXVBQ==
X-Google-Smtp-Source: AK7set+oxNs+lZ7ExvulPFQkDQk2yzvUPa1pOZ1JGXk53Q4g0EGuSMsQb3I4GbPejCEnvlCgu5ubiQ==
X-Received: by 2002:a05:600c:4da2:b0:3dc:561a:79e7 with SMTP id v34-20020a05600c4da200b003dc561a79e7mr2252539wmp.2.1676475611386;
        Wed, 15 Feb 2023 07:40:11 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:ea02:3f39:48c0:67ce])
        by smtp.gmail.com with ESMTPSA id j17-20020a05600c191100b003dd1c45a7b0sm2808877wmq.23.2023.02.15.07.40.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 07:40:11 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v2 3/4] arm64: dts: qcom: sa8775p: add the GNSS high-speed UART for sa8775p-ride
Date:   Wed, 15 Feb 2023 16:40:01 +0100
Message-Id: <20230215154002.446808-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230215154002.446808-1-brgl@bgdev.pl>
References: <20230215154002.446808-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Add the serial port connected to the GNSS on sa8775p-ride.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sa8775p-ride.dts | 34 +++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/sa8775p.dtsi     | 15 ++++++++++
 2 files changed, 49 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
index d01ca3a9ee37..47cf26ea49e8 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
+++ b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
@@ -13,6 +13,7 @@ / {
 
 	aliases {
 		serial0 = &uart10;
+		serial1 = &uart12;
 		i2c18 = &i2c18;
 		spi16 = &spi16;
 	};
@@ -66,6 +67,30 @@ qup_i2c18_default: qup-i2c18-state {
 		drive-strength = <2>;
 		bias-pull-up;
 	};
+
+	qup_uart12_cts: qup-uart12-cts-state {
+		pins = "gpio52";
+		function = "qup1_se5";
+		bias-disable;
+	};
+
+	qup_uart12_rts: qup_uart12_rts-state {
+		pins = "gpio53";
+		function = "qup1_se5";
+		bias-pull-down;
+	};
+
+	qup_uart12_tx: qup_uart12_tx-state {
+		pins = "gpio54";
+		function = "qup1_se5";
+		bias-pull-up;
+	};
+
+	qup_uart12_rx: qup_uart12_rx-state {
+		pins = "gpio55";
+		function = "qup1_se5";
+		bias-pull-down;
+	};
 };
 
 &uart10 {
@@ -75,6 +100,15 @@ &uart10 {
 	status = "okay";
 };
 
+&uart12 {
+	pinctrl-0 = <&qup_uart12_cts>,
+		    <&qup_uart12_rts>,
+		    <&qup_uart12_tx>,
+		    <&qup_uart12_rx>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
 &xo_board_clk {
 	clock-frequency = <38400000>;
 };
diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
index 1abb545ff4f4..8b8931ea739d 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
+++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
@@ -489,6 +489,21 @@ &clk_virt SLAVE_QUP_CORE_1 0>,
 				operating-points-v2 = <&qup_opp_table_100mhz>;
 				status = "disabled";
 			};
+
+			uart12: serial@a94000 {
+				compatible = "qcom,geni-uart";
+				reg = <0x0 0xa94000 0x0 0x4000>;
+				interrupts = <GIC_SPI 585 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&gcc GCC_QUPV3_WRAP1_S5_CLK>;
+				clock-names = "se";
+				interconnects = <&clk_virt MASTER_QUP_CORE_1 0
+						 &clk_virt SLAVE_QUP_CORE_1 0>,
+						<&gem_noc MASTER_APPSS_PROC 0
+						 &config_noc SLAVE_QUP_1 0>;
+				interconnect-names = "qup-core", "qup-config";
+				power-domains = <&rpmhpd SA8775P_CX>;
+				status = "disabled";
+			};
 		};
 
 		qupv3_id_2: geniqup@8c0000 {
-- 
2.37.2

