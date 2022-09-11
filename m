Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 304EB5B4DD7
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 13:13:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbiIKLM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 07:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbiIKLMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 07:12:20 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7085532B99
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 04:12:17 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id m15so10342539lfl.9
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 04:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=4rHHwOUbpZ1zz0X1ZCBP3fMB8RXmrk772qwdEx5p1YY=;
        b=Fu8ptctQDaI2uIgJo8917Xzo89LGap2DEDz7xxZZ0J+f8RgN6xDMxGGSW5uxQ6Lb5Y
         EQAoRbF9O2Dp2tgZrGjw2/ToX3w2pCWo9ecmTrDPZoAtOHFSgYLaPesqs2xuKWclWSVK
         LC9LGiEQRPl4QmWPkb5KIj/hxgX4cMmNIpccy0Cr3HqDIXWQSgI5q1VOACFcubb9Rdiw
         StDJp2/wTqZH3pyLXYAwnI+O13nxXvgl0p1BXSlaqfsadVrbhfJS8MM2jHrLGmMIgBk1
         gr8qXUG2XR7cuUwh97Z99HEoynxvzaVyo3SdHewyTyrLglE1k7Ta0PYRlUmLYwN3ja/O
         j7mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=4rHHwOUbpZ1zz0X1ZCBP3fMB8RXmrk772qwdEx5p1YY=;
        b=c7QY4Ptss0QbVMiIdZloxBnXlOEpVkyuSFUnHcoryGTtRxPSV96OPiB7QQssXijZ7O
         ipYs7ABi09rANh+6jMlL4m7vnX04OPEtS6BAwyMK7ptGW5zWCSfGXAF5sGWQh3PhO12y
         Ev4HQ+BTRDo6PAhXTQa0ARSb2KsOcoBhb7tImlBkkLAzMEz45KDpdD/7VSuFcdksvRo8
         gy6q9VGwl0YKmyKLxGYuPa1iPDcm9nx6QwV5dniqqeMGvAbS4sRaZ/X0bmEI1q8zFwEJ
         edsMEIi0f3OW0YP5LEdlC+1PZV6TEy5qBWOlzfhFlvPaa9vMfI7pTT5xcOjPWvoSpS+I
         K8pw==
X-Gm-Message-State: ACgBeo2q9FY3jBRbIbDkF0dCTmnjHVrAN49gheoHZtG59RhLRovZ9Gdi
        XqixBgTM/w/Pq3I2AuPNhsVszg==
X-Google-Smtp-Source: AA6agR5qnkA8Y8vV+2+FmuTE621GPU+psjfZnO6j9Nu+3Q+XpjYO4iEuWqxxbJXj4X6NC6K02mMQwQ==
X-Received: by 2002:a05:6512:2a88:b0:499:3bde:9630 with SMTP id dt8-20020a0565122a8800b004993bde9630mr2705951lfb.147.1662894736724;
        Sun, 11 Sep 2022 04:12:16 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id 11-20020a05651c128b00b0025dfd8c9287sm607365ljc.69.2022.09.11.04.12.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Sep 2022 04:12:16 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Iskren Chernev <iskren.chernev@gmail.com>,
        Martin Botka <martin.botka@somainline.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 10/40] dt-bindings: pinctrl: qcom,sm6375-pinctrl: fix matching pin config
Date:   Sun, 11 Sep 2022 13:11:30 +0200
Message-Id: <20220911111200.199182-11-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220911111200.199182-1-krzysztof.kozlowski@linaro.org>
References: <20220911111200.199182-1-krzysztof.kozlowski@linaro.org>
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

Matching PMIC GPIOs config nodes within a '-state' node by '.*' pattern
does not work as expected because of linux,phandle in the DTB:

    'pins' is a required property
    'function' is a required property
    'rx', 'tx' do not match any of the regexes: 'pinctrl-[0-9]+'
    [[59]] is not of type 'object'

Make the schema stricter and expect such nodes to be either named
'pinconfig' or followed with '-pins' prefix.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/pinctrl/qcom,sm6375-tlmm.yaml      | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sm6375-tlmm.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sm6375-tlmm.yaml
index 3908807a8339..50f0ca5ab7e7 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sm6375-tlmm.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sm6375-tlmm.yaml
@@ -44,8 +44,9 @@ patternProperties:
     oneOf:
       - $ref: "#/$defs/qcom-sm6375-tlmm-state"
       - patternProperties:
-          ".*":
+          "-pins$":
             $ref: "#/$defs/qcom-sm6375-tlmm-state"
+        additionalProperties: false
 
 $defs:
   qcom-sm6375-tlmm-state:
@@ -142,13 +143,13 @@ examples:
                 };
 
                 uart-w-subnodes-state {
-                        rx {
+                        rx-pins {
                                 pins = "gpio18";
                                 function = "qup13_f2";
                                 bias-pull-up;
                         };
 
-                        tx {
+                        tx-pins {
                                 pins = "gpio19";
                                 function = "qup13_f2";
                                 bias-disable;
-- 
2.34.1

