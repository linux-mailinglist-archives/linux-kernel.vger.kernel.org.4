Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC4667712F
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 18:46:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbjAVRp7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 12:45:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbjAVRp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 12:45:57 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A427BC163;
        Sun, 22 Jan 2023 09:45:54 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id c10-20020a05600c0a4a00b003db0636ff84so7034723wmq.0;
        Sun, 22 Jan 2023 09:45:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C1pTKo3OWmmnFLZF4o1FXmS9+0egk/fNiq0vh7NwwbU=;
        b=aRl4d32ipmSDJVbkB5xcYtx/AEwBlze3zNYXP97tiaBBpEkJWi9Ocm3s2RSA6dbWAT
         WiKfLjPLWOZZtJTA2bF0t8Ps4md2g3wtDHIq+Y9rZLqri54rsQhr1YSYASz/4hz2klL8
         pNclQ14iwKUYBdN/Skrr9eBveH+M3sULQMipbSi7KoTkWfZt/ccuvFL67f0liZeAMFSg
         JHAs8yHxUK9T7Rt/3udUUNESxkzTJhLpBWzknac5PU0aMWT5FYH4EhSDsxP6ICU2N3rB
         TcViA1D/7jyYCFWyy8lMD/hZnLUGElS8KlzNSV4dCL/LePhKt6UQyiashgwN14Llv6rk
         dZdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C1pTKo3OWmmnFLZF4o1FXmS9+0egk/fNiq0vh7NwwbU=;
        b=NqofxZnzJMXcn5kjP7Lfs6woqlwCV+Jr1qlrMldHQI2UXG9fNQL0MRPge9r0d4GxdO
         MUiFblh1IeWZfZs9nUq1LQwr8igGq6zltsi+L5ctYHnpoCQKUupHwBaLnBvfIhYK6Sh3
         G41EG0HzV3lctreRZ2ojlBPvXdknMfnW2/gFDuqQC099BWOuteKMmc74QsqF8YB4SUL+
         0G7O1AUDyrRoEK6blD90W+5Ni9LdiruXgoLtoYW9cEcmvH146uBP3KRkvnze+LFlugME
         nD5lfjde81CUfA4tv35Zt0YdCLBmryKHOt1Q3x/E0x709g0qlID90cf8IwfpZ86dM1CG
         CZJA==
X-Gm-Message-State: AFqh2koN3zpIvAXAI6DuzP289rA9UQXo+mAKJ5omXqUVTMSEGNGAg2qK
        TxYTTnxMnGiHvpH6C6ewHtWA3lpL16w=
X-Google-Smtp-Source: AMrXdXv15xgAEn1TsHXrbNh2/YWwtVVKsFJc/09xjz314ROnSyjf0M66mSz36RwziLbNJ3WC3u1s4A==
X-Received: by 2002:a05:600c:16c9:b0:3db:222:3e0c with SMTP id l9-20020a05600c16c900b003db02223e0cmr21130173wmn.33.1674409553042;
        Sun, 22 Jan 2023 09:45:53 -0800 (PST)
Received: from localhost.localdomain (93-34-89-61.ip49.fastwebnet.it. [93.34.89.61])
        by smtp.googlemail.com with ESMTPSA id m2-20020a05600c4f4200b003db0ad636d1sm9202257wmq.28.2023.01.22.09.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Jan 2023 09:45:52 -0800 (PST)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Ilia Lin <ilia.lin@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH v2 1/2] dt-bindings: cpufreq: qcom-cpufreq-nvmem: make cpr bindings optional
Date:   Sun, 22 Jan 2023 18:45:47 +0100
Message-Id: <20230122174548.13758-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
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

The qcom-cpufreq-nvmem driver supports 2 kind of devices:
- pre-cpr that doesn't have power-domains and base everything on nvmem
  cells and multiple named microvolt bindings
- cpr-based that require power-domain in the cpu nodes and use various
  source to decide the correct voltage and freq

When the schema was introduced, it was wrongly set to always require these
binding but this is not the case for pre-cpr devices.

Make the power-domain optional and set them required only for qcs404
based devices.

While at it also make more clear what the opp-table supports by adding
ref to the opp-v2-kryo-cpu and opp-v2-qcom-level schema.

Fixes: ec24d1d55469 ("dt-bindings: opp: Convert qcom-nvmem-cpufreq to DT schema")
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 .../bindings/cpufreq/qcom-cpufreq-nvmem.yaml  | 81 +++++++++++++------
 1 file changed, 56 insertions(+), 25 deletions(-)

diff --git a/Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml b/Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml
index 9c086eac6ca7..6f5e7904181f 100644
--- a/Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml
+++ b/Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml
@@ -17,6 +17,9 @@ description: |
   on the CPU OPP in use. The CPUFreq driver sets the CPR power domain level
   according to the required OPPs defined in the CPU OPP tables.
 
+  For old implementation efuses are parsed to select the correct opp table and
+  voltage and CPR is not supported/used.
+
 select:
   properties:
     compatible:
@@ -33,37 +36,65 @@ select:
   required:
     - compatible
 
-properties:
-  cpus:
-    type: object
-
-    patternProperties:
-      '^cpu@[0-9a-f]+$':
-        type: object
-
-        properties:
-          power-domains:
-            maxItems: 1
-
-          power-domain-names:
-            items:
-              - const: cpr
-
-        required:
-          - power-domains
-          - power-domain-names
-
 patternProperties:
   '^opp-table(-[a-z0-9]+)?$':
-    if:
+    allOf:
+      - if:
+          properties:
+            compatible:
+              const: operating-points-v2-kryo-cpu
+        then:
+          $ref: /schemas/opp/opp-v2-kryo-cpu.yaml#
+
+      - if:
+          properties:
+            compatible:
+              const: operating-points-v2-qcom-level
+        then:
+          $ref: /schemas/opp/opp-v2-qcom-level.yaml#
+
+    unevaluatedProperties: false
+
+allOf:
+  - if:
       properties:
         compatible:
-          const: operating-points-v2-kryo-cpu
+          contains:
+            enum:
+              - qcom,qcs404
+
     then:
+      properties:
+        cpus:
+          type: object
+
+          patternProperties:
+            '^cpu@[0-9a-f]+$':
+              type: object
+
+              properties:
+                power-domains:
+                  maxItems: 1
+
+                power-domain-names:
+                  items:
+                    - const: cpr
+
+              required:
+                - power-domains
+                - power-domain-names
+
       patternProperties:
-        '^opp-?[0-9]+$':
-          required:
-            - required-opps
+        '^opp-table(-[a-z0-9]+)?$':
+          if:
+            properties:
+              compatible:
+                const: operating-points-v2-kryo-cpu
+          then:
+            patternProperties:
+              '^opp-?[0-9]+$':
+                required:
+                  - required-opps
 
 additionalProperties: true
 
-- 
2.38.1

