Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 406736761D3
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 01:02:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbjAUAB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 19:01:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjAUAB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 19:01:56 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE21F72C2D;
        Fri, 20 Jan 2023 16:01:54 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id q8so5205901wmo.5;
        Fri, 20 Jan 2023 16:01:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fhc4Y58GfuJKdaxY2E2d3ec0IbqBR1waIv5D5PvQivo=;
        b=WGxp0F2TAS20TYxjbXmwc/7G+zGhU4YiYa3FcdzYwc4ZozaZpVqz5+KIpLaJ0H++PX
         Kq7c7sM6hpqbOsZGGganbMflhKSybAfCzSSwxPaHd84SvrQH4OOGs9jF4GDdUAMf4S5e
         jpIfNzMeDYDQxNtMnqTsE05t8rYz00BLPqAorJEqAnJ+5MSjWY/PSlM2WilmPCIU1mRy
         /xseyJrPvS/0S1WlIwYD9Fj906Uu2kNaHpNQA2xNIyr7dC4Z0XJChutOtmRd/p9aR4pn
         Rio+m2949kaRZeHv3dByAk6wxk9rq5sgBx3eMe2i91Wh+VIgny2tbaMKBaX5cml1ilJJ
         i2uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fhc4Y58GfuJKdaxY2E2d3ec0IbqBR1waIv5D5PvQivo=;
        b=p7+8S3h8u/F5tpbAylnerBtSIfbXvhxFFcfm629JFz3pGTRWOLka+LhsF6ezXU6gaj
         YZEiZrv6y0dJEjW2FeiRg8eFAq+57N6ohhCtNaAcKIM0pq9NlD8glcgabYIWEcwd9eiS
         42pGPLOCClxPdNietmyIn0ZCljdOOQi/SZCbKj0gFqsIM+ScvTYjxiP/EDG6JJXnS+/a
         +FoPCoooPezYwx+kY/Ru2peAmU3Z1YErlSEZpz5OyBxI1+tbCXaXCu5SwW3Q57od+9RG
         mk1V+JYfSX0WLp99pJ/FfC8+jcsJUj1unySLjtg55cQupbRTxFH67vLIPRXAfsDYFD9o
         Zx6g==
X-Gm-Message-State: AFqh2kr+W0y6KACHwzTfzo8cY0rSxd2SuwJbaYT7OK/eNu4RJlaUDwjQ
        7naHbA3XncNxyZS3Vb8ZEak=
X-Google-Smtp-Source: AMrXdXuCfFSNdqZaJRW0nxetEx9oWl/x974wMwsuGX0vI7+aEt+IlZUuugfKOcbztUuDhbjyFST6Rw==
X-Received: by 2002:a05:600c:4689:b0:3d6:80b5:f948 with SMTP id p9-20020a05600c468900b003d680b5f948mr15180561wmo.39.1674259313187;
        Fri, 20 Jan 2023 16:01:53 -0800 (PST)
Received: from localhost.localdomain (93-34-92-88.ip49.fastwebnet.it. [93.34.92.88])
        by smtp.googlemail.com with ESMTPSA id h11-20020a05600c314b00b003db2e3f2c7csm5284292wmo.0.2023.01.20.16.01.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 16:01:52 -0800 (PST)
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
Subject: [PATCH 1/3] dt-bindings: cpufreq: qcom-cpufreq-nvmem: make cpr bindings optional
Date:   Sat, 21 Jan 2023 01:01:44 +0100
Message-Id: <20230121000146.7809-1-ansuelsmth@gmail.com>
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

The qcom-cpufreq-nvmem driver also supports legacy devices pre-cpr that
doesn't have power-domains. When the schema was introduced, it was
wrongly set to always require these binding but this is not the case for
legacy device that base everything on nvmem cells and multiple microvolt
binding providing values based on speedbin, psv and version.

Make the power-domain optional and set them required only for qcs404
based devices.

Fixes: ec24d1d55469 ("dt-bindings: opp: Convert qcom-nvmem-cpufreq to DT schema")
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 .../bindings/cpufreq/qcom-cpufreq-nvmem.yaml  | 78 +++++++++++++------
 1 file changed, 54 insertions(+), 24 deletions(-)

diff --git a/Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml b/Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml
index 9c086eac6ca7..04aac634d7fc 100644
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
@@ -33,37 +36,64 @@ select:
   required:
     - compatible
 
-properties:
-  cpus:
-    type: object
+if:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - qcom,qcs404
 
-    patternProperties:
-      '^cpu@[0-9a-f]+$':
-        type: object
+then:
+  properties:
+    cpus:
+      type: object
 
-        properties:
-          power-domains:
-            maxItems: 1
+      patternProperties:
+        '^cpu@[0-9a-f]+$':
+          type: object
+
+          properties:
+            power-domains:
+              maxItems: 1
 
-          power-domain-names:
-            items:
-              - const: cpr
+            power-domain-names:
+              items:
+                - const: cpr
 
-        required:
-          - power-domains
-          - power-domain-names
+          required:
+            - power-domains
+            - power-domain-names
+
+  patternProperties:
+    '^opp-table(-[a-z0-9]+)?$':
+      if:
+        properties:
+          compatible:
+            const: operating-points-v2-kryo-cpu
+      then:
+        patternProperties:
+          '^opp-?[0-9]+$':
+            required:
+              - required-opps
 
 patternProperties:
   '^opp-table(-[a-z0-9]+)?$':
-    if:
-      properties:
-        compatible:
-          const: operating-points-v2-kryo-cpu
-    then:
-      patternProperties:
-        '^opp-?[0-9]+$':
-          required:
-            - required-opps
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
 
 additionalProperties: true
 
-- 
2.38.1

