Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20DDA69B004
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 16:59:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbjBQP66 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 10:58:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbjBQP6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 10:58:50 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9F445F81F
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 07:58:49 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id co2so5487968edb.13
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 07:58:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4jPvyv9I5wiu0UqUhJgWDDuJNNlu5P2BsRi/wHIwDbc=;
        b=a9uV58GEk+FUc8K7phf4KPxjwtO8DkbANSvWnfJPr0pZcuysJRUp2ohKo1ISVOR5A8
         443/0uLCDjColq3lUZmG19UutF4m6yIRu3WM93AxK12WGv15TzHYQDOXoxbjgHBSlges
         H80lh3YYcbIkSDTv6qFSyQkZ70bgwP4BGZEmWuSFYxa2pqk28oJbW1p/SNZpEDxzMim5
         UR1eK/Noyqo+EU2Lm7JqgNgktVHQuNOtE+DY2g0QZc3ELSDPV7+PuCG5Hc8ATvF/PLUp
         0aedsHuOCn24rP23RYTNQLUUyTHpKIdLNUQHOm28TiSN2bg1mvEkKv1DTmVnciFbeq8n
         nvDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4jPvyv9I5wiu0UqUhJgWDDuJNNlu5P2BsRi/wHIwDbc=;
        b=efA6b9980NvxXba2ca2EllpQa5HKKw9vuHw25WPHEGUgdY/+neYb5Lhh0xi6AHfkG1
         ewMVl64yLOMmQRGPQlx0KvPvYVbD0wLIB0S11WntZC0Hv/lcpW2DvOFei5w94cWqiz6/
         ebGOGAFaDDXH3mkKJbtd+9ijx++9JSWIIsT6Fy4Ms4tvMYHEUjYBBySRH5zH1GRe4RQZ
         Sv42riCS+CEh5wy+QSpZ/PvmvQKMLU2nwRxXt7OPeAXEre5XyC7OhaZepcOALkAqKN/r
         IiZosmgo0fJtdEbk8+krceg83GYRMDy1jf9gvF6ziXL9q94xJZVrr9DL6QdAxgvPoKTG
         E2IA==
X-Gm-Message-State: AO0yUKXqcQbX2pX/A9gf/W16Q+ywNkJGsenQIPGivaBxNmopGepBg9/S
        wncV5RcLXQBVxtSeqABz9xtbhQ==
X-Google-Smtp-Source: AK7set+joMfcLjTQD7eFiwgWm7xq5oE5NIIl4xcpSk5vjv9sKXfP5mg+4NzC2uQkmP+DVQ40Tu0pcg==
X-Received: by 2002:a17:906:2c15:b0:874:e17e:2526 with SMTP id e21-20020a1709062c1500b00874e17e2526mr214039ejh.72.1676649528379;
        Fri, 17 Feb 2023 07:58:48 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id i15-20020a17090685cf00b008b1435bd1cbsm2290068ejy.105.2023.02.17.07.58.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 07:58:48 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 3/3] arm64: dts: qcom: sc7280: align RPMh regulator nodes with bindings
Date:   Fri, 17 Feb 2023 16:58:38 +0100
Message-Id: <20230217155838.848403-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230217155838.848403-1-krzysztof.kozlowski@linaro.org>
References: <20230217155838.848403-1-krzysztof.kozlowski@linaro.org>
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

I was fixing these in other boards, but missed SC7280. Previous
(applied) set:
https://lore.kernel.org/r/20230127114347.235963-4-krzysztof.kozlowski@linaro.org
---
 arch/arm64/boot/dts/qcom/sc7280-crd-r3.dts        | 2 +-
 arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts | 2 +-
 arch/arm64/boot/dts/qcom/sc7280-idp.dts           | 2 +-
 arch/arm64/boot/dts/qcom/sc7280-idp.dtsi          | 4 ++--
 arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi        | 4 ++--
 5 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7280-crd-r3.dts b/arch/arm64/boot/dts/qcom/sc7280-crd-r3.dts
index 1185141f348e..afae7f46b050 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-crd-r3.dts
+++ b/arch/arm64/boot/dts/qcom/sc7280-crd-r3.dts
@@ -27,7 +27,7 @@ chosen {
 };
 
 &apps_rsc {
-	pmg1110-regulators {
+	regulators-2 {
 		compatible = "qcom,pmg1110-rpmh-regulators";
 		qcom,pmic-id = "k";
 
diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts b/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts
index 4e0b013e25f4..df39a64da923 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts
@@ -40,7 +40,7 @@ vreg_edp_bl_crd: vreg-edp-bl-crd-regulator {
 /* ADDITIONS TO NODES DEFINED IN PARENT DEVICE TREE FILES */
 
 &apps_rsc {
-	pmg1110-regulators {
+	regulators-2 {
 		compatible = "qcom,pmg1110-rpmh-regulators";
 		qcom,pmic-id = "k";
 
diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dts b/arch/arm64/boot/dts/qcom/sc7280-idp.dts
index ba64316b4427..15222e92e3f5 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-idp.dts
+++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dts
@@ -25,7 +25,7 @@ chosen {
 };
 
 &apps_rsc {
-	pmr735a-regulators {
+	regulators-2 {
 		compatible = "qcom,pmr735a-rpmh-regulators";
 		qcom,pmic-id = "e";
 
diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
index 8b5293e7fd2a..8ebcf763b3c7 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
@@ -184,7 +184,7 @@ codec {
 };
 
 &apps_rsc {
-	pm7325-regulators {
+	regulators-0 {
 		compatible = "qcom,pm7325-rpmh-regulators";
 		qcom,pmic-id = "b";
 
@@ -279,7 +279,7 @@ vreg_l19b_1p8: ldo19 {
 		};
 	};
 
-	pm8350c-regulators {
+	regulators-1 {
 		compatible = "qcom,pm8350c-rpmh-regulators";
 		qcom,pmic-id = "c";
 
diff --git a/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi b/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi
index 88204f794ccb..cb0cc2ba2fa3 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi
@@ -87,7 +87,7 @@ &apps_rsc {
 	 * are left out of here since they are managed elsewhere.
 	 */
 
-	pm7325-regulators {
+	regulators-0 {
 		compatible = "qcom,pm7325-rpmh-regulators";
 		qcom,pmic-id = "b";
 
@@ -188,7 +188,7 @@ vreg_l19b_1p8: ldo19 {
 		};
 	};
 
-	pm8350c-regulators {
+	regulators-1 {
 		compatible = "qcom,pm8350c-rpmh-regulators";
 		qcom,pmic-id = "c";
 
-- 
2.34.1

