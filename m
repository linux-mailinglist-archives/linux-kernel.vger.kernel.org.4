Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03C7267E40B
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 12:48:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234084AbjA0Lr4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 06:47:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233985AbjA0LrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 06:47:20 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E14A78AFD
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 03:45:24 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id k16so3253211wms.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 03:45:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cTd8MnH+nkLD/WD63jBeNkqDveSl0nTyS0QG26TUbhE=;
        b=ZGK5hFsH7bKOfkE51VDyoiS1Dzgk1mk5ZZJqacEQsd37laQjgYOWDgJslPTLI9Wqpa
         hbV+uUF4qe7HVwVv7dKFFx+paELC/IntDHs2ZE0C3DkVaVrC10l+mQ9VqN3b+CwQLZqc
         RSYTQ9ZCvzl/VdYa9FszQ7zlaOGXJA5BflKaTrLD/pr8gNh0o7jMFPAGRT+vC5QKLFHk
         r7qb9NcUJePlPAbki4JpYkdquVHwcVR4xwn3TgA0CaIo8+Amplh8p3v2L4QzHiv8g79W
         nybOy8W4ugC9OUgtPI944Cx6LGxs1MxvzXtOas983jess6KmGmHXzNzlteNkS0AQwd8Q
         i0bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cTd8MnH+nkLD/WD63jBeNkqDveSl0nTyS0QG26TUbhE=;
        b=2ZvPfMWn8PG4xx/ePHEjEMkDoTyHtAx8nv7oXj5dfVLihQiUIwHtTRNdTndb16HHfO
         p9a5q4dwePyZtYPLg7Z12RG5uepVCnI+FqQvfWe69SWwfmYALOggPsJFitOflGG0ZY38
         QQUmiVycsRKBFo4V0I5PlrcOXRRNlauoYRBxtLKSeD2XaiNazF8c39yv9Rix5x4DyAzS
         oQczHnaACs3ibys2+8Eoa1PhuukUjoseWWBT7vIHY0l6NBzmce6JqgcNcTsnrf8Y8Hsy
         RYr6okGopSvCXqrVebMN0SuMiv8BLepaaFFSLqHCcVw6guZg4AlI0LIEk3lAcn2ATvl6
         9YmA==
X-Gm-Message-State: AFqh2kpTu77Jof0oQP0nW9di4aJjBJneEzX1iBmrE1XDEJuLuES2yNaC
        qTB+J+WbOSIXuqWSm4QEHhKw0Q==
X-Google-Smtp-Source: AMrXdXvysnf4/pWxXbCGYH3aMKH6j07xjehYXGWRDisN/oghZ7KUcEQwCAbeTWwk/oAQkchUqK3STg==
X-Received: by 2002:a05:600c:5252:b0:3da:2500:e702 with SMTP id fc18-20020a05600c525200b003da2500e702mr36738862wmb.32.1674819864999;
        Fri, 27 Jan 2023 03:44:24 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id z14-20020a5d4c8e000000b002bfc2d0eff0sm3807760wrs.47.2023.01.27.03.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 03:44:24 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 10/11] arm64: dts: qcom: sm8350: align RPMh regulator nodes with bindings
Date:   Fri, 27 Jan 2023 12:43:46 +0100
Message-Id: <20230127114347.235963-10-krzysztof.kozlowski@linaro.org>
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
 arch/arm64/boot/dts/qcom/sm8350-hdk.dts                    | 4 ++--
 arch/arm64/boot/dts/qcom/sm8350-microsoft-surface-duo2.dts | 4 ++--
 arch/arm64/boot/dts/qcom/sm8350-mtp.dts                    | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8350-hdk.dts b/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
index 5a4c4ea4d122..0dab73c0c537 100644
--- a/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
+++ b/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
@@ -73,7 +73,7 @@ &adsp {
 };
 
 &apps_rsc {
-	pm8350-rpmh-regulators {
+	regulators-0 {
 		compatible = "qcom,pm8350-rpmh-regulators";
 		qcom,pmic-id = "b";
 
@@ -178,7 +178,7 @@ vreg_l9b_1p2: ldo9 {
 		};
 	};
 
-	pm8350c-rpmh-regulators {
+	regulators-1 {
 		compatible = "qcom,pm8350c-rpmh-regulators";
 		qcom,pmic-id = "c";
 
diff --git a/arch/arm64/boot/dts/qcom/sm8350-microsoft-surface-duo2.dts b/arch/arm64/boot/dts/qcom/sm8350-microsoft-surface-duo2.dts
index 00f16cde6c4a..b536ae36ae6d 100644
--- a/arch/arm64/boot/dts/qcom/sm8350-microsoft-surface-duo2.dts
+++ b/arch/arm64/boot/dts/qcom/sm8350-microsoft-surface-duo2.dts
@@ -44,7 +44,7 @@ &adsp {
 };
 
 &apps_rsc {
-	pm8350-rpmh-regulators {
+	regulators-0 {
 		compatible = "qcom,pm8350-rpmh-regulators";
 		qcom,pmic-id = "b";
 
@@ -135,7 +135,7 @@ vreg_l9b_1p2: ldo9 {
 		};
 	};
 
-	pm8350c-rpmh-regulators {
+	regulators-1 {
 		compatible = "qcom,pm8350c-rpmh-regulators";
 		qcom,pmic-id = "c";
 
diff --git a/arch/arm64/boot/dts/qcom/sm8350-mtp.dts b/arch/arm64/boot/dts/qcom/sm8350-mtp.dts
index f70e0de0509c..d21d2aacf201 100644
--- a/arch/arm64/boot/dts/qcom/sm8350-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sm8350-mtp.dts
@@ -43,7 +43,7 @@ &adsp {
 };
 
 &apps_rsc {
-	pm8350-rpmh-regulators {
+	regulators-0 {
 		compatible = "qcom,pm8350-rpmh-regulators";
 		qcom,pmic-id = "b";
 
@@ -134,7 +134,7 @@ vreg_l9b_1p2: ldo9 {
 		};
 	};
 
-	pm8350c-rpmh-regulators {
+	regulators-1 {
 		compatible = "qcom,pm8350c-rpmh-regulators";
 		qcom,pmic-id = "c";
 
-- 
2.34.1

