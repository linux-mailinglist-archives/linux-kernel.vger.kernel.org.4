Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC4D6E8BC9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 09:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234193AbjDTHvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 03:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234154AbjDTHv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 03:51:27 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEC7A5585
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 00:51:00 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-94f7a0818aeso40485166b.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 00:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681977058; x=1684569058;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y7TzpU6TgMuwz4sOGcNRBEuycSEzH4dOaJjh3nUn7qc=;
        b=BArUazQatTX4uQ3lJntVFYlnVxalexNHsj8sRBSTE9SffYpweHYhMIKCC6QDByxHP6
         v3x22KnSFv4rGHAcRLgiguR6DImfEgJe5C6JfE0fCZPa0+olU36NddJMwvkm11dTv53P
         oLSsQ2bypcePdH5m02Daa1UkhfzjTTrHIvG+786F1ogCcjwCVdeOCKKF/g+HC3v1yyxz
         ewfz23FJtY49Yro85mZNkzGsqochKhNdUGCPDOT9rrhKS8/FTxMrKp1UHrf+FTEDai5h
         KBlh3xIB9WKUwld4Zr2hG8tnuEbP+dUrq4sL31WjYTMd0hK93kHO3SWJavFcMeaBNACo
         m+rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681977058; x=1684569058;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y7TzpU6TgMuwz4sOGcNRBEuycSEzH4dOaJjh3nUn7qc=;
        b=NcCqV54YjkAX1wVY1eJSX9CAzuOGBPTdrgY366/oITr3oP/+8fi5oJ1NEj92f1hWB5
         W5CtkPd5oANBtzLStBHlyS0pbkBBMccGd6NBLXVkhs0eq7f13jteWda1DhSr3376RR6O
         tkahudFDuACw7q70aQkVqV8/ZKnQXlhqdQrTBGPxhtFzUAnM0cVI4DExpA9Toty2nUaD
         PT5LJX06f7qaYDV2M+1CWcBGadHC7ZK6A+kKyY9Tq1ABfkoJyJHgmou4EAhGdt8WaO04
         fyIHrIH64oKDhsczNuV9EE3Pw0/Ph7hbfLq3Ys5j4uFDuqMVtQDy+7jsG6AsIS1G/kHy
         bbWw==
X-Gm-Message-State: AAQBX9c7iL2Rf010i/Gpj8E4RF3NZRyRgrL0skJQcBmqdtA94Kz4b5SU
        S2brMirkiM0zWER1zd32FUbHVw==
X-Google-Smtp-Source: AKy350acwmM868Zvzlu6+qgmKVkLDKI5kLVRcybsnf/8BjFFKvlsHd+bG+TZOYysSgOJSNekdBPOvg==
X-Received: by 2002:aa7:c393:0:b0:4fb:4fc2:e600 with SMTP id k19-20020aa7c393000000b004fb4fc2e600mr802826edq.42.1681977058238;
        Thu, 20 Apr 2023 00:50:58 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:bcb8:77e6:8f45:4771])
        by smtp.gmail.com with ESMTPSA id h25-20020a50ed99000000b00505060e4280sm447165edr.94.2023.04.20.00.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 00:50:57 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 02/10] ARM: dts: qcom: sdx55: correct rsc unit-address
Date:   Thu, 20 Apr 2023 09:50:45 +0200
Message-Id: <20230420075053.41976-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230420075053.41976-1-krzysztof.kozlowski@linaro.org>
References: <20230420075053.41976-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Match unit-address to reg entry to fix dtbs W=1 warnings:

  Warning (simple_bus_reg): /soc/rsc@17840000: simple-bus unit address format error, expected "17830000"

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/qcom-sdx55.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/qcom-sdx55.dtsi b/arch/arm/boot/dts/qcom-sdx55.dtsi
index 72d82a9a6cc5..06c2646dd673 100644
--- a/arch/arm/boot/dts/qcom-sdx55.dtsi
+++ b/arch/arm/boot/dts/qcom-sdx55.dtsi
@@ -792,7 +792,7 @@ frame@17829000 {
 			};
 		};
 
-		apps_rsc: rsc@17840000 {
+		apps_rsc: rsc@17830000 {
 			compatible = "qcom,rpmh-rsc";
 			reg = <0x17830000 0x10000>, <0x17840000 0x10000>;
 			reg-names = "drv-0", "drv-1";
-- 
2.34.1

