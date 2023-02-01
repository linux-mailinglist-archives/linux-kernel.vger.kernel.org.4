Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E47C5686A56
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 16:30:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232431AbjBAPas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 10:30:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232254AbjBAPam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 10:30:42 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21CA1410A4
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 07:30:40 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id m16-20020a05600c3b1000b003dc4050c94aso1754750wms.4
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 07:30:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WH+iUmIlo2XKkyypu6pZsAFZkWM7iFUcewJRIDKO1d4=;
        b=xX17LUu7zIquaQYDFEWVDKtj2+WtV7/jLMsW1kqBic3wbtghZjjui/ynhyF3wtQPSI
         pfoxxc4rWVui+pKWjN0oNsfMp7TZ9sseQzW1+kaKoZGxLDfXvTw+3ip728K8ZZjDin5j
         oRtDYt4sdw4BAfCfpN6JQ/FaBQ9H1kFjNv4O+MorIoRplgeJltM3wrrLXXxT9/tUs5ZY
         RdRfZh+JoFv6mbRBR0prkJG1znxy2mkT5oTSyFY7bDmEhmg0CP2Y/8RnBu6rEnNyxkiR
         OBAh4qj+3DN+LdCSwy6uoyFZ8lA9Y3XY/i3jXktIS25bi48t39B9vjLJIrlEew9HBpSt
         hzLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WH+iUmIlo2XKkyypu6pZsAFZkWM7iFUcewJRIDKO1d4=;
        b=zexo6eE8oa7pUOycstci+VsjSTrTs6VYUe1dWzCNkBQgKOMf9FwjKKRqBVz65iIM1V
         pR0e7Sy/fRPcy3XtAj3zzGbJUJiUpDAw8kG29ZFld40Hhzq3mevJJjvQGAr+rz8Yb2Yc
         FWosynCscCZxxjBUFj7Do/AKLaan4y73QhUXhL1kqfW0jKb+agK7zsEXHTb1BGFR/Btr
         6c0iAm0zES7wo5TXeEZ0n3XqGOksomXL0uKd8gC4LK95R7zqwfiEAIeXIDUbmIElHaSl
         JpKTJgLAse3ACMVMS7TnhKu7VxBt/XpPMw1xhhacIkUuSVMOrDwl3NSDVoorqNbEV3lj
         fVvQ==
X-Gm-Message-State: AO0yUKXNgVT0JZ74NAGfzOsb4oGkg9dOnyWm4lBNlKjRpmYGZKkyk4D0
        J+bqRN50Yi2IqhSeP10srsIkBg==
X-Google-Smtp-Source: AK7set+IbENSgbstOVm1CmZtL/Fq/QDzb8Il1Q0rgl/gjJaCNAPGHeuA68irXOg3s8F0+bAHD3YWeQ==
X-Received: by 2002:a05:600c:1c1f:b0:3dc:5e21:8aa2 with SMTP id j31-20020a05600c1c1f00b003dc5e218aa2mr2486712wms.34.1675265438715;
        Wed, 01 Feb 2023 07:30:38 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id p11-20020a1c544b000000b003dc4fd6e624sm2168032wmi.19.2023.02.01.07.30.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 07:30:38 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Richard Acayan <mailingradian@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        krishna Lanka <quic_vamslank@quicinc.com>,
        Iskren Chernev <me@iskren.info>,
        Martin Botka <martin.botka@somainline.org>,
        Abel Vesa <abel.vesa@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 4/7] dt-bindings: pinctrl: qcom,msm8953: correct GPIO name pattern
Date:   Wed,  1 Feb 2023 16:30:16 +0100
Message-Id: <20230201153019.269718-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230201153019.269718-1-krzysztof.kozlowski@linaro.org>
References: <20230201153019.269718-1-krzysztof.kozlowski@linaro.org>
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

The MSM8953 TLMM pin controller has GPIOs 0-141, so narrow the pattern.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/pinctrl/qcom,msm8953-pinctrl.yaml       | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,msm8953-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,msm8953-pinctrl.yaml
index 6bcd52080801..ce219827ccc8 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,msm8953-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,msm8953-pinctrl.yaml
@@ -53,7 +53,7 @@ $defs:
           subnode.
         items:
           oneOf:
-            - pattern: "^gpio([0-9]|[1-9][0-9]|1[0-7][0-9])$"
+            - pattern: "^gpio([0-9]|[1-9][0-9]|1[0-3][0-9]|14[01])$"
             - enum: [ sdc1_clk, sdc1_cmd, sdc1_data, sdc1_rclk, sdc2_clk,
                       sdc2_cmd, sdc2_data, qdsd_clk, qdsd_cmd, qdsd_data0,
                       qdsd_data1, qdsd_data2, qdsd_data3 ]
-- 
2.34.1

