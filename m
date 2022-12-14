Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F88864CEB0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 18:13:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238706AbiLNRNr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 12:13:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235762AbiLNRNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 12:13:31 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4AE12871A
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 09:12:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671037924;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wGzNrd9cHTVZR3qKpPDKVgr46mZSxiCfmWSct1f/p6o=;
        b=Sx1SrqtIKOytrxBssz8MFc2NkwqjKqXjl1VdvWtxB1HRqV8hBfiswxHZHKfRSo+AYMbA9t
        XQPNxG1ebsylnHYrq5P2J/nA27v7V1umy7tF7Ysz36Xtk2RsbhEolEgexau6THuCgMP9CL
        DozvJWzP50N257r3cUZZXXWPkg5FZNE=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-77-VSPhck_HMlC79P_dPctkfA-1; Wed, 14 Dec 2022 12:12:02 -0500
X-MC-Unique: VSPhck_HMlC79P_dPctkfA-1
Received: by mail-yb1-f199.google.com with SMTP id a4-20020a5b0004000000b006fdc6aaec4fso389993ybp.20
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 09:12:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wGzNrd9cHTVZR3qKpPDKVgr46mZSxiCfmWSct1f/p6o=;
        b=0Yx8uc3GMDYEAiQLVVM1ieISAfyWjGiNRK6HvoI9DpWkUAgCnHvX5wxPzyEHaYQJDg
         R3Ej+TAGMWCxUVyxQuIhgtZ3LxWE1iNwcPEyfXJB4E0ke/vcpWpeyKLDSAovbxh0GQU4
         li4+XPguXeZ4WfLownXP3w3xdJzA62GXjaMxhWcnAH6WE9d7H4qoRL0lGIxLkI6j5tT1
         lImyNwneRj25mshgc5Gf/aSLuakPb/tCYTPWvbn1wrg7BAB+2973WBZPXkqQCUs8scXj
         LpC/Ru9S+BKNAmLXy1YsOWVDaNeWbToAzORrqsq4B9eoweRAWdSkc2phfCuEQokGoeM9
         IZpA==
X-Gm-Message-State: ANoB5pnfffQs3WW/EtpC04IaR0mdBNZK0Vid6Rd+AB4DzP/bR62aa8Lf
        Ufy6ivij9pywzWHNpoToJj3M/jXlGCJ4OgHA9m/XoEwov2x9/9MZt0sthzRG9ntVr3KVbRDsGoJ
        YS0I+Emsq9aDtwlbI7IwIT+Fm
X-Received: by 2002:a05:7500:2d3:b0:ea:80e1:4bca with SMTP id i19-20020a05750002d300b000ea80e14bcamr3251834gai.27.1671037921906;
        Wed, 14 Dec 2022 09:12:01 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5Xqzgq1xYXVyYWkrC7Qt86MNHLejECkmNLTH7/ZmDIhQ+buRpFm+SApvUvLXIgJIKI82SV/g==
X-Received: by 2002:a05:7500:2d3:b0:ea:80e1:4bca with SMTP id i19-20020a05750002d300b000ea80e14bcamr3251777gai.27.1671037921173;
        Wed, 14 Dec 2022 09:12:01 -0800 (PST)
Received: from x1.redhat.com (c-73-214-169-22.hsd1.pa.comcast.net. [73.214.169.22])
        by smtp.gmail.com with ESMTPSA id t30-20020a37ea1e000000b006eef13ef4c8sm10305477qkj.94.2022.12.14.09.12.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 09:12:00 -0800 (PST)
From:   Brian Masney <bmasney@redhat.com>
To:     andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     quic_shazhuss@quicinc.com, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, johan+linaro@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ahalaney@redhat.com,
        echanude@redhat.com
Subject: [PATCH v2 3/7] arm64: dts: qcom: sc8280xp: rename qup0_i2c4 to i2c4
Date:   Wed, 14 Dec 2022 12:11:41 -0500
Message-Id: <20221214171145.2913557-4-bmasney@redhat.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221214171145.2913557-1-bmasney@redhat.com>
References: <20221214171145.2913557-1-bmasney@redhat.com>
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
and rename qup0_i2c4 to i2c4. Note that some nodes are moved in the
file by this patch to preserve the expected sort order in the file.

Signed-off-by: Brian Masney <bmasney@redhat.com>
Link: https://lore.kernel.org/lkml/20221212182314.1902632-1-bmasney@redhat.com/
---
This is a new patch that's introduced in v2.

 arch/arm64/boot/dts/qcom/sc8280xp-crd.dts     | 58 +++++++++----------
 .../qcom/sc8280xp-lenovo-thinkpad-x13s.dts    | 58 +++++++++----------
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi        |  2 +-
 3 files changed, 59 insertions(+), 59 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
index 0de1bdb68e2c..c37a9d93a2a8 100644
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
@@ -494,6 +494,14 @@ hastings_reg_en: hastings-reg-en-state {
 &tlmm {
 	gpio-reserved-ranges = <74 6>, <83 4>, <125 2>, <128 2>, <154 7>;
 
+	i2c4_default: i2c4-default-state {
+		pins = "gpio171", "gpio172";
+		function = "qup4";
+
+		bias-disable;
+		drive-strength = <16>;
+	};
+
 	i2c21_default: i2c21-default-state {
 		pins = "gpio81", "gpio82";
 		function = "qup21";
@@ -598,14 +606,6 @@ wake-n-pins {
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
index d7af2040cbcb..ec06b6216408 100644
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
+		bias-disable;
+		drive-strength = <16>;
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

