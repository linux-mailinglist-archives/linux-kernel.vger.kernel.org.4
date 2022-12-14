Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDF0264CEAC
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 18:13:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237907AbiLNRNd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 12:13:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbiLNRN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 12:13:29 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A28A726573
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 09:12:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671037922;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ViPUo5RSC1lOfFH6js8lwSLNuz2X1DayNZ3oP43BQUE=;
        b=DBvkfog51ZySIiXkAOksc0/oey21r1agoxXWNXLlwz/P2fRCI7XXRU25ASB7ie/GCFp5yn
        FVv1VGJx+hIaLG5o/iqQmwi3e0OanHsQjlVl2JEpMmn+XIUi/A1PzmSmrScDtfKO9BJUp5
        CD3dOSUai7Qj1sBx95BP/lISf7v5QW4=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-137-RRlQdNTkOk663wupc5gqnw-1; Wed, 14 Dec 2022 12:12:01 -0500
X-MC-Unique: RRlQdNTkOk663wupc5gqnw-1
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-348608c1cd3so4587557b3.10
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 09:12:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ViPUo5RSC1lOfFH6js8lwSLNuz2X1DayNZ3oP43BQUE=;
        b=kRc8XA2FwgKgj2oUjAxE1Y8jQcH6xLhOrS3uo9CaTT3NanKYuFypCM3yxJkkDWEkgo
         PgaSMboNH65NV7c47Z39V+lZuvvpbKG3a7H/y0EN4lgAun1KXCIdv89cN2DGo/iGljeW
         tFB+Mam+EFXn7VgJuPYeB5HC3fpousRVZGDrswuaoxeoIMRSxSE5UaCjITyl3wkxpMlW
         wMhDt9h8ELIYT2qeTgQAAFIIVgTpT8No1UH3024M0WHXuS1H0suvSFAk8bnZGomybGyW
         gak6jnUy+pb46L7xFPUTaBf3fsgWy8nr55RM7kVm9dUxUr5TpX3DCT/MsxICxjDU/nwn
         YDbg==
X-Gm-Message-State: ANoB5pkRaxKpv+JzrlhqCYZCOjV5UHYijgOxmZGCKPeHajEqShvx7Siq
        Ny0xxYYUDmzeXGJTiNCZfJ4QkVTjTXfqIMQnb24BuzwJQG0KSwEF5PodSdpRlPu6nF+z92Q6jDp
        RiUocAILMtAsJ7yCdQvczg6Ri
X-Received: by 2002:a05:7500:b8e:b0:eb:2ca:b87a with SMTP id fx14-20020a0575000b8e00b000eb02cab87amr2699494gab.56.1671037920488;
        Wed, 14 Dec 2022 09:12:00 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5/D+8Llah6uyulxiUSnqmaPv4usKNf7Fw7SiI7MHsWoGj3T4BrDfrSP2E3SCQJ2bS/C6K4nQ==
X-Received: by 2002:a05:7500:b8e:b0:eb:2ca:b87a with SMTP id fx14-20020a0575000b8e00b000eb02cab87amr2699462gab.56.1671037920061;
        Wed, 14 Dec 2022 09:12:00 -0800 (PST)
Received: from x1.redhat.com (c-73-214-169-22.hsd1.pa.comcast.net. [73.214.169.22])
        by smtp.gmail.com with ESMTPSA id t30-20020a37ea1e000000b006eef13ef4c8sm10305477qkj.94.2022.12.14.09.11.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 09:11:59 -0800 (PST)
From:   Brian Masney <bmasney@redhat.com>
To:     andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     quic_shazhuss@quicinc.com, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, johan+linaro@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ahalaney@redhat.com,
        echanude@redhat.com
Subject: [PATCH v2 2/7] arm64: dts: qcom: sc8280xp: rename qup2_i2c5 to i2c21
Date:   Wed, 14 Dec 2022 12:11:40 -0500
Message-Id: <20221214171145.2913557-3-bmasney@redhat.com>
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
and rename qup2_i2c5 to i2c21. Under the old name, this was the 5th
index under qup2, which starts at index 16. Note that some nodes are
moved in the file by this patch to preserve the expected sort order in
the file.

Signed-off-by: Brian Masney <bmasney@redhat.com>
Link: https://lore.kernel.org/lkml/20221212182314.1902632-1-bmasney@redhat.com/
---
This is a new patch that's introduced in v2.

 arch/arm64/boot/dts/qcom/sc8280xp-crd.dts     |  90 ++++++-------
 .../qcom/sc8280xp-lenovo-thinkpad-x13s.dts    | 120 +++++++++---------
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi        |   2 +-
 3 files changed, 106 insertions(+), 106 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
index db273face248..0de1bdb68e2c 100644
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
 
@@ -494,6 +494,14 @@ hastings_reg_en: hastings-reg-en-state {
 &tlmm {
 	gpio-reserved-ranges = <74 6>, <83 4>, <125 2>, <128 2>, <154 7>;
 
+	i2c21_default: i2c21-default-state {
+		pins = "gpio81", "gpio82";
+		function = "qup21";
+
+		bias-disable;
+		drive-strength = <16>;
+	};
+
 	kybd_default: kybd-default-state {
 		disable-pins {
 			pins = "gpio102";
@@ -598,14 +606,6 @@ qup0_i2c4_default: qup0-i2c4-default-state {
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
index 568c6be1ceaa..d7af2040cbcb 100644
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
+		bias-disable;
+		drive-strength = <16>;
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
index 951cb1b6fcc4..929365cff555 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
@@ -827,7 +827,7 @@ uart17: serial@884000 {
 				status = "disabled";
 			};
 
-			qup2_i2c5: i2c@894000 {
+			i2c21: i2c@894000 {
 				compatible = "qcom,geni-i2c";
 				reg = <0 0x00894000 0 0x4000>;
 				clock-names = "se";
-- 
2.38.1

