Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CA58683149
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 16:21:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233217AbjAaPVC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 10:21:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbjAaPUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 10:20:36 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5DAE5866F;
        Tue, 31 Jan 2023 07:18:32 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id c4-20020a1c3504000000b003d9e2f72093so12708689wma.1;
        Tue, 31 Jan 2023 07:18:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bBwrI8hKmSv5gQ7N7D3hIfQL3dVj+xe6qEN98lCdCy0=;
        b=KUvk6pa+U6ArxTo3fM5DG3JpjKo5Mparu+2/mk+iCDI/peBaxA3PK9rAFfvRCUXu57
         kS6KKtIfsB5+4KDeLjxkUqzowUynUK6Bggov5so9huUjuB8vxtXaylHXdP9YeSHzt7tx
         9Rmk6bn88UuIjtj63z/UaEyg0XCx7lxEYHS64Ulhv8bqk2KhIYBGAOYBYowTAlPDYEiu
         OQ53w+e3VH2C0NOAQmDH15haFVFBqsOU+BmdaIq3ZG4PItdg7kzy+QpQt1H+WoWwsfle
         Brbx9uW1Z2/pjU1oX93aoRVkElmYBJaqeWPOd3wUAVTHJCZQ72d3FtbyROAH+yDL3voH
         4Big==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bBwrI8hKmSv5gQ7N7D3hIfQL3dVj+xe6qEN98lCdCy0=;
        b=UgpC9zeGEF/tKv+TCTCXPEfW8sVqz/OpWCjdkZiSKDXcWMjBkH8C1VVjpanVWufFxR
         qibvClZNhWtXUdTdEZize5quw0riwKBPRMcRqAV+l5EKKjTi4jkAEdSwrvVszRE+p5bF
         lpfnhOFLzA8bogdQUHz0wFxfMDQPcTiaB0MUE7RsYPHn1FjglVpNlzIHpmoeHyj4VI39
         c6z5koFvnguBFNeNToUdedghyRJ5vJx2AjrdzS6XGlYpIwvh+jv5P+Qs97yobj9IDQmo
         QXgUUPr66w+qibf7Ha3utZLC1zlvXXiqIeuZ+n5aQDc4TT21cw82Z2QG6AshgFd6Zx8I
         5luw==
X-Gm-Message-State: AO0yUKXRqMLnkVoKWXmNFWL+AWWftVRCHeBz1bbjAFVS3TL8QVovHLOZ
        toibGtwrFVBc0tSld4MFVlhDKziyvtk=
X-Google-Smtp-Source: AK7set+VVu+M+aULp66owrhILnZtcngXHdXkQ2pADm4UZQdos1fjvbwnPnM2kpyojLmxxTWfqCzXpg==
X-Received: by 2002:a05:600c:3492:b0:3dc:de85:5007 with SMTP id a18-20020a05600c349200b003dcde855007mr5985854wmq.21.1675178311223;
        Tue, 31 Jan 2023 07:18:31 -0800 (PST)
Received: from localhost.localdomain (93-34-88-241.ip49.fastwebnet.it. [93.34.88.241])
        by smtp.googlemail.com with ESMTPSA id x9-20020a05600c21c900b003dc434b39c7sm2854861wmj.0.2023.01.31.07.18.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 07:18:30 -0800 (PST)
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
Subject: [PATCH v5 1/3] dt-bindings: cpufreq: qcom-cpufreq-nvmem: specify supported opp tables
Date:   Tue, 31 Jan 2023 16:18:17 +0100
Message-Id: <20230131151819.16612-1-ansuelsmth@gmail.com>
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

