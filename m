Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5625A67E404
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 12:47:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234058AbjA0Lrp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 06:47:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233174AbjA0LrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 06:47:06 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA6DE7264E
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 03:45:17 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id b7so4738970wrt.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 03:45:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DvMSj9iqeRYV3NvUP0rQ8YdBQVXqQ1YOPZf872GP8pE=;
        b=Habr8avg1xhSgWFlsH0AyZYmBVKWjUwp9ty+9pdXocUmz1w8IhcOsR3PRvHpSKZirr
         tPBAoS0pwF/W0typvg/QIxHpra1cUFg87LhojivEpRS4lXzD7sdUOmQWqE0rHR+UPAh4
         kc9OdJU0a0aBXgB03ZQtymNrWr/ruOa5sjaT+qNxsVbjhLU6rGReXKd4n/dtBJPtoozm
         6ihcg3WZsykwsnJpRafCuw45KGikLVc0znNPomQf0lPlXvr2jouy6sQkvdMgJHaDRPma
         eArSBDvzA9l+c6q9sI84hYzrzJkqPp1u95SMzXGjv8iT9erkYQSJ6vq36c4rkGt3iifa
         WPTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DvMSj9iqeRYV3NvUP0rQ8YdBQVXqQ1YOPZf872GP8pE=;
        b=KCVJvDY0PpdR4GMblI9dmbYWVY4TUKSE/2zeimNSt4t7T5Yr2P4N0glf3r0lOApA2v
         Wh1ajsCDPxhZoddbDlJV5sFlWXFrM0Te90wSacE2LgadUhET9Pe2QytX1TZmOT4Bewkc
         iHrALea/IW9RXkq5bPNklln0N9vAL8GzfXT7Taee+07cSfcaCWrZrFALCsdIpG6ZYGPb
         yWnPyXo3pyXc4BkYrQhG9z9AA0ySF64OMpHWdXThfdcwnL3hFGpwRJByFkmQ1IRuQ8PF
         AXi7jNtISGmh1LpCvNInTPJj5GpXG4HWc4h8SYmPQq4qMCkWKXbEyKdnGw2SQuIKRExQ
         E9QQ==
X-Gm-Message-State: AO0yUKVS31oAgw7Kplayo3H6dwD6NNkwPwbKuahqdjqHJNVhxMqkk6+6
        f82EJ2iJylWzCvNZskaMUdpuOQ==
X-Google-Smtp-Source: AK7set9Xp+uPc6Y33RlqLfCDUFb1zrulP/zwXpry8hXO+UrILVJcVBD2/1Wa7QbPmi3pnLCTMIl7Iw==
X-Received: by 2002:a05:6000:1c8:b0:2bf:d0a3:c968 with SMTP id t8-20020a05600001c800b002bfd0a3c968mr2234398wrx.0.1674819863546;
        Fri, 27 Jan 2023 03:44:23 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id z14-20020a5d4c8e000000b002bfc2d0eff0sm3807760wrs.47.2023.01.27.03.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 03:44:23 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 09/11] arm64: dts: qcom: sm8250: align RPMh regulator nodes with bindings
Date:   Fri, 27 Jan 2023 12:43:45 +0100
Message-Id: <20230127114347.235963-9-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230127114347.235963-1-krzysztof.kozlowski@linaro.org>
References: <20230127114347.235963-1-krzysztof.kozlowski@linaro.org>
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

Device node names should be generic and bindings expect certain pattern
for RPMh regulator nodes.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/qrb5165-rb5.dts             | 6 +++---
 arch/arm64/boot/dts/qcom/sm8250-hdk.dts              | 6 +++---
 arch/arm64/boot/dts/qcom/sm8250-mtp.dts              | 6 +++---
 arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo.dtsi | 6 +++---
 4 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
index 8c64cb060e21..e96aa5ccb679 100644
--- a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
+++ b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
@@ -238,7 +238,7 @@ &adsp {
 };
 
 &apps_rsc {
-	pm8009-rpmh-regulators {
+	regulators-0 {
 		compatible = "qcom,pm8009-1-rpmh-regulators";
 		qcom,pmic-id = "f";
 
@@ -284,7 +284,7 @@ vreg_l7f_1p8: ldo7 {
 		};
 	};
 
-	pm8150-rpmh-regulators {
+	regulators-1 {
 		compatible = "qcom,pm8150-rpmh-regulators";
 		qcom,pmic-id = "a";
 
@@ -417,7 +417,7 @@ vreg_s6a_0p95: smps6 {
 		};
 	};
 
-	pm8150l-rpmh-regulators {
+	regulators-2 {
 		compatible = "qcom,pm8150l-rpmh-regulators";
 		qcom,pmic-id = "c";
 
diff --git a/arch/arm64/boot/dts/qcom/sm8250-hdk.dts b/arch/arm64/boot/dts/qcom/sm8250-hdk.dts
index 632e98193d27..0aee7f8658b4 100644
--- a/arch/arm64/boot/dts/qcom/sm8250-hdk.dts
+++ b/arch/arm64/boot/dts/qcom/sm8250-hdk.dts
@@ -65,7 +65,7 @@ key-vol-up {
 };
 
 &apps_rsc {
-	pm8150-rpmh-regulators {
+	regulators-0 {
 		compatible = "qcom,pm8150-rpmh-regulators";
 		qcom,pmic-id = "a";
 
@@ -199,7 +199,7 @@ vreg_l18a_0p92: ldo18 {
 		};
 	};
 
-	pm8150l-rpmh-regulators {
+	regulators-1 {
 		compatible = "qcom,pm8150l-rpmh-regulators";
 		qcom,pmic-id = "c";
 
@@ -310,7 +310,7 @@ vreg_l11c_3p3: ldo11 {
 		};
 	};
 
-	pm8009-rpmh-regulators {
+	regulators-2 {
 		compatible = "qcom,pm8009-rpmh-regulators";
 		qcom,pmic-id = "f";
 
diff --git a/arch/arm64/boot/dts/qcom/sm8250-mtp.dts b/arch/arm64/boot/dts/qcom/sm8250-mtp.dts
index 0991b34a8e49..0de8f2320b01 100644
--- a/arch/arm64/boot/dts/qcom/sm8250-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sm8250-mtp.dts
@@ -187,7 +187,7 @@ &adsp {
 };
 
 &apps_rsc {
-	pm8150-rpmh-regulators {
+	regulators-0 {
 		compatible = "qcom,pm8150-rpmh-regulators";
 		qcom,pmic-id = "a";
 
@@ -321,7 +321,7 @@ vreg_l18a_0p9: ldo18 {
 		};
 	};
 
-	pm8150l-rpmh-regulators {
+	regulators-1 {
 		compatible = "qcom,pm8150l-rpmh-regulators";
 		qcom,pmic-id = "c";
 
@@ -432,7 +432,7 @@ vreg_l11c_3p3: ldo11 {
 		};
 	};
 
-	pm8009-rpmh-regulators {
+	regulators-2 {
 		compatible = "qcom,pm8009-rpmh-regulators";
 		qcom,pmic-id = "f";
 
diff --git a/arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo.dtsi b/arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo.dtsi
index e76d0ef5aec9..b9c982a059df 100644
--- a/arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo.dtsi
@@ -123,7 +123,7 @@ &adsp {
 };
 
 &apps_rsc {
-	pm8150-rpmh-regulators {
+	regulators-0 {
 		compatible = "qcom,pm8150-rpmh-regulators";
 		qcom,pmic-id = "a";
 
@@ -247,7 +247,7 @@ vreg_l18a_0p9: ldo18 {
 	 * ab: 4600000-6100000
 	 * ibb: 800000-5400000
 	 */
-	pm8150l-rpmh-regulators {
+	regulators-1 {
 		compatible = "qcom,pm8150l-rpmh-regulators";
 		qcom,pmic-id = "c";
 
@@ -360,7 +360,7 @@ vreg_l11c_3p0: ldo11 {
 		};
 	};
 
-	pm8009-rpmh-regulators {
+	regulators-2 {
 		compatible = "qcom,pm8009-rpmh-regulators";
 		qcom,pmic-id = "f";
 
-- 
2.34.1

