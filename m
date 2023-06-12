Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D15C72C337
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 13:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234568AbjFLLji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 07:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233010AbjFLLiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 07:38:25 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EF8346BF
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 04:31:07 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4f6370ddd27so4816998e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 04:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google; t=1686569465; x=1689161465;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YpuBhKsWEFwrG+U6fAOV3v6Ozr7I0OWP1C3aU0PzTV4=;
        b=LconL8RHpCpwjklWxyvC74ECVtkdib0L3H+oc1qrqBvkwzexWBLycAyBp4jZWjzYVF
         FbfFFqTLr7w3aEXgRDnHs8dWJe9JM+P+LRR7Cp506h6WBAFLpN7ANb2nvAygrAkXhKRL
         TcbDgzjRfLBsHxemcdzt5R6DkVdEwuyG2ChCg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686569465; x=1689161465;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YpuBhKsWEFwrG+U6fAOV3v6Ozr7I0OWP1C3aU0PzTV4=;
        b=M17ebSxCnu3E+AzdCSGWUAV7wAcIfqK7Q6GgkclJnYy5pzf6fEt7SHz0Q0uy5fxtXZ
         b1edg6jsnOXciEurIqg6WhV5GTHnxzswzLQjgvO1KdYxzMJ9O4OpHFeXZ7zARZygnoUw
         WTFGIWOxsjTmkue+mt63bD54qhPRAtegotJ4A7uai8k7b/Ajr2E0C5dOUHVtECVGwkKd
         SKXkNGnZqB2DVp9i03a9xvW6lq4NpV3do/x9+sNaj9nLYsXSzwBtTSLoDbeYHQ7Vy+I9
         FJP6frAwx2raQA67TTi+7MAz8BmjXUL+76XTCSc8qTn9sfzrYlWlaa2XBZy5Yj7Ky4so
         1KFQ==
X-Gm-Message-State: AC+VfDwAU68kyq2tblsjZp//ruz9oErMmNoXaNGgwfIngYlDw5wGcPxF
        SpDuApwUfbE4JAl/OnlnGQafHg==
X-Google-Smtp-Source: ACHHUZ6laWK/Q3Q+PhWV0V2XyJiorOzxc6mfn2Qs3Lr2FsZ8f0qQfCBXjBJIbiby1VE5xsrBnBMasw==
X-Received: by 2002:a19:e34e:0:b0:4f6:21db:e584 with SMTP id c14-20020a19e34e000000b004f621dbe584mr3372913lfk.0.1686569465413;
        Mon, 12 Jun 2023 04:31:05 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id w26-20020a19c51a000000b004edb8fac1cesm1399320lfe.215.2023.06.12.04.31.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 04:31:04 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-rtc@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/8] dt-bindings: rtc: Move isil,isl12022 from trivial-rtc.yaml into own schema file
Date:   Mon, 12 Jun 2023 13:30:52 +0200
Message-Id: <20230612113059.247275-3-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230612113059.247275-1-linux@rasmusvillemoes.dk>
References: <20230612113059.247275-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the isil,isl12022 RTC bindings from trivial-rtc.yaml into its own
intersil,isl12022.yaml file, in preparation for adding more bindings.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 .../bindings/rtc/intersil,isl12022.yaml       | 42 +++++++++++++++++++
 .../devicetree/bindings/rtc/trivial-rtc.yaml  |  2 -
 2 files changed, 42 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/rtc/intersil,isl12022.yaml

diff --git a/Documentation/devicetree/bindings/rtc/intersil,isl12022.yaml b/Documentation/devicetree/bindings/rtc/intersil,isl12022.yaml
new file mode 100644
index 000000000000..899c5edc72e4
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/intersil,isl12022.yaml
@@ -0,0 +1,42 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/rtc/intersil,isl12022.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Intersil ISL12022 Real-time Clock
+
+allOf:
+  - $ref: rtc.yaml#
+
+properties:
+  compatible:
+    const: isil,isl12022
+
+  reg:
+    maxItems: 1
+
+  interrupts:
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
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        rtc@6f {
+            compatible = "isil,isl12022";
+            reg = <0x6f>;
+            interrupts-extended = <&gpio1 5 IRQ_TYPE_LEVEL_LOW>;
+        };
+    };
+
+...
diff --git a/Documentation/devicetree/bindings/rtc/trivial-rtc.yaml b/Documentation/devicetree/bindings/rtc/trivial-rtc.yaml
index a3603e638c37..b062c64266a6 100644
--- a/Documentation/devicetree/bindings/rtc/trivial-rtc.yaml
+++ b/Documentation/devicetree/bindings/rtc/trivial-rtc.yaml
@@ -45,8 +45,6 @@ properties:
       - isil,isl1208
       # Intersil ISL1218 Low Power RTC with Battery Backed SRAM
       - isil,isl1218
-      # Intersil ISL12022 Real-time Clock
-      - isil,isl12022
       # Loongson-2K Socs/LS7A bridge Real-time Clock
       - loongson,ls2x-rtc
       # Real Time Clock Module with I2C-Bus
-- 
2.37.2

