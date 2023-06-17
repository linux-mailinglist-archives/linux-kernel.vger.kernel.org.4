Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4151573427E
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 19:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbjFQRQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 13:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235610AbjFQRPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 13:15:55 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F40A19B5
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 10:15:53 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-51a426e4f4bso1752835a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 10:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687022152; x=1689614152;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E3fL/vuoxoElzgTRhXtbCs3GCepR+1nYd4/v099vO00=;
        b=fO7E1yvm6C6AVVsqvNP3hNPlXaDzXghu2IIQcQekRyL0tGJqNwo2GEkfVtS9VS/jsF
         scbg0EJ6XDuzw0vxjMtd+9I0TcbUXnOJi0tFtuQ34ZpEd8W99RrZo3PmNsCY+LqWibDP
         uFNXUXuoEyprVy8MjLJlyPez9Ik+f/+jsC2ifkj013GBANbNQTJN9KlKaJI4faWFG6Aw
         WMnDfIRVkYQBqLZ8mrJn1dv3HX6+SYKBSk84BdrBaAqXGv9hB8IS2+15VR1ap6WXlFun
         VXhai1Q+Nk6WWtz2i7MMhLg63mYKqnW4W3spi1uQJYFPPMgGDq0gCCgPrm2Vlsj1PmZA
         XmRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687022152; x=1689614152;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E3fL/vuoxoElzgTRhXtbCs3GCepR+1nYd4/v099vO00=;
        b=EDovgb8EAFNVg6GBuKphKuqJsO/A2nwcypfjqwH8UkRLGIDLp0EDNMs5qjDlVaotwE
         pHR2XpLySiSqywljHTcuTcFjFUCFybFHtCLmSQQ0P5uaoCpjPHGH7OxXjvDCBjFX2Nlt
         55HXJKjCuRlTpyh6OaGAlgalhfT3bHmk4SRZwXPeznCTD/cdPh6th5skqBaNeArepZKj
         lfmk93tLXhAmeITG5c78S4JV+alEbJcIUH0eXmiTB8QsI7GTxRHOP4vDI5I8m/NV+Fui
         8BFpYlKSXFTKVrRaz+263BOz2+/HusvUPRpoebIOPdoblNjSeN3CFdi8QezEl85kYqX/
         Z8aQ==
X-Gm-Message-State: AC+VfDyevAdnScqdqezdU0yGtg3V0pHshqFzrMuAROMs5e36b68ErQwH
        dsuEjX98AYNgD85aFJLSMUDgJw==
X-Google-Smtp-Source: ACHHUZ76KoZBR5N/28FWOVQCRubGGgyJQ241dqNESbpsJ1moZOt8Z6mx6Qcn2B0vRdtAB6skWQilCg==
X-Received: by 2002:a17:907:16a2:b0:982:4abc:97d6 with SMTP id hc34-20020a17090716a200b009824abc97d6mr5288572ejc.4.1687022151941;
        Sat, 17 Jun 2023 10:15:51 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id os5-20020a170906af6500b009829dc0f2a0sm3841897ejb.111.2023.06.17.10.15.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jun 2023 10:15:51 -0700 (PDT)
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
Subject: [PATCH 06/15] arm64: dts: qcom: msm8996-xiaomi: drop label from I2C
Date:   Sat, 17 Jun 2023 19:15:32 +0200
Message-Id: <20230617171541.286957-6-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230617171541.286957-1-krzysztof.kozlowski@linaro.org>
References: <20230617171541.286957-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I2C controller bindings do not allow label property:

  msm8996-xiaomi-gemini.dtb: i2c@75b6000: Unevaluated properties are not allowed ('label' was unexpected)

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8996-xiaomi-common.dtsi | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8996-xiaomi-common.dtsi b/arch/arm64/boot/dts/qcom/msm8996-xiaomi-common.dtsi
index 47f55c7311e9..8c2d6e9e851b 100644
--- a/arch/arm64/boot/dts/qcom/msm8996-xiaomi-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996-xiaomi-common.dtsi
@@ -187,7 +187,6 @@ &adsp_pil {
 
 &blsp2_i2c2 {
 	status = "okay";
-	label = "NFC_I2C";
 	clock-frequency = <400000>;
 
 	nfc: pn548@28 {
@@ -208,7 +207,6 @@ nfc: pn548@28 {
 
 &blsp2_i2c3 {
 	status = "okay";
-	label = "TYPEC_I2C";
 
 	typec: tusb320l@47 {
 		compatible = "ti,tusb320l";
@@ -220,7 +218,7 @@ typec: tusb320l@47 {
 
 &blsp2_i2c6 {
 	status = "okay";
-	label = "MSM_TS_I2C";
+	/* MSM_TS */
 };
 
 &blsp1_uart2 {
-- 
2.34.1

