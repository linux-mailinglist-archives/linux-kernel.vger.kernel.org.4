Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C47DA686AD0
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 16:52:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232880AbjBAPwB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 10:52:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232640AbjBAPv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 10:51:28 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 173B674A65
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 07:51:23 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id m14so17273507wrg.13
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 07:51:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4gkVO6+Tzg4fvpsjqr/AIsp9ic+ZLAa9X09QCCJKt3Q=;
        b=Zbom2BFz1/4u7gOdMA6fUaC6/oPny6nhUG7f4m0pQJu0XAMYXS2XkqIU7AKI27vaIM
         FSRQ5ezwKRETR6TQYJF4lYTFDcW6ukDO5fKitc4ogYOzw8AeBKfIpN3/V0ZWTMAT6wPN
         FgDWpJT7D9He/ZgdSYnsz4e7lhVK4WG7TS6v8R4JFklBahucuCNgl6jIJgpfF6LPIPQI
         W0nlySVv1JWLUi8go5jwfoSPADRrwN9ScvdHyunqO42pSAh75tmXMMwIm9OUgwZjKeEY
         BR1h44rpyjSWdCdMy1b6iw9wVc4b1bJbxEN/0X9UJHiNYQylhLkTmMeMBC46qmhYnePX
         uHXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4gkVO6+Tzg4fvpsjqr/AIsp9ic+ZLAa9X09QCCJKt3Q=;
        b=UuBpFTI2qXIUYXHFiVOCCmcXojj/imqLO96WNfOn7hXB9h1Hc9RjXl83H13G81AKy6
         AvQMuiOIkIhZ85dpv1dmSPKnIoNAOYSIA8le9ziSQjUX29aLGUnPWukPb4pL3FeWZt38
         d8p800xYXEuGd4Bm/NS20/geNoH+ceKO3XmNq5NebSiJK20mNC7BwhzgD7TbrKoH+VtZ
         8IgDyBPXSGsOCH3bJ1sy3CFCNL/b9a1DmHuNxueGLe/r5Vf2DRi6g38N6y1QhR4CFt4C
         VLYcKNiVI0Zu8Sst6uBw6ySEoOzs8KXTAK2OT3JoXufojNF6t9EwYRvHLDd3mutFzRHB
         bkUg==
X-Gm-Message-State: AO0yUKW2oC9K2SK9HELb3OsixT+xjNRg48QPr1nbghZ5Sv52R4ZjpXA1
        TE9oFEikiVOQ5nJuxeyQIIdx1A==
X-Google-Smtp-Source: AK7set8fIhWYhFx+7oY2e4OsT6BguLoUnELED0cj3wBENsd8LHb/eqzfZ5BpErIFIaGKV/Z/HZ9F1w==
X-Received: by 2002:a5d:6411:0:b0:2bf:95d6:4789 with SMTP id z17-20020a5d6411000000b002bf95d64789mr6366652wru.2.1675266682653;
        Wed, 01 Feb 2023 07:51:22 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id t1-20020adfe441000000b002bfd524255esm14816189wrm.43.2023.02.01.07.51.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 07:51:22 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [RFT PATCH 10/14] arm64: dts: qcom: sm6350: correct TLMM gpio-ranges
Date:   Wed,  1 Feb 2023 16:51:01 +0100
Message-Id: <20230201155105.282708-11-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230201155105.282708-1-krzysztof.kozlowski@linaro.org>
References: <20230201155105.282708-1-krzysztof.kozlowski@linaro.org>
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

Correct the number of GPIOs in TLMM pin controller.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm6350.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm6350.dtsi b/arch/arm64/boot/dts/qcom/sm6350.dtsi
index 8224adb99948..317ed9bd3507 100644
--- a/arch/arm64/boot/dts/qcom/sm6350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6350.dtsi
@@ -1511,7 +1511,7 @@ tlmm: pinctrl@f100000 {
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
-			gpio-ranges = <&tlmm 0 0 157>;
+			gpio-ranges = <&tlmm 0 0 156>;
 
 			sdc2_off_state: sdc2-off-state {
 				clk-pins {
-- 
2.34.1

