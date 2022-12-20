Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD496526FA
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 20:30:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234096AbiLTTaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 14:30:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234040AbiLTT36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 14:29:58 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 307D61D314
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 11:29:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671564547;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lAqlYrLdasgrEhfJzo+iyfwvixp2O1qnXeEJe7+SmO0=;
        b=QAHr0Wy9SYuXuzWJF/4b0VDP5O4Bk08nJeZMkTg1YOGAgyXxxzBevvOLKMvRpujb9yfIMd
        RKjkK6g685ENttsW7RBGDGE+2Nyb4cAtEESUos6wc5Ie4HVNuI4n7kbY5IQ/p5EIFoUZDR
        I6Ui6Bq0zkuMg79pwZ5iMdDZPKf0SLU=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-510-Rl9RxQgLN2uZD1eg-uakSA-1; Tue, 20 Dec 2022 14:29:06 -0500
X-MC-Unique: Rl9RxQgLN2uZD1eg-uakSA-1
Received: by mail-qv1-f70.google.com with SMTP id ob12-20020a0562142f8c00b004c6c72bf1d0so7515289qvb.9
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 11:29:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lAqlYrLdasgrEhfJzo+iyfwvixp2O1qnXeEJe7+SmO0=;
        b=mTO/Sa+7jFfitslgZTv3cVw7hk3bcfX3CMyQtAst/PFJ97/1ot21u2HzC0/cuZwMZA
         3ynA6g8jy1eQCaPRrz8PWrAfYb92AimOsxc/mHOmXydFxLISlTFZf7EsduKN9LhKhilF
         FH9jHOT3bg0JtbDlHlHUwnfg3BBlnjS9kLjlmLv/tHzGFygRj8XxQ4Y6wDJzbjAsMEs3
         kRsa6mUSz/cLqhla/+qyWaEZXjfzBaNuwMydYhd/8n5UgeWjy/cAPr/CjUiegf33uPpx
         rFGYIGnE3yftjBSJyGheEfteH/EUwVfRbo6pM+sBj0YJ1Wfv8UbeWRlHNHYNxV5zs7hn
         7RDA==
X-Gm-Message-State: ANoB5pl/TDHfPxR9siur5HEdkRBrMWxXSLpcmj16pi4+zYwar0MNmmn1
        62egvLWMqXlYtHYPCa80xQBATy2UIdbSPMVGdf7PxTws5TYRHsncl410zvZfb+wHqBWTeYud3Ii
        R8ggHSlGSbmsKlcGvUkSizrQj
X-Received: by 2002:a05:622a:488b:b0:3a8:1639:35a9 with SMTP id fc11-20020a05622a488b00b003a8163935a9mr50734092qtb.45.1671564545647;
        Tue, 20 Dec 2022 11:29:05 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6T8Ynrx1sXnVhYG19dMuHf/tosjh7JbaRcMkvkV89Rywx1gez70FHnfkxGaozaPSPdtuoDJw==
X-Received: by 2002:a05:622a:488b:b0:3a8:1639:35a9 with SMTP id fc11-20020a05622a488b00b003a8163935a9mr50734071qtb.45.1671564545350;
        Tue, 20 Dec 2022 11:29:05 -0800 (PST)
Received: from x1.redhat.com (c-73-214-169-22.hsd1.pa.comcast.net. [73.214.169.22])
        by smtp.gmail.com with ESMTPSA id gd15-20020a05622a5c0f00b003a82ca4e81csm744348qtb.80.2022.12.20.11.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 11:29:04 -0800 (PST)
From:   Brian Masney <bmasney@redhat.com>
To:     andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     quic_shazhuss@quicinc.com, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, johan+linaro@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ahalaney@redhat.com,
        echanude@redhat.com
Subject: [PATCH v3 2/7] arm64: dts: qcom: sc8280xp: rename qup2_i2c5 to i2c21
Date:   Tue, 20 Dec 2022 14:28:49 -0500
Message-Id: <20221220192854.521647-3-bmasney@redhat.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221220192854.521647-1-bmasney@redhat.com>
References: <20221220192854.521647-1-bmasney@redhat.com>
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
and rename qup2_i2c5 to i2c21. Under the old name, this was the 5th
index under qup2, which starts at index 16.

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

