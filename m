Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A99B678674
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 20:34:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231799AbjAWTeh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 14:34:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbjAWTeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 14:34:36 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E654931E0C;
        Mon, 23 Jan 2023 11:34:34 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id bk16so11826848wrb.11;
        Mon, 23 Jan 2023 11:34:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fT8/4JtDsE0YLu2QTGwrIucYe0iIl5yrZgyKe52Vxt0=;
        b=MyN/HVpy+iGknjLb01ZXX6V1zantOArIGSbx7Hfh02ILItgOR5jbSdjM1rh7k91pal
         Hmldfoz3YoxtE41iHSI5EvSN6AomdKawaUQjq6uRI26Qeukgrqn2GClLSNS6Afktqgc4
         ozpUPH0Sf6I+vM9nTM/BfiDCxKmlR0wMoYUBpsk0RmkxyVjyjlfmuLbx6y2yerX2XlyL
         B1L6dAhHdGErOVp/cT85OSW81lvkLLU7q0Xnx6GHOIxTbTLhoBYxafGAG0XPlazzYJQw
         RaSQDc3RvrL92asL1VbkPuDOXsoEj1wvmrWefuxk5IfVEpKmfz5cxXiXh3tqoaqCD/82
         YVTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fT8/4JtDsE0YLu2QTGwrIucYe0iIl5yrZgyKe52Vxt0=;
        b=C5OsWFNNZF9rtKDBk6MZEfvqudQ85/KTP1zQAIA3D2/ePqvDSlMSW/ogKbWAOih7N5
         wZvIT4OzMGSsktaNse7wnX2NSbn43065vnvhn5ZIk93yXi+KwcAl62Le3BJ6YyEGmjka
         dhgcRdJhvH79Vuop/1HUySxFuanBZZ2U+6yN22/PGptkXvTpZYv9DITaK2sURf91MCfl
         UbB7RRn7FiSCbY+9kWM5QErkYxufzet+C0v/QIRX56a6ILwcqVLX83VJONf0duntk2sP
         o5an1+dPf+O6suNG1Q0wqSWjNIcm9vISpOeWr5g1CokwdPb73+Nm5cddSiDI1foUAEKn
         ts9Q==
X-Gm-Message-State: AFqh2koSyGePlMV6OTbh16MdGg3OFJRzEDLhDZ+ktdat6q5jfqUQ1VT/
        iscZ8/H39Sb69e5H/xGULzc=
X-Google-Smtp-Source: AMrXdXseQT646WmqbfLo2Jjq9TtOmfd4GJkOXvOok5et0qEfdMM3jD97AMUlbSv77byUoFS/oq4iPQ==
X-Received: by 2002:a5d:4644:0:b0:2be:5cf8:2a83 with SMTP id j4-20020a5d4644000000b002be5cf82a83mr10311279wrs.37.1674502473337;
        Mon, 23 Jan 2023 11:34:33 -0800 (PST)
Received: from localhost.localdomain (93-34-89-61.ip49.fastwebnet.it. [93.34.89.61])
        by smtp.googlemail.com with ESMTPSA id z8-20020a5d4408000000b002b8fe58d6desm151428wrq.62.2023.01.23.11.34.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 11:34:32 -0800 (PST)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Ilia Lin <ilia.lin@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH v3 1/2] dt-bindings: cpufreq: qcom-cpufreq-nvmem: make cpr bindings optional
Date:   Mon, 23 Jan 2023 20:34:21 +0100
Message-Id: <20230123193422.15972-1-ansuelsmth@gmail.com>
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

Changes v2:
- Reword commit description
- Fix condition order
- Add allOf

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

