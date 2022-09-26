Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3D175E9D7A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 11:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234140AbiIZJYf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 05:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233711AbiIZJXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 05:23:02 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8E7E40BF3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 02:21:17 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id g20so6693243ljg.7
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 02:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=sVidsYs1jqb7FOV+eq1s/j1tEtW/eenq8/bPkK9cMMw=;
        b=iOuZBSGv+f4VKMPdXzBNdjrPG6B9tWlDMxUfxzmHbsstNsj7rwGiXbYpp2MThJa8GG
         BTjTCOW0tNiuv3S4yyV+Y1AP9VqHxaHmC+RMakDtw6dV8jIGH+Fl3FAtB4kLizHsHUF2
         t2xUzOVXkifJb4aGtwyeuvI3xOFDX6HUgM0jYxFZsIEQ0YvWR/1qMdcqu/zVTPeyoBCn
         Gf7d12NpttZnY46yo8rj3HGHwB7xv8Yt1/awH5z9imRs32uCFiBv/inMvVcwKYSynb0+
         gosjEvBUeJxkfPmebRz+7psMhBG5BV3EWfluwhQEvxArBHBjEBztTJZ5s46uQTUS8nvd
         0Tsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=sVidsYs1jqb7FOV+eq1s/j1tEtW/eenq8/bPkK9cMMw=;
        b=A2kiDcsYD8xWKae9cJifV+MwpX5XZaBiw+qTXNDd2PrUImXvwSKWXW2kMz/vPQpJhq
         Klp/55I/FzcGvuIz9PLhkzChC/vm/2+WL2yeIL5xm3JhOBxH6255rIQuDh4MTplj/y5K
         Y80vwbJmVUhwpAL87HPrkYkx6UQNcO8r9Jx+JJGo2mJcdv1g0+qVLWLwyic+FncO8vZy
         DLavawpRxq1v8RoBtUh08a7A71JZGGvVIuhHIPoQ8CKHAa1PWLIEJXlqPtys699mQSSw
         cRj5Erg9mOkhaYmo3dzXu3aemMADltQ78fSoduXqlqjnev7XTxp1mG5H67CqA4oSyZGc
         ekEg==
X-Gm-Message-State: ACrzQf3U+a8VQIJh2118mDL9vxTFGKvEUh/Sv92YDw9LiGQuvIltX4Od
        InHNpR34ivLYMJ+e9jEbTWRCTA==
X-Google-Smtp-Source: AMsMyM74X0xQr/cDy8UaZmyvmLbIaS4wWMvLlxsizDSucSuDBRztJdhsyXAvmmhotg1m+OAAKyGUvg==
X-Received: by 2002:a2e:ba08:0:b0:26c:14d6:9b97 with SMTP id p8-20020a2eba08000000b0026c14d69b97mr7163744lja.222.1664184076171;
        Mon, 26 Sep 2022 02:21:16 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id g8-20020a2ea4a8000000b0026c3ecf9a39sm2325600ljm.38.2022.09.26.02.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 02:21:15 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [RESEND PATCH v2 4/4] ARM: dts: qcom: align RPM regulators node name with bindings
Date:   Mon, 26 Sep 2022 11:21:04 +0200
Message-Id: <20220926092104.111449-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220926092104.111449-1-krzysztof.kozlowski@linaro.org>
References: <20220926092104.111449-1-krzysztof.kozlowski@linaro.org>
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

Node names should be generic and new DT schema expects RPM regulators
node to be just "regulators".

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes since v1:
1. Fix more nodes.
2. Do not shuffle regulators around as it might impact probe order.
---
 arch/arm/boot/dts/qcom-apq8026-asus-sparrow.dts               | 2 +-
 arch/arm/boot/dts/qcom-apq8026-lg-lenok.dts                   | 2 +-
 arch/arm/boot/dts/qcom-apq8074-dragonboard.dts                | 4 ++--
 arch/arm/boot/dts/qcom-apq8084.dtsi                           | 2 +-
 arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts      | 4 ++--
 arch/arm/boot/dts/qcom-msm8974-sony-xperia-rhine.dtsi         | 4 ++--
 arch/arm/boot/dts/qcom-msm8974pro-fairphone-fp2.dts           | 4 ++--
 arch/arm/boot/dts/qcom-msm8974pro-samsung-klte.dts            | 2 +-
 .../boot/dts/qcom-msm8974pro-sony-xperia-shinano-castor.dts   | 2 +-
 9 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-apq8026-asus-sparrow.dts b/arch/arm/boot/dts/qcom-apq8026-asus-sparrow.dts
index 215613c65250..7a80e1c9f126 100644
--- a/arch/arm/boot/dts/qcom-apq8026-asus-sparrow.dts
+++ b/arch/arm/boot/dts/qcom-apq8026-asus-sparrow.dts
@@ -87,7 +87,7 @@ &pm8226_vib {
 };
 
 &rpm_requests {
-	pm8226-regulators {
+	regulators {
 		compatible = "qcom,rpm-pm8226-regulators";
 
 		pm8226_s3: s3 {
diff --git a/arch/arm/boot/dts/qcom-apq8026-lg-lenok.dts b/arch/arm/boot/dts/qcom-apq8026-lg-lenok.dts
index 193569f0ca5f..061c02d1633e 100644
--- a/arch/arm/boot/dts/qcom-apq8026-lg-lenok.dts
+++ b/arch/arm/boot/dts/qcom-apq8026-lg-lenok.dts
@@ -115,7 +115,7 @@ bluetooth {
 };
 
 &rpm_requests {
-	pm8226-regulators {
+	regulators {
 		compatible = "qcom,rpm-pm8226-regulators";
 
 		pm8226_s3: s3 {
diff --git a/arch/arm/boot/dts/qcom-apq8074-dragonboard.dts b/arch/arm/boot/dts/qcom-apq8074-dragonboard.dts
index 91716298ec5e..3eb9275ec6d1 100644
--- a/arch/arm/boot/dts/qcom-apq8074-dragonboard.dts
+++ b/arch/arm/boot/dts/qcom-apq8074-dragonboard.dts
@@ -58,7 +58,7 @@ phy@b {
 };
 
 &rpm_requests {
-	pm8841-regulators {
+	regulators-0 {
 		compatible = "qcom,rpm-pm8841-regulators";
 
 		pm8841_s1: s1 {
@@ -82,7 +82,7 @@ pm8841_s4: s4 {
 		};
 	};
 
-	pm8941-regulators {
+	regulators-1 {
 		compatible = "qcom,rpm-pm8941-regulators";
 
 		vdd_l1_l3-supply = <&pm8941_s1>;
diff --git a/arch/arm/boot/dts/qcom-apq8084.dtsi b/arch/arm/boot/dts/qcom-apq8084.dtsi
index f2fb7c975af8..3cc69af9f320 100644
--- a/arch/arm/boot/dts/qcom-apq8084.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8084.dtsi
@@ -474,7 +474,7 @@ rpm-requests {
 				compatible = "qcom,rpm-apq8084";
 				qcom,smd-channels = "rpm_requests";
 
-				pma8084-regulators {
+				regulators-0 {
 					compatible = "qcom,rpm-pma8084-regulators";
 
 					pma8084_s1: s1 {};
diff --git a/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts b/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
index 6daceaa87802..3d5d0f2e2d96 100644
--- a/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
+++ b/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
@@ -344,7 +344,7 @@ led@5 {
 };
 
 &rpm_requests {
-	pm8841-regulators {
+	regulators-0 {
 		compatible = "qcom,rpm-pm8841-regulators";
 
 		pm8841_s1: s1 {
@@ -368,7 +368,7 @@ pm8841_s4: s4 {
 		};
 	};
 
-	pm8941-regulators {
+	regulators-1 {
 		compatible = "qcom,rpm-pm8941-regulators";
 
 		vdd_l1_l3-supply = <&pm8941_s1>;
diff --git a/arch/arm/boot/dts/qcom-msm8974-sony-xperia-rhine.dtsi b/arch/arm/boot/dts/qcom-msm8974-sony-xperia-rhine.dtsi
index 5a70683d9103..320c9bf397f8 100644
--- a/arch/arm/boot/dts/qcom-msm8974-sony-xperia-rhine.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8974-sony-xperia-rhine.dtsi
@@ -214,7 +214,7 @@ &pm8941_wled {
 };
 
 &rpm_requests {
-	pm8841-regulators {
+	regulators-0 {
 		compatible = "qcom,rpm-pm8841-regulators";
 
 		pm8841_s1: s1 {
@@ -238,7 +238,7 @@ pm8841_s4: s4 {
 		};
 	};
 
-	pm8941-regulators {
+	regulators-1 {
 		compatible = "qcom,rpm-pm8941-regulators";
 
 		vdd_l1_l3-supply = <&pm8941_s1>;
diff --git a/arch/arm/boot/dts/qcom-msm8974pro-fairphone-fp2.dts b/arch/arm/boot/dts/qcom-msm8974pro-fairphone-fp2.dts
index ff6e0066768b..9107bc6f24db 100644
--- a/arch/arm/boot/dts/qcom-msm8974pro-fairphone-fp2.dts
+++ b/arch/arm/boot/dts/qcom-msm8974pro-fairphone-fp2.dts
@@ -190,7 +190,7 @@ &remoteproc_mss {
 };
 
 &rpm_requests {
-	pm8841-regulators {
+	regulators-0 {
 		compatible = "qcom,rpm-pm8841-regulators";
 
 		pm8841_s1: s1 {
@@ -209,7 +209,7 @@ pm8841_s3: s3 {
 		};
 	};
 
-	pm8941-regulators {
+	regulators-1 {
 		compatible = "qcom,rpm-pm8941-regulators";
 
 		vdd_l1_l3-supply = <&pm8941_s1>;
diff --git a/arch/arm/boot/dts/qcom-msm8974pro-samsung-klte.dts b/arch/arm/boot/dts/qcom-msm8974pro-samsung-klte.dts
index 983e10c3d863..156023204c1e 100644
--- a/arch/arm/boot/dts/qcom-msm8974pro-samsung-klte.dts
+++ b/arch/arm/boot/dts/qcom-msm8974pro-samsung-klte.dts
@@ -470,7 +470,7 @@ &remoteproc_mss {
 };
 
 &rpm_requests {
-	pma8084-regulators {
+	regulators-0 {
 		compatible = "qcom,rpm-pma8084-regulators";
 
 		pma8084_s1: s1 {
diff --git a/arch/arm/boot/dts/qcom-msm8974pro-sony-xperia-shinano-castor.dts b/arch/arm/boot/dts/qcom-msm8974pro-sony-xperia-shinano-castor.dts
index 3f45f5c5d37b..e4580ed996e6 100644
--- a/arch/arm/boot/dts/qcom-msm8974pro-sony-xperia-shinano-castor.dts
+++ b/arch/arm/boot/dts/qcom-msm8974pro-sony-xperia-shinano-castor.dts
@@ -319,7 +319,7 @@ led@7 {
 };
 
 &rpm_requests {
-	pm8941-regulators {
+	regulators-0 {
 		compatible = "qcom,rpm-pm8941-regulators";
 
 		vdd_l1_l3-supply = <&pm8941_s1>;
-- 
2.34.1

