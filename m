Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E44E55B4598
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Sep 2022 11:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbiIJJQO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Sep 2022 05:16:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbiIJJPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 05:15:49 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC97932BA1
        for <linux-kernel@vger.kernel.org>; Sat, 10 Sep 2022 02:14:57 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id u18so6696746lfo.8
        for <linux-kernel@vger.kernel.org>; Sat, 10 Sep 2022 02:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=rmqQ4kjPWFQWglKjigsMWHNac7/x7IFTq30UtYcnmqY=;
        b=Vjv2svewyIN2U5P6rvQjir03D+g6EpmVV3R6ajRIKLNBxcpOyr4c4UkbjxSM2TJMEy
         X+uE+EHNFtIz8QgvKTsrOU9PktlAgLEH22tw6yVTmv7GIFcDbPr/VtOqGgwfR1NMwfOw
         vILCk45ixAfgzYbW3ggWvrPOSHlJ+0h1N+FUZ4ufHrp0bz93hydaUtQ+mvXQWkWA2Yco
         jcSuqcQkHn1OD5ndnsaPbY5cBFgLLZfKrWIP8iWBBpslUS75Qv0MYRM9aseg1myl8LLC
         VBFGtXf/oWA1EA23L2E/nbzjOC7v0tGI2rZjT0BPoK0wLpfKqFt7jRFs4M9tO7pnq/sy
         i6NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=rmqQ4kjPWFQWglKjigsMWHNac7/x7IFTq30UtYcnmqY=;
        b=pxhHyXZyytwqRnrQ2/svbS5nS3ZVvW8apd0KQ1a8Cb+fyo6JSwP9VHbtQEadW3Wfe0
         +KLRz1pSuJMT5idL+S4v+ue7L+hAF131dXrJKyXOdcdpSx/1OFDp1GogdeR1csNf3u7i
         IGYmYiO9pPGAbJnzJ5jyT3/9HD/TALKoICyvYnm24UgJ3vYBI+zJlvKEUBQ1u4/PORhb
         hFXHimwxLBEXHexkHXXC8RTLKfgSjfyVcatbpZS5Xly8UVCCOeDIrMsE9bSSFp1bIvEZ
         b9UTv2Gj6XXtY2WPMUyuntSToGgk9mO1KHNxb+h4+1EG+2TTXHeWEvRldkYb3kBMYpIr
         vHhg==
X-Gm-Message-State: ACgBeo0jOCOVK+1aH4FKcy6QcB5nAEmLoC5CxqoXM8pSDGbtr+k8RY/G
        NmIT10s0/PX7CIzjiOeGD8Cz9g==
X-Google-Smtp-Source: AA6agR5M2+DIslDj5uqNrZ+M/RK85p19Fiy/OF3lTqm4PY6EnhQ2RxNj9gfL7c/DjWGFWotv07lyEA==
X-Received: by 2002:a05:6512:4002:b0:499:280:9c5b with SMTP id br2-20020a056512400200b0049902809c5bmr1753800lfb.593.1662801295116;
        Sat, 10 Sep 2022 02:14:55 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id x22-20020a19e016000000b0048b26d4bb64sm201552lfg.40.2022.09.10.02.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Sep 2022 02:14:54 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 15/15] dt-bindings: soc: qcom: apr: add missing properties
Date:   Sat, 10 Sep 2022 11:14:28 +0200
Message-Id: <20220910091428.50418-16-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220910091428.50418-1-krzysztof.kozlowski@linaro.org>
References: <20220910091428.50418-1-krzysztof.kozlowski@linaro.org>
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

The APR bindings were not describing all properties already used in DTS:
1. Add qcom,glink-channels, qcom,smd-channels and qcom,intents (widely
   used).
2. Add power-domains for MSM8996.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../bindings/soc/qcom/qcom,apr.yaml           | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,apr.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,apr.yaml
index 54328d74af85..f47491aab3b1 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,apr.yaml
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,apr.yaml
@@ -20,6 +20,9 @@ properties:
       - qcom,apr-v2
       - qcom,gpr
 
+  power-domains:
+    maxItems: 1
+
   qcom,apr-domain:
     $ref: /schemas/types.yaml#/definitions/uint32
     enum: [1, 2, 3, 4, 5, 6, 7]
@@ -52,6 +55,26 @@ properties:
         2 = Audio DSP Domain
         3 = Application Processor Domain
 
+  qcom,glink-channels:
+    $ref: /schemas/types.yaml#/definitions/string-array
+    description: Channel name used for the communication
+    items:
+      - const: apr_audio_svc
+
+  qcom,intents:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description:
+      List of (size, amount) pairs describing what intents should be
+      preallocated for this virtual channel. This can be used to tweak the
+      default intents available for the channel to meet expectations of the
+      remote.
+
+  qcom,smd-channels:
+    $ref: /schemas/types.yaml#/definitions/string-array
+    description: Channel name used for the communication
+    items:
+      - const: apr_audio_svc
+
   '#address-cells':
     const: 1
 
@@ -172,6 +195,30 @@ required:
   - compatible
   - qcom,domain
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          enum:
+            - qcom,gpr
+    then:
+      properties:
+        power-domains: false
+
+  - if:
+      required:
+        - qcom,glink-channels
+    then:
+      properties:
+        qcom,smd-channels: false
+
+  - if:
+      required:
+        - qcom,smd-channels
+    then:
+      properties:
+        qcom,glink-channels: false
+
 additionalProperties: false
 
 examples:
-- 
2.34.1

