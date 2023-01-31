Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25631683156
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 16:21:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232594AbjAaPVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 10:21:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232810AbjAaPUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 10:20:43 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 762575899D;
        Tue, 31 Jan 2023 07:18:34 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id m5-20020a05600c4f4500b003db03b2559eso10862872wmq.5;
        Tue, 31 Jan 2023 07:18:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=61P/AQP6e8qbPwaNBBQNHhtlwmhRTV3BxORPGqurYw8=;
        b=RO/xvZjMj7JOTLyABWFwig5zlh9Qldz/0fnJvM6ywngfSYFAB3v6JizCWkwluhOP/a
         xdSNcij0eODr9LSiDLkEH0uQUlaUf1niOi9mQQ6i3hjlmE1se2aiuvVkLtTAOs2teMSt
         v2atCY4WiQJ54xV701ortRE72dD8vat9WVsFvU2MbCq0Bcix42Z4xAJbjYzDrK3bF06J
         HxCD1gK4Cdqf+dAV+ZvskfjQynZHkG0JuO6tuUSlei91KzpCzD1HLn/zva23859HUD5q
         QVagFNM3M6BAuAmvA8lH56P5Tut3STbPYF7Y3dWKF8Wse9iAvpeaGCGywVdhzRvE/r2c
         Hnbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=61P/AQP6e8qbPwaNBBQNHhtlwmhRTV3BxORPGqurYw8=;
        b=q4LweHgEo4ZBg5rycHzOZgBD1+beNuE8pbrEgD9Jk/Lvt0HkbhMo10oQclP2bNQuLO
         cJ5/gEcQGB14p65dZYTRgY+ekRpNqsNC0QoMVi4tx9TxJrqducNz5y7ZGAL0RTsOxnZO
         XpGaDiFgRxJ7cr0DbUKfeshEMQvA7rOgwrmip6qW5jOq82wJrTurnzt/fWhL7e/GUcGq
         T4ImAcqUxRFndlRv4B4AqUUiqKEpDuTQ5Uw+UuHbrjwD9fz3LL5t8cd5KSOQE7lDlKQ1
         GaQAFloqMtOzHdZwWKQiqHEcL9UOBsxjoCyXRCzLMKoNrYgTNUtN1JU7pPwzJJYZPtrW
         /XYw==
X-Gm-Message-State: AFqh2kpnA4foRusdNW6VF/Gcq8s7mbxBqZzFOIonf27X2wobq6WAh+G0
        dxXl26+IFLk6vVpPERc+Vnw=
X-Google-Smtp-Source: AMrXdXviE1Wy0drAiW0KG0aFSWLWSEX+CTvlLOgTAVi0tbRMMae92F+MXMutJAp6P47lnh9ThCE7WA==
X-Received: by 2002:a05:600c:3495:b0:3db:a3a:4594 with SMTP id a21-20020a05600c349500b003db0a3a4594mr56382645wmq.28.1675178312473;
        Tue, 31 Jan 2023 07:18:32 -0800 (PST)
Received: from localhost.localdomain (93-34-88-241.ip49.fastwebnet.it. [93.34.88.241])
        by smtp.googlemail.com with ESMTPSA id x9-20020a05600c21c900b003dc434b39c7sm2854861wmj.0.2023.01.31.07.18.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 07:18:32 -0800 (PST)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
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
Subject: [PATCH v5 2/3] dt-bindings: cpufreq: qcom-cpufreq-nvmem: make cpr bindings optional
Date:   Tue, 31 Jan 2023 16:18:18 +0100
Message-Id: <20230131151819.16612-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230131151819.16612-1-ansuelsmth@gmail.com>
References: <20230131151819.16612-1-ansuelsmth@gmail.com>
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
  cells and multiple named microvolt bindings.
  Doesn't need required-opp binding in the opp nodes as they are only
  used for genpd based devices.
- cpr-based that require power-domain in the cpu nodes and use various
  source to decide the correct voltage and freq
  Require required-opp binding since they need to be linked to the
  related opp-level.

When the schema was introduced, it was wrongly set to always require these
binding but this is not the case for pre-cpr devices.

Make the power-domain and the required-opp optional and set them required
only for qcs404 based devices.

Fixes: ec24d1d55469 ("dt-bindings: opp: Convert qcom-nvmem-cpufreq to DT schema")
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
Changes v5:
- Swap patch 1 and patch 2 to fix dt_check_warning on single
Changes v4:
- Explain why required-opp needs to be conditional
- Split additional ref part
Changes v3:
- No change
Changes v2:
- Reword commit description
- Fix condition order
- Add allOf

 .../bindings/cpufreq/qcom-cpufreq-nvmem.yaml  | 74 +++++++++++--------
 1 file changed, 44 insertions(+), 30 deletions(-)

diff --git a/Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml b/Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml
index 7c42d9439abd..6f5e7904181f 100644
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
@@ -33,26 +36,6 @@ select:
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
     allOf:
@@ -63,16 +46,6 @@ patternProperties:
         then:
           $ref: /schemas/opp/opp-v2-kryo-cpu.yaml#
 
-      - if:
-          properties:
-            compatible:
-              const: operating-points-v2-kryo-cpu
-        then:
-          patternProperties:
-            '^opp-?[0-9]+$':
-              required:
-                - required-opps
-
       - if:
           properties:
             compatible:
@@ -82,6 +55,47 @@ patternProperties:
 
     unevaluatedProperties: false
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,qcs404
+
+    then:
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
+      patternProperties:
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
+
 additionalProperties: true
 
 examples:
-- 
2.38.1

