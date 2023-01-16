Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7A4566D085
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 21:48:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233964AbjAPUs5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 15:48:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233856AbjAPUsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 15:48:09 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA02D2B2BB;
        Mon, 16 Jan 2023 12:48:01 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id h16so28610889wrz.12;
        Mon, 16 Jan 2023 12:48:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qNhknaVutA0+hwESiilZZqAeypzvuo91LxSk1FHi6xk=;
        b=NxMLdxS712ABWxDzQ1o9DiQpLJNdwITJ+v8rH3WIWYbh4JTw0X6emIOVCuCOR4BEku
         GTepwlyZnMD4DnRandx4W6h7h1UIfjSzoVCFrgNyjvui+cU61bGgEQY/5K+igM7guAY6
         zi3aY7pgjAn0/voM1RHvalCRC5EYH4gdYsa3W566/Lu6D5rawm/Dv7HFHWT99hrNXZg6
         2Ln90MJSMQ3gcEEakou4g8+fR2A13hz/yjYtL6q+Q1XK1JB9UCT8gouoqBu4FactVRSh
         isRDd9WWOhvKpTvYqrUpKQcTMwqR1Syz47MHd/6Ym4vD9aqtCPocsh2EUPt6kaRoucQo
         sUpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qNhknaVutA0+hwESiilZZqAeypzvuo91LxSk1FHi6xk=;
        b=Ish+00R853eN2J29E7V6vFYXxT0ivY1qp/2Vuz6VzXCgQtLYlzqmBkJnyPP7/JTU7v
         q5wGfJqjFBpp0S7fgpIDfvYFJqi8eqqovcTQ8ZUJfpEGW0YUY7Pb8ueMEPRiWYIQk3WS
         4TT2WPb3mB/OBh+rp4v/RmZVePcLqN+zeltd1xLyvZz1MqLFUqNVbY19RvP9ijoNTf6o
         PiuhSHUXaiSuTGMTUdMZtNkGr4qFMdbei/moUDzCAPLNeUHHCTvWvs+Bf+P1LEmkcHfi
         qmrVx7/wPK8oxo40vnvN6vC1VSyvf2IEqC5FCwXCz9qUgDbOnFK56cK8nYvdU3ZsbNXY
         EBzA==
X-Gm-Message-State: AFqh2kohCtvOMbOT9aU/PSXSRMXzQSv3O+sS/IpFEcGbfngsOGuqlWsy
        RwhMDvYClYxI7mPVFLE06xg=
X-Google-Smtp-Source: AMrXdXvCHTNuMd6pqRFRNdQmQnMz9DV/4qv+HVWJ0XaGrmHJQlV08ZoUlJnkIjX9b61+h2Du0m5xBQ==
X-Received: by 2002:adf:e74e:0:b0:2be:726:6f53 with SMTP id c14-20020adfe74e000000b002be07266f53mr664311wrn.66.1673902080070;
        Mon, 16 Jan 2023 12:48:00 -0800 (PST)
Received: from localhost.localdomain (93-34-92-88.ip49.fastwebnet.it. [93.34.92.88])
        by smtp.googlemail.com with ESMTPSA id k18-20020adfb352000000b00241fab5a296sm27785372wrd.40.2023.01.16.12.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 12:47:59 -0800 (PST)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Christian Marangi <ansuelsmth@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH v7 2/7] dt-bindings: arm: msm: Convert and split kpss-acc driver Documentation to yaml
Date:   Mon, 16 Jan 2023 21:47:46 +0100
Message-Id: <20230116204751.23045-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230116204751.23045-1-ansuelsmth@gmail.com>
References: <20230116204751.23045-1-ansuelsmth@gmail.com>
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

Convert kpss-acc driver Documentation to yaml.
The original Documentation was wrong all along. Fix it while we are
converting it.
The example was wrong as kpss-acc-v2 should only expose the regs but we
don't have any driver that expose additional clocks. The kpss-acc driver
is only specific to v1. For this exact reason, split the Documentation
to 2 different schema, v1 as clock-controller and v2 for
power-manager as per msm-3.10 specification, the exposed regs handle
power manager.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 .../bindings/arm/msm/qcom,kpss-acc.txt        | 49 -------------
 .../bindings/clock/qcom,kpss-acc-v1.yaml      | 72 +++++++++++++++++++
 .../bindings/power/qcom,kpss-acc-v2.yaml      | 42 +++++++++++
 3 files changed, 114 insertions(+), 49 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,kpss-acc.txt
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,kpss-acc-v1.yaml
 create mode 100644 Documentation/devicetree/bindings/power/qcom,kpss-acc-v2.yaml

diff --git a/Documentation/devicetree/bindings/arm/msm/qcom,kpss-acc.txt b/Documentation/devicetree/bindings/arm/msm/qcom,kpss-acc.txt
deleted file mode 100644
index 7f696362a4a1..000000000000
--- a/Documentation/devicetree/bindings/arm/msm/qcom,kpss-acc.txt
+++ /dev/null
@@ -1,49 +0,0 @@
-Krait Processor Sub-system (KPSS) Application Clock Controller (ACC)
-
-The KPSS ACC provides clock, power domain, and reset control to a Krait CPU.
-There is one ACC register region per CPU within the KPSS remapped region as
-well as an alias register region that remaps accesses to the ACC associated
-with the CPU accessing the region.
-
-PROPERTIES
-
-- compatible:
-	Usage: required
-	Value type: <string>
-	Definition: should be one of:
-			"qcom,kpss-acc-v1"
-			"qcom,kpss-acc-v2"
-
-- reg:
-	Usage: required
-	Value type: <prop-encoded-array>
-	Definition: the first element specifies the base address and size of
-		    the register region. An optional second element specifies
-		    the base address and size of the alias register region.
-
-- clocks:
-        Usage: required
-        Value type: <prop-encoded-array>
-        Definition: reference to the pll parents.
-
-- clock-names:
-        Usage: required
-        Value type: <stringlist>
-        Definition: must be "pll8_vote", "pxo".
-
-- clock-output-names:
-	Usage: optional
-	Value type: <string>
-	Definition: Name of the output clock. Typically acpuX_aux where X is a
-		    CPU number starting at 0.
-
-Example:
-
-	clock-controller@2088000 {
-		compatible = "qcom,kpss-acc-v2";
-		reg = <0x02088000 0x1000>,
-		      <0x02008000 0x1000>;
-		clocks = <&gcc PLL8_VOTE>, <&gcc PXO_SRC>;
-		clock-names = "pll8_vote", "pxo";
-		clock-output-names = "acpu0_aux";
-	};
diff --git a/Documentation/devicetree/bindings/clock/qcom,kpss-acc-v1.yaml b/Documentation/devicetree/bindings/clock/qcom,kpss-acc-v1.yaml
new file mode 100644
index 000000000000..a466e4e8aacd
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/qcom,kpss-acc-v1.yaml
@@ -0,0 +1,72 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/qcom,kpss-acc-v1.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Krait Processor Sub-system (KPSS) Application Clock Controller (ACC) v1
+
+maintainers:
+  - Christian Marangi <ansuelsmth@gmail.com>
+
+description:
+  The KPSS ACC provides clock, power domain, and reset control to a Krait CPU.
+  There is one ACC register region per CPU within the KPSS remapped region as
+  well as an alias register region that remaps accesses to the ACC associated
+  with the CPU accessing the region. ACC v1 is currently used as a
+  clock-controller for enabling the cpu and hanling the aux clocks.
+
+properties:
+  compatible:
+    const: qcom,kpss-acc-v1
+
+  reg:
+    items:
+      - description: Base address and size of the register region
+      - description: Optional base address and size of the alias register region
+    minItems: 1
+
+  clocks:
+    minItems: 2
+    maxItems: 2
+
+  clock-names:
+    items:
+      - const: pll8_vote
+      - const: pxo
+
+  clock-output-names:
+    description: Name of the aux clock. Krait can have at most 4 cpu.
+    enum:
+      - acpu0_aux
+      - acpu1_aux
+      - acpu2_aux
+      - acpu3_aux
+
+  '#clock-cells':
+    const: 0
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - clock-output-names
+  - '#clock-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,gcc-ipq806x.h>
+
+    clock-controller@2088000 {
+      compatible = "qcom,kpss-acc-v1";
+      reg = <0x02088000 0x1000>, <0x02008000 0x1000>;
+      clocks = <&gcc PLL8_VOTE>, <&pxo_board>;
+      clock-names = "pll8_vote", "pxo";
+      clock-output-names = "acpu0_aux";
+      #clock-cells = <0>;
+    };
+
+...
diff --git a/Documentation/devicetree/bindings/power/qcom,kpss-acc-v2.yaml b/Documentation/devicetree/bindings/power/qcom,kpss-acc-v2.yaml
new file mode 100644
index 000000000000..202a5d51ee88
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/qcom,kpss-acc-v2.yaml
@@ -0,0 +1,42 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/qcom,kpss-acc-v2.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Krait Processor Sub-system (KPSS) Application Clock Controller (ACC) v2
+
+maintainers:
+  - Christian Marangi <ansuelsmth@gmail.com>
+
+description:
+  The KPSS ACC provides clock, power manager, and reset control to a Krait CPU.
+  There is one ACC register region per CPU within the KPSS remapped region as
+  well as an alias register region that remaps accesses to the ACC associated
+  with the CPU accessing the region. ACC v2 is currently used as a
+  power-manager for enabling the cpu.
+
+properties:
+  compatible:
+    const: qcom,kpss-acc-v2
+
+  reg:
+    items:
+      - description: Base address and size of the register region
+      - description: Optional base address and size of the alias register region
+    minItems: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    power-manager@f9088000 {
+      compatible = "qcom,kpss-acc-v2";
+      reg = <0xf9088000 0x1000>,
+            <0xf9008000 0x1000>;
+    };
+...
-- 
2.37.2

