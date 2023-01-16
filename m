Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1677166D083
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 21:48:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233642AbjAPUsg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 15:48:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233570AbjAPUsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 15:48:09 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2CC72B0AE;
        Mon, 16 Jan 2023 12:48:02 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id r30so4203978wrr.10;
        Mon, 16 Jan 2023 12:48:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jljpjMB2d0+OVrT5QpDlSEjXzhMwiIlUWKVcff0Zz+A=;
        b=k3hCRcOh6Z8pdmvx0AVPsAjqDdpTO0IE/bTI81Uwy6slaNOdYF8eJHKF3VVZyp0Na0
         d9DqpNbdL4Tn8PJNCPdv17k49MxeqbuCEPFjr3T9XEJo4Vvsm8xxqm9mvcpCJNzuW3vH
         sJSDEgLobXR3ApGyos9x2AAwoOmWnmwQiQ8kOFQRrcIWAwm/N/ArZJBw7zHFUJoBdB7f
         WX971BSOnHRkeelWTJJQHPBDiWosAwVZ1pNNK5cppwYYEUTFC9Vjd6NzhhtgkNkrjQfC
         23YovG+bOP1c3W+UAh1KTsDUawclfeqZLw/vXOIBohrshaQwzQ15gYH8fPXkyaiaqqPq
         yW1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jljpjMB2d0+OVrT5QpDlSEjXzhMwiIlUWKVcff0Zz+A=;
        b=NhrBhuHx7BAxn41LcqKSesZtPvUl2WsPqRa4L4zxhbQkJLR34LN+Iz+yKcHOtxjJUI
         JMBcGsUyHL+6l8a2jFFh07j3NAmw01fzRlCdxsaDcL5uQlfvGG6haHPaoEt/LHs5vpiE
         hfivjiqbPsBiM59K7xvhGDCzEPjt4WA+xms3CsfN2UQhjbVdX04pcttcOMPTMucllx1F
         CdyQWHT8Bl0ZwW7EtuzWSAci9/5aMDFwBacImkjeHLZJDUiDfWZEfHuzX3hVHOhuBqaP
         IsKfFaaXmEjMsagKFT0Tmc83swaCeQg+M4vb/8NaSlZHfOeep6zj2f97EifRjMttScP8
         juXg==
X-Gm-Message-State: AFqh2kraKvFxJp14JmfWzcyqlyl1UKu5FGmICyM6mPWegv66j8D9f4Jr
        KSIgHE/JfcC6RfeAqjcUkkM=
X-Google-Smtp-Source: AMrXdXtXF91x3Jv1zO94b+DQVL8Z6lUf9MMScUvtXSsvjFWT31B0FWlvntw8fbkqN8gLvXr9Ln+cDw==
X-Received: by 2002:a5d:570b:0:b0:277:2e27:61e7 with SMTP id a11-20020a5d570b000000b002772e2761e7mr738568wrv.17.1673902081127;
        Mon, 16 Jan 2023 12:48:01 -0800 (PST)
Received: from localhost.localdomain (93-34-92-88.ip49.fastwebnet.it. [93.34.92.88])
        by smtp.googlemail.com with ESMTPSA id k18-20020adfb352000000b00241fab5a296sm27785372wrd.40.2023.01.16.12.48.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 12:48:00 -0800 (PST)
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
Cc:     Rob Herring <robh@kernel.org>
Subject: [PATCH v7 3/7] dt-bindings: arm: msm: Rework kpss-gcc driver Documentation to yaml
Date:   Mon, 16 Jan 2023 21:47:47 +0100
Message-Id: <20230116204751.23045-4-ansuelsmth@gmail.com>
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

Rework kpss-gcc driver Documentation to yaml Documentation and move it
to clock as it's a clock-controller.
The current kpss-gcc Documentation have major problems and can't be
converted directly. Introduce various changes to the original
Documentation.

Add #clock-cells additional binding as this clock outputs a static clk
named acpu_l2_aux with supported compatible.
Only some compatible require and outputs a clock, for the others, set
only the reg as a required binding to correctly export the kpss-gcc
registers. As the reg is shared also add the required syscon compatible.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/arm/msm/qcom,kpss-gcc.txt        | 44 ----------
 .../bindings/clock/qcom,kpss-gcc.yaml         | 88 +++++++++++++++++++
 2 files changed, 88 insertions(+), 44 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.txt
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,kpss-gcc.yaml

diff --git a/Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.txt b/Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.txt
deleted file mode 100644
index e628758950e1..000000000000
--- a/Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.txt
+++ /dev/null
@@ -1,44 +0,0 @@
-Krait Processor Sub-system (KPSS) Global Clock Controller (GCC)
-
-PROPERTIES
-
-- compatible:
-	Usage: required
-	Value type: <string>
-	Definition: should be one of the following. The generic compatible
-			"qcom,kpss-gcc" should also be included.
-			"qcom,kpss-gcc-ipq8064", "qcom,kpss-gcc"
-			"qcom,kpss-gcc-apq8064", "qcom,kpss-gcc"
-			"qcom,kpss-gcc-msm8974", "qcom,kpss-gcc"
-			"qcom,kpss-gcc-msm8960", "qcom,kpss-gcc"
-
-- reg:
-	Usage: required
-	Value type: <prop-encoded-array>
-	Definition: base address and size of the register region
-
-- clocks:
-	Usage: required
-	Value type: <prop-encoded-array>
-	Definition: reference to the pll parents.
-
-- clock-names:
-	Usage: required
-	Value type: <stringlist>
-	Definition: must be "pll8_vote", "pxo".
-
-- clock-output-names:
-	Usage: required
-	Value type: <string>
-	Definition: Name of the output clock. Typically acpu_l2_aux indicating
-		    an L2 cache auxiliary clock.
-
-Example:
-
-	l2cc: clock-controller@2011000 {
-		compatible = "qcom,kpss-gcc-ipq8064", "qcom,kpss-gcc";
-		reg = <0x2011000 0x1000>;
-		clocks = <&gcc PLL8_VOTE>, <&gcc PXO_SRC>;
-		clock-names = "pll8_vote", "pxo";
-		clock-output-names = "acpu_l2_aux";
-	};
diff --git a/Documentation/devicetree/bindings/clock/qcom,kpss-gcc.yaml b/Documentation/devicetree/bindings/clock/qcom,kpss-gcc.yaml
new file mode 100644
index 000000000000..88b7672123a0
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/qcom,kpss-gcc.yaml
@@ -0,0 +1,88 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/qcom,kpss-gcc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Krait Processor Sub-system (KPSS) Global Clock Controller (GCC)
+
+maintainers:
+  - Christian Marangi <ansuelsmth@gmail.com>
+
+description:
+  Krait Processor Sub-system (KPSS) Global Clock Controller (GCC). Used
+  to control L2 mux (in the current implementation) and provide access
+  to the kpss-gcc registers.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - qcom,kpss-gcc-ipq8064
+          - qcom,kpss-gcc-apq8064
+          - qcom,kpss-gcc-msm8974
+          - qcom,kpss-gcc-msm8960
+          - qcom,kpss-gcc-msm8660
+          - qcom,kpss-gcc-mdm9615
+      - const: qcom,kpss-gcc
+      - const: syscon
+
+  reg:
+    maxItems: 1
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
+  '#clock-cells':
+    const: 0
+
+required:
+  - compatible
+  - reg
+
+if:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - qcom,kpss-gcc-ipq8064
+          - qcom,kpss-gcc-apq8064
+          - qcom,kpss-gcc-msm8974
+          - qcom,kpss-gcc-msm8960
+then:
+  required:
+    - clocks
+    - clock-names
+    - '#clock-cells'
+else:
+  properties:
+    clock: false
+    clock-names: false
+    '#clock-cells': false
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,gcc-ipq806x.h>
+
+    clock-controller@2011000 {
+      compatible = "qcom,kpss-gcc-ipq8064", "qcom,kpss-gcc", "syscon";
+      reg = <0x2011000 0x1000>;
+      clocks = <&gcc PLL8_VOTE>, <&pxo_board>;
+      clock-names = "pll8_vote", "pxo";
+      #clock-cells = <0>;
+    };
+
+  - |
+    clock-controller@2011000 {
+      compatible = "qcom,kpss-gcc-mdm9615", "qcom,kpss-gcc", "syscon";
+      reg = <0x02011000 0x1000>;
+    };
+...
-- 
2.37.2

