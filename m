Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC846627767
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 09:21:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236341AbiKNIVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 03:21:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236320AbiKNIVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 03:21:04 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8FC51A822;
        Mon, 14 Nov 2022 00:21:03 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id d59-20020a17090a6f4100b00213202d77e1so13074143pjk.2;
        Mon, 14 Nov 2022 00:21:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6i4HyMglMaC/4c5RfmowST4xc1PHu7ajiLvUodJVrVY=;
        b=jOdMhJuYaPrfNRDkA04X8vm6WQ51WFHC4rY2fzCMDJiMqFzMXeLcNhuU7D/BKv7J7K
         wfK6wBIHtz+d4SNSubMZ4LldPF8xxxtDC+N4CSXygPkdm9vvIV9NX5yi0PvfCI/KFMwQ
         ejDzxS9FRJ59lWeZ7+p17YGamRE1Q12AG02Ad1S33TBKI/E4E1P56c289gyeq2K8oLAD
         PprLPyWdQo1XiZJOeDy3p3x2FROksDrero1v3BKL/Z2CFevo4zkRKQftZLG3TL6UDFdT
         MT+7wf8rndh/WkBSUh4Ia5JsXuaTDE7WTK2aVFuBZNVWLAnn0fx36ARzCIB3RF9cUohi
         9KYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6i4HyMglMaC/4c5RfmowST4xc1PHu7ajiLvUodJVrVY=;
        b=H3arnuXN0C1rMFs7KfeMgawaHFjQelwUq068R23asZgRfciZd8A2Z/goNMF1GI7wJd
         2ZO6d2VSHUYN8NUv/Ii8DtBGBkbfj7Ot/7aR79sw5pHJL60ny0tUcXha2880a+vO+bNC
         LTfSlbartAvwfem0r0H0OKOiLFEa/Q3/zHhTb1USWtPX3g0egjSQ44256Xg1YjbOQU3R
         kmsj+RZIBg/5HlcHx1Mdi6RpWtx8RlgnBH8OjBnGTqmDeRgRDRQuCitTwllP4qSm8KUN
         MiTbpeAXX7I9i57W8V3uIFBZEXKkzoMWROiUyJv+O8HaYSVltaIeSpNlzBkNxSjLnPsw
         asbw==
X-Gm-Message-State: ANoB5pkJ7LWvL0lul8sq1IWrPo4uZZ/FVXk/PSNM1+NqI4Wj6V1S+I6w
        VAiA6b7iBWFbPAzTK2LtISg=
X-Google-Smtp-Source: AA0mqf7PA5hHbtk7LNu55wa/tN6grk/2MrnLxASAHrd5VFTl2FliBuw9k22C9tCH+ZXwCZS8iBuDcg==
X-Received: by 2002:a17:902:70ca:b0:188:b35e:c787 with SMTP id l10-20020a17090270ca00b00188b35ec787mr9916613plt.76.1668414063271;
        Mon, 14 Nov 2022 00:21:03 -0800 (PST)
Received: from localhost.localdomain ([2402:7500:487:fe99:8803:61a2:a857:2b40])
        by smtp.gmail.com with ESMTPSA id o38-20020a634e66000000b004639c772878sm5419997pgl.48.2022.11.14.00.21.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Nov 2022 00:21:02 -0800 (PST)
From:   cy_huang <u0084500@gmail.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        sre@kernel.org
Cc:     cy_huang@richtek.com, allen_chiang@richtek.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/3] dt-bindings: power: supply: Add Richtek RT9759 smart cap divider charger
Date:   Mon, 14 Nov 2022 16:20:51 +0800
Message-Id: <1668414053-32728-2-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1668414053-32728-1-git-send-email-u0084500@gmail.com>
References: <1668414053-32728-1-git-send-email-u0084500@gmail.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

Add bindings for the Richtek RT9759 smart cap divider charger.

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
Since v2
- Add Reviewed-by tag for dt-binding patch

---
 .../bindings/power/supply/richtek,rt9759.yaml      | 61 ++++++++++++++++++++++
 1 file changed, 61 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/richtek,rt9759.yaml

diff --git a/Documentation/devicetree/bindings/power/supply/richtek,rt9759.yaml b/Documentation/devicetree/bindings/power/supply/richtek,rt9759.yaml
new file mode 100644
index 00000000..04fc6b0
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/richtek,rt9759.yaml
@@ -0,0 +1,61 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/supply/richtek,rt9759.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Richtek RT9759 Smart Cap Divider Charger
+
+maintainers:
+  - ChiYuan Huang <cy_huang@richtek.com>
+
+description: |
+  The RT9759 is a high efficiency and high charge current charger.
+  The efficiency is up to 97.8% when VBAT = 4.2V, IBAT = 2.5A and the maximum
+  charge current is up to 8A. The device integrates smart cap divider topology
+  with dual phase charge pump core. The ADCs provide input and output voltage,
+  current and temperature information to monitor the whole charging process.
+
+  Datasheet is available at
+  https://www.richtek.com/assets/product_file/RT9759/DS9759-02.pdf
+
+properties:
+  compatible:
+    enum:
+      - richtek,rt9759
+
+  reg:
+    maxItems: 1
+
+  wakeup-source: true
+
+  interrupts:
+    maxItems: 1
+
+  shunt-resistor-micro-ohms:
+    description: Battery current sense resistor mounted.
+    default: 2000
+
+required:
+  - compatible
+  - reg
+  - wakeup-source
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      charger@66 {
+        compatible = "richtek,rt9759";
+        reg = <0x66>;
+        wakeup-source;
+        interrupts-extended = <&gpio_intc 32 IRQ_TYPE_EDGE_FALLING>;
+        shunt-resistor-micro-ohms = <5000>;
+      };
+    };
-- 
2.7.4

