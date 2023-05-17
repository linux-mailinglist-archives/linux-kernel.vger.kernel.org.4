Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 200E37073F2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 23:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbjEQVTO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 17:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbjEQVTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 17:19:06 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B790AD0D
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 14:18:42 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-643a1656b79so1026005b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 14:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684358298; x=1686950298;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q9+WkMxaCFyRvz0ZQf19zyMmoq6vin0MgQ/wuGkS8c8=;
        b=bV7CpqoXWuNQqlxJQEUuHy5yHUGj+DQhue+ANh59IgumWtxISkQAYNuJBeLQy21CNn
         1hn9LwbNitAPTKlJv1X2U5lEUTlm73y0K/4Idn0MuAMOAgrgw2+8e7mp0fkfuwk1w4ym
         9FjpNrtPd5pY/NZZ7b33P5U0WuOVOHUu+M/PfXJYGauRs2RD72pyJ/tTXY5zzjIcNGHj
         wuIxeqVqFSrnveWFJTVmQXVHfxx2lVi9ZXApbK1l9p2TW6HYUvhyeWzj1uDt6ALa69oT
         6VI+PjEBefyOIj4LCqhMHNSPnjEo6AjOwMhp3CXFHZjBT6+2qKK+uJDjA4C39OxAMPcZ
         h6VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684358298; x=1686950298;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q9+WkMxaCFyRvz0ZQf19zyMmoq6vin0MgQ/wuGkS8c8=;
        b=hL2ZdwNOsRikxS5d6oG+fLeXC58RGRpZxlShA9+nfS8YWQdWqUZtesHzDo9oUNf/Tz
         DVKuQKEeI6HBv4Oq+0KDhWnrhstHlQKz2S8nC22gen6yHgvNlYOvdquBAbdjRiJM43oe
         wcUfvcwz/RjCGdXeFsnZmMruAgViz1vqUR0dopHWAgM2IwZu0mvuhJYRGr9MMGu/FvsP
         ct0RDZWHwnSzCE+bLRZG3N07IT/ri931wvRdyWdZ+PRSb+L++ghZEOXSZSIrreBoKcUg
         1vXIcZRDDXylluvHcjQ0+Fo2JogTom3aruZ2l7FJ0kAcO8dBZitR7CW0RSqFfT+wjOq/
         8OZQ==
X-Gm-Message-State: AC+VfDwAOHnBDhrc0OKnq7fvAFSdAWFvv68sZLRW+gad1Bg9X+IsNPUi
        wa2t0SFj3IUg+gfqFLvc21hW+Q==
X-Google-Smtp-Source: ACHHUZ45gEUCvskwkuAPB9ALTbFYRXtXCtNEJ7JJ9uOPKvh/xudi3JWJeMW3u5y1tRMOmtcTH8o4MA==
X-Received: by 2002:a05:6a00:2d1c:b0:643:b489:246d with SMTP id fa28-20020a056a002d1c00b00643b489246dmr1695144pfb.3.1684358297860;
        Wed, 17 May 2023 14:18:17 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1c60:6bed:7a51:340a:a439:1b87])
        by smtp.gmail.com with ESMTPSA id n18-20020aa79052000000b0064cb6206463sm4359210pfo.85.2023.05.17.14.18.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 14:18:17 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-kernel@vger.kernel.org, bhupesh.linux@gmail.com,
        bhupesh.sharma@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, krzysztof.kozlowski@linaro.org,
        quic_schowdhu@quicinc.com, gregkh@linuxfoundation.org
Subject: [PATCH v6 2/6] dt-bindings: soc: qcom: eud: Add SM6115 / SM4250 support
Date:   Thu, 18 May 2023 02:47:52 +0530
Message-Id: <20230517211756.2483552-3-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230517211756.2483552-1-bhupesh.sharma@linaro.org>
References: <20230517211756.2483552-1-bhupesh.sharma@linaro.org>
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

Add dt-bindings for EUD found on Qualcomm SM6115 / SM4250 SoC.

On this SoC (and derivatives) the enable bit inside 'tcsr_check_reg'
needs to be set first to 'enable' the eud module.

So, update the dt-bindings to accommodate the third register
property (TCSR Base) required by the driver on these SoCs.

Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 .../bindings/soc/qcom/qcom,eud.yaml           | 42 +++++++++++++++++--
 1 file changed, 39 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,eud.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,eud.yaml
index f2c5ec7e6437..9c64b5d9504f 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,eud.yaml
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,eud.yaml
@@ -18,12 +18,16 @@ properties:
     items:
       - enum:
           - qcom,sc7280-eud
+          - qcom,sm6115-eud
       - const: qcom,eud
 
   reg:
-    items:
-      - description: EUD Base Register Region
-      - description: EUD Mode Manager Register
+    minItems: 2
+    maxItems: 3
+
+  reg-names:
+    minItems: 2
+    maxItems: 3
 
   interrupts:
     description: EUD interrupt
@@ -52,6 +56,38 @@ required:
 
 additionalProperties: false
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,sc7280-eud
+    then:
+      properties:
+        reg:
+          maxItems: 2
+        reg-names:
+          items:
+            - const: eud-base
+            - const: eud-mode-mgr
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,sm6115-eud
+    then:
+      properties:
+        reg:
+          maxItems: 3
+        reg-names:
+          items:
+            - const: eud-base
+            - const: eud-mode-mgr
+            - const: tcsr-base
+
 examples:
   - |
     eud@88e0000 {
-- 
2.38.1

