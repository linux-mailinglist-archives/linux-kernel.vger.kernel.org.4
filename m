Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 258FE5E6928
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 19:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231831AbiIVRET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 13:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231651AbiIVREL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 13:04:11 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D0A0FF3D5
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 10:04:07 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id ay36so7233138wmb.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 10:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=XKH4BzMgDzrWHlzYeBaOGmh1hYA825wk6UyMQwxMx4g=;
        b=FRWCdjtLlOGIxGaDYH3EHK28wvDXCjtIMZv2ZI9SP6aCVOqcjK7U50+vnfX9myaLLl
         n+o/ITbPlvFyPWBL47CD9B+k0a0qvgPdoBH7jBxIIE9fniH1X498Qo7yPYXN6b/6yNXU
         IrHmb47VuRGpk5hPFXAdVhfcmBkxkIq0VwM4DX31Z1JlQ6erPGTD6Xv5aYewU8hTIF7z
         sd8mpvBNxXW19CpJoY7cmyiFIgmbSJF0YLhvBc2hmJfa0QPgkGj3TnuFHhVGpYBY+u4H
         +/OYxzE6sUtR/9JUqC/CZPF+H7x21EAVRDgP9Kp4loH9Oga6j3HgghO/1N6LMJA+i1lX
         XASg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=XKH4BzMgDzrWHlzYeBaOGmh1hYA825wk6UyMQwxMx4g=;
        b=pFzRL6BKo6tchHxFsG1jmZfA+mzLV9j0IyclFYgNz/mfASlTnHtl8xi/wQE5C7yIM7
         y82w7/ntmBrodpL8X1bIUiUBHjst0S4GYmTX2NnEI8gdSGS+R137XkpzEvXg9bfC/lT7
         69QHc2TtMDkdZqyLZF0JNmBPHBBPoR2fxYqxoBuiRhXHu9FFBveKhaWI5kEtVOlUznT9
         Qr+e5xhUABZPqLEhywBKP1uGcWCYqf5hpmZpFhD6YEkFExTjpWP7Wu+7rXKif+AAgbkz
         Z1JtHTlVetJDNWwJUtyRGeW6qbqIHlP2ZEXKsq8fNLcVQdt6z5yvhVqSIpj/1IBpv/s8
         KQNQ==
X-Gm-Message-State: ACrzQf3jP2aiglraccRRGS4IkLTcWy41RLXCclqcsTCUBnhAaJfp8Dgs
        M5PzNKvwKPXGPYvbAqjI9tl/RQ==
X-Google-Smtp-Source: AMsMyM4iuNElzHUByLPzE48k93z65t2TR+exTM1Fz6+PlLqA+gBagzkUl/oN2uYRGqilZ8qskW5SVA==
X-Received: by 2002:a05:600c:3781:b0:3a6:804a:afc with SMTP id o1-20020a05600c378100b003a6804a0afcmr10081311wmr.27.1663866245784;
        Thu, 22 Sep 2022 10:04:05 -0700 (PDT)
Received: from baylibre-ThinkPad-T14s-Gen-2i.. (32.31.102.84.rev.sfr.net. [84.102.31.32])
        by smtp.gmail.com with ESMTPSA id w21-20020a1cf615000000b003a604a29a34sm20334wmc.35.2022.09.22.10.04.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 10:04:05 -0700 (PDT)
From:   Julien Panis <jpanis@baylibre.com>
To:     william.gray@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, mranostay@ti.com
Subject: [PATCH v8 1/4] dt-bindings: counter: add ti,am62-ecap-capture.yaml
Date:   Thu, 22 Sep 2022 19:03:59 +0200
Message-Id: <20220922170402.403683-2-jpanis@baylibre.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220922170402.403683-1-jpanis@baylibre.com>
References: <20220922170402.403683-1-jpanis@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds a YAML binding for TI ECAP used in capture operating mode.

Signed-off-by: Julien Panis <jpanis@baylibre.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../counter/ti,am62-ecap-capture.yaml         | 61 +++++++++++++++++++
 1 file changed, 61 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/counter/ti,am62-ecap-capture.yaml

diff --git a/Documentation/devicetree/bindings/counter/ti,am62-ecap-capture.yaml b/Documentation/devicetree/bindings/counter/ti,am62-ecap-capture.yaml
new file mode 100644
index 000000000000..4e0b2d2b303e
--- /dev/null
+++ b/Documentation/devicetree/bindings/counter/ti,am62-ecap-capture.yaml
@@ -0,0 +1,61 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/counter/ti,am62-ecap-capture.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments Enhanced Capture (eCAP) Module
+
+maintainers:
+  - Julien Panis <jpanis@baylibre.com>
+
+description: |
+  The eCAP module resources can be used to capture timestamps
+  on input signal events (falling/rising edges).
+
+properties:
+  compatible:
+    const: ti,am62-ecap-capture
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    const: fck
+
+  power-domains:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/soc/ti,sci_pm_domain.h>
+
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        capture@23100000 { /* eCAP in capture mode on am62x */
+            compatible = "ti,am62-ecap-capture";
+            reg = <0x00 0x23100000 0x00 0x100>;
+            interrupts = <GIC_SPI 113 IRQ_TYPE_EDGE_RISING>;
+            power-domains = <&k3_pds 51 TI_SCI_PD_EXCLUSIVE>;
+            clocks = <&k3_clks 51 0>;
+            clock-names = "fck";
+        };
+    };
-- 
2.37.3

