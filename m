Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A770648E91
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Dec 2022 12:57:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbiLJL5X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Dec 2022 06:57:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbiLJL5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Dec 2022 06:57:16 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACC15192B8
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 03:57:13 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id y25so11035933lfa.9
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 03:57:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2aKGT7tvm+U766DlUeQvJkK/b6wDdJYC7cAMniFsjLY=;
        b=sGcZyKf2v871JJabnGjzz5G2LGfTbsnyH9ThYrjJOSD0YFCF1BKxYVVZaDtA0JkO9Z
         RHvziHlT2PJlKCnTZxk+NIAmn+XDfnM+9NYfMnCX2MnGkioCQwLrifkbsWhaHI2k6RRO
         qHUj6ZmvYW+4oAdi4sSdor0PBEi2NI7zQohHcr8n2q+lCjZk3FmbqGiNIugcMff2Fu5v
         HYniOkmyBWtltL2jHYFksYyqNFHNC9nXDElwEhdCGftFTyh5pyqxorYYxGrbAUykuovK
         5Pl6zS96n1a1nJwv5qU6nqpS5u5Li5eC0rZEy4xP2lPftl3WAa21d9r1soxp1tymLCl6
         Ufgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2aKGT7tvm+U766DlUeQvJkK/b6wDdJYC7cAMniFsjLY=;
        b=daiAzEKVQ8uoQJfR3Mb+1A5hQa8Y0eUIP9CxNZgf31oJo+YI1zydOHKGY0fK3wd8Ct
         xy0+fRI2jGx7EdEMPE3VCQiClUK+tI0y46H+7lIn+t7+J0+XbSIhRbSVVIeXjxsQM9vp
         IIkY/a1Ykpioc50r4GlZ/UQ1wz1f1WUffvU/M2fu9tjQCDJ8cSg3d+0/0Y+tHKkXI5t9
         vD+VU7Vj+LNNDq8x3kmJLJA+tXwpg4fJUgDW4GtYVSkgLamp+dq85V0lQFcoz5xbzynv
         8r8exmttn/tv31MC2yrTxMbyCL8CLKpvC3YPy/hvAYrO61bZA/gVecoGRU8k1qd9FtL5
         +4DQ==
X-Gm-Message-State: ANoB5pkU2rkO2Vh31wVg1ztNWFZK1+lp2SpKobLBhIcBO/zunMXdZ7Xp
        +3ocY+LwIkTKYS9bZ2Y7EP2L8Q==
X-Google-Smtp-Source: AA0mqf57GIJ7oiCi//wQfch5XLd3oGkCPVgySNcwxJ/rybvNhYXXfOnwfU7GVHgPZSBZ/cdE4mmqrw==
X-Received: by 2002:ac2:4305:0:b0:4b0:25f9:14ea with SMTP id l5-20020ac24305000000b004b025f914eamr1985735lfh.21.1670673431731;
        Sat, 10 Dec 2022 03:57:11 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id u20-20020a2eb814000000b002778d482800sm578343ljo.59.2022.12.10.03.57.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Dec 2022 03:57:11 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] arm64: dts: qcom: sm8250: move sound and codec nodes out of soc
Date:   Sat, 10 Dec 2022 12:57:04 +0100
Message-Id: <20221210115704.97614-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221210115704.97614-1-krzysztof.kozlowski@linaro.org>
References: <20221210115704.97614-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sound and codec nodes are not a property of a soc, but rather board
as it describes the sound configuration.  It also does not have unit
address:

  sm8250-hdk.dtb: soc@0: sound: {} should not be valid under {'type': 'object'}

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8250-mtp.dts | 40 ++++++++++++-------------
 arch/arm64/boot/dts/qcom/sm8250.dtsi    |  6 ++--
 2 files changed, 22 insertions(+), 24 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8250-mtp.dts b/arch/arm64/boot/dts/qcom/sm8250-mtp.dts
index 3ed8c84e25b8..b741b7da1afc 100644
--- a/arch/arm64/boot/dts/qcom/sm8250-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sm8250-mtp.dts
@@ -27,6 +27,25 @@ chosen {
 		stdout-path = "serial0:115200n8";
 	};
 
+	wcd938x: codec {
+		compatible = "qcom,wcd9380-codec";
+		#sound-dai-cells = <1>;
+		reset-gpios = <&tlmm 32 GPIO_ACTIVE_LOW>;
+		vdd-buck-supply = <&vreg_s4a_1p8>;
+		vdd-rxtx-supply = <&vreg_s4a_1p8>;
+		vdd-io-supply = <&vreg_s4a_1p8>;
+		vdd-mic-bias-supply = <&vreg_bob>;
+		qcom,micbias1-microvolt = <1800000>;
+		qcom,micbias2-microvolt = <1800000>;
+		qcom,micbias3-microvolt = <1800000>;
+		qcom,micbias4-microvolt = <1800000>;
+		qcom,mbhc-buttons-vthreshold-microvolt = <75000 150000 237000 500000 500000 500000 500000 500000>;
+		qcom,mbhc-headset-vthreshold-microvolt = <1700000>;
+		qcom,mbhc-headphone-vthreshold-microvolt = <50000>;
+		qcom,rx-device = <&wcd_rx>;
+		qcom,tx-device = <&wcd_tx>;
+	};
+
 	thermal-zones {
 		camera-thermal {
 			polling-delay-passive = <0>;
@@ -631,27 +650,6 @@ &slpi {
 	firmware-name = "qcom/sm8250/slpi.mbn";
 };
 
-&soc {
-	wcd938x: codec {
-		compatible = "qcom,wcd9380-codec";
-		#sound-dai-cells = <1>;
-		reset-gpios = <&tlmm 32 GPIO_ACTIVE_LOW>;
-		vdd-buck-supply = <&vreg_s4a_1p8>;
-		vdd-rxtx-supply = <&vreg_s4a_1p8>;
-		vdd-io-supply = <&vreg_s4a_1p8>;
-		vdd-mic-bias-supply = <&vreg_bob>;
-		qcom,micbias1-microvolt = <1800000>;
-		qcom,micbias2-microvolt = <1800000>;
-		qcom,micbias3-microvolt = <1800000>;
-		qcom,micbias4-microvolt = <1800000>;
-		qcom,mbhc-buttons-vthreshold-microvolt = <75000 150000 237000 500000 500000 500000 500000 500000>;
-		qcom,mbhc-headset-vthreshold-microvolt = <1700000>;
-		qcom,mbhc-headphone-vthreshold-microvolt = <50000>;
-		qcom,rx-device = <&wcd_rx>;
-		qcom,tx-device = <&wcd_tx>;
-	};
-};
-
 &sound {
 	compatible = "qcom,sm8250-sndcard";
 	model = "SM8250-MTP-WCD9380-WSA8810-VA-DMIC";
diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index d517d6a80bdc..fbbbae29e0c2 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -2826,9 +2826,6 @@ compute-cb@8 {
 			};
 		};
 
-		sound: sound {
-		};
-
 		usb_1_hsphy: phy@88e3000 {
 			compatible = "qcom,sm8250-usb-hs-phy",
 				     "qcom,usb-snps-hs-7nm-phy";
@@ -4910,6 +4907,9 @@ cpufreq_hw: cpufreq@18591000 {
 		};
 	};
 
+	sound: sound {
+	};
+
 	timer {
 		compatible = "arm,armv8-timer";
 		interrupts = <GIC_PPI 13
-- 
2.34.1

