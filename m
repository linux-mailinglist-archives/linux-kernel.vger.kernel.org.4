Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5520A734283
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 19:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346266AbjFQRQS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 13:16:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236139AbjFQRP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 13:15:56 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 023EE1BC9
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 10:15:55 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-977d55ac17bso299629766b.3
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 10:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687022153; x=1689614153;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kPDYBUqR9l7ZWoKsqO3wGVGBzQKRhUym+LyVhNjS9Kc=;
        b=HteCPkFhJQffzVFaLvd6umeUyL7SlMRq6RORzp4o0hyw7uRzMRSu4F72dV75NC2aHX
         z0iJxdS2ztOEgudJU2Fba7CX+Zl44yAq62rKZdjxnKBV6UFvbGJSPaPDzdF1YbEddidi
         k2iAuzLMpm5kewWTLG+7a093qp/M0nmLgxCUl7EqpxJqnxAUgEzK/wLC8ieDcLEd8yMW
         KYuvZusSD4/M94SRt0Uq5ix7gPpDiCzD4Gsu0dcxTFyaLxP9F4AIMiHqcwZr+y9jut0x
         pQ8kRo3fknOKr+e05A76YJfyU/1QHm8UB4MZznDK0Egw7XwhoJHC+T1dKtm0FbCWjpxN
         92sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687022153; x=1689614153;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kPDYBUqR9l7ZWoKsqO3wGVGBzQKRhUym+LyVhNjS9Kc=;
        b=Ti8/WxmWLbyogc6u2CKtAiK9Z+1VRavvz0cXDsjd4OfIWV0C33ecmRnMvVRpWNhxIp
         lZR4awNdI45B2pAXMv+tcSUMKM8b9R1TqgPTiaS2pVPpdst1zN6I+A1zkBNyU+zsrd0e
         Mz8TUYdfx8058Sj7XpkVCeQr739bmzaCOudQpn/U22mY/64PzKKS36DhLZj/01IiFXUr
         LwrgtGYrsJSZNu4uJ7YoACAIJfXuLdpeqf/7OB8j1IQ7qINObNmHqOOUzc71tL/DE1VQ
         CtJLIeiJAJ0Q8/C+YHP2LYQTPWYI4iV6+/jA1rDmoN+/+KkYiyeEd0z5sPM917J5ve/V
         Ug7w==
X-Gm-Message-State: AC+VfDyRj9rn/VnYxMZ/ClB7LBDKTwbAJILqg8DqOLhqZ7HvKf7jZNTX
        7JYE1RIWwEL0KpLxu0QxSLLqYQ==
X-Google-Smtp-Source: ACHHUZ4Cq0GZsuQSaHZn8Rw/ZWdz7BHEt0h0zCZyh62j4vXwIejL/QxrcveNtss5TqiEar5Sp3i0vw==
X-Received: by 2002:a17:907:360e:b0:96a:4ea0:a1e7 with SMTP id bk14-20020a170907360e00b0096a4ea0a1e7mr5307339ejc.50.1687022153375;
        Sat, 17 Jun 2023 10:15:53 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id os5-20020a170906af6500b009829dc0f2a0sm3841897ejb.111.2023.06.17.10.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jun 2023 10:15:53 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org,
        Nikita Travkin <nikita@trvn.ru>,
        Stephan Gerhold <stephan@gerhold.net>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 07/15] arm64: dts: qcom: msm8996-xiaomi: use generic node names
Date:   Sat, 17 Jun 2023 19:15:33 +0200
Message-Id: <20230617171541.286957-7-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230617171541.286957-1-krzysztof.kozlowski@linaro.org>
References: <20230617171541.286957-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use generic node names for I2C devices.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8996-xiaomi-common.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8996-xiaomi-common.dtsi b/arch/arm64/boot/dts/qcom/msm8996-xiaomi-common.dtsi
index 8c2d6e9e851b..bcd2397eb373 100644
--- a/arch/arm64/boot/dts/qcom/msm8996-xiaomi-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996-xiaomi-common.dtsi
@@ -189,7 +189,7 @@ &blsp2_i2c2 {
 	status = "okay";
 	clock-frequency = <400000>;
 
-	nfc: pn548@28 {
+	nfc: nfc@28 {
 		compatible = "nxp,nxp-nci-i2c";
 
 		reg = <0x28>;
@@ -208,7 +208,7 @@ nfc: pn548@28 {
 &blsp2_i2c3 {
 	status = "okay";
 
-	typec: tusb320l@47 {
+	typec: typec@47 {
 		compatible = "ti,tusb320l";
 		reg = <0x47>;
 		interrupt-parent = <&tlmm>;
-- 
2.34.1

