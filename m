Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25FA16C3F90
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 02:15:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbjCVBPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 21:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbjCVBOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 21:14:51 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 027BB58487
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 18:14:49 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-17671fb717cso18051771fac.8
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 18:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kali.org; s=google; t=1679447689;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d4WRBYhVHBZ8wEtUoS7CcmKTTwWyVK3DaxRziT3IUGY=;
        b=PaV2rxfk+xHLAwglDpJwNswMUDoe0XdAFxmgsEjWcscE431eO/bAtMuz2wqjmzySZV
         GzzyHFsSQYiA26cEfhzRQPMdMEJqRT/f4Yw/K2dT4XuBKhbbUDoDZTyjWrwrEJLUQY7C
         9bk62yu6ii2UNXV1ysNoIfhVKGFAOkkCyFoaVkS9XKzL6D/q6T3e2ybR6LwQCQf7WrGE
         1i959QcT8FPZSLGJRYswr0LxBPEhFdbKRn70tLXgOfiLW+FVD9NswMsZo/pk2u1bLwQA
         8bqYeVzVMRfWzEujRE0itwukDdGT1o0oq+YO1oQmSTgiU9jflmYw9yIEq6YaffW3cnTS
         atPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679447689;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d4WRBYhVHBZ8wEtUoS7CcmKTTwWyVK3DaxRziT3IUGY=;
        b=LDslu7o0BH/AcQI2Pn7VG4QtFthvYxMmlQdvok2ej4ONCsk+YoST3eIN/04GMubnxz
         Q8bygc4Qcn3cOE3MjDRjSqQOCUO+1DqwoQhCs/kfjjxSzOsaC+gzZs/8cIKev0vzLnMj
         LbPCRT3Rej7lLxa5nvhdDU12s2YxzJ0qmqNT9urSEAvZXVY2ShL2lH2CAO46zcpzwDoN
         goptOe2Xr7cGSZff1jvnakA23rblIoShKqA2ZUPZxVWLpOIcGjhUFBjH7MRA/D1IKS2d
         Cqd6RawePraUtPeyJpjYleOSN8dE07oyZI0u72PDbW5VEvN+jRxB8XmVWZXUZ/lFYD0Y
         Wo7w==
X-Gm-Message-State: AO0yUKWoFCo4Wmruecz1FVCNaMaEta4GISr5cdvV/7uX8J7JOTNvX9IY
        LHsWmdwK/ZE5hw607+BenDzxSQ==
X-Google-Smtp-Source: AK7set98lpmfliSClNeXPozbcX91zLQLW1HRymvDIIVVSvViJNENAAgdU8fH2fVbavdgit7z+k+DCg==
X-Received: by 2002:a05:6870:a1a7:b0:17a:c102:b449 with SMTP id a39-20020a056870a1a700b0017ac102b449mr576632oaf.59.1679447689676;
        Tue, 21 Mar 2023 18:14:49 -0700 (PDT)
Received: from localhost (23-118-233-243.lightspeed.snantx.sbcglobal.net. [23.118.233.243])
        by smtp.gmail.com with ESMTPSA id ee48-20020a056870c83000b0017299192eb1sm4715522oab.25.2023.03.21.18.14.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 18:14:49 -0700 (PDT)
From:   Steev Klimaszewski <steev@kali.org>
To:     Steev Klimaszewski <steev@kali.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Sven Peter <sven@svenpeter.dev>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        Mark Pearson <markpearson@lenovo.com>,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH v7 4/4] arm64: dts: qcom: sc8280xp-x13s: Add bluetooth
Date:   Tue, 21 Mar 2023 20:14:42 -0500
Message-Id: <20230322011442.34475-5-steev@kali.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230322011442.34475-1-steev@kali.org>
References: <20230322011442.34475-1-steev@kali.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Lenovo Thinkpad X13s has a WCN6855 Bluetooth controller on uart2,
add this.

Signed-off-by: Steev Klimaszewski <steev@kali.org>
---
Changes since v6:
 * Remove allowed-modes as they aren't needed
 * Remove regulator-allow-set-load
 * Set regulator-always-on because the wifi chip also uses the regulator
 * cts pin uses bias-bus-hold
 * Alphabetize uart2 pins

Changes since v5:
 * Update patch subject
 * Specify initial mode (via guess) for vreg_s1c
 * Drop uart17 definition
 * Rename bt_en to bt_default because configuring more than one pin
 * Correct (maybe) bias configurations
 * Correct cts gpio
 * Split rts-tx into two nodes
 * Drop incorrect link in the commit message

Changes since v4:
 * Address Konrad's review comments.

Changes since v3:
 * Add vreg_s1c
 * Add regulators and not dead code
 * Fix commit message changelog

Changes since v2:
 * Remove dead code and add TODO comment
 * Make dtbs_check happy with the pin definitions
 .../qcom/sc8280xp-lenovo-thinkpad-x13s.dts    | 78 +++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
index 92d365519546..05e66505e5cc 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
@@ -24,6 +24,7 @@ / {
 	aliases {
 		i2c4 = &i2c4;
 		i2c21 = &i2c21;
+		serial1 = &uart2;
 	};
 
 	wcd938x: audio-codec {
@@ -431,6 +432,14 @@ regulators-1 {
 		qcom,pmic-id = "c";
 		vdd-bob-supply = <&vreg_vph_pwr>;
 
+		vreg_s1c: smps1 {
+			regulator-name = "vreg_s1c";
+			regulator-min-microvolt = <1880000>;
+			regulator-max-microvolt = <1900000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-always-on;
+		};
+
 		vreg_l1c: ldo1 {
 			regulator-name = "vreg_l1c";
 			regulator-min-microvolt = <1800000>;
@@ -918,6 +927,32 @@ &qup0 {
 	status = "okay";
 };
 
+&uart2 {
+	pinctrl-0 = <&uart2_default>;
+	pinctrl-names = "default";
+
+	status = "okay";
+
+	bluetooth {
+		compatible = "qcom,wcn6855-bt";
+
+		vddio-supply = <&vreg_s10b>;
+		vddbtcxmx-supply = <&vreg_s12b>;
+		vddrfacmn-supply = <&vreg_s12b>;
+		vddrfa0p8-supply = <&vreg_s12b>;
+		vddrfa1p2-supply = <&vreg_s11b>;
+		vddrfa1p7-supply = <&vreg_s1c>;
+
+		max-speed = <3200000>;
+
+		enable-gpios = <&tlmm 133 GPIO_ACTIVE_HIGH>;
+		swctrl-gpios = <&tlmm 132 GPIO_ACTIVE_HIGH>;
+
+		pinctrl-0 = <&bt_default>;
+		pinctrl-names = "default";
+	};
+};
+
 &qup1 {
 	status = "okay";
 };
@@ -1192,6 +1227,21 @@ hastings_reg_en: hastings-reg-en-state {
 &tlmm {
 	gpio-reserved-ranges = <70 2>, <74 6>, <83 4>, <125 2>, <128 2>, <154 7>;
 
+	bt_default: bt-default-state {
+		hstp-sw-ctrl-pins {
+			pins = "gpio132";
+			function = "gpio";
+			bias-pull-down;
+		};
+
+		hstp-bt-en-pins {
+			pins = "gpio133";
+			function = "gpio";
+			drive-strength = <16>;
+			bias-disable;
+		};
+	};
+
 	edp_reg_en: edp-reg-en-state {
 		pins = "gpio25";
 		function = "gpio";
@@ -1213,6 +1263,34 @@ i2c4_default: i2c4-default-state {
 		bias-disable;
 	};
 
+	uart2_default: uart2-default-state {
+		cts-pins {
+			pins = "gpio121";
+			function = "qup2";
+			bias-bus-hold;
+		};
+
+		rts-pins {
+			pins = "gpio122";
+			function = "qup2";
+			drive-strength = <2>;
+			bias-disable;
+		};
+
+		rx-pins {
+			pins = "gpio124";
+			function = "qup2";
+			bias-pull-up;
+		};
+
+		tx-pins {
+			pins = "gpio123";
+			function = "qup2";
+			drive-strength = <2>;
+			bias-disable;
+		};
+	};
+
 	i2c21_default: i2c21-default-state {
 		pins = "gpio81", "gpio82";
 		function = "qup21";
-- 
2.39.2

