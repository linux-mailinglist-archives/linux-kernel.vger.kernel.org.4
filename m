Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30FDD7315E6
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 12:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245296AbjFOK6q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 06:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244393AbjFOK6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 06:58:39 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64E342729
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 03:58:36 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4f63ab1ac4aso10132288e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 03:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google; t=1686826714; x=1689418714;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/O5ajNJ8bhgs1nhXgvSUBPUBne+CmT1+jmqUtcvu2LU=;
        b=ErbZPPZXvUKlQoXhYWpKMzUgIlmgtXFL8h1xF9US85iurYsE0eidYdhkKCulFoGDNC
         yaZXHMQdvSNUb5rErJvZNzwcMQY1Chend81fZFofkkfCs+UOz0PSM2uzq+iR+qPci9am
         OenACAI9pG5a12e5V3H8qwYx0Ab61FVdbUbiE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686826714; x=1689418714;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/O5ajNJ8bhgs1nhXgvSUBPUBne+CmT1+jmqUtcvu2LU=;
        b=d4GLhMfUG4QiiWGZ223yxq5Xu35wOWwW/AJ6prfbW9vS9l1/9pQC+RtWVsicO17jho
         QATVQ5qjlt9i7JfZfL6GXoy3U/gT0buAkIPqE2feWIde9fv21TAP3IekS0AWLUpwbkN1
         LL02EgRxvJBKxE3DxbNxbeQ4ipyru1WnmjqBFNoY4ve74Dm2IaroBmtRGfCvOdCtcVJM
         EjYI7meiMvRVO8cbxJ0bn/x4NK+CgwkY6v41n0N9I0IVKaaUde+BxdAMYl2BT/XTL3dx
         JhiGyjMu5thSb6PaabHDrW5tgic6s7gG4HkoLeO4olTpVpBwVTwj0EWH+/VtEniCEPsa
         uWEw==
X-Gm-Message-State: AC+VfDzSGX3szTka3SLrQ/952agidlZMkJlevt8T3cxHumVrVxPus56C
        54HV8YQQ7eoRtSDvgzyRCvzRBQ==
X-Google-Smtp-Source: ACHHUZ67E82lkWq68LWSYGH0WEyZLC4mCttbXHLuYdkqTEasoP0CoqOEBdlvhoaiKO/uXnrlxYM/lA==
X-Received: by 2002:a19:9212:0:b0:4f6:2ce6:124 with SMTP id u18-20020a199212000000b004f62ce60124mr8184297lfd.39.1686826714625;
        Thu, 15 Jun 2023 03:58:34 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id h7-20020ac25967000000b004f13f4ec267sm165364lfp.186.2023.06.15.03.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 03:58:33 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-rtc@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/8] dt-bindings: rtc: Move isil,isl12022 from trivial-rtc.yaml into own schema file
Date:   Thu, 15 Jun 2023 12:58:20 +0200
Message-Id: <20230615105826.411953-3-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230615105826.411953-1-linux@rasmusvillemoes.dk>
References: <20230612113059.247275-1-linux@rasmusvillemoes.dk>
 <20230615105826.411953-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the isil,isl12022 RTC bindings from trivial-rtc.yaml into its own
intersil,isl12022.yaml file, in preparation for adding more bindings.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 .../bindings/rtc/intersil,isl12022.yaml       | 45 +++++++++++++++++++
 .../devicetree/bindings/rtc/trivial-rtc.yaml  |  2 -
 2 files changed, 45 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/rtc/intersil,isl12022.yaml

diff --git a/Documentation/devicetree/bindings/rtc/intersil,isl12022.yaml b/Documentation/devicetree/bindings/rtc/intersil,isl12022.yaml
new file mode 100644
index 000000000000..054d3fc649ba
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/intersil,isl12022.yaml
@@ -0,0 +1,45 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/rtc/intersil,isl12022.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Intersil ISL12022 Real-time Clock
+
+maintainers:
+  - Alexandre Belloni <alexandre.belloni@bootlin.com>
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
+allOf:
+  - $ref: rtc.yaml#
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

