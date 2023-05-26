Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EECC712D44
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 21:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243897AbjEZTXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 15:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243734AbjEZTXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 15:23:12 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B87DE54
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 12:23:09 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1b011cffe7fso6862815ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 12:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685128988; x=1687720988;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=prFhwvSxBQ/UQ8d4CbWdnfwjRcrN8xUyHXxMGOEWxfk=;
        b=NZpF0bEaiJ64NKcd0IR9qeUnMib3NkOs5ZN6tMGQtVc6S9eyXNxuLqp36iIypZKrEs
         t+FAvfflBOhUraeyz5P0Vf/rt2pVio9P3b/l5xFrqajyS5X4L0WBxiZMNLvcARzlW5j4
         xvIvJr+U63Ed26XkG5Pfz7Rzy59JuUXNhVA5PGSSNJ70W/OYmgssepxSbYFdtflV9vaZ
         bZYPxzU0Ia+/zpWxFv1QVbL2QlF24Hi4yUMpxaJD9QmQXt0MW4oY0rWB4dWOzn75jkbU
         e/BNCajd5h8EByWnBb7qXGp2f4+d8lWKyLjck6LVM2kq8aBWgg1/qJlpy7BH7l41i+EZ
         Souw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685128988; x=1687720988;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=prFhwvSxBQ/UQ8d4CbWdnfwjRcrN8xUyHXxMGOEWxfk=;
        b=bH3CeFr6gIlVhMRVZukbqc9OOVHLArMwM/IFx8jIa8953VdK7NyUvw7u6ftlIvRErO
         yBTA6lPxu/fk4zDD6P1b/n4xQX+srpRbaJE3m16xQQyyex6jeL7ped1Pn46/W5I6B0fG
         csFfLzwfpnxxfvLHoRoGTOsZDANe0rDE+9wP/ZlX82t70JtzBbH3MY8wa20S0daKcMYy
         cYX9vJspEk7dGTEa0tG2Jta3VqUd40qi20pk/h+txLPqyNPBZqsyLrx+dlJNcbC7uSVa
         gaI1A3+vVJtBq1h/6rbxRL5H7XBdMr+MCe4t3aXHHkEXaC3PaD+o9b+WiCkQTlyv26cO
         q4Zw==
X-Gm-Message-State: AC+VfDxhEFDW5bzUbPYC8cCGsvzxwRmEqz1P77ypOvhHh7xpQwFul44O
        s/+DilyFko8rXwDkBcYfigOIkA==
X-Google-Smtp-Source: ACHHUZ60c6AQTj4K3Aeo78Ha1u4XyOFEb9uQ4viBNyubuHN3rC3+0L5JFqBYaNSBovMUc2Xk8c8C1Q==
X-Received: by 2002:a17:902:d483:b0:1b0:12e:3bfd with SMTP id c3-20020a170902d48300b001b0012e3bfdmr4463175plg.7.1685128988620;
        Fri, 26 May 2023 12:23:08 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1f3a:6990:1a5c:b29f:f8cf:923c])
        by smtp.gmail.com with ESMTPSA id q18-20020a17090311d200b001b008b3dee2sm1955079plh.287.2023.05.26.12.23.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 12:23:08 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     agross@kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, andersson@kernel.org,
        bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        krzysztof.kozlowski@linaro.org, robh+dt@kernel.org,
        konrad.dybcio@linaro.org, vladimir.zapolskiy@linaro.org,
        rfoss@kernel.org, neil.armstrong@linaro.org, djakov@kernel.org,
        stephan@gerhold.net, Anders Roxell <anders.roxell@linaro.org>,
        Linux Kernel Functional Testing <lkft@linaro.org>
Subject: [PATCH v8 06/11] dt-bindings: qcom-qce: Add compatibles for SM6115 and QCM2290
Date:   Sat, 27 May 2023 00:52:05 +0530
Message-Id: <20230526192210.3146896-7-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230526192210.3146896-1-bhupesh.sharma@linaro.org>
References: <20230526192210.3146896-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The core clock for the Crypto Engine block on Qualcomm SoCs SM6115 and
QCM2290 are provided via the RPM block.

So mark the compatibles for these SoCs to indicate that only 'core'
clock is required for such SoCs.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Tested-by: Anders Roxell <anders.roxell@linaro.org>
Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 .../devicetree/bindings/crypto/qcom-qce.yaml  | 44 +++++++++++++++----
 1 file changed, 35 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/crypto/qcom-qce.yaml b/Documentation/devicetree/bindings/crypto/qcom-qce.yaml
index 90ddf98a6df9..bb828068c3b8 100644
--- a/Documentation/devicetree/bindings/crypto/qcom-qce.yaml
+++ b/Documentation/devicetree/bindings/crypto/qcom-qce.yaml
@@ -35,7 +35,9 @@ properties:
               - qcom,ipq6018-qce
               - qcom,ipq8074-qce
               - qcom,msm8996-qce
+              - qcom,qcm2290-qce
               - qcom,sdm845-qce
+              - qcom,sm6115-qce
           - const: qcom,ipq4019-qce
           - const: qcom,qce
 
@@ -52,16 +54,12 @@ properties:
     maxItems: 1
 
   clocks:
-    items:
-      - description: iface clocks register interface.
-      - description: bus clocks data transfer interface.
-      - description: core clocks rest of the crypto block.
+    minItems: 1
+    maxItems: 3
 
   clock-names:
-    items:
-      - const: iface
-      - const: bus
-      - const: core
+    minItems: 1
+    maxItems: 3
 
   iommus:
     minItems: 1
@@ -95,9 +93,37 @@ allOf:
             enum:
               - qcom,crypto-v5.1
               - qcom,crypto-v5.4
-              - qcom,ipq4019-qce
+              - qcom,ipq6018-qce
+              - qcom,ipq8074-qce
+              - qcom,msm8996-qce
+              - qcom,sdm845-qce
+    then:
+      properties:
+        clocks:
+          maxItems: 3
+        clock-names:
+          items:
+            - const: iface
+            - const: bus
+            - const: core
+      required:
+        - clocks
+        - clock-names
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,qcm2290-qce
+              - qcom,sm6115-qce
     then:
+      properties:
+        clocks:
+          maxItems: 1
+        clock-names:
+          items:
+            - const: core
       required:
         - clocks
         - clock-names
-- 
2.38.1

