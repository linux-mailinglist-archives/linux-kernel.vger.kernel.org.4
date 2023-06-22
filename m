Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB8B6739F41
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 13:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231604AbjFVLFg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 07:05:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231657AbjFVLFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 07:05:06 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6612D2105;
        Thu, 22 Jun 2023 04:04:55 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-312824aa384so2687822f8f.1;
        Thu, 22 Jun 2023 04:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687431893; x=1690023893;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cD2IBQ3gllS/hNv9a8DJi4PWdalaNeoSJkKF5Grc1bE=;
        b=nvxWHbTtQVgOa7Tr0IuekEY+8zoy8HJJWJh8LEXJOgUw3FAtyaH+OYNFIbZItGkFqw
         N1AoUSjwlCVIcHPVsjpOhesoIFviK0w8hcmPmyfMoVT1hg1yA7yF76QUUWLd/QnF4Jmh
         UzJVaKNykZeNynBJWv/f2okpfKmzWybjwqohMPb5xe1mWhr9IMjGTulZ5aoM7osOcQQf
         fuKZ6gUkK1eqhbFLd70Y0rCxAsNWHYOIiaeIq3ZAWxl1yLWo/GgK/z5RWjI2ByIwM8Wt
         9Er8YosVejJME/jd6kMobtvlInPjAImj96Tx1yfT/SuO6qz53mJyldzRc7SThfiSc+ss
         sF/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687431893; x=1690023893;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cD2IBQ3gllS/hNv9a8DJi4PWdalaNeoSJkKF5Grc1bE=;
        b=BGIBwuMV2dFUIVyFZ1jkvb0PiqZrD1d+REZaE7rZHyxLuNq/S3kMdM91XkhMZvjbSP
         5aIyQX4dpvNZReWyJYMos1Gj7/1kMIphMCZJX5WNK31KIyFHNOEGHKQDsu7YN5cvd5Yk
         MI0R3cYZdVueJa+UWQkidsjvipkVglf/rEc8CNkHsIISEhn65yH39mkPFigOo6TIwgq+
         aIbEZmoVWVgu6ZufmcZIEs0zN3MVhpibgQVBcN6gunV9uYFeYNrWmQpBg/vEK9MEYU/R
         0Cz19mxZfG5pfZwlWw/6MVP+y9EB8z/G61WJ/mt1sI4qZ+rWp7sH8kkhnI8H9Sx0SjwR
         VvEA==
X-Gm-Message-State: AC+VfDxwvI7VvICybYkpXZlEu3TYSYS+i/T63NmHyW9du1qeIf60gkdR
        OB788v22Nn/nnyTTUePxofqjpTpd/JI=
X-Google-Smtp-Source: ACHHUZ5bINkxxH24XYUaYNOiQ7GTOWsBVdUhZawiCNWlNns0nKL4ZKOtbnWKE+eH+RsT+bRLzVOj+Q==
X-Received: by 2002:adf:fd82:0:b0:30e:19a8:4b15 with SMTP id d2-20020adffd82000000b0030e19a84b15mr13326159wrr.30.1687431893200;
        Thu, 22 Jun 2023 04:04:53 -0700 (PDT)
Received: from localhost.localdomain (61.red-88-10-54.dynamicip.rima-tde.net. [88.10.54.61])
        by smtp.gmail.com with ESMTPSA id h9-20020a5d4fc9000000b0031134bcdacdsm6751766wrw.42.2023.06.22.04.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 04:04:52 -0700 (PDT)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     devicetree@vger.kernel.org
Cc:     tglx@linutronix.de, maz@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] dt-bindings: interrupt-controller: add Ralink SoCs interrupt controller
Date:   Thu, 22 Jun 2023 13:04:51 +0200
Message-Id: <20230622110451.1504823-1-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add YAML doc for the interrupt controller which is present on Ralink SoCs.

Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
Changes in v2:
 - Drop label from the example.

 .../ralink,rt2880-intc.yaml                   | 54 +++++++++++++++++++
 1 file changed, 54 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/ralink,rt2880-intc.yaml

diff --git a/Documentation/devicetree/bindings/interrupt-controller/ralink,rt2880-intc.yaml b/Documentation/devicetree/bindings/interrupt-controller/ralink,rt2880-intc.yaml
new file mode 100644
index 000000000000..533d6d03aa75
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/ralink,rt2880-intc.yaml
@@ -0,0 +1,54 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/ralink,rt2880-intc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Ralink SoCs Interrupt Controller
+
+maintainers:
+  - Sergio Paracuellos <sergio.paracuellos@gmail.com>
+
+allOf:
+  - $ref: /schemas/interrupt-controller.yaml#
+
+description: |
+  This interrupt controller support a central point for interrupt aggregation
+  for platform related blocks.
+
+properties:
+  compatible:
+    const: ralink,rt2880-intc
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  interrupt-controller: true
+
+  '#interrupt-cells':
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - interrupt-controller
+  - '#interrupt-cells'
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    interrupt-controller@200 {
+      compatible = "ralink,rt2880-intc";
+      reg = <0x200 0x100>;
+      interrupt-controller;
+      #interrupt-cells = <1>;
+
+      interrupt-parent = <&cpuintc>;
+      interrupts = <2>;
+    };
+...
-- 
2.25.1

