Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 522FB652704
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 20:30:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234192AbiLTTaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 14:30:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234091AbiLTT37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 14:29:59 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37EB618B04
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 11:29:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671564549;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ahYEQ32+0Wpbw3gt+ZfkH3hqfADhB4nWm8TfQjoEl3A=;
        b=EiOo/1aHwbzHwMhvnnPMYHDF4Jj3+31/ZhJoFq+XEjoEooXM2GzJE/92luHCsB+spll34O
        T4jMvUzNSWSqtzQwtXjFaGBaLNBXDul/03VAgGAl876yRbI66mCPe6VEnrsUjKK0tx7srq
        CPwNMgWU7QTlfx14Y38GcAQjR+guSts=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-351-RbBs0NWUPqCCrjdQxMX-EA-1; Tue, 20 Dec 2022 14:29:07 -0500
X-MC-Unique: RbBs0NWUPqCCrjdQxMX-EA-1
Received: by mail-qv1-f69.google.com with SMTP id o13-20020a056214108d00b004c6fb4f16dcso7525703qvr.6
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 11:29:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ahYEQ32+0Wpbw3gt+ZfkH3hqfADhB4nWm8TfQjoEl3A=;
        b=Vhjr/LV9oLYX0YiEBqgapWq7DEsLQOoGdYxYwLBwQDOr8RUAjiForKSuJsMAFWh9Fu
         fodGayJpHSOuYKIG4jFgZtOljo1vDGyP1o23f/SEXg/EM2Bojh75qCWw8JTHfax5SMRL
         KmoIwsZqy6+813MAu1tFSpNZvjgBXt4oChUKQwzLKUiJmRMZe+2V9mYYCGMFArCu/TzG
         z8md+8N4Dsqm0PAFCIFwrIdXlBCHL09+J1uNFX6aXIeclqC6aShl/Wbo4JILTmHsE+pT
         L3sFMO3WWfGbdsI+q3UruZp05TCgtlk5xiCMbKRLDkwGoloh1sQPLWLGG904FvCKNcc0
         GK4w==
X-Gm-Message-State: ANoB5pkZ1GsYitQZOnmWjelu+TlrN+QwSIQzQMGfJQEBRXhngLV2yQg5
        aiAQEockXImrhsNGrhokRo7kJ/7ZvIojSvRk2BI3hUSi1EwwtY8TvJNL5fV4w2zse953APuO1iG
        /qvxkYcCWLt//8LG/1MgbG5fH
X-Received: by 2002:a05:622a:260a:b0:3a8:14c7:47b0 with SMTP id ci10-20020a05622a260a00b003a814c747b0mr50513744qtb.52.1671564547138;
        Tue, 20 Dec 2022 11:29:07 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7FVa901Nts9/MMSXsitI1CkXAVM+wYpq6az4m16HP8vc+3GkMk9B4KNkBLpaDRn8+lZ4otyg==
X-Received: by 2002:a05:622a:260a:b0:3a8:14c7:47b0 with SMTP id ci10-20020a05622a260a00b003a814c747b0mr50513734qtb.52.1671564546858;
        Tue, 20 Dec 2022 11:29:06 -0800 (PST)
Received: from x1.redhat.com (c-73-214-169-22.hsd1.pa.comcast.net. [73.214.169.22])
        by smtp.gmail.com with ESMTPSA id gd15-20020a05622a5c0f00b003a82ca4e81csm744348qtb.80.2022.12.20.11.29.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 11:29:06 -0800 (PST)
From:   Brian Masney <bmasney@redhat.com>
To:     andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     quic_shazhuss@quicinc.com, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, johan+linaro@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ahalaney@redhat.com,
        echanude@redhat.com
Subject: [PATCH v3 3/7] arm64: dts: qcom: sc8280xp: rename qup0_i2c4 to i2c4
Date:   Tue, 20 Dec 2022 14:28:50 -0500
Message-Id: <20221220192854.521647-4-bmasney@redhat.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221220192854.521647-1-bmasney@redhat.com>
References: <20221220192854.521647-1-bmasney@redhat.com>
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
and rename qup0_i2c4 to i2c4.

Note that some nodes are moved in the file by this patch to preserve
the expected sort order in the file. Additionally, the properties
within the pinctrl state node are sorted to match the expected order
that's typically done in other DTs.

Signed-off-by: Brian Masney <bmasney@redhat.com>
Link: https://lore.kernel.org/lkml/20221212182314.1902632-1-bmasney@redhat.com/
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Changes from v2 to v3:
- Reordered properties on renamed state node to match order typically
  done elsewhere (Konrod)
- Add Konrad's R-b

Patch introduced in v2

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
index 929365cff555..f1111cd7f679 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
@@ -858,7 +858,7 @@ qup0: geniqup@9c0000 {
 
 			status = "disabled";
 
-			qup0_i2c4: i2c@990000 {
+			i2c4: i2c@990000 {
 				compatible = "qcom,geni-i2c";
 				reg = <0 0x00990000 0 0x4000>;
 				clock-names = "se";
-- 
2.38.1

