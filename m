Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB68F5E9D82
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 11:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234561AbiIZJZL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 05:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233705AbiIZJXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 05:23:02 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 780CD40E12
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 02:21:16 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id x29so6734014ljq.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 02:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=dJxiiG3cSpUqul9wxmFe5qa1GXdOnVN++JZ4X3LY6+0=;
        b=qg3oXRNOca0Kz65aBQqQlN7Lh+sSgYe18NomKf+v2H/nzBiKpaah5Rozku0em3hdXK
         3lzil9CQa+dhKd6Z60HxCSIQLZ7H+eilFSRokyrbP0E/p7MJYa9WrZR3AgCxPcyqFXOj
         9gGczYziRiLw9BCzUD2onCM2cBhsyubAC0jYiOd2SddJyTwb0gh1U8s+gLlogtzj00fL
         FWUPqbM/ZJ1xCkBDABCWjY3rDsvladjZJdxWc3aw106BeO7KBO7XAUNFFklAA/GvYlNA
         V3mgZ74j+VnsOOT6mIRSg4UD/u7MtPYrNv6H4G1s+Ry6bEy2gjsQJYvqGWE1Ii4KMOJ4
         HwMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=dJxiiG3cSpUqul9wxmFe5qa1GXdOnVN++JZ4X3LY6+0=;
        b=gmQctERMJ78XLBnRnDvyz0ZzD4h7pxphV/UFABQnVxMa0NJQKeNeQEov7SoHFYBFl0
         G6zX8i8k8tgiAmn4+ovjn88Dij0B03eKLsivXM5OrB87ZN9P03qMehzQsbdpi/3J4mpP
         R73ZWZQgXz2miKJ5r1b+P0q/+/YOKAC72H+HS9Wo/GhrnzgWODm58HlYY0cH1yx9yDpX
         1hckmA9ZTLbx9xpG6KL1YMNwQN09SrhSNmON56c9CB/1dZZrW4SoS7sH1IPoKFm6SZkN
         KMqfSazzHDsnv3mglmaPzKaD64QY+TApqXgWSZeWLoZOuYVnK/Yb7HCxSIp73QVdvJao
         tkMg==
X-Gm-Message-State: ACrzQf0OA7KXgJ1jgl+V72b6w2yHbAGt78SyPidS10hXv10FV+J1kWuV
        2VUmlBosfq4Kk0zud2ywcpHXhw==
X-Google-Smtp-Source: AMsMyM6Ed5SMF5cqHHd0gAJz1iWjMYnNsY5Q1bEptxCr5gaS18i+a4Ww8C6el8elWby+6fGYKfg7bA==
X-Received: by 2002:a2e:bc84:0:b0:26c:3bee:575f with SMTP id h4-20020a2ebc84000000b0026c3bee575fmr6968891ljf.389.1664184074775;
        Mon, 26 Sep 2022 02:21:14 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id g8-20020a2ea4a8000000b0026c3ecf9a39sm2325600ljm.38.2022.09.26.02.21.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 02:21:14 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [RESEND PATCH v2 3/4] arm64: dts: qcom: align RPM regulators node name with bindings
Date:   Mon, 26 Sep 2022 11:21:03 +0200
Message-Id: <20220926092104.111449-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220926092104.111449-1-krzysztof.kozlowski@linaro.org>
References: <20220926092104.111449-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Node names should be generic and new DT schema expects RPM regulators
node to be just "regulators".

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes since v1:
1. Fix more nodes.
2. Do not shuffle regulators around as it might impact probe order.
---
 arch/arm64/boot/dts/qcom/apq8096-db820c.dts                | 4 ++--
 arch/arm64/boot/dts/qcom/apq8096-ifc6640.dts               | 2 +-
 arch/arm64/boot/dts/qcom/msm8916-pm8916.dtsi               | 2 +-
 arch/arm64/boot/dts/qcom/msm8992-lg-bullhead.dtsi          | 4 ++--
 arch/arm64/boot/dts/qcom/msm8992-xiaomi-libra.dts          | 4 ++--
 arch/arm64/boot/dts/qcom/msm8994-msft-lumia-octagon.dtsi   | 4 ++--
 arch/arm64/boot/dts/qcom/msm8994-sony-xperia-kitakami.dtsi | 4 ++--
 arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone.dtsi     | 2 +-
 arch/arm64/boot/dts/qcom/msm8996-xiaomi-common.dtsi        | 4 ++--
 arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dts         | 2 +-
 arch/arm64/boot/dts/qcom/msm8996-xiaomi-natrium.dts        | 2 +-
 arch/arm64/boot/dts/qcom/msm8996-xiaomi-scorpio.dts        | 2 +-
 arch/arm64/boot/dts/qcom/msm8998-clamshell.dtsi            | 2 +-
 arch/arm64/boot/dts/qcom/msm8998-fxtec-pro1.dts            | 4 ++--
 arch/arm64/boot/dts/qcom/msm8998-mtp.dts                   | 4 ++--
 arch/arm64/boot/dts/qcom/msm8998-oneplus-common.dtsi       | 4 ++--
 arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino.dtsi  | 4 ++--
 arch/arm64/boot/dts/qcom/qcs404-evb.dtsi                   | 2 +-
 arch/arm64/boot/dts/qcom/sda660-inforce-ifc6560.dts        | 4 ++--
 arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile.dtsi      | 4 ++--
 arch/arm64/boot/dts/qcom/sdm632-fairphone-fp3.dts          | 2 +-
 arch/arm64/boot/dts/qcom/sdm660-xiaomi-lavender.dts        | 4 ++--
 22 files changed, 35 insertions(+), 35 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/apq8096-db820c.dts b/arch/arm64/boot/dts/qcom/apq8096-db820c.dts
index 5cdc7ac1a9c0..7f10372178d6 100644
--- a/arch/arm64/boot/dts/qcom/apq8096-db820c.dts
+++ b/arch/arm64/boot/dts/qcom/apq8096-db820c.dts
@@ -751,7 +751,7 @@ vdd_gfx: s2@1700 {
 };
 
 &rpm_requests {
-	pm8994-regulators {
+	regulators-0 {
 		compatible = "qcom,rpm-pm8994-regulators";
 
 		vdd_s1-supply = <&vph_pwr>;
@@ -963,7 +963,7 @@ vreg_lvs2a_1p8: lvs2 {
 		};
 	};
 
-	pmi8994-regulators {
+	regulators-1 {
 		compatible = "qcom,rpm-pmi8994-regulators";
 
 		vdd_s1-supply = <&vph_pwr>;
diff --git a/arch/arm64/boot/dts/qcom/apq8096-ifc6640.dts b/arch/arm64/boot/dts/qcom/apq8096-ifc6640.dts
index 92f264891d84..3ea793b20e7f 100644
--- a/arch/arm64/boot/dts/qcom/apq8096-ifc6640.dts
+++ b/arch/arm64/boot/dts/qcom/apq8096-ifc6640.dts
@@ -162,7 +162,7 @@ cd {
 };
 
 &rpm_requests {
-	pm8994-regulators {
+	regulators-0 {
 		compatible = "qcom,rpm-pm8994-regulators";
 
 		vdd_s1-supply = <&vph_pwr>;
diff --git a/arch/arm64/boot/dts/qcom/msm8916-pm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916-pm8916.dtsi
index 539823b2c36e..8cac23b5240c 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-pm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916-pm8916.dtsi
@@ -47,7 +47,7 @@ &usb_hs_phy {
 };
 
 &rpm_requests {
-	smd_rpm_regulators: pm8916-regulators {
+	smd_rpm_regulators: regulators {
 		compatible = "qcom,rpm-pm8916-regulators";
 
 		/* pm8916_s1 is managed by rpmpd (MSM8916_VDDCX) */
diff --git a/arch/arm64/boot/dts/qcom/msm8992-lg-bullhead.dtsi b/arch/arm64/boot/dts/qcom/msm8992-lg-bullhead.dtsi
index 71e373b11de9..aef92f3c49da 100644
--- a/arch/arm64/boot/dts/qcom/msm8992-lg-bullhead.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8992-lg-bullhead.dtsi
@@ -58,7 +58,7 @@ &blsp1_uart2 {
 };
 
 &rpm_requests {
-	pm8994_regulators: pm8994-regulators {
+	pm8994_regulators: regulators-0 {
 		compatible = "qcom,rpm-pm8994-regulators";
 
 		vdd_l1-supply = <&pm8994_s1>;
@@ -281,7 +281,7 @@ pm8994_l32: l32 {
 		};
 	};
 
-	pmi8994_regulators: pmi8994-regulators {
+	pmi8994_regulators: regulators-1 {
 		compatible = "qcom,rpm-pmi8994-regulators";
 
 		vdd_s1-supply = <&vph_pwr>;
diff --git a/arch/arm64/boot/dts/qcom/msm8992-xiaomi-libra.dts b/arch/arm64/boot/dts/qcom/msm8992-xiaomi-libra.dts
index c4e87d0aec42..b242c272d2af 100644
--- a/arch/arm64/boot/dts/qcom/msm8992-xiaomi-libra.dts
+++ b/arch/arm64/boot/dts/qcom/msm8992-xiaomi-libra.dts
@@ -153,7 +153,7 @@ VDD_APC1: s11 {
 };
 
 &rpm_requests {
-	pm8994-regulators {
+	regulators-0 {
 		compatible = "qcom,rpm-pm8994-regulators";
 
 		vdd_l1-supply = <&pm8994_s7>;
@@ -363,7 +363,7 @@ pm8994_l32: l32 {
 		pm8994_lvs2: lvs2 {};
 	};
 
-	pmi8994_regulators: pmi8994-regulators {
+	pmi8994_regulators: regulators-1 {
 		compatible = "qcom,rpm-pmi8994-regulators";
 		vdd_s1-supply = <&vph_pwr>;
 		vdd_bst_byp-supply = <&vph_pwr>;
diff --git a/arch/arm64/boot/dts/qcom/msm8994-msft-lumia-octagon.dtsi b/arch/arm64/boot/dts/qcom/msm8994-msft-lumia-octagon.dtsi
index f9d8bd09e074..d8d732ec1b73 100644
--- a/arch/arm64/boot/dts/qcom/msm8994-msft-lumia-octagon.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8994-msft-lumia-octagon.dtsi
@@ -551,7 +551,7 @@ vdd_gfx: s2@1700 {
 
 &rpm_requests {
 	/* These values were taken from the original firmware ACPI tables */
-	pm8994_regulators: pm8994-regulators {
+	pm8994_regulators: regulators-0 {
 		compatible = "qcom,rpm-pm8994-regulators";
 
 		vdd_s1-supply = <&vph_pwr>;
@@ -835,7 +835,7 @@ vreg_l32a_1p8: l32 {
 		vreg_lvs2a_1p8: lvs2 { };
 	};
 
-	pmi8994_regulators: pmi8994-regulators {
+	pmi8994_regulators: regulators-1 {
 		compatible = "qcom,rpm-pmi8994-regulators";
 
 		vdd_s1-supply = <&vph_pwr>;
diff --git a/arch/arm64/boot/dts/qcom/msm8994-sony-xperia-kitakami.dtsi b/arch/arm64/boot/dts/qcom/msm8994-sony-xperia-kitakami.dtsi
index ff60b7004d26..0c2680ff22a4 100644
--- a/arch/arm64/boot/dts/qcom/msm8994-sony-xperia-kitakami.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8994-sony-xperia-kitakami.dtsi
@@ -186,7 +186,7 @@ vdd_gfx: s2@1700 {
 
 &rpm_requests {
 	/* PMI8994 should probe first, because pmi8994_bby supplies some of PM8994's regulators */
-	pmi8994_regulators: pmi8994-regulators {
+	pmi8994_regulators: regulators-0 {
 		compatible = "qcom,rpm-pmi8994-regulators";
 
 		vdd_s1-supply = <&vph_pwr>;
@@ -205,7 +205,7 @@ pmi8994_bby: boost-bypass {
 		};
 	};
 
-	pm8994_regulators: pm8994-regulators {
+	pm8994_regulators: regulators-1 {
 		compatible = "qcom,rpm-pm8994-regulators";
 
 		vdd_s3-supply = <&vph_pwr>;
diff --git a/arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone.dtsi b/arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone.dtsi
index ca7c8d2e1d3d..de61c3c94903 100644
--- a/arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone.dtsi
@@ -629,7 +629,7 @@ &pmi8994_wled {
 };
 
 &rpm_requests {
-	pm8994-regulators {
+	regulators-0 {
 		compatible = "qcom,rpm-pm8994-regulators";
 
 		vdd_s1-supply = <&vph_pwr>;
diff --git a/arch/arm64/boot/dts/qcom/msm8996-xiaomi-common.dtsi b/arch/arm64/boot/dts/qcom/msm8996-xiaomi-common.dtsi
index 77819186086a..78a1977d0593 100644
--- a/arch/arm64/boot/dts/qcom/msm8996-xiaomi-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996-xiaomi-common.dtsi
@@ -413,7 +413,7 @@ &wcd9335 {
 };
 
 &rpm_requests {
-	pm8994-regulators {
+	regulators-0 {
 		compatible = "qcom,rpm-pm8994-regulators";
 
 		vdd_s1-supply = <&vph_pwr>;
@@ -598,7 +598,7 @@ vreg_lvs2a_1p8: lvs2 {
 		};
 	};
 
-	pmi8994-regulators {
+	regulators-1 {
 		compatible = "qcom,rpm-pmi8994-regulators";
 
 		vdd_s1-supply = <&vph_pwr>;
diff --git a/arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dts b/arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dts
index 4e5264f4116a..c8e84a934678 100644
--- a/arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dts
+++ b/arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dts
@@ -219,7 +219,7 @@ &venus {
 };
 
 &rpm_requests {
-	pm8994-regulators {
+	regulators-0 {
 		vreg_l17a_2p8: l17 {
 			regulator-name = "vreg_l17a_2p8";
 			regulator-min-microvolt = <2500000>;
diff --git a/arch/arm64/boot/dts/qcom/msm8996-xiaomi-natrium.dts b/arch/arm64/boot/dts/qcom/msm8996-xiaomi-natrium.dts
index ff4673ee9e81..7526f8f473b5 100644
--- a/arch/arm64/boot/dts/qcom/msm8996-xiaomi-natrium.dts
+++ b/arch/arm64/boot/dts/qcom/msm8996-xiaomi-natrium.dts
@@ -164,7 +164,7 @@ &venus {
 };
 
 &rpm_requests {
-	pm8994-regulators {
+	regulators-0 {
 		vreg_l3a_0p875: l3 {
 			regulator-name = "vreg_l3a_0p875";
 			regulator-min-microvolt = <850000>;
diff --git a/arch/arm64/boot/dts/qcom/msm8996-xiaomi-scorpio.dts b/arch/arm64/boot/dts/qcom/msm8996-xiaomi-scorpio.dts
index 79be5fb1295b..b751cbbf1a23 100644
--- a/arch/arm64/boot/dts/qcom/msm8996-xiaomi-scorpio.dts
+++ b/arch/arm64/boot/dts/qcom/msm8996-xiaomi-scorpio.dts
@@ -216,7 +216,7 @@ &venus {
 };
 
 &rpm_requests {
-	pm8994-regulators {
+	regulators-0 {
 		vreg_l3a_0p875: l3 {
 			regulator-name = "vreg_l3a_0p875";
 			regulator-min-microvolt = <850000>;
diff --git a/arch/arm64/boot/dts/qcom/msm8998-clamshell.dtsi b/arch/arm64/boot/dts/qcom/msm8998-clamshell.dtsi
index 7928b8197474..63413e39572c 100644
--- a/arch/arm64/boot/dts/qcom/msm8998-clamshell.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998-clamshell.dtsi
@@ -137,7 +137,7 @@ &qusb2phy {
 };
 
 &rpm_requests {
-	pm8998-regulators {
+	regulators-0 {
 		compatible = "qcom,rpm-pm8998-regulators";
 
 		vdd_s1-supply = <&vph_pwr>;
diff --git a/arch/arm64/boot/dts/qcom/msm8998-fxtec-pro1.dts b/arch/arm64/boot/dts/qcom/msm8998-fxtec-pro1.dts
index 429ba57e20f7..a7a79ddd3bea 100644
--- a/arch/arm64/boot/dts/qcom/msm8998-fxtec-pro1.dts
+++ b/arch/arm64/boot/dts/qcom/msm8998-fxtec-pro1.dts
@@ -390,7 +390,7 @@ &replicator1 {
 };
 
 &rpm_requests {
-	pm8998-regulators {
+	regulators-0 {
 		compatible = "qcom,rpm-pm8998-regulators";
 
 		vdd_s1-supply = <&vph_pwr>;
@@ -588,7 +588,7 @@ vreg_lvs2a_1p8: lvs2 {
 
 	};
 
-	pmi8998-regulators {
+	regulators-1 {
 		compatible = "qcom,rpm-pmi8998-regulators";
 
 		vdd_bob-supply = <&vph_pwr>;
diff --git a/arch/arm64/boot/dts/qcom/msm8998-mtp.dts b/arch/arm64/boot/dts/qcom/msm8998-mtp.dts
index a3ca58100aee..abea3ffa0094 100644
--- a/arch/arm64/boot/dts/qcom/msm8998-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/msm8998-mtp.dts
@@ -168,7 +168,7 @@ &replicator1 {
 };
 
 &rpm_requests {
-	pm8998-regulators {
+	regulators-0 {
 		compatible = "qcom,rpm-pm8998-regulators";
 
 		vdd_s1-supply = <&vph_pwr>;
@@ -366,7 +366,7 @@ vreg_lvs2a_1p8: lvs2 {
 
 	};
 
-	pmi8998-regulators {
+	regulators-1 {
 		compatible = "qcom,rpm-pmi8998-regulators";
 
 		vdd_bob-supply = <&vph_pwr>;
diff --git a/arch/arm64/boot/dts/qcom/msm8998-oneplus-common.dtsi b/arch/arm64/boot/dts/qcom/msm8998-oneplus-common.dtsi
index 62bda23791bb..3af6deed2e86 100644
--- a/arch/arm64/boot/dts/qcom/msm8998-oneplus-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998-oneplus-common.dtsi
@@ -288,7 +288,7 @@ &qusb2phy {
 };
 
 &rpm_requests {
-	pm8998-regulators {
+	regulators-0 {
 		compatible = "qcom,rpm-pm8998-regulators";
 
 		vdd_s1-supply = <&vph_pwr>;
@@ -477,7 +477,7 @@ vreg_l28_3p0: l28 {
 		vreg_lvs2a_1p8: lvs2 { };
 	};
 
-	pmi8998-regulators {
+	regulators-1 {
 		compatible = "qcom,rpm-pmi8998-regulators";
 
 		vdd_bob-supply = <&vph_pwr>;
diff --git a/arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino.dtsi b/arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino.dtsi
index d08639082247..47cd3caa6927 100644
--- a/arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino.dtsi
@@ -375,7 +375,7 @@ &qusb2phy {
 };
 
 &rpm_requests {
-	pm8998-regulators {
+	regulators-0 {
 		compatible = "qcom,rpm-pm8998-regulators";
 
 		vdd_s1-supply = <&vph_pwr>;
@@ -538,7 +538,7 @@ vreg_l28_3p0: l28 {
 		vreg_lvs2a_1p8: lvs2 { };
 	};
 
-	pmi8998-regulators {
+	regulators-1 {
 		compatible = "qcom,rpm-pmi8998-regulators";
 
 		vdd_bob-supply = <&vph_pwr>;
diff --git a/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi b/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
index 1678ef0f8684..dbbe1653718b 100644
--- a/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
@@ -125,7 +125,7 @@ &remoteproc_wcss {
 };
 
 &rpm_requests {
-	pms405-regulators {
+	regulators {
 		compatible = "qcom,rpm-pms405-regulators";
 
 		vdd_s1-supply = <&vph_pwr>;
diff --git a/arch/arm64/boot/dts/qcom/sda660-inforce-ifc6560.dts b/arch/arm64/boot/dts/qcom/sda660-inforce-ifc6560.dts
index 28050bc5f081..f62a74f0e8f0 100644
--- a/arch/arm64/boot/dts/qcom/sda660-inforce-ifc6560.dts
+++ b/arch/arm64/boot/dts/qcom/sda660-inforce-ifc6560.dts
@@ -231,7 +231,7 @@ &qusb2phy1 {
 };
 
 &rpm_requests {
-	pm660-regulators {
+	regulators-0 {
 		compatible = "qcom,rpm-pm660-regulators";
 
 		vdd_s1-supply = <&vph_pwr>;
@@ -313,7 +313,7 @@ vreg_l19a_3p3: l19 {
 		};
 	};
 
-	pm660l-regulators {
+	regulators-1 {
 		compatible = "qcom,rpm-pm660l-regulators";
 
 		vdd_s1-supply = <&vph_pwr>;
diff --git a/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile.dtsi b/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile.dtsi
index 09c07800793a..f9e1d599466a 100644
--- a/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile.dtsi
@@ -260,7 +260,7 @@ &qusb2phy0 {
 };
 
 &rpm_requests {
-	pm660l-regulators {
+	regulators-0 {
 		compatible = "qcom,rpm-pm660l-regulators";
 
 		vdd_s1-supply = <&vph_pwr>;
@@ -394,7 +394,7 @@ vreg_bob: bob {
 		};
 	};
 
-	pm660-regulators {
+	regulators-1 {
 		compatible = "qcom,rpm-pm660-regulators";
 
 		vdd_s1-supply = <&vph_pwr>;
diff --git a/arch/arm64/boot/dts/qcom/sdm632-fairphone-fp3.dts b/arch/arm64/boot/dts/qcom/sdm632-fairphone-fp3.dts
index 891e314bc782..c238fba2fe7c 100644
--- a/arch/arm64/boot/dts/qcom/sdm632-fairphone-fp3.dts
+++ b/arch/arm64/boot/dts/qcom/sdm632-fairphone-fp3.dts
@@ -69,7 +69,7 @@ &sdhc_2 {
 };
 
 &rpm_requests {
-	pm8953-regulators {
+	regulators {
 		compatible = "qcom,rpm-pm8953-regulators";
 
 		vdd_l1-supply = <&pm8953_s3>;
diff --git a/arch/arm64/boot/dts/qcom/sdm660-xiaomi-lavender.dts b/arch/arm64/boot/dts/qcom/sdm660-xiaomi-lavender.dts
index a3559f6e34a5..fea2c3e416e5 100644
--- a/arch/arm64/boot/dts/qcom/sdm660-xiaomi-lavender.dts
+++ b/arch/arm64/boot/dts/qcom/sdm660-xiaomi-lavender.dts
@@ -111,7 +111,7 @@ &qusb2phy0 {
 };
 
 &rpm_requests {
-	pm660l-regulators {
+	regulators-0 {
 		compatible = "qcom,rpm-pm660l-regulators";
 
 		vdd_s1-supply = <&vph_pwr>;
@@ -206,7 +206,7 @@ vreg_bob: bob {
 		};
 	};
 
-	pm660-regulators {
+	regulators-1 {
 		compatible = "qcom,rpm-pm660-regulators";
 
 		vdd_s1-supply = <&vph_pwr>;
-- 
2.34.1

