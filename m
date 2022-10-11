Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 709235FBD08
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 23:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbiJKVd5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 17:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbiJKVdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 17:33:52 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 648769B841
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 14:33:51 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id jr1so1107236qtb.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 14:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rdIShqHVM59tR3kcoJlO0eXiQv5w25Y9IMmRDVGACiI=;
        b=JT2iDBtceVwJ6diZ1Wo6cW/96+cuh+nBOVWYtJBTGleEQjjE4Hfv7zbe7gb1NYzrRC
         ZxegfjITL9YVyv8NNNMYEB8UJiRoZPlHhG25xXLQLNd/eD1AoWktvNqfwUnlvJ0wQO2c
         168OQbTK6qyVW6ufdXhQj5QBGCyADMa+lZTQ92ArB29YEipnm5Tz2xxvDNduHx/B/nM0
         SZHHrTGrEeDWB+/+CpXnz/pH4Vwyv5rATbMCbwK1b6T0+90j3E10RXEahjVN/3OdSSOW
         rCijXF0ykymc2c9wYFdDVsjyHPbVgkVwhV3DXoEglXKbQHoJSfzrM2pkPOhpyCi9abFS
         jAFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rdIShqHVM59tR3kcoJlO0eXiQv5w25Y9IMmRDVGACiI=;
        b=Fw4Qpin3kAvlRJz5WM1GqDw+zx+Zh/pwNFL+4Edk0jm/zusVbfR06pjVkdjYIHemzI
         JsHvXbYjwQCDVKvf6KaBpC1po7IyOcYlVHKH82VnD8Via6bwlNaMXhT4A+ubK2gsEqxy
         nuzr46npqBqDkWNey8e7dIJJuLgRAq2MmUFbOdEJyKc5RiRYRkA4ogRzEIVH/srjWZwq
         Qy2Y2iTCRQ3WbavNALPc6KrQbLbGzOXb3paC3A/JJOxFoQGb50Iqna7Zgl6vbSOpL3aA
         vtIZNSulpce3bHvcxgyh8WoXX+9bn2R44XsBH3dUoJ4RJ62xlssZ6VwNtCloClHyynS9
         euNA==
X-Gm-Message-State: ACrzQf1zro1BvMU1hXFYdIsJ/rO8uARDVgv5vIhGTRDn+vD1Ks/wSBNO
        qoD/foCpm5MoYeD7XFCsPWYKgw==
X-Google-Smtp-Source: AMsMyM64RAiJahvPOd/7TWx+V5hZti7m9w2O6qvkBrbWYmjQxI2u/yoh37GmlmnUzHcmktbRVbrhfg==
X-Received: by 2002:a05:622a:1050:b0:39a:a959:516f with SMTP id f16-20020a05622a105000b0039aa959516fmr9055269qte.271.1665524030588;
        Tue, 11 Oct 2022 14:33:50 -0700 (PDT)
Received: from krzk-bin.home (cpe-72-225-192-120.nyc.res.rr.com. [72.225.192.120])
        by smtp.gmail.com with ESMTPSA id j20-20020ac84414000000b0039cbb50951asm604224qtn.24.2022.10.11.14.33.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 14:33:50 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/4] arm64: dts: qcom: msm8998-oneplus-cheeseburger: fix backlight pin function
Date:   Tue, 11 Oct 2022 17:31:43 -0400
Message-Id: <20221011213145.122879-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221011213145.122879-1-krzysztof.kozlowski@linaro.org>
References: <20221011213145.122879-1-krzysztof.kozlowski@linaro.org>
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

There is no "normal" function, so use "gpio" for backlight button pin
configuration.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8998-oneplus-cheeseburger.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8998-oneplus-cheeseburger.dts b/arch/arm64/boot/dts/qcom/msm8998-oneplus-cheeseburger.dts
index ef2a88a64d32..122f6c25220e 100644
--- a/arch/arm64/boot/dts/qcom/msm8998-oneplus-cheeseburger.dts
+++ b/arch/arm64/boot/dts/qcom/msm8998-oneplus-cheeseburger.dts
@@ -35,7 +35,7 @@ &pmi8998_gpio {
 	button_backlight_default: button-backlight-state {
 		pinconf {
 			pins = "gpio5";
-			function = "normal";
+			function = "gpio";
 			bias-pull-down;
 			qcom,drive-strength = <PMIC_GPIO_STRENGTH_NO>;
 		};
-- 
2.34.1

