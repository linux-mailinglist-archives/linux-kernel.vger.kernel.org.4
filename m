Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE17F5F66B6
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 14:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231564AbiJFMtK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 08:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbiJFMsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 08:48:25 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22707A2A9F
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 05:47:40 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id bn8so2103782ljb.6
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 05:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=BhbTeBROl4/tOR51peuLJrLs0zaAX19oqYrmPX71dUc=;
        b=yCCjRXoAmJP0S6lgERbIi5iJYiYoBPwMKrA0sSuuCpleyMGy7yr2b28FYfmM4vURsq
         9VaqdyWCePZ2bRmswXlmVnyDSoGEHu8hAqoukq6fumRUCV7Ofus4fbhYZs70hGiFlK0i
         +fHpttUjGCln5rr5+m0F3ck0HSiDxwDv1DmUcK2CqIWIwDWmuVXsxA/uG6VD/rZ7+ccC
         s5Lgika30VtVu7jn8kWmo8o5mKKbbVKzZCBUk04ZYdOAezGNL18Km4Jn52T8S7WY6ONS
         O/uc6n1c8btPKjnmV6517mr5Ex4NOrPK0kfgRtG2pIHleEOUvKCgY2qthwYjidunJsGJ
         VJNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=BhbTeBROl4/tOR51peuLJrLs0zaAX19oqYrmPX71dUc=;
        b=lOYUsXfqjEnwzdtUKAT2XKbDT6cT9TvslhK2KkyKJBigM3T0U7aaX5IVEf9lwc62vl
         d6e8h77zrUSBXUyJbI5xhTQoSNnw6s1PZDnnPp9yyx0kJp540JXx5U9Ox8wgzx0Tduft
         WUNumqA9cD/kI47BfVXme1PCYXQ01QkV9g1Fn8InD/IEIi/aoWlox+RN6GtY2vfj4SF5
         Y6xecdYr0G8EOfrOyhjrBZM+VKSNQG1YwgCGmMQxXcbde/Mmny/hAuXr13uSPUbOZQmV
         KTItD/ii3kBc+S7lQRoULlWyG6SWZ+6IwqCJQ61JOcqnnMX6AA+Z7Nkc0RNIKNjynoG1
         DSIg==
X-Gm-Message-State: ACrzQf0+29lJDZISTh8nksqQOEnTasfNLoJYO8qxY8H3CRGh5n6ao3Xx
        YCDLGQT8SCcLUF8s6R3EjMNNXg==
X-Google-Smtp-Source: AMsMyM6VWYKjknNg/GEn95XfCDfHxTvyfGwlJ/ypT2LrshsmsO8fKd6hRSRKQHC9kupxUaNqdXrIyg==
X-Received: by 2002:a2e:9d5a:0:b0:25e:2c67:edaf with SMTP id y26-20020a2e9d5a000000b0025e2c67edafmr1714927ljj.437.1665060442427;
        Thu, 06 Oct 2022 05:47:22 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id br32-20020a056512402000b00497a3e2a191sm2687659lfb.112.2022.10.06.05.47.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 05:47:21 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Shawn Guo <shawn.guo@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        krishna Lanka <quic_vamslank@quicinc.com>,
        Sivaprakash Murugesan <sivaprak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v4 18/34] dt-bindings: pinctrl: qcom,msm8909-tlmm: fix matching pin config
Date:   Thu,  6 Oct 2022 14:46:43 +0200
Message-Id: <20221006124659.217540-19-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221006124659.217540-1-krzysztof.kozlowski@linaro.org>
References: <20221006124659.217540-1-krzysztof.kozlowski@linaro.org>
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

The TLMM pin controller follows generic pin-controller bindings, so
should have subnodes with '-state' and '-pins'.  Otherwise the subnodes
(level one and two) are not properly matched.  This method also unifies
the bindings with other Qualcomm TLMM and LPASS pinctrl bindings.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Bjorn Andersson <andersson@kernel.org>
Reviewed-by: Stephan Gerhold <stephan@gerhold.net>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/pinctrl/qcom,msm8909-tlmm.yaml     | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,msm8909-tlmm.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,msm8909-tlmm.yaml
index e03530091478..b1735918fa90 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,msm8909-tlmm.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,msm8909-tlmm.yaml
@@ -43,8 +43,9 @@ patternProperties:
     oneOf:
       - $ref: "#/$defs/qcom-msm8909-tlmm-state"
       - patternProperties:
-          ".*":
+          "-pins$":
             $ref: "#/$defs/qcom-msm8909-tlmm-state"
+        additionalProperties: false
 
 $defs:
   qcom-msm8909-tlmm-state:
@@ -136,13 +137,13 @@ examples:
                 };
 
                 uart-w-subnodes-state {
-                        rx {
+                        rx-pins {
                                 pins = "gpio4";
                                 function = "blsp_uart1";
                                 bias-pull-up;
                         };
 
-                        tx {
+                        tx-pins {
                                 pins = "gpio5";
                                 function = "blsp_uart1";
                                 bias-disable;
-- 
2.34.1

