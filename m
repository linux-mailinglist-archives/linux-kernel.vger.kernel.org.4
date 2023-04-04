Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF5D96D5828
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 07:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233403AbjDDFrO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 01:47:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233392AbjDDFrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 01:47:04 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4754C2114;
        Mon,  3 Apr 2023 22:46:54 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id x15so29444405pjk.2;
        Mon, 03 Apr 2023 22:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680587213;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W+/0LPIj3HM2hNCFq+jgpW1KVyITP1DwvC67zTe2p2w=;
        b=FApummjK53fz6CzEbSo4UuyG/zoVv6TAWrxUk0DM81aCtq/nx3BqUNMwBnHYnoVYaw
         HCRCuU+b348mIWIGJ/9/8b4MmoBjO4Q/NWE0e+dEzJD3EZMMD8WyAOSuk88Mx79bGja6
         gBEKf3rbUxOV5nwv0I3lqL/xCoYwfz4PeDT/LtPZwxQq0I/e73cJVvitDMm3LVCBimTR
         t3PdR70B/7XyEczC3I7xLj0Hzq75xaN/L5R6580D0bXNh+0PhxQLgnFN01t5fS7gDPxz
         PcFgOz3TLwac2mDCFYgDwWKFormcCIkkv3ngBNJ2B/lPp61Vw2UOQRZlbkbuCtzb//18
         7rVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680587213;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W+/0LPIj3HM2hNCFq+jgpW1KVyITP1DwvC67zTe2p2w=;
        b=P3S3I6I1Pt5r027sbj+QpP0dtgl64j9oiHglDsuSlbsRgiuw7TrWNAG1rsaxGCda8D
         gUkfzNvk7w1tKyn+9kycGWV9vUachTAcsFD2orTwmsQCpKwtQB+W+CqWLB9lLWXS1B27
         Iz0SB434Df+2hGqi5gpRkZmRmkDwsEg4RWjvefZ2enQzZ3p6P/K524ykDKK6yVTAk1U8
         3QdkhCgKXXP/iUunfh/WvKfawE69kgzdAWUdAbI5j/Re5EzuPkzZo0ualFZjA9Gck5no
         GrJAB2rcEbmrdVUCDXpMnQkg6SSgge++Y0TMCsVk9/WriTeDSpgz+AMLk2AyiE5S2XiC
         e0aw==
X-Gm-Message-State: AAQBX9fANkh1Plj0OPlo38SgXsxjvsxpxN+eAZwzDC4xcIeGOQ8p9fqL
        fCk2HMiSZwdLd9s4Gpesncw=
X-Google-Smtp-Source: AKy350YECH2zBFNTc5RSj05HDIG6b1IsIC/IFCZ19pm+vgoIH37k+pOfeALbNo8FYRiO3BKn3hW6/A==
X-Received: by 2002:a17:90b:1a86:b0:23f:7c82:2463 with SMTP id ng6-20020a17090b1a8600b0023f7c822463mr1802247pjb.9.1680587213662;
        Mon, 03 Apr 2023 22:46:53 -0700 (PDT)
Received: from otabekn-virtual-machine.localdomain ([211.169.38.26])
        by smtp.gmail.com with ESMTPSA id u3-20020a17090abb0300b0023371cb020csm10600524pjr.34.2023.04.03.22.46.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 22:46:53 -0700 (PDT)
From:   Otabek Nazrullaev <otabeknazrullaev1998@gmail.com>
Cc:     Otabek Nazrullaev <otabeknazrullaev1998@gmail.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] watchdog: dt-bindings: atmel-at91rm9200-wdt convert to json-schema
Date:   Tue,  4 Apr 2023 14:46:40 +0900
Message-Id: <20230404054642.5691-1-otabeknazrullaev1998@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert atmel AT91RM9200 system timer watchdog from text bindings
to YAML format

Signed-off-by: Otabek Nazrullaev <otabeknazrullaev1998@gmail.com>
---
 .../watchdog/atmel-at91rm9200-wdt.txt         |  9 ------
 .../watchdog/atmel-at91rm9200-wdt.yaml        | 28 +++++++++++++++++++
 2 files changed, 28 insertions(+), 9 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/watchdog/atmel-at91rm9200-wdt.txt
 create mode 100644 Documentation/devicetree/bindings/watchdog/atmel-at91rm9200-wdt.yaml

diff --git a/Documentation/devicetree/bindings/watchdog/atmel-at91rm9200-wdt.txt b/Documentation/devicetree/bindings/watchdog/atmel-at91rm9200-wdt.txt
deleted file mode 100644
index d4d86cf8f9eb..000000000000
--- a/Documentation/devicetree/bindings/watchdog/atmel-at91rm9200-wdt.txt
+++ /dev/null
@@ -1,9 +0,0 @@
-Atmel AT91RM9200 System Timer Watchdog
-
-Required properties:
-- compatible: must be "atmel,at91sam9260-wdt".
-
-Example:
-	watchdog@fffffd00 {
-		compatible = "atmel,at91rm9200-wdt";
-	};
diff --git a/Documentation/devicetree/bindings/watchdog/atmel-at91rm9200-wdt.yaml b/Documentation/devicetree/bindings/watchdog/atmel-at91rm9200-wdt.yaml
new file mode 100644
index 000000000000..e9e14fabe0fb
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/atmel-at91rm9200-wdt.yaml
@@ -0,0 +1,28 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/watchdog/atmel-at91rm9200-wdt.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+maintainers:
+  - Otabek Nazrullaev <otabeknazrullaev1998@gmail.com>
+
+title: Atmel AT91RM9200 System Timer Watchdog
+
+allOf:
+  - $ref: "watchdog.yaml#"
+
+properties:
+  compatible:
+    const: atmel,at91sam9260-wdt
+
+required:
+  - compatible
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    watchdog@fffffd00 {
+      compatible = "atmel,at91rm9200-wdt";
+    };
-- 
2.34.1

