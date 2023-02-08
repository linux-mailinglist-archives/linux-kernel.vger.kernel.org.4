Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 298F768F22B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 16:39:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231336AbjBHPjm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 10:39:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231588AbjBHPjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 10:39:39 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8449A4615D;
        Wed,  8 Feb 2023 07:39:36 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id f47-20020a05600c492f00b003dc584a7b7eso1759396wmp.3;
        Wed, 08 Feb 2023 07:39:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IZ2CaI/V2FdeNF+FZ2q8IFjrwh7v5x9Z6pVcuoKOE+s=;
        b=EscWcKO9aDv4lw1VYLc1R8eMRNuuaUZo7ShY+3T4Pw+6EbHsYJoiZdLEYBkMThqH/Q
         mbfGF/T6Ma9vy9y2YQBmr1M0xAvjXJSW/pk/04o4TChh1j03LFrPGivnrdD31dJ4T+9M
         em+V5VZNSe4i/opFx/oHCRoIpQkXX4PHQkRe17STrC+p3OpHd7vfFvK0lAv70Mbgh3E1
         7nvOEO7UB0+JCDpvIuLh91gPvZ0Syr36mFo3WUqsLpRnR92fsafTgC/Ffk7YgX5iai2b
         cclnEBdJtIQWwGAP+kict8qT+xTarUVs8f96Lp98lRkouoTjmjRiIEFKKPqHuhfraSTQ
         +5nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IZ2CaI/V2FdeNF+FZ2q8IFjrwh7v5x9Z6pVcuoKOE+s=;
        b=1bLyam4jALhfVhuZkHMxZxXgHtLt+ciGQERyJB6bvk09YudOUcNsMRZ1aqPPG7IWGj
         ICE0gnpwIkSqTaaAsv1+X9brO9UbwOVvDBJUbPZHGJShv7Wawzm9L8ZsvEBMmrCWDzwd
         vazBlgY9FVPuhb4YcEHOGQtOcwUxDP3FTEtG3SZr/3XJZI93YlsW40kTk7N/TinRFpEA
         xnY9L8kuF9nd554mYNlxjzhSF961Ev/oMfoIvQpNGEJTDuj/s093J14oif+N3H0KJo85
         8bIg0KtvS+ZFf5ld1GVTK3Ya/rkzLU0vtgrBD2pRLfSoY7QUOBYO7SacNcfZ8NKnvm3m
         vbxg==
X-Gm-Message-State: AO0yUKUP9oGRey+5mPskPEMppj6i8bzhMOJsbMVFXA+MkSys4y0taZR7
        xyPKbEfeLmV6ieJ9Eul1lME=
X-Google-Smtp-Source: AK7set8qO09YDtSj6g/rsPEetfbuIk6UE1JE0R+tTm2JERmPloHu6672cbPQGMrfz8eZQp1HeBLKZw==
X-Received: by 2002:a05:600c:920:b0:3dc:5390:6499 with SMTP id m32-20020a05600c092000b003dc53906499mr6992838wmp.1.1675870774900;
        Wed, 08 Feb 2023 07:39:34 -0800 (PST)
Received: from localhost.localdomain (93-34-91-73.ip49.fastwebnet.it. [93.34.91.73])
        by smtp.googlemail.com with ESMTPSA id n2-20020a05600c3b8200b003dfe659f9b1sm6755596wms.3.2023.02.08.07.39.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 07:39:34 -0800 (PST)
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
Subject: [PATCH v6 1/3] dt-bindings: cpufreq: qcom-cpufreq-nvmem: specify supported opp tables
Date:   Wed,  8 Feb 2023 16:39:11 +0100
Message-Id: <20230208153913.24436-1-ansuelsmth@gmail.com>
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

Add additional info on what opp tables the defined devices in this schema
supports (operating-points-v2-kryo-cpu and operating-points-v2-qcom-level)
and reference them.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
Changes v6:
- No change
Changes v5:
- Swap patch 1 and patch 2 to fix dt_check_warning on single
  patch bisecting 
Changes v4:
- Add patch split from patch 1

 .../bindings/cpufreq/qcom-cpufreq-nvmem.yaml  | 35 ++++++++++++++-----
 1 file changed, 26 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml b/Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml
index 9c086eac6ca7..7c42d9439abd 100644
--- a/Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml
+++ b/Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml
@@ -55,15 +55,32 @@ properties:
 
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
+              const: operating-points-v2-kryo-cpu
+        then:
+          patternProperties:
+            '^opp-?[0-9]+$':
+              required:
+                - required-opps
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

