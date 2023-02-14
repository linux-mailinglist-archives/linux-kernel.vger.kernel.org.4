Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 572AD696898
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 16:57:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233217AbjBNP5c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 10:57:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233212AbjBNP51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 10:57:27 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B4F4279BF
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 07:57:23 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id j29-20020a05600c1c1d00b003dc52fed235so11976445wms.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 07:57:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EVFIEvz89X8+njJ854cL83jhIhfm54rA1V6D66stgfk=;
        b=xXFINKn04myxAsiwHti7QVRpKV8wSaHu9KqUKk9QHNlGAoJkoqlZq6PuQ7IwpfnH4u
         VkcAIbPAXAY9us6juhgArimBxqfRYjmcCtQa7J9JK/EjSX54QzIBkQrTvgEICwfb474o
         4MyLbEHUb9f597eA+1Xe0Wr0D1QH4KhnODQZEkYRh1WcrgVxuSllhQ/8jhgUwjZlazWi
         GIB6b/JVnu13RdyCXQUKX7Di3lccVCfHeIqOBV6SwwGssADAkn9lMMtQpGAA+qUYs6Sw
         yfoI6PV4V98JLLPsuL4ENIeD5fiBYHt5hU8JVAm29mVE9vC69oKXsL0qswk1k3v+GDCN
         dLvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EVFIEvz89X8+njJ854cL83jhIhfm54rA1V6D66stgfk=;
        b=UHKJwIb8CyM9aZShK8uG0rVFrRRlZ0aSoIbh7Z3H5kBPwmNiJ7G10EZSfOxYVG1JjS
         s/YzQrOedWkMZcTf38Fy8oSfczzY0w6PNjVNXFzgTxQYIk/Q5ap4zeW5D2HKKDxD3Z2k
         fsEhGjM5F5e51YrBcGd4iKe0p8ktKrYvqAflETOYJQctbR9JpUA8cQjQA9spIUfR+3+c
         ME8cUyUpF26ciInfHTsxGEZV2b+DV+hFH4nO1snxuj7RfZLcEbSsLlwQEiTXZ8TwM1zD
         yhODJQqjLwE2lyJ+2GXzr13P6QKcj5jRpkhnYJYbUlRy2FjO5ZAC01SdN/UITa3ZGtqe
         sODw==
X-Gm-Message-State: AO0yUKVTTluRJEoHAsAiY66TqlX91XQIzAohyhiExn5BLecdmm7l4O6W
        T7YxxAKRvsezjLqzBvEjpTYRsg==
X-Google-Smtp-Source: AK7set+ai6AJ3UF7a97IgvHmoRm72GgmhAvMUUlet2bfyo4Nve4URVkx/HcPojcZjOgBJOkm8w6tXw==
X-Received: by 2002:a05:600c:1c17:b0:3dc:de85:5007 with SMTP id j23-20020a05600c1c1700b003dcde855007mr2480329wms.21.1676390242054;
        Tue, 14 Feb 2023 07:57:22 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:6e4b:bef:7edd:1af1])
        by smtp.gmail.com with ESMTPSA id x2-20020a1c7c02000000b003df30c94850sm20451924wmc.25.2023.02.14.07.57.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 07:57:21 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 3/3] arm64: dts: qcom: sa8775p: add the GNSS high-speed UART for sa8775p-ride
Date:   Tue, 14 Feb 2023 16:57:15 +0100
Message-Id: <20230214155715.451130-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230214155715.451130-1-brgl@bgdev.pl>
References: <20230214155715.451130-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
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
 arch/arm64/boot/dts/qcom/sa8775p.dtsi     | 17 ++++++++++++
 2 files changed, 51 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
index d01ca3a9ee37..9aee6e4c1ba1 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
+++ b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
@@ -13,6 +13,7 @@ / {
 
 	aliases {
 		serial0 = &uart10;
+		serial1 = &uart17;
 		i2c18 = &i2c18;
 		spi16 = &spi16;
 	};
@@ -66,6 +67,30 @@ qup_i2c18_default: qup-i2c18-state {
 		drive-strength = <2>;
 		bias-pull-up;
 	};
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
+		bias-pull-down;
+	};
 };
 
 &uart10 {
@@ -75,6 +100,15 @@ &uart10 {
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
index 1abb545ff4f4..b009e1100c0a 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
+++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
@@ -524,6 +524,23 @@ &config_noc SLAVE_QUP_2 0>,
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

