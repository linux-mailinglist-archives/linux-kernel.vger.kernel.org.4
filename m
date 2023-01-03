Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD7BD65C614
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 19:25:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238832AbjACSYw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 13:24:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238743AbjACSYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 13:24:16 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8526A13EA1
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 10:22:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672770170;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rftdAraMbWM0vRnSghO9fSRiwl5EDLk1MoH5BKJdYxg=;
        b=QVBJZ7JbyC3FOccS6jATljWfVJN9oXs5h1zeiQ9JXvapAy1mD5uJrqzHzyzHu8jlubuNZI
        zIQwnSUf1CpMgA4EmKkdTh2LAtisWsPd+auVmQl+UWbU4eLKJB1bQPS5uPnv1WpNtXpWGQ
        X6LmikoVkfVxXQwsAIIZao/F+KNVHfc=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-650-vK54D2CLM_i6EDC0s_k7bw-1; Tue, 03 Jan 2023 13:22:49 -0500
X-MC-Unique: vK54D2CLM_i6EDC0s_k7bw-1
Received: by mail-qk1-f199.google.com with SMTP id l16-20020a05620a28d000b00704af700820so21164592qkp.5
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 10:22:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rftdAraMbWM0vRnSghO9fSRiwl5EDLk1MoH5BKJdYxg=;
        b=5mHSsB1FdkGaveX7/YFXwQiJ0jpklp2NEq5rWE63WKFgviR/XdnnjaRnmi08B72bxd
         7lfScoriWsyvvEog2mwy1sBlXRp8GLFBHX9g13Bu+grNbnjto5I3KDgW9LpGUZY5uRIj
         W7+yhf1wxFv/vbMvz8IlSKbOylGNWCkpx6jzBPTav0vavj+GUGVHsdX2jCtOkXzfrups
         wa09OEOlXyL1ATKWjJT3ljeneV7s0IpQ2kYHU2VtX1CSJ5qiDh3REr/CRXWCfHd9fNKZ
         YGvyJfs+Li0lejLUOJdJJpo3+/o4EDa0h8oc9k5ATcrhpCpRJ0zKaiiuL8WQdR5fsNPY
         bUsQ==
X-Gm-Message-State: AFqh2krkTz5blMQJ0/x0WZhkT3DNR3Odf2IXrzDwrFPGkcE3zQ/DU7+j
        w9UL/HKVO6VwKeRnCf5LB1TJn9Ys2I81RyOQMTdFzIvCsP9Zja790T4L+jRw/sSQCBSIEt4Qj8f
        AIoWa59WKRtQxGGEku6a832XY
X-Received: by 2002:a05:622a:2509:b0:3a9:80bf:83c0 with SMTP id cm9-20020a05622a250900b003a980bf83c0mr65149795qtb.2.1672770168959;
        Tue, 03 Jan 2023 10:22:48 -0800 (PST)
X-Google-Smtp-Source: AMrXdXu9a0xnAhkKluE53tVSxDUcw1QVatibU28o9ldtbL+4gUktyTGPdK68ozq48nB/9l/zU02b5A==
X-Received: by 2002:a05:622a:2509:b0:3a9:80bf:83c0 with SMTP id cm9-20020a05622a250900b003a980bf83c0mr65149776qtb.2.1672770168706;
        Tue, 03 Jan 2023 10:22:48 -0800 (PST)
Received: from x1.. (c-73-214-169-22.hsd1.pa.comcast.net. [73.214.169.22])
        by smtp.gmail.com with ESMTPSA id t13-20020a05620a450d00b006fba0a389a4sm22819675qkp.88.2023.01.03.10.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 10:22:48 -0800 (PST)
From:   Brian Masney <bmasney@redhat.com>
To:     andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     quic_shazhuss@quicinc.com, robh+dt@kernel.org,
        konrad.dybcio@linaro.org, johan+linaro@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ahalaney@redhat.com,
        echanude@redhat.co
Subject: [PATCH v4 04/10] arm64: dts: qcom: sc8280xp: rename qup2_i2c5 to i2c21
Date:   Tue,  3 Jan 2023 13:22:23 -0500
Message-Id: <20230103182229.37169-5-bmasney@redhat.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230103182229.37169-1-bmasney@redhat.com>
References: <20230103182229.37169-1-bmasney@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for adding the missing SPI and I2C nodes to
sc8280xp.dtsi, it was decided to rename all of the existing qupX_
uart, spi, and i2c nodes to drop the qupX_ prefix. Let's go ahead
and rename qup2_i2c5 to i2c21. Under the old name, this was the 5th
index under qup2, which starts at index 16.

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

 arch/arm64/boot/dts/qcom/sc8280xp-crd.dts     |  89 +++++++------
 .../qcom/sc8280xp-lenovo-thinkpad-x13s.dts    | 120 +++++++++---------
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi        |   2 +-
 3 files changed, 105 insertions(+), 106 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
index db273face248..03e3814f2722 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
@@ -228,6 +228,43 @@ vreg_l9d: ldo9 {
 	};
 };
 
+&i2c21 {
+	clock-frequency = <400000>;
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c21_default>;
+
+	status = "okay";
+
+	touchpad@15 {
+		compatible = "hid-over-i2c";
+		reg = <0x15>;
+
+		hid-descr-addr = <0x1>;
+		interrupts-extended = <&tlmm 182 IRQ_TYPE_LEVEL_LOW>;
+		vdd-supply = <&vreg_misc_3p3>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&tpad_default>;
+
+		wakeup-source;
+	};
+
+	keyboard@68 {
+		compatible = "hid-over-i2c";
+		reg = <0x68>;
+
+		hid-descr-addr = <0x1>;
+		interrupts-extended = <&tlmm 104 IRQ_TYPE_LEVEL_LOW>;
+		vdd-supply = <&vreg_misc_3p3>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&kybd_default>;
+
+		wakeup-source;
+	};
+};
+
 &pcie2a {
 	perst-gpios = <&tlmm 143 GPIO_ACTIVE_LOW>;
 	wake-gpios = <&tlmm 145 GPIO_ACTIVE_LOW>;
@@ -326,43 +363,6 @@ &qup2 {
 	status = "okay";
 };
 
-&qup2_i2c5 {
-	clock-frequency = <400000>;
-
-	pinctrl-names = "default";
-	pinctrl-0 = <&qup2_i2c5_default>;
-
-	status = "okay";
-
-	touchpad@15 {
-		compatible = "hid-over-i2c";
-		reg = <0x15>;
-
-		hid-descr-addr = <0x1>;
-		interrupts-extended = <&tlmm 182 IRQ_TYPE_LEVEL_LOW>;
-		vdd-supply = <&vreg_misc_3p3>;
-
-		pinctrl-names = "default";
-		pinctrl-0 = <&tpad_default>;
-
-		wakeup-source;
-	};
-
-	keyboard@68 {
-		compatible = "hid-over-i2c";
-		reg = <0x68>;
-
-		hid-descr-addr = <0x1>;
-		interrupts-extended = <&tlmm 104 IRQ_TYPE_LEVEL_LOW>;
-		vdd-supply = <&vreg_misc_3p3>;
-
-		pinctrl-names = "default";
-		pinctrl-0 = <&kybd_default>;
-
-		wakeup-source;
-	};
-};
-
 &remoteproc_adsp {
 	firmware-name = "qcom/sc8280xp/qcadsp8280.mbn";
 
@@ -494,6 +494,13 @@ hastings_reg_en: hastings-reg-en-state {
 &tlmm {
 	gpio-reserved-ranges = <74 6>, <83 4>, <125 2>, <128 2>, <154 7>;
 
+	i2c21_default: i2c21-default-state {
+		pins = "gpio81", "gpio82";
+		function = "qup21";
+		drive-strength = <16>;
+		bias-disable;
+	};
+
 	kybd_default: kybd-default-state {
 		disable-pins {
 			pins = "gpio102";
@@ -598,14 +605,6 @@ qup0_i2c4_default: qup0-i2c4-default-state {
 		drive-strength = <16>;
 	};
 
-	qup2_i2c5_default: qup2-i2c5-default-state {
-		pins = "gpio81", "gpio82";
-		function = "qup21";
-
-		bias-disable;
-		drive-strength = <16>;
-	};
-
 	tpad_default: tpad-default-state {
 		int-n-pins {
 			pins = "gpio182";
diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
index 568c6be1ceaa..ad66a87141be 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
@@ -282,6 +282,59 @@ vreg_l9d: ldo9 {
 	};
 };
 
+&i2c21 {
+	clock-frequency = <400000>;
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c21_default>;
+
+	status = "okay";
+
+	touchpad@15 {
+		compatible = "hid-over-i2c";
+		reg = <0x15>;
+
+		hid-descr-addr = <0x1>;
+		interrupts-extended = <&tlmm 182 IRQ_TYPE_LEVEL_LOW>;
+		vdd-supply = <&vreg_misc_3p3>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&tpad_default>;
+
+		wakeup-source;
+
+		status = "disabled";
+	};
+
+	touchpad@2c {
+		compatible = "hid-over-i2c";
+		reg = <0x2c>;
+
+		hid-descr-addr = <0x20>;
+		interrupts-extended = <&tlmm 182 IRQ_TYPE_LEVEL_LOW>;
+		vdd-supply = <&vreg_misc_3p3>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&tpad_default>;
+
+		wakeup-source;
+	};
+
+	keyboard@68 {
+		compatible = "hid-over-i2c";
+		reg = <0x68>;
+
+		hid-descr-addr = <0x1>;
+		interrupts-extended = <&tlmm 104 IRQ_TYPE_LEVEL_LOW>;
+		vdd-supply = <&vreg_misc_3p3>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&kybd_default>;
+
+		wakeup-source;
+	};
+};
+
 &pcie2a {
 	perst-gpios = <&tlmm 143 GPIO_ACTIVE_LOW>;
 	wake-gpios = <&tlmm 145 GPIO_ACTIVE_LOW>;
@@ -531,59 +584,6 @@ &qup2 {
 	status = "okay";
 };
 
-&qup2_i2c5 {
-	clock-frequency = <400000>;
-
-	pinctrl-names = "default";
-	pinctrl-0 = <&qup2_i2c5_default>;
-
-	status = "okay";
-
-	touchpad@15 {
-		compatible = "hid-over-i2c";
-		reg = <0x15>;
-
-		hid-descr-addr = <0x1>;
-		interrupts-extended = <&tlmm 182 IRQ_TYPE_LEVEL_LOW>;
-		vdd-supply = <&vreg_misc_3p3>;
-
-		pinctrl-names = "default";
-		pinctrl-0 = <&tpad_default>;
-
-		wakeup-source;
-
-		status = "disabled";
-	};
-
-	touchpad@2c {
-		compatible = "hid-over-i2c";
-		reg = <0x2c>;
-
-		hid-descr-addr = <0x20>;
-		interrupts-extended = <&tlmm 182 IRQ_TYPE_LEVEL_LOW>;
-		vdd-supply = <&vreg_misc_3p3>;
-
-		pinctrl-names = "default";
-		pinctrl-0 = <&tpad_default>;
-
-		wakeup-source;
-	};
-
-	keyboard@68 {
-		compatible = "hid-over-i2c";
-		reg = <0x68>;
-
-		hid-descr-addr = <0x1>;
-		interrupts-extended = <&tlmm 104 IRQ_TYPE_LEVEL_LOW>;
-		vdd-supply = <&vreg_misc_3p3>;
-
-		pinctrl-names = "default";
-		pinctrl-0 = <&kybd_default>;
-
-		wakeup-source;
-	};
-};
-
 &remoteproc_adsp {
 	firmware-name = "qcom/sc8280xp/LENOVO/21BX/qcadsp8280.mbn";
 
@@ -698,6 +698,13 @@ hall_int_n_default: hall-int-n-state {
 		bias-disable;
 	};
 
+	i2c21_default: i2c21-default-state {
+		pins = "gpio81", "gpio82";
+		function = "qup21";
+		drive-strength = <16>;
+		bias-disable;
+	};
+
 	kybd_default: kybd-default-state {
 		disable-pins {
 			pins = "gpio102";
@@ -801,13 +808,6 @@ qup0_i2c4_default: qup0-i2c4-default-state {
 		drive-strength = <16>;
 	};
 
-	qup2_i2c5_default: qup2-i2c5-default-state {
-		pins = "gpio81", "gpio82";
-		function = "qup21";
-		bias-disable;
-		drive-strength = <16>;
-	};
-
 	tpad_default: tpad-default-state {
 		int-n-pins {
 			pins = "gpio182";
diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
index b8f567642551..d4a7a4c3fdee 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
@@ -827,7 +827,7 @@ uart17: serial@884000 {
 				status = "disabled";
 			};
 
-			qup2_i2c5: i2c@894000 {
+			i2c21: i2c@894000 {
 				compatible = "qcom,geni-i2c";
 				reg = <0 0x00894000 0 0x4000>;
 				#address-cells = <1>;
-- 
2.39.0

