Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0F015BFBF8
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 12:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbiIUKGl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 06:06:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbiIUKGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 06:06:34 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7479786FE
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 03:06:32 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id q21so7859390edc.9
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 03:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=XKH4BzMgDzrWHlzYeBaOGmh1hYA825wk6UyMQwxMx4g=;
        b=Ug+Z2CHZaiEesfoVp4XWq7sDhHzD6QtxEd5UXTRyyaKkp1hewp9yk7RHQJxTAk0epA
         iWmfh7YS/QTqD7Xez3oocfzY63v2BKbezU4pPkL8Uyob3CsEy9SI4Y3AlRE7B8oHMswn
         VwUGDPDgn9iTHAWYx6xzlAaA2MYOuvb4x+rhbSQhxHbrWo6xzvOq0P2xRmcY3hGd0cn7
         7GetZ1OLTC88zkigqh6GBBssXaXHHY8wjk8YxKw+Kse7gQIzqXhpGzT68li6WRJ9+Ypp
         OrTd6/j2flcjoudEZ0IFKg1WwIN4rxo4zO1xCV0cDAxuSG8KhnC1E1i+KVp2qJ4QLcsu
         lP5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=XKH4BzMgDzrWHlzYeBaOGmh1hYA825wk6UyMQwxMx4g=;
        b=7wGP9xXdg1H6Al0bUZ6MXcHbhsuF2fmJgv4/9deNeOLDOPaDWNcR+Vtuxqa8YI5oNS
         +YdeFRTxl2cOc0F8/E+7s0GlBf8FKPSNIQsd19hapiHJ/AiJfjSe/IE2wairc9w9Ew1O
         T2L6dLOiKoLD9iTiSEM+DVRMuYSj6VFg4jDyEtdTRz5yIBFX8mTyJDkZW34nqZXUhvNq
         CeWhjZdM3OMudXcc1kB3q6G66jTeTglibn1RO1cDYSAEMcpl1cSnl4pcERqGgWHypDhS
         050imUPJpdvNZUd2AvYUe8t/Fa8p88IJHltBJyAcZFGBwxyiVd/64WxRJkZ7F4b5ay6b
         OP6Q==
X-Gm-Message-State: ACrzQf0HODWGtHyqwV8vNFGfexeH7cFAEtmJswh4s+cEu68JL2ZBBt4P
        vq6Dr6wdkGK0wdRRP6jLFz8R7Q==
X-Google-Smtp-Source: AMsMyM4bK8wWTCqPfQXoFsFijFy933y3Hn0HjqxMmNc4qMp5ZXLhHKBgSsa0mvRI3J6idMrmxC4uLA==
X-Received: by 2002:a05:6402:3705:b0:454:e006:82 with SMTP id ek5-20020a056402370500b00454e0060082mr918854edb.360.1663754791338;
        Wed, 21 Sep 2022 03:06:31 -0700 (PDT)
Received: from baylibre-ThinkPad-T14s-Gen-2i.. (32.31.102.84.rev.sfr.net. [84.102.31.32])
        by smtp.gmail.com with ESMTPSA id v1-20020a170906292100b0074134543f82sm1087710ejd.90.2022.09.21.03.06.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 03:06:31 -0700 (PDT)
From:   Julien Panis <jpanis@baylibre.com>
To:     william.gray@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, mranostay@ti.com
Subject: [PATCH v7 1/4] dt-bindings: counter: add ti,am62-ecap-capture.yaml
Date:   Wed, 21 Sep 2022 12:06:24 +0200
Message-Id: <20220921100627.124085-2-jpanis@baylibre.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220921100627.124085-1-jpanis@baylibre.com>
References: <20220921100627.124085-1-jpanis@baylibre.com>
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

