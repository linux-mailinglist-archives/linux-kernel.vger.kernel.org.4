Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A30D7005C1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 12:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240747AbjELKiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 06:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240707AbjELKiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 06:38:09 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5618D59D1;
        Fri, 12 May 2023 03:37:38 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-6434e263962so7280552b3a.2;
        Fri, 12 May 2023 03:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683887857; x=1686479857;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O4pkWtf5ZbvB3Mwr1DSQ73VhT77HryuyM9DctWSrkJQ=;
        b=H7uyjFa2PQA21s7dZHna6CDOrkAJ1pbPcQPEJE6y4lY7fXow3TYcfSJo2hlc2Gv07R
         m11qvMNRrigLnTGxhLv68NITruFcPp25OZJLWr3tyCJStQJwMA+MXlac0WGgJSBsEdEi
         7f/8HSLYBwLGRp74MK1eX8LfdXRjeAcBpFR8SN2z2VMJ30ssgq4fdslhBGRyH7uDo56c
         DAFv6URrKny/4ze/s9GJQXszLrb5rg0K9d3icMCPziNl9jKvbgjwIypH50HVoNmnGXc9
         pt8ncfVGPbeQnmkJf5UXXAooO4pnzVnG1Ry6H8+6vDdAOuEhsb7PPH8/x0Uq20KrxAUq
         wXJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683887857; x=1686479857;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O4pkWtf5ZbvB3Mwr1DSQ73VhT77HryuyM9DctWSrkJQ=;
        b=fSopqB13Iti7QOLC3/f/tZiGLUx9d6T1UWDKBGKDIj2jzNpiubvR4pg/272becGLCk
         P6CdzIECLQTRPrK3bdy+z3RzLQ4yG79F/eBarp48tByyr9Mn70cJ67crC3xH2DIJWIyC
         uwC/FFzQWCwQilS7X1lmAYjuZoZsqsb6brLzXr/yOsx3gxyJ3DNQ38iqBHiqN5b2SCNY
         UJjGk7mI3Z1gaIMtCnljL+SoFwkfdizydrRFlkrITjpA/PNmc76sVyR3B78Glx8OQctC
         JIEtql1Dkf8KoGB7UCI6CUDYqLcKKbdatdBLmkFCgo3ZrtOHqii7x1mq5w2CchhE5QHZ
         jp7g==
X-Gm-Message-State: AC+VfDwzB06xUq4aLHcQEIKJmKjIcZcMLXVS0yGktbK1H1ySrTmICbIL
        hhF0RRwKlClbcU04hHC/DVp9SbQtotIkY7dk
X-Google-Smtp-Source: ACHHUZ6UYkantohKHOwH1sweJxcQcbFw0OgVlZhvmpXs4SaMqrMlnA544OMSqnS1dc2LJlhdQMfSrQ==
X-Received: by 2002:a05:6a00:2448:b0:63d:3789:733f with SMTP id d8-20020a056a00244800b0063d3789733fmr30478169pfj.15.1683887857081;
        Fri, 12 May 2023 03:37:37 -0700 (PDT)
Received: from kelvin-ThinkPad-L14-Gen-1.lan ([103.184.129.7])
        by smtp.gmail.com with ESMTPSA id k5-20020aa792c5000000b0063b89300347sm7009485pfa.142.2023.05.12.03.37.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 03:37:36 -0700 (PDT)
From:   Keguang Zhang <keguang.zhang@gmail.com>
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Keguang Zhang <keguang.zhang@gmail.com>
Subject: [PATCH v4 2/3] dt-bindings: timer: Add Loongson-1 clocksource
Date:   Fri, 12 May 2023 18:37:23 +0800
Message-Id: <20230512103724.587760-3-keguang.zhang@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230512103724.587760-1-keguang.zhang@gmail.com>
References: <20230512103724.587760-1-keguang.zhang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree binding document for Loongson-1 clocksource.

Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
---
V3 -> V4: Replaced the wildcard compatible string with specific one
V2 -> V3: None
V1 -> V2: None
---
 .../timer/loongson,ls1x-pwmtimer.yaml         | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/loongson,ls1x-pwmtimer.yaml

diff --git a/Documentation/devicetree/bindings/timer/loongson,ls1x-pwmtimer.yaml b/Documentation/devicetree/bindings/timer/loongson,ls1x-pwmtimer.yaml
new file mode 100644
index 000000000000..ad61ae55850b
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/loongson,ls1x-pwmtimer.yaml
@@ -0,0 +1,48 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/timer/loongson,ls1x-pwmtimer.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Loongson-1 PWM timer
+
+maintainers:
+  - Keguang Zhang <keguang.zhang@gmail.com>
+
+description:
+  Loongson-1 PWM timer can be used for system clock source
+  and clock event timers.
+
+properties:
+  compatible:
+    const: loongson,ls1b-pwmtimer
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/loongson,ls1x-clk.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    clocksource: timer@1fe5c030 {
+        compatible = "loongson,ls1b-pwmtimer";
+        reg = <0x1fe5c030 0x10>;
+
+        clocks = <&clkc LS1X_CLKID_APB>;
+        interrupt-parent = <&intc0>;
+        interrupts = <20 IRQ_TYPE_LEVEL_HIGH>;
+    };
-- 
2.39.2

