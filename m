Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F166368F231
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 16:39:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231787AbjBHPjq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 10:39:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231727AbjBHPjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 10:39:41 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9606248A26;
        Wed,  8 Feb 2023 07:39:37 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id bg26so13629627wmb.0;
        Wed, 08 Feb 2023 07:39:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HFW09DSWE151zjBNnB3HWCYqZY622+jBm6O+Jc9cnLw=;
        b=fhKRU/ws5vwOeH79D5Lma45fwrgAt7s1bP30GX5RUop3wYvlCJXl0c8gk74U2u4IZc
         +NMCNVSr2HPCjjNalcUvvQGI/aQhmP0mhU44vEeq9XogiGx/KGGNVtRdTKTynY/YdJnU
         v4C2Bo+5R1w11KaMVGEamNMpZLUW7Z1PRw4kDxnZYxgXXe7Ze9bDwJj7wtT8X8EqmhjP
         ycNq7ywfYgJjVPyik909QmQmZpoSlv6ZMO2h8BvM7SHHBGa4yaJCGq9A2BJawY1c1b1G
         rI18YeDIavR7n+zp9QKXO3D3y1lPWHT6Xp/RFIjR/DENhskDhDmVEFKInFsewIde7HC6
         sUgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HFW09DSWE151zjBNnB3HWCYqZY622+jBm6O+Jc9cnLw=;
        b=fGJCJBrqpSzLEPTgfWuFpF8jj0jII97/5V3Qp2OkeJkmYpqfJxCDpjZFtGzA3vvXT2
         ERPVoTLpajqy+ubPV5ZVS2lUYhBWPA/r6cAT47swUHZa7VBtwsW7xvlHbR7Xdz341Yfx
         HnBKMvclT+DveiEWGXdxjqwynJOGw9LhfJZ1qZsxZPLzDDn1wf6IZ1zfVTj4G5psykWO
         MZO2tSHbs3pKrt0AhFiCDW2R8w1OFYVdEuvadh7oSyMUp22rCe9sPRyTQAV7yxp0c5j9
         Elum0/Vr3emaHNnPBpTvNioOzqWoHKOWfGQr5kZZh4OyP1ICnJJJt1P3I/7UrX8RofZ0
         sDrg==
X-Gm-Message-State: AO0yUKUh/wla0oc6PEF14+2SrSfqIKlJ3wzdRfOz+iiXrxcw68bqkcXo
        wOyQydi9xfe8UrKM6v7kC3c=
X-Google-Smtp-Source: AK7set96rabuGY8uMwxhEXRUcmw7/0nZVzyGhNGMxmTgmsTUsR8WLekTdbtlb1CdIQC4idOKMtXDRg==
X-Received: by 2002:a05:600c:3417:b0:3dc:5b79:2dbb with SMTP id y23-20020a05600c341700b003dc5b792dbbmr6887685wmp.25.1675870775954;
        Wed, 08 Feb 2023 07:39:35 -0800 (PST)
Received: from localhost.localdomain (93-34-91-73.ip49.fastwebnet.it. [93.34.91.73])
        by smtp.googlemail.com with ESMTPSA id n2-20020a05600c3b8200b003dfe659f9b1sm6755596wms.3.2023.02.08.07.39.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 07:39:35 -0800 (PST)
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
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH v6 2/3] dt-bindings: cpufreq: qcom-cpufreq-nvmem: make cpr bindings optional
Date:   Wed,  8 Feb 2023 16:39:12 +0100
Message-Id: <20230208153913.24436-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230208153913.24436-1-ansuelsmth@gmail.com>
References: <20230208153913.24436-1-ansuelsmth@gmail.com>
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

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
Changes v6:
- Drop Fixes tag (can't be backported due to prereq changes required)
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

