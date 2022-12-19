Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CD91651148
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 18:36:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232375AbiLSRge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 12:36:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232054AbiLSRg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 12:36:28 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3D43DFC3;
        Mon, 19 Dec 2022 09:36:25 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id t17so23365445eju.1;
        Mon, 19 Dec 2022 09:36:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1SUx4YxBJbW2R7ovNPCFyF9xOKCwgY1o0HqXnE9Kzl8=;
        b=jpTtdQNQM3Yxi5Nf6/+5xf+/rghnp2f7NhMX2DtUaLELb6WakVq7gWsYPlbsyiL6PS
         ChAupK2HDu3Y9LU1fN+yCe7pPeTrG61BQaGyW/jDQx/+HHN2bMbWxoVxYZqfyiJwlfWa
         Y4h7iJvv4QIFpOoVyXIX19weZKsj9Cb6tADl7LQNqkD4T1wSYxbYS5HeqVefq90eA+ER
         /Nk7kAHpjjpXbjqGM1KRD1sSDI3O/5MLQ40SbYxa/HDE5seoG5uLTOmMSb71JLg2mGZZ
         lGDUyB1i+XE6M5lJ2ttLvYFNOBmrvQLtRzaDCIzMNHrNHSn16xwD0q8i2hUE+HNnuXoQ
         nFdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1SUx4YxBJbW2R7ovNPCFyF9xOKCwgY1o0HqXnE9Kzl8=;
        b=YERg/skqtZRdVhdfylcvfskjnwjGUQvv9PSwd7qowJI62Lc9NcjAZDeA90VXI9I6qY
         MDUuF/aPtvl80wmc5eIb7fN2q9frm8A36B9fBDvZ+d27jx6uDTJI6OzTPVayv2SSjVDB
         aoYrZxVU/4g+/7CHrCbOYViu4BGdQTl+xlXFtxfPHU+EB3CNAPslno1wHzpF+tB7li+B
         gAK7/Bki9nneYYkxxz3Jw6qhi/KAWVAV2Vmkg5zPjk/js8Yrd2iNzTeb3eiLdNR4D219
         6j5fJzGL84VVHK9c62V7hOCPDIJ4LnFkvfimXMJbKaGzV3jBT3wNAfKExxDcqIiBsBX1
         Ayxg==
X-Gm-Message-State: ANoB5pncn9EfYDx9YC2czQGwNeZvTN+PKMbd4r8YPCazeuTtLFhGsaVS
        QX1Vt63HKm88U03i2bgOxqzUcNSF6HC9GQ==
X-Google-Smtp-Source: AA0mqf5IeWagWC7vwl63uutw6mzJKidMwPtteo4m7qSQQpMtuhJ7rCJKW2KVN5qNXPj0ETrQq1lqfA==
X-Received: by 2002:a17:906:f6d7:b0:7c0:bf7c:19f4 with SMTP id jo23-20020a170906f6d700b007c0bf7c19f4mr36417779ejb.74.1671471384471;
        Mon, 19 Dec 2022 09:36:24 -0800 (PST)
Received: from localhost ([2a02:1210:8629:800:82ee:73ff:feb8:99e3])
        by smtp.gmail.com with UTF8SMTPSA id 17-20020a170906211100b007bb32e2d6f5sm4574859ejt.207.2022.12.19.09.36.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Dec 2022 09:36:24 -0800 (PST)
From:   Alexander Sverdlin <alexander.sverdlin@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: iio: adc: ep93xx: Add cirrus,ep9301-adc description
Date:   Mon, 19 Dec 2022 18:36:17 +0100
Message-Id: <20221219173618.1030415-1-alexander.sverdlin@gmail.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree bindings for Cirrus Logic EP9301/EP9302 internal SoCs' ADC
block.

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
---
Changelog:
v2: removed clock-names property, soc node and include as Krzysztof suggested

 .../bindings/iio/adc/cirrus,ep9301-adc.yaml   | 47 +++++++++++++++++++
 MAINTAINERS                                   |  2 +
 2 files changed, 49 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/cirrus,ep9301-adc.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/cirrus,ep9301-adc.yaml b/Documentation/devicetree/bindings/iio/adc/cirrus,ep9301-adc.yaml
new file mode 100644
index 000000000000..6d4fb3e1d2a2
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/cirrus,ep9301-adc.yaml
@@ -0,0 +1,47 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/cirrus,ep9301-adc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Cirrus Logic EP930x internal ADC
+
+description: |
+  Cirrus Logic EP9301/EP9302 SoCs' internal ADC block.
+
+  User's manual:
+  https://cdn.embeddedts.com/resource-attachments/ts-7000_ep9301-ug.pdf
+
+maintainers:
+  - Alexander Sverdlin <alexander.sverdlin@gmail.com>
+
+properties:
+  compatible:
+    const: cirrus,ep9301-adc
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
+
+additionalProperties: false
+
+examples:
+  - |
+    adc: adc@80900000 {
+        compatible = "cirrus,ep9301-adc";
+        reg = <0x80900000 0x28>;
+        clocks = <&syscon 24>;
+        interrupt-parent = <&vic1>;
+        interrupts = <30>;
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 69565ac0c224..4a914d5bc2e6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2027,8 +2027,10 @@ M:	Hartley Sweeten <hsweeten@visionengravers.com>
 M:	Alexander Sverdlin <alexander.sverdlin@gmail.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
+F:	Documentation/devicetree/bindings/iio/adc/cirrus,ep9301-adc.yaml
 F:	arch/arm/mach-ep93xx/
 F:	arch/arm/mach-ep93xx/include/mach/
+F:	drivers/iio/adc/ep93xx_adc.c
 
 ARM/CLKDEV SUPPORT
 M:	Russell King <linux@armlinux.org.uk>
-- 
2.39.0

