Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4733E5E8443
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 22:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232798AbiIWUmZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 16:42:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233213AbiIWUmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 16:42:04 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57B63153ED5
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 13:36:37 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id c7so1260590ljm.12
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 13:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=KoW18gfscBQcQUXjtlxACzOxZxKFFsSFNG1iDxVv0fY=;
        b=pS8XJfqzelQCdvzS1E9w49f9BAuXPH4IFj2tGe55LfT5QkwIpfe3WA1zjRs4j4/TEv
         +gk9k+QIIaFgEvoyEnaIPxjcQfLKRJvHutADsOmimJRPX1X1a4l9BvorRl61gaa+mYuA
         szisxwZ1PRBzjCUdf14nTpXrOGjIGhuCL4gBBld+i70nyL69CAoqlo+ZX+LIIjNw8o1+
         xj8fyphG9FV+Bs6/3GZjqZcz+kHcFPvNyzWN3fqMsI9idPnB6yts+B4hp3R5CEyjhHzj
         xHJ89wcRWePuQPb1NtGHHfY9aOFYCFmfky81CSHEW5Bve+hhwW1A0lqohA8al7tx8IMb
         bbbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=KoW18gfscBQcQUXjtlxACzOxZxKFFsSFNG1iDxVv0fY=;
        b=HE2d/m0gRRT7VxxgdKija7c/mp6p6XY/7YFhdFKgjPwqRNSCaSFiSvaX9OO/4NBLRG
         Xue1b8PRY4ei52ZcSnkj5KlKSeRt8u98RBbbs8XzwCbOx+vwE4mpe0SkHa5E3oNvq0BS
         lpy+hpkuH0ZYxBA4eE+zHEl3IHMyqcL5PX5BH/sGCduEZC6wzOfTYrFMZvFevZ/2hiOC
         c+afDysi1t9H7bqR81d2L2MO5SNupmbT3OPl8epEMN14v0JHXuDlD6zfxCo4EhBgOyY9
         icEbm+UhwCTc4Ojo8uMSH7wO0VAxOxoZrshAUtddg38DpCVb5AEJOGHOGdtW5AykWxLJ
         vhrA==
X-Gm-Message-State: ACrzQf14KKA75SEPp1jTS6YGvd4ywWepLSdDIeKyE+1y7Cpfelg+RWuX
        f49X/80VMdOFyB8bBz2Wz4JH2A==
X-Google-Smtp-Source: AMsMyM7GhWlynnQdutL3KMj7KJU7muxHjPCQgkEQscantEEdFOBqQQQul7FOp5bGs7CUT261VsbgMw==
X-Received: by 2002:a05:651c:1548:b0:26c:61b3:7129 with SMTP id y8-20020a05651c154800b0026c61b37129mr3306128ljp.381.1663965365155;
        Fri, 23 Sep 2022 13:36:05 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id f9-20020a05651201c900b0048af397c827sm1584099lfp.218.2022.09.23.13.36.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 13:36:04 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2] dt-bindings: power: reset: restart-handler: add common schema
Date:   Fri, 23 Sep 2022 22:36:03 +0200
Message-Id: <20220923203603.515714-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add common schema for restart and shutdown handlers, so they all use
same meaning of "priority" field.  The Linux drivers already have this
property and some systems want to customize it per-board in DTS.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes since v1:
1. Use double ':'

v1 was marked as changes-requested in Rob's patchwork, but I think there
was not actual consensus on any other changes to make.

v1:
https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20220907123630.57383-1-krzysztof.kozlowski@linaro.org/

See also:
https://lore.kernel.org/all/8fe93da3-f768-16ae-7025-1cfa97a42b27@linaro.org/
https://lore.kernel.org/all/20220831081715.14673-1-pali@kernel.org/
---
 .../bindings/power/reset/gpio-restart.yaml    | 13 ++------
 .../bindings/power/reset/restart-handler.yaml | 30 +++++++++++++++++++
 2 files changed, 33 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/reset/restart-handler.yaml

diff --git a/Documentation/devicetree/bindings/power/reset/gpio-restart.yaml b/Documentation/devicetree/bindings/power/reset/gpio-restart.yaml
index a72d5c721516..d3d18e0f5db3 100644
--- a/Documentation/devicetree/bindings/power/reset/gpio-restart.yaml
+++ b/Documentation/devicetree/bindings/power/reset/gpio-restart.yaml
@@ -25,6 +25,9 @@ description: >
   inactive-delay, the GPIO is driven active again.  After a delay specified by wait-delay, the
   restart handler completes allowing other restart handlers to be attempted.
 
+allOf:
+  - $ref: restart-handler.yaml#
+
 properties:
   compatible:
     const: gpio-restart
@@ -41,16 +44,6 @@ properties:
       in its inactive state.
 
   priority:
-    $ref: /schemas/types.yaml#/definitions/uint32
-    description: |
-      A priority ranging from 0 to 255 (default 129) according to the following guidelines:
-
-        0:   Restart handler of last resort, with limited restart capabilities.
-        128: Default restart handler; use if no other restart handler is expected to be available,
-             and/or if restart functionality is sufficient to restart the entire system.
-        255: Highest priority restart handler, will preempt all other restart handlers.
-    minimum: 0
-    maximum: 255
     default: 129
 
   active-delay:
diff --git a/Documentation/devicetree/bindings/power/reset/restart-handler.yaml b/Documentation/devicetree/bindings/power/reset/restart-handler.yaml
new file mode 100644
index 000000000000..1f9a2aac53c0
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/reset/restart-handler.yaml
@@ -0,0 +1,30 @@
+# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/reset/restart-handler.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Restart and shutdown handler generic binding
+
+maintainers:
+  - Sebastian Reichel <sre@kernel.org>
+
+description:
+  Restart and shutdown handler device is responsible for powering off the
+  system, e.g. my cutting off the power.  System might have several restart
+  handlers, which usually are tried from most precise to last resort.
+
+properties:
+  priority:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      A priority ranging from 0 to 255 according to the following guidelines::
+        0::   Restart handler of last resort, with limited restart capabilities.
+        128:: Typical, default restart handler; use if no other restart handler
+              is expected to be available, and/or if restart functionality is
+              sufficient to restart the entire system.
+        255:: Highest priority restart handler, will preempt all other restart handlers.
+    minimum: 0
+    maximum: 255
+
+additionalProperties: true
-- 
2.34.1

