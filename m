Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5E2E6D382C
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 15:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbjDBN4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 09:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjDBN4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 09:56:06 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE6EB9ED0;
        Sun,  2 Apr 2023 06:56:04 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id t10so107328136edd.12;
        Sun, 02 Apr 2023 06:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680443763;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fjf6bGXfCGtw1GBhD6mA8LYND1B2VUNBKMqAY73qJpg=;
        b=DWwYhDXRq06e6xUZlJSb3L79IGw9284KnRGOv5rQNXLBk4zV/gAkT47OCVqs/28rgE
         nqzACeJLaILlkssk9f/FrgD/fKmuSlOxDcHWqniSaF5eM1z/u1II8PuW3opqtnZyQq/d
         DHbX6Mgh9433tuRIz9l2jeUxxy2eAKPqJ+LV7kqQuZs1kHoGGh0cj1spt3PxXCjyCFRq
         3J6qGssaXuOPt3M401lj1+ilj1k0d6C+zV4cqhTbttL9sONdMAHPVM8k+f7BtvWTn+r8
         Vfb1xZkvfGTKu5aUIvP+RvmoBwgKvEHlzgNACtnJphOoR8Usgt/75jd77nBuH5zcfNbs
         EQpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680443763;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fjf6bGXfCGtw1GBhD6mA8LYND1B2VUNBKMqAY73qJpg=;
        b=IBk/i+8nKUdQ3DvwsOZHjroBc8eb4Ygs8HnSz+3xv3Nk8d8OW8AWJufDDHst6pEUAs
         QPplm0arHik02H+L2HnTOB3hVFeZ5cqKs7VVHbwS+Q2NbpBS5cMPEqn72jWPQjSJoVu8
         10YsYK8kxAXonphlTjH99aOhDV3pPe2OSWzcMutJOoEUS/ZdCrmmwz8b2aNgiFEhF9LM
         cHXFKqO3myvcIwcvNwFhfcmLsLr7q914ExJTjLVYSMZm0YWUV4uCPXDpB/WWIBiIsc4v
         eqAi/zX15LRgajnyvaxB8s1iAnqBBVM7KbZP9KoQ+vGZKhw29sW7oJJrb7o26W5tMax9
         Z0/A==
X-Gm-Message-State: AAQBX9fNHH5WUdHj4rWFq9XLrOZArFL3Ni2pbvQtB5EyN6qSk2BqZJ2p
        obyYotowuX0fe7BsE2SP/34=
X-Google-Smtp-Source: AKy350YHTd19GvIKiUIBvMbpofhO2HvoDSBZHULzst9eKdZbPLjOWCXpfLklvh7BZCi4UZUHOhlhxw==
X-Received: by 2002:a17:906:ad9:b0:930:8714:6739 with SMTP id z25-20020a1709060ad900b0093087146739mr30762837ejf.30.1680443763130;
        Sun, 02 Apr 2023 06:56:03 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8109:8c00:3b40:6e94:3cde:dfbe:3d7b])
        by smtp.gmail.com with ESMTPSA id h13-20020a1709063c0d00b008b176df2899sm3241853ejg.160.2023.04.02.06.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Apr 2023 06:55:59 -0700 (PDT)
From:   Nikita Bondarenko <n2h9z4@gmail.com>
To:     wim@linux-watchdog.org, linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, f.fainelli@gmail.com,
        rjui@broadcom.com, sbranden@broadcom.com
Cc:     Nikita Bondarenko <n2h9z4@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] dt-bindings: watchdog: brcm,kona-wdt: convert txt file to yaml
Date:   Sun,  2 Apr 2023 15:55:55 +0200
Message-Id: <20230402135555.62507-1-n2h9z4@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove device tree binding in txt
Add device tree binding in json-schema


Signed-off-by: Nikita Bondarenko <n2h9z4@gmail.com>
---

Changes in v2, according to review comments:
- use subject prefixes matching the subsystem in patch subject
- add commit message
- update the list of maintainers: add here all maintainers returned by scripts/get_maintainer.p who are marked as "maintainer:BROADCOM BCM281XX/BCM11XXX/BCM216XX"
- remove quotes in - $ref: watchdog.yaml#
- remove description for reg
- leave one example
- add all SoCs mentioned in txt file description to compatible enum values 

Both checks (dtbs_check, dt_binding_check) return no error:

make  DT_SCHEMA_FILES=Documentation/devicetree/bindings/watchdog/brcm,kona-wdt.yaml ARCH=arm dtbs_check
  LINT    Documentation/devicetree/bindings
  CHKDT   Documentation/devicetree/bindings/processed-schema.json
  SCHEMA  Documentation/devicetree/bindings/processed-schema.json

make  DT_SCHEMA_FILES=Documentation/devicetree/bindings/watchdog/brcm,kona-wdt.yaml ARCH=arm dt_binding_check
  LINT    Documentation/devicetree/bindings
  CHKDT   Documentation/devicetree/bindings/processed-schema.json
  SCHEMA  Documentation/devicetree/bindings/processed-schema.json
  DTEX    Documentation/devicetree/bindings/watchdog/brcm,kona-wdt.example.dts
  DTC_CHK Documentation/devicetree/bindings/watchdog/brcm,kona-wdt.example.dtb

 .../bindings/watchdog/brcm,kona-wdt.txt       | 15 -------
 .../bindings/watchdog/brcm,kona-wdt.yaml      | 45 +++++++++++++++++++
 2 files changed, 45 insertions(+), 15 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/watchdog/brcm,kona-wdt.txt
 create mode 100644 Documentation/devicetree/bindings/watchdog/brcm,kona-wdt.yaml

diff --git a/Documentation/devicetree/bindings/watchdog/brcm,kona-wdt.txt b/Documentation/devicetree/bindings/watchdog/brcm,kona-wdt.txt
deleted file mode 100644
index 2b86a00e351d..000000000000
--- a/Documentation/devicetree/bindings/watchdog/brcm,kona-wdt.txt
+++ /dev/null
@@ -1,15 +0,0 @@
-Broadcom Kona Family Watchdog Timer
------------------------------------
-
-This watchdog timer is used in the following Broadcom SoCs:
-  BCM11130, BCM11140, BCM11351, BCM28145, BCM28155
-
-Required properties:
-  - compatible = "brcm,bcm11351-wdt", "brcm,kona-wdt";
-  - reg: memory address & range
-
-Example:
-	watchdog@35002f40 {
-		compatible = "brcm,bcm11351-wdt", "brcm,kona-wdt";
-		reg = <0x35002f40 0x6c>;
-	};
diff --git a/Documentation/devicetree/bindings/watchdog/brcm,kona-wdt.yaml b/Documentation/devicetree/bindings/watchdog/brcm,kona-wdt.yaml
new file mode 100644
index 000000000000..c7627c00556a
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/brcm,kona-wdt.yaml
@@ -0,0 +1,45 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/watchdog/brcm,kona-wdt.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Broadcom Kona Family Watchdog Timer
+
+description: |
+  This watchdog timer is used in the following Broadcom SoCs:
+  BCM11130, BCM11140, BCM11351, BCM28145, BCM28155
+
+maintainers:
+  - Florian Fainelli <f.fainelli@gmail.com>
+  - Ray Jui <rjui@broadcom.com>
+  - Scott Branden <sbranden@broadcom.com>
+
+allOf:
+  - $ref: watchdog.yaml#
+
+properties:
+  compatible:
+    enum:
+      - brcm,bcm11130-wdt
+      - brcm,bcm11140-wdt
+      - brcm,bcm11351-wdt
+      - brcm,bcm28145-wdt
+      - brcm,bcm28155-wdt
+      - brcm,kona-wdt
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    watchdog@35002f40 {
+      compatible = "brcm,bcm11130-wdt";
+      reg = <0x35002f40 0x6c>;
+    };
-- 
2.34.1

