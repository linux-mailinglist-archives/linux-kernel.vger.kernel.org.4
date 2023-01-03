Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6166E65B8A6
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 02:09:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236577AbjACBJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 20:09:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236249AbjACBJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 20:09:15 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43961959F
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 17:09:12 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id m21so41869111edc.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jan 2023 17:09:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MgtnpdAa2mAi6RwKV7xNbFKSVnlSviA/bw6UNtJZNYc=;
        b=QNp0jrxui3Hwrv8jzpUKU5Mk7levcVJ6T7D+kMnjTuHqIUdYhqc+cffi262EtdEgGQ
         rgbXY9MghuZDlre1sUkAhqkF5XdKsjUhAOf/20B01xvGx3P9QbQ3LLnlucfRhvZA3NfH
         BHXRLstpD3YoPuA+e651Yk5vB/N8P2PyWwkR5PHAtRAiFaD0WTJ2KbRuesmiFmJ0q3j0
         G699UaJ6W9xX3MaL4m0d/8Smra+X8aK3ng4PS8gvf+O15Xu4RrEs8jssa/jRrLFiguZz
         X6NFAdEdlryH58yzbCsrhBar0I0IYuP84OBk7715qx4MoXwM1bKdae27igG1Wjik/XvY
         yl5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MgtnpdAa2mAi6RwKV7xNbFKSVnlSviA/bw6UNtJZNYc=;
        b=qlzXihmpWuPr0HWz+llO+xv0yUwdRk+7f4sq0gyBykqJf0bGe0BdY+5FivYsMpchs1
         DlPf+8EiEQRYvqzWxCTC6i+X8J5JK1ko/7w7s0Z2Y5e+KYtdNi/6QUii0hIuZlcNucEx
         iaq4mGSPqM3X/jclEbZI7RbglQYAg27fYcxUL88RshKiOmV8sNm1O6+iDxFtUA0nTfct
         Y6A9YyFERG8WoA061W/qdXtrGlY7XkxllhU/VVxXdVo3c+KBW1y7xjL0+NxfO6PPPNIe
         TcnzUaGn02LW7tl470gBZqbxQeHTHKph0r/ytA7WVzgZ/jAohHk9Z+KIFKaJhUxGVZSA
         7myg==
X-Gm-Message-State: AFqh2kp6i4+zPBH8k1dfBWiSDOr8D8Azs9kLxhUqdMJhvGiowIVOTgyv
        sDWz1qqAsUOFkWkFDxWotk2neQ==
X-Google-Smtp-Source: AMrXdXuKWE8RXCd1J/X5oqPL7hbqrTB/MbbtwpLkEun2H52wl3KNYTCbcKcIBJ9kXaXS0yKPyNmGzA==
X-Received: by 2002:a05:6402:78e:b0:487:a00e:192f with SMTP id d14-20020a056402078e00b00487a00e192fmr21177906edy.33.1672708150834;
        Mon, 02 Jan 2023 17:09:10 -0800 (PST)
Received: from planet9.chello.ie (2001-1c06-2302-5600-b443-9db7-1e5c-4fd5.cable.dynamic.v6.ziggo.nl. [2001:1c06:2302:5600:b443:9db7:1e5c:4fd5])
        by smtp.gmail.com with ESMTPSA id q26-20020a17090676da00b008302732f569sm13564648ejn.78.2023.01.02.17.09.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jan 2023 17:09:10 -0800 (PST)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        djakov@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     bryan.odonoghue@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, benl@squareup.com,
        shawn.guo@linaro.org, fabien.parent@linaro.org, leo.yan@linaro.org,
        dmitry.baryshkov@linaro.org
Subject: [PATCH v2 1/7] dt-bindings: interconnect: Move interconnect child node definition
Date:   Tue,  3 Jan 2023 01:08:58 +0000
Message-Id: <20230103010904.3201835-2-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230103010904.3201835-1-bryan.odonoghue@linaro.org>
References: <20230103010904.3201835-1-bryan.odonoghue@linaro.org>
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

New properties should be defined before the allOf. Move the
patternProperties definition to before the additionalProperties: false in
this file.

Fixes: dfeef93fe3ee ("dt-bindings: interconnect: Convert snoc-mm to a sub-node of snoc")
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 .../bindings/interconnect/qcom,rpm.yaml       | 62 +++++++++----------
 1 file changed, 31 insertions(+), 31 deletions(-)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,rpm.yaml b/Documentation/devicetree/bindings/interconnect/qcom,rpm.yaml
index 4b37aa88a375b..50b80ca07e433 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,rpm.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,rpm.yaml
@@ -62,6 +62,37 @@ properties:
   power-domains:
     maxItems: 1
 
+# Child node's properties
+patternProperties:
+  '^interconnect-[a-z0-9]+$':
+    type: object
+    description:
+      snoc-mm is a child of snoc, sharing snoc's register address space.
+
+    properties:
+      compatible:
+        enum:
+          - qcom,msm8939-snoc-mm
+
+      '#interconnect-cells':
+        const: 1
+
+      clock-names:
+        items:
+          - const: bus
+          - const: bus_a
+
+      clocks:
+        items:
+          - description: Bus Clock
+          - description: Bus A Clock
+
+    required:
+      - compatible
+      - '#interconnect-cells'
+      - clock-names
+      - clocks
+
 required:
   - compatible
   - reg
@@ -109,37 +140,6 @@ allOf:
             - description: Bus Clock
             - description: Bus A Clock
 
-      # Child node's properties
-      patternProperties:
-        '^interconnect-[a-z0-9]+$':
-          type: object
-          description:
-            snoc-mm is a child of snoc, sharing snoc's register address space.
-
-          properties:
-            compatible:
-              enum:
-                - qcom,msm8939-snoc-mm
-
-            '#interconnect-cells':
-              const: 1
-
-            clock-names:
-              items:
-                - const: bus
-                - const: bus_a
-
-            clocks:
-              items:
-                - description: Bus Clock
-                - description: Bus A Clock
-
-          required:
-            - compatible
-            - '#interconnect-cells'
-            - clock-names
-            - clocks
-
   - if:
       properties:
         compatible:
-- 
2.34.1

