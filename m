Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 456685E9B14
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 09:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234370AbiIZHsS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 03:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234323AbiIZHrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 03:47:25 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55A6236DDF
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 00:45:17 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id o2so9454977lfc.10
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 00:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=8nwp/MQe8qtj/E8pIN4GqMEGKKKg4JslS5CxcegQMDk=;
        b=qTGB9GjJz4hAaJjBdRcTUR81/6G4ePdr5l2sHrUvHIf/TQ05H8E07U2+dbxzJQrNgS
         TkOQWuAt9EMSQ/F+zGVNqJRmFZaTiG0PJiXSARF93OJH1evkUwSxyRkSvf9WROYXuBsl
         9Y+V+A/pzAwdPWKFdEnen2sCfNxxL4oJCW/b4cngL84XkrSYFvsmd5t8MIncaH7H6r8I
         5GGeWoCSzoOWDgyqahLkAWJnonA2NSlGSHjLd1r7h5WO6K3zKZUgSzvlzF1jF3zM9uPR
         wkfEQSDvq7FH5WKacohWUWJGFgdJ8W4O0eYGCQDVwt61zkqFZTsmWBOkVQp6F4g+da5g
         efzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=8nwp/MQe8qtj/E8pIN4GqMEGKKKg4JslS5CxcegQMDk=;
        b=aFxsBZXr4TSkkXINkp2+2kC+kwLnERmrsu7XBXRQROsxCHVzqXOiUHEcvh475AmRh2
         635/SjmaXwdBbwYzVkiGVIE/RTWBDEw9rBmIGw6TFq50R5fx4TLmtpb2GnaAOUeRuvzR
         o2G7fm5hPy89Ry8huGq6nzd9mxJlLgOS8EVnEgfwKXipZXh6XyN3mVjsa/jZP7L85LUK
         oL5S+6bh4zFOTO4GH9twdyjJt9J+7Hh4nSfncokptY0+38v6JGKif04DjvqyTZcpTZ4A
         AToNL8U7PXek0CHTKsvaKyJ1GDCto95tqVYQRPXyOaprY0dr6fhYiuCqnsBCLJTulfmE
         gt/Q==
X-Gm-Message-State: ACrzQf0u7pXhoejmFQytRfORg6Gd9srzYCW6ES21qzYOiMyKhz6n4ZFd
        Fj3X6ajU6WrtBSzhqkx/bA67hw==
X-Google-Smtp-Source: AMsMyM49e1nHwNafe160Mhf0QfpxnfNvEBxv+pjeWIPthKFlnjxVvyDrADhcraPCk3EZgcaztzUijw==
X-Received: by 2002:a05:6512:401d:b0:496:9971:78c5 with SMTP id br29-20020a056512401d00b00496997178c5mr7856346lfb.337.1664178317475;
        Mon, 26 Sep 2022 00:45:17 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id g6-20020a19e046000000b004978e51b691sm2453298lfj.266.2022.09.26.00.45.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 00:45:16 -0700 (PDT)
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
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 27/33] dt-bindings: pinctrl: qcom,sdx55: fix matching pin config
Date:   Mon, 26 Sep 2022 09:44:09 +0200
Message-Id: <20220926074415.53100-28-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220926074415.53100-1-krzysztof.kozlowski@linaro.org>
References: <20220926074415.53100-1-krzysztof.kozlowski@linaro.org>
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

