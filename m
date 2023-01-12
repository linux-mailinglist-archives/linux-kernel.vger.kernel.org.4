Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7CD8668485
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 21:54:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239940AbjALUx4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 15:53:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232847AbjALUwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 15:52:55 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 263BAFD12;
        Thu, 12 Jan 2023 12:26:34 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id x37so20564749ljq.1;
        Thu, 12 Jan 2023 12:26:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0XAdZ0L8PF2H6GOe/B7FuNBD1OvdAzvAA3E5DCKDiB0=;
        b=hBw9zvSHutT3/JOMAZW5GBanI2jxRfd1SRYMPqJ4O1ue7CYZV63/IIJ3G9lEItNgxk
         7wz7Ii9cbo01WzIywtBMsiZfgdvbry5iBHKkj1CzpYL0jwquhUa9rfLjR1Wz3M9N5X1h
         yIOCXEjj6fUwIez/GTLCiwXQ34vy2rlNd1bFj1ssh4e+WEW2AXKhEwv+nRL9CDHny+wV
         WTrcFfYcptLVd+AYCMfnrxDFnsw938vHJ/tNp5kRlBt5P4APOvXYTGRTuNDbakN2TWtv
         ExokZ1V/eMW61FjhYqGPXMnySpTtTYNpAHNjETYV2m3BPwatHe7L7JDWQS68bmjR1Bkg
         nI3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0XAdZ0L8PF2H6GOe/B7FuNBD1OvdAzvAA3E5DCKDiB0=;
        b=cmtuvI8WjJbpqcFX8nbjxjWtt1A/v/3Imocmtd56ndzh4E7wvg3jnfZNCXIfdhnAtH
         uX1VDW1F49dqmq0Cpap9xY7bwF48+Cg2zGQf1Z0uXHTXCnuz+Zhu6EVeJacVsO/7rQ8v
         oCSuuplMgkLvOy1wQ8qgH+LffQMNij6ilKVWxyilp99oGaCpObJEdBmQ4sBNl2tf5MnI
         S/3Q15oZiQCiORUvGQlRgyg5O0zO3NGMyq/SGZnFRhOANqar+eWTHPzCNh4FsltqoGXZ
         V3+b+YnTD3Q1yRNbeNZj3yyMXMnYiXX6DtQWtJ9rjmXtTmgzAagcPC2q8VbI3cheuGfM
         +ZBw==
X-Gm-Message-State: AFqh2kq4Zboo/LsMGW7t5ZyyDB8Ks57dGyQImCL3hDb3o5JRhvN+MrvC
        TI2izjqTio0v9CuAlgIE1V+8ALUZFG+pLA==
X-Google-Smtp-Source: AMrXdXtqlnGPS791Sixw5FEQ6Wr88B4aSdSUp8wrTbxrs/Duins3dsn/k/fiercEqKt8G5hfiJjpYA==
X-Received: by 2002:a05:651c:194b:b0:280:117:745e with SMTP id bs11-20020a05651c194b00b002800117745emr12414681ljb.0.1673555192556;
        Thu, 12 Jan 2023 12:26:32 -0800 (PST)
Received: from i-vetokaappi.home.lan (dsl-hkibng42-56733b-36.dhcp.inet.fi. [86.115.59.36])
        by smtp.gmail.com with ESMTPSA id k6-20020a2eb746000000b00281350bb5fbsm2346731ljo.2.2023.01.12.12.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 12:26:32 -0800 (PST)
From:   =?UTF-8?q?Matti=20Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        =?UTF-8?q?Matti=20Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/8] dt-bindings: remoteproc: qcom,msm8916-mss-pil: Add MSM8226
Date:   Thu, 12 Jan 2023 22:26:04 +0200
Message-Id: <20230112202612.791455-2-matti.lehtimaki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230112202612.791455-1-matti.lehtimaki@gmail.com>
References: <20230112202612.791455-1-matti.lehtimaki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds support for platforms with only single power domain.
Adds support for external power block headswitch (BHS) registers

Signed-off-by: Matti Lehtimäki <matti.lehtimaki@gmail.com>
---
 .../remoteproc/qcom,msm8916-mss-pil.yaml      | 41 +++++++++++++++++--
 1 file changed, 37 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,msm8916-mss-pil.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,msm8916-mss-pil.yaml
index 6e6e69ad9cd7..6a921f2711b2 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,msm8916-mss-pil.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,msm8916-mss-pil.yaml
@@ -17,6 +17,7 @@ properties:
   compatible:
     oneOf:
       - enum:
+          - qcom,msm8226-mss-pil
           - qcom,msm8909-mss-pil
           - qcom,msm8916-mss-pil
           - qcom,msm8953-mss-pil
@@ -70,16 +71,17 @@ properties:
     items:
       - description: CX proxy power domain (control handed over after startup)
       - description: MX proxy power domain (control handed over after startup)
+                     (not valid for qcom,msm8226-mss-pil)
       - description: MSS proxy power domain (control handed over after startup)
                      (only valid for qcom,msm8953-mss-pil)
-    minItems: 2
+    minItems: 1
 
   power-domain-names:
     items:
       - const: cx
-      - const: mx
+      - const: mx # not valid for qcom,msm8226-mss-pil
       - const: mss # only valid for qcom,msm8953-mss-pil
-    minItems: 2
+    minItems: 1
 
   pll-supply:
     description: PLL proxy supply (control handed over after startup)
@@ -106,6 +108,15 @@ properties:
     items:
       - const: stop
 
+  qcom,ext-bhs-reg:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description: External power block headswitch (BHS) register
+                 (only valid for qcom,msm8226-mss-pil)
+    items:
+      - items:
+          - description: phandle to external BHS syscon region
+          - description: offset to the external BHS register
+
   qcom,halt-regs:
     $ref: /schemas/types.yaml#/definitions/phandle-array
     description:
@@ -205,13 +216,35 @@ allOf:
       required:
         - power-domains
         - power-domain-names
-    else:
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,msm8909-mss-pil
+              - qcom,msm8916-mss-pil
+              - qcom,msm8974-mss-pil
+    then:
       properties:
         power-domains:
           maxItems: 2
         power-domain-names:
           maxItems: 2
 
+  - if:
+      properties:
+        compatible:
+          const: qcom,msm8226-mss-pil
+    then:
+      properties:
+        power-domains:
+          maxItems: 1
+        power-domain-names:
+          maxItems: 1
+      required:
+        - qcom,ext-bhs-reg
+
   - if:
       properties:
         compatible:
-- 
2.34.1

