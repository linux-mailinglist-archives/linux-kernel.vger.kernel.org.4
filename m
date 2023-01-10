Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06177664B25
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 19:39:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239571AbjAJSjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 13:39:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239553AbjAJShz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 13:37:55 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5725B9151C;
        Tue, 10 Jan 2023 10:33:11 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id ay40so9478091wmb.2;
        Tue, 10 Jan 2023 10:33:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SyBzt69jJkefG6UZiNhazmCV+d955MniSRj+C0Ih5Zs=;
        b=EdU9HqHJtcezz+uwRPIMIwdcX6vg1FnXr7a4oHkNbEcWPxLIpt85dDxujZUnhxIx+8
         Enpt8y+kIt7kyYf0T0mrXcTsVeGdQPapb9cdRi2pvsGDDWofnLJzW4VMGDJvUo1CLINX
         WUWUiUnzGXfMDTZQ8Ud7aPnwpFdYfDHZ/pzQHz/UWvsTbjmopxdngs93gDyGImyNDGl4
         8+j/zfd9Bx3J5YETNheOvxmtzsqCzGrlg5Q88jyC5ET9esYBouteEA+yVK9BbcJMzU+n
         Gci+GxF/menkK62afNxXCrTyKznxioVc3tntsVp9RYqD2+e1LNtJckctBtplh6TVAY8Y
         zOTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SyBzt69jJkefG6UZiNhazmCV+d955MniSRj+C0Ih5Zs=;
        b=T7fx/6UXSgTu8NWg0VeLy/EHtQhsu24M3ich+0s6nwWKhKJOcVbeiVbbsDOeHs2Fk2
         tLVM7vBLnXXrGMMzZ+5dsn+JfkDifvof3qbHuP7oWB/gk/M4aRvDVlZxteW8E8cZHOkk
         1mVzHrJN/jmg28Vpvah+c5eEEw+YVI48M6kTYE2MSBHOd/LKs4SLYJcqZHgOBWGrXjsx
         ZD1DwKvpvxEb1H5y0ylp0UtCpxflO+73O+wzYIO4vfpdj1pAGBkYsn90o7gSLx+ATZzr
         j1VAB3NJS3UniQm+8phbrxnHwp9uiyLS3hCdXmYB05nDfaj6EBaGhXfzIXQFVRb15HiM
         rckw==
X-Gm-Message-State: AFqh2krUeXSues5urHNpIi/hovQVwHku5hz6Qgwmtf/HYcP0TwEbE1k9
        yquByeYoqUKjE+4vEYeoj2I=
X-Google-Smtp-Source: AMrXdXugEOZLaI9h2VgasQkLnfhX/z2WM4YrKkVwU2YXKch0yfwy95T1y4xYskhrMkKv700KMNRG7Q==
X-Received: by 2002:a05:600c:3b87:b0:3d2:813:138a with SMTP id n7-20020a05600c3b8700b003d20813138amr53770949wms.35.1673375589697;
        Tue, 10 Jan 2023 10:33:09 -0800 (PST)
Received: from localhost.localdomain (93-34-92-88.ip49.fastwebnet.it. [93.34.92.88])
        by smtp.googlemail.com with ESMTPSA id r126-20020a1c2b84000000b003d35c845cbbsm19927757wmr.21.2023.01.10.10.33.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 10:33:09 -0800 (PST)
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
Subject: [PATCH v6 3/6] dt-bindings: arm: msm: Rework kpss-gcc driver Documentation to yaml
Date:   Tue, 10 Jan 2023 19:32:56 +0100
Message-Id: <20230110183259.19142-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230110183259.19142-1-ansuelsmth@gmail.com>
References: <20230110183259.19142-1-ansuelsmth@gmail.com>
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

