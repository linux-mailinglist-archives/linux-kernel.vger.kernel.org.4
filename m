Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99E60697FB4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 16:40:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbjBOPk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 10:40:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbjBOPkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 10:40:16 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C41B9367E3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 07:40:13 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id he5so5819080wmb.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 07:40:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=075PiImMlYWFaRFjC0H7YdFZXk92p3CzB07R2jH1NEM=;
        b=B5nfRh2FzKSQmbdwPsBW3AnFRO1vEQhEmDVlf5Hj+XVaV+sl8LtbaFB+3rgm2dEFMq
         PP9/tdjqd9hQxqx6jaUeC1f1pcCt4ySjmiu1B5riaZYufrjV7IpP8Z6NeiGzp2v+uAzM
         vf2fODSusCv/3YjOJyQfLbjd5Dee4p/RpO3unLT/tet/iWKYJAIaeYMv4s7hs8tZz+g0
         LdxMMH/1I1jcrFA14IormodbHtFwm1UiOu3S+/0sEA8k0XHRo+mLWG/Xr1H7TKAZ8p/x
         +43bJO3lkVdfBZIT3du2uRhFMjkdaZdTv4X7FsnbrMbndfB5ZROUlTtu+fi91JQROO5E
         wmqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=075PiImMlYWFaRFjC0H7YdFZXk92p3CzB07R2jH1NEM=;
        b=Obu0/XaBKmVVwSm6aUVT73QGXRFvfJBxsAOmdP1+beutVM19m8meaq7EnHtxXg1OiX
         iYPq7T1O5aiJLwCKhqbEQTvibyHCWdeiXUZ+0l5WykRsw7KZKR4GL9lRBohilZLDnED8
         NrQxNc3HmTdU1EeEunKFf/AKFiokFPHFpNze5vo/LfTDIyOwH+xXzbB9MXvCm0kHDTFt
         IaIs7cn4ZvNmKCaXPubXSQzjuiA1WpHgjHiJ4djn6gPX8Kh1Vzb3dC5v32NmE8ppeaRe
         1Sx1nsSWRjsZD5MYW3h9l7no+BoXyMENmyX/bAdXPxaaen9+zLynAbBNJgusSTa78YgD
         qUNA==
X-Gm-Message-State: AO0yUKXLP9OzInc6cPAk4cXK5HMl87LDFWfTx1Xrq6XWP6fstbs80eal
        6wA0/9umwigUBSDZSy5wKLf2nA==
X-Google-Smtp-Source: AK7set8irxK5YD/Oucuv582cwsYSLPJxqxjYkHjbqSk32FvKrHvsyLBj9Aq1VgOXINUygKQWL0wY2g==
X-Received: by 2002:a05:600c:2e95:b0:3dd:97d6:8f2a with SMTP id p21-20020a05600c2e9500b003dd97d68f2amr2305269wmn.33.1676475612381;
        Wed, 15 Feb 2023 07:40:12 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:ea02:3f39:48c0:67ce])
        by smtp.gmail.com with ESMTPSA id j17-20020a05600c191100b003dd1c45a7b0sm2808877wmq.23.2023.02.15.07.40.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 07:40:12 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v2 4/4] arm64: dts: qcom: sa8775p: add the BT high-speed UART for sa8775p-ride
Date:   Wed, 15 Feb 2023 16:40:02 +0100
Message-Id: <20230215154002.446808-5-brgl@bgdev.pl>
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

Add the serial port connected to the Bluetooth controller on sa8775p-ride.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sa8775p-ride.dts | 33 +++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/sa8775p.dtsi     | 17 ++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
index 47cf26ea49e8..e7629cb0306c 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
+++ b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
@@ -14,6 +14,7 @@ / {
 	aliases {
 		serial0 = &uart10;
 		serial1 = &uart12;
+		serial2 = &uart17;
 		i2c18 = &i2c18;
 		spi16 = &spi16;
 	};
@@ -89,6 +90,29 @@ qup_uart12_tx: qup_uart12_tx-state {
 	qup_uart12_rx: qup_uart12_rx-state {
 		pins = "gpio55";
 		function = "qup1_se5";
+	};
+
+	qup_uart17_cts: qup-uart17-cts-state {
+		pins = "gpio91";
+		function = "qup2_se3";
+		bias-disable;
+	};
+
+	qup_uart17_rts: qup0_uart17_rts-state {
+		pins = "gpio92";
+		function = "qup2_se3";
+		bias-pull-down;
+	};
+
+	qup_uart17_tx: qup0_uart17_tx-state {
+		pins = "gpio93";
+		function = "qup2_se3";
+		bias-pull-up;
+	};
+
+	qup_uart17_rx: qup0_uart17_rx-state {
+		pins = "gpio94";
+		function = "qup2_se3";
 		bias-pull-down;
 	};
 };
@@ -109,6 +133,15 @@ &uart12 {
 	status = "okay";
 };
 
+&uart17 {
+	pinctrl-0 = <&qup_uart17_cts>,
+		    <&qup_uart17_rts>,
+		    <&qup_uart17_tx>,
+		    <&qup_uart17_rx>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
 &xo_board_clk {
 	clock-frequency = <38400000>;
 };
diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
index 8b8931ea739d..9e057a34b14f 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
+++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
@@ -539,6 +539,23 @@ &config_noc SLAVE_QUP_2 0>,
 				status = "disabled";
 			};
 
+			uart17: serial@88c000 {
+				compatible = "qcom,geni-uart";
+				reg = <0x0 0x88c000 0x0 0x4000>;
+				interrupts-extended = <&intc GIC_SPI 585 IRQ_TYPE_LEVEL_HIGH>,
+						      <&tlmm 94 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&gcc GCC_QUPV3_WRAP2_S3_CLK>;
+				clock-names = "se";
+				interconnects = <&clk_virt MASTER_QUP_CORE_2 0
+						 &clk_virt SLAVE_QUP_CORE_2 0>,
+						<&gem_noc MASTER_APPSS_PROC 0
+						 &config_noc SLAVE_QUP_2 0>;
+				interconnect-names = "qup-core",
+						     "qup-config";
+				power-domains = <&rpmhpd SA8775P_CX>;
+				status = "disabled";
+			};
+
 			i2c18: i2c@890000 {
 				compatible = "qcom,geni-i2c";
 				reg = <0x0 0x890000 0x0 0x4000>;
-- 
2.37.2

