Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B38A655A86
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Dec 2022 16:42:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbiLXPmC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Dec 2022 10:42:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbiLXPl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Dec 2022 10:41:59 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A55796549
        for <linux-kernel@vger.kernel.org>; Sat, 24 Dec 2022 07:41:57 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id y25so10696730lfa.9
        for <linux-kernel@vger.kernel.org>; Sat, 24 Dec 2022 07:41:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3rKQS/0YKUCI62xf1acbC4UJxyiXUf6xCIz3qkWDQ50=;
        b=dy4FG9duBleDRxwzg4AWnNYlnTgVv0ViemoczD94fPzhrphvmDUQipkNoal59mA6Op
         lonhH+4lE9hhos+H5NharKbS1//MMNc2oxk9pxI/kMeaA1zmBCmFv5Dp+BPzIjMVgxPw
         rhjZ4ROGKTQdNu/LVqpaxLTipa+wQOHhFMG6d+4rq60pVf4YEkWzlMX3EB56E4dD7/zS
         FGHF6PFtWy8IU31/ppRYMNDc3+sNYJzgG0doPeIZWV7LB3ob3ZdeECXpxZ4jMr7byTSO
         nPthcYhwiYjhCJ+rWrBZAwP0n5oTZ6BF4BSZKi3NKDHqh1e9TePFNsvEi8+Yw32tx3c5
         GSvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3rKQS/0YKUCI62xf1acbC4UJxyiXUf6xCIz3qkWDQ50=;
        b=NppQlfMXBDbdUP0fC24lKAp4K2OOophXV1OzKpFHD3gu24PliyEEyF6sIoXAmn3iJe
         7F+KZHj6papjoyszHCLcCPJ4wY68KP7EfoSJ9f3exImBwXoo0M8MclMgkccctvAcuc+M
         nFCvpr7yI3ExmslpbQ3HHH4lFnfDNlIn/W7ijgeEGyO8SmNPRPE2UAkH0O7bHpYNiwaY
         K9LWfgNRjHRDbDHUd4nFibqHM4QNLP9UoSikB7ougdugtf+dRKUcwy9p99cxr+Icke8n
         X9KcXirjLi8Vd5Q+vFnUgjsqmsns0NYqiF0HK8uGDxQLORCvDmCDhcPs1J6VvFYIFbt9
         EY6Q==
X-Gm-Message-State: AFqh2kpt8EmW1TWO6U3Mo50Ld4jgCM6KlfxB3tJ89xLAuZ6f4WY08CVV
        Cpv4sxNzfyX7pR4lsKKfjkeUJw==
X-Google-Smtp-Source: AMrXdXufimet7fQubUw0w2dX0vrOhgc2TSgz4z65uYL9snsphwmWM+nVkfw95SK+XLmeQ+LYnyRBBA==
X-Received: by 2002:a19:7606:0:b0:4a4:68b8:9c3b with SMTP id c6-20020a197606000000b004a468b89c3bmr3564550lff.35.1671896515988;
        Sat, 24 Dec 2022 07:41:55 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id 7-20020ac25f47000000b0049482adb3basm990130lfz.63.2022.12.24.07.41.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Dec 2022 07:41:55 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Taniya Das <tdas@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: clock: qcom,videocc: correct clocks per variant
Date:   Sat, 24 Dec 2022 16:41:52 +0100
Message-Id: <20221224154152.43272-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

Different SoCs come with a bit different clock inputs:

  sm8250-mtp.dtb: clock-controller@abf0000: clock-names:0: 'bi_tcxo' was expected
  sm8250-mtp.dtb: clock-controller@abf0000: clock-names: ['iface', 'bi_tcxo', 'bi_tcxo_ao'] is too long

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/clock/qcom,videocc.yaml          | 59 +++++++++++++++++--
 1 file changed, 55 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/qcom,videocc.yaml b/Documentation/devicetree/bindings/clock/qcom,videocc.yaml
index e221985e743f..2b07146161b4 100644
--- a/Documentation/devicetree/bindings/clock/qcom,videocc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,videocc.yaml
@@ -30,12 +30,12 @@ properties:
       - qcom,sm8250-videocc
 
   clocks:
-    items:
-      - description: Board XO source
+    minItems: 1
+    maxItems: 3
 
   clock-names:
-    items:
-      - const: bi_tcxo
+    minItems: 1
+    maxItems: 3
 
   '#clock-cells':
     const: 1
@@ -68,6 +68,57 @@ required:
   - '#reset-cells'
   - '#power-domain-cells'
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          enum:
+            - qcom,sc7180-videocc
+            - qcom,sdm845-videocc
+            - qcom,sm8150-videocc
+    then:
+      properties:
+        clocks:
+          items:
+            - description: Board XO source
+        clock-names:
+          items:
+            - const: bi_tcxo
+
+  - if:
+      properties:
+        compatible:
+          enum:
+            - qcom,sc7280-videocc
+    then:
+      properties:
+        clocks:
+          items:
+            - description: Board XO source
+            - description: Board active XO source
+        clock-names:
+          items:
+            - const: bi_tcxo
+            - const: bi_tcxo_ao
+
+  - if:
+      properties:
+        compatible:
+          enum:
+            - qcom,sm8250-videocc
+    then:
+      properties:
+        clocks:
+          items:
+            - description: AHB
+            - description: Board XO source
+            - description: Board active XO source
+        clock-names:
+          items:
+            - const: iface
+            - const: bi_tcxo
+            - const: bi_tcxo_ao
+
 additionalProperties: false
 
 examples:
-- 
2.34.1

