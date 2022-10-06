Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6C5D5F691D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 16:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231913AbiJFOIi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 10:08:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231453AbiJFOH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 10:07:28 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99A8BAD9A8
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 07:07:11 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id a29so2903032lfo.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 07:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=Hn7Qh8oAd9K//t+8hLfSlsr8JV0b7onmXrk8KaEz0kU=;
        b=QUxNv8N0EuaPx/P83nmkln89/Z6U0CemyQ2ykHdXVYDvhgGf0hrRifAcxIcLwl7nnq
         Va4cYpBRHVH+xOlv9jQPhmL+gKodi5XOwo1w8/JCX/b0NIvEo9+h2D/swxOE2WvYbrqA
         bJYwCid0BOrroPGI0LWyOg82HFNlsv4xSWEluDbi87OK/Z4Xl9K7/lHw+TezE4wjUgNJ
         XWCzxS7Ljst1Hafm01dhjD2XTWcwNQ/SgTtnES1t77xSgXkOfAeOjfb51dMQf9fwLmZR
         irWAAJEqouA3+OZuVgSw9iLc/6fgysQK/9yA3YngOBQ63v2eBjBIb0oQF5yq0rOR/w60
         7R7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Hn7Qh8oAd9K//t+8hLfSlsr8JV0b7onmXrk8KaEz0kU=;
        b=0Rzqoq70yjGPAxox+IWxrxiUWi8G+WJuNOSvTwuZ3PSvLnTJQdO1ECmGIv1NflPgpo
         VOtiKC4eFXpB4W2KMTvHU1vZOhzXCmO6jkcBmM7bsD5oCgUFcXfWynKWDTG9cePDEuHN
         LfgQvokOB6s0mW2HqlPpKald5JoZ2V5zM7yvg0n5T/2+W2CRYb8qmZ7U/5fZpDKynUnD
         vA0bgzZ5qEik0UiQUg8RR8T/oJacTxpcP8yaCxoFY5Gv1HhQmnBuwZzP0O7Xw/Avh+7z
         5RlkUUV55vBprBhgY89NA1qrD/PawUqMB8eGMqKpN4tczD5oNEzjfaicbxoFhDi8pB4U
         9c0Q==
X-Gm-Message-State: ACrzQf25K5XmFqZKjVi1MagbVyhNFubos3mKXxAu0V2GNl52ol0Q424k
        uyTeTNq1RWHIYBoQKYfx5CN2Cw==
X-Google-Smtp-Source: AMsMyM4l4CVFZIjvdzfDaib7RSXSwoBLORlf4cdBAMxQgvy11NIxT4UIEX2PNnf06TuFVjiMIJaApg==
X-Received: by 2002:a05:6512:104d:b0:4a2:7d13:8579 with SMTP id c13-20020a056512104d00b004a27d138579mr36790lfb.585.1665065227920;
        Thu, 06 Oct 2022 07:07:07 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id z3-20020a056512370300b004a2386b8ce8sm1833929lfr.211.2022.10.06.07.07.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 07:07:07 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Shawn Guo <shawn.guo@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        krishna Lanka <quic_vamslank@quicinc.com>,
        Iskren Chernev <iskren.chernev@gmail.com>,
        Martin Botka <martin.botka@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 19/34] dt-bindings: pinctrl: qcom,qcm2290: minor style cleanups
Date:   Thu,  6 Oct 2022 16:06:22 +0200
Message-Id: <20221006140637.246665-20-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221006140637.246665-1-krzysztof.kozlowski@linaro.org>
References: <20221006140637.246665-1-krzysztof.kozlowski@linaro.org>
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

Drop "binding" from description (and align it with other Qualcomm
pinctrl bindings), use double quotes consistently and drop redundant
quotes.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/pinctrl/qcom,qcm2290-pinctrl.yaml         | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,qcm2290-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,qcm2290-pinctrl.yaml
index 0d73abeea715..1376031661d7 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,qcm2290-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,qcm2290-pinctrl.yaml
@@ -10,8 +10,7 @@ maintainers:
   - Shawn Guo <shawn.guo@linaro.org>
 
 description:
-  This binding describes the Top Level Mode Multiplexer block found in the
-  QCM2290 platform.
+  Top Level Mode Multiplexer pin controller in Qualcomm QCM2290 SoC.
 
 properties:
   compatible:
@@ -28,9 +27,8 @@ properties:
   gpio-ranges: true
   wakeup-parent: true
 
-#PIN CONFIGURATION NODES
 patternProperties:
-  '-state$':
+  "-state$":
     oneOf:
       - $ref: "#/$defs/qcom-qcm2290-tlmm-state"
       - patternProperties:
@@ -38,13 +36,13 @@ patternProperties:
             $ref: "#/$defs/qcom-qcm2290-tlmm-state"
         additionalProperties: false
 
-'$defs':
+$defs:
   qcom-qcm2290-tlmm-state:
     type: object
     description:
       Pinctrl node's client devices use subnodes for desired pin configuration.
       Client device subnodes use below standard properties.
-    $ref: "qcom,tlmm-common.yaml#/$defs/qcom-tlmm-state"
+    $ref: qcom,tlmm-common.yaml#/$defs/qcom-tlmm-state
 
     properties:
       pins:
-- 
2.34.1

