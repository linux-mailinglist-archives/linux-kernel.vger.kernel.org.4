Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 548385FC81A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 17:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbiJLPQc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 11:16:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbiJLPQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 11:16:24 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0322F101F2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 08:16:22 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id bb5so5010090qtb.11
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 08:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rdIShqHVM59tR3kcoJlO0eXiQv5w25Y9IMmRDVGACiI=;
        b=MXN/ITfuhZI48MRoMSMpyF6pN4J8I1LRNprL3aQ6XWhwF4C2+fF5jBckhBrCvuO7C5
         UpGbOl3zP+8Px2mvYRG8G+o+REfe7r3ZCCJ8Ti9agIy30on9bdBnKKIQk51Y1JIlB4kX
         5TFVkNFQJAXokCJOxXjP0/XBGhwCTpI3bTNyy2GXXd2bshJyijbhH4R2dHTxrKWrV/tZ
         4TYK1mSvBr71UFj70n/i0E8HZ2hNvaewh5kyPRRtydb5hkubJhaQUhF2Z+PjK/HKT8ZZ
         uQGo4AuocSzHZdawllNvsa2yD0JNj3ybDthhMa0lD8ES0xkSmihSFZFp2XZFXYO7Ln7s
         vteg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rdIShqHVM59tR3kcoJlO0eXiQv5w25Y9IMmRDVGACiI=;
        b=fdzP8H/i7q4GnFNrBlvI8UoDLxZAGqPXWfIrfIWzSmAq3cg1eT/p7+ORR6/FrFahKA
         R1apW5QqLk62ulQukkWGbYm+bbmLLX/DC8sKkyXKv6e6x5UjeuCtJTSVxpsR3/R4c5Sr
         fSwDaCILk/Vwh5h2i7tre906rM1lZSZBGpes/RvYiGG2rq4v9SNQvfUZv+3G3FI4KFQW
         HSwwJfPzTv0gqRD15WF3NocFkvEGcsx4KZ6qj8cgE7y6M+/RfpyRMwbYbNmnn4FJTnLP
         /EqloCii1CjItLWtGC3OS2TWwbzFwxl4TDI7IVp8xnCXVym9eVO1qiHBpZp1zmTsbZb7
         0Jnw==
X-Gm-Message-State: ACrzQf1WliAfovxrrYXIvUF8Q/c7dsbPaZ1KhRBEA8WIm1pYLorn2MAU
        bO037ipguFRzBIG5vrHwR7V2pw==
X-Google-Smtp-Source: AMsMyM7NPGbZ/tt+nrOePBcxLM75ZtnMOsg6+zjBRz71LDtfx+PJD3YV3ZB+Vxku9QCEJu9iSqqGTw==
X-Received: by 2002:ac8:5b44:0:b0:390:3f5:62d with SMTP id n4-20020ac85b44000000b0039003f5062dmr23896967qtw.8.1665587781155;
        Wed, 12 Oct 2022 08:16:21 -0700 (PDT)
Received: from krzk-bin.home (cpe-72-225-192-120.nyc.res.rr.com. [72.225.192.120])
        by smtp.gmail.com with ESMTPSA id u2-20020a05620a454200b006af0ce13499sm16671612qkp.115.2022.10.12.08.16.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 08:16:20 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 2/4] arm64: dts: qcom: msm8998-oneplus-cheeseburger: fix backlight pin function
Date:   Wed, 12 Oct 2022 11:14:14 -0400
Message-Id: <20221012151416.38645-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221012151416.38645-1-krzysztof.kozlowski@linaro.org>
References: <20221012151416.38645-1-krzysztof.kozlowski@linaro.org>
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

