Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AADCA62B05E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 02:05:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231560AbiKPBFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 20:05:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231382AbiKPBFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 20:05:01 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB84231FBD
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 17:05:00 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id k7so15001323pll.6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 17:05:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=27UddYJQC31d4E1orvFluo6m1mDuIp+0WFHUDVsxN30=;
        b=TtD/vMEaApxvczspGq7Q4L7MmCIGTX0MxhgMsE6Rn5M5JwKv9nChzsklrQS6R2GKcQ
         kHZCjZZfavysaxdONVUy/HuusWGt4zgTt3ZKYsTbBZAHffonQxwknk85SCbfOEAywx8U
         TMcvnsv7kLIi04/cYrxdqRg4tjF/KoUYYeGeLnY8VGNnMxLH5dl874MpXWwcShs4qrsH
         lfcoEmOPnBPM0NU9vsRb0ZkecDX6inWIglaJ56JWPO4kGHuYcZ0emNVrKp6mLGlptMq/
         RCdktHoIKReuUPMh12QBP0tqIyZKgRo9Rl7uqN8HlY6EEJOHj3mjVx8pVMZK7kGlvvFF
         yWPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=27UddYJQC31d4E1orvFluo6m1mDuIp+0WFHUDVsxN30=;
        b=3pCCGc5mPiItex4642aiQAq98mVG2cQz5HEJBBXlEj1LFFe7nUVQPIrW8TWK9LjupA
         In/7R1jw1U9ytJKhtG05ziJ/bbctm+k4yIOmACaR7xDQlfNCGn44yRMlhV1P8GPpVpI/
         jYhqWa2bnxyDoIvjaFPHfODZZ+M9HOUzEoEONi+GT13+Rl+/5VWrgEylADOf698CUCIc
         Lx21b7LEPC7s8gQz1Wpq0mFyh0osGiRvZYuIo9WuUjNS/SQTXqxZmpT1e8wfgxuvG9RB
         Je/SVp9ZcI3yNtPs8VzvG+ujy894ddBMjKDWe0GADRqWfwMssAzV7/8AAbUDucUiunEe
         QKzg==
X-Gm-Message-State: ANoB5pki7CrPikjgdR6NachFkXkWsMDCG1Jr6NgrAjAgsyWJ6TDiqqaA
        GCxmI/8PwjfMxIlpzDQ7JRF/eg==
X-Google-Smtp-Source: AA0mqf6mEgn6u2/xNi5LaQMqkpaErJ/cgxiNwhjcWn9g3AA2nM10Mx9Pwg3rfO1JOoALDg3jbk2SyA==
X-Received: by 2002:a17:90a:3d49:b0:213:9458:8a93 with SMTP id o9-20020a17090a3d4900b0021394588a93mr1020153pjf.233.1668560699966;
        Tue, 15 Nov 2022 17:04:59 -0800 (PST)
Received: from platform-dev1.pensando.io ([12.226.153.42])
        by smtp.gmail.com with ESMTPSA id f14-20020a170902ce8e00b00186b6bb2f48sm10688518plg.129.2022.11.15.17.04.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 17:04:58 -0800 (PST)
From:   Brad Larson <brad@pensando.io>
X-Google-Original-From: Brad Larson <blarson@amd.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        adrian.hunter@intel.com, alcooperx@gmail.com,
        andy.shevchenko@gmail.com, arnd@arndb.de, blarson@amd.com,
        brijeshkumar.singh@amd.com, catalin.marinas@arm.com,
        gsomlo@gmail.com, gerg@linux-m68k.org, krzk@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lee.jones@linaro.org,
        broonie@kernel.org, yamada.masahiro@socionext.com,
        p.zabel@pengutronix.de, piotrs@cadence.com, p.yadav@ti.com,
        rdunlap@infradead.org, robh+dt@kernel.org, samuel@sholland.org,
        fancer.lancer@gmail.com, suravee.suthikulpanit@amd.com,
        thomas.lendacky@amd.com, ulf.hansson@linaro.org, will@kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v7 06/17] dt-bindings: mfd: amd,pensando-elbasr: Add AMD Pensando Elba System Resource chip
Date:   Tue, 15 Nov 2022 17:04:53 -0800
Message-Id: <20221116010453.41320-1-blarson@amd.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the AMD Pensando Elba SoC System Resource chip
using the SPI interface.

Signed-off-by: Brad Larson <blarson@amd.com>
---

v7:
 - Use system-controller for the device with four chip-selects
   connected over spi.
 - Delete child by moving reset-controller into the parent.
 - Updated and used dtschema-2022.11 and yamllint-1.28.0

v6:
 - Expand description, rename nodes and change compatible usage

v5:
 - Change to AMD Pensando instead of Pensando

v4:
 - Change Maintained to Supported

 .../bindings/mfd/amd,pensando-elbasr.yaml     | 74 +++++++++++++++++++
 1 file changed, 74 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/amd,pensando-elbasr.yaml

diff --git a/Documentation/devicetree/bindings/mfd/amd,pensando-elbasr.yaml b/Documentation/devicetree/bindings/mfd/amd,pensando-elbasr.yaml
new file mode 100644
index 000000000000..ac44d7d0a91a
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/amd,pensando-elbasr.yaml
@@ -0,0 +1,74 @@
+# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/amd,pensando-elbasr.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: AMD Pensando Elba SoC Resource Controller bindings
+
+description: |
+  AMD Pensando Elba SoC Resource Controller functions are
+  accessed with four chip-selects.  Reset control is on CS0.
+
+maintainers:
+  - Brad Larson <blarson@amd.com>
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - amd,pensando-elbasr
+
+  "#reset-cells":
+    const: 1
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - spi-max-frequency
+
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        num-cs = <4>;
+        status = "okay";
+
+        rstc: system-controller@0 {
+            compatible = "amd,pensando-elbasr";
+            reg = <0>;
+            spi-max-frequency = <12000000>;
+            #reset-cells = <1>;
+        };
+
+        system-controller@1 {
+            compatible = "amd,pensando-elbasr";
+            reg = <1>;
+            spi-max-frequency = <12000000>;
+        };
+
+        system-controller@2 {
+            compatible = "amd,pensando-elbasr";
+            reg = <2>;
+            spi-max-frequency = <12000000>;
+            interrupt-parent = <&porta>;
+            interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+        };
+
+        system-controller@3 {
+            compatible = "amd,pensando-elbasr";
+            reg = <3>;
+            spi-max-frequency = <12000000>;
+        };
+    };
-- 
2.17.1

