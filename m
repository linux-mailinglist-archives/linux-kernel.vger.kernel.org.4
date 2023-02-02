Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0ECF688431
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 17:20:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232315AbjBBQU2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 11:20:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbjBBQTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 11:19:50 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDC142B2BF
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 08:19:48 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id m5-20020a05600c4f4500b003db03b2559eso1815691wmq.5
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 08:19:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OjhYi+0GpGdSn17lU5bVC4FkG9TB87E0c+itsVukMac=;
        b=LuQWUu+2efxxK8kBGFaDYm8ojGFMeaHvObZwLcUQX4ktnTz+OdgEUZX596AkwljIXq
         LdkI7+uNtlAshnjWt8fnrY8sXLS+An/47qx2tBIBzn1x9783SHAzTI1gcn5htv32S6e6
         5e8tXkD2gLIGtFMiJUZLtFI8r+++mjUlZTrrfg8U1SHjvEtdZuQVC0Xv0+WD7aU9XUKY
         VLqGfatUOVhDsR2aPmwqx7HlZJi7ReNHnMSt3EWug6R2Ouv4jC2yBr2alfA1lRDs3kn6
         GAJVywceSgsxWdnQ1UGU8e1LT2UaM75iwqrBejDkxPSZPQyxmOdffbt32V0jlzm8r3zQ
         dlyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OjhYi+0GpGdSn17lU5bVC4FkG9TB87E0c+itsVukMac=;
        b=YwpQtRPlKRS2RwDq1lm6o6E7CcLCy4SY2747AmkZbNg7nVLVkM5bLCTLEu/rMvwTMC
         /QGSO8G2hWwFyzTrUqH2w5/58MbyM7hcL2zc+YbMoOCzRkU98wXTUsH3HIQO2z2K/zGa
         +2957/kHjPlp30T8Td8fOcLxUfQyZkdUB6UaL0epputMHl94I2BlPWsv4AVaGWdvPf2F
         e10+97fBTTE452FryQSTEZ2Eekc7t6uMIR3by5YSCGzu9/cYN1voayeSVcTLgBLTD9g5
         1CKgt4hfqdt2sGo0fdrLRtF0+kPHZ/oBYJE+RP/UFKdRsjaR1yQcg9jVSjc/3VnEKCk8
         S72Q==
X-Gm-Message-State: AO0yUKW6LmUNRgW9ajk+sdyMUCahHmRPc4Afd+PYzhANH/D4Nqg4Ng43
        EoLwMlVZHmhCHlvkm8iz3cdFAQ==
X-Google-Smtp-Source: AK7set/r8h1uhffeyfBEN2l3ALK4St2Emp5CxY82HdUs1mFadGoDBKfZk3xGPjPBstJAFcePpDxiHg==
X-Received: by 2002:a05:600c:548d:b0:3db:114:a67f with SMTP id iv13-20020a05600c548d00b003db0114a67fmr6483884wmb.17.1675354788501;
        Thu, 02 Feb 2023 08:19:48 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id h16-20020a05600c351000b003dc521f336esm212416wmq.14.2023.02.02.08.19.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 08:19:48 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 10/13] arm64: dts: qcom: sm6125: add compatible fallback to mailbox
Date:   Thu,  2 Feb 2023 17:18:53 +0100
Message-Id: <20230202161856.385825-11-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230202161856.385825-1-krzysztof.kozlowski@linaro.org>
References: <20230202161856.385825-1-krzysztof.kozlowski@linaro.org>
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

SM6125 mailbox is compatible with MSM8953.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm6125.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm6125.dtsi b/arch/arm64/boot/dts/qcom/sm6125.dtsi
index 65033227718a..7990265274ca 100644
--- a/arch/arm64/boot/dts/qcom/sm6125.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6125.dtsi
@@ -1211,7 +1211,8 @@ apps_smmu: iommu@c600000 {
 		};
 
 		apcs_glb: mailbox@f111000 {
-			compatible = "qcom,sm6125-apcs-hmss-global";
+			compatible = "qcom,sm6125-apcs-hmss-global",
+				     "qcom,msm8953-apcs-kpss-global";
 			reg = <0x0f111000 0x1000>;
 
 			#mbox-cells = <1>;
-- 
2.34.1

