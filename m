Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C6616001C6
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 19:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbiJPRDQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 13:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbiJPRCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 13:02:24 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A9583DBF8
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 10:02:10 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id z18so6246670qvn.6
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 10:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KkxpRfvthMQRkjuRkMuhszBduBQdOCaoDx8XGiiNaXE=;
        b=FF0ZZRRl+dfHZ3gZqs7zxjk9lYREJn4EGbAXjTxVJMKkSrInBPjjJJ0tjpjy4mR3w5
         cbRAzglYzETzRY9C0Z5snGLsQP2+E1uMvUe/FN8+WxBn7UWioB7NoO7mcCYpvVm56tK+
         fMxU8kxgjc6OmmGSdJhaMYy/OO8zSDzgcJ8h9u/zTTaQZfE9AgkZFq07u4g7l0169O8E
         RcZ/NhNJXkDWw9WJUyzp3Smd2kDPsJiI8J0uOP3FS3NCTv3E2gJELY6NFqcSjMqkFvSc
         8OnbZkeXnXkrwOJAlfHXq9/55Y/8BPWCoqzBTLvXAc0mzIEVyxz7blM/I3XFmTxvf51h
         fkqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KkxpRfvthMQRkjuRkMuhszBduBQdOCaoDx8XGiiNaXE=;
        b=U84Ho5hxF4R9bSQlbYFG/Yl4xsT8japqAmQuZCB/a2hW3qWyWqV/hpOAZbakZ5Nx3O
         5tsifhZF8wL25GPm0lu+kkE15v0jtOo3VHrIS+kg9efTa2DXERWSnaHstjIUiYiBtob4
         owPAtEf3ZI+wyDqKaqX0aGmg+XUhlNFlZFMw+1UGip2dkS1JjI1I+uHuQpXyPHeZ6Eya
         1Za5p2qS8BQKiK0VFEFvl0AnN14bYRh2agP6XeWarA58z0As0lIcZipz4MxmntzBcOed
         yuX03a67dWxkR2L8AHdLJwOCXWLpezcJKszqDbVus2KztJpcJAQsZG/OcMhdZWWtSQfu
         r9LA==
X-Gm-Message-State: ACrzQf3/PhKO3HnSg3b+lt8PbQGZP1CWgr9gZCrmaAqy/3etkFIyEdYu
        dzGx8xYOvPfLFTgJ6FaeNZpmlA==
X-Google-Smtp-Source: AMsMyM50GDjeFfLoQbAlxmqn4jw5Q2xwTE1SWr00SNauMKMs78AzjR9XeKN4fTOkH5jo1xczY6e4kQ==
X-Received: by 2002:ad4:5c4c:0:b0:4b1:bc38:5e0f with SMTP id a12-20020ad45c4c000000b004b1bc385e0fmr5627556qva.41.1665939719740;
        Sun, 16 Oct 2022 10:01:59 -0700 (PDT)
Received: from krzk-bin.hsd1.pa.comcast.net ([2601:42:0:3450:9b13:d679:7b5b:6921])
        by smtp.gmail.com with ESMTPSA id q6-20020a05620a0d8600b006ce7bb8518bsm7539967qkl.5.2022.10.16.10.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Oct 2022 10:01:59 -0700 (PDT)
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
Subject: [PATCH v5 14/34] dt-bindings: pinctrl: qcom,msm8226: fix matching pin config
Date:   Sun, 16 Oct 2022 13:00:15 -0400
Message-Id: <20221016170035.35014-15-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221016170035.35014-1-krzysztof.kozlowski@linaro.org>
References: <20221016170035.35014-1-krzysztof.kozlowski@linaro.org>
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

The TLMM pin controller follows generic pin-controller bindings, so
should have subnodes with '-state' and '-pins'.  Otherwise the subnodes
(level one and two) are not properly matched.  This method also unifies
the bindings with other Qualcomm TLMM and LPASS pinctrl bindings.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Bjorn Andersson <andersson@kernel.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/pinctrl/qcom,msm8226-pinctrl.yaml     | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,msm8226-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,msm8226-pinctrl.yaml
index ab4a2b4cfda2..ecb90c77f666 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,msm8226-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,msm8226-pinctrl.yaml
@@ -45,9 +45,17 @@ properties:
   gpio-reserved-ranges:
     maxItems: 1
 
-#PIN CONFIGURATION NODES
 patternProperties:
-  '-pins$':
+  "-state$":
+    oneOf:
+      - $ref: "#/$defs/qcom-msm8226-tlmm-state"
+      - patternProperties:
+          "-pins$":
+            $ref: "#/$defs/qcom-msm8226-tlmm-state"
+        additionalProperties: false
+
+$defs:
+  qcom-msm8226-tlmm-state:
     type: object
     description:
       Pinctrl node's client devices use subnodes for desired pin configuration.
@@ -126,7 +134,7 @@ examples:
                 #interrupt-cells = <2>;
                 interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
 
-                serial-pins {
+                serial-state {
                         pins = "gpio8", "gpio9";
                         function = "blsp_uart3";
                         drive-strength = <8>;
-- 
2.34.1

