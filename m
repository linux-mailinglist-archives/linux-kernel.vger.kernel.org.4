Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73E5367CF19
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 16:00:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232041AbjAZPAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 10:00:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjAZPAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 10:00:37 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D972E62249;
        Thu, 26 Jan 2023 07:00:35 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id fl11-20020a05600c0b8b00b003daf72fc844so3431724wmb.0;
        Thu, 26 Jan 2023 07:00:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=76nzNYcvbX35QXLbvfMyhTGZcru6UNYtBlqgYDNzIKU=;
        b=N9eBWIh7rqM6gnde5S1TbQc2zp+jgfMsAJHG9aj2RmehPIUPOPvKhM1SYVoIJktWd7
         nD1KAAKL1GVBEAQlbydNgyu4fd7GB2bAl9CO6fiZIvtFByhJPIzYRrYdiPTqCVKojz9h
         D9mFRJd0biyyi4CVeuK7O7xGfKKgL9XICuKQflqsP5IG4VH3DsYvZdjYlW6aQHEk2kEo
         aPCKi3/tyIYonUqvfDwACEhXSHu+VQUY9wyahSgQnC2hkXjawhkm0hzR8WRwvfS1V8+T
         STSQd2cxPFlLMVLurRSZmINmkmJrNjSyySZNOFLMMyjS+ePEriM3G8hE/7cFE106R7AQ
         nupg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=76nzNYcvbX35QXLbvfMyhTGZcru6UNYtBlqgYDNzIKU=;
        b=HeUJWuczMXV6fVdEdGd+jDxb90g/8f0cSPuWf4tviDX5BfXIZopYJN6QkVicb3se37
         KcBOb5h8lxdkhrkbeAvpxalbu52NzgGjrHVdmjRZ230tHNRcqTc4muar/u3/a2hPW4vK
         MwmhQ/TvQXNDKeWN4uu+f4xxZQoYtpCRBHQamTh78VVfJbrncRkSHb6f/rdat8XALydD
         hpEUC9hRT5wRocbcmRMj2Rr03QNBOkXCmCez3sxbYu0kP3oxjMvneK5YoRzCJHiggJHL
         uE9jmjQcQSy+U17bzDKU5jESxEKKL8bK9RYbd4yGwCIq2dYS+DdGbxFPxob9aFO9sIJL
         K8bA==
X-Gm-Message-State: AFqh2krG3eN+bts1u9FbDHE2OptCJxOwUHmDMqbfLLvF44fX3YFCTfhP
        AOsEuVypmCD96iw7lv4xDZw=
X-Google-Smtp-Source: AMrXdXu1y7wrhu8v4ShNof4x6zjjXZT2iGTtyUsMx7I+9W7zX2+dTs+tawjrVWzfoGwAr+9/rG/zPw==
X-Received: by 2002:a05:600c:6006:b0:3db:21b8:5f58 with SMTP id az6-20020a05600c600600b003db21b85f58mr28431843wmb.2.1674745234130;
        Thu, 26 Jan 2023 07:00:34 -0800 (PST)
Received: from localhost.localdomain (93-34-89-61.ip49.fastwebnet.it. [93.34.89.61])
        by smtp.googlemail.com with ESMTPSA id g12-20020a05600c310c00b003db012d49b7sm11353115wmo.2.2023.01.26.07.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 07:00:33 -0800 (PST)
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
Subject: [PATCH v4 1/3] dt-bindings: cpufreq: qcom-cpufreq-nvmem: make cpr bindings optional
Date:   Thu, 26 Jan 2023 16:00:24 +0100
Message-Id: <20230126150026.14590-1-ansuelsmth@gmail.com>
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
Changes v4:
- Explain why required-opp needs to be conditional
- Split additional ref part
Changesv3:
- No change
Changes v2:
- Reword commit description
- Fix condition order
- Add allOf

 .../bindings/cpufreq/qcom-cpufreq-nvmem.yaml  | 62 +++++++++++--------
 1 file changed, 37 insertions(+), 25 deletions(-)

diff --git a/Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml b/Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml
index 9c086eac6ca7..89e99a198281 100644
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
@@ -33,37 +36,46 @@ select:
   required:
     - compatible
 
-properties:
-  cpus:
-    type: object
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,qcs404
 
-    patternProperties:
-      '^cpu@[0-9a-f]+$':
-        type: object
+    then:
+      properties:
+        cpus:
+          type: object
 
-        properties:
-          power-domains:
-            maxItems: 1
+          patternProperties:
+            '^cpu@[0-9a-f]+$':
+              type: object
 
-          power-domain-names:
-            items:
-              - const: cpr
+              properties:
+                power-domains:
+                  maxItems: 1
 
-        required:
-          - power-domains
-          - power-domain-names
+                power-domain-names:
+                  items:
+                    - const: cpr
+
+              required:
+                - power-domains
+                - power-domain-names
 
-patternProperties:
-  '^opp-table(-[a-z0-9]+)?$':
-    if:
-      properties:
-        compatible:
-          const: operating-points-v2-kryo-cpu
-    then:
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

