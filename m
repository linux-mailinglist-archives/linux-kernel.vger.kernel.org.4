Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F2A071351C
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 16:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232187AbjE0OMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 10:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbjE0OM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 10:12:28 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAEE8E1;
        Sat, 27 May 2023 07:12:26 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3f6dfc4e01fso18499375e9.0;
        Sat, 27 May 2023 07:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685196745; x=1687788745;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y73LttJXgXAmHhQ5741s9WbrUG10KAIdhEW2zXBoOQc=;
        b=SSaPjwvbMG4ZCo291BUkrxKdVuhVg+Wj6kvou/lqhMCj3nP/54QbnaMb7OxpDeo3NU
         ZoJexsI4K3GBGylrGpIQVv+olEPNxqSZvAl/b6h0/svnjQnDyEjQ2VhYtdtgcqmsWa/N
         7bZDcgMlWxoRtRx0Azs4enYz9xTFKuIVDGWGbKp8EMp88hF+L9kGNe9btYiJyHdhQxLP
         k82dUONAIov4yY1o6SzIHbtCgk3k4X9D6HthCiM+WBAAqcd6d2k2TjYOeIlhOY63Iqbz
         69YYGV5/mNgE1IPWDNsnN6p4wiqkJBDFydqaWtVm/nznxcZpMXgWeV/sop3xNdxKsiS8
         /GNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685196745; x=1687788745;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y73LttJXgXAmHhQ5741s9WbrUG10KAIdhEW2zXBoOQc=;
        b=h5fxcQAO/PggCUAcFCrrAZGbr6qXzcO30HNkMCZ7q7ROXkm0gvRVEOyv4C+kykGuCe
         xFrpLRHRMQG95MUTw4HH+i1ER/ukPPF1wGtSeUJ1sxnaBL8Kpdky/9fjrqDNu8ojFtio
         Chalqc9uLTlQIGL28/0XOb0ZzN+iiuC9EsFwpQu9YO3g5p1GxS73ynLdwX783Uk7zD3m
         TGbJMQ6mvMWpkspS19ZdiFU8H8gNyB6bOJKcEp8sEcBWcJumYLpyFTG9uibF+HhgbVFf
         ehqgdRrYEjvEg3zxFbv1zhABuQFtVxGC8OvDKZ/ghV+bk2pd1hVL34efDHJ4Kaiz/5GF
         jtSw==
X-Gm-Message-State: AC+VfDyM8c6jKibhIi/zWQn+26BVhvMWzHFKKnoHmdfYOKylnoOG8KZn
        LB3rKKbpzOgCJu/enCq7Y2E=
X-Google-Smtp-Source: ACHHUZ7iYd9QDeDJnyOgG5uAS9aZak2X8ynHR3qkQl+oqxSFLYVzUSO3mpKQZEUnoaSQrFv9DvxE0Q==
X-Received: by 2002:a1c:7415:0:b0:3f6:89e:2716 with SMTP id p21-20020a1c7415000000b003f6089e2716mr4510310wmc.33.1685196744886;
        Sat, 27 May 2023 07:12:24 -0700 (PDT)
Received: from standask-GA-A55M-S2HP ([188.123.113.247])
        by smtp.gmail.com with ESMTPSA id q21-20020a1ce915000000b003f421979398sm12015239wmc.26.2023.05.27.07.12.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 May 2023 07:12:24 -0700 (PDT)
Date:   Sat, 27 May 2023 16:12:22 +0200
From:   Stanislav Jakubek <stano.jakubek@gmail.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: power: reset: bcm21664-resetmgr: convert to YAML
Message-ID: <20230527141222.GA5048@standask-GA-A55M-S2HP>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert Broadcom Kona family reset manager bindings to DT schema.

Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
---
 .../power/reset/brcm,bcm21664-resetmgr.txt    | 14 ---------
 .../power/reset/brcm,bcm21664-resetmgr.yaml   | 31 +++++++++++++++++++
 2 files changed, 31 insertions(+), 14 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/power/reset/brcm,bcm21664-resetmgr.txt
 create mode 100644 Documentation/devicetree/bindings/power/reset/brcm,bcm21664-resetmgr.yaml

diff --git a/Documentation/devicetree/bindings/power/reset/brcm,bcm21664-resetmgr.txt b/Documentation/devicetree/bindings/power/reset/brcm,bcm21664-resetmgr.txt
deleted file mode 100644
index 93f31ca1ef4b..000000000000
--- a/Documentation/devicetree/bindings/power/reset/brcm,bcm21664-resetmgr.txt
+++ /dev/null
@@ -1,14 +0,0 @@
-Broadcom Kona Family Reset Manager
-----------------------------------
-
-The reset manager is used on the Broadcom BCM21664 SoC.
-
-Required properties:
-  - compatible: brcm,bcm21664-resetmgr
-  - reg: memory address & range
-
-Example:
-	brcm,resetmgr@35001f00 {
-		compatible = "brcm,bcm21664-resetmgr";
-		reg = <0x35001f00 0x24>;
-	};
diff --git a/Documentation/devicetree/bindings/power/reset/brcm,bcm21664-resetmgr.yaml b/Documentation/devicetree/bindings/power/reset/brcm,bcm21664-resetmgr.yaml
new file mode 100644
index 000000000000..3e28a59d718f
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/reset/brcm,bcm21664-resetmgr.yaml
@@ -0,0 +1,31 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/reset/brcm,bcm21664-resetmgr.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Broadcom Kona family reset manager
+
+maintainers:
+  - Florian Fainelli <f.fainelli@gmail.com>
+
+properties:
+  compatible:
+    const: brcm,bcm21664-resetmgr
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    reset-controller@35001f00 {
+        compatible = "brcm,bcm21664-resetmgr";
+        reg = <0x35001f00 0x24>;
+    };
+...
-- 
2.25.1

