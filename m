Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09E2E65C617
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 19:25:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238787AbjACSYo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 13:24:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238561AbjACSYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 13:24:16 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56CB113EA2
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 10:22:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672770172;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZKLP2VlAI1zSwLBLCdzn4XXvDmaNfVcksuoQpwTA03o=;
        b=dAgdoULO32DGjDRGmC5/4PqNVJLVIVnk7UbH6hGRTK0Ywrxu5M9/5FAQzpugOjQK5VUHDb
        DtfAkqcLcfxjfmW/kaRbn8gnOvDG809C7bc8unKp+TZZFszvlZbULy6HdVrR36l850jF5E
        JagjBX8/X8QIlwh2YBJgrMl4ljqJluw=
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-479-csA-VvJZOE6xwYLhynB_Wg-1; Tue, 03 Jan 2023 13:22:51 -0500
X-MC-Unique: csA-VvJZOE6xwYLhynB_Wg-1
Received: by mail-ua1-f71.google.com with SMTP id o43-20020ab0596e000000b0038421e4c7deso10316157uad.19
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 10:22:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZKLP2VlAI1zSwLBLCdzn4XXvDmaNfVcksuoQpwTA03o=;
        b=Y6DKOmSQmMGS/kWL/MqrcELnAV0VSl1kvGW7Iu//lYCLfKMpDhx3SMQ7Je+gINsyVz
         9hwpSkxYB1N4yWgQykPr0crM+a40pvciPQavBm6Q8k+IgTweC4XG0D3oIoWKHabfAUgV
         xbsNH+pE2RQ1iUtGrZfP/IN24OiP/qWfUVrjip8d659FlMeKjEYo/INLGLS2JfSv0n6F
         CBbyQnXNsO93srrol54FXnqn4xuo9S8wZuwSKNL66UvUGAGG7M6awg6o1LqfgXj1Pere
         Ov1eTP6Anovlq8cycPBV0oJRLQ3Ip9wlAWmdzubpl4jfiTkIlq3Vr/ylwx4i6NlEntux
         JDsA==
X-Gm-Message-State: AFqh2koOODQhvkf4cdtIjVSXkk6hLyZ5GAzJwfYDrV9dUPYom6xHSozt
        hDOI3Uk6O6O3v8zAjLtXrFV+xG1+Mdb0KCMUUWFRL/A4YVAdX+nwD8nSLIrIdRk8tlVLI95syxS
        LhARiWv2RzTaf2zGy46Ejlzcm
X-Received: by 2002:a1f:9f8e:0:b0:3bd:c428:c22b with SMTP id i136-20020a1f9f8e000000b003bdc428c22bmr25140899vke.4.1672770171040;
        Tue, 03 Jan 2023 10:22:51 -0800 (PST)
X-Google-Smtp-Source: AMrXdXs9+H7tl+HzgNXlhNw7BH4C7Nzq7y2pUXgXHVY+W2V1Y/8mMyVTk3FkLbhuojWbKyEp2rWQtQ==
X-Received: by 2002:a1f:9f8e:0:b0:3bd:c428:c22b with SMTP id i136-20020a1f9f8e000000b003bdc428c22bmr25140884vke.4.1672770170726;
        Tue, 03 Jan 2023 10:22:50 -0800 (PST)
Received: from x1.. (c-73-214-169-22.hsd1.pa.comcast.net. [73.214.169.22])
        by smtp.gmail.com with ESMTPSA id t13-20020a05620a450d00b006fba0a389a4sm22819675qkp.88.2023.01.03.10.22.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 10:22:49 -0800 (PST)
From:   Brian Masney <bmasney@redhat.com>
To:     andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     quic_shazhuss@quicinc.com, robh+dt@kernel.org,
        konrad.dybcio@linaro.org, johan+linaro@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ahalaney@redhat.com,
        echanude@redhat.co
Subject: [PATCH v4 05/10] arm64: dts: qcom: sc8280xp: rename qup0_i2c4 to i2c4
Date:   Tue,  3 Jan 2023 13:22:24 -0500
Message-Id: <20230103182229.37169-6-bmasney@redhat.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230103182229.37169-1-bmasney@redhat.com>
References: <20230103182229.37169-1-bmasney@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for adding the missing SPI and I2C nodes to
sc8280xp.dtsi, it was decided to rename all of the existing qupX_
uart, spi, and i2c nodes to drop the qupX_ prefix. Let's go ahead
and rename qup0_i2c4 to i2c4.

Note that some nodes are moved in the file by this patch to preserve
the expected sort order in the file. Additionally, the properties
within the pinctrl state node are sorted to match the expected order
that's typically done in other DTs.

Signed-off-by: Brian Masney <bmasney@redhat.com>
Link: https://lore.kernel.org/lkml/20221212182314.1902632-1-bmasney@redhat.com/
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
Tested-by: Steev Klimaszewski <steev@kali.org>
---
No changes in v4

 arch/arm64/boot/dts/qcom/sc8280xp-crd.dts     | 57 +++++++++---------
 .../qcom/sc8280xp-lenovo-thinkpad-x13s.dts    | 58 +++++++++----------
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi        |  2 +-
 3 files changed, 58 insertions(+), 59 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
index 03e3814f2722..dfd8c42d8ca0 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
@@ -228,6 +228,27 @@ vreg_l9d: ldo9 {
 	};
 };
 
+&i2c4 {
+	clock-frequency = <400000>;
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c4_default>;
+
+	status = "okay";
+
+	touchscreen@10 {
+		compatible = "hid-over-i2c";
+		reg = <0x10>;
+
+		hid-descr-addr = <0x1>;
+		interrupts-extended = <&tlmm 175 IRQ_TYPE_LEVEL_LOW>;
+		vdd-supply = <&vreg_misc_3p3>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&ts0_default>;
+	};
+};
+
 &i2c21 {
 	clock-frequency = <400000>;
 
@@ -334,27 +355,6 @@ &qup0 {
 	status = "okay";
 };
 
-&qup0_i2c4 {
-	clock-frequency = <400000>;
-
-	pinctrl-names = "default";
-	pinctrl-0 = <&qup0_i2c4_default>;
-
-	status = "okay";
-
-	touchscreen@10 {
-		compatible = "hid-over-i2c";
-		reg = <0x10>;
-
-		hid-descr-addr = <0x1>;
-		interrupts-extended = <&tlmm 175 IRQ_TYPE_LEVEL_LOW>;
-		vdd-supply = <&vreg_misc_3p3>;
-
-		pinctrl-names = "default";
-		pinctrl-0 = <&ts0_default>;
-	};
-};
-
 &qup1 {
 	status = "okay";
 };
@@ -494,6 +494,13 @@ hastings_reg_en: hastings-reg-en-state {
 &tlmm {
 	gpio-reserved-ranges = <74 6>, <83 4>, <125 2>, <128 2>, <154 7>;
 
+	i2c4_default: i2c4-default-state {
+		pins = "gpio171", "gpio172";
+		function = "qup4";
+		drive-strength = <16>;
+		bias-disable;
+	};
+
 	i2c21_default: i2c21-default-state {
 		pins = "gpio81", "gpio82";
 		function = "qup21";
@@ -597,14 +604,6 @@ wake-n-pins {
 		};
 	};
 
-	qup0_i2c4_default: qup0-i2c4-default-state {
-		pins = "gpio171", "gpio172";
-		function = "qup4";
-
-		bias-disable;
-		drive-strength = <16>;
-	};
-
 	tpad_default: tpad-default-state {
 		int-n-pins {
 			pins = "gpio182";
diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
index ad66a87141be..2c360e52dae5 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
@@ -282,6 +282,28 @@ vreg_l9d: ldo9 {
 	};
 };
 
+&i2c4 {
+	clock-frequency = <400000>;
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c4_default>;
+
+	status = "okay";
+
+	/* FIXME: verify */
+	touchscreen@10 {
+		compatible = "hid-over-i2c";
+		reg = <0x10>;
+
+		hid-descr-addr = <0x1>;
+		interrupts-extended = <&tlmm 175 IRQ_TYPE_LEVEL_LOW>;
+		vdd-supply = <&vreg_misc_3p3>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&ts0_default>;
+	};
+};
+
 &i2c21 {
 	clock-frequency = <400000>;
 
@@ -554,28 +576,6 @@ &qup0 {
 	status = "okay";
 };
 
-&qup0_i2c4 {
-	clock-frequency = <400000>;
-
-	pinctrl-names = "default";
-	pinctrl-0 = <&qup0_i2c4_default>;
-
-	status = "okay";
-
-	/* FIXME: verify */
-	touchscreen@10 {
-		compatible = "hid-over-i2c";
-		reg = <0x10>;
-
-		hid-descr-addr = <0x1>;
-		interrupts-extended = <&tlmm 175 IRQ_TYPE_LEVEL_LOW>;
-		vdd-supply = <&vreg_misc_3p3>;
-
-		pinctrl-names = "default";
-		pinctrl-0 = <&ts0_default>;
-	};
-};
-
 &qup1 {
 	status = "okay";
 };
@@ -698,6 +698,13 @@ hall_int_n_default: hall-int-n-state {
 		bias-disable;
 	};
 
+	i2c4_default: i2c4-default-state {
+		pins = "gpio171", "gpio172";
+		function = "qup4";
+		drive-strength = <16>;
+		bias-disable;
+	};
+
 	i2c21_default: i2c21-default-state {
 		pins = "gpio81", "gpio82";
 		function = "qup21";
@@ -801,13 +808,6 @@ wake-n-pins {
 		};
 	};
 
-	qup0_i2c4_default: qup0-i2c4-default-state {
-		pins = "gpio171", "gpio172";
-		function = "qup4";
-		bias-disable;
-		drive-strength = <16>;
-	};
-
 	tpad_default: tpad-default-state {
 		int-n-pins {
 			pins = "gpio182";
diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
index d4a7a4c3fdee..6f652ec9cfb1 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
@@ -858,7 +858,7 @@ qup0: geniqup@9c0000 {
 
 			status = "disabled";
 
-			qup0_i2c4: i2c@990000 {
+			i2c4: i2c@990000 {
 				compatible = "qcom,geni-i2c";
 				reg = <0 0x00990000 0 0x4000>;
 				#address-cells = <1>;
-- 
2.39.0

