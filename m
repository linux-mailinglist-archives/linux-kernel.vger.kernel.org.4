Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BFF367E484
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 13:04:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233580AbjA0MER (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 07:04:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233131AbjA0MDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 07:03:37 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF6DB7F31A
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 03:58:45 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id k38so5288912lje.5
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 03:58:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8/ptUxWMVTor6ntL9qaeIR6q6ULD16W0rtO/BKKve5U=;
        b=XpotfwvpwAyGdoLduq0wPKd+083oPmahqGb7dlU8BlHWvAA96vR7dtTVV8ulA3RJNZ
         OBapABPXKZsSh1HFJ4Mn3CJwvJDpA9hNRsiqi8E6mmzYMz8aCPwV8j4kJ/21LjcV5ycI
         TYXpVOFQUAgdoYJ88TiMpXVb0JV+als1/o+iTwoI2IoERkn4ht8H76hz4qBd//iKjo7Z
         abS3+A6Hwqa/IlSaxEcTQlmUU9/xqg+TfbIKaZ4zQVfdhCbaWZLj7YNNLDCdJUgm/Bcd
         gT0zARKKXH9/KoCQvBEdg0AuQzPpogTevN++TXasThHX5F55KFhT6C0nfhKbNw1AEie3
         xZXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8/ptUxWMVTor6ntL9qaeIR6q6ULD16W0rtO/BKKve5U=;
        b=tg2ZpxyM1mXdmW/mZ/BrS6AvpnTajDu9PMtGNbfeqIYaoN+XU5iKAgMHRzFv1gjJ41
         tZPir88I3hlmx8L6DNdiT6JrTCloqoDfdCXXwXvLpkIh8QyPl+4pPU5dFOW3cIF0qxyx
         8sB+EPRAZlsKr0X6UGBmhU/qfiuf2/DTy8TAW8KQYitODo6H+VEWA+Z6ctDFDiT5NviD
         R2W+vP6E5jX6QIlSCxefRwG+yyh0hE8ZzyX59hxe2h+Pkk4T725EGmCkP+C8R95ON1j4
         XRqmUJI7AerGmrqsE1CttptTh4YSxwVlSQ/I0TusY+gKtQasJmK294ggmku9VyagAAiV
         RvVA==
X-Gm-Message-State: AFqh2koLXIZHWZC4eD3+Ggp8+9PfAZTb8vW9ffrFpNiZjYdQAfEwP5k6
        UsGD9isGmsy5tmL2nirJCpKnfupjr0Cew0Zp
X-Google-Smtp-Source: AMrXdXtLkvzlKZwvzP7lcAlgGNjOGsSgHy9Ervuin0Wvk2cBJco0Vuy8P/UFMjU5kcu/IFDr+h2FPw==
X-Received: by 2002:a5d:60c7:0:b0:2bd:e592:5460 with SMTP id x7-20020a5d60c7000000b002bde5925460mr33113262wrt.39.1674819862219;
        Fri, 27 Jan 2023 03:44:22 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id z14-20020a5d4c8e000000b002bfc2d0eff0sm3807760wrs.47.2023.01.27.03.44.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 03:44:21 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 08/11] arm64: dts: qcom: sm8150: align RPMh regulator nodes with bindings
Date:   Fri, 27 Jan 2023 12:43:44 +0100
Message-Id: <20230127114347.235963-8-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230127114347.235963-1-krzysztof.kozlowski@linaro.org>
References: <20230127114347.235963-1-krzysztof.kozlowski@linaro.org>
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

Device node names should be generic and bindings expect certain pattern
for RPMh regulator nodes.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sa8155p-adp.dts                  | 4 ++--
 arch/arm64/boot/dts/qcom/sm8150-hdk.dts                   | 6 +++---
 arch/arm64/boot/dts/qcom/sm8150-microsoft-surface-duo.dts | 6 +++---
 arch/arm64/boot/dts/qcom/sm8150-mtp.dts                   | 6 +++---
 arch/arm64/boot/dts/qcom/sm8150-sony-xperia-kumano.dtsi   | 4 ++--
 5 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sa8155p-adp.dts b/arch/arm64/boot/dts/qcom/sa8155p-adp.dts
index eafdfbbf40b9..459384ec8f23 100644
--- a/arch/arm64/boot/dts/qcom/sa8155p-adp.dts
+++ b/arch/arm64/boot/dts/qcom/sa8155p-adp.dts
@@ -72,7 +72,7 @@ queue0 {
 };
 
 &apps_rsc {
-	pmm8155au-1-rpmh-regulators {
+	regulators-0 {
 		compatible = "qcom,pmm8155au-rpmh-regulators";
 		qcom,pmic-id = "a";
 
@@ -201,7 +201,7 @@ vreg_l17a_2p96: ldo17 {
 		};
 	};
 
-	pmm8155au-2-rpmh-regulators {
+	regulators-1 {
 		compatible = "qcom,pmm8155au-rpmh-regulators";
 		qcom,pmic-id = "c";
 
diff --git a/arch/arm64/boot/dts/qcom/sm8150-hdk.dts b/arch/arm64/boot/dts/qcom/sm8150-hdk.dts
index 3331ee957d64..8f014a232526 100644
--- a/arch/arm64/boot/dts/qcom/sm8150-hdk.dts
+++ b/arch/arm64/boot/dts/qcom/sm8150-hdk.dts
@@ -56,7 +56,7 @@ key-vol-up {
 };
 
 &apps_rsc {
-	pm8150-rpmh-regulators {
+	regulators-0 {
 		compatible = "qcom,pm8150-rpmh-regulators";
 		qcom,pmic-id = "a";
 
@@ -211,7 +211,7 @@ vreg_l17a_3p0: ldo17 {
 		};
 	};
 
-	pm8150l-rpmh-regulators {
+	regulators-1 {
 		compatible = "qcom,pm8150l-rpmh-regulators";
 		qcom,pmic-id = "c";
 
@@ -324,7 +324,7 @@ vreg_l11c_3p3: ldo11 {
 		};
 	};
 
-	pm8009-rpmh-regulators {
+	regulators-2 {
 		compatible = "qcom,pm8009-rpmh-regulators";
 		qcom,pmic-id = "f";
 
diff --git a/arch/arm64/boot/dts/qcom/sm8150-microsoft-surface-duo.dts b/arch/arm64/boot/dts/qcom/sm8150-microsoft-surface-duo.dts
index 5397fba9417b..69024f7c7f10 100644
--- a/arch/arm64/boot/dts/qcom/sm8150-microsoft-surface-duo.dts
+++ b/arch/arm64/boot/dts/qcom/sm8150-microsoft-surface-duo.dts
@@ -61,7 +61,7 @@ key-vol-up {
 };
 
 &apps_rsc {
-	pm8150-rpmh-regulators {
+	regulators-0 {
 		compatible = "qcom,pm8150-rpmh-regulators";
 		qcom,pmic-id = "a";
 
@@ -216,7 +216,7 @@ vreg_l17a_3p0: ldo17 {
 		};
 	};
 
-	pm8150l-rpmh-regulators {
+	regulators-1 {
 		compatible = "qcom,pm8150l-rpmh-regulators";
 		qcom,pmic-id = "c";
 
@@ -329,7 +329,7 @@ vreg_l11c_3p3: ldo11 {
 		};
 	};
 
-	pm8009-rpmh-regulators {
+	regulators-2 {
 		compatible = "qcom,pm8009-rpmh-regulators";
 		qcom,pmic-id = "f";
 
diff --git a/arch/arm64/boot/dts/qcom/sm8150-mtp.dts b/arch/arm64/boot/dts/qcom/sm8150-mtp.dts
index 46b5cf9a1192..eff995a07ab7 100644
--- a/arch/arm64/boot/dts/qcom/sm8150-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sm8150-mtp.dts
@@ -51,7 +51,7 @@ vreg_s4a_1p8: pm8150-s4 {
 };
 
 &apps_rsc {
-	pm8150-rpmh-regulators {
+	regulators-0 {
 		compatible = "qcom,pm8150-rpmh-regulators";
 		qcom,pmic-id = "a";
 
@@ -206,7 +206,7 @@ vreg_l17a_3p0: ldo17 {
 		};
 	};
 
-	pm8150l-rpmh-regulators {
+	regulators-1 {
 		compatible = "qcom,pm8150l-rpmh-regulators";
 		qcom,pmic-id = "c";
 
@@ -319,7 +319,7 @@ vreg_l11c_3p3: ldo11 {
 		};
 	};
 
-	pm8009-rpmh-regulators {
+	regulators-2 {
 		compatible = "qcom,pm8009-rpmh-regulators";
 		qcom,pmic-id = "f";
 
diff --git a/arch/arm64/boot/dts/qcom/sm8150-sony-xperia-kumano.dtsi b/arch/arm64/boot/dts/qcom/sm8150-sony-xperia-kumano.dtsi
index 64602748c657..ff77cc3c879a 100644
--- a/arch/arm64/boot/dts/qcom/sm8150-sony-xperia-kumano.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150-sony-xperia-kumano.dtsi
@@ -173,7 +173,7 @@ &adsp_mem {
 };
 
 &apps_rsc {
-	pm8150-rpmh-regulators {
+	regulators-0 {
 		compatible = "qcom,pm8150-rpmh-regulators";
 		qcom,pmic-id = "a";
 
@@ -306,7 +306,7 @@ vreg_l18a_0p8: ldo18 {
 		};
 	};
 
-	pm8150l-rpmh-regulators {
+	regulators-1 {
 		compatible = "qcom,pm8150l-rpmh-regulators";
 		qcom,pmic-id = "c";
 
-- 
2.34.1

