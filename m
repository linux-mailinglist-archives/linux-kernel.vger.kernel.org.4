Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 636195F68E0
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 16:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231646AbiJFOHI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 10:07:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbiJFOGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 10:06:52 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 562DDA98FC
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 07:06:50 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id g1so2840297lfu.12
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 07:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=J5ngFIXcSP1g00xRqhGw4exECwdqHtNburGMs+lMA4s=;
        b=zVLpt4jYV5+MIlNidrbj2d6yHkmojUQL68LRQw6O1r484WiOA01o5Ql3E3NtIzBq9L
         fN/aB5NT0i92UwmNUw9oOKP90wA9CZbnXXwSCXGzOAZxSpxluK9KDFg0dol+z/nKQS+w
         rGYLXAw2YRdC6t7AaC3s8UiahgUTynihlmKPpjP8M6Fu+NUj2u+hgVlaQzndsySBu4KV
         vLGuL15/QRNaJw6XXqj1GVBXxbLQ6YZjCmGB15/hDAqFDFr0NIVdMusyCNDvYRqoqnhd
         9Q9DO7UcN5Kq97bpS1C5K8BX4gwfjpFTFJUOiT+JKjOGJytgI0/4/2jBVRAzrUC23R/c
         rK8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=J5ngFIXcSP1g00xRqhGw4exECwdqHtNburGMs+lMA4s=;
        b=K8dJlirKx2h96YEKoqz+HmTV83r0yvB8FH82XUaIe6kdf5myVzQjjLWy5PUnfUw++2
         sdhn9xk1wG2wph+5t3mmvuyXwogx3oML8yLZLISg6XZM7xDCuvj4jvYvqxQBtra3anFM
         tsAdNOSjo/uV5eRI4wT4RN+tUntSzzLlHlYF0qNwjHHaStMY3hhjEOsaWdnO9lGuqMj5
         mSnbZP+RNaHAeGZYrW/E0wk7rejXs5ruTLTuaCb2wDwpPC3lNzGxVVOcSKtBQb0g+Qg9
         cT7dTVwvahKhK748n6IEsN/+KX6MeA4K/orIjjuhU9e9gmR4isLUGKgfw7nTXOMIwUxb
         A6FA==
X-Gm-Message-State: ACrzQf1ZrXxgF405p2dl3kHGd8cDHYxgoUyXcud8oAQIeTpVDBsTeiq7
        L6BWDQ2LBYU3QrgfFCh/Slt50Q==
X-Google-Smtp-Source: AMsMyM5T1H4r8Yw5QN3belT2ES+lQD5vl0lcgroUymzYSVFy1yZbA+zF/zZWoYlZrwa2oRzMmCqEBQ==
X-Received: by 2002:a05:6512:1191:b0:49f:220:b7d with SMTP id g17-20020a056512119100b0049f02200b7dmr53471lfr.244.1665065208241;
        Thu, 06 Oct 2022 07:06:48 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id z3-20020a056512370300b004a2386b8ce8sm1833929lfr.211.2022.10.06.07.06.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 07:06:47 -0700 (PDT)
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
Subject: [PATCH 04/34] dt-bindings: pinctrl: qcom,sc8180x: drop checks used in common TLMM
Date:   Thu,  6 Oct 2022 16:06:07 +0200
Message-Id: <20221006140637.246665-5-krzysztof.kozlowski@linaro.org>
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

The common Qualcomm TLMM pin controller schema already brings
requirement of function for GPIO pins.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/pinctrl/qcom,sc8180x-pinctrl.yaml        | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sc8180x-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sc8180x-pinctrl.yaml
index 62d0ea7bbc62..71ca4cfd567c 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sc8180x-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sc8180x-pinctrl.yaml
@@ -60,6 +60,7 @@ patternProperties:
     description:
       Pinctrl node's client devices use subnodes for desired pin configuration.
       Client device subnodes use below standard properties.
+    $ref: qcom,tlmm-common.yaml#/$defs/qcom-tlmm-state
 
     properties:
       pins:
@@ -111,16 +112,6 @@ patternProperties:
     required:
       - pins
 
-    allOf:
-      - $ref: "qcom,tlmm-common.yaml#/$defs/qcom-tlmm-state"
-      - if:
-          properties:
-            pins:
-              pattern: "^gpio([0-9]|[1-9][0-9]|1[0-8][0-9])$"
-        then:
-          required:
-            - function
-
     additionalProperties: false
 
 examples:
-- 
2.34.1

