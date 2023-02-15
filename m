Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2EB6697FB2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 16:40:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbjBOPkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 10:40:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbjBOPkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 10:40:15 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9D2A3645C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 07:40:11 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id m20-20020a05600c3b1400b003e1e754657aso1894947wms.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 07:40:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DA8FtU5k5fQCyhIkgC0GoFOKfitMelFiT63AH7hnguA=;
        b=KdTB2/Gice8LYygsxPRk1Ylt9pWBHnczHG+LcUf+YDeq8pJhZ59pH5sRDlVj3juw3B
         g7mlzInsC00mIpC7vsTNDATzZEfnpFnIoK6SQFHid97CTA/Wgg1TrjFHNFjGV4myaEb0
         Q2j0onVCIutAfw1ntA3fMDZbWLOACjkIuNF+U/TmSdBXNu8OmfqTUVw1uwca3dWq6Him
         OX1mmZycBtvXSqR3AO5YJIbtneBf/PBHJyScIdRUed7KUWISbanVOzGF7y9/lcrkx4LU
         J9DvI4idJKBOJC3A66TRubOx9P54Oi+X68wovMqMZPK8Fs15Oxdw4EKXSgFh6QmvCAjr
         FORw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DA8FtU5k5fQCyhIkgC0GoFOKfitMelFiT63AH7hnguA=;
        b=gLJ6CAbFhewXg51TeyIrt2WDdJyeZjqlBwPWBsHefwHacF9FHIeKtHYcQbHBRRJmFU
         NL3XrwFiorDnLau+CchjXjpawn9DX02p+W/aHe1qWwgaHoSoOeUccVBUFfVKS3VqXQVT
         EsQMC3bofl3bA2qq2cmgvHriHZrG2w3LKDrCTUCmfrkgBYxGjZq8nVwIzn7FAa8eqUm8
         ZnjFeEn11rggFFQDL7d7cLEFmoHzUmEslL9XCppIBj6ZN+uFMv9IhVy6ziODb48T9+2K
         aR9Hcpa36NSb/t9iCnI/DvQMR8RSyFu5AKIDMkhwuA/Z1M9U6eSKeHekNud47w91Yvxv
         mmsQ==
X-Gm-Message-State: AO0yUKX+KJHGOcKeHyHXKIalYuVjnEqcVPN5hVDFMBiE945s2kzrM9+h
        UpgF0DVtidkREY3i1TDF+mLxjA==
X-Google-Smtp-Source: AK7set9Pr77LG1ZbdGrX3RCk/pN0JoVgs/gPvV942uNRZeGD4Nb1DEDt3APT+V4SjLhHzhP5p147IA==
X-Received: by 2002:a05:600c:1c11:b0:3db:331b:bd57 with SMTP id j17-20020a05600c1c1100b003db331bbd57mr2281043wms.23.1676475610502;
        Wed, 15 Feb 2023 07:40:10 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:ea02:3f39:48c0:67ce])
        by smtp.gmail.com with ESMTPSA id j17-20020a05600c191100b003dd1c45a7b0sm2808877wmq.23.2023.02.15.07.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 07:40:10 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v2 2/4] arm64: dts: qcom: sa8775p: add the SPI node for sa8775p-ride
Date:   Wed, 15 Feb 2023 16:40:00 +0100
Message-Id: <20230215154002.446808-3-brgl@bgdev.pl>
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

Add the SPI node for the interface exposed on the sa8775p-ride board.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sa8775p-ride.dts | 14 ++++++++++++++
 arch/arm64/boot/dts/qcom/sa8775p.dtsi     | 21 +++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
index 5fdce8279537..d01ca3a9ee37 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
+++ b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
@@ -14,6 +14,7 @@ / {
 	aliases {
 		serial0 = &uart10;
 		i2c18 = &i2c18;
+		spi16 = &spi16;
 	};
 
 	chosen {
@@ -40,12 +41,25 @@ &sleep_clk {
 	clock-frequency = <32764>;
 };
 
+&spi16 {
+	pinctrl-0 = <&qup_spi16_default>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
 &tlmm {
 	qup_uart10_default: qup-uart10-state {
 		pins = "gpio46", "gpio47";
 		function = "qup1_se3";
 	};
 
+	qup_spi16_default: qup-spi16-state {
+		pins = "gpio86", "gpio87", "gpio88", "gpio89";
+		function = "qup2_se2";
+		drive-strength = <6>;
+		bias-disable;
+	};
+
 	qup_i2c18_default: qup-i2c18-state {
 		pins = "gpio95", "gpio96";
 		function = "qup2_se4";
diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
index 82582825f92a..1abb545ff4f4 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
+++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
@@ -503,6 +503,27 @@ qupv3_id_2: geniqup@8c0000 {
 			iommus = <&apps_smmu 0x5a3 0x0>;
 			status = "disabled";
 
+			spi16: spi@888000 {
+				compatible = "qcom,geni-spi";
+				reg = <0x0 0x888000 0x0 0x4000>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				interrupts = <GIC_SPI 584 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&gcc GCC_QUPV3_WRAP2_S2_CLK>;
+				clock-names = "se";
+				interconnects = <&clk_virt MASTER_QUP_CORE_2 0
+						 &clk_virt SLAVE_QUP_CORE_2 0>,
+						<&gem_noc MASTER_APPSS_PROC 0
+						 &config_noc SLAVE_QUP_2 0>,
+						<&aggre2_noc MASTER_QUP_2 0
+						 &mc_virt SLAVE_EBI1 0>;
+				interconnect-names = "qup-core",
+						     "qup-config",
+						     "qup-memory";
+				power-domains = <&rpmhpd SA8775P_CX>;
+				status = "disabled";
+			};
+
 			i2c18: i2c@890000 {
 				compatible = "qcom,geni-i2c";
 				reg = <0x0 0x890000 0x0 0x4000>;
-- 
2.37.2

