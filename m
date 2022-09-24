Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A5BF5E89CF
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 10:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233808AbiIXIIC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 04:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233799AbiIXIGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 04:06:48 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F0CB130BE5
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 01:05:42 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id a14so2300459ljj.8
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 01:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=8nwp/MQe8qtj/E8pIN4GqMEGKKKg4JslS5CxcegQMDk=;
        b=IHq5m2G1mEGHNQi9oW5df5bFeje0cLCRYx+363ZOhCWSr9Q0eu16Khx72mjZTzW2dL
         x6jI2lTJpDicPfpc7Md5EhYgLgvSplJZdqoB9XuXuhrMQ0j0fNJHcXIc+tieh4tAS14g
         mvR/BB7UJiCTPPiA7KzCb8fCALmpXWLc5EuuAEy7x2mAzGqVTBwUGDTA+aED2Wj1bgGo
         GjYI9A+l5Wq3ZvtUcxfL9RvwdJzjsXVEQjJqIH+9stdRPQ90TB+LV5jSe8YQ+dTJufNx
         g/d0BJVMlsJuXN9mQckTFJcP8P33D/LckdW5UnJUyydWZK7bSchDZJY0TqgOzsrEW9Wt
         Ukvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=8nwp/MQe8qtj/E8pIN4GqMEGKKKg4JslS5CxcegQMDk=;
        b=A4MO0JZcKhE6ntraUI9ONcEbpLkCkLub55blUuVZzkw1lSSMSAxOVcesu+c2NEUTMX
         f7VUZx8hvYp0C2YtCG5sawtsGYDSp/+jz5jqG9iTA8AKhP8CYIxCmWVSvmMkSZA9a9Yw
         4Gi38mUy8PQ88Vh2xuhJF5FFmibjB/fBYcbRGN3oXINi79tg+3t6pUAnEqeZ7QBfQFta
         Tn0UeDjDRl4c0C/ceyG7rpocQP3EuJSpRSjp6s0HQ7U+P2LdHEwyt7/Ye5RGVOQejYhI
         IDCRaQKsmVNCJ07ezyZB3zzRHxFShUb7GtPdJ+lTEIk93fdYgqNcAr1XoxaOFRbFX1xT
         776Q==
X-Gm-Message-State: ACrzQf2JKyWekaiTmCakkn2qM5ubdWhLpt7euIRdtU4qfRLYQWH0yGah
        c2BdjJk5xJbL+mrHAv1OH2Oo6Q==
X-Google-Smtp-Source: AMsMyM4mblzni5JIHJDLuKzTnjVszENydJNmoF0LQXizQvfXuLie03AcVN2cs8b8AhGvvDqu/z56/w==
X-Received: by 2002:a05:651c:1111:b0:26c:6b0f:472c with SMTP id e17-20020a05651c111100b0026c6b0f472cmr4028189ljo.384.1664006741589;
        Sat, 24 Sep 2022 01:05:41 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id y2-20020a2e5442000000b0026c41574790sm1696668ljd.30.2022.09.24.01.05.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Sep 2022 01:05:41 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sricharan R <sricharan@codeaurora.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Shawn Guo <shawn.guo@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        krishna Lanka <quic_vamslank@quicinc.com>,
        Sivaprakash Murugesan <sivaprak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 26/32] dt-bindings: pinctrl: qcom,sdx55: fix matching pin config
Date:   Sat, 24 Sep 2022 10:04:53 +0200
Message-Id: <20220924080459.13084-27-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220924080459.13084-1-krzysztof.kozlowski@linaro.org>
References: <20220924080459.13084-1-krzysztof.kozlowski@linaro.org>
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
(level one and two) are not properly matched.

  qcom-sdx55-telit-fn980-tlb.dtb: pinctrl@f100000: 'pcie_ep_clkreq_default', 'pcie_ep_perst_default', 'pcie_ep_wake_default' do not match any of the regexes: '-pins$', 'pinctrl-[0-9]+'

This method also unifies the bindings with other Qualcomm TLMM and LPASS
pinctrl bindings.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/pinctrl/qcom,sdx55-pinctrl.yaml       | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sdx55-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sdx55-pinctrl.yaml
index a38090b14aab..fff57abf4fbc 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sdx55-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sdx55-pinctrl.yaml
@@ -45,9 +45,17 @@ properties:
   gpio-reserved-ranges:
     maxItems: 1
 
-#PIN CONFIGURATION NODES
 patternProperties:
-  '-pins$':
+  "-state$":
+    oneOf:
+      - $ref: "#/$defs/qcom-sdx55-tlmm-state"
+      - patternProperties:
+          "-pins$":
+            $ref: "#/$defs/qcom-sdx55-tlmm-state"
+        additionalProperties: false
+
+$defs:
+  qcom-sdx55-tlmm-state:
     type: object
     description:
       Pinctrl node's client devices use subnodes for desired pin configuration.
@@ -146,7 +154,7 @@ examples:
                 #interrupt-cells = <2>;
                 interrupts = <GIC_SPI 212 IRQ_TYPE_LEVEL_HIGH>;
 
-                serial-pins {
+                serial-state {
                         pins = "gpio8", "gpio9";
                         function = "blsp_uart3";
                         drive-strength = <8>;
-- 
2.34.1

