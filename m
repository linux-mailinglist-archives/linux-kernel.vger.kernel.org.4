Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 300AC6CA73B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 16:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233032AbjC0ORF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 10:17:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232546AbjC0OQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 10:16:49 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0598F4C18
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 07:15:18 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id y4so36915961edo.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 07:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679926469;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=22QlH78r30mKptSQUkIWzE57vqh8AC7rlz//RU6jXdY=;
        b=AfCrN1i2xIgn6wwC9icg2OS4DCmKfS+z5Nyv9CmF4mLF7ttRQOatpUd6XVrxEjfpuT
         Gln1DcQyVvnZSxoz7gJM7274ueEfHyjZzkVlkmO+zVueGTX/AbWfD1QeDbB9W1hSGW1u
         wptrsYFTK+wbh9fOSIm4XmnuU4ooqQlTRC6b2AeMfqXINelXJvyEB5CoUH9EqXQvmjtQ
         tNw0jdKn0oiMr5jH9RBo7uWxGxAO/s75hiFkfGF8Vh7f/8g8z3zNGB7XVY8R9zwLj0fx
         Nyb/VBw0Jh20LhVL9zQkgMTf5zo/9FRSKtLUDa54WHnPgrdDh8Rx+5UJs8zQHXyzfqBx
         DO4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679926469;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=22QlH78r30mKptSQUkIWzE57vqh8AC7rlz//RU6jXdY=;
        b=DLGh68KbQx1LfqJPDNcjNJ5gaLV7+dr3CxRDRn3ma92ordsX7K9GTvCguCe1t/slWC
         iUgGwGlEqzxm5EWWE7cs8Xs7g6jVgifuBocbMWPZwIiln2xxOSUPENqm0bIga5UdO74L
         jOdg3mad1jPHthg5kxte264O/td3JcpzgELp//okW6Zu7KMlu+B50mH0RmMQhJAZg4vO
         xw2iUwTy+JWRbFPlSqlL1a0+xTLGZNtejv701hvhPD6ZaEKVWaDMkksPDbLee9l9ddTQ
         1RL2EBhhFWrZucR47OqnBxYT7cJW/OdtacWIxtuwDVZxhJbbdI+UitRLrftPM92wGSkG
         IE+A==
X-Gm-Message-State: AAQBX9dfW1hhIA8VbyfChaelExyEOw+tbg7XMETr+k2q1olzglNT34UT
        glJ9q9nZ4n5EIpM7Y+MDdbwBrA==
X-Google-Smtp-Source: AKy350YmQv6hHiUGGLcJ241v2uYAzUMQy8PH4CEurgzdHJV5/JTDiWtzCCR5u5jsenJzjqUsj8x6ug==
X-Received: by 2002:a17:906:478a:b0:930:fded:5bf2 with SMTP id cw10-20020a170906478a00b00930fded5bf2mr14687354ejc.52.1679926469679;
        Mon, 27 Mar 2023 07:14:29 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:581e:789c:7616:5ee])
        by smtp.gmail.com with ESMTPSA id ha25-20020a170906a89900b00934212e973esm11273339ejb.198.2023.03.27.07.14.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 07:14:29 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v4 1/5] dt-bindings: mailbox: qcom,apcs-kpss-global: use fallbacks for few variants
Date:   Mon, 27 Mar 2023 16:07:48 +0200
Message-Id: <20230327140752.163009-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230327140752.163009-1-krzysztof.kozlowski@linaro.org>
References: <20230327140752.163009-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rework the compatibles of IPQ8074, SC7180, SC8180X and SM8150 as
compatible devices (same from Linux driver point of view).  This allows
smaller of_device_id table in the Linux driver and smaller
allOf:if:then: constraints.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Rob Herring <robh@kernel.org>

---

Changes since v3:
1. Narrow the scope of the patch after feedback from Dmitry.

Depends on (merged to Qualcomm SoC tree):
https://lore.kernel.org/linux-arm-msm/20230322173559.809805-1-krzysztof.kozlowski@linaro.org/T/#t
---
 .../mailbox/qcom,apcs-kpss-global.yaml        | 31 ++++++++++---------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml b/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml
index 4d2f408a5efb..99cbf284ce9c 100644
--- a/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml
+++ b/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml
@@ -19,22 +19,14 @@ properties:
       - items:
           - enum:
               - qcom,ipq5332-apcs-apps-global
+              - qcom,ipq8074-apcs-apps-global
           - const: qcom,ipq6018-apcs-apps-global
       - items:
           - enum:
-              - qcom,ipq6018-apcs-apps-global
-              - qcom,ipq8074-apcs-apps-global
-              - qcom,msm8996-apcs-hmss-global
-              - qcom,msm8998-apcs-hmss-global
-              - qcom,qcm2290-apcs-hmss-global
               - qcom,sc7180-apss-shared
               - qcom,sc8180x-apss-shared
-              - qcom,sdm660-apcs-hmss-global
-              - qcom,sdm845-apss-shared
-              - qcom,sm4250-apcs-hmss-global
-              - qcom,sm6125-apcs-hmss-global
-              - qcom,sm6115-apcs-hmss-global
               - qcom,sm8150-apss-shared
+          - const: qcom,sdm845-apss-shared
       - items:
           - enum:
               - qcom,msm8916-apcs-kpss-global
@@ -45,6 +37,18 @@ properties:
               - qcom,qcs404-apcs-apps-global
               - qcom,sdx55-apcs-gcc
           - const: syscon
+      - enum:
+          - qcom,ipq6018-apcs-apps-global
+          - qcom,ipq8074-apcs-apps-global
+          - qcom,msm8996-apcs-hmss-global
+          - qcom,msm8998-apcs-hmss-global
+          - qcom,qcm2290-apcs-hmss-global
+          - qcom,sdm660-apcs-hmss-global
+          - qcom,sdm845-apss-shared
+          - qcom,sm4250-apcs-hmss-global
+          - qcom,sm6115-apcs-hmss-global
+          - qcom,sm6125-apcs-hmss-global
+
   reg:
     maxItems: 1
 
@@ -88,6 +92,7 @@ allOf:
           items:
             - const: pll
             - const: aux
+
   - if:
       properties:
         compatible:
@@ -106,13 +111,13 @@ allOf:
             - const: ref
             - const: pll
             - const: aux
+
   - if:
       properties:
         compatible:
           contains:
             enum:
               - qcom,ipq6018-apcs-apps-global
-              - qcom,ipq8074-apcs-apps-global
     then:
       properties:
         clocks:
@@ -134,14 +139,11 @@ allOf:
             - qcom,msm8996-apcs-hmss-global
             - qcom,msm8998-apcs-hmss-global
             - qcom,qcm2290-apcs-hmss-global
-            - qcom,sc7180-apss-shared
-            - qcom,sc8180x-apss-shared
             - qcom,sdm660-apcs-hmss-global
             - qcom,sdm845-apss-shared
             - qcom,sm4250-apcs-hmss-global
             - qcom,sm6115-apcs-hmss-global
             - qcom,sm6125-apcs-hmss-global
-            - qcom,sm8150-apss-shared
     then:
       properties:
         clocks: false
@@ -153,7 +155,6 @@ allOf:
           contains:
             enum:
               - qcom,ipq6018-apcs-apps-global
-              - qcom,ipq8074-apcs-apps-global
     then:
       properties:
         '#clock-cells':
-- 
2.34.1

