Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D93F69DDCD
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 11:26:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233416AbjBUKZ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 05:25:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232682AbjBUKZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 05:25:57 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D2F2234E2;
        Tue, 21 Feb 2023 02:25:56 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id f11so2195400pfe.2;
        Tue, 21 Feb 2023 02:25:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cdo1TKxpnar0eDh6W/ITmg9ZF6u597rrhRp3aGtHgvM=;
        b=c44hfkTeZKC0LorwOQZXu0DwX1hFgI8Z7XtDx2l3FdBVYOBXvZmQqdC13YVhzGosuK
         S+kN8IuAGyMGl4gIkDpu1kAmT74s9l4icI8ANo4OiNq+hVUCA7SSvReaBsKJ/71QvjCJ
         yBTqNAEK0p2EdBTs7TwO81RjY6elrzwwmwU5tiDspeihP9USFbxaP8UUaUN4tetnxlx4
         REZ28F/QyAOatJRVssqWUHK6cBNjIUHV39xb/1OzpNEcxAAFEhdKILFTVxk3t9Aadx1p
         Q3AFtF9TBn/E6sRRPs8Hm3WqNNrRBgLcc/RJHBmkqqrbClaDUlcapXgnDROnAFKp3gf5
         7keA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cdo1TKxpnar0eDh6W/ITmg9ZF6u597rrhRp3aGtHgvM=;
        b=5UR8RNHsFwNZe/bczuq/zXdflwZz9pxb+EwG7zgDAGMeu4EFFy2rTTtHzKgr/NOsJQ
         g8CVf6JpPFizn2GX+eSoUQDqjK4Wqqn+RcAuKUxeQsxSNPmL3Ia6yJm5v2N9JyiF4D3y
         AXQyAs+al25jhkYYpy2lR1toMv46tJZd5U0pMr5qy8ZxUvYW3enb0o3rWOE7SNZthoye
         U3LgszoYr9TEfPiBhWqjM/kulYrbd3Bw1u/Q0lngSHkf3Yd/5DVkIrhOttTTSCBhff0j
         e1Ky8l0HJ3lDdpkpJ7jp8o5c7J4TfnAvKbWTqTABar6rUEcUIJAk5QI/AqmJpQaspOJv
         7qzQ==
X-Gm-Message-State: AO0yUKWafb6WnPHablb0VP1M/qo0cEnTh+hIdQytEEfv4A5C8xqmbnqO
        EIqISXumBgXv+19rb8SaQmS0ZK79+BmpiA==
X-Google-Smtp-Source: AK7set9uUETlDgoDpGfVQo9Kg75+1R/evX0Scz2Xn0VKJv52fGav1qtGcY2C3/0E+BKcQcuUpUMSZA==
X-Received: by 2002:a62:17c6:0:b0:5a8:b6cf:1a74 with SMTP id 189-20020a6217c6000000b005a8b6cf1a74mr4554096pfx.18.1676975155155;
        Tue, 21 Feb 2023 02:25:55 -0800 (PST)
Received: from kelvin-ThinkPad-L14-Gen-1.. (94.130.220.35.bc.googleusercontent.com. [35.220.130.94])
        by smtp.gmail.com with ESMTPSA id t22-20020aa79396000000b00580e3917af7sm7745786pfe.117.2023.02.21.02.25.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 02:25:54 -0800 (PST)
From:   Keguang Zhang <keguang.zhang@gmail.com>
To:     linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Keguang Zhang <keguang.zhang@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3] dt-bindings: interrupt-controller: convert loongson,ls1x-intc.txt to json-schema
Date:   Tue, 21 Feb 2023 18:25:45 +0800
Message-Id: <20230221102545.2103632-1-keguang.zhang@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the Loongson1 interrupt controller dt-bindings to json-schema.

Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
V2 -> V3: Fix the description
V1 -> V2: Drop the description part
---
 .../loongson,ls1x-intc.txt                    | 24 ---------
 .../loongson,ls1x-intc.yaml                   | 51 +++++++++++++++++++
 2 files changed, 51 insertions(+), 24 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/loongson,ls1x-intc.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/loongson,ls1x-intc.yaml

diff --git a/Documentation/devicetree/bindings/interrupt-controller/loongson,ls1x-intc.txt b/Documentation/devicetree/bindings/interrupt-controller/loongson,ls1x-intc.txt
deleted file mode 100644
index a63ed9fcb535..000000000000
--- a/Documentation/devicetree/bindings/interrupt-controller/loongson,ls1x-intc.txt
+++ /dev/null
@@ -1,24 +0,0 @@
-Loongson ls1x Interrupt Controller
-
-Required properties:
-
-- compatible : should be "loongson,ls1x-intc". Valid strings are:
-
-- reg : Specifies base physical address and size of the registers.
-- interrupt-controller : Identifies the node as an interrupt controller
-- #interrupt-cells : Specifies the number of cells needed to encode an
-  interrupt source. The value shall be 2.
-- interrupts : Specifies the CPU interrupt the controller is connected to.
-
-Example:
-
-intc: interrupt-controller@1fd01040 {
-	compatible = "loongson,ls1x-intc";
-	reg = <0x1fd01040 0x18>;
-
-	interrupt-controller;
-	#interrupt-cells = <2>;
-
-	interrupt-parent = <&cpu_intc>;
-	interrupts = <2>;
-};
diff --git a/Documentation/devicetree/bindings/interrupt-controller/loongson,ls1x-intc.yaml b/Documentation/devicetree/bindings/interrupt-controller/loongson,ls1x-intc.yaml
new file mode 100644
index 000000000000..c60125fb1cbf
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/loongson,ls1x-intc.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/loongson,ls1x-intc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Loongson-1 Interrupt Controller
+
+maintainers:
+  - Keguang Zhang <keguang.zhang@gmail.com>
+
+description:
+  Loongson-1 interrupt controller is connected to the MIPS core interrupt
+  controller, which controls several groups of interrupts.
+
+properties:
+  compatible:
+    const: loongson,ls1x-intc
+
+  reg:
+    maxItems: 1
+
+  interrupt-controller: true
+
+  '#interrupt-cells':
+    const: 2
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupt-controller
+  - '#interrupt-cells'
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    intc0: interrupt-controller@1fd01040 {
+        compatible = "loongson,ls1x-intc";
+        reg = <0x1fd01040 0x18>;
+
+        interrupt-controller;
+        #interrupt-cells = <2>;
+
+        interrupt-parent = <&cpu_intc>;
+        interrupts = <2>;
+    };

base-commit: 39459ce717b863556d7d75466fcbd904a6fbbbd8
-- 
2.34.1

