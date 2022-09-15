Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D80E05B91AA
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 02:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbiIOAcs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 20:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbiIOAcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 20:32:39 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0633289924
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 17:32:34 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id fs14so16152196pjb.5
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 17:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=DtKceXLd5OaqYfgcv/swRBpRQ2sHIjDy1GhsRswCTPw=;
        b=F5kg1JwB7jNh0UV97uix8atJ6JxclLKrLtefnlzIlX/Qs01ULS1l0U04EgppuF0WiU
         E/FwCo09vVjDEU34SiW5WGCMGRBGWea7l+61QwM7ylHyeF3vUcOrBsj0cSTvDx93r9oh
         QjWiMOWbfUpXu5ty85aXkrUd5VtVsODn4Dcxs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=DtKceXLd5OaqYfgcv/swRBpRQ2sHIjDy1GhsRswCTPw=;
        b=hPkosVAho0sykeW+jtQBfVClx7jiG/h6Efyx+AlXYWNkE6BPEePBkTFeCL41zHsXVY
         1HSQeIEXFHygK8Rn36dPfc/G3QS47B7DqTZ/0geK2FLbr/WjWk90oiz+ACtOnqukBXhS
         S8Ki4njToa6C6Ih4tA+TAs2ltz0U0qa12yAsUDCMnXZwGtFJdGsRyxYbZEt1RvdyoJ4Y
         Pq0XAxQ4fHUETLMz5SVtrAiPV+rR2MF29+f8QETGJOKHpfKTjhfVRJWpQ0TPE5K7X3Kn
         qx/h6R5XBIOaWdvQPRs/ZBXCU0W2hHNFeTejj4P195/HRC/eUjibnFFkXLngbhqD9TKx
         dP9g==
X-Gm-Message-State: ACrzQf1PDnZZheC4us0RSr61sZc7Czp6XDzmIwcVoJaCVBQo4GyhXLio
        l0VRcO/uYnqvQO1gJiVUf1WQWNWj/kWxVQ==
X-Google-Smtp-Source: AMsMyM5oo1yTag2CiC8BS8G1wL5EWM/6BEyKoB/ei94ygUM9iit32S55ygriKJFwGdDp5uIescmj/g==
X-Received: by 2002:a17:903:2347:b0:178:1046:929e with SMTP id c7-20020a170903234700b001781046929emr1665692plh.110.1663201954226;
        Wed, 14 Sep 2022 17:32:34 -0700 (PDT)
Received: from jwerner-p920.mtv.corp.google.com ([2620:15c:202:201:347e:2a81:558b:d912])
        by smtp.gmail.com with ESMTPSA id 199-20020a6214d0000000b0053e22c7f135sm10991202pfu.141.2022.09.14.17.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 17:32:33 -0700 (PDT)
From:   Julius Werner <jwerner@chromium.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Dmitry Osipenko <digetx@gmail.com>,
        Doug Anderson <dianders@chromium.org>,
        Jian-Jia Su <jjsu@google.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Julius Werner <jwerner@chromium.org>
Subject: [PATCH 3/4 v4] dt-bindings: memory: Add jedec,lpddr4 and jedec,lpddr5 bindings
Date:   Wed, 14 Sep 2022 17:32:21 -0700
Message-Id: <20220915003222.1296421-3-jwerner@chromium.org>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
In-Reply-To: <20220915003222.1296421-1-jwerner@chromium.org>
References: <20220915003222.1296421-1-jwerner@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds bindings for LPDDR4 and LPDDR5 memory analogous to the
existing bindings for LPDDR2 and LPDDR3. For now, the new types are only
needed for topology description, so other properties like timing
parameters are omitted. They can be added later if needed.

Signed-off-by: Julius Werner <jwerner@chromium.org>
---
 .../ddr/jedec,lpddr-props.yaml                |  4 ++
 .../memory-controllers/ddr/jedec,lpddr4.yaml  | 35 ++++++++++++++
 .../memory-controllers/ddr/jedec,lpddr5.yaml  | 46 +++++++++++++++++++
 3 files changed, 85 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr4.yaml
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr5.yaml

Changelog:

- v2
  - removed minItems
  - moved `$ref` below `maintainers`
  - renamed example node from `lpddr4` to `lpddr`
- v3
  - removed manufacturer-id property from examples
- v4
  - removed quotes from schema $ref strings

diff --git a/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr-props.yaml b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr-props.yaml
index 4114cfa8de67f1..92ef660888f318 100644
--- a/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr-props.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr-props.yaml
@@ -45,9 +45,13 @@ properties:
       - 512
       - 1024
       - 2048
+      - 3072
       - 4096
+      - 6144
       - 8192
+      - 12288
       - 16384
+      - 24576
       - 32768
 
   io-width:
diff --git a/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr4.yaml b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr4.yaml
new file mode 100644
index 00000000000000..a078892fecee36
--- /dev/null
+++ b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr4.yaml
@@ -0,0 +1,35 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/memory-controllers/ddr/jedec,lpddr4.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: LPDDR4 SDRAM compliant to JEDEC JESD209-4
+
+maintainers:
+  - Krzysztof Kozlowski <krzk@kernel.org>
+
+allOf:
+  - $ref: jedec,lpddr-props.yaml#
+
+properties:
+  compatible:
+    items:
+      - pattern: "^lpddr4-[0-9a-f]{2},[0-9a-f]{4}$"
+      - const: jedec,lpddr4
+
+required:
+  - compatible
+  - density
+  - io-width
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    lpddr {
+        compatible = "lpddr4-ff,0100", "jedec,lpddr4";
+        density = <8192>;
+        io-width = <16>;
+        revision-id = <1 0>;
+    };
diff --git a/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr5.yaml b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr5.yaml
new file mode 100644
index 00000000000000..e441dac5f15445
--- /dev/null
+++ b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr5.yaml
@@ -0,0 +1,46 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/memory-controllers/ddr/jedec,lpddr5.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: LPDDR5 SDRAM compliant to JEDEC JESD209-5
+
+maintainers:
+  - Krzysztof Kozlowski <krzk@kernel.org>
+
+allOf:
+  - $ref: jedec,lpddr-props.yaml#
+
+properties:
+  compatible:
+    items:
+      - pattern: "^lpddr5-[0-9a-f]{2},[0-9a-f]{4}$"
+      - const: jedec,lpddr5
+
+  serial-id:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description:
+      Serial IDs read from Mode Registers 47 through 54. One byte per uint32
+      cell (i.e. <MR47 MR48 MR49 MR50 MR51 MR52 MR53 MR54>).
+    maxItems: 8
+    items:
+      minimum: 0
+      maximum: 255
+
+required:
+  - compatible
+  - density
+  - io-width
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    lpddr {
+        compatible = "lpddr5-01,0200", "jedec,lpddr5";
+        density = <8192>;
+        io-width = <8>;
+        revision-id = <2 0>;
+        serial-id = <3 1 0 0 0 0 0 0>;
+    };
-- 
2.31.0

